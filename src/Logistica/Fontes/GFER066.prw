/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include 'Protheus.ch'
#Include 'GFER066.ch'
/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFER066
Relatorio de Saldo de Frete 
Generico.

@sample
U_GFER066()

@author Amanda Vieira
@since 13/01/2016
@version 1.0
--------------------------------------------------------------------------------------------------/*/
User Function GFER066()
Local oReport := NIL                   //objeto que contem o relatorio
Local aArea   := GetArea()
 
Private nTotalEmi  := 0
Private nTotalGeral:= 0
Private cAliasTemp
Private cAliasDC := ""

dbSelectArea('SX1')
SX1->(dbSetOrder(1))
If !SX1->(MsSeek('GFER066   01'))
	MsgAlert('Cadastre o pergunte GFER066 do requisito PCREQ-9329 para utilizar o relatório')
	Return
EndIf

If TRepInUse() // teste padrão
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()
EndIf

If Select(cAliasTemp) > 0
	(cAliasTemp)->(dbCloseArea())
EndIf

If !Empty(cAliasDC) .and. Select(cAliasDC) > 0
	(cAliasDC)->(dbCloseArea())
EndIf

RestArea( aArea )

Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportDef
{Protheus.doc} GFER066
Relatorio de Saldo de Frete
Generico.

@sample
ReportDef()

@author Amanda Vieira
@since 13/01/2016
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function ReportDef()
Local oSection1, oSection2, oSection3, oSection4, oSection5 := NIL
Local oReport   := NIL
Local oCell     := NIL
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de  impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= TReport():New("GFER066",STR0001,"GFER066", {|oReport| ReportPrint(oReport)},STR0002)//"Saldo de Frete"##"Emite a listagem dos Saldo de Conhecimentos de Frete conforme os parâmetros informados."  
oReport:SetLandscape()     // define se o relatorio sairá deitado
oReport:SetTotalInLine(.F.)
Pergunte("GFER066",.F.)
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


oSection1 := TRSection():New(oReport,STR0003,{"(|)","GU3"},/*aOrdem*/)  //"Emitentes de Transporte"
oSection1:SetTotalInLine(.F.)

TRCell():New(oSection1,"GW3_EMISDF","(cAliasTemp)",STR0004,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasTemp)->GW3_EMISDF })//"Emissor"
TRCell():New(oSection1,"GU3_NMEMIT","GU3",STR0005,/*Picture*/,50,/*lPixel*/, {|| GU3->GU3_NMEMIT }/*{|| code-block de impressao }*/)//"Nome"
TRCell():New(oSection1,"GU3_FONE1" ,"GU3",STR0006,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| GU3->GU3_FONE1  }/*{|| code-block de impressao }*/)//"Telefone"
TRCell():New(oSection1,"GU3_EMAIL" ,"GU3",STR0007,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| GU3->GU3_EMAIL  }/*{|| code-block de impressao }*/)//"Email"

TRPosition():New(oSection1,"GU3",1,{|| xFilial("GU3") + (cAliasTemp)->GW3_EMISDF})

oSection2 := TRSection():New(oSection1,STR0008,{"(cAliasTemp)"},/*aOrdem*/) //  //""Documentos de Frete""
oSection2:SetTotalInLine(.F.)

