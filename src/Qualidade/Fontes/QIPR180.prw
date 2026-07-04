/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "QIPR180.CH" 
#Include "Protheus.ch"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QIPR180   ºAutor  ³Telso Carneiro      º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  "Follow-Up - Ordens de Producao"         				  º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function QIPR180()
Local oReport	

If  !TRepInUse()
	Return U_QIPR180R3()	// Executa versão anterior do fonte
Endif               

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("QPR180",.F.)
oReport := ReportDef()
oReport:PrintDialog()		

Return     

Static Function ReportDef()
Local wnrel	   	:= "QIPR180"
Local cDesc1   	:= OemToAnsi(STR0002) //"Este programa ira imprimir a Rela‡„o das Ordens de Produ‡„o."
Local cTitulo  	:= OemToAnsi(STR0001) //"Follow-Up - Ordens de Producao"
Local cPerg  	:= "QPR180"
Local oReport
Local oSection1		 
Local oBreak1        
Private cAliasQPK :="QPK"
	
DEFINE REPORT oReport NAME wnrel TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1)

DEFINE SECTION oSection1 OF oReport TITLE TITSX3("QPK_OP")[1] TABLES "QPK","SC2","QPR","QP6"
DEFINE CELL NAME "QPK_OP" 		OF oSection1 ALIAS "QPK" 
DEFINE CELL NAME "QPK_LOTE" 	OF oSection1 ALIAS "QPK" TITLE ""
DEFINE CELL NAME "QPK_NUMSER" 	OF oSection1 ALIAS "QPK" TITLE ""
DEFINE CELL NAME "QPK_PRODUT" 	OF oSection1 ALIAS "QPK" TITLE "PRODUTO / DESCRIÇÃO" SIZE 35 LINE BREAK 
DEFINE CELL NAME "C2_UM" 		OF oSection1 ALIAS "SC2"  
DEFINE CELL NAME "QPK_EMISSA" 	OF oSection1 ALIAS "QPK" 
DEFINE CELL NAME "C2_DATPRF" 	OF oSection1 ALIAS "SC2" 
DEFINE CELL NAME "C2_DATRF" 	OF oSection1 ALIAS "SC2"   
DEFINE CELL NAME "QPK_TAMLOT" 	OF oSection1 ALIAS "QPK"   Picture PesqPictQt("C2_QUANT",15)
DEFINE CELL NAME "cC2DATRF" 	OF oSection1 ALIAS NIL    TITLE STR0019 Picture PesqPictQt("C2_QUANT",15)//Saldo a Entregar
DEFINE CELL NAME "C2_STATUS" 	OF oSection1 ALIAS "SC2"

DEFINE SECTION oSection2 OF oSection1 TITLE TITSX3("C2_TPOP")[1] 
DEFINE CELL NAME "C2_TPOP" 		OF oSection2 ALIAS "SC2" 
DEFINE CELL NAME "QP6_CODREC" 	OF oSection2 ALIAS "QP6" TITLE STR0020 //Roteiro
DEFINE CELL NAME "cVERIFI" 	    OF oSection2 ALIAS ""    TITLE TITSX3("C2_VERIFI")[1] SIZE 15
DEFINE CELL NAME "QPK_LAUDO" 	OF oSection2 ALIAS "QPK"  SIZE 30

DEFINE SECTION oSection3 OF oSection1 TITLE TITSX3("QPR_OPERAC")[1] TABLES "QPM"
DEFINE CELL NAME "QPR_OPERAC"	OF oSection3 ALIAS "QPR"  SIZE 30
DEFINE CELL NAME "QPM_LAUDO" 	OF oSection3 ALIAS "QPM"  SIZE 30
oSection3:Cell("QPM_LAUDO"):SeTLineBREAK(.T.)
DEFINE CELL NAME "QPM_JUSTLA" 	OF oSection3 ALIAS "QPM"  SIZE 25
oSection3:Cell("QPM_JUSTLA"):SeTLineBREAK(.T.)
DEFINE CELL NAME "QPM_DTENLA" 	OF oSection3 ALIAS "QPM" 
DEFINE CELL NAME "QPM_HRENLA" 	OF oSection3 ALIAS "QPM" 
DEFINE CELL NAME "QPM_DTLAUD" 	OF oSection3 ALIAS "QPM" 
DEFINE CELL NAME "QPM_HRLAUD" 	OF oSection3 ALIAS "QPM" 
DEFINE CELL NAME "QPM_DTVAL" 	OF oSection3 ALIAS "QPM" 
DEFINE CELL NAME "QPM_TAMLOT" 	OF oSection3 ALIAS "QPM" 
DEFINE CELL NAME "QPM_QTREJ" 	OF oSection3 ALIAS "QPM"          
DEFINE CELL NAME "QPM_DTDILA" 	OF oSection3 ALIAS "QPM"          
DEFINE CELL NAME "QPM_HRDILA" 	OF oSection3 ALIAS "QPM"          

DEFINE SECTION oSection4 OF oSection1 TITLE TITSX3("QPR_LABOR")[1] TABLES "QPL"
DEFINE CELL NAME "QPR_LABOR" 	OF oSection4 ALIAS "QPR"  SIZE 40
DEFINE CELL NAME "QPL_LAUDO" 	OF oSection4 ALIAS "QPL"  SIZE 30
oSection4:Cell("QPL_LAUDO"):SeTLineBREAK(.T.)
DEFINE CELL NAME "QPL_JUSTLA" 	OF oSection4 ALIAS "QPL"  SIZE 25
oSection4:Cell("QPL_JUSTLA"):SeTLineBREAK(.T.)
DEFINE CELL NAME "QPL_DTENLA" 	OF oSection4 ALIAS "QPL" 
DEFINE CELL NAME "QPL_HRENLA" 	OF oSection4 ALIAS "QPL" 
DEFINE CELL NAME "QPL_DTLAUD" 	OF oSection4 ALIAS "QPL" 
DEFINE CELL NAME "QPL_HRLAUD" 	OF oSection4 ALIAS "QPL" 
DEFINE CELL NAME "QPL_DTVAL" 	OF oSection4 ALIAS "QPL" 
DEFINE CELL NAME "QPL_TAMLOT" 	OF oSection4 ALIAS "QPL" 
DEFINE CELL NAME "QPL_QTREJ" 	OF oSection4 ALIAS "QPL"          
DEFINE CELL NAME "QPL_DTDILA" 	OF oSection4 ALIAS "QPL"          
DEFINE CELL NAME "QPL_HRDILA" 	OF oSection4 ALIAS "QPL"          

oReport:SetLandscape(.T.)

Return(oReport)




Static Function PrintReport(oReport)
Local oQPK		:= oReport:Section(1)           
Local oQPK2		:= oReport:Section(1):Section(1)
Local oQPM		:= oReport:Section(1):Section(2)
Local oQPL		:= oReport:Section(1):Section(3)
Local cOrdProd  := ""
Local cOperac   := ""
Local cLabor    := ""
Local cEnsaio	:= ""
Local lPula     := .T.
Local nResApr   := 0
Local nResRep   := 0
Local cCarta    := ""
Local cCabEns   := ""
Local lImpCab	:= .T.
Local nTotRec	:= 0
Local cIndex     := CriaTrab("",.F.)

