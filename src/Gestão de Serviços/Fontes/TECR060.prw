/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.CH"
#Include "REPORT.CH"
#Include "TECR060.CH"

//------------------------------------------------------------------------------
/*/{Protheus.doc} TECR060
@description	Consulta os processos de indenizações
@sample	 	U_TECR060() 
@param			Nenhum
@return		Nil
@author		Kaique Schiller
@since			14/04/2016
@version		P12   
/*/
//------------------------------------------------------------------------------
User Function TECR060()
Local oReport				//Objeto do relatorio personalizavel
Local aArea := GetArea()	//Guarda a area atual

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ PARAMETROS                                                             ³
//³ MV_PAR01 : Do Codigo ?                                                 ³
//³ MV_PAR02 : Até o Codigo ?                                              ³
//³ MV_PAR03 : Status ?                                              	     ³
//³ MV_PAR04 : Do Contrato ?                                               ³
//³ MV_PAR05 : Até Contrato ?                                              ³
//³ MV_PAR06 : Natureza ?                                                  ³
//³ MV_PAR07 : Cliente ?                                                   ³
//³ MV_PAR08 : Loja ?                                                      ³
//³ MV_PAR09 : Pedido ?                                                    ³
//³ MV_PAR10 : Dt Emissão Pedido ?                                         ³
//³ MV_PAR11 : Da data de finalização ?                                    ³
//³ MV_PAR12 : Até a data de finalização ?                                 ³
//³ MV_PAR13 : Da Filial ?                                                 ³
//³ MV_PAR14 : Até Filial ?                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Pergunte("TECR060",.T.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := Tcr060RptDef()
	oReport:PrintDialog()

Endif

RestArea( aArea )

Return

