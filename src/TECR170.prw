/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.CH"
#Include "REPORT.CH"
#Include "TECR170.CH"

//------------------------------------------------------------------------------
/*/{Protheus.doc} TECR170
@description	Consulta coleta e entrega do equipamento
@sample	 	U_TECR170() 
@param		Nenhum
@return		Nil
@author		Kaique Schiller
@since		14/04/2016
@version	P12   
/*/
//------------------------------------------------------------------------------
User Function TECR170()

Local oReport	//Objeto relatorio TReport
Local cPerg := "TECR170"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ PARAMETROS                                                             ³
//³ MV_PAR01 : Contrato de?                                                ³
//³ MV_PAR02 : Contrato até?                                               ³
//³ MV_PAR03 : Local de atend. de?                                         ³
//³ MV_PAR04 : Local de atend. até?                                        ³
//³ MV_PAR05 : Tipo entidade?                                              ³
//³ MV_PAR06 : Cliente de?                                                 ³
//³ MV_PAR07 : Loja de?                                                    ³
//³ MV_PAR08 : Cliente até?                                                ³
//³ MV_PAR09 : Loja até?                                                   ³
//³ MV_PAR010: Produto de?                                                 ³
//³ MV_PAR011: Produto até?                                         	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.F.)

oReport := Rt170RDef(cPerg)
oReport:PrintDialog()

Return(.T.)

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rt170RDef()

Consulta coleta e entrega do equipamento - monta as Section's para impressão do relatorio

@sample 	Rt590RDef(cPerg)
@param cPerg 
@return oReport

