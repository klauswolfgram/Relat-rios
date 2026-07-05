/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR810.ch"
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'REPORT.CH'

//------------------------------------------------------------------------------
/*{Protheus.doc} TECR810
	Relatório TReport para impressão da Fatura da Locação 

@sample 	U_TECR810() 
@since		30/12/2013       
@version	P12   
*/
//------------------------------------------------------------------------------
User Function TECR810()

Local oReport := Nil
Local oCabec  := Nil
Local oItens  := Nil

Private cQryRep810 := ''
Private cPerg := 'TECR810'

Pergunte('TECR810',.F.)

DEFINE REPORT oReport NAME 'TECR810' TITLE STR0001 PARAMETER 'TECR810' ACTION {|oReport| PrintReport(oReport)} //"Fatura da Locação"
	
	oReport:HideParamPage()  // inibe a impressão da página de parâmetros
	DEFINE SECTION oCabec OF oReport TITLE STR0001 TABLE 'SM0', 'SE1', 'TFJ', 'ABS', 'SA1', 'TFI','SA4', 'SF2' LINE STYLE COLUMNS 3 //"Fatura da Locação"

		DEFINE CELL NAME 'E1_NUM' OF oCabec TITLE STR0002 ALIAS 'SE1' ; //"Fatura de Serviço"
			SIZE TamSX3('E1_NUM')[1] BLOCK { |oCell| RetTit(1) }
		DEFINE CELL NAME 'F2_EMISSAO' OF oCabec ALIAS 'SF2'
		DEFINE CELL NAME 'NATUREZA' OF oCabec TITLE STR0003 ; //"Natureza Operação"
			SIZE 23 BLOCK ( { |oCell| STR0004 } ) //"Locação de Equipamentos"
		DEFINE CELL NAME 'A1_NOME'    OF oCabec TITLE STR0005 ALIAS 'SA1' ; //"Cliente"
			SIZE TamSX3('A1_NOME')[1]+TamSX3('A1_COD')[1]+TamSX3('A1_LOJA')[1] + 7 ;
			BLOCK {|oCell| (cQryRep810)->TFJ_CODENT+'-'+(cQryRep810)->TFJ_LOJA+'/'+(cQryRep810)->A1_NOME}
		DEFINE CELL NAME 'ABS_END' OF oCabec TITLE STR0006 ALIAS 'ABS' ; //"Endereço"
			SIZE TamSX3('ABS_END')[1] + TamSX3('ABS_BAIRRO')[1] + 3 ;
			BLOCK { |oCell| RTrim((cQryRep810)->ABS_END) + '-' + (cQryRep810)->ABS_BAIRRO }
		DEFINE CELL NAME 'ABS_MUNIC' OF oCabec ALIAS 'ABS'
		DEFINE CELL NAME 'ABS_ESTADO' OF oCabec ALIAS 'ABS'
		DEFINE CELL NAME 'ABS_CEP' OF oCabec ALIAS 'ABS'
		DEFINE CELL NAME 'A1_CGC'     OF oCabec ALIAS 'SA1'
		DEFINE CELL NAME 'A1_INSCR' OF oCabec ALIAS 'SA1'
		DEFINE CELL NAME 'TFJ_CONDPG' OF oCabec ALIAS 'TFJ'
		//---------------- segunda parte das informações
		DEFINE CELL NAME 'TFI_CONTRT'   OF oCabec ALIAS 'TFI' ;
			SIZE TamSX3('TFI_CONTRT')[1] BLOCK { | oCell | (cQryRep810)->TFI_CONTRT }
		DEFINE CELL NAME 'PERIODO' OF oCabec TITLE STR0014 ALIAS 'TFI' ;			 //"Período"
			SIZE  TamSX3('TFI_PERINI')[1]+TamSX3('TFI_PERFIM')[1]+7 ;
			BLOCK { |oCell| DTOC((cQryRep810)->TFI_PERINI)+'-'+DTOC((cQryRep810)->TFI_PERFIM) }
		DEFINE CELL NAME 'OBSERV' OF oCabec TITLE STR0015 SIZE 80 //"Observações"
		DEFINE CELL NAME 'OBSERV_2' OF oCabec TITLE STR0016 SIZE 80 //"Cont.Obs."
		DEFINE CELL NAME 'F2_TRANSP' OF oCabec TITLE STR0017 ALIAS 'SF2'; //"Transportadora"
			SIZE TamSX3('F2_TRANSP')[1] + TamSX3('A4_NOME')[1] + 3 ;
			BLOCK { | oCell | (cQryRep810)->((cQryRep810)->F2_TRANSP+'-'+(cQryRep810)->A4_NOME) }
		DEFINE CELL NAME 'F2_FRETE' OF oCabec TITLE STR0018 ALIAS 'SF2' //"Valor do Frete"
		
