/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'REPORT.CH'
#INCLUDE 'PONR150.CH'

/*/{Protheus.doc} PONR150
 Relatório de Espelhos Não Baixados
@author PHILIPE.POMPEU
@since 08/04/2015
@version P12
@return Nil, Valor Nulo
/*/
User Function PONR150()
	Local	aArea 	:= GetArea()
	Local	oReport:= Nil
	
	oReport := ReportDef()
	
	if(oReport <> Nil)
		oReport:PrintDialog()
	endIf
	
	oReport := Nil
	RestArea(aArea)	
Return Nil


/*/{Protheus.doc} GetReport
 Retorna um objeto da Classe TReport utilizado na impressão do relatório;
 Define o título, o Pergunte utilizado e as seções do relatório;
@author PHILIPE.POMPEU
@since 08/04/2015
@version P12
@return oReport, Instância da Classe TReport
/*/
Static Function ReportDef()	
	Local oReport	:= Nil
	Local oSecFil	:= Nil
	Local oSecCab		:= Nil
	Local oSecItems	:= Nil
	Local cRptTitle	:= OemToAnsi(STR0001) //"Relatório de Espelhos Não Baixados"
	Local cRptDescr	:= OemToAnsi(STR0002) //"Este programa emite a Impressão do Relatório de Espelhos Não Baixados."
	Local aOrderBy	:= {}
	Local cNomePerg	:=	"PONR150"
	Local cMyAlias	:= GetNextAlias()		
	
	aAdd(aOrderBy, OemToAnsi(STR0003))//'1 - Filial + Departamento + Funcionário'
	aAdd(aOrderBy, OemToAnsi(STR0004))//'2 - Filial + Responsável + Departamento'
	aAdd(aOrderBy, OemToAnsi(STR0005))//'3 - Filial + Centro de Custo + Funcionário'
	
	Pergunte(cNomePerg,.F.)
	
	DEFINE REPORT oReport NAME "PONR150" TITLE cRptTitle PARAMETER cNomePerg ACTION {|oReport| PrintReport(oReport,cNomePerg,cMyAlias)} DESCRIPTION cRptDescr	TOTAL IN COLUMN

	DEFINE SECTION oSecFil OF oReport TITLE cRptTitle 	TABLES "SQB","SRA" TOTAL IN COLUMN ORDERS aOrderBy 
		DEFINE CELL NAME "RA_FILIAL" 	OF 	oSecFil ALIAS "SRA"		
	
	DEFINE SECTION oSecCab OF oSecFil 	TITLE '' TABLES "SQB","SRA","CTT" TOTAL IN COLUMN
		DEFINE CELL NAME "RA_DEPTO" 	OF 	oSecCab ALIAS "SRA" 
		DEFINE CELL NAME "QB_DESCRIC" 	OF 	oSecCab ALIAS "SQB" 
		DEFINE CELL NAME "RA_CC" 		OF 	oSecCab ALIAS "SRA"  
		DEFINE CELL NAME "CTT_DESC01" 	OF 	oSecCab ALIAS "CTT" 
		DEFINE CELL NAME "QB_MATRESP" 	OF 	oSecCab ALIAS "SQB" 
		DEFINE CELL NAME "NOMRESP" 		OF 	oSecCab TITLE OemToAnsi(STR0006) //'Nome Responsável'
			
	DEFINE SECTION oSecItems OF oSecCab TITLE OemToAnsi(STR0001) 	TABLES "RS4","SRA","CTT","SQB"	TOTAL IN COLUMN			
		DEFINE CELL NAME "RA_DEPTO" 	OF 	oSecItems ALIAS "SRA" 
		DEFINE CELL NAME "QB_DESCRIC" 	OF 	oSecItems ALIAS "SQB" 
		DEFINE CELL NAME "QB_MATRESP" 	OF 	oSecItems ALIAS "SQB" 
		DEFINE CELL NAME "NOMRESP" 		OF 	oSecItems TITLE OemToAnsi(STR0006)
		DEFINE CELL NAME "RA_CC" 		OF 	oSecItems ALIAS "SRA" 
		DEFINE CELL NAME "CTT_DESC01" 	OF 	oSecItems ALIAS "CTT" 
		DEFINE CELL NAME "RS4_MAT" 		OF 	oSecItems ALIAS "RS4" 
		DEFINE CELL NAME "RA_NOME" 		OF 	oSecItems ALIAS "SRA" 
		DEFINE CELL NAME "RA_EMAIL" 	OF 	oSecItems SIZE 35 ALIAS "SRA" 
		
		DEFINE CELL NAME "RA_TELEFON" 	OF 	oSecItems BLOCK {||FormatTel((cMyAlias)->RA_DDDFONE,(cMyAlias)->RA_TELEFON)} ALIAS "SRA"
		DEFINE CELL NAME "RS4_DATAI" 	OF 	oSecItems SIZE 18 ALIAS "RS4"
		DEFINE CELL NAME "RS4_DATAF" 	OF 	oSecItems SIZE 18 ALIAS "RS4"
		DEFINE CELL NAME "OBSERVACAO" 	OF 	oSecItems SIZE 50 TITLE OemToAnsi(STR0014) BLOCK {||MSMM((cMyAlias)->RS4_CODOBS,Nil,Nil,,3,,,"RS4","RS_CODOBS")} 
			
