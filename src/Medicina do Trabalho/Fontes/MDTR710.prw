/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr710.ch"
#Include "Protheus.ch"

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR710
Relatorio de atestados clinicos emitidos

@author Rafael Diogo Richter
@since 05/06/03
@return
/*/
//---------------------------------------------------------------------
User Function MDTR710()
//---------------------------------------------------------------------
//  Armazena variaveis p/ devolucao (NGRIGHTCLICK)
//---------------------------------------------------------------------
Local aNGBEGINPRM := NGBEGINPRM()

Local oReport
Local aArea := GetArea()
Private cPerg := ""
Private oTempTRB

Private lSigaMdtPS := SuperGetMv("MV_MDTPS",.F.,"N") == "S"

******************** Centro de custo
cAliasCC := "SI3"
cF3CC    := "SI3001"  //SI3 apenas do cliente
cCodCC   := "SI3->I3_CUSTO"
cCodCC2  := "I3_CUSTO"
cDescCC2 := "SI3->I3_DESC"
nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAliasCC := "CTT"
	cF3CC    := "CTT001"  //CTT apenas do cliente
	cCodCC   := "CTT->CTT_CUSTO"
	cCodCC2  := "CTT_CUSTO"
	cDescCC2 := "CTT->CTT_DESC01"
	nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
Endif
********************

If !MDTRESTRI(cPrograma)
	//---------------------------------------------------------------------
	//  Devolve variaveis armazenadas (NGRIGHTCLICK)
	//---------------------------------------------------------------------
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

/* Perguntas Padrão
+-----------------------------+
| 01  De Ficha Medica ?       |
| 02  Ate Ficha Medica ?      |
| 03  De Data ?               |
| 04  Ate Data ?              |
| 05  De Centro de Custo ?    |
| 06  Ate Centro de Custo ?   |
| 07  De Medico ?             |
| 08  Ate Medico ?            |
| 09  Totalizar por: ?        |
| 10  CID Complementar ?      |
+-----------------------------+*/

cPerg    :=  If(!lSigaMdtPS,"MDT710    ","MDT710PS  ")

lHoraTotal := TNY->(FieldPos("TNY_QTDHOR")) > 0  //Denota se será impresso o total de horas de afastamento
lIndMed    := TNY->(FieldPos("TNY_INDMED")) > 0
lRelPer    := .T.

If TRepInUse()
   	//-- Interface de impressao
  	oReport := ReportDef()
  	oReport:SetLandscape()
  	oReport:DisableOrientation()
	oReport:PrintDialog()
Else
   lRelPer := .F.
   U_MDTR710R3()
EndIf

RestArea(aArea)

//---------------------------------------------------------------------
//  Devolve variaveis armazenadas (NGRIGHTCLICK)
//---------------------------------------------------------------------
NGRETURNPRM(aNGBEGINPRM)

Return .T.
//---------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Define as secoes impressas no relatorio

@author Andre E. Perez Alvarez
@since 07/08/06
@return
/*/
//---------------------------------------------------------------------
Static Function ReportDef()

Local lPrintHr := GetNewpar("MV_NG2HRAT", "1") == "1" // Verifica se serao impressas as Horas do Atestado

Static oReport
Static oSectionA
Static oSection0
Static oSection1
Static oSection3
Static oSection4
Static oSection5
Static oCell

/************************************ LAYOUT -- mv_par09 == 1 (Totalizar por Filial)
/*        1         2         3         4         5         6         7         8         9       100       110       120       130
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
____________________________________________________________________________________________________________________________________

                                                       Atestados Clinicos
____________________________________________________________________________________________________________________________________

Nome 		  Matricula    Ficha Medica   Dt.Afast.Ini.   Dt.Afast.Fim     Medico Emitente 			  Total de Dias
________________________________________________________________________________________________________________________________
xxxxxxxxx     xxxxxx       xxxxxxxxxxx    xx/xx/xxxx      xx/xx/xxxx       xxxxxxxxxxxxxxxxxxxxxx             xxxxx
xxxxxxxxx     xxxxxx       xxxxxxxxxxx    xx/xx/xxxx      xx/xx/xxxx       xxxxxxxxxxxxxxxxxxxxxx             xxxxx
xxxxxxxxx     xxxxxx       xxxxxxxxxxx    xx/xx/xxxx      xx/xx/xxxx       xxxxxxxxxxxxxxxxxxxxxx             xxxxx
			  xxxxxx       xxxxxxxxxxx    xx/xx/xxxx      xx/xx/xxxx       xxxxxxxxxxxxxxxxxxxxxx             xxxxx
			  xxxxxx       xxxxxxxxxxx    xx/xx/xxxx      xx/xx/xxxx       xxxxxxxxxxxxxxxxxxxxxx             xxxxx
xxxxxxxxx     xxxxxx       xxxxxxxxxxx    xx/xx/xxxx      xx/xx/xxxx       xxxxxxxxxxxxxxxxxxxxxx             xxxxx
xxxxxxxxx     xxxxxx       xxxxxxxxxxx    xx/xx/xxxx      xx/xx/xxxx       xxxxxxxxxxxxxxxxxxxxxx             xxxxx

Total: xxxxx

**************************************/





//************************************ LAYOUT -- mv_par09 == 2 (Totalizar por Centro de Custo)
/*        1         2         3         4         5         6         7         8         9       100       110       120       130
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
____________________________________________________________________________________________________________________________________

                                                       Atestados Clinicos
____________________________________________________________________________________________________________________________________

Centro de Custo      Descricao
_____________________________________________

xxxxxxxxxxx          xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Nome 		  Matricula    Ficha Medica   Dt.Afast.Ini.   Dt.Afast.Fim     Medico Emitente 			  Total de Dias
________________________________________________________________________________________________________________________________
xxxxxxxxx     xxxxxx       xxxxxxxxxxx    xx/xx/xxxx      xx/xx/xxxx       xxxxxxxxxxxxxxxxxxxxxx             xxxxx
xxxxxxxxx     xxxxxx       xxxxxxxxxxx    xx/xx/xxxx      xx/xx/xxxx       xxxxxxxxxxxxxxxxxxxxxx             xxxxx
xxxxxxxxx     xxxxxx       xxxxxxxxxxx    xx/xx/xxxx      xx/xx/xxxx       xxxxxxxxxxxxxxxxxxxxxx             xxxxx
			  xxxxxx       xxxxxxxxxxx    xx/xx/xxxx      xx/xx/xxxx       xxxxxxxxxxxxxxxxxxxxxx             xxxxx
			  xxxxxx       xxxxxxxxxxx    xx/xx/xxxx      xx/xx/xxxx       xxxxxxxxxxxxxxxxxxxxxx             xxxxx
xxxxxxxxx     xxxxxx       xxxxxxxxxxx    xx/xx/xxxx      xx/xx/xxxx       xxxxxxxxxxxxxxxxxxxxxx             xxxxx
xxxxxxxxx     xxxxxx       xxxxxxxxxxx    xx/xx/xxxx      xx/xx/xxxx       xxxxxxxxxxxxxxxxxxxxxx             xxxxx

Total Centro de Custo: xxxxx

Total Geral: xxxxxx

***************************************/


//-------------------------------------------------------------------------
//Criacao do componente de impressao
//
//  TReport():New
//  ExpC1 : Nome do relatorio
//  ExpC2 : Titulo
//  ExpC3 : Pergunte
//  ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
//  ExpC5 : Descricao
//
//--------------------------------------------------------------------------
oReport := TReport():New("MDTR710",OemToAnsi(STR0004),cPerg,{|oReport| ReportPrint(lPrintHr)},;  //"Atestados Clinicos"
           STR0001)

//---------------------------------------------------------------------
// Variaveis utilizadas para parametros
//  mv_par01             // De Ficha Medica
//  mv_par02             // Ate Ficha Medica
//  mv_par03             // De Data
//  mv_par04             // Ate Data
//  mv_par05             // De Centro de Custo ?
//  mv_par06             // Ate Centro de Custo ?
//  mv_par07             // De Medico ?
//  mv_par08             // Ate Medico ?
//  mv_par09             // Totalizar por:
//  mv_par10			 //CID Complementar ?
//---------------------------------------------------------------------

Pergunte(oReport:uParam,.F.)

U_MDT710SEC()

Return oReport
//---------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Imprime o relatorio.

@param lPrintHr - Determina se imprime horas.

@author Andre E. Perez Alvarez
@since 07/08/06
@return
/*/
//---------------------------------------------------------------------
Static Function ReportPrint(lPrintHr)

Local lFirst
Local cNome
Local aBoxAux := {}
Local nAux
Local aTotal
Local nIndMed := 0 //Tipo de médico
Local cInterno    := "" //Recebe nome do tipo de médico
Local cExterno    := "" //Recebe nome do tipo de médico
Local cEmpresa    := "" //Recebe nome do tipo de médico
Local cSUS        := "" //Recebe nome do tipo de médico
Local cParticular := "" //Recebe nome do tipo de médico
Local cConvenio   := "" //Recebe nome do tipo de médico

Processa( {|lEND| TRBgrava(lPrintHr)}, STR0025 ,STR0026 ) //"Aguarde" ## "Processando os Atestados Médicos..."

aBoxAux:= StrTokArr( NGRETSX3BOX( "TNY_INDMED" ) , ";" )//Recebe somente o item selecionado.
nAux   := Len( aBoxAux )
aTotal := Array( nAux )
AFILL(aTotal, 0 )

nTotalRe    := 0
nTotalHH    := 0
nIndMed     := 0
nInterno    := 0
nExterno    := 0
nEmpresa    := 0
nSUS        := 0
nParticular := 0
nConvenio   := 0

If lSigaMdtps

	*****************************************************************
	If mv_par13 == 1  //Totalizar por Cliente

	    DbSelectArea("TRB")
	    dbGotop()
	    oReport:SetMeter ( LastRec() )

		While !Eof()			  .AND.;
			  !oReport:Cancel()

			nTotalRe := 0
			nTotalHH := 0
			nIndMed     := 0
			nInterno    := 0
			nExterno    := 0
			nEmpresa    := 0
			nSUS        := 0
			nParticular := 0
			nConvenio   := 0


			cCliente := TRB->CLIENT+TRB->LOJA
	   	    oSectionA:Init()
	   	    oSectionA:PrintLine()

	   	    While !Eof() .and. cCliente = TRB->CLIENT+TRB->LOJA

				cNome := TRB->NOMFIC
		  		lFirst := .T.
		  		oSection1:Init()
				oSection1:Cell("TM0_NOMFIC"):Show()

				While !Eof()			  	 .AND.;
					  !oReport:Cancel()	  	 .AND.;
					  cNome == TRB->NOMFIC   .AND.;
					  cCliente = TRB->CLIENT+TRB->LOJA

					If !lFirst
						oSection1:Cell("TM0_NOMFIC"):Hide()
					EndIf
					oSection1:PrintLine()
					nTotalRe += TRB->TOTDIA
					nTotalHH += HtoM(TRB->TOTHOR)
					If lIndMed
						nIndMed := Val(  TNY->TNY_INDMED )//Recebe o tipo de Médico
						If nIndMed == 1
							nInterno++
						ElseIf nIndMed == 2
							nExterno++
						ElseIf nIndMed == 3
				   			nEmpresa++
				   		ElseIf nIndMed == 4
				   			nSUS++
				   		ElseIf nIndMed == 5
				   			nParticular++
				   		ElseIf nIndMed == 6
				   			nConvenio++
				   		EndIf
					Endif
					lFirst := .F.
					If mv_par14 == 1 .And. !Empty(TRB->CIDCOM)
						oSection3:Init()
						oSection3:PrintLine()
						oReport:SkipLine()
        				oSection3:Finish()
   					Endif

		     		oReport:IncMeter()
		     		DbSkip()
		     	End
		     	oSection1:Finish()
	   	    End

			If nTotalRe > 0
				oSection4:Init()
				oSection4:PrintLine()
				oSection4:Finish()
			Endif

	   	    oSectionA:Finish()

		End

	*****************************************************************
	ElseIf Mv_par13 == 2 //Totalizar por Centro de Custo

	    DbSelectArea("TRB")
	    dbGotop()
	    oReport:SetMeter ( LastRec() )

		While !Eof()			  .AND.;
			  !oReport:Cancel()

	     	cCC := TRB->CODCC
	     	oSection0:Init()
	     	oSection0:PrintLine()
	     	oSection1:Init()
	     	While !Eof()			  .AND.;
			  	  !oReport:Cancel()	  .AND.;
			  	  cCC == TRB->CODCC

	     		cNome := TRB->NOMFIC
	     		lFirst := .T.
	     		oSection1:Cell("TM0_NOMFIC"):Show()
	     		While !Eof()			  	 .AND.;
			  	  	  !oReport:Cancel()	  	 .AND.;
			  	  	  cCC == TRB->CODCC  	 .AND.;
			  	  	  cNome == TRB->NOMFIC

					If !lFirst
						oSection1:Cell("TM0_NOMFIC"):Hide()
					EndIf
					oSection1:PrintLine()
					nTotalRe += TRB->TOTDIA
					nTotalHH += HtoM(TRB->TOTHOR)
					If lIndMed
						nIndMed := Val(  TNY->TNY_INDMED )//Recebe o tipo de Médico
						If nIndMed == 1
							nInterno++
						ElseIf nIndMed == 2
							nExterno++
						ElseIf nIndMed == 3
				   			nEmpresa++
				   		ElseIf nIndMed == 4
				   			nSUS++
				   		ElseIf nIndMed == 5
				   			nParticular++
				   		ElseIf nIndMed == 6
				   			nConvenio++
				   		EndIf
					Endif
					lFirst := .F.
					If mv_par14 == 1 .And. !Empty(TRB->CIDCOM)
						oSection3:Init()
						oSection3:PrintLine()
						oReport:SkipLine()
        				oSection3:Finish()
   					Endif

	     			oReport:IncMeter()
	     			DbSkip()
	     		End  //Ficha

	     	End  //CC
	     	oSection1:Finish()
	     	oSection0:Finish()
			If nTotalRe > 0
				oSection4:Init()
				oSection4:PrintLine()
				oSection4:Finish()
				nTotalRe    := 0
				nTotalHH    := 0
				nInterno    := 0
				nExterno    := 0
				nEmpresa    := 0
				nSUS        := 0
				nParticular := 0
				nConvenio   := 0
			Endif
		End

	*****************************************************************
	Else //Totalizar por Medico

	    DbSelectArea("TRB")
	    dbGotop()
	    oReport:SetMeter ( LastRec() )

		While !Eof()			  .AND.;
			  !oReport:Cancel()

	     	cCC := TRB->EMITEN
	     	oSection5:Init()
	     	oSection5:PrintLine()
	     	oSection1:Init()
	     	While !Eof()			  .AND.;
			  	  !oReport:Cancel()	  .AND.;
			  	  cCC == TRB->EMITEN

	     		cNome := TRB->NOMFIC
	     		lFirst := .T.
	     		oSection1:Cell("TM0_NOMFIC"):Show()
	     		While !Eof()			  	 .AND.;
			  	  	  !oReport:Cancel()	  	 .AND.;
			  	  	  cCC == TRB->EMITEN 	 .AND.;
			  	  	  cNome == TRB->NOMFIC

					If !lFirst
						oSection1:Cell("TM0_NOMFIC"):Hide()
					EndIf
					oSection1:PrintLine()
					nTotalRe += TRB->TOTDIA
					nTotalHH += HtoM(TRB->TOTHOR)
					If lIndMed
						nIndMed := Val(  TNY->TNY_INDMED )//Recebe o tipo de Médico
						If nIndMed == 1
							nInterno++
						ElseIf nIndMed == 2
							nExterno++
						ElseIf nIndMed == 3
				   			nEmpresa++
				   		ElseIf nIndMed == 4
				   			nSUS++
				   		ElseIf nIndMed == 5
				   			nParticular++
				   		ElseIf nIndMed == 6
				   			nConvenio++
				   		EndIf
					Endif
					lFirst := .F.
					If mv_par14 == 1 .And. !Empty(TRB->CIDCOM)
						oSection3:Init()
						oSection3:PrintLine()
						oReport:SkipLine()
        				oSection3:Finish()
   					Endif

	     			oReport:IncMeter()
	     			DbSkip()
	     		End  //Ficha

	     	End  //CC
	     	oSection1:Finish()
	     	oSection5:Finish()
			If nTotalRe > 0
				oSection4:Init()
				oSection4:PrintLine()
				oSection4:Finish()
				nTotalRe    := 0
				nTotalHH    := 0
				nInterno    := 0
				nExterno    := 0
				nEmpresa    := 0
				nSUS        := 0
				nParticular := 0
				nConvenio   := 0
			Endif
		End

	Endif
	*****************************************************************

Else

	*****************************************************************
	If mv_par09 == 1  //Totalizar por Filial

	    DbSelectArea("TRB")
	    dbGotop()
	    oReport:SetMeter ( LastRec() )

		oSection1:Init()
		While !Eof()			  .AND.;
			  !oReport:Cancel()

			cNome := TRB->NOMFIC
	  		lFirst := .T.
			oSection1:Cell("TM0_NOMFIC"):Show()
			While !Eof()			  	 .AND.;
				  !oReport:Cancel()	  	 .AND.;
				  cNome == TRB->NOMFIC

				If !lFirst
					oSection1:Cell("TM0_NOMFIC"):Hide()
				EndIf
				oSection1:PrintLine()
				nTotalRe += TRB->TOTDIA
				nTotalHH += HtoM(TRB->TOTHOR)
				If lIndMed
					nIndMed := Val(  TNY->TNY_INDMED )//Recebe o tipo de Médico
					If nIndMed == 1
						nInterno++
					ElseIf nIndMed == 2
						nExterno++
					ElseIf nIndMed == 3
						nEmpresa++
					ElseIf nIndMed == 4
						nSUS++
					ElseIf nIndMed == 5
						nParticular++
					ElseIf nIndMed == 6
						nConvenio++
					EndIf
				Endif
				lFirst := .F.
				If mv_par10 == 1 .And. !Empty(TRB->CIDCOM)
					oSection3:Init()
					oSection3:PrintLine()
					oReport:SkipLine()
     				oSection3:Finish()
   				Endif
	     		oReport:IncMeter()
	     		DbSkip()
	     	End

		End
		oSection1:Finish()
		If nTotalRe > 0
			oSection4:Init()
			oSection4:PrintLine()
			oSection4:Finish()
		Endif

	*****************************************************************
	ElseIf Mv_par09 == 2 //Totalizar por Centro de Custo

	    DbSelectArea("TRB")
	    dbGotop()
	    oReport:SetMeter ( LastRec() )

		While !Eof()			  .AND.;
			  !oReport:Cancel()

	     	cCC := TRB->CODCC
	     	oSection0:Init()
	     	oSection0:PrintLine()
	     	oSection1:Init()
	     	While !Eof()			  .AND.;
			  	  !oReport:Cancel()	  .AND.;
			  	  cCC == TRB->CODCC

	     		cNome := TRB->NOMFIC
	     		lFirst := .T.
	     		oSection1:Cell("TM0_NOMFIC"):Show()
	     		While !Eof()			  	 .AND.;
			  	  	  !oReport:Cancel()	  	 .AND.;
			  	  	  cCC == TRB->CODCC  	 .AND.;
			  	  	  cNome == TRB->NOMFIC

					If !lFirst
						oSection1:Cell("TM0_NOMFIC"):Hide()
					EndIf
					oSection1:PrintLine()
					nTotalRe += TRB->TOTDIA
					nTotalHH += HtoM(TRB->TOTHOR)
					If lIndMed
						nIndMed := Val(  TNY->TNY_INDMED )//Recebe o tipo de Médico
						If nIndMed == 1
							nInterno++
				   			cInterno := aBoxAux[nIndMed]
				   		ElseIf nIndMed == 2
				   			nExterno++
				   			cExterno := aBoxAux[nIndMed]
						ElseIf nIndMed == 3
				   			nEmpresa++
				   			cEmpresa := aBoxAux[nIndMed]
				   		ElseIf nIndMed == 4
				   			nSUS++
				   			cSUS := aBoxAux[nIndMed]
				   		ElseIf nIndMed == 5
				   			nParticular++
				   			cParticular := aBoxAux[nIndMed]
				   		ElseIf nIndMed == 6
				   			nConvenio++
				   			cConvenio := aBoxAux[nIndMed]
				   		EndIf
					Endif
					lFirst := .F.
					If mv_par10 == 1 .And. !Empty(TRB->CIDCOM)
						oSection3:Init()
						oSection3:PrintLine()
						oReport:SkipLine()
        				oSection3:Finish()
   					Endif

	     			oReport:IncMeter()
	     			DbSkip()
	     		End  //Ficha

	     	End  //CC
	     	oSection1:Finish()
	     	oSection0:Finish()
			If nTotalRe > 0
				oSection4:Init()
				oSection4:PrintLine()
				oSection4:Finish()
				nTotalRe    := 0
				nTotalHH    := 0
				nInterno    := 0
				nExterno    := 0
				nEmpresa    := 0
				nSUS        := 0
				nParticular := 0
				nConvenio   := 0
			Endif
		End

	*****************************************************************
	Else //Totalizar por Medico

	    DbSelectArea("TRB")
	    dbGotop()
	    oReport:SetMeter ( LastRec() )

		While !Eof()			  .AND.;
			  !oReport:Cancel()

	     	cCC := TRB->EMITEN
	     	oSection5:Init()
	     	oSection5:PrintLine()
	     	oSection1:Init()
	     	While !Eof()			  .AND.;
			  	  !oReport:Cancel()	  .AND.;
			  	  cCC == TRB->EMITEN

	     		cNome := TRB->NOMFIC
	     		lFirst := .T.
	     		oSection1:Cell("TM0_NOMFIC"):Show()
	     		While !Eof()			  	 .AND.;
			  	  	  !oReport:Cancel()	  	 .AND.;
			  	  	  cCC == TRB->EMITEN 	 .AND.;
			  	  	  cNome == TRB->NOMFIC

					If !lFirst
						oSection1:Cell("TM0_NOMFIC"):Hide()
					EndIf
					oSection1:PrintLine()
					nTotalRe += TRB->TOTDIA
					nTotalHH += HtoM(TRB->TOTHOR)
					If lIndMed
						nIndMed := Val(  TNY->TNY_INDMED )//Recebe o tipo de Médico
						If nIndMed == 1
							nInterno++
						ElseIf nIndMed == 2
							nExterno++
						ElseIf nIndMed == 3
							nEmpresa++
						ElseIf nIndMed == 4
							nSUS++
						ElseIf nIndMed == 5
							nParticular++
						ElseIf nIndMed == 6
							nConvenio++
						EndIf
					Endif
					lFirst := .F.
					If mv_par10 == 1 .And. !Empty(TRB->CIDCOM)
						oSection3:Init()
						oSection3:PrintLine()
						oReport:SkipLine()
        				oSection3:Finish()
   					Endif
	     			oReport:IncMeter()
	     			DbSkip()
	     		End  //Ficha

	     	End  //CC
	     	oSection1:Finish()
	     	oSection5:Finish()
			If nTotalRe > 0
				oSection4:Init()
				oSection4:PrintLine()
				oSection4:Finish()
				nTotalRe    := 0
				nTotalHH    := 0
				nInterno    := 0
				nExterno    := 0
				nEmpresa    := 0
				nSUS        := 0
				nParticular := 0
				nConvenio   := 0
			Endif
		End

	Endif
	*****************************************************************

Endif


dbSelectArea("TRB")
If RecCount() == 0
	MsgInfo(STR0027)  //"Não há nada para imprimir no relatório."
	oTempTRB:Delete()
	Return .F.
Endif

oTempTRB:Delete()

Return .T.
//---------------------------------------------------------------------
/*/{Protheus.doc} TRBgrava
Processa os atestados medicos de acordo com os parametros
e grava no arquivo temporario

@param lPrintHr - Determina se imprime horas.

