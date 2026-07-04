/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "OFIOR150.CH"
#Include "protheus.ch"
#Include "Fileio.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ OFIOR150 ³ Autor ³ Andre Luis Almeida    ³ Data ³ 23/11/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Historico de passagens                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIOR150(lAuto)

Private cPerg      := "OFR150"
Private nPassagem  := 0
Private nTpecas    := 0
Private nTpecas2   := 0
Private nTGpecas   := 0
Private nTGpecas2  := 0
Private nTservico  := 0
Private nTservico2 := 0
Private nTGservico := 0
Private nTGservic2 := 0
Private nTGeral    := 0
Private nTGeral2   := 0
Private nTTGeral   := 0
Private nTTGeral2  := 0
Private nPassTot   := 0
Private nDias      := 0
Private nHoras     := 0
Private nMinut     := 0
Private lA1_IBGE := If(SA1->(FieldPos("A1_IBGE"))>0,.t.,.f.)
Private cSpcFilial := SPACE(TamSX3("VO1_FILIAL")[1])
Private lLIBVOO := VOO->(FieldPos("VOO_LIBVOO")) > 0
Private lAutomatico

Default lAuto := .f.

lAutomatico := lAuto

OFR150R3() // Executa versão anterior do fonte

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³OFR150R3  ºAutor  ³Fabio               º Data ³  06/20/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Executa versão anterior do fonte                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function OFR150R3()

Local cDesc1		:=STR0001 		//"Historico de passagens"
Local cDesc2 		:=""
Local cDesc3 		:=""
Local cAlias		:="VV1"



Private nLin := 1
Private aPag := 1
Private nIte := 1
Private aReturn := { STR0127, 1,STR0128, 2, 2, 2, "",1 }  //Zebrado ## Administracao
Private cTamanho:= "M"           	// P/M/G 
Private Limite  := 132           	// 80/132/220
Private aOrdem  := {}           	// Ordem do Relatorio
Private cTitulo := STR0001 			//"Historico de passagens"
Private cNomProg:= "OFIOR150"
Private cNomeRel:= "OFIOR150"
Private nLastKey:= 0
Private cPerg := "OFR150"+Space(len(SX1->X1_GRUPO)-6)
Private lMultMoeda := FGX_MULTMOEDA()


// AADD(aRegs,{STR0136 , STR0136 , STR0136, "mv_ch1", "C", VV1->(TamSx3("VV1_FILIAL")[1]), 0, 0, "G", "", "mv_par01", "", "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "SM0_01" , "033" , "" , "" ,{STR0137},{},{}})  // Filial Inicial / Informe a Filial Inicial
// AADD(aRegs,{STR0138 , STR0138 , STR0138, "mv_ch2", "C", VV1->(TamSx3("VV1_FILIAL")[1]), 0, 0, "G", "", "mv_par02", "", "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "SM0_01" , "033" , "" , "" ,{STR0139},{},{}})  //Filial Final    / Informe a Filial Final
// AADD(aRegs,{STR0140 , STR0140 , STR0140, "mv_ch3", "D", 8								, 0, 0, "G", "!Empty(MV_PAR03)"												, "mv_par03", "", "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,{STR0141},{},{}})      //Data Inicial /  Informe a Data Inicial
// AADD(aRegs,{STR0142 , STR0142 , STR0142, "mv_ch4", "D", 8								, 0, 0, "G", "!Empty(MV_PAR03) .and. (MV_PAR04 >= Mv_PAR03)"				, "mv_par04", "", "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,{STR0143} ,{},{}})   //  Data Final / Informe a Data Final
// AADD(aRegs,{STR0144 , STR0144 , STR0144, "mv_ch5", "C", VV1->(TamSx3("VV1_PROATU")[1])	, 0, 0, "G", 'EMPTY(MV_PAR05) .OR. FG_VALIDA(,"SA1TMV_PAR05*")'				, "mv_par05", "", "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "SA1" , "001" , "" , "" ,{STR0145},{},{}})  //Cliente / Informe o Codigo do Cliente
// AADD(aRegs,{STR0146 , STR0146 , STR0146, "mv_ch6", "C", VV1->(TamSx3("VV1_LJPATU")[1])	, 0, 0, "G", 'EMPTY(MV_PAR06) .OR. FG_VALIDA(,"SA1TMV_PAR05+MV_PAR06*")'	, "mv_par06", "", "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "SA1" , "002" , "" , "" ,{STR0147},{},{}})    // Loja / Informe a Loja do Cliente
// AADD(aRegs,{STR0045 , STR0045 , STR0045, "mv_ch7", "C", VV1->(TamSx3("VV1_CODMAR")[1])	, 0, 0, "G", 'EMPTY(MV_PAR07) .OR. FG_VALIDA(,"VE1TMV_PAR07*")'				, "mv_par07", "", "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "VE1" , "" , "" , "" ,{STR0148},{},{}})  // Marca / Informe a Marca do Veiculo
// AADD(aRegs,{STR0052 , STR0052 , STR0052, "mv_ch8", "C", VV1->(TamSx3("VV1_MODVEI")[1])	, 0, 0, "G", 'EMPTY(MV_PAR08) .OR. FG_VALIDA(,"VV2TMV_PAR07+MV_PAR08*")'	, "mv_par08", "", "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "VV2" , "" , "" , "" ,{STR0149},{},{}})  // Modelo / Informe o Modelo do Veiculo
// AADD(aRegs,{STR0150 , STR0150 , STR0150, "mv_ch9", "C", 25								, 0, 0, "G", "FS_IDENTVEIC()"												, "mv_par09", "", "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,{STR0151},{},{}})  // Identif Veiculo /Informe a Identificacao do veiculo
// AADD(aRegs,{STR0152 , STR0152 , STR0152, "mv_chA", "N", 1								, 0, 0, "C", ""																, "mv_par10", "Sim", "" , "" , "" , "" , "Nao" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,{STR0153},{},{}})   // Mostra Vlr Peças / Informe Sim para mostrar os valores de pecas
// AADD(aRegs,{STR0154 , STR0154 , STR0154, "mv_chB", "N", 1								, 0, 0, "C", ""																, "mv_par11", "Sim", "" , "" , "" , "" , "Nao" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,{STR0155},{},{}})   // Mostra Vlr Serviços / Informe Sim para mostrar os valores de Serviços
// AADD(aRegs,{STR0156 , STR0156 , STR0156, "mv_chC", "N", 1								, 0, 0, "C", ""																, "mv_par12", "Sim", "" , "" , "" , "" , "Nao" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,{STR0157},{},{}})   // Mostra Obs das OSs / Informe Sim para mostrar as Observações das OSs
// aAdd(aRegs,{cPerg,"13",STR0158,"","","mv_chd","C",40,0,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","VOI","","","","!!!!/!!!!/!!!!/!!!!/!!!!/!!!!/!!!!/!!!!/"})
cNomeRel := SetPrint(cAlias,cNomeRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,.t.,cTamanho)

If nLastKey == 27
	Return
EndIf

PERGUNTE(cPerg,.f.)
IIF(lMultMoeda,aReturn[4] := 2,"") 
SetDefault(aReturn,cAlias)

