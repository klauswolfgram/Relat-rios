/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR750.CH"
#include "PROTHEUS.CH"

Static _oFr750TRB

// 17/08/2009 - Compilacao para o campo filial de 4 posicoes
// 18/08/2009 - Compilacao para o campo filial de 4 posicoes

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FINR750  ³ Autor ³ Wagner Xavier         ³ Data ³ 08.05.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Eficiˆncia da Cobran‡a.                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR750(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR750()
Local oReport
Local aArea	:= GetArea()

oReport := ReportDef()
oReport:PrintDialog()

RestArea( aArea)  

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Marcio Menon		   º Data ³  15/08/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas.                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPC1 - Grupo de perguntas do relatorio                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ 												                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport
Local oSection1
Local cReport 	:= "FINR750" 				// Nome do relatorio
Local cDescri 	:= STR0001 + " "+;				//"Este programa ir  emitir um resumo referente ao contas a receber"
						STR0002   				//"referente aos ultimos 30 dias."
Local cTitulo 	:= OemToAnsi(STR0008)  //"Eficiencia do Contas a Receber"
Local cPerg		:= "FIN750"					// Nome do grupo de perguntas 
/*
GESTAO - inicio */
Local oSecFil	:= Nil
/* GESTAO - fim 
*/  
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Defini‡„o dos cabe‡alhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Ponto de entrada pela Microsiga
If ExistBlock("FR750TIT")
	ExecBlock("FR750TIT",.F.,.F.,cTitulo)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("FIN750",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                        ³
//³ mv_par01            // Prefixo de                           ³
//³ mv_par02            // Prefixo ate                          ³
//³ mv_par03            // Natureza de                          ³
//³ mv_par04            // Natureza ate                         ³
//³ mv_par05            // Seleciona tipos                      ³
//³ mv_par06            // Considera data base                  ³
//³ mv_par07            // Qual Moeda                           ³
//³ mv_par08            // Outras Moedas                        ³
//³ mv_par09            // Da Filial Origem                     ³
//³ mv_par10            // Até Filial Origem                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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
oReport := TReport():New(cReport, cTitulo, cPerg, {|oReport| ReportPrint(oReport, cTitulo)}, cDescri) 

oReport:lDisableOrientation := .T.
oReport:SetLandscape()	//Imprime o relatorio no formato paisagem


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                                                                        ³
//³                      Definicao das Secoes                              ³
//³                                                 aa                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 01                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New(oReport, STR0013, "cNomeArq")//"Saldo Anterior"

TRCell():New(oSection1,"TXTSALDO","", 														,/*Picture*/,30,/*lPixel*/,{|| OemToAnsi(STR0011) + DtoC(cNomeArq->D_DATA) })	//"ANTERIOR A "
TRCell():New(oSection1,"DESCO_A" ,"", STR0014+CRLF+STR0015+CRLF+STR0017	  	,Tm(0,14),14,/*lPixel*/,/*CodeBlock*/) //"VLS.RECEBIDOS" "S/ATRASO" "DESCONTO"
TRCell():New(oSection1,"ACRES_A" ,"", STR0014+CRLF+STR0015+CRLF+STR0018	,Tm(0,14),14,/*lPixel*/,/*CodeBlock*/) //"VLS.RECEBIDOS" "S/ATRASO" "ACRESCIMO"
TRCell():New(oSection1,"VALOR_C" ,"", STR0014+CRLF+STR0015+CRLF+STR0019 ,Tm(0,14),14,/*lPixel*/,/*CodeBlock*/) //"VLS.RECEBIDOS" "S/ATRASO" "TOT.RECEBIDO"
TRCell():New(oSection1,"DESCO_B" ,"", STR0014+CRLF+STR0016+CRLF+STR0017	  	,Tm(0,14),14,/*lPixel*/,{|| cNomeArq->DESCO_B }) //"VLS.RECEBIDOS" "C/ATRASO" "DESCONTO"
TRCell():New(oSection1,"ACRES_B" ,"", STR0014+CRLF+STR0016+CRLF+STR0018	,Tm(0,14),14,/*lPixel*/,{|| cNomeArq->ACRES_B }) //"VLS.RECEBIDOS" "C/ATRASO" "ACRESCIMO"
TRCell():New(oSection1,"VALOR_D" ,"", STR0014+CRLF+STR0016+CRLF+STR0019 ,Tm(0,14),14,/*lPixel*/,{|| cNomeArq->VALOR_D }) //"VLS.RECEBIDOS" "C/ATRASO" "TOT.RECEBIDO"
TRCell():New(oSection1,"NVALORE" ,"", STR0020+CRLF+STR0021+CRLF+STR0022,Tm(0,14),14,/*lPixel*/,/*CodeBlock*/) //"VALOR NAO PAGO" "NO DIA DO" "VENCIMENTO"
TRCell():New(oSection1,"EFICIEN" ,"", STR0023+CRLF+STR0024							  		,Tm(0,08),08,/*lPixel*/,/*CodeBlock*/) //"EFICIEN" "CIA (%)"
TRCell():New(oSection1,"VALOR_G" ,"", STR0025+CRLF+STR0026+DtoC(dDataBase)  		,Tm(0,14),14,/*lPixel*/,{|| cNomeArq->VALOR_G }) //"SALDO PENDENTE" "EM "

//Oculta as celulas
oSection1:Cell("DESCO_A"):Hide()
oSection1:Cell("ACRES_A"):Hide()
oSection1:Cell("VALOR_C"):Hide()
oSection1:Cell("NVALORE"):Hide()
oSection1:Cell("EFICIEN"):Hide()

oSection1:SetHeaderSection(.F.)	//Nao imprime o cabeçalho da secao

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 02                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New(oSection1, STR0027, "cNomeArq")

TRCell():New(oSection2,"D_DATA"  ,"", STR0028+CRLF+STR0029					,/*Picture*/,10,/*lPixel*/,{|| DtoC(cNomeArq->D_DATA) }	 )//"DATA" "VENCTO"
TRCell():New(oSection2,"VALOR_B" ,"", STR0030+CRLF+STR0031					,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->VALOR_B }		 ) //"VALOR DOS" "TITULOS"
TRCell():New(oSection2,"DESCO_A" ,"", STR0014+CRLF+STR0015+CRLF+STR0017		,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->DESCO_A }		 ) //"VLS.RECEBIDOS" "S/ATRASO" "DESCONTO"
TRCell():New(oSection2,"ACRES_A" ,"", STR0014+CRLF+STR0015+CRLF+STR0018		,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->ACRES_A }		 ) //"VLS.RECEBIDOS" "S/ATRASO" "ACRESCIMO"
TRCell():New(oSection2,"VALOR_C" ,"", STR0014+CRLF+STR0015+CRLF+STR0019		,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->VALOR_C }		 ) //"VLS.RECEBIDOS" "S/ATRASO" "TOT.RECEBIDO"
TRCell():New(oSection2,"DESCO_B" ,"", STR0014+CRLF+STR0016+CRLF+STR0017		,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->DESCO_B }		 ) //"VLS.RECEBIDOS" "C/ATRASO" "DESCONTO"
TRCell():New(oSection2,"ACRES_B" ,"", STR0014+CRLF+STR0016+CRLF+STR0018		,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->ACRES_B }		 ) //"VLS.RECEBIDOS" "C/ATRASO" "ACRESCIMO"
TRCell():New(oSection2,"VALOR_D" ,"", STR0014+CRLF+STR0016+CRLF+STR0019		,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->VALOR_D }		 ) //"VLS.RECEBIDOS" "C/ATRASO" "TOT.RECEBIDO"
TRCell():New(oSection2,"NVALORE" ,"", STR0020+CRLF+STR0021+CRLF+STR0022		,Tm(0,14)	,14,/*lPixel*/,/*CodeBlock*/				 ) //"VALOR NAO PAGO" "NO DIA DO" "VENCIMENTO"
TRCell():New(oSection2,"EFICIEN" ,"", STR0023+CRLF+STR0024					,Tm(0,08)	,08,/*lPixel*/,/*CodeBlock*/				 ) //"EFICIEN" "CIA (%)"
TRCell():New(oSection2,"VALOR_G" ,"", STR0025+CRLF+STR0026+DtoC(dDataBase)	,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->VALOR_G }		 ) //"SALDO PENDENTE" "EM "
TRCell():New(oSection2,"CREDDIA" ,"", STR0032+CRLF+STR0033+CRLF+STR0034		,Tm(0,08)	,08,/*lPixel*/,/*CodeBlock*/				 ) //"ATUAL VLR." "CREDITADO" "(%)"
TRCell():New(oSection2,"PGTDI_H" ,"", STR0032+CRLF+STR0033+CRLF+STR0035		,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->PGTDI_H }		 ) //"ATUAL VLR." "CREDITADO" "NO DIA"
TRCell():New(oSection2,"BAIXADIA","", STR0036+CRLF+STR0032 					,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->BAIXADIA }		 ) //"VALOR BAIXADO" "NO DIA"
TRCell():New(oSection2,"NOCREDIT","", STR0036+CRLF+STR0037					,Tm(0,14)	,14,/*lPixel*/,{|| cNomeArq->NOCREDIT }		 ) //"VALOR BAIXADO" "SEM CREDITO"