oReport:PrintDialog()

Return 

//------------------------------------------------------------------------------
/*{Protheus.doc} PrintReport
	Função que faz o controle de impressão do relatório 

@sample 	U_TECR810() 

@since		30/12/2013       
@version	P12   

@param  	oReport, Objeto, objeto da classe TReport para construção da consulta
	de busca e impressão dos dados 
*/
//------------------------------------------------------------------------------
Static Function PrintReport(oReport)

Local oCabec  := oReport:Section(1)
Local oItens  := Nil
Local cSeq	:= '0000'
cQryRep810 := GetNextAlias()

MakeSqlExp('TECR810')
		// DEFINE OS CAMPOS DOS ITENS SOMENTE DURANTE A EXECUCAO
		If mv_par04 == 1 //Analitico

			DEFINE SECTION oItens OF oCabec TITLE STR0007 TABLE 'TFI', 'SB1' LEFT MARGIN 20 //"Itens da Nota"
		
				DEFINE CELL NAME 'TFI_COD'   OF oItens TITLE STR0008 ALIAS 'TFI' //"Item"
				DEFINE CELL NAME 'B1_UM'    OF oItens TITLE STR0009 ALIAS 'TFI' //"Un."
				DEFINE CELL NAME 'B1_DESC'   OF oItens ALIAS 'SB1'
				DEFINE CELL NAME 'TFI_QTDVEN' OF oItens TITLE STR0010 ALIAS 'TFI' //"Quant."
				DEFINE CELL NAME 'UNIT' OF oItens TITLE STR0011 PICTURE PesqPict('TFI','TFI_TOTAL') ; //"Unit."
					BLOCK { |oCell| (cQryRep810)->TFI_TOTAL / (cQryRep810)->TFI_QTDVEN } ALIAS 'TFI' 
				DEFINE CELL NAME 'TFI_VALDES' OF oItens TITLE STR0012 ALIAS 'TFI' //"Desconto"
				DEFINE CELL NAME 'TFI_TOTAL' OF oItens TITLE STR0013 ALIAS 'TFI' //"Total"
				
				
			
			oSum := TRFunction():New(oItens:Cell("TFI_TOTAL" )	, ,"SUM", , , , , .F. ,)
			oSum:SetEndSection(.T.)
			oSum:SetEndReport(.F.)
		
		 DEFINE SECTION oItens2 OF oItens TITLE "Itens da Medição" TABLE 'TFZ','TFI', 'SB1' LEFT MARGIN 20 //"Itens da Nota"	
			oItens2:SetLineBreak()
			
			DEFINE CELL NAME 'Mod' OF oItens2 TITLE 'Mod. Cobrança' SIZE(20);
					 BLOCK { |oCell| Tecr810Mod((cQryRep810)->TFZ_MODCOB) } //'Mod. Cobrança'
			DEFINE CELL NAME 'TFZ_QTDAPU' OF oItens2 TITLE "Qtd. Apuração" ALIAS 'TFZ' //"Qtd. Apuração"
			DEFINE CELL NAME 'TFZ_VLRUNI' OF oItens2 TITLE "Vlr. Uni. Medição" ALIAS 'TFZ' //"Vlr. Uni. Medição"
			DEFINE CELL NAME 'TFZ_TOTAL' OF oItens2 TITLE "Total Medição" ALIAS 'TFZ' //"Total Medição"
			
		Else

			DEFINE SECTION oItens OF oCabec TITLE STR0007 TABLE 'TFI','SB1','TFZ' LEFT MARGIN 20 //"Itens da Nota"
		
				DEFINE CELL NAME 'ITEM'   OF oItens TITLE STR0008 ; //"Item"
					SIZE 4 BLOCK { |oCell| cSeq }
				DEFINE CELL NAME 'B1_UM'    OF oItens TITLE STR0009 ALIAS 'TFI' //"Un."
				DEFINE CELL NAME 'B1_DESC'   OF oItens ALIAS 'SB1'
				DEFINE CELL NAME 'TFI_QTDVEN' OF oItens TITLE STR0010 BLOCK { |oCell| 1 } ALIAS 'TFI' //"Quant."
				DEFINE CELL NAME 'TFZ_TOTAL' OF oItens TITLE STR0011 ALIAS 'TFI' //"Unit."
				DEFINE CELL NAME 'TFI_VALDES' OF oItens TITLE STR0012 ALIAS 'TFI' //"Desconto"
				DEFINE CELL NAME 'TFZ_TOTAL' OF oItens TITLE STR0013 ALIAS 'TFI' //"Total"
			
			oSum := TRFunction():New(oItens:Cell("TFZ_TOTAL" )	, ,"SUM", , , , , .F. ,)
			oSum:SetEndSection(.T.)
			oSum:SetEndReport(.F.)
			
			oItens:bOnPrintLine   := {|oSection| cSeq := Soma1(cSeq) } // adiciona o documento impresso no array para validação posterior		
		
		EndIf

