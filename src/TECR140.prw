/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR140.CH"
#INCLUDE "REPORT.CH"

#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
Static cAutoPerg := "ATR140"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR140   ³ Autor ³ Rodrigo Toledo        ³ Data ³ 06/05/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao Status do Contrato                      			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TECR140()
Local oReport				//Objeto do relatorio personalizavel
Local aArea := GetArea()	//Guarda a area atual

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                       PARAMETROS                                       ³
//³                                                                        ³
//³ MV_PAR01 : Cliente Inicial de ?                                    	   ³
//³ MV_PAR02 : Cliente Final   Ate ?                                   	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("ATR140",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := Tcr140RptDef()
oReport:SetLandscape()
oReport:PrintDialog()

RestArea( aArea )
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr140RptDef ºAutor  ³Rodrigo Toledo      º Data ³  06/05/2011 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR140                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr140RptDef()
Local oReport			// Objeto do relatorio
Local oSection1			// Objeto secao 1 do relatorio (Cabecalho, campos da tabela AD1)
Local oSection2			// Objeto secao 2 do relatorio (detalhes, campos das tabelas "AD1")
Local oSection3			// Objeto secao 3 do relatorio (detalhes, campos das tabelas "AAH")
Local oSection4			// Objeto secao 4 do relatorio (detalhes, campos das tabelas "AAM")
Local oSection5			// Objeto secao 5 do relatorio (detalhes, campos das tabelas "AAA")
Local oSection6			// Objeto secao 6 do relatorio (detalhes, campos das tabelas "AB6")
Local oSection7			// Objeto secao 7 do relatorio (detalhes, campos das tabelas "SC6")
Local oSection8			// Objeto secao 8 do relatorio (detalhes, campos das tabelas "SC6")
Local aOrdem	:= {}  
Local cAlias1	:= ""	// Pega o proximo Alias Disponivel

#IFDEF TOP
	cAlias1	:= GetNextAlias()
