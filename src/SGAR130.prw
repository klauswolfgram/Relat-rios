/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "SGAR130.ch"
#Include "Protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ SGAR130  ³ Autor ³ Rafael Diogo Richter  ³ Data ³09/07/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio de Historico de Eventos ocorridos na Est. Org.    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGASGA                                                    ³±±
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
User Function SGAR130()
//----------------------------------------------------
// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
//----------------------------------------------------
Local aNGBEGINPRM := NGBEGINPRM( )
Local oReport
Local aArea       := GetArea()
Private cPerg     := PadR( "SGR130" , 10 )
Private aPerg     :={}
Private lModulos  := NGCADICBASE("TCJ_MODSGA","D","TCJ",.F.)

If FindFunction("TRepInUse") .And. TRepInUse()
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:SetPortrait()
	oReport:PrintDialog()
Else
	U_SGAR130R3()
EndIf
RestArea(aArea)
//------------------------------------------------
// Devolve variaveis armazenadas (NGRIGHTCLICK)
//------------------------------------------------
NGRETURNPRM(aNGBEGINPRM)

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportDef ³ Autor ³ Rafael Diogo Richter  ³ Data ³09/07/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Define as sessoes impressas no relatorio.                   ³±±
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
Static Function ReportDef()
Local oReport
Local oSection1
Local oSection2
Local oCell
Local oCell2
Private lNovo := .T., cEvento := "", dData := CTOD("  /  /  "), cHora

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
oReport := TReport():New("SGAR130",OemToAnsi(STR0005),"SGR130",{|oReport| ReportPrint(oReport)},STR0006+" "+STR0007+" "+STR0008) //"Histórico de Eventos da Estrutura Organizacional"###"Relatório de Histórico dos eventos ocorridos na Estrutura Organizacional"###"O usuario podera utilizar a opcao Parametros para a obtencao "###"dos Itens da Estrutura Organizacional de seu interesse."

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
oSection1 := TRSection():New(oReport,STR0009,{"TCJ"}) //"Item: "
oCell := TRCell():New(oSection1,"TCJ_CODNIV"	,"TCJ",STR0010 ,"@!" ,06,/*lPixel*/,/*{|| code-block de impressao }*/) //"Item"
oCell := TRCell():New(oSection1,"TCJ_DESNIV"	,"TCJ",STR0011	,"@!" ,40,/*lPixel*/,/*{|| code-block de impressao }*/) //"Descrição"

oSection2 := TRSection():New(oReport,STR0012,{"TCJ","TAF"}) //"Ordem"
oCell2 := TRCell():New(oSection2,"TCJ_NIVSUP"	,"TCJ"	,STR0046		,"@!" 			,15,/*lPixel*/,/*{|| code-block de impressao }*/) //"Niv. Sup." //"Processo Pai"
oCell2 := TRCell():New(oSection2,"TAF_NOMNIV"	,"TAF"	,STR0011		,"@!" 			,40,/*lPixel*/,/*{|| code-block de impressao }*/) //"Descrição"
oCell2 := TRCell():New(oSection2,"DATA"		,		,STR0014		,"99/99/9999"	,12,/*lPixel*/,{|| dData }) //"Data"
oCell2 := TRCell():New(oSection2,"HORA"		,		,STR0015		,"99:99"		,08,/*lPixel*/,{|| cHora }) //"Hora"
oCell2 := TRCell():New(oSection2,"EVENTO"		, 		,STR0016		,"@!" 			,40,/*lPixel*/,{|| cEvento}) //"Tipo Evento"
If lModulos
	oCell2 := TRCell():New(oSection2,"NIVEL"	, 		,STR0033		,"999" 			,05,/*lPixel*/,{|| nNivel}) //"Nivel"
	oCell2 := TRCell():New(oSection2,"MODSGA"	, 		,STR0034	,"@!" 			,15,/*lPixel*/,{|| cModSGA}) //"Util. SGA"
	oCell2 := TRCell():New(oSection2,"MODMDT"	, 		,STR0035	,"@!" 			,15,/*lPixel*/,{|| cModMDT}) //"Util. MDT"
	oCell2 := TRCell():New(oSection2,"MODMNT"	, 		,STR0036	,"@!" 			,15,/*lPixel*/,{|| cModMNT}) //"Util. MNT"
Endif
oCell2 := TRPosition():New(oSection2,"TAF",2,{|| xFilial("TAF")+"001"+TCJ->TCJ_NIVSUP})

