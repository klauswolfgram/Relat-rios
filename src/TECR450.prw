/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR450.CH"
#INCLUDE "report.ch"

#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
Static cAutoPerg := "ATR450"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR450   ³ Autor ³ Eduardo Riera         ³ Data ³ 06.10.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do Ordem de Servico.                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³25/05/2006³Cleber Martinez³Bops 98346: Localizacao do modulo SIGATEC.  ³±±
±±³11/08/2006³Cleber Martinez³Bops 99263: Conversao para relatorio perso- ³±±
±±³          ³               ³nalizavel (Release 4).                      ³±±
±±³16/02/2007³Conrado Quilles³Bops 119542: Retirado função de ajuste.     ³±±
±±³23/04/2007³Cleber Martinez³Bops 124760: Correcao no dbSeek do SX1 devi-³±±
±±³          ³               ³do a mudanca do tamanho do campo X1_GRUPO.  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function TECR450(cOs)
Local oReport							//Objeto do relatorio personalizavel
Local aArea		:= GetArea()			//Guarda a area atual
Local cPergunte := Padr("ATR450",10)	//Nome da pergunta p/ buscar no X1_GRUPO

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ MV_PAR01               Ordem de Servico De                    ³
//³ MV_PAR02               Ordem de Servico Ate                   ³
//³ MV_PAR03               Qual Moeda                             ³
//³ MV_PAR04               Outras Moedas (Converter/Nao imprimir) ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("ATR450",.F.)
If !Empty(cOS)
	MV_PAR01 := cOS
	MV_PAR02 := cOS
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:=Tcr450RptDef()
oReport:PrintDialog()


RestArea( aArea )

