/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'TOTVS.CH'
#include 'FINR198.CH'
//#Include "FwLibVersion.ch"

Static cTMPSE5198		:= "TMPSE5198"
Static cTMPSED198		:= "TMPSED198"
Static lExistFKD		:= Nil
Static __oCheque		:= Nil
Static __lCachedQry		:= Nil
Static __oProcFK6		:= Nil
Static __oEstCheq		:= Nil
Static __nDecs			:= Nil
Static __lImposBx       := .T.
Static __lPccBxCP       := .F.
Static __lIssBxCP       := .F.
Static __lPccBxCR       := .F.
Static __lIssBxCR       := .F.
Static __nCasDec        := 2
Static __cSeqBaix       := ""
Static __cDbName		:= ""

//------------------------------------
/*/{Protheus.doc} FINR198
Relação de baixas por natureza

@author Marcos Berto
@since 07/01/2013
@version 12
/*/
//------------------------------------
User Function FINR198()
	Local oReport := Nil
	Local lNatSint := SuperGetMV("MV_NATSINT", .F., "2" ) == "1"

	If !lNatSint
		Help(Nil, Nil, "MV_NATSINT", Nil, STR0040 + CRLF + STR0041 + CRLF + STR0042, 1, 0)
	EndIf

	oReport := ReportDef()
	oReport:PrintDialog()
Return

//------------------------------------
/*/{Protheus.doc} ReportDef
Definição da estrutura do relatório
Primeira sessão - Dados dos títulos
Segunda sessão - Totalizador pelas sintéticas

@author    Marcos Berto
@version   11.80
@since     07/01/13

@return oReport - Objeto de Relatório
/*/
//------------------------------------
Static Function ReportDef()
	Local nX		:= 0
	Local nPosFim	:= 0
	Local nTam		:= 0
	Local oSecTit   := Nil
	Local oSecTot   := Nil
	Local oReport   := Nil
	Local oSecFil	:= Nil
	Local cMascara  := ""
	Local nTamVal   := 0

	If lExistFKD == Nil
		lExistFKD := TableInDic('FKD')
	Endif

	oReport := TReport():New("FINR198", STR0002, "FIN198", {|oReport| ReportPrint(oReport)}, STR0002) //"Relação de Baixas por Natureza"
	oReport:SetLandscape(.T.)
	oReport:SetUseGC(.F.)

	dbSelectArea("SE2")
	cMascara := PesqPict("SE5","E5_VALOR")
	nTamVal  := TamSX3("E5_VALOR")[1]

	oSecTit := TRSection():New(oReport, STR0003 /*"Movimentos"*/)

	TRCell():New(oSecTit, "PREFIXO", Nil, STR0015, PesqPict("SE5","E5_PREFIXO"), TamSX3("E5_PREFIXO")[1], .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.) //Prf
	TRCell():New(oSecTit, "NUMERO",  Nil, STR0016, PesqPict("SE5","E5_NUM"),     TamSX3("E5_NUMERO")[1],  .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.) //Numero
	TRCell():New(oSecTit, "PARCELA", Nil, STR0017, PesqPict("SE5","E5_PARCELA"), TamSX3("E5_PARCELA")[1], .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.) //Prc
	TRCell():New(oSecTit, "TIPO",    Nil, STR0018, PesqPict("SE5","E5_TIPO"),    TamSX3("E5_TIPO")[1]	, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.) //Tp
	TRCell():New(oSecTit, "CLIFOR",  Nil, STR0019, PesqPict("SE5","E5_CLIFOR"),  TamSX3("E5_FORNECE")[1], .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.) //Cli/For
	TRCell():New(oSecTit, "LOJA",    Nil, STR0020, PesqPict("SE5","E5_LOJA"),    TamSX3("E5_LOJA")[1]	, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.) //Lj
	TRCell():New(oSecTit, "NOME",    Nil, STR0021, PesqPict("SE2","E2_NOMFOR"),  15						, .F., Nil, Nil, .T., Nil, Nil, Nil, .F.) //Nome
	TRCell():New(oSecTit, "VENCTO",  Nil, STR0022, PesqPict("SE5","E5_VENCTO"),  10						, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.) //Vencto
	TRCell():New(oSecTit, "DTDIGIT", Nil, STR0023, PesqPict("SE5","E5_DTDIGIT"), 10						, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.) //Dt.Dig.
	TRCell():New(oSecTit, "BAIXA",   Nil, STR0024, PesqPict("SE5","E5_DATA"),    10						, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.) //Baixa
	TRCell():New(oSecTit, "HIST",    Nil, STR0025, PesqPict("SE5","E5_HIST"),    25						, .F., Nil, Nil, .T., Nil, Nil, Nil, .F.) //Historico
	TRCell():New(oSecTit, "VALORIG", Nil, STR0004, cMascara, nTamVal, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.) //Valor Orig
	TRCell():New(oSecTit, "JURMUL",  Nil, STR0005, cMascara, nTamVal, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.) //uros/Multa

	If lExistFKD
		TRCell():New(oSecTit,"VALACESS", Nil, STR0039, cMascara, TamSX3("FKD_VLCALC")[1], .F. , Nil, Nil, Nil, Nil, Nil, Nil, .F.) //Valores Acessorios
	EndIf

	TRCell():New(oSecTit,"VALCORR", Nil, STR0006, cMascara ,nTamVal, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.) //Correção
	TRCell():New(oSecTit,"DESCONT", Nil, STR0007, cMascara ,nTamVal, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.) //Desconto
	TRCell():New(oSecTit,"ABATIM",  Nil, STR0008, cMascara ,nTamVal, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.) //Abatimento
	TRCell():New(oSecTit,"IMPOSTO", Nil, STR0009, cMascara ,nTamVal, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.) //Imposto
	TRCell():New(oSecTit,"BAIXADO", Nil, STR0010, cMascara ,nTamVal, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.) //Total Baixado
	TRCell():New(oSecTit,"BANCO",   Nil, STR0026, PesqPict("SE5","E5_BANCO"), TamSX3("E5_BANCO")[1], .F.,,,,,,,.F.) //Bco

	oSecTit:SetTotalInLine(.F.)
	oSecTit:SetHeaderPage(.T.)
	oSecTit:Cell("VALORIG"):SetAlign("RIGHT")
	oSecTit:Cell("JURMUL"):SetAlign("RIGHT")

	If lExistFKD
		oSecTit:Cell("VALACESS"):SetAlign("RIGHT")
	EndIf

	oSecTit:Cell("VALCORR"):SetAlign("RIGHT")
	oSecTit:Cell("DESCONT"):SetAlign("RIGHT")
	oSecTit:Cell("ABATIM"):SetAlign("RIGHT")
	oSecTit:Cell("IMPOSTO"):SetAlign("RIGHT")
	oSecTit:Cell("BAIXADO"):SetAlign("RIGHT")
	oSecTit:Cell("VALORIG"):SetHeaderAlign("RIGHT")
	oSecTit:Cell("JURMUL"):SetHeaderAlign("RIGHT")

	If lExistFKD
		oSecTit:Cell("VALACESS"):SetHeaderAlign("RIGHT")
	EndIf

	oSecTit:Cell("VALCORR"):SetHeaderAlign("RIGHT")
	oSecTit:Cell("DESCONT"):SetHeaderAlign("RIGHT")
	oSecTit:Cell("ABATIM"):SetHeaderAlign("RIGHT")
	oSecTit:Cell("IMPOSTO"):SetHeaderAlign("RIGHT")
	oSecTit:Cell("BAIXADO"):SetHeaderAlign("RIGHT")

	oSecTit:Cell("VALORIG"):SetNegative("PARENTHESES")
	oSecTit:Cell("JURMUL"):SetNegative("PARENTHESES")

	If lExistFKD
		oSecTit:Cell("VALACESS"):SetNegative("PARENTHESES")
	EndIf

	oSecTit:Cell("VALCORR"):SetNegative("PARENTHESES")
	oSecTit:Cell("DESCONT"):SetNegative("PARENTHESES")
	oSecTit:Cell("ABATIM"):SetNegative("PARENTHESES")
	oSecTit:Cell("IMPOSTO"):SetNegative("PARENTHESES")
	oSecTit:Cell("BAIXADO"):SetNegative("PARENTHESES")

	//Configura os totalizadores por natureza sintética
	oSecTot := TRSection():New(oReport, STR0011, Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil, Nil, .F.) //Totais
	nPosFim := aScan(oSecTit:aCell, {|x| x:cName == "HIST"})

	For nX := 1 to nPosFim
		nTam += oSecTit:Cell(oSecTit:aCell[nX]:cName):GetSize()
		nTam += oReport:nColSpace
	Next nX

	nTam -= oReport:nColSpace

	TRCell():New(oSecTot, "TITULO",  Nil, "",      Nil, nTam,    .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.)
	TRCell():New(oSecTot, "VALORIG", Nil, "", cMascara, nTamVal, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.)
	TRCell():New(oSecTot, "JURMUL",  Nil, "", cMascara, nTamVal, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.)

	If lExistFKD
		TRCell():New(oSecTot, "VALACESS", Nil, "", cMascara, nTamVal, .F., Nil, Nil, Nil, Nil, Nil, Nil,.F.)
	EndIf

	TRCell():New(oSecTot, "VALCORR", Nil, "", cMascara, nTamVal, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.)
	TRCell():New(oSecTot, "DESCONT", Nil, "", cMascara, nTamVal, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.)
	TRCell():New(oSecTot, "ABATIM",  Nil, "", cMascara, nTamVal, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.)
	TRCell():New(oSecTot, "IMPOSTO", Nil, "", cMascara, nTamVal, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.)
	TRCell():New(oSecTot, "BAIXADO", Nil, "", cMascara, nTamVal, .F., Nil, Nil, Nil, Nil, Nil, Nil, .F.)

	oSecTot:SetTotalInLine(.F.)
	oSecTot:SetHeaderPage(.F.)

	oSecTot:Cell("VALORIG"):SetAlign("RIGHT")
	oSecTot:Cell("JURMUL"):SetAlign("RIGHT")
	oSecTot:Cell("VALCORR"):SetAlign("RIGHT")
	oSecTot:Cell("DESCONT"):SetAlign("RIGHT")
	oSecTot:Cell("ABATIM"):SetAlign("RIGHT")
	oSecTot:Cell("IMPOSTO"):SetAlign("RIGHT")
	oSecTot:Cell("BAIXADO"):SetAlign("RIGHT")

	oSecTot:Cell("VALORIG"):SetHeaderAlign("RIGHT")
	oSecTot:Cell("JURMUL"):SetHeaderAlign("RIGHT")
	oSecTot:Cell("VALCORR"):SetHeaderAlign("RIGHT")
	oSecTot:Cell("DESCONT"):SetHeaderAlign("RIGHT")
	oSecTot:Cell("ABATIM"):SetHeaderAlign("RIGHT")
	oSecTot:Cell("IMPOSTO"):SetHeaderAlign("RIGHT")
	oSecTot:Cell("BAIXADO"):SetHeaderAlign("RIGHT")

	oSecTot:Cell("VALORIG"):SetNegative("PARENTHESES")
	oSecTot:Cell("JURMUL"):SetNegative("PARENTHESES")
	oSecTot:Cell("VALCORR"):SetNegative("PARENTHESES")
	oSecTot:Cell("DESCONT"):SetNegative("PARENTHESES")
	oSecTot:Cell("ABATIM"):SetNegative("PARENTHESES")
	oSecTot:Cell("IMPOSTO"):SetNegative("PARENTHESES")
	oSecTot:Cell("BAIXADO"):SetNegative("PARENTHESES")

	If lExistFKD
		oSecTot:Cell("VALACESS"):SetAlign("RIGHT")
		oSecTot:Cell("VALACESS"):SetHeaderAlign("RIGHT")
		oSecTot:Cell("VALACESS"):SetNegative("PARENTHESES")
	EndIf

	//Relacao das filiais selecionadas para compor o relatorio
	oSecFil := TRSection():New(oReport,"SECFIL",{"SE1","SED"})
	TRCell():New(oSecFil, "CODFIL",  Nil, STR0034, /*Picture*/, 20, /*lPixel*/, /*{|| code-block de impressao }*/)	//"Código"
	TRCell():New(oSecFil, "EMPRESA", Nil, STR0035, /*Picture*/, 60, /*lPixel*/, /*{|| code-block de impressao }*/)	//"Empresa"
	TRCell():New(oSecFil, "UNIDNEG", Nil, STR0036, /*Picture*/, 60, /*lPixel*/, /*{|| code-block de impressao }*/)	//"Unidade de negócio"
	TRCell():New(oSecFil, "NOMEFIL", Nil, STR0037, /*Picture*/, 60, /*lPixel*/, /*{|| code-block de impressao }*/)	//"Filial"
Return oReport

