/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Rwmake.ch"
#Include "Protheus.ch"      
#Include "TOPCONN.ch"
#Include "TECR020.ch"
Static cAutoPerg := "TECR020" 
//-------------------------------------------------------------------
/*/{Protheus.doc} TECR020
Monta as definiçoes do relatorio de Recursos (Atendentes) Não-Alocados.
@author filipe.goncalves
@since 21/01/2016
@version P12.1.11
@history 17/11/2020, Mário A. cavenaghi - EthosX, Correção de MultiFiliais
/*/
//-------------------------------------------------------------------
User Function TECR020()
Local oReport := Nil
Private cPerg	:= "TECR020" 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ PARAMETROS                                                             ³
//³ MV_PAR01 : Data de ?                                                   ³
//³ MV_PAR02 : Data ate?                                                   ³
//³ MV_PAR03 : Atendente de ?                                              ³
//³ MV_PAR04 : Atendente ate ?                                             ³
//³ MV_PAR05 : Centro de custo de ?                                        ³
//³ MV_PAR06 : Centro de custo ate ?                                       ³
//³ MV_PAR07 : Filiais?                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

//Exibe dialog de perguntes ao usuario
If !Pergunte(cPerg,.T.)
	Return nil
Endif

//Pinta o relatorio a partir das perguntas escolhidas
oReport := ReportDef()   
oReport:PrintDialog()  
Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} reportDef
Monta as definiçoes do relatorio de Recursos (Atendentes) Não-Alocados.

@author filipe.goncalves
@since 21/01/2016
@version P12.1.11
@return  Nil
/*/
//-------------------------------------------------------------------------------------
Static Function ReportDef()

Local cTitulo 	:= STR0002
Local oReport
Local oSection1

If TYPE("cPerg") == "U"
	cPerg	:= "TECR020"
EndIf

oReport 	:= TReport():New(cPerg, cTitulo, cPerg , {|oReport| PrintReport(oReport)},STR0001)
oSection1 := TRSection():New(oReport,"Atendentes",{"AA1","SRA","TGY"})

oReport:ShowHeader()
oReport:SetPortrait()
oReport:SetTotalInLine(.F.)
oSection1:SetTotalInLine(.F.)

TRCell():New(oSection1, STR0024 , "SRA", STR0023 ,PesqPict('SRA',"RA_FILIAL") ,TamSX3("RA_FILIAL")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1, STR0009 , "SRA", STR0016 ,PesqPict('SRA',"RA_MAT")    ,TamSX3("RA_MAT")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1, STR0010 , "AA1", STR0017 ,PesqPict('AA1',"AA1_CODTEC"),TamSX3("AA1_CODTEC")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1, STR0011 , "AA1", STR0018 ,PesqPict('AA1',"AA1_NOMTEC"),TamSX3("AA1_NOMTEC")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1, STR0012 , "SRA", STR0019 ,PesqPict('SRA',"RA_SEXO")   ,TamSX3("RA_SEXO")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1, STR0013 , "TGY", STR0020 ,PesqPict('TGY',"TGY_DTINI") ,TamSX3("TGY_DTINI")[1],/*lPixel*/,/*{|| code-block de impressao }*/)  

oSection1:Cell(STR0009):SetAlign("LEFT")
oSection1:Cell(STR0010):SetAlign("LEFT")
oSection1:Cell(STR0011):SetAlign("LEFT")
oSection1:Cell(STR0012):SetAlign("LEFT")
oSection1:Cell(STR0013):SetAlign("LEFT")

Return (oReport) 

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
Gera o relatorio de Recursos (Atendentes) Não-Alocados.

