/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR320.CH"
#include "PROTHEUS.CH"
#INCLUDE "fwcommand.ch"

Static lFWCodFil := .T.
Static __aTtImp
Static aTitImp
Static __oHash

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR320  ³ Autora³ Adrianne Furtado      ³ Data ³ 06/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Posi‡„o Geral da Cobran‡a.								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FINR320()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FINR320()

Local oReport
Local aArea		:= GetArea()
Local cPerg		:= "FIN320"		// Nome do grupo de perguntas

Private oAbatim := Nil

oReport := ReportDef( cPerg )
oReport:PrintDialog()

RestArea( aArea )  

If oAbatim != NIL
	oAbatim:Destroy()
	oAbatim := NIL
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Adrianne Furtado   º Data ³  06/06/06  º±±
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

Local cReport	:= "FINR320" // Nome do relatorio
Local cTitulo	:= STR0005	 // Titulo do relatorio -> "Posicao Geral do Contas a Receber"
Local cDescri	:= STR0001 +" "+ STR0002// Descricao do relatorio ->"Este programa ir  emitir a posi‡„o geral da cobran‡a no mˆs"
									//"referente a data base do sistema."
Local oReport	:= Nil
Local oSection1	:= Nil        
Local oSection2	:= Nil
Local oSecFil	:= Nil


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
oReport  := TReport():New( cReport , cTitulo, cPerg, { |oReport| ReportPrint( oReport ) }, cDescri )
/*
GESTAO - inicio */
oReport:SetUseGC(.F.)
/* GESTAO - fim
*/ 
__oHash    := tHashMap():New() //Cria o Objeto do Hash Map
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
/*
GESTAO - inicio */
/* Relacao das filiais selecionadas para compor o relatorio */
oSecFil := TRSection():New(oReport,"SECFIL",{"SE1","SED"})
TRCell():New(oSecFil,"CODFIL",,"Código",/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSecFil,"EMPRESA",,"Empresa",/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSecFil,"UNIDNEG",,"Unidade de negócio",/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSecFil,"NOMEFIL",,"Filial",/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)
/* GESTAO - fim
*/

Return oReport                   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportPrint ºAutor³Adrianne Furtado    º Data ³  07/06/06   º±±
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
Static Function ReportPrint( oReport )
Local oCliente  := oReport:Section(1)
Local oSection1 := oReport:Section(1):Section(1) 
Local oSection2 := oReport:Section(1):Section(2)
Local oSection3 := oReport:Section(1):Section(3)
Local oSection4 := oReport:Section(1):Section(4)
Local oSection5 := oReport:Section(1):Section(5)
Local oSection6 := oReport:Section(1):Section(6)
Local oSection7 := oReport:Section(1):Section(7)
Local oSection8 := oReport:Section(1):Section(8)
Local oSection9 := oReport:Section(1):Section(9)
Local nLinha	:= 0
Local aVal
Local aValor	:={}
Local nX
Local nMeter	:= 0          
Local cFiltSE1 := oReport:Section(1):GetAdvplExp("SE1")
Local cFiltSED := oReport:Section(1):GetAdvplExp("SED")
/*
GESTAO - inicio */
Local aSelFil		:= {}
Local aSM0			:= {}
Local nRegSM0		:= 0
Local nTamEmp		:= 0
Local nTamUnNeg		:= 0
Local nTamTit		:= 0
Local cFiLSel		:= ""
Local cTitulo		:= ""
Local oSecFil		:= oReport:Section("SECFIL")
Local lGestao	:= Iif( lFWCodFil, FWSizeFilial() > 2, .F. )	// Indica se usa Gestao Corporativa
//Situacao de cobranca
Local aSitua		:= {} 
Local nLinCob		:= 0
Local nLin1st		:= 0
Local nLin2nd		:= 0

Local nI := 0
Local aAux := {}

#IFDEF TOP
nRegSM0 := SM0->(Recno())

If FindFunction("AdmSelecFil") .AND. MV_PAR01 == 1
	AdmSelecFil("FIN320",1,.F.,@aSelFil,"SE1",.F.)
Else
	If MV_PAR01 == 2
		aSelFil := AdmGetFil(.F.,(MV_PAR01 == 2),"SE1",.F.,.F.,.F.)
	Else
		aSelFil := AdmGetFil(.F.,(MV_PAR01 == 1),"SE1",.F.,.F.,.T.)
	Endif
	
	For nI := 1 to Len(aSelFil)
		Aadd(aAux, aSelFil[nI][1])
	Next nI
	
	aSelFil := aAux
