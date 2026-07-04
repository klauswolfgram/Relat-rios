/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.CH"
#Include "fwcommand.CH"
#Include "FINR355.CH"

Static lIsIssBx  := FindFunction("IsIssBx")
Static lFWCodFil := FindFunction("FWCodFil")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FinR355  ³ Autor ³ Pâmela Bernardo       ³ Data ³ 10/08/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impostos por fornecedor						              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR355(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function FinR355()

#IFNDEF CDX
	Alert("Relatório disponivel apenas para versões TOTVSDBACCESS")
	Return
#ENDIF
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport := ReportDef()
If !Empty(oReport:uParam)
	Pergunte(oReport:uParam,.F.)
EndIf
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Pâmela Bernardo     ³ Data ³ 10/08/12	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local oFornecedores
Local oTitsForn
Local oDetbx
Local oTotaisForn
Local oCell
Local nTam := 0
Local cPictTit:= PesqPict("SE2","E2_VALOR")
Local cAliasSE2		:= GetNextAlias()
Local cAliasSE5		:= GetNextAlias()
Local lGestao 		:= Iif( lFWCodFil, FWSizeFilial() > 2, .F. )	// Indica se usa Gestao Corporativa
Local nGestao 		:= Iif(lFWCodFil, FWSizeFilial() ,2)

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
oReport := TReport():New("FINR355",STR0004,"FIN355", {|oReport| ReportPrint(oReport, @cAliasSE2, @cAliasSE5)},STR0001+" "+STR0002+" "+STR0003) //"Demonstrar os títulos a pagar por fornecedor e "##"status da retenção dos impostos, ‡„o"##"quando efetuados na baixa."
oReport:SetTotalInLine(.F.)
oReport:SetEdit(.F.)//-- Desabilitado botao personalizar, se o usuario incluir campo numerico nao eh possivel totalizar corretamente,
                    //--  segundo Framework teria de reescrever o relatorio.

/*
GESTAO - inicio */
oReport:SetUseGC(.F.)
/* GESTAO - fim
*/

//seção de fornecedor
oFornecedores := TRSection():New(oReport,STR0016,{"SA2"},{OemToAnsi(STR0012),OemToAnsi(STR0013) })   //Por Codigo - Por Nome

nTam:= TAMSX3("A2_COD")[1]+TAMSX3("A2_LOJA")[1] + 10
TRCell():New(oFornecedores,STR0005 	,,STR0005,/*Picture*/,nTam/*Tamanho*/,/*lPixel*/,)
nTam:= TAMSX3("A2_NOME")[1]
TRCell():New(oFornecedores,STR0040	,,STR0040,,nTam)
nTam:= TAMSX3("A2_NREDUZ")[1]
TRCell():New(oFornecedores,STR0041	,,STR0041,,nTam)

//seção de titulos
oTitsForn := TRSection():New(oFornecedores,STR0017,{"SE2","SED"})	//"Titulos
nTam:= TAMSX3("E2_PREFIXO")[1]+TAMSX3("E2_NUM")[1]+1
TRCell():New(oTitsForn,"E2_PREFIXO" 	,cAliasSE2,STR0006,/*Picture*/,nTam/*Tamanho*/,/*lPixel*/,) //"Prf Numero"
nTam:= TAMSX3("E2_PARCELA")[1]+3
TRCell():New(oTitsForn,"E2_PARCELA"		,cAliasSE2,STR0007 ,		, nTam)	//"PC"
nTam:= TAMSX3("E2_TIPO")[1]+1
TRCell():New(oTitsForn,"E2_TIPO"    	,cAliasSE2,STR0009 ,		, nTam)	//"Tipo"
nTam:= TAMSX3("E2_VALOR")[1]+5
TRCell():New(oTitsForn,STR0008      	, 	  	  ,STR0008	,cPictTit,nTam) //"Valor Original"
nTam:= TAMSX3("E2_EMISSAO")[1]+5
TRCell():New(oTitsForn,STR0014  		,         ,STR0014  ,		,nTam) //"Emissao"
TRCell():New(oTitsForn,"E2_VENCREA"		,cAliasSE2,STR0015	,		,nTam) //"Vencimento"
nTam:= TAMSX3("E2_PIS")[1]
TRCell():New(oTitsForn,STR0018     		,	  	   ,STR0018 ,cPictTit,nTam) //"Lei 10925"
TRCell():New(oTitsForn,STR0019     		,	  	   ,STR0019 ,		,1) //"S10925"
TRCell():New(oTitsForn,"E2_IRRF"      	,cAliasSE2,STR0020  ,		,nTam)	//"IRRF"
TRCell():New(oTitsForn,STR0021			,	  	   ,STR0021	,		,1)	//"SIRRF"
TRCell():New(oTitsForn,"E2_INSS"		,cAliasSE2,STR0022 	,		,nTam)	//"INSS"
TRCell():New(oTitsForn,"E2_ISS"			,cAliasSE2,STR0023  ,		,nTam) //"ISS"
TRCell():New(oTitsForn,STR0024      	,	  	   ,STR0024 ,		,1) //"SISS"
TRCell():New(oTitsForn,"E2_PRINSS"		,cAliasSE2,STR0025  ,		,nTam) //"PROV INSS"
TRCell():New(oTitsForn,"E2_PRISS"		,cAliasSE2,STR0026  ,		,nTam) //"PROV ISS"
nTam:= TAMSX3("E2_VALOR")[1]+3
TRCell():New(oTitsForn,STR0027     		,	  	  ,STR0027  ,cPictTit,nTam)	//"Valor Liquido"
TRCell():New(oTitsForn,STR0028     		,	  	  ,STR0028  ,cPictTit,nTam)	//"Valor Pago"
TRCell():New(oTitsForn,STR0029			,		  ,STR0029  ,cPictTit,nTam)	//"Saldo Atual"

//alinhamento do cabeçalho das celulas da seção titulos
oTitsForn:Cell(STR0008):SetHeaderAlign("RIGHT")
oTitsForn:Cell(STR0014):SetHeaderAlign("CENTER")
oTitsForn:Cell(STR0015):SetHeaderAlign("CENTER")
oTitsForn:Cell(STR0024):SetHeaderAlign("CENTER")
oTitsForn:Cell(STR0018 ):SetHeaderAlign("RIGHT")
oTitsForn:Cell(STR0019):HideHeader() //Status fica oculto
oTitsForn:Cell(STR0020):SetHeaderAlign("RIGHT")
oTitsForn:Cell(STR0021):HideHeader()
oTitsForn:Cell(STR0022):SetHeaderAlign("RIGHT")
oTitsForn:Cell(STR0023):SetHeaderAlign("RIGHT")
oTitsForn:Cell(STR0024):HideHeader()
oTitsForn:Cell(STR0027):SetHeaderAlign("RIGHT")
oTitsForn:Cell(STR0028):SetHeaderAlign("RIGHT")
oTitsForn:Cell(STR0029):SetHeaderAlign("RIGHT")

//alinhamento das celulas da seção titulos
oTitsForn:Cell(STR0008):SetAlign("RIGHT")
oTitsForn:Cell(STR0014):SetAlign("CENTER")
oTitsForn:Cell(STR0015):SetAlign("CENTER")
oTitsForn:Cell(STR0024):SetAlign("CENTER")
oTitsForn:Cell(STR0018 ):SetAlign("RIGHT")
oTitsForn:Cell(STR0019):SetAlign("RIGHT")
oTitsForn:Cell(STR0020):SetAlign("RIGHT")
oTitsForn:Cell(STR0021):SetAlign("RIGHT")
oTitsForn:Cell(STR0022):SetAlign("RIGHT")
oTitsForn:Cell(STR0023):SetAlign("RIGHT")
oTitsForn:Cell(STR0027):SetAlign("RIGHT")
oTitsForn:Cell(STR0028):SetAlign("RIGHT")
oTitsForn:Cell(STR0029):SetAlign("RIGHT")

oTitsForn:SetHeaderPage(.F.)
oTitsForn:SetHeaderSection(.T.)

//seção detalhamento de baixa
oDetbx:= TRSection():New(oTitsForn,STR0030,{"SE2","SE5"},,,,,,,,,,50)	//"detalhamento de baixa"


nTam:= TAMSX3("E5_DATA")[1]+10
TRCell():New(oDetbx,STR0031 	,,STR0031,/*Picture*/,nTam/*Tamanho*/,/*lPixel*/,) //"Data da baixa"

nTam:= TAMSX3("E5_MOTBX")[1]+6
TRCell():New(oDetbx,STR0032	,,STR0032 ,, nTam)	//"Motivo de baixa"

nTam:= TAMSX3("E5_VALOR")[1]+1
TRCell():New(oDetbx,STR0033     , 	  ,STR0033	,cPictTit,nTam) //"Lei 10925 - SE5"
TRCell():New(oDetbx,STR0042  	, 	  ,STR0042 	,		 ,1) //"Status 10925"
TRCell():New(oDetbx,STR0034   	,	  ,STR0034 	,cPictTit,nTam) //"Irrf - SE5"
TRCell():New(oDetbx,STR0043  	, 	  ,STR0043 	,		 ,1) //"Status Irrf"
TRCell():New(oDetbx,STR0035     ,	  ,STR0035 	,cPictTit,nTam) //"ISS - SE5"
TRCell():New(oDetbx,STR0044  	, 	  ,STR0044 	,		 ,1) //"Status Iss"
TRCell():New(oDetbx,STR0036  	, 	  ,STR0036 	,cPictTit,nTam) //"Valor de Baixa"

//alinhamento do cabeçalho das celulas da seção titulos
oDetbx:Cell(STR0031):SetHeaderAlign("CENTER")
oDetbx:Cell(STR0032):SetHeaderAlign("CENTER")
oDetbx:Cell(STR0033):SetHeaderAlign("CENTER")
oDetbx:Cell(STR0042):HideHeader() //Status fica oculto
oDetbx:Cell(STR0034):SetHeaderAlign("CENTER")
oDetbx:Cell(STR0043):HideHeader() //Status fica oculto
oDetbx:Cell(STR0035):SetHeaderAlign("CENTER")
oDetbx:Cell(STR0044):HideHeader() //Status fica oculto
oDetbx:Cell(STR0036):SetHeaderAlign("CENTER")

//alinhamento das celulas da seção titulos
oDetbx:Cell(STR0031):SetAlign("CENTER")
oDetbx:Cell(STR0032):SetAlign("CENTER")
oDetbx:Cell(STR0033):SetAlign("CENTER")
oDetbx:Cell(STR0042):SetAlign("CENTER")
oDetbx:Cell(STR0034):SetAlign("CENTER")
oDetbx:Cell(STR0043):SetAlign("CENTER")
oDetbx:Cell(STR0035):SetAlign("CENTER")
oDetbx:Cell(STR0044):SetAlign("CENTER")
oDetbx:Cell(STR0036):SetAlign("CENTER")


// seção de totais do fornecedor
oTotaisForn := TRSection():New(oTitsForn,STR0011,{"SE2","SED"})	//
oTotaisForn:SetHeaderSection(.T.)	//Imprime o cabeçalho da secao

TRCell():New(oTotaisForn,"E2_PREFIXO" 	,cAliasSE2,STR0006,/*Picture*/,nTam/*Tamanho*/,/*lPixel*/,) //"Prf Numero"
nTam:= TAMSX3("E2_PARCELA")[1]+4
TRCell():New(oTotaisForn,"E2_PARCELA"	,cAliasSE2,STR0007,		      , nTam)	//"PC"
nTam:= TAMSX3("E2_TIPO")[1]+2
TRCell():New(oTotaisForn,"E2_TIPO"    	,cAliasSE2,STR0009,			  ,nTam)	//"Tipo"
TRCell():New(oTotaisForn,STR0014  		,          ,STR0014,		      ,nTam) //"Emissao"
TRCell():New(oTotaisForn,STR0018     	,	  	   ,STR0018,cPictTit    ,nTam) //"Lei 10925"
TRCell():New(oTotaisForn,"E2_IRRF"     	,cAliasSE2,STR0020,		      ,nTam)	//"IRRF"
TRCell():New(oTotaisForn,STR0021		,	  	   ,STR0021,		      ,3)	//"SIRRF"
TRCell():New(oTotaisForn,"E2_INSS"		,cAliasSE2,STR0022,		      ,nTam)	//"INSS"
TRCell():New(oTotaisForn,"E2_ISS"		,cAliasSE2,STR0023,		      ,nTam) //"ISS"
TRCell():New(oTotaisForn,STR0024      	,	  	   ,STR0024,		      ,3) //"SISS"
TRCell():New(oTotaisForn,"E2_PRINSS"	,cAliasSE2,STR0025,		      ,nTam) //"PROV INSS"
TRCell():New(oTotaisForn,"E2_PRISS"	,cAliasSE2,STR0026,		       ,nTam) //"PROV ISS"
nTam:= TAMSX3("E2_VALOR")[1]+3
TRCell():New(oTotaisForn,STR0027        ,	  	    ,STR0027  ,cPictTit ,nTam)	//"Valor Liquido"
TRCell():New(oTotaisForn,STR0010        ,          ,STR0010   ,cPictTit , 17) //"Total Fornecedor


oTotaisForn:Cell(STR0006):HIDE()
oTotaisForn:Cell(STR0007):HIDE()
oTotaisForn:Cell(STR0009):HIDE()
oTotaisForn:Cell(STR0014):HIDE()
oTotaisForn:Cell(STR0018):HIDE()
oTotaisForn:Cell(STR0020):HIDE()
oTotaisForn:Cell(STR0021):HIDE()
oTotaisForn:Cell(STR0022):HIDE()
oTotaisForn:Cell(STR0023):HIDE()
oTotaisForn:Cell(STR0024):HIDE()
oTotaisForn:Cell(STR0025):HIDE()
oTotaisForn:Cell(STR0026):HIDE()
oTotaisForn:Cell(STR0027):HIDE()

/*
GESTAO - inicio */
// Seção de totais por FILIAL
oTotaisFilial := TRSection():New(oTitsForn,"TOTFIL",{"SE2","SED"})
oTotaisFilial:SetHeaderSection(.F.)	//Nao imprime o cabeçalho da secao
oTotaisFilial:SetLinesBefore(0)
oTotaisFilial:SetAutosize(.F.)
TRCell():New(oTotaisFilial,"TXTTOTAL"	,	,"TXTTOTAL"	,,58) // SALDO FILIAL:
TRCell():New(oTotaisFilial,"SLDFIL"		,	,"SLDFIL"	,cPictTit ,17) //"Saldo Filial"

// Seção de totais por EMPRESA
oTotaisEmp := TRSection():New(oTitsForn,"TOTEMP",{"SE2","SED"})
oTotaisEmp:SetHeaderSection(.F.)	//Nao imprime o cabeçalho da secao
oTotaisEmp:SetLinesBefore(0)
oTotaisEmp:SetAutosize(.F.)
TRCell():New(oTotaisEmp,"TXTTOTAL"	,	,"TXTTOTAL"	,,58) // SALDO EMPRESA:
TRCell():New(oTotaisEmp,"SLDEMP"	,	,"SLDEMP"	,cPictTit ,17) //"Saldo Empresa"

//Totalizador Geral
oTotalGeral := TRSection():New(oTitsForn,"TOTGERAL",{"SE2","SED"}) 
oTotalGeral:SetHeaderSection(.F.)	//Nao imprime o cabeçalho da secao
oTotalGeral:SetLinesBefore(0)
oTotaisFilial:SetAutosize(.F.)
TRCell():New(oTotalGeral,"TXTTOTAL"	,	,"TXTTOTAL"	,,58)  // STR0047 - SALDO GERAL ---->
TRCell():New(oTotalGeral,"SLDGERAL"	,	,"SLDGERAL"	,cPictTit ,17) // "Saldo Geral"

If cPaisLoc != "BRA"
	oTotaisFilial:Cell("TXTOTAL"):Hide()
	oTotaisFilial:Cell("SLDFIL"):SetTitle("")
	oTotaisEmp:Cell("TXTOTAL"):Hide()
	oTotaisEmp:Cell("SLDEMP"):SetTitle("")
	oTotalGeral:Cell("TXTOTAL"):Hide()
	oTotalGeral:Cell("SLDGERAL"):SetTitle("")
EndIf
/* GESTAO - fim
*/

oFornecedores:SetColSpace(0)
oTitsForn:SetColSpace(0) 
oTotaisFilial:SetColSpace(0)
oTotaisEmp:SetColSpace(0)
oTotalGeral:SetColSpace(0)
oDetbx:SetColSpace(0)
oTotaisForn:SetColSpace(0)

oReport:SetLandScape()         
oReport:lDisableOrientation := .T.

Return(oReport)  

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Pâmela Bernardo      ³ Data ³13/08/2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport, cAliasSE2, cAliasSE5)

