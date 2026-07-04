/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR400.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "TOPCONN.CH"

#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
Static cAutoPerg := "ATR400"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR400   ³ Autor ³ Eduardo Riera         ³ Data ³ 06.10.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do Orcamento.                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³18/05/2006³Cleber Martinez³Bops 98346: Localizacao do modulo SIGATEC.  ³±±
±±³16/02/2007³Conrado Quilles³Bops 119542: Retirado função de ajuste.     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function TECR400(cOrcamento)
Local oReport				//Objeto do relatorio personalizavel
Local aArea := GetArea()	//Guarda a area atual

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ MV_PAR01               Orcamento De                           ³
//³ MV_PAR02               Orcamento Ate                          ³
//³ MV_PAR03               Qual Moeda                             ³
//³ MV_PAR04               Outras Moedas (Converter/Nao imprimir) ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("ATR400",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica as Perguntas Seleciondas                                       ³
//³Gravacao no SX1 foi removida em atendimento ao Projeto Russia / SemCtree³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
If ( !Empty(cOrcamento ) )
	MV_PAR01 := cOrcamento
	MV_PAR02 := cOrcamento
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := Tcr400RptDef()
oReport:PrintDialog()


RestArea( aArea )
Return	


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr400RptDef ºAutor  ³Cleber Martinez     º Data ³  02/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR400 R4                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr400RptDef()
Local oReport			// Objeto do relatorio
Local oSection1			// Objeto da secao 1
Local oSection2			// Objeto da secao 2
Local oSection3			// Objeto da secao 3
Local cAlias1	:= ""	// Pega o proximo Alias Disponivel
Local cAlias3	:= ""	// Pega o proximo Alias Disponivel

#IFDEF TOP
	cAlias1	:= GetNextAlias()
	cAlias3	:= GetNextAlias()	