//Faz o alinhamento do cabecalho das celulas
oSection2:Cell("VALOR_B"):SetHeaderAlign("CENTER")
oSection2:Cell("DESCO_A"):SetHeaderAlign("CENTER")
oSection2:Cell("ACRES_A"):SetHeaderAlign("CENTER")
oSection2:Cell("VALOR_C"):SetHeaderAlign("CENTER")
oSection2:Cell("DESCO_B"):SetHeaderAlign("CENTER")
oSection2:Cell("ACRES_B"):SetHeaderAlign("CENTER")
oSection2:Cell("VALOR_D"):SetHeaderAlign("CENTER")
oSection2:Cell("VALOR_C"):SetHeaderAlign("CENTER")
oSection2:Cell("NVALORE"):SetHeaderAlign("CENTER")
oSection2:Cell("EFICIEN"):SetHeaderAlign("CENTER")
oSection2:Cell("VALOR_G"):SetHeaderAlign("CENTER")
oSection2:Cell("CREDDIA"):SetHeaderAlign("CENTER")
oSection2:Cell("PGTDI_H"):SetHeaderAlign("CENTER")
oSection2:Cell("BAIXADIA"):SetHeaderAlign("CENTER")
oSection2:Cell("NOCREDIT"):SetHeaderAlign("CENTER")

