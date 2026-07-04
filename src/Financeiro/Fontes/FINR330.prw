/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "finr330.ch"
#include "protheus.ch"

/*/{Protheus.doc} FINR330
Posição geral do contas a pagar.

@author	  Adrianne Furtado
@since    06/06/2006
/*/
User Function FINR330()

Local oReport
Local aArea := GetArea()
Local cPerg := "FIR330"		// Nome do grupo de perguntas
PRIVATE aReturn := { OemToAnsi(STR0003), 1,OemToAnsi(STR0004), 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"

oReport := ReportDef( cPerg )
oReport:PrintDialog()

RestArea( aArea )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef ºAutora ³Adrianne Furtado    º Data ³  13/06/06  º±±
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

Local cReport	:= "FINR330" // Nome do relatorio
Local cTitulo	:= STR0005	 // Titulo do relatorio -> "Posicao Geral do Contas a Pagar"
Local cDescri	:= STR0001 +" "+ STR0002// "Este programa irá emitir a posição geral do contas a pagar" | "referente a data base do sistema."
Local oReport
Local oFornece
Local oSection1
Local oSection2
Local oSection3
Local oSection4
Local oSection5
Local oSection6
Local oSection7
Local oSection8

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
oReport  := TReport():New( cReport , cTitulo, cPerg, { |oReport| U_FINR330Imp( oReport ) }, cDescri )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oFornece    := TRSection():New( oReport, STR0045, {"SA2"}, )//"Fornecedor"
TRCell():New( oFornece   , "A2_COD"	,"SA2",,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oFornece   , "A2_LOJA"	,"SA2",,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oFornece   , "A2_NOME"	,"SA2",,/*Picture*/,,/*lPixel*/,/*{|| code-block de impressao }*/)

oFornece:SetNoFilter({"SA2"})
oFornece:HideHeader()
oFornece:Hide()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oFornece , STR0046, {"SE2","SED"}, )															// "Compras (no mes)"
TRCell():New( oSection1, "CelDesc"	,,""						,/*Picture*/,70,/*lPixel*/,/*{|| code-block de impressao }*/)	// Descricao
TRCell():New( oSection1, "CelValor"	,,STR0039+GetMv("MV_SIMB1"),"@E 999,999,999,999.99",30,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor
TRCell():New( oSection1, "CelQuant"	,,STR0040		 			, 								,30/*lPixel*/,/*{|| code-block de impressao }*/)	// Quantidade

oSection2 := TRSection():New( oFornece, STR0047, {"SE2","SED"} )	// "Valores baixados"
TRCell():New( oSection2, "CelDesc"	,,,/*Picture*/,70,/*lPixel*/,/*{|| code-block de impressao }*/)					// Descricao
TRCell():New( oSection2, "CelValor"	,,,"@E 999,999,999,999.99",30,,/*{|| code-block de impressao }*/)					// Valor
TRCell():New( oSection2, "CelQuant"	,,,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Quantidade

oSection3 := TRSection():New( oFornece, STR0048, {"SE2","SED"} )	// "Titulos a vencer"
TRCell():New( oSection3, "CelDesc"	,,,/*Picture*/,70,/*lPixel*/,/*{|| code-block de impressao }*/)					// Descricao
TRCell():New( oSection3, "CelValor"	,,,"@E 999,999,999,999.99",30,,/*{|| code-block de impressao }*/)					// Valor
TRCell():New( oSection3, "CelQuant"	,,,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Quantidade

oSection4 := TRSection():New( oFornece, STR0049, {"SE2","SED"} )	// "Titulos vencidos"
TRCell():New( oSection4, "CelDesc"	,,,/*Picture*/,70,/*lPixel*/,/*{|| code-block de impressao }*/)					// Descricao
TRCell():New( oSection4, "CelValor"	,,,"@E 999,999,999,999.99",30,,/*{|| code-block de impressao }*/)					// Valor
TRCell():New( oSection4, "CelQuant"	,,,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Quantidade

oSection5 := TRSection():New( oFornece, STR0050, {"SE2","SED"} )	// "Por tipo de titulo"
TRCell():New( oSection5, "CelDesc"	,,,/*Picture*/,70,/*lPixel*/,/*{|| code-block de impressao }*/)					// Descricao
TRCell():New( oSection5, "CelValor"	,,,"@E 999,999,999,999.99",30,,/*{|| code-block de impressao }*/)					// Valor
TRCell():New( oSection5, "CelQuant"	,,,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Quantidade

// Pedidos de Compras
oSection6 := TRSection():New( oFornece, STR0051, {"SE2","SED"} )	// "Pedidos de compra atrasados"
TRCell():New( oSection6, "CelDesc"	,,,/*Picture*/,70,/*lPixel*/,/*{|| code-block de impressao }*/)					// Descricao
TRCell():New( oSection6, "CelValor"	,,,"@E 999,999,999,999.99",30,,/*{|| code-block de impressao }*/)					// Valor
TRCell():New( oSection6, "CelQuant"	,,,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Quantidade

oSection7 := TRSection():New( oFornece, STR0052, {"SE2","SED"} )	// "Pedidos de compra adiantados"
TRCell():New( oSection7, "CelDesc"	,,,/*Picture*/,70,/*lPixel*/,/*{|| code-block de impressao }*/)					// Descricao
TRCell():New( oSection7, "CelValor"	,,,"@E 999,999,999,999.99",30,,/*{|| code-block de impressao }*/)					// Valor
TRCell():New( oSection7, "CelQuant"	,,,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Quantidade

// "PRAZOS MEDIOS E QUOCIENTE DE ATRASO"
oSection8 := TRSection():New( oFornece,STR0053, {"SE2","SED"} )	// "Prazos medios e quociente de atraso"
TRCell():New( oSection8, "CelDesc"	,,,/*Picture*/,70,/*lPixel*/,/*{|| code-block de impressao }*/)					// Descricao
TRCell():New( oSection8, "CelValor"	,,,,30,,/*{|| code-block de impressao }*/)					// Valor
TRCell():New( oSection8, "CelQuant"	,,,"@E 999,999,999,999.99",30,/*lPixel*/,/*{|| code-block de impressao }*/)					// Quantidade

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ FINR330Imp ºAutor³Adrianne Furtado    º Data ³  07/06/06   º±±
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
User Function FINR330Imp( oReport )
Local oFornece  := oReport:Section(1)
Local oSection1 := oReport:Section(1):Section(1)
Local oSection2 := oReport:Section(1):Section(2)
Local oSection3 := oReport:Section(1):Section(3)
Local oSection4 := oReport:Section(1):Section(4)
Local oSection5 := oReport:Section(1):Section(5)
Local oSection6 := oReport:Section(1):Section(6)
Local oSection7 := oReport:Section(1):Section(7)
Local oSection8 := oReport:Section(1):Section(8)

Local cFilSE2	:= ""
Local nLinha	:= 0
Local aVal
Local aValor	:= {}

aVal := FA330Calc(,,,oReport)

cFilSE2 := oFornece:GetAdvplExp("SE2")

// Aplica filtro do usuario na secao 1
If !Empty( cFilSE2 )
	oSection1:SetFilter( cFilSE2 )
EndIf

aADD(aValor,{STR0010,aVal[1,1]	,""	})  			//"COMPRAS (no mes)"
aADD(aValor,{STR0011,aVal[1,2]	,""	}) 				//"A Vista"
aADD(aValor,{STR0012,aVal[1,3]	,""	}) 				//"A Prazo"

aADD(aValor,{STR0013,""			,""	}) 				//"VALORES BAIXADOS"
aADD(aValor,{STR0014,aVal[2,1]	,""	}) 				//"Recebido"             //STR0060 "Recebido"
aADD(aValor,{STR0015,aVal[2,2]	,""	}) 				//"Taxa de Permanencia"  //STR0061 "Taxa de Permanencia"
aADD(aValor,{STR0016,aVal[2,3]	,""	}) 				//"Multa"                //STR0062
aADD(aValor,{STR0017,aVal[2,4]	,""	}) 				//"Correcao"             //STR0063
aADD(aValor,{STR0018,aVal[2,5]	,""	}) 				//"Descontos"            //STR0064
aADD(aValor,{STR0019,aVal[2,6]	,""	}) 				//"Pgto Antecipado"
aADD(aValor,{STR0054,aVal[2,7]  ,""}) 				//"Valores Acessórios"

aADD(aValor,{STR0020,(aVal[2,1]-aVal[2,2]-aVal[2,3]-aVal[2,4]+aVal[2,5]),""	}) 	//"ORIGINAL"

//"TITULOS A VENCER"
aADD(aValor,{STR0021,aVal[3,1,1],aVal[3,1,2]		})
aADD(aValor,{STR0022,aVal[3,2,1],aVal[3,2,2]		}) 				//"Ate 15 Dias"
aADD(aValor,{STR0023,aVal[3,3,1],aVal[3,3,2]		}) 				//"De 16 a 30 dias"
aADD(aValor,{STR0024,aVal[3,4,1],aVal[3,4,2]		}) 				//"De 31 a 60 dias"
aADD(aValor,{STR0025,aVal[3,5,1],aVal[3,5,2]		}) 				//"De 61 a 90 dias"
aADD(aValor,{STR0026,aVal[3,6,1],aVal[3,6,2]		}) 				//"Acima de 90 Dias

//"TITULOS VENCIDOS"
aADD(aValor,{STR0027,aVal[4,1,1],aVal[4,1,2]		})
aADD(aValor,{STR0022,aVal[4,2,1],aVal[4,2,2]		}) 				//"Ate 15 Dias"
aADD(aValor,{STR0023,aVal[4,3,1],aVal[4,3,2]		}) 				//"De 16 a 30 dias"
aADD(aValor,{STR0024,aVal[4,4,1],aVal[4,4,2]		}) 				//"De 31 a 60 dias"
aADD(aValor,{STR0025,aVal[4,5,1],aVal[4,5,2]		}) 				//"De 61 a 90 dias"
aADD(aValor,{STR0026,aVal[4,6,1],aVal[4,6,2]		}) 				//"Acima de 90 Dias

//"POR TIPO DE TITULO"
aADD(aValor,{STR0028,(aVal[5,1]+aVal[5,2]+aVal[5,3]+aVal[5,4]+aVal[5,5]+aVal[5,6]+aVal[5,7]+aVal[5,8]),""	})
aADD(aValor,{STR0029,aVal[5,1],""	}) 				//"Duplicatas"
aADD(aValor,{STR0030,aVal[5,2],""	}) 				//"Notas Fiscais"
aADD(aValor,{STR0031,aVal[5,3],""	}) 				//"Cheques Pre-Datados"
aADD(aValor,{STR0032,aVal[5,4],""	}) 				//"Carnet De Pagamento"
aADD(aValor,{STR0033,aVal[5,5],""	}) 				//"Impostos"
aADD(aValor,{STR0034,aVal[5,6],""	}) 				//"Pagamentos Antecipados"
aADD(aValor,{STR0035,aVal[5,7],""	}) 				//"Notas de Debito"
aADD(aValor,{STR0036,aVal[5,8],""	}) 				//"Outros"

// Pedidos de Compras
If mv_par07 == 1
	//"PEDIDOS DE COMPRA ATRASADOS"
	aADD(aValor,{STR0037,(aVal[6,1]+aVal[6,2]+aVal[6,3]+aVal[6,4]+aVal[6,5]),""	})
	aADD(aValor,{STR0022,aVal[6,1],""	}) 				//"Ate 15 Dias"
	aADD(aValor,{STR0023,aVal[6,2],""	}) 				//"De 16 a 30 dias"
	aADD(aValor,{STR0024,aVal[6,3],""	}) 				//"De 31 a 60 dias"
	aADD(aValor,{STR0025,aVal[6,4],""	}) 				//"De 61 a 90 dias"
	aADD(aValor,{STR0026,aVal[6,5],""	}) 				//"Acima de 90 Dias
	//"PEDIDOS DE COMPRA ADIANTADOS"
	aADD(aValor,{STR0038,(aVal[7,1]+aVal[7,2]+aVal[7,3]+aVal[7,4]+aVal[7,5]),""	})
	aADD(aValor,{STR0022,aVal[7,1],""	}) 				//"Ate 15 Dias"
	aADD(aValor,{STR0023,aVal[7,2],""	}) 				//"De 16 a 30 dias"
	aADD(aValor,{STR0024,aVal[7,3],""	}) 				//"De 31 a 60 dias"
	aADD(aValor,{STR0025,aVal[7,4],""	}) 				//"De 61 a 90 dias"
	aADD(aValor,{STR0026,aVal[7,5],""	}) 				//"Acima de 90 Dias
EndIf

aADD(aValor,{STR0041,"" ,(aVal[8,1,1]/aVal[8,1,2])	}) 				//"Prazo Medio Absoluto"
aADD(aValor,{STR0042,"" ,(aVal[8,2,1]/aVal[8,2,2])	}) 				//"Prazo Medio Ponderado"
aADD(aValor,{STR0043,"" ,(((aVal[6,1]+aVal[2,2]+aVal[6,3]+aVal[6,4]+aVal[6,5])/aVal[6,6]))*100})	//"Quociente De Atraso"

oReport:SetMeter(Len(aValor))

oFornece:Init()
oFornece:PrintLine()
oFornece:Finish()

// primeira secao  --> "COMPRAS (no mes)"
oSection1:Init()

oSection1:Cell("CelDesc" ):SetBlock( { || aValor[nLinha,1] } )
oSection1:Cell("CelValor"):SetBlock( { || aValor[nLinha,2] } )
oSection1:Cell("CelQuant"):SetBlock( { || aValor[nLinha,3] } )
oSection1:Cell("CelValor"):SetHeaderAlign("RIGHT")
oSection1:Cell("CelQuant"):SetHeaderAlign("RIGHT")
oSection1:Cell("CelValor"):SetPicture(PesqPict("SE5","E5_VALOR",oSection1:Cell("CelValor"):nSize,mv_par09))
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
For nLinha := 4 to 12
	If nLinha == 4
		oSection2:Cell("CelValor"):SetPicture("") //Não deve utilizar picture no titulo da secao que n imprime valores
	ElseIf nLinha == 5
		oSection2:Cell("CelValor"):SetPicture(PesqPict("SE5","E5_VALOR",oSection2:Cell("CelValor"):nSize,mv_par09))
	EndIf
	oReport:IncMeter()
	oSection2:PrintLine()
Next
oSection2:Finish()

// terceira secao --> "TITULOS A VENCER"
oSection3:Init()
oSection3:SetHeaderSection(.F.)
oReport:ThinLine()
oSection3:Cell("CelDesc" ):SetBlock( { || aValor[nLinha,1] } )
oSection3:Cell("CelValor"):SetBlock( { || aValor[nLinha,2] } )
oSection3:Cell("CelQuant"):SetBlock( { || aValor[nLinha,3] } )
oSection3:Cell("CelValor"):SetPicture(PesqPict("SE5","E5_VALOR",oSection3:Cell("CelValor"):nSize,mv_par09))
For nLinha := 13 to 18
	oReport:IncMeter()
	oSection3:PrintLine()
Next
oSection3:Finish()

// quarta secao --> TITULOS VENCIDOS
oSection4:Init()
oSection4:SetHeaderSection(.F.)
oReport:ThinLine()
oSection4:Cell("CelDesc" ):SetBlock( { || aValor[nLinha,1] } )
oSection4:Cell("CelValor"):SetBlock( { || aValor[nLinha,2] } )
oSection4:Cell("CelQuant"):SetBlock( { || aValor[nLinha,3] } )
oSection4:Cell("CelValor"):SetPicture(PesqPict("SE5","E5_VALOR",oSection4:Cell("CelValor"):nSize,mv_par09))
For nLinha := 19 to 24
	oReport:IncMeter()
	oSection4:PrintLine()
Next
oSection4:Finish()

// quinta secao --> "POR TIPO DE TITULO"
oSection5:Init()
oSection5:SetHeaderSection(.F.)
oReport:ThinLine()
oSection5:Cell("CelDesc" ):SetBlock( { || aValor[nLinha,1] } )
oSection5:Cell("CelValor"):SetBlock( { || aValor[nLinha,2] } )
oSection5:Cell("CelQuant"):SetBlock( { || aValor[nLinha,3] } )
oSection5:Cell("CelValor"):SetPicture(PesqPict("SE5","E5_VALOR",oSection5:Cell("CelValor"):nSize,mv_par09))
For nLinha := 25 to 33
	oReport:IncMeter()
	oSection5:PrintLine()
Next
oSection5:Finish()
// Pedidos de Compras

If mv_par07 == 1
	// sexta secao -->"PEDIDOS DE COMPRA ATRASADOS"
	oSection6:Init()
	oSection6:SetHeaderSection(.F.)
	oReport:ThinLine()
	oSection6:Cell("CelDesc" ):SetBlock( { || aValor[nLinha,1] } )
	oSection6:Cell("CelValor"):SetBlock( { || aValor[nLinha,2] } )
	oSection6:Cell("CelQuant"):SetBlock( { || aValor[nLinha,3] } )
	oSection6:Cell("CelValor"):SetPicture(PesqPict("SE5","E5_VALOR",oSection6:Cell("CelValor"):nSize,mv_par09))
	For nLinha := 34 to 39
		oReport:IncMeter()
		oSection6:PrintLine()
	Next
	oSection6:Finish()

	// sétima secao  --> "PEDIDOS DE COMPRA ADIANTADOS"
	oSection7:Init()
	oSection7:SetHeaderSection(.F.)
	oReport:ThinLine()
	oSection7:Cell("CelDesc" ):SetBlock( { || aValor[nLinha,1] } )
	oSection7:Cell("CelValor"):SetBlock( { || aValor[nLinha,2] } )
	oSection7:Cell("CelQuant"):SetBlock( { || aValor[nLinha,3] } )
	oSection7:Cell("CelValor"):SetPicture(PesqPict("SE5","E5_VALOR",oSection7:Cell("CelValor"):nSize,mv_par09))
	For nLinha := 40 to 45
		oReport:IncMeter()
		oSection7:PrintLine()
	Next
	oSection7:Finish()

	oSection8:Init()
	oSection8:SetHeaderSection(.F.)
	oReport:ThinLine()
	oSection8:Cell("CelDesc" ):SetBlock( { || aValor[nLinha,1] } )
	oSection8:Cell("CelValor"):SetBlock( { || aValor[nLinha,2] } )
	oSection8:Cell("CelQuant"):SetBlock( { || aValor[nLinha,3] } )

	For nLinha := 46 to 48
		oReport:IncMeter()
		oSection8:PrintLine()
	Next
	oSection8:Finish()
Else

	oSection6:Hide()
	oSection7:Hide()

	oSection8:Init()
	oSection8:SetHeaderSection(.F.)
	oReport:ThinLine()
	oSection8:Cell("CelDesc" ):SetBlock( { || aValor[nLinha,1] } )
	oSection8:Cell("CelValor"):SetBlock( { || aValor[nLinha,2] } )
	oSection8:Cell("CelQuant"):SetBlock( { || aValor[nLinha,3] } )
	For nLinha := 34 to 36
		oReport:IncMeter()
		oSection8:PrintLine()
	Next
	oSection8:Finish()
EndIf
Return


Static Function InSide(cTp)
Local lRet := .T.
IF mv_par03 != 1
	lRet := .T.
Else
	lRet := (cTp $ cTipos)
Endif
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Fa330Saldo³ Autor ³ Alessandro Freire     ³ Data ³ 16.01.97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o saldo do item do pedido                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_Fa330Saldo()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Fa330Saldo()
LOCAL nRetSaldo := 0

If (C7_QUANT-C7_QUJE) > 0
	If !Empty( SC7->C7_TES )
		dbSelectArea("SF4")
		dbSetOrder(1)
		dbSeek( xFilial("SF4")+SC7->C7_TES )
		If mv_par11 == 1		// Verifica se ir  considerar o TES (F4_DUPLIC)
			If SF4->F4_DUPLIC == "S"
				nRetSaldo := (SC7->C7_QUANT - SC7->C7_QUJE) * SC7->C7_PRECO
			Endif
		Else
			nRetSaldo := (SC7->C7_QUANT - SC7->C7_QUJE) * SC7->C7_PRECO
		EndIf
	EndIf
EndIf
dbSelectArea("SC7")
Return(nRetSaldo)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Fa330Calc ³ Autor ³ Adrianne Furtado      ³ Data ³ 13.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna o saldo do item do pedido                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ Fa330Calc()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Fa330Calc(lEnd,wnRel,cString,oReport)

// Acumuladores
LOCAL aCompras 	:= {}
LOCAL aBaixados	:= {}
LOCAL aVencer 		:= {}
LOCAL aVencidos 	:= {}
LOCAL aAcessoFil  := {}
LOCAL aTipos 		:= {}
LOCAL aAdiantados := {}
LOCAL aAtrasados 	:= {}
Local aValores 	:= {}
Local aMedia      := {}
LOCAL nX 			:= 0
LOCAL nSaldo 		:= 0
Local nDias			:= 0
Local nSaldoAtu	:= 0
LOCAL cArq 			:= ""
Local cCondFil
Local cFilterUser :=	aReturn[7]
Local nDecs 		:= MsDecimais(mv_par09)
Local cAliasTmp
Local nTipoData 	:= 1
Local cSQLSE2		:=	Nil
Local cFiltSED		:=	Nil
LOCAL dDataBaixa
Local nMoedaBco := 1
LOCAL nRecebido:=0
Local cQuery

cSQLSE2	:=	If(oReport<>Nil,oReport:Section(1):GetSqlExp('SE2'),Nil)

aAcessoFil := 	MatFilCalc(.F.)

If oReport <> Nil
	cFiltSED		:=	If(oReport<>Nil,oReport:Section(1):GetAdvplExp('SED'),Nil)
Endif
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
li       := 80
m_pag    := 1
PRIVATE  cTipos := ""

//Zerar os Acumuladores

FOR nX:=1 TO 3
	Aadd(aCompras, 0 )
Next nX

FOR nX:=1 TO 7
	Aadd(aBaixados, 0 )
Next nX

FOR nX:=1 TO 6
	Aadd(aVencer, { 0, 0 } )
Next nX

FOR nX:=1 TO 6
	Aadd(aVencidos, { 0, 0 } )
Next nX

FOR nX:=1 TO 10
	Aadd(aTipos, 0 )
Next nX

FOR nX:=1 TO 6
	Aadd(aAtrasados, 0 )
Next nX

FOR nX:=1 TO 5
	Aadd(aAdiantados, 0 )
Next nX

FOR nX:=1 TO 2
	Aadd(aMedia, {0,0})
Next nX

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se seleciona tipos para total pagamento           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par03 == 1
	finaTipos()
Endif

dbSelectArea("SE2")

dbSetOrder(1)
If mv_par01 == 1
	dbSeek(xFilial("SE2"))
Else
	dbGotop()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtra APENAS os emitidos antes da database, pois este rela³
//³ torio pode ser retroativo.                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aStru  := SE2->(dbStruct())
cAliasTmp := "FINR330"
cQuery := ""
aEval(aStru,{|x| cQuery += ","+AllTrim(x[1])})
cQuery := "SELECT "+SubStr(cQuery,2)
cQuery +=         ",R_E_C_N_O_ RECNO "
cQuery += "FROM "+RetSqlName("SE2")+ " SE2 "
cQuery += "WHERE "
If mv_par01 == 1
	cQuery += "SE2.E2_FILIAL ='"+xFilial("SE2")+"' AND "
Else
	cQuery += "SE2.E2_FILIAL IN ( "
	cQuery += FilQryIn("SE2", aAcessoFil)
	cQuery += ") AND "
Endif
cQuery += "SE2.E2_EMISSAO <= '"+Dtos(dDataBase)+"' AND "
cQuery += "SE2.E2_PREFIXO >= '"+MV_PAR04+"' AND "
cQuery += "SE2.E2_PREFIXO <= '"+MV_PAR05+"' AND "
If mv_par10 == 2
	cQuery += "SE2.E2_MOEDA = "+Str(MV_PAR09,2)+" AND "
Endif

If !Empty(cSQLSE2)
	cQuery += "("+cSqlSE2 +") AND "
Endif

cQuery += "SE2.D_E_L_E_T_=' ' "

cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTmp,.T.,.T.)
For nX := 1 To Len(aStru)
	If aStru[nX][2] <> "C"
		TcSetField(cAliasTmp,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
	EndIf
Next nX

// Leitura do SE2 (Contas a Pagar)
dbSelectArea(cAliasTmp)

While !Eof()

	dbSelectArea(cAliasTmp)

	IF lEnd
		Exit
	End

	If mv_par03 == 1
		If !Inside(E2_TIPO)
			dbSkip()
			Loop
		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro do usuario                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cFilterUser).and.!(&cFilterUser)
		dbSkip()
		Loop
	Endif

	IF !Empty(E2_FATURA) .and. Substr(E2_FATURA,1,6) != "NOTFAT" .and. E2_DTFATUR <= dDataBase
		dbSkip()
		Loop
	Endif

	If mv_par01 == 1 .and. E2_FILIAL != xFilial("SE2")
		Exit
	EndIF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se ‚ provis¢rio ou abatimento ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If E2_TIPO $ MVPROVIS+"/"+MVABATIM
		dbSkip()
		Loop
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro do usuario - SED                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cFiltSED)
		SED->(DbSetOrder(1))
		SED->(MsSeek(xFilial()+(cAliasTmp)->E2_NATUREZ))
		If SED->(!&(cFiltSED))
			DbSkip()
			Loop
		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula o faturamento baseado na data base/item 1 analise    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Month(E2_EMISSAO) == Month(dDatabase) .and. Year(E2_EMISSAO) == Year(dDataBase)
		If Inside(E2_TIPO) .and. !(E2_TIPO $MV_CPNEG+"/"+MVPAGANT)
			nDias := (E2_VENCREA - E2_EMISSAO)
			aCompras[1] += xMoeda(E2_VALOR,E2_MOEDA,MV_PAR09,,,If(cPaisLoc=="BRA",E2_TXMOEDA,0))
			If nDias <= 1
				aCompras[2] += xMoeda(E2_VALOR,E2_MOEDA,MV_PAR09,,,If(cPaisLoc=="BRA",E2_TXMOEDA,0))
			Else
				aCompras[3] += xMoeda(E2_VALOR,E2_MOEDA,MV_PAR09,,,If(cPaisLoc=="BRA",E2_TXMOEDA,0))
			Endif
		Endif
	Endif

	nSaldoAtu := 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acumula titulos vencidos/vencer / Item 2 e 3 da analise      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par08 == 1
		// Posiciona SE2 ou SE1 para pegar o saldo do titulo correto
		SE2->(DbGoto((cAliasTmp)->RECNO))
		nSaldoAtu := SaldoTit( 	E2_PREFIXO,;
								E2_NUM,;
								E2_PARCELA,;
								E2_TIPO,;
								E2_NATUREZ,;
								"P",;
								E2_FORNECE,;
								MV_PAR09,;
								dDataBase,;
								dDataBase,;
								E2_LOJA,;
								E2_FILIAL,;
								IIf(cPaisLoc=="BRA",E2_TXMOEDA,0),nTipoData )

	Else
		If cPaisLoc == "BRA"
			nSaldoAtu := xMoeda(E2_SALDO,E2_MOEDA,mv_par09,,,If(cPaisLoc=="BRA",E2_TXMOEDA,0))
		Else
			nSaldoAtu := xMoeda(E2_SALDO,E2_MOEDA,mv_par09,E2_EMISSAO,nDecs+1,If(cPaisLoc=="BRA",E2_TXMOEDA,0))
		EndIf
	Endif
	If nSaldoAtu > 0
		nSaldoAtu-=SomaAbat(E2_PREFIXO,E2_NUM,E2_PARCELA,"P",1,,E2_FORNECE,E2_LOJA,E2_FILIAL)
	Endif
	nSaldoAtu:=Round(NoRound(nSaldoAtu,3),2)

	If E2_TIPO $ (MVPAGANT + "/" + MV_CPNEG)		// Substrai as Notas de Debitou ou Adiantamentos
		nSaldoAtu := nSaldoAtu * -1
	Endif

	If nSaldoAtu <> 0
		dBaixa := dDataBase
		nJuros := 0
		If mv_par06 == 1
			fa080juros(mv_par09)
		Endif
		If dDataBase <= E2_VENCREA .OR. E2_TIPO $ MVPAGANT		//Titulos a vencer			//Titulos a vencer
			nSaldoAtu+=nJuros
			aVencer[1][1] += nSaldoAtu
			aVencer[1][2] ++
			nDias := (E2_VENCREA - dDatabase)
			If nDias <= 15
				aVencer[2][1] += nSaldoAtu
				aVencer[2][2] ++
			ElseIf nDias > 15 .And. nDias <= 30
				aVencer[3][1] += nSaldoAtu
				aVencer[3][2] ++
			ElseIf nDias > 30 .And. nDias <= 60
				aVencer[4][1] += nSaldoAtu
				aVencer[4][2] ++
			ElseIf nDias > 60 .And. nDias <= 90
				aVencer[5][1] += nSaldoAtu
				aVencer[5][2] ++
			Else
				aVencer[6][1] += nSaldoAtu
				aVencer[6][2] ++
			Endif
		Else		 	// Titulos Vencidos
			aVencidos[1][1] += nSaldoAtu
			aVencidos[1][2] ++
			nDias := (dDatabase - E2_VENCTO)
			If nDias <= 15
				aVencidos[2][1] += nSaldoAtu
				aVencidos[2][2] ++
			ElseIf nDias > 15 .And. nDias <= 30
				aVencidos[3][1] += nSaldoAtu
				aVencidos[3][2] ++
			ElseIf nDias > 30 .And. nDias <= 60
				aVencidos[4][1] += nSaldoAtu
				aVencidos[4][2] ++
			ElseIf nDias > 60 .And. nDias <= 90
				aVencidos[5][1] += nSaldoAtu
				aVencidos[5][2] ++
			Else
				aVencidos[6][1] += nSaldoAtu
				aVencidos[6][2] ++
			Endif
		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula Tipo de Titulo
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nSaldoAtu <> 0 .and. E2_EMISSAO <= dDatabase
		Do Case
			Case E2_TIPO  $ MVDUPLIC                    //Duplicatas
				aTipos[1] += nSaldoAtu
            Case E2_TIPO  $ MVNOTAFIS                   //Notas fiscais
				aTipos[2] += nSaldoAtu
			Case E2_TIPO  $ MVCHEQUES                   //Cheque Pre
				aTipos[3] += nSaldoAtu
			Case E2_TIPO   = "CN"                       //Carne de Pagamento
				aTipos[4] += nSaldoAtu
			Case E2_TIPO  $ MVTAXA						//Juros
				aTipos[5] += nSaldoAtu
			Case E2_TIPO  $ MVPAGANT                    //Pagamento antecipado
				aTipos[6] += nSaldoAtu
			Case E2_TIPO $ MV_CPNEG						//Nota de Debito
				aTipos[7] += nSaldoAtu
			OtherWise                                   //Total
				aTipos[8] += nSaldoAtu
		EndCase
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula o P.M.A e P.M.P - indices / item 7 da analise        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nSaldoAtu != 0
		aMedia[1][1] +=(E2_VENCREA-E2_EMISSAO)
		aMedia[1][2] += 1
		aMedia[2][1] += (E2_VENCREA-E2_EMISSAO)*;
					   xMoeda(nSaldoAtu,E2_MOEDA,mv_par09,E2_EMISSAO,nDecs+1,If(cPaisLoc=="BRA",E2_TXMOEDA,0))
		aMedia[2][2] += xMoeda(nSaldoAtu,E2_MOEDA,mv_par09,E2_EMISSAO,nDecs+1,If(cPaisLoc=="BRA",E2_TXMOEDA,0))
	EndIf

	dbSelectArea("SE5")
	dbSetOrder(7)
	IF dbSeek(xFilial("SE5")+ (cAliasTmp)->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE))
		IF SE5->E5_MOTBX $ 'DSD'
			aCompras[1] -= xMoeda((cAliasTmp)->E2_VALOR,(cAliasTmp)->E2_MOEDA,MV_PAR09,,,If(cPaisLoc=="BRA",(cAliasTmp)->E2_TXMOEDA,0))
			aCompras[2] -= xMoeda((cAliasTmp)->E2_VALOR,(cAliasTmp)->E2_MOEDA,MV_PAR09,,,If(cPaisLoc=="BRA",(cAliasTmp)->E2_TXMOEDA,0))
		EndIF
	EndIf

	dbSelectArea(cAliasTmp)
	(cAliasTmp)->(dbSkip())
EndDo


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Valor Recebido.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SE5")
If mv_par01 == 1
	dbSeek(xFilial("SE5"))
Else
	dbGotop()
Endif

aStru  := SE5->(dbStruct())
cAliasSe5 := "NEWSE5"
cCondFil := ""
aEval(aStru,{|x| cCondFil += ","+AllTrim(x[1])})
cCondFil := "SELECT "+SubStr(cCondFil,2)
cCondFil +=         ",R_E_C_N_O_ RECNO "
cCondFil += "FROM "+RetSqlName("SE5") + " SE5 "
cCondFil += "WHERE "
If mv_par01 == 1
	cCondFil += "E5_FILIAL = '" + xFilial("SE5") + "' AND "
Else
	cQuery += "SE5.E5_FILIAL IN ( "
	cQuery += FilQryIn("SE5", aAcessoFil)
	cQuery += ") AND "
Endif
cCondFil += "E5_TIPODOC IN ('VL','V2','JR','J2','CM','C2','MT','M2','DC','D2','TL','BA','PA','VA') AND E5_RECPAG = 'P' AND "
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
For nX := 1 To Len(aStru)
	If aStru[nX][2] <> "C"
		TcSetField(cAliasSe5,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
	EndIf
Next nX

(cAliasSE5)->(dbGoTop())

Do While (mv_par01 != 1 .OR. xFilial("SE5") == (cAliasSe5)->E5_FILIAL) .AND. !Eof()

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
		(cAliasSe5)->E5_RECPAG=="P" .and. dDataBaixa <= dDatabase .AND.;
		(cAliasSe5)->E5_TIPODOC$"VL/V2/BA/VA" ;
		.and.  (cAliasSe5)->E5_SITUACA <> "C" .and. ;
		(	MovBcoBx((cAliasSe5)->E5_MOTBX) .or. ;
		((cAliasSe5)->E5_MOTBX=="CMP" .and. (cAliasSe5)->E5_TIPO $ MVPAGANT+"#"+MV_CPNEG ) )
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se existe estorno para esta baixa                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SE5->(dbGoto((cAliasSe5)->RECNO))

		If !TemBxCanc((cAliasSe5)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ))
			nRecebido += xMoeda((cAliasSe5)->E5_VALOR,nMoedaBco,mv_par09,(cAliasSe5)->E5_DATA,nDecs+1,,If(cPaisLoc=="BRA",(cAliasSe5)->E5_TXMOEDA,0))
		EndIf
	EndIf

	If Month(dDatabase) = Month(dDataBaixa) .and. ;
      	Year(dDataBase)  = Year(dDataBaixa)  .and. (cAliasSe5)->E5_RECPAG=="P" .and. ;
		dDataBaixa <= dDatabase .and. (cAliasSe5)->E5_SITUACA <> "C" .and. ;
		MovBcoBx((cAliasSe5)->E5_MOTBX)
		nValorE5 := xMoeda((cAliasSe5)->E5_VALOR,nMoedaBco,mv_par09,(cAliasSe5)->E5_DATA,nDecs+1,,If(cPaisLoc=="BRA",(cAliasSe5)->E5_TXMOEDA,0))
    	Do Case
			Case (cAliasSe5)->E5_TIPODOC $ "VL/BA"     //Valor recebido
		 		aBaixados[1]+= nValorE5
			Case (cAliasSe5)->E5_TIPODOC $ "JR/J2/TL"  //Valor juros
            	aBaixados[2] += nValorE5
		 	Case (cAliasSe5)->E5_TIPODOC $ "CM/C2"     //Valor da correcao
            	aBaixados[4] += nValorE5
			Case (cAliasSe5)->E5_TIPODOC $ "MT/M2"     //Valor da Multa
            	aBaixados[3] += nValorE5
			Case (cAliasSe5)->E5_TIPODOC $ "DC/D2"     //Valor do Desconto
            	aBaixados[5] += nValorE5
   			Case (cAliasSe5)->E5_TIPODOC $ MVPAGANT     //Valor do Pagamento antecipado
            	aBaixados[6] += nValorE5
			Case (cAliasSe5)->E5_TIPODOC $ "VA"       // Valores Acessórios
				aBaixados[7] += nValorE5
		EndCase

	EndIf
	dbSelectArea(cAliasSe5)
	dbSkip()
Enddo

dbSelectArea(cAliasSe5)
dbSelectArea("SE5")

dbSelectArea("SE5")
DbClearFil()
RetIndex("SE5")
FErase(cArq+OrdBagExt())

dbSelectArea("SE5")
Set Filter to
Ferase(cArq+OrdBagExt())
dbSelectArea(cAliasTmp)

// Pedidos de Compras
If mv_par07 == 1

	dbSelectArea("SC7")
	If mv_par01 == 1
		dbSeek(xFilial("SC7"))
	Else
		dbGotop()
	Endif

	aStru  := SC7->(dbStruct())
	cCondFil := ""
	aEval(aStru,{|x| cCondFil += ","+AllTrim(x[1])})
	cCondFil := "SELECT "+SubStr(cCondFil,2)
	cCondFil +=         ",R_E_C_N_O_ RECNO "
	cCondFil += "FROM "+RetSqlName("SC7") + " SC7 "
	cCondFil += "WHERE "
	If mv_par01 == 1
		cCondFil += "C7_FILIAL='" + xFilial("SC7") + "' AND "
	Else
		cQuery += "SC7.C7_FILIAL IN ( "
		cQuery += FilQryIn("SC7", aAcessoFil)
		cQuery += ") AND "
	Endif
	cCondFil += "D_E_L_E_T_ = ' ' "

	cCondFil := ChangeQuery(cCondFil)

	dbSelectArea("SC7")
	dbCloseArea()
	dbSelectArea("SA2")

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cCondFil),"SC7",.T.,.T.)

	For nX := 1 To Len(aStru)
		If aStru[nX][2] <> "C"
			TcSetField("SC7",aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
		EndIf
	Next nX

	While (mv_par01 != 1 .OR. xFilial("SC7") == SC7->C7_FILIAL) .AND. !Eof()

		If SC7->C7_QUJE >= SC7->C7_QUANT 			//	 pedido já atendido
			dbSkip()
			Loop
		Endif

		nSaldo := U_Fa330Saldo()
		aAtrasados[6] += nSaldo
		If SC7->C7_DATPRF < dDataBase 			   // Pedidos atrasados
			nDias := dDataBase - SC7->C7_DATPRF
			If nDias <= 15
				aAtrasados[1] += nSaldo
			ElseIf nDias > 15 .And. nDias <= 30
				aAtrasados[2] += nSaldo
			ElseIf nDias > 30 .And. nDias <= 60
				aAtrasados[3] += nSaldo
			ElseIf nDias > 60 .And. nDias <= 90
				aAtrasados[4] += nSaldo
			Else
				aAtrasados[5] += nSaldo
			EndIf
		Else
			nDias := SC7->C7_DATPRF - dDataBase    // Pedidos adiantados
			If nDias <= 15
				aAdiantados[1] += nSaldo
			ElseIf nDias > 15 .And. nDias <= 30
				aAdiantados[2] += nSaldo
			ElseIf nDias > 30 .And. nDias <= 60
				aAdiantados[3] += nSaldo
			ElseIf nDias > 60 .And. nDias <= 90
				aAdiantados[4] += nSaldo
			Else
				aAdiantados[5] += nSaldo
			Endif
		Endif

		dbSelectArea("SC7")
		dbSkip()

	Enddo

Endif

If Select(cAliasTmp) <> 0
	dbSelectArea(cAliasTmp)
	dbCloseArea()
EndIf

If Select(cAliasSe5) <> 0
	dbSelectArea(cAliasSe5)
	dbCloseArea()
EndIf

dbSelectArea("SE2")
ChKFile("SE2")
dbSelectArea("SE2")
dbSetOrder(1)

dbSelectArea("SE5")
dbCloseArea()
ChKFile("SE5")
dbSelectArea("SE5")
dbSetOrder(1)

dbSelectArea("SC7")
dbCloseArea()
ChKFile("SC7")
dbSelectArea("SC7")
dbSetOrder(1)

If aReturn[5] = 1
	dbCommitAll()
Endif

AaDD(aValores, aCompras)
AaDD(aValores, aBaixados)
AaDD(aValores, aVencer)
AaDD(aValores, aVencidos)
AaDD(aValores, aTipos)
AaDD(aValores, aAtrasados)
AaDD(aValores, aAdiantados)
AaDD(aValores, aMedia)

Return aValores

/*/{Protheus.doc} FilQryIn
Retorna uma String com as Filiais para a Query

@author Guilherme Santos
@since 11/07/2017
@version 1.0
@param cTabQry, Tabela da Query
@param aAcessoFil, Filiais que o Usuario tem Acesso
@return cRetorno, Retorno da String com as Filiais para a Query
/*/
Static Function FilQryIn(cTabQry, aAcessoFil)
Local cRetorno	:= ""
Local nX 		:= 0

For nX := 1 to Len(aAcessoFil)
	If At(FWxFilial(cTabQry, aAcessoFil[nX][02]), cRetorno) == 0
		If Empty(cRetorno)
			cRetorno += "'" +  FWxFilial(cTabQry, aAcessoFil[nX][02]) + "'"
		Else
			cRetorno += ",'" +  FWxFilial(cTabQry, aAcessoFil[nX][02]) + "'"
		EndIf
	EndIf
Next nX

Return cRetorno
