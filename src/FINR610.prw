/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR610.CH"
#INCLUDE "PROTHEUS.CH"

#DEFINE CRLF CHR(13)+CHR(10)

#DEFINE PREFIXO		1
#DEFINE TITULO		2
#DEFINE PARCELA		3                   
#DEFINE COD_CLI		4
#DEFINE LOJA		5
#DEFINE NOME_CLI	6                 
#DEFINE DT_EMIS		7
#DEFINE DT_VENC		8
#DEFINE VAL_TIT		9
#DEFINE COM_EMISS	10
#DEFINE COM_BAIXA	11
#DEFINE VAL_BASE	12
#DEFINE PERC		13
#DEFINE VAL_COMIS	14
#DEFINE PARC		15
#DEFINE CODFIL		16
#DEFINE VEN_COD 	17
#DEFINE VEN_NOME 	18

Static _oFr610TRB
Static __oStTemFi := NIL

// 17/08/2009 - Compilacao para o campo filial de 4 posicoes
// 18/08/2009 - Compilacao para o campo filial de 4 posicoes

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR610	³ Autor ³ Daniel Tadashi Batori ³ Data ³ 29.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Previs„o de Comiss”es								      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR610(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR610()
Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return

/*/{Protheus.doc} ReportDef
	Definicao do layout do Relatorio
	@type function
	@author Daniel Batori
	@since 28/08/2006
/*/
Static Function ReportDef()
	Local oReport   as Object
	Local oSection1 as Object
	Local cPictVal  as Character
	Local nTamCli   as Numeric

	nTamCli	:= TamSx3("A1_NOME")[1]

	oReport := TReport():New("FINR610",STR0003,"FIN610", {|oReport| ReportPrint(oReport)},STR0001+STR0002)

	pergunte("FIN610",.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Vari veis utilizadas para parametros                         ³
	//³ mv_par01         // Do Vendedor                              ³
	//³ mv_par02         // At‚ o Vendedor                           ³
	//³ mv_par03         // Vencto de                                ³
	//³ mv_par04         // Vencto At‚                               ³
	//³ mv_par05         // Qual Moeda                               ³
	//³ mv_par06         // Da emiss„o                               ³
	//³ mv_par07         // At‚ a emiss„o                            ³
	//³ mv_par08         // Comiss„o Zero                            ³
	//³ mv_par09         // Considera P.Venda                        ³
	//³ mv_par10         // Abate IR Comiss                          ³
	//³ mv_par11         // Outras Moedas                            ³
	//³ mv_par12         // Salta Pagina por Vendedor                ³
	//³ mv_par13         // Nome cliente							 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cPictVal	:= PesqPict("SE1","E1_VLCRUZ")

	oSection1 := TRSection():New(oReport,STR0024,{},) //"Registros"
	TRCell():New(oSection1,"E1_FILORIG","SE1",STR0048,,,.F.,) //"FILIAL"
	TRCell():New(oSection1,"E1_PREFIXO","SE1",STR0025,,,.F.,) //"PRF"
	TRCell():New(oSection1,"E1_NUM","SE1",	STR0026+CRLF+STR0027,,,.F.,)//"TITULO" "PEDIDO"
	TRCell():New(oSection1,"E1_PARCELA","SE1",STR0028,,3,.F.,)//"PRC"
	TRCell():New(oSection1,"E1_CLIENTE"	,"SE1",STR0029+CRLF+STR0030,,,.F.,)//"CODIGO" "CLIENTE"
	TRCell():New(oSection1,"E1_LOJA","SE1",STR0031,,,.F.,) //"LJ"
	TRCell():New(oSection1,"NOME","SA1",STR0032,,nTamCli,.F.,) //"NOME"
	TRCell():New(oSection1,"E1_EMISSAO","SE1",STR0033+CRLF+STR0034,,,.F.,) //"DATA DE""EMISSAO"
	TRCell():New(oSection1,"E1_VENCREA","SE1",STR0035+CRLF+STR0036,,,.F.,) //"DATA""VENCTO"
	TRCell():New(oSection1,"E1_VLCRUZ","SE1",STR0037+CRLF+STR0038,,,.F.,) //"VALOR""TITULO"
	TRCell():New(oSection1,"VL_EMISS",,STR0039+CRLF+STR0040,cPictVal,13,.F.,) //"COMISSAO""P/EMISSAO"
	TRCell():New(oSection1,"VL_BAIXA",,STR0039+CRLF+STR0041,cPictVal,13,.F.,) //"COMISSAO""P/BAIXA"
	TRCell():New(oSection1,"VL_BASE",,STR0042+CRLF+STR0041,cPictVal,13,.F.,) //"VALOR BASE""P/BAIXA"
	TRCell():New(oSection1,"PERC_COMI",,STR0043+CRLF+STR0044, PesqPict("SE3","E3_PORC") ,5,.F.,)//"%COMIS""TOTAL"
	TRCell():New(oSection1,"VL_COMIS",,STR0045+CRLF+STR0046,cPictVal,13,.F.,) //"VALOR TOTAL""DA COMISSAO"
	TRCell():New(oSection1,"PARC",,STR0047,,1,.F.,) //"P/T"
	TRCell():New(oSection1,"VEN_COD",,STR0029,,,.F.,) //"CODIGO"
	TRCell():New(oSection1,"VEN_NOME",,STR0032,,,.F.,) //"NOME"

	oSection1:Cell("E1_VLCRUZ"):SetHeaderAlign("RIGHT")
	oSection1:Cell("VL_EMISS"):SetHeaderAlign("RIGHT")
	oSection1:Cell("VL_BAIXA"):SetHeaderAlign("RIGHT")
	oSection1:Cell("VL_BASE"):SetHeaderAlign("RIGHT")
	oSection1:Cell("PERC_COMI"):SetHeaderAlign("RIGHT")
	oSection1:Cell("VL_COMIS"):SetHeaderAlign("RIGHT")

	oSection1:SetHeaderSection(.F.)

	oReport:SetLandScape()

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Daniel Batori          ³ Data ³22.08.06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrint(oReport)

Local oSection1 := oReport:Section(1)
Local aDados[18]

Local cTitulo

LOCAL aCampos :={}
LOCAL cVendAnt:=Space(6)
LOCAL nComissao:=0.00
LOCAL nValTit :=0.00
LOCAL nComEnt :=0.00
LOCAL nComVen :=0.00
LOCAL nValBas :=0.00
LOCAL nPorc   :=0.00
LOCAL nVendComis :=0.00
LOCAL nTotTit :=0.00
LOCAL nTotEnt :=0.00
LOCAL nTotVen :=0.00
LOCAL nTotBas :=0.00
LOCAL nTotComis :=0.00
LOCAL lFirst := .T.
LOCAL aParcelas := {}	// Array das comissoes (geral)
LOCAL aParcItem := {}	// Array das comissoes (item)
LOCAL nVendSC5 := 0		// Codigo do vendedor no pedido
LOCAL nComiSC5 := 0		// Percentual Comissao no pedido
LOCAL nComiSC6 := 0		// Percentual comissao no item do pedido
LOCAL nPerComE := 0		// Percentual comissao na emissao vendedor
LOCAL nPerComB	:= 0		// Percentual comissao na Baixa vendedor
LOCAL nRegSC6	:= 0		// Registro do item de pedido
LOCAL nQtdItem := 0		// Quantidade de produtos nao entregues
LOCAL nPercItem:= 0		// Percentual a ser usado (pedido ou item)
LOCAL nVlTotPed:= 0		// Valor total do pedido nao entregue
LOCAL nIrEnt	:= 0		// Ir na Emissao
LOCAL nIrVen	:= 0		// Ir na Baixa
LOCAL nVendIr	:= 0		// total de Ir do vendedor
LOCAL nTotIrE	:= 0		// Total geral de IR na emissao
LOCAL nTotIrB	:= 0		// Total geral de IR na Baixa
LOCAL nTotIrVen:= 0		// Total geral de IR do relatorio
LOCAL nTotPorc := 0		// Percentual medio de comissoes do relatorio
LOCAL nTotCount:= 0
LOCAL nCount	:= 0
Local aLiquid	:= {}
Local aSeqCont	:= {} //Controle de calculo de comissoes (Sequencia no SE5)
LOCAL aTam		:= {}
LOCAL nValMinRet	:= SuperGetMv( "MV_VLRETIR" ,,0) // Valor minimo para retencao do IR
Local nMoedaBco :=1, dDataConv
Local cTipo
Local cParcela
Local cPrefixo
Local cNum
Local cTipoFat
Local nBaseCom
Local nValorFat
Local nCond
Local nIrrItem := 0
Local nInsItem := 0
Local nPisItem := 0
Local nCofItem := 0
Local nCslItem := 0
Local nIcmItem := 0
Local nIssItem := 0
Local nSolItem := 0
Local nRecOri	:= 0
Local nItem		:= 0
Local nTotImp	:= 0
Local nJurLiq	:= 0
Local nPerJur	:= 0
Local nDescLiq	:= 0
Local nPerDesc	:= 0
Local nVlrLiq	:= 0
Local lImpSub 	:= .T.		// Imprime subtotal
Local lBxReneg	:=	.F.
Local lReneg	:=	.F.

Local nX
Local aBaseAux 		:= {}, nBaseAux, nPerAux
Local cNumLiq		:=	""

Local lJuros   		:= .F. 
Local lDescont 		:= .F. 

Local cA1Vend		:=	""
Local aSelFil		:= {}
Local cFilBack		:= cFilAnt
Local lTroca		:= .F.
Local lGetParAut	:= FindFunction("GetParAuto")

Local lcomisir		:= SuperGetMv("MV_COMISIR")    == "N"
Local lComiins		:= GetNewPar("MV_COMIINS","N") == "N"
Local lComipis		:= GetNewPar("MV_COMIPIS","N") == "N"
Local lComicof		:= GetNewPar("MV_COMICOF","N") == "N"
Local lComicsl		:= GetNewPar("MV_COMICSL","N") == "N"

Local aAreaSE1		:= {}
Local lExistSE3		:= .F.
Local cChvSE1		:= ""
Local cChvSE3I2		:= ""

Private nDecs   := MsDecimais(mv_par05)
Private nIndexSE5
Private aVendedor

If oReport:nExcelPrintType <> 3
	oSection1:Cell("VEN_COD"):Disable()
	oSection1:Cell("VEN_NOME"):Disable()
Endif

If MV_PAR16 == 1	// Considera Juros?
	lJuros := .T.
Endif

If MV_PAR17 == 1	// Considera Desconto?
	lDescont := .T.
Endif

If mv_par15 == 1 .And. !IsBlind()
	aSelFil := AdmGetFil(.F.,.F.,"SE5")
ElseIf lGetParAut
	aRetAuto	:= GetParAuto("FINR610TestCase")
	aSelFil:= Iif(ValType(aRetAuto) == "A", aRetAuto, aSelFil)
	nRegSM0 := SM0->(Recno())
	SM0->(DbGoTo(nRegSM0))
Endif

If Empty(aSelFil)
	Aadd(aSelFil,cFilAnt)
EndIf

dbSelectArea("SE5")
nIndexSE5 := RetIndex("SE5")
dbSetOrder(nIndexSE5+1)
dbGoTop()

oSection1:Cell("E1_PREFIXO"):SetBlock( { || aDados[PREFIXO] })
oSection1:Cell("E1_NUM"):SetBlock( { || aDados[TITULO] })
oSection1:Cell("E1_PARCELA"):SetBlock( { || aDados[PARCELA] })
oSection1:Cell("E1_CLIENTE"):SetBlock( { || aDados[COD_CLI] })
oSection1:Cell("E1_LOJA"):SetBlock( { || aDados[LOJA] })
oSection1:Cell("NOME"):SetBlock( { || aDados[NOME_CLI] })
oSection1:Cell("E1_EMISSAO"):SetBlock( { || aDados[DT_EMIS] })
oSection1:Cell("E1_VENCREA"):SetBlock( { || aDados[DT_VENC] })
oSection1:Cell("E1_VLCRUZ"):SetBlock( { || aDados[VAL_TIT] })
oSection1:Cell("VL_EMISS"):SetBlock( { || aDados[COM_EMISS] })
oSection1:Cell("VL_BAIXA"):SetBlock( { || aDados[COM_BAIXA] })
oSection1:Cell("VL_BASE"):SetBlock( { || aDados[VAL_BASE] })
oSection1:Cell("PERC_COMI"):SetBlock( { || aDados[PERC] })
oSection1:Cell("VL_COMIS"):SetBlock( { || aDados[VAL_COMIS] })
oSection1:Cell("PARC"):SetBlock( { || aDados[PARC] })
oSection1:Cell("E1_FILORIG"):SetBlock( { || aDados[CODFIL] })
If oReport:nDevice == 4 .And. oReport:nExcelPrintType == 3
	oSection1:Cell("VEN_COD"):SetBlock( { || aDados[VEN_COD] })
	oSection1:Cell("VEN_NOME"):SetBlock( { || aDados[VEN_NOME] })
Endif
oReport:OnPageBreak({ ||	oSection1:SetHeaderSection(.T.), ;
									aDados[TITULO] := " " , ;
									oSection1:SetHeaderSection(.T.) } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define array para arquivo de trabalho                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam:=TamSX3("E1_FILORIG")
AADD(aCampos,{ "FILIAL" , "C", aTam[1], aTam[2] } )

aTam := TamSX3("E1_VEND1")
AADD(aCampos, { "CODIGO" , "C", aTam[1], aTam[2] } )

AADD(aCampos, { "CHAVE"  , 	"C", 10, 0 } )
AADD(aCampos, { "VENDSUF" ,	"C",  1, 0 } )
AADD(aCampos, { "PVEND"  , 	"C", 01, 0 } )
AADD(aCampos, { "CHVFAT" , 	"N", 10, 0 } )
AADD(aCampos, { "RECPRINC",	"N", 10, 0 } )
AADD(aCampos, { "TABELA", 	"C", 03, 0 } )

aTam := TamSX3("E1_CLIENTE")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria arquivo de Trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If(_oFr610TRB <> NIL)
	
	_oFr610TRB:Delete()
	_oFr610TRB := NIL

EndIf

//Criando a tabela temporaria
_oFr610TRB := FwTemporaryTable():New("TRB")
//Setando as colunas
_oFr610TRB:SetFields(aCampos)
//Criando o indicie 
_oFr610TRB:AddIndex("1",{"CODIGO","FILIAL","CHAVE","TABELA"})
//Criando a Tabela Temporaria
_oFr610TRB:Create()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Defini‡„o dos cabe‡alhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo := oReport:Title() + STR0022 + GetMV("MV_MOEDA"+Str(mv_par05,1))
oReport:SetTitle(cTitulo)

dbSelectarea("TRB")
dbSetOrder(1)
dbGoTop()

dbSelectarea("SE1")
dbsetOrder(7)

oReport:SetMeter(SE1->(Reccount()))

If MV_PAR14 == 1
	U_Fr610ProcP(@oReport, ,aSelFil)
Else
	U_Fr610ProcF(@oReport, ,aSelFil)
Endif

dbSelectarea("TRB")
dbGotop()

oReport:SetMeter(TRB->(Reccount()))

oSection1:Init()
aFill(aDados,nil)

While TRB->(!Eof())

	lFirst   := .T.
	cVendAnt := CODIGO
	nCount	 := 0
	
		While TRB->(!Eof()) .and. cVendAnt == CODIGO
					// Muda para a filial do título que irá tratar
					cFilAnt	:= TRB->FILIAL
					
					oReport:IncMeter()
			
					nComissao 	:= 0
					nJurLiq		:= 0
					nPerJur		:= 0
					nDescLiq	:= 0
					nPerDesc	:= 0
					nVlrLiq		:= 0
					lImpSub 	:= .T.
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Verifica se a previsao sera calculada por titulo ja gerado   ³
					//³ ou pedido de vendas.                                         ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If TRB->PVEND == "N"
						dbSelectArea("SE1")
						dbSetOrder(1)
						If TRB->CHVFAT > 0 .And. TRB->CHVFAT <> TRB->RECPRINC
							dbGOTO(TRB->CHVFAT)
						Else
							dbGoTo(Val(TRB->CHAVE))
							lTroca	:= .T.
						Endif
								
						// Títulos renegociados LIQUIDAÇÃO
						If MV_PAR14 == 2 .And. !Empty(SE1->E1_NUMLIQ) .And. ( !lJuros .Or. !lDescont )
							
							If cNumLiq != SE1->E1_NUMLIQ
								aLiquid 	:=	{}
								aSeqCont	:=	{}
								Fa440LiqSe1(SE1->E1_NUMLIQ,@aLiquid,,@aSeqCont)
								cNumLiq	:= SE1->E1_NUMLIQ
							EndIf
							
							aAreaSE1 := GetArea()
							For nX := 1 To Len(aLiquid)
								SE1->(DbGoTo(aLiquid[nX]))
								nJurLiq += F440JurLiq(SE1->(Recno()))
								nDescLiq += F440DesLiq(SE1->(Recno()))
								nVlrLiq  += SE1->E1_VLCRUZ
							Next nX
							RestArea(aAreaSE1)
							
							nVlrLiq := nVlrLiq + nJurLiq - nDescLiq
							nPerJur	:= IF( !lJuros, ((nJurLiq*1000)/nVlrLiq)/1000, 0)
							nPerDesc := IF( !lDescont, ((nDescLiq*1000)/nVlrLiq)/1000, 0)
							
						EndIf
			
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Calculo Bases, valores e percentuais de comissao.            ³
						//³ Constituicao de aBases{} retornada por FA440COMIS()          ³
						//³ Coluna 01    Vendedor        	       		                 ³
						//³ Coluna 02    Valor do Titulo    		                     ³
						//³ Coluna 03    Base Comissao Emissao			                 ³
						//³ Coluna 04    Base Comissao Baixa	                         ³
						//³ Coluna 05    Comissao Emissao								 ³
						//³ Coluna 06    Comissao Baixa                                  ³
						//³ Coluna 07    % Total da comissao                             ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						
						aBases  := Fa440Comis(SE1->(Recno()),.F.,.T.,,,TRB->RECPRINC)
						nBases 	:= aScan(aBases,{|x| x[1] == TRB->CODIGO })
						lBxReneg	:= .F.
						lReneg		:= .F.
						
						If mv_par14 == 1
							If !Empty(SE1->E1_NUMLIQ) .Or. !Empty(E1_FATURA)
								lReneg	:= .T.
							EndIf 
						ElseIf	mv_par14 == 2 
							cPrefixo := SE1->E1_PREFIXO
							cNum	 := SE1->E1_NUM
							aAreaSE1 := GetArea()
							If Empty(SE1->E1_NUMLIQ) 
								DbSelectArea("SE3")
								SE3->(DbSetOrder(2))
								SE3->(DbGoTop())
								If SE3->(DbSeek(xFilial("SE3") + TRB->CODIGO + cPrefixo + cNum ))
									While SE3->(!Eof()) .And. SE3->E3_VEND == TRB->CODIGO .And. SE3->E3_PREFIXO == cPrefixo .And. SE3->E3_NUM == cNum
										If Empty(SE3->E3_DATA)
											lExistSE3 := .T.
											Exit
										Endif
										SE3->(DbSkip())
									Enddo
								Endif
								If (!lExistSE3 .And. SE1->E1_SALDO >= 0 .And. SE1->E1_TIPOLIQ != "LIQ") .And. Empty(SE1->E1_NUMLIQ)
									lReneg := .F.
								Endif
							Else
								DbGoTo(TRB->RECPRINC)
								DbSelectArea("SE3")
								SE3->(DbSetOrder(2))
								SE3->(DbGoTop())
								If SE3->(DbSeek(xFilial("SE3") + TRB->CODIGO + cPrefixo + cNum ))
									While SE3->(!Eof()) .And. SE3->E3_VEND == TRB->CODIGO .And. SE3->E3_PREFIXO == SE1->E1_PREFIXO .And. SE3->E3_NUM == SE1->E1_NUM
										If Empty(SE3->E3_DATA)
											lExistSE3 := .T.
											Exit
										Endif
										SE3->(DbSkip())
									Enddo
								Endif
								If (!lExistSE3 .And. SE1->E1_SALDO = 0 .And. SE1->E1_TIPOLIQ != "LIQ") .And. Empty(SE1->E1_NUMLIQ)
									lReneg := .T.
								Endif
							Endif
							RestArea(aAreaSE1)
						EndIf
						If lTroca
							dbGoTo(Val(TRB->CHAVE))
						EndIf
					
						If	!lBxReneg .And. !lReneg
						
							SE3->( dbSetOrder(3) )
							
							If Len(aBases) > 0
								If 	TRB->CHVFAT > 0 .And. (aBases[nBases][7] == 0 .or. IsFatura()) .And.;	// Existe mais de um percentual de comissao (comissao por produto)
									!SE3->( MsSeek( xFilial("SE3") + aBases[nBases,1]+SE1->(E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA) ) ) // Nao eh comissao realizada
									
									// Recalcula bases pelo total da nota de saida, sem considerar parcelas geradas.
									cA1Vend	:= Posicione("SA1",1,xFilial("SA1") + SE1->(E1_CLIENTE + E1_LOJA),"A1_VEND")
									
									If Empty(cA1Vend) .Or. (!Empty(cA1Vend) .And. cA1Vend == cVendAnt) 
										If Empty(SE1->E1_NUMLIQ)  
											aBases := Fa440Comis(SE1->(Recno()),.F.,.T.,,.F./*Nao calcula por parcelas*/)
										Else
											aBases := Fa440Comis(TRB->RECPRINC,.F.,.T.,,.F./*Nao calcula por parcelas*/)
										Endif
									EndIf										
									nBases 	:= aScan(aBases,{|x| x[1] == TRB->CODIGO })					
									If nBases > 0  //se encontrou vendendor
										If aBases[nBases][7] == 0
											aBaseAux := Fa440Comis(TRB->RECPRINC,.F.,.T.,,.F./*Nao calcula por parcelas*/)
											nBaseAux := aScan(aBaseAux,{|x| x[1] == TRB->CODIGO })
											If nBaseAux > 0
												If aBases[nBases][5]+aBases[nBases][6] == 0
												   If ( aBaseAux[nBaseAux][3]+aBaseAux[nBaseAux][4] ) > 0
													   nPerAux := ( aBases[nBases][3]+aBases[nBases][4] ) / ( aBaseAux[nBaseAux][3]+aBaseAux[nBaseAux][4] )
												   Else
													   nPerAux := 1
												   EndIf
												   aBases[nBases][5] := aBaseAux[nBaseAux][5]*nPerAux
												   aBases[nBases][6] := aBaseAux[nBaseAux][6]*nPerAux
												   If ( aBases[nBases][3]+aBases[nBases][4] ) > 0
													   aBases[nBases][7] := ( aBases[nBases][5]+aBases[nBases][6] ) / ( aBases[nBases][3]+aBases[nBases][4] ) * 100
												   EndIf
												EndIf
											EndIf
										EndIf
									EndIf
								EndIf
							EndIf
				
							If TRB->CHVFAT > 0
								dbGoTo(Val(TRB->CHAVE))
							Endif
							If nBases = 0    
								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³ Caso vendedor n„o seja encontrado...           ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
								dbSelectArea("TRB")
								dbSkip()
								LOOP
							Endif
							cChaveSE3	:= aBases[Iif(nBases > 0, nbases,1),1]+SE1->(E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA)
							cTipo 	 	:= SE1->E1_TIPO
							cParcela	:= SE1->E1_PARCELA
							cChvSE1		:= SE1->(E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO)
				
							dbSelectArea("SE1")
							aAreaSE1 := GetArea()
							dbGoto(TRB->RECPRINC)
							nBaseCom  := SE1->&("E1_BASCOM"+ TRB->VENDSUF) // Utilizado para estornar a base de comissao do titulo
							nComissao := (SE1->&("E1_COMIS"+ TRB->VENDSUF)/100)*nBaseCom // Utilizado para estornar o valor da comissao do titulo
							RestArea(aAreaSE1)
				
							If (!Empty(SE1->E1_FATURA) .And. AllTrim(SE1->E1_FATURA) != "NOTFAT") .Or. !Empty(SE1->E1_NUMLIQ)  
								cTipoFat := SE1->E1_TIPOFAT
								// Localiza o titulo de fatura, pois no SE3 eh gerado o titulo de fatura
								// para verificar as comissoes que ja foram pagas.
								If Empty(SE1->E1_NUMLIQ)
									SE1->(MsSeek(xFilial("SE1")+E1_FATPREF+E1_FATURA)) // Localiza o titulo de fatura
								Else
									SE1->(DbSetOrder(1))
									SE1->(DbSeek(xFilial("SE1") + cChvSE1 ))
								Endif
								cPrefixo := SE1->E1_PREFIXO
								cNum	 := SE1->E1_NUM
								// Processar todas as parcelas da fatura gerada e verificar se a comissao
								// para a parcela nao foi paga.
								While xFilial("SE1") + SE1->(E1_PREFIXO+E1_NUM) == xFilial("SE1")+cPrefixo+cNum .And.;
										SE1->(!Eof())
									If SE1->E1_TIPO == cTipoFat .Or. !Empty(SE1->E1_NUMLIQ)
									
										aAreaSE1 := GetArea()
										dbGoto(TRB->RECPRINC)
										nValorFat := SE1->E1_VLCRUZ
										RestArea(aAreaSE1)
										
										//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
										//³ Verificar comissoes ja pagas                                 ³
										//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
										cChaveSE3 := aBases[nBases,1] + SE1->(E1_CLIENTE + E1_LOJA + E1_PREFIXO + E1_NUM + E1_PARCELA)
										cTipo 	  := SE1->E1_TIPO
										cParcela  := SE1->E1_PARCELA
										cChvSE3I2 := aBases[nBases,1] + SE1->(E1_PREFIXO + E1_NUM )
										U_FA610ComPg(@aBases,cChaveSE3,nBases,cTipo,cParcela,nValorFat,nBaseCom,nComissao, cChvSE3I2, SE1->E1_TIPOLIQ)
									Endif
									SE1->(DbSkip())
								End
								dbSelectArea("SE1")
								dbSetOrder(1)
								dbGOTO(Val(TRB->CHAVE))
							Else
								cChaveSE3   := aBases[nBases,1] + SE1->(E1_CLIENTE + E1_LOJA + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO)
								cChvSE3I2	:= aBases[nBases,1] + SE1->(E1_PREFIXO + E1_NUM )
								cTipo		:= SE1->E1_TIPO
								cParcela	:= SE1->E1_PARCELA
								nValorFat 	:= SE1->E1_VLCRUZ
								U_FA610ComPg(@aBases,cChaveSE3,nBases,cTipo,cParcela,nValorFat,nBaseCom,nComissao, cChvSE3I2, SE1->E1_TIPOLIQ)
							Endif
				
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Caso percentual de comissao seja retornado == a zero, devo   ³
							//³ calcular a media (Faturamento com comissao no item <> percen-³
							//³ tual do vendedor)                                            ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							If aBases[nBases,7] == 0
								aBases[nBases,7] := (((aBases[nBases,5]+aBases[nBases,6])*100)/aBases[nBases,2])
							Endif
							
							If Empty(SE1->E1_NUMLIQ) .Or. (!Empty(SE1->E1_NUMLIQ) .And. SE1->E1_SALDO > 0)
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Imprime o Vendedor caso possa imprimir Comiss„o Zero ou      ³
							//³ exista alguma comiss„o para o Vendedor                       ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
								If (mv_par08 == 1 .or. aBases[nBases,6] != 0 .Or. aBases[nBases,5] != 0) .Or. (!Empty(SE1->E1_NUMLIQ) .And. SE1->E1_SALDO > 0)
									If lFirst
										dbSelectArea("SA3")
										dbSeek(cFilial+TRB->CODIGO)
					
										oReport:PrintText( PadR(STR0009 + TRB->CODIGO,16) + STR0010 + GetLGPDValue('SA3','A3_NOME') ) //"CODIGO : ""NOME : "
										oReport:SkipLine()

										If oReport:nDevice == 4 .And. oReport:nExcelPrintType == 3
											aDados[VEN_COD]	:= TRB->CODIGO
											aDados[VEN_NOME]:= SA3->A3_NOME
										Endif
					
										dbSelectArea("TRB")
										lFirst := .F.
									Endif
									dbSelectArea("SE1")
									dbSetOrder(1)
									dbGOTO(Val(TRB->CHAVE))
									If cPaisLoc == "BRA"
									   nMoedaBco := 1
									   dDataConv := dDataBase
									Else
								   //	   nMoedaBco := SE1->E1_MOEDA
									   dDataConv := SE1->E1_EMISSAO
									EndIf
					
									aBases[nBases,2] := xMoeda(aBases[nBases,2],nMoedaBco,mv_par05,dDataConv,nDecs+1)
									aBases[nBases,4] := xMoeda(aBases[nBases,4],nMoedaBco,mv_par05,dDataConv,nDecs+1)
									aBases[nBases,5] := xMoeda(aBases[nBases,5],nMoedaBco,mv_par05,dDataConv,nDecs+1)
									aBases[nBases,6] := xMoeda(aBases[nBases,6],nMoedaBco,mv_par05,dDataConv,nDecs+1)
					
									aDados[PREFIXO]	:= E1_PREFIXO
									aDados[TITULO]	:= E1_NUM
									aDados[PARCELA]	:= E1_PARCELA
									aDados[COD_CLI]	:= E1_CLIENTE
									aDados[LOJA]	:= E1_LOJA
									aDados[CODFIL]	:= E1_FILORIG
									
									dbSelectArea("SA1")
									dbSeek(cFilial+SE1->E1_CLIENTE+SE1->E1_LOJA)
									aDados[NOME_CLI]	:= Iif(mv_par13 == 1,GetLGPDValue('SA1','A1_NREDUZ'),GetLGPDValue('SA1','A1_NOME')) + Iif(!Empty(SE1->E1_NUMLIQ),"  LIQ","" )
									dbSelectArea("SE1")
									
									For nX := 1 To Len(aBases[nBases])
										If Str(nX,1) $ "2|4|5|6"
											aBases[nBases,nX] -= NoRound(aBases[nBases,nX] * nPerJur,nDecs)
											aBases[nBases,nX] += NoRound(aBases[nBases,nX] * nPerDesc,nDecs)
										EndIf
									Next nX
									
									nComissao := xMoeda(aBases[nBases,5] + aBases[nBases,6],nMoedaBco,mv_par05,dDataConv,nDecs+1)
					
									aDados[DT_EMIS]		:= E1_EMISSAO
									aDados[DT_VENC]		:= E1_VENCREA
									aDados[VAL_TIT]		:= E1_VALOR 
									
									If Empty(SE1->E1_NUMLIQ) 
										aDados[COM_EMISS]	:= aBases[nBases,5]
										aDados[COM_BAIXA]	:= aBases[nBases,6]
										aDados[VAL_BASE]	:= aBases[nBases,4]
										aDados[PERC]		:= aBases[nBases,7]
										aDados[VAL_COMIS]	:= nComissao
										aDados[PARC]		:= "T"     // identificador de Titulo ou Pedido
									Else
										aDados[COM_EMISS]	:= 0
										aDados[COM_BAIXA]	:= 0
										aDados[VAL_BASE]	:= 0
										aDados[PERC]		:= 0
										aDados[VAL_COMIS]	:= 0
									Endif
									
									oSection1:PrintLine()
									aFill(aDados,nil)
									
									If Empty(SE1->E1_NUMLIQ)
									   	nValTit		+= E1_VALOR  
										nComEnt		+= aBases[nBases,5]
										nIrEnt		+= If(aBases[nBases,2] > nValMinRet,aBases[nBases,5] * (mv_par10/100),0)
										nComVen		+= aBases[nBases,6]
										nIrVen		+= If(aBases[nBases,2] > nValMinRet, aBases[nBases,6] * (mv_par10/100),0)
										nValBas		+= aBases[nBases,4]
										nPorc		+= aBases[nBases,7]
										nVendComis	+= nComissao
										nVendIr		+= If(aBases[nBases,2] > nValMinRet,(aBases[nBases,5]+aBases[nBases,6])* (mv_par10/100),0)
										nCount++
									Endif
								Else
									lImpSub := .F.
								EndIf
							Endif
						EndIf
						
					Else
						// calculo das comissoes p/ pedido venda
						dbSelectArea("SC5")
						dbSetOrder(1)
						DbGoto(Val(TRB->CHAVE))
						//Fecho os dados fiscais de um pedido antes de carregar um novo pedido
						MaFisEnd()
						//Inicializo a funcao fiscal
						MaFisIni(C5_CLIENTE,;// 1-Codigo Cliente/Fornecedor
									C5_LOJAENT,;		// 2-Loja do Cliente/Fornecedor
									IIf(C5_TIPO$'DB',"F","C"),;				// 3-C:Cliente , F:Fornecedor
									C5_TIPO,;				// 4-Tipo da NF
									C5_TIPOCLI,;		// 5-Tipo do Cliente/Fornecedor
									Nil,;
									Nil,;
									Nil,;
									Nil,;
									"MATA461")
			
						dbSelectArea("SC6")
						dbSetOrder(1)
						If dbSeek(xFilial("SC6")+SC5->C5_NUM)
							While !Eof() .and. SC6->C6_NUM == SC5->C5_NUM
								nRecOri := 0
								If !Empty(SC6->C6_NFORI) .And. !Empty(SC6->C6_ITEMORI)
									SD1->(dbSetOrder(1))
									If SD1->(MSSeek(xFilial("SD1")+SC6->C6_NFORI+SC6->C6_SERIORI+SC5->C5_CLIENTE+SC5->C5_LOJACLI+SC6->C6_PRODUTO+SC6->C6_ITEMORI))
										nRecOri := SD1->(Recno())
									Endif
								Endif
			
								MaFisAdd(C6_PRODUTO,;   	// 1-Codigo do Produto ( Obrigatorio )
									C6_TES,;	   	// 2-Codigo do TES ( Opcional )
									C6_QTDVEN,;  	// 3-Quantidade ( Obrigatorio )
									C6_PRCVEN,;		  	// 4-Preco Unitario ( Obrigatorio )
									a410Arred(C6_QTDVEN*C6_PRCVEN,"D2_DESCON")-C6_VALOR,; 	// 5-Valor do Desconto ( Opcional )
									"",;	   			// 6-Numero da NF Original ( Devolucao/Benef )
									"",;				// 7-Serie da NF Original ( Devolucao/Benef )
									nRecOri,;					// 8-RecNo da NF Original no arq SD1/SD2
									0,;					// 9-Valor do Frete do Item ( Opcional )
									0,;					// 10-Valor da Despesa do item ( Opcional )
									0,;					// 11-Valor do Seguro do item ( Opcional )
									0,;					// 12-Valor do Frete Autonomo ( Opcional )
									C6_VALOR ,;			// 13-Valor da Mercadoria ( Obrigatorio )
									0)					// 14-Valor da Embalagem ( Opiconal )
			
								SC6->(DBSkip())
							Enddo
						Endif
						nComissao	:= 0
						nVlTotPed	:= 0
						dbSelectArea("SC6")
						dbSetOrder(1)
						If dbSeek(xFilial("SC6")+SC5->C5_NUM)
							aParcelas	:= {}
							nVendSC5		:= SC5->(FieldPos("C5_VEND"+  TRB->VENDSUF))
							nComiSC5		:= SC5->(FieldPos("C5_COMIS"+ TRB->VENDSUF))
							nComiSC6		:= SC6->(FieldPos("C6_COMIS"+ TRB->VENDSUF))
							dbSelectArea("SA3")
							dbSeek(xFilial("SA3")+SC5->(FieldGet(nVendsc5)))
							nPerComE		:= (SA3->A3_ALEMISS/100)
							nPerComB		:= (SA3->A3_ALBAIXA/100)
							dbSelectArea("SC6")
							nRegSC6 := Recno()
							// valor de nao entregues total no pedido
							bAcao:= {|| nVlTotPed += IF(!Left(SC6->C6_BLQ,1) $ "RS", SC6->(C6_PRCVEN * (C6_QTDVEN - C6_QTDENT)), 0)}
							dbEval(bAcao,,{||!Eof() .and. SC6->C6_NUM == SC5->C5_NUM},,,.T.)
							dbGoto(nRegSC6)
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Constituicao de aParcelas{}				                     ³
							//³ Coluna 01    Data Vencto da Parcela			                 ³
							//³ Coluna 02    Valor da Parcela			                     ³
							//³ Coluna 03    Valor Comissao Emissao		                     ³
							//³ Coluna 04    Valor Comissao Baixa                            ³
							//³ Coluna 05    Base da Baixa                                   ³
							//³ Coluna 06    % Total da comissao                             ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							aParcelas := Condicao (nVlTotPed,SC5->C5_CONDPAG,,SC5->C5_EMISSAO)
							aEval(aParcelas,{|elem| aadd(elem,0),aadd(elem,0),aadd(elem,0),aadd(elem,0),aadd(elem,0)})
							dbSelectArea("SC6")
							nItem		:= 0
							nTotImp	:= 0
							While !Eof() .and. SC6->C6_NUM == SC5->C5_NUM
								nItem++
								If SC6->C6_QTDENT >= SC6->C6_QTDVEN .Or.;
									!Empty(SC6->C6_BLOQUEI)          .Or.;
									Left(SC6->C6_BLQ,1) $ "RS"
									dbskip()
									Loop
								Endif
								nQtdItem := SC6->(C6_QTDVEN - C6_QTDENT)  // Qtde nao entregue
								nBasItem := SC6->(C6_PRCVEN * nQtdItem) 	// Valor ref. nao entregue
			
								nIrrItem := 0
								nInsItem := 0
								nPisItem := 0
								nCofItem := 0
								nCslItem := 0
								nIcmItem := 0
								nIssItem := 0
								nSolItem := 0
			
								If lcomisir
									nIrrItem := MafisRet(nItem, "IT_VALIRR")
									nBasItem -= nIrrItem
								Endif
								If lComiins
									nInsItem := MafisRet(nItem, "IT_VALINS")
									nBasItem -= nInsItem
								EndIf
								If lComipis
									nPisItem := MafisRet(nItem, "IT_VALPIS")
									nBasItem -= nPisItem
								EndIf
								If lComicof
									nCofItem := MafisRet(nItem, "IT_VALCOF")
									nBasItem -= nCofItem
								EndIf
								If lComicsl
									nCslItem := MafisRet(nItem, "IT_VALCSL")
									nBasItem -= nCslItem
								EndIf
			
								// Calcula abatimento de ISS e ICMS da base da comissao do vendedor
								SF4->(dbSetOrder(1))
								SF4->(MsSeek(xFilial("SF4")+SC6->C6_TES))
								If !(SF4->F4_ISS == "S")
									If ( SA3->A3_ICM == "N" )
										nIcmItem := MaFisRet(nItem, "IT_VALICM")
										nBasItem -= nIcmItem
									EndIf
								Else
									If ( SA3->A3_ISS == "N" )
										nIssItem := MaFisRet(nItem, "IT_VALISS")
										nBasItem -= nIssItem
									EndIf
								EndIf
			
								nPercItem:= IIF(SC6->(FieldGet(nComiSC6))== 0,;
													 SC5->(FieldGet(nComiSC5)),	 ;	// Percentual no Pedido
													 SC6->(FieldGet(nComiSC6)))		// Percentual no Item
								aParcItem:= Condicao(nBasItem,SC5->C5_CONDPAG,,SC5->C5_EMISSAO)
			
								//valor dos impostos do pedido
								nTotImp := nIrrItem + nInsItem + nPisItem + nCofItem + nCslItem + nIcmItem + nIssItem + nSolItem
			
								dbSelectArea("SC6")
								For nCond := 1 to Len(aParcItem)
									aParcelas[nCond,3] += ((aParcItem[nCond,2] * (nPercItem/100)) * nPerComE)
									aParcelas[nCond,4] += ((aParcItem[nCond,2] * (nPercItem/100)) * nPerComB)
									aParcelas[nCond,5] += (aParcItem[nCond,2] * nPerComB)
									aParcelas[nCond,7] += (nTotImp / Len(aParcItem))
								Next
								dbskip()
							Enddo
							For nCond := 1 to	Len(aParcelas)
								aParcelas[nCond,6] += (((aParcelas[nCond,3]+aParcelas[nCond,4]) * 100) / (aParcelas[nCond,2] - aParcelas[nCond,7]))
								nComissao += (aParcelas[nCond,3]+aParcelas[nCond,4])
							Next
			
							// impressao das previsoes de comiss do ped venda
							If ( nComissao != 0 )
								If lFirst
									oReport:PrintText( PadR(STR0009 + TRB->CODIGO,16) + STR0010 + GetLGPDValue('SA3','A3_NOME') )
									oReport:SkipLine()
									dbSelectArea("TRB")
									lFirst := .F.
								Endif
			
								dbSelectArea("SC5")
								dbSetOrder(1)
								dbGOTO(Val(TRB->CHAVE))
			
							   nMoedaBco := SC5->C5_MOEDA
							   dDataConv := SC5->C5_EMISSAO
			
								For nCond := 1 to Len(aParcelas)
									If aParcelas[nCond,1] >= mv_par03 .and.  ;
										aParcelas[nCond,1] <= mv_par04
			
										aParcelas[nCond,2] := xMoeda(aParcelas[nCond,2],nMoedaBco,mv_par05,dDataConv,nDecs+1)
										aParcelas[nCond,3] := xMoeda(aParcelas[nCond,3],nMoedaBco,mv_par05,dDataConv,nDecs+1)
										aParcelas[nCond,4] := xMoeda(aParcelas[nCond,4],nMoedaBco,mv_par05,dDataConv,nDecs+1)
										aParcelas[nCond,5] := xMoeda(aParcelas[nCond,5],nMoedaBco,mv_par05,dDataConv,nDecs+1)
			
										aDados[TITULO]		:= C5_NUM
										aDados[PARCELA]	:= Str(nCond,3)
										aDados[COD_CLI]	:= C5_CLIENTE
										aDados[LOJA]		:= C5_LOJACLI
			
										dbSelectArea("SA1")
										dbSeek(cFilial+SC5->C5_CLIENTE+SC5->C5_LOJACLI)
										aDados[NOME_CLI]	:= IF(mv_par13 == 1,GetLGPDValue('SA1','A1_NREDUZ'),GetLGPDValue('SA1','A1_NOME'))
										dbSelectArea("SC5")
			
										aDados[DT_EMIS]	:= C5_EMISSAO
										aDados[DT_VENC]	:= aParcelas[nCond,1]   //Vencto
										aDados[VAL_TIT]	:= aParcelas[nCond,2]
										aDados[COM_EMISS]	:= aParcelas[nCond,3]
										aDados[COM_BAIXA]	:= aParcelas[nCond,4]
										aDados[VAL_BASE]	:= aParcelas[nCond,5]
										aDados[PERC]		:= aParcelas[nCond,6]
										aDados[VAL_COMIS]	:= aParcelas[nCond,3]+aParcelas[nCond,4] //Total Comissao (Emissao+Baixa)
										aDados[PARC]		:= "P"     // identificador de Titulo ou Pedido
			
										oSection1:PrintLine()
										aFill(aDados,nil)
			
										nValTit		+= aParcelas[nCond,2]
										nComEnt		+= aParcelas[nCond,3]
										nIrEnt		+= If(aParcelas[nCond,2] > nValMinRet, aParcelas[nCond,3] * (mv_par10/100),0)
										nComVen		+= aParcelas[nCond,4]
										nIrVen		+= If(aParcelas[nCond,2] > nValMinRet, aParcelas[nCond,4] * (mv_par10/100),0)
										nValBas		+= aParcelas[nCond,5]
										nPorc			+= aParcelas[nCond,6]
										nVendComis	+= aParcelas[nCond,3]+aParcelas[nCond,4]
										nVendIr		+= If(aParcelas[nCond,2] > nValMinRet, aParcelas[nCond,3]+aParcelas[nCond,4] * (mv_par10/100),0)
										nCount++
									Endif
								Next
							Endif
						Endif
					EndIf
			dbSelectArea("TRB")
			dbSkip()
		End
		nTotTit  +=nValTit
		nTotEnt  +=nComEnt
		nTotIrE  +=nIrEnt
		nTotVen  +=nComVen
		nTotIrB  +=nIrVen
		nTotBas  +=nValBas
		nTotComis+=nVendComis
		nTotIrVen+=nVendIr
		nTotPorc += nPorc
		nTotCount+= nCount
	
		If ((nVendComis <> 0 .or. nTotCount > 0) .or. mv_par08 == 1 ) .And. lImpSub
			SubR4(nValTit,nComEnt,nComVen,nValBas,nPorc,nVendComis,nIrEnt,nIrVen,nVendIr,nCount,oReport,aDados)
		Endif

		If oReport:nDevice == 4 .And. oReport:nExcelPrintType == 3	
			aDados[VEN_COD]	:= TRB->CODIGO
			aDados[VEN_NOME]:= SA3->A3_NOME
		Endif
	
		nValTit		:= 0.00
		nComEnt		:= 0.00
		nIrEnt		:= 0.00
		nComVen		:= 0.00
		nIrVen		:= 0.00
		nValBas		:= 0.00
		nPorc 		:= 0
		nVendComis 	:= 0.00
		nVendIr		:= 0.00
	
		If mv_par12 == 1 // Salta Pagina por Vendedor? SIM/NAO
			oReport:EndPage()
		Endif
Enddo

If nTotComis <> 0
	TotR4(nTotTit,nTotEnt,nTotVen,nTotBas,nTotComis,nTotIrE,nTotIrB,nTotIrVen,nTotPorc,nTotCount,oReport,aDados)
Endif

//Fecho os dados fiscais de um pedido
MaFisEnd()

oSection1:Finish()

dbSelectarea("Trb")
dbCloseArea( )

dbSelectArea("SE3")
dbSetOrder(1)
DbSelectarea("SE1")
DbsetOrder(1)
dbClearFilter()
cFilAnt	:= cFilBack

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ SubR4	³ Autor ³  Daniel Tadashi Batori³ Data ³ 30.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime Sub-Total                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ SubR4(void)		                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Gen‚rico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function SubR4(nValTit,nComEnt,nComVen,nValBas,nPorc,nVendComis,nIrEnt,nIrVen,nVendIr,nCount,oReport,aDados)
Local oSection1 := oReport:Section(1)

oReport:SkipLine()

aDados[VEN_COD]	:= ""
aDados[VEN_NOME]:= ""

If mv_par10 > 0  // Aliquota IRRF
	aDados[NOME_CLI]	:= STR0013  //"SUBTOTAL DO VENDEDOR --->"
	aDados[VAL_TIT]	:= nValTit
	aDados[COM_EMISS]	:= nComEnt
	aDados[COM_BAIXA]	:= nComVen
	aDados[VAL_BASE]	:= nValBas
	aDados[PERC]		:= ""
	aDados[VAL_COMIS]	:= nVendComis

	oSection1:PrintLine()
	aFill(aDados,nil)

	aDados[NOME_CLI]	:= STR0014  //"TOTAL IR VENDEDOR    --->"
	aDados[COM_EMISS]	:= nIrEnt
	aDados[COM_BAIXA]	:= nIrVen
	aDados[PERC]		:= ""
	aDados[VAL_COMIS]	:= nVendIr

	oSection1:PrintLine()
	aFill(aDados,nil)

	aDados[NOME_CLI]	:= STR0011 // "TOTAL DO VENDEDOR    --->"
	aDados[VAL_TIT]	:= nValTit
	aDados[COM_EMISS]	:= nComEnt
	aDados[COM_BAIXA]	:= nComVen - nIrVen
	aDados[VAL_BASE]	:= nValBas
	aDados[PERC]		:= ""
	aDados[VAL_COMIS]	:= nVendComis - nVendiR
	oSection1:PrintLine()
	aFill(aDados,nil)

Else

	aDados[NOME_CLI]	:= STR0011 // "TOTAL DO VENDEDOR    --->"
	aDados[VAL_TIT]	:= nValTit
	aDados[COM_EMISS]	:= nComEnt
	aDados[COM_BAIXA]	:= nComVen
	aDados[VAL_BASE]	:= nValBas
	aDados[PERC]		:= ""
	aDados[VAL_COMIS]	:= nVendComis


	oSection1:PrintLine()
	aFill(aDados,nil)
EndIf

oReport:SkipLine()

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TOTR4		³ Autor ³  Paulo Boschetti  ³ Data ³ 30.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime Total De Comiss”es                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TotR4(void)		                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Gen‚rico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function TotR4(nTotTit,nTotEnt,nTotVen,nTotBas,nTotComis,nTotIrE,nTotIrB,nTotIrVen,nTotPorc,nTotCount,oReport,aDados)
Local oSection1 := oReport:Section(1)

oReport:SkipLine()

aDados[VEN_COD]	:= ""
aDados[VEN_NOME]:= ""

If mv_par10 > 0  // Aliquota IRRF

	aDados[NOME_CLI]	:= STR0015   //"SUBTOTAL GERAL    --->"
	aDados[VAL_TIT]	:= nTotTit
	aDados[COM_EMISS]	:= nTotEnt
	aDados[COM_BAIXA]	:= nTotVen
	aDados[VAL_BASE]	:= nTotBas
	aDados[PERC]		:= ""
	aDados[VAL_COMIS]	:= nTotComis

	oSection1:PrintLine()
	aFill(aDados,nil)

	aDados[NOME_CLI]	:= STR0016  //"TOTAL GERAL IR    --->"
	aDados[COM_EMISS]	:= nTotIrE
	aDados[COM_BAIXA]	:= nTotIrB
	aDados[PERC]		:= ""
	aDados[VAL_COMIS]	:= nTotIrVen

	oSection1:PrintLine()
	aFill(aDados,nil)

	aDados[NOME_CLI]	:= STR0012  //"TOTAL  GERAL         --->"
	aDados[VAL_TIT]	:= nTotTit
	aDados[COM_EMISS]	:= nTotEnt
	aDados[COM_BAIXA]	:= nTotVen - nTotIrB
	aDados[VAL_BASE]	:= nTotBas
	aDados[PERC]		:= ""
	aDados[VAL_COMIS]	:= nTotComis - nTotIrVen

	oSection1:PrintLine()
	aFill(aDados,nil)

Else
	aDados[NOME_CLI]	:= STR0012  //"TOTAL  GERAL         --->"
	aDados[VAL_TIT]	:= nTotTit
	aDados[COM_EMISS]	:= nTotEnt
	aDados[COM_BAIXA]	:= nTotVen
	aDados[VAL_BASE]	:= nTotBas
	aDados[PERC]		:= ""
	aDados[VAL_COMIS]	:= nTotComis

	oSection1:PrintLine()
	aFill(aDados,nil)

EndIf

oReport:SkipLine()

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ GRAVACOM ³ Autor ³  Paulo Boschetti      ³ Data ³ 13.07.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Grava Arquivo de Trabalho                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GRAVACOM(void)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Gen‚rico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function GRAVACOM(nVend as numeric, lPVen as logical, nChvFat as numeric, cVend as character, nRecPrinc as numeric)
Local cAlias 	:= Alias()
Local cTabela	:= cAlias
local cVendSuf 	:= ""

Default nChvFat 	:= 0
Default cVend   	:= ""
Default nRecPrinc 	:= 0

cVendSuf := retAsc(nVend, 1, .T.)

dbSelectarea("TRB")
If Empty(cVend)
	cVend := IIf(lPVen,"SC5->C5_VEND","SE1->E1_VEND") + cVendSuf
	cVend := &cVend
Endif

nChave := AllTrim(Str(&(cAlias+"->(RECNO())")))
nChave := nChave + Space(10 - Len(nChave)) 

If TRB->(!DbSeek(cVend + cFilAnt + nChave + cTabela))  
	RecLock("TRB",.T.)
	Replace FILIAL 		With cFilAnt  
	Replace CODIGO 		With cVend
	Replace CHAVE  		With AllTrim(Str(&(cAlias+"->(RECNO())")))
	Replace VENDSUF 	with cVendSuf
	Replace PVEND  		With IIF(lPVen,"S","N")
	Replace RECPRINC 	With nRecPrinc
	If nChvFat > 0
		Replace CHVFAT 	With nChvFat
	Endif
	Replace TABELA 		With cTabela
	MsUnlock()
Endif
DbSelectarea(cAlias)

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³a³ Autor ³ Mauricio Pequim jr             ³ Data ³ 30.07.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Verifica comissoes j  pagas							      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FA610COMPG(aBases,cChaveSE3)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                         	  	              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FA610ComPg(aBases,cChaveSE3,nBases,cTipo,cParcela,nValorFat,nBaseCom,nComissao, cChvSE3I2, cLiqSE1)

Local aAreaSE1	:= SE1->(GetArea())
Local nPercBase := 0
Local nPercEst
Local cDocSE5	:= ""
Local cChvSE5	:= ""
Local nCount	:= 0

Default cTipo    	:= SE1->E1_TIPO
Default cParcela 	:= SE1->E1_PARCELA
Default cChvSE3I2	:= ""
Default cLiqSE1		:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso percentual de comissao seja retornado == a zero, devo   ³
//³ calcular a media (Faturamento com comissao no item <> percen-³
//³ tual do vendedor)                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aBases[nBases,7] == 0
	aBases[nBases,7] := (((aBases[nBases,5]+aBases[nBases,6])*100)/aBases[nBases,2])
Endif

If cLiqSE1 == "LIQ"
	DbSelectArea("SE5")
	SE5->(DbSetOrder(7))
	SE5->(DbGoTop())
	cChvSE5 := SE1->(E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO + E1_CLIENTE + E1_LOJA)
	If SE5->(DbSeek(xFilial("SE5") + SE1->(E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO + E1_CLIENTE + E1_LOJA) ))
		While !SE5->(Eof()) .And. SE1->(E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO + E1_CLIENTE + E1_LOJA) == cChvSE5
			If SE5->E5_MOTBX == "LIQ" 
				cDocSE5 := Alltrim(SE5->E5_DOCUMEN)
				Exit
			Endif
			SE5->(DbSkip())
		Enddo
	Endif
Endif

If !Empty(cDocSE5)
	DbSelectArea("SE1")
	SE1->(DbSetOrder(15))
	SE1->(DbGoTop())
Endif
	
If SE1->(DbSeek(xFilial("SE1") + cDocSE5)) .And. !Empty(cDocSE5)
	cChvSE3I2 := cChaveSE3
	While !SE1->(Eof()) .And. SE1->E1_NUMLIQ == cDocSE5
		cChaveSE3 := aBases[Iif(nBases > 0, nbases,1),1] + SE1->(E1_CLIENTE + E1_LOJA + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO)
		dbSelectArea("SE3")
		dbSetOrder(3)
		If dbSeek(xFilial("SE3") + cChaveSE3)
			While !Eof() .and. xFilial("SE3")== SE3->E3_FILIAL .and.;
				SE3->E3_VEND + SE3->E3_CODCLI + SE3->E3_LOJA + SE3->E3_PREFIXO + SE3->E3_NUM + SE3->E3_PARCELA + SE3->E3_TIPO == cChaveSE3
		
				nPercEst	:= Abs(SE3->E3_BASE / nValorFat)

				If SE3->E3_BAIEMI == "E" .AND. EMPTY(SE3->E3_DATA) 
					If SE3->E3_COMIS < 0
						aBases[nBases,3] += SE3->E3_BASE
						aBases[nBases,5] += SE3->E3_COMIS
					Else
						If aBases[nBases,3] > 0 .and. SE3->E3_BASE <> aBases[nBases,3]
							nPercBase:= Round(NoRound((aBases[nBases,3] * 100) / SE3->E3_BASE, 3),2)
						Else
							nPercBase:= 100
						Endif
						aBases[nBases,3] -= Round(NoRound(SE3->E3_BASE  * (nPercBase/100) ,3),2)
						aBases[nBases,5] += Round(NoRound(SE3->E3_COMIS * (nPercBase/100) ,3),2)
					Endif
				ElseIf !EMPTY(SE3->E3_DATA) .Or. (EMPTY(SE3->E3_DATA) .And. SE3->E3_COMIS < 0 )
					If SE3->E3_BAIEMI == "B" .and. SE3->E3_COMIS > 0
						aBases[nBases,4] -= (nBaseCom*nPercEst)
						aBases[nBases,6] -= (nComissao*nPercEst)
					ElseIf SE3->E3_BAIEMI == "B" .and. cTIPO+cPARCELA == SE3->E3_TIPO+SE3->E3_PARCELA .and. SE3->E3_COMIS < 0
						aBases[nBases,4] += (nBaseCom*nPercEst)
						aBases[nBases,6] += (nComissao*nPercEst)
					Endif
				Endif
				SE3->(dbSkip())
			EndDo
		Endif
		SE1->(DbSkip())
	Enddo
		
		If dbSeek(xFilial("SE3") + cChvSE3I2)
			While !Eof() .and. xFilial("SE3")== SE3->E3_FILIAL .and.;
				SE3->E3_VEND + SE3->E3_CODCLI + SE3->E3_LOJA + SE3->E3_PREFIXO + SE3->E3_NUM + SE3->E3_PARCELA + SE3->E3_TIPO == cChvSE3I2

				nCount++
				nPercEst	:= Abs(SE3->E3_BASE / nValorFat)

				If SE3->E3_BAIEMI == "E" .AND. EMPTY(SE3->E3_DATA) 
					If SE3->E3_COMIS < 0
						aBases[nBases,3] += SE3->E3_BASE
						aBases[nBases,5] += SE3->E3_COMIS
					Else
						If aBases[nBases,3] > 0 .and. SE3->E3_BASE <> aBases[nBases,3]
							nPercBase:= Round(NoRound((aBases[nBases,3] * 100) / SE3->E3_BASE, 3),2)
						Else
							nPercBase:= 100
						Endif

						If nCount == 1
							aBases[nBases,3] := Round(NoRound(SE3->E3_BASE  * (nPercBase/100) ,3),2)
							aBases[nBases,5] := Round(NoRound(SE3->E3_COMIS * (nPercBase/100) ,3),2)
						Else
							aBases[nBases,3] -= Round(NoRound(SE3->E3_BASE  * (nPercBase/100) ,3),2)
							aBases[nBases,5] += Round(NoRound(SE3->E3_COMIS * (nPercBase/100) ,3),2)
						Endif
					Endif
				ElseIf !EMPTY(SE3->E3_DATA) .Or. (EMPTY(SE3->E3_DATA) .And. SE3->E3_COMIS < 0 )
					If SE3->E3_BAIEMI == "B" .and. SE3->E3_COMIS > 0
						aBases[nBases,4] -= (nBaseCom*nPercEst)
						aBases[nBases,6] -= (nComissao*nPercEst)
					ElseIf SE3->E3_BAIEMI == "B" .and. cTIPO+cPARCELA == SE3->E3_TIPO+SE3->E3_PARCELA .and. SE3->E3_COMIS < 0
						aBases[nBases,4] += (nBaseCom*nPercEst)
						aBases[nBases,6] += (nComissao*nPercEst)
					Endif
				Endif
				SE3->(dbSkip())
			EndDo
		EndIf
Else
	dbSelectArea("SE3")
	dbSetOrder(3)
	If dbSeek(xFilial("SE3") + cChaveSE3)
		While !Eof() .and. xFilial("SE3")== SE3->E3_FILIAL .and.;
			SE3->E3_VEND+SE3->E3_CODCLI+SE3->E3_LOJA+SE3->E3_PREFIXO+SE3->E3_NUM + SE3->E3_PARCELA + SE3->E3_TIPO == cChaveSE3

			nCount++
			nPercEst	:= Abs(SE3->E3_BASE / nValorFat)

			If SE3->E3_BAIEMI == "E" .AND. EMPTY(SE3->E3_DATA) 
				If SE3->E3_COMIS < 0
					aBases[nBases,3] += SE3->E3_BASE
					aBases[nBases,5] += SE3->E3_COMIS
				Else
					If aBases[nBases,3] > 0 .and. SE3->E3_BASE <> aBases[nBases,3]
						nPercBase:= Round(NoRound((aBases[nBases,3] * 100) / SE3->E3_BASE, 3),2)
					Else
						nPercBase:= 100
					Endif

					If nCount == 1
						aBases[nBases,3] := Round(NoRound(SE3->E3_BASE  * (nPercBase/100) ,3),2)
						aBases[nBases,5] := Round(NoRound(SE3->E3_COMIS * (nPercBase/100) ,3),2)
					Else
						aBases[nBases,3] -= Round(NoRound(SE3->E3_BASE  * (nPercBase/100) ,3),2)
						aBases[nBases,5] += Round(NoRound(SE3->E3_COMIS * (nPercBase/100) ,3),2)
					Endif
				Endif
			ElseIf !EMPTY(SE3->E3_DATA) .Or. (EMPTY(SE3->E3_DATA) .And. SE3->E3_COMIS < 0 )
				If SE3->E3_BAIEMI == "B" .and. SE3->E3_COMIS > 0
					aBases[nBases,4] -= (nBaseCom*nPercEst)
					aBases[nBases,6] -= (nComissao*nPercEst)
				ElseIf SE3->E3_BAIEMI == "B" .and. cTIPO+cPARCELA == SE3->E3_TIPO+SE3->E3_PARCELA .and. SE3->E3_COMIS < 0
					aBases[nBases,4] += (nBaseCom*nPercEst)
					aBases[nBases,6] += (nComissao*nPercEst)
				Endif
			Endif
			SE3->(dbSkip())
		EndDo
	EndIf
Endif
RestArea(aAreaSE1)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Vendedor610 ³ Autor ³ Marcelo Celi Marques³Data ³ 18/03/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Complemento a função TitPrinc para retorno da array de     ³±±
±±³          ³ vendedores com dados de comissão de titulos principais     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Finr610.prx                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Vendedor610(cAliasFi As Character,nIndexSE5 As Numeric) As Array

	Local aAreaSe1 As Array
	Local aVend610	As Array

	aAreaSe1 := GetArea()
	aVend610	:= {{},{},{},{}}

	TitPrinc(cAliasFi->E1_FILIAL,cAliasFi->E1_PREFIXO,cAliasFi->E1_NUM,cAliasFi->E1_PARCELA,cAliasFi->E1_TIPO,"SE1",@aVend610,nIndexSE5)

	RestArea(aAreaSe1)
	
Return aVend610
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Fr610ProcF  ³ Autor ³ Marcelo Celi Marques³Data ³ 23/03/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Trata o abastecimento do TRB a partir dos títulos filhos   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Finr610.prx                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Fr610ProcF(oReport As Object,lEnd As Logical, aSelFil As Array)

	Local nJX			As Numeric
	Local nVendTit 		As Numeric
	Local nRecPrinc 	As Numeric
	Local nx1 			As Numeric
	Local ny1 			As Numeric
	Local nFilial 		As Numeric
	Local cFilBack 		As Character
	Local cFilSE1 		As Character
	Local lFirstSE1 	As Logical
	local nRecSE1Grv 	As Numeric
	local cComiLiq 		As Character
	local nVend			As Numeric
	local cVendSuf		As character
	Local cQuery 		As Character
	Local cAliasFi		As Character
	Local lPVen 		As Logical
	Local cE1TpNotIN	As Character 

	Default oReport := .F.
	Default lEnd := .F.
	Default aSelFil	:= { cFilAnt }

	nVendTit	:= 0
	nRecPrinc	:= 0
	nx1			:= 0
	ny1 		:= 0
	nFilial		:= 0
	cFilBack	:= cFilAnt
	lFirstSE1	:= .T.
	nRecSE1Grv	:= 0
	cComiLiq	:= AllTrim(SuperGetMV("MV_COMILIQ",,"2"))
	nVend		:= 0
	cQuery 		:= ""
	cAliasFi 	:= ""
	cFilSE1		:= ""
	nJX			:= 0
	lPVen 		:= .F.
	cE1TpNotIN	:= FormatIn(SubStr(MVABATIM,1,Len(MVABATIM)-1),'|')

	
	For nFilial := 1 to Len(aSelFil)
		cFilAnt	:= aSelFil[nFilial]
		cFilSE1	:= xFilial('SE1')
	
		If  cComiliq == '2'

			If __oStTemFi == NIL 
				cQuery := " SELECT DISTINCT E1_FILIAL,E1_PREFIXO,E1_TIPO,E1_NUM,E1_PARCELA,E1_CLIENTE,E1_LOJA,E1_NOMCLI,E1_EMISSAO,E1_VENCREA,E1_VALOR,	RECNO,SUM(SALDOF) AS SALDOF,SUM(SALDOP) AS SALDOP "
				cQuery += " FROM "
				cQuery += " (	"
				cQuery += "	SELECT SE1.E1_FILIAL, SE1.E1_PREFIXO,SE1.E1_TIPO,SE1.E1_NUM, SE1.E1_PARCELA,SE1.E1_CLIENTE,SE1.E1_LOJA, SE1.E1_NOMCLI, SE1.E1_EMISSAO, SE1.E1_VENCREA, SE1.E1_VALOR, SE1.R_E_C_N_O_ AS RECNO, SE1F.E1_SALDO SALDOF, SE1.E1_SALDO SALDOP " 
				cQuery += "	FROM " + RetSqlName("SE1") + " SE1 " 
				cQuery += " LEFT JOIN "+ RetSqlName("FI7") + " FI7P "
				cQuery += " ON FI7P.FI7_FILIAL = SE1.E1_FILIAL AND FI7P.FI7_PRFORI = SE1.E1_PREFIXO AND FI7P.FI7_NUMORI = SE1.E1_NUM AND FI7P.FI7_PARORI = SE1.E1_PARCELA AND FI7P.FI7_TIPORI = SE1.E1_TIPO AND FI7P.FI7_CLIORI = SE1.E1_CLIENTE AND FI7P.FI7_LOJORI = SE1.E1_LOJA "
				cQuery += " LEFT JOIN  " + RetSqlName("SE1") + " SE1F "
				cQuery += " ON FI7P.FI7_FILDES = SE1F.E1_FILIAL AND FI7P.FI7_PRFDES = SE1F.E1_PREFIXO AND FI7P.FI7_NUMDES = SE1F.E1_NUM AND FI7P.FI7_PARDES = SE1F.E1_PARCELA AND FI7P.FI7_TIPDES = SE1F.E1_TIPO AND FI7P.FI7_CLIDES = SE1F.E1_CLIENTE AND FI7P.FI7_LOJDES = SE1F.E1_LOJA "
				cQuery += "	WHERE SE1.D_E_L_E_T_ = '' "	
				cQuery += "	AND SE1.E1_FILIAL = '"+ cFilSE1 +"' " 
				cQuery += " AND SE1.E1_TIPO NOT IN " + cE1TpNotIN + " 
				cQuery += " AND SE1.E1_EMISSAO BETWEEN '" + DTOS(MV_PAR06) + "' AND '" + DTOS(MV_PAR07) + "' " 
				cQuery += "	AND SE1.E1_VENCREA BETWEEN '" + DTOS(MV_PAR03) + "' AND '" + DTOS(MV_PAR04) + "' " 
				If MV_PAR11 == 2
					cQuery += " AND SE1.E1_MOEDA = '"+ cValtochar(MV_PAR05) +"' " 
				EndIf				
				cQuery += " ) A "
				cQuery += " GROUP BY E1_FILIAL,E1_PREFIXO,E1_TIPO,E1_NUM,E1_PARCELA,E1_CLIENTE,E1_LOJA,E1_NOMCLI,E1_EMISSAO,E1_VENCREA,E1_VALOR,RECNO "
				cQuery += " ORDER BY E1_FILIAL,E1_NUM, E1_PREFIXO, E1_PARCELA"

				cQuery := ChangeQuery(cQuery)
				__oStTemFi := FWPreparedStatement():New(cQuery)
			EndIf

		Else				//MV_COMILIQ = 1

			If __oStTemFi == NIL 
				cQuery := " SELECT SE1.E1_FILIAL,SE1.E1_PREFIXO,SE1.E1_TIPO,SE1.E1_NUM,SE1.E1_PARCELA,SE1.E1_CLIENTE,SE1.E1_LOJA,SE1.E1_NOMCLI,SE1.E1_EMISSAO,SE1.E1_VENCREA,SE1.E1_VALOR,SE1.R_E_C_N_O_ AS RECNO,SE1.E1_SALDO SALDOP	"
				cQuery += " FROM " + RetSqlName("SE1") + " SE1 " 
				cQuery += " LEFT JOIN "+ RetSqlName("FI7") + " FI7P "
				cQuery += " ON FI7P.FI7_FILIAL = SE1.E1_FILIAL AND FI7P.FI7_PRFORI = SE1.E1_PREFIXO AND FI7P.FI7_NUMORI = SE1.E1_NUM AND FI7P.FI7_PARORI = SE1.E1_PARCELA AND FI7P.FI7_TIPORI = SE1.E1_TIPO AND FI7P.FI7_CLIORI = SE1.E1_CLIENTE AND FI7P.FI7_LOJORI = SE1.E1_LOJA "
				cQuery += " WHERE  SE1.D_E_L_E_T_ = ' ' "
				cQuery += " AND SE1.E1_FILIAL = '"+ cFilSE1 +"' "
				cQuery += " AND SE1.E1_TIPO NOT IN " + cE1TpNotIN + " 
				cQuery += " AND SE1.E1_EMISSAO BETWEEN '" + DTOS(MV_PAR06) + "' AND '" + DTOS(MV_PAR07) + "' " 
				cQuery += "	AND SE1.E1_VENCREA BETWEEN '" + DTOS(MV_PAR03) + "' AND '" + DTOS(MV_PAR04) + "' " 
				cQuery += "	AND E1_FATURA = '' "
				cQuery += " AND E1_NUMLIQ = '' "
				cQuery += "	AND E1_TIPOLIQ = '' "
				If MV_PAR11 == 2
					cQuery += " AND SE1.E1_MOEDA = '"+ cValtochar(MV_PAR05) +"' " 
				EndIf				
				cQuery += " AND (E1_VEND1 <> '' OR E1_VEND2 <> '' OR E1_VEND3 <> '' OR E1_VEND4 <> '' OR E1_VEND5 <> '') "

				cQuery := ChangeQuery(cQuery)
				__oStTemFi := FWPreparedStatement():New(cQuery)
			EndIf

		EndIf

		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'cAliasFi',.T.,.T.)
		
		While cAliasFi->(!EOF())
	
			DbGoTo(cAliasFi->RECNO)

			aVendedor := Vendedor610(cAliasFi,nIndexSE5)
		
			For nVendTit := 1 to len(aVendedor[1])
				For nJX := 1 TO len(aVendedor[1][nVendTit])
					nVend := nJX
					cVendedor := aVendedor[1][nVendTit][nJX]
					If !Empty(cVendedor)
		
						// Descobrir o recno() do titulo principal
						For nx1 := 1 to Len(aVendedor[1])
							nPos := aScan(aVendedor[1],{|x| x[nx1] == cVendedor})
							If nPos > 0
							nx1 := Len(aVendedor[1])+1
							dbSelectArea("SE1")
							aAreaSE1 := GetArea()
							dbSetOrder(1)
							If dbSeek(aVendedor[4][nPos])
								nRecPrinc := 0
								For ny1 := 1 to len(aVendedor[1][nPos])
									If aVendedor[1][nPos][ny1] == cVendedor
									nRecPrinc := SE1->(Recno())
									Endif
								Next
							Endif
							RestArea(aAreaSE1)
							Endif
						Next
		
						If cVendedor >= mv_par01 .And. cVendedor <= mv_par02
							If ((!Empty(SE1->E1_FATURA) .And. (AllTrim(SE1->E1_FATURA) <> "NOTFAT")) .Or. !Empty(SE1->E1_NUMLIQ)) 
								aAreaSE1 := GetArea()
								cCliente := E1_CLIENTE  //Declarar variaveis
								cLoja    := E1_LOJA
								cFatura  := E1_FATURA
								cFatPref := E1_FATPREF
								nChvFat  := SE1->(Recno())
								
								If !Empty(SE1->E1_NUMLIQ)
									nRecSE1Grv := SE1->(Recno())										
									GravaCom(nVend,lPVen,nRecSE1Grv,cVendedor,nRecPrinc)			
								Else
									If AllTrim(E1_FATURA) == "NOTFAT" .And. E1_SALDO > 0
										GravaCom(nVend,lPVen,nChvFat,cVendedor,nRecPrinc)
									Endif	
								Endif
								RestArea(aAreaSE1)
							Else
								GravaCom(nVend,lPVen,,cVendedor,nRecPrinc)
							Endif
						Endif
					Endif
				Next
			Next
			cAliasFi->(DbSkip())
		Enddo
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se considera pedidos de venda                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par09 == 1  // Considera Ped. Venda
				
				cFilAnt	:= aSelFil[nFilial]
				
				lPVen := .T.
				dbSelectarea("SC5")
				dbsetOrder(2)
			
				If Valtype(oReport) <> "L"
					oReport:SetMeter(SC5->(Reccount()))
				Endif
			
				dbSeek(cFilial+DtoS(mv_par03),.T.)
				While !Eof() .and. cFilial == C5_FILIAL .and. C5_EMISSAO <= mv_par04
			
					If Valtype(oReport) <> "L"
						// chamado pelo r4
						oReport:IncMeter()
					Else
						// chamado pelo R3
						IF lEnd
							@PROW()+1,001 PSAY STR0008 // "CANCELADO PELO OPERADOR"
							Exit
						Endif
						IncRegua()
					Endif
			
					If C5_EMISSAO < mv_par06 .or. C5_EMISSAO > mv_par07
						dbSkip()
						Loop
					Endif
					If MV_PAR11 == 2 .And. C5_MOEDA <> MV_PAR05
						dbSkip()
						Loop
					Endif
					For nVend := 1 TO fa440CntVen()  // grava vendedores no arq TRB
						cVendSuf := retAsc(nVend, 1, .T.)
						IF !EMPTY(C5_VEND&cVendSuf.)
							If C5_VEND&cVendSuf. >= mv_par01 .and. C5_VEND&cVendSuf. <= mv_par02
								GravaCom(nVend,lPVen)
							End
						End
					next nVend
					dbSkip()
				Enddo
			Endif
			
		If __oStTemFi <> Nil
			__oStTemFi:Destroy()
			__oStTemFi := Nil
		EndIf
		
		cAliasFi->(dbCloseArea())

	Next

	cFilAnt	:= cFilBack

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Fr610ProcP  ³ Autor ³ Marcelo Celi Marques³Data ³ 23/03/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Trata o abastecimento do TRB a partir dos títulos pais     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Finr610.prx                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Fr610ProcP(oReport,lEnd, aSelFil)

Local JX 		as numeric
Local nJ 		as numeric
Local lComiLiq 	as logical
Local aTitulos 	as array
Local lLiqui 	as logical
Local nFilial 	as numeric
Local nRecSe1Pr as numeric
Local nSE1Rec 	as numeric
Local cFilSE1 	as character
Local cFilBack	as character
Local lFirstSE1 as logical
Local cTblSE1	as character
Local __oQrySE1	as object
local nTotVend	as numeric
local nVend		as numeric
local cVendSuf	as character

Private _oFINR6101	:= Nil
Private cQueryE1	:= ""

Default oReport := .F.
Default lEnd := .F.
Default aSelFil	:= { cFilAnt }

JX			:= 0
nJ			:= 0
lComiLiq 	:= SuperGetMv("MV_COMILIQ",,"1") == "2" // Se a comissão será definida na liquidação ou na baixa (1 = Liq, 2 = Baixa)
aTitulos 	:= {}
lLiqui	 	:= .F.
nFilial		:= 0
nRecSe1Pr	:= 0
nSE1Rec		:= 0
cFilSE1		:= ""
cFilBack	:= cFilAnt
lFirstSE1	:= .T.
cTblSE1		:= ""
__oQrySE1	:= Nil
nTotVend	:= fa440CntVen()

U_GeraTRBE1(lComiLiq)
__oQrySE1 := FWPreparedStatement():New(cQueryE1)

For nFilial := 1 to Len(aSelFil)
	cFilSE1	:= FwxFilial("SE1", aSelFil[nFilial])

	_oFINR6101:Create()						//crio o TRB no banco
	cTblSE1 :=  _oFINR6101:GetRealName()	//obtenho o nome da tabela temporaria	
	__oQrySE1:setNumeric(1,cTblSE1)//deve ser numeric pra nao carregar aspas simples no nome da tabela
	__oQrySE1:SetString(2,cFilSE1)
	if lComiLiq
		__oQrySE1:SetString(3,cFilSE1)
		__oQrySE1:SetString(4,cFilSE1)
		__oQrySE1:SetString(5,cFilSE1)
	endIf
	cQueryE1 := __oQrySE1:GetFixQuery()
	TCSqlExec(cQueryE1)
	TRBSE1->(dbgotop())
	
	cFilSE1	:= FwxFilial("SE1",TRBSE1->E1_FILIAL)
	
	If (Empty(cFilSE1) .and. lFirstSE1) .or. !Empty(cFilSE1)
		lFirstSE1	:= .F.	
		
		While TRBSE1->(!Eof()) .and. TRBSE1->(!Bof())	
			// Reposiciona filial para casos de compartilhamento do SE1
			cFilAnt	:= If(!Empty(TRBSE1->E1_FILORIG),TRBSE1->E1_FILORIG,cFilAnt)
					
			lPVen 		:= .F.
			lLiqui 		:= .F.
			nSE1Rec		:= 0
			nRecSe1Pr	:= 0
			aTitulos 	:= {}
		
			If Valtype(oReport) <> "L"
				// chamado pelo r4
				oReport:IncMeter()
			Else
				// chamado pelo r3
				IF lEnd
					@PROW()+1,001 PSAY STR0008 // "CANCELADO PELO OPERADOR"
					Exit
				Endif
				IncRegua()
			Endif

			nRecSe1Pr := TRBSE1->E1RECNO

			If TRBSE1->(E1STATUS) == 'NOLIQUIDA '
				aadd(aTitulos, TRBSE1->E1RECNO)
			ElseIf	TRBSE1->(E1STATUS) == 'LIQUIDA   '

				nSE1Rec		:= TRBSE1->E1RECNO
				
				While TRBSE1->E1RECNO == nSE1Rec 

					If TRBSE1->E1RECPAI > 0
						aAdd(aTitulos, TRBSE1->E1RECPAI)	
					Else
						aAdd(aTitulos, TRBSE1->E1RECNO)
					EndIf	
					
					nTRBSE1Rec := TRBSE1->(recno())
					TRBSE1->(dbskip()) 
				EndDo
				TRBSE1->(dbskip(-1))  

			ElseIf TRBSE1->(E1STATUS) == 'E1FATURA  '

				If TRBSE1->(E5_DOCUMEN) <> ''	//alguma coisa entao outra
					aAdd(aTitulos, TRBSE1->E1RECNO)
				EndIf

			Endif
		
			For nJ := 1 To Len(aTitulos)
		
				For JX := 1 TO nTotVend
					nVend := JX
					cVendSuf := retAsc(nVend, 1, .T.)
		
					dbSelectArea("SE1")
					SE1->(dbGoto(aTitulos[nJ]))
		
					IF !EMPTY(E1_VEND&cVendSuf.)
						If E1_VEND&cVendSuf. >= mv_par01 .and. E1_VEND&cVendSuf. <= mv_par02
		
							cVend    := E1_VEND&cVendSuf

							if Empty(SE1->E1_FATURA) .or. (AllTrim(SE1->E1_FATURA) == "NOTFAT")
								If (lComiLiq .OR. ( !lComiLiq .And. Empty(E1_NUMLIQ) ))
									If ( Alltrim(SE1->E1_FATURA) <> "NOTFAT"   .and. SE1->E1_SALDO > 0) .or. (lLiqui .and. SE1->E1_SALDO == 0)
										//VERIFICAR SE DATA VENCTO ESTA NO RANGE DE/ATE
										If SE1->E1_VENCREA >= mv_par03 .And. SE1->E1_VENCREA <= mv_par04
											GravaCom(nVend,lPVen,,cVend,nRecSe1Pr)
										EndIf
									Else
										If SE1->E1_VENCREA >= mv_par03 .And. SE1->E1_VENCREA <= mv_par04 
											aAreaSE1 := GetArea()
											dbSelectArea("SE3")
											dbSetOrder(1)
											If dbSeek(xFilial("SE1")+SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA))
												While SE3->(E3_FILIAL+E3_PREFIXO+E3_NUM+E3_PARCELA) == xFilial("SE1")+SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA)
													//VERIFICAR SE E3_DATA ESTA PREENCHIDO
													If Empty(E3_DATA)
														RestArea(aAreaSE1)
														GravaCom(nVend,lPVen,,cVend,nRecSe1Pr)
													EndIf
													SE3->(DbSkip())
												EndDo
											Else 
												RestArea(aAreaSE1)
												GravaCom(nVend,lPVen,,cVend,nRecSe1Pr)
											EndIf
										EndIf
									EndIf
								Endif
							Endif

						Endif
					Endif
				Next JX
			Next nJ

			TRBSE1->(dbSkip())
		Enddo
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se considera pedidos de venda                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par09 == 1  // Considera Ped. Venda
		
		cFilAnt	:= aSelFil[nFilial]
		
		lPVen := .T.
		dbSelectarea("SC5")
		dbsetOrder(2)
	
		If Valtype(oReport) <> "L"
			oReport:SetMeter(SC5->(Reccount()))
		Endif
	
		dbSeek(cFilial+DtoS(mv_par03),.T.)
		While !Eof() .and. cFilial == C5_FILIAL .and. C5_EMISSAO <= mv_par04
	
			If Valtype(oReport) <> "L"
				// chamado pelo r4
				oReport:IncMeter()
			Else
				// chamado pelo R3
				IF lEnd
					@PROW()+1,001 PSAY STR0008 // "CANCELADO PELO OPERADOR"
					Exit
				Endif
				IncRegua()
			Endif
	
			If C5_EMISSAO < mv_par06 .or. C5_EMISSAO > mv_par07
				dbSkip()
				Loop
			Endif

			If MV_PAR11 == 2 .And. C5_MOEDA <> MV_PAR05
				dbSkip()
				Loop
			Endif
			For nVend:=1 TO nTotVend // grava vendedores no arq TRB
				cVendSuf := retAsc(nVend, 1, .T.)
				IF !EMPTY(C5_VEND&cVendSuf.)
					If C5_VEND&cVendSuf. >= mv_par01 .and. C5_VEND&cVendSuf. <= mv_par02
						GravaCom(nVend,lPVen)
					End
				End
			next nVend
			dbSkip()
		Enddo
	Endif

	_oFINR6101:Delete()