If mv_par04 == 1 // é analítico?
	// consulta das informações para relatório analítico
	BEGIN REPORT QUERY oReport:Section(1)
	
	BeginSql alias cQryRep810
		
		COLUMN TFI_PERINI AS DATE
		COLUMN TFI_PERFIM AS DATE
		COLUMN F2_EMISSAO AS DATE
		
		SELECT TFI_PERINI, TFI_PERFIM, TFI_CONTRT, TFI_TOTAL, TFI_COD, TFI_QTDVEN, TFI_VALDES 
			, A1_NOME, A1_CGC, A1_INSCR, B1_DESC, B1_UM, ABS_MUNIC, ABS_BAIRRO, ABS_END, ABS_CEP
			, TFJ_CONDPG, TFJ_CODENT, TFJ_LOJA, F2_DOC, F2_TRANSP, F2_FRETE, F2_EMISSAO, A4_NOME, CNE_ITEM, CNE_PEDTIT,
			TFZ_MODCOB,TFZ_QTDAPU,TFZ_VLRUNI,TFZ_TOTAL
			
		FROM %Table:TFZ% TFZ
		        INNER JOIN %Table:TFI% TFI ON TFI.TFI_FILIAL = %xFilial:TFI% AND TFI.TFI_COD = TFZ.TFZ_CODTFI AND TFI.%NotDel%
		                                 AND TFI.TFI_CONTRT = %Exp:mv_par01% AND TFI.TFI_CONREV = %Exp:mv_par02%
		        INNER JOIN %Table:ABS% ABS ON ABS.ABS_FILIAL = %xFilial:ABS% AND ABS.ABS_LOCAL = TFI.TFI_LOCAL AND ABS.%NotDel%
		        INNER JOIN %Table:TFL% TFL ON TFL.TFL_FILIAL = %xFilial:TFL% AND TFL.TFL_CODIGO = TFI.TFI_CODPAI AND TFL.%NotDel%
		        INNER JOIN %Table:TFJ% TFJ ON TFJ.TFJ_FILIAL = %xFilial:TFJ% AND TFJ.TFJ_CODIGO = TFL.TFL_CODPAI AND TFJ.TFJ_CONTRT = TFI.TFI_CONTRT
		                                 AND TFJ.TFJ_CONREV = TFI.TFI_CONREV AND TFJ.%NotDel%
		        INNER JOIN %Table:SB1% SB1 ON SB1.B1_FILIAL = %xFilial:SB1% AND SB1.B1_COD = TFI.TFI_PRODUT AND SB1.%NotDel%
		        INNER JOIN %Table:SA1% SA1 ON SA1.A1_FILIAL = %xFilial:SA1% AND SA1.A1_COD = TFJ.TFJ_CODENT AND SA1.A1_LOJA = TFJ.TFJ_LOJA
		                                 AND SA1.%NotDel%
		        INNER JOIN %Table:CNE% CNE ON CNE.CNE_FILIAL = %xFilial:CNE% AND CNE.CNE_NUMMED = TFZ.TFZ_NUMMED AND CNE.%NotDel% 
		        INNER JOIN %Table:SC5% SC5 ON SC5.C5_FILIAL = %xFilial:SC5% AND SC5.C5_MDNUMED = TFZ.TFZ_NUMMED AND SC5.%NotDel%
		        INNER JOIN %Table:SC6% SC6 ON SC6.C6_FILIAL = %xFilial:SC6% AND SC6.C6_NUM = SC5.C5_NUM AND SC6.%NotDel%
		        LEFT OUTER JOIN %Table:SF2% SF2 ON SF2.F2_FILIAL = %xFilial:SF2% AND SF2.F2_DOC = SC6.C6_NOTA AND SF2.F2_SERIE = SC6.C6_SERIE 
		                                 AND SF2.F2_CLIENTE = SC6.C6_CLI AND SF2.F2_LOJA = SC6.C6_LOJA AND SF2.%NotDel%
		        LEFT OUTER JOIN %Table:SA4% SA4 ON SA4.A4_FILIAL = %xFilial:SA4% AND SA4.A4_COD = SF2.F2_TRANSP AND SA4.%NotDel%
		        
		WHERE   TFZ.TFZ_FILIAL = %xFilial:TFZ% AND TFZ.TFZ_NUMMED = %Exp:mv_par03% AND TFZ.%NotDel%
		
		GROUP BY TFI_PERINI, TFI_PERFIM, TFI_CONTRT, TFI_TOTAL, TFI_COD, TFI_QTDVEN, TFI_VALDES, A1_NOME,
		        A1_CGC, A1_INSCR, B1_DESC, B1_UM, ABS_MUNIC, ABS_BAIRRO, ABS_END, ABS_CEP, TFJ_CONDPG,
		        TFJ_CODENT, TFJ_LOJA, F2_DOC, F2_TRANSP, F2_FRETE, F2_EMISSAO, A4_NOME, CNE_ITEM,
		        CNE_PEDTIT, TFZ_MODCOB,TFZ_QTDAPU,TFZ_VLRUNI,TFZ_TOTAL
	EndSql
	
	END REPORT QUERY oReport:Section(1)
	
