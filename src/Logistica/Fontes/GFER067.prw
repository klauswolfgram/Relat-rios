/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include 'GFER067.CH'
#Include 'Protheus.ch'
/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFER067
Relatorio de Manifesto de Carga.
Generico.

@sample
U_GFER067()

@author Amanda Vieira
@since 13/01/2016
@version 1.0
--------------------------------------------------------------------------------------------------/*/
User Function GFER067()
	Local oReport 		:= NIL                   //objeto que contem o relatorio
	Local aArea   		:= GetArea()
	Local lRet    		:= .T.

	//-- Totalizadores por Romaneio
	Static nNtRelRom  	:= 0  //Notas Relacionadas no romaneio
	Static nPesoBruto 	:= 0  //Peso Bruto
	Static nPesoLiq   	:= 0  //Peso Líquido
	Static nVolume    	:= 0  //Volumes 
	Static nValTotal  	:= 0  //Valor total das notas do romaneio
	//-- Totalizadores por Doc de Carga
	Static nPesoRTot   // Soma do valor do campo GW8_PESOR (Peso Real)
	Static nQtdAltTot  // Soma do valor do campo GW8_QTDALT(Qtd/Peso Alt)
	Static nValorTot   // Soma do valor do campo GW8_VALOR (Valor)
	Static nQuantTot   // Soma do valor do campo GWB_QTDE  (Quantidade)
	//-- Informações do trecho do documento
	Static cCidadeDes  // Cidade Destino
	Static cUFDes      // Uf Destino
	//--  Alias da tabela temporária
	Static cAliasTemp   := GetNextAlias()
	Static cAliasQry    := GetNextAlias()
	//-- Sequência dos Doc de Carga
	Static nSequen 		:= 0
	
	If TRepInUse() .And. lRet // teste padrão
		oReport := ReportDef()
		oReport:PrintDialog()	
	EndIf
	
	If Select(cAliasTemp) > 0
		(cAliasTemp)->(dbCloseArea())
	EndIf

	RestArea( aArea )
Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportDef
Generico.

@sample
ReportDef()

@author Amanda Vieira
@since 13/01/2016
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function ReportDef()
	Local oReport    := NIL
	Local oCell      := NIL
	Local aTipoFrete := RetSX3Box(Posicione('SX3',2,'GW1_TPFRET','X3CBox()'),,,1)
	Local oSection1, oSection2, oSection3, oSection4, oSection5, oSection6 := NIL

	Pergunte("GFEA052", .F.)

	Private cMotor1    	:= MV_PAR04
	Private cMotor2    	:= MV_PAR05
	Private cPlacaD    	:= MV_PAR06 
	Private cPlacaT    	:= MV_PAR07
	Private cPlacaM    	:= MV_PAR08
	Private dDataSaida 	:= MV_PAR09
	Private cHoraSaida 	:= MV_PAR10

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
	oReport:= TReport():New("GFER067",STR0001,"GFEA052", {|oReport| ReportPrint(oReport)},STR0002)  //"GFE - Relatório Manifesto de Carga","GFEA052"
	oReport:SetLandscape()     // define se o relatorio sairá deitado
	oReport:HideParamPage()

	//Pergunte("GFER067",.F.)
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

	oSection1 := TRSection():New(oReport,STR0003,{"(|)","GWN"},/*aOrdem*/)  //""Dados do Romaneio""
	oSection1:SetTotalInLine(.T.)
	oSection1:SetLineStyle()
	oSection1:SetColSpace(2)

	TRCell():New(oSection1,"GWN_FILIAL","GWN",STR0004,/*Picture*/,TamSx3("GWN_FILIAL")[1],/*lPixel*/,{|| (cAliasTemp)->GWN_FILIAL }) //"Filial"
	TRCell():New(oSection1,"GWN_NRROM" ,"GWN",STR0005,/*Picture*/,TamSx3("GWN_NRROM")[1] ,/*lPixel*/,{|| (cAliasTemp)->GWN_NRROM }) //"Nr Romaneio"
	TRCell():New(oSection1,"GWN_VIAGEM","GWN",STR0041,/*Picture*/,TamSx3("GWN_VIAGEM")[1] ,/*lPixel*/,{|| (cAliasTemp)->GWN_VIAGEM }) //"Nr Romaneio" 
	oCell := TRCell():New(oSection1,"GWN_DTIMPL","GWN",STR0006,/*Picture*/,10,/*lPixel*/,{|| StoD((cAliasTemp)->GWN_DTIMPL) })//"Dt. Emis. Romaneio"
	oCell:lCellBreak := .T.
	TRCell():New(oSection1,"GWN_CDTRP" ,"GWN",STR0007,/*Picture*/,TamSx3("GWN_CDTRP")[1] ,/*lPixel*/,{|| (cAliasTemp)->GWN_CDTRP}) //"Cod. Transp."
	TRCell():New(oSection1,"GWN_DSTRP" ,"GWN",STR0008,/*Picture*/,TamSx3("GWN_DSTRP")[1],/*lPixel*/,{|| (cAliasTemp)->GWN_NMEMIT }) //"Nome Transp."
	TRCell():New(oSection1,"GWN_PLACAD","GWN",STR0009,/*Picture*/,TamSx3("GWN_PLACAD")[1]+1,/*lPixel*/,{|| IIF(MV_PAR11 == 2,cPlacaD ,(cAliasTemp)->GWN_PLACAD) }) //"Placas "
	TRCell():New(oSection1,"GWN_PLACAT","GWN",""     ,/*Picture*/,TamSx3("GWN_PLACAT")[1]+1,/*lPixel*/,{|| IIF(MV_PAR11 == 2,cPlacaT,(cAliasTemp)->GWN_PLACAT) })
	oCell := TRCell():New(oSection1,"GWN_PLACAM","GWN",""     ,/*Picture*/,TamSx3("GWN_PLACAM")[1],/*lPixel*/,{|| IIF(MV_PAR11 == 2,cPlacaM,(cAliasTemp)->GWN_PLACAM) })
	oCell:lCellBreak := .T.
	If MV_PAR11 == 2 //Impressão Oficial
		TRCell():New(oSection1,"GWN_CDMTR" ,"GWN",STR0010,/*Picture*/,TamSx3("GWN_CDMTR")[1] ,/*lPixel*/,{|| cMotor1}) //"Motorista"
		TRCell():New(oSection1,"GWN_NMMTR" ,"GWN",STR0011,/*Picture*/,TamSx3("GWN_NMMTR")[1],/*lPixel*/,{|| Alltrim(POSICIONE("GUU",1,XFILIAL("GUU")+cMotor1,"GUU_NMMTR"))})//"Nome Motorista"
		oCell := TRCell():New(oSection1,"GUU_IDFEED","GUU",STR0037,/*Picture*/,TamSx3("GUU_IDFED")[1] ,/*lPixel*/,{|| POSICIONE("GUU",1,XFILIAL("GUU")+cMotor1,"GUU_IDFED")})//"CPF Motorista"
		oCell:lCellBreak := .T.
		TRCell():New(oSection1,"GWN_CDMTR2","GWN",STR0038,/*Picture*/,TamSx3("GWN_CDMTR2")[1],/*lPixel*/,{|| cMotor2})//Motorista 02
		TRCell():New(oSection1,"GWN_NMMTR2","GWN",STR0039,/*Picture*/,TamSx3("GWN_NMMTR")[1],/*lPixel*/,{|| Alltrim(POSICIONE("GUU",1,XFILIAL("GUU")+cMotor2,"GUU_NMMTR"))})//"Nome Motorista 02"
		oCell :=  TRCell():New(oSection1,"GUU_IDFEED","GUU",STR0040,/*Picture*/,TamSx3("GUU_IDFED")[1] ,/*lPixel*/,{|| POSICIONE("GUU",1,XFILIAL("GUU")+cMotor2,"GUU_IDFED")})//"CPF Motorista 02"
		oCell:lCellBreak := .T.
	Else
		TRCell():New(oSection1,"GWN_CDMTR" ,"GWN",STR0010,/*Picture*/,TamSx3("GWN_CDMTR")[1],/*lPixel*/,{|| (cAliasTemp)->GWN_CDMTR}) //"Motorista"
		TRCell():New(oSection1,"GWN_NMMTR" ,"GWN",STR0011,/*Picture*/,TamSx3("GWN_NMMTR")[1],/*lPixel*/,{|| Alltrim(POSICIONE("GUU",1,XFILIAL("GUU")+(cAliasTemp)->GWN_CDMTR,"GUU_NMMTR"))})//"Nome Motorista"
		oCell := TRCell():New(oSection1,"GUU_IDFEED","GUU",STR0037,/*Picture*/,TamSx3("GUU_IDFED")[1],/*lPixel*/,{|| POSICIONE("GUU",1,XFILIAL("GUU")+(cAliasTemp)->GWN_CDMTR,"GUU_IDFED")}) //"CPF Motorista"
		oCell:lCellBreak := .T.
		TRCell():New(oSection1,"GWN_CDMTR" ,"GWN",STR0038,/*Picture*/,TamSx3("GWN_CDMTR")[1],/*lPixel*/,{|| (cAliasTemp)->GWN_CDMTR2})//"Motorista 02"
		TRCell():New(oSection1,"GWN_NMMTR2","GWN",STR0039,/*Picture*/,TamSx3("GWN_NMMTR")[1],/*lPixel*/,{|| Alltrim(POSICIONE("GUU",1,XFILIAL("GUU")+(cAliasTemp)->GWN_CDMTR2,"GUU_NMMTR"))})//"Nome Motorista 02"
		oCell := TRCell():New(oSection1,"GUU_IDFEED","GUU",STR0040,/*Picture*/,TamSx3("GUU_IDFED")[1],/*lPixel*/,{|| POSICIONE("GUU",1,XFILIAL("GUU")+(cAliasTemp)->GWN_CDMTR2,"GUU_IDFED")})//"CPF Motorista 02"
		oCell:lCellBreak := .T.
	EndIf
	TRCell():New(oSection1,"GWN_VPVAL" ,"GWN","Valor Pedágio",/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasTemp)->GWN_VPVAL }) //"Lacre"
	TRCell():New(oSection1,"GW1_CDTPDC","GW1",STR0012,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasTemp)->GW1_CDTPDC }) //"Nota Fiscal de Saída"

	If GfeVerCmpo({"GWN_LACRE"})
		TRCell():New(oSection1,"GWN_LACRE" ,"GWN",STR0013,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasTemp)->GWN_LACRE }) //"Lacre"
	EndIf
	/****************************************************************************/

	oSection2 := TRSection():New(oSection1,STR0014,{"GW1"},/*aOrdem*/) //"Sequência de Entrega"
	oSection2:SetTotalInLine(.F.)
      
	TRCell():New(oSection2,"nSequen"   ,""   ,STR0015,/*Picture*/,3                      ,/*lPixel*/,{|| STRZERO(nSequen, 3, 0) }) //"Seq"
	TRCell():New(oSection2,"GW1_FILIAL","GW1",STR0004,/*Picture*/,TamSx3("GW1_FILIAL")[1],/*lPixel*/,{|| (cAliasTemp)->GW1_FILIAL}) //"Filial" 
	TRCell():New(oSection2,"GW1_NRDC"  ,"GW1",STR0016,/*Picture*/,TamSx3("GW1_NRDC")[1]  ,/*lPixel*/,{|| (cAliasTemp)->GW1_NRDC}) //"Nr Doc"
	TRCell():New(oSection2,"GW1_SERDC" ,"GW1",STR0017,'!!!'      ,TamSx3("GW1_SERDC")[1] ,/*lPixel*/,{|| (cAliasTemp)->GW1_SERDC }) //"Série"
	TRCell():New(oSection2,"GW1_DTEMIS","GW1",STR0018,/*Picture*/,TamSx3("GW1_DTEMIS")[1],/*lPixel*/,{|| StoD((cAliasTemp)->GW1_DTEMIS)  }) //"Data Emissão"
	TRCell():New(oSection2,"nPesoRTot" ,"GW8",STR0019,/*Picture*/,TamSx3("GW8_PESOR")[1] ,/*lPixel*/,{|| Alltrim(Transform(nPesoRTot, PesqPict("GW8","GW8_PESOR")))}) //"Peso Bruto"
	TRCell():New(oSection2,"nQtdAltTot","GW8",STR0020,/*Picture*/,TamSx3("GW8_QTDALT")[1],/*lPixel*/,{|| Alltrim(Transform(nQtdAltTot,PesqPict("GW8","GW8_QTDALT")))}) //"Peso Líquido"
	TRCell():New(oSection2,"nValorTot" ,"GW8",STR0021,/*Picture*/,TamSx3("GW8_VALOR")[1] ,/*lPixel*/,{|| Alltrim(Transform(nValorTot, PesqPict("GW8","GW8_VALOR")))}) //"Valor Tot Nota"
	TRCell():New(oSection2,"nQuantTot" ,"GW1",STR0022,/*Picture*/,TamSx3("GW1_QTVOL")[1]  ,/*lPixel*/,{|| Alltrim(Transform(nQuantTot, PesqPict("GW1","GW1_QTVOL")))}) //"Volumes"
	TRCell():New(oSection2,"GW1_CDDEST","GW1",STR0023,/*Picture*/,TamSx3("GW1_CDDEST")[1],/*lPixel*/,{|| (cAliasTemp)->GW1_CDDEST}) //"Cód. Cliente"
	TRCell():New(oSection2,"cNmDest"   ,"GU3",STR0024,/*Picture*/,15                     ,/*lPixel*/,{|| (cAliasTemp)->GW1_NMEMIT}) //"Nome Cliente"
	TRCell():New(oSection2,"cNmCidd"   ,"GU7",STR0025,/*Picture*/,23                     ,/*lPixel*/,{|| (cAliasTemp)->GU7_NMCID}) //"Cidade"
	TRCell():New(oSection2,"cUF"       ,"GU7",STR0026,/*Picture*/,TamSx3("GU7_CDUF")[1]  ,/*lPixel*/,{|| (cAliasTemp)->GU7_CDUF}) //"UF"
	TRCell():New(oSection2,"GW1_TPFRET","GW1",STR0027,/*Picture*/,3                      ,/*lPixel*/,{|| aTipoFrete[Val((cAliasTemp)->GW1_TPFRET),3]}) //"Tipo Frete"
	/**************************************************************************/
	oSection3 := TRSection():New(oSection2,STR0028,,/* aOrdem*/) //"Totais"
	oSection3:SetTotalInLine(.F.)
	oSection3:SetHeaderSection(.F.) //Define que imprime cabeçalho das células na quebra de seção

	//Utiliza células vazias para posicionar os totalizadores conforme a oSection2
	TRCell():New(oSection3,"cCelVazia" ,"GW1",STR0015,/*Picture*/,19                     ,/*lPixel*/,{||STR0028+" "+ cValToChar(nNtRelRom) +" "+STR0032}) //"TOTAIS: n NOTA(S)"
	TRCell():New(oSection3,"cCelVazia" ,"GW1",STR0015,/*Picture*/,0                      ,/*lPixel*/,)
	TRCell():New(oSection3,"cCelVazia" ,"GW1",STR0015,/*Picture*/,0                      ,/*lPixel*/,)
	TRCell():New(oSection3,"cCelVazia" ,"GW1",STR0017,'!!!'      ,TamSx3("GW1_SERDC")[1] ,/*lPixel*/,) //"Série"
	TRCell():New(oSection3,"cCelVazia" ,"GW1",STR0018,/*Picture*/,TamSx3("GW1_DTEMIS")[1],/*lPixel*/,) //"Data Emissão"
	TRCell():New(oSection3,"nPesoBruto","GW8",STR0019,/*Picture*/,TamSx3("GW8_PESOR")[1] ,/*lPixel*/,{|| Alltrim(Transform(nPesoBruto, PesqPict("GW8","GW8_PESOR")))}) //"Peso Bruto"
	TRCell():New(oSection3,"nPesoLiq"  ,"GW8",STR0020,/*Picture*/,TamSx3("GW8_QTDALT")[1],/*lPixel*/,{|| Alltrim(Transform(nPesoLiq,PesqPict("GW8","GW8_QTDALT")))}) //"Peso Líquido"
	TRCell():New(oSection3,"nValTotal" ,"GW8",STR0021,/*Picture*/,TamSx3("GW8_VALOR")[1] ,/*lPixel*/,{|| Alltrim(Transform(nValTotal, PesqPict("GW8","GW8_VALOR"))) }) //"Valor Tot Nota"
	TRCell():New(oSection3,"nVolume"   ,"GW1",STR0022,/*Picture*/,TamSx3("GW1_QTVOL")[1]  ,/*lPixel*/,{|| Alltrim(Transform(nVolume, PesqPict("GW1","GW1_QTVOL")))}) //"Volumes"
	/****************************************************************************/
	oSection4 := TRSection():New(oSection2,STR0029,,/* aOrdem*/) //"Assinatura"
	oSection4:SetHeaderSection(.F.) //Define que imprime cabeçalho das células na quebra de seção

	TRCell():New(oSection4,"declaracao","GW1","Campo Vazio",/*Picture*/,160,/*lPixel*/,{||STR0030+Alltrim(GetFilRom(SM0->M0_CODIGO,(cAliasTemp)->GWN_FILIAL))+STR0031  }) //"Declaração" // "Declaro ter recebido da empresa " # " as mercadoria e notas fiscais relacionadas a este manifesto de carga."
	oSection4:Cell("declaracao"):SetAlign('CENTER')
	/****************************************************************************/
	oSection5 := TRSection():New(oSection2,STR0029,,/* aOrdem*/) //"Assinatura"
	oSection5:SetTotalInLine(.F.)
	oSection5:SetHeaderSection(.F.)

	TRCell():New(oSection5,"assinatura1" ,"","",/*Picture*/,40,/*lPixel*/,{|| "________________________________________"})
	TRCell():New(oSection5,"assinatura2" ,"","",/*Picture*/,60,/*lPixel*/,{|| "________________________________________"})
	TRCell():New(oSection5,"assinatura3" ,"","",/*Picture*/,40,/*lPixel*/,{|| "________________________________________"})

	oSection5:Cell("assinatura1"):SetAlign('CENTER')
	oSection5:Cell("assinatura2"):SetAlign('CENTER')
	oSection5:Cell("assinatura3"):SetAlign('CENTER')
	/****************************************************************************/
	oSection6 := TRSection():New(oSection2,STR0029,,/* aOrdem*/) 
	oSection6:SetTotalInLine(.F.)
	oSection6:SetHeaderSection(.F.)

	TRCell():New(oSection6,"assinatura1" ,"","",/*Picture*/,40,/*lPixel*/,{|| STR0033}) //"Conferente Transportadora"
	TRCell():New(oSection6,"assinatura2" ,"","",/*Picture*/,60,/*lPixel*/,{|| STR0034+SM0->M0_NOMECOM}) //"Conferente "
	TRCell():New(oSection6,"assinatura3" ,"","",/*Picture*/,40,/*lPixel*/,{|| STR0035}) //"Conferente Motorista"

	oSection6:Cell("assinatura1"):setAlign('CENTER')
	oSection6:Cell("assinatura2"):SetAlign('CENTER')
	oSection6:Cell("assinatura3"):SetAlign('CENTER')
