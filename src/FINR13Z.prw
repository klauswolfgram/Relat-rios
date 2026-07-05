/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "protheus.ch"        // incluido por el asistente de conversión del AP5 IDE en 01/06/00
#INCLUDE "finr13z.ch"
#INCLUDE "RPTDEF.CH"

#DEFINE BOTTOMPAGE 60

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR13Z  ³ Autor ³ Bruno Sobieski        ³ Data ³ 01.03.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cuenta corriente de proveedor.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³             ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Programador³ DATA    ³ BOPS      ³                  ALTERACAO         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   Bruno    ³09.05.00 ³  Melhor   ³Considerar data de digitacao no     ³±±
±±³            ³         ³           ³parametros.                         ³±±
±±³   Rubens   ³07.03.01 ³  Melhor   ³Aumento dos campos numericos do     ³±±
±±³            ³         ³           ³arquivo temp. e da mascara na s     ³±±
±±³            ³         ³           ³impressao dos valore                ³±±
±±³   Rubens   ³20/04/01 ³  Melhor   ³Considera tambem as baixas manuais, ³±±
±±³            ³         ³           ³juros, multas e descontos.          ³±±
±±³  Marco A.  ³07/12/16 ³ SERINN001-³Se aplica CTREE para evitar la      ³±±
±±³            ³         ³ 132       ³creacion de tablas temporales de    ³±±
±±³            ³         ³           ³manera fisica en system.            ³±±
±±³L. Samaniego³01/03/18 ³DMICNS-1270³Replica de DMIMIX-827. Argentina.   ³±±
±±³            ³         ³           ³Se corrige error 'variable does not |±±
±±³            ³         ³           ³exist EK_TXMOE01'.                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Finr13Z()	// incluido pelo assistente de conversao do AP5 IDE em 09/09/99

	Local oReport	:= Nil

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport	:= ReportDef()
	oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Paulo Augusto       º Data ³  21/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tratamanto release 04                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

	Local oReport	:= Nil
	Local oSection1	:= Nil
	Local oSection2	:= Nil
	Local cReport	:= "FINR13Z"
	Local cTitulo	:= OemToAnsi(STR0003) // "Informe de Pagos"
	Local cDescri	:= OemToAnsi(STR0003) // "Informe de Pagos"

	oReport  := TReport():New( cReport, cTitulo, "FIR13Z" , {|oReport| ReportPrint(oReport, "SE2" )}, cDescri)

	oSection1 := TRSection():New(oReport,STR0043, {"SA2"},)//'Fornecedores'

	TRCell():New(oSection1, "A2_COD" 	, "SA2", /*X3Titulo*/, /*Picture*/, TamSX3("A2_COD")[1]+TamSx3("A2_LOJA")[1]+2, /*lPixel*/,)
	TRCell():New(oSection1, "A2_NOME"	, "SA2", /*X3Titulo*/, /*Picture*/, /*Tamanho*/, /*lPixel*/,)
	TrPosition():New(oSection1, 'SA2', 1, {|| xFilial('SA2')+TRB->CODPRO+TRB->LOJA} )

	oSection2 := TRSection():New(oSection1,STR0044,) //'Movimentos'
	TRCell():New(oSection2, "E2_TIPO"	, "SE2", /*X3Titulo*/, /*Picture*/, /*Tamanho*/, /*lPixel*/,)
	TRCell():New(oSection2, "E2_NUM"	, "SE2", /*X3Titulo*/, /*Picture*/, TamSx3("E2_PREFIXO")[1]+TamSx3("E2_NUM")[1]+TamSx3("E2_PARCELA")[1]+10, /*lPixel*/,{||  TRB->SERIE+Trans(TRB->NRODOC,"@R /999999999999")+" "+TRB->PARCELA})	
	If cPaisLoc == "PTG"
		TRCell():New(oSection2, "NODIA"	, "TRB", STR0046, /*Picture*/, 10, /*lPixel*/,)//"Diario CTB"
	Endif
	TRCell():New(oSection2,"E2_EMISSAO"	, "SE2", /*X3Titulo*/, /*Picture*/, 10, /*lPixel*/,)
	TRCell():New(oSection2,"E2_EMIS1"	, "SE2", OemToAnsi(STR0036)+ CHR(13)+CHR(10) + OemToAnsi(STR0037), /*Picture*/, 13,/*lPixel*/,) //"Fch. " - "Registro"
	TRCell():New(oSection2,"E2_VENCREA"	, "SE2", OemToAnsi(STR0036) + CHR(13)+CHR(10) + OemToAnsi(STR0038), /*Picture*/, /*Tamanho*/, /*lPixel*/,) //"Fch. " - "Vencto"
	TRCell():New(oSection2,"DEBITO"		, "   ", OemToAnsi(STR0039), PesqPict("SE2","E2_VALOR"), GetSX3Cache("E2_VALOR","X3_TAMANHO")+GetSX3Cache("E2_VALOR","X3_DECIMAL"), /*lPixel*/,) //"Debitos "
	TRCell():New(oSection2,"CREDITO"	, "   ", OemToAnsi(STR0040), PesqPict("SE2","E2_VALOR"), GetSX3Cache("E2_VALOR","X3_TAMANHO")+GetSX3Cache("E2_VALOR","X3_DECIMAL"), /*lPixel*/,) //"Creditos "
	TRCell():New(oSection2,"SALDO"		, "   ", OemToAnsi(STR0041) +  CHR(13)+CHR(10) + OemToAnsi(STR0042), PesqPict("SE2","E2_VALOR"), 13, /*lPixel*/,) //"  Saldo" - "Acumulado"


Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Paulo Augusto       º Data ³  21/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina de impressao                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )

	Local oSection1	:= oReport:Section(1)
	Local oSection2	:= oSection1:Section(1)
	Local lAgregSEK	:= .F.
	Local cLoja		:= ""
	Local nTaxa		:= 0
	Local cFiltro	:= oSection1:GetAdvPlExp('SA2')
	Local nMoeda	:= IIf(Empty(mv_par12), 1, mv_par12)
	Local dData		:= Nil
	Local aOrdem1	:= {}
	Local aOrdem2	:= {}
	Local aOrdem3	:= {}
	Local aOrdem4	:= {}
	Local aOrdem5	:= {}
	Local aOrdem6	:= {}
	Local nValRet   := 0
	Local nVRetAsum   := 0
	
	Private nDecs		:= MsDecimais(1)
	Private oTmpTable	:= Nil

	If !Empty(oReport:uParam)
		Pergunte(oReport:uParam, .F.)
	EndIf
	oReport:SetTitle(OemToAnsi(STR0003) + OemToAnsi(STR0045) + GetMv("MV_MOEDA"+LTrim(Str(MV_PAR12)))) //"Estado de CTAS por PAGAR" - " - En "

	aTipDoc    := { { "FT ", "FT" }, { "NF ", "FT" }, { "NCP", "NC" }, { "NDP", "ND" } }
	cCodPro    := Space( 0 )
	cProveedor := Space( 0 )
	cTelef     := Space( 0 )
	cContact   := Space( 0 )
	nDebPro    := 0
	nCredPro   := 0
	nSalAC     := 0
	nSalMO     := 0
	nTotDeb    := 0
	nTotCred   := 0
	nTotMO     := 0
	aFields    := Array( 0 )

	AAdd(aFields, {"CODPRO"		, "C",  TamSx3('E2_FORNECE')[1], 0})
	AAdd(aFields, {"LOJA"		, "C", 	TamSx3('E2_LOJA')[1], 0})
	AAdd(aFields, {"PROVEEDOR"	, "C", 40, 0 } )
	AAdd(aFields, {"TIPODOC"	, "C",  3, 0 } )
	AAdd(aFields, {"SERIE"		, "C",  TamSx3('E2_PREFIXO')[1], 0})
	AAdd(aFields, {"NRODOC"		, "C",  13,0 } )
	AAdd(aFields, {"PARCELA"	, "C",  TamSx3('E2_PARCELA')[1], 0})
	AAdd(aFields, {"FECHA"		, "D",  8, 0 })
	AAdd(aFields, {"FECVTO"		, "D",  8, 0 })
	AAdd(aFields, {"FECREG"		, "D",  8, 0 })
	AAdd(aFields, {"DEBITO"		, "N", GetSX3Cache("E2_VALOR","X3_TAMANHO"), GetSX3Cache("E2_VALOR","X3_DECIMAL") })
	AAdd(aFields, {"CREDITO"	, "N", GetSX3Cache("E2_VALOR","X3_TAMANHO"), GetSX3Cache("E2_VALOR","X3_DECIMAL") })
	AAdd(aFields, {"SALDO"		, "N", 15, 2 })
	AAdd(aFields, {"TIPSAL"		, "C",  1, 2 })
	AAdd(aFields, {"TELEFONOS"	, "C", 40, 0 })
	AAdd(aFields, {"CONTACTO"	, "C", 40, 0 })
	AAdd(aFields, {"NODIA"		, "C", 10, 0 })
	
	
	aOrdem1 := {"CODPRO"	, "TIPODOC"	, "SERIE"	, "NRODOC"}
	aOrdem2 := {"CODPRO"	, "FECHA"	, "TIPODOC"	, "SERIE", "NRODOC"}
	aOrdem3 := {"CODPRO"	, "FECVTO"	, "TIPODOC"	, "SERIE", "NRODOC"}
	aOrdem4 := {"PROVEEDOR"	, "FECHA"	, "TIPODOC"	, "SERIE", "NRODOC"}
	aOrdem5 := {"PROVEEDOR"	, "FECVTO"	, "TIPODOC"	, "SERIE", "NRODOC"}
	aOrdem6 := {"PROVEEDOR"	, "FECREG"	, "TIPODOC"	, "SERIE", "NRODOC"}
	
	If !Empty( Select( "TRB" ) )
		DbSelectArea( "TRB" )
		DbCloseArea()
	EndIf
	
	oTmpTable := FWTemporaryTable():New("TRB")
	oTmpTable:SetFields(aFields)
	oTmpTable:AddIndex("I1", aOrdem1)
	oTmpTable:AddIndex("I2", aOrdem2)
	oTmpTable:AddIndex("I3", aOrdem3)
	oTmpTable:AddIndex("I4", aOrdem4)
	oTmpTable:AddIndex("I5", aOrdem5)
	oTmpTable:AddIndex("I6", aOrdem6)
	
	oTmpTable:Create()

	SE5->(DbSetOrder(7)) //E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ
	DbSelectArea( "SA2" )
	DbSetOrder( 1 ) //A2_FILIAL+A2_COD+A2_LOJA

	DbSelectArea( "SE2" )
	DbSetOrder( 6 ) //E2_FILIAL+E2_FORNECE+E2_LOJA+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO

	If mv_par08 == 2
		oSection1:SetPageBreak()
	endif

	If !Empty( mv_par01 )
		DbSeek( xFilial( "SE2" ) + mv_par01 , .t. )
	Else
		DbSeek(xFilial())
	EndIf
	
	While !EoF() .And. E2_FILIAL == xFilial() .And. E2_FORNECE <= mv_par02

		DbSelectArea( "SA2" )
		DbSeek( xFilial( "SA2" ) + SE2->E2_FORNECE + SE2->E2_LOJA )
		If !Empty(cFiltro) .And. !(&(cFiltro))
			DbSelectArea( "SE2" )
			DbSkip()
			Loop
		Endif

		DbSelectArea( "SE2" )

	If  (cPaisLoc <> "BRA" .And. SE2->E2_CONVERT == 'N' .And. MV_PAR12 <> SE2->E2_MOEDA) .Or. ( mv_par10 == 2 .And. E2_SALDO = 0 )
			dbSkip()
			Loop
		Endif
		If Alltrim( E2_TIPO) $ "TF^CH^PA".OR. E2_EMISSAO > dDataBase
			DbSkip()
			Loop
		Endif

		cCodPro		:= SA2->A2_COD
		cProveedor	:= SA2->A2_NOME
		cTelef		:= SA2->A2_TEL
		cContact	:= SA2->A2_CONTATO

		If ( mv_par06 ==1  .And. E2_EMISSAO < mv_par03 ) .OR.;
		( mv_par06 == 2 .And. E2_VENCREA < mv_par03 ) .Or.;
		( mv_par06 == 3 .And. E2_EMIS1   < mv_par03 )

			DbSelectArea("TRB")
			DBSetOrder(1) //CODPRO + TIPODOC + SERIE + NRODOC
			If !DbSeek( SE2->E2_FORNECE+"SA")

				TRB->( DbAppend() )
				TRB->CODPRO    := cCodPro
				TRB->LOJA      := SA2->A2_LOJA
				TRB->PROVEEDOR := cProveedor
				TRB->TELEFONOS := cTelef
				TRB->CONTACTO  := cContact
				TRB->TIPODOC   := "SA"
				TRB->FECHA     := mv_par03 - 1

			EndIf
			DbSelectArea( "SE2" )
			nTaxa := IIf(MV_PAR11 == 2,IIf(SE2->E2_TXMOEDA>0,SE2->E2_TXMOEDA,RecMoeda(SE2->E2_EMISSAO,SE2->E2_MOEDA)),0)
			dData := IIf(MV_PAR11 == 1, dDataBase, SE2->E2_EMISSAO )
			If E2_TIPO $ MV_CPNEG .OR. SubStr( E2_TIPO, 3, 1 ) == "-"
				TRB->CREDITO   := TRB->CREDITO + xMoeda(E2_VALOR,SE2->E2_MOEDA,nMoeda,dData,, nTaxa )
				TRB->SALDO     := TRB->SALDO - xMoeda(E2_SALDO,SE2->E2_MOEDA,nMoeda,dData,, nTaxa )
			Else
				TRB->DEBITO    := TRB->DEBITO  + xMoeda(E2_VALOR,SE2->E2_MOEDA,nMoeda,dData,, nTaxa )
				TRB->SALDO     := TRB->SALDO + xMoeda(E2_SALDO,SE2->E2_MOEDA,nMoeda,dData,, nTaxa )
			EndIf
			LeBaixaMCompra(SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA))
			DbSelectArea( "SE2" )
		Else
			If (mv_par06 == 1 .And. E2_EMISSAO <= mv_par04 ) .OR. ;
				(mv_par06 == 2 .And. E2_VENCREA <= mv_par04 ) .OR. ;
				(mv_par06 == 3 .And. E2_EMIS1   <= mv_par04 )

				TRB->( DbAppend() )
				TRB->CODPRO    := cCodPro
				TRB->LOJA      := SA2->A2_LOJA
				TRB->PROVEEDOR := cProveedor
				TRB->TELEFONOS := cTelef
				TRB->CONTACTO  := cContact

				cTipo 	:= Space( 3 )
				nPosTp	:=	AScan( aTipDoc, { |a| a[1] == E2_TIPO })
				cTipo	:=	IIf(nPosTp	>	0	, aTipDoc[nPosTp][2],E2_TIPO)
				nMoeda  := mv_par12

				TRB->SERIE   := AllTrim( E2_PREFIXO )
				TRB->NRODOC  := E2_NUM
				TRB->PARCELA := E2_PARCELA
				TRB->FECHA   := E2_EMISSAO
				TRB->FECVTO  := E2_VENCREA
				TRB->FECREG  := E2_EMIS1
				TRB->TIPODOC := cTipo
				TRB->TIPSAL  := If( E2_TIPO $ MV_CPNEG.OR. ;
				SubStr( E2_TIPO, 3, 1 ) == "-", "A", "D" )
				nTaxa := IIf(MV_PAR11 == 2,IIf(SE2->E2_TXMOEDA > 0, SE2->E2_TXMOEDA, RecMoeda(SE2->E2_EMISSAO, SE2->E2_MOEDA)), RecMoeda(dDataBase, SE2->E2_MOEDA))
				dData := IIf(MV_PAR11 == 1, dDataBase, SE2->E2_EMISSAO )
				If cPaisLoc == "PTG"
					TRB->NODIA  := E2_NODIA
				Endif
				If TRB->TIPSAL == "A"
					TRB->SALDO   := xMoeda(E2_SALDO,E2_MOEDA,nMoeda,dData,,nTaxa ) * -1
					TRB->CREDITO := xMoeda(E2_VALOR,E2_MOEDA,nMoeda,dData,,nTaxa )
					//Desconsidera monto de retención si fue asumido
					IF (cPaisLoc == "EQU" .and. SubStr( E2_TIPO, 3, 1 ) == "-" .and. E2_VALLIQ > 0)
						TRB->CREDITO := TRB->CREDITO - xMoeda(E2_VALLIQ,E2_MOEDA,nMoeda,dData,,nTaxa )
					ENDIF
				Else
					TRB->SALDO	:= Round(xMoeda(E2_SALDO,E2_MOEDA,nMoeda,dData,MsDecimais(1)+1,nTaxa),MsDecimais(1)) 
					TRB->DEBITO	:= Round(xMoeda(E2_VALOR,E2_MOEDA,nMoeda,dData,MsDecimais(1)+1,nTaxa),MsDecimais(1))
				Endif
				LeBaixaMCompra(SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA))
				DbSelectArea( "SE2" )
			EndIf
		EndIf
		DbSkip()
	EndDo

	DbSelectArea( "SE2" )
	DbSetOrder( 8 ) //E2_FILIAL+E2_ORDPAGO

	DbSelectArea( "SEK" )
	DbSetOrder( 3 ) //EK_FILIAL+DTOS(EK_DTDIGIT)+EK_ORDPAGO+EK_TIPODOC 

	If cPaisLoc $ "ANG|ARG|AUS|BOL|CHI|COL|COS|DOM|EQU|EUA|HAI|MEX|PAD|PAN|PAR|PER|POR|PTG|SAL|URU|VEN"
		lAgregSEK := .T.
	EndIf
	DbSeek(xFilial("SEK"))

	While !EoF() .And. EK_FILIAL == xFilial("SEK") .And. EK_DTDIGIT <= mv_par04

		If EK_DTDIGIT > dDataBase .OR. EK_CANCEL
			DbSkip()
			Loop
		Endif

		If lAgregSEK .and. !Empty(EK_FORNEPG)
			cCodPro	:= EK_FORNEPG
			cLoja		:= EK_LOJAPG
		Else
			cCodPro	:= EK_FORNECE
			cLoja		:= EK_LOJA
		EndIf

		If cCodPro < mv_par01 .or. cCodPro > mv_par02
			DbSkip()
			Loop
		EndIf

		DbSelectArea("SA2")
		DbSeek( xFilial("SA2") + cCodPro + cLoja)
		If !Empty(cFiltro) .And. !(&(cFiltro))
			DbSelectArea("SEK")
			DbSkip()
			Loop
		Endif

		cProveedor := SA2->A2_NOME

		DbSelectArea("SEK")
		
		If EK_DTDIGIT < mv_par03

			DbSelectArea("TRB")
			DBSetOrder(1) //CODPRO + TIPODOC + SERIE + NRODOC
			If !DbSeek(cCodPro+"SA", .F.)
				TRB->( DbAppend() )
				TRB->CODPRO    := cCodPro
				TRB->LOJA      := SA2->A2_LOJA
				TRB->PROVEEDOR := cProveedor
				TRB->TIPODOC   := "SA"
				TRB->FECHA     := mv_par03 - 1
				TRB->TELEFONOS := SA2->A2_TEL
				TRB->CONTACTO  := SA2->A2_CONTATO
			EndIf

			DbSelectArea( "SEK" )

			cOrdPag := EK_ORDPAGO
			
			While !EoF() .And. xFilial( "SEK" ) == EK_FILIAL .And. EK_ORDPAGO == cOrdPag
				If  ((EK_TIPODOC == "TB" .Or. EK_TIPODOC == "PA" ).And. !(cPaisLoc == "EQU" .And. EK_TIPO <> "NF "))
					SE2->(DBSETORDER(1)) //E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA 
					If SE2->(dbSeek(xFilial("SE2")+SEK->(EK_PREFIXO+EK_NUM+EK_PARCELA+EK_TIPO+EK_FORNECE+EK_LOJA)))
						dData := IIf(MV_PAR11 == 1, dDataBase, SE2->E2_EMISSAO)	
						nValRet := Round(xMoeda(xValRet(cOrdPag, SEK->EK_NUM, SEK->EK_PREFIXO, SEK->EK_PARCELA), SE2->E2_MOEDA, nMoeda, dData, 5, Iif(sE2->E2_MOEDA == 1, 1, SEK->&("EK_TXMOE" + strzero(sE2->E2_MOEDA, 2)))), MsDecimais(nMoeda))
						If (EK_TIPO $ "PA "+MV_CPNEG.And.EK_TIPODOC <> "PA")
							TRB->CREDITO := TRB->CREDITO - Round(xMoeda(SEK->EK_VALOR,SE2->E2_MOEDA,nMoeda,dData,5,Iif(MV_PAR11 == 2,Iif(SE2->E2_TXMOEDA>0 .And. SE2->E2_MOEDA > 1,SEK->&("EK_TXMOE"+ strzero(sE2->E2_MOEDA,2)),RecMoeda(SE2->E2_EMISSAO,SE2->E2_MOEDA)),0) ),MsDecimais(nMoeda))
						Else
							TRB->CREDITO :=  TRB->CREDITO + xMoeda(SEK->EK_VALOR,SE2->E2_MOEDA,nMoeda,dData,,IIf(sE2->E2_MOEDA==1,1,IIf(MV_PAR11 == 2,SEK->&("EK_TXMOE"+ strzero(sE2->E2_MOEDA,2)),0)) ) - nValRet
						Endif  
					Endif
					If SEK->EK_TIPODOC   == "PA"
						If SE2->(DbSeek(xFilial()+SEK->(EK_PREFIXO+EK_NUM+EK_PARCELA+EK_TIPO+EK_FORNECE+EK_LOJA)))  
							dData := IIf(MV_PAR11 == 1, dDataBase, SE2->E2_EMISSAO)		
							TRB->SALDO  := TRB->SALDO - xMoeda(SE2->E2_SALDO,SE2->E2_MOEDA,nMoeda,dData,,IIf(MV_PAR11 == 2,IIf(SE2->E2_TXMOEDA>0,SE2->E2_TXMOEDA,RecMoeda(SE2->E2_EMISSAO,SE2->E2_MOEDA)),0) )
						Endif
					Endif
				EndIf
				If TRB->CREDITO > TRB->DEBITO
					TRB->TIPSAL := "A"
				Else
					TRB->TIPSAL := "D"
				Endif
				DbSkip()
			EndDo
		Else
			If (EK_DTDIGIT <= mv_par04) 
				DbSelectArea("TRB")
				DBSetOrder(1) //CODPRO + TIPODOC + SERIE + NRODOC
				TRB->(DbAppend())
				TRB->CODPRO    := cCodPro
				TRB->LOJA      := SA2->A2_LOJA
				TRB->PROVEEDOR := cProveedor
				TRB->NRODOC    := If(!Empty( Val( SEK->EK_ORDPAGO ) ), ;
									StrZero(Val( SEK->EK_ORDPAGO ), 12 ), SEK->EK_ORDPAGO )
				TRB->FECHA     := SEK->EK_DTDIGIT
				TRB->FECVTO    := SEK->EK_EMISSAO
				TRB->FECREG    := SEK->EK_DTDIGIT
				TRB->TIPODOC   := "OP"
				TRB->TIPSAL    := "A"
				TRB->TELEFONOS := SA2->A2_TEL
				TRB->CONTACTO  := SA2->A2_CONTATO
				If cPaisLoc == "PTG"
					TRB->NODIA  := SEK->EK_NODIA
				Endif

				DbSelectArea( "SEK" )
				cOrdPag	:= EK_ORDPAGO
				nMoeda	:= mv_par12

				While !EoF() .And. xFilial( "SEK" ) == EK_FILIAL .And. EK_ORDPAGO == cOrdPag
					If  ((EK_TIPODOC == "TB".Or. EK_TIPODOC == "PA") .And. !(cPaisLoc == "EQU" .And. EK_TIPO <> "NF "))

						SE2->(DBSETORDER(1)) //E2_FILIAL+E2_NATUREZ+E2_NOMFOR+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE
						If SE2->(dbSeek(xFilial("SE2")+SEK->(EK_PREFIXO+EK_NUM+EK_PARCELA+EK_TIPO+EK_FORNECE+EK_LOJA)))
							If cPaisLoc == "ARG" .and. SE2->E2_SALDO == 0 .and. mv_par10 == 2
								DbSkip()
								Loop
							Else
								dData := IIf(MV_PAR11 == 1, dDataBase, SE2->E2_EMISSAO)	
								nValRet := Round(xMoeda(xValRet(cOrdPag, SEK->EK_NUM, SEK->EK_PREFIXO, SEK->EK_PARCELA), SE2->E2_MOEDA, nMoeda, dData, 5, Iif(sE2->E2_MOEDA == 1, 1, SEK->&("EK_TXMOE"+ strzero(sE2->E2_MOEDA,2)))), MsDecimais(nMoeda))
								If (EK_TIPO $ "PA "+MV_CPNEG .And. EK_TIPODOC <> "PA")
									TRB->CREDITO := TRB->CREDITO - Round(xMoeda(SEK->EK_VALOR,SE2->E2_MOEDA,nMoeda,dData,5,Iif(MV_PAR11 == 2,Iif(SE2->E2_TXMOEDA > 0 .And. SE2->E2_MOEDA > 1 ,SEK->&("EK_TXMOE"+ strzero(sE2->E2_MOEDA,2)),RecMoeda(SE2->E2_EMISSAO,SE2->E2_MOEDA)),0) ),MsDecimais(nMoeda))
								Else
									TRB->CREDITO :=  TRB->CREDITO + Round(xMoeda(SEK->EK_VALOR, SE2->E2_MOEDA, nMoeda, dData, 5, Iif(sE2->E2_MOEDA == 1, 1, SEK->&("EK_TXMOE"+ strzero(sE2->E2_MOEDA,2)))), MsDecimais(nMoeda)) - nValRet
									IF (cPaisLoc == "EQU" .And. EK_TIPODOC == "TB") 
										nVRetAsum := Round(xMoeda(xValRetAsum(cOrdPag, SEK->EK_NUM, SEK->EK_PREFIXO, SEK->EK_PARCELA, SEK->EK_TIPO), SE2->E2_MOEDA, nMoeda, dData, 5, Iif(sE2->E2_MOEDA == 1, 1, SEK->&("EK_TXMOE"+ strzero(sE2->E2_MOEDA,2)))), MsDecimais(nMoeda))
										TRB->CREDITO :=  TRB->CREDITO + nVRetAsum
									ENDIF
								Endif
							EndIf
						Endif

						If SEK->EK_TIPODOC   == "PA"
							If SE2->(DbSeek(xFilial()+SEK->(EK_PREFIXO+EK_NUM+EK_PARCELA+EK_TIPO+EK_FORNECE+EK_LOJA))) 
								dData		:= IIf(MV_PAR11 == 1, dDataBase, SE2->E2_EMISSAO)
								TRB->SALDO	:= TRB->SALDO - xMoeda(SE2->E2_SALDO,SE2->E2_MOEDA,nMoeda,dData,,IIf(MV_PAR11 == 2,IIf(SE2->E2_TXMOEDA>0,SE2->E2_TXMOEDA,RecMoeda(SE2->E2_EMISSAO,SE2->E2_MOEDA)),0) )
							Endif
						Endif
					EndIf
					DbSkip()
				EndDo
				If cPaisLoc == "ARG" .AND. TRB->CREDITO == 0 .AND. TRB->DEBITO == 0 .AND. mv_par10 ==2
					TRB->(DBDelete())
				EndIf
			Else
				DbSkip()
			EndIf
		EndIf
	EndDo

	DbSelectArea("TRB")

	If TRB->( RecCount() ) == 0
		MsgAlert( OemToAnsi(STR0006) )  //"No se encontraron datos segun los parametros ingresados"
		Return .F.
	EndIf

	If mv_par07 < 2
		If mv_par06 < 2
			DBSetOrder(2) //CODPRO + FECHA + TIPODOC + SERIE + NRODOC
		Else
			DBSetOrder(3) //CODPRO + FECVTO + TIPODOC + SERIE + NRODOC
		EndIf
	Else
		If mv_par06 == 1
			DBSetOrder(4) //PROVEEDOR + FECHA + TIPODOC + SERIE + NRODOC
		ElseIf mv_par06 == 2
			DBSetOrder(5) //PROVEEDOR + FECVTO + TIPODOC + SERIE + NRODOC
		ElseIf mv_par06 == 3
			DBSetOrder(6) //PROVEEDOR + FECREG + TIPODOC + SERIE + NRODOC
		EndIf
	EndIf

	DbSelectArea("TRB")
	DbGoTop()

	oReport:SetMeter(TRB->( RecCount() ) + 1)

	If MV_PAR05 == 2
		oSection2:Cell("E2_TIPO"	):Disable()
		oSection2:Cell("E2_EMISSAO"	):Disable()
		oSection2:Cell("E2_VENCREA"	):Disable()
		oSection2:Cell("E2_EMIS1"	):Disable()
		oSection2:Cell("E2_EMISSAO"	):Disable()
		oSection2:Cell("E2_NUM"		):SetTitle(" ")
	EndIf
	oSection1:SetHeaderPage(.T.)
	oSection2:SetHeaderPage(.T.)
	While !EoF()
	If ( mv_par10 == 2 .And. TRB->SALDO = 0 ) .Or. ((TRB->FECHA< MV_PAR03 .Or. TRB->FECHA > MV_PAR04).and.(TRB->TIPODOC!="SA"))
		dbSkip()
		Loop
	EndIf
		cCodPro    := TRB->CODPRO
		cProveedor := AllTrim( PROVEEDOR )
		cTelef     := AllTrim( TELEFONOS )
		cContact   := AllTrim( CONTACTO )
		oSection1:Init()
		oSection1:Cell("A2_COD"	):SetBlock({||TRB->CODPRO  })
		oSection1:Cell("A2_NOME"):SetBlock({||TRB->PROVEEDOR})
		oSection1:PrintLine()
		oReport:SkipLine()
		oSection1 :Finish()
		oSection2:Init()
		If oReport:nDevice == IMP_EXCEL 
			oSection2:SetHeaderSection(.F.)	
			oSection2:SetPageBreak(.F.)	    
			oSection1:SetHeaderSection(.F.)	
			oSection1:SetPageBreak(.F.)	               
		EndIf		
		While !EoF() .And. TRB->CODPRO == cCodPro
			nCredPro := nCredPro + TRB->CREDITO
			nTotCred := nTotCred + TRB->CREDITO
			nDebPro  := nDebPro  + TRB->DEBITO
			nTotDeb  := nTotDeb  + TRB->DEBITO

			nSalMO   := nSalMO   + TRB->SALDO
			nSalAC   :=nSalAC   + (TRB->DEBITO - TRB->CREDITO) 
			nTotMO   := nTotMO   + TRB->SALDO
			If mv_par05 == 1 // .And. !Empty( VALOR )
				DbSelectArea("TRB")
				If TIPODOC == "SA"
					oSection2:Cell("E2_NUM"):SetBlock({||OemToAnsi(STR0012) }) //"Saldos al: "
					oSection2:Cell("E2_EMISSAO"):SetBlock({||TRB->FECHA })
				Else
					oSection2:Cell("E2_TIPO"	):SetBlock({||TRB->TIPODOC })
					oSection2:Cell("E2_NUM"		):SetBlock({||Left(TRB->NRODOC,20)})
					oSection2:Cell("E2_EMISSAO"	):SetBlock({||OemToAnsi(STR0012) }) //"Saldos al: "
					oSection2:Cell("E2_VENCREA"	):SetBlock({||TRB->FECVTO })
					oSection2:Cell("E2_EMIS1"	):SetBlock({||TRB->FECREG })
					oSection2:Cell("E2_EMISSAO"	):SetBlock({||TRB->FECHA })
					If cPaisLoc == "PTG"
						oSection2:Cell("NODIA"):SetBlock({||TRB->NODIA })  
					Endif	
				Endif
				If TRB->DEBITO > 0
					oSection2:Cell("DEBITO"):SetBlock({||TRB->DEBITO })
				EndIf
				If TRB->CREDITO > 0
					oSection2:Cell("CREDITO"):SetBlock({||TRB->CREDITO})
				Endif
			
				oSection2:Cell("SALDO"):SetBlock({||nSalAC })
			
				
				oSection2:PrintLine()
			EndIf
			TRB->(DbSkip())
			oReport:IncMeter()
		EndDo

		If ( mv_par10 == 1 .OR. cCodPro <> CodPro ) .And. mv_par09 == 1

			cDisp := cTelef + " - " + cContact

			If mv_par05 < 2
				oReport:ThinLine()
				oReport:SkipLine()
				oReport:PrintText(OemToAnsi(STR0013) + cCodPro + " (" + Left( cDisp, 40 ) + ")" ) //"SUBTOTALES DEL PROVEEDOR "
			Else
				oReport:PrintText( cCodPro  +  "  " + cProveedor + " (" +  Left( cDisp, 40 ) + ")"  )
			EndIf
			oSection2:Cell("E2_TIPO"	):Hide()
			oSection2:Cell("E2_NUM"		):Hide()
			oSection2:Cell("E2_EMISSAO"	):Hide()
			oSection2:Cell("E2_VENCREA"	):Hide()
			oSection2:Cell("E2_EMIS1"	):Hide()
			oSection2:Cell("E2_EMISSAO"	):Hide()
			oSection2:Cell("DEBITO"		):SetBlock({||nDebPro })
			oSection2:Cell("CREDITO"	):SetBlock({||nCredPro})
			oSection2:Cell("SALDO"		):SetBlock({||nSalAC })
			oSection2:PrintLine()
			oSection2:Cell("E2_TIPO"	):Show()
			oSection2:Cell("E2_NUM"		):Show()
			oSection2:Cell("E2_EMISSAO"	):Show()
			oSection2:Cell("E2_VENCREA"	):Show()
			oSection2:Cell("E2_EMIS1"	):Show()
			oSection2:Cell("E2_EMISSAO"	):Show()
			If cPaisLoc == "PTG"
				oSection2:Cell("NODIA"):Show()
			Endif	
			If mv_par05 < 2
				oReport:ThinLine()
				oReport:SkipLine()
			EndIf
			nDebPro  := 0
			nCredPro := 0
			nSalAC   := 0
			nSalMo   := 0
		EndIf
		oSection2 :Finish()
		If oReport:nDevice == IMP_EXCEL 
			oSection2:SetHeaderSection(.T.)	
			oSection2:SetPageBreak(.T.)	    
			oSection1:SetHeaderSection(.T.)	
			oSection1:SetPageBreak(.T.)	               
		EndIf
	EndDo
	
	If oReport:nDevice == IMP_EXCEL 
		oSection2:SetHeaderSection(.F.)	
		oSection2:SetPageBreak(.F.)	    
		oSection1:SetHeaderSection(.F.)	
		oSection1:SetPageBreak(.F.)	               
	EndIf

	If  mv_par09 == 1
		oReport:SkipLine()
		oSection2:Init()
		If cPaisLoc == "PTG"
			oSection2:Cell("NODIA"):Hide()
		Endif	
		oSection2:Cell("E2_TIPO"	):Hide()
		oSection2:Cell("E2_EMISSAO"	):Hide()
		oSection2:Cell("E2_VENCREA"	):Hide()
		oSection2:Cell("E2_EMIS1"	):Hide()
		oSection2:Cell("E2_EMISSAO"	):Hide()
		oSection2:Cell("E2_NUM"		):SetBlock({||OemToAnsi(STR0014) }) //"TOTALES GENERALES:"
		oSection2:Cell("DEBITO"		):SetBlock({||nTotDeb})
		oSection2:Cell("CREDITO"	):SetBlock({||nTotCred })
		oSection2:Cell("SALDO"		):SetBlock({|| nTotDeb-nTotCred })
		oSection2:PrintLine()
		oReport:SkipLine()
		oReport:FatLine()
	EndIf
	
	If oTmpTable <> Nil
		oTmpTable:Delete()
		oTmpTable := Nil
	EndIf

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LeBaixaMCompraºAutor  ³Paulo Augusto    º Data ³  21/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Grava as baixas manuais que houverem do titulo corrente no   º±±
±±º          ³arquivo de trabalho                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function LeBaixaMCompra(cChave)
	
	Local cSeq		:= ""
	Local nReg		:= 0
	Local nMoeda	:= mv_par12
	
	SE5->(DbSeek(xFilial("SE5") + cChave))
	While cChave = SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA) ;
			.And. ! SE5->(Eof()) .And. SE5->E5_DATA <= mv_par04
		cSeq := SE5->E5_SEQ
		nReg := SE5->(Recno())
		If SE5->E5_TIPODOC = "VL" .Or. (SE5->E5_TIPODOC == "BA" .And. SE5->E5_MOTBX == 'CEC');  
			.And. SE5->E5_SITUACA !="C"  // Baixa manual e baixa por compensacao entre carteiras

			SE5->(DbSkip())
			If !(cChave + cSeq == SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ) ;
					.And. SE5->E5_TIPODOC = "ES") // Nao faz nada se Houver Estorno da baixa
				SE5->(DbGoto(nReg))
				TRB->( DbAppend() )
				TRB->CODPRO    	:= cCodPro
				TRB->PROVEEDOR 	:= cProveedor
				TRB->TELEFONOS 	:= cTelef
				TRB->CONTACTO  	:= cContact
				TRB->Credito	:= Round(xMoeda(SE5->E5_VALOR, SE2->E2_MOEDA, nMoeda,, nDecs + 1, IIf(MV_PAR11 == 2, IIf(SE5->E5_TXMOEDA > 0, SE5->E5_TXMOEDA, RecMoeda(SE5->E5_DATA, SE2->E2_MOEDA)), RecMoeda(dDataBase, SE2->E2_MOEDA))),nDecs)
				TRB->TIPSAL		:= "A"
				TRB->Saldo 		:= - TRB->Credito
				TRB->NRODOC		:= SE5->E5_NUMERO
				TRB->TIPODOC	:= SE5->E5_TIPODOC
				TRB->SERIE		:= SE5->E5_PREFIXO
				TRB->FECHA     	:= SE5->E5_DATA
				TRB->FECREG    	:= SE5->E5_DTDIGIT
			EndIf
		ElseIf SE5->E5_TIPODOC $ "JR/MT/DC/IS" .And. SE5->E5_SITUACA != "C" // Juros, Multa, Desconto, Impsubst(localiz"CHI")
			TRB->( DbAppend() )
			TRB->CODPRO    := cCodPro
			TRB->PROVEEDOR := cProveedor
			TRB->TELEFONOS := cTelef
			TRB->CONTACTO  := cContact
			If SE5->E5_TIPODOC = "DC"
				TRB->TIPSAL		:= "A"
				TRB->Credito	:= Round(xMoeda(SE5->E5_VALOR,SE2->E2_MOEDA,nMoeda,,nDecs+1,IIf(MV_PAR11 == 2,IIf(SE5->E5_TXMOEDA>0,SE5->E5_TXMOEDA,RecMoeda(SE5->E5_DATA,E2_MOEDA)),0) ),nDecs)
				TRB->Saldo		:= - TRB->Credito
			Else
				TRB->TIPSAL	:= "D"
				TRB->Debito	:= Round(xMoeda(SE5->E5_VALOR,SE2->E2_MOEDA,nMoeda,,nDecs+1,IIf(MV_PAR11 == 2,IIf(SE5->E5_TXMOEDA>0,SE5->E5_TXMOEDA,RecMoeda(SE5->E5_DATA,E2_MOEDA)),0) ),nDecs)
				TRB->Saldo	:= TRB->Debito
			EndIf
			TRB->NRODOC		:= SE5->E5_NUMERO
			TRB->TIPODOC	:= SE5->E5_TIPODOC
			TRB->SERIE		:= SE5->E5_PREFIXO
			TRB->FECHA		:= SE5->E5_DATA
			TRB->FECREG     := SE5->E5_DTDIGIT
		EndIf
		SE5->(DbSkip())
	EndDo
	
