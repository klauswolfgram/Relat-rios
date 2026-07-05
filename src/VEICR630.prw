/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 12     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#include "PROTHEUS.CH"
#include "VEICR630.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ VEICR630 º Autor ³ Andre Luis Almeida º Data ³  03/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Impressao da Frota dos Clientes CEV                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MIL                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEICR630()
Local aArea := GetArea()
Local aParamBox   := {}
Private aRetSX1   := {}
Private cImp      := ""
Private lA1_IBGE  := IIf(SA1->(FieldPos("A1_IBGE"))>0,.t.,.f.)
Private cDesc1    := STR0001
Private cDesc2    := ""
Private cDesc3    := ""
Private cAlias    := "VCF"
Private nLin      := 0
Private aPag      := 1
Private nIte      := 1
Private aReturn   := { STR0012, 1,STR0013, 2, 2, 1, "",1 } //Zebrado # Administracao
Private cTamanho  := "G"           // P/M/G
Private Limite    := 220           // 80/132/220
Private aOrdem    := {}           // Ordem do Relatorio
Private cTitulo   := STR0001
Private cNomeRel  := "VEICR630"
Private nLastKey  := 0
Private nCaracter := 18
Private cabec1    := ""
Private cabec2    := ""
Private lNewVend  := ( VCF->(FieldPos("VCF_VENVEU")) > 0 ) // Possui campos novos Vendedores
//
DbSelectArea("VCF") 
//
AADD(aParamBox,{1,STR0010,Space(TamSX3("VCF_CODCLI")[1]),"@!",'VAZIO() .OR. FG_Seek("VCF","MV_PAR01",1,.f.)'                ,"VCF",,40,.f.}) // 01-Cliente
AADD(aParamBox,{1,STR0011,Space(TamSX3("VCF_LOJCLI")[1]),"@!",'VAZIO() .OR. FG_Seek("VCF","MV_PAR01+MV_PAR02",1,.f.)'       ,""   ,,20,.f.}) // 02-Loja
AADD(aParamBox,{1,STR0014,Space(TamSX3("VCF_NIVIMP")[1]),"@!",''                                                            ,""   ,,20,.f.}) // 03-Nivel Importancia Cliente
AADD(aParamBox,{1,STR0015,Space(TamSX3("VCF_CODSEG")[1]),"@!",'VAZIO() .OR. FG_Seek("VCH","MV_PAR04",1,.f.)'                ,"VCH",,40,.f.}) // 04-Segmento do Cliente
AADD(aParamBox,{1,STR0016,Space(TamSX3("VCF_AREVEN")[1]),"@!",''                                                            ,"VCB",,20,.f.}) // 05-Regiao de atuacao
AADD(aParamBox,{1,STR0017,Space(TamSX3("VC3_CODMAR")[1]),"@!",'VAZIO() .OR. FG_SEEK("VE1","MV_PAR06",1,.f.)'                ,"VE1",,20,.f.}) // 06-Filtra apenas a Marca
aAdd(aParamBox,{2,STR0018,"1",{"1="+STR0019,"2="+STR0020,"3="+STR0021},80,"",.F.})                                                           // 07-Tipo de Relatorio
AADD(aParamBox,{1,STR0022,Space(TamSX3("VC3_CODMAR")[1]),"@!",'VAZIO() .OR. FG_SEEK("VE1","MV_PAR08",1,.f.)'                ,"VE1",,20,.f.}) // 08-Marca 1a. Coluna
AADD(aParamBox,{1,STR0023,Space(TamSX3("VC3_CODMAR")[1]),"@!",'VAZIO() .OR. FG_SEEK("VE1","MV_PAR09",1,.f.)'                ,"VE1",,20,.f.}) // 09-Marca 2a. Coluna
AADD(aParamBox,{1,STR0024,Space(TamSX3("VC3_CODMAR")[1]),"@!",'VAZIO() .OR. FG_SEEK("VE1","MV_PAR10",1,.f.)'                ,"VE1",,20,.f.}) // 10-Marca 3a. Coluna
AADD(aParamBox,{1,STR0025,Space(TamSX3("VC3_CODMAR")[1]),"@!",'VAZIO() .OR. FG_SEEK("VE1","MV_PAR11",1,.f.)'                ,"VE1",,20,.f.}) // 11-Marca 4a. Coluna
AADD(aParamBox,{1,STR0026,Space(TamSX3("VC3_CODMAR")[1]),"@!",'VAZIO() .OR. FG_SEEK("VE1","MV_PAR12",1,.f.)'                ,"VE1",,20,.f.}) // 12-Marca 5a. Coluna
AADD(aParamBox,{1,STR0027,Space(TamSX3("VC3_CODMAR")[1]),"@!",'VAZIO() .OR. FG_SEEK("VE1","MV_PAR13",1,.f.)'                ,"VE1",,20,.f.}) // 13-Marca 6a. Coluna
AADD(aParamBox,{1,STR0028,Space(TamSX3("VC3_CODMAR")[1]),"@!",'VAZIO() .OR. FG_SEEK("VE1","MV_PAR14",1,.f.)'                ,"VE1",,20,.f.}) // 14-Marca 7a. Coluna
AADD(aParamBox,{1,STR0029,Space(TamSX3("VC3_CODMAR")[1]),"@!",'VAZIO() .OR. FG_SEEK("VE1","MV_PAR15",1,.f.)'                ,"VE1",,20,.f.}) // 15-Marca 8a. Coluna
AADD(aParamBox,{1,STR0030,Space(TamSX3("VC3_CODMAR")[1]),"@!",'VAZIO() .OR. FG_SEEK("VE1","MV_PAR16",1,.f.)'                ,"VE1",,20,.f.}) // 16-Marca 9a. Coluna
AADD(aParamBox,{2,STR0031,"1",{"1="+STR0032,"0="+STR0033},100,"",.F.})                                                                       // 17-Veiculos ou Equipamentos
AADD(aParamBox,{1,STR0034,Space(TamSX3("VCF_VENPEC")[1]),"@!",'VAZIO() .OR. FG_SEEK("SA3","MV_PAR18",1,.f.)'                ,"SA3",,40,.f.}) // 18-Vendedor de Pecas
AADD(aParamBox,{1,STR0035,Space(TamSX3("VCF_VENSRV")[1]),"@!",'VAZIO() .OR. FG_SEEK("SA3","MV_PAR19",1,.f.)'                ,"SA3",,40,.f.}) // 19-Vendedor de Servicos
AADD(aParamBox,{1,STR0036,Space(TamSX3("VCF_VENVEI")[1]),"@!",'VAZIO() .OR. FG_SEEK("SA3","MV_PAR20",1,.f.)'                ,"SA3",,40,.f.}) // 20-Vendedor de Veic.Novos
If lNewVend // Possui campos novos Vendedores
	AADD(aParamBox,{1,STR0037,Space(TamSX3("VCF_VENVEU")[1]),"@!",'VAZIO() .OR. FG_SEEK("SA3","MV_PAR21",1,.f.)'              ,"SA3",,40,.f.}) // 21-Vendedor de Veic.Novos
	AADD(aParamBox,{1,STR0038,Space(TamSX3("VCF_VENPNE")[1]),"@!",'VAZIO() .OR. FG_SEEK("SA3","MV_PAR22",1,.f.)'              ,"SA3",,40,.f.}) // 22-Vendedor de Veic.Novos
	AADD(aParamBox,{1,STR0039,Space(TamSX3("VCF_VENOUT")[1]),"@!",'VAZIO() .OR. FG_SEEK("SA3","MV_PAR23",1,.f.)'              ,"SA3",,40,.f.}) // 23-Vendedor de Veic.Novos