Local oFornecedores	:= oReport:Section(1)
Local oTitsForn		:= oReport:Section(1):Section(1)
Local oDetbx		:= oReport:Section(1):Section(1):Section(1)
Local oTotaisForn	:= oReport:Section(1):Section(1):Section(2)
Local oTotaisFilial := oReport:Section(1):Section(1):Section(3)
Local oTotaisEmp	:= oReport:Section(1):Section(1):Section(4)
Local oTotalGeral	:= oReport:Section(1):Section(1):Section(5)
Local cFornecedor   := ""
Local aValor 		:= {}
Local nTotAbat      := 0
Local bPosTit		:= { || }		// Posiciona a impressao dos titulos do fornecedor
Local bWhile		:= { || }		// Condicao para impressao dos titulos do fornecedor
Local nSaldo		:= 0
Local lInitForn		:=	.T.
Local lProcSQL 		:= .T.
Local lPCCBaixa 	:= SuperGetMv("MV_BX10925",.T.,"2") == "1"
Local nValorOrig 	:= 0
Local lPaBruto		:= GetNewPar("MV_PABRUTO","2") == "1"  //Indica se o PA terá o valor dos impostos descontados do seu valor
Local lImpTit		:= .T.		// Indica se imprime o titulo a pagar (SE2)
Local nInc			:= 0
Local nX			:= 0
Local cQuery	  	:= ""
//Query na SE2
Local nSE2  		:= 0
Local aStruSE2	  	:= {}
//Query na SE5
Local nSE5  		:= 0
Local aStruSE5	  	:= {}
Local cS10925		:= ""
Local nL10925		:= 0
Local nL10925SE5	:= 0
Local cS10925SE5	:= ""
Local cSIrrfSE5		:= ""
Local cSIssSE5		:= ""
Local nValorLiq		:= 0
Local nValorBx		:= 0
Local nTotForn		:= 0
Local nIss			:= 0
Local nIrrf			:= 0
Local cSIrrf		:= ""
Local cSIss			:= ""
Local nTotSaldo		:= 0
Local cChaveSA2		:= ""
Local lImpress		:= .F.
Local lIRPFBaixa 	:= .F.
Local nRec	:= 0
Local nInc			:= 0
Local nReg			:= 0