oSection2:SetHeaderPage(.T.)		//Define o cabecalho da secao como padrao
oSection2:SetTotalInLine (.F.) 	//O totalizador da secao sera impresso em coluna
/*
GESTAO - inicio */
/* Relacao das filiais selecionadas para compor o relatorio */
oSecFil := TRSection():New(oReport,"SECFIL","cNomeArq")
TRCell():New(oSecFil,"CODFIL",,STR0038,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0039,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0040,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0041,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)			//"Filial"
/* GESTAO - fim
*/
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrint ºAutor³ Marcio Menon       º Data ³  15/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime o objeto oReport definido na funcao ReportDef.     º±±                                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ oReport - Objeto TReport do relatorio                      º±±
±±º          ³ 										                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport)

Local oSection1 	:= oReport:Section(1) 
Local oSection2 	:= oReport:Section(1):Section(1)
Local cNomeArq
Local aCampos
Local nDias, dDtSeek, dDtPagto
Local i
Local nValorSe5, nTValorE := 0
Local nValorTitulo   	  := 0
Local nTotValB		:= 0
Local nTotValG		:= 0
Local lFirst  		:= .T.
Local cChaveSe1
Local nIndexSe1
Local cIndexSe1
Local cChaveSe5
Local cIndexSe5
Local nTotAbat 	:= 0
Local nTotDescoA	:= 0
Local nTotAcresA	:= 0
Local nTotValorC	:= 0
Local nTotDescoB	:= 0
Local nTotAcresB	:= 0
Local nTotValorD	:= 0
Local nTotPgtdi_h	:= 0
Local nTotBaixa 	:= 0
Local nTotNoCred	:= 0
Local lAnterior 	:= .F.
Local nValAdto 	:= 0
Local nMoeda    	:= mv_par07
Local nDecs     	:= MsDecimais(mv_par07)
Local nMoedaBco	:= 1
/*
GESTAO - inicio */
Local nRegSM0		:= 0
Local nLenSelFil	:= 0
Local cFilOrig		:= ""
Local cTitulo		:= ""
Local nTamEmp		:= 0
Local nTamUnNeg		:= 0
Local nLinha		:= 0
Local aTmpFil		:= {}

Local cTmpFil		:= {}
Local aSelFil		:= {}
Local aSM0			:= {}
Local oSecFil		:= oReport:Section("SECFIL")
Local cQryFilSE1	:= ""
/* GESTAO - fim 
*/
Local aStruArq	 := SE1->(dbStruct()), ni, cOrder
Local dDtLimite := dDataBase + 30
	
Private cTipos  := ""

oSection2:Cell("NVALORE"):SetBlock( { || nValorE } )
oSection2:Cell("EFICIEN"):SetBlock( { || (1-(nValorE/VALOR_B))*100 } )
oSection2:Cell("CREDDIA"):SetBlock( { || (1-(VALOR_G/VALOR_B))*100 } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se seleciona tipos para total faturamento         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par05 == 1
	finaTipos()
Endif

If Empty(aSelFil)
    AdmSelecFil("FIN750",0,.F.,@aSelFil,"SE1",.F.)
Endif

nLenSelFil := Len(aSelFil)
/* imprime a lista de filiais selecionadas para o relatorio */
If nLenSelFil > 0
	cQryFilSE1  := GetRngFil( aSelFil, "SE1", .T., @cTmpFil)
	Aadd(aTmpFil,cTmpFil)
	
	oSection2:SetHeaderSection(.F.)
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0042 + ")")		//"Filiais selecionadas para o relatorio"
	nTamTit := Len(oReport:Title())
	oSecFil:Init()  
	oSecFil:Cell("CODFIL"):SetBlock({||cFilSel})
	oSecFil:Cell("EMPRESA"):SetBlock({||aSM0[nLinha,SM0_DESCEMP]})
	oSecFil:Cell("UNIDNEG"):SetBlock({||aSM0[nLinha,SM0_DESCUN]})
	oSecFil:Cell("NOMEFIL"):SetBlock({||aSM0[nLinha,SM0_NOMRED]})
	For i := 1 To Len(aSelFil)
		nLinha := Ascan(aSM0,{|sm0|,sm0[SM0_CODFIL] == aSelFil[i]})
		If nLinha > 0
			cFilSel := Substr(aSM0[nLinha,SM0_CODFIL],1,nTamEmp)
			cFilSel += " "
			cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + 1,nTamUnNeg)
			cFilSel += " "
			cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + nTamUnNeg + 1)
			oSecFil:PrintLine()
		Endif
	Next
	oReport:SetTitle(cTitulo)
	oSecFil:Finish()
	oSection2:SetHeaderSection(.T.)
	oReport:EndPage()
