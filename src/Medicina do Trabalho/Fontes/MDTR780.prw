/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR780.ch"
#Include "Protheus.ch"
//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR780
Indices FAP (Fator Acidentario de Prevencao)

@author Denis Hyroshi de Souza
@since 24.06.03
@return Nil
/*/
//---------------------------------------------------------------------
User Function MDTR780()

	//------------------------------------------------------------
	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	//------------------------------------------------------------
	Local aNGBEGINPRM := NGBEGINPRM()

	Private cPerg  := "MDT780    "
	Private aDadosCus := {}
	Private cCadastro := STR0001 //"Índices FAP (Fator Acidentário de Prevenção)"
	Private cCnaeEmp  := SM0->M0_CNAE

	/*------------------------------
	//cPerg  						|
	|  De Ano						|
	|  Ate Ano					    |
	|  Calcular Indice de Custo ?	|
	--------------------------------*/

	If !AliasInDic('TYH')

		MsgStop( STR0045 ) //'O dicionário de dados está desatualizado, favor aplicar a atualização contida no pacote da issue DNG-1847'

	Else

		If pergunte(cPerg,.T.,cCadastro)
			If U_MDT78P03()
				Processa({|lEnd| MDT780PRC() })
			EndIf
		EndIf

	EndIf
	//------------------------------------------------------------
	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	//------------------------------------------------------------
	NGRETURNPRM(aNGBEGINPRM)

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT780PRC
Chama Relatório.

