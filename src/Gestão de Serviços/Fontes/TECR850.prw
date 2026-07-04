/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
#INCLUDE 'TECR850.ch'

Static cAliasSRA	:= ""
Static cAliasABB	:= ""
//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} TECR860

Relatorio de Admitidos - GESP
@author Serviços
@since 01/04/2014
@version P12
@return oReport 
@history 05/11/2020: Mário A. Cavenaghi - EthosX: Implementada a funcionalidade "Excel Formato Tabela"
/*/
//----------------------------------------------------------------------------------------------------------------------

User Function TECR850()

Local cPerg := "TECR850"
Local oReport
Local oSection1
Local oSection2

Pergunte(cPerg,.T.)

oReport := TReport():New("TECR850",STR0001,cPerg,{|oReport| ReportPrint(oReport)},STR0002)
oReport:SetLandscape(.T.)

//Sessao 1
oSection1 := TRSection():New(oReport,STR0039,{'SRA','AA1','ABS','SRJ'},,.F.,.F.)
oSection1:SetHeaderPage()
TRCell():New(oSection1,"AA1_CODTEC" ,"AA1",STR0003,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_NOME"    ,"SRA",STR0004,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"AA1_REGIAO" ,"AA1",STR0005,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RJ_DESC"    ,"SRJ",STR0006,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| U_At850Funcao() })
TRCell():New(oSection1,"RA_ADMISSA" ,"SRA",STR0009,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_TNOTRAB" ,"SRA",STR0010,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_RG"      ,"SRA",STR0013,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_RGORG"   ,"SRA",STR0014,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_NUMCP"   ,"SRA",STR0015,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_SERCP"   ,"SRA",STR0016,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_UFCP"    ,"SRA",STR0017,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_PIS"     ,"SRA",STR0018,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_CIC"     ,"SRA",STR0019,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_TITULOE" ,"SRA",STR0020,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_ZONASEC" ,"SRA",STR0021,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_SECAO"   ,"SRA",STR0022,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_PAI"     ,"SRA",STR0023,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_MAE"     ,"SRA",STR0024,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_ENDEREC" ,"SRA",STR0025,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_NUMENDE" ,"SRA",STR0026,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_COMPLEM" ,"SRA",STR0027,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_BAIRRO"  ,"SRA",STR0028,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_MUNICIP" ,"SRA",STR0029,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_ESTADO"  ,"SRA",STR0030,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_CEP"     ,"SRA",STR0031,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_DDDFONE" ,"SRA",STR0032,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_TELEFON" ,"SRA",STR0033,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_NASC"    ,"SRA",STR0034,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_NATURAL" ,"SRA",STR0035,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_SEXO"    ,"SRA",STR0036,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"RA_ESTCIVI" ,"SRA",STR0037,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

//sessao 2
oSection2 := TRSection():New(oReport,STR0040,{'ABB','ABS'},,.F.,.F.)
TRCell():New(oSection2,"ABS_LOCAL"  ,"ABS",STR0003,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"ABS_DESCRI" ,"ABS",STR0007,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"A1_COD"     ,"SA1",STR0003,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
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

Static Function ReportPrint(oReport)
#IFDEF TOP

Local oSection1	:= oReport:Section(1)
Local oSection2	:= oReport:Section(2)
Local cSql1		:= DtoS(MV_PAR01)
Local cSql2		:= DtoS(MV_PAR02)
Local cSql3		:= MV_PAR03
Local cCodTec	:= ""

//sessao 2
If oReport:lXlsTable	//	Excel Formato Tabela
	TRCell():New(oSection2,"AA1_CODTEC","AA1",STR0004,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| cCodTec})
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
	cSql3 := "AND RA.RA_CODFUNC = '" + MV_PAR03 + "' "
EndIf
cSql3 := "%"+cSql3+"%"

BEGIN REPORT QUERY oReport:Section(1)

	BeginSql alias cAliasSRA
		SELECT
			AA1_CODTEC, RA_NOME, AA1_REGIAO, RA_ADMISSA, RA_TNOTRAB,
			RA_RG, RA_RGORG, RA_NUMCP, RA_SERCP, RA_UFCP, RA_PIS, RA_CIC, RA_TITULOE, RA_ZONASEC, RA_SECAO,
			RA_PAI, RA_MAE, RA_ENDEREC, RA_NUMENDE, RA_COMPLEM, RA_BAIRRO, RA_MUNICIP, RA_ESTADO, RA_CEP,
			RA_DDDFONE, RA_TELEFON, RA_NASC, RA_NATURAL, RA_SEXO, RA_ESTCIVI, RA_CODFUNC
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
			RA.RA_ADMISSA >= %exp:cSql1%
		AND
			RA.RA_ADMISSA <= %exp:cSql2%
		AND
			RA.%NotDel%
		%exp:cSql3%
	EndSql
	
END REPORT QUERY oReport:Section(1)
oReport:SetMeter((cAliasSRA)->(LastRec()))

While  !oReport:Cancel() .AND. (cAliasSRA)->( !Eof() )	

	cCodTec := ( cAliasSRA )->AA1_CODTEC	

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
			
		EndSql
		
	END REPORT QUERY oReport:Section(2)

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
User Function At850Funcao()
Local cFuncao := ""

cFuncao := Posicione("SRJ",1,xFilial("SRJ") + (cAliasSRA)->RA_CODFUNC, "RJ_DESC")

Return(cFuncao)