Return oReport


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportPrint³ Autor ³ Rafael Diogo Richter  ³ Data ³03/08/2006³±±
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
Local oSection2 := oReport:Section(2)
Local cCodNiv  := ""
Local lFirst
Local aAreaOri, aAreaWhl
//Ordena parametros De/Ate Localização
If MV_PAR01 > MV_PAR02
	cTempPar  := MV_PAR01
	MV_PAR01 := MV_PAR02
	MV_PAR02 := cTempPar
EndIf

If mv_par05 <> 4
	aNiveis := {}
	#IFDEF TOP
		cAliasQry := GetNextAlias()
		cQuery := "SELECT TAF.TAF_CODNIV FROM "+ RetSqlName("TAF") + " TAF "
		cQuery += "WHERE TAF.TAF_FILIAL = '"+xFilial("TAF")+"' AND "
		If mv_par05 == 1
			cQuery += " TAF.TAF_MODSGA <> ''"
		ElseIf mv_par05 == 2
			cQuery += " TAF.TAF_MODMDT <> ''"
		Else
			cQuery += " TAF.TAF_MODMNT <> ''"
		Endif
		cQuery := ChangeQuery(cQuery)
		MPSysOpenQuery( cQuery , cAliasQry )
		cModulo := "N"
		dbSelectArea(cAliasQry)
		dbGoTop()
		While !eof()
			If aScan(aNiveis, {|x| Trim(Upper(x[1])) == (cAliasQry)->TAF_CODNIV}) == 0
				aADD(aNiveis, {(cAliasQry)->TAF_CODNIV})
			Endif
			dbSelectArea(cAliasQry)
			dbSkip()
		End
		(cAliasQry)->(dbCloseArea())
	#ENDIF
Endif

DbSelectArea("TCJ")
DbSetOrder(03)
DbSeek(xFilial('TCJ')+Mv_Par01,.T.)
oReport:SetMeter(RecCount())
lFirst := .T.
While !Eof() .And. TCJ->TCJ_FILIAL == xFilial("TCJ") .And. TCJ->TCJ_CODNIV <= Mv_Par02 .And. !oReport:Cancel()

	oReport:IncMeter()
	If TCJ->TCJ_DATA < Mv_Par03 .OR. TCJ->TCJ_DATA > Mv_Par04
		dbSelectArea("TCJ")
		dbSkip()
		Loop
	Endif
	If mv_par05 <> 4
		#IFDEF TOP
			If aScan(aNiveis, {|x| Trim(Upper(x[1])) == TCJ->TCJ_CODNIV}) == 0
				dbSelectArea("TCJ")
				dbSkip()
				Loop
			Endif
		#ELSE
			dbSelectArea("TAF")
			dbSetOrder(1)
			If dbSeek(xFilial("TAF")+TCJ->TCJ_CODNIV)
				If mv_par05 == 1 .and. TAF->TAF_MODSGA <> "X"
					dbSelectArea("TCJ")
					dbSkip()
					Loop
				ElseIf mv_par05 == 2 .and. TAF->TAF_MODMDT <> "X"
					dbSelectArea("TCJ")
					dbSkip()
					Loop
				ElseIf mv_par05 == 3 .and. TAF->TAF_MODMNT <> "X"
					dbSelectArea("TCJ")
					dbSkip()
					Loop
				Endif
			Else
				dbSelectArea("TCJ")
				dbSkip()
				Loop
			Endif
		#ENDIF
	Endif

	cCodNiv := TCJ->TCJ_CODNIV
	aAreaOri:= TCJ->( GetArea() )
	lNovo := .T.

	If lFirst
		oSection1:Init()
		oSection1:PrintLine()
		lFirst := .F.
	Else
		oSection1:Finish()
		oSection1:Init()
		oReport:SkipLine()
		oReport:SkipLine()
		oSection1:PrintLine()
	EndIf

	Do While !Eof() .And. TCJ->TCJ_FILIAL == xFilial("TCJ") .And. TCJ->TCJ_CODNIV = cCodNiv .And. lNovo

		cEvento := U_SGR130Ev()

		If TCJ->TCJ_DATA < Mv_Par03 .OR. TCJ->TCJ_DATA > Mv_Par04
			dbSelectArea("TCJ")
			dbSkip()
			Loop
		Endif
		If TCJ->TCJ_NIVSUP == "000"
			dbSelectArea("TCJ")
			dbSkip()
			Loop
		Endif
		dData := TCJ->TCJ_DATA
		cHora := TCJ->TCJ_HORA
        If lModulos
        	nNivel := TCJ->TCJ_NIVEL
			If TCJ->TCJ_MODSGA == "X"
				cModSGA := STR0037 //"Sim"
			Else
				cModSGA := STR0038 //"Não"
			Endif
			If TCJ->TCJ_MODMDT == "X"
				cModMDT := STR0037 //"Sim"
			Else
				cModMDT := STR0038 //"Nao"
			Endif
			If TCJ->TCJ_MODMNT == "X"
				cModMNT := STR0037 //"Sim"
			Else
				cModMNT := STR0038 //"Não"
			Endif
        Endif
		oSection2:Init()
		oSection2:PrintLine()

		dbSelectArea("TCJ")
		dbSetOrder(03)
		dbSkip()
	EndDo

	aAreaWhl := TCJ->( GetArea() )

	RestArea( aAreaOri )

	dbSelectArea("TAF")
	dbSetOrder(2)
	If dbSeek(xFilial("TAF")+"001"+cCodNiv) .And. lNovo
		dData := dDatabase
		cHora := Time()
		cEvento := STR0028 //"Situação Atual do Item"
        If lModulos
	        dbSelectArea("TAF")
			dbSetOrder(2)
			If dbSeek(xFilial("TAF")+"001"+cCodNiv)
	        	nNivel := TAF->TAF_NIVEL
				If TAF->TAF_MODSGA == "X"
					cModSGA := STR0037 //"Sim"
				Else
					cModSGA := STR0038 //"Não"
				Endif
				If TAF->TAF_MODMDT == "X"
					cModMDT := STR0037 //"Sim"
				Else
					cModMDT := STR0038 //"Nao"
				Endif
				If TAF->TAF_MODMNT == "X"
					cModMNT := STR0037 //"Sim"
				Else
					cModMNT := STR0038 //"Não"
				Endif
			Endif
        Endif
		oSection2:Init()
		oSection2:PrintLine()
	EndIf

	RestArea( aAreaWhl )
	dbSelectArea("TCJ")
	dbSetOrder(3)
	oSection2:Finish()
