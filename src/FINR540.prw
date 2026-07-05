/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "FINR540.CH"
#Include "PROTHEUS.CH"

// 17/08/2009 - Compilacao para o campo filial de 4 posicoes
// 18/08/2009 - Compilacao para o campo filial de 4 posicoes

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR540  ³ Autor ³ Daniel Tadashi Batori ³ Data ³ 18.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao dos Cheque Cancelados                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR540(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄ-Ä-ÂÄÄÄÄÄÄÄÄ-ÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ FECHA    ³   BOPS   ³  MOTIVO DE LA ALTERACION         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄ--ÅÄÄÄÄÄÄÄÄ-ÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Dora Vega     ³02/02/2017³ MMI-4144 ³ Realizacion del merge para la    ³±±
±±³              ³          ³          ³ replica del llamado TUCCMA en    ³±±
±±³              ³          ³          ³ el fuente FINR540 de la V11.8    ³±±
±±³              ³          ³          ³ a la V12.1.14 en el cual se      ³±±
±±³              ³          ³          ³ agrega un filtro en la consulta  ³±±
±±³              ³          ³          ³ de cheques anulados, si es de ARG³±±
±±³              ³          ³          ³ filtra por EF_STATUS si no por   ³±±
±±³              ³          ³          ³ EF_IMPRESS. (ARG)                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄ-Ä-ÁÄÄÄÄÄÄÄÄÄ-ÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FinR540()
	Local oReport

	If TRepInUse()
		oReport := ReportDef()
		oReport:PrintDialog()
	Else
		Return U_FINR540R3() // Executa versão anterior do fonte
	Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Daniel Batori         ³ Data ³ 06.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do layout do Relatorio							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
	Local oReport
	Local oSection1
	Local oSection11
	Local aTam1, aTam2, aTam3, aTam4, nTam

	oReport := TReport():New("FINR540",STR0005,"FIN540",;
	{|oReport| ReportPrint(oReport)},STR0001)

	Pergunte("FIN540", .F.)

	aTam1 := TamSX3("A6_COD")
	nTam1 := aTam1[1] + Len(STR0010)
	aTam2 := TamSX3("A6_NREDUZ")
	nTam2 := aTam2[1]
	aTam3 := TamSX3("A6_AGENCIA")
	nTam3 := aTam3[1] + Len(STR0011)
	aTam4 := TamSX3("EF_CONTA")
	nTam4 := aTam4[1] + Len(STR0012)

	oSection1 := TRSection():New(oReport,STR0021,{"SEF","SA6"},{STR0006,STR0007})
	TRCell():New(oSection1,"BANCO",,,"@!",nTam1,.F.,)  //definido por SetBlock
	TRCell():New(oSection1,"NREDUZ",,,"@!",nTam2,.F.,)  //definido por SetBlock
	TRCell():New(oSection1,"AGENCIA",,,"@!",nTam3,.F.,)  //definido por SetBlock
	TRCell():New(oSection1,"CONTA",,,"@!",nTam4,.F.,)  //definido por SetBlock

	oSection1:SetHeaderSection(.F.)

	oSection11 := TRSection():New(oSection1,STR0022,{"SEF"},)
	TRCell():New(oSection11,"EF_NUM","SEF",STR0016,,,.F.,)  //"Numero"
	TRCell():New(oSection11,"EF_VALOR","SEF",STR0017,,,.F.,)  //"Valor"
	TRCell():New(oSection11,"EF_DATA","SEF",STR0018,,,.F.,)  //"Emissao"
	TRCell():New(oSection11,"EF_BENEF","SEF",STR0019,,,.F.,)  //"Beneficiario"
	TRCell():New(oSection11,"EF_HIST","SEF",STR0020,,,.F.,)  //"Historico""

	oSection11:SetHeaderPage()	//Define o cabecalho da secao como padrao

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Daniel Batori          ³ Data ³26/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport)
	Local oSection1  	:= oReport:Section(1)
	Local oSection11 	:= oReport:Section(1):Section(1)
	Local cQuery 		:= ""
	Local cAliasQry1 	:= GetNextAlias()
	Local cAliasQry2 	:= GetNextAlias()
	Local nOrdem 		:= oSection1:GetOrder()
	Local cOrdem
	Local cCpo  		:= ""
	Local cCondCanc 	:= ""

	#IFDEF TOP
		If cPaisLoc == "ARG"
			cCpo  := "% EF_STATUS %"
			cCondCanc :=  '05'
		Else
			cCpo  := "% EF_IMPRESS %"
			cCondCanc := 'C'
		EndIf
	
		oSection1:BeginQuery()

		cOrdem := SqlOrder(SEF->(IndexKey(nOrdem)))
		cQuery += " ORDER BY "+ cOrdem

		cQuery := "%" + cQuery + "%"

		BeginSql Alias cAliasQry1

		SELECT A6_COD, A6_NREDUZ, A6_AGENCIA, SEF.*
		FROM %table:SEF% SEF, %table:SA6% SA6
		WHERE A6_FILIAL = %xFilial:SA6% AND
		EF_BANCO    = A6_COD AND
		EF_AGENCIA  = A6_AGENCIA AND
		EF_CONTA    = A6_NUMCON AND
		EF_FILIAL   = %xFilial:SEF% AND
		EF_BANCO   >= %exp:mv_par01% AND
		EF_BANCO   <= %exp:mv_par02% AND
		EF_AGENCIA >= %exp:mv_par03% AND
		EF_AGENCIA <= %exp:mv_par04% AND
		EF_CONTA   >= %exp:mv_par05% AND
		EF_CONTA   <= %exp:mv_par06% AND
		EF_NUM     >= %exp:mv_par07% AND
		EF_NUM     <= %exp:mv_par08% AND
		EF_DATA    >= %exp:mv_par09% AND
		EF_DATA    <= %exp:mv_par10% AND
		%exp:cCpo% = %exp:cCondCanc% AND
		SEF.%NotDel%
		%exp:cQuery%

		EndSQL
		oSection1:EndQuery()
	
		cAliasQry2 := cAliasQry1
	
		oSection11:SetParentQuery()

	#ELSE
		cAliasQry1 := "SEF"
		cAliasQry2 := "SA6"
	
		cQuery := "EF_FILIAL  == '"+xFilial("SEF") + "' .And. "
		cQuery += "EF_BANCO   >= '" + mv_par01 + "' .And. "
		cQuery += "EF_BANCO   <= '" + mv_par02 + "' .And. "
		cQuery += "EF_AGENCIA >= '" + mv_par03 + "' .And. "
		cQuery += "EF_AGENCIA <= '" + mv_par04 + "' .And. "
		cQuery += "EF_CONTA   >= '" + mv_par05 + "' .And. "
		cQuery += "EF_CONTA   <= '" + mv_par06 + "' .And. "
		cQuery += "EF_NUM     >= '" + mv_par07 + "' .And. "
		cQuery += "EF_NUM     <= '" + mv_par08 + "' .And. "
		cQuery += "DTOS(EF_DATA) >= '" + DTOS(mv_par09) + "' .And. "
		cQuery += "DTOS(EF_DATA) <= '" + DTOS(mv_par10) + "' .And. "
		If cPaisLoc == "ARG"
			cQuery += "EF_STATUS == '05' "
		Else
			cQuery += "EF_IMPRESS == 'C' "
		EndIf

		oSection1:SetFilter(cQuery,(cAliasQry1)->(IndexKey(nOrdem)))
	
		TRPosition():New(oSection1,cAliasQry2, 1, {|| xFilial("SA6")+(cAliasQry1)->(EF_BANCO+EF_AGENCIA+EF_CONTA) }, .T. )

	#ENDIF

	oSection11:SetParentFilter({|cParam| (cAliasQry1)->(EF_BANCO+EF_AGENCIA+EF_CONTA) == cParam},{|| (cAliasQry1)->(EF_BANCO+EF_AGENCIA+EF_CONTA) })

	oSection11:SetTotalText(SubStr(STR0013,1,9))  //"Sub-Total"
	oSection11:SetTotalInLine(.F.)

	oReport:SetTotalText(STR0023)		//"Totais"

	TRFunction():New(oSection11:Cell("EF_VALOR"),"T_VAL","SUM",,STR0014,,,.T.,.T.)
	TRFunction():New(oSection11:Cell("EF_VALOR"),"CONTADOR","COUNT",,STR0015,,,.F.,.T.)

	oSection1:Cell("BANCO"):SetBlock(	{|| STR0010 + (cAliasQry2)->A6_COD } ) 				//"Banco : "
	oSection1:Cell("NREDUZ"):SetBlock(	{|| " - " + AllTrim((cAliasQry2)->A6_NREDUZ) } )
	oSection1:Cell("AGENCIA"):SetBlock(	{|| STR0011 + (cAliasQry2)->A6_AGENCIA } )        //" -  Agencia : "
	oSection1:Cell("CONTA"):SetBlock(	{|| STR0012 + (cAliasQry1)->EF_CONTA } )          //" Conta : "

	oSection11:Cell("EF_NUM"):SetBlock(		{|| (cAliasQry1)->EF_NUM } )
	oSection11:Cell("EF_VALOR"):SetBlock(	{|| (cAliasQry1)->EF_VALOR } )
	oSection11:Cell("EF_DATA"):SetBlock(	{|| (cAliasQry1)->EF_DATA } )
	oSection11:Cell("EF_BENEF"):SetBlock(	{|| (cAliasQry1)->EF_BENEF } )
	oSection11:Cell("EF_HIST"):SetBlock(	{|| (cAliasQry1)->EF_HIST } )

	oSection1:Print()

