/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GFEA056.ch"
#INCLUDE "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} GFEA056

Enviar Pré-Fatura

@author Israel Alcantara Possoli
@since 04/12/09
@version 1.0
/*/
//-------------------------------------------------------------------
User Function GFEA056()
	Local oReport
	Local aArea := GetArea()
	Private cAliasGWJ := GetNextAlias()

	If TRepInUse()
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf

	RestArea( aArea )
Return


//-------------------------------------------------------------------
/*/ReportDef
Uso Interno

@author Israel Alcantara Possoli
@since 04/12/09
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function ReportDef()
	Local oReport, oSection1, oSection2
	Local oSection3
	Local aOrdem    := {}

	//--------------------------------------------------------------------------
	//Criacao do componente de impressao
	//--------------------------------------------------------------------------
	//TReport():New
	//ExpC1 : Nome do relatorio
	//ExpC2 : Titulo
	//ExpC3 : Pergunte
	//ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
	//ExpC5 : Descricao
	//--------------------------------------------------------------------------

	oReport:= TReport():New("GFEA056",'Envio de Pré-faturas',"GFEA056", {|oReport| ReportPrint(oReport)},STR0002)  //"Envio de Pré-fatua"###"Envio de pré-faturas."
	oReport:SetLandscape()
	oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
	oReport:SetTotalInLine(.F.)
	oReport:nFontBody	:= 10 // Define o tamanho da fonte.
	oReport:nLineHeight	:= 50 // Define a altura da linha.
	Pergunte("GFEA056",.F.)
	//--------------------------------------------------------------------------
	//Criacao da secao utilizada pelo relatorio
	//--------------------------------------------------------------------------
	//TRSection():New
	//ExpO1 : Objeto TReport que a secao pertence
	//ExpC2 : Descricao da seçao
	//ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela
	//        sera considerada como principal para a seção.
	//ExpA4 : Array com as Ordens do relatório
	//ExpL5 : Carrega campos do SX3 como celulas
	//        Default : False
	//ExpL6 : Carrega ordens do Sindex
	//        Default : False
	//--------------------------------------------------------------------------
	//Criacao da celulas da secao do relatorio
	//
	//TRCell():New
	//ExpO1 : Objeto TSection que a secao pertence
	//ExpC2 : Nome da celula do relatório. O SX3 será consultado
	//ExpC3 : Nome da tabela de referencia da celula
	//ExpC4 : Titulo da celula
	//        Default : X3Titulo()
	//ExpC5 : Picture
	//        Default : X3_PICTURE
	//ExpC6 : Tamanho
	//        Default : X3_TAMANHO
	//ExpL7 : Informe se o tamanho esta em pixel
	//        Default : False
	//ExpB8 : Bloco de código para impressao.
	//        Default : ExpC2
	//--------------------------------------------------------------------------

	Aadd( aOrdem, STR0003 ) // "Sequência" //"Codigo"

	oSection1 := TRSection():New(oReport,STR0004,{(cAliasGWJ)},aOrdem) // "Pré-fatura" //"Pré-fatura"
	oSection1:SetLineStyle() //Define a impressao da secao em linha
	oSection1:SetTotalInLine(.F.)
	TRCell():New(oSection1,"GWJ_FILIAL",(cAliasGWJ),/*cTitle*/  ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GWJ_NRPF"  ,(cAliasGWJ),/*cTitle*/  ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GWJ_CDTRP" ,(cAliasGWJ),/*cTitle*/  ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"GWJ_SIT"   ,(cAliasGWJ),/*cTitle*/  ,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1,"cDtImpl"   ,""         ,"Dt Criacao",""                        , 10, /*lPixel*/, {||cDtImpl})
	TRCell():New(oSection1,"nVLPF"     ,""         ,"Valor PF"  ,"@E 999,999.99"/*Picture*/, 12, /*lPixel*/, {||nVLPF})

	oSection2 := TRSection():New(oSection1,STR0005,{"GW1"},aOrdem) // "Documento de carga" //"Documento de Carga"
	oSection2:SetTotalInLine(.F.)
	oSection2:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection2,"GW1_SERDC" ,"GW1",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GW1_NRDC"  ,"GW1",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GW1_EMISDC","GW1",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

	oSection3 := TRSection():New(oSection2,STR0006,{"GW8"},aOrdem) // "Documento de carga" //"Itens do Documento de Carga"
	oSection3:SetTotalInLine(.F.)
	oSection3:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection3,"GW8_ITEM"  ,"GW8",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GW8_DSITEM","GW8",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GW8_QTDE"  ,"GW8",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GW8_VALOR" ,"GW8",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

	oSection4 := TRSection():New(oSection2,STR0007,{"GWB"},aOrdem) // "Documento de carga" //"Unitizadores do Documento de Carga"
	oSection4:SetTotalInLine(.F.)
	oSection4:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection4,"GWB_CDUNIT","GWB",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection4,"GWB_DSUNIT","GWB",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection4,"GWB_QTDE"  ,"GWB",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
