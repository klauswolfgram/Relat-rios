/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "FINR830.CH"
#Include "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR830  ³ Autor ³ Daniel Tadashi Batori ³ Data ³ 28.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao relatorio de Emprestimos Financeiros		        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR830(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR830()
Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Daniel Batori         ³ Data ³ 28.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do layout do Relatorio									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport
Local oSection1
Local oSection2 //Gestão Corporativa
Local oSecFil //Gestão Corporativa
Local nTamNum, nTamVal, nTamStat
Local cPictVal

Private nValor1  := 0
Private nValor2  := 0
Private nValor3  := 0
Private nValor4  := 0

oReport := TReport():New("FINR830",STR0003,"FIR830", {|oReport| ReportPrint(oReport)},STR0001+STR0002)

pergunte("FIR830",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros								  ³
//³ mv_par01				// Data de            ?                  ³
//³ mv_par02				// Data ate           ?                  ³
//³ mv_par03            // Moeda              ?                  ³
//³ mv_par04            // Imprime Cancelados ?                  ³
//³ mv_par05            // Resume por Motivo  ?                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nTamNum	:= TamSX3("EI_NUMERO")[1] + TamSX3("EI_REVISAO")[1] + 1
nTamVal	:= TamSX3("EI_VALOR")[1]
cPictVal	:= PesqPict("SEI","EI_VALOR")
nTamStat	:= Len(STR0011) //"CANCEL."

oSection1 := TRSection():New(oReport,STR0029,{"SEI"},) //"Registros"
TRCell():New(oSection1,"NUMERO",,				STR0012,,nTamNum,.F.,{||SEI->EI_NUMERO+"/"+SEI->EI_REVISAO }) //"Numero"
TRCell():New(oSection1,"EH_NBANCO","SEH",		STR0013,,20,.F.,{||SubStr(SEH->EH_NBANCO,1,20) })//"Instituicao"
TRCell():New(oSection1,"EI_TIPO","SEI",		STR0014,,,.F.,{||SEI->EI_TIPO })//"Mod"
TRCell():New(oSection1,"EI_DTDIGIT"	,"SEI",	STR0015,,,.F.,)//"Dt.Digit"
TRCell():New(oSection1,"EH_VALOR","SEH",		STR0016,,,.F.,{||xMoeda(SEH->EH_VALOR,1,MV_PAR03) })//"Valor Nominal"
TRCell():New(oSection1,"EI_NATUREZ","SEI",	STR0017,,,.F.,{||SEI->EI_NATUREZ })//"Natureza"
TRCell():New(oSection1,"EI_BANCO","SEI",		STR0018,,,.F.,{||SEI->EI_BANCO })//"Bco"
TRCell():New(oSection1,"EI_AGENCIA","SEI",	STR0019,,,.F.,{||SEI->EI_AGENCIA })//"Age."
TRCell():New(oSection1,"EI_CONTA","SEI",		STR0020,,,.F.,{||SEI->EI_CONTA })//"Conta"
TRCell():New(oSection1,"EI_TIPODOC","SEI",	STR0021,,,.F.,{||SEI->EI_TIPODOC })//"Tip"
TRCell():New(oSection1,"EI_MOTBX","SEI",		STR0022,,,.F.,{||SEI->EI_MOTBX })//"Mot"
TRCell():New(oSection1,"EI_HISTOR","SEI",		STR0023,,40,.F.,{||SubStr(SEI->EI_HISTOR,1,40) })//"Historico"
TRCell():New(oSection1,"VL_RESG",,				STR0024,cPictVal,nTamVal,.F.,)//"Vlr Resgatado"
TRCell():New(oSection1,"VL_IMPO",,				STR0025,cPictVal,nTamVal,.F.,) //"Impostos"
TRCell():New(oSection1,"VL_JURO",,				STR0026,cPictVal,nTamVal,.F.,) //"Juros"
TRCell():New(oSection1,"VL_CRED",,				STR0027,cPictVal,nTamVal,.F.,) //"Vlr Creditado"
TRCell():New(oSection1,"STATUS",,				STR0028,,nTamStat,.F.,{||If(SEI->EI_STATUS=="C",STR0011,"")}) //"Situacao"

//Gestão Corporativa - Início
oSection2 := TRSection():New(oReport,"",{"SEI"})
TRCell():New(oSection2,"Filial",,,,TamSx3("EI_FILIAL")[1] + Len(STR0030)) //"Filial : "
oSection2:SetHeaderSection(.F.)

oSecFil := TRSection():New(oReport,"SECFIL",{})
TRCell():New(oSecFil,"CODFIL" ,,STR0031,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0032,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0033,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0034,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Filial"

oReport:SetUseGC(.F.)
//Gestão Corporativa - Fim

oBreak := TRBreak():New(oSection1,{|| SEI->EI_FILIAL},STR0036,.F.) //"Total Filial : "

TRFunction():New(oSection1:Cell("VL_RESG"),"TOT_RESG","SUM",oBreak,,,{ || If( SEI->EI_MOTBX == "NOR", nValor1, 0)},.F.,.T.)
TRFunction():New(oSection1:Cell("VL_IMPO"),"TOT_IMPO","SUM",oBreak,,,{ || If( SEI->EI_MOTBX == "NOR", nValor2, 0)},.F.,.T.)
TRFunction():New(oSection1:Cell("VL_JURO"),"TOT_JURO","SUM",oBreak,,,{ || If( SEI->EI_MOTBX == "NOR", nValor3, 0)},.F.,.T.)
TRFunction():New(oSection1:Cell("VL_CRED"),"TOT_CRED","SUM",oBreak,,,{ || If( SEI->EI_MOTBX == "NOR", nValor4, 0)},.F.,.T.)

oReport:SetLandScape()
oReport:SetTotalInLine(.F.)
oSection1:SetLineBreak(.T.)

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Daniel Batori          ³ Data ³22.08.06	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(2)
Local dDt_Digi
LOCAL cChave   := ""
//Gestão Corporativa - Início
Local aTotalF  := { 0,0,0,0 }
Local lGestao   := ( FWSizeFilial() > 2 ) 	// Indica se usa Gestao Corporativa
Local lSEIExcl  := Iif( lGestao, FWModeAccess("SEI",1) == "E", FWModeAccess("SEI",3) == "E")
Local cSEIFil  := FWModeAccess("SEI",3)
Local cSEIUN   := FWModeAccess("SEI",2)
Local cSEIEmp  := FWModeAccess("SEI",1)
Local nX 		:= 1
Local oSecFil	:= oReport:Section("SECFIL")
Local nRegSM0	:= SM0->(Recno())
Local aSelFil := {}
Local nC := 1
Local cUNold := ""
Local cEmpOld := ""
Local cFilialAnt := cFilAnt
Local lPrtFil := .T.
Local cNumAPR := ""
//Gestão Corporativa - Fim

oSection1:Cell("EI_DTDIGIT"):SetBlock( { || dDt_Digi })
oSection1:Cell("VL_RESG"):SetBlock( { || nValor1 })
oSection1:Cell("VL_IMPO"):SetBlock( { || nValor2 })
oSection1:Cell("VL_JURO"):SetBlock( { || nValor3 })
oSection1:Cell("VL_CRED"):SetBlock( { || nValor4 })

oReport:SetMeter(SEI->(RecCount()))

nValor1  := 0
nValor2  := 0
nValor3  := 0
nValor4  := 0

If ( MV_PAR05 == 1 ) // Resume por Motivo  ? SIM/NAO
	oSection1:Cell("EI_TIPODOC"):Hide()
EndIf

nRegSM0 := SM0->(Recno())

If (lSEIExcl .and. mv_par06 == 1)
	aSelFil := FwSelectGC()
Endif

If Empty(aSelFil)
	aSelFil := {cFilAnt}
Endif

SM0->(DbGoTo(nRegSM0))

If mv_par06 == 1
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0035 +  ")")	//"Filiais selecionadas para o relatorio"
	nTamTit := Len(oReport:Title())
	oSecFil:Init()
	oSecFil:Cell("CODFIL"):SetBlock({||cFilSel})
	oSecFil:Cell("EMPRESA"):SetBlock({||aSM0[nLinha,SM0_DESCEMP]})
	oSecFil:Cell("UNIDNEG"):SetBlock({||aSM0[nLinha,SM0_DESCUN]})
	oSecFil:Cell("NOMEFIL"):SetBlock({||aSM0[nLinha,SM0_NOMRED]})
	
	For nX := 1 To Len(aSelFil)
		nLinha := Ascan(aSM0,{|sm0|,sm0[SM0_CODFIL] == aSelFil[nX] .And. sm0[SM0_GRPEMP] == cEmpAnt})
		If nLinha > 0
			cFilSel := Substr(aSM0[nLinha,SM0_CODFIL],1,nTamEmp)
			cFilSel += " "
			cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + 1,nTamUnNeg)
			cFilSel += " "
			cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + nTamUnNeg + 1)
			oSecFil:PrintLine()
		Endif
	Next nX
	
	oReport:SetTitle(cTitulo)
	oSecFil:Finish()
	oReport:EndPage()
