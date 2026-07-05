/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "PROTHEUS.CH"
#Include "OFIPR020.ch"  

Static cPrefVEI := GetNewPar("MV_PREFVEI","VEI")
Static cPrefOFI := GetNewPar("MV_PREFOFI","OFI")

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ OFIPR020 บ Autor ณ Andre Luis Almeida บ Data ณ  16/04/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relatorio de Analise do Estoque                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MIL                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ MV_PAR01 ณ Indique quais grupos a considerar no relatorio. Se branco  บฑฑ
ฑฑบ          ณ mostra todos os Grupos                                     บฑฑ
ฑฑบ MV_PAR02 ณ De 1 a 9. Faixas para mostrar os Itens de Vendas Analitico บฑฑ
ฑฑบ          ณ correspondente. Se "*" mostra todas as Linhas.             บฑฑ
ฑฑบ MV_PAR03 ณ Valor a Considerar: Custo ou Reposicao                     บฑฑ
ฑฑบ MV_PAR04 ณ Ordem do Relatorio:  Item(Grupo/Cod) ou Vlr(Custo/Reposic) บฑฑ
ฑฑบ MV_PAR05 ณ Colocar "LinhaColuna" p/ mostrar os Itens de Compras       บฑฑ
ฑฑบ          ณ Analitico correspondente. Se "*" ou "**" mostra todas as   บฑฑ
ฑฑบ          ณ Linhas e Colunas. Se "*Coluna" mostra todas as linhas da   บฑฑ
ฑฑบ          ณ Coluna correspondente. Se "Linha*" mostra todas as Colunas บฑฑ
ฑฑบ          ณ da Linha correspondente.                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function OFIPR020

Local cPerg := "OFP020"
cDesc1    := STR0001
cDesc2    := ""
cDesc3    := ""
cAlias    := "SB2"
aRegistros:= {}
nLin      := 0
aPag      := 1
nIte      := 1
aReturn   := { STR0002 , 1 , STR0003 , 2 , 2 , 1 , "" , 1 }
cTamanho  := "M"          // P/M/G
Limite    := 132          // 80/132/220
aOrdem    := {}          // Ordem do Relatorio
cTitulo   := STR0004
cNomeProg := "OFIPR020"
cNomeRel  := "OFIPR020"
nLastKey  := 0
nCaracter := 15
cabec1    := ""
cabec2    := ""

// cPerg := PADR(cPerg,Len(SX1->X1_GRUPO))
// AADD(aRegs,{STR0088, "", "", "mv_ch1", "C", 50, 0, 0, "G", "", "mv_par01", "", "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,{STR0089},{},{}})
// AADD(aRegs,{STR0090, "", "", "mv_ch2", "C", 20, 0, 0, "G", "", "mv_par02", "", "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,{STR0091,STR0092,STR0058,STR0059,STR0060,STR0061,STR0062,STR0063,STR0064,STR0065,STR0066,STR0093,STR0094,STR0095},{},{}})
// AADD(aRegs,{STR0096, "", "", "mv_ch3", "N", 1 , 0, 0, "C", "", "mv_par03", STR0097, "" , "" , "" , "" , STR0098 , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,{STR0099},{},{}})
// AADD(aRegs,{STR0100, "", "", "mv_ch4", "N", 1 , 0, 0, "C", "", "mv_par04", STR0101, "" , "" , "" , "" , STR0102 , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,{STR0103},{},{}})
// AADD(aRegs,{STR0104, "", "", "mv_ch5", "C", 60, 0, 0, "G", "", "mv_par05", "", "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,{STR0105,STR0106,STR0107,STR0108,STR0109,STR0110,STR0111,STR0112,STR0113,STR0114,STR0115,STR0116,STR0117,STR0118},{},{}})

cNomeRel:=SetPrint(cAlias,cNomeRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,,cTamanho)
If nLastKey == 27
	Return
EndIf
PERGUNTE(cPerg,.f.)

SetDefault(aReturn,cAlias)
RptStatus( { |lEnd| FS_IMPOFP020(@lEnd,cNomeRel,cAlias) } , cTitulo )

If aReturn[5] == 1
	OurSpool( cNomeRel )
EndIf

MS_Flush()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณFS_IMPOFP020บ Autor ณ Andre Luis Almeida บ Data ณ 16/04/02  บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Levantamento / Impressao Relatorio de Analise do Estoque   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FS_IMPOFP020()

Local nLacoEE, ni, nj
Local cDt1 := ""
Local cDt2 := ""
Local nee
Local lB1_DTULTVD := ( SB1->(FieldPos("B1_DTULTVD")) # 0 )
Private cbTxt    := Space(10)
Private cbCont   := 0
Private cString  := "SB2"
Private Li       := 132
Private m_Pag    := 1
Private aTotVdas := {}
Private aCusCpra := {}
Private aQtdCpra := {}
Private aTotCpra := {}
Private aTotProd := {}
Private aGrpProd := {}
Private aNumProd := {}
Private cTp      := ""
Private aTp      := {}
Private aTtCpra  := {}
Private aGrpCpra := {}
Private aNumCpra := {}
Private nTotSB2  := 0 , ci := "" , cMudou := STR0055 , cMudou2:= STR0055    //INICIAL
Private cCusRep  := If(MV_PAR03==1,STR0005,STR0006) //Custo # Repos
Private cCabTot  := STR0007+cCusRep+STR0008+" "+cCusRep+STR0009 // "   Itens                           Localizacao Almx  Dispon. " / " Unit. " / " Total Preco Venda Ult.Cmp. Ult.Vda. Cl"
Private aGrupos  := {}
Private nPos     := 0
Private dDtVenda := ctod("")
Private dDtCompra:= ctod("")
Private dDtUltVda:= ctod("")
Private dDtUltCpa:= ctod("")
Private cSemData := STR0056 //NAO
Private cSeekSF2 := ""
Private cConfere := ""
Private nTotSD2  := 0
Private nTotSD1  := 0
Private cGrupoSZ := ""
Private cVariav  := ""
Private cQAlSB2  := "SQLSB2" // SB2
Private cQAlSD2  := "SQLSD2" // SD2
Private cAliasSF1 := "SQLSF1"

cabec1 := STR0010 //Grupos
cMVPAR01 := MV_PAR01

DbSelectArea( "SBM" )
DbSetOrder( 1 )
DbSeek( xFilial( "SBM" ) )
While !Eof() .and. SBM->BM_FILIAL == xFilial("SBM")
	If !Empty(SBM->BM_TIPGRU) .and. !(left(SBM->BM_TIPGRU,1) $ "3/4/7")
		If Empty(cMVPAR01) .or. ( SBM->BM_GRUPO $ cMVPAR01 )
			aAdd(aGrupos,{ SBM->BM_GRUPO })
			cabec1 += SBM->BM_GRUPO + "/"
			cVariav+= "'"+SBM->BM_GRUPO+"',"
		EndIf
	EndIf
	DbSelectArea("SBM")
	DbSkip()
EndDo
aAdd(aTp,{ "A" , STR0011 })// 0 a  30"
aAdd(aTp,{ "B" , STR0012 })//31 a  60
aAdd(aTp,{ "C" , STR0013 })//61 a  90
aAdd(aTp,{ "D" , STR0014 })//91 a 120
aAdd(aTp,{ "E" , STR0015 })//121 a 180
aAdd(aTp,{ "F" , STR0016 })//181 a 240
aAdd(aTp,{ "G" , STR0017 })//241 a 365
aAdd(aTp,{ "H" , STR0018 })//366 a 730
aAdd(aTp,{ "I" , STR0019 })//+ de 730
Set Printer to &cNomeRel
Set Printer On
Set Device  to Printer
nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
cCusRep  := If(MV_PAR03==1,STR0020,STR0021)//"de Custo # Reposic.
cFormVda := substr(GETMV("MV_FMLPECA"),2,6)
cAlmxGar := ""
cFormGar := ""
cAlmxOfi := ""
DbSelectArea("VOI")
DbSetOrder(1)
DbSeek( xFilial("VOI") )
Do While !Eof() .and. VOI->VOI_FILIAL == xFilial("VOI")
	If VOI->VOI_CODALM <> "01" // nao considerar almoxarifado 01 - disponivel (estoque)
		If Alltrim(VOI->VOI_SITTPO) == "2"
			cFormGar := VOI->VOI_VALPEC
			cAlmxGar += VOI->VOI_CODALM+"/"
		Else
			cAlmxOfi += VOI->VOI_CODALM+"/"
		EndIf
	EndIf
	DbSelectArea("VOI")
	DbSkip()
EndDo

/*
aAdd(aTotVdas,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 }) //	  0 a  30      (1)
aAdd(aTotVdas,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 }) //	 31 a  60      (2)
aAdd(aTotVdas,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 }) //	 61 a  90      (3)
aAdd(aTotVdas,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 }) //	 91 a 120      (4)
aAdd(aTotVdas,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 }) //	121 a 180      (5)
aAdd(aTotVdas,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 }) //	181 a 240      (6)
aAdd(aTotVdas,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 }) //	241 a 365      (7)
aAdd(aTotVdas,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 }) //	366 a 730      (8)
aAdd(aTotVdas,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 })	//	 + de 730      (9)
aAdd(aTotVdas,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 })	//	T O T A L     (10)

aAdd(aQtdCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }) 	//	  0 a  30      (1)
aAdd(aQtdCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }) 	//	 31 a  60      (2)
aAdd(aQtdCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }) 	//	 61 a  90      (3)
aAdd(aQtdCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }) 	//	 91 a 120      (4)
aAdd(aQtdCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }) 	//	121 a 180      (5)
aAdd(aQtdCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }) 	//	181 a 240      (6)
aAdd(aQtdCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }) 	//	241 a 365      (7)
aAdd(aQtdCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }) 	//	366 a 730      (8)
aAdd(aQtdCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })	//	 + de 730      (9)

aAdd(aCusCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }) 	//	  0 a  30      (1)
aAdd(aCusCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }) 	//	 31 a  60      (2)
aAdd(aCusCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }) 	//	 61 a  90      (3)
aAdd(aCusCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }) 	//	 91 a 120      (4)
aAdd(aCusCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }) 	//	121 a 180      (5)
aAdd(aCusCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }) 	//	181 a 240      (6)
aAdd(aCusCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }) 	//	241 a 365      (7)
aAdd(aCusCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }) 	//	366 a 730      (8)
aAdd(aCusCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })	//	 + de 730      (9)
*/

aVetEE1 := {}
aVetEE2 := {}
aVetEE3 := {}
aVetEE4 := {}
aVetEE5 := {}
aVetEESpc := {}
aVetSemEE := {}
aVetSZ  := {}
// Acrescentou o aVetSZ por causa do Super Zerado
nVLacoEE:= 8//7

cQuery := "SELECT "
cQuery +=    "SB2.R_E_C_N_O_ , SB1.B1_GRUPO "
cQuery += "FROM "
cQuery +=  RetSqlName("SB1")+" SB1 "
cQuery +=  "JOIN "+RetSqlName("SB2")+" SB2 ON ( "
cQuery +=        "SB2.B2_FILIAL = '"+xFilial("SB2")+"' AND "
cQuery +=        "SB2.B2_COD = SB1.B1_COD AND "
cQuery +=        "SB2.B2_QATU > 0 AND "
cQuery +=        "SB2.D_E_L_E_T_=' ' ) "
cQuery +=  "JOIN "+RetSqlName("SB5")+" SB5 ON ( "
cQuery +=        "SB5.B5_FILIAL = '"+xFilial("SB5")+"' AND "
cQuery +=        "SB5.B5_COD = SB1.B1_COD AND "
cQuery +=        "SB5.D_E_L_E_T_=' ' ) "
cQuery += "WHERE "
cQuery +=        "SB1.B1_FILIAL = '"+xFilial("SB1")+"' AND "
If !Empty(cVariav) .and. len(cVariav) > 1
	cQuery +=    "SB1.B1_GRUPO IN ("+left(cVariav,len(cVariav)-1)+") AND "
Else
	cQuery +=    "SB1.B1_GRUPO='NAO_ENCONTRAR_PRODUTO' AND " // Grupo nao escolhido pelo usuario
EndIf
cQuery +=        "SB1.D_E_L_E_T_=' ' "
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlSB2 , .F., .T. )
SetRegua(( cQAlSB2 )->( RecCount() ))
While !( cQAlSB2 )->( Eof() )
	IncRegua()
	If !( ( cQAlSB2 )->(B1_GRUPO) $ cGrupoSZ )
		aAdd(aVetSemEE, ( cQAlSB2 )->( R_E_C_N_O_ ) )
	EndIf
	( cQAlSB2 )->( DbSkip() )
