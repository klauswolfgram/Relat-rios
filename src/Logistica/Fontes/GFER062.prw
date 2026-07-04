/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GFEA061F.ch"
/*/{Protheus.doc}GFER062
Relatório de Tarifas das Tabelas de Frete 
@Author Alexandre José Cuchi
@Since 15/10/2014
@Version 1.0
/*/ 
User Function GFER062()
	Local   oReport 
	 
	If TRepInUse() 
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
Return

Static Function ReportDef()
	Local oReport
	Local aOrdem := {}
	Local oSection 
	Local oSctnHide
	Private cAli   := ""
	/* CRIAÇÃO DO COMPONENTE DE IMPRESSÃO
	TReport():New                                                           
	ExpC1 : Nome do relatorio                                               
	ExpC2 : Titulo                                                          
	ExpC3 : Pergunte                                                        
	ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  
	ExpC5 : Descricao 
	*/
	
	oReport := TReport():New("GFER062","Listagem de Tarifas de Frete","GFER062",{|oReport|Iif(GFR63VLPER("GFER062",.F.),ReportPrint(oReport),oReport:CancelPrint())})
	oReport:SetLandscape()
	oReport:HideParamPage()
	oReport:SetTotalInLine(.F.)
	
	oSctnHide := TrSection():New(oReport,"",{"GV9"} ,{'-'})
	
	oSctnHide:Hide()
	oSctnHide:Disable()
	oSctnHide:lReadOnly := .T.
	oSctnHide:lUserVisible := .F.
	
	oSection := TrSection():New(oReport,"Relatório de Tarifas das Tabelas de Frete",{cAli} ,aOrdem)
	oSection:SetTotalInLine(.F.)
	oSection:SetHeaderSection(.T.)
	
	TrCell():New(oSection, "(cAli)->TRANSP"    ,"(cAli)","Transportador"         )      // Transportador
	TrCell():New(oSection, "TABELA"            ,"(cAli)","Tabela "               ,,,,;
	{||AllTrim( (cAli)->NRTAB)+"- " + AllTrim( (cAli)->DSTAB)})                                   // Tabela de frete 
	TrCell():New(oSection, "TPOPER"            ,"(cAli)","Tipo Operação "        ,,,,;
	{||AllTrim( (cAli)->CDOPER ) +"- "+ AllTrim( (cAli)->DSOPER )})      // Tipo de operação
	
	TrCell():New(oSection, "CLASSFRET"         ,"(cAli)","Classificação de Frete",,,,;
	{|| AllTrim( (cAli)->CDCLART )+"- "+ AllTrim( (cAli)->DSCLAFRT )})      // Classificação de Frete
	TrCell():New(oSection, "(cAli)->NEGOCIACAO","(cAli)","Negociação"            )      // Numero da negociação
	TrCell():New(oSection, "(cAli)->SEQFX"     ,"(cAli)","Seq.  Faixa"           )      // Sequencia de faixa               
	
	TrCell():New(oSection, "SEQFX"             ,""      ,"Info Faixa"            ,,,,;
	{||GFEASEQFX((cAli)->TRANSP,(cAli)->NRTAB,(cAli)->NEGOCIACAO,(cAli)->SEQFX,.T.)})  // Info de faixa                
	TrCell():New(oSection, "(cAli)->NRROTA"    ,"(cAli)","Nr Rota"               )      // Numero de rota                   
	TrCell():New(oSection, "NRROTA"            ,""      ,"Info Rota"             ,,,,;
	{||U_GFEA62ROTA((cAli)->TRANSP,(cAli)->NRTAB,(cAli)->NEGOCIACAO,(cAli)->SEQFX,(cAli)-> NRROTA,.T.)})      // Info de Rota   
	TrCell():New(oSection, "(cAli)->IDAVLT"    ,"(cAli)","Ida\Volta"             ,,,,;
	{||Iif((cAli)->IDAVLT == '1','Sim','Não')}) // Relatório é Ida e volta

	TrCell():New(oSection, "(cAli)->COMPONE"   ,"(cAli)","Componente"            ,,,,;
	{||AllTrim( (cAli)->CDCOMP ) +"- "+ AllTrim( (cAli)-> DSCOMP ) })      // Componente de frete
	TrCell():New(oSection, "(cAli)->CATEGORIA" ,"(cAli)","Categoria"             )      // Categoria de frete
	TrCell():New(oSection, "(cAli)->CALCSOBRE" ,"(cAli)","Calcula sobre"         )      // Calculo sobre ?
	
	TrCell():New(oSection, "(cAli)->VLFXNORM"  ,"(cAli)","Vl. Fixo Normal"       )      // Valor Fixo Normal
	TrCell():New(oSection, "(cAli)->VLFXUNIT"  ,"(cAli)","Vl. Unit. Normal"      )      // Valor Fixo Unitario
	TrCell():New(oSection, "(cAli)->PERCNORM"  ,"(cAli)","% Normal"              )      // Percentual Normal
	
	TrCell():New(oSection, "(cAli)->VLFXCOR"   ,"(cAli)","Valor Fixo Corrigido"  )      // Valor Fixo corrigido 
	TrCell():New(oSection, "(cAli)->VLUNCOR"   ,"(cAli)","Valor Unit. Corrigido" )      // Valor unitario corrigido