Return oReport


/*/{Protheus.doc} PrintReport
	Define a consulta à ser executada e as quebras do relatório;
	Imprime o relatório;
@author PHILIPE.POMPEU
@since 08/04/2015
@version P12
@param oReport, objeto, Instância da Classe TReport que será impresso
@param cNomePerg, caractere, Nome do Grupo de Perguntas utilizado no relatório
@param cMyAlias, caractere, Alias à ser utilizado
@return Nil, Valor Nulo
/*/
Static Function PrintReport(oReport, cNomePerg, cMyAlias)
	Local oSecFil		:= oReport:Section(1)
	Local nOrderBy	:= oSecFil:GetOrder()
	Local oSecCab		:= oSecFil:Section(1)
	Local oSecItems	:= oSecCab:Section(1)	
	Local oSecResp	:= Nil	
	Local oBreakFil	:= Nil
	Local oBreakUni	:= Nil
	Local oBreakEmp	:= Nil
	Local oBreakCab	:= Nil
	Local oBreakItems	:= Nil
	Local cTitFil		:= ''
	Local cTitUniNeg	:= ''
	Local cTitEmp		:= ''
	Local cTitCab		:= ''
	Local cTitItems	:= ''
	Local cOrderBy	:= ''
	Local aTemp := {}
	Local cJoinResp	:= IIF(nOrderBy == 2, '%INNER%', '%LEFT%')
	Local cJoinCC 	:= IIF(nOrderBy == 3, '%INNER%', '%LEFT%')
	Local cJoinRAQB	:= GetJoin( "SQB", "SRA", "%" )
	Local cJoinRACT	:= GetJoin( "CTT", "SRA", "%" )
	Local lCorpManage	:= fIsCorpManage( FWGrpCompany() )	// Verifica se o cliente possui Gestão Corporativa no Grupo Logado
	Local cLayoutGC 	:= ''
	Local nStartEmp	:= 0
	Local nStartUnN	:= 0
	Local nEmpLength	:= 0
	Local nUnNLength	:= 0
	Local cDataDeAte	:= ''
	Default cMyAlias	:= GetNextAlias()	
	
	If lCorpManage
		cLayoutGC 	:= FWSM0Layout(cEmpAnt)
		nStartEmp	:= At("E",cLayoutGC)
		nStartUnN	:= At("U",cLayoutGC)
		nEmpLength	:= Len(FWSM0Layout(cEmpAnt, 1))
		nUnNLength	:= Len(FWSM0Layout(cEmpAnt, 2))	
	EndIf
		
	cOrderBy := GetOrderBy(nOrderBy)
	
	MakeSqlExpr(cNomePerg)
	
	MV_PAR01 := StrTran(MV_PAR01, 'RA_', 'SRA.RA_')
	MV_PAR02 := StrTran(MV_PAR02, 'RA_', 'SRA.RA_')
	cDataDeAte:= "(RS4_DATAI >= '"+ DtoS(MV_PAR06) +"' AND RS4_DATAF <= '"+ DtoS(MV_PAR07) +"')"
	 
	BEGIN REPORT QUERY oSecFil	
	
	BeginSql alias cMyAlias
		COLUMN RS4_DATAI AS DATE
		COLUMN RS4_DATAF AS DATE
		SELECT DISTINCT SRA.RA_FILIAL,SRA.RA_DEPTO,QB_DESCRIC,QB_MATRESP,SRA2.RA_NOME AS NOMRESP,RS4_FILIAL,SRA.RA_CC,CTT.CTT_DESC01,RS4_MAT,SRA.RA_NOME,SRA.RA_EMAIL,SRA.RA_DDDFONE,SRA.RA_TELEFON,
		RS4_DATAI,RS4_DATAF,RS4_CODOBS
		FROM %table:RS4% RS4
		INNER JOIN %table:SRA% SRA ON(SRA.RA_FILIAL = RS4_FILIAL AND SRA.%notDel% AND SRA.RA_MAT = RS4_MAT)
		LEFT JOIN %table:SQB% SQB ON(%exp:cJoinRAQB% AND SQB.%notDel% AND QB_DEPTO = SRA.RA_DEPTO)
		%exp:cJoinCC% JOIN %table:CTT% CTT ON(%exp:cJoinRACT% AND CTT.%notDel% AND CTT_CUSTO = SRA.RA_CC)
		LEFT JOIN %table:SRA% SRA2 ON(SRA2.RA_FILIAL = QB_FILRESP AND SRA2.%notDel% AND SRA2.RA_MAT = QB_MATRESP)
		WHERE
		RS4.%notDel% AND RS4_STATUS = '2'			
		ORDER BY %exp:cOrderBy%		
	EndSql	
	
	END REPORT QUERY oSecFil PARAM MV_PAR01, MV_PAR02, MV_PAR03, MV_PAR04, MV_PAR05,cDataDeAte
	
	Do Case
		Case (nOrderBy  == 1)		
			oSecCab:SetParentQuery()
			oSecCab:SetParentFilter({|cParam|(cMyAlias)->RS4_FILIAL == cParam},{||(cMyAlias)->RA_FILIAL})
			
			oSecCab:Cell("RA_CC"):Disable()
			oSecCab:Cell("CTT_DESC01"):Disable()
			
			DEFINE BREAK oBreakItems OF oReport WHEN {|| ((cMyAlias)->RA_FILIAL + (cMyAlias)->RA_DEPTO)}	
			oBreakItems:OnBreak({|x|cTitItems := OemToAnsi(STR0007) + " " + oSecItems:Cell("RA_DEPTO"):GetText() + " - " + oSecItems:Cell("QB_DESCRIC"):GetText(), oReport:ThinLine()})
			oBreakItems:SetTotalText({||cTitItems})
			oBreakItems:SetTotalInLine(.T.)			
			DEFINE FUNCTION NAME "DA" FROM oSecItems:Cell("RS4_MAT")  FUNCTION COUNT	BREAK oBreakItems NO END SECTION NO END REPORT
			
			oSecItems:SetParentQuery()
			oSecItems:SetParentFilter({|cParam| ((cMyAlias)->RA_FILIAL + (cMyAlias)->RA_DEPTO) == cParam},{|| ((cMyAlias)->RA_FILIAL + (cMyAlias)->RA_DEPTO) })
		
			oSecItems:Cell("RA_DEPTO"):Disable()
			oSecItems:Cell("QB_DESCRIC"):Disable()
			oSecItems:Cell("QB_MATRESP"):Disable()
			oSecItems:Cell("NOMRESP"):Disable()
			oSecItems:Cell("RA_CC"):Disable()
			oSecItems:Cell("CTT_DESC01"):Disable()
						
		Case (nOrderBy  == 2)
			
			DEFINE SECTION oSecResp OF oSecFil 	TITLE '' TABLES "SQB"
				DEFINE CELL NAME "QB_MATRESP" 	OF 	oSecResp ALIAS "SQB"
				DEFINE CELL NAME "NOMRESP" 		OF 	oSecResp TITLE OemToAnsi(STR0006)				
			oSecResp:SetParentQuery()
			oSecResp:SetParentFilter({|cParam|(cMyAlias)->RA_FILIAL == cParam},{||(cMyAlias)->RA_FILIAL})
							
			aTemp := aClone(oSecFil:aSection)
			aDel(oSecFil:aSection,1)
			aSize(oSecFil:aSection,Len(oSecFil:aSection)-1)
			oSecCab := aTemp[1]
			oSecCab:oParent := oSecResp
			aAdd(oSecResp:aSection,oSecCab)
			
						
			oSecCab:SetParentQuery()
			oSecCab:SetParentFilter({|cParam| ((cMyAlias)->RA_FILIAL + (cMyAlias)->QB_MATRESP) == cParam},{|| ((cMyAlias)->RA_FILIAL + (cMyAlias)->QB_MATRESP) })			
			oSecCab:Cell("QB_MATRESP"):Disable()
			oSecCab:Cell("NOMRESP"):Disable()			
			oSecCab:Cell("RA_CC"):Disable()
			oSecCab:Cell("CTT_DESC01"):Disable()		
			
			
			DEFINE BREAK oBreakItems OF oReport WHEN {|| ((cMyAlias)->RA_FILIAL + (cMyAlias)->RA_DEPTO)}	
			oBreakItems:OnBreak({|x|cTitItems := OemToAnsi(STR0007) +" " + oSecItems:Cell("RA_DEPTO"):GetText() + " - " + oSecItems:Cell("QB_DESCRIC"):GetText(), oReport:ThinLine()})
			oBreakItems:SetTotalText({||cTitItems})
			oBreakItems:SetTotalInLine(.T.)			
			DEFINE FUNCTION NAME "DA" FROM oSecItems:Cell("RS4_MAT")  FUNCTION COUNT	BREAK oBreakItems NO END SECTION NO END REPORT
			
			DEFINE BREAK oBreakCab OF oReport WHEN {|| ((cMyAlias)->RA_FILIAL + (cMyAlias)->QB_MATRESP)}	
			oBreakCab:OnBreak({|x|cTitCab := OemToAnsi(STR0008) +" " + oSecCab:Cell("QB_MATRESP"):GetText() + " - " + oSecCab:Cell("NOMRESP"):GetText(), oReport:ThinLine()})
			oBreakCab:SetTotalText({||cTitCab})
			oBreakCab:SetTotalInLine(.T.)			
			DEFINE FUNCTION NAME "DA" FROM oSecItems:Cell("RS4_MAT")  FUNCTION COUNT	BREAK oBreakCab NO END SECTION NO END REPORT
			
			oSecItems:SetParentQuery()
			oSecItems:SetParentFilter({|cParam| ((cMyAlias)->RA_FILIAL + (cMyAlias)->RA_DEPTO) == cParam},{|| ((cMyAlias)->RA_FILIAL + (cMyAlias)->RA_DEPTO) })		
			
			oSecItems:Cell("RA_DEPTO"):Disable()
			oSecItems:Cell("QB_DESCRIC"):Disable()
			oSecItems:Cell("QB_MATRESP"):Disable()
			oSecItems:Cell("NOMRESP"):Disable()
			oSecItems:Cell("RA_CC"):Disable()
			oSecItems:Cell("CTT_DESC01"):Disable()			
				
		Case (nOrderBy  == 3)
			oSecCab:SetParentQuery()
			oSecCab:SetParentFilter({|cParam|(cMyAlias)->RA_FILIAL == cParam},{||(cMyAlias)->RA_FILIAL})
			
			oSecCab:Cell("RA_DEPTO"):Disable()
			oSecCab:Cell("QB_DESCRIC"):Disable()
			oSecCab:Cell("QB_MATRESP"):Disable()
			oSecCab:Cell("NOMRESP"):Disable()
			
			DEFINE BREAK oBreakItems OF oReport WHEN {|| ((cMyAlias)->RA_FILIAL + (cMyAlias)->RA_CC)}	
			oBreakItems:OnBreak({|x|cTitItems := OemToAnsi(STR0009) +" " + oSecItems:Cell("RA_CC"):GetText() + " - " + oSecItems:Cell("CTT_DESC01"):GetText(), oReport:ThinLine()})
			oBreakItems:SetTotalText({||cTitItems})
			oBreakItems:SetTotalInLine(.T.)			
			DEFINE FUNCTION NAME "DA" FROM oSecItems:Cell("RS4_MAT")  FUNCTION COUNT	BREAK oBreakItems NO END SECTION NO END REPORT
						
			oSecItems:SetParentQuery()
			oSecItems:SetParentFilter({|cParam| ((cMyAlias)->RA_FILIAL + (cMyAlias)->RA_CC) == cParam},{|| ((cMyAlias)->RA_FILIAL + (cMyAlias)->RA_CC) })		
			
			oSecItems:Cell("RA_DEPTO"):Disable()
			oSecItems:Cell("QB_DESCRIC"):Disable()
			oSecItems:Cell("QB_MATRESP"):Disable()
			oSecItems:Cell("NOMRESP"):Disable()
			oSecItems:Cell("RA_CC"):Disable()
			oSecItems:Cell("CTT_DESC01"):Disable()	
	EndCase
	
	if(lCorpManage)
		
		//QUEBRA FILIAL
		DEFINE BREAK oBreakFil OF oReport WHEN {|| (cMyAlias)->RA_FILIAL }		
		oBreakFil:OnBreak({|x|cTitFil := OemToAnsi(STR0010) +" " + x, oReport:ThinLine()})
		oBreakFil:SetTotalText({||cTitFil})
		oBreakFil:SetTotalInLine(.T.)			
		DEFINE FUNCTION NAME "DA" FROM oSecItems:Cell("RS4_MAT")  FUNCTION COUNT	BREAK oBreakFil NO END SECTION NO END REPORT		
		
		//QUEBRA UNIDADE DE NEGÓCIO
		DEFINE BREAK oBreakUni OF oReport WHEN {|| Substr((cMyAlias)->RA_FILIAL, nStartUnN, nUnNLength) }		
		oBreakUni:OnBreak({|x|cTitUniNeg := OemToAnsi(STR0011) +" " + x, oReport:ThinLine()})
		oBreakUni:SetTotalText({||cTitUniNeg})
		oBreakUni:SetTotalInLine(.T.)			
		DEFINE FUNCTION NAME "DA" FROM oSecItems:Cell("RS4_MAT")  FUNCTION COUNT	BREAK oBreakUni NO END SECTION NO END REPORT
		
		//QUEBRA EMPRESA
		DEFINE BREAK oBreakEmp OF oReport WHEN {|| Substr((cMyAlias)->RA_FILIAL, nStartEmp, nEmpLength) }		
		oBreakEmp:OnBreak({|x|cTitEmp := OemToAnsi(STR0012) + " " + x, oReport:ThinLine()})
		oBreakEmp:SetTotalText({||cTitEmp})
		oBreakEmp:SetTotalInLine(.T.)			
		DEFINE FUNCTION NAME "DA" FROM oSecItems:Cell("RS4_MAT")  FUNCTION COUNT	BREAK oBreakEmp NO END SECTION NO END REPORT
			
	Else
		DEFINE BREAK oBreakFil OF oReport WHEN {|| (cMyAlias)->RA_FILIAL }		
		oBreakFil:OnBreak({|x|cTitFil := OemToAnsi(STR0010) +" " + x, oReport:ThinLine()})
		oBreakFil:SetTotalText({||cTitFil})
		oBreakFil:SetTotalInLine(.T.)			
		DEFINE FUNCTION NAME "DA" FROM oSecItems:Cell("RS4_MAT")  FUNCTION COUNT	BREAK oBreakFil NO END SECTION NO END REPORT	
	endIf
		
	oSecFil:Print()
			
