/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "protheus.ch"
#Include "OFIOR560.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ OFIOR560 º Autor ³ Andre Luis Almeida º Data ³  17/07/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Impressao das Vendas por Clientes                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Veiculos/Oficina/Pecas                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIOR560()

Private cDesc1    := STR0001
Private cDesc2    := ""
Private cDesc3    := ""
Private cAlias    := "SF2"
Private aRegistros:= {}
Private nLin      := 0
Private aPag      := 1
Private nIte      := 1
Private aReturn   := {STR0002,1,STR0003,2,2,1,"",1}
Private cTamanho  := "M"           // P/M/G
Private Limite    := 132            // 80/132/220
Private aOrdem    := {}           // Ordem do Relatorio
Private cTitulo   := STR0001
Private cNomeProg := "OFIOR560"
Private cNomeRel  := "OFIOR560"
Private nLastKey  := 0
Private nCaracter := 15
Private cabec1    := ""
Private cabec2    := ""
Private cPerg     := "OFR560"
Private nFiltIni := 0
Private nFiltFin := 0
Private dDataIni := dDataBase
Private dDataFin := dDataBase
Private nk       := 1
Private cTitCab  := ""
Private lOk      := .f.
Private lDepto   := .f.
Private cDepto   := ""
Private aDepto   := {}
Private nCont    := 0
Private lA1_IBGE := If(SA1->(FieldPos("A1_IBGE"))#0,.t.,.f.)
cNomeRel:=SetPrint(cAlias,cNomeRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,,cTamanho)
If nLastKey == 27
	Return
EndIf     
PERGUNTE(cPerg,.f.)
dDataIni := MV_PAR01
dDataFin := MV_PAR02
If MV_PAR04 == 1 // Departamento Individual
	lDepto := .t.
	cDepto := ("1 - "+STR0004)
	aDepto := {("1 - "+STR0004),("2 - "+STR0005),("3 - "+STR0006),("4 - "+STR0007),("5 - "+STR0008),("6 - "+STR0009)}
ElseIf MV_PAR04 == 2 // Todos
	lDepto := .f.
	lOk    := .t.
	cDepto := " "+STR0010
	aDepto := {" "+STR0010}
	MV_PAR04 := 5 //Todos
EndIf
If MV_PAR04 # 5 .or. MV_PAR05 # 5 // Filtrar: Departamentos ou Valores/Qtde Vendas
	nOpc := 0
	DEFINE MSDIALOG oFiltro TITLE STR0011 From 5,25 to 15,66 of oMainWnd
		@ 013,016 SAY STR0012 OF oFiltro SIZE 155,10 PIXEL COLOR CLR_BLACK
		@ 023,016 MSCOMBOBOX oDepto VAR cDepto ITEMS aDepto VALID (lOk:=.t.) SIZE 105,08 OF oFiltro PIXEL COLOR CLR_BLUE WHEN lDepto
		If MV_PAR05 == 1
			@ 042,016 SAY STR0013 OF oFiltro SIZE 155,10 PIXEL COLOR CLR_BLACK
			@ 053,016 SAY STR0014 OF oFiltro SIZE 150,10 PIXEL COLOR CLR_BLUE
			@ 052,064 MSGET oQtdCli VAR nFiltIni PICTURE "@E 999,999,999,999" VALID(nFiltIni>0) SIZE 55,08 OF oFiltro PIXEL COLOR CLR_BLUE
		ElseIf MV_PAR05 == 2
			@ 042,016 SAY STR0015 OF oFiltro SIZE 155,10 PIXEL COLOR CLR_BLACK
			@ 053,016 SAY STR0016 OF oFiltro SIZE 150,10 PIXEL COLOR CLR_BLUE
			@ 052,072 MSGET oVlrTot VAR nFiltIni PICTURE "@E 99,999,999,999.99" VALID(nFiltIni>0) SIZE 55,08 OF oFiltro PIXEL COLOR CLR_BLUE
		ElseIf MV_PAR05 == 3
			@ 042,016 SAY STR0017 OF oFiltro SIZE 155,10 PIXEL COLOR CLR_BLACK
			@ 053,016 SAY STR0018 OF oFiltro SIZE 150,10 PIXEL COLOR CLR_BLUE
			@ 052,070 MSGET oPerTot VAR nFiltIni PICTURE "@E 999.9" VALID(nFiltIni>0 .and. nFiltIni<=100) SIZE 55,08 OF oFiltro PIXEL COLOR CLR_BLUE
		ElseIf MV_PAR05 == 4
			@ 038,016 SAY STR0019 OF oFiltro SIZE 155,10 PIXEL COLOR CLR_BLACK
			@ 049,016 SAY STR0020 OF oFiltro SIZE 150,10 PIXEL COLOR CLR_BLUE
			@ 048,065 MSGET oVlrIni VAR nFiltIni PICTURE "@E 99,999,999,999.99" VALID(nFiltIni>0) SIZE 55,08 OF oFiltro PIXEL COLOR CLR_BLUE
			@ 059,016 SAY STR0021 OF oFiltro SIZE 150,10 PIXEL COLOR CLR_BLUE
			@ 058,065 MSGET oVlrFin VAR nFiltFin PICTURE "@E 99,999,999,999.99" VALID(nFiltFin>=nFiltIni) SIZE 55,08 OF oFiltro PIXEL COLOR CLR_BLUE
		Else
			lOk:=.t.
		EndIf	
	DEFINE SBUTTON FROM 009,125 TYPE 1 ACTION(nOpc:=1,oFiltro:End()) ENABLE OF oFiltro PIXEL WHEN lOk
	@ 004,004 TO 073,159 LABEL "" OF oFiltro PIXEL  //caixa 1
	ACTIVATE MSDIALOG oFiltro CENTER 
   If nOpc == 0
		Return()
   EndIf
EndIf
nCont := 0
If MV_PAR09 == 4 // Etiqueta
	cPerg := "OFR561"
	If PERGUNTE(cPerg,.t.)
		nCol  := MV_PAR01
  		nLarg := MV_PAR02
  	Else
  		Return()
  	EndIf
EndIf
SetDefault(aReturn,cAlias)
RptStatus( { |lEnd| FS_IMP_OFR560(@lEnd,cNomeRel,cAlias) } , cTitulo )
If aReturn[5] == 1
   OurSpool( cNomeRel )
EndIf
MS_Flush()
Return
                              
           
Static Function FS_IMP_OFR560()
                  
Local   ni       := 0
Local   nj       := 0 
Local   nDepto   := 0
Private cbTxt    := Space(10)
Private cbCont   := 0
Private cString  := "SF2"
Private Li       := 80
Private m_Pag    := 1
Private nTotal   := 0
Private aTotCli  := {}
Private aNumCli  := {}
Private nValor   := 0
Private cTipo    := ""
Private cTipoSF  := "SF2"
Private nImpost  := 0
Private nCusto   := 0
Private nLucbru  := 0

Set Printer to &cNomeRel
Set Printer On
Set Device  to Printer

nVlrTotal:= 0
cPrefixo := ""
cTipo    := "          "
cTitCab  := left(If(!Empty(cPrefixo),STR0022,STR0023)+cPrefixo+space(6),6)+cTipo
nk := 1
If MV_PAR04 # 5 // Departamento Individual
	If left(cDepto,1) == "1" // Balcao
		MV_PAR04 := 1
		cPrefixo := GetNewPar("MV_PREFBAL","BAL")
		cTitCab  := STR0024
	ElseIf left(cDepto,1) == "2"  // Oficina Pecas
		MV_PAR04 := 2
		cPrefixo := GetNewPar("MV_PREFOFI","OFI")
		cTipo    := STR0025
		cTitCab  := STR0026
	ElseIf left(cDepto,1) == "3"  // Oficina Servicos
		MV_PAR04 := 3
		cPrefixo := GetNewPar("MV_PREFOFI","OFI")
		cTipo    := STR0027
		cTitCab  := STR0028
	ElseIf left(cDepto,1) == "4"  // Veiculos
		MV_PAR04 := 4
		cPrefixo := GetNewPar("MV_PREFVEI","VEI")
		cTitCab  := STR0029
	ElseIf left(cDepto,1) == "5"	// Pecas (Bacao+Oficina)
		nk := 2
		MV_PAR04 := 1
		cPrefixo := GetNewPar("MV_PREFBAL","BAL")
		cTitCab  := STR0030
	ElseIf left(cDepto,1) == "6"	// Oficina (Pecas+Servicos)
		nk := 2
		MV_PAR04 := 2
		cPrefixo := GetNewPar("MV_PREFOFI","OFI")
		cTipo    := STR0025
		cTitCab  := STR0031
	EndIf 
EndIf
For nDepto := 1 to nk
	If nDepto == 2
		cPrefixo := GetNewPar("MV_PREFOFI","OFI")
		If left(cDepto,1) == "5"
			cTipo := STR0025
			MV_PAR04 := 2
   	Else
			cTipo := STR0027
			MV_PAR04 := 3
		EndIf
	EndIf
	If !Empty(dDataIni)
		DbSelectArea("SD2")
		DbSetOrder(5)
		DbSeek( xFilial("SD2") + DTOS(dDataIni) , .t. )
		DbSelectArea("SF2")
		DbSetOrder(1)
		DbSeek( xFilial("SF2") + SD2->D2_DOC + SD2->D2_SERIE + SD2->D2_CLIENTE + SD2->D2_LOJA )
	Else                                                                         
		DbSelectArea("SF2")
		DbSetOrder(1)
		DbSeek( xFilial("SF2") ) 
	EndIf
	SetRegua( RecCount() )       
	While !Eof() .and. ( SF2->F2_FILIAL == xFilial("SF2") .and. ( Empty(dDataFin) .or. SF2->F2_EMISSAO <= dDataFin ))
		IncRegua()
		nCont++
		If SF2->F2_TIPO # "N"
		   DbSelectArea("SF2")  
			DbSkip()     	          
			Loop
		EndIf      
	  	If !Empty(cPrefixo) .and. !(SF2->F2_PREFORI $ cPrefixo)
	   	DbSelectArea("SF2")  
			DbSkip()     	          
			Loop
		EndIf
		DbSelectArea("SA1")
		DbSetOrder(1)
		DbSeek(xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA )

			DbSelectArea("VAM")
			DbSetOrder(1)
			DbSeek(xFilial("VAM")+SA1->A1_IBGE)
			If !Empty(MV_PAR06) .and. (VAM->VAM_REGIAO#MV_PAR06)
			   DbSelectArea("SF2")
				DbSkip()
				Loop
	   	EndIf
			If !Empty(MV_PAR07+MV_PAR08) .and. (VAM->VAM_DESCID+VAM->VAM_ESTADO#MV_PAR07+MV_PAR08)
			   DbSelectArea("SF2")
				DbSkip()
				Loop
			EndIf







		DbSelectArea("SD2")
		DbSetOrder(3)
		DbSeek(xFilial("SD2") + SF2->F2_DOC + SF2->F2_SERIE + SF2->F2_CLIENTE + SF2->F2_LOJA )
		DbSelectArea( "SF4" )	
		DbSetOrder(1)
		DbSeek( xFilial("SF4") + SD2->D2_TES )
	   If SF4->F4_DUPLIC # "S" .or. ( SF2->F2_PREFORI == GetNewPar("MV_PREFBAL","BAL") .and. SF4->F4_ESTOQUE # "S" )
		   DbSelectArea("SF2")  
			DbSkip()     	          
			Loop
	   EndIf
		nValor := 0
		If MV_PAR04 # 3
			DbSelectArea("SD2")
			While !Eof() .and. ( SD2->D2_FILIAL == xFilial("SD2") ) .and. ( SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA == SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA )
				nValor += SD2->D2_CUSTO1
			   DbSelectArea("SD2")
				DbSkip()
			EndDo
		EndIf
		nCusto := nValor                             
		nValor := 0
		If MV_PAR04 == 1 .or. MV_PAR04 == 2 .or. MV_PAR04 == 5
			DbSelectArea("VEC")
			DbSetOrder(4)
			DbSeek(xFilial("VEC") + SF2->F2_DOC + SF2->F2_SERIE )
			While !Eof() .and. ( VEC->VEC_FILIAL == xFilial("VEC") ) .and. ( VEC->VEC_NUMNFI+VEC->VEC_SERNFI == SF2->F2_DOC + SF2->F2_SERIE )
				nValor += VEC->VEC_VALPIS + VEC->VEC_VALCOF
				If MV_PAR09==3 // Relatorio Analitico (Grupo+Cod.Item)
					DbSelectArea("SB1")
					DbSetOrder(1)
					DbSeek( xFilial("SB1") + VEC->VEC_PECINT )
					aAdd(aNumCli,{ SF2->F2_CLIENTE + SF2->F2_LOJA , SB1->B1_GRUPO +" "+ SB1->B1_CODITE , SB1->B1_DESC , VEC->VEC_QTDITE , VEC->VEC_VALBRU , VEC->VEC_PECINT , "2" })
				EndIf
			   DbSelectArea("VEC") 
				DbSkip()
			EndDo
		EndIf
		If MV_PAR04 == 3 .or. MV_PAR04 == 5
			If MV_PAR04 == 3
				nCusto := 0
				DbSelectArea("VSC")
				DbSetOrder(6)
				If !DbSeek(xFilial("VSC") + SF2->F2_DOC + SF2->F2_SERIE )
			   	DbSelectArea("SF2")  
					DbSkip()     	          
					Loop
				EndIf
			EndIf
			DbSelectArea("VSC")
			DbSetOrder(6)
			DbSeek(xFilial("VSC") + SF2->F2_DOC + SF2->F2_SERIE )
			While !Eof() .and. ( VSC->VSC_FILIAL == xFilial("VSC") ) .and. ( VSC->VSC_NUMNFI+VSC->VSC_SERNFI == SF2->F2_DOC + SF2->F2_SERIE )
				nValor += VSC->VSC_VALPIS + VSC->VSC_VALCOF
				nCusto += VSC->VSC_CUSSER 
				If MV_PAR09==3 // Relatorio Analitico (Tp.Srv+Cod.Srv)
					DbSelectArea("VO6") 
					DbSetOrder(1)
					DbSeek( xFilial("VO6") + VSC->VSC_SERINT )
					aAdd(aNumCli,{ SF2->F2_CLIENTE + SF2->F2_LOJA , VSC->VSC_TIPSER +" "+ VSC->VSC_CODSER , Substr(VO6->VO6_DESSER,1,30) , 1 , VSC->VSC_VALSER , VSC->VSC_SERINT , "4" })
				EndIf				
			   DbSelectArea("VSC") 
				DbSkip()
			EndDo
	   EndIf
		If MV_PAR04 == 4 .or. MV_PAR04 == 5
			DbSelectArea("VV0")
			DbSetOrder(4)
			DbSeek(xFilial("VV0") + SF2->F2_DOC + SF2->F2_SERIE )
			While !Eof() .and. ( VV0->VV0_FILIAL == xFilial("VV0") ) .and. ( VV0->VV0_NUMNFI+VV0->VV0_SERNFI == SF2->F2_DOC + SF2->F2_SERIE )
				DbSelectArea("VVA")
				DbSetOrder(1)
				DbSeek(xFilial("VVA") + VV0->VV0_NUMTRA )
				nValor += VVA->VVA_PISVEN + VVA->VVA_COFVEN
				If MV_PAR09==3 // Relatorio Analitico (Chassi+Modelo)
					DbSelectArea("VV1")
					DbSetOrder(1)
					DbSeek( xFilial("VV1") + VVA->VVA_CHAINT )
					aAdd(aNumCli,{ SF2->F2_CLIENTE + SF2->F2_LOJA , VVA->VVA_CHASSI , VV1->VV1_MODVEI , 1 , VVA->VVA_FATTOT , VVA->VVA_CHAINT , "1" })
				EndIf
			   DbSelectArea("VV0")
				DbSkip()
			EndDo
		EndIf                                     
		If MV_PAR04 == 2
			nImpost := SF2->F2_VALICM + nValor
		ElseIf MV_PAR04 == 3
			nImpost := SF2->F2_VALISS + nValor
		Else
			nImpost := SF2->F2_VALICM + SF2->F2_VALISS + nValor
		EndIf
		nValor := 0
		nValor := SF2->F2_VALBRUT
		If MV_PAR04 == 1 .or. MV_PAR04 == 2
			nValor := SF2->F2_VALBRUT - SF2->F2_BASEISS
		ElseIf MV_PAR04 == 3
			nValor := SF2->F2_BASEISS	
		EndIf
		nLucbru := (  nValor - ( nImpost + nCusto ) )
		nPos := aScan(aTotCli,{|x| x[1] == SF2->F2_CLIENTE + SF2->F2_LOJA })
		If nPos == 0
			aAdd(aTotCli,{ SF2->F2_CLIENTE + SF2->F2_LOJA , left(SA1->A1_NOME,30) , SA1->A1_CGC+" "+If(lA1_IBGE,left(VAM->VAM_DESCID,16)+"-"+VAM->VAM_ESTADO+" "+VAM->VAM_REGIAO,left(SA1->A1_MUN,20)+"-"+SA1->A1_EST) , 1 , nValor , 9999 , 1000000000000-nValor , nImpost , nCusto , nLucbru })
	   Else
	   	aTotCli[nPos,4]++
			aTotCli[nPos,5]+= nValor
	   	aTotCli[nPos,6]--
			aTotCli[nPos,7]-= nValor
			aTotCli[nPos,8]+= nImpost
			aTotCli[nPos,9]+= nCusto
			aTotCli[nPos,10]+= nLucbru
	   EndIf
	  	nVlrTotal += nValor
		If MV_PAR09==2 // Relatorio Sintetico (NF+Serie)
			DbSelectArea("SA3")
			DbSetOrder(1)
			DbSeek( xFilial("SA3") + SF2->F2_VEND1 )
			aAdd(aNumCli,{ SF2->F2_CLIENTE + SF2->F2_LOJA , SF2->F2_DOC +"-"+ SF2->F2_SERIE , nValor , nImpost , nCusto , nLucbru , Transform(SF2->F2_EMISSAO,"@D")+" "+SA3->A3_NREDUZ })
	  	EndIf
	   DbSelectArea("SF2")
		DbSkip()
	EndDo
	If MV_PAR05 == 5  // Somente somar Outras Vendas quando NENHUM FILTRO
		nj := 1
		If MV_PAR04 == 5  // Todas
			nj := 2
		EndIf
		For ni := 1 to nj // Outras Vendas 
			If ni == 2
			   MV_PAR04 := 1  // Outras Vendas: Outros
			EndIf
			nPis := ( GetMv("MV_TXPIS")   / 100 )
			nCof := ( GetMv("MV_TXCOFIN") / 100 )
			If !Empty(dDataIni)
				DbSelectArea("SD2")
				DbSetOrder(5)
				DbSeek( xFilial("SD2") + DTOS(dDataIni) , .t. )
				DbSelectArea("SF2")
				DbSetOrder(1)
				DbSeek( xFilial("SF2") + SD2->D2_DOC + SD2->D2_SERIE + SD2->D2_CLIENTE + SD2->D2_LOJA )
			Else                                                                         
				DbSelectArea("SF2")
				DbSetOrder(1)
				DbSeek( xFilial("SF2") ) 
			EndIf
			While !Eof() .and. ( SF2->F2_FILIAL == xFilial("SF2") .and. ( Empty(dDataFin) .or. SF2->F2_EMISSAO <= dDataFin ))
				IncRegua()
				If SF2->F2_TIPO # "N"
				   DbSelectArea("SF2")  
					DbSkip()     	          
					Loop
				EndIf
				If !( cPrefixo==GetNewPar("MV_PREFOFI","OFI") .and. SF2->F2_VALISS > 0 .and. SF2->F2_PREFORI==GetNewPar("MV_PREFBAL","BAL") .and. cTipo==STR0027 )
		   		If !Empty(cPrefixo) .and. !(SF2->F2_PREFORI $ cPrefixo)
				   	DbSelectArea("SF2")  
						DbSkip()     	          
						Loop
					EndIf
				EndIf
				DbSelectArea( "VV0" )	//	VEICULOS
				DbSetOrder(4)
				If DbSeek( xFilial("VV0") + SF2->F2_DOC + SF2->F2_SERIE )
					DbSelectArea("SF2")
					Dbskip()
					loop
				EndIf  
				DbSelectArea( "VSC" )	//	SERVICOS
				DbSetOrder(6)
				If DbSeek( xFilial("VSC") + SF2->F2_DOC + SF2->F2_SERIE )
					DbSelectArea("SF2")
					Dbskip()
					loop
				EndIf  
				DbSelectArea( "SD2" )	
				DbSetOrder(3)
				DbSeek( xFilial("SD2") + SF2->F2_DOC + SF2->F2_SERIE )
				DbSelectArea( "VEC" )	//	PECAS
				DbSetOrder(4)
				If DbSeek( xFilial("VEC") + SF2->F2_DOC + SF2->F2_SERIE )
					If MV_PAR04 == 1
						If SD2->D2_VALISS > 0
							DbSelectArea("SF2")
							Dbskip()
							loop
						EndIf
					Else
						If SD2->D2_VALISS == 0 
							DbSelectArea("SF2")
							Dbskip()
							loop
						EndIf
					EndIf
				EndIf  
				DbSelectArea("SA1")
				DbSetOrder(1)
				DbSeek(xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA )

					DbSelectArea("VAM")
					DbSetOrder(1)
					DbSeek(xFilial("VAM")+SA1->A1_IBGE) 
					If !Empty(MV_PAR06) .and. (VAM->VAM_REGIAO#MV_PAR06)
		   			DbSelectArea("SF2")
						DbSkip()
						Loop
   				EndIf
					If !Empty(MV_PAR07+MV_PAR08) .and. (VAM->VAM_DESCID+VAM->VAM_ESTADO#MV_PAR07+MV_PAR08)
					   DbSelectArea("SF2")
						DbSkip()
						Loop
					EndIf







				lSF2Soma:= .f.
				nValor  := 0
				nImpost := 0
				nCusto  := 0
				nLucbru := 0
				DbSelectArea( "SD2" )	
				While !Eof() .and. (SD2->D2_FILIAL == xFilial("SD2")) .and. (SD2->D2_DOC+SD2->D2_SERIE == SF2->F2_DOC+SF2->F2_SERIE)
					DbSelectArea( "SF4" )	
					DbSetOrder(1)
					DbSeek( xFilial("SF4") + SD2->D2_TES )
					lSrvPec := .f.
					If strzero(MV_PAR04,1) $ "1/2/4/5"// 1-Balcao 2-Oficina Pecas 4-Veiculos 5-Pecas Geral(Balcao+Oficina)
                        If SD2->D2_BASEISS<>0 
                            lSrvPec := .t.
                        EndIf
                    ElseIf MV_PAR04 == 3 // Oficina Servicos
						If SD2->D2_BASEISS==0 
							lSrvPec := .t.
						EndIf
					EndIf
					// Se for duplicata ou servico/peca nao soma
					If SF4->F4_DUPLIC # "S" .or. lSrvPec
						DbSelectArea("SD2")
						Dbskip()
						loop
					Else
						If Alltrim(SF4->F4_ATUATF) # "S"    //  OUTRAS VENDAS
							
							If !lSF2Soma 
							   lSF2Soma := .t.
							 	nImpost += (SF2->F2_VALICM + SF2->F2_VALISS + (SD2->D2_TOTAL * nPis) + (SD2->D2_TOTAL * nCof))
							EndIf
					 		nValor += SD2->D2_TOTAL
							nCusto += SD2->D2_CUSTO1
							If MV_PAR09==3 // Relatorio Analitico (Grupo+Cod.Item)
								DbSelectArea("SB1")
								DbSetOrder(1)
								DbSeek( xFilial("SB1") + SD2->D2_COD )
								aAdd(aNumCli,{ SF2->F2_CLIENTE + SF2->F2_LOJA , SB1->B1_GRUPO +" "+ SB1->B1_CODITE , SB1->B1_DESC , SD2->D2_QUANT , SD2->D2_TOTAL , SD2->D2_COD , "3" })
							EndIf							
						EndIf
					EndIf
				   DbSelectArea("SD2")
					DbSkip()
				EndDo
				If nValor > 0
					nPos := aScan(aTotCli,{|x| x[1] == SF2->F2_CLIENTE + SF2->F2_LOJA })
					If nPos == 0
						aAdd(aTotCli,{ SF2->F2_CLIENTE + SF2->F2_LOJA , left(SA1->A1_NOME,30) , SA1->A1_CGC+" "+If(lA1_IBGE,left(VAM->VAM_DESCID,16)+"-"+VAM->VAM_ESTADO+" "+VAM->VAM_REGIAO,left(SA1->A1_MUN,20)+"-"+SA1->A1_EST) , 1 , nValor , 9999 , 1000000000000-nValor , nImpost , nCusto , 0 })
		   		Else
			   		aTotCli[nPos,4]++
						aTotCli[nPos,5]+= nValor
			   		aTotCli[nPos,6]--
						aTotCli[nPos,7]-= nValor
						aTotCli[nPos,8]+= nImpost
						aTotCli[nPos,9]+= nCusto
			   	EndIf
			   	nVlrTotal += nValor
  					If MV_PAR09==2 // Relatorio Sintetico(NF+Serie)
						DbSelectArea("SA3")
						DbSetOrder(1)
						DbSeek( xFilial("SA3") + SF2->F2_VEND1 )
						aAdd(aNumCli,{ SF2->F2_CLIENTE + SF2->F2_LOJA , SF2->F2_DOC +"-"+ SF2->F2_SERIE , nValor , nImpost , nCusto , nLucbru , Transform(SF2->F2_EMISSAO,"@D")+" "+SA3->A3_NREDUZ })
			  		EndIf
		   	EndIf
				DbSelectArea("SF2")
				DbSkip()
			EndDo
		Next
	EndIf
	If MV_PAR04 # 3
		If !Empty(dDataIni)
			DbSelectArea("SD1")
			DbSetOrder(6)
			DbSeek( xFilial("SD1") + DTOS(dDataIni) , .t. )
			DbSelectArea("SF1")
			DbSetOrder(1)
			DbSeek( xFilial("SF1") + SD1->D1_DOC + SD1->D1_SERIE + SD1->D1_FORNECE + SD1->D1_LOJA )
		Else                                                                         
			DbSelectArea("SF1")
			DbSetOrder(1)
			DbSeek( xFilial("SF1") ) 
		EndIf
		While !Eof() .and. ( SF1->F1_FILIAL == xFilial("SF1") .and. ( Empty(dDataFin) .or. SF1->F1_DTDIGIT <= dDataFin ))
			If SF1->F1_TIPO == "D"
				DbSelectArea( "SD1" )
				DbSetOrder(1)
				DbSeek( xFilial("SD1") + SF1->F1_DOC + SF1->F1_SERIE + SF1->F1_FORNECE + SF1->F1_LOJA )
				While !Eof() .and. SD1->D1_FILIAL == xFilial("SD1") .and. SF1->F1_DOC + SF1->F1_SERIE + SF1->F1_FORNECE + SF1->F1_LOJA == SD1->D1_DOC + SD1->D1_SERIE + SD1->D1_FORNECE + SD1->D1_LOJA
				 	DbSelectArea( "SF4" )
					DbSetOrder(1)
					DbSeek( xFilial("SF4") + SD1->D1_TES )    
					If SF4->F4_ESTOQUE == "S"
						cTipoSF := "SF2"
					 	DbSelectArea( "SF2" )
						DbSetOrder(1)
						If DbSeek( xFilial("SF2") + SD1->D1_NFORI + SD1->D1_SERIORI , .f. )
							If !Empty(cPrefixo) .and. !(SF2->F2_PREFORI $ cPrefixo)
				   			DbSelectArea("SD1")  
								DbSkip()     	          
								Loop
							EndIf
						Else
							cTipoSF := "SF1"
						EndIf
						If cTipoSF == "SF2"
							DbSelectArea("SA1")
							DbSetOrder(1)
							DbSeek(xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA )
						Else
							DbSelectArea("SA1")
							DbSetOrder(1)
							DbSeek(xFilial("SA1") + SF1->F1_FORNECE + SF1->F1_LOJA )
						EndIf

							DbSelectArea("VAM")
							DbSetOrder(1)
							DbSeek(xFilial("VAM")+SA1->A1_IBGE) 
							If !Empty(MV_PAR06) .and. (VAM->VAM_REGIAO#MV_PAR06)
								Exit
			   			EndIf
							If !Empty(MV_PAR07+MV_PAR08) .and. (VAM->VAM_DESCID+VAM->VAM_ESTADO#MV_PAR07+MV_PAR08)
								Exit
							EndIf





						nVlrDev := ( ( SD1->D1_TOTAL + SD1->D1_VALIPI + SD1->D1_ICMSRET + SD1->D1_DESPESA + SD1->D1_SEGURO + SD1->D1_VALFRE ) - SD1->D1_VALDESC )
						nPisDev := 0
						nCofDev := 0

						DbSelectArea("SFT")
						DbSetOrder(1)
						DbSeek(xFilial("SFT")+ "E" + SD1->D1_SERIE + SD1->D1_DOC + SD1->D1_FORNECE + SD1->D1_LOJA + SD1->D1_ITEM)

						// Verifica se tem COFINS/PIS - se tem SFT->FT_VALIMP5(COF) e se tem SFT->FT_VALIMP6(PIS)
						If SFT->FT_VALIMP5 > 0 .AND. SFT->FT_VALIMP6 == 0
							nPisDev := 0
							nCofDev := round( nVlrDev * nCof ,2)
						ElseIf SFT->FT_VALIMP5 == 0 .AND. SFT->FT_VALIMP6 > 0
							nPisDev := round( nVlrDev * nPis ,2)
							nCofDev := 0
						ElseIf SFT->FT_VALIMP5 > 0 .AND. SFT->FT_VALIMP6 > 0
							nPisDev := round( nVlrDev * nPis ,2)
							nCofDev := round( nVlrDev * nCof ,2)
						Else
							nPisDev := 0
							nCofDev := 0
						EndIf

						nValor  := nVlrDev
						nImpDev := ( SD1->D1_VALICM + SD1->D1_VALISS + nPisDev + nCofDev )
						nImpost := nImpDev
						nCusto  := SD1->D1_CUSTO
						nLucbru := ( nValor - ( nImpost + nCusto ) )
						If cTipoSF == "SF2"
							nPos := aScan(aTotCli,{|x| x[1] == SF2->F2_CLIENTE + SF2->F2_LOJA })
						Else
							nPos := aScan(aTotCli,{|x| x[1] == SF1->F1_FORNECE + SF1->F1_LOJA })
						EndIf
						If nPos == 0
							If cTipoSF == "SF2"
								aAdd(aTotCli,{ SF2->F2_CLIENTE + SF2->F2_LOJA , left(SA1->A1_NOME,30) , SA1->A1_CGC+" "+If(lA1_IBGE,left(VAM->VAM_DESCID,16)+"-"+VAM->VAM_ESTADO+" "+VAM->VAM_REGIAO,left(SA1->A1_MUN,20)+"-"+SA1->A1_EST) , 1 , nValor*(-1) , 9999 , 1000000000000-(nValor*(-1)) , nImpost*(-1) , nCusto*(-1) , nLucbru*(-1) })
							Else
								aAdd(aTotCli,{ SF1->F1_FORNECE + SF1->F1_LOJA , left(SA1->A1_NOME,30) , SA1->A1_CGC+" "+If(lA1_IBGE,left(VAM->VAM_DESCID,16)+"-"+VAM->VAM_ESTADO+" "+VAM->VAM_REGIAO,left(SA1->A1_MUN,20)+"-"+SA1->A1_EST) , 1 , nValor*(-1) , 9999 , 1000000000000-(nValor*(-1)) , nImpost*(-1) , nCusto*(-1) , nLucbru*(-1) })
							EndIf
					   Else
							aTotCli[nPos,5]+= nValor*(-1)
							aTotCli[nPos,7]-= nValor*(-1)
							aTotCli[nPos,8]+= nImpost*(-1)
							aTotCli[nPos,9]+= nCusto*(-1)
							aTotCli[nPos,10]+= nLucbru*(-1)
					   EndIf
		   	   	nVlrTotal -= nValor
	  					If MV_PAR09==2 // Relatorio Sintetico (NF+Serie)
							If cTipoSF == "SF2"
								nPos := aScan(aNumCli,{|x| x[1]+x[2] == SF2->F2_CLIENTE + SF2->F2_LOJA + SF2->F2_DOC +"-"+ SF2->F2_SERIE })
							Else
								nPos := aScan(aNumCli,{|x| x[1]+x[2] == SF1->F1_FORNECE + SF1->F1_LOJA + SF1->F1_DOC +"-"+ SF1->F1_SERIE })
							EndIf
							If nPos == 0
	  							If cTipoSF == "SF2"
									DbSelectArea("SA3")
									DbSetOrder(1)
									DbSeek( xFilial("SA3") + SF2->F2_VEND1 )
									aAdd(aNumCli,{ SF2->F2_CLIENTE + SF2->F2_LOJA , SF2->F2_DOC +"-"+ SF2->F2_SERIE , nValor*(-1) , nImpost*(-1) , nCusto*(-1) , nLucbru*(-1) , Transform(SF2->F2_EMISSAO,"@D")+" "+SA3->A3_NREDUZ })
								Else
									aAdd(aNumCli,{ SF1->F1_FORNECE + SF1->F1_LOJA , SF1->F1_DOC +"-"+ SF1->F1_SERIE , nValor*(-1) , nImpost*(-1) , nCusto*(-1) , nLucbru*(-1) , Transform(SF1->F1_DTDIGIT,"@D") })
								EndIf
					   	Else
								aNumCli[nPos,3]+= nValor*(-1)
								aNumCli[nPos,4]+= nImpost*(-1)
								aNumCli[nPos,5]+= nCusto*(-1)
								aNumCli[nPos,6]+= nLucbru*(-1)
							EndIf
						ElseIf MV_PAR09==3 // Relatorio Analitico (Chassi+Modelo/Grupo+Cod.Item/Tp.Srv+Desc.Srv)
							If cTipoSF == "SF2"
								nPos := aScan(aNumCli,{|x| x[1]+x[6] == SF2->F2_CLIENTE + SF2->F2_LOJA + SD1->D1_COD })
							Else
								nPos := aScan(aNumCli,{|x| x[1]+x[6] == SF1->F1_FORNECE + SF1->F1_LOJA + SD1->D1_COD })
							EndIf
							If nPos == 0
								DbSelectArea("SB1")
								DbSetOrder(1)
								DbSeek( xFilial("SB1") + SD1->D1_COD )
								If cTipoSF == "SF2"
									aAdd(aNumCli,{ SF2->F2_CLIENTE + SF2->F2_LOJA , SB1->B1_GRUPO +" "+ SB1->B1_CODITE , SB1->B1_DESC , SD1->D1_QUANT*(-1) , nValor*(-1) , SD1->D1_COD , "2" })
								Else
									aAdd(aNumCli,{ SF1->F1_FORNECE + SF1->F1_LOJA , SB1->B1_GRUPO +" "+ SB1->B1_CODITE , SB1->B1_DESC , SD1->D1_QUANT*(-1) , nValor*(-1) , SD1->D1_COD , "2" })
								EndIf
							Else
								aNumCli[nPos,4]+= SD1->D1_QUANT*(-1)
								aNumCli[nPos,5]+= nValor*(-1)
							EndIf
						EndIf
					EndIf
					DbSelectArea("SD1")
					Dbskip()             
				EndDo
			EndIf
			DbSelectArea("SF1")
			Dbskip()             
		EndDo
	EndIf
Next

If MV_PAR03 == 1
	aSort(aTotCli,1,,{|x,y| x[2] < y[2] })
ElseIf MV_PAR03 == 2
	aSort(aTotCli,1,,{|x,y| str(x[6],4) + str(x[7],13) + x[2] < str(y[6],4) + str(y[7],13) + y[2] })
Else
	aSort(aTotCli,1,,{|x,y| str(x[7],13) + x[2] < str(y[7],13) + y[2] })
EndIf             

If MV_PAR09 # 4 // Relatorio
	If MV_PAR05 == 1
		cabec1 := STR0013+" ( "+Alltrim(Transform(nFiltIni,"@E 999,999,999,999"))+" "+STR0032+" )"
		cabec2 := STR0032+" "+cTitCab+STR0033+Transform(dDataIni,"@D")+STR0034+Transform(dDataFin,"@D")+STR0036
	ElseIf MV_PAR05 == 2
		cabec1 := STR0015+" ( "+Alltrim(Transform(nFiltIni,"@E 99,999,999,999.99"))+" )"
		cabec2 := STR0032+" "+cTitCab+STR0033+Transform(dDataIni,"@D")+STR0034+Transform(dDataFin,"@D")+STR0036
	ElseIf MV_PAR05 == 3
		cabec1 := STR0017+" ( "+Alltrim(Transform(nFiltIni,"@E 999.9"))+" % )"
		cabec2 := STR0032+" "+cTitCab+STR0033+Transform(dDataIni,"@D")+STR0034+Transform(dDataFin,"@D")+STR0036
	ElseIf MV_PAR05 == 4
		cabec1 := STR0019+" ("+STR0035+Alltrim(Transform(nFiltIni,"@E 99,999,999,999.99"))+STR0034+Alltrim(Transform(nFiltFin,"@E 99,999,999,999.99"))+" )"
		cabec2 := STR0032+" "+cTitCab+STR0033+Transform(dDataIni,"@D")+STR0034+Transform(dDataFin,"@D")+STR0036
	Else
		cabec1 := STR0032+" "+cTitCab+STR0033+Transform(dDataIni,"@D")+STR0034+Transform(dDataFin,"@D")+STR0036
	EndIf	
	nLin  := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
	nVlrVendas := 0
	nVlrImpost := 0
	nVlrCustos := 0
	nLucroBrut := 0
	If len(aNumCli) > 0
		If MV_PAR09==2 // Relatorio Sintetico (NF+Serie)
			aSort(aNumCli,1,,{|x,y| x[1] + x[2] < y[1] + y[2] })
		ElseIf MV_PAR09==3 // Relatorio Analitico (Chassi+Modelo/Grupo+Cod.Item/Tp.Srv+Desc.Srv)
			aSort(aNumCli,1,,{|x,y| x[1] + x[7] + x[2] < y[1] + y[7] + y[2] })
		EndIf
	EndIf
Else // Etiqueta
	nColunas := nCol
	nLin     := 0
   cNomes   := ""
   cEnds    := ""
  	cBairros := ""
   cCeps    := ""
EndIf
lImpr := .t.
For ni := 1 to len(aTotCli)
	If aTotCli[ni,5] # 0
		If MV_PAR05 # 5 // Filtrar por:
			lImpr := .t.
			If ( MV_PAR05 == 1 ) .and. ( ni > nFiltIni ) // Qtde de Clientes
				Exit
			ElseIf ( MV_PAR05 == 2 ) .and. ( ( nVlrVendas + aTotCli[ni,5] ) > nFiltIni ) // Vlr Total
			   Exit
			ElseIf ( MV_PAR05 == 3 ) .and. ( ( ( ( nVlrVendas + aTotCli[ni,5] ) / nVlrTotal ) * 100 ) > nFiltIni ) // % Total
			   Exit
			ElseIf ( MV_PAR05 == 4 ) .and. ( ( aTotCli[ni,5] < nFiltIni ) .or. ( aTotCli[ni,5] > nFiltFin ) ) // Vlr das Vendas por Cliente
				lImpr := .f.
			EndIf
		EndIf
		If lImpr
			If MV_PAR09 # 4 // Relatorio
			  	If nLin >= 58
					nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
			   EndIf
	  			@ nLin++ , 00 psay left(aTotCli[ni,2]+" "+aTotCli[ni,3],69) + Transform(aTotCli[ni,4],"@E 999999") + Transform(aTotCli[ni,5],"@E 999999,999.99") + Transform(aTotCli[ni,8],"@E 99999,999.99") + Transform(aTotCli[ni,9],"@E 999999,999.99") + Transform(aTotCli[ni,10],"@E 99999,999.99") + Transform(((aTotCli[ni,10]/aTotCli[ni,5])*100),"@E 9999.9")+"%"
				nVlrVendas += aTotCli[ni,5]
		  		nVlrImpost += aTotCli[ni,8]
			  	nVlrCustos += aTotCli[ni,9]
				nLucroBrut += aTotCli[ni,10]
				nTotal++ 
				If MV_PAR09 # 1
					nPos := aScan(aNumCli,{|x| x[1] == aTotCli[ni,1] })
					For nj := nPos to Len(aNumCli)
						If aNumCli[nj,1] == aTotCli[ni,1]
						  	If nLin >= 60
								nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1
						   EndIf
							If MV_PAR09 == 2
					  			@ nLin++ , 00 psay left(space(25)+aNumCli[nj,2]+" "+aNumCli[nj,7]+space(50),75) + Transform(aNumCli[nj,3],"@E 999999,999.99") + Transform(aNumCli[nj,4],"@E 99999,999.99") + Transform(aNumCli[nj,5],"@E 999999,999.99") + Transform(aNumCli[nj,6],"@E 99999,999.99") + Transform(((aNumCli[nj,6]/aNumCli[nj,3])*100),"@E 9999.9")+"%"
					  		ElseIf MV_PAR09 == 3 
					  			If nj < len(aNumCli)
					  				If ( aNumCli[nj,1] + aNumCli[nj,2] ) == ( aNumCli[nj+1,1] + aNumCli[nj+1,2] ) 
					  				   aNumCli[nj+1,4] += aNumCli[nj,4]
					  				   aNumCli[nj+1,5] += aNumCli[nj,5]
					  				   aNumCli[nj,4] := 0              
					  				   aNumCli[nj,5] := 0
					  				EndIf
					  			EndIf
					  			If ( aNumCli[nj,4] # 0 ) .or. ( aNumCli[nj,5] # 0 )
					  				@ nLin++ , 00 psay left(space(7)+aNumCli[nj,2]+" "+aNumCli[nj,3]+space(62),69) + Transform(aNumCli[nj,4],"@E 999999") + Transform(aNumCli[nj,5],"@E 999999,999.99")
					  			EndIf
							EndIf
				  		Else
							Exit
				  		EndIf
			  		Next
			  		nLin++
				EndIf
			Else // Etiqueta
			   If !(nColunas > 0 )
			      nLin++ 
			      @ nLin++,00 PSAY cNomes
		   	   @ nLin++,00 PSAY cEnds
		      	@ nLin++,00 PSAY cBairros
			      @ nLin++,00 PSAY cCeps
		   	   nLin++
			      nColunas := nCol 
		   	   cNomes := cEnds := cBairros := cCeps := ""
			   EndIf
				DbSelectArea("SA1")
				DbSetOrder(1)
				If DbSeek(xFilial("SA1") + aTotCli[ni,1] )
				   nColunas--                        
				   cNomes   += left( Alltrim(SA1->A1_NOME) + space(nLarg) , nLarg-1 ) + " "
				   cEnds    += left( Alltrim(SA1->A1_END)+", "+SA1->A1_NUMERO + space(nLarg) , nLarg-1 ) + " " 
			   	cBairros += left( SA1->A1_BAIRRO + space(nLarg) , nLarg-1 ) + " " 

						DbSelectArea("VAM")
						DbSetOrder(1)
						DbSeek(xFilial("VAM")+SA1->A1_IBGE) 
					   cCeps += left( Transform(SA1->A1_CEP,"@R 99999-999") + " " + Alltrim(VAM->VAM_DESCID)+"-"+VAM->VAM_ESTADO + space(nLarg) , nLarg-1 ) + " " 



				EndIf
			EndIf
		EndIf
  	EndIf
Next
If MV_PAR09 # 4 // Relatorio
	nLin++                                              
	@ nLin++ , 00 psay space(10)+STR0037+" ("+Transform(nTotal,"@E 9999,999,999")+" "+STR0032+" )            "+Transform(nVlrVendas,"@E 99999999,999.99")+Transform(nVlrImpost,"@E 99999,999.99")+Transform(nVlrCustos,"@E 999999,999.99")+Transform(nLucroBrut,"@E 99999,999.99")+Transform(((nLucroBrut/nVlrVendas)*100),"@E 9999.9")+"%"
Else // Etiqueta
	If len(cNomes) > 0 
		nLin++
	   @ nLin++,00 PSAY cNomes
   	@ nLin++,00 PSAY cEnds
	   @ nLin++,00 PSAY cBairros
   	@ nLin++,00 PSAY cCeps
	EndIf
EndIf
Set Printer to
Set Device  to Screen

Return