EndDo
( cQAlSB2 )->( DbCloseArea() )

DbSelectArea("SB2")
DbSetOrder(1)

SetRegua( RecCount() )
For nEE := 1 to nVLacoEE
	aCusCpra := {}
	aQtdCpra := {}
	aTotCpra := {}
	aTotProd := {}
	aGrpProd := {}
	aNumProd := {}
	aTotVdas := {}
	nTotSD2  := 0
	nTotSD1  := 0
	nQtdVda  := 0
	cTp      := ""
	aTtCpra  := {}
	aGrpCpra := {}
	aNumCpra := {}

	For nj := 1 to 9
		aAdd(aTotVdas,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 })
		aAdd(aQtdCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
		aAdd(aCusCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
	Next
	aAdd(aTotVdas,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 }) // 10 - Total

	Do Case	
		Case nEE == 1
			nTotVEE := Len (aVetEE1)
		Case nEE == 2
			nTotVEE := Len (aVetEE2)
		Case nEE == 3
			nTotVEE := Len (aVetEE3)
		Case nEE == 4
			nTotVEE := Len (aVetEE4)
		Case nEE == 5
			nTotVEE := Len (aVetEE5)
		Case nEE == 6
			nTotVEE := Len (aVetEESpc)
		Case nEE == 7
			nTotVEE := Len (aVetSemEE)
		Case nEE == 8
			nTotVEE := Len (aVetSZ)
	EndCase
	
	for nLacoEE := 1 to nTotVEE
		DbSelectArea("SB2")
		Do Case
			Case nEE == 1
				DBGoTo(aVetEE1[nLacoEE])
			Case nEE == 2
				DBGoTo(aVetEE2[nLacoEE])
			Case nEE == 3
				DBGoTo(aVetEE3[nLacoEE])
			Case nEE == 4
				DBGoTo(aVetEE4[nLacoEE])
			Case nEE == 5
				DBGoTo(aVetEE5[nLacoEE])
			Case nEE == 6
				DBGoTo(aVetEESpc[nLacoEE])
			Case nEE == 7
				DBGoTo(aVetSemEE[nLacoEE])
			OtherWise //if nEE == 8
				DBGoTo(aVetSZ[nLacoEE])
		EndCase
		DbSelectArea("SB1")
		DbSetOrder(1)
		DBSeek(xFilial("SB1")+SB2->B2_COD)
		nPos := aScan(aGrupos,{|x| x[1] == SB1->B1_GRUPO })
		If nPos > 0
			DbSelectArea("SB5")
			DbSetOrder(1)
			If DbSeek( xFilial("SB5") + SB2->B2_COD )
				dDtUltVda := ctod("")
				cSemData  := STR0056 //NAO
				
				cQuery := "SELECT SD2.D2_EMISSAO FROM "+RetSqlName("SD2")+" SD2 WHERE SD2.D2_FILIAL='"+xFilial("SD2")+"' AND "
				cQuery += "SD2.D2_COD='"+SB2->B2_COD+"' AND SD2.D_E_L_E_T_=' ' ORDER BY SD2.D2_EMISSAO DESC "
				dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlSD2 , .F., .T. )
				If !( cQAlSD2 )->( Eof() )
					dDtUltVda := stod((cQAlSD2)->( D2_EMISSAO ))
				Endif
				( cQAlSD2 )->( DbCloseArea() )
				
				DbSelectArea("SB1")
				If Empty(dDtUltVda)
					If lB1_DTULTVD .and. !Empty(SB1->B1_DTULTVD)
						dDtUltVda := SB1->B1_DTULTVD
					Else
						dDtUltVda := SB1->B1_UCOM
						cSemData  := STR0057 //SIM
					EndIf
				EndIf
				DbSelectArea("SB2")
				If SB2->B2_QATU == 0
					cSemData := STR0057 //SIM
				EndIf
				Do Case
					Case ( ( dDataBase - dDtUltVda ) <  31 )
						ci := STR0058//0 a  30 dias(1)
						FS_OPR20SOMA(1)
					Case ( ( dDataBase - dDtUltVda ) <  61 )
						ci := STR0059//31 a  60 dias(2)
						FS_OPR20SOMA(2)
					Case ( ( dDataBase - dDtUltVda ) <  91 )
						ci := STR0060// 61 a  90 dias(3)
						FS_OPR20SOMA(3)
					Case ( ( dDataBase - dDtUltVda ) < 121 )
						ci := STR0061//91 a 120 dias(4)
						FS_OPR20SOMA(4)
					Case ( ( dDataBase - dDtUltVda ) < 181 )
						ci := STR0062//121 a 180 dias(5)
						FS_OPR20SOMA(5)
					Case ( ( dDataBase - dDtUltVda ) < 241 )
						ci := STR0063//181 a 240 dias(6)
						FS_OPR20SOMA(6)
					Case ( ( dDataBase - dDtUltVda ) < 366 )
						ci := STR0064//241 a 365 dias(7)
						FS_OPR20SOMA(7)
					Case ( ( dDataBase - dDtUltVda ) < 731 )
						ci := STR0065//366 a 730 dias(8)
						FS_OPR20SOMA(8)
					OtherWise
						ci := STR0066//+ de 730 dias(9)
						FS_OPR20SOMA(9)
				EndCase
				FS_OPR20SOMA(10)
			EndIf
		EndIf
		DbSelectArea("SB2")
		DbSkip()
	next
	if nTotVEE ==0
		loop
	endif
	DbSelectArea("SF2")
	DbSetOrder(0)
	DbGoBottom()
	dDtVenda := SF2->F2_EMISSAO
	//	21/06/2007 - Manoel - Da forma que estava, a DATA DA ULTIMA COMPRA estava ficando errada
	//	DbSelectArea("SF1")
	//	DbSetOrder(0)
	//	DbGoBottom()
	//	dDtCompra := SF1->F1_EMISSAO
	//
	cQryAl001 := GetNextAlias()
	cQuery := "SELECT MAX(D1_EMISSAO) DTMAX FROM "+RetSqlName("SD1")
	cQuery += " WHERE D1_FILIAL ='" + xFilial("SD1") + "' AND D_E_L_E_T_=' '"
	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQryAl001, .F., .T. )
	//
	if !(cQryAl001)->(eof())
		dDtCompra := stod((cQryAl001)->(DTMAX))
	else
		dDtCompra := stod("00000000")
	endif
	//
	(cQryAl001)->(dbCloseArea())
	//
	nQtdVda := 0
	nTotSD2 := 0
	DbSelectArea("SD2")
	DbSetOrder(5)
	DbSeek( xFilial("SD2") + dtos(dDatabase-30) , .t. )
	cNF := SD2->D2_DOC + SD2->D2_SERIE
	//	DbSelectArea("SD2")
	//	DbSetOrder(3)
	//	DbSeek( xFilial("SD2") + cNF )
	cNF := STR0055 //INICIAL
	While !Eof() .and. xFilial("SD2") == SD2->D2_FILIAL
		nPos := aScan(aGrupos,{|x| x[1] == SD2->D2_GRUPO })
		If nPos == 0
			DbSelectArea("SD2")
			Dbskip()
			Loop
		EndIf
		DbSelectArea("SB1")
		DbSetOrder(1)
		DBSeek(xFilial("SB1")+SD2->D2_COD)
		If nEE == 8
			If !(SB1->B1_GRUPO $ cGrupoSZ)
				DbSelectArea("SD2")
				Dbskip()
				Loop
			endif
		endif
		DbSelectArea("SB5")
		DbSetOrder(1)
		If DbSeek( xFilial("SB5") + SD2->D2_COD )
			if (nEE ==1 .and. SB5->B5_ESTRAT != "1") .or.;
				(nEE ==2 .and. SB5->B5_ESTRAT != "2") .or.;
				(nEE ==3 .and. SB5->B5_ESTRAT != "3") .or.;
				(nEE ==4 .and. SB5->B5_ESTRAT != "4") .or.;
				(nEE ==5 .and. SB5->B5_ESTRAT != "5") .or.;
				(nEE ==6 .and. SB5->B5_ESTRAT != " ")
				DbSelectArea("SD2")
				Dbskip()
				Loop
			endif
		EndIf
		DbSelectArea("SF4")
		DbSetOrder(1)
		If !DbSeek( xFilial("SF4") + SD2->D2_TES )
			DbSelectArea("SD2")
			Dbskip()
			Loop
		EndIf
		If Alltrim(SF4->F4_ATUATF) == "S" .or. SF4->F4_DUPLIC == "N" .or. SF4->F4_OPEMOV # "05" .or. SF4->F4_ESTOQUE # "S"
			DbSelectArea("SD2")
			Dbskip()
			Loop
		EndIf
		
		DbSelectArea("SF2")
		DbSetOrder(1)
		If !DbSeek( xFilial("SF2") + SD2->D2_DOC + SD2->D2_SERIE )
			DbSelectArea("SD2")
			Dbskip()
			Loop
		EndIf
		If SF2->F2_PREFORI == cPrefVEI // Veiculos
			DbSelectArea("SD2")
			Dbskip()
			Loop
		ElseIf SF2->F2_PREFORI == cPrefOFI // Oficina
			If SD2->D2_BASEISS > 0
				DbSelectArea("SD2")
				Dbskip()
				Loop
			EndIf
		EndIf
		If ( cNF # ( SD2->D2_DOC + SD2->D2_SERIE ) )
			cNF := ( SD2->D2_DOC + SD2->D2_SERIE )
			nQtdVda++
		EndIf
		nTotSD2 += SD2->D2_CUSTO1
		DbSelectArea("SD2")
		DbSkip()
	EndDo
	nTotSD1 := 0
	
	cQuery := "SELECT SF1.F1_DTDIGIT,SF1.F1_TIPO,SF1.F1_DOC,SF1.F1_SERIE,SF1.F1_FORNECE,SF1.F1_LOJA "
	cQuery += "FROM "
	cQuery += RetSqlName( "SF1" ) + " SF1 "
	cQuery += "WHERE "
	cQuery += "SF1.F1_FILIAL='"+ xFilial("SF1")+ "' AND SF1.F1_DTDIGIT >= '"+dtos((dDatabase-30))+"' AND SF1.F1_DTDIGIT <= '"+dtos(dDatabase)+"' AND "
	cQuery += "SF1.D_E_L_E_T_=' '"
	
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSF1, .T., .T. )
	
	lAchou := .f.
	Do While !( cAliasSF1 )->( Eof() )
		
		If ( cAliasSF1 )->F1_TIPO == "D"
			DbSelectArea( "SD1" )
			DbSetOrder(1)
			DbSeek( xFilial("SD1") + ( cAliasSF1 )->F1_DOC + ( cAliasSF1 )->F1_SERIE + ( cAliasSF1 )->F1_FORNECE + ( cAliasSF1 )->F1_LOJA )
			While !Eof() .and. SD1->D1_FILIAL == xFilial("SD1") .and. ( cAliasSF1 )->F1_DOC + ( cAliasSF1 )->F1_SERIE + ( cAliasSF1 )->F1_FORNECE + ( cAliasSF1 )->F1_LOJA == SD1->D1_DOC + SD1->D1_SERIE + SD1->D1_FORNECE + SD1->D1_LOJA
				nPos := aScan(aGrupos,{|x| x[1] == SD1->D1_GRUPO })
				If nPos == 0
					DbSelectArea("SD1")
					Dbskip()
					Loop
				EndIf
				
				DbSelectArea("SB1")
				DbSetOrder(1)
				DBSeek(xFilial("SB1")+SD1->D1_COD)
				
				If nEE == 8
					If !(SB1->B1_GRUPO $ cGrupoSZ)
						DbSelectArea("SD1")
						Dbskip()
						Loop
					endif
				endif
				DbSelectArea("SB5")
				DbSetOrder(1)
				If DbSeek( xFilial("SB5") + SD1->D1_COD )
					
					if (nEE ==1 .and. SB5->B5_ESTRAT != "1") .or.;
						(nEE ==2 .and. SB5->B5_ESTRAT != "2") .or.;
						(nEE ==3 .and. SB5->B5_ESTRAT != "3") .or.;
						(nEE ==4 .and. SB5->B5_ESTRAT != "4") .or.;
						(nEE ==5 .and. SB5->B5_ESTRAT != "5") .or.;
						(nEE ==6 .and. SB5->B5_ESTRAT != " ")
						DbSelectArea("SD1")
						Dbskip()
						Loop
					endif
				EndIf
				DbSelectArea( "SF4" )
				DbSetOrder(1)
				DbSeek( xFilial("SF4") + SD1->D1_TES )
				If SF4->F4_ESTOQUE == "S"
					DbSelectArea( "SF2" )
					DbSetOrder(1)
					DbSeek( xFilial("SF2") + SD1->D1_NFORI + SD1->D1_SERIORI , .f. )
					If SF2->F2_PREFORI # cPrefVEI
						nTotSD1 += SD1->D1_CUSTO
					EndIf
				EndIf
				DbSelectArea("SD1")
				Dbskip()
			EndDo
		EndIf
		DbSelectArea(cAliasSF1)
		( cAliasSF1 )->(Dbskip())
	EndDo
	( cAliasSF1 )->( dbCloseArea() )
	nTotSD2 -= nTotSD1
	
	CAB_RANEST(nEE)
	
	nLin++
	@ nLin++ , 00 psay STR0067 //" ===============  -Qtde-  ---------- SALDO ESTOQUE ---------  ---------- SALDO OFICINA ---------  --------- SALDO GARANTIA ---------"
	@ nLin++ , 00 psay STR0068+" "+cCusRep+"    "+STR0069+" "+cCusRep+"    "+STR0069+" "+cCusRep+"    "+STR0070+" " //V E N D A S    Produt   Preco # Preco de Venda    Preco # Preco de Venda    Preco # Preco Garantia
	@ nLin++ , 00 psay " ===============  ------  ----------------------------------  ----------------------------------  ----------------------------------"
	nLin++
	@ nLin++ , 00 psay STR0058 + Transform(aTotVdas[1,1],"@E 999,999") ;
	+ Transform(aTotVdas[1,2],"@E 999999,999.99") + Transform(((aTotVdas[1,2]/aTotVdas[10,2])*100),"@E 999.9") + Transform(aTotVdas[1,3],"@E 999999,999.99") + Transform(((aTotVdas[1,3]/aTotVdas[10,3])*100),"@E 999.9") + Transform(aTotVdas[1,4],"@E 999999,999.99") + Transform(((aTotVdas[1,4]/aTotVdas[10,4])*100),"@E 999.9") ;
	+ Transform(aTotVdas[1,5],"@E 999999,999.99") + Transform(((aTotVdas[1,5]/aTotVdas[10,5])*100),"@E 999.9") + Transform(aTotVdas[1,6],"@E 999999,999.99") + Transform(((aTotVdas[1,6]/aTotVdas[10,6])*100),"@E 999.9") + Transform(aTotVdas[1,7],"@E 999999,999.99") + Transform(((aTotVdas[1,7]/aTotVdas[10,7])*100),"@E 999.9")
	@ nLin++ , 00 psay STR0059 + Transform(aTotVdas[2,1],"@E 999,999") ;
	+ Transform(aTotVdas[2,2],"@E 999999,999.99") + Transform(((aTotVdas[2,2]/aTotVdas[10,2])*100),"@E 999.9") + Transform(aTotVdas[2,3],"@E 999999,999.99") + Transform(((aTotVdas[2,3]/aTotVdas[10,3])*100),"@E 999.9") + Transform(aTotVdas[2,4],"@E 999999,999.99") + Transform(((aTotVdas[2,4]/aTotVdas[10,4])*100),"@E 999.9") ;
	+ Transform(aTotVdas[2,5],"@E 999999,999.99") + Transform(((aTotVdas[2,5]/aTotVdas[10,5])*100),"@E 999.9") + Transform(aTotVdas[2,6],"@E 999999,999.99") + Transform(((aTotVdas[2,6]/aTotVdas[10,6])*100),"@E 999.9") + Transform(aTotVdas[2,7],"@E 999999,999.99") + Transform(((aTotVdas[2,7]/aTotVdas[10,7])*100),"@E 999.9")
	@ nLin++ , 00 psay STR0060 + Transform(aTotVdas[3,1],"@E 999,999") ;
	+ Transform(aTotVdas[3,2],"@E 999999,999.99") + Transform(((aTotVdas[3,2]/aTotVdas[10,2])*100),"@E 999.9") + Transform(aTotVdas[3,3],"@E 999999,999.99") + Transform(((aTotVdas[3,3]/aTotVdas[10,3])*100),"@E 999.9") + Transform(aTotVdas[3,4],"@E 999999,999.99") + Transform(((aTotVdas[3,4]/aTotVdas[10,4])*100),"@E 999.9") ;
	+ Transform(aTotVdas[3,5],"@E 999999,999.99") + Transform(((aTotVdas[3,5]/aTotVdas[10,5])*100),"@E 999.9") + Transform(aTotVdas[3,6],"@E 999999,999.99") + Transform(((aTotVdas[3,6]/aTotVdas[10,6])*100),"@E 999.9") + Transform(aTotVdas[3,7],"@E 999999,999.99") + Transform(((aTotVdas[3,7]/aTotVdas[10,7])*100),"@E 999.9")
	@ nLin++ , 00 psay STR0061 + Transform(aTotVdas[4,1],"@E 999,999") ;
	+ Transform(aTotVdas[4,2],"@E 999999,999.99") + Transform(((aTotVdas[4,2]/aTotVdas[10,2])*100),"@E 999.9") + Transform(aTotVdas[4,3],"@E 999999,999.99") + Transform(((aTotVdas[4,3]/aTotVdas[10,3])*100),"@E 999.9") + Transform(aTotVdas[4,4],"@E 999999,999.99") + Transform(((aTotVdas[4,4]/aTotVdas[10,4])*100),"@E 999.9") ;
	+ Transform(aTotVdas[4,5],"@E 999999,999.99") + Transform(((aTotVdas[4,5]/aTotVdas[10,5])*100),"@E 999.9") + Transform(aTotVdas[4,6],"@E 999999,999.99") + Transform(((aTotVdas[4,6]/aTotVdas[10,6])*100),"@E 999.9") + Transform(aTotVdas[4,7],"@E 999999,999.99") + Transform(((aTotVdas[4,7]/aTotVdas[10,7])*100),"@E 999.9")
	@ nLin++ , 00 psay STR0062 + Transform(aTotVdas[5,1],"@E 999,999") ;
	+ Transform(aTotVdas[5,2],"@E 999999,999.99") + Transform(((aTotVdas[5,2]/aTotVdas[10,2])*100),"@E 999.9") + Transform(aTotVdas[5,3],"@E 999999,999.99") + Transform(((aTotVdas[5,3]/aTotVdas[10,3])*100),"@E 999.9") + Transform(aTotVdas[5,4],"@E 999999,999.99") + Transform(((aTotVdas[5,4]/aTotVdas[10,4])*100),"@E 999.9") ;
	+ Transform(aTotVdas[5,5],"@E 999999,999.99") + Transform(((aTotVdas[5,5]/aTotVdas[10,5])*100),"@E 999.9") + Transform(aTotVdas[5,6],"@E 999999,999.99") + Transform(((aTotVdas[5,6]/aTotVdas[10,6])*100),"@E 999.9") + Transform(aTotVdas[5,7],"@E 999999,999.99") + Transform(((aTotVdas[5,7]/aTotVdas[10,7])*100),"@E 999.9")
	@ nLin++ , 00 psay STR0063 + Transform(aTotVdas[6,1],"@E 999,999") ;
	+ Transform(aTotVdas[6,2],"@E 999999,999.99") + Transform(((aTotVdas[6,2]/aTotVdas[10,2])*100),"@E 999.9") + Transform(aTotVdas[6,3],"@E 999999,999.99") + Transform(((aTotVdas[6,3]/aTotVdas[10,3])*100),"@E 999.9") + Transform(aTotVdas[6,4],"@E 999999,999.99") + Transform(((aTotVdas[6,4]/aTotVdas[10,4])*100),"@E 999.9") ;
	+ Transform(aTotVdas[6,5],"@E 999999,999.99") + Transform(((aTotVdas[6,5]/aTotVdas[10,5])*100),"@E 999.9") + Transform(aTotVdas[6,6],"@E 999999,999.99") + Transform(((aTotVdas[6,6]/aTotVdas[10,6])*100),"@E 999.9") + Transform(aTotVdas[6,7],"@E 999999,999.99") + Transform(((aTotVdas[6,7]/aTotVdas[10,7])*100),"@E 999.9")
	@ nLin++ , 00 psay STR0064 + Transform(aTotVdas[7,1],"@E 999,999") ;
	+ Transform(aTotVdas[7,2],"@E 999999,999.99") + Transform(((aTotVdas[7,2]/aTotVdas[10,2])*100),"@E 999.9") + Transform(aTotVdas[7,3],"@E 999999,999.99") + Transform(((aTotVdas[7,3]/aTotVdas[10,3])*100),"@E 999.9") + Transform(aTotVdas[7,4],"@E 999999,999.99") + Transform(((aTotVdas[7,4]/aTotVdas[10,4])*100),"@E 999.9") ;
	+ Transform(aTotVdas[7,5],"@E 999999,999.99") + Transform(((aTotVdas[7,5]/aTotVdas[10,5])*100),"@E 999.9") + Transform(aTotVdas[7,6],"@E 999999,999.99") + Transform(((aTotVdas[7,6]/aTotVdas[10,6])*100),"@E 999.9") + Transform(aTotVdas[7,7],"@E 999999,999.99") + Transform(((aTotVdas[7,7]/aTotVdas[10,7])*100),"@E 999.9")
	@ nLin++ , 00 psay STR0065 + Transform(aTotVdas[8,1],"@E 999,999") ;
	+ Transform(aTotVdas[8,2],"@E 999999,999.99") + Transform(((aTotVdas[8,2]/aTotVdas[10,2])*100),"@E 999.9") + Transform(aTotVdas[8,3],"@E 999999,999.99") + Transform(((aTotVdas[8,3]/aTotVdas[10,3])*100),"@E 999.9") + Transform(aTotVdas[8,4],"@E 999999,999.99") + Transform(((aTotVdas[8,4]/aTotVdas[10,4])*100),"@E 999.9") ;
	+ Transform(aTotVdas[8,5],"@E 999999,999.99") + Transform(((aTotVdas[8,5]/aTotVdas[10,5])*100),"@E 999.9") + Transform(aTotVdas[8,6],"@E 999999,999.99") + Transform(((aTotVdas[8,6]/aTotVdas[10,6])*100),"@E 999.9") + Transform(aTotVdas[8,7],"@E 999999,999.99") + Transform(((aTotVdas[8,7]/aTotVdas[10,7])*100),"@E 999.9")
	@ nLin++ , 00 psay STR0066 + Transform(aTotVdas[9,1],"@E 999,999") ;
	+ Transform(aTotVdas[9,2],"@E 999999,999.99") + Transform(((aTotVdas[9,2]/aTotVdas[10,2])*100),"@E 999.9") + Transform(aTotVdas[9,3],"@E 999999,999.99") + Transform(((aTotVdas[9,3]/aTotVdas[10,3])*100),"@E 999.9") + Transform(aTotVdas[9,4],"@E 999999,999.99") + Transform(((aTotVdas[9,4]/aTotVdas[10,4])*100),"@E 999.9") ;
	+ Transform(aTotVdas[9,5],"@E 999999,999.99") + Transform(((aTotVdas[9,5]/aTotVdas[10,5])*100),"@E 999.9") + Transform(aTotVdas[9,6],"@E 999999,999.99") + Transform(((aTotVdas[9,6]/aTotVdas[10,6])*100),"@E 999.9") + Transform(aTotVdas[9,7],"@E 999999,999.99") + Transform(((aTotVdas[9,7]/aTotVdas[10,7])*100),"@E 999.9")
	nLin++
	@ nLin++ , 00 psay "*** "+STR0071+" ***" + Transform(aTotVdas[10,1],"@E 999,999") ; //TOTAL
	+ Transform(aTotVdas[10,2],"@E 999999,999.99") + " 100%" + Transform(aTotVdas[10,3],"@E 9999999,999.99") + " 100%" + Transform(aTotVdas[10,4],"@E 999999,999.99") + " 100%" ;
	+ Transform(aTotVdas[10,5],"@E 999999,999.99") + " 100%" + Transform(aTotVdas[10,6],"@E 9999999,999.99") + " 100%" + Transform(aTotVdas[10,7],"@E 999999,999.99") + " 100%"
	nLin++
	@ nLin++ , 00 psay STR0072+Transform(dDtVenda,"@D")+"  "+STR0073+Transform(dDtCompra,"@D")+" "+STR0074 //"Data da Ultima Venda: # Data da Ultima Compra: # "OBS.: No SALDO ESTOQUE nao constam SALDO OFICINA nem SALDO GARANTIA"
	nLin++
	nTotSB2 := aTotVdas[10,2] + aTotVdas[10,4] + aTotVdas[10,6]
	@ nLin++ , 00 psay Repl("-",132)
	nLin++
	@ nLin++ , 10 psay STR0032+"("+Transform(dDatabase-30,"@D")+STR0054+Transform(dDatabase,"@D")+")"+space(16)+STR0035 //"Vendas nos Ultimos 30 dias  #  a   # Estoque Total"
	@ nLin++ , 10 psay STR0033 + Transform(nQtdVda,"@E 99,999,999,999")      +space(18)+STR0036 + Transform((nTotSB2/nTotSD2),"@E 999,999.99")           + STR0039//"  - Qtde de Vendas................:"  ### Disponibilidade..........:"   ###  meses"
	@ nLin++ , 10 psay STR0034 + Transform(nTotSD2,"@E 999,999,999.99")      +space(18)+STR0037 + Transform((12/(nTotSB2/nTotSD2)),"@E 999,999.99")      + STR0040//"  - Custo das Vendas..............:"  ### - Giro Anual...............:"  ### vezes"
	@ nLin++ , 77 psay STR0038 + Transform((1/(nTotSB2/nTotSD2)),"@E 999,999.99")      + STR0040//"- Giro Mensal..............:  # vezes
	nLin++
	@ nLin++ , 10 psay STR0041+cCusRep+"           "+space(30)+STR0044//"Estoque a Preco  ###  Estoque sem Oficina e Garantia
	@ nLin++ , 10 psay STR0042 + Transform(nTotSB2,"@E 999,999,999.99")      +space(18)+STR0036 + Transform((aTotVdas[10,2]/nTotSD2),"@E 999,999.99")     + STR0039//"  - Estoque Total.................: ###  Disponibilidade..........:"  ###  meses"
	@ nLin++ , 10 psay STR0043 + Transform(aTotVdas[10,2],"@E 999,999,999.99")+space(18)+STR0037 + Transform((12/(aTotVdas[10,2]/nTotSD2)),"@E 999,999.99")+ STR0040//
	@ nLin++ , 77 psay STR0038 + Transform((1/(aTotVdas[10,2]/nTotSD2)),"@E 999,999.99")      + STR0040//"- Giro Mensal..............:   ###  vezes"//
	nLin++
	@ nLin++ , 00 psay Repl("-",132)
	++nLin
	@ nLin++ , 00 psay STR0045 // ===============  ------  -------------  -------------------------------------- ULTIMA COMPRA ------------------------------------"
	@ nLin++ , 00 psay STR0046 //   V E N D A S     Qtde       Preco         0 a 30   31 a 60   61 a 90  91 a 120 121 a 180 181 a 240 241 a 365 366 a 730  + de 730"
	@ nLin++ , 00 psay STR0047+cCusRep+"    "+STR0076//Qtd.%Cust Qtd.%Cust Qtd.%Cust Qtd.%Cust Qtd.%Cust Qtd.%Cust Qtd.%Cust Qtd.%Cust Qtd.%Cust"
	@ nLin++ , 00 psay " ===============  ------  -------------  ---(A)--- ---(B)--- ---(C)--- ---(D)--- ---(E)--- ---(F)--- ---(G)--- ---(H)--- ---(I)---"
	@ nLin++ , 00 psay STR0058 + Transform(aTotVdas[1,1],"@E 999,999") ;
	+Transform(aTotVdas[1,2],"@E 99999999,999.99")+" "+Transform(aQtdCpra[1,1],"@E 99999")+Transform(((aCusCpra[1,1]/aTotVdas[1,2])*100),"@E 999.9")+Transform(aQtdCpra[1,2],"@E 99999")+Transform(((aCusCpra[1,2]/aTotVdas[1,2])*100),"@E 999.9")+Transform(aQtdCpra[1,3],"@E 99999")+Transform(((aCusCpra[1,3]/aTotVdas[1,2])*100),"@E 999.9")+Transform(aQtdCpra[1,4],"@E 99999")+Transform(((aCusCpra[1,4]/aTotVdas[1,2])*100),"@E 999.9")+Transform(aQtdCpra[1,5],"@E 99999");
	+Transform(((aCusCpra[1,5]/aTotVdas[1,2])*100),"@E 999.9")+Transform(aQtdCpra[1,6],"@E 99999")+Transform(((aCusCpra[1,6]/aTotVdas[1,2])*100),"@E 999.9")+Transform(aQtdCpra[1,7],"@E 99999")+Transform(((aCusCpra[1,7]/aTotVdas[1,2])*100),"@E 999.9")+Transform(aQtdCpra[1,8],"@E 99999")+Transform(((aCusCpra[1,8]/aTotVdas[1,2])*100),"@E 999.9")+Transform(aQtdCpra[1,9],"@E 99999")+Transform(((aCusCpra[1,9]/aTotVdas[1,2])*100),"@E 999.9")
	@ nLin++ , 00 psay STR0059 + Transform(aTotVdas[2,1],"@E 999,999") ;
	+Transform(aTotVdas[2,2],"@E 99999999,999.99")+" "+Transform(aQtdCpra[2,1],"@E 99999")+Transform(((aCusCpra[2,1]/aTotVdas[2,2])*100),"@E 999.9")+Transform(aQtdCpra[2,2],"@E 99999")+Transform(((aCusCpra[2,2]/aTotVdas[2,2])*100),"@E 999.9")+Transform(aQtdCpra[2,3],"@E 99999")+Transform(((aCusCpra[2,3]/aTotVdas[2,2])*100),"@E 999.9")+Transform(aQtdCpra[2,4],"@E 99999")+Transform(((aCusCpra[2,4]/aTotVdas[2,2])*100),"@E 999.9")+Transform(aQtdCpra[2,5],"@E 99999");
	+Transform(((aCusCpra[2,5]/aTotVdas[2,2])*100),"@E 999.9")+Transform(aQtdCpra[2,6],"@E 99999")+Transform(((aCusCpra[2,6]/aTotVdas[2,2])*100),"@E 999.9")+Transform(aQtdCpra[2,7],"@E 99999")+Transform(((aCusCpra[2,7]/aTotVdas[2,2])*100),"@E 999.9")+Transform(aQtdCpra[2,8],"@E 99999")+Transform(((aCusCpra[2,8]/aTotVdas[2,2])*100),"@E 999.9")+Transform(aQtdCpra[2,9],"@E 99999")+Transform(((aCusCpra[2,9]/aTotVdas[2,2])*100),"@E 999.9")
	@ nLin++ , 00 psay STR0060 + Transform(aTotVdas[3,1],"@E 999,999") ;
	+Transform(aTotVdas[3,2],"@E 99999999,999.99")+" "+Transform(aQtdCpra[3,1],"@E 99999")+Transform(((aCusCpra[3,1]/aTotVdas[3,2])*100),"@E 999.9")+Transform(aQtdCpra[3,2],"@E 99999")+Transform(((aCusCpra[3,2]/aTotVdas[3,2])*100),"@E 999.9")+Transform(aQtdCpra[3,3],"@E 99999")+Transform(((aCusCpra[3,3]/aTotVdas[3,2])*100),"@E 999.9")+Transform(aQtdCpra[3,4],"@E 99999")+Transform(((aCusCpra[3,4]/aTotVdas[3,2])*100),"@E 999.9")+Transform(aQtdCpra[3,5],"@E 99999");
	+Transform(((aCusCpra[3,5]/aTotVdas[3,2])*100),"@E 999.9")+Transform(aQtdCpra[3,6],"@E 99999")+Transform(((aCusCpra[3,6]/aTotVdas[3,2])*100),"@E 999.9")+Transform(aQtdCpra[3,7],"@E 99999")+Transform(((aCusCpra[3,7]/aTotVdas[3,2])*100),"@E 999.9")+Transform(aQtdCpra[3,8],"@E 99999")+Transform(((aCusCpra[3,8]/aTotVdas[3,2])*100),"@E 999.9")+Transform(aQtdCpra[3,9],"@E 99999")+Transform(((aCusCpra[3,9]/aTotVdas[3,2])*100),"@E 999.9")
	@ nLin++ , 00 psay STR0061 + Transform(aTotVdas[4,1],"@E 999,999") ;
	+Transform(aTotVdas[4,2],"@E 99999999,999.99")+" "+Transform(aQtdCpra[4,1],"@E 99999")+Transform(((aCusCpra[4,1]/aTotVdas[4,2])*100),"@E 999.9")+Transform(aQtdCpra[4,2],"@E 99999")+Transform(((aCusCpra[4,2]/aTotVdas[4,2])*100),"@E 999.9")+Transform(aQtdCpra[4,3],"@E 99999")+Transform(((aCusCpra[4,3]/aTotVdas[4,2])*100),"@E 999.9")+Transform(aQtdCpra[4,4],"@E 99999")+Transform(((aCusCpra[4,4]/aTotVdas[4,2])*100),"@E 999.9")+Transform(aQtdCpra[4,5],"@E 99999");
	+Transform(((aCusCpra[4,5]/aTotVdas[4,2])*100),"@E 999.9")+Transform(aQtdCpra[4,6],"@E 99999")+Transform(((aCusCpra[4,6]/aTotVdas[4,2])*100),"@E 999.9")+Transform(aQtdCpra[4,7],"@E 99999")+Transform(((aCusCpra[4,7]/aTotVdas[4,2])*100),"@E 999.9")+Transform(aQtdCpra[4,8],"@E 99999")+Transform(((aCusCpra[4,8]/aTotVdas[4,2])*100),"@E 999.9")+Transform(aQtdCpra[4,9],"@E 99999")+Transform(((aCusCpra[4,9]/aTotVdas[4,2])*100),"@E 999.9")
	@ nLin++ , 00 psay STR0062 + Transform(aTotVdas[5,1],"@E 999,999") ;
	+Transform(aTotVdas[5,2],"@E 99999999,999.99")+" "+Transform(aQtdCpra[5,1],"@E 99999")+Transform(((aCusCpra[5,1]/aTotVdas[5,2])*100),"@E 999.9")+Transform(aQtdCpra[5,2],"@E 99999")+Transform(((aCusCpra[5,2]/aTotVdas[5,2])*100),"@E 999.9")+Transform(aQtdCpra[5,3],"@E 99999")+Transform(((aCusCpra[5,3]/aTotVdas[5,2])*100),"@E 999.9")+Transform(aQtdCpra[5,4],"@E 99999")+Transform(((aCusCpra[5,4]/aTotVdas[5,2])*100),"@E 999.9")+Transform(aQtdCpra[5,5],"@E 99999");
	+Transform(((aCusCpra[5,5]/aTotVdas[5,2])*100),"@E 999.9")+Transform(aQtdCpra[5,6],"@E 99999")+Transform(((aCusCpra[5,6]/aTotVdas[5,2])*100),"@E 999.9")+Transform(aQtdCpra[5,7],"@E 99999")+Transform(((aCusCpra[5,7]/aTotVdas[5,2])*100),"@E 999.9")+Transform(aQtdCpra[5,8],"@E 99999")+Transform(((aCusCpra[5,8]/aTotVdas[5,2])*100),"@E 999.9")+Transform(aQtdCpra[5,9],"@E 99999")+Transform(((aCusCpra[5,9]/aTotVdas[5,2])*100),"@E 999.9")
	@ nLin++ , 00 psay STR0063 + Transform(aTotVdas[6,1],"@E 999,999") ;
	+Transform(aTotVdas[6,2],"@E 99999999,999.99")+" "+Transform(aQtdCpra[6,1],"@E 99999")+Transform(((aCusCpra[6,1]/aTotVdas[6,2])*100),"@E 999.9")+Transform(aQtdCpra[6,2],"@E 99999")+Transform(((aCusCpra[6,2]/aTotVdas[6,2])*100),"@E 999.9")+Transform(aQtdCpra[6,3],"@E 99999")+Transform(((aCusCpra[6,3]/aTotVdas[6,2])*100),"@E 999.9")+Transform(aQtdCpra[6,4],"@E 99999")+Transform(((aCusCpra[6,4]/aTotVdas[6,2])*100),"@E 999.9")+Transform(aQtdCpra[6,5],"@E 99999");
	+Transform(((aCusCpra[6,5]/aTotVdas[6,2])*100),"@E 999.9")+Transform(aQtdCpra[6,6],"@E 99999")+Transform(((aCusCpra[6,6]/aTotVdas[6,2])*100),"@E 999.9")+Transform(aQtdCpra[6,7],"@E 99999")+Transform(((aCusCpra[6,7]/aTotVdas[6,2])*100),"@E 999.9")+Transform(aQtdCpra[6,8],"@E 99999")+Transform(((aCusCpra[6,8]/aTotVdas[6,2])*100),"@E 999.9")+Transform(aQtdCpra[6,9],"@E 99999")+Transform(((aCusCpra[6,9]/aTotVdas[6,2])*100),"@E 999.9")
	@ nLin++ , 00 psay STR0064 + Transform(aTotVdas[7,1],"@E 999,999") ;
	+Transform(aTotVdas[7,2],"@E 99999999,999.99")+" "+Transform(aQtdCpra[7,1],"@E 99999")+Transform(((aCusCpra[7,1]/aTotVdas[7,2])*100),"@E 999.9")+Transform(aQtdCpra[7,2],"@E 99999")+Transform(((aCusCpra[7,2]/aTotVdas[7,2])*100),"@E 999.9")+Transform(aQtdCpra[7,3],"@E 99999")+Transform(((aCusCpra[7,3]/aTotVdas[7,2])*100),"@E 999.9")+Transform(aQtdCpra[7,4],"@E 99999")+Transform(((aCusCpra[7,4]/aTotVdas[7,2])*100),"@E 999.9")+Transform(aQtdCpra[7,5],"@E 99999");
	+Transform(((aCusCpra[7,5]/aTotVdas[7,2])*100),"@E 999.9")+Transform(aQtdCpra[7,6],"@E 99999")+Transform(((aCusCpra[7,6]/aTotVdas[7,2])*100),"@E 999.9")+Transform(aQtdCpra[7,7],"@E 99999")+Transform(((aCusCpra[7,7]/aTotVdas[7,2])*100),"@E 999.9")+Transform(aQtdCpra[7,8],"@E 99999")+Transform(((aCusCpra[7,8]/aTotVdas[7,2])*100),"@E 999.9")+Transform(aQtdCpra[7,9],"@E 99999")+Transform(((aCusCpra[7,9]/aTotVdas[7,2])*100),"@E 999.9")
	@ nLin++ , 00 psay STR0065 + Transform(aTotVdas[8,1],"@E 999,999") ;
	+Transform(aTotVdas[8,2],"@E 99999999,999.99")+" "+Transform(aQtdCpra[8,1],"@E 99999")+Transform(((aCusCpra[8,1]/aTotVdas[8,2])*100),"@E 999.9")+Transform(aQtdCpra[8,2],"@E 99999")+Transform(((aCusCpra[8,2]/aTotVdas[8,2])*100),"@E 999.9")+Transform(aQtdCpra[8,3],"@E 99999")+Transform(((aCusCpra[8,3]/aTotVdas[8,2])*100),"@E 999.9")+Transform(aQtdCpra[8,4],"@E 99999")+Transform(((aCusCpra[8,4]/aTotVdas[8,2])*100),"@E 999.9")+Transform(aQtdCpra[8,5],"@E 99999");
	+Transform(((aCusCpra[8,5]/aTotVdas[8,2])*100),"@E 999.9")+Transform(aQtdCpra[8,6],"@E 99999")+Transform(((aCusCpra[8,6]/aTotVdas[8,2])*100),"@E 999.9")+Transform(aQtdCpra[8,7],"@E 99999")+Transform(((aCusCpra[8,7]/aTotVdas[8,2])*100),"@E 999.9")+Transform(aQtdCpra[8,8],"@E 99999")+Transform(((aCusCpra[8,8]/aTotVdas[8,2])*100),"@E 999.9")+Transform(aQtdCpra[8,9],"@E 99999")+Transform(((aCusCpra[8,9]/aTotVdas[8,2])*100),"@E 999.9")
	@ nLin++ , 00 psay  STR0066 + Transform(aTotVdas[9,1],"@E 999,999") ;
	+Transform(aTotVdas[9,2],"@E 99999999,999.99")+" "+Transform(aQtdCpra[9,1],"@E 99999")+Transform(((aCusCpra[9,1]/aTotVdas[9,2])*100),"@E 999.9")+Transform(aQtdCpra[9,2],"@E 99999")+Transform(((aCusCpra[9,2]/aTotVdas[9,2])*100),"@E 999.9")+Transform(aQtdCpra[9,3],"@E 99999")+Transform(((aCusCpra[9,3]/aTotVdas[9,2])*100),"@E 999.9")+Transform(aQtdCpra[9,4],"@E 99999")+Transform(((aCusCpra[9,4]/aTotVdas[9,2])*100),"@E 999.9")+Transform(aQtdCpra[9,5],"@E 99999");
	+Transform(((aCusCpra[9,5]/aTotVdas[9,2])*100),"@E 999.9")+Transform(aQtdCpra[9,6],"@E 99999")+Transform(((aCusCpra[9,6]/aTotVdas[9,2])*100),"@E 999.9")+Transform(aQtdCpra[9,7],"@E 99999")+Transform(((aCusCpra[9,7]/aTotVdas[9,2])*100),"@E 999.9")+Transform(aQtdCpra[9,8],"@E 99999")+Transform(((aCusCpra[9,8]/aTotVdas[9,2])*100),"@E 999.9")+Transform(aQtdCpra[9,9],"@E 99999")+Transform(((aCusCpra[9,9]/aTotVdas[9,2])*100),"@E 999.9")
	aAdd(aTotCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
	aAdd(aTotCpra,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
	For ni := 1 to 9
		For nj := 1 to 9
			aTotCpra[1,nj] += aQtdCpra[ni,nj]
			aTotCpra[2,nj] += aCusCpra[ni,nj]
		Next
	Next
	nLin++
	@ nLin++ , 00 psay "*** "+STR0071+" ***"  + Transform(aTotVdas[10,1],"@E 999,999") ; //TOTAL
	+Transform(aTotVdas[10,2],"@E 99999999,999.99")+" "+Transform(aTotCpra[1,1],"@E 99999")+Transform(((aTotCpra[2,1]/aTotVdas[10,2])*100),"@E 999.9")+Transform(aTotCpra[1,2],"@E 99999")+Transform(((aTotCpra[2,2]/aTotVdas[10,2])*100),"@E 999.9")+Transform(aTotCpra[1,3],"@E 99999")+Transform(((aTotCpra[2,3]/aTotVdas[10,2])*100),"@E 999.9")+Transform(aTotCpra[1,4],"@E 99999")+Transform(((aTotCpra[2,4]/aTotVdas[10,2])*100),"@E 999.9")+Transform(aTotCpra[1,5],"@E 99999");
	+Transform(((aTotCpra[2,5]/aTotVdas[10,2])*100),"@E 999.9")+Transform(aTotCpra[1,6],"@E 99999")+Transform(((aTotCpra[2,6]/aTotVdas[10,2])*100),"@E 999.9")+Transform(aTotCpra[1,7],"@E 99999")+Transform(((aTotCpra[2,7]/aTotVdas[10,2])*100),"@E 999.9")+Transform(aTotCpra[1,8],"@E 99999")+Transform(((aTotCpra[2,8]/aTotVdas[10,2])*100),"@E 999.9")+Transform(aTotCpra[1,9],"@E 99999")+Transform(((aTotCpra[2,9]/aTotVdas[10,2])*100),"@E 999.9")
	If Len(aNumProd) > 0
		cabec2   := "*** "+STR0077+" *** "+cCabTot //vendas
		cMudou := STR0055 //INICIAL
		cMudou2:= STR0055 //INICIAL"
		If MV_PAR04 == 1
			aSort(aNumProd,1,,{|x,y| x[1]+x[2]+x[3] < y[1]+y[2]+y[3]})
		Else
			aSort(aNumProd,1,,{|x,y| x[1]+x[2]+Transform(100000000000-x[8],"@E 999999,999,999.99")+x[3] < y[1]+y[2]+Transform(100000000000-y[8],"@E 999999,999,999.99")+y[3] })
		EndIf
		For ni:=1 to Len(aNumProd)
			If cMudou # aNumProd[ni,1]
				nLin := 1
				nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
				cMudou := aNumProd[ni,1]
				cMudou2:= STR0055// INICIAL
				nLin++
				nLin++
				nPos := 0
				nPos := aScan(aTotProd,{|x| x[1] == cMudou })
				@ nLin++ , 00 psay left(" <<< " + aTotProd[nPos,2] + " >>>"+space(67),67);
				+Transform(aTotProd[nPos,3],"@E 9999,999")+space(12);
				+Transform(aTotProd[nPos,4],"@E 999999,999.99")+Transform(aTotProd[nPos,5],"@E 999999,999.99")
			EndIf
			If cMudou2 # aNumProd[ni,1]+aNumProd[ni,2]
				If nLin >= 57
					nLin := 1
					nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
				EndIf
				cMudou2 := aNumProd[ni,1]+aNumProd[ni,2]
				nLin++
				nPos := 0
				nPos := aScan(aGrpProd,{|x| x[1]+x[2] == cMudou2 })
				@ nLin++ , 00 psay left("  - "+aGrpProd[nPos,2]+" "+aGrpProd[nPos,3]+space(67),67);
				+Transform(aGrpProd[nPos,4],"@E 9999,999")+space(12);
				+Transform(aGrpProd[nPos,5],"@E 999999,999.99")+Transform(aGrpProd[nPos,6],"@E 999999,999.99")
			EndIf
			If nLin >= 60
				nLin := 1
				nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
			EndIf
			cDt1 := Transform(aNumProd[ni,10],"@D")
			cDt1 := left(cDt1,6)+right(cDt1,2)
			cDt2 := Transform(aNumProd[ni,11],"@D")
			cDt2 := left(cDt2,6)+right(cDt2,2)
			@ nLin++ , 00 psay space(6)+left(Alltrim(aNumProd[ni,2])+" "+aNumProd[ni,3]+space(28),28)+left(aNumProd[ni,4]+space(13),13)+" "+left(aNumProd[ni,5]+space(15),15)+" ";
			+aNumProd[ni,13]+" ";
			+Transform(aNumProd[ni,6],"@E 9999,999")+Transform(aNumProd[ni,7],"@E 99999,999.99");
			+Transform(aNumProd[ni,8],"@E 999999,999.99")+Transform(aNumProd[ni,9],"@E 999999,999.99")+" ";
			+cDt1+" "+cDt2+" ";
			+aNumProd[ni,12]
		Next
	EndIf
	If Len(aNumCpra) > 0
		cabec2   := "*** "+STR0078+" ***"+cCabTot //compras
		cMudou := STR0055// INICIAL
		cMudou2:= STR0055// INICIAL
		If MV_PAR04 == 1
			aSort(aNumCpra,1,,{|x,y| x[1]+x[2]+x[3] < y[1]+y[2]+y[3]})
		Else
			aSort(aNumCpra,1,,{|x,y| x[1]+x[2]+Transform(100000000000-x[8],"@E 999999,999,999.99")+x[3] < y[1]+y[2]+Transform(100000000000-y[8],"@E 999999,999,999.99")+y[3] })
		EndIf
		For ni:=1 to Len(aNumCpra)
			If cMudou # aNumCpra[ni,1]
				nLin := 1
				nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
				cMudou := aNumCpra[ni,1]
				cMudou2:= STR0055// INICIAL
				nLin++
				nLin++
				nPos := 0
				nPos := aScan(aTtCpra,{|x| x[1] == cMudou })
				nPos2:= aScan(aTp,{|x| x[1] == substr(aTtCpra[nPos,1],2,1) })
				@ nLin++ , 00 psay left(" <<< " + aTtCpra[nPos,2] + " - "+STR0079+" "+aTp[nPos2,2]+" "+STR0080+" ("+substr(aTtCpra[nPos,1],2,1)+") >>>"+space(67),67) ; //Compra: # dias
				+Transform(aTtCpra[nPos,3],"@E 9999,999")+space(12);
				+Transform(aTtCpra[nPos,4],"@E 999999,999.99")+Transform(aTtCpra[nPos,5],"@E 999999,999.99")
			EndIf
			If cMudou2 # aNumCpra[ni,1]+aNumCpra[ni,2]
				If nLin >= 57
					nLin := 1
					nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
				EndIf
				cMudou2 := aNumCpra[ni,1]+aNumCpra[ni,2]
				nLin++
				nPos := 0
				nPos := aScan(aGrpCpra,{|x| x[1]+x[2] == cMudou2 })
				@ nLin++ , 00 psay left("  - "+aGrpCpra[nPos,2]+" "+aGrpCpra[nPos,3]+space(67),67) ;
				+Transform(aGrpCpra[nPos,4],"@E 9999,999")+space(12);
				+Transform(aGrpCpra[nPos,5],"@E 999999,999.99")+Transform(aGrpCpra[nPos,6],"@E 999999,999.99")
			EndIf
			If nLin >= 60
				nLin := 1
				nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
			EndIf
			cDt1 := Transform(aNumCpra[ni,10],"@D")
			cDt1 := left(cDt1,6)+right(cDt1,2)
			cDt2 := Transform(aNumCpra[ni,11],"@D")
			cDt2 := left(cDt2,6)+right(cDt2,2)
			@ nLin++ , 00 psay space(6)+left(Alltrim(aNumCpra[ni,2])+" "+aNumCpra[ni,3]+space(28),28)+left(aNumCpra[ni,4]+space(13),13)+" "+left(aNumCpra[ni,5]+space(15),15)+" ";
			+aNumCpra[ni,13]+" ";    
			+Transform(aNumCpra[ni,6],"@E 9999,999")+Transform(aNumCpra[ni,7],"@E 99999,999.99");
			+Transform(aNumCpra[ni,8],"@E 999999,999.99")+Transform(aNumCpra[ni,9],"@E 999999,999.99")+" ";
			+cDt1+" "+cDt2+" ";
			+aNumCpra[ni,12]
		Next
	EndIf
next
Set Printer to
Set Device  to Screen
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณFS_OPR20SOMAบ Autor ณ Andre Luis Almeida บ Data ณ 16/04/02  บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Soma colunas saldos                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FS_OPR20SOMA(ni)
Local cAno := strzero(Year(dDatabase),4)
Local cMes := strzero(Month(dDatabase)-1,2)
If cMes == "00"
	cAno := strzero(Year(dDatabase)-1,4)
	cMes := "12"
EndIf
If SB2->B2_LOCAL $ cAlmxOfi
	DbSelectArea("SBM")
	DbSeek(xFilial("SBM")+SB1->B1_GRUPO)
	If SBM->BM_PROORI == "1" // Original
		aTotVdas[ni,4]+= If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),If(!Empty(SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda))))
	Else // Paralelo
		aTotVdas[ni,4]+= If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),((SB2->B2_QATU-SB2->B2_QTNP)*SB1->B1_UPRC))
	Endif
	aTotVdas[ni,5]+=((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda))
ElseIf SB2->B2_LOCAL $ cAlmxGar
	DbSelectArea("SBM")
	DbSeek(xFilial("SBM")+SB1->B1_GRUPO)
	If SBM->BM_PROORI == "1" // Original
		aTotVdas[ni,6]+= If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),If(!Empty(SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormGar))))
	Else // Paralelo
		aTotVdas[ni,6]+= If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),((SB2->B2_QATU-SB2->B2_QTNP)*SB1->B1_UPRC))
	Endif
	aTotVdas[ni,7]+=((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormGar))
ElseIf ( SB2->B2_LOCAL >= "01" .and. SB2->B2_LOCAL <= "99" )
	aTotVdas[ni,1]++
	DbSelectArea("SBM")
	DbSeek(xFilial("SBM")+SB1->B1_GRUPO)
	If SBM->BM_PROORI == "1" // Original
		aTotVdas[ni,2]+= If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),If(!Empty(SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda))))
	Else // Paralelo
		aTotVdas[ni,2]+= If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),((SB2->B2_QATU-SB2->B2_QTNP)*SB1->B1_UPRC))
	Endif
	aTotVdas[ni,3]+=((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda))
	If !Empty(MV_PAR02)
		If ni # 10
			If ( str(ni,1) $ MV_PAR02 ) .or. ( Alltrim(MV_PAR02) == "*" )
				DbSelectArea( "SBL" )
				DbSetOrder(1)
				DbSeek( xFilial("SBL") + SB1->B1_COD + cAno + cMes , .f. )
				DbSelectArea("SBM")
				DbSeek(xFilial("SBM")+SB1->B1_GRUPO)
				If SBM->BM_PROORI == "1" // Original
					aAdd(aNumProd,{ str(ni,1) , SB1->B1_GRUPO , SB1->B1_CODITE , SB1->B1_DESC , SB2->B2_LOCALIZ , (SB2->B2_QATU-SB2->B2_QTNP) , If(MV_PAR03==1,SB2->B2_CM1,If(!Empty(SB5->B5_PRV2),SB5->B5_PRV2,FG_FORMULA(cFormVda))) , If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),If(!Empty(SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)))) , ((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)) , SB1->B1_UCOM , If(cSemData==STR0057,ctod("  /  /  "),dDtUltVda) , (SBL->BL_ABCVEND+SBL->BL_ABCCUST) , SB2->B2_LOCAL })
				Else // Paralelo
					nCustoU := If(MV_PAR03==1,SB2->B2_CM1,(SB1->B1_UPRC))
					nCustoT := If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),((SB2->B2_QATU-SB2->B2_QTNP)*SB1->B1_UPRC))
					aAdd(aNumProd,{ str(ni,1) , SB1->B1_GRUPO , SB1->B1_CODITE , SB1->B1_DESC , SB2->B2_LOCALIZ , (SB2->B2_QATU-SB2->B2_QTNP) , nCustoU , nCustoT , ((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)) , SB1->B1_UCOM , If(cSemData==STR0057,ctod("  /  /  "),dDtUltVda) , (SBL->BL_ABCVEND+SBL->BL_ABCCUST) , SB2->B2_LOCAL })
				Endif
				nPos := 0
				nPos := aScan(aGrpProd,{|x| x[1]+x[2] == str(ni,1) + SB1->B1_GRUPO })
				If nPos == 0
					DbSelectArea( "SBM" )
					DbSetOrder(1)
					DbSeek( xFilial("SBM") + SB1->B1_GRUPO , .f. )
					DbSelectArea("SBM")
					DbSeek(xFilial("SBM")+SB1->B1_GRUPO)
					If SBM->BM_PROORI == "1" // Original
						aAdd(aGrpProd,{ str(ni,1) , SB1->B1_GRUPO , SBM->BM_DESC , (SB2->B2_QATU-SB2->B2_QTNP) , If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),If(!Empty(SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)))) , ((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)) })
					Else // Paralelo
						nCustoT := If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),((SB2->B2_QATU-SB2->B2_QTNP)*SB1->B1_UPRC))
						aAdd(aGrpProd,{ str(ni,1) , SB1->B1_GRUPO , SBM->BM_DESC , (SB2->B2_QATU-SB2->B2_QTNP) , nCustoT , ((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)) })
					Endif
				Else
					aGrpProd[nPos,4] += (SB2->B2_QATU-SB2->B2_QTNP)
					DbSelectArea("SBM")
					DbSeek(xFilial("SBM")+SB1->B1_GRUPO)
					If SBM->BM_PROORI == "1" // Original
						aGrpProd[nPos,5] += If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),If(!Empty(SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda))))
					Else // Paralelo
						nCustoT := If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),((SB2->B2_QATU-SB2->B2_QTNP)*SB1->B1_UPRC))
						aGrpProd[nPos,5] += nCustoT
					Endif
					aGrpProd[nPos,6] += ((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda))
				EndIf
				nPos := 0
				nPos := aScan(aTotProd,{|x| x[1] == str(ni,1) })
				If nPos == 0
					DbSelectArea("SBM")
					DbSeek(xFilial("SBM")+SB1->B1_GRUPO)
					If SBM->BM_PROORI == "1" // Original
						aAdd(aTotProd,{ str(ni,1) , ci , (SB2->B2_QATU-SB2->B2_QTNP) , If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),If(!Empty(SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)))) , ((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)) })
					Else // Paralelo
						nCustoT := If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),((SB2->B2_QATU-SB2->B2_QTNP)*SB1->B1_UPRC))
						aAdd(aTotProd,{ str(ni,1) , ci , (SB2->B2_QATU-SB2->B2_QTNP) , nCustoT , ((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)) })
					Endif
				Else
					aTotProd[nPos,3] += (SB2->B2_QATU-SB2->B2_QTNP)
					DbSelectArea("SBM")
					DbSeek(xFilial("SBM")+SB1->B1_GRUPO)
					// Manoel - 10/10/2007 - As linhas abaixo estavam duplicadas, entao resolvemos comentar
					If SBM->BM_PROORI == "1" // Original
						aTotProd[nPos,4] += If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),If(!Empty(SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda))))
					Else // Paralelo
						nCustoT := If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),((SB2->B2_QATU-SB2->B2_QTNP)*SB1->B1_UPRC))
						aTotProd[nPos,4] += nCustoT
					Endif
					aTotProd[nPos,5] += ((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda))
				EndIf
			EndIf
		EndIf
	EndIf
	If ni # 10
		nj := FS_OPR20CPRA(ni)
		If !Empty(MV_PAR05)
			cTp := aTp[nj,1]
			If ( Alltrim(MV_PAR05) == "*" ) .or. ( Alltrim(MV_PAR05) == "**" ) .or. ( at("*"+cTp,MV_PAR05) > 0 ) .or. ( at(str(ni,1)+"*",MV_PAR05) > 0 ) .or. ( at(str(ni,1)+cTp,MV_PAR05) > 0 )
				DbSelectArea( "SBL" )
				DbSetOrder(1)
				DbSeek( xFilial("SBL") + SB1->B1_COD + cAno + cMes , .f. )
				DbSelectArea("SBM")
				DbSeek(xFilial("SBM")+SB1->B1_GRUPO)
				If SBM->BM_PROORI == "1" // Original
					aAdd(aNumCpra,{ str(ni,1) + cTp , SB1->B1_GRUPO , SB1->B1_CODITE , SB1->B1_DESC , SB2->B2_LOCALIZ , (SB2->B2_QATU-SB2->B2_QTNP) , If(MV_PAR03==1,SB2->B2_CM1,If(!Empty(SB5->B5_PRV2),SB5->B5_PRV2,FG_FORMULA(cFormVda))) , If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),If(!Empty(SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)))) , ((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)) , SB1->B1_UCOM , If(cSemData==STR0057,ctod("  /  /  "),dDtUltVda) , (SBL->BL_ABCVEND+SBL->BL_ABCCUST) , SB2->B2_LOCAL })
				Else // Paralelo
					nCustoU := If(MV_PAR03==1,SB2->B2_CM1,SB1->B1_UPRC)
					nCustoT := If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),((SB2->B2_QATU-SB2->B2_QTNP)*SB1->B1_UPRC))
					aAdd(aNumCpra,{ str(ni,1) + cTp , SB1->B1_GRUPO , SB1->B1_CODITE , SB1->B1_DESC , SB2->B2_LOCALIZ , (SB2->B2_QATU-SB2->B2_QTNP) , nCustoU , nCustoT , ((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)) , SB1->B1_UCOM , If(cSemData==STR0057,ctod("  /  /  "),dDtUltVda) , (SBL->BL_ABCVEND+SBL->BL_ABCCUST) , SB2->B2_LOCAL })
				Endif
				nPos := 0
				nPos := aScan(aGrpCpra,{|x| x[1]+x[2] == str(ni,1) + cTp + SB1->B1_GRUPO })
				If nPos == 0
					DbSelectArea( "SBM" )
					DbSetOrder(1)
					DbSeek( xFilial("SBM") + SB1->B1_GRUPO , .f. )
					If SBM->BM_PROORI == "1" // Original
						aAdd(aGrpCpra,{ str(ni,1) + cTp , SB1->B1_GRUPO , SBM->BM_DESC , (SB2->B2_QATU-SB2->B2_QTNP) , If(MV_PAR03==1,SB2->B2_VATU1,If(!Empty(SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)))) , ((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)) })
					Else // Paralelo
						nCustoT := If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),((SB2->B2_QATU-SB2->B2_QTNP)*SB1->B1_UPRC))
						aAdd(aGrpCpra,{ str(ni,1) + cTp , SB1->B1_GRUPO , SBM->BM_DESC , (SB2->B2_QATU-SB2->B2_QTNP) , nCustoT , ((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)) })
					Endif
				Else
					aGrpCpra[nPos,4] += (SB2->B2_QATU-SB2->B2_QTNP)
					DbSelectArea( "SBM" )
					DbSetOrder(1)
					DbSeek( xFilial("SBM")+SB1->B1_GRUPO)
					If SBM->BM_PROORI == "1" // Original
						aGrpCpra[nPos,5] += If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),If(!Empty(SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda))))
					Else // Paralelo
						nCustoT := If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),((SB2->B2_QATU-SB2->B2_QTNP)*SB1->B1_UPRC))
						aGrpCpra[nPos,5] += nCustoT
					Endif
					aGrpCpra[nPos,6] += ((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda))
				EndIf
				nPos := 0
				nPos := aScan(aTtCpra,{|x| x[1] == str(ni,1) + cTp })
				If nPos == 0
					DbSelectArea( "SBM" )
					DbSetOrder(1)
					DbSeek( xFilial("SBM")+SB1->B1_GRUPO)
					If SBM->BM_PROORI == "1" // Original
						aAdd(aTtCpra,{ str(ni,1) + cTp , ci , (SB2->B2_QATU-SB2->B2_QTNP) , If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),If(!Empty(SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)))) , ((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)) })
					Else // Paralelo
						nCustoT := If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),((SB2->B2_QATU-SB2->B2_QTNP)*SB1->B1_UPRC))
						aAdd(aTtCpra,{ str(ni,1) + cTp , ci , (SB2->B2_QATU-SB2->B2_QTNP) , nCustoT , ((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda)) })
					Endif
				Else
					aTtCpra[nPos,3] += (SB2->B2_QATU-SB2->B2_QTNP)
					DbSelectArea( "SBM" )
					DbSetOrder(1)
					DbSeek( xFilial("SBM")+SB1->B1_GRUPO)
					If SBM->BM_PROORI == "1" // Original
						aTtCpra[nPos,4] += If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),If(!Empty(SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda))))
					Else // Paralelo
						nCustoT := If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),((SB2->B2_QATU-SB2->B2_QTNP)*SB1->B1_UPRC))
						aTtCpra[nPos,4] += nCustoT
					Endif
					aTtCpra[nPos,5] += ((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda))
				EndIf
			EndIf
		EndIf
	EndIf
EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณFS_OPR20CPRAบ Autor ณ Andre Luis Almeida บ Data ณ 16/04/02  บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Soma colunas compras                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FS_OPR20CPRA(ni)
dDtUltCpa:= SB1->B1_UCOM
Do Case
	Case ( ( dDataBase - dDtUltCpa ) <  31 )
		nj := 1
	Case ( ( dDataBase - dDtUltCpa ) <  61 )
		nj := 2
	Case ( ( dDataBase - dDtUltCpa ) <  91 )
		nj := 3
	Case ( ( dDataBase - dDtUltCpa ) < 121 )
		nj := 4
	Case ( ( dDataBase - dDtUltCpa ) < 181 )
		nj := 5
	Case ( ( dDataBase - dDtUltCpa ) < 241 )
		nj := 6
	Case ( ( dDataBase - dDtUltCpa ) < 366 )
		nj := 7
	Case ( ( dDataBase - dDtUltCpa ) < 731 )
		nj := 8
	Otherwise
		nj := 9
Endcase
aQtdCpra[ni,nj]++
DbSelectArea( "SBM" )
DbSetOrder(1)
DbSeek( xFilial("SBM")+SB1->B1_GRUPO)
If SBM->BM_PROORI == "1" // Original
	aCusCpra[ni,nj]+= If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),If(!Empty(SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*SB5->B5_PRV2),((SB2->B2_QATU-SB2->B2_QTNP)*FG_FORMULA(cFormVda))))
