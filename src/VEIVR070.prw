/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 27     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼
#INCLUDE "VEIVR070.ch"
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VEIVR070  º Autor ³ Ricardo Farinelli  º Data ³  04/06/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Movimentacao de Veiculos Por Periodo.         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Gestao de Concessionarias                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEIVR070()
Local oReport
Local aArea := GetArea()
Private lTIPMOV	:= ( VV0->(FieldPos("VV0_TIPMOV")) > 0 ) // Tipo de Movimento ( Normal / Agregacao / Desagregacao )
If FindFunction("TRepInUse") .And. TRepInUse()
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	U_FS_VR070Imp()
EndIf
RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef³ Autor ³ Andre Luis Almeida    ³ Data ³ 20/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio usando o TReport                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport
Local oSection1
Local oSection2
Local oSection3
Local oSection4
Local oSection5
Local oSection6
Private cPerg       := "VEV070"

ValidPerg()

oReport := TReport():New("VEIVR070",STR0094,"VEV070",{|oReport| U_VR070IMP(oReport)})

oSection1 := TRSection():New(oReport,STR0036,{"VVA","VV1"})
TRCell():New(oSection1,"VVA_CHAINT","VVA",STR0037,,30)
TRCell():New(oSection1,"VV1_CODMAR","VV1",STR0038,,10)
TRCell():New(oSection1,"VE1_DESMAR","VE1","",,25)
TRCell():New(oSection1,"VV1_FABMOD","VV1",STR0039,,15)
TRCell():New(oSection1,"VV1_CHASSI","VV1",STR0040,,30)
TRCell():New(oSection1,"VV1_MODVEI","VV1",STR0041,,30)
TRCell():New(oSection1,"VV2_DESMOD","VV2",STR0042,,40)
TRCell():New(oSection1,"VV1_COMMOD","VV1",STR0043,"@!",35)
TRCell():New(oSection1,"VV1_CORVEI","VV1",STR0044,"@!",20)
TRCell():New(oSection1,"VVC_DESCRI","VVC",STR0045,"@!",25)
TRCell():New(oSection1,"t9",,STR0046,"@!",60,,{|| cOpeMov })

TRPosition():New(oSection1,"VE1",1,{|| xFilial("VE1")+VV1->VV1_CODMAR })
TRPosition():New(oSection1,"VV2",1,{|| xFilial("VV2")+VV1->VV1_CODMAR+VV1->VV1_MODVEI })
TRPosition():New(oSection1,"VVC",1,{|| xFilial("VVC")+VV1->VV1_CODMAR+VV1->VV1_CORVEI })

oSection2 := TRSection():New(oReport,STR0047,{})
TRCell():New(oSection2,"",,"","@!",500,,{|| "" })

oSection3 := TRSection():New(oReport,STR0048,{"VVF","VVG"})
TRCell():New(oSection3,"t8",,"","@!",20,,{|| STR0016 })
TRCell():New(oSection3,"VVF_CODFOR","VVF",STR0049,,25)
TRCell():New(oSection3,"A2_NOME","SA2",STR0050,,50)
TRCell():New(oSection3,"VVF_DATMOV","VVF",STR0051,,25)
TRCell():New(oSection3,"VVF_NUMNFI","VVF",STR0052,,15)
TRCell():New(oSection3,FGX_MILSNF("VVF", 3, "VVF_SERNFI"),"VVF",STR0053,,30)
TRCell():New(oSection3,"VVG_VALUNI","VVG",STR0054,,30)
TRCell():New(oSection3,"VVG_VCNVEI","VVG",STR0055,,40)
TRCell():New(oSection3,"t7",,STR0056,"@E 9,999,999.99",60,,{|| nICM })
TRCell():New(oSection3,"t6",,STR0057,"@E 99.99",60,,{|| nAliq })
TRCell():New(oSection3,"VVG_VALIPI","VVG",STR0058,"@E 99,999,999.99",35)
TRCell():New(oSection3,"VVG_ALIIPI","VV1",STR0059,"@E 99.99",20)

TRPosition():New(oSection3,"SA2",1,{|| xFilial("SA2")+VVF->VVF_CODFOR+VVF->VVF_LOJA })