Endif

If Empty(aSelFil)
	Aadd(aSelFil,cFilAnt)
Endif

SM0->(DbGoTo(nRegSM0))
#ELSE
	Aadd(aSelFil,cFilAnt)
#ENDIF

aVal := FA320Calc(cFiltSE1,cFiltSED,@aSelFil,aSitua)  //sitcob

aADD(aValor,{STR0010,aVal[1,1]+aVal[2,1],aVal[1,2]+aVal[2,2]}) 		//"FATURAMENTO (no mes)"
aADD(aValor,{STR0011,aVal[1,1],aVal[1,2]})	 						//"A Vista"
aADD(aValor,{STR0012,aVal[2,1],aVal[2,2]}) 							//"A Prazo"

aADD(aValor,{STR0051,""					 ,""		}) 				//"VALORES BAIXADOS"
aADD(aValor,{STR0013,aVal[40,1]			 ,""		}) 				//"RECEBIDO"
aADD(aValor,{STR0014,aVal[41,1]			 ,""		}) 				//"TAXA DE PERMANENCIA"          
aADD(aValor,{STR0015,aVal[42,1]			 ,""		}) 				//"Multa"
aADD(aValor,{STR0016,aVal[43,1]			 ,""		}) 				//"CORRECAO"
aADD(aValor,{STR0017,aVal[44,1]			 ,""		}) 				//"DESCONTO"
aADD(aValor,{STR0069,aVal[46,1]			 ,""		}) 				//"Valor acessório"
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

//SitCob
For nX := 1 to Len(aSitua)
	/*
	[1] - Codigo da situacao de Cobranca
	[2] - Descricao da situacao de cobranca
	[3] - Valor (a ser alimentado posteriormente)
	[4] - Quantidade de titulos (a ser alimentado posteriormente)
    */
	aADD(aValor,{aSitua[nX,2],aSitua[nX,3]	 ,aSitua[nX,4]	})
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
For nLinha := 4 to 11
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
For nLinha := 12 to 17
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
For nLinha := 18 to 23
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
For nLinha := 24 to 25
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
nLinCob := 26 + Len(aSitua)
For nLinha := 26 to nLinCob
	If nLinha == 26
		oSection6:Cell("CelValor"):SetPicture("") //Não deve utilizar picture no titulo da secao que n imprime valores
	ElseIf nLinha == 27
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
nLin1st := nLinha
nLin2nd := nLinha + 1
For nLinha := nLinha to nLinha+7 
	If nLinha == nLin1st
		oSection7:Cell("CelValor"):SetPicture("") //Não deve utilizar picture no titulo da secao que n imprime valores
	ElseIf nLinha == nLin2nd
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
For nLinha := nLinha to nLinha + 5
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

For nLinha := nLinha to nLinha + 2
	oReport:IncMeter()
	oSection9:PrintLine()
Next 
oSection9:Finish()      

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ INSIDE     ºAutor³                    º Data ³             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function InSide(cTp)
Return (cTp$cTipos)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Fa320Saldo³ Autor ³ Alessandro Freire     ³ Data ³ 16.01.97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o saldo do item do pedido                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_Fa320Saldo()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Fa320Saldo()
LOCAL nRetSaldo := 0

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
±±³Fun‡„o    ³FA320Calc ³ Autor ³ Adrianne Furtado      ³ Data ³ 07.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Calculo dos valores do relatorio Posi‡„o Geral da Cobran‡a.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FA320Calc(cFiltSE1)                            				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FA320Calc(cFiltSE1,cFiltSED,aSelFil,aSitua)