//------------------------------------
/*/{Protheus.doc} ReportPrint
Impressão do relatório
@author    Marcos Berto
@version   11.80
@since     27/12/12
@param oReport - Objeto de Relatório
/*/
//------------------------------------
Static Function ReportPrint(oReport)
	Local bVlOrig		:= Nil
	Local bVlBxd		:= Nil
	Local cNatPai		:= ""
	Local cNatureza		:= ""
	Local cDescricao	:= ""
	Local oSecTit		:= oReport:Section(1)
	Local oSecTot		:= oReport:Section(2)
	Local aSelFil		:= {}
	Local aSM0			:= {}
	Local nTamEmp		:= 0
	Local nTamUnNeg		:= 0
	Local nTamTit		:= 0
	Local nX			:= 0
	Local cFiLSel		:= ""
	Local cTitulo		:= ""
	Local oSecFil		:= oReport:Section("SECFIL")
	Local lGestao		:= FWSizeFilial() > 2	// Indica se usa Gestao Corporativa
	Local lSE5Access	:= IIf( lGestao, FWModeAccess("SE5",1) == "E", FWModeAccess("SE5",3) == "E")
	Local cCodNat		:= ""
	Local cDscNat       := ""
	Local nSelFil       := 0

	PRIVATE  aTotais	:= {}
	PRIVATE  aTotSint	:= {}

	If lExistFKD == Nil
		lExistFKD := TableInDic('FKD')
	Endif

	If __lCachedQry == Nil
		__lCachedQry := .T. //FwLibVersion() >= "20211116"
	EndIf

	//Força preenchimento dos parametros mv_parXX
	Pergunte("FIN198",.F.)

	If __nDecs == Nil
		__nDecs := MsDecimais(MV_PAR20)
	EndIf

	If MV_PAR19 == 1
		oSectit:Cell("NOME"):SetObfuscate( RetGlbLGPD('E1_NOMCLI') )
	else
		oSectit:Cell("NOME"):SetObfuscate( RetGlbLGPD('E2_NOMFOR') )
	Endif

	If MV_PAR36 == 1 .And. lSE5Access
		If lGestao .And. FindFunction("FwSelectGC")
			aSelFil := FwSelectGC()
		Else
			aSelFil := AdmGetFil(.F.,.F.,"SE5")
		EndIf
	EndIf

	If (nSelFil := Len(aSelFil)) == 0
		Aadd(aSelFil, cFilAnt)
		nSelFil := 1
	EndIf

	If !LockByName("FINR198SE5", .T., .F.)
		cTMPSE5198 := GetNextAlias()
	EndIf

	If !LockByName("FINR198SED", .T., .F.)
		cTMPSED198 := GetNextAlias()
	EndIf

	//Alimenta o arquivo temporário
	U_F198GerTrb(@aSelFil)

	//Totaliza por natureza
	U_F198TotNat()

	//imprime a lista de filiais selecionadas para o relatorio
	If nSelFil > 1 .And. !((cTMPSE5198)->(Eof()))
		oSecTit:SetHeaderSection(.F.)
		aSM0      := FWLoadSM0()
		nTamEmp   := Len(FWSM0LayOut(,1))
		nTamUnNeg := Len(FWSM0LayOut(,2))
		cTitulo   := oReport:Title()

		oReport:SetTitle(cTitulo + " (" + STR0038 + ")") //"Filiais selecionadas para o relatorio"
		nTamTit := Len(oReport:Title())
		oSecFil:Init()
		oSecFil:Cell("CODFIL"):SetBlock({||cFilSel})
		oSecFil:Cell("EMPRESA"):SetBlock({||aSM0[nLinha,SM0_DESCEMP]})
		oSecFil:Cell("UNIDNEG"):SetBlock({||aSM0[nLinha,SM0_DESCUN]})
		oSecFil:Cell("NOMEFIL"):SetBlock({||aSM0[nLinha,SM0_NOMRED]})

		For nX := 1 To nSelFil
			nLinha := Ascan(aSM0, {|sm0|, sm0[SM0_CODFIL] == aSelFil[nX]})

			If nLinha > 0
				cFilSel := Substr(aSM0[nLinha,SM0_CODFIL],1,nTamEmp)
				cFilSel += " "
				cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + 1,nTamUnNeg)
				cFilSel += " "
				cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + nTamUnNeg + 1)
				oSecFil:PrintLine()
			EndIf
		Next nX

		oReport:SetTitle(cTitulo)
		oSecFil:Finish()
		oSecTit:SetHeaderSection(.T.)
		oReport:EndPage()
	EndIf

	//Impressão dos dados
	dbSelectArea(cTMPSE5198)
	(cTMPSE5198)->(dbSetOrder(1))
	(cTMPSE5198)->(dbGoTop())

	//Seta os valores nas colunas
	oSecTit:Cell("PREFIXO"):SetBlock({|| (cTMPSE5198)->E5_PREFIXO })
	oSecTit:Cell("NUMERO"):SetBlock({||  (cTMPSE5198)->E5_NUMERO })
	oSecTit:Cell("PARCELA"):SetBlock({|| (cTMPSE5198)->E5_PARCELA })
	oSecTit:Cell("TIPO"):SetBlock({||    (cTMPSE5198)->E5_TIPO })
	oSecTit:Cell("CLIFOR"):SetBlock({||  (cTMPSE5198)->E5_CLIFOR })
	oSecTit:Cell("LOJA"):SetBlock({||    (cTMPSE5198)->E5_LOJA })
	oSecTit:Cell("NOME"):SetBlock({||    (cTMPSE5198)->E5_NOME })
	oSecTit:Cell("VENCTO"):SetBlock({||  (cTMPSE5198)->E5_VENCTO })
	oSecTit:Cell("DTDIGIT"):SetBlock({|| (cTMPSE5198)->E5_DTDIGIT })
	oSecTit:Cell("BAIXA"):SetBlock({||   (cTMPSE5198)->E5_DATA })
	oSecTit:Cell("HIST"):SetBlock({||    (cTMPSE5198)->E5_HISTOR })
	oSecTit:Cell("VALORIG"):SetBlock({|| (cTMPSE5198)->E5_VALORIG })
	oSecTit:Cell("JURMUL"):SetBlock({||  (cTMPSE5198)->(E5_VLJUROS+E5_VLMULTA)})

	If lExistFKD
		oSecTit:Cell("VALACESS"):SetBlock({|| (cTMPSE5198)->VALACESS })
	EndIf

	oSecTit:Cell("VALCORR"):SetBlock({|| (cTMPSE5198)->E5_VLCORRE })
	oSecTit:Cell("DESCONT"):SetBlock({|| (cTMPSE5198)->E5_VLDESCO })
	oSecTit:Cell("ABATIM"):SetBlock({||  (cTMPSE5198)->E5_ABATIM })
	oSecTit:Cell("IMPOSTO"):SetBlock({|| (cTMPSE5198)->E5_IMPOSTO })
	oSecTit:Cell("BAIXADO"):SetBlock({|| (cTMPSE5198)->E5_VALOR })
	oSecTit:Cell("BANCO"):SetBlock({||   (cTMPSE5198)->E5_BANCO })
	oSecTot:Cell("VALORIG"):SetBlock({|| (cTMPSED198)->VALORIG })
	oSecTot:Cell("JURMUL"):SetBlock({||  (cTMPSED198)->(VLJUROS+VLMULTA)})

	If lExistFKD
		oSecTot:Cell("VALACESS"):SetBlock({||(cTMPSED198)->VALACESS})
	EndIf

	oSecTot:Cell("VALCORR"):SetBlock({||(cTMPSED198)->VALCORR})
	oSecTot:Cell("DESCONT"):SetBlock({||(cTMPSED198)->VLDESCO})
	oSecTot:Cell("ABATIM"):SetBlock({||(cTMPSED198)->ABATIM})
	oSecTot:Cell("IMPOSTO"):SetBlock({||(cTMPSED198)->IMPOSTO})
	oSecTot:Cell("BAIXADO"):SetBlock({||(cTMPSED198)->VALOR})

	//Regras para soma do valor Original
	bVlOrig := {|| (cTMPSE5198)->E5_ULTBX == "S" .And. U_F198VldBx(cTMPSE5198) }
	bVlBxd  := {|| U_F198VldBx(cTMPSE5198) }

	cCodNat := (cTMPSE5198)->E5_NATUREZ
	cDscNat := (cTMPSE5198)->E5_NATDESC

	While !(cTMPSE5198)->(Eof())
		cNatPai := (cTMPSE5198)->E5_NATPAI
		oSecTit:Init()

		While (cTMPSE5198)->E5_NATPAI == cNatPai .And. !(cTMPSE5198)->(Eof())
			If cCodNat != (cTMPSE5198)->E5_NATUREZ
				If (cTMPSED198)->(DBSeek(cCodNat))
					oSecTit:Finish()
					oSecTot:Init()
					oSecTot:Cell("TITULO"):SetValue( STR0012 + MascNat( cCodNat,,,"") + " " + cDscNat ) //TOTAL DA NATUREZA ANALÍTICA
					oSecTot:PrintLine()
					oSecTot:Finish()
					U_F198IncTot(oReport, cCodNat, "aTotais" )
					oSecTit:Init()
				EndIf
			EndIf

			oSecTit:PrintLine()
			oReport:IncMeter()
			cNatureza  := (cTMPSE5198)->E5_NATUREZ
			cDescricao := (cTMPSE5198)->E5_NATDESC
			cCodNat    := (cTMPSE5198)->E5_NATUREZ
			cDscNat    := (cTMPSE5198)->E5_NATDESC
			(cTMPSE5198)->(dbSkip())
		EndDo

		oSecTit:Finish()

		If (cTMPSED198)->(DBSeek(cCodNat))
			oSecTot:Init() //Inicializa sessão dos Totais
			oSecTot:Cell("TITULO"):SetValue( STR0012 + MascNat( cCodNat,,,"") + " " + cDscNat ) //TOTAL DA NATUREZA ANALÍTICA
			oSecTot:PrintLine()
			oSecTot:Finish()
			U_F198IncTot(oReport, cCodNat, "aTotais" )
		EndIf

		dbSelectArea(cTMPSED198)
		(cTMPSED198)->(dbGoTop())

		While cNatPai <> ""
			If (cTMPSED198)->(dbSeek(cNatPai))
				If 	(cTMPSED198)->NIVEL == 1 //Só imprime o totalizador da sintética no último nível
					oSecTot:Init()
					oSecTot:Cell("TITULO"):SetValue( STR0013 + MascNat( (cTMPSED198)->NATUREZA,,,"") + " " + (cTMPSED198)->DESCNAT ) //TOTAL DA NATUREZA SINTÉTICA
					oSecTot:PrintLine()
					oSecTot:Finish()
					U_F198IncTot( oReport, (cTMPSED198)->NATUREZA, "aTotSint")
					oReport:IncMeter()
				Else
					Reclock(cTMPSED198,.F.)
					(cTMPSED198)->NIVEL -= 1
					(cTMPSED198)->(MsUnlock())
				EndIf

				//Controle de atualização das superiores imediatas
				cNatPai := (cTMPSED198)->NATPAI
			Else
				cNatPai := ""
			EndIf

			cCodNat := (cTMPSE5198)->E5_NATUREZ
			(cTMPSED198)->(dbSkip())
		EndDo
	EndDo

	(cTMPSE5198)->(dbCloseArea())
	(cTMPSED198)->(dbCloseArea())
	MsErase(cTMPSE5198)
	MsErase(cTMPSED198)

	FwFreeArray(aSM0)

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} F198GerTrb

Gera o arquivo temporário

@author    Marcos Berto
@version   11.80
@since     27/12/12

@param oReport - Objeto de Relatório

