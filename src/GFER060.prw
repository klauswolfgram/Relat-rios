/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

/*/ -------------------------------------------------------------------------------------------------- 
{Protheus.doc} GFER060
Relatorio de Freight LeadTime Fact
Generico.

@sample 
GFER040()

@author Felipe M.
@since 21/12/11
@version 1.0
--------------------------------------------------------------------------------------------------/*/
User Function GFER060()
	Local oReport                   //objeto que contem o relatorio
	Local aArea := GetArea()

	cAliasPr := U_GFEBITtPr()
	Pergunte("GFER060",.F.)
	If TRepInUse() // teste padrão 
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf 

	GFEDelTab(cAliasPr)  
 	RestArea( aArea )

Return     

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportDef
Relatorio de Freight LeadTime Fact
Generico.

@sample
ReportDef()

@author Felipe M.
@since 21/12/11
@version 1.0
--------------------------------------------------------------------------------------------------/*/     

Static Function ReportDef()
Local oReport, oSection1
Local aOrdem    := {}
Local oCell
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
oReport:= TReport():New("GFER060","Relatório de Entregas","GFER060", {|oReport| ReportPrint(oReport)},"BI - Freight LeadTime Fact.")  
oReport:SetLandscape()   // define se o relatorio saira deitado
oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
oReport:SetTotalInLine(.F.)
oReport:nFontBody	:= 10 // Define o tamanho da fonte.
oReport:nLineHeight	:= 50 // Define a altura da linha.    
oReport:NDEVICE := 4    

Aadd( aOrdem, "Freight LeadTime Fact" ) // "Sequência" //"Codigo"

oSection1 := TRSection():New(oReport,"Freight LeadTime Fact",{"(cAliasPr)"},aOrdem)
//oSection1:SetLineStyle() //Define a impressao da secao em linha
//oSection1:SetTotalInLine(.F.) 

oCell := TRCell():New(oSection1,"(cAliasPr)->FILIAL"	  ,"(cAliasPr)","Empresa" 	  			,"@!",02,/*lPixel*/,{||If( "_" $ (cAliasPr)->FILIAL 	,"",(cAliasPr)->FILIAL  ) } )
oCell:Disable()
		 TRCell():New(oSection1,"(cAliasPr)->GW1_FILIAL"  ,"(cAliasPr)","Filial"   				,"@!",02,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW1_FILIAL ,"",(cAliasPr)->GW1_FILIAL )} )
		 TRCell():New(oSection1,"(cAliasPr)->GW1_SERDC"   ,"(cAliasPr)","Serie" 				,"@!",05,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW1_SERDC 	,"",(cAliasPr)->GW1_SERDC )})     
		 TRCell():New(oSection1,"(cAliasPr)->GW1_NRDC"    ,"(cAliasPr)","Nr Docto"				,"@!",16,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW1_NRDC 	,"",(cAliasPr)->GW1_NRDC )})     
		 TRCell():New(oSection1,"(cAliasPr)->GW1_CDTPDC"  ,"(cAliasPr)","Tp Doc" 				,"@!",05,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW1_CDTPDC ,"",(cAliasPr)->GW1_CDTPDC )})     
oCell := TRCell():New(oSection1,"(cAliasPr)->GV5_DSTPDC"  ,"(cAliasPr)","Des Tipo Doc" 			,"@!",50,/*lPixel*/,{||If( "_" $ (cAliasPr)->GV5_DSTPDC ,"",(cAliasPr)->GV5_DSTPDC )})     
oCell:Disable()
		 TRCell():New(oSection1,"(cAliasPr)->GW1_CDREM"   ,"(cAliasPr)","Cod Rem"     			,"@!",14,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW1_CDREM 	,"",(cAliasPr)->GW1_CDREM )})     
		 TRCell():New(oSection1,"(cAliasPr)->GW1_NMREM"   ,"(cAliasPr)","Nome Remetente"		,"@!",50,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW1_NMREM 	,"",(cAliasPr)->GW1_NMREM )})     
		 TRCell():New(oSection1,"(cAliasPr)->GW_CIDREM"	  ,"(cAliasPr)","Nr Cid Origem"			,"@!",07,/*lPixel*/,/*{||}*/)
		 TRCell():New(oSection1,"(cAliasPr)->GW_DSCIREM"  ,"(cAliasPr)","Cidade Origem"   	    ,"@!",50,/*lPixel*/,/*{||}*/)
		 TRCell():New(oSection1,"(cAliasPr)->GW_CDUFRE"	  ,"(cAliasPr)","UF"					,"@!",02,/*lPixel*/,/*{||}*/)    
		 TRCell():New(oSection1,"(cAliasPr)->GW1_CDDEST"  ,"(cAliasPr)","Cod Dest"     			,"@!",14,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW1_CDDEST ,"",(cAliasPr)->GW1_CDDEST )})     
		 TRCell():New(oSection1,"(cAliasPr)->GW1_NMDEST"  ,"(cAliasPr)","Nm Dest"     			,"@!",50,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW1_NMDEST ,"",(cAliasPr)->GW1_NMDEST )})     