oSection4 := TRSection():New(oReport,STR0060,{"VV0","VVA"})
TRCell():New(oSection4,"t8",,"","@!",60,,{|| STR0018 })
TRCell():New(oSection4,"VV0_CODCLI","VV0",STR0061,,7)
TRCell():New(oSection4,"VV0_LOJA","VV0",STR0062,,10)
TRCell():New(oSection4,"A1_NOME","SA1",STR0050,,25)
TRCell():New(oSection4,"VV0_DATMOV","VV0",STR0063,,15)
TRCell():New(oSection4,"VV0_NUMNFI","VV0",STR0052,,30)
TRCell():New(oSection4,FGX_MILSNF("VV0", 3, "VV0_SERNFI"),"VV0",STR0064,,30)
TRCell():New(oSection4,"VVA_PISVEN","VVA",STR0065,"@E 999,999.99",40)
TRCell():New(oSection4,"VVA_COFVEN","VVA",STR0066,"@E 999,999.99",35)
TRCell():New(oSection4,"VVA_ICMVEN","VVA",STR0056,"@E 999,999.99",20)
TRCell():New(oSection4,"VVA_ALIICM","VVA",STR0057,"@E 99.99",20)
TRCell():New(oSection4,"VVA_FATTOT","VVA",STR0067,"@E 999,999.99",20)
TRCell():New(oSection4,"VV0_CODVEN","VV0",STR0068,"@",20)
TRCell():New(oSection4,"A3_NOME","SA3",STR0069,"@",80)
TRCell():New(oSection4,"A1_END","SA3",STR0070,"@",80)
TRCell():New(oSection4,"A1_TEL","SA3",STR0071,"@",80)

TRPosition():New(oSection4,"SA1",1,{|| xFilial("SA1")+VV0->VV0_CODCLI+VV0->VV0_LOJA })

oSection5 := TRSection():New(oReport,STR0072,{"VVA"})
TRCell():New(oSection5,"t5",,STR0072,"@!",60,,{|| cTipFat })
TRCell():New(oSection5,"VVA_BONFAB","VVA",STR0073,"@E 999,999.99",15)
TRCell():New(oSection5,"VVA_SEGVIA","VVA",STR0074,"@E 999,999.99",15)
TRCell():New(oSection5,"VVA_ASSIMP","VVA",STR0075,"@E 999,999.99",15)
TRCell():New(oSection5,"VVA_VALREV","VVA",STR0076,"@E 999,999.99",15)
TRCell():New(oSection5,"VVA_VALASS","VVA",STR0077,"@E 999,999.99",15)