/*/
//------------------------------------------------------------------------------------------
User Function F198GerTrb(aSelFil as Array)
	Local aAux			as Array
	Local aStruct		as Array
	Local aValores		as Array
	Local cCposQry		as Character
	Local cCampo		as Character
	Local cTipoIn		as Character
	Local cTipoOut		as Character
	Local cSituacao		as Character
	Local cQuery		as Character
	Local cCarteira		as Character
	Local cAliasQry		as Character
	Local cTpSel		as Character
	Local cTpBusc		as Character
	Local lCreate		as Logical
	Local nX			as Numeric
	Local nI			as Numeric
	Local nTaxa			as Numeric
	Local nFator		as Numeric
	Local nMoedOrig		as Numeric
	Local nBaixado		as Numeric
	Local nMovFin		as Numeric
	Local nCompensa		as Numeric
	Local nFatura		as Numeric
	Local nPosNat		as Numeric
	Local lMulNat		as Logical
	Local cQuery2 		as Character
	Local cDBName		as Character
	Local nAux			as Numeric
	Local nResto		as Numeric
	Local cSitCartei	as Character
	Local cAdianta      as Character
	Local nStruct		as Numeric
	Local nValores		as Numeric
	Local nMoedaBx      as Numeric
	Local dDataBx       as Date
	Local oRatSev       as Object
	Local oQryFk1       as Object
	Local oQryFk2       as Object
	Local oRegCheq      as Object
	Local cMAEmpSED     as Character
	Local cMAUniSED     as Character
	Local cMAFilSED     as Character
	Local cMAEmpSE5     as Character
	Local cMAUniSE5     as Character
	Local cMAFilSE5     as Character
	Local cFilSE5       as Character
	Local aCampos       as Array
	Local cNumCheq      as Character
	Local cEdPai        as Character
	Local cFilOriAnt    as Character
	Local cChaveCh      as Character
	Local lAchouSE1     as Logical
	Local lAchouSE2     as Logical
	Local cQuery3		as Character
	Local cQuery4		as Character
	Local cChaveTit     as Character
	Local nCampo		as Numeric
	Local cCampos		as Character
	Local cValor		as Character
	Local cSQLValues	as Character
	Local nQtdInsert	as Numeric
	Local nRecno		as Numeric
	Local lUltBx		as Logical
	Local cNatureza		as Character
	Local cNatDesc		as Character
	Local cNatPai		as Character
	Local nVlrJuros		as Numeric
	Local nVlrCorre		as Numeric
	Local nVlrDesco		as Numeric
	Local nValAbatim	as Numeric
	Local nVlrImpost	as Numeric
	Local nSE5Valor		as Numeric
	Local nVlrMulta		as Numeric
	Local nValTitulo	as Numeric
	Local nValBaixa		as Numeric
	Local nSQLStatus	as Numeric
	Local lDbOracle		as Logical
	Local cSQLInsert	as Character
	Local nTargetIns	as Numeric
	Local nTamHist		as Numeric

	aAux       := {}
	aStruct    := {}
	aValores   := {}
	cCposQry   := ""
	cCampo     := ""
	cTipoIn    := ""
	cTipoOut   := ""
	cSituacao  := MV_PAR23
	cQuery     := ""
	cCarteira  := ""
	cAliasQry  := ""
	cTpSel     := ""
	cTpBusc    := ""
	lCreate    := .F.
	nX         := 0
	nI         := 0
	nTaxa      := 0
	nFator     := 1
	nMoedOrig  := 1
	nBaixado   := 0
	nMovFin    := 0
	nCompensa  := 0
	nFatura    := 0
	nPosNat    := 0
	lMulNat    := .F.
	cQuery2    := ''
	cDBName    := Alltrim(Upper(TCGetDB()))
	nAux       := 0
	nResto     := 0
	cSitCartei := FN022LSTCB(1) + Space(TamSx3("E5_SITCOB")[1])
	cAdianta   := MV_CPNEG+"|"+MVPAGANT+"|"+MV_CRNEG+"|"+MVRECANT
	nStruct    := 0
	nValores   := 0
	nMoedaBx   := 0
	dDataBx    := dDataBase
	oRatSev    := Nil
	oQryFk1    := Nil
	oQryFk2    := Nil
	oRegCheq   := Nil
	cMAEmpSED  := FWModeAccess("SED",1)
	cMAUniSED  := FWModeAccess("SED",2)
	cMAFilSED  := FWModeAccess("SED",3)
	cMAEmpSE5  := FWModeAccess("SE5",1)
	cMAUniSE5  := FWModeAccess("SE5",2)
	cMAFilSE5  := FWModeAccess("SE5",3)
	cFilSE5    := xFilial("SE5")
	aCampos    := {}
	cNumCheq   := ""
	cEdPai     := Padr(" ", TamSx3("ED_PAI")[1], " ")
	cFilOriAnt := ""
	cChaveCh   := ""
	lAchouSE1  := .F.
	lAchouSE2  := .F.
	cQuery3    := ""
	cQuery4    := ""
	cChaveTit  := ""
	nCampo     := 0
	cCampos    := ""
	cValor     := ""
	cSQLValues := ""
	nQtdInsert := 0
	nRecno     := 0
	lUltBx     := .F.
	cNatureza  := ""
	cNatDesc   := ""
	cNatPai    := ""
	nVlrJuros  := 0
	nVlrCorre  := 0
	nVlrDesco  := 0
	nValAbatim := 0
	nVlrImpost := 0
	nSE5Valor  := 0
	nVlrMulta  := 0
	nValTitulo := 0
	nValBaixa  := 0
	nSQLStatus := 0
	lDbOracle  := .F.
	cSQLInsert := ""
	nTargetIns := 0
	nTamHist   := 0

	Private dBaixa	:= dDataBase

	/****************************************
	mv_par01 - Do Codigo ?
	mv_par02 - Ate o Codigo ?
	mv_par03 - Da Loja ?
	mv_par04 - Ate a Loja ?
	mv_par05 - Do Prefixo ?
	mv_par06 - Ate o Prefixo ?
	mv_par07 - Da Natureza ?
	mv_par08 - Ate a Natureza ?
	mv_par09 - Do Banco ?
	mv_par10 - Ate o Banco ?
	mv_par11 - Da Data de Baixa ?
	mv_par12 - Ate a Data de Baixa ?
	mv_par13 - Da Data Digitacao ?
	mv_par14 - Ate a Data Digitacao ?
	mv_par15 - Da Data Vencto Tit. ?
	mv_par16 - Ate Data Vencto Tit. ?
	mv_par17 - Do Lote ?
	mv_par18 - Ate o Lote ?
	mv_par19 - Da Carteira ?
	mv_par20 - Qual Moeda ?
	mv_par21 - Outras Moedas ?
	mv_par22 - Imprime Baixas ?
	mv_par23 - Situacoes ?
	mv_par24 - Cons. Mov. Fin. da Baixa ?
	mv_par25 - Cons. Filiais Abaixo ?
	mv_par26 - Da Filial ?
	mv_par27 - Ate a Filial ?
	mv_par28 - Da Filial Origem ?
	mv_par29 - Ate a Filial de Origem ?
	mv_par30 - Imprimir Tipos ?
	mv_par31 - Nao Imprimir Tipos ?
	mv_par32 - Imprime Incl. Adiantamentos ?
	mv_par33 - Considera Compensados ?
	mv_par34 - Imprime Titulos em Carteira ?
	mv_par35 - Imprime Cheques Aglutinados ?
	mv_par36 - seleciona filiais ?
	*****************************************/

	__cDbName 	:= TCGetDb()
	lDbOracle 	:= __cDbName == "ORACLE"
	nTargetIns	:= IIf(lDbOracle, 50, 100)
	cCarteira 	:= Iif(mv_par19 == 1, "R", "P")
	__nCasDec 	:= IIf(mv_par19 == 1, TamSx3("E1_TXMOEDA")[2], TamSx3("E2_TXMOEDA")[2])
	nTamHist	:= TamSX3("E5_HISTOR")[1]

	//Seleção de Movimentos
	IF TCCANOPEN(cTMPSE5198)
		MsErase(cTMPSE5198)
	EndIf

	cCposQry := ""
	DbSelectArea("SE5")

	aStruct := SE5->(dbStruct())
	aEval(aStruct, {|e| cCposQry += "," + AllTrim(e[1]) })

	cCposQry += ",ED_FILIAL,ED_CODIGO,ED_DESCRIC,ED_PAI "

	cQuery   := "SELECT " + SubStr(cCposQry, 2) + " FROM " + RetSqlName("SE5") + " SE5 "
	cQuery   += "LEFT JOIN "+ RetSqlName("SED") +" SED ON ("

	//Tratamento compartilhamento entre SE5 e SED para várias filiais
	Do Case
		//Se compartilhamento for igual -> Filial com filial
		Case cMAEmpSE5 == cMAEmpSED .And. cMAUniSE5 == cMAUniSED .And. cMAFilSE5 == cMAFilSED
			cQuery += "SED.ED_FILIAL = SE5.E5_FILIAL "
		Case (cMAEmpSED+cMAUniSED+cMAFilSED) == "EEE"
			cQuery += "SED.ED_FILIAL = SE5.E5_FILORIG "
		Case cMAEmpSED == "C"
			cQuery += "SED.ED_FILIAL = '" + Space(FWSizeFilial()) + "' "
		Otherwise //Comparar o E5_FILORIG até onde for o compartilhamento da SED
			If cDBName == "MSSQL"
				nAux   := Len(RTrim(FWxFilial("SED")))
				nResto := FWSizeFilial() - nAux
				cQuery += "SED.ED_FILIAL = SUBSTRING(SE5.E5_FILORIG, 1, " + cValToChar(nAux) + ") + SPACE(" + cValToChar(nResto) + ") "
			Else
				cQuery += "SED.ED_FILIAL = RPAD(SUBSTRING(SE5.E5_FILORIG, 1, " + cValToChar(Len(RTrim(FWxFilial("SED")))) + "), " + cValToChar(FWSizeFilial()) + ",' ') "
			EndIf
	EndCase

	cQuery += "AND SED.ED_CODIGO = SE5.E5_NATUREZ AND SED.D_E_L_E_T_ = ' ' ) WHERE "

	If mv_par36 == 1 //Seleciona Filiais
		cQuery += FinSelFil(aSelFil, "SE5") + "AND "
	ElseIf mv_par25 == 1 //Considera filiais
		If Empty(cFilSE5)
			cQuery += "SE5.E5_FILORIG BETWEEN '"+ mv_par28 + "' AND '" + mv_par29 + "' AND "
		Else
			cQuery += "SE5.E5_FILIAL BETWEEN '"+ mv_par26 + "' AND '" + mv_par27 + "' AND "
		EndIf
	Else
		cQuery += "SE5.E5_FILIAL = '" + cFilSE5 + "' AND "
	Endif

	cQuery += "SE5.E5_PREFIXO BETWEEN '" + mv_par05	+ "' AND '" + mv_par06 + "' AND "
	cQuery += "SE5.E5_CLIFOR BETWEEN '"	 + mv_par01 + "' AND '" + mv_par02 + "' AND "
	cQuery += "SE5.E5_LOJA BETWEEN '"    + mv_par03 + "' AND '" + mv_par04 + "' AND "
	cQuery += "SE5.E5_NATUREZ BETWEEN '" + mv_par07 + "' AND '" + mv_par08 + "' AND "
	cQuery += "SE5.E5_BANCO BETWEEN '"   + mv_par09 + "' AND '"+ mv_par10 		+ "' AND "
	cQuery += "SE5.E5_DATA BETWEEN '"    + DtoS(mv_par11)   + "' AND '" + DtoS(mv_par12) + "' AND "
	cQuery += "SE5.E5_DTDIGIT BETWEEN '" + DtoS(mv_par13)   + "' AND '" + DtoS(mv_par14) + "' AND "
	cQuery += "SE5.E5_LOTE BETWEEN '" + mv_par17 		+ "' AND '"+ mv_par18 		+ "' AND "

	//Outras moedas
	If mv_par21 = 2 //Nao Imprimir
		cQuery += "SE5.E5_MOEDA = '" + PadL(AllTrim(Str(mv_par20)), TamSx3("E5_MOEDA")[1], "0")+ "' AND "
	EndIf

	//Tipos que serão impressos
	If !Empty(mv_par30)
		cTipoIn := FormatIn(mv_par30,";")
		cQuery  += "SE5.E5_TIPO IN " +cTipoIn+ " AND "
	EndIf

	//Tipos que não serão impressos
	If !Empty(mv_par31)
		cTipoOut := FormatIn(mv_par31,";")
		cQuery   += "SE5.E5_TIPO NOT IN " + cTipoOut + " AND "
	EndIf

	//Mov. Bancario da Baixa
	If mv_par24 == 2
		cQuery += "SE5.E5_TIPODOC <> '" + Space(TamSX3("E5_TIPODOC")[1]) + "' AND "
		cQuery += "SE5.E5_NUMERO  <> '" + Space(TamSX3("E5_NUMERO")[1]) + "' AND "
		cQuery += "SE5.E5_TIPODOC <> 'CH' AND "
	Endif

	cQuery += "SE5.E5_TIPODOC NOT IN ('DC','D2','JR','J2','TL','MT','M2','CM','C2','TR','TE','E2','VA') AND "
	cQuery += "SE5.E5_SITUACA NOT IN ('E','X') AND "

	If cCarteira == "R" //Receber
		cQuery += "((SE5.E5_RECPAG = 'R' AND SE5.E5_TIPODOC <> 'ES') OR "
		cQuery += " (SE5.E5_RECPAG = 'P' AND SE5.E5_TIPODOC = 'ES')) AND "
	Else //Pagar
		cQuery += "((SE5.E5_RECPAG = 'P' AND SE5.E5_TIPODOC <> 'ES') OR "
		cQuery += " (SE5.E5_RECPAG = 'R' AND SE5.E5_TIPODOC = 'ES')) AND "
	EndIf

	If cCarteira == "R" .And. mv_par34 = 1 .And. !Empty(cSitCartei) //Somente em carteira
		cQuery += " E5_SITCOB IN " + FormatIn(cSitCartei, "|") + " AND "
	EndIf

	cQuery    += "SED.ED_PAI <> '" + cEdPai + "' AND SED.ED_PAI IS NOT NULL AND SED.ED_PAI <> ' ' AND "
	cQuery    += "SE5.D_E_L_E_T_ = ' ' "
	cQuery    += "ORDER BY SED.ED_PAI,SED.ED_CODIGO "
	cQuery    :=  ChangeQuery(cQuery)
	cAliasQry :=  MpSysOpenQuery(cQuery)

	AAdd(aCampos, TamSX3(IIf(cCarteira == "R", "A1_NOME", "A2_NOME")))	//1
	AAdd(aCampos, TamSx3("E5_VALOR"))   								//2
	AAdd(aCampos, TamSx3("E5_NATUREZ")) 								//3
	AAdd(aCampos, TamSx3("ED_DESCRIC")) 								//4

	AAdd(aStruct, {"E5_NOME",    "C", aCampos[1,1],  aCampos[1,2]})
	AAdd(aStruct, {"E5_VALORIG", "N", aCampos[2,1],  aCampos[2,2]})
	AAdd(aStruct, {"E5_VALTIT",  "N", aCampos[2,1],  aCampos[2,2]})
	AAdd(aStruct, {"E5_ABATIM",  "N", aCampos[2,1],  aCampos[2,2]})
	AAdd(aStruct, {"E5_IMPOSTO", "N", aCampos[2,1],  aCampos[2,2]})
	AAdd(aStruct, {"E5_VALBX",   "N", aCampos[2,1],  aCampos[2,2]})
	AAdd(aStruct, {"E5_NATPAI",  "C", aCampos[3,1],  aCampos[3,2]})
	AAdd(aStruct, {"E5_NATDESC", "C", aCampos[4,1],  aCampos[4,2]})
	AAdd(aStruct, {"E5_ULTBX",   "C", 1, 0})
	AAdd(aStruct, {"VALACESS",   "N", aCampos[2,1], aCampos[2,2]})

	//Cria o arquivo temporário
	If (lCreate := (MsCreate(cTMPSE5198, aStruct, "TOPCONN")))
		DbSelectArea("SE1")
		DbSelectArea("SED")
		SED->(dbSetOrder(1))
		SE2->(DbSetOrder(1))
		SE1->(DbSetOrder(2))
		SE5->(DbSetOrder(11))

		nStruct  := Len(aStruct)
		cNumCheq := PadR(cNumCheq, TamSx3("E5_NUMCHEQ")[1], " ")		

		dbUseArea(.T., "TOPCONN", cTMPSE5198, cTMPSE5198, .T., .F.)
		dbSelectArea(cTMPSE5198)
		dbCreateIndex(cTMPSE5198 + "i","E5_NATPAI+E5_NATUREZ+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_FORNECE+E5_LOJA+E5_SEQ", {|| "E5_NATPAI+E5_NATUREZ+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_FORNECE+E5_LOJA+E5_SEQ"})
		dbSelectArea(cAliasQry)
		(cAliasQry)->(dbGoTop())

		If __oEstCheq == Nil
			cQuery2 := "SELECT COUNT(SE5.E5_BANCO) NTOTAL "
			cQuery2 += " FROM " + RetSqlName( "SE5" ) + " SE5 "
			cQuery2 += " WHERE SE5.E5_FILIAL = ? "
			cQuery2 +=   " AND SE5.E5_BANCO = ? "
			cQuery2 +=   " AND SE5.E5_AGENCIA = ? "
			cQuery2 +=   " AND SE5.E5_CONTA = ? "
			cQuery2 +=   " AND SE5.E5_NUMCHEQ = ? "
			cQuery2 +=   " AND SE5.E5_TIPODOC = ? "
			cQuery2 +=   " AND SE5.D_E_L_E_T_ = ? "
			cQuery2 := ChangeQuery(cQuery2)

			__oEstCheq := IIf(__lCachedQry, FwExecStatement():New(cQuery2), FwPreparedStatement():New(cQuery2))
		EndIf

		If __oCheque == Nil
			cQuery3 := "SELECT COUNT(*) CHEQUE "
			cQuery3 += " FROM " + RetSqlName("SE5") + " SE5 "
			cQuery3 += " WHERE SE5.E5_FILIAL = ?"
			cQuery3 +=   " AND SE5.E5_BANCO = ?"
			cQuery3 +=   " AND SE5.E5_AGENCIA = ?"
			cQuery3 +=   " AND SE5.E5_CONTA = ?"
			cQuery3 +=   " AND SE5.E5_NUMCHEQ = ?"
			cQuery3 +=   " AND (SE5.E5_TIPODOC = ? OR SE5.E5_NUMCHEQ = ?) "
			cQuery3 +=   " AND SE5.D_E_L_E_T_ = ? "
			cQuery3 := ChangeQuery(cQuery3)

			__oCheque := IIf(__lCachedQry, FwExecStatement():New(cQuery3), FwPreparedStatement():New(cQuery3))
		EndIf

		If __oProcFK6 == Nil
			cQuery4 := "SELECT COUNT(*) VA"
			cQuery4 += " FROM " + RetSQLName("FK6") + " FK6 "
			cQuery4 += " WHERE FK6.FK6_FILIAL = ? "
			cQuery4 +=   " AND FK6.FK6_IDORIG = ? "
			cQuery4 +=   " AND FK6.FK6_TABORI = ? "
			cQuery4 +=   " AND FK6.FK6_TPDOC =  ? "
			cQuery4 +=   " AND FK6.D_E_L_E_T_ = ? "
			cQuery4 := ChangeQuery(cQuery4)
			__oProcFK6 := IIf(__lCachedQry, FwExecStatement():New(cQuery4), FwPreparedStatement():New(cQuery4))
		EndIf

		cSQLInsert := " INTO " + cTMPSE5198 + " ("

		nCampo 	:= 0
		cCampos	:= ""
		For nCampo := 1 To nStruct
			cCampos += aStruct[nCampo][1] + ", "
		Next nCampo

		cSQLInsert += cCampos + "R_E_C_N_O_) VALUES "

		While (cAliasQry)->(!Eof())

			lAchouSE1 := .F. //Restaura as variaveis para novo laço
			lAchouSE2 := .F. //Restaura as variaveis para novo laço

			If !Empty((cAliasQry)->E5_TIPODOC) .And. !Empty((cAliasQry)->E5_NUMERO)
				//Motivo de baixa - normal/todos
				If mv_par22 == 1 .And. !MovBcoBx((cAliasQry)->E5_MOTBX)
					(cAliasQry)->(dbSkip())
					Loop
				EndIf

				//Adiantamento
				If mv_par32 == 2 .And. (cAliasQry)->E5_TIPO $ cAdianta
					(cAliasQry)->(dbSkip())
					Loop
				EndIf

				//Compensação
				If mv_par33 == 2 .And. (cAliasQry)->E5_TIPO $ cAdianta .And. (cAliasQry)->E5_MOTBX == "CMP"
					(cAliasQry)->(dbSkip())
					Loop
				EndIf

				//Valida informações dos títulos (SE1/SE2)
				If cCarteira == "R" //Receber
					lAchouSE1 := SE1->(DbSeek(xFilial("SE1",(cAliasQry)->E5_FILORIG) + (cAliasQry)->(E5_CLIFOR+E5_LOJA+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO)))

					If mv_par34 == 2 .And. !Empty(cSituacao) //Título em carteira já é filtrado na query, situação em branco não filtra
						//Valida situação
						If !Empty((cAliasQry)->E5_SITCOB)
							If !((cAliasQry)->E5_SITCOB $ cSituacao)
								(cAliasQry)->(dbSkip())
								Loop
							EndIf
						ElseIf lAchouSE1 .And. !Empty(SE1->E1_SITUACA) .And. !SE1->E1_SITUACA $ cSituacao
							(cAliasQry)->(dbSkip())
							Loop
						EndIf
					EndIf

					//Valida o vencimento do título
					If lAchouSE1 .And. (SE1->E1_VENCTO < mv_par15 .Or. SE1->E1_VENCTO > mv_par16)
						(cAliasQry)->(dbSkip())
						Loop
					EndIf
				Else //Pagar, valida o vencimento do título
					lAchouSE2 := SE2->(MsSeek(xFilial("SE2",(cAliasQry)->E5_FILORIG) + (cAliasQry)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)))

					If lAchouSE2 .And. (SE2->E2_VENCTO < mv_par15 .Or. SE2->E2_VENCTO > mv_par16)
						(cAliasQry)->(dbSkip())
						Loop
					EndIf
				EndIf
			EndIf

			If mv_par35 == 1
				cTpSel	:= "BA"
				cTpBusc	:= "CH"
			ElseIf mv_par35 == 2
				cTpSel	:= "CH"
				cTpBusc	:= "BA"
			EndIf

			If cFilOriAnt != (cAliasQry)->E5_FILORIG
				cFilOriAnt := (cAliasQry)->E5_FILORIG
				cFilSE5    := Iif(Empty(cFilOriAnt), xFilial("SE5"), xFilial("SE5", cFilOriAnt))
			EndIf

			If (cAliasQry)->E5_TIPODOC == cTpSel .And.;
				F198Cheque(cFilSE5, (cAliasQry)->E5_BANCO, (cAliasQry)->E5_AGENCIA, (cAliasQry)->E5_CONTA, (cAliasQry)->E5_NUMCHEQ, cTpBusc)
				(cAliasQry)->(DbSkip())
				Loop
			EndIf

			If F198EstChq(cFilSE5, (cAliasQry)->E5_BANCO, (cAliasQry)->E5_AGENCIA, (cAliasQry)->E5_CONTA, (cAliasQry)->E5_NUMCHEQ)
				(cAliasQry)->(DbSkip())
				Loop
			EndIf

			cTpSel := cTpBusc := ""

			If (lAchouSE1 .Or. lAchouSE2)
				If cChaveTit != (cAliasQry)->(E5_FILORIG + E5_PREFIXO + E5_NUMERO + E5_PARCELA + E5_TIPO + E5_CLIFOR + E5_LOJA)
					cChaveTit := (cAliasQry)->(E5_FILORIG + E5_PREFIXO + E5_NUMERO + E5_PARCELA + E5_TIPO + E5_CLIFOR + E5_LOJA)
					__cSeqBaix := ""
				EndIf
			Else
				__cSeqBaix := ""
			EndIf

			//Recupera os valores do movimento
			aValores := U_F198TotVal(cAliasQry, cCarteira, @oRatSev, @oQryFk1, @oQryFk2, lAchouSE1, lAchouSE2)

			/*aValores
			[x][1] = Natureza, [x][2] = Valor Original, [x][3] = Juros/Multa, [x][4] = Correção, [x][5] = Desconto, [x][6] = Abatimentos,
			[x][7] = Impostos, [x][8] = Valor Baixado, [x][09] = Sequência, [x][10] = Multa, [x][11] = Cancelado*/

			If (nValores := Len(aValores)) > 0
				cValor := ""

				nVA := 0

				If (lTemVA := lExistFKD .And. F198ProcVA((cAliasQry)->E5_FILIAL, (cAliasQry)->E5_IDORIG, (cAliasQry)->E5_TABORI))
					nVA := FK6Calc((cAliasQry)->E5_TABORI, (cAliasQry)->E5_IDORIG, (cAliasQry)->E5_TIPODOC)
				EndIf

				nMoedaBx := Val((cAliasQry)->E5_MOEDA)
				dDataBx  := StoD((cAliasQry)->E5_DATA)
				nTaxa    := 0

				//Verifica a taxa de conversão do título, quando aplicável
				If !Empty((cAliasQry)->E5_TXMOEDA)
					nTaxa := (cAliasQry)->E5_TXMOEDA
				ElseIf lAchouSE2 .And. cCarteira == "P" .And. ((SE2->E2_MOEDA != nMoedaBx) .Or. (SE2->E2_MOEDA > 1) .Or. (nMoedaBx > 1)) .And. Empty((nTaxa := SE2->E2_TXMOEDA))
					nTaxa := RecMoeda(dDataBx, SE2->E2_MOEDA)
				ElseIf lAchouSE1 .And. cCarteira == "R" .And. ((SE1->E1_MOEDA != nMoedaBx) .Or. (SE1->E1_MOEDA > 1) .Or. (nMoedaBx > 1)) .And. Empty((nTaxa := SE1->E1_TXMOEDA))
					nTaxa := RecMoeda(dDataBx, SE1->E1_MOEDA)
				EndIf

				//Altera a natureza Pai
				If MV_MULNATP
					If cCarteira == "R" .And. ((lAchouSE1 .And. SE1->E1_MULTNAT == "1") .Or. (cAliasQry)->E5_MULTNAT == "1")
						lMulNat := .T.
					ElseIf cCarteira == "P" .And. ((lAchouSE2 .And. SE2->E2_MULTNAT == "1") .Or. (cAliasQry)->E5_MULTNAT == "1")
						lMulNat := .T.
					EndIf
				EndIf

				nFator := 1

				If (cAliasQry)->E5_TIPODOC == "ES" //ESTORNO
					nFator := -1
				EndIf

				nMoedOrig := 1 //Impostos localizados

				If cPaisLoc == "BRA"
					nMoedOrig := nMoedaBx
				EndIf

				//Grava o registro
				For nI := 1 To nValores
					nQtdInsert++
					nRecno++
					lUltBx := .F.

					cNatureza	:= aValores[nI][1]
					cNatDesc	:= ""
					cNatPai		:= ""

					If lMulNat .And. SED->(DbSeek(FwXFilial("SED") + aValores[nI][1]))
						cNatDesc	:= SED->ED_DESCRIC
						cNatPai		:= SED->ED_PAI
					Else
						cNatDesc	:= (cAliasQry)->ED_DESCRIC
						cNatPai		:= (cAliasQry)->ED_PAI
					EndIf
					cNatDesc := Replace(cNatDesc, "'", " ")

					nVlrJuros	:= 0
					nVlrCorre	:= 0
					nVlrDesco	:= 0
					nValAbatim	:= 0
					nVlrImpost	:= 0
					nSE5Valor	:= 0
					nVlrMulta	:= 0
					nValTitulo	:= 0
					nValBaixa	:= 0

					nVlrOrigin := Round(NoRound(xMoeda(aValores[nI][2], nMoedaBx, MV_PAR20, dDataBx, __nDecs + 1, nTaxa), __nDecs + 1), __nDecs) * nFator

					If aValores[nI][3] != 0
						nVlrJuros := Round(NoRound(xMoeda(aValores[nI][3], nMoedaBx, MV_PAR20, dDataBx, __nDecs + 1, nTaxa), __nDecs + 1), __nDecs) * nFator
					EndIf

					If aValores[nI][4] != 0
						nVlrCorre := Round(NoRound(xMoeda(aValores[nI][4], nMoedaBx, MV_PAR20, dDataBx, __nDecs + 1, nTaxa), __nDecs + 1), __nDecs) * nFator
					EndIf

					If aValores[nI][5] != 0
						nVlrDesco := Round(NoRound(xMoeda(aValores[nI][5], nMoedaBx, MV_PAR20, dDataBx, __nDecs + 1, nTaxa), __nDecs + 1), __nDecs) * nFator
					EndIf

					If aValores[nI][6] != 0
						nValAbatim := Round(NoRound(xMoeda(aValores[nI][6], nMoedaBx, MV_PAR20, dDataBx, __nDecs + 1, nTaxa), __nDecs + 1), __nDecs) * nFator
					EndIf

					If aValores[nI][7] != 0
						nVlrImpost := Round(NoRound(xMoeda(aValores[nI][7], nMoedOrig, MV_PAR20, dDataBx, __nDecs + 1, nTaxa), __nDecs + 1), __nDecs) *  nFator
					EndIf

					If aValores[nI][8] != 0
						nSE5Valor := Round(NoRound(xMoeda(aValores[nI][8], nMoedaBx, MV_PAR20, dDataBx, __nDecs + 1, nTaxa), __nDecs + 1), __nDecs) * nFator
					EndIf

					If aValores[nI][10]
						nVlrMulta := Round(NoRound(xMoeda(aValores[nI][10], nMoedaBx, MV_PAR20, dDataBx, __nDecs + 1, nTaxa), __nDecs + 1), __nDecs) * nFator
					EndIf

					For nCampo := 1 To nStruct
						cCampo := aStruct[nCampo][1]

						Do Case
							Case cCampo == "VALACESS"
								cValor += ", " + Str(nVa, aStruct[nCampo][3], aStruct[nCampo][4])
							Case cCampo == "E5_NATUREZ"
								cValor += ", '" + cNatureza + "' "
							Case cCampo == "E5_NATDESC"
								cValor += ", '" + cNatDesc + "' "
							Case cCampo == "E5_NATPAI"
								cValor += ", '" + cNatPai + "' "
							Case cCampo == "E5_NOME"
								If cCarteira == "R"
									If lAchouSE1
										xConteudo := SE1->E1_NOMCLI
									ElseIf !Empty((cAliasQry)->E5_CLIFOR)
										xConteudo := Posicione("SA1", 1, xFilial("SA1") + (cAliasQry)->E5_CLIFOR + (cAliasQry)->E5_LOJA, "A1_NOME")
									Else
										xConteudo := " "
									EndIf
								Else
									If lAchouSE2
										xConteudo := SE2->E2_NOMFOR
									ElseIf !Empty((cAliasQry)->E5_CLIFOR)
										xConteudo := Posicione("SA2", 1, xFilial("SA2") + (cAliasQry)->E5_CLIFOR + (cAliasQry)->E5_LOJA, "A2_NOME")
									Else
										xConteudo := " "
									EndIf
								EndIf
								cValor += + ", '" + xConteudo + "' "
							Case cCampo == "E5_VENCTO"
								//Ajusta a data de vencimento
								xConteudo := " "
								If Empty((cAliasQry)->E5_VENCTO)
									xConteudo := DToS(IIf(cCarteira == "R", IIf(lAchouSE1, SE1->E1_VENCTO, CToD("")), IIf(lAchouSE2, SE2->E2_VENCTO, CToD(""))))
								Else
									xConteudo := (cAliasQry)->E5_VENCTO
								EndIf
								cValor +=  ", '" + xConteudo + "'"
							Case cCampo == "E5_TABORI"
								cValor += ", '" +  (cAliasQry)->E5_TABORI + "'"
							Case cCampo == "E5_IDORIG"
								cValor += ", '" +  (cAliasQry)->E5_IDORIG + "'"
							Case cCampo == "E5_TIPODOC"
								cValor += ", '" + (cAliasQry)->E5_TIPODOC + "'"
							Case cCampo == "E5_VALORIG"
								cValor += ", " + Str(nVlrOrigin, aStruct[nCampo][3], aStruct[nCampo][4])
							Case cCampo == "E5_ABATIM"
								cValor += ", " + Str(nValAbatim, aStruct[nCampo][3], aStruct[nCampo][4])
							Case cCampo == "E5_IMPOSTO"
								cValor += ", " + Str(nVlrImpost, aStruct[nCampo][3], aStruct[nCampo][4])
							Case cCampo == "E5_VLJUROS"
								cValor += ", " + Str(nVlrJuros, aStruct[nCampo][3], aStruct[nCampo][4])
							Case cCampo == "E5_VLCORRE"
								cValor += ", " + Str(nVlrCorre, aStruct[nCampo][3], aStruct[nCampo][4])
							Case cCampo == "E5_VLDESCO"
								cValor += ", " + Str(nVlrDesco, aStruct[nCampo][3], aStruct[nCampo][4])
							Case cCampo == "E5_VALOR"
								cValor += ", " + Str(nSE5Valor, aStruct[nCampo][3], aStruct[nCampo][4])
							Case cCampo == "E5_VLMULTA"
								cValor += ", " + Str(nVlrMulta, aStruct[nCampo][3], aStruct[nCampo][4])
							Case cCampo $ "E5_VALTIT|E5_VALBX|E5_ULTBX|"
								If !lUltBx
									lUltBx := .T.
									cUltBx := "N"
									If (cAliasQry)->E5_SEQ == aValores[nI][9] .Or. Empty((cAliasQry)->E5_SEQ) .Or. Empty(aValores[nI][9])
										cUltBx := "S"
									EndIf
									If U_F198VldBx(cAliasQry)
										//Valor dos títulos que serão totalizados
										If cUltBx == "S"
											nValTitulo := nVlrOrigin //Considera uma única vez o valor do título para recompor o total
										EndIf
										//Valor baixado que será totalizado
										nValBaixa := nSE5Valor
									EndIf
								EndIf
								If cCampo == "E5_VALTIT"
									cValor += ", " + Str(nValTitulo, aCampos[2][1],  aCampos[2][2]) //ok
								ElseIf cCampo == "E5_VALBX"
									cValor += ", " + Str(nValBaixa, aCampos[2][1],  aCampos[2][2]) //ok
								Else //cCampo == "E5_ULTBX"
									cValor += ", '" + cUltBx + "'"
								EndIf
							Case cCampo == "E5_HISTOR"
								If aValores[nI][11] //Cancelado
									xConteudo := STR0033 //CANCELAMENTO DE BAIXA
								ElseIf Empty((cAliasQry)->E5_TIPODOC) .And. Empty((cAliasQry)->E5_NUMERO) .And. Empty((cAliasQry)->E5_HISTOR)
									xConteudo := STR0027 //MOVIMENTO MANUAL
								ElseIf !Empty((cAliasQry)->E5_NUMCHEQ)
									xConteudo := AllTrim((cAliasQry)->E5_NUMCHEQ) + "/" + IIf(!Empty((cAliasQry)->E5_HISTOR), (cAliasQry)->E5_HISTOR, STR0028) //CHEQUE
								ElseIf !Empty((cAliasQry)->E5_HISTOR)
									xConteudo := (cAliasQry)->E5_HISTOR
								EndIf
								cValor += ", '" + SubStr(xConteudo, 1, nTamHist) + "'"
							Otherwise
								xConteudo := (cAliasQry)->&cCampo

								//Ajuste para campos do tipo data
								If aStruct[nCampo][2] $ "C|D|"
									cValor += ", '" + xConteudo + "' "
								ElseIf aStruct[nCampo][2] == "L"
									cValor += ", " + IIf(xConteudo == "T", "1", "0")
								ElseIf aStruct[nCampo][2] == "N"
									cValor += "," + Str(xConteudo, aStruct[nCampo][3], aStruct[nCampo][4])
								EndIf
						EndCase
					Next nCampo

					If ValType("aTotais") <> "U"
						nBaixado  := 0
						nMovFin	  := 0
						nCompensa := 0
						nFatura	  := 0

						//Atualiza os totais
						If !((cAliasQry)->E5_MOTBX == "CMP" .Or. !MovBcoBx((cAliasQry)->E5_MOTBX)) .And. !Empty((cAliasQry)->(E5_TIPODOC + E5_NUMERO))
							nBaixado := nSE5Valor
						EndIf

						If !(cAliasQry)->E5_TIPODOC $ " VL|V2|BA|RA|PA|CP|ES"
							nMovFin	:= nSE5Valor
						EndIf

						If (cAliasQry)->E5_TIPODOC == "CP"
							//Títulos compensados são exibidos com sinal negativo (-), sendo necessário fazer a inversao no totalizador
							nCompensa	:= nSE5Valor * nFator
						EndIf

						If (cAliasQry)->E5_MOTBX == "FAT"
							nFatura	:= nSE5Valor
						EndIf

						nPosNat := AScan(aTotais, {|natureza| natureza[1] == cNatureza})

						If nPosNat > 0
							aTotais[nPosNat][3][1][2] += nBaixado
							aTotais[nPosNat][3][2][2] += nMovFin
							aTotais[nPosNat][3][3][2] += nCompensa
							aTotais[nPosNat][3][4][2] += nFatura
						Else
							aAux := {}
							AAdd(aAux, {STR0029, nBaixado})  //Baixados
							AAdd(aAux, {STR0030, nMovFin})   //Mov. Fin
							AAdd(aAux, {STR0031, nCompensa}) //Compensados
							AAdd(aAux, {STR0032, nFatura})   //Bx Fatura
							AAdd(aTotais, {cNatureza, cNatPai, aAux})
						EndIf
					EndIf

					cSQLValues += IIf(lDbOracle, cSQLInsert, ", ") + "(" + SubStr(cValor, 2) + ", " + CValToChar(nRecno) + ") "
					cValor := ""

					IIf(nQtdInsert == nTargetIns .Or. (lDbOracle .And. nQtdInsert == nTargetIns), F198Commit(cSQLInsert, @cSQLValues, @nQtdInsert), Nil)
				Next nI
			EndIf

			IIf(nQtdInsert == nTargetIns .Or. (lDbOracle .And. nQtdInsert == nTargetIns), F198Commit(cSQLInsert, @cSQLValues, @nQtdInsert), Nil)

			(cAliasQry)->(DbSkip())
		EndDo

		__lImposBx := .T.

		IIf(nQtdInsert > 0, F198Commit(cSQLInsert, @cSQLValues, @nQtdInsert), Nil)

		If __oEstCheq != Nil
			__oEstCheq:Destroy()
			__oEstCheq := Nil
		EndIf

		If __oCheque != Nil
			__oCheque:Destroy()
			__oCheque := Nil
		EndIf

		If __oProcFK6 != Nil
			__oProcFK6:Destroy()
			__oProcFK6 := Nil
		EndIf

		If oRatSev != Nil
			oRatSev:Destroy()
			oRatSev := Nil
		EndIf

		If oQryFk1 != Nil
			oQryFk1:Destroy()
			oQryFk1 := Nil
		EndIf

		If oQryFk2 != Nil
			oQryFk2:Destroy()
			oQryFk2 := Nil
		EndIf

		If oRegCheq != Nil
			oRegCheq:Destroy()
			oRegCheq := Nil
		EndIf
	EndIf

	FwFreeArray(aStruct)
	FwFreeArray(aCampos)
	(cAliasQry)->(DbCloseArea())

