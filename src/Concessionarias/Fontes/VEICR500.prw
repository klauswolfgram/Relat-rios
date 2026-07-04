/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 23     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#Include "protheus.ch"
#Include "fileio.ch"
#Include "VEICR500.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao    ³ VEICR500 ³ Autor ³ Andre Luis Almeida   ³ Data ³ 29/07/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descricao ³ Ficha Modular - Contatos  C E V                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³                Quadro de Informacao - Modulos da Ficha                ³±±
±±³ A = Dados do Cliente                                                  ³±±
±±³ B = Pessoas de Contato                                                ³±±
±±³ C = Quadro Societario                                                 ³±±
±±³ D = Receita bruta/Mes, Principais Clientes, Principais Fornecedores   ³±±
±±³ E = Filiais do Cliente, Empresas Coligadas                            ³±±
±±³ F = Bancos que Trabalha                                               ³±±
±±³ G = Frota do Cliente                                                  ³±±
±±³ H = Equipamentos do Cliente                                           ³±±
±±³ I = Dados da utilizacao de Frota de Terceiros                         ³±±
±±³ J = Cotas de Consorcio do Cliente                                     ³±±
±±³ K = Seguros dos Veiculos                                              ³±±
±±³ L = Pos-Venda (ultimos Srvcos realizados na Oficina, Qtd Veic Acordo, ³±±
±±³     Qtd Veic Contrato Manutencao, Fat. Pecas Bal, Pecas Ofi, MO Ofi)  ³±±
±±³ M = Financeiro (Val.Cadast., Lim.Cred., Sdo.Aberto, Vencido, A Vencer)³±±
±±³ N = Outras Informacoes (Ofic Propria, Qtd Mecanicos, Utiliza Serv 3o. ³±±
±±³     e Valor/Mes, Principais Fornecedores de MO e Pecas)               ³±±
±±³ O = Espaco para definicao da Estrategia a ser seguida na Abordagem    ³±±
±±³ P = Ultimos Contatos realizados                                       ³±±
±±³ Q = Espaco para registrar a Abordagem                                 ³±±
±±³ R = Interesse de Compra / Preferencia Pagto / Data da Proxima Visita  ³±±
±±³ S = Dados do Registro de Satisfacao / Insatifacao do Cliente          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEICR500()
Private cPerg := "VCR500"
Private cPRW  := "VEICR500"
DbSelectArea("SX1")
DbSetOrder(1)
If DbSeek(cPerg+(Space(Len(SX1->X1_GRUPO)-Len(cPerg)))+"11")
	RecLock("SX1",.F.)
	DbDelete()
	MsUnlock()
EndIf
If DbSeek(cPerg+(Space(Len(SX1->X1_GRUPO)-Len(cPerg)))+"12")
	RecLock("SX1",.F.)
	DbDelete()
	MsUnlock()
EndIf               
If Pergunte(cPerg,.t.)
	Processa({|| U_FS_VEICR500()})
EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao    ³FS_VEICR500³ Autor ³ Andre Luis Almeida  ³ Data ³ 29/07/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descricao ³ Impressao da Ficha Modular - Contatos  C E V              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_VEICR500(cPerg)

Local aOrd           := {}
Local cDesc1         := STR0088
Local cDesc2         := ""
Local cDesc3         := ""
Local wnrel          := cPRW // Coloque aqui o nome do arquivo usado para impressao em disco
Local cString        := "VGB"
Local ni             := 0
Local nQI            := 0
Local dPz            := cTod("")
Local lx             := .f.
Local aSM0           := {}
Local lCEVOUT        := ( VAI->(FieldPos("VAI_CEVOUT")) > 0 ) // Visualiza Agendas de Outros Usuarios do CEV? (1=Sim/0=Nao)
Local lVAQ_TIPOSI    := ( VAQ->(FieldPos("VAQ_TIPOSI")) > 0 )
Local lVCF_GRUECN    := ( VCF->(FieldPos("VCF_GRUECN")) > 0 )
Local lNewVend       := ( VCF->(FieldPos("VCF_VENVEU")) > 0 ) // Possui campos novos Vendedores
Private titulo       := STR0002
Private nLin         := 80
Private lAbortPrint  := .F.
Private limite       := 120
Private tamanho      := "M"
Private Cabec1       := ""
Private Cabec2       := ""
Private nTipo        := 15
Private aReturn      := { STR0089, 1, STR0090, 1, 2, 1, "", 1}  //Zebrado # Administracao
Private nLastKey     := 0
Private m_pag        := 01
Private aImpress := {}
Private aDesc    := {}
Private aContato := {}
Private cContato := ""
Private aAssunto := {}
Private cAssunto := ""
Private cFicCont := ""
Private cCliente := ""
Private cDir     := ""
Private cDirMsg := ""
Private cArq     := ""
Private cBcoAg1  := ""
Private cBcoAg2  := ""
Private cBcoAg3  := ""
Private cQI      := ""
Private nRegistro:= 0
Private nPosicao := 0
Private nTotal   := 0
Private nSldAber := 0
Private nVencido := 0
Private nAVencer := 0
Private nDias    := 0
Private nAcord   := 0
Private nContr   := 0
Private nFrota   := 0
Private aFrota   := {}
Private aOS      := {}
Private nPBM     := 0
Private nPBA     := 0
Private nPOM     := 0
Private nPOA     := 0
Private nSOM     := 0
Private nSOA     := 0
Private nVlrPec  := 0
Private nVlrSrv  := 0
Private cVend1   := ""
Private cVend2   := ""
Private cVend3   := ""
Private cQuebra  := "INICIAL"
Private lImpr    := .f.
Private cSeparac := "_"
Private cNor     := space(1)
Private cNeg     := space(1)
Private cLet     := space(1)
Private cCond    := ""
Private cQInf    := ""
Private cDbSelec := ""
Private nRegua   := 0
Private lNroEnd  := ( SA1->(FieldPos("A1_NUMERO")) > 0 )
Private nQtdHis  := 0
Private nMesHis  := 0
Private cDepHis  := ""
Private lA1_IBGE := ( SA1->(FieldPos("A1_IBGE")) > 0 )
Default cPerg    := "VCR500"

wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
EndIf

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
EndIf

VAI->(DbSetOrder(4))
VAI->(DbSeek( xFilial("VAI") + __CUSERID ))

DbSelectArea("SX3")
DbSetOrder(2)
DbSeek("VC2_ASSUNT")
cAssunto := X3CBOX()
While len(cAssunto) > 1
	nTam := If(at(";",cAssunto)==0,len(cAssunto)+1,at(";",cAssunto))
	aAdd(aAssunto,{substr(cAssunto,1,1),substr(cAssunto,3,nTam-3)})
	cAssunto := Alltrim(substr(cAssunto,nTam+1,len(cAssunto)))
EndDo
If cPRW == "VEICR500"
	DbSelectArea("VC1")
	DbSetOrder(4)
	DbSeek(xFilial("VC1")+MV_PAR01+MV_PAR04+Dtos(MV_PAR02),.T.)
	cCond := 'VC1->VC1_FILIAL == xFilial("VC1") .and. ( Empty(MV_PAR01) .or. VC1->VC1_TIPAGE == MV_PAR01 ) .and. ( Empty(MV_PAR04) .or. VC1->VC1_CODVEN == MV_PAR04 ) .and. VC1->VC1_DATAGE >= MV_PAR02 .and. VC1->VC1_DATAGE <= MV_PAR03'
	cQInf := MV_PAR07
	nQtdHis := MV_PAR08
	nMesHis := MV_PAR09
	cDepHis := MV_PAR10
	cDbSelec := "VC1"
Else
	DbSelectArea("VCF")
	DbSetOrder(1)
	DbSeek(xFilial("VCF")+Alltrim(MV_PAR02+MV_PAR03))
	cCond := 'VCF->VCF_FILIAL == xFilial("VCF") .and. ( Empty(MV_PAR02+MV_PAR03) .or. VCF->VCF_CODCLI+VCF->VCF_LOJCLI == MV_PAR02+MV_PAR03 )'
	cQInf := MV_PAR04
	nQtdHis := MV_PAR08
	nMesHis := MV_PAR09
	cDepHis := MV_PAR10
	cDbSelec := "VCF"