Return Nil


/*/{Protheus.doc} GetOrderBy
	Retorna uma cláusula ORDER BY à ser utilizada na consulta do relatório.
@author PHILIPE.POMPEU
@since 08/04/2015
@version P12
@param nOrderBy, numérico, Ordem utilizada no Relatório
@return cOrderBy, string quem contem a cláusula ORDER BY à ser utilizado na consulta
/*/
Static Function GetOrderBy(nOrderBy)
	Local cOrderBy	:= ''
	Default nOrderBy := 1

	Do Case
		Case (nOrderBy == 1)
			cOrderBy := '%SRA.RA_FILIAL,SRA.RA_DEPTO,RS4_MAT%'
		Case (nOrderBy == 2)
			cOrderBy := '%SRA.RA_FILIAL,QB_MATRESP,SRA.RA_DEPTO%'
		Case (nOrderBy == 3)
			cOrderBy := '%SRA.RA_FILIAL,SRA.RA_CC,RS4_MAT%'				
		OtherWise
			cOrderBy := '%SRA.RA_FILIAL,SRA.RA_DEPTO,RS4_MAT%'
	EndCase
	
Return cOrderBy

/*/{Protheus.doc} FPNR150FTR
	Consulta Especifica que lista todos os responsáveis.
@author PHILIPE.POMPEU
@since 08/04/2015
@version P12
@return lResult, Verdadeiro se a consulta foi executada
/*/
User Function FPNR150FTR()
	Local aArea	:= GetArea()
	Local lResult	:= .F.
	Local cMyAlias:= GetNextAlias()	
	Local aAdvSize:= {}
	Local aInfoAdvSize:= {}
	Local aObjCoords	:= {}
	Local aObjSize	:= {}
	LOcal oFont		:= Nil
	Local oDlg			:= NIL
	Local oListResp	:= NIL
	Local aHead		:= {}
	Local nPosLinha	:= 0.00
	Local aOpcoes 	:= {}
	Local bOk		:= { ||lResult := .T., nPosLinha:=oListResp:nAt,oDlg:End()}   
	Local bCancel	:= { ||lResult := .F., oDlg:End() }
	
	BeginSql alias cMyAlias
		SELECT DISTINCT QB_FILRESP, QB_MATRESP,RA_NOME
		FROM %table:SQB% SQB
		INNER JOIN %table:SRA% SRA ON (SRA.%notDel% AND RA_FILIAL = QB_FILRESP AND RA_MAT = QB_MATRESP)
		WHERE
		SQB.%notDel%
		ORDER BY QB_FILRESP,QB_MATRESP ASC
	EndSql
		
	while ( (cMyAlias)->(!Eof()) )		
		aAdd(aOpcoes,{ (cMyAlias)->QB_FILRESP, (cMyAlias)->QB_MATRESP, (cMyAlias)->RA_NOME})		
		(cMyAlias)->(dbSkip())
	End
	(cMyAlias)->(dbCloseArea())
	
	if !(Len(aOpcoes) > 0)
		aOpcoes := {{'','',''}}
	endIf
	
	aAdd(aHead,GetSx3Cache("QB_FILRESP"	, "X3_TITULO"))
	aAdd(aHead,GetSx3Cache("QB_MATRESP"	, "X3_TITULO"))
	aAdd(aHead,GetSx3Cache("RA_NOME"		, "X3_TITULO"))
	
	aAdvSize := MsAdvSize( , .T., 390)
	aInfoAdvSize	:= { aAdvSize[1] , aAdvSize[2] , aAdvSize[3] , aAdvSize[4] , 15 , 5 }
	aAdd( aObjCoords , { 000 , 000 , .T. , .T. } )
	aObjSize := MsObjSize( aInfoAdvSize , aObjCoords )

	DEFINE FONT oFont NAME "Arial" SIZE 0,-11 BOLD 
	DEFINE MSDIALOG oDlg FROM aAdvSize[7],0 TO aAdvSize[6],aAdvSize[5] TITLE OemToAnsi(STR0013) PIXEL
			
	@ aObjSize[1,1], aObjSize[1,2] LISTBOX oListResp FIELDS HEADER aHead[1],aHead[2],aHead[3]  SIZE 290,130 OF oDlg PIXEL;
	ON DBLCLICK ( lResult := .T., nPosLinha:=oListResp:nAt,oDlg:End() )
		
	oListResp:SetArray(aOpcoes)	
	oListResp:bLine := { || {aOpcoes[oListResp:nAt,1],aOpcoes[oListResp:nAt,2],aOpcoes[oListResp:nAt,3]}}
	
	ACTIVATE MSDIALOG oDlg CENTERED ON INIT (EnchoiceBar(oDlg, bOk, bCancel))
	
	IIF(lResult,VAR_IXB := aOpcoes[nPosLinha,2],VAR_IXB := '')		
	RestArea(aArea)