Return

/*/{Protheus.doc} F198Commit
Efetua o commit dos dados na tabela temporária para impressão.

@author		Rafael Riego
@since		18/03/2022
@param		cSQLInsert, character, parte inicial do comando de insert para tabela temporária (somente diferente de ORACLE)
@param		cSQLValues, character, comando de insert a ser executado (passado por referência. Deve ser limpo após execução)
@param		nQtdInsert, numeric, quantidade de registros que serão inseridos (passado por referência. Deve ser zerado após execução)
@return		Nil
/*/
Static Function F198Commit(cSQLInsert As Character, cSQLValues As Character, nQtdInsert As Numeric)

	Local cSQLExec		As Character
	Local cInsOracle	As Character
	Local nSQLStatus	As Numeric

	cInsOracle	:= "INSERT ALL " + cSQLValues + " SELECT 1 FROM DUAL " //ORACLE
	cSQLExec	:= "INSERT " + cSQLInsert //Outros BDs

	nSQLStatus	:= TCSQLExec(IIf(__cDbName == "ORACLE", cInsOracle, cSQLExec + SubStr(cSQLValues, 2)))
	nQtdInsert	:= 0
	cSQLValues	:= ""

Return Nil

/*/{Protheus.doc} F198ProcVA
Realiza a busca de registros de cheque ou baixa para de determinar se o registro principal deve ser apresentado no relatório.

@author		Rafael Riego
@since		02/02/2022
@param		cFilSE5, character, filial da SE5
@param		cIdOrig, character, id de origem do registro
@param		cTabOri, character, tabela de origem do registro
@return		logical, verdadeiro caso tenha encontrado algum registro de VA
/*/
Static Function F198ProcVA(cFilSE5 As Character, cIdOrig As Character, cTabOri As Character) As Logical

	Local lTemVA	As Logical

	lTemVA := .F.

	__oProcFK6:SetString(1, cFilSE5)
	__oProcFK6:SetString(2, cIdOrig)
	__oProcFK6:SetString(3, cTabOri)
	__oProcFK6:SetString(4, "VA")
	__oProcFK6:SetString(5, " ")

	lTemVA := IIf(__lCachedQry, __oProcFK6:ExecScalar("VA", "600", "15"), MPSysExecScalar(__oProcFK6:GetFixQuery(), "VA")) > 0