Return(oReport)

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportPrint
Generico.

@sample
ReportPrint(oReport)

@author Amanda Vieira
@since 13/01/201
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function ReportPrint(oReport)
	Local nRegs     := 0
	Local cRomAnt   := ""
	Local cDocAnt   := ""
	Local oSection1 := oReport:Section(1)
	Local oSection2 := oReport:Section(1):Section(1)
	Local oSection3 := oReport:Section(1):Section(1):Section(1)
	Local oSection4 := oReport:Section(1):Section(1):Section(2)
	Local oSection5 := oReport:Section(1):Section(1):Section(3)
	Local oSection6 := oReport:Section(1):Section(1):Section(4)

	cMotor1    	:= MV_PAR04
	cMotor2    	:= MV_PAR05
	cPlacaD    	:= MV_PAR06 
	cPlacaT    	:= MV_PAR07
	cPlacaM    	:= MV_PAR08
	dDataSaida 	:= MV_PAR09
	cHoraSaida 	:= MV_PAR10
	
	If MV_PAR12 <> 2
		Help(,, 'HELP',,STR0036, 1, 0) //"Para imprimir o relatório Manifesto de Carga é necessário parametrizar o modelo como Manifesto. "
		return
	EndIf
	
	CarregaDados(oReport)
	
	//Calcula a quantidade de registros para utilizar na regra de progressão
	( cAliasTemp )->( dbEval( { || nRegs ++ },,{ || ( cAliasTemp )->( !Eof() ) } ) )
	
	oReport:SetMeter( nRegs )
	
	dbSelectArea(cAliasTemp)
	(cAliasTemp)->( dbGoTop())
	While !oReport:Cancel() .And. !(cAliasTemp)->( Eof() )	
		oReport:IncMeter()
		//-- Posiciona para leitura correta de dados dos campos customizaveis
		GW1->(dbGoTo((cAliasTemp)->RECNOGW1))	
		GWN->(dbGoTo((cAliasTemp)->RECNOGWN))

		If cRomAnt <> (cAliasTemp)->GWN_NRROM
		 	If !Empty(cRomAnt)
			 	oSection3:Init()
				oSection3:PrintLine()
				oSection3:Finish()
				
				//Assinatura
				oSection4:Init()
				oSection4:PrintLine()
				oSection4:Finish()		
				
				oReport:SkipLine(2)
				
				oSection5:Init()
				oSection5:PrintLine()
				oSection5:Finish()
				
				oSection6:Init()
				oSection6:PrintLine()
				oSection6:Finish()	 
				
				oReport:EndPage()
		 	EndIf
		 	oSection2:SetHeaderSection(.T.)
		 	
			cRomAnt := (cAliasTemp)->GWN_NRROM
			
			//Limpa variáveis totalizadoras
			nSequen   := 0
			nNtRelRom := 0  
			nPesoBruto:= 0
			nPesoLiq  := 0 
			nValTotal := 0
			nVolume	  := 0
			
			oSection1:SetWidth(2)
			oSection1:Init()
			oSection1:PrintLine()
			oSection1:Finish()
			
			//Impressão Oficial
			If MV_PAR11 == 2
				GWN->(dbGoTo((cAliasTemp)->RECGWN))
				GFE52IMPOF(dDataSaida,cHoraSaida,cMotor1,cMotor2,cPlacaD,cPlacaT,cPlacaM)
			EndIf
		Else 
			oSection2:SetHeaderSection(.F.)
		EndIf
		
		If cDocAnt <> (cAliasTemp)->GW1_NRDC
			cDocAnt := (cAliasTemp)->GW1_NRDC
			nSequen++
			//Calcula valores de peso e quantidade totais do documento de carga
			CalculaTotais()
			//Acrescenta número de notas relacionadas  
			nNtRelRom++
			 
			oSection2:Init()
			oSection2:PrintLine()
			oSection2:Finish() 
		EndIf
		(cAliasTemp)->(dbSkip())
	EndDo
	
	oSection3:Init()
	oSection3:PrintLine()
	oSection3:Finish()	
	
	oSection4:Init()
	oSection4:PrintLine()
	oSection4:Finish()		
	
	oReport:SkipLine(2)
	
	oSection5:Init()
	oSection5:PrintLine()
	oSection5:Finish()
	
	oSection6:Init()
	oSection6:PrintLine()
	oSection6:Finish()
Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} CarregaDados
Carrega dados para impressão