#ELSE 
	cAlias1	:= "AD1"
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a criacao do objeto oReport  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "TECR140" TITLE STR0001 PARAMETER "ATR140" ACTION {|oReport| Tcr140PrtRpt(oReport, aOrdem, cAlias1)} DESCRIPTION STR0002 + STR0003 + STR0004
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao1 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	DEFINE SECTION oSection1 OF oReport TITLE STR0005 TABLES "AD1" // "Oportunidade de Venda"			
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define as celulas que irao aparecer na secao1  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:SetLineBreak()	
	DEFINE CELL NAME "AD1_NROPOR"	OF oSection1 ALIAS "AD1"
	DEFINE CELL NAME "AD1_REVISA"	OF oSection1 ALIAS "AD1"
	DEFINE CELL NAME "AD1_DESCRI" 	OF oSection1 ALIAS "AD1"
	DEFINE CELL NAME "AD1_DATA" 	OF oSection1 ALIAS "AD1"
	DEFINE CELL NAME "AD1_CODCLI" 	OF oSection1 ALIAS "AD1"
	DEFINE CELL NAME "AD1_LOJCLI" 	OF oSection1 ALIAS "AD1"
	DEFINE CELL NAME "AD1_NOMCLI" 	OF oSection1 ALIAS "AD1" BLOCK {|| Posicione("SA1",1,xFilial("SA1")+(cAlias1)->AD1_CODCLI+(cAlias1)->AD1_LOJCLI,"A1_NOME")}
	DEFINE CELL NAME "AD1_VEND" 	OF oSection1 ALIAS "AD1"
	DEFINE CELL NAME "AD1_NOMVEN" 	OF oSection1 ALIAS "AD1" BLOCK {|| Posicione("SA3",1,xFilial("SA3")+(cAlias1)->AD1_VEND,"A3_NOME")}
	DEFINE CELL NAME "AD1_DTINI" 	OF oSection1 ALIAS "AD1"
	DEFINE CELL NAME "AD1_DTFIM" 	OF oSection1 ALIAS "AD1"
	DEFINE CELL NAME "AD1_FCS"	 	OF oSection1 ALIAS "AD1"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao2 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				
	DEFINE SECTION oSection2 OF oSection1 TITLE STR0006 TABLE "ADY","ADZ" LEFT MARGIN 5 // "Proposta Comercial"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define as celulas que irao aparecer na secao2  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    	
	DEFINE CELL NAME "ADY_PROPOS" 		OF oSection2 ALIAS "ADY" 
	DEFINE CELL NAME "ADY_PREVIS" 		OF oSection2 ALIAS "ADY"
	DEFINE CELL NAME "ADY_DATA" 		OF oSection2 ALIAS "ADY"
	DEFINE CELL NAME STR0012 			OF oSection2 ALIAS "ADY" BLOCK {||IF(ADY->ADY_TPCONT == "1",STR0013,IIF(ADY->ADY_TPCONT == "2",STR0014,STR0015))}
	DEFINE CELL NAME "ADZ_TOTAL" 		OF oSection2 ALIAS "ADZ" PICTURE PesqPict("ADZ","ADZ_TOTAL",14) HEADER ALIGN RIGHT
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao3 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
	DEFINE SECTION oSection3 OF oSection2 TITLE STR0007 TABLE "AAH" LEFT MARGIN 10 // "Contrato de Manutenção"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define as celulas que irao aparecer na secao3  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
	oSection3:SetLineBreak()
	DEFINE CELL NAME "AAH_CONTRT" 	OF oSection3 ALIAS "AAH" 
	DEFINE CELL NAME "AAH_TPCONT" 	OF oSection3 ALIAS "AAH"
	DEFINE CELL NAME "AAH_INIVLD" 	OF oSection3 ALIAS "AAH"
	DEFINE CELL NAME "AAH_FIMVLD" 	OF oSection3 ALIAS "AAH"
	DEFINE CELL NAME "AAH_CODPRO" 	OF oSection3 ALIAS "AAH"
	DEFINE CELL NAME "B1_DESC" 		OF oSection3 ALIAS "AAH" BLOCK {|| Posicione("SB1",1,xFilial("SB1")+AAH->AAH_CODPRO,"B1_DESC")}
	DEFINE CELL NAME "AAH_VALOR" 	OF oSection3 ALIAS "AAH" PICTURE PesqPict("AAH","AAH_VALOR",14) HEADER ALIGN RIGHT
	DEFINE CELL NAME "AAH_INICOB" 	OF oSection3 ALIAS "AAH"
	DEFINE CELL NAME "AAH_FIMCOB" 	OF oSection3 ALIAS "AAH"
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao4 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
	DEFINE SECTION oSection4 OF oSection3 TITLE STR0008 TABLE "AAB" LEFT MARGIN 15 // "Grupo de Cobertura"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define as celulas que irao aparecer na secao4  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
	DEFINE CELL NAME "AAB_TIPO" 	OF oSection4 ALIAS "AAB"
	DEFINE CELL NAME "AAB_GRUPO" 	OF oSection4 ALIAS "AAB"
	DEFINE CELL NAME "AAB_CODPRO" 	OF oSection4 ALIAS "AAB"
	DEFINE CELL NAME "B1_DESC" 		OF oSection4 ALIAS "AAB" BLOCK {|| Posicione("SB1",1,xFilial("SB1")+AAB->AAB_CODPRO,"B1_DESC")}
	DEFINE CELL NAME "AAB_CODSER" 	OF oSection4 ALIAS "AAB"
	DEFINE CELL NAME "AAB_DESCRI" 	OF oSection4 ALIAS "AAB" BLOCK {|| Posicione("AA5",1,xFilial("AA5")+AAB->AAB_CODSER,"AA5_DESCRI")}
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao5 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
	DEFINE SECTION oSection5 OF oSection3 TITLE STR0009 TABLE "AB6" LEFT MARGIN 15 //"O/S"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define as celulas que irao aparecer na secao5  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
	DEFINE CELL NAME "AB6_NUMOS" 	OF oSection5 ALIAS "AB6" 
	DEFINE CELL NAME "AB6_EMISSA" 	OF oSection5 ALIAS "AB6"
	DEFINE CELL NAME "AB6_ATEND" 	OF oSection5 ALIAS "AB6"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao6 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
	DEFINE SECTION oSection6 OF oSection3 TITLE STR0010 TABLE "SC5","SC6" LEFT MARGIN 15 //"Pedidos de Venda"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define as celulas que irao aparecer na secao6  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
	DEFINE CELL NAME "C5_NUM" 		OF oSection6 ALIAS "SC5"
	DEFINE CELL NAME "C5_TIPO" 		OF oSection6 ALIAS "SC5"
	DEFINE CELL NAME "C5_EMISSAO"	OF oSection6 ALIAS "SC5"	
	DEFINE CELL NAME "C5_TABELA"	OF oSection6 ALIAS "SC5"
	DEFINE CELL NAME "C5_CONDPAG"	OF oSection6 ALIAS "SC5"
	DEFINE CELL NAME "C6_VALOR"		OF oSection6 ALIAS "SC6" PICTURE PesqPict("SC6","C6_VALOR",14) HEADER ALIGN RIGHT
	DEFINE CELL NAME "C6_NUMOS"		OF oSection6 ALIAS "SC6"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao7 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
	DEFINE SECTION oSection7 OF oSection2 TITLE STR0011 TABLE "AAM" LEFT MARGIN 10 // "Contrato de Serviço"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define as celulas que irao aparecer na secao4  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
	DEFINE CELL NAME "AAM_CONTRT" 	OF oSection7 ALIAS "AAM" 
	DEFINE CELL NAME "AAM_TPCONT" 	OF oSection7 ALIAS "AAM"
	DEFINE CELL NAME "AAM_CLASSI" 	OF oSection7 ALIAS "AAM"
	DEFINE CELL NAME "AAM_DESCLA" 	OF oSection7 ALIAS "AAM" BLOCK {|| Tabela("A7", AAM->AAM_CLASSI, .F. )}
	DEFINE CELL NAME "AAM_INIVIG" 	OF oSection7 ALIAS "AAM" 
	DEFINE CELL NAME "AAM_FIMVIG" 	OF oSection7 ALIAS "AAM"
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao8 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
	DEFINE SECTION oSection8 OF oSection7 TITLE STR0010 TABLE "SC5","SC6" LEFT MARGIN 15 //"Pedidos de Venda"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define as celulas que irao aparecer na secao6  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
	DEFINE CELL NAME "C5_NUM" 		OF oSection8 ALIAS "SC5"
	DEFINE CELL NAME "C5_TIPO" 		OF oSection8 ALIAS "SC5"
	DEFINE CELL NAME "C5_EMISSAO"	OF oSection8 ALIAS "SC5"	
	DEFINE CELL NAME "C5_TABELA"	OF oSection8 ALIAS "SC5"
	DEFINE CELL NAME "C5_CONDPAG"	OF oSection8 ALIAS "SC5"
	DEFINE CELL NAME "C6_VALOR"		OF oSection8 ALIAS "SC6" PICTURE PesqPict("SC6","C6_VALOR",14) HEADER ALIGN RIGHT
	 	
	oSection1:SetTotalInLine(.F.)
	oSection2:SetTotalInLine(.F.)
	oSection3:SetTotalInLine(.F.)
	oSection4:SetTotalInLine(.F.)
	oSection5:SetTotalInLine(.F.)
	oSection6:SetTotalInLine(.F.)
	oSection7:SetTotalInLine(.F.)
	oSection8:SetTotalInLine(.F.)