Else
	// consulta das informações para relatório sintético
	BEGIN REPORT QUERY oReport:Section(1)
	
	BeginSql alias cQryRep810
	
		COLUMN TFI_PERINI AS DATE
		COLUMN TFI_PERFIM AS DATE
		COLUMN F2_EMISSAO AS DATE

		SELECT  TFI_PERINI ,TFI_PERFIM ,TFI_CONTRT ,SUM(TFZ_TOTAL) TFZ_TOTAL , TFI_QTDVEN ,A1_NOME ,A1_CGC ,
		        A1_INSCR ,B1_DESC ,B1_UM ,ABS_MUNIC ,ABS_BAIRRO ,ABS_END ,ABS_CEP ,TFJ_CONDPG ,TFJ_CODENT ,TFJ_LOJA ,
		        F2_DOC ,F2_TRANSP ,F2_FRETE ,F2_EMISSAO ,A4_NOME ,CNE_ITEM ,CNE_PEDTIT
		FROM %Table:TFZ% TFZ
		        INNER JOIN %Table:TFI% TFI ON TFI.TFI_FILIAL = %xFilial:TFI% AND TFI.TFI_COD = TFZ.TFZ_CODTFI AND TFI.%NotDel%
		                                 AND TFI.TFI_CONTRT = %Exp:mv_par01% AND TFI.TFI_CONREV = %Exp:mv_par02%
		        INNER JOIN %Table:ABS% ABS ON ABS.ABS_FILIAL = %xFilial:ABS% AND ABS.ABS_LOCAL = TFI.TFI_LOCAL AND ABS.%NotDel%
		        INNER JOIN %Table:TFL% TFL ON TFL.TFL_FILIAL = %xFilial:TFL% AND TFL.TFL_CODIGO = TFI.TFI_CODPAI AND TFL.%NotDel%
		        INNER JOIN %Table:TFJ% TFJ ON TFJ.TFJ_FILIAL = %xFilial:TFJ% AND TFJ.TFJ_CODIGO = TFL.TFL_CODPAI AND TFJ.TFJ_CONTRT = TFI.TFI_CONTRT
		                                 AND TFJ.TFJ_CONREV = TFI.TFI_CONREV AND TFJ.%NotDel%
		        INNER JOIN %Table:SB1% SB1 ON SB1.B1_FILIAL = %xFilial:SB1% AND SB1.B1_COD = TFJ.TFJ_GRPLE AND SB1.%NotDel%
		        INNER JOIN %Table:SA1% SA1 ON SA1.A1_FILIAL = %xFilial:SA1% AND SA1.A1_COD = TFJ.TFJ_CODENT AND SA1.A1_LOJA = TFJ.TFJ_LOJA
		                                 AND SA1.%NotDel%
		        INNER JOIN %Table:CNE% CNE ON CNE.CNE_FILIAL = %xFilial:CNE% AND CNE.CNE_NUMMED = TFZ.TFZ_NUMMED AND CNE.%NotDel% 
		        INNER JOIN %Table:SC5% SC5 ON SC5.C5_FILIAL = %xFilial:SC5% AND SC5.C5_MDNUMED = TFZ.TFZ_NUMMED AND SC5.%NotDel%
		        INNER JOIN %Table:SC6% SC6 ON SC6.C6_FILIAL = %xFilial:SC6% AND SC6.C6_NUM = SC5.C5_NUM AND SC6.%NotDel%
		        LEFT OUTER JOIN %Table:SF2% SF2 ON SF2.F2_FILIAL = %xFilial:SF2% AND SF2.F2_DOC = SC6.C6_NOTA AND SF2.F2_SERIE = SC6.C6_SERIE 
		                                 AND SF2.F2_CLIENTE = SC6.C6_CLI AND SF2.F2_LOJA = SC6.C6_LOJA AND SF2.%NotDel%
		        LEFT OUTER JOIN %Table:SA4% SA4 ON SA4.A4_FILIAL = %xFilial:SA4% AND SA4.A4_COD = SF2.F2_TRANSP AND SA4.%NotDel%
		        
		WHERE   TFZ.TFZ_FILIAL = %xFilial:TFZ% AND TFZ.TFZ_NUMMED = %Exp:mv_par03% AND TFZ.%NotDel%
		
		GROUP BY TFI_PERINI ,TFI_PERFIM ,TFI_CONTRT ,TFI_QTDVEN ,A1_NOME ,A1_CGC ,A1_INSCR ,
		        B1_DESC ,B1_UM ,ABS_MUNIC ,ABS_BAIRRO ,ABS_END ,ABS_CEP ,TFJ_CONDPG ,TFJ_CODENT ,TFJ_LOJA ,
		        F2_DOC ,F2_TRANSP ,F2_FRETE ,F2_EMISSAO ,A4_NOME ,CNE_ITEM ,CNE_PEDTIT
	
	EndSql
	
	END REPORT QUERY oReport:Section(1)