@author Amanda Vieira
@since 13/01/2016
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function CarregaDados(oReport)
	Local cQuery  := ""

	cQuery := " SELECT GWN_FILIAL,GWN_NRROM,GWN_PLACAD,GWN_PLACAT,GWN_PLACAM,GWN_CDTRP,GWN_CDMTR,GWN_CDMTR2,GWN_DTIMPL,GWN_VPVAL,GWN.R_E_C_N_O_ AS RECGWN,  GW1.R_E_C_N_O_ RECNOGW1, GWN.R_E_C_N_O_ RECNOGWN,"
	cQuery += " GWN_VIAGEM,"

	If GfeVerCmpo({"GWN_LACRE"})
		cQuery += " GWN_LACRE,"
	EndIf
	cQuery +=        " GW1_FILIAL,GW1_CDTPDC,GW1_NRDC,GW1_SERDC,GW1_DTEMIS,GW1_TPFRET,GW1_CDDEST,GW1_QTVOL,GW1_ENTNRC,GW1_EMISDC,GU7_NMCID,GU7_CDUF,GU3B.GU3_NMEMIT GWN_NMEMIT,GU3A.GU3_NMEMIT GW1_NMEMIT"
	cQuery +=  " FROM "+RetSqlName('GWN')+" GWN"
	cQuery += "	INNER JOIN "+RetSqlName('GW1')+" GW1"
	If GFXCP1212210('GW1_FILROM')
		cQuery +=    " ON GW1_FILROM = GWN_FILIAL"
	Else
		cQuery +=    " ON GW1_FILIAL = GWN_FILIAL"
	EndIf
	cQuery +=   " AND GW1_NRROM  = GWN_NRROM"
	cQuery +=   " AND GW1.D_E_L_E_T_ = ' '"
	cQuery += " INNER JOIN "+RetSqlName('GU3')+" GU3A"
	cQuery +=    " ON GU3A.GU3_FILIAL = '"+xFilial('GU3')+"'"
	cQuery +=   " AND GU3A.GU3_CDEMIT = GW1.GW1_CDDEST"
	cQuery +=   " AND GU3A.D_E_L_E_T_ = ''"
	cQuery += " INNER JOIN "+RetSqlName('GU7')+" GU7"
	cQuery +=    " ON GU7_FILIAL = '"+xFilial('GU7')+"'"
	cQuery +=   " AND GU7_NRCID  = GU3A.GU3_NRCID"
	cQuery +=   " AND GU7.D_E_L_E_T_ =' '"
	cQuery += " INNER JOIN "+RetSqlName('GU3')+" GU3B"
	cQuery +=  	 " ON GU3B.GU3_FILIAL = '"+xFilial('GU3')+"'"
	cQuery += 	" AND GU3B.GU3_CDEMIT = GWN_CDTRP"
	cQuery +=   " AND GU3B.D_E_L_E_T_ = ' '"
	cQuery += " WHERE GWN_FILIAL = '"+MV_PAR01+"'"
	cQuery +=   " AND GWN_NRROM >= '"+MV_PAR02+"'"
	cQuery +=   " AND GWN_NRROM <= '"+MV_PAR03+"'"
	cQuery +=   " AND GWN.D_E_L_E_T_ = ' '"
	cQuery += " ORDER BY GWN_NRROM"
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTemp,.F.,.T.)
	dbSelectArea((cAliasTemp))
Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} CalculaTotais()
Calcula totalizadores do romaneio