oCell := TRCell():New(oSection1,"(cAliasPr)->GW_NRCIDD"	  ,"(cAliasPr)","Nr Cid Dest" 			,"@!",07,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW_NRCIDD 	,"",(cAliasPr)->GW_NRCIDD )})
oCell:Disable()
         TRCell():New(oSection1,"(cAliasPr)->GW_NMCIDD"   ,"(cAliasPr)","Cidade Destino"		,"@!",20,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW_NMCIDD 	,"",(cAliasPr)->GW_NMCIDD )})
		 TRCell():New(oSection1,"(cAliasPr)->GWU_UFD"     ,"(cAliasPr)","UF" 		   			,"@!",02,/*lPixel*/,{||If( "_" $ (cAliasPr)->GWU_UFD 	,"",(cAliasPr)->GWU_UFD )})
oCell := TRCell():New(oSection1,"(cAliasPr)->GW_PAIS"     ,"(cAliasPr)","Cod Pais" 	   			,"@!",03,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW_PAIS 	,"",(cAliasPr)->GW_PAIS )})
oCell:Disable()
		 TRCell():New(oSection1,"(cAliasPr)->GW1_TPFRET"  ,"(cAliasPr)","Tipo Frete"			,"@!",08,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW1_TPFRET ,"",(cAliasPr)->GW1_TPFRET )})     
		 TRCell():New(oSection1,"(cAliasPr)->GWN_CDTRP"	  ,"(cAliasPr)","Transp Romaneio"       ,"@!",14,/*lPixel*/,/*{||}*/)
		 TRCell():New(oSection1,"(cAliasPr)->GWN_DSTRP"   ,"(cAliasPr)","Nome Transportador"	,"@!",50,/*lPixel*/,/*{||}*/)
		 TRCell():New(oSection1,"(cAliasPr)->GW_REDESP"   ,"(cAliasPr)","Redp?"				    ,"@!",03,/*lPixel*/,{||If( (cAliasPr)->GW_REDESP==1 	,"Sim","Não") })     
		 TRCell():New(oSection1,"(cAliasPr)->GW1_DTEMIS"  ,"(cAliasPr)","Emissão" 		    	,""  ,10,/*lPixel*/,{||If((cAliasPr)->GW1_DTEMIS == CtoD("01/01/1800") ,CtoD("  /  /    "),(cAliasPr)->GW1_DTEMIS )})     
	     TRCell():New(oSection1,"(cAliasPr)->GW1_DTPSAI"  ,"(cAliasPr)","Dt Prev Saida" 		,"@!",10,/*lPixel*/,{||If((cAliasPr)->GW1_DTPSAI == CtoD("01/01/1800") ,CtoD("  /  /    "),(cAliasPr)->GW1_DTPSAI )})     
oCell := TRCell():New(oSection1,"(cAliasPr)->GW1_HRPSAI"  ,"(cAliasPr)","Hr Prev Saida" 		,"@!",05,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW1_HRPSAI ,"",(cAliasPr)->GW1_HRPSAI )})     
oCell:Disable()
		 TRCell():New(oSection1,"(cAliasPr)->GW1_DTSAI"   ,"(cAliasPr)","Dt Saida" 	   			,    ,10,/*lPixel*/,{||If((cAliasPr)->GW1_DTSAI == CtoD("01/01/1800") ,CtoD("  /  /    "),(cAliasPr)->GW1_DTSAI )})     
oCell := TRCell():New(oSection1,"(cAliasPr)->GW1_HRSAI"   ,"(cAliasPr)","Hr Saida" 				,"@!",05,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW1_HRSAI 	,"",(cAliasPr)->GW1_HRSAI )})     
oCell:Disable()
		 TRCell():New(oSection1,"(cAliasPr)->GW1_DTPENT"  ,"(cAliasPr)","Dt Prev Entr" 			,  ,10,/*lPixel*/,{||If((cAliasPr)->GW1_DTPENT == CtoD("01/01/1800") ,CtoD("  /  /    "),(cAliasPr)->GW1_DTPENT )})     
oCell := TRCell():New(oSection1,"(cAliasPr)->GW1_HRPENT"  ,"(cAliasPr)","Hr Prev Entr"			,"@!",05,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW1_HRPENT ,"",(cAliasPr)->GW1_HRPENT )})     
oCell:Disable()
		 TRCell():New(oSection1,"(cAliasPr)->GWU_DTENT"   ,"(cAliasPr)","Dt Entr" 				,   ,10,/*lPixel*/,{||If((cAliasPr)->GWU_DTENT == CtoD("01/01/1800") ,CtoD("  /  /    "),(cAliasPr)->GWU_DTENT )})     