EndIf

oItens := oCabec:Section(1)  // Itens da Nota Fiscal
oItens:SetParentQuery()
oItens:SetParentFilter( {|cParam| (cQryRep810)->(F2_DOC)==cParam},{|| (cQryRep810)->(F2_DOC)} )

oReport:Section(1):Print()

Return

//-----------------------------------------
Static Function RetTit(nTipo)

Local xRet := If(nTipo==1,'',ctod(''))
Local aArea := GetArea()
Local cAliasQry := GetNextAlias()
Local cQuery := ''
Local cCampo := If(nTipo==1,'E1_NUM','E1_EMISSAO')


If (cQryRep810)->CNE_PEDTIT == '1' 

	cQuery := "Select " + cCampo + " "
	cQuery += "From " + RetSqlName('SE1') + " SE1 "
	cQuery += "Inner Join " + RetSqlName('SC6') + " SC6 "
	cQuery += "On C6_FILIAL = '" + xFilial('SC6') + "' "
	cQuery += "And C6_NOTA = E1_NUM "
	cQuery += "And C6_ITEMED = '" + (cQryRep810)->CNE_ITEM + "' "
	cQuery += "And SC6.D_E_L_E_T_ = ' ' "
	cQuery += "Inner Join " + RetSqlName('SC5') + " SC5 "
	cQuery += "On C5_FILIAL = '" + xFilial('SC5') + "' "
	cQuery += "And C5_NUM = C6_NUM "
	cQuery += "And C5_MDNUMED = '" + mv_par03 + "' "
	cQuery += "And SC5.D_E_L_E_T_ = ' ' "
	cQuery += "Where E1_FILIAL = '" + xFilial('SE1') + "' "
	cQuery += "And E1_PREFIXO = '" + GetNewPar('MV_CNPREMD') + "' "
	cQuery += "And E1_TIPO = '" + GetNewPar('MV_CNTPTMD') + "' "
	cQuery += "And E1_NATUREZ = '" + GetNewPar('MV_CNNATMD') + "' "
	cQuery += "And SE1.D_E_L_E_T_ = ' '"