LOCAL aVal[46,2]
LOCAL CbCont		:= ""	
LOCAL CbTxt			:= ""
LOCAL tamanho		:= "M"
LOCAL nSaldo		:= 0
LOCAL nDias			:= 0
LOCAL nJ			:= 0
LOCAL nSaldoAtu		:= 0
LOCAL nFirst		:= 1
LOCAL nFirst1		:= 1
LOCAL nRecebido		:= 0
LOCAL nValJuros		:= 0
LOCAL nDesconto		:= 0
LOCAL nCorrecao		:= 0
LOCAL nMulta		:= 0
LOCAL nOriginal		:= 0
LOCAL dDataBaixa	:= CTOD("//")
Local cCondSC6		:= ""
Local dOldDtBase 	:= dDataBase
Local nI			:= 0
Local nMoedaBco		:= 1
Local nDecs			:= MsDecimais(mv_par09)
Local cFiltro		:= ""
Local cIndTmp		:= ""
Local cAliasTmp		:= ""
Local nTipoData		:= 1
Local lAdto			:= .F.
Local nValAbat		:= 0
Local nAbt			:= 0
Local nTamFilial	:= FWGETTAMFILIAL
Local nVa			:= 0
Local nVaRec		:= 0  
//GESTAO - inicio
Local aTmpFil		:= {}
Local cTmpFil		:= {}
Local cFilOrig		:= ""
Local cFilTit		:= ""
Local cAliasSC6		:= ""
//GESTAO - fim
Local nX			:= 0
Local cCondFil		:= ""
Local nIndex		:= 0
Local cQuery		:= ""
Local cArq			:= ""
Local lFValAcess	:= ExistFunc('FValAcess')
Local lMvPar15		:= FR320CHK()
Local lTcSrvType	:= TcSrvType() != "AS/400"
Local lTemGEM		:= ExistTemplate("GEMDESCTO") .And. HasTemplate("LOT")
Local cTipoIn		:= ""
Local lExistAba		:= .F. 

DEFAULT aSelFil 	:= {cFilAnt}
DEFAULT cFiltSE1	:= ""
DEFAULT cFiltSED	:= ""
DEFAULT aSitua		:= {}	

//Sitcob
//Obtem as situacos de cobranca cadastradas (tabela FRV)
aSitua := Fr320Situa()

//Tipo da data para a composicao do saldo via SaldoTit()
If mv_par02 == 1		// Data da baixa (E5_BAIXA)
	nTipoData := 1
ElseIf mv_par02 == 2 	//Data de Digitacao (E5_DTDIGIT)
	nTipoData := 3
Else					//Data de Disponibilidade (E5_DTDISPO)
	nTipoData := 2
EndIf

If mv_par08 == 1 //considera database
	dDataBase := mv_par13
EndIf

PRIVATE  cTipos := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se seleciona tipos para total faturamento         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par03 == 1
	finaTipos()
EndIf

dbSelectArea("SE1")
dbSetOrder(1)
If mv_par01 == 1
	dbSeek(xFilial("SE1"))
Else 
	dbGotop()
EndIf

For nI := 1 to 45
	For nJ := 1 to 2
		aVal[nI,nJ] := 0
	Next nJ