DbSelectArea("QPK")
DbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿              
//³ Inicializa variavel para controle do filtro                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

MakeSqlExpr(oReport:uParam)

If mv_par12 == 1 
	cStatus := 'S'
ElseIf mv_par12 == 2
	cStatus := 'U'
ElseIf mv_par12 == 3
	cStatus := 'S,U,D,N, '
EndIf	     
                                                
If mv_par13 == 1
	cTPOP := 'F'
ElseIf mv_par13 == 2
	cTPOP := 'P'
ElseIf mv_par13 == 3
	cTPOP := 'F,P'
EndIf	              

cAliasQPK := 'R180IMP'

BeginSql Alias cAliasQPK

SELECT COUNT(*) TOTAL FROM %Table:QPK% QPK , %Table:SC2%  SC2 
	WHERE QPK.QPK_FILIAL = %xFilial:QPK% AND 
		QPK.QPK_OP BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR04% AND 
		QPK.QPK_LOTE BETWEEN %exp:MV_PAR02% AND %exp:MV_PAR05% AND 
		QPK.QPK_NUMSER BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR06% AND
		QPK.QPK_PRODUT BETWEEN %exp:mv_par07% AND %exp:mv_par08% AND 
		QPK.QPK_EMISSA BETWEEN %exp:DtoS(mv_par09)% AND %exp:DtoS(mv_par10)% AND 
		Substring(QPK.QPK_OP,1,6) = SC2.C2_NUM AND 
		Substring(QPK.QPK_OP,7,2) = SC2.C2_ITEM AND 
		Substring(QPK.QPK_OP,9,3) = SC2.C2_SEQUEN AND 
		SC2.C2_STATUS IN (%exp:cStatus%) And 
		SC2.C2_TPOP IN (%exp:cTPOP%) And 
		SC2.%notDel% And 
		QPK.%notDel%
		
EndSql                

If (cAliasQPK)->(!Eof())
	nTotRec:= (cAliasQPK)->TOTAL
	dbCloseArea()
EndIf	
                           
    BEGIN REPORT QUERY oQPK
       
cAliasQPK:= GetNextAlias()
	                    
BeginSql Alias cAliasQPK	

SELECT QPK_FILIAL, QPK_OP, QPK_PRODUT, QPK_LOTE, QPK_NUMSER, 
	QPK_EMISSA, QPK_TAMLOT, QPK_LAUDO, QPK_REVI FROM %Table:QPK% QPK  
	WHERE QPK.QPK_FILIAL = %xFilial:QPK% AND 
		QPK.QPK_OP BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR04% AND 
		QPK.QPK_LOTE BETWEEN %exp:MV_PAR02% AND %exp:MV_PAR05% AND 
		QPK.QPK_NUMSER BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR06% AND 
		QPK.QPK_PRODUT BETWEEN %exp:mv_par07% AND %exp:mv_par08% AND
		QPK.QPK_EMISSA BETWEEN %exp:DtoS(mv_par09)% AND %exp:DtoS(mv_par10)% AND
		QPK.%notDel%
		ORDER BY %Order:QPK,1%
    EndSql
    
END REPORT QUERY oQPK

oReport:SetMeter(nTotRec)	// Total de Elementos da regua

While !EOF()

	If oReport:Cancel()
		Exit
	EndIf		
	
	//Posiciona OP Principal
	dbSelectArea("SC2")
	dbSetOrder(1)
	dbSeek(xFiliaL("SC2")+PadR((cAliasQPK)->QPK_OP,11)) 
	
	If mv_par11 == 1  // O.P.s EM ABERTO
		If aSC2Sld("SC2") <= 0 .Or. !Empty(SC2->C2_DATRF)
			(cAliasQPK)->(dbSkip())
			Loop
		Endif
	Elseif mv_par11 == 2 //O.P.S ENCERRADAS
		If aSC2Sld("SC2") > 0 .And. Empty(SC2->C2_DATRF)
			(cAliasQPK)->(dbSkip())
			Loop
		Endif
	Endif
	
	
	If !(SC2->C2_STATUS$cStatus)
		(cAliasQPK)->(dbSkip())
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Termina filtragem e grava variavel p/ totalizacao            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While (cAliasQPK)->(!Eof()) .And. xFilial("QPK") == (cAliasQPK)->QPK_FILIAL
	
		oReport:IncMeter()	

		If oReport:Cancel()
			Exit
		EndIf		

		//Reposiciona OP Principal						
		SC2->(dbSetOrder(1))
		SC2->(dbSeek(xFiliaL("SC2")+PadR((cAliasQPK)->QPK_OP,11)))
	
		//Posiciona Especificacao do Produto
		dbSelectArea("QP6")
		dbSetOrder(1)
		dbSeek(xFiliaL("QP6")+(cAliasQPK)->QPK_PRODUT+INVERTE((cAliasQPK)->QPK_REVI))	

		If mv_par11 == 1  // O.P.s EM ABERTO
			If aSC2Sld("SC2") <= 0 .Or. !Empty(SC2->C2_DATRF)
				(cAliasQPK)->(dbSkip())
				Loop
			Endif
		Elseif mv_par11 == 2 //O.P.S ENCERRADAS
				If aSC2Sld("SC2") > 0 .And. Empty(SC2->C2_DATRF)
				(cAliasQPK)->(dbSkip())
				Loop
			Endif
		Endif

		//-- Valida se a OP deve ser Impressa ou n„o
	
		SB1->(dbSetOrder(1))
		SB1->(dbSeek(xFilial("SB1")+(cAliasQPK)->QPK_PRODUTO))
		oQPK:Init()		
		oQPK:Cell("QPK_OP"):SetValue((cAliasQPK)->QPK_OP)
		oQPK:Cell("QPK_LOTE"):SetValue((cAliasQPK)->QPK_LOTE)
		oQPK:Cell("QPK_NUMSER"):SetValue((cAliasQPK)->QPK_NUMSER)
		oQPK:Cell("QPK_PRODUT"):SetValue((cAliasQPK)->QPK_PRODUT+' '+SB1->B1_DESC) 
		oQPK:Cell("C2_UM"):SetValue(Posicione("SAH",1,xFilial("SAH")+SC2->C2_UM,"AH_UMRES"))
		oQPK:Cell("QPK_EMISSA"):SetValue((cAliasQPK)->QPK_EMISSA)
		oQPK:Cell("C2_DATPRF"):SetValue(SC2->C2_DATPRF)  
		oQPK:Cell("C2_DATRF"):SetValue(SC2->C2_DATRF)
		oQPK:Cell("QPK_TAMLOT"):SetValue((cAliasQPK)->QPK_TAMLOT)
		oQPK:Cell("cC2DATRF"):SetValue(IIf(Empty(SC2->C2_DATRF),aSC2Sld("SC2"),0))
		oQPK:Cell("C2_STATUS"):SetValue(SC2->C2_STATUS)

		TRPosition():New(oQPK,"QPR",1,{|| xFilial("QPR")+(cAliasQPK)->QPK_OP+(cAliasQPK)->QPK_LOTE+(cAliasQPK)->QPK_NUMSER})
		TRPosition():New(oQPK,"QP6",1,{|| xFilial("QP6")+(cAliasQPK)->QPK_PRODUT+INVERTE((cAliasQPK)->QPK_REVI)})

		oQPK:PrintLine()
		oQPK:Finish()   
		
		oQPK2:Init()		
		oQPK2:Cell("C2_TPOP"):SetValue(SC2->C2_TPOP)
		oQPK2:Cell("QP6_CODREC"):SetValue(QP6->QP6_CODREC)
		If(SC2->C2_VERIFI == 1)
			oQPK2:Cell("cVERIFI"):SetValue(OemToAnsi(STR0008))// "Inpesciona"
		Else
			oQPK2:Cell("cVERIFI"):SetValue(OemToAnsi(STR0009))//Certifc
		Endif
		oQPK2:Cell("QPK_LAUDO"):SetValue(If(!Empty((cAliasQPK)->QPK_LAUDO),Posicione("QPD",1,xFilial("QPD")+(cAliasQPK)->QPK_LAUDO,"QPD_DESCPO"),OemToAnsi(STR0018))) // "Sem Laudo"
        oQPK2:PrintLine()
        oQPK2:Finish()
        
		//Seleciona as medicoes da entrega
		cOrdProd := (cAliasQPK)->QPK_OP
		cReviQPK  := If(Empty((cAliasQPK)->QPK_REVI),QA_UltRevEsp((cAliasQPK)->QPK_PRODUT,,,,"QIP"),(cAliasQPK)->QPK_REVI)  
		
		QPR->(DbSetOrder(9))
		If QPR->(DbSeek(xFilial("QPR")+(cAliasQPK)->QPK_OP+(cAliasQPK)->QPK_LOTE+(cAliasQPK)->QPK_NUMSER))
			cOperac:= " "
			cLabor := " "
			cEnsaio:= " "

			While QPR->(!Eof()) .And. xFilial("QPR") == QPR->QPR_FILIAL .And. ;
				QPR->QPR_OP+QPR->QPR_LOTE+QPR->QPR_NUMSER == (cAliasQPK)->QPK_OP+(cAliasQPK)->QPK_LOTE+(cAliasQPK)->QPK_NUMSER

				lPula:= .T.
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Laudo da Operacao                                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If cOperac <> QPR->QPR_OPERAC
					cOperac := QPR->QPR_OPERAC
					cLabor  := ""
					lImpCab := .T.
					oQPM:Init()
					oQPM:Cell("QPR_OPERAC"):SetValue(QPR->QPR_OPERAC+" - "+RetDesOper(cOrdProd,QPR->QPR_OPERAC,QPR->QPR_PRODUT,QPR->QPR_REVI))
					QPM->(DbSetOrder(3))
					If QPM->(DbSeek(xFilial("QPM")+QPR->QPR_OP+QPR->QPR_LOTE+QPR->QPR_NUMSER+QP6->QP6_CODREC+QPR->QPR_OPERAC))

					If !Empty(AllTrim(oQPM:GetSQLExp("QPM")))
						If !QPM->(&(oQPM:GetSQLExp("QPM")))
							QPM->(DbSkip())
							loop
						Endif
	              Endif
					
						oQPM:Cell("QPM_LAUDO"):SetValue(Posicione("QPD",1,xFilial("QPD")+QPM->QPM_LAUDO,"QPD_DESCPO"))
						oQPM:Cell("QPM_JUSTLA"):SetValue(QPM->QPM_JUSTLA)
						oQPM:Cell("QPM_DTENLA"):SetValue(QPM->QPM_DTENLA)
						oQPM:Cell("QPM_HRENLA"):SetValue(QPM->QPM_HRENLA)
						oQPM:Cell("QPM_DTLAUD"):SetValue(QPM->QPM_DTLAUD)
						oQPM:Cell("QPM_HRLAUD"):SetValue(QPM->QPM_HRLAUD)
						oQPM:Cell("QPM_DTVAL"):SetValue(QPM->QPM_DTVAL)
						oQPM:Cell("QPM_TAMLOT"):SetValue(QPM->QPM_TAMLOT)
						oQPM:Cell("QPM_QTREJ"):SetValue(If(Empty(QPM->QPM_QTREJ),"0",QPM->QPM_QTREJ))
						oQPM:Cell("QPM_DTDILA"):SetValue(QPM->QPM_DTDILA)
						oQPM:Cell("QPM_HRDILA"):SetValue(QPM->QPM_HRDILA)
						If Empty(QPM->QPM_JUSTLA)
							oQPM:Cell("QPM_JUSTLA"):Disable()
						Else
							oQPM:Cell("QPM_JUSTLA"):Enable()
						Endif
						If Empty(QPM->QPM_DTDILA)
							oQPM:Cell("QPM_DTDILA"):Disable()
							oQPM:Cell("QPM_HRDILA"):Disable()
						Else
							oQPM:Cell("QPM_DTDILA"):Enable()
							oQPM:Cell("QPM_HRDILA"):Enable()
						Endif
						oQPM:PrintLine()
					EndIf
					oQPM:Finish()
				EndIf

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Laudo do Laborat¢rio                             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If cLabor <> QPR->QPR_LABOR
					cLabor   := QPR->QPR_LABOR
					cDescLab := Tabela("Q2",QPR->QPR_LABOR)
					cEnsaio  := " "
					lImpCab  := .T.
					oQPL:Init()
					oQPL:Cell("QPR_LABOR"):SetValue(QPR->QPR_LABOR + " - " + cDescLab)	//"Laboratorio : " 
					QPL->(DbSetOrder(3))
					If QPL->(dbSeek(xFilial("QPL")+QPR->QPR_OP+QPR->QPR_LOTE+QPR->QPR_NUMSER+QP6->QP6_CODREC+QPR->QPR_OPERAC+QPR->QPR_LABOR))

					If !Empty(AllTrim(oQPL:GetSQLExp("QPL")))
						If !QPL->(&(oQPL:GetSQLExp("QPL")))
							QPL->(DbSkip())
							loop
						Endif
	              Endif
					
						oQPL:Cell("QPL_LAUDO"):SetValue(Posicione("QPD",1,xFilial("QPD")+QPL->QPL_LAUDO,"QPD_DESCPO"))
						oQPL:Cell("QPL_JUSTLA"):SetValue(QPL->QPL_JUSTLA)
						oQPL:Cell("QPL_DTENLA"):SetValue(QPL->QPL_DTENLA)
						oQPL:Cell("QPL_HRENLA"):SetValue(QPL->QPL_HRENLA)
						oQPL:Cell("QPL_DTLAUD"):SetValue(DtoC(QPL->QPL_DTLAUD))
						oQPL:Cell("QPL_HRLAUD"):SetValue(QPL->QPL_HRLAUD)
						oQPL:Cell("QPL_DTVAL"):SetValue(QPL->QPL_DTVAL)
						oQPL:Cell("QPL_TAMLOT"):SetValue(QPL->QPL_TAMLOT)
						oQPL:Cell("QPL_QTREJ"):SetValue(If(Empty(QPL->QPL_QTREJ),"0",QPL->QPL_QTREJ))
						oQPL:Cell("QPL_DTDILA"):SetValue(QPL->QPL_DTDILA)
						oQPL:Cell("QPL_HRDILA"):SetValue(QPL->QPL_HRDILA)
						If Empty(QPL->QPL_JUSTLA)
							oQPL:Cell("QPL_JUSTLA"):Disable()
						Else
							oQPL:Cell("QPL_JUSTLA"):Enable()
						Endif
						If Empty(QPL->QPL_DTDILA)
							oQPL:Cell("QPL_DTDILA"):Disable()
							oQPL:Cell("QPL_HRDILA"):Disable()
						Else
							oQPL:Cell("QPL_DTDILA"):Enable()
							oQPL:Cell("QPL_HRDILA"):Enable()
						Endif
						oQPL:PrintLine()
					EndIf	   
					oQPL:Finish()		
				EndIf
                 
				If QP1->(dbSeek(xFilial("QP1")+QPR->QPR_ENSAIO))  // Ensaios

					If cEnsaio <> QPR->QPR_ENSAIO
						cEnsaio := QPR->QPR_ENSAIO

						If lImpCab	
							//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
							//          1         2         3         4         5         6         7         8         9        10         11       12        13        14        15        16        17        18        19        20        21        22
							//ENSAIO                                              CARTA TOT MED. APROVADOS. REPROVADOS PLANO DE AMOSTRAGEM
							//12345678 - 1234567890123456789012345678901234567890 123   12345678 12345678   12345678   123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
							cCabEns:= OemToAnsi(STR0007) // "ENSAIO                                              CARTA TOT MED. APROVADOS. REPROVADOS PLANO DE AMOSTRAGEM"
							oReport:SkipLine()							
							oRePort:ThinLine()
							oReport:PrintText(cCabEns,oReport:Row(),oReport:Col())							
							oReport:SkipLine()							
							oRePort:ThinLine()
                        	lImpCab:= .F.
                        EndIf
						
						oReport:PrintText((QPR->QPR_ENSAIO + " - " +QP1->QP1_DESCPO)+"  "+QP1->QP1_CARTA,oReport:Row(),oReport:Col())					
								
					   	nResApr := 0
						nResRep := 0
						QPR->(dbSetOrder(9))
						If QPR->(DbSeek(xFilial("QPR")+(cAliasQPK)->QPK_OP+(cAliasQPK)->QPK_LOTE+(cAliasQPK)->QPK_NUMSER+QP6->QP6_CODREC+cOperac+cLabor+cEnsaio))
							While QPR->(!Eof()) .And. xFilial("QPR") == QPR->QPR_FILIAL .And. ;
								QPR->QPR_OP == (cAliasQPK)->QPK_OP .And. QPR->QPR_LOTE == (cAliasQPK)->QPK_LOTE .And. ;
								QPR->QPR_NUMSER == (cAliasQPK)->QPK_NUMSER .And. QPR->QPR_OPERAC == cOperac .And. ;
								QPR->QPR_LABOR == cLabor .And. QPR->QPR_ENSAIO == cEnsaio

								If QPR->QPR_RESULT == "A"
									nResApr++
								Else
									nResRep++
								EndIf
								lPula:= .F.
								QPR->(dbSkip())
							EndDo
						EndIf
						oReport:PrintText(AllTrim(Str(nResApr+nResRep)),oReport:Row(),870) // "Total de Medicoes: "
						oReport:PrintText(AllTrim(Str(nResApr)),oReport:Row(), 1020) 		// "Medicoes Aprovadas: "
						oReport:PrintText(AllTrim(Str(nResRep)),oReport:Row(), 1170)  		// "Medicoes Reprovadas: "
                        
						cCarta := QPCarta(QP1->QP1_ENSAIO)
						If cCarta <> "TXT"
							QP7->(dbSetOrder(1))
							If QP7->(dbSeek(xFilial("QP7")+(cAliasQPK)->(QPK_PRODUT)+cReviQPK+QP6->QP6_CODREC+cOperac+cEnsaio))
								If !Empty(QP7->QP7_PLAMO)
									If QP7->QP7_PLAMO == "I"
										oReport:PrintText(QP7->QP7_DESPLA,oReport:Row(),1270)
									ElseIf QP7->QP7_PLAMO == "N"
										If !Empty(Substr(QP7->QP7_DESPLA,1,3))
											oReport:PrintText(Substr(QP7->QP7_DESPLA,1,3)+": "+AllTrim(Substr(QP7->QP7_DESPLA,4,16)),oReport:Row(),1270)
										EndIf							
										If !Empty(Substr(QP7->QP7_DESPLA,20,13))
											oReport:PrintText(Substr(QP7->QP7_DESPLA,20,13)+": "+AllTrim(Substr(QP7->QP7_DESPLA,33,3)),oReport:Row(),1700)
										EndIf
										If !Empty(Substr(QP7->QP7_DESPLA,36,10))
											oReport:PrintText(Substr(QP7->QP7_DESPLA,36,10)+": "+AllTrim(substr(QP7->QP7_DESPLA,49,2)),oReport:Row(),2200)
										EndIf
									ElseIf QP7->QP7_PLAMO == "T"
										oReport:PrintText(OemToAnsi(STR0017)+" "+QP7->QP7_DESPLA,oReport:Row(),1270)	//"Texto"
									ElseIf QP7->QP7_PLAMO == "Z"
										oReport:PrintText(OemToAnsi(STR0006)+" "+QP7->QP7_DESPLA,oReport:Row(),1270)	//"Zero Defeito"
									EndIf
								EndIf
							EndIf
						Else
							QP8->(dbSetOrder(1))
							If QP8->(dbSeek(xFilial("QP8")+(cAliasQPK)->(QPK_PRODUT)+cReviQPK+QP6->QP6_CODREC+cOperac+cEnsaio))
								If !Empty(QP8->QP8_PLAMO)
									If QP8->QP8_PLAMO == "I"
										oReport:PrintText(QP8->QP8_DESPLA,oReport:Row(),1270)
									ElseIf QP8->QP8_PLAMO == "N"
										If !Empty(Substr(QP8->QP8_DESPLA,1,3))
											oReport:PrintText(Substr(QP8->QP8_DESPLA,1,3)+": "+AllTrim(Substr(QP8->QP8_DESPLA,4,16)),oReport:Row(),1270)
										EndIf							
										If !Empty(Substr(QP8->QP8_DESPLA,20,13))
											oReport:PrintText(Substr(QP8->QP8_DESPLA,20,13)+": "+AllTrim(Substr(QP8->QP8_DESPLA,33,3)),oReport:Row(),1700)
										EndIf
										If !Empty(Substr(QP8->QP8_DESPLA,36,10))
											oReport:PrintText(Substr(QP8->QP8_DESPLA,36,10)+": "+AllTrim(substr(QP8->QP8_DESPLA,49,2)),oReport:Row(),2200)
										EndIf
									ElseIf QP8->QP8_PLAMO == "T"
										oReport:PrintText(OemToAnsi(STR0017)+" "+QP8->QP8_DESPLA,oReport:Row(),1270)	//"Texto"
									ElseIf QP8->QP8_PLAMO == "Z"
										oReport:PrintText(OemToAnsi(STR0006)+" "+QP8->QP8_DESPLA,oReport:Row(),1270)	//"Zero Defeito"
									EndIf
								EndIf
							EndIf
						EndIf
                        oReport:SkipLine()
					EndIf
				EndIf				

				If lPula
					QPR->(dbSkip())
				EndIf
			EndDo			
		EndIf

		(cAliasQPK)->(dbSkip())
	EndDo
