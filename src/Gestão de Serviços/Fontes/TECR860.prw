/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "TECR860.CH"

Static cAliasSRA	:= ""
Static cAliasABB	:= ""
//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} TECR860

Relatorio de Demitidos - GESP
@author Serviços
@since 01/04/2014
@version P12
@return oReport
@history 05/11/2020: Mário A. Cavenaghi - EthosX: Implementada a funcionalidade "Excel Formato Tabela"
/*/
//----------------------------------------------------------------------------------------------------------------------
User Function TECR860()
Local cPerg := "TECR860"
Local oReport
Local oSection1
Local oSection2

Pergunte(cPerg, .T.)

//Relatório
DEFINE REPORT oReport NAME "TECR860" TITLE STR0001 PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION STR0002

oReport:SetLandscape()

oSection1 :=TRSection():New(oReport,STR0012,{'SRA','AA1','ABS','SRJ'},,.F.,.F.)
oSection1:SetHeaderPage()
TRCell():New(oSection1,"AA1_CODTEC" ,"AA1",STR0011,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_NOME"    ,"SRA",STR0003,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RJ_DESC"    ,"SRJ",STR0004,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| U_GetFuncao() })
TRCell():New(oSection1,"RA_ADMISSA" ,"SRA",STR0005,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_DEMISSA" ,"SRA",STR0006,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

//sessao 2
oSection2 :=TRSection():New(oReport,STR0013,{'ABB','ABS', 'SA1'},,.F.,.F.)
TRCell():New(oSection2,"ABS_LOCAL"  ,"ABS",STR0011,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"ABS_DESCRI" ,"ABS",STR0007,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"A1_COD"     ,"SA1",STR0011,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"A1_NOME"    ,"SA1",STR0008,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
		
TRFunction():New(oSection1:Cell("RA_NOME"),NIL,"COUNT")
		
oReport:PrintDialog()

Return oReport

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport

Função responsavél pela impressão do relatório
@author Serviços
@since 02/01/2013
@version P11 R9

@return Nil,Não Retorna Nada
/*/
//----------------------------------------------------------------------------------------------------------------------
Static Function PrintReport(oReport)
#IFDEF TOP

Local oSection1	:= oReport:Section(1)
Local oSection2	:= oReport:Section(2)
Local cSql1		:= DtoS(MV_PAR01)
Local cSql2		:= DtoS(MV_PAR02)
Local cSql3		:= MV_PAR03
Local cCodTec	:= ""
Local lDb2		:= IIf(Trim(Upper(TcGetDb())) $ "ORACLE,POSTGRES,DB2,INFORMIX",.T.,.F.)

//sessao 2
If oReport:lXlsTable	//	Excel Formato Tabela
	TRCell():New(oSection2,"AA1_CODTEC","AA1",STR0003,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| cCodTec})
Endif

cAliasSRA 	:= GetNextAlias()
cAliasABB 	:= GetNextAlias()

If Empty(cSql1)
	cSql1 := "0"
EndIf

If Empty(cSql2)
	cSql2 := DToS(dDataBase)
EndIf

If !Empty(MV_PAR03)
	cSql3 := "AND AA1.AA1_FUNCAO = '" + MV_PAR03 + "' "
EndIf
cSql3 := "%"+cSql3+"%"

BEGIN REPORT QUERY oReport:Section(1)	
	
	BeginSql alias cAliasSRA
		SELECT AA1_CODTEC, RA_CODFUNC, RA_NOME, RA_ADMISSA, RA_DEMISSA
		FROM %table:SRA% RA
		INNER JOIN 
			%table:AA1% AA1
		ON
			AA1.AA1_FILIAL = %xfilial:AA1%
		AND
			RA.RA_MAT = AA1.AA1_CDFUNC
		AND
			AA1.%NotDel%	
		WHERE
			RA.RA_FILIAL = %xfilial:SRA% 
		AND
			RA.RA_DEMISSA >= %exp:cSql1%
		AND
			RA.RA_DEMISSA <= %exp:cSql2%
		AND
			RA.%NotDel%
		%exp:cSql3%
	EndSql

END REPORT QUERY oReport:Section(1)
oReport:SetMeter((cAliasSRA)->(LastRec()))