Return Nil

/*/{Protheus.doc} xValRet
Función que recupera las retenciones pagadas de una OP.
@type
@author eduardo.manriquez
@since 06/08/2021
@version 1.0
@param cNumOrd , caracter , Numero de la orden de pago
@param cNumDoc , caracter , Numero de la cuenta por pagar vinculada a la OP
@param cSerie , caracter , Serie de la cuenta por pagar vinculada a la OP
@param cParcela , caracter , Parcialidad de la cuenta por pagar vinculada a la OP
@return nValRet , numerico , Valor de las retenciones pagadas.
@example
 xValRet(cNumOrd,cNumDoc,cSerie,cParcela)
@see (links_or_references)
/*/
Static Function xValRet(cNumOrd,cNumDoc,cSerie,cParcela)

	Local nValRet     := 0
	Local nReg        := 0
	Local aArea       := GetArea()
	Local cSFERet     := GetNextAlias()

	
	Default cNumOrd    := ""
	Default cNumDoc    := ""
	Default cSerie     := ""
	Default cParcela   := ""

	If !(cPaisLoc) $ "ARG|PAR|C3HI|URU|BOL"
		
		BeginSQL Alias cSFERet
			SELECT SUM(SFE.FE_RETENC) FE_RETENC
			FROM %Table:SFE% SFE
			WHERE SFE.FE_ORDPAGO = %Exp:cNumOrd% AND SFE.FE_NFISCAL=%Exp:cNumDoc% AND SFE.FE_SERIE=%Exp:cSerie% AND SFE.FE_PARCELA=%Exp:cParcela% AND SFE.FE_FILIAL= %xfilial:SFE% 
			AND SFE.%NotDel%
		EndSQL
		Count to nReg
		(cSFERet)->(DbGoTop())
		If nReg > 0
			While (cSFERet)->(!EoF())
				nValRet += (cSFERet)->FE_RETENC
				(cSFERet)->(DbSkip())
			EndDo
		EndIf
		(cSFERet)->(Dbclosearea())
		RestArea(aArea)
	EndIf	