//------------------------------------------------------------------------------
/*/{Protheus.doc} Tcr060RptDef
@description	Definição das colunas.
@sample	 	Tcr060RptDef() 
@param		Nenhum
@return		oReport
@author		Kaique Schiller
@since		14/04/2016
@version	P12   
/*/
//------------------------------------------------------------------------------
Static Function Tcr060RptDef()
Local oReport			// Objeto do relatorio
Local oSection1		// Objeto da secao 1
Local oSection2		// Objeto da secao 2
Local oSection3		// Objeto da secao 3
Local oSection4		// Objeto da secao 3
Local oCobSec2		// Cobrança total da secao 2
Local oCobSec3		// Cobrança total da secao 3
Local oCobSec4		// Cobrança total da secao 4
Local oFatSec2		// Faturamento total da secao 2
Local oFatSec3		// Faturamento total da secao 3
Local oFatSec4		// Faturamento total da secao 4
Local cPictTotal	:= "@E 999,999,999,999.99"		// Picture para campos numéricos
Local nTamMaxNum	:= Len(cPictTotal) - 3			// Tratamento para não truncar os valores totais

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a criacao do objeto oReport  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "TECR060" TITLE STR0001 PARAMETER "TECR060" ACTION {|oReport| Tcr060PrtRpt(oReport)} DESCRIPTION  STR0002 //"Consulta de indenizações" ## "Consulta as indenizações"
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao1 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection1 OF oReport TITLE STR0003 TABLES "TW9","SC5" //"Indenização"
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao1  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DEFINE CELL NAME "TW9_FILIAL" 	OF oSection1 ALIAS "TW9"
		DEFINE CELL NAME "TW9_CODIGO" 	OF oSection1 ALIAS "TW9" 
		DEFINE CELL NAME "TW9_STATUS" 	OF oSection1 ALIAS "TW9" 
		DEFINE CELL NAME "TW9_CONTRT"	OF oSection1 ALIAS "TW9"
		DEFINE CELL NAME "TW9_NATCOB"	OF oSection1 ALIAS "TW9"
		DEFINE CELL NAME "TW9_CLIENT" 	OF oSection1 ALIAS "TW9"
		DEFINE CELL NAME "TW9_CLILOJ" 	OF oSection1 ALIAS "TW9"
		DEFINE CELL NAME "TW9_CLINOM" 	OF oSection1 BLOCK {|| Posicione( "SA1", 1, xFilial("SA1")+oSection1:Cell("TW9_CLIENT"):GetValue(.T.)+oSection1:Cell("TW9_CLILOJ"):GetValue(.T.), "A1_NOME" )}
		DEFINE CELL NAME "TW9_NUMPED" 	OF oSection1 ALIAS "TW9"		
		DEFINE CELL NAME "C5_EMISSAO" 	OF oSection1 BLOCK {|| Posicione( "SC5", 1, xFilial("SC5")+oSection1:Cell("TW9_NUMPED"):GetValue(.T.), "C5_EMISSAO" )}
		DEFINE CELL NAME "C5_NOTA" 		OF oSection1 BLOCK {|| Posicione( "SC5", 1, xFilial("SC5")+oSection1:Cell("TW9_NUMPED"):GetValue(.T.), "C5_NOTA" )}
		DEFINE CELL NAME "C5_SERIE" 	OF oSection1 BLOCK {|| Posicione( "SC5", 1, xFilial("SC5")+oSection1:Cell("TW9_NUMPED"):GetValue(.T.), "C5_SERIE" )}
		DEFINE CELL NAME "F2_EMISSAO"	OF oSection1 BLOCK {|| Posicione( "SF2", 1, xFilial("SF2")+oSection1:Cell("C5_NOTA"):GetValue(.T.)+;
			                                                                                       oSection1:Cell("C5_SERIE"):GetValue(.T.)+;
			                                                                                       oSection1:Cell("TW9_CLIENT"):GetValue(.T.)+;
			                                                                                       oSection1:Cell("TW9_CLILOJ"):GetValue(.T.), "F2_EMISSAO" )}
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao2 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		DEFINE SECTION oSection2 OF oSection1 TITLE STR0004 TABLE "TWA","SC6" //"SIGATEC"
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define as celulas que irao aparecer na secao2  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DEFINE CELL NAME "TWA_CODAB6"  OF oSection2 ALIAS "TWA"
			DEFINE CELL NAME "TWA_CODAB7"  OF oSection2 ALIAS "TWA"
			DEFINE CELL NAME "TWA_NUMSER"  OF oSection2 ALIAS "TWA"
			DEFINE CELL NAME "TWA_CUSTO"   OF oSection2 ALIAS "TWA"   SIZE nTamMaxNum
			DEFINE CELL NAME "TWA_VLRCOB"  OF oSection2 ALIAS "TWA"   SIZE nTamMaxNum
			DEFINE CELL NAME "C6_VALOR"    OF oSection2 TITLE STR0010 SIZE nTamMaxNum BLOCK {|| Tcr060SC6() } //"Vlr.Faturamento"
			DEFINE CELL NAME "TWA_PRODUT"  OF oSection2 ALIAS "TWA"
			DEFINE CELL NAME "B1_DESC"     OF oSection2 BLOCK {|| Posicione("SB1", 1, xFilial("SB1")+oSection2:Cell("TWA_PRODUT"):GetValue(.T.), "B1_DESC")}
			DEFINE CELL NAME "TWA_TES"     OF oSection2 ALIAS "TWA"

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao3 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
		DEFINE SECTION oSection3 OF oSection1 TITLE STR0005 TABLE "TWA","SC6" //"SIGAMNT"
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define as celulas que irao aparecer na secao3  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DEFINE CELL NAME "TWA_CODSTJ"  OF oSection3 ALIAS "TWA"
			DEFINE CELL NAME "TWA_CODTFI"  OF oSection3 ALIAS "TWA"
			DEFINE CELL NAME "TWA_NUMSER"  OF oSection3 ALIAS "TWA"
			DEFINE CELL NAME "TWA_CUSTO"   OF oSection3 ALIAS "TWA"   SIZE nTamMaxNum
			DEFINE CELL NAME "TWA_VLRCOB"  OF oSection3 ALIAS "TWA"   SIZE nTamMaxNum
			DEFINE CELL NAME "C6_VALOR"    OF oSection3 TITLE STR0010 SIZE nTamMaxNum BLOCK {|| Tcr060SC6() } //"Vlr.Faturamento"
			DEFINE CELL NAME "TWA_PRODUT"  OF oSection3 ALIAS "TWA"
			DEFINE CELL NAME "B1_DESC"     OF oSection3 BLOCK {|| Posicione("SB1", 1, xFilial("SB1")+oSection3:Cell("TWA_PRODUT"):GetValue(.T.), "B1_DESC")}
			DEFINE CELL NAME "TWA_TES"     OF oSection3 ALIAS "TWA"

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao4 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		DEFINE SECTION oSection4 OF oSection1 TITLE STR0006 TABLE "TWA","SC6" //"Movimento/Equipamento"
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define as celulas que irao aparecer na secao4  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DEFINE CELL NAME "TWA_CODTEW"  OF oSection4 ALIAS "TWA"
			DEFINE CELL NAME "TWA_NUMSER"  OF oSection4 ALIAS "TWA"
			DEFINE CELL NAME "TWA_CUSTO"   OF oSection4 ALIAS "TWA"   SIZE nTamMaxNum
			DEFINE CELL NAME "TWA_VLRCOB"  OF oSection4 ALIAS "TWA"   SIZE nTamMaxNum
			DEFINE CELL NAME "C6_VALOR"    OF oSection4 TITLE STR0010 SIZE nTamMaxNum BLOCK {|| Tcr060SC6() } //"Vlr.Faturamento"
			DEFINE CELL NAME "TWA_PRODUT"  OF oSection4 ALIAS "TWA"
			DEFINE CELL NAME "B1_DESC"     OF oSection4 BLOCK {|| Posicione("SB1", 1, xFilial("SB1")+oSection4:Cell("TWA_PRODUT"):GetValue(.T.), "B1_DESC")}
			DEFINE CELL NAME "TWA_TES"     OF oSection4 ALIAS "TWA"

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ totalizador das seçoes ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DEFINE FUNCTION oCobSec2 FROM oSection2:Cell("TWA_VLRCOB") FUNCTION SUM TITLE STR0007 PICTURE cPictTotal NO END REPORT //"Cobrança"
		DEFINE FUNCTION oFatSec2 FROM oSection2:Cell("C6_VALOR")   FUNCTION SUM TITLE STR0008 PICTURE cPictTotal NO END REPORT //"Faturamento"
		DEFINE FUNCTION FROM oSection2:Cell("TWA_VLRCOB") FUNCTION ONPRINT FORMULA {|| Tcr060Sub( oCobSec2:GetLastValue(), oFatSec2:GetLastValue() ) } TITLE STR0009 PICTURE cPictTotal NO END REPORT //"Diferença"

		DEFINE FUNCTION oCobSec3 FROM oSection3:Cell("TWA_VLRCOB") FUNCTION SUM TITLE STR0007 PICTURE cPictTotal NO END REPORT //"Cobrança"
		DEFINE FUNCTION oFatSec3 FROM oSection3:Cell("C6_VALOR")   FUNCTION SUM TITLE STR0008 PICTURE cPictTotal NO END REPORT //"Faturamento"
		DEFINE FUNCTION FROM oSection3:Cell("TWA_VLRCOB") FUNCTION ONPRINT FORMULA {|| Tcr060Sub( oCobSec3:GetLastValue(), oFatSec3:GetLastValue() ) } TITLE STR0009 PICTURE cPictTotal NO END REPORT //"Diferença"

		DEFINE FUNCTION oCobSec4 FROM oSection4:Cell("TWA_VLRCOB") FUNCTION SUM TITLE STR0007 PICTURE cPictTotal NO END REPORT //"Cobrança"
		DEFINE FUNCTION oFatSec4 FROM oSection4:Cell("C6_VALOR")   FUNCTION SUM TITLE STR0008 PICTURE cPictTotal NO END REPORT //"Faturamento"
		DEFINE FUNCTION FROM oSection4:Cell("TWA_VLRCOB") FUNCTION ONPRINT FORMULA {|| Tcr060Sub( oCobSec4:GetLastValue(), oFatSec4:GetLastValue() ) } TITLE STR0009 PICTURE cPictTotal NO END REPORT //"Diferença"