Return









/*
---------------------------------------------------------- RELEASE 3 ---------------------------------------------
*/











/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR540R3³ Autor ³ Wagner Xavier            ³ Data ³ 06.01.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao dos Cheque Cancelados                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FINR540R3(void)                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ DATA   ³ BOPS ³Prograd.  ³ALTERACAO                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³08.10.98³XXXXXX³Andreia   ³Alteracao no lay-out para ativar set century   ³±±
±±³30.03.99³META  ³Julio     ³Revisao dos Parametros de Tamanho  do Rel.     ³±±
±±³03.02.03³XXXXXX³Eduardo Ju³Criacao de Queries para filtros em TOP.        ³±±
±±ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function FinR540R3()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define Variaveis                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local cDesc1 	:= STR0001  //"Este relatorio ira imprimir a rela‡„o de cheques cancelados."
	Local cDesc2 	:=""
	Local cDesc3 	:=""
	Local wnrel
	Local cString 	:="SEF"
	Local titulo	:= STR0002  // "Rela‡„o de Cheques Cancelados.",
	Local aOrd
	Local Tamanho	:="M"

	Private aReturn 	:= { OemToAnsi(STR0003), 1,OemToAnsi(STR0004), 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
	Private nomeprog	:="FINR540"
	Private nLastKey	:= 0
	Private cPerg   	:="FIN540"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Definicao dos cabecalhos                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	titulo := STR0005  //"Rela‡„o de Cheques Cancelados."

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	pergunte("FIN540",.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                         ³
	//³ mv_par01            // Do Banco                              ³
	//³ mv_par02            // Ate o Banco                           ³
	//³ mv_par03            // Da Agencia                            ³
	//³ mv_par04            // Ate a Agencia                         ³
	//³ mv_par05            // Da Conta                              ³
	//³ mv_par06            // Ate a Conta                           ³
	//³ mv_par07            // Do Cheque                             ³
	//³ mv_par08            // Ate o Cheque                          ³
	//³ mv_par09            // Da Emissao                            ³
	//³ mv_par10            // Ate a Emissao                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Envia controle para a funcao SETPRINT                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	wnrel:="FINR540"            //Nome Default do relatorio em Disco
	aOrd :={OemToAnsi(STR0006) , OemToAnsi(STR0007) }  //"Por Cheque"###"Por Emissao"
	wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

	If nLastKey = 27
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Return
	Endif

	RptStatus({|lEnd| Fa540Imp(@lEnd,wnRel,cString,titulo)},titulo)
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FA540Imp ³ Autor ³ Wagner Xavier         ³ Data ³ 06.01.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao dos Cheque Cancelados                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FA540Imp(lEnd,wnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd    - A‡ao do Codeblock                                ³±±
±±³          ³ wnRel   - T¡tulo do relat¢rio                              ³±±
±±³          ³ cString - Mensagem                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FA540Imp(lEnd,wnRel,cString,titulo)
	Local CbCont,CbTxt
	Local tamanho  :="M"
	Local limite   := 132
	Local nOrdem
	Local nTotch   :=0,nTotVal:=0,nTotchg:=0,nTotValg:=0,nFirst:=0
	Local lContinua:= .T.
	Local cCond1,cCond2,cCarAnt
	Local nTipo    :=  IIf(aReturn[4]==1,15,18)
	Local cabec1   := OemToAnsi(STR0008)  //"Numero                   Valor Emissao  Beneficiario                    Historico"
	Local cabec2   := " "
	
	#IFDEF TOP
		Local aStru    := SEF->(dbStruct()), ni
	#ENDIF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cbtxt    := SPACE(10)
	cbcont   := 0
	li       := 80
	m_pag    := 1

	dbSelectArea("SEF")
	nOrdem := aReturn[8]

	SetRegua(RecCount())

	#IFDEF TOP
		If TcSrvType() != "AS/400"
	
			cOrder := SqlOrder(SEF->(IndexKey(nOrdem)))
			cQuery := "SELECT * "
			cQuery += "  FROM "+	RetSqlName("SEF")
			cQuery += " WHERE EF_FILIAL = '" + xFilial("SEF") + "' AND "
			cQuery += "EF_BANCO   >= '" + mv_par01 + "' AND EF_BANCO   <= '"  + mv_par02 + "' AND "
			cQuery += "EF_AGENCIA >= '" + mv_par03 + "' AND EF_AGENCIA <= '"  + mv_par04 + "' AND "
			cQuery += "EF_CONTA   >= '" + mv_par05 + "' AND EF_CONTA   <= '"  + mv_par06 + "' AND "
			cQuery += "EF_NUM     >= '" + mv_par07 + "' AND EF_NUM     <= '"  + mv_par08 + "' AND "
			cQuery += "EF_DATA    >= '" + Dtos(mv_par09) + "' AND EF_DATA    <= '"  + Dtos(mv_par10) + "' AND "
			If cPaisLoc == "ARG"
				cQuery += "EF_STATUS = '05' AND "
			Else
				cQuery += "EF_IMPRESS = 'C' AND "
			EndIf
			cQuery += "D_E_L_E_T_ = ' ' "
	
			cQuery += " ORDER BY "+ cOrder
			cQuery := ChangeQuery(cQuery)
	
			dbSelectArea("SEF")
			dbCloseArea()
			dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SEF', .F., .T.)
	
			For ni := 1 to Len(aStru)
				If aStru[ni,2] != 'C'
					TCSetField('SEF', aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
				Endif
			Next
	
			If (SEF->(EOF()))
				dbSelectArea("SEF")
				dbCloseArea()
				ChkFile("SEF")
				dbSelectArea("SEF")
				dbSetOrder(1)
				Return
			EndIf
		Else

	#ENDIF

		If nOrdem = 1
			dbSetOrder(1)
			dbSeek(cFilial+mv_par01+mv_par03+mv_par05+mv_par07,.T.)
		Else
			dbSetOrder(2)
			dbSeek(cFilial+mv_par01+mv_par03+mv_par05+Dtos(mv_par09),.T.)
		EndIf

	#IFDEF TOP
		Endif
	#ENDIF

	If nOrdem = 1
		cCond1 := "EF_BANCO+EF_AGENCIA+EF_CONTA+EF_NUM <= mv_par02+mv_par04+mv_par06+mv_par08"
		cCond2 := "EF_BANCO+EF_AGENCIA+EF_CONTA"
	Else
		cCond1 := "EF_BANCO+EF_AGENCIA+EF_CONTA+DTOS(EF_DATA) <= mv_par02+mv_par04+mv_par06+DTOS(mv_par10)"
		cCond2 := "EF_BANCO+EF_AGENCIA+EF_CONTA"
	EndIf

	While &cCond1 .And. !Eof() .And. lContinua .and. EF_FILIAL == cFilial

		If lEnd
			@Prow()+1,001 PSAY OemToAnsi(STR0009) //"Cancelado pelo Operador"
			Exit
		End

		IncRegua()

		If cPaisLoc == "ARG"
			If EF_STATUS != "05"
				dbSkip()
				Loop
			End
		Else    
			If EF_IMPRESS != "C"
				dbSkip()
				Loop
			End
		EndIf

		nTotVal := nTotCh := nFirst := 0
		cCarAnt := &cCond2

		While &cCond2 == cCarAnt .And. !Eof()

			If lEnd
				@Prow()+1,001 PSAY OemToAnsi(STR0009) //"Cancelado pelo Operador"
				lContinua := .F.
				Exit
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se esta dentro dos parametros                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If EF_BANCO   < mv_par01 .OR. EF_BANCO   > mv_par02 .OR. ;
			EF_AGENCIA < mv_par03 .OR. EF_AGENCIA > mv_par04 .OR. ;
			EF_CONTA   < mv_par05 .OR. EF_CONTA   > mv_par06 .OR. ;
			EF_NUM     < mv_par07 .OR. EF_NUM     > mv_par08 .OR. ;
			EF_DATA    < mv_par09 .OR. EF_DATA    > mv_par10
				dbSkip()
				Loop
			End

			If cPaisLoc == "ARG"
				If EF_STATUS != "05"
					dbSkip()
					Loop
				End
			Else    
				If EF_IMPRESS != "C"
					dbSkip()
					Loop
				End
			EndIf

			If li > 58
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				nFirst:=0
			End

			If nFirst = 0
				dbSelectArea("SA6")
				dbSeek(xFilial("SA6")+SEF->EF_BANCO+SEF->EF_AGENCIA+SEF->EF_CONTA)
				@li, 0 PSAY OemToAnsi(STR0010)+A6_COD+" - "+AllTrim(A6_NREDUZ)+OemToAnsi(STR0011)+A6_AGENCIA+STR0012+SEF->EF_CONTA  //"Banco : "###" -  Agencia : "###" Conta : "
				li+=2
				nFirst++
			End

			dbSelectArea("SEF")
			@li ,   0 PSAY EF_NUM
			@li ,  16 PSAY EF_VALOR     Picture TM(EF_VALOR,14)
			@li ,  31 PSAY EF_DATA
			@li ,  42 PSAY Substr(SEF->EF_BENEF,1,40)
			@li ,  85 PSAY Substr(EF_HIST,1,40)
			nTotCh++
			nTotVal += EF_VALOR
			dbSkip()
			li++

		EndDO

		If nTotVal > 0
			SubTot540(nTotVal,limite)
		End
		nTotChg  += nTotCh
		nTotValg += nTotVal
	End

	If nTotValg > 0
		TotGer540(nTotChg,nTotValg)
	End

	If li != 80
		roda(cbcont,cbtxt,Tamanho)
	End

	Set Device To Screen
	dbSelectArea("SEF")

	#IFDEF TOP
		If TcSrvType() != "AS/400"
			dbCloseArea()
			ChkFile("SEF")
			dbSelectArea("SEF")
		Endif
	#ENDIF
	dbSetOrder(1)
	Set Filter To

	If aReturn[5] = 1
		Set Printer To
		dbCommit()
		ourspool(wnrel)
	End
	MS_FLUSH()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³SubTot540 ³ Autor ³ Wagner Xavier         ³ Data ³ 06.01.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do SubTotal do Banco                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ SubTot540(ExpN1)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1  - Valor Total                                       ³±±
±±³          ³ ExpN2  - Tamanho da linha                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function SubTot540(nTotVal,limite)
	li++
	@li, 0 PSAY OemToAnsi(STR0013)  //"Sub-Total ----> "
	@li,16 PSAY nTotVal            Picture TM(nTotVaL,14)
	li++
	@ li,00 pSay __PrtThinLine()
	li++
Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ TotGer540³ Autor ³ Wagner Xavier         ³ Data ³ 06.01.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do Total Do Relatorio                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ TotGer540(ExpN1,ExpN2)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Total de cheques,Valor Total                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TotGer540(nTotChg,nTotValg)
	li++
	@li  ,  0 PSAY OemToAnsi(STR0014)  //"Total Geral --> "
	@li  , 16 PSAY nTotValg              Picture tm(nTotValg,14)
	li++
	@li  ,  0 PSAY OemToAnsi(STR0015)+Alltrim(str(nTotChg))  //"Total Cheques-> "
	li++
Return .T.