/*
GESTAO - inicio */
Local lGestao		:= Iif( lFWCodFil, FWSizeFilial() > 2, .F. )	// Indica se usa Gestao Corporativa
Local aSelFil		:= {}
Local lTotEmp		:= .F.
Local cEmpAtual		:= ""
Local nRegEmp		:= 0
Local nLenSelFil	:= 0
Local nTamEmp		:= 0
Local nTotSaldo		:= nTotFil := nTotEmp := nTotGeral := 0
Local cTotFil 		:= cTotEmp := ""
Local aSM0			:= {}
Local nValRet 		:= 0
Local nX			:= 0
Local aFilProc		:= {}	// Filiais jah processadas

/* GESTAO - fim
*/

//******************************************
// Utilizados pelo ponto de entrada F355MFIL
//******************************************
Local lMovFil	:= .T. //Default: Imprime todas as filiais
Local lImpMFil 	:= .T.

//Define se ISS na Emissão ou na baixa
Local lCalcIssBx 	:= IIF(lIsIssBx, IsIssBx("P"), SuperGetMv("MV_MRETISS",.F.,"1") == "2" )

//Variavel indica se irá provisionar os impostos de INSS e ISS na inclusão da PA, deduzindo-os do valor de adiantamento.
Local lPrImPA 		:= !lPaBruto .And. (SuperGetMv("MV_PAPRIME",.T.,"2") == "1")