Next nI

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtra APENAS os emitidos antes da database, pois este rela³
//³ torio pode ser retroativo.                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lTcSrvType
	aStru  := SE1->(dbStruct())
	cAliasTmp := "FINR320"
	cQuery := ""
	aEval(aStru,{|x| cQuery += ","+AllTrim(x[1])})
	cQuery := "SELECT "+SubStr(cQuery,2)
	cQuery +=         ",R_E_C_N_O_ RECNO "
	cQuery += "FROM "+RetSqlName("SE1")+ " SE1 "
	cQuery += "WHERE "
	/*
	GESTAO - inicio */
	
	cQuery += "SE1.E1_FILIAL " + GetRngFil( aSelFil, "SE1", .T., @cTmpFil) + " AND "
	Aadd(aTmpFil,cTmpFil)
	
	/* GESTAO - fim
	*/
	If mv_par14 == 2 //Nao considerar titulos com emissao futura
		cQuery += "SE1.E1_EMISSAO <= '"+Dtos(dDataBase)+"' AND "
	Endif
	
	If mv_par08 == 1 .AND. mv_par14 != 2
		cQuery += "SE1.E1_EMISSAO <= '"+Dtos(mv_par13)+"' AND "
	Endif
	cQuery += "(SE1.E1_FATURA = '      ' OR SE1.E1_FATURA = 'NOTFAT') AND "
	cQuery += "(SE1.E1_DTFATUR > '"+Dtos(dDataBase)+"' OR SE1.E1_DTFATUR = '        ') AND "
	cQuery += "SE1.E1_TIPOLIQ = ' ' AND "
	cQuery += "SE1.E1_PREFIXO >= '"+MV_PAR04+"' AND "	
	cQuery += "SE1.E1_PREFIXO <= '"+MV_PAR05+"' AND "
	If mv_par10 == 2 
		cQuery += "SE1.E1_MOEDA = "+Str(MV_PAR09,2)+" AND "
	Endif 
	cQuery += "SE1.E1_SALDO >= 0 AND "	
	cQuery += "(SE1.E1_DESDOBR != '1' OR (SE1.E1_DESDOBR = '1' AND SE1.E1_STATUS = 'A' )) AND "
	cQuery += "SE1.D_E_L_E_T_=' ' "

	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTmp,.T.,.T.)
	For nX :=  1 To Len(aStru)
		If aStru[nX][2] <> "C"
			TcSetField(cAliasTmp,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
		EndIf
	Next nX
Else
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
EndIf

dbSelectArea(cAliasTmp)
/*
GESTAO - inicio */
cFilOrig := cFilAnt
/* GESTAO - fim
*/
While !Eof()

	dbSelectArea(cAliasTmp)
	
	//GESTAO - inicio
	cFilAnt := (cAliasTmp)->E1_FILORIG
	//GESTAO - fim
	
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
		EndIf
	EndIf		

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se ‚ provis¢rio ou abatimento ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If E1_TIPO $ MVPROVIS+"/"+MVABATIM
		If E1_TIPO $ MVABATIM	//Somo o valor caso seja abatimento 
			If mv_par11 == 1  
				If E1_MOEDA != MV_PAR09
					nAbt := IIF(dDatabase < E1_BAIXA, xMoeda(E1_VALOR,E1_MOEDA,MV_PAR09,,,If(cPaisLoc=="BRA",E1_TXMOEDA,0)), xMoeda(E1_SALDO,E1_MOEDA,MV_PAR09,,,If(cPaisLoc=="BRA",E1_TXMOEDA,0)))		// no resumo por tipo de titulos
				Else
					nAbt  := IIF(dDatabase < E1_BAIXA, E1_VALOR, E1_SALDO)		// no resumo por tipo de titulos
				EndIf
				aVal[35,1] += nAbt
				aVal[35,2] += IIF(nAbt > 0,1,0)
			EndIf
		Else
			If E1_MOEDA != MV_PAR09            
        		aVal[16,1] += xMoeda(E1_SALDO,E1_MOEDA,MV_PAR09,,,If(cPaisLoc=="BRA",E1_TXMOEDA,0))
        	Else
        		aVal[16,1] += E1_SALDO
        	EndIf
			aVal[16,2] += IIF(SE1->E1_SALDO > 0,1,0)
		EndIf
		dbSkip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula o faturamento baseado na data base/item 1 analise    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Month(E1_EMISSAO) == Month(dDatabase) .And. Year(E1_EMISSAO) == Year(dDataBase)
		If !(E1_TIPO $MV_CRNEG+"/"+MVRECANT)
			nDias := (E1_VENCREA - E1_EMISSAO)
			If nDias <= 1
				If E1_MOEDA != MV_PAR09 
					aVal[1,1] += xMoeda(E1_VALOR,E1_MOEDA,MV_PAR09,,,If(cPaisLoc=="BRA",E1_TXMOEDA,0))
				Else
					aVal[1,1] += E1_VALOR
				EndIf
					aVal[1,2] += 1
			Else
				If E1_MOEDA != MV_PAR09
					aVal[2,1] += xMoeda(E1_VALOR,E1_MOEDA,MV_PAR09,,,If(cPaisLoc=="BRA",E1_TXMOEDA,0))
				Else
					aVal[2,1] += E1_VALOR
				EndIf
					aVal[2,2] += 1
			EndIf
		EndIf
	EndIf
    
	nSaldoAtu := 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acumula titulos vencidos/vencer / Item 2 e 3 da analise      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lTcSrvType
		// Posiciona SE2 ou SE1 para pegar o saldo do titulo correto
		SE1->(DbGoto((cAliasTmp)->RECNO))
	EndIf	
	
	If mv_par08 == 1    // Considera Data Base
		 dDataBase := mv_par13
	Endif	

	If mv_par08 == 1
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
			If (E1_MOEDA != MV_PAR09)
				nSaldoAtu := xMoeda((SE1->E1_SALDO+SE1->E1_SDACRES-SE1->E1_SDDECRE),E1_MOEDA,mv_par09,,,If(cPaisLoc=="BRA",E1_TXMOEDA,0))
			Else
				nSaldoAtu := SE1->E1_SALDO+SE1->E1_SDACRES-SE1->E1_SDDECRE
			EndIf
		Else
			nSaldoAtu := xMoeda((SE1->E1_SALDO+SE1->E1_SDACRES-SE1->E1_SDDECRE),E1_MOEDA,mv_par09,E1_EMISSAO,nDecs+1,If(cPaisLoc=="BRA",E1_TXMOEDA,0))
		EndIf
	EndIf
	
	nSaldoAtu -= FaDescFin("SE1",dDataBase,nSaldoAtu,1,, lTemGEM)
	
	nValAbat := 0		
	
	
	If !(E1_TIPO $MV_CRNEG+"/"+MVRECANT+"/"+MVABATIM)
		// Se considerar titulos com emissao futura, envia a data de ref. para Somaabat para que ela considere os
		// titulos de abatimento com emissao <= Database + 40 anos (30 * 480) - Emissao futura
		
		cFilNat		:= SE1->E1_NATUREZ
        lExistAba	:= HashNatur(@cTipoIn)

        //Busca as informacoes para alimentar a array aTitImp utilizando a funcao FR320RtImp
        If lExistAba
            If __aTtImp == Nil
            	__aTtImp := {}
            EndIf
            
			If ( nPos := (aScan(__aTtImp, {|x| x[1] == cFilNat}))) == 0
                aTitImp		:= FR320RtImp(cFilNat)
                aAdd(__aTtImp, {cFilNat, aTitImp} )
            Else
            	aTitImp := aClone(__aTtImp[nPos,2])
            EndIf
        Else
            aTitImp:= {}
        EndIf

		If ( (nPos := (aScan(aTitImp, {|x| x[1] <> SE1->E1_TIPO }))) > 0 .and. aTitImp[nPos][2] ) 

			// Somente verifica abatimentos se existirem titulos deste tipo para o cliente
			If lExistAba
				nValAbat := SomaAbat(E1_PREFIXO,E1_NUM,E1_PARCELA,"R",1,,E1_CLIENTE,E1_LOJA,E1_FILIAL,If(mv_par14==1,dDataBase+(30*480),dDataBase))
			Else
				nValAbat := 0
			EndIf

		Endif
	
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

		If lMvPar15
			If mv_par15 == 1
				nVa	:= IIf(lFValAcess,FValAcess(E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO,E1_CLIENTE,E1_LOJA,E1_NATUREZ, Iif(Empty(E1_BAIXA),.F.,.T.),"","R",E1_BAIXA),0)
			EndIf
		EndIf 
		
		lAdto := E1_TIPO $ MVRECANT+"/"+MV_CRNEG

		If E1_VENCREA < dDataBase
			nSaldoAtu += nJuros + nVa
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
	         	EndIf
			EndIf
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula a distribuicao de cobranca / item 4  analise         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nSaldoAtu > 0		//sitcob
		If !(E1_TIPO $MV_CRNEG+"/"+MVRECANT)
			nPos := Ascan(aSitua,{|x|, x[1] == E1_SITUACA})
			If nPos > 0
				aSitua[nPos,3] += nSaldoAtu
				aSitua[nPos,4] += 1
			EndIf 
		EndIf
	EndIf
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valor Recebido.     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	cFilTit := cFilAnt
	If nFirst1 == 1
		SA6->(dbSetorder(1)) // para pegar a moeda do banco.
		dbSelectArea("SE5") 
		If mv_par01 == 1
			dbSeek(xFilial("SE5"))
		Else
			dbGotop()
		Endif

		If lTcSrvType
			aStru  := SE5->(dbStruct())
			cAliasSe5 := "NEWSE5"
			cCondFil := ""
			aEval(aStru,{|x| cCondFil += ","+AllTrim(x[1])})
			cCondFil := "SELECT "+SubStr(cCondFil,2)
			cCondFil +=         ",R_E_C_N_O_ RECNO "
			cCondFil += "FROM "+RetSqlName("SE5") + " SE5 "
			cCondFil += "WHERE "
			/*
			GESTAO - inicio */
			
			cCondFil += "E5_FILIAL " + GetRngFil( aSelFil, "SE5", .T., @cTmpFil) + " AND "
			Aadd(aTmpFil,cTmpFil)
			
			/* GESTAO - fim
			*/
			cCondFil += "E5_TIPODOC IN ('VL','V2','JR','J2','CM','C2','MT','M2','DC','D2','TL','BA','VA') AND E5_RECPAG = 'R' AND " 
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
			cCondFil := ""
			If mv_par01 == 1
				cCondFil += "E5_FILIAL=='" + xFilial("SE5") + "' .And. "
			Endif
			cCondFil += "E5_TIPODOC$'VL/V2/JR/J2/CM/C2/MT/M2/DC/D2/TL/BA/VA' .and. E5_RECPAG == 'R' .and. " 
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
		Endif

		
		DbSelectArea(cAliasSe5)
		DbGoTop()
		
		While !Eof()
			cFilAnt := (cAliasSE5)->E5_FILIAL
	
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
				If lTcSrvType
					SE5->(dbGoto((cAliasSe5)->RECNO))
				EndIf
				
				If !TemBxCanc((cAliasSe5)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ))
					nValorE5 := If(MovMoedEs((cAliasSe5)->E5_MOEDA, (cAliasSe5)->E5_TIPODOC, (cAliasSe5)->E5_MOTBX, DTOS((cAliasSe5)->E5_DATA), (cAliasSe5)->E5_RECPAG),;
						(cAliasSe5)->E5_VLMOED2, (cAliasSe5)->E5_VALOR)
					
					If nMoedaBco != mv_par09
						nRecebido += xMoeda(nValorE5, nMoedaBco, mv_par09, (cAliasSe5)->E5_DATA, nDecs+1, Nil, If(cPaisLoc=="BRA", (cAliasSe5)->E5_TXMOEDA, 0))
					Else
						nRecebido += nValorE5
					EndIf
					
					nValorE5 := 0
				EndIf
			EndIf
			
			If (cAliasSe5)->E5_RECPAG == "R" .And. (cAliasSe5)->E5_SITUACA <> "C" .And. dDataBaixa <= dDatabase .And. MovBcoBx((cAliasSe5)->E5_MOTBX) .And.;
				Month(dDatabase) = Month(dDataBaixa) .And. Year(dDataBase) == Year(dDataBaixa)
				
				nValorE5 := If(MovMoedEs((cAliasSe5)->E5_MOEDA, (cAliasSe5)->E5_TIPODOC, (cAliasSe5)->E5_MOTBX, DTOS((cAliasSe5)->E5_DATA), (cAliasSe5)->E5_RECPAG),;
						(cAliasSe5)->E5_VLMOED2, (cAliasSe5)->E5_VALOR)
				
				If nMoedaBco != mv_par09
					nValorE5 := xMoeda((cAliasSe5)->E5_VALOR,nMoedaBco,mv_par09,(cAliasSe5)->E5_DATA,nDecs+1,,If(cPaisLoc=="BRA",(cAliasSe5)->E5_TXMOEDA,0))
				EndIf
	         	
	         	Do Case 
	         		Case (cAliasSe5)->E5_TIPODOC $ "JR/J2/TL"  //Valor juros
	            		nValJuros += nValorE5
					Case (cAliasSe5)->E5_TIPODOC $ "CM/C2"     //Valor da correcao
	            		nCorrecao += nValorE5
					Case (cAliasSe5)->E5_TIPODOC $ "MT/M2"     //Valor da Multa
	            		nMulta    += nValorE5
					Case (cAliasSe5)->E5_TIPODOC $ "DC/D2"     //Valor do Desconto
	            		ndesconto += nValorE5
	            	Case (cAliasSe5)->E5_TIPODOC $ "VA"     //Valor acessório
	            		nVARec	+= nValorE5
				EndCase
			EndIf
			dbSelectArea(cAliasSe5)
			dbSkip()
		EndDo
		
		If lTcSrvType
			dbSelectArea(cAliasSe5)
			dbCloseArea()
			dbSelectArea("SE5")
		Else
			dbSelectArea("SE5")
			DbClearFil()
			RetIndex("SE5")
			FErase(cArq+OrdBagExt())
		EndIf
		nFirst1++
		dbSelectArea(cAliasTmp)
	EndIf
	
	//GESTAO - inicio
	cFilAnt := cFilTit
	//GESTAO - fim
	
	//---------------------------------------------------------------
	// Calcula a distribuicao por tipo de titulo / item 5 analise
	//---------------------------------------------------------------
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
	EndIf
    
	//---------------------------------------------------------------
	// Calcula T.Carteira pedidos a entregar / item 6 da analise
	//---------------------------------------------------------------
	If nFirst == 1 .and. mv_par12 == 1	
		dbSelectArea("SC6")
		cCondSC6 := 'C6_QTDVEN > C6_QTDENT '
		cArq := CriaTrab("",.F.)
		nIndex := RetIndex("SC6")
		
		//GESTAO - inicio
		cCondFil := " SELECT C5_MOEDA MOEDA, SC6.R_E_C_N_O_ FROM " + RetSQLName("SC6") + " SC6 "
		cCondFil += " LEFT JOIN " + RetSqlName("SC5") + " SC5 "
		cCondFil += " ON C5_FILIAL = C6_FILIAL AND C5_NUM = C6_NUM AND SC5.D_E_L_E_T_ = ' ' WHERE "
		
		cCondFil += " C6_FILIAL " + GetRngFil( aSelFil, "SC6", .T., @cTmpFil)
		Aadd(aTmpFil,cTmpFil)
	
		cCondFil += " AND SC6.D_E_L_E_T_ = ' ' "
		cCondFil += " ORDER BY C6_FILIAL, C6_NUM "
		cCondFil := ChangeQuery(cCondFil)
		cAliasSC6 := GetNextAlias()
	   	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cCondFil),cAliasSC6,.T.,.T.)
        //GESTAO - fim

		While !((cAliasSC6)->(Eof()))
			
			//GESTAO - inicio
			SC6->(DbGoto((cAliasSC6)->R_E_C_N_O_))
         	//GESTAO fim
	       	dbSelectArea( "SC6" )

		 	// Calcula se moeda for igual a escolhida ou for para converter
		 	If (cAliasSC6)->MOEDA == mv_par09 .OR. mv_par10 == 1 
				If (cAliasSC6)->MOEDA != mv_par09		 		            
            		nSaldo := xMoeda(U_fa320Saldo(),(cAliasSC6)->MOEDA, mv_par09,SC5->C5_EMISSAO,nDecs+1)
            	Else
            		nSaldo := U_fa320Saldo()
            	EndIf
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
						EndIf
					Else // itens vencidos
						nDias := (dDatabase - C6_ENTREG)
						aVal[21,2]++
						aVal[21,1]+= nSaldo
					EndIf
				EndIf
			EndIf
			(cAliasSC6)->(dbSkip())
		EndDo
		RetIndex("SC6")
		Set Filter to
		Ferase(cArq+OrdBagExt())
		nFirst++
		dbSelectArea(cAliasSC6)
		dbCloseArea()
		dbSelectArea(cAliasTmp)
	EndIf
    
	//----------------------------------------------------------------
	// Calcula o P.M.A e P.M.P - indices / item 7 da analise
	//----------------------------------------------------------------
	If nSaldoAtu != 0
		aVal[22,1] += (E1_VENCREA-E1_EMISSAO)
		aVal[22,2] += 1
		aVal[23,1] += (E1_VENCREA-E1_EMISSAO) * xMoeda(nSaldoAtu, E1_MOEDA, mv_par09, E1_EMISSAO, nDecs+1, If(cPaisLoc=="BRA", E1_TXMOEDA, 0))
		aVal[23,2] +=  xMoeda(nSaldoAtu, E1_MOEDA, mv_par09, E1_EMISSAO, nDecs+1, If(cPaisLoc=="BRA", E1_TXMOEDA, 0))
	EndIf
	dbSelectArea(cAliasTmp)
	nSaldoAtu:=0
	dbSkip()