@author filipe.goncalves
@since 21/01/2016
@version P12.1.11
@return  Nil
/*/
//-------------------------------------------------------------------------------------
Static Function PrintReport(oReport)

Local aArea	:= GetArea() 
Local oSection1	:= oReport:Section(1)
Local dDtIni	:= MV_PAR01
Local dDtFim	:= MV_PAR02
Local lExistTGY := .F.
Local lExistABB	:= .F.
Local cAliasTGY	:= ""
Local cAliasABB	:= ""
Local nPosTXBDtI:= 0
Local nPosTXBDtF:= 0	
Local lResRHTXB	:= TableInDic("TXB") //Restrições de RH
Local lMVPAR07 	:= .F. 
Local aFilsPAR07 := {}
Local cXfilAA1 	:= " = '" + xFilial("AA1", cFilAnt) +"'"
Local cXfilTGY 	:= " = '" + xFilial("TGY", cFilAnt) +"'"
Local cXfilABB 	:= " = '" + xFilial("ABB", cFilAnt) +"'" 
Local cXfilTCU	:= " = '" + xFilial("TCU", cFilAnt) +"'"
Local cFiAA1SRA := FWJoinFilial("SRA","AA1","SRA","AA1",.T.)
Local cFilBkp	:= ""
Local aPrjAgd	:= {}
Local nX		:= 0
Local nY 		:= 0
Local cChavTGY	:= ""
Local lDiaTrb	:= .F.
Local lVerRestr	:= .F.
Local nTotSM0 	:= SM0->(RecCount())
Local cDtFimAlo	:= ""

lMVPAR07 := TecHasPerg("MV_PAR07","TECR020")

MakeSqlExpr("TECR020")

If lMVPAR07
	If Empty(MV_PAR07)	//	Todas as Filiais
		nY := SM0->(Recno())
		SM0->(dbGotop())
		For nX := 1 To nTotSM0
			aAdd(aFilsPAR07, xFilial("ABB", SM0->M0_CODFIL))
			SM0->(dbSkip())
		Next
		SM0->(dbGoto(nY))
	Else	//	Só as selecionadas
		MV_PAR07 := Alltrim(MV_PAR07)
		MV_PAR07 := STRTRAN(MV_PAR07, "AA1_FILIAL")
		MV_PAR07 := STRTRAN(MV_PAR07, ";", ",")
		MV_PAR07 := REPLACE(MV_PAR07, " IN")
		MV_PAR07 := REPLACE(MV_PAR07, "(")
		MV_PAR07 := REPLACE(MV_PAR07, ")")
		MV_PAR07 := REPLACE(MV_PAR07, "'")
		aFilsPAR07 := StrTokArr(MV_PAR07,",")
	Endif
	For nX := 1 To LEN(aFilsPAR07)
		If nX == 1
			cXfilAA1 := " IN ("
			cXfilTGY := " IN ("
			cXfilABB := " IN ("
			cXfilTCU := " IN ("
		EndIf

		cXfilAA1 += "'" + xFilial("AA1", aFilsPAR07[nX] ) 
		cXfilTGY += "'" + xFilial("TGY", aFilsPAR07[nX] )
		cXfilABB += "'" + xFilial("ABB", aFilsPAR07[nX] )
		cXfilTCU += "'" + xFilial("TCU", aFilsPAR07[nX] )

		If nX < LEN(aFilsPAR07)
			cXfilAA1 +=  "',"
			cXfilTGY +=  "',"
			cXfilABB +=  "',"
			cXfilTCU +=  "',"
		EndIf

		If nX == LEN(aFilsPAR07)
			cXfilAA1 += "') "		
			cXfilTGY += "') "
			cXfilABB += "') "
			cXfilTCU += "') "
		EndIf
	Next nX
Else
	MV_PAR07 := cFilAnt
EndIf
If SuperGetMV("MV_GSMSFIL",, .F.)	//	Se for MultiFilial, considerar as agendas de todas as filiais
	nY := SM0->(Recno())
	SM0->(dbGotop())
	cXfilABB := " IN ('"
	For nX := 1 To nTotSM0
		cXfilABB += xFilial("ABB", SM0->M0_CODFIL) + Iif(nX < nTotSM0, "','", "")
		SM0->(dbSkip())
	Next
	cXfilABB += "') "
	SM0->(dbGoto(nY))
Endif
cXfilAA1  := "%"+cXfilAA1 +"%" 
cXfilTGY  := "%"+cXfilTGY +"%" 
cXfilABB  := "%"+cXfilABB +"%"  
cXfilTCU  := "%"+cXfilTCU +"%"
cFiAA1SRA := "%"+cFiAA1SRA+"%"

BEGIN REPORT QUERY oReport:Section(1)

	BeginSql alias "QRY"

		SELECT AA1.AA1_CODTEC, AA1.AA1_NOMTEC, SRA.RA_FILIAL, SRA.RA_SEXO, RA_MAT, RA_NOME
		  FROM %table:AA1% AA1
		  	INNER JOIN %table:SRA% SRA ON %exp:cFiAA1SRA% 
		  	AND SRA.RA_MAT = AA1.AA1_CDFUNC
		  	AND SRA.RA_FILIAL = AA1.AA1_FUNFIL	  
		  	AND SRA.%notDel% 
		 WHERE AA1.AA1_FILIAL  %exp:cXfilAA1%
			AND AA1.AA1_CODTEC BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04%
			AND AA1.AA1_CC	   BETWEEN %Exp:MV_PAR05% AND %Exp:MV_PAR06%
		   	AND AA1.%notDel%
		ORDER BY SRA.RA_NOME 
		
	EndSql

END REPORT QUERY oReport:Section(1)

//Define tamanho da regua de processamento
oReport:SetMeter(QRY->(RecCount()))

//Monta a primeira secao do relatorio
oSection1:Init()
oSection1:SetHeaderSection(.T.)

dbSelectArea("QRY")

//Printa cada registro da query de busca no relatorio
While QRY->(!Eof())

	lVerRestr := .F.
	aPrjAgd   := {}
	cAliasTGY := GetNextAlias()
	cChavTGY  := ""

	BeginSql Alias cAliasTGY

		SELECT TGY.TGY_FILIAL,TGY.TGY_ESCALA,TGY.TGY_CODTDX,
				TGY.TGY_CODTFF,TGY.TGY_ITEM,TGY.TGY_DTINI,TGY.TGY_DTFIM,TGY.TGY_ULTALO
		FROM %table:TGY% TGY
		WHERE TGY.TGY_FILIAL %exp:cXfilTGY%
			AND	TGY.TGY_ATEND = %Exp:QRY->AA1_CODTEC%
				AND (TGY.TGY_DTINI BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02% OR TGY.TGY_ULTALO BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
					OR (%Exp:MV_PAR01% BETWEEN TGY.TGY_DTINI AND TGY.TGY_ULTALO OR %Exp:MV_PAR02% BETWEEN TGY.TGY_DTINI AND TGY.TGY_ULTALO)) 
			AND TGY.%notDel%
			AND EXISTS ( SELECT TCU.TCU_COD 
							FROM %table:TCU% TCU 
							WHERE TCU.TCU_FILIAL %exp:cXfilTCU% 
							AND TCU.TCU_COD = TGY.TGY_TIPALO
							AND TCU.TCU_RESTEC <> '1'
							AND TCU.%notDel% )
	EndSql

	cAliasABB := GetNextAlias()
		
	BeginSql Alias cAliasABB
		SELECT ABB.ABB_FILIAL,ABB.ABB_CODIGO,ABB.ABB_DTINI, ABB.ABB_DTFIM
		FROM %table:ABB% ABB
		WHERE ABB.ABB_FILIAL %exp:cXfilABB%
			AND	ABB.ABB_CODTEC = %Exp:QRY->AA1_CODTEC%
				AND (ABB.ABB_DTINI BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02% OR ABB.ABB_DTFIM BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
					OR (%Exp:MV_PAR01% BETWEEN ABB.ABB_DTINI AND ABB.ABB_DTFIM OR %Exp:MV_PAR02% BETWEEN ABB.ABB_DTINI AND ABB.ABB_DTFIM))
            AND ABB.%notDel%
			AND ABB.ABB_ATIVO <> '2'
			AND EXISTS ( SELECT TCU.TCU_COD 
							FROM %table:TCU% TCU 
							WHERE TCU.TCU_FILIAL %exp:cXfilTCU% 
							AND TCU.TCU_COD = ABB.ABB_TIPOMV
							AND TCU.TCU_RESTEC <> '1'
							AND TCU.%notDel% )
		ORDER BY ABB.ABB_DTINI
	EndSql
				
	If lMVPAR07 .And. !Empty(aFilsPAR07)
	
		cFilBkp := cFilAnt

		For nX := 1 To Len(aFilsPAR07)

			cFilAnt := aFilsPAR07[nX]
			// Consulta os conflitos do atendente.
			ChkCfltAlc(MV_PAR01, MV_PAR02, QRY->AA1_CODTEC)
			
		Next nX

		If lResRHTXB .And. nPosTXBDtI == 0 .And. nPosTXBDtF == 0
			nPosTXBDtI:= AScan(AT330ArsSt("aCfltHead"),{|e| e == 'TXB_DTINI'})
			nPosTXBDtF:= AScan(AT330ArsSt("aCfltHead"),{|e| e == 'TXB_DTFIM'})
		Endif

		cFilAnt := cFilBkp
		
	Else
		// Consulta os conflitos do atendente.
		ChkCfltAlc(MV_PAR01, MV_PAR02, QRY->AA1_CODTEC)				

		If lResRHTXB .And. nPosTXBDtI == 0 .And. nPosTXBDtF == 0
			nPosTXBDtI:= AScan(AT330ArsSt("aCfltHead"),{|e| e == 'TXB_DTINI'})
			nPosTXBDtF:= AScan(AT330ArsSt("aCfltHead"),{|e| e == 'TXB_DTFIM'})
		Endif

	Endif

	While dDtIni <= dDtFim

		lExistTGY := .F.
		lExistABB := .F.
		lRestrRH  := .F.
		lDiaTrb   := .F.

		(cAliasTGY)->(dBGoTop())

		While (cAliasTGY)->(!Eof())
			If !Empty((cAliasTGY)->TGY_ULTALO)
				If dDtIni >= sTod((cAliasTGY)->TGY_DTINI) .And. dDtIni <= sTod((cAliasTGY)->TGY_ULTALO)				
					lExistTGY := .T.
					//Projeção de agenda.
					If cChavTGY <> (cAliasTGY)->(TGY_FILIAL+TGY_ESCALA+TGY_CODTDX+TGY_CODTFF+TGY_ITEM) .And.;
						TDX->(MsSeek(xFilial("TDX")+(cAliasTGY)->TGY_CODTDX))
						
						Aadd(aPrjAgd,ProjAgend(sTod((cAliasTGY)->TGY_DTINI),sTod((cAliasTGY)->TGY_ULTALO),TDX->TDX_TURNO,TDX->TDX_SEQTUR))
						cChavTGY := (cAliasTGY)->(TGY_FILIAL+TGY_ESCALA+TGY_CODTDX+TGY_CODTFF+TGY_ITEM)
					Endif
				Endif
			Else
				If cChavTGY <> (cAliasTGY)->(TGY_FILIAL+TGY_ESCALA+TGY_CODTDX+TGY_CODTFF+TGY_ITEM) .And.;
						TDX->(MsSeek(xFilial("TDX")+(cAliasTGY)->TGY_CODTDX))

					cDtFimAlo := GetUltAloc((cAliasTGY)->TGY_CODTFF,QRY->AA1_CODTEC)
				EndIf
				If !Empty(cDtFimAlo) .And. dDtIni >= sTod((cAliasTGY)->TGY_DTINI) .And. dDtIni <= sTod(cDtFimAlo)				
					lExistTGY := .T.
					//Projeção de agenda.
					If cChavTGY <> (cAliasTGY)->(TGY_FILIAL+TGY_ESCALA+TGY_CODTDX+TGY_CODTFF+TGY_ITEM) .And.;
						TDX->(MsSeek(xFilial("TDX")+(cAliasTGY)->TGY_CODTDX))
						
						Aadd(aPrjAgd,ProjAgend(sTod((cAliasTGY)->TGY_DTINI),sTod(cDtFimAlo),TDX->TDX_TURNO,TDX->TDX_SEQTUR))
						cChavTGY := (cAliasTGY)->(TGY_FILIAL+TGY_ESCALA+TGY_CODTDX+TGY_CODTFF+TGY_ITEM)
					Endif
				Endif

			EndIf	
			(cAliasTGY)->(dbSkip())
		EndDo

		(cAliasABB)->(dBGoTop())

		While (cAliasABB)->(!Eof())
			If dDtIni >= sTod((cAliasABB)->ABB_DTINI) .And. dDtIni <= sTod((cAliasABB)->ABB_DTFIM)
				lExistABB := .T.
				//Verifica se houve troca de sequencia para ajustar a projeção
				CheckSeq((cAliasABB)->ABB_CODIGO,(cAliasABB)->ABB_FILIAL,dDtIni,aPrjAgd)
				Exit
			Elseif sTod((cAliasABB)->ABB_DTINI) > dDtIni
				Exit
			Endif
			(cAliasABB)->(dbSkip())
		EndDo
		
		//Verifica a exclusão de agenda
		If lExistTGY .And. !lExistABB
			For nX := 1 To Len(aPrjAgd)
				For nY := 1 To Len(aPrjAgd[nX])
					If aPrjAgd[nX,nY,1] == dDtIni .And. aPrjAgd[nX,nY,3] == "S"
						lDiaTrb := .T.
						Exit
					Elseif aPrjAgd[nX,nY,1] > dDtIni
						Exit
					Endif
				Next nY
			Next nX		
		Endif
		
		If (!lExistABB .And. !lExistTGY) .Or. lDiaTrb
							
			If !lRestrRH .And. Len(AT330ArsSt("aDiasFer")) > 0
				lRestrRH := (Ascan(AT330ArsSt("aDiasFer"),{|x| dDtIni >= x[2] .And. dDtIni <= x[3]} ) > 0)
			EndIf

			If !lRestrRH .And. Len(AT330ArsSt("aDiasFer2")) > 0
				lRestrRH := (Ascan(AT330ArsSt("aDiasFer2"),{|x| dDtIni >= x[2] .And. dDtIni <= x[3]} ) > 0)
			EndIf

			If !lRestrRH .And. Len(AT330ArsSt("aDiasFer3")) > 0
				lRestrRH := (Ascan(AT330ArsSt("aDiasFer3"),{|x| dDtIni >= x[2] .And. dDtIni <= x[3]} ) > 0)
			EndIf

			If !lRestrRH .And. Len(AT330ArsSt("aDiasDem")) > 0
				lRestrRH := (Ascan(AT330ArsSt("aDiasDem"),{|x| dDtIni >= x[2] } ) > 0)
			EndIf

			If !lRestrRH .And. Len(AT330ArsSt("aDiasAfast")) > 0
				lRestrRH := (Ascan(AT330ArsSt("aDiasAfast"),{|x| dDtIni >= x[2] .And. (dDtIni <= x[3] .Or. Empty(x[3]) )} ) > 0)
			EndIf

			If lResRHTXB .And. !lRestrRH .And. Len(AT330ArsSt("ACFLTATND")) > 0  .And. nPosTXBDtI > 0 .And. nPosTXBDtF > 0
				lRestrRH := (Ascan(AT330ArsSt("ACFLTATND"),{|x| !Empty(x[nPosTXBDtI]) .And. dDtIni >= sTod(x[nPosTXBDtI]) .And. ( Empty(x[nPosTXBDtF]) .Or. dDtIni <= sTod(x[nPosTXBDtF])) } ) > 0)
			Endif

			If !lRestrRH 

				//Atendente Ocioso nesse dia
				oSection1:Cell(STR0024):SetValue(Iif(Len(aFilsPAR07) == 1, aFilsPAR07[1], MV_PAR07))
				oSection1:Cell(STR0009):SetValue(QRY->RA_MAT)
				oSection1:Cell(STR0010):SetValue(QRY->AA1_CODTEC)
				oSection1:Cell(STR0011):SetValue(QRY->AA1_NOMTEC)
				oSection1:Cell(STR0012):SetValue(QRY->RA_SEXO)
				oSection1:Cell(STR0013):SetValue(dDtIni)
				
				If !isBlind()
					oSection1:PrintLine()
				EndIf
		
			Endif

		EndIf

		//Incremento da regua
		oReport:IncMeter()
	
		dDtIni++			
	
	EndDo

	dDtIni := MV_PAR01
		
	QRY->(dbSkip())

	(cAliasTGY)->(dbCloseArea())
	(cAliasABB)->(dbCloseArea())
	
	AT330ArsSt(,.T.)

	//botao cancelar
	If oReport:Cancel()
		Exit
	EndIf

EndDo

QRY->(dbCloseArea())

oSection1:Finish()

RestArea(aArea)

Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} GetPergTRp
Retorna o nome do Pergunte utilizado no relatório
Função utilizada na automação
@author Mateus Boiani
@since 31/10/2018
@return cAutoPerg, string, nome do pergunte
/*/
//-------------------------------------------------------------------------------------
Static Function GetPergTRp()

Return cAutoPerg

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} ProjAgend
Retorna a projeção de agenda de um determinado período
@author Kaique Schiller
@since 13/05/2020
@return aProjAgd, array, todos os dias do turno.
/*/
//-------------------------------------------------------------------------------------
Static Function ProjAgend(dDtIni,dDtFim,cTurno,cSeqIni)
Local aProjAgd  := {}
Local dDtProj   := dDtIni
Local aDiasSPJ  := {}
Local cAliasSPJ := GetNextAlias()
Local lPriDia	:= .F.
Local cUltSeq	:= ""
Local nSeq		:= 0
Local nPos		:= 0

BeginSql Alias cAliasSPJ
	SELECT SPJ.PJ_TURNO,
		   SPJ.PJ_SEMANA,
		   SPJ.PJ_DIA,
		   SPJ.PJ_TPDIA
	FROM %table:SPJ% SPJ
	WHERE SPJ.PJ_FILIAL = %xFilial:SPJ%
		AND SPJ.PJ_TURNO = %Exp:cTurno%
		AND SPJ.%notDel%
	ORDER BY PJ_TURNO,PJ_SEMANA,PJ_DIA
EndSql

While (cAliasSPJ)->(!Eof())
	aAdd(aDiasSPJ,{(cAliasSPJ)->PJ_SEMANA,; //Sequencia
					(cAliasSPJ)->PJ_DIA,;   //Dia semana
					(cAliasSPJ)->PJ_TPDIA}) //Tipo do dia - "S" Trabalahdo
	(cAliasSPJ)->(dbSkip())
	If !Empty((cAliasSPJ)->PJ_SEMANA)
		cUltSeq := (cAliasSPJ)->PJ_SEMANA
	Endif
EndDo

cSeqAux := cSeqIni

While dDtProj <= dDtFim

	If lPriDia .And. Dow(dDtProj) == 2
		nSeq := 1
		If (nSeq+Val(cSeqAux)) > Val(cUltSeq)
			nSeq 	:= 0
			cSeqAux := cSeqIni
		Else
			cSeqAux := PadL(cValToChar((nSeq+Val(cSeqAux))),TamSx3("PJ_SEMANA")[1],"0")
		Endif
	Endif
	
	If (nPos := AScan( aDiasSPJ ,{|e| e[1] == cSeqAux .And. e[2] == cValToChar(Dow(dDtProj)) })) > 0
		aAdd(aProjAgd, {dDtProj, aDiasSPJ[nPos,2],aDiasSPJ[nPos,3],aDiasSPJ[nPos,1] })
		lPriDia := .T.
	Endif
		
	dDtProj++
EndDo

(cAliasSPJ)->(DbCloseArea())

Return aProjAgd

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} CheckSeq
Compara a projeção da SPJ com a TDV para verificar se houve troca de sequencia e realiza
a quebra da projeção acertando a mesma.

@author Luiz Gabriel		
@since 11/02/2021
@return
/*/
//-------------------------------------------------------------------------------------
Static Function CheckSeq(cCodABB,cFilABB,dDtIni,aPrjAgd)
Local cAliasTDV	:= GetNextAlias()
Local nY		:= 0
Local nX		:= 0
Local nPosSeq	:= 0
Local aProjNew	:= 0
Local dDtFim	:= cToD('')