Return(oReport)


//-------------------------------------------------------------------
/* ReportPrint
Uso Interno

@author Israel Alcantara Possoli
@since 06/07/15
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function ReportPrint(oReport)
	Local oSection1  := oReport:Section(1)
	Local oSection2  := oReport:Section(1):Section(1)
	Local oSection3  := oReport:Section(1):Section(1):Section(1)
	Local oSection4  := oReport:Section(1):Section(1):Section(2)
	Local cCondSit   := ""
	Local cTpCalc    := ""
	Local lCabecImp  := .F.	// Cabeçalho impresso
	Local cEmailPara := ""
	Local aRetMail[2]
	Local cAliasGWH
	Local nCountGWJ
	Private cEmailMsg  := ""
	Private nVLPF
	Private cDtImpl

	//MV_PAR01 = Filial Inicio
	//MV_PAR02 = Filial Fim
	//MV_PAR03 = Transportador Inicio
	//MV_PAR04 = Transportador Fim
	//MV_PAR05 = Data de Geração de
	//MV_PAR06 = Data de Geração ate
	//MV_PAR07 = Nr Pre-fatura de
	//MV_PAR08 = Nr Pre-fatura ate
	//MV_PAR09 = Tipo Docto Carga de
	//MV_PAR10 = Tipo Docto Carga ate

	//MV_PAR11 = Tipo Normal
	//MV_PAR12 = Complementar de Valor
	//MV_PAR13 = Complementar de Imposto
	//MV_PAR14 = Reentrega
	//MV_PAR15 = Devolucao
	//MV_PAR16 = Redespacho
	//MV_PAR17 = Servico

	//MV_PAR18 = Pendentes
	//MV_PAR17 = Enviadas
	//MV_PAR20 = Confirmadas
	//MV_PAR21 = Vinculadas a Fatura
	//MV_PAR22 = Canceladas
	//MV_PAR23 = Enviar por e-mail

	//----------------------------------------------------------
	//  Tipo do Cálculo
	//----------------------------------------------------------
	// 1 - Normal
	If MV_PAR11 == 1
		if cTpCalc != ""
			cTpCalc := cTpCalc + ".OR."
		EndIf
		cTpCalc := cTpCalc + 'GWF->GWF_TPCALC == "1"'
	EndIf
	// 2 - Complementar de Valor
	If MV_PAR12 == 1
		if cTpCalc != ""
			cTpCalc := cTpCalc + ".OR."
		EndIf
		cTpCalc := cTpCalc + 'GWF->GWF_TPCALC == "2"'
	EndIf
	// 3 - Complementar de Imposto
	If MV_PAR13 == 1
		if cTpCalc != ""
			cTpCalc := cTpCalc + ".OR."
		EndIf
		cTpCalc := cTpCalc + 'GWF->GWF_TPCALC == "3"'
	EndIf
	// 4 - Reentrega
	If MV_PAR14 == 1
		if cTpCalc != ""
			cTpCalc := cTpCalc + ".OR."
		EndIf
		cTpCalc := cTpCalc + 'GWF->GWF_TPCALC == "4"'
	EndIf
	// 5 - Devolucao
	If MV_PAR15 == 1
		if cTpCalc != ""
			cTpCalc := cTpCalc + ".OR."
		EndIf
		cTpCalc := cTpCalc + 'GWF->GWF_TPCALC == "5"'
	EndIf
	// 6 - Redespacho
	If MV_PAR16 == 1
		if cTpCalc != ""
			cTpCalc := cTpCalc + ".OR."
		EndIf
		cTpCalc := cTpCalc + 'GWF->GWF_TPCALC == "6"'
	EndIf
	// 7 - Servico
	If MV_PAR17 == 1
		if cTpCalc != ""
			cTpCalc := cTpCalc + ".OR."
		EndIf
		cTpCalc := cTpCalc + 'GWF->GWF_TPCALC == "7"'
	EndIf

	If cTpCalc == ""
		cTpCalc := ".F."
	EndIf	


	//----------------------------------------------------------
	//  Situação Pré-Fatura
	//----------------------------------------------------------
	// Pendente
	If MV_PAR18 == 1
		if cCondSit != ""
			cCondSit := cCondSit + " OR "
		EndIf
		cCondSit := cCondSit + "GWJ_SIT = '1'"
	EndIf
	// Enviada
	If MV_PAR19 == 1
		if cCondSit != ""
			cCondSit := cCondSit + " OR "
		EndIf
		cCondSit := cCondSit +  "GWJ_SIT = '2'"
	EndIf
	// Confirmada
	If MV_PAR20 == 1
		if cCondSit != ""
			cCondSit := cCondSit + " OR "
		EndIf
		cCondSit := cCondSit + "GWJ_SIT = '3'"
	EndIf
	// Cancelada
	If MV_PAR22 == 1
		if cCondSit != ""
			cCondSit := cCondSit + " OR "
		EndIf
		cCondSit := cCondSit + "GWJ_SIT = '4'"
	EndIf


	//----------------------------------------------------------
	// SQL de busca das pré-faturas
	//----------------------------------------------------------	
	cQuery := "SELECT *"
	cQuery += " FROM " + RetSQLName("GWJ") + " GWJ"
	cQuery += " WHERE GWJ_FILIAL >= '" + MV_PAR01 + "' AND GWJ_FILIAL <= '" + MV_PAR02 + "'"
	cQuery += " AND GWJ_CDTRP  >= '" + MV_PAR03 + "' AND GWJ_CDTRP  <= '" + MV_PAR04 + "'"
	cQuery += " AND GWJ_DTIMPL >= '" + DTOS(MV_PAR05) + "' AND GWJ_DTIMPL <= '" + DTOS(MV_PAR06) + "'"
	cQuery += " AND GWJ_NRPF   >= '" + MV_PAR07 + "' AND GWJ_NRPF   <= '" + MV_PAR08 + "'"

	If MV_PAR21 == 1
		cQuery +=  "AND (GWJ_NRFAT <> '' AND GWJ_NRFAT <> '0')"
	EndIf

	If !Empty(cCondSit)
		cQuery += " AND (" + cCondSit + ")"
	EndIf

	cQuery += " AND GWJ.D_E_L_E_T_ = ''"

	cQuery := ChangeQuery(cQuery)

	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasGWJ, .F., .T.)

	//----------------------------------------------------------
	//Seta regua de processamento
	//----------------------------------------------------------
	nCountGWJ := 0

	dbSelectArea(cAliasGWJ)
	(cAliasGWJ)->( dbGoTop() )
	While !(cAliasGWJ)->(Eof())
		nCountGWJ++
		(cAliasGWJ)->(dbSkip())
	EndDo

	oReport:SetMeter(nCountGWJ)

	oSection1:Init()

	dbSelectArea(cAliasGWJ)
	(cAliasGWJ)->( dbGoTop() )
	While !oReport:Cancel() .AND. !(cAliasGWJ)->(Eof())

		lCabecImp := .F.

		cDtImpl := STOD((cAliasGWJ)->GWJ_DTIMPL)

		// Valor da Pré-Fatura
		nVLPF := 0
		dbselectarea("GWF")
		GWF->( dbSetOrder(3) )
		GWF->( dbSeek((cAliasGWJ)->GWJ_FILIAL + (cAliasGWJ)->GWJ_NRPF) )
		While !GWF->( Eof() ) .And. (cAliasGWJ)->GWJ_FILIAL + (cAliasGWJ)->GWJ_NRPF == GWF->GWF_FILPRE + GWF->GWF_NRPREF
			nVLPF += VLTOTFRET()
			GWF->( dbSkip() )
		EndDo

		oReport:IncMeter()
		oReport:SkipLine()
		oSection1:PrintLine()
		oReport:SkipLine()


		// === GWF - Cálculo de Frete ==============================
		dbSelectArea("GWF")
		dbSetOrder(3) // GWF_FILPRE+GWF_NRPREF
		dbSeek((cAliasGWJ)->GWJ_FILIAL + (cAliasGWJ)->GWJ_NRPF)
		While !oReport:Cancel() .And. !GWF->(Eof()) ;
								.AND. GWF->GWF_FILPRE == (cAliasGWJ)->GWJ_FILIAL ;
								.AND. GWF->GWF_NRPREF == (cAliasGWJ)->GWJ_NRPF

			If &(cTpCalc)

				dbSelectArea("GWJ")
				dbSetOrder(1)
				dbSeek((cAliasGWJ)->GWJ_FILIAL + (cAliasGWJ)->GWJ_NRPF)

				If (cAliasGWJ)->GWJ_SIT $ "13" .And. Empty((cAliasGWJ)->GWJ_DTENV) //Pendente ou Confirmada

					RecLock("GWJ",.F.)
					If GWJ->GWJ_SIT == "1"
						GWJ->GWJ_SIT := "2" // Altera a situação para Enviada
					EndIf
					GWJ->GWJ_USUENV := cUserName
					GWJ->GWJ_DTENV  := DDATABASE
					GWJ->GWJ_HRENV  := TIME()
					MsUnLock("GWJ")
				EndIf

				If !lCabecImp
					If MV_PAR23 == 1
						cEmailMsg = "<font face='verdana' size=2><h4>"+STR0009+"</h4>" //"Fatura"
						cEmailMsg += "<table cellpadding='3'><tr>"
						cEmailMsg += "<td><font size=2><b>"+STR0010+" </b></font></td><td><font size=2>" + AllTrim((cAliasGWJ)->GWJ_FILIAL) + "</font></td>" //"Filial:"
						cEmailMsg += "<td><font size=2><b>"+STR0011+" </b></font></td><td><font size=2>" + AllTrim((cAliasGWJ)->GWJ_NRPF) + "</font></td>" //"Número:"
						cEmailMsg += "<td><font size=2><b>"+"Transportador: "+" </b></font></td><td><font size=2>" + AllTrim((cAliasGWJ)->GWJ_CDTRP) + "</font></td>" //"Transportador:"
						If AllTrim(GWJ->GWJ_SIT) == '2' //1=Pendente;2=Enviada;3=Confirmada;4=Cancelada
							cEmailMsg += "<td><font size=2><b>"+STR0012+" </b></font></td><td><font size=2>" + "Enviada" + "</font></td>" //"Situação:"
						ElseIf AllTrim(GWJ->GWJ_SIT) == '3'
							cEmailMsg += "<td><font size=2><b>"+STR0012+" </b></font></td><td><font size=2>" + "Confirmada" + "</font></td>" //"Situação:"
						EndIF															
						cEmailMsg += "<td><font size=2><b>"+STR0013+" </b></font></td><td><font size=2>" + DTOC(STOD((cAliasGWJ)->GWJ_DTIMPL)) + "</font></td>" //"Data:"
						cEmailMsg += "<td><font size=2><b>"+"Valor PF: "+" </b></font></td><td><font size=2>" + AllTrim(Transform(nVLPF,"@E 999,999.99")) + "</font></td>" //"Valor PF:"
						cEmailMsg += "</tr></table>"
					EndIf
					lCabecImp := .T.
				EndIf

				// === GWH - Documento de Carga do Cálculo de Frete ==============================
				cQuery := "SELECT * FROM " + RetSQLName("GWH") + " GWH "
				cQuery += "WHERE "
				cQuery += " GWH_FILIAL = '"  + GWF->GWF_FILIAL + "' AND "
				cQuery += " GWH_NRCALC = '"  + GWF->GWF_NRCALC + "' AND "
				cQuery += " GWH_CDTPDC >= '" + MV_PAR09 + "' AND GWH_CDTPDC <= '" + MV_PAR10 + "' AND "
				cQuery += " GWH.D_E_L_E_T_ = ''"

				cQuery := ChangeQuery(cQuery)

				cAliasGWH := GetNextAlias()
				dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasGWH, .F., .T.)

				dbSelectArea(cAliasGWH)
				(cAliasGWH)->( dbGoTop() )
				While !oReport:Cancel() .AND. !(cAliasGWH)->(Eof())					
					// === GW1 - Documento de Carga =====================================
					oSection2:Init()

					dbselectarea("GW1")
					dbsetorder(1)
					dbSeek((cAliasGWH)->GWH_FILIAL + (cAliasGWH)->GWH_CDTPDC + (cAliasGWH)->GWH_EMISDC + (cAliasGWH)->GWH_SERDC + (cAliasGWH)->GWH_NRDC)
					While !oReport:Cancel() .And. !GW1->(Eof()) 	  .AND. ;
					GW1->GW1_FILIAL == (cAliasGWH)->GWH_FILIAL .AND. ;
					GW1->GW1_CDTPDC == (cAliasGWH)->GWH_CDTPDC .AND. ;
					GW1->GW1_EMISDC == (cAliasGWH)->GWH_EMISDC .AND. ;
					GW1->GW1_SERDC  == (cAliasGWH)->GWH_SERDC  .AND. ;
					GW1->GW1_NRDC   == (cAliasGWH)->GWH_NRDC

						If MV_PAR23 == 1
							cEmailMsg += "<hr>"
							cEmailMsg += "<table cellpadding='3'>"
							cEmailMsg += "<tr><td colspan='6'><font size=2><b>"+STR0005+"</b></font></td></tr>" //"Documento de Carga"
							cEmailMsg += "<tr><td><font size=2><b>"+STR0011+" </b></font></td><td><font size=2>" + AllTrim(GW1->GW1_NRDC) + "</font></td>" //"Número:"
							cEmailMsg += "<td><font size=2><b>"+STR0014+" </b></font></td><td><font size=2>" + AllTrim(SerieNfId("GW1",2,"GW1_SERDC")) + "</font></td>" //"Série:"
							cEmailMsg += "<td><font size=2><b>"+STR0015+" </b></font></td><td><font size=2>" + AllTrim(GW1->GW1_EMISDC) + "</font></td>" //"Emissor:"
							cEmailMsg += "</tr></table>"
						EndIf

						oSection2:PrintLine()
						oReport:SkipLine()

						// === GW8 - Itens do Documento de Carga =====================================
						PrintGW8(oReport, oSection3)

						// === GWB - Unitizadores do Documento de Carga =====================================
						PrintGWB(oReport, oSection4)

						dbSelectArea("GW1")
						dbSkip()
					EndDo
					oSection2:Finish()

					(cAliasGWH)->(dbSkip())
				EndDo

				(cAliasGWH)->( dbCloseArea() )
			EndIf

			dbSelectArea("GWF")
			dbSkip()
		EndDo

		// Envia e-mail
		If MV_PAR23 == 1
			dbSelectArea("GU3")
			dbSetOrder(1)
			If dbSeek(xFilial("GU3") + (cAliasGWJ)->GWJ_CDTRP)
				dbSelectArea("GU2")
				dbSetOrder(1)
				dbSeek(xFilial("GU2") + (cAliasGWJ)->GWJ_CDTRP)
				While !EOF().AND.GU2->GU2_CDEMIT == (cAliasGWJ)->GWJ_CDTRP
					If GU2->GU2_RECPRE == "1"
						cEmailPara += AllTrim(GU2->GU2_EMAIL) + ";"
					EndIf
					dbSkip()
				EndDo
				cEmailMsg += "</font>"
				If Empty(cEmailPara)
					Alert("Verifique se no cadastro de Emitente existe contato para o Transportador(Código - " + AllTrim((cAliasGWJ)->GWJ_CDTRP) + ") e se o contato está com o parâmetro Rec Pre-Fat marcado como Sim. ")
				Else
					aRetMail := GFEMail(cEmailPara, STR0004, cEmailMsg,.F.) //"Pré-Fatura"
					If aRetMail[1] = .F.
						Alert(aRetMail[2])
					EndIf
				EndIf
				cEmailMsg  := ""
				cEmailPara := ""
			EndIf
		EndIf	

		(cAliasGWJ)->(dbSkip())
	EndDo

	(cAliasGWJ)->( dbCloseArea() )
	oSection1 :Finish()
Return


//-------------------------------------------------------------------
/*/PrintGW8
Uso Interno