EndDo

__oHash:Clean()

//GESTAO - inicio
cFilAnt := cFilOrig

If !Empty(aTmpFil)
	For nI := 1 To Len(aTmpFil)
		CtbTmpErase(aTmpFil[nI])
	Next
EndIf
//GESTAO - fim

dbSelectArea(cAliasTmp)
dbCloseArea()
dbSelectArea("SE1")


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
aVal[46,1] := nVaRec 
aVal[45,1] := nRecebido-(nValJuros+nVaRec+nMulta+nCorrecao-nDesconto)
dDataBase := dOldDtBase // Restaura Data base

Return aVal

//-------------------------------------------------------------------
/*/{Protheus.doc} Fr320Situa
Função para retornar as informações do cadastro de situacao de cotrança

@return aSituaca - Array contendo as seguintes informações
					[1] - Codigo da situacao de Cobranca
					[2] - Descricao da situacao de cobranca
					[3] - Valor (a ser alimentado posteriormente)
					[4] - Quantidade de titulos (a ser alimentado posteriormente)

@author pequim

@since 09/12/2013
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function Fr320Situa()

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

//-------------------------------------------------------------------
/*/{Protheus.doc} FR320Chk()
Função para uso temporário, validando se a pergunta 15 existe no dicionário

@Author Pedro Pereira Lima
@Since 29/08/2017
@Version 12.1.17
/*/
//-------------------------------------------------------------------
Static Function FR320CHK()
Local lRet := .F.

SX1->(DbSetOrder(1))
lRet := SX1->(DbSeek('FIN320    ' + '15'))

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} FR320RtImp
Efetua a validacao na exclusao do titulo 

@author Bruno Horvat
@since 31/05/2021
@version 12.1.27
/*/
//-------------------------------------------------------------------
Static Function FR320RtImp(cFiltro)