Return	


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr450RptDef ºAutor  ³Cleber Martinez     º Data ³  11/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR450 R4                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr450RptDef()
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
	cAlias1	:= "AB6"
	cAlias3	:= "AB8"
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a criacao do objeto oReport  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "TECR450" TITLE STR0001 PARAMETER "ATR450" ACTION {|oReport| Tcr450PrtRpt(oReport, cAlias1, cAlias3)} DESCRIPTION STR0002 + STR0003 + STR0004 
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao1 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection1 OF oReport TITLE STR0023 TABLES "AB6","SA1","SE4" TOTAL TEXT STR0018 TOTAL IN COLUMN 		//"Ordem de Serviço"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao1  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		DEFINE CELL NAME "AB6_NUMOS" 	OF oSection1 ALIAS "AB6" CELL BREAK
		DEFINE CELL NAME "AB6_CODCLI" 	OF oSection1 ALIAS "AB6"
		DEFINE CELL NAME "AB6_LOJA" 	OF oSection1 ALIAS "AB6"
		DEFINE CELL NAME "A1_NOME" 		OF oSection1 ALIAS "SA1" CELL BREAK
		DEFINE CELL NAME "AB6_EMISSA" 	OF oSection1 ALIAS "AB6" CELL BREAK
		DEFINE CELL NAME "AB6_MOEDA" 	OF oSection1 ALIAS "AB6" CELL BREAK 
		DEFINE CELL NAME "AB6_ATEND" 	OF oSection1 ALIAS "AB6" CELL BREAK
		DEFINE CELL NAME "AB6_CONPAG" 	OF oSection1 ALIAS "AB6"
		DEFINE CELL NAME "E4_DESCRI" 	OF oSection1 ALIAS "SE4"
		DEFINE CELL NAME "AB6_DESC1" 	OF oSection1 ALIAS "AB6"
		DEFINE CELL NAME "AB6_DESC2" 	OF oSection1 ALIAS "AB6"		
		DEFINE CELL NAME "AB6_DESC3" 	OF oSection1 ALIAS "AB6"
		DEFINE CELL NAME "AB6_DESC4" 	OF oSection1 ALIAS "AB6"
          
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao2 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		DEFINE SECTION oSection2 OF oSection1 TITLE STR0024 TABLE "AB7","AB6","AAG","AA3"			//Itens da ordem de servico
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define as celulas que irao aparecer na secao2  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DEFINE CELL NAME "AB7_ITEM" 	OF oSection2 ALIAS "AB7"
			DEFINE CELL NAME "AB7_TIPO" 	OF oSection2 ALIAS "AB7"
			DEFINE CELL NAME "AB7_CODPRO" 	OF oSection2 ALIAS "AB7"
			DEFINE CELL NAME "AB7_NUMSER" 	OF oSection2 ALIAS "AB7"
			DEFINE CELL NAME "AB7_CODPRB" 	OF oSection2 ALIAS "AB7"
			DEFINE CELL NAME "AAG_DESCRI" 	OF oSection2 ALIAS "AAG" 
			DEFINE CELL NAME "AA3_CONTRT"  	OF oSection2 ALIAS "AA3" 
			DEFINE CELL NAME "AA3_DTGAR" 	OF oSection2 ALIAS "AA3"
            
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao3 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DEFINE SECTION oSection3 OF oSection2 TITLE STR0025 TABLE "AB8","AB7","AB6"					//Subitens da ordem de servico
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define as celulas que irao aparecer na secao3  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
			DEFINE CELL NAME "AB8_SUBITE" 	OF oSection3 ALIAS "AB8"
			DEFINE CELL NAME "AB8_CODPRO" 	OF oSection3 ALIAS "AB8"
			DEFINE CELL NAME "AB8_DESPRO" 	OF oSection3 ALIAS "AB8"
			DEFINE CELL NAME "AB8_CODSER" 	OF oSection3 ALIAS "AB8"
			DEFINE CELL NAME "AB8_QUANT" 	OF oSection3 ALIAS "AB8" PICTURE PesqPict("AB8","AB8_QUANT")
			DEFINE CELL NAME "AB8_VUNIT" 	OF oSection3 ALIAS "AB8" PICTURE PesqPict("AB8","AB8_VUNIT",14,MV_PAR03) BLOCK {|| TCR450VUNIT(cAlias1,cAlias3) }
			DEFINE CELL NAME "nAB8_TOTAL" 	OF oSection3 ALIAS " " TITLE STR0019 PICTURE PesqPict("AB8","AB8_TOTAL",19,MV_PAR03) BLOCK {|| TCR450TOTAL("C",cAlias1,cAlias3) }	//"Valor Cliente"
            DEFINE CELL NAME "nVlrFabric" 	OF oSection3 ALIAS " " TITLE STR0020 PICTURE PesqPict("AB8","AB8_TOTAL",19,MV_PAR03) BLOCK {|| TCR450TOTAL("F",cAlias1,cAlias3) }	//"Valor Fabricante"
            
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Totalizadores da Secao 3 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DEFINE FUNCTION FROM oSection3:Cell("nAB8_TOTAL") FUNCTION SUM NO END REPORT //END PAGE 
		 	DEFINE FUNCTION FROM oSection3:Cell("nVlrFabric") FUNCTION SUM NO END REPORT //END PAGE 

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Totalizadores da Secao 1 (Pagina) ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DEFINE FUNCTION FROM oSection3:Cell("nAB8_TOTAL") OF oSection1 FUNCTION SUM NO END REPORT END PAGE
		 	DEFINE FUNCTION FROM oSection3:Cell("nVlrFabric") OF oSection1 FUNCTION SUM NO END REPORT END PAGE

        oSection1:SetPageBreak()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define impressao no estilo Enchoice ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        oSection1:SetLineStyle()
        //oSection2:SetLineBreak()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime total em coluna (default .T. - linha ) ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oSection3:SetTotalText(STR0021)		//"SUB-TOTAL"
		oSection3:SetTotalInLine(.F.)
		
Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ TCR450VUNIT ºAutor  ³Cleber Martinez     º Data ³  11/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para retornar o valor unitario de acordo com a Moeda    º±±
±±º          ³selecionada.                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR450 R4                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TCR450VUNIT(cAlias1,cAlias3)
Local nAB8_VUNIT:= 0										// Valor do campo AB8_VUNIT
Local nDecs		:= Msdecimais(MV_PAR03)						// Nr. de casas decimais da Moeda escolhida p/ o relatorio

nAB8_VUNIT := Round(xMoeda((cAlias3)->AB8_VUNIT, (cAlias1)->AB6_MOEDA, MV_PAR03, (cAlias1)->AB6_EMISSA, nDecs+1,(cAlias1)->AB6_TXMOED), nDecs)

Return nAB8_VUNIT


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ TCR450TOTAL ºAutor  ³Cleber Martinez     º Data ³  11/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para retornar o valor total do item (valor cliente e    º±±
±±º          ³fabricante)                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR450 R4                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TCR450TOTAL(cOpcao,cAlias1,cAlias3)
Local nAB8_TOTAL:= 0										// Valor do campo AB8_TOTAL 
Local nValorRet	:= 0										// Valor de retorno da funcao
Local nDecs		:= Msdecimais(MV_PAR03)						// Nr. de casas decimais da Moeda escolhida p/ o relatorio

nAB8_TOTAL := Round(xMoeda((cAlias3)->AB8_TOTAL, (cAlias1)->AB6_MOEDA, MV_PAR03, (cAlias1)->AB6_EMISSA, nDecs+1, (cAlias1)->AB6_TXMOED), nDecs)