@author Israel Alcantara Possoli
@since 04/12/09
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function PrintGW8(oReport, oSection)
	dbselectarea("GW8")
	dbsetorder(1)
	If dbSeek(GW1->GW1_FILIAL + GW1->GW1_CDTPDC + GW1->GW1_EMISDC + GW1->GW1_SERDC + GW1->GW1_NRDC)
		oSection:Init()
		If MV_PAR23 == 1
			cEmailMsg += "<br><table cellpadding='3' border='1'>"
			cEmailMsg += "<tr><td colspan='4'><font size=2><b>"+STR0006+"</b></font></td></tr>" //"Itens do Documento de Cargas"
			cEmailMsg += "<td><font size=2><b>"+STR0016+"</b></font></td>" //"Item"
			cEmailMsg += "<td><font size=2><b>"+STR0017+"</b></font></td>" //"Descrição"
			cEmailMsg += "<td><font size=2><b>"+STR0018+"</b></font></td>" //"Qtde"
			cEmailMsg += "<td><font size=2><b>"+STR0019+"</b></font></td></tr>" //"Valor"
		EndIf

		While !oReport:Cancel() .AND. !GW8->(Eof()) .AND. ;
		GW8->GW8_FILIAL == GW1->GW1_FILIAL	.AND. ;
		GW8->GW8_CDTPDC == GW1->GW1_CDTPDC	.AND. ;
		GW8->GW8_EMISDC == GW1->GW1_EMISDC	.AND. ;
		GW8->GW8_SERDC  == GW1->GW1_SERDC		.AND. ;
		GW8->GW8_NRDC   == GW1->GW1_NRDC

			If MV_PAR23 == 1
				cEmailMsg += "<tr>"
				cEmailMsg += "<td><font size=2>" + AllTrim(GW8->GW8_ITEM) + "</font></td>"
				cEmailMsg += "<td><font size=2>" + AllTrim(GW8->GW8_DSITEM) + "</font></td>"
				cEmailMsg += "<td><font size=2>" + STR(GW8->GW8_QTDE) + "</font></td>"
				cEmailMsg += "<td><font size=2>" + STR(GW8->GW8_VALOR) + "</font></td>"
				cEmailMsg += "</tr>"
			EndIf

			oSection:PrintLine()

			dbSelectArea("GW8")
			dbSkip()
		EndDo

		If MV_PAR23 == 1
			cEmailMsg += "</table>"
		EndIf

		oSection:Finish()
	EndIf