BeginSql Alias cAliasTDV
	SELECT TDV.TDV_TURNO,
		   TDV.TDV_SEQTRN,
		   TDV.TDV_CODABB
	FROM %table:TDV% TDV
	WHERE TDV.TDV_FILIAL =%Exp:cFilABB%
		AND TDV.TDV_CODABB = %Exp:cCodABB%
		AND TDV.%notDel%
EndSql

If (cAliasTDV)->(!Eof())
	For nX := 1 To Len(aPrjAgd)
		For nY := 1 To Len(aPrjAgd[nX])
			If aPrjAgd[nX,nY,1] == dDtIni .And. aPrjAgd[nX,nY,4] <> (cAliasTDV)->TDV_SEQTRN
				dDtFim := aPrjAgd[nX,Len(aPrjAgd[nX]),1]
				nPosSeq := AScan(aPrjAgd[nX],{|e| AllTrim(e[4]) == (cAliasTDV)->TDV_SEQTRN})
				If nPosSeq > 0
					//Projeta novamente o turno com as datas ajustadas até a quebra de sequencia
					aProjNew := ProjAgend(aPrjAgd[nX,nPosSeq,1],dDtIni-1,(cAliasTDV)->TDV_TURNO,aPrjAgd[nX,nPosSeq,4])
					//Deleta a posição no array para colocar a nova projeção
					ADel( aPrjAgd, nX )
					ASize( aPrjAgd, Len(aPrjAgd) - 1 )
					Aadd(aPrjAgd,aProjNew)
					//Projeta o periodo onde houve a quebra de sequencia e adiciona no array
					Aadd(aPrjAgd,ProjAgend(dDtIni,dDtFim,(cAliasTDV)->TDV_TURNO,(cAliasTDV)->TDV_SEQTRN))
				EndIf
				Exit
			Endif
		Next nY
	Next nX	
