/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR987.ch"
#INCLUDE "Protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Matr987   ³ Autor ³ Luciana Pires         ³ Data ³04/03/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³Relatorio para totalizar os creditos dos movimentos de saida³±±
±±³			 ³de produtos incentivados pelo PRODEPE				          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function Matr987()

Local oReport
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao das variaveis                                      |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cCadastro 	:= STR0001 //"Resumo de Créditos de Movimentos de Produtos Incentivados - PRODEPE"
Local aSays			:= {}
Local aButtons		:= {}
Local cTitulo1		:= STR0002 //"Este relatório ira imprimir os créditos dos movimentos de saida de"
Local cTitulo2		:= STR0003 //"produtos incentivados pelo PRODEPE."
Local cTitulo3		:= STR0016 //"Para visualizar o relatório corretamente, verificar a tabela de " 
Local cTitulo4		:= STR0017 //"Percentuais Aplicãveis no botao Incluir." 
Local cPerg    		:= "MTR987"
Local nOpc			:= 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera Temporario                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
A987Temp()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Carrega temporario com as informacoes ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
A987Carga()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                                          ³
//³ mv_par01             // Data Inicial                                          ³
//³ mv_par02             // Data Final                                            ³
//³ mv_par03             // Tipo Relatorio (Por NCM+Faixas / Somentes por Faixas) ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Janela Principal                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aSays,OemToAnsi( cTitulo1 ) )
AADD(aSays,OemToAnsi( cTitulo2 ) )
AADD(aSays,OemToAnsi( cTitulo3 ) )
AADD(aSays,OemToAnsi( cTitulo4 ) )
AADD(aButtons, { 4,.T.,{|o| A987Cfg()} } )		//Inclusao da tabela temporaria
AADD(aButtons, { 1,.T.,{|o| nOpc:=2,o:oWnd:End()} } )
AADD(aButtons, { 2,.T.,{|o| nOpc:=3,o:oWnd:End()} } )
AADD(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T.)} } )
FormBatch( cCadastro, aSays, aButtons )
	
dbSelectArea("TMP")
dbCloseArea()

If nOpc == 2
	If FindFunction("TRepInUse") .And. TRepInUse()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Interface de impressao                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport	:= ReportDef()
		oReport:PrintDialog()
	Else
		U_Matr987R3()
	EndIf