Local aTitulos := {}
Local aAreaSE1	:= SE1->(GetArea())

dbSelectArea("SED")
dbSetOrder(1)
If MSSeek (FwxFilial("SED")+cFiltro)
    If SED->ED_CALCIRF=="S"
         AADD(aTitulos,{MVIRABT, .T.})
     EndIf
       If SED->ED_CALCINS=="S"
           AADD(aTitulos,{MVINABT,.T.})
       EndIf
     If SED->ED_CALCPIS=="S"
         AADD(aTitulos,{MVPIABT,.T.})
     EndIf
       If SED->ED_CALCCOF=="S"
         AADD(aTitulos,{MVCFABT,.T.})
     EndIf
       If SED->ED_CALCCSL=="S"
         AADD(aTitulos,{MVCSABT,.T.})
       EndIf
     If SED->ED_CALCISS=="S"
         AADD(aTitulos,{MVISABT,.T.})
    EndIf
    //ISS Bitributado
    If SED->ED_CALCISS=="S"
         AADD(aTitulos,{MVI2ABT,.T.})
    EndIf
EndIf

RestArea(aAreaSE1)

Return aTitulos

//-------------------------------------------------------------------
/*/{Protheus.doc} hashNatur
Faz querypara verificar se existe abatimento para determido cliente

@author Bruno Horvat
@since 31/05/2021
@version 12.1.27
/*/
//-------------------------------------------------------------------
Static Function HashNatur(cTipoIn)

