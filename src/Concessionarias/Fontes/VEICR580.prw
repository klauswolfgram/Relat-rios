/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "veicr580.ch"
#Include "fileio.ch"
#Include "protheus.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ VEICR580 ³ Autor ³  Fabio                ³ Data ³ 19/10/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Clientes p/ Cidade                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ (Veiculos)                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEICR580
Local oReport
Local aArea := GetArea()
Private oDlgRegiao,oRegiao,oDesReg,oBranco
Private nTotal  := 0
Private nQtdCli := 0
Private cCGCCPF := space(18)
//If FindFunction("TRepInUse") .and. TRepInUse()
	If SA1->(FieldPos("A1_IBGE")) # 0
		oReport := ReportDef()
		oReport:PrintDialog()
	Else
		MsgAlert(STR0006,STR0007)
	EndIf
//Else
//	MsgAlert(STR0008,STR0007)
//EndIf
RestArea( aArea )
Return
        
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef³ Autor ³ Andre Luis Almeida    ³ Data ³ 03/07/06 ³±±
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
Local oCell
oReport := TReport():New("VEICR580",STR0001,"VCR580",{|oReport| U_VCR580IMP(oReport)})
oSection1 := TRSection():New(oReport,STR0001,{"VAM"})
TRCell():New(oSection1,"VAM_DESCID","VAM",,,25)
TRCell():New(oSection1,"VAM_ESTADO","VAM",,,2)
TRCell():New(oSection1,STR0009,,"","@E 999,999,999",11,,{|| nQtdCli })  	//TOTAL
oSection2 := TRSection():New(oReport,OemToAnsi(STR0009),{}) 				//Total
TRCell():New(oSection2,STR0010,,"","@!",29,,{|| STR0005 }) 				//TOTAL GERAL
TRCell():New(oSection2,STR0010,,"","@E 999,999,999",11,,{|| nTotal }) 		//TOTAL GERAL
oSection3 := TRSection():New(oReport,STR0011,{"SA1","VAM"})  		   		//Clientes
TRCell():New(oSection3,"A1_NOME","SA1",,,37)
TRCell():New(oSection3,STR0012,,"","@!",18,,{|| cCGCCPF })					//CNPJ / CPF
TRCell():New(oSection3,"A1_END","SA1",,,32)
TRCell():New(oSection3,"A1_BAIRRO","SA1",,,15)
TRCell():New(oSection3,"A1_CEP","SA1",,"@R 99999-999")
TRCell():New(oSection3,"VAM_DDD","VAM",,)
TRCell():New(oSection3,"A1_TEL","SA1",,)

Return oReport
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ VCR580IMP³ Autor ³ Andre Luis Almeida    ³ Data ³ 03/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Executa a impressao do relatorio do TReport                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Oficina                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VCR580IMP(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(2)
Local oSection3 := oReport:Section(3)
Local aMun := {}
Local nPos := 0
Local cIBGE   := "INICIAL"
Pergunte("VCR580",.f.)
DbSelectArea("SA1")
DbSetOrder(1)
DbSeek(xFilial("SA1"))
oReport:SetMeter(RecCount())
oSection1:Init()
oSection2:Init()
oSection3:Init()
While !Eof() .and. !oReport:Cancel() .and. SA1->A1_FILIAL == xFilial("SA1")
	oReport:IncMeter()
	If !Empty(MV_PAR02) .and. ( SA1->A1_IBGE # MV_PAR02 )
		DbSelectArea("SA1")
		DbSkip()
		Loop
	EndIf
	If MV_PAR01 == 1 // Qtde
		If cIBGE # SA1->A1_IBGE
			cIBGE := SA1->A1_IBGE
			nPos  := aScan(aMun,{|x| x[1] == cIBGE })
			If nPos == 0
				Aadd(aMun,{ cIBGE , 1 } )
				nPos := Len(aMun)			
			Else
				aMun[nPos,2]++
			EndIf
		Else
			aMun[nPos,2]++
		EndIf
	Else // Cliente
		If cIBGE # SA1->A1_IBGE
			cIBGE := SA1->A1_IBGE
			DbSelectArea("VAM")
			DbSetOrder(1)
			DbSeek(xFilial("VAM")+ cIBGE )
		EndIf
		nTotal++
	   cCGCCPF := left(subs(transform(SA1->A1_CGC,PicPes(RetPessoa(SA1->A1_CGC))),1,at("%",transform(SA1->A1_CGC,PicPes(RetPessoa(SA1->A1_CGC))))-1)+space(18),18)
	  	oSection3:PrintLine()
	EndIf
	DbSelectArea("SA1")
	DbSkip()
EndDo
If MV_PAR01 == 1 // Qtde
	For nPos := 1 to len(aMun)
		nQtdCli := aMun[nPos,2]
		DbSelectArea("VAM")
		DbSetOrder(1)
		DbSeek(xFilial("VAM")+ aMun[nPos,1] )
		oSection1:PrintLine()
		nTotal += nQtdCli
	Next
EndIf
oReport:SkipLine()
oSection2:PrintLine()
oSection1:Finish()
oSection2:Finish()
oSection3:Finish()
Return Nil