Next

FreeObj(__oQrySE1)

cFilAnt := cFilBack
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IsFatura  ºAutor  ³Microsiga           º Data ³  03/08/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna se o titulo posicionado eh fatura                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function IsFatura()
Local lFatura	 := ( alltrim(SE1->E1_FATURA)=="NOTFAT") .Or. !Empty(SE1->E1_NUMLIQ)
Return(lFatura)

//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} MaxSeqSe5

Função para verificação dda maior sequencia de baixa do título

@author    Rodrigo Oliveira
@version   12
@since     21/08/2017

@return cSeq - retorna a maior sequencia de baixa do título 
/*/
//-----------------------------------------------------------------------------------------------------

Static Function MaxSeqSe5(cChave)

Local cSeq		:= "01"
Local aAreaSE5	:= SE5->(GetArea())

SE5->(DbSetOrder(7))

If SE5->(DbSeek(cChave))

	While SE5->(!Eof()) .And. ;
		cChave == SE5->E5_FILIAL + SE5->E5_PREFIXO + SE5->E5_NUMERO + SE5->E5_PARCELA + SE5->E5_TIPO + SE5->E5_CLIENTE + SE5->E5_LOJA
		If cSeq < SE5->E5_SEQ
			cSeq	:= SE5->E5_SEQ
		EndIf
		SE5->(DbSkip())
	EndDo			
EndIf

RestArea(aAreaSE5)

Return cSeq

//-----------------------------------------------------------------------------------------------------
/*/{Protheus.doc} GeraTRBE1