Return


//-------------------------------------------------------------------
/*/PrintGWB
Uso Interno

@author Israel Alcantara Possoli
@since 04/12/09
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function PrintGWB(oReport, oSection)
	dbselectarea("GWB")
	dbsetorder(2)
	If dbSeek(GW1->GW1_FILIAL + GW1->GW1_CDTPDC + GW1->GW1_EMISDC + GW1->GW1_SERDC + GW1->GW1_NRDC)
		oSection:Init()

		If MV_PAR23 == 1
			cEmailMsg += "<br><table cellpadding='3' border='1'><tr>"
			cEmailMsg += "<tr><td colspan='3'><font size=2><b>"+STR0008+"</b></font></td></tr>" //"Unitizadores"
			cEmailMsg += "<td><font size=2><b>"+STR0003+"</b></font></td>" //"Código"
			cEmailMsg += "<td><font size=2><b>"+STR0017+"</b></font></td>" //"Descrição"
			cEmailMsg += "<td><font size=2><b>"+STR0018+"</b></font></td></tr>" //Qtde
		EndIf

		While !oReport:Cancel() .And. !GWB->(Eof()) .AND. ;
		GWB->GWB_FILIAL == GW1->GW1_FILIAL	.AND. ;
		GWB->GWB_CDTPDC == GW1->GW1_CDTPDC	.AND. ;
		GWB->GWB_EMISDC == GW1->GW1_EMISDC	.AND. ;
		GWB->GWB_SERDC  == GW1->GW1_SERDC		.AND. ;
		GWB->GWB_NRDC   == GW1->GW1_NRDC

			If MV_PAR23 == 1
				cEmailMsg += "<tr>"
				cEmailMsg += "<td><font size=2>" + AllTrim(GWB->GWB_CDUNIT)  + "</font></td>"
				dbSelectArea("GUG")
				dbSetOrder(1)
				If dbSeek(xFilial("GUG")+GWB->GWB_CDUNIT)
					cEmailMsg += "<td><font size=2>" + AllTrim(GUG->GUG_DSUNIT) + "</font></td>"
				Endif
				cEmailMsg += "<td><font size=2>" + STR(GWB->GWB_QTDE) + "</font></td>"
				cEmailMsg += "</tr>"
			EndIf

			oSection:PrintLine()

			dbSelectArea("GWB")
			dbSkip()
		EndDo

		If MV_PAR23 == 1
			cEmailMsg += "</table>"
		EndIf

		oSection:Finish()
	EndIf

Return