Return nValRet

/*/{Protheus.doc} xValRetAsum
Función que recupera las retenciones Asumidas.
@type
@author diego.rivera
@since 14/10/2022
@version 1.0
@param cNumOrd , caracter , Numero de la orden de pago
@param cNumDoc , caracter , Numero de la cuenta por pagar vinculada a la OP
@param cSerie , caracter , Serie de la cuenta por pagar vinculada a la OP
@param cParcela , caracter , Parcialidad de la cuenta por pagar vinculada a la OP
@param cTipo , caracter , Tipo de la cuenta por pagar vinculada a la OP
@return nVRetAsum , numerico , Valor de las retenciones Asumidas.
@example
 xValRetAsum(cNumOrd,cNumDoc,cSerie,cParcela,cTipo)
@see (links_or_references)
/*/
Static Function xValRetAsum(cNumOrd,cNumDoc,cSerie,cParcela,cTipo)

	Local nVRetAsum     := 0
	Local nReg        := 0
	Local aArea       := GetArea()
	Local cSE2RetAsu  := GetNextAlias()
		
	Default cNumOrd    := ""
	Default cNumDoc    := ""
	Default cSerie     := ""
	Default cParcela   := ""
	Default cTipo      := ""

	If (cPaisLoc == "EQU" .And. !Empty(cTipo))
		
		BeginSQL Alias cSE2RetAsu
			SELECT SUM(SE2.E2_VALLIQ) E2_VALLIQ
			FROM %Table:SE2% SE2
			WHERE SE2.E2_ORDPAGO = %Exp:cNumOrd% AND SE2.E2_NUM=%Exp:cNumDoc% AND SE2.E2_PREFIXO=%Exp:cSerie% AND SE2.E2_PARCELA=%Exp:cParcela% AND SE2.E2_TIPO!=%Exp:cTipo% AND SE2.E2_FILIAL= %xfilial:SE2%
			AND SE2.%NotDel%
		EndSQL
		Count to nReg
		(cSE2RetAsu)->(DbGoTop())
		If nReg > 0
			While (cSE2RetAsu)->(!EoF())
				nVRetAsum += (cSE2RetAsu)->E2_VALLIQ
				(cSE2RetAsu)->(DbSkip())
			EndDo
		EndIf
		(cSE2RetAsu)->(Dbclosearea())
		RestArea(aArea)
	EndIf	

