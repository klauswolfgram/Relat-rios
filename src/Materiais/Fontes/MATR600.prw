/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR600.CH" 
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR600  ³ Autor ³ Marco Bianchi         ³ Data ³ 27/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Pedidos de Vendas por Vendedor/Cliente          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function MATR600()

Local oReport
Local aFieldsPD := {}
Private oTempTable := NIL
If FindFunction("TRepInUse") .And. TRepInUse()
	aFieldsPD := {"A1_NOME","A3_NOME", "A1_MUN"}
	FATPDLoad(Nil, Nil, aFieldsPD)
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()
	FATPDUnload()
	ASize(aFieldsPD, 0)
Else
	U_MATR600R3()
EndIf

If( valtype(oTempTable) == "O")
	oTempTable:Delete()
	freeObj(oTempTable)
	oTempTable := nil
EndIf



Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³27/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local oVendedor
Local oPedVC
Local oTotGer
Local cNome 	:= ""
Local cMun		:= ""
Local nTotPed1	:= 0
Local nTotGer	:= 0

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
oReport := TReport():New("MATR600",STR0015,"MTR600", {|oReport| ReportPrint(oReport,oPedVC,oVendedor,oTotGer)},STR0016 + " " + STR0017)	// "Pedidos Por Vendedor/Cliente"###"Este relatorio ira emitir a relacao de Pedidos por"###"ordem de Vendedor/Cliente."
oReport:SetPortrait() 
oReport:SetTotalInLine(.F.)

