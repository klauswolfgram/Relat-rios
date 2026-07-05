/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Protheus.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "TMKR050.CH"
                          
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TMKRXX      º Autor ³Vendas CRM          º Data ³  04/11/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Relatorio de ligações anotadas                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function TMKR050()
Local 	oReport

oReport := ReportDef()
oReport:PrintDialog()

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ReportDef ³ Autor ³Vendas CRM             ³ Data ³13/08/20119³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina que define os itens que serao apresentados no relato-³±±
±±³          ³rio.                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Tkr501RptDef()                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function ReportDef()
Local	cAlias		:=	""
Local	cPerg		:=	"TMKR050"
Local 	oReport

Static	oTotA
Static	oTotSG
Static	oTotSO

#IFDEF TOP
	cAlias	:=	GetNextAlias()
#ELSE
	cAlias	:=	"AGL"
#ENDIF

Pergunte(cPerg, .F.)

//Relatório
DEFINE REPORT oReport NAME "TMKR050" TITLE STR0013 PARAMETER cPerg ACTION {|oReport| PrintReport(oReport, cPerg, @cAlias)} //"Relatório de Motivos de Ligações Anotadas"

//Sessão
DEFINE SECTION oInativ	OF oReport TITLE "Titulo da sessão"				TABLES "AGL" BREAK HEADER //"Operadores inativos"
DEFINE SECTION oSecSinG	OF oReport TITLE "Titulo da sessão Sintetica"	TABLES "AGL" BREAK HEADER //Sintetico por grupo  
DEFINE SECTION oSecSinO	OF oReport TITLE "Titulo da sessão Sintetica"	TABLES "AGL" BREAK HEADER //Sintetico por Operador

//Celulas
DEFINE CELL NAME "AGL_FILIAL"	OF oInativ ALIAS "AGL"
DEFINE CELL NAME "AGL_DATA"		OF oInativ ALIAS "AGL"  BLOCK {|| SToD(AGL_DATA)}  	SIZE 12	Align Left 
DEFINE CELL NAME "AGL_HORA"		OF oInativ ALIAS "AGL"
DEFINE CELL NAME "AGL_OPNAME"	OF oInativ ALIAS "AGL" 	BLOCK {|| FATPDObfuscate(POSICIONE('SU7',1, xFILIAL('SU7') + (cAlias)->AGL_OPERAD, 'U7_NOME'),"U7_NOME",,.T.)} // Anderson.Walter_121203 - Alterado de "XFILIAL('SU7')" para "(cAlias)->AGL_FILIAL", para poder exibir o nome do analista de outra filial - BABDK9
DEFINE CELL NAME "AGL_MOTIVO"	OF oInativ ALIAS "AGL"
DEFINE CELL NAME "AGL_MOTNAM"	OF oInativ ALIAS "AGL"	BLOCK {|| POSICIONE("AGK",1,XFILIAL("AGK") +(cAlias)->AGL_MOTIVO,"AGK_DESCRI")}
DEFINE CELL NAME "AGL_GRUPO"	OF oInativ ALIAS "AGL"	BLOCK {|| cValToChar(AGL_GRUPO)}									//Anderson.Walter_121120 - Tratamento de Casas Decimais(Esse campo deve ser convertido para Caracter pois e uma informação e não um valor) - BAFMO4
DEFINE CELL NAME "AGL_GRPNAM"	OF oInativ ALIAS "AGL"  BLOCK {|| Posicione("AGI", 3, xFILIAL("AGI") + Str((cAlias)->AGL_GRUPO, TamSX3("AGL_GRUPO")[1], TamSX3("AGL_GRUPO")[2]), "AGI_DACNAM") } //Anderson.Walter_121203 - Alterado de "XFILIAL("AGK")" para "(cAlias)->AGL_FILIAL", para poder exibir o nome do analista de outra filial - BABDK9

//Sintetico por grupo
DEFINE CELL NAME "AGL_FILIAL"	OF oSecSinG ALIAS "AGL"
DEFINE CELL NAME "AGL_GRUPO"	OF oSecSinG ALIAS "AGL"	BLOCK {|| cValToChar(AGL_GRUPO)}									//Anderson.Walter_121120 - Tratamento de Casas Decimais(Esse campo deve ser convertido para Caracter pois e uma informação e não um valor) - BAFMO4
DEFINE CELL NAME "AGL_GRPNAM"	OF oSecSinG ALIAS "AGL" BLOCK {|| Posicione("AGI", 3, XFILIAL("AGI") + Str((cAlias)->AGL_GRUPO, TamSX3("AGL_GRUPO")[1], TamSX3("AGL_GRUPO")[2]), "AGI_DACNAM") }
DEFINE CELL NAME "AGL_MOTIVO"	OF oSecSinG ALIAS "AGL"
DEFINE CELL NAME "AGL_MOTNAM"	OF oSecSinG ALIAS "AGL"	BLOCK {|| POSICIONE("AGK",1,XFILIAL("AGK") +(cAlias)->AGL_MOTIVO,"AGK_DESCRI")} 
DEFINE CELL NAME "TOTAL" OF oSecSinG TITLE "TOTAL" SIZE 5
oReport:aSection[2]:aCell[6]:bCellBlock   := {|| (cAlias)->TOTAL}
oReport:aSection[2]:aCell[6]:cType        := "N"
oReport:aSection[2]:aCell[6]:cPicture     := "@E 99999"
oReport:aSection[2]:aCell[6]:nHeaderAlign := 2

//Sintetico por operador
DEFINE CELL NAME "AGL_FILIAL"	OF oSecSinO ALIAS "AGL"
DEFINE CELL NAME "AGL_OPNAME"	OF oSecSinO ALIAS "AGL" 	BLOCK {|| FATPDObfuscate(POSICIONE('SU7',1,xFILIAL('SU7') + (cAlias)->AGL_OPERAD, 'U7_NOME'),"U7_NOME",,.T.)} //Anderson.Walter_121203 - Alterado de "XFILIAL('SU7')" para "(cAlias)->AGL_FILIAL", para poder exibir o nome do analista de outra filial - BABDK9
DEFINE CELL NAME "AGL_MOTIVO"	OF oSecSinO ALIAS "AGL"
DEFINE CELL NAME "AGL_MOTNAM"	OF oSecSinO ALIAS "AGL"		BLOCK {|| POSICIONE("AGK",1,xFILIAL("AGK")+(cAlias)->AGL_MOTIVO,"AGK_DESCRI")} //Anderson.Walter_121203 - Alterado de "XFILIAL("AGK")" para "(cAlias)->AGL_FILIAL", para poder exibir o nome do analista de outra filial - BABDK9
DEFINE CELL NAME "TOTAL" 		OF oSecSinO TITLE "TOTAL" SIZE 5
oReport:aSection[3]:aCell[5]:bCellBlock   := {|| (cAlias)->TOTAL} 
oReport:aSection[3]:aCell[5]:cType        := "N"
oReport:aSection[3]:aCell[5]:cPicture     := "@E 99999"
oReport:aSection[3]:aCell[5]:nHeaderAlign := 2

//Quebra                                                                
DEFINE BREAK oBreak 	OF oInativ	WHEN oInativ:Cell("AGL_FILIAL")
DEFINE BREAK oBreakSG	OF oSecSinG	WHEN oSecSinG:Cell("AGL_FILIAL")
DEFINE BREAK oBreakSO	OF oSecSinO	WHEN oSecSinO:Cell("AGL_FILIAL")

//Totalizador
DEFINE FUNCTION oTotA	FROM oInativ:Cell("AGL_FILIAL")	OF oInativ	FUNCTION COUNT	TITLE STR0014 NO END SECTION BREAK oBreak //"Quantidade total de ligações no período"
DEFINE FUNCTION oTotSG	FROM oSecSinG:Cell("TOTAL")		OF oSecSinG	FUNCTION SUM	TITLE STR0014 NO END SECTION BREAK oBreakSG  //"Quantidade total de ligações no período"
DEFINE FUNCTION oTotSO	FROM oSecSinO:Cell("TOTAL")		OF oSecSinO	FUNCTION SUM	TITLE STR0014 NO END SECTION BREAK oBreakSO //"Quantidade total de ligações no período"