EndIf
nRegua := 0
ProcRegua((RecCount()/10))
While !Eof() .and. &cCond
	nRegua++
	If nRegua == 10
		nRegua := 0
		If cPRW == "VEICR500"
			IncProc(STR0001)
		Else
			IncProc(STR0075)
		EndIf
	EndIf
	If cPRW == "VEICR500"
		If VC1->VC1_EMIFIC # "0"
			DbSelectArea("VC1")
			DbSkip()
			Loop
		EndIf
		If !Empty(Alltrim(MV_PAR05+MV_PAR06))
			If (VC1->VC1_CODCLI+VC1->VC1_LOJA) # (MV_PAR05+MV_PAR06)
				DbSelectArea("VC1")
				DbSkip()
				Loop
			EndIf
		EndIf
		DbSelectArea("VCF")
		DbSetOrder(1)
		DbSeek( xFilial("VCF") + VC1->VC1_CODCLI + VC1->VC1_LOJA )
		DbSelectArea("VC5")
		DbSetOrder(1)
		DbSeek( xFilial("VC5") + VC1->VC1_TIPAGE )
		DbSelectArea("SA3")
		DbSetOrder(1)
		DbSeek( xFilial("SA3") + VC1->VC1_CODVEN )
		cFicCont := VC1->VC1_CODCLI+" "+VC1->VC1_LOJA+" "+Transform(VC1->VC1_DATAGE,"@D")+" "+VC1->VC1_TIPAGE
		cCliente := VC1->VC1_CODCLI + VC1->VC1_LOJA
	Else
		If !Empty(MV_PAR05) .and. VCF->VCF_NIVIMP # MV_PAR05
			DbSelectArea("VCF")
			DbSkip()
			Loop
		EndIf
		If !Empty(MV_PAR06) .and. VCF->VCF_CODSEG # MV_PAR06
			DbSelectArea("VCF")
			DbSkip()
			Loop
		EndIf
		If !Empty(MV_PAR07)
			If "*" $ MV_PAR07
				If left(VCF->VCF_AREVEN,1) # left(MV_PAR07,1)
					DbSelectArea("VCF")
					DbSkip()
					Loop
				EndIf
			Else
				If VCF->VCF_AREVEN # MV_PAR07
					DbSelectArea("VCF")
					DbSkip()
					Loop
				EndIf
			EndIf
		EndIf
		If !Empty(MV_PAR12) // Vendedor
			If lNewVend
				If !( MV_PAR12 $ (VCF->VCF_VENPEC+"/"+VCF->VCF_VENSRV+"/"+VCF->VCF_VENVEI+"/"+VCF->VCF_VENVEU+"/"+VCF->VCF_VENPNE+"/"+VCF->VCF_VENOUT) )
					DbSelectArea("VCF")
					DbSkip()
					Loop
				EndIf
			Else
				If !( MV_PAR12 $ (VCF->VCF_VENPEC+"/"+VCF->VCF_VENVEI+"/"+VCF->VCF_VENSRV) )
					DbSelectArea("VCF")
					DbSkip()
					Loop
				EndIf
			EndIf
		EndIf
		DbSelectArea("VC5")
		DbSetOrder(1)
		DbSeek( xFilial("VC5") + MV_PAR01 )
		cFicCont := " "+STR0091+"  "+VCF->VCF_CODCLI+"-"+VCF->VCF_LOJCLI+" "
		cCliente := VCF->VCF_CODCLI + VCF->VCF_LOJCLI
	EndIf
	If lCEVOUT .and. VAI->VAI_CEVOUT == "0"
		If cPRW == "VEICR500"
			If VAI->VAI_CODVEN<>VC1->VC1_CODVEN // Vendedor
				DbSelectArea("VC1")
				DbSkip()
				Loop
			EndIf
		Else
			If !Empty(MV_PAR12) .and. VAI->VAI_CODVEN<>MV_PAR12 // Vendedor
				DbSelectArea("VCF")
				DbSkip()
				Loop
			EndIf
		EndIf

		If lNewVend
			If !Empty(VCF->VCF_VENSRV+VCF->VCF_VENPEC+VCF->VCF_VENVEI+VCF->VCF_VENVEU+VCF->VCF_VENPNE+VCF->VCF_VENOUT)
				If !( VAI->VAI_CODVEN $ ( VCF->VCF_VENSRV+"/"+VCF->VCF_VENPEC+"/"+VCF->VCF_VENVEI+"/"+VCF->VCF_VENVEU+"/"+VCF->VCF_VENPNE+"/"+VCF->VCF_VENOUT ) )
					If cPRW == "VEICR500"
						DbSelectArea("VC1")
					Else
						DbSelectArea("VCF")
					EndIf
					DbSkip()
					Loop
				EndIf
			EndIf		
		Else
			If !Empty(VCF->VCF_VENSRV+VCF->VCF_VENPEC+VCF->VCF_VENVEI)
				If !( VAI->VAI_CODVEN $ ( VCF->VCF_VENSRV+"/"+VCF->VCF_VENPEC+"/"+VCF->VCF_VENVEI ) )
					If cPRW == "VEICR500"
						DbSelectArea("VC1")
					Else
						DbSelectArea("VCF")
					EndIf
					DbSkip()
					Loop
				EndIf
			EndIf
		EndIf
	EndIf
	lImpr := .t.

	If lVCF_GRUECN
		VQK->(DbSeek(xFilial("VQK")+VCF->VCF_GRUECN))
	Endif
	
	DbSelectArea("SA1")
	DbSetOrder(1)
	DbSeek( xFilial("SA1") + cCliente )
	If lA1_IBGE
		DbSelectArea("VAM")
		DbSetOrder(1)
		DbSeek( xFilial("VAM") + SA1->A1_IBGE )
	EndIf
	aContato := {}
	cContato := ""
	aImpress := {}
	DbSelectArea("VC2")
	DbSetOrder(1)
	DbSeek( xFilial("VC2") + cCliente )
	While !Eof().and. VC2->VC2_FILIAL == xFilial("VC2") .and. ( VC2->VC2_CODCLI+VC2->VC2_LOJA == cCliente )
		If VC2->VC2_RELFIC == "0"
			nPos := aScan(aAssunto,{|x| x[1] == VC2->VC2_ASSUNT })
			If nPos > 0
				cAssunto := left(aAssunto[nPos,2]+space(20),20)
			Else
				cAssunto := space(20)
			EndIf
			aAdd(aContato,{"  "+left(VC2->VC2_NOMCON+"  "+VC2->VC2_GRAINF+"  "+VC2->VC2_CARCON+"  "+VC2->VC2_PERFIL+"    "+cAssunto+"  "+VC2->VC2_DDDCEL+"  "+VC2->VC2_TELCEL+" "+left(Transform(VC2->VC2_DATNAS,"@D"),5)+space(128),128)+"  "})
			If VC2->VC2_PRICON == "1"
				cContato := left(VC2->VC2_NOMCON,20)
			EndIf
		EndIf
		DbSelectArea("VC2")
		DbSkip()
	EndDo
	aSM0 := FWArrFilAtu(cEmpAnt,cFilAnt) // Filial Origem (Filial logada)
	If cPRW == "VEICR500"
		aAdd(aImpress,{repl(cSeparac,132)})
		aAdd(aImpress,{space(104)+"[ "+cFicCont+" ]  "})
		aAdd(aImpress,{"  "+left(aSM0[6]+space(5)+STR0002+space(13)+left(SA1->A1_NREDUZ,20)+space(9)+STR0003+left(SA3->A3_NREDUZ,14)+" "+VC1->VC1_CODVEN+space(128),128)+"  "})
		aAdd(aImpress,{"  "+left(aSM0[2]+space(5)+left(VC5->VC5_DTPAGE+space(28),28)+If(!Empty(cContato),space(18)+STR0004+cContato,"")+space(103),103)+STR0005+Transform(If(VCF->VCF_DIAPER>0,VCF->VCF_DIAPER,VC5->VC5_DIAPER),"@E 9999")+STR0006+"  "})
	Else
		aAdd(aImpress,{repl(cSeparac,132)})
		aAdd(aImpress,{space(104)+"[ "+cFicCont+" ]  "})
		aAdd(aImpress,{"  "+left(aSM0[6]+space(8)+STR0076+space(15)+left(SA1->A1_NREDUZ,20)+space(128),128)+"  "})
		aAdd(aImpress,{"  "+left(aSM0[2]+space(33)+If(!Empty(cContato),space(18)+STR0004+cContato,"")+space(103),103)+If(VCF->VCF_DIAPER>0,STR0005+Transform(VCF->VCF_DIAPER,"@E 9999")+STR0006,space(25))+"  "})
	EndIf
	aAdd(aImpress,{repl(cSeparac,132)})
	
	cQI := " " // Quadro de Informacoes
	
	For nQI := 1 to len(cQInf)
		
		cQI := substr(cQInf,nQI,1)
		
		Do Case
			
			Case ( "A" == cQI )
				aAdd(aImpress,{space(125)+"[ A ]  "})
				If cPRW == "VEICR500"
					aAdd(aImpress,{"  "+STR0007+left(SA1->A1_NOME+space(50),50)+left(SA1->A1_NREDUZ+space(30),30)+STR0008+left(OFIOA560DS("033",VCF->VCF_CODSEG),20)+STR0009+VCF->VCF_NIVIMP+"   "})
					aAdd(aImpress,{"  "+STR0010+left(left(Alltrim(SA1->A1_END)+If(lNroEnd,", "+SA1->A1_NUMERO,"")+space(50),50)+" "+left(SA1->A1_BAIRRO,20)+STR0011+Transform(SA1->A1_CEP,"@R 99999-999")+" "+Alltrim(If(lA1_IBGE,VAM->VAM_DESCID,SA1->A1_MUN))+"-"+If(lA1_IBGE,VAM->VAM_ESTADO,SA1->A1_EST)+space(112),112)+STR0012+VCF->VCF_AREVEN+"  "})
				Else
					aAdd(aImpress,{"  "+STR0007+left(SA1->A1_NOME+space(80),80)+STR0008+left(OFIOA560DS("033",VCF->VCF_CODSEG),20)+STR0009+VCF->VCF_NIVIMP+"   "})
					aAdd(aImpress,{"  "+STR0010+left(left(Alltrim(SA1->A1_END)+If(lNroEnd,", "+SA1->A1_NUMERO,"")+space(50),50)+" "+left(SA1->A1_BAIRRO,20)+STR0011+Transform(SA1->A1_CEP,"@R 99999-999")+" "+Alltrim(If(lA1_IBGE,VAM->VAM_DESCID,SA1->A1_MUN))+"-"+If(lA1_IBGE,VAM->VAM_ESTADO,SA1->A1_EST)+space(112),112)+STR0012+VCF->VCF_AREVEN+"  "})
				EndIf
				If lVCF_GRUECN
					aAdd(aImpress,{"  "+left(STR0013+SA1->A1_TEL+" "+Alltrim(SA1->A1_CONTATO)+" "+If(SA1->(FieldPos("A1_CELULAR"))#0,SA1->A1_CELULAR,"")+" "+If(SA1->(FieldPos("A1_TELCOM"))#0,SA1->A1_TELCOM,"")+" "+SA1->A1_TELEX+" "+STR0014+SA1->A1_FAX+STR0093+VQK->VQK_CODIGO+"-"+VQK->VQK_DESCRI+space(128),128)+"  "})
				Else
					aAdd(aImpress,{"  "+left(STR0013+SA1->A1_TEL+" "+Alltrim(SA1->A1_CONTATO)+" "+If(SA1->(FieldPos("A1_CELULAR"))#0,SA1->A1_CELULAR,"")+" "+If(SA1->(FieldPos("A1_TELCOM"))#0,SA1->A1_TELCOM,"")+" "+SA1->A1_TELEX+"     "+STR0014+SA1->A1_FAX+space(128),128)+"  "})
				Endif
				aAdd(aImpress,{"  "+left(If(Len(Alltrim(SA1->A1_CGC))>12,STR0015,STR0016)+Transform(SA1->A1_CGC,If(Len(Alltrim(SA1->A1_CGC))>12,"@!R NN.NNN.NNN/NNNN-99","@R 999.999.999-99"))+" "+Alltrim(SA1->(RetTitle("A1_RG")))+":"+SA1->A1_RG+" "+STR0084+SA1->A1_INSCR+STR0085+SA1->A1_INSCRM+If(SA1->(FieldPos("A1_INSCRUR"))#0,STR0086+SA1->A1_INSCRUR,"")+space(128),128)+"  "})
				aAdd(aImpress,{"  "+left(Alltrim(SA1->(RetTitle("A1_EMAIL")))+":"+SA1->A1_EMAIL+" "+Alltrim(SA1->(RetTitle("A1_HPAGE")))+":"+SA1->A1_HPAGE+space(128),128)+"  "})
				cVend1 := space(16)
				cVend2 := space(16)
				cVend3 := space(16)
				If !Empty(VCF->VCF_VENVEI)
					DbSelectArea("SA3")
					DbSetOrder(1)
					DbSeek( xFilial("SA3") + VCF->VCF_VENVEI )
					cVend1 := left(SA3->A3_NREDUZ,16)
				EndIf
				If !Empty(VCF->VCF_VENPEC)
					DbSelectArea("SA3")
					DbSetOrder(1)
					DbSeek( xFilial("SA3") + VCF->VCF_VENPEC )
					cVend2 := left(SA3->A3_NREDUZ,16)
				EndIf
				If !Empty(VCF->VCF_VENSRV)
					DbSelectArea("SA3")
					DbSetOrder(1)
					DbSeek( xFilial("SA3") + VCF->VCF_VENSRV )
					cVend3 := left(SA3->A3_NREDUZ,16)
				EndIf
				If !Empty(Alltrim(cVend1+cVend2+cVend3))
					aAdd(aImpress,{"  "+STR0017+STR0019+VCF->VCF_VENVEI+" "+cVend1+STR0018+VCF->VCF_VENPEC+" "+cVend2+STR0020+VCF->VCF_VENSRV+" "+cVend3+"  "})
				EndIf
				If lNewVend
					cVend1 := space(16)
					cVend2 := space(16)
					cVend3 := space(16)
					If !Empty(VCF->VCF_VENVEU)
						DbSelectArea("SA3")
						DbSetOrder(1)
						DbSeek( xFilial("SA3") + VCF->VCF_VENVEU )
						cVend1 := left(SA3->A3_NREDUZ,16)
					EndIf
					If !Empty(VCF->VCF_VENPNE)
						DbSelectArea("SA3")
						DbSetOrder(1)
						DbSeek( xFilial("SA3") + VCF->VCF_VENPNE )
						cVend2 := left(SA3->A3_NREDUZ,16)
					EndIf
					If !Empty(VCF->VCF_VENOUT)
						DbSelectArea("SA3")
						DbSetOrder(1)
						DbSeek( xFilial("SA3") + VCF->VCF_VENOUT )
						cVend3 := left(SA3->A3_NREDUZ,16)
					EndIf
					If !Empty(Alltrim(cVend1+cVend2+cVend3))
						aAdd(aImpress,{"  "+space(len(STR0017))+STR0094+VCF->VCF_VENVEU+" "+cVend1+STR0095+VCF->VCF_VENPNE+" "+cVend2+STR0096+VCF->VCF_VENOUT+" "+cVend3+"  "})
					EndIf
				EndIf
				aAdd(aImpress,{repl(cSeparac,132)})
				
			Case ( "B" == cQI )
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ B ]  "})
					aAdd(aImpress,{"  "+left(STR0021+space(128),128)+"  "})
				Else
					aAdd(aImpress,{space(125)+"[ B ]  "})
					aAdd(aImpress,{"  "+left(STR0021+space(128),128)+"  "})
				EndIf
				If Len(aContato) > 0
					For ni := 1 to Len(aContato)
						aAdd(aImpress,{aContato[ni,1]})
					Next
				Else
					aAdd(aImpress,{"  "+space(128)+"  "})
				EndIf
				aAdd(aImpress,{repl(cSeparac,132)})
				
			Case ( "C" == cQI )
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ C ]  "})
					aAdd(aImpress,{"  "+left(STR0022+space(128),128)+"  "})
				Else
					aAdd(aImpress,{space(125)+"[ C ]  "})
					aAdd(aImpress,{"  "+left(STR0022+space(128),128)+"  "})
				EndIf
				If !Empty(VCF->VCF_SOCIO1+VCF->VCF_SOCIO2+VCF->VCF_SOCIO3)
					If !Empty(VCF->VCF_SOCIO1)
						aAdd(aImpress,{"  "+left(VCF->VCF_SOCIO1+space(128),128)+"  "})
					EndIf
					If !Empty(VCF->VCF_SOCIO2)
						aAdd(aImpress,{"  "+left(VCF->VCF_SOCIO2+space(128),128)+"  "})
					EndIf
					If !Empty(VCF->VCF_SOCIO3)
						aAdd(aImpress,{"  "+left(VCF->VCF_SOCIO3+space(128),128)+"  "})
					EndIf
				Else
					aAdd(aImpress,{"  "+space(128)+"  "})
				EndIf
				aAdd(aImpress,{repl(cSeparac,132)})
				
			Case ( "D" == cQI )
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ D ]  "})
					aAdd(aImpress,{"  "+STR0023+STR0024+left(VCF->VCF_PRICL1+space(70),70)+"  "})
				Else
					aAdd(aImpress,{space(125)+"[ D ]  "})
					aAdd(aImpress,{"  "+STR0023+STR0024+left(VCF->VCF_PRICL1+space(70),70)+"  "})
				EndIf
				aAdd(aImpress,{"  "+left(substr(VCF->VCF_RECVIS, 1,8)+Transform(val(substr(VCF->VCF_RECVIS, 9,7)),"@E 999,999,999.99")+Transform(12*val(substr(VCF->VCF_RECVIS, 9,7)),"@E 9999,999,999.99")+space(48),48)+space(10)+left(VCF->VCF_PRICL2+space(70),70)+"  "})
				aAdd(aImpress,{"  "+left(substr(VCF->VCF_RECVIS,16,8)+Transform(val(substr(VCF->VCF_RECVIS,24,7)),"@E 999,999,999.99")+Transform(12*val(substr(VCF->VCF_RECVIS,24,7)),"@E 9999,999,999.99")+space(48),48)+space(10)+left(VCF->VCF_PRICL3+space(70),70)+"  "})
				If cPRW == "VEICR500"
					aAdd(aImpress,{"  "+left(substr(VCF->VCF_RECVIS,31,8)+Transform(val(substr(VCF->VCF_RECVIS,39,7)),"@E 999,999,999.99")+Transform(12*val(substr(VCF->VCF_RECVIS,39,7)),"@E 9999,999,999.99")+space(48),48)+STR0025+left(VCF->VCF_PRIFO1+space(70),70)+"  "})
				Else
					aAdd(aImpress,{"  "+left(substr(VCF->VCF_RECVIS,31,8)+Transform(val(substr(VCF->VCF_RECVIS,39,7)),"@E 999,999,999.99")+Transform(12*val(substr(VCF->VCF_RECVIS,39,7)),"@E 9999,999,999.99")+space(48),48)+STR0025+left(VCF->VCF_PRIFO1+space(70),70)+"  "})
				EndIf
				aAdd(aImpress,{"  "+left(substr(VCF->VCF_RECVIS,46,8)+Transform(val(substr(VCF->VCF_RECVIS,54,7)),"@E 999,999,999.99")+Transform(12*val(substr(VCF->VCF_RECVIS,54,7)),"@E 9999,999,999.99")+space(48),48)+space(10)+left(VCF->VCF_PRIFO2+space(70),70)+"  "})
				aAdd(aImpress,{"  "+left(substr(VCF->VCF_RECVIS,61,8)+Transform(val(substr(VCF->VCF_RECVIS,69,7)),"@E 999,999,999.99")+Transform(12*val(substr(VCF->VCF_RECVIS,69,7)),"@E 9999,999,999.99")+space(48),48)+space(10)+left(VCF->VCF_PRIFO3+space(70),70)+"  "})
				aAdd(aImpress,{repl(cSeparac,132)})
				
			Case ( "E" == cQI )
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ E ]  "})
					aAdd(aImpress,{"  "+left(STR0026+space(38),38)+left(STR0027+space(90),90)+"  "})
				Else
					aAdd(aImpress,{space(125)+"[ E ]  "})
					aAdd(aImpress,{"  "+left(STR0026+space(38),38)+left(STR0027+space(90),90)+"  "})
				EndIf
				If !Empty(VCF->VCF_FIL_01) .or. !Empty(VCF->VCF_EMPCO1)
					aAdd(aImpress,{"  "+left(VCF->VCF_FIL_01+space(37),37)+" "+left(VCF->VCF_EMPCO1+space(90),90)+"  "})
					If !Empty(VCF->VCF_FIL_02) .or. !Empty(VCF->VCF_EMPCO2)
						aAdd(aImpress,{"  "+left(VCF->VCF_FIL_02+space(37),37)+" "+left(VCF->VCF_EMPCO2+space(90),90)+"  "})
						If !Empty(VCF->VCF_FIL_03) .or. !Empty(VCF->VCF_EMPCO3)
							aAdd(aImpress,{"  "+left(VCF->VCF_FIL_03+space(37),37)+" "+left(VCF->VCF_EMPCO3+space(90),90)+"  "})
						EndIf
					EndIf
				Else
					aAdd(aImpress,{"  "+space(128)+"  "})
				EndIf
				aAdd(aImpress,{repl(cSeparac,132)})
				
			Case ( "F" == cQI )
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ F ]  "})
					aAdd(aImpress,{"  "+left(STR0028+space(128),128)+"  "})
				Else
					aAdd(aImpress,{space(125)+"[ F ]  "})
					aAdd(aImpress,{"  "+left(STR0028+space(128),128)+"  "})
				EndIf
				cBcoAg1 := space(42)
				cBcoAg2 := space(42)
				cBcoAg3 := space(42)
				If !Empty(VCF->VCF_BCOAG1)
					DbSelectArea("SA6")
					DbSetOrder(1)
					If DbSeek( xFilial("SA6") + substr(VCF->VCF_BCOAG1,1,3) )
						cBcoAg1 := left(substr(VCF->VCF_BCOAG1,1,3)+" - "+left(SA6->A6_NOME,15)+STR0029+substr(VCF->VCF_BCOAG1,4,4)+space(42),42)
					Else	       
						cBcoAg1 := left(VCF->VCF_BCOAG1+" - "+space(15)+STR0029+space(4)+space(42),42)
					EndIf
				EndIf
				If !Empty(VCF->VCF_BCOAG2)
					DbSelectArea("SA6")
					DbSetOrder(1)
					If DbSeek( xFilial("SA6") + substr(VCF->VCF_BCOAG2,1,3) )
						cBcoAg2 := left(substr(VCF->VCF_BCOAG2,1,3)+" - "+left(SA6->A6_NOME,15)+STR0029+substr(VCF->VCF_BCOAG2,4,4)+space(42),42)
					Else	        
						cBcoAg2 := left(VCF->VCF_BCOAG2+" - "+space(15)+STR0029+space(4)+space(42),42)
					EndIf
				EndIf
				If !Empty(VCF->VCF_BCOAG3)
					DbSelectArea("SA6")
					DbSetOrder(1)
					If DbSeek( xFilial("SA6") + substr(VCF->VCF_BCOAG3,1,3) )
						cBcoAg3 := left(substr(VCF->VCF_BCOAG3,1,3)+" - "+left(SA6->A6_NOME,15)+STR0029+substr(VCF->VCF_BCOAG3,4,4)+space(42),42)
					Else
						cBcoAg3 := left(VCF->VCF_BCOAG3+" - "+space(15)+STR0029+space(4)+space(42),42)
					EndIf
				EndIf
				aAdd(aImpress,{"  "+cBcoAg1+" "+cBcoAg2+" "+cBcoAg3+"  "})
				aAdd(aImpress,{repl(cSeparac,132)})
				
			Case ( "G" == cQI )
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ G ]  "})
					aAdd(aImpress,{"  "+left(STR0030+space(110),110)+STR0032+" "+STR0092+"         "})
				Else
					aAdd(aImpress,{space(125)+"[ G ]  "})
					aAdd(aImpress,{"  "+left(STR0030+space(110),110)+STR0032+" "+STR0092+"         "})
				EndIf
				nTotal := 0
				nFrota := 0
				aFrota := {}
				DbSelectArea("VC3")
				DbSetOrder(1)
				If DbSeek( xFilial("VC3") + cCliente )
					While !Eof() .and. VC3->VC3_FILIAL == xFilial("VC3") .and. ( VC3->VC3_CODCLI+VC3->VC3_LOJA == cCliente )
						If VC3->VC3_TIPO == "1" .and. Empty(VC3->VC3_DATVEN) // Veiculos
							DbSelectArea("VV2")
							DbSetOrder(1)
							If DbSeek( xFilial("VV2") + VC3->VC3_CODMAR + VC3->VC3_MODVEI )
								cDesc := left(VV2->VV2_DESMOD+space(20),20)
							Else
								cDesc := left(VC3->VC3_MODVEI+space(20),20)
							EndIf
							DbSelectArea("VVB")
							DbSetOrder(1)
							DbSeek( xFilial("VVB") + VV2->VV2_CATVEI )
							DbSelectArea("VCI")
							DbSetOrder(1)
							DbSeek( xFilial("VCI") + VC3->VC3_CODOPE )
							aAdd(aFrota,{left(VC3->VC3_CODMAR+" "+cDesc+" "+left(VVB->VVB_DESCRI,15)+" "+left(VCI->VCI_DESOPE,15)+" "+Transform(VC3->VC3_FABMOD,"@R 9999/9999")+"  "+Transform(VC3->VC3_DATAQU,"@D")+"  "+Transform(VC3->VC3_TERPAG,"@R 99/9999")+Transform(VC3->VC3_KMMES,"@E 9999999,999")+Transform(VC3->VC3_KMLIT,"@E 999999.9")+space(110),110)+str(VC3->VC3_QTDFRO,6)+" "+Dtoc(VC3->VC3_DATATU),VC3->VC3_CODMAR+VC3->VC3_FABMOD+left(VVB->VVB_DESCRI,15)+cDesc})
							nTotal += VC3->VC3_QTDFRO
							If !Empty(VC3->VC3_FABMOD)
								nFrota += (((year(dDataBase)-val(left(VC3->VC3_FABMOD,4)))+1)*VC3->VC3_QTDFRO)
							EndIf
						EndIf
						DbSelectArea("VC3")
						DbSkip()
					EndDo
					If nTotal > 0
						aSort(aFrota,1,,{|x,y| x[2] < y[2] })
						For ni := 1 to len(aFrota)
							aAdd(aImpress,{"  "+aFrota[ni,1]+"         "})
						Next
						If cPRW == "VEICR500"
							aAdd(aImpress,{"  "+space(45)+STR0033+Transform((nFrota/nTotal),"@E 9999999.9")+STR0034+space(24)+STR0035+Transform(nTotal,"@E 999999,999")+"         "})
						Else
							aAdd(aImpress,{"  "+space(45)+STR0033+Transform((nFrota/nTotal),"@E 9999999.9")+STR0034+space(24)+STR0035+Transform(nTotal,"@E 999999,999")+"         "})
						EndIf
					Else
						aAdd(aImpress,{"  "+space(128)+"  "})
					EndIf
				Else
					aAdd(aImpress,{"  "+space(128)+"  "})
				EndIf
				aAdd(aImpress,{repl(cSeparac,132)})
				
			Case ( "H" == cQI )
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ H ]  "})
					aAdd(aImpress,{"  "+left(STR0031+space(110),110)+STR0032+" "+STR0092+"         "})
				Else
					aAdd(aImpress,{space(125)+"[ H ]  "})
					aAdd(aImpress,{"  "+left(STR0031+space(110),110)+STR0032+" "+STR0092+"         "})
				EndIf
				nTotal := 0
				nFrota := 0
				aFrota := {}
				DbSelectArea("VC3")
				DbSetOrder(1)
				If DbSeek( xFilial("VC3") + cCliente )
					While !Eof() .and. VC3->VC3_FILIAL == xFilial("VC3") .and. ( VC3->VC3_CODCLI+VC3->VC3_LOJA == cCliente )
						If VC3->VC3_TIPO == "0" .and. Empty(VC3->VC3_DATVEN) // Equipamentos
							DbSelectArea("VV2")
							DbSetOrder(1)
							If DbSeek( xFilial("VV2") + VC3->VC3_CODMAR + VC3->VC3_MODVEI )
								cDesc := left(VV2->VV2_DESMOD+space(20),20)
							Else
								cDesc := left(VC3->VC3_MODVEI+space(20),20)
							EndIf
							DbSelectArea("VVB")
							DbSetOrder(1)
							DbSeek( xFilial("VVB") + VV2->VV2_CATVEI )
							DbSelectArea("VCI")
							DbSetOrder(1)
							DbSeek( xFilial("VCI") + VC3->VC3_CODOPE )
							aAdd(aFrota,{left(VC3->VC3_CODMAR+" "+cDesc+" "+left(VVB->VVB_DESCRI,15)+" "+left(VCI->VCI_DESOPE,15)+" "+Transform(VC3->VC3_FABMOD,"@R 9999/9999")+"  "+Transform(VC3->VC3_DATAQU,"@D")+"  "+Transform(VC3->VC3_TERPAG,"@R 99/9999")+Transform(VC3->VC3_KMMES,"@E 9999999,999")+Transform(VC3->VC3_KMLIT,"@E 999999.9")+space(110),110)+str(VC3->VC3_QTDFRO,6)+" "+Dtoc(VC3->VC3_DATATU),VC3->VC3_CODMAR+VC3->VC3_FABMOD+left(VVB->VVB_DESCRI,15)+cDesc})
							nTotal += VC3->VC3_QTDFRO
							If !Empty(VC3->VC3_FABMOD)
								nFrota += (((year(dDataBase)-val(left(VC3->VC3_FABMOD,4)))+1)*VC3->VC3_QTDFRO)
							EndIf
						EndIf
						DbSelectArea("VC3")
						DbSkip()
					EndDo
					If nTotal > 0
						aSort(aFrota,1,,{|x,y| x[2] < y[2] })
						For ni := 1 to len(aFrota)
							aAdd(aImpress,{"  "+aFrota[ni,1]+"         "})
						Next
						If cPRW == "VEICR500"
							aAdd(aImpress,{"  "+space(45)+STR0033+Transform((nFrota/nTotal),"@E 9999999.9")+STR0034+space(24)+STR0035+Transform(nTotal,"@E 999999,999")+"         "})
						Else
							aAdd(aImpress,{"  "+space(45)+STR0033+Transform((nFrota/nTotal),"@E 9999999.9")+STR0034+space(24)+STR0035+Transform(nTotal,"@E 999999,999")+"         "})
						EndIf
					Else
						aAdd(aImpress,{"  "+space(128)+"  "})
					EndIf
				Else
					aAdd(aImpress,{"  "+space(128)+"  "})
				EndIf
				aAdd(aImpress,{repl(cSeparac,132)})
				
			Case ( "I" == cQI )
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ I ]  "})
					aAdd(aImpress,{"  "+left(STR0036+space(128),128)+"  "})
					aAdd(aImpress,{"  "+STR0037+str(VCF->VCF_QTDFR3,3)+space(20)+STR0038+str(VCF->VCF_PERFT3,3)+" %"+space(20)+STR0039+str(VCF->VCF_PERVC3,3)+" %      "})
				Else
					aAdd(aImpress,{space(125)+"[ I ]  "})
					aAdd(aImpress,{"  "+left(STR0036+space(128),128)+"  "})
					aAdd(aImpress,{"  "+STR0037+str(VCF->VCF_QTDFR3,3)+space(20)+STR0038+str(VCF->VCF_PERFT3,3)+" %"+space(20)+STR0039+str(VCF->VCF_PERVC3,3)+" %      "})
				EndIf
				aAdd(aImpress,{repl(cSeparac,132)})
				
			Case ( "J" == cQI )
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ J ]  "})
					aAdd(aImpress,{"  "+left(STR0040+space(128),128)+"  "})
				Else
					aAdd(aImpress,{space(125)+"[ J ]  "})
					aAdd(aImpress,{"  "+left(STR0040+space(128),128)+"  "})
				EndIf
				DbSelectArea("VCC")
				DbSetOrder(2)
				If DbSeek( xFilial("VCC") + cCliente )
					While !Eof() .and. VCC->VCC_FILIAL == xFilial("VCC") .and. ( VCC->VCC_CODCLI+VCC->VCC_LOJA == cCliente )
						DbSelectArea("VV4")
						DbSetOrder(1)
						DbSeek( xFilial("VV4") + VCC->VCC_EMPCON )
						DbSelectArea("VV2")
						DbSetOrder(1)
						DbSeek( xFilial("VV2") + VCC->VCC_CODMAR + VCC->VCC_MODVEI )
						aAdd(aImpress,{"  "+left(left(VV4->VV4_DESCRI,20)+"  "+VCC->VCC_CODMAR+" "+left(VV2->VV2_DESMOD,20)+"    "+VCC->VCC_CODGRU+"   "+VCC->VCC_NUMCOT+"   "+Transform(VCC->VCC_DATCTP,"@D")+Transform(VCC->VCC_VALCRE,"@E 99999,999,999,999.99")+"   "+Transform(VCC->VCC_ENCGRU,"@D")+space(128),128)+"  "})
						DbSelectArea("VCC")
						DbSkip()
					EndDo
				Else
					aAdd(aImpress,{"  "+space(128)+"  "})
				EndIf
				aAdd(aImpress,{repl(cSeparac,132)})
				
			Case ( "K" == cQI )
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ K ]  "})
					aAdd(aImpress,{"  "+left(STR0041+space(128),128)+"  "})
				Else
					aAdd(aImpress,{space(125)+"[ K ]  "})
					aAdd(aImpress,{"  "+left(STR0041+space(128),128)+"  "})
				EndIf
				DbSelectArea("VC6")
				DbSetOrder(2)
				If DbSeek( xFilial("VC6") + cCliente )
					While !Eof() .and. VC6->VC6_FILIAL == xFilial("VC6") .and. ( VC6->VC6_CODCLI+VC6->VC6_LOJA == cCliente )
						DbSelectArea("VC9")
						DbSetOrder(1)
						DbSeek( xFilial("VC9") + VC6->VC6_SEGURA )
						DbSelectArea("VCG")
						DbSetOrder(1)
						DbSeek( xFilial("VCG") + VC6->VC6_CORRET )
						DbSelectArea("VC8")
						DbSetOrder(1)
						DbSeek( xFilial("VC8") + VC6->VC6_TIPSEG )
						DbSelectArea("VV2")
						DbSetOrder(1)
						DbSeek( xFilial("VV2") + VC6->VC6_CODMAR + VC6->VC6_MODVEI )
						aAdd(aImpress,{"  "+left(VC6->VC6_CODMAR+" "+left(VV2->VV2_DESMOD,20)+"  "+Transform(VC6->VC6_FABMOD,"@R 9999/9999")+"  "+left(VC9->VC9_DESSEG,20)+"  "+left(VCG->VCG_DESCOR,20)+"  "+Transform(VC6->VC6_VENSEG,"@D")+"  "+left(VC8->VC8_DESSEG,15)+space(128),128)+"  "})
						DbSelectArea("VC6")
						DbSkip()
					EndDo
				Else
					aAdd(aImpress,{"  "+space(128)+"  "})
				EndIf
				aAdd(aImpress,{repl(cSeparac,132)})
				
			Case ( "L" == cQI )
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ L ]  "})
					aAdd(aImpress,{"  "+left(STR0042+space(128),128)+"  "})
				Else
					aAdd(aImpress,{space(125)+"[ L ]  "})
					aAdd(aImpress,{"  "+left(STR0042+space(128),128)+"  "})
				EndIf
				aOS := {}
				aAdd(aOS,{ "" , "" , "" , "" , "" , "" }) // Ultima OS
				aAdd(aOS,{ "" , "" , "" , "" , "" , "" }) // Penultima OS
				DbSelectArea("VO1")
				DbSetOrder(3)
				If DbSeek( xFilial("VO1") + cCliente )
					While !Eof() .and. VO1->VO1_FILIAL == xFilial("VO1") .and. ( VO1->VO1_PROVEI+VO1->VO1_LOJPRO == cCliente )
						For ni := 1 to 6
							aOS[2,ni] := aOS[1,ni]
						Next
						DbSelectArea( "VV1" )
						DbSetOrder(2)
						DbSeek( xFilial("VV1") + VO1->VO1_CHASSI )
						DbSelectArea( "VV2" )
						DbSetOrder(1)
						DbSeek( xFilial("VV2") + VV1->VV1_CODMAR + VV1->VV1_MODVEI )
						aOS[1,1] := VO1->VO1_NUMOSV
						aOS[1,2] := VO1->VO1_STATUS
						aOS[1,3] := VO1->VO1_DATABE
						aOS[1,4] := VO1->VO1_CODMAR
						aOS[1,5] := VO1->VO1_CHASSI
						aOS[1,6] := left(VV2->VV2_DESMOD,30)
						DbSelectArea("VO1")
						DbSkip()
					EndDo
					nVlrPec := 0
					nVlrSrv := 0
					For ni := 1 to 2
						If !Empty(aOS[ni,1])
							nTotal  := 1
							cQuebra := "INICIAL"
							DbSelectArea( "VO2" )
							DbSetOrder(1)
							DbSeek( xFilial("VO2") + aOS[ni,1] )
							While !Eof() .and. (VO2->VO2_NUMOSV == aOS[ni,1])
								If VO2->VO2_TIPREQ # "P"
									DbSelectArea( "VO4" )
									DbSetOrder(1)
									DbSeek( xFilial("VO4") + VO2->VO2_NOSNUM )
									While !Eof() .and. VO4->VO4_NOSNUM == VO2->VO2_NOSNUM
										If cQuebra # VO4->VO4_TIPSER+VO4->VO4_GRUSER+VO4->VO4_CODSER
											cQuebra := VO4->VO4_TIPSER+VO4->VO4_GRUSER+VO4->VO4_CODSER
											DbSelectArea( "VO6" )
											DbSetOrder(2)
											DbSeek( xFilial("VO6") + FG_MARSRV( aOS[ni,4], VO4->VO4_CODSER) + VO4->VO4_CODSER )
											aAdd(aImpress,{"  "+left(If(nTotal==1,Transform(aOS[ni,3],"@D")+STR0043+aOS[ni,1]+" "+aOS[ni,2]+"  ",space(25))+VO4->VO4_TIPSER+" "+VO4->VO4_GRUSER+" "+VO4->VO4_CODSER+" "+substr(VO6->VO6_DESSER,1,30)+" "+aOS[ni,4]+" "+aOS[ni,6]+" "+aOS[ni,5]+space(128),128)+"  "})
											nTotal++
										EndIf
										DbSelectArea("VO4")
										DbSkip()
									EndDo
								EndIf
								DbSelectArea("VO2")
								DbSkip()
							EndDo
							DbSelectArea( "VOO" )
							DbSetOrder(1)
							DbSeek( xFilial("VOO") + aOS[ni,1] )
							While !Eof() .and. VOO->VOO_NUMOSV == aOS[ni,1]
								If ( VOO->VOO_FATPAR+VOO->VOO_LOJA == cCliente )
									DbSelectArea( "SF2" )
									DbSetOrder(1)
									If DbSeek( xFilial("SF2") + VOO->VOO_NUMNFI + VOO->VOO_SERNFI )
										nVlrPec += ( SF2->F2_VALBRUT - SF2->F2_BASEISS )
										nVlrSrv += SF2->F2_BASEISS
									EndIf
								EndIf
								DbSelectArea("VOO")
								DbSkip()
							EndDo
						EndIf
					Next
					If ( ( nVlrPec + nVlrSrv ) > 0 )
						aAdd(aImpress,{"  "+left(space(25)+STR0044+Transform(nVlrPec,"@E 9999999,999.99")+space(8)+STR0045+Transform(nVlrSrv,"@E 9999999,999.99")+space(128),128)+"  "})
					EndIf
					aAdd(aImpress,{"  "+space(128)+"  "})
				Else
					aAdd(aImpress,{"  "+space(128)+"  "})
				EndIf
				DbSelectArea( "VV1" )
				DbSetOrder(5)
				If DbSeek( xFilial("VV1") + cCliente )
					nAcord := 0
					nContr := 0
					While !Eof() .and. VV1->VV1_FILIAL == xFilial("VV1") .and. ( VV1->VV1_PROATU+VV1->VV1_LJPATU == cCliente )
						DbSelectArea("VO5")
						DbSetOrder(1)
						If DbSeek( xFilial("VO5") + VV1->VV1_CHAINT )
							If VO5->VO5_VEIACO == "1" // Contrato
								nContr++
							ElseIf VO5->VO5_VEIACO == "2" // Acordo
								nAcord++
							EndIf
						EndIf
						DbSelectArea("VV1")
						DbSkip()
					EndDo
					If cPRW == "VEICR500"
						aAdd(aImpress,{"  "+STR0046+Transform(nAcord,"@E 99999,999")+STR0048+space(15)+STR0047+Transform(nContr,"@E 99999,999")+STR0048+space(41)+"  "})
					Else
						aAdd(aImpress,{"  "+STR0046+Transform(nAcord,"@E 99999,999")+STR0048+space(15)+STR0047+Transform(nContr,"@E 99999,999")+STR0048+space(41)+"  "})
					EndIf
					aAdd(aImpress,{"  "+space(128)+"  "})
				EndIf
				nPBM := 0 // Pecas Balcao Mes
				nPBA := 0 // Pecas Balcao Ano
				nPOM := 0 // Pecas Oficina Mes
				nPOA := 0 // Pecas Oficina Ano
				nSOM := 0 // Servicos Oficina Mes
				nSOA := 0 // Servicos Oficina Ano
				DbSelectArea("SF2")
				DbSetOrder(2)
				If DbSeek( xFilial("SF2") + cCliente )
					While !Eof() .and. SF2->F2_FILIAL == xFilial("SF2") .and. ( SF2->F2_CLIENTE+SF2->F2_LOJA == cCliente )
						If (SF2->F2_PREFORI $ GetNewPar("MV_PREFBAL","BAL")+GetNewPar("MV_PREFOFI","OFI")) .and. ( SF2->F2_EMISSAO >= (dDataBase-365) )
							DbSelectArea( "SD2" )
							DbSetOrder(3)
							DbSeek( xFilial("SD2") + SF2->F2_DOC + SF2->F2_SERIE + SF2->F2_CLIENTE + SF2->F2_LOJA )
							While !Eof() .and. SD2->D2_FILIAL == xFilial("SD2") .and. ( SD2->D2_DOC + SD2->D2_SERIE + SD2->D2_CLIENTE + SD2->D2_LOJA ) == ( SF2->F2_DOC + SF2->F2_SERIE + SF2->F2_CLIENTE + SF2->F2_LOJA )
								DbSelectArea( "SF4" )
								DbSetOrder(1)
								DbSeek( xFilial("SF4") + SD2->D2_TES )
								If (SF4->F4_DUPLIC == "N")
									DbSelectArea("SF2")
									DbSkip()
									Loop
								EndIf
								If ( SF4->F4_OPEMOV # "05" )
									DbSelectArea("SF2")
									DbSkip()
									Loop
								EndIf
								If SF2->F2_PREFORI == GetNewPar("MV_PREFBAL","BAL") // Balcao
									If !( ( SF2->F2_VALISS == 0 ) .and. ( SF4->F4_ESTOQUE == "S" ) )
										DbSelectArea("SD2")
										DbSkip()
										Loop
									EndIf
									If SF2->F2_EMISSAO >= ( dDataBase-30 )
										nPBM += ((SD2->D2_TOTAL+SD2->D2_DESPESA+SD2->D2_VALFRE+SD2->D2_SEGURO+SD2->D2_VALIPI)-SD2->D2_DESCON)
									EndIf
									If SF2->F2_EMISSAO >= ( dDataBase-365 )
										nPBA += ((SD2->D2_TOTAL+SD2->D2_DESPESA+SD2->D2_VALFRE+SD2->D2_SEGURO+SD2->D2_VALIPI)-SD2->D2_DESCON)
									EndIf
								ElseIf SF2->F2_PREFORI == GetNewPar("MV_PREFOFI","OFI") // Oficina
									If SF2->F2_EMISSAO >= ( dDataBase-30 )
										If SD2->D2_BASEISS == 0
											nPOM += ((SD2->D2_TOTAL+SD2->D2_DESPESA+SD2->D2_VALFRE+SD2->D2_SEGURO+SD2->D2_VALIPI)-SD2->D2_DESCON)
										Else
											nSOM += ((SD2->D2_TOTAL+SD2->D2_DESPESA+SD2->D2_VALFRE+SD2->D2_SEGURO+SD2->D2_VALIPI)-SD2->D2_DESCON)
										EndIf
									EndIf
									If SF2->F2_EMISSAO >= ( dDataBase-365 )
										If SD2->D2_BASEISS == 0
											nPOA += ((SD2->D2_TOTAL+SD2->D2_DESPESA+SD2->D2_VALFRE+SD2->D2_SEGURO+SD2->D2_VALIPI)-SD2->D2_DESCON)
										Else
											nSOA += ((SD2->D2_TOTAL+SD2->D2_DESPESA+SD2->D2_VALFRE+SD2->D2_SEGURO+SD2->D2_VALIPI)-SD2->D2_DESCON)
										EndIf
									EndIf
								EndIf
								DbSelectArea("SD2")
								DbSkip()
							EndDo
						EndIf
						DbSelectArea("SF2")
						DbSkip()
					EndDo
					If cPRW == "VEICR500"
						aAdd(aImpress,{"  "+STR0049+STR0050+Transform(nPBM,"@E 99999,999,999.99")+STR0053+Transform(nPBA,"@E 99999,999,999.99")+STR0054+space(37)+"  "})
						aAdd(aImpress,{"  "+space(17)+STR0051+Transform(nPOM,"@E 99999,999,999.99")+STR0053+Transform(nPOA,"@E 99999,999,999.99")+STR0054+space(37)+"  "})
						aAdd(aImpress,{"  "+space(17)+STR0052+Transform(nSOM,"@E 99999,999,999.99")+STR0053+Transform(nSOA,"@E 99999,999,999.99")+STR0054+space(37)+"  "})
					Else
						aAdd(aImpress,{"  "+STR0049+STR0050+Transform(nPBM,"@E 99999,999,999.99")+STR0053+Transform(nPBA,"@E 99999,999,999.99")+STR0054+space(37)+"  "})
						aAdd(aImpress,{"  "+space(17)+STR0051+Transform(nPOM,"@E 99999,999,999.99")+STR0053+Transform(nPOA,"@E 99999,999,999.99")+STR0054+space(37)+"  "})
						aAdd(aImpress,{"  "+space(17)+STR0052+Transform(nSOM,"@E 99999,999,999.99")+STR0053+Transform(nSOA,"@E 99999,999,999.99")+STR0054+space(37)+"  "})
					EndIf
				EndIf
				aAdd(aImpress,{repl(cSeparac,132)})
				
			Case ( "M" == cQI )
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ M ]  "})
					aAdd(aImpress,{"  "+left(STR0055+space(128),128)+"  "})
				Else
					aAdd(aImpress,{space(125)+"[ M ]  "})
					aAdd(aImpress,{"  "+left(STR0055+space(128),128)+"  "})
				EndIf
				nSldAber := 0
				nVencido := 0
				nAVencer := 0
				nDias    := 0
				DbSelectArea("SE1")
				DbSetOrder(2)
				DbSeek( xFilial("SE1") + cCliente )
				While !Eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and. ( SE1->E1_CLIENTE+SE1->E1_LOJA == cCliente )
					If SE1->E1_SALDO > 0
						nSldAber += SE1->E1_SALDO
						nDias := ( SE1->E1_VENCTO - dDataBase )
						If nDias < 0
							nVencido += SE1->E1_SALDO
						Else
							nAVencer += SE1->E1_SALDO
						EndIf
					EndIf
					DbSelectArea("SE1")
					DbSkip()
				EndDo
				aAdd(aImpress,{"  "+left(space(15)+Transform(SA1->A1_VENCLC,"@D")+space(3)+Transform(SA1->A1_LC,"@E 99999,999,999.99")+space(10)+Transform(nSldAber,"@E 99999,999,999,999.99")+space(5)+Transform(nVencido,"@E 99999,999,999,999.99")+space(5)+Transform(nAVencer,"@E 99999,999,999,999.99")+space(128),128)+"  "})
				aAdd(aImpress,{repl(cSeparac,132)})
				
			Case ( "N" == cQI )
				nValor := 0
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ N ]  "})
					aAdd(aImpress,{"  "+left(STR0056+space(128),128)+"  "})
					aAdd(aImpress,{"  "+STR0057+"[ "+If(VCF->VCF_OFIPRO=="1","S","N")+" ]"+space(12)+STR0058+"[ "+Transform(VCF->VCF_QTDMEC,"@E 9999")+" ]"+space(12)+STR0059+"[ "+If(VCF->VCF_USASTE=="1","S","N")+" ]"+space(12)+STR0060+Transform(VCF->VCF_VALSTE,"@E 999,999,999.99")+"  "})
					aAdd(aImpress,{"  "+left(STR0061+space(128),128)+"  "})
				Else
					aAdd(aImpress,{space(125)+"[ N ]  "})
					aAdd(aImpress,{"  "+left(STR0056+space(128),128)+"  "})
					aAdd(aImpress,{"  "+STR0057+"[ "+If(VCF->VCF_OFIPRO=="1","S","N")+" ]"+space(12)+STR0058+"[ "+Transform(VCF->VCF_QTDMEC,"@E 9999")+" ]"+space(12)+STR0059+"[ "+If(VCF->VCF_USASTE=="1","S","N")+" ]"+space(12)+STR0060+Transform(VCF->VCF_VALSTE,"@E 999,999,999.99")+"  "})
					aAdd(aImpress,{"  "+left(STR0061+space(128),128)+"  "})
				EndIf
				If !Empty(VCF->VCF_FOR1MO) .or. !Empty(VCF->VCF_FOR1PC)
					aAdd(aImpress,{"  "+left(space(15)+VCF->VCF_FOR1MO+space(47)+VCF->VCF_FOR1PC+space(128),128)+"  "})
					nValor++
				EndIf
				If !Empty(VCF->VCF_FOR2MO) .or. !Empty(VCF->VCF_FOR2PC)
					aAdd(aImpress,{"  "+left(space(15)+VCF->VCF_FOR2MO+space(47)+VCF->VCF_FOR2PC+space(128),128)+"  "})
					nValor++
				EndIf
				If nValor == 0
					aAdd(aImpress,{"  "+space(128)+"  "})
				EndIf
				aAdd(aImpress,{repl(cSeparac,132)})
				
			Case ( "O" == cQI )
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ O ]  "})
					aAdd(aImpress,{"  "+STR0062+repl("_",116)+"  "})
					For ni := 1 to 4
						aAdd(aImpress,{"  "+repl("_",128)+"  "})
					Next
					aAdd(aImpress,{repl(cSeparac,132)})
				EndIf
				
			Case ( "P" == cQI )
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ P ]  "})
					aAdd(aImpress,{"  "+left(STR0063+space(128),128)+"  "})
				Else
					aAdd(aImpress,{space(125)+"[ P ]  "})
					aAdd(aImpress,{"  "+left(STR0063+space(128),128)+"  "})
				EndIf
				DbSelectArea("VC1")
				nRegistro:= 1
				nPosicao := Recno()
				aDesc    := {}
				DbSetOrder(7)
				DbSeek(xFilial("VC1")+ cCliente + "9999" ,.T.)
				If !Bof() .and. ( VC1->VC1_CODCLI+VC1->VC1_LOJA # cCliente )
					DbSelectArea("VC1")
					DbSkip(-1)
				EndIf
				While !Bof() .and. VC1->VC1_FILIAL == xFilial("VC1") .and. ( VC1->VC1_CODCLI+VC1->VC1_LOJA == cCliente ) .and. nRegistro <= nQtdHis
					If ( VC1->VC1_TIPAGE $ cDepHis ) .and. !Empty(VC1->VC1_DATVIS)
						If ( VC1->VC1_DATVIS >= ( dDataBase - ( nMesHis * 30 ) ) )
							ni := 0
							nValor := 0
							DbSelectArea("SYP")
							DbSetOrder(1)
							DbSeek( xFilial("SYP") + VC1->VC1_OCOMEM )
							While !Eof() .and. SYP->YP_CHAVE == VC1->VC1_OCOMEM
								cTexto := Alltrim(SYP->YP_TEXTO)
								nPos := AT("___",cTexto)
								If nPos > 0
									DbSelectArea("SYP")
									DbSkip()
									Loop
								EndIf
								If ni == 0
									DbSelectArea("VC0")
									DbSetOrder(1)
									DbSeek( xFilial("VC0") + VC1->VC1_TIPCON )
									DbSelectArea("SA3")
									DbSetOrder(1)
									DbSeek( xFilial("SA3") + VC1->VC1_CODVEN )
									nValor := 0
									ni++
								EndIf
								nValor++
								nPos := AT("\13\10",cTexto)
								If nPos > 0
									nPos--
								Else
									nPos := Len(cTexto)
								EndIf
								If ni == 1
									aAdd(aDesc,{If(nValor==1,Transform(VC1->VC1_DATVIS,"@D")+" "+left(SA3->A3_NREDUZ,8)+" "+VC0->VC0_DESCON+" ",space(29))+Substr(cTexto,1,nPos)})
									ni := 2
								Else
									aDesc[len(aDesc),1] += " "+Substr(cTexto,1,nPos)
									ni := 1
								EndIf
								DbSelectArea("SYP")
								DbSkip()
							EndDo
							If ni # 0
								nRegistro++
							EndIf
						EndIf
					EndIf
					DbSelectArea("VC1")
					DbSkip(-1)
				EndDo
				For ni := 1 to len(aDesc)
					If !Empty(Alltrim(aDesc[ni,1]))
						aAdd(aImpress,{"  "+left(aDesc[ni,1]+space(128),128)+"  "})
					EndIf
				Next
				DbGoTo(nPosicao)
				DbSetOrder(4)
				If nRegistro == 1
					aAdd(aImpress,{"  "+space(128)+"  "})
				EndIf
				aAdd(aImpress,{repl(cSeparac,132)})
				
			Case ( "Q" == cQI )
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ Q ]  "})
					aAdd(aImpress,{"  "+STR0064+left("____/____/_______        "+STR0065+STR0066+STR0067+STR0068+space(117),117)+"  "})
					For ni := 1 to 7
						aAdd(aImpress,{"  "+repl("_",128)+"  "})
					Next
					aAdd(aImpress,{repl(cSeparac,132)})
				EndIf
				
			Case ( "R" == cQI )
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ R ]  "})
					aAdd(aImpress,{"  "+left(STR0069+repl("_",117)+space(128),128)+"  "})
					aAdd(aImpress,{"  "+left(STR0070+repl("_",63)+STR0071+"____/____/_______"+space(128),128)+"  "})
					aAdd(aImpress,{repl(cSeparac,132)})
				EndIf
				
			Case ( "S" == cQI )
				If cPRW == "VEICR500"
					aAdd(aImpress,{space(125)+"[ S ]  "})
					aAdd(aImpress,{"  "+left(STR0077+space(128),128)+"  "})
				Else
					aAdd(aImpress,{space(125)+"[ S ]  "})
					aAdd(aImpress,{"  "+left(STR0077+space(128),128)+"  "})
				EndIf
				nRegistro:= 1
				DbSelectArea("VAO")
				DbSetOrder(1)
				DbSeek(xFilial("VAO") + cCliente )
				While !Eof() .and. ( VAO->VAO_CODCLI+VAO->VAO_LOJCLI == cCliente )
					aDesc := {}
					ni := 1
					DbSelectArea("SYP")
					DbSetOrder(1)
					DbSeek( xFilial("SYP") + VAO->VAO_RECLAO )
					While !Eof() .and. SYP->YP_CHAVE == VAO->VAO_RECLAO
						lx := .f.
						cTexto := Alltrim(SYP->YP_TEXTO)
						nPos := AT("_____",cTexto)
						If nPos > 0
							ni := 1
							lx := .t.
						EndIf
						nPos := AT("*** ",cTexto)
						If nPos > 0
							ni := 1
						EndIf
						nPos := AT("\13\10",cTexto)
						If nPos > 0
							nPos--
						Else
							nPos := Len(cTexto)
						EndIf
						If ni == 1
							aAdd(aDesc,{Substr(cTexto,1,nPos)+If(lx,repl("_",47),"")})
							ni := 2
						Else
							aDesc[len(aDesc),1] += " "+Substr(cTexto,1,nPos)
							ni := 1
						EndIf
						DbSelectArea("SYP")
						DbSkip()
					EndDo
					DbSelectArea("VAP")
					DbSetOrder(1)
					DbSeek( xFilial("VAP") + VAO->VAO_DEPART )
					DbSelectArea("VAQ")
					DbSetOrder(1)
					DbSeek( xFilial("VAQ") + VAO->VAO_TIPREC )
					dPz := cTod("")
					If !Empty(VAO->VAO_DATPRO)
						dPz := VAO->VAO_DATPRO + VAP->VAP_PRARES
					Else
						dPz := VAO->VAO_DATREC + VAP->VAP_PRARES
					EndIf
					aAdd(aImpress,{"  "+IIf(lVAQ_TIPOSI.and.VAQ->VAQ_TIPOSI=="1","1","2")+") "+left(Transform(VAO->VAO_DATREC,"@D")+"-"+left(UsrRetName(VAO->VAO_USUREC),10)+" "+STR0078+left(UsrRetName(VAO->VAO_USURES),10)+" "+STR0079+left(VAP->VAP_DESDEP,10)+" "+STR0080+left(VAQ->VAQ_DESTIP,10)+" "+STR0081+Transform(VAO->VAO_DATPRO,"@D")+" "+STR0082+Transform(dPz,"@D")+" "+STR0083+Transform(VAO->VAO_DATENC,"@D")+space(128),128)+"  "})
					If ni # 0
						nRegistro++
						For ni := 1 to len(aDesc)
							aAdd(aImpress,{"  "+left("         "+aDesc[ni,1]+space(128),128)+"  "})
						Next
						aAdd(aImpress,{"  "+space(128)+"  "})
					EndIf
					DbSelectArea("VAO")
					DbSkip()
				EndDo
				If nRegistro == 1
					aAdd(aImpress,{"  "+space(128)+"  "})
				EndIf
				aAdd(aImpress,{repl(cSeparac,132)})
				
		EndCase
		
	Next
	
	//Inicio da criacao de pastas e arquivos separadamente por tipo de agenda, vendedor e cliente.
	
	cDirMsg := "\PROTHEUS_DATA"
	If cPRW == "VEICR500"
		// Cria Diretorio: GetMv("MV_RELT") //
		cDir := GetMv("MV_RELT") 
		cDirMsg += GetMv("MV_RELT") 
		If !lIsDir(cDir)
			MakeDir(cDir)
		EndIf                     
		// Cria Diretorio: Tipo de Agenda dentro do GetMv("MV_RELT") //
		cDir += "AGENDA_" + VC1->VC1_TIPAGE + "\"
		cDirMsg += "AGENDA_" + VC1->VC1_TIPAGE + "\"
		If !lIsDir(cDir)
			MakeDir(cDir)
		EndIf
		// Cria Diretorio: Vendedor dentro do GetMv("MV_RELT") + Tipo de Agenda //
		cDir += "V_" + VC1->VC1_CODVEN + "\"
		If !lIsDir(cDir)
			MakeDir(cDir)
		EndIf
		// Cria Arquivo Texto: Cliente dentro do GetMv("MV_RELT") + Tipo de Agenda + Vendedor //
		cArq := cCliente + ".txt"
		Outputfile := FCREATE(cDir+cArq,0)
	
		For ni := 1 to len(aImpress)
			nLin++
			If left(aImpress[ni,1],20) == repl(cSeparac,20)
				If nLin >= 48 .and. ( len(aImpress) - ni ) > 4
					fwrite(outputfile,repl(cSeparac,132)+CHR(13)+CHR(10))
					fwrite(outputfile," "+CHR(13)+CHR(10))
					fwrite(outputfile,space(104)+cFicCont+CHR(13)+CHR(10)+CHR(12))
					nLin := 1
				EndIf
			Else
				If nLin >= 58 .and. ( len(aImpress) - ni ) > 4
					fwrite(outputfile," "+CHR(13)+CHR(10))
					fwrite(outputfile,space(104)+cFicCont+CHR(13)+CHR(10)+CHR(12))
					nLin := 1
				EndIf
			EndIf
			fwrite(outputfile,aImpress[ni,1]+CHR(13)+CHR(10))
		Next
		fwrite(outputfile," "+CHR(13)+CHR(10))
		fwrite(outputfile,space(104)+cFicCont+CHR(18)+CHR(13)+CHR(10)+CHR(12))
		
		fclose(Outputfile)

		// Marcar a Ficha como ja emitida //
		If RecLock("VC1",.F.)
			VC1->VC1_EMIFIC := "1"
			MsUnLock()
		Else
			HELP("REGNLOCK")
		EndIf
	
	Else
	
		nLin := 66
		For ni := 1 to len(aImpress)
			
			If nLin > 64
				nLin := cabec(cDesc1,cabec1,cabec2,cPRW,Tamanho,nTipo)+1
			EndIf
			
			nLin++
			If left(aImpress[ni,1],20) == repl(cSeparac,20)
				If nLin >= 62 .and. ( len(aImpress) - ni ) > 4
					@ nLin,01 PSAY repl(cSeparac,130)+CHR(13)+CHR(10)
					@ nLin,01 PSAY " "+CHR(13)+CHR(10)
					@ nLin,01 PSAY space(104)+cFicCont+CHR(13)+CHR(10)//+CHR(12)
					nLin := cabec(cDesc1,cabec1,cabec2,cPRW,Tamanho,nTipo)
					nLin++
				EndIf
			Else
				If nLin >= 62 .and. ( len(aImpress) - ni ) > 4
					@ nLin,01 PSAY " "+CHR(13)+CHR(10)
					@ nLin,01 PSAY space(104)+cFicCont+CHR(13)+CHR(10)//+CHR(12)
					nLin := cabec(cDesc1,cabec1,cabec2,cPRW,Tamanho,nTipo)
					nLin++
				EndIf
			EndIf
			@ nLin,01 PSAY aImpress[ni,1] //Informacao normal a ser impressa na linha
		Next
		@ nLin,01 PSAY " "+CHR(13)+CHR(10)
		@ nLin,01 PSAY space(104)+cFicCont+CHR(18)+CHR(13)+CHR(10)//+CHR(12)
	
	EndIf

	DbSelectArea(cDbSelec)
	DbSkip()
EndDo

If cPRW == "VEICR500"
	If lImpr
		MsgInfo(STR0073,STR0072)
		MsgInfo(STR0087+cDirMsg,STR0072)
	Else
		MsgAlert(STR0074,STR0072)
	EndIf
Else

	SET DEVICE TO SCREEN
	If aReturn[5]==1
		DbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	EndIf

	MS_FLUSH()

EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao    ³VEICR500TP ³ Autor ³ Andre Luis Almeida  ³ Data ³ 29/07/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descricao ³ Atualiza Pergunte: VCR500                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEICR500TP()
Local lRet := .f.
If !Empty(MV_PAR01)
	DbSelectArea("VC5")
	DbSetOrder(1)
	If DbSeek( xFilial("VC5") + MV_PAR01 )
		lRet := .t.
		MV_PAR07 := VC5->VC5_QTDFIC // Quadro de Informacoes
		MV_PAR08 := VC5->VC5_QTDHIS // Qtde de Historicos a Relacionar
		MV_PAR09 := VC5->VC5_MESHIS // Meses de Historicos a Relacionar
		MV_PAR10 := VC5->VC5_HISDEP // Historicos dos Departamentos a Relacionar
	EndIf
EndIf
Return(lRet)