oCell := TRCell():New(oSection1,"(cAliasPr)->GWU_HRENT"   ,"(cAliasPr)","Hr Entr" 				,"@!",05,/*lPixel*/,{||If( "_" $ (cAliasPr)->GWU_HRENT 	,"",(cAliasPr)->GWU_HRENT )})     
oCell:Disable()
oCell := TRCell():New(oSection1,"(cAliasPr)->GW1_DTIMPL"  ,"(cAliasPr)","Dt Impl" 				,   ,10,/*lPixel*/,{||If((cAliasPr)->GW1_DTIMPL == CtoD("01/01/1800") ,CtoD("  /  /    "),(cAliasPr)->GW1_DTIMPL )})     
oCell:Disable()
oCell := TRCell():New(oSection1,"(cAliasPr)->GW1_HRIMPL"  ,"(cAliasPr)","Hr Impl" 				,"@!",05,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW1_HRIMPL ,"",(cAliasPr)->GW1_HRIMPL )})     
oCell:Disable()
		 TRCell():New(oSection1,"(cAliasPr)->PREVEXP"	  ,"(cAliasPr)","Prev Exp"	  			,"999",03,/*lPixel*/,/*{||}*/)	//Prev Exp
		 TRCell():New(oSection1,"(cAliasPr)->TEMPOEFIC"   ,"(cAliasPr)","Real Exp"	  			,"999",03,/*lPixel*/,/*{||}*/)   
		 TRCell():New(oSection1,"(cAliasPr)->TEMPOPRSAI"  ,"(cAliasPr)","Atr Exp"	 			,"999",03,/*lPixel*/,/*{||}*/)     
         TRCell():New(oSection1,"(cAliasPr)->TEMPOPREV"   ,"(cAliasPr)","Prev Ent"				,"999",03,/*lPixel*/,/*{||}*/)     
	     TRCell():New(oSection1,"(cAliasPr)->TEMPOREAL"   ,"(cAliasPr)","Real Ent" 				,"999",03,/*lPixel*/,/*{||}*/)     
		 TRCell():New(oSection1,"(cAliasPr)->TEMPO"    	  ,"(cAliasPr)","Atr Ent" 				,"999",03,/*lPixel*/,/*{||}*/)         
		 TRCell():New(oSection1,"(cAliasPr)->PREVTOT"	  ,"(cAliasPr)","Prev Tot"	  			,"999",03,/*lPixel*/,/*{||}*/)	//Prev Tot
		 TRCell():New(oSection1,"(cAliasPr)->REALTOT"	  ,"(cAliasPr)","Real Tot"	  			,"999",03,/*lPixel*/,/*{||}*/)	//Real Tot
		 TRCell():New(oSection1,"(cAliasPr)->ATRTOT"	  ,"(cAliasPr)","Atr Tot"	  			,"999",03,/*lPixel*/,/*{||}*/)	//Atr Tot
		 TRCell():New(oSection1,"(cAliasPr)->GWN_CDTPVC"  ,"(cAliasPr)","Cod Tp Veic" 			,"@!",10,/*lPixel*/,{||If( "_" $ (cAliasPr)->GWN_CDTPVC ,"",(cAliasPr)->GWN_CDTPVC )})     
oCell := TRCell():New(oSection1,"(cAliasPr)->GV3_DSTPVC"  ,"(cAliasPr)","Des Tp Veic" 			,"@!",50,/*lPixel*/,{||If( "_" $ (cAliasPr)->GV3_DSTPVC ,"",(cAliasPr)->GV3_DSTPVC )})     
oCell:Disable()
	     TRCell():New(oSection1,"(cAliasPr)->GW1_REGCOM"  ,"(cAliasPr)","Reg Comer."   			,"@!",12,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW1_REGCOM ,"",(cAliasPr)->GW1_REGCOM )})
		 TRCell():New(oSection1,"(cAliasPr)->GW1_REPRES"  ,"(cAliasPr)","Repres." 	   			,"@!",20,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW1_REPRES	,"",(cAliasPr)->GW1_REPRES )})
		 TRCell():New(oSection1,"(cAliasPr)->GW1_NRROM"   ,"(cAliasPr)","Romaneio" 				,"@!",08,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW1_NRROM 	,"",(cAliasPr)->GW1_NRROM )})     
oCell := TRCell():New(oSection1,"(cAliasPr)->GW1_EMISDC"  ,"(cAliasPr)","Cod Emissor"  			,"@!",14,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW1_EMISDC ,"",(cAliasPr)->GW1_EMISDC )})
oCell:Disable()
oCell := TRCell():New(oSection1,"(cAliasPr)->GW_NMEMI"    ,"(cAliasPr)","Nm Emissor"  			,"@!",50,/*lPixel*/,{||If( "_" $ (cAliasPr)->GW_NMEMI 	,"",(cAliasPr)->GW_NMEMI )})
oCell:Disable()
		 TRCell():New(oSection1,"(cAliasPr)->GWN_CDTPOP"  ,"(cAliasPr)","Tipo Oper" 			,"@!",10,/*lPixel*/,{||If( "_" $ (cAliasPr)->GWN_CDTPOP ,"",(cAliasPr)->GWN_CDTPOP )})     
oCell := TRCell():New(oSection1,"(cAliasPr)->GV4_DSTPOP"  ,"(cAliasPr)","Des Tp Op"			 	,"@!",50,/*lPixel*/,{||If( "_" $ (cAliasPr)->GV4_DSTPOP ,"",(cAliasPr)->GV4_DSTPOP )})  
oCell:Disable()

            
Return(oReport) 
         

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportPrint
Relatorio de Freight LeadTime Fact
Generico.

@sample
ReportPrint(oReport)