@author Denis Hyroshi de Souza
@since 24.06.03
@return
/*/
//---------------------------------------------------------------------
Static Function MDT780PRC()

	Local OldRot
	Local nInd
	Local oTempFAP
	Local lIntMDTGPE	:= Alltrim(GETMV("MV_MDTGPE")) == "S"
	Local nPos4 := 0
	Local nPos5 := 0
	Local nPos6 := 0
	Local nPos7 := 0
	Local nPos8 := 0
	Local nPos9 := 0
	Local nPos10 := 0
	Local nPos11 := 0
	Local nPos12 := 0
	Local nPos13 := 0
	Local nPos14 := 0
	Local nPos15 := 0
	Local nPos16 := 0
	Local aPos17 := {}
	Local cSubString := "%SUBSTR%"
	Local cSubStr2	 := "SUBSTR"
	Local nLenTMR	:= If( Len(TMR->TMR_CID) == 0, 8 , Len(TMR->TMR_CID) )

	Private cAliasFAP := GetNextAlias()
	Private aVETINR := {}  //Usado na criacao do arquivo temporario
	Private aDadosRel := {}

	//Verifica banco de dados para alterar o corte de string
	If "MSSQL" $ Upper(TCGetDB()) .Or. "SYBASE" $ Upper(TCGetDB())
		cSubString := "%SUBSTRING%"
		cSubStr2   := "SUBSTRING"
	Endif

	nRegTotal := ( SRA->(LastRec()) * (Mv_par02 - Mv_par01 + 1) * 13 )
	ProcRegua(nRegTotal)

	aDBF := {}
	aAdd( aDBF , { "ANO"     , "C", 04,0} )
	aAdd( aDBF , { "PERIODO" , "C", 25,0} )
	aAdd( aDBF , { "INDFREQ" , "N", 12,4} )
	aAdd( aDBF , { "VARFREQ" , "C", 10,0} )
	aAdd( aDBF , { "INDGRAV" , "N", 12,4} )
	aAdd( aDBF , { "VARGRAV" , "C", 10,0} )
	aAdd( aDBF , { "INDCUST" , "N", 16,4} )
	aAdd( aDBF , { "VARCUST" , "C", 10,0} )
	aAdd( aDBF , { "INDROTA" , "N", 12,4} )
	aAdd( aDBF , { "VARROTA" , "C", 10,0} )
	aAdd( aDBF , { "BENEFIC" , "N", 12,2} )
	aAdd( aDBF , { "REMUNER" , "N", 12,2} )

	oTempFAP := FWTemporaryTable():New( cAliasFAP, aDBF )
	oTempFAP:AddIndex( "1", {"ANO"} )
	oTempFAP:Create()

	For nInd := Mv_par01 To Mv_par02
		dDtIni := CtoD("01/01/"+StrZero(nInd-2,4))
		dDtFim := CtoD("01/01/"+StrZero(nInd,4)) - 1
		dDtPar := CtoD("01/01/"+StrZero(nInd-1,4))
		nAnIni := Year(dDtIni)
		nAnFim := Year(dDtFim)

		If nInd == 2009
			dDtIni := CtoD("01/04/2007")
		Endif

		// Zera valores a cada processamento
		nPos4 := 0
		nPos5 := 0
		nPos6 := 0
		nPos7 := 0
		nPos8 := 0
		nPos9 := 0
		nPos10 := 0
		nPos11 := 0
		nPos12 := 0
		nPos13 := 0
		nPos14 := 0
		nPos15 := 0
		nPos16 := 0
		aPos17 := {}

		cAliQry := GetNextAlias()

		/*
			Conta a Quantidade de Funcionários por Mês
		*/
		dDtTemp := dDtIni
		While dDtTemp <= dDtFim
			dInicPer := dDtTemp
			dFinaPer := MonthSum(dDtTemp,1) - 1
			nPos6++
			If lIntMDTGPE
				BeginSql Alias cAliQry
					SELECT COUNT( SRA.RA_MAT ) QTDFUN
					FROM %table:SRA% SRA
					WHERE SRA.RA_ADMISSA <= %exp:DTOS(dDtFim)% AND ( SRA.RA_DEMISSA >= %exp:DTOS(dDtIni)% OR SRA.RA_DEMISSA = '' ) AND SRA.%NotDel% AND
							SRA.RA_CATFUNC NOT IN ('A','E','P','G') AND
							SRA.RA_VIEMRAI <> '80' AND
							SRA.RA_TIPOADM NOT IN ('1A','1B','1C') AND
							SRA.RA_MAT NOT IN ( SELECT R8_MAT FROM %table:SR8%
											WHERE R8_DATAINI <= %exp:DTOS(dDtIni)% AND ( R8_DATAFIM >= %exp:DTOS(dDtFim)% OR R8_DATAFIM = '' AND %NotDel% ))
				EndSql
			Else
				BeginSql Alias cAliQry
					SELECT COUNT( SRA.RA_MAT ) QTDFUN
					FROM %table:SRA% SRA
					WHERE SRA.RA_ADMISSA <= %exp:DTOS(dDtFim)% AND ( SRA.RA_DEMISSA >= %exp:DTOS(dDtIni)% OR SRA.RA_DEMISSA = '' ) AND
							SRA.RA_CATFUNC NOT IN ('A','E','P','G') AND
							SRA.RA_VIEMRAI <> '80' AND
							SRA.RA_TIPOADM NOT IN ('1A','1B','1C') AND SRA.%NotDel%
				EndSql
			EndIf
			nPos5 += ( cAliQry )->QTDFUN
			( cAliQry )->( dbCloseArea() )
			dDtTemp := MonthSum(dDtTemp,1)
		End


		/*
			Query para Buscar os Acidentes
		*/
		BeginSql Alias cAliQry
			SELECT TM0.TM0_FILFUN,
				TM0.TM0_MAT,
				TNC.TNC_DTACID,
				TNC.TNC_VITIMA,
				TNC.TNC_DTOBIT,
				TNC.TNC_INDACI
			FROM   %table:TNC% TNC
			LEFT JOIN %table:TM0% TM0 ON TNC.TNC_FILFUN = TM0.TM0_FILFUN AND TNC.TNC_MAT = TM0.TM0_MAT AND TM0.%NotDel%
			WHERE TNC.%NotDel%
					AND TNC.TNC_NUMFIC <> ''
					AND TNC.TNC_CATINS <> ''
					AND TNC.TNC_DTACID BETWEEN %exp:DTOS(dDtIni)% AND %exp:DTOS(dDtFim)% AND TNC.%NotDel%
		EndSql

		While ( cAliQry )->( !EoF() )
			If ( cAliQry )->TNC_INDACI <> '2'
				nPos4++
			EndIf
			aAdd( aPos17 , { ( cAliQry )->TM0_FILFUN , ( cAliQry )->TM0_MAT , ( cAliQry )->TNC_DTACID , ;
												If(( cAliQry )->TNC_VITIMA=="3" .Or. !Empty(( cAliQry )->TNC_DTOBIT),.T.,.F.) } )
			( cAliQry )->( dbSkip() )
		End
		( cAliQry )->( dbCloseArea() )


		/*
			Query para Buscar os valores da SRA
		*/
		cAnIni := cValToChar(nAnIni)
		cAnFim := cValToChar(nAnFim)
		cAnIni := "%" + cSubStr2 + "(" + ValtoSQL(cAnIni) + ",1,4)%"
		cAnFim := "%" + cSubStr2 + "(" + ValtoSQL(cAnFim) + ",1,4)%"

		BeginSql Alias cAliQry
			SELECT SUM( CASE
						WHEN %exp:cSubString%(SRA.RA_ADMISSA,1,4) = %exp:cAnIni%
							THEN CASE
								WHEN SRA.RA_ADMISSA >= %exp:DTOS(dDtIni)%
									THEN 1
									ELSE 0
									END
							ELSE 0
						END ) Adm1Ano,
				SUM( CASE %exp:cSubString%(SRA.RA_ADMISSA,1,4)
						WHEN %exp:cAnFim%
							THEN 1
							ELSE 0
						END ) Adm2Ano,
				SUM( CASE %exp:cSubString%(SRA.RA_DEMISSA,1,4)
						WHEN %exp:cAnIni%
							THEN 1
							ELSE 0
						END ) Dem1Ano,
				SUM( CASE %exp:cSubString%(SRA.RA_DEMISSA,1,4)
						WHEN %exp:cAnFim%
							THEN 1
							ELSE 0
						END ) Dem2Ano,
				SUM( CASE
						WHEN SRA.RA_ADMISSA <= %exp:DTOS(dDtIni)% AND (SRA.RA_DEMISSA >= %exp:DTOS(dDtIni)% OR SRA.RA_DEMISSA = '' )
							THEN 1
							ELSE 0
						END ) Ati1Ano,
				SUM( CASE
						WHEN SRA.RA_ADMISSA <= %exp:DTOS(dDtPar)% AND (SRA.RA_DEMISSA >= %exp:DTOS(dDtPar)% OR SRA.RA_DEMISSA = '' )
							THEN 1
							ELSE 0
						END ) Ati2Ano,
				SUM( CASE
						WHEN SRA.RA_SITFOLH IN ('D','E') AND SRA.RA_RESCRAI IN ('62','64') AND
							SRA.RA_DEMISSA >= %exp:DTOS(dDtIni)% AND SRA.RA_DEMISSA <= %exp:DTOS(dDtFim)%
							THEN 1
							ELSE 0
						END ) Morte,
				SUM( CASE
						WHEN SRA.RA_SITFOLH IN ('D','E') AND SRA.RA_RESCRAI IN ('73','74') AND
							SRA.RA_DEMISSA >= %exp:DTOS(dDtIni)% AND SRA.RA_DEMISSA <= %exp:DTOS(dDtFim)%
							THEN 1
							ELSE 0
						END ) Invalidez
			FROM %table:SRA% SRA
			WHERE SRA.RA_ADMISSA <= %exp:DTOS(dDtFim)% AND ( SRA.RA_DEMISSA >= %exp:DTOS(dDtIni)% OR SRA.RA_DEMISSA = '' ) AND
					SRA.RA_CATFUNC NOT IN ('A','E','P','G') AND
					SRA.RA_VIEMRAI <> '80' AND
					SRA.RA_TIPOADM NOT IN ('1A','1B','1C') AND SRA.%NotDel%
		EndSql
		nPos8  := ( cAliQry )->Invalidez
		nPos9  := ( cAliQry )->Morte
		nPos11 := ( cAliQry )->Adm1Ano
		nPos12 := ( cAliQry )->Adm2Ano
		nPos13 := ( cAliQry )->Dem1Ano
		nPos14 := ( cAliQry )->Dem2Ano
		nPos15 := ( cAliQry )->Ati1Ano
		nPos16 := ( cAliQry )->Ati2Ano
		( cAliQry )->( dbCloseArea() )


		/*
			Query para Buscar as demissões
		*/
		BeginSql Alias cAliQry
			SELECT SRA.RA_FILIAL, SRA.RA_MAT, SRA.RA_DEMISSA
			FROM %table:SRA% SRA
			WHERE SRA.RA_ADMISSA <= %exp:DTOS(dDtFim)% AND ( RA_DEMISSA >= %exp:DTOS(dDtIni)% OR RA_DEMISSA = '' ) AND
					SRA.RA_DEMISSA >= %exp:DTOS(dDtIni)% AND SRA.RA_DEMISSA <= %exp:DTOS(dDtFim)% AND
					SRA.RA_CATFUNC NOT IN ('A','E','P','G') AND
					SRA.RA_VIEMRAI <> '80' AND
					SRA.RA_TIPOADM NOT IN ('1A','1B','1C') AND
					SRA.RA_SITFOLH IN ('D','E') AND SRA.RA_RESCRAI IN ('62','64','73','74') AND SRA.%NotDel%
		EndSql
		While ( cAliQry )->( !EoF() )
			If aScan(aPos17, {|x| x[1]+x[2] == ( cAliQry )->RA_FILIAL+( cAliQry )->RA_MAT .And. SToD( cValToChar( ( cAliQry )->RA_DEMISSA ) ) < SToD( cValToChar( x[3] ) ) +10 }) == 0
				nPos4 ++ //CAT, Morte ou Invalidez
				aAdd( aPos17 , { ( cAliQry )->RA_FILIAL , ( cAliQry )->RA_MAT , ( cAliQry )->RA_DEMISSA , .T. } )
			Endif
			( cAliQry )->( dbSkip() )
		End
		( cAliQry )->( dbCloseArea() )


		/*
				Busca as Ausências
		*/
		BeginSql Alias cAliQry
			SELECT SRA.RA_FILIAL, SRA.RA_MAT, SR8.R8_DATAINI,SR8.R8_CID,TNY.TNY_CID FROM %table:SR8% SR8
				JOIN %table:SRA% SRA ON SR8.R8_MAT = SRA.RA_MAT AND SR8.R8_FILIAL = SRA.RA_FILIAL AND SRA.%NotDel%
				LEFT JOIN %table:TM0% TM0 ON TM0.TM0_FILFUN = SRA.RA_FILIAL AND TM0.TM0_MAT = SRA.RA_MAT AND TM0.TM0_NUMDEP = '' AND TM0.%NotDel%
				LEFT JOIN %table:TNY% TNY ON TNY.TNY_NUMFIC = TM0.TM0_NUMFIC AND
							TNY.TNY_CID <> '' AND ( TNY.TNY_DTINIC = SR8.R8_DATAINI OR TNY.TNY_DTSAI2 = SR8.R8_DATAINI OR TNY.TNY_DTSAI3 = SR8.R8_DATAINI ) AND TNY.%NotDel%
				LEFT JOIN %table:RCM% RCM ON TNY.TNY_CODAFA = RCM.RCM_TIPO AND RCM.RCM_CODSEF IN ('O','P') AND RCM.%NotDel%
				WHERE
					SRA.RA_ADMISSA <= %exp:DTOS(dDtFim)% AND ( SRA.RA_DEMISSA >= %exp:DTOS(dDtIni)% OR SRA.RA_DEMISSA = '' ) AND
					SRA.RA_CATFUNC NOT IN ('A','E','P','G') AND
					SRA.RA_VIEMRAI <> '80' AND
					SRA.RA_TIPOADM NOT IN ('1A','1B','1C') AND
					SR8.R8_DATAINI >= %exp:DTOS(dDtIni)% AND SR8.R8_DATAFIM <= %exp:DTOS(dDtFim)% AND
					SR8.R8_DURACAO > 15 AND SR8.R8_TIPO IN ('O','P') AND SR8.%NotDel%
		EndSql

		While ( cAliQry )->( !EoF() )
			nPos7++
			//Verificar Nexo Causal
			cCodCID := If( !Empty(( cAliQry )->R8_CID) , ;
							( cAliQry )->R8_CID , ;
							If( !Empty( ( cAliQry )->TNY_CID ) , ( cAliQry )->TNY_CID , "" ) )
			lNexo   := MDT82NEXO( PadR(cCodCID,nLenTMR) , cCnaeEmp , 0 )
			If lNexo .And. aScan(aPos17, {|x| x[1]+x[2] == ( cAliQry )->RA_FILIAL+( cAliQry )->RA_MAT .And. SToD( cValToChar( ( cAliQry )->R8_DATAINI ) ) < STOD( cValToChar( x[3] ) ) + 10 }) == 0
				nPos4 ++ //CAT, Morte ou Invalidez
				aAdd( aPos17 , { ( cAliQry )->RA_FILIAL , ( cAliQry )->RA_MAT , ( cAliQry )->R8_DATAINI , .T. } )
			Endif
			( cAliQry )->( dbSkip() )
		End
		( cAliQry )->( dbCloseArea() )

		aAdd( aDadosRel , { nInd , ; //1. Ano FAP
							dDtIni , ; //2. Data Inicio
							dDtFim , ; //3. Data Fim
							nPos4 , ; // 4. Contagem de Acidentes + Beneficios
							nPos5 , ; // 5. Contagem de Funcionarios (Total periodo)
							nPos6 , ; // 6. Quantidade de meses no periodo
							nPos7 , ; // 7. Contagem de B91
							nPos8 , ; // 8. Contagem de B92 (Invalidez 73 e 74)
							nPos9 , ; // 9. Contagem de B93 (Morte 62 e 64)
							nPos10 , ; //10. Contagem de B94
							nPos11 , ; //11. Contagem de Admitidos no primeiro ano
							nPos12 , ; //12. Contagem de Admitidos no segundo ano
							nPos13 , ; //13. Contagem de Demitidos no primeiro ano
							nPos14 , ; //14. Contagem de Demitidos no segundo ano
							nPos15 , ; //15. Contagem de Ativos no inicio do primeiro ano
							nPos16 , ; //16. Contagem de Ativos no inicio do primeiro ano
							aPos17   ; //17. Acidentes
							} )
	Next nInd

	If Len(aDadosRel) == 0
		Return .F.
	Endif
	/*
	- Índice de freqüência = número de acidentes registrados em cada empresa, mais os benefícios que entraram
							sem CAT vinculada, por nexo técnico / número médio de vínculos x 1.000 (mil).

	- Índice de gravidade  = (número de benefícios auxílio doença por acidente (B91) x 0,1 + número de benefícios
							por invalidez (B92) x 0,3 + número de benefícios por morte (B93) x 0,5 + o número de
							benefícios auxílio-acidente (B94) x 0,1) / número médio de vínculos x 1.000 (mil).

	- Índice de custo      = valor total de benefícios / valor total deremuneração paga pelo estabelecimento aos
							segurados x 1.000 (mil).

	- Taxa de rotatividade anual = mínimo (número de rescisões ocorridas no ano ou número de admissões ocorridas no ano)/número
								de vínculos no início do ano x 100 (cem)
								Em seguida, calcula-se a taxa média de rotatividade da seguinte maneira:
								Taxa média de rotatividade = média das taxas de rotatividade anuais dos últimos dois anos
	*/

	aSalvo := {0,0,0,0}
	For nInd := 1 To Len(aDadosRel)
		nNumVinculo := Round( aDadosRel[nInd,5] / aDadosRel[nInd,6] , 10 )
		nValMin1    := If( aDadosRel[nInd,13] < aDadosRel[nInd,11] , aDadosRel[nInd,13] , aDadosRel[nInd,11] ) / aDadosRel[nInd,15] * 100
		nValMin2    := If( aDadosRel[nInd,14] < aDadosRel[nInd,12] , aDadosRel[nInd,14] , aDadosRel[nInd,12] ) / aDadosRel[nInd,16] * 100
		(cAliasFAP)->(DbAppend())
		(cAliasFAP)->ANO     := StrZero(aDadosRel[nInd,1],4)
		(cAliasFAP)->PERIODO := DtoC(aDadosRel[nInd,2]) + STR0014 + DtoC(aDadosRel[nInd,3]) //" a "
		(cAliasFAP)->INDFREQ := aDadosRel[nInd,4] / nNumVinculo * 1000
		(cAliasFAP)->INDGRAV := ( (aDadosRel[nInd,7]*0.1) + (aDadosRel[nInd,8]*0.3) + ;
								(aDadosRel[nInd,9]*0.5) + (aDadosRel[nInd,10]*0.1) ) / nNumVinculo * 1000
		nPosi := aScan(aDadosCus, {|x| x[1] == aDadosRel[nInd,1] })
		If nPosi > 0
			(cAliasFAP)->INDCUST := aDadosCus[nPosi,3] / aDadosCus[nPosi,4] * 1000
		Endif
		(cAliasFAP)->INDROTA := (nValMin1 + nValMin2) / 2
		If nInd > 1
			If aSalvo[1] <> 0 .And. (cAliasFAP)->INDFREQ <> 0
				nTemp := ((100 / aSalvo[1]) * (cAliasFAP)->INDFREQ) - 100
				nSinal := If(nTemp > 0 , "+" , "" )
				(cAliasFAP)->VARFREQ := nSinal+Alltrim(Transform( nTemp , "@E 9,999,999.9"))+ " %"
			Else
				(cAliasFAP)->VARFREQ := PadL("-",8)
			Endif
			If aSalvo[2] <> 0 .And. (cAliasFAP)->INDGRAV <> 0
				nTemp := ((100 / aSalvo[2]) * (cAliasFAP)->INDGRAV) - 100
				nSinal := If(nTemp > 0 , "+" , "" )
				(cAliasFAP)->VARGRAV := nSinal+Alltrim(Transform( nTemp , "@E 9,999,999.9"))+ " %"
			Else
				(cAliasFAP)->VARGRAV := PadL("-",8)
			Endif
			If aSalvo[3] <> 0 .And. (cAliasFAP)->INDCUST <> 0
				nTemp := ((100 / aSalvo[3]) * (cAliasFAP)->INDCUST) - 100
				nSinal := If(nTemp > 0 , "+" , "" )
				(cAliasFAP)->VARCUST := nSinal+Alltrim(Transform( nTemp , "@E 9,999,999.9"))+ " %"
			Else
				(cAliasFAP)->VARCUST := PadL("-",8)
			Endif
			If aSalvo[4] <> 0 .And. (cAliasFAP)->INDROTA <> 0
				nTemp := ((100 / aSalvo[4]) * (cAliasFAP)->INDROTA) - 100
				nSinal := If(nTemp > 0 , "+" , "" )
				(cAliasFAP)->VARROTA := nSinal+Alltrim(Transform( nTemp , "@E 9,999,999.9"))+ " %"
			Else
				(cAliasFAP)->VARROTA := PadL("-",8)
			Endif
		Else
			(cAliasFAP)->VARFREQ := PadL("-",8)
			(cAliasFAP)->VARGRAV := PadL("-",8)
			(cAliasFAP)->VARCUST := PadL("-",8)
			(cAliasFAP)->VARROTA := PadL("-",8)
		Endif
		aSalvo := { (cAliasFAP)->INDFREQ , (cAliasFAP)->INDGRAV , (cAliasFAP)->INDCUST , (cAliasFAP)->INDROTA }
	Next nInd

	dbSelectArea(cAliasFAP)
	dbGoTop()

	aNgCadBt := {}
	Aadd(aNgCadBt,{"GRAF2D"		,{|| U_fGrafico()  }, STR0002	}) //"Gráfico"
	Aadd(aNgCadBt,{"RELATORIO"	,{|| fImprimir() }, STR0003  }) //"Imprimir"

	DEFINE MSDIALOG oDlg1 TITLE cCadastro FROM 6,0 TO 500,750 Of oMainwnd Pixel
	oDlg1:lEscClose := .F.

		oPnlAll := TPanel():New( , , , oDlg1 , , , , , , , , .F. , .F. )
						oPnlAll:Align := CONTROL_ALIGN_ALLCLIENT

		If Len(aDadosCus) > 0
			@ 01,0.3 LISTBOX oObjFAP FIELDS	ANO ,;
									PERIODO ,;
									PADL(Transform(INDFREQ,"@E 9,999,999.9999"),15) ,;
									VARFREQ ,;
									PADL(Transform(INDGRAV,"@E 9,999,999.9999"),15) ,;
									VARGRAV ,;
									Transform(INDCUST,"@E 9,999,999,999.9999") ,;
									VARCUST ,;
									PADL(Transform(INDROTA,"@E 9,999,999.9999"),15) ,;
									VARROTA ;
							FieldSizes 50,70,40,40,40,40,40,40,40,40 ;
							HEADERS  STR0004,; //"Ano"
										STR0005,; //"Período"
										STR0006,; //"Frequência"
										STR0007,; //"Var."
										STR0008,; //"Gravidade"
										STR0007,; //"Var."
										STR0022,; //"Custo (R$)"
										STR0007,; //"Var."
										STR0010,; //"Rotatividade"
										STR0007 ;//"Var."
							Of oPnlAll Pixel
		Else
			@ 01,0.3 LISTBOX oObjFAP FIELDS	ANO ,;
									PERIODO ,;
									PADL(Transform(INDFREQ,"@E 9,999,999.9999"),15) ,;
									VARFREQ ,;
									PADL(Transform(INDGRAV,"@E 9,999,999.9999"),15) ,;
									VARGRAV ,;
									PADL(Transform(INDROTA,"@E 9,999,999.9999"),15) ,;
									VARROTA ;
							FieldSizes 50,70,40,40,40,40,40,40, ;
							HEADERS  STR0004,; //"Ano"
										STR0005,; //"Período"
										STR0006,; //"Frequência"
										STR0007,; //"Var."
										STR0008,; //"Gravidade"
										STR0007,; //"Var."
										STR0010,; //"Rotatividade"
										STR0007 ; //"Var."
						Of oPnlAll Pixel
		Endif

		oObjFAP:Align := CONTROL_ALIGN_ALLCLIENT

	ACTIVATE MSDIALOG oDlg1 ON INIT EnchoiceBar(oDlg1,{||oDlg1:End()},{||oDlg1:End()},,aNgCadBt) CENTERED

	oTempFAP:Delete()

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT78P01
Valida De/Ate Ano