Função para geração da TRB e query para a geração dos registros da função Fr610ProcP

@author    Bruno Hovat
@version   12
@since     05/08/2021

@return Nil
/*/
//-----------------------------------------------------------------------------------------------------

User Function GeraTRBE1(lComiLiq as logical)

Local cAliasQry1 	as character
Local nBigInt 		as numeric
Local aCampos 		as array	
Local cCampos 		as character	
Local cSE1Tbl 		as character	
Local cSE5Tbl 		as character	
Local cSE3Tbl 		as character	
Local cE1TpNotIN 	as character
Local nX 			as numeric		
local aCposComi 	as array	

default lComiLiq := AllTrim(SuperGetMV("MV_COMILIQ", ,"2")) == "2"

cAliasQry1	:= "TRBSE1"
nBigInt		:= 9223372036854775807	//tamanho do bigint que eh o tamanho maximo do RECNO
aCampos		:= {}
cCampos		:= ""
cSE1Tbl		:= ""	
cSE5Tbl		:= ""
cSE3Tbl		:= ""
cE1TpNotIN	:= ""
nX			:= 0
aCposComi	:= fa440Cpos()

AAdd(aCampos, {"E1_FILIAL"	, "C", TamSX3("E1_FILIAL")[1]	,	0							})
AAdd(aCampos, {"E1_FILORIG"	, "C", TamSX3("E1_FILORIG")[1]	,	0							})
AAdd(aCampos, {"E1_PREFIXO"	, "C", TamSX3("E1_PREFIXO")[1]	,	0							})
AAdd(aCampos, {"E1_NUM"		, "C", TamSX3("E1_NUM")[1]		,	0							})
AAdd(aCampos, {"E1_PARCELA"	, "C", TamSX3("E1_PARCELA")[1]	,	0							})
AAdd(aCampos, {"E1_TIPO"	, "C", TamSX3("E1_TIPO")[1]		,	0							})
AAdd(aCampos, {"E1_EMISSAO"	, "D", 8						,	0							})
AAdd(aCampos, {"E1_VENCREA"	, "D", 8						,	0							})
AAdd(aCampos, {"E1_MOEDA"	, "N", TamSX3("E1_TIPO")[1]		,	0							})
AAdd(aCampos, {"E1_SALDO"	, "N", TamSX3("E1_SALDO")[1]	,	TamSX3("E1_SALDO")[2]		})
AAdd(aCampos, {"E1_FATURA"	, "C", TamSX3("E1_FATURA")[1]	,	0							})
AAdd(aCampos, {"E1_FATPREF"	, "C", TamSX3("E1_FATPREF")[1]	,	0							})
AAdd(aCampos, {"E1_NUMLIQ"	, "C", TamSX3("E1_NUMLIQ")[1]	,	0							})
AAdd(aCampos, {"E1_TIPOLIQ"	, "C", TamSX3("E1_TIPOLIQ")[1]	,	0							})

for nX := 1 to len(aCposComi)
	AAdd(aCampos, {aCposComi[nX][1]	, "C", TamSX3(aCposComi[nX][1])[1]	,	0							})
next nX

AAdd(aCampos, {"E1_CLIENTE"	, "C", TamSX3("E1_CLIENTE")[1]	,	0							})
AAdd(aCampos, {"E1_LOJA"	, "C", TamSX3("E1_LOJA")[1]		,	0							})
AAdd(aCampos, {"E1STATUS"	, "C", 10						,	0							})
AAdd(aCampos, {"E5_TIPODOC"	, "C", TamSX3("E5_TIPODOC")[1]	,	0							})
AAdd(aCampos, {"E5_SITUACA"	, "C", TamSX3("E5_SITUACA")[1]	,	0							})
AAdd(aCampos, {"E5_MOTBX"	, "C", TamSX3("E5_MOTBX")[1]	,	0							})
AAdd(aCampos, {"E5_DOCUMEN"	, "C", TamSX3("E5_DOCUMEN")[1]	,	0							})
AAdd(aCampos, {"E5_RECPAG"	, "C", TamSX3("E5_RECPAG")[1]	,	0							})
AAdd(aCampos, {"E1RECNO"	, "N", nBigInt					,	0							})
AAdd(aCampos, {"E1RECPAI"	, "N", nBigInt					,	0							})

If _oFINR6101 <> Nil
	_oFINR6101:Delete()
	_oFINR6101 := Nil
EndIf

_oFINR6101 := FwTemporaryTable():New(cAliasQry1)
_oFINR6101:SetFields(aCampos)
_oFINR6101:AddIndex("1",{"E1_FILIAL"})

cCampos	:= "E1_FILIAL,E1_FILORIG,E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO,E1_EMISSAO,E1_VENCREA,E1_MOEDA,"
cCampos	+= "E1_SALDO,E1_FATURA,E1_FATPREF,E1_NUMLIQ,E1_TIPOLIQ,
cCampos += fa440CpoCh(, 3)	+ ", "
cCampos += "E1_CLIENTE,E1_LOJA,E1STATUS,E5_TIPODOC,E5_SITUACA,E5_MOTBX,E5_DOCUMEN,E5_RECPAG, E1RECNO,E1RECPAI"

cCmpAlias	:= "SE1.E1_FILIAL,SE1.E1_FILORIG,SE1.E1_PREFIXO,SE1.E1_NUM,SE1.E1_PARCELA,SE1.E1_TIPO,SE1.E1_EMISSAO,SE1.E1_VENCREA,SE1.E1_MOEDA,"
cCmpAlias	+= "SE1.E1_SALDO,SE1.E1_FATURA,SE1.E1_FATPREF,SE1.E1_NUMLIQ,SE1.E1_TIPOLIQ, "	
cCmpAlias 	+= fa440CpoCh("SE1", 3)	+ ", "
cCmpAlias	+= "SE1.E1_CLIENTE,SE1.E1_LOJA,"//campos de recno incluidos no seu respectivo resultset

cSE1Tbl		:= RetSqlName("SE1")
cSE5Tbl		:= RetSqlName("SE5")
cSE3Tbl		:= RetSqlName("SE3")
cE1TpNotIN	:= FormatIn(SubStr(MVABATIM,1,Len(MVABATIM)-1),'|')

//titulo não liquidado
cQueryE1 := "INSERT INTO ? (" + cCampos +") SELECT " + cCampos + " FROM ( "
cQueryE1 += "SELECT " + cCmpAlias
cQueryE1 += 		" 'NOLIQUIDA' AS E1STATUS, ' ' AS E5_TIPODOC, ' ' AS E5_SITUACA, ' ' AS E5_MOTBX, "
cQueryE1 += 		" ' ' AS E5_DOCUMEN, ' ' AS E5_RECPAG, SE1.R_E_C_N_O_ AS E1RECNO, 0 AS E1RECPAI "
cQueryE1 += 		" FROM " + cSE1Tbl + " SE1 "
cQueryE1 += 		" WHERE SE1.E1_FILIAL = ? AND SE1.E1_VENCREA BETWEEN '" + dtos(mv_par03) + "' AND '" + dtos(mv_par04) + "' AND "
cQueryE1 += 		" SE1.E1_TIPO NOT IN " + cE1TpNotIN + " AND " 
cQueryE1 += 		" SE1.E1_EMISSAO BETWEEN '" + dtos(mv_par06) + "' AND '" + dtos(mv_par07) + "' AND SE1.D_E_L_E_T_ = ' ' "
cQueryE1 += 		" AND SE1.E1_NUMLIQ = ' ' "
cQueryE1 += 		" AND SE1.E1_FATURA <> '" + padr('NOTFAT',TamSx3("E1_FATURA")[1]) + "'"
cQueryE1 +=			" AND ( "+ fa440CpoCh(, 2, "<>", "","OR") +" )" //E1_VEND1 <> ' ' OR E1_VEND2 <> ' '...
If	MV_PAR11 = 2	//se mv_par11  2 -> nao exibe outras moedas, entao fitra pela moeda escolhida
	cQueryE1 += 	" AND SE1.E1_MOEDA = '" + cvaltochar(MV_PAR05) +"' "
EndIf	
if lComiLiq
	cQueryE1 += "union "
	//titulos liquidacao
	cQueryE1 += "SELECT " + cCmpAlias
	cQueryE1 += 		" 'LIQUIDA' AS E1STATUS, E5XE1.E5_TIPODOC AS E5_TIPODOC, E5XE1.E5_SITUACA AS E5_SITUACA, E5XE1.E5_MOTBX AS E5_MOTBX, "
	cQueryE1 += 		" ' ' AS E5_DOCUMEN, E5XE1.E5_RECPAG AS E5_RECPAG, SE1.R_E_C_N_O_ AS E1RECNO, E1RECPAI.R_E_C_N_O_ AS E1RECPAI "
	cQueryE1 += 		" FROM " + cSE1Tbl + " SE1 LEFT JOIN "
	cQueryE1 += 		" (SELECT E5_FILIAL,E5_DOCUMEN,E5_PREFIXO,E5_NUMERO,E5_PARCELA,E5_TIPO,E5_TIPODOC,E5_SITUACA,E5_MOTBX, E5_RECPAG "
	cQueryE1 += 		" FROM " + cSE5Tbl +" SE5 WHERE SE5.D_E_L_E_T_ = ' ' ) E5XE1 ON "
	cQueryE1 += 			" SE1.E1_FILIAL = E5XE1.E5_FILIAL AND SE1.E1_NUMLIQ = E5XE1.E5_DOCUMEN AND E5XE1.E5_MOTBX = 'LIQ' AND E5XE1.E5_RECPAG = 'R'  "
	cQueryE1 += 		" LEFT JOIN "
	cQueryE1 += 		" (SELECT E1_FILIAL,E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO,R_E_C_N_O_ FROM " + cSE1Tbl + " SE1 "
	cQueryE1 += 		" WHERE SE1.D_E_L_E_T_ = ' ') E1RECPAI ON "
	cQueryE1 += 				" E5XE1.E5_FILIAL = E1RECPAI.E1_FILIAL AND "
	cQueryE1 += 				" E5XE1.E5_PREFIXO = E1RECPAI.E1_PREFIXO AND "
	cQueryE1 += 				" E5XE1.E5_NUMERO = E1RECPAI.E1_NUM AND "
	cQueryE1 += 				" E5XE1.E5_PARCELA = E1RECPAI.E1_PARCELA AND "
	cQueryE1 += 				" E5XE1.E5_TIPO = E1RECPAI.E1_TIPO "
	cQueryE1 += 		" WHERE SE1.E1_FILIAL = ? AND SE1.E1_VENCREA BETWEEN '" + dtos(mv_par03) + "' AND '" + dtos(mv_par04) + "' AND "
	cQueryE1 += 			" SE1.E1_TIPO NOT IN " + cE1TpNotIN + " AND "
	cQueryE1 += 			" SE1.E1_EMISSAO BETWEEN '" + dtos(mv_par06) + "' AND '" + dtos(mv_par07) + "' AND SE1.D_E_L_E_T_ = ' ' "
	cQueryE1 += 			" AND SE1.E1_NUMLIQ <> ' ' "
	cQueryE1 += 			" AND SE1.E1_SALDO > 0 "
	If	MV_PAR11 = 2	//nao exibe outras moedas, entao fitra pela moeda escolhida
		cQueryE1 += 		" AND SE1.E1_MOEDA = '" + cvaltochar(MV_PAR05) +"' "
	EndIf	
	cQueryE1 += "union "
	// titulo faturado
	cQueryE1 += "SELECT " + cCmpAlias
	cQueryE1 += 		" 'NOTFAT' AS E1STATUS, ' ' AS E5_TIPODOC, ' ' AS E5_SITUACA, ' ' AS E5_MOTBX, "
	cQueryE1 += 		" ' ' AS E5_DOCUMEN, ' ' AS E5_RECPAG, SE1.R_E_C_N_O_ AS E1RECNO, 0 E1RECPAI "
	cQueryE1 += 		" FROM " + cSE1Tbl + " SE1 "
	cQueryE1 += 		" WHERE SE1.E1_FILIAL = ? AND "			
	cQueryE1 += 			" SE1.E1_TIPO NOT IN " + cE1TpNotIN + " AND "  			
	cQueryE1 += 			" SE1.E1_EMISSAO BETWEEN '" + dtos(mv_par06) + "' AND '" + dtos(mv_par07) + "'"
	cQueryE1 += 			" AND SE1.E1_VENCREA BETWEEN '" + dtos(mv_par03) + "' AND '" + dtos(mv_par04) + "'"
	cQueryE1 += 			" AND SE1.D_E_L_E_T_ = ' ' "
	cQueryE1 += 			" AND SE1.E1_FATURA = '" + padr('NOTFAT',TamSx3("E1_FATURA")[1]) + "'"
	cQueryE1 += 			" AND SE1.E1_SALDO = 0 "			
	cQueryE1 +=				" AND ( "+ fa440CpoCh(, 2, "=", "", "AND") +" )" //E1_VEND1 = ' ' AND E1_VEND2 = ' '...
	If	MV_PAR11 = 2	//nao exibe outras moedas, entao fitra pela moeda escolhida
		cQueryE1 += 		" AND SE1.E1_MOEDA = '" + cvaltochar(MV_PAR05) +"' "
	EndIf	
	cQueryE1 += "union "
	//titulo faturado e liquidado 
	cQueryE1 += "SELECT " + cCmpAlias
	cQueryE1 += 		" 'E1FATURA' AS E1STATUS, ' ' AS E5_TIPODOC, ' ' AS E5_SITUACA, SC5FATURA.E5_MOTBX AS E5_MOTBX,"
	cQueryE1 += 		" SC5FATURA.E5_DOCUMEN, SC5FATURA.E5_RECPAG AS E5_RECPAG, SE1.R_E_C_N_O_ AS E1RECNO, 0 AS E1RECPAI "
	cQueryE1 += 		" FROM " + cSE1Tbl + " SE1 LEFT JOIN "
	cQueryE1 += 				" (SELECT DISTINCT E5_FILIAL, E5_DOCUMEN, E5_MOTBX, E5_RECPAG "
	cQueryE1 += 				" FROM " + cSE5Tbl + " SE5 INNER JOIN " + cSE1Tbl + " SE1IN ON SE1IN.E1_FILIAL = SE5.E5_FILIAL AND "
	cQueryE1 += 				" SE1IN.E1_PREFIXO = SE5.E5_PREFIXO AND SE1IN.E1_NUM = SE5.E5_NUMERO AND "
	cQueryE1 += 				" SE1IN.E1_PARCELA = SE5.E5_PARCELA AND SE1IN.E1_TIPO = SE5.E5_TIPO "
	cQueryE1 += 				" WHERE SE1IN.D_E_L_E_T_ = ' ' AND SE5.D_E_L_E_T_ = ' ' AND "
	cQueryE1 += 				" NOT EXISTS ( select '' from " + cSE3Tbl + " SE3 WHERE SE1IN.E1_FILIAL = SE3.E3_FILIAL AND "
	cQueryE1 += 				" SE1IN.E1_PREFIXO = SE3.E3_PREFIXO AND SE1IN.E1_NUM = SE3.E3_NUM AND " 
	cQueryE1 += 				" SE1IN.E1_PARCELA = SE3.E3_PARCELA AND SE3.D_E_L_E_T_ = ' ') "
	cQueryE1 += 				" ) SC5FATURA ON "
	cQueryE1 += 				" SC5FATURA.E5_FILIAL = SE1.E1_FILIAL AND SC5FATURA.E5_DOCUMEN = SE1.E1_NUMLIQ AND SC5FATURA.E5_MOTBX = 'LIQ' AND SC5FATURA.E5_RECPAG = 'R' "
	cQueryE1 += 			" WHERE SE1.E1_FILIAL = ? AND "
	cQueryE1 += 			" SE1.E1_TIPO NOT IN " + cE1TpNotIN + " AND "
	cQueryE1 += 			" SE1.E1_EMISSAO BETWEEN '" + dtos(mv_par06) + "' AND '" + dtos(mv_par07) + "'"
	cQueryE1 += 			" AND SE1.E1_VENCREA BETWEEN '" + dtos(mv_par03) + "' AND '" + dtos(mv_par04) + "'"
	cQueryE1 += 			" AND SE1.D_E_L_E_T_ = ' ' "
	cQueryE1 += 			" AND SE1.E1_FATURA <> ' ' "
	cQueryE1 += 			" AND SE1.E1_FATURA <> 'NOTFAT' "
	cQueryE1 += 			" AND SE1.E1_NUMLIQ <> ' ' "
	cQueryE1 += 			" AND SE1.E1_SALDO = 0 "
	cQueryE1 +=				" AND ( "+ fa440CpoCh(, 2, "=", "", "AND") +" )" //E1_VEND1 = ' ' AND E1_VEND2 = ' '...
	If	MV_PAR11 = 2	//nao exibe outras moedas, entao fitra pela moeda escolhida
		cQueryE1 += 		" AND SE1.E1_MOEDA = '" + cvaltochar(MV_PAR05) +"' "
	EndIf	
endIf

cQueryE1 += " ) FINR6101 " //o que acontece ser duas queries rodarem com o mesmo alias

Return