Private nRegSM0 := SM0->(Recno())
Private nAtuSM0 := SM0->(Recno())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                     ³
//³ mv_par01    // Fornecedor de                     		 ³
//³ mv_par02    // Fornecedor ate	                 		 ³
//³ mv_par03    // Loja de                           		 ³
//³ mv_par04    // Loja ate		                     		 ³
//³ mv_par05    // Considera Data (Documento/ Sistema)  	 ³
//³ mv_par06    // Data Ate 	                     		 ³
//³ mv_par07    // Data ate     	                		 ³
//³ mv_par08    // Considera Nome (Razão Social/ Reduzido)	 ³
//³ mv_par09    // Seleciona Filiais			    		 ³
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
MV_PAR09 := 2
Pergunte( "FIN355", .F. )

oFornecedores:Cell(STR0005):SetBlock({||(cAliasSE2)->A2_COD+(cAliasSE2)-> A2_LOJA}) //"COD"
oFornecedores:Cell(STR0041):SetBlock({|| GetLGPDValue(cAliasSE2,'A2_NREDUZ')}) //"NREDUZ"
oFornecedores:Cell(STR0040):SetBlock({|| GetLGPDValue(cAliasSE2,'A2_NOME')}) //"NOME"

oTitsForn:Cell(STR0021	):SetBlock({||cSIrrf}) //"SIRRF"
oTitsForn:Cell(STR0024	):SetBlock({||cSIss}) //"SISS"
oTitsForn:Cell(STR0018 	):SetBlock({||nL10925})  				//"Lei 10925"
oTitsForn:Cell(STR0019	):SetBlock({||cS10925}) //"S10925"
oTitsForn:Cell(STR0006 	):SetBlock	({|| (cAliasSE2)->E2_PREFIXO+'-'+ (cAliasSE2)->E2_NUM}  )
oTitsForn:Cell(STR0008 	):SetBlock({||nValorOrig})
oTitsForn:Cell(STR0014	):SetBlock({|| If(mv_par05==1, (cAliasSE2)->E2_EMISSAO,(cAliasSE2)->E2_EMIS1)}) //"Emissao"
oTitsForn:Cell(STR0027	):SetBlock({||nValorLiq})
oTitsForn:Cell(STR0028	):SetBlock({||nValorbx})
oTitsForn:Cell(STR0029	):SetBlock({||nSaldo})

oDetbx:Cell(STR0031	):SetBlock({||(cAliasSE5)->E5_DATA}) ////"Data da baixa"
oDetbx:Cell(STR0032	):SetBlock({||(cAliasSE5)->E5_MOTBX}) //"Motivo de baixa"
oDetbx:Cell(STR0033	):SetBlock({||nL10925SE5}) //"Lei 10925 SE5"
oDetbx:Cell(STR0042	):SetBlock({||cS10925SE5})//"Status Lei 10925 SE5"
oDetbx:Cell(STR0034	):SetBlock({||(cAliasSE5)->E5_VRETIRF})//"Irrf - SE5"
oDetbx:Cell(STR0043	):SetBlock({||cSIrrfSE5}) //"Status Irrf SE5"
oDetbx:Cell(STR0035	):SetBlock({||(cAliasSE5)->E5_VRETISS}) //"ISS - SE5"
oDetbx:Cell(STR0044	):SetBlock({||cSIssSE5}) //"Status Iss SE5"
oDetbx:Cell(STR0036	):SetBlock({||(cAliasSE5)->E5_VALOR}) //"VALOR DE BAIXA"