TRCell():New(oSection2,"GW3_FILIAL","(cAliasTemp)",STR0009 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasTemp)->GW3_FILIAL})//"Filial"
oCell := TRCell():New(oSection2,"GW3_CDESP" ,"(cAliasTemp)",STR0010 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasTemp)->GW3_CDESP })//"Espécie" 
oCell:lUserEnabled := .F.
oCell := TRCell():New(oSection2,"GW3_EMISDF","(cAliasTemp)",STR0011 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasTemp)->GW3_EMISDF})//"Emissor"
oCell:lUserEnabled := .F.
TRCell():New(oSection2,"GW3_SERDF" ,"(cAliasTemp)",STR0012 ,'!!!'      ,/*Tamanho*/,/*lPixel*/,{|| (cAliasTemp)->GW3_SERDF })//"Série"
TRCell():New(oSection2,"GW3_NRDF"  ,"(cAliasTemp)",STR0013 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasTemp)->GW3_NRDF  })//"Nr Doc Frete"
TRCell():New(oSection2,"GW3_DTEMIS","(cAliasTemp)",STR0014 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| StoD((cAliasTemp)->GW3_DTEMIS)})//"Dt Emissão"
TRCell():New(oSection2,"GW3_DTENT" ,"(cAliasTemp)",STR0015 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| StoD((cAliasTemp)->GW3_DTENT) })//"Dt Entrada"
oCell := TRCell():New(oSection2,"GW3_CDREM" ,"(cAliasTemp)",STR0016 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasTemp)->GW3_CDREM })//"Remetente"
oCell:lUserEnabled := .F.
oCell := TRCell():New(oSection2,"GU3_NMEMIT","GU3",STR0017 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| GU3->GU3_NMEMIT})//"Nome Remetente"
oCell:lUserEnabled := .F.
oCell := TRCell():New(oSection2,"GW3_CDDEST","(cAliasTemp)",STR0018 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasTemp)->GW3_CDDEST})//"Destinatário"
oCell:lUserEnabled := .F.
oCell := TRCell():New(oSection2,"GU3_NMEMIT","GU3",STR0019 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| GU3->GU3_NMEMIT})//"Nome Destinatário"
oCell:lUserEnabled := .F.
oCell := TRCell():New(oSection2,"GW6_FILIAL","(cAliasTemp)",STR0020 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasTemp)->GW6_FILIAL})//"Filial Fatura"
oCell:lUserEnabled := .F.
oCell := TRCell():New(oSection2,"GW6_EMIFAT","(cAliasTemp)",STR0021 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasTemp)->GW6_EMIFAT})//"Emissor Fatura"
oCell:lUserEnabled := .F.
oCell := TRCell():New(oSection2,"GU3_NMEMIT","GU3",STR0022,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| GU3->GU3_NMEMIT})//"Nome Emissor Fatura"
oCell:lUserEnabled := .F.
TRCell():New(oSection2,"GW6_SERFAT","(cAliasTemp)",STR0023 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasTemp)->GW6_SERFAT})//"Série Fatura"
TRCell():New(oSection2,"GW6_NRFAT" ,"(cAliasTemp)",STR0024 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasTemp)->GW6_NRFAT })//"Nr Fatura"
TRCell():New(oSection2,"GW6_DTFIN" ,"(cAliasTemp)",STR0025 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIF(!Empty((cAliasTemp)->GW6_NRFAT) .And. (cAliasTemp)->GW6_SITFIN == '4',StoD((cAliasTemp)->GW6_DTFIN),StoD("")) })//"Dt Integra Fin"

If GFXCP12127("GW6_DTLIQD")
	oFldHide := TRCell():New(oSection2, "GW6_DTLIQD"	, "(cAliasTemp)"	, "Dt. Liquid.", /*Picture*/,/*Tamanho*/,/*lPixel*/,{|| StoD((cAliasTemp)->GW6_DTLIQD) })//"Dt Liquid."
	oFldHide:lUserEnabled := .F.
EndIf
	
TRCell():New(oSection2,"GW3_VLDF"  ,"(cAliasTemp)",STR0026 ,PesqPict("GW3","GW3_VLDF") ,/*Tamanho*/,/*lPixel*/,{|| (cAliasTemp)->GW3_VLDF})//"Valor"
/**************************************************************************/
oSection3 := TRSection():New(oSection2,STR0027,,/* aOrdem*/) //"Total Emissor"
oSection3:SetTotalInLine(.T.)
oSection3:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
oSection3:SetLineStyle()

TRCell():New(oSection3,"nTotalEmi"   ,"",STR0027,/*Picture*/,12,/*lPixel*/,{|| Alltrim(Transform(nTotalEmi, PesqPict("GW3","GW3_VLDF")))  })
oSection3:Cell("nTotalEmi"):SetHeaderAlign('LEFT')
oSection3:Cell("nTotalEmi"):SetAlign('LEFT' )

/**************************************************************************/
oSection4 := TRSection():New(oSection2,STR0028,,/*aOrdem*/) //  //"Total Geral"
oSection4:SetTotalInLine(.T.)
oSection4:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
oSection4:SetLineStyle()


oSection5 := TRSection():New(oSection2,"Documentos de Carga")
oSection5:SetTotalInLine(.F.)