Return oReport
/*/{Protheus.doc}ReportPrint
Consulta retorna todas as tarifas cadastradas para a tabela e negociação de frete vigente na data especificada em cVigencia
@Author Alexandre José Cuchi
@Since 15/10/2014
@Version 1.0
/*/
Static Function ReportPrint(oReport)
	Local lFilExc    := FWModeAccess("GV9",1) == "E"
	Local oSection1  := oReport:Section(2)
	Local oFilUser   := Nil
	Local cQuery     := ""
	Local cVigencia  := DToS(MV_PAR01)
	Local cTransport := MV_PAR02
	Local cTabela    := MV_PAR03
	Local cComp      := MV_PAR04
	Local cLstFil    := ""

	// Converte o retorno do AdvPL (nn,nn) para formato de banco (nn.nn) 
	Local cMulti     := StrTran(cValToChar(IIF(Empty(MV_PAR05),1,MV_PAR05)),',','.') 
	If lFilExc
		oFilUser:= GFEFilialPermissaoUsuario():New()
		oFilUser:MontaFilUsr()
		cLstFil := oFilUser:getFilSQLIn()
		oFilUser:Destroy(oFilUser)
	EndIf
	cQuery += "     SELECT DISTINCT GV9.GV9_FILIAL  FILIAL,                                              "
	cQuery += "                     GV8.GV8_DUPSEN  IDAVLT,                                              "
	cQuery += "                     GV9_CDEMIT      TRANSP,	                                             "
	cQuery += "              	    GV9.GV9_NRTAB   NRTAB,                                               " 
	cQuery += "                     GVA_DSTAB       DSTAB,                                               "
	cQuery += "                     GV9.GV9_CDTPOP  CDOPER,                                              " 
	cQUery += "                     GV4_DSTPOP      DSOPER ,                                             "
	cQuery += "                     GV9.GV9_CDCLFR  CDCLART,                                             "
	cQUery += "                     GUB_DSCLFR      DSCLAFRT,                                            "
	cQuery += "                     GV9.GV9_NRNEG   NEGOCIACAO,                                          "
	cQuery += "                     GV7.GV7_CDFXTV  SEQFX,                                               "
	cQuery += "                     GV8.GV8_NRROTA  NRROTA,                                              "
	cQuery += "                     GV1.GV1_CDCOMP  CDCOMP,                                              "
	cQuery += "                     GV2.GV2_DSCOMP  DSCOMP,                                              "
	cQuery += "                     (CASE                                                                "
	cQuery += "                       WHEN GV2_CATVAL = '1' THEN 'Frete Unidade'                         "
	cQuery += "                       WHEN GV2_CATVAL = '2' THEN 'Frete Valor'                           "
	cQuery += "                       WHEN GV2_CATVAL = '3' THEN 'Taxas'                                 "
	cQuery += "                       WHEN GV2_CATVAL = '4' THEN 'Pedagio' END) CATEGORIA,               "
	cQuery += "                     (CASE                                                                "
	cQuery += "                       WHEN GV2.GV2_ATRCAL  = '1' THEN 'Peso da Carga'                    "
	cQuery += "                       WHEN GV2.GV2_ATRCAL  = '2' THEN 'Valor da Carga'                   "
	cQuery += "                       WHEN GV2.GV2_ATRCAL  = '3' THEN 'Quantidade de Itens'              "
	cQuery += "                       WHEN GV2.GV2_ATRCAL  = '4' THEN 'Volume da Carga'                  "
	cQuery += "                       WHEN GV2.GV2_ATRCAL  = '5' THEN 'Quantidade de Volumes'            "
	cQuery += "                       WHEN GV2.GV2_ATRCAL  = '6' THEN 'Distância'                        "
	cQuery += "                       WHEN GV2.GV2_ATRCAL  = '7' THEN 'Quantidade de Entregas'           "
	cQuery += "                       WHEN GV2.GV2_ATRCAL  = '8' THEN 'Valor Fixo'                       "
	cQuery += "                       WHEN GV2.GV2_ATRCAL  = '9' THEN 'Valor do Frete'                   "
	cQuery += "                       WHEN GV2.GV2_ATRCAL  = '10' THEN 'Quantidade ou Peso Alternativo'  "
	cQuery += "                       WHEN GV2.GV2_ATRCAL  = '11' THEN 'Qtde Serviço'                    "
	cQuery += "                       END) CALCSOBRE,                                                    "
	cQuery += "                       GV1_VLFIXN VLFXNORM,	                                             "
	cQuery += "                       GV1_VLUNIN VLFXUNIT,                                               "
	cQuery += "                       GV1_PCNORM PERCNORM,                                               "
	cQuery += "                       (GV1_VLFIXN * "+cMulti+") VLFXCOR,                                 "
	cQuery += "                       (GV1_VLUNIN * "+cMulti+") VLUNCOR                                  "
	cQuery += "                FROM "+RetSQLName("GV9")+" GV9                                            "
	cQuery += "              INNER JOIN "+RetSQLName("GV8")+" GV8                                     "
	cQuery += "                      ON GV8.GV8_FILIAL = GV9.GV9_FILIAL                                  "
	cQuery += "                     AND GV8.GV8_CDEMIT = GV9.GV9_CDEMIT                                  "
	cQuery += "                     AND GV8.GV8_NRTAB  = GV9.GV9_NRTAB                                   "
	cQuery += "                     AND GV8.GV8_NRNEG  = GV9.GV9_NRNEG                                   "
	cQuery += "                     AND GV8.D_E_L_E_T_ = ''                                              "
	cQuery += "                INNER JOIN "+RetSQLName("GV7")+" GV7                                   "
	cQuery += "                        ON GV7.GV7_FILIAL = GV9.GV9_FILIAL                                "
	cQuery += "                       AND GV7.GV7_CDEMIT = GV9.GV9_CDEMIT                                "
	cQuery += "                       AND GV7.GV7_NRTAB  = GV9.GV9_NRTAB                                 "
	cQuery += "                       AND GV7.GV7_NRNEG  = GV9.GV9_NRNEG                                 "
	cQuery += "                       AND GV7.D_E_L_E_T_ = ''                                            "
	cQuery += "                INNER JOIN "+RetSQLName("GV6")+" GV6                                   "
	cQuery += "                        ON GV6.GV6_FILIAL = GV7.GV7_FILIAL                                "
	cQuery += "                       AND GV6.GV6_CDEMIT = GV7.GV7_CDEMIT                                "
	cQuery += "                       AND GV6.GV6_NRTAB  = GV7.GV7_NRTAB                                 "
	cQuery += "                       AND GV6.GV6_NRNEG  = GV7.GV7_NRNEG                                 "
	cQuery += "                       AND GV6.GV6_CDFXTV = GV7.GV7_CDFXTV                                " 
	cQuery += "                       AND GV6.GV6_NRROTA = GV8.GV8_NRROTA                                "
	cQuery += "                       AND GV6.D_E_L_E_T_ = ''                                            "
	cQuery += "               INNER JOIN "+RetSQLName("GV1")+" GV1                                    "
	cQuery += "                     ON GV1.GV1_FILIAL = GV6.GV6_FILIAL                                   "
	cQuery += "                    AND GV1.GV1_CDEMIT = GV6.GV6_CDEMIT                                   "
	cQuery += "                    AND GV1.GV1_NRTAB  = GV6.GV6_NRTAB                                    "
	cQuery += "                    AND GV1.GV1_NRNEG  = GV6.GV6_NRNEG                                    "
	cQuery += "                    AND GV1.GV1_CDFXTV = GV6.GV6_CDFXTV                                   "
	cQuery += "                    AND GV1.GV1_NRROTA = GV6.GV6_NRROTA                                   "
	cQuery += "                    AND GV1.D_E_L_E_T_ = ''                                            "
	If !Empty(cComp)
		cQuery += "                AND GV1.GV1_CDCOMP = '"+cComp+"'                                      "
	EndIf                   
	cQuery += "              INNER JOIN "+RetSQLName("GV2")+" GV2                                     "
	cQuery += "                   ON GV2.GV2_FILIAL = GV1.GV1_FILIAL
	cQuery += "                  AND GV2.GV2_CDCOMP = GV1.GV1_CDCOMP                                     "
	cQuery += "                  AND GV2.D_E_L_E_T_ = ''                                                 "
	cQuery += "              INNER JOIN "+RetSQLName("GVA")+" GVA                                     "
	cQuery += "                    ON GVA.GVA_FILIAL = GV9.GV9_FILIAL                                    "
	cQuery += "                   AND GVA.GVA_CDEMIT = GV9.GV9_CDEMIT                                    "
	cQuery += "                   AND GVA.GVA_NRTAB  = GV9.GV9_NRTAB                                     "
	cQuery += "                   AND GVA.D_E_L_E_T_ = ''                                                "

	cQuery += "               LEFT JOIN "+RetSQLName("GV4")+" GV4                                     "
	cQuery += "                     ON GV4.GV4_FILIAL = GV9.GV9_FILIAL                                   "
	cQuery += "                    AND GV4.GV4_CDTPOP = GV9_CDTPOP                                       "
	cQuery += "                    AND GV4.D_E_L_E_T_ = ''                                               "               
	cQuery += "               LEFT JOIN "+RetSQLName("GUB")+" GUB                                     "               
	cQuery += "                     ON GUB.GUB_FILIAL = GV9.GV9_FILIAL
	cQUery += "                    AND GUB.GUB_CDCLFR = GV9.GV9_CDCLFR                                   "
	cQuery += "                    AND GUB.D_E_L_E_T_ = ''                                               "               
	cQuery += "             WHERE  GV9.GV9_SIT = '2' AND                               "
	If lFilExc .And. !Empty(cLstFil)
		cQuery += "         GV9.GV9_FILIAL IN ("+cLstFil+")    AND                               "
 	EndIf

	cQuery += "               GV9.GV9_DTVALI <= '"+cVigencia+"' AND GV9.D_E_L_E_T_ = ''                                                    "

	If !Empty(cTransport)
		cQuery += "         AND GV9.GV9_CDEMIT  = '"+cTransport+"'                               "
	EndIf

	If !Empty(cTabela)
		cQuery += "         AND GV9.GV9_NRTAB = '"+cTabela+"'                                     "
	EndIf
	
	cQuery += "               AND (GV9.GV9_DTVALF >= '"+cVigencia+"' OR GV9.GV9_DTVALF = '')             "               
	//--------------------------------------------------------------
	// Fim da query
	//--------------------------------------------------------------
	cAli   := GetNextAlias()
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T., "TOPCONN", TCGENQRY(,,cQuery), cAli, .F.) 
	oSection1:Init()// Inicializa a impreção do relatório
	(cAli)->(dbGoTop())
	
	While  !(cAli)->( Eof() ) .And. !oReport:Cancel()
		oSection1:PrintLine()
		(cAli)->( dbSkip() )
	EndDo 
	oSection1:Finish()// Finaliza a impreção do relatório
	(cAli)->(dbCloseArea())