@param nTipo - Tipo do relatório.

@author Andre E.Perez Alvarez
@since 29/09/2009
@return .T.
/*/
//---------------------------------------------------------------------
User Function MDT78P01(nTipo)

	If nTipo == 1
		If Mv_par01 < 100
			If Mv_par01 >= 50
				Mv_par01 := Mv_par01 + 1900
			Else
				Mv_par01 := Mv_par01 + 2000
			Endif
		Endif
		If Mv_par01 < 2009
			If !MsgNoYes(STR0011,STR0012) //"O cálculo do FAP teve início em 2009, mesmo assim, deseja visualizar as informações do ano informado?"###"Ano Inválido"
				Return .F.
			Endif
		Endif
		If Mv_par01 > Year(dDataBase)+1
			MsgInfo(STR0013,STR0012) //"Não existem informações suficientes para calcular o FAP do ano informado, pois devem conter informações dos dois anos anteriores."###"Ano Inválido"
			Return .F.
		Endif
		If Mv_par01 > Mv_par02
			Mv_par02 := Mv_par01
		Endif
	Else
		If Mv_par02 < 100
			If Mv_par02 >= 50
				Mv_par02 := Mv_par02 + 1900
			Else
				Mv_par02 := Mv_par02 + 2000
			Endif
		Endif
		If Mv_par02 < 2009
			If !MsgNoYes(STR0011,STR0012) //"O cálculo do FAP teve início em 2009, mesmo assim, deseja visualizar as informações do ano informado?"###"Ano Inválido"
				Return .F.
			Endif
		Endif
		If Mv_par02 > Year(dDataBase)+1
			MsgInfo(STR0013,STR0012) //"Não existem informações suficientes para calcular o FAP do ano informado, pois devem conter informações dos dois anos anteriores."###"Ano Inválido"
			Return .F.
		Endif
		If Mv_par01 > Mv_par02
			Mv_par01 := Mv_par02
		Endif
	Endif

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT78P03
Valida parametro mv_par03, caso seja 1 traz os registros das tabela
TYH (Tabela de custos FAP) do intervalo de anos selecionado.

@author Andre E.Perez Alvarez
@since 29/09/2009
@return .T.
/*/
//---------------------------------------------------------------------
User Function MDT78P03()

	Local nInd
	Local dDtIni, dDtFim, nPos1, nBenef, nRemun, cMemo, cTxtUso
	Local l_Eof, nCol, aTemp, nLen
	Local oPnlFap
	Local lTem
	Local lRet := .T.

	If Mv_par03 == 1

		dbSelectArea("TYH")
		dbSetOrder(1)
		For nInd := Mv_par01 To Mv_par02  //Intervalo de anos passado como parâmetro

			nBenef := 0
			nRemun := 0

			//Intervalo dos dois utimos anos antes do ano corrente
			dDtIni := CtoD("01/01/"+StrZero(nInd-2,4))
			dDtFim := CtoD("01/01/"+StrZero(nInd,4)) - 1
			If nInd == 2009
				dDtIni := CtoD("01/04/2007")
			Endif

			//Se houver registros de custos daquele ano pega os registros, se não mostra zerado
			If dbSeek(xFilial("TYH")+cValToChar(nInd))

				nBenef := TYH->TYH_BENEF
				nRemun := TYH->TYH_REMUN

			EndIf

			aAdd( aDadosCus , { nInd , ; //1. Ano FAP
										DtoC(dDtIni) + STR0014 + DtoC(dDtFim) , ; //2. Periodo //" a "
										nBenef , ; //3. Valor pago em beneficios
										nRemun } ) //4. Valor da remuneracao dos funcionarios

		Next nInd

		If Len(aDadosCus) == 0
			aDadosCus := {}
			Mv_par03  := 2
			MsgInfo(STR0015) //"De Ano ou Até Ano inválido."
			Return Nil
		Endif

		nConfCus := 0
		DEFINE MSDIALOG oDlgPar TITLE cCadastro FROM 6,0 TO 28,70 Of oMainwnd COLOR CLR_BLACK,CLR_WHITE
		oDlgPar:lEscClose := .F.

			oPnlFap							:=	tPanel():New(00,00,,oDlgPar,,.F.)
			oPnlFap:Align					:= CONTROL_ALIGN_ALLCLIENT

			@ 05,013 Say STR0016 Of oPnlFap Pixel //"Informar o custo dos benefícios por afastamento cobertos pela Previdência (Benefícios) e"
			@ 14,013 Say STR0017 Of oPnlFap Pixel //"informar o valor total de remuneração paga pelo estabelecimento aos segurados (Remuneração)."

			oListExa							:= VCBrowse():New( 28 , 013, 255, 90,,{STR0018,STR0019,STR0020,STR0021},{40,80,60,50},; //'Ano'###'Período'###'Benefícios (R$)'###'Remuneração (R$)'
													oPnlFap,,,,,{||},,,,,,,.F.,,.T.,,.F.,,.T.,.T.)
			oListExa:SetArray(aDadosCus)
			bListExa							:= { || { StrZero(aDadosCus[oListExa:nAt,1],4), aDadosCus[oListExa:nAt,2] ,;
															TransForm(aDadosCus[oListExa:nAt,3],"@E 999,999,999.99"),;
															TransForm(aDadosCus[oListExa:nAt,4],"@E 999,999,999.99") } }
			oListExa:bLine:= bListExa
			oListExa:bLDblClick := {|| fMarkVCB(oListExa:nColPos) }
		ACTIVATE MSDIALOG oDlgPar ON INIT EnchoiceBar(oDlgPar,{|| (oDlgPar:End(),nConfCus:=1)},{|| oDlgPar:End()}) CENTERED

		lTem := .F.
		//Grava na tabela de custos
		dbSelectArea("TYH")
		dbSetOrder(1)
		For nInd := 1 To Len(aDadosCus)
			If nConfCus == 1
				If aDadosCus[nInd,3] > 0 .Or. aDadosCus[nInd,4] > 0

					lTem := .T.

					lSeek := dbSeek(xFilial("TYH")+cValToChar(aDadosCus[nInd,1]))
					If !lSeek .Or. ( lSeek .And. ( TYH->TYH_BENEF <> aDadosCus[nInd,3] .Or.;
						TYH->TYH_REMUN <> aDadosCus[nInd,4] ) ) //Se não houver registro daquele ano ou o registro tiver sido modificao

						If lSeek
							RecLock("TYH",.F.)
						Else
							RecLock("TYH",.T.)
							TYH->TYH_FILIAL := xFilial("TYH")
							TYH->TYH_ANO := cValToChar(aDadosCus[nInd,1])
						EndIf
						TYH->TYH_BENEF := aDadosCus[nInd,3]
						TYH->TYH_REMUN := aDadosCus[nInd,4]
						TYH->(MsUnlock())

					EndIf

				Endif
			Endif
		Next nInd

		If !lTem .Or. nConfCus == 0
			aDadosCus := {}
			Mv_par03  := 2
		Endif

	Else
		aDadosCus := {}
	EndIf

