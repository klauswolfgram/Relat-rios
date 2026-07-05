/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GFER032.ch"
#INCLUDE "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} GFER032

Relatório de Ocorrencias por Tipo

@author Luiz fernando Soares
@since 16/03/10
@version 1.0
/*/
//-------------------------------------------------------------------
User Function GFER032()

Local oReport
Local aArea := GetArea()

If TRepInUse()
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()
EndIf

RestArea( aArea )

Return

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os
//          relatorios que poderao ser agendados pelo usuario.
//
//Uso       GFER032
//---------------------------------------------------------------------------

Static Function ReportDef()
Local oReport, oSection1, oSection2
Local aOrdem := {}

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

oReport:= TReport():New("GFER032",STR0001,"GFER032", {|oReport| ReportPrint(oReport)},".")  //"Documentos com Ocorrência"
oReport:SetLandscape()
oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
oReport:SetTotalInLine(.F.)
Pergunte("GFER032",.F.)
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

Aadd( aOrdem, STR0002 ) // "Sequência" //"Codigo"

oSection1 := TRSection():New(oReport,STR0003,{"GW1"},aOrdem) // "Contrato com Autônomo" //"Documentos de Carga"
oSection1:SetLineStyle() //Define a impressao da secao em linha
oSection1:SetTotalInLine(.F.)
oSection1:SetColSpace(2)
TRCell():New(oSection1,"GW1_FILIAL" ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW1_EMISDC" ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW1_SERDC"  ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW1_NRDC"   ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW1_CDTPDC" ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"cDescTipo"  ,""   ,STR0004   ,/*Picture*/,50         ,/*lPixel*/,  {||POSICIONE("GV5",1,xFilial("GV5")+GW1->GW1_CDTPDC,"GV5_DSTPDC")}) //"Descrição"
TRCell():New(oSection1,"GW1_DTEMIS" ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW1_TPFRET" ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW1_CDREM"  ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"cNmRem"     ,""   ,STR0005   ,/*Picture*/,50         ,/*lPixel*/,  {||POSICIONE("GU3",1,xFilial("GU3")+GW1->GW1_CDREM ,"GU3_NMEMIT")}) //"Remetente"
TRCell():New(oSection1,"GW1_CDDEST" ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"cNmDest"    ,""   ,STR0006   ,/*Picture*/,50         ,/*lPixel*/,  {||POSICIONE("GU3",1,xFilial("GU3")+GW1->GW1_CDDEST,"GU3_NMEMIT")}) //"Destinatário"
TRCell():New(oSection1,"GW1_DTSAI"  ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW1_HRSAI"  ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW1_REGCOM" ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GW1_NRROM"  ,"GW1",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection2 := TRSection():New(oSection1,STR0008,{"GWD"},aOrdem) // "Valores Adicionais"  //"Ocorrências"
oSection2:SetTotalInLine(.F.)
oSection2:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
TRCell():New(oSection2,"GWD_NROCO"  ,"GWD",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"GWD_DSOCOR" ,"GWD",/*cTitle*/,/*Picture*/,20         ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"GWD_CDTIPO" ,"GWD",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"cDsTpOco"   ,""   ,STR0004   ,/*Picture*/,20         ,/*lPixel*/,  {||POSICIONE("GU5",1,xFilial("GU5")+GWD->GWD_CDTIPO,"GU5_DESC" )}) //"Descrição"
TRCell():New(oSection2,"GWD_CDMOT"  ,"GWD",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"cDsMotOco"  ,""   ,STR0004   ,/*Picture*/,20         ,/*lPixel*/,  {||POSICIONE("GU6",1,xFilial("GU6")+GWD->GWD_CDMOT ,"GU6_DESC" )}) //"Descrição"
TRCell():New(oSection2,"GWD_CDTRP"  ,"GWD",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"cNmTransp"  ,""  ,""         ,/*Picture*/,50         ,/*lPixel*/,  {||POSICIONE("GU3",1,xFilial("GU3")+GWD->GWD_CDTRP,"GU3_NMEMIT")})
TRCell():New(oSection2,"GWD_DTCRIA" ,"GWD",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"GWD_HRCRIA" ,"GWD",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"GWD_SIT"    ,"GWD",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

Return oReport

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os
//          relatorios que poderao ser agendados pelo usuario.
//---------------------------------------------------------------------------
//Parametros³ExpO1: Objeto Report do Relatório
//---------------------------------------------------------------------------
//Uso  GFER032
//---------------------------------------------------------------------------
Static Function ReportPrint(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local cExpFil   := MntExpFil(oReport:GetGCList())
Local cQuery    := ""
Local cAliasQry := GetNextAlias()
Local nRegs     := 0

	cQuery := "SELECT GW1_NRDC, GW1.R_E_C_N_O_ RECNOGW1, GWD.R_E_C_N_O_ RECNOGWD"
	cQuery +=  " FROM "+RetSqlName('GW1')+" GW1"
	cQuery += " INNER JOIN "+RetSqlName('GWL')+" GWL"
	cQuery +=    " ON GWL.GWL_FILDC   = GW1.GW1_FILIAL"
	cQuery +=   " AND GWL.GWL_EMITDC  = GW1.GW1_EMISDC"
	cQuery +=   " AND GWL.GWL_TPDC    = GW1.GW1_CDTPDC"
	cQuery +=   " AND GWL.GWL_SERDC   = GW1.GW1_SERDC"
	cQuery +=   " AND GWL.GWL_NRDC    = GW1.GW1_NRDC"
	cQuery +=   " AND GWL.D_E_L_E_T_  = ' '"
	cQuery += " INNER JOIN "+RetSqlName('GWD')+" GWD"
	cQuery +=    " ON GWD.GWD_FILIAL  = GWL.GWL_FILIAL"
	cQuery +=   " AND GWD.GWD_NROCO   = GWL.GWL_NROCO"
	cQuery +=   " AND GWD.D_E_L_E_T_  = ' '"
	cQuery += " WHERE GW1.GW1_FILIAL " + cExpFil
	cQuery +=   " AND GW1.GW1_CDTPDC >= '"+MV_PAR05      +"' AND GW1.GW1_CDTPDC <= '"+MV_PAR06      +"'"
	cQuery +=   " AND GW1.GW1_SERDC  >= '"+MV_PAR01      +"' AND GW1.GW1_SERDC  <= '"+MV_PAR02      +"'"
	cQuery +=   " AND GW1.GW1_NRDC   >= '"+MV_PAR03      +"' AND GW1.GW1_NRDC   <= '"+MV_PAR04      +"'"
	cQuery +=   " AND GW1.GW1_DTEMIS >= '"+DtoS(MV_PAR07)+"' AND GW1.GW1_DTEMIS <= '"+DtoS(MV_PAR08)+"'"
	cQuery +=   " AND GW1.GW1_CDREM  >= '"+MV_PAR09      +"' AND GW1.GW1_CDREM  <= '"+MV_PAR10      +"'"
	cQuery +=   " AND GW1.GW1_CDDEST >= '"+MV_PAR11      +"' AND GW1.GW1_CDDEST <= '"+MV_PAR12      +"'"
	cQuery +=   " AND GW1.GW1_NRROM  >= '"+MV_PAR15      +"' AND GW1.GW1_NRROM  <= '"+MV_PAR16      +"'"
	cQuery +=   " AND GW1.GW1_REGCOM >= '"+MV_PAR17      +"' AND GW1.GW1_REGCOM <= '"+MV_PAR18      +"'"
	cQuery +=   " AND GWD.GWD_CDTRP  >= '"+MV_PAR13      +"' AND GWD.GWD_CDTRP  <= '"+MV_PAR14      +"'"
	cQuery +=   " AND GW1.D_E_L_E_T_ = ' '"
	cQuery += " ORDER BY " + SqlOrder(GW1->(IndexKey(1)))
	cQuery := ChangeQuery(cQuery)
	DbUseArea(.T.,'TOPCONN',TcGenQry(,,cQuery),cAliasQry,.F.,.T.)

	// Conta o número de registros retornado no cursor
	(cAliasQry)->(DBEval( { || nRegs ++ },,{ || !(cAliasQry)->(Eof()) } ) )

	oReport:SetMeter(nRegs)

	(cAliasQry)->(DbGoTop())

	oSection1:Init() // Início da seção 1

	While !oReport:Cancel() .And. !(cAliasQry)->(Eof())

		oReport:IncMeter() // Incrementa régua de progressão

		GW1->(DbGoTo((cAliasQry)->RECNOGW1))

		oSection1:PrintLine()

		oReport:PrintText(STR0009,,300) // Imprime o identificador dos Valores Adicionais //"Ocorrencias"

		oSection2:Init()

		While !oReport:Cancel() .And. (cAliasQry)->GW1_NRDC == GW1->GW1_NRDC

			GWD->(DbGoTo((cAliasQry)->RECNOGWD))

			oSection2:PrintLine()

			(cAliasQry)->(DbSkip())

		EndDo

		oSection2:Finish()

		oReport:SkipLine()
		oReport:FatLine()
		oReport:SkipLine()

	EndDo

	(cAliasQry)->(DbCloseArea())

	oSection1:Finish()

Return

// -----------------------------------------------------------
/*/{Protheus.doc} MntExpFil
Monta expressão utilizada para filtrar filial no SQL principal
do relatório

@param   aSelFil  Array retornado pela função GetGCList()

@author  Guilherme A. Metzger
@since   17/05/2016
@version 1.0
@obs     Para os casos em que se utiliza Gestão de Empresas
/*/
// -----------------------------------------------------------
Static Function MntExpFil(aSelFil)
Local cExpFil := ""

	If !Empty(aSelFil)
		If Len(aSelFil) > 1
			AEval(aSelFil, { | x | cExpFil += Iif(cExpFil=="",x,"','"+x) } )
			cExpFil := " IN ('" + cExpFil + "')"
		Else
			cExpFil := " = '" + aSelFil[1] + "'"
		EndIf
	Else
		cExpFil := " = '" + xFilial('GW1') + "'"
	EndIf

Return cExpFil