#ELSE
	cAlias1	:= "AB3"
	cAlias3	:= "AB5"
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a criacao do objeto oReport  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//"Impressao do Orcamento"
//"     Este programa ira emitir os Orcamentos conforme os parametros"
//"solicitados."
DEFINE REPORT oReport NAME "TECR400" TITLE STR0001 PARAMETER "ATR400" ACTION {|oReport| Tcr400PrtRpt(oReport, cAlias1, cAlias3)} 	DESCRIPTION STR0002 + STR0003 + STR0004 
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao1 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//"Cabeçalho do Orçamento"
	DEFINE SECTION oSection1 OF oReport TITLE STR0023 TABLES "AB3","SA1","SE4" TOTAL TEXT STR0018 TOTAL IN COLUMN //"TOTAL GERAL"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao1  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		DEFINE CELL NAME "AB3_NUMORC" 	OF oSection1 ALIAS "AB3" CELL BREAK
		DEFINE CELL NAME "AB3_CODCLI" 	OF oSection1 ALIAS "AB3"
		DEFINE CELL NAME "AB3_LOJA" 	OF oSection1 ALIAS "AB3"
		DEFINE CELL NAME "A1_NOME" 		OF oSection1 ALIAS "SA1" CELL BREAK
		DEFINE CELL NAME "AB3_EMISSA" 	OF oSection1 ALIAS "AB3" CELL BREAK
		DEFINE CELL NAME "AB3_MOEDA" 	OF oSection1 ALIAS "AB3" CELL BREAK 
		DEFINE CELL NAME "AB3_ATEND" 	OF oSection1 ALIAS "AB3" CELL BREAK
		DEFINE CELL NAME "AB3_CONPAG" 	OF oSection1 ALIAS "AB3"
		DEFINE CELL NAME "E4_DESCRI" 	OF oSection1 ALIAS "SE4"
		DEFINE CELL NAME "AB3_DESC1" 	OF oSection1 ALIAS "AB3"
		DEFINE CELL NAME "AB3_DESC2" 	OF oSection1 ALIAS "AB3"		
		DEFINE CELL NAME "AB3_DESC3" 	OF oSection1 ALIAS "AB3"
		DEFINE CELL NAME "AB3_DESC4" 	OF oSection1 ALIAS "AB3"
          
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao2 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		//"Itens do Orçamento"
		DEFINE SECTION oSection2 OF oSection1 TITLE STR0024 TABLE "AB4","AB3","AAG","AA3"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define as celulas que irao aparecer na secao2  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DEFINE CELL NAME "AB4_ITEM" 	OF oSection2 ALIAS "AB4"
			DEFINE CELL NAME "AB4_TIPO" 	OF oSection2 ALIAS "AB4"
			DEFINE CELL NAME "AB4_CODPRO" 	OF oSection2 ALIAS "AB4"
			DEFINE CELL NAME "AB4_NUMSER" 	OF oSection2 ALIAS "AB4"
			DEFINE CELL NAME "AB4_CODPRB" 	OF oSection2 ALIAS "AB4"
			DEFINE CELL NAME "AAG_DESCRI" 	OF oSection2 ALIAS "AAG" 
			DEFINE CELL NAME "AA3_CONTRT"  	OF oSection2 ALIAS "AA3" 
			DEFINE CELL NAME "AA3_DTGAR" 	OF oSection2 ALIAS "AA3"
			DEFINE CELL NAME "AB4_NUMOS" 	OF oSection2 ALIAS "AB4" 
            
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao3 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                
		//"Apontamento"
		DEFINE SECTION oSection3 OF oSection2 TITLE STR0025 TABLE "AB5","AB4","AB3"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define as celulas que irao aparecer na secao3  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
			DEFINE CELL NAME "AB5_SUBITE" 	OF oSection3 ALIAS "AB5"
			DEFINE CELL NAME "AB5_CODPRO" 	OF oSection3 ALIAS "AB5"
			DEFINE CELL NAME "AB5_DESPRO" 	OF oSection3 ALIAS "AB5"
			DEFINE CELL NAME "AB5_CODSER" 	OF oSection3 ALIAS "AB5"
			DEFINE CELL NAME "AB5_QUANT" 	OF oSection3 ALIAS "AB5" PICTURE PesqPict("AB5","AB5_QUANT") 
			DEFINE CELL NAME "AB5_VUNIT" 	OF oSection3 ALIAS "AB5" PICTURE PesqPict("AB5","AB5_VUNIT",14,MV_PAR03) BLOCK {|| TEC400VUNIT(cAlias1,cAlias3) }
			DEFINE CELL NAME "nAB5_TOTAL" 	OF oSection3 ALIAS " " TITLE STR0019 PICTURE PesqPict("AB5","AB5_TOTAL",19,MV_PAR03) BLOCK {|| TEC400TOTAL("C",cAlias1,cAlias3) }	//"Valor Cliente"
            DEFINE CELL NAME "nVlrFabric" 	OF oSection3 ALIAS " " TITLE STR0020 PICTURE PesqPict("AB5","AB5_TOTAL",19,MV_PAR03) BLOCK {|| TEC400TOTAL("F",cAlias1,cAlias3) }	//"Valor Fabricante"
            DEFINE CELL NAME "nImpostos" 	OF oSection3 ALIAS " " TITLE "Impostos" PICTURE PesqPict("AB5","AB5_TOTAL",19,MV_PAR03) ;
			 BLOCK {|| TEC400Imp((cAlias1)->AB4_NUMORC,(cAlias1)->AB4_ITEM, (cAlias3)->AB5_CODPRO) }    //"Valor Impostos"
				
            
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Totalizadores da Secao 3 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DEFINE FUNCTION FROM oSection3:Cell("nAB5_TOTAL") FUNCTION SUM NO END REPORT //END PAGE
		 	DEFINE FUNCTION FROM oSection3:Cell("nVlrFabric") FUNCTION SUM NO END REPORT //END PAGE
		 	DEFINE FUNCTION FROM oSection3:Cell("nImpostos") FUNCTION SUM NO END REPORT //END PAGE 

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Totalizadores da Secao 1 (Pagina) ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DEFINE FUNCTION FROM oSection3:Cell("nAB5_TOTAL") OF oSection1 FUNCTION SUM NO END REPORT END PAGE
		 	DEFINE FUNCTION FROM oSection3:Cell("nVlrFabric") OF oSection1 FUNCTION SUM NO END REPORT END PAGE
		 	DEFINE FUNCTION FROM oSection3:Cell("nImpostos") OF oSection1 FUNCTION SUM NO END REPORT END PAGE

        oSection1:SetPageBreak()
        //Define impressao no estilo Enchoice
        oSection1:SetLineStyle()
        oSection2:SetLineBreak()
		oSection3:SetTotalText(STR0021)		//"SUB-TOTAL"
		//Imprime total em coluna (default .T. - linha )
		oSection3:SetTotalInLine(.F.)
		
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³TEC400VUNIT  ºAutor  ³Cleber Martinez     º Data ³  02/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para retornar o valor unitario de acordo com a Moeda    º±±
±±º          ³selecionada.                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR400 R4                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TEC400VUNIT(cAlias1,cAlias3)
Local nAB5_VUNIT:= 0										// Valor do campo AB5_VUNIT
Local nDecs		:= Msdecimais(MV_PAR03)						// Nr. de casas decimais da Moeda escolhida p/ o relatorio