EndIf
If ParamBox(aParamBox,STR0001,@aRetSX1,,,,,,,,.f.)
	cNomeRel:=SetPrint(cAlias,cNomeRel,,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,,cTamanho)
	If nLastKey == 27
		Return
	EndIf
	SetDefault(aReturn,cAlias)
	RptStatus( { |lEnd| FS_IMPVCR630(@lEnd,cNomeRel,cAlias) } , cTitulo )
	If aReturn[5] == 1
		OurSpool( cNomeRel )
	EndIf
	MS_Flush()
EndIf
RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FS_IMPVCR630³ Autor ³ Andre Luis Almeida  ³ Data ³ 05/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao da Frota                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_IMPVCR630()
Local ni         := 0
Local cDesc      := ""
Local lCEVOUT    := ( VAI->(FieldPos("VAI_CEVOUT")) > 0 ) // Visualiza Agendas de Outros Usuarios do CEV? (1=Sim/0=Nao)
Local cCidade    := ""
Local cVendedores:= ""
Private cbTxt    := Space(10)
Private cbCont   := 0
Private cString  := "VCF"
Private Li       := 80
Private m_Pag    := 1
Private wnRel    := "VEICR630"
Private aCli     := {}
Private nCli     := 0
Private nTotal   := 0
Private nFrota   := 0
Private nTotal01 := 0
Private nTotal02 := 0
Private nTotal03 := 0
Private nTotal04 := 0
Private nTotal05 := 0
Private nTotal06 := 0
Private nTotal07 := 0
Private nTotal08 := 0
Private nTotal09 := 0
Private nTotal10 := 0
Private nTotal11 := 0
Private cCol1    := "[ "+left(IIf(len(alltrim(aRetSX1[08]))<3," ","")+aRetSX1[08]+space(4),4)+" ]"
Private cCol2    := "[ "+left(IIf(len(alltrim(aRetSX1[09]))<3," ","")+aRetSX1[09]+space(4),4)+" ]"
Private cCol3    := "[ "+left(IIf(len(alltrim(aRetSX1[10]))<3," ","")+aRetSX1[10]+space(4),4)+" ]"
Private cCol4    := "[ "+left(IIf(len(alltrim(aRetSX1[11]))<3," ","")+aRetSX1[11]+space(4),4)+" ]"
Private cCol5    := "[ "+left(IIf(len(alltrim(aRetSX1[12]))<3," ","")+aRetSX1[12]+space(4),4)+" ]"
Private cCol6    := "[ "+left(IIf(len(alltrim(aRetSX1[13]))<3," ","")+aRetSX1[13]+space(4),4)+" ]"
Private cCol7    := "[ "+left(IIf(len(alltrim(aRetSX1[14]))<3," ","")+aRetSX1[14]+space(4),4)+" ]"
Private cCol8    := "[ "+left(IIf(len(alltrim(aRetSX1[15]))<3," ","")+aRetSX1[15]+space(4),4)+" ]"
Private cCol9    := "[ "+left(IIf(len(alltrim(aRetSX1[16]))<3," ","")+aRetSX1[16]+space(4),4)+" ]"
Private aFrota   := {}
Private aMarcas  := {}
Private lImpCli  := .t.