//Verifica se eh Valor Total do Cliente ou Fabricante
If cOpcao == "C"
	nValorRet := AtVlrPagto((cAlias3)->AB8_CODSER,nAB8_TOTAL,"C")
ElseIf cOpcao == "F"
	nValorRet := AtVlrPagto((cAlias3)->AB8_CODSER,nAB8_TOTAL,"F")
EndIf

Return nValorRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr450PrtRptºAutor  ³Cleber Martinez     º Data ³  11/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³Nenhum                                                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³oReport: Objeto TReport do relatorio personalizavel        	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR450 R4                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr450PrtRpt( oReport, cAlias1, cAlias3 )
Local oSection1 := oReport:Section(1)							// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)							// Define que a secao 2 sera filha da secao 1
Local oSection3 := oReport:Section(1):Section(1):Section(1)	// Define que a secao 3 sera filha da secao 2
Local cWhere	:= ""											// Condicao a adicionar na query
Local cSelect	:= ""											// Campos adicionais do Select

#IFDEF TOP
	DbSelectArea("AB6")
	DbSetOrder(1)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("ATR450")
    
	If mv_par04 == 2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ So imprimir orcamentos com moeda igual a escolhida (MV_PAR03)   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cWhere := "% AND AB6_MOEDA = '" + Str(mv_par03) + "' %"
	Else
		cWhere := "% %"
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Adiciona campos no SELECT ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSelect := "%, AB6_TXMOED %"

	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BeginSql alias cAlias1
		SELECT	AB6_NUMOS,	AB6_CODCLI,	AB6_LOJA,	AB6_EMISSA,
				AB6_MOEDA,	AB6_ATEND,	AB6_CONPAG,	E4_DESCRI,
				AB6_DESC1,	AB6_DESC2,	AB6_DESC3,	AB6_DESC4,
				AB7_NUMOS,	AB7_ITEM,	AB7_TIPO,	AB7_CODPRO,	
				AB7_NUMSER,	AB7_CODPRB,	AB7_NUMOS,	A1_NOME
				%exp:cSelect%
				
		FROM %table:AB6% AB6, %table:AB7% AB7, %table:SA1% SA1, %table:SE4% SE4
		WHERE	AB6_FILIAL = %xfilial:AB6%		AND
				AB6_NUMOS >= %exp:mv_par01%		AND  
				AB6_NUMOS <= %exp:mv_par02%		AND
				AB6.%notDel%					AND
				AB7_FILIAL = %xfilial:AB7%		AND
				AB7_NUMOS = AB6_NUMOS			AND
				AB7.%notDel%					AND
				A1_FILIAL = %xfilial:SA1%		AND
				AB6_CODCLI = A1_COD				AND
				AB6_LOJA = A1_LOJA				AND
				SA1.%notDel%					AND                       
				E4_FILIAL = %xfilial:SE4%		AND
				AB6_CONPAG = E4_CODIGO			AND
				SE4.%notDel%				
				%exp:cWhere%				

		ORDER BY %Order:AB6%
				
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
		SELECT	AB8_SUBITE,	AB8_CODPRO,	AB8_DESPRO,
				AB8_CODSER,	AB8_QUANT,	AB8_VUNIT,
				AB8_TOTAL
				
		FROM %table:AB8% AB8
		WHERE	AB8_FILIAL	= 	%xfilial:AB8%	AND
				AB8_NUMOS	=	%report_param: (cAlias1)->AB7_NUMOS%	AND
				AB8_ITEM	=	%report_param: (cAlias1)->AB7_ITEM%		AND
				AB8.%notDel%
				
		ORDER BY %Order:AB8%
	EndSql

	END REPORT QUERY oSection3
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona nas tabelas auxiliares ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
	TRPosition():New(oSection2,"AAG",1,{|| xFilial("AAG")+(cAlias1)->AB7_CODPRB }) 
	TRPosition():New(oSection2,"AA3",1,{|| xFilial("AA3")+(cAlias1)->AB6_CODCLI+(cAlias1)->AB6_LOJA+(cAlias1)->AB7_CODPRO+(cAlias1)->AB7_NUMSER }) 
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define que a secao 2 usara a mesma query da secao 1 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection2:SetParentQuery()
	oSection2:SetParentFilter({|cParam| (cAlias1)->AB7_NUMOS == cParam},{|| (cAlias1)->AB6_NUMOS })