nAB5_VUNIT := Round(xMoeda((cAlias3)->AB5_VUNIT, (cAlias1)->AB3_MOEDA, MV_PAR03, (cAlias1)->AB3_EMISSA, nDecs+1, (cAlias1)->AB3_TXMOED), nDecs)

Return nAB5_VUNIT


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³TEC400TOTAL  ºAutor  ³Cleber Martinez     º Data ³  02/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para retornar o valor total do item (valor cliente e    º±±
±±º          ³fabricante)                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR400 R4                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TEC400TOTAL(cOpcao,cAlias1,cAlias3)
Local nAB5_TOTAL:= 0										// Valor do campo AB5_TOTAL 
Local nValorRet	:= 0										// Valor de retorno da funcao
Local nDecs		:= Msdecimais(MV_PAR03)						// Nr. de casas decimais da Moeda escolhida p/ o relatorio

nAB5_TOTAL := Round(xMoeda((cAlias3)->AB5_TOTAL, (cAlias1)->AB3_MOEDA, MV_PAR03, (cAlias1)->AB3_EMISSA, nDecs+1, (cAlias1)->AB3_TXMOED), nDecs)

//Verifica se eh Valor Total do Cliente ou Fabricante
If cOpcao == "C"
	nValorRet := AtVlrPagto((cAlias3)->AB5_CODSER,nAB5_TOTAL,"C")
ElseIf cOpcao == "F"
	nValorRet := AtVlrPagto((cAlias3)->AB5_CODSER,nAB5_TOTAL,"F")
EndIf

Return nValorRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr400PrtRptºAutor  ³Cleber Martinez     º Data ³  02/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³Nenhum                                                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³oReport: Objeto TReport do relatorio personalizavel        	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR400 R4                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr400PrtRpt( oReport, cAlias1, cAlias3 )
Local oSection1 := oReport:Section(1)							// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)							// Define que a secao 2 sera filha da secao 1
Local oSection3 := oReport:Section(1):Section(1):Section(1)	// Define que a secao 3 sera filha da secao 2
Local cWhere	:= ""											// Condicao a adicionar na query
Local cSelect	:= ""											// Campos adicionais do Select

