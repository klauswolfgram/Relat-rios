/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"
#Include "VEIR010.CH"

/*/{Protheus.doc} VEIR010
	Impressao de Frotas

	@author Andre Luis Almeida
	@since 01/02/2021
/*/
User Function VEIR010( cGruNeg , cCodCli , cLojCli , cRegCli , cMunCli , cUFMCli )
Local oReport
Local aArea   := GetArea()
Default cGruNeg := ""
Default cCodCli := ""
Default cLojCli := ""
Default cRegCli := ""
Default cMunCli := ""
Default cUFMCli := ""
Private cP_GruNeg  := cGruNeg // Parametros para filtro
Private cP_CodCli  := cCodCli // Parametros para filtro
Private cP_LojCli  := cLojCli // Parametros para filtro
Private cP_RegCli  := cRegCli // Parametros para filtro
Private cP_MunCli  := cMunCli // Parametros para filtro
Private cP_UFMCli  := cUFMCli // Parametros para filtro
Private lFazPerg   := Empty( cP_GruNeg + cP_CodCli + cP_LojCli + cP_RegCli + cP_MunCli + cP_UFMCli ) // Se não passou parametro, faz a pergunte
Private lVC3SEGMOD := ( VC3->(ColumnPos("VC3_SEGMOD")) > 0 )
Private cCodMarca  := FMX_RETMAR(GetNewPar("MV_MIL0006","")) // 28 da VX5
Private aFrotas    := U_VR0100021_Levanta() // Frotas ativas -> [1] Grupos de Modelos da Marca Pricipal / [2] Totalizadores Marca Principal, Outras Marcas e Total
//
If lFazPerg
	Pergunte("VEIR010",.f.)
EndIf
oReport := ReportDef()
oReport:PrintDialog()
RestArea( aArea )
//
Return

/*/{Protheus.doc} ReportDef
	ReportDef

	@author Andre Luis Almeida
	@since 01/02/2021
/*/
Static Function ReportDef()
Local oReport
Local oSection1
//
oReport := TReport():New("VEIR010",STR0001,IIf(lFazPerg,"VEIR010",nil),{|oReport| VR0100011_Impressao(oReport)}) // Frotas
//
oSection1 := TRSection():New(oReport,STR0001,{}) // Frotas
TRCell():New(oSection1,"COD",,GetSX3Cache("A1_COD"    ,"X3_TITULO"),GetSX3Cache("A1_COD"    ,"X3_PICTURE"),GetSX3Cache("A1_COD"    ,"X3_TAMANHO"),,{|| nCodCli } )
TRCell():New(oSection1,"LOJ",,GetSX3Cache("A1_LOJA"   ,"X3_TITULO"),GetSX3Cache("A1_LOJA"   ,"X3_PICTURE"),GetSX3Cache("A1_LOJA"   ,"X3_TAMANHO"),,{|| nLojCli } )
TRCell():New(oSection1,"NOM",,GetSX3Cache("A1_NOME"   ,"X3_TITULO"),GetSX3Cache("A1_NOME"   ,"X3_PICTURE"),GetSX3Cache("A1_NOME"   ,"X3_TAMANHO"),,{|| nNomCli } )
TRCell():New(oSection1,"REG",,GetSX3Cache("A1_REGIAO" ,"X3_TITULO"),GetSX3Cache("A1_REGIAO" ,"X3_PICTURE"),GetSX3Cache("A1_REGIAO" ,"X3_TAMANHO"),,{|| nRegCli } )
TRCell():New(oSection1,"MUN",,GetSX3Cache("VAM_DESCID","X3_TITULO"),GetSX3Cache("VAM_DESCID","X3_PICTURE"),GetSX3Cache("VAM_DESCID","X3_TAMANHO"),,{|| nMunCli } )
TRCell():New(oSection1,"EST",,GetSX3Cache("VAM_ESTADO","X3_TITULO"),GetSX3Cache("VAM_ESTADO","X3_PICTURE"),GetSX3Cache("VAM_ESTADO","X3_TAMANHO"),,{|| nEstCli } )
U_VR0100031_MontaColunas(@oSection1,aFrotas,.t.) // Frotas
oReport:SetTotalInLine(.f.)
oReport:SetLandScape()
oReport:DisableOrientation()
//
Return oReport