Pergunte(oReport:uParam,.F.)

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
oVendedor := TRSection():New(oReport,STR0024,{"TRB","SA3"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Pedidos Por Vendedor/Cliente"
oVendedor:SetTotalInLine(.F.)
TRCell():New(oVendedor,"VENDEDOR"	,"TRB",STR0028,PesqPict("SA3","A3_COD")	,TamSx3("A3_COD"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/	)	// Codigo do Vendedor
TRCell():New(oVendedor,"A3_NOME"		,		,RetTitle("A3_NOME")	,PesqPict("SA3","A3_NOME")	,TamSx3("A3_NOME"	)[1],/*lPixel*/,{|| FATPDObfuscate(SA3->A3_NOME, "A3_NOME") })	// Nome do Vendedor

oPedVC := TRSection():New(oVendedor,STR0025,{"TRB"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Pedidos Por Vendedor/Cliente"
oPedVC:SetTotalInLine(.F.)
TRCell():New(oPedVC,"CLIENTE"	,"TRB",STR0029	,PesqPict("SA1","A1_COD")	,TamSx3("A1_COD"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/	)	// Codigo do Cliente
TRCell():New(oPedVC,"CNOME"		,		,RetTitle("A1_NOME")	,PesqPict("SA1","A1_NOME")	,TamSx3("A1_NOME"		)[1],/*lPixel*/,{|| FATPDObfuscate(cNome, "A1_NOME") }								)	// Razao Social do Cliente
TRCell():New(oPedVC,"CMUN"		,		,RetTitle("A1_MUN")	,PesqPict("SA1","A1_MUN")	,TamSx3("A1_MUN"		)[1],/*lPixel*/,{|| FATPDObfuscate(cMun, "A1_MUN") }									)	// Municipio do Cliente
TRCell():New(oPedVC,"NUMPED"	,"TRB",RetTitle("C5_NUM")	,PesqPict("SC5","C5_NUM")	,TamSx3("C5_NUM"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/	)	// Numero do Pedido de Venda
TRCell():New(oPedVC,"NTOTPED1"	,		,STR0019					,TM(nTotPed1,18,2),TamSx3("C6_VALOR"	)[1],/*lPixel*/,{|| nTotPed1 },,,"RIGHT")	// "Total"


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Esta Secao serve apenas para receber as Querys que irao gerar o arquivo³
//³ temporario para impressao 							                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTemp := TRSection():New(oReport,STR0026,{"SC5","SA1"},,/*Campos do SX3*/,/*Campos do SIX*/)		// "Pedidos Por Vendedor/Cliente"
oTemp:SetTotalInLine(.F.)

oTemp1 := TRSection():New(oReport,STR0027,{"SC6"},,/*Campos do SX3*/,/*Campos do SIX*/)		// "Pedidos Por Vendedor/Cliente"
oTemp1:SetTotalInLine(.F.)


// Secao Total Geral
oTotGer := TRSection():New(oReport,"",,/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Pedidos Por Vendedor/Cliente"
oTotGer:SetTotalInLine(.F.)
                            
TRCell():New(oTotGer,""	,,STR0030	,PesqPict("SA1","A1_COD")	,TamSx3("A1_COD"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/	)	// Codigo do Cliente
TRCell():New(oTotGer,""	,," ",PesqPict("SA1","A1_NOME")	,TamSx3("A1_NOME"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/								)	// Razao Social do Cliente
TRCell():New(oTotGer,""	,," ",PesqPict("SA1","A1_MUN")	,TamSx3("A1_MUN"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/									)	// Municipio do Cliente
TRCell():New(oTotGer,""	,," ",PesqPict("SC5","C5_NUM")	,TamSx3("C5_NUM"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/	)	// Numero do Pedido de Venda
TRCell():New(oTotGer,"NTOTGER"	,," ",TM(nTotGer,18,2) ,TamSx3("C6_VALOR"		)[1],/*lPixel*/,{|| nTotGer },,,"RIGHT")	// "Total"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Cabecalho no topo da pagina                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Section(1):SetHeaderPage()
oReport:Section(1):SetTotalText(STR0022) 

oReport:Section(2):SetEditCell(.F.)
oReport:Section(3):SetEditCell(.F.)

oReport:Section(1):Section(1):SetEdit(.F.)
oReport:Section(4):SetEdit(.F.)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Marco Bianchi          ³ Data ³27/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,oPedVC,oVendedor,oTotGer)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao das Variaveis                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cCli
Local cLoja
Local cVend
Local nTotPed1
Local aCampos 	:= {}
Local aTam			:= {}
Local cExt			:= ""
Local cVendCh		:= ""
Local j, Suf
Local nTotSC6		:= 0
Local cEstoq		:= If( (MV_PAR13 == 1),"S",If( (MV_PAR13 == 2),"N","SN" ) )
Local cDupli		:= If( (MV_PAR14 == 1),"S",If( (MV_PAR14 == 2),"N","SN" ) )
Local cFilSA3		:= ""
Local cFiltroSA3	:= ""
Local aPedido		:= {}
Local nCont		    := 0
Local nTotGer		:= 0

TRPosition():New(oReport:Section(1),"SA3",1,{|| xFilial("SA3")+TRB->VENDEDOR })
TRPosition():New(oReport:Section(1):Section(1),"SA1",1,{|| xFilial("SA1")+TRB->CLIENTE+TRB->LOJA })

If MV_PAR15 ==  1
	TRFunction():New(oPedVC:Cell("NTOTPED1"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,TM(nTotPed1,18,2),/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)
	oReport:Section(1):Section(1):SetTotalText(STR0021)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SetBlock: faz com que as variaveis locais possam ser         ³
//³ utilizadas em outras funcoes nao precisando declara-las      ³
//³ como private											  	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Section(1):Cell("CNOME" 	):SetBlock({|| FATPDObfuscate(cNome, "A1_NOME")	})
oReport:Section(1):Section(1):Cell("CMUN" 		):SetBlock({|| FATPDObfuscate(cMun, "A1_MUN") })
oReport:Section(1):Section(1):Cell("NTOTPED1" 	):SetBlock({|| nTotPed1	})
oReport:Section(4):Cell("NTOTGER" 	):SetBlock({|| nTotGer	})
cNome 	:= ""
cMun	:= ""
nTotPed1:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define array para arquivo de trabalho                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam:=TamSX3("C5_VEND1")
AADD(aCampos,{ "VENDEDOR","C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_NUM")
AADD(aCampos,{ "NUMPED"  ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C5_CLIENTE")
AADD(aCampos,{ "CLIENTE" ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C5_EMISSAO")
AADD(aCampos,{ "EMISSAO" ,"D",aTam[1],aTam[2] } )
aTam:=TamSX3("C5_LOJACLI")
AADD(aCampos,{ "LOJA"    ,"C",aTam[1],aTam[2] } )
AADD(aCampos,{ "MOEDA"   ,"N",1,0 } )
aTam:=TamSX3("F1_VALBRUT")
AADD(aCampos,{ "TOTPED"    ,"N",aTam[1],aTam[2] } )
aTam:=TamSX3("A1_NOME")
AADD(aCampos,{ "CLINOME"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("A1_MUN")
AADD(aCampos,{ "CLIMUN"   ,"C",aTam[1],aTam[2] } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pula pagina na quebra por vendedor                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR07 == 1
	oReport:Section(1):SetPageBreak(.T.)
EndIf
TRFunction():New(oPedVC:Cell("NTOTPED1"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,TM(nTotPed1,18,2),/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/,oVendedor)

//-------------------------------------------------------------------
// Instancia tabela temporária.  
//-------------------------------------------------------------------

oTempTable	:= FWTemporaryTable():New( "TRB" )

//-------------------------------------------------------------------
// Atribui o  os índices.  
//-------------------------------------------------------------------
oTempTable:SetFields( aCampos )
oTempTable:AddIndex("1",{"VENDEDOR","CLIENTE","NUMPED"})
	
//------------------
//Criação da tabela
//------------------
oTempTable:Create()
   
If len(oReport:Section(1):GetAdvplExp("SA3")) > 0
	cFiltroSA3 := oReport:Section(1):GetAdvplExp("SA3")
EndIf

GTrabTopR4(oReport)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Relatorio                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cFilSA3	:= xFilial("SA3")
dbSelectArea("TRB")
TRB->(dbGoTop())
oReport:Section(1):Init()
oReport:SetMeter(RecCount())		// Total de Elementos da regua
While TRB->(! Eof())

	// Verifica filtro do usuario
	SA3->(dbSetOrder(1))
	SA3->(dbSeek(cFilSA3 + TRB->VENDEDOR))
	If !Empty(cFiltroSA3) .And. SA3->(! (&cFiltroSA3))
		TRB->(dbSkip())
		Loop
	EndIf


	cVend := TRB->VENDEDOR
	oReport:Section(1):PrintLine()
	
	While TRB->(! Eof()) .And.  TRB->VENDEDOR == cVend
				
		cCli 		:= TRB->CLIENTE
		cLoja		:= TRB->LOJA
		oReport:Section(1):Section(1):Init()
		While TRB->(! Eof()) .And. TRB->VENDEDOR == cVend .And. TRB->CLIENTE == cCli .And. TRB->LOJA == cLoja
			
			oReport:IncMeter()
		
			nTotPed1	:= xMoeda( TRB->TOTPED, TRB->MOEDA, MV_PAR08, TRB->EMISSAO )
				
			cNome := TRB->CLINOME
			cMun  := TRB->CLIMUN
		 		
			oReport:Section(1):Section(1):PrintLine()
			
			If MV_PAR16 == 2
				If AScan(aPedido,{|x| x[1]+x[2]+x[3] == cCli+cLoja+TRB->NUMPED}) == 0
					AADD(aPedido,{cCli,cLoja,TRB->NUMPED})
					nTotGer += nTotPed1
				EndIf
			Else
				nTotGer += nTotPed1
			EndIf
			
			TRB->(dbSkip())
			
		EndDo

		// Total por Cliente
		IF (MV_PAR15 == 1 .And. TRB->CLIENTE+TRB->LOJA <> cCli+cLoja) .Or. (MV_PAR15 == 1 .And. TRB->VENDEDOR <> cVend)
			oReport:Section(1):Section(1):SetTotalText(STR0021 + cCli+cLoja)
			oReport:Section(1):Section(1):Finish()
			oReport:Section(1):Section(1):Init()
		EndIF

	EndDo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime totalizador                									   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):SetTotalText(STR0022 + cVend)
	oReport:section(1):Finish()
	oReport:section(1):Init()
	
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Total geral                									   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR07 == 2
	oReport:section(4):Init()
	oReport:section(4):Printline()
	oReport:section(4):Finish()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura Areas                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If( valtype(oTempTable) == "O")
	oTempTable:Delete()
	freeObj(oTempTable)
	oTempTable := nil
EndIf

SC5->(DbSetOrder(1))

dbSelectArea("SA3")
dbClearFilter()
dbSetOrder(1)

Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GravTrabR4³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava Arquivo de Trabalho                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nEl - Ordem do Vendedor                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR600                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static FuncTion GravTrabR4(nEl)

Local suf := "SC5->C5_VEND" + Str(nEl,1)

RecLock("TRB",.t.)
Replace VENDEDOR With &suf
Replace NUMPED   With SC5->C5_NUM
Replace CLIENTE  With SC5->C5_CLIENTE
Replace EMISSAO  With SC5->C5_EMISSAO
Replace LOJA     With SC5->C5_LOJACLI
Replace MOEDA    With SC5->C5_MOEDA
MsUnlock()
dbSelectArea("SC5")

Return .T.


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GTrabTopR4³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava Arquivo de Trabalho                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nEl - Ordem do Vendedor                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR600                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GTrabTopR4(oReport)

Local aArea		:= GetArea()
Local nJ      	:= 0
Local cSC5Tmp 	:= GetNextAlias()
Local cSC5Tmp2	:= GetNextAlias()
Local cCampos  	:= ""
Local cQuery2 	:= ""
Local cVendCh 	:= ""
Local cSuf    	:= ""
Local nVend	  	:= Fa440CntVen()
Local cVend   	:= ""
Local cWhere   	:= ""
Local cWhere2  	:= ""
Local cPedTemp 	:= ""
Local aVend   	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

cSuf:="0"
cWhere := "%("
For nJ := 1 to nVend
	cSuf := Soma1(cSuf)
	cVend := "C5_VEND"+cSuf
	If SC5->(FieldPos(cVend))>0
		Aadd(aVend,cVend)
		cCampos += cVend+","
		If Len(cWhere) > 2
			cWhere+="or "
		Endif
		cWhere += "("+cVend+"<>' ' and "+cVend+">='"+MV_PAR03+"' and "+cVend+"<='"+MV_PAR04+"') "
	Endif
Next
cWhere += ")%"

cCampos := "%,"
For nJ := 1 To SC5->(FCount())
	If nJ > 1
		cCampos += ", "
	EndIf		
	cCampos += SC5->(FieldName(nJ))
Next
cCampos += "%"

cWhere2 := "% AND"      
If cPaisLoc == "BRA"
	If MV_PAR12 == 1
		cWhere2 += " SF4.F4_AGREG <> 'N' AND "
	Endif
Endif
If MV_PAR13 == 1
	cWhere2 += " SF4.F4_ESTOQUE = 'S' AND "
ElseIf MV_PAR13 == 2
	cWhere2 += " SF4.F4_ESTOQUE = 'N' AND "
EndIf
If MV_PAR14 == 1
	cWhere2 += " SF4.F4_DUPLIC = 'S' AND "
ElseIf MV_PAR14 == 2
	cWhere2 += " SF4.F4_DUPLIC = 'N' AND "
EndIf
If MV_PAR09 == 2
	cWhere2 += " SC6.C6_BLQ <> 'R ' AND "
Endif
cWhere2 += "%"   

oReport:Section(2):BeginQuery()	
BeginSql Alias cSC5Tmp

SELECT A1_NOME,A1_MUN %Exp:cCampos%
FROM %Table:SC5% SC5, %Table:SA1% SA1
WHERE SC5.C5_FILIAL = %xFilial:SC5%
	AND SC5.%notdel%
	AND SC5.C5_CLIENTE >= %Exp:MV_PAR05%  AND SC5.C5_CLIENTE <= %Exp:MV_PAR06%
	AND SC5.C5_LOJACLI >= %Exp:MV_PAR10% AND SC5.C5_LOJACLI <= %Exp:MV_PAR11%
	AND SC5.C5_EMISSAO >= %Exp:Dtos(MV_PAR01)% AND SC5.C5_EMISSAO <= %Exp:Dtos(MV_PAR02)%
	AND SC5.C5_TIPO NOT IN ('D','B')
	AND %Exp:cWhere%
	AND SA1.A1_FILIAL = %xFilial:SA1%
	AND SA1.A1_COD = SC5.C5_CLIENTE
	AND SA1.A1_LOJA = SC5.C5_LOJACLI
	AND SA1.%notdel%
	AND
	(SELECT SUM(C6_VALOR) 
	FROM %Table:SC6% SC6, %Table:SF4% SF4
	WHERE SC6.C6_FILIAL = %xFilial:SC6%
		AND SC6.C6_NUM = SC5.C5_NUM
		AND SF4.F4_FILIAL = %xFilial:SF4%
		AND SF4.F4_CODIGO = SC6.C6_TES
		%Exp:cWhere2%
		SC6.%notdel%
		AND SF4.%notdel%) > 0
EndSql 
oReport:Section(2):EndQuery(/*Array com os parametros do tipo Range*/)	

oReport:SetMeter(SC6->(LastRec()))
DbSelectArea(cSC5Tmp)
While (cSC5Tmp)->(!Eof())
	
	cPedTemp := (cSC5Tmp)->C5_NUM
	oReport:Section(3):BeginQuery()	
	BeginSql Alias cSC5Tmp2
		SELECT SUM(C6_VALOR) nTotPed
		  FROM %Table:SC6% SC6, %Table:SF4% SF4
	 	 WHERE SC6.C6_FILIAL = %xFilial:SC6%
		   AND SC6.C6_NUM = %Exp:cPedTemp%
		   AND SF4.F4_FILIAL = %xFilial:SF4%
		   AND SF4.F4_CODIGO = SC6.C6_TES
		   %Exp:cWhere2%
		   SC6.%notdel%
		   AND SF4.%notdel%
	EndSql 
	oReport:Section(3):EndQuery(/*Array com os parametros do tipo Range*/)	
	
	If (cSC5Tmp2)->nTotPed > 0
		For nJ := 1 to nVend
			cVend := aVend[nJ]
			cVendCh := (cSC5Tmp)->&cVend
			
			If !Empty(cVendCH) .And. cVendCh >= MV_PAR03 .And. cVendCh <= MV_PAR04
				RecLock("TRB",.t.)
				Replace TRB->VENDEDOR With cVendCH
				Replace TRB->NUMPED   With (cSC5Tmp)->C5_NUM
				Replace TRB->CLIENTE  With (cSC5Tmp)->C5_CLIENTE
				Replace TRB->EMISSAO  With (cSC5Tmp)->C5_EMISSAO
				Replace TRB->LOJA     With (cSC5Tmp)->C5_LOJACLI
				Replace TRB->MOEDA    With (cSC5Tmp)->C5_MOEDA
				Replace TRB->TOTPED   With (cSC5Tmp2)->nTotPed
				Replace TRB->CLINOME  With (cSC5Tmp)->A1_NOME
				Replace TRB->CLIMUN   With (cSC5Tmp)->A1_MUN
				TRB->(MsUnlock())
			Endif
		Next
	EndIf
	DbSelectArea(cSC5Tmp2)
	dbCloseArea()
	DbSelectArea(cSC5Tmp)
	oReport:IncMeter()
	(cSC5Tmp)->(DbSkip())
Enddo

DbSelectArea(cSC5Tmp)
DbCloseArea()
RestArea(aArea)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR600  ³ Autor ³ Wagner Xavier         ³ Data ³ 14.04.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Pedidos de Vendas por Vendedor/Cliente          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Matr600R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL CbTxt
LOCAL titulo := OemToAnsi(STR0001)	//"Pedidos Por Vendedor/Cliente"
LOCAL cDesc1 := OemToAnsi(STR0002)	//"Este relatorio ira emitir a relacao de Pedidos por"
LOCAL cDesc2 := OemToAnsi(STR0003)	//"ordem de Vendedor/Cliente."
LOCAL cDesc3 := ""
LOCAL CbCont,cabec1,cabec2,wnrel
LOCAL tamanho:="P"
LOCAL limite := 80
LOCAL cString:="SC5"
LOCAL lContinua := .T.
LOCAL nTotCli1,nTotVend1,nTotGer1,nContCli
LOCAL cCli,cVend,nTotPed1,cLoja
LOCAL aCampos := {},cVencCh
LOCAL aTam    := {}
Local aFieldsPD :={"A1_NOME","A3_NOME"}


PRIVATE aReturn := { STR0004, 1,STR0005, 1, 2, 1, "",1 }		//"Zebrado"###"Administracao"
PRIVATE nomeprog:="MATR600"
PRIVATE aLinha  := { },nLastKey := 0
PRIVATE cPerg   :="MTR600"

FATPDLoad(Nil, Nil, aFieldsPD)
pergunte("MTR600",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ MV_PAR01        	// A partir da data                      ³
//³ MV_PAR02        	// Ate a data                            ³
//³ MV_PAR03        	// Vendedor de                           ³
//³ MV_PAR04 	     	// Vendedor ate                          ³
//³ MV_PAR05	     	// Cliente de                            ³
//³ MV_PAR06        	// Cliente ate                           ³
//³ MV_PAR07        	// Salta pagina entre vendedores(Sim/Nao)³
//³ MV_PAR08        	// Qual Moeda                            ³
//³ MV_PAR09        	// Considera residuo                     ³
//³ MV_PAR10	     	// Loja Cliente de                       ³
//³ MV_PAR11        	// Loja Cliente ate                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="MATR600"            //Nome Default do relatorio em Disco

wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If  nLastKey==27
	dbClearFilter()
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey==27
	dbClearFilter()
	Return
Endif

RptStatus({|lEnd| C600Imp(@lEnd,wnRel,cString)},Titulo)
FATPDUnload()	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ C600IMP  ³ Autor ³ Rosane Luciane Chene  ³ Data ³ 09.11.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR600			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function C600Imp(lEnd,WnRel,cString)
LOCAL CbTxt
LOCAL titulo := OemToAnsi(STR0001)		//"Pedidos Por Vendedor/Cliente"
LOCAL CbCont,cabec1,cabec2
LOCAL tamanho:="P"
LOCAL lContinua := .T.
LOCAL nTotCli1,nTotVend1,nTotGer1,nContCli
LOCAL cCli,cVend,nTotPed1,cLoja
LOCAL aCampos := {}
LOCAL aTam:={}, aTamSXG, aCoord, aTam2
Local cExt
LOCAL cVendCh
LOCAL j, Suf
LOCAL nTotSC6 := 0 
LOCAL cEstoq := If( (MV_PAR13 == 1),"S",If( (MV_PAR13 == 2),"N","SN" ) )
LOCAL cDupli := If( (MV_PAR14 == 1),"S",If( (MV_PAR14 == 2),"N","SN" ) )
LOCAL nTotGerAux := 0
LOCAL aPedido := {}
Local cCLIObfus  :=""
Local cVENDObfus :=""
Local lCLIObfus  :=  FATPDIsObfuscate("A1_NOME") 
Local lVENDObfus :=  FATPDIsObfuscate("A3_NOME")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       :=80
m_pag    :=1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define array para arquivo de trabalho                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam:=TamSX3("C5_VEND1")
AADD(aCampos,{ "VENDEDOR","C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_NUM")
AADD(aCampos,{ "NUMPED"  ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C5_CLIENTE")
AADD(aCampos,{ "CLIENTE" ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C5_EMISSAO")
AADD(aCampos,{ "EMISSAO" ,"D",aTam[1],aTam[2] } )
aTam:=TamSX3("C5_LOJACLI")
AADD(aCampos,{ "LOJA"    ,"C",aTam[1],aTam[2] } )
AADD(aCampos,{ "MOEDA"   ,"N",1,0 } )
aTam:=TamSX3("F1_VALBRUT")
AADD(aCampos,{ "TOTPED"    ,"N",aTam[1],aTam[2] } )
aTam:=TamSX3("A1_NOME")
AADD(aCampos,{ "CLINOME"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("A1_MUN")
AADD(aCampos,{ "CLIMUN"   ,"C",aTam[1],aTam[2] } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aTamSXG := TamSXG("001")

titulo := STR0006 + " em "+GetMv("MV_MOEDA"+Str(MV_PAR08,1))   //"PED. DE VENDAS POR VENDEDOR/CLIENTE"
If aTamSXG[1] == aTamSXG[3]
	cabec1 := STR0007		//"CODIGO RAZAO SOCIAL             PRACA                  PEDIDO            TOTAL"
								// 999999 XXXXXXXXXXXXXXXXXXXXXX   XXXXXXXXXXXXXXXXXXXX   999999 9999999999999999
	aCoord := {07, 32, 55, 62}
	aTam2  := {22, 20}
Else
	cabec1 := STR0014		//"CODIGO               RAZAO SOCIAL         PRACA           PEDIDO           TOTAL"
								// 999999xxxxxxxxxxxxxx XXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXX 9999999999999999999999
								//           1         2         3         4         5         6         7
								// 01234567890123456789012345678901234567890123456789012345678901234567890123456789
	aCoord := {21, 42, 58, 64}
	aTam2  := {20, 15}
EndIf
cabec2 := ""

//-------------------------------------------------------------------
// Instancia tabela temporária.  
//-------------------------------------------------------------------

oTempTable	:= FWTemporaryTable():New( "TRB" )

//-------------------------------------------------------------------
// Atribui o  os índices.  
//-------------------------------------------------------------------
oTempTable:SetFields( aCampos )
oTempTable:AddIndex("1",{"VENDEDOR","CLIENTE","NUMPED"})
	
//------------------
//Criação da tabela
//------------------
oTempTable:Create()

GerTrabTop()

dbSelectArea("TRB")
dbGoTop()
nTotGer1 := 0
nTotGerAux := 0

SetRegua(RecCount())		// Total de Elementos da regua

While !Eof() .And. lContinua
	
	IF lEnd
		@PROW()+1,001 Psay STR0009		//"CANCELADO PELO OPERADOR"
		lContinua := .F.
		Exit
	Endif
	
	cVend := VENDEDOR
	dbSelectArea("SA3")
	dbSetOrder(1)
	dbSeek( xFilial() + cVend )
	
	IF li > 55
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,GetMv("MV_NORM"))
	EndIF
	
	If lVENDObfus .And. Empty(cVENDObfus)
		cVENDObfus:= FATPDObfuscate(SA3->A3_NOME)		
	EndIf
	@li,  0 Psay STR0010+ cVend + "  " + Iif(Empty(cVENDObfus), SA3->A3_NOME, cVENDObfus)//"VENDEDOR : "
	 
	
	li++
	dbSelectArea("TRB")
	nTotVend1 := 0
	
	While !Eof() .And. lContinua .And. VENDEDOR == cVend
		
		IF lEnd
			@PROW()+1,001 Psay STR0009		//"CANCELADO PELO OPERADOR"
			lContinua := .F.
			Exit
		Endif
	
		nTotCli1 := 0
		cCli := CLIENTE
		cLoja:= LOJA
		nContCli := 0
		While !Eof() .And. lContinua .And. VENDEDOR == cVend .And. CLIENTE == cCli .And. LOJA == cLoja
			
			IF lEnd
				@PROW()+1,001 Psay STR0009		//"CANCELADO PELO OPERADOR"
				lContinua := .F.
				EXIT
			ENDIF
			
			IncRegua()
			
			IF li > 55
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,GetMv("MV_NORM"))				   				
			EndIF
			
	
			nTotPed1:=xMoeda( TRB->TOTPED, TRB->MOEDA, MV_PAR08, TRB->EMISSAO )
	  

         	DbSelectArea("TRB")
			@li, 0 Psay TRB->CLIENTE + " "
			
	
			If lCLIObfus .And. Empty(cCLIObfus)
				cCLIObfus:= FATPDObfuscate(SubStr(CLINOME, 1, aTam2[1])) 
			EndIf
			@li, aCoord[1] Psay  Iif(Empty(cCLIObfus),SubStr(CLINOME, 1, aTam2[1]), cCLIObfus)
			@li, aCoord[2] Psay SubStr(CLIMUN,  1, aTam2[2])
			
	
			@li, aCoord[3] Psay NUMPED
			@li, aCoord[4] Psay nTotPed1	Picture tm(nTotPed1,16)
			li++
			nTotCli1 += nTotPed1
			nContCli++			

			If MV_PAR16 == 2
				If AScan(aPedido,{|x| x[1]+x[2]+x[3] == cCli+cLoja+TRB->NUMPED}) == 0
					AADD(aPedido,{cCli,cLoja,TRB->NUMPED})
					nTotGerAux += nTotPed1
				EndIf	
			EndIf		
			
			dbSkip()
			
		EndDO
		IF li > 55
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,GetMv("MV_NORM"))
		EndIF

		//-- Total por Cliente
		IF MV_PAR15 == 1 .And. CLIENTE+LOJA <> cCli+cLoja
			@li, 0         Psay STR0011+ cCli + cLoja		//"TOTAL CLIENTE   ---> "
			@li, aCoord[4] Psay nTotCli1	   	   Picture  tm(nTotCli1,16)
		EndIF
		nTotVend1 += nTotCli1
		If MV_PAR15 == 1
			li++
		EndIf
		dbSelectArea("TRB")
	End
	
	@li, 0         Psay STR0012+ cVend		//"TOTAL VENDEDOR  ---> "
	@li, aCoord[4] Psay nTotVend1		Picture tm(nTotVend1,16)
	If MV_PAR07 == 1
		li:=90
	Else
		li++
		@li,00 PSay Repl("-",80)
		li++
	Endif
	
	If MV_PAR16 == 2
		nTotGer1 += nTotGerAux
		nTotGerAux := 0
	Else	
		nTotGer1 += nTotVend1
	EndIf	
		
	dbSelectArea("TRB")
EndDo

IF li != 80
	If MV_PAR07 # 1
		@li,  0        Psay STR0013	//"T O T A L  G E R A L : "
		@li, aCoord[4] Psay nTotGer1	Picture tm(nTotGer1,16)
	Endif
	roda(cbcont,cbtxt,"P")
EndIF

If( valtype(oTempTable) == "O")
	oTempTable:Delete()
	freeObj(oTempTable)
	oTempTable := nil
EndIf
dbSelectArea("SC5")
dbSetOrder(1)

dbSelectArea("SA3")
dbClearFilter()
dbSetOrder(1)

If aReturn[5] == 1
	Set Printer TO
	dbCommitall()
	ourspool(wnrel)
Endif

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GravaTrab ³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava Arquivo de Trabalho                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nEl - Ordem do Vendedor                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR600                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static FuncTion GravaTrab(nEl)
Local suf := "SC5->C5_VEND" + Str(nEl,1)
RecLock("TRB",.t.)
Replace VENDEDOR With &suf
Replace NUMPED   With SC5->C5_NUM
Replace CLIENTE  With SC5->C5_CLIENTE
Replace EMISSAO  With SC5->C5_EMISSAO
Replace LOJA     With SC5->C5_LOJACLI
Replace MOEDA    With SC5->C5_MOEDA
MsUnlock()
dbSelectArea("SC5")
Return .T.

Static Function GerTrabTop()
Local aArea:=GetArea()
Local aStruSC5:= {}
Local nJ      := 0
Local nLoop   := 0
Local cSC5Tmp := GetNextAlias()
Local cSC5Tmp2:= GetNextAlias()
Local cQuerTmp := ""				//Utilizada para adequar a query segundo necessidades de bancos Sybase
Local cQuery  := ""
Local cQuery2 := ""
Local cVendCh := ""
Local cSuf    := ""
Local nVend	  := Fa440CntVen()
Local cVend   := ""
Local cCond   := ""
Local cPedido := ""
Local aVend   := {}

aStruSC5  := SC5->(dbStruct())

cQuery:="SELECT "
cSuf:="0"
For nJ:=1 to nVend
	cSuf := Soma1(cSuf)
	cVend := "C5_VEND"+cSuf
	If SC5->(FieldPos(cVend))>0
		Aadd(aVend,cVend)
		cQuery+=cVend+","
		If !Empty(cCond)
			cCond+="or "
		Endif
		cCond+="("+cVend+"<>' ' and "+cVend+">='"+MV_PAR03+"' and "+cVend+"<='"+MV_PAR04+"') "
	Endif
Next	                                                        
For nJ := 1 To SC5->(FCount())
	If nJ > 1
		cQuery += ", "
	EndIf		
	cQuery += SC5->(FieldName(nJ))
Next      
cQuery+=",A1_NOME,A1_MUN "
cQuery+="FROM "+RetSqlName("SC5")+" SC5, "+RetSqlName("SA1")+" SA1 "
cQuery+="WHERE "
cQuery+="SC5.C5_FILIAL='"+xFilial("SC5")+"' "
cQuery+="AND SC5.D_E_L_E_T_=' ' "
cQuery+="AND SC5.C5_CLIENTE>='"+MV_PAR05+"' AND SC5.C5_CLIENTE<='"+MV_PAR06+"' "
cQuery+="AND SC5.C5_LOJACLI>='"+MV_PAR10+"' AND SC5.C5_LOJACLI<='"+MV_PAR11+"' "
cQuery+="AND SC5.C5_EMISSAO>='"+Dtos(MV_PAR01)+"' AND SC5.C5_EMISSAO<='"+Dtos(MV_PAR02)+"' "
cQuery+="AND SC5.C5_TIPO NOT IN ('D','B') "
cQuery+="AND ("+cCond+") "
cQuery+="AND SA1.A1_FILIAL='"+xFilial("SA1")+"' "	
cQuery+="AND SA1.A1_COD=SC5.C5_CLIENTE "
cQuery+="AND SA1.A1_LOJA=SC5.C5_LOJACLI "
cQuery+="AND SA1.D_E_L_E_T_=' ' "
	
cQuery+="AND ("

cQuery2:="SELECT SUM(C6_VALOR) nTotPed FROM "+RetSqlName("SC6")+" SC6,"+RetSqlName("SF4")+" SF4 "
cQuery2+="WHERE "
cQuery2+="SC6.C6_FILIAL='"+xFilial("SC6")+"' AND "
cQuery2+="SC6.C6_NUM=C5_NUM AND "
cQuery2+="SF4.F4_FILIAL='"+xFilial("SF4")+"' AND "
cQuery2+="SF4.F4_CODIGO=SC6.C6_TES  AND "
If cPaisLoc == "BRA"
	If MV_PAR12 == 1
		cQuery2 += "SF4.F4_AGREG<>'N' AND "
	Endif
Endif
If MV_PAR13 == 1
	cQuery2 += "SF4.F4_ESTOQUE = 'S' AND "
ElseIf MV_PAR13 == 2
	cQuery2 += "SF4.F4_ESTOQUE = 'N' AND "
EndIf
If MV_PAR14 == 1
	cQuery2 += "SF4.F4_DUPLIC = 'S' AND "
ElseIf MV_PAR14 == 2
	cQuery2 += "SF4.F4_DUPLIC = 'N' AND "
EndIf
cQuery2 += "SF4.D_E_L_E_T_=' ' AND "		
If MV_PAR09==2
	cQuery2+="SC6.C6_BLQ<>'R ' AND "
Endif
cQuery2+="SC6.D_E_L_E_T_=' ' "

cQuerTmp := STRTRAN(cQuery2,"nTotPed","")
cQuerTmp := STRTRAN(cQuerTmp,"C5_NUM","SC5.C5_NUM")

cQuery += cQuerTmp + ") > 0 "

cQuery:=ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cSC5Tmp)

For nLoop := 1 To Len(aStruSC5)
	If aStruSC5[nLoop][2] <> "C" .and. FieldPos(aStruSC5[nLoop][1]) > 0
		TcSetField(cSC5Tmp,aStruSC5[nLoop][1],aStruSC5[nLoop][2],aStruSC5[nLoop][3],aStruSC5[nLoop][4])
	EndIf
Next nLoop

SetRegua(SC6->(LastRec()))
DbSelectArea(cSC5Tmp)
While (cSC5Tmp)->(!Eof())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa a validacao do filtro do usuario           	        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(aReturn[7]) .And. !&(aReturn[7])
		(cSC5Tmp)->(DbSkip())
		Loop
	EndIf	
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,StrTran(cQuery2,"=C5_NUM","='"+(cSC5Tmp)->C5_NUM+"'")),cSC5Tmp2)
	If (cSC5Tmp2)->nTotPed>0
		For nJ:=1 to nVend
			cVend := aVend[nJ]
			cVendCh := (cSC5Tmp)->&cVend
			If !Empty(cVendCH) .And. cVendCh >= MV_PAR03 .And. cVendCh <= MV_PAR04
				RecLock("TRB",.t.)
				Replace TRB->VENDEDOR With cVendCH
				Replace TRB->NUMPED   With (cSC5Tmp)->C5_NUM
				Replace TRB->CLIENTE  With (cSC5Tmp)->C5_CLIENTE
				Replace TRB->EMISSAO  With (cSC5Tmp)->C5_EMISSAO
				Replace TRB->LOJA     With (cSC5Tmp)->C5_LOJACLI
				Replace TRB->MOEDA    With (cSC5Tmp)->C5_MOEDA
				Replace TRB->TOTPED   With (cSC5Tmp2)->nTotPed
				Replace TRB->CLINOME  With (cSC5Tmp)->A1_NOME
				Replace TRB->CLIMUN   With (cSC5Tmp)->A1_MUN
				TRB->(MsUnlock())
			Endif
		Next
	EndIf
	DbSelectArea(cSC5Tmp2)
	dbCloseArea()
	DbSelectArea(cSC5Tmp)
	IncRegua()
	(cSC5Tmp)->(DbSkip())
Enddo

DbSelectArea(cSC5Tmp)
DbCloseArea()
RestArea(aArea)
Return

//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDLoad
    @description
    Inicializa variaveis com lista de campos que devem ser ofuscados de acordo com usuario.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cUser, Caractere, Nome do usuário utilizado para validar se possui acesso ao 
        dados protegido.
    @param aAlias, Array, Array com todos os Alias que serão verificados.
    @param aFields, Array, Array com todos os Campos que serão verificados, utilizado 
        apenas se parametro aAlias estiver vazio.
    @param cSource, Caractere, Nome do recurso para gerenciar os dados protegidos.
    
    @return cSource, Caractere, Retorna nome do recurso que foi adicionado na pilha.
    @example FATPDLoad("ADMIN", {"SA1","SU5"}, {"A1_CGC"})
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDLoad(cUser, aAlias, aFields, cSource)
	Local cPDSource := ""

	If FATPDActive()
		cPDSource := FTPDLoad(cUser, aAlias, aFields, cSource)
	EndIf

Return cPDSource

//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDUnload
    @description
    Finaliza o gerenciamento dos campos com proteção de dados.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cSource, Caractere, Remove da pilha apenas o recurso que foi carregado.
    @return return, Nulo
    @example FATPDUnload("XXXA010") 
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDUnload(cSource)    

    If FATPDActive()
		FTPDUnload(cSource)    
    EndIf

Return Nil

//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDIsObfuscate
    @description
    Verifica se um campo deve ser ofuscado, esta função deve utilizada somente após 
    a inicialização das variaveis atravez da função FATPDLoad.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cField, Caractere, Campo que sera validado
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado
    @return lObfuscate, Lógico, Retorna se o campo será ofuscado.
    @example FATPDIsObfuscate("A1_CGC",Nil,.T.)
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDIsObfuscate(cField, cSource, lLoad)
    
	Local lObfuscate := .F.

    If FATPDActive()
		lObfuscate := FTPDIsObfuscate(cField, cSource, lLoad)
    EndIf 

Return lObfuscate

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @sample FATPDObfuscate("999999999","U5_CEL")
    @author Squad CRM & Faturamento
    @since 04/12/2019
    @version P12
    @param xValue, (caracter,numerico,data), Valor que sera ofuscado.
    @param cField, caracter , Campo que sera verificado.
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado

    @return xValue, retorna o valor ofuscado.
/*/
//-----------------------------------------------------------------------------
Static Function FATPDObfuscate(xValue, cField, cSource, lLoad)
    
    If FATPDActive()
		xValue := FTPDObfuscate(xValue, cField, cSource, lLoad)
    EndIf

Return xValue   

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    Função que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive