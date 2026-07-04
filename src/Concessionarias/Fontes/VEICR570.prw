/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 04     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#Include "VEICR570.CH" 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao   ³ VEICR570 ³ Autor ³ Andre Luis Almeida    ³ Data ³ 27/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao³ Clientes/Contatos CEV por Dt.Anivers. ou Dt.Movto          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEICR570()
Local aParamBox  := {}
Private aRetSX1  := {}
Private lNewVend := ( VCF->(FieldPos("VCF_VENVEU")) > 0 ) // Possui campos novos Vendedores
Private cTitulo  := STR0001
Private aReturn  := {STR0002,1,STR0003,2,2,1,"",1}
Private cAlias   := "SA1"
Private cNomeRel := "VEICR570"
Private cTamanho := "M"
Private cLimite  := 132
Private cDesc1   := ""
Private cDesc2   := ""
Private cDesc3   := ""
Private lA1_IBGE := ( SA1->(FieldPos("A1_IBGE")) > 0 )
//
aAdd(aParamBox,{1,STR0009,dDataBase-day(dDataBase)+1,"@D","","","",45,.F.}) // 1
aAdd(aParamBox,{1,STR0010,dDataBase,"@D","","","",45,.F.}) // 2
aAdd(aParamBox,{2,STR0011,"1",{"1="+STR0012,"2="+STR0013},100,"",.F.}) // 3
aAdd(aParamBox,{2,STR0014,"1",{"1="+STR0015,"2="+STR0016,"3="+STR0017},100,"",.F.}) // 4
If lNewVend
	aAdd(aParamBox,{2,STR0022,"",{"","1="+STR0023,"3="+STR0024,"4="+STR0025,"5="+STR0026,"6="+STR0027,"7="+STR0028},100,"",.F.}) // 5
Else
	aAdd(aParamBox,{2,STR0022,"",{"","1="+STR0023,"3="+STR0024,"4="+STR0025},100,"",.F.}) // 5
EndIf
aAdd(aParamBox,{2,STR0029,"1",{"1="+STR0030,"2="+STR0031,"3="+STR0032},100,"",.F.}) // 6
aAdd(aParamBox,{1,STR0033,32,"@E 99","","","",45,.F.}) // 7
aAdd(aParamBox,{1,STR0034,Space(TamSX3("VCF_VENVEI")[1]),"@!","","SA3","",40,.f.})	// 8
aAdd(aParamBox,{2,STR0018,"1",{"1="+STR0019,"2="+STR0020,"3="+STR0021},100,"",.F.}) // 9
If ParamBox(aParamBox,STR0001,@aRetSX1,,,,,,,,.f.)
	cNomeRel := SetPrint(cAlias,cNomeRel,,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,,cTamanho)
	If nlastkey == 27
		Return
	EndIf
	RptStatus({|lEnd| FS_VCR570(@lEnd,cNomeRel,'SA1')},cTitulo)
EndIf
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao   ³ FS_VCR570³ Autor ³ Andre Luis Almeida    ³ Data ³ 27/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao³ Impressao                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_VCR570()

Local lCEVOUT    := ( VAI->(FieldPos("VAI_CEVOUT")) > 0 ) // Visualiza Agendas de Outros Usuarios do CEV? (1=Sim/0=Nao)
Local ni         := 0
Private cabec1   := If(aRetSX1[4]=="1",STR0004,STR0005)
Private cabec2   := ""
Private nCaracter:= 15
Private M_PAG    := 1
Private cDatas   := ""
Private cNomes   := ""
Private cEnds    := ""
Private cCeps    := ""
Private cBairros := ""
Private nColunas := 0
Private cPrefix  := "  "
Private nLin     := 0
Private aCliente := {}
Private lNroEnd  := ( SA1->(FieldPos("A1_NUMERO")) > 0 )
Private nT       := 0
Private cT       := ""

VAI->(DbSetOrder(4))
VAI->(DbSeek( xFilial("VAI") + __CUSERID ))

Set Console On
Set Printer to &cNomeRel
Set Printer On
Set device to Printer

SetDefault(aReturn,cAlias)

nColunas := val(aRetSX1[6])
nLarg    := aRetSX1[7]

if aRetSX1[3] == "1" // Relatorio
	nLin := cabec(cTitulo,cabec1,cabec2,cNomeRel,ctamanho,nCaracter) + 1