oTotaisForn:SetLineStyle(.T.)
oTotaisForn:Cell(STR0010):SetBlock({||nTotSaldo }) //Saldo fornecedor
oTotaisForn:Cell(STR0027):SetAlign("RIGHT")
oTotaisForn:Cell(STR0010):SetPicture(Tm(nTotSaldo,oTitsForn:Cell(STR0029):nSize,2)) //"Valor original"
oReport:SetPageFooter(4,{|| If(!oTitsForn:Printing(),F355Legenda(oReport),"")})

oTotaisFilial:Cell("TXTTOTAL"):SetBlock({|| cTotFil })	//"Total filial"
oTotaisFilial:Cell("SLDFIL"):SetBlock({|| nTotFil }) 	//"SALDO FILIAL: "


oTotaisEmp:Cell("TXTTOTAL"):SetBlock({|| cTotEmp })		//"Total empresa"
oTotaisEmp:Cell("SLDEMP"):SetBlock({|| nTotEmp })		//"SALDO EMPRESA: "

/*
GESTAO - inicio */
#IFDEF TOP

	  	
		If MV_PAR09 == 1
			If lGestao .And. FindFunction("FwSelectGC")
				aSelFil := FwSelectGC()
			Else
				aSelFil := AdmGetFil(.F.,.F.,"SE2")
			Endif
			SM0->(DbGoTo(nRegSM0))
		Endif
	
	If Empty(aSelFil)
		aSelFil := {cFilAnt}
	Endif		
	Asort(aSelFil)
	nLenSelFil := Len(aSelFil)
	lTotEmp := .F.
	nTamEmp := Len(FWSM0LayOut(,1))
	If nLenSelFil > 1
		nX := 1 
		While nX < nLenSelFil .And. !lTotEmp
			nX++
			lTotEmp := !(Substr(aSelFil[nX-1],1,nTamEmp) == Substr(aSelFil[nX],1,nTamEmp))
		Enddo
	Endif
#ELSE
	aSelFil := {}
#ENDIF

If lGestao
	aSM0 := FWLoadSM0()
Else
	aSM0 := AdmAbreSM0()
EndIf	

oReport:SetMeter(RecCount())  

If ExistBlock("F355MFIL")
	lMovFil := ExecBlock("F355MFIL",.F.,.F.)			              
Endif
	oReport:SetTitle(STR0004)
	oReport:SetMeter(RecCount())
	oReport:IncMeter()
#IFDEF TOP
	nInc := 0
	/* Deixo na aSM0 somente as filiais selecionas para impressao. */
	For nReg := Len(aSM0) To 1 Step(-1)
		If  Ascan(aSelFil,aSM0[nReg,SM0_CODFIL]) == 0
			Adel(aSM0,nReg)
			nInc++
		Endif
	Next
	If nInc > 0
		Asize(aSM0,Len(aSM0) - nInc)
	Endif
#ELSE
	aSM0 := {}