/*/{Protheus.doc} VR0100011_Impressao
	Carrega variaveis para serem utilizadas nos Filtros dos Browse's para a Consulta

	@author Andre Luis Almeida
	@since 01/02/2021
/*/
Static Function VR0100011_Impressao( oReport )
Local oSection1 := oReport:Section(1)
Local aVetImp   := {}
Local nPos      := 0
Local nCntFor   := 0
Local cQuery    := ""
Local cQAlias   := "SQLVC3"
Local cTitRel   := U_VR0100051_CarregaVariaveisFiltros()
Private nCodCli := ""
Private nLojCli := ""
Private nNomCli := ""
Private nRegCli := ""
Private nMunCli := ""
Private nEstCli := ""
//
If !Empty(cTitRel)
	oReport:SetTitle( cTitRel )
EndIf
//
cQuery := "SELECT SA1.A1_COD , SA1.A1_LOJA , SA1.A1_NOME ,"
cQuery += "       SA1.A1_REGIAO , VAM.VAM_DESCID , VAM.VAM_ESTADO ,"
cQuery += "       VC3.VC3_CODMAR , VC3.VC3_MODVEI ,"
If lVC3SEGMOD
	cQuery += "   VC3.VC3_SEGMOD ,"
EndIf
cQuery += "       SUM(VC3.VC3_QTDFRO) AS QTD "
cQuery += "  FROM "+RetSqlName("VC3")+" VC3"
cQuery += "  JOIN "+RetSqlName("SA1")+" SA1 ON SA1.A1_FILIAL='"+xFilial("SA1")+"' AND SA1.A1_COD=VC3.VC3_CODCLI AND SA1.A1_LOJA=VC3.VC3_LOJA AND SA1.D_E_L_E_T_=' '"
cQuery += "  JOIN "+RetSqlName("VAM")+" VAM ON VAM.VAM_FILIAL='"+xFilial("VAM")+"' AND VAM.VAM_IBGE=SA1.A1_IBGE AND VAM.D_E_L_E_T_=' '"
cQuery += U_VR0100061_Monta_WHERE_SQL() // Monta WHERE com Filtros no SQL de levantamento das Frotas
cQuery += " GROUP BY SA1.A1_COD , SA1.A1_LOJA , SA1.A1_NOME ,"
cQuery += "          SA1.A1_REGIAO , VAM.VAM_DESCID , VAM.VAM_ESTADO ,"
cQuery += "          VC3.VC3_CODMAR , VC3.VC3_MODVEI "
If lVC3SEGMOD
	cQuery += "    , VC3.VC3_SEGMOD "
EndIf
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlias, .F., .T. )
oReport:SetMeter((cQAlias)->(RecCount()))
While !((cQAlias)->(Eof())) .and. !oReport:Cancel()
	oReport:IncMeter()
	nPos := aScan(aVetImp,{ |x| x[1]+x[2] == (cQAlias)->( A1_COD ) + (cQAlias)->( A1_LOJA ) })
	If nPos == 0
		aAdd(aVetImp,{	(cQAlias)->( A1_COD ) ,;
						(cQAlias)->( A1_LOJA ) ,;
						(cQAlias)->( A1_NOME ) ,;
						(cQAlias)->( A1_REGIAO ) ,;
						(cQAlias)->( VAM_DESCID ) ,;
						(cQAlias)->( VAM_ESTADO ) ,;
						array(len(aFrotas[1])) ,;
						array(len(aFrotas[2])) })
		nPos := len(aVetImp)
		For nCntFor := 1 to len(aFrotas[1])
			aVetImp[nPos,7,nCntFor] := 0
		Next
		For nCntFor := 1 to len(aFrotas[2])
			aVetImp[nPos,8,nCntFor] := 0
		Next
	EndIf
	If cCodMarca == (cQAlias)->( VC3_CODMAR ) // Marca Principal
		FGX_VV2( (cQAlias)->( VC3_CODMAR ) ,  (cQAlias)->( VC3_MODVEI ) , IIF( lVC3SEGMOD ,  (cQAlias)->( VC3_SEGMOD ) , "" ) )
		nPosCol := ascan(aFrotas[1],{ |x| x[1] == VV2->VV2_GRUMOD })
		If nPosCol > 0
			aVetImp[nPos,7,nPosCol] += (cQAlias)->( QTD )
		EndIf
		aVetImp[nPos,8,1] += (cQAlias)->( QTD )
	Else // Outras Marcas
		aVetImp[nPos,8,2] += (cQAlias)->( QTD )
	EndIf
	aVetImp[nPos,8,3] += (cQAlias)->( QTD ) // Total Geral
	(cQAlias)->(dbSkip())
EndDo
(cQAlias)->(dbCloseArea())
DbSelectArea("VC3")
oSection1:Init()
For nPos := 1 to len(aVetImp)
	nCodCli := aVetImp[nPos,1]
	nLojCli := aVetImp[nPos,2]
	nNomCli := aVetImp[nPos,3]
	nRegCli := aVetImp[nPos,4]
	nMunCli := aVetImp[nPos,5]
	nEstCli := aVetImp[nPos,6]
	For nCntFor := 1 to len(aFrotas[1])
		&("nGRP"+strzero(nCntFor,4)) := aVetImp[nPos,7,nCntFor]
	Next
	For nCntFor := 1 to len(aFrotas[2])
		&("nTOT"+strzero(nCntFor,4)) := aVetImp[nPos,8,nCntFor]
	Next
	oSection1:PrintLine()
Next
oSection1:Finish()
//
Return Nil

/*/{Protheus.doc} VR0100021_Levanta
	Levanta registros ( VC3 )

	@author Andre Luis Almeida
	@since 01/02/2021
/*/
User Function VR0100021_Levanta()
Local aRet    := {{},{}}
Local cQuery  := ""
Local cQAlAux := "SQLAUX"
//
cQuery := "SELECT DISTINCT VC3_CODMAR , VC3_MODVEI"
If lVC3SEGMOD
	cQuery += " , VC3_SEGMOD "
EndIf
cQuery += "  FROM "+RetSqlName("VC3")
cQuery += " WHERE VC3_FILIAL='"+xFilial("VC3")+"'"
cQuery += "   AND VC3_CODMAR='"+cCodMarca+"'"
cQuery += "   AND VC3_DATVEN=' '"
cQuery += "   AND D_E_L_E_T_=' '"
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlAux, .F., .T. )
While !((cQAlAux)->(Eof()))
	FGX_VV2( (cQAlAux)->( VC3_CODMAR ) ,  (cQAlAux)->( VC3_MODVEI ) , IIF( lVC3SEGMOD ,  (cQAlAux)->( VC3_SEGMOD ) , "" ) )
	If aScan(aRet[1],{ |x| x[1] == VV2->VV2_GRUMOD }) == 0
		aAdd(aRet[1],{ VV2->VV2_GRUMOD }) // Todos os Grupos de Modelo da Marca Principal
	EndIf
	(cQAlAux)->(dbSkip())
EndDo
(cQAlAux)->(dbCloseArea())
//
aAdd(aRet[2],{ cCodMarca }) // Marca Principal
aAdd(aRet[2],{ STR0002 }) // Outras
aAdd(aRet[2],{ STR0003 }) // Total
//
DbSelectArea("VC3")
Return aClone(aRet)

/*/{Protheus.doc} VR0100031_MontaColunas
	Monta colunas dinamicas do relatorio ( dependendo dos registros do VC3 - Marca e Grupo de Modelos das Frotas )

	@author Andre Luis Almeida
	@since 01/02/2021
/*/
User Function VR0100031_MontaColunas(oSec,aAux,lTotaliza)
Local nCntFor := 0
Local cPictur := "@E 999999"
Local nTamanh := 6
For nCntFor := 1 to len(aAux[1])
	TRCell():New(oSec,"GRP"+strzero(nCntFor,4),,aAux[1,nCntFor,1],cPictur,nTamanh,,&("{|| nGRP"+strzero(nCntFor,4)+" } ") )
	If lTotaliza
		TRFunction():New(oSec:Cell("GRP"+strzero(nCntFor,4)),NIL,"SUM") // Totalizadores por Coluna
	EndIf
Next
For nCntFor := 1 to len(aAux[2])
	TRCell():New(oSec,"TOT"+strzero(nCntFor,4),,aAux[2,nCntFor,1],cPictur,nTamanh,,&("{|| nTOT"+strzero(nCntFor,4)+" } ") )
	If lTotaliza
		TRFunction():New(oSec:Cell("TOT"+strzero(nCntFor,4)),NIL,"SUM") // Totalizadores por Coluna
	EndIf
Next
Return