EndDo

dbSelectArea("QPK")
Set Filter To
dbSetOrder(1)

If File(cIndex+OrdBagExt())
	Ferase(cIndex+OrdBagExt())
Endif
 
Return(NIL)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QIPR180  ³ Autor ³ Eduardo de Souza      ³ Data ³ 31/03/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Follow-Up de Ordens de Producao                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QIPR180(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Inspecao de Processos                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function QIPR180R3()

Local Titulo 	:= OemToAnsi(STR0001) //"Follow-Up - Ordens de Producao"
Local cString	:= "QPK"
Local wnrel		:= "QIPR180"
Local cDesc		:= OemToAnsi(STR0002) //"Este programa ira imprimir a Rela‡„o das Ordens de Produ‡„o."
Local Tamanho	:= "G"

Private aReturn := {OemToAnsi(STR0004),1,OemToAnsi(STR0005), 1, 2, 1, "",1 }	//"Zebrado"###"Administracao"
Private cPerg   := "QPR180"
Private nLastKey:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01        	// Da OP                                 ³
//³ mv_par02        	// Do Lote                               ³
//³ mv_par03        	// Do Nume Serie                         ³
//³ mv_par04        	// Ate a OP                              ³
//³ mv_par05        	// Ate Lote                              ³
//³ mv_par06        	// Ate Num Serie                         ³
//³ mv_par07        	// Do Produto                            ³
//³ mv_par08        	// Ate o Produto                         ³
//³ mv_par09        	// Da data                               ³
//³ mv_par10        	// Ate a data                            ³
//³ mv_par11        	// 1-EM ABERTO 2-ENCERRADAS  3-TODAS     ³
//³ mv_par12        	// 1-SACRAMENTADAS 2-SUSPENSA 3-TODAS    ³
//³ mv_par13           // Impr. OP's Firmes, Previstas ou Ambas ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("QPR180",.F.)

wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc,"","",.F.,,,Tamanho)