TRCell():New(oSection5,"GWM_CDTPDC" ,cAliasDC, "Tipo DC" ,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasDC)->GWM_CDTPDC})
TRCell():New(oSection5,"GWM_SERDC" ,cAliasDC, "Série",'!!!'      ,/*Tamanho*/,/*lPixel*/, {|| (cAliasDC)->GWM_SERDC})//"Serie"
TRCell():New(oSection5,"GWM_NRDC" ,cAliasDC, "Número"  ,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cAliasDC)->GWM_NRDC})
TRCell():New(oSection5,"VLFRET" ,cAliasDC, "Val. Rat."       ,PesqPict("GWM","GWM_VLFRET"),/*Tamanho*/,/*lPixel*/, {|| (cAliasDC)->VLFRET})

TRCell():New(oSection4,"nTotalGeral"    ,"" ,STR0028,/*Picture*/,12,/*lPixel*/,{||Alltrim(Transform(nTotalGeral, PesqPict("GW3","GW3_VLDF"))) } ) //"Descrição Unit."
oSection4:Cell("nTotalGeral"):SetAlign('LEFT')
oSection4:Cell("nTotalGeral"):SetHeaderAlign('LEFT')

Return(oReport)


/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportPrint
Relatorio de Saldo de Frete
Generico.

@sample
ReportPrint(oReport)

@author Amanda Vieira
@since 13/01/201
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function ReportPrint(oReport)
Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oSection1:Section(1)
Local oSection3 	:= oSection2:Section(1)
Local oSection4 	:= oSection2:Section(2)

Local oSection6
Local oSection5		:= oSection2:Section(3)
Local nRegs     	:= 0
Local cEmisAnt   	:= ""
Local cDataAux   	:= ""
Local lHasDc        := .F.

	If AllTrim(MV_PAR10) != "" 
		If(MV_PAR04 <= MV_PAR10)
			cDataAux := DToS(MV_PAR04)
		Else
			cDataAux := DToS(MV_PAR10)
		EndIf
		
		cDataCorte := Substr(cDataAux,7,2) + "/" + Substr(cDataAux,5,2) + "/" + Substr(cDataAux,1,4)
		
		oSection6 := TRSection():New(oReport,"Info",,/*Ordem*/,/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*/,/*lTotalInLine*/,.T.)
		TRCell():New(oSection6,"cDataCorte"    ,"" ,"Data Corte: " + cDataCorte,/*Picture*/,12,/*lPixel*/)
	EndIf
	
	CarregaDados(oReport)
	
	//Calcula a quantidade de registros para utilizar na regra de progressão
	( cAliasTemp )->( dbEval( { || nRegs ++ },,{ || ( cAliasTemp )->( !Eof() ) } ) )
	
	oReport:SetMeter( nRegs )
	
	dbSelectArea(cAliasTemp)
	(cAliasTemp)->( dbGoTop())
	While !oReport:Cancel() .And. !(cAliasTemp)->( Eof() )
		//Soma valor de todos os documentos de frete
		nTotalGeral += (cAliasTemp)->GW3_VLDF 
		
		oSection1:Init()
		oSection2:Init()

		oSection4:Init()

		oReport:IncMeter()
		
		If cEmisAnt != (cAliasTemp)->GW3_EMISDF
			dbSelectArea("GU3")	
			GU3->(dbSetOrder(1))//GU3_FILIAL+GU3_CDEMIT
			GU3->(dbSeek(xFilial('GU3')+(cAliasTemp)->GW3_EMISDF))
			
			//Quando muda o transportador, mostra o cabecalho do documento de frete
			oSection2:SetHeaderSection(.T.) 

			oSection1:PrintLine()
			
			
			//Soma valor do documento de frete agrupado por emitente
			nTotalEmi := (cAliasTemp)->GW3_VLDF 
			cEmisAnt  := (cAliasTemp)->GW3_EMISDF
		Else 
			If cValToChar(MV_PAR11) == '1' .and. lHasDc
				oSection2:SetHeaderSection(.T.)
				
				oReport:SkipLine()
				oSection2:PrintHeader()
				lHasDc := .F.
			EndIf
		
			oSection2:SetHeaderSection(.F.)

			nTotalEmi += (cAliasTemp)->GW3_VLDF 
		EndIf
		oSection1:Finish()
		oSection2:PrintLine()
		
		if cValToChar(MV_PAR11) == '1'

			carregaDC((cAliasTemp)->GW3_FILIAL,;
					  (cAliasTemp)->GW3_CDESP,;
					  (cAliasTemp)->GW3_EMISDF,;
					  (cAliasTemp)->GW3_SERDF,;
					  (cAliasTemp)->GW3_NRDF,;
					  (cAliasTemp)->GW3_DTEMIS)

			If !(cAliasDC)->(EoF())
				lHasDc := .T.

				oSection5:Init()

				While !(cAliasDC)->(EoF())
					
					oSection5:PrintLine()

					(cAliasDC)->(DbSkip())
				End
				oSection5:Finish()
			
			EndIf

		Endif
					
		(cAliasTemp)->( dbSkip() )

		If (cEmisAnt != (cAliasTemp)->GW3_EMISDF .and. nTotalEmi != 0) .or. (cAliasTemp )->(Eof())
			oSection3:Init()
			oSection3:PrintLine()
			oSection3:Finish()
		EndIf

		oSection2:Finish()	
	EndDo
	oSection4:PrintLine()
	oSection4:Finish()

