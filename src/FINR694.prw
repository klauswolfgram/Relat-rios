/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE 'Protheus.ch'
#INCLUDE 'FWMVCDEF.ch'
#INCLUDE "FINR694.ch"
Static cTpPgtCbx := ""
/*----------------------------------------------------------------------------------------------------------------------*/
/*/{Protheus.doc} FINR694
Relatório de Conciliação de EBTA
@author Jacomo Lisa
@since 17/08/15
/*/
/*--------------------------------------------------------------------------------------------------------------------*/
User Function FINR694()
Local oReport
Local aArea	:= GetArea()
If TRepInUse()
	oReport := ReportDef()
	oReport:PrintDialog()
Endif

RestArea(aArea)

Return .T.

/*----------------------------------------------------------------------------------------------------------------------*/
/*/{Protheus.doc} ReportDef
Definicao do objeto do relatorio personalizavel e das secoes que serao utilizadas.
@return oReport 
@author Jacomo Lisa
@since 17/08/15
/*/
/*--------------------------------------------------------------------------------------------------------------------*/
Static Function ReportDef()
Local oReport
Local oSection1
Local cReport 	:= "FINR694"	// Nome do relatorio
Local cTitulo 	:= STR0001		//"Conciliação de Viagem"
Local cDescri 	:= STR0002		//"Relatório de Conciliação"
Local cPerg		:= "FINR694"	// Nome do grupo de perguntas
Local N1 		:= 0
Local cN1		:= ""

SX1->(DBSEEK(AvKey("FINA694A","X1_GRUPO")+"01"))
For N1 := 1 to 5
	cN1 := Alltrim(str(n1))
	If !Empty(+AllTrim(&("x1def0"+cN1+"()"))) 
		cTpPgtCbx += ";"+cN1+"="+AllTrim(&("x1def0"+cN1+"()"))
	EndIf 
Next
cTpPgtCbx := SubStr(cTpPgtCbx,2)
/************************************************************************************************\
|* Verifica as perguntas selecionadas															*|
|* Variaveis utilizadas para parametros															*|
|* mv_par01	-->	Itens a Imprimir (CB: 1=Não Conciliados; 2= Conciliado; 3=Conferidos; 4= Todos )*|
|* mv_par02	-->	Agrupamento (CB: 1=Não Agrupado; 2=Por Viagem;3=Por Conciliação)				*|
|* mv_par03	-->	Viagem Inicial																	*|
|* mv_par04	-->	Viagem Final																	*|
|* mv_par05	-->	Conferencia Inicial																*|
|* mv_par06	-->	Conferencia Final																*|
|* mv_par07	-->	Seleciona Filiais (CB: 1=Sim;2=Não) Obs: Caso Não, não mostra coluna Filial		*|
\************************************************************************************************/
Pergunte("FINR694",.F.)
If mv_par02 == 1
	cDescri +=" - " + STR0003  
ElseIf mv_par02 == 2
	cDescri +=" - " + STR0004  
Else 
	cDescri +=" - " + STR0005
Endif
oReport := TReport():New(cReport, cTitulo, cPerg, {|oReport| ReportPrint(oReport)}, cDescri)

oReport:SetPortrait()	//Imprime o relatorio no formato retrato
oReport:HideFooter()	//Oculta o rodape do relatorio

// Secao 01
oSection1 := TRSection():New(oReport, STR0006 , {"FWN"})	//"CABECALHO"

oSection1:SetTotalInLine(.F.)	//O totalizador da secao sera impresso em coluna
oSection1:SetHeaderBreak(.T.)	//Imprime o cabecalho das celulas apos a quebra

Return oReport

/*---------------------	-------------------------------------------------------------------------------------------------*/
/*/{Protheus.doc} ReportPrint
Imprime o objeto oReport definido na funcao ReportDef
@author Jacomo Lisa
@param oReport - Objeto para impressão definido pela função ReportDef
@return oReport 
@since 17/08/15
/*/
/*--------------------------------------------------------------------------------------------------------------------*/
Static Function ReportPrint(oReport)
Local oSection1 	:= oReport:Section(1)
Local cTmpSE2Fil	:= ""
Local aFilial		:= {}
Local cChave      	:= ""
Local cAliasREL		:= "FWN"
Local cFilQuery		:= ""
Local nLen			:= 0
Local aCpos			:= {}
Local cCampos		:= ""
Local cQuery		:= ""
Local nX,N1
Local aCels		:= {}
Local cTipo		:= ""


aCels	:= MontaCel()
FOR N1 := 1 TO LEN (aCels)
	TRCell():New(oSection1, aCels[N1][1], aCels[N1][2], aCels[N1][3], aCels[N1][4], aCels[N1][5],/*lPixel*/,/*CodeBlock*/)	//"PRF"
NEXT

oSection1:Cell("FLQ_TPPGTO"):SetCBox(cTpPgtCbx)


aADD(aCpos,{"R_E_C_N_O_","FWN"})
aADD(aCpos,{"FWN_FILIAL","FWN"})
aADD(aCpos,{"FWN_TPDESP","FWN"})
aADD(aCpos,{"FWN_IDRESE","FWN"})
aADD(aCpos,{"FWN_NUMFAT","FWN"})
aADD(aCpos,{"FWN_VTRANS","FWN"})
aADD(aCpos,{"FL6_IDRESE","FL6"})
aADD(aCpos,{"FL6_VIAGEM","FL6"})
aADD(aCpos,{"FLQ_CONFER","FLQ"})
aADD(aCpos,{"FLQ_DATA"  ,"FLQ"})
aADD(aCpos,{"FLQ_TPPGTO","FLQ"})
aADD(aCpos,{"FLQ_PEDIDO","FLQ"})
aADD(aCpos,{"FLQ_PREFIX","FLQ"})
aADD(aCpos,{"FLQ_NUMTIT","FLQ"})
	
If oReport:lXlsTable
	ApMsgAlert(STR0013) //"Formato de impressão Tabela não suportado neste relatório"
	oReport:CancelPrint()
	Return
Endif

For nX := 1 to Len(aCpos)
	cCampos += ","+aCpos[nX][2]+"."+aCpos[nX][1] 
Next
cCampos := "%"+SubStr(cCampos,2)+"%"
SEA->(DbGoTop())
SE2->(DbGoTop())

If MV_PAR02 == 1 //Simpres
	cChave := FWN->(IndexKey())
ElseIf MV_PAR02 == 2 //por viagem 
	cChave := "FWN.FWN_VIAGEM"
Else // Por conciliação
	cChave := "FWN.FWN_CONFER"
Endif

	cAliasREL 		:= GetNextAlias()

	cChave 	:= "%"+SqlOrder(cChave)+"%"

	
	//Seleciona filiais
	If MV_PAR07 == 1 //Sim
		aFilial := AdmGetFil(.F.,.T.,"SE2")
	Endif
	
	If !Empty(aFilial)
		cFilQuery += " FWN.FWN_FILIAL " + GetRngFil( aFilial, "FWN", .T., @cTmpSE2Fil ) 
		//aAdd(aTmpFil, cTmpSE2Fil)
	Else
		cFilQuery += " FWN.FWN_FILIAL = '" + xFilial("FWN") + "' "
	EndIf
	
	//Tipo - Hotel ou Aéreo.
	If MV_PAR08 != 3
		cTipo := AllTrim(Str(MV_PAR08)) 
		cFilQuery += "AND FWN.FWN_TPDESP = '" + cTipo + "'"
	EndIf
	//
	cFilQuery := "%"+cFilQuery+"%"

	oSection1:BeginQuery()
	BeginSql Alias cAliasREL
		SELECT	%Exp:cCampos%
		
		FROM	%table:FWN% FWN
				
			LEFT JOIN %table:FLQ% FLQ 
			ON FWN.FWN_CONFER = FLQ.FLQ_CONFER AND FLQ.%notDel%
							
			LEFT JOIN  %table:FL6% FL6
			ON FWN.FWN_VIAGEM = FL6.FL6_VIAGEM AND FWN.%notDel%
			
		WHERE 
		    %Exp:cFilQuery% AND
			FWN_VIAGEM BETWEEN %Exp:MV_PAR03% and %Exp:MV_PAR04% AND
			FWN.FWN_CONFER BETWEEN %Exp:MV_PAR05% and %Exp:MV_PAR06% AND
			FWN.%notDel%
		ORDER BY %Exp:cChave%
	EndSql
	
	oSection1:EndQuery()
	oSection1:SetParentQuery()
	

oSection1:Cell("STATUS"):SetBlock( { ||(FWN->(DBGOTO((cAliasREL)->R_E_C_N_O_) ) ,F694SetBlock("STATUS"))} )

oSection1:Cell("DOCUMENTO"):SetBlock( { ||(FWN->(DBGOTO((cAliasREL)->R_E_C_N_O_) ) ,F694SetBlock("DOCUMENTO"))} )

oSection1:SetLineCondition( { ||	 ValidLine(Eval(oSection1:Cell("STATUS"):GetValue())) } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia a impressao.						 								  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:Print()

Return

/*--------------------------------------------------------------------------------------------------------------------*/
/*/{Protheus.doc} MontaCel
Monta um Array de Acordo com o tipo de Relatório
@author Jacomo Lisa
@since 17/08/15
/*/
/*--------------------------------------------------------------------------------------------------------------------*/
Static Function MontaCel()
Local aCels		:= {}//aADD(aCels, {cCampo,cAlias,cTitulo,cPicture,nTamanho})
Local nTamDoc	:= TamSX3("FLQ_PREFIX")[1] + TamSX3("FLQ_NUMTIT")[1]
If MV_PAR07 == 1 //Se seleciona Filial, inclui a coluna Filial na primeira Posição
	aADD(aCels, {"FWN_FILIAL","FWN",SX3->(RetTitle("FWN_FILIAL")),PesqPict("FWN","FWN_FILIAL"),TamSX3("FWN_FILIAL")[1]})
Endif
// mv_par02	-->	Agrupamento (CB: 1=Não Agrupado; 2=Por Viagem;3=Por Conciliação)
If MV_PAR02 == 1	
	aADD(aCels, {"STATUS","","Status","",15})
	aADD(aCels, {"FWN_TPDESP","FWN",SX3->(RetTitle("FWN_TPDESP")),PesqPict("FWN","FWN_TPDESP"),TamSX3("FWN_TPDESP")[1]})
	aADD(aCels, {"FWN_IDRESE","FWN",SX3->(RetTitle("FWN_IDRESE")),PesqPict("FWN","FWN_IDRESE"),TamSX3("FWN_IDRESE")[1]})
	aADD(aCels, {"FWN_NUMFAT","FWN",SX3->(RetTitle("FWN_NUMFAT")),PesqPict("FWN","FWN_NUMFAT"),TamSX3("FWN_NUMFAT")[1]})
	aADD(aCels, {"FWN_VTRANS","FWN",SX3->(RetTitle("FWN_VTRANS")),PesqPict("FWN","FWN_VTRANS"),TamSX3("FWN_VTRANS")[1]})
	aADD(aCels, {"FL6_IDRESE","FL6",SX3->(RetTitle("FL6_IDRESE")),PesqPict("FL6","FL6_IDRESE"),TamSX3("FL6_IDRESE")[1]})
	aADD(aCels, {"FL6_VIAGEM","FL6",SX3->(RetTitle("FL6_VIAGEM")),PesqPict("FL6","FL6_VIAGEM"),TamSX3("FL6_VIAGEM")[1]})
	aADD(aCels, {"FLQ_CONFER","FLQ",SX3->(RetTitle("FLQ_CONFER")),PesqPict("FLQ","FLQ_CONFER"),TamSX3("FLQ_CONFER")[1]})
	aADD(aCels, {"FLQ_DATA"  ,"FLQ",SX3->(RetTitle("FLQ_DATA"  )),PesqPict("FLQ","FLQ_DATA"  ),TamSX3("FLQ_DATA"  )[1]})
	aADD(aCels, {"FLQ_TPPGTO","FLQ",SX3->(RetTitle("FLQ_TPPGTO")),PesqPict("FLQ","FLQ_TPPGTO"),TamSX3("FLQ_TPPGTO")[1]})
	aADD(aCels, {"DOCUMENTO" ,"FLQ",STR0007,PesqPict("FLQ","FLQ_NUMTIT"),nTamDoc})
	
Elseif MV_PAR02 == 2
	aADD(aCels, {"FWN_IDRESE","FWN",SX3->(RetTitle("FWN_IDRESE")),PesqPict("FWN","FWN_IDRESE"),TamSX3("FWN_IDRESE")[1]})
	aADD(aCels, {"STATUS","","Status","",15})
	aADD(aCels, {"FWN_TPDESP","FWN",SX3->(RetTitle("FWN_TPDESP")),PesqPict("FWN","FWN_TPDESP"),TamSX3("FWN_TPDESP")[1]})
	aADD(aCels, {"FWN_NUMFAT","FWN",SX3->(RetTitle("FWN_NUMFAT")),PesqPict("FWN","FWN_NUMFAT"),TamSX3("FWN_NUMFAT")[1]})
	aADD(aCels, {"FWN_VTRANS","FWN",SX3->(RetTitle("FWN_VTRANS")),PesqPict("FWN","FWN_VTRANS"),TamSX3("FWN_VTRANS")[1]})
	aADD(aCels, {"FL6_IDRESE","FL6",SX3->(RetTitle("FL6_IDRESE")),PesqPict("FL6","FL6_IDRESE"),TamSX3("FL6_IDRESE")[1]})
	aADD(aCels, {"FL6_VIAGEM","FL6",SX3->(RetTitle("FL6_VIAGEM")),PesqPict("FL6","FL6_VIAGEM"),TamSX3("FL6_VIAGEM")[1]})
	aADD(aCels, {"FLQ_CONFER","FLQ",SX3->(RetTitle("FLQ_CONFER")),PesqPict("FLQ","FLQ_CONFER"),TamSX3("FLQ_CONFER")[1]})
	aADD(aCels, {"FLQ_DATA"  ,"FLQ",SX3->(RetTitle("FLQ_DATA"  )),PesqPict("FLQ","FLQ_DATA"  ),TamSX3("FLQ_DATA"  )[1]})
	aADD(aCels, {"FLQ_TPPGTO","FLQ",SX3->(RetTitle("FLQ_TPPGTO")),PesqPict("FLQ","FLQ_TPPGTO"),TamSX3("FLQ_TPPGTO")[1]})
	aADD(aCels, {"DOCUMENTO" ,"FLQ",STR0007,PesqPict("FLQ","FLQ_NUMTIT"),nTamDoc})
	
Else
	aADD(aCels, {"FWN_TPDESP","FWN",SX3->(RetTitle("FWN_TPDESP")),PesqPict("FWN","FWN_TPDESP"),TamSX3("FWN_TPDESP")[1]})
	aADD(aCels, {"FLQ_CONFER","FLQ",SX3->(RetTitle("FLQ_CONFER")),PesqPict("FLQ","FLQ_CONFER"),TamSX3("FLQ_CONFER")[1]})
	aADD(aCels, {"FLQ_DATA"  ,"FLQ",SX3->(RetTitle("FLQ_DATA"  )),PesqPict("FLQ","FLQ_DATA"  ),TamSX3("FLQ_DATA"  )[1]})
	aADD(aCels, {"FLQ_TPPGTO","FLQ",SX3->(RetTitle("FLQ_TPPGTO")),PesqPict("FLQ","FLQ_TPPGTO"),TamSX3("FLQ_TPPGTO")[1]})
	aADD(aCels, {"DOCUMENTO" ,"FLQ",STR0007,PesqPict("FLQ","FLQ_NUMTIT"),nTamDoc})
	aADD(aCels, {"STATUS","","Status","",15})
	aADD(aCels, {"FWN_IDRESE","FWN",SX3->(RetTitle("FWN_IDRESE")),PesqPict("FWN","FWN_IDRESE"),TamSX3("FWN_IDRESE")[1]})
	aADD(aCels, {"FWN_NUMFAT","FWN",SX3->(RetTitle("FWN_NUMFAT")),PesqPict("FWN","FWN_NUMFAT"),TamSX3("FWN_NUMFAT")[1]})
	aADD(aCels, {"FWN_VTRANS","FWN",SX3->(RetTitle("FWN_VTRANS")),PesqPict("FWN","FWN_VTRANS"),TamSX3("FWN_VTRANS")[1]})
	aADD(aCels, {"FL6_IDRESE","FL6",SX3->(RetTitle("FL6_IDRESE")),PesqPict("FL6","FL6_IDRESE"),TamSX3("FL6_IDRESE")[1]})
	aADD(aCels, {"FL6_VIAGEM","FL6",SX3->(RetTitle("FL6_VIAGEM")),PesqPict("FL6","FL6_VIAGEM"),TamSX3("FL6_VIAGEM")[1]})
	
EndIf


Return aCels


/*--------------------------------------------------------------------------------------------------------------------*/
/*/{Protheus.doc} F694SetBlock()
Preenche campos não utilizados na query
@author Jacomo Lisa
@since 17/08/15
/*/
/*--------------------------------------------------------------------------------------------------------------------*/
Static Function F694SetBlock(cCampo)
Local xRet
Local aArea	:= GetArea()
Do Case	
//'1=Não Conciliado;2=Conciliado;3=Concil./Confer.;4=Concil.Manual.;5=Conc.Man./Conf.'
	Case cCampo == "STATUS"
		IF !EMPTY(FWN->FWN_VIAGEM) .AND. !EMPTY(FWN->FWN_CONFER)
			If Posicione( "FL6", 1, FWN->FWN_FILIAL + FWN->FWN_VIAGEM, "FL6_IDRESE" ) <> FWN->FWN_IDRESE 
				xRet := STR0008
			Else
				xRet := STR0009 
			Endif
		ElseIf !EMPTY(FWN->FWN_VIAGEM)
			If	Posicione( "FL6", 1, FWN->FWN_FILIAL + FWN->FWN_VIAGEM, "FL6_IDRESE" ) <> FWN->FWN_IDRESE
				xRet := STR0010
			Else
				xRet := STR0011
			Endif
		Else
			xRet := STR0012
		ENDIF
	Case cCampo == "DOCUMENTO" //1=Contas a pagar;2=Pedido de compra;3=Documento de entrada
		IF FLQ->(DBSEEK(FWN->FWN_FILIAL + FWN->FWN_CONFER)) 
			If FLQ->FLQ_TPPGTO <> "2"
				xRet := FLQ->FLQ_PREFIX + ' ' + FLQ->FLQ_NUMTIT  
			Else
				xRet := FLQ->FLQ_PEDIDO
			Endif 
		ENDIF
EndCase

RestArea(aArea)

Return xRet

/*--------------------------------------------------------------------------------------------------------------------*/
Static Function ValidLine(xConteudo)
Local lRet := .T.
Default xConteudo := ""
//1=Não Conciliados; 2= Conciliado; 3=Conferidos; 4= Todos
If MV_PAR01 == 1
	lRet :=  Alltrim(xConteudo) == STR0012  
ELSEIF MV_PAR01 == 2
	lRet :=  Alltrim(xConteudo) <> STR0012
ELSEIF MV_PAR01 == 3
	lRet :=  Alltrim(xConteudo)  == STR0008 .or. Alltrim(xConteudo)  == STR0009
ENDIF

Return lRet