Else

	cQuery := "Select " + cCampo + " "
	cQuery += "From " + RetSqlName('SE1') + " SE1 "
	cQuery += "Inner Join " + RetSqlName('CND') + " CND "
	cQuery += "On CND_FILIAL = '" + xFilial('CND') + "' "
	cQuery += "And CND_NUMTIT = E1_NUM "
	cQuery += "And CND_NUMMED = '" + mv_par03 + "' "
	cQuery += "And CND.D_E_L_E_T_ = ' ' "
	cQuery += "Where E1_FILIAL = '" + xFilial('SE1') + "' "
	cQuery += "And E1_PREFIXO = '" + GetNewPar('MV_CNPREMD') + "' "
	cQuery += "And E1_TIPO = '" + GetNewPar('MV_CNTPTMD') + "' "
	cQuery += "And E1_NATUREZ = '" + GetNewPar('MV_CNNATMD') + "' "
	cQuery += "And SE1.D_E_L_E_T_ = ' '"
	
	cQuery := ChangeQuery(cQuery)

EndIf
	
cQuery := ChangeQuery(cQuery)

If Select(cAliasQry) > 0
	(cAliasQry)->(DbCloseArea())
EndIf

DbUseArea(.T., "TOPCONN",TcGenQry(,,cQuery), cAliasQry, .T., .T.)

If nTipo == 2
	TcSetField(cAliasQry,cCampo,'D',8,0)
EndIf

If !(cAliasQry)->(Eof())

	xRet := (cAliasQry)->&(cCampo)

EndIf

(cAliasQry)->(DbCloseArea())

RestArea(aArea)

Return xRet

//------------------------------------------------------------------------------
/*{Protheus.doc} Tecr810Mod
	Função para retorno do modo de cobrança

@sample 	Tecr810Mod(cMod) 
@since		02/08/2017    
@version	P12   
*/
//------------------------------------------------------------------------------
Static Function Tecr810Mod(cMod)
Local cDesc	:= ""

Do Case

Case cMod == "1"
	cDesc = "Uso"
	
Case cMod == "2"
	cDesc := "Disponibilidade"
	
Case cMod == "3" 
	cDesc := "Mobilização" 
	
Case cMod == "4"
	cDesc := "Horas" 
	
Case cMod == "5" 
	cDesc := "Franquia/Excedente"

EndCase

Return cDesc