EndIf

(cAliasTDV)->(DbCloseArea())

Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} GetUltAloc
Quando existe TGY mais a data de ultima alocação não está preenchido,buscamos a data da 
ultima agenda para realizar a projeção

@author Luiz Gabriel		
@since 25/02/2021
@return
/*/
//-------------------------------------------------------------------------------------
Static Function GetUltAloc(cCodTFF,cCodAtend)
Local cAliasTDV	:= GetNextAlias()
Local cAliasABB := GetNextAlias()
Local cAliasABQ	:= GetNextAlias()
Local cIdcFal	:= ""
Local cCodABB	:= ""
Local cDtAloc	:= ""

BeginSql Alias cAliasABQ

	SELECT ABQ.ABQ_CONTRT,ABQ.ABQ_ITEM,ABQ.ABQ_ORIGEM 
		FROM %table:ABQ% ABQ
	INNER JOIN %table:TFF% TFF ON TFF.TFF_FILIAL = ABQ.ABQ_FILTFF 
		AND TFF.TFF_COD = ABQ.ABQ_CODTFF 
		AND TFF.TFF_CONTRT = ABQ.ABQ_CONTRT 
		AND TFF.%notDel%
	WHERE ABQ.%notDel% AND ABQ_CODTFF = %Exp:cCodTFF%

EndSql

If (cAliasABQ)->( !Eof() )
	cIdcFal := (cAliasABQ)->ABQ_CONTRT + (cAliasABQ)->ABQ_ITEM + (cAliasABQ)->ABQ_ORIGEM 
EndIf

(cAliasABQ)->(DbCloseArea())

If !Empty(cIdcFal)
	BeginSql Alias cAliasABB

		SELECT max(ABB_CODIGO) CODIGO 
			FROM %table:ABB% ABB
		WHERE ABB_IDCFAL = %Exp:cIdcFal% 
				AND ABB_CODTEC = %Exp:cCodAtend% 
				AND ABB.%notDel%

	EndSql

	If (cAliasABB)->( !Eof() )
		cCodABB := (cAliasABB)->CODIGO
	EndIf

	(cAliasABB)->(DbCloseArea())

	If !Empty(cCodABB)

		BeginSql Alias cAliasTDV
			SELECT TDV.TDV_DTREF 
				FROM %table:TDV% TDV 
			WHERE TDV.TDV_CODABB = %Exp:cCodABB%
				  AND TDV.%notDel%		
		EndSql

		If (cAliasTDV)->( !Eof() )
			cDtAloc := (cAliasTDV)->TDV_DTREF
		EndIf

		(cAliasTDV)->(DbCloseArea())

	EndIf

EndIf

Return cDtAloc