Return lTemVA

/*/{Protheus.doc} F198Cheque
Realiza a busca de registros de cheque ou baixa para de determinar se o registro principal deve ser apresentado no relatório.

@author		Rafael Riego
@since		02/02/2022
@param		cFilSE5, character, filial da SE5
@param		cBanco, character, código do banco
@param		cAgencia, character, agência bancária
@param		cConta, character, conta bancária
@param		cNumCheque, character, número do cheque
@param		cTipoBusca, character, tipo doc do movimento
@return		logical, verdadeiro caso tenha encontrado algum registro
/*/
Static Function F198Cheque(cFilSE5 As Character, cBanco As Character, cAgencia As Character, cConta As character, cNumCheque As Character, cTipoBusca As Character) As Logical

	Local lTemCheque	As Logical

	lTemCheque := .F.

	__oCheque:SetString(1, cFilSE5)
	__oCheque:SetString(2, cBanco)
	__oCheque:SetString(3, cAgencia)
	__oCheque:SetString(4, cConta)
	__oCheque:SetString(5, cNumCheque)
	__oCheque:SetString(6, cTipoBusca)
	__oCheque:SetString(7, " ")
	__oCheque:SetString(8, " ")

	lTemCheque := IIf(__lCachedQry, __oCheque:ExecScalar("CHEQUE", "600", "15"), MPSysExecScalar(__oCheque:GetFixQuery(), "CHEQUE")) > 0

