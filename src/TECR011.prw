/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "protheus.ch"
#INCLUDE 'FWMVCDEF.CH'

#DEFINE QTD_ATIVO		1
#DEFINE QTD_LOCADO	2
#DEFINE QTD_RESERVA	3
#DEFINE QTD_MANUT		4
#DEFINE QTD_BLOQ		5
#DEFINE QTD_DISPLOC	6

STATIC cPerg := "TECR011"

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} TECR011
Relatorio do tipo R4, que permite a impressao dos itens de locação da base de atendimento
exibindo seus saldos
@author  Cesar A. Bianchi
@version P12
@since 	 13/09/2016
@return 
/*/
//-------------------------------------------------------------------------------------
User Function TECR011()
	U_TECR011()
Return

User Function TECR011()
	Local oReport
    
    If TRepInUse() 
		Pergunte(cPerg,.F.)	
		oReport := RepInit() 
		oReport:SetLandScape()
		oReport:PrintDialog()	
	EndIf
	
Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} RepInit
Função responsavel por elaborar o layout do relatorio a ser impresso
@author  Cesar A. Bianchi
@version P12
@since 	 13/09/2016
@return 
/*/
//-------------------------------------------------------------------------------------
Static Function RepInit()
	Local oReport
	Local oSection1

	//Instancia Objeto do Relatorio
	oReport := TReport():New("REL001","Saldos Base Locação x Ativo Fixo",cPerg,{|oReport| PrintReport(oReport)},"Saldos Base Locação x Ativo Fixo")
	oSection1 := TRSection():New(oReport	,"Bases de Atendimento"		,{"AA3","SB1","SB5","SN1","SBM","TWH"})
	
	//Define as Celulas do Relatorio
	//TRCell():New(Secao,NomeCel,Alias,X3Titulo,Picture,Tamanho,lPixel,{|| code-block de impressao})
	TRCell():New(oSection1,"AA3_NUMSER"	,"AA3") 
	TRCell():New(oSection1,"AA3_CODPRO"	,"AA3")
	TRCell():New(oSection1,"B1_DESC"		,"SB1")
	TRCell():New(oSection1,"AA3_MANPRE"	,"AA3")
	TRCell():New(oSection1,"AA3_EXIGNF"	,"AA3")
	TRCell():New(oSection1,"AA3_EQ3"		,"AA3")
	TRCell():New(oSection1,"AA3_OSMONT"	,"AA3")	
	TRCell():New(oSection1,"AA3_FILORI"	,"AA3")
	TRCell():New(oSection1,"AA3_QTDATF"	,"AA3")	
	TRCell():New(oSection1,"AA3_SLDLOC"	,"AA3")
	TRCell():New(oSection1,"AA3_SLDRES"	,"AA3")
	TRCell():New(oSection1,"AA3_SLDMAN"	,"AA3")
	TRCell():New(oSection1,"AA3_SLDBLQ"	,"AA3")
	TRCell():New(oSection1,"AA3_SLDDIS"	,"AA3")
		
Return oReport

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
Função responsavel por selecionar e pintar os dados (registros) no relatorio
respectivos apontamentos realizados
@author  Cesar A. Bianchi
@version P12
@since 	 13/09/2017
@return 
/*/
//-------------------------------------------------------------------------------------
Static Function PrintReport(oReport)
	Local oSection1 := oReport:Section(1)
	Local cWhere
	                           	                       
    //Monta a clausula "Where" com os MV_PARs
	cWhere := "% "
	cWhere += " AND AA3.AA3_NUMSER BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "'"			//Base De Atendimento De/Ate
	cWhere += " AND SB1.B1_COD BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "'"				//Produto De/Ate
	cWhere += " AND SBM.BM_GRUPO BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "'"				//Grupo De/Ate
	cWhere += " AND SN1.N1_CBASE  BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "'"				//Ativo De/Ate
	cWhere += " %"
                 
	//Busca os dados da Secao principal
	oSection1:BeginQuery()
	BeginSql alias "QRY_01"	
		SELECT DISTINCT AA3.AA3_NUMSER, AA3.AA3_CODPRO, SB1.B1_DESC, AA3.AA3_MANPRE, AA3.AA3_EXIGNF,
		  AA3.AA3_EQ3, AA3.AA3_OSMONT, AA3.AA3_FILORI 
		FROM %table:AA3% AA3, %table:SB1% SB1, %table:SB5% SB5, %table:SBM% SBM, %table:SN1% SN1, %table:TWH% TWH   
			WHERE 
				AA3.AA3_FILIAL = %xfilial:AA3%
				AND TWH.TWH_FILIAL = %xfilial:TWH%
				AND SB1.B1_FILIAL = AA3.AA3_FILORI
				AND SB5.B5_FILIAL = SB1.B1_FILIAL
				AND SBM.BM_FILIAL = SB1.B1_FILIAL
				AND SN1.N1_FILIAL = TWH.TWH_FILORI
				AND TWH.TWH_FILORI = AA3.AA3_FILORI
				
				AND AA3.AA3_CODPRO = SB1.B1_COD 
				AND SB1.B1_COD = SB5.B5_COD 
				AND AA3.AA3_NUMSER = TWH.TWH_BASE
				AND SN1.N1_CBASE = TWH.TWH_ATVCBA
				AND SN1.N1_ITEM = TWH.TWH_ATVITE	
				AND SB1.B1_GRUPO = SBM.BM_GRUPO				
				%Exp:cWhere%				
				AND AA3.D_E_L_E_T_ = ' '
				AND SB1.D_E_L_E_T_ = ' '
				AND SB5.D_E_L_E_T_ = ' '
				AND SBM.D_E_L_E_T_ = ' '
				AND SN1.D_E_L_E_T_ = ' '
				AND TWH.D_E_L_E_T_ = ' '
				
	EndSql	
	oSection1:EndQuery()
             
	//Pinta o Relatorio
	While QRY_01->(!Eof())		
        //Se nivel detalhe
      	oSection1:Init()
      	
      	//Preenche celulas de campos virtuais
		oSection1:Cell("AA3_QTDATF"):SetBlock( {|| GetSldBase(QRY_01->AA3_NUMSER , QTD_ATIVO, .T.) } )
		oSection1:Cell("AA3_SLDLOC"):SetBlock( {|| GetSldBase(QRY_01->AA3_NUMSER , QTD_LOCADO, .T.) } )
		oSection1:Cell("AA3_SLDRES"):SetBlock( {|| GetSldBase(QRY_01->AA3_NUMSER , QTD_RESERVA, .T.) } )
		oSection1:Cell("AA3_SLDMAN"):SetBlock( {|| GetSldBase(QRY_01->AA3_NUMSER , QTD_MANUT, .T.) } )
		oSection1:Cell("AA3_SLDBLQ"):SetBlock( {|| GetSldBase(QRY_01->AA3_NUMSER , QTD_BLOQ, .T.) } )
		oSection1:Cell("AA3_SLDDIS"):SetBlock( {|| GetSldBase(QRY_01->AA3_NUMSER , QTD_DISPLOC, .T.) } )		
		oSection1:PrintLine()
		QRY_01->(dbSkip())						
	EndDo
	
	//Finaliza a impressão
	oSection1:Finish()
	
Return