Return

Static Function CarregaDados(oReport)
Local aGCList := oReport:GetGCList()// Função retorna array com filiais que o usuário tem acesso
Local cQuery  := ""
Local cFiliais:= ""
Local nCont   := 0 

	cQuery := " SELECT GW3.GW3_EMISDF," 
	cQuery += " GW3.GW3_FILIAL, "
	cQuery += " GW3.GW3_TPDF, "
	cQuery += " GW3.GW3_CDESP,  "
	cQuery += " GW3.GW3_EMISDF, "
	cQuery += " GW3.GW3_SERDF,  "
	cQuery += " GW3.GW3_NRDF,   "
	cQuery += " GW3.GW3_DTEMIS, "
	cQuery += " GW3.GW3_DTENT,  "
	cQuery += " GW3.GW3_CDREM,  "
	cQuery += " GW3.GW3_VLDF,   "
	cQuery += " GW3.GW3_CDDEST, "
	cQuery += " GW6.GW6_FILIAL, "
	cQuery += " GW6.GW6_EMIFAT, "
	cQuery += " GW6.GW6_SERFAT, "
	cQuery += " GW6.GW6_NRFAT,  "
	cQuery += " GW6.GW6_DTFIN,  "
	If GFXCP12127("GW6_DTLIQD")
		cQuery += " GW6.GW6_DTLIQD, "
	EndIf
	cQuery += " GW6.GW6_SITFIN  "
	cQuery += "FROM "+RetSqlName('GW3')+" GW3"
	cQuery += " LEFT JOIN "+RetSqlName('GW6')+" GW6"
	cQuery += "  ON GW6.GW6_FILIAL = GW3.GW3_FILFAT"
	cQuery += " AND GW6.GW6_EMIFAT = GW3.GW3_EMIFAT"
	cQuery += " AND GW6.GW6_SERFAT = GW3.GW3_SERFAT"
	cQuery += " AND GW6.GW6_NRFAT  = GW3.GW3_NRFAT "
	cQuery += " AND GW6.GW6_DTEMIS = GW3.GW3_DTEMFA"
	cQuery += " AND GW6.D_E_L_E_T_ = ' '" 
	cQuery += " WHERE GW3.D_E_L_E_T_ = ' '"
	
	If Empty(aGCList)
		cQuery += " AND GW3.GW3_FILIAL >= '"+MV_PAR01+"'"
		cQuery += IIF(!Empty(MV_PAR02)," AND GW3.GW3_FILIAL <= '"+MV_PAR02+"'", "")
	Else
		cFiliais += '('
		For nCont := 1 To Len(aGCList)
			If nCont != 1
				cFiliais += ","
			EndIf 
			cFiliais += "'"+aGCList[nX]+"'" 
	 	Next nCont
		cFiliais += ")"
		cQuery += " AND GW3.GW3_FILIAL IN " + cFiliais 
	EndIf
	
	If MV_PAR07 == 1
		cQuery += " AND GW3.GW3_NRFAT <> ''"	
	ElseIf MV_PAR07 == 2
		cQuery += " AND GW3.GW3_NRFAT = ''"
	EndIf
	
	cQuery += IIF (!Empty(MV_PAR03), " AND GW3.GW3_DTENT >= '"+ DTOS(MV_PAR03) +"'", "")
	cQuery += IIF (!Empty(MV_PAR04), " AND GW3.GW3_DTENT <= '"+ DTOS(MV_PAR04) +"'", "")
	cQuery += IIF (!Empty(MV_PAR05), " AND GW3.GW3_DTEMIS >='"+ DTOS(MV_PAR05) +"'", "")
	cQuery += IIF (!Empty(MV_PAR06), " AND GW3.GW3_DTEMIS <='"+ DTOS(MV_PAR06) +"'", "")
	
	If MV_PAR08 == 1 .And. (MV_PAR07 == 1 .Or. MV_PAR07 == 3)
		cQuery += " AND (GW6.GW6_SITFIN  = '4' OR GW3.GW3_NRFAT = '')"
	ElseIf MV_PAR08 == 2  .And. (MV_PAR07 == 1 .Or. MV_PAR07 == 3)
		cQuery += " AND (GW6.GW6_SITFIN  <> '4'  OR GW3.GW3_NRFAT = '')"
	EndIf
	
	cQuery += IIF (!Empty(MV_PAR09), " AND (GW6.GW6_DTFIN >='"+ DTOS(MV_PAR09) +"' OR GW6.GW6_DTFIN = '' OR GW3.GW3_NRFAT = '')", "")
	cQuery += IIF (!Empty(MV_PAR10), " AND (GW6.GW6_DTFIN <='"+ DTOS(MV_PAR10) +"' OR GW6.GW6_DTFIN = '' OR GW3.GW3_NRFAT = '')", "")

	
	cQuery += " ORDER BY GW3.GW3_EMISDF"
	cQuery := ChangeQuery(cQuery)
	cAliasTemp := GetNextAlias()
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,ChangeQuery(cQuery)),cAliasTemp, .F., .T.)
	dbSelectArea((cAliasTemp))
