/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'totvs.ch'
#include 'finr158.ch'

STATIC cRngFilSE2 := NIL
STATIC cRngFilSED := NIL
STATIC cRngFilSA2 := NIL

// #########################################################################################
// Projeto: 11.80
// Modulo : Financeiro
// Fonte  : FINR158.prw
// ---------+-------------------+-----------------------------------------------------------
// Data     | Autor             | Descricao
// ---------+-------------------+-----------------------------------------------------------
// 07/01/13 | Marcos Berto	    | Títulos a Pagar por Natureza
// #########################################################################################

User Function Finr158()

Local oReport

PRIVATE aSelFil   := {}

oReport := ReportDef()
oReport:PrintDialog()

Return


//------------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportDef

Definição da estrutura do relatório
	Primeira sessão - Dados dos títulos
	Segunda sessão - Totalizador pelas sintéticas

@author    Marcos Berto
@version   11.80
@since     07/01/13

@return oReport - Objeto de Relatório

/*/
//------------------------------------------------------------------------------------------
Static Function ReportDef()

Local nX		 	:= 0
Local nPosFim		:= 0
Local nTam			:= 0

Local oSecTit
Local oSecTot
Local oReport

oReport:= TReport():New("FINR158",STR0002,"FIN158",{|oReport| ReportPrint(oReport)},STR0002) //"Titulos a Pagar por Natureza"
oReport:SetLandscape(.T.)


dbSelectArea("SE2")

oSecTit := TRSection():New(oReport,STR0002,,,,,,,,,,,,,,.F.)
// TRCELL():New(01 oParent,    02 cName, 03 cAlias,    04 cTitle, 05 cPicture,  06 nSize,  07 lPixel,                   08 bBlock, 09 cAlign, 10 lLineBreak, 11 cHeaderAlign, 12 lCellBreak, 13 nColSpace, 14 lAutoSize, 15 nClrBack, 16 nClrFore, 17 lBold)
TRCell():New(oSecTit,"FORNECE"	,,RetTitle("E2_FORNECE")		,PesqPict("SE2","E2_FORNECE")	,TamSX3("E2_FORNECE")[1] + 10	,.F.,,,,,,0,.F.)
TRCell():New(oSecTit,"LOJA"		,,RetTitle("E2_LOJA")			,PesqPict("SE2","E2_LOJA")		,TamSX3("E2_LOJA")[1] 			,.F.,,,,,,0,.F.)
TRCell():New(oSecTit,"NOMFOR"	,,STR0010 /*Nome*/				,PesqPict("SA2","A2_NREDUZ")	,40							,.F.,,,,,,0,.F.)
TRCell():New(oSecTit,"PREFIXO"	,,RetTitle("E2_PREFIXO")		,PesqPict("SE2","E2_PREFIXO")	,TamSX3("E2_PREFIXO")[1] + 1	,.F.,,"CENTER",,,,0,.F.)
TRCell():New(oSecTit,"NUMERO"	,,RetTitle("E2_NUM")			,PesqPict("SE2","E2_NUM")		,TamSX3("E2_NUM")[1] + 8		,.F.,,"CENTER",,,,0,.F.)
TRCell():New(oSecTit,"PARCELA"	,,RetTitle("E2_PARCELA")		,PesqPict("SE2","E2_PARCELA")	,TamSX3("E2_PARCELA")[1] + 2	,.F.,,"CENTER",,,,0,.F.)
TRCell():New(oSecTit,"TIPO"		,,RetTitle("E2_TIPO")			,PesqPict("SE2","E2_TIPO")		,TamSX3("E2_TIPO")[1] + 2		,.F.,,,,,,0,.F.)
TRCell():New(oSecTit,"EMISSAO"	,,RetTitle("E2_EMISSAO")		,PesqPict("SE2","E2_EMISSAO")	,TamSX3("E2_EMISSAO")[1] + 11	,.F.,,,,,,0,.F.)
TRCell():New(oSecTit,"VENCTO"	,,RetTitle("E2_VENCTO")			,PesqPict("SE2","E2_VENCTO")	,TamSX3("E2_VENCTO")[1]  + 11	,.F.,,,,,,0,.F.)
TRCell():New(oSecTit,"VENCREA"	,,RetTitle("E2_VENCREA")		,PesqPict("SE2","E2_VENCREA")	,TamSX3("E2_VENCREA")[1] + 11	,.F.,,,,,,0,.F.)
TRCell():New(oSecTit,"BANCO"	,,RetTitle("E2_PORTADO")		,PesqPict("SE2","E2_PORTADO")	,TamSX3("E2_PORTADO")[1] + 8	,.F.,,,,,,0,.F.)
TRCell():New(oSecTit,"NUMBANCO"	,,RetTitle("E2_NUMBCO")			,PesqPict("SE2","E2_NUMBCO")	,TamSX3("E2_NUMBCO")[1]	+ 12 	,.F.,,,,,,0,.F.)
TRCell():New(oSecTit,"VALORIG"	,,RetTitle("E2_VALOR")			,PesqPict("SE2","E2_VALOR")		,TamSX3("E2_VALOR")[1] + 20	,.F.,,,,,,0,.F.)
TRCell():New(oSecTit,"SALDO"	,,STR0006 /*Saldo*/				,PesqPict("SE2","E2_VALOR")		,TamSX3("E2_VALOR")[1] + 20		,.F.,,,,,,0,.F.)
TRCell():New(oSecTit,"VALCORR"	,,STR0007 /*Valor Corrigido*/	,PesqPict("SE2","E2_VALOR")		,TamSX3("E2_VALOR")[1] + 20	,.F.,,,,,,0,.F.)
TRCell():New(oSecTit,"JUROS"	,,STR0008 /*Juros*/				,PesqPict("SE2","E2_JUROS")		,TamSX3("E2_JUROS")[1]			,.F.,,,,,,0,.F.)
TRCell():New(oSecTit,"ATRASO"	,,STR0009 /*Dias de Atraso*/	,/*Picture*/""					,20						,.F.,,"CENTER",,,,0,.F.)
TRCell():New(oSecTit,"HIST"		,,RetTitle("E2_HIST")			,PesqPict("SE2","E2_HIST")		,TamSX3("E2_HIST")[1]+10		,.F.,,,,,,0,.F.)
TRCell():New(oSecTit,"NATUREZA"	,,RetTitle("E2_NATUREZ")		,PesqPict("SE2","E2_NATUREZ")	,TamSX3("E2_NATUREZ")[1]		,.F.,,,,,,0,.F.)

/*GESTAO - inicio */
oReport:SetUseGC(.F.)
/* GESTAO - fim
*/

oSecTit:SetTotalInLine(.F.)
oSecTit:SetHeaderPage(.T.)

oSecTit:Cell("VALORIG"):SetAlign("RIGHT")
oSecTit:Cell("SALDO"):SetAlign("RIGHT")
oSecTit:Cell("VALCORR"):SetAlign("RIGHT")
oSecTit:Cell("JUROS"):SetAlign("cENTER")

oSecTit:Cell("VALORIG"):SetHeaderAlign("RIGHT")
oSecTit:Cell("SALDO"):SetHeaderAlign("RIGHT")
oSecTit:Cell("VALCORR"):SetHeaderAlign("RIGHT")
oSecTit:Cell("JUROS"):SetHeaderAlign("CENTER")

oSecTit:Cell("VALORIG"):SetNegative("PARENTHESES")
oSecTit:Cell("SALDO"):SetNegative("PARENTHESES")
oSecTit:Cell("VALCORR"):SetNegative("PARENTHESES")
oSecTit:Cell("JUROS"):SetNegative("PARENTHESES")

oSecTot := TRSection():New(oReport,STR0003 /*Totais*/,,,,,,,,,,,,,,.F.)

//Processa as colunas
nPosFim := aScan(oSecTit:aCell,{|x| x:cName == "NUMBANCO"})

	For nX := 1 to nPosFim
		nTam += oSecTit:Cell(oSecTit:aCell[nX]:cName):GetSize()
		nTam += oReport:nColSpace //Adiciona os espaços entre as colunas
	Next nX


TRCell():New(oSecTot,"TITULO"		,,"",,nTam-84,.F.,,,,,,,.F.)
TRCell():New(oSecTot,"VALORIG"		,,"",PesqPict("SE2","E2_VALOR")	,	TamSX3("E2_VALOR")[1],.F.,,,,,,,.F.)

TRCell():New(oSecTot,"SALDO"		,,"",PesqPict("SE2","E2_VALOR")	, 	TamSX3("E2_VALOR")[1]+1,.F.,,,,,,,.F.)
TRCell():New(oSecTot,"VALCORR"		,,"",PesqPict("SE2","E2_VALOR")	,	TamSX3("E2_VALOR")[1]+1,.F.,,,,,,,.F.)
TRCell():New(oSecTot,"JUROS"		,,"",PesqPict("SE2","E2_JUROS")	,	TamSX3("E2_JUROS")[1],.F.,,,,,,,.F.)

oSecTot:Cell("VALORIG"):SetAlign("RIGHT")
oSecTot:Cell("SALDO"):SetAlign("RIGHT")
oSecTot:Cell("VALCORR"):SetAlign("RIGHT")
oSecTot:Cell("JUROS"):SetAlign("RIGHT")


oSecTot:Cell("VALORIG"):SetHeaderAlign("RIGHT")
oSecTot:Cell("SALDO"):SetHeaderAlign("RIGHT")
oSecTot:Cell("VALCORR"):SetHeaderAlign("RIGHT")
oSecTot:Cell("JUROS"):SetHeaderAlign("RIGHT")


oSecTot:Cell("VALORIG"):SetNegative("PARENTHESES")
oSecTot:Cell("SALDO"):SetNegative("PARENTHESES")
oSecTot:Cell("VALCORR"):SetNegative("PARENTHESES")
oSecTot:Cell("JUROS"):SetNegative("PARENTHESES")

oSecTot:SetTotalInLine(.F.)
oSecTot:SetHeaderPage(.F.)




Return oReport

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint

Impressão do relatório

@author    Marcos Berto
@version   11.80
@since     27/12/12

@param oReport - Objeto de Relatório

/*/
//------------------------------------------------------------------------------------------
Static Function ReportPrint(oReport)

Local cNatPai		:= ""
Local cNatureza 	:= ""
Local oSecTit 	:= oReport:Section(1)
Local oSecTot 	:= oReport:Section(2)
Local oBreak

//Gestao
Local nRegSM0	:= SM0->(Recno())
Local lGestao   := FWSizeFilial() > 2	// Indica se usa Gestao Corporativa
Local lSE2Access:= IIf( lGestao, FWModeAccess("SE2",1) == "E", FWModeAccess("SE2",3) == "E")
Local aTmpFil	:= {}
Local cTmpSE2Fil:= ""
Local cTmpSEDFil:= ""
Local cTmpSA2Fil:= ""
Local nX := 0
Private cTRBSED := CriaTrab(Nil,.F.)
Private cTRBSE2 := CriaTrab(Nil,.F.)

//Força preenchimento dos parametros mv_parXX
Pergunte("FIN158",.F.)

//Gestao
nRegSM0 := SM0->(Recno())

If mv_par34 == 1
	If lSE2Access .And. !IsBlind()	//filial nao totalmente compartilhada
		If lGestao
			If FindFunction("FwSelectGC")
				aSelFil := FwSelectGC()
			Else
				aSelFil := AdmGetFil(.F.,.F.,"SE2")
			Endif
		Else		// Se nao for gestao, usa AdmGetFil()
			aSelFil := AdmGetFil(.F.,.F.,"SE2")
		EndIf
	Endif
EndIf

If Empty(aSelFil)
	aSelFil := {cFilAnt}
Endif

SM0->(DbGoTo(nRegSM0))

cRngFilSE2 := GetRngFil( aSelFil, "SE2", .T., @cTmpSE2Fil )
aAdd(aTmpFil, cTmpSE2Fil)
cRngFilSED := GetRngFil( aSelFil, "SED", .T., @cTmpSEDFil )
aAdd(aTmpFil, cTmpSEDFil)
cRngFilSA2 := GetRngFil( aSelFil, "SA2", .T., @cTmpSA2Fil )
aAdd(aTmpFil, cTmpSE2Fil)

//Alimenta o arquivo temporário
U_F158GerTrb()
	
//Totaliza por natureza
U_F158TotNat()
	
oSecTit:Cell("FORNECE"):SetBlock({|| TMPSE2->E2_FORNECE })
oSecTit:Cell("LOJA"):SetBlock({|| TMPSE2->E2_LOJA })
oSecTit:Cell("NOMFOR"):SetBlock({|| GetLGPDValue('TMPSE2','A2_NREDUZ') })
oSecTit:Cell("PREFIXO"):SetBlock({|| TMPSE2->E2_PREFIXO })
oSecTit:Cell("NUMERO"):SetBlock({|| TMPSE2->E2_NUM })
oSecTit:Cell("PARCELA"):SetBlock({|| TMPSE2->E2_PARCELA })
oSecTit:Cell("TIPO"):SetBlock({|| TMPSE2->E2_TIPO })
oSecTit:Cell("EMISSAO"):SetBlock({|| TMPSE2->E2_EMISSAO })
oSecTit:Cell("VENCTO"):SetBlock({|| TMPSE2->E2_VENCTO })
oSecTit:Cell("VENCREA"):SetBlock({|| TMPSE2->E2_VENCREA })
oSecTit:Cell("BANCO"):SetBlock({|| TMPSE2->E2_PORTADO })
oSecTit:Cell("NUMBANCO"):SetBlock({|| TMPSE2->E2_NUMBCO })
oSecTit:Cell("VALORIG"):SetBlock({|| TMPSE2->E2_VALOR })
oSecTit:Cell("SALDO"):SetBlock({|| TMPSE2->E2_SALDO })
oSecTit:Cell("VALCORR"):SetBlock({|| TMPSE2->E2_VALCORR })
oSecTit:Cell("JUROS"):SetBlock({|| TMPSE2->E2_JUROS })
oSecTit:Cell("ATRASO"):SetBlock({|| TMPSE2->E2_ATRASO })
oSecTit:Cell("HIST"):SetBlock({|| TMPSE2->E2_HIST })
If oReport:nDevice == 4		//Formato planilha
	oSecTit:Cell("NATUREZA"):SetBlock({|| TMPSE2->E2_NATUREZ })
Else						//Desabilita celula para layout padrao
	oSecTit:Cell("NATUREZA"):Disable()
EndIf

//Configura as quebras baseadas na tabela temporária
oBreak := TRBreak():New(oSecTit,{|| TMPSE2->E2_NATUREZ+TMPSE2->E2_NATPAI },{|| STR0004+MascNat(cNatureza)}) /*TOTAL DA NATUREZA ANALÍTICA*/

TRFunction():New(oSecTit:Cell("VALORIG"),"","SUM",oBreak,,,,.F.,.F.)
TRFunction():New(oSecTit:Cell("SALDO"),"","SUM",oBreak,,,,.F.,.F.)
TRFunction():New(oSecTit:Cell("VALCORR"),"","SUM",oBreak,,,,.F.,.F.)
TRFunction():New(oSecTit:Cell("JUROS"),"","SUM",oBreak,,,,.F.,.F.)

oSecTot:Cell("VALORIG"):SetBlock({||TMPSED->VALORIG})
oSecTot:Cell("SALDO"):SetBlock({||TMPSED->SALDO})
oSecTot:Cell("VALCORR"):SetBlock({||TMPSED->VALCORR})
oSecTot:Cell("JUROS"):SetBlock({||TMPSED->JUROS})

//Impressão dos dados
dbSelectArea("TMPSE2")
TMPSE2->(dbSetOrder(1))
TMPSE2->(dbGoTop())
	
While !TMPSE2->(Eof())
	cNatPai := TMPSE2->E2_NATPAI
		
	oSecTit:Init()
	
	While TMPSE2->E2_NATPAI == cNatPai
		If TMPSE2->E2_SALDO <> 0	
			oSecTit:PrintLine()
			oReport:IncMeter()
		EndIf
			
		cNatureza := TMPSE2->E2_NATUREZ		
		TMPSE2->(dbSkip())							
	EndDo
	
	oSecTit:Finish()
		
	dbSelectArea("TMPSED")
	TMPSED->(dbGoTop())
			
	While cNatPai <> ""
		If TMPSED->(dbSeek(cNatPai))
			//Só imprime o totalizador da sintética no último nível
			If 	TMPSED->NIVEL == 1		
			
				oSecTot:Init()
				oSecTot:Cell("TITULO"):SetTitle(STR0005+MascNat(TMPSED->NATUREZA)) /*TOTAL DA NATUREZA SINTÉTICA*/
				oSecTot:PrintLine()
				oSecTot:Finish()						
				oReport:IncMeter()
				
			Else
				Reclock("TMPSED",.F.)
				TMPSED->NIVEL -= 1
				TMPSED->(MsUnlock())
			EndIf				
			//Controle de atualização das superiores imediatas
			cNatPai := TMPSED->NATPAI
		Else
			cNatPai := ""	
		EndIf	
			
		TMPSED->(dbSkip())	
	EndDo						
EndDo

TMPSE2->(dbCloseArea())	
TMPSED->(dbCloseArea())	
MsErase(cTRBSE2)
MsErase(cTRBSED)	

//Gestao
For nX := 1 TO Len(aTmpFil)
	CtbTmpErase(aTmpFil[nX])   
Next	

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} F158GerTrb

Gera o arquivo temporário

@author    Marcos Berto
@version   11.80
@since     27/12/12

@param oReport - Objeto de Relatório

/*/
//------------------------------------------------------------------------------------------
User Function F158GerTrb()

Local aStruct		:= {}
Local aSaldo		:= {}
Local cCampo		:= ""
Local cTipoIn		:= ""
Local cTipoOut	:= ""
Local cQuery		:= ""
Local cCposQry	:= ""
Local cAliasQry 	:= GetNextAlias()
Local dDtReaj		:= dDataBase
Local lCreate		:= .F.
Local nX			:= 0
Local nI			:= 0
Local nDecs  		:= 0
Local nTaxa		:= 0
Local nFator		:= 1
Local nJuros		:= 0
Local nValOrig	:= 0
Local nValSaldo	:= 0
Local nValCorr	:= 0
Local nTotAbat	:= 0
Local nSldAux		:= 0
Local nDiaAtrs	:= 0
Local lGestao		:= FWSizeFilial() > 2	// Indica se usa Gestao Corporativa
Local lSE2Access	:= IIf( lGestao, FWModeAccess("SE2",1) == "E", FWModeAccess("SE2",3) == "E")
Local lOk			:=	.T.

Private dBaixa	:= dDataBase

/****************************************
mv_par01 - Do Fornecedor ?
mv_par02 - Ate o Fornecedor ?
mv_par03 - Da Loja ?
mv_par04 - Ate a Loja ?
mv_par05 - Do Prefixo ?
mv_par06 - Ate o Prefixo ?
mv_par07 - Do Numero ?
mv_par08 - Ate o Numero ?
mv_par09 - Da Natureza ?
mv_par10 - Ate a Natureza ?
mv_par11 - Do Vencimento ?
mv_par12 - Ate o Vencimento ?
mv_par13 - Do Banco ?
mv_par14 - Ate o Banco ?
mv_par15 - Da Emissao ?
mv_par16 - Ate a Emissao ?
mv_par17 - Qual Moeda ?
mv_par18 - Outras Moedas ?
mv_par19 - Quanto a Taxa ?
mv_par20 - Converte Vencto. por ?
mv_par21 - Da Data Contabil ?
mv_par22 - Ate a Data Contabil ?
mv_par23 - Cons. Filiais Abaixo ?
mv_par24 - Da Filial ?
mv_par25 - Ate a Filial ?
mv_par26 - Imprimir Tipos ?
mv_par27 - Nao Imprimir Tipos ?
mv_par28 - Somente Tit. p/ Fluxo ?
mv_par29 - Imprime Provisórios ?
mv_par30 - Tit. Emissao Futura ?
mv_par31 - Considera Adiantamento ?
mv_par32 - Data Base ?
mv_par33 - Compoe Saldo Retroativo ?
mv_par34 - Seleciona Filais ?
*****************************************/

nDecs := MsDecimais(mv_par17)

/*****************************
 Seleção de Títulos a Receber
******************************/

cCposQry := ""

DbSelectArea("SE2")
aEval(SE2->(dbStruct()),{|e| cCposQry += ","+AllTrim(e[1])})

DbSelectArea("SED")
aEval(SED->(dbStruct()),{|e| cCposQry += ","+AllTrim(e[1])})

DbSelectArea("SA2")
aEval(SA2->(dbStruct()),{|e| cCposQry += ","+AllTrim(e[1])})

cQuery := "SELECT "+SubStr(cCposQry,2)+" FROM "
cQuery += 		RetSqlName("SE2") + " SE2, " 
cQuery += 		RetSqlName("SED") + " SED, " 
cQuery += 		RetSqlName("SA2") + " SA2 " 
cQuery += 		"WHERE "

If mv_par34 = 1 .And. lSE2Access //Seleciona filiais
	cQuery +=		"SE2.E2_FILIAL " + cRngFilSE2 + " AND "
Else
	cQuery +=		"SE2.E2_FILIAL = '" +xFilial("SE2")+ "' AND "
EndIf

cQuery +=			"SE2.E2_PREFIXO BETWEEN '" 	+mv_par05+ "' AND '" +mv_par06+ "' AND "
cQuery +=			"SE2.E2_NUM BETWEEN '" 		+mv_par07+ "' AND '" +mv_par08+ "' AND "
cQuery +=			"SE2.E2_FORNECE BETWEEN '" 	+mv_par01+ "' AND '" +mv_par02+ "' AND "
cQuery +=			"SE2.E2_LOJA BETWEEN '" 		+mv_par03+ "' AND '" +mv_par04+ "' AND "
cQuery +=			"SE2.E2_NATUREZ BETWEEN '" 	+mv_par09+ "' AND '" +mv_par10+ "' AND "
cQuery +=			"SE2.E2_PORTADO BETWEEN '" 	+mv_par13+ "' AND '" +mv_par14+ "' AND "
cQuery +=			"SE2.E2_EMISSAO BETWEEN '" 	+DtoS(mv_par15)+ "' AND '" +DtoS(mv_par16)+ "' AND "
cQuery +=			"SE2.E2_VENCTO BETWEEN '" 	+DtoS(mv_par11)+ "' AND '" +DtoS(mv_par12)+ "' AND "
cQuery +=			"SE2.E2_EMIS1 BETWEEN '" 	+DtoS(mv_par21)+ "' AND '" +DtoS(mv_par22)+ "' AND "

If mv_par18 = 2
	cQuery +=		"SE2.E2_MOEDA = " +Str(mv_par17)+ " AND "
EndIf

//Tipos que serão impressos
If !Empty(mv_par26)
	cTipoIn 	:= FormatIn(mv_par26,";")
	cQuery +=		"SE2.E2_TIPO IN " +cTipoIn+ " AND "
EndIf 

//Tipos que não serão impressos
If !Empty(mv_par27)
	cTipoOut 	:= FormatIn(mv_par27,";") 
	cQuery +=		"SE2.E2_TIPO NOT IN " + cTipoOut + " AND "
EndIf

If mv_par33 = 1
	cQuery +=		"(SE2.E2_SALDO <> 0 OR  SE2.E2_BAIXA > '"+DtoS(mv_par32)+"') AND "
Else
	cQuery +=		"SE2.E2_SALDO <> 0 AND "
EndIf

If mv_par28 = 1 //Considera somente títulos para fluxo
	cQuery +=		"SE2.E2_FLUXO <> 'N'  AND "
EndIf

If mv_par30 == 2 //Nao considerar titulos com emissao futura
	cQuery += 		"SE2.E2_EMISSAO <= '" + DtoS(mv_par32) + "' AND "
Endif


//NATUREZAS		
If mv_par34 = 1 //Seleciona filiais
	cQuery +=		"SED.ED_FILIAL " + cRngFilSED + " AND "
Else
	cQuery +=		"SED.ED_FILIAL = '" +xFilial("SED")+ "' AND "
EndIf

cQuery +=			"SED.ED_CODIGO = SE2.E2_NATUREZ AND " 
cQuery +=			"SED.ED_PAI <> ''  AND " 


//FORNECEDOR
If mv_par34 = 1 //Seleciona filiais
	cQuery +=		"SA2.A2_FILIAL " + cRngFilSA2 + " AND "
Else
	cQuery +=		"SA2.A2_FILIAL = '" +xFilial("SA2")+ "' AND "
EndIf

cQuery +=			"SA2.A2_COD = SE2.E2_FORNECE AND " 
cQuery +=			"SA2.A2_LOJA = SE2.E2_LOJA AND " 

cQuery +=			"SED.D_E_L_E_T_ = '' AND "
cQuery +=			"SA2.D_E_L_E_T_ = '' AND "
cQuery +=			"SE2.D_E_L_E_T_ = '' "

cQuery +=		"ORDER BY SED.ED_PAI,SED.ED_CODIGO "

cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAliasQry,.F.,.T.)

//Gera o arquivo temporário
aStruct := SE2->(dbStruct())
       
aAdd(aStruct,{"A2_NREDUZ"	,"C",40,0})
aAdd(aStruct,{"E2_ATRASO"	,"N",10,0})
aAdd(aStruct,{"E2_VALCORR"	,"N",TamSx3("E2_VALOR")[1]	,TamSx3("E2_VALOR")[2]}		)
aAdd(aStruct,{"E2_NATPAI"	,"C",TamSx3("E2_NATUREZ")[1],TamSx3("E2_NATUREZ")[2]}	)

//Cria o arquivo temporário
cTRBSE2 := CriaTrab(Nil,.F.)
MsErase(cTRBSE2)
lCreate := MsCreate(cTRBSE2,aStruct,"TOPCONN")		
If lCreate		
	dbUseArea(.T.,"TOPCONN",cTRBSE2,"TMPSE2",.T.,.F.)
	dbSelectArea("TMPSE2")
	dbCreateIndex(cTRBSE2+"i","E2_NATPAI+E2_NATUREZ", {|| "E2_NATPAI+E2_NATUREZ"})
	
	//Grava o retorno no arquivo temporário
	dbSelectArea(cAliasQry)
	(cAliasQry)->(dbGoTop())
	
	While !(cAliasQry)->(Eof())
		/****************************
		 Valida se imprime o títulos
		*****************************/
		
		//Provisorios
		If mv_par29 = 2 .And. (cAliasQry)->E2_TIPO $ MVPROVIS
			(cAliasQry)->(dbSkip())
			Loop			
		EndIf 
		
		//Adiantamento
		If mv_par31 = 2 .And. (cAliasQry)->E2_TIPO $ MV_CPNEG+"|"+MVPAGANT
			(cAliasQry)->(dbSkip())
			Loop
		EndIf
	
		//Rateio Multinatureza
		If MV_MULNATP .And. (cAliasQry)->E2_MULTNAT == "1"
		   	If !PesqNatSev(cAliasQry,"E2", mv_par09, mv_par10)
				(cAliasQry)->(dbSkip())
				Loop
			Endif
		EndIf
	
		//Data base para reajuste de títulos baixados
		If mv_par20 = 2 .And. StoD((cAliasQry)->E2_VENCREA) < mv_par32
			dDtReaj := StoD((cAliasQry)->E2_VENCREA)	
		Else
			dDtReaj := mv_par32		
		EndIf
		
		//Data da baixa para cálculo de Juros
		dBaixa := mv_par32

		//Posiciona no registro na SE2 para composição de saldo
		dbSelectArea("SE2")
		SE2->(dbSetOrder(1))
		SE2->(dbSeek((cAliasQry)->E2_FILIAL+(cAliasQry)->E2_PREFIXO+(cAliasQry)->E2_NUM+(cAliasQry)->E2_PARCELA+(cAliasQry)->E2_TIPO+(cAliasQry)->E2_FORNECE+(cAliasQry)->E2_LOJA))

		//Calculo de valores
		aSaldo := SdoTitNat((cAliasQry)->E2_PREFIXO,; 	//PREFIXO
								(cAliasQry)->E2_NUM,;		//NUMERO
								(cAliasQry)->E2_PARCELA,;	//PARCELA
								(cAliasQry)->E2_TIPO,;		//TIPO
								(cAliasQry)->E2_FORNECE,;	//FORNECEDOR
								(cAliasQry)->E2_LOJA,;		//LOJA
								/**/,;							//NATUREZA
								"P",;							//CARTEIRA 
							  	"SE2",;						//ALIAS
							 	(cAliasQry)->E2_MOEDA,;		//MOEDA -> Passamos a moeda do título para não haver conversao pela função
							  	mv_par33 = 1,;				//RECOMPOE PELA DATA BASE?
							  	dDtReaj )						//DATA DO REAJUSTE
								
		//Grava o registro 
		For nI := 1 to Len(aSaldo)
			Reclock("TMPSE2",.T.)
			
			For nX := 1 to Len(aStruct)	

				If aStruct[nX,2] == "L"			
					Loop 
				EndIf
				cCampo := aStruct[nX,1]
				lOk		:=	.T.
				
				Do Case
					Case cCampo == "A2_NREDUZ"
						xConteudo := (cAliasQry)->A2_NREDUZ			
					Case cCampo == "E2_ATRASO"
						nDiaAtrs := mv_par32 - StoD((cAliasQry)->E2_VENCREA) //(Data base do relatório - Vencimento Real)
						xConteudo := Iif (nDiaAtrs > 0,nDiaAtrs,0)		
					Case cCampo == "E2_VALCORR"
						xConteudo := 0				
					Case cCampo == "E2_JUROS"
						xConteudo := 0
					Case cCampo == "E2_NATPAI"
						xConteudo := (cAliasQry)->ED_PAI							
					Otherwise						
						If (cAliasQry)->(FieldPos(cCampo)) == 0
							lOk	:=	.F.
						Else
							xConteudo := (cAliasQry)->&cCampo							
							//Ajuste para campos do tipo data
							If aStruct[nX,2] == "D"
								xConteudo := StoD(xConteudo)
							EndIf
						Endif		
				EndCase					
						
				If lOk //Campo encontra-se na query e no padrão.		
					//Adiciona conteúdo ao campo
					nPosCampo := TMPSE2->(FieldPos(cCampo))
					TMPSE2->(FieldPut(nPosCampo,xConteudo))										
				Endif	
			Next nX			
										
			/****************************************
			 Recompoe os valores que serão impressos
			*****************************************/
			
			//Verifica a taxa de conversão do título, quando aplicável
			If mv_par19 = 2
				If !Empty((cAliasQry)->E2_TXMOEDA)
					nTaxa := (cAliasQry)->E2_TXMOEDA
				Else
					nTaxa := RecMoeda(StoD((cAliasQry)->E2_EMISSAO),mv_par17)
				EndIf
			Else
				nTaxa := 0	//Zera a taxa para utilização da taxa do dia			
			EndIf 				
			
			//Valida o fator de multiplicação
			If (cAliasQry)->E2_TIPO $ MVABATIM+"|"+MV_CPNEG+"|"+MVPAGANT
				nFator := -1
			Else
				nFator := 1
			EndIf
			
			nValOrig  	:= Round(NoRound(xMoeda(aSaldo[nI][4],(cAliasQry)->E2_MOEDA,mv_par17,mv_par32,nDecs+1,nTaxa),nDecs+1),nDecs)
			nValSaldo	:= Round(NoRound(xMoeda(aSaldo[nI][2]-nTotAbat,(cAliasQry)->E2_MOEDA,mv_par17,mv_par32,nDecs+1,nTaxa),nDecs+1),nDecs)
			
			TMPSE2->E2_NATUREZ := aSaldo[nI][1]
			
			//Altera a natureza Pai
			If MV_MULNATP .And. (cAliasQry)->E2_MULTNAT == "1"
				dbSelectArea("SED")
				SED->(dbSetOrder(1))
				If dbSeek(xFilial("SED")+aSaldo[nI][1])
					TMPSE2->E2_NATPAI := SED->ED_PAI	
				EndIf
			EndIf
			
			TMPSE2->E2_SALDO   := nValSaldo * nFator
			TMPSE2->E2_VALOR   := nValOrig *nFator
			
			nJuros 	:= fa080Juros(mv_par17,,"TMPSE2")	
			nValCorr	:= (nValSaldo + nJuros)
			
			TMPSE2->E2_VALCORR	:= nValCorr * nFator
			TMPSE2->E2_JUROS		:= nJuros * nFator
			
			TMPSE2->(MsUnlock())
			
			//Zera os valores calculados
			nJuros		:= 0
			nValOrig	:= 0
			nValCorr	:= 0
			nValSaldo	:= 0
		
		Next nI		
		(cAliasQry)->(dbSkip())
	EndDo
	
	(cAliasQry)->(dbClearIndex()) 
	(cAliasQry)->(dbCloseArea()) 
	MsErase(cAliasQry)
EndIf

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} F158TotNat

Totaliza as naturezas analíticas nas sintéticas

@author    Marcos Berto
@version   11.80
@since     27/12/12

@param oReport - Objeto de Relatório

/*/
//------------------------------------------------------------------------------------------
User Function F158TotNat()

Local aStruct		:= {}
Local cNatureza	:= ""
Local cQuery		:= ""
Local cAliasQry1 	:= GetNextAlias()
Local cAliasQry2 	:= GetNextAlias()
Local lCreate		:= .F.
Local nX			:= 0

//Gestao
Local lGestao		:= FWSizeFilial() > 2	// Indica se usa Gestao Corporativa
Local lSEDAccess	:= IIf( lGestao, FWModeAccess("SED",1) == "E", FWModeAccess("SED",3) == "E")

/*************************************
 Busca todas as naturezas sintéticas
**************************************/

cQuery := "SELECT SED.ED_CODIGO,SED.ED_DESCRIC,SED.ED_PAI FROM "
cQuery +=		RetSqlName("SED") + " SED " 
cQuery +=		"WHERE "
If mv_par34 = 1 //Seleciona filiais
	cQuery +=		"SED.ED_FILIAL " + cRngFilSED + " AND "
Else
	cQuery +=		"SED.ED_FILIAL = '" +xFilial("SED")+ "' AND "
EndIf
cQuery +=		"SED.ED_TIPO = '1' AND "	
cQuery +=		"SED.D_E_L_E_T_ = ''	"

cQuery +=	"ORDER BY ED_CODIGO DESC"	

cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAliasQry1,.F.,.T.)


//Gera o arquivo temporário
aStruct := SED->(dbStruct())

aAdd(aStruct,{"NATUREZA","C",TamSX3("ED_CODIGO")[1],TamSX3("ED_CODIGO")[2]})
aAdd(aStruct,{"NATPAI"	,"C",TamSX3("ED_CODIGO")[1],TamSX3("ED_CODIGO")[2]})
aAdd(aStruct,{"VALORIG"	,"N",TamSx3("E2_VALOR")[1],TamSx3("E2_VALOR")[2]} )
aAdd(aStruct,{"SALDO"	,"N",TamSx3("E2_SALDO")[1],TamSx3("E2_SALDO")[2]} )
aAdd(aStruct,{"VALCORR"	,"N",TamSx3("E2_VALOR")[1],TamSx3("E2_VALOR")[2]} )
aAdd(aStruct,{"JUROS"	,"N",TamSx3("E2_JUROS")[1],TamSx3("E2_JUROS")[2]} )
aAdd(aStruct,{"ATRASO"	,"N",10,0})
aAdd(aStruct,{"NIVEL"	,"N",10,0})

cTRBSED := CriaTrab(Nil,.F.)
MsErase(cTRBSED)
lCreate := MsCreate(cTRBSED,aStruct,"TOPCONN")		
If lCreate
	dbUseArea(.T.,"TOPCONN",cTRBSED,"TMPSED",.F.,.F.)
	dbSelectArea("TMPSED")
	dbCreateIndex(cTRBSED+"i","NATUREZA", {|| "NATUREZA"})
	
	While !(cAliasQry1)->(Eof())
			
		RecLock("TMPSED",.T.)
		TMPSED->NATUREZA 	:= (cAliasQry1)->ED_CODIGO
		TMPSED->NATPAI 	:= (cAliasQry1)->ED_PAI
		TMPSED->(MsUnlock())
		
		(cAliasQry1)->(dbSkip())
	EndDo
	
	/******************************************************************
	 Busca na tabela temporária os registros pertecentes às sintéticas
	*******************************************************************/
	
	cQuery := "SELECT "
	cQuery +=		"E2_NATPAI, "
	cQuery +=		"SUM(E2_VALOR) E2_VALOR, "
	cQuery +=		"SUM(E2_SALDO) E2_SALDO, "
	cQuery +=		"SUM(E2_VALCORR) E2_VALCORR, "
	cQuery +=		"SUM(E2_JUROS) E2_JUROS, "
	cQuery +=		"SUM(E2_ATRASO) E2_ATRASO "
	cQuery +=		"FROM "+cTRBSE2+" TMPSE2 "
	cQuery +=		"GROUP BY E2_NATPAI "	
	
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAliasQry2,.F.,.T.)
	
	dbSelectArea("TMPSED")
	TMPSED->(dbSetOrder(1))
	
	While !(cAliasQry2)->(Eof())
	
		If TMPSED->(dbSeek((cAliasQry2)->E2_NATPAI))
			
			cNatureza := TMPSED->NATUREZA
			
			While cNatureza <> ""
				If TMPSED->(dbSeek(cNatureza))
							
					RecLock("TMPSED",.F.)
					TMPSED->VALORIG	+= (cAliasQry2)->E2_VALOR
					TMPSED->SALDO		+= (cAliasQry2)->E2_SALDO
					TMPSED->VALCORR	+= (cAliasQry2)->E2_VALCORR
					TMPSED->JUROS		+= (cAliasQry2)->E2_JUROS
					TMPSED->ATRASO	+= (cAliasQry2)->E2_ATRASO
					TMPSED->NIVEL		+= 1
					TMPSED->(MsUnlock())
					
					//Controle de atualização das superiores imediatas
					cNatureza := TMPSED->NATPAI
				Else
					cNatureza := ""	
				EndIf		
			EndDo						
		EndIf
		
		(cAliasQry2)->(dbSkip())
	EndDo
	
	dbSelectArea(cAliasQry2)
	(cAliasQry2)->(dbCloseArea())
	MsErase(cAliasQry2)
EndIf

dbSelectArea(cAliasQry1)
(cAliasQry1)->(dbCloseArea())
MsErase(cAliasQry1)

Return