If nLastKey == 27
   Set Filter To
   Return
Endif

SetDefault(aReturn,cString)
             
If nLastKey == 27
   Set Filter To
   Return
Endif

RptStatus({|lEnd| QPR180Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return NIL

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³QPR180Imp ³ Autor ³ Eduardo de Souza      ³ Data ³ 31/03/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIPR180			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QPR180Imp(lEnd,wnRel,titulo,tamanho)

Local CbTxt      := Space(10)
Local CbCont     := 0
Local cCabec1    := ""
Local cCabec2    := ""
Local nomeprog   := "QIPR180"
Local nTipo      := If(aReturn[4] == 1,15,18)
Local cStatus    := ""
Local cQuery     := ""
Local cIndex     := CriaTrab("",.F.)
Local nIndex     := 0
Local lQuery     := .F.
Local cLin       :="_______________________________________________________________________________________________"

Local aStruQPK   := {}
Local cTPOP      := ""
Local nTotRec    := 0
Local nX         := 0

Local cAliasQPK  := "QPK"
Local cOrdProd   := ""
Local cReviC2    := ""
Local cOperac    := ""
Local cLabor     := ""
Local cEnsaio	 := ""
Local lPula      := .T.
Local nResApr    := 0
Local nResRep    := 0
Local cCarta     := ""
Local cCabEns    := ""
Local lImpCab    := .T.

li     := 80
m_pag  := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCabec1 :="NUMERO                                               PRODUTO                                  UN. MED.    DATA     ENTREGA     DATA     QUANTIDADE   SALDO A       SITUACAO    TIPO OP    ROTEIRO"	
cCabec2 :="                                                     DESCRICAO                                          PREVISTA               REAL                 ENTREGAR"
cCabec3 :="INSPECIONA/CERTIFICA             LAUDO"							  	
                                 

DbSelectArea("QPK")
DbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿              9
//³ Inicializa variavel para controle do filtro                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par12 == 1 
	cStatus := "S"
ElseIf mv_par12 == 2
	cStatus := "U"
ElseIf mv_par12 == 3
	cStatus := "S,U,D,N, "
EndIf	                                                     
If mv_par13 == 1
	cTPOP := "F"
ElseIf mv_par13 == 2
	cTPOP := "P"
ElseIf mv_par13 == 3
	cTPOP := "F,P"
EndIf	
lQuery 	  := .T.
aStruQPK  := QPK->(dbStruct())
cAliasQPK := 'R180IMP'

cQuery    := "SELECT COUNT(*) TOTAL FROM "
cQuery    += RetSqlName("QPK")+" QPK , "
cQuery    += RetSqlName("SC2")+" SC2 "
cQuery    += "WHERE "
    cQuery    += "QPK.QPK_FILIAL = '"+xFilial('QPK')+"' And "
cQuery    += "QPK.QPK_OP >= '"+MV_PAR01+"' AND "
cQuery    += "QPK.QPK_LOTE >= '"+MV_PAR02+"' AND "
cQuery    += "QPK.QPK_NUMSER >= '"+MV_PAR03+"' AND "
cQuery    += "QPK.QPK_OP <= '"+MV_PAR04+"' AND "
cQuery    += "QPK.QPK_LOTE <= '"+MV_PAR05+"' AND "
cQuery    += "QPK.QPK_NUMSER <= '"+MV_PAR06+"' AND "
cQuery    += "QPK.QPK_PRODUT >= '"+mv_par07+"' And QPK.QPK_PRODUT <= '"+mv_par08+"' And "
cQuery    += "QPK.QPK_EMISSA  >= '"+DtoS(mv_par09)+"' And QPK.QPK_EMISSA  <= '"+DtoS(mv_par10)+"' And "
cQuery    += "Substring(QPK.QPK_OP,1,6) = SC2.C2_NUM AND "
cQuery    += "Substring(QPK.QPK_OP,7,2) = SC2.C2_ITEM AND "
cQuery    += "Substring(QPK.QPK_OP,9,3) = SC2.C2_SEQUEN AND "
cQuery    += "SC2.C2_STATUS IN ('"+cStatus+"') And "
cQuery    += "SC2.C2_TPOP IN ('"+cTPOP+"') And "
cQuery    += "SC2.D_E_L_E_T_ = ' ' And "
cQuery    += "QPK.D_E_L_E_T_ = ' ' "

cQuery    := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQPK,.T.,.T.)
If Select(cAliasQPK) > 0
	nTotRec:= (cAliasQPK)->TOTAL
	dbCloseArea()
EndIf

cQuery    := "SELECT QPK_FILIAL, QPK_OP, QPK_PRODUT, QPK_LOTE, QPK_NUMSER, "
cQuery    += "QPK_EMISSA, QPK_TAMLOT, QPK_LAUDO, QPK_REVI FROM "
cQuery    += RetSqlName("QPK")+" QPK , "
cQuery    += "WHERE "
cQuery    += "QPK.QPK_FILIAL = '"+xFilial("QPK")+"' And "
cQuery    += "QPK.QPK_OP >= '"+MV_PAR01+"' AND "
cQuery    += "QPK.QPK_LOTE >= '"+MV_PAR02+"' AND "
cQuery    += "QPK.QPK_NUMSER >= '"+MV_PAR03+"' AND "
cQuery    += "QPK.QPK_OP <= '"+MV_PAR04+"' AND "
cQuery    += "QPK.QPK_LOTE <= '"+MV_PAR05+"' AND "
cQuery    += "QPK.QPK_NUMSER <= '"+MV_PAR06+"' AND "
cQuery    += "QPK.QPK_PRODUT >= '"+mv_par07+"' And QPK.QPK_PRODUT <= '"+mv_par08+"' And "
cQuery    += "QPK.QPK_EMISSA  >= '"+DtoS(mv_par09)+"' And QPK.QPK_EMISSA  <= '"+DtoS(mv_par10)+"' And "
cQuery    += "QPK.D_E_L_E_T_ = ' ' "
cQuery    += "ORDER BY "+SqlOrder(QPK->(IndexKey()))

cQuery    := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQPK,.T.,.T.)