Return
/*/{Protheus.doc} GFEA62ROTA
Função busca e retorna a informação da rota passada como parâmetro
@author alexandre.cuchi
@param cCdEmit, Codigo do emitente da tabela de frete 
@param cNrTab, Número da tabela de frete 
@param cNrNeg, negociação da tabela de frete 
@param cCdFxTv, Código da faixa/tipo de veiculo 
@param cRota, Rota que deve ser descrita
@return cRetorno, Informação da rota, "Cod Ori. Tipo Ori.| Cod. Dest. Tipo Destin.
@since 06/02/2015
@version 1.0
@example
(examples)
@see (links_or_references)
/*/
User Function GFEA62ROTA(cCdEmit,cNrTab,cNrNeg,cCdFxTv,cRota)
	Local cRetorno  := ""              
	Local cRetOri   := ""     
	Local cRetDes   := ""  
	Local aAreaGV7  := GV7->(GetArea())
	Local aAreaGV9  := GV9->(GetArea())
	Local aAreaGV3  := GV3->(GetArea()) 
	
	Default cCdEmit := GV9->GV9_CDEMIT
	Default cNrTab  := GV9->GV9_NRTAB
	Default cNrNeg  := GV9->GV9_NRNEG
	Default cCdFxTv := FwFldGet("GV6_NRROTA")  
	
	dbSelectArea("GVA")
	GVA->( dbSetOrder(1) ) 
	If GVA->( dbSeek(xFilial("GVA") + cCdEmit + cNrTab ) ) 
		If GVA->GVA_TPTAB == "2"
			dbSelectArea("GV9")
			GV9->( dbSetOrder(1) ) 
			If GV9->( dbSeek(xFilial("GV9") + GVA->GVA_EMIVIN + GVA->GVA_TABVIN) )  					
				dbSelectArea("GV8")
				GV8->( dbSetOrder(1) )
				If GV8->( dbSeek(xFilial("GV8") + GV9->GV9_CDEMIT + GV9->GV9_NRTAB + cNrNeg ) )
					cCdEmit	:= GV8->GV8_CDEMIT
					cNrTab  := GV8->GV8_NRTAB
				Endif						
			Endif					
		Endif
	Endif
	
	dbSelectArea("GV8")
	If GV8->(dbSeek(xFilial("GV8") + cCdEmit + cNrTab + cNrNeg  + cRota))
		If GV8->GV8_TPORIG == "1"
	   		cRetOri := STR0048 + " - " + AllTrim(GV8->GV8_NRCIOR)      + " - " + AllTrim(POSICIONE("GU7",1,XFILIAL("GU7")+GV8->GV8_NRCIOR,"GU7_NMCID")) //"Cidade"
	  	ElseIf GV8->GV8_TPORIG == "2"
			cRetOri := STR0049 + " - " + Alltrim(STR(GV8->GV8_DSTORI)) + " - " + Alltrim(STR(GV8->GV8_DSTORF)) //"Distância"
		ElseIf GV8->GV8_TPORIG == "3"
			cRetOri := STR0050 + " - " + AllTrim(GV8->GV8_NRREOR)      + " - " + AllTrim(POSICIONE("GU9",1,XFILIAL("GU9")+GV8->GV8_NRREOR,"GU9_NMREG")) //"Região"
		ElseIf GV8->GV8_TPORIG == "4"
			cRetOri := STR0051 + " - " + AllTrim(GV8->GV8_CDPAOR)      + " - " +;
			                             AllTrim(POSICIONE("SYA",1,XFILIAL("SYA")+GV8->GV8_CDPAOR,"YA_DESCR")) + ;
					                              " , " + STR0056 + " - " + GV8->GV8_CDUFOR // "País" ### "UF"
		ElseIf GV8_TPORIG == "5"
			cRetOri := STR0052 + " - " + AllTrim(GV8->GV8_CDREM)       + " - " + AllTrim(POSICIONE("GU3",1,XFILIAL("GU3")+GV8->GV8_CDREM,"GU3_NMEMIT")) //"Remetente"
		Endif            
		
		If GV8->GV8_TPORIG != "2"
		   	If GV8->GV8_TPDEST == "1"
				cRetDes := " | "+STR0048 + " - " + AllTrim(GV8->GV8_NRCIDS)      + " - " + AllTrim(POSICIONE("GU7",1,XFILIAL("GU7")+GV8->GV8_NRCIDS,"GU7_NMCID")) //"Cidade"
			ElseIf GV8->GV8_TPDEST == "2"
				cRetDes := " | "+STR0049 + " - " + Alltrim(STR(GV8->GV8_DSTDEI)) + " - " + Alltrim(STR(GV8->GV8_DSTDEF)) //"Distância"
			ElseIf GV8->GV8_TPDEST == "3"
				cRetDes := " | "+STR0050 + " - " + AllTrim(GV8->GV8_NRREDS)      + " - " + AllTrim(POSICIONE("GU9",1,XFILIAL("GU9")+GV8->GV8_NRREDS,"GU9_NMREG"))//"Região"
			ElseIf GV8->GV8_TPDEST == "4"                                      
				cRetDes := " | "+STR0051 + " - " + AllTrim(GV8->GV8_CDPADS)      + " - " + AllTrim(POSICIONE("SYA",1,XFILIAL("SYA")+GV8->GV8_CDPADS,"YA_DESCR")) + ;
						   " , " + STR0056 + " - " + GV8->GV8_CDUFDS // "País" ### "UF"
			ElseIf GV8->GV8_TPDEST == "5"
				cRetDes := " | Destinatário - " + AllTrim(GV8->GV8_CDDEST)      + " - " + Alltrim(POSICIONE("GU3",1,XFILIAL("GU3")+GV8->GV8_CDDEST,"GU3_NMEMIT")) //"Destinatário"
			Endif
		EndIf
		
		cRetorno := cRetOri + cRetDes
		
	Endif
		
	RestArea(aAreaGV3)
	RestArea(aAreaGV9)
	RestArea(aAreaGV7)   
Return cRetorno