@version	P12
/*/
//--------------------------------------------------------------------------------------------------------------------
Static Function Rt170RDef(cPerg)

Local aArea := GetArea()//Guarda a area atual
Local oReport			// Objeto do relatorio
Local oSection1			// Objeto da secao 1
Local oSection2			// Objeto da secao 2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a criacao do objeto oReport  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "TECR170" TITLE STR0001 PARAMETER "TECR170" ACTION {|oReport| Tcr170PrtR(oReport)} DESCRIPTION STR0002 //"Coleta e entrega do equipamento" ## "Consulta as informações dos equipamentos que foram entregues e o período de início da sua locação"
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao1 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection1 OF oReport TITLE STR0003 TABLES "TFJ","TFL","TFI","ABS","SU5","TEW","SA1" //"Contrato"
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao1  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DEFINE CELL NAME "TFL_CONTRT" 	OF oSection1 ALIAS "TFI" 
		DEFINE CELL NAME "ABS_DESCRI"	OF oSection1 TITLE STR0005 ALIAS "ABS"
		DEFINE CELL NAME "TFJ_TPFRET" 	OF oSection1 TITLE STR0006 ALIAS "TFJ"
		DEFINE CELL NAME "A1_NOME" 		OF oSection1 TITLE STR0007 ALIAS "SA1"
		DEFINE CELL NAME "ABS_CONTAT"   OF oSection1 ALIAS "ABS" 
		DEFINE CELL NAME "U5_DDD" 		OF oSection1 ALIAS "SU5"
		DEFINE CELL NAME "U5_FONE" 		OF oSection1 TITLE STR0008 ALIAS "SU5"
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao2 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		DEFINE SECTION oSection2 OF oSection1 TITLE STR0004 TABLE "TFI","TEW","SB1" LEFT MARGIN 5 //"Locação"
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define as celulas que irao aparecer na secao2  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DEFINE CELL NAME "TFI_ENTEQP" 	OF oSection2 ALIAS "TFI"
			DEFINE CELL NAME "TFI_COLEQP" 	OF oSection2 ALIAS "TFI"
			DEFINE CELL NAME "TFI_PERINI" 	OF oSection2 ALIAS "TFI"
			DEFINE CELL NAME "TFI_PERFIM" 	OF oSection2 ALIAS "TFI"
			DEFINE CELL NAME "TEW_NFSAI"	OF oSection2 TITLE STR0009 ALIAS "TEW"	
			DEFINE CELL NAME "B1_DESC" 		OF oSection2 TITLE STR0010 ALIAS "SB1"
			DEFINE CELL NAME "TEW_BAATD" 	OF oSection2 ALIAS "TEW"
			DEFINE CELL NAME "TEW_CODMV" 	OF oSection2 ALIAS "TEW"
			DEFINE CELL NAME "TEW_NUMPED" 	OF oSection2 ALIAS "TEW"
			DEFINE CELL NAME "TEW_ITEMPV" 	OF oSection2 ALIAS "TEW"
			
RestArea( aArea )
		
Return oReport

//------------------------------------------------------------------------------
/*/{Protheus.doc} Tcr170PrtR
@description	Realiza a pesquisa dos dados para o relatorio.
@sample	 	Tcr170PrtR() 
@param		Nenhum
@return		Nil
@author		Kaique Schiller
@since		14/04/2016
@version	P12   
/*/
//------------------------------------------------------------------------------
Static Function Tcr170PrtR( oReport )
Local oSection1 := oReport:Section(1)				// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)				// Define que a secao 2 sera filha da secao 1
Local cAlias	:= GetNextAlias()					// Pega o proximo Alias Disponivel


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa a secao 1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSection1
	BEGIN REPORT QUERY oSection2

		BeginSql alias cAlias

			SELECT TFL.TFL_CONTRT, ABS.ABS_DESCRI, TFJ.TFJ_TPFRET, SA1.A1_NOME,    ABS.ABS_CONTAT, SU5.U5_DDD,     SU5.U5_FONE,
			       SU5.U5_EMAIL,   TFL.TFL_CODIGO, TFI.TFI_ENTEQP, TFI.TFI_COLEQP, TFI.TFI_PERINI, TFI.TFI_PERFIM, TEW.TEW_PRODUT,
			       SB1.B1_DESC,    TEW.TEW_BAATD,  TEW.TEW_NFSAI,  TEW.TEW_CODMV,  TEW.TEW_NUMPED, TEW.TEW_ITEMPV
			  FROM %Table:TFL% TFL
			       INNER JOIN %Table:TFJ% TFJ ON TFJ.TFJ_FILIAL = %xFilial:TFJ%
			                                 AND TFJ.%NotDel%
			                                 AND TFJ.TFJ_CODIGO = TFL.TFL_CODPAI
			       INNER JOIN %Table:TFI% TFI ON TFI.TFI_FILIAL = %xFilial:TFI%
			                                 AND TFI.%NotDel%
			                                 AND TFI.TFI_CODPAI = TFL.TFL_CODIGO
			       INNER JOIN %Table:ABS% ABS ON ABS.ABS_FILIAL = %xFilial:ABS%
			                                 AND ABS.%NotDel%
			                                 AND ABS.ABS_LOCAL = TFL.TFL_LOCAL
			       INNER JOIN %Table:TEW% TEW ON TEW.TEW_FILIAL = %xFilial:TEW%
			                                 AND TEW.%NotDel%
			                                 AND TEW.TEW_CODEQU = TFI.TFI_COD
			       LEFT JOIN  %Table:SU5% SU5 ON SU5.U5_FILIAL = %xFilial:SU5%
			                                 AND SU5.%NotDel%
			                                 AND SU5.U5_CODCONT = ABS.ABS_CONTAT 
			       INNER JOIN %Table:SA1% SA1 ON SA1.A1_FILIAL = %xFilial:SA1%
			                                 AND SA1.%NotDel%
			                                 AND ABS.ABS_CODIGO = SA1.A1_COD
			                                 AND SA1.A1_LOJA = ABS.ABS_LOJA
			       INNER JOIN %Table:SB1% SB1 ON SB1.B1_FILIAL = %xFilial:SB1%
			                                 AND SB1.%NotDel%
			                                 AND SB1.B1_COD = TFI.TFI_PRODUT
			 WHERE TFL.TFL_FILIAL = %xFilial:TFL% 
			   AND TFL.TFL_CONTRT >= %Exp:MV_PAR01%
			   AND TFL.TFL_CONTRT <= %Exp:MV_PAR02%
			   AND TFL.TFL_LOCAL  >= %Exp:MV_PAR03%
			   AND TFL.TFL_LOCAL  <= %Exp:MV_PAR04%
			   AND ABS.ABS_CODIGO >= %Exp:MV_PAR06%
			   AND ABS.ABS_CODIGO <= %Exp:MV_PAR08%
			   AND ABS.ABS_LOJA   >= %Exp:MV_PAR07%
			   AND ABS.ABS_LOJA   <= %Exp:MV_PAR09%
			   AND TEW.TEW_PRODUT >= %Exp:MV_PAR10%
			   AND TEW.TEW_PRODUT <= %Exp:MV_PAR11%
			   AND TFL.TFL_CODSUB = ' '
			   AND TFL.%NotDel%
			   AND EXISTS(SELECT 1
			                FROM %Table:TFI% TFI
			               WHERE TFI.TFI_FILIAL = %xFilial:TFI%
			                 AND TFI.%NotDel%
			                 AND TFI.TFI_CODPAI = TFL.TFL_CODIGO)
			 ORDER BY TFL.TFL_CONTRT, TEW.TEW_CODMV
		EndSql

	END REPORT QUERY oSection1
END REPORT QUERY oSection2

dbSelectArea(cAlias)

If !oReport:Cancel() .And. !(cAlias)->(EOF())
	
	While !oReport:Cancel() .And. !(cAlias)->(Eof())
		oSection1:Init()
		oSection1:PrintLine()
		cChave	:= (cAlias)->TFL_CONTRT 
		While !oReport:Cancel() .And. !(cAlias)->(Eof()) .AND. cChave == (cAlias)->TFL_CONTRT 
			oSection2:Init()
			oSection2:PrintLine()
			(cAlias)->(dbSkip())
		EndDo
		oSection2:Finish()
		oSection1:Finish()
	EndDo
	
EndIf

(cAlias)->(dbCloseArea())

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} At170F3Ent()
Função que pertence a consulta especifica SA1SUS.

@author Kaique Schiller
@since 25/04/2016
@return lRet
/*/
//-------------------------------------------------------------------
User Function Rt170F3Ent(lPerg)
Local lRet		:= .T.
Local aArea		:= GetArea()
Local cEnt		:= ""
Default lPerg 	:= .F.

SaveInter()

If lPerg
	cEnt := MV_PAR05
	Do Case
		Case cEnt == 1
			lRet := Conpad1( NIL,NIL,NIL,"SA1")

		Case cEnt == 2
			lRet := ConPad1(Nil,Nil,Nil,"SUS")

	EndCase
Endif

RestInter()
 
RestArea(aArea)

Return (lRet)

//-------------------------------------------------------------------
/*/{Protheus.doc} At170RtEnt()
Função que retorna conteudo da consulta especifica SA1SUS.

@author Kaique Schiller
@since 25/04/2016
@return cCodigo
/*/
//-------------------------------------------------------------------
User Function Rt170RtEnt(lPerg)
Local cCodigo	:= ""
Local cEnt 		:= ""
Default lPerg 	:= .F.

If lPerg
	cEnt := MV_PAR05
	Do Case
		Case cEnt == 1
			cCodigo := SA1->A1_COD
			
		Case cEnt == 2
			cCodigo := SUS->US_COD
			
	EndCase
Endif

Return(cCodigo)