Endif

aSort(aSelFil)
cFilAnt	:= aSelFil[nC]
cUN		:= FWUnitBusiness()
cEmp	:= FWCodEmp()
cUNold	:= cUN
cEmpOld	:= cEmp
cNumAPR	:= ""

For nC := 1 To Len(aSelFil) Step 1

	If aSelFil[nC] <> cFilAnt .And. mv_par06 == 1
		dbCloseArea()
		If cSEIEmp == "E" .And. cSEIUN == "E" .And. cSEIFil == "C" .And. mv_par06 == 1
			While cUN == cUNold
				nC += 1
				If nC > Len(aSelFil)
					cUN := ""
				Else
					cFilAnt := aSelFil[nC]
					cUN := FWUnitBusiness()
				EndIf
			EndDo
		EndIf

		If cSEIEmp == "E" .And. cSEIUN == "C" .And. cSEIFil == "C" .And. mv_par06 == 1
			While cEmp == cEmpOld
				nC += 1
				If nC > Len(aSelFil)
					cEmp := ""
				Else
					cFilAnt := aSelFil[nC]
					cEmp := FWCodEmp()
				EndIf
			EndDo
		EndIf

		If cSEIEmp == "C" .And. cSEIUN == "C" .And. cSEIFil == "C" .And. mv_par06 == 1
			nC := Len(aSelFil) + 1
			Loop
		EndIf
		cFilAnt	:= aSelFil[nC]
		cUN		:= FWUnitBusiness()
		cEmp	:= FWCodEmp()
		cUNold	:= cUN
		cEmpOld	:= cEmp
		lPrtFil	:= .T.
	EndIf

	DbSelectArea("SEI")
	SEI->( DbSetOrder(3) )
	SEI->( DbSeek( xFilial("SEI") + "APL" + Dtos(MV_PAR01), .T.) )

	If SEI->(EOF())
		nC := Len(aSelFil) + 1
		Loop
	EndIf

	While ( !SEI->(Eof()) .AND. ;
			SEI->EI_FILIAL == xFilial("SEI") .AND. ;
			SEI->EI_DTDIGIT >= MV_PAR01 .AND. ;
			SEI->EI_DTDIGIT <= MV_PAR02 .AND. ;
			SEI->EI_APLEMP == "APL" )

		If ( SEI->EI_DTDIGIT >= MV_PAR01 .AND. ;
			 SEI->EI_DTDIGIT <= MV_PAR02 .AND. ;
			SEI->EI_APLEMP == "APL"  .AND. ;
			SEI->EI_TIPODOC $ "RG#I1#I2#I3#I4#I5#JR#VL" .AND. ;
			If( MV_PAR04 == 1, .T., SEI->EI_STATUS != "C" ) )

			If lPrtFil
				If mv_par06 == 1
					oReport:SkipLine()
					oSection2:Init()
					oSection2:Cell("Filial"):SetBlock({|| STR0030 + xFilial("SEI")}) //"Filial : "
					oSection2:PrintLine()
					oSection2:Finish()
				EndIf
				lPrtFil := .F.
				oSection1:Init()
			EndIf

			dbSelectArea("SEH")
			SEH->( DbSetOrder(1) )
			SEH->( DbSeek( xFilial("SEH") + SEI->EI_NUMERO + SEI->EI_REVISAO ) )
			
			dDt_Digi	:= SEI->EI_DTDIGIT
			nValor1		:= 0
			nValor2		:= 0
			nValor3		:= 0
			nValor4		:= 0
			
			cChave  := SEI->EI_FILIAL + DtoS(SEI->EI_DTDIGIT) + SEI->EI_NUMERO + SEI->EI_REVISAO + SEI->EI_MOTBX
			If ( MV_PAR05 == 1 )	// Resume por Motivo  ? SIM/NAO
			
				While ( SEI->(!Eof()) .AND. cChave == SEI->EI_FILIAL + DToS(SEI->EI_DTDIGIT) + SEI->EI_NUMERO + SEI->EI_REVISAO + SEI->EI_MOTBX .AND. If( MV_PAR04 == 1, .T., SEI->EI_STATUS != "C" ) )
				
					cNumAPR := SEI->EI_NUMERO
					
					Do Case
						Case SEI->EI_TIPODOC == "RG"
						
							nValor1 += xMoeda( SEI->EI_VALOR, SEH->EH_MOEDA, MV_PAR03 )
							
						Case SubStr(SEI->EI_TIPODOC,1,1) == "I"
						 
							nValor2 += xMoeda( SEI->EI_VALOR, SEH->EH_MOEDA, MV_PAR03 )
							
						Case SubStr(SEI->EI_TIPODOC,1,1) =="J"
						
							nValor3 += xMoeda( SEI->EI_VALOR, SEH->EH_MOEDA, MV_PAR03 )
							
						Case SEI->EI_TIPODOC == "VL"
						
							nValor4 += xMoeda( SEI->EI_VALOR, SEH->EH_MOEDA, MV_PAR03 )
							
					EndCase
					
					SEI->( DbSkip() )
					oReport:IncMeter()
				EndDo
				
				SEI->(dbSkip(-1)) 
				oSection1:PrintLine()
				
			Else
				
				cNumAPR:=SEI->EI_NUMERO
				
				Do Case
					Case SEI->EI_TIPODOC == "RG"
					
						nValor1 := xMoeda(SEI->EI_VALOR, SEH->EH_MOEDA, MV_PAR03)
						
					Case SubStr(SEI->EI_TIPODOC,1,1) == "I"
					
						nValor2 := xMoeda(SEI->EI_VALOR, SEH->EH_MOEDA, MV_PAR03)
						
					Case SubStr(SEI->EI_TIPODOC,1,1) =="J"
					
						nValor3 := xMoeda(SEI->EI_VALOR, SEH->EH_MOEDA, MV_PAR03)
						
					Case SEI->EI_TIPODOC == "VL"
					
						nValor4 := xMoeda(SEI->EI_VALOR, SEH->EH_MOEDA, MV_PAR03)
						
				EndCase
				
				oReport:IncMeter()
				oSection1:PrintLine()
			EndIf
		EndIf
		
		SEH->( DbCloseArea() )
		SEI->( DbSkip() )
		
	EndDo
	SEI->( DbCloseArea() )
	oSection1:Finish()
	
Next nC

cFilAnt := cFilialAnt

Return( .T. )