@author Amanda Vieira
@since 13/01/2016
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function CalculaTotais()
	Local cQuery := ""

	cQuery := " SELECT SUM(GW8_PESOR) AS PesoRTot"
	cQuery += "      , SUM(GW8_QTDALT) AS QtdAltTot"
	cQuery += "      , SUM(GW8_VALOR) AS ValorTot"
	cQuery += "   FROM "+RetSqlName('GW8')+""
	cQuery += "  WHERE GW8_FILIAL = '"+(cAliasTemp)->GW1_FILIAL+"'" 
	cQuery += "    AND GW8_CDTPDC = '"+(cAliasTemp)->GW1_CDTPDC+"'" 
	cQuery += "    AND GW8_EMISDC = '"+(cAliasTemp)->GW1_EMISDC+"'" 
	cQuery += "    AND GW8_SERDC  = '"+(cAliasTemp)->GW1_SERDC+"'" 
	cQuery += "    AND GW8_NRDC   = '"+(cAliasTemp)->GW1_NRDC+"'"
	cQuery += "    AND D_E_L_E_T_ = ' '"
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.F.,.T.)

	If (cAliasQry)->(!Eof())
		nPesoRTot  := (cAliasQry)->PesoRTot
		nQtdAltTot := (cAliasQry)->QtdAltTot
		nValorTot  := (cAliasQry)->ValorTot

		nPesoBruto += nPesoRTot
		nPesoLiq   += nQtdAltTot
		nValTotal  += nValorTot
	EndIf
	(cAliasQry)->(dbCloseArea())
	
	//Cálcula totalizador de Quantidade de Volumes
	nQuantTot  := (cAliasTemp)->GW1_QTVOL
	nVolume   += nQuantTot
Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GetFilRom()
Função que retorna a filial do romaneio

@author Amanda Vieira
@since 13/01/2016
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function GetFilRom(cSM0Emp,cCodFil)
	Local cNmEmp   := ""
	Local aAreaSM0 := SM0->(GetArea())
	
	SM0->( DbSetOrder(1) )
	//Pesquisa a empresa informada
	If SM0->( DbSeek( cSM0Emp + cCodFil ) )
		cNmEmp := SM0->M0_NOMECOM
	Endif
 
	RestArea(aAreaSM0)
Return cNmEmp