RptStatus( { |lEnd| U_OFIR150IMP(@lEnd,cNomeRel,cAlias) } , cTitulo )

If aReturn[5] == 1
	OurSpool( cNomeRel )
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³OFIR150IMPºAutor  ³Andre Luis Almeida  º Data ³  23/11/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Historico de passagens                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIR150IMP(lEnd,wNRel,cAlias,oReport,oSection1,oSection2,oSection3,oSection4,oSection5,oSection6,oSection7,oSection8,oSection9,oSection10,oSection11,oSection12,oSection13,oSection14,oSection15,oSection16)

Local nLin := 1
Local cTitulo , cabec1 , cabec2 , nomeprog , tamanho , nCaracter , cCabPec , cCabSrv , cOKPeca , cOKServico , cChaInt
Local nPos := 0 , nixx := 0 , njxx := 0
Local aTotPec := {} 		//vetor Total Pecas por tipo de tempo
Local aTotSrv := {} 		//vetor Total Servicos por tipo de tempo



Local cFil := ""

Local cFilBkp := cFilAnt

Local cQryAl001 := GetNextAlias()

Local nCont := 0
Local nContApon := 0
Local cDatLib := ""
Local cDatFec := ""
Local cDatCan := ""

Local nTamColCli := 0
Local lVV1_DTUVEN := VV1->(FieldPos("VV1_DTUVEN")) > 0

Local cMoeda1 := AllTrim(GetMv("MV_MOEDA1"))
Local cMoeda2 := AllTrim(GetMv("MV_MOEDA2"))
Local cDMoeda := ""

Private aTipos  := {} 		//vetor Tipos de tempo diferentes
Private aNumSrv := {} 		//vetor de Servicos
Private aNumPec := {} 		//vetor de Pecas
Private ni := 0 , nj := 0

Private cbTxt    := Space(10)
Private cbCont   := 0
Private cString  := "VV1"
Private Li       := 80
Private m_Pag    := 1

cTitulo:= STR0001 			//"Historico de passagens"
cabec1 := ""
cabec2 := ""
nomeprog:="OFIOR150"
tamanho := "M"
nCaracter:=15

cCabPec := STR0002 + If(MV_PAR10==1,STR0003,"")
cCabSrv := STR0004 + If(MV_PAR11==1,STR0005,"")
ctt := mv_par13
lAchou := .f.
cTtempo := ""
cInicio := "Inicio"
For nPos:=1 to Len(mv_par13)
	nPos := AT("/",ctt)
	if nPos > 0
		nPos -= 1
	Else
		nPos := Len(mv_par13)
	Endif
	cTpT := Substr(ctt,1,nPos)
	if !Empty(cTpT)
		if cInicio == "Inicio"
			cTtempo += "'"+cTpT+"'"
			cInicio := ""
		Else
			cTtempo += ",'"+cTpT+"'"
		Endif
		lAchou := .t.
	Endif
	ctt := alltrim(Substr(ctt,nPos+2,Len(ctt)))
Next

If lAutomatico
	MV_PAR01 := Repl(" ",TamSx3("VO1_FILIAL")[1])
	MV_PAR02 := Repl("z",TamSx3("VO1_FILIAL")[1])
	MV_PAR03 := Ctod("01/01/01")
	MV_PAR04 := dDataBase
	MV_Par09 := VV1->VV1_CHASSI
	MV_Par10 := 1
	MV_Par11 := 1
Endif

If !Empty(MV_PAR09)			//chassi

	DbSelectArea( "VV1" )
	DbSetOrder(2)
	If DbSeek( xFilial("VV1") + RTrim(UPPER(MV_PAR09)) )	//    C H A S S I
		cChaInt := VV1->VV1_CHAINT
	Else
		cChaInt := "Erro"  							   		//    E R R O
	EndIf

elseif !Empty(MV_PAR05)  	//cliente

	DbSelectArea( "VV1" )
	DbSetOrder(5)
	DbSeek( xFilial("VV1") + MV_PAR05, .t. )

elseif !Empty(MV_PAR07) .and. Empty(MV_PAR08)  	//marca e Modelo em branco

	DbSelectArea( "VV1" )
	DbSetOrder(3)
	DbSeek( xFilial("VV1") + MV_PAR07, .t. )

elseif !Empty(MV_PAR07) .and. !Empty(MV_PAR08)  	//marca + modelo

	DbSelectArea( "VV1" )
	DbSetOrder(3)
	DbSeek( xFilial("VV1") + MV_PAR07 + MV_PAR08 , .t. )

EndIf


// Configura linha de impressao do tipo de tempo
nTamColCli := 11

If !lLIBVOO  // Liberacao parcial de TT
	nTamColCli += 08
EndIf
If MV_PAR10 <> 1 // Mostra Vlr Peças
	nTamColCli += 09
EndIf
If MV_PAR11 <> 1 // Mostra Vlr Serviços
	nTamColCli += 21
EndIf

cCabecTT := PadR(STR0167,04) + " "			// "Tp"    
cCabecTT += PadR(STR0168,nTamColCli) + " "	// "Cliente"
cCabecTT += PadR(STR0169,02) + " "			// "Lj"
if Len(SA1->A1_LOJA) > 2
	cCabecTT += space(Len(SA1->A1_LOJA)-2) 
Endif
cCabecTT += PadR(STR0170,06) + " "			// "CT Fec"
cCabecTT += PadR(STR0171,10) + " "			// "Liberada"
cCabecTT += PadR(STR0172,10) + " "			// "Fechada"
cCabecTT += PadR(STR0173,10) + " "			// "Cancel"
cCabecTT += PadR(STR0174,13) + " "			// "NF"
If lLIBVOO  // Liberacao parcial de TT
	cCabecTT += PadR(STR0181,08) + " "		// "Lib. TT"
EndIf
If MV_PAR10 == 1 // Mostra Vlr Peças
	cCabecTT += PadL(STR0175,09) + " "		// "Pecas"
EndIf
cCabecTT += PadR(STR0176,06) + " "			// "TpoPad"
cCabecTT += PadR(STR0177,06) + " "			// "TpoTra"
If MV_PAR11 == 1 // Mostra Vlr Serviços
	cCabecTT += PadR(STR0178,06) + " "		// "TpoCob"
	cCabecTT += PadR(STR0179,06) + " "		// "TpoVen"
	cCabecTT += PadL(STR0180,09) + " "		// "Servicos"
EndIf

VO5->(DbSetOrder(1))
SA1->(DbSetOrder(1))
VVC->(DbSetOrder(1))
VVK->(DbSetOrder(1))
VV2->(DbSetOrder(1))
VVK->(DbSetOrder(1))
VV2->(DbSetOrder(1))
VAM->(DbSetOrder(1))
VAI->(DbSetOrder(1))