Return oReport

//------------------------------------------------------------------------------
/*/{Protheus.doc} Tcr060PrtRpt
@description	Realiza a pesquisa dos dados para o relatorio.
@sample	 	Tcr060PrtRpt() 
@param		Nenhum
@return		Nil
@author		Kaique Schiller
@since		14/04/2016
@version	P12   
/*/
//------------------------------------------------------------------------------
Static Function Tcr060PrtRpt( oReport )
Local oSection1	:= oReport:Section(1)			// Define a secao 1 do relatorio
Local oSection2	:= oSection1:Section(1)			// Define que a secao 2 serah filha da secao 1
Local oSection3	:= oSection1:Section(2) 			// Define que a secao 3 serah filha da secao 1
Local oSection4	:= oSection1:Section(3)			// Define que a secao 4 serah filha da secao 1
Local cAlias1		:= GetNextAlias()					// Pega o proximo Alias Disponivel
Local cAlias2		:= GetNextAlias()					// Pega o proximo Alias Disponivel
Local cAlias3		:= GetNextAlias()					// Pega o proximo Alias Disponivel
Local cAlias4		:= GetNextAlias()					// Pega o proximo Alias Disponivel
Local cWhere		:= ""								// Condição dos parâmetros.
Local cJoin		:= ""

If MV_PAR03 == 2//Abertas
	cWhere += "AND TW9.TW9_STATUS = 1 "