@author Andre E. Perez Alvarez
@since 07/08/06
@return
/*/
//---------------------------------------------------------------------
Static Function TRBgrava(lPrintHr)
Local cNATEST

Private cTurnoTrab := ""
Private cTurnSeq := ""


aDBF := {}
If lSigaMdtps
	If mv_par13 == 1
		AADD (aDBF, { "CLIENT", "C" ,nTa1, 0 } )
		AADD (aDBF, { "LOJA"  , "C" ,nTa1L, 0 } )
	EndIf
EndIf
AADD (aDBF, { "CODCC"   , "C" ,nSizeSI3, 0 } )
AADD (aDBF, { "NUMFIC"  , "C" ,09, 0 } )
AADD (aDBF, { "NOMFIC"  , "C" ,40, 0 } )
AADD (aDBF, { "DTINIC"  , "D" ,08, 0 } )
AADD (aDBF, { "DTFIM"   , "D" ,08, 0 } )
AADD (aDBF, { "EMITEN"  , "C" ,12, 0 } )
AADD (aDBF, { "TOTDIA"  , "N" ,09, 0 } )
AADD (aDBF, { "TOTHOR"  , "C" ,09, 0 } )
If lIndMed
	AADD (aDBF, { "INDMED"  , "C" ,12, 0 } )
Endif
AADD (aDBF, { "CID"     , "C", 08, 0 } )
AADD (aDBF, { "DESCID"  , "C", 42, 0 } )
AADD (aDBF, { "CIDCOM"  , "M", 08, 0 } )
AADD (aDBF, { "HRINIC"  , "C" ,05, 0 } )
AADD (aDBF, { "HRFIM"   , "C" ,05, 0 } )

If lSigaMdtps
	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	If mv_par13 == 1	//Totalizar por Cliente
		oTempTRB:AddIndex( "1", {"CLIENT","LOJA","NOMFIC","DTINIC"} )
	ElseIf mv_par13 == 2	//Totalizar por Centro de Custo
		oTempTRB:AddIndex( "1", {"CODCC","NOMFIC","DTINIC"} )
	Else
		oTempTRB:AddIndex( "1", {"EMITEN","NOMFIC","DTINIC"} )
	Endif
	oTempTRB:Create()

	DbSelectArea("TNY")
	DbSetOrder(01)  //TNY_NUMFIC + DTOS(TNY_DTINIC) + TNY_HRINIC
	DbSeek( xFilial("TNY") + mv_par05, .T. )
	oReport:SetMeter ( LastRec() )

	oSection1:Init()
	While !Eof()							 .AND.;
		  !oReport:Cancel()					 .AND.;
		  xFilial("TNY") == TNY->TNY_FILIAL  .AND.;
		  TNY->TNY_NUMFIC <= mv_par06

		oReport:IncMeter()

		If TNY->TNY_DTINIC < mv_par07 .or. TNY->TNY_DTINIC > mv_par08
			dbSelectArea("TNY")
			dbSkip()
			Loop
		Endif

		If TNY->(TNY_CLIENT+TNY_LOJA) < mv_par01+mv_par02 .or. TNY->(TNY_CLIENT+TNY_LOJA) > mv_par03+mv_par04
			dbSelectArea("TNY")
			dbSkip()
			Loop
		Endif

		If ( TNY->TNY_EMITEN < mv_par11 ) .OR. ( TNY->TNY_EMITEN > mv_par12 )
			dbSelectArea("TNY")
			dbSkip()
			loop
		Endif

		DbSelectArea("TM0")
		DbSetOrder(01)
		dbSeek( xFilial("TM0") + TNY->TNY_NUMFIC )

		DbSelectArea("SRA")
		DbSetOrder(01)
		If !DbSeek ( TM0->TM0_FILFUN + TM0->TM0_MAT ) .OR. Empty(TM0->TM0_MAT)
			dbSelectArea("TNY")
	 		DbSkip()
			Loop
		EndIf
		If ( SRA->RA_CC < mv_par09 ) .OR. ( SRA->RA_CC > mv_par10 )
			dbSelectArea("TNY")
			DbSkip()
			Loop
		Endif
		If mv_par14 == 1
	   		cNATEST := ""
			dbSelectArea("TKI")
			dbSetOrder(1)
   			If dbSeek(xFilial("TKI") + TNY->TNY_NATEST)
				cNATEST := TNY->TNY_NATEST
    	   	EndIf
		EndIf

		DbSelectArea(cAliasCC)
	 	DbSetOrder(01)
	 	DbSeek ( xFilial(cAliasCC) + SRA->RA_CC )

		TRB->(DbAppend())
		TRB->CODCC  := &(cCodCC)
		TRB->NUMFIC := TNY->TNY_NUMFIC
		TRB->NOMFIC := TM0->TM0_NOMFIC
		TRB->DTINIC := TNY->TNY_DTINIC
		TRB->DTFIM  := TNY->TNY_DTFIM
		TRB->HRINIC := TNY->TNY_HRINIC
		TRB->HRFIM  := TNY->TNY_HRFIM
		TRB->EMITEN := TNY->TNY_EMITEN
		TRB->TOTDIA := Posic1()
		If lIndMed
			aBoxAux:= StrTokArr( NGRETSX3BOX( "TNY_INDMED" ) , ";" )
			nIndMed := Val(  TNY->TNY_INDMED )
			If nIndMed == 1
				cInterno := aBoxAux[1]
				cInterno := StrTran (AllTrim(cInterno) , "1=" )//Recebe somente o nome do campo
				TRB->INDMED := cInterno
			ElseIf nIndMed == 2
				cExterno := aBoxAux[2]
				cExterno := StrTran (AllTrim(cExterno) , "2=" )
				TRB->INDMED := cExterno
			ElseIf nIndMed == 3
				cEmpresa := aBoxAux[3]
				cEmpresa := StrTran (AllTrim(cEmpresa) , "3=" )
				TRB->INDMED := cEmpresa
			ElseIf nIndMed == 4
				cSUS := aBoxAux[4]
				cSUS := StrTran (AllTrim(cSUS) , "4=" )
				TRB->INDMED := cSUS
			ElseIf nIndMed == 5
				cParticular := aBoxAux[5]
				cParticular := StrTran (AllTrim(cParticular) , "5=" )
				TRB->INDMED := cParticular
			Else
				cConvenio := aBoxAux[6]
				cConvenio := StrTran (AllTrim(cConvenio) , "6=" )
				TRB->INDMED := cConvenio
			Endif
		Endif

		lDiaOK := .T.
		If DtoC(TNY->TNY_DTFIM) == Space(8) .OR. Empty(TNY->TNY_DTFIM)
			lDiaOk := .F.
		EndIf
		lHoraOK := .T.
		If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
			lHoraOK := .F.
		EndIf
		If lDiaOK
			nDias := (TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
		Else
			nDias := ( 	Date() - TNY->TNY_DTINIC ) + 1
		EndIf
		If !lHoraOk
			cHoraFim := SubStr( Time(),1,5)
		Else
			cHoraFim := TNY->TNY_HRFIM
		Endif

		If lHoraTotal
			TRB->TOTHOR := MtoH( Posic2() * 60)
		Else
			cTurnoTrab := SRA->RA_TNOTRAB
			cTurnSeq := SRA->RA_SEQTURN
			U_MDT700TURN() //Verifica o turno dentro do periodo do atestado.

			TRB->TOTHOR := U_SomaHrSPJ( TNY->TNY_DTINIC, TNY->TNY_DTFIM, TNY->TNY_HRINIC, TNY->TNY_HRFIM , cTurnoTrab , cTurnSeq , SRA->RA_FILIAL)
		Endif

		TRB->CID := TNY->TNY_CID
		TRB->DESCID := SubStr(AllTrim(NGSEEK("TMR",TNY->TNY_CID,1,"TMR_DOENCA")),1,42)
		//Carrega CID Complementar
		If !EMPTY(TRB->CID) .AND. !Empty(cNATEST)
			fCarrCIDC(cNATEST)
		EndIf

		If mv_par13 == 1	//Totalizar por Cliente
			TRB->CLIENT := TM0->TM0_CLIENT
			TRB->LOJA   := TM0->TM0_LOJA
		Endif

		DbSelectArea("TNY")
		DbSkip()
	End

Else

	//Cria TRB
	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	If mv_par09 == 1	//Totalizar por Filial
		oTempTRB:AddIndex( "1", {"NOMFIC","DTINIC"} )
	ElseIf mv_par09 == 2	//Totalizar por Centro de Custo
		oTempTRB:AddIndex( "1", {"CODCC","NOMFIC","DTINIC"} )
	Else
		oTempTRB:AddIndex( "1", {"EMITEN","NOMFIC","DTINIC"} )
	Endif
	oTempTRB:Create()

	DbSelectArea("TNY")
	DbSetOrder(01)  //TNY_NUMFIC + DTOS(TNY_DTINIC) + TNY_HRINIC
	DbSeek( xFilial("TNY") + mv_par01, .T. )
	oReport:SetMeter ( LastRec() )

	oSection1:Init()
	While !Eof()							 .AND.;
		  !oReport:Cancel()					 .AND.;
		  xFilial("TNY") == TNY->TNY_FILIAL .AND.;
		  TNY->TNY_NUMFIC <= mv_par02

		oReport:IncMeter()

		If !(	(TNY->TNY_DTINIC >= mv_par03 .And. TNY->TNY_DTINIC <= mv_par04) .Or.;
				(TNY->TNY_DTFIM >= mv_par03 .And. TNY->TNY_DTFIM <= mv_par04) .Or.;
				(TNY->TNY_DTINIC <= mv_par03 .And. TNY->TNY_DTFIM >= mv_par04)	)
			dbSelectArea("TNY")
			dbSkip()
			Loop
		Endif

		If ( TNY->TNY_EMITEN < mv_par07 ) .OR. ( TNY->TNY_EMITEN > mv_par08 )
			dbSelectArea("TNY")
			dbSkip()
			loop
		Endif

		DbSelectArea("TM0")
		DbSetOrder(01)
		dbSeek( xFilial("TM0") + TNY->TNY_NUMFIC )

		DbSelectArea("SRA")
		DbSetOrder(01)
		If !DbSeek ( TM0->TM0_FILFUN + TM0->TM0_MAT ) .OR. Empty(TM0->TM0_MAT)
			dbSelectArea("TNY")
	 		DbSkip()
			Loop
		EndIf
		If ( SRA->RA_CC < mv_par05 ) .OR. ( SRA->RA_CC > mv_par06 )
			dbSelectArea("TNY")
			DbSkip()
			Loop
		Endif
		If mv_par10 == 1
	   		cNATEST := ""
			dbSelectArea("TKI")
			dbSetOrder(1)
			If dbSeek(xFilial("TKI")+TNY->TNY_NATEST)
				cNATEST := TNY->TNY_NATEST
    	 	EndIf
		EndIf

		DbSelectArea(cAliasCC)
	 	DbSetOrder(01)
	 	DbSeek ( xFilial(cAliasCC) + SRA->RA_CC )

		TRB->(DbAppend())
		TRB->CODCC  := &(cCodCC)
		TRB->NUMFIC := TNY->TNY_NUMFIC
		TRB->NOMFIC := TM0->TM0_NOMFIC
		TRB->DTINIC := TNY->TNY_DTINIC
		TRB->DTFIM  := TNY->TNY_DTFIM
		TRB->HRINIC := TNY->TNY_HRINIC
		TRB->HRFIM  := TNY->TNY_HRFIM
		TRB->EMITEN := TNY->TNY_EMITEN
		TRB->TOTDIA := Posic1()

		If lIndMed
			aBoxAux:= StrTokArr( NGRETSX3BOX( "TNY_INDMED" ) , ";" )
			nIndMed := Val(  TNY->TNY_INDMED )
			If nIndMed == 1
				cInterno := aBoxAux[1]
				cInterno := StrTran (AllTrim(cInterno) , "1=" )//Recebe somente o nome do campo
				TRB->INDMED := cInterno
			ElseIf nIndMed == 2
				cExterno := aBoxAux[2]
				cExterno := StrTran (AllTrim(cExterno) , "2=" )
				TRB->INDMED := cExterno
			ElseIf nIndMed == 3
				cEmpresa := aBoxAux[3]
				cEmpresa := StrTran (AllTrim(cEmpresa) , "3=" )
				TRB->INDMED := cEmpresa
			ElseIf nIndMed == 4
				cSUS := aBoxAux[4]
				cSUS := StrTran (AllTrim(cSUS) , "4=" )
				TRB->INDMED := cSUS
			ElseIf nIndMed == 5
				cParticular := aBoxAux[5]
				cParticular := StrTran (AllTrim(cParticular) , "5=" )
				TRB->INDMED := cParticular
			Else
				cConvenio := aBoxAux[6]
				cConvenio := StrTran (AllTrim(cConvenio) , "6=" )
				TRB->INDMED := cConvenio
			Endif
		Endif

		lDiaOK := .T.
		If DtoC(TNY->TNY_DTFIM) == Space(8) .OR. Empty(TNY->TNY_DTFIM)
			lDiaOk := .F.
		EndIf

		lHoraOK := .T.
		If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
			lHoraOK := .F.
		EndIf

		If lDiaOK
			nDias := (TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
		Else
			nDias := ( 	Date() - TNY->TNY_DTINIC ) + 1
		EndIf

		If !lHoraOk
			cHoraFim := SubStr( Time(),1,5)
		Else
			cHoraFim := TNY->TNY_HRFIM
		Endif

		If lHoraTotal
			TRB->TOTHOR := MtoH( Posic2() * 60 )
		Else
			cTurnoTrab := SRA->RA_TNOTRAB
			cTurnSeq := SRA->RA_SEQTURN
			U_MDT700TURN() //Verifica o turno dentro do periodo do atestado.

			TRB->TOTHOR := U_SomaHrSPJ( TNY->TNY_DTINIC, TNY->TNY_DTFIM, TNY->TNY_HRINIC, TNY->TNY_HRFIM , cTurnoTrab , cTurnSeq , SRA->RA_FILIAL)
		Endif

		TRB->CID := TNY->TNY_CID
		TRB->DESCID := SubStr(AllTrim(NGSEEK("TMR",TNY->TNY_CID,1,"TMR_DOENCA")),1,42)
		//Carrega CID Complementar
		If !EMPTY(TRB->CID) .AND. !Empty(cNATEST)
			fCarrCIDC(cNATEST)
		EndIf


		DbSelectArea("TNY")
		DbSkip()
	End

Endif

Return .T.
//---------------------------------------------------------------------
/*/{Protheus.doc} Posic1
Retorna o Total de Dias para cada atestado.

@author Andre E. Perez Alvarez
@since 07/08/06
@return
/*/
//---------------------------------------------------------------------
Static Function Posic1()

Local lDiaOK := .T.
Local cNG2TUAT := GetNewpar("MV_NG2TUAT", "2")
Local aRet     := MdtTurnoSPJ(TNY->TNY_DTINIC,TNY->TNY_DTFIM,TNY->TNY_HRINIC,TNY->TNY_HRFIM)

If DtoC(TNY->TNY_DTFIM) == Space(8) .OR. Empty(TNY->TNY_DTFIM)
	lDiaOk := .F.
EndIf

If lDiaOK
	If cNG2TUAT == "2"
		nTotalDias := (TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
	Else
		nTotalDias := aRet[3]
	EndIf
Else
	If cNG2TUAT == "2"
		nTotalDias := ( dDataBase - TNY->TNY_DTINIC ) + 1
	Else
		nTotalDias := aRet[3]
	EndIf
EndIf


Return nTotalDias
//---------------------------------------------------------------------
/*/{Protheus.doc} Posic2
Retorna o Total de Horas para cada atestado.

@author Andre E. Perez Alvarez
@since 07/08/06
@return
/*/
//---------------------------------------------------------------------
Static Function Posic2()

Local lQTDHOR     := .T.
Local lDiaOk      := .T.
Local lHoraOK     := .T.
Local nTotalHoras := 0

If DtoC(TNY->TNY_DTFIM) == Space(8) .OR. Empty(TNY->TNY_DTFIM)
	lDiaOk := .F.
EndIf

If TNY->TNY_QTDHOR == Space(5) .OR. Empty(TNY->TNY_QTDHOR)
	lQTDHOR := .F.
EndIf

If lQTDHOR
	nTotalHoras := Val(TNY->TNY_QTDHOR)
Else
	If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
		lHoraOK := .F.
	EndIf

	If lHoraOK .AND. lDiaOK
		nTotalHoras := ( (TNY->TNY_DTFIM - TNY->TNY_DTINIC + 1 )*24 + (Val(SUBSTR(TNY->TNY_HRFIM,1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2))) )
	Else
		If !lDiaOK
			nTotalHoras := ( (dDataBase - TNY->TNY_DTINIC  + 1 )*24 + (Val(SUBSTR(Time(),1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2)))  )
		Else
			If !lHoraOK
				nTotalHoras := (TNY->TNY_DTFIM - TNY->TNY_DTINIC + 1 )*24
			EndIf
		EndIf
	EndIf
EndIf

Return nTotalHoras
//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR710R3
Relatorio de atestados clinicos emitidos	(realese 3)

@author Rafael Diogo Richter
@since 05/06/03
@return
/*/
//---------------------------------------------------------------------
User Function MDTR710R3()
//---------------------------------------------------------------------
//  Variaveis locais exclusivas desta funcao
//---------------------------------------------------------------------
LOCAL wnrel   := "MDTR710"
LOCAL limite  := 132
LOCAL cDesc1  := STR0001 //"Relatorio de atestados clinicos emitidos"
LOCAL cDesc2  := " "
LOCAL cDesc3  := " "
LOCAL cString := "TM0"

//---------------------------------------------------------------------
//  Variaveis exclusivas desta funcao e suas sub-funcoes
//---------------------------------------------------------------------
PRIVATE nomeprog := "MDTR710"
PRIVATE tamanho  := "G"
PRIVATE aReturn  := { STR0002, 1,STR0003, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0004 //"Atestados Clinicos"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cabec1, cabec2

//---------------------------------------------------------------------
//  Verifica as perguntas selecionadas
//---------------------------------------------------------------------
pergunte(cPerg,.F.)
//---------------------------------------------------------------------
//  Variaveis utilizadas para parametros
//  mv_par01             // De Ficha Medica
//  mv_par02             // Ate Ficha Medica
//  mv_par03             // De Data
//  mv_par04             // Ate Data
//  mv_par05             // De Centro de Custo ?
//  mv_par06             // Ate Centro de Custo ?
//  mv_par07             // De Medico ?
//  mv_par08             // Ate Medico ?
//  mv_par09             // Totalizar por:
//  mv_par10             // CID Complementar ?
//---------------------------------------------------------------------
//---------------------------------------------------------------------
//  Envia controle para a funcao SETPRINT
//---------------------------------------------------------------------
wnrel:="MDTR710"

If lSigaMdtps
	If mv_par13 == 2
		cString := "SRA"
	EndIf
Else
	If mv_par09 == 2
		cString := "SRA"
	EndIf
Endif

wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
	Set Filter to
 	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	Return
Endif

If lSigaMdtps
	If mv_par13 == 1
		RptStatus({|lEnd| R710Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
	ElseIf mv_par13 == 2
	   	RptStatus({|lEnd| R710ImpC(@lEnd,wnRel,titulo,tamanho)},titulo)
	ElseIf mv_par13 == 3
	   	RptStatus({|lEnd| R710ImpM(@lEnd,wnRel,titulo,tamanho)},titulo)
	EndIf
Else
	If mv_par09 == 1
		RptStatus({|lEnd| R710Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
	ElseIf mv_par09 == 2
	   	RptStatus({|lEnd| R710ImpC(@lEnd,wnRel,titulo,tamanho)},titulo)
	ElseIf mv_par09 == 3
	   	RptStatus({|lEnd| R710ImpM(@lEnd,wnRel,titulo,tamanho)},titulo)
	EndIf
Endif

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} R710Imp
Chamada do Relat¢rio (separa por Centro de Custo)

@param lEnd - Cancela a impressão.
@param wnRel - Programa utilizado.
@param titulo - Titulo do relatório.
@param tamanho - Tamanho do relatório.

@author Andre E. Perez Alvarez
@since 28/12/05
@return
/*/
//---------------------------------------------------------------------
Static Function R710Imp(lEnd,wnRel,titulo,tamanho)

//---------------------------------------------------------------------
// Variaveis locais exclusivas desta funcao
//---------------------------------------------------------------------
LOCAL cRodaTxt := ""
LOCAL nCntImpr := 0
LOCAL lHoraOK	//var01
LOCAL lDiaOK	//var02
LOCAL lFirst  := .T.  //var03
LOCAL lQTDHOR          //var04
LOCAL nTotalDias  := 0  //var05
LOCAL nTotalHoras := 0  //var06
Local nInterno    := 0 //Contador de médicos
Local nExterno    := 0 //Contador de médicos
Local nEmpresa    := 0 //Contador de médicos
Local nSUS        := 0 //Contador de médicos
Local nParticular := 0 //Contador de médicos
Local nConvenio   := 0 //Contador de médicos
Local cNomMed := "" //Recebe o nome do local de trabalho do médico
Local nDias := 0, cHoraFim := "",cPerdido:=""
Local lPrint := .f.
Local nLastCol := 0

Local lPrintHr := GetNewpar("MV_NG2HRAT", "1") == "1" // Verifica se serao impressas as Horas do Atestado
Local cNATEST
Local mv_CID //Parametro para impressao de cabecalho de CID Complementar

Private cTurnoTrab := ""
Private cTurnSeq := ""

If lSigaMdtPs
	mv_CID := mv_par14 == 1
Else
	mv_CID := mv_par10 == 1
EndIf

//---------------------------------------------------------------------
//                         Descricao das variaveis
//---------------------------------------------------------------------
/*
var01 - Denota se o campo TNY->TNY_HRFIM está preenchido
var02 - Denota se o campo TNY->TNY_DTFIM está preenchido
var03 - Serve para imprimir apenas uma vez o nome de um determinado funcionário,
   		caso ele tenha mais do que um período de afastamento.
var04 - Denota se o campo TNY->TNY_QTDHOR está preenchido
var05 - Total geral de dias de afastamento
var06 - Total geral de horas de afastamento
*/

//---------------------------------------------------------------------
// Contadores de linha e pagina
//---------------------------------------------------------------------
PRIVATE li := 80 ,m_pag := 1

//---------------------------------------------------------------------
// Verifica se deve comprimir ou nao
//---------------------------------------------------------------------
nTipo  := IIF(aReturn[4]==1,15,18)

//---------------------------------------------------------------------
// Monta os Cabecalhos
//---------------------------------------------------------------------
If lIndMed
	//           1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6
   // 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Ind. Medico  Total Dias   Total Horas    CID      Descricao"
	//"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Ind. Medico  Total Dias   CID      Descricao"

	If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
		If mv_CID  // CID Complementar
			cabec1 := STR0051 //"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Ind. Medico  Total Dias   Total Horas    CID      Descricao        CID Complementar"
		Else
			cabec1 := STR0082//"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Ind. Medico  Total Dias   Total Horas    CID      Descricao"
		EndIf
	Else
		If mv_CID //CID Complementar
			cabec1 := STR0075 //"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Ind. Medico  Total Dias   CID      Descricao         CID Complementar"
		Else
			cabec1 := STR0084//"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Ind. Medico  Total Dias   CID      Descricao"
		EndIf
	Endif
Else
  	//           1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7
   // 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
   //"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Total Dias   Total Horas    CID       Descricao"
   //"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Total Dias   CID       Descricao"

	If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
		If mv_CID
			cabec1 := STR0052 //"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Total Dias   Total Horas    CID       Descricao        CID Complementar"
		Else
			cabec1 := STR0083 //"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Total Dias   Total Horas    CID       Descricao"
		EndIf
	Else
		If mv_CID
			cabec1 := STR0076 //"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Total Dias   CID       Descricao"
		Else
			cabec1 := STR0085//"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Total Dias   CID       Descricao"
		EndIf
	Endif
Endif
cabec2 := ""

/*
If lIndMed
	************************************************************************************************************************************
	*<empresa>                                                                                                        Folha..: xxxxx   *
	*SIGA /<nome .04                                                                                                  DT.Ref.: dd/mm/aa*
	*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
	************************************************************************************************************************************

	          1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	(Padrao)                                 Funcionarios por Centro de Custo e Funcao                                 (Padrao)
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	Nome                            Matric.  Ficha Med.  Dt.Afast.  Dt. Fim    Medico Emitente       Ind. Medico  Total Dias  Total Horas
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	123456789012345678901234567890  123456   123456789   99/99/99   99/99/99   XXXXXXXXXXXXXXXXXXXX  XXXXXXXXXX   XXXX        XXX

	 																		  		Total de Dias..............:  9999        9999
					 																Total de Atestados Emitidos:  9999
																	                Total de Atestados Externos:  9999
Else
	************************************************************************************************************************************
	*<empresa>                                                                                                        Folha..: xxxxx   *
	*SIGA /<nome .04                                                                                                  DT.Ref.: dd/mm/aa*
	*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
	************************************************************************************************************************************

	          1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	(Padrao)                                 Funcionarios por Centro de Custo e Funcao                                 (Padrao)
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	Nome                            Matric.  Ficha Med.  Dt.Afast.  Dt. Fim    Medico Emitente       Total Dias  Total Horas  Ind. Medico
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	123456789012345678901234567890  123456   123456789   99/99/99   99/99/99   XXXXXXXXXXXXXXXXXXXX  XXXX        XXX          XXXXXXXXXX
*/

If lSigaMdtps   //Totaliza por Cliente

	Processa( {|lEND| TRB2grava(lPrintHr)}, STR0025 ,STR0026 ) //"Aguarde" ## "Processando os Atestados Médicos..."

	DbSelectArea("TRB")
	dbGotop()
	SetRegua(LastRec())

	While !Eof()

		nTotalDias  := 0
		nTotalHoras := 0
		nInterno    := 0
		nExterno    := 0
		nEmpresa    := 0
		nSUS        := 0
		nParticular := 0
		nConvenio   := 0

		SomaLinha()
		cCliente := TRB->CLIENT+TRB->LOJA
		@ Li,000 PSay STR0053  + AllTrim(TRB->CLIENT) + "-" + AllTrim(TRB->LOJA) + " - " + SubSTR( NGSEEK("SA1",cCliente,1,"SA1->A1_NOME"), 1, 40 ) //"Cliente/Loja: "
		SomaLinha()
		SomaLinha()

		While !Eof() .and. cCliente = TRB->CLIENT+TRB->LOJA

			cNome := TRB->NOMFIC

			@li,000 PSay SUBSTR(TRB->NOMFIC,1,25)
			@li,032 PSay TRB->MAT
			@li,042 PSay TRB->NUMFIC
			@li,053 PSay TRB->DTINIC
			@li,064 PSay TRB->DTFIM

			DbSelectArea("TNP")
			DbSetOrder(1)
			IF DbSeek(XFilial("TNP")+TRB->EMITEN)
				@li,075 PSay SUBSTR(TNP->TNP_NOME,1,20)
			EndIf

			nColDias := 97
			nColHoras := 109
			If lIndMed
				nIndMed := Val( TRB->INDMED )//Recebe o tipo de Médico
				If nIndMed <> 0
					If nIndMed == 1
						cNomMed := StrTran (AllTrim(TRB->INDMED) , "1=" )
						@li,097 PSay cNomMed
						nInterno++
					ElseIf nIndMed == 2
						cNomMed := StrTran (AllTrim(TRB->INDMED) , "2=" )
						@li,097 PSay cNomMed
						nExterno++
					ElseIf nIndMed == 3
						cNomMed := StrTran (AllTrim(TRB->INDMED) , "3=" )
						@li,097 PSay cNomMed
						nEmpresa++
					ElseIf nIndMed == 4
						cNomMed := StrTran (AllTrim(TRB->INDMED) , "4=" )
						@li,097 PSay cNomMed
						nSUS++
					ElseIf nIndMed == 5
						cNomMed := StrTran (AllTrim(TRB->INDMED) , "5=" )
						@li,097 PSay cNomMed
						nParticular++
					ElseIf nIndMed == 6
						cNomMed := StrTran (AllTrim(TRB->INDMED) , "6=" )
						@li,097 PSay cNomMed
						nConvenio++
					EndIf
				EndIf
				nColDias  := 110
				nColHoras := 122
			Endif

			lDiaOK := .T.
			If DtoC(TRB->DTFIM) == Space(8) .OR. Empty(TRB->DTFIM)
				lDiaOk := .F.
			EndIf

			If lHoraTotal
				If lDiaOK
					@li,nColDias PSay Posic1()//(TRB->DTFIM - TRB->DTINIC) + 1 picture "@E 9,999"
					nTotalDias += Posic1()//(TRB->DTFIM - TRB->DTINIC) + 1
				Else
					@li,nColDias PSay ( dDataBase - TRB->DTINIC )  + 1 picture "@E 9,999"
					nTotalDias += ( dDataBase - TRB->DTINIC ) + 1
				EndIf

				If Alltrim(TRB->QTDHOR) == ":" .OR. Empty(TRB->QTDHOR)
					lQTDHOR := .F.
				Else
					lQTDHOR := .T.
				EndIf

				If lQTDHOR
					If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
						@li,nColHoras PSay TRB->QTDHOR
					Endif
					nTotalHoras += HtoM(TRB->QTDHOR)
				Else
					lHoraOK := .T.
					If TRB->HRFIM == Space(5) .OR. Empty(TRB->HRFIM)
						lHoraOK := .F.
					EndIf

					If lHoraOK .AND. lDiaOK
						If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
							@li,nColHoras PSay ( (TRB->DTFIM - TRB->DTINIC)*24 + (Val(SUBSTR(TRB->HRFIM,1,2)) - Val(SUBSTR(TRB->HRINIC,1,2))) )
						Endif
						nTotalHoras += ( (TRB->DTFIM - TRB->DTINIC)*24 + (Val(SUBSTR(TRB->HRFIM,1,2)) - Val(SUBSTR(TRB->HRINIC,1,2))) )
					Else
						If !lDiaOK
							If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
								@li,nColHoras PSay ( (dDataBase - TRB->DTINIC)*24 + (Val(SUBSTR(Time(),1,2)) - Val(SUBSTR(TRB->HRINIC,1,2))) )
							Endif
							nTotalHoras += ( (dDataBase - TRB->DTINIC)*24 + (Val(SUBSTR(Time(),1,2)) - Val(SUBSTR(TRB->HRINIC,1,2))) )
						Else
							If !lHoraOK
								If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
									@li,nColHoras PSay  (TRB->DTFIM - TRB->DTINIC)*24
								Endif
								nTotalHoras += (TRB->DTFIM - TRB->DTINIC)*24
							EndIf
						EndIf
					EndIf
				Endif

			Else

				If lDiaOK
					@li,nColDias PSay Posic1()//(TRB->DTFIM - TRB->DTINIC) + 1 picture "@E 9,999"
					nTotalDias += Posic1()//(TRB->DTFIM - TRB->DTINIC) + 1
				Else
					@li,nColDias PSay Posic1()//( dDataBase - TRB->DTINIC ) + 1 picture "@E 9,999"
					nTotalDias += Posic1()//( dDataBase - TRB->DTINIC ) + 1
				EndIf

				If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
					If lIndMed
						@li,128 PSay Padl(TRB->QTDHOR,9," ")
					Else
						@li,112 PSay Padl(TRB->QTDHOR,9," ")
					EndIf
				Endif

			EndIf

			If lIndMed
				nLastCol := If(lPrintHr,138,123)
				@li,nLastCol PSay TRB->CID
				nLastCol += 9
				@li,nLastCol Psay TRB->DESCID
			Else
				nLastCol := If(lPrintHr,125,110)
				@li,nLastCol PSay TRB->CID
				nLastCol += 10
				@li,nLastCol Psay TRB->DESCID
			Endif
            //Imprime CID Complementar
			If mv_par14 == 1 .AND. !Empty(TRB->CID)
				cNATEST := NGSEEK("TNY",TRB->NUMFIC,1,"TNY_NATEST")
				fImpCIDCom(@nLastCol,cNATEST)
			EndIf
			dbSelectArea("TRB")
			dbSkip()
			SomaLinha()

			While !Eof()			  	 .AND.;
					cNome == TRB->NOMFIC   .AND.;
					cCliente = TRB->CLIENT+TRB->LOJA

				@li,053 PSay TRB->DTINIC
				@li,064 PSay TRB->DTFIM

				DbSelectArea("TNP")
				DbSetOrder(1)
				IF DbSeek(XFilial("TNP")+TRB->EMITEN)
					@li,075 PSay SUBSTR(TNP->TNP_NOME,1,20)
				EndIf

				nColDias := 97
				nColHoras := 109
				If lIndMed
					nIndMed := Val( TRB->INDMED )//Recebe o tipo de Médico
					If nIndMed <> 0
						If nIndMed == 1
							cNomMed := StrTran (AllTrim(TRB->INDMED) , "1=" )
							@li,097 PSay SUBSTR(cNomMed,1,12)
							nInterno++
						ElseIf nIndMed == 2
							cNomMed := StrTran (AllTrim(TRB->INDMED) , "2=" )
							@li,097 PSay SUBSTR(cNomMed,1,12)
							nExterno++
						ElseIf nIndMed == 3
							cNomMed := StrTran (AllTrim(TRB->INDMED) , "3=" )
							@li,097 PSay SUBSTR(cNomMed,1,12)
							nEmpresa++
						ElseIf nIndMed == 4
							cNomMed := StrTran (AllTrim(TRB->INDMED) , "4=" )
							@li,097 PSay SUBSTR(cNomMed,1,12)
							nSUS++
						ElseIf nIndMed == 5
							cNomMed := StrTran (AllTrim(TRB->INDMED) , "5=" )
							@li,097 PSay SUBSTR(cNomMed,1,12)
							nParticular++
						ElseIf nIndMed == 6
							cNomMed := StrTran (AllTrim(TRB->INDMED) , "6=" )
							@li,097 PSay SUBSTR(cNomMed,1,12)
							nConvenio++
						EndIf
					EndIf
					nColDias := 110
					nColHoras := 122
				Endif

				lDiaOK := .T.
				If DtoC(TRB->DTFIM) == Space(8) .OR. Empty(TRB->DTFIM)
					lDiaOk := .F.
				EndIf

				If lHoraTotal
					If lDiaOK
						@li,nColDias PSay Posic1() //(TRB->DTFIM - TRB->DTINIC) + 1 picture "@E 9,999"
						nTotalDias += Posic1()//(TRB->DTFIM - TRB->DTINIC) + 1
					Else
						@li,nColDias PSay ( dDataBase - TRB->DTINIC )  + 1 picture "@E 9,999"
						nTotalDias += ( dDataBase - TRB->DTINIC ) + 1
					EndIf

					If Alltrim(TRB->QTDHOR) == ":" .OR. Empty(TRB->QTDHOR)
						lQTDHOR := .F.
					Else
						lQTDHOR := .T.
					EndIf

					If lQTDHOR
						If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
							@li,nColHoras PSay TRB->QTDHOR
						Endif
						nTotalHoras += HtoM(TRB->QTDHOR)
					Else
						lHoraOK := .T.
						If TRB->HRFIM == Space(5) .OR. Empty(TRB->HRFIM)
							lHoraOK := .F.
						EndIf
						If lHoraOK .AND. lDiaOK
							If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
								@li,nColHoras PSay ( (TRB->DTFIM - TRB->DTINIC)*24 + (Val(SUBSTR(TRB->HRFIM,1,2)) - Val(SUBSTR(TRB->HRINIC,1,2))) )
							Endif
							nTotalHoras += ( (TRB->DTFIM - TRB->DTINIC)*24 + (Val(SUBSTR(TRB->HRFIM,1,2)) - Val(SUBSTR(TRB->HRINIC,1,2))) )
						Else
							If !lDiaOK
								If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
									@li,nColHoras PSay ( (dDataBase - TRB->DTINIC)*24 + (Val(SUBSTR(Time(),1,2)) - Val(SUBSTR(TRB->HRINIC,1,2))) )
								Endif
								nTotalHoras += ( (dDataBase - TRB->DTINIC)*24 + (Val(SUBSTR(Time(),1,2)) - Val(SUBSTR(TRB->HRINIC,1,2))) )
							Else
								If !lHoraOK
									If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
										@li,nColHoras PSay  (TRB->DTFIM - TRB->DTINIC)*24
									Endif
									nTotalHoras += (TRB->DTFIM - TRB->DTINIC)*24
								EndIf
							EndIf
						EndIf
					Endif
				Else
					If lDiaOK
						@li,nColDias PSay Posic1() //(TRB->DTFIM - TRB->DTINIC) + 1 picture "@E 9,999"
						nTotalDias += Posic1()//(TRB->DTFIM - TRB->DTINIC) + 1
					Else
						@li,nColDias PSay Posic1()//( dDataBase - TRB->DTINIC ) + 1 picture "@E 9,999"
						nTotalDias += Posic1()//( dDataBase - TRB->DTINIC ) + 1
					EndIf

					cPerdido := TRB->QTDHOR
					If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
						If lIndMed
							@li,125 PSay Padl(cPerdido,9," ")
						Else
							@li,112 PSay Padl(cPerdido,9," ")
						EndIf
					Endif
				EndIf

				If lIndMed
					nLastCol := If(lPrintHr,138,123)
					@li,nLastCol PSay TRB->CID
					nLastCol += 9
					@li,nLastCol Psay TRB->DESCID
				Else
					nLastCol := If(lPrintHr,125,110)
					@li,nLastCol PSay TRB->CID
					nLastCol += 10
					@li,nLastCol Psay TRB->DESCID
				Endif
				If !Empty(TRB->CID) .AND. !Empty(cNATEST)
					fImpCIDCom(@nLastCol,cNATEST)
				EndIf

				SomaLinha()

				dbSelectArea("TRB")
				DbSkip()
			End  //Matricula

		End	 //Cliente

		If lIndMed
			SomaLinha()
			@li,075 PSay STR0054 + ALLTRIM(STR(nTotalDias))//"Total de Dias...................:  "
			If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
				@li,125 PSay Padl(MtoH(nTotalHoras),9," ") //Total de horas
			Endif
			SomaLinha()
			@li,075 PSay STR0096 + ALLTRIM(STR(nInterno))   //"Total de Atestados - Interno....:  "
			SomaLinha()
			@li,075 PSay STR0097 + ALLTRIM(STR(nExterno))   //"Total de Atestados - Externo....:  "
			SomaLinha()
			@li,075 PSay STR0055 + ALLTRIM(STR(nEmpresa))   //"Total de Atestados - Empresa....:  "
			SomaLinha()
			@li,075 PSay STR0056 + ALLTRIM(STR(nSUS))       //"Total de Atestados - SUS........:  "
			SomaLinha()
			@li,075 PSay STR0068 + ALLTRIM(STR(nParticular))//"Total de Atestados - Particular.:  "
			SomaLinha()
			@li,075 PSay STR0069 + ALLTRIM(STR(nConvenio))  //"Total de Atestados - Convênio...:  "
		Else
			SomaLinha()
			@li,080 PSay STR0054 + ALLTRIM(STR(nTotalDias)) //"Total de Dias...................:  "
			If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
				@li,122 PSay ALLTRIM(STR(nTotalHoras))  //Total de horas
			Endif
		Endif

		SomaLinha()
		@ Li,000 PSAY __PrtThinLine()
		lPrint := .t.
	End

Else //Totaliza por Filial

	If lIndMed

		nInterno    := 0
		nExterno    := 0
		nEmpresa    := 0
		nSUS        := 0
		nParticular := 0
		nConvenio   := 0

		dbSelectArea("TM0")
		dbSetOrder(02)
		dbSeek(xFilial("TM0"))

		SetRegua(LastRec())
		While !Eof() .AND. TM0->TM0_FILIAL = xFilial('TM0')

			DbSelectArea("SRA")
			DbSetOrder(01)
			If !DbSeek(TM0->TM0_FILFUN+TM0->TM0_MAT) .OR. Empty(TM0->TM0_MAT)
				dbSelectArea("TM0")
				DbSkip()
				Loop
			EndIf

			IF TM0->TM0_NUMFIC < MV_PAR01 .or. TM0->TM0_NUMFIC > MV_PAR02
				dbSelectArea("TM0")
				DBSkip()
				Loop
			ENDIF

			If SRA->RA_CC < Mv_par05 .or. SRA->RA_CC > Mv_par06
				dbSelectArea("TM0")
				DbSkip()
				Loop
			Endif

			nDias := 0
			cPerdido := ""
			cHoraFim := ""
			lfirst := .t.
			dbselectArea("TNY")
			dbSetOrder(01)
			dbSeek(xFilial("TNY")+TM0->TM0_NUMFIC)
			While !Eof() .AND. TNY->TNY_FILIAL = xFilial('TNY') .AND. TNY->TNY_NUMFIC = TM0->TM0_NUMFIC

				If !(	(TNY->TNY_DTINIC >= mv_par03 .And. TNY->TNY_DTINIC <= mv_par04) .Or.;
						(TNY->TNY_DTFIM >= mv_par03 .And. TNY->TNY_DTFIM <= mv_par04) .Or.;
						(TNY->TNY_DTINIC <= mv_par03 .And. TNY->TNY_DTFIM >= mv_par04)	)
					DBSKIP()
					Loop
				ENDIF

				If TNY->TNY_EMITEN < MV_PAR07 .OR. TNY->TNY_EMITEN > MV_PAR08
					dbSelectArea("TNY")
					dbSKIP()
					loop
				Endif
			If mv_par10 == 1
				cNATEST := ""
				dbSelectArea("TKI")
					dbSetOrder(1)
					If dbSeek(xFilial("TKI") + TNY->TNY_NATEST)
						cNATEST := TNY->TNY_NATEST
					EndIf
				EndIf

				nDias := 0
				cPerdido := ""
				cHoraFim := ""
				SomaLinha()

				IF lfirst
					@li,000 PSay SUBSTR(TM0->TM0_NOMFIC,1,25)
					lfirst := .f.
					lPrint := .t.
				ENDIF

				@li,032 PSay TM0->TM0_MAT
				@li,042 PSay TM0->TM0_NUMFIC
				@li,053 PSay TNY->TNY_DTINIC
				@li,064 PSay TNY->TNY_DTFIM

				DbSelectArea("TNP")
				DbSetOrder(1)
				IF DbSeek(XFilial("TNP")+TNY->TNY_EMITEN)
					@li,075 PSay SUBSTR(TNP->TNP_NOME,1,20)
				EndIf

				If TNY->TNY_INDMED == "1"
					nInterno++
					@li,097 PSay STR0098//"Interno"
				ElseIf TNY->TNY_INDMED == "2"
					nExterno++
					@li,097 PSay STR0099//"Externo"
				ElseIf TNY->TNY_INDMED == "3"
					nEmpresa++
					@li,097 PSay STR0073//"Empresa"
				ElseIf TNY->TNY_INDMED == "4"
					nSUS++
					@li,097 PSay STR0074//"SUS"
				ElseIf TNY->TNY_INDMED == "5"
					nParticular++
					@li,097 PSay STR0090//"Particular"
				ElseIf TNY->TNY_INDMED == "6"
					nConvenio++
					@li,097 PSay STR0091//"Convênio"
				Endif

				lDiaOK := .T.
				If DtoC(TNY->TNY_DTFIM) == Space(8) .OR. Empty(TNY->TNY_DTFIM)
					lDiaOk := .F.
				EndIf

				lHoraOK := .T.
				If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
					lHoraOK := .F.
				EndIf

				If lDiaOK
					@li,110 PSay Posic1() //(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1 picture "@E 9,999"
					nDias := Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
					nTotalDias += Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
				Else
					@li,110 PSay (	Date() - TNY->TNY_DTINIC ) + 1 picture "@E 9,999"
					nDias := ( 	Date() - TNY->TNY_DTINIC ) + 1
					nTotalDias += ( Date() - TNY->TNY_DTINIC ) + 1
				EndIf

				If !lHoraOk
					cHoraFim := SubStr( Time(),1,5)
				Else
					cHoraFim := TNY->TNY_HRFIM
				Endif

				If lHoraTotal
					If lDiaOK
						@li,110 PSay Posic1() //(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1 picture "@E 9,999"
						nTotalDias += Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
					Else
						@li,110 PSay ( dDataBase - TNY->TNY_DTINIC )  + 1 picture "@E 9,999"
						nTotalDias += ( dDataBase - TNY->TNY_DTINIC ) + 1
					EndIf

					If Alltrim(TNY->TNY_QTDHOR) == ":" .OR. Empty(TNY->TNY_QTDHOR)
						lQTDHOR := .F.
					Else
						lQTDHOR := .T.
					EndIf

					If lQTDHOR
						If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
							@li,122 PSay MtoH( Val(TNY->TNY_QTDHOR) * 60 )
						Endif
						nTotalHoras += Val(TNY->TNY_QTDHOR) * 60
					Else
						lHoraOK := .T.
						If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
							lHoraOK := .F.
						EndIf

						If lHoraOK .AND. lDiaOK
							nD_tmp := ( (TNY->TNY_DTFIM - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(TNY->TNY_HRFIM,1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2))) )
							If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
								@li,122 PSay MtoH( nD_tmp * 60 )
							Endif
							nTotalHoras += nD_tmp * 60
						Else
							If !lDiaOK
								nD_tmp := ( (dDataBase - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(Time(),1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2))) )
								If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
									@li,122 PSay MtoH( nD_tmp * 60 )
								Endif
								nTotalHoras += nD_tmp * 60
							Else
								If !lHoraOK
									If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
										@li,122 PSay MtoH( (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60 )
									Endif
									nTotalHoras += (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60
								EndIf
							EndIf
						EndIf

					EndIf
				Else
					cTurnoTrab :=  SRA->RA_TNOTRAB
					cTurnSeq := SRA->RA_SEQTURN
					U_MDT700TURN() //Verifica o turno dentro do periodo do atestado.

					cPerdido := U_SomaHrSPJ( TNY->TNY_DTINIC, TNY->TNY_DTFIM, TNY->TNY_HRINIC, TNY->TNY_HRFIM , cTurnoTrab , cTurnSeq , SRA->RA_FILIAL)
					If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
						@li,125 PSay Padl(cPerdido,9," ")
					Endif
					nTotalHoras += HtoM( cPerdido )
				Endif

				nLastCol := If(lPrintHr,138,123)
				@li, nLastCol PSay TNY->TNY_CID
				nLastCol += 9
				@li, nLastCol Psay SubStr(AllTrim(NGSEEK("TMR",TNY->TNY_CID,1,"TMR_DOENCA")),1,42)
	    		//CID Complementar
				If !Empty(TNY->TNY_CID) .AND. !Empty(cNATEST)
					fImpCIDCom(@nLastCol,cNATEST)
				EndIf

				dbSelectArea("TNY")
				DBSkip()

			END

			dbSelectArea("TM0")
			DBSkip()
			IncRegua()

		END

		SomaLinha()
		SomaLinha()
		@li,075 PSay STR0054 + ALLTRIM(STR(nTotalDias))//"Total de Dias...................:  "
		If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
			@li,125 PSay Padl(MtoH(nTotalHoras),9," ")
		Endif
		SomaLinha()
		@li,075 PSay STR0096 + ALLTRIM(STR(nInterno))   //"Total de Atestados - Interno....:  "
		SomaLinha()
		@li,075 PSay STR0097 + ALLTRIM(STR(nExterno))   //"Total de Atestados - Externo....:  "
		SomaLinha()
		@li,075 PSay STR0055 + ALLTRIM(STR(nEmpresa))   //"Total de Atestados - Empresa....:  "
		SomaLinha()
		@li,075 PSay STR0056 + ALLTRIM(STR(nSUS))       //"Total de Atestados - SUS........:  "
		SomaLinha()
		@li,075 PSay STR0068 + ALLTRIM(STR(nParticular))//"Total de Atestados - Particular.:  "
		SomaLinha()
		@li,075 PSay STR0069 + ALLTRIM(STR(nConvenio))  //"Total de Atestados - Convênio...:  "

	Else

		dbSelectArea("TM0")
		dbSetOrder(02)
		dbSeek(xFilial("TM0"))

		SetRegua(LastRec())
		While !Eof() .AND. TM0->TM0_FILIAL = xFilial('TM0')

			DbSelectArea("SRA")
			DbSetOrder(01)
			If !DbSeek(TM0->TM0_FILFUN+TM0->TM0_MAT) .OR. Empty(TM0->TM0_MAT)
				dbSelectArea("TM0")
				DbSkip()
				Loop
			EndIf
			IF TM0->TM0_NUMFIC < MV_PAR01 .or. TM0->TM0_NUMFIC > MV_PAR02
				dbSelectArea("TM0")
				DBSkip()
				Loop
			ENDIF
			If SRA->RA_CC < Mv_par05 .or. SRA->RA_CC > Mv_par06
				dbSelectArea("TM0")
				DbSkip()
				Loop
			Endif

			lfirst := .t.
			dbselectArea("TNY")
			dbSetOrder(01)
			dbSeek(xFilial("TNY")+TM0->TM0_NUMFIC)
			While !Eof() .AND. TNY->TNY_FILIAL = xFilial('TNY') .AND. TNY->TNY_NUMFIC = TM0->TM0_NUMFIC
				If !(	(TNY->TNY_DTINIC >= mv_par03 .And. TNY->TNY_DTINIC <= mv_par04) .Or.;
						(TNY->TNY_DTFIM >= mv_par03 .And. TNY->TNY_DTFIM <= mv_par04) .Or.;
						(TNY->TNY_DTINIC <= mv_par03 .And. TNY->TNY_DTFIM >= mv_par04)	)
					DBSKIP()
					Loop
				ENDIF

				If TNY->TNY_EMITEN < MV_PAR07 .OR. TNY->TNY_EMITEN > MV_PAR08
					dbSelectArea("TNY")
					dbSKIP()
					loop
				Endif
				If AliasIndic("TKI") .AND. mv_par10 == 1
					cNATEST := ""
					dbSelectArea("TKI")
					dbSetOrder(1)
					If dbSeek(xFilial("TKI") + TNY->TNY_NATEST)
						cNATEST := TNY->TNY_NATEST
					EndIf
				EndIf

				nDias := 0
				cPerdido := ""
				cHoraFim := ""
				SomaLinha()
				IF lfirst
					@li,000 PSay SUBSTR(TM0->TM0_NOMFIC,1,25)
					lfirst := .f.
					lPrint := .t.
				ENDIF
				@li,032 PSay TM0->TM0_MAT
				@li,042 PSay TM0->TM0_NUMFIC
				@li,053 PSay TNY->TNY_DTINIC
				@li,064 PSay TNY->TNY_DTFIM
				DbSelectArea("TNP")
				DbSetOrder(1)
				IF DbSeek(XFilial("TNP")+TNY->TNY_EMITEN)
					@li,075 PSay SUBSTR(TNP->TNP_NOME,1,20)
				EndIf

				lDiaOK := .T.
				If DtoC(TNY->TNY_DTFIM) == Space(8) .OR. Empty(TNY->TNY_DTFIM)
					lDiaOk := .F.
				EndIf

				lHoraOK := .T.
				If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
					lHoraOK := .F.
				EndIf

				If lDiaOK
					@li,97 PSay Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
					nDias := Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
					nTotalDias += Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
				Else
					@li,97 PSay ( 	Date() - TNY->TNY_DTINIC ) + 1
					nDias := ( 	Date() - TNY->TNY_DTINIC ) + 1
					nTotalDias += ( Date() - TNY->TNY_DTINIC ) + 1
				EndIf

				If !lHoraOk
					cHoraFim := SubStr( Time(),1,5)
				Else
					cHoraFim := TNY->TNY_HRFIM
				Endif

				If lHoraTotal
					If lDiaOK
						@li,97 PSay (TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
						nTotalDias += (TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
					Else
						@li,97 PSay ( 	Date() - TNY->TNY_DTINIC )  + 1
						nTotalDias += ( Date() - TNY->TNY_DTINIC ) + 1
					EndIf

					If Alltrim(TNY->TNY_QTDHOR) == ":" .OR. Empty(TNY->TNY_QTDHOR)
						lQTDHOR := .F.
					Else
						lQTDHOR := .T.
					EndIf

					If lQTDHOR
						If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
							@li,109 PSay MtoH( Val(TNY->TNY_QTDHOR) * 60 )
						Endif
						nTotalHoras += Val(TNY->TNY_QTDHOR) * 60
					Else
						lHoraOK := .T.
						If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
							lHoraOK := .F.
						EndIf

						If lHoraOK .AND. lDiaOK
							nD_tmp := ( (TNY->TNY_DTFIM - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(TNY->TNY_HRFIM,1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2))) )
							If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
								@li,109 PSay MtoH( nD_tmp * 60 )
							Endif
							nTotalHoras += nD_tmp * 60
						Else
							If !lDiaOK
								nD_tmp := ( (Date() - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(Time(),1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2))) )
								If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
									@li,109 PSay MtoH( nD_tmp * 60 )
								Endif
								nTotalHoras += nD_tmp * 60
							Else
								If !lHoraOK
									If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
										@li,109 PSay MtoH( (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60 )
									Endif
									nTotalHoras += (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60
								EndIf
							EndIf
						EndIf
					EndIf
				Else
					cTurnoTrab := SRA->RA_TNOTRAB
					cTurnSeq := SRA->RA_SEQTURN
					U_MDT700TURN() //Verifica o turno dentro do periodo do atestado.

					cPerdido := U_SomaHrSPJ( TNY->TNY_DTINIC, TNY->TNY_DTFIM, TNY->TNY_HRINIC, TNY->TNY_HRFIM ,cTurnoTrab , cTurnSeq , SRA->RA_FILIAL)
					If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
						@li,112 PSay Padl(cPerdido,9," ")
					Endif
					nTotalHoras += HtoM( cPerdido )
				EndIf

				nLastCol := If(lPrintHr,125,110)
				@li,nLastCol PSay TNY->TNY_CID
				nLastCol += 10
				@li,nLastCol Psay SubStr(AllTrim(NGSEEK("TMR",TNY->TNY_CID,1,"TMR_DOENCA")),1,42)
	    		//CID Complementar
				If !Empty(TNY->TNY_CID) .AND. !Empty(cNATEST)
					fImpCIDCom(@nLastCol,cNATEST)
				Endif

				dbSelectArea("TNY")
				DBSkip()

			END

			dbSelectArea("TM0")
			DBSkip()
			IncRegua()

		END

		somalinha()
		@li,085 PSay STR0012 + Space(6) + ALLTRIM(STR(nTotalDias))	//"Total:"   <total dias>
		If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
			@li,112 PSay Padl(MtoH(nTotalHoras),9," ")
		Endif

	Endif

Endif


If !lPrint
	MsgInfo(STR0027)  //"Não há nada para imprimir no relatório."
	RetIndex("TM0")
	Set Filter To
	If lSigaMdtps
		oTempTRB:Delete()
	Endif
	Return .F.
Endif

Roda(nCntImpr,cRodaTxt,Tamanho)

//---------------------------------------------------------------------
//  Devolve a condicao original do arquivo principal
//---------------------------------------------------------------------
RetIndex("TM0")

Set Filter To

If lSigaMdtps
	oTempTRB:Delete()
Endif

Set device to Screen

If aReturn[5] = 1
        Set Printer To
        dbCommitAll()
        OurSpool(wnrel)
Endif
//SET CENTURY ON
MS_FLUSH()

dbSelectArea("TM0")
dbSetOrder(01)

Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} R710ImpC
Chamada do Relat¢rio (separa por Centro de Custo)

@param lEnd - Cancela a impressão.
@param wnRel - Programa utilizado.
@param titulo - Titulo do relatório.
@param tamanho - Tamanho do relatório.

@author Andre E. Perez Alvarez
@since 28/12/05
@return
/*/
//---------------------------------------------------------------------
Static Function R710ImpC(lEnd,wnRel,titulo,tamanho)

//---------------------------------------------------------------------
//  Variaveis locais exclusivas desta funcao
//---------------------------------------------------------------------
LOCAL cRodaTxt := ""
LOCAL nCntImpr := 0
LOCAL cCCtemp	//var01
LOCAL lMesmoCC 	//var02
LOCAL lHoraOK	//var03
LOCAL lDiaOK	//var04
LOCAL nTotDcc := 0	  //var05
LOCAL nTotHcc := 0	  //var06
LOCAL lFirst  := .T.  //var07
LOCAL lFirst2 := .T.  //var08
LOCAL lQTDHOR         //var09
LOCAL nTotalDias  := 0   //var10
LOCAL nTotalHoras := 0   //var11
Local nLastCol    := 0

Local lPrint   := .f.
Local lPrintHr := GetNewpar("MV_NG2HRAT", "1") == "1" // Verifica se serao impressas as Horas do Atestado
Local cNATEST
Local mv_CID //Parametro para impressao de cabecalho de CID Complementar

Private cTurnoTrab := ""
Private cTurnSeq := ""

If lSigaMdtPs
	mv_CID := mv_par14 == 1
Else
	mv_CID := mv_par10 == 1
EndIf

//---------------------------------------------------------------------
//                         Descricao das variaveis
//---------------------------------------------------------------------
/*
var01 - Centro de Custo do registro atualmente selecionado em "SRA"
var02 - Denota se o registro atualmente selecionado em "SRA" é do mesmo Centro de Custo do
        registro anterior
var03 - Denota se o campo TNY->TNY_HRFIM está preenchido
var04 - Denota se o campo TNY->TNY_DTFIM está preenchido
var05 - Total de dias de afastamento por Centro de Custo
var06 - Total de horas de afastamento por Centro de Custo
var07 - Serve para imprimir apenas uma vez o nome de um determinado funcionário,
   		caso ele tenha mais do que um período de afastamento.
var08 - Serve para indicar o momento exato de imprimir o total de dias e de horas
   		de afastamento por centro de custo.
var09 - Denota se o campo TNY->TNY_QTDHOR está preenchido
var10 - Total geral de dias de afastamento
var11 - Total geral de horas de afastamento
*/

//---------------------------------------------------------------------
//  Contadores de linha e pagina
//---------------------------------------------------------------------
PRIVATE li := 80 ,m_pag := 1

//---------------------------------------------------------------------
//  Verifica se deve comprimir ou nao
//---------------------------------------------------------------------
nTipo  := IIF(aReturn[4]==1,15,18)

//---------------------------------------------------------------------
//  Monta os Cabecalhos
//---------------------------------------------------------------------
cabec1 := STR0007 //"        Centro de Custo"
If lIndMed
	// 1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7
	// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Ind. Medico  Total Dias   Total Horas    CID      Descricao"
	//"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Ind. Medico  Total Dias   CID      Descricao"
	If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
		If mv_CID //CID Complementar
			cabec2 := STR0051 //"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Ind. Medico  Total Dias   Total Horas    CID      Descricao       CID Complementar"
		Else
			cabec2 := STR0082 //"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Ind. Medico  Total Dias   Total Horas    CID      Descricao"
		EndIf
	Else
		If mv_CID //CID Complementar
			cabec2 := STR0075 //"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Ind. Medico  Total Dias   CID      Descricao          CID Complementar"
		Else
			cabec2 := STR0084 //"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Ind. Medico  Total Dias   CID      Descricao"
		EndIf
	Endif
Else
	// 1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7
	// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Total Dias   Total Horas    CID       Descricao"
	//"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Total Dias   CID       Descricao"
	If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
		If mv_CID
			cabec2 := STR0052 //"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Total Dias   Total Horas    CID       Descricao     CID Complementar"
		Else
			cabec2 := STR0083//"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Total Dias   Total Horas    CID       Descricao"
		EndIf
	Else
		If mv_CID
			cabec2 := STR0076 //"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Total Dias   CID       Descricao       CID Complementar"
		Else
			cabec2 := STR0085//"Nome                            Matric.   Ficha Med. Dt.Afast.  Dt. Fim    Medico Emitente       Total Dias   CID       Descricao"
		EndIf
	Endif
Endif

/*
If lIndMed

	************************************************************************************************************************************
	*<empresa>                                                                                                        Folha..: xxxxx   *
	*SIGA /<nome .04                                                                                                  DT.Ref.: dd/mm/aa*
	*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
	************************************************************************************************************************************

	          1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	(Padrao)                                 Funcionarios por Centro de Custo e Funcao                                 (Padrao)
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			Centro de Custo
	Nome                            Matric.  Ficha Med.  Dt.Afast.  Dt. Fim    Medico Emitente       Ind. Medico  Total Dias  Total Horas
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			XXXXXXXXX
	XXXXXXXXXXXXXXXXXXXXXXXXX   XXXXXX      XXXXXXXXX      99/99/99        99/99/99       XXXXXXXXXXXXXXXXXXXX     XXXX          XXXX


Else

	************************************************************************************************************************************
	*<empresa>                                                                                                        Folha..: xxxxx   *
	*SIGA /<nome .04                                                                                                  DT.Ref.: dd/mm/aa*
	*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
	************************************************************************************************************************************

	          1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	(Padrao)                                 Funcionarios por Centro de Custo e Funcao                                 (Padrao)
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			Centro de Custo
	Nome                            Matric.  Ficha Med.  Dt.Afast.  Dt. Fim    Medico Emitente       Total Dias  Total Horas  Ind. Medico
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			XXXXXXXXX
	XXXXXXXXXXXXXXXXXXXXXXXXX   XXXXXX      XXXXXXXXX      99/99/99        99/99/99       XXXXXXXXXXXXXXXXXXXX     XXXX          XXXX

Endif
*/

If lSigaMdtps //Totaliza por CC

	If lIndMed

		nInterno    := 0
		nExterno    := 0
		nEmpresa    := 0
		nSUS        := 0
		nParticular := 0
		nConvenio   := 0

		DbSelectArea("SRA")
		DbSetOrder(02) //RA_CC+RA_MAT
		dbSeek(xFilial("SRA"))
		SetRegua(LastRec())
		While 	SRA->RA_FILIAL == xFilial("SRA")		.AND.;
				!Eof()

			If SRA->RA_CC < Mv_par09 .OR. SRA->RA_CC > Mv_par10
		    	DbSkip()
			    Loop
			Endif

			cCliente := SubStr(SRA->RA_CC,1,nSizeTD)

			If cCliente < mv_par01+mv_par02 .or. cCliente > mv_par03+mv_par04
				dbSelectArea("SRA")
				dbSkip()
				Loop
			Endif

		    dbSelectArea("TM0")
			dbSetOrder(03) //TM0_FILFUN+TM0_MAT+TM0_NUMDEP
			dbSeek (SRA->RA_FILIAL + SRA->RA_MAT)
			While  TM0->TM0_FILFUN == SRA->RA_FILIAL  .AND.;
				   TM0->TM0_MAT    == SRA->RA_MAT     .AND.;
					  !Eof()
				IF TM0->TM0_NUMFIC < MV_PAR05 .OR. TM0->TM0_NUMFIC > MV_PAR06
		         	DBSkip()
		            Loop
		   		ENDIF
		   		lfirst := .T.
				dbselectArea("TNY")
				dbSetOrder(01)
				dbSeek(xFilial("TNY")+TM0->TM0_NUMFIC)
				While  TNY->TNY_FILIAL == xFilial('TNY')   .AND.;
					   TNY->TNY_NUMFIC == TM0->TM0_NUMFIC  .AND.;
						  !Eof()
		  			IF TNY->TNY_DTINIC < MV_PAR07 .OR. TNY->TNY_DTINIC > MV_PAR08
		   			DBSKIP()
		   			Loop
		   		ENDIF
		   		If TNY->TNY_EMITEN < MV_PAR11 .OR. TNY->TNY_EMITEN > MV_PAR12
				   	dbSKIP()
		      		loop
				Endif
			If  mv_par14 == 1
		   		cNATEST := ""
					dbSelectArea("TKI")
					dbSetOrder(1)
					If dbSeek(xFilial("TKI") + TNY->TNY_NATEST)
						cNATEST := TNY->TNY_NATEST
					EndIf
				EndIf
				SomaLinha()
				If cCCtemp <> SRA->RA_CC
					cCCtemp := SRA->RA_CC
			   		lMesmoCC := .F.
		  		Else
			  		lMesmoCC := .T.
		   		EndIf
				   IF lfirst
			    		If !lMesmoCC
			    			If !lFirst2
			    				SomaLinha()
								@li,075 PSay STR0057 + ALLTRIM(STR(nTotDcc))//"Total do Centro de Custo........:  "
							If lPrintHr
								@li,122 PSay ALLTRIM(STR(nTotHcc))  //Total de horas
							EndIf
								SomaLinha()
								@li,075 PSay STR0096 + ALLTRIM(STR(nInterno))   //"Total de Atestados - Interno....:  "
								SomaLinha()
								@li,075 PSay STR0097 + ALLTRIM(STR(nExterno))   //"Total de Atestados - Externo....:  "
								SomaLinha()
								@li,075 PSay STR0055 + ALLTRIM(STR(nEmpresa))   //"Total de Atestados - Empresa....:  "
								SomaLinha()
								@li,075 PSay STR0056 + ALLTRIM(STR(nSUS))       //"Total de Atestados - SUS........:  "
								SomaLinha()
								@li,075 PSay STR0068 + ALLTRIM(STR(nParticular))//"Total de Atestados - Particular.:  "
								SomaLinha()
								@li,075 PSay STR0069 + ALLTRIM(STR(nConvenio))  //"Total de Atestados - Convênio...:  "
								nTotDcc := 0
								nTotHcc := 0
								nInterno    := 0
								nExterno    := 0
								nEmpresa    := 0
								nSUS        := 0
								nParticular := 0
								nConvenio   := 0
								SomaLinha()
								lFirst2 := .T.
					    		@li,000 Psay Replicate("-",221)
					    		SomaLinha()
			    			EndIf
				    		@li,08 PSay AllTrim(SRA->RA_CC) + " - " + NGSEEK(cAliasCC,SRA->RA_CC,1,cDescCC2)
				    		SomaLinha(); SomaLinha()
				    	EndIf
			    		@li,000 PSay SUBSTR(TM0->TM0_NOMFIC,1,25)
			    		lfirst  := .F.
			    		lFirst2 := .F.
			    	ENDIF

		    		@li,032 PSay TM0->TM0_MAT
		    		@li,042 PSay TM0->TM0_NUMFIC
		    		@li,053 PSay TNY->TNY_DTINIC
		    		@li,064 PSay TNY->TNY_DTFIM

		    		lPrint := .t.

					DbSelectArea("TNP")
					DbSetOrder(1)
					IF DbSeek(XFilial("TNP")+TNY->TNY_EMITEN)
		    			@li,075 PSay SUBSTR(TNP->TNP_NOME,1,20)
		   			EndIf

					If TNY->TNY_INDMED == "1"
			   			nInterno++
			   			@li,097 PSay STR0098 //"Interno"
			   		ElseIf TNY->TNY_INDMED == "2"
			   			nExterno++
			   			@li,097 PSay STR0099 //"Externo"
					ElseIf TNY->TNY_INDMED == "3"
			   			nEmpresa++
			   			@li,097 PSay STR0073//"Empresa"
			   		ElseIf TNY->TNY_INDMED == "4"
			   			nSUS++
			   			@li,097 PSay STR0074//"SUS"
			   		ElseIf TNY->TNY_INDMED == "5"
			   			nParticular++
			   			@li,097 PSay STR0090//"Particular"
			   		ElseIf TNY->TNY_INDMED == "6"
			   			nConvenio++
			   			@li,097 PSay STR0091//"Convênio"
			   		Endif

		   			lDiaOK := .T.

		    		If DtoC(TNY->TNY_DTFIM) == Space(8) .OR. Empty(TNY->TNY_DTFIM)
		    			lDiaOk := .F.
		    		EndIf

					lHoraOK := .T.

					If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
						lHoraOK := .F.
					EndIf

		   		If lDiaOK
					@li,110 PSay Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1 picture "@E 9,999"
		   			nDias := Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
		   			nTotalDias += Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
						nTotDcc += Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
		   		Else
		   			@li,110 PSay (	Date() - TNY->TNY_DTINIC ) + 1 picture "@E 9,999"
		   			nDias := ( 	Date() - TNY->TNY_DTINIC ) + 1
		    	   	nTotalDias += ( Date() - TNY->TNY_DTINIC ) + 1
		   		EndIf

		   		If !lHoraOk
		   			cHoraFim := SubStr( Time(),1,5)
		   		Else
		   			cHoraFim := TNY->TNY_HRFIM
		   		Endif

					If lHoraTotal
						If Alltrim(TNY->TNY_QTDHOR) == ":" .OR. Empty(TNY->TNY_QTDHOR)
				    		lQTDHOR := .F.
				    	Else
				    		lQTDHOR := .T.
				    	EndIf

						If lQTDHOR
							If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
					 			@li,122 PSay MtoH( Val(TNY->TNY_QTDHOR) * 60 )
					 		Endif
							nTotalHoras += Val(TNY->TNY_QTDHOR) * 60
					  		nTotHcc += Val(TNY->TNY_QTDHOR) * 60
						Else
							lHoraOK := .T.
							If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
								lHoraOK := .F.
							EndIf

							If lHoraOK .AND. lDiaOK
								nD_tmp := ( (TNY->TNY_DTFIM - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(TNY->TNY_HRFIM,1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2))) )
								If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
									@li,122 PSay MtoH( nD_tmp * 60 )
								Endif
								nTotalHoras += nD_tmp * 60
					    		nTotHcc += nD_tmp * 60
							Else
	            			If !lDiaOK
		            			nD_tmp := ( (dDataBase - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(Time(),1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2))) )
		            			If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
									@li,122 PSay MtoH( nD_tmp * 60 )
								Endif
								nTotalHoras += nD_tmp * 60
	            				nTotHcc += nD_tmp * 60
	            			Else
	            				If !lHoraOK
	            					If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
		            					@li,122 PSay MtoH( (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60 )
		            				Endif
										nTotalHoras += (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60
				    					nTotHcc += (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60
	            				EndIf
	            			EndIf
							EndIf
						Endif
   					Else
	   					cTurnoTrab := SRA->RA_TNOTRAB
						cTurnSeq := SRA->RA_SEQTURN
						U_MDT700TURN() //Verifica o turno dentro do periodo do atestado.

						cPerdido := U_SomaHrSPJ( TNY->TNY_DTINIC, TNY->TNY_DTFIM, TNY->TNY_HRINIC, TNY->TNY_HRFIM , cTurnoTrab , cTurnSeq , SRA->RA_FILIAL)
						If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
		    				@li,125 PSay Padl(cPerdido,9," ")
		    			Endif
		    		    If !Empty(cPerdido)
		    		    	nTotalHoras += HtoM( cPerdido )
		    		    	nTotHcc += HtoM( cPerdido )
		    		    Endif
					Endif

					nLastCol := If(lPrintHr,138,123)
		    		@li, nLastCol PSay TNY->TNY_CID
		    		nLastCol += 9
		    		@li, nLastCol Psay SubStr(AllTrim(NGSEEK("TMR",TNY->TNY_CID,1,"TMR_DOENCA")),1,42)
		    		//CID Complementar
		    		If !Empty(TNY->TNY_CID) .And. !Empty(cNATEST)
	    				fImpCIDCom(@nLastCol,cNATEST)
	    			Endif

		    		dbSelectArea("TNY")
		        	DBSkip()
		   	End
				dbSelectArea("TM0")
				DBSkip()
			End
			dbSelectArea("SRA")
			DBSkip()
			IncRegua()
		End

		SomaLinha()
		SomaLinha()
		@li,075 PSay STR0057 + ALLTRIM(STR(nTotDcc))//"Total do Centro de Custo........:  "
		If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
			@li,122 PSay ALLTRIM(STR(nTotHcc))  //Total de horas
		Endif
		SomaLinha()
		@li,075 PSay STR0096 + ALLTRIM(STR(nInterno))   //"Total de Atestados - Interno....:  "
		SomaLinha()
		@li,075 PSay STR0097 + ALLTRIM(STR(nExterno))   //"Total de Atestados - Externo....:  "
		SomaLinha()
		@li,075 PSay STR0055 + ALLTRIM(STR(nEmpresa))   //"Total de Atestados - Empresa....:  "
		SomaLinha()
		@li,075 PSay STR0056 + ALLTRIM(STR(nSUS))       //"Total de Atestados - SUS........:  "
		SomaLinha()
		@li,075 PSay STR0068 + ALLTRIM(STR(nParticular))//"Total de Atestados - Particular.:  "
		SomaLinha()
		@li,075 PSay STR0069 + ALLTRIM(STR(nConvenio))  //"Total de Atestados - Convênio...:  "
		SomaLinha()
		SomaLinha()
		@li,000 Psay Replicate("-",221)
		somalinha()
		@li,080 PSay STR0058 + ALLTRIM(STR(nTotalDias)) //"Total Geral................:  "
		If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
			@li,122 PSay ALLTRIM(STR(nTotalHoras))  //Total de horas
		Endif

	Else

		DbSelectArea("SRA")
		DbSetOrder(02) //RA_CC+RA_MAT
		dbSeek(xFilial("SRA"))
		SetRegua(LastRec())
		While 	SRA->RA_FILIAL == xFilial("SRA")		.AND.;
				!Eof()

			If SRA->RA_CC < Mv_par09 .OR. SRA->RA_CC > Mv_par10
		    	DbSkip()
			    Loop
			Endif

			cCliente := SubStr(SRA->RA_CC,1,nSizeTD)

			If cCliente < mv_par01+mv_par02 .or. cCliente > mv_par03+mv_par04
				dbSelectArea("SRA")
				dbSkip()
				Loop
			Endif

		    dbSelectArea("TM0")
			dbSetOrder(03) //TM0_FILFUN+TM0_MAT+TM0_NUMDEP
			dbSeek (SRA->RA_FILIAL + SRA->RA_MAT)
			While  TM0->TM0_FILFUN == SRA->RA_FILIAL  .AND.;
				   TM0->TM0_MAT    == SRA->RA_MAT     .AND.;
				   !Eof()
				IF TM0->TM0_NUMFIC < MV_PAR05 .OR. TM0->TM0_NUMFIC > MV_PAR06
		         	DBSkip()
		            Loop
		   		ENDIF
		   		lfirst := .T.
				dbselectArea("TNY")
				dbSetOrder(01)
				dbSeek(xFilial("TNY")+TM0->TM0_NUMFIC)
				Do While  TNY->TNY_FILIAL == xFilial('TNY')   .AND.;
						  TNY->TNY_NUMFIC == TM0->TM0_NUMFIC  .AND.;
						  !Eof()
		  			IF TNY->TNY_DTINIC < MV_PAR07 .OR. TNY->TNY_DTINIC > MV_PAR08
		   			  DBSKIP()
		   			  Loop
		   			ENDIF
		   			If TNY->TNY_EMITEN < MV_PAR11 .OR. TNY->TNY_EMITEN > MV_PAR12
				        dbSKIP()
		        		loop
				    Endif
				    If AliasIndic("TKI") .AND. mv_par10 == 1
				   		cNATEST := ""
				    	dbSelectArea("TKI")
				    	dbSetOrder(1)
				    	If dbSeek (xFilial("TKI") + TNY->TNY_NATEST)
				    		cNATEST := TNY->TNY_NATEST
				    	EndIf
				    EndIf
				    SomaLinha()
				    If cCCtemp <> SRA->RA_CC
						cCCtemp := SRA->RA_CC
			   			lMesmoCC := .F.
		  			Else
			  			lMesmoCC := .T.
		   			EndIf
				    IF lfirst
			    		If !lMesmoCC
			    			If !lFirst2
			    				SomaLinha()
								@li,71 PSay STR0008 + Space(4) + ALLTRIM(STR(nTotDcc))  //"Total Centro de Custo:"   <total dias>
								If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
									@li,109 PSay MtoH(nTotHcc) //Total de horas
								Endif
								nTotDcc := 0
								nTotHcc := 0
								SomaLinha()
								lFirst2 := .T.
			    			EndIf
				    		@li,000 Psay Replicate("-",221)
				    		SomaLinha()

				    		@li,08 PSay SRA->RA_CC
				    		SomaLinha(); SomaLinha()
				    	EndIf
			    		@li,000 PSay SUBSTR(TM0->TM0_NOMFIC,1,25)
			    		lfirst  := .F.
			    		lFirst2 := .F.
			    	ENDIF
		    		@li,032 PSay TM0->TM0_MAT
		    		@li,042 PSay TM0->TM0_NUMFIC
		    		@li,053 PSay TNY->TNY_DTINIC
		    		@li,064 PSay TNY->TNY_DTFIM
		    		lPrint := .t.
					DbSelectArea("TNP")
					DbSetOrder(1)
					IF DbSeek(XFilial("TNP")+TNY->TNY_EMITEN)
		    			@li,075 PSay SUBSTR(TNP->TNP_NOME,1,20)
		   			EndIf

		   			lDiaOK := .T.
		    		If DtoC(TNY->TNY_DTFIM) == Space(8) .OR. Empty(TNY->TNY_DTFIM)
		    			lDiaOk := .F.
		    		EndIf
					lHoraOK := .T.
					If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
						lHoraOK := .F.
					EndIf
		   			If lDiaOK
						@li,97 PSay Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1 picture "@E 9,999"
		   				nDias := Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
		   				nTotalDias += Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
						nTotDcc += Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
		   			Else
		   				@li,97 PSay ( 	Date() - TNY->TNY_DTINIC ) + 1 picture "@E 9,999"
		   				nDias := ( 	Date() - TNY->TNY_DTINIC ) + 1
		    	   		nTotalDias += ( Date() - TNY->TNY_DTINIC ) + 1
						nTotDcc += ( Date() - TNY->TNY_DTINIC ) + 1
		   			EndIf
		   			If !lHoraOk
		   				cHoraFim := SubStr( Time(),1,5)
		   			Else
		   				cHoraFim := TNY->TNY_HRFIM
		   			Endif

					If lHoraTotal
						If Alltrim(TNY->TNY_QTDHOR) == ":" .OR. Empty(TNY->TNY_QTDHOR)
				    		lQTDHOR := .F.
				    	Else
				    		lQTDHOR := .T.
				    	EndIf

						If lQTDHOR
							If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
						 		@li,109 PSay MtoH( Val(TNY->TNY_QTDHOR) * 60 )
							Endif
							nTotalHoras += Val(TNY->TNY_QTDHOR) * 60
					  		nTotHcc += Val(TNY->TNY_QTDHOR) * 60
						Else
							lHoraOK := .T.
							If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
								lHoraOK := .F.
							EndIf
							If lHoraOK .AND. lDiaOK
								nD_tmp := ( (TNY->TNY_DTFIM - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(TNY->TNY_HRFIM,1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2))) )
								If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
									@li,109 PSay MtoH( nD_tmp * 60)
								Endif
								nTotalHoras += nD_tmp * 60
					    		nTotHcc += nD_tmp * 60
							Else
	            				If !lDiaOK
		            				nD_tmp := ( (Date() - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(Time(),1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2))) )
			            			If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
										@li,109 PSay MtoH( nD_tmp * 60)
									Endif
									nTotalHoras += nD_tmp * 60
	            					nTotHcc += nD_tmp * 60
	            				Else
	            					If !lHoraOK
	            						@li,109 PSay MtoH( (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60 )
										nTotalHoras += (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60
					    				nTotHcc += (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60
	            					EndIf
	            				EndIf
							EndIf
						EndIf
		    		Else
		    			cTurnoTrab := SRA->RA_TNOTRAB
						cTurnSeq := SRA->RA_SEQTURN
						U_MDT700TURN() //Verifica o turno dentro do periodo do atestado.

						cPerdido := U_SomaHrSPJ( TNY->TNY_DTINIC, TNY->TNY_DTFIM, TNY->TNY_HRINIC, TNY->TNY_HRFIM , cTurnoTrab , cTurnSeq , SRA->RA_FILIAL)
		    		    @li,112 PSay Padl(cPerdido,9," ")
		    		    If !Empty(cPerdido)
			    		    nTotalHoras += HtoM( cPerdido )
			    		    nTotHcc += HtoM( cPerdido )
			   			Endif
		    		EndIf

					nLastCol := If(lPrintHr,125,110)
					@li,nLastCol PSay TNY->TNY_CID
					nLastCol += 10
					@li,nLastCol Psay SubStr(AllTrim(NGSEEK("TMR",TNY->TNY_CID,1,"TMR_DOENCA")),1,42)
					//CID Complementar
					If !Empty(TNY->TNY_CID) .AND. !Empty(cNATEST)
						fImpCIDCom(@nLastCol,cNATEST)
					EndIf
					dbSelectArea("TNY")
					DBSkip()

		   	EndDo
				dbSelectArea("TM0")
				DBSkip()
			EndDo
			dbSelectArea("SRA")
			DBSkip()
			IncRegua()
		EndDo

		Somalinha(); SomaLinha()
		@li,71 PSay STR0008 + Space(4) + ALLTRIM(STR(nTotDcc))	   //"Total Centro de Custo:"  <total dias>
		If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
		@li,109 PSay ALLTRIM(STR(nTotHcc))   //Total de horas
		Endif
		SomaLinha()

		@li,000 Psay Replicate("-",221)
		somalinha()
		@li,81 PSay STR0009 + Space(4) + ALLTRIM(STR(nTotalDias))	 //"Total Geral:"   <total dias>
		If lHoraTotal .And. lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
			@li,109 PSay ALLTRIM(STR(nTotalHoras))  //Total de horas
		EndIf

	Endif

Else

	If lIndMed

		nInterno    := 0
		nExterno    := 0
		nEmpresa    := 0
		nSUS        := 0
		nParticular := 0
		nConvenio   := 0

		DbSelectArea("SRA")
		DbSetOrder(02) //RA_CC+RA_MAT
		dbSeek(xFilial("SRA"))
		SetRegua(LastRec())
		While 	SRA->RA_FILIAL == xFilial("SRA") .And. !Eof()

			If SRA->RA_CC < Mv_par05 .OR. SRA->RA_CC > Mv_par06
		    	DbSkip()
			    Loop
			Endif

		   dbSelectArea("TM0")
			dbSetOrder(03) //TM0_FILFUN+TM0_MAT+TM0_NUMDEP
			dbSeek (SRA->RA_FILIAL + SRA->RA_MAT)
			While  TM0->TM0_FILFUN == SRA->RA_FILIAL  .AND.;
				   TM0->TM0_MAT    == SRA->RA_MAT     .AND.;
					  !Eof()
				IF TM0->TM0_NUMFIC < MV_PAR01 .OR. TM0->TM0_NUMFIC > MV_PAR02
		         	DBSkip()
		            Loop
		   		ENDIF
		   		lfirst := .T.
				dbselectArea("TNY")
				dbSetOrder(01)
				dbSeek(xFilial("TNY")+TM0->TM0_NUMFIC)
				While  TNY->TNY_FILIAL == xFilial('TNY')   .AND.;
					   TNY->TNY_NUMFIC == TM0->TM0_NUMFIC  .AND.;
						  !Eof()
					If !(	(TNY->TNY_DTINIC >= mv_par03 .And. TNY->TNY_DTINIC <= mv_par04) .Or.;
							(TNY->TNY_DTFIM >= mv_par03 .And. TNY->TNY_DTFIM <= mv_par04) .Or.;
							(TNY->TNY_DTINIC <= mv_par03 .And. TNY->TNY_DTFIM >= mv_par04)	)
		   			  DBSKIP()
		   			  Loop
		   			ENDIF
		   			If TNY->TNY_EMITEN < MV_PAR07 .OR. TNY->TNY_EMITEN > MV_PAR08
				        dbSKIP()
		        		loop
				    Endif
			    If mv_par10 == 1
			   		cNATEST := ""
				    	dbSelectArea("TKI")
				    	dbSetOrder(1)
				    	If dbSeek (xFilial("TKI") + TNY->TNY_NATEST)
				    		cNATEST := TNY->TNY_NATEST
				    	EndIf
				    EndIf

        		    nDias := 0
					cPerdido := ""
			        cHoraFim := ""
				    SomaLinha()
				    If cCCtemp <> SRA->RA_CC
						cCCtemp := SRA->RA_CC
			   			lMesmoCC := .F.
		  			Else
			  			lMesmoCC := .T.
		   			EndIf
				    IF lfirst
			    		If !lMesmoCC
			    			If !lFirst2
			    				SomaLinha()
								@li,075 PSay STR0057 + ALLTRIM(STR(nTotDcc))//"Total do Centro de Custo........:  "
								If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
									@li,125 PSay Padl(MtoH(nTotHcc),9," ")
								Endif
								SomaLinha()
								@li,075 PSay STR0096 + ALLTRIM(STR(nInterno))   //"Total de Atestados - Interno....:  "
								SomaLinha()
								@li,075 PSay STR0097 + ALLTRIM(STR(nExterno))   //"Total de Atestados - Externo....:  "
								SomaLinha()
								@li,075 PSay STR0055 + ALLTRIM(STR(nEmpresa))   //"Total de Atestados - Empresa....:  "
								SomaLinha()
								@li,075 PSay STR0056 + ALLTRIM(STR(nSUS))       //"Total de Atestados - SUS........:  "
								SomaLinha()
								@li,075 PSay STR0068 + ALLTRIM(STR(nParticular))//"Total de Atestados - Particular.:  "
								SomaLinha()
								@li,075 PSay STR0069 + ALLTRIM(STR(nConvenio))  //"Total de Atestados - Convênio...:  "
								nTotDcc := 0
								nTotHcc := 0
								nInterno    := 0
								nExterno    := 0
								nEmpresa    := 0
								nSUS        := 0
								nParticular := 0
								nConvenio   := 0
								SomaLinha()
								lFirst2 := .T.
					    		@li,000 Psay Replicate("-",221)
					    		SomaLinha()
			    			EndIf
				    		@li,08 PSay SRA->RA_CC
				    		SomaLinha(); SomaLinha()
				    	EndIf
			    		@li,000 PSay SUBSTR(TM0->TM0_NOMFIC,1,25)
			    		lfirst  := .F.
			    		lFirst2 := .F.
			    	ENDIF
		    		@li,032 PSay TM0->TM0_MAT
		    		@li,042 PSay TM0->TM0_NUMFIC
		    		@li,053 PSay TNY->TNY_DTINIC
		    		@li,064 PSay TNY->TNY_DTFIM
		    		lPrint := .t.
					DbSelectArea("TNP")
					DbSetOrder(1)
					IF DbSeek(XFilial("TNP")+TNY->TNY_EMITEN)
		    			@li,075 PSay SUBSTR(TNP->TNP_NOME,1,20)
		   			EndIf

		   			If TNY->TNY_INDMED == "1"
			   			nInterno++
			   			@li,097 PSay STR0098 //"Interno"
			   		ElseIf TNY->TNY_INDMED == "2"
			   			nExterno++
			   			@li,097 PSay STR0099 //"Externo"
		   			ElseIf TNY->TNY_INDMED == "3"
			   			nEmpresa++
			   			@li,097 PSay STR0073//"Empresa"
			   		ElseIf TNY->TNY_INDMED == "4"
			   			nSUS++
			   			@li,097 PSay STR0074//"SUS"
			   		ElseIf TNY->TNY_INDMED == "5"
			   			nParticular++
			   			@li,097 PSay STR0090//"Particular"
			   		ElseIf TNY->TNY_INDMED == "6"
			   			nConvenio++
			   			@li,097 PSay STR0091//"Convênio"
			   		Endif

		   			lDiaOK := .T.
			    		If DtoC(TNY->TNY_DTFIM) == Space(8) .OR. Empty(TNY->TNY_DTFIM)
			    			lDiaOk := .F.
			    		EndIf
						lHoraOK := .T.
						If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
							lHoraOK := .F.
						EndIf
		   			If lDiaOK
						@li,110 PSay Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1 picture "@E 9,999"
		   				nDias := Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
		   				nTotalDias += Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
					  		nTotDcc += Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
		   			Else
		   				@li,110 PSay (	Date() - TNY->TNY_DTINIC ) + 1 picture "@E 9,999"
		   				nDias := ( 	Date() - TNY->TNY_DTINIC ) + 1
		    	   		nTotalDias += ( Date() - TNY->TNY_DTINIC ) + 1
		   			EndIf
		   			If !lHoraOk
		   				cHoraFim := SubStr( Time(),1,5)
		   			Else
		   				cHoraFim := TNY->TNY_HRFIM
		   			Endif
		    		nLastCol := 123

					If lHoraTotal
						If Alltrim(TNY->TNY_QTDHOR) == ":" .OR. Empty(TNY->TNY_QTDHOR)
				    		lQTDHOR := .F.
				    	Else
				    		lQTDHOR := .T.
				    	EndIf

						If lQTDHOR
							If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
						 		@li,122 PSay MtoH( Val(TNY->TNY_QTDHOR) * 60 )
						 	Endif
							nTotalHoras += Val(TNY->TNY_QTDHOR) * 60
					  		nTotHcc += Val(TNY->TNY_QTDHOR) * 60
						Else
							lHoraOK := .T.
							If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
								lHoraOK := .F.
							EndIf
							If lHoraOK .AND. lDiaOK
								nD_tmp := ( (TNY->TNY_DTFIM - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(TNY->TNY_HRFIM,1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2))) )
								If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
									@li,122 PSay MtoH( nD_tmp * 60 )
								Endif
								nTotalHoras += nD_tmp * 60
					    		nTotHcc += nD_tmp * 60
							Else
		            			If !lDiaOK
			            			nD_tmp := ( (dDataBase - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(Time(),1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2))) )
			            			If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
										@li,122 PSay MtoH( nD_tmp * 60 )
									Endif
									nTotalHoras += nD_tmp * 60
		            				nTotHcc += nD_tmp * 60
		            			Else
		            				If !lHoraOK
		            					If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
			            					@li,122 PSay MtoH( (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60 )
			            				Endif
										nTotalHoras += (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60
					    				nTotHcc += (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60
		            				EndIf
		            			EndIf
							EndIf
						EndIf
					Else
						cTurnoTrab := SRA->RA_TNOTRAB
						cTurnSeq := SRA->RA_SEQTURN
						U_MDT700TURN() //Verifica o turno dentro do periodo do atestado.

						cPerdido := U_SomaHrSPJ( TNY->TNY_DTINIC, TNY->TNY_DTFIM, TNY->TNY_HRINIC, TNY->TNY_HRFIM , cTurnoTrab , cTurnSeq , SRA->RA_FILIAL)
						If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
							@li,125 PSay Padl(cPerdido,9," ")
						Endif
		    		    nTotalHoras += HtoM( cPerdido )
		    		    nTotHcc += HtoM( cPerdido )
					Endif

					nLastCol := If(lPrintHr,138,123)
		    		@li, nLastCol PSay TNY->TNY_CID
		    		nLastCol += 9
		    		@li, nLastCol Psay SubStr(AllTrim(NGSEEK("TMR",TNY->TNY_CID,1,"TMR_DOENCA")),1,42)
                    //CID Complementar
                    If !Empty(TNY->TNY_CID) .AND. !Empty(cNATEST)
                    	fImpCIDCom(@nLastCol,cNATEST)
                    EndIf
		    		dbSelectArea("TNY")
		          	DBSkip()
		   		End
				dbSelectArea("TM0")
				DBSkip()
			End
			dbSelectArea("SRA")
			DBSkip()
			IncRegua()
		End

		SomaLinha()
		SomaLinha()
		@li,075 PSay STR0057 + ALLTRIM(STR(nTotDcc))//"Total do Centro de Custo........:  "
		If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
			@li,125 PSay Padl(MtoH(nTotHcc),9," ")
		Endif
		SomaLinha()
		@li,075 PSay STR0096 + ALLTRIM(STR(nInterno))   //"Total de Atestados - Interno....:  "
		SomaLinha()
		@li,075 PSay STR0097 + ALLTRIM(STR(nExterno))   //"Total de Atestados - Externo....:  "
		SomaLinha()
		@li,075 PSay STR0055 + ALLTRIM(STR(nEmpresa))   //"Total de Atestados - Empresa....:  "
		SomaLinha()
		@li,075 PSay STR0056 + ALLTRIM(STR(nSUS))       //"Total de Atestados - SUS........:  "
		SomaLinha()
		@li,075 PSay STR0068 + ALLTRIM(STR(nParticular))//"Total de Atestados - Particular.:  "
		SomaLinha()
		@li,075 PSay STR0069 + ALLTRIM(STR(nConvenio))  //"Total de Atestados - Convênio...:  "
		SomaLinha()
		SomaLinha()
		@li,000 Psay Replicate("-",221)
		somalinha()
		@li,080 PSay STR0058 + ALLTRIM(STR(nTotalDias)) //"Total Geral................:  "
		If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
			@li,125 PSay Padl(MtoH(nTotalHoras),9," ")
		Endif

	Else

		DbSelectArea("SRA")
		DbSetOrder(02) //RA_CC+RA_MAT
		dbSeek(xFilial("SRA"))
		SetRegua(LastRec())
		While 	SRA->RA_FILIAL == xFilial("SRA")		.AND.;
				!Eof()
			If SRA->RA_CC < Mv_par05 .OR. SRA->RA_CC > Mv_par06
		    	DbSkip()
			    Loop
			Endif
		    dbSelectArea("TM0")
			dbSetOrder(03) //TM0_FILFUN+TM0_MAT+TM0_NUMDEP
			dbSeek (SRA->RA_FILIAL + SRA->RA_MAT)
			While  TM0->TM0_FILFUN == SRA->RA_FILIAL  .AND.;
				   TM0->TM0_MAT    == SRA->RA_MAT     .AND.;
				   !Eof()
				IF TM0->TM0_NUMFIC < MV_PAR01 .OR. TM0->TM0_NUMFIC > MV_PAR02
		         	DBSkip()
		            Loop
		   		ENDIF
		   		lfirst := .T.
				dbselectArea("TNY")
				dbSetOrder(01)
				dbSeek(xFilial("TNY")+TM0->TM0_NUMFIC)
				Do While  TNY->TNY_FILIAL == xFilial('TNY')   .AND.;
						TNY->TNY_NUMFIC == TM0->TM0_NUMFIC  .AND.;
						!Eof()
					If !(	(TNY->TNY_DTINIC >= mv_par03 .And. TNY->TNY_DTINIC <= mv_par04) .Or.;
							(TNY->TNY_DTFIM >= mv_par03 .And. TNY->TNY_DTFIM <= mv_par04) .Or.;
							(TNY->TNY_DTINIC <= mv_par03 .And. TNY->TNY_DTFIM >= mv_par04)	)
						DBSKIP()
						Loop
					ENDIF
					If TNY->TNY_EMITEN < MV_PAR07 .OR. TNY->TNY_EMITEN > MV_PAR08
						dbSKIP()
						loop
					Endif
					If AliasIndic("TKI") .AND. mv_par10 == 1
						cNATEST := ""
						dbSelectArea("TKI")
						dbSetOrder(1)
						If dbSeek (xFilial("TKI") + TNY->TNY_NATEST)
							cNATEST := TNY->TNY_NATEST
						EndIf
					EndIf

					nDias := 0
					cPerdido := ""
					cHoraFim := ""
					SomaLinha()

				    If cCCtemp <> SRA->RA_CC
						cCCtemp := SRA->RA_CC
			   			lMesmoCC := .F.
		  			Else
			  			lMesmoCC := .T.
		   			EndIf
				    IF lfirst
			    		If !lMesmoCC
			    			If !lFirst2
			    				SomaLinha()
								@li,71 PSay STR0008 + Space(4) + ALLTRIM(STR(nTotDcc))  //"Total Centro de Custo:"   <total dias>
								If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
									@li,112 PSay Padl(MtoH(nTotHcc),9," ")
								Endif
								nTotDcc := 0
								nTotHcc := 0
								SomaLinha()
								lFirst2 := .T.
			    			EndIf
				    		@li,000 Psay Replicate("-",221)
				    		SomaLinha()

				    		@li,08 PSay SRA->RA_CC
				    		SomaLinha(); SomaLinha()
				    	EndIf
			    		@li,000 PSay SUBSTR(TM0->TM0_NOMFIC,1,25)
			    		lfirst  := .F.
			    		lFirst2 := .F.
			    	ENDIF
		    		@li,032 PSay TM0->TM0_MAT
		    		@li,042 PSay TM0->TM0_NUMFIC
		    		@li,053 PSay TNY->TNY_DTINIC
		    		@li,064 PSay TNY->TNY_DTFIM
		    		lPrint := .t.
					DbSelectArea("TNP")
					DbSetOrder(1)
					IF DbSeek(XFilial("TNP")+TNY->TNY_EMITEN)
		    			@li,075 PSay SUBSTR(TNP->TNP_NOME,1,20)
		   			EndIf

					lDiaOK := .T.
		    		If DtoC(TNY->TNY_DTFIM) == Space(8) .OR. Empty(TNY->TNY_DTFIM)
		    			lDiaOk := .F.
		    		EndIf
					lHoraOK := .T.
					If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
						lHoraOK := .F.
					EndIf

	   			If lDiaOK
					@li,97 PSay Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1 Picture "@E 9,999"
	   				nDias := Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
	   				nTotalDias += Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
						nTotDcc += Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
	   			Else
	   				@li,97 PSay ( 	Date() - TNY->TNY_DTINIC ) + 1 Picture "@E 9,999"
	   				nDias := ( 	Date() - TNY->TNY_DTINIC ) + 1
	    	   		nTotalDias += ( Date() - TNY->TNY_DTINIC ) + 1
						nTotDcc += ( Date() - TNY->TNY_DTINIC ) + 1
	   			EndIf

	   			nLastCol := 110

	   			If !lHoraOk
	   				cHoraFim := SubStr( Time(),1,5)
	   			Else
	   				cHoraFim := TNY->TNY_HRFIM
	   			Endif

					If lHoraTotal
						If Alltrim(TNY->TNY_QTDHOR) == ":" .OR. Empty(TNY->TNY_QTDHOR)
				    		lQTDHOR := .F.
				    	Else
				    		lQTDHOR := .T.
				    	EndIf

						If lQTDHOR
							If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
						 		@li,109 PSay MtoH( Val(TNY->TNY_QTDHOR) * 60 )
						 	Endif
							nTotalHoras += Val(TNY->TNY_QTDHOR) * 60
					  		nTotHcc += Val(TNY->TNY_QTDHOR) * 60
						Else
							lHoraOK := .T.
							If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
								lHoraOK := .F.
							EndIf
							If lHoraOK .AND. lDiaOK
								nD_tmp := ( (TNY->TNY_DTFIM - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(TNY->TNY_HRFIM,1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2))) )
								If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
									@li,109 PSay MtoH( nD_tmp * 60 )
								Endif
								nTotalHoras += nD_tmp * 60
					    		nTotHcc += nD_tmp * 60
							Else
		            			If !lDiaOK
			            			nD_tmp := ( (Date() - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(Time(),1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2))) )
			            		If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
										@li,109 PSay MtoH( nD_tmp * 60 )
									Endif
									nTotalHoras += nD_tmp * 60
		            				nTotHcc += nD_tmp * 60
		            			Else
		            				If !lHoraOK
		            					If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
			            					@li,109 PSay MtoH( (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60 )
			            				Endif
										nTotalHoras += (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60
					    				nTotHcc += (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60
		            				EndIf
		            			EndIf
							EndIf
						EndIf
		    		Else
		    			cTurnoTrab := SRA->RA_TNOTRAB
						cTurnSeq := SRA->RA_SEQTURN
						U_MDT700TURN() //Verifica o turno dentro do periodo do atestado.

						cPerdido := U_SomaHrSPJ( TNY->TNY_DTINIC, TNY->TNY_DTFIM, TNY->TNY_HRINIC, TNY->TNY_HRFIM , cTurnoTrab , cTurnSeq , SRA->RA_FILIAL)
						If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
			    		    @li,112 PSay Padl(cPerdido,9," ")
			   		Endif
		    		    nTotalHoras += HtoM( cPerdido )
		    		    nTotHcc += HtoM( cPerdido )
		    		EndIf

		    		nLastCol := If(lPrintHr,125,110)
		    		@li,nLastCol PSay TNY->TNY_CID
		    		nLastCol += 10
		    		@li,nLastCol Psay SubStr(AllTrim(NGSEEK("TMR",TNY->TNY_CID,1,"TMR_DOENCA")),1,42)
		    		//CID Complementar
		    		If !Empty(TNY->TNY_CID) .AND. !Empty(cNATEST)
	    				fImpCIDCom(@nLastCol,cNATEST)
	    			Endif

		    		dbSelectArea("TNY")
		      	DBSkip()
				EndDo
				dbSelectArea("TM0")
				DBSkip()
			EndDo
			dbSelectArea("SRA")
			DBSkip()
			IncRegua()
		EndDo

		Somalinha(); SomaLinha()
		@li,71 PSay STR0008 + Space(4) + ALLTRIM(STR(nTotDcc))	   //"Total Centro de Custo:"  <total dias>
		If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
			@li,112 PSay Padl(MtoH(nTotHcc),9," ")
		Endif
		SomaLinha()

		@li,000 Psay Replicate("-",221)
		somalinha()
		@li,81 PSay STR0009 + Space(4) + ALLTRIM(STR(nTotalDias))	 //"Total Geral:"   <total dias>
		If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
			@li,112 PSay Padl(MtoH(nTotalHoras),9," ")
		Endif

	Endif

Endif

If !lPrint
	MsgInfo(STR0027)  //"Não há nada para imprimir no relatório."
	RetIndex("SRA")
	Set Filter To
	Return .F.
Endif

Roda(nCntImpr,cRodaTxt,Tamanho)

//---------------------------------------------------------------------
//  Devolve a condicao original do arquivo principal
//---------------------------------------------------------------------
RetIndex("SRA")

Set Filter To

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
//SET CENTURY ON
MS_FLUSH()

dbSelectArea("SRA")
dbSetOrder(01)

Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina

@author Rafael Diogo Richter
@since 05/06/03
@return
/*/
//---------------------------------------------------------------------
Static Function Somalinha()
    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
    EndIf
Return

//---------------------------------------------------------------------
/*/{Protheus.doc} R710ImpM
Chamada do Relat¢rio (separa por Medico)

@param lEnd - Cancela a impressão.
@param wnRel - Programa utilizado.
@param titulo - Titulo do relatório.
@param tamanho - Tamanho do Relatório.

@author Denis Hyroshi de Souza
@since 28/12/05
@return Nill
/*/
//---------------------------------------------------------------------
Static Function R710ImpM(lEnd,wnRel,titulo,tamanho)

//---------------------------------------------------------------------
//  Variaveis locais exclusivas desta funcao
//---------------------------------------------------------------------
LOCAL cRodaTxt := ""
LOCAL nCntImpr := 0, nInd
LOCAL cCCtemp	//var01
LOCAL lMesmoCC 	//var02
LOCAL lHoraOK	//var03
LOCAL lDiaOK	//var04
LOCAL nTotDcc := 0	  //var05
LOCAL nTotHcc := 0	  //var06
LOCAL lFirst  := .T.  //var07
LOCAL lFirst2 := .T.  //var08
LOCAL lQTDHOR         //var09
LOCAL nTotalDias  := 0   //var10
LOCAL nTotalHoras := 0   //var11

Local nLastCol := 0
Local lPrintHr := GetNewpar("MV_NG2HRAT", "1") == "1" // Verifica se serao impressas as Horas do Atestado
Local cNATEST
Local mv_CID //Parametro para impressao de cabecalho de CID Complementar

Private cTurnoTrab := ""
Private cTurnSeq := ""

If lSigaMdtPs
	mv_CID := mv_par14 == 1
Else
	mv_CID := mv_par10 == 1
EndIf

//---------------------------------------------------------------------
//                         Descricao das variaveis
//---------------------------------------------------------------------
/*
var01 - Centro de Custo do registro atualmente selecionado em "SRA"
var02 - Denota se o registro atualmente selecionado em "SRA" é do mesmo Centro de Custo do
        registro anterior
var03 - Denota se o campo TNY->TNY_HRFIM está preenchido
var04 - Denota se o campo TNY->TNY_DTFIM está preenchido
var05 - Total de dias de afastamento por Centro de Custo
var06 - Total de horas de afastamento por Centro de Custo
var07 - Serve para imprimir apenas uma vez o nome de um determinado funcionário,
   		caso ele tenha mais do que um período de afastamento.
var08 - Serve para indicar o momento exato de imprimir o total de dias e de horas
   		de afastamento por centro de custo.
var09 - Denota se o campo TNY->TNY_QTDHOR está preenchido
var10 - Total geral de dias de afastamento
var11 - Total geral de horas de afastamento
*/

//---------------------------------------------------------------------
// Contadores de linha e pagina
//---------------------------------------------------------------------
PRIVATE li := 80 ,m_pag := 1

//---------------------------------------------------------------------
// Verifica se deve comprimir ou nao
//---------------------------------------------------------------------
nTipo  := IIF(aReturn[4]==1,15,18)

//---------------------------------------------------------------------
// Monta os Cabecalhos
//---------------------------------------------------------------------
cabec1 := STR0059 //"        Medico"
If lIndMed
	// 1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7
	// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//"Nome                                      Matricula   Ficha Medica   Dt.Afast.  Dt. Fim    Ind. Medico        Total Dias  Total Horas    CID       Descricao"
	//"Nome                                      Matricula   Ficha Medica   Dt.Afast.  Dt. Fim    Ind. Medico        Total Dias  CID       Descricao"
	If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
		If mv_CID
			cabec2 := STR0060 //"Nome                                      Matricula   Ficha Medica   Dt.Afast.  Dt. Fim    Ind. Medico        Total Dias  Total Horas    CID       Descricao       CID Complementar"
		Else
			cabec2 := STR0088 //"Nome                                      Matricula   Ficha Medica   Dt.Afast.  Dt. Fim    Ind. Medico        Total Dias  Total Horas    CID       Descricao"
		EndIf
	Else
		If mv_CID
			cabec2 := STR0077 //"Nome                                      Matricula   Ficha Medica   Dt.Afast.  Dt. Fim    Ind. Medico        Total Dias  CID       Descricao       CID Complementar"
		Else
			cabec2 := STR0086 //"Nome                                      Matricula   Ficha Medica   Dt.Afast.  Dt. Fim    Ind. Medico        Total Dias  CID       Descricao"
		EndIf
	Endif
Else
	// 1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7
	// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//"Nome                                      Matricula   Ficha Medica   Dt.Afast.  Dt. Fim    Total Dias  Total Horas    CID       Descricao"
	//"Nome                                      Matricula   Ficha Medica   Dt.Afast.  Dt. Fim    Total Dias  CID       Descricao"
	If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
		If mv_CID
			cabec2 := STR0061 //"Nome                                      Matricula   Ficha Medica   Dt.Afast.  Dt. Fim    Total Dias  Total Horas    CID       Descricao        CID Complementar"
		Else
			cabec2 := STR0089 //"Nome                                      Matricula   Ficha Medica   Dt.Afast.  Dt. Fim    Total Dias  Total Horas    CID       Descricao"
		EndIf
	Else
		If mv_CID
			cabec2 := STR0078 //"Nome                                      Matricula   Ficha Medica   Dt.Afast.  Dt. Fim    Total Dias  CID       Descricao        CID Complementar"
		Else
			cabec2 := STR0087 //"Nome                                      Matricula   Ficha Medica   Dt.Afast.  Dt. Fim    Total Dias  CID       Descricao"
		EndIf
	Endif
Endif


/*
If lIndMed

	************************************************************************************************************************************
	*<empresa>                                                                                                        Folha..: xxxxx   *
	*SIGA /<nome .04                                                                                                  DT.Ref.: dd/mm/aa*
	*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
	************************************************************************************************************************************

	          1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	(Padrao)                                 Funcionarios por Centro de Custo e Funcao                                 (Padrao)
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			Centro de Custo
	Nome                                      Matricula   Ficha Medica   Dt.Afast.  Dt. Fim    Ind. Medico        Total Dias  Total Horas
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			XXXXXXXXX
	1234567890123456789012345678901234567890  XXXXXX      XXXXXXXXX      99/99/99   99/99/99   Interno            XXXX        XXXX

Else

	************************************************************************************************************************************
	*<empresa>                                                                                                        Folha..: xxxxx   *
	*SIGA /<nome .04                                                                                                  DT.Ref.: dd/mm/aa*
	*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
	************************************************************************************************************************************

	          1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	(Padrao)                                 Funcionarios por Centro de Custo e Funcao                                 (Padrao)
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			Centro de Custo
	Nome                                      Matricula   Ficha Medica   Dt.Afast.  Dt. Fim    Total Dias  Total Horas   Ind. Medico
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			XXXXXXXXX
	1234567890123456789012345678901234567890  XXXXXX      XXXXXXXXX      99/99/99   99/99/99   XXXX        XXXX          Interno

Endif
*/

If lSigaMdtps //Totaliza por Médico

	If lIndMed

		nInterno    := 0
		nExterno    := 0
		nEmpresa    := 0
		nSUS        := 0
		nParticular := 0
		nConvenio   := 0

		aDadosTNY := {}

		dbselectArea("TNY")
		SetRegua(LastRec())
		dbSetOrder(01)
		dbSeek(xFilial("TNY")+Mv_par05,.t.)
		While !Eof() .and. TNY->TNY_FILIAL == xFilial('TNY') .AND. TNY->TNY_NUMFIC <= Mv_par06

			IncRegua()

			If TNY->(TNY_CLIENT+TNY_LOJA) < mv_par01+mv_par02 .or. TNY->(TNY_CLIENT+TNY_LOJA) > mv_par03+mv_par04
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

			IF TNY->TNY_DTINIC < MV_PAR07 .OR. TNY->TNY_DTINIC > MV_PAR08
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

			If TNY->TNY_EMITEN < MV_PAR11 .OR. TNY->TNY_EMITEN > MV_PAR12
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

		    dbSelectArea("TM0")
			dbSetOrder(1)
			If !dbSeek(xFilial("TM0") + TNY->TNY_NUMFIC)
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

		    dbSelectArea("SRA")
			dbSetOrder(1)
			If !dbSeek(xFilial("SRA") + TM0->TM0_MAT)
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

			If SRA->RA_CC < Mv_par09 .OR. SRA->RA_CC > Mv_par10
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

			dbSelectArea("TNP")
			dbSetOrder(1)
			If !dbSeek(xFilial("TNP") + TNY->TNY_EMITEN)
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			EndIf

		If  mv_par14 == 1//CID Complementar - Sim
	   		cNATEST := ""
				dbSelectArea("TKI")
				dbSetOrder(1)
	            If dbSeek(xFilial("TKI")+TNY->TNY_NATEST)
	            	cNATEST := TNY->TNY_NATEST
	            EndIf
            EndIf

			nDiasAFA := 0
			cHoraAFA := ""
			cLocalAtes := TNY->TNY_INDMED
			nDias := 0
			cPerdido := ""
		    cHoraFim := ""

			lDiaOK := If(DtoC(TNY->TNY_DTFIM) == Space(8) .OR. Empty(TNY->TNY_DTFIM), .F. , .T. )
			lHoraOK := .T.
			If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
				lHoraOK := .F.
			EndIf

			If lDiaOk
				nDiasAFA := Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
				nDias := Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
			Else
				nDiasAFA := (Date() - TNY->TNY_DTINIC) + 1
				nDias := ( 	Date() - TNY->TNY_DTINIC ) + 1
			EndIf

			If !lHoraOk
	   		cHoraFim := SubStr( Time(),1,5)
	   	Else
	   		cHoraFim := TNY->TNY_HRFIM
	   	Endif

			If lHoraTotal
				lQTDHOR := If(Alltrim(TNY->TNY_QTDHOR) == ":" .OR. Empty(TNY->TNY_QTDHOR), .F. , .T. )
				If lQTDHOR
					cHoraAFA := MtoH( Val(TNY->TNY_QTDHOR) * 60 )
				Else
					lHoraOK := If(TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM), .F. , .T. )
					If lHoraOK .AND. lDiaOK
						cHoraAFA := MtoH( ((TNY->TNY_DTFIM - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(TNY->TNY_HRFIM,1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2)))) * 60 )
					Else
						If !lDiaOK
							cHoraAFA := MtoH( ((dDataBase - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(Time(),1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2))) ) * 60 )
						Else
							If !lHoraOK
								cHoraAFA := MtoH( (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60 )
		            		EndIf
		      			EndIf
					EndIf
				EndIf
			Else
				cTurnoTrab := SRA->RA_TNOTRAB
				cTurnSeq := SRA->RA_SEQTURN
				U_MDT700TURN() //Verifica o turno dentro do periodo do atestado.

				cHoraAFA := U_SomaHrSPJ( TNY->TNY_DTINIC, TNY->TNY_DTFIM, TNY->TNY_HRINIC, TNY->TNY_HRFIM , cTurnoTrab , cTurnSeq , SRA->RA_FILIAL)
			EndIf

			aADD(aDadosTNY,{TNY->TNY_EMITEN,SubStr(TNP->TNP_NOME,1,40),; 	// Medico, Nome Medico
								TM0->TM0_MAT,TM0->TM0_NUMFIC,;		// Matricula, Ficha Medica
								TNY->TNY_DTINIC,TNY->TNY_DTFIM,;	// Data Inicio, Data Fim
								TM0->TM0_NOMFIC,nDiasAFA,cHoraAFA,cLocalAtes,;
								TNY->TNY_CID,cNATEST})	// Nome Funcionario, Qtde Dias, Qtde Horas

			dbSelectArea("TNY")
			dBSkip()
		End

		ASORT(aDadosTNY,,,{|x,y| x[1]+x[7] < y[1]+y[7] })

		nTotHcc := 0
		nTotDcc := 0
		nTotHGe := 0
		nTotDGe := 0
		cMedInd := Space(12)
		nInterno    := 0
		nExterno    := 0
		nEmpresa    := 0
		nSUS        := 0
		nParticular := 0
		nConvenio   := 0

		For nInd := 1 To Len(aDadosTNY)
			If cMedInd <> aDadosTNY[nInd,1]
				If nInd <> 1
					//Imprime total do medico anterior
					SomaLinha()
					SomaLinha()
					@li,075 PSay STR0062 + ALLTRIM(STR(nTotDcc))//"Total por Medico................:  "
					If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
						@li,122 PSay MtoH(nTotHcc)  //Total de horas
					Endif
					SomaLinha()
					@li,075 PSay STR0096 + ALLTRIM(STR(nInterno))   //"Total de Atestados - Interno....:  "
					SomaLinha()
					@li,075 PSay STR0097 + ALLTRIM(STR(nExterno))   //"Total de Atestados - Externo....:  "
					SomaLinha()
					@li,075 PSay STR0055 + ALLTRIM(STR(nEmpresa))   //"Total de Atestados - Empresa....:  "
					SomaLinha()
					@li,075 PSay STR0056 + ALLTRIM(STR(nSUS))       //"Total de Atestados - SUS........:  "
					SomaLinha()
					@li,075 PSay STR0068 + ALLTRIM(STR(nParticular))//"Total de Atestados - Particular.:  "
					SomaLinha()
					@li,075 PSay STR0069 + ALLTRIM(STR(nConvenio))  //"Total de Atestados - Convênio...:  "
					SomaLinha()
					@li,000 Psay Replicate("-",221)
				Endif
				cMedInd := aDadosTNY[nInd,1]
				//Acumula no total geral
				nTotHGe += nTotHcc
				nTotDGe += nTotDcc
				//Zera total medico
				nTotHcc     := 0
				nTotDcc     := 0
				nInterno    := 0
				nExterno    := 0
				nEmpresa    := 0
				nSUS        := 0
				nParticular := 0
				nConvenio   := 0
				//Imprime cabeçalho do medico atual
				SomaLinha()
				@li,008 PSay aDadosTNY[nInd,2]
				SomaLinha()
			Endif

			SomaLinha()
			@li,000 PSay aDadosTNY[nInd,7]
			@li,042 PSay aDadosTNY[nInd,3]
		    @li,054 PSay aDadosTNY[nInd,4]
		    @li,069 PSay aDadosTNY[nInd,5]
		    @li,080 PSay aDadosTNY[nInd,6]

		    If aDadosTNY[nInd,10] == "1"
				nInterno++
				@li,91 PSay STR0098 //"Interno"
			ElseIf aDadosTNY[nInd,10] == "2"
				nExterno++
				@li,91 PSay STR0099 //"Externo"
			ElseIf aDadosTNY[nInd,10] == "3"
				nEmpresa++
				@li,91 PSay STR0073//"Empresa"
			ElseIf aDadosTNY[nInd,10] == "4"
				nSUS++
				@li,91 PSay STR0074//"SUS"
			ElseIf aDadosTNY[nInd,10] == "5"
				nParticular++
				@li,91 PSay STR0090//"Particular"
			ElseIf aDadosTNY[nInd,10] == "6"
				nConvenio++
				@li,91 PSay STR0091//"Convênio"
			Endif

			@li,110 PSay aDadosTNY[nInd,8]

			nLastCol := 122

			If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
				@li,123 PSay Padl(aDadosTNY[nInd,9],9," ")
				nLastCol := 137
			Endif
           //CID e Descricao
		   @li,nLastCol PSay aDadosTNY[nInd,11]
		   nLastCol += 10
		   @li,nLastCol Psay SubStr(AllTrim(NGSEEK("TMR",aDadosTNY[nInd,11],1,"TMR_DOENCA")),1,42)
		   //CID Complementar
		   If !Empty(aDadosTNY[nInd,11]) .AND. !Empty(aDadosTNY[nInd,12])
		   		fImpCIDCom(@nLastCol,aDadosTNY[nInd,12])
		   Endif

			nTotHcc += HtoM( aDadosTNY[nInd,9] )
			nTotDcc += aDadosTNY[nInd,8]

		Next nInd

		If Len(aDadosTNY) > 0
			//Imprime total do medico anterior
			SomaLinha()
			SomaLinha()

			@li,075 PSay STR0062 + ALLTRIM(STR(nTotDcc))//"Total por Medico................:  "
			If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
				@li,122 PSay MtoH(nTotHcc) //Total de horas
			Endif
			SomaLinha()
			@li,075 PSay STR0096 + ALLTRIM(STR(nInterno))   //"Total de Atestados - Interno....:  "
			SomaLinha()
			@li,075 PSay STR0097 + ALLTRIM(STR(nExterno))   //"Total de Atestados - Externo....:  "
			SomaLinha()
			@li,075 PSay STR0055 + ALLTRIM(STR(nEmpresa))   //"Total de Atestados - Empresa....:  "
			SomaLinha()
			@li,075 PSay STR0056 + ALLTRIM(STR(nSUS))       //"Total de Atestados - SUS........:  "
			SomaLinha()
			@li,075 PSay STR0068 + ALLTRIM(STR(nParticular))//"Total de Atestados - Particular.:  "
			SomaLinha()
			@li,075 PSay STR0069 + ALLTRIM(STR(nConvenio))  //"Total de Atestados - Convênio...:  "
			SomaLinha()
			SomaLinha()

			@li,000 Psay Replicate("-",221)
			nTotHGe += nTotHcc
			nTotDGe += nTotDcc

			//Imprime total Geral
			SomaLinha()
			@li,080 PSay STR0058 + ALLTRIM(STR(nTotDGe)) //"Total Geral................:  "
			If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
			@li,122 PSay MtoH(nTotHGe)
			Endif
		Endif

	Else

		aDadosTNY := {}

		dbselectArea("TNY")
		SetRegua(LastRec())
		dbSetOrder(01)
		dbSeek(xFilial("TNY")+Mv_par05,.t.)
		While !Eof() .and. TNY->TNY_FILIAL == xFilial('TNY') .AND. TNY->TNY_NUMFIC <= Mv_par06

			IncRegua()

			If TNY->TNY_CLIENT+TNY->TNY_LOJA < MV_PAR01+MV_PAR02 .OR. TNY->TNY_CLIENT+TNY->TNY_LOJA > MV_PAR03+MV_PAR04
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

			IF TNY->TNY_DTINIC < MV_PAR07 .OR. TNY->TNY_DTINIC > MV_PAR08
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

			If TNY->TNY_EMITEN < MV_PAR11 .OR. TNY->TNY_EMITEN > MV_PAR12
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

		    dbSelectArea("TM0")
			dbSetOrder(1)
			If !dbSeek(xFilial("TM0") + TNY->TNY_NUMFIC)
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

		    dbSelectArea("SRA")
			dbSetOrder(1)
			If !dbSeek(xFilial("SRA") + TM0->TM0_MAT)
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

			If SRA->RA_CC < Mv_par09 .OR. SRA->RA_CC > Mv_par10
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

			dbSelectArea("TNP")
			dbSetOrder(1)
			If !dbSeek(xFilial("TNP") + TNY->TNY_EMITEN)
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			EndIf
			If AliasIndic("TKI") .AND. mv_par14 == 1
		   		cNATEST := ""
				dbSelectArea("TKI")
				dbSetOrder(1)
				If dbSeek(xFilial("TKI") + TNY->TNY_NATEST)
					cNATEST := TNY->TNY_NATEST
				EndIf
			EndIf

			nDiasAFA := 0
			cHoraAFA := ""
			cLocalAtes := " "
			nDias := 0
			cPerdido := ""
		    cHoraFim := ""

			lDiaOK := If(DtoC(TNY->TNY_DTFIM) == Space(8) .OR. Empty(TNY->TNY_DTFIM), .F. , .T. )
			lHoraOK := .T.
			If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
				lHoraOK := .F.
			EndIf
			If lDiaOk
				nDiasAFA := Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
				nDias := Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
			Else
				nDiasAFA := (Date() - TNY->TNY_DTINIC) + 1
				nDias := ( 	Date() - TNY->TNY_DTINIC ) + 1
			EndIf

			If !lHoraOk
	   		cHoraFim := SubStr( Time(),1,5)
	   	Else
	   		cHoraFim := TNY->TNY_HRFIM
	   	Endif
			If lHoraTotal
				lQTDHOR := If(Alltrim(TNY->TNY_QTDHOR) == ":" .OR. Empty(TNY->TNY_QTDHOR), .F. , .T. )
				If lQTDHOR
					cHoraAFA := MtoH( Val(TNY->TNY_QTDHOR) * 60 )
				Else
					lHoraOK := If(TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM), .F. , .T. )
					If lHoraOK .AND. lDiaOK
						cHoraAFA := MtoH( ((TNY->TNY_DTFIM - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(TNY->TNY_HRFIM,1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2)))) * 60 )
					Else
						If !lDiaOK
							cHoraAFA := MtoH( ((Date() - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(Time(),1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2))) ) * 60 )
						Else
							If !lHoraOK
								cHoraAFA := MtoH( (TNY->TNY_DTFIM - TNY->TNY_DTINIC) * 24 * 60 )
		            		EndIf
		      			EndIf
					EndIf
				EndIf
			Else
				cTurnoTrab := SRA->RA_TNOTRAB
				cTurnSeq := SRA->RA_SEQTURN
				U_MDT700TURN() //Verifica o turno dentro do periodo do atestado.

				cHoraAFA := U_SomaHrSPJ( TNY->TNY_DTINIC, TNY->TNY_DTFIM, TNY->TNY_HRINIC, TNY->TNY_HRFIM , cTurnoTrab , cTurnSeq , SRA->RA_FILIAL)
			EndIf

			aADD(aDadosTNY,{TNY->TNY_EMITEN,SubStr(TNP->TNP_NOME,1,40),; 	// Medico, Nome Medico
								TM0->TM0_MAT,TM0->TM0_NUMFIC,;		// Matricula, Ficha Medica
								TNY->TNY_DTINIC,TNY->TNY_DTFIM,;	// Data Inicio, Data Fim
								TM0->TM0_NOMFIC,nDiasAFA,cHoraAFA,cLocalAtes,;
								TNY->TNY_CID,cNATEST})	// Nome Funcionario, Qtde Dias, Qtde Horas

			dbSelectArea("TNY")
			dBSkip()
		End

		ASORT(aDadosTNY,,,{|x,y| x[1]+x[7] < y[1]+y[7] })

		nTotHcc := 0
		nTotDcc := 0
		nTotHGe := 0
		nTotDGe := 0
		cMedInd := Space(12)
		nInterno    := 0
		nExterno    := 0
		nEmpresa    := 0
		nSUS        := 0
		nParticular := 0
		nConvenio   := 0

		For nInd := 1 To Len(aDadosTNY)
			If cMedInd <> aDadosTNY[nInd,1]
				If nInd <> 1
					//Imprime total do medico anterior
					SomaLinha()
					SomaLinha()
					@li,70 PSay STR0063 + ALLTRIM(STR(nTotDcc)) //"Total por Medico:    "
					If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
						@li,123 PSay MtoH(nTotHcc)
					Endif
					SomaLinha()
					@li,000 Psay Replicate("-",221)
				Endif
				cMedInd := aDadosTNY[nInd,1]
				//Acumula no total geral
				nTotHGe += nTotHcc
				nTotDGe += nTotDcc
				//Zera total medico
				nTotHcc := 0
				nTotDcc := 0

				//Imprime cabeçalho do medico atual
				SomaLinha()
				@li,008 PSay aDadosTNY[nInd,2]
				SomaLinha()
			Endif

			SomaLinha()
			@li,000 PSay aDadosTNY[nInd,7]
			@li,042 PSay aDadosTNY[nInd,3]
			@li,054 PSay aDadosTNY[nInd,4]
			@li,069 PSay aDadosTNY[nInd,5]
			@li,080 PSay aDadosTNY[nInd,6]
			@li,091 PSay aDadosTNY[nInd,8]

			nLastCol := 103

			If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
				@li,104 PSay Padl(aDadosTNY[nInd,9],9," ")
				nLastCol := 118
			Endif

		   @li,nLastCol PSay aDadosTNY[nInd,11]
		   nLastCol += 10
		   @li,nLastCol Psay SubStr(AllTrim(NGSEEK("TMR",aDadosTNY[nInd,11],1,"TMR_DOENCA")),1,42)
			If !Empty(aDadosTNY[nInd,11]) .And. !Empty(aDadosTNY[nInd,12])
				fImpCIDCom(@nLastCol,aDadosTNY[nInd,12])
			EndIf

			nTotHcc += HtoM(aDadosTNY[nInd,9])
			nTotDcc += aDadosTNY[nInd,8]

		Next nInd

		If Len(aDadosTNY) > 0
			//Imprime total do medico anterior
			SomaLinha()
			SomaLinha()
			@li,70 PSay STR0063 + ALLTRIM(STR(nTotDcc)) //"Total por Medico:    "
			If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
				@li,123 PSay MtoH(nTotHcc)
			Endif
			SomaLinha()

			@li,000 Psay Replicate("-",221)
			nTotHGe += nTotHcc
			nTotDGe += nTotDcc

			//Imprime total Geral
			SomaLinha()
			@li,75 PSay STR0064 + ALLTRIM(STR(nTotDGe)) //"Total Geral:    "
			If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
				@li,103 PSay MtoH(nTotHGe)
			Endif
		Endif

	Endif

Else

	If lIndMed

		nInterno    := 0
		nExterno    := 0
		nEmpresa    := 0
		nSUS        := 0
		nParticular := 0
		nConvenio   := 0

		aDadosTNY := {}

		dbselectArea("TNY")
		SetRegua(LastRec())
		dbSetOrder(01)
		dbSeek(xFilial("TNY")+Mv_par01,.t.)
		While !Eof() .and. TNY->TNY_FILIAL == xFilial('TNY') .AND. TNY->TNY_NUMFIC <= Mv_par02

			IncRegua()

			If !(	(TNY->TNY_DTINIC >= mv_par03 .And. TNY->TNY_DTINIC <= mv_par04) .Or.;
					(TNY->TNY_DTFIM >= mv_par03 .And. TNY->TNY_DTFIM <= mv_par04) .Or.;
					(TNY->TNY_DTINIC <= mv_par03 .And. TNY->TNY_DTFIM >= mv_par04)	)
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

			If TNY->TNY_EMITEN < MV_PAR07 .OR. TNY->TNY_EMITEN > MV_PAR08
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

		    dbSelectArea("TM0")
			dbSetOrder(1)
			If !dbSeek(xFilial("TM0") + TNY->TNY_NUMFIC)
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

		    dbSelectArea("SRA")
			dbSetOrder(1)
			If !dbSeek(xFilial("SRA") + TM0->TM0_MAT)
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

			If SRA->RA_CC < Mv_par05 .OR. SRA->RA_CC > Mv_par06
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

			dbSelectArea("TNP")
			dbSetOrder(1)
			If !dbSeek(xFilial("TNP") + TNY->TNY_EMITEN)
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			EndIf
		If  mv_par10 == 1
	   		cNATEST := ""
				dbSelectArea("TKI")
				dbSetOrder(1)
				If dbSeek(xFilial("TKI") + TNY->TNY_NATEST)
			  		cNATEST := TNY->TNY_NATEST
			  	EndIf
			EndIf

			nDiasAFA := 0
			cHoraAFA := ""
			cLocalAtes := TNY->TNY_INDMED
			nDias := 0
			cPerdido := ""
		    cHoraFim := ""

			lDiaOK := If(DtoC(TNY->TNY_DTFIM) == Space(8) .OR. Empty(TNY->TNY_DTFIM), .F. , .T. )

			lHoraOK := .T.
			If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
				lHoraOK := .F.
			EndIf

			If lDiaOk
				nDiasAFA := Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
				nDias := Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
			Else
				nDiasAFA := (Date() - TNY->TNY_DTINIC) + 1
				nDias := ( 	Date() - TNY->TNY_DTINIC ) + 1
			EndIf

			If !lHoraOk
	   		cHoraFim := SubStr( Time(),1,5)
	   	Else
	   		cHoraFim := TNY->TNY_HRFIM
	   	Endif

			If lHoraTotal
				lQTDHOR := If(Alltrim(TNY->TNY_QTDHOR) == ":" .OR. Empty(TNY->TNY_QTDHOR), .F. , .T. )
				If lQTDHOR
					cHoraAFA := MtoH( Val(TNY->TNY_QTDHOR) * 60 )
				Else
					lHoraOK := If(TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM), .F. , .T. )
					If lHoraOK .AND. lDiaOK
						cHoraAFA := MtoH( ((TNY->TNY_DTFIM - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(TNY->TNY_HRFIM,1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2)))) * 60 )
					Else
						If !lDiaOK
							cHoraAFA := MtoH( ((dDataBase - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(Time(),1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2))) ) * 60 )
						Else
							If !lHoraOK
								cHoraAFA := MtoH( (TNY->TNY_DTFIM - TNY->TNY_DTINIC)*24 * 60 )
		            		EndIf
		      			EndIf
					EndIf
				EndIf
			Else
				cTurnoTrab := SRA->RA_TNOTRAB
				cTurnSeq := SRA->RA_SEQTURN
				U_MDT700TURN() //Verifica o turno dentro do periodo do atestado.

				cHoraAFA := U_SomaHrSPJ( TNY->TNY_DTINIC, TNY->TNY_DTFIM, TNY->TNY_HRINIC, TNY->TNY_HRFIM , cTurnoTrab , cTurnSeq , SRA->RA_FILIAL)
			EndIf

			aADD(aDadosTNY,{TNY->TNY_EMITEN,SubStr(TNP->TNP_NOME,1,40),; 	// Medico, Nome Medico
								TM0->TM0_MAT,TM0->TM0_NUMFIC,;		// Matricula, Ficha Medica
								TNY->TNY_DTINIC,TNY->TNY_DTFIM,;	// Data Inicio, Data Fim
								TM0->TM0_NOMFIC,nDiasAFA,cHoraAFA,cLocalAtes,;
								TNY->TNY_CID,cNATEST})	// Nome Funcionario, Qtde Dias, Qtde Horas

			dbSelectArea("TNY")
			dBSkip()
		End

		ASORT(aDadosTNY,,,{|x,y| x[1]+x[7] < y[1]+y[7] })

		nTotHcc := 0
		nTotDcc := 0
		nTotHGe := 0
		nTotDGe := 0
		cMedInd := Space(12)
		nInterno    := 0
		nExterno    := 0
		nEmpresa    := 0
		nSUS        := 0
		nParticular := 0
		nConvenio   := 0

		For nInd := 1 To Len(aDadosTNY)
			If cMedInd <> aDadosTNY[nInd,1]
				If nInd <> 1
					//Imprime total do medico anterior
					SomaLinha()
					SomaLinha()
					@li,075 PSay STR0062 + ALLTRIM(STR(nTotDcc))//"Total por Medico................:  "
					If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
						@li,123 PSay Padl(MtoH(nTotHcc),9," ")
					Endif
					SomaLinha()
					@li,075 PSay STR0096 + ALLTRIM(STR(nInterno))   //"Total de Atestados - Interno....:  "
					SomaLinha()
					@li,075 PSay STR0097 + ALLTRIM(STR(nExterno))   //"Total de Atestados - Externo....:  "
					SomaLinha()
					@li,075 PSay STR0055 + ALLTRIM(STR(nEmpresa))   //"Total de Atestados - Empresa....:  "
					SomaLinha()
					@li,075 PSay STR0056 + ALLTRIM(STR(nSUS))       //"Total de Atestados - SUS........:  "
					SomaLinha()
					@li,075 PSay STR0068 + ALLTRIM(STR(nParticular))//"Total de Atestados - Particular.:  "
					SomaLinha()
					@li,075 PSay STR0069 + ALLTRIM(STR(nConvenio))  //"Total de Atestados - Convênio...:  "
					SomaLinha()
					@li,000 Psay Replicate("-",221)
				Endif
				cMedInd := aDadosTNY[nInd,1]
				//Acumula no total geral
				nTotHGe += nTotHcc
				nTotDGe += nTotDcc
				//Zera total medico
				nTotHcc     := 0
				nTotDcc     := 0
				nInterno    := 0
				nExterno    := 0
				nEmpresa    := 0
				nSUS        := 0
				nParticular := 0
				nConvenio   := 0
				//Imprime cabeçalho do medico atual
				SomaLinha()
				@li,008 PSay aDadosTNY[nInd,2]
				SomaLinha()
			Endif

			SomaLinha()
			@li,000 PSay aDadosTNY[nInd,7]
			@li,042 PSay aDadosTNY[nInd,3]
		    @li,054 PSay aDadosTNY[nInd,4]
		    @li,069 PSay aDadosTNY[nInd,5]
		    @li,080 PSay aDadosTNY[nInd,6]

		    If aDadosTNY[nInd,10] == "1"
				nInterno++
				@li,91 PSay STR0098 //"Interno"
			ElseIf aDadosTNY[nInd,10] == "2"
				nExterno++
				@li,91 PSay STR0099 //"Externo"
			ElseIf aDadosTNY[nInd,10] == "3"
				nEmpresa++
				@li,91 PSay STR0073//"Empresa"
			ElseIf aDadosTNY[nInd,10] == "4"
				nSUS++
				@li,91 PSay STR0074//"SUS"
			ElseIf aDadosTNY[nInd,10] == "5"
				nParticular++
				@li,91 PSay STR0090//"Particular"
			ElseIf aDadosTNY[nInd,10] == "6"
				nConvenio++
				@li,91 PSay STR0091//"Convênio"
			Endif

			@li,110 PSay aDadosTNY[nInd,8]

			nLastCol := 122

			If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
				@li,123 PSay Padl(aDadosTNY[nInd,9],9," ")
				nLastCol := 137
			Endif

		    @li,nLastCol PSay aDadosTNY[nInd,11]
		    nLastCol += 10
		    @li,nLastCol Psay SubStr(AllTrim(NGSEEK("TMR",aDadosTNY[nInd,11],1,"TMR_DOENCA")),1,42)
		    //CID Complementar
		   	If !Empty(aDadosTNY[nInd,11]) .And. !Empty(aDadosTNY[nInd,12])
		   		fImpCIDCom(@nLastCol,aDadosTNY[nInd,12])
		   	Endif

			nTotHcc += HtoM(aDadosTNY[nInd,9])
			nTotDcc += aDadosTNY[nInd,8]

		Next nInd

		If Len(aDadosTNY) > 0
			//Imprime total do medico anterior
			SomaLinha()
			SomaLinha()
			@li,075 PSay STR0062 + ALLTRIM(STR(nTotDcc))//"Total por Medico................:  "
			If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
				@li,123 PSay Padl(MtoH(nTotHcc),9," ")
			Endif
			SomaLinha()
			@li,075 PSay STR0096 + ALLTRIM(STR(nInterno))   //"Total de Atestados - Interno....:  "
			SomaLinha()
			@li,075 PSay STR0097 + ALLTRIM(STR(nExterno))   //"Total de Atestados - Externo....:  "
			SomaLinha()
			@li,075 PSay STR0055 + ALLTRIM(STR(nEmpresa))   //"Total de Atestados - Empresa....:  "
			SomaLinha()
			@li,075 PSay STR0056 + ALLTRIM(STR(nSUS))       //"Total de Atestados - SUS........:  "
			SomaLinha()
			@li,075 PSay STR0068 + ALLTRIM(STR(nParticular))//"Total de Atestados - Particular.:  "
			SomaLinha()
			@li,075 PSay STR0069 + ALLTRIM(STR(nConvenio))  //"Total de Atestados - Convênio...:  "
			SomaLinha()
			SomaLinha()
			@li,000 Psay Replicate("-",221)
			nTotHGe += nTotHcc
			nTotDGe += nTotDcc
			//Imprime total Geral
			SomaLinha()
			@li,080 PSay STR0058 + ALLTRIM(STR(nTotDGe)) //"Total Geral................:  "
			If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
				@li,123 PSay Padl(MtoH(nTotHGe),9," ")
			Endif
		Endif

	Else

		aDadosTNY := {}

		dbselectArea("TNY")
		SetRegua(LastRec())
		dbSetOrder(01)
		dbSeek(xFilial("TNY")+Mv_par01,.t.)
		While !Eof() .and. TNY->TNY_FILIAL == xFilial('TNY') .AND. TNY->TNY_NUMFIC <= Mv_par02

			IncRegua()

			If !(	(TNY->TNY_DTINIC >= mv_par03 .And. TNY->TNY_DTINIC <= mv_par04) .Or.;
					(TNY->TNY_DTFIM >= mv_par03 .And. TNY->TNY_DTFIM <= mv_par04) .Or.;
					(TNY->TNY_DTINIC <= mv_par03 .And. TNY->TNY_DTFIM >= mv_par04)	)
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

			If TNY->TNY_EMITEN < MV_PAR07 .OR. TNY->TNY_EMITEN > MV_PAR08
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

		    dbSelectArea("TM0")
			dbSetOrder(1)
			If !dbSeek(xFilial("TM0") + TNY->TNY_NUMFIC)
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

		    dbSelectArea("SRA")
			dbSetOrder(1)
			If !dbSeek(xFilial("SRA") + TM0->TM0_MAT)
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

			If SRA->RA_CC < Mv_par05 .OR. SRA->RA_CC > Mv_par06
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			Endif

			dbSelectArea("TNP")
			dbSetOrder(1)
			If !dbSeek(xFilial("TNP") + TNY->TNY_EMITEN)
				dbselectArea("TNY")
		    	dbSkip()
			    Loop
			EndIf
			If AliasIndic("TKI") .AND. mv_par10 == 1
		   		cNATEST := ""
				dbSelectArea("TKI")
				dbSetOrder(1)
				If dbSeek(xFilial("TKI") + TNY->TNY_NATEST)
			  		cNATEST := TNY->TNY_NATEST
			  	EndIf
			EndIf

			nDiasAFA := 0
			cHoraAFA := ""
			cLocalAtes := " "
			nDias := 0
			cPerdido := ""
		    cHoraFim := ""

			lDiaOK := If(DtoC(TNY->TNY_DTFIM) == Space(8) .OR. Empty(TNY->TNY_DTFIM), .F. , .T. )
			lHoraOK := .T.
			If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
				lHoraOK := .F.
			EndIf

			If lDiaOk
				nDiasAFA := Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
				nDias := Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
			Else
				nDiasAFA := (Date() - TNY->TNY_DTINIC) + 1
				nDias := ( 	Date() - TNY->TNY_DTINIC ) + 1
			EndIf

			If !lHoraOk
	   		cHoraFim := SubStr( Time(),1,5)
	   	Else
	   		cHoraFim := TNY->TNY_HRFIM
	   	Endif

			If lHoraTotal
				lQTDHOR := If(Alltrim(TNY->TNY_QTDHOR) == ":" .OR. Empty(TNY->TNY_QTDHOR), .F. , .T. )
				If lQTDHOR
					cHoraAFA := MtoH( Val(TNY->TNY_QTDHOR) * 60 )
				Else
					lHoraOK := If(TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM), .F. , .T. )
					If lHoraOK .AND. lDiaOK
						cHoraAFA := MtoH( ((TNY->TNY_DTFIM - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(TNY->TNY_HRFIM,1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2)))) * 60 )
					Else
						If !lDiaOK
							cHoraAFA := MtoH( ((Date() - TNY->TNY_DTINIC)*24 + (Val(SUBSTR(Time(),1,2)) - Val(SUBSTR(TNY->TNY_HRINIC,1,2))) ) * 60 )
						Else
							If !lHoraOK
								cHoraAFA := MtoH( (TNY->TNY_DTFIM - TNY->TNY_DTINIC)*24 * 60 )
		            		EndIf
		      			EndIf
					EndIf
				EndIf
			Else
				cTurnoTrab := SRA->RA_TNOTRAB
				cTurnSeq := SRA->RA_SEQTURN
				U_MDT700TURN() //Verifica o turno dentro do periodo do atestado.

				cHoraAFA := U_SomaHrSPJ( TNY->TNY_DTINIC, TNY->TNY_DTFIM, TNY->TNY_HRINIC, TNY->TNY_HRFIM , cTurnoTrab , cTurnSeq , SRA->RA_FILIAL)
			EndIf

			aADD(aDadosTNY,{TNY->TNY_EMITEN,SubStr(TNP->TNP_NOME,1,40),; 	// Medico, Nome Medico
								TM0->TM0_MAT,TM0->TM0_NUMFIC,;		// Matricula, Ficha Medica
								TNY->TNY_DTINIC,TNY->TNY_DTFIM,;	// Data Inicio, Data Fim
								TM0->TM0_NOMFIC,nDiasAFA,cHoraAFA,cLocalAtes,;
								TNY->TNY_CID,cNATEST})	// Nome Funcionario, Qtde Dias, Qtde Horas

			dbSelectArea("TNY")
			dBSkip()
		End

		ASORT(aDadosTNY,,,{|x,y| x[1]+x[7] < y[1]+y[7] })

		nTotHcc := 0
		nTotDcc := 0
		nTotHGe := 0
		nTotDGe := 0
		cMedInd := Space(12)
		nInterno    := 0
		nExterno    := 0
		nEmpresa    := 0
		nSUS        := 0
		nParticular := 0
		nConvenio   := 0

		For nInd := 1 To Len(aDadosTNY)
			If cMedInd <> aDadosTNY[nInd,1]
				If nInd <> 1
					//Imprime total do medico anterior
					SomaLinha()
					SomaLinha()
					@li,70 PSay STR0063 + ALLTRIM(STR(nTotDcc)) //"Total por Medico:    "
					If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
						@li,104 PSay Padl(MtoH(nTotHcc),9," ")
					Endif
					SomaLinha()
					@li,000 Psay Replicate("-",221)
				Endif
				cMedInd := aDadosTNY[nInd,1]
				//Acumula no total geral
				nTotHGe += nTotHcc
				nTotDGe += nTotDcc
				//Zera total medico
				nTotHcc := 0
				nTotDcc := 0

				//Imprime cabeçalho do medico atual
				SomaLinha()
				@li,008 PSay aDadosTNY[nInd,2]
				SomaLinha()
			Endif

			SomaLinha()
			@li,000 PSay aDadosTNY[nInd,7]
			@li,042 PSay aDadosTNY[nInd,3]
		    @li,054 PSay aDadosTNY[nInd,4]
		    @li,069 PSay aDadosTNY[nInd,5]
		    @li,080 PSay aDadosTNY[nInd,6]
			@li,091 PSay aDadosTNY[nInd,8]

			nLastCol := 103

			If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
				@li,104 PSay Padl(aDadosTNY[nInd,9],9," ")
				nLastCol := 118
			Endif

		   @li,nLastCol PSay aDadosTNY[nInd,11]
		   nLastCol += 10
		   @li,nLastCol Psay SubStr(AllTrim(NGSEEK("TMR",aDadosTNY[nInd,11],1,"TMR_DOENCA")),1,42)
		    //CID Complementar
		   	If !Empty(aDadosTNY[nInd,11]) .AND. !Empty(aDadosTNY[nInd,12])
		   		fImpCIDCom(@nLastCol,aDadosTNY[nInd,12])
		   	Endif
			nTotHcc += HtoM(aDadosTNY[nInd,9])
			nTotDcc += aDadosTNY[nInd,8]

		Next nInd

		If Len(aDadosTNY) > 0
			//Imprime total do medico anterior
			SomaLinha()
			SomaLinha()
			@li,70 PSay STR0063 + ALLTRIM(STR(nTotDcc)) //"Total por Medico:    "

			If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
				@li,104 PSay Padl(MtoH(nTotHcc),9," ")
			Endif
			SomaLinha()

			@li,000 Psay Replicate("-",221)
			nTotHGe += nTotHcc
			nTotDGe += nTotDcc

			//Imprime total Geral
			SomaLinha()
			@li,75 PSay STR0064 + ALLTRIM(STR(nTotDGe)) //"Total Geral:    "
			If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
				@li,104 PSay Padl(MtoH(nTotHGe),9," ")
			Endif
		Endif

	Endif