Endif
/* GESTAO - fim
*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Query para TOP no SE1                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	dbSelectArea("SE1")
	dbSetOrder(1)	
	cChaveSe1 := IndexKey()
	cOrder 	 := SqlOrder(cChaveSe1)
	
	cQuery := "SELECT *"
	cQuery += " FROM " + RetSqlName("SE1")
	/*
	GESTAO - inicio */
	If nLenSelFil > 0
		cQuery += " WHERE E1_FILIAL " + cQryFilSE1
	Else
		cQuery += " WHERE E1_FILIAL = '" + xFilial("SE1") + "'"
	Endif
	/* GESTAO - fim 
	*/
	cQuery += " AND D_E_L_E_T_ = ' '"
	cQuery += " AND E1_NATUREZ between '" + mv_par03 + "' AND '" + mv_par04 + "'"
	cQuery += " AND E1_PREFIXO between '" + mv_par01 + "' AND '" + mv_par02 + "'"
	cQuery += " AND E1_FILORIG between '" + mv_par09 + "' AND '" + mv_par10 + "'"
	cQuery += " AND E1_TIPO <> '" + MV_CRNEG	+ "'"
	cQuery += " AND E1_TIPO <> '" + MVRECANT	+ "'"
	cQuery += " AND E1_TIPO <> '" + MVPROVIS	+ "'"
	If ExistFunc('FormExpIn')
		cQuery += " AND E1_TIPO NOT IN "+ FormExpIn() //Função responsavel por retirar o NOT LIKE
	EndIf
	cQuery += " AND E1_EMISSAO <= '" + DTOS(dDataBase) + "'"
	cQuery += " AND E1_VENCREA <= '" + DTOS(dDatabase) + "'"
	
	cQuery += " ORDER BY " + cOrder
	
	cQuery := ChangeQuery(cQuery)

	dbSelectAre("SE1")
	dbCloseArea()

	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SE1', .T., .T.)
	
	For ni := 1 to Len(aStruArq)
		If aStruArq[ni,2] != 'C'
			TCSetField('SE1', aStruArq[ni,1], aStruArq[ni,2],aStruArq[ni,3],aStruArq[ni,4])
		Endif
	Next

oReport:SetMeter(SE1->(RecCount())+SE5->(RecCount()))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria arquivo de trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCampos:={	{"D_DATA" ,"D", 8,0},;
				{"VALOR_B","N",17,2},;
				{"VALOR_C","N",17,2},;
				{"VALOR_D","N",17,2},;
				{"VALOR_E","N",17,2},;
				{"VALOR_F","N",17,2},;
				{"VALOR_G","N",17,2},;
				{"DESCO_A","N",17,2},;
				{"ACRES_A","N",17,2},;
				{"DESCO_B","N",17,2},;
				{"PGTDI_H","N",17,2},;
				{"ACRES_B","N",17,2},;
				{"BAIXADIA","N",17,2},;
				{"NOCREDIT","N",17,2} }

If(_oFr750TRB <> NIL)
	_oFr750TRB:Delete()
	_oFr750TRB := NIL
EndIf

//Criando a tabela temporaria
_oFr750TRB := FwTemporaryTable():New("cNomeArq")
//Setando as colunas
_oFr750TRB:SetFields(aCampos)
//Criando o indicie 
_oFr750TRB:AddIndex("1",{"D_DATA"})
//Criando a Tabela Temporaria
_oFr750TRB:Create()

dbCommit()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Le contas a receber para montar arquivo de trabalho          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SE1")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Le contas a receber para montar arquivo de trabalho          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/* 
GESTAO - inicio */
cFilOrig := cFilAnt
/* GESTAO - fim
*/
While SE1->(!Eof()) .and. If(nLenSelFil == 0,SE1->E1_FILIAL == cFilial,.T.)
	
   oReport:IncMeter()
	/*
	GESTAO - inicio */
	cFilAnt := SE1->E1_FILORIG
	/* GESTAO - fim
	*/
	If !Fr750Skip()
		SE1->(dbSkip())
		Loop
	EndIf					

    If mv_par08 == 2
      If SE1->E1_MOEDA <> nMoeda
         SE1->(DbSkip())
         Loop
      EndIf
    EndIf    
	
	nTotAbat  := 0
	nSaldoTit := 0
	
	If mv_par06 == 1
		nSaldoTit := SaldoTit(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_NATUREZ,"R",SE1->E1_CLIENTE,1,,,,,If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0))
		nSaldoTit := Round(NoRound(nSaldoTit,3),2)
		If nSaldoTit > 0
			nTotAbat  := SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",1,,SE1->E1_CLIENTE,SE1->E1_LOJA)
			nSaldoTit -= nTotAbat
		Endif
	Else
		nSaldoTit := xMoeda((SE1->E1_SALDO+SE1->E1_SDACRES-SE1->E1_SDDECRE),SE1->E1_MOEDA,nMoeda,SE1->E1_EMISSAO,nDecs+1,If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0))
		If nSaldoTit > 0
			nTotAbat  := SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",1,,SE1->E1_CLIENTE,SE1->E1_LOJA)
			nSaldoTit -= nTotAbat
		Endif
	Endif
	nSaldoTit := Round(NoRound(nSaldotit,3),2)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Anula os retroativos se nao considerar data base             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par06 == 2 .AND. SE1->E1_SALDO = 0
		nSaldoTit := 0
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se o atraso e' maior que 30 dias                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("cNomeArq")
	If (dDataBase - SE1->E1_VENCREA) > 30      //atrasados anterior
		If dbSeek(DtoS(dDataBase-31))
			Reclock("cNomeArq")
		Else
			Reclock("cNomeArq",.T.)
		Endif
		cNomeArq->D_DATA  := dDataBase - 31      //grava anteriores com 31 dias
		cNomeArq->VALOR_G += nSaldoTit           //saldo
		MsUnlock()
	Else
		nDias := dDataBase - SE1->E1_VENCREA    // titulos do periodo
		If cPaisLoc == "BRA"
		   nValorTitulo := xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,1,,,SE1->E1_TXMOEDA)  // grava o valor original
		Else   
		   nValorTitulo := xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,nMoeda,SE1->E1_EMISSAO,nDecs+1)  // grava o valor original
		EndIf   
		If dbSeek(DtoS(dDataBase-nDias))
			Reclock("cNomeArq")
		Else
			Reclock("cNomeArq",.T.)
		Endif
		cNomeArq->D_DATA  := (dDataBase - nDias )
		cNomeArq->VALOR_B += nValorTitulo - nTotAbat		//valor original
		cNomeArq->VALOR_G += nSaldoTit         			//saldo em aberto
		MsUnlock()
	Endif
	dbSelectArea("SE1")
	dbSkip()