#IFDEF TOP
	DbSelectArea("AB3")
	DbSetOrder(1)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("ATR400")
    
	If mv_par04 == 2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ So imprimir orcamentos com moeda igual a escolhida (MV_PAR03)   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cWhere := "% AND AB3_MOEDA = '" + Str(mv_par03) + "' %"
	Else
		cWhere := "% %"
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Adiciona campos no SELECT ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSelect := "%, AB3_TXMOED %"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BeginSql alias cAlias1
		SELECT	AB3_NUMORC,	AB3_CODCLI,	AB3_LOJA,	A1_NOME,	
				AB3_MOEDA,	AB3_ATEND,	AB3_CONPAG,	E4_DESCRI,
				AB3_DESC1,	AB3_DESC2,	AB3_DESC3,	AB3_DESC4,
				AB4_NUMORC,	AB4_ITEM,	AB4_TIPO,	AB4_CODPRO,	
				AB4_NUMSER,	AB4_CODPRB,	AB4_NUMOS,	AB3_EMISSA
				%exp:cSelect%
				
		FROM %table:AB3% AB3, %table:AB4% AB4, %table:SA1% SA1, %table:SE4% SE4
		WHERE	AB3_FILIAL = %xfilial:AB3%		AND
				AB3_NUMORC >= %exp:mv_par01%	AND  
				AB3_NUMORC <= %exp:mv_par02%	AND
				AB3.%notDel%					AND
				AB4_FILIAL = %xfilial:AB4%		AND
				AB4_NUMORC = AB3_NUMORC			AND
				AB4.%notDel%					AND
				A1_FILIAL = %xfilial:SA1%		AND
				AB3_CODCLI = A1_COD				AND
				AB3_LOJA = A1_LOJA				AND
				SA1.%notDel%					AND                       
				E4_FILIAL = %xfilial:SE4%		AND
				AB3_CONPAG = E4_CODIGO			AND
				SE4.%notDel%				
				%exp:cWhere%				

		ORDER BY %Order:AB3%
				
	EndSql
	
	END REPORT QUERY oSection1 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 3³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection3

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao 3, para impressao dos dados das celulas apenas da secao 3³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BeginSql alias cAlias3
		SELECT	AB5_SUBITE,	AB5_CODPRO,	AB5_DESPRO,
				AB5_CODSER,	AB5_QUANT,	AB5_VUNIT,	
				AB5_TOTAL
				
		FROM %table:AB5% AB5
		WHERE	AB5_FILIAL	= 	%xfilial:AB5%	AND
				AB5_NUMORC	=	%report_param: (cAlias1)->AB4_NUMORC%	AND
				AB5_ITEM	=	%report_param: (cAlias1)->AB4_ITEM%		AND
				AB5.%notDel%
				
		ORDER BY %Order:AB5%
	EndSql

	END REPORT QUERY oSection3
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona nas tabelas auxiliares ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
	TRPosition():New(oSection2,"AAG",1,{|| xFilial("AAG")+(cAlias1)->AB4_CODPRB }) 
	TRPosition():New(oSection2,"AA3",1,{|| xFilial("AA3")+(cAlias1)->AB3_CODCLI+(cAlias1)->AB3_LOJA+(cAlias1)->AB4_CODPRO+(cAlias1)->AB4_NUMSER }) 
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define que a secao 2 usara a mesma query da secao 1 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection2:SetParentQuery()
	oSection2:SetParentFilter({|cParam| (cAlias1)->AB4_NUMORC == cParam},{|| (cAlias1)->AB3_NUMORC })

#ELSE

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("ATR400")

	DbSelectArea("AB3")
	DbSetOrder(1)
    
	cFiltro := "AB3_FILIAL == '" + xFilial("AB3") + "' .AND. "
	cFiltro += "AB3_NUMORC >= '" + mv_par01 + "' .AND. "
	cFiltro += "AB3_NUMORC <= '" + mv_par02 + "'" 
	If mv_par04 == 2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ So imprimir orcamentos com moeda igual a escolhida (MV_PAR03)   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cFiltro += " .AND. AB3_MOEDA == " + Str(mv_par03) //+" "
	EndIf
		 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Efetua o filtro de acordo com a expressao do arquivo AB3 (Chamado Tecnico)	 						 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:SetFilter( cFiltro )
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa a secao2, com o mesmo filtro da secao1.                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection2:SetRelation({|| xFilial("AB4") + AB3->AB3_NUMORC },"AB4",1,.T.)
	oSection2:SetParentFilter({|cParam| AB4->AB4_NUMORC == cParam},{|| AB3->AB3_NUMORC })
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa a secao3, com o mesmo filtro da secao2.                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection3:SetRelation({|| xFilial("AB5") + AB4->AB4_NUMORC + AB4->AB4_ITEM },"AB5",1,.T.)
	oSection3:SetParentFilter({|cParam| AB5->AB5_NUMORC + AB5->AB5_ITEM == cParam},{|| AB4->AB4_NUMORC + AB4->AB4_ITEM })

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona nas tabelas auxiliares ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    TRPosition():New(oSection1,"SA1",1,{|| xFilial("SA1")+AB3->AB3_CODCLI+AB3->AB3_LOJA }) 
	TRPosition():New(oSection1,"SE4",1,{|| xFilial("SE4")+AB3->AB3_CONPAG })  
	TRPosition():New(oSection2,"AAG",1,{|| xFilial("AAG")+AB4->AB4_CODPRB }) 
	TRPosition():New(oSection2,"AA3",1,{|| xFilial("AA3")+AB3->AB3_CODCLI+AB3->AB3_LOJA+AB4->AB4_CODPRO+AB4->AB4_NUMSER }) 

