/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "rwmake.ch"        // incluido por el asistente de conversión del AP5 IDE en 01/06/00
#include "finr13h.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³          ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador  ³ Data   ³ BOPS     ³  Motivo da Alteracao                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Jonathan Glez³09/12/16³SERINN001-³Se modifica uso de tablas temporales  ³±±
±±³             ³        ³      130 ³por motivo de limpieza de CTREE.      ³±±
±±³Dora Vega    ³21/03/17³MMI-250   ³Merge de replica del llamado TVTKAE.  ³±±
±±³             ³        ³          ³Correcciones en el fuente FINR13H para³±±
±±³             ³        ³          ³mostrar en los campos E1_EMISSAO y    ³±±
±±³             ³        ³          ³E1_VENCTO el tamano correctamente(ARG)³±±
±±³L. Samaniego ³12/03/18³DMICNS    ³Mostrar las cuentas por cobrar con y  ³±±
±±³             ³        ³ -1167    ³sin prefijo. Argentina.               ³±±
±±³   Marco A.  ³16/04/18³DMINA-2310³Se remueven sentencias CriaTrab y se  ³±±
±±³             ³        ³          ³aplica FWTemporaryTable(), para el    ³±±
±±³             ³        ³          ³manejo de las tablas temporales.      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR13H()
	Local oReport	:= Nil

	Private oTmpTRB	:= Nil //jgr
	Private aOrder := {}

	SetPrvt("CTITULO")

	SetPrvt("CARQTRAB,CARQTRAB1")

	If !ExistBlock("FARGTIP")
		MsgAlert(OemToAnsi(STR0001),OemToAnsi(STR0002)) //"Bloque FARGTIP no encontrado","RDMAKE no Existe!"
		Return
	EndIf

	If TRepInUse()
		oReport	:= ReportDef()
		oReport:PrintDialog()
	EndIf

	If oTmpTRB <> Nil   //JGR
		dbSelectArea("TRB")
		TRB->(dbCloseArea())
		oTmpTRB:Delete()
		oTmpTRB := Nil
	Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef  ºAutor  ³Paulo Augusto       º Data ³  27/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Definicion de Reporte FINR13h                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
	Local oReport,oSection1,oSection2
	Local cReport := "FINR13H"
	Local cTitulo := OemToAnsi(STR0003)
	Local cDescri := OemToAnsi(STR0003)
	Local nTamPreFix := TAMSX3("E1_PREFIXO" )[1]
	Local nTamNumTit := TAMSX3("E1_NUM" )[1] + 2

	Pergunte( "FIN13H" , .F. )

	oReport  := TReport():New( cReport, cTitulo, "FIN13H" , { |oReport| ReportPrint( oReport, "TRB" ) }, cDescri )

	oSection1 := TRSection():New( oReport,STR0038, {"TRB","SA1","SE1"} ) //'Cliente x Titulos a receber'

	TRCell():New( oSection1, "E1_CLIENTE" 	,"SE1" ,/*X3Titulo*/   	,/*Picture*/				,TAMSX3("E1_CLIENTE")[1],/*lPixel*/,{||TRB->TR_CLIENTE})
	TRCell():New( oSection1, "A1_NOME" 		,"SA1",/*X3Titulo*/  	,/*Picture*/			,TAMSX3("A1_NOME")[1] /*Tamanho*/,/*lPixel*/,{||TRB->TR_NOME})	
	TRCell():New( oSection1, "DESCTIPO"		,"   ",STR0034			,/*Picture*/				,10			,/*lPixel*/,{|| Iif(Alltrim(TRB->TR_TIPO)$"CH","Cheque Carteira","")})
	TRCell():New( oSection1, "E1_PREFIXO"	,"   ",/*X3Titulo*/  	,/*Picture*/				,nTamPreFix ,/*lPixel*/,{|| TRB->TR_PREFIXO})
	TRCell():New( oSection1, "E1_NUM" 		,"   ",/*X3Titulo*/  	,/*Picture*/				,nTamNumTit,/*lPixel*/,{|| TRB->TR_DOC})	
	TRCell():New( oSection1, "E1_PARCELA" 	,"   " ,/*X3Titulo()*/	,/*Picture*/				,/*Tamanho*/		    ,/*lPixel*/,{||TRB->TR_PARCELA })
	TRCell():New( oSection1, "E1_TIPO"    	,"   " ,/*X3Titulo()*/	,/*Picture*/				,/*Tamanho*/		    ,/*lPixel*/,{|| TRB->TR_TIPO})
	TRCell():New( oSection1, "E1_NATUREZ"	,"   " ,/*X3Titulo()*/	,/*Picture*/				,12					    ,/*lPixel*/,{|| TRB->TR_NATUREZ },,,,,,.F.)
	TRCell():New( oSection1, "E1_EMISSAO" 	,"   " ,/*X3Titulo()*/	,/*Picture*/				,/*Tamanho*/		    ,/*lPixel*/,{|| TRB->TR_EMISSAO },,,,,2,.F.)
	TRCell():New( oSection1, "E1_VENCTO" 	,"   " ,/*X3Titulo()*/	,/*Picture*/				,/*Tamanho*/		    ,/*lPixel*/,{|| TRB->TR_VENCTO  },,,,,2,.F.)
	TRCell():New( oSection1, "VLCRUZ" 		,"   " ,STR0035			,PesqPict("SE1","E1_VLCRUZ"),TAMSX3("E1_VLCRUZ")[1] ,/*lPixel*/,{||TRB->TR_VALOR })
	TRCell():New( oSection1, "SALDO" 		,"   " ,STR0036 		,PesqPict("SE1","E1_VLCRUZ"),TAMSX3("E1_SALDO")[1]  ,/*lPixel*/,{||TRB->TR_SALDO  })
	TRCell():New( oSection1, "ATRASO" 		,"   " ,STR0037			,"@E999"					,3					    ,/*lPixel*/,{||dDataBase-TRB->TR_VENCREA  })
	TRCell():New( oSection1, "CART" 		,"   " ,/*X3Titulo()*/	,/*Picture*/				,1					    ,/*lPixel*/,{||TRB->TR_CART })
	TRCell():New( oSection1, "VENCIDO" 		,"   " ,STR0012  		,PesqPict("SE1","E1_VLCRUZ"),TAMSX3("E1_VLCRUZ")[1] ,/*lPixel*/,{||Iif(!Alltrim(TRB->TR_TIPO)$"CH" .AND. dDatabase>TRB->TR_VENCREA,TRB->TR_SALDO ,0) })
	TRCell():New( oSection1, "ABERTO" 		,"   " ,STR0013  		,PesqPict("SE1","E1_VLCRUZ"),TAMSX3("E1_VLCRUZ")[1] ,/*lPixel*/,{||Iif(!Alltrim(TRB->TR_TIPO)$"CH",TRB->TR_SALDO ,0) })
	TRCell():New( oSection1, "CARTEIRA" 	,"   " ,STR0015  		,PesqPict("SE1","E1_VLCRUZ"),TAMSX3("E1_VLCRUZ")[1] ,/*lPixel*/,{||Iif(Alltrim(TRB->TR_TIPO)$"CH",TRB->TR_SALDO ,0) })
	TRCell():New( oSection1, "TOTCLI" 		,"   " ,STR0016 		,PesqPict("SE1","E1_VLCRUZ"),TAMSX3("E1_VLCRUZ")[1] ,/*lPixel*/,{||TRB->TR_SALDO  })

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Paulo Augusto       º Data ³  27/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )
	Local oSection1 := oReport:Section(1)
	Local oBreak1
	Local oBreak2
	Local aCampos:={}

	AADD(aCampos,{ "TR_CLIENTE", "C",  TamSX3('A1_COD')[1], 0 })
	AADD(aCampos,{ "TR_LOCAL"  , "C",  TamSX3('A1_LOJA')[1], 0 })
	AADD(aCampos,{ "TR_NOME"   , "C", 20, 0 })
	AADD(aCampos,{ "TR_DOC"    , "C", TamSX3('E1_NUM')[1], 0 })
	AADD(aCampos,{ "TR_PREFIXO", "C", TamSX3('E1_PREFIXO')[1], 0 })
	AADD(aCampos,{ "TR_TIPO"   , "C",  3, 0 })
	AADD(aCampos,{ "TR_PARCELA", "C",  TamSX3('E1_PARCELA')[1], 0 })
	AADD(aCampos,{ "TR_EMISSAO", "D",  8, 0 })
	AADD(aCampos,{ "TR_VENCTO" , "D",  8, 0 })
	AADD(aCampos,{ "TR_VENCREA", "D",  8, 0 })
	AADD(aCampos,{ "TR_BANCO"  , "C",  3, 0 })
	AADD(aCampos,{ "TR_SITUACA", "C",  1, 0 })
	AADD(aCampos,{ "TR_VALOR"  , "N", 14, 2 })
	AADD(aCampos,{ "TR_SALDO"  , "N", 14, 2 })
	AADD(aCampos,{ "TR_NATUREZ", "C", 10, 0 })
	AADD(aCampos,{ "TR_CART", "N", 1, 0 })
	AADD(aCampos,{ "TR_TIPOORI"   , "C",  3, 0 })

	aOrder := {"TR_CLIENTE","TR_LOCAL","TR_EMISSAO","TR_TIPO"}//JGR
	oTmpTRB := FWTemporaryTable():New("TRB") //JGR
	oTmpTRB:SetFields( aCampos )
	oTmpTRB:AddIndex("I01", aOrder)
	oTmpTRB:Create()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Llena el archivo temporario con los datos pedidos           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄDiegoÄÄÄÄÄÄÙ
	Processa({|| FID010GR4(oSection1:GetAdvPlExp('SE1'),oSection1:GetAdvPlExp('SA1'))},OemToAnsi(STR0007),OemToAnsi(STR0008))

	TrPosition():New(oSection1,'SA1',1,{|| xFilial('SA1')+TRB->(TR_CLIENTE+TR_LOCAL)})
	TrPosition():New(oSection1,'SE1',1,{|| xFilial('SE1')+TRB->(TR_PREFIXO+TR_DOC+TR_PARCELA+TR_TIPOORI)})

	oBreak1 := TRBreak():New( oSection1,oSection1:Cell("E1_CLIENTE"), STR0016 ,.T.)

	TRFunction():New(oSection1:Cell("VENCIDO")	, , "SUM" , oBreak1, , , ,.f.  , )
	TRFunction():New(oSection1:Cell("ABERTO")		, , "SUM" , oBreak1, , , , .f.  ,  )
	TRFunction():New(oSection1:Cell("CARTEIRA")	, , "SUM" , oBreak1, , , ,.f. ,   )
	TRFunction():New(oSection1:Cell("TOTCLI")	, , "SUM" , oBreak1, , , ,.f. ,   )

	oSection1:Cell("CART"):Disable()
	oSection1:Cell("TOTCLI"):Disable()
	oSection1:Cell("VENCIDO"):Disable()
	oSection1:Cell("ABERTO"):Disable()
	oSection1:Cell("CARTEIRA"):Disable()
	oSection1:Print()

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funci¢n   ³FID010GR4 ³ Autor ³ Paulo Augusto         ³ Data ³ 11/01/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrip.  ³ Carga archivo temporario                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ FIND010                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FID010GR4(cFiltSE1,cFiltSA1)

	Local lCartera:=.F.
	Local lAbierto:=.F.
	Local dDataTit:= dDatabase
	Local cTipos := ExecBlock("FARGTIP",.F.,.F.)
	Local cNeg   := GetMV("MV_CRNEG") + "/RA "
	Local nSaldo:=0
	Local nSigno:=1

	lCartera := IIf( mv_par07 == 2 .or. mv_par07 == 3, .t., .f. )
	lAbierto := IIf( mv_par07 == 1 .or. mv_par07 == 3, .t., .f. )
	dDataTit := MIN(dDataBase,mv_par06)

	If lCartera
		cTipos := cTipos + "/CH "
	End If

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Busca el primer producto                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄDiegoÄÄÄÄÄÄÙ
	DbSelectArea("SE1")
	DbSetOrder(2)

	If ! Empty(mv_par01)
		SE1->(DbSeek(xFilial("SE1")+mv_par01+mv_par03,.T.))
	Else
		SE1->(DbSeek(xFilial("SE1")))
	Endif

	ProcRegua( LastRec() )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Recorre el archivo de Stock                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄDiegoÄÄÄÄÄÄÙ
	While !EOF() .AND. xFilial("SE1") == E1_FILIAL.And. E1_CLIENTE + e1_loja <= mv_par02+mv_par04

		IncProc(OemToAnsi(STR0020) + E1_TIPO +"  "+ E1_NUM)  //"Procesando "

		If Val(E1_SITUACA) > 0 .or.  E1_EMISSAO > dDataTit
			DbSkip()
			Loop
		Endif

		If (mv_par07==1   .AND. E1_TIPO == "CH ").Or.;
		(mv_par07==2   .AND. E1_TIPO <> "CH ")
			DbSkip()
			Loop
		End If

		If !( E1_TIPO $ cTipos )
			DbSkip()
			Loop
		End If

		If (E1_NATUREZ < mv_par08 .or. E1_NATUREZ > mv_par09) .and.;
		(E1_TIPO != "CH ")
			DbSkip()
			Loop
		EndIf

		If !Empty(cFiltSE1) .And. !(&(cFiltSE1))
			DbSelectArea("SE1")
			DbSkip()
			Loop
		Endif

		nSaldo   := SaldoTit(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_NATUREZ,"R",SE1->E1_CLIENTE,1,,dDataBase,SE1->E1_LOJA,,Iif(MV_PAR10==2,Iif(!Empty(SE1->E1_TXMOEDA),SE1->E1_TXMOEDA,RecMoeda(SE1->E1_EMISSAO,SE1->E1_MOEDA)),0))

		If nSaldo <= 0
			DbSkip()
			Loop
		Endif

		If E1_TIPO $ cNeg
			nSigno := -1
		Else
			nSigno := 1
		EndIF
		SA1->(DbSetOrder(1))
		If !Empty(cFiltSA1)
			SA1->(MsSeek( xFilial("SA1") + SE1->E1_CLIENTE + SE1->E1_LOJA ))
			If !SA1->(&(cFiltSA1))
				DbSelectArea("SE1")
				DbSkip()
				Loop
			Endif
		Endif

		If E1_EMISSAO < Min(mv_par05,dDataBase)
			IF TRB->(DbSeek(SE1->E1_CLIENTE+SE1->E1_LOJA+dtos(mv_par05-1) ))
				Reclock("TRB",.F.)
				Replace TR_SALDO   With TR_SALDO + (nSaldo * nSigno)
				Replace TR_VALOR   With TR_VALOR + (SE1->E1_VLCRUZ * nSigno )
				MsUnlock()
			Else
				RecLock("TRB",.T.)
				Replace TR_CLIENTE With SE1->E1_CLIENTE
				Replace TR_LOCAL   With SE1->E1_LOJA
				Replace TR_NOME    With OemToAnsi(STR0021)  // "Saldo acumulado al"
				Replace TR_NATUREZ With "--------->"
				Replace TR_VALOR   With ( SE1->E1_VLCRUZ * nSigno )
				Replace TR_SALDO   With (nSaldo * nSigno)
				Replace TR_EMISSAO With MV_PAR05 - 1
				Replace TR_CART    With 0
				Replace TR_VENCTO  With SE1->E1_VENCTO
				Replace TR_VENCREA With SE1->E1_VENCREA
				MsUnLock()
			Endif
			DbSelectArea("SE1")
			DbSkip()
			Loop
		ENDIF
		DbSelectArea("SA1")
		DbSetOrder(1)
		MsSeek( xFilial("SA1") + SE1->E1_CLIENTE + SE1->E1_LOJA )

		DbSelectArea("TRB")
		RecLock("TRB",.T.)
		Replace TR_CLIENTE With SE1->E1_CLIENTE
		Replace TR_LOCAL   With SE1->E1_LOJA
		Replace TR_NOME    With SubStr( SA1->A1_NOME, 1, 20 )
		Replace TR_PREFIXO With SE1->E1_PREFIXO
		Replace TR_DOC     With SE1->E1_NUM
		Replace TR_TIPO    With IIF(ALLTRIM(SE1->E1_TIPO)$"NF/FT","FT",ALLTRIM(SE1->E1_TIPO))
		Replace TR_TIPOORI With SE1->E1_TIPO
		Replace TR_PARCELA With SE1->E1_PARCELA
		Replace TR_EMISSAO With SE1->E1_EMISSAO
		Replace TR_VENCTO  With SE1->E1_VENCTO
		Replace TR_VENCREA With SE1->E1_VENCREA
		Replace TR_BANCO   With SE1->E1_BCOCHQ
		Replace TR_SITUACA With SE1->E1_SITUACA
		Replace TR_VALOR   With ( SE1->E1_VLCRUZ * nSigno )
		Replace TR_SALDO   With  nSaldo * nSigno
		Replace TR_NATUREZ With SE1->E1_NATUREZ
		Replace TR_CART    With IIF(ALLTRIM(SE1->E1_TIPO)=="CH",1,0)

		MsUnLock()

		DbSelectArea("SE1")
		DbSkip()

	EndDo

	DbSelectArea("TRB")
	DbGoTop()

Return