Enddo
/*
GESTAO - inicio */
cFilAnt := cFilOrig
/* GESTAO - fim
*/ 
	dbSelectArea("SE1")
	dbCloseArea()
	ChKFile("SE1")
  	dbSelectArea("SE1")
	dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Query para TOP no SE5                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SE5")
cChaveSe5 := IndexKey()
cOrder 	 := SqlOrder(cChaveSE5)
dData		 := dDataBase - 33
dDtPagto  := SE5->E5_DATA

cQuery := "SELECT * "
cQuery += " FROM " + RetSqlName("SE5") + " SE5 "
/*
GESTAO - inicio */
If nLenSelFil > 0
	cQuery += "WHERE E5_FILIAL " + GetRngFil( aSelFil, "SE5", .T., @cTmpFil)
	Aadd(aTmpFil,cTmpFil)
Else
	cQuery += " WHERE E5_FILIAL = '" + xFilial("SE5") + "'"
Endif
/* GESTAO - fim
*/
cQuery += " AND D_E_L_E_T_ = ' ' "
cQuery += " AND E5_TIPODOC IN ('VL','BA','V2','DC','JR','D2','J2','MT','M2','CM','C2','TL','RA','VA')"
cQuery += " AND E5_NATUREZ between '" + mv_par03 + "' AND '" + mv_par04 + "'"
cQuery += " AND E5_PREFIXO between '" + mv_par01 + "' AND '" + mv_par02 + "'"
cQuery += " AND E5_FILORIG between '" + mv_par09 + "' AND '" + mv_par10 + "'"
cQuery += " AND E5_RECPAG = 'R' "
cQuery += " AND E5_DTDISPO >= '" + DTOS(dData) + "'"
cQuery += " AND (E5_DTDISPO <= '" + DTOS(dDtLimite) + "' )"
cQuery += " AND NOT EXISTS (SELECT E5_TIPODOC FROM " 
cQuery +=   RetSqlName("SE5") + " XE5 "
cQuery += " WHERE XE5.E5_FILIAL = '" + xFilial("SE5") + "'"
cQuery += " AND D_E_L_E_T_ <> '*' "
cQuery += " AND XE5.E5_PREFIXO = SE5.E5_PREFIXO"
cQuery += " AND XE5.E5_NUMERO  = SE5.E5_NUMERO"
cQuery += " AND XE5.E5_PARCELA = SE5.E5_PARCELA"
cQuery += " AND XE5.E5_TIPO    = SE5.E5_TIPO"
cQuery += " AND XE5.E5_CLIFOR  = SE5.E5_CLIFOR"
cQuery += " AND XE5.E5_LOJA    = SE5.E5_LOJA"
cQuery += " AND XE5.E5_SEQ     = SE5.E5_SEQ"
cQuery += " AND XE5.E5_TIPODOC = 'ES' " 
cQuery += " AND XE5.E5_RECPAG  = 'P' )"

cQuery += " ORDER BY " + cOrder

cQuery := ChangeQuery(cQuery)

dbSelectArea("SE5")
aStruArq := SE5->(dbStruct())
dbCloseArea()

dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'NEWSE5', .T., .T.)

For ni := 1 to Len(aStruArq)
	If aStruArq[ni,2] != 'C'
		TCSetField('NEWSE5', aStruArq[ni,1], aStruArq[ni,2],aStruArq[ni,3],aStruArq[ni,4])
	Endif