aAdd(aMarcas,{02,left(aRetSX1[08]+space(3),3)}) // 1a.Coluna
aAdd(aMarcas,{04,left(aRetSX1[09]+space(3),3)}) // 2a.Coluna
aAdd(aMarcas,{06,left(aRetSX1[10]+space(3),3)}) // 3a.Coluna
aAdd(aMarcas,{08,left(aRetSX1[11]+space(3),3)}) // 4a.Coluna
aAdd(aMarcas,{10,left(aRetSX1[12]+space(3),3)}) // 5a.Coluna
aAdd(aMarcas,{12,left(aRetSX1[13]+space(3),3)}) // 6a.Coluna
aAdd(aMarcas,{14,left(aRetSX1[14]+space(3),3)}) // 7a.Coluna
aAdd(aMarcas,{16,left(aRetSX1[15]+space(3),3)}) // 8a.Coluna
aAdd(aMarcas,{18,left(aRetSX1[16]+space(3),3)}) // 9a.Coluna

Set Printer to &cNomeRel
Set Printer On
Set Device  to Printer

If val(aRetSX1[7]) >= 2
	cabec1 := STR0002
	cabec1 += left(STR0034+space(28),28)
	cabec1 += left(STR0035+space(28),28)
	cabec1 += left(STR0036+space(28),28)
	If lNewVend // Possui campos novos Vendedores
		cabec1 += left(STR0037+space(28),28)
		cabec1 += left(STR0038+space(28),28)
		cabec1 += left(STR0039+space(28),28)
	EndIf