For nX := 1 To Len(aStruQPK)
	If ( aStruQPK[nX][2] <> "C" ) 
		TcSetField(cAliasQPK,aStruQPK[nX][1],aStruQPK[nX][2],aStruQPK[nX][3],aStruQPK[nX][4])
	EndIf
Next nX

SetRegua(nTotRec)		// Total de Elementos da regua

dbGoTop()
While !Eof()

	IncRegua()

	If lEnd
		@ Prow()+1,001 PSay OemToAnsi(STR0003)	//	"CANCELADO PELO OPERADOR"
		Exit
	EndIF                              
	
	//Posiciona OP Principal
	dbSelectArea("SC2")
	dbSetOrder(1)
	dbSeek(xFiliaL("SC2")+PadR((cAliasQPK)->QPK_OP,11)) 
	
	If mv_par11 == 1  // O.P.s EM ABERTO
		If aSC2Sld("SC2") <= 0 .Or. !Empty(SC2->C2_DATRF)
			(cAliasQPK)->(dbSkip())
			Loop
		Endif
	Elseif mv_par11 == 2 //O.P.S ENCERRADAS
		If aSC2Sld("SC2") > 0 .And. Empty(SC2->C2_DATRF)
			(cAliasQPK)->(dbSkip())
			Loop
		Endif
	Endif
	
	//-- Valida se a OP deve ser Impressa ou n„o
	
	If !(SC2->C2_STATUS$cStatus)
		(cAliasQPK)->(dbSkip())
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtro do Usuario ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(aReturn[7])
		If !&(aReturn[7])
			(cAliasQPK)->(dbSkip())
			Loop
		EndIf
	EndIf	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Termina filtragem e grava variavel p/ totalizacao            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While (cAliasQPK)->(!Eof()) .And. xFilial("QPK") == (cAliasQPK)->QPK_FILIAL
		IncRegua()

		//Reposiciona OP Principal
		SC2->(dbSetOrder(1)	)
		SC2->(dbSeek(xFiliaL("SC2")+PadR((cAliasQPK)->QPK_OP,11)))
	
		//Posiciona Especificacao do Produto
		dbSelectArea("QP6")
		dbSetOrder(1)
		dbSeek(xFiliaL("QP6")+(cAliasQPK)->QPK_PRODUT+INVERTE((cAliasQPK)->QPK_REVI))	

		If lEnd
			@ Prow()+1,001 PSay OemToAnsi(STR0003)	//	"CANCELADO PELO OPERADOR"
			Exit
		EndIF

		If mv_par11 == 1  // O.P.s EM ABERTO
			If aSC2Sld("SC2") <= 0 .Or. !Empty(SC2->C2_DATRF)
				(cAliasQPK)->(dbSkip())
				Loop
			Endif
		Elseif mv_par11 == 2 //O.P.S ENCERRADAS
				If aSC2Sld("SC2") > 0 .And. Empty(SC2->C2_DATRF)
				(cAliasQPK)->(dbSkip())
				Loop
			Endif
		Endif

		//-- Valida se a OP deve ser Impressa ou n„o
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Filtro do Usuario ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(aReturn[7])
			If !&(aReturn[7])
				(cAliasQPK)->(dbSkip())
				Loop
			EndIf
		EndIf	

		SB1->(dbSetOrder(1))
		SB1->(dbSeek(xFilial("SB1")+(cAliasQPK)->QPK_PRODUTO))

		IF li > 58
			Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,nTipo)
		EndIF

		@Li ,000 PSay (cAliasQPK)->QPK_OP
		@Li ,014 PSay (cAliasQPK)->QPK_LOTE
		@Li ,031 PSay (cAliasQPK)->QPK_NUMSER
		@Li ,052 PSay (cAliasQPK)->QPK_PRODUT
		If Len(Alltrim(SB1->B1_DESC)) < 15 
			@Li ,078 PSay SubStr(SB1->B1_DESC,1,30)
		Endif
		@Li ,094 PSay Posicione("SAH",1,xFilial("SAH")+SC2->C2_UM,"AH_UMRES")
		@Li ,106 PSay (cAliasQPK)->QPK_EMISSA
		@Li ,116 PSay SC2->C2_DATPRF
		@Li ,126 PSay SC2->C2_DATRF
		@Li ,134 PSay (cAliasQPK)->QPK_TAMLOT Picture PesqPictQt("C2_QUANT",12)
		@Li ,146 PSay IIf(Empty(SC2->C2_DATRF),aSC2Sld("SC2"),0) Picture PesqPictQt("C2_QUANT",12)
	  	@Li ,163 PSay SC2->C2_STATUS
	 	@Li ,175 PSay SC2->C2_TPOP
	  	@Li ,186 PSay QP6->QP6_CODREC
		Li++
		If Len(Alltrim(SB1->B1_DESC)) > 15 
			@Li ,052 PSay SB1->B1_DESC
		Endif
        Li++
        @li, 001 PSAY __PrtLeft(cLin)
        @Li, 000 PSAY cCabec3
        Li+=2
        @Li ,001 PSay If(SC2->C2_VERIFI == 1,OemToAnsi(STR0008),OemToAnsi(STR0009)) // "Inpesciona" ### "Certifica"
	 	@Li ,032 PSay If(!Empty((cAliasQPK)->QPK_LAUDO),Posicione("QPD",1,xFilial("QPD")+(cAliasQPK)->QPK_LAUDO,"QPD_DESCPO"),OemToAnsi(STR0018)) // "Sem Laudo"
	    @Li++
		//Seleciona as medicoes da entrega
		cOrdProd := (cAliasQPK)->QPK_OP
		cReviQPK  := If(Empty((cAliasQPK)->QPK_REVI),QA_UltRevEsp((cAliasQPK)->QPK_PRODUT,,,,"QIP"),(cAliasQPK)->QPK_REVI)  

		QPR->(DbSetOrder(9))
		If QPR->(DbSeek(xFilial("QPR")+(cAliasQPK)->QPK_OP+(cAliasQPK)->QPK_LOTE+(cAliasQPK)->QPK_NUMSER))
			cOperac:= " "
			cLabor := " "
			cEnsaio:= " "
			@Li ,000 PSay __PrtThinLine()
			While QPR->(!Eof()) .And. xFilial("QPR") == QPR->QPR_FILIAL .And. ;
				QPR->QPR_OP+QPR->QPR_LOTE+QPR->QPR_NUMSER == (cAliasQPK)->QPK_OP+(cAliasQPK)->QPK_LOTE+(cAliasQPK)->QPK_NUMSER

				If lEnd
					Exit
				EndIF

				lPula:= .T.
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Laudo da Operacao                                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If cOperac <> QPR->QPR_OPERAC
					cOperac := QPR->QPR_OPERAC
					cLabor  := ""
					lImpCab := .T.
					Li+= 2
					@Li ,000 PSay TitSx3("QPR_OPERAC")[1]+": "+QPR->QPR_OPERAC+" - "+RetDesOper(cOrdProd,QPR->QPR_OPERAC,QPR->QPR_PRODUT,QPR->QPR_REVI)
					QPM->(DbSetOrder(3))
					If QPM->(DbSeek(xFilial("QPM")+QPR->QPR_OP+QPR->QPR_LOTE+QPR->QPR_NUMSER+QP6->QP6_CODREC+QPR->QPR_OPERAC))
						@Li ,049 PSay OemToAnsi(STR0013)+Posicione("QPD",1,xFilial("QPD")+QPM->QPM_LAUDO,"QPD_DESCPO") // "Laudo da Operacao: "
						If !Empty(QPM->QPM_JUSTLA)
							@Li ,121 Psay AllTrim(TitSx3("QPM_JUSTLA")[1])+": "+QPM->QPM_JUSTLA
						EndIf
	 					Li++
						@Li ,000 Psay AllTrim(TitSx3("QPM_DTENLA")[1])+": "+DtoC(QPM->QPM_DTENLA)
						@Li ,026 Psay AllTrim(TitSx3("QPM_HRENLA")[1])+": "+QPM->QPM_HRENLA
						@Li ,049 Psay AllTrim(TitSx3("QPM_DTLAUD")[1])+": "+DtoC(QPM->QPM_DTLAUD)
						@Li ,074 Psay AllTrim(TitSx3("QPM_HRLAUD")[1])+": "+QPM->QPM_HRLAUD
						@Li ,097 Psay AllTrim(TitSx3("QPM_DTVAL" )[1])+": "+DtoC(QPM->QPM_DTVAL)
						@Li ,121 Psay AllTrim(TitSx3("QPM_TAMLOT")[1])+": "+QPM->QPM_TAMLOT
						@Li ,144 Psay AllTrim(TitSx3("QPM_QTREJ" )[1])+": "+If(Empty(QPM->QPM_QTREJ),"0",QPM->QPM_QTREJ)
						If !Empty(QPM->QPM_DTDILA)
							@Li ,167 Psay AllTrim(TitSx3("QPM_DTDILA")[1])+": "+DtoC(QPM->QPM_DTDILA)
							@Li ,191 Psay AllTrim(TitSx3("QPM_HRDILA")[1])+": "+QPM->QPM_HRDILA
						EndIf
					EndIf
				EndIf

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Laudo do Laborat¢rio                             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If cLabor <> QPR->QPR_LABOR
					cLabor   := QPR->QPR_LABOR
					cDescLab := Tabela("Q2",QPR->QPR_LABOR)
					cEnsaio  := " "
					lImpCab  := .T.
					Li+=2
					@Li, 000 PSAY TitSx3("QPR_LABOR")[1]+": "+QPR->QPR_LABOR + " - " + cDescLab	//"Laboratorio : " 
					QPL->(DbSetOrder(3))
					If QPL->(dbSeek(xFilial("QPL")+QPR->QPR_OP+QPR->QPR_LOTE+QPR->QPR_NUMSER+QP6->QP6_CODREC+QPR->QPR_OPERAC+QPR->QPR_LABOR))
						QPD->(dbSeek(xFilial("QPD")+QPL->QPL_LAUDO))
						@Li,049 PSAY OemToAnsi(STR0014)+Posicione("QPD",1,xFilial("QPD")+QPL->QPL_LAUDO,"QPD_DESCPO") //"Laudo Laboratorio : "
						If !Empty(QPL->QPL_JUSTLA)
							@Li ,121 Psay AllTrim(TitSx3("QPL_JUSTLA")[1])+": "+QPL->QPL_JUSTLA
						EndIf
	 					Li++
						@Li ,000 Psay AllTrim(TitSx3("QPL_DTENLA")[1])+": "+DtoC(QPL->QPL_DTENLA)
						@Li ,026 Psay AllTrim(TitSx3("QPL_HRENLA")[1])+": "+QPL->QPL_HRENLA
						@Li ,049 Psay AllTrim(TitSx3("QPL_DTLAUD")[1])+": "+DtoC(QPL->QPL_DTLAUD)
						@Li ,074 Psay AllTrim(TitSx3("QPL_HRLAUD")[1])+": "+QPL->QPL_HRLAUD
						@Li ,097 Psay AllTrim(TitSx3("QPL_DTVAL" )[1])+": "+DtoC(QPL->QPL_DTVAL)
						@Li ,121 Psay AllTrim(TitSx3("QPL_TAMLOT")[1])+": "+QPL->QPL_TAMLOT
						@Li ,144 Psay AllTrim(TitSx3("QPL_QTREJ" )[1])+": "+If(Empty(QPL->QPL_QTREJ),"0",QPL->QPL_QTREJ)
						If !Empty(QPL->QPL_DTDILA)
							@Li ,167 Psay AllTrim(TitSx3("QPL_DTDILA")[1])+": "+DtoC(QPL->QPL_DTDILA)
							@Li ,191 Psay AllTrim(TitSx3("QPL_HRDILA")[1])+": "+QPL->QPL_HRDILA
						EndIf
						Li++
					EndIf			
				EndIf

				Li++
				
				If li > 58
					Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,nTipo)
				EndIf

				If QP1->(dbSeek(xFilial("QP1")+QPR->QPR_ENSAIO))  // Ensaios

					If cEnsaio <> QPR->QPR_ENSAIO
						cEnsaio := QPR->QPR_ENSAIO

						If lImpCab	
							//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
							//          1         2         3         4         5         6         7         8         9        10         11       12        13        14        15        16        17        18        19        20        21        22
							//ENSAIO                                              CARTA TOT MED. APROVADOS. REPROVADOS PLANO DE AMOSTRAGEM
							//12345678 - 1234567890123456789012345678901234567890 123   12345678 12345678   12345678   123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
							cCabEns:= OemToAnsi(STR0007) // "ENSAIO                                              CARTA TOT MED. APROVADOS. REPROVADOS PLANO DE AMOSTRAGEM"
							@Li, 000 PSAY __PrtThinLine()
							Li++
							@Li, 000 PSAY cCabEns
							Li++
							@Li, 000 PSAY __PrtThinLine()
							Li++	
                        	lImpCab:= .F.
                        EndIf
						
						@Li, 000 PSAY QPR->QPR_ENSAIO + " - " +QP1->QP1_DESCPO
						@Li, 052 PSAY QP1->QP1_CARTA
								
						nResApr := 0
						nResRep := 0
						QPR->(dbSetOrder(9))
						If QPR->(DbSeek(xFilial("QPR")+(cAliasQPK)->QPK_OP+(cAliasQPK)->QPK_LOTE+(cAliasQPK)->QPK_NUMSER+QP6->QP6_CODREC+cOperac+cLabor+cEnsaio))
							While QPR->(!Eof()) .And. xFilial("QPR") == QPR->QPR_FILIAL .And. ;
								QPR->QPR_OP == (cAliasQPK)->QPK_OP .And. QPR->QPR_LOTE == (cAliasQPK)->QPK_LOTE .And. ;
								QPR->QPR_NUMSER == (cAliasQPK)->QPK_NUMSER .And. QPR->QPR_OPERAC == cOperac .And. ;
								QPR->QPR_LABOR == cLabor .And. QPR->QPR_ENSAIO == cEnsaio

								If QPR->QPR_RESULT == "A"
									nResApr++
								Else
									nResRep++
								EndIf
								lPula:= .F.
								QPR->(dbSkip())
							EndDo
						EndIf
						@Li, 058 PSAY AllTrim(Str(nResApr+nResRep)) // "Total de Medicoes: "
						@Li, 067 PSAY AllTrim(Str(nResApr)) // "Medicoes Aprovadas: "
						@Li, 078 PSAY AllTrim(Str(nResRep)) // "Medicoes Reprovadas: "

						cCarta := QPCarta(QP1->QP1_ENSAIO)
						If cCarta <> "TXT"
							QP7->(dbSetOrder(1))
							If QP7->(dbSeek(xFilial("QP7")+(cAliasQPK)->(QPK_PRODUT)+cReviQPK+QP6->QP6_CODREC+cOperac+cEnsaio))
								If !Empty(QP7->QP7_PLAMO)
									If QP7->QP7_PLAMO == "I"
										@Li, 089 PSAY QP7->QP7_DESPLA
									ElseIf QP7->QP7_PLAMO == "N"
										If !Empty(Substr(QP7->QP7_DESPLA,1,3))
											@Li, 089 PSAY Substr(QP7->QP7_DESPLA,1,3)+": "
											@Li, 095 PSAY AllTrim(Substr(QP7->QP7_DESPLA,4,16))
										EndIf							
										If !Empty(Substr(QP7->QP7_DESPLA,20,13))
											@Li, 116 PSAY Substr(QP7->QP7_DESPLA,20,13)+": "
											@Li, 131 PSAY AllTrim(Substr(QP7->QP7_DESPLA,33,3))
										EndIf
										If !Empty(Substr(QP7->QP7_DESPLA,36,10))
											@Li, 137 PSAY Substr(QP7->QP7_DESPLA,36,10)+": "
											@Li, 149 PSAY AllTrim(substr(QP7->QP7_DESPLA,49,2))
										EndIf
									ElseIf QP7->QP7_PLAMO == "T"
										@Li, 089 PSAY OemToAnsi(STR0017)+" "+QP7->QP7_DESPLA	//"Texto"
									ElseIf QP7->QP7_PLAMO == "Z"
										@Li, 089 PSAY OemToAnsi(STR0006)+" "+QP7->QP7_DESPLA	//"Zero Defeito"
									EndIf
								EndIf
							EndIf
						Else
							QP8->(dbSetOrder(1))
							If QP8->(dbSeek(xFilial("QP8")+(cAliasQPK)->(QPK_PRODUT)+cReviQPK+QP6->QP6_CODREC+cOperac+cEnsaio))
								If !Empty(QP8->QP8_PLAMO)
									If QP8->QP8_PLAMO == "I"
										@Li, 089 PSAY QP8->QP8_DESPLA
									ElseIf QP8->QP8_PLAMO == "N"
										If !Empty(Substr(QP8->QP8_DESPLA,1,3))
											@Li, 089 PSAY Substr(QP8->QP8_DESPLA,1,3)+": "
											@Li, 095 PSAY AllTrim(Substr(QP8->QP8_DESPLA,4,16))
										EndIf							
										If !Empty(Substr(QP8->QP8_DESPLA,20,13))
											@Li, 116 PSAY Substr(QP8->QP8_DESPLA,20,13)+": "
											@Li, 131 PSAY AllTrim(Substr(QP8->QP8_DESPLA,33,3))
										EndIf
										If !Empty(Substr(QP8->QP8_DESPLA,36,10))
											@Li, 137 PSAY Substr(QP8->QP8_DESPLA,36,10)+": "
											@Li, 149 PSAY AllTrim(substr(QP8->QP8_DESPLA,49,2))
										EndIf
									ElseIf QP8->QP8_PLAMO == "T"
										@Li, 089 PSAY OemToAnsi(STR0017)+" "+QP8->QP8_DESPLA	//"Texto"
									ElseIf QP8->QP8_PLAMO == "Z"
										@Li, 089 PSAY OemToAnsi(STR0006)+" "+QP8->QP8_DESPLA	//"Zero Defeito"
									EndIf
								EndIf
							EndIf
						EndIf
					EndIf
				EndIf				
				If lPula
					QPR->(dbSkip())
				EndIf
			EndDo			
		EndIf
		Li++
		@Li ,  0 PSay __PrtFatLine()
		Li+=2
		(cAliasQPK)->(dbSkip())
	EndDo
EndDo

If Li != 80
	Roda(cbcont,cbtxt)
EndIF

If lQuery
	dbSelectArea(cAliasQPK)
	dbCloseArea()
EndIf

QPR->(dbSetOrder(1))

dbSelectArea("QPK")
Set Filter To
dbSetOrder(1)

If File(cIndex+OrdBagExt())
	Ferase(cIndex+OrdBagExt())
Endif

If aReturn[5] == 1
   Set Printer To
   OurSpool(wnrel)
EndIf

MS_FLUSH()

Return NIL