Next
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Abre o SE5 com outro alias para ser filtrado porque a funcao³
//³ TemBxCanc() utilizara o SE5 sem filtro.							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While NEWSE5->(!Eof()) .and. If(nLenSelFil == 0,NEWSE5->E5_FILIAL == xFilial("SE5"),.T.)	

   oReport:IncMeter()
	
	If !Fr750Skip2()
		NEWSE5->(dbSkip())
		Loop
	EndIf					

	If cPaisLoc	# "BRA"
	   SA6->(DbSetOrder(1))
	   SA6->(DbSeek(xFilial("SA6",NEWSE5->E5_FILORIG)+NEWSE5->E5_BANCO+NEWSE5->E5_AGENCIA+NEWSE5->E5_CONTA))
	   nMoedaBco	:=	Max(SA6->A6_MOEDA,1)
	Endif

    If mv_par08 == 2
      If nMoedaBco <> nMoeda
         NEWSE5->(DbSkip())
         Loop
      EndIf
    EndIf    

	nValorSe5 := 0
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se Baixa gerou movimentacao Bancaria                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If MovBcoBx( NEWSE5->E5_MOTBX )
		nValorSe5 := xMoeda(NEWSE5->E5_VALOR,nMoedaBco,nMoeda,NEWSE5->E5_DATA,nDecs+1,,If(cPaisLoc=="BRA",NEWSE5->E5_TXMOEDA,0))
	Endif
	
	dDtPagto  := NEWSE5->E5_DATA
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se foi pago com atraso                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SE1")
	dbSetOrder(1)
	dbSeek(xFilial("SE1",NEWSE5->E5_FILORIG)+NEWSE5->E5_PREFIXO+NEWSE5->E5_NUMERO+NEWSE5->E5_PARCELA+NEWSE5->E5_TIPO)
	
	If SE1->E1_EMISSAO > dDataBase .or. SE1->(Eof())
		dbSelectArea("NEWSE5")
		NEWSE5->(dbSkip())
		Loop
	Endif

	IF SE1->E1_MOEDA > 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Caso a Moeda seja > 1, converte o valor da movimenta‡„o pela ³
		//³ cota‡„o da  moeda na Data de EmissÆo do T¡tulo, pois podem   ³
		//³ ter sido efetuadas baixas informando taxa contratada.        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cPaisLoc == "BRA"
			// Para as movimentacoes que existem taxa contratada, converte pela taxa, senao
			// encontra a taxa contratada atraves do E5_VLMOED2
		   If NEWSE5->E5_TXMOEDA > 0 
		   	nValorSE5 := Round(xMoeda(NEWSE5->E5_VALOR,1,nMoeda,NEWSE5->E5_DATA,nDecs+1,,NEWSE5->E5_TXMOEDA),2)
		   Else
		   	nValorSE5 := Round(xMoeda(NEWSE5->E5_VLMOED2,SE1->E1_MOEDA,1,SE1->E1_EMISSAO,3),2)
		   Endif	
		Else
		   nValorSE5 := xMoeda(NEWSE5->E5_VLMOED2,nMoedaBco,nMoeda,SE1->E1_EMISSAO,nDecs+1)		
		EndIf   
	Endif
	dbSelectArea("cNomeArq")
	dDtSeek := Iif(SE1->E1_VENCREA < dDatabase-30,dDatabase-31,SE1->E1_VENCREA)
	lAnterior := .F.
	If NEWSE5->E5_DTDISPO > (dDataBase-31) .and. NEWSE5->E5_DTDISPO <= dDataBase .and. SE1->E1_VENCREA <= (dDataBase-31)
		If dbSeek(DtoS(dDtSeek))
			Reclock("cNomeArq")
		Else
			Reclock("cNomeArq",.T.)
		Endif
		lAnterior := .T.
		cNomeArq->D_DATA := (dDtSeek)
		If NEWSE5->E5_TIPODOC $ "VL|BA|V2|RA" .and. MovBcoBx(NEWSE5->E5_MOTBX)
			cNomeArq->VALOR_D += nValorSe5
		Elseif NEWSE5->E5_TIPODOC $ "DC|D2" .and. MovBcoBx(NEWSE5->E5_MOTBX) 
			cNomeArq->DESCO_B += nValorSe5
		Elseif NEWSE5->E5_TIPODOC $ "JR|J2|MT|M2|CM|C2|TL|VA" .and. MovBcoBx(NEWSE5->E5_MOTBX)
			cNomeArq->ACRES_B += nValorSe5
		Endif
	Endif
	If SE1->E1_VENCREA <= dDataBase
		If dbSeek(DtoS(dDtSeek))
			Reclock("cNomeArq")
		Else
			Reclock("cNomeArq",.T.)
		Endif
		cNomeArq->D_DATA := (dDtSeek)
		If SE1->E1_VENCREA >= dDtPagto    // Sem Atraso
			If NEWSE5->E5_TIPODOC $ "VL|BA|V2|RA"
				cNomeArq->VALOR_C += nValorSe5
			Elseif NEWSE5->E5_TIPODOC $ "DC|D2"
				cNomeArq->DESCO_A += nValorSe5
			Elseif NEWSE5->E5_TIPODOC $ "JR|J2|MT|M2|CM|C2|TL|VA"
				cNomeArq->ACRES_A += nValorSe5
			Endif
		Else                 // com atraso
			If !lAnterior
				If dbSeek(DtoS(dDtSeek))
					Reclock("cNomeArq")
				Else
					Reclock("cNomeArq",.T.)
				Endif
				cNomeArq->D_DATA := (dDtSeek)
				If NEWSE5->E5_TIPODOC $ "VL|BA|V2|RA"
					cNomeArq->VALOR_D += nValorSe5
				Elseif NEWSE5->E5_TIPODOC $ "DC|D2"
					cNomeArq->DESCO_B += nValorSe5
				Elseif NEWSE5->E5_TIPODOC $ "JR|J2|MT|M2|CM|C2|TL|VA"
					cNomeArq->ACRES_B += nValorSe5
				Endif
			Endif
		Endif
	Endif
	If NEWSE5->E5_TIPODOC $ "VL/BA/V2/RA" .and. NEWSE5->E5_DTDISPO > (dDatabase-31) .and. ;    //(receitas do dia)
		MovBcoBx(NEWSE5->E5_MOTBX)
		If dbSeek(DtoS(NEWSE5->E5_DTDISPO))
			Reclock("cNomeArq")
		Else
			Reclock("cNomeArq",.T.)
		End
		If SE1->E1_VENCREA > NEWSE5->E5_DTDISPO .AND. SE1->E1_VENCREA > dDataBase
			nValAdto += xMoeda(NEWSE5->E5_VALOR,nMoedaBco,nMoeda,NEWSE5->E5_DATA,nDecs+1,,If(cPaisLoc=="BRA",NEWSE5->E5_TXMOEDA,0))
		End
		cNomeArq->D_DATA  := NEWSE5->E5_DTDISPO
		cNomeArq->PGTDI_H += xMoeda(NEWSE5->E5_VALOR,nMoedaBco,nMoeda,NEWSE5->E5_DATA,nDecs+1,,If(cPaisLoc=="BRA",NEWSE5->E5_TXMOEDA,0))
	End
	MsUnlock()
	If NEWSE5->E5_TIPODOC $ "VL/BA/V2/RA" .and. NEWSE5->E5_DTDIGIT > dDatabase-31    //(baixados no dia)
		If dbSeek(DtoS(NEWSE5->E5_DTDIGIT))
			Reclock("cNomeArq")
		Else
			Reclock("cNomeArq",.T.)
		End
		cNomeArq->D_DATA   := NEWSE5->E5_DTDIGIT
		cNomeArq->BAIXADIA += Iif(MovBcoBx(NEWSE5->E5_MOTBX),xMoeda(NEWSE5->E5_VALOR,nMoedaBco,nMoeda,NEWSE5->E5_DATA,nDecs+1,,If(cPaisLoc=="BRA",NEWSE5->E5_TXMOEDA,0)),0)
		cNomeArq->NOCREDIT += Iif(MovBcoBx(NEWSE5->E5_MOTBX),0,xMoeda(NEWSE5->E5_VALOR,nMoedaBco,nMoeda,NEWSE5->E5_DATA,nDecs+1,,If(cPaisLoc=="BRA",NEWSE5->E5_TXMOEDA,0)))
	End
	MsUnlock()
	dbSelectArea("NEWSE5")
	dbSkip()