#ENDIF
For nInc := 1 To Len( aSM0 )
	If aSM0[nInc][1] == cEmpAnt .Or. !Empty(aSelFil)
		cFilAnt := aSM0[nInc][2]
		If AScan( aFilProc, xFilial("SE2") ) == 0 // Filial nao processada
					
			oTitsForn:Init()           
			oTotaisForn:Init()
			nReg := 0 //Zera a contagem de registros impressos.
			cChaveSA2 := "" // Limpa chave do ulimo fornecedor processado.
			
			cQuery := "SELECT "  
			cQuery += " SA2.A2_FILIAL, SA2.A2_COD, SA2.A2_LOJA, SA2.A2_NOME, SA2.A2_NREDUZ, A2_CALCIRF, "
			cQuery += "SE2.E2_FILIAL, SE2.E2_PREFIXO, SE2.E2_NUM, SE2.E2_PARCELA, E2_VENCREA,"
			cQuery += "SE2.E2_TIPO, SE2.E2_FORNECE, SE2.E2_LOJA, SE2.E2_VALOR, E2_MOEDA, E2_TXMOEDA, "
			cQuery += "SE2.E2_SALDO, SE2.E2_EMISSAO, SE2.E2_EMIS1,SE2.E2_VENCREA,"
			cQuery += "SE2.E2_PIS, SE2.E2_COFINS, SE2.E2_CSLL,SE2.E2_IRRF,E2_PRETPIS, E2_PRETIRF, "
			cQuery += "SE2.E2_VRETPIS, SE2.E2_VRETCOF, SE2.E2_VRETCSL,SE2.E2_VRETIRF,E2_VRETISS, "
			cQuery += "SE2.E2_INSS, SE2.E2_ISS, SE2.E2_PRINSS,SE2.E2_PRISS "
			cQuery += "FROM "+RetSqlName("SA2") + " SA2, "
			cQuery += RetSqlName("SE2") + " SE2  "   
			
			cQuery += "WHERE "        
		    If  !Empty(FwFilial("SA2"))
				cQuery += "SA2.A2_FILIAL = '"+xFilial("SA2")+"' AND "   
			Endif
			
			cQuery += "SE2.E2_FILIAL = '"+xFilial("SE2")+"' AND "    
			cQuery += If(mv_par05 == 1,"SE2.E2_EMISSAO","SE2.E2_EMIS1") + " between '" + DTOS(mv_par06)+ "' AND '" + DTOS(mv_par07) + "' AND E2_TIPO NOT IN "+FormatIn(MVABATIM,"|")+" AND "
			cQuery += "SE2.E2_FORNECE" + " between " +"'"+ mv_par01+"'"+ " AND " + "'"+ mv_par02 +"'"+ " AND "
			cQuery += "SE2.E2_LOJA" + " between " + "'"+ mv_par03 +"'"+ " AND " +"'"+ mv_par04 + "'"+" AND "	
			cQuery += "SA2.A2_COD = SE2.E2_FORNECE AND "	
			cQuery += "SA2.A2_LOJA = SE2.E2_LOJA AND "
			cQuery += "SE2.E2_TIPO NOT IN ('TX','ISS','INS', 'INA', 'TXA') AND "
			cQuery += "SE2.D_E_L_E_T_ = ' ' AND SA2.D_E_L_E_T_ = ' '"      
			cQuery += "ORDER BY "
			cQuery += "SA2.A2_COD, SA2.A2_LOJA "   			

			cQuery := ChangeQuery(cQuery)
					
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),(cAliasSE2),.T.,.T.)		
			
			aStruSE2:= SE2->(dbStruct())
			
			For nSE2 := 1 To Len(aStruSE2)
				If aStruSE2[nSE2][2] <> "C" .and.  FieldPos(aStruSE2[nSE2][1]) > 0
					TcSetField((cAliasSE2),aStruSE2[nSE2][1],aStruSE2[nSE2][2],aStruSE2[nSE2][3],aStruSE2[nSE2][4])
			
			EndIf
			Next nSE2	
			
			While !oReport:Cancel() .And.(cAliasSE2)->(!EOF())
				nValorbx:=0  	
				lIRPFBaixa := (cAliasSE2)->A2_CALCIRF == "2"
			    If cChaveSA2 <>(cAliasSE2)->A2_COD +(cAliasSE2)-> A2_LOJA
			          If cChaveSA2 == ""
				    	cChaveSA2:=(cAliasSE2)->A2_COD +(cAliasSE2)-> A2_LOJA
						nTotSaldo:= If((cAliasSe2)->E2_TIPO <> MVPAGANT,(cAliasSE2)-> E2_SALDO,((cAliasSE2)-> E2_SALDO)*(-1))
						nTotFil  += nTotSaldo
					  Else
						 oTotaisForn:Init()
						 oTotaisForn:PrintLine() 
			 		     oTotaisForn:Finish()  
			 		     oTitsForn:Finish()
			 		  	 cChaveSA2:=(cAliasSE2)->A2_COD +(cAliasSE2)-> A2_LOJA
					  	 nTotSaldo:= If ((cAliasSe2)->E2_TIPO <> MVPAGANT,(cAliasSE2)-> E2_SALDO,((cAliasSE2)-> E2_SALDO)*(-1))
					  	 nTotFil  += nTotSaldo  
					  	 oTitsForn:Init()//indica que trocou o fornecedor
					  EndIf					
						If mv_par08 == 1
					   		oFornecedores:Cell(STR0041):Disable()
				   		Else
				  			oFornecedores:Cell(STR0040):Disable()
				  		EndIf
						oFornecedores:Init()  
						oFornecedores:PrintLine()
						oFornecedores:Finish()     
					Else
						nTotSaldo+= If ((cAliasSe2)->E2_TIPO <> MVPAGANT,(cAliasSE2)-> E2_SALDO,((cAliasSE2)-> E2_SALDO)*(-1))
						nTotFil  += If ((cAliasSe2)->E2_TIPO <> MVPAGANT,(cAliasSE2)-> E2_SALDO,((cAliasSE2)-> E2_SALDO)*(-1))
				EndIf 
				
				nSaldo := If ((cAliasSe2)->E2_TIPO <> MVPAGANT,(cAliasSE2)-> E2_SALDO,((cAliasSE2)-> E2_SALDO)*(-1))
				
				If oReport:Cancel()
					Exit
				EndIf	
			
				nValorOrig:= (cAliasSE2)-> E2_VALOR  
				nValorLiq:=  (cAliasSE2)-> E2_SALDO    
				If (cAliasSE2)->E2_VALOR <> (cAliasSE2)->E2_SALDO .and. (cAliasSE2)->E2_SALDO >0
					nValorbx	:= (cAliasSE2)->E2_VALOR
				Endif 
				
				If cPaisLoc == "BRA"
					If lPCCBaixa .and. ((cAliasSE2)->E2_COFINS+(cAliasSE2)->E2_PIS+(cAliasSE2)->E2_CSLL)>0
						// Calcula valor de PA com PCC                        
							nL10925 := ((cAliasSE2)->E2_COFINS+(cAliasSE2)->E2_PIS+(cAliasSE2)->E2_CSLL)    
							If (cAliasSE2)->E2_SALDO>0 .and. (cAliasSE2)->E2_TIPO <> MVPAGANT
								cS10925:= "P"          
							Elseif (cAliasSE2)->E2_PRETPIS $ " |1|3|4"
								cS10925:= "R"
							Else
								cS10925:= "A"
							EndIf
							If (cAliasSE2)->E2_SALDO==(cAliasSE2)->E2_VALOR .and. (cAliasSE2)->E2_TIPO <> MVPAGANT  // indica que não houve baixa do titulo
						 		nValorLiq-= (cAliasSE2)->E2_COFINS+(cAliasSE2)->E2_PIS+(cAliasSE2)->E2_CSLL
						    Elseif cS10925== "P"       // Indica que houve baixa parcial
								nValorLiq-= ((cAliasSE2)->E2_COFINS+(cAliasSE2)->E2_PIS+(cAliasSE2)->E2_CSLL) -((cAliasSE2)->E2_VRETCOF+(cAliasSE2)->E2_VRETPIS+(cAliasSE2)->E2_VRETCSL)
						  	Endif  
					  		If (cAliasSE2)->E2_VALOR <> (cAliasSE2)->E2_SALDO .and. (cAliasSE2)->E2_SALDO >0 
							  	nValorbx-=nL10925
							Endif
					Else
							nL10925 := ((cAliasSE2)->E2_COFINS+(cAliasSE2)->E2_PIS+(cAliasSE2)->E2_CSLL)    
							If (cAliasSE2)->E2_PRETPIS=="2"
								cS10925:= "A"        
							Else
							
								cS10925:= "R"        
							Endif
							nValorOrig+=nL10925
					EndIf			
					
					If !lPrImPA
						oTitsForn:Cell(STR0025):Disable()
						oTitsForn:Cell(STR0026):Disable()
					EndIf     
						
					If lIRPFBaixa
						If (cAliasSE2)->E2_SALDO>0.and. (cAliasSE2)->E2_TIPO <> MVPAGANT
							cSIrrf:="P"
						ElseIf (cAliasSE2)->E2_PRETIRF $ " |1|3|4"
							cSIrrf:="R"	  
						Else
							cSIrrf:="A"	   
						Endif 
						If (cAliasSE2)->E2_SALDO==(cAliasSE2)->E2_VALOR .and. (cAliasSE2)->E2_TIPO <> MVPAGANT// indica que não houve baixa do titulo
					 		nIrrf := ((cAliasSE2)->E2_IRRF)
					    Elseif cSIrrf== "P"       // Indica que houve baixa parcial
							nIrrf := (cAliasSE2)->E2_IRRF-(cAliasSE2)->E2_VRETIRF
					  	Endif
					   nValorLiq-= If((cAliasSE2)->E2_TIPO <> MVPAGANT,nIrrf,0)
					   If (cAliasSE2)->E2_VALOR <> (cAliasSE2)->E2_SALDO .and. (cAliasSE2)->E2_SALDO >0
					   		nValorbx-= ((cAliasSE2)->E2_IRRF)
					    Endif
					Else
						cSIrrf:="R"
						nValorOrig+=(cAliasSE2)->E2_IRRF 
					Endif  
					If lCalcIssBx .and. (cAliasSE2)->E2_SALDO>0.and. (cAliasSE2)->E2_TIPO <> MVPAGANT
						cSIss:="P" 
						If (cAliasSE2)->E2_SALDO==(cAliasSE2)->E2_VALOR // indica que não houve baixa do titulo
					 		nIss := ((cAliasSE2)->E2_ISS)
					    Elseif (cAliasSE2)->E2_SALDO==(cAliasSE2)->E2_VALOR .and. (cAliasSE2)->E2_SALDO>0  //Indica que houve baixa parcial
					        nIss := (cAliasSE2)->E2_ISS-(cAliasSE2)->E2_VRETISS
					  	Endif
					   nValorLiq-= nIss        
						If (cAliasSE2)->E2_VALOR <> (cAliasSE2)->E2_SALDO .and. (cAliasSE2)->E2_SALDO >0
						   nValorbx-= nIss
						Endif
					Else
						cSIss:="R"	  
					Endif
					If !lCalcIssBx
						oTitsForn:Cell(STR0024):Disable()
						nValorOrig+=(cAliasSE2)->E2_ISS
					EndIf 			                    
					nValorOrig+=(cAliasSE2)->E2_INSS
					If (cAliasSE2)->E2_VALOR <> (cAliasSE2)->E2_SALDO .and. (cAliasSE2)->E2_SALDO >0
					   nValorbx-= nValorLiq
					Endif  
					If ((cAliasSE2)->E2_IRRF)==0
						cSIrrf:=""
					EndIf 
					If nL10925==0
						cS10925:= ""
					Endif
					If lCalcIssBx .and. nIss==0
						cSIss:=""
					EndIf
					
					If (cAliasSE2)->E2_VALOR <> (cAliasSE2)->E2_SALDO .OR. (cAliasSE2)->E2_SALDO == 0  //Indica que houve movimento de baixa
					
						cQuery := "SELECT "
						cQuery += "SE5.E5_FILIAL,SE5.E5_VALOR,SE5.E5_VRETPIS,SE5.E5_VRETCOF,SE5.E5_VRETCSL,SE5.E5_VRETIRF,SE5.E5_VRETISS,SE5.E5_PRETPIS,"
						cQuery += "SE5.E5_PRETCOF,SE5.E5_PRETCSL,SE5.E5_PRETIRF,SE5.E5_MOTBX,SE5.E5_CLIFOR,SE5.E5_LOJA,SE5.E5_PREFIXO, "
						cQuery += "SE5.E5_NUMERO,SE5.E5_PARCELA,SE5.E5_TIPO,SE5.E5_TIPODOC,SE5.E5_DATA,SE5.E5_SEQ, SE5.R_E_C_N_O_ "
						cQuery += "FROM "+ RetSqlName("SE5") + " SE5  "
						
						cQuery += "WHERE "  
						                                             
						cQuery += "SE5.E5_FILIAL = '"+xFilial("SE2")+"' AND "   
						cQuery += "SE5.E5_FILIAL = '"+xFilial("SE2")+"' AND "    
						cQuery += "SE5.E5_PREFIXO ='" + (cAliasSE2)->E2_PREFIXO +"' AND "
						cQuery += "SE5.E5_NUMERO = '" + (cAliasSE2)->E2_NUM +"' AND "
						cQuery += "SE5.E5_PARCELA ='" + (cAliasSE2)->E2_PARCELA +"' AND "
						cQuery += "SE5.E5_TIPO = '" + (cAliasSE2)->E2_TIPO +"' AND "
						cQuery += "SE5.E5_CLIFOR = '" + (cAliasSE2)->E2_FORNECE +"' AND "
						cQuery += "SE5.E5_LOJA = '" + (cAliasSE2)->E2_LOJA +"' AND "   
						cQuery += "SE5.E5_MOTBX NOT IN ('FAT','IRF','PCC','LIQ','STP') AND " 
						cQuery += "SE5.E5_TIPODOC <>'ES' AND SE5.E5_SITUACA <>'C' AND SE5.D_E_L_E_T_ = ' ' "    
										
						cQuery += "ORDER BY "
						cQuery += "SE5.E5_FILIAL, SE5.E5_TIPODOC, SE5.E5_PREFIXO, SE5.E5_NUMERO, SE5.E5_PARCELA, SE5.E5_TIPO, SE5.E5_DATA, SE5.E5_SEQ "
					
						cQuery := ChangeQuery(cQuery)
						
						dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),(cAliasSE5),.T.,.T.)
			
						aStruSE5:= SE5->(dbStruct())
			
						For nSE5 := 1 To Len(aStruSE5)
							If aStruSE5[nSE5][2] <> "C" .and.  FieldPos(aStruSE5[nSE5][1]) > 0
								TcSetField((cAliasSE5),aStruSE5[nSE5][1],aStruSE5[nSE5][2],aStruSE5[nSE5][3],aStruSE5[nSE5][4])
							EndIf
						Next nSE5
						oDetbx:Init()      
						While !oReport:Cancel() .And.(cAliasSE5)->(!EOF())
							cS10925SE5:= ""
							cSIrrfSE5:= ""
							cSIssSE5:= ""
							If TemBxCanc((cAliasSE5)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ),.F.)
								(cAliasSE5)->( dbskip())
				   				loop
			 				EndIf
			 				IF  (cAliasSE2)->E2_TIPO $ MVPAGANT .AND. (cAliasSE5)->E5_MOTBX == "NOR"
								(cAliasSE5)->(dbSkip())           
								loop
							Endif
			                If (cAliasSE2)->E2_SALDO == 0   
			           		   	If (cAliasSE5)-> E5_MOTBX $ "CMP|DEV|DAC"
			                  		nValorbx+=(cAliasSE5)->E5_VALOR   
			                 	Elseif (cAliasSE5)->E5_TIPODOC $ "BL|CH|VL"
			                 		nValorbx+=(cAliasSE5)->E5_VALOR
			                 	Else
				                 	(cAliasSE5)->( dbskip())
					   				loop    
					   			Endif 
			
					   			(cAliasSE5)->(dbSkip())
			                Else 
			
							    If lPCCBaixa .and. (cAliasSE5)->E5_PRETPIS $ " |1|3|4|7"
							    	nL10925SE5:= (cAliasSE5)->E5_VRETPIS + (cAliasSE5)->E5_VRETCSL +(cAliasSE5)->E5_VRETCOF
									cS10925SE5:= "R"
							  	Else
								  	oDetbx:Cell(STR0033):Disable()
								EndIf
								If !lIRPFBaixa
									oDetbx:Cell(STR0034):Disable()
								ElseIF(cAliasSE5)->E5_PRETIRF $ " |1|3|4|7"
									cSIrrfSE5:= "R"
								Elseif (cAliasSE5)->E5_PRETIRF=="2"
									cSIrrfSE5:= "P"
								Endif
								If !lCalcIssBx
									oDetbx:Cell(STR0035):Disable()
								Else
									cSIssSE5:= "R"
								Endif  
			                
				                If !lImpress
									oTitsForn:Printline()
									lImpress:= .T.
								Endif
								oDetbx:SetHeaderSection(.T.)
								oDetbx:PrintLine()
								(cAliasSE5)->(dbSkip())								
							Endif												
						Enddo  
						If (cAliasSE2)->E2_SALDO==0
							oTitsForn:PrintLine()   
						Endif
						(cAliasSE5)->(dbCloseArea())
					Else 
				    	oTitsForn:PrintLine()
					Endif
					oDetbx:Finish()
					(cAliasSE2)->(dbSkip())     		
					lImpress:= .F.
					nReg++
					nRegEmp++
					
					If (cAliasSE2)->(EOF())
						oTotaisForn:Init()
						oTotaisForn:PrintLine()
						oTotaisForn:Finish()   
						oReport:SkipLine()
						nTotGeral += nTotFil
						nTotEmp	+= nTotFil
						nTotSaldo := 0
					EndIf		
				Endif					
			EndDo
			
			/*	GESTAO - inicio */
			
			//Imprime ou não as filiais sem movimento - P.E. F350MFIL
			If !lMovFil
				lImpMFil := Iif(nReg != 0, .T., .F.)
			Endif
			
			// IMPRESSÃO TOTAL FILIAL
			
				If mv_par09 == 1 .and. Len( aSM0 ) > 1 .And. lImpMFil
				cTotFil := STR0045 + AllTrim( aSM0[nInc][2] ) + "-" + AllTrim(aSM0[nInc][7]) // SALDO FILIAL: NOME FIL
				oTotaisFilial:Init()
				oReport:ThinLine()
				oTotaisFilial:PrintLine()
				oTotaisFilial:Finish()
				oReport:SkipLine(2)
				nTotFil := 0
				Endif
		
			// IMPRESSÃO TOTAL EMPRESA
			If lTotEmp
				If nInc <= Len(aSM0)
					If (nInc == Len(aSM0)) .Or. !(Substr(aSM0[nInc,SM0_CODFIL],1,nTamEmp) == Substr(aSM0[nInc+1,SM0_CODFIL],1,nTamEmp))
						If lImpMFil .Or. nRegEmp <> 0
							cTotEmp := STR0046 + " - " + Substr(aSM0[nInc,SM0_CODFIL],1,nTamEmp) // SALDO EMPRESA: NOME EMP
							oTotaisEmp:Init() 			
							oReport:ThinLine()
							oTotaisEmp:PrintLine()
							oTotaisEmp:Finish()
							oReport:SkipLine(2)
							nTotEmp := 0
							nRegEmp := 0
							cTotEmp := ""
						EndIf	
					Endif
				Endif
			Endif
			/* GESTAO - fim */
			
			AAdd( aFilProc, xFilial("SE2") )
			
			oTitsForn:Finish() // Indica que mudou de Fornecedor(FILIAL)       
			oTotaisForn:Finish()
			
		EndIf
	EndIf