Return lTemCheque

/*/{Protheus.doc} F198EstChq
Realiza a busca de registros de estorno de cheque para o cheque posicionado.

@author		Rafael Riego
@since		02/02/2022
@param		cFilSE5, character, filial da SE5
@param		cBanco, character, código do banco
@param		cAgencia, character, agência bancária
@param		cConta, character, conta bancária
@param		cNumCheque, character, número do cheque
@return		logical, verdadeiro caso tenha encontrado algum registro
/*/
Static Function F198EstChq(cFilSE5 As Character, cBanco As Character, cAgencia As Character, cConta As character, cNumCheque As Character) As Logical

	Local lTemEstChq	As Logical

	lTemEstChq := .F.

	__oEstCheq:SetString(1, cFilSE5)
	__oEstCheq:SetString(2, cBanco)
	__oEstCheq:SetString(3, cAgencia)
	__oEstCheq:SetString(4, cConta)
	__oEstCheq:SetString(5, cNumCheque)
	__oEstCheq:SetString(6, "EC")
	__oEstCheq:SetString(7, " ")

	lTemEstChq := IIf(__lCachedQry, __oEstCheq:ExecScalar("NTOTAL", "600", "15"), MPSysExecScalar(__oEstCheq:GetFixQuery(), "NTOTAL")) > 0

Return lTemEstChq

//--------------------------------
/*/{Protheus.doc} F198TotNat
Totaliza as naturezas analíticas nas sintéticas
@author    Marcos Berto
@version   11.80
@since     27/12/12
@param oReport - Objeto de Relatório

/*/
//--------------------------------
User Function F198TotNat()
	Local aAux			:= {}
	Local aStruct		:= {}
	Local cNatureza		:= ""
	Local cQuery		:= ""
	Local cAliasQry1 	:= ""
	Local cAliasQry2 	:= ""
	Local lCreate		:= .F.
	Local nX			:= 0
	Local oTotais       := Nil
	Local cTblTot       := ""
	Local aTamVal := TamSx3("E5_VALOR")
	Local aTamCod := TamSX3("ED_CODIGO")
	Local aTamDes := TamSX3("ED_DESCRIC")

	//Busca todas as naturezas sintéticas
	IF TCCANOPEN(cTMPSED198)
		MsErase(cTMPSED198)
	EndIf

	cQuery := "SELECT SED.ED_CODIGO,SED.ED_DESCRIC,SED.ED_PAI FROM "
	cQuery += RetSqlName("SED") + " SED "
	cQuery += "WHERE "
	cQuery += "SED.ED_FILIAL = '" + xFilial("SED") + "' AND "
	cQuery += "SED.ED_TIPO = '1' AND "
	cQuery += "SED.D_E_L_E_T_ = ' '	"
	cQuery += "ORDER BY ED_CODIGO DESC"
	cQuery := ChangeQuery(cQuery)

	cAliasQry1 := MpSysOpenQuery(cQuery)
	(cAliasQry1)->(DbGotop())

	aAdd(aStruct, {"NATUREZA", "C", aTamCod[1], aTamCod[2]})
	aAdd(aStruct, {"DESCNAT",  "C", aTamDes[1], aTamDes[2]})
	aAdd(aStruct, {"NATPAI",   "C", aTamCod[1], aTamCod[2]})
	aAdd(aStruct, {"VALORIG",  "N", aTamVal[1], aTamVal[2]})
	aAdd(aStruct, {"VLJUROS",  "N", aTamVal[1], aTamVal[2]})
	aAdd(aStruct, {"VLMULTA",  "N", aTamVal[1], aTamVal[2]})
	aAdd(aStruct, {"VALCORR",  "N", aTamVal[1], aTamVal[2]})
	aAdd(aStruct, {"VLDESCO",  "N", aTamVal[1], aTamVal[2]})
	aAdd(aStruct, {"ABATIM",   "N", aTamVal[1], aTamVal[2]})
	aAdd(aStruct, {"IMPOSTO",  "N", aTamVal[1], aTamVal[2]})
	aAdd(aStruct, {"VALOR",    "N", aTamVal[1], aTamVal[2]})
	aAdd(aStruct, {"NIVEL",    "N", 10, 0})
	aAdd(aStruct, {"VALACESS", "N", aTamVal[1], aTamVal[2]})

	//Cria o arquivo temporário
	If (lCreate := (MsCreate(cTMPSED198, aStruct, "TOPCONN")))
		dbUseArea(.T.,"TOPCONN",cTMPSED198,cTMPSED198,.T.,.F.)
		dbSelectArea(cTMPSED198)
		dbCreateIndex(cTMPSED198 + "i","NATUREZA", {|| "NATUREZA"})

		While (cAliasQry1)->(!Eof())
			RecLock(cTMPSED198,.T.)
			(cTMPSED198)->NATUREZA 	:= (cAliasQry1)->ED_CODIGO
			(cTMPSED198)->DESCNAT	:= (cAliasQry1)->ED_DESCRIC
			(cTMPSED198)->NATPAI 	:= (cAliasQry1)->ED_PAI
			(cTMPSED198)->(MsUnlock())

			//Prepara os totalizadores
			If ValType("aTotSint") <> "U"
				aAux := {}
				aAdd(aAux, {"Baixados",    0})
				aAdd(aAux, {"Mov. Fin",    0})
				aAdd(aAux, {"Compensados", 0})
				aAdd(aAux, {"Bx Fatura",   0})
				aAdd(aTotSint,{(cAliasQry1)->ED_CODIGO,(cAliasQry1)->ED_PAI,aAux})
			EndIf

			(cAliasQry1)->(dbSkip())
		EndDo

		//Busca na tabela temporária os registros pertecentes às analíticas
		For nX := 01 To Len(aTotais)
			If oTotais == Nil //Query agrupadora por Natureza
				cQuery := "SELECT "
				cQuery += "E5_NATUREZ, E5_NATDESC, E5_NATPAI, "
				cQuery += "SUM(E5_VALTIT) E5_VALORIG, "
				cQuery += "SUM(E5_VLJUROS) E5_VLJUROS, "
				cQuery += "SUM(E5_VLMULTA) E5_VLMULTA, "
				cQuery += "SUM(E5_VLCORRE) E5_VLCORRE, "
				cQuery += "SUM(E5_VLDESCO) E5_VLDESCO, "
				cQuery += "SUM(E5_ABATIM) E5_ABATIM,  "
				cQuery += "SUM(E5_IMPOSTO) E5_IMPOSTO, "
				cQuery += "SUM(E5_VALBX) E5_VALOR,    "
				cQuery += "SUM(VALACESS) VALACESS "
				cQuery += "FROM ? "
				cQuery += "WHERE E5_NATUREZ = ? "
				cQuery += "GROUP BY E5_NATUREZ, E5_NATDESC, E5_NATPAI "
				cQuery  := ChangeQuery(cQuery)
				oTotais := FWPreparedStatement():New(cQuery)
			EndIf

			oTotais:SetNumeric(1, cTMPSE5198)
			oTotais:SetString(2, aTotais[nX,01])
			cQuery  := oTotais:GetFixQuery()
			cTblTot := MpSysOpenQuery(cQuery)

			If (cTblTot)->(!Eof())
				dbSelectArea(cTMPSED198)

				If (RecLock(cTMPSED198,.T.)) //Criando novo registro totalizador
					(cTMPSED198)->NATUREZA 	:= (cTblTot)->E5_NATUREZ
					(cTMPSED198)->DESCNAT	:= (cTblTot)->E5_NATDESC
					(cTMPSED198)->NATPAI 	:= (cTblTot)->E5_NATPAI
					(cTMPSED198)->VALORIG	:= (cTblTot)->E5_VALORIG
					(cTMPSED198)->VLJUROS	:= (cTblTot)->E5_VLJUROS
					(cTMPSED198)->VLMULTA	:= (cTblTot)->E5_VLMULTA
					(cTMPSED198)->VALCORR	:= (cTblTot)->E5_VLCORRE
					(cTMPSED198)->VLDESCO	:= (cTblTot)->E5_VLDESCO
					(cTMPSED198)->ABATIM	:= (cTblTot)->E5_ABATIM
					(cTMPSED198)->IMPOSTO	:= (cTblTot)->E5_IMPOSTO
					(cTMPSED198)->VALOR		:= (cTblTot)->E5_VALOR
					(cTMPSED198)->VALACESS	+= (cTblTot)->VALACESS
					(cTMPSED198)->(MsUnlock())
				EndIf
			EndIf

			(cTblTot)->(DbCloseArea())
		Next nX

		//Busca na tabela temporária os registros pertecentes às sintéticas
		cQuery := "SELECT "
		cQuery += "E5_NATPAI, "
		cQuery += "SUM(E5_VALTIT) E5_VALORIG, "
		cQuery += "SUM(E5_VLJUROS) E5_VLJUROS, "
		cQuery += "SUM(E5_VLMULTA) E5_VLMULTA, "
		cQuery += "SUM(E5_VLCORRE) E5_VLCORRE, "
		cQuery += "SUM(E5_VLDESCO) E5_VLDESCO, "
		cQuery += "SUM(E5_ABATIM) E5_ABATIM,  "
		cQuery += "SUM(E5_IMPOSTO) E5_IMPOSTO, "
		cQuery += "SUM(E5_VALBX) E5_VALOR,    "
		cQuery += "SUM(VALACESS) VALACESS "
		cQuery += "FROM " + cTMPSE5198 + " "
		cQuery += "GROUP BY E5_NATPAI "

		cQuery := ChangeQuery(cQuery)
		cAliasQry2 := GetNextAlias()
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery), cAliasQry2,.F.,.T.)

		dbSelectArea(cTMPSED198)
		(cTMPSED198)->(dbSetOrder(1))

		While !(cAliasQry2)->(Eof())
			If (cTMPSED198)->(dbSeek((cAliasQry2)->E5_NATPAI))
				cNatureza := (cTMPSED198)->NATUREZA

				While cNatureza <> ""
					If (cTMPSED198)->(dbSeek(cNatureza))
						RecLock(cTMPSED198,.F.)
						(cTMPSED198)->VALORIG	+= (cAliasQry2)->E5_VALORIG
						(cTMPSED198)->VLJUROS	+= (cAliasQry2)->E5_VLJUROS
						(cTMPSED198)->VLMULTA	+= (cAliasQry2)->E5_VLMULTA
						(cTMPSED198)->VALCORR	+= (cAliasQry2)->E5_VLCORRE
						(cTMPSED198)->VLDESCO	+= (cAliasQry2)->E5_VLDESCO
						(cTMPSED198)->ABATIM	+= (cAliasQry2)->E5_ABATIM
						(cTMPSED198)->IMPOSTO	+= (cAliasQry2)->E5_IMPOSTO
						(cTMPSED198)->VALOR		+= (cAliasQry2)->E5_VALOR
						(cTMPSED198)->NIVEL		+= 1
						(cTMPSED198)->VALACESS	+= (cAliasQry2)->VALACESS
						(cTMPSED198)->(MsUnlock())

						//Controle de atualização das superiores imediatas
						cNatureza := (cTMPSED198)->NATPAI
					Else
						cNatureza := ""
					EndIf
				EndDo
			EndIf

			(cAliasQry2)->(dbSkip())
		EndDo

		dbSelectArea(cAliasQry2)
		(cAliasQry2)->(dbCloseArea())
		MsErase(cAliasQry2)

		If oTotais != Nil
			oTotais:Destroy()
			oTotais := Nil
		EndIf
	EndIf

	FwFreeArray(aTamVal)
	FwFreeArray(aTamCod)
	FwFreeArray(aTamDes)
	FwFreeArray(aStruct)

	(cAliasQry1)->(dbCloseArea())

	U_F198TotSint() //Monta os totalizadores por natureza sintética