@author Felipe M.
@since 14/10/09                              
@version 1.0                                           
--------------------------------------------------------------------------------------------------/*/
Static Function ReportPrint(oReport)
	Local aParam    := {,,,}
	Local oSection1 := oReport:Section(1)

	aParam[1] := If(Empty(MV_PAR03),CtoD("01/01/1800"),MV_PAR03)
	aParam[2] := If(Empty(MV_PAR04),CtoD("01/01/3000"),MV_PAR04)

	cAliasPr := U_GFEProcPr(aParam)
	
	dbSelectArea(cAliasPr)
	oReport:SetMeter((cAliasPr)->(LastRec()))
	(cAliasPr)->( dbgotop() )
	//Secção 1
	oSection1:Init()

	While !( (cAliasPr)->(eof()) )
	    oReport:IncMeter() 
	    If ( (cAliasPr)->GW1_FILIAL >= MV_PAR01 .AND. (cAliasPr)->GW1_FILIAL <= MV_PAR02 ) ;
	    .AND. ( (cAliasPr)->GW1_CDTPDC >= MV_PAR05 .AND. (cAliasPr)->GW1_CDTPDC <= MV_PAR06 );
	    .AND. ( (cAliasPr)->GWN_CDTPOP >= MV_PAR07 .AND. (cAliasPr)->GWN_CDTPOP <= MV_PAR08 ) ;
	    .AND. ( (cAliasPr)->GWN_CDTRP  >= MV_PAR10 .AND. (cAliasPr)->GWN_CDTRP  <= MV_PAR11 ) ;
	    .AND. ( (MV_PAR12 == 1 .AND. (cAliasPr)->GW_REDESP == 0 ) .OR. (MV_PAR12 == 2)      ) ;
	    .AND. ( (MV_PAR09 == 1 .AND. (cAliasPr)->GW1_TPFRET $ "1;2") .OR. (MV_PAR09 == 2 .AND. (cAliasPr)->GW1_TPFRET $ "3;4") .OR. (MV_PAR09 == 3) ); 
			
			dbSelectArea("GW1")
			GW1->( dbSetOrder(1) )
			GW1->( dbSeek((cAliasPr)->GW1_FILIAL+(cAliasPr)->GW1_CDTPDC+(cAliasPr)->GW1_EMISDC+(cAliasPr)->GW1_SERDC+(cAliasPr)->GW1_NRDC))
				
			If GW1->GW1_SIT == "5" .Or. GW1->GW1_SIT == "6"
				oSection1:PrintLine()
			EndIf
			
		EndIf
		(cAliasPr)->(dbSkip())
	EndDo
   
	oSection1:Finish() 
	
Return

/*--------------------------------------------------------/
Função que processa a regua de progressão


--------------------------------------------------------*/
User Function GFEProcPr(aParam)
Local cAlias

Processa( {|| cAlias := U_GFEBIPRAZO(aParam) }, "Aguarde...", "Exportando Prazo de Entrega...",.F.)

Return cAlias

/*--------------------------------------------------------/
Função que cria a Tamp-table do Prazo de entrega


--------------------------------------------------------*/
User Function GFEBITtPr()
	Local aTT        := Nil
	Local cTTBIPrazo := Nil

	// Criacao da tabela temporaria p/ imprimir o relat
	aTT := {{"FILIAL"    	,"C",TamSX3("GW1_FILIAL")[1],0},;	//CD_Company
			{"GW1_FILIAL"   ,"C",TamSX3("GW1_FILIAL")[1],0},;	//CD_Site
			{"GW_NRCIDD"    ,"C",TamSX3("GU7_NRCID")[1] ,0},;	//CD_City
			{"GW_NMCIDD"    ,"C",TamSX3("GU7_NMCID")[1],0},;
			{"GWU_UFD"      ,"C",02,0},;						//CD_State
			{"GW_PAIS"      ,"C",TamSX3("GU7_CDPAIS")[1],0},;	//CD_Country
			{"GW1_REGCOM"   ,"C",TamSX3("GW1_REGCOM")[1],0},;	//CD_Comercial_Territory
			{"GW1_REPRES"   ,"C",TamSX3("GW1_REPRES")[1],0},;	//CD_Representative
			{"GW1_EMISDC"   ,"C",TamSX3("GW1_EMISDC")[1],0},;	//CD_Carrier
			{"GW_NMEMI"     ,"C",50,0},; 						//NOVO
			{"GW1_CDDEST"   ,"C",TamSX3("GW1_CDDEST")[1],0},;	//CD_Emitter
			{"GW1_NMDEST"   ,"C",TamSX3("GW1_NMDEST")[1],0},; 	//NOVO
			{"GW1_CDREM"    ,"C",TamSX3("GW1_CDREM")[1],0},;	//CD_Emitter_Sender
			{"GW1_NMREM"    ,"C",TamSX3("GW1_NMREM")[1],0},; 	//NOVO
			{"GW1_CDTPDC"   ,"C",TamSX3("GW1_CDTPDC")[1],0},;	//CD_NF_Type
			{"GV5_DSTPDC"   ,"C",TamSX3("GV5_DSTPDC")[1],0},; 	//NOVO
			{"GW1_TPFRET"   ,"C",TamSX3("GW1_TPFRET")[1],0},;	//CD_Freight_Type
			{"GWN_CDTPVC"   ,"C",TamSX3("GWN_CDTPVC")[1],0},;	//CD_Vehicle_Type
			{"GV3_DSTPVC"   ,"C",TamSX3("GV3_DSTPVC")[1],0},; 	//NOVO
			{"GW_REDESP"    ,"N",01,0},;						//CD_Redispatch
			{"GW1_SERDC"    ,"C",TamSX3("GW1_SERDC")[1],0},;	//CD_Sale_Forma_Bill_Series
			{"GW1_NRDC"     ,"C",TamSX3("GW1_NRDC")[1],0},;		//CD_Sale_Forma_Bill_Number
			{"GW1_NRROM"    ,"C",TamSX3("GW1_NRROM")[1],0},;	//CD_Romaneio
			{"GW1_DTIMPL"   ,"D",TamSX3("GW1_DTIMPL")[1],0},;	//DT_Day
			{"GW1_DTEMIS"   ,"D",TamSX3("GW1_DTEMIS")[1],0},;	//DT_NF_Create
			{"GW1_HRIMPL"   ,"C",TamSX3("GW1_HRIMPL")[1],0},;	//DT_NF_Create_Time
			{"GW1_DTSAI"    ,"D",TamSX3("GW1_DTSAI")[1],0},;	//DT_Material_Out
			{"GW1_HRSAI"    ,"C",TamSX3("GW1_HRSAI")[1],0},;	//DT_Material_Out_Time
			{"GWU_DTENT"    ,"D",TamSX3("GWU_DTENT")[1],0},;	//DT_Material_Delivery
			{"GWU_HRENT"    ,"C",TamSX3("GWU_HRENT")[1],0},;	//DT_Material_Delivery_Time
			{"GW1_DTPENT"	,"D",TamSX3("GW1_DTPENT")[1],0},;	//DT_Material_Delivery_Prev
			{"GW1_HRPENT"   ,"C",TamSX3("GW1_HRPENT")[1],0},;	//DT_Material_Delivery_Prev_Time
			{"GW1_DTPSAI"   ,"D",TamSX3("GW1_DTPSAI")[1],0},;	//DT_Material_Out_Prev
			{"GW1_HRPSAI"   ,"C",TamSX3("GW1_HRPSAI")[1],0},;	//DT_Material_Out_Prev_Time
			{"TEMPOEFIC"    ,"N",07,0},;						//NM_Lead_Time_Internal
			{"TEMPO"    	,"N",07,0},;						// NM_Lead_Time
			{"TEMPOPREV"    ,"N",07,0},;						// NM_Lead_Time_Prevision
			{"TEMPOREAL"    ,"N",07,0},;						// NM_Lead_Time_Real
			{"TEMPOPRSAI"   ,"N",07,0},;						//NM_Lead_Time_Prevision_Out
			{"GWN_CDTPOP"   ,"C",TamSX3("GWN_CDTPOP")[1],0},;	//CD_TIPO_OPERACAO
			{"GV4_DSTPOP"   ,"C",TamSX3("GV4_DSTPOP")[1],0},;
			{"PREVEXP"		,"N",15,0},;						//Prev Exp
			{"PREVTOT"		,"N",15,0},;						//Prev Tot
			{"REALTOT"		,"N",15,0},;						//Real Tot
			{"ATRTOT"		,"N",15,0},;						//Atr Tot
			{"GWN_CDTRP"    ,"C",TamSX3("GWN_CDTRP")[1],0},;
			{"GWN_DSTRP"    ,"C",TamSX3("GWN_DSTRP")[1],0},;
			{"GW_CIDREM"	,"C",TamSX3("GU7_NRCID")[1],0},;
			{"GW_DSCIREM"   ,"C",TamSX3("GU7_NMCID")[1],0},;
			{"GW_CDUFRE"	,"C",02,0} }

	cTTBIPrazo := GFECriaTab({aTT,{"FILIAL+GW1_FILIAL+GW_NRCIDD+GW1_SERDC+GW1_NRDC"}})