Return oReport
  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr140PrtRptºAutor  ³Rodrigo Toledo      º Data ³  06/05/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³Nenhum                                                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³oReport: Objeto TReport do relatorio personalizavel        	º±±
±±º          ³aOrdem:  Array com as ordens de impressao disponiveis      	º±±
±±º          ³cAlias: Alias principal do relatorio                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR130                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr140PrtRpt( oReport, aOrdem, cAlias1 )
Local oSection1 := oReport:Section(1)				// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)				// Define que a secao 2 sera filha da secao 1
Local oSection3 := oSection2:Section(1)				// Define que a secao 3 sera filha da secao 2
Local oSection4 := oSection3:Section(1)				// Define que a secao 4 sera filha da secao 3
Local oSection5 := oSection3:Section(2)				// Define que a secao 5 sera filha da secao 3
Local oSection6 := oSection3:Section(3)				// Define que a secao 6 sera filha da secao 3
Local oSection7 := oSection2:Section(2)				// Define que a secao 7 sera filha da secao 2
Local oSection8 := oSection7:Section(1)				// Define que a secao 8 sera filha da secao 7
Local nOrdem 	:= 1								// Ordem definida pelo usuario
Local cOrderBy	:= ""								// Chave de ordenacao
Local cIndexKey := ""								// Indice do filtro (CodeBase)
Local cQuebra 	:= ""								// Conteudo da quebra do relatorio
Local cFiltro	:= ""								// Filtro da tabela (CodeBase)
Local nLin 		:= 0								// Guarda a linha atual impressa
Local cDbMs		:= ""								// Nome do BD              
Local nLoop		:= 0								// Contador
Local nPos		:= 0                                // Localiza a posicao do codigo do produto
Local nValor	:= 0								// Carrela o valor total da proposta       
Local cContrat  := ""								// Carrega o numero do contrato
Local cTpContr  := ""								// Carrega o tipo do contrato
Local aPedido	:= {}								// Armazena os itens do pedido de venda
Local aNoOs     := {}                              // Armazena o numero da O/S
Local nX        := 0							   // Incremento utilizado no For

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pega a ordem escolhida pelo usuario ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nOrdem := oSection1:GetOrder() 
If nOrdem <= 0
	nOrdem := 1
