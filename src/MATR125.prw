/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "matr125.ch"
#INCLUDE "PROTHEUS.CH"
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR125  ³ Autor ³ Eduardo Riera         ³ Data ³02.12.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do contrato de parceria                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ .T. / .F.                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

/*/
User Function MATR125()

Local oReport := NIL
CHKFILE("SC3")

oReport := ReportDef()
oReport:PrintDialog()

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef()
Definição das propriedades do relatório em TReport
@author Andre Anjos
@since 14/01/2014
@version 1.0
@return NIL
/*/
//-------------------------------------------------------------------
Static Function ReportDef()

Local oReport	:= NIL
Local oSection1	:= NIL
Local oSection2	:= NIL
Local oSection3	:= NIL
Local oSection4	:= NIL
Local oSection5	:= NIL
Local oSection6	:= NIL
Local oSection7	:= NIL
Local cField    := 'B1_DESC'

Pergunte("MTR125",.F.)

oReport := TReport():New("MATR125",STR0001,"MTR125",{|oReport| ReportPrin(oReport)},STR0002)

oSection1 := TRSection():New(oReport,STR0001,{"SC3"})
oSection1:lHeaderVisible := .T.

oSection1:SetLineStyle(.T.)
oSection1:nColSpace := 3

TRCell():New(oSection1,"C3_NUM","SC3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"C3_EMISSAO","SC3",RetTitle("C3_EMISSAO"),/*picture*/,,,/*{|| code-block de impressao }*/)

oSection2 := TRSection():New(oSection1,STR0025,{"SM0"})
oSection2:lHeaderVisible := .T.
oSection2:SetLineStyle(.T.)
oSection2:nColSpace := 3
oSection2:SetNoFilter("SM0")

TRCell():New(oSection2,"M0_NOMECOM","SM0",RetTitle("A2_NREDUZ"),PesqPict("SA2","A2_NREDUZ"),Len(SM0->M0_NOMECOM),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"M0_ENDENT","SM0",RetTitle("A2_END"),PesqPict("SA2","A2_END"),Len(SM0->M0_ENDENT),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"M0_CEPENT","SM0",RetTitle("A2_CEP"),PesqPict("SA2","A2_CEP"),Len(SM0->M0_CEPENT),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"M0_CIDENT","SM0",RetTitle("A2_MUN"),PesqPict("SA2","A2_MUN"),Len(SM0->M0_CIDENT),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"M0_ESTENT","SM0",RetTitle("A2_EST"),PesqPict("SA2","A2_EST"),Len(SM0->M0_ESTENT),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"M0_TEL","SM0",RetTitle("A2_TEL"),PesqPict("SA2","A2_TEL"),Len(SM0->M0_TEL),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"M0_FAX","SM0",RetTitle("A2_FAX"),PesqPict("SA2","A2_FAX"),Len(SM0->M0_FAX),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"M0_CGC","SM0",RetTitle("A2_CGC"),PesqPict("SA2","A2_CGC"),Len(SM0->M0_CGC),/*lPixel*/,/*{|| code-block de impressao }*/)

If !(cPaisLoc $ "ARG|POR|EUA") 
	TRCell():New(oSection2,"M0_INSC","SM0",RetTitle("A2_INSC"),PesqPict("SA2","A2_INSC"),Len(SM0->M0_INSC),/*lPixel*/,/*{|| code-block de impressao }*/)
EndIf

//-- Só adiciona SA2 no personalizável quando não compartilhado ou sem gestão de empresas
//-- Isto para habilitar o recurso de impressão em N filiais (botão Gestão de Empresas)
If FWModeAccess("SA2",1) == "E" .Or. (At("E",FWSM0Layout()) == 0 .And. At("U",FWSM0Layout()) == 0)
	oSection3 := TRSection():New(oSection1,STR0027,{"SA2"})
Else
	oSection3 := TRSection():New(oSection1,STR0027,{"SM0"})
	oSection3:SetNoFilter("SM0")
EndIf
oSection3:lHeaderVisible := .T.
oSection3:SetLineStyle(.T.)
oSection3:nColSpace := 3

TRCell():New(oSection3,"C3_FORNECE","SC3")
TRCell():New(oSection3,"C3_LOJA","SC3")
TRCell():New(oSection3,"A2_NOME","SA2")
TRCell():New(oSection3,"A2_END","SA2")
TRCell():New(oSection3,"A2_CEP","SA2")
TRCell():New(oSection3,"A2_MUN","SA2")
TRCell():New(oSection3,"A2_EST","SA2")
TRCell():New(oSection3,"A2_TEL","SA2")
TRCell():New(oSection3,"A2_FAX","SA2")
TRCell():New(oSection3,"A2_CGC","SA2")

If !(cPaisLoc $ "ARG|POR|EUA")
	TRCell():New(oSection3,"A2_INSCR","SA2")
EndIf

//-- Só adiciona SB1 no personalizável quando não compartilhado ou sem gestão de empresas
//-- Isto para habilitar o recurso de impressão em N filiais (botão Gestão de Empresas)
If FWModeAccess("SB1",1) == "E" .Or. (At("E",FWSM0Layout()) == 0 .And. At("U",FWSM0Layout()) == 0)
	oSection4 := TRSection():New(oSection1,STR0028,{"SC3","SB1"})
Else
	oSection4 := TRSection():New(oSection1,STR0028,{"SC3"})
EndIf
oSection4:lHeaderVisible := .T.

TRCell():New(oSection4,"C3_ITEM","SC3")
TRCell():New(oSection4,"C3_PRODUTO","SC3")

cField := IIF(Empty(MV_PAR03),'B1_DESC',Alltrim(MV_PAR03))

If	!(cField == 'B1_DESC' .Or. cField == 'B5_CEME')
	cField :='D1_DESC' 
	TRCell():New(oSection4,"DESCRI",,RetTitle(cField), PesqPict("S"+Left(cField,2),cField),TamSX3(cField)[1],/*lPixel*/,{|| &("S"+Left(cField,2)+"->"+cField)})
else
	TRCell():New(oSection4,"DESCRI",,RetTitle(cField), PesqPict("S"+Left(cField,2),cField),TamSX3(cField)[1],/*lPixel*/,{|| &("S"+Left(cField,2)+"->"+cField)})
EndIf


TRCell():New(oSection4,"B1_UM","SB1")
TRCell():New(oSection4,"C3_QUANT","SC3")
TRCell():New(oSection4,"C3_TOTAL","SC3")
TRCell():New(oSection4,"C3_OBS","SC3")
TRCell():New(oSection4,"C3_CC","SC3")

oSection5 := TRSection():New(oSection1,STR0029,{"SM0"})
oSection5:lHeaderVisible := .T.
oSection5:SetLineStyle(.T.)
oSection5:nColSpace := 3
oSection5:SetNoFilter("SM0")

TRCell():New(oSection5,"M0_ENDENT","SM0",RetTitle("A2_END"),PesqPict("SA2","A2_END"),Len(SM0->M0_ENDENT),,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,"M0_CIDENT","SM0",RetTitle("A2_MUN"),PesqPict("SA2","A2_MUN"),Len(SM0->M0_CIDENT),,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,"M0_ESTENT","SM0",RetTitle("A2_EST"),PesqPict("SA2","A2_EST"),Len(SM0->M0_ESTENT),,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,"M0_CEPENT","SM0",RetTitle("A2_CEP"),PesqPict("SA2","A2_CEP"),Len(SM0->M0_CEPENT),,/*{|| code-block de impressao }*/)

oSection6 := TRSection():New(oSection1,STR0030,{"SM0"})
oSection6:lHeaderVisible := .T.
oSection6:SetLineStyle(.T.)
oSection6:nColSpace := 3
oSection6:SetNoFilter("SM0")

TRCell():New(oSection6,"M0_ENDCOB","SM0",RetTitle("A2_END"),PesqPict("SA2","A2_END"),Len(SM0->M0_ENDCOB),,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,"M0_CIDCOB","SM0",RetTitle("A2_MUN"),PesqPict("SA2","A2_MUN"),Len(SM0->M0_CIDCOB),,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,"M0_ESTCOB","SM0",RetTitle("A2_EST"),PesqPict("SA2","A2_EST"),Len(SM0->M0_ESTCOB),,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,"M0_CEPCOB","SM0",RetTitle("A2_CEP"),PesqPict("SA2","A2_CEP"),Len(SM0->M0_CEPCOB),,/*{|| code-block de impressao }*/)

//-- Só adiciona SE4 no personalizável quando não compartilhado ou sem gestão de empresas
//-- Isto para habilitar o recurso de impressão em N filiais (botão Gestão de Empresas)
If FWModeAccess("SE4",1) == "E" .Or. (At("E",FWSM0Layout()) == 0 .And. At("U",FWSM0Layout()) == 0)
	oSection7 := TRSection():New(oSection1,STR0031,{"SC3,SE4"})
Else
	oSection7 := TRSection():New(oSection1,STR0031,{"SC3"})
EndIf
oSection7:lHeaderVisible := .T.
oSection7:SetLineStyle(.T.)
oSection7:nColSpace := 3

TRCell():New(oSection7,"TOTGER",,STR0032,"@E 9,999,999,999,999.99",16,,/*{|| code-block de impressao }*/)
TRCell():New(oSection7,"TOTMER",,STR0033,"@E 9,999,999,999,999.99",16,,/*{|| code-block de impressao }*/)
TRCell():New(oSection7,"TOTFRE",,STR0034,"@E 9,999,999,999,999.99",16,,/*{|| code-block de impressao }*/)
TRCell():New(oSection7,"C3_COND","SC3")
TRCell():New(oSection7,"E4_DESCRI","SE4")
TRCell():New(oSection7,"MSG","SC3",STR0035,,255,,{|| Formula(C3_MSG)})

Return oReport
 
//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrin()
Definição das propriedades do relatório em TReport
@author Andre Anjos
@since 14/01/2014
@version 1.0
@return NIL
/*/
//-------------------------------------------------------------------
Static Function ReportPrin(oReport)
Local cQuebra := ""
Local aTotais := {0,0,0}
Local cFilCont:= ""

TRPosition():New(oReport:Section(1):Section(1),"SM0",1,{|| cEmpAnt+cFilAnt})
TRPosition():New(oReport:Section(1):Section(2),"SA2",1,{|| xFilial("SA2")+SC3->(C3_FORNECE+C3_LOJA)})
TRPosition():New(oReport:Section(1):Section(3),"SB1",1,{|| xFilial("SB1")+SC3->C3_PRODUTO})
TRPosition():New(oReport:Section(1):Section(3),"SB5",1,{|| xFilial("SB1")+SC3->C3_PRODUTO})
TRPosition():New(oReport:Section(1):Section(4),"SM0",1,{|| cEmpAnt+SC3->C3_FILENT})
TRPosition():New(oReport:Section(1):Section(5),"SM0",1,{|| cEmpAnt+SC3->C3_FILENT})
TRPosition():New(oReport:Section(1):Section(6),"SE4",1,{|| xFilial("SE4")+SC3->C3_COND})

dbSelectArea("SC3")
SC3->(dbSetOrder(1))
SC3->(dbSeek(xFilial("SC3")))

While SC3->(!Eof())
	If SC3->C3_NUM >= mv_par01 .And. SC3->C3_NUM <= mv_par02 .And. SC3->C3_FILENT >= mv_par04 .And. SC3->C3_FILENT <= mv_par05
		
		oReport:Section(1):Init()
		oReport:Section(1):PrintLine()
				
		oReport:Section(1):Section(1):Init()	
		oReport:Section(1):Section(1):PrintLine()
		oReport:Section(1):Section(1):Finish()
			
		oReport:Section(1):Section(2):Init()
		oReport:Section(1):Section(2):PrintLine()
		oReport:Section(1):Section(2):Finish()
		
		aTotais[1] := 0
		aTotais[2] := 0
		aTotais[3] := 0
		cQuebra    := SC3->C3_NUM
		cFilCont   := SC3->C3_FILENT
		
		oReport:Section(1):Section(3):Init()
		While  SC3->(!Eof()) .And. SC3->C3_NUM == cQuebra .And. SC3->C3_FILENT == cFilCont
					
			aTotais[1] += SC3->C3_TOTAL+SC3->C3_FRETE
			aTotais[2] += SC3->C3_TOTAL
			aTotais[3] += SC3->C3_FRETE
			oReport:Section(1):Section(3):PrintLine()
				
			SC3->(dbSkip())
		Enddo
			
		oReport:Section(1):Section(3):Finish()
		SC3->(dbSkip(-1))	
			
		oReport:Section(1):Section(4):Init()	
		oReport:Section(1):Section(4):PrintLine()
		oReport:Section(1):Section(4):Finish()
		
		oReport:Section(1):Section(5):Init()
		oReport:Section(1):Section(5):PrintLine()
		oReport:Section(1):Section(5):Finish()
			
		oReport:Section(1):Section(6):Init()
		oReport:Section(1):Section(6):Cell("TOTGER"):SetValue(aTotais[1])
		oReport:Section(1):Section(6):Cell("TOTMER"):SetValue(aTotais[2])
		oReport:Section(1):Section(6):Cell("TOTFRE"):SetValue(aTotais[3])
		oReport:Section(1):Section(6):PrintLine()
		oReport:Section(1):Section(6):Finish()
			
		oReport:Section(1):Finish()


	Else 
	
		// Caso o usuário não tenha criado em base o pergunte mv_par04 e mv_par05, o sistema traz os dados de todas as filiais.
		If SC3->C3_NUM >= mv_par01 .And. SC3->C3_NUM <= mv_par02 .And.  mv_par04 == "" .And.  mv_par05 == ""

			oReport:Section(1):Init()
			oReport:Section(1):PrintLine()
					
			oReport:Section(1):Section(1):Init()	
			oReport:Section(1):Section(1):PrintLine()
			oReport:Section(1):Section(1):Finish()
				
			oReport:Section(1):Section(2):Init()
			oReport:Section(1):Section(2):PrintLine()
			oReport:Section(1):Section(2):Finish()
			
			aTotais[1] := 0
			aTotais[2] := 0
			aTotais[3] := 0
			cQuebra := SC3->C3_NUM
		
			oReport:Section(1):Section(3):Init()
			While  SC3->(!Eof()) .And. SC3->C3_NUM == cQuebra
						
				aTotais[1] += SC3->C3_TOTAL+SC3->C3_FRETE
				aTotais[2] += SC3->C3_TOTAL
				aTotais[3] += SC3->C3_FRETE
				oReport:Section(1):Section(3):PrintLine()
					
				SC3->(dbSkip())
			Enddo
			
			oReport:Section(1):Section(3):Finish()
			SC3->(dbSkip(-1))	
				
			oReport:Section(1):Section(4):Init()	
			oReport:Section(1):Section(4):PrintLine()
			oReport:Section(1):Section(4):Finish()
			
			oReport:Section(1):Section(5):Init()
			oReport:Section(1):Section(5):PrintLine()
			oReport:Section(1):Section(5):Finish()
				
			oReport:Section(1):Section(6):Init()
			oReport:Section(1):Section(6):Cell("TOTGER"):SetValue(aTotais[1])
			oReport:Section(1):Section(6):Cell("TOTMER"):SetValue(aTotais[2])
			oReport:Section(1):Section(6):Cell("TOTFRE"):SetValue(aTotais[3])
			oReport:Section(1):Section(6):PrintLine()
			oReport:Section(1):Section(6):Finish()
				
			oReport:Section(1):Finish()

		Endif

	Endif
	SC3->(dbSkip())
Enddo

Return