#ELSE

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("ATR450")

	DbSelectArea("AB6") 
	DbSetOrder(1)
    
	cFiltro := "AB6_FILIAL == '" + xFilial("AB6") + "' .AND. "
	cFiltro += "AB6_NUMOS >= '" + mv_par01 + "' .AND. "
	cFiltro += "AB6_NUMOS <= '" + mv_par02 + "'" 
	If mv_par04 == 2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ So imprimir Ord. Serv. com moeda igual a escolhida (MV_PAR03)   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cFiltro += " .AND. AB6_MOEDA == " + Str(mv_par03) 
	EndIf
		 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Efetua o filtro de acordo com a expressao do arquivo AB6 (Ordens de Servico)  						 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:SetFilter( cFiltro )
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa a secao2, com o mesmo filtro da secao1.                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection2:SetRelation({|| xFilial("AB7") + AB6->AB6_NUMOS },"AB7",1,.T.)
	oSection2:SetParentFilter({|cParam| AB7->AB7_NUMOS == cParam},{|| AB6->AB6_NUMOS })
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa a secao3, com o mesmo filtro da secao2.                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection3:SetRelation({|| xFilial("AB8") + AB7->AB7_NUMOS + AB7->AB7_ITEM },"AB8",1,.T.)
	oSection3:SetParentFilter({|cParam| AB8->AB8_NUMOS + AB8->AB8_ITEM == cParam},{|| AB7->AB7_NUMOS + AB7->AB7_ITEM })

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona nas tabelas auxiliares ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    TRPosition():New(oSection1,"SA1",1,{|| xFilial("SA1")+AB6->AB6_CODCLI+AB6->AB6_LOJA }) 
	TRPosition():New(oSection1,"SE4",1,{|| xFilial("SE4")+AB6->AB6_CONPAG }) 
	TRPosition():New(oSection2,"AAG",1,{|| xFilial("AAG")+AB7->AB7_CODPRB }) 
	TRPosition():New(oSection2,"AA3",1,{|| xFilial("AA3")+AB6->AB6_CODCLI+AB6->AB6_LOJA+AB7->AB7_CODPRO+AB7->AB7_NUMSER }) 

#ENDIF	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(STR0022) //"ORDEM DE SERVICO"
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
aLay[02] := STR0008 // "|                                ORDEM DE SERVICO                                                   | Nr.OS: ###### | Folha: ######|"
aLay[03] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[04] := "|                                                                                                                                  |"
aLay[05] := STR0009 // "|Cliente  : ######/## - ########################################                                                                   |"
aLay[06] := STR0010 // "|Emissao  : ##########                                                                                                             |"
aLay[07] := STR0017 // "|Moeda    : #                                                                                                                      |"
aLay[08] := STR0011 // "|Atendente: ####################                                                                                                   |"
aLay[09] := STR0012 // "|Cond.Pag.: ### - ##################################                                 Desconto(s): ###### + ###### + ###### + ######|"
aLay[10] := "|                                                                                                                                  |"
aLay[11] := "+----------------------------------------------------------------------------------------------------------------------------------+"
aLay[12] := STR0013 // "|It|   Tipo   |    Produto    |      Nr.Serie      |                Problema               |    Contrato   | Garantia |            |"
aLay[13] := "+--+----------+---------------+--------------------+---------------------------------------+---------------+----------+------------+"
aLay[14] := "|##|##########|###############|####################|#######################################|###############|##########|            |"
aLay[15] := "+--+----------+-------+-------+--------------------+-+-------+--------------+--------------+---------------+---+------+------------+"
aLay[16] := STR0014 //"|  |IT|Produto        |Descricao                     |Servico|  Quantidade  |Valor Unitario|    Valor Total    | Valor Fabricante  |"
aLay[17] := "+--+------------------+-------+----------------------+-------+--------------+--------------+-------------------+-------------------+"
aLay[18] := "|->|##|###############|##############################|#######|##############|##############|###################|                   |"
aLay[19] := "+--+------------------+------------------------------+-------+--------------+--------------+-------------------+-------------------+"
aLay[20] := STR0015 // "|                                                                            SUB-TOTAL     | ##################| ##################|"
aLay[21] := "|------------------------------------------------------------------------------------------+-------------------+-------------------+"
aLay[22] := "|                                                                                                                                  |"
aLay[23] := "+------------------------------------------------------------------------------------------+-------------------+-------------------+"
aLay[24] := STR0016 //"|                                                                            TOTAL GERAL   | ##################| ##################|"
aLay[25] := "+------------------------------------------------------------------------------------------+-------------------+-------------------+"
aLay[26] := "|  |          |               |                    |                                       |               |          |            |"

Return(aLay)

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

Return Tcr450RptDef()

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

Return Tcr450PrtRpt( oReport , GetNextAlias() , GetNextAlias() )

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