If Select(cAliasSE2) > 0
	(cAliasSE2)->(dbCloseArea())
EndIf
Next nInc

/* TOTAL GERAL */
oTotalGeral:Cell("TXTTOTAL"):SetBlock({|| STR0047 })	//""SALDO GERAL -->"" STR0047
oTotalGeral:Cell("SLDGERAL"):SetBlock({|| nTotGeral })		//"SALDO GERAL: "

oTotalGeral:Init()      			
oReport:ThinLine()
oTotalGeral:PrintLine()
oTotalGeral:Finish()	
/*     FIM     */

oTotaisForn:Finish()
oTitsForn:Finish()
					

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FINR355	ºAutor  ³Pâmela Bernardo     º Data ³  09/05/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Impressao da legenda de retencao de impostos.		      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Finr355                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


Static Function F355Legenda(oReport)

Local lContrRet	:= .T.

If lContrRet
	oReport:PrintText(STR0037)		// A = Os valores de Pis,Cofins e Csll deste titulo foram retidos em outro titulo.
	oReport:PrintText(STR0038)		// B = Os valores de Pis,Cofins e Csll deste titulo se referem a uma previsao, ainda nao foram retidos.
	oReport:PrintText(STR0039)		// C = Os registros referentes a fatura não são incluidos nos totalizadores.
Endif

Return