Enddo
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava Movimenta‡„o zerada se data nao houver registro        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("cNomeArq")
For i := 0 TO 30
	If !(dbSeek(DtoS(dDataBase - i)))
		Reclock("cNomeArq", .T. )
		cNomeArq->D_DATA := dDataBase - i
		MsUnlock()
	End
Next i

cNomeArq->(dbGoTop())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa a impressao do relatorio                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:Init()

While cNomeArq->(!Eof())

	If lFirst	//Imprime o Saldo Anterior
      oSection1:PrintLine()
		oSection1:Finish()
		oSection2:Init()
		cNomeArq->(dbSkip())
		lFirst := .F.
		Loop
	EndIf
	
	nValorE 		:= VALOR_B - (VALOR_C-ACRES_A+DESCO_A)
	nTValorE 	+= nValorE
	nTotValB		+= VALOR_B
	nTotValG		+= VALOR_G
	nTotDescoA	+= DESCO_A
	nTotAcresA	+= ACRES_A
	nTotValorC	+= VALOR_C
	nTotDescoB	+= DESCO_B
	nTotAcresB	+= ACRES_B
	nTotValorD	+= VALOR_D
	nTotPgtdi_h	+= PGTDI_H
	nTotBaixa	+= BAIXADIA
	nTotNoCred	+= NOCREDIT

	oSection2:PrintLine()
   oReport:IncMeter()
	cNomeArq->(dbSkip())
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a impressao do Total Geral.		                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:PrintText("")
oSection2:Cell("D_DATA"  ):Hide()
oSection2:Cell("VALOR_B" ):SetBlock( { || nTotValB } )
oSection2:Cell("DESCO_A" ):SetBlock( { || nTotDescoA } )
oSection2:Cell("ACRES_A" ):SetBlock( { || nTotAcresA } )   
oSection2:Cell("ACRES_A" ):Picture( If(cPaisLoc == "BRA","@E 9999,999.99",PesqPict("SE5","E5_VALOR",11,nMoeda)) )
oSection2:Cell("VALOR_C" ):SetBlock( { || nTotValorC } )
oSection2:Cell("DESCO_B" ):SetBlock( { || nTotDescoB } )
oSection2:Cell("DESCO_B" ):Picture( If(cPaisLoc == "BRA","@E 9999,999.99",PesqPict("SE5","E5_VALOR",11,nMoeda)) )
oSection2:Cell("ACRES_B" ):SetBlock( { || nTotAcresB } )
oSection2:Cell("ACRES_B" ):Picture( If(cPaisLoc == "BRA","@E 9999,999.99",PesqPict("SE5","E5_VALOR",11,nMoeda)) )
oSection2:Cell("VALOR_D" ):SetBlock( { || nTotValorD } )
oSection2:Cell("NVALORE" ):SetBlock( { || nTValorE } )
oSection2:Cell("EFICIEN" ):SetBlock( { || (1-(nTValorE/nTotValB))*100 } )
oSection2:Cell("VALOR_G" ):SetBlock( { || nTotValG } )
oSection2:Cell("CREDDIA" ):SetBlock( { || (1-(nTotValG/nTotValB))*100 } )
oSection2:Cell("PGTDI_H" ):SetBlock( { || nTotPgtdi_H } )
oSection2:Cell("BAIXADIA"):SetBlock( { || nTotBaixa } )
oSection2:Cell("NOCREDIT"):SetBlock( { || nTotNoCred } )

