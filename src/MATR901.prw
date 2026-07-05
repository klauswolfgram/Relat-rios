/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR901.CH"
#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR901   ³ Autor ³ Nereu Humberto Junior     ³ Data ³ 18.07.06    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Kardex Fisico - Financeiro                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³             ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador  ³Data    ³    BOPS     ³ Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Jonathan Glz ³20/07/15³PCREQ-4256   ³Se elimina la funcion AjustaSX1() y       ³±±
±±³             ³        ³             ³MTR901CUnf() que hacen modificaciones     ³±±
±±³             ³        ³             ³a SX1 por motivo adecuacion a fuentes     ³±±
±±³             ³        ³             ³a nuevas estructuras SX para v12.         ³±±
±±³Alf. Medrano ³19/11/15³PCREQ-4263   ³se realiza merge 12.1.8                   ³±±
±±³Luis Enríquez³02/12/16³SERINN001-386³Se realizó merge Inovação 12.1.15         ³±±
±±³  Marco A.   ³16/04/18³ DMINA-2310  ³Se remueven sentencias CriaTrab y se apli-³±±
±±³             ³        ³             ³ca FWTemporaryTable(), para el manejo de  ³±±
±±³             ³        ³             ³las tablas temporales.                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR901()
	Local oReport

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:= ReportDef()
	oReport:PrintDialog()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Nereu Humberto Junior  ³ Data ³18.07.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

	Local aOrdem    := {}
	Local cTamD1Doc := TamSX3('D1_DOC')[1]
	Local cPicD1Qt  := PesqPict("SD1","D1_QUANT" ,18)
	Local cTamD1Qt  := TamSX3('D1_QUANT')[1]
	Local cPicD1Cust:= PesqPict("SD1","D1_CUSTO",18)
	Local cTamD1Cust:= TamSX3('D1_CUSTO')[1]
	Local cPicD2Qt  := PesqPict("SD2","D2_QUANT" ,18)
	Local cTamD2Qt  := TamSX3('D2_QUANT')[1]
	Local cPicD2Cust:= PesqPict("SD2","D2_CUSTO1",18)
	Local cTamD2Cust:= TamSX3('D2_CUSTO1')[1]
	Local cPicB2Qt  := PesqPictQt("B2_QATU",18)
	Local oSection1
	Local oSection2
	Local oSection3
	Local oReport 
	Local oCell         
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se utiliza custo unificado por Empresa/Filial       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local lCusUnif := IIf(FindFunction("A330CusFil"),A330CusFil(),GetMV("MV_CUSFIL",.F.))


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
	oReport:= TReport():New("MATR901",STR0001,"MTR901", {|oReport| ReportPrint(oReport)},STR0002+" "+STR0003) //"Kardex Fisico"##"Este programa emitir  uma rela‡„o com as movimenta‡”es"##"dos produtos selecionados, ordenados sequencialmente."
	oReport:SetLandscape()    
	oReport:SetTotalInLine(.F.)

	Pergunte("MTR901",.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Definicao da Sessao 1 - Dados do Produto                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1 := TRSection():New(oReport,STR0063,{"SB1","SB2"}) //"Produtos (Parte 1)"
	oSection1 :SetTotalInLine(.F.)
	oSection1 :SetReadOnly()
	oSection1 :SetLineStyle()

	TRCell():New(oSection1,"B1_COD"		,"SB1",/*Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"B1_DESC"	,"SB1",/*Titulo*/	,/*Picture*/,30			,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"B1_UM"		,"SB1",STR0057		,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"B1_TIPO"	,"SB1",STR0058		,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"B1_GRUPO"	,"SB1",STR0059		,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"nCusMed"	,"   ",STR0060		,cPicD1Cust	,cTamD1Cust	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"nQtdSal"	,"   ",STR0055		,cPicD1Qt	,cTamD1Qt	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"nVlrSal"	,"   ",STR0056		,cPicD1Cust	,cTamD1Cust	,/*lPixel*/,/*{|| code-block de impressao }*/)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Definicao da Sessao 2 - Cont. dos dados do Produto           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection2 := TRSection():New(oSection1,STR0064,{"SB1","SB2"}) //"Produtos (Parte 2)"
	oSection2 :SetTotalInLine(.F.)
	oSection2 :SetReadOnly()
	oSection2 :SetLineStyle()

	TRCell():New(oSection2,"B1_POSIPI"	,"SB1",STR0061,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"B2_LOCALIZ","SB2",STR0062,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Definicao da Sessao 3 - Movimentos                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection3 := TRSection():New(oSection2,STR0065,{"SD1","SD2","SD3"}) //"Movimentação dos Produtos"
	oSection3 :SetHeaderPage()
	oSection3 :SetTotalInLine(.F.)
	oSection3 :SetTotalText(STR0021) //"T O T A I S  :"
	oSection3 :SetReadOnly()

	TRCell():New(oSection3,"dDtMov"		,"   ",STR0039+CRLF+STR0040	,/*Picture*/,10         ,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"cTES"		,"   ",STR0041				,"@!"		,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"cCF"		,"   ",STR0042				,"@!"		,4/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"cDoc"		,"   ",STR0043+CRLF+STR0044	,"@!"		,cTamD1Doc	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"cTraco1"	,"   ","|"+CRLF+"|"			,/*Picture*/,1			,/*lPixel*/,{|| "|" })
	TRCell():New(oSection3,"nENTQtd"	,"   ",STR0045+CRLF+STR0046	,cPicD1Qt	,cTamD1Qt	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"cTraco2"	,"   ","|"+CRLF+"|"			,/*Picture*/,1			,/*lPixel*/,{|| "|" })
	TRCell():New(oSection3,"nENTCus"	,"   ",STR0045+CRLF+STR0047	,cPicD1Cust	,cTamD1Cust	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"cTraco3"	,"   ","|"+CRLF+"|"			,/*Picture*/,1			,/*lPixel*/,{|| "|" })
	TRCell():New(oSection3,"nCusMov"	,"   ",STR0048+CRLF+STR0049	,cPicD1Cust	,cTamD1Cust	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"cTraco4"	,"   ","|"+CRLF+"|"			,/*Picture*/,1			,/*lPixel*/,{|| "|" })
	TRCell():New(oSection3,"nSAIQtd"	,"   ",STR0050+CRLF+STR0046	,cPicD2Qt	,cTamD2Qt	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"cTraco5"	,"   ","|"+CRLF+"|"			,/*Picture*/,1			,/*lPixel*/,{|| "|" })
	TRCell():New(oSection3,"nSAICus"	,"   ",STR0050+CRLF+STR0047	,cPicD2Cust	,cTamD2Cust	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"cTraco6"	,"   ","|"+CRLF+"|"			,/*Picture*/,1			,/*lPixel*/,{|| "|" })
	TRCell():New(oSection3,"nSALDQtd"	,"   ",STR0051+CRLF+STR0046	,cPicD1Qt	,cTamD1Qt	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"cTraco7"	,"   ","|"+CRLF+"|"			,/*Picture*/,1			,/*lPixel*/,{|| "|" })
	TRCell():New(oSection3,"nSALDCus"	,"   ",STR0051+CRLF+STR0052	,cPicD1Cust	,cTamD1Cust	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"cTraco8"	,"   ","|"+CRLF+"|"			,/*Picture*/,1			,/*lPixel*/,{|| "|" })
	TRCell():New(oSection3,"cCCPVPJOP"	,"   ",STR0053+CRLF+STR0054	,"@!"		,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

	TRFunction():New(oSection3:Cell("nENTQtd"),NIL,"SUM",/*oBreak*/,"",cPicD1Qt	,/*uFormula*/,.T.,.F.) 
	TRFunction():New(oSection3:Cell("nENTCus"),NIL,"SUM",/*oBreak*/,"",cPicD1Cust	,/*uFormula*/,.T.,.F.) 

	TRFunction():New(oSection3:Cell("nSAIQtd"),NIL,"SUM",/*oBreak*/,"",cPicD2Qt	,/*uFormula*/,.T.,.F.) 
	TRFunction():New(oSection3:Cell("nSAICus"),NIL,"SUM",/*oBreak*/,"",cPicD2Cust	,/*uFormula*/,.T.,.F.) 

	TRFunction():New(oSection3:Cell("nSALDQtd"),NIL,"ONPRINT",/*oBreak*/,"",cPicB2Qt	,{|| oSection3:Cell("nSALDQtd"):GetValue(.T.) },.T.,.F.) 
	TRFunction():New(oSection3:Cell("nSALDCus"),NIL,"ONPRINT",/*oBreak*/,"",cPicD1Cust,{|| oSection3:Cell("nSALDCus"):GetValue(.T.) },.T.,.F.) 

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Nereu Humberto Junior  ³ Data ³21.06.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)

	Local oSection1		:= oReport:Section(1) 
	Local oSection2		:= oReport:Section(1):Section(1)  
	Local oSection3		:= oReport:Section(1):Section(1):Section(1)  
	Local cSelectD1		:= '', cWhereD1 := '%%', cWhereD1C := ''
	Local cSelectD2		:= '', cWhereD2 := '%%', cWhereD2C := ''
	Local cSelectD3		:= '', cWhereD3 := '%%', cWhereD3C := ''
	Local cWhereRE		:= ''
	Local nTam			:= 18
	Local cPicB2Qt2		:= PesqPictQt("B2_QTSEGUM" ,nTam)
	Local aSalAtu		:= {0,0,0,0,0,0,0}
	Local lQuery		:= .F.
	Local nTamCod		:= TamSX3("B1_COD")[1]
	Local lUsaD2DIG		:= IIF(FindFunction("UsaD2DTDIG"), UsaD2DTDIG(), .F.)
	Local cDepTrf		:= SuperGetMv("MV_DEPTRAN",.F.,"95")	// Dep.transferencia
	Local lTranSB2		:= SuperGetMv("MV_TRANSB2" ,.F.,.F.)	// Atualiza saldos de transferencia
	Local lLocProc		:= Alltrim(mv_par08) == GetMv("MV_LOCPROC")
	Local lInverteMov	:= .F.
	Local aTamB2Loc		:= {}
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para processamento de Filiais           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local aFilsCalc 	:= MatFilCalc( Iif (!IsBlind(), ValType(mv_par14) == "N" .and. mv_par14 == 1, .F.))
	Local cFilBack  	:= cFilAnt
	Local nForFilial	:= 0
	Local aFils     	:= {}
	Local nFils     	:= 0
	Local nRegImp		:= 0
	Local lShowZero 	:= (ValType(MV_PAR15) <> "N" .Or. (ValType(MV_PAR15) == "N" .and. mv_par15 == 2))
	Local nSLDCosto		:= 0

	Local cAliasTop := ''
	
	Private oTmpTable := Nil

	Private bBloco := { |nV,nX| Trim(nV)+IIf(Valtype(nX)='C',"",Str(nX,1)) }
	Private nDecs  := MsDecimais(mv_par10)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³MV_CUSREP - Parametro utilizado para habilitar o calculo do   ³
	//³            Custo de Reposicao.                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private lCusRep  := SuperGetMv("MV_CUSREP",.F.,.F.) .And. (FindFunction("MA330AvRep") .And. MA330AvRep())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³MV_CUSFIL - Parametro utilizado para verificar se o sistema   |
	//|utiliza custo unificado por:                                  |
	//|      F = Custo Unificado por Filial                          |
	//|      E = Custo Unificado por Empresa                         |
	//|      A = Custo Unificado por Armazem                         |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private lCusFil    := AllTrim(SuperGetMV('MV_CUSFIL' ,.F.,"A")) == "F"
	Private lCusEmp    := AllTrim(SuperGetMv('MV_CUSFIL' ,.F.,"A")) == "E"

	lCusFil := lCusFil .And. mv_par08 == Repl("*",TamSX3("B2_LOCAL")[1])
	lCusEmp := lCusEmp .And. mv_par08 == Repl("#",TamSX3("B2_LOCAL")[1])

	If lCusEmp .And. !Empty(aFilsCalc)
		For nForFilial := 1 To Len( aFilsCalc )
			If aFilsCalc[ nForFilial, 1 ]
				aAdd(aFils, aFilsCalc[ nForFilial, 2 ])
			EndIf 
		Next nForFilial
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ aFilsCalc - Array com filiais a serem processadas            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(aFilsCalc)

		For nForFilial := 1 To Len( aFilsCalc )

			If aFilsCalc[ nForFilial, 1 ]

				cFilAnt := aFilsCalc[ nForFilial, 2 ]

				oReport:EndPage() //Reinicia Pagina
							
				oReport:SetTitle(OemToAnsi(STR0008)+iif(MV_PAR11==1,OemToAnsi(STR0009),OemToAnsi(STR0010) ) + " " + IIf(lCusFil .Or. lCusEmp,"",OemToAnsi(STR0011)+" "+mv_par08))    // "KARDEX FISICO-FINANCEIRO "###"(SEQUENCIA)"###"(CALCULO)"###"L O C A L :"
				oReport:SetTitle(oReport:Title()+STR0017+STR0004+STR0018+AllTrim(&("MV_SIMB"+Str(mv_par10,1)))+")" + ' - ' + aFilsCalc[ nForFilial, 3 ] )  //" (Por "###" ,em "

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Genera segundo arquivo de Trabalho                           ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				dbSelectArea("SB1")
				dbSetOrder(1)
				Set Softseek On
				dbseek(cFilial+mv_par01)
				Set Softseek Off
				cCond1:="SB1->B1_COD"
				cCond2:="mv_par02"
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Gera arquivo de Trabalho                                     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				aTamQ:=TamSX3("B2_QATU")
				aTamT:=TamSX3("B2_VFIM1")
				aTamC:=TamSX3("B2_CM1")
				aTamX:=TamSX3("F4_CF")
				aTamF:=TamSX3("A2_COD")
				aTamL:=TamSX3("A2_LOJA")
				aTamB2Loc:=TamSX3("B2_LOCAL")

				aCampos := {}
				AADD(aCampos,{"PRODUTO"  ,"C",nTamCod,0})
				AADD(aCampos,{"EMISSAO"  ,"D",08,0})
				AADD(aCampos,{"SEQCALC"  ,"C",14,0})
				AADD(aCampos,{"NUMSEQ"   ,"C",14,0})
				AADD(aCampos,{"TES"      ,"C",03,0})
				AADD(aCampos,{"CF"       ,"C",aTamX[1],aTamX[2]})
				AADD(aCampos,{"TIPODOC"  ,"C",03,0})
				AADD(aCampos,{"NUMDOC"   ,"C",TamSX3('D1_DOC')[1],0})
				AADD(aCampos,{"SERIE"    ,"C",03,0})
				AADD(aCampos,{"QUANT"    ,"N",aTamQ[1],aTamQ[2]})
				AADD(aCampos,{"CUSTOTAL" ,"N",aTamT[1],aTamT[2]})
				AADD(aCampos,{"CLIFOR"   ,"C",aTamF[1],aTamF[2]})
				AADD(aCampos,{"LOJA"     ,"C",aTamL[1],aTamL[2]})
				AADD(aCampos,{"ARMAZEM"  ,"C", aTamB2Loc[1], aTamB2Loc[2]})
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Transforma parametros Range em expressao SQL                            ³	
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				MakeSqlExpr(oReport:uParam)

				If cPaisLoc == "BRA"
					cAliasTop := "TRB"
				Else 
					cAliasTop := "TRC"
				EndIf	
				lQuery := .T.

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Query do relatorio da secao 1                                           ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oReport:Section(1):BeginQuery()	

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Complemento do SELECT da tabela SD1                                     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cSelectD1 := "%
				If mv_par10 == 1
					If lCusRep .And. mv_par13 == 2
						cSelectD1 += " D1_CUSRP1 CUSTOTAL,"
					Else
						cSelectD1 += " D1_CUSTO CUSTOTAL,"
					EndIf	
				Else
					If lCusRep .And. mv_par13 == 2
						cSelectD1 += " D1_CUSRP"+str(mv_par10,1)+" CUSTOTAL,"
					Else
						cSelectD1 += " D1_CUSTO"+str(mv_par10,1)+" CUSTOTAL,"
					EndIf	
				EndIf	
				cSelectD1 += "%"
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Complemento do Where da tabela SD1                                      ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
				cWhereD1 := "%" 
				If !(lCusFil .Or. lCusEmp)
					cWhereD1 += " SD1.D1_LOCAL ='"+mv_par08+"' AND"
				EndIf
				cWhereD1 += "%"
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Complemento do Where da tabela SD1 (Tratamento Filial)                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lCusEmp
					cWhereD1C := "%"
					If FWModeAccess("SD1") == "E" .AND. FWModeAccess("SF4") == "E"
						cWhereD1C += " D1_FILIAL = F4_FILIAL AND "
					EndIf
					If FWModeAccess("SD1") == "E" .AND. FWModeAccess("SB1") == "E"
						cWhereD1C += " D1_FILIAL = B1_FILIAL AND "
					EndIf
					For nFils := 1 to len(aFils)
						If nFils == 1
							cWhereD1C += " D1_FILIAL IN ('"+aFils[nFils]+"'"
						else
							cWhereD1C += ",'"+aFils[nFils]+"'"
						EndIf
						If nFils == len(aFils)
							cWhereD1C += ") "
						EndIf
					Next nFils
					cWhereD1C += "%"
				Else
					cWhereD1C := "%"
					cWhereD1C += " D1_FILIAL ='" + xFilial("SD1") + "' AND "
					cWhereD1C += " SF4.F4_FILIAL = '" + xFilial("SF4") + "'"
					cWhereD1C += "%"
				EndIf 
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Complemento do SELECT da tabela SD2                                     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lCusRep .And. mv_par13 == 2
					cSelectD2 := "% D2_CUSRP"
					cSelectD2 += Str(mv_par10,1) // Coloca a Moeda do Custo
				Else
					cSelectD2 := "% D2_CUSTO"
					cSelectD2 += Str(mv_par10,1) // Coloca a Moeda do Custo
				EndIf
				cSelectD2 += " CUSTOTAL,"
				cSelectD2 += "%"
				// Verifica se usa o campo D2_DTDIGIT ou nao, de acordo com a funcao UsaD2DTDIG
				If lUsaD2DIG
					cD2EMISSAO := "% D2_DTDIGIT EMISSAO,%"
				Else
					cD2EMISSAO := "% D2_EMISSAO EMISSAO,%"
				EndIf	
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Complemento do Where da tabela SD1                                      ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
				cWhereD2 := "%" 
				If !(lCusFil .Or. lCusEmp)
					cWhereD2 += " SD2.D2_LOCAL ='"+mv_par08+"' AND "
				EndIf
				// Verifica se usa o campo D2_DTDIGIT ou nao, de acordo com a funcao UsaD2DTDIG
				If lUsaD2DIG
					cWhereD2 += " SD2.D2_DTDIGIT >= '"+Dtos(mv_par05)+"' AND "
					cWhereD2 += " SD2.D2_DTDIGIT <= '"+Dtos(mv_par06)+"' AND "
				Else
					cWhereD2 += " SD2.D2_EMISSAO >= '"+Dtos(mv_par05)+"' AND "
					cWhereD2 += " SD2.D2_EMISSAO <= '"+Dtos(mv_par06)+"' AND "
				EndIf
				cWhereD2 += "%"    

				cWhereRE := "%" 
				cWhereRE += " (SD2.D2_REMITO   = '" + Space(TamSx3('D2_REMITO')[1]) + "' OR SD2.D2_TPDCENV IN ('1','A')) "	
				cWhereRE += "%"

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Complemento do Where da tabela SD2 (Tratamento Filial)                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lCusEmp
					cWhereD2C := "%"
					If FWModeAccess("SD2") == "E" .AND. FWModeAccess("SF4") == "E"
						cWhereD2C += " D2_FILIAL = F4_FILIAL AND "
					EndIf
					If FWModeAccess("SD2") == "E" .AND. FWModeAccess("SB1") == "E"
						cWhereD2C += " D2_FILIAL = B1_FILIAL AND "
					EndIf
					For nFils := 1 to len(aFils)
						If nFils == 1
							cWhereD2C += " D2_FILIAL IN ('"+aFils[nFils]+"'"
						Else
							cWhereD2C += ",'"+aFils[nFils]+"'"
						EndIf
						If nFils == len(aFils)
							cWhereD2C += ") "
						EndIf
					Next nFils
					cWhereD2C += "%"
				Else
					cWhereD2C := "%"
					cWhereD2C += " D2_FILIAL ='" + xFilial("SD2") + "' AND "
					cWhereD2C += " SF4.F4_FILIAL = '" + xFilial("SF4") + "'"
					cWhereD2C += "%"
				EndIf

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Complemento do SELECT da tabelas SD3                                    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lCusRep .And. mv_par13 == 2
					cSelectD3 := "% D3_CUSRP"
					cSelectD3 += Str(mv_par10,1) // Coloca a Moeda do Custo
				Else
					cSelectD3 := "% D3_CUSTO"
					cSelectD3 += Str(mv_par10,1) // Coloca a Moeda do Custo
				EndIf	
				cSelectD3 += " CUSTOTAL, "	
				cSelectD3 += "%"    
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Complemento do WHERE da tabela SD3                                      ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cWhereD3 := "%"
				If !(lCusFil .Or. lCusEmp) .And. !lLocProc 
					cWhereD3 += " SD3.D3_LOCAL ='"+mv_par08+"' AND"
				EndIf
				If cPaisLoc != "EQU" .And. !lTranSB2 .And. !lLocProc 
						cWhereD3 += " SD3.D3_LOCAL <> '"+cDepTrf+"' AND"
				EndIf
				If SuperGetMV('MV_D3ESTOR', .F., 'N') == 'N'
					cWhereD3 += " SD3.D3_ESTORNO <> 'S' AND"
				EndIf  
				If SuperGetMV('MV_D3SERVI', .F., 'N') == 'N' .And. IntDL()
					cWhereD3 += " ( (D3_SERVIC = '   ') OR (D3_SERVIC <> '   ' AND D3_TM <= '500' AND D3_STSERV = '3') ) AND"
				EndIf		      	
				cWhereD3 += "%"	

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Complemento do Where da tabela SD3 (Tratamento Filial)                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lCusEmp
					cWhereD3C := "%"
					For nFils := 1 to len(aFils)
						If nFils == 1
							cWhereD3C += " D3_FILIAL IN ('"+aFils[nFils]+"'"
						Else
							cWhereD3C += ",'"+aFils[nFils]+"'"
						EndIf
						If nFils == len(aFils)
							cWhereD3C += ") %"
						EndIf
					Next nFils
				Else
					cWhereD3C := "%"
					cWhereD3C += " D3_FILIAL ='" + xFilial("SD3")  + "' "
					cWhereD3C += "%"
				EndIf

				cOrder := "%"
				If mv_par11 == 1
					If UPPER(TcGetDB()) != "INFORMIX"    
						cOrder += " PRODUTO, EMISSAO, NUMSEQ, TES"     		
					Else
						cOrder += " 2, 5, 4, 6"
					EndIf
				Else                                 
					If UPPER(TcGetDB()) != "INFORMIX"    
						cOrder += " PRODUTO, SEQCALC, TES"
					Else
						cOrder += " 2, 3, 6 "
					EndIf	
				EndIf
				cOrder += "%"

				BeginSql Alias cAliasTop

				SELECT 	 B1_TIPO TIPO, 				
				D1_COD PRODUTO,
				D1_SEQCALC SEQCALC,
				D1_NUMSEQ NUMSEQ,
				D1_DTDIGIT EMISSAO,
				D1_TES TES,
				D1_CF CF, 
				D1_ESPECIE TIPODOC,
				D1_DOC NUMDOC,
				D1_SERIE SERIE,
				D1_QUANT QUANT,
				D1_FORNECE CLIFOR,
				D1_LOJA LOJA,
				D1_LOCAL ARMAZEM,
				%Exp:cSelectD1%		
				SD1.R_E_C_N_O_

				FROM %table:SD1% SD1,%table:SF4% SF4,%table:SB1% SB1

				WHERE
				SD1.D1_COD     >= %Exp:mv_par01% 	AND
				SD1.D1_COD     <= %Exp:mv_par02% AND          
				%Exp:cWhereD1C%						AND
				%Exp:cWhereD1%
				SD1.D1_DTDIGIT >= %Exp:mv_par05% 	AND
				SD1.D1_DTDIGIT <= %Exp:mv_par06%	AND		
				SD1.D1_ORIGLAN <> 'LF'           	AND
				SD1.D1_REMITO  = ' '             	AND
				SD1.D1_TIPO_NF >= ' '            	AND
				SD1.%NotDel%						AND	
				SF4.F4_CODIGO  = SD1.D1_TES 		AND
				SF4.F4_ESTOQUE = 'S' 				AND
				SF4.%NotDel%                     	AND      
				SB1.B1_FILIAL  =  %xFilial:SB1%	AND 	
				SB1.B1_COD     = SD1.D1_COD 		AND
				SB1.B1_TIPO    >= %Exp:mv_par03% 	AND
				SB1.B1_TIPO    <= %Exp:mv_par04% 	AND          			  
				SB1.%NotDel%                     	         

				UNION

				SELECT 	B1_TIPO TIPO,
				D2_COD PRODUTO,
				D2_SEQCALC SEQCALC,
				D2_NUMSEQ NUMSEQ,
				%Exp:cD2EMISSAO%
				D2_TES TES,
				D2_CF CF,
				D2_ESPECIE TIPODOC,
				D2_DOC NUMDOC,
				D2_SERIE SERIE,
				D2_QUANT QUANT,
				D2_CLIENTE CLIFOR,
				D2_LOJA LOJA,
				D2_LOCAL ARMAZEM,
				%Exp:cSelectD2%			
				SD2.R_E_C_N_O_

				FROM %table:SD2% SD2,%table:SF4% SF4,%table:SB1% SB1

				WHERE
				SD2.D2_COD     >= %Exp:mv_par01% 	AND
				SD2.D2_COD     <= %Exp:mv_par02% AND          
				%Exp:cWhereD2C%						AND
				%Exp:cWhereD2%
				SD2.D2_EMISSAO >= %Exp:mv_par05% 	AND
				SD2.D2_EMISSAO <= %Exp:mv_par06%	AND		
				SD2.D2_ORIGLAN <> 'LF'           	AND
				%Exp:cWhereRE%                   	AND
				SD2.%NotDel%						AND
				SF4.F4_CODIGO  = SD2.D2_TES 		AND
				SF4.F4_ESTOQUE = 'S' 				AND
				SF4.%NotDel%                     	AND      
				SB1.B1_FILIAL  =  %xFilial:SB1%	AND 	
				SB1.B1_COD     = SD2.D2_COD 		AND
				SB1.B1_TIPO    >= %Exp:mv_par03% 	AND
				SB1.B1_TIPO    <= %Exp:mv_par04% 	AND          			  
				SB1.%NotDel%                     	         

				UNION		

				SELECT 	B1_TIPO TIPO,
				D3_COD PRODUTO,
				D3_SEQCALC SEQCALC,
				D3_NUMSEQ NUMSEQ,
				D3_EMISSAO EMISSAO, 
				D3_TM TES, 
				D3_CF CF, 
				D3_CF TIPODOC,
				D3_DOC NUMDOC,
				' ' SERIE,
				D3_QUANT QUANT,
				' ' CLIFOR,
				' ' LOJA,
				D3_LOCAL ARMAZEM,
				%Exp:cSelectD3%			
				SD3.R_E_C_N_O_

				FROM %table:SD3% SD3,%table:SB1% SB1

				WHERE
				SD3.D3_COD     >= %Exp:mv_par01% 	AND
				SD3.D3_COD     <= %Exp:mv_par02% AND
				SD3.D3_EMISSAO >= %Exp:mv_par05% 	AND
				SD3.D3_EMISSAO <= %Exp:mv_par06%	AND
				%Exp:cWhereD3C%						AND
				%Exp:cWhereD3%                      
				SD3.%NotDel%						AND
				SB1.B1_FILIAL  =  %xFilial:SB1%	AND 	
				SB1.B1_COD     = SD3.D3_COD 		AND
				SB1.B1_TIPO    >= %Exp:mv_par03% 	AND
				SB1.B1_TIPO    <= %Exp:mv_par04% 	AND          			  
				SB1.%NotDel%                     	                       

				ORDER BY %Exp:cOrder%

				EndSql 
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Metodo EndQuery ( Classe TRSection )                                    ³
				//³                                                                        ³
				//³Prepara o relatorio para executar o Embedded SQL.                       ³
				//³                                                                        ³
				//³ExpA1 : Array com os parametros do tipo Range                           ³
				//³                                                                        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

				If cPaisLoc == "BRA" 
					aEval(aCampos, {|e| If(e[2]!= "C", TCSetField("TRB", e[1], e[2],e[3],e[4]),Nil)})
				Else                
					aEval(aCampos, {|e| If(e[2]!= "C", TCSetField("TRC", e[1], e[2],e[3],e[4]),Nil)})
					U_MTR901FillTrb(aCampos)	
				EndIf	

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Inicio da impressao do fluxo do relatório                               ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				dbSelectArea("SB1") 
				dbSetOrder(1)
				SB1->(dbSeek(xFilial()+mv_par01,.T.))

				dbSelectArea("TRB")
				oReport:SetMeter(TRB->(LastRec()))
				dbGoTop()

				While !oReport:Cancel() .And. !("TRB")->(Eof()) .Or. If(lQuery.And.mv_par07 == 1,&cCond1 <= &cCond2 .And. !SB1->(Eof()),.F.)

					nRegImp   := 0
					lImpCabec := .T.

					cProduto := PRODUTO

					If mv_par07 == 2
						SB1->(MsSeek(xFilial()+TRB->PRODUTO))   
					EndIf

					If oReport:Cancel()
						Exit
					EndIf	

					If !lQuery .Or. (lQuery .And. TRB->PRODUTO == SB1->B1_COD)
						
						While !Eof() .And. PRODUTO == cProduto

							If oReport:Cancel()
								Exit
							EndIf				

							lInverteMov := .F.

							If lLocProc .And. !(Substr(TIPODOC,3,1) $ "3") .And. mv_par08 <> ARMAZEM
								dbSkip()
								Loop
							EndIf

							oReport:IncMeter()

							If lImpCabec
								MTR901S12(aSalAtu,oSection1,oSection2,lQuery)
								lImpCabec := .F.
							EndIf

							dbSelectArea("TRB")

							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Verifica la fecha para productos sin movimientos        ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							oSection3:Init() 
							If lQuery
								If TIPODOC $ "FT /NF /   "     
									TIPODOC := "FAC"
								EndIf
							EndIf
							If CtoD("  /  /  ") != EMISSAO

								oSection3:Cell("dDtMov"):SetValue(EMISSAO)			
								oSection3:Cell("cTES"):SetValue(TES)														
								If Alltrim(TIPODOC) $ "RE3|DE3" .And. lLocProc
									oSection3:Cell("cCF"):SetValue(TIPODOC+"*")	
									lInverteMov := .T.		
								Else
									oSection3:Cell("cCF"):SetValue(TIPODOC)			
								EndIf
								oSection3:Cell("cDoc"):SetValue(IIF(mv_par09 == 1,NUMDOC,NUMSEQ))			

								If (TES <= "500" .And. !lInverteMov) .Or. (TES > "500" .And. lInverteMov)
									oSection3:Cell("nENTQtd"):Show()
									oSection3:Cell("nENTCus"):Show()

									oSection3:Cell("nENTQtd"):SetValue(QUANT)			
									oSection3:Cell("nENTCus"):SetValue(Round(CUSTOTAL,aTamT[2]))					            

									nCusto := 0
									If QUANT != 0
										nCusto := Round(CUSTOTAL,aTamT[2])/QUANT
										oSection3:Cell("nCusMov"):Show()
										oSection3:Cell("nCusMov"):SetValue(nCusto)		               
									Else
										oSection3:Cell("nCusMov"):Hide()
										oSection3:Cell("nCusMov"):SetValue(0)		               	    	        
									EndIf
									oSection3:Cell("nSAIQtd"):Hide()
									oSection3:Cell("nSAICus"):Hide()
									oSection3:Cell("nSAIQtd"):SetValue(0)			
									oSection3:Cell("nSAICus"):SetValue(0)							
								Else                
									nCusto := 0
									If QUANT != 0
										nCusto := Round(CUSTOTAL,aTamT[2])/QUANT
										oSection3:Cell("nCusMov"):Show()
										oSection3:Cell("nCusMov"):SetValue(nCusto)		               	        	       
									Else
										oSection3:Cell("nCusMov"):Hide()
										oSection3:Cell("nCusMov"):SetValue(0)		               	    	        
									EndIf

									oSection3:Cell("nSAIQtd"):Show()
									oSection3:Cell("nSAICus"):Show()
									oSection3:Cell("nSAIQtd"):SetValue(QUANT)			
									oSection3:Cell("nSAICus"):SetValue(Round(CUSTOTAL,aTamT[2]))										            

									oSection3:Cell("nENTQtd"):Hide()
									oSection3:Cell("nENTCus"):Hide()
									oSection3:Cell("nENTQtd"):SetValue(0)			
									oSection3:Cell("nENTCus"):SetValue(0)					            					
								EndIf

								If (TRB->TES > "500" .And. !lInverteMov) .Or. (TRB->TES <= "500" .And. lInverteMov)
									aSalAtu[1] -= QUANT
									aSalAtu[mv_par10+1] -= Round(CUSTOTAL,aTamT[2])  
									aSalAtu[7] -= ConvUm(SB1->B1_COD,QUANT,0,2)
								Else
									aSalAtu[1] += QUANT
									aSalAtu[mv_par10+1] += IIF(QUANT >0,( QUANT * nCusto ),Round(CUSTOTAL,aTamT[2]))
									aSalAtu[7] += ConvUm(SB1->B1_COD,QUANT,0,2)
								EndIf

								oSection3:Cell("nSALDQtd"):SetValue(aSalAtu[1])
								nSLDCosto := aSalAtu[mv_par10+1]
								If lShowZero .And. aSalAtu[1] == 0
									nSLDCosto := 0
								EndIf
								oSection3:Cell("nSALDCus"):SetValue(nSLDCosto)

								cMovto := ""

								If TRB->TES > "500" .And. ALLTRIM(TRB->TIPODOC) $ "REM|NF|FAC"
									cMovto := OemToAnsi(STR0030) //"CLI"
								ElseIf TRB->TES > "500" .And. ALLTRIM(TRB->TIPODOC) $ "RE0|DE0|RE8|DE8|RE3"
									cMovto := OemToAnsi(STR0032) //"CC"
								ElseIf TRB->TES <= "500" .And. ALLTRIM(TRB->TIPODOC) $ "RE6|DE6"
									cMovto := OemToAnsi(STR0034) //"MAN"
								ElseIf TRB->TES <= "500" .And. ALLTRIM(TRB->TIPODOC) $ "RE8|DE8|DE3"
									cMovto := OemToAnsi(STR0032) //"CC"
								ElseIf TRB->TES <= "500" .And. ALLTRIM(TRB->TIPODOC) $ "REM|NF|FAC"
									cMovto := OemToAnsi(STR0031) //"PROV"
								Else
									cMovto := OemToAnsi(STR0033) //"OP"
								EndIf

								oSection3:Cell("cCCPVPJOP"):SetValue(cMovto)				        	

								nRegImp++
								oSection3:PrintLine()
							EndIf
							dbSelectArea("TRB")
							dbSkip()
						EndDo
					EndIf	

					If nRegImp > 0

						oSection1:Finish()
						oSection2:Finish()
						oSection3:Finish()

						oReport:PrintText(STR0022+TransForm(aSalAtu[7],cPicB2Qt2),,oSection3:Cell('nSAICus'):ColPos()) //"QTD. NA SEGUNDA UM: "											      	
						oReport:ThinLine()		

						If lQuery
							SB1->(DbSkip())
						EndIf   
					Else
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Verifica se deve ou nao listar os produtos s/movimento ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If mv_par07 == 1
							If !lQuery
								dbSelectArea("TRB")
								oReport:PrintText(STR0023)   //"NAO HOUVE MOVIMENTACAO PARA ESTE PRODUTO"
								oReport:ThinLine()		
								oReport:SkipLine()		
							Else
								If TRB->PRODUTO <> SB1->B1_COD .And. SB1->B1_FILIAL==xFilial("SB1");
								.And. &cCond1 <= &cCond2 .And. !SB1->(eof()) .And.;
								(SB1->B1_TIPO >= mv_par03 .AND. SB1->B1_TIPO <= mv_par04)

									MTR901S12(aSalAtu,oSection1,oSection2,lQuery)

									oSection1:Finish()
									oSection2:Finish()

									oReport:PrintText(STR0023)   //"NAO HOUVE MOVIMENTACAO PARA ESTE PRODUTO"		         	
									oReport:ThinLine()		
									oReport:SkipLine()		
								EndIf
								SB1->(DbSkip())
							Endif
						EndIf
					EndIf
				EndDo

				dbSelectArea("SB1")
				DbClearFilter()
				dbSetOrder(1)

				dbSelectArea("TRB")
				dbCloseArea()

				If !lQuery
					Ferase(cNomeArq+GetDbExtension())	// Elimina arquivos de Trabalho
					Ferase(cNomeArq+OrdBagExt())		// Elimina arquivos de Trabalho
				EndIf

				If oTmpTable <> Nil
					oTmpTable:Delete()
					oTmpTable := Nil
				Endif
			EndIf

		Next nForFilial
	
	EndIf

	// Restaura Filial Corrente
	cFilAnt := cFilBack
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MTR901val³ Autor ³ Paulo Boschetti       ³ Data ³ 22.12.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Mtr901val()

	If mv_par09 > 0 .And. mv_par09 < 3
		Return .T.
	EndIf

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MTR901Cab³ Autor ³ Marcos Bregantim      ³ Data ³ 28.07.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cabecalho com dados do produto                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Mtr901Cab(ExpA1,ExpC1,ExpC2,ExpN1,ExpN2)                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpA1: Array com saldos do produto                         ³±±
±±³          ³ ExpC1: alias arq. trb.                                     ³±±
±±³          ³ ExpC2: picture (nao usado)                                 ³±±
±±³          ³ ExpN1: tam.usado em campos numericos                       ³±±
±±³          ³ ExpN2: incremento na coluna devido tam.do campo documento  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Mtr901Cab(aSalAtu,cAlias,cPicB2Cust,nTam,nIncCol)

	LOCAL nCusMed := 0
	LOCAL cPicD1Cust:= PesqPict("SD1","D1_CUSTO"+IIF(mv_par10 == 1 ,"",Str(mv_par10,1)),nTam,mv_par10)
	LOCAL aSalMov := {}
	LOCAL cSeek           
	LOCAL cProduto
	LOCAL i:=0
	LOCAL aSalAlmox:={},aArea:={}
	aSalAtu := {0,0,0,0,0,0,0}

	If !lQuery
		SB1->( MsSeek(xFilial("SB1")+TRB->PRODUTO) )
	EndIf
	cProduto	:=	SB1->B1_COD

	//Grava o Acumulado
	If lCusUnif
		aArea:=GetArea()
		aSalAtu  := { 0,0,0,0,0,0,0 }
		dbSelectArea("SB2")
		dbSetOrder(1)
		dbSeek(cSeek:=xFilial("SB2")+cProduto)
		While !Eof() .And. B2_FILIAL+B2_COD == cSeek
			aSalAlmox := CalcEst(cProduto,SB2->B2_LOCAL,mv_par05,,,( lCusRep .And. mv_par13==2 ))
			For i:=1 to Len(aSalAtu)
				aSalAtu[i] += aSalAlmox[i]
			Next i
			dbSkip()
		EndDo
		RestArea(aArea)
	Else
		aSalAtu   := CalcEst(cPRODUTO,mv_par08,mv_par05,,,( lCusRep .And. mv_par13==2 ))
	EndIf	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula o Custo de Reposicao do Produto        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lCusRep .And. mv_par13==2
		aSalAtu := {aSalAtu[1],aSalAtu[18],aSalAtu[19],aSalAtu[20],aSalAtu[21],aSalAtu[22],aSalAtu[07]}
	EndIf

	dbSelectArea("TRA")
	RecLock("TRA",.T.)
	Replace FILIAL    With xFilial("SB9")
	Replace COD       With SB1->B1_COD
	Replace LOCAL     With mv_par08
	Replace QINI      With aSalAtu[1]
	Replace QISEGUM   With ConvUm(COD,QINI,0,2)
	Replace VINI      With aSalAtu[2]
	If mv_par10 > 1
		Replace VINI   With Round(xMoeda(TRA->VINI,1,mv_par10,mv_par05,nDecs+1),nDecs)
	EndIf
	MsUnLock()

	dbSelectArea("TRB")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula o Saldo Inicial do Produto             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SB2->( dbSeek(xFilial("SB2")+cProduto) )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula o Custo Medio do Produto               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If aSalAtu[1] > 0
		nCusmed := Round(aSalAtu[mv_par10+1]/aSalAtu[1],nDecs)
	ElseIf aSalAtu[1] == 0 .And. aSalAtu[mv_par10+1] == 0
		nCusMed := 0
	Else
		nCusmed := &(Eval(bBloco,"SB2->B2_CM",mv_par10))
	EndIf

	@ Li,000 PSAY SB1->B1_COD
	@ Li,019 PSAY SubStr(SB1->B1_DESC,1,30)
	@ Li,056 PSAY STR0024+SB1->B1_UM		//"UM : "
	@ Li,068 PSAY STR0025+SB1->B1_TIPO		//"TIPO : "
	@ Li,083 PSAY STR0026+SB1->B1_GRUPO		//"GRUPO : "
	If lCusRep
		@ Li,115+nIncCol PSAY STR0069          	//"Custo Reposição : "
	Else
		@ Li,115+nIncCol PSAY STR0027          	//"Custo Medio : "
	EndIf	

	@ Li,132+nIncCol PSAY nCusMed		         Picture cPicD1Cust
	@ Li,157+nIncCol PSAY aSalAtu[1]    	     Picture PesqPictQt("B2_QATU" ,nTam)
	@ Li,182+nIncCol PSAY aSalAtu[mv_par10+1] 	 Picture cPicD1Cust

	Li++
	@ Li,000 PSAY STR0028+SUBS(SB1->B1_POSIPI,1,4)+"."+SUBS(SB1->B1_POSIPI,5,4)+"."+SUBS(SB1->B1_POSIPI,9,2)    //"Posicao IPI : "
	@ Li,035 PSAY STR0029+SB2->B2_LOCALIZ     //"Localizacao : "
	Li += 2
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MTR901Dev³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 17/07/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Avalia se item pertence a uma nota de devolu‡ao             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR901                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MTR901Dev()
	LOCAL cAlias:=Alias(),lRet:=.F.

	If cAlias == "SD1"
		dbSelectArea("SF1")
		dbSeek(cFilial+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA)
		If SF1->F1_TIPO == "D"
			lRet:=.T.
		EndIf
	ElseIf cAlias == "SD2"
		dbSelectArea("SF2")
		dbSeek(cFilial+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA)
		If SF2->F2_TIPO == "D"
			lRet:=.T.
		EndIf
	EndIf
	dbSelectArea(cAlias)
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MTR901VAlm ³ Autor ³ Lucas                 ³ Data ³19/02/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Valida Almoxarifado do KARDEX com relacao a custo unificado ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR901                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MTR901VAlm
	LOCAL lRet:=.T.
	LOCAL cConteudo:=&(ReadVar())
	LOCAL nOpc:=2
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³MV_CUSFIL - Parametro utilizado para verificar se o sistema   |
	//|utiliza custo unificado por:                                  |
	//|      F = Custo Unificado por Filial                          |
	//|      E = Custo Unificado por Empresa                         |
	//|      A = Custo Unificado por Armazem                         |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local lCusFil    := AllTrim(SuperGetMV('MV_CUSFIL' ,.F.,"A")) == "F"
	Local lCusEmp    := AllTrim(SuperGetMv('MV_CUSFIL' ,.F.,"A")) == "E"
	
	If (lCusFil .And. cConteudo != Repl("*",TamSX3("B2_LOCAL")[1])) .or. (lCusEmp .And. cConteudo != Repl("#",TamSX3("B2_LOCAL")[1]))
		nOpc := Aviso(STR0035,STR0036,{STR0037,STR0038})	//"Aten‡„o"###"Ao alterar o almoxarifado o custo medio unificado sera desconsiderado."###"Confirma"###"Abandona"
		If nOpc == 2
			lRet:=.F.
		EndIf
	EndIf
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MTR901S12 ³ Autor ³ Nereu Humberto Junior ³ Data ³ 18.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cabecalho com dados do produto                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MTR901S12(aSalAtu,oSection1,oSection2,lQuery)

	LOCAL nCusMed := 0
	LOCAL aSalMov := {}
	LOCAL cSeek           
	LOCAL cProduto
	LOCAL i:=0
	Local cFilBkp   := cFilAnt
	LOCAL aSalAlmox:={},aArea:={}
	Local nIndice	:= 0
	Local cTrbSB2	:= GetNextAlias()
	aSalAtu := {0,0,0,0,0,0,0}

	If !lQuery
		SB1->( MsSeek(xFilial("SB1")+TRB->PRODUTO) )
	EndIf
	cProduto	:=	SB1->B1_COD

	//Grava o Acumulado
	If lCusFil
		aArea:=GetArea()
		aSalAtu  := { 0,0,0,0,0,0,0 }
		dbSelectArea("SB2")
		dbSetOrder(1)
		dbSeek(cSeek:=xFilial("SB2")+cProduto)
		While !Eof() .And. B2_FILIAL+B2_COD == cSeek
			aSalAlmox := CalcEst(cProduto,SB2->B2_LOCAL,mv_par05,,,( lCusRep .And. mv_par13==2 ))
			For i:=1 to Len(aSalAtu)
				aSalAtu[i] += aSalAlmox[i]
			Next i
			dbSkip()
		EndDo
		RestArea(aArea)
	ElseIf lCusEmp
		aArea:=GetArea()
		aSalAtu  := { 0,0,0,0,0,0,0 }
		dbSelectArea("SB2")
		dbSetOrder(1)
		INDREGUA("SB2",cTrbSB2,"B2_COD+B2_LOCAL",,,"")
		nIndice := RetIndex("SB2")
		dbSetOrder(nIndice+1)
		MsSeek(cSeek:=cProduto)
		While !Eof() .And. SB2->B2_COD == cSeek
			If !Empty(xFilial("SB2"))
				cFilAnt:=SB2->B2_FILIAL
			EndIf
			aSalAlmox := CalcEst(cProduto,SB2->B2_LOCAL,mv_par05,,,( lCusRep .And. mv_par13==2 ))
			For i:=1 to Len(aSalAtu)
				aSalAtu[i] += aSalAlmox[i]
			Next i
			dbSkip()
		End
		dbSelectArea("SB2")
		If !Empty(cTrbSB2)
			RetIndex("SB2")
			Ferase(cTrbSB2+OrdBagExt())
		EndIf
		cFilAnt := cFilBkp
		RestArea(aArea)
	Else
		aSalAtu   := CalcEst(cPRODUTO,mv_par08,mv_par05,,,( lCusRep .And. mv_par13==2 ))
	EndIf	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula o Custo de Reposicao do Produto        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lCusRep .And. mv_par13==2
		aSalAtu := {aSalAtu[1],aSalAtu[18],aSalAtu[19],aSalAtu[20],aSalAtu[21],aSalAtu[22],aSalAtu[07]}
	EndIf

	dbSelectArea("TRB")
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula o Saldo Inicial do Produto             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(TRB->ARMAZEM)
		SB2->( dbSeek(xFilial("SB2")+cProduto+TRB->ARMAZEM) )
	else
		SB2->( dbSeek(xFilial("SB2")+cProduto) )
	EndIf	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula o Custo Medio do Produto               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If aSalAtu[1] > 0
		nCusmed := Round(aSalAtu[mv_par10+1]/aSalAtu[1],nDecs)
	ElseIf aSalAtu[1] == 0 .And. aSalAtu[mv_par10+1] == 0
		nCusMed := 0
	Else
		nCusmed := &(Eval(bBloco,"SB2->B2_CM",mv_par10))
	EndIf

	oSection1:Init()
	oSection2:Init()

	If lCusRep
		oSection1:Cell("nCusMed"):SetTitle(UPPER(STR0069))
	EndIf

	oSection1:Cell("nCusMed"):SetValue(nCusMed)			
	oSection1:Cell("nQtdSal"):SetValue(aSalAtu[1])
	oSection1:Cell("nVlrSal"):SetValue(aSalAtu[mv_par10+1])

	oSection1:PrintLine()
	oSection2:PrintLine()

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MTR901NFExp ³ Autor ³Lucas				 ³ Data ³18/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Carrega arquivo TRB com resultado da Query                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR901                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MTR901FillTrb(aCampos)

	Local aOrdem := {}
	
	//Creacion de Objeto
	oTmpTable := FWTemporaryTable():New("TRB")
	oTmpTable:SetFields( aCampos )

	If mv_par11 == 1
		aOrdem := {"PRODUTO","EMISSAO","NUMSEQ","TES"}
	Else
		aOrdem := {"PRODUTO","SEQCALC","TES"}
	Endif

	oTmpTable:AddIndex("I1", aOrdem)

	//Creacion de la tabla
	oTmpTable:Create()

	DbSelectArea("TRC")
	TRC->(DbGoTop())
	While !Eof()
		DbSelectArea("TRB")
		Reclock("TRB",.T.)
		Replace 	PRODUTO 	With	TRC->PRODUTO
		Replace 	EMISSAO 	With	TRC->EMISSAO
		Replace 	SEQCALC 	With	TRC->SEQCALC
		Replace 	NUMSEQ 		With	TRC->NUMSEQ
		Replace 	TES 		With	TRC->TES
		Replace 	CF 			With	TRC->CF
		Replace 	TIPODOC 	With	If(AllTrim(TRC->TIPODOC) $ "FT|NF","FAC",TRC->TIPODOC)
		Replace 	NUMDOC 		With	TRC->NUMDOC
		Replace 	SERIE 		With	TRC->SERIE
		Replace 	QUANT 		With	TRC->QUANT
		Replace 	CUSTOTAL 	With	TRC->CUSTOTAL
		Replace 	CLIFOR	 	With	TRC->CLIFOR
		Replace 	LOJA		With	TRC->LOJA
		Replace 	ARMAZEM	With	TRC->ARMAZEM
		MsUnLock()
		DbSelectArea("TRC")
		DbSkip()
	EndDo
	
Return