Endif
If aRetSX1[4] == "1"  // Data de Movimento ( Balcao / Oficina / Veiculos / Todos )
	Do Case
		Case aRetSX1[5] == "3" .or. aRetSX1[5] == "6" .or. aRetSX1[5] == "7" // 3-Balcao / 6-Pneus / 7-Outros
			cPrefix := GetNewPar("MV_PREFBAL","BAL")
		Case aRetSX1[5] == "1" // Oficina
			cPrefix := GetNewPar("MV_PREFOFI","OFI")
		Case aRetSX1[5] == "4" .or. aRetSX1[5] == "5" // Veiculos ( 4-Novos / 5-Usados )
			cPrefix := GetNewPar("MV_PREFVEI","VEI")
	EndCase
	DbSelectArea("SD2")
	DbSetOrder(5)
	DbSeek( xFilial("SD2") + DTOS(aRetSX1[1]) , .t. )
	DbSelectArea("SF2")
	DbSetOrder(1)
	DbSeek( xFilial("SF2") + SD2->D2_DOC + SD2->D2_SERIE + SD2->D2_CLIENTE + SD2->D2_LOJA )
	SetRegua(RecCount())
	While !Eof() .and. xFilial("SF2") == SF2->F2_FILIAL .and. SF2->F2_EMISSAO <= aRetSX1[2]
		IncRegua()
		If !Empty(aRetSX1[5])
			If SF2->F2_PREFORI # cPrefix
				DbSelectArea("SF2")
				DbSkip()
				Loop
			EndIf
		EndIf
		If ( lCEVOUT .and. VAI->VAI_CEVOUT == "0" ) .or. !Empty(aRetSX1[8])
			DbSelectArea("VCF")
			DbSetOrder(1)
			If !DbSeek( xFilial("VCF") + SF2->F2_CLIENTE + SF2->F2_LOJA )
				DbSelectArea("SF2")
				DbSkip()
				Loop
			EndIf
		EndIf
		If lCEVOUT .and. VAI->VAI_CEVOUT == "0" // Visualiza Agendas de Outros Usuarios do CEV? (1=Sim/0=Nao)
			If lNewVend
				If !Empty(VCF->VCF_VENSRV+VCF->VCF_VENPEC+VCF->VCF_VENVEI+VCF->VCF_VENVEU+VCF->VCF_VENPNE+VCF->VCF_VENOUT)
					If !(VAI->VAI_CODVEN $ VCF->VCF_VENSRV+"/"+VCF->VCF_VENPEC+"/"+VCF->VCF_VENVEI+"/"+VCF->VCF_VENVEU+"/"+VCF->VCF_VENPNE+"/"+VCF->VCF_VENOUT)
						DbSelectArea("SF2")
						DbSkip()
						Loop
					EndIf
				EndIf
			Else
				If !Empty(VCF->VCF_VENSRV+VCF->VCF_VENPEC+VCF->VCF_VENVEI)
					If !(VAI->VAI_CODVEN $ VCF->VCF_VENSRV+"/"+VCF->VCF_VENPEC+"/"+VCF->VCF_VENVEI)
						DbSelectArea("SF2")
						DbSkip()
						Loop
					EndIf
				EndIf
			EndIf
		EndIf
		If !Empty(aRetSX1[8])
			Do Case
				Case aRetSX1[5] == "1" // 1-Oficina
					If ( aRetSX1[8] # VCF->VCF_VENSRV )
						DbSelectArea("SF2")
						DbSkip()
						Loop
					EndIf
				Case aRetSX1[5] == "3"  // 3-Balcao
					If ( aRetSX1[8] # VCF->VCF_VENPEC )
						DbSelectArea("SF2")
						DbSkip()
						Loop
					EndIf
				Case aRetSX1[5] == "4" // 4-Veiculos Novos
					If ( aRetSX1[8] # VCF->VCF_VENVEI )
						DbSelectArea("SF2")
						DbSkip()
						Loop
					EndIf
				Case aRetSX1[5] == "5" // 5-Veiculos Usados
					If ( aRetSX1[8] # VCF->VCF_VENVEU )
						DbSelectArea("SF2")
						DbSkip()
						Loop
					EndIf
				Case aRetSX1[5] == "6" // 6-Pneus
					If ( aRetSX1[8] # VCF->VCF_VENPNE )
						DbSelectArea("SF2")
						DbSkip()
						Loop
					EndIf
				Case aRetSX1[5] == "7" // 7-Outros
					If ( aRetSX1[8] # VCF->VCF_VENOUT )
						DbSelectArea("SF2")
						DbSkip()
						Loop
					EndIf
				Otherwise
					If lNewVend
						If !(aRetSX1[8] $ VCF->VCF_VENSRV+"/"+VCF->VCF_VENPEC+"/"+VCF->VCF_VENVEI+"/"+VCF->VCF_VENVEU+"/"+VCF->VCF_VENPNE+"/"+VCF->VCF_VENOUT)
							DbSelectArea("SF2")
							DbSkip()
							Loop
						EndIf
					Else
						If !(aRetSX1[8] $ VCF->VCF_VENSRV+"/"+VCF->VCF_VENPEC+"/"+VCF->VCF_VENVEI)
							DbSelectArea("SF2")
							DbSkip()
							Loop
						EndIf
					EndIf
			EndCase
		EndIf
		DbSelectArea("SD2")
		DbSetOrder(3)
		If DbSeek( xFilial("SD2") + SF2->F2_DOC + SF2->F2_SERIE )
			DbSelectArea("SF4")
			DbSetOrder(1)
			DbSeek( xFilial("SF4") + SD2->D2_TES )
			If SF4->F4_DUPLIC == "S"
				If aRetSX1[9] == "3"
					Aadd(aCliente,{ SF2->F2_CLIENTE , SF2->F2_LOJA , SF2->F2_EMISSAO } )
				Else
					nPos := 0
					nPos := aScan(aCliente,{|x| x[1]+x[2] == SF2->F2_CLIENTE + SF2->F2_LOJA })
					If nPos == 0
						Aadd(aCliente,{ SF2->F2_CLIENTE , SF2->F2_LOJA , SF2->F2_EMISSAO } )
					Else
						If aRetSX1[9] == "2"
							If aCliente[nPos,3] < SF2->F2_EMISSAO
								aCliente[nPos,3] := SF2->F2_EMISSAO
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
		DbSelectArea("SF2")
		DbSkip()
	EndDo
	aSort(aCliente,1,,{|x,y| x[1]+x[2]+dtos(x[3]) < y[1]+y[2]+dtos(y[3]) })
	For ni := 1 to len(aCliente)
		DbSelectArea("SA1")
		DbSetOrder(1)
		If DbSeek( xFilial("SA1") + aCliente[ni,1] + aCliente[ni,2] )
			If lA1_IBGE
				VAM->(DbSetOrder(1))
				VAM->(Dbseek(xFilial("VAM")+SA1->A1_IBGE))
			EndIf
			If aRetSX1[3] == "1"
				If nLin >= 60
					nLin := 1
					nLin := cabec(cTitulo,cabec1,cabec2,cNomeRel,ctamanho,nCaracter) + 1
				EndIf
				If lA1_IBGE
					@ nLin++, 000 pSay left(Alltrim(aCliente[ni,1]+"-"+aCliente[ni,2])+" "+SA1->A1_NOME,28)+" "+left(Transform(aCliente[ni,3],"@D"),6)+right(Transform(aCliente[ni,3],"@D"),2)+" "+If(lNroEnd,left(alltrim(left(alltrim(SA1->A1_END),30-len(alltrim(left(SA1->A1_NUMERO,6))))+","+alltrim(left(SA1->A1_NUMERO,6)))+space(31),31),left(SA1->A1_END,31))+" "+left(SA1->A1_BAIRRO,13)+" "+left(VAM->VAM_DESCID,21)+"-"+VAM->VAM_ESTADO+" "+SA1->A1_CEP+" "+left(VAM->VAM_DDD+" "+alltrim(SA1->A1_TEL),14)
				Else
					@ nLin++, 000 pSay left(Alltrim(aCliente[ni,1]+"-"+aCliente[ni,2])+" "+SA1->A1_NOME,28)+" "+left(Transform(aCliente[ni,3],"@D"),6)+right(Transform(aCliente[ni,3],"@D"),2)+" "+If(lNroEnd,left(alltrim(left(alltrim(SA1->A1_END),30-len(alltrim(left(SA1->A1_NUMERO,6))))+","+alltrim(left(SA1->A1_NUMERO,6)))+space(31),31),left(SA1->A1_END,31))+" "+left(SA1->A1_BAIRRO,13)+" "+left(SA1->A1_MUN,21)+"-"+SA1->A1_EST+" "+SA1->A1_CEP+" "+alltrim(SA1->A1_TEL)
				EndIf
			Else
				If !(nColunas > 0 )
					@ nLin++,00 PSAY cDatas
					@ nLin++,00 PSAY cNomes
					@ nLin++,00 PSAY cEnds
					@ nLin++,00 PSAY cBairros
					@ nLin++,00 PSAY cCeps
					nLin++
					nColunas := val(aRetSX1[6])
					cDatas := cNomes := cEnds := cBairros := cCeps := ""
				EndIf
				nColunas--
				nT := ( dDataBase - aCliente[ni,3] )
				If nT > 365
					nT := ( nT / 365 )
					cT := left(STR0006,1)
				ElseIf nT > 30
					nT := ( nT / 30 )
					cT := left(STR0007,1)
				Else
					cT := left(STR0008,1)
				EndIf
				cDatas   += left( space(nLarg-14)+Transform(aCliente[ni,3],"@D")+" "+str(nT,3)+cT , nLarg-1 ) + " "
				cNomes   += left( Alltrim(SA1->A1_NOME) + space(nLarg) , nLarg-1 ) + " "
				cEnds    += left( If(lNroEnd,left(SA1->A1_END,If(nLarg>9,nLarg-9,1))+", "+SA1->A1_NUMERO,SA1->A1_END) + space(nLarg) , nLarg-1 ) + " "
				cBairros += left( SA1->A1_BAIRRO + space(nLarg) , nLarg-1 ) + " "
				If lA1_IBGE
					cCeps += left( Transform(SA1->A1_CEP,"@R 99999-999") + " " + left(VAM->VAM_DESCID,If(nLarg>14,nLarg-14,1))+"-"+VAM->VAM_ESTADO + space(nLarg) , nLarg-1 ) + " "
				Else
					cCeps += left( Transform(SA1->A1_CEP,"@R 99999-999") + " " + left(SA1->A1_MUN,If(nLarg>14,nLarg-14,1))+"-"+SA1->A1_EST + space(nLarg) , nLarg-1 ) + " "
				EndIf
			EndIf
		EndIf
	Next
	nColunas := val(aRetSX1[6])
	nLarg    := aRetSX1[7]
	if len(cNomes) > 0
		@ nLin++,00 PSAY cDatas
		@ nLin++,00 PSAY cNomes
		@ nLin++,00 PSAY cEnds
		@ nLin++,00 PSAY cBairros
		@ nLin++,00 PSAY cCeps
	Endif
ElseIf aRetSX1[4] == "2" // Dt. de Aniversario Cliente
	DbSelectArea("SA1")
	DbSetOrder(1)
	DbSeek(xFilial("SA1"))
	SetRegua(RecCount())
	While !Eof() .and. SA1->A1_FILIAL == xFilial("SA1")
		IncRegua()
		If Len(Alltrim(SA1->A1_CGC)) > 12 // Nao fazer para Pessoa Juridica
			DbSelectArea("SA1")
			DbSkip()
			Loop
		EndIf
		If ( lCEVOUT .and. VAI->VAI_CEVOUT == "0" ) .or. !Empty(aRetSX1[8])
			DbSelectArea("VCF")
			DbSetOrder(1)
			If !DbSeek( xFilial("VCF") + SA1->A1_COD + SA1->A1_LOJA )
				DbSelectArea("SA1")
				DbSkip()
				Loop
			EndIf
		EndIf
		If lCEVOUT .and. VAI->VAI_CEVOUT == "0" // Visualiza Agendas de Outros Usuarios do CEV? (1=Sim/0=Nao)
			If lNewVend
				If !Empty(VCF->VCF_VENSRV+VCF->VCF_VENPEC+VCF->VCF_VENVEI+VCF->VCF_VENVEU+VCF->VCF_VENPNE+VCF->VCF_VENOUT)
					If !(VAI->VAI_CODVEN $ VCF->VCF_VENSRV+"/"+VCF->VCF_VENPEC+"/"+VCF->VCF_VENVEI+"/"+VCF->VCF_VENVEU+"/"+VCF->VCF_VENPNE+"/"+VCF->VCF_VENOUT)
						DbSelectArea("SA1")
						DbSkip()
						Loop
					EndIf
				EndIf
			Else
				If !Empty(VCF->VCF_VENSRV+VCF->VCF_VENPEC+VCF->VCF_VENVEI)
					If !(VAI->VAI_CODVEN $ VCF->VCF_VENSRV+"/"+VCF->VCF_VENPEC+"/"+VCF->VCF_VENVEI)
						DbSelectArea("SA1")
						DbSkip()
						Loop
					EndIf
				EndIf
			EndIf
		EndIf
		If !Empty(aRetSX1[8])
			Do Case
				Case aRetSX1[5] == "1" // 1-Oficina
					If ( aRetSX1[8] # VCF->VCF_VENSRV )
						DbSelectArea("SA1")
						DbSkip()
						Loop
					EndIf
				Case aRetSX1[5] == "3"  // 3-Balcao
					If ( aRetSX1[8] # VCF->VCF_VENPEC )
						DbSelectArea("SA1")
						DbSkip()
						Loop
					EndIf
				Case aRetSX1[5] == "4" // 4-Veiculos Novos
					If ( aRetSX1[8] # VCF->VCF_VENVEI )
						DbSelectArea("SA1")
						DbSkip()
						Loop
					EndIf
				Case aRetSX1[5] == "5" // 5-Veiculos Usados
					If ( aRetSX1[8] # VCF->VCF_VENVEU )
						DbSelectArea("SA1")
						DbSkip()
						Loop
					EndIf
				Case aRetSX1[5] == "6" // 6-Pneus
					If ( aRetSX1[8] # VCF->VCF_VENPNE )
						DbSelectArea("SA1")
						DbSkip()
						Loop
					EndIf
				Case aRetSX1[5] == "7" // 7-Outros
					If ( aRetSX1[8] # VCF->VCF_VENOUT )
						DbSelectArea("SA1")
						DbSkip()
						Loop
					EndIf
				Otherwise
					If lNewVend
						If !(aRetSX1[8] $ VCF->VCF_VENSRV+"/"+VCF->VCF_VENPEC+"/"+VCF->VCF_VENVEI+"/"+VCF->VCF_VENVEU+"/"+VCF->VCF_VENPNE+"/"+VCF->VCF_VENOUT)
							DbSelectArea("SA1")
							DbSkip()
							Loop
						EndIf
					Else
						If !(aRetSX1[8] $ VCF->VCF_VENSRV+"/"+VCF->VCF_VENPEC+"/"+VCF->VCF_VENVEI)
							DbSelectArea("SA1")
							DbSkip()
							Loop
						EndIf
					EndIf
			EndCase
		EndIf
		dDiaNas := substr(dtoc(SA1->A1_DTNASC),1,2)
		dMesNas := substr(dtoc(SA1->A1_DTNASC),4,2)
		dDiaIni := substr(dtoc(aRetSX1[1]),1,2)
		dMesIni := substr(dtoc(aRetSX1[1]),4,2)
		dDiaFin := substr(dtoc(aRetSX1[2]),1,2)
		dMesFin := substr(dtoc(aRetSX1[2]),4,2)
		dDatBas := ctod(dDiaNas+"/"+dMesNas+"/00")
		dDatIni := ctod(dDiaIni+"/"+dMesIni+"/00")
		dDatFin := ctod(dDiaFin+"/"+dMesFin+"/00")
		If dDatBas < dDatIni .or. dDatBas > dDatFin // Verifica DIA/MES do Aniversario do Cliente
			DbSelectArea("SA1")
			DbSkip()
			Loop
		Endif
		If lA1_IBGE
			VAM->(DbSetOrder(1))
			VAM->(Dbseek(xFilial("VAM")+SA1->A1_IBGE))
		EndIf
		If aRetSX1[3] == "1"
			If nLin >= 60
				nLin := 1
				nLin := cabec(cTitulo,cabec1,cabec2,cNomeRel,ctamanho,nCaracter) + 1
			EndIf
			If lA1_IBGE
				@ nLin++, 000 pSay left(Alltrim(SA1->A1_COD+"-"+SA1->A1_LOJA)+" "+SA1->A1_NOME,28)+" "+left(Transform(SA1->A1_DTNASC,"@D"),6)+right(Transform(SA1->A1_DTNASC,"@D"),2)+" "+If(lNroEnd,left(alltrim(left(alltrim(SA1->A1_END),30-len(alltrim(left(SA1->A1_NUMERO,6))))+","+alltrim(left(SA1->A1_NUMERO,6)))+space(31),31),left(SA1->A1_END,31))+" "+left(SA1->A1_BAIRRO,13)+" "+left(VAM->VAM_DESCID,21)+"-"+VAM->VAM_ESTADO+" "+SA1->A1_CEP+" "+left(VAM->VAM_DDD+" "+alltrim(SA1->A1_TEL),14)
			Else
				@ nLin++, 000 pSay left(Alltrim(SA1->A1_COD+"-"+SA1->A1_LOJA)+" "+SA1->A1_NOME,28)+" "+left(Transform(SA1->A1_DTNASC,"@D"),6)+right(Transform(SA1->A1_DTNASC,"@D"),2)+" "+If(lNroEnd,left(alltrim(left(alltrim(SA1->A1_END),30-len(alltrim(left(SA1->A1_NUMERO,6))))+","+alltrim(left(SA1->A1_NUMERO,6)))+space(31),31),left(SA1->A1_END,31))+" "+left(SA1->A1_BAIRRO,13)+" "+left(SA1->A1_MUN,21)+"-"+SA1->A1_EST+" "+SA1->A1_CEP+" "+alltrim(SA1->A1_TEL)
			EndIf
		Else
			If !(nColunas > 0 )
				@ nLin++,00 PSAY cDatas
				@ nLin++,00 PSAY cNomes
				@ nLin++,00 PSAY cEnds
				@ nLin++,00 PSAY cBairros
				@ nLin++,00 PSAY cCeps
				nLin++
				nColunas := val(aRetSX1[6])
				cDatas := cNomes := cEnds := cBairros := cCeps := ""
			EndIf
			nColunas--
			cDatas   += left( space(nLarg-6)+substr(dtoc(SA1->A1_DTNASC),1,5) , nLarg-1 ) + " "
			cNomes   += left( Alltrim(SA1->A1_NOME) + space(nLarg) , nLarg-1 ) + " "
			cEnds    += left( If(lNroEnd,left(SA1->A1_END,If(nLarg>9,nLarg-9,1))+", "+SA1->A1_NUMERO,SA1->A1_END) + space(nLarg) , nLarg-1 ) + " "
			cBairros += left( SA1->A1_BAIRRO + space(nLarg) , nLarg-1 ) + " "
			If lA1_IBGE
				cCeps += left( Transform(SA1->A1_CEP,"@R 99999-999") + " " + left(VAM->VAM_DESCID,If(nLarg>14,nLarg-14,1))+"-"+VAM->VAM_ESTADO + space(nLarg) , nLarg-1 ) + " "
			Else
				cCeps += left( Transform(SA1->A1_CEP,"@R 99999-999") + " " + left(SA1->A1_MUN,If(nLarg>14,nLarg-14,1))+"-"+SA1->A1_EST + space(nLarg) , nLarg-1 ) + " "
			EndIf
		EndIf
		DbSelectArea("SA1")
		DbSkip()
	EndDo
Else // aRetSX1[4] == "3" // Dt. de Aniversario Contato CEV
	DbSelectArea("VC2")
	DbSetOrder(1)
	DbSeek( xFilial("VC2") )
	SetRegua(RecCount())
	While !Eof() .and. VC2->VC2_FILIAL == xFilial("VC2")
		IncRegua()
		dDiaNas := substr(dtoc(VC2->VC2_DATNAS),1,2)
		dMesNas := substr(dtoc(VC2->VC2_DATNAS),4,2)
		dDiaIni := substr(dtoc(aRetSX1[1]),1,2)
		dMesIni := substr(dtoc(aRetSX1[1]),4,2)
		dDiaFin := substr(dtoc(aRetSX1[2]),1,2)
		dMesFin := substr(dtoc(aRetSX1[2]),4,2)
		dDatBas := ctod(dDiaNas+"/"+dMesNas+"/00")
		dDatIni := ctod(dDiaIni+"/"+dMesIni+"/00")
		dDatFin := ctod(dDiaFin+"/"+dMesFin+"/00")
		If dDatBas < dDatIni .or. dDatBas > dDatFin // Verifica DIA/MES do Aniversario Contato CEV
			DbSelectArea("VC2")
			DbSkip()
			Loop
		Endif
		DbSelectArea("SA1")
		DbSetOrder(1)
		DbSeek(xFilial("SA1")+VC2->VC2_CODCLI+VC2->VC2_LOJA)
		If ( lCEVOUT .and. VAI->VAI_CEVOUT == "0" ) .or. !Empty(aRetSX1[8])
			DbSelectArea("VCF")
			DbSetOrder(1)
			If !DbSeek( xFilial("VCF") + SA1->A1_COD + SA1->A1_LOJA )
				DbSelectArea("VC2")
				DbSkip()
				Loop
			EndIf
		EndIf
		If lCEVOUT .and. VAI->VAI_CEVOUT == "0" // Visualiza Agendas de Outros Usuarios do CEV? (1=Sim/0=Nao)
			If lNewVend
				If !Empty(VCF->VCF_VENSRV+VCF->VCF_VENPEC+VCF->VCF_VENVEI+VCF->VCF_VENVEU+VCF->VCF_VENPNE+VCF->VCF_VENOUT)
					If !(VAI->VAI_CODVEN $ VCF->VCF_VENSRV+"/"+VCF->VCF_VENPEC+"/"+VCF->VCF_VENVEI+"/"+VCF->VCF_VENVEU+"/"+VCF->VCF_VENPNE+"/"+VCF->VCF_VENOUT)
						DbSelectArea("VC2")
						DbSkip()
						Loop
					EndIf
				EndIf
			Else
				If !Empty(VCF->VCF_VENSRV+VCF->VCF_VENPEC+VCF->VCF_VENVEI)
					If !(VAI->VAI_CODVEN $ VCF->VCF_VENSRV+"/"+VCF->VCF_VENPEC+"/"+VCF->VCF_VENVEI)
						DbSelectArea("VC2")
						DbSkip()
						Loop
					EndIf
				EndIf
			EndIf
		EndIf
		If !Empty(aRetSX1[8])
			Do Case
				Case aRetSX1[5] == "1" // 1-Oficina
					If ( aRetSX1[8] # VCF->VCF_VENSRV )
						DbSelectArea("VC2")
						DbSkip()
						Loop
					EndIf
				Case aRetSX1[5] == "3"  // 3-Balcao
					If ( aRetSX1[8] # VCF->VCF_VENPEC )
						DbSelectArea("VC2")
						DbSkip()
						Loop
					EndIf
				Case aRetSX1[5] == "4" // 4-Veiculos Novos
					If ( aRetSX1[8] # VCF->VCF_VENVEI )
						DbSelectArea("VC2")
						DbSkip()
						Loop
					EndIf
				Case aRetSX1[5] == "5" // 5-Veiculos Usados
					If ( aRetSX1[8] # VCF->VCF_VENVEU )
						DbSelectArea("VC2")
						DbSkip()
						Loop
					EndIf
				Case aRetSX1[5] == "6" // 6-Pneus
					If ( aRetSX1[8] # VCF->VCF_VENPNE )
						DbSelectArea("VC2")
						DbSkip()
						Loop
					EndIf
				Case aRetSX1[5] == "7" // 7-Outros
					If ( aRetSX1[8] # VCF->VCF_VENOUT )
						DbSelectArea("VC2")
						DbSkip()
						Loop
					EndIf
				Otherwise
					If lNewVend
						If !(aRetSX1[8] $ VCF->VCF_VENSRV+"/"+VCF->VCF_VENPEC+"/"+VCF->VCF_VENVEI+"/"+VCF->VCF_VENVEU+"/"+VCF->VCF_VENPNE+"/"+VCF->VCF_VENOUT)
							DbSelectArea("VC2")
							DbSkip()
							Loop
						EndIf
					Else
						If !(aRetSX1[8] $ VCF->VCF_VENSRV+"/"+VCF->VCF_VENPEC+"/"+VCF->VCF_VENVEI)
							DbSelectArea("VC2")
							DbSkip()
							Loop
						EndIf
					EndIf
			EndCase
		EndIf
		If lA1_IBGE
			VAM->(DbSetOrder(1))
			VAM->(Dbseek(xFilial("VAM")+SA1->A1_IBGE))
		EndIf
		If aRetSX1[3] == "1"
			If nLin >= 60
				nLin := 1
				nLin := cabec(cTitulo,cabec1,cabec2,cNomeRel,ctamanho,nCaracter) + 1
			EndIf
			If lA1_IBGE
				@ nLin++, 000 pSay left(Alltrim(SA1->A1_COD+"-"+SA1->A1_LOJA)+" "+VC2->VC2_NOMCON,28)+" "+left(Transform(VC2->VC2_DATNAS,"@D"),6)+right(Transform(VC2->VC2_DATNAS,"@D"),2)+" "+If(lNroEnd,left(alltrim(left(alltrim(SA1->A1_END),30-len(alltrim(left(SA1->A1_NUMERO,6))))+","+alltrim(left(SA1->A1_NUMERO,6)))+space(31),31),left(SA1->A1_END,31))+" "+left(SA1->A1_BAIRRO,13)+" "+left(VAM->VAM_DESCID,21)+"-"+VAM->VAM_ESTADO+" "+SA1->A1_CEP+" "+left(VAM->VAM_DDD+" "+alltrim(SA1->A1_TEL),14)
			Else
				@ nLin++, 000 pSay left(Alltrim(SA1->A1_COD+"-"+SA1->A1_LOJA)+" "+VC2->VC2_NOMCON,28)+" "+left(Transform(VC2->VC2_DATNAS,"@D"),6)+right(Transform(VC2->VC2_DATNAS,"@D"),2)+" "+If(lNroEnd,left(alltrim(left(alltrim(SA1->A1_END),30-len(alltrim(left(SA1->A1_NUMERO,6))))+","+alltrim(left(SA1->A1_NUMERO,6)))+space(31),31),left(SA1->A1_END,31))+" "+left(SA1->A1_BAIRRO,13)+" "+left(SA1->A1_MUN,21)+"-"+SA1->A1_EST+" "+SA1->A1_CEP+" "+alltrim(SA1->A1_TEL)
			EndIf
		Else
			If !(nColunas > 0 )
				@ nLin++,00 PSAY cDatas
				@ nLin++,00 PSAY cNomes
				@ nLin++,00 PSAY cEnds
				@ nLin++,00 PSAY cBairros
				@ nLin++,00 PSAY cCeps
				nLin++
				nColunas := val(aRetSX1[6])
				cDatas := cNomes := cEnds := cBairros := cCeps := ""
			EndIf
			nColunas--
			cDatas   += left( space(nLarg-6)+substr(dtoc(VC2->VC2_DATNAS),1,5) , nLarg-1 ) + " "
			cNomes   += left( Alltrim(VC2->VC2_NOMCON) + space(nLarg) , nLarg-1 ) + " "
			cEnds    += left( If(lNroEnd,left(SA1->A1_END,If(nLarg>9,nLarg-9,1))+", "+SA1->A1_NUMERO,SA1->A1_END) + space(nLarg) , nLarg-1 ) + " "
			cBairros += left( SA1->A1_BAIRRO + space(nLarg) , nLarg-1 ) + " "
			If lA1_IBGE
				cCeps += left( Transform(SA1->A1_CEP,"@R 99999-999") + " " + left(VAM->VAM_DESCID,If(nLarg>14,nLarg-14,1))+"-"+VAM->VAM_ESTADO + space(nLarg) , nLarg-1 ) + " "
			Else
				cCeps += left( Transform(SA1->A1_CEP,"@R 99999-999") + " " + left(SA1->A1_MUN,If(nLarg>14,nLarg-14,1))+"-"+SA1->A1_EST + space(nLarg) , nLarg-1 ) + " "
			EndIf
		EndIf
		DbSelectArea("VC2")
		DbSkip()
	EndDo
EndIf
nColunas := val(aRetSX1[6])
nLarg    := aRetSX1[7]
if len(cNomes) > 0
	@ nLin++,00 PSAY cDatas
	@ nLin++,00 PSAY cNomes
	@ nLin++,00 PSAY cEnds
	@ nLin++,00 PSAY cBairros
	@ nLin++,00 PSAY cCeps
Endif

Eject
Set Printer to
Set device to Screen
If aReturn[5] == 1
	ourspool(cNomeRel)
EndIf
MS_FLUSH()
Return