oSection2:PrintLine()
oSection2:Finish()

dbSelectArea("SE1")

If Select("NEWSE5") != 0
	dbSelectArea("NEWSE5")
	dbCloseArea()
EndIf

If Select("cNomeArq") != 0
	dbSelectArea("cNomeArq")
	dbCloseArea()
EndIf

dbSelectArea("SE1")
dbCloseArea()
ChKFile("SE1")
dbSelectArea("SE1")
dbSetOrder(1)
ChKFile("SE5")
dbSelectArea("SE5")
dbSetOrder(1)
/*
GESTAO - inicio */
If !Empty(aTmpFil)
	For nLenSelFil := 1 To Len(aTmpFil)
		CtbTmpErase(aTmpFil[nLenSelFil])
	Next
Endif
/* GESTAO - fim
*/

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fr750Chec1³ Autor ³ Wagner Xavier         ³ Data ³ 09/05/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Efetua sele‡„o dos T¡tulos.                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³FinR750                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fr750Chec1()
Local cString
cString := 'E1_NATUREZ >= "'+mv_par03+'" .and. E1_NATUREZ <= "'+mv_par04+'" .And. '
cString := 'E1_FILORIG >= "'+mv_par09+'" .and. E1_FILORIG <= "'+mv_par10+'" .And. '
cString += 'E1_PREFIXO >= "'+mv_par01+'" .and. E1_PREFIXO <= "'+mv_par02+'"'
Return cString
                        	
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fr750Chec5³ Autor ³ Wagner Xavier         ³ Data ³ 09/05/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Efetua sele‡„o das Baixas.                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³FinR750                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fr750Chec5()
Local cString
Local cTipodoc := "VLüBAüV2üDCüJRüD2üJ2üMTüM2üCMüC2üTLüRA"
cString := 'E5_TIPODOC$"'+cTipodoc+'" .And. '
cString += 'E5_NATUREZ >= "'+mv_par03+'" .and. E5_NATUREZ <= "'+mv_par04+'" .And. '
cString += 'E5_PREFIXO >= "'+mv_par01+'" .and. E5_PREFIXO <= "'+mv_par02+'" .And. '
cString += 'E5_FILORIG >= "'+mv_par09+'" .and. E5_PREFIXO <= "'+mv_par10+'" .And. '
cString += 'E5_RECPAG = "R" .And. '
cString += 'dtos(E5_DTDISPO) >= "'+dtos(dDataBase-33)+'"'      //reten‡„o
Return cString


Static Function InSide(cTp)
IF mv_par05 != 1
	Return .t.
Else
	Return (cTp$cTipos)
Endif



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³Fr750Skip ³ Autor ³ Pilar S. Albaladejo	  ³ Data ³ 13.10.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Pula registros de acordo com as condicoes (AS 400/CDX/ADS)  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ FINR750.PRX																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Fr750Skip()

Local lRet := .T.

IF E1_TIPO $ MVPROVIS+"/"+MVRECANT+"/"+MV_CRNEG+"/"+MVABATIM
	lRet := .F.
ElseIf ! Inside(SE1->E1_TIPO)
	lRet := .F.
ElseIf SE1->E1_EMISSAO > dDataBase .or. SE1->E1_VENCREA > dDataBase
	lRet := .F.
Endif

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³Fr750Skip2³ Autor ³ Pilar S. Albaladejo	  ³ Data ³ 13.10.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Pula registros de acordo com as condicoes (AS 400/CDX/ADS)  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ FINR750.PRX																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Fr750Skip2()

Local lRet := .T.

IF NEWSE5->E5_TIPO $ MVPROVIS+"/"+MV_CRNEG
	lRet := .F.
ElseIf !Inside(NEWSE5->E5_TIPO)
	lRet := .F.
ElseIf TemBxCanc(NEWSE5->E5_PREFIXO+NEWSE5->E5_NUMERO+NEWSE5->E5_PARCELA+NEWSE5->E5_TIPO+NEWSE5->E5_CLIFOR+NEWSE5->E5_LOJA+NEWSE5->E5_SEQ) .OR.;
	NEWSE5->E5_SITUACA =="C"
	lRet := .F.
EndIf

Return lRet