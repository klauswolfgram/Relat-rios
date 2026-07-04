/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "TECR880.CH"

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} TECR880

Relatorio de Efetivos - GESP
@author Serviços
@since 02/01/2013
@version P11 R9

@return Nil,Não Retorna Nada
/*/ 
//----------------------------------------------------------------------------------------------------------------------
User Function TECR880()
Local cPerg  	:= "TECR880"
Local cAlias 	:= ""
Local oSA1		:= Nil                			//Objeto para armazenar a secao pai
Local cAliasSRA := GetNextAlias()
Local cAliasABB := GetNextAlias()
	

DEFINE REPORT oReport NAME "TECR880" TITLE STR0001 PARAMETER cPerg ACTION {|oReport| PrintReport(oReport, cAliasABB, cAliasSRA)} DESCRIPTION STR0002

oReport:SetLandscape()

//sessao 1
oSection1 :=TRSection():New(oReport,'',{'SRA','AA1','ABS','SPJ', 'SRJ', 'SR6'},,.F.,.F.)
oSection1:SetHeaderPage()
TRCell():New(oSection1,"AA1_CODTEC" ,"AA1",STR0008,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_NOME"	 ,"SRA",STR0009	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_CODFUNC" ,"AA1",STR0006	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RJ_DESC"	 ,"SRJ",STR0007	,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| POSICIONE("SRJ",1,XFILIAL("SRJ") + (cAliasSRA)->RA_CODFUNC,"RJ_DESC")})
TRCell():New(oSection1,"AA1_CNV"	 ,"AA1",STR0022	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"AA1_TURNO"	 ,"AA1",STR0010	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"R6_DESCRI"	 ,"SR6",STR0011	,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| POSICIONE("SR6",1,XFILIAL("SR6") + (cAliasSRA)->RA_TNOTRAB,"R6_DESC")})
TRCell():New(oSection1,"RA_ADMISSA" ,"SRA",STR0012,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

//sessao 2
oSection2 :=TRSection():New(oReport,'',{'ABB','ABS'},,.F.,.F.)
TRCell():New(oSection2,"ABS_LOCAL"	,"ABS",STR0003	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"ABS_DESCRI","ABS",STR0004	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"A1_COD"		,"SA1",STR0023	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"A1_NOME"	,"SA1",STR0004	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
		
TRFunction():New(oSection1:Cell("RA_NOME"),NIL,"COUNT")

oReport:PrintDialog()
Return Nil

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport

Função responsavél pela impressão do relatório
@author Serviços
@since 02/01/2013
@version P11 R9

@return Nil,Não Retorna Nada
/*/ 
//----------------------------------------------------------------------------------------------------------------------
Static Function PrintReport(oReport, cAliasABB, cAliasSRA)
#IFDEF TOP


Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oReport:Section(2)
Local cDataDe := DtoS(MV_PAR01)
Local cDataAt := DtoS(MV_PAR02)
Local cLocDe := MV_PAR03
Local cLocAt := MV_PAR04
Local cFuncao := MV_PAR05
Local cCodTec := ""

If Empty(cDataDe)
	cDataDe = DToS(dDataBase)
EndIf

If Empty(cDataAt)
	cDataAt = DToS(dDataBase)
EndIf

If !Empty(MV_PAR05)
	cFuncao = "AND AA1.AA1_FUNCAO = '" + MV_PAR05 + "' "
EndIf
cFuncao := "%"+cFuncao+"%"

If !Empty(cLocDe) .OR. !Empty(cLocAt)
	cLocDe = " AND ABS.ABS_LOCAL >= '"+MV_PAR03+"' AND ABS.ABS_LOCAL >= '"+MV_PAR04+"' "
EndIf
cLocDe := "%"+cLocDe+"%"
	
BEGIN REPORT QUERY oReport:Section(1)	
	BeginSql alias cAliasSRA		
		SELECT * FROM %table:SRA% RA
		INNER JOIN %table:AA1% AA1
		ON RA.RA_FILIAL = %xfilial:SRA% 
		AND RA.RA_MAT = AA1.AA1_CDFUNC
		WHERE RA.RA_DEMISSA = ' '
		%exp:cFuncao%
		AND RA.%NotDel%
		AND AA1.%NotDel%
	EndSql
END REPORT QUERY oReport:Section(1)

While  !oReport:Cancel() .AND. (cAliasSRA)->( !Eof() )	

	cCodTec := ( cAliasSRA )->AA1_CODTEC	
	
	BEGIN REPORT QUERY oReport:Section(2)			
		BeginSql alias cAliasABB		
			SELECT ABB.ABB_CODTEC, ABB.ABB_DTINI, ABS.ABS_LOCAL, ABS.ABS_DESCRI, SA1.A1_COD, SA1.A1_NOME
			FROM %table:ABB% ABB
			LEFT JOIN 	%table:ABS% ABS
			ON ABS.ABS_FILIAL = %xfilial:ABS% 
			AND ABB.ABB_LOCAL = ABS.ABS_LOCAL
			AND ABS.%NotDel%
			LEFT JOIN %Table:SA1% SA1  
			ON SA1.A1_COD = ABS.ABS_CODIGO 
			AND SA1.A1_LOJA = ABS.ABS_LOJA 
			AND SA1.%NotDel% 
			AND SA1.A1_FILIAL = %xfilial:SA1%
			WHERE ABB.ABB_CODTEC = %exp:cCodTec%
			AND ABB.ABB_DTINI >= %exp:cDataDe%
			AND ABB.ABB_DTFIM <= %exp:cDataAt%
			AND ABB.%NotDel%	
			%exp:cLocDe%		
			GROUP BY ABB.ABB_CODTEC, ABB.ABB_DTINI, ABS.ABS_LOCAL, ABS.ABS_DESCRI, SA1.A1_COD, SA1.A1_NOME
			ORDER BY ABB.ABB_DTINI DESC		
		EndSql
	END REPORT QUERY oReport:Section(2)
	
	If  !oReport:Cancel() .AND. (cAliasABB)->( !Eof() )	
		oSection2:IncMeter()			
			
		oSection1:Init()
		oSection2:Init()
		
		oSection1:PrintLine()		
		oSection2:PrintLine()
					
		oSection1:Finish()
		oSection2:Finish()
			
		oReport:SkipLine()
		oReport:SkipLine()	

	Else
		oSection1:Init()
		
		oSection1:PrintLine()
		
		oSection1:Finish()
		
		oReport:SkipLine()
		oReport:SkipLine()
	
	EndIf
	
	(cAliasABB)->(DbSkip())	
			
(cAliasSRA)->(DbSkip())	
	
End

If Select(cAliasSRA)>0
	(cAliasSRA)->(DbCloseArea())
EndIf
	      
If Select(cAliasABB)>0
	(cAliasABB)->(DbCloseArea())
EndIf

#ENDIF
Return Nil
//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} At880Func

Função responsavél pela filtro dos atendentes
@Sample U_At880Func(cAlias)
@author Serviços
@since 02/01/2013
@version P11 R9

@return lRet, retorna .T. se o atendente não estiver igual ao anterior
/*/ 
//----------------------------------------------------------------------------------------------------------------------
User Function At880Func(cAlias)

Default cAlias := ""

If !Empty(cAlias)
	If cFunc == (cAlias)->ABB_CODTEC
		lRet := .F.
	Else
		cFunc := (cAlias)->ABB_CODTEC
		lRet := .T.	
	EndIf
Else
	lRet := .F.
EndIf

Return(lRet)