Return oReport 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintReportºAutor  ³Vendas CRM         º Data ³  05/11/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Selecao dos itens a serem impressos                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³TMKRXX                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport, cPerg, cAlias)

Local cSQL 		:= ""
Local aRangeDAC := {}
Local nCount 	:= 0
Local cQuer1	:=	""
Local cQuer2	:=	""	
Local cOrder	:=	""
Local cDBType	:= AllTrim(Upper(TcGetDb()))

MakeSqlExp(cPerg)

If !Empty(MV_PAR01)	//Filial De:	
	cQuer1 += "AND GJ.AGJ_FILIAL >= '"+MV_PAR01+"' "
Endif
If !Empty(MV_PAR01)	//Filial De:	
	cQuer1 += "AND GJ.AGJ_FILIAL <= '"+MV_PAR02+"' "	
Endif	
If !Empty(MV_PAR03)	//Data De:
	cQuer2	+=	"AND AGL.AGL_DATA >= '"+DToS(MV_PAR03)+"' "		
EndIf
If !Empty(MV_PAR04)	//Data Ate:	
	cQuer2	+=	"AND AGL.AGL_DATA <= '"+DToS(MV_PAR04)+"' "			
EndIf

If !Empty(MV_PAR05)	//Operador De
	cQuer1 += "AND AG9.AG9_CODSU7 >='"+MV_PAR05+"' "
EndIf

If !Empty(MV_PAR06)	//Operador Ate
	cQuer1 += "AND AG9.AG9_CODSU7 <='"+MV_PAR06+"' "
EndIf

If !Empty(MV_PAR07)	//Grupo DAC
	cQuer1 += "AND (GJ.AGJ_GICOD IN("+SubStr(MV_PAR07,At("'",MV_PAR07))
EndIf

If !Empty(MV_PAR08)	 //Motivo De
	cQuer2 += "AND AGL.AGL_MOTIVO >= '"+MV_PAR08+"' "
EndIf

If !Empty(MV_PAR09)	 //Motivo Ate
	cQuer2 += "AND AGL.AGL_MOTIVO <= '"+MV_PAR09+"' "
EndIf

If  cDBType $ "ORACLE,POSTGRES,DB2,INFORMIX"
	cQuer2 += " AND	(AGL.AGL_GRUPO  = CAST(AXX.DAC AS INTEGER) OR AGL.AGL_GRUPO = 0) "
Else
	cQuer2 += " AND	(AGL.AGL_GRUPO = AXX.DAC OR AGL.AGL_GRUPO = 0) "
EndIf

If !Empty(MV_PAR10)
	If MV_PAR10 == 2
		If MV_PAR11 == 1
			cQuer2 += "GROUP BY AGL.AGL_FILIAL, AGL.AGL_MOTIVO, AGL.AGL_GRUPO "
		Elseif MV_PAR11 == 2
			cQuer2 += "GROUP BY AGL.AGL_FILIAL, AGL.AGL_MOTIVO, AGL.AGL_OPERAD "
		Endif
	Endif
Endif

If !Empty(MV_PAR11)	 //Agrupar por
	If MV_PAR11 == 1 .And. !Empty(MV_PAR10) .And. MV_PAR10 == 1
		cQuer2 += "ORDER BY AGL.AGL_GRUPO, AGL.AGL_OPERAD, AGL.AGL_FILIAL, AGL.AGL_DATA, AGL.AGL_HORA " 
	Endif
ElseIf MV_PAR11 == 2
		cQuer2 += "ORDER BY AGL.AGL_OPERAD, AGL.AGL_GRUPO, AGL.AGL_FILIAL, AGL.AGL_DATA, AGL.AGL_HORA " 
Endif


cQuer1 := "%"+cQuer1+"%"
cQuer2 := "%"+cQuer2+"%"