Else // Paralelo
	nCustoT := If(MV_PAR03==1,(SB2->B2_VATU1/SB2->B2_QATU)*(SB2->B2_QATU-SB2->B2_QTNP),((SB2->B2_QATU-SB2->B2_QTNP)*SB1->B1_UPRC))
	aCusCpra[ni,nj]+= nCustoT
Endif
Return(nj)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณ CAB_RANEST บ Autor ณ Andre Luis Almeida บ Data ณ 16/04/02  บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Impressao Cabecalhos                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CAB_RANEST(nEE)
Do Case
	Case nEE == 1
		@ nLin++ , 00 psay "===================================================================================================================================="
		@ nLin++ , 00 psay STR0081//"                                  E S T O Q U E   E S T R A T E G I C O   -   D S M   N O R M A L"
		@ nLin++ , 00 psay "===================================================================================================================================="
	Case nEE == 2
		nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
		@ nLin++ , 00 psay "===================================================================================================================================="
		@ nLin++ , 00 psay STR0082//"                                    E S T O Q U E   E S T R A T E G I C O   -   D S M   C A N A"
		@ nLin++ , 00 psay "===================================================================================================================================="
	Case nEE == 3
		nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
		@ nLin++ , 00 psay "===================================================================================================================================="
		@ nLin++ , 00 psay STR0083//"                                 E S T O Q U E   E S T R A T E G I C O   -   D S M   M O T O R E S"
		@ nLin++ , 00 psay "===================================================================================================================================="
	Case nEE == 4
		nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
		@ nLin++ , 00 psay "===================================================================================================================================="
		@ nLin++ , 00 psay STR0084//"                         E S T O Q U E   E S T R A T E G I C O   -   P R O J E T O S   E S P E C I A I S"
		@ nLin++ , 00 psay "===================================================================================================================================="
	Case nEE == 5
		nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
		@ nLin++ , 00 psay "===================================================================================================================================="
		@ nLin++ , 00 psay STR0085//"                         E S T O Q U E   E S T R A T E G I C O   -   R E T O R N O                      "
		@ nLin++ , 00 psay "===================================================================================================================================="
	Case nEE ==6
		nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
		@ nLin++ , 00 psay "===================================================================================================================================="
		@ nLin++ , 00 psay STR0086//"                          E S T O Q U E   E S T R A T E G I C O   -   S E M   C L A S S I F I C A C A O"
		@ nLin++ , 00 psay "===================================================================================================================================="
	Case nEE ==8
		nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
		@ nLin++ , 00 psay "===================================================================================================================================="
		@ nLin++ , 00 psay STR0087//"                          E S T O Q U E   E S T R A T E G I C O   -   S U P E R    Z E R A D O         "
		@ nLin++ , 00 psay "===================================================================================================================================="
EndCase
Return