#ENDIF	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(STR0022) //"ORCAMENTO TECNICO"
If !isBlind()
	oSection1:Print()
EndIf

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³RetLayOut ³ Autor ³ Eduardo Riera         ³ Data ³ 06.10.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o LayOut a ser impresso                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Array com o LayOut                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static ;
User Function RetLayOut()

Local aLay := Array(26)

//
//                     1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//           01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

aLay[01] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[02] := STR0008 //"|                                ORCAMENTO TECNICO                                           | Nr.Orcamento: ###### | Folha: ######|"
aLay[03] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[04] := "|                                                                                                                                  |"
aLay[05] := STR0009// "|Cliente  : ######/## - ########################################                                                                   |"
aLay[06] := STR0010// "|Emissao  : ##########                                                                                                             |"
aLay[07] := STR0017// "|Moeda    : #                                                                                                                      |"
aLay[08] := STR0011// "|Atendente: ####################                                                                                                   |"
aLay[09] := STR0012// "|Cond.Pag.: ### - ##################################                                 Desconto(s): ###### + ###### + ###### + ######|"
aLay[10] := "|                                                                                                                                  |"
aLay[11] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[12] := STR0013 //"|It|   Tipo   |    Produto    |      Nr.Serie      |                Problema               |    Contrato   | Garantia |    O.S.    |"
aLay[13] := "+--+----------+---------------+--------------------+---------------------------------------+---------------+----------+------------+"
aLay[14] := "|##|##########|###############|####################|#######################################|###############|##########|############|"
aLay[15] := "+--+----------+-------+-------+--------------------+-+-------+--------------+--------------+---------------+---+------+------------+"
aLay[16] := STR0014 // "|  |IT|Produto        |Descricao                     |Servico|  Quantidade  |Valor Unitario|    Valor Total    | Valor Fabricante  |"
aLay[17] := "+--+------------------+-------+----------------------+-------+--------------+--------------+-------------------+-------------------+"
aLay[18] := "|->|##|###############|##############################|#######|##############|##############|###################|                   |"
aLay[19] := "+--+------------------+------------------------------+-------+--------------+--------------+-------------------+-------------------+"
aLay[20] := STR0015 // "|                                                                            SUB-TOTAL     | ##################| ##################|"
aLay[21] := "|------------------------------------------------------------------------------------------+-------------------+-------------------+"
aLay[22] := "|                                                                                                                                  |"
aLay[23] := "+------------------------------------------------------------------------------------------+-------------------+-------------------+"
aLay[24] := STR0016 // "|                                                                            TOTAL GERAL   | ##################| ##################|"
aLay[25] := "+------------------------------------------------------------------------------------------+-------------------+-------------------+"
aLay[26] := "|  |          |               |                    |                                       |               |          |            |"


Return(aLay)

//------------------------------------------------------------------------------------------------
/*/{Protheus.doc} TEC400Imp()
Faz o calculo do impostos a serem destacados no relatório.

@return nTotal - contém o valor dos impostos.
@author Manutenção Serviços
@since 01/04/2014
/*/
//------------------------------------------------------------------------------------------------

Static Function TEC400Imp(cOrc,cItem,cProd)