Local cQuery
Local cAreaAtu // := Alias()//- salvo o alias aberto
Local lTemCli := .F.
Local lFlag
Default cTipoIn := ""

lTemCli := __oHash:Get( SE1->(E1_CLIENTE+E1_LOJA) , lFlag )

If !lTemCli
    cAreaAtu := Alias()//- salvo o alias aberto
    cQuery := " SELECT Max(R_E_C_N_O_) AS RECNO"
    cQuery += "   FROM " + RetSqlName("SE1")+" SE1 "
    cQuery += "  WHERE SE1.E1_FILIAL = '"+FwxFilial("SE1")+"'"
    cQuery += "    AND SE1.E1_CLIENTE = '"+SE1->E1_CLIENTE+"'"
    cQuery += "    AND SE1.E1_LOJA = '"+SE1->E1_LOJA+"'"
    cQuery += "    AND SE1.E1_TIPO IN "  + U_FR320TpIn(@cTipoIn)
    cQuery += "    AND SE1.D_E_L_E_T_ = ' ' "

    dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"HashNatur",.T.,.T.)

    If !Eof()
        lTemCli := __oHash:Set( SE1->(E1_CLIENTE+E1_LOJA) , .T. )
    Endif

    HashNatur->(dbCloseArea())

    //- restauro o alias anterior
    dbSelectArea(cAreaAtu)
EndIf

Return (lTemCli)

//-------------------------------------------------------------------
/*/{Protheus.doc} FR320TpIn
Formata a expressa para IN ou NOT IN

@author Bruno Horvat
@since 31/05/2021
@version 12.1.27
/*/
//-------------------------------------------------------------------
User Function FR320TpIn(cTipoIn)
Local cTiposAbt	:= MVABATIM +"|"+MVFUABT
Default cTipoIn   := ""

If cTipoIn == ""
    cTipoIn	:=	StrTran(cTiposAbt,',','/')
    cTipoIn	:=	StrTran(cTipoIn,';','/')
    cTipoIn	:=	StrTran(cTipoIn,'|','/')
    cTipoIn	:=	StrTran(cTipoIn,'\','/')

    cTipoIn := Formatin(cTipoIn,"/")
Endif

Return cTipoIn