End

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³SGAR130R3 ³ Autor ³ Rafael Diogo Richter  ³ Data ³09/07/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio de Historico de Eventos ocorridos na Est. Org.    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Tabelas   ³TCJ - Historico de Mov. Na Estrutura Organizacional         ³±±
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
User Function SGAR130R3()
Local cString    := "TCJ"
Local cDesc1     := STR0006 //"Relatório de Histórico dos eventos ocorridos na Estrutura Organizacional"
Local cDesc2     := STR0007 //"O usuario podera utilizar a opcao Parametros para a obtencao "
Local cDesc3     := STR0008 //"dos Itens da Estrutura Organizacional de seu interesse."
Local wnRel      := "SGAR130"

Private aReturn  := { STR0017, 1,STR0018, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
Private nLastKey := 0
Private Titulo   := STR0005 //"Histórico de Eventos da Estrutura Organizacional"
Private Tamanho  := If(lModulos,"G","M")

DbSelectArea("TCJ")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros      ³
//³ mv_par01     // De  Aspecto               ³
//³ mv_par02     // Ate Aspecto               ³
//³ mv_par03     // De Data                   ³
//³ mv_par04     // Ate Data                  ³
//³ mv_par05     // De Criticidade            ³
//³ mv_par06     // Ate Criticidade           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnRel := SetPrint(cString,wnRel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.f.,"")

If nLastKey = 27
   Set Filter To
   DbSelectArea("TCJ")
   Return
Endif

SetDefault(aReturn,cString)

Processa({|lEnd| R130Imp(@lEnd,wnRel,Titulo,Tamanho)})

DbSelectArea("TCJ")

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R130IMP  ³ Autor ³ Rafael Diogo Richter  ³ Data ³09/07/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Chamada do Relatorio.                                       ³±±
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
Static Function R130Imp(lEnd,wnRel,Titulo,Tamanho)
Local cRodaTxt := ""
Local nCntImpr := 0
Local lNovo := .T.
Local cNivSup
Local cEvento := ""
Private li := 80 ,m_pag := 1
Private NomeProg := "SGAR130"
Private Cabec1   := STR0019 //"             Nivel Superior                                  Data         Hora   Tipo Evento"
Private Cabec2   := " "
Private Inclui   := .t.
If lModulos
	Cabec1 += STR0040 //"                               Nivel      Util. SGA   Util. MDT   Util. MNT"
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIf(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8
//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//             Nivel Superior                                  Data         Hora   Tipo Evento                               Nivel      Util. SGA   Util. MDT   Util. MNT
//
//Item:  XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
//             XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/9999   99:99  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    999		Sim         Não         Não
//             XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/9999   99:99  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    999		Sim         Não         Não
//             XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/9999   99:99  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    999		Sim         Não         Não

//Item:  XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
//             XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/9999   99:99  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    999		Sim         Não         Não
//             XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/9999   99:99  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    999		Sim         Não         Não
//             XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/9999   99:99  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    999		Sim         Não         Não


//Ordena parametros De/Ate Localização
If MV_PAR01 > MV_PAR02
	cTempPar  := MV_PAR01
	MV_PAR01 := MV_PAR02
	MV_PAR02 := cTempPar
EndIf

If mv_par05 <> 4
	//Verifica as localizações do modulo
	#IFDEF TOP
		aNiveis := {}
		cAliasQry := GetNextAlias()
		cQuery := "SELECT TAF.TAF_CODNIV FROM "+ RetSqlName("TAF") + " TAF "
		cQuery += "WHERE TAF.TAF_FILIAL = '"+xFilial("TAF")+"' AND "
		If mv_par05 == 1
			cQuery += " TAF.TAF_MODSGA <> ''"
		ElseIf mv_par05 == 2
			cQuery += " TAF.TAF_MODMDT <> ''"
		Else
			cQuery += " TAF.TAF_MODMNT <> ''"
		Endif
		cQuery := ChangeQuery(cQuery)
		MPSysOpenQuery( cQuery , cAliasQry )
		cModulo := "N"
		dbSelectArea(cAliasQry)
		dbGoTop()
		While !eof()
			If aScan(aNiveis, {|x| Trim(Upper(x[1])) == (cAliasQry)->TAF_CODNIV}) == 0
				aADD(aNiveis, {(cAliasQry)->TAF_CODNIV})
			Endif
			dbSelectArea(cAliasQry)
			dbSkip()
		End
		(cAliasQry)->(dbCloseArea())
	#ENDIF
Endif
DbSelectArea("TCJ")
DbSetOrder(03)
DbSeek(xFilial('TCJ')+Mv_Par01,.T.)
ProcRegua(RecCount())
While !Eof() .And. TCJ->TCJ_FILIAL == xFilial("TCJ") .And. TCJ->TCJ_CODNIV <= Mv_Par02

	If lEnd
		@ Prow()+1,001 PSay STR0020 //"CANCELADO PELO OPERADOR"
		Exit
	EndIf
	If TCJ->TCJ_DATA < Mv_Par03 .OR. TCJ->TCJ_DATA > Mv_Par04
		dbSelectArea("TCJ")
		dbSkip()
		Loop
	Endif
	If TCJ->TCJ_NIVSUP == "000"
		dbSelectArea("TCJ")
		dbSkip()
		Loop
	Endif
	IncProc()
	If mv_par05 <> 4
		#IFDEF TOP
			//Checa se o CODNIV é do módulo
			If aScan(aNiveis, {|x| Trim(Upper(x[1])) == TCJ->TCJ_CODNIV}) == 0
				dbSelectArea("TCJ")
				dbSkip()
				Loop
			Endif
		#ELSE
			//Se não for TOP filtra apenas os não deletados
			dbSelectArea("TAF")
			dbSetOrder(1)
			If dbSeek(xFilial("TAF")+TCJ->TCJ_CODNIV)
				If mv_par05 == 1 .and. TAF->TAF_MODSGA <> "X"
					dbSelectArea("TCJ")
					dbSkip()
					Loop
				ElseIf mv_par05 == 2 .and. TAF->TAF_MODMDT <> "X"
					dbSelectArea("TCJ")
					dbSkip()
					Loop
				ElseIf mv_par05 == 3 .and. TAF->TAF_MODMNT <> "X"
					dbSelectArea("TCJ")
					dbSkip()
					Loop
				Endif
			Else
				dbSelectArea("TCJ")
				dbSkip()
				Loop
			Endif
		#ENDIF
	Endif

	NgSomaLi(58)

	cCodNiv := TCJ->TCJ_CODNIV
	lNovo := .T.

	@ Li,000 PSay STR0009 + TCJ->TCJ_CODNIV + " - " + TCJ->TCJ_DESNIV //"Item: "

	Do While !Eof() .And. TCJ->TCJ_FILIAL == xFilial("TCJ") .And. TCJ->TCJ_CODNIV = cCodNiv .And. lNovo

		cEvento := U_SGR130Ev()
		If TCJ->TCJ_DATA < Mv_Par03 .OR. TCJ->TCJ_DATA > Mv_Par04
			dbSelectArea("TCJ")
			dbSkip()
			Loop
		Endif

		NgSomaLi(58)
		cDNivSup := ""
		cNivSup := TCJ->TCJ_NIVSUP
		aAreaTCJ := TCJ->(GetArea())
		dbSelectArea("TCJ")
		dbSetOrder(1)
		If dbSeek(xFilial("TCJ")+cNivSup)
			cDNivSup := SubStr(TCJ->TCJ_DESNIV,1,40)
		Else
			dbSelectArea("TAF")
			dbSetOrder(2)
			dbSeek(xFilial("TAF")+"001"+cNivSup)
			cDNivSup := SubStr(TAF->TAF_NOMNIV,1,40)
		EndIf
		RestArea(aAreaTCJ)

		If TCJ->TCJ_NIVSUP == "000"
			cDNivSup := STR0021 //"*** Primeiro Nível ***"
		EndIf

		@ Li,013 Psay TCJ->TCJ_NIVSUP + " - " + cDNivSup
		@ Li,061 PSay TCJ->TCJ_DATA
		@ Li,074 PSay TCJ->TCJ_HORA
		@ Li,081 PSay cEvento
		If lModulos
			@ Li,125 Psay TCJ->TCJ_NIVEL Picture "999"
			If TCJ->TCJ_MODSGA == "X"
				@ Li,134 pSay STR0037 //"Sim"
			Else
				@ Li,134 pSay STR0038 //"Não"
			Endif
			If TCJ->TCJ_MODMDT == "X"
				@ Li,146 pSay STR0037 //"Sim"
			Else
				@ Li,146 pSay STR0038 //"Nao"
			Endif
			If TCJ->TCJ_MODMNT == "X"
				@ Li,158 pSay STR0037 //"Sim"
			Else
				@ Li,158 Psay STR0038 //"Não"
			Endif
		Endif
		dbSelectArea("TCJ")
		dbSetOrder(03)
		dbSkip()
	EndDo

	dbSelectArea("TAF")
	dbSetOrder(2)
	If dbSeek(xFilial("TAF")+"001"+cCodNiv) .And. lNovo
		aAreaTAF := GetArea("TAF")
		If dbSeek(xFilial("TAF")+"001"+TAF->TAF_NIVSUP)
			NgSomaLi(58)
			@ Li,013 Psay TAF->TAF_CODNIV + " - " + SubStr(TAF->TAF_NOMNIV,1,40)
			RestArea(aAreaTAF)
			@ Li,061 PSay dDataBase
			@ Li,074 PSay Time() Picture "99:99"
			@ Li,081 PSay STR0028 //"Situação Atual do Item"
			If lModulos
				dbSelectArea("TAF")
				dbSetOrder(2)
				If dbSeek(xFilial("TAF")+"001"+cCodNiv)
					@ Li,125 Psay TAF->TAF_NIVEL Picture "999"
					If TAF->TAF_MODSGA == "X"
						@ Li,134 pSay STR0037 //"Sim"
					Else
						@ Li,134 pSay STR0038 //"Não"
					Endif
					If TAF->TAF_MODMDT == "X"
						@ Li,146 pSay STR0037 //"Sim"
					Else
						@ Li,146 pSay STR0038 //"Nao"
					Endif
					If TAF->TAF_MODMNT == "X"
						@ Li,158 pSay STR0037 //"Sim"
					Else
						@ Li,158 Psay STR0038 //"Não"
					Endif
				ENdif
			Endif
		EndIf
	EndIf
	dbSelectArea("TCJ")
	dbSetOrder(3)
	NgSomaLi(58)
End

Roda(nCntImpr,cRodaTxt,Tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("TCJ")
RetIndex("TAF")

Set Filter To

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ SGR130Ev ³ Autor ³ Rafael Diogo Richter  ³ Data ³11/07/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna a descricao do evento                               ³±±
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
User Function SGR130Ev()
Local cEvento

If TCJ->TCJ_TIPROC == "O"
	cEvento := STR0022 //"Efetuado Alteração da Ordem"
ElseIf TCJ->TCJ_TIPROC == "E"
	cEvento := STR0023 //"Efetuado Exclusão do Item"
	lNovo := .F.
ElseIf TCJ->TCJ_TIPROC == "N"
	cEvento := STR0024 //"Efetuado Inclusão do Item"
ElseIf TCJ->TCJ_TIPROC == "A"
	cEvento := STR0025 //"Efetuado Alteração do Bem para Ativo"
ElseIf TCJ->TCJ_TIPROC == "I"
	cEvento := STR0026 //"Efetuado Alteração do Bem para Inativo"
ElseIf TCJ->TCJ_TIPROC == "T"
	cEvento := STR0027 //"Efetuada Transferência de Filial do Bem"
ElseIf TCJ->TCJ_TIPROC == "M"
	cEvento := STR0039 //"Efetuado Alteração dos Módulos"
EndIf

Return cEvento