Else
	cabec1 := left(STR0003+space(39),39)+cCol1+" "+cCol2+" "+cCol3+" "+cCol4+" "+cCol5+" "+cCol6+" "+cCol7+" "+cCol8+" "+cCol9+STR0004
	cabec2 := "Cliente                                Qtde.IMd Qtde.IMd Qtde.IMd Qtde.IMd Qtde.IMd Qtde.IMd Qtde.IMd Qtde.IMd Qtde.IMd Qtde.IMd Qtde.IMd"

EndIf
nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
//
VAI->(DbSetOrder(4))
VAI->(DbSeek( xFilial("VAI") + __CUSERID ))
//
DbSelectArea("VCF")
DbSetOrder(1)
DbSeek( xFilial("VCF") + Alltrim(aRetSX1[1]+aRetSX1[2]) )
SetRegua( RecCount() )
While !Eof() .and. VCF->VCF_FILIAL == xFilial("VCF") .and. ( Empty(aRetSX1[1]+aRetSX1[2]) .or. VCF->VCF_CODCLI+VCF->VCF_LOJCLI == aRetSX1[1]+aRetSX1[2] )
	IncRegua()
	If !Empty(aRetSX1[3]) .and. VCF->VCF_NIVIMP # aRetSX1[3]
		DbSelectArea("VCF")
		DbSkip()
		Loop
	EndIf
	If !Empty(aRetSX1[4]) .and. VCF->VCF_CODSEG # aRetSX1[4]
		DbSelectArea("VCF")
		DbSkip()
		Loop
	EndIf
	If !Empty(aRetSX1[18]) .and. VCF->VCF_VENPEC # aRetSX1[18]
		DbSelectArea("VCF")
		DbSkip()
		Loop
	EndIf
	If !Empty(aRetSX1[19]) .and. VCF->VCF_VENSRV # aRetSX1[19]
		DbSelectArea("VCF")
		DbSkip()
		Loop
	EndIf
	If !Empty(aRetSX1[20]) .and. VCF->VCF_VENVEI # aRetSX1[20]
		DbSelectArea("VCF")
		DbSkip()
		Loop
	EndIf
	If lNewVend // Possui campos novos Vendedores
		If !Empty(aRetSX1[21]) .and. VCF->VCF_VENVEU # aRetSX1[21]
			DbSelectArea("VCF")
			DbSkip()
			Loop
		EndIf
		If !Empty(aRetSX1[22]) .and. VCF->VCF_VENPNE # aRetSX1[22]
			DbSelectArea("VCF")
			DbSkip()
			Loop
		EndIf
		If !Empty(aRetSX1[23]) .and. VCF->VCF_VENOUT # aRetSX1[23]
			DbSelectArea("VCF")
			DbSkip()
			Loop
		EndIf
		If lCEVOUT .and. VAI->VAI_CEVOUT == "0" .and. !Empty(VCF->VCF_VENPEC+VCF->VCF_VENVEI+VCF->VCF_VENSRV+VCF->VCF_VENVEU+VCF->VCF_VENPNE+VCF->VCF_VENOUT)
			If !( VAI->VAI_CODVEN $ VCF->VCF_VENPEC+"/"+VCF->VCF_VENVEI+"/"+VCF->VCF_VENSRV+"/"+VCF->VCF_VENVEU+"/"+VCF->VCF_VENPNE+"/"+VCF->VCF_VENOUT )
				DbSelectArea("VC1")
				DbSkip()
				Loop
			EndIf
		EndIf
	Else
		If lCEVOUT .and. VAI->VAI_CEVOUT == "0" .and. !Empty(VCF->VCF_VENPEC+VCF->VCF_VENVEI+VCF->VCF_VENSRV)
			If !( VAI->VAI_CODVEN $ VCF->VCF_VENPEC+"/"+VCF->VCF_VENVEI+"/"+VCF->VCF_VENSRV )
				DbSelectArea("VC1")
				DbSkip()
				Loop
			EndIf
		EndIf
	EndIf
	If !Empty(aRetSX1[5])
		If "*" $ aRetSX1[5]
			If left(VCF->VCF_AREVEN,1) # left(aRetSX1[5],1)
				DbSelectArea("VCF")
				DbSkip()
				Loop
			EndIf
		Else
			If VCF->VCF_AREVEN # aRetSX1[5]
				DbSelectArea("VCF")
				DbSkip()
				Loop
			EndIf
		EndIf
	EndIf
	lImpCli := .t.
	aFrota := {}
	nFrota := 0
	nTotal := 0
	DbSelectArea("VC3")
	DbSetOrder(1)
	If DbSeek( xFilial("VC3") + VCF->VCF_CODCLI + VCF->VCF_LOJCLI )
		While !Eof() .and. VC3->VC3_FILIAL == xFilial("VC3") .and. VC3->VC3_CODCLI+VC3->VC3_LOJA == VCF->VCF_CODCLI+VCF->VCF_LOJCLI
			If VC3->VC3_TIPO == aRetSX1[17] .and. Empty(VC3->VC3_DATVEN) // Veiculos/Equipamentos
				If !Empty(aRetSX1[6]) .and. VC3->VC3_CODMAR # aRetSX1[6]
					DbSelectArea("VC3")
					DbSkip()
					Loop
				EndIf
				DbSelectArea("VV2")
				DbSetOrder(1)
				If DbSeek( xFilial("VV2") + VC3->VC3_CODMAR + VC3->VC3_MODVEI )
					cDesc := left(VV2->VV2_DESMOD+space(21),21)
				Else
					cDesc := left(VC3->VC3_MODVEI+space(21),21)
				EndIf
				DbSelectArea("VVB")
				DbSetOrder(1)
				DbSeek( xFilial("VVB") + VV2->VV2_CATVEI )
				DbSelectArea("VCI")
				DbSetOrder(1)
				DbSeek( xFilial("VCI") + VC3->VC3_CODOPE )
				nPos := aScan(aMarcas,{|x| x[2] == VC3->VC3_CODMAR })
				If nPos > 0
					nCol := aMarcas[nPos,1]
				Else
					nCol := 20
				EndIf
				If lImpCli
					lImpCli := .f.
					DbSelectArea("SA1")
					DbSetOrder(1)
					DbSeek( xFilial("SA1") + VCF->VCF_CODCLI + VCF->VCF_LOJCLI )
					If val(aRetSX1[7]) >= 2
						If nLin > 52
							nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
						EndIf
						cVendedores := ""
						SA3->(DbSetOrder(1))
						If !Empty(VCF->VCF_VENPEC) .and. SA3->(DbSeek(xFilial("SA3")+VCF->VCF_VENPEC))
							cVendedores += left(VCF->VCF_VENPEC+"-"+Left(SA3->A3_NREDUZ,27)+space(27),27)+" "
						Else
							cVendedores += space(28)
						EndIf
						If !Empty(VCF->VCF_VENSRV) .and. SA3->(DbSeek(xFilial("SA3")+VCF->VCF_VENSRV))
							cVendedores += left(VCF->VCF_VENSRV+"-"+Left(SA3->A3_NREDUZ,27)+space(27),27)+" "
						Else
							cVendedores += space(28)
						EndIf
						If !Empty(VCF->VCF_VENVEI) .and. SA3->(DbSeek(xFilial("SA3")+VCF->VCF_VENVEI))
							cVendedores += left(VCF->VCF_VENVEI+"-"+Left(SA3->A3_NREDUZ,27)+space(27),27)+" "
						Else
							cVendedores += space(28)
						EndIf
						If lNewVend // Possui campos novos Vendedores
							If !Empty(VCF->VCF_VENVEU) .and. SA3->(DbSeek(xFilial("SA3")+VCF->VCF_VENVEU))
								cVendedores += left(VCF->VCF_VENVEU+"-"+Left(SA3->A3_NREDUZ,27)+space(27),27)+" "
							Else
								cVendedores += space(28)
							EndIf
							If !Empty(VCF->VCF_VENPNE) .and. SA3->(DbSeek(xFilial("SA3")+VCF->VCF_VENPNE))
								cVendedores += left(VCF->VCF_VENPNE+"-"+Left(SA3->A3_NREDUZ,27)+space(27),27)+" "
							Else
								cVendedores += space(28)
							EndIf
							If !Empty(VCF->VCF_VENOUT) .and. SA3->(DbSeek(xFilial("SA3")+VCF->VCF_VENOUT))
								cVendedores += left(VCF->VCF_VENOUT+"-"+Left(SA3->A3_NREDUZ,27)+space(27),27)+" "
							Else
								cVendedores += space(28)
							EndIf
						EndIf
						cCidade := left(SA1->A1_MUN,25)+" "+SA1->A1_EST
						If lA1_IBGE
							VAM->(DbSetOrder(1))
							VAM->(Dbseek(xFilial("VAM")+SA1->A1_IBGE))
							cCidade := left(VAM->VAM_DESCID,25)+" "+VAM->VAM_ESTADO
						EndIf
						@ nLin++,00 psay VCF->VCF_CODCLI+"-"+VCF->VCF_LOJCLI+" "+left(SA1->A1_NOME,25)+" "+left(OFIOA560DS("033",VCF->VCF_CODSEG),15)+" "+cCidade+" "+cVendedores
					EndIf
					aAdd(aCli,{SA1->A1_COD+"-"+SA1->A1_LOJA+" "+left(SA1->A1_NOME,25),0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
					nCli++
				EndIf
				aAdd(aFrota,{nCol,VC3->VC3_CODMAR+" "+cDesc+" "+left(VVB->VVB_DESCRI,15)+" "+left(VCI->VCI_DESOPE,15)+" "+Transform(VC3->VC3_FABMOD,"@R 9999/9999")+str(VC3->VC3_QTDFRO,6)+" "+DtoC(VC3->VC3_DATATU),left(VVB->VVB_DESCRI,15)})
				aCli[nCli,nCol] += VC3->VC3_QTDFRO
				aCli[nCli,22]   += VC3->VC3_QTDFRO
				nTotal += VC3->VC3_QTDFRO
				If !Empty(VC3->VC3_FABMOD)
					aCli[nCli,nCol+1] += (((year(dDataBase)-val(left(VC3->VC3_FABMOD,4)))+1)*VC3->VC3_QTDFRO)
					aCli[nCli,23]     += (((year(dDataBase)-val(left(VC3->VC3_FABMOD,4)))+1)*VC3->VC3_QTDFRO)
					nFrota += (((year(dDataBase)-val(left(VC3->VC3_FABMOD,4)))+1)*VC3->VC3_QTDFRO)
				EndIf
			EndIf
			DbSelectArea("VC3")
			DbSkip()
		EndDo
		If val(aRetSX1[7]) >= 2
			If len(aFrota) > 0
				If val(aRetSX1[7]) == 3
					aSort(aFrota,1,,{|x,y| strzero(x[1],2)+x[3]+left(x[2],25) < strzero(y[1],2)+y[3]+left(y[2],25) })
					If nLin > 58
						nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
					EndIf
					@ nLin++,07 psay STR0006
					For ni := 1 to len(aFrota)
						If nLin > 60
							nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
						EndIf
						@ nLin++,07 psay aFrota[ni,2]
					Next
				EndIf
				@ nLin++,38 psay STR0007+Transform(nFrota/nTotal,"@E 9999")+STR0008+str(nTotal,6)
				nLin++
			EndIf
		EndIf
	EndIf
	DbSelectArea("VCF")
	DbSkip()
	Loop
EndDo

cabec1 := left(STR0003+space(39),39)+cCol1+" "+cCol2+" "+cCol3+" "+cCol4+" "+cCol5+" "+cCol6+" "+cCol7+" "+cCol8+" "+cCol9+STR0004
cabec2 := "Cliente                                Qtde.IMd Qtde.IMd Qtde.IMd Qtde.IMd Qtde.IMd Qtde.IMd Qtde.IMd Qtde.IMd Qtde.IMd Qtde.IMd Qtde.IMd"
If val(aRetSX1[7]) >= 2
	nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
EndIf
For ni := 1 to len(aCli)
	If nLin > 60
		nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,cTamanho,nCaracter) + 1
	EndIf
	@ nLin++,00 psay aCli[ni,1]+" "+;
	Transform(aCli[ni,02],"@E 99999")+Transform(aCli[ni,03]/aCli[ni,02],"@E 9999")+;
	Transform(aCli[ni,04],"@E 99999")+Transform(aCli[ni,05]/aCli[ni,04],"@E 9999")+;
	Transform(aCli[ni,06],"@E 99999")+Transform(aCli[ni,07]/aCli[ni,06],"@E 9999")+;
	Transform(aCli[ni,08],"@E 99999")+Transform(aCli[ni,09]/aCli[ni,08],"@E 9999")+;
	Transform(aCli[ni,10],"@E 99999")+Transform(aCli[ni,11]/aCli[ni,10],"@E 9999")+;
	Transform(aCli[ni,12],"@E 99999")+Transform(aCli[ni,13]/aCli[ni,12],"@E 9999")+;
	Transform(aCli[ni,14],"@E 99999")+Transform(aCli[ni,15]/aCli[ni,14],"@E 9999")+;
	Transform(aCli[ni,16],"@E 99999")+Transform(aCli[ni,17]/aCli[ni,16],"@E 9999")+;
	Transform(aCli[ni,18],"@E 99999")+Transform(aCli[ni,19]/aCli[ni,18],"@E 9999")+;
	Transform(aCli[ni,20],"@E 99999")+Transform(aCli[ni,21]/aCli[ni,20],"@E 9999")+;
	Transform(aCli[ni,22],"@E 99999")+Transform(aCli[ni,23]/aCli[ni,22],"@E 9999")
	nTotal01 += aCli[ni,02]
	nTotal02 += aCli[ni,04]
	nTotal03 += aCli[ni,06]
	nTotal04 += aCli[ni,08]
	nTotal05 += aCli[ni,10]
	nTotal06 += aCli[ni,12]
	nTotal07 += aCli[ni,14]
	nTotal08 += aCli[ni,16]
	nTotal09 += aCli[ni,18]
	nTotal10 += aCli[ni,20]
	nTotal11 += aCli[ni,22]
Next
nLin++
nTamLoj := Len(SA1->A1_LOJA)
@ nLin++,00 psay left(STR0009+space(30+nTamLoj),30+nTamLoj) + Transform(nTotal01,"@E 999999999")+;
												Transform(nTotal02,"@E 999999999")+;
												Transform(nTotal03,"@E 999999999")+;
												Transform(nTotal04,"@E 999999999")+;
												Transform(nTotal05,"@E 999999999")+;
												Transform(nTotal06,"@E 999999999")+;
												Transform(nTotal07,"@E 999999999")+;
												Transform(nTotal08,"@E 999999999")+;
												Transform(nTotal09,"@E 999999999")+;
												Transform(nTotal10,"@E 999999999")+;
												Transform(nTotal11,"@E 999999999")
Set Printer to
Set Device  to Screen

Return