EndIf

#IFDEF TOP
	cDbMs	:= UPPER(TcGetDb())  //define o tipo de banco para diferenciar o operador de soma
	cOrderBy := "% AD1_FILIAL,AD1_NROPOR,AD1_REVISA %"
	cIndexKey:= "AD1_FILIAL+AD1_NROPOR+AD1_REVISA"	
#ENDIF
#IFDEF TOP
	DbSelectArea("AD1") 
	DbSetOrder(1)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("ATR140")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao1 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	BeginSql alias cAlias1
		SELECT	AD1_NROPOR, AD1_REVISA, AD1_DESCRI, AD1_DATA, AD1_CODCLI, AD1_LOJCLI, AD1_VEND,
				AD1_DTINI, AD1_DTFIM, AD1_FCS
				
		FROM %table:AD1% AD1, %table:ADY% ADY
		
		WHERE	AD1.AD1_FILIAL = %xfilial:AD1%		AND
				AD1.AD1_PROPOS = ADY.ADY_PROPOS		AND
				AD1.AD1_CODCLI >= %exp:mv_par01%	AND
				AD1.AD1_CODCLI <= %exp:mv_par02%	AND
				AD1.AD1_STATUS =  %exp:'9'%			AND
				ADY.ADY_PROCES =  %exp:'S'%			AND
				AD1.%notDel%          				AND
				ADY.%notDel%
								
		ORDER BY %exp:cOrderBy%		
	EndSql
	
	END REPORT QUERY oSection1

#ELSE

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cAlias1 := "AD1"
	MakeAdvplExpr("ATR140")	

	DbSelectArea(cAlias1) 
	DbSetOrder(1)

	cFiltro := "AD1_FILIAL=='"+xFilial("AD1")+"'.AND."	
	cFiltro += "AD1_CODCLI>='"+MV_PAR01+"'.AND."
	cFiltro += "AD1_CODCLI<='"+MV_PAR02+"'.AND."
	cFiltro += "AD1_STATUS='9'"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Efetua o filtro de acordo com a expressao do arquivo AD1 (Oportunidade de Vendas)					 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:SetFilter( cFiltro, cIndexKey )
	
	oReport:Section(1):SetFilter(cFiltro, cIndexKey)
	oReport:Section(1):SetLineCondition({|| dbSelectArea("AD1"),dbSetOrder(1),AD1->(MsSeek(xFilial("AD1")+(cAlias1)->AD1_NROPOR+(cAlias1)->AD1_REVISA))})
	
	oSection2:SetParentQuery()
	oSection2:SetParentFilter({|| xFilial( "ADY" ) == ADY->ADY_FILIAL .And. (cAlias1)->AD1_PROPOS == ADY->ADY_PROPOS .And. ADY_PROCES='S'})	
		
#ENDIF	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona a ordem escolhida ao titulo do relatorio          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + Space(05))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter((cAlias1)->(LastRec()))
DbSelectArea(cAlias1)
cQuebra := (cAlias1)->AD1_NROPOR+(cAlias1)->AD1_REVISA