Endif
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Luciana Pires          ³ Data ³11/03/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local oCabec
Local oSaidi

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Componente de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TReport():New("MATR987","Resumo de Créditos de Movimentos de Produtos Incentivados - PRODEPE","MTR987",{|oReport| ReportPrint(oReport)},STR0002+" "+STR0003) // "Este relatório ira imprimir os créditos dos movimentos de saida de produtos incentivados pelo PRODEPE."
Pergunte("MTR987",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao 1 - Cabecalho Padrao    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCabec	:= TRSection():New(oReport,"Dados da Empresa/Filial",{"SM0"},{"Emissão"},/*Campos do SX3*/,/*Campos do SIX*/)
oCabec:SetTotalInLine(.F.)
TRCell():New(oCabec,"M0_NOMECOM"	,"SM0"	,"EMPRESA"	,/*Picture*/,40	,/*lPixel*/,{|| SM0->M0_NOMECOM })
TRCell():New(oCabec,"M0_CGC"		,"SM0"	,"C.N.P.J"	,"@R! NN.NNN.NNN/NNNN-99" ,30 ,/*lPixel*/,{|| SM0->M0_CGC })
TRCell():New(oCabec,"M0_INSC"		,"SM0"	,"I.E"		,/*Picture*/,25	,/*lPixel*/,{|| SM0->M0_INSC })
TRCell():New(oCabec,"M0_ENDENT"		,"SM0"	,"ENDERECO"	,/*Picture*/,40	,/*lPixel*/,{|| SM0->M0_ENDENT })
TRCell():New(oCabec,"M0_CIDENT"		,"SM0"	,"CIDADE"	,/*Picture*/,25	,/*lPixel*/,{|| SM0->M0_CIDENT })
TRCell():New(oCabec,"M0_ESTENT"		,"SM0"	,"ESTADO"	,/*Picture*/,02,/*lPixel*/,{||  SM0->M0_ESTENT })
     
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao 2 - Movimentos de Saida com Produtos Incentivados  	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSaidi := TRSection():New(oReport,"MOVIMENTOS DE SAIDA COM PRODUTOS INCENTIVADOS",{},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oSaidi:SetTotalInLine(.F.)
TRCell():New(oSaidi,"NCM"			,,"NCM"				,"@!"				,12,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSaidi,"FAIXA INI"		,,"FAIXA INI"		,"@E 999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSaidi,"FAIXA FIM"		,,"FAIXA FIM"		,"@E 999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSaidi,"PERCENTUAL"	,,"PERCENTUAL"  	,"@E 999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSaidi,"QTDADE"		,,"QTDADE"			,"@E 999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSaidi,"ICMS"			,,"ICMS"			,"@E 999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSaidi,"CREDITO"		,,"CREDITO"			,"@E 999,999,999.99",14,/*lPixel*/,/*{|| code-block de impressao }*/)

oSaidi:Cell("FAIXA INI"):SetHeaderAlign("RIGHT")
oSaidi:Cell("FAIXA FIM"):SetHeaderAlign("RIGHT")
oSaidi:Cell("PERCENTUAL"):SetHeaderAlign("RIGHT")
oSaidi:Cell("QTDADE"):SetHeaderAlign("RIGHT")
oSaidi:Cell("ICMS"):SetHeaderAlign("RIGHT")
oSaidi:Cell("CREDITO"):SetHeaderAlign("RIGHT")

//Totalizador
TRFunction():New(oSaidi:Cell("QTDADE")	,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oSaidi:Cell("ICMS")	,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
TRFunction():New(oSaidi:Cell("CREDITO")	,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,"@E 999,999,999.99",/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oReport:Section(2):SetTotalText("TOTALIZACAO")

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Luciana Pires          ³ Data ³11/03/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos  ³±±
±±³          ³os relatorios que poderao ser agendados pelo usuario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao de Variaveis                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cChave	:= ""

Local lHouveMov	:= .F.

Local aRetCred	:= {}
Local aFaixa	:= {}
Local aLinha	:= {}

Local nX		:= 0 
Local nY		:= 1 
Local nICMS	  	:= 0
Local nICMSCd	:= 0
Local nPerc 	:= 0

Local dDataIni	:= MV_PAR01
Local dDataFin	:= MV_PAR02

Private nTipoMov:= MV_PAR03

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tabela de Percentuais Aplicaveis       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aFaixa := A987LeCfg()

If Len(aFaixa) > 0 .And. aFaixa[1][4] <> 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Creditos de ICMS - Prodepe             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aRetCred := RetCred(dDataIni, dDataFin, aFaixa) 
Endif
dbSelectArea("SFT")

If nTipoMov == 1 .And. Len(aRetCred)>0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ordenacao Por NCM + Faixas                                   |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aSort(aRetCred,,, { |x, y| x[4]+Str(x[1])+Str(x[2])+Str(x[3]) < y[4]+Str(y[1])+Str(y[2])+Str(y[3])}) //(NCM+FxINI+FxFim+Tipo)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Guarda as informacoes por NCM+Faixa                          |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nX := 1 to Len(aRetCred)
		
		lHouveMov 	:= .T.
		nICMS	  	:= 0
		nICMSCd		:= 0
		nQtd		:= 0
		nFxIni		:= aRetCred[nX][1]
		nFxFim		:= aRetCred[nX][2]
		nTipo		:= aRetCred[nX][3]
		cNCM		:= aRetCred[nX][4]
		nPerc 		:= aRetCred[nX][5]   

		cChave	    := aRetCred[nX][4]+Alltrim(Str(aRetCred[nX][1]))+Alltrim(Str(aRetCred[nX][2]))+Alltrim(Str(aRetCred[nX][3]))
		While nY <= Len(aRetCred) .And. cChave == aRetCred[nX][4]+Alltrim(Str(aRetCred[nX][1]))+Alltrim(Str(aRetCred[nX][2]))+Alltrim(Str(aRetCred[nX][3]))
			nICMS	+= aRetCred[nY][7]
			nQtd	+= aRetCred[nY][6]
	    	nY++
			If nY <= Len(aRetCred)
				cChave	    := aRetCred[nY][4]+Alltrim(Str(aRetCred[nY][1]))+Alltrim(Str(aRetCred[nY][2]))+Alltrim(Str(aRetCred[nY][3]))
	    	Endif
	    Enddo

		nX 		:= nY-1
		nICMSCd	:= (nICMS * nPerc) / 100
		AADD(aLinha,{ nFxIni,;		//1 - Faixa Aliq Ini
						nFxFim,;	//2 - Faixa Aliq Fim
						nTipo,;		//3 - Tipo Operacao
						cNCM,;		//4 - NCM Produto
						nPerc,;		//5 - Valor Percentual Aplicado
						nQtd,;		//6 - Quantidade Produto
						nICMS,;		//7 - Valor ICMS
						nICMSCd})	//8 - Credito Prodepe       

	    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Zera as variaveis                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nICMS	  	:= 0
		nICMSCd		:= 0
		nQtd		:= 0
		nFxIni		:= 0
		nFxFim		:= 0
		nTipo		:= 0
		cNCM		:= ""
		nPerc 		:= 0
	Next
	  

ElseIf nTipoMov == 2 .And. Len(aRetCred) > 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ordenacao Somente por Faixas                                 |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aSort(aRetCred,,, { |x, y| Str(x[3])+Str(x[1])+Str(x[2]) < Str(y[3])+Str(y[1])+Str(y[2])}) //(Tipo+FxINI+FxFim)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Guarda as informacoes Somente por Faixa                      |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nX := 1 to Len(aRetCred)
		
		lHouveMov 	:= .T.
		
		nICMS	  	:= 0
		nICMSCd		:= 0
		nQtd		:= 0
		nFxIni		:= aRetCred[nX][1]
		nFxFim		:= aRetCred[nX][2]
		nTipo		:= aRetCred[nX][3]
		cNCM		:= aRetCred[nX][4]
		nPerc 		:= aRetCred[nX][5]
		     
		cChave	    := Alltrim(Str(aRetCred[nX][3]))+Alltrim(Str(aRetCred[nX][1]))+Alltrim(Str(aRetCred[nX][2]))
		While nY <= Len(aRetCred) .And. cChave == Alltrim(Str(aRetCred[nX][3]))+Alltrim(Str(aRetCred[nX][1]))+Alltrim(Str(aRetCred[nX][2]))
			nICMS	+= aRetCred[nY][7]
			nQtd	+= aRetCred[nY][6]
	    	nY++
			If nY <= Len(aRetCred)
				cChave	    := Alltrim(Str(aRetCred[nY][3]))+Alltrim(Str(aRetCred[nY][1]))+Alltrim(Str(aRetCred[nY][2]))
	    	Endif
	    Enddo

		nX 		:= nY-1
		nICMSCd	:= (nICMS * nPerc) / 100
		AADD(aLinha,{ nFxIni,;		//1 - Faixa Aliq Ini
						nFxFim,;	//2 - Faixa Aliq Fim
						nTipo,;		//3 - Tipo Operacao
						cNCM,;		//4 - NCM Produto
						nPerc,;		//5 - Valor Percentual Aplicado
						nQtd,;		//6 - Quantidade Produto
						nICMS,;		//7 - Valor ICMS
						nICMSCd})	//8 - Credito Prodepe       

	    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Zera as variaveis                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nICMS	  	:= 0
		nICMSCd		:= 0
		nQtd		:= 0
		nFxIni		:= 0
		nFxFim		:= 0
		nTipo		:= 0
		cNCM		:= ""
		nPerc 		:= 0
	Next
Endif		
		
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime o cabecalho                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter(1)
oReport:Section(1):Init()
oReport:Section(1):PrintLine() 	
oReport:SkipLine(2)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sem Movimento no Periodo                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !lHouveMov
	oReport:Section(2):PrintLine()
	oReport:SkipLine(2)
	oReport:PrintText("*** NAO HOUVE MOVIMENTO ***")
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao 2 - Movimentos de Saida com Produtos Incentivados  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lHouveMov
	oReport:SetMeter(Len(aLinha))
	oReport:Section(2):Init()
	oReport:SkipLine()
	oReport:ThinLine()
	oReport:SkipLine()   
	nLin := oReport:Row()
	oReport:PrintText("MOVIMENTOS DE SAIDA COM PRODUTOS INCENTIVADOS - "+Iif(nTipoMov == 1,"POR NCM + FAIXA","POR FAIXA"),nLin,oReport:Section(2):Cell("PERCENTUAL"):ColPos())
	oReport:SkipLine(2)
	oReport:ThinLine()
	oReport:SkipLine()   
Endif
	
If nTipoMov == 2
	oReport:Section(2):Cell("NCM"):Disable()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Altero codeblocks para imp dos campos do array  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(2):Cell("NCM"):SetBlock({|| aLinha[nX][04] })
oReport:Section(2):Cell("FAIXA INI"):SetBlock({|| aLinha[nX][01] })
oReport:Section(2):Cell("FAIXA FIM"):SetBlock({|| aLinha[nX][02] })
oReport:Section(2):Cell("PERCENTUAL"):SetBlock({|| aLinha[nX][05] })
oReport:Section(2):Cell("QTDADE"):SetBlock({|| aLinha[nX][06] })
oReport:Section(2):Cell("ICMS"):SetBlock({|| aLinha[nX][07] })
oReport:Section(2):Cell("CREDITO"):SetBlock({|| aLinha[nX][08] })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprimo as linhas do relatorio                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nX := 1 to Len(aLinha)
	oReport:Section(2):PrintLine() 	
Next

oReport:Section(2):Finish() 

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Matr987R3 ºAutor  ³Luciana Pires       º Data ³ 04/03/2008   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio para totalizar os creditos dos movimentos de saidaº±±
±±º          ³ de produtos incentivados pelo PRODEPE                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Sigafis                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Matr987R3

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao das variaveis                                      |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private titulo		:=	STR0001 //"Resumo de Créditos de Movimentos de Produtos Incentivados - PRODEPE"
Private cDesc1		:=	STR0002 //"Este relatório ira imprimir os créditos dos movimentos de saida de"
Private cDesc2		:=	STR0003 //"produtos incentivados pelo PRODEPE."
Private cDesc3		:=	""  
Private aReturn  	:=	{STR0004,1,STR0005,2,2,1,"",1} //"Zebrado"###"Administracao"
Private nomeprog 	:=	"MATR987"
Private cPerg    	:=	"MTR987"
Private cString		:= "SFT"
Private nLastKey 	:=	0
Private Limite   	:=	132
Private Tamanho  	:=	"M"      
Private lEnd   		:= 	.F.		// Controle de cancelamento do relatorio
Private m_pag  		:= 	1  		// Contador de Paginas

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Titulo   :=	STR0001 //"Resumo de Créditos de Movimentos de Produtos Incentivados - PRODEPE"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel	:=	"MATR987"   
wnrel	:=	SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,"",.T.,Tamanho)

nPagina	:=	1

If nLastKey == 27
	dbClearFilter()
	Return
Endif
SetDefault(aReturn,cString)
If nLastKey == 27
	dbClearFilter()
	Return                                                        
Endif
	
RptStatus({|lEnd| ImpRel(@lEnd,wnRel,Tamanho, nPagina)},titulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura Ambiente                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5] == 1
	Set Printer To
	dbCommitAll()
	Ourspool(wnrel)
Endif

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ImpRel   ºAutor  ³Luciana Pires       º Data ³ 04/03/2008  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Imprime o Relatorio                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Matr987                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                    

Static Function ImpRel(lEnd,wnRel,Tamanho,nPagina)       

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao de Variaveis                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cChave	:= ""

Local lHouveMov	:= .F.

Local aLay      := Array(23)
Local aRetCred	:= {}
Local aFaixa	:= {}
Local aLinha	:= {}

Local nLinha    := 0
Local nX		:= 0 
Local nY		:= 1 
Local nICMS	  	:= 0
Local nICMSCd	:= 0
Local nPerc 	:= 0
Local nTICMS	:= 0
Local nTICMSCd	:= 0
Local nTQtd		:= 0

Local dDataIni	:= MV_PAR01
Local dDataFin	:= MV_PAR02

Private nTipoMov:= MV_PAR03

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tabela de Percentuais Aplicaveis       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                		
aFaixa := A987LeCfg()

If Len(aFaixa) > 0 .And. aFaixa[1][4] <> 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Creditos de ICMS - Prodepe             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aRetCred := RetCred(dDataIni, dDataFin, aFaixa) 
Endif
dbSelectArea("SFT")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Layout                                 ³      		
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
U_R987LayOut(@aLay)           

If nTipoMov == 1 .And. Len(aRetCred)>0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ordenacao Por NCM + Faixas                                   |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aSort(aRetCred,,, { |x, y| x[4]+Str(x[1])+Str(x[2])+Str(x[3]) < y[4]+Str(y[1])+Str(y[2])+Str(y[3])}) //(NCM+FxINI+FxFim+Tipo)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Guarda as informacoes por NCM+Faixa                          |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nX := 1 to Len(aRetCred)
		
		lHouveMov 	:= .T.
		
		nICMS	  	:= 0
		nICMSCd		:= 0
		nQtd		:= 0
		nFxIni		:= aRetCred[nX][1]
		nFxFim		:= aRetCred[nX][2]
		nTipo		:= aRetCred[nX][3]
		cNCM		:= aRetCred[nX][4]
		nPerc 		:= aRetCred[nX][5]
		     
		cChave	    := aRetCred[nX][4]+Alltrim(Str(aRetCred[nX][1]))+Alltrim(Str(aRetCred[nX][2]))+Alltrim(Str(aRetCred[nX][3]))
		While nY <= Len(aRetCred) .And. cChave == aRetCred[nX][4]+Alltrim(Str(aRetCred[nX][1]))+Alltrim(Str(aRetCred[nX][2]))+Alltrim(Str(aRetCred[nX][3]))
			nICMS	+= aRetCred[nY][7]
			nQtd	+= aRetCred[nY][6]
	    	nY++
			If nY <= Len(aRetCred)
				cChave	    := aRetCred[nY][4]+Alltrim(Str(aRetCred[nY][1]))+Alltrim(Str(aRetCred[nY][2]))+Alltrim(Str(aRetCred[nY][3]))
	    	Endif
	    Enddo

		nX 		:= nY-1
		nICMSCd	:= (nICMS * nPerc) / 100
		AADD(aLinha,{ nFxIni,;		//1 - Faixa Aliq Ini
						nFxFim,;	//2 - Faixa Aliq Fim
						nTipo,;		//3 - Tipo Operacao
						cNCM,;		//4 - NCM Produto
						nPerc,;		//5 - Valor Percentual Aplicado
						nQtd,;		//6 - Quantidade Produto
						nICMS,;		//7 - Valor ICMS
						nICMSCd})	//8 - Credito Prodepe       

	    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Zera as variaveis                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		nICMS	  	:= 0
		nICMSCd		:= 0
		nQtd		:= 0
		nFxIni		:= 0
		nFxFim		:= 0
		nTipo		:= 0
		cNCM		:= ""
		nPerc 		:= 0
	Next
	  

ElseIf nTipoMov == 2 .And. Len(aRetCred) > 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ordenacao Somente por Faixas                                 |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aSort(aRetCred,,, { |x, y| Str(x[3])+Str(x[1])+Str(x[2]) < Str(y[3])+Str(y[1])+Str(y[2])}) //(Tipo+FxIni+FxFim)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Guarda as informacoes Somente por Faixa                      |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nX := 1 to Len(aRetCred)
		
		lHouveMov 	:= .T.
		
		nICMS	  	:= 0
		nICMSCd		:= 0
		nQtd		:= 0
		nFxIni		:= aRetCred[nX][1]
		nFxFim		:= aRetCred[nX][2]
		nTipo		:= aRetCred[nX][3]
		cNCM		:= aRetCred[nX][4]
		nPerc 		:= aRetCred[nX][5]
		     
		cChave	    := Alltrim(Str(aRetCred[nX][3]))+Alltrim(Str(aRetCred[nX][1]))+Alltrim(Str(aRetCred[nX][2]))
		While nY <= Len(aRetCred) .And. cChave == Alltrim(Str(aRetCred[nX][3]))+Alltrim(Str(aRetCred[nX][1]))+Alltrim(Str(aRetCred[nX][2]))
			nICMS	+= aRetCred[nY][7]
			nQtd	+= aRetCred[nY][6]
	    	nY++
			If nY <= Len(aRetCred)
				cChave	    := Alltrim(Str(aRetCred[nY][3]))+Alltrim(Str(aRetCred[nY][1]))+Alltrim(Str(aRetCred[nY][2]))
	    	Endif
	    Enddo


		nX 		:= nY-1
		nICMSCd	:= (nICMS * nPerc) / 100
		AADD(aLinha,{ nFxIni,;		//1 - Faixa Aliq Ini
						nFxFim,;	//2 - Faixa Aliq Fim
						nTipo,;		//3 - Tipo Operacao
						cNCM,;		//4 - NCM Produto
						nPerc,;		//5 - Valor Percentual Aplicado
						nQtd,;		//6 - Quantidade Produto
						nICMS,;		//7 - Valor ICMS
						nICMSCd})	//8 - Credito Prodepe       

	    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Zera as variaveis                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		nICMS	  	:= 0
		nICMSCd		:= 0
		nQtd		:= 0
		nFxIni		:= 0
		nFxFim		:= 0
		nTipo		:= 0
		cNCM		:= ""
		nPerc 		:= 0
	Next
Endif		

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sem Movimento no Periodo                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !lHouveMov
	nLinha 	:= Mtr987Cabec(nPagina,dDataIni,dDataFin)
	nPagina += 1
	FmtLin(,aLay[19],,,@nLinha)
Else
	nLinha 	:= Mtr987Cabec(nPagina,dDataIni,dDataFin)
	nPagina += 1
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprimo as linhas do relatorio                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nX := 1 to Len(aLinha)
	If nLinha >= 65
		FmtLin(,aLay[22],,,@nLinha)		
		nLinha 	:= Mtr987Cabec(nPagina,dDataIni,dDataFin)	
		nPagina += 1
	Endif

	If nTipoMov == 1
		FmtLin({	aLinha[nX][04],;
					TransForm(aLinha[nX][01],"@e 9999,999,999.99"),;
					TransForm(aLinha[nX][02],"@e 9999,999,999.99"),;
					TransForm(aLinha[nX][05],"@e 999,999,999.99"),;
					TransForm(aLinha[nX][06],"@e 9,999,999,999.99"),;
					TransForm(aLinha[nX][07],"@e 99,999,999,999.99"),;
					TransForm(aLinha[nX][08],"@e 9,999,999,999.99")},aLay[14],,,@nLinha)
	Else
		FmtLin({	TransForm(aLinha[nX][01],"@e 99,999,999,999,999.99"),;
					TransForm(aLinha[nX][02],"@e 9999,999,999,999.99"),;
					TransForm(aLinha[nX][05],"@e 999,999,999.99"),;
					TransForm(aLinha[nX][06],"@e 9,999,999,999,999.99"),;
					TransForm(aLinha[nX][07],"@e 99,999,999,999,999.99"),;
					TransForm(aLinha[nX][08],"@e 999,999,999,999.99")},aLay[17],,,@nLinha)	
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Acumula os valores tot. pagina³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nTICMS	  	+= aLinha[nX][07]
	nTICMSCd	+= aLinha[nX][08]
	nTQtd		+= aLinha[nX][06]
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizacao dos Movimentos                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLinha >= 63
	nLinha 	:= Mtr987Cabec(nPagina,dDataIni,dDataFin)	
	nPagina += 1
ElseIf nLinha >= 65
	FmtLin(,aLay[22],,,@nLinha)		
	nLinha 	:= Mtr987Cabec(nPagina,dDataIni,dDataFin)	
	nPagina += 1
Endif           
           
If nLinha > 0 .And. lHouveMov
	If nTipoMov == 1
		FmtLin(,aLay[13],,,@nLinha)	
		FmtLin({TransForm(nTQtd,"@e 9,999,999,999.99"),TransForm(nTICMS,"@e 99,999,999,999.99"),	TransForm(nTICMSCd,"@e 9,999,999,999.99")},aLay[20],,,@nLinha)			    
	Else
		FmtLin(,aLay[18],,,@nLinha)
		FmtLin({TransForm(nTQtd,"@e 9,999,999,999,999.99"),TransForm(nTICMS,"@e 99,999,999,999,999.99"),TransForm(nTICMSCd,"@e 999,999,999,999.99")},aLay[21],,,@nLinha)			    
	Endif
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Completa o preenchimento da pagina³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLinha <= 65
	While nLinha <= 64
		FmtLin({,,,,,,,,,,,},aLay[04],,,@nLinha)
	EndDo
	FmtLin({},aLay[22],,,@nLinha)
Endif

                                
Return( .T. ) 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  |R987LayOutº Autor ³Luciana Pires       º Data ³ 07/03/2008  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Layout de Impressao                                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³MATR987                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R987LayOut(aLay)

						//   0	     1         2         3         4         5         6         7         8         9         10        11        12        13
						//   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

	aLay[01] := STR0018 // 	"+----------------------------------------------------------------------------------------------------------------------------------+"
	aLay[02] := STR0019 // 	"|                                RESUMO DE CREDITOS DE MOVIMENTOS DE PRODUTOS INCENTIVADOS - PRODEPE                               |"
	aLay[03] := STR0020 //	"|                                                                                                                 PAGINA: ######   |"
	aLay[04] := STR0021 //	"|                                                                                                                                  |"
	aLay[05] := STR0022 //	"| EMPRESA:  ######################################     C.N.P.J.: ##################                I.E.:   #####################   |"
	aLay[06] := STR0023 //	"| ENDERECO: ######################################     CIDADE:   #############################     ESTADO: ##                      |"
	aLay[07] := STR0021 //	"|                                                                                                                                  |"
	aLay[08] := STR0018 //	"+----------------------------------------------------------------------------------------------------------------------------------+"
	aLay[09] := STR0024 //	"|                                  MOVIMENTOS DE SAIDA COM PRODUTOS INCENTIVADOS - POR NCM + FAIXA                                 |"
	aLay[10] := STR0025 //	"|                                     MOVIMENTOS DE SAIDA COM PRODUTOS INCENTIVADOS - POR FAIXA                                    |"
    aLay[11] := STR0018 //	"+----------------------------------------------------------------------------------------------------------------------------------+"
	aLay[12] := STR0026 //	"|        NCM        |    FAIXA INI    |    FAIXA FIM    |   PERCENTUAL   |      QTDADE      |       ICMS        |     CREDITO      |"	
	aLay[13] := STR0027 //	"|-------------------+-----------------+-----------------+----------------+------------------+-------------------+------------------|"
	aLay[14] := STR0028 //	"| ################# | ############### | ############### | ############## | ################ | ################# | ################ |"
	aLay[15] := STR0029 //	"|        FAIXA INI      |      FAIXA FIM      |   PERCENTUAL   |        QTDADE        |         ICMS          |      CREDITO       |"	
	aLay[16] := STR0030 //	"|-----------------------+---------------------+----------------+----------------------+-----------------------+--------------------|"
	aLay[17] := STR0031 //	"| ##################### | ################### | ############## | #################### | ##################### | ################## |"
	aLay[18] := STR0032 //	"|-----------------------+---------------------+----------------+----------------------+-----------------------+--------------------|"
	aLay[19] := STR0033 //	"|                                                   *** NAO HOUVE MOVIMENTO ***                                                    |"
	aLay[20] := STR0034 //	"|                                           TOTALIZACAO | ############## | ################ | ################# | ################ |"
	aLay[21] := STR0035 //	"|                                 TOTALIZACAO | ############## | #################### | ##################### | ################## |"
	aLay[22] := STR0018 //	"+----------------------------------------------------------------------------------------------------------------------------------+"
	aLay[23] := STR0036 //	"|                                             EMISSAO: DE  ##########  ATE  ##########                                             |"	

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Mtr987Cabecº Autor ³Luciana Pires       º Data ³ 07/03/2008  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cabecalho do relatorio                                       º±±
±±º          ³                                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Matr987                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function Mtr987Cabec(nPagina,dDataIni,dDataFin)
Local nLinha	:= 0
Local aLay		:= Array(23)

U_R987LayOut(@aLay)
	
@nLinha,000 PSAY AvalImp(Limite)
	
FmtLin({},aLay[01],,,@nLinha)
FmtLin({},aLay[02],,,@nLinha)
FmtLin({StrZero(nPagina,6)},aLay[03],,,@nLinha)                              
FmtLin({dDataIni,dDataFin},aLay[23],,,@nLinha)                              
FmtLin({},aLay[04],,,@nLinha)                              
FmtLin({SM0->M0_NOMECOM,Transform(SM0->M0_CGC,"@R! NN.NNN.NNN/NNNN-99"),SM0->M0_INSC},aLay[05],,,@nLinha)
FmtLin({SM0->M0_ENDENT,SM0->M0_CIDENT,SM0->M0_ESTENT},aLay[06],,,@nLinha)
FmtLin({},aLay[07],,,@nLinha)           
FmtLin({},aLay[08],,,@nLinha)           
If  nTipoMov == 1
	FmtLin({},aLay[09],,,@nLinha)           
	FmtLin({},aLay[11],,,@nLinha)           
	FmtLin({},aLay[12],,,@nLinha)           
	FmtLin({},aLay[13],,,@nLinha)           		
Else
	FmtLin({},aLay[10],,,@nLinha)           
	FmtLin({},aLay[11],,,@nLinha)           
	FmtLin({},aLay[15],,,@nLinha)           
	FmtLin({},aLay[16],,,@nLinha)           		
Endif	

Return(nLinha)

/*/                              
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³A987LeCfg  ³ Autor ³Luciana Pires          ³ Data ³06/03/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Le o arquivo de configuracao P1CONFIG.CFG                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function A987LeCfg()

Local aRet 		:= {}
Local cFile		:= "P1CONFIG.CFG"
Local cLinha	:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Arquivo de Configuracao dos Percentuais Aplicaveis           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If File(cFile)
	FT_FUSE(cFile)
	FT_FGotop()
	While ( !FT_FEof() )
		cLinha := AllTrim(UPPER(FT_FREADLN()))
		If !Empty(cLinha) .And. Left(cLinha,1)=="{" .And. Right(cLinha,1)=="}" .And.	Len(&cLinha)==4 
			AADD(aRet,&cLinha)
		Endif
		FT_FSKIP()
	EndDo
	FT_FUse()
Endif

Return( aRet )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³A987Cfg    ³ Autor ³Luciana Pires          ³ Data ³06/03/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Tela de configuracao da tabela de percentuais aplicaveis     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function A987Cfg()

Local aAltera	:= {"FXINI","FXFIM","PERC","TIPO"}

Local cFile		:= "P1CONFIG.CFG"
Local cArqBkp	:= "P1CONFIG.#FG"	//Backup
Local cDados	:= ""

Local nHandle	:= 0
Local nOpca		:= 0

Local oDlg            

Private aHeader	:= {}
Private aRotina := {{OemtoAnsi(STR0006)	,"AxPesqui"	,0,1},; // "Pesquisar"
                    {OemtoAnsi(STR0007)	,"AxVisual"	,0,2},; // "Visualizar"
                    {OemtoAnsi(STR0008)	,"AxInclui"	,0,3},; // "Incluir"
                    {OemtoAnsi(STR0009)	,"AxAltera"	,0,4},; // "Alterar"
                    {OemtoAnsi(STR0010)	,"AxDeleta"	,0,5} } // "Excluir"

dbSelectArea("TMP")
dbSetOrder(0)
dbGoTop()

AADD(aHeader,{ OemtoAnsi(STR0011),"FXINI","@E 99.99",05,2,"","","N","TMP","" } )		//"Valor Inicial"
AADD(aHeader,{ OemtoAnsi(STR0012),"FXFIM","@E 99.99",05,2,"","","N","TMP","" } )		//"Valor Final"
AADD(aHeader,{ OemtoAnsi(STR0013),"PERC","@E 99.99",05,2,"","","N","TMP","" } ) 		//"Percentual"  
AADD(aHeader,{ OemtoAnsi(STR0014),"TIPO","@E 9",01,0,"","","N","TMP","" } )			//"Tipo"

aSize		:= MsAdvSize()
aObjects	:= {} 

AAdd( aObjects, { 100, 100, .T., .T. } )

aInfo	:= { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
aPosObj	:= MsObjSize( aInfo, aObjects )

DEFINE MSDIALOG oDlg TITLE OemtoAnsi(STR0015) From aSize[7],0 to aSize[6],aSize[5] of oMainWnd PIXEL //"Tabela de Percentuais Aplicáveis"
oGetDb := MsGetDB():New(aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4],4,"Allwaystrue","Allwaystrue",,.T.,aAltera,,.T.,,"TMP",,,.T.)
ACTIVATE MSDIALOG oDlg CENTERED ON INIT EnchoiceBar(oDlg,{||nOpcA:=1,oDlg:End()},{||nOpcA:=2,oDlg:End()})

If nOpcA == 1
	If (File(cFile))
		If File(cArqBkp)
			FErase (cArqBkp)
		Endif
		FRename(cFile,cArqBkp)
	Endif
	nHandle	:=	MsFCreate(cFile)
	dbSelectArea("TMP")
	dbSetOrder(1)
	dbGoTop()
	While !Eof() 
		If !(TMP->_FLAG)
			cDados	:=	'{'+;
					LTRIM(STR(TMP->FXINI,5,2))+','+;
					LTRIM(STR(TMP->FXFIM,5,2))+','+;
					LTRIM(STR(TMP->PERC,5,2))+','+;
					LTRIM(STR(TMP->TIPO,1,0))+;
					'}'+Chr(13)+Chr(10)
			FWrite(nHandle,cDados,Len(cDados))
		Endif
		dbSkip()
	Enddo
	If nHandle >= 0
		FClose(nHandle)
	Endif
Else 
	A987Carga()	
Endif

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³A987Temp   ³ Autor ³Luciana Pires	         ³ Data ³06/03/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Gera arquivo temporario                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function A987Temp()

Local aStru		:= {}
Private cArqTMP	:= ""

AADD(aStru,{"FXINI"		,"N",005,2})	//Faixa Aliquota Inicial
AADD(aStru,{"FXFIM"		,"N",005,2})	//Faixa Aliquota Final
AADD(aStru,{"PERC"		,"N",005,2})	//Percentual Aplicavel
AADD(aStru,{"TIPO"		,"N",001,0})	//Tipo Operacao - 1 (Interna) / 2 (Interestadual)
AADD(aStru,{"_FLAG"		,"L",001,0})	//Flag de Controle

cArqTMP := CriaTrab(aStru)
dbUseArea(.T.,__LocalDriver,cArqTMP,"TMP")
IndRegua("TMP",cArqTMP,"STR(TIPO,1,0)")

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³A987Carga  ³ Autor ³Luciana Pires          ³ Data ³06/03/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Carrega arquivo temporario                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function A987Carga() 
Local nX		:= 0
Local aFaixa 	:= A987LeCfg()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Excluindo os itens atuais para recarregar o temporario³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("TMP")
Do While !TMP->(Eof())
	RecLock("TMP",.F.)
	TMP->(dbDelete())
	MsUnLock()
	TMP->(dbSkip())
Enddo

If Len(aFaixa) > 0
	For nX := 1 To Len(aFaixa)
		RecLock("TMP",.T.)
		FXINI		:= aFaixa[nX][01]
		FXFIM		:= aFaixa[nX][02]
		PERC		:= aFaixa[nX][03]
		TIPO		:= aFaixa[nX][04]
		MsUnlock()
	Next
Else
	RecLock("TMP",.T.)
	MsUnlock()
Endif

dbSelectArea("TMP")
dbGoTop()

Return