Elseif MV_PAR03 == 3//Faturadas
	cWhere += "AND TW9.TW9_STATUS = 2 "
Elseif MV_PAR03 == 4//Encerradas
	cWhere += "AND TW9.TW9_STATUS = 3 "
Endif

If ! Empty(MV_PAR01) //Codigo Indenização De?
	cWhere += "AND TW9.TW9_CODIGO >= '" + MV_PAR01 + "' "
Endif

If ! Empty(MV_PAR02) //Codigo Indenização Até?
	cWhere += "AND TW9.TW9_CODIGO <= '" + MV_PAR02 + "' "
Endif

If ! Empty(MV_PAR04)
	cWhere += "AND TW9.TW9_CONTRT >= '" + MV_PAR04 + "' "
Endif

If ! Empty(MV_PAR05)
	cWhere += "AND TW9.TW9_CONTRT <= '" + MV_PAR05 + "' "
Endif
If ! Empty(MV_PAR06) //Natureza
	cWhere += "AND TW9.TW9_NATCOB = '" + MV_PAR06 + "' "
Endif

If ! Empty(MV_PAR07) //Cliente
	cWhere += "AND TW9.TW9_CLIENT = '" + MV_PAR07 + "' "
Endif

If ! Empty(MV_PAR08) //Loja
	cWhere += "AND TW9.TW9_CLILOJ = '" + MV_PAR08 + "' "
Endif

If ! Empty(MV_PAR09) //Pedido
	cWhere += "AND TW9.TW9_NUMPED = '" + MV_PAR09 + "' "
Endif

If ! Empty(MV_PAR10) //Dt Emissão Pedido
	cWhere += "AND SC5.C5_EMISSAO = '" + DTOS(MV_PAR10) + "' "
Endif

If ! Empty(MV_PAR11) //Da Dt de finalização
	cWhere += "AND TW9.TW9_DTFINA >= '" + DTOS(MV_PAR11) + "' "
Endif

If ! Empty(MV_PAR12) //Da Dt de finalização
	cWhere += "AND TW9.TW9_DTFINA <= '" + DTOS(MV_PAR12) + "' "
Endif

If ! Empty(MV_PAR09) .OR. ! Empty(MV_PAR10) //Pedido # Dt Emissão Pedido
	cJoin := "INNER JOIN " + RetSQLName("SC5") + " SC5 "
	cJoin += "ON SC5.C5_FILIAL  = '" + xFilial("SC5") + "' "
	cJoin += "AND SC5.C5_NUM = TW9.TW9_NUMPED "
	cJoin += "AND SC5.D_E_L_E_T_ = ' ' "
Endif

cWhere	:= '%' + cWhere + '%'
cJoin	:= '%' + cJoin + '%'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa a secao 1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSection1
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BeginSql alias cAlias1
		SELECT TW9.TW9_FILIAL, TW9.TW9_CODIGO, TW9.TW9_STATUS, TW9.TW9_CONTRT, TW9.TW9_NATCOB, TW9.TW9_CLIENT, TW9.TW9_CLILOJ, TW9.TW9_NUMPED, TW9.TW9_AGPPED
		  FROM %Table:TW9% TW9 
		       %Exp:cJoin%
 		  WHERE TW9.TW9_FILIAL BETWEEN %Exp:MV_PAR13% AND %Exp:MV_PAR14%
		    AND TW9.%NotDel%
		    %Exp:cWhere%
		 ORDER BY TW9.TW9_FILIAL, TW9.TW9_CODIGO
	EndSql
END REPORT QUERY oSection1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa a secao 2³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSection2
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao 2³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	BeginSql alias cAlias2
		SELECT TWA.TWA_CODIGO, TWA.TWA_CODAB6, TWA.TWA_CODAB7, TWA.TWA_CUSTO, TWA.TWA_VLRCOB, TWA.TWA_PRODUT, TWA.TWA_TES, TWA.TWA_ITEMPD
		  FROM %table:TWA% TWA
		 WHERE	TWA.TWA_FILIAL = %report_param: (cAlias1)->TW9_FILIAL%
		   AND TWA.TWA_CODTW9 = %report_param: (cAlias1)->TW9_CODIGO%
		   AND TWA.TWA_TPOS   = '1'
		   AND TWA.%NotDel%
		 ORDER BY TWA.TWA_CODIGO
	EndSql