Return cTTBIPrazo

/*/--------------------------------------------------------------------------------------------------
Função responsavel por buscar os registro e retornar o nome da tabela temporaria com os registros
Generico.

@sample
U_GFEBIPRAZO(aParam)

@author Felipe M.
@since 19/12/11
@version 1.0
--------------------------------------------------------------------------------------------------/*/
User Function GFEBIPRAZO(aParam)
Local aCampos := Array(50)
Local cFiltro := ""
Local aStruct := geraStruct("GW1")
Local cQuery := ""
Local s_SITEDC := SuperGetMV("MV_SITEDC",.F.,"1")

Private cAliGW1N := GetNextAlias()

cAliGW1N := GFECriaTab({aStruct, {"GW1_NRDC"}})

cQuery += "SELECT * FROM " + RetSqlName("GW1") + " GW1 "
cQuery += " WHERE GW1.GW1_DTEMIS >= '" + DtoS(aParam[1]) + "' AND GW1.GW1_DTEMIS <= '" + DToS(aParam[2]) + "' "

SqlToTrb(cQuery, aStruct, cAliGW1N)

// verifica se a função de relatorio está no stack, se estiver não executa a função de cração da tabela, pois a mesma já foi criada
If !IsInCallStack("GFER060")
	cAliasPr := U_GFEBITtPr()
EndIf

