/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 24     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼
#Include "OFIOR250.CH"
#Include "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ OFIOR250 ³ Autor ³ Thiago                ³ Data ³ 10/02/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Posicao das Vendas & Resultados                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIOR250

	if cPaisLoc == "BRA"
		OOR250018_RelatorioBrasil()
	else
		ofir250()
	endif
return nil


static function OOR250018_RelatorioBrasil()
Local cDesc1	 := STR0001
Local cDesc2	 := cDesc3 := ""
Local cAlias	 := "VV0"

if Existblock("M_OFR250")
	ExecBlock("M_OFR250",.f.,.f.,{})
	Return(.t.)
Endif

Private nLin 	 := 1
Private aReturn := { STR0118, 1,STR0119, 2, 2, 1, "",1 }
Private cTamanho:= "G"           // P/M/G
Private Limite  := 220           // 80/132/220
Private aOrdem  := {}           // Ordem do Relatorio
Private cTitulo := STR0001
Private cNomProg:= "OFIOR250"
Private cNomeRel:= "OFIOR250"
Private nLastKey:= 0
Private cPerg   := "OFR250"
Private nPis    := ( GetMv("MV_TXPIS")   / 100 )
Private nCof    := ( GetMv("MV_TXCOFIN") / 100 )
Private aTXTCli := {} //vetor de Clientes para gerar TXT
Private aTXTCliA:= {} //vetor de Clientes para gerar TXT Mes a Mes
Private aTXTCliNG:= {} //vetor de Clientes para gerar TXT Mes a Mes (Nao garantia)
Private aTXTIte := {} //vetor de Itens para gerar TXT
Private aTXTIteA:= {} //vetor de Itens para gerar TXT Mes a Mes
Private aTXTIteNG:= {} //vetor de Itens para gerar TXT Mes a Mes (Nao garantia)
Private aTXTMes := {} //vetor de Meses para gerar TXT
Private nTXTVda := nTXTLuc := nTXTAux1 := nTXTAux2 := 0
Private nTXTVdaNG:= nTXTLucNG:= 0
//Private axxx := {}
Private nHnd := ""

//Private nTResSTDv := 0
cNomeRel := SetPrint(cAlias,cNomeRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,.t.,cTamanho)
If nLastKey == 27
	Return
EndIf
PERGUNTE("OFR250",.f.)
If ExistBlock("GERAARQTXT")
	ExecBlock("GERAARQTXT",.f.,.f.)
EndIf

SetDefault(aReturn,cAlias)
If nLastKey == 27
	Return
EndIf
RptStatus( { |lEnd| U_ImpORM_250(@lEnd,cNomeRel,cAlias) } , cTitulo )
If aReturn[5] == 1
	OurSpool( cNomeRel )
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ImpORM_250ºAutor  ³Andre Luis Almeida  º Data ³  03/09/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Posicao das Vendas & Resultados                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ImpORM_250(lEnd,wNRel,cAlias)

local nj := 0
local ni := 0
local nMes := 0
Private cCliente := cGrupo := cMes := ""
Private nVfattot := nVtotimp := nVicmven := nVpisven := nVcofven := nVtotcus := nVjurest := nVlucbru := nVtotdes := nVcomvde := nVluclq1 := nVdesfix := nVdesadm := nVluclq2 := nVdescon := 0
Private nPvalvda := nPtotimp := nPvalicm := nPvalpis := nPvalcof := nPcustot := nPjurest := nPlucbru := nPdesvar := nPcomven := nPlucliq := nPdesfix := nPdesdep := nPresfin := nPdescon := 0
Private nSvalser := nStotimp := nSvaliss := nSvalpis := nSvalcof := nScusser := nSlucbru := nSdesvar := nScomven := nSlucliq := nSdesfix := nSdesadm := nSresfin := nSdescon := 0
Private aNumVei   := {} //vetor de Veiculos
Private aTotVei   := {} //vetor Total de Veiculos por tipo de tempo
Private aGrpVei   := {} //vetor Grupos de Veiculos
Private aNumPec   := {} //vetor de Pecas
Private aTotPec   := {} //vetor do Total de Pecas
Private aGrpPec   := {} //vetor de Grupos de Pecas
Private aGrpPBO   := {} //vetor de Grupos de Pecas (Balcao ou Oficina)
Private aDpto     := {} //vetor de Departamentos no Balcao/Oficina
Private aNumSrv   := {} //vetor de Servicos
Private aTotSrv   := {} //vetor do Total de Servicos
Private aGrpSrv   := {} //vetor de Grupos de Servicos
Private aTotCon   := {} //vetor de Totais de Condicoes de Pagamento
Private aTotOOpe  := {} //vetor de Outras Vendas
Private aOOpeSrv  := {} //vetor de Outras Vendas - Servicos
Private aOOpeOut  := {} //vetor de Outras Vendas - Outros
Private aOOpeOutV := {} //vetor de Outras Vendas Veiculos Novos
Private aOOpeOutU := {} //vetor de Outras Vendas Veiculos Usados
Private aGrpEnt   := {} //vetor de Grupos de Entradas
Private aTotEnt   := {} //vetor de Total de Entrada
Private aNumEnt   := {} //vetor de Entradas
Private aEntrad   := {} //vetor de Total de Entrada por Tipo de Pagamento
Private aDesAce   := {} //vetor de Despesas Acessorias
Private aTotal    := {} //vetor de Totais
Private aTotAtiMob:= {} //vetor de Total de Ativo Imobilizado
Private aNumAtiMob:= {} //vetor de Ativo Imobilizado
Private aGrpPag   := {} //vetor de Grupos de Condicoes de Pagamento
Private aTotPag   := {} //vetor de Condicoes de Pagamento por Vendedor
Private aPecSrvOfi:= {} //vetor de Pecas Balcao, Pecas Oficina e Servicos Oficina
Private aConPagNF := {} //vetor de NF's de Condicoes de Pagamento
Private aNumDev   := {} //vetor de Devolucoes
Private aTotDev   := {} //vetor do Total de Devolucoes
Private aCCVend   := {} //vetor de Vendas por Centro de Custo / Vendedor
Private aTotCCV   := {} //vetor de Totais de Vendas por Centro de Custo

Private aIcmRet   := {} //vetor de Icms Retido
Private nTResSTDv := 0

Private nLin := 1
Private nCont := nPos := ni := nMes := nAno := 0
Private cTitulo := cabec1 := cabec2 := cCabTot := cCabVei := cCabPec := cCabSrv := cMudou := cMudou2 := cTipo := cPulou := ""
Private nomeprog:="OFIOR250"
Private tamanho := "G"
Private nCaracter := 15
Private cbTxt   := Space(10)
Private cbCont  := 0
Private cString := "VEC"
Private Li      := 220
Private m_Pag   := 1
Private lAbortPrint := .f.

aAdd(aOOpeOutV,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0, 0, 0})   // Outras Operacoes Veiculos Novos
aAdd(aOOpeOutU,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0, 0, 0})   // Outras Operacoes Veiculos Usados

If FunName() == "OFIOR250"
	Set Printer to &cNomeRel
	Set Printer On
	Set Device  to Printer
Endif

cTitulo:= Iif(!Empty(MV_PAR01),STR0001 + Iif(MV_PAR08 == 1, STR0054 , STR0055 ) + Transform(MV_PAR01,"@D") + STR0056 + Transform(MV_PAR02,"@D"),STR0001)
cCabTot := STR0002
cCabTot := U_FS_ImpRM_250(cCabTot)
cCabVei := STR0003
cCabVei := U_FS_ImpRM_250(cCabVei)
cCabPec := STR0004
cCabPec := U_FS_ImpRM_250(cCabPec)
cCabSrv := STR0005
cCabSrv := U_FS_ImpRM_250(cCabSrv)

If FunName() == "OFIOR250"
	SetRegua(20)
	nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
	If ( strzero(month(MV_PAR01),2)+strzero(year(MV_PAR01),4) # strzero(month(MV_PAR02),2)+strzero(year(MV_PAR02),4) )
		nMes := month(MV_PAR01)-1
		nAno := year(MV_PAR01)
		For nj := 1 to 12
			nMes++
			If nMes > 12
				nMes := 1
				nAno++
			EndIf
			aAdd(aTXTMes,{ strzero(nMes,2)+strzero(nAno,4) , strzero(nAno,4)+strzero(nMes,2) }) // Venda
			aAdd(aTXTMes,{ " " , " " }) // Lucro Bruto
		Next
	EndIf
Else
	nLin := 2
	fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
	fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
	fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
	fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cEmpr+cFil+"_"+strzero(nMes,2)+strzero(nAno,4)+".##r"+CHR(13)+CHR(10))
EndIf

// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
aAdd(aTotal,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })

// ATIVO IMOBILIZADO
aAdd(aTotAtiMob,{ "T" , "T" , 0 , 0 , 0 , 0 , 0 , 0 })
aAdd(aTotAtiMob,{ "V" , STR0049 , 0 , 0 , 0 , 0 , 0 , 0 })
aAdd(aTotAtiMob,{ "O" , STR0050 , 0 , 0 , 0 , 0 , 0 , 0 })

// CONDICOES DE PAGAMENTO / CENTRO DE CUSTO POR VENDEDOR
aAdd(aTotCon,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0 , 0 , 0 })

// ENTRADAS (PAGAMENTO)
aAdd(aTotEnt,{ 0 })
aAdd(aGrpEnt,{ "V" , STR0029 , 0 })   // Veiculos
aAdd(aGrpEnt,{ "O" , STR0030 , 0 })   // Oficina
aAdd(aGrpEnt,{ "B" , STR0031 , 0 })   // Balcao

// DESPESAS ACESSORIAS
aAdd(aDesAce,{ "T" , 0 , 0 , 0 })
aAdd(aDesAce,{ STR0051 , 0 , 0 , 0 })
aAdd(aDesAce,{ STR0052 , 0 , 0 , 0 })
aAdd(aDesAce,{ STR0053 , 0 , 0 , 0 })

// ICMS RETIDO
aAdd(aIcmRet,{ "T" , 0 , 0 , 0 })
aAdd(aIcmRet,{ STR0123 , 0 , 0 , 0 })
aAdd(aIcmRet,{ STR0124 , 0 , 0 , 0 })
aAdd(aIcmRet,{ STR0125 , 0 , 0 , 0 })

///////////////////////////////////
//    V  E  I  C  U  L  O  S     //
///////////////////////////////////
FS_M_OR25B()

///////////////////////////////////
//         P  E  C  A  S         //
///////////////////////////////////
FS_M_OR25C()

///////////////////////////////////
//    S  E  R  V  I  C  O  S     //
///////////////////////////////////
FS_M_OR25D()

///////////////////////////////////

FS_M_OR250()   // Funcao FS_M_OR250: Continua carregando os vetores e variaveis para impressao...

// Manoel - 27/11/2008 - usando o campos Cst/Dsp Fix para mostrar Result ST - nao subtrai do RESFIN e sim do LUCBRU
//nLucBru := aOOpeSrv[1,01]-aOOpeSrv[1,02]-aOOpeSrv[1,07]
//nLucLiq := nLucBru-aOOpeSrv[1,08]-aOOpeSrv[1,10]-aOOpeSrv[1,11]
//nResFin := nLucLiq-aOOpeSrv[1,13]-aOOpeSrv[1,14]
nLucBru := aOOpeSrv[1,01]-aOOpeSrv[1,02]-aOOpeSrv[1,07]+aOOpeSrv[1,13]+aOOpeSrv[1,14]
nLucLiq := nLucBru-aOOpeSrv[1,08]-aOOpeSrv[1,10]-aOOpeSrv[1,11]
nResFin := nLucLiq

fClose(nHnd)

aTotal[1,1]  += aTotOOpe[1,1]
aTotal[1,2]  += aTotOOpe[1,2]
aTotal[1,3]  += aTotOOpe[1,3]
aTotal[1,4]  += aTotOOpe[1,4]
aTotal[1,5]  += aTotOOpe[1,5]
aTotal[1,6]  += aTotOOpe[1,6]
aTotal[1,7]  += aTotOOpe[1,7]
aTotal[1,8]  += aTotOOpe[1,8]
aTotal[1,9]  += aTotOOpe[1,9]
aTotal[1,9]  += nLucBru
aTotal[1,10] += aTotOOpe[1,10]
aTotal[1,11] += aTotOOpe[1,11]
aTotal[1,12] += aTotOOpe[1,12]
aTotal[1,12] += nLucLiq
aTotal[1,13] += aTotOOpe[1,13]
aTotal[1,14] += aTotOOpe[1,14]
aTotal[1,15] += aTotOOpe[1,15]
aTotal[1,15] += nResFin
// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
aTotal[1,16] += aTotOOpe[1,16]
aTotal[1,17] += aTotOOpe[1,17]
// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
aTotal[1,18] += aTotOOpe[1,18]

aTotCon[1,1] += aTotOOpe[1,1]
aTotCon[1,2] += aTotOOpe[1,2]
aTotCon[1,3] += aTotOOpe[1,3]
aTotCon[1,4] += aTotOOpe[1,4]
aTotCon[1,5] += aTotOOpe[1,5]
aTotCon[1,6] += aTotOOpe[1,6]
aTotCon[1,7] += aTotOOpe[1,7]
aTotCon[1,8] += aTotOOpe[1,8]
aTotCon[1,9] += aTotOOpe[1,9]
aTotCon[1,10]+= aTotOOpe[1,10]
aTotCon[1,11]+= aTotOOpe[1,11]
aTotCon[1,12]+= aTotOOpe[1,12]
aTotCon[1,13]+= aTotOOpe[1,13]
aTotCon[1,14]+= aTotOOpe[1,14]
aTotCon[1,15]+= aTotOOpe[1,15]
// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
aTotCon[1,16]+= aTotOOpe[1,16]
aTotCon[1,17]+= aTotOOpe[1,17]
// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
aTotCon[1,18]+= aTotOOpe[1,18]

///////////////////////////////////////////////////////////
//                                                       //
//          I   M   P   R   E   S   S   A   O            //
//                                                       //
///////////////////////////////////////////////////////////

cString := Transform(aTotal[1,1],"@E 999,999,999.99") ;// Venda Total
+ Transform(aTotal[1,2],"@E 99999,999.99") ;	// Impostos
+ Transform(aTotal[1,3],"@E 99999,999.99") ;	// ICMS
+ Transform(aTotal[1,4],"@E 9999,999.99") ;	// ISS
+ Transform(aTotal[1,5],"@E 9999,999.99") ;	// PIS
+ Transform(aTotal[1,6],"@E 9999,999.99") ;	// Cofins
+ Transform(aTotal[1,7],"@E 99,999,999.99") ;	// Custos
+ Transform(aTotal[1,9],"@E 99,999,999.99") + Transform(((aTotal[1,9]/aTotal[1,1])*100),"@E 9999.9") ; // Lucro Bruto
+ Transform(aTotal[1,8],"@E 99,999,999.99") ;	// Juro Estoque
+ Transform(aTotal[1,10],"@E 99,999,999.99") ;// Desp Var
+ Transform(aTotal[1,11],"@E 99,999,999.99") ;// Comissoes
+ Transform(aTotal[1,12],"@E 99,999,999.99") ;// Lucro Liq
+ Transform(aTotal[1,13]+aTotal[1,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
+ Transform(aTotal[1,15],"@E 99,999,999.99") ;// Resultado Final
+ Transform(aTotal[1,16]/aTotal[1,17],"@E 999,999,999.9") //;// Prz Medio
//							+ Transform((aTotal[1,18]/aTotal[1,1])*100,"@E 9999.9")	// % Desc
If FunName() == "OFIOR250"
	IncRegua()
	cCabPri := STR0077
	cCabPri := U_FS_ImpRM_250(cCabPri)
	@ nLin++ , 00 psay Space(27)+cCabPri
	@ nLin++ , 00 psay STR0006 + cCabTot
	@ nLin++ , 00 psay STR0007 + U_FS_ImpRM_250(cString)
Else
	nLin+= 3
	fwrite(outputfile,Repl("*",220)+CHR(13)+CHR(10))
	fwrite(outputfile,STR0006+cCabTot +CHR(13)+CHR(10))
	cString += CHR(13)+CHR(10)
	fwrite(outputfile,STR0007+U_FS_ImpRM_250(cString))
EndIf

If MV_PAR09 == 1
	cString := Transform((aTotal[1,1]-aTotDev[1,1]),"@E 999,999,999.99"); // Venda Total
	+ Transform((aTotal[1,2]-aTotDev[1,2]),"@E 99999,999.99") ;	// Impostos
	+ Transform((aTotal[1,3]-aTotDev[1,3]),"@E 99999,999.99") ;	// ICMS
	+ Transform((aTotal[1,4]-aTotDev[1,4]),"@E 9999,999.99") ;	// ISS
	+ Transform((aTotal[1,5]-aTotDev[1,5]),"@E 9999,999.99") ;	// PIS
	+ Transform((aTotal[1,6]-aTotDev[1,6]),"@E 9999,999.99") ;	// Cofins
	+ Transform((aTotal[1,7]-aTotDev[1,7]),"@E 99,999,999.99") ; // Custos
	+ Transform((aTotal[1,9]-aTotDev[1,8]),"@E 99,999,999.99") + Transform((((aTotal[1,9]-aTotDev[1,8])/(aTotal[1,1]-aTotDev[1,1]))*100),"@E 9999.9");//Lucro Bruto
	+ Transform(aTotal[1,8],"@E 99,999,999.99") ;	// Juro Estoque
	+ Transform(aTotal[1,10],"@E 99,999,999.99") ;// Desp Var
	+ Transform(aTotal[1,11],"@E 99,999,999.99") ;// Comissoes
	+ Transform(aTotal[1,12],"@E 99,999,999.99") ;// Lucro Liq
	+ Transform(aTotal[1,13]+aTotal[1,14]-nTResSTDv,"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
	+ Transform(Iif(aTotal[1,1]-aTotDev[1,1]==0,0,aTotal[1,9]-aTotDev[1,8]-aTotal[1,8]-aTotal[1,10]),"@E 99,999,999.99") ;// Resultado Final
	+ Transform(Iif(aTotal[1,1]-aTotDev[1,1]==0,0,aTotal[1,16]/aTotal[1,17]),"@E 999,999,999.9") //;	// Prz Medio
	//								+ Transform((aTotal[1,18]/aTotal[1,1])*100,"@E 9999.9")	// % Desc
	
	//								+ Transform(If(aTotal[1,1]-aTotDev[1,1]==0,0,aTotal[1,15]),"@E 99,999,999.99") ;// Resultado Final
	
	If FunName() == "OFIOR250"
		@ nLin++ , 00 psay STR0045 + U_FS_ImpRM_250(cString)
	Else
		nLin++
		cString += CHR(13)+CHR(10)
		fwrite(outputfile,STR0045 + U_FS_ImpRM_250(cString))
	EndIf
EndIf

If FunName() == "OFIOR250"
	@ nLin++ , 00 psay Repl("*",220)
	IncRegua()
	If lAbortPrint
		nLin++
		@nLin++,30 PSAY STR0058 //"* * *  C A N C E L A D O   P E L O   O P E R A D O R  * * *"
		Return
	EndIf
Else
	nLin++
	fwrite(outputfile,Repl("*",220)+CHR(13)+CHR(10))
EndIf

If MV_PAR09 == 1
	////  DEVOLUCAO  ->  SUBTRAIR  NOS  TOTAIS  ////
	For ni:=1 to Len(aNumDev)
		cBALVEI := " "
		If left(aNumDev[ni,10],2) == "00" // Outros
			DbSelectArea( "SBM" )
			DbSetOrder(1)
			DbSeek( xFilial("SBM") + substr(aNumDev[ni,10],3,4) )
			If Alltrim(SBM->BM_TIPGRU) == "7" // Outros - Veiculos
				cBALVEI := "V"
			Else // Outros - Pecas
				cBALVEI := "B"
			EndIf
		EndIf
		If left(aNumDev[ni,10],2) $ "01/02/03/04" .or. cBALVEI == "V" // VEICULOS
			aTotVei[1,1] -= aNumDev[ni,3]
			aTotVei[1,2] -= aNumDev[ni,4]
			aTotVei[1,3] -= aNumDev[ni,5]
			aTotVei[1,4] -= aNumDev[ni,7]
			aTotVei[1,5] -= aNumDev[ni,8]
			aTotVei[1,6] -= aNumDev[ni,9]
			aTotVei[1,8] -= aNumDev[ni,11]
			cSeekDev := "XXX"
			If left(aNumDev[ni,10],2) == "01"
				cSeekDev := "10"
			ElseIf left(aNumDev[ni,10],2) == "02"
				cSeekDev := "11"
			ElseIf left(aNumDev[ni,10],2) == "03"
				cSeekDev := "20"
			ElseIf left(aNumDev[ni,10],2) == "04"
				cSeekDev := "21"
			EndIf
			nPos := 0
			nPos := aScan(aGrpVei,{|x| x[1]+x[2] == cSeekDev })
			If nPos > 0
				aGrpVei[nPos,3] -= aNumDev[ni,3]
				aGrpVei[nPos,4] -= aNumDev[ni,4]
				aGrpVei[nPos,5] -= aNumDev[ni,5]
				aGrpVei[nPos,6] -= aNumDev[ni,7]
				aGrpVei[nPos,7] -= aNumDev[ni,8]
				aGrpVei[nPos,8] -= aNumDev[ni,9]
				aGrpVei[nPos,10]-= aNumDev[ni,11]
				aGrpVei[nPos,17]--
			EndIf
			nPos := 0
			nPos := aScan(aNumVei,{|x| x[1] + x[2] + left(x[3],25) == cSeekDev + substr(aNumDev[ni,10],3,25) })
			If nPos > 0
				aNumVei[nPos,4] -= aNumDev[ni,3]
				aNumVei[nPos,5] -= aNumDev[ni,4]
				aNumVei[nPos,6] -= aNumDev[ni,5]
				aNumVei[nPos,7] -= aNumDev[ni,7]
				aNumVei[nPos,8] -= aNumDev[ni,8]
				aNumVei[nPos,9] -= aNumDev[ni,9]
				aNumVei[nPos,11]-= aNumDev[ni,11]
				aNumVei[nPos,18]--
			EndIf
		ElseIf left(aNumDev[ni,10],2) == "10" .or. cBALVEI == "B" // BALCAO
			aTotPec[1,1] -= aNumDev[ni,3]
			aTotPec[1,2] -= aNumDev[ni,4]
			aTotPec[1,3] -= aNumDev[ni,5]
			aTotPec[1,4] -= aNumDev[ni,7]
			aTotPec[1,5] -= aNumDev[ni,8]
			aTotPec[1,6] -= aNumDev[ni,9]
			aTotPec[1,8] -= aNumDev[ni,11]
			aGrpPBO[1,2] -= aNumDev[ni,3]
			aGrpPBO[1,3] -= aNumDev[ni,4]
			aGrpPBO[1,4] -= aNumDev[ni,5]
			aGrpPBO[1,5] -= aNumDev[ni,7]
			aGrpPBO[1,6] -= aNumDev[ni,8]
			aGrpPBO[1,7] -= aNumDev[ni,9]
			aGrpPBO[1,9] -= aNumDev[ni,11]
			aGrpPBO[1,13] -= aNumDev[ni,15]
			nPos := 0
			nPos := aScan(aNumPec,{|x| x[1]+x[2]+x[18]+x[19] == "B"+substr(aNumDev[ni,10],3,4)+"9"+aNumDev[ni,12] })
			If nPos > 0
				aNumPec[nPos,4] -= aNumDev[ni,3]
				aNumPec[nPos,5] -= aNumDev[ni,4]
				aNumPec[nPos,6] -= aNumDev[ni,5]
				aNumPec[nPos,7] -= aNumDev[ni,7]
				aNumPec[nPos,8] -= aNumDev[ni,8]
				aNumPec[nPos,9] -= aNumDev[ni,9]
				aNumPec[nPos,9] -= aNumDev[ni,9]
				aNumPec[nPos,15]-= aNumDev[ni,15]
				nPos := 0
				nPos := aScan(aDpto,{|x| x[1]+x[17]+x[18] == aNumDev[ni,12]+"B"+"9" })
				If nPos > 0
					aDpto[nPos,2] -= aNumDev[ni,3]
					aDpto[nPos,3] -= aNumDev[ni,4]
					aDpto[nPos,4] -= aNumDev[ni,5]
					aDpto[nPos,5] -= aNumDev[ni,7]
					aDpto[nPos,6] -= aNumDev[ni,8]
					aDpto[nPos,7] -= aNumDev[ni,9]
					aDpto[nPos,9] -= aNumDev[ni,11]
					aDpto[nPos,13] -= aNumDev[ni,15]
				EndIf
			Else
				//				aAdd(aNumPec,{ "B" , "DEV" , "DEV" , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , "9" , aNumDev[ni,12] })
				aAdd(aNumPec,{ "B" , aNumDev[ni,1] , aNumDev[ni,2] , aNumDev[ni,3]*-1 , aNumDev[ni,4]*-1 , aNumDev[ni,5]*-1 , aNumDev[ni,7]*-1 , aNumDev[ni,8]*-1 , aNumDev[ni,9]*-1 ,  0 , aNumDev[ni,11]*-1 , 0 , 0 ,  0, aNumDev[ni,15]*-1 , 0 , 0, "9" , aNumDev[ni,12],0,0,0 })
				nPos := 0
				nPos := aScan(aDpto,{|x| x[1]+x[17]+x[18] == aNumDev[ni,12]+"B"+"9" })
				If nPos == 0
					DbSelectArea( "SX5" )
					DbSetOrder(1)
					DbSeek( xFilial("SX5") + "99" + aNumDev[ni,12] )
					aAdd(aDpto,{ aNumDev[ni,12] , aNumDev[ni,3]*(-1) , aNumDev[ni,4]*(-1) , aNumDev[ni,5]*(-1) , aNumDev[ni,7]*(-1) , aNumDev[ni,8]*(-1) , aNumDev[ni,9]*(-1) , 0 , aNumDev[ni,11]*(-1) , 0 , 0 , 0 , aNumDev[ni,15]*-1 , 0 , 0 , left(Alltrim(SX5->X5_DESCRI)+repl(".",21),21) , "B" , "9" , 0 , 0 , 0 })
				Else
					aDpto[nPos,2] -= aNumDev[ni,3]
					aDpto[nPos,3] -= aNumDev[ni,4]
					aDpto[nPos,4] -= aNumDev[ni,5]
					aDpto[nPos,5] -= aNumDev[ni,7]
					aDpto[nPos,6] -= aNumDev[ni,8]
					aDpto[nPos,7] -= aNumDev[ni,9]
					aDpto[nPos,9] -= aNumDev[ni,11]
					aDpto[nPos,13] -= aNumDev[ni,15]
				EndIf
			EndIf
		ElseIf left(aNumDev[ni,10],1) == "2" // OFICINA
			aTotPec[1,1] -= aNumDev[ni,3]
			aTotPec[1,2] -= aNumDev[ni,4]
			aTotPec[1,3] -= aNumDev[ni,5]
			aTotPec[1,4] -= aNumDev[ni,7]
			aTotPec[1,5] -= aNumDev[ni,8]
			aTotPec[1,6] -= aNumDev[ni,9]
			aTotPec[1,8] -= aNumDev[ni,11]
			aGrpPBO[2,2] -= aNumDev[ni,3]
			aGrpPBO[2,3] -= aNumDev[ni,4]
			aGrpPBO[2,4] -= aNumDev[ni,5]
			aGrpPBO[2,5] -= aNumDev[ni,7]
			aGrpPBO[2,6] -= aNumDev[ni,8]
			aGrpPBO[2,7] -= aNumDev[ni,9]
			aGrpPBO[2,9] -= aNumDev[ni,11]
			aGrpPBO[2,13] -= aNumDev[ni,15]
			nPos := 0
			nPos := aScan(aGrpPec,{|x| x[1]+x[16] == "O" + substr(aNumDev[ni,10],2,1) })
			If nPos > 0
				aGrpPec[nPos,2] -= aNumDev[ni,3]
				aGrpPec[nPos,3] -= aNumDev[ni,4]
				aGrpPec[nPos,4] -= aNumDev[ni,5]
				aGrpPec[nPos,5] -= aNumDev[ni,7]
				aGrpPec[nPos,6] -= aNumDev[ni,8]
				aGrpPec[nPos,7] -= aNumDev[ni,9]
				aGrpPec[nPos,9] -= aNumDev[ni,11]
				aGrpPec[nPos,13] -= aNumDev[ni,15]
			EndIf
			nPos := 0
			nPos := aScan(aNumPec,{|x| x[1]+x[2]+x[18]+x[19] == "O"+substr(aNumDev[ni,10],3,4)+substr(aNumDev[ni,10],2,1)+aNumDev[ni,12] })
			If nPos > 0
				aNumPec[nPos,4] -= aNumDev[ni,3]
				aNumPec[nPos,5] -= aNumDev[ni,4]
				aNumPec[nPos,6] -= aNumDev[ni,5]
				aNumPec[nPos,7] -= aNumDev[ni,7]
				aNumPec[nPos,8] -= aNumDev[ni,8]
				aNumPec[nPos,9] -= aNumDev[ni,9]
				aNumPec[nPos,11]-= aNumDev[ni,11]
				aNumPec[nPos,15]-= aNumDev[ni,15]
				nPos := 0
				nPos := aScan(aDpto,{|x| x[1]+x[17]+x[18] == aNumDev[ni,12]+"O"+substr(aNumDev[ni,10],2,1) })
				If nPos > 0
					aDpto[nPos,2] -= aNumDev[ni,3]
					aDpto[nPos,3] -= aNumDev[ni,4]
					aDpto[nPos,4] -= aNumDev[ni,5]
					aDpto[nPos,5] -= aNumDev[ni,7]
					aDpto[nPos,6] -= aNumDev[ni,8]
					aDpto[nPos,7] -= aNumDev[ni,9]
					aDpto[nPos,9] -= aNumDev[ni,11]
					aDpto[nPos,13] -= aNumDev[ni,15]
				EndIf
			Else
				// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
				aAdd(aNumPec,{"O",aNumDev[ni,1],aNumDev[ni,2]+" ",-aNumDev[ni,3],-aNumDev[ni,4],-aNumDev[ni,5],-aNumDev[ni,7],-aNumDev[ni,8],-aNumDev[ni,9],0,-aNumDev[ni,11],0,0,0,-aNumDev[ni,15],0,-aNumDev[ni,13],substr(aNumDev[ni,10],2,1),aNumDev[ni,12],0,0,0})
				nPos := 0
				nPos := aScan(aDpto,{|x| x[1]+x[17]+x[18] == aNumDev[ni,12]+"O"+substr(aNumDev[ni,10],2,1) })
				If nPos == 0
					DbSelectArea( "SX5" )
					DbSetOrder(1)
					DbSeek( xFilial("SX5") + "99" + aNumDev[ni,12] )
					aAdd(aDpto,{aNumDev[ni,12],aNumDev[ni,3]*(-1),aNumDev[ni,4]*(-1),aNumDev[ni,5]*(-1),aNumDev[ni,7]*(-1),aNumDev[ni,8]*(-1),aNumDev[ni,9]*(-1),0,aNumDev[ni,11]*(-1),0,0,0,aNumDev[ni,15]*-1,0,0,left(Alltrim(SX5->X5_DESCRI)+repl(".",21),21),"O",substr(aNumDev[ni,10],2,1),0,0,0})
				Else
					aDpto[nPos,2] -= aNumDev[ni,3]
					aDpto[nPos,3] -= aNumDev[ni,4]
					aDpto[nPos,4] -= aNumDev[ni,5]
					aDpto[nPos,5] -= aNumDev[ni,7]
					aDpto[nPos,6] -= aNumDev[ni,8]
					aDpto[nPos,7] -= aNumDev[ni,9]
					aDpto[nPos,9] -= aNumDev[ni,11]
					aDpto[nPos,13] -= aNumDev[ni,15]
				EndIf
			EndIf
		EndIf
	Next
EndIf
FS_OR25A("V",aTotVei,aGrpVei,aNumVei,,,MV_PAR04,MV_PAR05,MV_PAR06,MV_PAR07)
FS_OR25A("P",aTotPec,aGrpPec,aNumPec,aGrpPBO,aDpto,MV_PAR04,MV_PAR05,MV_PAR06,MV_PAR07)
FS_OR25A("S",aTotSrv,aGrpSrv,aNumSrv,aDpto,,MV_PAR04,MV_PAR05,MV_PAR06,MV_PAR07)
FS_OR25A("A",aDesAce,,,,,MV_PAR04,MV_PAR05,MV_PAR06,MV_PAR07)
FS_OR25A("O",aTotOOpe,aOOpeSrv,aOOpeOut,,,MV_PAR04,MV_PAR05,MV_PAR06,MV_PAR07)
FS_OR25A("M",aTotAtiMob,aNumAtiMob,,,,MV_PAR04,MV_PAR05,MV_PAR06,MV_PAR07)
FS_OR25A("D",aTotDev,aNumDev,,,,MV_PAR04,MV_PAR05,MV_PAR06,MV_PAR07)

FS_OR25A("I",aIcmRet,,,,,MV_PAR04,MV_PAR05,MV_PAR06,MV_PAR07)

If ExistBlock("CONTABIL")
	ExecBlock("CONTABIL",.f.,.f.)
EndIf

If MV_PAR07 == 1
	FS_OR25A("E",aTotEnt,aGrpEnt,aNumEnt,aEntrad,,MV_PAR04,MV_PAR05,MV_PAR06,MV_PAR07)
EndIf
If MV_PAR06 # 1
	FS_OR25A("C",aTotCon,aTotPag,aGrpPag,aPecSrvOfi,aConPagNF,MV_PAR04,MV_PAR05,MV_PAR06,MV_PAR07)
EndIf

//Gera OFIO250_CLI e OFIOR250_ITE (Total)
If FunName() == "OFIOR250"
	/// Cria Arquivo TXT por Cliente (Venda/LucroBruto) ///
	nTXTAux1 := nTXTAux2 := 0
	aSort(aTXTCli,1,,{|x,y| x[2] > y[2] })
	For ni:=1 to len(aTXTCli)
		nTXTAux1 += aTXTCli[ni,2]
		nTXTAux2 += aTXTCli[ni,4]
		aTXTCli[ni,3] := Transform(((aTXTCli[ni,2]/nTXTVda)*100),"@E 9999.9")+Transform(((nTXTAux1/nTXTVda)*100),"@E 9999.9")
		aTXTCli[ni,5] := Transform(((aTXTCli[ni,4]/nTXTLuc)*100),"@E 9999.9")+Transform(((nTXTAux2/nTXTLuc)*100),"@E 9999.9")
	Next
	cArq := __RELDIR+cNomeRel+"_Cli.##R"
	If File(cArq)
		Dele File &(cArq)
	EndIf
	Outputfile := FCREATE(cArq,0)
	If fError() != 0 .And. OutputFile < 0
		//	   Exit
	Endif
	fwrite(outputfile," "+CHR(15)+CHR(13)+CHR(10))
	fwrite(outputfile,strzero(len(aTXTCli),5)+STR0126+cTitulo+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	cMes := ""
	If len(aTXTMes) > 23
		For nMes:=1 to 12
			cMes += Iif(aTXTMes[((nMes-1)*2)+1,2]<=(strzero(year(MV_PAR02),4)+strzero(month(MV_PAR02),2)),"  Vda("+Transform(aTXTMes[((nMes-1)*2)+1,1],"@R 99/9999")+")  LBr("+Transform(aTXTMes[((nMes-1)*2)+1,1],"@R 99/9999")+")","")
		Next
	EndIf
	fwrite(outputfile,STR0127+cMes+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	For ni:=1 to len(aTXTCli)
		DbSelectArea("SA1")
		DbSetOrder(1)
		DbSeek(xFilial("SA1") + aTXTCli[ni,1] )
		cMes := ""
		If len(aTXTMes) > 23
			For nMes:=1 to 12
				cMes += Iif(aTXTMes[((nMes-1)*2)+1,2]<=(strzero(year(MV_PAR02),4)+strzero(month(MV_PAR02),2)),Transform(aTXTCliA[aTXTCli[ni,6],((nMes-1)*2)+1],"@E 999,999,999.99"),"")
				cMes += Iif(aTXTMes[((nMes-1)*2)+1,2]<=(strzero(year(MV_PAR02),4)+strzero(month(MV_PAR02),2)),Transform(aTXTCliA[aTXTCli[ni,6],((nMes-1)*2)+2],"@E 999,999,999.99"),"")
			Next
		EndIf
		fwrite(outputfile,strzero(ni,5)+" "+SA1->A1_CGC+" "+SA1->A1_NOME+Transform(aTXTCli[ni,2],"@E 999,999,999.99")+aTXTCli[ni,3]+Transform(aTXTCli[ni,4],"@E 999,999,999.99")+aTXTCli[ni,5]+cMes+CHR(13)+CHR(10))
	Next
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,STR0128+Transform(nTXTVda,"@E 999,999,999.99")+CHR(13)+CHR(10))
	fwrite(outputfile,STR0129+Transform(nTXTLuc,"@E 999,999,999.99")+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(18)+CHR(13)+CHR(10)+CHR(12))
	fclose(Outputfile)
	/// Cria Arquivo TXT por Item (Venda/LucroBruto) ///
	nTXTAux1 := nTXTAux2 := 0
	aSort(aTXTIte,1,,{|x,y| x[2] > y[2] })
	For ni:=1 to len(aTXTIte)
		nTXTAux1 += aTXTIte[ni,2]
		nTXTAux2 += aTXTIte[ni,4]
		aTXTIte[ni,3] := Transform(((aTXTIte[ni,2]/nTXTVda)*100),"@E 9999.9")+Transform(((nTXTAux1/nTXTVda)*100),"@E 9999.9")
		aTXTIte[ni,5] := Transform(((aTXTIte[ni,4]/nTXTLuc)*100),"@E 9999.9")+Transform(((nTXTAux2/nTXTLuc)*100),"@E 9999.9")
	Next
	cArq := __RELDIR+cNomeRel+"_Ite.##R"
	If File(cArq)
		Dele File &(cArq)
	EndIf
	Outputfile := FCREATE(cArq,0)
	If fError() != 0 .And. OutputFile < 0
		//	   Exit
	Endif
	fwrite(outputfile," "+CHR(15)+CHR(13)+CHR(10))
	fwrite(outputfile,strzero(len(aTXTIte),5)+STR0130+cTitulo+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	cMes := ""
	If len(aTXTMes) > 23
		For nMes:=1 to 12
			cMes += Iif(aTXTMes[((nMes-1)*2)+1,2]<=(strzero(year(MV_PAR02),4)+strzero(month(MV_PAR02),2)),"  Vda("+Transform(aTXTMes[((nMes-1)*2)+1,1],"@R 99/9999")+")  LBr("+Transform(aTXTMes[((nMes-1)*2)+1,1],"@R 99/9999")+")","")
		Next
	EndIf
	fwrite(outputfile,STR0131+cMes+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	For ni:=1 to len(aTXTIte)
		DbSelectArea("SB1")
		DbSetOrder(7)
		DbSeek(xFilial("SB1") + aTXTIte[ni,1] )
		cMes := ""
		If len(aTXTMes) > 23
			For nMes:=1 to 12
				cMes += Iif(aTXTMes[((nMes-1)*2)+1,2]<=(strzero(year(MV_PAR02),4)+strzero(month(MV_PAR02),2)),Transform(aTXTIteA[aTXTIte[ni,6],((nMes-1)*2)+1],"@E 999,999,999.99"),"")
				cMes += Iif(aTXTMes[((nMes-1)*2)+1,2]<=(strzero(year(MV_PAR02),4)+strzero(month(MV_PAR02),2)),Transform(aTXTIteA[aTXTIte[ni,6],((nMes-1)*2)+2],"@E 999,999,999.99"),"")
			Next
		EndIf
		fwrite(outputfile,strzero(ni,5)+" "+SB1->B1_GRUPO+" "+SB1->B1_CODITE+" "+SB1->B1_DESC+Transform(aTXTIte[ni,8],"999999")+Transform(aTXTIte[ni,2],"@E 999,999,999.99")+aTXTIte[ni,3]+Transform(aTXTIte[ni,4],"@E 999,999,999.99")+aTXTIte[ni,5]+cMes+CHR(13)+CHR(10))
	Next
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,STR0128+Transform(nTXTVda,"@E 999,999,999.99")+CHR(13)+CHR(10))
	fwrite(outputfile,STR0129+Transform(nTXTLuc,"@E 999,999,999.99")+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(18)+CHR(13)+CHR(10)+CHR(12))
	fclose(Outputfile)
	For ni:=nCont to 20
		IncRegua()
	Next
	Ms_Flush()
	Set Printer to
	Set Device  to Screen
EndIf

//Gera OFIO250_CLI_P e OFIOR250_ITE_P (Sem considerar Garantia)
If FunName() == "OFIOR250"
	/// Cria Arquivo TXT por Cliente (Venda/LucroBruto) ///
	nTXTAux1 := nTXTAux2 := 0
	aSort(aTXTCli,1,,{|x,y| x[2] > y[2] })
	For ni:=1 to len(aTXTCli)
		If aTXTCli[ni,7] != "2" // Nao Garantia
			nTXTAux1 += aTXTCli[ni,2]
			nTXTAux2 += aTXTCli[ni,4]
			aTXTCli[ni,3] := Transform(((aTXTCli[ni,2]/nTXTVdaNG)*100),"@E 9999.9")+Transform(((nTXTAux1/nTXTVdaNG)*100),"@E 9999.9")
			aTXTCli[ni,5] := Transform(((aTXTCli[ni,4]/nTXTLucNG)*100),"@E 9999.9")+Transform(((nTXTAux2/nTXTLucNG)*100),"@E 9999.9")
		Endif
	Next
	cArq := __RELDIR+cNomeRel+"_Cli_P.##R"
	If File(cArq)
		Dele File &(cArq)
	EndIf
	Outputfile := FCREATE(cArq,0)
	If fError() != 0 .And. OutputFile < 0
		//	   Exit
	Endif
	fwrite(outputfile," "+CHR(15)+CHR(13)+CHR(10))
	fwrite(outputfile,strzero(len(aTXTCli),5)+STR0126+cTitulo+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	cMes := ""
	If len(aTXTMes) > 23
		For nMes:=1 to 12
			cMes += Iif(aTXTMes[((nMes-1)*2)+1,2]<=(strzero(year(MV_PAR02),4)+strzero(month(MV_PAR02),2)),"  Vda("+Transform(aTXTMes[((nMes-1)*2)+1,1],"@R 99/9999")+")  LBr("+Transform(aTXTMes[((nMes-1)*2)+1,1],"@R 99/9999")+")","")
		Next
	EndIf
	fwrite(outputfile,STR0127+cMes+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	For ni:=1 to len(aTXTCli)
		If aTXTCli[ni,7] != "2" // Nao Garantia
			DbSelectArea("SA1")
			DbSetOrder(1)
			DbSeek(xFilial("SA1") + aTXTCli[ni,1] )
			cMes := ""
			If len(aTXTMes) > 23
				For nMes:=1 to 12
					cMes += Iif(aTXTMes[((nMes-1)*2)+1,2]<=(strzero(year(MV_PAR02),4)+strzero(month(MV_PAR02),2)),Transform(aTXTCliNG[aTXTCli[ni,6],((nMes-1)*2)+1],"@E 999,999,999.99"),"")
					cMes += Iif(aTXTMes[((nMes-1)*2)+1,2]<=(strzero(year(MV_PAR02),4)+strzero(month(MV_PAR02),2)),Transform(aTXTCliNG[aTXTCli[ni,6],((nMes-1)*2)+2],"@E 999,999,999.99"),"")
				Next
			EndIf
			fwrite(outputfile,strzero(ni,5)+" "+SA1->A1_CGC+" "+SA1->A1_NOME+Transform(aTXTCli[ni,2],"@E 999,999,999.99")+aTXTCli[ni,3]+Transform(aTXTCli[ni,4],"@E 999,999,999.99")+aTXTCli[ni,5]+cMes+CHR(13)+CHR(10))
		Endif
	Next
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,STR0128+Transform(nTXTVdaNG,"@E 999,999,999.99")+CHR(13)+CHR(10))
	fwrite(outputfile,STR0129+Transform(nTXTLucNG,"@E 999,999,999.99")+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(18)+CHR(13)+CHR(10)+CHR(12))
	fclose(Outputfile)
	/// Cria Arquivo TXT por Item (Venda/LucroBruto) ///
	nTXTAux1 := nTXTAux2 := 0
	aSort(aTXTIte,1,,{|x,y| x[2] > y[2] })
	For ni:=1 to len(aTXTIte)
		If aTXTIte[ni,7] != "2" // Nao Garantia
			nTXTAux1 += aTXTIte[ni,2]
			nTXTAux2 += aTXTIte[ni,4]
			aTXTIte[ni,3] := Transform(((aTXTIte[ni,2]/nTXTVdaNG)*100),"@E 9999.9")+Transform(((nTXTAux1/nTXTVdaNG)*100),"@E 9999.9")
			aTXTIte[ni,5] := Transform(((aTXTIte[ni,4]/nTXTLucNG)*100),"@E 9999.9")+Transform(((nTXTAux2/nTXTLucNG)*100),"@E 9999.9")
		Endif
	Next
	cArq := __RELDIR+cNomeRel+"_Ite_P.##R"
	If File(cArq)
		Dele File &(cArq)
	EndIf
	Outputfile := FCREATE(cArq,0)
	If fError() != 0 .And. OutputFile < 0
		//	   Exit
	Endif
	fwrite(outputfile," "+CHR(15)+CHR(13)+CHR(10))
	fwrite(outputfile,strzero(len(aTXTIte),5)+STR0130+cTitulo+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	cMes := ""
	If len(aTXTMes) > 23
		For nMes:=1 to 12
			cMes += Iif(aTXTMes[((nMes-1)*2)+1,2]<=(strzero(year(MV_PAR02),4)+strzero(month(MV_PAR02),2)),"  Vda("+Transform(aTXTMes[((nMes-1)*2)+1,1],"@R 99/9999")+")  LBr("+Transform(aTXTMes[((nMes-1)*2)+1,1],"@R 99/9999")+")","")
		Next
	EndIf
	fwrite(outputfile,STR0131+cMes+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	For ni:=1 to len(aTXTIte)
		If aTXTIte[ni,7] != "2" // Nao Garantia
			
			DbSelectArea("SB1")
			DbSetOrder(7)
			DbSeek(xFilial("SB1") + aTXTIte[ni,1] )
			cMes := ""
			If len(aTXTMes) > 23
				For nMes:=1 to 12
					cMes += Iif(aTXTMes[((nMes-1)*2)+1,2]<=(strzero(year(MV_PAR02),4)+strzero(month(MV_PAR02),2)),Transform(aTXTIteNG[aTXTIte[ni,6],((nMes-1)*2)+1],"@E 999,999,999.99"),"")
					cMes += Iif(aTXTMes[((nMes-1)*2)+1,2]<=(strzero(year(MV_PAR02),4)+strzero(month(MV_PAR02),2)),Transform(aTXTIteNG[aTXTIte[ni,6],((nMes-1)*2)+2],"@E 999,999,999.99"),"")
				Next
			EndIf
			fwrite(outputfile,strzero(ni,5)+" "+SB1->B1_GRUPO+" "+SB1->B1_CODITE+" "+SB1->B1_DESC+Transform(aTXTIte[ni,8],"999999")+Transform(aTXTIte[ni,2],"@E 999,999,999.99")+aTXTIte[ni,3]+Transform(aTXTIte[ni,4],"@E 999,999,999.99")+aTXTIte[ni,5]+cMes+CHR(13)+CHR(10))
			
		Endif
	Next
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,STR0128+Transform(nTXTVdaNG,"@E 999,999,999.99")+CHR(13)+CHR(10))
	fwrite(outputfile,STR0129+Transform(nTXTLucNG,"@E 999,999,999.99")+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(18)+CHR(13)+CHR(10)+CHR(12))
	fclose(Outputfile)
	For ni:=nCont to 20
		IncRegua()
	Next
	Ms_Flush()
	Set Printer to
	Set Device  to Screen
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³FS_M_OR250³Autor  ³ Andre Luis Almeida    ³ Data ³ 03/01/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Continua carregando o OFIOR250, pois nao estava compilando ³±±
±±³          ³ na versao 609 devido ao numero alto de variaveis e vetores ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Atualizacao: PIS/COFINS da Desp. Acess. esta sendo somado no Depto de  ³±±
±±³             Origem, apos 21/05/04, 25/05/04 e 26/05/04.               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_M_OR250()
local ii := 0
Local cChave  := cSF2Soma := ""
Local lDuplic := .f. , lEntrada := .f.
Local nCofins := nCofDesp := nPisDesp := nVPisDesp := nVCofDesp := nVlrDev := nPisDev := nCofDev := nImpDev := nPisOOpe := nCofOOpe := 0
Local cDpto   := "  "
Local cAliasSF2  := "SQLSF2"
Local cAliasSF1  := "SQLSF1"
Local cAliasSD1  := "SQLSD1"
Local cAliasSD2  := "SQLSD2"
Local cAliasSD2a := "SQLSD2"
Local cPrefBAL   := GetNewPar("MV_PREFBAL","BAL")
Local cPrefOFI   := GetNewPar("MV_PREFOFI","OFI")
Local cPrefVEI   := GetNewPar("MV_PREFVEI","VEI")
Local oSqlHlp := DMS_SqlHelper():New()
Public ntott := 0
Public ntotu := 0
///////////////////////////////////
//   O U T R A S   V E N D A S   //
///////////////////////////////////

If FunName() == "OFIOR250"
	IncRegua()
EndIf

cQuery := "SELECT SF2.F2_VALICM , SF2.F2_DOC,SF2.F2_SERIE,SF2.F2_EMISSAO,SF2.F2_TIPO ,SF2.F2_NFORI,SF2.F2_SERIORI,SF2.F2_DESPESA,SF2.F2_FRETE,SF2.F2_SEGURO,SF2.F2_COND,SF2.F2_VEND1,SF2.F2_PREFIXO,SF2.F2_CLIENTE,SF2.F2_LOJA,SF2.F2_ICMSRET,SF2.F2_VALISS,SF2.F2_PREFORI "
cQuery += "FROM "
cQuery += RetSqlName( "SF2" ) + " SF2 "
cQuery += "WHERE "
cQuery += "SF2.F2_FILIAL='"+ xFilial("SF2")+ "' AND SF2.F2_EMISSAO >= '"+dtos(mv_par01)+"' AND SF2.F2_EMISSAO <= '"+dtos(mv_par02)+"' AND "
cQuery += "(SF2.F2_TIPO = 'N' OR SF2.F2_TIPO = 'C' OR SF2.F2_TIPO = 'I') AND "
cQuery += "SF2.D_E_L_E_T_=' '"

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSF2, .T., .T. )

While !((cAliasSF2)->(Eof()))
	
	If FunName() == "OFIOR250"
		nCont ++
		If nCont == 400
			IncRegua()
			nCont := 2
			If lAbortPrint
				nLin++
				@nLin++,30 PSAY STR0058 //"* * *  C A N C E L A D O   P E L O   O P E R A D O R  * * *"
				Exit
			EndIf
		EndIf
	EndIf
	If (cAliasSF2)->(F2_EMISSAO) < "20040201"
		nCofins := ( 3 / 100 )
	Else
		nCofins := nCof
	EndIf
	
	///////////////////////////////////
	// D E S P E S A S   A C E S S . //
	///////////////////////////////////
	
	nVPisDesp := 0
	nVCofDesp := 0
	lDuplic := .f.
	cNFSORI := (cAliasSF2)->(F2_NFORI)
	cSERORI := (cAliasSF2)->(F2_SERIORI)
	
	
	cQuery := "SELECT SD2.D2_DOC,SD2.D2_SERIE,SD2.D2_NFORI,SD2.D2_SERIORI,SD2.D2_TES,SD2.D2_EMISSAO,SD2.D2_DESPESA,SD2.D2_VALFRE,SD2.D2_SEGURO "
	cQuery += "FROM "
	cQuery += RetSqlName( "SD2" ) + " SD2 "
	cQuery += "WHERE "
	cQuery += "SD2.D2_FILIAL='"+ xFilial("SD2")+ "' AND SD2.D2_DOC = '"+(cAliasSF2)->(F2_DOC)+"' AND SD2.D2_SERIE = '"+(cAliasSF2)->(F2_SERIE)+"' AND "
	cQuery += "SD2.D_E_L_E_T_=' '"
	
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSD2, .T., .T. )
	
	While !((cAliasSD2)->(Eof()))
		
		cNFSORI := (cAliasSD2)->D2_NFORI
		cSERORI := (cAliasSD2)->D2_SERIORI
		DbSelectArea( "SF4" )
		DbSetOrder(1)
		DbSeek( xFilial("SF4") + (cAliasSD2)->D2_TES )
		If SF4->F4_DUPLIC == "S" .or. SF4->F4_OPEMOV == "05"
			lDuplic := .t.
			nPisDesp := nPis
			nCofDesp := nCofins
			nVPisDesp += ( ( (cAliasSD2)->D2_DESPESA + (cAliasSD2)->D2_VALFRE + (cAliasSD2)->D2_SEGURO ) * nPisDesp )
			nVCofDesp += ( ( (cAliasSD2)->D2_DESPESA + (cAliasSD2)->D2_VALFRE + (cAliasSD2)->D2_SEGURO ) * nCofDesp )
		EndIf
		dbSelectArea(cAliasSD2)
		(cAliasSD2)->(Dbskip())
	EndDo
	(cAliasSD2)->(DBCloseArea())
	
	If lDuplic
		
		//		Manoel - 27/02/2008 - Tiramos (Silvania)
		//		If Mv_Par09 != 1
		aDesAce[1,2] += ((cAliasSF2)->(F2_DESPESA) + (cAliasSF2)->(F2_FRETE) + (cAliasSF2)->(F2_SEGURO))		// Despesa
		aDesAce[1,3] += nVPisDesp				// PIS
		aDesAce[1,4] += nVCofDesp				// COFINS
		//		Endif
		
		aTotal[1,1]  += ((cAliasSF2)->(F2_DESPESA) + (cAliasSF2)->(F2_FRETE) + (cAliasSF2)->(F2_SEGURO) )  		// Despesa
		aTotal[1,5]  += nVPisDesp				// PIS
		aTotal[1,6]  += nVCofDesp				// COFINS
		
		//		Manoel - 28/02/2008
		//		aTotal[1,9]  += ( (SF2->F2_DESPESA + SF2->F2_FRETE + SF2->F2_SEGURO ) - (nVPisDesp+nVCofDesp) )		// Lucro Bruto
		//		aTotal[1,12] += ( (SF2->F2_DESPESA + SF2->F2_FRETE + SF2->F2_SEGURO ) - (nVPisDesp+nVCofDesp) )		// Lucro Liquido
		//		aTotal[1,15] += ( (SF2->F2_DESPESA + SF2->F2_FRETE + SF2->F2_SEGURO ) - (nVPisDesp+nVCofDesp) )		// Resultado Final
		
		If MV_PAR06 # 1
			
			aTotCon[1,1] += ((cAliasSF2)->(F2_DESPESA) + (cAliasSF2)->(F2_FRETE) + (cAliasSF2)->(F2_SEGURO) )  		// Despesa
			aTotCon[1,5] += nVPisDesp			// PIS
			aTotCon[1,6] += nVCofDesp			// COFINS
			
			nPos := 0
			nPos := aScan(aGrpPag,{|x| x[1] == (cAliasSF2)->(F2_COND)})
			If nPos == 0
				DbSelectArea( "SE4" )
				DbSetOrder(1)
				DbSeek( xFilial("SE4") + (cAliasSF2)->(F2_COND) )
				// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
				aAdd(aGrpPag,{ SF2->F2_COND , SE4->E4_DESCRI , ( (cAliasSF2)->(F2_DESPESA) + (cAliasSF2)->(F2_FRETE) + (cAliasSF2)->(F2_SEGURO)) , (nVPisDesp+nVCofDesp) , 0 , 0 , nVPisDesp , nVCofDesp , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,0})
			Else
				aGrpPag[nPos,3] += ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO )
				aGrpPag[nPos,4] += (nVPisDesp+nVCofDesp)
				aGrpPag[nPos,7] += nVPisDesp
				aGrpPag[nPos,8] += nVCofDesp
			EndIf
			
			DbSelectArea( "VAI" )
			DbSetOrder(6)
			DbSeek( xFilial("VAI") + (cAliasSF2)->F2_VEND1 )
			nPos := 0
			If MV_PAR06 # 3
				nPos := aScan(aTotPag,{|x| x[1]+x[2] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+(cAliasSF2)->F2_VEND1 })
			Else
				nPos := aScan(aTotPag,{|x| x[1]+x[2] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+VAI->VAI_CC })
			EndIf
			If nPos == 0 .or. MV_PAR06 == 4
				If MV_PAR06 # 3
					DbSelectArea( "SA3" )
					DbSetOrder(1)
					DbSeek( xFilial("SA3") + VAI->VAI_CODVEN )
					// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
					aAdd(aTotPag,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+(cAliasSF2)->F2_VEND1 , left(SA3->A3_NOME,17) , ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO ) , (nVPisDesp+nVCofDesp) , 0 , 0 , nVPisDesp , nVCofDesp , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
					
					nPos3 := 0
					nPos3 := aScan(aCCVend,{|x| x[1]+x[2] == Iif(lDuplic,"E","I")+VAI->VAI_CC + (cAliasSF2)->F2_VEND1 })
					If nPos3 == 0
						DbSelectArea( "SI3" )
						DbSetOrder(1)
						DbSeek( xFilial("SI3") + VAI->VAI_CC )
						// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
						aAdd(aCCVend,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , (cAliasSF2)->F2_VEND1 , left(SA3->A3_NOME,17) , ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO ) , (nVPisDesp+nVCofDesp) , 0 , 0 , nVPisDesp , nVCofDesp , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , Iif(lDuplic,"Ext ","Int ")+left(SI3->I3_DESC,21),0,0,0})
					Else
						aCCVend[nPos3,4] += ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO )
						aCCVend[nPos3,5] += (nVPisDesp+nVCofDesp)
						aCCVend[nPos3,8] += nVPisDesp
						aCCVend[nPos3,9] += nVCofDesp
					EndIf
					nPos3 := 0
					nPos3 := aScan(aTotCCV,{|x| x[1] == Iif(lDuplic,"E","I")+VAI->VAI_CC })
					If nPos3 == 0
						// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
						aAdd(aTotCCV,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO ) , (nVPisDesp+nVCofDesp) , 0 , 0 , nVPisDesp , nVCofDesp , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
					Else
						aTotCCV[nPos3,2] += ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO )
						aTotCCV[nPos3,3] += (nVPisDesp+nVCofDesp)
						aTotCCV[nPos3,6] += nVPisDesp
						aTotCCV[nPos3,7] += nVCofDesp
					EndIf
				Else
					DbSelectArea( "SI3" )
					DbSetOrder(1)
					DbSeek( xFilial("SI3") + VAI->VAI_CC )
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					aAdd(aTotPag,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+VAI->VAI_CC , left(SI3->I3_DESC,14) , ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO ) , (nVPisDesp+nVCofDesp) , 0 , 0 , nVPisDesp , nVCofDesp , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
				EndIf
			Else
				aTotPag[nPos,4] += ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO )
				aTotPag[nPos,5] += (nVPisDesp+nVCofDesp)
				aTotPag[nPos,8] += nVPisDesp
				aTotPag[nPos,9] += nVCofDesp
			EndIf
			// Andre Luis Almeida - 15/03/2004 - Mostrar DESPESA no Resumo p/Cond.Pagto.
			nPos := 0
			If (cAliasSF2)->F2_PREFORI == cPrefOFI
				If Alltrim(SD2->D2_GRUPO) == "SRV"
					nPos := aScan(aPecSrvOfi,{|x| x[1]+x[2]+x[4] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + Iif(lDuplic,"Ext ","Int ")+left(STR0063,18) })
					If nPos == 0
						aAdd(aPecSrvOfi,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO ) , Iif(lDuplic,"Ext ","Int ")+left(STR0063,18) })
					Else
						aPecSrvOfi[nPos,3] += ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO )
					EndIf
					nPos := 0
					nPos := aScan(aConPagNF,{|x| x[1]+x[2]+x[3]+x[4]+x[7] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE + Iif(lDuplic,"Ext ","Int ")+left(STR0063,18) })
					If nPos == 0
						DbSelectArea( "SA1" )
						DbSetOrder(1)
						DbSeek( xFilial("SA1") + (cAliasSF2)->F2_CLIENTE + (cAliasSF2)->F2_LOJA )
						aAdd(aConPagNF,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , (cAliasSF2)->F2_DOC , (cAliasSF2)->F2_SERIE , left(SA1->A1_NOME,10) , ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO ) , Iif(lDuplic,"Ext ","Int ")+left(STR0063,18) })
					Else
						aConPagNF[nPos,6] += ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO )
					EndIf
				Else
					nPos := aScan(aPecSrvOfi,{|x| x[1]+x[2]+x[4] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + Iif(lDuplic,"Ext ","Int ")+left(STR0064,18) })
					If nPos == 0
						aAdd(aPecSrvOfi,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO ) , Iif(lDuplic,"Ext ","Int ")+left(STR0064,18) })
					Else
						aPecSrvOfi[nPos,3] += ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO )
					EndIf
					nPos := 0
					nPos := aScan(aConPagNF,{|x| x[1]+x[2]+x[3]+x[4]+x[7] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE + Iif(lDuplic,"Ext ","Int ")+left(STR0064,18) })
					If nPos == 0
						DbSelectArea( "SA1" )
						DbSetOrder(1)
						DbSeek( xFilial("SA1") + (cAliasSF2)->F2_CLIENTE + (cAliasSF2)->F2_LOJA )
						aAdd(aConPagNF,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , (cAliasSF2)->F2_DOC , (cAliasSF2)->F2_SERIE , left(SA1->A1_NOME,10) , ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO ) , Iif(lDuplic,"Ext ","Int ")+left(STR0064,18) })
					Else
						aConPagNF[nPos,6] += ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO )
					EndIf
				EndIf
			ElseIf (cAliasSF2)->F2_PREFORI == cPrefBAL
				nPos := aScan(aPecSrvOfi,{|x| x[1]+x[2]+x[4] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + Iif(lDuplic,"Ext ","Int ")+left(STR0065,18) })
				If nPos == 0
					aAdd(aPecSrvOfi,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO ) , Iif(lDuplic,"Ext ","Int ")+left(STR0065,18) })
				Else
					aPecSrvOfi[nPos,3] += ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO )
				EndIf
				nPos := aScan(aConPagNF,{|x| x[1]+x[2]+x[3]+x[4]+x[7] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE + Iif(lDuplic,"Ext ","Int ")+left(STR0065,18) })
				If nPos == 0
					DbSelectArea( "SA1" )
					DbSetOrder(1)
					DbSeek( xFilial("SA1") + (cAliasSF2)->F2_CLIENTE + (cAliasSF2)->F2_LOJA )
					aAdd(aConPagNF,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , (cAliasSF2)->F2_DOC , (cAliasSF2)->F2_SERIE , left(SA1->A1_NOME,10) , ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO ) , Iif(lDuplic,"Ext ","Int ")+left(STR0065,18) })
				Else
					aConPagNF[nPos,6] += ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO )
				EndIf
			Else
				nPos := aScan(aConPagNF,{|x| x[1]+x[2]+x[3]+x[4]+x[7] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE + "1" })
				If nPos == 0
					DbSelectArea( "SA1" )
					DbSetOrder(1)
					DbSeek( xFilial("SA1") + (cAliasSF2)->F2_CLIENTE + (cAliasSF2)->F2_LOJA )
					aAdd(aConPagNF,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , (cAliasSF2)->F2_DOC , (cAliasSF2)->F2_SERIE , left(SA1->A1_NOME,10) , ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO ) , "1" })
				Else
					aConPagNF[nPos,6] += ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO )
				EndIf
			EndIf
		EndIf
		
		//		Manoel - 27/02/2008 - Tiramos (Silvania)
		//		If Mv_Par09 != 1
		
		Do Case
			
			Case (cAliasSF2)->F2_PREFORI == cPrefVEI  //  V E I C U L O S
				aDesAce[2,2] += ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO )	// Despesa
				aDesAce[2,3] += nVPisDesp			// PIS
				aDesAce[2,4] += nVCofDesp	 		// COFINS
				
			Case (cAliasSF2)->F2_PREFORI == cPrefBAL  //  B A L C A O
				aDesAce[3,2] += ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO )	// Despesa
				aDesAce[3,3] += nVPisDesp			// PIS
				aDesAce[3,4] += nVCofDesp			// COFINS
				
			Case (cAliasSF2)->F2_PREFORI == cPrefOFI  //  O F I C I N A
				aDesAce[4,2] += ( (cAliasSF2)->F2_DESPESA + (cAliasSF2)->F2_FRETE + (cAliasSF2)->F2_SEGURO )	// Despesa
				aDesAce[4,3] += nVPisDesp			// PIS
				aDesAce[4,4] += nVCofDesp			// COFINS
		EndCase
		
		//		EndIf
		
	EndIf
	
	///////////////////////////////////////////////////////////////////////////
	// Manoel - 10/06/2008  -  ICMRET
	If lDuplic
		
		//		Manoel - 27/02/2008 - Tiramos (Silvania)
		//		If Mv_Par09 != 1
		aICMRET[1,2] += ( (cAliasSF2)->F2_ICMSRET)
		//		Endif
		
		aTotal[1,1]  += ( (cAliasSF2)->F2_ICMSRET )
		
		//		Manoel - 28/02/2008
		aTotal[1,9]  += ((cAliasSF2)->F2_ICMSRET) // Lucro Bruto
		aTotal[1,12] += ((cAliasSF2)->F2_ICMSRET) // Lucro Liquido
		aTotal[1,15] += ((cAliasSF2)->F2_ICMSRET) // Resultado Final
		
		If MV_PAR06 # 1
			
			aTotCon[1,1] += ( (cAliasSF2)->F2_ICMSRET)
			
			nPos := 0
			nPos := aScan(aGrpPag,{|x| x[1] == (cAliasSF2)->F2_COND })
			//If nPos == 0
			//	DbSelectArea( "SE4" )
			//	DbSetOrder(1)
			//	DbSeek( xFilial("SE4") + (cAliasSF2)->F2_COND )
			//	// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
			//	aAdd(aGrpPag,{ (cAliasSF2)->F2_COND , SE4->E4_DESCRI , ( (cAliasSF2)->F2_ICMSRET ) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,0})
			//Else
				aGrpPag[nPos,3] += ( (cAliasSF2)->F2_ICMSRET )
			//EndIf
			
			DbSelectArea( "VAI" )
			DbSetOrder(6)
			DbSeek( xFilial("VAI") + (cAliasSF2)->F2_VEND1 )
			nPos := 0
			If MV_PAR06 # 3
				nPos := aScan(aTotPag,{|x| x[1]+x[2] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+(cAliasSF2)->F2_VEND1 })
			Else
				nPos := aScan(aTotPag,{|x| x[1]+x[2] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+VAI->VAI_CC })
			EndIf
			If nPos == 0 .or. MV_PAR06 == 4
				If MV_PAR06 # 3
					DbSelectArea( "SA3" )
					DbSetOrder(1)
					DbSeek( xFilial("SA3") + VAI->VAI_CODVEN )
					// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
					aAdd(aTotPag,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+(cAliasSF2)->F2_VEND1 , left(SA3->A3_NOME,17) , ( (cAliasSF2)->F2_ICMSRET ) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
					
					nPos3 := 0
					nPos3 := aScan(aCCVend,{|x| x[1]+x[2] == Iif(lDuplic,"E","I")+VAI->VAI_CC + (cAliasSF2)->F2_VEND1 })
					If nPos3 == 0
						DbSelectArea( "SI3" )
						DbSetOrder(1)
						DbSeek( xFilial("SI3") + VAI->VAI_CC )
						// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
						aAdd(aCCVend,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , (cAliasSF2)->F2_VEND1 , left(SA3->A3_NOME,17) , ( (cAliasSF2)->F2_ICMSRET ) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , Iif(lDuplic,"Ext ","Int ")+left(SI3->I3_DESC,21),0,0,0})
					Else
						aCCVend[nPos3,4] += ( (cAliasSF2)->F2_ICMSRET )
					EndIf
					nPos3 := 0
					nPos3 := aScan(aTotCCV,{|x| x[1] == Iif(lDuplic,"E","I")+VAI->VAI_CC })
					If nPos3 == 0
						// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
						aAdd(aTotCCV,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , ( (cAliasSF2)->F2_ICMSRET ) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
					Else
						aTotCCV[nPos3,2] += ( (cAliasSF2)->F2_ICMSRET )
					EndIf
				Else
					DbSelectArea( "SI3" )
					DbSetOrder(1)
					DbSeek( xFilial("SI3") + VAI->VAI_CC )
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					aAdd(aTotPag,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+VAI->VAI_CC , left(SI3->I3_DESC,14) , ( (cAliasSF2)->F2_ICMSRET  ) , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
				EndIf
			Else
				aTotPag[nPos,4] += ( (cAliasSF2)->F2_ICMSRET )
			EndIf
			// Andre Luis Almeida - 15/03/2004 - Mostrar DESPESA no Resumo p/Cond.Pagto.
			nPos := 0
			If (cAliasSF2)->F2_PREFORI == cPrefOFI // Oficina
				If Alltrim(SD2->D2_GRUPO) == "SRV"
					nPos := aScan(aPecSrvOfi,{|x| x[1]+x[2]+x[4] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + Iif(lDuplic,"Ext ","Int ")+left(STR0063,18) })
					If nPos == 0
						aAdd(aPecSrvOfi,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , ( (cAliasSF2)->F2_ICMSRET ) , Iif(lDuplic,"Ext ","Int ")+left(STR0063,18) })
					Else
						aPecSrvOfi[nPos,3] += ( (cAliasSF2)->F2_ICMSRET )
					EndIf
					nPos := 0
					nPos := aScan(aConPagNF,{|x| x[1]+x[2]+x[3]+x[4]+x[7] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE + Iif(lDuplic,"Ext ","Int ")+left(STR0063,18) })
					If nPos == 0
						DbSelectArea( "SA1" )
						DbSetOrder(1)
						DbSeek( xFilial("SA1") + (cAliasSF2)->F2_CLIENTE + (cAliasSF2)->F2_LOJA )
						aAdd(aConPagNF,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , (cAliasSF2)->F2_DOC , (cAliasSF2)->F2_SERIE , left(SA1->A1_NOME,10) , ( (cAliasSF2)->F2_ICMSRET ) , Iif(lDuplic,"Ext ","Int ")+left(STR0063,18) })
					Else
						aConPagNF[nPos,6] += ( (cAliasSF2)->F2_ICMSRET )
					EndIf
				Else
					nPos := aScan(aPecSrvOfi,{|x| x[1]+x[2]+x[4] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + Iif(lDuplic,"Ext ","Int ")+left(STR0064,18) })
					If nPos == 0
						aAdd(aPecSrvOfi,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , ( (cAliasSF2)->F2_ICMSRET ) , Iif(lDuplic,"Ext ","Int ")+left(STR0064,18) })
					Else
						aPecSrvOfi[nPos,3] += ( (cAliasSF2)->F2_ICMSRET )
					EndIf
					nPos := 0
					nPos := aScan(aConPagNF,{|x| x[1]+x[2]+x[3]+x[4]+x[7] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE + Iif(lDuplic,"Ext ","Int ")+left(STR0064,18) })
					If nPos == 0
						DbSelectArea( "SA1" )
						DbSetOrder(1)
						DbSeek( xFilial("SA1") + (cAliasSF2)->F2_CLIENTE + (cAliasSF2)->F2_LOJA )
						aAdd(aConPagNF,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , (cAliasSF2)->F2_DOC , (cAliasSF2)->F2_SERIE , left(SA1->A1_NOME,10) , ( (cAliasSF2)->F2_ICMSRET ) , Iif(lDuplic,"Ext ","Int ")+left(STR0064,18) })
					Else
						aConPagNF[nPos,6] += ( (cAliasSF2)->F2_ICMSRET )
					EndIf
				EndIf
			ElseIf (cAliasSF2)->F2_PREFORI == cPrefBAL // BALCAO
				nPos := aScan(aPecSrvOfi,{|x| x[1]+x[2]+x[4] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + Iif(lDuplic,"Ext ","Int ")+left(STR0065,18) })
				If nPos == 0
					aAdd(aPecSrvOfi,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , ( (cAliasSF2)->F2_ICMSRET ) , Iif(lDuplic,"Ext ","Int ")+left(STR0065,18) })
				Else
					aPecSrvOfi[nPos,3] += ( (cAliasSF2)->F2_ICMSRET )
				EndIf
				nPos := aScan(aConPagNF,{|x| x[1]+x[2]+x[3]+x[4]+x[7] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE + Iif(lDuplic,"Ext ","Int ")+left(STR0065,18) })
				If nPos == 0
					DbSelectArea( "SA1" )
					DbSetOrder(1)
					DbSeek( xFilial("SA1") + (cAliasSF2)->F2_CLIENTE + (cAliasSF2)->F2_LOJA )
					aAdd(aConPagNF,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , (cAliasSF2)->F2_DOC , (cAliasSF2)->F2_SERIE , left(SA1->A1_NOME,10) , ( (cAliasSF2)->F2_ICMSRET ) , Iif(lDuplic,"Ext ","Int ")+left(STR0065,18) })
				Else
					aConPagNF[nPos,6] += ( (cAliasSF2)->F2_ICMSRET )
				EndIf
			Else
				nPos := aScan(aConPagNF,{|x| x[1]+x[2]+x[3]+x[4]+x[7] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE + "1" })
				If nPos == 0
					DbSelectArea( "SA1" )
					DbSetOrder(1)
					DbSeek( xFilial("SA1") + (cAliasSF2)->F2_CLIENTE + (cAliasSF2)->F2_LOJA )
					aAdd(aConPagNF,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , (cAliasSF2)->F2_DOC , (cAliasSF2)->F2_SERIE , left(SA1->A1_NOME,10) , ( (cAliasSF2)->F2_ICMSRET ) , "1" })
				Else
					aConPagNF[nPos,6] += ( (cAliasSF2)->F2_ICMSRET )
				EndIf
			EndIf
		EndIf
		
		Do Case
			
			Case (cAliasSF2)->F2_PREFORI == cPrefVEI  //  V E I C U L O S
				aICMRET[2,2] += ( (cAliasSF2)->F2_ICMSRET )	//
				
			Case (cAliasSF2)->F2_PREFORI == cPrefBAL  //  B A L C A O
				aICMRET[3,2] += ( (cAliasSF2)->F2_ICMSRET )	//
				
			Case (cAliasSF2)->F2_PREFORI == cPrefOFI  //  O F I C I N A
				aICMRET[4,2] += ( (cAliasSF2)->F2_ICMSRET )	//
				
			Otherwise
				DbSelectArea("SF2")
				nSavRF2 := recno()
				If DbSeek(xFilial("SF2")+cNFSORI+cSERORI)
					If (cAliasSF2)->F2_PREFORI == cPrefVEI  //  V E I C U L O S
						Dbgoto(nSavRF2)
						aICMRET[2,2] += ( (cAliasSF2)->F2_ICMSRET )	//
					Elseif (cAliasSF2)->F2_PREFORI == cPrefBAL //  B A L C A O
						Dbgoto(nSavRF2)
						aICMRET[3,2] += ( (cAliasSF2)->F2_ICMSRET )	//
					Elseif (cAliasSF2)->F2_PREFORI == cPrefOFI //  O F I C I N A
						Dbgoto(nSavRF2)
						aICMRET[4,2] += ( (cAliasSF2)->F2_ICMSRET )	//
					Endif
				Endif
				Dbgoto(nSavRF2)
				
				
				
		EndCase
		
	EndIf
	
	///////////////////////////////////////////////////////////////////////////
	
	DbSelectArea( "VV0" )	//	VEICULOS
	DbSetOrder(4)
	If DbSeek( xFilial("VV0") + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE )
		dbSelectArea(cAliasSF2)
		(cAliasSF2)->(Dbskip())
		loop
	EndIf
	
	DbSelectArea( "VSC" )	//	SERVICOS
	DbSetOrder(6)
	If DbSeek( xFilial("VSC") + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE )
		dbSelectArea(cAliasSF2)
		(cAliasSF2)->(Dbskip())
		loop
	EndIf
	
	cQuery := "SELECT SD2.D2_GRUPO,SD2.D2_DOC,SD2.D2_SERIE,SD2.D2_NFORI,SD2.D2_SERIORI,SD2.D2_TES,SD2.D2_EMISSAO,SD2.D2_DESPESA,SD2.D2_VALFRE,SD2.D2_SEGURO,SD2.D2_VALISS,SD2.D2_TOTAL,SD2.D2_VALIPI,SD2.D2_CUSTO1,SD2.D2_CLIENTE,SD2.D2_LOJA,SD2.D2_ITEM "
	cQuery += "FROM "
	cQuery += RetSqlName( "SD2" ) + " SD2 "
	cQuery += "WHERE "
	cQuery += "SD2.D2_FILIAL='"+ xFilial("SD2")+ "' AND SD2.D2_DOC = '"+(cAliasSF2)->(F2_DOC)+"' AND SD2.D2_SERIE = '"+(cAliasSF2)->(F2_SERIE)+"' AND "
	cQuery += "SD2.D_E_L_E_T_=' '"
	
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSD2a, .T., .T. )
	
	//	While !((cAliasSD2)->(Eof()))
	
	DbSelectArea( "VEC" )	//	PECAS
	DbSetOrder(4)
	If DbSeek( xFilial("VEC") + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE )
		If (cAliasSD2a)->D2_VALISS == 0
			dbSelectArea(cAliasSF2)
			(cAliasSF2)->(Dbskip())
			(cAliasSD2a)->(DBCloseArea())
			loop
		EndIf
	EndIf
	
	cSF2Soma := "nao"
	
	DbSelectArea( "SD2" )
	
	While !((cAliasSD2a)->(Eof()))
		
		DbSelectArea( "SF4" )
		DbSetOrder(1)
		DbSeek( xFilial("SF4") + (cAliasSD2a)->D2_TES )
		If SF4->F4_DUPLIC # "S" .and. SF4->F4_OPEMOV # "05"
			dbSelectArea(cAliasSD2a)
			(cAliasSD2a)->(Dbskip())
			loop
		EndIf

		DbSelectArea("SFT")
		DbSetOrder(1)
		DbSeek(xFilial("SFT")+ "S" + (cAliasSD2a)->D2_SERIE + (cAliasSD2a)->D2_DOC + (cAliasSD2a)->D2_CLIENTE + (cAliasSD2a)->D2_LOJA + (cAliasSD2a)->D2_ITEM)
		
		If Alltrim(SF4->F4_ATUATF) == "S"    //  A T I V O   I M O B I L I Z A D O
			aTotAtiMob[1,3] += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
			aTotAtiMob[1,8] += (cAliasSD2a)->D2_CUSTO1
			aTotAtiMob[3,3] += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
			aTotAtiMob[3,8] += (cAliasSD2a)->D2_CUSTO1
			aAdd(aNumAtiMob,{ "O" , STR0057 , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , 0 , 0 , 0 , 0 , (cAliasSD2a)->D2_CUSTO1 })
		Else
			If SFT->FT_VALIMP5 > 0 .AND. SFT->FT_VALIMP6 > 0
				nPisOOpe := nPis
				nCofOOpe := nCofins
			Else
				nPisOOpe := 0
				nCofOOpe := 0
			EndIf
			If (cAliasSF2)->F2_TIPO == "C" .and. (cAliasSF2)->F2_PREFORI == cPrefVEI // VEICULOS
				DbSelectArea("VV0")
				DbSetOrder(4)
				DbSeek( xFilial("VV0") + (cAliasSD2a)->D2_NFORI + (cAliasSD2a)->D2_SERIORI )
				DbSelectArea( "VVA" )
				DbSetOrder(1)
				DbSeek( xFilial("VVA") + VV0->VV0_NUMTRA )
				DbSelectArea( "VV1" )
				DbSetOrder(2)
				DbSeek( xFilial("VV1") + VVA->VVA_CHASSI )
				DbSelectArea("VV2")
				DbSetOrder(1)
				DbSeek(xFilial("VV2") + VV1->VV1_CODMAR + VV1->VV1_MODVEI )
				nPos := 0
				If ( MV_PAR05 == 1 .or. ( MV_PAR05 == 2 .and. MV_PAR04 # 3 .and. MV_PAR04 # 4 ))
					nPos := aScan(aNumVei,{|x| x[1] + x[2] + x[3] == Alltrim(VV1->VV1_PROVEI) + Alltrim(VV0->VV0_TIPFAT) + VV2->VV2_DESMOD })
				Else
					DbSelectArea( "SA1" )
					DbSetOrder(1)
					//DbSeek( xFilial("SA1") + VV1->VV1_PROATU + VV1->VV1_LJPATU ) 16/03/2009 - Alterado por Otavio e Silvania
					DbSeek( xFilial("SA1") + (cAliasSF2)->F2_CLIENTE + (cAliasSF2)->F2_LOJA )
					//cCliente := VV1->VV1_PROATU + " " + left(SA1->A1_NOME,15) 16/03/2009 - Alterado por Otavio e Silvania
					cCliente := (cAliasSF2)->F2_CLIENTE + " " + left(SA1->A1_NOME,15)
					nPos := aScan(aNumVei,{|x| x[1] + x[2] + x[3] == Alltrim(VV1->VV1_PROVEI) + Alltrim(VV0->VV0_TIPFAT) + cCliente })
				EndIf
				If nPos == 0
					If ( MV_PAR05 == 1 .or. ( MV_PAR05 == 2 .and. MV_PAR04 # 3 .and. MV_PAR04 # 4 ))
						if SFT->FT_VALICM > 0
							aAdd(aNumVei,{ Alltrim(VV1->VV1_PROVEI) , Alltrim(VV0->VV0_TIPFAT) , VV2->VV2_DESMOD , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , Iif(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe) , Iif(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0) , (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) , (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe) , (cAliasSD2a)->D2_CUSTO1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , VV1->VV1_MODVEI , 0 , 0 , 0 })
						Else
							aAdd(aNumVei,{ Alltrim(VV1->VV1_PROVEI) , Alltrim(VV0->VV0_TIPFAT) , VV2->VV2_DESMOD , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe) , 0 , (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) , (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe) , (cAliasSD2a)->D2_CUSTO1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , VV1->VV1_MODVEI , 0 , 0 , 0 })
						Endif
					Else
						if SFT->FT_VALICM > 0
							aAdd(aNumVei,{ Alltrim(VV1->VV1_PROVEI) , Alltrim(VV0->VV0_TIPFAT) , cCliente , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , Iif(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe) , Iif(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0) , (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) , (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe) , (cAliasSD2a)->D2_CUSTO1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , VV1->VV1_MODVEI , 0 , 0 , 0 })
						Else
							aAdd(aNumVei,{ Alltrim(VV1->VV1_PROVEI) , Alltrim(VV0->VV0_TIPFAT) , cCliente , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe) , 0 , (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) , (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe) , (cAliasSD2a)->D2_CUSTO1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , VV1->VV1_MODVEI , 0 , 0 , 0 })
						Endif
					EndIf
				Else
					aNumVei[nPos,4] += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
					if SFT->FT_VALICM > 0
						aNumVei[nPos,5] += Iif(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
						aNumVei[nPos,6] += Iif(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0)
					Else
						aNumVei[nPos,5] += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
						//						aNumVei[nPos,6] += If(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0)
					Endif
					aNumVei[nPos,7] += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe)
					aNumVei[nPos,8] += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
					aNumVei[nPos,9] += (cAliasSD2a)->D2_CUSTO1
					aNumVei[nPos,18]++
				EndIf
				nPos := 0
				nPos := aScan(aGrpVei,{|x| x[1] + x[2] == Alltrim(VV1->VV1_PROVEI) + Alltrim(VV0->VV0_TIPFAT) })
				If nPos == 0
					if SFT->FT_VALICM > 0
						aAdd(aGrpVei,{ Alltrim(VV1->VV1_PROVEI) , Alltrim(VV0->VV0_TIPFAT) , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , Iif(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe) , Iif(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0) , (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) , (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe) , (cAliasSD2a)->D2_CUSTO1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 })
					Else
						aAdd(aGrpVei,{ Alltrim(VV1->VV1_PROVEI) , Alltrim(VV0->VV0_TIPFAT) , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe) , 0 , (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) , (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe) , (cAliasSD2a)->D2_CUSTO1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 })
					Endif
				Else
					aGrpVei[nPos,3] += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
					if SFT->FT_VALICM > 0
						aGrpVei[nPos,4] += Iif(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
						aGrpVei[nPos,5] += Iif(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0)
					Else
						aGrpVei[nPos,4] +=  (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
						//						aGrpVei[nPos,5] += If(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0)
					Endif
					aGrpVei[nPos,6] += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe)
					aGrpVei[nPos,7] += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
					aGrpVei[nPos,8] += (cAliasSD2a)->D2_CUSTO1
					aGrpVei[nPos,17]++
				EndIf
				aTotVei[1,1] += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
				if SFT->FT_VALICM > 0
					aTotVei[1,2] += Iif(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
					aTotVei[1,3] += Iif(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0)
				Else
					aTotVei[1,2] += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
					//					aTotVei[1,3] += If(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0)
				Endif
				aTotVei[1,4] += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe)
				aTotVei[1,5] += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
				aTotVei[1,6] += (cAliasSD2a)->D2_CUSTO1
				aTotal[1,1]  += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
				if SFT->FT_VALICM > 0
					aTotal[1,2]  += Iif(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
					aTotal[1,3]  += Iif(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0)
				Else
					aTotal[1,2]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
					//					aTotal[1,3]  += If(cSF2Soma=="nao",(cAliasSF2)->F2_VALICM,0)
				Endif
				aTotal[1,5]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe)
				aTotal[1,6]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
				aTotal[1,7]  += (cAliasSD2a)->D2_CUSTO1
			EndIf
			If cSF2Soma == "nao"
				cSF2Soma := "sim"
				If (cAliasSF2)->F2_TIPO # "C" .or. (cAliasSF2)->F2_PREFORI # cPrefVEI // DIFERENTE DE VEICULOS
					if SFT->FT_VALICM > 0
						aTotOOpe[1,2] += iif((cAliasSF2)->F2_VALISS>0,(cAliasSF2)->F2_VALISS,((cAliasSF2)->F2_VALICM + (cAliasSF2)->F2_VALISS))
						aTotOOpe[1,3] += iif((cAliasSF2)->F2_VALISS>0,0,(cAliasSF2)->F2_VALICM)
					Else
						aTotOOpe[1,2] += iif((cAliasSF2)->F2_VALISS>0,(cAliasSF2)->F2_VALISS,((cAliasSF2)->F2_VALISS))
						//						aTotOOpe[1,3] += if((cAliasSF2)->F2_VALISS>0,0,(cAliasSF2)->F2_VALICM)
					Endif
					If (cAliasSF2)->F2_TIPO # "I"
						aTotOOpe[1,4] += (cAliasSF2)->F2_VALISS
					Endif
				EndIf
				If MV_PAR06 # 1
					nPos := 0
					nPos := aScan(aGrpPag,{|x| x[1] == (cAliasSF2)->F2_COND })
					//If nPos == 0
					//	DbSelectArea( "SE4" )
					//	DbSetOrder(1)
					//	DbSeek( xFilial("SE4") + (cAliasSF2)->F2_COND )
					//	// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
					//	if SFT->FT_VALICM > 0
					//		aAdd(aGrpPag,{ (cAliasSF2)->F2_COND , SE4->E4_DESCRI , 0 , ((cAliasSF2)->F2_VALICM + (cAliasSF2)->F2_VALISS) , (cAliasSF2)->F2_VALICM , (cAliasSF2)->F2_VALISS , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
					//	Else
					//		aAdd(aGrpPag,{ (cAliasSF2)->F2_COND , SE4->E4_DESCRI , 0 , ((cAliasSF2)->F2_VALISS) , 0 , (cAliasSF2)->F2_VALISS , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
					//	Endif
					//Else
						if SFT->FT_VALICM > 0
							aGrpPag[nPos,4] += ((cAliasSF2)->F2_VALICM + (cAliasSF2)->F2_VALISS)
							aGrpPag[nPos,5] += (cAliasSF2)->F2_VALICM
						Else
							aGrpPag[nPos,4] += ((cAliasSF2)->F2_VALISS)
						Endif
						aGrpPag[nPos,6] += (cAliasSF2)->F2_VALISS
					//EndIf
					DbSelectArea( "VAI" )
					DbSetOrder(6)
					DbSeek( xFilial("VAI") + (cAliasSF2)->F2_VEND1 )
					nPos := 0
					If MV_PAR06 # 3
						nPos := aScan(aTotPag,{|x| x[1]+x[2] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+(cAliasSF2)->F2_VEND1 })
					Else
						nPos := aScan(aTotPag,{|x| x[1]+x[2] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+VAI->VAI_CC })
					EndIf
					If nPos == 0 .or. MV_PAR06 == 4
						//If MV_PAR06 # 3
							DbSelectArea( "SA3" )
							DbSetOrder(1)
							DbSeek( xFilial("SA3") + VAI->VAI_CODVEN )
							// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
							if SFT->FT_VALICM > 0
								aAdd(aTotPag,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+(cAliasSF2)->F2_VEND1 , left(SA3->A3_NOME,17) , 0 , ((cAliasSF2)->F2_VALICM + (cAliasSF2)->F2_VALISS) , (cAliasSF2)->F2_VALICM , (cAliasSF2)->F2_VALISS , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
							Else
								aAdd(aTotPag,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+(cAliasSF2)->F2_VEND1 , left(SA3->A3_NOME,17) , 0 , ((cAliasSF2)->F2_VALISS) , 0 , (cAliasSF2)->F2_VALISS , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
							Endif
							
							nPos3 := 0
							nPos3 := aScan(aCCVend,{|x| x[1]+x[2] == Iif(lDuplic,"E","I")+VAI->VAI_CC + (cAliasSF2)->F2_VEND1 })
							//If nPos3 == 0
							//	DbSelectArea( "SI3" )
							//	DbSetOrder(1)
							//	DbSeek( xFilial("SI3") + VAI->VAI_CC )
							//	// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
							//	if SFT->FT_VALICM > 0
							//		aAdd(aCCVend,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , (cAliasSF2)->F2_VEND1 , left(SA3->A3_NOME,17) , 0 , ((cAliasSF2)->F2_VALICM + (cAliasSF2)->F2_VALISS) , (cAliasSF2)->F2_VALICM , (cAliasSF2)->F2_VALISS , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , Iif(lDuplic,"Ext ","Int ")+left(SI3->I3_DESC,21),0,0,0})
							//	Else
							//		aAdd(aCCVend,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , (cAliasSF2)->F2_VEND1 , left(SA3->A3_NOME,17) , 0 , ((cAliasSF2)->F2_VALISS) , 0 , (cAliasSF2)->F2_VALISS , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , Iif(lDuplic,"Ext ","Int ")+left(SI3->I3_DESC,21),0,0,0})
							//	Endif
							//Else
								if SFT->FT_VALICM > 0
									aCCVend[nPos3,5]  += ((cAliasSF2)->F2_VALICM + (cAliasSF2)->F2_VALISS)
									aCCVend[nPos3,6]  += (cAliasSF2)->F2_VALICM
								Else
									aCCVend[nPos3,5]  += ((cAliasSF2)->F2_VALISS)
									//									aCCVend[nPos3,6]  += (cAliasSF2)->F2_VALICM
								Endif
								aCCVend[nPos3,7]  += (cAliasSF2)->F2_VALISS
							//EndIf
							nPos3 := 0
							nPos3 := aScan(aTotCCV,{|x| x[1] == Iif(lDuplic,"E","I")+VAI->VAI_CC })
							//If nPos3 == 0
							//	// Manoel - 22/03/2005 - Inserir aqui, levantamento do Prazo medio
							//	if SFT->FT_VALICM > 0
							//		aAdd(aTotCCV,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , 0 , ((cAliasSF2)->F2_VALICM + (cAliasSF2)->F2_VALISS) , (cAliasSF2)->F2_VALICM , (cAliasSF2)->F2_VALISS , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
							//	Else
							//		aAdd(aTotCCV,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , 0 , ((cAliasSF2)->F2_VALISS) , 0 , (cAliasSF2)->F2_VALISS , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
							//	Endif
							//	//
							//Else
								if SFT->FT_VALICM > 0
									aTotCCV[nPos3,3]  += ((cAliasSF2)->F2_VALICM + (cAliasSF2)->F2_VALISS)
									aTotCCV[nPos3,4]  += (cAliasSF2)->F2_VALICM
								Else
									aTotCCV[nPos3,3]  += ((cAliasSF2)->F2_VALISS)
									//									aTotCCV[nPos3,4]  += (cAliasSF2)->F2_VALICM
								Endif
								aTotCCV[nPos3,5]  += (cAliasSF2)->F2_VALISS
							//EndIf
						//Else
						//	DbSelectArea( "SI3" )
						//	DbSetOrder(1)
						//	DbSeek( xFilial("SI3") + VAI->VAI_CC )
						//	// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
						//	if SFT->FT_VALICM > 0
						//		aAdd(aTotPag,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+VAI->VAI_CC , left(SI3->I3_DESC,14) , 0 , ((cAliasSF2)->F2_VALICM + (cAliasSF2)->F2_VALISS) , (cAliasSF2)->F2_VALICM , (cAliasSF2)->F2_VALISS , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
						//	Else
						//		aAdd(aTotPag,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+VAI->VAI_CC , left(SI3->I3_DESC,14) , 0 , ((cAliasSF2)->F2_VALISS) ,0 , (cAliasSF2)->F2_VALISS , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
						//	Endif
						//EndIf
					Else
						if SFT->FT_VALICM > 0
							aTotPag[nPos,5]  += ((cAliasSF2)->F2_VALICM + (cAliasSF2)->F2_VALISS)
							aTotPag[nPos,6]  += (cAliasSF2)->F2_VALICM
						Else
							aTotPag[nPos,5]  += ((cAliasSF2)->F2_VALISS)
							//							aTotPag[nPos,6]  += (cAliasSF2)->F2_VALICM
						Endif
						aTotPag[nPos,7]  += (cAliasSF2)->F2_VALISS
					EndIf
					
				EndIf
				If (cAliasSF2)->F2_TIPO # "C" .or. (cAliasSF2)->F2_PREFORI # cPrefVEI // Diferente de VEICULOS
					If (cAliasSD2a)->D2_VALISS > 0	//  S E R V I C O S
						aOOpeSrv[1,2]  += (cAliasSF2)->F2_VALISS
						aOOpeSrv[1,4]  += (cAliasSF2)->F2_VALISS
					Else					// O U T R O S
						if SFT->FT_VALICM > 0
							DbSelectArea( "VV0" )
							DbSetOrder(4)
							DbSeek( xFilial("VV0") + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE)
							If (cAliasSD2a)->D2_GRUPO == "VEI "
								If VV0->VV0_TIPFAT == "1"
									aOOpeOutU[1,2]  += ((cAliasSF2)->F2_VALICM + (cAliasSF2)->F2_VALISS)
									aOOpeOutU[1,3]  += (cAliasSF2)->F2_VALICM
								Else
									aOOpeOutV[1,2]  += ((cAliasSF2)->F2_VALICM + (cAliasSF2)->F2_VALISS)
									aOOpeOutV[1,3]  += (cAliasSF2)->F2_VALICM
								Endif
							Else
								aOOpeOut[1,2]  += ((cAliasSF2)->F2_VALICM + (cAliasSF2)->F2_VALISS)
								aOOpeOut[1,3]  += (cAliasSF2)->F2_VALICM
							Endif
						Else
							If (cAliasSD2a)->D2_GRUPO == "VEI "
								DbSelectArea( "VV0" )
								DbSetOrder(4)
								DbSeek( xFilial("VV0") + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE)
								If VV0->VV0_TIPFAT == "1"
									aOOpeOutU[1,2]  += ((cAliasSF2)->F2_VALISS)
								Else
									aOOpeOutV[1,2]  += ((cAliasSF2)->F2_VALISS)
								Endif
								//							aOOpeOut[1,3]  += (cAliasSF2)->F2_VALICM
							Else
								aOOpeOut[1,2]  += ((cAliasSF2)->F2_VALISS)
								//							aOOpeOut[1,3]  += (cAliasSF2)->F2_VALICM
							Endif
						Endif
					EndIf
				EndIf
			EndIf
			
			If (cAliasSF2)->F2_TIPO # "C" .or. (cAliasSF2)->F2_PREFORI # cPrefVEI // Diferente de VEICULOS
				If (cAliasSF2)->F2_TIPO # "I"
					aTotOOpe[1,2] += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
					aTotOOpe[1,5] += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe)
					aTotOOpe[1,6] += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
				Endif
			EndIf
			If MV_PAR06 # 1
				nPos := 0
				nPos := aScan(aGrpPag,{|x| x[1] == (cAliasSF2)->F2_COND })
				If nPos > 0
					aGrpPag[nPos,4] += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
					aGrpPag[nPos,7] += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe)
					aGrpPag[nPos,8] += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
				EndIf
				nPos := 0
				If MV_PAR06 # 3
					nPos := aScan(aTotPag,{|x| x[1]+x[2] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+(cAliasSF2)->F2_VEND1 })
				Else
					nPos := aScan(aTotPag,{|x| x[1]+x[2] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+VAI->VAI_CC })
				EndIf
				If nPos > 0
					aTotPag[nPos,5] += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
					aTotPag[nPos,8] += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe)
					aTotPag[nPos,9] += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
					If MV_PAR06 # 3
						nPos3 := 0
						nPos3 := aScan(aCCVend,{|x| x[1]+x[2] == Iif(lDuplic,"E","I")+VAI->VAI_CC + (cAliasSF2)->F2_VEND1 })
						If nPos3 > 0
							aCCVend[nPos3,5]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
							aCCVend[nPos3,8]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe)
							aCCVend[nPos3,9]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
						EndIf
						nPos3 := 0
						nPos3 := aScan(aTotCCV,{|x| x[1] == Iif(lDuplic,"E","I")+VAI->VAI_CC })
						If nPos3 > 0
							aTotCCV[nPos3,3]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
							aTotCCV[nPos3,6]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe)
							aTotCCV[nPos3,7]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
						EndIf
					EndIf
				EndIf
			EndIf
			If (cAliasSF2)->F2_TIPO # "C" .or. (cAliasSF2)->F2_PREFORI # cPrefVEI // Diferente de VEICULOS
				If (cAliasSD2a)->D2_VALISS > 0	//  S E R V I C O S
					aOOpeSrv[1,2]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
					aOOpeSrv[1,5]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe)
					aOOpeSrv[1,6]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
				Else					// O U T R O S
					If (cAliasSF2)->F2_TIPO # "I"
						If (cAliasSD2a)->D2_GRUPO == "VEI "
							DbSelectArea( "VV0" )
							DbSetOrder(4)
							DbSeek( xFilial("VV0") + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE)
							If VV0->VV0_TIPFAT == "1"
								aOOpeOutU[1,2]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
								aOOpeOutU[1,5]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe)
								aOOpeOutU[1,6]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
							Else
								aOOpeOutV[1,2]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
								aOOpeOutV[1,5]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe)
								aOOpeOutV[1,6]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
							Endif
						Else
							aOOpeOut[1,2]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe) + (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
							aOOpeOut[1,5]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nPisOOpe)
							aOOpeOut[1,6]  += (((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) * nCofOOpe)
						EndIf
					EndIf
				EndIf
			EndIf
			
			nPos := 0
			If (cAliasSF2)->F2_PREFORI == cPrefOFI // OFICINA
				
				If Alltrim((cAliasSD2a)->D2_GRUPO) == "SRV"
					nPos := aScan(aPecSrvOfi,{|x| x[1]+x[2]+x[4] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + Iif(lDuplic,"Ext ","Int ")+left(STR0063,18) })
					If nPos == 0
						aAdd(aPecSrvOfi,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , Iif(lDuplic,"Ext ","Int ")+left(STR0063,18) })
					Else
						aPecSrvOfi[nPos,3] += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
					EndIf
					nPos := 0
					nPos := aScan(aConPagNF,{|x| x[1]+x[2]+x[3]+x[4]+x[7] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE + Iif(lDuplic,"Ext ","Int ")+left(STR0063,18) })
					If nPos == 0
						DbSelectArea( "SA1" )
						DbSetOrder(1)
						DbSeek( xFilial("SA1") + (cAliasSF2)->F2_CLIENTE + (cAliasSF2)->F2_LOJA )
						aAdd(aConPagNF,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , (cAliasSF2)->F2_DOC , (cAliasSF2)->F2_SERIE , left(SA1->A1_NOME,10) , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , Iif(lDuplic,"Ext ","Int ")+left(STR0063,18) })
					Else
						aConPagNF[nPos,6] += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
					EndIf
				Else
					nPos := aScan(aPecSrvOfi,{|x| x[1]+x[2]+x[4] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + Iif(lDuplic,"Ext ","Int ")+left(STR0064,18) })
					If nPos == 0
						aAdd(aPecSrvOfi,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , Iif(lDuplic,"Ext ","Int ")+left(STR0064,18) })
					Else
						aPecSrvOfi[nPos,3] += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
					EndIf
					nPos := 0
					nPos := aScan(aConPagNF,{|x| x[1]+x[2]+x[3]+x[4]+x[7] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE + Iif(lDuplic,"Ext ","Int ")+left(STR0064,18) })
					If nPos == 0
						DbSelectArea( "SA1" )
						DbSetOrder(1)
						DbSeek( xFilial("SA1") + (cAliasSF2)->F2_CLIENTE + (cAliasSF2)->F2_LOJA )
						aAdd(aConPagNF,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , (cAliasSF2)->F2_DOC , (cAliasSF2)->F2_SERIE , left(SA1->A1_NOME,10) , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , Iif(lDuplic,"Ext ","Int ")+left(STR0064,18) })
					Else
						aConPagNF[nPos,6] += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
					EndIf
				EndIf
				
			ElseIf (cAliasSF2)->F2_PREFORI == cPrefBAL // BALCAO
				
				nPos := aScan(aPecSrvOfi,{|x| x[1]+x[2]+x[4] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + Iif(lDuplic,"Ext ","Int ")+left(STR0065,18) })
				If nPos == 0
					aAdd(aPecSrvOfi,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , Iif(lDuplic,"Ext ","Int ")+left(STR0065,18) })
				Else
					aPecSrvOfi[nPos,3] += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
				EndIf
				nPos := aScan(aConPagNF,{|x| x[1]+x[2]+x[3]+x[4]+x[7] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE + Iif(lDuplic,"Ext ","Int ")+left(STR0065,18) })
				If nPos == 0
					DbSelectArea( "SA1" )
					DbSetOrder(1)
					DbSeek( xFilial("SA1") + (cAliasSF2)->F2_CLIENTE + (cAliasSF2)->F2_LOJA )
					aAdd(aConPagNF,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , (cAliasSF2)->F2_DOC , (cAliasSF2)->F2_SERIE , left(SA1->A1_NOME,10) , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , Iif(lDuplic,"Ext ","Int ")+left(STR0065,18) })
				Else
					aConPagNF[nPos,6] += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
				EndIf
				
			Else
				
				nPos := aScan(aConPagNF,{|x| x[1]+x[2]+x[3]+x[4]+x[7] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE + "1" })
				If nPos == 0
					DbSelectArea( "SA1" )
					DbSetOrder(1)
					DbSeek( xFilial("SA1") + (cAliasSF2)->F2_CLIENTE + (cAliasSF2)->F2_LOJA )
					aAdd(aConPagNF,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,(cAliasSF2)->F2_VEND1,VAI->VAI_CC) , (cAliasSF2)->F2_DOC , (cAliasSF2)->F2_SERIE , left(SA1->A1_NOME,10) , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , "1" })
				Else
					aConPagNF[nPos,6] += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
				EndIf
				
			EndIf
			
			If (cAliasSF2)->F2_TIPO # "C" .or. (cAliasSF2)->F2_PREFORI # cPrefVEI // Diferente de VEICULOS
				If (cAliasSF2)->F2_TIPO # "I"
					aTotOOpe[1,1]  += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
					aTotOOpe[1,7]  += (cAliasSD2a)->D2_CUSTO1
				EndIf
			EndIf
			
			If MV_PAR06 # 1
				
				nPos := 0
				nPos := aScan(aGrpPag,{|x| x[1] == (cAliasSF2)->F2_COND })
				//If nPos == 0
				//	DbSelectArea( "SE4" )
				//	DbSetOrder(1)
				//	DbSeek( xFilial("SE4") + (cAliasSF2)->F2_COND )
				//	// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
				//	aAdd(aGrpPag,{ (cAliasSF2)->F2_COND , SE4->E4_DESCRI , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , 0 , 0 , 0 , 0 , 0 , (cAliasSD2a)->D2_CUSTO1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
				//Else
					aGrpPag[nPos,3] += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
					aGrpPag[nPos,9] += (cAliasSD2a)->D2_CUSTO1
				//EndIf
				
				nPos := 0
				
				DbSelectArea( "VAI" )
				DbSetOrder(6)
				DbSeek( xFilial("VAI") + (cAliasSF2)->F2_VEND1 )
				
				If MV_PAR06 # 3
					nPos := aScan(aTotPag,{|x| x[1]+x[2] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+(cAliasSF2)->F2_VEND1 })
				Else
					nPos := aScan(aTotPag,{|x| x[1]+x[2] == (cAliasSF2)->F2_COND + Iif(lDuplic,"E","I")+VAI->VAI_CC })
				EndIf
				
				If nPos == 0 .or. MV_PAR06 == 4
					If MV_PAR06 # 3
						DbSelectArea( "SA3" )
						DbSetOrder(1)
						DbSeek( xFilial("SA3") + VAI->VAI_CODVEN )
						// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
						aAdd(aTotPag,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+(cAliasSF2)->F2_VEND1 , left(SA3->A3_NOME,17) , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , 0 , 0 , 0 , 0 , 0 , (cAliasSD2a)->D2_CUSTO1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
						nPos3 := 0
						nPos3 := aScan(aCCVend,{|x| x[1]+x[2] == Iif(lDuplic,"E","I")+VAI->VAI_CC + (cAliasSF2)->F2_VEND1 })
						If nPos3 == 0
							DbSelectArea( "SI3" )
							DbSetOrder(1)
							DbSeek( xFilial("SI3") + VAI->VAI_CC )
							// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
							aAdd(aCCVend,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , (cAliasSF2)->F2_VEND1 , left(SA3->A3_NOME,17) , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , 0 , 0 , 0 , 0 , 0 , (cAliasSD2a)->D2_CUSTO1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , Iif(lDuplic,"Ext ","Int ")+left(SI3->I3_DESC,21),0,0,0})
						Else
							aCCVend[nPos3,4]  += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
							aCCVend[nPos3,10] += (cAliasSD2a)->D2_CUSTO1
						EndIf
						nPos3 := 0
						nPos3 := aScan(aTotCCV,{|x| x[1] == Iif(lDuplic,"E","I")+VAI->VAI_CC })
						If nPos3 == 0
							// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
							aAdd(aTotCCV,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , 0 , 0 , 0 , 0 , 0 , (cAliasSD2a)->D2_CUSTO1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
						Else
							aTotCCV[nPos3,2]  += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
							aTotCCV[nPos3,8]  += (cAliasSD2a)->D2_CUSTO1
						EndIf
					Else
						DbSelectArea( "SI3" )
						DbSetOrder(1)
						DbSeek( xFilial("SI3") + VAI->VAI_CC )
						// Manoel - 21/03/2005 - Inserir aqui, levantamento do Prazo medio
						aAdd(aTotPag,{ (cAliasSF2)->F2_COND , Iif(lDuplic,"E","I")+VAI->VAI_CC , left(SI3->I3_DESC,14) , ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI) , 0 , 0 , 0 , 0 , 0 , (cAliasSD2a)->D2_CUSTO1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 })
					EndIf
				Else
					aTotPag[nPos,4]  += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
					aTotPag[nPos,10] += (cAliasSD2a)->D2_CUSTO1
				EndIf
				
			EndIf
			
			If (cAliasSF2)->F2_TIPO # "C" .or. (cAliasSF2)->F2_PREFORI # cPrefVEI // Diferente de VEICULOS
				If (cAliasSD2a)->D2_VALISS > 0	//  S E R V I C O S
					aOOpeSrv[1,1]  += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
					aOOpeSrv[1,7]  += (cAliasSD2a)->D2_CUSTO1
				Else					// O U T R O S
					If (cAliasSF2)->F2_TIPO # "I"
						If (cAliasSD2a)->D2_GRUPO == "VEI "
							DbSelectArea( "VV0" )
							DbSetOrder(4)
							DbSeek( xFilial("VV0") + (cAliasSF2)->F2_DOC + (cAliasSF2)->F2_SERIE)
							If VV0->VV0_TIPFAT == "1"
								aOOpeOutU[1,1]  += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
								aOOpeOutU[1,7]  += (cAliasSD2a)->D2_CUSTO1
							Else
								aOOpeOutV[1,1]  += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
								aOOpeOutV[1,7]  += (cAliasSD2a)->D2_CUSTO1
							Endif
							
						Else
							aOOpeOut[1,1]  += ((cAliasSD2a)->D2_TOTAL+(cAliasSD2a)->D2_VALIPI)
							aOOpeOut[1,7]  += (cAliasSD2a)->D2_CUSTO1
						Endif
					EndIf
				EndIf
			EndIf
			
		EndIf
		
		dbSelectArea(cAliasSD2a)
		(cAliasSD2a)->(Dbskip())
	EndDo
	(cAliasSD2a)->(DBCloseArea())
	
	dbSelectArea(cAliasSF2)
	(cAliasSF2)->(Dbskip())
	
EndDo
(cAliasSF2)->(DBCloseArea())


///////////////////////////////////
//      D E V O L U C O E S      //
///////////////////////////////////

aAdd(aTotDev,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0 })   // Devolucoes - Total

cQuery := "SELECT SF1.F1_DOC,SF1.F1_SERIE,SF1.F1_DTDIGIT,SF1.F1_FORNECE,SF1.F1_LOJA,SF1.F1_TIPO "
cQuery += "FROM "
cQuery += RetSqlName( "SF1" ) + " SF1 "
cQuery += "WHERE "
cQuery += "SF1.F1_FILIAL='"+ xFilial("SF1")+ "' AND SF1.F1_DTDIGIT >= '"+dtos(mv_par01)+"' AND SF1.F1_DTDIGIT <= '"+dtos(mv_par02)+"' AND "
cQuery += "SF1.D_E_L_E_T_=' '"

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSF1, .T., .T. )

While !((cAliasSF1)->(Eof()))
	If FunName() == "OFIOR250"
		nCont ++
		If nCont == 400
			IncRegua()
			nCont := 2
			If lAbortPrint
				nLin++
				@nLin++,30 PSAY STR0058 //"* * *  C A N C E L A D O   P E L O   O P E R A D O R  * * *"
				Exit
			EndIf
		EndIf
	EndIf
	
	nDespes := 0
	If (cAliasSF1)->F1_TIPO == "D"
		
		cQuery := "SELECT SD1.D1_DOC,SD1.D1_SERIE,SD1.D1_FORNECE,SD1.D1_LOJA,SD1.D1_TES,SD1.D1_TOTAL,SD1.D1_VALIPI,SD1.D1_ICMSRET,SD1.D1_DESPESA,SD1.D1_VALDESC,SD1.D1_SEGURO,SD1.D1_VALFRE,SD1.D1_QUANT,SD1.D1_VALIMP6,SD1.D1_VALIMP5,SD1.D1_VALISS,SD1.D1_VALICM,SD1.D1_CUSTO,SD1.D1_NFORI,SD1.D1_SERIORI,SD1.D1_COD,SD1.D1_GRUPO, "
		cQuery += "SD2.D2_SERIE, SD2.D2_DOC,SD2.D2_CLIENTE,SD2.D2_LOJA,SD2.D2_ITEM "
		cQuery += "FROM "
		cQuery += RetSqlName( "SD1" ) + " SD1 "
		cQuery += "JOIN " + oSqlHlp:NoLock("SD2")
		cQuery += "ON SD2.D2_FILIAL  = '" + xFilial("SD2") + "' "
		cQuery += "AND SD1.D1_NFORI   = SD2.D2_DOC "
		cQuery += "AND SD1.D1_SERIORI = SD2.D2_SERIE "
		cQuery += "AND SD1.D1_COD     = SD2.D2_COD "
		cQuery += "AND SD1.D1_ITEMORI = SD2.D2_ITEM "
		cQuery += "AND SD2.D_E_L_E_T_ = ' ' "
		cQuery += "WHERE "
		cQuery += "SD1.D1_FILIAL='"+ xFilial("SD1")+ "' AND SD1.D1_DOC = '"+(cAliasSF1)->F1_DOC+"' AND SD1.D1_SERIE <= '"+(cAliasSF1)->F1_SERIE+"' AND "
		cQuery += "SD1.D1_FORNECE ='"+ (cAliasSF1)->F1_FORNECE+ "' AND SD1.D1_LOJA = '"+(cAliasSF1)->F1_LOJA+"' AND "
		cQuery += "SD1.D_E_L_E_T_=' '"
		
		dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSD1, .T., .T. )
		
		While !((cAliasSD1)->(Eof()))
			DbSelectArea( "SF4" )
			DbSetOrder(1)
			DbSeek( xFilial("SF4") + (cAliasSD1)->D1_TES )

			DbSelectArea("SFT")
			DbSetOrder(1)
			DbSeek(xFilial("SFT")+ "S" + (cAliasSD1)->D2_SERIE + (cAliasSD1)->D2_DOC + (cAliasSD1)->D2_CLIENTE + (cAliasSD1)->D2_LOJA + (cAliasSD1)->D2_ITEM)

			if SF4->F4_OPEMOV == "09"
				If SF4->F4_ESTOQUE == "S"
					//				nVlrDev := ( ( (cAliasSD1)->D1_TOTAL + (cAliasSD1)->D1_VALIPI + (cAliasSD1)->D1_ICMSRET + (cAliasSD1)->D1_DESPESA + (cAliasSD1)->D1_SEGURO + (cAliasSD1)->D1_VALFRE ) - (cAliasSD1)->D1_VALDESC )
					nVlrDev := ( ( (cAliasSD1)->D1_TOTAL + (cAliasSD1)->D1_VALIPI + (cAliasSD1)->D1_ICMSRET ) - (cAliasSD1)->D1_VALDESC )
					nDespes := ( (cAliasSD1)->D1_DESPESA + (cAliasSD1)->D1_SEGURO + (cAliasSD1)->D1_VALFRE )
					nQtdDev := (cAliasSD1)->D1_QUANT
					nPisDev := 0
					nCofDev := 0

					// Verifica se tem COFINS/PIS - se tem SFT->FT_VALIMP5(COF) e se tem SFT->FT_VALIMP6(PIS)
					If SFT->FT_VALIMP5 > 0 .AND. SFT->FT_VALIMP6 == 0
						nCofDev := (cAliasSD1)->D1_VALIMP5
					ElseIf SFT->FT_VALIMP5 == 0 .AND. SFT->FT_VALIMP6 > 0
						nPisDev := (cAliasSD1)->D1_VALIMP6
					ElseIf SFT->FT_VALIMP5 > 0 .AND. SFT->FT_VALIMP6 > 0
						nPisDev := (cAliasSD1)->D1_VALIMP6
						nCofDev := (cAliasSD1)->D1_VALIMP5
					EndIf

					If SFT->FT_VALICM == 0
						nImpDev := (cAliasSD1)->D1_VALISS + nPisDev + nCofDev
					Else
						if SFT->FT_VALICM > 0
							nImpDev := (cAliasSD1)->D1_VALICM + (cAliasSD1)->D1_VALISS + nPisDev + nCofDev
						Else
							nImpDev := (cAliasSD1)->D1_VALISS + nPisDev + nCofDev
						Endif
					Endif
					//				aTotDev[1,1] += (nVlrDev+nDespes) //06/11/08-Renata-retirado do total da devol
					aTotDev[1,1] += nVlrDev
					aTotDev[1,2] += nImpDev
					if SFT->FT_VALICM > 0
						aTotDev[1,3] += (cAliasSD1)->D1_VALICM
					Endif
					aTotDev[1,4] += (cAliasSD1)->D1_VALISS
					aTotDev[1,5] += nPisDev
					aTotDev[1,6] += nCofDev
					aTotDev[1,7] += (cAliasSD1)->D1_CUSTO
					//				aTotDev[1,8] += (nVlrDev+nDespes) - ( nImpDev + (cAliasSD1)->D1_CUSTO )
					aTotDev[1,8] += nVlrDev - ( nImpDev + (cAliasSD1)->D1_CUSTO ) //06/11/08-Renata-retirado do LB da devol
					//				aTotDev[1,8] += (nVlrDev) - ( nImpDev + (cAliasSD1)->D1_CUSTO )
					
					// Manoel - 9/12/2008
					// Considerando Resultado do ST na Devolucao
					
					DbSelectArea("VEC")
					DbSetOrder(4)
					DbSeek(xFilial("VEC") + (cAliasSD1)->D1_NFORI + (cAliasSD1)->D1_SERIORI)
					nResSTDv := 0 // Resultado do ST na Devolucao
					nQtdSTDv := 0 // Quantidade do Resultado do ST na Devolucao
					While !eof() .and. VEC->VEC_FILIAL+VEC->VEC_NUMNFI+VEC->VEC_SERNFI == xFilial("VEC")+(cAliasSD1)->D1_NFORI+(cAliasSD1)->D1_SERIORI
						If VEC->VEC_PECINT == (cAliasSD1)->D1_COD
							nResSTDv += (VEC->VEC_ICMSST+VEC->VEC_DCLBST+VEC->VEC_COPIST)
							nQtdSTDv += VEC->VEC_QTDITE
							exit
						Endif
						DbSKip()
					Enddo
					If nResSTDv != 0
						nResSTDv := ((nResSTDv / nQtdSTDv) ) * (cAliasSD1)->D1_QUANT
						nTResSTDv += nResSTDv
					Endif
					If Mv_Par09 == 1
						aTotPec[1,12] -= nResSTDv
					Endif
					aTotDev[1,8]  += nResSTDv
					aTotDev[1,9]  += nResSTDv
					
					DbSelectArea("SF2")
					DbSetOrder(1)
					DbSeek(xFilial("SF2") + (cAliasSD1)->D1_NFORI + (cAliasSD1)->D1_SERIORI , .f. )
					
					If Mv_Par09 == 1 // Devolucao
						aDesAce[1,2] -= nDespes
						If SF2->F2_PREFORI == cPrefBAL // BALCAO
							aDesAce[3,2] -= nDespes
						ElseIf SF2->F2_PREFORI == cPrefOFI // OFICINA
							aDesAce[4,2] -= nDespes
						Else//If SF2->F2_PREFORI == cPrefVEI // VEICULOS
							aDesAce[2,2] -= nDespes
						Endif
					Endif
					
					
					nDespes := 0 // Manoel - 26/02/08 - zerei
					
					////////// TXT com Clientes/Itens //////////
					If MV_PAR09 == 1 .and. Alltrim(SF2->F2_PREFORI) $ (cPrefBAL+"/"+cPrefOFI) // BAL/OFI -> Devolucao
						
						If SF2->F2_PREFORI == cPrefOFI // OFICINA
							DbSelectArea( "VO3" )
							DbSetOrder(5)
							DbSeek( xFilial("VO3") + (cAliasSD1)->D1_NFORI + (cAliasSD1)->D1_SERIORI , .f. )
							DbSelectArea( "VOI" )
							DbSetOrder(1)
							DbSeek( xFilial("VOI") + VO3->VO3_TIPTEM , .f. )
						Endif
						
						If FunName() == "OFIOR250"
							nMes := aScan(aTXTMes,{|x| x[1] == strzero(month(VEC->VEC_DATVEN),2)+strzero(year(VEC->VEC_DATVEN),4) })
						EndIf
						
						If SF2->F2_PREFORI == cPrefOFI // OFICINA
							nTXTVda -= nVlrDev
							nTXTLuc -= nVlrDev - ( nImpDev + (cAliasSD1)->D1_CUSTO )
							If VOI->VOI_SITTPO != "2" // se nao for garantia
								If ValType(nTXTVdaNG) == "U"
									nTXTVdaNG := 0
								Endif
								If ValType(nTXTLucNG) == "U"
									nTXTLucNG := 0
								Endif
								If ValType(nVlrDev) == "U"
									nVlrDev := 0
								Endif
								nTXTVdaNG -= nVlrDev
								nTXTLucNG -= nVlrDev - ( nImpDev + (cAliasSD1)->D1_CUSTO )
								cTipGar  := "N"
							Else
								cTipGar  := "S"
							Endif
						Else
							cTipGar  := "N"
							nTXTVda -= nVlrDev
							nTXTLuc -= nVlrDev - ( nImpDev + (cAliasSD1)->D1_CUSTO )
							nTXTVda -= nVlrDev
							nTXTLuc -= nVlrDev - ( nImpDev + (cAliasSD1)->D1_CUSTO )
						Endif
						
						//					nTXTAux1 := aScan(aTXTCli,{|x| x[1] == SF2->F2_CLIENTE + SF2->F2_LOJA + cTipGar})
						nTXTAux1 := aScan(aTXTCli,{|x| x[1] == SF2->F2_CLIENTE + SF2->F2_LOJA})
						If nTXTAux1 == 0
							//						aAdd(aTXTCli,{ SF2->F2_CLIENTE + SF2->F2_LOJA + cTipGar, (-1) * ( nVlrDev ) , space(12) , (-1) * ( nVlrDev - ( nImpDev + (cAliasSD1)->D1_CUSTO ) ) , space(12) , len(aTXTCli)+1,VOI->VOI_SITTPO })
							aAdd(aTXTCli,{ SF2->F2_CLIENTE + SF2->F2_LOJA , (-1) * ( nVlrDev ) , space(12) , (-1) * ( nVlrDev - ( nImpDev + (cAliasSD1)->D1_CUSTO ) ) , space(12) , len(aTXTCli)+1,VOI->VOI_SITTPO })
							If FunName() == "OFIOR250"
								//							If VOI->VOI_SITTPO != "2" // se nao for garantia
								aAdd(aTXTCliA,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,VOI->VOI_SITTPO})
								//								nTXTAux1 := len(aTXTCliA)
								//							Else
								aAdd(aTXTCliNG,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,VOI->VOI_SITTPO})
								//								nTXTAux1 := len(aTXTCliNG)
								//							EndIf
								nTXTAux1 := len(aTXTCli)
							EndIf
						Else
							aTXTCli[nTXTAux1,2] -= nVlrDev
							aTXTCli[nTXTAux1,4] -= nVlrDev - ( nImpDev + (cAliasSD1)->D1_CUSTO )
						EndIf
						If FunName() == "OFIOR250"
							If nMes > 0
								If VOI->VOI_SITTPO != "2" // se nao for garantia
									If Len(aTXTCliA) < nTXTAux1
										nCont := Len(aTXTCliA) + 1
										for ii := nCont to nTXTAux1
											aAdd(aTXTCliA,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
										Next
									Endif
									aTXTCliA[aTXTCli[nTXTAux1,6],nMes] -= nVlrDev
									aTXTCliA[aTXTCli[nTXTAux1,6],nMes+1] -= nVlrDev - ( nImpDev + (cAliasSD1)->D1_CUSTO )
								Else
									If Len(aTXTCliNG) < nTXTAux1
										nCont := Len(aTXTCliNG) + 1
										for ii := nCont to nTXTAux1
											aAdd(aTXTCliNG,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
										Next
									Endif
									aTXTCliNG[aTXTCli[nTXTAux1,6],nMes] -= nVlrDev
									aTXTCliNG[aTXTCli[nTXTAux1,6],nMes+1] -= nVlrDev - ( nImpDev + (cAliasSD1)->D1_CUSTO )
								EndIf
							EndIf
						EndIf
						DbSelectArea("SB1")
						DbSetOrder(1)
						DbSeek(xFilial("SB1") + (cAliasSD1)->D1_COD )
						nTXTAux1 := aScan(aTXTIte,{|x| x[1] == SB1->B1_GRUPO + SB1->B1_CODITE })
						If nTXTAux1 == 0
							aAdd(aTXTIte,{ SB1->B1_GRUPO + SB1->B1_CODITE , (-1) * ( nVlrDev ) , space(12) , (-1) * ( nVlrDev - ( nImpDev + (cAliasSD1)->D1_CUSTO ) ) , space(12) , len(aTXTIte)+1 , VOI->VOI_SITTPO,nQtdDev})
							If FunName() == "OFIOR250"
								//							If VOI->VOI_SITTPO != "2" // se nao for garantia
								aAdd(aTXTIteA,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
								//								nTXTAux1 := len(aTXTIteA)
								//							Else
								aAdd(aTXTIteNG,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
								//								nTXTAux1 := len(aTXTIteNG)
								//							EndIf
								nTXTAux1 := len(aTXTIte)
							EndIf
						Else
							aTXTIte[nTXTAux1,2] -= nVlrDev
							aTXTIte[nTXTAux1,4] -= nVlrDev - ( nImpDev + (cAliasSD1)->D1_CUSTO )
							aTXTIte[nTXTAux1,8] -= nQtdDev
						EndIf
						If FunName() == "OFIOR250"
							If nMes > 0
								If VOI->VOI_SITTPO != "2" // se nao for garantia
									If Len(aTXTIteA) < nTXTAux1
										nCont := Len(aTXTIteA) + 1
										for ii := nCont to nTXTAux1
											aAdd(aTXTIteA,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
										Next
									Endif
									aTXTIteA[aTXTIte[nTXTAux1,6],nMes] -= nVlrDev
									aTXTIteA[aTXTIte[nTXTAux1,6],nMes+1] -= nVlrDev - ( nImpDev + (cAliasSD1)->D1_CUSTO )
								Else
									If Len(aTXTIteNG) < nTXTAux1
										nCont := Len(aTXTIteNG) + 1
										for ii := nCont to nTXTAux1
											aAdd(aTXTIteNG,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
										Next
									Endif
									aTXTIteNG[aTXTIte[nTXTAux1,6],nMes] -= nVlrDev
									aTXTIteNG[aTXTIte[nTXTAux1,6],nMes+1] -= nVlrDev - ( nImpDev + (cAliasSD1)->D1_CUSTO )
								EndIf
							EndIf
						EndIf
					EndIf
					////////////////////////////////////////////
					
					cSeekDev := "00"+(cAliasSD1)->D1_GRUPO
					cDpto := "  "
					If SF2->F2_PREFORI == cPrefVEI // VEICULOS
						DbSelectArea( "VV0" )
						DbSetOrder(4)
						DbSeek( xFilial("VV0") + (cAliasSD1)->D1_NFORI + (cAliasSD1)->D1_SERIORI , .f. )
						DbSelectArea( "VVA" )
						DbSetOrder(1)
						DbSeek( xFilial("VVA") + VV0->VV0_NUMTRA , .f. )
						DbSelectArea( "VV1" )
						DbSetOrder(1)
						DbSeek( xFilial("VV1") + VVA->VVA_CHAINT , .f. )
						If Alltrim(VV1->VV1_PROVEI) + Alltrim(VV0->VV0_TIPFAT) == "10"
							cSeekDev := "01" // Nac.Novos
						ElseIf Alltrim(VV1->VV1_PROVEI) + Alltrim(VV0->VV0_TIPFAT) == "11"
							cSeekDev := "02" // Nac.Usados
						ElseIf Alltrim(VV1->VV1_PROVEI) + Alltrim(VV0->VV0_TIPFAT) == "20"
							cSeekDev := "03" // Imp.Novos
						ElseIf Alltrim(VV1->VV1_PROVEI) + Alltrim(VV0->VV0_TIPFAT) == "21"
							cSeekDev := "04" // Imp.Usados
						EndIf
						DbSelectArea("VV2")
						DbSetOrder(1)
						DbSeek(xFilial("VV2") + VV1->VV1_CODMAR + VV1->VV1_MODVEI )
						cSeekDev += VV2->VV2_DESMOD
					ElseIf SF2->F2_PREFORI == cPrefBAL // BALCAO
						cSeekDev := "10"+(cAliasSD1)->D1_GRUPO
						DbSelectArea( "VS1" )
						DbSetOrder(3)
						DbSeek( xFilial("VS1") + SF2->F2_DOC + SF2->F2_SERIE )
						cDpto := VS1->VS1_DEPTO
					ElseIf SF2->F2_PREFORI == cPrefOFI // OFICINA
						DbSelectArea( "VO3" )
						DbSetOrder(5)
						DbSeek( xFilial("VO3") + (cAliasSD1)->D1_NFORI + (cAliasSD1)->D1_SERIORI , .f. )
						DbSelectArea( "VOI" )
						DbSetOrder(1)
						DbSeek( xFilial("VOI") + VO3->VO3_TIPTEM , .f. )
						cSeekDev := "2"+VOI->VOI_SITTPO+(cAliasSD1)->D1_GRUPO
						DbSelectArea( "VOO" )
						DbSetOrder(4)
						DbSeek( xFilial("VOO") + (cAliasSD1)->D1_NFORI + (cAliasSD1)->D1_SERIORI , .f. )
						cDpto := VOO->VOO_DEPTO
					EndIf
					nPos := aScan(aNumDev,{|x| x[10]+x[12] == cSeekDev + cDpto })
					If nPos == 0
						DbSelectArea( "SBM" )
						DbSetOrder(1)
						DbSeek( xFilial("SBM") + (cAliasSD1)->D1_GRUPO , .f. )
						DBSelectArea("SF4")
						DBSetOrder(1)
						DBSeek(xFilial("SF4")+(cAliasSD1)->D1_TES)
						vD1ResEc := (cAliasSD1)->D1_TOTAL+(cAliasSD1)->D1_VALIPI+(cAliasSD1)->D1_ICMSRET+(cAliasSD1)->D1_DESPESA+(cAliasSD1)->D1_VALFRE+(cAliasSD1)->D1_SEGURO-(cAliasSD1)->D1_CUSTO
						if SFT->FT_VALICM > 0
							vD1ResEc -= (cAliasSD1)->D1_VALICM
						endif
						if SFT->FT_VALIMP5 > 0 .AND. SFT->FT_VALIMP6 > 0
							vD1ResEc -= ((cAliasSD1)->D1_VALIMP5-(cAliasSD1)->D1_VALIMP6)
						endif
						if SFT->FT_VALICM > 0
							aAdd(aNumDev,{ (cAliasSD1)->D1_GRUPO , left(SBM->BM_DESC,16) , nVlrDev , nImpDev , (cAliasSD1)->D1_VALICM , (cAliasSD1)->D1_VALISS , nPisDev , nCofDev , (cAliasSD1)->D1_CUSTO , cSeekDev , nVlrDev+nDespes - ( nImpDev + (cAliasSD1)->D1_CUSTO ) + nResSTDv, cDpto,vD1ResEc, nDespes,nResSTDv })
						Else
							aAdd(aNumDev,{ (cAliasSD1)->D1_GRUPO , left(SBM->BM_DESC,16) , nVlrDev , nImpDev , 0 , (cAliasSD1)->D1_VALISS , nPisDev , nCofDev , (cAliasSD1)->D1_CUSTO , cSeekDev , nVlrDev+nDespes - ( nImpDev + (cAliasSD1)->D1_CUSTO ) + nResSTDv, cDpto,vD1ResEc, nDespes,nResSTDv })
						Endif
					Else
						aNumDev[nPos,3] += (nVlrDev+nDespes)
						aNumDev[nPos,4] += nImpDev
						if SFT->FT_VALICM > 0
							aNumDev[nPos,5] += (cAliasSD1)->D1_VALICM
						Endif
						aNumDev[nPos,6] += (cAliasSD1)->D1_VALISS
						aNumDev[nPos,7] += nPisDev
						aNumDev[nPos,8] += nCofDev
						aNumDev[nPos,9] += (cAliasSD1)->D1_CUSTO
						aNumDev[nPos,11]+= (nVlrDev+nDespes) - ( nImpDev + (cAliasSD1)->D1_CUSTO ) + (nResSTDv)
						aNumDev[nPos,13]+= vD1ResEc
						aNumDev[nPos,15]+= nResSTDv
					EndIf
					
				EndIf
			Endif
			dbSelectArea(cAliasSD1)
			(cAliasSD1)->(Dbskip())
		EndDo
		(cAliasSD1)->(DBCloseArea())
		
	EndIf
	dbSelectArea(cAliasSF1)
	(cAliasSF1)->(Dbskip())
EndDo
(cAliasSF1)->(DBCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_OR25A ³ Autor ³ Andre Luis Almeida    ³ Data ³ 03/01/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao: Posicao das Vendas & Resultados                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_OR25A(cQual,aVet1,aVet2,aVet3,aVet4,aVet5,MV_PAR04,MV_PAR05,MV_PAR06,MV_PAR07)
Do Case
	Case cQual == "V"
		FS_OR25AV(aVet1,aVet2,aVet3)		  			//  V E I C U L O S
	Case cQual == "P"
		FS_OR25AP(aVet1,aVet2,aVet3,aVet4,aVet5)	//  P E C A S
	Case cQual == "S"
		FS_OR25AS(aVet1,aVet2,aVet3,aVet4)			//  S E R V I C O S
	Case cQual == "A"
		FS_M_OR25AA(aVet1)									//  D E S P    A C E S S O R I A S
	Case cQual == "O"
		FS_OR25AO(aVet1,aVet2,aVet3)					//  O U T R A S    V E N D A S
	Case cQual == "M"
		FS_OR25AM(aVet1,aVet2)							//  A T I V O    I M O B I L I Z A D O
	Case cQual == "D"
		FS_OR25AD(aVet1,aVet2)				 			//  D E V O L U C O E S
	Case cQual == "E"
		FS_OR25AE(aVet1,aVet2,aVet3,aVet4)			//  V A L O R E S    E N T R A D A S
	Case cQual == "C"
		FS_OR25AC(aVet1,aVet2,aVet3,aVet4,aVet5)	//  C O N D    P A G A M E N T O S
		
	Case cQual == "I"
		FS_OR25AI(aVet1)									//  I C M S   R E T I D O
		
EndCase

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_OR25AV³ Autor ³ Andre Luis Almeida    ³ Data ³ 03/01/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao: Posicao das Vendas & Resultados - VEICULOS      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_OR25AV(aTotVei,aGrpVei,aNumVei)

///////////////////////////////////
//    V  E  I  C  U  L  O  S     //
///////////////////////////////////
local ni := 0
If FunName() == "OFIOR250"
	nLin++
	
	@ nLin++ , 00 psay STR0008 + cCabVei
	cString := Transform(aTotVei[1,1],"@E 999,999,999.99") ;// Venda Total
	+ Transform(aTotVei[1,2],"@E 99999,999.99") ;	// Impostos
	+ Transform(aTotVei[1,3],"@E 99999,999.99") ;	// ICMS
	+ space(11) ;
	+ Transform(aTotVei[1,4],"@E 9999,999.99") ;	// PIS
	+ Transform(aTotVei[1,5],"@E 9999,999.99") ;	// Cofins
	+ Transform(aTotVei[1,6],"@E 99,999,999.99") ;// Custo Veic
	+ Transform(aTotVei[1,8],"@E 99,999,999.99") + Transform(((aTotVei[1,8]/aTotVei[1,1])*100),"@E 9999.9") ;// Lucro Bruto
	+ Transform(aTotVei[1,7],"@E 99,999,999.99") ;// Juro Estq
	+ Transform(aTotVei[1,9],"@E 99,999,999.99") ;// Desp Var
	+ Transform(aTotVei[1,10],"@E 99,999,999.99");// Comissoes
	+ Transform(aTotVei[1,11],"@E 99,999,999.99");// Lucro Liq
	+ Transform(aTotVei[1,12]+aTotVei[1,13],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
	+ Transform(aTotVei[1,14],"@E 99,999,999.99") ;// Resultado Final
	+ Transform(aTotVei[1,15]/aTotVei[1,16],"@E 999,999,999.9") //; // Prz Medio
	//	+ Transform((aTotVei[1,17]/aTotVei[1,1])*100,"@E 9999.9")	// % Desc
	// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
	//								+ Transform(aTotVei[1,12],"@E 99,999,999.99") ;// Cst/Dsp Fix
	//								+ Transform(aTotVei[1,13],"@E 99,999,999.99") ;// Dsp Dep/Adm
	//								+ Transform(aTotVei[1,14],"@E 99,999,999.99")  // Resultado Final
	
	@ nLin++ , 00 psay STR0009 + U_FS_ImpRM_250(cString)
	
Else
	nLin+= 3
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,STR0008 + cCabVei+CHR(13)+CHR(10))
	cString := Transform(aTotVei[1,1],"@E 999,999,999.99") ;// Venda Total
	+ Transform(aTotVei[1,2],"@E 99999,999.99") ;	// Impostos
	+ Transform(aTotVei[1,3],"@E 99999,999.99") ;	// ICMS
	+ space(11) ;
	+ Transform(aTotVei[1,4],"@E 9999,999.99") ;	// PIS
	+ Transform(aTotVei[1,5],"@E 9999,999.99") ;	// Cofins
	+ Transform(aTotVei[1,6],"@E 99,999,999.99") ;// Custo Veic
	+ Transform(aTotVei[1,8],"@E 99,999,999.99") + Transform(((aTotVei[1,8]/aTotVei[1,1])*100),"@E 9999.9") ;// Lucro Bruto
	+ Transform(aTotVei[1,7],"@E 99,999,999.99") ;// Juro Estq
	+ Transform(aTotVei[1,9],"@E 99,999,999.99") ;// Desp Var
	+ Transform(aTotVei[1,10],"@E 99,999,999.99");// Comissoes
	+ Transform(aTotVei[1,11],"@E 99,999,999.99");// Lucro Liq
	+ Transform(aTotVei[1,12]+aTotVei[1,13],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
	+ Transform(aTotVei[1,14],"@E 99,999,999.99") ;// Resultado Final
	+ Transform(aTotVei[1,15]/aTotVei[1,16],"@E 999,999,999.9")	;// Prz Medio
	+CHR(13)+CHR(10)
	//	+ Transform((aTotVei[1,17]/aTotVei[1,1])*100,"@E 9999.9")	;// % Desc
	
	fwrite(outputfile,STR0009 + U_FS_ImpRM_250(cString))
	
	// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
	//								+ Transform(aTotVei[1,12],"@E 99,999,999.99") ;// Cst/Dsp Fix
	//								+ Transform(aTotVei[1,13],"@E 99,999,999.99") ;// Dsp Dep/Adm
	//								+ Transform(aTotVei[1,14],"@E 99,999,999.99") ;// Resultado Final
	
EndIf
If MV_PAR04 >= 2
	aSort(aNumVei,1,,{|x,y| x[1]+x[2]+x[3] < y[1]+y[2]+y[3]})
	cMudou  := "9"
	cMudou2 := "9"
	For ni:=1 to Len(aNumVei)
		If FunName() == "OFIOR250"
			nCont ++
			If nCont == 400
				IncRegua()
				nCont := 2
				If lAbortPrint
					nLin++
					@nLin++,30 PSAY STR0058 //"* * *  C A N C E L A D O   P E L O   O P E R A D O R  * * *"
					Exit
				EndIf
			EndIf
		EndIf
		If nLin >= 60
			If FunName() == "OFIOR250"
				nLin := 1
				nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
				nLin++
				@ nLin++ , 27 psay cCabVei
				nLin++
			Else
				nLin := 4
				fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
				fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
				fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
				fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cFil+".##r"+CHR(13)+CHR(10))
				fwrite(outputfile," "+CHR(13)+CHR(10))
				fwrite(outputfile,space(27)+cCabVei+CHR(13)+CHR(10))
				fwrite(outputfile," "+CHR(13)+CHR(10))
			EndIf
		EndIf
		If cMudou # aNumVei[ni,1] .or. cMudou2 # aNumVei[ni,2]
			If aNumVei[ni,1] == "1" .and. aNumVei[ni,2] == "0"  			// Nacional Novo
				cTipo := STR0010
			ElseIf  aNumVei[ni,1] == "1" .and. aNumVei[ni,2] == "1" 	// Nacional Usado
				cTipo := STR0011
			ElseIf  aNumVei[ni,1] == "2" .and. aNumVei[ni,2] == "0" 	// Importado Novo
				cTipo := STR0012
			ElseIf  aNumVei[ni,1] == "2" .and. aNumVei[ni,2] == "1"		// Importado Usado
				cTipo := STR0013
			ElseIf  aNumVei[ni,1] == "8" .and. aNumVei[ni,2] == "8"		// Faturamento Direto
				cTipo := STR0062
			Else
				cTipo := STR0014
			EndIf
			cMudou  := aNumVei[ni,1]
			cMudou2 := aNumVei[ni,2]
			nPos := aScan(aGrpVei,{|x| x[1] + x[2] == cMudou + cMudou2 })
			If FunName() == "OFIOR250"
				nLin++
				cString :=       Transform(aGrpVei[nPos,3],"@E 999,999,999.99") ;	// Venda Total
				+ Transform(aGrpVei[nPos,4],"@E 99999,999.99") ;		// Impostos
				+ Transform(aGrpVei[nPos,5],"@E 99999,999.99") ;		// ICMS
				+ space(11) ;
				+ Transform(aGrpVei[nPos,6],"@E 9999,999.99") ;		// PIS
				+ Transform(aGrpVei[nPos,7],"@E 9999,999.99") ;		// Cofins
				+ Transform(aGrpVei[nPos,8],"@E 99,999,999.99") ;	// Custos
				+ Transform(aGrpVei[nPos,10],"@E 99,999,999.99") + Transform(((aGrpVei[nPos,10]/aGrpVei[nPos,3])*100),"@E 9999.9") ; // Lucro Bruto
				+ Transform(aGrpVei[nPos,9],"@E 99,999,999.99") ;	// Juro Estoque
				+ Transform(aGrpVei[nPos,11],"@E 99,999,999.99") ;	// Desp Var
				+ Transform(aGrpVei[nPos,12],"@E 99,999,999.99") ;	// Comissoes
				+ Transform(aGrpVei[nPos,13],"@E 99,999,999.99") ;	// Lucro Liq
				+ Transform(aGrpVei[nPos,14]+aGrpVei[nPos,15],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
				+ Transform(aGrpVei[nPos,16],"@E 99,999,999.99") ;// Resultado Final
				+ Transform(aGrpVei[nPos,18]/aGrpVei[nPos,19],"@E 999,999,999.9")	//;// Prz Medio
				//				+ Transform((aGrpVei[nPos,20]/aGrpVei[nPos,3])*100,"@E 9999.9")	// % Desc
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				//										+ Transform(aGrpVei[nPos,14],"@E 99,999,999.99") ;// Cst/Dsp Fix
				//										+ Transform(aGrpVei[nPos,15],"@E 99,999,999.99") ;// Dsp Dep/Adm
				//										+ Transform(aGrpVei[nPos,16],"@E 99,999,999.99")  // Resultado Final
				
				If ExistBlock("GRAVGRPVEI")
					ExecBlock("GRAVGRPVEI",.f.,.f.)
				EndIf
				@ nLin++ , 01 psay cTipo + Transform(aGrpVei[nPos,17],"@E 9999") + U_FS_ImpRM_250(cString)
				
				
			Else
				nLin+= 2
				fwrite(outputfile," "+CHR(13)+CHR(10))
				
				cString := Transform(aGrpVei[nPos,3],"@E 999,999,999.99") ;	// Venda Total
				+ Transform(aGrpVei[nPos,4],"@E 99999,999.99") ;		// Impostos
				+ Transform(aGrpVei[nPos,5],"@E 99999,999.99") ;		// ICMS
				+ space(11) ;
				+ Transform(aGrpVei[nPos,6],"@E 9999,999.99") ;		// PIS
				+ Transform(aGrpVei[nPos,7],"@E 9999,999.99") ;		// Cofins
				+ Transform(aGrpVei[nPos,8],"@E 99,999,999.99") ;	// Custos
				+ Transform(aGrpVei[nPos,10],"@E 99,999,999.99") + Transform(((aGrpVei[nPos,10]/aGrpVei[nPos,3])*100),"@E 9999.9") ; // Lucro Bruto
				+ Transform(aGrpVei[nPos,9],"@E 99,999,999.99") ;	// Juro Estoque
				+ Transform(aGrpVei[nPos,11],"@E 99,999,999.99") ;	// Desp Var
				+ Transform(aGrpVei[nPos,12],"@E 99,999,999.99") ;	// Comissoes
				+ Transform(aGrpVei[nPos,13],"@E 99,999,999.99") ;	// Lucro Liq
				+ Transform(aGrpVei[nPos,14]+aGrpVei[nPos,15],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
				+ Transform(aGrpVei[nPos,16],"@E 99,999,999.99") ;// Resultado Final
				+ Transform(aGrpVei[nPos,18]/aGrpVei[nPos,19],"@E 999,999,999.9") ;// Prz Medio
				+CHR(13)+CHR(10)
				//				+ Transform((aGrpVei[nPos,20]/aGrpVei[nPos,3])*100,"@E 9999.9") ;// % Desc
				
				fwrite(outputfile," "+ cTipo + Transform(aGrpVei[nPos,17],"@E 9999") ; 	// Qtde
				+ U_FS_ImpRM_250(cString))
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				//										+ Transform(aGrpVei[nPos,14],"@E 99,999,999.99") ;// Cst/Dsp Fix
				//										+ Transform(aGrpVei[nPos,15],"@E 99,999,999.99") ;// Dsp Dep/Adm
				//										+ Transform(aGrpVei[nPos,16],"@E 99,999,999.99") ;// Resultado Final
				
			EndIf
		EndIf
		If MV_PAR04 >= 3
			If aNumVei[ni,18] > 0
				If FunName() == "OFIOR250"
					cString :=  Transform(aNumVei[ni,4],"@E 999,999,999.99") ;	// Venda Total
					+ Transform(aNumVei[ni,5],"@E 99999,999.99") ;	// Impostos
					+ Transform(aNumVei[ni,6],"@E 99999,999.99") ;	// ICMS
					+ space(11) ;
					+ Transform(aNumVei[ni,7],"@E 9999,999.99") ;		// PIS
					+ Transform(aNumVei[ni,8],"@E 9999,999.99") ;		// Cofins
					+ Transform(aNumVei[ni,9],"@E 99,999,999.99") ;	// Custos
					+ Transform(aNumVei[ni,11],"@E 99,999,999.99") + Transform(((aNumVei[ni,11]/aNumVei[ni,4])*100),"@E 9999.9") ; // Lucro Bruto
					+ Transform(aNumVei[ni,10],"@E 99,999,999.99") ;	// Juro Estoque
					+ Transform(aNumVei[ni,12],"@E 99,999,999.99") ; // Desp Var
					+ Transform(aNumVei[ni,13],"@E 99,999,999.99") ; // Comissoes
					+ Transform(aNumVei[ni,14],"@E 99,999,999.99") ;	// Lucro Liq
					+ Transform(aNumVei[ni,15]+aNumVei[ni,16],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
					+ Transform(aNumVei[ni,17],"@E 99,999,999.99") ;// Resultado Final
					+ Transform(aNumVei[ni,20]/aNumVei[ni,21],"@E 999,999,999.9")//	;// Prz Medio
					//					+ Transform((aNumVei[ni,22]/aNumVei[ni,4])*100,"@E 9999.9")	// % Desc
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					//										+ Transform(aNumVei[ni,15],"@E 99,999,999.99") ;// Cst/Dsp Fix
					//										+ Transform(aNumVei[ni,16],"@E 99,999,999.99") ;// Dsp Dep/Adm
					//										+ Transform(aNumVei[ni,17],"@E 99,999,999.99")  // Resultado Final
					
					@ nLin++ , 00 psay "    " + left(aNumVei[ni,3],18) + Transform(aNumVei[ni,18],"@E 9999") + U_FS_ImpRM_250(cString)
					
				Else
					nLin++
					cString := Transform(aNumVei[ni,4],"@E 999,999,999.99") ;	// Venda Total
					+ Transform(aNumVei[ni,5],"@E 99999,999.99") ;	// Impostos
					+ Transform(aNumVei[ni,6],"@E 99999,999.99") ;	// ICMS
					+ space(11) ;
					+ Transform(aNumVei[ni,7],"@E 9999,999.99") ;		// PIS
					+ Transform(aNumVei[ni,8],"@E 9999,999.99") ;		// Cofins
					+ Transform(aNumVei[ni,9],"@E 99,999,999.99") ;	// Custos
					+ Transform(aNumVei[ni,11],"@E 99,999,999.99") + Transform(((aNumVei[ni,11]/aNumVei[ni,4])*100),"@E 9999.9") ; // Lucro Bruto
					+ Transform(aNumVei[ni,10],"@E 99,999,999.99") ;	// Juro Estoque
					+ Transform(aNumVei[ni,12],"@E 99,999,999.99") ; // Desp Var
					+ Transform(aNumVei[ni,13],"@E 99,999,999.99") ; // Comissoes
					+ Transform(aNumVei[ni,14],"@E 99,999,999.99") ;	// Lucro Liq
					+ Transform(aNumVei[ni,15]+aNumVei[ni,16],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
					+ Transform(aNumVei[ni,17],"@E 99,999,999.99") ;// Resultado Final
					+ Transform(aNumVei[ni,20]/aNumVei[ni,21],"@E 999,999,999.9");// Prz Medio
					+CHR(13)+CHR(10)
					//					+ Transform((aNumVei[ni,22]/aNumVei[ni,4])*100,"@E 9999.9");// % Desc
					fwrite(outputfile,"    " + left(aNumVei[ni,3],18) + Transform(aNumVei[ni,18],"@E 9999") ; // Qtde
					+ U_FS_ImpRM_250(cString))
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					//										+ Transform(aNumVei[ni,15],"@E 99,999,999.99") ;// Cst/Dsp Fix
					//										+ Transform(aNumVei[ni,16],"@E 99,999,999.99") ;// Dsp Dep/Adm
					//										+ Transform(aNumVei[ni,17],"@E 99,999,999.99") ;// Resultado Final
					
				EndIf
			Else
				If FunName() == "OFIOR250"
					@ nLin++ , 00 psay STR0076 + Transform(aNumVei[ni,4],"@E 9999,999,999.99") 	// Venda Total: Faturamento Direto
				Else
					nLin++
					fwrite(outputfile,STR0076 + Transform(aNumVei[ni,4],"@E 9999,999,999.99")+CHR(13)+CHR(10))
				EndIf
			EndIf
		EndIf
	Next
EndIf
If FunName() == "OFIOR250"
	nLin++
	@ nLin++ , 00 psay Repl("-",220)
Else
	nLin+= 2
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,Repl("-",220)+CHR(13)+CHR(10))
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_OR25AP³ Autor ³ Andre Luis Almeida    ³ Data ³ 03/01/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao: Posicao das Vendas & Resultados - PECAS	      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_OR25AP(aTotPec,aGrpPec,aNumPec,aGrpPBO,aDpto)
local ni := 0
Local cDpto := "??"
Local cImpDpto := ""
local xx := 0
///////////////////////////////////
//        P  E  C  A  S          //
///////////////////////////////////
If FunName() == "OFIOR250"
	
	//	aTotPec[1, 8] := aTotPec[1,1]-aTotPec[1,2]-aTotPec[1,6]
	//	aTotPec[1,14] := aTotPec[1,8]-aTotPec[1,7]-aTotPec[1,9]
	//	aTotPec[1, 8] := aTotPec[1,1]-aTotPec[1,2]-aTotPec[1,6]+aTotPec[1,12]+aTotPec[1,13]
	//	aTotPec[1,11] := aTotPec[1,8]-aTotPec[1,7]-aTotPec[1,10]-aTotPec[1,9]
	//	aTotPec[1,14] := aTotPec[1,8]-aTotPec[1,7]-aTotPec[1,10]-aTotPec[1,9]
	nLin++
	@ nLin++ , 00 psay STR0015 + cCabPec
	cString := Transform(aTotPec[1,1],"@E 999,999,999.99");// Venda Total //Manoel
	+ Transform(aTotPec[1,2],"@E 99999,999.99") ;	// Impostos
	+ Transform(aTotPec[1,3],"@E 99999,999.99") ;	// ICMS
	+ space(11) ;
	+ Transform(aTotPec[1,4],"@E 9999,999.99") ;	// PIS
	+ Transform(aTotPec[1,5],"@E 9999,999.99") ;	// Cofins
	+ Transform(aTotPec[1,6],"@E 99,999,999.99") ;// C.M.V.
	+ Transform(aTotPec[1,8],"@E 99,999,999.99") + Transform((((aTotPec[1,8])/aTotPec[1,1])*100),"@E 9999.9") ;// Lucro Bruto
	+ Transform(aTotPec[1,7],"@E 99,999,999.99") ;// Juro Estoque
	+ Transform(aTotPec[1,9],"@E 99,999,999.99") ;// Desp Var
	+ Transform(aTotPec[1,10],"@E 99,999,999.99");// Comissoes
	+ Transform(aTotPec[1,11],"@E 99,999,999.99");// Lucro Liq
	+ Transform(aTotPec[1,12]+aTotPec[1,13],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
	+ Transform(Iif(aTotPec[1,1]==0,0,aTotPec[1,14]),"@E 99,999,999.99") ;// Resultado Final
	+ Transform(Iif(aTotPec[1,1]==0,0,aTotPec[1,15]/aTotPec[1,16]),"@E 999,999,999.9")//	;// Prz Medio
	//	+ Transform((aTotPec[1,17]/aTotPec[1,1])*100,"@E 9999.9")	// % Desc
	
	// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
	//										+ Transform(aTotPec[1,12],"@E 99,999,999.99") ;// Cst/Dsp Fix
	//										+ Transform(aTotPec[1,13],"@E 99,999,999.99") ;// Dsp Dep/Adm
	//										+ Transform(aTotPec[1,14],"@E 99,999,999.99")  // Resultado Final
	
	@ nLin++ , 00 psay LEFT(STR0016+space(26),26) + U_FS_ImpRM_250(cString)
	
	
Else
	//	aTotPec[1, 8] := aTotPec[1,1]-aTotPec[1,2]-aTotPec[1,6]+aTotPec[1,12]+aTotPec[1,13]
	//	aTotPec[1,11] := aTotPec[1,8]-aTotPec[1,7]-aTotPec[1,10]-aTotPec[1,9]
	//	aTotPec[1,14] := aTotPec[1,8]-aTotPec[1,7]-aTotPec[1,10]-aTotPec[1,9]
	nLin+= 3
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,STR0015 + cCabPec+CHR(13)+CHR(10))
	
	cString := Transform(aTotPec[1,1],"@E 999,999,999.99");// Venda Total //Manoel
	+ Transform(aTotPec[1,2],"@E 99999,999.99") ;	// Impostos
	+ Transform(aTotPec[1,3],"@E 99999,999.99") ;	// ICMS
	+ space(11) ;
	+ Transform(aTotPec[1,4],"@E 9999,999.99") ;	// PIS
	+ Transform(aTotPec[1,5],"@E 9999,999.99") ;	// Cofins
	+ Transform(aTotPec[1,6],"@E 99,999,999.99") ;// C.M.V.
	+ Transform(aTotPec[1,8],"@E 99,999,999.99") + Transform((((aTotPec[1,8])/aTotPec[1,1])*100),"@E 9999.9") ;// Lucro Bruto
	+ Transform(aTotPec[1,7],"@E 99,999,999.99") ;// Juro Estoque
	+ Transform(aTotPec[1,9],"@E 99,999,999.99") ;// Desp Var
	+ Transform(aTotPec[1,10],"@E 99,999,999.99");// Comissoes
	+ Transform(aTotPec[1,11],"@E 99,999,999.99");// Lucro Liq
	+ Transform(aTotPec[1,12]+aTotPec[1,13],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
	+ Transform(aTotPec[1,14],"@E 99,999,999.99") ;// Resultado Final
	+ Transform(aTotPec[1,15]/aTotPec[1,16],"@E 999,999,999.9");// Prz Medio
	+CHR(13)+CHR(10)
	//	+ Transform((aTotPec[1,17]/aTotPec[1,1])*100,"@E 9999.9");// % Desc
	fwrite(outputfile,STR0016 +U_FS_ImpRM_250(cString))
	
	
	// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
	//										+ Transform(aTotPec[1,12],"@E 99,999,999.99") ;// Cst/Dsp Fix
	//										+ Transform(aTotPec[1,13],"@E 99,999,999.99") ;// Dsp Dep/Adm
	//										+ Transform(aTotPec[1,14],"@E 99,999,999.99") ; // Resultado Final
	
EndIf
If MV_PAR04 >= 2
	aSort(aNumPec,1,,{|x,y| x[1]+x[18]+x[19]+x[2] < y[1]+y[18]+y[19]+y[2]})
	cMudou := "9"
	cMudou2:= "9"
	aaa := ""
	//	cNomeArq := "\INT\"+"ofior250.txt"
	//	nHnd := FCREATE(cNomeArq,0)
	
	//	For xx := 1 to Len(aXXX)
	//      aaa := aXXX[xx,1]+" "+aXXX[xx,2]+" "+transform(aXXX[xx,6],"@E 999,999,999.99")
	//		fwrite(nHnd,aaa+CHR(13)+CHR(10))
	//	Next
	For ni:=1 to Len(aNumPec)
		//		Manoel - 26/03/08 - Fazia a pergunta errado, ou seja, perguntando sempre sobre o 1o elemento.
		//		Nao aparecia PECAS BALCAO / PECAS OFICINA
		//		If (aNumpec[1,4]==0) .and. Mv_Par09 == 1
		If (aNumpec[ni,4]==0) .and. Mv_Par09 == 1
			loop
		Endif
		If FunName() == "OFIOR250"
			nCont ++
			If nCont == 400
				IncRegua()
				nCont := 2
				If lAbortPrint
					nLin++
					@nLin++,30 PSAY STR0058 //"* * *  C A N C E L A D O   P E L O   O P E R A D O R  * * *"
					Exit
				EndIf
			EndIf
		EndIf
		If nLin >= 60
			If FunName() == "OFIOR250"
				nLin := 1
				nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
				nLin++
				@ nLin++ , 27 psay cCabPec
				nLin++
			Else
				nLin := 4
				fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
				fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
				fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
				fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cFil+".##r"+CHR(13)+CHR(10))
				fwrite(outputfile," "+CHR(13)+CHR(10))
				fwrite(outputfile,space(27)+cCabPec+CHR(13)+CHR(10))
				fwrite(outputfile," "+CHR(13)+CHR(10))
			EndIf
		EndIf
		If cMudou # aNumPec[ni,1]
			If aGrpPBO[1,2] > 0 .and. aNumPec[ni,1] == "B"
				nPos := 1
				//				aGrpPBO[nPos, 9] := aGrpPBO[nPos, 2]-aGrpPBO[nPos, 3]-aGrpPBO[nPos, 7]
				//				aGrpPBO[nPos,12] := aGrpPBO[nPos, 9]-aGrpPBO[nPos, 8]-aGrpPBO[nPos,10]
				//				aGrpPBO[nPos,15] := aGrpPBO[nPos,12]-aGrpPBO[nPos,13]-aGrpPBO[nPos,14]
				//	Manoel - 27/11/2008 - usando o campos Cst/Dsp Fix para mostrar Result ST - nao subtrai do RESFIN e sim do LUCBRU
				//				aGrpPBO[nPos, 9] := aGrpPBO[nPos, 2]-aGrpPBO[nPos, 3]-aGrpPBO[nPos, 7]+aGrpPBO[nPos,13]+aGrpPBO[nPos,14]
				//				aGrpPBO[nPos,12] := aGrpPBO[nPos, 9]-aGrpPBO[nPos, 8]-aGrpPBO[nPos,10]
				//				aGrpPBO[nPos,15] := aGrpPBO[nPos,12]
				If FunName() == "OFIOR250"
					nLin++
					cString := Transform(aGrpPBO[nPos,2],"@E 999,999,999.99");//Venda Total
					+ Transform(aGrpPBO[nPos,3],"@E 99999,999.99") ;	// Impostos
					+ Transform(aGrpPBO[nPos,4],"@E 99999,999.99") ;	// ICMS
					+ space(11) ;
					+ Transform(aGrpPBO[nPos,5],"@E 9999,999.99") ;	// PIS
					+ Transform(aGrpPBO[nPos,6],"@E 9999,999.99") ;	// Cofins
					+ Transform(aGrpPBO[nPos,7],"@E 99,999,999.99") ;// C.M.V.
					+ Transform(aGrpPBO[nPos,9],"@E 99,999,999.99") + Transform(((aGrpPBO[nPos,9]/aGrpPBO[nPos,2])*100),"@E 9999.9") ;// Lucro Bruto
					+ Transform(aGrpPBO[nPos,8],"@E 99,999,999.99") ;// Juro Estoque
					+ Transform(aGrpPBO[nPos,10],"@E 99,999,999.99");// Desp Var
					+ Transform(aGrpPBO[nPos,11],"@E 99,999,999.99");// Comissoes
					+ Transform(aGrpPBO[nPos,12],"@E 99,999,999.99");// Lucro Liq
					+ Transform(aGrpPBO[nPos,13]+aGrpPBO[nPos,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
					+ Transform(aGrpPBO[nPos,15],"@E 99,999,999.99") ;// Resultado Final
					+ Transform(aGrpPBO[nPos,16]/aGrpPBO[nPos,17],"@E 999,999,999.9")// ;	// Prz Medio
					//					+ Transform((aGrpPBO[nPos,18]/aGrpPBO[nPos,2])*100,"@E 9999.9")	// % Desc
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					//					  								+ Transform(aGrpPBO[nPos,13],"@E 99,999,999.99") ;// Cst/Dsp Fix
					//					  								+ Transform(aGrpPBO[nPos,14],"@E 99,999,999.99") ;// Dsp Dep/Adm
					//					  								+ Transform(aGrpPBO[nPos,15],"@E 99,999,999.99")  // Resultado Final
					
					@ nLin++ , 00 psay LEFT(STR0017+space(26),26) + U_FS_ImpRM_250(cString)
					
				Else
					nLin+= 2
					fwrite(outputfile," "+CHR(13)+CHR(10))
					cString := Transform(aGrpPBO[nPos,2],"@E 999,999,999.99");//Venda Total
					+ Transform(aGrpPBO[nPos,3],"@E 99999,999.99") ;	// Impostos
					+ Transform(aGrpPBO[nPos,4],"@E 99999,999.99") ;	// ICMS
					+ space(11) ;
					+ Transform(aGrpPBO[nPos,5],"@E 9999,999.99") ;	// PIS
					+ Transform(aGrpPBO[nPos,6],"@E 9999,999.99") ;	// Cofins
					+ Transform(aGrpPBO[nPos,7],"@E 99,999,999.99") ;// C.M.V.
					+ Transform(aGrpPBO[nPos,9],"@E 99,999,999.99") + Transform(((aGrpPBO[nPos,9]/aGrpPBO[nPos,2])*100),"@E 9999.9") ;// Lucro Bruto
					+ Transform(aGrpPBO[nPos,8],"@E 99,999,999.99") ;// Juro Estoque
					+ Transform(aGrpPBO[nPos,10],"@E 99,999,999.99");// Desp Var
					+ Transform(aGrpPBO[nPos,11],"@E 99,999,999.99");// Comissoes
					+ Transform(aGrpPBO[nPos,12],"@E 99,999,999.99");// Lucro Liq
					+ Transform(aGrpPBO[nPos,13]+aGrpPBO[nPos,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
					+ Transform(aGrpPBO[nPos,15],"@E 99,999,999.99") ;// Resultado Final
					+ Transform(aGrpPBO[nPos,16]/aGrpPBO[nPos,17],"@E 999,999,999.9")  ;// Prz Medio
					+CHR(13)+CHR(10)
					//					+ Transform((aGrpPBO[nPos,18]/aGrpPBO[nPos,2])*100,"@E 9999.9")  ;// % Desc
					fwrite(outputfile,STR0017 + U_FS_ImpRM_250(cString))
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					//					  								+ Transform(aGrpPBO[nPos,13],"@E 99,999,999.99") ;// Cst/Dsp Fix
					//					  								+ Transform(aGrpPBO[nPos,14],"@E 99,999,999.99") ;// Dsp Dep/Adm
					//					  								+ Transform(aGrpPBO[nPos,15],"@E 99,999,999.99") ;// Resultado Final
					
				EndIf
			EndIf
			If aGrpPBO[2,2] > 0 .and. aNumPec[ni,1] == "O"
				nPos := 2
				If FunName() == "OFIOR250"
					nLin++
					cString := Transform(aGrpPBO[nPos,2],"@E 999,999,999.99");//Venda Total
					+ Transform(aGrpPBO[nPos,3],"@E 99999,999.99") ;	// Impostos
					+ Transform(aGrpPBO[nPos,4],"@E 99999,999.99") ;	// ICMS
					+ space(11) ;
					+ Transform(aGrpPBO[nPos,5],"@E 9999,999.99") ;	// PIS
					+ Transform(aGrpPBO[nPos,6],"@E 9999,999.99") ;	// Cofins
					+ Transform(aGrpPBO[nPos,7],"@E 99,999,999.99") ;// C.M.V.
					+ Transform(aGrpPBO[nPos,9],"@E 99,999,999.99") + Transform(((aGrpPBO[nPos,9]/aGrpPBO[nPos,2])*100),"@E 9999.9") ;// Lucro Bruto
					+ Transform(aGrpPBO[nPos,8],"@E 99,999,999.99") ;// Juro Estoque
					+ Transform(aGrpPBO[nPos,10],"@E 99,999,999.99");// Desp Var
					+ Transform(aGrpPBO[nPos,11],"@E 99,999,999.99");// Comissoes
					+ Transform(aGrpPBO[nPos,12],"@E 99,999,999.99");// Lucro Liq
					+ Transform(aGrpPBO[nPos,13]+aGrpPBO[nPos,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
					+ Transform(aGrpPBO[nPos,15],"@E 99,999,999.99") ;// Resultado Final
					+ Transform(aGrpPBO[nPos,16]/aGrpPBO[nPos,17],"@E 999,999,999.9") //;	// Prz Medio
					//					+ Transform((aGrpPBO[nPos,18]/aGrpPBO[nPos,2])*100,"@E 9999.9")	// % Desc
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					//					  								+ Transform(aGrpPBO[nPos,13],"@E 99,999,999.99") ;// Cst/Dsp Fix
					//					  								+ Transform(aGrpPBO[nPos,14],"@E 99,999,999.99") ;// Dsp Dep/Adm
					//					  								+ Transform(aGrpPBO[nPos,15],"@E 99,999,999.99")  // Resultado Final
					
					@ nLin++ , 00 psay LEFT(STR0018+space(26),26) + U_FS_ImpRM_250(cString)
					
				Else
					nLin+= 2
					fwrite(outputfile," "+CHR(13)+CHR(10))
					
					cString := Transform(aGrpPBO[nPos,2],"@E 999,999,999.99");//Venda Total
					+ Transform(aGrpPBO[nPos,3],"@E 99999,999.99") ;	// Impostos
					+ Transform(aGrpPBO[nPos,4],"@E 99999,999.99") ;	// ICMS
					+ space(11) ;
					+ Transform(aGrpPBO[nPos,5],"@E 9999,999.99") ;	// PIS
					+ Transform(aGrpPBO[nPos,6],"@E 9999,999.99") ;	// Cofins
					+ Transform(aGrpPBO[nPos,7],"@E 99,999,999.99") ;// C.M.V.
					+ Transform(aGrpPBO[nPos,9],"@E 99,999,999.99") + Transform(((aGrpPBO[nPos,9]/aGrpPBO[nPos,2])*100),"@E 9999.9") ;// Lucro Bruto
					+ Transform(aGrpPBO[nPos,8],"@E 99,999,999.99") ;// Juro Estoque
					+ Transform(aGrpPBO[nPos,10],"@E 99,999,999.99");// Desp Var
					+ Transform(aGrpPBO[nPos,11],"@E 99,999,999.99");// Comissoes
					+ Transform(aGrpPBO[nPos,12],"@E 99,999,999.99");// Lucro Liq
					+ Transform(aGrpPBO[nPos,13]+aGrpPBO[nPos,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
					+ Transform(aGrpPBO[nPos,15],"@E 99,999,999.99") ;// Resultado Final
					+ Transform(aGrpPBO[nPos,16]/aGrpPBO[nPos,17],"@E 999,999,999.9")	;// Prz Medio
					+CHR(13)+CHR(10)
					//					+ Transform((aGrpPBO[nPos,18]/aGrpPBO[nPos,2])*100,"@E 9999.9")	;// % Desc
					
					fwrite(outputfile,STR0018 + U_FS_ImpRM_250(cString))
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					//					  								+ Transform(aGrpPBO[nPos,13],"@E 99,999,999.99") ;// Cst/Dsp Fix
					//					  								+ Transform(aGrpPBO[nPos,14],"@E 99,999,999.99") ;// Dsp Dep/Adm
					//					  								+ Transform(aGrpPBO[nPos,15],"@E 99,999,999.99") ;// Resultado Final
					
				EndIf
			EndIf
			cMudou := aNumPec[ni,1]
		EndIf
		If cMudou2 # aNumPec[ni,18] .and. aNumPec[ni,18] # "9"
			cMudou2 := aNumPec[ni,18]
			cDpto := "??"
			If cMudou2 == "1"
				cTipo := STR0019
			ElseIf  cMudou2 == "2"
				cTipo := STR0020
			ElseIf  cMudou2 == "3"
				cTipo := STR0021
			ElseIf  cMudou2 == "4"
				cTipo := STR0022
			EndIf
			nPos := aScan(aGrpPec,{|x| x[16] == cMudou2 })
			If FunName() == "OFIOR250"
				nLin++
				if nPos # 0
					cString := Transform(aGrpPec[nPos,2],"@E 999,999,999.99");// Venda Total
					+ Transform(aGrpPec[nPos,3],"@E 99999,999.99") ;	// Impostos
					+ Transform(aGrpPec[nPos,4],"@E 99999,999.99") ;	// ICMS
					+ space(11) ;
					+ Transform(aGrpPec[nPos,5],"@E 9999,999.99") ;	// PIS
					+ Transform(aGrpPec[nPos,6],"@E 9999,999.99") ;	// Cofins
					+ Transform(aGrpPec[nPos,7],"@E 99,999,999.99");	// C.M.V.
					+ Transform(aGrpPec[nPos,9],"@E 99,999,999.99") + Transform(((aGrpPec[nPos,9]/aGrpPec[nPos,2])*100),"@E 9999.9");//Lucro Bruto
					+ Transform(aGrpPec[nPos,8],"@E 99,999,999.99");	// Juro Estoque
					+ Transform(aGrpPec[nPos,10],"@E 99,999,999.99");// Desp Var
					+ Transform(aGrpPec[nPos,11],"@E 99,999,999.99");// Comissoes
					+ Transform(aGrpPec[nPos,12],"@E 99,999,999.99");// Lucro Liq
					+ Transform(aGrpPec[nPos,13]+aGrpPec[nPos,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
					+ Transform(aGrpPec[nPos,15],"@E 99,999,999.99") ;// Resultado Final
					+ Transform(aGrpPec[nPos,17]/aGrpPec[nPos,18],"@E 999,999,999.9") //;	// Prz Medio
					//					+ Transform((aGrpPec[nPos,19]/aGrpPec[nPos,2])*100,"@E 9999.9")	// % Desc
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					//					  								+ Transform(aGrpPec[nPos,13],"@E 99,999,999.99") ;// Cst/Dsp Fix
					//					  								+ Transform(aGrpPec[nPos,14],"@E 99,999,999.99") ;// Dsp Dep/Adm
					//					  								+ Transform(aGrpPec[nPos,15],"@E 99,999,999.99")  // Resultado Final
					
					@ nLin++ , 00 psay "  " + cTipo + U_FS_ImpRM_250(cString)
				endif
			Else
				nLin+= 2
				fwrite(outputfile," "+CHR(13)+CHR(10))
				cString := Transform(aGrpPec[nPos,2],"@E 999,999,999.99");// Venda Total
				+ Transform(aGrpPec[nPos,3],"@E 99999,999.99") ;	// Impostos
				+ Transform(aGrpPec[nPos,4],"@E 99999,999.99") ;	// ICMS
				+ space(11) ;
				+ Transform(aGrpPec[nPos,5],"@E 9999,999.99") ;	// PIS
				+ Transform(aGrpPec[nPos,6],"@E 9999,999.99") ;	// Cofins
				+ Transform(aGrpPec[nPos,7],"@E 99,999,999.99");	// C.M.V.
				+ Transform(aGrpPec[nPos,9],"@E 99,999,999.99") + Transform(((aGrpPec[nPos,9]/aGrpPec[nPos,2])*100),"@E 9999.9");//Lucro Bruto
				+ Transform(aGrpPec[nPos,8],"@E 99,999,999.99");	// Juro Estoque
				+ Transform(aGrpPec[nPos,10],"@E 99,999,999.99");// Desp Var
				+ Transform(aGrpPec[nPos,11],"@E 99,999,999.99");// Comissoes
				+ Transform(aGrpPec[nPos,12],"@E 99,999,999.99");// Lucro Liq
				+ Transform(aGrpPec[nPos,13]+aGrpPec[nPos,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
				+ Transform(aGrpPec[nPos,15],"@E 99,999,999.99") ;// Resultado Final
				+ Transform(aGrpPec[nPos,17]/aGrpPec[nPos,18],"@E 999,999,999.9");// Prz Medio
				+CHR(13)+CHR(10)
				//				+ Transform((aGrpPec[nPos,19]/aGrpPec[nPos,2])*100,"@E 9999.9");// % Desc
				fwrite(outputfile,"  " + cTipo + U_FS_ImpRM_250(cString))
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				//					  								+ Transform(aGrpPec[nPos,13],"@E 99,999,999.99") ;// Cst/Dsp Fix
				//					  								+ Transform(aGrpPec[nPos,14],"@E 99,999,999.99") ;// Dsp Dep/Adm
				//					  								+ Transform(aGrpPec[nPos,15],"@E 99,999,999.99") ;// Resultado Final
				
			EndIf
		EndIf
		If MV_PAR04 >= 2
			If cDpto # aNumPec[ni,19]
				cDpto := aNumPec[ni,19]
				nPos := aScan(aDpto,{|x| x[1]+x[17]+x[18] == cDpto+aNumPec[ni,1]+aNumPec[ni,18] })
				If nPos > 0
					If aNumPec[ni,1] == "B"
						If MV_PAR04 >= 3 .or. Empty(aDpto[nPos,1])
							nLin++
						EndIf
						cImpDpto := "  " + iIf(!Empty(aDpto[nPos,1]),aDpto[nPos,1],"--") + " " + left(Iif(left(aDpto[nPos,16],3)#"...",aDpto[nPos,16],"")+repl(".",21),21)
					Else
						cImpDpto := "   " + Iif(!Empty(aDpto[nPos,1]),aDpto[nPos,1],"--") + " " + left(Iif(left(aDpto[nPos,16],3)#"...",aDpto[nPos,16],"")+repl(".",20),20)
					EndIf
					If FunName() == "OFIOR250"
						cString := Transform(aDpto[nPos,2],"@E 999,999,999.99") ;	// Venda Total
						+ Transform(aDpto[nPos,3],"@E 99999,999.99") ;	// Impostos
						+ Transform(aDpto[nPos,4],"@E 99999,999.99") ;	// ICMS
						+ space(11) ;
						+ Transform(aDpto[nPos,5],"@E 9999,999.99") ;	// PIS
						+ Transform(aDpto[nPos,6],"@E 9999,999.99") ;	// Cofins
						+ Transform(aDpto[nPos,7],"@E 99,999,999.99"); // C.M.V.
						+ Transform(aDpto[nPos,9],"@E 99,999,999.99") + Transform(((aDpto[nPos,9]/aDpto[nPos,2])*100),"@E 9999.9");//Lucro Bruto
						+ Transform(aDpto[nPos,8],"@E 99,999,999.99");	// Juro Estoque
						+ Transform(aDpto[nPos,10],"@E 99,999,999.99");// Desp Var
						+ Transform(aDpto[nPos,11],"@E 99,999,999.99");// Comissoes
						+ Transform(aDpto[nPos,12],"@E 99,999,999.99");// Lucro Liq
						+ Transform(aDpto[nPos,13]+aDpto[nPos,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
						+ Transform(aDpto[nPos,15],"@E 99,999,999.99") ;// Resultado Final
						+ Transform(aDpto[nPos,19]/aDpto[nPos,20],"@E 999,999,999.9") //	;// Prz Medio
						//						+ Transform((aDpto[nPos,21]/aDpto[nPos,2])*100,"@E 9999.9")	// % Desc
						// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
						//				  								+ Transform(aDpto[nPos,13],"@E 99,999,999.99") ;// Cst/Dsp Fix
						//				  								+ Transform(aDpto[nPos,14],"@E 99,999,999.99") ;// Dsp Dep/Adm
						//				  								+ Transform(aDpto[nPos,15],"@E 99,999,999.99")  // Resultado Final
						
						@ nLin++ , 00 psay LEFT(cImpDpto+space(26),26) + U_FS_ImpRM_250(cString)
						
					Else
						nLin++
						fwrite(outputfile," "+CHR(13)+CHR(10))
						cString := Transform(aDpto[nPos,2],"@E 999,999,999.99") ;	// Venda Total
						+ Transform(aDpto[nPos,3],"@E 99999,999.99") ;	// Impostos
						+ Transform(aDpto[nPos,4],"@E 99999,999.99") ;	// ICMS
						+ space(11) ;
						+ Transform(aDpto[nPos,5],"@E 9999,999.99") ;	// PIS
						+ Transform(aDpto[nPos,6],"@E 9999,999.99") ;	// Cofins
						+ Transform(aDpto[nPos,7],"@E 99,999,999.99"); // C.M.V.
						+ Transform(aDpto[nPos,9],"@E 99,999,999.99") + Transform(((aDpto[nPos,9]/aDpto[nPos,2])*100),"@E 9999.9");//Lucro Bruto
						+ Transform(aDpto[nPos,8],"@E 99,999,999.99");	// Juro Estoque
						+ Transform(aDpto[nPos,10],"@E 99,999,999.99");// Desp Var
						+ Transform(aDpto[nPos,11],"@E 99,999,999.99");// Comissoes
						+ Transform(aDpto[nPos,12],"@E 99,999,999.99");// Lucro Liq
						+ Transform(aDpto[nPos,13]+aDpto[nPos,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
						+ Transform(aDpto[nPos,15],"@E 99,999,999.99") ;// Resultado Final
						+ Transform(aDpto[nPos,19]/aDpto[nPos,20],"@E 999,999,999.9") 	;// Prz Medio
						+ CHR(13)+CHR(10)
						//						+ Transform((aDpto[nPos,21]/aDpto[nPos,2])*100,"@E 9999.9")	;// % Desc
						fwrite(outputfile, cImpDpto + U_FS_ImpRM_250(cString))
						// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
						//				  								+ Transform(aDpto[nPos,13],"@E 99,999,999.99") ;// Cst/Dsp Fix
						//				  								+ Transform(aDpto[nPos,14],"@E 99,999,999.99") ;// Dsp Dep/Adm
						//				  								+ Transform(aDpto[nPos,15],"@E 99,999,999.99") ; // Resultado Final
						
					EndIf
				EndIf
			EndIf
		EndIf
		
		If (MV_PAR04 >= 3 .and. ((!Empty(alltrim(aNumPec[ni,2]))) .and. (!Empty(alltrim(aNumPec[ni,3]))) .and. (aNumPec[ni,4] # 0)))
			If .t. //( aNumPec[ni,1]+aNumPec[ni,2] # "BDEV" )
				If FunName() == "OFIOR250"
					cString := Transform(aNumPec[ni,4],"@E 999,999,999.99") ;	// Venda Total
					+ Transform(aNumPec[ni,5],"@E 99999,999.99") ;	// Impostos
					+ Transform(aNumPec[ni,6],"@E 99999,999.99") ;	// ICMS
					+ space(11) ;
					+ Transform(aNumPec[ni,7],"@E 9999,999.99") ;		// PIS
					+ Transform(aNumPec[ni,8],"@E 9999,999.99") ;		// Cofins
					+ Transform(aNumPec[ni,9],"@E 99,999,999.99") ;	// C.M.V.
					+ Transform(aNumPec[ni,11],"@E 99,999,999.99")	 + Transform(((aNumPec[ni,11]/aNumPec[ni,4])*100),"@E 9999.9");//Lucro Bruto
					+ Transform(aNumPec[ni,10],"@E 99,999,999.99");	// Juro Estoque
					+ Transform(aNumPec[ni,12],"@E 99,999,999.99");	// Desp Var
					+ Transform(aNumPec[ni,13],"@E 99,999,999.99");	// Comissoes
					+ Transform(aNumPec[ni,14],"@E 99,999,999.99");	// Lucro Liq
					+ Transform(aNumPec[ni,15]+aNumPec[ni,16],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
					+ Transform(aNumPec[ni,17],"@E 99,999,999.99") ;// Resultado Final
					+ Transform(aNumPec[ni,20]/aNumPec[ni,21],"@E 999,999,999.9")	//; // Prz Medio
					//					+ Transform((aNumPec[ni,22]/aNumPec[ni,4])*100,"@E 9999.9")	// % Desc
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					//				  										+ Transform(aNumPec[ni,15],"@E 99,999,999.99") ;// Cst/Dsp Fix
					//				  										+ Transform(aNumPec[ni,16],"@E 99,999,999.99") ;// Dsp Dep/Adm
					//				  										+ Transform(aNumPec[ni,17],"@E 99,999,999.99")  // Resultado Final
					
					@ nLin++ , 00 psay "    " + aNumPec[ni,2] + " " + left(aNumPec[ni,3],Iif(MV_PAR05==1,17,15)) + U_FS_ImpRM_250(cString)
					
				Else
					nLin++
					cString := Transform(aNumPec[ni,4],"@E 999,999,999.99") ;	// Venda Total
					+ Transform(aNumPec[ni,5],"@E 99999,999.99") ;	// Impostos
					+ Transform(aNumPec[ni,6],"@E 99999,999.99") ;	// ICMS
					+ space(11) ;
					+ Transform(aNumPec[ni,7],"@E 9999,999.99") ;		// PIS
					+ Transform(aNumPec[ni,8],"@E 9999,999.99") ;		// Cofins
					+ Transform(aNumPec[ni,9],"@E 99,999,999.99") ;	// C.M.V.
					+ Transform(aNumPec[ni,11],"@E 99,999,999.99")	 + Transform(((aNumPec[ni,11]/aNumPec[ni,4])*100),"@E 9999.9");//Lucro Bruto
					+ Transform(aNumPec[ni,10],"@E 99,999,999.99");	// Juro Estoque
					+ Transform(aNumPec[ni,12],"@E 99,999,999.99");	// Desp Var
					+ Transform(aNumPec[ni,13],"@E 99,999,999.99");	// Comissoes
					+ Transform(aNumPec[ni,14],"@E 99,999,999.99");	// Lucro Liq
					+ Transform(aNumPec[ni,15]+aNumPec[ni,16],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
					+ Transform(aNumPec[ni,17],"@E 99,999,999.99") ;// Resultado Final
					+ Transform(aNumPec[ni,20]/aNumPec[ni,21],"@E 999,999,999.9") ;// Prz Medio
					+ CHR(13)+CHR(10)
					///					+ Transform((aNumPec[ni,22]/aNumPec[ni,4])*100,"@E 9999.9") ;// % Desc
					
					fwrite(outputfile,"    " + aNumPec[ni,2] + " " + left(aNumPec[ni,3],Iif(MV_PAR05==1,17,15)) + U_FS_ImpRM_250(cString))
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					//				  										+ Transform(aNumPec[ni,15],"@E 99,999,999.99") ;// Cst/Dsp Fix
					//				  										+ Transform(aNumPec[ni,16],"@E 99,999,999.99") ;// Dsp Dep/Adm
					//				  										+ Transform(aNumPec[ni,17],"@E 99,999,999.99") ;// Resultado Final
					
				EndIf
			EndIf
		EndIf
	Next
EndIf
If FunName() == "OFIOR250"
	nLin++
	@ nLin++ , 00 psay Repl("-",220)
Else
	nLin+= 2
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,Repl("-",220)+CHR(13)+CHR(10))
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_OR25AS³ Autor ³ Andre Luis Almeida    ³ Data ³ 03/01/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao: Posicao das Vendas & Resultados - SERVICOS      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_OR25AS(aTotSrv,aGrpSrv,aNumSrv,aDpto)
local ni := 0
Local cDpto := "??"
Local cImpDpto := ""

///////////////////////////////////
//    S  E  R  V  I  C  O  S     //
///////////////////////////////////
If FunName() == "OFIOR250"
	nLin++
	@ nLin++ , 00 psay STR0023 + cCabSrv
	cString := Transform(aTotSrv[1,1],"@E 999,999,999.99"); // Venda Total
	+ Transform(aTotSrv[1,2],"@E 99999,999.99");	// Impostos
	+ space(12) ;
	+ Transform(aTotSrv[1,3],"@E 9999,999.99") ;	// ISS
	+ Transform(aTotSrv[1,4],"@E 9999,999.99") ;	// PIS
	+ Transform(aTotSrv[1,5],"@E 9999,999.99") ;	// Cofins
	+ Transform(aTotSrv[1,6],"@E 99,999,999.99");	// Custo Srv
	+ Transform(aTotSrv[1,7],"@E 99,999,999.99") + Transform(((aTotSrv[1,7]/aTotSrv[1,1])*100),"@E 9999.9");// Lucro Bruto
	+ space(13) ;
	+ Transform(aTotSrv[1,8],"@E 99,999,999.99");	// Desp Var
	+ Transform(aTotSrv[1,9],"@E 99,999,999.99");	// Comissoes
	+ Transform(aTotSrv[1,10],"@E 99,999,999.99");// Lucro Liq
	+ Transform(aTotSrv[1,11]+aTotSrv[1,12],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
	+ Transform(aTotSrv[1,13],"@E 99,999,999.99") ;// Resultado Final
	+ Transform(aTotSrv[1,14]/aTotSrv[1,15],"@E 999,999,999.9") //;  // Prz Medio
	//	+ Transform((aTotSrv[1,16]/aTotSrv[1,1])*100,"@E 9999.9")  // % Desc
	// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
	//									+ Transform(aTotSrv[1,11],"@E 99,999,999.99") ;// Cst/Dsp Fix
	//									+ Transform(aTotSrv[1,12],"@E 99,999,999.99") ;// Dsp Dep/Adm
	//									+ Transform(aTotSrv[1,13],"@E 99,999,999.99")  // Resultado Final
	
	@ nLin++ , 00 psay LEFT(STR0024+space(26),26) + U_FS_ImpRM_250(cString) //left fnc 6573
	
Else
	nLin+= 3
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,STR0023 + cCabSrv+CHR(13)+CHR(10))
	cString := Transform(aTotSrv[1,1],"@E 999,999,999.99"); // Venda Total
	+ Transform(aTotSrv[1,2],"@E 99999,999.99");	// Impostos
	+ space(12) ;
	+ Transform(aTotSrv[1,3],"@E 9999,999.99") ;	// ISS
	+ Transform(aTotSrv[1,4],"@E 9999,999.99") ;	// PIS
	+ Transform(aTotSrv[1,5],"@E 9999,999.99") ;	// Cofins
	+ Transform(aTotSrv[1,6],"@E 99,999,999.99");	// Custo Srv
	+ Transform(aTotSrv[1,7],"@E 99,999,999.99") + Transform(((aTotSrv[1,7]/aTotSrv[1,1])*100),"@E 9999.9");// Lucro Bruto
	+ space(13) ;
	+ Transform(aTotSrv[1,8],"@E 99,999,999.99");	// Desp Var
	+ Transform(aTotSrv[1,9],"@E 99,999,999.99");	// Comissoes
	+ Transform(aTotSrv[1,10],"@E 99,999,999.99");// Lucro Liq
	+ Transform(aTotSrv[1,11]+aTotSrv[1,12],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
	+ Transform(aTotSrv[1,13],"@E 99,999,999.99") ;// Resultado Final
	+ Transform(aTotSrv[1,14]/aTotSrv[1,15],"@E 999,999,999.9") ;// Prz Medio
	+ CHR(13)+CHR(10)
	//	+ Transform((aTotSrv[1,16]/aTotSrv[1,1])*100,"@E 9999.9") ;// % Desc
	fwrite(outputfile,STR0024 + U_FS_ImpRM_250(cString))
	// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
	//									+ Transform(aTotSrv[1,11],"@E 99,999,999.99") ;// Cst/Dsp Fix
	//									+ Transform(aTotSrv[1,12],"@E 99,999,999.99") ;// Dsp Dep/Adm
	//									+ Transform(aTotSrv[1,13],"@E 99,999,999.99") ;// Resultado Final
	
EndIf
If MV_PAR04 >= 2
	aSort(aNumSrv,1,,{|x,y| x[1]+x[17]+x[2] < y[1]+y[17]+y[2]})
	cMudou := "9"
	For ni:=1 to Len(aNumSrv)
		If FunName() == "OFIOR250"
			nCont++
			If nCont == 400
				IncRegua()
				nCont := 2
				If lAbortPrint
					nLin++
					@nLin++,30 PSAY STR0058 //"* * *  C A N C E L A D O   P E L O   O P E R A D O R  * * *"
					Exit
				EndIf
			EndIf
		EndIf
		If nLin >= 60
			If FunName() == "OFIOR250"
				nLin := 1
				nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
				nLin++
				@ nLin++ , 27 psay cCabSrv
				nLin++
			Else
				nLin := 4
				fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
				fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
				fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
				fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cFil+".##r"+CHR(13)+CHR(10))
				fwrite(outputfile," "+CHR(13)+CHR(10))
				fwrite(outputfile,space(27)+cCabSrv+CHR(13)+CHR(10))
				fwrite(outputfile," "+CHR(13)+CHR(10))
			EndIf
		EndIf
		If cMudou # aNumSrv[ni,1]
			cDpto := "??"
			If aNumSrv[ni,1] == "1"
				cTipo := STR0019
			ElseIf  aNumSrv[ni,1] == "2"
				cTipo := STR0020
			ElseIf  aNumSrv[ni,1] == "3"
				cTipo := STR0021
			ElseIf  aNumSrv[ni,1] == "4"
				cTipo := STR0022
			EndIf
			cMudou := aNumSrv[ni,1]
			nPos := aScan(aGrpSrv,{|x| x[1] == cMudou })
			If FunName() == "OFIOR250"
				nLin++
				cString := Transform(aGrpSrv[nPos,2],"@E 999,999,999.99"); // Venda Total
				+ Transform(aGrpSrv[nPos,3],"@E 99999,999.99");	// Impostos
				+ space(12);
				+ Transform(aGrpSrv[nPos,4],"@E 9999,999.99");	// ISS
				+ Transform(aGrpSrv[nPos,5],"@E 9999,999.99");	// PIS
				+ Transform(aGrpSrv[nPos,6],"@E 9999,999.99");	// Cofins
				+ Transform(aGrpSrv[nPos,7],"@E 99,999,999.99");	// Custo Srv
				+ Transform(aGrpSrv[nPos,8],"@E 99,999,999.99") + Transform(((aGrpSrv[nPos,8]/aGrpSrv[nPos,2])*100),"@E 9999.9") ;//Lucro Bruto
				+ space(13);
				+ Transform(aGrpSrv[nPos,9],"@E 99,999,999.99");	// Desp Var
				+ Transform(aGrpSrv[nPos,10],"@E 99,999,999.99");// Comissoes
				+ Transform(aGrpSrv[nPos,11],"@E 99,999,999.99");// Lucro Liq
				+ Transform(aGrpSrv[nPos,12]+aGrpSrv[nPos,13],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
				+ Transform(aGrpSrv[nPos,14],"@E 99,999,999.99") ;// Resultado Final
				+ Transform(aGrpSrv[nPos,15]/aGrpSrv[nPos,16],"@E 999,999,999.9") //; // Prz Medio
				//				+ Transform((aGrpSrv[nPos,17]/aGrpSrv[nPos,2])*100,"@E 9999.9") // % Desc
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				//												+ Transform(aGrpSrv[nPos,12],"@E 99,999,999.99") ;// Cst/Dsp Fix
				//												+ Transform(aGrpSrv[nPos,13],"@E 99,999,999.99") ;// Dsp Dep/Adm
				//												+ Transform(aGrpSrv[nPos,14],"@E 99,999,999.99")  // Resultado Final
				
				@ nLin++ , 00 psay "  " + cTipo + U_FS_ImpRM_250(cString)
				
			Else
				nLin+= 2
				fwrite(outputfile," "+CHR(13)+CHR(10))
				cString := Transform(aGrpSrv[nPos,2],"@E 999,999,999.99"); // Venda Total
				+ Transform(aGrpSrv[nPos,3],"@E 99999,999.99");	// Impostos
				+ space(12);
				+ Transform(aGrpSrv[nPos,4],"@E 9999,999.99");	// ISS
				+ Transform(aGrpSrv[nPos,5],"@E 9999,999.99");	// PIS
				+ Transform(aGrpSrv[nPos,6],"@E 9999,999.99");	// Cofins
				+ Transform(aGrpSrv[nPos,7],"@E 99,999,999.99");	// Custo Srv
				+ Transform(aGrpSrv[nPos,8],"@E 99,999,999.99") + Transform(((aGrpSrv[nPos,8]/aGrpSrv[nPos,2])*100),"@E 9999.9") ;//Lucro Bruto
				+ space(13);
				+ Transform(aGrpSrv[nPos,9],"@E 99,999,999.99");	// Desp Var
				+ Transform(aGrpSrv[nPos,10],"@E 99,999,999.99");// Comissoes
				+ Transform(aGrpSrv[nPos,11],"@E 99,999,999.99");// Lucro Liq
				+ Transform(aGrpSrv[nPos,12]+aGrpSrv[nPos,13],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
				+ Transform(aGrpSrv[nPos,14],"@E 99,999,999.99") ;// Resultado Final
				+ Transform(aGrpSrv[nPos,15]/aGrpSrv[nPos,16],"@E 999,999,999.9") ;// Prz Medio
				+CHR(13)+CHR(10)
				//				+ Transform((aGrpSrv[nPos,17]/aGrpSrv[nPos,2])*100,"@E 9999.9") ;// % Desc
				fwrite(outputfile,"  " + cTipo + U_FS_ImpRM_250(cString))
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				//												+ Transform(aGrpSrv[nPos,12],"@E 99,999,999.99") ;// Cst/Dsp Fix
				//												+ Transform(aGrpSrv[nPos,13],"@E 99,999,999.99") ;// Dsp Dep/Adm
				//												+ Transform(aGrpSrv[nPos,14],"@E 99,999,999.99") ;// Resultado Final
				
			EndIf
		EndIf
		If MV_PAR04 >= 2
			If cDpto # aNumSrv[ni,17]
				cDpto := aNumSrv[ni,17]
				nPos := aScan(aDpto,{|x| x[1]+x[17]+x[18] == cDpto+"S"+aNumSrv[ni,1] })
				cImpDpto := "   " + Iif(!Empty(aDpto[nPos,1]),aDpto[nPos,1],"--") + " " + left(Iif(left(aDpto[nPos,16],3)#"...",aDpto[nPos,16],"")+repl(".",20),20)
				If FunName() == "OFIOR250"
					cString := Transform(aDpto[nPos,2],"@E 999,999,999.99") ;	// Venda Total
					+ Transform(aDpto[nPos,3],"@E 99999,999.99") ;	// Impostos
					+ space(12) ;
					+ Transform(aDpto[nPos,4],"@E 9999,999.99") ;	// ISS
					+ Transform(aDpto[nPos,5],"@E 9999,999.99") ;	// PIS
					+ Transform(aDpto[nPos,6],"@E 9999,999.99") ;	// Cofins
					+ Transform(aDpto[nPos,7],"@E 99,999,999.99"); // C.M.V.
					+ Transform(aDpto[nPos,8],"@E 99,999,999.99") + Transform(((aDpto[nPos,8]/aDpto[nPos,2])*100),"@E 9999.9");//Lucro Bruto
					+ space(13) ;
					+ Transform(aDpto[nPos,9],"@E 99,999,999.99"); // Desp Var
					+ Transform(aDpto[nPos,10],"@E 99,999,999.99");// Comissoes
					+ Transform(aDpto[nPos,11],"@E 99,999,999.99");// Lucro Liq
					+ Transform(aDpto[nPos,12]+aDpto[nPos,13],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
					+ Transform(aDpto[nPos,14],"@E 99,999,999.99") ;// Resultado Final
					+ Transform(aDpto[nPos,19]/aDpto[nPos,20],"@E 999,999,999.9") //	; // Prz Medio
					//					+ Transform((aDpto[nPos,21]/aDpto[nPos,2])*100,"@E 9999.9")	// % Desc
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					//				  								+ Transform(aDpto[nPos,12],"@E 99,999,999.99") ;// Cst/Dsp Fix
					//				  								+ Transform(aDpto[nPos,13],"@E 99,999,999.99") ;// Dsp Dep/Adm
					//				  								+ Transform(aDpto[nPos,14],"@E 99,999,999.99")  // Resultado Final
					
					@ nLin++ , 00 psay LEFT(cImpDpto+space(26),26) + U_FS_ImpRM_250(cString)
					
				Else
					nLin++
					fwrite(outputfile," "+CHR(13)+CHR(10))
					cString := Transform(aDpto[nPos,2],"@E 999,999,999.99") ;	// Venda Total
					+ Transform(aDpto[nPos,3],"@E 99999,999.99") ;	// Impostos
					+ space(12) ;
					+ Transform(aDpto[nPos,4],"@E 9999,999.99") ;	// ISS
					+ Transform(aDpto[nPos,5],"@E 9999,999.99") ;	// PIS
					+ Transform(aDpto[nPos,6],"@E 9999,999.99") ;	// Cofins
					+ Transform(aDpto[nPos,7],"@E 99,999,999.99"); // C.M.V.
					+ Transform(aDpto[nPos,8],"@E 99,999,999.99") + Transform(((aDpto[nPos,8]/aDpto[nPos,2])*100),"@E 9999.9");//Lucro Bruto
					+ space(13) ;
					+ Transform(aDpto[nPos,9],"@E 99,999,999.99"); // Desp Var
					+ Transform(aDpto[nPos,10],"@E 99,999,999.99");// Comissoes
					+ Transform(aDpto[nPos,11],"@E 99,999,999.99");// Lucro Liq
					+ Transform(aDpto[nPos,12]+aDpto[nPos,13],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
					+ Transform(aDpto[nPos,14],"@E 99,999,999.99") ;// Resultado Final
					+ Transform(aDpto[nPos,19]/aDpto[nPos,20],"@E 999,999,999.9") ;// Prz Medio
					+CHR(13)+CHR(10)
					//					+ Transform((aDpto[nPos,21]/aDpto[nPos,2])*100,"@E 9999.9") ;// % Desc
					
					fwrite(outputfile, cImpDpto + U_FS_ImpRM_250(cString))
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					//				  								+ Transform(aDpto[nPos,12],"@E 99,999,999.99") ;// Cst/Dsp Fix
					//				  								+ Transform(aDpto[nPos,13],"@E 99,999,999.99") ;// Dsp Dep/Adm
					//				  								+ Transform(aDpto[nPos,14],"@E 99,999,999.99") ;// Resultado Final
					
				EndIf
			EndIf
		EndIf
		If MV_PAR04 >= 3
			If FunName() == "OFIOR250"
				cString := Transform(aNumSrv[ni,4],"@E 999,999,999.99") ;	// Venda Total
				+ Transform(aNumSrv[ni,5],"@E 99999,999.99") ;	// Impostos
				+ space(12);
				+ Transform(aNumSrv[ni,6],"@E 9999,999.99");		// ISS
				+ Transform(aNumSrv[ni,7],"@E 9999,999.99");		// PIS
				+ Transform(aNumSrv[ni,8],"@E 9999,999.99");		// Cofins
				+ Transform(aNumSrv[ni,9],"@E 99,999,999.99");	// Custo Srv
				+ Transform(aNumSrv[ni,10],"@E 99,999,999.99")	+ Transform(((aNumSrv[ni,10]/aNumSrv[ni,4])*100),"@E 9999.9");//Lucro Bruto
				+ space(13);
				+ Transform(aNumSrv[ni,11],"@E 99,999,999.99");	// Desp Var
				+ Transform(aNumSrv[ni,12],"@E 99,999,999.99");	// Comissoes
				+ Transform(aNumSrv[ni,13],"@E 99,999,999.99");	// Lucro Liq
				+ Transform(aNumSrv[ni,14]+aNumSrv[ni,15],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
				+ Transform(aNumSrv[ni,16],"@E 99,999,999.99") ;// Resultado Final
				+ Transform(aNumSrv[ni,18]/aNumSrv[ni,19],"@E 999,999,999.9")//	; // Prz Medio
				//				+ Transform((aNumSrv[ni,20]/aNumSrv[ni,4])*100,"@E 9999.9")	// % Desc
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				//				  								+ Transform(aNumSrv[ni,14],"@E 99,999,999.99") ;// Cst/Dsp Fix
				//				  								+ Transform(aNumSrv[ni,15],"@E 99,999,999.99") ;// Dsp Dep/Adm
				//				  								+ Transform(aNumSrv[ni,16],"@E 99,999,999.99")  // Resultado Final
				
				@ nLin++ , 00 psay "    " + aNumSrv[ni,2] + " " + left(aNumSrv[ni,3],Iif(MV_PAR05==1,18,15)) + U_FS_ImpRM_250(cString)
				
			Else
				nLin++
				cString := Transform(aNumSrv[ni,4],"@E 999,999,999.99") ;	// Venda Total
				+ Transform(aNumSrv[ni,5],"@E 99999,999.99") ;	// Impostos
				+ space(12);
				+ Transform(aNumSrv[ni,6],"@E 9999,999.99");		// ISS
				+ Transform(aNumSrv[ni,7],"@E 9999,999.99");		// PIS
				+ Transform(aNumSrv[ni,8],"@E 9999,999.99");		// Cofins
				+ Transform(aNumSrv[ni,9],"@E 99,999,999.99");	// Custo Srv
				+ Transform(aNumSrv[ni,10],"@E 99,999,999.99")	+ Transform(((aNumSrv[ni,10]/aNumSrv[ni,4])*100),"@E 9999.9");//Lucro Bruto
				+ space(13);
				+ Transform(aNumSrv[ni,11],"@E 99,999,999.99");	// Desp Var
				+ Transform(aNumSrv[ni,12],"@E 99,999,999.99");	// Comissoes
				+ Transform(aNumSrv[ni,13],"@E 99,999,999.99");	// Lucro Liq
				+ Transform(aNumSrv[ni,14]+aNumSrv[ni,15],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
				+ Transform(aNumSrv[ni,16],"@E 99,999,999.99") ;// Resultado Final
				+ Transform(aNumSrv[ni,18]/aNumSrv[ni,19],"@E 999,999,999.9")	;// Prz Medio
				+CHR(13)+CHR(10)
				//				+ Transform((aNumSrv[ni,20]/aNumSrv[ni,4])*100,"@E 9999.9")	;// % Desc
				fwrite(outputfile,"    " + aNumSrv[ni,2] + " " + left(aNumSrv[ni,3],Iif(MV_PAR05==1,18,15)) ;
				+ U_FS_ImpRM_250(cString))
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				
			EndIf
		EndIf
	Next
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FS_M_OR25AA³ Autor ³ Andre Luis Almeida    ³ Data ³ 03/01/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao: Posicao das Vendas & Resultados - DESPESAS ACESS.³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_M_OR25AA(aDesAce)

///////////////////////////////////
// D E S P E S A S   A C E S S . //
///////////////////////////////////

If nLin >= 50
	If FunName() == "OFIOR250"
		nLin := 1
		nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
	Else
		nLin := 2
		fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
		fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
		fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
		fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cFil+".##r"+CHR(13)+CHR(10))
	EndIf
EndIf
If FunName() == "OFIOR250"
	nLin++
	@ nLin++ , 00 psay Repl("-",220)
	nLin++
	@ nLin++ , 00 psay STR0042 + STR0044
	@ nLin++ , 00 psay STR0043 + Transform(aDesAce[1,2],"@E 99,999,999.99") + space(35) + Transform(aDesAce[1,3],"@E 9999,999.99") + Transform(aDesAce[1,4],"@E 9999,999.99")
	nLin++
Else
	nLin+= 6
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,Repl("-",220)+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,STR0042 + STR0044+CHR(13)+CHR(10))
	fwrite(outputfile,STR0043 + Transform(aDesAce[1,2],"@E 99,999,999.99") + space(35) + Transform(aDesAce[1,3],"@E 9999,999.99") + Transform(aDesAce[1,4],"@E 9999,999.99")+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
EndIf
If MV_PAR04 >= 2
	If FunName() == "OFIOR250"
		@ nLin++ , 04 psay aDesAce[2,1] + Transform(aDesAce[2,2],"@E 999,999,999.99") + space(35) + Transform(aDesAce[2,3],"@E 9999,999.99") + Transform(aDesAce[2,4],"@E 9999,999.99")
		@ nLin++ , 04 psay aDesAce[3,1] + Transform(aDesAce[3,2],"@E 999,999,999.99") + space(35) + Transform(aDesAce[3,3],"@E 9999,999.99") + Transform(aDesAce[3,4],"@E 9999,999.99")
		@ nLin++ , 04 psay aDesAce[4,1] + Transform(aDesAce[4,2],"@E 999,999,999.99") + space(35) + Transform(aDesAce[4,3],"@E 9999,999.99") + Transform(aDesAce[4,4],"@E 9999,999.99")
		nLin++
	Else
		nLin+= 4
		fwrite(outputfile,space(4)+aDesAce[2,1] + Transform(aDesAce[2,2],"@E 999,999,999.99") + space(35) + Transform(aDesAce[2,3],"@E 9999,999.99") + Transform(aDesAce[2,4],"@E 9999,999.99")+CHR(13)+CHR(10))
		fwrite(outputfile,space(4)+aDesAce[3,1] + Transform(aDesAce[3,2],"@E 999,999,999.99") + space(35) + Transform(aDesAce[3,3],"@E 9999,999.99") + Transform(aDesAce[3,4],"@E 9999,999.99")+CHR(13)+CHR(10))
		fwrite(outputfile,space(4)+aDesAce[4,1] + Transform(aDesAce[4,2],"@E 999,999,999.99") + space(35) + Transform(aDesAce[4,3],"@E 9999,999.99") + Transform(aDesAce[4,4],"@E 9999,999.99")+CHR(13)+CHR(10))
		fwrite(outputfile," "+CHR(13)+CHR(10))
	EndIf
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_OR25AO³ Autor ³ Andre Luis Almeida    ³ Data ³ 03/01/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao: Posicao das Vendas & Resultados - OUTRAS VENDAS ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_OR25AO(aTotOOpe,aOOpeSrv,aOOpeOut)

///////////////////////////////////
//  O U T R A S     V E N D A S  //
///////////////////////////////////

If nLin >= 58
	If FunName() == "OFIOR250"
		nLin := 1
		nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
	Else
		nLin := 2
		fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
		fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
		fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
		fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cFil+".##r"+CHR(13)+CHR(10))
	EndIf
EndIf
If FunName() == "OFIOR250"
	@ nLin++ , 00 psay Repl("-",220)
	nLin++
	@ nLin++ , 00 psay STR0035 + cCabTot
	
	//	Manoel - 27/11/2008 - usando o campos Cst/Dsp Fix para mostrar Result ST - nao subtrai do RESFIN e sim do LUCBRU
	//	aTotOOpe[1, 9] := aTotOOpe[1, 1]-aTotOOpe[1, 2]-aTotOOpe[1, 7]
	//	aTotOOpe[1,12] := aTotOOpe[1, 9]-aTotOOpe[1, 8]-aTotOOpe[1,10]
	//	aTotOOpe[1,15] := aTotOOpe[1,12]-aTotOOpe[1,13]-aTotOOpe[1,14]
	aTotOOpe[1, 9] := aTotOOpe[1, 1]-aTotOOpe[1, 2]-aTotOOpe[1, 7]+aTotOOpe[1,13]+aTotOOpe[1,14]
	aTotOOpe[1,12] := aTotOOpe[1, 9]-aTotOOpe[1, 8]-aTotOOpe[1,10]
	aTotOOpe[1,15] := aTotOOpe[1,12]
	
	cString := Transform(aTotOOpe[1,1],"@E 999,999,999.99");//Venda Total
	+ Transform(aTotOOpe[1,2],"@E 99999,999.99");		// Impostos
	+ Transform(aTotOOpe[1,3],"@E 99999,999.99");		// ICMS
	+ Transform(aTotOOpe[1,4],"@E 9999,999.99");		// ISS
	+ Transform(aTotOOpe[1,5],"@E 9999,999.99");		// PIS
	+ Transform(aTotOOpe[1,6],"@E 9999,999.99");		// Cofins
	+ Transform(aTotOOpe[1,7],"@E 99,999,999.99");	// Custos
	+ Transform(aTotOOpe[1,9],"@E 99,999,999.99") + Transform(((aTotOOpe[1,9]/aTotOOpe[1,1])*100),"@E 9999.9");//Lucro Bruto
	+ Transform(aTotOOpe[1,8],"@E 99,999,999.99");	// Juro Estoque
	+ Transform(aTotOOpe[1,10],"@E 99,999,999.99");	// Desp Var
	+ Transform(aTotOOpe[1,11],"@E 99,999,999.99");	// Comissoes
	+ Transform(aTotOOpe[1,12],"@E 99,999,999.99");	// Lucro Liq
	+ Transform(aTotOOpe[1,13]+aTotOOpe[1,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
	+ Transform(aTotOOpe[1,15],"@E 99,999,999.99") ;// Resultado Final
	+ Transform(aTotOOpe[1,16]/aTotOOpe[1,17],"@E 999,999,999.9")	//; // Prz Medio
	//	+ Transform((aTotOOpe[1,18]/aTotOOpe[1,1])*100,"@E 9999.9")	// % Desc
	// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
	
	@ nLin++ , 00 psay LEFT(STR0036+space(26),26) + U_FS_ImpRM_250(cString) //left fnc 6573  STR0036 + U_FS_ImpRM_250(cString)
Else
	nLin+= 4
	fwrite(outputfile,Repl("-",220)+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,STR0035 + cCabTot+CHR(13)+CHR(10))
	cString := Transform(aTotOOpe[1,1],"@E 99,999,999.99");//Venda Total
	+ Transform(aTotOOpe[1,2],"@E 99999,999.99");		// Impostos
	+ Transform(aTotOOpe[1,3],"@E 99999,999.99");		// ICMS
	+ Transform(aTotOOpe[1,4],"@E 9999,999.99");		// ISS
	+ Transform(aTotOOpe[1,5],"@E 9999,999.99");		// PIS
	+ Transform(aTotOOpe[1,6],"@E 9999,999.99");		// Cofins
	+ Transform(aTotOOpe[1,7],"@E 99,999,999.99");	// Custos
	+ Transform(aTotOOpe[1,9],"@E 99,999,999.99") + Transform(((aTotOOpe[1,9]/aTotOOpe[1,1])*100),"@E 9999.9");//Lucro Bruto
	+ Transform(aTotOOpe[1,8],"@E 99,999,999.99");	// Juro Estoque
	+ Transform(aTotOOpe[1,10],"@E 99,999,999.99");	// Desp Var
	+ Transform(aTotOOpe[1,11],"@E 99,999,999.99");	// Comissoes
	+ Transform(aTotOOpe[1,12],"@E 99,999,999.99");	// Lucro Liq
	+ Transform(aTotOOpe[1,13]+aTotOOpe[1,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
	+ Transform(aTotOOpe[1,15],"@E 99,999,999.99") ;// Resultado Final
	+ Transform(aTotOOpe[1,16]/aTotOOpe[1,17],"@E 999,999,999.9");// Prz Medio
	+CHR(13)+CHR(10)
	//	+ Transform((aTotOOpe[1,18]/aTotOOpe[1,1])*100,"@E 9999.9");// % Desc
	fwrite(outputfile,STR0036 + U_FS_ImpRM_250(cString))
	// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
	
EndIf
If MV_PAR04 >= 2
	If FunName() == "OFIOR250"
		//		Manoel - 27/11/2008 - usando o campos Cst/Dsp Fix para mostrar Result ST - nao subtrai do RESFIN e sim do LUCBRU
		//		nLucBru := aOOpeSrv[1,01]-aOOpeSrv[1,02]-aOOpeSrv[1,07]
		//		nLucLiq := nLucBru-aOOpeSrv[1,08]-aOOpeSrv[1,10]-aOOpeSrv[1,11]
		//		nResFin := nLucLiq-aOOpeSrv[1,13]-aOOpeSrv[1,14]
		nLucBru := aOOpeSrv[1,01]-aOOpeSrv[1,02]-aOOpeSrv[1,07]+aOOpeSrv[1,13]+aOOpeSrv[1,14]
		nLucLiq := nLucBru-aOOpeSrv[1,08]-aOOpeSrv[1,10]-aOOpeSrv[1,11]
		nResFin := nLucLiq
		
		// Manoel (03/06/2008) - Inclusao da NF de Complemento de ICMS
		//		aOOpeOut[1, 9] := aOOpeOut[1, 1]-aOOpeOut[1, 2]-aOOpeOut[1, 7]
		//		aOOpeOut[1,12] := aOOpeOut[1, 9]-aOOpeOut[1, 8]-aOOpeOut[1,10]
		//		aOOpeOut[1,15] := aOOpeOut[1,12]-aOOpeOut[1,13]-aOOpeOut[1,14]
		//		Manoel - 27/11/2008 - usando o campos Cst/Dsp Fix para mostrar Result ST - nao subtrai do RESFIN e sim do LUCBRU
		aOOpeOut[1, 9] := aOOpeOut[1, 1]-aOOpeOut[1, 2]-aOOpeOut[1, 7]+aOOpeOut[1,13]+aOOpeOut[1,14]
		aOOpeOut[1,12] := aOOpeOut[1, 9]-aOOpeOut[1, 8]-aOOpeOut[1,10]
		aOOpeOut[1,15] := aOOpeOut[1,12]
		
		nLin++
		cString := Transform(aOOpeSrv[1,1],"@E 999,999,999.99");//Venda Total
		+ Transform(aOOpeSrv[1,2],"@E 99999,999.99");		// Impostos
		+ Transform(aOOpeSrv[1,3],"@E 99999,999.99");		// ICMS
		+ Transform(aOOpeSrv[1,4],"@E 9999,999.99");		// ISS
		+ Transform(aOOpeSrv[1,5],"@E 9999,999.99");		// PIS
		+ Transform(aOOpeSrv[1,6],"@E 9999,999.99");		// Cofins
		+ Transform(aOOpeSrv[1,7],"@E 99,999,999.99");	// Custos
		+ Transform(nLucBru,"@E 99,999,999.99") + Transform(((nLucBru/aOOpeSrv[1,1])*100),"@E 9999.9");//Lucro Bruto
		+ Transform(aOOpeSrv[1,8],"@E 99,999,999.99");	// Juro Estoque
		+ Transform(aOOpeSrv[1,10],"@E 99,999,999.99");	// Desp Var
		+ Transform(aOOpeSrv[1,11],"@E 99,999,999.99");	// Comissoes
		+ Transform(nLucLiq,"@E 99,999,999.99");	// Lucro Liq
		+ Transform(aOOpeSrv[1,13]+aOOpeSrv[1,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
		+ Transform(nResFin,"@E 99,999,999.99") ;// Resultado Final
		+ Transform(aOOpeSrv[1,16]/aOOpeSrv[1,17],"@E 999,999,999.9") //	; // Prz Medio
		//		+ Transform((aOOpeSrv[1,18]/aOOpeSrv[1,1])*100,"@E 9999.9")	// % Desc
		// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
		
		@ nLin++ , 04 psay STR0037 + U_FS_ImpRM_250(cString)
		
		
		cString := Transform(aOOpeOut[1,1],"@E 999,999,999.99");//Venda Total
		+ Transform(aOOpeOut[1,2],"@E 99999,999.99");		// Impostos
		+ Transform(aOOpeOut[1,3],"@E 99999,999.99");		// ICMS
		+ Transform(aOOpeOut[1,4],"@E 9999,999.99");		// ISS
		+ Transform(aOOpeOut[1,5],"@E 9999,999.99");		// PIS
		+ Transform(aOOpeOut[1,6],"@E 9999,999.99");		// Cofins
		+ Transform(aOOpeOut[1,7],"@E 99,999,999.99");	// Custos
		+ Transform(aOOpeOut[1,9],"@E 99,999,999.99") + Transform(((aOOpeOut[1,9]/aOOpeOut[1,1])*100),"@E 9999.9");//Lucro Bruto
		+ Transform(aOOpeOut[1,8],"@E 99,999,999.99");	// Juro Estoque
		+ Transform(aOOpeOut[1,10],"@E 99,999,999.99");	// Desp Var
		+ Transform(aOOpeOut[1,11],"@E 99,999,999.99");	// Comissoes
		+ Transform(aOOpeOut[1,12],"@E 99,999,999.99");	// Lucro Liq
		+ Transform(aOOpeOut[1,13]+aOOpeOut[1,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
		+ Transform(aOOpeOut[1,15],"@E 99,999,999.99") ;// Resultado Final
		+ Transform(aOOpeOut[1,16]/aOOpeOut[1,17],"@E 999,999,999.9")//	;// Prz Medio
		//		+ Transform((aOOpeOut[1,18]/aOOpeOut[1,1])*100,"@E 9999.9")	// % Desc
		// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
		
		@ nLin++ , 04 psay STR0038 + U_FS_ImpRM_250(cString)
		
		// Manoel (03/06/2008) - Inclusao da NF de Complemento de ICMS
		//		aOOpeOutV[1, 9] := aOOpeOutV[1, 1]-aOOpeOutV[1, 2]-aOOpeOutV[1, 7]
		//		aOOpeOutV[1,12] := aOOpeOutV[1, 9]-aOOpeOutV[1, 8]-aOOpeOutV[1,10]
		//		aOOpeOutV[1,15] := aOOpeOutV[1,12]-aOOpeOutV[1,13]-aOOpeOutV[1,14]
		
		//		Manoel - 27/11/2008 - usando o campos Cst/Dsp Fix para mostrar Result ST - nao subtrai do RESFIN e sim do LUCBRU
		aOOpeOutV[1, 9] := aOOpeOutV[1, 1]-aOOpeOutV[1, 2]-aOOpeOutV[1, 7]+aOOpeOutV[1,13]+aOOpeOutV[1,14]
		aOOpeOutV[1,12] := aOOpeOutV[1, 9]-aOOpeOutV[1, 8]-aOOpeOutV[1,10]
		aOOpeOutV[1,15] := aOOpeOutV[1,12]
		cString := Transform(aOOpeOutV[1,1],"@E 999,999,999.99");//Venda Total
		+ Transform(aOOpeOutV[1,2],"@E 99999,999.99");		// Impostos
		+ Transform(aOOpeOutV[1,3],"@E 99999,999.99");		// ICMS
		+ Transform(aOOpeOutV[1,4],"@E 9999,999.99");		// ISS
		+ Transform(aOOpeOutV[1,5],"@E 9999,999.99");		// PIS
		+ Transform(aOOpeOutV[1,6],"@E 9999,999.99");		// Cofins
		+ Transform(aOOpeOutV[1,7],"@E 99,999,999.99");	// Custos
		+ Transform(aOOpeOutV[1,9],"@E 99,999,999.99") + Transform(((aOOpeOutV[1,9]/aOOpeOutV[1,1])*100),"@E 9999.9");//Lucro Bruto
		+ Transform(aOOpeOutV[1,8],"@E 99,999,999.99");	// Juro Estoque
		+ Transform(aOOpeOutV[1,10],"@E 99,999,999.99");	// Desp Var
		+ Transform(aOOpeOutV[1,11],"@E 99,999,999.99");	// Comissoes
		+ Transform(aOOpeOutV[1,12],"@E 99,999,999.99");	// Lucro Liq
		+ Transform(aOOpeOutV[1,13]+aOOpeOutV[1,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
		+ Transform(aOOpeOutV[1,15],"@E 99,999,999.99") ;// Resultado Final
		+ Transform(aOOpeOutV[1,16]/aOOpeOutV[1,17],"@E 999,999,999.9")   //	;// Prz Medio
		//		+ Transform((aOOpeOutV[1,18]/aOOpeOutV[1,1])*100,"@E 9999.9")	// % Desc
		// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
		
		@ nLin++ , 04 psay "Veiculos Novos........" + U_FS_ImpRM_250(cString)
		
		//		aOOpeOutV[1, 9] := aOOpeOutU[1, 1]-aOOpeOutU[1, 2]-aOOpeOutU[1, 7]
		//		aOOpeOutV[1,12] := aOOpeOutU[1, 9]-aOOpeOutU[1, 8]-aOOpeOutU[1,10]
		//		aOOpeOutV[1,15] := aOOpeOutU[1,12]-aOOpeOutU[1,13]-aOOpeOutU[1,14]
		//		Manoel - 27/11/2008 - usando o campos Cst/Dsp Fix para mostrar Result ST - nao subtrai do RESFIN e sim do LUCBRU
		aOOpeOutV[1, 9] := aOOpeOutU[1, 1]-aOOpeOutU[1, 2]-aOOpeOutU[1, 7]+aOOpeOutU[1,13]+aOOpeOutU[1,14]
		aOOpeOutV[1,12] := aOOpeOutU[1, 9]-aOOpeOutU[1, 8]-aOOpeOutU[1,10]
		aOOpeOutV[1,15] := aOOpeOutU[1,12]
		cString := Transform(aOOpeOutU[1,1],"@E 999,999,999.99");//Venda Total
		+ Transform(aOOpeOutU[1,2],"@E 99999,999.99");		// Impostos
		+ Transform(aOOpeOutU[1,3],"@E 99999,999.99");		// ICMS
		+ Transform(aOOpeOutU[1,4],"@E 9999,999.99");		// ISS
		+ Transform(aOOpeOutU[1,5],"@E 9999,999.99");		// PIS
		+ Transform(aOOpeOutU[1,6],"@E 9999,999.99");		// Cofins
		+ Transform(aOOpeOutU[1,7],"@E 99,999,999.99");	// Custos
		+ Transform(aOOpeOutU[1,9],"@E 99,999,999.99") + Transform(((aOOpeOutU[1,9]/aOOpeOutU[1,1])*100),"@E 9999.9");//Lucro Bruto
		+ Transform(aOOpeOutU[1,8],"@E 99,999,999.99");	// Juro Estoque
		+ Transform(aOOpeOutU[1,10],"@E 99,999,999.99");	// Desp Var
		+ Transform(aOOpeOutU[1,11],"@E 99,999,999.99");	// Comissoes
		+ Transform(aOOpeOutU[1,12],"@E 99,999,999.99");	// Lucro Liq
		+ Transform(aOOpeOutU[1,13]+aOOpeOutU[1,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
		+ Transform(aOOpeOutU[1,15],"@E 99,999,999.99") ;// Resultado Final
		+ Transform(aOOpeOutU[1,16]/aOOpeOutU[1,17],"@E 999,999,999.9")   //	;// Prz Medio
		//		+ Transform((aOOpeOutU[1,18]/aOOpeOutU[1,1])*100,"@E 9999.9")	// % Desc
		// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
		
		@ nLin++ , 04 psay "Veiculos Usados......." + U_FS_ImpRM_250(cString)
		
	Else
		nLin+= 3
		//		nLucBru := aOOpeSrv[1,01]-aOOpeSrv[1,02]-aOOpeSrv[1,07]
		//		nLucLiq := nLucBru-aOOpeSrv[1,08]-aOOpeSrv[1,10]-aOOpeSrv[1,11]
		//		nResFin := nLucLiq-aOOpeSrv[1,13]-aOOpeSrv[1,14]
		//		Manoel - 27/11/2008 - usando o campos Cst/Dsp Fix para mostrar Result ST - nao subtrai do RESFIN e sim do LUCBRU
		nLucBru := aOOpeSrv[1,01]-aOOpeSrv[1,02]-aOOpeSrv[1,07]+aOOpeSrv[1,13]+aOOpeSrv[1,14]
		nLucLiq := nLucBru-aOOpeSrv[1,08]-aOOpeSrv[1,10]-aOOpeSrv[1,11]
		nResFin := nLucLiq
		fwrite(outputfile," "+CHR(13)+CHR(10))
		cString := Transform(aOOpeSrv[1,1],"@E 999,999,999.99");//Venda Total
		+ Transform(aOOpeSrv[1,2],"@E 99999,999.99");		// Impostos
		+ Transform(aOOpeSrv[1,3],"@E 99999,999.99");		// ICMS
		+ Transform(aOOpeSrv[1,4],"@E 9999,999.99");		// ISS
		+ Transform(aOOpeSrv[1,5],"@E 9999,999.99");		// PIS
		+ Transform(aOOpeSrv[1,6],"@E 9999,999.99");		// Cofins
		+ Transform(aOOpeSrv[1,7],"@E 99,999,999.99");	// Custos
		+ Transform(nLucBru,"@E 99,999,999.99") + Transform(((nLucBru/aOOpeSrv[1,1])*100),"@E 9999.9");//Lucro Bruto
		+ Transform(aOOpeSrv[1,8],"@E 99,999,999.99");	// Juro Estoque
		+ Transform(aOOpeSrv[1,10],"@E 99,999,999.99");	// Desp Var
		+ Transform(aOOpeSrv[1,11],"@E 99,999,999.99");	// Comissoes
		+ Transform(nLucLiq,"@E 99,999,999.99");	// Lucro Liq
		+ Transform(aOOpeSrv[1,13]+aOOpeSrv[1,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
		+ Transform(nResFin,"@E 99,999,999.99") ;// Resultado Final
		+ Transform(aOOpeSrv[1,16]/aOOpeSrv[1,17],"@E 999,999,999.9");//Prz Medio
		+CHR(13)+CHR(10)
		//		+ Transform((aOOpeSrv[1,18]/aOOpeSrv[1,1])*100,"@E 9999.9");//% Desc
		fwrite(outputfile,space(4)+STR0037 + U_FS_ImpRM_250(cString))
		// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
		
		cString := Transform(aOOpeOut[1,1],"@E 999,999,999.99");//Venda Total
		+ Transform(aOOpeOut[1,2],"@E 99999,999.99");		// Impostos
		+ Transform(aOOpeOut[1,3],"@E 99999,999.99");		// ICMS
		+ Transform(aOOpeOut[1,4],"@E 9999,999.99");		// ISS
		+ Transform(aOOpeOut[1,5],"@E 9999,999.99");		// PIS
		+ Transform(aOOpeOut[1,6],"@E 9999,999.99");		// Cofins
		+ Transform(aOOpeOut[1,7],"@E 99,999,999.99");	// Custos
		+ Transform(aOOpeOut[1,9],"@E 99,999,999.99") + Transform(((aOOpeOut[1,9]/aOOpeOut[1,1])*100),"@E 9999.9");//Lucro Bruto
		+ Transform(aOOpeOut[1,8],"@E 99,999,999.99");	// Juro Estoque
		+ Transform(aOOpeOut[1,10],"@E 99,999,999.99");	// Desp Var
		+ Transform(aOOpeOut[1,11],"@E 99,999,999.99");	// Comissoes
		+ Transform(aOOpeOut[1,12],"@E 99,999,999.99");	// Lucro Liq
		+ Transform(aOOpeOut[1,13]+aOOpeOut[1,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
		+ Transform(aOOpeOut[1,15],"@E 99,999,999.99") ;// Resultado Final
		+ Transform(aOOpeOut[1,16]/aOOpeOut[1,17],"@E 999,999,999.9")	;// Prz Medio
		+CHR(13)+CHR(10)
		//		+ Transform((aOOpeOut[1,18]/aOOpeOut[1,1])*100,"@E 9999.9")	;// % Desc
		fwrite(outputfile,space(4)+STR0038 + U_FS_ImpRM_250(cString))
		
	EndIf
EndIf

If FunName() == "OFIOR250"
	nLin++
	@ nLin++ , 00 psay Repl("-",220)
Else
	nLin+= 2
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,Repl("-",220)+CHR(13)+CHR(10))
EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_OR25AM³ Autor ³ Andre Luis Almeida    ³ Data ³ 03/01/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao: Posicao das Vendas & Resultados -ATIVO IMOBILIZ.³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_OR25AM(aTotAtiMob,aNumAtiMob)

///////////////////////////////////
//  A T I V O   I M O B I L I Z. //
///////////////////////////////////

local ni := 0
aSort(aNumAtiMob,1,,{|x,y| x[1]+x[2] < y[1]+y[2]})
If nLin >= 58
	If FunName() == "OFIOR250"
		nLin := 1
		nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
	Else
		nLin := 2
		fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
		fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
		fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
		fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cFil+".##r"+CHR(13)+CHR(10))
	EndIf
EndIf
If FunName() == "OFIOR250"
	nLin++
	@ nLin++ , 00 psay STR0046 + STR0048
	@ nLin++ , 00 psay STR0047 + Transform(aTotAtiMob[1,3],"@E 99,999,999.99") + Transform(aTotAtiMob[1,4],"@E 99999,999.99") + Transform(aTotAtiMob[1,5],"@E 99999,999.99") + space(11) + Transform(aTotAtiMob[1,6],"@E 9999,999.99") + Transform(aTotAtiMob[1,7],"@E 9999,999.99") + Transform(aTotAtiMob[1,8],"@E 99,999,999.99")
Else
	nLin+= 3
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,STR0046 + STR0048+CHR(13)+CHR(10))
	fwrite(outputfile,STR0047 + Transform(aTotAtiMob[1,3],"@E 99,999,999.99") + Transform(aTotAtiMob[1,4],"@E 99999,999.99") + Transform(aTotAtiMob[1,5],"@E 99999,999.99") + space(11) + Transform(aTotAtiMob[1,6],"@E 9999,999.99") + Transform(aTotAtiMob[1,7],"@E 9999,999.99") + Transform(aTotAtiMob[1,8],"@E 99,999,999.99")+CHR(13)+CHR(10))
EndIf
If MV_PAR04 >= 2
	If Len(aNumAtiMob) > 0
		If FunName() == "OFIOR250"
			nLin++
		Else
			nLin++
			fwrite(outputfile," "+CHR(13)+CHR(10))
		EndIf
	EndIf
	For ni:=1 to Len(aNumAtiMob)
		If FunName() == "OFIOR250"
			nCont ++
			If nCont == 400
				IncRegua()
				nCont := 2
				If lAbortPrint
					nLin++
					@nLin++,30 PSAY STR0058 //"* * *  C A N C E L A D O   P E L O   O P E R A D O R  * * *"
					Exit
				EndIf
			EndIf
		EndIf
		If nLin >= 58
			If FunName() == "OFIOR250"
				nLin := 1
				nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
				nLin++
				@ nLin++ , 27 psay STR0048
				nLin++
			Else
				nLin := 4
				fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
				fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
				fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
				fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cFil+".##r"+CHR(13)+CHR(10))
				fwrite(outputfile," "+CHR(13)+CHR(10))
				fwrite(outputfile,space(27)+STR0048+CHR(13)+CHR(10))
				fwrite(outputfile," "+CHR(13)+CHR(10))
			EndIf
		EndIf
		If cMudou # aNumAtiMob[ni,1]
			cMudou := aNumAtiMob[ni,1]
			nPos := aScan(aTotAtiMob,{|x| x[1] == cMudou })
			If MV_PAR04 >= 3
				If FunName() == "OFIOR250"
					nLin++
				Else
					nLin++
					fwrite(outputfile," "+CHR(13)+CHR(10))
				EndIf
			EndIf
			If	nPos > 0
				If FunName() == "OFIOR250"
					@ nLin++ , 05 psay aTotAtiMob[nPos,2] + Transform(aTotAtiMob[nPos,3],"@E 99,999,999.99") + Transform(aTotAtiMob[nPos,4],"@E 99999,999.99") + Transform(aTotAtiMob[nPos,5],"@E 99999,999.99") + space(11) + Transform(aTotAtiMob[nPos,6],"@E 9999,999.99") + Transform(aTotAtiMob[nPos,7],"@E 9999,999.99") + Transform(aTotAtiMob[nPos,8],"@E 99,999,999.99")
				Else
					nLin++
					fwrite(outputfile,space(5)+aTotAtiMob[nPos,2] + Transform(aTotAtiMob[nPos,3],"@E 99,999,999.99") + Transform(aTotAtiMob[nPos,4],"@E 99999,999.99") + Transform(aTotAtiMob[nPos,5],"@E 99999,999.99") + space(11) + Transform(aTotAtiMob[nPos,6],"@E 9999,999.99") + Transform(aTotAtiMob[nPos,7],"@E 9999,999.99") + Transform(aTotAtiMob[nPos,8],"@E 99,999,999.99")+CHR(13)+CHR(10))
				EndIf
			EndIf
		EndIf
		If MV_PAR04 >= 3
			If FunName() == "OFIOR250"
				@ nLin++ , 08 psay left(aNumAtiMob[ni,2],19) + Transform(aNumAtiMob[ni,3],"@E 99,999,999.99") + Transform(aNumAtiMob[ni,4],"@E 99999,999.99") + Transform(aNumAtiMob[ni,5],"@E 99999,999.99") + space(11) + Transform(aNumAtiMob[ni,6],"@E 9999,999.99") + Transform(aNumAtiMob[ni,7],"@E 9999,999.99") + Transform(aNumAtiMob[ni,8],"@E 99,999,999.99")
			Else
				nLin++
				fwrite(outputfile,space(8)+left(aNumAtiMob[ni,2],19) + Transform(aNumAtiMob[ni,3],"@E 99,999,999.99") + Transform(aNumAtiMob[ni,4],"@E 99999,999.99") + Transform(aNumAtiMob[ni,5],"@E 99999,999.99") + space(11) + Transform(aNumAtiMob[ni,6],"@E 9999,999.99") + Transform(aNumAtiMob[ni,7],"@E 9999,999.99") + Transform(aNumAtiMob[ni,8],"@E 99,999,999.99")+CHR(13)+CHR(10))
			EndIf
		EndIf
	Next
EndIf
If FunName() == "OFIOR250"
	nLin++
	@ nLin++ , 00 psay Repl("-",220)
Else
	nLin+= 2
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,Repl("-",220)+CHR(13)+CHR(10))
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_OR25AD³ Autor ³ Andre Luis Almeida    ³ Data ³ 03/01/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao: Posicao das Vendas & Resultados - DEVOLUCOES    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_OR25AD(aTotDev,aNumDev)

///////////////////////////////////
//      D E V O L U C O E S      //
///////////////////////////////////

local ni := 0
aSort(aNumDev,1,,{|x,y| left(x[10],1)+x[12]+x[10]+x[2] < left(y[10],1)+y[12]+y[10]+y[2]})
If nLin >= 58
	If FunName() == "OFIOR250"
		nLin := 1
		nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
	Else
		nLin := 2
		fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
		fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
		fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
		fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cFil+".##r"+CHR(13)+CHR(10))
	EndIf
EndIf
If FunName() == "OFIOR250"
	nLin++
	@ nLin++ , 00 psay STR0039 + STR0041
	@ nLin++ , 00 psay STR0040 + Transform(aTotDev[1,1],"@E 99,999,999.99") + Transform(aTotDev[1,2],"@E 99999,999.99") + Transform(aTotDev[1,3],"@E 99999,999.99") + Transform(aTotDev[1,4],"@E 9999,999.99") + Transform(aTotDev[1,5],"@E 9999,999.99") + Transform(aTotDev[1,6],"@E 9999,999.99") + Transform(aTotDev[1,7],"@E 99,999,999.99") + Transform(aTotDev[1,9],"@E 99,999,999.99") + Transform(aTotDev[1,8],"@E 99,999,999.99") + Transform(((aTotDev[1,8]/aTotDev[1,1])*100),"@E 9999.9")
Else
	nLin+= 3
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,STR0039 + STR0041 +CHR(13)+CHR(10))
	fwrite(outputfile,STR0040 + Transform(aTotDev[1,1],"@E 99,999,999.99") + Transform(aTotDev[1,2],"@E 99999,999.99") + Transform(aTotDev[1,3],"@E 99999,999.99") + Transform(aTotDev[1,4],"@E 9999,999.99") + Transform(aTotDev[1,5],"@E 9999,999.99") + Transform(aTotDev[1,6],"@E 9999,999.99") + Transform(aTotDev[1,7],"@E 99,999,999.99") + Transform(aTotDev[1,8],"@E 99,999,999.99") + Transform(aTotDev[1,9],"@E 99,999,999.99") + Transform(((aTotDev[1,8]/aTotDev[1,1])*100),"@E 9999.9")+CHR(13)+CHR(10))
EndIf
If MV_PAR04 >= 3
	If FunName() == "OFIOR250"
		nLin++
	Else
		nLin++
		fwrite(outputfile," "+CHR(13)+CHR(10))
	EndIf
	For ni:=1 to Len(aNumDev)
		If FunName() == "OFIOR250"
			nCont ++
			If nCont == 400
				IncRegua()
				nCont := 2
				If lAbortPrint
					nLin++
					@nLin++,30 PSAY STR0058 //"* * *  C A N C E L A D O   P E L O   O P E R A D O R  * * *"
					Exit
				EndIf
			EndIf
		EndIf
		If nLin >= 58
			If FunName() == "OFIOR250"
				nLin := 1
				nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
				nLin++
				@ nLin++ , 27 psay STR0041
				nLin++
			Else
				nLin := 4
				fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
				fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
				fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
				fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cFil+".##r"+CHR(13)+CHR(10))
				fwrite(outputfile," "+CHR(13)+CHR(10))
				fwrite(outputfile,space(27)+STR0041+CHR(13)+CHR(10))
				fwrite(outputfile," "+CHR(13)+CHR(10))
			EndIf
		EndIf
		cSeekDev := ""
		If left(aNumDev[ni,10],2) == "00"
			cSeekDev := STR0066
		ElseIf left(aNumDev[ni,10],2) == "01"
			cSeekDev := STR0067
		ElseIf left(aNumDev[ni,10],2) == "02"
			cSeekDev := STR0068
		ElseIf left(aNumDev[ni,10],2) == "03"
			cSeekDev := STR0069
		ElseIf left(aNumDev[ni,10],2) == "04"
			cSeekDev := STR0070
		ElseIf left(aNumDev[ni,10],2) == "10"
			cSeekDev := STR0071
		ElseIf left(aNumDev[ni,10],2) == "21"
			cSeekDev := STR0072
		ElseIf left(aNumDev[ni,10],2) == "22"
			cSeekDev := STR0073
		ElseIf left(aNumDev[ni,10],2) == "23"
			cSeekDev := STR0074
		ElseIf left(aNumDev[ni,10],2) == "24"
			cSeekDev := STR0075
		EndIf
		If FunName() == "OFIOR250"
			@ nLin++ , 01 psay left(cSeekDev+Iif(!Empty(aNumDev[ni,12]),aNumDev[ni,12],"--")+" "+Alltrim(aNumDev[ni,1])+" "+aNumDev[ni,2]+space(25),25)+Transform(aNumDev[ni,3]+aNumDev[ni,14],"@E 999,999,999.99")+Transform(aNumDev[ni,4],"@E 99999,999.99")+Transform(aNumDev[ni,5],"@E 99999,999.99")+Transform(aNumDev[ni,6],"@E 9999,999.99")+Transform(aNumDev[ni,7],"@E 9999,999.99")+Transform(aNumDev[ni,8],"@E 9999,999.99")+Transform(aNumDev[ni,9],"@E 99,999,999.99")+Transform(aNumDev[ni,11],"@E 99,999,999.99")+Transform(((aNumDev[ni,11]/(aNumDev[ni,3]+aNumDev[ni,14]))*100),"@E 9999.9")
		Else
			nLin++
			fwrite(outputfile," "+left(cSeekDev+Iif(!Empty(aNumDev[ni,12]),aNumDev[ni,12],"--")+" "+Alltrim(aNumDev[ni,1])+" "+aNumDev[ni,2]+space(25),25)+Transform(aNumDev[ni,3]+aNumDev[ni,14],"@E 999,999,999.99")+Transform(aNumDev[ni,4],"@E 99999,999.99")+Transform(aNumDev[ni,5],"@E 99999,999.99")+Transform(aNumDev[ni,6],"@E 9999,999.99")+Transform(aNumDev[ni,7],"@E 9999,999.99")+Transform(aNumDev[ni,8],"@E 9999,999.99")+Transform(aNumDev[ni,9],"@E 99,999,999.99")+Transform(aNumDev[ni,11],"@E 99,999,999.99")+Transform(((aNumDev[ni,11]/(aNumDev[ni,3]+aNumDev[ni,14]))*100),"@E 9999.9")+CHR(13)+CHR(10))
		EndIf
	Next
EndIf
If FunName() == "OFIOR250"
	nLin++
	@ nLin++ , 00 psay Repl("*",220)
Else
	nLin+= 2
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,Repl("*",220)+CHR(13)+CHR(10))
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_OR25AE³ Autor ³ Andre Luis Almeida      ³ Data ³ 03/01/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao: Posicao das Vendas & Resultados - VALORES ENTRADAS³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_OR25AE(aTotEnt,aGrpEnt,aNumEnt,aEntrad)

///////////////////////////////////
//V A L O R E S   E N T R A D A S//
///////////////////////////////////

local ni := 0
If nLin >= 55
	If FunName() == "OFIOR250"
		nLin := 1
		nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
	Else
		nLin := 2
		fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
		fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
		fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
		fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cFil+".##r"+CHR(13)+CHR(10))
	EndIf
EndIf
If FunName() == "OFIOR250"
	nLin++
	nLin++
	@ nLin++ , 00 psay STR0032
	nLin++
	@ nLin++ , 40 psay STR0033
	@ nLin++ , 00 psay STR0034 + Transform(aTotEnt[1,1],"@E 99,999,999.99")
Else
	nLin+= 6
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,STR0032+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,space(40)+STR0033+CHR(13)+CHR(10))
	fwrite(outputfile,STR0034 + Transform(aTotEnt[1,1],"@E 99,999,999.99")+CHR(13)+CHR(10))
EndIf
aSort(aNumEnt,1,,{|x,y| x[1]+x[2] < y[1]+y[2]})
aSort(aEntrad,1,,{|x,y| x[1] < y[1]})
If MV_PAR04 >= 3
	For ni:=1 to Len(aEntrad)
		If nLin >= 60
			If FunName() == "OFIOR250"
				nLin := 1
				nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
				nLin++
				@ nLin++ , 40 psay STR0033
				nLin++
			Else
				nLin := 4
				fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
				fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
				fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
				fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cFil+".##r"+CHR(13)+CHR(10))
				fwrite(outputfile," "+CHR(13)+CHR(10))
				fwrite(outputfile,space(40)+STR0033+CHR(13)+CHR(10))
				fwrite(outputfile," "+CHR(13)+CHR(10))
			EndIf
		EndIf
		If !Empty(alltrim(aEntrad[ni,1]))
			If FunName() == "OFIOR250"
				@ nLin++ , 04 psay aEntrad[ni,1] + "  " + aEntrad[ni,2] + "  " + Transform(aEntrad[ni,3],"@E 99,999,999.99")
			Else
				nLin++
				fwrite(outputfile,space(4)+aEntrad[ni,1] + "  " + aEntrad[ni,2] + "  " + Transform(aEntrad[ni,3],"@E 99,999,999.99")+CHR(13)+CHR(10))
			EndIf
		EndIf
	Next
EndIf
cMudou := "9"
For ni:=1 to Len(aNumEnt)
	If FunName() == "OFIOR250"
		nCont ++
		If nCont == 400
			IncRegua()
			nCont := 2
			If lAbortPrint
				nLin++
				@nLin++,30 PSAY STR0058 //"* * *  C A N C E L A D O   P E L O   O P E R A D O R  * * *"
				Exit
			EndIf
		EndIf
	EndIf
	If nLin >= 60
		If FunName() == "OFIOR250"
			nLin := 1
			nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
			nLin++
			@ nLin++ , 40 psay STR0033
			nLin++
		Else
			nLin := 4
			fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
			fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
			fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
			fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cFil+".##r"+CHR(13)+CHR(10))
			fwrite(outputfile," "+CHR(13)+CHR(10))
			fwrite(outputfile,space(40)+STR0033+CHR(13)+CHR(10))
			fwrite(outputfile," "+CHR(13)+CHR(10))
		EndIf
	EndIf
	If cMudou # aNumEnt[ni,1]
		cMudou := aNumEnt[ni,1]
		nPos := aScan(aGrpEnt,{|x| x[1] == cMudou })
		If MV_PAR04 >= 3
			If FunName() == "OFIOR250"
				nLin++
			Else
				nLin++
				fwrite(outputfile," "+CHR(13)+CHR(10))
			EndIf
		EndIf
		If	nPos > 0
			If FunName() == "OFIOR250"
				@ nLin++ , 02 psay aGrpEnt[nPos,2] + " " + Transform(aGrpEnt[nPos,3],"@E 99,999,999.99")
			Else
				nLin++
				fwrite(outputfile,space(2)+aGrpEnt[nPos,2] + " " + Transform(aGrpEnt[nPos,3],"@E 99,999,999.99")+CHR(13)+CHR(10))
			EndIf
		EndIf
	EndIf
	If (MV_PAR04 >= 3 .and. !Empty(alltrim(aNumEnt[ni,2])))
		If FunName() == "OFIOR250"
			@ nLin++ , 04 psay aNumEnt[ni,2] + "  " + left(aNumEnt[ni,3],30) + "  " + Transform(aNumEnt[ni,4],"@E 99,999,999.99")
		Else
			nLin++
			fwrite(outputfile,space(4)+aNumEnt[ni,2] + "  " + left(aNumEnt[ni,3],30) + "  " + Transform(aNumEnt[ni,4],"@E 99,999,999.99")+CHR(13)+CHR(10))
		EndIf
	EndIf
Next
If FunName() == "OFIOR250"
	nLin++
	@ nLin++ , 00 psay Repl("*",220)
Else
	nLin+= 2
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,Repl("*",220)+CHR(13)+CHR(10))
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_OR25AC³ Autor ³ Andre Luis Almeida      ³ Data ³ 03/01/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao: Posicao das Vendas & Resultados - COND.PAGTO      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_OR25AC(aTotCon,aTotPag,aGrpPag,aPecSrvOfi,aConPagNF)
local ni := 0
Local nVlrExt := nVlrInt := 0
If FunName() == "OFIOR250"
	nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
Else
	nLin := 2
	fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
	fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
	fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
	fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cFil+".##r"+CHR(13)+CHR(10))
EndIf

If MV_PAR06 == 2 .or. MV_PAR06 == 3
	///////////////////////////////////
	// C O N D.  P A G A M E N T O S //
	///////////////////////////////////
	cString := Transform(aTotCon[1,1],"@E 99,999,999.99");//Venda Total
	+ Transform(aTotCon[1,2],"@E 99999,999.99");	// Impostos
	+ Transform(aTotCon[1,3],"@E 99999,999.99");	// ICMS
	+ Transform(aTotCon[1,4],"@E 9999,999.99");	// ISS
	+ Transform(aTotCon[1,5],"@E 9999,999.99");	// PIS
	+ Transform(aTotCon[1,6],"@E 9999,999.99");	// Cofins
	+ Transform(aTotCon[1,7],"@E 99,999,999.99");	// Custos
	+ Transform(aTotCon[1,9],"@E 99,999,999.99")+ Transform(((aTotCon[1,9]/aTotCon[1,1])*100),"@E 9999.9");//Lucro Bruto
	+ Transform(aTotCon[1,8],"@E 99,999,999.99");	// Juro Estoque
	+ Transform(aTotCon[1,10],"@E 99,999,999.99");// Desp Var
	+ Transform(aTotCon[1,11],"@E 99,999,999.99");// Comissoes
	+ Transform(aTotCon[1,12],"@E 99,999,999.99");// Lucro Liq
	+ Transform(aTotCon[1,13]+aTotCon[1,14],"@E 99,999,999.99") ;// Cst/Dsp F + Dsp Dep/Adm
	+ Transform(aTotCon[1,15],"@E 99,999,999.99") ;// Resultado Final
	+ Transform(aTotCon[1,16]/aTotCon[1,17],"@E 999,999,999.9") //; // Prz Medio
	//	+ Transform((aTotCon[1,18]/aTotCon[1,1])*100,"@E 9999.9")	// % Desc
	If FunName() == "OFIOR250"
		nLin+=2
		@ nLin++ , 62 psay STR0025
		nLin+=2
		@ nLin++ , 00 psay STR0026 + cCabTot
		@ nLin++ , 00 psay STR0027 + U_FS_ImpRM_250(cString)
	Else
		nLin+= 7
		fwrite(outputfile," "+CHR(13)+CHR(10))
		fwrite(outputfile," "+CHR(13)+CHR(10))
		fwrite(outputfile,space(62)+STR0025+CHR(13)+CHR(10))
		fwrite(outputfile," "+CHR(13)+CHR(10))
		fwrite(outputfile," "+CHR(13)+CHR(10))
		fwrite(outputfile,STR0026 + cCabTot+CHR(13)+CHR(10))
		cString += CHR(13)+CHR(10)
		fwrite(outputfile,STR0027 + U_FS_ImpRM_250(cString))
	EndIf
	aSort(aTotPag,1,,{|x,y| x[1]+x[2] < y[1]+y[2]})
	aSort(aConPagNF,1,,{|x,y| x[1]+x[2]+x[7]+x[3] < y[1]+y[2]+y[7]+y[3]})
	cMudou := "9"
	cMudou2:= "9"
	For ni:=1 to Len(aConPagNF)
		If Left(aConPagNF[ni,2],1) == "E" // Externa
			nVlrExt += aConPagNF[ni,6]
		Else // Interna
			nVlrInt += aConPagNF[ni,6]
		EndIf
		If FunName() == "OFIOR250"
			nCont ++
			If nCont == 400
				IncRegua()
				nCont := 2
				If lAbortPrint
					nLin++
					@nLin++,30 PSAY STR0058 //"* * *  C A N C E L A D O   P E L O   O P E R A D O R  * * *"
					Exit
				EndIf
			EndIf
		EndIf
		If nLin >= 60
			If FunName() == "OFIOR250"
				nLin := 1
				nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
				nLin++
				@ nLin++ , 27 psay cCabTot
				nLin++
			Else
				nLin := 4
				fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
				fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
				fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
				fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cFil+".##r"+CHR(13)+CHR(10))
				fwrite(outputfile," "+CHR(13)+CHR(10))
				fwrite(outputfile,space(27)+cCabTot+CHR(13)+CHR(10))
				fwrite(outputfile," "+CHR(13)+CHR(10))
			EndIf
		EndIf
		If cMudou # aConPagNF[ni,1]
			cMudou := aConPagNF[ni,1]
			cMudou2:= "9"
			cMudou3:= "1"
			nPos := aScan(aGrpPag,{|x| x[1] == cMudou })
			If MV_PAR04 >= 3
				nLin++
				If FunName() # "OFIOR250"
					fwrite(outputfile," "+CHR(13)+CHR(10))
				EndIf
			EndIf
			If Empty(aGrpPag[nPos,1])
				cGrpPag := STR0028
			Else
				cGrpPag := aGrpPag[nPos,1] + " - "
				If(len(aGrpPag[nPos,2])>=20)
					cGrpPag := cGrpPag + left(aGrpPag[nPos,2],20)
				Else
					cGrpPag := cGrpPag + aGrpPag[nPos,2] + Repl(" ",(20-len(aGrpPag[nPos,2])))
				EndIf
			EndIf
			cString := Transform(aGrpPag[nPos,3],"@E 99,999,999.99");//Venda Total
			+ Transform(aGrpPag[nPos,4],"@E 99999,999.99");	// Impostos
			+ Transform(aGrpPag[nPos,5],"@E 99999,999.99");	// ICMS
			+ Transform(aGrpPag[nPos,6],"@E 9999,999.99");	// ISS
			+ Transform(aGrpPag[nPos,7],"@E 9999,999.99");	// PIS
			+ Transform(aGrpPag[nPos,8],"@E 9999,999.99");	// Cofins
			+ Transform(aGrpPag[nPos,9],"@E 99,999,999.99");	// Custos
			+ Transform(aGrpPag[nPos,11],"@E 99,999,999.99") + Transform(((aGrpPag[nPos,11]/aGrpPag[nPos,3])*100),"@E 9999.9");//Lucro Bruto
			+ Transform(aGrpPag[nPos,10],"@E 99,999,999.99");// Juro Estoque
			+ Transform(aGrpPag[nPos,12],"@E 99,999,999.99");// Desp Var
			+ Transform(aGrpPag[nPos,13],"@E 99,999,999.99");// Comissoes
			+ Transform(aGrpPag[nPos,14],"@E 99,999,999.99");// Lucro Liq
			+ Transform(aGrpPag[nPos,15]+aGrpPag[nPos,16],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
			+ Transform(aGrpPag[nPos,17],"@E 99,999,999.99") ;// Resultado Final
			+ Transform(aGrpPag[nPos,18]/aGrpPag[nPos,19],"@E 999,999,999.9") //; // Prz Medio
			//			+ Transform((aGrpPag[nPos,20]/aGrpPag[nPos,3])*100,"@E 9999.9")	// % Desc
			If FunName() == "OFIOR250"
				nLin++
				@ nLin++ , 00 psay cGrpPag + " " + U_FS_ImpRM_250(cString)
			Else
				nLin+= 2
				fwrite(outputfile," "+CHR(13)+CHR(10))
				cString += CHR(13)+CHR(10)
				fwrite(outputfile,cGrpPag + " " + U_FS_ImpRM_250(cString))
			EndIf
		EndIf
		If MV_PAR04 >= 2
			If cMudou2 # aConPagNF[ni,2]
				cMudou2:= aConPagNF[ni,2]
				cMudou3:= "1"
				nPos := aScan(aTotPag,{|x| x[1] + x[2] == cMudou + cMudou2 })
				If MV_PAR04 >= 3
					nLin++
					If FunName() # "OFIOR250"
						fwrite(outputfile," "+CHR(13)+CHR(10))
					EndIf
				EndIf
				cString := Transform(aTotPag[nPos,4],"@E 99,999,999.99");	// Venda Total
				+ Transform(aTotPag[nPos,5],"@E 99999,999.99") ;	// Impostos
				+ Transform(aTotPag[nPos,6],"@E 99999,999.99") ;	// ICMS
				+ Transform(aTotPag[nPos,7],"@E 9999,999.99") ;	// ISS
				+ Transform(aTotPag[nPos,8],"@E 9999,999.99") ;	// PIS
				+ Transform(aTotPag[nPos,9],"@E 9999,999.99") ;	// Cofins
				+ Transform(aTotPag[nPos,10],"@E 99,999,999.99");// Custos
				+ Transform(aTotPag[nPos,12],"@E 99,999,999.99") + Transform(((aTotPag[nPos,12]/aTotPag[nPos,4])*100),"@E 9999.9");//Lucro Bruto
				+ Transform(aTotPag[nPos,11],"@E 99,999,999.99");// Juro Estoque
				+ Transform(aTotPag[nPos,13],"@E 99,999,999.99");// Desp Var
				+ Transform(aTotPag[nPos,14],"@E 99,999,999.99");// Comissoes
				+ Transform(aTotPag[nPos,15],"@E 99,999,999.99");// Lucro Liq
				+ Transform(aTotPag[nPos,16]+aTotPag[nPos,17],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
				+ Transform(aTotPag[nPos,18],"@E 99,999,999.99") ;// Resultado Final
				+ Transform(aTotPag[nPos,19]/aTotPag[nPos,20],"@E 999,999,999.9") //; // Prz Medio
				//				+ Transform((aTotPag[nPos,21]/aTotPag[nPos,4])*100,"@E 9999.9")	// % Desc
				If FunName() == "OFIOR250"
					@ nLin++ , 00 psay "  " + substr(aTotPag[nPos,2],2) + " " + aTotPag[nPos,3] + " "  + U_FS_ImpRM_250(cString)
				Else
					nLin++
					cString += CHR(13)+CHR(10)
					fwrite(outputfile,"  " + substr(aTotPag[nPos,2],2) + " " + aTotPag[nPos,3] + " " + U_FS_ImpRM_250(cString))
				EndIf
				If MV_PAR04 >= 3
					nLin++
					If FunName() # "OFIOR250"
						fwrite(outputfile," "+CHR(13)+CHR(10))
					EndIf
				EndIf
				cPulou := "JA"
			EndIf
			If nLin >= 59
				If FunName() == "OFIOR250"
					nLin := 1
					nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
					nLin++
					@ nLin++ , 27 psay cCabTot
					nLin++
				Else
					nLin := 4
					fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
					fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
					fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
					fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cFil+".##r"+CHR(13)+CHR(10))
					fwrite(outputfile," "+CHR(13)+CHR(10))
					fwrite(outputfile,space(27)+cCabTot+CHR(13)+CHR(10))
					fwrite(outputfile," "+CHR(13)+CHR(10))
				EndIf
			EndIf
		EndIf
		If MV_PAR04 >= 3
			If cMudou3 # aConPagNF[ni,7]
				cMudou3 := aConPagNF[ni,7]
				nPos := aScan(aPecSrvOfi,{|x| x[1]+x[2]+x[4] == cMudou + cMudou2 + cMudou3 })
				If nPos > 0
					If cPulou # "JA"
						nLin++
						If FunName() # "OFIOR250"
							fwrite(outputfile," "+CHR(13)+CHR(10))
						EndIf
					EndIf
					cPulou := "NAO"
					If FunName() == "OFIOR250"
						@ nLin++ , 00 psay "    " + aPecSrvOfi[nPos,4] + " " + Transform(aPecSrvOfi[nPos,3],"@E 99,999,999.99")
					Else
						nLin++
						fwrite(outputfile,"    " + aPecSrvOfi[nPos,4] + " " + Transform(aPecSrvOfi[nPos,3],"@E 99,999,999.99")+CHR(13)+CHR(10))
					EndIf
				Endif
			EndIf
			cPulou := "NAO"
			If FunName() == "OFIOR250"
				@ nLin++ , 00 psay "     " + aConPagNF[ni,3] + "-" + aConPagNF[ni,4] + " " + aConPagNF[ni,5] + " " + Transform(aConPagNF[ni,6],"@E 99,999,999.99")
			Else
				nLin++
				fwrite(outputfile,"     " + aConPagNF[ni,3] + "-" + aConPagNF[ni,4] + " " + aConPagNF[ni,5] + " " + Transform(aConPagNF[ni,6],"@E 99,999,999.99")+CHR(13)+CHR(10))
			EndIf
		EndIf
	Next
	
ElseIf MV_PAR06 == 4
	
	///////////////////////////////////
	// C.C U S T O   V E N D E D O R //
	///////////////////////////////////
	cString := Transform(aTotCon[1,1],"@E 99,999,999.99");//Venda Total
	+ Transform(aTotCon[1,2],"@E 99999,999.99");	// Impostos
	+ Transform(aTotCon[1,3],"@E 99999,999.99");	// ICMS
	+ Transform(aTotCon[1,4],"@E 9999,999.99");	// ISS
	+ Transform(aTotCon[1,5],"@E 9999,999.99");	// Pis
	+ Transform(aTotCon[1,6],"@E 9999,999.99");	// Cofins
	+ Transform(aTotCon[1,7],"@E 99,999,999.99");// Custos
	+ Transform(aTotCon[1,9],"@E 99,999,999.99") + Transform(((aTotCon[1,9]/aTotCon[1,1])*100),"@E 9999.9");	// Lucro Bruto
	+ Transform(aTotCon[1,8],"@E 99,999,999.99");// Juro Estoque
	+ Transform(aTotCon[1,10],"@E 99,999,999.99");// Desp Var
	+ Transform(aTotCon[1,11],"@E 99,999,999.99");// Comissoes
	+ Transform(aTotCon[1,12],"@E 99,999,999.99");// Lucro Liq
	+ Transform(aTotCon[1,13]+aTotCon[1,14],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
	+ Transform(aTotCon[1,15],"@E 99,999,999.99") ;// Resultado Final
	+ Transform(aTotCon[1,16]/aTotCon[1,17],"@E 999,999,999.9") //; // Prz Medio
	//	+ Transform((aTotCon[1,18]/aTotCon[1,1])*100,"@E 9999.9")	// % Desc
	If FunName() == "OFIOR250"
		nLin+=2
		@ nLin++ , 62 psay STR0059
		nLin+=2
		@ nLin++ , 00 psay STR0060 + cCabTot
		@ nLin++ , 00 psay STR0061 + U_FS_ImpRM_250(cString)
	Else
		nLin+= 7
		fwrite(outputfile," "+CHR(13)+CHR(10))
		fwrite(outputfile," "+CHR(13)+CHR(10))
		fwrite(outputfile,space(62)+STR0059+CHR(13)+CHR(10))
		fwrite(outputfile," "+CHR(13)+CHR(10))
		fwrite(outputfile," "+CHR(13)+CHR(10))
		fwrite(outputfile,STR0060 + cCabTot+CHR(13)+CHR(10))
		cString += CHR(13)+CHR(10)
		fwrite(outputfile,STR0061 + U_FS_ImpRM_250(cString))
	EndIf
	aSort(aCCVend,1,,{|x,y| x[19]+x[2] < y[19]+y[2]})
	cMudou := "9"
	For ni:=1 to Len(aCCVend)
		If FunName() == "OFIOR250"
			nCont ++
			If nCont == 400
				IncRegua()
				nCont := 2
				If lAbortPrint
					nLin++
					@nLin++,30 PSAY STR0058 //"* * *  C A N C E L A D O   P E L O   O P E R A D O R  * * *"
					Exit
				EndIf
			EndIf
		EndIf
		If ( ( aCCVend[ni,4] + aCCVend[ni,5] + aCCVend[ni,6] + aCCVend[ni,7] + aCCVend[ni,8] + aCCVend[ni,9] + aCCVend[ni,10] ) > 0 )
			If nLin >= 60
				If FunName() == "OFIOR250"
					nLin := 1
					nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
					nLin++
					@ nLin++ , 27 psay cCabTot
					nLin++
				Else
					nLin := 4
					fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
					fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
					fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
					fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cFil+".##r"+CHR(13)+CHR(10))
					fwrite(outputfile," "+CHR(13)+CHR(10))
					fwrite(outputfile,space(27)+cCabTot+CHR(13)+CHR(10))
					fwrite(outputfile," "+CHR(13)+CHR(10))
				EndIf
			EndIf
			If cMudou # aCCVend[ni,19]
				cMudou := aCCVend[ni,19]
				nPos := aScan(aTotCCV,{|x| x[1] == aCCVend[ni,1] })
				cString := Transform(aTotCCV[nPos,2],"@E 99,999,999.99");//Venda Total
				+ Transform(aTotCCV[nPos,3],"@E 99999,999.99");	// Impostos
				+ Transform(aTotCCV[nPos,4],"@E 99999,999.99");	// ICMS
				+ Transform(aTotCCV[nPos,5],"@E 9999,999.99");	// ISS
				+ Transform(aTotCCV[nPos,6],"@E 9999,999.99");	// PIS
				+ Transform(aTotCCV[nPos,7],"@E 9999,999.99");	// Cofins
				+ Transform(aTotCCV[nPos,8],"@E 99,999,999.99");// Custos
				+ Transform(aTotCCV[nPos,10],"@E 99,999,999.99") + Transform(((aTotCCV[nPos,10]/aTotCCV[nPos,2])*100),"@E 9999.9");//Lucro Bruto
				+ Transform(aTotCCV[nPos,9],"@E 99,999,999.99");// Juro Estoque
				+ Transform(aTotCCV[nPos,11],"@E 99,999,999.99");// Desp Var
				+ Transform(aTotCCV[nPos,12],"@E 99,999,999.99");// Comissoes
				+ Transform(aTotCCV[nPos,13],"@E 99,999,999.99");// Lucro Liq
				+ Transform(aTotCCV[nPos,14]+aTotCCV[nPos,15],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
				+ Transform(aTotCCV[nPos,16],"@E 99,999,999.99") ;// Resultado Final
				+ Transform(aTotCCV[nPos,17]/aTotCCV[nPos,18],"@E 999,999,999.9") //; // Prz Medio
				//				+ Transform((aTotCCV[nPos,19]/aTotCCV[nPos,2])*100,"@E 9999.9")	// % Desc
				If FunName() == "OFIOR250"
					nLin++
					@ nLin++ , 00 psay aCCVend[ni,19] + "  " + U_FS_ImpRM_250(cString)
					nLin++
				Else
					nLin+= 3
					fwrite(outputfile," "+CHR(13)+CHR(10))
					cString += CHR(13)+CHR(10)
					fwrite(outputfile,aCCVend[ni,19] + "  " + U_FS_ImpRM_250(cString))
					fwrite(outputfile," "+CHR(13)+CHR(10))
				EndIf
			EndIf
			cString := Transform(aCCVend[ni,4],"@E 99,999,999.99");	// Venda Total
			+ Transform(aCCVend[ni,5],"@E 99999,999.99");	// Impostos
			+ Transform(aCCVend[ni,6],"@E 99999,999.99");	// ICMS
			+ Transform(aCCVend[ni,7],"@E 9999,999.99");		// ISS
			+ Transform(aCCVend[ni,8],"@E 9999,999.99");		// PIS
			+ Transform(aCCVend[ni,9],"@E 9999,999.99");		// Cofins
			+ Transform(aCCVend[ni,10],"@E 99,999,999.99");	// Custos
			+ Transform(aCCVend[ni,12],"@E 99,999,999.99") + Transform(((aCCVend[ni,12]/aCCVend[ni,4])*100),"@E 9999.9");//Lucro Bruto
			+ Transform(aCCVend[ni,11],"@E 99,999,999.99");	// Juro Estoque
			+ Transform(aCCVend[ni,13],"@E 99,999,999.99");	// Desp Var
			+ Transform(aCCVend[ni,14],"@E 99,999,999.99");	// Comissoes
			+ Transform(aCCVend[ni,15],"@E 99,999,999.99");	// Lucro Liq
			+ Transform(aCCVend[ni,16]+aCCVend[ni,17],"@E 99,999,999.99") ;// Cst/Dsp Fix + Dsp Dep/Adm
			+ Transform(aCCVend[ni,18],"@E 99,999,999.99") ;// Resultado Final
			+ Transform(aCCVend[ni,20]/aCCVend[ni,21],"@E 999,999,999.9")// ; // Prz Medio
			//			+ Transform((aCCVend[ni,22]/aCCVend[ni,4])*100,"@E 9999.9")	// % Desc
			If FunName() == "OFIOR250"
				@ nLin++ , 00 psay "  " + aCCVend[ni,2] + " " + aCCVend[ni,3] + " "  + U_FS_ImpRM_250(cString)
			Else
				nLin++
				cString += CHR(13)+CHR(10)
				fwrite(outputfile,"  " + aCCVend[ni,2] + " " + aCCVend[ni,3] + " " + U_FS_ImpRM_250(cString))
			EndIf
			If Left(aCCVend[ni,1],1) == "E" // Externa
				nVlrExt += aCCVend[ni,4]
			Else // Interna
				nVlrInt += aCCVend[ni,4]
			EndIf
		EndIf
	Next
	
EndIf

If FunName() == "OFIOR250"
	nLin++
	@ nLin++ , 00 psay STR0132+Transform(nVlrExt,"@E 999,999,999.99")
	nLin++
	@ nLin++ , 00 psay STR0133+Transform(nVlrInt,"@E 999,999,999.99")
	nLin++
	@ nLin++ , 00 psay Repl("*",220)
Else
	nLin+= 6
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,STR0134+Transform(nVlrExt,"@E 999,999,999.99")+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,STR0135+Transform(nVlrInt,"@E 999,999,999.99")+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,Repl("*",220)+CHR(13)+CHR(10))
EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³FS_ImpRM_250³ Autor ³  Manoel             ³ Data ³ 07/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Faz a Disposicao das colunas do relatorio                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_ImpRM_250(cPar)
local iDisp := 0
cParStr := cPar
cParDisp := Alltrim(Upper(Mv_Par10))//"AHIGBCDEFJKLNOP"
// Vetor que determina a posicao das colunas na STRING Total
aVetDisp  := {"A001,014","B015,012","C027,012","D039,011","E050,011","F061,011","G072,013","H085,013","I098,006","J104,013","K117,013","L130,013","M143,013","N156,013","O169,013","P182,013","Q195,007"}
cRet := ""
For iDisp := 1 To Len(cParDisp)
	nPos   := aScan(aVetDisp,{|x| Subs(x,1,1) == Subs(cParDisp,iDisp,1)})
	if nPos > 0
		nPosic := Subs(aVetDisp[nPos],2,7)
		cRet += &("Subs(cParStr,"+nPosic+")")
	Endif
Next
If FunName() # "OFIOR250"
	cRet := cRet +CHR(13)+CHR(10)
endif
Return('')

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FS_OR25AI³ Autor ³ Andre Luis Almeida      ³ Data ³ 03/01/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao: Posicao das Vendas & Resultados - ICMS RETIDO     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_OR25AI(aIcmRet)

///////////////////////////////////
// I C M S   R E T I D O       . //
///////////////////////////////////

c0042 := STR0136
c0043 := STR0137
c0044 := STR0138

If nLin >= 50
	If FunName() == "OFIOR250"
		nLin := 1
		nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
	Else
		nLin := 2
		fwrite(outputfile," "+CHR(13)+CHR(10)+CHR(12))
		fwrite(outputfile,cTitulo+CHR(13)+CHR(10))
		fwrite(outputfile,STR0120+cEmpr+STR0121+cFil+space(10)+STR0122+str(nPagina++,4)+CHR(13)+CHR(10))
		fwrite(outputfile,"Arquivo: \RELATO\_R250_"+cFil+".##r"+CHR(13)+CHR(10))
	EndIf
EndIf
If FunName() == "OFIOR250"
	nLin++
	@ nLin++ , 00 psay Repl("-",220)
	nLin++
	@ nLin++ , 00 psay c0042 + c0044
	@ nLin++ , 00 psay c0043 + Transform(aIcmRet[1,2],"@E 99,999,999.99")
	nLin++
Else
	nLin+= 6
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,Repl("-",220)+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
	fwrite(outputfile,c0042 + c0044+CHR(13)+CHR(10))
	fwrite(outputfile,c0043 + Transform(aIcmRet[1,2],"@E 99,999,999.99")+CHR(13)+CHR(10))
	fwrite(outputfile," "+CHR(13)+CHR(10))
EndIf
If MV_PAR04 >= 2
	If FunName() == "OFIOR250"
		@ nLin++ , 04 psay aIcmRet[2,1] + Transform(aIcmRet[2,2],"@E 999,999,999.99")
		@ nLin++ , 04 psay aIcmRet[3,1] + Transform(aIcmRet[3,2],"@E 999,999,999.99")
		@ nLin++ , 04 psay aIcmRet[4,1] + Transform(aIcmRet[4,2],"@E 999,999,999.99")
		nLin++
	Else
		nLin+= 4
		fwrite(outputfile,space(4)+aIcmRet[2,1] + Transform(aIcmRet[2,2],"@E 999,999,999.99")+CHR(13)+CHR(10))
		fwrite(outputfile,space(4)+aIcmRet[3,1] + Transform(aIcmRet[3,2],"@E 999,999,999.99")+CHR(13)+CHR(10))
		fwrite(outputfile,space(4)+aIcmRet[4,1] + Transform(aIcmRet[4,2],"@E 999,999,999.99")+CHR(13)+CHR(10))
		fwrite(outputfile," "+CHR(13)+CHR(10))
	EndIf
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³FS_M_OR25B³ Autor ³ Andre Luis Almeida    ³ Data ³ 10/04/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Carregando VETOR de Vendas de Veiculos                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_M_OR25B()

Local cGruVei  := GetMv("MV_GRUVEI")+space(4-len(GetMv("MV_GRUVEI")))
Local lDuplic  := .f.
// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
Local nVPrzMd1 := nVPrzMd2 := nVdescon := 0
Local na := nk := 1
Local cAliasVV0 := "SQLVV0"

///////////////////////////////////
//    V  E  I  C  U  L  O  S     //
///////////////////////////////////

nCont := 0
If FunName() == "OFIOR250"
	IncRegua()
EndIf

cQuery := "SELECT VV0.VV0_DATMOV,VV0.VV0_OPEMOV,VV0.VV0_SITNFI,VV0.VV0_NUMTRA,VV0.VV0_NUMNFI,VV0.VV0_SERNFI,VV0.VV0_TIPFAT "
cQuery += "FROM "
cQuery += RetSqlName( "VV0" ) + " VV0 "
cQuery += "WHERE "
cQuery += "VV0.VV0_FILIAL='"+ xFilial("VV0")+ "' AND VV0.VV0_DATMOV >= '"+dtos(mv_par01)+"' AND VV0.VV0_DATMOV <= '"+dtos(mv_par02)+"' AND "
cQuery += "VV0.VV0_OPEMOV = '0' AND VV0.VV0_SITNFI <> '0' AND "
cQuery += "VV0.D_E_L_E_T_=' '"

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVV0, .T., .T. )

aAdd(aTotVei,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0})

While !((cAliasVV0)->(Eof()))
	
	If FunName() == "OFIOR250"
		nCont ++
		If nCont == 400
			IncRegua()
			nCont := 1
			If lAbortPrint
				nLin++
				@nLin++,30 PSAY STR0058 //"* * *  C A N C E L A D O   P E L O   O P E R A D O R  * * *"
				Exit
			EndIf
		EndIf
	EndIf
	
	If (!Empty(MV_PAR01) .and. (stod((cAliasVV0)->VV0_DATMOV) < MV_PAR01))
		dbSelectArea(cAliasVV0)
		(cAliasVV0)->(Dbskip())
		Loop
	EndIf
	
	DbSelectArea( "VVA" )
	DbSetOrder(1)
	DbSeek( xFilial("VVA") + (cAliasVV0)->VV0_NUMTRA )
	
	DbSelectArea("SB1")
	DbSetOrder(7)
	DbSeek(xFilial("SB1")+cGruVei+VVA->VVA_CHAINT)
	
	DbSelectArea( "SD2" )
	DbSetOrder(3)
	DbSeek( xFilial("SD2") + (cAliasVV0)->VV0_NUMNFI + (cAliasVV0)->VV0_SERNFI)
	
	DbSelectArea( "SF4" )
	DbSetOrder(1)
	DbSeek( xFilial("SF4") + SD2->D2_TES )
	
	DbSelectArea( "SF2" )
	DbSetOrder(1)
	DbSeek( xFilial("SF2") + (cAliasVV0)->VV0_NUMNFI + (cAliasVV0)->VV0_SERNFI )

	DbSelectArea("SFT")
	DbSetOrder(1)
	DbSeek(xFilial("SFT")+ "S" + SD2->D2_SERIE + SD2->D2_DOC + SD2->D2_CLIENTE + SD2->D2_LOJA + SD2->D2_ITEM)
	
	// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
	na := ( (SF2->F2_VALBRUT-SF2->F2_BASEISS) / SF2->F2_VALBRUT )
	nk := ( (SD2->D2_TOTAL+SD2->D2_VALIPI) / ( SF2->F2_VALBRUT - SF2->F2_BASEISS ) )
	nVprzmd1 := 0
	nVprzmd2 := 0
	// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
	nVdescon := 0
	DbSelectArea("SE1")
	DbSetOrder(1)
	DbSeek( xFilial("SE1") + SF2->F2_PREFIXO + SF2->F2_DUPL )
	While !Eof() .and. ( SE1->E1_FILIAL == xFilial("SE1") ) .and. ( ( SF2->F2_PREFIXO + SF2->F2_DUPL ) == ( SE1->E1_PREFIXO + SE1->E1_NUM ) )
		nVprzmd1 += ( ( nk * ( SE1->E1_VALOR * na ) ) * ( SE1->E1_VENCTO - SF2->F2_EMISSAO ) )
		nVprzmd2 += ( nk * ( SE1->E1_VALOR * na )  )
		If Alltrim(SE1->E1_TIPO) == "CD" // CDCI - sem prazo medio
			nVprzmd1 := 0
		EndIf
		DbSelectArea("SE1")
		Dbskip()
	EndDo
	
	lDuplic := .f.
	If SF4->F4_DUPLIC == "N" .and. SF4->F4_OPEMOV <> "05"
		dbSelectArea(cAliasVV0)
		(cAliasVV0)->(Dbskip())
		Loop
	Else
		lDuplic := .t.
	EndIf
	
	If (cAliasVV0)->VV0_TIPFAT # "2"
		
		If Empty((cAliasVV0)->VV0_NUMNFI)
			dbSelectArea(cAliasVV0)
			(cAliasVV0)->(Dbskip())
			Loop
		EndIf
		
		If !SD2->D2_TIPO $ "N/C"//alteracao 02/05/08 - Renata - acrescentou o C
			dbSelectArea(cAliasVV0)
			(cAliasVV0)->(Dbskip())
			Loop
		EndIf
		
		
		DbSelectArea( "VV1" )
		DbSetOrder(1)
		DbSeek( xFilial("VV1") + VVA->VVA_CHAINT )
		
		nVtotimp := Iif( MV_PAR03 == 1 , VVA->VVA_TOTIMP-(VVA->VVA_PISRTE+VVA->VVA_ISSRTE+VVA->VVA_PISBFB+VVA->VVA_ISSBFB) , Iif( MV_PAR03 == 2 , VVA->VVA_TMFIMP-(VVA->VVA_PISRTE+VVA->VVA_ISSRTE+VVA->VVA_PISBFB+VVA->VVA_ISSBFB) , xmoeda(VVA->VVA_TOTIMP-(VVA->VVA_PISRTE+VVA->VVA_ISSRTE+VVA->VVA_PISBFB+VVA->VVA_ISSBFB),1,MV_PAR03,DDataBase)))
		
		if VV1->VV1_ESTVEI == "1"
			nVpisven := Iif( MV_PAR03 == 1 , VVA->VVA_PISVEN , Iif( MV_PAR03 == 2 , VVA->VVA_PMFVEN , xmoeda(VVA->VVA_PISVEN,1,MV_PAR03,DDataBase)))
			nVcofven := Iif( MV_PAR03 == 1 , VVA->VVA_COFVEN , Iif( MV_PAR03 == 2 , VVA->VVA_CMFVEN , xmoeda(VVA->VVA_COFVEN,1,MV_PAR03,DDataBase)))
		Else
			nVpisven := Iif( MV_PAR03 == 1 , VVA->VVA_PISVEN , Iif( MV_PAR03 == 2 , VVA->VVA_PMFVEN , xmoeda(VVA->VVA_PISVEN,1,MV_PAR03,DDataBase)))
			nVcofven := Iif( MV_PAR03 == 1 , VVA->VVA_COFVEN , Iif( MV_PAR03 == 2 , VVA->VVA_CMFVEN , xmoeda(VVA->VVA_COFVEN,1,MV_PAR03,DDataBase)))
		Endif
		
		// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
		// Renata - 23/05/06 - Campo de moeda forte inexistente para desconto, nao e tratado no VEIVM010
		nVdescon := Iif( MV_PAR03 == 1 , VVA->VVA_VALDES , xmoeda(VVA->VVA_VALDES,1,MV_PAR03,DDataBase))
		If (MV_PAR08 == 1)
			
			nVfattot := Iif( MV_PAR03 == 1 , VVA->VVA_FATTOT , Iif( MV_PAR03 == 2 , VVA->VVA_FMFTOT , xmoeda(VVA->VVA_FATTOT,1,MV_PAR03,DDataBase)))
			If SFT->FT_VALICM == 0
				nVicmven  := 0
			Else
				nVicmven := Iif( MV_PAR03 == 1 , VVA->VVA_ICMVEN , Iif( MV_PAR03 == 2 , VVA->VVA_IMFVEN , xmoeda(VVA->VVA_ICMVEN,1,MV_PAR03,DDataBase)))
			Endif
			nVtotimp := Iif( MV_PAR03 == 1 , VVA->VVA_TOTIMP-(VVA->VVA_PISRTE+VVA->VVA_ISSRTE+VVA->VVA_PISBFB+VVA->VVA_ISSBFB) , Iif( MV_PAR03 == 2 , VVA->VVA_TMFIMP , xmoeda(VVA->VVA_TOTIMP-(VVA->VVA_PISRTE+VVA->VVA_ISSRTE+VVA->VVA_PISBFB+VVA->VVA_ISSBFB),1,MV_PAR03,DDataBase)))
			nVpisven := Iif( MV_PAR03 == 1 , VVA->VVA_PISVEN , Iif( MV_PAR03 == 2 , VVA->VVA_PMFVEN , xmoeda(VVA->VVA_PISVEN,1,MV_PAR03,DDataBase)))
			nVcofven := Iif( MV_PAR03 == 1 , VVA->VVA_COFVEN , Iif( MV_PAR03 == 2 , VVA->VVA_CMFVEN , xmoeda(VVA->VVA_COFVEN,1,MV_PAR03,DDataBase)))
			
			nVtotcus := Iif( MV_PAR03 == 1 , VVA->VVA_TOTCUS , Iif( MV_PAR03 == 2 , VVA->VVA_TMFCUS , xmoeda(VVA->VVA_TOTCUS,1,MV_PAR03,DDataBase)))
			nVjurest := Iif( MV_PAR03 == 1 , VVA->VVA_JUREST , Iif( MV_PAR03 == 2 , VVA->VVA_JMFEST , xmoeda(VVA->VVA_JUREST,1,MV_PAR03,DDataBase)))
			nVtotcus := (nVtotcus - nVjurest)
			nVlucbru := Iif( MV_PAR03 == 1 , VVA->VVA_LUCBRU , Iif( MV_PAR03 == 2 , VVA->VVA_LMFBRU , xmoeda(VVA->VVA_LUCBRU,1,MV_PAR03,DDataBase)))
			
		Else
			
			nVfattot := Iif( MV_PAR03 == 1 , (SD2->D2_TOTAL+SD2->D2_VALIPI)  , Iif( MV_PAR03 == 2 , VVA->VVA_FMFTOT , xmoeda(VVA->VVA_FATTOT,1,MV_PAR03,DDataBase)))
			If SFT->FT_VALICM == 0
				nVicmven := 0
			Else
				nVicmven := Iif( MV_PAR03 == 1 , SD2->D2_VALICM , Iif( MV_PAR03 == 2 , VVA->VVA_IMFVEN , xmoeda(VVA->VVA_ICMVEN,1,MV_PAR03,DDataBase)))
			Endif
			///////////
			nVtotimp := Iif( MV_PAR03 == 1 , VVA->VVA_TOTIMP-(VVA->VVA_PISRTE+VVA->VVA_ISSRTE+VVA->VVA_PISBFB+VVA->VVA_ISSBFB) , Iif( MV_PAR03 == 2 , VVA->VVA_TMFIMP , xmoeda(VVA->VVA_TOTIMP-(VVA->VVA_PISRTE+VVA->VVA_ISSRTE+VVA->VVA_PISBFB+VVA->VVA_ISSBFB),1,MV_PAR03,DDataBase)))
			if SFT->FT_VALIMP5 > 0 .AND. SFT->FT_VALIMP6 > 0
				
				nVpisven := Iif( MV_PAR03 == 1 , SD2->D2_VALIMP6  , Iif( MV_PAR03 == 2 , VVA->VVA_PMFVEN , xmoeda(VVA->VVA_PISVEN,1,MV_PAR03,DDataBase)))
				nVcofven := Iif( MV_PAR03 == 1 , SD2->D2_VALIMP5  , Iif( MV_PAR03 == 2 , VVA->VVA_CMFVEN , xmoeda(VVA->VVA_COFVEN,1,MV_PAR03,DDataBase)))
				
			Endif
			///////////
			nVtotcus := Iif( MV_PAR03 == 1 , SD2->D2_CUSTO1 , Iif( MV_PAR03 == 2 , VVA->VVA_TMFCUS , xmoeda(VVA->VVA_TOTCUS,1,MV_PAR03,DDataBase)))
			nVjurest := Iif( MV_PAR03 == 1 , VVA->VVA_JUREST , Iif( MV_PAR03 == 2 , VVA->VVA_JMFEST , xmoeda(VVA->VVA_JUREST,1,MV_PAR03,DDataBase)))
			//	   	   nVlucbru := Iif( MV_PAR03 == 1 , ((SD2->D2_TOTAL+SD2->D2_VALIPI)-(SD2->D2_CUSTO1+VVA->VVA_TOTIMP-(VVA->VVA_PISRTE+VVA->VVA_ISSRTE+VVA->VVA_PISBFB+VVA->VVA_ISSBFB))) , Iif( MV_PAR03 == 2 , VVA->VVA_LMFBRU , xmoeda(VVA->VVA_LUCBRU,1,MV_PAR03,DDataBase)))
			nVlucbru := Iif( MV_PAR03 == 1 , ((SD2->D2_TOTAL+SD2->D2_VALIPI)-(SD2->D2_CUSTO1+nVtotimp)) , Iif( MV_PAR03 == 2 , VVA->VVA_LMFBRU , xmoeda(VVA->VVA_LUCBRU,1,MV_PAR03,DDataBase)))
			
		EndIf
		
		nVtotdes := Iif( MV_PAR03 == 1 , VVA->VVA_TOTDES , Iif( MV_PAR03 == 2 , VVA->VVA_TMFDES , xmoeda(VVA->VVA_TOTDES,1,MV_PAR03,DDataBase)))
		nVcomvde := Iif( MV_PAR03 == 1 , (VVA->VVA_COMVDE+VVA->VVA_COMGER) , Iif( MV_PAR03 == 2 , (VVA->VVA_CMFVDE+VVA->VVA_CMFGER) , xmoeda((VVA->VVA_COMVDE+VVA->VVA_COMGER),1,MV_PAR03,DDataBase)))
		nVluclq1 := Iif( MV_PAR03 == 1 , VVA->VVA_LUCLQ1 , Iif( MV_PAR03 == 2 , VVA->VVA_LMFLQ1 , xmoeda(VVA->VVA_LUCLQ1,1,MV_PAR03,DDataBase)))
		nVdesfix := Iif( MV_PAR03 == 1 , VVA->VVA_DESFIX , Iif( MV_PAR03 == 2 , VVA->VVA_DMFFIX , xmoeda(VVA->VVA_DESFIX,1,MV_PAR03,DDataBase)))
		nVdesadm := 0
		nVluclq2 := Iif( MV_PAR03 == 1 , VVA->VVA_LUCLQ2 , Iif( MV_PAR03 == 2 , VVA->VVA_LMFLQ2 , xmoeda(VVA->VVA_LUCLQ2,1,MV_PAR03,DDataBase)))
		
		If Alltrim(SF4->F4_ATUATF) == "S"    //  A T I V O   I M O B I L I Z A D O
			
			aTotAtiMob[1,3] += nVfattot
			aTotAtiMob[1,4] += nVtotimp
			aTotAtiMob[1,5] += nVicmven
			aTotAtiMob[1,6] += nVpisven
			aTotAtiMob[1,7] += nVcofven
			aTotAtiMob[1,8] += nVtotcus
			aTotAtiMob[2,3] += nVfattot
			aTotAtiMob[2,4] += nVtotimp
			aTotAtiMob[2,5] += nVicmven
			aTotAtiMob[2,6] += nVpisven
			aTotAtiMob[2,7] += nVcofven
			aTotAtiMob[2,8] += nVtotcus
			
			DbSelectArea( "VV1" )
			DbSetOrder(1)
			DbSeek( xFilial("VV1") + VVA->VVA_CHAINT )
			
			DbSelectArea("VV2")
			DbSetOrder(1)
			DbSeek(xFilial("VV2") + VV1->VV1_CODMAR + VV1->VV1_MODVEI )
			
			//			aAdd(aNumAtiMob,{ "V" , VV2->VV2_DESMOD , nVfattot , 0 , 0 , 0 , 0 , nVtotcus })
			aAdd(aNumAtiMob,{ "V" , VV2->VV2_DESMOD , nVfattot , nVtotimp , nVicmven ,nVpisven , nVcofven , nVtotcus })
			
		Else
			
			DbSelectArea( "VV1" )
			DbSetOrder(1)
			DbSeek( xFilial("VV1") + VVA->VVA_CHAINT )
			
			DbSelectArea("VV2")
			DbSetOrder(1)
			DbSeek(xFilial("VV2") + VV1->VV1_CODMAR + VV1->VV1_MODVEI )
			
			nPos := 0
			If ( MV_PAR05 == 1 .or. ( MV_PAR05 == 2 .and. MV_PAR04 # 3 .and. MV_PAR04 # 4 ))
				nPos := aScan(aNumVei,{|x| x[1] + x[2] + x[3] == Alltrim(VV1->VV1_PROVEI) + Alltrim((cAliasVV0)->VV0_TIPFAT) + VV2->VV2_DESMOD })
			Else
				DbSelectArea( "SA1" )
				DbSetOrder(1)
				//DbSeek( xFilial("SA1") + VV1->VV1_PROATU + VV1->VV1_LJPATU ) 16/03/2009 - Alterado por Otavio e Silvania
				DbSeek( xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA )
				//cCliente := VV1->VV1_PROATU + " " + left(SA1->A1_NOME,15) 16/03/2009 - Alterado por Otavio e Silvania
				cCliente := SF2->F2_CLIENTE + " " + left(SA1->A1_NOME,15)
				nPos := aScan(aNumVei,{|x| x[1] + x[2] + x[3] == Alltrim(VV1->VV1_PROVEI) + Alltrim((cAliasVV0)->VV0_TIPFAT) + cCliente })
			EndIf
			
			If nPos == 0
				If ( MV_PAR05 == 1 .or. ( MV_PAR05 == 2 .and. MV_PAR04 # 3 .and. MV_PAR04 # 4 ))
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					aAdd(aNumVei,{ Alltrim(VV1->VV1_PROVEI) , Alltrim((cAliasVV0)->VV0_TIPFAT) , VV2->VV2_DESMOD , nVfattot , nVtotimp , nVicmven , nVpisven , nVcofven , nVtotcus , nVjurest , nVlucbru , nVtotdes , nVcomvde , nVluclq1 , nVdesfix , nVdesadm , nVluclq2 , 1,VV1->VV1_MODVEI, nVPrzMd1, nVPrzMd2, nVdescon })
				Else
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					aAdd(aNumVei,{ Alltrim(VV1->VV1_PROVEI) , Alltrim((cAliasVV0)->VV0_TIPFAT) , cCliente , nVfattot , nVtotimp , nVicmven , nVpisven , nVcofven , nVtotcus , nVjurest , nVlucbru , nVtotdes , nVcomvde , nVluclq1 , nVdesfix , nVdesadm , nVluclq2 , 1,VV1->VV1_MODVEI, nVPrzMd1, nVPrzMd2, nVdescon })
				EndIf
			Else
				aNumVei[nPos,4]  += nVfattot
				aNumVei[nPos,5]  += nVtotimp
				aNumVei[nPos,6]  += nVicmven
				aNumVei[nPos,7]  += nVpisven
				aNumVei[nPos,8]  += nVcofven
				aNumVei[nPos,9]  += nVtotcus
				aNumVei[nPos,10] += nVjurest
				aNumVei[nPos,11] += nVlucbru
				aNumVei[nPos,12] += nVtotdes
				aNumVei[nPos,13] += nVcomvde
				aNumVei[nPos,14] += nVluclq1
				aNumVei[nPos,15] += nVdesfix
				aNumVei[nPos,16] += nVdesadm
				aNumVei[nPos,17] += nVluclq2
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				aNumVei[nPos,20] += nVPrzMd1
				aNumVei[nPos,21] += nVPrzMd2
				// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
				aNumVei[nPos,22] += nVDescon
				aNumVei[nPos,18]++
			EndIf
			
			nPos := 0
			nPos := aScan(aGrpVei,{|x| x[1] + x[2] == Alltrim(VV1->VV1_PROVEI) + Alltrim((cAliasVV0)->VV0_TIPFAT) })
			If nPos == 0
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				aAdd(aGrpVei,{ Alltrim(VV1->VV1_PROVEI) , Alltrim((cAliasVV0)->VV0_TIPFAT) , nVfattot , nVtotimp , nVicmven , nVpisven , nVcofven , nVtotcus , nVjurest , nVlucbru , nVtotdes , nVcomvde , nVluclq1 , nVdesfix , nVdesadm , nVluclq2 , 1, nVPrzMd1, nVPrzMd2, nVdescon })
			Else
				aGrpVei[nPos,3]  += nVfattot
				aGrpVei[nPos,4]  += nVtotimp
				aGrpVei[nPos,5]  += nVicmven
				aGrpVei[nPos,6]  += nVpisven
				aGrpVei[nPos,7]  += nVcofven
				aGrpVei[nPos,8]  += nVtotcus
				aGrpVei[nPos,9]  += nVjurest
				aGrpVei[nPos,10] += nVlucbru
				aGrpVei[nPos,11] += nVtotdes
				aGrpVei[nPos,12] += nVcomvde
				aGrpVei[nPos,13] += nVluclq1
				aGrpVei[nPos,14] += nVdesfix
				aGrpVei[nPos,15] += nVdesadm
				aGrpVei[nPos,16] += nVluclq2
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				aGrpVei[nPos,18] += nVPrzMd1
				aGrpVei[nPos,19] += nVPrzMd2
				// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
				aGrpVei[nPos,20] += nVdescon
				aGrpVei[nPos,17]++
			EndIf
			
			aTotVei[1,1]  += nVfattot
			aTotVei[1,2]  += nVtotimp
			aTotVei[1,3]  += nVicmven
			aTotVei[1,4]  += nVpisven
			aTotVei[1,5]  += nVcofven
			aTotVei[1,6]  += nVtotcus
			aTotVei[1,7]  += nVjurest
			aTotVei[1,8]  += nVlucbru
			aTotVei[1,9]  += nVtotdes
			aTotVei[1,10] += nVcomvde
			aTotVei[1,11] += nVluclq1
			aTotVei[1,12] += nVdesfix
			aTotVei[1,13] += nVdesadm
			aTotVei[1,14] += nVluclq2
			// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
			aTotVei[1,15] += nVPrzMd1
			aTotVei[1,16] += nVPrzMd2
			// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
			aTotVei[1,17] += nVdescon
			
			aTotal[1,1]  += nVfattot
			aTotal[1,2]  += nVtotimp
			aTotal[1,3]  += nVicmven
			aTotal[1,5]  += nVpisven
			aTotal[1,6]  += nVcofven
			aTotal[1,7]  += nVtotcus
			aTotal[1,8]  += nVjurest
			aTotal[1,9]  += nVlucbru
			aTotal[1,10] += nVtotdes
			aTotal[1,11] += nVcomvde
			aTotal[1,12] += nVluclq1
			aTotal[1,13] += nVdesfix
			aTotal[1,14] += nVdesadm
			aTotal[1,15] += nVluclq2
			// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
			aTotal[1,16] += nVPrzMd1
			aTotal[1,17] += nVPrzMd2
			// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
			aTotal[1,18] += nVdescon
			
			If MV_PAR06 # 1
				
				aTotCon[1,1]  += nVfattot
				aTotCon[1,2]  += nVtotimp
				aTotCon[1,3]  += nVicmven
				aTotCon[1,5]  += nVpisven
				aTotCon[1,6]  += nVcofven
				aTotCon[1,7]  += nVtotcus
				aTotCon[1,8]  += nVjurest
				aTotCon[1,9]  += nVlucbru
				aTotCon[1,10] += nVtotdes
				aTotCon[1,11] += nVcomvde
				aTotCon[1,12] += nVluclq1
				aTotCon[1,13] += nVdesfix
				aTotCon[1,14] += nVdesadm
				aTotCon[1,15] += nVluclq2
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				aTotCon[1,16] += nVPrzMd1
				aTotCon[1,17] += nVPrzMd2
				// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
				aTotCon[1,18] += nVdescon
				
				DbSelectArea( "SF2" )
				DbSetOrder(1)
				DbSeek( xFilial("SF2") + (cAliasVV0)->VV0_NUMNFI + (cAliasVV0)->VV0_SERNFI )
				
				DbSelectArea( "VAI" )
				DbSetOrder(6)
				DbSeek( xFilial("VAI") + SF2->F2_VEND1 )
				
				nPos := 0
				nPos := aScan(aConPagNF,{|x| x[1]+x[2]+x[3]+x[4]+x[7] == SF2->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,SF2->F2_VEND1,VAI->VAI_CC) + (cAliasVV0)->VV0_NUMNFI + (cAliasVV0)->VV0_SERNFI + "1" })
				If nPos == 0
					DbSelectArea( "SA1" )
					DbSetOrder(1)
					DbSeek( xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA )
					aAdd(aConPagNF,{ SF2->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,SF2->F2_VEND1,VAI->VAI_CC) , (cAliasVV0)->VV0_NUMNFI , (cAliasVV0)->VV0_SERNFI , left(SA1->A1_NOME,10) , nVfattot , "1" })
				Else
					aConPagNF[nPos,6] += nVfattot
				EndIf
				nPos := 0
				nPos := aScan(aGrpPag,{|x| x[1] == SF2->F2_COND })
				If nPos == 0
					DbSelectArea( "SE4" )
					DbSetOrder(1)
					DbSeek( xFilial("SE4") + SF2->F2_COND )
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					aAdd(aGrpPag,{ SF2->F2_COND , SE4->E4_DESCRI , nVfattot , nVtotimp , nVicmven , 0 , nVpisven , nVcofven , nVtotcus , nVjurest , nVlucbru , nVtotdes , nVcomvde , nVluclq1 , nVdesfix , nVdesadm , nVluclq2, nVPrzMd1, nVPrzMd2, nVdescon })
				Else
					aGrpPag[nPos,3]  += nVfattot
					aGrpPag[nPos,4]  += nVtotimp
					aGrpPag[nPos,5]  += nVicmven
					aGrpPag[nPos,7]  += nVpisven
					aGrpPag[nPos,8]  += nVcofven
					aGrpPag[nPos,9]  += nVtotcus
					aGrpPag[nPos,10] += nVjurest
					aGrpPag[nPos,11] += nVlucbru
					aGrpPag[nPos,12] += nVtotdes
					aGrpPag[nPos,13] += nVcomvde
					aGrpPag[nPos,14] += nVluclq1
					aGrpPag[nPos,15] += nVdesfix
					aGrpPag[nPos,16] += nVdesadm
					aGrpPag[nPos,17] += nVluclq2
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					aGrpPag[nPos,18] += nVPrzMd1
					aGrpPag[nPos,19] += nVPrzMd2
					// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
					aGrpPag[nPos,20] += nVdescon
				EndIf
				
				nPos := 0
				If MV_PAR06 # 3
					nPos := aScan(aTotPag,{|x| x[1]+x[2] == SF2->F2_COND + Iif(lDuplic,"E","I")+SF2->F2_VEND1 })
				Else
					nPos := aScan(aTotPag,{|x| x[1]+x[2] == SF2->F2_COND + Iif(lDuplic,"E","I")+VAI->VAI_CC })
				EndIf
				
				If nPos == 0 .or. MV_PAR06 == 4
					If MV_PAR06 # 3
						DbSelectArea( "SA3" )
						DbSetOrder(1)
						DbSeek( xFilial("SA3") + VAI->VAI_CODVEN )
						// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
						aAdd(aTotPag,{ SF2->F2_COND , Iif(lDuplic,"E","I")+SF2->F2_VEND1 , left(SA3->A3_NOME,17) , nVfattot , nVtotimp , nVicmven , 0 , nVpisven , nVcofven , nVtotcus , nVjurest , nVlucbru , nVtotdes , nVcomvde , nVluclq1 , nVdesfix , nVdesadm , nVluclq2, nVPrzMd1, nVPrzMd2, nVdescon })
						
						nPos3 := 0
						nPos3 := aScan(aCCVend,{|x| x[1]+x[2] == Iif(lDuplic,"E","I")+VAI->VAI_CC + SF2->F2_VEND1 })
						If nPos3 == 0
							DbSelectArea( "SI3" )
							DbSetOrder(1)
							DbSeek( xFilial("SI3") + VAI->VAI_CC )
							// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
							aAdd(aCCVend,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , SF2->F2_VEND1 , left(SA3->A3_NOME,17) , nVfattot , nVtotimp , nVicmven , 0 , nVpisven , nVcofven , nVtotcus , nVjurest , nVlucbru , nVtotdes , nVcomvde , nVluclq1 , nVdesfix , nVdesadm , nVluclq2 , Iif(lDuplic,"Ext ","Int ")+left(SI3->I3_DESC,21), nVPrzMd1, nVPrzMd2, nVdescon })
						Else
							aCCVend[nPos3,4]  += nVfattot
							aCCVend[nPos3,5]  += nVtotimp
							aCCVend[nPos3,6]  += nVicmven
							aCCVend[nPos3,7]  += 0
							aCCVend[nPos3,8]  += nVpisven
							aCCVend[nPos3,9]  += nVcofven
							aCCVend[nPos3,10] += nVtotcus
							aCCVend[nPos3,11] += nVjurest
							aCCVend[nPos3,12] += nVlucbru
							aCCVend[nPos3,13] += nVtotdes
							aCCVend[nPos3,14] += nVcomvde
							aCCVend[nPos3,15] += nVluclq1
							aCCVend[nPos3,16] += nVdesfix
							aCCVend[nPos3,17] += nVdesadm
							aCCVend[nPos3,18] += nVluclq2
							// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
							aCCVend[nPos3,20] += nVPrzMd1
							aCCVend[nPos3,21] += nVPrzMd2
							// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
							aCCVend[nPos3,22] += nVdescon
						EndIf
						nPos3 := 0
						nPos3 := aScan(aTotCCV,{|x| x[1] == Iif(lDuplic,"E","I")+VAI->VAI_CC })
						If nPos3 == 0
							// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
							aAdd(aTotCCV,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , nVfattot , nVtotimp , nVicmven , 0 , nVpisven , nVcofven , nVtotcus , nVjurest , nVlucbru , nVtotdes , nVcomvde , nVluclq1 , nVdesfix , nVdesadm , nVluclq2, nVPrzMd1, nVPrzMd2, nVdescon })
						Else
							aTotCCV[nPos3,2]  += nVfattot
							aTotCCV[nPos3,3]  += nVtotimp
							aTotCCV[nPos3,4]  += nVicmven
							aTotCCV[nPos3,5]  += 0
							aTotCCV[nPos3,6]  += nVpisven
							aTotCCV[nPos3,7]  += nVcofven
							aTotCCV[nPos3,8]  += nVtotcus
							aTotCCV[nPos3,9]  += nVjurest
							aTotCCV[nPos3,10] += nVlucbru
							aTotCCV[nPos3,11] += nVtotdes
							aTotCCV[nPos3,12] += nVcomvde
							aTotCCV[nPos3,13] += nVluclq1
							aTotCCV[nPos3,14] += nVdesfix
							aTotCCV[nPos3,15] += nVdesadm
							aTotCCV[nPos3,16] += nVluclq2
							// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
							aTotCCV[nPos3,17] += nVPrzMd1
							aTotCCV[nPos3,18] += nVPrzMd2
							// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
							aTotCCV[nPos3,18] += nVdescon
						EndIf
					Else
						DbSelectArea( "SI3" )
						DbSetOrder(1)
						DbSeek( xFilial("SI3") + VAI->VAI_CC )
						// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
						aAdd(aTotPag,{ SF2->F2_COND , Iif(lDuplic,"E","I")+VAI->VAI_CC , left(SI3->I3_DESC,14) , nVfattot , nVtotimp , nVicmven , 0 , nVpisven , nVcofven , nVtotcus , nVjurest , nVlucbru , nVtotdes , nVcomvde , nVluclq1 , nVdesfix , nVdesadm , nVluclq2, nVPrzMd1, nVPrzMd2, nVdescon })
					EndIf
				Else
					aTotPag[nPos,4]  += nVfattot
					aTotPag[nPos,5]  += nVtotimp
					aTotPag[nPos,6]  += nVicmven
					aTotPag[nPos,8]  += nVpisven
					aTotPag[nPos,9]  += nVcofven
					aTotPag[nPos,10] += nVtotcus
					aTotPag[nPos,11] += nVjurest
					aTotPag[nPos,12] += nVlucbru
					aTotPag[nPos,13] += nVtotdes
					aTotPag[nPos,14] += nVcomvde
					aTotPag[nPos,15] += nVluclq1
					aTotPag[nPos,16] += nVdesfix
					aTotPag[nPos,17] += nVdesadm
					aTotPag[nPos,18] += nVluclq2
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					aTotPag[nPos,19] += nVPrzMd1
					aTotPag[nPos,20] += nVPrzMd2
					// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
					aTotPag[nPos,21] += nVdescon
				EndIf
				
			EndIf
			
		EndIf
		
	Else // (cAliasVV0)->VV0_TIPFAT == "2" -> Faturamento Direto
		
		DbSelectArea( "VV1" )
		DbSetOrder(1)
		DbSeek( xFilial("VV1") + VVA->VVA_CHAINT )
		
		if VV1->VV1_ESTVEI == "1"
			nVtotimp := Iif( MV_PAR03 == 1 , VVA->VVA_TOTIMP-(VVA->VVA_PISRTE+VVA->VVA_ISSRTE+VVA->VVA_PISBFB+VVA->VVA_ISSBFB) , Iif( MV_PAR03 == 2 , VVA->VVA_TMFIMP , xmoeda(VVA->VVA_TOTIMP-(VVA->VVA_PISRTE+VVA->VVA_ISSRTE+VVA->VVA_PISBFB+VVA->VVA_ISSBFB),1,MV_PAR03,DDataBase)))
			nVpisven := Iif( MV_PAR03 == 1 , VVA->VVA_PISVEN , Iif( MV_PAR03 == 2 , VVA->VVA_PMFVEN , xmoeda(VVA->VVA_PISVEN,1,MV_PAR03,DDataBase)))
			nVcofven := Iif( MV_PAR03 == 1 , VVA->VVA_COFVEN , Iif( MV_PAR03 == 2 , VVA->VVA_CMFVEN , xmoeda(VVA->VVA_COFVEN,1,MV_PAR03,DDataBase)))
		Else
			nVtotimp := Iif( MV_PAR03 == 1 , VVA->VVA_TOTIMP-(VVA->VVA_PISRTE+VVA->VVA_ISSRTE+VVA->VVA_PISBFB+VVA->VVA_ISSBFB) , Iif( MV_PAR03 == 2 , VVA->VVA_TMFIMP , xmoeda(VVA->VVA_TOTIMP-(VVA->VVA_PISRTE+VVA->VVA_ISSRTE+VVA->VVA_PISBFB+VVA->VVA_ISSBFB),1,MV_PAR03,DDataBase)))
			nVpisven := Iif( MV_PAR03 == 1 , VVA->VVA_PISVEN , Iif( MV_PAR03 == 2 , VVA->VVA_PMFVEN , xmoeda(VVA->VVA_PISVEN,1,MV_PAR03,DDataBase)))
			nVcofven := Iif( MV_PAR03 == 1 , VVA->VVA_COFVEN , Iif( MV_PAR03 == 2 , VVA->VVA_CMFVEN , xmoeda(VVA->VVA_COFVEN,1,MV_PAR03,DDataBase)))
		Endif
		// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
		// Renata - 23/05/06 - Campo de moeda forte inexistente para desconto, nao e tratado no VEIVM010
		nVdescon := Iif( MV_PAR03 == 1 , VVA->VVA_VALDES , xmoeda(VVA->VVA_VALDES,1,MV_PAR03,DDataBase))
		If ( MV_PAR08 == 1 .or. Empty((cAliasVV0)->VV0_NUMNFI) )
			
			nVfattot := Iif( MV_PAR03 == 1 , VVA->VVA_FATTOT , Iif( MV_PAR03 == 2 , VVA->VVA_FMFTOT , xmoeda(VVA->VVA_FATTOT,1,MV_PAR03,DDataBase)))
			If SFT->FT_VALICM == 0
				nVicmven := 0
			Else
				nVicmven := Iif( MV_PAR03 == 1 , VVA->VVA_ICMVEN , Iif( MV_PAR03 == 2 , VVA->VVA_IMFVEN , xmoeda(VVA->VVA_ICMVEN,1,MV_PAR03,DDataBase)))
			Endif
			nVtotcus := Iif( MV_PAR03 == 1 , VVA->VVA_TOTCUS , Iif( MV_PAR03 == 2 , VVA->VVA_TMFCUS , xmoeda(VVA->VVA_TOTCUS,1,MV_PAR03,DDataBase)))
			nVjurest := Iif( MV_PAR03 == 1 , VVA->VVA_JUREST , Iif( MV_PAR03 == 2 , VVA->VVA_JMFEST , xmoeda(VVA->VVA_JUREST,1,MV_PAR03,DDataBase)))
			nVtotcus := (nVtotcus - nVjurest)
			nVlucbru := Iif( MV_PAR03 == 1 , VVA->VVA_LUCBRU , Iif( MV_PAR03 == 2 , VVA->VVA_LMFBRU , xmoeda(VVA->VVA_LUCBRU,1,MV_PAR03,DDataBase)))
			
		Else
			
			nVfattot := Iif( MV_PAR03 == 1 , VVA->VVA_FATTOT , Iif( MV_PAR03 == 2 , VVA->VVA_FMFTOT , xmoeda(VVA->VVA_FATTOT,1,MV_PAR03,DDataBase)))
			If SFT->FT_VALICM == 0
				nVicmven := 0
			Else
				nVicmven := Iif( MV_PAR03 == 1 , VVA->VVA_ICMVEN , Iif( MV_PAR03 == 2 , VVA->VVA_IMFVEN , xmoeda(VVA->VVA_ICMVEN,1,MV_PAR03,DDataBase)))
			Endif
			nVtotcus := Iif( MV_PAR03 == 1 , VVA->VVA_TOTCUS , Iif( MV_PAR03 == 2 , VVA->VVA_TMFCUS , xmoeda(VVA->VVA_TOTCUS,1,MV_PAR03,DDataBase)))
			nVjurest := Iif( MV_PAR03 == 1 , VVA->VVA_JUREST , Iif( MV_PAR03 == 2 , VVA->VVA_JMFEST , xmoeda(VVA->VVA_JUREST,1,MV_PAR03,DDataBase)))
			nVtotcus := (nVtotcus - nVjurest)
			nVlucbru := Iif( MV_PAR03 == 1 , VVA->VVA_LUCBRU , Iif( MV_PAR03 == 2 , VVA->VVA_LMFBRU , xmoeda(VVA->VVA_LUCBRU,1,MV_PAR03,DDataBase)))
			
		EndIf
		
		nVtotdes := Iif( MV_PAR03 == 1 , VVA->VVA_TOTDES , Iif( MV_PAR03 == 2 , VVA->VVA_TMFDES , xmoeda(VVA->VVA_TOTDES,1,MV_PAR03,DDataBase)))
		nVcomvde := Iif( MV_PAR03 == 1 , (VVA->VVA_COMVDE+VVA->VVA_COMGER) , If( MV_PAR03 == 2 , (VVA->VVA_CMFVDE+VVA->VVA_CMFGER) , xmoeda((VVA->VVA_COMVDE+VVA->VVA_COMGER),1,MV_PAR03,DDataBase)))
		nVluclq1 := Iif( MV_PAR03 == 1 , VVA->VVA_LUCLQ1 , Iif( MV_PAR03 == 2 , VVA->VVA_LMFLQ1 , xmoeda(VVA->VVA_LUCLQ1,1,MV_PAR03,DDataBase)))
		nVdesfix := Iif( MV_PAR03 == 1 , VVA->VVA_DESFIX , Iif( MV_PAR03 == 2 , VVA->VVA_DMFFIX , xmoeda(VVA->VVA_DESFIX,1,MV_PAR03,DDataBase)))
		nVdesadm := 0
		nVluclq2 := Iif( MV_PAR03 == 1 , VVA->VVA_LUCLQ2 , Iif( MV_PAR03 == 2 , VVA->VVA_LMFLQ2 , xmoeda(VVA->VVA_LUCLQ2,1,MV_PAR03,DDataBase)))
		
		DbSelectArea( "VV1" )
		DbSetOrder(1)
		DbSeek( xFilial("VV1") + VVA->VVA_CHAINT )
		
		DbSelectArea("VV2")
		DbSetOrder(1)
		DbSeek(xFilial("VV2") + VV1->VV1_CODMAR + VV1->VV1_MODVEI )
		
		nPos := 0
		If ( MV_PAR05 == 1 .or. ( MV_PAR05 == 2 .and. MV_PAR04 # 3 .and. MV_PAR04 # 4 ))
			nPos := aScan(aNumVei,{|x| x[1] + x[2] + x[3] == "88" + VV2->VV2_DESMOD })
		Else
			DbSelectArea( "SA1" )
			DbSetOrder(1)
			//DbSeek( xFilial("SA1") + VV1->VV1_PROATU + VV1->VV1_LJPATU ) 16/03/2009 - Alterado por Otavio e Silvania
			DbSeek( xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA )
			//cCliente := VV1->VV1_PROATU + " " + left(SA1->A1_NOME,15) 16/03/2009 - Alterado por Otavio e Silvania
			cCliente := SF2->F2_CLIENTE + " " + left(SA1->A1_NOME,15)
			nPos := aScan(aNumVei,{|x| x[1] + x[2] + x[3] == "88" + cCliente })
		EndIf
		
		If nPos == 0
			If ( MV_PAR05 == 1 .or. ( MV_PAR05 == 2 .and. MV_PAR04 # 3 .and. MV_PAR04 # 4 ))
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				aAdd(aNumVei,{ "8" , "8" , VV2->VV2_DESMOD , nVfattot , nVtotimp , nVicmven , nVpisven , nVcofven , nVtotcus , nVjurest , nVlucbru , nVtotdes , nVcomvde , nVluclq1 , nVdesfix , nVdesadm , nVluclq2 , 1 , VV1->VV1_MODVEI, nVPrzMd1, nVPrzMd2, nVdescon })
			Else
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				aAdd(aNumVei,{ "8" , "8" , cCliente , nVfattot , nVtotimp , nVicmven , nVpisven , nVcofven , nVtotcus , nVjurest , nVlucbru , nVtotdes , nVcomvde , nVluclq1 , nVdesfix , nVdesadm , nVluclq2 , 1 , VV1->VV1_MODVEI, nVPrzMd1, nVPrzMd2, nVdescon })
			EndIf
		Else
			aNumVei[nPos,4]  += nVfattot
			aNumVei[nPos,5]  += nVtotimp
			aNumVei[nPos,6]  += nVicmven
			aNumVei[nPos,7]  += nVpisven
			aNumVei[nPos,8]  += nVcofven
			aNumVei[nPos,9]  += nVtotcus
			aNumVei[nPos,10] += nVjurest
			aNumVei[nPos,11] += nVlucbru
			aNumVei[nPos,12] += nVtotdes
			aNumVei[nPos,13] += nVcomvde
			aNumVei[nPos,14] += nVluclq1
			aNumVei[nPos,15] += nVdesfix
			aNumVei[nPos,16] += nVdesadm
			aNumVei[nPos,17] += nVluclq2
			// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
			aNumVei[nPos,20] += nVPrzMd1
			aNumVei[nPos,21] += nVPrzMd2
			// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
			aNumVei[nPos,22] += nVdescon
			aNumVei[nPos,18]++
		EndIf
		
		nPos := 0
		nPos := aScan(aNumVei,{|x| x[1] + x[2] + x[3] == "88" + space(30) })
		If nPos == 0
			// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
			aAdd(aNumVei,{ "8" , "8" , space(30) , VVA->VVA_VALVDA , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , VV1->VV1_MODVEI , 0 , 0, 0 })
		Else
			aNumVei[nPos,4]  += VVA->VVA_VALVDA
		EndIf
		nPos := 0
		If ( MV_PAR05 == 1 .or. ( MV_PAR05 == 2 .and. MV_PAR04 # 3 .and. MV_PAR04 # 4 ))
			nPos := aScan(aNumVei,{|x| x[1] + x[2] + x[3] == "88" + VV2->VV2_DESMOD + "X" })
		Else
			//cCliente := VV1->VV1_PROATU + " " + left(SA1->A1_NOME,15) 16/03/2009 - Alterado por Otavio e Silvania
			cCliente := SF2->F2_CLIENTE + " " + left(SA1->A1_NOME,15)
			nPos := aScan(aNumVei,{|x| x[1] + x[2] + x[3] == "88" + cCliente + "X" })
		EndIf
		If nPos == 0
			If ( MV_PAR05 == 1 .or. ( MV_PAR05 == 2 .and. MV_PAR04 # 3 .and. MV_PAR04 # 4 ))
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				aAdd(aNumVei,{ "8" , "8" , VV2->VV2_DESMOD + "X" , VVA->VVA_VALVDA , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , VV1->VV1_MODVEI , 0 , 0, 0})
			Else
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				aAdd(aNumVei,{ "8" , "8" , cCliente + "X" , VVA->VVA_VALVDA , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , VV1->VV1_MODVEI , 0 , 0, 0})
			EndIf
		Else
			aNumVei[nPos,4]  += VVA->VVA_VALVDA
		EndIf
		
		nPos := 0
		nPos := aScan(aGrpVei,{|x| x[1] + x[2] == "88" })
		If nPos == 0
			// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
			aAdd(aGrpVei,{ "8" , "8" , nVfattot , nVtotimp , nVicmven , nVpisven , nVcofven , nVtotcus , nVjurest , nVlucbru , nVtotdes , nVcomvde , nVluclq1 , nVdesfix , nVdesadm , nVluclq2 , 1 , nVPrzMd1, nVPrzMd2, nVdescon })
		Else
			aGrpVei[nPos,3]  += nVfattot
			aGrpVei[nPos,4]  += nVtotimp
			aGrpVei[nPos,5]  += nVicmven
			aGrpVei[nPos,6]  += nVpisven
			aGrpVei[nPos,7]  += nVcofven
			aGrpVei[nPos,8]  += nVtotcus
			aGrpVei[nPos,9]  += nVjurest
			aGrpVei[nPos,10] += nVlucbru
			aGrpVei[nPos,11] += nVtotdes
			aGrpVei[nPos,12] += nVcomvde
			aGrpVei[nPos,13] += nVluclq1
			aGrpVei[nPos,14] += nVdesfix
			aGrpVei[nPos,15] += nVdesadm
			aGrpVei[nPos,16] += nVluclq2
			// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
			aGrpVei[nPos,18] += nVPrzMd1
			aGrpVei[nPos,19] += nVPrzMd2
			// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
			aGrpVei[nPos,20] += nVdescon
			aGrpVei[nPos,17]++
		EndIf
	EndIf
	
	dbSelectArea(cAliasVV0)
	(cAliasVV0)->(Dbskip())
EndDo
(cAliasVV0)->(DBCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³FS_M_OR25C³ Autor ³ Andre Luis Almeida    ³ Data ³ 10/04/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Carregando VETOR de Vendas de Pecas                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_M_OR25C()

local ii := 0
Local cSeekSF2 := ""
Local	cDpto    := "  "
Local nContpis := nContcof := nContjur := nContbru := nContvar := nContcom := nContliq := nContfix := nContdep := nContfin := nCofins := 0
Local lDuplic  := .f.
// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
Local nVPrzMd1 := nVPrzMd2 := 0
Local na := nk := 1
// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
Local nPdescon := 0
Local cAliasVEC := "SQLVEC"
Local aPulaVEC := {}
Local nRecVEC  := 0
Local cConfere := 0
Local nAVECI   := 1
Local nPulaVEC := 0

//Local aResRet := {}

///////////////////////////////////
//         P  E  C  A  S         //
///////////////////////////////////

If FunName() == "OFIOR250"
	IncRegua()
EndIf

//cQuery := "SELECT VEC.VEC_DATVEN,VEC.VEC_BALOFI,VEC.VEC_NUMNFI,VEC.VEC_SERNFI,VEC.VEC_NUMORC,VEC.VEC_PECINT,VEC.VEC.TIPTEM,VEC.VEC.VALPIS,VEC.VEC.VMFPIS,VEC.VEC.VALCOF,VEC.VEC.VMFCOF,VEC.VEC.JUREST,VEC.VEC.JMFEST, "
//cQuery := "VEC.VEC_LUCBRU,LMFBRU,VEC_BALOFI,VEC.VEC_NUMNFI,VEC.VEC_SERNFI,VEC.VEC_NUMORC,VEC.VEC_PECINT,VEC.VEC.TIPTEM,VEC.VEC.VALPIS,VEC.VEC.VMFPIS,VEC.VEC.VALCOF,VEC.VEC.VMFCOF,VEC.VEC.JUREST,VEC.VEC.JMFEST, "
cQuery := "SELECT * "
cQuery += "FROM "
cQuery += RetSqlName( "VEC" ) + " VEC "
cQuery += "WHERE "
cQuery += "VEC.VEC_FILIAL='"+ xFilial("VEC")+ "' AND VEC.VEC_DATVEN >= '"+dtos(mv_par01)+"' AND VEC.VEC_DATVEN <= '"+dtos(mv_par02)+"' AND "
cQuery += "VEC.D_E_L_E_T_=' ' ORDER BY VEC.VEC_NUMNFI,VEC.VEC_SERNFI,VEC.VEC_GRUITE,VEC.VEC_CODITE "

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVEC, .T., .T. )

aAdd(aTotVei,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0})

// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
aAdd(aGrpPBO,{ "B" , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0, 0, 0 })
aAdd(aGrpPBO,{ "O" , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0, 0, 0 })
aAdd(aTotOOpe,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0, 0, 0 })   // Outras Operacoes - Total
aAdd(aOOpeSrv,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0, 0, 0 })   // Outras Operacoes - Servicos
aAdd(aOOpeOut,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0, 0, 0 })   // Outras Operacoes - Outros
aAdd(aTotPec,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0, 0, 0 })

While !((cAliasVEC)->(Eof()))
	cConfere := (cAliasVEC)->VEC_NUMNFI + (cAliasVEC)->VEC_SERNFI + (cAliasVEC)->VEC_GRUITE + (cAliasVEC)->VEC_CODITE
	nRecVEC  := (cAliasVEC)->(RECNO())
	(cAliasVEC)->(dbSkip())
	if cConfere == (cAliasVEC)->VEC_NUMNFI + (cAliasVEC)->VEC_SERNFI + (cAliasVEC)->VEC_GRUITE + (cAliasVEC)->VEC_CODITE
		//    aAdd(aPulaVEC,{nRecVEC})
		aadd(aPulaVEC,{nRecVEC})
	Endif
Enddo
nPulaVEC := Len(aPulaVEC)

(cAliasVEC)->(dbGotop())

While !((cAliasVEC)->(Eof()))
	
	If FunName() == "OFIOR250"
		nCont ++
		If nCont == 400
			IncRegua()
			nCont := 2
			If lAbortPrint
				nLin++
				@nLin++,30 PSAY STR0058 //"* * *  C A N C E L A D O   P E L O   O P E R A D O R  * * *"
				Exit
			EndIf
		EndIf
	EndIf
	If (!Empty(MV_PAR01) .and. (stod((cAliasVEC)->VEC_DATVEN) < MV_PAR01))
		dbSelectArea(cAliasVEC)
		(cAliasVEC)->(Dbskip())
		Loop
	EndIf
	If (cAliasVEC)->VEC_BALOFI == "B"
		DbSelectArea( "VS1" )
		DbSetOrder(3)
		If !DbSeek( xFilial("VS1") + (cAliasVEC)->VEC_NUMNFI + (cAliasVEC)->VEC_SERNFI , .f. )
			dbSelectArea(cAliasVEC)
			(cAliasVEC)->(Dbskip())
			Loop
		EndIf
		cSeekSF2 := (cAliasVEC)->VEC_NUMNFI + (cAliasVEC)->VEC_SERNFI + VS1->VS1_CLIFAT + VS1->VS1_LOJA
		cDpto := VS1->VS1_DEPTO
	Else
		DbSelectArea( "VS1" )
		DbSetOrder(1)
		DbSeek( xFilial("VS1") + (cAliasVEC)->VEC_NUMORC, .f. )
		DbSelectArea( "VOO" )
		DbSetOrder(4)
		DbSeek( xFilial("VOO") + (cAliasVEC)->VEC_NUMNFI + (cAliasVEC)->VEC_SERNFI , .t. )
		cSeekSF2 := (cAliasVEC)->VEC_NUMNFI + (cAliasVEC)->VEC_SERNFI + VOO->VOO_FATPAR + VOO->VOO_LOJA
		cDpto := VOO->VOO_DEPTO
	EndIf
	
	///////////// Brindes - Desconsiderar /////////////
	DbSelectArea( "SF2" )
	DbSetOrder(1)
	If !DbSeek( xFilial("SF2") + cSeekSF2 , .f. )
		dbSelectArea(cAliasVEC)
		(cAliasVEC)->(Dbskip())
		Loop
	Else
		If SF2->F2_TIPO # "N"
			dbSelectArea(cAliasVEC)
			(cAliasVEC)->(Dbskip())
			Loop
		EndIf
		DbSelectArea( "SD2" )
		DbSetOrder(3)
		If !DbSeek( xFilial("SD2") + cSeekSF2 + (cAliasVEC)->VEC_PECINT , .f. )
			dbSelectArea(cAliasVEC)
			(cAliasVEC)->(Dbskip())
			Loop
		EndIf
		DbSelectArea( "VOI" )
		DbSetOrder(1)
		DbSeek( xFilial("VOI") + (cAliasVEC)->VEC_TIPTEM , .f. )
		DbSelectArea( "SF4" )
		DbSetOrder(1)
		DbSeek( xFilial("SF4") + SD2->D2_TES )
		DbSelectArea("SFT")
		DbSetOrder(1)
		DbSeek(xFilial("SFT")+ "S" + SD2->D2_SERIE + SD2->D2_DOC + SD2->D2_CLIENTE + SD2->D2_LOJA + SD2->D2_ITEM)
		lDuplic := .t.
		If SF4->F4_DUPLIC == "N" .and. SF4->F4_OPEMOV <> "05"
			lDuplic := .f.
			If VOI->VOI_SITTPO # "3"
				dbSelectArea(cAliasVEC)
				(cAliasVEC)->(Dbskip())
				Loop
			EndIf
		EndIf
	EndIf
	//////////////////////////////////////////////////////////////////////////
	
	If dtos(SF2->F2_EMISSAO) < "20040201"
		nCofins := ( 3 / 100 )
	Else
		nCofins := nCof
	EndIf
	
	If (cAliasVEC)->VEC_BALOFI == "B"
		If SD2->D2_VALISS > 0
			dbSelectArea(cAliasVEC)
			(cAliasVEC)->(Dbskip())
			Loop
		EndIf
		If SF4->F4_DUPLIC == "N" .and. SF4->F4_OPEMOV <> "05"
			dbSelectArea(cAliasVEC)
			(cAliasVEC)->(Dbskip())
			Loop
		EndIf
		nPos := 1
	Else // (cAliasVEC)->VEC_BALOFI == "O"
		nPos := 2
	EndIf
	
	// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
	na := ( (SF2->F2_VALBRUT-SF2->F2_BASEISS) / SF2->F2_VALBRUT )
	nk := ( (SD2->D2_TOTAL+SD2->D2_VALIPI) / ( SF2->F2_VALBRUT - SF2->F2_BASEISS ) )
	nVprzmd1 := nVprzmd2 := 0
	DbSelectArea("SE1")
	DbSetOrder(1)
	DbSeek( xFilial("SE1") + SF2->F2_PREFIXO + SF2->F2_DUPL )
	While !Eof() .and. ( SE1->E1_FILIAL == xFilial("SE1") ) .and. ( ( SF2->F2_PREFIXO + SF2->F2_DUPL ) == ( SE1->E1_PREFIXO + SE1->E1_NUM ) )
		nVprzmd1 += ( ( nk * ( SE1->E1_VALOR * na ) ) * ( SE1->E1_VENCTO - SF2->F2_EMISSAO ) )
		nVprzmd2 += ( nk * ( SE1->E1_VALOR * na )  )
		If Alltrim(SE1->E1_TIPO) == "CD" // CDCI - sem prazo medio
			nVprzmd1 := 0
		EndIf
		DbSelectArea("SE1")
		Dbskip()
	EndDo
	
	If MV_PAR08 # 1
		If SFT->FT_VALIMP5 > 0 .AND. SFT->FT_VALIMP6 > 0    // Tributado
			nContpis += Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_VALPIS , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_VMFPIS , xmoeda((cAliasVEC)->VEC_VALPIS,1,MV_PAR03,DDataBase)))
			nContcof += Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_VALCOF , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_VMFCOF , xmoeda((cAliasVEC)->VEC_VALCOF,1,MV_PAR03,DDataBase)))
		EndIf
		nContjur += Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_JUREST , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_JMFEST , xmoeda((cAliasVEC)->VEC_JUREST,1,MV_PAR03,DDataBase)))
		nContbru += Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_LUCBRU , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_LMFBRU , xmoeda((cAliasVEC)->VEC_LUCBRU,1,MV_PAR03,DDataBase)))
		//		nContbru += nPvalvda - nPtotimp - nPcustot
		nContvar += Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_DESVAR , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_DMFVAR , xmoeda((cAliasVEC)->VEC_DESVAR,1,MV_PAR03,DDataBase)))
		nContcom += Iif( MV_PAR03 == 1 , ((cAliasVEC)->VEC_COMVEN+(cAliasVEC)->VEC_COMGER) , Iif( MV_PAR03 == 2 , ((cAliasVEC)->VEC_CMFVEN+(cAliasVEC)->VEC_CMFGER) , xmoeda(((cAliasVEC)->VEC_COMVEN+(cAliasVEC)->VEC_COMGER),1,MV_PAR03,DDataBase)))
		nContliq += Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_LUCLIQ , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_LMFLIQ , xmoeda((cAliasVEC)->VEC_LUCLIQ,1,MV_PAR03,DDataBase)))
		nContfix += Iif( MV_PAR03 == 1 , ((cAliasVEC)->VEC_DESFIX+(cAliasVEC)->VEC_CUSFIX+(cAliasVEC)->VEC_ICMSST+(cAliasVEC)->VEC_DCLBST+(cAliasVEC)->VEC_COPIST) , Iif( MV_PAR03 == 2 , ((cAliasVEC)->VEC_DMFFIX+(cAliasVEC)->VEC_CMFFIX+(cAliasVEC)->VEC_IMFSST+(cAliasVEC)->VEC_DMFBST+(cAliasVEC)->VEC_CMFIST) , xmoeda(((cAliasVEC)->VEC_DESFIX+(cAliasVEC)->VEC_CUSFIX+(cAliasVEC)->VEC_ICMSST+(cAliasVEC)->VEC_DCLBST+(cAliasVEC)->VEC_COPIST),1,MV_PAR03,DDataBase)))
		nContdep += Iif( MV_PAR03 == 1 , ((cAliasVEC)->VEC_DESDEP+(cAliasVEC)->VEC_DESADM) , Iif( MV_PAR03 == 2 , ((cAliasVEC)->VEC_DMFDEP+(cAliasVEC)->VEC_DMFADM) , xmoeda(((cAliasVEC)->VEC_DESDEP+(cAliasVEC)->VEC_DESADM),1,MV_PAR03,DDataBase)))
		nContfin += Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_RESFIN , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_RMFFIN , xmoeda((cAliasVEC)->VEC_RESFIN,1,MV_PAR03,DDataBase)))
		//		cConfere := (cAliasVEC)->VEC_NUMNFI + (cAliasVEC)->VEC_SERNFI + (cAliasVEC)->VEC_GRUITE + (cAliasVEC)->VEC_CODITE
		//		dbSelectArea(cAliasVEC)
		//		(cAliasVEC)->(Dbskip())
		//		If ( cConfere == ( (cAliasVEC)->VEC_NUMNFI + (cAliasVEC)->VEC_SERNFI + (cAliasVEC)->VEC_GRUITE + (cAliasVEC)->VEC_CODITE ) )
		//			dbSelectArea(cAliasVEC)
		//			Loop
		//		EndIf
		//		dbSelectArea(cAliasVEC)
		//		(cAliasVEC)->(Dbskip(-1))
		if nAVECI <= nPulaVEC
			if aPulaVEC[nAVECI,1] == (cAliasVEC)->(Recno())
				(cAliasVEC)->(dbSkip())
				nAVECI++
				Loop
			Endif
		Endif

		// Verifica se tem COFINS/PIS - se tem SFT->FT_VALIMP5(COF) e se tem SFT->FT_VALIMP6(PIS)
		If SFT->FT_VALIMP5 > 0 .AND. SFT->FT_VALIMP6 == 0
			nContcof += SD2->D2_VALIMP5
		ElseIf SFT->FT_VALIMP5 == 0 .AND. SFT->FT_VALIMP6 > 0
			nContpis += SD2->D2_VALIMP6
		ElseIf SFT->FT_VALIMP5 > 0 .AND. SFT->FT_VALIMP6 > 0
			nContpis += SD2->D2_VALIMP6
			nContcof += SD2->D2_VALIMP5
		EndIf

		nPvalpis := nContpis
		nPvalcof := nContcof
		nPjurest := nContjur
		nPlucbru := nContbru
		nPdesvar := nContvar
		nPcomven := nContcom
		nPlucliq := nContliq
		nPdesfix := nContfix
		nPdesdep := nContdep
		nPresfin := nContfin
		nContpis := nContcof := nContjur := nContbru := nContvar := nContcom := nContliq := nContfix := nContdep := nContfin := 0
	Else
		//		nPvalpis := Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_VALPIS , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_VMFPIS , xmoeda((cAliasVEC)->VEC_VALPIS,1,MV_PAR03,DDataBase)))
		nPvalpis := Iif( MV_PAR03 == 1 , SD2->D2_VALIMP6 , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_VMFPIS , xmoeda((cAliasVEC)->VEC_VALPIS,1,MV_PAR03,DDataBase)))
		//		nPvalcof := Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_VALCOF , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_VMFCOF , xmoeda((cAliasVEC)->VEC_VALCOF,1,MV_PAR03,DDataBase)))
		nPvalcof := Iif( MV_PAR03 == 1 , SD2->D2_VALIMP5 , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_VMFCOF , xmoeda((cAliasVEC)->VEC_VALCOF,1,MV_PAR03,DDataBase)))
		nPjurest := Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_JUREST , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_JMFEST , xmoeda((cAliasVEC)->VEC_JUREST,1,MV_PAR03,DDataBase)))
		nPlucbru := Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_LUCBRU , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_LMFBRU , xmoeda((cAliasVEC)->VEC_LUCBRU,1,MV_PAR03,DDataBase)))
		nPdesvar := Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_DESVAR , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_DMFVAR , xmoeda((cAliasVEC)->VEC_DESVAR,1,MV_PAR03,DDataBase)))
		nPcomven := Iif( MV_PAR03 == 1 , ((cAliasVEC)->VEC_COMVEN+(cAliasVEC)->VEC_COMGER) , Iif( MV_PAR03 == 2 , ((cAliasVEC)->VEC_CMFVEN+(cAliasVEC)->VEC_CMFGER) , xmoeda(((cAliasVEC)->VEC_COMVEN+(cAliasVEC)->VEC_COMGER),1,MV_PAR03,DDataBase)))
		nPlucliq := Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_LUCLIQ , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_LMFLIQ , xmoeda((cAliasVEC)->VEC_LUCLIQ,1,MV_PAR03,DDataBase)))
		nPdesfix := Iif( MV_PAR03 == 1 , ((cAliasVEC)->VEC_DESFIX+(cAliasVEC)->VEC_CUSFIX) , Iif( MV_PAR03 == 2 , ((cAliasVEC)->VEC_DMFFIX+(cAliasVEC)->VEC_CMFFIX) , xmoeda(((cAliasVEC)->VEC_DESFIX+(cAliasVEC)->VEC_CUSFIX),1,MV_PAR03,DDataBase)))
		nPdesdep := Iif( MV_PAR03 == 1 , ((cAliasVEC)->VEC_DESDEP+(cAliasVEC)->VEC_DESADM) , Iif( MV_PAR03 == 2 , ((cAliasVEC)->VEC_DMFDEP+(cAliasVEC)->VEC_DMFADM) , xmoeda(((cAliasVEC)->VEC_DESDEP+(cAliasVEC)->VEC_DESADM),1,MV_PAR03,DDataBase)))
		nPresfin := Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_RESFIN , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_RMFFIN , xmoeda((cAliasVEC)->VEC_RESFIN,1,MV_PAR03,DDataBase)))
	EndIf
	
	If (MV_PAR08 == 1)
		
		nPvalvda := Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_VALVDA , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_VMFVDA , xmoeda((cAliasVEC)->VEC_VALVDA,1,MV_PAR03,DDataBase)))
		nQtdVda  := (cAliasVEC)->VEC_QTDITE
		nPtotimp := Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_TOTIMP , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_TMFIMP , xmoeda((cAliasVEC)->VEC_TOTIMP,1,MV_PAR03,DDataBase)))
		If SFT->FT_VALICM == 0
			nPvalicm := 0
		Else
			nPvalicm := Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_VALICM , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_VMFICM , xmoeda((cAliasVEC)->VEC_VALICM,1,MV_PAR03,DDataBase)))
		Endif
		nPcustot := Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_CUSMED , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_CMFMED , xmoeda((cAliasVEC)->VEC_CUSMED,1,MV_PAR03,DDataBase)))
		// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
		nPdescon := Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_VALDES , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_VMFDES , xmoeda((cAliasVEC)->VEC_VALDES,1,MV_PAR03,DDataBase)))
		
	Else
		
		If (cAliasVEC)->VEC_BALOFI == "B"
			
			nPvalvda := Iif( MV_PAR03 == 1 , (SD2->D2_TOTAL+SD2->D2_VALIPI)   , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_VMFVDA , xmoeda((SD2->D2_TOTAL+SD2->D2_VALIPI),1,MV_PAR03,DDataBase)))
			nQtdVda  := Iif( MV_PAR03 == 1 , SD2->D2_QUANT   , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_QTDITE , xmoeda(SD2->D2_QUANT,1,MV_PAR03,DDataBase)))
			//			nPos := Ascan(aResRet,{|x| x[1] == SD2->D2_DOC+"/"+SD2->D2_SERIE})
			//			If nPos == 0
			//   			aadd(aResRet,{SD2->D2_DOC+"/"+SD2->D2_SERIE,(SD2->D2_TOTAL+SD2->D2_VALIPI)})
			//		   Endif
			If SFT->FT_VALICM == 0
				nPvalicm := 0
			Else
				nPvalicm := Iif( MV_PAR03 == 1 , SD2->D2_VALICM  , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_VMFICM , xmoeda(SD2->D2_VALICM,1,MV_PAR03,DDataBase)))
			Endif
			nPtotimp := Iif( MV_PAR03 == 1 , ( nPvalpis + nPvalcof + nPvalicm ) , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_TMFIMP , xmoeda(( nPvalpis + nPvalcof + nPvalicm ),1,MV_PAR03,DDataBase)))
			nPcustot := Iif( MV_PAR03 == 1 , SD2->D2_CUSTO1 , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_CMFMED , xmoeda(SD2->D2_CUSTO1,1,MV_PAR03,DDataBase)))
			// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
			nPdescon := Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_VALDES , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_VMFDES , xmoeda((cAliasVEC)->VEC_VALDES,1,MV_PAR03,DDataBase)))
			
		Else // (cAliasVEC)->VEC_BALOFI == "O"
			
			DbSelectArea( "SD2" )
			DbSetOrder(3)
			DbSeek( xFilial("SD2") + cSeekSF2 + (cAliasVEC)->VEC_PECINT , .f. )
			
			nPvalvda := Iif( MV_PAR03 == 1 , (SD2->D2_TOTAL+SD2->D2_VALIPI)  , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_VMFVDA , xmoeda((SD2->D2_TOTAL+SD2->D2_VALIPI),1,MV_PAR03,DDataBase)))
			nQtdVda  := Iif( MV_PAR03 == 1 , SD2->D2_QUANT   , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_QTDITE , xmoeda(SD2->D2_QUANT,1,MV_PAR03,DDataBase)))
			If SFT->FT_VALICM == 0
				nPvalicm := 0
			Else
				nPvalicm := Iif( MV_PAR03 == 1 , SD2->D2_VALICM , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_VMFICM , xmoeda(SD2->D2_VALICM,1,MV_PAR03,DDataBase)))
			Endif
			nPtotimp := Iif( MV_PAR03 == 1 , ( nPvalpis + nPvalcof + nPvalicm ) , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_TMFIMP , xmoeda(( nPvalpis + nPvalcof + nPvalicm ),1,MV_PAR03,DDataBase)))
			nPcustot := Iif( MV_PAR03 == 1 , SD2->D2_CUSTO1 , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_CMFMED , xmoeda(SD2->D2_CUSTO1,1,MV_PAR03,DDataBase)))
			// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
			nPdescon := Iif( MV_PAR03 == 1 , (cAliasVEC)->VEC_VALDES , Iif( MV_PAR03 == 2 , (cAliasVEC)->VEC_VMFDES , xmoeda((cAliasVEC)->VEC_VALDES,1,MV_PAR03,DDataBase)))
			
		EndIf
		
	EndIf
	
	////////// TXT com Clientes/Itens //////////
	If (cAliasVEC)->VEC_BALOFI == "B" .or. VOI->VOI_SITTPO # "3" // NAO CONSTAR INTERNOS
		If FunName() == "OFIOR250"
			nMes := aScan(aTXTMes,{|x| x[1] == strzero(month(stod((cAliasVEC)->VEC_DATVEN)),2)+strzero(year(stod((cAliasVEC)->VEC_DATVEN)),4) })
		EndIf
		nTXTVda += nPvalvda
		nTXTLuc += nPlucbru
		If VOI->VOI_SITTPO != "2" // se nao for garantia
			nTXTVda += nPvalvda
			nTXTLuc += nPlucbru
			cTipGar   := "N"
		Else
			cTipGar   := "S"
		Endif
		//		nTXTAux1 := aScan(aTXTCli,{|x| x[1] == SD2->D2_CLIENTE + SD2->D2_LOJA + cTipGar})
		nTXTAux1 := aScan(aTXTCli,{|x| x[1] == SD2->D2_CLIENTE + SD2->D2_LOJA})
		If nTXTAux1 == 0
			//			aAdd(aTXTCli,{ SD2->D2_CLIENTE + SD2->D2_LOJA + cTipGar, nPvalvda , space(12) , nPlucbru , space(12) , len(aTXTCli)+1, VOI->VOI_SITTPO })
			aAdd(aTXTCli,{ SD2->D2_CLIENTE + SD2->D2_LOJA , nPvalvda , space(12) , nPlucbru , space(12) , len(aTXTCli)+1, VOI->VOI_SITTPO })
			If FunName() == "OFIOR250"
				//				If VOI->VOI_SITTPO != "2" // se nao for garantia
				aAdd(aTXTCliA,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
				//					nTXTAux1 := len(aTXTCliA)
				//				Else
				aAdd(aTXTCliNG,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
				//					nTXTAux1 := len(aTXTCliNG)
				//				Endif
				nTXTAux1 := len(aTXTCli)
			EndIf
		Else
			aTXTCli[nTXTAux1,2] += nPvalvda
			aTXTCli[nTXTAux1,4] += nPlucbru
		EndIf
		If FunName() == "OFIOR250"
			If nMes > 0
				If VOI->VOI_SITTPO != "2" // se nao for garantia
					If Len(aTXTCliA) < nTXTAux1
						nCont := Len(aTXTCliA) + 1
						for ii := nCont to nTXTAux1
							aAdd(aTXTCliA,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
						Next
					Endif
					aTXTCliA[aTXTCli[nTXTAux1,6],nMes] += nPvalvda
					aTXTCliA[aTXTCli[nTXTAux1,6],nMes+1] += nPlucbru
				Else
					If Len(aTXTCliNG) < nTXTAux1
						nCont := Len(aTXTCliNG) + 1
						for ii := nCont to nTXTAux1
							aAdd(aTXTCliNG,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
						Next
					Endif
					aTXTCliNG[aTXTCli[nTXTAux1,6],nMes] += nPvalvda
					aTXTCliNG[aTXTCli[nTXTAux1,6],nMes+1] += nPlucbru
				Endif
			EndIf
		EndIf
		//		nTXTAux1 := aScan(aTXTIte,{|x| x[1] == (cAliasVEC)->VEC_GRUITE + (cAliasVEC)->VEC_CODITE + cTipGar})
		nTXTAux1 := aScan(aTXTIte,{|x| x[1] == (cAliasVEC)->VEC_GRUITE + (cAliasVEC)->VEC_CODITE})
		If nTXTAux1 == 0
			//			aAdd(aTXTIte,{ (cAliasVEC)->VEC_GRUITE + (cAliasVEC)->VEC_CODITE + cTipGar, nPvalvda , space(12) , nPlucbru , space(12) , len(aTXTIte)+1 , VOI->VOI_SITTPO})
			aAdd(aTXTIte,{ (cAliasVEC)->VEC_GRUITE + (cAliasVEC)->VEC_CODITE , nPvalvda , space(12) , nPlucbru , space(12) , len(aTXTIte)+1 , VOI->VOI_SITTPO,nQtdVda})
			If FunName() == "OFIOR250"
				//				If VOI->VOI_SITTPO != "2" // se nao for garantia
				aAdd(aTXTIteA,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
				//					nTXTAux1 := len(aTXTIteA)
				//				Else
				aAdd(aTXTIteNG,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
				//					nTXTAux1 := len(aTXTIteNG)
				//				Endif
				nTXTAux1 := len(aTXTIte)
			EndIf
		Else
			aTXTIte[nTXTAux1,2] += nPvalvda
			aTXTIte[nTXTAux1,4] += nPlucbru
			aTXTIte[nTXTAux1,8] += nQtdVda
		EndIf
		If FunName() == "OFIOR250"
			If nMes > 0
				If VOI->VOI_SITTPO != "2" // se nao for garantia
					If Len(aTXTIteA) < nTXTAux1
						nCont := Len(aTXTIteA) + 1
						for ii := nCont to nTXTAux1
							aAdd(aTXTIteA,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
						Next
					Endif
					aTXTIteA[aTXTIte[nTXTAux1,6],nMes] += nPvalvda
					aTXTIteA[aTXTIte[nTXTAux1,6],nMes+1] += nPlucbru
				Else
					If Len(aTXTIteNG) < nTXTAux1
						nCont := Len(aTXTIteNG) + 1
						for ii := nCont to nTXTAux1
							aAdd(aTXTIteNG,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
						Next
					Endif
					aTXTIteNG[aTXTIte[nTXTAux1,6],nMes] += nPvalvda
					aTXTIteNG[aTXTIte[nTXTAux1,6],nMes+1] += nPlucbru
				EndIf
			EndIf
		EndIf
	EndIf
	////////////////////////////////////////////
	
	If ( Alltrim(VS1->VS1_NOROUT) == "2" .and. Alltrim((cAliasVEC)->VEC_GRUITE) == "SRVC" )
		DbSelectArea("SFT")
		DbSetOrder(1)
		DbSeek(xFilial("SFT")+ "S" + SD2->D2_SERIE + SD2->D2_DOC + SD2->D2_CLIENTE + SD2->D2_LOJA + SD2->D2_ITEM)
		
		aTotOOpe[1,1] += nPvalvda
		if SFT->FT_VALICM > 0
			aTotOOpe[1,2] += (SF2->F2_VALICM + SF2->F2_VALISS + nPvalpis + nPvalcof)
			aTotOOpe[1,3] += SF2->F2_VALICM
		Else
			aTotOOpe[1,2] += (SF2->F2_VALISS + nPvalpis + nPvalcof)
			//			aTotOOpe[1,3] += SF2->F2_VALICM
		Endif
		aTotOOpe[1,4] += SF2->F2_VALISS
		aTotOOpe[1,5] += nPvalpis
		aTotOOpe[1,6] += nPvalcof
		aTotOOpe[1,7] += nPcustot
		aTotOOpe[1,8] += nPjurest
		aTotOOpe[1,9] += nPlucbru
		aTotOOpe[1,10]+= nPdesvar
		aTotOOpe[1,11]+= nPcomven
		aTotOOpe[1,12]+= nPlucliq
		aTotOOpe[1,13]+= nPdesfix
		aTotOOpe[1,14]+= nPdesdep
		aTotOOpe[1,15]+= nPresfin
		// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
		aTotOOpe[1,16]+= nVPrzMd1
		aTotOOpe[1,17]+= nVPrzMd2
		// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
		aTotOOpe[1,18]+= nPdescon
		aOOpeSrv[1,1] += nPvalvda
		if SFT->FT_VALICM > 0
			aOOpeSrv[1,2] += (SF2->F2_VALICM + SF2->F2_VALISS + nPvalpis + nPvalcof)
			aOOpeSrv[1,3] += SF2->F2_VALICM
		Else
			aOOpeSrv[1,2] += (SF2->F2_VALISS + nPvalpis + nPvalcof)
			//			aOOpeSrv[1,3] += SF2->F2_VALICM
		Endif
		aOOpeSrv[1,4] += SF2->F2_VALISS
		aOOpeSrv[1,5] += nPvalpis
		aOOpeSrv[1,6] += nPvalcof
		aOOpeSrv[1,7] += nPcustot
		aOOpeSrv[1,8] += nPjurest
		aOOpeSrv[1,9] += nPlucbru
		aOOpeSrv[1,10]+= nPdesvar
		aOOpeSrv[1,11]+= nPcomven
		aOOpeSrv[1,12]+= nPlucliq
		aOOpeSrv[1,13]+= nPdesfix
		aOOpeSrv[1,14]+= nPdesdep
		aOOpeSrv[1,15]+= nPresfin
		// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
		aOOpeSrv[1,16]+= nVPrzMd1
		aOOpeSrv[1,17]+= nVPrzMd1
		// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
		aOOpeSrv[1,18]+= nPdescon
		
		If MV_PAR06 # 1
			
			nPos2 := 0
			nPos2 := aScan(aGrpPag,{|x| x[1] == SF2->F2_COND })
			//If nPos2 == 0
			//	DbSelectArea( "SE4" )
			//	DbSetOrder(1)
			//	DbSeek( xFilial("SE4") + SF2->F2_COND )
			//	if SFT->FT_VALICM > 0
			//		aAdd(aGrpPag,{ SF2->F2_COND , SE4->E4_DESCRI , nPvalvda , (SF2->F2_VALICM + SF2->F2_VALISS + nPvalpis + nPvalcof) , SF2->F2_VALICM , SF2->F2_VALISS , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
			//	Else
			//		aAdd(aGrpPag,{ SF2->F2_COND , SE4->E4_DESCRI , nPvalvda , (SF2->F2_VALISS + nPvalpis + nPvalcof) , 0 , SF2->F2_VALISS , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
			//	Endif
			//Else
				aGrpPag[nPos2,3] += nPvalvda
				if SFT->FT_VALICM > 0
					aGrpPag[nPos2,4] += (SF2->F2_VALICM + SF2->F2_VALISS + nPvalpis + nPvalcof)
					aGrpPag[nPos2,5] += SF2->F2_VALICM
				Else
					aGrpPag[nPos2,4] += (SF2->F2_VALISS + nPvalpis + nPvalcof)
					//				 	aGrpPag[nPos2,5] += SF2->F2_VALICM
				Endif
				aGrpPag[nPos2,6] += SF2->F2_VALISS
				aGrpPag[nPos2,7] += nPvalpis
				aGrpPag[nPos2,8] += nPvalcof
				aGrpPag[nPos2,9] += nPcustot
				aGrpPag[nPos2,10]+= nPjurest
				aGrpPag[nPos2,11]+= nPlucbru
				aGrpPag[nPos2,12]+= nPdesvar
				aGrpPag[nPos2,13]+= nPcomven
				aGrpPag[nPos2,14]+= nPlucliq
				aGrpPag[nPos2,15]+= nPdesfix
				aGrpPag[nPos2,16]+= nPdesdep
				aGrpPag[nPos2,17]+= nPresfin
				// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
				aGrpPag[nPos2,18]+= nVPrzMd1
				aGrpPag[nPos2,19]+= nVPrzMd2
				// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
				aGrpPag[nPos2,20]+= nPdescon
			//EndIf
			
			DbSelectArea( "VAI" )
			DbSetOrder(6)
			DbSeek( xFilial("VAI") + SF2->F2_VEND1 )
			
			nPos2 := 0
			If MV_PAR06 # 3
				nPos2 := aScan(aTotPag,{|x| x[1]+x[2] == SF2->F2_COND + Iif(lDuplic,"E","I")+SF2->F2_VEND1 })
			Else
				nPos2 := aScan(aTotPag,{|x| x[1]+x[2] == SF2->F2_COND + Iif(lDuplic,"E","I")+VAI->VAI_CC })
			EndIf
			
			If nPos2 == 0 .or. MV_PAR06 == 4
				//If MV_PAR06 # 3
					DbSelectArea( "SA3" )
					DbSetOrder(1)
					DbSeek( xFilial("SA3") + VAI->VAI_CODVEN )
					// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
					if SFT->FT_VALICM > 0
						aAdd(aTotPag,{ SF2->F2_COND , Iif(lDuplic,"E","I")+SF2->F2_VEND1 , left(SA3->A3_NOME,17) , nPvalvda , (SF2->F2_VALICM + (nPvalvda * nPis) + (nPvalvda * nCofins)) , SF2->F2_VALICM , 0 , (nPvalvda * nPis) , (nPvalvda * nCofins) , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
					Else
						aAdd(aTotPag,{ SF2->F2_COND , Iif(lDuplic,"E","I")+SF2->F2_VEND1 , left(SA3->A3_NOME,17) , nPvalvda , ((nPvalvda * nPis) + (nPvalvda * nCofins)) , 0 , 0 , (nPvalvda * nPis) , (nPvalvda * nCofins) , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
					Endif
					nPos3 := 0
					nPos3 := aScan(aCCVend,{|x| x[1]+x[2] == Iif(lDuplic,"E","I")+VAI->VAI_CC + SF2->F2_VEND1 })
					//If nPos3 == 0
					//	DbSelectArea( "SI3" )
					//	DbSetOrder(1)
					//	DbSeek( xFilial("SI3") + VAI->VAI_CC )
					//	// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
					//	if SFT->FT_VALICM > 0
					//		aAdd(aCCVend,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , SF2->F2_VEND1 , left(SA3->A3_NOME,17) , nPvalvda , (SF2->F2_VALICM + nPvalpis + nPvalcof) , SF2->F2_VALICM , 0 , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin , Iif(lDuplic,"Ext ","Int ")+left(SI3->I3_DESC,21), nVPrzMd1, nVPrzMd2, nPdescon })
					//	Else
					//		aAdd(aCCVend,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , SF2->F2_VEND1 , left(SA3->A3_NOME,17) , nPvalvda , (nPvalpis + nPvalcof) , 0 , 0 , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin , Iif(lDuplic,"Ext ","Int ")+left(SI3->I3_DESC,21), nVPrzMd1, nVPrzMd2, nPdescon })
					//	Endif
					//Else
						aCCVend[nPos3,4]  += nPvalvda
						if SFT->FT_VALICM > 0
							aCCVend[nPos3,5]  += (SF2->F2_VALICM + nPvalpis + nPvalcof)
							aCCVend[nPos3,6]  += SF2->F2_VALICM
						Else
							aCCVend[nPos3,5]  += (nPvalpis + nPvalcof)
							//						 	aCCVend[nPos3,6]  += SF2->F2_VALICM
						Endif
						aCCVend[nPos3,8]  += nPvalpis
						aCCVend[nPos3,9]  += nPvalcof
						aCCVend[nPos3,10] += nPcustot
						aCCVend[nPos3,11] += nPjurest
						aCCVend[nPos3,12] += nPlucbru
						aCCVend[nPos3,13] += nPdesvar
						aCCVend[nPos3,14] += nPcomven
						aCCVend[nPos3,15] += nPlucliq
						aCCVend[nPos3,16] += nPdesfix
						aCCVend[nPos3,17] += nPdesdep
						aCCVend[nPos3,18] += nPresfin
						// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
						aCCVend[nPos3,20] += nVPrzMd1
						aCCVend[nPos3,21] += nVPrzMd2
						// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
						aCCVend[nPos3,22] += nPdescon
					//EndIf
					
					nPos3 := 0
					nPos3 := aScan(aTotCCV,{|x| x[1] == Iif(lDuplic,"E","I")+VAI->VAI_CC })
					//If nPos3 == 0
					//	// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
					//	if SFT->FT_VALICM > 0
					//		aAdd(aTotCCV,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , nPvalvda , (SF2->F2_VALICM + nPvalpis + nPvalcof) , SF2->F2_VALICM , 0 , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
					//	Else
					//		aAdd(aTotCCV,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , nPvalvda , (nPvalpis + nPvalcof) , 0 , 0 , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
					//	Endif
					//Else
						aTotCCV[nPos3,2]  += nPvalvda
						if SFT->FT_VALICM > 0
							aTotCCV[nPos3,3]  += (SF2->F2_VALICM + SF2->F2_VALISS + nPvalpis + nPvalcof)
							aTotCCV[nPos3,4]  += SF2->F2_VALICM
						Else
							aTotCCV[nPos3,3]  += (SF2->F2_VALISS + nPvalpis + nPvalcof)
							//						 	aTotCCV[nPos3,4]  += SF2->F2_VALICM
						Endif
						aTotCCV[nPos3,6]  += nPvalpis
						aTotCCV[nPos3,7]  += nPvalcof
						aTotCCV[nPos3,8]  += nPcustot
						aTotCCV[nPos3,9]  += nPjurest
						aTotCCV[nPos3,10] += nPlucbru
						aTotCCV[nPos3,11] += nPdesvar
						aTotCCV[nPos3,12] += nPcomven
						aTotCCV[nPos3,13] += nPlucliq
						aTotCCV[nPos3,14] += nPdesfix
						aTotCCV[nPos3,15] += nPdesdep
						aTotCCV[nPos3,16] += nPresfin
						// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
						aTotCCV[nPos3,17] += nVPrzMd1
						aTotCCV[nPos3,18] += nVPrzMd2
						// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
						aTotCCV[nPos3,19] += nPdescon
					//EndIf
					
				//Else
				//	DbSelectArea( "SI3" )
				//	DbSetOrder(1)
				//	DbSeek( xFilial("SI3") + VAI->VAI_CC )
				//	// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
				//	if SFT->FT_VALICM > 0
				//		aAdd(aTotPag,{ SF2->F2_COND , Iif(lDuplic,"E","I")+VAI->VAI_CC , left(SI3->I3_DESC,14) , nPvalvda , (SF2->F2_VALICM + SF2->F2_VALISS + nPvalpis + nPvalcof) , SF2->F2_VALICM , SF2->F2_VALISS , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
				//	Else
				//		aAdd(aTotPag,{ SF2->F2_COND , Iif(lDuplic,"E","I")+VAI->VAI_CC , left(SI3->I3_DESC,14) , nPvalvda , (SF2->F2_VALISS + nPvalpis + nPvalcof) , 0 , SF2->F2_VALISS , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
				//	Endif
				//EndIf
			Else
				aTotPag[nPos2,4] += nPvalvda
				if SFT->FT_VALICM > 0
					aTotPag[nPos2,5] += (SF2->F2_VALICM + SF2->F2_VALISS + nPvalpis + nPvalcof)
					aTotPag[nPos2,6] += SF2->F2_VALICM
				Else
					aTotPag[nPos2,5] += (SF2->F2_VALISS + nPvalpis + nPvalcof)
					//				 	aTotPag[nPos2,6] += SF2->F2_VALICM
				Endif
				aTotPag[nPos2,7] += SF2->F2_VALISS
				aTotPag[nPos2,8] += nPvalpis
				aTotPag[nPos2,9] += nPvalcof
				aTotPag[nPos2,10]+= nPcustot
				aTotPag[nPos2,11]+= nPjurest
				aTotPag[nPos2,12]+= nPlucbru
				aTotPag[nPos2,13]+= nPdesvar
				aTotPag[nPos2,14]+= nPcomven
				aTotPag[nPos2,15]+= nPlucliq
				aTotPag[nPos2,16]+= nPdesfix
				aTotPag[nPos2,17]+= nPdesdep
				aTotPag[nPos2,18]+= nPresfin
				// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
				aTotPag[nPos2,19]+= nVPrzMd1
				aTotPag[nPos2,20]+= nVPrzMd2
				// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
				aTotPag[nPos2,21]+= nPdescon
			EndIf
			
		EndIf
		
		dbSelectArea(cAliasVEC)
		(cAliasVEC)->(Dbskip())
		Loop
		
	ElseIf ( Alltrim(VS1->VS1_NOROUT)=="2" )
		
		DbSelectArea( "SD2" )
		DbSetOrder(3)
		DbSeek( xFilial("SD2") + (cAliasVEC)->VEC_NUMNFI + (cAliasVEC)->VEC_SERNFI + VS1->VS1_CLIFAT + VS1->VS1_LOJA + (cAliasVEC)->VEC_PECINT , .f. )
		DbSelectArea( "SF4" )
		DbSetOrder(1)
		DbSeek( xFilial("SF4") + SD2->D2_TES )
		DbSelectArea("SFT")
		DbSetOrder(1)
		DbSeek(xFilial("SFT")+ "S" + SD2->D2_SERIE + SD2->D2_DOC + SD2->D2_CLIENTE + SD2->D2_LOJA + SD2->D2_ITEM)
		
		If ((SF4->F4_DUPLIC=="S" .or. SF4->F4_OPEMOV == "05") .and. SF4->F4_ESTOQUE=="N" .and. Alltrim(SF4->F4_ATUATF)#"S")
			
			aTotOOpe[1,1] += nPvalvda
			if SFT->FT_VALICM > 0
				aTotOOpe[1,2] += (SD2->D2_VALICM + (nPvalpis) + (nPvalcof))
			Else
				aTotOOpe[1,2] += ((nPvalpis) + (nPvalcof))
			Endif
			If SFT->FT_VALICM > 0
				aTotOOpe[1,3] += SD2->D2_VALICM
			Endif
			aTotOOpe[1,5] += (nPvalpis)
			aTotOOpe[1,6] += (nPvalcof)
			aTotOOpe[1,7] += nPcustot
			aTotOOpe[1,8] += nPjurest
			aTotOOpe[1,9] += nPlucbru
			aTotOOpe[1,10]+= nPdesvar
			aTotOOpe[1,11]+= nPcomven
			aTotOOpe[1,12]+= nPlucliq
			aTotOOpe[1,13]+= nPdesfix
			aTotOOpe[1,14]+= nPdesdep
			aTotOOpe[1,15]+= nPresfin
			// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
			aTotOOpe[1,16]+= nVPrzMd1
			aTotOOpe[1,17]+= nVPrzMd2
			// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
			aTotOOpe[1,18]+= nPdescon
			aOOpeOut[1,1] += nPvalvda
			If SFT->FT_VALICM > 0
				aOOpeOut[1,2] += (SD2->D2_VALICM + (nPvalpis) + (nPvalcof))
			Else
				aOOpeOut[1,2] += ((nPvalpis) + (nPvalcof))
			Endif
			If SFT->FT_VALICM > 0
				aOOpeOut[1,3] += SD2->D2_VALICM
			Endif
			aOOpeOut[1,5] += (nPvalpis)
			aOOpeOut[1,6] += (nPvalcof)
			aOOpeOut[1,7] += nPcustot
			aOOpeOut[1,8] += nPjurest
			aOOpeOut[1,9] += nPlucbru
			aOOpeOut[1,10]+= nPdesvar
			aOOpeOut[1,11]+= nPcomven
			aOOpeOut[1,12]+= nPlucliq
			aOOpeOut[1,13]+= nPdesfix
			aOOpeOut[1,14]+= nPdesdep
			aOOpeOut[1,15]+= nPresfin
			// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
			aOOpeOut[1,16]+= nVPrzMd1
			aOOpeOut[1,17]+= nVPrzMd2
			// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
			aOOpeOut[1,18]+= nPdescon
			
			If MV_PAR06 # 1
				
				nPos2 := 0
				nPos2 := aScan(aGrpPag,{|x| x[1] == SF2->F2_COND })
				//If nPos2 == 0
				//	DbSelectArea( "SE4" )
				//	DbSetOrder(1)
				//	DbSeek( xFilial("SE4") + SF2->F2_COND )
				//	// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
				//	if SFT->FT_VALICM > 0
				//		aAdd(aGrpPag,{ SF2->F2_COND , SE4->E4_DESCRI , nPvalvda , (SF2->F2_VALICM + (nPvalpis) + (nPvalcof)) , SF2->F2_VALICM , 0 , (nPvalvda * nPis) , (nPvalvda * nCofins) , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
				//	Else
				//		aAdd(aGrpPag,{ SF2->F2_COND , SE4->E4_DESCRI , nPvalvda , ((nPvalpis) + (nPvalcof)) , 0 , 0 , (nPvalvda * nPis) , (nPvalvda * nCofins) , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
				//	Endif
				//Else
					aGrpPag[nPos2,3] += nPvalvda
					if SFT->FT_VALICM > 0
						aGrpPag[nPos2,4] += (SF2->F2_VALICM + (nPvalpis) + (nPvalcof))
						aGrpPag[nPos2,5] += SF2->F2_VALICM
					Else
						aGrpPag[nPos2,4] += ((nPvalpis) + (nPvalcof))
						//					 	aGrpPag[nPos2,5] += SF2->F2_VALICM
					Endif
					aGrpPag[nPos2,7] += (nPvalpis)
					aGrpPag[nPos2,8] += (nPvalcof)
					aGrpPag[nPos2,9] += nPcustot
					aGrpPag[nPos2,10]+= nPjurest
					aGrpPag[nPos2,11]+= nPlucbru
					aGrpPag[nPos2,12]+= nPdesvar
					aGrpPag[nPos2,13]+= nPcomven
					aGrpPag[nPos2,14]+= nPlucliq
					aGrpPag[nPos2,15]+= nPdesfix
					aGrpPag[nPos2,16]+= nPdesdep
					aGrpPag[nPos2,17]+= nPresfin
					// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
					aGrpPag[nPos2,18]+= nVPrzMd1
					aGrpPag[nPos2,19]+= nVPrzMd2
					// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
					aGrpPag[nPos2,20]+= nPdescon
				//EndIf
				
				DbSelectArea( "VAI" )
				DbSetOrder(6)
				DbSeek( xFilial("VAI") + SF2->F2_VEND1 )
				
				nPos2 := 0
				If MV_PAR06 # 3
					nPos2 := aScan(aTotPag,{|x| x[1]+x[2] == SF2->F2_COND + Iif(lDuplic,"E","I")+SF2->F2_VEND1 })
				Else
					nPos2 := aScan(aTotPag,{|x| x[1]+x[2] == SF2->F2_COND + Iif(lDuplic,"E","I")+VAI->VAI_CC })
				EndIf
				
				If nPos2 == 0 .or. MV_PAR06 == 4
					//If MV_PAR06 # 3
						DbSelectArea( "SA3" )
						DbSetOrder(1)
						DbSeek( xFilial("SA3") + VAI->VAI_CODVEN )
						// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
						if SFT->FT_VALICM > 0
							aAdd(aTotPag,{ SF2->F2_COND , Iif(lDuplic,"E","I")+SF2->F2_VEND1 , left(SA3->A3_NOME,17) , nPvalvda , (SF2->F2_VALICM + (nPvalvda * nPis) + (nPvalvda * nCofins)) , SF2->F2_VALICM , 0 , (nPvalvda * nPis) , (nPvalvda * nCofins) , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
						Else
							aAdd(aTotPag,{ SF2->F2_COND , Iif(lDuplic,"E","I")+SF2->F2_VEND1 , left(SA3->A3_NOME,17) , nPvalvda , ((nPvalvda * nPis) + (nPvalvda * nCofins)) , 0 , 0 , (nPvalvda * nPis) , (nPvalvda * nCofins) , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
						Endif
						nPos3 := 0
						nPos3 := aScan(aCCVend,{|x| x[1]+x[2] == Iif(lDuplic,"E","I")+VAI->VAI_CC + SF2->F2_VEND1 })
						//If nPos3 == 0
						//	DbSelectArea( "SI3" )
						//	DbSetOrder(1)
						//	DbSeek( xFilial("SI3") + VAI->VAI_CC )
						//	// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
						//	if SFT->FT_VALICM > 0
						//		aAdd(aCCVend,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , SF2->F2_VEND1 , left(SA3->A3_NOME,17) , nPvalvda , (SF2->F2_VALICM + (nPvalvda * nPis) + (nPvalvda * nCofins)) , SF2->F2_VALICM , 0 , (nPvalvda * nPis) , (nPvalvda * nCofins) , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin , Iif(lDuplic,"Ext ","Int ")+left(SI3->I3_DESC,21), nVPrzMd1, nVPrzMd2, nPDescon })
						//	Else
						//		aAdd(aCCVend,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , SF2->F2_VEND1 , left(SA3->A3_NOME,17) , nPvalvda , ((nPvalvda * nPis) + (nPvalvda * nCofins)) , 0 , 0 , (nPvalvda * nPis) , (nPvalvda * nCofins) , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin , Iif(lDuplic,"Ext ","Int ")+left(SI3->I3_DESC,21), nVPrzMd1, nVPrzMd2, nPDescon })
						//	Endif
						//Else
							aCCVend[nPos3,4]  += nPvalvda
							if SFT->FT_VALICM > 0
								aCCVend[nPos3,5]  += (SF2->F2_VALICM + (nPvalpis) + (nPvalcof))
								aCCVend[nPos3,6]  += SF2->F2_VALICM
							Else
								aCCVend[nPos3,5]  += ((nPvalpis) + (nPvalcof))
								//							 	aCCVend[nPos3,6]  += SF2->F2_VALICM
							Endif
							aCCVend[nPos3,8]  += (nPvalpis)
							aCCVend[nPos3,9]  += (nPvalcof)
							aCCVend[nPos3,10] += nPcustot
							aCCVend[nPos3,11] += nPjurest
							aCCVend[nPos3,12] += nPlucbru
							aCCVend[nPos3,13] += nPdesvar
							aCCVend[nPos3,14] += nPcomven
							aCCVend[nPos3,15] += nPlucliq
							aCCVend[nPos3,16] += nPdesfix
							aCCVend[nPos3,17] += nPdesdep
							aCCVend[nPos3,18] += nPresfin
							// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
							aCCVend[nPos3,20] += nVPrzMd1
							aCCVend[nPos3,21] += nVPrzMd2
							// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
							aCCVend[nPos3,22] += nPdescon
						//EndIf
						
						nPos3 := 0
						nPos3 := aScan(aTotCCV,{|x| x[1] == Iif(lDuplic,"E","I")+VAI->VAI_CC })
						//If nPos3 == 0
						//	// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
						//	if SFT->FT_VALICM > 0
						//		aAdd(aTotCCV,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , nPvalvda , (SF2->F2_VALICM + (nPvalpis) + (nPvalcof)) , SF2->F2_VALICM , 0 , (nPvalvda * nPis) , (nPvalvda * nCofins) , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
						//	Else
						//		aAdd(aTotCCV,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , nPvalvda , ( (nPvalpis) + (nPvalcof)) , 0 , 0 , (nPvalvda * nPis) , (nPvalvda * nCofins) , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
						//	Endif
						//Else
							aTotCCV[nPos3,2]  += nPvalvda
							if SFT->FT_VALICM > 0
								aTotCCV[nPos3,3]  += (SF2->F2_VALICM + (nPvalpis) + (nPvalcof))
								aTotCCV[nPos3,4]  += SF2->F2_VALICM
							Else
								aTotCCV[nPos3,3]  += ((nPvalpis) + (nPvalcof))
								//							 	aTotCCV[nPos3,4]  += SF2->F2_VALICM
							Endif
							aTotCCV[nPos3,6]  += (nPvalpis)
							aTotCCV[nPos3,7]  += (nPvalcof)
							aTotCCV[nPos3,8]  += nPcustot
							aTotCCV[nPos3,9]  += nPjurest
							aTotCCV[nPos3,10] += nPlucbru
							aTotCCV[nPos3,11] += nPdesvar
							aTotCCV[nPos3,12] += nPcomven
							aTotCCV[nPos3,13] += nPlucliq
							aTotCCV[nPos3,14] += nPdesfix
							aTotCCV[nPos3,15] += nPdesdep
							aTotCCV[nPos3,16] += nPresfin
							// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
							aTotCCV[nPos3,17] += nVPrzMd1
							aTotCCV[nPos3,18] += nVPrzMd2
							// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
							aTotCCV[nPos3,19] += nPdescon
						//EndIf
						
					//Else
					//	DbSelectArea( "SI3" )
					//	DbSetOrder(1)
					//	DbSeek( xFilial("SI3") + VAI->VAI_CC )
					//	// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
					//	if SFT->FT_VALICM > 0
					//		aAdd(aTotPag,{ SF2->F2_COND , Iif(lDuplic,"E","I")+VAI->VAI_CC , left(SI3->I3_DESC,14) , nPvalvda , (SF2->F2_VALICM + (nPvalpis) + (nPvalcof)) , SF2->F2_VALICM , 0 , (nPvalvda * nPis) , (nPvalvda * nCofins) , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
					//	Else
					//		aAdd(aTotPag,{ SF2->F2_COND , Iif(lDuplic,"E","I")+VAI->VAI_CC , left(SI3->I3_DESC,14) , nPvalvda , ((nPvalpis) + (nPvalcof)) , 0 , 0 , (nPvalvda * nPis) , (nPvalvda * nCofins) , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
					//	Endif
					//EndIf
				Else
					aTotPag[nPos2,4] += nPvalvda
					if SFT->FT_VALICM > 0
						aTotPag[nPos2,5] += (SF2->F2_VALICM + (nPvalpis) + (nPvalcof))
						aTotPag[nPos2,6] += SF2->F2_VALICM
					Else
						aTotPag[nPos2,5] += ((nPvalpis) + (nPvalcof))
						//					 	aTotPag[nPos2,6] += SF2->F2_VALICM
					Endif
					aTotPag[nPos2,8] += (nPvalpis)
					aTotPag[nPos2,9] += (nPvalcof)
					aTotPag[nPos2,10]+= nPcustot
					aTotPag[nPos2,11]+= nPjurest
					aTotPag[nPos2,12]+= nPlucbru
					aTotPag[nPos2,13]+= nPdesvar
					aTotPag[nPos2,14]+= nPcomven
					aTotPag[nPos2,15]+= nPlucliq
					aTotPag[nPos2,16]+= nPdesfix
					aTotPag[nPos2,17]+= nPdesdep
					aTotPag[nPos2,18]+= nPresfin
					// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
					aTotPag[nPos2,19]+= nVPrzMd1
					aTotPag[nPos2,20]+= nVPrzMd2
					// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
					aTotPag[nPos2,21]+= nPdescon
				EndIf
				
			EndIf
			
			dbSelectArea(cAliasVEC)
			(cAliasVEC)->(Dbskip())
			Loop
			
		EndIf
		
	EndIf
	
	If ((cAliasVEC)->VEC_BALOFI == "B" .and. Alltrim(SF4->F4_ATUATF) == "S")    //  A T I V O   I M O B I L I Z A D O
		
		aTotAtiMob[1,3] += nPvalvda
		aTotAtiMob[1,8] += nPcustot
		aTotAtiMob[3,3] += nPvalvda
		aTotAtiMob[3,8] += nPcustot
		
		DbSelectArea( "SBM" )
		DbSetOrder(1)
		DbSeek( xFilial("SBM") + (cAliasVEC)->VEC_GRUITE , .f. )
		aAdd(aNumAtiMob,{ "O" , (cAliasVEC)->VEC_GRUITE + " " + SBM->BM_DESC , nPvalvda , 0 , 0 , 0 , 0 , nPcustot })
		
	Else
		
		If VOI->VOI_SITTPO # "3"
			If (cAliasVEC)->VEC_BALOFI == "B"
				If SD2->D2_VALISS > 0
					dbSelectArea(cAliasVEC)
					(cAliasVEC)->(Dbskip())
					Loop
				EndIf
				If SF4->F4_DUPLIC == "N" .and. SF4->F4_OPEMOV <> "05"
					dbSelectArea(cAliasVEC)
					(cAliasVEC)->(Dbskip())
					Loop
				EndIf
				nPos := 1
			Else // (cAliasVEC)->VEC_BALOFI == "O"
				nPos := 2
			EndIf
			aGrpPBO[nPos,2]  += nPvalvda
			aGrpPBO[nPos,3]  += nPtotimp
			aGrpPBO[nPos,4]  += nPvalicm
			aGrpPBO[nPos,5]  += nPvalpis
			aGrpPBO[nPos,6]  += nPvalcof
			aGrpPBO[nPos,7]  += nPcustot
			aGrpPBO[nPos,8]  += nPjurest
			aGrpPBO[nPos,9]  += nPlucbru
			aGrpPBO[nPos,10] += nPdesvar
			aGrpPBO[nPos,11] += nPcomven
			aGrpPBO[nPos,12] += nPlucliq
			aGrpPBO[nPos,13] += nPdesfix
			aGrpPBO[nPos,14] += nPdesdep
			aGrpPBO[nPos,15] += nPresfin
			// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
			aGrpPBO[nPos,16] += nVPrzMd1
			aGrpPBO[nPos,17] += nVPrzMd2
			// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
			aGrpPBO[nPos,18] += nPdescon
		EndIf
		
		If (cAliasVEC)->VEC_BALOFI == "O"
			cGrupo := VOI->VOI_SITTPO
			nPos := 0
			nPos := aScan(aDpto,{|x| x[1]+x[17]+x[18] == cDpto+"O"+cGrupo })
			If nPos == 0
				DbSelectArea( "SX5" )
				DbSetOrder(1)
				DbSeek( xFilial("SX5") + "99" + cDpto )
				// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
				aAdd(aDpto,{ cDpto , nPvalvda , nPtotimp , nPvalicm , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin , left(Alltrim(SX5->X5_DESCRI)+repl(".",21),21) , "O" , cGrupo, nVPrzMd1, nVPrzMd2, nPdescon })
			Else
				aDpto[nPos,2]  += nPvalvda
				aDpto[nPos,3]  += nPtotimp
				aDpto[nPos,4]  += nPvalicm
				aDpto[nPos,5]  += nPvalpis
				aDpto[nPos,6]  += nPvalcof
				aDpto[nPos,7]  += nPcustot
				aDpto[nPos,8]  += nPjurest
				aDpto[nPos,9]  += nPlucbru
				aDpto[nPos,10] += nPdesvar
				aDpto[nPos,11] += nPcomven
				aDpto[nPos,12] += nPlucliq
				aDpto[nPos,13] += nPdesfix
				aDpto[nPos,14] += nPdesdep
				aDpto[nPos,15] += nPresfin
				// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
				aDpto[nPos,19] += nVPrzMd1
				aDpto[nPos,20] += nVPrzMd2
				// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
				aDpto[nPos,21] += nPdescon
			EndIf
		Else
			cGrupo := "9"
			nPos := 0
			nPos := aScan(aDpto,{|x| x[1]+x[17]+x[18] == cDpto+"B"+cGrupo })
			If nPos == 0
				DbSelectArea( "SX5" )
				DbSetOrder(1)
				DbSeek( xFilial("SX5") + "99" + cDpto )
				// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
				aAdd(aDpto,{ cDpto , nPvalvda , nPtotimp , nPvalicm , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin , left(Alltrim(SX5->X5_DESCRI)+repl(".",21),21) , "B" , cGrupo, nVPrzMd1, nVPrzMd2, nPdescon })
			Else
				aDpto[nPos,2]  += nPvalvda
				aDpto[nPos,3]  += nPtotimp
				aDpto[nPos,4]  += nPvalicm
				aDpto[nPos,5]  += nPvalpis
				aDpto[nPos,6]  += nPvalcof
				aDpto[nPos,7]  += nPcustot
				aDpto[nPos,8]  += nPjurest
				aDpto[nPos,9]  += nPlucbru
				aDpto[nPos,10] += nPdesvar
				aDpto[nPos,11] += nPcomven
				aDpto[nPos,12] += nPlucliq
				aDpto[nPos,13] += nPdesfix
				aDpto[nPos,14] += nPdesdep
				aDpto[nPos,15] += nPresfin
				// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
				aDpto[nPos,19] += nVPrzMd1
				aDpto[nPos,20] += nVPrzMd2
				// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
				aDpto[nPos,21] += nPdescon
			EndIf
		EndIf
		
		nPos := 0
		If ( MV_PAR05 == 1 .or. ( MV_PAR05 == 2 .and. MV_PAR04 # 3 .and. MV_PAR04 # 4 ))
			nPos := aScan(aNumPec,{|x| x[1] + x[2] + x[18] + x[19] == (cAliasVEC)->VEC_BALOFI + (cAliasVEC)->VEC_GRUITE + cGrupo + cDpto })
		Else
			nPos := aScan(aNumPec,{|x| x[1] + x[2] + x[18] + x[19] == (cAliasVEC)->VEC_BALOFI + SF2->F2_CLIENTE + cGrupo + cDpto })
		EndIf
		If nPos == 0
			If ( MV_PAR05 == 1 .or. ( MV_PAR05 == 2 .and. MV_PAR04 # 3 .and. MV_PAR04 # 4 ))
				DbSelectArea( "SBM" )
				DbSetOrder(1)
				DbSeek( xFilial("SBM") + (cAliasVEC)->VEC_GRUITE , .f. )
				// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
				aAdd(aNumPec,{ (cAliasVEC)->VEC_BALOFI , (cAliasVEC)->VEC_GRUITE , SBM->BM_DESC , nPvalvda , nPtotimp , nPvalicm , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin , cGrupo , cDpto, nVPrzMd1, nVPrzMd2, nPdescon  })
			Else
				DbSelectArea( "SA1" )
				DbSetOrder(1)
				DbSeek( xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA , .f. )
				// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
				aAdd(aNumPec,{ (cAliasVEC)->VEC_BALOFI , SF2->F2_CLIENTE , left(SA1->A1_NOME,20) , nPvalvda , nPtotimp , nPvalicm , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin , cGrupo , cDpto, nVPrzMd1, nVPrzMd2, nPdescon })
			EndIf
		Else
			aNumPec[nPos,4]  += nPvalvda
			aNumPec[nPos,5]  += nPtotimp
			aNumPec[nPos,6]  += nPvalicm
			aNumPec[nPos,7]  += nPvalpis
			aNumPec[nPos,8]  += nPvalcof
			aNumPec[nPos,9]  += nPcustot
			aNumPec[nPos,10] += nPjurest
			aNumPec[nPos,11] += nPlucbru
			aNumPec[nPos,12] += nPdesvar
			aNumPec[nPos,13] += nPcomven
			aNumPec[nPos,14] += nPlucliq
			aNumPec[nPos,15] += nPdesfix
			aNumPec[nPos,16] += nPdesdep
			aNumPec[nPos,17] += nPresfin
			// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
			aNumPec[nPos,20] += nVPrzMd1
			aNumPec[nPos,21] += nVPrzMd2
			// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
			aNumPec[nPos,22] += nPdescon
		EndIf
		
		nPos := 0
		nPos := aScan(aGrpPec,{|x| x[1]+x[16] == (cAliasVEC)->VEC_BALOFI + cGrupo })
		If nPos == 0
			// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
			aAdd(aGrpPec,{ (cAliasVEC)->VEC_BALOFI , nPvalvda , nPtotimp , nPvalicm , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin , cGrupo, nVPrzMd1, nVPrzMd2, nPdescon })
		Else
			aGrpPec[nPos,2]  += nPvalvda
			aGrpPec[nPos,3]  += nPtotimp
			aGrpPec[nPos,4]  += nPvalicm
			aGrpPec[nPos,5]  += nPvalpis
			aGrpPec[nPos,6]  += nPvalcof
			aGrpPec[nPos,7]  += nPcustot
			aGrpPec[nPos,8]  += nPjurest
			aGrpPec[nPos,9]  += nPlucbru
			aGrpPec[nPos,10] += nPdesvar
			aGrpPec[nPos,11] += nPcomven
			aGrpPec[nPos,12] += nPlucliq
			aGrpPec[nPos,13] += nPdesfix
			aGrpPec[nPos,14] += nPdesdep
			aGrpPec[nPos,15] += nPresfin
			// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
			aGrpPec[nPos,17] += nVPrzMd1
			aGrpPec[nPos,18] += nVPrzMd2
			// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
			aGrpPec[nPos,19] += nPdescon
		EndIf
		
		If VOI->VOI_SITTPO # "3"
			
			aTotPec[1,1]  += nPvalvda
			aTotPec[1,2]  += nPtotimp
			aTotPec[1,3]  += nPvalicm
			aTotPec[1,4]  += nPvalpis
			aTotPec[1,5]  += nPvalcof
			aTotPec[1,6]  += nPcustot
			aTotPec[1,7]  += nPjurest
			aTotPec[1,8]  += nPlucbru
			aTotPec[1,9]  += nPdesvar
			aTotPec[1,10] += nPcomven
			aTotPec[1,11] += nPlucliq
			aTotPec[1,12] += nPdesfix
			aTotPec[1,13] += nPdesdep
			aTotPec[1,14] += nPresfin
			// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
			aTotPec[1,15] += nVPrzMd1
			aTotPec[1,16] += nVPrzMd2
			// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
			aTotPec[1,17] += nPdescon
			
			aTotal[1,1]  += nPvalvda
			aTotal[1,2]  += nPtotimp
			aTotal[1,3]  += nPvalicm
			aTotal[1,5]  += nPvalpis
			aTotal[1,6]  += nPvalcof
			aTotal[1,7]  += nPcustot
			aTotal[1,8]  += nPjurest
			aTotal[1,9]  += nPlucbru
			aTotal[1,10] += nPdesvar
			aTotal[1,11] += nPcomven
			aTotal[1,12] += nPlucliq
			aTotal[1,13] += nPdesfix
			aTotal[1,14] += nPdesdep
			aTotal[1,15] += nPresfin
			// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
			aTotal[1,16] += nVPrzMd1
			aTotal[1,17] += nVPrzMd2
			// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
			aTotal[1,18] += nPdescon
			
		EndIf
		
		If MV_PAR06 # 1
			
			If VOI->VOI_SITTPO # "3"
				aTotCon[1,1]  += nPvalvda
				aTotCon[1,2]  += nPtotimp
				aTotCon[1,3]  += nPvalicm
				aTotCon[1,5]  += nPvalpis
				aTotCon[1,6]  += nPvalcof
				aTotCon[1,7]  += nPcustot
				aTotCon[1,8]  += nPjurest
				aTotCon[1,9]  += nPlucbru
				aTotCon[1,10] += nPdesvar
				aTotCon[1,11] += nPcomven
				aTotCon[1,12] += nPlucliq
				aTotCon[1,13] += nPdesfix
				aTotCon[1,14] += nPdesdep
				aTotCon[1,15] += nPresfin
				// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
				aTotCon[1,16] += nVPrzMd1
				aTotCon[1,17] += nVPrzMd2
				// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
				aTotCon[1,18] += nPdescon
			EndIf
			
			If MV_PAR06 # 2 .and. MV_PAR06 # 4
				DbSelectArea( "VAI" )
				DbSetOrder(6)
				DbSeek( xFilial("VAI") + SF2->F2_VEND1 )
			EndIf
			
			nPos := 0
			If (cAliasVEC)->VEC_BALOFI == "B"
				nPos := aScan(aPecSrvOfi,{|x| x[1]+x[2]+x[4] == SF2->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,SF2->F2_VEND1,VAI->VAI_CC) + Iif(lDuplic,"Ext ","Int ")+left(STR0065,18) })
				If nPos == 0
					DbSelectArea( "SA1" )
					DbSetOrder(1)
					DbSeek( xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA )
					aAdd(aPecSrvOfi,{ SF2->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,SF2->F2_VEND1,VAI->VAI_CC) , nPvalvda , Iif(lDuplic,"Ext ","Int ")+left(STR0065,18) })
				Else
					aPecSrvOfi[nPos,3] += nPvalvda
				EndIf
				nPos := aScan(aConPagNF,{|x| x[1]+x[2]+x[3]+x[4]+x[7] == SF2->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,SF2->F2_VEND1,VAI->VAI_CC) + (cAliasVEC)->VEC_NUMNFI + (cAliasVEC)->VEC_SERNFI + Iif(lDuplic,"Ext ","Int ")+left(STR0065,18) })
			Else // (cAliasVEC)->VEC_BALOFI == "O"
				nPos := aScan(aPecSrvOfi,{|x| x[1]+x[2]+x[4] == SF2->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,SF2->F2_VEND1,VAI->VAI_CC) + Iif(lDuplic,"Ext ","Int ")+left(STR0064,18) })
				If nPos == 0
					DbSelectArea( "SA1" )
					DbSetOrder(1)
					DbSeek( xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA )
					aAdd(aPecSrvOfi,{ SF2->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,SF2->F2_VEND1,VAI->VAI_CC) , nPvalvda , Iif(lDuplic,"Ext ","Int ")+left(STR0064,18) })
				Else
					aPecSrvOfi[nPos,3] += nPvalvda
				EndIf
				nPos := aScan(aConPagNF,{|x| x[1]+x[2]+x[3]+x[4]+x[7] == SF2->F2_COND + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,SF2->F2_VEND1,VAI->VAI_CC) + (cAliasVEC)->VEC_NUMNFI + (cAliasVEC)->VEC_SERNFI + Iif(lDuplic,"Ext ","Int ")+left(STR0064,18) })
			EndIf
			If nPos == 0
				DbSelectArea( "SA1" )
				DbSetOrder(1)
				DbSeek( xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA )
				If (cAliasVEC)->VEC_BALOFI == "B"
					aAdd(aConPagNF,{ SF2->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,SF2->F2_VEND1,VAI->VAI_CC) , (cAliasVEC)->VEC_NUMNFI , (cAliasVEC)->VEC_SERNFI , left(SA1->A1_NOME,10) , nPvalvda , Iif(lDuplic,"Ext ","Int ")+left(STR0065,18) })
				Else // (cAliasVEC)->VEC_BALOFI == "O"
					aAdd(aConPagNF,{ SF2->F2_COND , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,SF2->F2_VEND1,VAI->VAI_CC) , (cAliasVEC)->VEC_NUMNFI , (cAliasVEC)->VEC_SERNFI , left(SA1->A1_NOME,10) , nPvalvda , Iif(lDuplic,"Exp ","Int ")+left(STR0064,18) })
				EndIf
			Else
				aConPagNF[nPos,6] += nPvalvda
			EndIf
			
			nPos := 0
			nPos := aScan(aGrpPag,{|x| x[1] == SF2->F2_COND })
			If nPos == 0
				DbSelectArea( "SE4" )
				DbSetOrder(1)
				DbSeek( xFilial("SE4") + SF2->F2_COND )
				// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
				aAdd(aGrpPag,{ SF2->F2_COND , SE4->E4_DESCRI , nPvalvda , nPtotimp , nPvalicm , 0 , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
			Else
				aGrpPag[nPos,3]  += nPvalvda
				aGrpPag[nPos,4]  += nPtotimp
				aGrpPag[nPos,5]  += nPvalicm
				aGrpPag[nPos,7]  += nPvalpis
				aGrpPag[nPos,8]  += nPvalcof
				aGrpPag[nPos,9]  += nPcustot
				aGrpPag[nPos,10] += nPjurest
				aGrpPag[nPos,11] += nPlucbru
				aGrpPag[nPos,12] += nPdesvar
				aGrpPag[nPos,13] += nPcomven
				aGrpPag[nPos,14] += nPlucliq
				aGrpPag[nPos,15] += nPdesfix
				aGrpPag[nPos,16] += nPdesdep
				aGrpPag[nPos,17] += nPresfin
				// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
				aGrpPag[nPos,18] += nVPrzMd1
				aGrpPag[nPos,19] += nVPrzMd2
				// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
				aGrpPag[nPos,20] += nPdescon
			EndIf
			
			DbSelectArea( "VAI" )
			DbSetOrder(6)
			DbSeek( xFilial("VAI") + SF2->F2_VEND1 )
			
			nPos := 0
			If MV_PAR06 # 3
				nPos := aScan(aTotPag,{|x| x[1]+x[2] == SF2->F2_COND + Iif(lDuplic,"E","I")+SF2->F2_VEND1 })
			Else
				nPos := aScan(aTotPag,{|x| x[1]+x[2] == SF2->F2_COND + Iif(lDuplic,"E","I")+VAI->VAI_CC })
			EndIf
			
			If nPos == 0 .or. MV_PAR06 == 4
				If MV_PAR06 # 3
					DbSelectArea( "SA3" )
					DbSetOrder(1)
					DbSeek( xFilial("SA3") + VAI->VAI_CODVEN )
					// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
					aAdd(aTotPag,{ SF2->F2_COND , Iif(lDuplic,"E","I")+SF2->F2_VEND1 , left(SA3->A3_NOME,17) , nPvalvda , nPtotimp , nPvalicm , 0 , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
					
					nPos3 := 0
					nPos3 := aScan(aCCVend,{|x| x[1]+x[2] == Iif(lDuplic,"E","I")+VAI->VAI_CC + SF2->F2_VEND1 })
					If nPos3 == 0
						DbSelectArea( "SI3" )
						DbSetOrder(1)
						DbSeek( xFilial("SI3") + VAI->VAI_CC )
						// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
						aAdd(aCCVend,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , SF2->F2_VEND1 , left(SA3->A3_NOME,17) , nPvalvda , nPtotimp , nPvalicm , 0 , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin , Iif(lDuplic,"Ext ","Int ")+left(SI3->I3_DESC,21), nVPrzMd1, nVPrzMd2, nPdescon })
					Else
						aCCVend[nPos3,4]  += nPvalvda
						aCCVend[nPos3,5]  += nPtotimp
						aCCVend[nPos3,6]  += nPvalicm
						aCCVend[nPos3,8]  += nPvalpis
						aCCVend[nPos3,9]  += nPvalcof
						aCCVend[nPos3,10] += nPcustot
						aCCVend[nPos3,11] += nPjurest
						aCCVend[nPos3,12] += nPlucbru
						aCCVend[nPos3,13] += nPdesvar
						aCCVend[nPos3,14] += nPcomven
						aCCVend[nPos3,15] += nPlucliq
						aCCVend[nPos3,16] += nPdesfix
						aCCVend[nPos3,17] += nPdesdep
						aCCVend[nPos3,18] += nPresfin
						// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
						aCCVend[nPos3,20] += nVPrzMd1
						aCCVend[nPos3,21] += nVPrzMd2
						// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
						aCCVend[nPos3,21] += nPdescon
					EndIf
					
					nPos3 := 0
					nPos3 := aScan(aTotCCV,{|x| x[1] == Iif(lDuplic,"E","I")+VAI->VAI_CC })
					If nPos3 == 0
						// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
						aAdd(aTotCCV,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , nPvalvda , nPtotimp , nPvalicm , 0 , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
					Else
						aTotCCV[nPos3,2]  += nPvalvda
						aTotCCV[nPos3,3]  += nPtotimp
						aTotCCV[nPos3,4]  += nPvalicm
						aTotCCV[nPos3,6]  += nPvalpis
						aTotCCV[nPos3,7]  += nPvalcof
						aTotCCV[nPos3,8]  += nPcustot
						aTotCCV[nPos3,9]  += nPjurest
						aTotCCV[nPos3,10] += nPlucbru
						aTotCCV[nPos3,11] += nPdesvar
						aTotCCV[nPos3,12] += nPcomven
						aTotCCV[nPos3,13] += nPlucliq
						aTotCCV[nPos3,14] += nPdesfix
						aTotCCV[nPos3,15] += nPdesdep
						aTotCCV[nPos3,16] += nPresfin
						// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
						aTotCCV[nPos3,17] += nVPrzMd1
						aTotCCV[nPos3,18] += nVPrzMd2
						// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
						aTotCCV[nPos3,19] += nPdescon
					EndIf
				Else
					DbSelectArea( "SI3" )
					DbSetOrder(1)
					DbSeek( xFilial("SI3") + VAI->VAI_CC )
					// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
					aAdd(aTotPag,{ SF2->F2_COND , Iif(lDuplic,"E","I")+VAI->VAI_CC , left(SI3->I3_DESC,14) , nPvalvda , nPtotimp , nPvalicm , 0 , nPvalpis , nPvalcof , nPcustot , nPjurest , nPlucbru , nPdesvar , nPcomven , nPlucliq , nPdesfix , nPdesdep , nPresfin, nVPrzMd1, nVPrzMd2, nPdescon })
				EndIf
			Else
				aTotPag[nPos,4]  += nPvalvda
				aTotPag[nPos,5]  += nPtotimp
				aTotPag[nPos,6]  += nPvalicm
				aTotPag[nPos,8]  += nPvalpis
				aTotPag[nPos,9]  += nPvalcof
				aTotPag[nPos,10]  += nPcustot
				aTotPag[nPos,11] += nPjurest
				aTotPag[nPos,12] += nPlucbru
				aTotPag[nPos,13] += nPdesvar
				aTotPag[nPos,14] += nPcomven
				aTotPag[nPos,15] += nPlucliq
				aTotPag[nPos,16] += nPdesfix
				aTotPag[nPos,17] += nPdesdep
				aTotPag[nPos,18] += nPresfin
				// Manoel - 14/03/2005 - Inserir aqui, levantamento do Prazo medio
				aTotPag[nPos,19] += nVPrzMd1
				aTotPag[nPos,20] += nVPrzMd2
				// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
				aTotPag[nPos,21] += nPdescon
			EndIf
			
		EndIf
		
	EndIf
	
	dbSelectArea(cAliasVEC)
	(cAliasVEC)->(Dbskip())
EndDo
(cAliasVEC)->(DBCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³FS_M_OR25D³ Autor ³ Andre Luis Almeida    ³ Data ³ 10/04/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Carregando VETOR de Vendas de Servicos                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_M_OR25D()

Local cCliVSC := cLojVSC := cVenVSC := cCPgVSC := ""
Local lDuplic := .f.
// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo Medio
Local nVprzmd1 := nVprzmd2 := 0
// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
Local	nSdescon := 0
Local cAliasVSC := "SQLVSC"

///////////////////////////////////
//    S  E  R  V  I  C  O  S     //
///////////////////////////////////

If FunName() == "OFIOR250"
	IncRegua()
EndIf

//cQuery := "SELECT VSC.VSC_DATVEN,VSC.VSC_TIPTEM,VSC.VSC_RECVO4,VSC.VSC_NUMNFI,VSC.VSC_SERNFI,VSC.VSC_VALSER,VSC.VSC_VMFSER,VSC.VSC_VALISS,VSC.VSC_VMFISS,VSC.VSC_VALPIS,VSC.VSC_VMFPIS,VSC.VSC_VALCOF,VSC.VSC_VMFCOF,VSC.VSC_TOTIMP "
//cQuery := "VSC.VSC_TMFIMP,VSC.VSC_CMFSER,VSC.VSC_RECVO4,VSC.VSC_NUMNFI,VSC.VSC_SERNFI,VSC.VSC_VALSER,VSC.VSC_VMFSER,VSC.VSC_VALISS,VSC.VSC_VMFISS,VSC.VSC_VALPIS,VSC.VSC_VMFPIS,VSC.VSC_VALCOF,VSC.VSC_VMFCOF,VSC.VSC_TOTIMP "
cQuery := "SELECT * "
cQuery += "FROM "
cQuery += RetSqlName( "VSC" ) + " VSC "
cQuery += "WHERE "
cQuery += "VSC.VSC_FILIAL='"+ xFilial("VSC")+ "' AND VSC.VSC_DATVEN >= '"+dtos(mv_par01)+"' AND VSC.VSC_DATVEN <= '"+dtos(mv_par02)+"' AND "
cQuery += "VSC.D_E_L_E_T_=' '
//ORDER BY VEC.VEC_NUMNFI,VEC.VEC_SERNFI,VEC.VEC_GRUITE,VEC.VEC_CODITE "

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVSC, .T., .T. )

aAdd(aTotSrv,{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 0, 0, 0 })
While !((cAliasVSC)->(Eof()))
	
	If FunName() == "OFIOR250"
		nCont ++
		If nCont == 400
			IncRegua()
			nCont := 2
			If lAbortPrint
				nLin++
				@nLin++,30 PSAY STR0058 //"* * *  C A N C E L A D O   P E L O   O P E R A D O R  * * *"
				Exit
			EndIf
		EndIf
	EndIf
	If (!Empty(MV_PAR01) .and. (stod((cAliasVSC)->VSC_DATVEN) < MV_PAR01))
		dbSelectArea(cAliasVSC)
		(cAliasVSC)->(Dbskip())
		loop
	EndIf
	DbSelectArea( "VOI" )
	DbSetOrder(1)
	DbSeek( xFilial("VOI") + (cAliasVSC)->VSC_TIPTEM , .f. )
	DbSelectArea( "SF2" )
	DbSetOrder(1)
	nVprzmd1 := nVprzmd2 := 0
	lDuplic := .t.
	VO4->(DbGoTo(Val((cAliasVSC)->VSC_RECVO4)))
	If !DbSeek( xFilial("SF2") + (cAliasVSC)->VSC_NUMNFI + (cAliasVSC)->VSC_SERNFI )
		If VOI->VOI_SITTPO # "3"
			dbSelectArea(cAliasVSC)
			(cAliasVSC)->(Dbskip())
			loop
		Else
			lDuplic := .f.
			nSvalser:= VO4->VO4_VALINT
			DbSelectArea( "VO2" )
			DbSetOrder(2)
			DbSeek( xFilial("VO2") + VO4->VO4_NOSNUM )
			cCliVSC := VO4->VO4_FATPAR
			cLojVSC := VO4->VO4_LOJA
			cVenVSC := VO2->VO2_FUNREQ
			cCPgVSC := "___"
		EndIf
	Else
		If SF2->F2_TIPO # "N"
			dbSelectArea(cAliasVSC)
			(cAliasVSC)->(Dbskip())
			loop
		EndIf
		If VOI->VOI_SITTPO # "3"
			nSvalser:= Iif( MV_PAR03 == 1 , (cAliasVSC)->VSC_VALSER , Iif( MV_PAR03 == 2 , (cAliasVSC)->VSC_VMFSER , xmoeda((cAliasVSC)->VSC_VALSER,1,MV_PAR03,DDataBase)))
		Else
			lDuplic := .f.
			nSvalser:= VO4->VO4_VALINT
		EndIf
		cCliVSC := SF2->F2_CLIENTE
		cLojVSC := SF2->F2_LOJA
		cVenVSC := SF2->F2_VEND1
		cCPgVSC := SF2->F2_COND
		
		// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
		na := ( SF2->F2_BASEISS / SF2->F2_VALBRUT )
		nk := ( (cAliasVSC)->VSC_VALSER / SF2->F2_BASEISS )
		DbSelectArea("SE1")
		DbSetOrder(1)
		DbSeek( xFilial("SE1") + SF2->F2_PREFIXO + SF2->F2_DUPL )
		While !Eof() .and. ( SE1->E1_FILIAL == xFilial("SE1") ) .and. ( ( SF2->F2_PREFIXO + SF2->F2_DUPL ) == ( SE1->E1_PREFIXO + SE1->E1_NUM ) )
			nVprzmd1 += ( ( nk * ( SE1->E1_VALOR * na ) ) * ( SE1->E1_VENCTO - SF2->F2_EMISSAO ) )
			nVprzmd2 += ( nk * ( SE1->E1_VALOR * na )  )
			If Alltrim(SE1->E1_TIPO) == "CD" // CDCI - sem prazo medio
				nVprzmd1 := 0
			EndIf
			DbSelectArea("SE1")
			Dbskip()
		EndDo
		
	EndIf
	nSvaliss := Iif( MV_PAR03 == 1 , (cAliasVSC)->VSC_VALISS , Iif( MV_PAR03 == 2 , (cAliasVSC)->VSC_VMFISS , xmoeda((cAliasVSC)->VSC_VALISS,1,MV_PAR03,DDataBase)))
	nSvalpis := Iif( MV_PAR03 == 1 , (cAliasVSC)->VSC_VALPIS , Iif( MV_PAR03 == 2 , (cAliasVSC)->VSC_VMFPIS , xmoeda((cAliasVSC)->VSC_VALPIS,1,MV_PAR03,DDataBase)))
	nSvalcof := Iif( MV_PAR03 == 1 , (cAliasVSC)->VSC_VALCOF , Iif( MV_PAR03 == 2 , (cAliasVSC)->VSC_VMFCOF , xmoeda((cAliasVSC)->VSC_VALCOF,1,MV_PAR03,DDataBase)))
	nStotimp := Iif( MV_PAR03 == 1 , (cAliasVSC)->VSC_TOTIMP , Iif( MV_PAR03 == 2 , (cAliasVSC)->VSC_TMFIMP , xmoeda(cQuery := (cAliasVSC)->VSC_TOTIMP,1,MV_PAR03,DDataBase)))
	nScusser := Iif( MV_PAR03 == 1 , (cAliasVSC)->VSC_CUSSER , Iif( MV_PAR03 == 2 , (cAliasVSC)->VSC_CMFSER , xmoeda((cAliasVSC)->VSC_CUSSER,1,MV_PAR03,DDataBase)))
	nSlucbru := Iif( MV_PAR03 == 1 , (cAliasVSC)->VSC_LUCBRU , Iif( MV_PAR03 == 2 , (cAliasVSC)->VSC_LMFBRU , xmoeda((cAliasVSC)->VSC_LUCBRU,1,MV_PAR03,DDataBase)))
	nSdesvar := Iif( MV_PAR03 == 1 , (cAliasVSC)->VSC_DESVAR , Iif( MV_PAR03 == 2 , (cAliasVSC)->VSC_DMFVAR , xmoeda((cAliasVSC)->VSC_DESVAR,1,MV_PAR03,DDataBase)))
	nScomven := Iif( MV_PAR03 == 1 , ((cAliasVSC)->VSC_COMVEN+(cAliasVSC)->VSC_COMGER) , Iif( MV_PAR03 == 2 , ((cAliasVSC)->VSC_CMFVEN+(cAliasVSC)->VSC_CMFGER) , xmoeda(((cAliasVSC)->VSC_COMVEN+(cAliasVSC)->VSC_COMGER),1,MV_PAR03,DDataBase)))
	nSlucliq := Iif( MV_PAR03 == 1 , (cAliasVSC)->VSC_LUCLIQ , Iif( MV_PAR03 == 2 , (cAliasVSC)->VSC_LMFLIQ , xmoeda((cAliasVSC)->VSC_LUCLIQ,1,MV_PAR03,DDataBase)))
	nSdesfix := Iif( MV_PAR03 == 1 , ((cAliasVSC)->VSC_DESFIX+(cAliasVSC)->VSC_CUSFIX) , Iif( MV_PAR03 == 2 , ((cAliasVSC)->VSC_DMFFIX+(cAliasVSC)->VSC_CMFFIX) , xmoeda(((cAliasVSC)->VSC_DESFIX+(cAliasVSC)->VSC_CUSFIX),1,MV_PAR03,DDataBase)))
	nSdesadm := Iif( MV_PAR03 == 1 , ((cAliasVSC)->VSC_DESADM+(cAliasVSC)->VSC_DESDEP) , Iif( MV_PAR03 == 2 , ((cAliasVSC)->VSC_DMFADM+(cAliasVSC)->VSC_DMFDEP) , xmoeda(((cAliasVSC)->VSC_DESADM+(cAliasVSC)->VSC_DESDEP),1,MV_PAR03,DDataBase)))
	nSresfin := Iif( MV_PAR03 == 1 , (cAliasVSC)->VSC_RESFIN , Iif( MV_PAR03 == 2 , (cAliasVSC)->VSC_RMFFIN , xmoeda((cAliasVSC)->VSC_RESFIN,1,MV_PAR03,DDataBase)))
	nSdescon := Iif( MV_PAR03 == 1 , (cAliasVSC)->VSC_VALDES , Iif( MV_PAR03 == 2 , (cAliasVSC)->VSC_VMFDES , xmoeda((cAliasVSC)->VSC_VALDES,1,MV_PAR03,DDataBase)))
	
	If !Empty(Alltrim((cAliasVSC)->VSC_NUMNFI+(cAliasVSC)->VSC_SERNFI))
		DbSelectArea( "VOO" )
		DbSetOrder(4)
		DbSeek( xFilial("VOO") + (cAliasVSC)->VSC_NUMNFI + (cAliasVSC)->VSC_SERNFI )
	Else
		DbSelectArea( "VOO" )
		DbSetOrder(1)
		DbSeek( xFilial("VOO") + (cAliasVSC)->VSC_NUMOSV + (cAliasVSC)->VSC_TIPTEM )
	EndIf
	nPos := 0
	nPos := aScan(aDpto,{|x| x[1]+x[17]+x[18] == VOO->VOO_DEPTO+"S"+VOI->VOI_SITTPO })
	If nPos == 0
		DbSelectArea( "SX5" )
		DbSetOrder(1)
		DbSeek( xFilial("SX5") + "99" + VOO->VOO_DEPTO )
		// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
		aAdd(aDpto,{ VOO->VOO_DEPTO , nSvalser , nStotimp , nSvaliss , nSvalpis , nSvalcof , nScusser , nSlucbru , nSdesvar , nScomven , nSlucliq , nSdesfix , nSdesadm , nSresfin , 0 , left(Alltrim(SX5->X5_DESCRI)+repl(".",21),21) , "S" , VOI->VOI_SITTPO, nVPrzMd1, nVPrzMd2, nSdescon })
	Else
		aDpto[nPos,2]  += nSvalser
		aDpto[nPos,3]  += nStotimp
		aDpto[nPos,4]  += nSvaliss
		aDpto[nPos,5]  += nSvalpis
		aDpto[nPos,6]  += nSvalcof
		aDpto[nPos,7]  += nScusser
		aDpto[nPos,8]  += nSlucbru
		aDpto[nPos,9]  += nSdesvar
		aDpto[nPos,10] += nScomven
		aDpto[nPos,11] += nSlucliq
		aDpto[nPos,12] += nSdesfix
		aDpto[nPos,13] += nSdesadm
		aDpto[nPos,14] += nSresfin
		// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
		aDpto[nPos,19] += nVPrzMd1
		aDpto[nPos,20] += nVPrzMd2
		// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
		aDpto[nPos,21] += nSdescon
	EndIf
	
	nPos := 0
	If ( MV_PAR05 == 1 .or. ( MV_PAR05 == 2 .and. MV_PAR04 # 3 .and. MV_PAR04 # 4 ))
		If MV_PAR04 == 4 // Por SECAO
			nPos := aScan(aNumSrv,{|x| x[1] + x[2] + x[17] == VOI->VOI_SITTPO + VO4->VO4_CODSEC + VOO->VOO_DEPTO })
		Else // Por Grupo
			nPos := aScan(aNumSrv,{|x| x[1] + x[2] + x[17] == VOI->VOI_SITTPO + (cAliasVSC)->VSC_TIPSER + VOO->VOO_DEPTO })
		EndIf
	Else
		nPos := aScan(aNumSrv,{|x| x[1] + x[2] + x[17] == VOI->VOI_SITTPO + cCliVSC + VOO->VOO_DEPTO })
	EndIf
	
	If nPos == 0
		If ( MV_PAR05 == 1 .or. ( MV_PAR05 == 2 .and. MV_PAR04 # 3 .and. MV_PAR04 # 4 ))
			If MV_PAR04 == 4 // Por SECAO
				DbSelectArea( "VOD" )
				DbSetOrder(1)
				DbSeek( xFilial("VOD") + VO4->VO4_CODSEC , .f. )
				aAdd(aNumSrv,{ VOI->VOI_SITTPO , VO4->VO4_CODSEC , VOD->VOD_DESSEC , nSvalser , nStotimp , nSvaliss , nSvalpis , nSvalcof , nScusser , nSlucbru , nSdesvar , nScomven , nSlucliq , nSdesfix , nSdesadm , nSresfin , VOO->VOO_DEPTO, nVPrzMd1, nVPrzMd2, nSdescon })
			Else // Por Grupo
				DbSelectArea( "VOK" )
				DbSetOrder(1)
				DbSeek( xFilial("VOK") + (cAliasVSC)->VSC_TIPSER , .f. )
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				aAdd(aNumSrv,{ VOI->VOI_SITTPO , (cAliasVSC)->VSC_TIPSER , VOK->VOK_DESSER , nSvalser , nStotimp , nSvaliss , nSvalpis , nSvalcof , nScusser , nSlucbru , nSdesvar , nScomven , nSlucliq , nSdesfix , nSdesadm , nSresfin , VOO->VOO_DEPTO, nVPrzMd1, nVPrzMd2, nSdescon })
			EndIf
		Else
			DbSelectArea( "SA1" )
			DbSetOrder(1)
			DbSeek( xFilial("SA1") + cCliVSC + cLojVSC , .f. )
			// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
			aAdd(aNumSrv,{ VOI->VOI_SITTPO , cCliVSC , left(SA1->A1_NOME,20) , nSvalser , nStotimp , nSvaliss , nSvalpis , nSvalcof , nScusser , nSlucbru , nSdesvar , nScomven , nSlucliq , nSdesfix , nSdesadm , nSresfin , VOO->VOO_DEPTO, nVPrzMd1, nVPrzMd2, nSdescon })
		EndIf
	Else
		aNumSrv[nPos,4]  += nSvalser
		aNumSrv[nPos,5]  += nStotimp
		aNumSrv[nPos,6]  += nSvaliss
		aNumSrv[nPos,7]  += nSvalpis
		aNumSrv[nPos,8]  += nSvalcof
		aNumSrv[nPos,9]  += nScusser
		aNumSrv[nPos,10] += nSlucbru
		aNumSrv[nPos,11] += nSdesvar
		aNumSrv[nPos,12] += nScomven
		aNumSrv[nPos,13] += nSlucliq
		aNumSrv[nPos,14] += nSdesfix
		aNumSrv[nPos,15] += nSdesadm
		aNumSrv[nPos,16] += nSresfin
		// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
		aNumSrv[nPos,18] += nVPrzMd1
		aNumSrv[nPos,19] += nVPrzMd2
		// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
		aNumSrv[nPos,20] += nSdescon
	EndIf
	
	nPos := 0
	nPos := aScan(aGrpSrv,{|x| x[1] == VOI->VOI_SITTPO })
	If nPos == 0
		// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
		aAdd(aGrpSrv,{ VOI->VOI_SITTPO , nSvalser , nStotimp , nSvaliss , nSvalpis , nSvalcof , nScusser , nSlucbru , nSdesvar , nScomven , nSlucliq , nSdesfix , nSdesadm , nSresfin, nVPrzMd1, nVPrzMd2, nSdescon })
	Else
		aGrpSrv[nPos,2]  += nSvalser
		aGrpSrv[nPos,3]  += nStotimp
		aGrpSrv[nPos,4]  += nSvaliss
		aGrpSrv[nPos,5]  += nSvalpis
		aGrpSrv[nPos,6]  += nSvalcof
		aGrpSrv[nPos,7]  += nScusser
		aGrpSrv[nPos,8]  += nSlucbru
		aGrpSrv[nPos,9]  += nSdesvar
		aGrpSrv[nPos,10] += nScomven
		aGrpSrv[nPos,11] += nSlucliq
		aGrpSrv[nPos,12] += nSdesfix
		aGrpSrv[nPos,13] += nSdesadm
		aGrpSrv[nPos,14] += nSresfin
		// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
		aGrpSrv[nPos,15] += nVPrzMd1
		aGrpSrv[nPos,16] += nVPrzMd2
		// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
		aGrpSrv[nPos,17] += nSdescon
	EndIf
	
	If VOI->VOI_SITTPO # "3"
		
		aTotSrv[1,1]  += nSvalser
		aTotSrv[1,2]  += nStotimp
		aTotSrv[1,3]  += nSvaliss
		aTotSrv[1,4]  += nSvalpis
		aTotSrv[1,5]  += nSvalcof
		aTotSrv[1,6]  += nScusser
		aTotSrv[1,7]  += nSlucbru
		aTotSrv[1,8]  += nSdesvar
		aTotSrv[1,9]  += nScomven
		aTotSrv[1,10] += nSlucliq
		aTotSrv[1,11] += nSdesfix
		aTotSrv[1,12] += nSdesadm
		aTotSrv[1,13] += nSresfin
		// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
		aTotSrv[1,14] += nVPrzMd1
		aTotSrv[1,15] += nVPrzMd2
		// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
		aTotSrv[1,16] += nSdescon
		
		aTotal[1,1]  += nSvalser
		aTotal[1,2]  += nStotimp
		aTotal[1,4]  += nSvaliss
		aTotal[1,5]  += nSvalpis
		aTotal[1,6]  += nSvalcof
		aTotal[1,7]  += nScusser
		aTotal[1,9]  += nSlucbru
		aTotal[1,10] += nSdesvar
		aTotal[1,11] += nScomven
		aTotal[1,12] += nSlucliq
		aTotal[1,13] += nSdesfix
		aTotal[1,14] += nSdesadm
		aTotal[1,15] += nSresfin
		// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
		aTotal[1,16] += nVPrzMd1
		aTotal[1,17] += nVPrzMd2
		// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
		aTotal[1,18] += nSdescon
		
	Endif
	
	If MV_PAR06 # 1
		
		aTotCon[1,1]  += nSvalser
		aTotCon[1,2]  += nStotimp
		aTotCon[1,4]  += nSvaliss
		aTotCon[1,5]  += nSvalpis
		aTotCon[1,6]  += nSvalcof
		aTotCon[1,7]  += nScusser
		aTotCon[1,9]  += nSlucbru
		aTotCon[1,10] += nSdesvar
		aTotCon[1,11] += nScomven
		aTotCon[1,12] += nSlucliq
		aTotCon[1,13] += nSdesfix
		aTotCon[1,14] += nSdesadm
		aTotCon[1,15] += nSresfin
		// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
		aTotCon[1,16] += nVPrzMd1
		aTotCon[1,17] += nVPrzMd2
		// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
		aTotCon[1,18] += nSdescon
		
		nPos := 0
		nPos := aScan(aGrpPag,{|x| x[1] == cCPgVSC })
		If nPos == 0
			DbSelectArea( "SE4" )
			DbSetOrder(1)
			DbSeek( xFilial("SE4") + cCPgVSC )
			// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
			aAdd(aGrpPag,{ cCPgVSC , Iif(!empty(SE4->E4_DESCRI),SE4->E4_DESCRI,STR0028) , nSvalser , nStotimp , 0 , nSvaliss , nSvalpis , nSvalcof , nScusser , 0 , nSlucbru , nSdesvar , nScomven , nSlucliq , nSdesfix , nSdesadm , nSresfin , nVPrzMd1 , nVPrzMd2, nSdescon })
		Else
			aGrpPag[nPos,3]  += nSvalser
			aGrpPag[nPos,4]  += nStotimp
			aGrpPag[nPos,6]  += nSvaliss
			aGrpPag[nPos,7]  += nSvalpis
			aGrpPag[nPos,8]  += nSvalcof
			aGrpPag[nPos,9]  += nScusser
			aGrpPag[nPos,11] += nSlucbru
			aGrpPag[nPos,12] += nSdesvar
			aGrpPag[nPos,13] += nScomven
			aGrpPag[nPos,14] += nSlucliq
			aGrpPag[nPos,15] += nSdesfix
			aGrpPag[nPos,16] += nSdesadm
			aGrpPag[nPos,17] += nSresfin
			// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
			aGrpPag[nPos,18] += nVPrzMd1
			aGrpPag[nPos,19] += nVPrzMd2
			// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
			aGrpPag[nPos,20] += nSdescon
		EndIf
		
		DbSelectArea( "VAI" )
		DbSetOrder(6)
		DbSeek( xFilial("VAI") + cVenVSC )
		
		nPos := 0
		If MV_PAR06 # 3
			nPos := aScan(aTotPag,{|x| x[1]+x[2] == cCPgVSC + Iif(lDuplic,"E","I")+cVenVSC })
		Else
			nPos := aScan(aTotPag,{|x| x[1]+x[2] == cCPgVSC + Iif(lDuplic,"E","I")+VAI->VAI_CC })
		EndIf
		
		If nPos == 0 .or. MV_PAR06 == 4
			If MV_PAR06 # 3
				DbSelectArea( "SA3" )
				DbSetOrder(1)
				DbSeek( xFilial("SA3") + VAI->VAI_CODVEN )
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				aAdd(aTotPag,{ cCPgVSC , Iif(lDuplic,"E","I")+cVenVSC , left(SA3->A3_NOME,17) , nSvalser , nStotimp , 0 , nSvaliss , nSvalpis , nSvalcof , nScusser , 0 , nSlucbru , nSdesvar , nScomven , nSlucliq , nSdesfix , nSdesadm , nSresfin, nVPrzMd1, nVPrzMd2, nSdescon })
				
				nPos3 := 0
				nPos3 := aScan(aCCVend,{|x| x[1]+x[2] == Iif(lDuplic,"E","I")+VAI->VAI_CC + cVenVSC })
				If nPos3 == 0
					DbSelectArea( "SI3" )
					DbSetOrder(1)
					DbSeek( xFilial("SI3") + VAI->VAI_CC )
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					aAdd(aCCVend,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , cVenVSC , left(SA3->A3_NOME,17) , nSvalser , nStotimp , 0 , nSvaliss , nSvalpis , nSvalcof , nScusser , 0 , nSlucbru , nSdesvar , nScomven , nSlucliq , nSdesfix , nSdesadm , nSresfin , Iif(lDuplic,"Ext ","Int ")+left(SI3->I3_DESC,21), nVPrzMd1, nVPrzMd2, nSdescon })
				Else
					aCCVend[nPos3,4]  += nSvalser
					aCCVend[nPos3,5]  += nStotimp
					aCCVend[nPos3,7]  += nSvaliss
					aCCVend[nPos3,8]  += nSvalpis
					aCCVend[nPos3,9]  += nSvalcof
					aCCVend[nPos3,10] += nScusser
					aCCVend[nPos3,12] += nSlucbru
					aCCVend[nPos3,13] += nSdesvar
					aCCVend[nPos3,14] += nScomven
					aCCVend[nPos3,15] += nSlucliq
					aCCVend[nPos3,16] += nSdesfix
					aCCVend[nPos3,17] += nSdesadm
					aCCVend[nPos3,18] += nSresfin
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					aCCVend[nPos3,20] += nVPrzMd1
					aCCVend[nPos3,21] += nVPrzMd2
					// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
					aCCVend[nPos3,22] += nSdescon
				EndIf
				
				nPos3 := 0
				nPos3 := aScan(aTotCCV,{|x| x[1] == Iif(lDuplic,"E","I")+VAI->VAI_CC })
				If nPos3 == 0
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					aAdd(aTotCCV,{ Iif(lDuplic,"E","I")+VAI->VAI_CC , nSvalser , nStotimp , 0 , nSvaliss , nSvalpis , nSvalcof , nScusser , 0 , nSlucbru , nSdesvar , nScomven , nSlucliq , nSdesfix , nSdesadm , nSresfin, nVPrzMd1, nVPrzMd2, nSdescon })
				Else
					aTotCCV[nPos3,2]  += nSvalser
					aTotCCV[nPos3,3]  += nStotimp
					aTotCCV[nPos3,5]  += nSvaliss
					aTotCCV[nPos3,6]  += nSvalpis
					aTotCCV[nPos3,7]  += nSvalcof
					aTotCCV[nPos3,8]  += nScusser
					aTotCCV[nPos3,10] += nSlucbru
					aTotCCV[nPos3,11] += nSdesvar
					aTotCCV[nPos3,12] += nScomven
					aTotCCV[nPos3,13] += nSlucliq
					aTotCCV[nPos3,14] += nSdesfix
					aTotCCV[nPos3,15] += nSdesadm
					aTotCCV[nPos3,16] += nSresfin
					// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
					aTotCCV[nPos3,17] += nVPrzMd1
					aTotCCV[nPos3,18] += nVPrzMd2
					// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
					aTotCCV[nPos3,19] += nSdescon
				EndIf
			Else
				DbSelectArea( "SI3" )
				DbSetOrder(1)
				DbSeek( xFilial("SI3") + VAI->VAI_CC )
				// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
				aAdd(aTotPag,{ cCPgVSC , Iif(lDuplic,"E","I")+VAI->VAI_CC , left(SI3->I3_DESC,14) , nSvalser , nStotimp , 0 , nSvaliss , nSvalpis , nSvalcof , nScusser , 0 , nSlucbru , nSdesvar , nScomven , nSlucliq , nSdesfix , nSdesadm , nSresfin, nVPrzMd1, nVPrzMd2, nSdescon })
			EndIf
		Else
			aTotPag[nPos,4]  += nSvalser
			aTotPag[nPos,5]  += nStotimp
			aTotPag[nPos,7]  += nSvaliss
			aTotPag[nPos,8]  += nSvalpis
			aTotPag[nPos,9]  += nSvalcof
			aTotPag[nPos,10] += nScusser
			aTotPag[nPos,12] += nSlucbru
			aTotPag[nPos,13] += nSdesvar
			aTotPag[nPos,14] += nScomven
			aTotPag[nPos,15] += nSlucliq
			aTotPag[nPos,16] += nSdesfix
			aTotPag[nPos,17] += nSdesadm
			aTotPag[nPos,18] += nSresfin
			// Manoel - 15/03/2005 - Inserir aqui, levantamento do Prazo medio
			aTotPag[nPos,19] += nVPrzMd1
			aTotPag[nPos,20] += nVPrzMd2
			// Manoel - 18/05/2005 - Inserir aqui, levantamento do % De Desconto
			aTotPag[nPos,21] += nSdescon
		EndIf
		
		If MV_PAR06 # 2
			DbSelectArea( "VAI" )
			DbSetOrder(6)
			DbSeek( xFilial("VAI") + cVenVSC )
		EndIf
		
		nPos := 0
		nPos := aScan(aPecSrvOfi,{|x| x[1]+x[2]+x[4] == cCPgVSC + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,cVenVSC,VAI->VAI_CC) + Iif(lDuplic,"Ext ","Int ")+left(STR0063,18) })
		If nPos == 0
			DbSelectArea( "SA1" )
			DbSetOrder(1)
			DbSeek( xFilial("SA1") + cCliVSC + cLojVSC )
			aAdd(aPecSrvOfi,{ cCPgVSC , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,cVenVSC,VAI->VAI_CC) , nSvalser , Iif(lDuplic,"Ext ","Int ")+left(STR0063,18) })
		Else
			aPecSrvOfi[nPos,3] += nSvalser
		EndIf
		nPos := 0
		nPos := aScan(aConPagNF,{|x| x[1]+x[2]+x[3]+x[4]+x[7] == cCPgVSC + Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,cVenVSC,VAI->VAI_CC) + (cAliasVSC)->VSC_NUMNFI + (cAliasVSC)->VSC_SERNFI + Iif(lDuplic,"Ext ","Int ")+left(STR0063,18) })
		If nPos == 0
			DbSelectArea( "SA1" )
			DbSetOrder(1)
			DbSeek( xFilial("SA1") + cCliVSC + cLojVSC )
			aAdd(aConPagNF,{ cCPgVSC , Iif(lDuplic,"E","I")+Iif(MV_PAR06#3,cVenVSC,VAI->VAI_CC) , (cAliasVSC)->VSC_NUMNFI , (cAliasVSC)->VSC_SERNFI , left(SA1->A1_NOME,10) , nSvalser , Iif(lDuplic,"Ext ","Int ")+left(STR0063,18) })
		Else
			aConPagNF[nPos,6] += nSvalser
		EndIf
		
	EndIf
	
	
	dbSelectArea(cAliasVSC)
	(cAliasVSC)->(Dbskip())
EndDo
(cAliasVSC)->(DBCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³OR250CHFUN³ Autor ³ Manoel Filho          ³ Data ³ 19/04/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Chamada externa de funcoes "STATIC" deste Fonte            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
// Parametro cNomeFun - Nome da Funcao+Parametros
// Exemplo  cNomeFun := "FS_M_OR25C()" // Para chamar a partir de outro fonte, a funcao FS_M_OR25C()
User Function OR250CHFUN(cNomeFun)

DEFAULT cNomeFun := ""

&cNomeFun

return