/*/{Protheus.doc} VR0100041_ValidPerg
	Validacao dos Parametros da Pergunte VEIR010 - Necessario limpar os demais parametros 
	
	@author Andre Luis Almeida
	@since 01/02/2021
/*/
User Function VR0100041_ValidPerg(cValid)
Local lRet     := .f.
Local lLimpa01 := .t. // Limpar variaveis pois é somente possivel um parametro por vez
Local lLimpa02 := .t. // Limpar variaveis pois é somente possivel um parametro por vez
Local lLimpa03 := .t. // Limpar variaveis pois é somente possivel um parametro por vez
Local lLimpa04 := .t. // Limpar variaveis pois é somente possivel um parametro por vez
Local lLimpa05 := .t. // Limpar variaveis pois é somente possivel um parametro por vez
Local lLimpa06 := .t. // Limpar variaveis pois é somente possivel um parametro por vez
If Empty(&(readvar()))
	Return .t.
EndIf
Do Case
	Case cValid == "VJW" // Grupo de Negocio
		lRet := !Empty(FM_SQL("SELECT VJW_CODIGO FROM "+RetSQLName("VJW")+" WHERE VJW_FILIAL='"+xFilial("VJW")+"' AND VJW_CODIGO='"+MV_PAR01+"' AND D_E_L_E_T_=' '"))
		lLimpa01 := .f.
	Case cValid == "SA11" // Codigo do Cliente
		lRet := !Empty(FM_SQL("SELECT A1_COD FROM "+RetSQLName("SA1")+" WHERE A1_FILIAL='"+xFilial("SA1")+"' AND A1_COD='"+MV_PAR02+"' AND A1_LOJA='"+MV_PAR03+"' AND D_E_L_E_T_=' '"))
		lLimpa02 := lLimpa03 := .f.
		If !lRet
			lLimpa03 := .t.
			lRet := !Empty(FM_SQL("SELECT A1_COD FROM "+RetSQLName("SA1")+" WHERE A1_FILIAL='"+xFilial("SA1")+"' AND A1_COD='"+MV_PAR02+"' AND D_E_L_E_T_=' '"))
		EndIf
	Case cValid == "SA12" // Loja do Cliente
		lRet := !Empty(FM_SQL("SELECT A1_COD FROM "+RetSQLName("SA1")+" WHERE A1_FILIAL='"+xFilial("SA1")+"' AND A1_COD='"+MV_PAR02+"' AND A1_LOJA='"+MV_PAR03+"' AND D_E_L_E_T_=' '"))
		lLimpa02 := lLimpa03 := .f.
	Case cValid == "SX5A2" // Regiao do Cliente
		lRet := !Empty(FM_SQL("SELECT X5_DESCRI FROM "+RetSQLName("SX5")+" WHERE X5_FILIAL='"+xFilial("SX5")+"' AND X5_TABELA='A2' AND X5_CHAVE='"+MV_PAR04+"' AND D_E_L_E_T_=' '"))
		lLimpa04 := .f.
	Case cValid == "VAM" // Codigo do IBGE do Cliente
		lRet := !Empty(FM_SQL("SELECT VAM_IBGE FROM "+RetSQLName("VAM")+" WHERE VAM_FILIAL='"+xFilial("VAM")+"' AND VAM_IBGE='"+MV_PAR05+"' AND D_E_L_E_T_=' '"))
		lLimpa05 := .f.
	Case cValid == "SX512" // UF do Municipio do Cliente
		lRet := !Empty(FM_SQL("SELECT X5_DESCRI FROM "+RetSQLName("SX5")+" WHERE X5_FILIAL='"+xFilial("SX5")+"' AND X5_TABELA='12' AND X5_CHAVE='"+MV_PAR06+"' AND D_E_L_E_T_=' '"))
		lLimpa06 := .f.
EndCase
IIf(lLimpa01,MV_PAR01:=space(GetSX3Cache("VJW_CODIGO","X3_TAMANHO")),.t.)
IIf(lLimpa02,MV_PAR02:=space(GetSX3Cache("A1_COD"    ,"X3_TAMANHO")),.t.)
IIf(lLimpa03,MV_PAR03:=space(GetSX3Cache("A1_LOJA"   ,"X3_TAMANHO")),.t.)
IIf(lLimpa04,MV_PAR04:=space(GetSX3Cache("X5_CHAVE"  ,"X3_TAMANHO")),.t.)
IIf(lLimpa05,MV_PAR05:=space(GetSX3Cache("VAM_IBGE"  ,"X3_TAMANHO")),.t.)
IIf(lLimpa06,MV_PAR06:=space(GetSX3Cache("A1_EST"    ,"X3_TAMANHO")),.t.)
Return lRet

/*/{Protheus.doc} VR0100051_CarregaVariaveisFiltros
	Carrega Variaveis para serem utilizados nos Filtros (parametros)
	
	@author Andre Luis Almeida
	@since 01/02/2021
/*/
User Function VR0100051_CarregaVariaveisFiltros()
Local cTitRel := ""
If lFazPerg // Utilizou a Pergunte ? --> Se sim, utilizar os Parametros / Se não, utilizar os Parametros passados na chamada do Relatorio
	cP_GruNeg := MV_PAR01 // Grupo de Negocio
	cP_CodCli := MV_PAR02 // Codigo do Cliente
	cP_LojCli := MV_PAR03 // Loja do Cliente
	cP_RegCli := MV_PAR04 // Regiao
	cP_MunCli := MV_PAR05 // Municipio (IBGE)
	cP_UFMCli := MV_PAR06 // UF
EndIf
Do Case
	Case !Empty(cP_GruNeg)
		cTitRel := STR0004+": "+cP_GruNeg // Frotas do Grupo de Negocio
	Case !Empty(cP_CodCli+cP_LojCli)
		cTitRel := STR0005+": "+cP_CodCli // Frota do Cliente
		If !Empty(cP_LojCli)
			cTitRel += "-"+cP_LojCli
		Else
			cTitRel += " ("+STR0006+")" // todas lojas
		EndIf
	Case !Empty(cP_RegCli)
		cTitRel := STR0007+": "+Alltrim(cP_RegCli)+" - "+FM_SQL("SELECT X5_DESCRI FROM "+RetSQLName("SX5")+" WHERE X5_FILIAL='"+xFilial("SX5")+"' AND X5_TABELA='A2' AND X5_CHAVE='"+cP_RegCli+"' AND D_E_L_E_T_=' '") // Frotas da Regiao
	Case !Empty(cP_MunCli)
		VAM->(DbSetOrder(1))
		VAM->(Dbseek(xFilial("VAM")+cP_MunCli))
		cTitRel := STR0001+" - "+Alltrim(left(VAM->VAM_DESCID,30))+" - "+VAM->VAM_ESTADO // Frotas
	Case !Empty(cP_UFMCli)
		cTitRel := STR0008+" - "+cP_UFMCli // Frotas do Estado
EndCase
Return cTitRel

/*/{Protheus.doc} VR0100061_Monta_WHERE_SQL
	Monta WHERE com Filtros no SQL de levantamento das Frotas
	
	@author Andre Luis Almeida
	@since 02/02/2021
/*/
User Function VR0100061_Monta_WHERE_SQL()
Local cQuery := ""
cQuery += " WHERE VC3.VC3_FILIAL='"+xFilial("VC3")+"'"
cQuery += "   AND VC3.VC3_DATVEN=' '"
cQuery += "   AND VC3.D_E_L_E_T_=' '"
cQuery += IIf(!Empty(cP_CodCli)," AND SA1.A1_COD='"    +cP_CodCli+"'","")
cQuery += IIf(!Empty(cP_LojCli)," AND SA1.A1_LOJA='"   +cP_LojCli+"'","")
cQuery += IIf(!Empty(cP_RegCli)," AND SA1.A1_REGIAO='" +cP_RegCli+"'","")
cQuery += IIf(!Empty(cP_MunCli)," AND SA1.A1_IBGE='"   +cP_MunCli+"'","")
cQuery += IIf(!Empty(cP_UFMCli)," AND VAM.VAM_ESTADO='"+cP_UFMCli+"'","")
If !Empty(cP_GruNeg)
	cQuery += " AND EXISTS ("
	cQuery += "     SELECT VJX.VJX_GRUNEG "
	cQuery += "       FROM "+RetSqlName("VJX")+" VJX "
	cQuery += "      WHERE VJX.VJX_FILIAL='"+xFilial("VJX")+"'"
	cQuery += "        AND VJX.VJX_GRUNEG='"+cP_GruNeg+"'"
	cQuery += "        AND VJX.VJX_CODCLI=SA1.A1_COD"
	cQuery += "        AND VJX.VJX_LOJCLI=SA1.A1_LOJA"
	cQuery += "        AND VJX.D_E_L_E_T_=' ' )"
EndIf
Return cQuery