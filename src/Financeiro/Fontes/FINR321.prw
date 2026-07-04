/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR321.CH"
#include "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR321  ³ Autor ³ Mauricio Pequim Jr    ³ Data ³ 27/02/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Posi‡„o Geral da Cobran‡a.								  			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FINR321()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FINR321()

Local oReport
Local aArea		  := GetArea()
Local cPerg       := "FIN320"		// Nome do grupo de perguntas
PRIVATE aReturn := { OemToAnsi(STR0003), 1,OemToAnsi(STR0004), 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"

If TRepInUse()
	oReport := ReportDef( cPerg )
	oReport:PrintDialog()
Else
	Return U_FINR321R3( ) // Executa versão anterior do fonte
Endif

RestArea( aArea )  

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef ³ Autor ³ Mauricio Pequim Jr ³ Data ³ 27/02/09   ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPC1 - Grupo de perguntas do relatorio                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Planejamento e Controle Orcamentario                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef( cPerg )

Local cReport	:= "FINR321" // Nome do relatorio
Local cTitulo	:= STR0005	 // Titulo do relatorio -> "Posicao Geral do Contas a Receber"
Local cDescri	:= STR0001 +" "+ STR0002// Descricao do relatorio ->"Este programa ir  emitir a posi‡„o geral da cobran‡a no mˆs"
									//"referente a data base do sistema."
Local oReport
Local oSection1        
Local oSection2

Pergunte( cPerg, .F. )
                   
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
//"Este relatorio irá apresentar a posiçäo geral da cobrança no mês referente a data base do sistema."
oReport  := TReport():New( cReport , cTitulo, cPerg, { |oReport| U_FINR321Imp( oReport ) }, cDescri ) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0059, {"SA1"}, )//"Dados do Cliente"
TRCell():New( oSection1, "A1_COD"	,"SA1",,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "A1_LOJA"	,"SA1",,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "A1_NOME"	,"SA1",,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection1:SetNoFilter({"SA1"})
oSection1:HideHeader()
oSection1:Hide()

oSection2 := TRSection():New( oSection1, STR0060, {"SE1","SED"}, ) // "Faturamento (no mes)"
TRCell():New( oSection2, "CelDesc"	,,STR0058					,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)	// Descricao
TRCell():New( oSection2, "CelValor"	,,STR0054+GetMv("MV_SIMB1"),/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor
TRCell():New( oSection2, "CelQuant"	,,STR0055					,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)	// Quantidade

//Faz o alinhamento do cabecalho das celulas
oSection2:Cell("CelValor"):SetHeaderAlign("RIGHT")
oSection2:Cell("CelQuant"):SetHeaderAlign("RIGHT")

oSection3 := TRSection():New( oSection1, STR0061, {"SE1","SED"} )	// "Valores Baixados"
TRCell():New( oSection3, "CelDesc"	,,STR0058,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Descricao
TRCell():New( oSection3, "CelValor"	,,STR0054+GetMv("MV_SIMB1"),/*Picture*/,/*lPixel*/,/*{|| code-block de impressao }*/)					// Valor
TRCell():New( oSection3, "CelQuant"	,,STR0055,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Quantidade

oSection4 := TRSection():New( oSection1, STR0062, {"SE1","SED"} )	// "Titulos a vencer"
TRCell():New( oSection4, "CelDesc"	,,STR0058,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Descricao
TRCell():New( oSection4, "CelValor"	,,STR0054+GetMv("MV_SIMB1"),/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Valor
TRCell():New( oSection4, "CelQuant"	,,STR0055,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Quantidade

oSection5 := TRSection():New( oSection1, STR0063, {"SE1","SED"} )	// "Titulos vencidos"
TRCell():New( oSection5, "CelDesc"	,,STR0058,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Descricao
TRCell():New( oSection5, "CelValor"	,,STR0054+GetMv("MV_SIMB1"),/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Valor
TRCell():New( oSection5, "CelQuant"	,,STR0055,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Quantidade

oSection6 := TRSection():New( oSection1, STR0064, {"SE1","SED"} )	// "Recebimento e notas de credito"
TRCell():New( oSection6, "CelDesc"	,,STR0058,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Descricao
TRCell():New( oSection6, "CelValor"	,,STR0054+GetMv("MV_SIMB1"),/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Valor
TRCell():New( oSection6, "CelQuant"	,,STR0055,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Quantidade

oSection7 := TRSection():New( oSection1, STR0065, {"SE1","SED"} )	// "Distribuicao da cobranca"
TRCell():New( oSection7, "CelDesc"	,,STR0058,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Descricao
TRCell():New( oSection7, "CelValor"	,,STR0054+GetMv("MV_SIMB1"),/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Valor
TRCell():New( oSection7, "CelQuant"	,,STR0055,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Quantidade

oSection8 := TRSection():New( oSection1, STR0066, {"SE1","SED"} )	// "Por tipo de titulo"
TRCell():New( oSection8, "CelDesc"	,,STR0058,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Descricao
TRCell():New( oSection8, "CelValor"	,,STR0054+GetMv("MV_SIMB1"),/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Valor
TRCell():New( oSection8, "CelQuant"	,,STR0055,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Quantidade

oSection9 := TRSection():New( oSection1, STR0067, {"SE1","SED"} )	// "Carteira de pedidos a entregar"
TRCell():New( oSection9, "CelDesc"	,,STR0058,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Descricao
TRCell():New( oSection9, "CelValor"	,,STR0054+GetMv("MV_SIMB1"),/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Valor
TRCell():New( oSection9, "CelQuant"	,,STR0055,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Quantidade

oSection10 := TRSection():New( oSection1, STR0068, {"SE1","SED"} )	// "Prazos medios e quociente de atraso"
TRCell():New( oSection10, "CelDesc"	,,STR0058,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Descricao
TRCell():New( oSection10, "CelValor"	,,STR0054+GetMv("MV_SIMB1"),/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Valor
TRCell():New( oSection10, "CelQuant"	,,STR0055,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Quantidade

Return oReport                   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ FINR321Imp ³Autor³ Mauricio Pequim Jr ³ Data ³ 27/02/09    ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPO1 - Objeto TReport do relatorio                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR321Imp( oReport )
Local oCliente  := oReport:Section(1)
Local oSection1 := oReport:Section(1):Section(1) 
Local oSection2 := oReport:Section(1):Section(1)
Local oSection3 := oReport:Section(1):Section(1)
Local oSection4 := oReport:Section(1):Section(1)
Local oSection5 := oReport:Section(1):Section(1)
Local oSection6 := oReport:Section(1):Section(1)
Local oSection7 := oReport:Section(1):Section(1)
Local oSection8 := oReport:Section(1):Section(1)
Local oSection9 := oReport:Section(1):Section(1)
Local nLinha	:= 0
Local aVal		:= {}
Local aValor	:= {}
Local aSitua	:= {}
Local nX			:= 0
Local nMeter	:= 0          
Local cFiltSE1 := oReport:Section(1):GetAdvplExp("SE1")
Local cFiltSED := oReport:Section(1):GetAdvplExp("SED")

aVal := FA321Calc(cFiltSE1,cFiltSED,aSitua)

aADD(aValor,{STR0010,aVal[1,1]+aVal[2,1],aVal[1,2]+aVal[2,2]}) 	//"FATURAMENTO (no mes)"
aADD(aValor,{STR0011,aVal[1,1]			 ,aVal[1,2]	}) 				//"A Vista"
aADD(aValor,{STR0012,aVal[2,1]			 ,aVal[2,2]	}) 				//"A Prazo"

aADD(aValor,{STR0051,""					 ,""		}) 				//"VALORES BAIXADOS"
aADD(aValor,{STR0013,aVal[40,1]			 ,""		}) 				//"RECEBIDO"
aADD(aValor,{STR0014,aVal[41,1]			 ,""		}) 				//"TAXA DE PERMANENCIA"
aADD(aValor,{STR0015,aVal[42,1]			 ,""		}) 				//"Multa"
aADD(aValor,{STR0016,aVal[43,1]			 ,""		}) 				//"CORRECAO"
aADD(aValor,{STR0017,aVal[44,1]			 ,""		}) 				//"DESCONTO"
aADD(aValor,{STR0018,aVal[45,1]			 ,""		}) 				//"ORIGINAL"

//"TITULOS A VENCER"
aADD(aValor,{STR0019,(aVal[39,1]+aVal[7,1]+aVal[8,1]+aVal[9,1]+aVal[10,1])  ,(aVal[39,2]+aVal[7,2]+aVal[8,2]+aVal[9,2]+aVal[10,2])}) 
aADD(aValor,{STR0052,aVal[39,1]			 ,aVal[39,2]	}) 				//"Ate 15 Dias"
aADD(aValor,{STR0053,aVal[07,1]    		 ,aVal[07,2]	}) 				//"De 16 a 30 dias"
aADD(aValor,{STR0023,aVal[08,1]    		 ,aVal[08,2]	}) 				//"De 31 a 60 dias"
aADD(aValor,{STR0024,aVal[09,1]    		 ,aVal[09,2]	}) 				//"De 61 a 90 dias"
aADD(aValor,{STR0025,aVal[10,1]   		 ,aVal[10,2]	}) 				//"Acima de 90 Dias

//"TITULOS VENCIDOS"
aADD(aValor,{STR0026,(aVal[38,1]+aVal[3,1]+aVal[4,1]+aVal[5,1]+aVal[6,1])  ,(aVal[38,2]+aVal[3,2]+aVal[4,2]+aVal[5,2]+aVal[6,2])}) 
aADD(aValor,{STR0052,aVal[38,1]			 ,aVal[38,2]	}) 				//"Ate 15 Dias"
aADD(aValor,{STR0053,aVal[03,1]    		 ,aVal[03,2]	}) 				//"De 16 a 30 dias"
aADD(aValor,{STR0023,aVal[04,1]    		 ,aVal[04,2]	}) 				//"De 31 a 60 dias"
aADD(aValor,{STR0024,aVal[05,1]    		 ,aVal[05,2]	}) 				//"De 61 a 90 dias"
aADD(aValor,{STR0025,aVal[06,1]   		 ,aVal[06,2]	}) 				//"Acima de 90 Dias

aADD(aValor,{STR0020,aVal[24,1]   		 ,aVal[24,2]	}) 				//"Recebimento Antecipado"
aADD(aValor,{STR0021,aVal[36,1]			 ,aVal[36,2]	}) 				//"Notas de Credito"

aADD(aValor,{STR0027,""					 ,""			}) 				//"DISTRIBUICAO DA COBRANCA"
For nX := 1 to Len (aSitua)
	//Estrutura de aSitua
	//[1] - Codigo da situacao de Cobranca
	//[2] - Descricao da situacao de cobranca
	//[3] - Valor (a ser alimentado posteriormente)
	//[4] - Quantidade de titulos (a ser alimentado posteriormente)
	aADD(aValor,{aSitua[nX,2],aSitua[nX,3],aSitua[nX,4]	}) 
Next

aADD(aValor,{STR0036,""					 ,""			}) 				//"POR TIPO DE TITULO"
aADD(aValor,{STR0037,aVal[11,1]			 ,aVal[11,2]	}) 				//"Duplicatas"
aADD(aValor,{STR0038,aVal[12,1]			 ,aVal[12,2]	}) 				//"Notas Fiscais"
aADD(aValor,{STR0039,aVal[13,1]			 ,aVal[13,2]	}) 				//"Cheques Pre-Datados"
aADD(aValor,{STR0040,aVal[14,1]			 ,aVal[14,2]	}) 				//"Carnet De Pagamento"
aADD(aValor,{STR0041,aVal[15,1]			 ,aVal[15,2]	}) 				//"Impostos"
aADD(aValor,{STR0042,aVal[35,1]			 ,aVal[35,2]	}) 				//"Abatimentos"
aADD(aValor,{STR0043,aVal[16,1]			 ,aVal[16,2]	}) 				//"Outros"

//"CARTEIRA DE PEDIDOS A ENTREGAR"
aADD(aValor,{STR0044,(aVal[17,1]+aVal[18,1]+aVal[19,1]+aVal[20,1]+aVal[21,1])  ,(aVal[17,2]+aVal[18,2]+aVal[19,2]+aVal[20,2]+aVal[21,2])}) 
aADD(aValor,{STR0045,aVal[21,1]			 ,aVal[21,2]	}) 				//"Itens de Pedidos Vencidos"
aADD(aValor,{STR0022,aVal[17,1]    		 ,aVal[17,2]	}) 				//"Ate 30 Dias"
aADD(aValor,{STR0023,aVal[18,1]    		 ,aVal[18,2]	}) 				//"De 31 a 60 dias"
aADD(aValor,{STR0024,aVal[19,1]    		 ,aVal[19,2]	}) 				//"De 61 a 90 dias"
aADD(aValor,{STR0025,aVal[20,1]   		 ,aVal[20,2]	}) 				//"Acima de 90 Dias

aADD(aValor,{STR0047,"" 	,(aVal[22,1]/aVal[22,2])	}) 				//"Prazo Medio Absoluto"
aADD(aValor,{STR0048,""  	,(aVal[23,1]/aVal[23,2])	}) 				//"Prazo Medio Ponderado"
aADD(aValor,{STR0049,""  	,(((aVal[38,1]+aVal[3,1]+aVal[4,1]+aVal[5,1]+aVal[6,1])/aVal[34,1]))*100})	//"Quociente De Atraso"

oReport:SetMeter(Len(aValor))       

oCliente:Init()
oCliente:PrintLine()
oCliente:Finish()

// primeira secao  --> FATURAMENTO
oSection1:Init()                 
oSection1:Cell("CelDesc" ):SetBlock( { || aValor[nLinha,1] } )
oSection1:Cell("CelValor"):SetBlock( { || aValor[nLinha,2] } )
oSection1:Cell("CelQuant"):SetBlock( { || aValor[nLinha,3] } )
oSection1:Cell("CelValor"):SetPicture(TM(aValor[1,2],18, MsDecimais(mv_par09)))
For nLinha := 1 to 3
	oReport:IncMeter()
	oSection1:PrintLine()
Next 
oSection1:Finish()      

// segunda secao --> VALORES BAIXADOS
oSection2:Init()     
oSection2:SetHeaderSection(.F.)
oReport:ThinLine()
oSection2:Cell("CelDesc" ):SetBlock( { || aValor[nLinha,1] } )
oSection2:Cell("CelValor"):SetBlock( { || aValor[nLinha,2] } )
oSection2:Cell("CelQuant"):SetBlock( { || aValor[nLinha,3] } )   
For nLinha := 4 to 10
	If nLinha == 4
		oSection1:Cell("CelValor"):SetPicture("") //Não deve utilizar picture no titulo da secao que n imprime valores
	ElseIf nLinha == 5
		oSection1:Cell("CelValor"):SetPicture(PesqPict("SE5","E5_VALOR",oSection1:Cell("CelValor"):nSize,mv_par09))
	EndIf
	oReport:IncMeter()
	oSection2:PrintLine()
Next 
oSection2:Finish()      

// terceira secao --> TITULOS A VENCER
oSection3:Init()
oReport:ThinLine()
oSection3:Cell("CelDesc" ):SetBlock( { || aValor[nLinha,1] } )
oSection3:Cell("CelValor"):SetBlock( { || aValor[nLinha,2] } )
oSection3:Cell("CelQuant"):SetBlock( { || aValor[nLinha,3] } )
oSection3:Cell("CelValor"):SetPicture(PesqPict("SE5","E5_VALOR",oSection3:Cell("CelValor"):nSize,mv_par09))
For nLinha := 11 to 16
	oReport:IncMeter()
	oSection3:PrintLine()
Next 
oSection3:Finish()      

// quarta secao --> TITULOS VENCIDOS
oSection4:Init()
oReport:ThinLine()
oSection4:Cell("CelDesc" ):SetBlock( { || aValor[nLinha,1] } )
oSection4:Cell("CelValor"):SetBlock( { || aValor[nLinha,2] } )
oSection4:Cell("CelQuant"):SetBlock( { || aValor[nLinha,3] } )
oSection4:Cell("CelValor"):SetPicture(PesqPict("SE5","E5_VALOR",oSection4:Cell("CelValor"):nSize,mv_par09))
For nLinha := 17 to 22
	oReport:IncMeter()
	oSection4:PrintLine()
Next 
oSection4:Finish()      

// quinta secao --> RECEBIMENTO ANTECIPADO E NOTAS DE CREDITO
oSection5:Init()
oReport:ThinLine()
oSection5:Cell("CelDesc" ):SetBlock( { || aValor[nLinha,1] } )
oSection5:Cell("CelValor"):SetBlock( { || aValor[nLinha,2] } )
oSection5:Cell("CelQuant"):SetBlock( { || aValor[nLinha,3] } )
oSection5:Cell("CelValor"):SetPicture(PesqPict("SE5","E5_VALOR",oSection5:Cell("CelValor"):nSize,mv_par09))
For nLinha := 23 to 24
	oReport:IncMeter()
	oSection5:PrintLine()
Next 
oSection5:Finish()      

// sexta secao -->DISTRIBUICAO DA COBRANCA
oSection6:Init()
oReport:ThinLine()
oSection6:Cell("CelDesc" ):SetBlock( { || aValor[nLinha,1] } )
oSection6:Cell("CelValor"):SetBlock( { || aValor[nLinha,2] } )
oSection6:Cell("CelQuant"):SetBlock( { || aValor[nLinha,3] } )

nLinIni := 25
nLinFin := nLinIni+Len(aSitua)

For nLinha := nLinIni to nLinFin
	If nLinha == 25
		oSection6:Cell("CelValor"):SetPicture("") //Não deve utilizar picture no titulo da secao que n imprime valores
	ElseIf nLinha == 26
		oSection6:Cell("CelValor"):SetPicture(PesqPict("SE5","E5_VALOR",oSection6:Cell("CelValor"):nSize,mv_par09))
	EndIf
	oReport:IncMeter()
	oSection6:PrintLine()
Next 
oSection6:Finish()      

// sétima secao  --> POR TIPO DE TITULO
oSection7:Init()
oReport:ThinLine()
oSection7:Cell("CelDesc" ):SetBlock( { || aValor[nLinha,1] } )
oSection7:Cell("CelValor"):SetBlock( { || aValor[nLinha,2] } )
oSection7:Cell("CelQuant"):SetBlock( { || aValor[nLinha,3] } )

nLinIni := nLinFin+1
nLinFin := nLinIni+7
For nLinha := nLinIni to nLinFin
	If nLinha == nLinIni
		oSection7:Cell("CelValor"):SetPicture("") //Não deve utilizar picture no titulo da secao que n imprime valores
	ElseIf nLinha == nLinIni+1
		oSection7:Cell("CelValor"):SetPicture(PesqPict("SE5","E5_VALOR",oSection7:Cell("CelValor"):nSize,mv_par09))
	EndIf
	oReport:IncMeter()
	oSection7:PrintLine()
Next 
oSection7:Finish()      

// oitava secao  -->CARTEIRA DE PEDIDOS A ENTREGAR
oSection8:Init()
oReport:ThinLine()
oSection8:Cell("CelDesc" ):SetBlock( { || aValor[nLinha,1] } )
oSection8:Cell("CelValor"):SetBlock( { || aValor[nLinha,2] } )
oSection8:Cell("CelQuant"):SetBlock( { || aValor[nLinha,3] } )   
oSection8:Cell("CelValor"):SetPicture(PesqPict("SE5","E5_VALOR",oSection8:Cell("CelValor"):nSize,mv_par09))

nLinIni := nLinFin+1
nLinFin := nLinIni+5
For nLinha := nLinIni to nLinFin
	oReport:IncMeter()
	oSection8:PrintLine()
Next 
oSection8:Finish()      

// nona secao --> PRAZO MEDIO E QUOCIENTE DE ATRASO
oSection9:Init()
oReport:ThinLine()
oSection9:Cell("CelDesc" ):SetBlock( { || aValor[nLinha,1] } )
oSection9:Cell("CelValor"):SetBlock( { || aValor[nLinha,2] } )
oSection9:Cell("CelQuant"):SetBlock( { || aValor[nLinha,3] } )
oSection9:Cell("CelValor"):SetPicture("")
oSection9:Cell("CelQuant"):SetPicture("999.99")
nLinIni := nLinFin+1
nLinFin := nLinIni+2
For nLinha := nLinIni to nLinFin
	oReport:IncMeter()
	oSection9:PrintLine()
Next 
oSection9:Finish()      

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FINR321  ³ Autor ³ Paulo Boschetti       ³ Data ³ 05.06.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Posi‡„o Geral da Cobran‡a.                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR321(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR321R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local wnrel
Local cString:="SE1"
Local cDesc1 := STR0001 //"Este programa ir  emitir a posi‡„o geral da cobran‡a no mˆs"
Local cDesc2 := STR0002 //"referente a data base do sistema."
Local cDesc3 :=""
Local Tamanho := "P"
Local aPergs	:= {}
Local dOldDtBase := dDataBase

PRIVATE titulo
PRIVATE cabec1
PRIVATE cabec2 
PRIVATE aReturn := { OemToAnsi(STR0003), 1,OemToAnsi(STR0004), 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE nomeprog:="FINR321"
PRIVATE cPerg   :="FIN320"
PRIVATE nLastKey:= 0
PRIVATE nJuros  := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := OemToAnsi(STR0005)  //"Posicao Geral do Contas a Receber"
cabec1 := OemToAnsi(STR0006)+GetMv("MV_SIMB1")+OemToAnsi(STR0007)  //"                                             Valores ("###")            Quantidade"
cabec2 := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("FIN320",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                        ³
//³ mv_par01            // Imprime Por Filial ou Empresa.       ³
//³ mv_par02            // Nas baixas, Dt Baixa, Digit ou Dispo ³
//³ mv_par03            // Seleciona tipos ( Sim / Nao ).       ³
//³ mv_par04            // Prefixo inicial                      ³
//³ mv_par05            // Prefixo final                        ³
//³ mv_par06            // Considera Juros                      ³
//³ mv_par07            // Considera TES para Pedido Venda      ³
//³ mv_par08            // Considera data base                  ³
//³ mv_par09            // Qual moeda                           ³
//³ mv_par10            // Outras moedas                        ³
//³ mv_par11            // Considerar Abatimentos(Sim/Nao)      ³
//³ mv_par12            // Considerar Pedidos Vendas(Sim/Nao)   ³
//³ mv_par13            // Data Base									 ³
//³ mv_par14            // Tit. Emissao Futura 						 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="FINR321"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif
dDataBase := mv_par13 // Altera data base conforme parametro
RptStatus({|lEnd| Fa321Imp(@lEnd,wnRel,cString)},titulo)
dDataBase := dOldDtBase // Restaura Data base

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FINR321  ³ Autor ³ Paulo Boschetti       ³ Data ³ 05.06.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Posi‡„o Geral da Cobran‡a.                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FA321Imp(lEnd,wnRelm,Cstring)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Parametro 1 - lEnd    - A‡Æo do CodeBlock                  ³±±
±±³          ³ Parametro 2 - wnRel   - T¡tulo do relat¢rio                ³±±
±±³          ³ Parametro 3 - cString - Mensagem                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FA321Imp(lEnd,wnRel,cString)

Local CbCont
Local CbTxt
Local tamanho	:= "P"
Local nDecs		:= MsDecimais(mv_par09)
Local nTipoData:= 1
Local nX			:= 0
Local dOldDtBase := dDataBase
Local aVal 		:= {}
Local aSitua	:= {}
Local cFilterUser := aReturn[7]


//Tipo da data para a composicao do saldo via SaldoTit()
If mv_par02 == 1			// Data da baixa (E5_BAIXA)
	nTipoData := 1
ElseIf mv_par02 == 2 	//Data de Digitacao (E5_DTDIGIT)
	nTipoData := 3
Else							//Data de Disponibilidade (E5_DTDISPO)
	nTipoData := 2
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1
PRIVATE  cTipos := ""

//Calculo dos valores a serem demonstrados no relatorio
aVal := FA321Calc(cFilterUser,,aSitua)

IF li > 65
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
Endif

@Li ,  0 PSAY OemToAnsi(STR0010)  //"FATURAMENTO (no mes)"
@Li , 40 PSAY aVal[1,1]+aVal[2,1]    PICTURE TM(aVal[1,1]+aVal[2,1],18, nDecs)
@Li , 72 PSAY aVal[1,2]+aVal[2,2]    PICTURE "999999"
Li++
@Li ,  0 PSAY OemToAnsi(STR0011)  //"A Vista"
@Li , 40 PSAY aVal[1,1]	     	 PICTURE TM(aVal[1,1],18,nDecs)
@Li , 72 PSAY aVal[1,2]   	      PICTURE "999999"
Li++
@Li ,  0 PSAY OemToAnsi(STR0012)  //"A Prazo"
@Li , 40 PSAY aVal[2,1]	     	 PICTURE TM(aVal[2,1],18,nDecs)
@Li , 72 PSAY aVal[2,2]   	      PICTURE "999999"
Li++
@Li ,  0 PSAY REPLICATE("-",80) 
li++
@li,   0 PSAY OemToAnsi(STR0051)  //"VALORES BAIXADOS"
li++
@li,   0 PSAY OemToAnsi(STR0013)  //"Recebido"
@li,  40 PSAY aVal[40,1]			Picture PesqPict("SE5","E5_VALOR",18,mv_par09)
li++
@li,   0 PSAY OemToAnsi(STR0014)  //"Taxa Permanencia"
@li,  40 PSAY aVal[41,1]			Picture PesqPict("SE5","E5_VALOR",18,mv_par09)
li++
@li,   0 PSAY OemToAnsi(STR0015)  //"Multa"
@li,  40 PSAY aVal[42,1]			Picture PesqPict("SE5","E5_VALOR",18,mv_par09)
li++
@li,   0 PSAY OemToAnsi(STR0016)  //"Correcao"
@li,  40 PSAY aVal[43,1]			Picture PesqPict("SE5","E5_VALOR",18,mv_par09)
li++
@li,   0 PSAY OemToAnsi(STR0017)  //"Descontos"
@li,  40 PSAY aVal[44,1]			Picture PesqPict("SE5","E5_VALOR",18,mv_par09)
li++
@li,   0 PSAY OemToAnsi(STR0018)  //"Original"
@li,  40 PSAY aVal[45,1]			Picture PesqPict("SE5","E5_VALOR",18,mv_par09)
li++
@Li ,  0 PSAY REPLICATE("-",80) 
li++
@Li ,  0 PSAY OemToAnsi(STR0019)  //"TITULOS A VENCER"
@Li , 40 PSAY (aVal[39,1]+aVal[7,1]+aVal[8,1]+aVal[9,1]+aVal[10,1])             PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[39,2]+aVal[7,2]+aVal[8,2]+aVal[9,2]+aVal[10,2]               PICTURE "999999"
Li++
@Li ,  0 PSAY OemToAnsi(STR0052)  //"Ate 15 Dias"
@Li , 40 PSAY aVal[39,1]   PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[39,2]   PICTURE "999999"
Li++
@Li ,  0 PSAY OemToAnsi(STR0053)  //"De 16 a 30 Dias"
@Li , 40 PSAY aVal[7,1]    PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[7,2]    PICTURE "999999"
Li++
@Li ,  0 PSAY OemToAnsi(STR0023)  //"De 31 a 60 dias"
@Li , 40 PSAY aVal[8,1]    PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[8,2]    PICTURE "999999"
Li++
@Li ,  0 PSAY OemToAnsi(STR0024)  //"De 61 a 90 dias"
@Li , 40 PSAY aVal[9,1]    PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[9,2]    PICTURE "999999"
Li++
@Li ,  0 PSAY OemToAnsi(STR0025)  //"Acima de 90 Dias"
@Li , 40 PSAY aVal[10,1]   PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[10,2]   PICTURE "999999"
Li++
@Li ,  0 PSAY REPLICATE("-",80) 
Li++
@Li ,  0 PSAY OemToAnsi(STR0026)  //"TITULOS VENCIDOS"
@Li , 40 PSAY (aVal[38,1]+aVal[3,1]+aVal[4,1]+aVal[5,1]+aVal[6,1])    PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[38,2]+aVal[3,2]+aVal[4,2]+aVal[5,2]+aVal[6,2]    PICTURE "999999"
Li++
@Li ,  0 PSAY OemToAnsi(STR0052)  //"Ate 15 Dias"
@Li , 40 PSAY aVal[38,1]	PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[38,2]	PICTURE "999999"
Li++
@Li ,  0 PSAY OemToAnsi(STR0053)  //"De 16 a 30 Dias"
@Li , 40 PSAY aVal[3,1]	   PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[3,2]		PICTURE "999999"
Li++
@Li ,  0 PSAY OemToAnsi(STR0023)  //"De 31 a 60 dias"
@Li , 40 PSAY aVal[4,1]	   PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[4,2]   	PICTURE "999999"
Li++
@Li ,  0 PSAY OemToAnsi(STR0024)  //"De 61 a 90 dias"
@Li , 40 PSAY aVal[5,1]	   PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[5,2]		PICTURE "999999"
Li++
@Li ,  0 PSAY OemToAnsi(STR0025)  //"Acima de 90 Dias"
@Li , 40 PSAY aVal[6,1]		PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[6,2]		PICTURE "999999"
Li++
@Li ,  0 PSAY REPLICATE("-",80) 
li++
@Li ,  0 PSAY OemToAnsi(STR0020)   //"Recebimento Antecipado"
@Li , 40 PSAY aVal[24,1]   PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[24,2]   PICTURE "999999"
Li++
@Li ,  0 PSAY OemToAnsi(STR0021)  //"Notas de Credito"
@Li , 40 PSAY aVal[36,1]   PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[36,2]   PICTURE "999999"
Li++
@Li ,  0 PSAY REPLICATE("-",80) 
li++
@Li ,  0 PSAY OemToAnsi(STR0027)  //"DISTRIBUICAO DA COBRANCA"
Li++

For nX := 1 to Len(aSitua)
	@Li ,  0 PSAY aSitua[nX,2]		//Descricao da carteira de cobranca
	@Li , 40 PSAY aSitua[nX,3]	PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)	//Valor total da carteira
	@Li , 72 PSAY aSitua[nX,4]	PICTURE "999999"		//Numero de titulos da carteira 
	Li++
	IF li > 65
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
	Endif
Next

@Li ,  0 PSAY REPLICATE("-",80) 
Li++

IF li > 65
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
Endif

@Li ,  0 PSAY OemToAnsi(STR0036)  //"POR TIPO DE TITULO"
Li++
@Li ,  0 PSAY OemToAnsi(STR0037)  //"Duplicatas"
@Li , 40 PSAY aVal[11,1]	PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[11,2]	PICTURE "999999"
Li++

IF li > 65
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
Endif

@Li ,  0 PSAY OemToAnsi(STR0038)  //"Notas Fiscais"
@Li , 40 PSAY aVal[12,1]	PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[12,2]	PICTURE "999999"
Li++

IF li > 65
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
Endif

@Li ,  0 PSAY OemToAnsi(STR0039)  //"Cheques Pre-Datados"
@Li , 40 PSAY aVal[13,1]	PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[13,2]	PICTURE "999999"
Li++

IF li > 65
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
Endif

@Li ,  0 PSAY OemToAnsi(STR0040)  //"Carne De Pagamento"
@Li , 40 PSAY aVal[14,1]	PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[14,2]	PICTURE "999999"
Li++

IF li > 65
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
Endif

@Li ,  0 PSAY OemToAnsi(STR0041)  //"Impostos"
@Li , 40 PSAY aVal[15,1]	PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[15,2]			      PICTURE "999999"
Li++

IF li > 65
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
Endif

@Li ,  0 PSAY OemToAnsi(STR0042)  //"Abatimentos"
@Li , 40 PSAY aVal[35,1]        			PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[35,2]        			PICTURE "999999"
Li++

IF li > 65
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
Endif

@Li ,  0 PSAY OemToAnsi(STR0043)  //"Outros"
@Li , 40 PSAY aVal[16,1]				  	PICTURE PesqPict("SE5","E5_VALOR",18,mv_par09)
@Li , 72 PSAY aVal[16,2]					PICTURE "999999"
Li++
@Li ,  0 PSAY REPLICATE("-",80) 
Li++

IF li > 65
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
Endif

@Li ,  0 PSAY OemToAnsi(STR0044)  //"CARTEIRA DE PEDIDOS A ENTREGAR"
@Li , 43 PSAY aVal[17,1]+aVal[18,1]+aVal[19,1]+aVal[20,1]+aVal[21,1]  Picture PesqPict("SC6","C6_PRCVEN",16,mv_par09)
@Li , 72 PSAY aVal[17,2]+aVal[18,2]+aVal[19,2]+aVal[20,2]+aVal[21,2]  Picture "999999"
Li++

IF li > 65
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
Endif

@Li ,  0 PSAY OemToAnsi(STR0045)  //"Itens de Pedidos Vencidos"
@Li , 43 PSAY aVal[21,1]             PICTURE  PesqPict("SC6","C6_PRCVEN",16,mv_par09)
@Li , 72 PSAY aVal[21,2]             PICTURE  "999999"
Li++

IF li > 65
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
Endif

@Li ,  0 PSAY OemToAnsi(STR0022)  //"Ate 30 Dias"
@Li , 43 PSAY aVal[17,1]             PICTURE PesqPict("SC6","C6_PRCVEN",16,mv_par09)
@Li , 72 PSAY aVal[17,2]             PICTURE "999999"
Li++

IF li > 65
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
Endif

@Li ,  0 PSAY OemToAnsi(STR0023)  //"De 31 a 60 Dias"
@Li , 43 PSAY aVal[18,1]             PICTURE PesqPict("SC6","C6_PRCVEN",16,mv_par09)
@Li , 72 PSAY aVal[18,2]             PICTURE "999999"
Li++

IF li > 65
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
Endif

@Li ,  0 PSAY OemToAnsi(STR0024)  //"De 61 a 90 Dias"
@Li , 43 PSAY aVal[19,1]             PICTURE PesqPict("SC6","C6_PRCVEN",16,mv_par09)
@Li , 72 PSAY aVal[19,2]             PICTURE "999999"
Li++

IF li > 65
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
Endif

@Li ,  0 PSAY OemToAnsi(STR0025)  //"Acima De 90 Dias"
@Li , 43 PSAY aVal[20,1]             PICTURE PesqPict("SC6","C6_PRCVEN",16,mv_par09)
@Li , 72 PSAY aVal[20,2]             PICTURE "999999"
Li++
@Li ,  0 PSAY REPLICATE("-",80) 
Li++

IF li > 65
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
Endif

@Li ,  0 PSAY OemToAnsi(STR0047)  //"Prazo Medio Absoluto"
@Li , 72 PSAY (aVal[22,1]/aVal[22,2])   	      PICTURE "999.99"
Li++
@Li ,  0 PSAY OemToAnsi(STR0048)  //"Prazo Medio Ponderado"
@Li , 72 PSAY (aVal[23,1]/aVal[23,2])   	      PICTURE "999.99"
Li++
@Li ,  0 PSAY OemToAnsi(STR0049)  //"Quociente De Atraso"
@Li , 72 PSAY  (((aVal[38,1]+aVal[3,1]+aVal[4,1]+aVal[5,1]+aVal[6,1])/aVal[34,1]))*100 PICTURE "999.99"
Li++

Set Device To Screen
dbSelectArea("SE1")
dbSetOrder(1)
Set Filter to
dbSelectArea("SE5")
dbSetOrder(1)
Set Filter to

If aReturn[5] = 1
    Set Printer TO
    dbCommitAll()
    Ourspool(wnrel)
Endif
MS_FLUSH()

dDataBase := dOldDtBase // Restaura Data base
Static Function InSide(cTp)
Return (cTp$cTipos)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Fa321SALDO³ Autor ³ Alessandro Freire     ³ Data ³ 16.01.97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o saldo do item do pedido                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_Fa321SALDO()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Fa321SALDO()
Local nRetSaldo := 0


If (C6_QTDVEN-C6_QTDENT) > 0 .And. C6_BLQ != "R"
	If !Empty( SC6->C6_TES )
		dbSelectArea("SF4")
 		dbSetOrder(1)
		dbSeek( xFilial("SF4")+SC6->C6_TES )
		nRetSaldo := SC6->C6_PRCVEN * (SC6->C6_QTDVEN - SC6->C6_QTDENT)
		If mv_par07 == 1		// Verifica se ir  considerar o TES (F4_DUPLIC)
			nRetSaldo := 0
			If SF4->F4_DUPLIC == "S"
				nRetSaldo := SC6->C6_PRCVEN * (SC6->C6_QTDVEN - SC6->C6_QTDENT)
			Endif
		EndIf
	EndIf
EndIf
dbSelectArea("SC6")
Return(nRetSaldo)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³FA321Calc ³ Autor ³ Adrianne Furtado      ³ Data ³ 07.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Calculo dos valores do relatorio Posi‡„o Geral da Cobran‡a.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FA321Calc(cFiltSE1)                            				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FA321Calc(cFiltSE1,cFiltSED,aSitua)

Local CbCont
Local CbTxt
Local tamanho		:= "P"
Local aVal	 		:= Array(48,2)
Local dDataBaixa	:= CTOD("//")
Local dOldDtBase	:= dDataBase
Local cCondSC6		:= ""
Local cFiltro		:= "" 
Local cIndTmp		:= ""
Local cAliasTmp	:= ""
Local lAdto			:= .F.
Local nSaldo		:= 0
Local nDias			:= 0
Local nI				:= 0
Local nJ				:= 0
Local nSaldoAtu	:= 0
Local nFirst		:= 1
Local nFirst1		:= 1
Local nRecebido	:= 0
Local nValJuros	:= 0
Local nDesconto	:= 0
Local nCorrecao	:= 0
Local nMulta  		:= 0
Local nOriginal	:= 0
Local nValAbat		:= 0
Local nAbt			:= 0
Local nTipoData	:= 1
Local nMoedaBco	:= 1
Local nDecs			:= MsDecimais(mv_par09)

#IFDEF TOP
	Local nX			:= 0 
	Local cCondFil := "" 
	Local nIndex	:= ""
	Local cQuery	:= ""
#ELSE
	Local cArq		:= ""	
#ENDIF	

DEFAULT cFiltSE1 := ""
DEFAULT cFiltSED := ""

//Monta array com as situacoes de cobranca contidas no SX5
aSitua :=  Fr321Situa()

//Tipo da data para a composicao do saldo via SaldoTit()
If mv_par02 == 1			// Data da baixa (E5_BAIXA)
	nTipoData := 1
ElseIf mv_par02 == 2 	//Data de Digitacao (E5_DTDIGIT)
	nTipoData := 3
Else							//Data de Disponibilidade (E5_DTDISPO)
	nTipoData := 2
Endif

PRIVATE  cTipos := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se seleciona tipos para total faturamento         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par03 == 1
	finaTipos()
Endif

dbSelectArea("SE1")
dbSetOrder(1)
If mv_par01 == 1
	dbSeek(xFilial("SE1"))
Else 
	dbGotop()
Endif

//Inicializa os valores do array de impressao
For nI := 1 to Len(aVal)
	For nJ := 1 to 2
		aVal[nI,nJ] := 0
	Next nJ
Next nI

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtra APENAS os emitidos antes da database, pois este rela³
//³ torio pode ser retroativo.                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP
	IF TcSrvType() != "AS/400"
		aStru  := SE1->(dbStruct())
		cAliasTmp := "FINR321"
		cQuery := ""
		aEval(aStru,{|x| cQuery += ","+AllTrim(x[1])})
		cQuery := "SELECT "+SubStr(cQuery,2)
		cQuery +=         ",R_E_C_N_O_ RECNO "
		cQuery += "FROM "+RetSqlName("SE1")+ " SE1 "
		cQuery += "WHERE "
		If mv_par01 == 1
			cQuery += "SE1.E1_FILIAL ='"+xFilial("SE1")+"' AND "
		Endif	
		If mv_par14 == 2 //Nao considerar titulos com emissao futura
			cQuery += "SE1.E1_EMISSAO <= '"+Dtos(dDataBase)+"' AND "
		Endif	
		cQuery += "SE1.E1_PREFIXO >= '"+MV_PAR04+"' AND "	
		cQuery += "SE1.E1_PREFIXO <= '"+MV_PAR05+"' AND "
		If mv_par10 == 2 
			cQuery += "SE1.E1_MOEDA = "+Str(MV_PAR09,2)+" AND "
		Endif	
		cQuery += "SE1.D_E_L_E_T_=' ' "
   	
		cQuery := ChangeQuery(cQuery)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTmp,.T.,.T.)	
		For nX :=  1 To Len(aStru)
			If aStru[nX][2] <> "C"
				TcSetField(cAliasTmp,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
			EndIf
		Next nX
	Else
#ENDIF
		cFiltro := ""
		If Mv_par01 == 1
			cFiltro += "E1_FILIAL>='"+xFilial("SE1")+"'.And."
		Endif
		If MV_PAR14 == 2 //Nao considerar titulos com emissao futura
			cFiltro += "Dtos(E1_EMISSAO)<='"+Dtos(dDataBase)+"'.And."
		Endif	
		cFiltro += "E1_PREFIXO>='"+MV_PAR04+"'.And."	
		cFiltro += "E1_PREFIXO<='"+MV_PAR05+"'"
		If mv_par10 == 2 
			cFiltro += ".And.E1_MOEDA == "+Str(MV_PAR09,2)
		Endif	
		dbSelectArea("SE1")
		dbSetOrder(1)
		cIndTmp := CriaTrab(,.F.)
		dbGotop()
		cAliasTmp := "SE1"
#IFDEF TOP
	Endif
#ENDIF

dbSelectArea(cAliasTmp)

While !Eof()

	dbSelectArea(cAliasTmp)
   
	If mv_par03 == 1
		If !Inside(E1_TIPO)
			dbSkip()
			Loop
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro do usuario - SE1                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cFiltSE1).and.!(&cFiltSE1)
		dbSkip()
		Loop
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro do usuario - SED                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cFiltSED)                       
		SED->(DbSetOrder(1))
		SED->(MsSeek(xFilial()+SE1->E1_NATUREZ)) 
		If SED->(!&(cFiltSED))
			SE1->(DbSkip())		
			Loop
		Endif
	Endif		
		
	IF !Empty(E1_FATURA) .and. Substr(E1_FATURA,1,6) != "NOTFAT" .and. E1_DTFATUR <= dDataBase
		dbSkip()
		Loop
	Endif
		
	If mv_par01 == 1 .and. E1_FILIAL != xFilial("SE1")
		Exit
	EndIF
   
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Verifica se ‚ provis¢rio ou abatimento ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If E1_TIPO $ MVPROVIS+"/"+MVABATIM
    	If E1_TIPO $ MVABATIM	//Somo o valor caso seja abatimento 
      		If mv_par11 == 1  
				nAbt := IIF(dDatabase < E1_BAIXA, xMoeda(E1_VALOR,E1_MOEDA,MV_PAR09,,,If(cPaisLoc=="BRA",E1_TXMOEDA,0)), xMoeda(E1_SALDO,E1_MOEDA,MV_PAR09,,,If(cPaisLoc=="BRA",E1_TXMOEDA,0)))		// no resumo por tipo de titulos
				aVal[35,1] += nAbt
				aVal[35,2] += IIF(nAbt > 0,1,0)
			Endif
		Else            
        	aVal[16,1] += xMoeda(E1_SALDO,E1_MOEDA,MV_PAR09,,,If(cPaisLoc=="BRA",E1_TXMOEDA,0))
			aVal[16,2] += IIF(SE1->E1_SALDO > 0,1,0)
		Endif
		dbSkip()
		Loop
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula o faturamento baseado na data base/item 1 analise    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Month(E1_EMISSAO) == Month(dDatabase) .and. Year(E1_EMISSAO) == Year(dDataBase)
		If !(E1_TIPO $MV_CRNEG+"/"+MVRECANT)
			nDias := (E1_VENCREA - E1_EMISSAO)
			If nDias <= 1
				aVal[1,1] += xMoeda(E1_VALOR,E1_MOEDA,MV_PAR09,,,If(cPaisLoc=="BRA",E1_TXMOEDA,0))
				aVal[1,2] += 1
			Else
				aVal[2,1] += xMoeda(E1_VALOR,E1_MOEDA,MV_PAR09,,,If(cPaisLoc=="BRA",E1_TXMOEDA,0))
				aVal[2,2] += 1
			Endif
		Endif
	Endif
    
	nSaldoAtu := 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acumula titulos vencidos/vencer / Item 2 e 3 da analise      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	#IFDEF TOP
		IF TcSrvType() != "AS/400"
			// Posiciona SE2 ou SE1 para pegar o saldo do titulo correto
			SE1->(DbGoto((cAliasTmp)->RECNO))
		Endif	
	#ENDIF 

	If mv_par08 == 1 	// Considera Data Base

		//Seta a database para o parametro da pergunta
		dDataBase := mv_par13

		IF !Empty(SE1->E1_BAIXA) .and. IIF(mv_par02 == 1,(SE1->E1_SALDO == 0 .and. SE1->E1_BAIXA <= dDataBase),.F.)
			nSaldoAtu := 0
		Else
			nSaldoAtu := SaldoTit( 	E1_PREFIXO,;
										E1_NUM,;
										E1_PARCELA,;
										E1_TIPO,;
										E1_NATUREZ,;
										"R",;
										E1_CLIENTE,;
										MV_PAR09,;
										dDataBase,;
										dDataBase,;
										E1_LOJA,;
										E1_FILIAL,;
										IIf(cPaisLoc=="BRA",E1_TXMOEDA,0),nTipoData )

			// Subtrai decrescimo para recompor o saldo na data escolhida.
			If Str(SE1->E1_VALOR,17,2) == Str(nSaldoAtu,17,2) .And. SE1->E1_DECRESC > 0 .And. SE1->E1_SDDECRE == 0
				nSaldoAtu -= SE1->E1_DECRESC
			Endif
			// Soma Acrescimo para recompor o saldo na data escolhida.
			If Str(SE1->E1_VALOR,17,2) == Str(nSaldoAtu,17,2) .And. SE1->E1_ACRESC > 0 .And. SE1->E1_SDACRES == 0
				nSaldoAtu += SE1->E1_ACRESC
			Endif
			
		Endif
	Else       
		If cPaisLoc == "BRA"
			nSaldoAtu := xMoeda((SE1->E1_SALDO+SE1->E1_SDACRES-SE1->E1_SDDECRE),E1_MOEDA,mv_par09,,,If(cPaisLoc=="BRA",E1_TXMOEDA,0))
		Else
			nSaldoAtu := xMoeda((SE1->E1_SALDO+SE1->E1_SDACRES-SE1->E1_SDDECRE),E1_MOEDA,mv_par09,E1_EMISSAO,nDecs+1,If(cPaisLoc=="BRA",E1_TXMOEDA,0))
		EndIf
	Endif
	
	nSaldoAtu -= FaDescFin("SE1",dDataBase,nSaldoAtu,1)
	
	nValAbat := 0		
	If !(E1_TIPO $MV_CRNEG+"/"+MVRECANT+"/"+MVABATIM)
		// Se considerar titulos com emissao futura, envia a data de ref. para Somaabat para que ela considere os
		// titulos de abatimento com emissao <= Database + 40 anos (30 * 480) - Emissao futura
		nValAbat := SomaAbat(E1_PREFIXO,E1_NUM,E1_PARCELA,"R",1,,E1_CLIENTE,E1_LOJA,E1_FILIAL,If(mv_par14==1,dDataBase+(30*480),dDataBase))
	Endif
	
	If nSaldoAtu > 0 .and. (mv_par11 == 1 .or. STR(nSaldoAtu,17,2) == STR(nValAbat,17,2))
		nSaldoAtu-= nValAbat
	Endif  
  	nSaldoAtu:=Round(NoRound(nSaldoAtu,3),2)

	If nSaldoAtu > 0
		dBaixa := dDataBase
		nJuros := 0
		If mv_par06 == 1
			fa070juros(mv_par09)
		Endif

		lAdto := E1_TIPO $ MVRECANT+"/"+MV_CRNEG

		If E1_VENCREA < dDataBase
			nSaldoAtu+=nJuros
			nDias := (dDatabase - E1_VENCTO)
	
			aVal[34,1] += nSaldoAtu

			If !lAdto
				If nDias <= 15
					aVal[38,1] += nSaldoAtu
					aVal[38,2] += 1
				ElseIf nDias > 15 .And. nDias <= 30
					aVal[3,1] += nSaldoAtu
					aVal[3,2] += 1
				ElseIf nDias > 30 .And. nDias <= 60
					aVal[4,1] += nSaldoAtu
					aVal[4,2] += 1
				ElseIf nDias > 60 .And. nDias <= 90
					aVal[5,1] += nSaldoAtu
					aVal[5,2] += 1
				Else
					aVal[6,1] += nSaldoAtu
					aVal[6,2] += 1
				Endif
			Endif
		Else
			If !lAdto
				aVal[34,1] += nSaldoAtu
	         	nDias      := (E1_VENCREA - dDatabase)
				If nDias <= 15
    	   	  		aVal[39,1] += nSaldoAtu
    		   		aVal[39,2] += 1
	            ElseIf nDias > 15 .And. nDias <= 30
    	        	aVal[7,1] += nSaldoAtu
        	    	aVal[7,2] += 1
	         	ElseIf nDias > 30 .And. nDias <= 60
    	       		aVal[8,1] += nSaldoAtu
        	    	aVal[8,2] += 1
	         	ElseIf nDias > 60 .And. nDias <= 90
    	       		aVal[9,1] += nSaldoAtu
        	    	aVal[9,2] += 1
	         	Else
    	       		aVal[10,1] += nSaldoAtu
        	    	aVal[10,2] += 1
	         	EndIF
			Endif
		EndIF
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula a distribuicao de cobranca / item 4  analise         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nSaldoAtu > 0
		IF !(E1_TIPO $MV_CRNEG+"/"+MVRECANT)
			If (nPos := Ascan(aSitua,{|x|, x[1] == E1_SITUACA})) > 0 
				aSitua[nPos,3] += nSaldoAtu
				aSitua[nPos,4] += 1
			Endif
		Endif
	Endif
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valor Recebido.     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nFirst1 == 1
		SA6->(dbSetorder(1)) // para pegar a moeda do banco.
		dbSelectArea("SE5") 
		If mv_par01 == 1
			dbSeek(xFilial("SE5"))
		Else
			dbGotop()
		Endif
		#IFDEF TOP
			IF TcSrvType() != "AS/400"
				aStru  := SE5->(dbStruct())
				cAliasSe5 := "NEWSE5"
				cCondFil := ""
				aEval(aStru,{|x| cCondFil += ","+AllTrim(x[1])})
				cCondFil := "SELECT "+SubStr(cCondFil,2)
				cCondFil +=         ",R_E_C_N_O_ RECNO "
				cCondFil += "FROM "+RetSqlName("SE5") + " SE5 "
				cCondFil += "WHERE " 
				If mv_par01 == 1
					cCondFil += "E5_FILIAL='" + xFilial("SE5") + "' AND "
				Endif
				cCondFil += "E5_TIPODOC IN ('VL','V2','JR','J2','CM','C2','MT','M2','DC','D2','TL','BA') AND E5_RECPAG = 'R' AND "
				cCondFil += "E5_PREFIXO >= '"+MV_PAR04+"' AND "	
				cCondFil += "E5_PREFIXO <= '"+MV_PAR05+"' AND "
	            If mv_par02 == 1
					cCondFil += "E5_DATA >= '"
				ElseIf mv_par02 == 2
					cCondFil += "E5_DTDIGIT >= '"
				ElseIf mv_par02 == 3
					cCondFil += "E5_DTDISPO >= '"
				Endif				
				cCondFIl += Subs(dtos(dDataBase),1,6)+"01"+"' AND "
	            If mv_par02 == 1
					cCondFil += "E5_DATA <= '"
				ElseIf mv_par02 == 2
					cCondFil += "E5_DTDIGIT <= '"
				ElseIf mv_par02 == 3
					cCondFil += "E5_DTDISPO <= '"
				Endif				
				cCondFIl += Dtos(LastDay(dDataBase))+"' AND "
				cCondFil += "D_E_L_E_T_=' ' "
		   	
				cCondFil := ChangeQuery(cCondFil)
		   	
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cCondFil),cAliasSe5,.T.,.T.)
				For nX :=  1 To Len(aStru)
					If aStru[nX][2] <> "C"
						TcSetField(cAliasSe5,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf
				Next nX
			Else
		#ENDIF
				cCondFil := ""
				If mv_par01 == 1
					cCondFil += "E5_FILIAL=='" + xFilial("SE5") + "' .And. "
				Endif
				cCondFil += "E5_TIPODOC$'VL/V2/JR/J2/CM/C2/MT/M2/DC/D2/TL/BA' .and. E5_RECPAG == 'R' .and. "
				cCondFil += "E5_PREFIXO>='"+MV_PAR04+"'.And."	
				ccondFil += "E5_PREFIXO<='"+MV_PAR05+"'.And."
	            If mv_par02 == 1
					cCondFil += "DTOS(E5_DATA) >= '"
				ElseIf mv_par02 == 2
					cCondFil += "DTOS(E5_DTDIGIT) >= '"
				ElseIf mv_par02 == 3
					cCondFil += "DTOS(E5_DTDISPO) >= '"
				Endif				
				cCOndFIl += Subs(dtos(dDataBase),1,6)+"01"+"'.and."
	            If mv_par02 == 1
					cCondFil += "DTOS(E5_DATA) <= '"
				ElseIf mv_par02 == 2
					cCondFil += "DTOS(E5_DTDIGIT) <= '"
				ElseIf mv_par02 == 3
					cCondFil += "DTOS(E5_DTDISPO) <= '"
				Endif				
				cCOndFIl += Dtos(LastDay(dDataBase))+"'"
				cArq :=CriaTrab(NIL,.F.)
				IndRegua("SE5",cArq,IndexKey(),,)
				nIndex:=RetIndex("SE5")
				#IFNDEF TOP
					dbSetIndex(cArq+OrdBagExt())
				#ENDIF					 
				dbSetOrder(nIndex+1)
				cAliasSe5 := "SE5"
				DbGoTop()
		#IFDEF TOP
			Endif
		#ENDIF
		
		DbSelectArea(cAliasSe5)
		DbGoTop()
       
		While (mv_par01 != 1 .OR. xFilial("SE5") == (cAliasSe5)->E5_FILIAL) .AND. !Eof()
		

        	// Ignora registros que nao sao da moeda quando escolhido nao imprimir
			SA6->(dbSeek(xFilial()+(cAliasSe5)->E5_BANCO+(cAliasSe5)->E5_AGENCIA+(cAliasSe5)->E5_CONTA))
         If mv_par10 == 2 .AND. Max(SA6->A6_MOEDA, 1) != mv_par09 
         	dbSkip()
            Loop
			Endif                 
     
	     	nMoedaBco := If(SA6->(Found()), Max(SA6->A6_MOEDA, 1), 1)

			If mv_par02 == 1
		  		dDataBaixa := (cAliasSe5)->E5_DATA
			ElseIf mv_par02 == 2
		  		dDataBaixa := (cAliasSe5)->E5_DTDIGIT
			ElseIf mv_par02 == 3
		  		dDataBaixa := (cAliasSe5)->E5_DTDISPO
			Endif				
            
         //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
         //³ Valor Recebido.   ³
         //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Month(dDatabase)== Month(dDataBaixa) .and.;
				Year(dDataBase) ==Year(dDataBaixa)   .and.;
				(cAliasSe5)->E5_RECPAG=="R" .and. dDataBaixa <= dDatabase .AND.;
				(cAliasSe5)->E5_TIPODOC$"VL/V2/BA" ;
				.and.  (cAliasSe5)->E5_SITUACA <> "C" .and. ;
				(	MovBcoBx((cAliasSe5)->E5_MOTBX) .or. ;
				((cAliasSe5)->E5_MOTBX=="CMP" .and. (cAliasSe5)->E5_TIPO $ MVRECANT+"#"+MV_CRNEG ) )			

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se existe estorno para esta baixa                       ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				#IFDEF TOP
					IF TcSrvType() != "AS/400"
						SE5->(dbGoto((cAliasSe5)->RECNO))
					Endif
				#ENDIF	
				If !TemBxCanc((cAliasSe5)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ))
					nRecebido += xMoeda((cAliasSe5)->E5_VALOR,nMoedaBco,mv_par09,(cAliasSe5)->E5_DATA,nDecs+1,,If(cPaisLoc=="BRA",(cAliasSe5)->E5_TXMOEDA,0))
				EndIf
			EndIf

	      If Month(dDatabase) = Month(dDataBaixa) .and. ;
	      	Year(dDataBase)  = Year(dDataBaixa)  .and. (cAliasSe5)->E5_RECPAG=="R" .and. ;
	         dDataBaixa <= dDatabase .and. (cAliasSe5)->E5_SITUACA <> "C" .and. ;
	         MovBcoBx((cAliasSe5)->E5_MOTBX) 
	         nValorE5 := xMoeda((cAliasSe5)->E5_VALOR,nMoedaBco,mv_par09,(cAliasSe5)->E5_DATA,nDecs+1,,If(cPaisLoc=="BRA",(cAliasSe5)->E5_TXMOEDA,0))
	         Do Case 
	         	Case (cAliasSe5)->E5_TIPODOC $ "JR/J2/TL"  //Valor juros
	            	nValJuros += nValorE5
					Case (cAliasSe5)->E5_TIPODOC $ "CM/C2"     //Valor da correcao
	            	nCorrecao += nValorE5
					Case (cAliasSe5)->E5_TIPODOC $ "MT/M2"     //Valor da Multa
	            	nMulta    += nValorE5
					Case (cAliasSe5)->E5_TIPODOC $ "DC/D2"     //Valor do Desconto
	            	ndesconto += nValorE5
				EndCase
			EndIf
			dbSelectArea(cAliasSe5)
	      dbSkip()
		Enddo
		#IFDEF TOP
			IF TcSrvType() != "AS/400"
				dbSelectArea(cAliasSe5)
				dbCloseArea()
				dbSelectArea("SE5")
			Else
		#ENDIF
				dbSelectArea("SE5")
				DbClearFil()
				RetIndex("SE5")
				FErase(cArq+OrdBagExt())
		#IFDEF TOP
			Endif
		#ENDIF
		nFirst1++
		dbSelectArea(cAliasTmp)
	EndIf
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula a distribuicao por tipo de titulo / item 5 analise   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nSaldoAtu > 0 .and. (mv_par14 == 1 .Or. E1_EMISSAO <= dDatabase)
		Do Case
			Case E1_TIPO  $ MVDUPLIC
				aVal[11,1] += nSaldoAtu
            aVal[11,2] += 1
			Case E1_TIPO  $ MVNOTAFIS
				aVal[12,1] += nSaldoAtu
				aVal[12,2] += 1
			Case E1_TIPO  $ MVCHEQUES
				aVal[13,1] += nSaldoAtu
				aVal[13,2] += 1
			Case E1_TIPO   = "CN"
				aVal[14,1] += nSaldoAtu
				aVal[14,2] += 1
			Case E1_TIPO  $ MVTAXA
				aVal[15,1] += nSaldoAtu
				aVal[15,2] += 1
			Case E1_TIPO  $ MVRECANT
				aVal[24,1] += nSaldoAtu
				aVal[24,2] += 1
			Case E1_TIPO $ MV_CRNEG				
				aVal[36,1] += nSaldoAtu
				aVal[36,2] += 1
			OtherWise
				aVal[16,1]  += nSaldoAtu
				aVal[16,2]  += 1	
		EndCase
	End
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula T.Carteira pedidos a entregar / item 6 da analise    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nFirst == 1 .and. mv_par12 == 1	
		dbSelectArea("SC6")
		cCondSC6 := 'C6_QTDVEN > C6_QTDENT '
		cArq :=CriaTrab("",.F.)
		nIndex:=RetIndex("SC6")
/*		#IFNDEF TOP
			dbSetIndex(cArq+OrdBagExt())
		#ENDIF
		dbSetOrder(nIndex+1)*/
		If mv_par01 == 1
			dbSeek(cFilial)
		Else
			dbGotop()
		Endif
        
		While !Eof()

         IF mv_par01 == 1 .and. cFilial != C6_FILIAL
				Exit
         Endif

         //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
         //³ Posicionar do SC5 para Localiza moeda do pedido              ³
         //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
         dbSelectArea( "SC5" )
         dbSeek( cFilial + SC6->C6_NUM )
         dbSelectArea( "SC6" )

		 	// Calcula se moeda for igual a escolhida ou for para converter
		 	If SC5->C5_MOEDA == mv_par09 .OR. mv_par10 == 1             
            nSaldo := xMoeda(U_fa321SALDO(),SC5->C5_MOEDA, mv_par09,SC5->C5_EMISSAO,nDecs+1)
            If nSaldo > 0
					If dDatabase < C6_ENTREG // itens a vencer					 
						nDias := (C6_ENTREG - dDatabase)
						If nDias <= 30
							aVal[17,2]++
							aVal[17,1]+= nSaldo
						ElseIf nDias > 30 .And. nDias <= 60
							aVal[18,2]++
							aVal[18,1]+= nSaldo
						ElseIf nDias > 60 .And. nDias <= 90
							aVal[19,2]++
							aVal[19,1]+= nSaldo
						Else
							aVal[20,2]++
							aVal[20,1]+= nSaldo
						Endif
					Else // itens vencidos
						nDias := (dDatabase - C6_ENTREG)
						aVal[21,2]++
						aVal[21,1]+= nSaldo
					EndIf
				Endif
			Endif
			dbSkip()
		EndDo
		RetIndex("SC6")
		Set Filter to
		Ferase(cArq+OrdBagExt())
		nFirst++
		dbSelectArea(cAliasTmp)
	Endif
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula o P.M.A e P.M.P - indices / item 7 da analise        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nSaldoAtu != 0
		aVal[22,1] += (E1_VENCREA-E1_EMISSAO)
		aVal[22,2] += 1
		aVal[23,1] += (E1_VENCREA-E1_EMISSAO)*;
					   xMoeda(nSaldoAtu,E1_MOEDA,mv_par09,E1_EMISSAO,nDecs+1,If(cPaisLoc=="BRA",E1_TXMOEDA,0))
		aVal[23,2] +=  xMoeda(nSaldoAtu,E1_MOEDA,mv_par09,E1_EMISSAO,nDecs+1,If(cPaisLoc=="BRA",E1_TXMOEDA,0))
	EndIf
	dbSelectArea(cAliasTmp)
	nSaldoAtu:=0
	dbSkip()
Enddo
#IFDEF TOP
	IF TcSrvType() != "AS/400"
		dbSelectArea(cAliasTmp)
		dbCloseArea()
		dbSelectArea("SE1")
	Else
#ENDIF
		dbSelectArea("SE1")
		DbClearFil()
		RetIndex("SE1")
		FErase(cIndTmp+OrdBagExt())
#IFDEF TOP
	Endif
#ENDIF

dbSelectArea("SE1")
dbSetOrder(1)
Set Filter to
dbSelectArea("SE5")
dbSetOrder(1)
Set Filter to

aVal[40,1] := nRecebido
aVal[41,1] := nValJuros
aVal[42,1] := nMulta           
aVal[43,1] := nCorrecao        
aVal[44,1] := nDesconto			
aVal[45,1] := nRecebido-(nValJuros+nMulta+nCorrecao-nDesconto)  
dDataBase := dOldDtBase // Restaura Data base

Return aVal


//-------------------------------------------------------------------
/*/
{Protheus.doc} Fr321Situa
Função para retornar as informações do cadastro de situacao de cotrança

@return aSituaca	 - Array contendo as seguintes informações
					[1] - Codigo da situacao de Cobranca
					[2] - Descricao da situacao de cobranca
					[3] - Valor (a ser alimentado posteriormente)
					[4] - Quantidade de titulos (a ser alimentado posteriormente)

@author pequim

@since 09/12/2013
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function Fr321Situa()

Local aSituaca	:= {}
Local aArea		:= GetArea()

dbSelectArea("FRV")
dbSetOrder(1)
If MsSeek(xFilial("FRV")+"0")
	While !(FRV->(EOF())) .and. xFilial("FRV") == FRV->FRV_FILIAL
		AADD(aSituaca,{FRV->FRV_CODIGO,Alltrim(FRV->FRV_DESCRI),0,0})
		FRV->(dbSkip())
	Enddo
Endif

RestArea(aArea)

Return aSituaca		