Return lRet

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT78P03
Funcao para editar valor do list box

@param _nColPos - Posição.

@author Denis Hyroshi de Souza
@since 09/05/08
@return .T.
/*/
//---------------------------------------------------------------------
Static Function fMarkVCB(_nColPos)

	If _nColPos == 3
		lEditCell(@aDadosCus,oListExa,"@E 999,999,999.99",3)
		oListExa:REFRESH()
	ElseIf _nColPos == 4
		lEditCell(@aDadosCus,oListExa,"@E 999,999,999.99",4)
		oListExa:REFRESH()
	Endif

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} fImprimir
Funcao imprimir os indices

@author Denis Hyroshi de Souza
@since 09/05/08
@return .T.
/*/
//---------------------------------------------------------------------
Static Function fImprimir()
				`
	Local aArea := GetArea(),nX
	Private oPrint
	Private oFont12,oFont13,oFont20
	Private lin
	oFont08	:= TFont():New("Arial",07,07,,.F.,,,,.F.,.F.)
	oFont12	:= TFont():New("Arial",09,09,,.T.,,,,.F.,.F.)
	oFont13	:= TFont():New("Arial",08,08,,.F.,,,,.F.,.F.)
	oFont20	:= TFont():New("Arial",12,12,,.T.,,,,.F.,.F.)
	oFont15	:= TFont():New("Arial",12,12,,.T.,,,,.F.,.F.)
	oFont14	:= TFont():New("Arial",12,12,,.F.,,,,.F.,.F.)

	oPrint	:= TMSPrinter():New(OemToAnsi(cCadastro))
	oPrint:SetPortRait()
	oPrint:Setup()

	dbSelectArea(cAliasFAP)
	dbGoTop()
	lin := 9999
	nPag1 := 0
	lNaoImpr := .T.
	dbSelectArea(cAliasFAP)
	dbGoTop()
	While !Eof()
		Somalin1(60,.T.)
		oPrint:Say(lin,0110,(cAliasFAP)->ANO,oFont13)
		oPrint:Say(lin,0310,(cAliasFAP)->PERIODO,oFont13)
		oPrint:Say(lin,0800,Transform((cAliasFAP)->INDFREQ,"@E 9,999,999.9999"),oFont13,,,,1)
		oPrint:Say(lin,0870,(cAliasFAP)->VARFREQ,oFont13)
		oPrint:Say(lin,1230,Transform((cAliasFAP)->INDGRAV,"@E 9,999,999.9999"),oFont13,,,,1)
		oPrint:Say(lin,1300,(cAliasFAP)->VARGRAV,oFont13)
		If Len(aDadosCus) > 0
			oPrint:Say(lin,1640,Transform((cAliasFAP)->INDCUST,"@E 9,999,999.9999"),oFont13,,,,1)
			oPrint:Say(lin,1730,(cAliasFAP)->VARCUST,oFont13)
			oPrint:Say(lin,2070,Transform((cAliasFAP)->INDROTA,"@E 9,999,999.9999"),oFont13,,,,1)
			oPrint:Say(lin,2110,(cAliasFAP)->VARROTA,oFont13)
		Else
			oPrint:Say(lin,1700,Transform((cAliasFAP)->INDROTA,"@E 9,999,999.9999"),oFont13,,,,1)
			oPrint:Say(lin,1730,(cAliasFAP)->VARROTA,oFont13)
		Endif

		dbSelectArea(cAliasFAP)
		dbSkip()
	End

	dbSelectArea(cAliasFAP)
	dbGoTop()

	For nX := 1 To Len(aDadosRel)
		lin := 9999
		Somalin1(60,.F.)
		lin += 100
		oPrint:Say(lin,0110,STR0032,oFont15) //"FAP:"
		oPrint:Say(lin,1100,StrZero(aDadosRel[nX,1],4),oFont14)
		Somalin1(60,.F.)
		oPrint:Say(lin,0110,STR0033,oFont15) //"Período:"
		oPrint:Say(lin,1100,DtoC(aDadosRel[nX,2])+" à "+DtoC(aDadosRel[nX,3]),oFont14)
		Somalin1(60,.F.)
		oPrint:Say(lin,0110,STR0034,oFont15) //"Nº Acidentes com CAT / Benefícios sem CAT:"
		oPrint:Say(lin,1100,Alltrim(Transform(aDadosRel[nX,4],"@E 9,999,999.99")),oFont14)
		Somalin1(60,.F.)
		oPrint:Say(lin,0110,STR0035,oFont15) //"Nº Médio de vínculos (Funcion. por mês):"
		nNumMed := aDadosRel[nX,5] / aDadosRel[nX,6]
		nPosDec := At(".",cValtoChar(nNumMed))
		nTamDec := If(nPosDec > 0,If(Len(cValtoChar(nNumMed)) - nPosDec <= 2,2,Len(cValtoChar(nNumMed)) - nPosDec),2)
		oPrint:Say(lin,1100,Alltrim(Transform(nNumMed,"@E 9,999,999." + Replicate("9",nTamDec))),oFont14)
		Somalin1(60,.F.)
		oPrint:Say(lin,0110,STR0036+" B91:",oFont15) //"Nº Benefícios"
		oPrint:Say(lin,1100,Alltrim(Transform(aDadosRel[nX,7],"@E 9,999,999.99")),oFont14)
		Somalin1(60,.F.)
		oPrint:Say(lin,0110,STR0036+" B92:",oFont15) //"Nº Benefícios"
		oPrint:Say(lin,1100,Alltrim(Transform(aDadosRel[nX,8],"@E 9,999,999.99")),oFont14)
		Somalin1(60,.F.)
		oPrint:Say(lin,0110,STR0036+" B93:",oFont15) //"Nº Benefícios"
		oPrint:Say(lin,1100,Alltrim(Transform(aDadosRel[nX,9],"@E 9,999,999.99")),oFont14)
		Somalin1(60,.F.)
		oPrint:Say(lin,0110,STR0036+" B94:",oFont15) //"Nº Benefícios"
		oPrint:Say(lin,1100,Alltrim(Transform(aDadosRel[nX,10],"@E 9,999,999.99")),oFont14)
		Somalin1(60,.F.)
		oPrint:Say(lin,0110,STR0037+" "+StrZero(Year(aDadosRel[nX,2]),4)+":",oFont15) //"Nº Admissões"
		oPrint:Say(lin,1100,Alltrim(Transform(aDadosRel[nX,11],"@E 9,999,999.99")),oFont14)
		Somalin1(60,.F.)
		oPrint:Say(lin,0110,STR0037+" "+StrZero(Year(aDadosRel[nX,3]),4)+":",oFont15) //"Nº Admissões"
		oPrint:Say(lin,1100,Alltrim(Transform(aDadosRel[nX,12],"@E 9,999,999.99")),oFont14)
		Somalin1(60,.F.)
		oPrint:Say(lin,0110,STR0038+" "+StrZero(Year(aDadosRel[nX,2]),4)+":",oFont15) //"Nº Rescisões"
		oPrint:Say(lin,1100,Alltrim(Transform(aDadosRel[nX,13],"@E 9,999,999.99")),oFont14)
		Somalin1(60,.F.)
		oPrint:Say(lin,0110,STR0038+" "+StrZero(Year(aDadosRel[nX,3]),4)+":",oFont15) //"Nº Rescisões"
		oPrint:Say(lin,1100,Alltrim(Transform(aDadosRel[nX,14],"@E 9,999,999.99")),oFont14)
		Somalin1(60,.F.)
		oPrint:Say(lin,0110,STR0039+" "+StrZero(Year(aDadosRel[nX,2]),4)+":",oFont15) //"Nº Vínculos no início de"
		oPrint:Say(lin,1100,Alltrim(Transform(aDadosRel[nX,15],"@E 9,999,999.99")),oFont14)
		Somalin1(60,.F.)
		oPrint:Say(lin,0110,STR0039+" "+StrZero(Year(aDadosRel[nX,3]),4)+":",oFont15) //"Nº Vínculos no início de"
		oPrint:Say(lin,1100,Alltrim(Transform(aDadosRel[nX,16],"@E 9,999,999.99")),oFont14)
		nPosi := aScan(aDadosCus, {|x| x[1] == aDadosRel[nX,1] })
		If nPosi > 0
			Somalin1(60,.F.)
			oPrint:Say(lin,0110,STR0040,oFont15) //"Valor pago em benefícios:"
			oPrint:Say(lin,1100,Alltrim(Transform(aDadosCus[nPosi,3],"@E 999,999,999,999.99")),oFont14)
			Somalin1(60,.F.)
			oPrint:Say(lin,0110,STR0041,oFont15) //"Valor da remuneração dos funcionários:"
			oPrint:Say(lin,1100,Alltrim(Transform(aDadosCus[nPosi,4],"@E 999,999,999,999.99")),oFont14)
		Endif
	Next nX

	If !lNaoImpr
		oPrint:EndPage()
	Endif

	oPrint:Preview()
	RestArea(aArea)

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} Somalin1
Somalinha

@param nLinha - Linha.
@param lCabec - Cabeçalho.

@author Denis Hyroshi de Souza
@since 09/05/08
@return .T.
/*/
//---------------------------------------------------------------------
Static Function Somalin1(nLinha,lCabec)

	Local cPathSiga := GetPvProfString( GetEnvServer(), "StartPath", "ERROR", GetADV97() )
	Local cSMCOD := FWGrpCompany()
	Local cSMFIL := FWCodFil()
	lin += nLinha
	If lin > 2300
		If !lNaoImpr
			oPrint:EndPage()
		Endif
		nPag1++
		oPrint:StartPage()

		cFileLogo := cPathSiga+"lgrl"+cSMCOD+cSMFIL+".bmp"
		If File(cFileLogo)
			oPrint:sayBitMap(150,150,cFileLogo,370,120)
		Else
			cFileLogo := cPathSiga+"lgrl"+cSMCOD+".bmp"
			If File(cFileLogo)
				oPrint:sayBitMap(150,150,cFileLogo,370,120)
			Endif
		EndIf

		lin := 200
		oPrint:Say(lin,800,cCadastro,oFont20)
		lin := 320
		If lCabec
			oPrint:Line(lin-10,100,lin-10,3100)
			oPrint:Line(lin+60,100,lin+60,3100)
			oPrint:Say(lin,0110,STR0004,oFont12) //"Ano"
			oPrint:Say(lin,0310,STR0005,oFont12) //"Período"
			oPrint:Say(lin,0800,STR0006,oFont12,,,,1) //"Frequência"
			oPrint:Say(lin,0870,STR0007,oFont12) //"Var."
			oPrint:Say(lin,1230,STR0008,oFont12,,,,1) //"Gravidade"
			oPrint:Say(lin,1300,STR0007,oFont12) //"Var."
			If Len(aDadosCus) > 0
				oPrint:Say(lin,1640,STR0022,oFont12,,,,1) //"Custo (R$)"
				oPrint:Say(lin,1730,STR0007,oFont12) //"Var."
				oPrint:Say(lin,2070,STR0010,oFont12,,,,1) //"Rotatividade"
				oPrint:Say(lin,2110,STR0007,oFont12) //"Var."
			Else
				oPrint:Say(lin,1700,STR0010,oFont12,,,,1) //"Rotatividade"
				oPrint:Say(lin,1730,STR0007,oFont12) //"Var."
			Endif
			lin := 400
		Endif
		lNaoImpr := .F.
	Endif

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} fGrafico
Monta o Grafico das perguntas

@author Denis Hyroshi de Souza
@since 11/04/2000
@return .T.
/*/
//---------------------------------------------------------------------
User Function fGrafico()

	Local oTempGRF

	dbSelectArea(cAliasFAP)
	dbGoTop()

	If RecCount() == 0
		Help(" ",1,"NGTDADGRAF") //"Nao existem dados para montar o grafico..."###"Atencao"
		return .T.
	Endif

	cAliasGRF := GetNextAlias()
	aNiveis := {STR0006,STR0008,STR0010} //"Frequência"###"Gravidade"###"Rotatividade"
	aDBF3 := { {"CODIGO" , "C", 04,0} ,;
			{"NOMECOD", "C", 25,0} ,;
			{"VALOR1" , "N", 12,4} ,;
			{"VALOR2" , "N", 12,4} ,;
			{"VALOR3" , "N", 12,4}}
	If Len(aDadosCus) > 0
		aAdd( aDBF3, {"VALOR4" , "N", 12,4} )
		aNiveis := {STR0006,STR0008,STR0009,STR0010} //"Frequência"###"Gravidade"###"Custo"###"Rotatividade"
	Endif

	oTempGRF := FWTemporaryTable():New( cAliasGRF, aDBF3 )
	oTempGRF:AddIndex( "1", {"CODIGO"} )
	oTempGRF:Create()

	dbSelectArea(cAliasFAP)
	dbGoTop()
	While !eof()
		(cAliasGRF)->(DbAppend())
		(cAliasGRF)->CODIGO  := (cAliasFAP)->ANO
		(cAliasGRF)->NOMECOD := (cAliasFAP)->PERIODO
		(cAliasGRF)->VALOR1  := (cAliasFAP)->INDFREQ
		(cAliasGRF)->VALOR2  := (cAliasFAP)->INDGRAV
		If Len(aDadosCus) > 0
			(cAliasGRF)->VALOR3  := (cAliasFAP)->INDCUST
			(cAliasGRF)->VALOR4  := (cAliasFAP)->INDROTA
		Else
			(cAliasGRF)->VALOR3  := (cAliasFAP)->INDROTA
		Endif
		dbSelectArea(cAliasFAP)
		dbSkip()
	End

	// 1§ linha titulo do grafico (janela)
	// 2§ linha titulo da direita do grafico
	// 3§ linha titulo superior do grafico
	// 4§ linha titulo da direita do grafico
	// 5§ linha titulo da inferior do grafico
	// 6§ linha series do grafico
	// 7§ leitura ("A" - Arquivo temporario,"M" - Matriz)
	// 8§ alias doa arquivo temporario com os dados /ou
	// 9§ matriz com os dados

	vCRIGTXT := NGGRAFICO(" "+STR0023," "," ",cCadastro," ",; //"Indices FAP"
						aNiveis,"A",cAliasGRF)

	oTempGRF:Delete()

	dbSelectArea(cAliasFAP)
	Dbgotop()

return .T.