END REPORT QUERY oSection2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa a secao 3³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSection3
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao 3³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	BeginSql alias cAlias3
		SELECT TWA.TWA_CODIGO, TWA.TWA_CODSTJ, TWA.TWA_CODTFI, TWA.TWA_CUSTO, TWA.TWA_VLRCOB, TWA.TWA_PRODUT, TWA.TWA_TES, TWA.TWA_ITEMPD
		  FROM %table:TWA% TWA
		 WHERE	TWA.TWA_FILIAL = %report_param: (cAlias1)->TW9_FILIAL%
		   AND TWA.TWA_CODTW9 = %report_param: (cAlias1)->TW9_CODIGO%
		   AND TWA.TWA_TPOS   = '2'
		   AND TWA.%NotDel%
		 ORDER BY TWA.TWA_CODIGO
	EndSql
END REPORT QUERY oSection3

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa a secao 4³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSection4
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao 4³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	BeginSql alias cAlias4
		SELECT TWA.TWA_CODIGO, TWA.TWA_CODTEW, TWA.TWA_NUMSER, TWA.TWA_CUSTO, TWA.TWA_VLRCOB, TWA.TWA_PRODUT, TWA.TWA_TES, TWA.TWA_ITEMPD
		  FROM %table:TWA% TWA
		 WHERE	TWA.TWA_FILIAL = %report_param: (cAlias1)->TW9_FILIAL%
		   AND TWA.TWA_CODTW9 = %report_param: (cAlias1)->TW9_CODIGO%
		   AND TWA.TWA_TPOS   = ' '
		   AND TWA.%NotDel%
		ORDER BY TWA.TWA_CODIGO
	EndSql
END REPORT QUERY oSection4

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona nas tabelas usadas na secao1 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oSection1,"TW9",1,{|| xFilial("TW9")+(cAlias1)->TW9_CODIGO})
TRPosition():New(oSection1,"SC5",1,{|| xFilial("SC5")+(cAlias1)->TW9_NUMPED})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona nas tabelas usadas na secao2 	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oSection2,"TWA",1,{|| xFilial("TWA")+(cAlias2)->TWA_CODIGO})
TRPosition():New(oSection2,"SB1",1,{|| xFilial("SB1")+(cAlias2)->TWA_PRODUT})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona nas tabelas usadas na secao3 	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oSection3,"TWA",1,{|| xFilial("TWA")+(cAlias3)->TWA_CODIGO})
TRPosition():New(oSection3,"SB1",1,{|| xFilial("SB1")+(cAlias3)->TWA_PRODUT})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona nas tabelas usadas na secao4 	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oSection4,"TWA",1,{|| xFilial("TWA")+(cAlias4)->TWA_CODIGO})
TRPosition():New(oSection4,"SB1",1,{|| xFilial("SB1")+(cAlias4)->TWA_PRODUT})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Exibe os títulos das seçoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:lHeaderVisible := .T.
oSection2:lHeaderVisible := .T.
oSection3:lHeaderVisible := .T.
oSection4:lHeaderVisible := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com a query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:Print()

Return

//------------------------------------------------------------------------------
/*/{Protheus.doc} Tcr060SC6
@description	Realiza a pesquisa dos dados na SC6.
@sample	 	Tcr060SC6() 
@param		Nenhum
@return		cRet
@author		Kaique Schiller
@since		14/04/2016
@version	P12   
/*/
//------------------------------------------------------------------------------
Static Function Tcr060SC6()
Local nRet := 0

If TW9->TW9_AGPPED == "2" .AND. TW9->TW9_STATUS == "2" //Não Agrupa e Faturada.
	nRet := Posicione( "SC6", 1, xFilial("SC6")+TW9->TW9_NUMPED+TWA->TWA_ITEMPD, "C6_VALOR" )
Elseif TW9->TW9_AGPPED == "1" .AND. TW9->TW9_STATUS == "2" //Agrupa e Faturada.
	nRet := TWA->TWA_VLRCOB
Endif

Return nRet

//------------------------------------------------------------------------------
/*/{Protheus.doc} Tcr060Sub
@description	Retorna a subtração dos totais.
@sample	 	Tcr060Sub() 
@param		Nenhum
@return		cRet
@author		Kaique Schiller
@since		14/04/2016
@version	P12   
/*/
//------------------------------------------------------------------------------
Static Function Tcr060Sub(nCob, nFat)
Local nRet := 0

Default nCob := 0
Default nFat := 0

nRet := nFat - nCob

Return nRet