If cChaInt # "Erro"

	DbSelectArea( "VV1" )
	SetRegua(RecCount())

	//cCliente := VV1->VV1_PROATU+VV1->VV1_LJPATU	+VV1->VV1_CHAINT
	cCliente := ""
	nPassTot := 0

	Do While !Eof() .And. VV1->VV1_FILIAL==xFilial("VV1") .And. (Empty(MV_PAR05) .or. (VV1->VV1_PROATU == MV_PAR05)) .and. (Empty(MV_PAR06) .or. (VV1->VV1_LJPATU == MV_PAR06))

		IncRegua()

		If (Empty(cChaInt) .Or. VV1->VV1_CHAINT == cChaInt) .And. (Empty(MV_PAR07) .or. (VV1->VV1_CODMAR == MV_PAR07)) .and. (Empty(MV_PAR08) .or. (VV1->VV1_MODVEI == MV_PAR08))

			If nLin <= 1 .Or. nLin >= 60
				nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
				@ nLin++ , 00 psay Repl("*",132)
			EndIf
			//
			VO1->(dbSetOrder(1))
			//

			cQuery := "SELECT VO1.VO1_FILIAL , VO1.VO1_NUMOSV "
			cQuery +=  " FROM "+RetSqlName("VO1")+" VO1 "
			if lAchou
				cQuery += "LEFT JOIN " + RetSqlName("VO2") + " VO2 ON VO2_FILIAL = VO1_FILIAL AND VO2_NUMOSV = VO1_NUMOSV AND VO2.D_E_L_E_T_ = ' ' "
				cQuery += "LEFT JOIN " + RetSqlName("VO3") + " VO3 ON VO3_FILIAL = VO1_FILIAL AND VO3_NOSNUM = VO2_NOSNUM AND VO3.D_E_L_E_T_ = ' ' "
				cQuery += "LEFT JOIN " + RetSqlName("VO4") + " VO4 ON VO4_FILIAL = VO1_FILIAL AND VO4_NOSNUM = VO2_NOSNUM AND VO4.D_E_L_E_T_ = ' ' "
			Endif
			cQuery += "WHERE "
			cQuery += "VO1.VO1_FILIAL>='"+MV_PAR01+"' AND VO1.VO1_FILIAL<='"+MV_PAR02+"' AND "
			cQuery += "VO1.VO1_CHASSI='"+VV1->VV1_CHASSI+"' AND "
			If !Empty(MV_PAR03)
				cQuery += "VO1.VO1_DATABE >= '" + DtoS(MV_PAR03) + "' AND "
			EndIf
			If !Empty(MV_PAR04)
				cQuery += "VO1.VO1_DATABE <= '" + DtoS(MV_PAR04) + "' AND "
			EndIf
			if lAchou
				cQuery += "( VO3_TIPTEM IN ("+cTtempo+") OR VO4_TIPTEM IN ("+cTtempo+") ) AND "
			Endif
			cQuery += "VO1.D_E_L_E_T_=' '"
			cQuery += "GROUP BY VO1.VO1_FILIAL , VO1.VO1_NUMOSV "
			cQuery += "ORDER BY VO1.VO1_FILIAL , VO1.VO1_NUMOSV "

			dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQryAl001, .F., .T. )
			DBSelectArea(cQryAl001)
			while !(cQryAl001)->(eof())

				cFilAnt := (cQryAl001)->VO1_FILIAL

				VO1->(dbSeek( (cQryAl001)->VO1_FILIAL + (cQryAl001)->VO1_NUMOSV ))

				cOSOK:= "NAO"

				VO5->(dbSeek( xFilial("VO5") + VV1->VV1_CHAINT ))

				SA1->(MsSeek( xFilial("SA1") + VV1->VV1_PROATU + VV1->VV1_LJPATU ))

				VVC->(MsSeek( xFilial("VVC") + VV1->VV1_CODMAR + VV1->VV1_CORVEI ))

				If cCliente <> VV1->VV1_PROATU+VV1->VV1_LJPATU+VV1->VV1_CHAINT

					cCliente  := VV1->VV1_PROATU+VV1->VV1_LJPATU+VV1->VV1_CHAINT
					nPassagem  := 0
					nTpecas    := 0
					nTservico  := 0
					nTGeral    := 0
					nTpecas2    := 0
					nTservico2  := 0
					nTGeral2    := 0

					If nLin >= 50
						nLin := 1
						nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
						@ nLin++ , 00 psay Repl("*",132)
					EndIf

					VVK->(MsSeek( xFilial("VVK") + VV1->VV1_CODMAR + VV1->VV1_CODCON))

					VV2->(MsSeek( xFilial("VV2") + VV1->VV1_CODMAR + VV1->VV1_MODVEI))

					nLin++
					@ nLin++ , 00 psay Repl("-",132)
					@ nLin++ , 00 psay STR0006 + VV1->VV1_CODMAR + STR0007 + VV1->VV1_CHASSI + STR0008 + VV1->VV1_PLAVEI + STR0009 + VV1->VV1_CODFRO + STR0010 + VV1->VV1_CHAINT + STR0011 + Transform(VV1->VV1_FABMOD,"@R 9999/9999")
					@ nLin++ , 00 psay STR0012 + Left(VV2->VV2_DESMOD,30) + STR0013 + Left(VV1->VV1_COMMOD,20) + STR0014 + VV1->VV1_CORVEI + " " + Left(VVC->VVC_DESCRI,30)

					@ nLin++ , 11 psay STR0016 + VV1->VV1_TIPDIF + "   " + STR0017 + "        " + VV1->VV1_NUMDIF + STR0018 + VV1->VV1_TIPCAM + "           " + STR0019 + VV1->VV1_CAMBIO
					@ nLin++ , 00 psay STR0020 + VV1->VV1_TIPMOT + STR0021 + VV1->VV1_NUMMOT + STR0022 + Str(VV1->VV1_POTMOT,5)+ STR0015 + VV1->VV1_RENAVA
					nLin++

					If lA1_IBGE
						VAM->(MsSeek(xFilial("VAM")+SA1->A1_IBGE))
						@ nLin++ , 00 psay STR0023 + VV1->VV1_PROATU + " " + VV1->VV1_LJPATU + " " + Padr(SA1->A1_NREDUZ,20) + "   " + Padr(VAM->VAM_DESCID,39) + "-" + VAM->VAM_ESTADO + STR0025 + "(" + VAM->VAM_DDD + ") " + Alltrim(SA1->A1_TEL) + " / " + Alltrim(SA1->A1_FAX)
					Else
						@ nLin++ , 00 psay STR0023 + VV1->VV1_PROATU + " " + VV1->VV1_LJPATU + " " + Padr(SA1->A1_NREDUZ,20) + "   " + Padr(SA1->A1_MUN,39) + "-" + SA1->A1_EST +  STR0025 + "     " + Alltrim(SA1->A1_TEL) + " / " + Alltrim(SA1->A1_FAX)
					EndIf
					@ nLin++ , 00 psay STR0026 + Padr(VVK->VVK_NOMFAN,43) + " " + VVK->VVK_CIDADE + STR0027 + Dtoc(IIf(lVV1_DTUVEN.and.!Empty(VV1->VV1_DTUVEN),VV1->VV1_DTUVEN,VO5->VO5_DATVEN))
					@ nLin++ , 00 psay Repl("-",132)

				EndIf

				nPassagem++
				nPassTot++

				If nLin >= 60
					nLin := 1
					nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
					@ nLin++ , 00 psay Repl("*",132)
					nLin++
				EndIf
				If lMultMoeda 
					If  VO1->VO1_MOEDA = 2
						cDMoeda := cMoeda2
					Else
						cDMoeda := cMoeda1
					Endif
				Endif

				nLin++
				@ nLin++ , 00 psay STR0028+VO1->VO1_NUMOSV+space(8)+ STR0029 + Dtoc(VO1->VO1_DATABE) + STR0030 + strzero(val(left(Transform(VO1->VO1_HORABE,"@R 99:99"),2)),2)+":"+strzero(val(substr(Transform(VO1->VO1_HORABE,"@R 99:99"),4,2)),2)+ STR0031+STR0184 + " " +  Alltrim(Transform(VO1->VO1_KILOME,"@E 999,999,999,999,999")) + IIF(lMultMoeda,space(10) + STR0183 + " " + cDMoeda,"") 

				If !Empty(VO1-> VO1_DATSAI)
					nHoras := ((VO1->VO1_DATSAI-VO1->VO1_DATABE)*24)
					nHoras += (val(left(Transform(VO1->VO1_HORSAI,"@R 99:99"),2))+val(substr(Transform(VO1->VO1_HORSAI,"@R 99:99"),4,2))/60)
				Else
					nHoras := ((dDataBase-VO1->VO1_DATABE)*24)
					nHoras += (val(left(Transform(Dtoc(dDataBase),"@R 99:99"),2))+val(substr(Transform(Dtoc(dDataBase),"@R 99:99"),4,2))/60)
				EndIf
				
				nHoras -= (val(left(Transform(VO1->VO1_HORABE,"@R 99:99"),2))+val(substr(Transform(VO1->VO1_HORABE,"@R 99:99"),4,2))/60)
				nMinut := round(60*(nHoras-int(nHoras)),0)
				nHoras := int(nHoras)

				cFil := Alltrim(VO1->(RetTitle("VO1_FILIAL")))+": "+VO1->VO1_FILIAL
				if GetNewPar("MV_DTATAB","T")  == "T" 	//DATA ATENDIMENTO
					if !Empty(VO1->VO1_DATATE) .or. !Empty(VO1->VO1_HORATE)
						@ nLin++ , 00 psay left(cFil+space(27),27)+ STR0129+" " + Dtoc(VO1->VO1_DATATE) + STR0030 + strzero(val(left(Transform(VO1->VO1_HORATE,"@R 99:99"),2)),2)+":"+strzero(val(substr(Transform(VO1->VO1_HORATE,"@R 99:99"),4,2)),2)+ STR0031 + STR0035 + Transform(nHoras,"@E 99999999999999")+":"+strzero(nMinut,2) + STR0031  //Atendimento Veic:
					Else
						@ nLin++ , 00 psay left(cFil+space(27),27)+ STR0130+" " + Dtoc(VO1->VO1_DATABE) + STR0030 + strzero(val(left(Transform(VO1->VO1_HORABE,"@R 99:99"),2)),2)+":"+strzero(val(substr(Transform(VO1->VO1_HORABE,"@R 99:99"),4,2)),2)+ STR0031 + STR0035 + Transform(nHoras,"@E 99999999999999")+":"+strzero(nMinut,2) + STR0031 //Atendimento Veic:
					Endif
				Else //DATA ABERTURA
					@ nLin++ , 00 psay left(cFil+space(27),27)+ STR0033 + Dtoc(VO1->VO1_DATABE) + STR0030 + strzero(val(left(Transform(VO1->VO1_HORABE,"@R 99:99"),2)),2)+":"+strzero(val(substr(Transform(VO1->VO1_HORABE,"@R 99:99"),4,2)),2)+ STR0031 + STR0035 + Transform(nHoras,"@E 99999999999999")+":"+strzero(nMinut,2) + STR0031
				Endif

				nDias  := int(nHoras/24)
				nHoras -= (nDias*24)
				if GetNewPar("MV_DTATAB","T")  == "T" //DATA ATENDIMENTO
					@ nLin++ , 00 psay space(27)+ STR0130+"  : " + Dtoc(VO1->VO1_DATSAI) + STR0030 + strzero(val(left(Transform(VO1->VO1_HORSAI,"@R 99:99"),2)),2)+":"+strzero(val(substr(Transform(VO1->VO1_HORSAI,"@R 99:99"),4,2)),2)+ STR0031 + space(26) + Transform(nDias,"@E 99999")+STR0036+strzero(nHoras,2)+":"+strzero(nMinut,2) + STR0031  //Liberacao Veic
				Else
					@ nLin++ , 00 psay space(27)+ STR0034 + Dtoc(VO1->VO1_DATSAI) + STR0030 + strzero(val(left(Transform(VO1->VO1_HORSAI,"@R 99:99"),2)),2)+":"+strzero(val(substr(Transform(VO1->VO1_HORSAI,"@R 99:99"),4,2)),2)+ STR0031 + space(26) + Transform(nDias,"@E 99999")+STR0036+strzero(nHoras,2)+":"+strzero(nMinut,2) + STR0031
				Endif
				cOSOK := "SIM"

				aNumSrv := {} // zera vetor de Servicos
				aNumPec := {} // zera vetor de Pecas
				aTotPec := {} // zera vetor Total Pecas por tipo de tempo
				aTotSrv := {} // zera vetor Total Servicos por tipo de tempo
				aTipos  := {} // zera vetor de Tipos de tempo


				// ---------------------------- //
				// P R O C E S S A    P E C A S //
				// ---------------------------- //
				aPeca := FMX_CALPEC( VO1->VO1_NUMOSV ,;
									 /* cTipTem */ ,;
									 /* cGruIte */ ,;
									 /* cCodIte */ ,;
									 .t. /* lMov */ ,;
									 .t. /* lNegoc */ ,;
									 .f. /* lReqZerada */ ,;
									 .t. /* lRetAbe */ ,;
									 .t. /* lRetLib */ ,;
									 .t. /* lRetFec */ ,;
									 .f. /* lRetCan */ ,;
									  /* cLibVOO */ ,;
									  IIf( lAchou , " VO3_TIPTEM IN ("+cTtempo+") " , "" ) /* cFiltroSQL */ )

				For nCont := 1 to Len(aPeca)

					cOKPeca := "S"
					if lAchou
						// Filtra por tipo de tempo
						if !( aPeca[nCont,03] $ mv_par13)
							Loop
						Endif
						//
					Endif

					If lLIBVOO
						nPos := Ascan(aNumPec,{|x| x[1] + x[3] + x[4] + x[11] == aPeca[nCont,03] + aPeca[nCont,01] + aPeca[nCont,02] + aPeca[nCont,25] })
					Else
						nPos := Ascan(aNumPec,{|x| x[1] + x[3] + x[4] == aPeca[nCont,03] + aPeca[nCont,01] + aPeca[nCont,02] })
					EndIf
					If nPos == 0

						VO3->(dbGoTo(aPeca[nCont,14,1,05]))

						AADD( aNumPec , Array(11) )
						nPos := Len(aNumPec)
						aNumPec[nPos,01] := aPeca[nCont,03]					// Tipo de Tempo
						aNumPec[nPos,02] := aPeca[nCont,14,01,01]			// Nosso Numero
						aNumPec[nPos,03] := aPeca[nCont,01]					// Grupo da Peca
						aNumPec[nPos,04] := aPeca[nCont,02]					// Codigo da Peca
						aNumPec[nPos,05] := PadR(aPeca[nCont,13],37)		// Descricao da Peca
						aNumPec[nPos,06] := 0								// Quantidade Requisitada
						aNumPec[nPos,07] := VO3->VO3_PROREQ					// Produtivo que requisitou
						aNumPec[nPos,08] := aPeca[nCont,27]
						aNumPec[nPos,09] := 0								// Valor Unitario
						aNumPec[nPos,10] := 0								// Total das pecas
						aNumPec[nPos,11] := ""								// Numero da Liberacao

						If lLIBVOO
							aNumPec[nPos,11] := aPeca[nCont,25]				// Numero da Liberacao
						EndIf

					EndIf

					aNumPec[nPos,06] := aPeca[nCont,05]						// Quantidade Requisitada
					aNumPec[nPos,09] := aPeca[nCont,09]	- ( aPeca[nCont,07] / aPeca[nCont,05] )	// Valor Unitario
					aNumPec[nPos,10] := aPeca[nCont,10] - aPeca[nCont,07]	// Total de Pecas

					If lLIBVOO
						nPos := aScan(aTipos, { |x| x[1] == aPeca[nCont,03] .and. x[9] == aPeca[nCont,25] } )
					Else
						nPos := aScan(aTipos, { |x| x[1] == aPeca[nCont,03] } )
					EndIf
					If nPos == 0
						VO3->(dbGoTo(aPeca[nCont,14,1,05]))

						SA1->(MsSeek( xFilial("SA1") + aPeca[nCont,15] + aPeca[nCont,16] ))


                        cDia := substr(dtoc(aPeca[nCont,17]),1,2)   
                        cMes := substr(dtoc(aPeca[nCont,17]),4,2)   
                        cAno := substr(dtoc(aPeca[nCont,17]),7,4)   
						if Len(cAno) == 2   
							cDatLib := dtoc(aPeca[nCont,17])
						Else   
							cAno    := substr(cAno,3,2)
							cDatLib := cDia+"/"+cMes+"/"+cAno
						Endif	

                        cDia := substr(dtoc(aPeca[nCont,19]),1,2)   
                        cMes := substr(dtoc(aPeca[nCont,19]),4,2)   
                        cAno := substr(dtoc(aPeca[nCont,19]),7,4)   
						if Len(cAno) == 2   
							cDatFec := dtoc(aPeca[nCont,19])
						Else
							cAno    := substr(cAno,3,2)
							cDatFec := cDia+"/"+cMes+"/"+cAno
						Endif	

                        cDia := substr(dtoc(aPeca[nCont,18]),1,2)   
                        cMes := substr(dtoc(aPeca[nCont,18]),4,2)   
                        cAno := substr(dtoc(aPeca[nCont,18]),7,4)   
						if Len(cAno) == 2   
							cAno    := substr(cAno,3,2)
							cDatCan := dtoc(aPeca[nCont,18])
						Else
							cDatCan := cDia+"/"+cMes+"/"+cAno
						Endif	


						AADD( aTipos , Array(09) )
						nPos := Len(aTipos)
						aTipos[nPos,01] := aPeca[nCont,03]
						aTipos[nPos,02] := 	Left(aPeca[nCont,15] + " " + SA1->A1_NOME, nTamColCli ) + " " + ;	// Codigo + Nome do Cliente
											aPeca[nCont,16] + " " + ;	// Loja do Cliente
											VO3->VO3_FUNFEC + " " + ;	// Produtivo que fechou
											PadR(cDatLib,10) + " " + ;	// Data de Liberacao
											PadR(cDatFec,10) + " " + ;	// Data de Fechamento
											PadR(cDatCan,10) + " " + ;	// Data de Cancelamento
											VO3->VO3_NUMNFI + " " + ;	// Numero da Nota Fiscal
											FGX_UFSNF(VO3->VO3_SERNFI)	// Serie da Nota Fiscal

						aTipos[nPos,03] := 0	// Total de Pecas 
						aTipos[nPos,04] := 0	// Tempo Padrao
						aTipos[nPos,05] := 0	// Tempo Trabalhado
						aTipos[nPos,06] := 0	// Tempo Cobrado
						aTipos[nPos,07] := 0	// Tempo Vendido
						aTipos[nPos,08] := 0	// Total de Servico 
						aTipos[nPos,09] := ""	// Liberacao Parcial

						If lLIBVOO
							aTipos[nPos,09] := aPeca[nCont,25]
						EndIf

					EndIf

					// Total de Pecas 
					aTipos[nPos,3] += aPeca[nCont,10] - aPeca[nCont,07]

					If lMultMoeda  .and.  VO1->VO1_MOEDA == 2
						nTpecas2  += aPeca[nCont,10] - aPeca[nCont,07]
						nTGpecas2 += aPeca[nCont,10] - aPeca[nCont,07]
						nTGeral2  += aPeca[nCont,10] - aPeca[nCont,07]
						nTTGeral2 += aPeca[nCont,10] - aPeca[nCont,07]			
					Else
						nTpecas  += aPeca[nCont,10] - aPeca[nCont,07]
						nTGpecas += aPeca[nCont,10] - aPeca[nCont,07]
						nTGeral  += aPeca[nCont,10] - aPeca[nCont,07]
						nTTGeral += aPeca[nCont,10] - aPeca[nCont,07]
					Endif

				Next nCont


				// ---------------------------------- //
				// P R O C E S S A    S E R V I C O S //
				// ---------------------------------- //
				aSrvc := FMX_CALSER( VO1->VO1_NUMOSV ,;
									 /* cTipTem */,;
									 /* cGruSer */,;
									 /* cCodSer */,;
									 .t. /* lApont */,;
									 .t. /* lNegoc */,;
									 .t. /* lRetAbe */,;
									 .t. /* lRetLib */,;
									 .t. /* lRetFec */,;
									 .f. /* lRetCan */,;
									 /* cLibVOO */,;
									 IIf( lAchou , " VO4_TIPTEM IN ("+cTtempo+") " , "" ) /* cFiltroSQL */ )

				For nCont := 1 to Len(aSrvc)

					cOKServico := "S"

					if lAchou
						// Filtra por tipo de tempo
						if !( aSrvc[nCont,04] $ mv_par13)
							Loop
						Endif
					Endif

					aAdd(aNumSrv, Array(14) )
					nPos := Len(aNumSrv)
					aNumSrv[nPos,01] := aSrvc[nCont,04]				// Tipo de Tempo
					aNumSrv[nPos,02] := aSrvc[nCont,05]				// Tipo de Servico
					aNumSrv[nPos,03] := aSrvc[nCont,01]				// Grupo do Servico
					aNumSrv[nPos,04] := aSrvc[nCont,02]				// Codigo do Servico
					aNumSrv[nPos,05] := Left(aSrvc[nCont,15],30)	// Descricao do Servico
					aNumSrv[nPos,06] := Space(6)					// Codigo do produtivo
					aNumSrv[nPos,07] := Space(23)					// Nome do Produtivo
					aNumSrv[nPos,08] := aSrvc[nCont,10]				// Tempo Padrao
					aNumSrv[nPos,09] := aSrvc[nCont,11]				// Tempo Trabalhado
					aNumSrv[nPos,10] := aSrvc[nCont,12]				// Tempo Cobrado
					aNumSrv[nPos,11] := aSrvc[nCont,13]				// Tempo Vendido
					aNumSrv[nPos,12] := aSrvc[nCont,09]				// Valor do Servico
					aNumSrv[nPos,13] := ""							// Numero da Liberacao
					aNumSrv[nPos,14] := {}							// Apontamentos

					If lLIBVOO
						aNumSrv[nPos,13] := aSrvc[nCont,38]			// Numero da Liberacao
					EndIf

					// Atualiza total do relatorio
					If lMultMoeda .AND. VO1->VO1_MOEDA == 2
						nTServico2  += aSrvc[nCont,09]
						nTGServic2  += aSrvc[nCont,09]
						nTGeral2    += aSrvc[nCont,09]						
						nTTGeral2   += aSrvc[nCont,09]						
					Else
						nTServico  += aSrvc[nCont,09]
						nTGServico += aSrvc[nCont,09]
						nTGeral    += aSrvc[nCont,09]						
						nTTGeral   += aSrvc[nCont,09]
					Endif
					//
					For nContApon := 1 to Len(aSrvc[nCont,14])

						AADD( aNumSrv[nPos,14] , Array(04) )

						VO4->(dbGoTo(aSrvc[nCont,14,nContApon,08]))
						VAI->(MsSeek(xFilial("VAI") + VO4->VO4_CODPRO ))

						// Acerta o cabecalho com o primeiro apontamento ...
						If nContApon == 1
							aNumSrv[nPos,06] := aSrvc[nCont,14,nContApon,01]				// Codigo do produtivo
							aNumSrv[nPos,07] := Subs(VAI->VAI_NOMTEC,1,23)					// Nome do Produtivo
						EndIf
						//

						aNumSrv[nPos,14,nContApon,01] := aSrvc[nCont,14,nContApon,01] 		// Codigo do produtivo
						aNumSrv[nPos,14,nContApon,02] := Subs(VAI->VAI_NOMTEC,1,23)			// Nome do Produtivo
						aNumSrv[nPos,14,nContApon,03] := aSrvc[nCont,14,nContApon,06]		// Tempo Trabalhado

						// Se tiver VSC, grava o valor do servico por apontamento ...
						If aSrvc[nCont,14,nContApon,11] > 0
							aNumSrv[nPos,14,nContApon,04] := aSrvc[nCont,14,nContApon,10]	// Valor do Servico
						Else
							aNumSrv[nPos,14,nContApon,04] := 0
						EndIf
						//

					Next nContApon


					If lLIBVOO
						nPos := aScan(aTipos, { |x| x[1] == aSrvc[nCont,04] .and. x[9] == aSrvc[nCont,38] } )
					Else
						nPos := aScan(aTipos, { |x| x[1] == aSrvc[nCont,04] } )
					EndIf
					If nPos == 0
						VO4->(dbGoTo(aSrvc[nCont,14,01,08]))

						SA1->(MsSeek( xFilial("SA1") + aSrvc[nCont,20] + aSrvc[nCont,21] ))
                        
                        cDia := substr(dtoc(aSrvc[nCont,22]),1,2)   
                        cMes := substr(dtoc(aSrvc[nCont,22]),4,2)   
                        cAno := substr(dtoc(aSrvc[nCont,22]),7,4)   
						if Len(cAno) == 2   
							cDatLib := dtoc(aSrvc[nCont,22])
						Else   
							cAno    := substr(cAno,3,2)
							cDatLib := cDia+"/"+cMes+"/"+cAno
						Endif	

                        cDia := substr(dtoc(aSrvc[nCont,24]),1,2)   
                        cMes := substr(dtoc(aSrvc[nCont,24]),4,2)   
                        cAno := substr(dtoc(aSrvc[nCont,24]),7,4)   
						if Len(cAno) == 2   
							cDatFec := dtoc(aSrvc[nCont,24])
						Else
							cAno    := substr(cAno,3,2)
							cDatFec := cDia+"/"+cMes+"/"+cAno
						Endif	

                        cDia := substr(dtoc(aSrvc[nCont,23]),1,2)   
                        cMes := substr(dtoc(aSrvc[nCont,23]),4,2)   
                        cAno := substr(dtoc(aSrvc[nCont,23]),7,4)   
						if Len(cAno) == 2   
							cDatCan := dtoc(aSrvc[nCont,23])
						Else
							cAno    := substr(cAno,3,2)
							cDatCan := cDia+"/"+cMes+"/"+cAno
						Endif	
						
						AADD( aTipos , Array(09) )
						nPos := Len(aTipos)
						aTipos[nPos,01] := aSrvc[nCont,04]
						aTipos[nPos,02] := 	Left(aSrvc[nCont,20] + " " + SA1->A1_NOME, nTamColCli ) + " " + ;	// Codigo + Nome do Cliente
											aSrvc[nCont,21] + " " + ;	// Loja do Cliente
											VO4->VO4_FUNFEC + " " + ;	// Produtivo que fechou
											PadR(cDatLib,10) + " " + ;	// Data de Liberacao
											PadR(cDatFec,10) + " " + ;	// Data de Fechamento
											PadR(cDatCan,10) + " " + ;	// Data de Cancelamento
											VO4->VO4_NUMNFI + " " + ;	// Numero da Nota Fiscal
											FGX_UFSNF(VO4->VO4_SERNFI)	// Serie da Nota Fiscal

						aTipos[nPos,03] := 0	// Total de Pecas 
						aTipos[nPos,04] := 0	// Tempo Padrao 
						aTipos[nPos,05] := 0	// Tempo Trabalhado
						aTipos[nPos,06] := 0	// Tempo Cobrado
						aTipos[nPos,07] := 0	// Tempo Vendido 
						aTipos[nPos,08] := 0	// Valor do Servico
						aTipos[nPos,09] := ""	// Liberacao Parcial

						If lLIBVOO
							aTipos[nPos,09] := aSrvc[nCont,38]
						EndIf

					EndIf

					aTipos[nPos,04] := aSrvc[nCont,10]	// Tempo Padrao
					aTipos[nPos,05] += aSrvc[nCont,11]	// Tempo Trabalhado
					aTipos[nPos,06] += aSrvc[nCont,12]	// Tempo Cobrado
					aTipos[nPos,07] += aSrvc[nCont,13]	// Tempo Vendido
					aTipos[nPos,08] += aSrvc[nCont,09]	// Valor do Servico


				Next nCont

				//////////////////////////////////
				///  I  M  P  R  E  S  S  A  O ///
				//////////////////////////////////
				If (cOKPeca == "S" .or. cOKServico == "S")

					Asort(aTipos,1,, { |x,y|  x[1] < y[1] } )

					For njxx := 1 to Len(aTipos)

						nj := njxx

						If nLin >= 58

							nLin := 1
							nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
							@ nLin++ , 00 psay Repl("*",132)
							@ nLin++

						EndIf

						nLin++
						@ nLin++ , 01 psay 	cCabecTT

						nLin++
						cLinha := aTipos[nj,1] + " "
						cLinha += aTipos[nj,2] + " "
						cLinha += IIf( lLibVOO , aTipos[nJ,09] + " " , "" )
						cLinha += IIf( MV_PAR10 == 1, Transform(aTipos[nj,3],"@E 99,999.99") + " " ,"")
						cLinha += Transform(aTipos[nj,4],"@R 999:99") + " "
						cLinha += Transform(aTipos[nj,5],"@R 999:99") + " "
						If MV_PAR11 == 1
							cLinha += 	Transform(aTipos[nj,6],"@R 999:99") + " " + ;	// Tempo Cobrado
										Transform(aTipos[nj,7],"@R 999:99") + " " + ;	// Tempo Vendido
										Transform(aTipos[nj,8],"@E 99,999.99")			// Valor do Servico
						EndIf
						@ nLin++ , 01 psay 	cLinha

						If Ascan(aNumPec, { |x| x[1] == aTipos[nj,1] .and. (!lLibVOO .or. x[11] == aTipos[nJ,09]) } ) > 0

							If nLin >= 59
								nLin := 1
								nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
								@ nLin++ , 00 psay Repl("*",132)
								nLin++
							EndIf

							If aTipos[nj,3] # 0
								nLin++
								@ nLin++ , 00 psay cCabPec
								nLin++
							EndIf

							For nixx := 1 to Len(aNumPec)

								ni := nixx

								If aNumPec[ni,1] == aTipos[nj,1] .and. (!lLibVOO .or. aNumPec[nI,11] == aTipos[nJ,09])
									If nLin >= 61
										nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
										@ nLin++ , 00 psay Repl("*",132)
										nLin++
									EndIf

									// Possui qtde requisitada
									If  ( aNumPec[ni,6] # 0 )
										@ nLin++ , 08 psay aNumPec[ni,2] + " " + ;
												aNumPec[ni,3] + " " + ;
												aNumPec[ni,4] + " " + ;
												aNumPec[ni,5] + " " + ;
												Str(aNumPec[ni,6],6)+ "  " + ;
												aNumPec[ni,7] + ;
												If(MV_PAR10 == 1 , "  " + aNumPec[ni,8] + Transform(aNumPec[ni,9],"@E 999,999.99") + " " + Transform(aNumPec[ni,10],"@E 999,999.99") , "" )
									EndIf

								EndIf

							Next

							cOKPeca := "N"

						EndIf

						If Ascan(aNumSrv, { |x| x[1] == aTipos[nj,1] .and. (!lLibVOO .or. x[13] == aTipos[nJ,09] )} ) >0

							If nLin >= 59
								nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
								@ nLin++ , 00 psay Repl("*",132)
								nLin++
							EndIf

							@ nLin++
							@ nLin++ , 00 psay cCabSrv
							@ nLin++

							For nixx := 1 to Len(aNumSrv)

								ni := nixx

								If aNumSrv[ni,1] == aTipos[nj,1] .and. (!lLibVOO .or. aNumSrv[nI,13] == aTipos[nJ,09] )

									If nLin >= 61
										nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
										@ nLin++ , 00 psay Repl("*",132)
										nLin++
									EndIf

									cLinha := aNumSrv[ni,2] + " "									// Tipo de Servico
									cLinha += aNumSrv[ni,3] + " "									// Grupo do Servico
									cLinha += aNumSrv[ni,4] + " "									// Codigo do Servico
									cLinha += aNumSrv[ni,5] + " "									// Descricao do Servico
									cLinha += aNumSrv[ni,6] + " " 									// Codigo do Produtivo
									cLinha += aNumSrv[ni,7] + " " 									// Nome do Produtivo
									cLinha += Transform(aNumSrv[ni,8],"@RZ 999:99") + " "			// Tempo Padrao
									// Se tiver apontamento ...
									If Len(aNumSrv[ni,14]) > 0
										cLinha += Transform(aNumSrv[ni,14,01,03],"@R 999:99") + " "	// Tempo Trabalhado
									EndIf
									//

									// Mostra Vlr Serviços
									If MV_PAR11 == 1
										cLinha += Transform(aNumSrv[ni,10],"@RZ 999:99") + " "
										cLinha += Transform(aNumSrv[ni,11],"@RZ 999:99") + " "
										// Se tiver apontamento ...
										If Len(aNumSrv[ni,14]) > 0
											// So possui valor de servico por apontamento depois de fechada a OS
											If aNumSrv[ni,14,01,04] > 0
												cLinha += Transform(aNumSrv[ni,14,01,04],"@E 999,999.99") 	// Valor do servico
											Else
												cLinha += Transform(aNumSrv[ni,12],"@E 999,999.99")			// Valor do servico
											EndIf
										EndIf
										//
									EndIf
									//

									@ nLin++ , 06 psay cLinha

									// Impressao dos apontamentos ...
									// comeca da segunda linha, pois a primeira foi impressa no bloco acima...
									For nContApon := 2 to Len(aNumSrv[ni,14])

										cLinha := aNumSrv[ni,2] + " "	// Tipo de Servico
										cLinha += aNumSrv[ni,3] + " "	// Grupo do Servico
										cLinha += aNumSrv[ni,4] + " "	// Codigo do Servico
										cLinha += aNumSrv[ni,5] + " "	// Descricao do Servico
										cLinha += aNumSrv[ni,6] + " " 	// Codigo do Produtivo
										cLinha += aNumSrv[ni,7] + " " 	// Nome do Produtivo
										cLinha += "      " + " "		// Tempo Padrao

										cLinha += Transform(aNumSrv[ni,14,nContApon,03],"@R 999:99") + " "		// Tempo Trabalhado

										// Mostra Vlr Serviços
										If MV_PAR11 == 1
											cLinha += "      " + " "			// Tempo Cobrado
											cLinha += "      " + " "			// Tempo Vendido
											If aNumSrv[ni,14,01,04] > 0
												cLinha += Transform(aNumSrv[ni,14,nContApon,04],"@E 999,999.99") 	// Valor do servico
											EndIf
										EndIf
										//

										If nLin >= 61
											nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
											nLin++
										EndIf
										@ nLin++ , 06 psay cLinha

									Next nContApon

								EndIf

							Next

							cOKServico := "N"

						EndIf

					Next

				EndIf

				If MV_PAR12 == 1 .and. cOSOK == "SIM"
					DbSelectArea("SYP")
					DbSetOrder(1)
					If DbSeek( xFilial("SYP") + VO1->VO1_OBSMEM )
						nLin++
						@ nLin , 04 psay STR0041
						cObs := ""
						While !eof() .and. xFilial("SYP")+VO1->VO1_OBSMEM == SYP->YP_FILIAL+SYP->YP_CHAVE
							nPos := AT("\13\10",SYP->YP_TEXTO)
							if nPos > 0
								nPos -= 1
							Else
								nPos := Len(SYP->YP_TEXTO)
							Endif

							cObs := alltrim(Substr(SYP->YP_TEXTO,1,nPos))
							If !Empty(cObs)
								@ nLin , 18 psay "- " + cObs
								nlin++
							EndIf
							SYP->(DbSkip())
						Enddo
					EndIf

				EndIf

				(cQryAl001)->(DBSkip())
			enddo
			(cQryAl001)->(dbCloseArea())

		EndIf

		cCliente := VV1->VV1_PROATU+VV1->VV1_LJPATU+VV1->VV1_CHAINT

		DbSelectArea("VV1")
		DbSkip()

		If cCliente # VV1->VV1_PROATU+VV1->VV1_LJPATU+VV1->VV1_CHAINT
			If nLin >= 60
				nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
				@ nLin++ , 00 psay Repl("*",132)
			EndIf
			If nPassagem # 0
				nLin++
				@ nLin++ , 00 psay STR0042 + Str(nPassagem,8)
				nLin++
				If MV_PAR14 == 1 .or. MV_Par15 == 1
					If lMultMoeda
				    		nLin++
					 		@ nLin , 000 psay STR0182 + " " + cMoeda1	// 'Total de OS em '
					 		@ nLin , 100 psay STR0182 + " " + cMoeda2
							nLin++
						If MV_PAR14 == 1 // Mostra Vlr Pecas-Totalizador 
							nLin++
							@ nLin , 000 psay STR0161 + space(3) + transform(nTpecas,"@E 9,999,999.99")
							@ nLin , 100 psay STR0161 + space(3) + transform(nTpecas2,"@E 9,999,999.99")
						Endif
						If MV_PAR15 == 1 // Mostra Vlr Srvcs-Totalizador 
							nLin++
							@ nLin , 000 psay STR0162 + transform(nTservico,"@E 9,999,999.99")
							@ nLin , 100 psay STR0162 + transform(nTservico2,"@E 9,999,999.99")
						Endif  
						If MV_PAR14 == 1 .and. MV_Par15 == 1
							nLin++
							@ nLin , 000 psay STR0163 + space(2) + transform(nTGeral,"@E 9,999,999.99")
							@ nLin , 100 psay STR0163 + space(2) + transform(nTGeral2,"@E 9,999,999.99")
						Endif
					Else
						nLin++
						If MV_PAR14 == 1 // Mostra Vlr Pecas-Totalizador 
							@ nLin++ , 00 psay STR0161 + transform(nTpecas,"@E 9,999,999.99")
						Endif
						If MV_PAR15 == 1 // Mostra Vlr Srvcs-Totalizador 
							@ nLin++ , 00 psay STR0162 + transform(nTservico,"@E 9,999,999.99")
						Endif
						If MV_PAR14 == 1 .and. MV_Par15 == 1
							@ nLin++ , 00 psay STR0163 + transform(nTGeral,"@E 9,999,999.99")
						Endif
					EndIf
				Endif
				nPassagem := 0
			EndIf
		EndIf

	EndDo
    nLin++
	
	If nPassTot # 0
		If nLin >= 60
			nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
			@ nLin++ , 00 psay Repl("*",132)
		EndIf
		@ nLin++ , 00 psay Repl("*",132)
		nLin++
		@ nLin++ , 00 psay STR0043 + Str(nPassTot,8)
		nLin++
		If MV_PAR14 == 1 .or. MV_Par15 == 1
			If lMultMoeda
				nLin++
				@ nLin , 000 psay STR0182 +" "+ cMoeda1	// 'Total de OS em '
				@ nLin , 100 psay STR0182 +" "+ cMoeda2
				nLin++
				If MV_PAR14 == 1 // Mostra Vlr Pecas-Totalizador 
					nLin++
					@ nLin , 000 psay STR0164 + space(1) + transform(nTGpecas,"@E 9,999,999.99")
					@ nLin , 100 psay STR0164 + space(1) + transform(nTGpecas2,"@E 9,999,999.99")
				Endif
				If MV_PAR15 == 1 // Mostra Vlr Srvcs-Totalizador 
					nLin++
					@ nLin , 000 psay STR0165 + transform(nTGservico,"@E 9,999,999.99")
					@ nLin , 100 psay STR0165 + transform(nTGservic2,"@E 9,999,999.99")
				Endif
				If MV_PAR14 == 1 .and. MV_Par15 == 1
					nLin++
					@ nLin , 000 psay STR0166 + space(3) + transform(nTTGeral,"@E 9,999,999.99")
 					@ nLin , 100 psay STR0166 + space(3) + transform(nTTGeral2,"@E 9,999,999.99")
				Endif
			Else
				If MV_PAR14 == 1 // Mostra Vlr Pecas-Totalizador 
					@ nLin++ , 00 psay STR0164 + transform(nTGpecas,"@E 9,999,999.99")
				Endif
				If MV_PAR15 == 1 // Mostra Vlr Srvcs-Totalizador 
					@ nLin++ , 00 psay STR0165 + transform(nTGservico,"@E 9,999,999.99")
				Endif
				If MV_PAR14 == 1 .and. MV_Par15 == 1
					@ nLin++ , 00 psay STR0166 + transform(nTTGeral,"@E 9,999,999.99")
				Endif
			Endif	
			nLin++
		Endif
		@ nLin++ , 00 psay Repl("*",132)
		nPassTot := 0
	EndIf

EndIf

cFilAnt := cFilBkp

Set Printer to
Set Device  to Screen

Ms_Flush()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_IDENTVEICºAutor  ³Andre Luis Almeida  º Data ³  23/11/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Indentificacao do veiculo                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_IDENTVEIC()
lRet := .t.

cPar := "MV_PAR09"
if !FG_POSVEI(cPar,)//Posicione("VV1",10,xFilial("VV1")+Alltrim(&cPar),"VV1_CHASSI")
	MsgInfo(STR0134,STR0135) // Chassi invalido / Atencao
	lRet := .f.
Endif

Return(lRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³OF150VALID³ Autor ³ Thiago                ³ Data ³ 03/11/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Validacao no parametro tipo de tempo						  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OF150VALID()
Local nPos := 0
ctt := mv_par13

For nPos:=1 to Len(mv_par13)
	nPos := AT("/",ctt)
	if nPos > 0
		nPos -= 1
	Else
		nPos := Len(mv_par13)
	Endif
	cTipTem := alltrim(Substr(ctt,1,nPos))
	dbSelectArea("VOI")
	dbSetOrder(1)
	if !dbSeek(xFilial("VOI")+cTipTem)
		MsgInfo(STR0159+cTipTem+STR0160)
		Return(.f.)
	Endif
	ctt := alltrim(Substr(ctt,nPos+2,Len(ctt)))
Next
Return(.t.)