Return

/*/{Protheus.doc} F198TotVal
Totaliza os valores de cada movimento

IMPORTANTE: Para utilização desta função deve ser utilizada somente para recompor os valores
deste relatório, uma vez que o alias utilizado é resultado de uma query que concatena 2 ou
mais tabelas
@author    Marcos Berto
@version   11.80
@since     08/01/13
@param cAlias 	- Alias de referência
@param cCarteira 	- Carteira
@return aValores 	- Valores totalizados do movimento
/*/
User Function F198TotVal(cAliasQry, cCarteira, oRatSev, oQryFk1, oQryFk2, lAchouSE1, lAchouSE2)
	Local aAreaSE1		:= {}
	Local aDados		:= {}
	Local aValMov		:= {}
	Local aValores		:= {}
	Local cQuery		:= ""
	Local nImposto		:= 0
	Local nTotAbImp		:= 0
	Local lMulNat		:= .F.
	Local lCancel		:= .F. //Registros cancelados serão impressos 2 vezes
	Local nMoedaBx      := 0
	Local lTemRatio     := .F.
	Local cChaveSev     := ""
	Local cEvSeq        := "  "
	Local cEvIdent      := "1"
	Local cTmpSev       :=  ""
	Local lIrrfBxCP     := .F.
	Local lIrrfBxCR     := .F.
	Local aSE1          := {}
	Local aSE2          := {}

	Default cAliasQry := ""
	Default cCarteira := ""
	Default oRatSev   := Nil
	Default oQryFk1   := Nil
	Default oQryFk2   := Nil
	Default lAchouSE1 := .F.
	Default lAchouSE2 := .F.

	If cPaisLoc == "BRA"
		If __lImposBx
			__lImposBx := .F.
			__lPccBxCP := SuperGetMv("MV_BX10925", .T., "2") == "1"
			__lIssBxCP := SuperGetMv("MV_MRETISS", .F., "1") == "2"
			__lPccBxCR := SuperGetMv("MV_BR10925", .T., "2") == "1"
			__lIssBxCR := (__lIssBxCP .And. cCarteira == "R" .And. !Empty(SE1->(FieldPos("E1_TRETISS"))))
		EndIf

		lIrrfBxCR := FIrPjBxCr()
		lIrrfBxCP := (Posicione("SA2", 1, xFilial("SA2") + SE2->(E2_FORNECE+E2_LOJA), "A2_CALCIRF") == "2") .And. ;
							(Posicione("SED", 1, xFilial("SED") + SE2->(E2_NATUREZ), "ED_CALCIRF") = "S")
	EndIf

	//Os cálculos feitos pela função serão efetuados considerando a moeda do movimento. A conversão na moeda do relatório será efetuada posteriormente.
	If !Empty(cAliasQry) .And. !Empty(cCarteira)
		aValMov := Array(9)
		/*aValMov: [1] = Valor Original, [2] = Juros/Multa, [3] = Correção, [4] = Desconto, [5] = Amatimentos
				[6] = Impostos, [7] = Valor Baixado, [8] = Ult. Baixa?, [9] = Multa*/

		aValMov[1] := (cAliasQry)->E5_VALOR
		nMoedaBx   := Val((cAliasQry)->E5_MOEDA)
		aValMov[8] := __cSeqBaix

		If cCarteira == "R"
			If lAchouSE1 .And. SE1->E1_VALOR != 0 .And. SE1->E1_MOEDA != nMoedaBx
				If SE1->E1_MOEDA == 1
					aValMov[1] := Round(xMoeda(SE1->E1_VALOR, SE1->E1_MOEDA, nMoedaBx, SE1->E1_EMISSAO, __nCasDec, 0, SE1->E1_TXMOEDA),2)
				Else
					aValMov[1] := Round(xMoeda(SE1->E1_VALOR, SE1->E1_MOEDA, nMoedaBx, SE1->E1_EMISSAO, __nCasDec, SE1->E1_TXMOEDA),2)
				EndIf
			Endif

			If Empty(aValMov[8])
				aValMov[8] := F198SeqBx("FK1", (cAliasQry)->E5_FILIAL, (cAliasQry)->E5_PREFIXO, (cAliasQry)->E5_NUMERO, (cAliasQry)->E5_PARCELA,;
										(cAliasQry)->E5_TIPO, (cAliasQry)->E5_CLIFOR, (cAliasQry)->E5_LOJA, @oQryFk1, Nil, __lCachedQry)
				__cSeqBaix := IIf(lAchouSE1, aValMov[8], __cSeqBaix)
			EndIf
		Else
			If lAchouSE2 .And. SE2->E2_VALOR != 0 .And. SE2->E2_MOEDA != nMoedaBx
				If SE2->E2_MOEDA == 1
					aValMov[1] := Round(xMoeda(SE2->E2_VALOR, SE2->E2_MOEDA, nMoedaBx, SE2->E2_EMISSAO, __nCasDec, 0, SE2->E2_TXMOEDA),2)
				Else
					aValMov[1] := Round(xMoeda(SE2->E2_VALOR, SE2->E2_MOEDA, nMoedaBx, SE2->E2_EMISSAO, __nCasDec, SE2->E2_TXMOEDA),2)
				EndIf
			Endif

			If Empty(aValMov[8])
				aValMov[8] := F198SeqBx("FK2", (cAliasQry)->E5_FILIAL, (cAliasQry)->E5_PREFIXO, (cAliasQry)->E5_NUMERO, (cAliasQry)->E5_PARCELA,;
										(cAliasQry)->E5_TIPO, (cAliasQry)->E5_CLIFOR, (cAliasQry)->E5_LOJA, Nil, @oQryFk2, __lCachedQry)
				__cSeqBaix := IIf(lAchouSE2, aValMov[8], __cSeqBaix)
			EndIf
		EndIf

		lCancel    := (cAliasQry)->E5_SITUACA == "C"
		aValMov[2] := (cAliasQry)->E5_VLJUROS
		aValMov[9] := (cAliasQry)->E5_VLMULTA
		aValMov[3] := (cAliasQry)->E5_VLCORRE
		aValMov[4] := (cAliasQry)->E5_VLDESCO
		aValMov[5] := 0

		If (lAchouSE1 .Or. lAchouSE2) .And. (cAliasQry)->E5_SEQ == aValMov[8]
			If cCarteira == "R"
				aSE1 := SE1->(GetArea())
				SE1->(DbSetOrder(28))

				If SE1->(DbSeek(SE1->(E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_CLIENTE+E1_LOJA)))
					aValMov[5] := SumAbatRec((cAliasQry)->E5_PREFIXO, (cAliasQry)->E5_NUMERO, (cAliasQry)->E5_PARCELA, /*Moeda*/, "V", (cAliasQry)->E5_DATA, @nTotAbImp)
				EndIf

				RestArea(aSE1)
			Else
				aSE2 := SE2->(GetArea())
				SE2->(DbSetOrder(17))

				If SE2->(MsSeek(SE2->(E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)))
					aValMov[5] := SomaAbat((cAliasQry)->E5_PREFIXO, (cAliasQry)->E5_NUMERO, (cAliasQry)->E5_PARCELA, cCarteira, /*Moeda*/, ,(cAliasQry)->E5_CLIFOR, (cAliasQry)->E5_LOJA)
				EndIf
				RestArea(aSE2)
			EndIf
		EndIf

		If cPaisLoc == "BRA"
			nImposto := 0

			If cCarteira == "R"
				//PCC
				If __lPccBxCR .And. Empty((cAliasQry)->E5_PRETPIS) .And. Empty((cAliasQry)->E5_PRETCOF) .And. Empty((cAliasQry)->E5_PRETCSL)
					nImposto += (cAliasQry)->E5_VRETPIS + (cAliasQry)->E5_VRETCOF + (cAliasQry)->E5_VRETCSL
				EndIf

				//IRRF
				If lIrrfBxCR
					nImposto += (cAliasQry)->E5_VRETIRF
				EndIf

				//ISS
				If __lIssBxCR
					nImposto += (cAliasQry)->E5_VRETISS
				EndIf

				//Abatimentos de Impostos
				If (cAliasQry)->E5_SEQ == aValMov[8]
					nImposto   += nTotAbImp
					aValMov[5] -= nTotAbImp //Desconta dos abatimentos o valor que for refente à impostos
				EndIf
			Else
				//PCC
				If __lPccBxCP .And. Empty((cAliasQry)->E5_PRETPIS) .And. Empty((cAliasQry)->E5_PRETCOF) .And. Empty((cAliasQry)->E5_PRETCSL)
					nImposto += (cAliasQry)->E5_VRETPIS + (cAliasQry)->E5_VRETCOF + (cAliasQry)->E5_VRETCSL
				EndIf

				//IR
				If lIrrfBxCP
					nImposto += (cAliasQry)->E5_VRETIRF
				EndIf

				//ISS
				If __lIssBxCP
					nImposto += (cAliasQry)->E5_VRETISS
				EndIf
			EndIf
		Else
			nImposto := 0
			dbSelectArea("SFE")
			SFE->(dbGoTop())

			If cCarteira == "P"
				SFE->(dbSetOrder(2)) //FILIAL + ORDEM DE PAGO
			Else
				SFE->(dbSetOrder(6)) //FILIAL + RECIBO
			EndIf

			If SFE->(dbSeek(xFilial("SFE")+(cAliasQry)->E5_ORDREC))
				While !SFE->(Eof()) .And. SFE->FE_FILIAL == xFilial("SFE") .And.;
						((cCarteira == "P" .And. SFE->FE_ORDPAGO == (cAliasQry)->E5_ORDREC).Or.;
						(cCarteira == "R" .And. SFE->FE_RECIBO == (cAliasQry)->E5_ORDREC))

					nImposto += SFE->FE_RETENC
					SFE->(dbSkip())
				EndDo
			EndIf
		EndIf

		aValMov[6] := nImposto
		aValMov[7] := (cAliasQry)->E5_VALOR

		//Valida se há rateio multinatureza
		If MV_MULNATP
			If cCarteira == "R" .And. (SE1->E1_MULTNAT == "1" .Or. (cAliasQry)->E5_MULTNAT == "1")
				lMulNat := .T.
			ElseIf cCarteira == "P" .And. (SE2->E2_MULTNAT == "1" .Or. (cAliasQry)->E5_MULTNAT == "1")
				lMulNat := .T.
			EndIf

			If lMulNat
				dbSelectArea("SEV")
				SEV->(dbSetOrder(2))
				cChaveSev := xFilial("SEV")+(cAliasQry)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)

				If SEV->(dbSeek(cChaveSev+"2"+(cAliasQry)->E5_SEQ)) //Pela distribuição da baixa
					lTemRatio := .T.
					cEvIdent  := "2"
					cEvSeq    := (cAliasQry)->E5_SEQ
				ElseIf SEV->(dbSeek(cChaveSev+"1")) //Pela distribuição do título
					lMultNat  := .T.
					lTemRatio := .T.
				EndIf

				If lTemRatio
					If oRatSev == Nil
						cQuery := "SELECT * FROM " + RetSqlName("SEV") + " SEV WHERE "
						cQuery += "SEV.EV_FILIAL = ? "
						cQuery += "AND SEV.EV_PREFIXO = ? "
						cQuery += "AND SEV.EV_NUM = ? "
						cQuery += "AND SEV.EV_PARCELA = ? "
						cQuery += "AND SEV.EV_TIPO = ? "
						cQuery += "AND SEV.EV_CLIFOR = ? "
						cQuery += "AND SEV.EV_LOJA = ? "
						cQuery += "AND SEV.EV_NATUREZ BETWEEN ? AND ? "
						cQuery += "AND SEV.EV_IDENT = ? "
						cQuery += "AND SEV.EV_SEQ = ? "
						cQuery += "AND SEV.D_E_L_E_T_ = ' ' "
						cQuery  := ChangeQuery(cQuery)
						oRatSev := FWPreparedStatement():New(cQuery)
					EndIf

					oRatSev:SetString(1,  xFilial("SEV") )
					oRatSev:SetString(2,  (cAliasQry)->E5_PREFIXO)
					oRatSev:SetString(3,  (cAliasQry)->E5_NUMERO)
					oRatSev:SetString(4,  (cAliasQry)->E5_PARCELA)
					oRatSev:SetString(5,  (cAliasQry)->E5_TIPO)
					oRatSev:SetString(6,  (cAliasQry)->E5_CLIFOR)
					oRatSev:SetString(7,  (cAliasQry)->E5_LOJA)
					oRatSev:SetString(8,  mv_par07)
					oRatSev:SetString(9,  mv_par08)
					oRatSev:SetString(10, cEvIdent)
					oRatSev:SetString(11, cEvSeq)
					cQuery  := oRatSev:GetFixQuery()
					cTmpSev := MpSysOpenQuery(cQuery)

					If (cTmpSev)->(Eof())
						(cTmpSev)->(DbCloseArea())
						cTmpSev := ""
					EndIf
				EndIf
			EndIf
		EndIf

		If !Empty(cTmpSev)
			While (cTmpSev)->(!Eof())
				aDados     := Array(11)
				aDados[1]  := (cTmpSev)->EV_NATUREZ			//NATUREZA
				aDados[2]  := aValMov[1] * (cTmpSev)->EV_PERC	//VALOR ORIGINAL
				aDados[3]  := aValMov[2] * (cTmpSev)->EV_PERC	//JUROS
				aDados[4]  := aValMov[3] * (cTmpSev)->EV_PERC	//CORREÇÃO
				aDados[5]  := aValMov[4] * (cTmpSev)->EV_PERC	//DESCONTO
				aDados[6]  := aValMov[5] * (cTmpSev)->EV_PERC	//ABATIMENTO
				aDados[7]  := aValMov[6] * (cTmpSev)->EV_PERC	//IMPOSTO
				aDados[8]  := aValMov[7] * (cTmpSev)->EV_PERC	//BAIXADO
				aDados[9]  := aValMov[8]							//ULT. BAIXA
				aDados[10] := aValMov[9] * (cTmpSev)->EV_PERC	//MULTA
				aDados[11] := .F.								//CANCELAMENTO

				aAdd(aValores, AClone(aDados))
				FwFreeArray(aDados)

				//Gera o movimento inverso do cancelamento
				If lCancel
					aDados     := Array(11)
					aDados[1]  := (cTmpSev)->EV_NATUREZ					//NATUREZA
					aDados[2]  := (aValMov[1] * (cTmpSev)->EV_PERC) * (-1)	//VALOR ORIGINAL
					aDados[3]  := (aValMov[2] * (cTmpSev)->EV_PERC) * (-1)	//JUROS
					aDados[4]  := (aValMov[3] * (cTmpSev)->EV_PERC) * (-1)	//CORREÇÃO
					aDados[5]  := (aValMov[4] * (cTmpSev)->EV_PERC) * (-1)	//DESCONTO
					aDados[6]  := (aValMov[5] * (cTmpSev)->EV_PERC) * (-1)	//ABATIMENTO
					aDados[7]  := (aValMov[6] * (cTmpSev)->EV_PERC) * (-1)	//IMPOSTO
					aDados[8]  := (aValMov[7] * (cTmpSev)->EV_PERC) * (-1)	//BAIXADO
					aDados[9]  :=  aValMov[8]								//ULT. BAIXA
					aDados[10] := (aValMov[9] * (cTmpSev)->EV_PERC) * (-1)	//MULTA
					aDados[11] := .T.										//CANCELAMENTO

					aAdd(aValores, AClone(aDados))
					FwFreeArray(aDados)
				EndIf

				(cTmpSev)->(DbSkip())
			EndDo
		Else
			aDados     := Array(11)
			aDados[1]  := (cAliasQry)->E5_NATUREZ	//NATUREZA
			aDados[2]  := aValMov[1]					//VALOR ORIGINAL
			aDados[3]  := aValMov[2]					//JUROS/MULTA
			aDados[4]  := aValMov[3]					//CORREÇÃO
			aDados[5]  := aValMov[4]					//DESCONTO
			aDados[6]  := aValMov[5]					//ABATIMENTO
			aDados[7]  := aValMov[6]					//IMPOSTO
			aDados[8]  := aValMov[7]					//BAIXADO
			aDados[9]  := aValMov[8]					//ULT. BAIXA
			aDados[10] := aValMov[9]					//MULTA
			aDados[11] := .F.						//CANCELAMENTO

			aAdd(aValores, AClone(aDados))
			FwFreeArray(aDados)

			//Gera o movimento inverso do cancelamento
			If lCancel
				aDados     := Array(11)
				aDados[1]  := (cAliasQry)->E5_NATUREZ	//NATUREZA
				aDados[2]  := aValMov[1] * (-1)			//VALOR ORIGINAL
				aDados[3]  := aValMov[2] * (-1)			//JUROS
				aDados[4]  := aValMov[3] * (-1)			//CORREÇÃO
				aDados[5]  := aValMov[4] * (-1)			//DESCONTO
				aDados[6]  := aValMov[5] * (-1)			//ABATIMENTO
				aDados[7]  := aValMov[6] * (-1)			//IMPOSTO
				aDados[8]  := aValMov[7] * (-1)			//BAIXADO
				aDados[9]  := aValMov[8]					//ULT. BAIXA
				aDados[10] := aValMov[9] * (-1)			//MULTA
				aDados[11] := .T.						//CANCELAMENTO

				aAdd(aValores, AClone(aDados))
				FwFreeArray(aDados)
			EndIf
		EndIf
	EndIf

	FwFreeArray(aAreaSE1)
	FwFreeArray(aValMov)