Return nVRetAsum

/*/{Protheus.doc} existePago
	valida si existe registro datos del pago en la SE5
	@type  void
	@author adrian.perez
	@since 30/11/2021
	@version version
	@param cProveedor, string, codigo de proveedor
	@param cLoja, string, tienda de proveedor
	@param cNUm, string, numero de documento
	@param cPrefijo, string, serie del documento
	@param cParcela, string, numero de cuota(parcela) del movimiento
	@param cOP, string, numero de la orden pago vinculo entre la tabla SEK y SE5
	@return aDatos, array, contiene el valor,numero y fecha del documeno original en caso de existir movimiento en la SE5
	@example
	(examples)
	@see (links_or_references)
	/*/
Static Function 	existePago(cProveedor,cLoja,cNum,cPrefijo,cParcela,cOP)


	Local cSE5    := GetNextAlias()
	Local aArea       := GetArea() 
	Local aDatos:={}
	Local cQuery:=''
	Local nReg:=0
	Local nPagAcu:=0
	IF cOP<> ''
			cQuery:="%SE5.E5_DOCUMEN='"+cOP +"' AND %"
		ELSE
			cQuery:= "%SE5.E5_DOCUMEN<>"+"''" +" AND  %"
	ENDIF
	BeginSQL Alias cSE5
		SELECT
		E5_NUMERO,E5_VALOR,E5_DOCUMEN,E5_DATA
		FROM %Table:SE5% SE5
		WHERE 
		SE5.E5_FILIAL= %xfilial:SE5% AND
		SE5.E5_NUMERO= %Exp:cNum% AND 
		SE5.E5_PREFIXO=%Exp:cPrefijo% AND
		SE5.E5_CLIFOR = %Exp:cProveedor% AND
		SE5.E5_LOJA= %Exp:cLoja% AND
		SE5.E5_PARCELA= %Exp:cParcela% AND
		%Exp:cQuery%

		SE5.E5_TIPODOC ="BA" 
		AND SE5.%NotDel%
		ORDER BY E5_DATA ASC
	EndSQL

	Count to nReg
	(cSE5)->(DbGoTop())
	If nReg > 0
		While (cSE5)->(!EoF())
			nPagAcu+=(cSE5)->E5_VALOR
			(cSE5)->(DbSkip())
		EndDo
	EndIf
	
	If nPagAcu > 0
		aDatos:={.T.,nPagAcu,(cSE5)->E5_DOCUMEN,(cSE5)->E5_DATA}
	ELSE
		aDatos:={.F.,-1,-1}
	EndIf



	RestArea(aArea)

Return aDatos