While !oReport:Cancel() .AND. !(cAlias1)->(Eof())
	
	If cQuebra <> (cAlias1)->AD1_NROPOR+(cAlias1)->AD1_REVISA
		oReport:Section(1):SetPageBreak(.T.)
	EndIf
	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf	
	cQuebra := (cAlias1)->AD1_NROPOR+(cAlias1)->AD1_REVISA
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime a secao 1 e 2 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ADY->(DbSetOrder(2))
	ADZ->(DbSetOrder(3))    
	If ADY->(MsSeek(xFilial("ADY")+cQuebra))
		While (ADY->(!EOF()) .AND. xFilial("ADY") == ADY->ADY_FILIAL .AND.;
		 				 ADY->(ADY_OPORTU+ADY_REVISA) == cQuebra)
		 	If ADY->ADY_PROCES == 'S'
		 		If !isBlind()
					oSection1:Init()
				EndIf
				oReport:PrintText(STR0005,,10) //"Oportunidade de Venda"
				oReport:Line(oReport:Row(),10,oReport:Row(),290)
				oReport:SkipLine()
				If !isBlind()
					oSection1:PrintLine()
					oSection1:Finish()
				EndIf
				oReport:Line(oReport:Row(),10,oReport:Row(),2830)
				oReport:SkipLine()
				nValor := 0				
				ADZ->(MsSeek(xFilial("ADZ")+ADY->(ADY_PROPOS+ADY_PREVIS)))
				While (ADZ->(!Eof()) .AND. xFilial("ADZ") == ADY->ADY_FILIAL .AND.;
								 ADZ->ADZ_PROPOS == ADY->ADY_PROPOS .AND.;
								 ADZ->ADZ_REVISA == ADY->ADY_PREVIS)
					nValor += ADZ->ADZ_TOTAL
					ADZ->(DbSkip())
				End		
				oReport:PrintText(STR0006,,80) //"Proposta Comercial"
				oReport:Line(oReport:Row(),80,oReport:Row(),320)
				oSection2:Cell("ADZ_TOTAL"):SetValue(nValor)
				If !isBlind()
					oSection2:Init()
					oSection2:PrintLine()
					oSection2:Finish()
				EndIf
				oReport:Line(oReport:Row(),90,oReport:Row(),1230)
				oReport:SkipLine()
				Exit
			EndIf	
			ADY->(DbSkip())
		End	
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime a secao 3 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ						
	AAH->(DbSetOrder(6))
	If AAH->(DBSeek(xFilial("AAH")+ADY->(ADY_PROPOS+ADY_PREVIS)))
		cContrat := AAH->AAH_CONTRT
		cTpContr := AAH->AAH_TPCONT
		oReport:PrintText(STR0007,,150) //"Contrato de Manutenção"
		oReport:Line(oReport:Row(),150,oReport:Row(),460)
		If !isBlind()
			oSection3:Init()
			oSection3:PrintLine()
			oSection3:Finish()
		EndIf
		oReport:Line(oReport:Row(),170,oReport:Row(),2530)
		oReport:SkipLine()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a secao 4 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ								
		AAA->(DbSetOrder(1))
		If AAA->(DBSeek(xFilial("AAA")+AAH->AAH_CODGRP))
			oReport:PrintText(STR0008,,220)//"Grupo de Cobertura"
			oReport:Line(oReport:Row(),220,oReport:Row(),800)
			oReport:PrintText(AAA->AAA_CODGRP + " - " + AAA->AAA_DESCRI,,220)
			oReport:Line(oReport:Row(),220,oReport:Row(),800)
			AAB->(DbSetOrder(1))										
			If AAB->(DBSeek(xFilial("AAB")+AAA->AAA_CODGRP))
				While (AAB->(!Eof()) .AND. AAB->AAB_FILIAL == xFilial("AAB") .AND. AAB->AAB_CODGRP == AAA->AAA_CODGRP)
					If !isBlind()
						oSection4:Init()
						oSection4:PrintLine()
					EndIF
					AAB->(DbSkip())
				End			
				oSection4:Finish()
				oReport:Line(oReport:Row(),250,oReport:Row(),1870)
				oReport:SkipLine()
			EndIf
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a secao 5 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		AA3->(DbSetOrder(2))	    
		AB7->(DbSetOrder(5))
		AB6->(DbSetOrder(1))		
		If AA3->(DbSeek(xFilial("AA3")+cContrat+AAH->AAH_CODCLI+AAH->AAH_LOJA))
			oReport:PrintText(STR0009,,220) //"O/S - Geradas"
			oReport:Line(oReport:Row(),220,oReport:Row(),400)
			While (AA3->(!Eof()) .AND. AA3->AA3_FILIAL == xFilial("AA3") .AND.;
										AA3->AA3_CONTRT == cContrat .AND.;
										AA3->AA3_CODCLI == AAH->AAH_CODCLI .AND.;
										AA3->AA3_LOJA  == AAH->AAH_LOJA)
				AB7->(DbSeek(xFilial("AB7")+AA3->AA3_CODFAB+AA3->AA3_LOJAFA+AA3->AA3_CODPRO+AA3->AA3_NUMSER))
				While (AB7->(!Eof()) .AND. AB7->AB7_FILIAL == xFilial("AB7") .AND.;
	 							AB7->AB7_CODFAB == AA3->AA3_CODFAB .AND.;				
	 							AB7->AB7_LOJAFA == AA3->AA3_LOJAFA .AND.;
	 							AB7->AB7_CODPRO == AA3->AA3_CODPRO .AND.;
	 							AB7->AB7_NUMSER == AA3->AA3_NUMSER)
					If AB6->(DBSeek(xFilial("AB6")+AB7->AB7_NUMOS))
						If aScan(aNoOs,AB6->AB6_NUMOS) == 0
							If !isBlind()
								oSection5:Init()
								oSection5:PrintLine()
							EndIf
							aAdd(aNoOs,AB6->AB6_NUMOS) //Armazena o numero da O/S
						EndIf
					EndIf
					AB7->(DbSkip())
				End
				AA3->(DbSkip())
			End
			oSection5:Finish()
			oReport:Line(oReport:Row(),245,oReport:Row(),940)
			oReport:SkipLine()
		EndIf
		
		aSort(aNoOs) //Ordenacao crescente
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿                                                
		//³ Imprime a secao 6 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SC5->(DbSetOrder(1))
		SC6->(DbSetOrder(1))
		AB8->(DbSetOrder(1))		
		
		For nX := 1 To Len(aNoOS)
			AB8->(DbSeek(xFilial("AB8")+aNoOS[nX]))
			While AB8->(!Eof()) .AND. AB8->AB8_NUMOS == aNoOS[nX]
			    If !Empty(AB8->AB8_NUMPV)
					If SC6->(DbSeek(xFilial("SC6")+AB8->AB8_NUMPV))
						If SC5->(MsSeek(xFilial("SC5")+SC6->C6_NUM))				
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Monta array para os itens do pedido de venda ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
							If (nPos := aScan(aPedido,{|x| x[1] == SC6->C6_NUM})) == 0					
								aAdd(aPedido,{SC5->C5_NUM,;				// 1- Numero do Pedido
									X3Combo("C5_TIPO",SC5->C5_TIPO),;	// 2- Tipo do pedido
									SC5->C5_EMISSAO,;	   				// 3- Data de emissao
									SC5->C5_TABELA,;	   				// 4- Codigo da tabela de preco
									SC5->C5_CONDPAG,;	   				// 5- Condicao de pagto
									SC6->C6_VALOR,;		  				// 6- Vlr. Total
									Substr(aNoOS[nX],1,TAMSX3("AB6_NUMOS")[1])})			// 7- Numero da OS
							Else 				
								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³ Atualiza valores do produto ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
								aPedido[nPos,6] += Round(SC6->C6_VALOR,2)
							EndIf
						EndIf
					EndIf
				EndIf
				AB8->(DbSkip())
		    End
		 Next nX
		 
		 aNoOS := {}
		 			
		If Len(aPedido) > 0
			oReport:PrintText(STR0010,,220) //"Pedidos de Venda"
			oReport:Line(oReport:Row(),220,oReport:Row(),450)
			For nLoop := 1 To Len(aPedido)
				oSection6:Init()
				oSection6:Cell("C5_NUM"):SetValue(aPedido[nLoop,1])
				oSection6:Cell("C5_TIPO"):SetValue(aPedido[nLoop,2])
				oSection6:Cell("C5_EMISSAO"):SetValue(aPedido[nLoop,3])
				oSection6:Cell("C5_TABELA"):SetValue(aPedido[nLoop,4])
				oSection6:Cell("C5_CONDPAG"):SetValue(aPedido[nLoop,5])
				oSection6:Cell("C6_VALOR"):SetValue(aPedido[nLoop,6])
				oSection6:Cell("C6_NUMOS"):SetValue(aPedido[nLoop,7])
				If !isBlind()
					oSection6:PrintLine()
				EndIF
			 Next nLoop
			oSection6:Finish()
			oReport:Line(oReport:Row(),250,oReport:Row(),1550)
			oReport:SkipLine()
			aPedido:= {}
			EndIf			
		EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime a secao 7 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	AAM->(DbSetOrder(3))
	If AAM->(MsSeek(xFilial("AAM")+ADY->(ADY_PROPOS+ADY_PREVIS)))
		oReport:PrintText(STR0011,,150) //"Contrato de Serviços"
		oReport:Line(oReport:Row(),150,oReport:Row(),450)
		If !isBlind()
			oSection7:Init()
			oSection7:PrintLine()
			oSection7:Finish()
		EndIf
		oReport:Line(oReport:Row(),150,oReport:Row(),1575)
		oReport:SkipLine()
		SC5->(DbSetOrder(1))
		SC6->(DbSetOrder(6))		
		If SC6->(DbSeek(xFilial("SC6")+AAM->AAM_CONTRT+"1"))
			While (SC6->(!Eof()) .AND. SC6->C6_FILIAL == xFilial("SC6") .AND.;
										SC6->C6_CONTRT == AAM->AAM_CONTRT .AND.;		
										SC6->C6_TPCONTRT == "1")
				If SC5->(MsSeek(xFilial("SC5")+SC6->C6_NUM))				
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Monta array para os itens do pedido de venda ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
					If (nPos := aScan(aPedido,{|x| x[1] == SC6->C6_NUM})) == 0					
						aAdd(aPedido,{SC5->C5_NUM,;				// 1- Numero do Pedido
							X3Combo("C5_TIPO",SC5->C5_TIPO),;	// 2- Tipo do pedido
							SC5->C5_EMISSAO,;					// 3- Data de emissao
							SC5->C5_TABELA,;					// 4- Codigo da tabela de preco
							SC5->C5_CONDPAG,;					// 5- Condicao de pagto
							SC6->C6_VALOR})						// 6- Vlr. Total
					Else 				
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Atualiza valores do produto ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
						aPedido[nPos,6] += Round(SC6->C6_VALOR,2)
					EndIf
				EndIf
				SC6->(DbSkip())
			End
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime a secao 8 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Len(aPedido) > 0
				oReport:PrintText(STR0010,,220) //"Pedidos de Venda"
				oReport:Line(oReport:Row(),220,oReport:Row(),450)					
			    For nLoop := 1 To Len(aPedido)
					oSection8:Init()
					oSection8:Cell("C5_NUM"):SetValue(aPedido[nLoop,1])
					oSection8:Cell("C5_TIPO"):SetValue(aPedido[nLoop,2])
					oSection8:Cell("C5_EMISSAO"):SetValue(aPedido[nLoop,3])
					oSection8:Cell("C5_TABELA"):SetValue(aPedido[nLoop,4])
					oSection8:Cell("C5_CONDPAG"):SetValue(aPedido[nLoop,5])
					oSection8:Cell("C6_VALOR"):SetValue(aPedido[nLoop,6])
					If !isBlind()					
						oSection8:PrintLine()
					EndIf
			    Next nLoop
				oSection8:Finish()
				oReport:Line(oReport:Row(),220,oReport:Row(),1215)
				oReport:SkipLine()						
				aPedido:= {}
			EndIf
		EndIf										
	EndIf
	dbSelectArea(cAlias1)
	dbSkip()		
End
Return

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

Return Tcr140RptDef()

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

Return Tcr140PrtRpt( oReport, {} , GetNextAlias() )

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