oSection6:= TRSection():New(oReport,"",{})
TRCell():New(oSection6,"",,"","@!",500,,{|| Replicate("-",220) })
//
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³VR070IMP  ³ Autor ³ Andre Luis Almeida    ³ Data ³ 20/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Impressao do relatorio.                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VR070IMP(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(2)
Local oSection3 := oReport:Section(3)
Local oSection4 := oReport:Section(4)
Local oSection5 := oReport:Section(5)
Local oSection6 := oReport:Section(6)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Local aOrd          := {}
//Local cDesc1        := STR0001 //"Este programa tem como objetivo imprimir a movi- "
//Local cDesc2        := STR0002 //"mentacao dos veiculos realizadas no periodo sele-"
//Local cDesc3        := STR0003 //"cionados"
//Local cPict         := ""
//Local imprime       := .T.
Local wnrel         := "VEIVR070" // Coloque aqui o nome do arquivo usado para impressao em disco
Local cString       := "VVF"
Local nwnk          := 1
Private aValores    := {}// Vetor com os Totais para venda, remessa, transferencia e devolucao
Private cTipo       := ""
Private titulo      := STR0004 //"Movimentacao de Veiculos no Periodo"
Private nLin        := 80
Private lEnd        := .F.
Private lAbortPrint := .F.
Private limite      := 220
Private tamanho     := "G"
Private Cabec1      := STR0005 //"[C.In] [Marca--------------------------] [Fab/Mod] [Chassi do Veiculo------] [Codigo Modelo---------------] [Descricao Modelo------------] [Complemento Modelo] [Cor do Veiculo------------------------] [Operação do Movto]"
Private Cabec2      := " "
Private nTipo       := 15
Private aReturn     := {STR0006, 1,STR0007 , 1, 2, 1, "", 1}  //"Zebrado"###"Administracao"
Private nLastKey    := 0
Private cPerg       := "VEV070"
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01  
Private cTipFat     := ""

oSection1:Init()
oSection2:Init()
oSection3:Init()
oSection4:Init()
oSection5:Init()
oSection6:Init()

// Basear relatorio na movimentacao de saida do veiculo.
dbSelectArea("VV0")
dbSetOrder(2)

ValidPerg()

pergunte(cPerg,.F.)

dbSelectArea(cString)
dbSetOrder(2)

Titulo += STR0008+Dtoc(MV_PAR01)+STR0009+Dtoc(MV_PAR02) //" de "###" a "

if MV_PAR04 == 1
	Titulo += STR0010+" "+STR0011
Elseif MV_PAR04 == 2
	Titulo += STR0010+" "+STR0030
Elseif MV_PAR04 == 3
	Titulo += STR0010+" "+STR0031
Elseif MV_PAR04 == 4
	Titulo += STR0010+" "+STR0012
Else
	Titulo += STR0010+" "+STR0013
Endif

// Ou seleciona todas as opcoes ou imprime apenas a escolhida.
For nwnk := 1 to 4
	
	If MV_PAR04==5
		cTipo := If(nwnk==1,"0",str(nwnk,1))
	Else
		cTipo := If(MV_PAR04==1,"0",str(MV_PAR04,1))
		if nwnk > 1
			exit
		endif
	Endif
	
	// Posiciona no primeiro registro conforme a data inicial informada
	if mv_par04 == 4
		if cTipo == "4" // alterado pois quando e devolucao o sistema nao altera o vv0_opemov para 4 , altera somente o vv0_sitnfi para 2
			cTipo := "0"
		Endif
	Endif
	
	VV0->(DBSetOrder(2))
	VV0->(Dbseek(xFilial("VV0")+cTipo+Dtos(MV_PAR01),.T.))
	
	Do While (VV0->(VV0_FILIAL+VV0_OPEMOV)) == (xFilial("VV0")+cTipo) .and. !VV0->(Eof())
		//  Do While VV0->VV0_FILIAL == xFilial("VV0") .and. !VV0->(Eof())
		
		If lAbortPrint .or. lEnd
			@nLin,00 PSAY STR0014 //"*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
		If VV0->VV0_DATMOV > MV_PAR02
			Exit
		Endif
		If MV_PAR04==1 .and. (VV0->VV0_OPEMOV<>"0" .or. VV0->VV0_SITNFI == "2")
			VV0->(Dbskip())
			Loop
		Endif
		If MV_PAR04==2 .and. (VV0->VV0_OPEMOV<>"2")
			VV0->(Dbskip())
			Loop
		Endif
		If MV_PAR04==3 .and. (VV0->VV0_OPEMOV<>"3")
			VV0->(Dbskip())
			Loop
		Endif
		If MV_PAR04==4 .and. ( VV0->VV0_OPEMOV <>"4" .and. (VV0->VV0_OPEMOV == "0" .and. VV0->VV0_SITNFI <> "2") )      //FNC 22679/2010 - BOBY - DEVOLUCAO
			VV0->(Dbskip())
			Loop
		Endif
		If Empty(Alltrim(VV0->VV0_NUMNFI)) // Se for apenas NF
			VV0->(Dbskip())
			Loop
		Endif
		If Empty(Alltrim(VV0->VV0_SITNFI)) // Se tiver situacao da NF
			VV0->(Dbskip())
			Loop
		Endif
		If lTIPMOV
			If VV0->VV0_TIPMOV <> ' ' .and. VV0->VV0_TIPMOV <> '0'
				VV0->(Dbskip())
				Loop
			EndIf
		EndIf
		If nLin+11 > 58
			Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
			nLin := 9
		Endif
		dbSelectArea("VVA")
		dbSetOrder(1)
		dbSeek(xFilial("VVA")+VV0->VV0_NUMTRA)
		While !eof() .and. VVA->VVA_NUMTRA == VV0->VV0_NUMTRA
			if  !Empty(MV_PAR05)
				if VVA->VVA_CHASSI <> alltrim(MV_PAR05)
					VVA->(Dbskip())
					Loop
				Endif
			Endif
			// Posiciona nos principais arquivos - saida
			VR70POSSAI()
			
			// Verifica se o modelo se enquadra no solicitado na pergunte
			If !Empty(MV_PAR03)
				If !VV1->VV1_MODVEI==MV_PAR03
					VVA->(Dbskip())
					Loop
				Endif
			Endif
			nICM  := 0
			aAliq := 0
			// Posiciona nos principais arquivos - entrada
			VR70POSENT()
			If VR70GETICMS(VV0->VV0_NUMNFI, VV0->VV0_SERNFI)
				//      nICM  := Transform(VVG->VVG_ICMCOM,TM(VVG->VVG_ICMCOM,12))
				//      nAliq := Transform(VVG->VVG_ALIICM,TM(VVG->VVG_ALIICM,5))
				nICM  := VVG->VVG_ICMCOM
				nAliq := VVG->VVG_ALIICM
			Else
				nICM  := 0
				nAliq := 0
			EndIf
			
			cOpeMov := If((VV0->VV0_OPEMOV=="0" .and. VV0->VV0_SITNFI <> "2") ,STR0027,If(VV0->VV0_OPEMOV=="2",STR0030,If(VV0->VV0_OPEMOV=="3",STR0031, If(VV0->VV0_OPEMOV=="1",STR0029, If(VV0->VV0_OPEMOV=="4" .or. (VV0->VV0_OPEMOV == "0" .and. VV0->VV0_SITNFI == "2"),STR0012, If(VV0->VV0_OPEMOV=="5",STR0032, If(VV0->VV0_OPEMOV=="6",STR0033, If(VV0->VV0_OPEMOV=="7",STR0034,STR0035) ))))))) //"Venda"###"Transferencia"###"Remessa"###"Simulação"###"Devolução"###"Consignado"###"Ret. Remessa"###"Ret. Consignado"###"Venda Futura"
			oSection1:PrintLine()
			oSection2:PrintLine()
			oSection2:PrintLine()
			oSection3:PrintLine()
	  		oSection2:PrintLine()
			oSection2:PrintLine()
			oSection2:PrintLine()
			oSection4:PrintLine()
			oSection2:PrintLine()
			cTipFat := Iif(VV0->VV0_TIPFAT=="0",STR0020,Iif(VV0->VV0_TIPFAT=="1",STR0021,STR0022)) //"Veiculo Novo"###"Veiculo Usado"###"Fat.Direto"
			oSection5:PrintLine()
			oSection6:PrintLine()
			DbSelectArea("VVA")
			DbSkip()
		Enddo

		VV0->(Dbskip())
		
		If VV0->VV0_DATMOV > MV_PAR02
			Exit
		Endif
		
	Enddo
	
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FS_VR070Imp³ Autor ³ Andre Luis Almeida    ³ Data ³ 20/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Impressao do relatorio.                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_VR070Imp()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aOrd          := {}
Local cDesc1        := STR0094 //"Este programa tem como objetivo imprimir a movi- "
Local cDesc2        := ""
Local cDesc3        := ""
Local cPict         := ""
Local imprime       := .T.
Local wnrel         := "VEIVR070" // Coloque aqui o nome do arquivo usado para impressao em disco
Local cString       := "VVF"
Private titulo      := STR0004 //"Movimentacao de Veiculos no Periodo"
Private nLin        := 80
Private lEnd        := .F.
Private lAbortPrint := .F.
Private limite      := 220
Private tamanho     := "G"
Private Cabec1      := STR0005 //"[C.In] [Marca--------------------------] [Fab/Mod] [Chassi do Veiculo------] [Codigo Modelo---------------] [Descricao Modelo------------] [Complemento Modelo] [Cor do Veiculo------------------------] [Operação do Movto]"
Private Cabec2      := " "
Private nTipo       := 15
Private aReturn     := {STR0006, 1,STR0007 , 1, 2, 1, "", 1}  //"Zebrado"###"Administracao"
Private nLastKey    := 0
Private cPerg       := "VEV070"
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01

// Basear relatorio na movimentacao de saida do veiculo.
dbSelectArea("VV0")
dbSetOrder(2)

ValidPerg()

pergunte(cPerg,.F.)

wnrel    := SetPrint(cString,wnrel   ,cPerg,@titulo ,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

RptStatus({|lEnd| U_VEIVR70IMP(@lEnd,wnrel,cString)},Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³VEIVR70IMPº Autor ³ Ricardo Farinelli  º Data ³  04/06/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar para a impressao do relatorio de movimenta-º±±
±±º          ³ cao no periodo informado.                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Gestao de Concessionarias                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function VEIVR70IMP(lEnd,wnrel,cString)

Local nwnk       := 1
Private aValores := {}// Vetor com os Totais para venda, remessa, transferencia e devolucao
Private cTipo    := ""

dbSelectArea(cString)
dbSetOrder(2)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetRegua(RecCount())

/*
BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³MV_PAR01 = Data Inicial                                                                               ³
//³MV_PAR02 = Data Final                                                                                 ³
//³MV_PAR03 = Modelo = ou informar um modelo ou deixar em branco para imprimir todos                     ³
//³MV_PAR04 = Considera = 1 - Venda, 2 - Transferencia, 3 - Remessa, 4 - Devolucao, 5 - Todas            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC
*/
Titulo += STR0008+Dtoc(MV_PAR01)+STR0009+Dtoc(MV_PAR02) //" de "###" a "

if MV_PAR04 == 1
	Titulo += STR0010+" "+STR0011
Elseif MV_PAR04 == 2
	Titulo += STR0010+" "+STR0030
Elseif MV_PAR04 == 3
	Titulo += STR0010+" "+STR0031
Elseif MV_PAR04 == 4
	Titulo += STR0010+" "+STR0012
Else
	Titulo += STR0010+" "+STR0013
Endif
// Ou seleciona todas as opcoes ou imprime apenas a escolhida.
For nwnk := 1 to 4
	
	If MV_PAR04==5
		cTipo := If(nwnk==1,"0",str(nwnk,1))
	Else
		cTipo := If(MV_PAR04==1,"0",str(MV_PAR04,1))
		if nwnk > 1
			exit
		endif
	Endif
	
	// Posiciona no primeiro registro conforme a data inicial informada
	if mv_par04 == 4
		if cTipo == "4" // alterado pois quando e devolucao o sistema nao altera o vv0_opemov para 4 , altera somente o vv0_sitnfi para 2
			cTipo := "0"
		Endif
	Endif
	
	VV0->(DBSetOrder(2))
	VV0->(Dbseek(xFilial("VV0")+cTipo+Dtos(MV_PAR01),.T.))
	
	Do While (VV0->(VV0_FILIAL+VV0_OPEMOV)) == (xFilial("VV0")+cTipo) .and. !VV0->(Eof())
		//  Do While VV0->VV0_FILIAL == xFilial("VV0") .and. !VV0->(Eof())
		
		If lAbortPrint .or. lEnd
			@nLin,00 PSAY STR0014 //"*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
		If VV0->VV0_DATMOV > MV_PAR02
			Exit
		Endif
		If MV_PAR04==1 .and. (VV0->VV0_OPEMOV<>"0" .or. VV0->VV0_SITNFI == "2")
			VV0->(Dbskip())
			Loop
		Endif
		If MV_PAR04==2 .and. (VV0->VV0_OPEMOV<>"2")
			VV0->(Dbskip())
			Loop
		Endif
		If MV_PAR04==3 .and. (VV0->VV0_OPEMOV<>"3")
			VV0->(Dbskip())
			Loop
		Endif
		If MV_PAR04==4 .and. ( VV0->VV0_OPEMOV <>"4" .and. (VV0->VV0_OPEMOV == "0" .and. VV0->VV0_SITNFI <> "2") )      //FNC 22679/2010 - BOBY - DEVOLUCAO
			VV0->(Dbskip())
			Loop
		Endif
		If Empty(Alltrim(VV0->VV0_NUMNFI)) // Se for apenas NF
			VV0->(Dbskip())
			Loop
		Endif
		If Empty(Alltrim(VV0->VV0_SITNFI)) // Se tiver situacao da NF
			VV0->(Dbskip())
			Loop
		Endif
		If lTIPMOV
			If VV0->VV0_TIPMOV <> ' ' .and. VV0->VV0_TIPMOV <> '0'
				VV0->(Dbskip())
				Loop
			EndIf
		EndIf
		If nLin+11 > 58
			Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
			nLin := 9
		Endif
		dbSelectArea("VVA")
		dbSetOrder(1)
		dbSeek(xFilial("VVA")+VV0->VV0_NUMTRA)
		While !eof() .and. VVA->VVA_NUMTRA == VV0->VV0_NUMTRA
			if !Empty(MV_PAR05)
				if VVA->VVA_CHASSI <> alltrim(MV_PAR05)
					VVA->(Dbskip())
					Loop
				Endif
			Endif
			// Posiciona nos principais arquivos - saida
			VR70POSSAI()
			
			// Verifica se o modelo se enquadra no solicitado na pergunte
			If !Empty(MV_PAR03)
				If !VV1->VV1_MODVEI==MV_PAR03
					VVA->(Dbskip())
					Loop
				Endif
			Endif
			nICM  := 0
			aAliq := 0
			// Posiciona nos principais arquivos - entrada
			VR70POSENT()
			If VR70GETICMS(VV0->VV0_NUMNFI, VV0->VV0_SERNFI)
				//      nICM  := Transform(VVG->VVG_ICMCOM,TM(VVG->VVG_ICMCOM,12))
				//      nAliq := Transform(VVG->VVG_ALIICM,TM(VVG->VVG_ALIICM,5))
				nICM  := VVG->VVG_ICMCOM
				nAliq := VVG->VVG_ALIICM
			Else
				nICM  := 0
				nAliq := 0
			EndIf
			@ nLin,001 PSAY VVA->VVA_CHAINT
			@ nLin,008 PSAY VV1->VV1_CODMAR+"-"+VE1->VE1_DESMAR
			@ nLin,042 PSAY Transform(VV1->VV1_FABMOD,"@R ####/####")
			@ nLin,052 PSAY VV1->VV1_CHASSI
			@ nLin,078 PSAY VV1->VV1_MODVEI
			@ nLin,110 PSAY VV2->VV2_DESMOD
			@ nLin,141 PSAY VV1->VV1_COMMOD
			@ nLin,162 PSAY VV1->VV1_CORVEI+"- "+Left(VVC->VVC_DESCRI,30)
			//    @ nLin,203 PSAY If(VV0->VV0_OPEMOV=="0",STR0028,If(VV0->VV0_OPEMOV=="2",STR0029,If(VV0->VV0_OPEMOV=="3",STR0030,STR0031)))
			//  FNC - 22679/2010 - BOBY - 08/10/10   / 28/10
			@ nLin,203 PSAY If((VV0->VV0_OPEMOV=="0" .and. VV0->VV0_SITNFI <> "2") ,STR0027,If(VV0->VV0_OPEMOV=="2",STR0030,If(VV0->VV0_OPEMOV=="3",STR0031, If(VV0->VV0_OPEMOV=="1",STR0029, If(VV0->VV0_OPEMOV=="4" .or. (VV0->VV0_OPEMOV == "0" .and. VV0->VV0_SITNFI == "2"),STR0012, If(VV0->VV0_OPEMOV=="5",STR0032, If(VV0->VV0_OPEMOV=="6",STR0033, If(VV0->VV0_OPEMOV=="7",STR0034,STR0035) ))))))) //"Venda"###"Transferencia"###"Remessa"###"Simulação"###"Devolução"###"Consignado"###"Ret. Remessa"###"Ret. Consignado"###"Venda Futura"
			nLin+=2
			//                           12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
			@ nLin,010 PSAY STR0015 //"[Fornecedor-----------------------------------] [Dt Ent] [No.NF/Ser] [Vlr  Custo] [Vlr  Total] [Valor Icms] [Aliq] [Valor  Ipi] [Aliq]"
			nLin++
			@ nLin,001 PSAY STR0016 //"Entrada:"
			@ nLin,010 PSAY VVF->VVF_CODFOR+"-"+SA2->A2_NOME
			@ nLin,058 PSAY VVF->VVF_DATMOV
			@ nLin,069 PSAY VVF->VVF_NUMNFI+"/"+ FGX_MILSNF("VVF", 2, "VVF_SERNFI")
			@ nLin,082 PSAY Transform(VVG->VVG_VALUNI,TM(VVG->VVG_VALUNI,12))
			@ nLin,095 PSAY Transform(VVG->VVG_VCNVEI,TM(VVG->VVG_VCNVEI,12))
			//@ nLin,104 PSAY Transform(VVG->VVG_ICMCOM,TM(VVG->VVG_ICMCOM,12))
			@ nLin,108 PSAY Transform(nICM,"@E 9,999,999.99")   // FNC - 22679/2010 - BOBY - 08/10/10
			@ nLin,121 PSAY Transform(nAliq,"@E 99.99")         // FNC - 22679/2010 - BOBY - 08/10/10
			@ nLin,127 PSAY Transform(VVG->VVG_VALIPI,TM(VVG->VVG_VALIPI,12))
			@ nLin,141 PSAY Transform(VVG->VVG_ALIIPI,TM(VVG->VVG_ALIIPI,5))
			nLin+=2
			
			@ nLin,010 PSAY STR0017 //"[Cliente--------------------------------------] [Dt Sai] [No.NF/Ser] [Valor Pis-] [Vlr Cofins] [Valor Icms] [Aliq] [Vlr  Total] [Vendedor                 ]"
			nLin++
			@ nLin,001 PSAY STR0018 //"Saida..:"
			@ nLin,010 PSAY VV0->VV0_CODCLI+"/"+VV0->VV0_LOJA+"-"+Substr(SA1->A1_NOME,1,37)
			@ nLin,058 PSAY VV0->VV0_DATMOV
			@ nLin,068 PSAY VV0->VV0_NUMNFI+"/"+ FGX_MILSNF("VV0", 2, "VV0_SERNFI")
			@ nLin,082 PSAY Transform(VVA->VVA_PISVEN,TM(VVA->VVA_PISVEN,12))
			@ nLin,095 PSAY Transform(VVA->VVA_COFVEN,TM(VVA->VVA_COFVEN,12))
			@ nLin,108 PSAY Transform(VVA->VVA_ICMVEN,TM(VVA->VVA_ICMVEN,12))
			@ nLin,122 PSAY Transform(VVA->VVA_ALIICM,TM(VVA->VVA_ALIICM,5))
			@ nLin,128 PSAY Transform(VVA->VVA_FATTOT,TM(VVA->VVA_FATTOT,12))
			DbSelectArea( "SA3" )
			DbSetOrder(1)
			DbSeek( xFilial("SA3") + VV0->VV0_CODVEN )
			@ nLin,143 PSAY VV0->VV0_CODVEN + " - " + left(SA3->A3_NOME,15)
			@ nLin,169 PSAY Left(SA1->A1_END,36)
			@ nLin,208 PSAY SA1->A1_TEL
			nLin++
			@ nLin,056 PSAY STR0019 //"[Tp Faturam.] [Bonus Fabr] [Seg Viagem] [Assessoria] [ Revisoes ] [Associacao]"
			@ nLin,169 PSAY Transform(SA1->A1_CEP,"@R 99999-999") + " - " + Alltrim(SA1->A1_MUN) + "-" + SA1->A1_EST
			nLin++
			@ nLin,056 PSAY Iif(VV0->VV0_TIPFAT=="0",STR0020,Iif(VV0->VV0_TIPFAT=="1",STR0021,STR0022)) //"Veiculo Novo"###"Veiculo Usado"###"Fat.Direto"
			@ nLin,070 PSAY Transform(VVA->VVA_BONFAB,TM(VVA->VVA_BONFAB,12))
			@ nLin,083 PSAY Transform(VVA->VVA_SEGVIA,TM(VVA->VVA_SEGVIA,12))
			@ nLin,096 PSAY Transform(VVA->VVA_ASSIMP,TM(VVA->VVA_ASSIMP,12))
			@ nLin,109 PSAY Transform(VVA->VVA_VALREV,TM(VVA->VVA_VALREV,12))
			@ nLin,122 PSAY Transform(VVA->VVA_VALASS,TM(VVA->VVA_VALASS,12))
			nLin++
			@ nLin,001 PSAY Replicate("-",220)
			nLin++
			
			If nLin > 58
				Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
				nLin := 9
			Endif
			
			VVA->(Dbskip())

		Enddo
		
		IncRegua()
		VV0->(Dbskip())
		
		If VV0->VV0_DATMOV > MV_PAR02
			Exit
		Endif
		
	Enddo
	
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³VALIDPERG º Autor ³ Ricardo Farinelli  º Data ³  04/06/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Verifica a existencia das perguntas criando-as caso seja   º±±
±±º          ³ necessario (caso nao existam).                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ValidPerg

Local _sAlias   := Alias()
Local aRegs     := {} , i , j
Local aHelpPor	:={}
Local aHelpEng	:={}
Local aHelpSpa	:={}

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,Len(SX1->X1_GRUPO))

Aadd(aRegs,{cPerg,"01",STR0023,STR0023,STR0023,"mv_ch1","D", 8,0,0,"G",""                                   ,"mv_par01",""     ,"","","","",""     ,"","","","",""     ,"","","","",""     ,"","","","",""     ,"","","",""   ,""})
Aadd(aRegs,{cPerg,"02",STR0024,STR0024,STR0024,"mv_ch2","D", 8,0,0,"G","NaoVazio() .and. MV_par02>=Mv_PAR01","mv_par02",""     ,"","","","",""     ,"","","","",""     ,"","","","",""     ,"","","","",""     ,"","","",""   ,""})
Aadd(aRegs,{cPerg,"03",STR0025,STR0025,STR0025,"mv_ch3","C",30,0,0,"G",""                                   ,"mv_par03",""     ,"","","","",""     ,"","","","",""     ,"","","","",""     ,"","","","",""     ,"","","","VV2",""})
Aadd(aRegs,{cPerg,"04",STR0026,STR0026,STR0026,"mv_ch4","N", 1,0,0,"C","NaoVazio()"                         ,"mv_par04",STR0027,"","","","",STR0030,"","","","",STR0031,"","","","",STR0012,"","","","",STR0013,"","","",""   ,""})
// STR0027 ### STR0030 ### STR0031 ### STR0012 ###STR0013  - "Venda"###"Transferencia"###"Remessa"###"Devolucao"###"Todas"
Aadd(aRegs,{cPerg,"05",STR0028,STR0028,STR0028,"mv_ch5","C",25,0,0,"G",""                                   ,"mv_par05",""     ,"","","","",""     ,"","","","",""     ,"","","","",""     ,"","","","",""     ,"","","","VV1",""})
//23 "Data Inicial?"//24 "Data Final?"//25 "Modelo?"//26 "Tipo Operacao?"//28 "Chassi?"

For i:=1 to Len(aRegs)
	If dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.F.)
	Else
		RecLock("SX1",.T.)
	Endif
	For j:=1 to FCount()
		If j <= Len(aRegs[i])
			if j <> 17
				FieldPut(j,aRegs[i,j])
			Endif
		Endif
	Next
	MsUnlock()
	
	aHelpPor := aHelpSpa := aHelpEng := {}
	
	If i == 1
		AADD(aHelpPor,STR0078)
		AAdd(aHelpPor,STR0079)
	ElseIf i == 2
		AAdd(aHelpPor,STR0080)
		AAdd(aHelpPor,STR0079)
	ElseIf i == 3    //1234567890123456789012345678901234567890
		AAdd(aHelpPor,STR0081)
		AAdd(aHelpPor,STR0082)
		AAdd(aHelpPor,STR0083)
		AAdd(aHelpPor,STR0084)
	ElseIf i == 4
		AAdd(aHelpPor,STR0085)
		AAdd(aHelpPor,STR0086)
		AAdd(aHelpPor,STR0087)
		AAdd(aHelpPor,STR0088)
		AAdd(aHelpPor,STR0089)
		AAdd(aHelpPor,STR0090)
	ElseIf i == 5
		AAdd(aHelpPor,STR0091)
		AAdd(aHelpPor,STR0092)
		AAdd(aHelpPor,STR0083)
		AAdd(aHelpPor,STR0093)
	EndIf
	
	//	PutSX1Help("P."+cPerg+strzero(i,2)+".",aHelpPor,aHelpEng,aHelpSpa)
	PutSX1Help("P.VEV070"+strzero(i,2)+".",aHelpPor,aHelpEng,aHelpSpa)
	
Next

dbSelectArea(_sAlias)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VR60POSENTºAutor  ³Ricardo Farinelli   º Data ³  04/06/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Posiciona nos arquivos a serem utilizados pela rotina de    º±±
±±º          ³impressao de Entrada.                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VR70POSENT()

// Cabecalho de Entradas
VVF->(DbsetOrder(1))
VVF->(Dbseek(xFilial("VVF")+VVA->VVA_TRACPA))
// Itens de Entradas
VVG->(DbsetOrder(1))
VVG->(Dbseek(xFilial("VVG")+VVA->VVA_TRACPA+VVA->VVA_CHAINT))
// Cadastro de Fornecedores
SA2->(DbsetOrder(1))
SA2->(Dbseek(xFilial("SA2")+VVF->VVF_CODFOR+VVF->VVF_LOJA))

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VR60POSSAIºAutor  ³Ricardo Farinelli   º Data ³  04/06/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Posiciona nos arquivos a serem utilizados pela rotina de    º±±
±±º          ³impressao da Saida.                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VR70POSSAI()

// Cadastro de Veiculos
VV1->(DbsetOrder(1))
VV1->(Dbseek(xFilial("VV1")+VVA->VVA_CHAINT))
// Cadastro de Cores
VVC->(DbsetOrder(1))
VVC->(Dbseek(xFilial("VVC")+VV1->VV1_CODMAR+VV1->VV1_CORVEI))
// Tipo de Venda
VV3->(Dbsetorder(1))
VV3->(Dbseek(xFilial("VV3")+VV0->VV0_TIPVEN))
// Marca
VE1->(DbsetOrder(1))
VE1->(Dbseek(xFilial("VE1")+VV1->VV1_CODMAR))
// Modelo
VV2->(DbsetOrder(1))
VV2->(Dbseek(xFilial("VV2")+VV1->(VV1_CODMAR+VV1_MODVEI)))
// Cadastro de Clientes
SA1->(DbsetOrder(1))
SA1->(Dbseek(xFilial("SA1")+VV0->VV0_CODCLI+VV0->VV0_LOJA))

Return

/*/{Protheus.doc} VR70GETICMS
Funcao responsavel por verificar se o ICMS esta zerado ou nao

@author Bruno Forcato
@since 24/07/2025
@version 1.0
@param cNroDoc, character, Numero da nota fiscal
@param cSerDoc, character, Serie da nota fiscal
/*/
Static Function VR70GETICMS(cNroDoc, cSerDoc)
	local nICMS := 0

	SFT->(DbSetOrder(6))
	SFT->(DbSeek(xFilial("SFT")+"S"+cNroDoc+cSerDoc))
	nICMS := SFT->FT_VALICM
	if !empty(nICMS) .AND. nICMS > 0 
		return .t.
	endif
return .f.