Local nValSOL	:= 0
Local nValCMP	:= 0
Local nValIPI	:= 0
Local nValISS	:= 0
Local nValIRR	:= 0
Local nValINSS	:= 0
Local nValCofins := 0
Local nValCSL	:= 0
Local nValPIS	:= 0                        
Local nValPS2	:= 0
Local nValCF2	:= 0
Local nValSES	:= 0
Local nTotal 	:= 0
Local nTotSOL	:= 0
Local nTotCMP	:= 0
Local nTotIPI	:= 0
Local nTotISS	:= 0
Local nTotIRR	:= 0
Local nTotINSS	:= 0
Local nTotCofins := 0
Local nTotCSL	:= 0
Local nTotPIS	:= 0
Local nTotPS2	:= 0
Local nTotCF2	:= 0
Local nTotSES	:= 0
Local aDados	:= {}
Local nItem		:= 01
Local nValICMS	:= 0
Local nTotICMS	:= 0


cAliasTrb := GetNextAlias()
	
	cQuery := " SELECT AB5_NUMORC,AB5_CODPRO,AB5_QUANT,AB5_VUNIT,AB5_TOTAL,AB5_ITEM,AA5_TES,AB3_CODCLI,AB3_LOJA,A1_TIPO,A1_RECISS FROM "+RetSqlName("AB5")+" AB5 "
	cQuery += " INNER JOIN " +RetSqlName("AA5")+" AA5 ON AA5_CODSER = AB5_CODSER AND AA5.D_E_L_E_T_='' "
	cQuery += " INNER JOIN " +RetSqlName("AB3")+" AB3 ON AB3_NUMORC = AB5_NUMORC AND AB3.D_E_L_E_T_='' "
	cQuery += " INNER JOIN " +RetSqlName("SA1")+" SA1 ON A1_COD	= AB3_CODCLI AND A1_LOJA = AB3_LOJA AND SA1.D_E_L_E_T_=''  
	cQuery += " WHERE AB5_NUMORC = '"+cOrc+"' AND AB5_ITEM = '"+cItem+"' AND AB5_CODPRO = '"+cProd+"' "
	cQuery += " AND AB5.D_E_L_E_T_=''
	cQuery := ChangeQuery(cQuery)
	DbUseArea(.T.,"TOPCONN", TcGenQry(,,cQuery), cAliasTrb , .T. , .F.)	
	
	Aadd(aDados,{PadR(AB5_CODPRO, TamSx3("B1_COD")[1]),AB5_QUANT,AB5_VUNIT,AB5_TOTAL,AB5_ITEM,AA5_TES,AB3_CODCLI,AB3_LOJA,A1_TIPO,A1_RECISS,AB5_NUMORC})

	AB5->(DbCloseArea())
	
	//Garante que os Arrays da Matxfis estao Limpos a cada chamada.
	MaFisEnd()  
	
	DbSelectArea("AB5")
    
	//Inicia a carga da MATXFIS com os dados do Cabecalho
	MaFisIni(aDados[1,7],aDados[1,8],"C","N",aDados[1,9],,,,,"MATA461",,,,,aDados[1,10],,,,,,,,,,,)
	
		//Limpa todos os itens e zera todos totalizadores do cabeçalho dos arrays internos da MATXFIS.
		MaFisClear()
	
		MaFisAdd(aDados[1,1],; // 1-Codigo do Produto ( Obrigatorio )
		aDados[1,6],;                            // 2-Codigo do TES ( Opcional )
		aDados[1,2],;  	      // 3-Quantidade ( Obrigatorio )
		aDados[1,3],;		  				  // 4-Preco Unitario ( Obrigatorio )
		0,; 		              // 5-Valor do Desconto ( Opcional )
		"",;	   			              // 6-Numero da NF Original ( Devolucao/Benef )
		"",;				              // 7-Serie da NF Original ( Devolucao/Benef )
		0 ,;					          // 8-RecNo da NF Original no arq SD1/SD2
		0 ,;					          // 9-Valor do Frete do Item ( Opcional )
		0 ,;					          // 10-Valor da Despesa do item ( Opcional )
		0 ,;					          // 11-Valor do Seguro do item ( Opcional )
		0 ,;					          // 12-Valor do Frete Autonomo ( Opcional )
		aDados[1,4],;			              // 13-Valor da Mercadoria ( Obrigatorio )
		0 ,;					          // 14-Valor da Embalagem ( Opiconal )
		0 ,;					          // 15-RecNo do SB1
		0 ,;					          // 16-RecNo do SF4
		StrZero(nItem , TAMSX3("C6_ITEM")[1]),;	 						 //17- Código do Item
		0 ,;					          // 18-Despesas nao tributadas - Portugal
		0 ,;					          // 19-Tara - Portugal
		"",;                            // 20-CFO
		{},;            	              // 21-Array para o calculo do IVA Ajustado (opcional)
		"",;				              // 22-Codigo Retencao - Equador
		0 ,;                              // 23-Valor Abatimento ISS
		"",;                              // 24-Lote Produto
		"",;                              // 25-Sub-Lote Produto
		0 ,;                              // 26-Valor do Abatimento ISS
		"",;                              // 27-Codigo ISS
		"",;                             // 28-Classificação fiscal
		"",;							  // 29-Cod. do Produto Fiscal
		0,;								  // 30-Recno do Produto Fiscal
		0)								  // 31-NCM do produto Fiscal

		//ICMS
		nValSOL	:= 0
		nValSOL := MaFisRet(nItem,"IT_VALSOL")
		nTotSOL	+= nValSOL
		//ICMS Complementar
		nValCMP := 0
		nValCMP := MaFisRet(nItem,"IT_VALCMP")
		nTotCMP += nValCMP
		//IPI
		nValIPI := 0
		nValIPI := MaFisRet(nItem,"IT_VALIPI")
		nTotIPI += nValIPI
		//ISS
		nValISS	:= 0
		nValISS := MaFisRet(nItem,"IT_VALISS")
		nTotISS += nValISS
		//IR
		nValIRR	:= 0     
		nValIRR := MaFisRet(nItem,"IT_VALIRR")
		nTotIRR += nValIRR
		//INSS
		nValINSS := 0
		nValINSS := MaFisRet(nItem,"IT_VALINS")
		nTotINSS += nValINSS
		//COFINS
		nValCofins := 0
		nValCofins := MaFisRet(nItem,"IT_VALCOF")
		nTotCofins += nValCofins
		//CSLL
		nValCSL	 := 0    
		nValCSL  := MaFisRet(nItem,"IT_VALCSL")
		nTotCSL  += nValCSL
		//PIS
		nValPIS	 := 0
		nValPIS  := MaFisRet(nItem,"IT_VALPIS")
		nTotPIS  += nValPIS
		//PIS 2
		nValPS2	 := 0
		nValPS2  := MaFisRet(nItem,"IT_VALPS2")
		nTotPS2  += nValPS2
		//COFINS 2
		nValCF2	 := 0
		nValCF2  := MaFisRet(nItem,"IT_VALCF2")
		nTotCF2  += nValCF2
		//SES
		nValSES	 := 0
		nValSES  := MaFisRet(nItem,"IT_VALSES")
		nTotSES  += nValSES
		//ICMS
		nValICMS := 0
		nValICMS := MaFisRet(nItem,"IT_VALICM")
		nTotICMS += nValICMS
			
	MaFisEnd()
		
	//Totaliza impostos.
	nTotal := nValSOL+nValCMP+nValIPI+nValISS+nValIRR+nValINSS+nValCofins+nValCSL+nValPIS+nValPS2+nValCF2+nValSES+nValICMS
	
(cAliasTrb)->(DbCloseArea())
Return nTotal


//-------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Monta as definiçoes do relatorio.
Chamada utilizada na automação de código.

@author Mateus Boiani
@since 31/10/2018
@return objeto Report
/*/
//-------------------------------------------------------------------------------------
Static Function ReportDef()

Return Tcr400RptDef()

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
Chama a função ReportPrint
Chamada utilizada na automação de código.

@author Mateus Boiani
@since 31/10/2018
@return objeto Report
/*/
//-------------------------------------------------------------------------------------
Static Function PrintReport ( oReport )

Return Tcr400PrtRpt( oReport , GetNextAlias() , GetNextAlias() )

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} GetPergTRp
Retorna o nome do Pergunte utilizado no relatório
Função utilizada na automação
@author Mateus Boiani
@since 31/10/2018
@return cAutoPerg, string, nome do pergunte
/*/
//-------------------------------------------------------------------------------------
Static Function GetPergTRp()

Return cAutoPerg