dbSelectArea(cAliGW1N)
dbSetOrder(1)
dbGoTop()
ProcRegua(RecCount())
While !(cAliGW1N)->( Eof() )

	IncProc()
	aCampos    := Array(50)
    If IsInCallStack("GFER060")
    	aCampos[1] := cEmpAnt
	    aCampos[2] := (cAliGW1N)->GW1_FILIAL
    Else
	    aCampos[1] := Iif(Empty(RetEmpFil(cEmpAnt, (cAliGW1N)->GW1_FILIAL)), cEmpAnt, RetEmpFil(cEmpAnt, (cAliGW1N)->GW1_FILIAL)[1] )
	    aCampos[2] := Iif(Empty(RetEmpFil(cEmpAnt, (cAliGW1N)->GW1_FILIAL)), (cAliGW1N)->GW1_FILIAL, RetEmpFil(cEmpAnt, (cAliGW1N)->GW1_FILIAL)[2] )
    EndIf
    cFiltro    := ""

    cFiltro :=       " GWU->GWU_FILIAL='" +  (cAliGW1N)->GW1_FILIAL + "'"
    cFiltro += " .AND. GWU->GWU_CDTPDC='" +  (cAliGW1N)->GW1_CDTPDC + "'"
    cFiltro += " .AND. GWU->GWU_EMISDC='" +  (cAliGW1N)->GW1_EMISDC + "'"
    cFiltro +=  " .AND. GWU->GWU_SERDC='" +  (cAliGW1N)->GW1_SERDC  + "'"
    cFiltro +=   " .AND. GWU->GWU_NRDC='" +  (cAliGW1N)->GW1_NRDC   + "'"
     
    SeekLast("GWU",1,cFiltro)
 
    If EMPTY((cAliGW1N)->GW1_ENTNRC)
        aCampos[3] := GWU->GWU_NRCIDD
        aCampos[4] := Posicione("GU7",1,xFilial("GU7")+GWU->GWU_NRCIDD,"GU7_NMCID")
        aCampos[5] := Posicione("GU7",1,XFILIAL("GU7")+GWU->GWU_NRCIDD,"GU7_CDUF")
        aCampos[6] := Posicione("GU7",1,XFILIAL("GU7")+GWU->GWU_NRCIDD,"GU7_CDPAIS")
	Else
		aCampos[3] := (cAliGW1N)->GW1_ENTNRC
	    aCampos[4] := Posicione("GU7",1,xFilial("GU7")+(cAliGW1N)->GW1_ENTNRC,"GU7_NMCID")
	    aCampos[5] := Posicione("GU7",1,XFILIAL("GU7")+(cAliGW1N)->GW1_ENTNRC,"GU7_CDUF")
	    aCampos[6] := Posicione("GU7",1,XFILIAL("GU7")+(cAliGW1N)->GW1_ENTNRC,"GU7_CDPAIS")
    EndIf

	cAliasGWU := GetNextAlias()
	BeginSql Alias cAliasGWU
		SELECT GWU.GWU_SEQ,
				GWU.GWU_DTENT,
				GWU.GWU_HRENT,
				GWU.GWU_DTPENT,
				GWU.GWU_HRPENT,
				GWU.GWU_PAGAR
		FROM %Table:GWU% GWU
		WHERE GWU.GWU_FILIAL = %Exp:(cAliGW1N)->GW1_FILIAL%
		AND GWU.GWU_CDTPDC = %Exp:(cAliGW1N)->GW1_CDTPDC%
		AND GWU.GWU_EMISDC = %Exp:(cAliGW1N)->GW1_EMISDC%
		AND GWU.GWU_SERDC = %Exp:(cAliGW1N)->GW1_SERDC%
		AND GWU.GWU_NRDC = %Exp:(cAliGW1N)->GW1_NRDC%
		AND GWU.%NotDel%
	EndSql 
	
	Do While (cAliasGWU)->(!Eof())
		If s_SITEDC == "1" .Or. Empty(s_SITEDC)
			If (cAliasGWU)->GWU_PAGAR == '1'
				aCampos[29] := STOD((cAliasGWU)->GWU_DTENT)
				aCampos[30] := (cAliasGWU)->GWU_HRENT
				aCampos[31] := STOD((cAliasGWU)->GWU_DTPENT)
				aCampos[32] := (cAliasGWU)->GWU_HRPENT
			EndIf
		Else 
			aCampos[29] := GWU->GWU_DTENT
			aCampos[30] := GWU->GWU_HRENT
			aCampos[31] := GWU->GWU_DTPENT
			aCampos[32] := GWU->GWU_HRPENT
		EndIf
		(cAliasGWU)->(dbSkip())
	EndDo
	(cAliasGWU)->(dbCloseArea())

    DBCLEARALLFILTER()

    aCampos[7]  := (cAliGW1N)->GW1_REGCOM
    aCampos[8]  := (cAliGW1N)->GW1_REPRES
	aCampos[9]  := (cAliGW1N)->GW1_EMISDC
	aCampos[10] := POSICIONE("GU3",1,xFilial("GU3")+(cAliGW1N)->GW1_EMISDC,"GU3_NMEMIT")
	aCampos[11] := (cAliGW1N)->GW1_CDDEST
	aCampos[12] := POSICIONE("GU3",1,xFilial("GU3")+(cAliGW1N)->GW1_CDDEST,"GU3_NMEMIT")
	aCampos[13] := (cAliGW1N)->GW1_CDREM
    aCampos[14] := POSICIONE("GU3",1,xFilial("GU3")+(cAliGW1N)->GW1_CDREM,"GU3_NMEMIT")
    aCampos[48] := GU3->GU3_NRCID
 	aCampos[49] := Posicione("GU7",1,xFilial("GU7")+GU3->GU3_NRCID,"GU7_NMCID")
	aCampos[50] := Posicione("GU7",1,XFILIAL("GU7")+GU3->GU3_NRCID,"GU7_CDUF")
    aCampos[15] := (cAliGW1N)->GW1_CDTPDC
    aCampos[16] := POSICIONE("GV5",1,xFilial("GV5")+(cAliGW1N)->GW1_CDTPDC,"GV5_DSTPDC")
    aCampos[17] := (cAliGW1N)->GW1_TPFRET

	dbSelectArea("GWN")
	dbSetOrder(1)
	If dbSeek((cAliGW1N)->GW1_FILIAL+(cAliGW1N)->GW1_NRROM)
		aCampos[18] := GWN->GWN_CDTPVC
		aCampos[19] := Posicione("GV3",1,XFILIAL("GV3")+GWN->GWN_CDTPVC,"GV3_DSTPVC")
		aCampos[40] := GWN->GWN_CDTPOP
		aCampos[41] := Posicione("GV4",1,XFILIAL("GV4")+GWN->GWN_CDTPOP,"GV4_DSTPOP")
		aCampos[46] := GWN->GWN_CDTRP
		aCampos[47] := POSICIONE("GU3",1,xFilial("GU3")+GWN->GWN_CDTRP,"GU3_NMEMIT")
	EndIf
  	aCampos[20] := If((cAliGW1N)->GW1_TPFRET $ "2/4/6",1,0)
	aCampos[21] := (cAliGW1N)->GW1_SERDC
	aCampos[22] := (cAliGW1N)->GW1_NRDC
	aCampos[23] := (cAliGW1N)->GW1_NRROM
    aCampos[24] := (cAliGW1N)->GW1_DTIMPL
	aCampos[25] := (cAliGW1N)->GW1_DTEMIS
	aCampos[26] := (cAliGW1N)->GW1_HRIMPL
	aCampos[27] := (cAliGW1N)->GW1_DTSAI
	aCampos[28] := (cAliGW1N)->GW1_HRSAI
	aCampos[33] := (cAliGW1N)->GW1_DTPSAI
	aCampos[34] := (cAliGW1N)->GW1_HRPSAI
	aCampos[35] := If(Empty((cAliGW1N)->GW1_DTSAI)	.OR.Empty((cAliGW1N)->GW1_DTEMIS)	,0,(cAliGW1N)->GW1_DTSAI 	- (cAliGW1N)->GW1_DTEMIS)
	aCampos[36] := If(Empty(aCampos[29])	.OR.Empty(GWU->GWU_DTPENT)	,0,aCampos[29] 		- GWU->GWU_DTPENT)
	aCampos[37] := If(Empty(GWU->GWU_DTPENT).OR.Empty((cAliGW1N)->GW1_DTPSAI)	,0,GWU->GWU_DTPENT 	- (cAliGW1N)->GW1_DTPSAI)
	aCampos[38] := If(Empty(aCampos[29])	.OR.Empty((cAliGW1N)->GW1_DTSAI)	,0,aCampos[29] 		- (cAliGW1N)->GW1_DTSAI)
	aCampos[39] := If(Empty((cAliGW1N)->GW1_DTSAI)	.OR.Empty((cAliGW1N)->GW1_DTPSAI)	,0,(cAliGW1N)->GW1_DTSAI 	- (cAliGW1N)->GW1_DTPSAI)
    aCampos[42] := If(Empty((cAliGW1N)->GW1_DTPSAI).OR.Empty((cAliGW1N)->GW1_DTEMIS)	,0,(cAliGW1N)->GW1_DTPSAI 	- (cAliGW1N)->GW1_DTEMIS) //Prev Expedição - Prev Exp
    aCampos[43] := If(Empty(GWU->GWU_DTPENT).OR.Empty((cAliGW1N)->GW1_DTEMIS)	,0,GWU->GWU_DTPENT 	- (cAliGW1N)->GW1_DTEMIS) //Previsto Total - Prev Tot
    aCampos[44] := If(Empty(aCampos[29])	.OR.Empty((cAliGW1N)->GW1_DTEMIS)	,0,aCampos[29]    	- (cAliGW1N)->GW1_DTEMIS) //Realizado Total - Real Tot
    aCampos[45] := If(Empty(aCampos[43])	.OR.Empty(aCampos[44])		,0,aCampos[43] 		- aCampos[44]    ) //Atraso Total  - Atr Tot
	
	
    RecLock( (cAliasPr), .T. )
		(cAliasPr)->FILIAL      :=  If(!Empty(aCampos[1]), aCampos[1], PADC( "",02,"_"))
		IF FWModeAccess("GW1",1)  == "E"
			(cAliasPr)->GW1_FILIAL  :=  If(!Empty(aCampos[2]), aCampos[2], PADC( "",02,"_"))
		ELSE
			(cAliasPr)->GW1_FILIAL  :=  If(!Empty(aCampos[2]), aCampos[2], PADC( "",TamSX3("GW1_FILIAL")[1],"_"))
		ENDIF
		(cAliasPr)->GW_NRCIDD   :=  If(!Empty(aCampos[3]), aCampos[3], PADC( "",07,"_"))
		(cAliasPr)->GW_NMCIDD   :=  If(!Empty(aCampos[4]), aCampos[4], PADC( "",50,"_"))
		(cAliasPr)->GWU_UFD     :=  If(!Empty(aCampos[5]), aCampos[5], PADC( "",02,"_"))
		(cAliasPr)->GW_PAIS     :=  If(!Empty(aCampos[6]), aCampos[6], PADC( "",03,"_"))
		(cAliasPr)->GW1_REGCOM  :=  If(!Empty(aCampos[7]), aCampos[7], PADC( "",12,"_"))
		(cAliasPr)->GW1_REPRES  :=  If(!Empty(aCampos[8]), aCampos[8], "0")
		(cAliasPr)->GW1_EMISDC  :=  If(!Empty(aCampos[9]), aCampos[9], PADC( "",14,"_"))
		(cAliasPr)->GW_NMEMI    :=  If(!Empty(aCampos[10]), aCampos[10], PADC( "",50,"_"))
		(cAliasPr)->GW1_CDDEST  :=  If(!Empty(aCampos[11]), aCampos[11], PADC( "",14,"_"))
		(cAliasPr)->GW1_NMDEST  :=  If(!Empty(aCampos[12]), aCampos[12], PADC( "",50,"_"))
		(cAliasPr)->GW1_CDREM   :=  If(!Empty(aCampos[13]), aCampos[13], PADC( "",14,"_"))
		(cAliasPr)->GW1_NMREM   :=  If(!Empty(aCampos[14]), aCampos[14], PADC( "",50,"_"))
		(cAliasPr)->GW1_CDTPDC  :=  If(!Empty(aCampos[15]), aCampos[15], PADC( "",05,"_"))
		(cAliasPr)->GV5_DSTPDC  :=  If(!Empty(aCampos[16]), aCampos[16], PADC( "",50,"_"))
		(cAliasPr)->GW1_TPFRET  :=  If(!Empty(aCampos[17]), aCampos[17], PADC( "",08,"_"))
		(cAliasPr)->GWN_CDTPVC  :=  If(!Empty(aCampos[18]), aCampos[18], PADC( "",10,"_"))
		(cAliasPr)->GV3_DSTPVC  :=  If(!Empty(aCampos[19]), aCampos[19], PADC( "",50,"_"))
		(cAliasPr)->GW_REDESP   :=  aCampos[20]
		(cAliasPr)->GW1_SERDC   :=  If(!Empty(aCampos[21]), aCampos[21], PADC( "",0,"_"))
		(cAliasPr)->GW1_NRDC    :=  If(!Empty(aCampos[22]), aCampos[22], PADC( "",05,"_"))
		(cAliasPr)->GW1_NRROM   :=  If(!Empty(aCampos[23]), aCampos[23], "0"             )
		(cAliasPr)->GW1_DTIMPL  :=  If(!Empty(aCampos[24]), aCampos[24], CtoD("01/01/1800"))
		(cAliasPr)->GW1_DTEMIS  :=  If(!Empty(aCampos[25]), aCampos[25], CtoD("01/01/1800"))
		(cAliasPr)->GW1_HRIMPL  :=  If(!Empty(aCampos[26]), aCampos[26], PADC( "",05,"_"))
		(cAliasPr)->GW1_DTSAI   :=  If(!Empty(aCampos[27]), aCampos[27], CtoD("01/01/1800"))
		(cAliasPr)->GW1_HRSAI   :=  If(!Empty(aCampos[28]), aCampos[28], PADC( "",05,"_"))
		(cAliasPr)->GWU_DTENT   :=  If(!Empty(aCampos[29]), aCampos[29], CtoD("01/01/1800"))
		(cAliasPr)->GWU_HRENT   :=  If(!Empty(aCampos[30]), aCampos[30], PADC( "",05,"_"))
		(cAliasPr)->GW1_DTPENT  :=  If(!Empty(aCampos[31]), aCampos[31], CtoD("01/01/1800"))
		(cAliasPr)->GW1_HRPENT  :=  If(!Empty(aCampos[32]), aCampos[32], PADC( "",05,"_"))
		(cAliasPr)->GW1_DTPSAI  :=  If(!Empty(aCampos[33]), aCampos[33], CtoD("01/01/1800"))
		(cAliasPr)->GW1_HRPSAI  :=  If(!Empty(aCampos[34]), aCampos[34], PADC( "",05,"_"))
		(cAliasPr)->TEMPOEFIC   :=  aCampos[35]
		(cAliasPr)->TEMPO       :=  aCampos[36]
		(cAliasPr)->TEMPOPREV   :=  aCampos[37]
		(cAliasPr)->TEMPOREAL   :=  aCampos[38]
		(cAliasPr)->TEMPOPRSAI  :=  aCampos[39]
		(cAliasPr)->GWN_CDTPOP  :=  If(!Empty(aCampos[40]), aCampos[40], PADC( "",10,"_"))
		(cAliasPr)->GV4_DSTPOP  :=  If(!Empty(aCampos[41]), aCampos[41], PADC( "",50,"_"))
		(cAliasPr)->PREVEXP		:=  aCampos[42]
		(cAliasPr)->PREVTOT		:=	aCampos[43]
		(cAliasPr)->REALTOT		:=	aCampos[44]
		(cAliasPr)->ATRTOT		:=	aCampos[45]
		(cAliasPr)->GWN_CDTRP   :=	If(!Empty(aCampos[46]), aCampos[46], PADC( "",14,"_"))
		(cAliasPr)->GWN_DSTRP   :=	If(!Empty(aCampos[47]), aCampos[47], PADC( "",50,"_"))
		(cAliasPr)->GW_CIDREM   :=	If(!Empty(aCampos[48]), aCampos[48], PADC( "",07,"_"))
		(cAliasPr)->GW_DSCIREM  :=	If(!Empty(aCampos[49]), aCampos[49], PADC( "",50,"_"))
		(cAliasPr)->GW_CDUFRE   :=	If(!Empty(aCampos[50]), aCampos[50], PADC( "",02,"_"))
	MsUnLock(cAliasPr)

    (cAliGW1N)->( dbSkip() )
EndDo
GFEDelTab(cAliGW1N)

Return cAliasPr