Return aValores

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} F198TotSint

Totaliza os movimentos para as naturezas sintéticas

@author    Marcos Berto
@version   11.80
@since     08/01/13

@Param oReport	- Objeto do Relatório
@Param cNatureza	- Natureza a ser impressa o totalizador

/*/
//------------------------------------------------------------------------------------------
User Function F198TotSint()
	Local nX			:= 0
	Local nY			:= 0
	Local cNatureza 	:= ""
	Local nPosNat		:= ""
	Local nTotais       := 0
	Local nTotSint      := 0

	If ValType("aTotais") <> "U" .And. ValType("aTotSint") <> "U"
		nTotais := Len(aTotais)

		For nX := 1 to nTotais
			cNatureza := aTotais[nX][2]

			While cNatureza <> ""
				If (nPosNat := aScan(aTotSint,{|x| x[1] == cNatureza})) == 0
					exit
				EndIf

				nTotSint := Len(aTotSint[nPosNat][3])

				For nY:= 1 to nTotSint
					aTotSint[nPosNat][3][nY][2] += aTotais[nX][3][nY][2]
				Next nY

				cNatureza := aTotSint[nPosNat][2]
			EndDo
		Next nX
	EndIf

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} F198IncTot

Impressão de totalizadores

@author    Marcos Berto
@version   11.80
@since     08/01/13

@param oReport	- Objeto do Relatório
@param cNatureza	- Natureza a ser impressa o totalizador
@param cTotaliz	- Array que contém o totalizador

/*/
//------------------------------------------------------------------------------------------
User Function F198IncTot(oReport,cNatureza,cTotaliz)
	Local aTotalNat	:= {}
	Local nX		:= 0
	Local nPosNat	:= 0
	Local nValor	:= 0
	Local nFator	:= 1

	DEFAULT oReport		:= Nil
	DEFAULT cNatureza	:= ""
	DEFAULT cTotaliz	:= ""

	If ValType(cTotaliz) <> "U"

		aTotalNat := &cTotaliz

		nPosNat := aScan(aTotalNat,{|x| x[1] == cNatureza})

		If nPosNat > 0
			For nX := 1 to Len(aTotalNat[nPosNat][3])
				If aTotalNat[nPosNat][3][nX][2] <> 0

					If aTotalNat[nPosNat][3][nX][2] < 0
						nFator := -1
					Else
						nFator := 1
					EndIf

					nValor := aTotalNat[nPosNat][3][nX][2] * nFator

					oReport:PrintText( PadR(aTotalNat[nPosNat][3][nX][1]+": ",15),oReport:nRow )
					If nFator < 0
						oReport:PrintText("("+Transform(nValor, tm(nValor,20,__nDecs))+")",oReport:nRow )
					Else
						oReport:PrintText( Transform(nValor, tm(nValor,20,__nDecs)),oReport:nRow )
					EndIf
					oReport:SkipLine(1)
				EndIf
			Next nX
		EndIf

	EndIf

Return

//----------------------------------------
/*/{Protheus.doc} F198VldBx
Valida os motivos de baixa e/ou tipo do doc. do movimento.

IMPORTANTE: Para validação dos dados, o registro deve estar posicionado.
@author    Marcos Berto
@version   11.80
@since     08/01/13
@param cAlias - Alias em que os dados devem ser validados
@return lRet - Resultado da validação do movimento
/*/
//----------------------------------------
User Function F198VldBx(cAlias)
	Local lRet := .T.

	Default cAlias := ""

	If !Empty(cAlias)
		If (cAlias)->E5_MOTBX == "CMP"
			lRet := .F.
		ElseIf !Empty((cAlias)->E5_MOTBX) .And. !MovBcoBx((cAlias)->E5_MOTBX)
			lRet := .F.
		ElseIf (cAlias)->E5_SITUACA == "C"
			lRet := .F.
		EndIf
	EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} FK6Calc
Calcula as tabelas da FK6
@author jose.aribeiro
@since 10/08/2016
@version V12
@param cTabOrig, caracters, Tabela de Origem da SE5
@param cIdOrig , caracters, Chave de Origem da Tabela SE5
@param cTipo   , caracters, O tipo de Documento
/*/
//-------------------------------------------------------------------
Static Function FK6Calc(cTabOrig,cIdOrig,cTipo)
	Local nRet  := 0

	If ExistFunc('FXLOADFK6')
		nRet := FXLOADFK6(cTabOrig,cIdOrig,'VA')[1][2]
	Else
		nRet := 0
	EndIf

	If cTipo == 'ES'

		nRet *= -1

	EndIf

Return nRet

/*/{Protheus.doc}F198SeqBx
Busca a última sequência de baixa do título nas tabelas FK1 ou FK2

@param cTabFk, Character, Tabela FK na qual será feita a busca na sequencia de baixa
@param cFil, Character, Filial de inclusão do título
@param cPref, Character, Prefixo do título
@param cNro, Character, Número do título
@param cParc, Character, Parcela do título
@param cTipo, Character, Tipo do título
@param cCliFor, Character, Cliente / Fornecedor do título
@param cLoja, Character, Loja do Cliente / Fornecedor do título
@param oQryFk1, Character, Objeto de consulta da tabela FK1
@param oQryFk1, Character, Objeto de consulta da tabela FK2
@param lCachedQry, logical, se deve utilizar a classe FwExecStatement ou não
@return cSeqMax, Character, retorna a última sequência de baixa do título

@author		Sivaldo Oliveira
@since		09/09/2020
@version	12
@type		Function
/*/
Static Function F198SeqBx(cTabFk As Character, cFil As Character, cPref As Character, cNro As Character, cParc As Character, cTipo As Character, cCliFor As Character, cLoja As Character, oQryFK1 As Object, oQryFK2 As Object, lCachedQry As Logical) As Character

	Local cChaveTit	As Character
	Local cChaveFk7	As Character
	Local cQuery	As Character
	Local cSeqMax	As Character
	Local cSequen	As Character
	Local cTipDoc	As Character
	Local oQryFK	As Object

	Default cTabFk		:= ""
	Default cFil		:= ""
	Default cPref		:= ""
	Default cNro		:= ""
	Default cParc		:= ""
	Default cTipo		:= ""
	Default cCliFor		:= ""
	Default cLoja		:= ""
	Default oQryFK1		:= Nil
	Default oQryFK2		:= Nil
	Default lCachedQry	:= .F.

	//Inicializa variáveis.
	cChaveTit := ""
	cChaveFk7 := ""
	cQuery    := ""
	cSeqMax   := ""
	cSequen   := ""
	cTipDoc   := ""

	If !Empty(cTabFk) .And. cTabFk $ "FK1|FK2"
		cChaveTit := cFil + "|" + cPref + "|" + cNro + "|" + cParc + "|" + cTipo + "|" + cCliFor + "|" + cLoja
		cChaveFK7 := FINBuscaFK7(cChaveTit, IIf(cTabFk == "FK1", "SE1", "SE2"))

		If cTabFk == "FK1"
			cSequen := AllTrim(PadR("0", TamSX3("FK1_SEQ")[1], "0"))

			If oQryFK1 == Nil
				cQuery := "SELECT ISNULL(MAX(FK1_SEQ), '" + cSequen + "') MAXSEQ "
				cQuery += "FROM " + RetSQLName("FK1") + " FK1 WHERE "
				cQuery += "FK1_FILIAL = ? "
				cQuery += "AND FK1_IDDOC = ? "
				cQuery += "AND FK1.D_E_L_E_T_ = ? "
				cQuery  := ChangeQuery(cQuery)

				oQryFK1 := IIf(lCachedQry, FwExecStatement():New(cQuery), FwPreparedStatement():New(cQuery))
			EndIf

			oQryFK := oQryFK1
		Else
			cSequen := AllTrim(PadR("0", TamSX3("FK2_SEQ")[1], "0"))

			If oQryFk2 == Nil
				cQuery := "SELECT ISNULL(MAX(FK2_SEQ), '" + cSequen + "') MAXSEQ "
				cQuery += "FROM " + RetSQLName("FK2") + " FK2 WHERE "
				cQuery += "FK2_FILIAL = ? "
				cQuery += "AND FK2_IDDOC = ? "
				cQuery += "AND FK2.D_E_L_E_T_ = ? "
				cQuery  := ChangeQuery(cQuery)

				oQryFK2 := IIf(lCachedQry, FwExecStatement():New(cQuery), FwPreparedStatement():New(cQuery))
			EndIf

			oQryFK := oQryFK2
		EndIf

		oQryFK:SetString(1, FwXFilial(cTabFk))
		oQryFK:SetString(2, cChaveFK7)
		oQryFK:SetString(3, " ")

		cSeqMax := IIf(lCachedQry, oQryFK:ExecScalar("MAXSEQ", "600", "30"), MPSysExecScalar(oQryFK:GetFixQuery(), "MAXSEQ"))

		cSeqMax := IIf(cSequen == cSeqMax, "", cSeqMax)
	EndIf

Return cSeqMax