If MV_PAR10 == 1 // 1 = Analitico
BEGIN REPORT QUERY oReport:Section(1)
	BeginSql Alias cAlias
	SELECT	AGL.AGL_FILIAL,AGL.AGL_DATA,AGL.AGL_HORA,AGL.AGL_OPERAD,AGL.AGL_GRUPO,AGL.AGL_MOTIVO
	FROM	%table:AGL% AGL, (	SELECT DISTINCT AG9.AG9_FILIAL FILIAL, AG9.AG9_CODSU7 OPERADOR, GJ.AGJ_GICOD DAC
							FROM %table:AGJ% GJ, %table:AG9% AG9  
							WHERE GJ.%NotDel%
								AND AG9.%NotDel%
								AND AG9.AG9_FILIAL = GJ.AGJ_FILIAL
								AND GJ.AGJ_SU0COD = AG9.AG9_CODSU0						  
								%Exp:cQuer1%) AXX
	WHERE	AGL.%NotDel%
		AND	AGL.AGL_OPERAD 	= 	AXX.OPERADOR
		%Exp:cQuer2%
	EndSql  
END REPORT QUERY oReport:Section(1)
oTotSG:Disable()
oTotSO:Disable()	

Elseif MV_PAR10 == 2 // 2 = Sintetico
	If MV_PAR11 == 1
		BEGIN REPORT QUERY oReport:Section(2)
			BeginSql Alias cAlias
			SELECT	AGL.AGL_FILIAL, AGL.AGL_MOTIVO, AGL.AGL_GRUPO, SUM(1) TOTAL
			FROM	%table:AGL% AGL, (	SELECT DISTINCT AG9.AG9_FILIAL FILIAL, AG9.AG9_CODSU7 OPERADOR, GJ.AGJ_GICOD DAC
									FROM %table:AGJ% GJ, %table:AG9% AG9  
									WHERE GJ.%NotDel%
									  AND AG9.%NotDel%
									  AND AG9.AG9_FILIAL = GJ.AGJ_FILIAL
									  AND GJ.AGJ_SU0COD = AG9.AG9_CODSU0						  
									  %Exp:cQuer1% ) AXX
			WHERE	AGL.%NotDel%
			  AND	AGL.AGL_OPERAD 	= 	AXX.OPERADOR
			  %Exp:cQuer2%
			EndSql
		END REPORT QUERY oReport:Section(2)
		oTotA:Disable()
		oTotSO:Disable()		
	Elseif MV_PAR11 == 2
		BEGIN REPORT QUERY oReport:Section(3)
			BeginSql Alias cAlias
			SELECT	AGL.AGL_FILIAL, AGL.AGL_MOTIVO, AGL.AGL_OPERAD, SUM(1) TOTAL
			FROM	%table:AGL% AGL, (	SELECT DISTINCT AG9.AG9_FILIAL FILIAL, AG9.AG9_CODSU7 OPERADOR, GJ.AGJ_GICOD DAC
									FROM %table:AGJ% GJ, %table:AG9% AG9    
									WHERE GJ.%NotDel%
									  AND AG9.%NotDel%
									  AND AG9.AG9_FILIAL = GJ.AGJ_FILIAL
									  AND GJ.AGJ_SU0COD = AG9.AG9_CODSU0						  
									  %Exp:cQuer1%) AXX
			WHERE	AGL.%NotDel%
			  AND	AGL.AGL_OPERAD 	= 	AXX.OPERADOR
			  %Exp:cQuer2%
			EndSql
			END REPORT QUERY oReport:Section(3)	
		END REPORT QUERY oReport:Section(3)	
		oTotA:Disable()
		oTotSG:Disable()		
	Endif
Endif	


If MV_PAR10 == 1
	oReport:Section(1):Print()
Elseif MV_PAR10 == 2
	If MV_PAR11 == 1
		oReport:Section(2):Print()
	Elseif MV_PAR11 == 2
		oReport:Section(3):Print()
	Endif
Endif

Return Nil

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @sample FATPDObfuscate("999999999","U5_CEL")
    @author Squad CRM & Faturamento
    @since 04/12/2019
    @version P12
    @param xValue, (caracter,numerico,data), Valor que sera ofuscado.
    @param cField, caracter , Campo que sera verificado.
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado

    @return xValue, retorna o valor ofuscado.
/*/
//-----------------------------------------------------------------------------
Static Function FATPDObfuscate(xValue, cField, cSource, lLoad)
    
    If FATPDActive()
		xValue := FTPDObfuscate(xValue, cField, cSource, lLoad)
    EndIf

Return xValue   

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    Função que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive