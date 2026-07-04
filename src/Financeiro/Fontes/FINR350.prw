/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "FINR350.CH"
#Include "PROTHEUS.CH"
#Include "fwcommand.CH"
#INCLUDE "RPTDEF.CH"

#Define I_CORRECAO_MONETARIA     1
#Define I_DESCONTO               2
#Define I_JUROS                  3
#Define I_MULTA                  4
#Define I_VALOR_RECEBIDO         5
#Define I_VALOR_PAGO             6
#Define I_RECEB_ANT              7
#Define I_PAGAM_ANT              8
#Define I_MOTBX                  9
#Define I_RECPAG_REAIS         	10
#Define I_LEI10925              12
#DeFine I_VALOR_ACESSORIO		13

Static lFWCodFil := .T.
Static __oTBxCanc

// 17/08/2009 - Compilacao para o campo filial de 4 posicoes
// 18/08/2009 - Compilacao para o campo filial de 4 posicoes

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FinR350  ³ Autor ³ Adrianne Furtado      ³ Data ³ 27/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Posicao dos Fornecedores 					              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FINR530(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FinR350()

If GetHlpLGPD({"A2_NOME"})
	Return
EndIf

If !Empty( __oTBxCanc )
	__oTBxCanc:Destroy()
	__oTBxCanc := Nil
EndIf

__oTBxCanc	:= FWPreparedStatement():New( '' )

FDelQuery(.T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()
oReport:PrintDialog()

__oTBxCanc:Destroy()
__oTBxCanc := Nil

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Adrianne Furtado      ³ Data ³27.06.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport		:= Nil
Local oFornecedores	:= Nil
Local oTitsForn		:= Nil
Local oTotaisForn	:= Nil
Local oTotaisFilial	:= Nil
Local oTotaisEmp	:= Nil		/* GESTAO */
Local nTamVal  		:= TamSx3("E2_VALOR")[1]
Local nTamData		:= TamSx3("E2_EMISSAO")[1]
Local nTamTipo		:= TamSx3("E2_TIPO")[1]
Local nTamNum 		:= TamSX3("E2_NUM")[1] + TamSX3("E2_PREFIXO")[1] + 6
Local nTamNum2 		:= TamSX3("E2_NUM")[1] + TamSX3("E2_PREFIXO")[1] + 9


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TReport():New("FINR350",STR0005,"FIN350", {|oReport| ReportPrint(oReport)},STR0001+" "+STR0002) //"Movimento Financeiro Diario"##"Este programa ir  emitir o resumo da Movimenta‡„o"##"Bancaria de um determinado dia."
oReport:SetTotalInLine(.F.)

Pergunte( "FIN350", .F. )

// GESTÃO - início
oReport:SetUseGC(.F.)
// GESTÃO - fim

oFornecedores := TRSection():New(oReport,STR0016,{"SA2"},{OemToAnsi(STR0012),OemToAnsi(STR0013) })   //Por Codigo - Por Nome
TRCell():New(oFornecedores,"A2_COD" 	,"SA2",STR0009,,TamSx3("A2_COD")[1])
TRCell():New(oFornecedores,"A2_NOME" 	,"SA2", "Nome"        ,PesqPict("SA2","A2_NOME"),TamSX3("A2_NOME")[1],/*lPixel*/,{|| IIF(mv_par15 == 1, SA2->A2_NOME, SA2->A2_NREDUZ) } )
oFornecedores:SetHeaderSection(.F.)	//Nao imprime o cabeçalho da secao
oFornecedores:SetAutoSize(.F.)

oTitsForn := TRSection():New(oFornecedores,STR0017,{"SE2","SED"})	//"Titulos
oTitsForn:SetHeaderSection(.T.)
oTitsForn:SetHeaderPage(.T.)
oTitsForn:SetAutoSize(.F.)
oTitsForn:SetLinesBefore(0)
TRCell():New(oTitsForn,"E2_PREFIXO" 	,"SE2",STR0018,/*Picture*/,nTamNum/*Tamanho*/,/*lPixel*/,{|| SE2->E2_PREFIXO+'-'+SE2->E2_NUM }) //"Prf Numero"
TRCell():New(oTitsForn,"E2_PARCELA"		,"SE2",STR0019,,4) 		//"PC"
TRCell():New(oTitsForn,"E2_TIPO"    	,"SE2",STR0020,,nTamTipo+1) 		//"Tip"
TRCell():New(oTitsForn,"E2_EMISSAO"  	,"SE2",STR0044,,nTamData+3) 		//"Emissão"
TRCell():New(oTitsForn,"E2_VENCTO" 		,"SE2",STR0023,,nTamData+3) 		//"Vencimento"
TRCell():New(oTitsForn,"E2_BAIXA"		,"SE2",STR0024,,nTamData+3)		//"Baixa"
TRCell():New(oTitsForn,"VLORIG"      	, 	  ,STR0021  ,,nTamVal) 		//"Valor Original"
TRCell():New(oTitsForn,"LEI10925"    	,	  ,STR0025	,,nTamVal-3) 		//"Lei 10925"
TRCell():New(oTitsForn,"DESCON"    		,	  ,STR0026  ,,nTamVal-3) 		//"Descontos"
TRCell():New(oTitsForn,"ABAT"    	  	,	  ,STR0027  ,,nTamVal-3)		//"Abatimentos"
TRCell():New(oTitsForn,"JUROS"			,	  ,STR0028	,,nTamVal-3)		//"Juros"
TRCell():New(oTitsForn,"MULTA"			,	  ,STR0029 	,,nTamVal-3)		//"Multa"
TRCell():New(oTitsForn,"CMONE"      	,	  ,STR0030  ,,nTamVal-3)		//"Corr. Monet"
TRCell():New(oTitsForn,"VA" 	     	,	  ,STR0045  ,,nTamVal-3)		//"Valor Acessório"
TRCell():New(oTitsForn,"VLPAGO"     	,	  ,STR0031  ,,nTamVal)		//"Valor Pago"
TRCell():New(oTitsForn,"VLPAGANT"      	,	  ,STR0032  ,,nTamVal)		//"Pagto.Antecipado"
TRCell():New(oTitsForn,"SALDO"      	,	  ,STR0033  ,,nTamVal+3)		//"Saldo Atual"
TRCell():New(oTitsForn,"MOTIVO"			,	  ,STR0034	,,5)		//"Motivo"

If cPaisLoc != "BRA"
	oTitsForn:Cell("LEI10925"):Disable()
	oTitsForn:ResetCellPos(.T.)
EndIf

oTitsForn:Cell("E2_PREFIXO"):SetHeaderAlign("LEFT")
oTitsForn:Cell("E2_PARCELA"):SetHeaderAlign("LEFT")
oTitsForn:Cell("E2_TIPO"):SetHeaderAlign("CENTER")
oTitsForn:Cell("E2_EMISSAO"):SetHeaderAlign("CENTER")
oTitsForn:Cell("E2_VENCTO" ):SetHeaderAlign("CENTER")
oTitsForn:Cell("E2_BAIXA"):SetHeaderAlign("CENTER")
oTitsForn:Cell("VLORIG"):SetHeaderAlign("RIGHT")
oTitsForn:Cell("LEI10925"):SetHeaderAlign("RIGHT")
oTitsForn:Cell("DESCON"):SetHeaderAlign("RIGHT")
oTitsForn:Cell("ABAT"):SetHeaderAlign("RIGHT")
oTitsForn:Cell("JUROS"):SetHeaderAlign("RIGHT")
oTitsForn:Cell("MULTA"):SetHeaderAlign("RIGHT")
oTitsForn:Cell("CMONE"):SetHeaderAlign("RIGHT")
oTitsForn:Cell("VLPAGO"):SetHeaderAlign("RIGHT")
oTitsForn:Cell("VA"):SetHeaderAlign("RIGHT")
oTitsForn:Cell("VLPAGANT"):SetHeaderAlign("RIGHT")
oTitsForn:Cell("SALDO"):SetHeaderAlign("RIGHT")
oTitsForn:Cell("MOTIVO"):SetHeaderAlign("RIGHT")

oTitsForn:Cell("E2_PREFIXO"):SetAlign("LEFT")
oTitsForn:Cell("E2_PARCELA"):SetAlign("LEFT")
oTitsForn:Cell("E2_TIPO"):SetAlign("CENTER")
oTitsForn:Cell("E2_EMISSAO"):SetAlign("CENTER")
oTitsForn:Cell("E2_VENCTO" ):SetAlign("CENTER")
oTitsForn:Cell("E2_BAIXA"):SetAlign("CENTER")
oTitsForn:Cell("VLORIG"):SetAlign("RIGHT")
oTitsForn:Cell("LEI10925"):SetAlign("RIGHT")
oTitsForn:Cell("DESCON"):SetAlign("RIGHT")
oTitsForn:Cell("ABAT"):SetAlign("RIGHT")
oTitsForn:Cell("JUROS"):SetAlign("RIGHT")
oTitsForn:Cell("MULTA"):SetAlign("RIGHT")
oTitsForn:Cell("CMONE"):SetAlign("RIGHT")
oTitsForn:Cell("VLPAGO"):SetAlign("RIGHT")
oTitsForn:Cell("VA"):SetAlign("RIGHT")
oTitsForn:Cell("VLPAGANT"):SetAlign("RIGHT")
oTitsForn:Cell("SALDO"):SetAlign("RIGHT")
oTitsForn:Cell("MOTIVO"):SetAlign("RIGHT")

oTotaisForn := TRSection():New(oReport,STR0038,{"SE2","SED"})	//"Total Fornecedor
oTotaisForn:SetHeaderSection(.F.)	//Nao imprime o cabeçalho da secao
oTotaisForn:SetAutoSize(.F.)
oTotaisForn:SetLinesBefore(0)
TRCell():New(oTotaisForn,"TXTTOTAL"	,,"",,nTamNum2) 	//Totais
TRCell():New(oTotaisForn,"PC"		,,"PC"		,,4) 	//"PC"
TRCell():New(oTotaisForn,"TIP"		,,"TIP"		,,nTamTipo+1) 	//"tip"
TRCell():New(oTotaisForn,"EMISSAO"  ,,STR0044	,,nTamData+2)	//"Emissão"
TRCell():New(oTotaisForn,"VENCTO"   ,,STR0023	,,nTamData+2)	//"Vencimento"
TRCell():New(oTotaisForn,"BAIXA"	,,STR0024	,,nTamData+2)	//"Baixa"
TRCell():New(oTotaisForn,"VLORIG"	,,STR0021	,,nTamVal)	//"Valor Original"
TRCell():New(oTotaisForn,"LEI10925"	,,STR0025	,,nTamVal-3)	//"Lei 10925"
TRCell():New(oTotaisForn,"DESCON"	,,STR0026	,,nTamVal-3)	//"Descontos"
TRCell():New(oTotaisForn,"ABAT"		,,STR0027	,,nTamVal-3)	//"Abatimentos"
TRCell():New(oTotaisForn,"JUROS"	,,STR0028	,,nTamVal-3)	//"Juros"
TRCell():New(oTotaisForn,"MULTA"	,,STR0029	,,nTamVal-3)	//"Multa"
TRCell():New(oTotaisForn,"CMONE"	,,STR0030	,,nTamVal-3)	//"Corr. Monet"
TRCell():New(oTotaisForn,"VA"		,,STR0045	,,nTamVal-3)	//"Valor Acessório"
TRCell():New(oTotaisForn,"VLPAGO"	,,STR0031	,,nTamVal)	//"Valor Pago"
TRCell():New(oTotaisForn,"VLPAGANT"	,,STR0032	,,nTamVal)	//"Pagto.Antecip"
TRCell():New(oTotaisForn,"SALDO"	,,STR0033	,,nTamVal+3)	//"Saldo Atual"
TRCell():New(oTotaisForn,"MOTIVO"	,,STR0034	,,5)	//"Motivo"

oTotaisForn:Cell("VLORIG"):SetAlign("RIGHT")
oTotaisForn:Cell("LEI10925"):SetAlign("RIGHT")
oTotaisForn:Cell("DESCON"):SetAlign("RIGHT")
oTotaisForn:Cell("ABAT"):SetAlign("RIGHT")
oTotaisForn:Cell("JUROS"):SetAlign("RIGHT")
oTotaisForn:Cell("MULTA"):SetAlign("RIGHT")
oTotaisForn:Cell("CMONE"):SetAlign("RIGHT")
oTotaisForn:Cell("VLPAGO"):SetAlign("RIGHT")
oTotaisForn:Cell("VA"):SetAlign("RIGHT")
oTotaisForn:Cell("VLPAGANT"):SetAlign("RIGHT")
oTotaisForn:Cell("SALDO"):SetAlign("RIGHT")
oTotaisForn:Cell("MOTIVO"):SetAlign("RIGHT")


If cPaisLoc != "BRA"
	oTotaisForn:Cell("LEI10925"):Disable()
	oTotaisForn:ResetCellPos(.T.)
EndIf

nSpaceTot := 0
nSpaceTot := oTitsForn:Cell("E2_PREFIXO"):nSize + oTitsForn:Cell("E2_PARCELA"):nSize + oTitsForn:Cell("E2_TIPO"):nSize + ;
oTitsForn:Cell("E2_EMISSAO"):nSize + oTitsForn:Cell("E2_VENCTO"):nSize + oTitsForn:Cell("E2_BAIXA"):nSize

oTotaisFilial := TRSection():New(oReport,STR0037)	//"Titulos
oTotaisFilial:SetHeaderSection(.F.)	//Nao imprime o cabeçalho da secao
oTotaisFilial:SetAutoSize(.F.)
oTotaisFilial:SetLinesBefore(0)
TRCell():New(oTotaisFilial,"TXTTOTAL"	,,"",,		nTamNum2+38,,,,.T.)
TRCell():New(oTotaisFilial,"PC"      	,,"PC" ,, 	4)	//"PC"
TRCell():New(oTotaisFilial,"TIP"      	,,"TIP",,	nTamTipo+1) 		
TRCell():New(oTotaisFilial,"EMISSAO"	,,STR0044,,	nTamData+2) 		//"Emissão"
TRCell():New(oTotaisFilial,"VENCTO"		,,STR0023,,	nTamData+2) 		//"Vencimen
TRCell():New(oTotaisFilial,"BAIXA"		,,STR0024,,	nTamData+2)		//"Baixa" 
TRCell():New(oTotaisFilial,"VLORIG"    	,,STR0021,,	nTamVal)	//"Valor Original"
TRCell():New(oTotaisFilial,"LEI10925"  	,,STR0025,,	nTamVal-3)	//"Lei 10925"
TRCell():New(oTotaisFilial,"DESCON"    	,,STR0026,,	nTamVal-3)	//"Descontos"
TRCell():New(oTotaisFilial,"ABAT"    	,,STR0027,,	nTamVal-3)	//"Abatimentos"
TRCell():New(oTotaisFilial,"JUROS"		,,STR0028,,	nTamVal-3)	//"Juros"
TRCell():New(oTotaisFilial,"MULTA"		,,STR0029,,	nTamVal-3)	//"Multa"
TRCell():New(oTotaisFilial,"CMONE"    	,,STR0030,,	nTamVal-3)	//"Corr. Monet"
TRCell():New(oTotaisFilial,"VA"  		,,STR0045,,	nTamVal-3)	//"Valor Acessório"
TRCell():New(oTotaisFilial,"VLPAGO"    	,,STR0031 ,,nTamVal)	//"Valor Pago"
TRCell():New(oTotaisFilial,"VLPAGANT"  	,,STR0032 ,,nTamVal)	//"Pagto.Antecip"
TRCell():New(oTotaisFilial,"SALDO"   	,,STR0033 ,,nTamVal+3)	//"Saldo Atual"
TRCell():New(oTotaisFilial,"MOTIVO" 	,,STR0034,,5)	//"Motivo"


oTotaisFilial:Cell("VLORIG"):SetAlign("RIGHT")
oTotaisFilial:Cell("LEI10925"):SetAlign("RIGHT")
oTotaisFilial:Cell("DESCON"):SetAlign("RIGHT")
oTotaisFilial:Cell("ABAT"):SetAlign("RIGHT")
oTotaisFilial:Cell("JUROS"):SetAlign("RIGHT")
oTotaisFilial:Cell("MULTA"):SetAlign("RIGHT")
oTotaisFilial:Cell("CMONE"):SetAlign("RIGHT")
oTotaisFilial:Cell("VLPAGO"):SetAlign("RIGHT")
oTotaisFilial:Cell("VA"):SetAlign("RIGHT")
oTotaisFilial:Cell("VLPAGANT"):SetAlign("RIGHT")
oTotaisFilial:Cell("SALDO"):SetAlign("RIGHT")
oTotaisFilial:Cell("MOTIVO"):SetAlign("RIGHT")

If cPaisLoc != "BRA"
	oTotaisFilial:Cell("LEI10925"):Disable()
	oTotaisFilial:ResetCellPos(.T.)
EndIf

oTotaisEmp := TRSection():New(oReport,"TOTAISEMP")
oTotaisEmp:SetHeaderSection(.F.)	//Nao imprime o cabeçalho da secao
oTotaisEmp:SetAutoSize(.F.)
oTotaisEmp:SetLinesBefore(0)
TRCell():New(oTotaisEmp,"TXTTOTAL"	,,""	,,nTamNum2) 	//Totais
TRCell():New(oTotaisEmp,"PC"		,,"PC"	,,4) 	//"PC"
TRCell():New(oTotaisEmp,"TIP"		,,"TIP"	,,nTamTipo+1) 	//"tip"
TRCell():New(oTotaisEmp,"EMISSAO"	,,STR0044,,nTamData+2)	//"Emissão"
TRCell():New(oTotaisEmp,"VENCTO" 	,,STR0023,,nTamData+2)	//"Vencimento
TRCell():New(oTotaisEmp,"BAIXA"	 	,,STR0024,,nTamData+2)	//"Baixa"
TRCell():New(oTotaisEmp,"VLORIG"    ,,STR0021,,nTamVal)	//"Valor Original"
TRCell():New(oTotaisEmp,"LEI10925"  ,,STR0025,,nTamVal-3)	//"Lei 10925"
TRCell():New(oTotaisEmp,"DESCON"    ,,STR0026,,nTamVal-3)	//"Descontos"
TRCell():New(oTotaisEmp,"ABAT"    	,,STR0027,,nTamVal-3)	//"Abatimentos"
TRCell():New(oTotaisEmp,"JUROS"		,,STR0028,,nTamVal-3)	//"Juros"
TRCell():New(oTotaisEmp,"MULTA"		,,STR0029,,nTamVal-3)	//"Multa"
TRCell():New(oTotaisEmp,"CMONE"    	,,STR0030,,nTamVal-3)	//"Corr. Monet"
TRCell():New(oTotaisEmp,"VA"  		,,STR0045,,nTamVal-3)	//"Valor Acessório"
TRCell():New(oTotaisEmp,"VLPAGO"    ,,STR0031,,nTamVal)	//"Valor Pago"
TRCell():New(oTotaisEmp,"VLPAGANT"  ,,STR0032,,nTamVal)	//"Pagto.Antecip"
TRCell():New(oTotaisEmp,"SALDO"    	,,STR0033,,nTamVal+3)	//"Saldo Atual"
TRCell():New(oTotaisEmp,"MOTIVO"	,,STR0034,,5	  )	//"Motivo"


oTotaisEmp:Cell("VLORIG"):SetAlign("RIGHT")
oTotaisEmp:Cell("LEI10925"):SetAlign("RIGHT")
oTotaisEmp:Cell("DESCON"):SetAlign("RIGHT")
oTotaisEmp:Cell("ABAT"):SetAlign("RIGHT")
oTotaisEmp:Cell("JUROS"):SetAlign("RIGHT")
oTotaisEmp:Cell("MULTA"):SetAlign("RIGHT")
oTotaisEmp:Cell("CMONE"):SetAlign("RIGHT")
oTotaisEmp:Cell("VLPAGO"):SetAlign("RIGHT")
oTotaisEmp:Cell("VA"):SetAlign("RIGHT")
oTotaisEmp:Cell("VLPAGANT"):SetAlign("RIGHT")
oTotaisEmp:Cell("SALDO"):SetAlign("RIGHT")
oTotaisEmp:Cell("MOTIVO"):SetAlign("RIGHT")

If cPaisLoc != "BRA"
	oTotaisEmp:Cell("LEI10925"):Disable()
	oTotaisEmp:ResetCellPos(.T.)
EndIf

//Totalizador Geral
oTotalGeral := TRSection():New(oReport,STR0011,{"SE2","SED"})	//"Total Geral
oTotalGeral:SetHeaderSection(.F.)	//Nao imprime o cabeçalho da secao
oTotalGeral:SetAutoSize(.F.)
oTotalGeral:SetLinesBefore(0)
TRCell():New(oTotalGeral,"TXTTOTAL"		,  ,STR0011		,, nTamNum2)   //"TOTAL GERAL ---->"
TRCell():New(oTotalGeral,"PC"		,  ,"PC"		,,4	  ) //"PC"
TRCell():New(oTotalGeral,"TIP"		,  ,"TIP"		,,nTamTipo+1) //"tip" 3 ) 	//"tip"
TRCell():New(oTotalGeral,"EMISSAO"		,,STR0044	,, nTamData+2)	//"Emissão"
TRCell():New(oTotalGeral,"VENCTO"		,,STR0023 ,, nTamData+2)	//"Vencimento"
TRCell():New(oTotalGeral,"BAIXA"		,  ,STR0024		,, nTamData+2)	//"Baixa"
TRCell():New(oTotalGeral,"VLORIG"      	, ,STR0021		,,nTamVal)	//"Valor Original" TAM 16
TRCell():New(oTotalGeral,"LEI10925"    	,,STR0025		,,nTamVal-3)	//"Lei 10925" TAM 16
TRCell():New(oTotalGeral,"DESCON"    	,,STR0026 		,,nTamVal-3)	//"Descontos" TAM16
TRCell():New(oTotalGeral,"ABAT"      	,,STR0027  		,,nTamVal-3)	//"Abatimentos" TAM16
TRCell():New(oTotalGeral,"JUROS"		,,STR0028		,,nTamVal-3)	//"Juros" TAM16
TRCell():New(oTotalGeral,"MULTA"		,,STR0029 		,,nTamVal-3)	//"Multa" TAM16
TRCell():New(oTotalGeral,"CMONE"      	,,STR0030  		,,nTamVal-3)	//"Corr. Monet" TAM16
TRCell():New(oTotalGeral,"VA"    		,,STR0045		,,nTamVal-3)	//"Valor Acessório" 
TRCell():New(oTotalGeral,"VLPAGO"     	,,STR0031  		,,nTamVal)	//"Valor Pago"
TRCell():New(oTotalGeral,"VLPAGANT"    	,,STR0032  		,,nTamVal)	//"Pagto.Antecip"
TRCell():New(oTotalGeral,"SALDO"      	,,STR0033  		,,nTamVal+3)	//"Saldo Atual"
TRCell():New(oTotalGeral,"MOTIVO"		,,STR0034		,,5	 )	//"Motivo"


oTotalGeral:Cell("VLORIG"):SetAlign("RIGHT")
oTotalGeral:Cell("LEI10925"):SetAlign("RIGHT")
oTotalGeral:Cell("DESCON"):SetAlign("RIGHT")
oTotalGeral:Cell("ABAT"):SetAlign("RIGHT")
oTotalGeral:Cell("JUROS"):SetAlign("RIGHT")
oTotalGeral:Cell("MULTA"):SetAlign("RIGHT")
oTotalGeral:Cell("CMONE"):SetAlign("RIGHT")
oTotalGeral:Cell("VLPAGO"):SetAlign("RIGHT")
oTotalGeral:Cell("VA"):SetAlign("RIGHT")
oTotalGeral:Cell("VLPAGANT"):SetAlign("RIGHT")
oTotalGeral:Cell("SALDO"):SetAlign("RIGHT")
oTotalGeral:Cell("MOTIVO"):SetAlign("RIGHT")

If cPaisLoc != "BRA"
	oTotalGeral:Cell("LEI10925"):Disable()
	oTotalGeral:ResetCellPos(.T.)
EndIf

oFornecedores:SetColSpace(0)
oTitsForn:SetColSpace(0)
oTotaisForn:SetColSpace(0)
oTotaisFilial:SetColSpace(0)
oTotaisEmp:SetColSpace(0)	
oTotalGeral:SetColSpace(0)

oReport:SetLandScape()
oReport:lDisableOrientation := .T.

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Adrianne Furtado      ³ Data ³27.06.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)
Local oFornecedores	:= oReport:Section(1)
Local oTitsForn		:= oReport:Section(1):Section(1)
Local oTotaisForn	:= oReport:Section(2)
Local oTotaisFilial	:= oReport:Section(3)
Local oTotaisEmp	:= oReport:Section("TOTAISEMP")
Local oTotalGeral	:= oReport:Section(5)
Local cAlias
Local cAliasSE2		:= "SE2"
Local cAliasSA2 	:= "SA2"
Local cFornecedor
Local cSql1, cSql2	:= ""
Local nDecs, nMoeda
Local aValor 		:= {}
Local nTotAbat
Local bPosTit		:= { || }		// Posiciona a impressao dos titulos do fornecedor
Local bCondFil		:= { || }		// Condicao para impressao dos titulos da filial
Local lInitForn	:=	.T.
Local	lPrintForn	:=	.T.
Local cFilDe,cFilAte, cFilDeSA2,cFilAteSA2
Local cFilAux := ""
Local nTotFil0:= nTotForn0:= nTotGeral0:=0
Local nTotFil1:= nTotForn1:= nTotGeral1:=0
Local nTotFil2:= nTotForn2:= nTotGeral2:=0
Local nTotFil3:= nTotForn3:= nTotGeral3:=0
Local nTotFil4:= nTotForn4:= nTotGeral4:=0
Local nTotFil5:= nTotForn5:= nTotGeral5:=0
Local nTotFil6:= nTotForn6:= nTotGeral6:=0
Local nTotFil7:= nTotForn7:= nTotGeral7:=0
Local nTotFil8:= nTotForn8:= nTotGeral8:=0
Local nTotFil9:= nTotForn9:= nTotGeral9:=0
Local nTotFilA:= nTotFornA:= nTotGeralA:=0
Local nY	  := 0
Local lProcSQL := .T.
Local lPCCBaixa := SuperGetMv("MV_BX10925",.T.,"2") == "1"
Local nValorOrig := 0
Local lPaBruto	:= GetNewPar("MV_PABRUTO","2") == "1"  //Indica se o PA terá o valor dos impostos descontados do seu valor
Local lImpTit	:= .T.		// Indica se imprime o titulo a pagar (SE2)
Local nInc		:= 0
Local aSM0		:= {}
Local cLayout   := FWSM0Layout()
Local lGestao	:= "E" $ cLayout .Or. "U" $ cLayout
Local nValRet 	:= 0
Local cE2ModFil := FWModeAccess("SE2",3)
Local cMVMoeda  := ""
//******************************************
// Utilizados pelo ponto de entrada F350MFIL
//******************************************
Local lMovFil	:= .T. //Default: Imprime todas as filiais
Local lImpMFil 	:= .T.
Local nReg		:= 0
//******************************************

Local nX		:= 0
Local aFilProc	:= {}	// Filiais jah processadas

// GESTÃO - início
Local aSelFil		:= {}
Local lTotEmp		:= .F.
Local nRegEmp		:= 0
Local nLenSelFil	:= 0
Local nTamEmp		:= 0
Local nTotEmp0		:= 0
Local nTotEmp1		:= 0
Local nTotEmp2		:= 0
Local nTotEmp3		:= 0
Local nTotEmp4		:= 0
Local nTotEmp5		:= 0
Local nTotEmp6		:= 0
Local nTotEmp7		:= 0
Local nTotEmp8		:= 0
Local nTotEmp9		:= 0
Local nTotEmpA		:= 0
// GESTÃO - fim

// Valores acessórios.
Local nValAcess	:= 0
Local lExistVlAc:= ExistFunc('FValAcess')
Local lFxLoadFK6:= ExistFunc('FxLoadFK6')

Local cNomeFor	:= ""
Local cTexto	:= ""

Private nRegSM0    := SM0->(Recno())
Private nAtuSM0    := SM0->(Recno())

If Type("lImpXlsTbl") == 'U'
	lImpXlsTbl := .F.
EndIf

// GESTÃO - início
If MV_PAR22 == 1 .and. lGestao //Seleciona filiais e gestão
	aSelFil := AdmGetFil(.F.,.F.,"SE2")

	If Empty(aSelFil) //Não seleciona filiais
		Aadd(aSelFil,cFilAnt)
	Endif

	SM0->(DbGoTo(nRegSM0))

ElseIf MV_PAR22 == 1 .And. !lGestao

	AdmSelecFil("FIN350",22,.F.,@aSelFil,"SE2",.F.)
	SM0->(DbGoTo(nRegSM0))


ElseIf MV_PAR19 == 2 //Não considera filiais
	If Empty(aSelFil) //Não seleciona filiais
		Aadd(aSelFil,cFilAnt)
	Endif
Else
	aSelFil := {}
Endif

If lImpXlsTbl .And. !oReport:lXlsTable .And. IsBlind() 
	oReport:lXlsTable := lImpXlsTbl
EndIf

Asort(aSelFil)
nLenSelFil := Len(aSelFil)
lTotEmp := .F.
nTamEmp := Len(FWSM0LayOut(,1))

If nLenSelFil > 1
	nX := 1
	While nX < nLenSelFil .And. !lTotEmp
		nX++
		lTotEmp := !(Substr(aSelFil[nX-1],1,nTamEmp) == Substr(aSelFil[nX],1,nTamEmp))
	Enddo
Endif

If lGestao
	aSM0 := FWLoadSM0()
Else
	aSM0 := AdmAbreSM0()
EndIf

nDecs 	:= Msdecimais(mv_par10)
nMoeda 	:= Iif(mv_par10 == 0, 1,mv_par10)
cMVMoeda := GetMv("MV_MOEDA"+Str(nMoeda,1))

oReport:SetMeter(RecCount())

If (Len(aSelFil)== 1 .And. !lGestao) //empresa sem gestao e 'Considera filiais = NAO" deve selecionar somente a filial logada.

	cFilDe 	:=	aSelFil[1]
	cFilAte 	:= aSelFil[1]
	cFilDeSA2 := aSelFil[1]
	cFilAteSA2:= aSelFil[1]
	nInc 	:= 0

	For nReg := Len(aSM0) To 1 Step(-1)

		If !lGestao .And. aSM0[nReg,1] <> cEmpAnt //nao utiliza gestao de empresa
			Adel(aSM0,nReg)
			nInc++
			Loop
		Endif

		If  aSM0[nReg,2] <> cFilDe
			Adel(aSM0,nReg)
			nInc++
		Endif

	Next
	If nInc > 0
		Asize(aSM0,Len(aSM0) - nInc)
	Endif

ElseIf (Empty(aSelFil) .And. MV_PAR19 == 1)
	cFilDe 	:=	mv_par20
	cFilAte 	:= mv_par21
	cFilDeSA2 := cFilDe
	cFilAteSA2:= cFilAte
	nInc 	:= 0

	For nReg := Len(aSM0) To 1 Step(-1)

		If !lGestao .And. aSM0[nReg,1] <> cEmpAnt //nao utiliza gestao de empresa
			Adel(aSM0,nReg)
			nInc++
			Loop
		Endif

		If  aSM0[nReg,2]>= cFilDe .And. aSM0[nReg,2]<= cFilAte
			Aadd(aSelFil,aSM0[nReg,SM0_CODFIL])
		Endif

		If  !(aSM0[nReg,2]>= cFilDe .And. aSM0[nReg,2]<= cFilAte)
			Adel(aSM0,nReg)
			nInc++
		Endif

	Next
	If nInc > 0
		Asize(aSM0,Len(aSM0) - nInc)
	Endif

Else
	If len(aSelFil) == 0
		aSelFil := {cFilAnt}
	Endif
	cFilDe := aSelFil[1]
	cFilAte := aSelFil[Len(aSelFil)]
	cFilDeSA2 := cFilDe
	cFilAteSA2:= cFilAte
	nInc := 0
	/* Deixo na aSM0 somente as filiais selecionas para impressao. */
	For nReg := Len(aSM0) To 1 Step(-1)
		If aSM0[nReg][1] != cEmpAnt .OR. Ascan(aSelFil,aSM0[nReg,SM0_CODFIL]) == 0
			Adel(aSM0,nReg)
			nInc++
		Endif
	Next
	If nInc > 0
		Asize(aSM0,Len(aSM0) - nInc)
	Endif
Endif
// GESTÃO - fim

oFornecedores:Init()
oTitsForn:Init()

If ExistBlock("F350MFIL")
	lMovFil := ExecBlock("F350MFIL",.F.,.F.)
Endif

For nInc := 1 To Len( aSM0 )

	If aSM0[nInc][1] == cEmpAnt .Or. !Empty(aSelFil)

		cFilAnt := aSM0[nInc][2]

		If	!Empty(cFilAte) .And. (aSM0[nInc][2] >= cFilDe .and. aSM0[nInc][2] <= cFilAte) .And. AScan( aFilProc, xFilial("SE2") ) == 0

			nReg := 0 //Zera a contagem de registros impressos.
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Filtragem do relatório                                                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lProcSQL
				lProcSQL := .F.
				cAlias := GetNextAlias()
			EndIf

			bPosTit 	:= { || cFornecedor := (cAliasSA2)->( A2_COD + A2_LOJA ) }
			bCondTit	:= { || (cAliasSE2)->( E2_FORNECE + E2_LOJA ) == cFornecedor }

			cSql0 := "A2_FILIAL = '"+xFilial("SA2")+"' AND "
			If cE2ModFil == "C" .And. mv_par22 == 1 .And. !Empty(aSelFil)	//Filtra selecao de filiais
				nY := Len(aSelFil)
				cSql0 += "E2_FILIAL = '"+xFilial("SE2")+"' AND "
				cSql0 += "E2_FILORIG between '"+ aSelFil[1]+ "' AND '"+ aSelFil[nY]+ "' AND"
			Else
				cSql0 += "E2_FILIAL = '"+xFilial("SE2")+"' AND "
			EndIf
			cSql0 := "%"+cSql0+"%"

			cSql1 := If(mv_par18 == 1,"E2_EMISSAO","E2_EMIS1") + " between '" + DTOS(mv_par05)+ "' AND '" + DTOS(mv_par06) + "' AND E2_TIPO NOT IN "+FormatIn(MVABATIM,"|")+" AND "
			cSql1 := "%"+cSql1+"%"

			cSql2 := If(mv_par18 == 1,"E2_EMISSAO","E2_EMIS1") + "<= '"+DTOS(dDataBase)+"' AND "
			If mv_par09 == 2
				cSql2 += "E2_TIPO != '"+MVPROVIS+"' AND "
			EndIf
			If mv_par16 == 2
				cSql2 += "E2_TIPO != 'PA ' AND "
			EndIf
			If mv_par12 == 2
				If cpaisLOC =="BRA"
				  	cSql2 += "E2_FATURA IN('"+Space(Len(SE2->E2_FATURA))+"','NOTFAT') AND SE2.E2_DTFATUR <= '" + DTOS(mv_par06) + "' AND ""
				Else
			  	  	cSql2 += "E2_ORIGEM <>'FINA085A' AND "
			  	EndIf
			Endif
			If mv_par13 == 2
				cSQL2 += " E2_MOEDA = " + STR(mv_par10) +" AND "
			Endif

			cSql2 := "%"+cSql2+"%"
			If oFornecedores:GetOrder() == 1
				cOrder := "A2_FILIAL,E2_FILIAL,A2_COD,A2_LOJA,A2_NOME,E2_PREFIXO,E2_NUM,E2_PARCELA,E2_TIPO"
				SA2->( dbSetOrder( 1 ) )
			Else
				cOrder := "A2_FILIAL,E2_FILIAL,A2_NOME,A2_COD,A2_LOJA,E2_PREFIXO,E2_NUM,E2_PARCELA,E2_TIPO"
				SA2->( dbSetOrder( 2 ) )
			EndIf
			cOrder := "%"+cOrder+"%"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Transforma parametros Range em expressao SQL                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			MakeSqlExpr(oReport:uParam)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Query do relatório      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oFornecedores:BeginQuery()

			BeginSql Alias cAlias
				SELECT  A2_FILIAL,A2_COD,A2_NOME,A2_NREDUZ,A2_LOJA,SE2.*
				FROM %table:SA2% SA2,%table:SE2% SE2
					LEFT OUTER JOIN %table:SED% SED
					ON	(	ED_FILIAL 	= 	%xFilial:SED% AND
							ED_CODIGO 	=	E2_NATUREZ AND
							SED.%NotDel% )
				WHERE %exp:cSql0%
					E2_FORNECE 	= A2_COD 		AND
					E2_LOJA 	= A2_LOJA		AND
					E2_FORNECE 	between %Exp:mv_par01% AND %Exp:mv_par02% AND
					E2_LOJA 	between %Exp:mv_par03% AND %Exp:mv_par04% AND
					%exp:cSql1%
					E2_VENCREA 	between %Exp:DTOS(mv_par07)% AND %Exp:DTOS(mv_par08)% AND
					%exp:cSql2%
					SE2.%notDel% AND
					SA2.%notDel%

				ORDER BY %exp:cOrder%

			EndSql
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Metodo EndQuery ( Classe TRSection )                                    ³
			//³Prepara o relatório para executar o Embedded SQL.                       ³
			//³ExpA1 : Array com os parametros do tipo Range                           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oFornecedores:EndQuery(/*Array com os parametros do tipo Range*/)

			oTitsForn:SetParentQuery()
			oTitsForn:SetParentFilter({|cParam| (cAlias)->(E2_FORNECE+E2_LOJA) == cParam}, { || (cAlias)->(A2_COD+A2_LOJA) })

			cAliasSE2	:= cAlias
			cAliasSA2 	:= cAlias

			(cAlias)->( dbGoTop() )

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Inicio da impressao do fluxo do relatório                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If (cAliasSA2)->( !EoF() )
				If oReport:cTitle = oReport:cRealTitle
					oReport:SetTitle(STR0005 + " - " + cMVMoeda)
				Else
					oReport:SetTitle(oReport:cTitle + " - " + cMVMoeda)
				EndIf

				oReport:SetMeter((cAliasSE2)->(LastRec()))
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Posicionamento do SE5 neste ponto que servira para   ³
			//³pesquisa de descarte de registros geradores de       ³
			//³desdobramento                                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SE5")
			SE5->(dbSetOrder(7))
			dbSelectArea("SE2")

			While !oReport:Cancel() .And. (cAliasSA2)->(!Eof())
				If oFornecedores:GetOrder() == 1
					SA2->(DbSetOrder(1))
					SA2->(DbSeek((cAliasSA2)->A2_FILIAL + (cAliasSA2)->A2_COD + (cAliasSA2)->A2_LOJA ) )
				Else
					SA2->(DbSetOrder(1))
					SA2->(DbSeek((cAliasSA2)->A2_FILIAL + (cAliasSA2)->A2_COD + (cAliasSA2)->A2_LOJA ) )
					SA2->(DbSetOrder(2))
				Endif

				oReport:IncMeter()

				If oReport:Cancel()
					Exit
				EndIf

				lFirst := .T.

				Eval( bPosTit )

				While !oReport:Cancel() .And. !(cAliasSE2)->(Eof()) .And. Eval( bCondTit )

					If oReport:Cancel()
						Exit
					EndIf

					If cE2ModFil == "C"
						cFilAux := (cAliasSE2)->E2_FILORIG
						bCondFil	:= { || cFilAux == (cAliasSE2)->E2_FILORIG }
					Else
						cFilAux := xFilial("SE2")
						bCondFil	:= { || cFilAux == (cAliasSE2)->E2_FILIAL }
					EndIf

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Pesquisa de descarte de registros geradores de       ³
					//³desdobramento                                        ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If SE5->(dbSeek(xFilial("SE5") + (cAliasSE2)->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)))
						If AllTrim(SE5->E5_TIPODOC) == "BA" .AND. AllTrim(SE5->E5_MOTBX) == "DSD"
							(cAliasSE2)->(dbSkip())
							Loop
						Endif
					Endif

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ O alias SE2 eh utilizado nas funcoes Baixa() e SaldoTit() abaixo, por isso deve estar posicionado ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					SE2->( dbSetOrder(1) )
					If mv_par19 == 1 .And. Iif( lGestao, !Empty( FWFilial("SE2") ), !Empty( xFilial("SE2") ) )
						lImpTit := SE2->( MsSeek( aSM0[nInc][2] +(cAliasSE2)->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA ) ) )
					Else
						lImpTit := SE2->( MsSeek( xFilial("SE2")+(cAliasSE2)->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA ) ) )
					EndIf

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Imprime o titulo a pagar do fornecedor se passou nas condicoes de filtros ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If lImpTit
						aValor :=Baixas((cAliasSE2)->E2_NATUREZ,(cAliasSE2)->E2_PREFIXO,(cAliasSE2)->E2_NUM,(cAliasSE2)->E2_PARCELA,(cAliasSE2)->E2_TIPO,;
						nMoeda,"P",(cAliasSE2)->E2_FORNECE,dDataBase,(cAliasSE2)->E2_LOJA,(cAliasSE2)->E2_FILORIG,,,,MV_PAR10 <> 1,__oTBxCanc)

						If SE2->E2_TIPO == "NDF"
							aValor[I_VALOR_PAGO]:=0
						Endif

						If mv_par14 == 1
							nSaldo :=SaldoTit((cAliasSE2)->E2_PREFIXO,(cAliasSE2)->E2_NUM,(cAliasSE2)->E2_PARCELA,(cAliasSE2)->E2_TIPO,;
											   (cAliasSE2)->E2_NATUREZ,"P",(cAliasSE2)->E2_FORNECE,nMoeda,;
									If(mv_par11==1,dDataBase,(cAliasSE2)->E2_VENCREA),,(cAliasSE2)->E2_LOJA,,If(mv_par17 == 1 ,(cAliasSE2)->E2_TXMOEDA,0),,,__oTBxCanc)
						Else
							nSaldo := Round(xMoeda(((cAliasSE2)->E2_SALDO+(cAliasSE2)->E2_SDACRES-(cAliasSE2)->E2_SDDECRE),(cAliasSE2)->E2_MOEDA,mv_par10,;
							If(mv_par17 == 1,If(mv_par18 == 1,(cAliasSE2)->E2_EMISSAO,(cAliasSE2)->E2_EMIS1),dDataBase),nDecs+1,If(mv_par17 == 1 .and. (cAliasSE2)->E2_TXMOEDA>0,(cAliasSE2)->E2_TXMOEDA, )), nDecs)
						Endif

						//compensação de nf x pa/ncc de filiais diferentes.
						//vld para corrigir o sld atual do total geral.
						If nSaldo > 0 .And. (cAliasSE2)->E2_SALDO == 0 .And. (cAliasSE2)->E2_TIPO $ MVPAGANT+"/"+MV_CPNEG .And. len(aValor) > 0 .And. mv_par18 == 2
							If AllTrim(aValor[9]) == STR0042//"Compensação"
								nSaldo := 0
							EndIf
						EndIf

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ SE2 - Calcula valor acessório
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						nValAcess	:= 0
						If SE2->E2_SALDO <> SE2->E2_VALOR //Sofreu baixa
							aAreaSE5	:= SE5->(GetArea())

							DbSelectArea("SE5")
							DBSetOrder(2)  // E5_FILIAL, E5_TIPODOC, E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_TIPO, E5_DATA, E5_CLIFOR, E5_LOJA, E5_SEQ.
							If SE5->(DBSeek(xFilial("SE5") + "VA" + SE2->E2_PREFIXO + SE2->E2_NUM + SE2->E2_PARCELA + SE2->E2_TIPO + Dtos(SE2->E2_BAIXA) + SE2->E2_FORNECE + SE2->E2_LOJA))
								nValAcess := IIf(lFxLoadFK6,FxLoadFK6("FK1",SE5->E5_IDORIG,"VA")[1,2],0)
							Endif

							RestArea(aAreaSE5)

						Else
							nValAcess := IIf(lExistVlAc,FValAcess(SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,SE2->E2_TIPO,SE2->E2_FORNECE,SE2->E2_LOJA,SE2->E2_NATUREZ, Iif(Empty(SE2->E2_BAIXA),.F.,.T.),"","P",DDataBase),0)
							nSaldo	+= nValAcess
						Endif

						aValor[I_DESCONTO]+= (cAliasSE2)->E2_SDDECRE
						aValor[I_JUROS]   += (cAliasSE2)->E2_SDACRES
						aValor[I_VALOR_ACESSORIO]	+= nValAcess

						nTotAbat:=SumAbatPag(SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,SE2->E2_FORNECE,mv_par10,"V",,SE2->E2_LOJA,If(mv_par18==1,"1","2"),mv_par05,mv_par06,;
										If(mv_par17 == 1,If(mv_par18 == 1,SE2->E2_EMISSAO,SE2->E2_EMIS1),dDataBase),SE2->E2_TIPO)

						If !(cPaisLoc $ "EQU") .And.  !((cAliasSE2)->E2_TIPO $ MVPAGANT+"/"+MV_CPNEG) .And. !( MV_PAR14 == 2 .And. nSaldo == 0 ) // nao deve olhar abatimento pois e zerado o saldo na liquidacao final do titulo
							nSaldo -= nTotAbat
						EndIf
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Se foi gerada fatura, colocar Motbx == Faturado				  ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If !Empty((cAliasSE2)->E2_DTFATUR) .and. (cAliasSE2)->E2_DTFATUR <= dDataBase
							aValor[I_MOTBX] := STR0015  //"Faturado"
							aValor[I_VALOR_PAGO] -= nTotAbat
						Endif

						If cPaisLoc == "BRA" .And. !lPaBruto  .And. alltrim((cAliasSE2)->E2_TIPO)$"PA ,"+MV_CPNEG
							nValorOrig:=(cAliasSE2)->E2_VALOR+(cAliasSE2)->E2_COFINS+(cAliasSE2)->E2_PIS+(cAliasSE2)->E2_CSLL
						Else
							nValorOrig:=(cAliasSE2)->E2_VALOR
						EndIf

						oTitsForn:Cell("E2_EMISSAO"	):SetBlock({|| If(mv_par18==1, (cAliasSE2)->E2_EMISSAO,(cAliasSE2)->E2_EMIS1)}) //"Emissão"
					   	oTitsForn:Cell("VLORIG" 	):SetBlock({||Round(xMoeda(nValorOrig,(cAliasSE2)->E2_MOEDA,nMoeda,If(mv_par17 == 1,If(mv_par18 == 1,(cAliasSE2)->E2_EMISSAO,(cAliasSE2)->E2_EMIS1),dDataBase),nDecs+1,If(mv_par17 == 1 .and. (cAliasSE2)->E2_TXMOEDA>0,(cAliasSE2)->E2_TXMOEDA,))*if(alltrim((cAliasSE2)->E2_TIPO)$"PA ,"+MV_CPNEG,-1,1), nDecs)})
						oTitsForn:Cell("E2_BAIXA"	):SetBlock({||IIf(dDataBase >= (cAliasSE2)->E2_BAIXA,IIF(!Empty((cAliasSE2)->E2_BAIXA),(cAliasSE2)->E2_BAIXA," "),"")})		          //"Baixa"
						If cPaisLoc == "BRA"
							If lPCCBaixa
								// Calcula valor de PA com PCC
								If SE2->E2_TIPO $ MVPAGANT .And. SE2->( E2_COFINS + E2_PIS + E2_CSLL ) > 0
									If aValor[I_LEI10925] < (SE2->E2_COFINS+SE2->E2_PIS+SE2->E2_CSLL) .And. !Empty(SE2->E2_BAIXA)
										nValRet := aValor[I_LEI10925]
									Endif

									aValor[I_LEI10925]   := (SE2->E2_COFINS+SE2->E2_PIS+SE2->E2_CSLL)

									If !lPaBruto
										If aValor[I_VALOR_PAGO] <> NVALORORIG
											aValor[I_VALOR_PAGO] := Iif(nValRet > 0, (aValor[I_VALOR_PAGO] - (nValRet + nSaldo)), (aValor[I_VALOR_PAGO] - (aValor[I_LEI10925]+nSaldo)))
										Else
											aValor[I_VALOR_PAGO] := Iif(nValRet > 0, (NVALORORIG - (nValRet + nSaldo)), (NVALORORIG - (aValor[I_LEI10925]+nSaldo)))
										Endif
									Else
										If (nValRet + aValor[I_LEI10925]) > 0
											aValor[I_VALOR_PAGO] += Iif(nValRet > 0, nValRet, (aValor[I_LEI10925]+nSaldo))
										EndIf
									EndIf
								EndIf
								oTitsForn:Cell("LEI10925"	):SetBlock({||aValor[I_LEI10925]})  				//"Lei 10925"
							Else
								aValor[I_LEI10925]:= (SE2->E2_COFINS+SE2->E2_PIS+SE2->E2_CSLL)
								oTitsForn:Cell("LEI10925"	):SetBlock({||aValor[I_LEI10925]})  				//"Lei 10925"
							Endif
						EndIf
						If cPaisLoc == 'EQU'
							aValor[I_VALOR_PAGO] -= nTotAbat
						EndIf
						oTitsForn:Cell("DESCON"	):SetBlock({||aValor[I_DESCONTO]})					//"Descontos"
						oTitsForn:Cell("ABAT"	):SetBlock({||nTotAbat})							//"Abatimentos"
						oTitsForn:Cell("JUROS"	):SetBlock({||aValor[I_JUROS]})						//"Juros"
						oTitsForn:Cell("MULTA"	):SetBlock({||aValor[I_MULTA]})						//"Multa"
						oTitsForn:Cell("CMONE"	):SetBlock({||aValor[I_CORRECAO_MONETARIA]})		//"Corr. Monet"
						oTitsForn:Cell("VA"	):SetBlock({||aValor[I_VALOR_ACESSORIO]})			//"Valor Acessório"
						oTitsForn:Cell("VLPAGO"	):SetBlock({||aValor[I_VALOR_PAGO]})
						oTitsForn:Cell("VLPAGANT"	):SetBlock({||aValor[I_PAGAM_ANT]})  				//"Pagto.Antecip"
						oTitsForn:Cell("SALDO"	):SetBlock({||nSaldo*if(alltrim((cAliasSE2)->E2_TIPO)$"PA ,"+MV_CPNEG,-1,1)})  //"Saldo Atual"
						oTitsForn:Cell("MOTIVO"):SetBlock({||aValor[I_MOTBX]})  					//"Motivo"

					   	nTotForn0+=Round(xMoeda(nValorOrig,(cAliasSE2)->E2_MOEDA,nMoeda,If(mv_par17 == 1,If(mv_par18 == 1,(cAliasSE2)->E2_EMISSAO,(cAliasSE2)->E2_EMIS1),dDataBase),nDecs+1,If(mv_par17 == 1 .and. (cAliasSE2)->E2_TXMOEDA>0,(cAliasSE2)->E2_TXMOEDA,))*if(alltrim((cAliasSE2)->E2_TIPO)$"PA ,"+MV_CPNEG,-1,1), nDecs)
					   	nTotForn1+=aValor[I_LEI10925]
						nTotForn2+=aValor[I_DESCONTO]
						nTotForn3+=nTotAbat
						nTotForn4+=aValor[I_JUROS]
						nTotForn5+=aValor[I_MULTA]
						nTotForn6+=aValor[I_CORRECAO_MONETARIA]
						If ! ((cAliasSE2)->E2_TIPO $ MVPAGANT+"/"+MV_CPNEG )
							nTotForn7+=aValor[I_VALOR_PAGO]
						Else
							nTotForn7-=aValor[I_VALOR_PAGO]
							nTotForn8+=aValor[I_PAGAM_ANT]
						Endif
						nTotForn9+=nSaldo*if(alltrim((cAliasSE2)->E2_TIPO)$"PA ,"+MV_CPNEG,-1,1)
						nTotFornA += aValor[I_VALOR_ACESSORIO]

						nTotFil0+=Round(xMoeda(nValorOrig,(cAliasSE2)->E2_MOEDA,nMoeda,If(mv_par17 == 1,If(mv_par18 == 1,(cAliasSE2)->E2_EMISSAO,(cAliasSE2)->E2_EMIS1),dDataBase),nDecs+1,If(mv_par17 == 1 .and. (cAliasSE2)->E2_TXMOEDA>0,(cAliasSE2)->E2_TXMOEDA,),If(mv_par17 == 1 .and. (cAliasSE2)->E2_TXMOEDA>0,1,))*if(alltrim((cAliasSE2)->E2_TIPO)$"PA ,"+MV_CPNEG,-1,1), nDecs)
						nTotFil1+=aValor[I_LEI10925]
						nTotFil2+=aValor[I_DESCONTO]
						nTotFil3+=nTotAbat
						nTotFil4+=aValor[I_JUROS]
						nTotFil5+=aValor[I_MULTA]
						nTotFil6+=aValor[I_CORRECAO_MONETARIA]
						If ! ((cAliasSE2)->E2_TIPO $ MVPAGANT+"/"+MV_CPNEG )
							nTotFil7+=aValor[I_VALOR_PAGO]
						Else
							nTotFil7-=aValor[I_VALOR_PAGO]
							nTotFil8+=aValor[I_PAGAM_ANT]
						Endif
						nTotFil9+=nSaldo*if(alltrim((cAliasSE2)->E2_TIPO)$"PA ,"+MV_CPNEG,-1,1)

						nTotFilA+=aValor[I_VALOR_ACESSORIO]
						oTitsForn:Cell("VLORIG"	):SetPicture(Tm(nValorOrig,oTitsForn:Cell("VLORIG"	):nSize,nDecs))  	//"Valor original"
						oTitsForn:Cell("LEI10925"	):SetPicture(Tm(aValor[I_LEI10925],oTitsForn:Cell("LEI10925"	):nSize,nDecs))  	//"Lei 10925"
				   		oTitsForn:Cell("DESCON"	):SetPicture(Tm(aValor[I_DESCONTO],oTitsForn:Cell("DESCON"	):nSize,nDecs)) 	//"Descontos"
				   		oTitsForn:Cell("ABAT"	):SetPicture(Tm(nTotAbat,oTitsForn:Cell("ABAT"	):nSize,nDecs))  	//"Abatimentos"
		  				oTitsForn:Cell("JUROS"	):SetPicture(Tm(aValor[I_JUROS],oTitsForn:Cell("JUROS"	):nSize,nDecs)) 	//"Juros"
						oTitsForn:Cell("MULTA"	):SetPicture(Tm(aValor[I_MULTA],oTitsForn:Cell("MULTA"	):nSize,nDecs)) 	//"Multa"
						oTitsForn:Cell("CMONE"	):SetPicture(Tm(aValor[I_CORRECAO_MONETARIA],oTitsForn:Cell("CMONE"	):nSize,nDecs))  //"Corr. Monet"
						oTitsForn:Cell("VA" 	):SetPicture(Tm(aValor[I_VALOR_ACESSORIO],oTitsForn:Cell("VA"	):nSize,nDecs))  //"Valor Acessório"
						oTitsForn:Cell("VLPAGO" 	):SetPicture(Tm(aValor[I_VALOR_PAGO],oTitsForn:Cell("VLPAGO"	):nSize,nDecs))  //"Valor Pago"
						oTitsForn:Cell("VLPAGANT"	):SetPicture(Tm(aValor[I_PAGAM_ANT],oTitsForn:Cell("VLPAGANT"	):nSize,nDecs))  //"Pagto.Antecip"
						oTitsForn:Cell("SALDO"):SetPicture(PictParent(Tm(nSaldo,oTitsForn:Cell("SALDO"	):nSize,nDecs))) 	//"SAldo atual"

						If lPrintForn
							oFornecedores:PrintLine()
							lPrintForn	:=	.F.
						Endif
						oTitsForn:PrintLine()
						oReport:IncMeter()
						nReg++
						nRegEmp++

					EndIf

					(cAliasSE2)->(dbSkip())

					If !Eval( bCondTit )
						cTexto := STR0010							
						If lImpXlsTbl .Or. oReport:lXlsTable							
							cNomeFor := SA2->A2_NOME
							If mv_par15 <> 1
								cNomeFor := SA2->A2_NREDUZ
							EndIf							
							cTexto := SA2->A2_COD + "-" + Alltrim(cNomeFor)
						EndIf						
						oTotaisForn:Cell("TXTTOTAL"):SetBlock({||cTexto }) 
						oTotaisForn:Cell("VLORIG"   ):SetBlock({||nTotForn0 }) 	//"Valor Original
						If cPaisLoc == "BRA"
							oTotaisForn:Cell("LEI10925"   ):SetBlock({||nTotForn1 })  	//"Lei 10925"
						EndIf
						oTotaisForn:Cell("DESCON"   ):SetBlock({||nTotForn2 })  	//"Descontos"
						oTotaisForn:Cell("ABAT"   ):SetBlock({||nTotForn3 })  	//"Abatimentos"
						oTotaisForn:Cell("JUROS"   ):SetBlock({||nTotForn4 })  	//"Juros"
						oTotaisForn:Cell("MULTA"   ):SetBlock({||nTotForn5 })  	//"Multa"
						oTotaisForn:Cell("CMONE"   ):SetBlock({||nTotForn6 })  	//"Corr. Monet"
						oTotaisForn:Cell("VA"   ):SetBlock({||nTotFornA }) 	//"Valor Acessório"
						oTotaisForn:Cell("VLPAGO"   ):SetBlock({||nTotForn7 })  	//"Valor Pago"
						oTotaisForn:Cell("VLPAGANT"   ):SetBlock({||nTotForn8 })  	//"Pagto.Antecip"
						oTotaisForn:Cell("SALDO" ):SetBlock({||nTotForn9 })  	//"Saldo Atual"

						oTotaisForn:Cell("VLORIG"	):SetPicture(Tm(nTotForn0,oTitsForn:Cell("VLORIG"	):nSize,nDecs)) //"Valor original"
						oTotaisForn:Cell("LEI10925"	):SetPicture(Tm(nTotForn1,oTitsForn:Cell("LEI10925"	):nSize,nDecs)) //"Lei 10925"
						oTotaisForn:Cell("DESCON"	):SetPicture(Tm(nTotForn2,oTitsForn:Cell("DESCON"	):nSize,nDecs)) //"Descontos"
						oTotaisForn:Cell("ABAT"	):SetPicture(Tm(nTotForn3,oTitsForn:Cell("ABAT"	):nSize,nDecs)) //"Abatimentos"
						oTotaisForn:Cell("JUROS"	):SetPicture(Tm(nTotForn4,oTitsForn:Cell("JUROS"	):nSize,nDecs)) //"Juros"
						oTotaisForn:Cell("MULTA"	):SetPicture(Tm(nTotForn5,oTitsForn:Cell("MULTA"	):nSize,nDecs)) //"Multa"
						oTotaisForn:Cell("CMONE"	):SetPicture(Tm(nTotForn6,oTitsForn:Cell("CMONE"	):nSize,nDecs)) //"Corr. Monet"
						oTotaisForn:Cell("VA" 	):SetPicture(Tm(nTotFornA,oTitsForn:Cell("VA"	):nSize,nDecs)) //"Valor Accessorio"
						oTotaisForn:Cell("VLPAGO" 	):SetPicture(Tm(nTotForn7,oTitsForn:Cell("VLPAGO"	):nSize,nDecs)) //"Valor Pago"
						oTotaisForn:Cell("VLPAGANT"	):SetPicture(Tm(nTotForn8,oTitsForn:Cell("VLPAGANT"	):nSize,nDecs)) //"Pagto.Antecip"
						oTotaisForn:Cell("SALDO"	):SetPicture(PictParent(Tm(nTotForn9,oTitsForn:Cell("SALDO"	):nSize,nDecs))) //"SAldo atual"

						oTotaisForn:Init()
						oReport:ThinLine()
						oTotaisForn:PrintLine()
						oTotaisForn:Finish()						
						oReport:SkipLine(2)

						nTotGeral0 += nTotForn0
						nTotGeral1 += nTotForn1
						nTotGeral2 += nTotForn2
						nTotGeral3 += nTotForn3
						nTotGeral4 += nTotForn4
						nTotGeral5 += nTotForn5
						nTotGeral6 += nTotForn6
						nTotGeral7 += nTotForn7
						nTotGeral8 += nTotForn8
						nTotGeral9 += nTotForn9
						nTotGeralA += nTotFornA

						// GESTÃO - início
						nTotEmp0 += nTotForn0
						nTotEmp1 += nTotForn1
						nTotEmp2 += nTotForn2
						nTotEmp3 += nTotForn3
						nTotEmp4 += nTotForn4
						nTotEmp5 += nTotForn5
						nTotEmp6 += nTotForn6
						nTotEmp7 += nTotForn7
						nTotEmp8 += nTotForn8
						nTotEmp9 += nTotForn9
						nTotEmpA += nTotFornA
						// GESTÃO - fim

						nTotForn0 := nTotForn1 := nTotForn2 := nTotForn3 := nTotForn4 := nTotForn5 := nTotForn6 := nTotForn7 := nTotForn8 := nTotForn9 := nTotFornA := 0
						lPrintForn := .T.
					EndIf

					If !Eval( bCondFil )
						If (mv_par19 == 1 .Or. !Empty(aSelFil)) .and. Len( aSM0 ) > 1 .And. lImpMFil

							If !oReport:nDevice == IMP_EXCEL 
								oTotaisFilial:Cell("PC"):Disable() 
								oTotaisFilial:Cell("TIP"):Disable()
								oTotaisFilial:Cell("EMISSAO"):Disable()
								oTotaisFilial:Cell("VENCTO"):Disable()
								oTotaisFilial:Cell("BAIXA"):Disable()
								oTotaisFilial:ResetCellPos(.T.) 
							EndIf

							oTotaisFilial:Cell("TXTTOTAL"):SetBlock({||AllTrim(STR0036) + AllTrim( cFilAux ) + "-" + AllTrim(FWFilialName(cEmpAnt,cFilAux)) })
							oTotaisFilial:Cell("VLORIG"   ):SetBlock({||nTotFil0 }) 		//"Valor Original
							If cPaisLoc == "BRA"
								oTotaisFilial:Cell("LEI10925"   ):SetBlock({||nTotFil1 })  //"Lei 10925"
							EndIf
							oTotaisFilial:Cell("DESCON"   ):SetBlock({||nTotFil2 })  	//"Descontos"
							oTotaisFilial:Cell("ABAT"   ):SetBlock({||nTotFil3 })  	//"Abatimentos"
							oTotaisFilial:Cell("JUROS"   ):SetBlock({||nTotFil4 })  	//"Juros"
							oTotaisFilial:Cell("MULTA"   ):SetBlock({||nTotFil5 })  	//"Multa"
							oTotaisFilial:Cell("CMONE"   ):SetBlock({||nTotFil6 })  	//"Corr. Monet"
							oTotaisFilial:Cell("VA"   ):SetBlock({||nTotFilA })  	//"Valor Acessório"
							oTotaisFilial:Cell("VLPAGO"   ):SetBlock({||nTotFil7 })  	//"Valor Pago"
							oTotaisFilial:Cell("VLPAGANT"   ):SetBlock({||nTotFil8 })  	//"Pagto.Antecip"
							oTotaisFilial:Cell("SALDO"   ):SetBlock({||nTotFil9 })  	//"Saldo Atual"

							oTotaisFilial:Cell("VLORIG"	):SetPicture(Tm(nTotFil0,oTitsForn:Cell("VLORIG"	):nSize,nDecs))					//"Valor original"
							oTotaisFilial:Cell("LEI10925"	):SetPicture(Tm(nTotFil1,oTitsForn:Cell("LEI10925"	):nSize,nDecs))					//"Lei 10925"
							oTotaisFilial:Cell("DESCON"	):SetPicture(Tm(nTotFil2,oTitsForn:Cell("DESCON"	):nSize,nDecs))					//"Descontos"
							oTotaisFilial:Cell("ABAT"	):SetPicture(Tm(nTotFil3,oTitsForn:Cell("ABAT"	):nSize,nDecs))					//"Abatimentos"
							oTotaisFilial:Cell("JUROS"	):SetPicture(Tm(nTotFil4,oTitsForn:Cell("JUROS"	):nSize,nDecs))					//"Juros"
							oTotaisFilial:Cell("MULTA"	):SetPicture(Tm(nTotFil5,oTitsForn:Cell("MULTA"):nSize,nDecs))					//"Multa"
							oTotaisFilial:Cell("CMONE"	):SetPicture(Tm(nTotFil6,oTitsForn:Cell("CMONE"	):nSize,nDecs))					//"Corr. Monet"
							oTotaisFilial:Cell("VA"	):SetPicture(Tm(nTotFilA,oTitsForn:Cell("VA"	):nSize,nDecs))					//"Valor Acessório"
							oTotaisFilial:Cell("VLPAGO"	):SetPicture(Tm(nTotFil7,oTitsForn:Cell("VLPAGO"	):nSize,nDecs))					//"Valor Pago"
							oTotaisFilial:Cell("VLPAGANT"	):SetPicture(Tm(nTotFil8,oTitsForn:Cell("VLPAGANT"	):nSize,nDecs))					//"Pagto.Antecip"
							oTotaisFilial:Cell("SALDO"	):SetPicture(PictParent(Tm(nTotFil9,oTitsForn:Cell("SALDO"	):nSize,nDecs)))	//"SAldo atual"

							oTotaisFilial:Init()
							oReport:ThinLine()
							oTotaisFilial:PrintLine()
							oTotaisFilial:Finish()
							oReport:SkipLine(2)
							nTotFil0 := nTotFil1 := nTotFil2 := nTotFil3 := nTotFil4 := nTotFil5 := nTotFil6 := nTotFil7 := nTotFil8 := nTotFil9 := nTotFilA := 0
						EndIf
					EndIf
				EndDo
				lPrintForn	:=	lPrintForn
				//imprime os totais por fornecedor
				#IFNDEF TOP
					(cAliasSA2)->(dbSkip())
				#ENDIF
			EndDo

			//Imprime ou não as filiais sem movimento - P.E. F350MFIL
			If !lMovFil
				lImpMFil := Iif(nReg != 0, .T., .F.)
			Endif

			lInitForn := .T.

			AAdd( aFilProc, xFilial("SE2") )

			// GESTÃO - início
			If lTotEmp
				If nInc <= Len(aSM0)
					If (nInc == Len(aSM0)) .Or. !(Substr(aSM0[nInc,SM0_CODFIL],1,nTamEmp) == Substr(aSM0[nInc+1,SM0_CODFIL],1,nTamEmp))
						If lImpMFil .Or. nRegEmp <> 0
							oTotaisEmp:Cell("TXTTOTAL"):SetBlock({||STR0040 + " - " + Substr(aSM0[nInc,SM0_CODFIL],1,nTamEmp)})		//"Total empresa"
							oTotaisEmp:Cell("VLORIG"   ):SetBlock({||nTotEmp0 }) 		//"Valor Original
							If cPaisLoc == "BRA"
								oTotaisEmp:Cell("LEI10925"   ):SetBlock({||nTotEmp1 })  //"Lei 10925"
							EndIf
							oTotaisEmp:Cell("DESCON"   ):SetBlock({||nTotEmp2 })  	//"Descontos"
							oTotaisEmp:Cell("ABAT"   ):SetBlock({||nTotEmp3 })  	//"Abatimentos"
							oTotaisEmp:Cell("JUROS"   ):SetBlock({||nTotEmp4 })  	//"Juros"
							oTotaisEmp:Cell("MULTA"   ):SetBlock({||nTotEmp5 })  	//"Multa"
							oTotaisEmp:Cell("CMONE"   ):SetBlock({||nTotEmp6 })  	//"Corr. Monet"
							oTotaisEmp:Cell("VA"   ):SetBlock({||nTotEmpA })  	//"Valor Acessório"
							oTotaisEmp:Cell("VLPAGO"   ):SetBlock({||nTotEmp7 })  	//"Valor Pago"
							oTotaisEmp:Cell("VLPAGANT"   ):SetBlock({||nTotEmp8 })  	//"Pagto.Antecip"
							oTotaisEmp:Cell("SALDO"   ):SetBlock({||nTotEmp9 })  	//"Saldo Atual"

							oTotaisEmp:Cell("VLORIG"	):SetPicture(Tm(nTotEmp0,oTitsForn:Cell("VLORIG"	):nSize,nDecs))					//"Valor original"
							oTotaisEmp:Cell("LEI10925"	):SetPicture(Tm(nTotEmp1,oTitsForn:Cell("LEI10925"	):nSize,nDecs))					//"Lei 10925"
							oTotaisEmp:Cell("DESCON"	):SetPicture(Tm(nTotEmp2,oTitsForn:Cell("DESCON"	):nSize,nDecs))					//"Descontos"
							oTotaisEmp:Cell("ABAT"	):SetPicture(Tm(nTotEmp3,oTitsForn:Cell("ABAT"	):nSize,nDecs))					//"Abatimentos"
							oTotaisEmp:Cell("JUROS"	):SetPicture(Tm(nTotEmp4,oTitsForn:Cell("JUROS"	):nSize,nDecs))					//"Juros"
							oTotaisEmp:Cell("MULTA"	):SetPicture(Tm(nTotEmp5,oTitsForn:Cell("MULTA"	):nSize,nDecs))					//"Multa"
							oTotaisEmp:Cell("CMONE"	):SetPicture(Tm(nTotEmp6,oTitsForn:Cell("CMONE"	):nSize,nDecs))					//"Corr. Monet"
							oTotaisEmp:Cell("VA"	):SetPicture(Tm(nTotEmpA,oTitsForn:Cell("VA"):nSize,nDecs))					//"Valor Acessório"
							oTotaisEmp:Cell("VLPAGO"	):SetPicture(Tm(nTotEmp7,oTitsForn:Cell("VLPAGO"	):nSize,nDecs))					//"Valor Pago"
							oTotaisEmp:Cell("VLPAGANT"	):SetPicture(Tm(nTotEmp8,oTitsForn:Cell("VLPAGANT"	):nSize,nDecs))					//"Pagto.Antecip"
							oTotaisEmp:Cell("SALDO"	):SetPicture(PictParent(Tm(nTotEmp9,oTitsForn:Cell("SALDO"	):nSize,nDecs)))	//"SAldo atual"

							oTotaisEmp:Init()
							oReport:ThinLine()
							oTotaisEmp:PrintLine()
							oTotaisEmp:Finish()
							oReport:SkipLine(2)
							nTotEmp0:= nTotEmp1:= nTotEmp2:= nTotEmp3:= nTotEmp4:= nTotEmp5:= nTotEmp6:= nTotEmp7:= nTotEmp8:= nTotEmp9:= nTotEmpA := 0
							nRegEmp := 0
						Endif
					Endif
				Endif
			Endif
			// GESTÃO - fim
		EndIf
	EndIf
Next


//Imprime Total geral
oTotalGeral:Cell("TXTTOTAL"):SetBlock({||STR0011  })
oTotalGeral:Cell("VLORIG"   ):SetBlock({||nTotGeral0 }) 			//"Valor Original
If cPaisLoc == "BRA"
	oTotalGeral:Cell("LEI10925"   ):SetBlock({||nTotGeral1 })  	//"Lei 10925"
EndIf
oTotalGeral:Cell("DESCON"   ):SetBlock({||nTotGeral2 })  		//"Descontos"
oTotalGeral:Cell("ABAT"   ):SetBlock({||nTotGeral3 })  		//"Abatimentos"
oTotalGeral:Cell("JUROS"   ):SetBlock({||nTotGeral4 })  		//"Juros"
oTotalGeral:Cell("MULTA"   ):SetBlock({||nTotGeral5 })  		//"Multa"
oTotalGeral:Cell("CMONE"   ):SetBlock({||nTotGeral6 })  		//"Corr. Monet"
oTotalGeral:Cell("VA"   ):SetBlock({||nTotGeralA })  		//"Valor Acessório"
oTotalGeral:Cell("VLPAGO"   ):SetBlock({||nTotGeral7 })  		//"Valor Pago"
oTotalGeral:Cell("VLPAGANT"   ):SetBlock({||nTotGeral8 })  		//"Pagto.Antecip"
oTotalGeral:Cell("SALDO"   ):SetBlock({||nTotGeral9 })  		//"Saldo Atual"

oTotalGeral:Cell("VLORIG"	):SetPicture(PictParent(Tm(nTotGeral0,oTitsForn:Cell("VLORIG"	):nSize,nDecs)))		//"Valor original"
oTotalGeral:Cell("LEI10925"	):SetPicture(Tm(nTotGeral1,oTitsForn:Cell("LEI10925"	):nSize,nDecs))						//"Lei 10925"
oTotalGeral:Cell("DESCON"	):SetPicture(Tm(nTotGeral2,oTitsForn:Cell("DESCON"	):nSize,nDecs))						//"Descontos"
oTotalGeral:Cell("ABAT"	):SetPicture(Tm(nTotGeral3,oTitsForn:Cell("ABAT"	):nSize,nDecs))						//"Abatimentos"
oTotalGeral:Cell("JUROS"	):SetPicture(Tm(nTotGeral4,oTitsForn:Cell("JUROS"	):nSize,nDecs))						//"Juros"
oTotalGeral:Cell("MULTA"	):SetPicture(Tm(nTotGeral5,oTitsForn:Cell("MULTA"	):nSize,nDecs))						//"Multa"
oTotalGeral:Cell("CMONE"	):SetPicture(Tm(nTotGeral6,oTitsForn:Cell("CMONE"	):nSize,nDecs))						//"Corr. Monet"
oTotalGeral:Cell("VA" 	):SetPicture(Tm(nTotGeralA,oTitsForn:Cell("VA"	):nSize,nDecs))						//"Valor Acessório"
oTotalGeral:Cell("VLPAGO" 	):SetPicture(Tm(nTotGeral7,oTitsForn:Cell("VLPAGO"	):nSize,nDecs))						//"Valor Pago"
oTotalGeral:Cell("VLPAGANT"	):SetPicture(Tm(nTotGeral8,oTitsForn:Cell("VLPAGANT"	):nSize,nDecs))						//"Pagto.Antecip"
oTotalGeral:Cell("SALDO"	):SetPicture(PictParent(Tm(nTotGeral9,oTitsForn:Cell("SALDO"	):nSize,nDecs)))		//"SAldo atual"

oTotalGeral:Init()
oReport:ThinLine()
oTotalGeral:PrintLine()
oTotalGeral:Finish()

oTitsForn:Finish()
oFornecedores:Finish()

SM0->(dbGoTo(nRegSM0))
cFilAnt := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ AndaTRB	³ Autor ³ Emerson / Sandro      ³ Data ³ 20.09.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Movimenta area temporaria e reposiciona SE1 ou SE2 ou SE5  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³         																	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function AndaTRB(xMyAlias)

Local cAlias:= Alias()

dbSelectArea(XMyAlias)
dbSkip()
(cAlias)->(dbGoTo((xMyAlias)->Recno))
dbSelectArea(cAlias)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³PictNeg	³ Autor ³ Adrianne Furtado  	³ Data ³ 03.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³TRansforme uma Picture em Picture com "()"parenteses para   ³±±
±±³          ³valores negativos. 										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ FINR350.PRX												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PictParent(cPict)
	Local   cRet
	Local   nAt   := At("9",cPict)
	Default cPict := ""

	If oReport:nDevice == 4 //(IMP_EXCEL) Impressao em Excel, usar a picture padrão
		cRet := cPict		
	Else 
		cRet := SubStr(cPict,1,nAt-2)+")"+SubStr(cPict,nAt-1,Len(cPict)) 
	EndIf

Return cRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³AdmAbreSM0³ Autor ³ Orizio                ³ Data ³ 22/01/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna um array com as informacoes das filias das empresas ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function AdmAbreSM0()
	Local aArea			:= SM0->(GetArea())
	Local aAux			:= {}
	Local aRetSM0		:= {}
	Local lFWLoadSM0	:= .T.
	Local lFWCodFilSM0 	:= .T.

	If lFWLoadSM0
		aRetSM0	:= FWLoadSM0()
	Else
		DbSelectArea( "SM0" )
		SM0->( DbGoTop() )
		While SM0->( !Eof() )
			aAux := { 	SM0->M0_CODIGO,;
						IIf( lFWCodFilSM0, FWGETCODFILIAL, SM0->M0_CODFIL ),;
						"",;
						"",;
						"",;
						SM0->M0_NOME,;
						SM0->M0_FILIAL }

			aAdd( aRetSM0, aClone( aAux ) )
			SM0->( DbSkip() )
		EndDo
	EndIf

	RestArea(aArea)
Return aRetSM0