While  !oReport:Cancel() .AND. (cAliasSRA)->( !Eof() )	

	cCodTec := ( cAliasSRA )->AA1_CODTEC	
	If lDb2
		
		BEGIN REPORT QUERY oReport:Section(2)			
			
			BeginSql alias cAliasABB		
				
				SELECT 
					AA1_CODTEC = %exp:cCodTec%,
					ABB.ABB_CODTEC, 
					ABB.ABB_DTINI, 
					ABS.ABS_LOCAL, 
					ABS.ABS_DESCRI, 
					SA1.A1_COD, 
					SA1.A1_NOME
				FROM %table:ABB% ABB
				LEFT JOIN 
					%table:ABS% ABS
				ON 
					ABS.ABS_FILIAL = %xfilial:ABS% 
				AND 
					ABB.ABB_LOCAL = ABS.ABS_LOCAL
				AND 
					ABS.%NotDel%
				LEFT JOIN 
					%Table:SA1% SA1  
				ON 
					SA1.A1_COD = ABS.ABS_CODIGO 
				AND 
					SA1.A1_LOJA = ABS.ABS_LOJA 
				AND 
					SA1.%NotDel% 
				AND 
					SA1.A1_FILIAL = %xfilial:SA1%
				WHERE 
					ABB.ABB_CODTEC = %exp:cCodTec%
				AND 
					ABB.ABB_DTINI >= %exp:cSql1%
				AND 
					ABB.ABB_DTFIM <= %exp:cSql2%
				AND 
					ABB.%NotDel%			
				GROUP BY ABB.ABB_CODTEC, 
							ABB.ABB_DTINI, 
							ABS.ABS_LOCAL, 
							ABS.ABS_DESCRI, 
							SA1.A1_COD, 
							SA1.A1_NOME
				ORDER BY ABB.ABB_DTINI DESC
				FETCH FIRST ROW ONLY		
			
			EndSql
		
		END REPORT QUERY oReport:Section(2)
	Else
		
		BEGIN REPORT QUERY oReport:Section(2)			
			
			BeginSql alias cAliasABB		

				SELECT TOP 1
					AA1_CODTEC = %exp:cCodTec%,
					ABB.ABB_CODTEC, 
					ABB.ABB_DTINI, 
					ABS.ABS_LOCAL, 
					ABS.ABS_DESCRI, 
					SA1.A1_COD, 
					SA1.A1_NOME
				FROM %table:ABB% ABB
				LEFT JOIN 	
					%table:ABS% ABS
				ON 
					ABS.ABS_FILIAL = %xfilial:ABS% 
				AND 
					ABB.ABB_LOCAL = ABS.ABS_LOCAL
				AND 
					ABS.%NotDel%
				LEFT JOIN 
					%Table:SA1% SA1  
				ON 
					SA1.A1_COD = ABS.ABS_CODIGO 
				AND 
					SA1.A1_LOJA = ABS.ABS_LOJA 
				AND 
					SA1.%NotDel% 
				AND 
					SA1.A1_FILIAL = %xfilial:SA1%
				WHERE 
					ABB.ABB_CODTEC = %exp:cCodTec%
				AND 
					ABB.ABB_DTINI >= %exp:cSql1%
				AND 
					ABB.ABB_DTFIM <= %exp:cSql2%
				AND 
					ABB.%NotDel%			
				GROUP BY ABB.ABB_CODTEC, 
							ABB.ABB_DTINI, 
							ABS.ABS_LOCAL, 
							ABS.ABS_DESCRI, 
							SA1.A1_COD, 
							SA1.A1_NOME
				ORDER BY ABB.ABB_DTINI DESC
			
			EndSql
		
		END REPORT QUERY oReport:Section(2)
	
	EndIf

	oReport:IncMeter()		
	If  !oReport:Cancel() .AND. (cAliasABB)->( !Eof() )	
		oSection2:SetParentQuery()
			
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
	(cAliasSRA)->(DbSkip())	

Enddo

If Select(cAliasSRA)>0
	(cAliasSRA)->(DbCloseArea())
EndIf
	      
If Select(cAliasABB)>0
	(cAliasABB)->(DbCloseArea())
EndIf

#ENDIF
Return

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} GetFuncao

Retorna a função do atendente
@author Serviços
@since 02/01/2013
@version P11 R9

@return cFuncao,Descrição da função do atendente
/*/
//----------------------------------------------------------------------------------------------------------------------
User Function GetFuncao()
Local cFuncao := ""

cFuncao := Posicione("SRJ",1,xFilial("SRJ") + (cAliasSRA)->RA_CODFUNC, "RJ_DESC")

Return(cFuncao)
