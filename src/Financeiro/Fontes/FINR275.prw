/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR275.ch"
#Include "PROTHEUS.CH"

Static lFWCodFil := FindFunction("FWCodFil")

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR275  ³ Autor ³ Paulo Augusto           ³ Data ³ 12.06.06   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Resumo de Cliente                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ FECHA  ³   BOPS  ³  MOTIVO DE LA ALTERACION                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   Marco A.   ³08/12/16³SERINN001³ Se aplica CTREE para evitar la creacion ³±±
±±³              ³        ³-136     ³ de tablas temporales de manera fisica   ³±±
±±³              ³        ³         ³ en system. (ARG)                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function FINR275()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Parametros:                                ³
	//³ mv_par01	// Data Inicial ?              ³
	//³ mv_par02	// Data Final ?                ³
	//³ mv_par03	// De Filial     ?             ³
	//³ mv_par04	// Ate Filial  ?               ³
	//³ mv_par05	// Quebra por Filial?          ³
	//³ mv_par06	// Qual Moedas                 ³
	//³ mv_par07	// Outras Moedas?              ³
	//³ mv_par08	// Imprime por?                ³
	//³ mv_par09	// Valor minimo de impressao?" ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	Local cCabec1	:= Space( 0 )
	Local cCabec2	:= Space( 0 )
	Local cDesc1	:= Space( 0 )
	Local cDesc2	:= Space( 0 )
	Local cDesc3	:= Space( 0 )
	Local nLimite	:= 220              
	Local aOrdem	:= {}            
	Local lEnd		:= .T.
	Local cPerg		:= PADR( "FIR275", 6 )
	Local cNRel		:= ""

	Private cNomeProg	:= "FINR275"        // nome do programa
	Private cTitulo		:= ""
	Private cTamanho	:= "G"               
	Private aReturn		:= {OemToAnsi(STR0001),1,OemToAnsi(STR0002),1, 1,1,"",1}    //"Zebrado"###"Administracao"
	Private m_pag		:= 1
	Private nLastKey	:= 0  // Controla o cancelamento da SetPrint e SetDefault

	cNRel  := cNomeProg

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas, busca o padrao da Nfiscal   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nLastKey == 27
		Return
	EndIf

	Pergunte("FIR275",.F.)

	cTitulo   := STR0003 //"Resumo de clientes que pagaram em dinheiro"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Envia control para funcion SETPRINT  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cNRel := SetPrint( "SE1", cNRel, cPerg, cTitulo, cDesc1, ;
	cDesc2, cDesc3, .F., aOrdem, .T., ;
	cTamanho, .T., .f. )

	If nLastKey == 27
		Return Nil
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica Posicion del Formulario en la Impresora  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SetDefault( aReturn, "SE1" )

	If nLastKey == 27
		SET PRINTER TO
		SET PRINT OFF
		Return
	EndIf

	Private lProc  := .f.

	RptStatus( { ||Fir275Imp() } )

	SET PRINTER TO

	If aReturn[5] == 1
		SET PRINTER TO
		DbCommitAll()
		OurSpool(cNRel)
	EndIf

	Ms_Flush()

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Fir275Imp ³ Autor ³   Paulo Augusto       ³ Data ³ 12/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina de Impressao                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Fir275Imp()

	Local nLine		:= 60
	Local nCredCli	:= 0
	Local nValorRec	:= 0
	Local nNumTit	:= 0
	Local nMumTitF	:= 0
	Local nTotMO	:= 0
	Local nRecno	:= 0
	Local aFields	:= Array( 0 )
	Local cDbfTmp	:= ""
	Local cNtxTmp	:= ""
	Local nPosTp	:= 0
	Local nSigno	:= IIf (MV_PAR08 == 3, -1,1)  
	Local cFil		:= ""   
	Local nTotFil	:= 0  
	Local cCredInm	:= If(SES->(FieldPos("ES_RCOPGER")) > 0, GetSESTipos({|| ES_RCOPGER == "2"},"1"), "" )
	Local cFilAnt	:= ""
	Local aEmp		:= {}
	Local lGestao	:= IIf( lFWCodFil, FWSizeFilial() > 2, .F. )	// Indica se usa Gestao Corporativa
	Local aOrdem1	:= {}
	Local aOrdem2	:= {}
	Local aOrdem3	:= {}

	Private nDecs		:= MsDecimais(mv_par06)
	Private oTmpTable	:= Nil

	cCredInm :=	IIf(Empty(cCredInm), "TF /EF ", cCredInm)

	aAdd( aFields, {"FILSIS"	, "C", IIf( lFWCodFil, FWGETTAMFILIAL, 2 ), 0 } )
	aAdd( aFields, {"CODCLI"	, "C", TamSX3('A1_COD'	)[1], 0 } )
	aAdd( aFields, {"LOJCLI"	, "C", TamSX3('A1_LOJA'	)[1], 0 } )
	aAdd( aFields, {"NOME"		, "C", TamSX3('A1_NOME'	)[1], 0 } )
	aAdd( aFields, {"CGC"		, "C", TamSX3('A1_CGC'	)[1], 0 } )
	aAdd( aFields, {"ENDERECO"	, "C", TamSX3('A1_END'	)[1], 0 } )
	aAdd( aFields, {"MUNICIPIO"	, "C", TamSX3('A1_MUN'	)[1], 0 } )    						
	aAdd( aFields, {"ESTADO"	, "C", TamSX3('A1_EST'	)[1], 0 } )
	aAdd( aFields, {"NUMPAGTOS"	, "N", 5, 0 } )
	aAdd( aFields, {"VALOR"		, "N", TamSX3('E1_VLCRUZ')[1], TamSX3('E1_VLCRUZ')[2]})
	
	aOrdem1 := {"FILSIS", "CODCLI", "LOJCLI"}
	aOrdem2 := {"FILSIS", "NOME"}
	aOrdem3	:= {"VALOR"}
	
	If !Empty( Select("TRB"))
		DbSelectArea("TRB")
		DbCloseArea()
	EndIf
		
	oTmpTable := FWTemporaryTable():New("TRB")
	oTmpTable:SetFields(aFields)
	oTmpTable:AddIndex("IN1", aOrdem1)
	oTmpTable:AddIndex("IN2", aOrdem2)
	oTmpTable:AddIndex("IN3", aOrdem3)
	
	oTmpTable:Create()

	DbSelectArea("SA1")
	DbSetOrder(1)

	DbSelectArea("SE5")
	DbSetOrder(6) // por data  
	If !Empty(xFilial("SE5") )
		SE5->(DbSeek(mv_par03+Dtos(mv_par01),.T.))
	Else
		SE5->(DbSeek(xFilial("SE5")+Dtos(mv_par01),.T.))
	Endif
	
	aEmp	:= SM0->(GetArea())
	cFilAnt	:= SE5->E5_FILIAL
	aEmp	:= SM0->(GetArea())
	
	SetRegua(RecCount())
	While !SE5->(EoF()) .AND. SE5->E5_FILIAL >= mv_par03 .And.SE5->E5_FILIAL <= mv_par04  

		If !Empty(xFilial( "SE5" ) ) .And. cFilAnt <> SE5->E5_FILIAL
			SM0->(DbSkip())	   
		EndIf

		If SE5->E5_DTDIGIT >= mv_par01 .And. SE5->E5_DTDIGIT <= mv_par02 
			If mv_par05 == 1//Por Filial
				cChave := " SE5->E5_FILIAL + SE5->E5_CLIfor + SE5->E5_LOJA "
			Else
				cChave := '"  " + SE5->E5_CLIfor + SE5->E5_LOJA '
			EndIf
			DbSelectArea("TRB")
			DBSetOrder(1)
			If !DbSeek(&cChave)
				If Empty( IIf( lGestao, FWFilial("SA1"), xFilial( "SA1" ) ) )
					SA1->(DbSeek( xFilial( "SA1" ) + SE5->E5_CLIFOR + SE5->E5_LOJA ))
				Else
					SA1->(DbSeek( IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL ) + SE5->E5_CLIFOR + SE5->E5_LOJA ))
				EndIf	
				TRB->( DbAppend() ) 
				If mv_par05 == 1
					TRB->FILSIS		:= SE5->E5_FILIAL
				Else
					TRB->FILSIS		:= "  "	
				End		
				TRB->CODCLI	:= SA1->A1_COD 
				TRB->LOJCLI	:= SA1->A1_LOJA
				TRB->NOME	:= SA1->A1_NOME

				TRB->CGC		:= SA1->A1_CGC
				TRB->ENDERECO	:= SA1->A1_END
				TRB->MUNICIPIO	:= SA1->A1_MUN     						
				TRB->ESTADO		:= SA1->A1_EST    
			Else
				RecLock("TRB",.F.)
			EndIF
			If (mv_par07 == 2 .AND. mv_par06 == Val(SE5->E5_MOEDA) ) .Or. mv_par07 == 1	
				If SE5->E5_TIPODOC $ "VL" .And. SE5->E5_RECPAG == "R" .And. Empty(SE5->E5_ORDREC)  .or.;
				SE5->E5_TIPO $ cCredInm  .And. SE5->E5_RECPAG == "R" .And. !Empty(SE5->E5_ORDREC)

					TRB->VALOR	:=  TRB->VALOR +( Round(xMoeda(SE5->E5_VALOR,Val(SE5->E5_MOEDA),mv_par06,SE5->E5_DATA,nDecs+1),nDecs)* nSigno)
					TRB->NUMPAGTOS:= TRB->NUMPAGTOS +1
				EndIf
			EndIf
			MsUnlock()
		EndIf
		cFilAnt := SE5->E5_FILIAL
		SE5->(DbSkip())
		IncRegua()
	EndDo                

	SM0->(RestArea(aEmp))
	DbSelectArea( "TRB" )

	If mv_par08 == 1
		DBSetOrder(2)
	ElseIf mv_par08 == 2
		DBSetOrder(1)
	Else
		DBSetOrder(3)
	EndIf

	SetRegua( RecCount() )
	DbGoTop()

	nLine	:= 60
	cFil	:= FILSIS	
	
	While !EoF()
		If Abs(VALOR) >= mv_par09 
			nValorRec	:= nValorRec + VALOR
			nTotFil		:= nTotFil + VALOR
			nNumTit		:= nNumTit + NUMPAGTOS
			nMumTitF	:= nMumTitF + NUMPAGTOS 
			If nLine >= 60
				Fir275Cab(@lProc,@nLine)
			EndIf
			Fir275It(@nLine)
		EndIF	

		cFil:= FILSIS	
		DbSkip()

		If cFil <> FILSIS	.AND. Abs(nTotFil) >= mv_par09 
			If nLine >= 60
				Fir275Cab(@lProc,@nLine)
			EndIf
			Fir275Tot(@nLine,cFil,nTotFil,nMumTitF)
			nTotFil	:= 0
			nMumTitF:= 0
		EndIf    

		IncRegua()
	EndDo

	If nLine >= 60
		Fir275Cab(@lProc,@nLine)
	EndIf
	Fir275TotG(@nLine,@nNumTit,@nValorRec)

	If oTmpTable <> Nil
		oTmpTable:Delete()
		oTmpTable := Nil
	EndIf

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Fir275Cab ³ Autor ³   Paulo Augusto       ³ Data ³ 12/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do cabecalho                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Fir275Cab(lProc,nLine)
	
	Local cCabec1 := ""
	Local cCabec2 := ""
	
	cTitulo   :=	STR0004 + GETMV("MV_SIMB"+ Alltrim(Str(MV_PAR06))) + " " +Alltrim(Str(MV_PAR09)) +;
	 				STR0005 +  dtoc(mv_par01) + STR0006  +  dtoc(mv_par02) //"Resumo de clientes que pagaram mais de "###" em dinheiro no periodo de: "###" ate "

	If !lProc
		lProc := .t.
	EndIf

	cCabec1 :=  STR0007 //"Codigo    Razao Social                                           RFC               Endereco                                             Municipio                  Estado         No. Pagtos        Total Pago"
	cCabec2 := ""

	Cabec(cTitulo, cCabec1, Ccabec2, cNomeProg, cTamanho, 18)
	nLine := 09 

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Fir275It  ³ Autor ³   Paulo Augusto       ³ Data ³ 12/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao dos Itens                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Fir275It(nLine)

	@ nLine, 00		PSAY CODCLI
	@ nLine, 11		PSAY NOME
	@ nLine, 66		PSAY CGC Picture PesqPict('SA1','A1_CGC')
	@ nLine, 85		PSAY ENDERECO
	@ nLine, 135	PSAY MUNICIPIO 
	@ nLine, 165	PSAY ESTADO
	@ nLine, 181	PSAY NUMPAGTOS  Picture TM(NUMPAGTOS,5,0)
	@ nLine, 191	PSAY Abs(VALOR) Picture TM(VALOR,16,nDecs)

	nLine := nLine + 1

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Fir275TotG³ Autor ³   Paulo Augusto       ³ Data ³ 12/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do total Geral                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Fir275TotG(nLine, nNumTit, nVlCli)

	nLine := nLine + 1
	@ nLine,  00 PSAY STR0008  //"Total de Pagamentos:"
	@ nLine, 180 PSAY  Abs(nNumTit) Picture TM(nNumTit,5,0)
	@ nLine, 190 PSAY  Abs(nVlCli) Picture TM(nVlCli,16,nDecs)

	nLine := nLine + 1

	@ nLine,  00 PSAY Replicate( ".", 220 )
	nLine := nLine + 2

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Fir275Tot ³ Autor ³   Paulo Augusto       ³ Data ³ 12/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do total por filial                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Fir275Tot(nLine, cFil, nTotFil, nMumTitF)

	@ nLine,  00 PSAY Replicate( ".", 220 )
	nLine := nLine + 1
	@ nLine,  00 PSAY STR0009 + cFil  //"Total da Filial: "
	@ nLine, 180 PSAY nMumTitF PICTURE TM(nMumTitF,5,0)
	@ nLine, 190 PSAY Abs(nTotFil) PICTURE TM(nTotFil,16,nDecs) //"99,999,999.99"

	nLine := nLine + 1
	@ nLine,  00 PSAY Replicate( "-", 220 )
	nLine := nLine + 1

Return Nil