Return lResult




/*/{Protheus.doc} GetJoin
	Retorna o join das tabelas informadas
@author philipe.pompeu
@since 13/04/2015
@version P12
@param cTabela1, character, Nome da primeira Entidade
@param cTabela2, character, Nome da segunda Entidade
@param cEmbedded, character, Caractere de escape utilizado
@return cFiltJoin, Cláusula Join das tabelas
/*/
Static Function GetJoin(cTabela1, cTabela2,cEmbedded)

	Local cFiltJoin := ""
	Local cNameDB	  := TCGetDb()
	Default cEmbedded := ""
	
	cFiltJoin := cEmbedded + FWJoinFilial(cTabela1, cTabela2) + cEmbedded	
	
	If ( cNameDB $ 'DB2|ORACLE|POSTGRES|INFORMIX' )
		cFiltJoin := STRTRAN(cFiltJoin, "SUBSTRING", "SUBSTR")
	EndIf
	
Return (cFiltJoin)


/*/{Protheus.doc} FormatTel
	Formata o telefone no formato (DDD)TELEFONE
@author philipe.pompeu
@since 13/04/2015
@version P12
@param cDDD, caractere, DDD
@param cTelefone, caractere, Telefone
@return cResult, Retorna o telefone formatado
/*/
Static Function FormatTel(cDDD,cTelefone)
	Local cResult := ''
	Default cDDD := ''
	
	if(AllTrim(cDDD) <> '')
		cResult := '('+ AllTrim(cDDD) + ')'
	endIf
	
	cResult+= AllTrim(cTelefone)
Return cResult