Return
//-------------------------------------------------------------------
/*/{Protheus.doc} carregaDC(cFil, cEspecie, cCodTransp, cSerie, cNumero, cDataEmissao)
Carrega o alias cAliasDC com dados dos documento de carga do documento de frete passado por parametro
@author  Lucas Briesemeister
@since   30/12/2019
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function carregaDC(cFil, cEspecie, cCodTransp, cSerie, cNumero, cDataEmissao)

	If !Empty(cAliasDC) .and. Select(cAliasDC) > 0
		(cAliasDC)->(dbCloseArea())
	EndIf

	cAliasDC := GetNextAlias()

	BeginSql Alias cAliasDC
		SELECT GWM.GWM_FILIAL,
			GWM.GWM_CDTPDC,
			GWM.GWM_SERDC,
			GWM.GWM_NRDC,
			%exp:SelectRateio()%

		FROM %table:GWM% GWM

		WHERE GWM.GWM_FILIAL = %exp:cFil%
			AND GWM.GWM_TPDOC = '2'
			AND GWM.GWM_CDESP = %exp:cEspecie%
			AND GWM.GWM_CDTRP = %exp:cCodTransp%
			AND GWM.GWM_SERDOC = %exp:cSerie%
			AND GWM.GWM_NRDOC = %exp:cNumero%
			AND GWM.GWM_DTEMIS = %exp:cDataEmissao%
			AND GWM.%notDel%
		
		GROUP BY GWM.GWM_FILIAL,
			GWM.GWM_CDTPDC,
			GWM.GWM_SERDC,
			GWM.GWM_NRDC

		ORDER BY GWM.GWM_CDTPDC,
			GWM.GWM_SERDC,
			GWM.GWM_NRDC

	EndSql

Return
//-------------------------------------------------------------------
/*/{Protheus.doc} SelectRateio()
Retorna strin para embedded sql com o campo de soma do valor de frete de acordo com parametro de rateio
@author  Lucas Briesemeister
@since   30/12/2019
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function SelectRateio()

	Local cQuery as char
	Local cTpRateio as char

	cTpRateio := SuperGetMV('MV_CRIRAT', .F., '1')

	cQuery := ""

	Do Case
        Case cTpRateio == "1"
            cQuery += "% SUM(GWM.GWM_VLFRET) AS VLFRET %"
        Case cTpRateio == "2"
            cQuery += "% SUM(GWM.GWM_VLFRE1) AS VLFRET %"
        Case cTpRateio == "3"
            cQuery += "% SUM(GWM.GWM_VLFRE3) AS VLFRET %"
        Case cTpRateio == "4"
            cQuery += "% SUM(GWM.GWM_VLFRE2) AS VLFRET %"
        Otherwise
            cQuery += "% SUM(GWM.GWM_VLFRET) AS VLFRET %"
    EndCase

Return cQuery