Endif

If Len(aDadosTNY) == 0
	MsgInfo(STR0027)  //"Não há nada para imprimir no relatório."
	RetIndex("SRA")
	Set Filter To
	Return .F.
Endif

Roda(nCntImpr,cRodaTxt,Tamanho)

//----------------------------------------------------------------
//  Devolve a condicao original do arquivo principal
//----------------------------------------------------------------
RetIndex("SRA")

Set Filter To

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

dbSelectArea("SRA")
dbSetOrder(01)

Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} MDT710SEC
Atualiza as configuracoes de secao de acordo com o parametro
Totalizar por

@author Andre E. Perez Alvarez
@since 20/06/08
@return .T.
/*/
//---------------------------------------------------------------------
User Function MDT710SEC()

Local lPrintHr := GetNewpar("MV_NG2HRAT", "1") == "1" // Verifica se serao impressas as Horas do Atestado

//--------------------------------------------------------------------------
// Criacao da secao utilizada pelo relatorio
//
// TRSection():New
// ExpO1 : Objeto TReport que a secao pertence
// ExpC2 : Descricao da seçao
// ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela
//         sera considerada como principal para a seção.
// ExpA4 : Array com as Ordens do relatório
// ExpL5 : Carrega campos do SX3 como celulas
//         Default : False
// ExpL6 : Carrega ordens do Sindex
//         Default : False
//
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
// Criacao da celulas da secao do relatorio
//
// TRCell():New
// ExpO1 : Objeto TSection que a secao pertence
// ExpC2 : Nome da celula do relatório. O SX3 será consultado
// ExpC3 : Nome da tabela de referencia da celula
// ExpC4 : Titulo da celula
//         Default : X3Titulo()
// ExpC5 : Picture
//         Default : X3_PICTURE
// ExpC6 : Tamanho
//         Default : X3_TAMANHO
// ExpL7 : Informe se o tamanho esta em pixel
//         Default : False
// ExpB8 : Bloco de código para impressao.
//         Default : ExpC2
//
//--------------------------------------------------------------------------
		oReport:SetTotalInLine(.F.)
	If lSigaMdtPs

		oSectionA := TRSection():New(oReport,STR0046,{"TRB","SA1"}) //"Cliente"
		TRCell():New(oSectionA,"TRB->CLIENT","TRB",STR0046,"@!",nTa1) //"Cliente"
		TRCell():New(oSectionA,"TRB->LOJA"  ,"TRB",STR0030	,"@!",nTa1L) //"Loja"
		TRCell():New(oSectionA,"A1_NOME"	,"SA1",STR0013   ,"@!",40) //"Nome"
		TRPosition():New(oSectionA,"SA1",1,{|| xFilial("SA1")+TRB->CLIENT+TRB->LOJA})

		//********************* Secao 0 - Centro de Custo
		oSection0 := TRSection():New (oReport,STR0020, {"TRB",cAliasCC} )//"Centro de Custo"
		oCell := TRCell():New(oSection0, "TRB->CODCC", "TRB" , STR0020, "@!", nSizeSI3, /*lPixel*/, /*{|| code-block de impressao }*/  ) //"Centro de Custo"
		oCell := TRCell():New(oSection0, cDescCC2    , cAliasCC , STR0021, "@!", 42, /*lPixel*/, /*{|| code-block de impressao }*/  ) //"Descricao"
		TRPosition():New (oSection0, cAliasCC, 1, {|| xFilial(cAliasCC) + TRB->CODCC} )

		//********************* Secao 5 - Medico
		oSection5 := TRSection():New (oReport,"Medico", {"TRB","TNP"} )
		oCell := TRCell():New(oSection5, "TRB->EMITEN", "TRB" , "Emitente", "@!", 18, /*lPixel*/, /*{|| code-block de impressao }*/  ) //"Centro de Custo"
		oCell := TRCell():New(oSection5, "TNP_NOME"   , "TNP" , STR0013, "@!", 30, /*lPixel*/, /*{|| code-block de impressao }*/  ) //"Descricao"      //"Nome"
		TRPosition():New (oSection5, "TNP", 1, {|| xFilial("TNP") + TRB->EMITEN} )
	Else
		nTamCC := If(nSizeSI3 < 17, 17, nSizeSI3)
		//********************* Secao 0 - Centro de Custo
		oSection0 := TRSection():New (oReport,STR0020, {"TRB",cAliasCC} )//"Centro de Custo"
		oCell := TRCell():New(oSection0, "TRB->CODCC", "TRB"    , STR0020, "@!", nTamCC, /*lPixel*/, /*{|| code-block de impressao }*/  ) //"Centro de Custo"
		oCell := TRCell():New(oSection0, cDescCC2    , cAliasCC , STR0021, "@!", 42, /*lPixel*/, /*{|| code-block de impressao }*/  ) //"Descricao"
		TRPosition():New (oSection0, cAliasCC, 1, {|| xFilial(cAliasCC) + TRB->CODCC} )

		//********************* Secao 5 - Medico
		oSection5 := TRSection():New (oReport,"Medico", {"TRB","TNP"} )
		oCell := TRCell():New(oSection5, "TRB->EMITEN", "TRB" , "Emitente", "@!", 15, /*lPixel*/, /*{|| code-block de impressao }*/  )
		oCell := TRCell():New(oSection5, "TNP_NOME"   , "TNP" , STR0013, "@!", 30, /*lPixel*/, /*{|| code-block de impressao }*/  ) //"Descricao"      //"Nome"
		TRPosition():New (oSection5, "TNP", 1, {|| xFilial("TNP") + TRB->EMITEN} )
	EndIf
	//********************* Secao 1 - Nome /Matricula / Ficha Medica ....
	oSection1 := TRSection():New (oReport,"Atestado", {"TRB","TNY","TM0","TNP"} )
	oCell := TRCell():New(oSection1, "TM0_NOMFIC"    , "TM0" , STR0013, "@!"        , 45, /*lPixel*/, /*{|| code-block de impressao }*/  ) //"Nome"
	oCell := TRCell():New(oSection1, "TM0_MAT"       , "TM0" , STR0014, "@!"       , 11, /*lPixel*/, /*{|| code-block de impressao }*/  ) //"Matricula"
	oCell := TRCell():New(oSection1, "TRB->NUMFIC"   , "TRB" , STR0015, "@!"       , 16, /*lPixel*/, /*{|| code-block de impressao }*/  ) //"Ficha Medica"
	oCell := TRCell():New(oSection1, "TRB->DTINIC"   , "TRB" , STR0016, "99/99/9999" , 17, /*lPixel*/, /*{|| code-block de impressao }*/  ) //"Dt.Afast.Ini."
	oCell := TRCell():New(oSection1, "TRB->DTFIM"    , "TRB" , STR0017, "99/99/9999" , 17, /*lPixel*/, /*{|| code-block de impressao }*/  ) //"Dt.Afast.Fim"
	oCell := TRCell():New(oSection1, "TNP_NOME"      , "TNP" , STR0018, "@!"       , 30, /*lPixel*/, /*{|| code-block de impressao }*/  ) //"Medico Emitente"
    oCell := TRCell():New(oSection1, cDescCC2        , cAliasCC , STR0020, "@!"       , 42, /*lPixel*/, /*{|| code-block de impressao }*/  ) //"Centro de Custo"
	oCell := TRCell():New(oSection1, "TRB->TOTDIA"   , "TRB" , STR0019, "999999999", 11, /*lPixel*/, /*{|| code-block de impressao }*/,,,"RIGHT"   ) //"Total de Dias"

	If lIndMed
		oCell := TRCell():New(oSection1,"","","","",04,/*lPixel*/,)
		oCell := TRCell():New(oSection1, "TRB->INDMED"   , "TRB" , STR0065, "@!", 22, /*lPixel*/, /*{|| code-block de impressao }*/  ) //"Ind. Medico" //"Ind. Medico"
		If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
			oCell := TRCell():New(oSection1, "TRB->TOTHOR"   , "TRB" , STR0022, "@!"        , 16, /*lPixel*/, /*{|| code-block de impressao }*/,"RIGHT" ) //"Total de Horas"
			oSection1:Cell("TRB->TOTHOR"):SetHeaderAlign("RIGHT")
		Endif
		oCell := TRCell():New(oSection1," ", "	" ,	,	,	04, /*lPixel*/, /*{|| code-block de impressao }*/ )
		oCell := TRCell():New(oSection1, "TRB->CID"      , "TRB" , STR0035, "@!"         , 08, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"CID"
		oCell := TRCell():New(oSection1, "TRB->DESCID"   , "TRB" , STR0036, "@!"         , 50, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"DESC. CID"

	  	oSection3 := TRSection():New(oReport,STR0081,{""}) //"CID Complementar"
	  	oCell3 := TRCell():New(oSection3,"TRB->CIDCOM", "TRB" , STR0081		, "@!" 			, 70 ,/*lPixel*/,/*{|| code-block de impressao }*/) //"CID Complementar"

		TRPosition():New (oSection1, "TNY", 1, {|| xFilial("TNY") + TRB->NUMFIC + DtoS(TRB->DTINIC) + TRB->HRINIC} )
		TRPosition():New (oSection1, "TM0", 1, {|| xFilial("TM0") + TRB->NUMFIC} )
		TRPosition():New (oSection1, "TNP", 1, {|| xFilial("TNP") + TRB->EMITEN} )
		TRPosition():New (oSection1, cAliasCC, 1, {|| xFilial(cAliasCC) + TRB->CODCC } )

		oSection4 := TRSection():New(oReport,STR0066,{"TRB"}) //"Resumo"
		oCell4 := TRCell():New(oSection4,"Inte","   ",STR0100 ,"999999999",21,/*lPixel*/,{|| nInterno })   //"Atestados Interno"
		oCell4 := TRCell():New(oSection4,"Exte","   ",STR0101 ,"999999999",21,/*lPixel*/,{|| nExterno })   //"Atestados Externo"
		oCell4 := TRCell():New(oSection4,"Empr","   ",STR0092 ,"999999999",21,/*lPixel*/,{|| nEmpresa })   //"Atestados Empresa"
		oCell4 := TRCell():New(oSection4,"SUS ","   ",STR0093 ,"999999999",21,/*lPixel*/,{|| nSUS })       //"Atestados SUS"
		oCell4 := TRCell():New(oSection4,"Part","   ",STR0094 ,"999999999",21,/*lPixel*/,{|| nParticular })//"Atestados Particular"
		oCell4 := TRCell():New(oSection4,"Conv","   ",STR0095 ,"999999999",21,/*lPixel*/,{|| nConvenio })  //"Atestados Convênio"
		oCell4 := TRCell():New(oSection4,"DIAS","   ",STR0019	,"999999999"	,15,/*lPixel*/,{|| nTotalRe }) //"Total de Dias"
		oCell4 := TRCell():New(oSection4,""		,"   ",""		,"     "		,06,/*lPixel*/,)
		If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
			oCell4 := TRCell():New(oSection4,"HORATOT","   ",STR0022		,"@!"	,14,/*lPixel*/,{|| MtoH(nTotalHH) },"RIGHT")  //"Total de Horas"
			oSection4:Cell("HORATOT"):SetHeaderAlign("RIGHT")
		Endif
		oSection4:Cell("Inte"):SetHeaderAlign("RIGHT")
		oSection4:Cell("Exte"):SetHeaderAlign("RIGHT")
		oSection4:Cell("Empr"):SetHeaderAlign("RIGHT")
		oSection4:Cell("SUS "):SetHeaderAlign("RIGHT")
		oSection4:Cell("Part"):SetHeaderAlign("RIGHT")
		oSection4:Cell("Conv"):SetHeaderAlign("RIGHT")
		oSection4:Cell("DIAS"):SetHeaderAlign("RIGHT")
	Else
		If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
			oCell := TRCell():New(oSection1, "TRB->TOTHOR"   , "TRB" , STR0022, "@!"        , 16, /*lPixel*/, /*{|| code-block de impressao }*/,"RIGHT" ) //"Total de Horas"
			oSection1:Cell("TRB->TOTHOR"):SetHeaderAlign("RIGHT")
		Endif
		oCell := TRCell():New(oSection1," ", "	" ,	,	,	04, /*lPixel*/, /*{|| code-block de impressao }*/ )
		oCell := TRCell():New(oSection1, "TRB->CID"      , "TRB" , STR0035, "@!"         , 08, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"CID"
		oCell := TRCell():New(oSection1, "TRB->DESCID"   , "TRB" , STR0036, "@!"         , 50, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"DESC. CID"

		oSection3 := TRSection():New(oReport,"",{""}) //"CID Complementar"
		oCell3 := TRCell():New(oSection3,"TRB->CIDCOM" , "TRB" , STR0081		, "@!" 			, 70 ,/*lPixel*/,/*{|| code-block de impressao }*/) //"CID Complementar"

		TRPosition():New (oSection1, "TNY", 1, {|| xFilial("TNY") + TRB->NUMFIC + DtoS(TRB->DTINIC) + TRB->HRINIC} )
		TRPosition():New (oSection1, "TM0", 1, {|| xFilial("TM0") + TRB->NUMFIC} )
		TRPosition():New (oSection1, "TNP", 1, {|| xFilial("TNP") + TRB->EMITEN} )

		oSection4 := TRSection():New(oReport,STR0066,{"TRB"}) //"Resumo"
		oCell4 := TRCell():New(oSection4,"    ","   ",STR0066	,"@!" 			,22,/*lPixel*/,/*{|| code-block de impressao }*/) //"Resumo"
		oCell4 := TRCell():New(oSection4,"DIAS","   ",STR0019	,"999999999"	,15,/*lPixel*/,{|| nTotalRe }) //"Total de Dias"
		If lPrintHr // Verifica se, conforme o parametro MV_NG2HRAT, serao impressas as Horas do Atestado
			oCell4 := TRCell():New(oSection4,"HORATOT","   ",STR0022,"@!"	,14,/*lPixel*/,{|| MtoH(nTotalHH) },"RIGHT")  //"Total de Horas"
			oSection4:Cell("HORATOT"):SetHeaderAlign("RIGHT")
		Endif
		oSection4:Cell("DIAS"):SetHeaderAlign("RIGHT")
	Endif

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} TRB2grava
Processa os atestados medicos de acordo com os parametros
e grava no arquivo temporario

@author Andre E. Perez Alvarez
@since 20/06/08
@return .T.
/*/
//---------------------------------------------------------------------
Static Function TRB2grava()

Private cTurnoTrab := ""
Private cTurnSeq := ""

aDBF := {}
AADD (aDBF, { "CLIENT"  , "C" ,nTa1, 0 } )
AADD (aDBF, { "LOJA"    , "C" ,nTa1L, 0 } )
AADD (aDBF, { "MAT"     , "C" ,06, 0 } )
AADD (aDBF, { "NUMFIC"  , "C" ,09, 0 } )
AADD (aDBF, { "NOMFIC"  , "C" ,40, 0 } )
AADD (aDBF, { "DTINIC"  , "D" ,08, 0 } )
AADD (aDBF, { "DTFIM"   , "D" ,08, 0 } )
AADD (aDBF, { "EMITEN"  , "C" ,12, 0 } )
AADD (aDBF, { "TOTDIA"  , "N" ,09, 0 } )
AADD (aDBF, { "HRINIC"  , "C" ,05, 0 } )
AADD (aDBF, { "HRFIM"   , "C" ,05, 0 } )
AADD (aDBF, { "QTDHOR"  , "C" ,09, 0 } )
If lIndMed
	AADD (aDBF, { "INDMED"  , "C" ,12, 0 } )
Endif
AADD (aDBF, { "CID"     , "C", 08, 0 } )
AADD (aDBF, { "DESCID"  , "C", 42, 0 } )

//Cria TRB
oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
oTempTRB:AddIndex( "1", {"CLIENT","LOJA","NOMFIC","DTINIC"} )
oTempTRB:Create()

DbSelectArea("TNY")
DbSetOrder(01)  //TNY_NUMFIC + DTOS(TNY_DTINIC) + TNY_HRINIC
DbSeek( xFilial("TNY") + mv_par05, .T. )
ProcRegua(LastRec())

While !Eof()							        .AND.;
	  xFilial("TNY") == TNY->TNY_FILIAL  .AND.;
	  TNY->TNY_NUMFIC <= mv_par06

	IncProc()

	If TNY->TNY_DTINIC < mv_par07 .or. TNY->TNY_DTINIC > mv_par08
		dbSelectArea("TNY")
		dbSkip()
		Loop
	Endif

	If TNY->(TNY_CLIENT+TNY_LOJA) < mv_par01+mv_par02 .or. TNY->(TNY_CLIENT+TNY_LOJA) > mv_par03+mv_par04
		dbSelectArea("TNY")
		dbSkip()
		Loop
	Endif

	If ( TNY->TNY_EMITEN < mv_par11 ) .OR. ( TNY->TNY_EMITEN > mv_par12 )
		dbSelectArea("TNY")
		dbSkip()
		loop
	Endif

	DbSelectArea("TM0")
	DbSetOrder(01)
	dbSeek( xFilial("TM0") + TNY->TNY_NUMFIC )

	DbSelectArea("SRA")
	DbSetOrder(01)
	If !DbSeek ( TM0->TM0_FILFUN + TM0->TM0_MAT ) .OR. Empty(TM0->TM0_MAT)
		dbSelectArea("TNY")
 		DbSkip()
		Loop
	EndIf

	If ( SRA->RA_CC < mv_par09 ) .OR. ( SRA->RA_CC > mv_par10 )
		dbSelectArea("TNY")
		DbSkip()
		Loop
	Endif

	DbSelectArea(cAliasCC)
 	DbSetOrder(01)
 	DbSeek ( xFilial(cAliasCC) + SRA->RA_CC )

	TRB->(DbAppend())
	TRB->MAT    := SRA->RA_MAT
	TRB->NUMFIC := TNY->TNY_NUMFIC
	TRB->NOMFIC := TM0->TM0_NOMFIC
	TRB->DTINIC := TNY->TNY_DTINIC
	TRB->DTFIM  := TNY->TNY_DTFIM
	TRB->EMITEN := TNY->TNY_EMITEN
	TRB->TOTDIA := Posic1()
	TRB->CLIENT := TM0->TM0_CLIENT
	TRB->LOJA   := TM0->TM0_LOJA
	TRB->HRINIC := TNY->TNY_HRINIC
	TRB->HRFIM  := TNY->TNY_HRFIM

	If lIndMed
		aBoxAux:= StrTokArr( NGRETSX3BOX( "TNY_INDMED" ) , ";" )
		nIndMed := Val(  TNY->TNY_INDMED )
		IF TNY->TNY_INDMED == "1"
			cInterno := aBoxAux[nIndMed]
			TRB->INDMED := cInterno
		ELSEIF TNY->TNY_INDMED == "2"
			cExterno := aBoxAux[nIndMed]
			TRB->INDMED := cExterno
		ELSEIF TNY->TNY_INDMED == "3"
			cEmpresa := aBoxAux[nIndMed]
			TRB->INDMED := cEmpresa
		ELSEIF TNY->TNY_INDMED == "4"
			cSUS := aBoxAux[nIndMed]
			TRB->INDMED := cSUS
		ELSEIF TNY->TNY_INDMED == "5"
			cParticular := aBoxAux[nIndMed]
			TRB->INDMED := cParticular
		ELSEIF TNY->TNY_INDMED == "6"
			cConvenio := aBoxAux[nIndMed]
			TRB->INDMED := cConvenio
		Endif
	Endif

	lDiaOK := .T.
	If DtoC(TNY->TNY_DTFIM) == Space(8) .OR. Empty(TNY->TNY_DTFIM)
		lDiaOk := .F.
	EndIf

	lHoraOK := .T.
	If TNY->TNY_HRFIM == Space(5) .OR. Empty(TNY->TNY_HRFIM)
		lHoraOK := .F.
	EndIf

	If lDiaOK
		nDias := Posic1()//(TNY->TNY_DTFIM - TNY->TNY_DTINIC) + 1
	Else
		nDias := ( 	Date() - TNY->TNY_DTINIC ) + 1
	EndIf

	If !lHoraOk
		cHoraFim := SubStr( Time(),1,5)
	Else
		cHoraFim := TNY->TNY_HRFIM
	Endif

	If lHoraTotal
		TRB->QTDHOR := MtoH( Posic2() * 60 )
	Else
		cTurnoTrab := SRA->RA_TNOTRAB
		cTurnSeq := SRA->RA_SEQTURN

		U_MDT700TURN() //Verifica o turno dentro do periodo do atestado.

		TRB->QTDHOR := U_SomaHrSPJ( TNY->TNY_DTINIC, TNY->TNY_DTFIM, TNY->TNY_HRINIC, TNY->TNY_HRFIM , cTurnoTrab , cTurnSeq , SRA->RA_FILIAL)
	Endif

	TRB->CID := TNY->TNY_CID
	TRB->DESCID := SubStr(AllTrim(NGSEEK("TMR",TNY->TNY_CID,1,"TMR_DOENCA")),1,42)

	DbSelectArea("TNY")
	DbSkip()
End

Return .T.
//---------------------------------------------------------------------
/*/{Protheus.doc} HORAPERD
Retorna a quantidade de horas perdida pelo atestado.

@param nTotalDias - Total de dias.
@param cHoraIni - Hora inicial.
@param cHoraFim - Fora final.

@author Roger Rodrigues
@since 18/05/09
@return cTotPerd
/*/
//---------------------------------------------------------------------
User Function HORAPERD(nTotalDias,cHoraIni,cHoraFim)
Local nHorasPerd := 0, nHoras := 0
Local nMinsPerd := 0, nMins := 0
Local cTotPerd  := "00:00"

If Empty(TNY->TNY_HRFIM) .and. !Empty(TNY->TNY_DTFIM)
	cHoraFim := "24:00"
Endif

nHorasPerd := (nTotalDias - 1) * 24
nHoras := Val(SubStr(cHoraFim,1,2)) - Val(Substr(cHoraIni,1,2))
nMins  := Val(SubStr(cHoraFim,4,5)) - Val(SubStr(cHoraIni,4,5))

While nMins < 0
	nMins := nMins + 60
	nHoras := nHoras - 1
End
While nMins > 59
	nHoras := nHoras + 1
	nMins := nMins - 60
End
If nHoras < 0 .or. nMins < 0
	nHoras := 0
	nMins := 0
Endif

nHorasPerd := nHorasPerd + (nHoras)
nMinsPerd := nMins
cTotPerd :=  Str(nHorasPerd) + ":" + StrZero(nMinsPerd,2)

Return AllTrim(cTotPerd)

//---------------------------------------------------------------------
/*/{Protheus.doc} SomaHrSPJ
Totaliza as horas do turno, conforme periodo informado.

@param dDtIniTNY - Data inicio.
@param dDtFimTNY - Data Fim.
@param cHrIniTNY - Hora Inicio.
@param cHrFimTNY - Hora Fim.
@param cTurnoFun - Turno de trabalho.
@param cTurnoSeq - Turno secundario
@param cFilTurno - Filtro do turno.

@author NG Informatica
@since 17/03/11
@return cTotalHr
/*/
//---------------------------------------------------------------------
User Function SomaHrSPJ( dDtIniTNY, dDtFimTNY, cHrIniTNY, cHrFimTNY , cTurnoFun , cTurnoSeq , cFilTurno)

	Local aTabTno   := {} //Horarios do turno

	Local bVld, nPos, nDow, lCont, l48h, nFor, xInd

	Local cTotalHr := "0:00"
	Local cTurSRA := cTurnoFun
	Local cTurSEQ := cTurnoSeq

	Local nDiff := If( Empty( dDtFimTNY ), dDataBase, dDtFimTNY ) - dDtIniTNY
	Local nHorIni := 0
	Local nMinIni := 0
	Local nNumIni := 0
	Local nHorFim := 0
	Local nMinFim := 0
	Local nNumFim := 0
	Local nNumMIN := 0
	Local nNumMAX := 0
	Local nTotalHr := 0
	Local nHor := 0
	Local nMin := 0

	Private aTab685 := {}

	Default cFilTurno := xFilial("SR6")

	If Empty(dDtFimTNY)
		dDtFimTNY := Date()
	Endif
	If Empty(cHrFimTNY) .or. Alltrim(cHrFimTNY) == ":"
		cHrFimTNY := SubStr(Time(),1,5)
	Endif

	dbSelectArea("SR6")
	dbSetOrder(1)
	If dbSeek(xFilial("SR6",cFilTurno)+cTurnoFun)
		If SuperGetMv("MV_TNOOPC",NIL,"N") == "S"
			If !Empty(SR6->R6_TNOOPC)
				cTurSRA := SR6->R6_TNOOPC
				cTurSEQ := ""
			Endif
		Endif
	Endif

	nPos := At(":",cHrIniTNY)
	nHorIni := Val(SubStr(cHrIniTNY,1,nPos-1))
	nMinIni := Val(SubStr(cHrIniTNY,nPos+1  ))
	nNumIni := Val(StrZero(nHorIni,2)+"."+StrZero(nMinIni,2))
	nPos := At(":",cHrFimTNY)
	nHorFim := Val(SubStr(cHrFimTNY,1,nPos-1))
	nMinFim := Val(SubStr(cHrFimTNY,nPos+1  ))
	nNumFim := Val(StrZero(nHorFim,2)+"."+StrZero(nMinFim,2))

	//Verifica se a sequencia do turno esta preenchida
	If !Empty(cTurSEQ)
		bVld := &("{|| PJ_SEMANA == '"+cTurSEQ+"' }")
	Else
		//Verifica o turno possui horario cadastrado
		dbSelectArea("SPJ")
		dbSetOrder(1)
		If dbSeek(xFilial("SPJ",cFilTurno)+cTurSRA)
			bVld := &("{|| PJ_SEMANA == '"+SPJ->PJ_SEMANA+"' }")
		Endif
	Endif

	//---------------------------------------------------------------
	// Indica se o turno possuir horario cadastrado
	//---------------------------------------------------------------
	If ValType(bVld) == "B" .And. nDiff >= 0 .And. !Empty(dDtIniTNY)

		//Busca horario do turno
		fTabPadrao( @aTabTno , xFilial("SR6",cFilTurno) , cTurSRA , , bVld )
		aTab685 := aClone(aTabTno)

		For xInd := 0 To nDiff
			//---------------------------------------------------------------
			// Verifica calendario na data inicio atestado
			//---------------------------------------------------------------
			dTemp := dDtIniTNY+xInd
			nDow  := Dow(dTemp)
			If Len(aTab685) > 0
				//---------------------------------------------------------------
				// Se a data analisa nao for a primeira nem a ultima, sera
				// acumulado a quantidade gravada no cadastro de turno.
				//---------------------------------------------------------------
				nTotalTmp := aTab685[1,3,nDow,9] + aTab685[1,3,nDow,10] + aTab685[1,3,nDow,11] + aTab685[1,3,nDow,12] + ;
							aTab685[1,3,nDow,13] + aTab685[1,3,nDow,14] + aTab685[1,3,nDow,15]

				nTotalHr := SomaHoras( nTotalHr, nTotalTmp )

				If (xInd <> 0 .or. nNumIni == 0) .And. (xInd <> nDiff .or. nNumFim == 23.59)
					Loop
				Endif
				If aTab685[1,3,nDow,9] == 0
					Loop
				Endif

				nDescIni := 0
				nDescFim := 0
				lContIni := .T.
				lContFim := .T.
				lCont := .F.
				//---------------------------------------------------------------
				// Analisa 1ª entrada e saida.
				//---------------------------------------------------------------
				nNumMIN := aTab685[1,3,nDow,1] //1º Entrada
				nNumMAX := aTab685[1,3,nDow,2] + aTab685[1,3,nDow,13] //1º Saida + Numero de Horas 1º Intervalo
				nNum2In := nNumIni
				nNum2Fi := nNumFim
				If aTab685[1,3,nDow,32] == "S" .or. aTab685[1,3,nDow,2] < aTab685[1,3,nDow,1]
					If nNum2In <= nNumMAX
						nNum2In += 24
						nNum2Fi += 24
					Endif
					nNumMAX += 24
					lCont := .T.
				Endif

				//---------------------------------------------------------------
				// Verifica se o inicio do afastamento cai dentro do intervalo
				//---------------------------------------------------------------
				If xInd == 0
					If nNum2In > nNumMIN .and. nNum2In <= nNumMAX
						nDescIni += __TIMESUM(nNum2In,-nNumMIN)
						lContIni := .F.
					ElseIf nNum2In > nNumMAX
						nDescIni += aTab685[1,3,nDow,9] + aTab685[1,3,nDow,13]
					Endif
				Else
					lContIni := .F.
				Endif
				If xInd == nDiff
					If nNum2Fi < nNumMAX .and. nNum2Fi >= nNumMIN
						nDescFim += __TIMESUM(nNumMAX,-nNum2Fi)
						//lContFim := .F.
					ElseIf nNum2Fi < nNumMAX .and. nNum2Fi < nNumMIN
						nDescFim += nTotalTmp
						lContFim := .F.
					Endif
				Else
					lContFim := .F.
				Endif

				If lContIni .or. lContFim
					l48h := .F.
					For nFor := 2 To 4
						If aTab685[1,3,nDow,nFor+8] == 0 //Se o intervalo nao possui horas
							Loop
						Endif
						If l48h //Se ultrapassou 48 horas
							Loop
						Endif

						nNumMIN := aTab685[1,3,nDow,(nFor*2)-1] //Xº Entrada
						nNumMAX := aTab685[1,3,nDow,(nFor*2)] + If( nFor < 4 , aTab685[1,3,nDow,nFor+12] , 0 ) //Xº Saida + Numero de Horas Xº Intervalo
						nNum2In := nNumIni
						nNum2Fi := nNumFim
						//---------------------------------------------------------------
						// Analisa 2ª a 4º entrada e saida.
						//---------------------------------------------------------------
						If lCont
							If nNumMIN >= aTab685[1,3,nDow,(nFor*2)-2] .and. aTab685[1,3,nDow,(nFor*2)] > nNumMIN
								If nNum2In <= nNumMAX
									nNum2In += 24
									nNum2Fi += 24
								Endif
								nNumMAX += 24
								nNumMIN += 24
							Else
								l48h := .T.
								Loop
							Endif
						Else
							If nNumMIN >= aTab685[1,3,nDow,(nFor*2)-2]
								If aTab685[1,3,nDow,nFor+31] == "S" .or. aTab685[1,3,nDow,(nFor*2)] < nNumMIN
									If nNum2In <= nNumMAX
										nNum2In += 24
										nNum2Fi += 24
									Endif
									nNumMAX := aTab685[1,3,nDow,(nFor*2)] + 24
									lCont := .T.
								Endif
							Else
								If aTab685[1,3,nDow,(nFor*2)] < nNumMIN
									nNumMAX := aTab685[1,3,nDow,(nFor*2)] + 24
									lCont := .T.
								Endif
							Endif
						Endif

						//---------------------------------------------------------------
						// Verifica se o inicio do afastamento cai dentro do intervalo
						//---------------------------------------------------------------
						If lContIni
							If nNum2In > nNumMIN .and. nNum2In <= nNumMAX
								nDescIni += __TIMESUM(nNum2In,-nNumMIN)
								lContIni := .F.
							ElseIf nNum2In > nNumMAX
								nDescIni += aTab685[1,3,nDow,nFor+8] + If( nFor < 4 , aTab685[1,3,nDow,nFor+12] , 0 )
							Endif
						Endif
						//---------------------------------------------------------------
						// Verifica se o fim do afastamento cai dentro do intervalo
						//---------------------------------------------------------------
						If xInd == nDiff
							If lContFim
								If nNum2Fi < nNumMAX .and. nNum2Fi >= nNumMIN
									nDescFim += __TIMESUM(nNumMAX,-nNum2Fi)
									lContFim := .F.
								ElseIf nNum2Fi < nNumMAX .and. nNum2Fi < nNumMIN
									nDescFim += aTab685[1,3,nDow,nFor+8] + If( nFor < 4 , aTab685[1,3,nDow,nFor+12] , 0 )
								Endif
							Else
								nDescFim += aTab685[1,3,nDow,nFor+8] + If( nFor < 4 , aTab685[1,3,nDow,nFor+12] , 0 )
							Endif
						Endif
					Next nFor
				Endif
				//---------------------------------------------------------------
				// Desconta as horas caso o inicio ou fim do afastamento não
				// corresponda ao inicio e fim da jornada de trabalho
				//---------------------------------------------------------------
				nTotalHr := __TIMESUM(nTotalHr,-nDescIni)
				nTotalHr := __TIMESUM(nTotalHr,-nDescFim)
			Endif
		Next xInd
		If nTotalHr > 0
			// Exibe as horas trabalhadas somadas como 60m = 1hr
			cTempHr := Alltrim( Str( nTotalHr, 10, 2 ) )
			nPos := At( ".", cTempHr )
			nHor := Val( SubStr( cTempHr, 1, nPos - 1 ) )
			nMin := Val( SubStr( cTempHr, nPos + 1 ) )
			If nMin > 59
				nHor += 1
				nMin -= 60
			EndIf
			nHor := cValToChar( nHor )
			nMin := cValToChar( nMin )
			nHor := IIf( Len( nHor ) == 1, '0' + nHor, nHor )
			nMin := IIf( Len( nMin ) == 1, '0' + nMin, nMin )
			cTotalHr := nHor + ':' + nMin
		Endif
	Else
		nDias := (dDtFimTNY - dDtIniTNY) + 1
		cTotalHr := U_HORAPERD(nDias,cHrIniTNY,cHrFimTNY)
	Endif

Return cTotalHr

//---------------------------------------------------------------------
/*/{Protheus.doc} fImpCIDCom
Imprime CID Complementar

@author Guiherme Benkendorf
@since 22/11/2012
@version MP11
@return .T.
/*/
//---------------------------------------------------------------------
Static Function fImpCIDCom(nLastCol,cNATEST)

	Local aArea := GetArea()
	Local cCIDC
	Local nCol
	Local nPos := 23
	nCol := nLastCol

	nLastCol += nPos

	dbSelectArea("TKI")
	dbSetOrder(1)
	dbSeek(xFilial("TKI")+cNATEST)

	While !EOF() .AND. xFilial('TKI')+cNATEST = TKI->TKI_FILIAL+TKI->TKI_NATEST
		cCIDC := Alltrim(TKI->TKI_CID)

		If EMPTY(cCIDC) // Se não houver CID Complementar, não exibe
			dbSkip()
			Loop
		EndIf

		//Concatenacao dos CID complementares
		aAreaTMP := GetArea()
		dbSkip()
		cCIDC += If(Eof() .OR. xFilial('TKI')+cNATEST <> TKI->TKI_FILIAL+TKI->TKI_NATEST .OR. Empty(TKI->TKI_CID),".",", ")
		RestArea(aAreaTMP)

		//imprime os valores do CID Complementar e incrementa espaco para o lado
		@Li, nLastCol+20 PSay cCIDC
		nLastCol += Len(cCIDC)
		// Se houver muitos registros, pula linha.
		If nLastCol + Len(cCIDC) >= 200
			nLastCol := nCol + nPos
			Somalinha()
		EndIF

		dbSkip()
		Loop
	End

	RestArea(aArea)

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} fCarrCIDC
Carrega CID Complementar para a tabela temporaria

@author Guiherme Benkendorf
@since 22/11/2012
@version MP11
@return .T.
/*/
//---------------------------------------------------------------------
Static Function fCarrCIDC(cNATEST)

		Local aArea := GetArea()
		Local aAreaTMP
		Local aDataCIDC :={}

		dbSelectArea("TKI")
		dbSetOrder(1)
		dbSeek(xFilial("TKI") + cNATEST)
		While !EOF() .AND. xFilial("TKI") + cNATEST = TKI->TKI_FILIAL + TKI->TKI_NATEST
			//Se vazio adiciona array com o CID
			If !Empty(TKI->TKI_CID)
				If Len(aDataCIDC) == 0
					aAdd(aDataCIDC, AllTrim(TKI->TKI_CID))
				Else //Incrementa novo CID na primeira linha
					aDataCIDC[1] += AllTrim(TKI->TKI_CID)
				Endif
				//Concatenacao dos CIDs Complementares
				aAreaTMP := GetArea()
					dbSkip()
					aDataCIDC[1] += If(Eof() .OR. xFilial("TKI")+cNATEST <> TKI->TKI_FILIAL+TKI->TKI_NATEST .OR. Empty(TKI->TKI_CID),".",", ")
				RestArea(aAreaTMP)
			EndIf
			dbSkip()
		END
		//Atribui a linha concatenada no campo da TRB
		If Len(aDataCIDC) > 0
			TRB->CIDCOM := aDataCIDC[1]
		EndIf
		RestArea(aArea)

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT700TURN
Verifica o Turno usado no momento do Atestado Médico

@type function

@source MDTR710.prx

@author Guilherme Freudenburg
@since 02/10/2016

@sample U_MDT700TURN()

@return Lógico, Retorna sempre verdadeiro
/*/
//---------------------------------------------------------------------
User Function MDT700TURN()

Local lTurnIni := .T.

dbSelectArea("SPF")
dbSetOrder(1) //PF_FILIAL+PF_MAT+DTOS(PF_DATA)
If dbSeek(xFilial("TNY")+Posicione("TM0",1,xFilial("TNY")+TNY->TNY_NUMFIC,"TM0_MAT"))
	While !Eof() .And. xFilial("TNY") == SPF->PF_FILIAL .And. Posicione("TM0",1,xFilial("TNY")+TNY->TNY_NUMFIC,"TM0_MAT") == SPF->PF_MAT
		If SPF->PF_DATA <= TNY->TNY_DTINIC .And. SPF->PF_DATA <= TNY->TNY_DTFIM  //Caso encontre um Turno abaixo da Data do Atestado
			cTurnoTrab := SPF->PF_TURNOPA
			cTurnSeq := SPF->PF_SEQUEPA
			lTurnIni := .F.
		ElseIf SPF->PF_DATA >= TNY->TNY_DTINIC .And. SPF->PF_DATA >= TNY->TNY_DTFIM .And. lTurnIni //Caso encontre algum turno posterior
			lTurnIni := .F.
			cTurnoTrab := SPF->PF_TURNODE
			cTurnSeq := SPF->PF_SEQUEDE
		EndIf
		SPF->(dbSkip())
	End
EndIf

Return .T.
