/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "TECR012.ch"
#include 'protheus.ch'
#include 'parmtype.ch'

Static cPerg := "TECR012"
Static aItens := {}
/*
aItens[x]
			[1] Tabela (TFF, TFG, TFH, TFI)
			[2] Valor no período 
			[3] Código da TFL
			[4] Código (TFF_COD , TFG_COD, TFH_COD, TFI_COD)
			[5] Código da TFJ
*/
User Function TECR012()
	U_TECR012()
Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport

@author  Matheus Lando Raimundo
@version P12
@since 	 16/02/2017
/*/
//--------------------------------------------------------------------------------------
User Function TECR012()
	Local oReport
	
   	aItens := {}
   	
	If TRepInUse() 
		Pergunte(cPerg,.F.)	
		oReport := RepInit() 
		oReport:SetLandScape()
		oReport:PrintDialog()	
	EndIf
	
	aItens := {}
Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} RepInit
Função responsavel por elaborar o layout do relatorio a ser impresso

@version P12
/*/
//-------------------------------------------------------------------------------------
Static Function RepInit()
	Local oReport
	Local oSection1
	Local oSection2
	Local oSection3
	Local oSection4
	Local cPict := PesqPict("TFL","TFL_TOTRH")
	Local aTamTot := TamSx3("TFL_TOTRH")
	Local nTam	:= aTamTot[1]
	Local cPictQtd := PesqPict("TFF","TFF_QTDVEN")
	Local aTamQtd := TamSx3("TFF_QTDVEN")
	Local nTamQtd	:= aTamQtd[1]
	Local oBreak1	:= Nil
	Local oBreak2	:= Nil
	Local oBreak3	:= Nil
	Local oBreak4	:= Nil
	
	
	oReport := TReport():New("TECR012",STR0001,cPerg,{|oReport| PrintReport(oReport)},STR0001) //"Relatorio de Custos"
	oSection1 := TRSection():New(oReport	,STR0002,{"TFJ","TWZ"},,,,,,.T.,.T.,.T.)
	oSection2 := TRSection():New(oSection1	,STR0026,{"TFL","ABS"},,,,,,,.T.) //"Locais de atendimento" 
	oSection3 := TRSection():New(oSection2	,STR0027,{"TWZ"},,,,,,,.T.) //"Custos"
	oSection4 := TRSection():New(oSection2	,STR0028,{"TWZ"},,,,,,,.T.) //"Itens"
	
	/*[ <oSection> := ] TRSection():New(<oParent>, [ <cTitle> ], [ \{<cTable>\} ], [ <aOrder> ] ,;
								 [ <.lLoadCells.> ], , [ <cTotalText> ], [ !<.lTotalInCol.> ], [ <.lHeaderPage.> ],;
								 [ <.lHeaderBreak.> ], [ <.lPageBreak.> ], [ <.lLineBreak.> ], [ <nLeftMargin> ],;
								 [ <.lLineStyle.> ], [ <nColSpace> ], [<.lAutoSize.>], [<cSeparator>],;
								 [ <nLinesBefore> ], [ <nCols> ], [ <nClrBack> ], [ <nClrFore> ])
								 */
	
	
	TRCell():New(oSection1,"TFJ_FILIAL"		,"TFJ"	,"Filial",,,,,,,,,,,,,.T.)
	TRCell():New(oSection1,"TFJ_CODIGO"		,"TFJ"	,STR0002,,,,,,,,,,,,,.T.) //"Orçamento"
	TRCell():New(oSection1,"TFJ_PROPOS"		,"TFJ"	,STR0003,,,,,,,,,,,,,.T.) //"Proposta"
	TRCell():New(oSection1,"TFJ_CONTRT"		,"TFJ"	,STR0004,,,,,,,,,,,,,.T.) //"Contrato"
	TRCell():New(oSection1,"TFJ_CONREV"		,"TFJ"	,STR0005,,,,,,,,,,,,,.T.) //"Revisao"
	TRCell():New(oSection1,"TFJ_PEROCR"		,""	,STR0006,cPict,nTam,,,"RIGHT",,"RIGHT",,,,,,.T.) //"Orçado no Período"
	TRCell():New(oSection1,"TFJ_TOTIMP"		,""	,STR0007,cPict,nTam,,,"RIGHT",,"RIGHT",,,,,,.T.) //"Impostos"
	TRCell():New(oSection1,"TFJ_VLCUST"		,""	,STR0008,cPict,nTam,,,"RIGHT",,"RIGHT",,,,,,.T.) //"Custo Apurado"
	TRCell():New(oSection1,"TFJ_VLDIF"			,""	,STR0009,cPict,nTam,,,"RIGHT",,"RIGHT",,,,,,.T.) //"Lucro"
	TRCell():New(oSection1,"TFJ_PERLUC"		,""	,STR0010,cPict,nTam,,,"RIGHT",,"RIGHT",,,,,,.T.)	 //"% Lucro"
	TRCell():New(oSection1,"TFJ_VLROCR"		,""	,STR0011,cPict,nTam,,,"RIGHT",,"RIGHT",,,,,,.T.) //"Total Orçado"

	TRCell():New(oSection2,"TFL_CODIGO"		,"TFL"	,STR0012,,,,,,,,,,,,,.T.) //"Código"
	TRCell():New(oSection2,"ABS_LOCAL"		,"ABS"	,STR0013,,,,,,,,,,,,,.T.) //"Local"
	TRCell():New(oSection2,"ABS_DESCRI"		,"ABS"	,STR0014,,,,,,,,,,,,,.T.) //"Descricao"
	TRCell():New(oSection2,"TFL_DTINI"		,"TFL"	,STR0015,,,,,,,,,,,,,.T.) //"Dt Ini"
	TRCell():New(oSection2,"TFL_DTFIM"		,"TFL"	,STR0016,,,,,,,,,,,,,.T.) //"Dt Fim"
	TRCell():New(oSection2,"TFL_VLROCR"		,""	,STR0017,cPict,nTam,,,"RIGHT",,"RIGHT",,,,,,.T.) //"Orçado"
	TRCell():New(oSection2,"TFL_TOTIMP"		,"TFL"	,STR0007,,,,,,,,,,,,,.T.,,,,,,.T.) //"Impostos"
	TRCell():New(oSection2,"TFL_VLCUST"		,""	,STR0008,cPict,nTam,,,"RIGHT",,"RIGHT",,,,,,.T.) //"Custo Apurado"
	TRCell():New(oSection2,"TFL_VLDIF"		,""	,STR0009,cPict,nTam,,,"RIGHT",,"RIGHT",,,,,,.T.) //"Lucro"
	TRCell():New(oSection2,"TFL_PERLUC"		,""	,STR0010,cPict,nTam,,,"RIGHT",,"RIGHT",,,,,,.T.) //"% Lucro"
		
	TRCell():New(oSection3,"TWZ_TPSERV"		,"TWZ"	,STR0018) //"Tp serv"
	TRCell():New(oSection3,"TWZ_VLRORC"		,""	,STR0017,cPict,nTam,,,"RIGHT",,"RIGHT") //"Orçado"
	TRCell():New(oSection3,"TWZ_VLCUST"		,""	,STR0008,cPict,nTam,,,"RIGHT",,"RIGHT") //"Custo Apurado"
	TRCell():New(oSection3,"TWZ_VLDIF"		,""	,STR0009,cPict,nTam,,,"RIGHT",,"RIGHT") //"Lucro"
	TRCell():New(oSection3,"TWZ_PERLUC"		,""	,STR0010,cPict  ,nTam,,,"RIGHT",,"RIGHT") //"% Lucro"

	TRCell():New(oSection4,"TWZ_TPSERV"		,"TWZ"	,STR0018) //"Tp serv"
	TRCell():New(oSection4,"TWZ_ITEM"		,"TWZ"	,STR0019) //"Item"
	TRCell():New(oSection4,"TWZ_PRODUT"		,"TWZ"	,STR0020) //"Produto"
	TRCell():New(oSection4,"TWZ_DESCRI"		,"TWZ"	,STR0014) //"Descricao"
	TRCell():New(oSection4,"TWZ_QUANT"		,""	,STR0021,cPictQtd,nTamQtd,,,"RIGHT",,"RIGHT") //"Quantidade"
	TRCell():New(oSection4,"TWZ_VLUNIT"		,""	,STR0022,cPict,nTam,,,"RIGHT",,"RIGHT") //"Vlr Unitário"
	TRCell():New(oSection4,"TWZ_VLRORC"		,""	,STR0017,cPict,nTam,,,"RIGHT",,"RIGHT") //"Orçado"
	TRCell():New(oSection4,"TWZ_VLCUST"		,"TWZ"	,STR0023) //"Custo"
	TRCell():New(oSection4,"TWZ_VLDIF"		,""	,STR0009,cPict,nTam,,,"RIGHT",,"RIGHT") //"Lucro"
	TRCell():New(oSection4,"TWZ_PERLUC"		,""	,STR0010,cPict  ,nTam,,,"RIGHT",,"RIGHT") //"% Lucro"
	//TRCell():New(oSection4,"TWZ_ROTINA"		,"TWZ"	,"Origem")
	TRCell():New(oSection4,"TWZ_DTINC"		,"TWZ"	,STR0024,,,,,,,,,,,,,.T.) //"Data Inc"
	
	oBreak1 := TRBreak():New( oSection1,{|| QRY_ORC->TFJ_CODIGO} )
	oBreak2 := TRBreak():New( oSection2,{|| QRY_LOC->TFL_CODIGO} )
	oBreak3 := TRBreak():New( oSection3,{|| QRY_LOC->TFL_CODIGO} )
	oBreak4 := TRBreak():New( oSection4,{|| QRY_LOC->TFL_CODIGO} )

Return oReport


//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport

@author  Matheus Lando Raimundo
@version P12
@since 	 16/02/2017
@return 
/*/
//--------------------------------------------------------------------------------------
Static Function PrintReport(oReport)
	Local oSection1 := oReport:Section(1)
	Local oSection2 := oReport:Section(1):Section(1)
	Local oSection3 := oReport:Section(1):Section(1):Section(1)
	Local oSection4 := oReport:Section(1):Section(1):Section(2)
	Local cCodOrc	:= ""
	Local cCodLocal	:= ""
	Local cPict     := PesqPict("TFL","TFL_TOTRH")	
	Local nVlDif	:= 0
	Local nQtd		:= 0		
	Local cItem		:= ""
	Local nTotal	:= 0
	Local nX
	Local nVisu	:= MV_PAR01      
	Local cOrcDe	:= MV_PAR02
	Local cOrcAte	:= MV_PAR03
	Local dDataIni := CTOD("01/01/50")
	Local dDataFim := CTOD("31/12/49")
	Local nOrcPer := 0
	Local nImpPer := 0
	Local aArea
	Local nOrcLoc := 0
	Local nOrcRH := 0
	Local nOrcMI := 0
	Local nOrcMC := 0
	Local nOrcLE := 0
	Local cLocal := STR0025
	
	If TYPE("MV_PAR04") == 'D' .AND. TYPE("MV_PAR05") == "D" .AND. MV_PAR05 >= MV_PAR04
		dDataIni := MV_PAR04
		dDataFim := MV_PAR05
	EndIf
	
	//Busca os dados da Secao principal
	oSection1:BeginQuery()
	
	BeginSql alias "QRY_ORC"			 		 				
		SELECT TFJ_FILIAL, TFJ_CODIGO, TFJ_PROPOS, TFJ_CONTRT, TFJ_CONREV, 
				(
					SELECT  SUM(TFL_TOTRH) + SUM(TFL_TOTMI) + SUM(TFL_TOTMC) + SUM(TFL_TOTLE) TOTORC FROM %table:TFL% TFL 
						WHERE TFL.TFL_FILIAL = %xfilial:TFL%
							AND TFL.TFL_CODPAI = TFJ.TFJ_CODIGO
							AND ( ( TFL.TFL_DTINI <= %exp:dDataIni% AND TFL.TFL_DTFIM >= %exp:dDataFim% ) OR  
									( TFL.TFL_DTFIM >= %exp:dDataFim% AND TFL.TFL_DTINI BETWEEN %exp:dDataIni% AND %exp:dDataFim% ) OR
									( %exp:dDataIni% <= TFL.TFL_DTINI AND %exp:dDataFim% >= TFL.TFL_DTFIM ) OR
									( TFL.TFL_DTINI <= %exp:dDataIni% AND TFL.TFL_DTFIM BETWEEN %exp:dDataIni% AND %exp:dDataFim% ) 
								)
							AND TFL.%notDel%
							 
				) TOTORC,
				(
					SELECT  SUM(TWZ_VLCUST) FROM %table:TWZ% TWZ 
						WHERE TWZ_FILIAL = %xfilial:TWZ%
							AND TWZ.TWZ_CODORC = TFJ.TFJ_CODIGO
							AND TWZ.%notDel%
							AND TWZ.TWZ_DTINC BETWEEN %exp:dDataIni% AND %exp:dDataFim%
							 
				) TOTCUS
			FROM %table:TFJ% TFJ
			WHERE TFJ_FILIAL = %xfilial:TFJ% 			
				AND TFJ_CODIGO BETWEEN %Exp:cOrcDe% AND %Exp:cOrcAte%   
				AND TFJ.%notDel%
	EndSql
	
	oSection1:EndQuery()
	oSection1:SetParentQuery(.F.)
		
	oSection1:Init()
	While QRY_ORC->(!Eof())
		
		nOrcPer := 0
		nImpPer := 0
		
		aArea := GetArea()
		
		DbSelectArea("TFL")
		DbSetOrder(2)
		DBSeek(xFilial("TFL") + QRY_ORC->(TFJ_CODIGO))
		
		While TFL->(!EOF()) .AND. QRY_ORC->(TFJ_CODIGO) == TFL->TFL_CODPAI .AND. xFilial("TFL") == TFL->TFL_FILIAL
			nOrcPer += getOrcPer( TFL->TFL_CODIGO, dDataIni, dDataFim, QRY_ORC->(TFJ_CODIGO) )
			nImpPer += ( (TFL->TFL_TOTIMP) / ((TFL->TFL_DTFIM + 1) - TFL->TFL_DTINI) ) *;
								 diasPeriod(TFL->TFL_DTINI, TFL->TFL_DTFIM, dDataIni , dDataFim)
			TFL->(DbSkip())	
		End
		
		RestArea(aArea)
		
		nVlDif := nOrcPer - QRY_ORC->(TOTCUS)
		oSection1:Cell("TFJ_PEROCR"):SetBlock( {|| nOrcPer })
		oSection1:Cell("TFJ_VLROCR"):SetBlock( {||QRY_ORC->(TOTORC) } )
		oSection1:Cell("TFJ_VLCUST"):SetBlock( {||QRY_ORC->(TOTCUS) } )
		oSection1:Cell("TFJ_VLDIF"):SetBlock( {|| nVlDif  } )
		oSection1:Cell("TFJ_TOTIMP"):SetBlock( {|| nImpPer } )
		oSection1:Cell("TFJ_PERLUC"):SetBlock( {||(nVlDif / nOrcPer) * 100 } )
		oSection1:PrintLine()
		
		cCodOrc := QRY_ORC->(TFJ_CODIGO)
		If nVisu >= 2
			oSection2:BeginQuery()		
			BeginSql alias "QRY_LOC"			 		 				
			//-- Preenche a section de Locais
				SELECT  TFL_FILIAL, TFL_CODIGO, ABS_LOCAL, ABS_DESCRI, TFL_TOTRH, TFL_TOTMI, TFL_TOTMC, TFL_TOTLE, TFL_TOTIMP,
							0 TOTORC, TFL_DTINI, TFL_DTFIM,
				(
						SELECT  SUM(TWZ_VLCUST) FROM %table:TWZ% TWZ 
							WHERE TWZ_FILIAL = %xfilial:TWZ%
								AND TWZ.TWZ_CODORC = %Exp:cCodOrc%
								AND TWZ.TWZ_LOCAL = TFL.TFL_CODIGO
								AND TWZ.%notDel%
								AND TWZ.TWZ_DTINC BETWEEN %exp:dDataIni% AND %exp:dDataFim%
								 
					) TOTCUS
			
				
				 FROM %table:ABS% ABS  
					INNER JOIN %table:TFL% TFL
					ON TFL.TFL_FILIAL = %xfilial:TFL%
						AND TFL.TFL_LOCAL = ABS.ABS_LOCAL
						AND TFL.%notDel%
						AND TFL_CODPAI =  %Exp:cCodOrc%
						AND ( ( TFL.TFL_DTINI <= %exp:dDataIni% AND TFL.TFL_DTFIM >= %exp:dDataFim% ) OR  
									( TFL.TFL_DTFIM >= %exp:dDataFim% AND TFL.TFL_DTINI BETWEEN %exp:dDataIni% AND %exp:dDataFim% ) OR
									( %exp:dDataIni% <= TFL.TFL_DTINI AND %exp:dDataFim% >= TFL.TFL_DTFIM ) OR
									( TFL.TFL_DTINI <= %exp:dDataIni% AND TFL.TFL_DTFIM BETWEEN %exp:dDataIni% AND %exp:dDataFim% ) 
							)
						WHERE ABS_FILIAL = %xfilial:ABS%
						AND ABS.%notDel%
				UNION
				
				SELECT "", "", "", %Exp:cLocal%, 0, 0, 0, 0, 0,0,"",""  //"Custos sem local informado"
							,SUM(TWZ_VLCUST) TOTCUS FROM %table:TWZ% TWZ 
				WHERE TWZ.TWZ_FILIAL = %xfilial:TWZ%
					AND TWZ.TWZ_CODORC = %Exp:cCodOrc%
					AND TWZ.TWZ_LOCAL = %Exp:Padr('',TamSX3('TFL_CODIGO')[1])%
					AND TWZ.%notDel%
					AND TWZ.TWZ_DTINC BETWEEN %exp:dDataIni% AND %exp:dDataFim%
					HAVING SUM(TWZ_VLCUST) > 0
			EndSql
			
			oSection2:EndQuery()
			oSection2:SetParentQuery(.F.)		
			oSection2:Init()
		
			While QRY_LOC->(!Eof())
				nOrcLoc := 0
				For nX := 1 To LEN(aItens)
					IF aItens[nX][3] == QRY_LOC->(TFL_CODIGO) .AND. aItens[nX][5] == cCodOrc
						nOrcLoc += aItens[nX][2]
					EndIf
				Next
				
				nVlDif :=  nOrcLoc - QRY_LOC->(TOTCUS)
				oSection2:Cell("TFL_VLROCR"):SetBlock({||nOrcLoc})
				oSection2:Cell("TFL_VLCUST"):SetBlock({||QRY_LOC->(TOTCUS)})		
				oSection2:Cell("TFL_VLDIF"):SetBlock({||nVlDif })
				oSection2:Cell("TFL_PERLUC"):SetBlock({||(nVlDif / nOrcLoc) * 100 } )
				
				oSection2:PrintLine()
				cCodLocal := QRY_LOC->(TFL_CODIGO)

				If nVisu >= 3
					oSection3:BeginQuery()			

					//-- Preenche a section de Locais/
					If !Empty(QRY_LOC->(ABS_LOCAL))
						BeginSql alias "QRY_CUS"
							SELECT TWZ_TPSERV, SUM(TWZ_VLCUST) TWZ_VLCUST FROM %table:TWZ% TWZ 
								WHERE TWZ.TWZ_FILIAL = %xfilial:TWZ%
									AND TWZ_CODORC = %Exp:cCodOrc%
									AND TWZ_LOCAL = %Exp:cCodLocal%
									AND TWZ.TWZ_DTINC BETWEEN %exp:dDataIni% AND %exp:dDataFim%
									AND TWZ.%notDel%

								GROUP BY TWZ_TPSERV
							EndSql
					Else
						BeginSql alias "QRY_CUS"
							SELECT TWZ_TPSERV, SUM(TWZ_VLCUST) TWZ_VLCUST FROM %table:TWZ% TWZ 
								WHERE TWZ.TWZ_FILIAL = %xfilial:TWZ%
									AND TWZ_CODORC = %Exp:cCodOrc%
									AND TWZ.TWZ_LOCAL = %Exp:Padr('',TamSX3('TFL_CODIGO')[1])%
									AND TWZ.TWZ_DTINC BETWEEN %exp:dDataIni% AND %exp:dDataFim%
									AND TWZ.%notDel%
								 
								GROUP BY TWZ_TPSERV
							EndSql	
					
					EndIf		
					oSection3:EndQuery()
					
					oSection3:SetParentQuery(.F.)		
					oSection3:Init()
					
					While QRY_CUS->(!Eof())
						nOrcRH := 0
						nOrcMI := 0
						nOrcMC := 0
						nOrcLE := 0
						Do Case
							Case ((QRY_CUS->TWZ_TPSERV) == '1')
								For nX := 1 To LEN(aItens)
									IF aItens[nX][3] == QRY_LOC->(TFL_CODIGO) .AND.;
										 aItens[nX][5] == cCodOrc .AND. aItens[nX][1] == "TFF"
										nOrcRH += aItens[nX][2]
									EndIf
								Next
								nVlDif :=  nOrcRH - QRY_CUS->TWZ_VLCUST
								
								oSection3:Cell("TWZ_VLRORC"):SetBlock( {||nOrcRH})
								oSection3:Cell("TWZ_VLDIF"):SetBlock( {||nVlDif})
								oSection3:Cell("TWZ_PERLUC"):SetBlock( {||(nVlDif / nOrcRH) * 100})
								
							Case ((QRY_CUS->TWZ_TPSERV) == '2')
								For nX := 1 To LEN(aItens)
									IF aItens[nX][3] == QRY_LOC->(TFL_CODIGO) .AND.;
										 aItens[nX][5] == cCodOrc .AND. aItens[nX][1] == "TFG"
										nOrcMI += aItens[nX][2]
									EndIf
								Next
								nVlDif :=  nOrcMI - QRY_CUS->TWZ_VLCUST
								oSection3:Cell("TWZ_VLRORC"):SetBlock( {||nOrcMI})
								oSection3:Cell("TWZ_VLDIF"):SetBlock( {||nVlDif})
								oSection3:Cell("TWZ_PERLUC"):SetBlock( {||(nVlDif / nOrcMI) * 100})
								
							Case ((QRY_CUS->TWZ_TPSERV) == '3')
								For nX := 1 To LEN(aItens)
									IF aItens[nX][3] == QRY_LOC->(TFL_CODIGO) .AND.;
										 aItens[nX][5] == cCodOrc .AND. aItens[nX][1] == "TFH"
										nOrcMC += aItens[nX][2]
									EndIf
								Next
								nVlDif :=  nOrcMC - QRY_CUS->TWZ_VLCUST
								oSection3:Cell("TWZ_VLRORC"):SetBlock( {||nOrcMC})
								oSection3:Cell("TWZ_VLDIF"):SetBlock( {||nVlDif})
								oSection3:Cell("TWZ_PERLUC"):SetBlock( {||(nVlDif / nOrcMC) * 100})
								
							Case ((QRY_CUS->TWZ_TPSERV) == '4')
								For nX := 1 To LEN(aItens)
									IF aItens[nX][3] == QRY_LOC->(TFL_CODIGO) .AND.;
										 aItens[nX][5] == cCodOrc .AND. aItens[nX][1] == "TFI"
										nOrcLE += aItens[nX][2]
									EndIf
								Next
								nVlDif :=  nOrcLE - QRY_CUS->TWZ_VLCUST
								oSection3:Cell("TWZ_VLRORC"):SetBlock( {||nOrcLE})
								oSection3:Cell("TWZ_VLDIF"):SetBlock( {||nVlDif})
								oSection3:Cell("TWZ_PERLUC"):SetBlock( {||(nVlDif / nOrcLE) * 100})
								
							Case ((QRY_CUS->TWZ_TPSERV) == '5')
								nVlDif :=  QRY_CUS->TWZ_VLCUST * -1														
								oSection3:Cell("TWZ_VLRORC"):SetBlock( {||0,00 } )
								oSection3:Cell("TWZ_VLDIF"):SetBlock( {||-QRY_CUS->TWZ_VLCUST})
								oSection3:Cell("TWZ_PERLUC"):SetBlock( {||0})						
						EndCase
						
						oSection3:PrintLine()				
						QRY_CUS->(dbSkip())
						
					EndDo
				EndIf	
				//oSection3:Finish()
				
				If nVisu >= 4
					oSection4:BeginQuery()
					
					BeginSql alias "QRY_ITE"			 		 				
					//-- Preenche a section de Locais/
							SELECT TWZ_TPSERV, TWZ_ITEM, TWZ_PRODUT, TWZ_DTINC ,SUM(TWZ_VLCUST) TWZ_VLCUST FROM %table:TWZ% TWZ 
								WHERE TWZ.TWZ_FILIAL = %xfilial:TWZ%
									AND TWZ_CODORC = %Exp:cCodOrc%
									AND TWZ_LOCAL = %Exp:cCodLocal%
									AND TWZ.TWZ_DTINC BETWEEN %exp:dDataIni% AND %exp:dDataFim%
									AND TWZ.%notDel%
									GROUP BY TWZ_TPSERV, TWZ_ITEM, TWZ_PRODUT, TWZ_DTINC
								 
								ORDER BY TWZ_TPSERV
					EndSql		
					
					
					oSection4:EndQuery()			
					oSection4:SetParentQuery(.F.)		
					oSection4:Init()
					
					While QRY_ITE->(!Eof())
						cItem := (QRY_ITE->TWZ_ITEM)
					 	
						oSection4:Cell("TWZ_DESCRI"):SetBlock( {|| Alltrim(Posicione( "SB1", 1, xFilial("SB1")+QRY_ITE->TWZ_PRODUT, "B1_DESC" ))})
						
						Do Case
							Case ((QRY_ITE->TWZ_TPSERV) == '1')
								TFF->(DbSetOrder(1))
								TFF->(DbSeek(xFilial("TFF")+cItem))
								
								nVlrItem := TFF->TFF_PRCVEN
								nQtd := TFF->TFF_QTDVEN
								
								For nX := 1 to LEN(aItens)
									If aItens[nX][4] == cItem .AND. aItens[nX][1] == "TFF"
										nTotal	:= aItens[nX][2]
										Exit
									EndIf
								Next
								
								nVlDif :=  nTotal - QRY_ITE->TWZ_VLCUST
								
								oSection4:Cell("TWZ_QUANT"):SetBlock( {||nQtd})
								oSection4:Cell("TWZ_VLUNIT"):SetBlock( {||nVlrItem})						
								oSection4:Cell("TWZ_VLRORC"):SetBlock( {||nTotal})
								oSection4:Cell("TWZ_VLDIF"):SetBlock( {||nVlDif})
								oSection4:Cell("TWZ_PERLUC"):SetBlock( {||(nVlDif / nTotal) * 100 })
								oSection4:Cell("TWZ_DTINC"):SetBlock({|| QRY_ITE->TWZ_DTINC })
							Case ((QRY_ITE->TWZ_TPSERV) == '2')
								TFG->(DbSetOrder(1))
								TFG->(DbSeek(xFilial("TFG")+cItem))
								
								nVlrItem := TFG->TFG_PRCVEN
								nQtd := TFG->TFG_QTDVEN
								
								For nX := 1 to LEN(aItens)
									If aItens[nX][4] == cItem .AND. aItens[nX][1] == "TFG"
										nTotal	:= aItens[nX][2]
										Exit
									EndIf
								Next
								
								nVlDif :=  nTotal - QRY_ITE->TWZ_VLCUST
								
								oSection4:Cell("TWZ_QUANT"):SetBlock( {||nQtd})
								oSection4:Cell("TWZ_VLUNIT"):SetBlock( {||nVlrItem})						 
								oSection4:Cell("TWZ_VLRORC"):SetBlock( {||nTotal})
								oSection4:Cell("TWZ_VLDIF"):SetBlock( {||nVlDif})
								oSection4:Cell("TWZ_PERLUC"):SetBlock( {||(nVlDif  / nTotal) * 100 })
								oSection4:Cell("TWZ_DTINC"):SetBlock({|| QRY_ITE->TWZ_DTINC })
							Case ((QRY_ITE->TWZ_TPSERV) == '3')
								TFH->(DbSetOrder(1))
								TFH->(DbSeek(xFilial("TFH")+cItem))
								
								nVlrItem := TFH->TFH_PRCVEN
								nQtd := TFH->TFH_QTDVEN
								For nX := 1 to LEN(aItens)
									If aItens[nX][4] == cItem .AND. aItens[nX][1] == "TFH"
										nTotal	:= aItens[nX][2]
										Exit
									EndIf
								Next
								nVlDif :=  nTotal - QRY_ITE->TWZ_VLCUST
								 
								oSection4:Cell("TWZ_QUANT"):SetBlock( {||nQtd})
								oSection4:Cell("TWZ_VLUNIT"):SetBlock( {||nVlrItem})						
								oSection4:Cell("TWZ_VLRORC"):SetBlock( {||nTotal})
								oSection4:Cell("TWZ_VLDIF"):SetBlock( {||nVlDif})
								oSection4:Cell("TWZ_PERLUC"):SetBlock( {||(nVlDif  / nTotal) * 100 })
								oSection4:Cell("TWZ_DTINC"):SetBlock({|| QRY_ITE->TWZ_DTINC })				
							Case ((QRY_ITE->TWZ_TPSERV) == '4')
								TFI->(DbSetOrder(1))
								TFI->(DbSeek(xFilial("TFI")+cItem))
								
								nQtd := TFI->TFI_QTDVEN
								For nX := 1 to LEN(aItens)
									If aItens[nX][4] == cItem .AND. aItens[nX][1] == "TFI"
										nTotal	:= aItens[nX][2]
										Exit
									EndIf
								Next
								nVlrItem := nTotal / nQtd 
								nVlDif :=  nTotal - QRY_ITE->TWZ_VLCUST
																				
								oSection4:Cell("TWZ_QUANT"):SetBlock( {||nQtd})
								oSection4:Cell("TWZ_VLUNIT"):SetBlock( {||nVlrItem})						
								oSection4:Cell("TWZ_VLRORC"):SetBlock( {||nTotal})
								oSection4:Cell("TWZ_VLDIF"):SetBlock( {||nVlDif})
								oSection4:Cell("TWZ_PERLUC"):SetBlock( {||(nVlDif  / nTotal) * 100 })
								oSection4:Cell("TWZ_DTINC"):SetBlock({|| QRY_ITE->TWZ_DTINC })
							Case ((QRY_ITE->TWZ_TPSERV) == '5')														
								oSection4:Cell("TWZ_QUANT"):SetBlock( {||0})
								oSection4:Cell("TWZ_VLUNIT"):SetBlock({||0,00})
								oSection4:Cell("TWZ_VLRORC"):SetBlock({||0,00})
								oSection4:Cell("TWZ_VLDIF"):SetBlock( {||-QRY_ITE->TWZ_VLCUST})
								oSection4:Cell("TWZ_PERLUC"):SetBlock({||0,00})
								oSection4:Cell("TWZ_DTINC"):SetBlock({|| QRY_ITE->TWZ_DTINC })
						EndCase
					
						oSection4:PrintLine()
						QRY_ITE->(dbSkip())
					EndDo
				EndIf
				QRY_LOC->(dbSkip())
			EndDo
		EndIf	
		QRY_ORC->(dbSkip())
		oReport:EndPage( .T. )
	EndDo
	//oSection1:Finish()
	
	If Select("QRY_ORC") > 0 
		QRY_ORC->(DbCloseArea())
	EndIf
	
	If Select("QRY_LOC") > 0
		QRY_LOC->(DbCloseArea())
	EndIf 
	
	If Select("QRY_CUS") > 0
		QRY_CUS->(DbCloseArea())
	EndIf
	
	If Select("QRY_ITE") > 0
		QRY_ITE->(DbCloseArea())
	EndIf
Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} getOrcPer
@description Recebe um período (Dia inicio / Dia Fim ) e um código de Local de Atendimento (TFL).
Verifica itens de RH, MI, MC e LE dessa TFL nesse período - se ao menos 1 dia desses itens estiver
dentro do range de datas informada, proporcionaliza o valor do item pela quantidade de dias em que
esse item está dentro do período informado no parametro, considerando taxa de lucro, taxa de administração
e descontos. Essa função também preenche o array static aItens, que é utilizad caso esse relatório possua mais
de uma section. O array é utilizado apenas para não chamar essa rotina para cada uma das sections (já que aqui
nós já chegamos no detalhe do item do orçamento)

@param cCodTFL, string, Código da TFL analisada
@param dDataIni, date, Inicio do período
@param dDataFim, date, Fim do período
@param cCodTFJ, string, Código da TFJ que a TFL é filha
@author  Mateus Boiani
@version P12
@since 	 28/06/2018
@return nRet, int, soma proporcionalizada dos valores nos períodos
/*/
//--------------------------------------------------------------------------------------
Static Function getOrcPer(cCodTFL, dDataIni, dDataFim, cCodTFJ)
Local nRet := 0
Local aArea := GetArea()
Local aAreaTFF := TFF->(GetArea())
Local aAreaTFJ := TFJ->(GetArea())
Local aAreaTFI := TFI->(GetArea())
Local aAreaTFG := TFG->(GetArea())
Local aAreaTFH := TFH->(GetArea())
Local lOrcPrc := !(EMPTY(Posicione("TFJ",1,xFilial("TFJ")+cCodTFJ, "TFJ_CODTAB")))
Local nAux := 0

Local nTot
Local nDescon
Local nTxLucr
Local nTxAdm

DbSelectArea("TFF")
DbSetOrder(3)

MSSeek(xFilial("TFF") + cCodTFL)

While TFF->(!EOF()) .AND. cCodTFL == TFF->TFF_CODPAI .AND. xFilial("TFF") == TFF->TFF_FILIAL
	If ( ( TFF->TFF_PERINI <= dDataIni .AND. TFF->TFF_PERFIM >= dDataFim ) .OR.;  
			( TFF->TFF_PERFIM >= dDataFim .AND. (TFF->TFF_PERINI >= dDataIni .AND. TFF->TFF_PERINI <= dDataFim) ) .OR.;
			( dDataIni <= TFF->TFF_PERINI .AND. dDataFim >= TFF->TFF_PERFIM ) .OR.;
			( TFF->TFF_PERINI <= dDataIni .AND. (TFF->TFF_PERFIM >= dDataIni .AND. TFF->TFF_PERFIM <= dDataFim) ))
			
		nTot := (TFF->TFF_QTDVEN * TFF->TFF_PRCVEN)
		nDescon := nTot * (TFF->TFF_DESCON / 100)
		nTxLucr := nTot * (TFF->TFF_LUCRO / 100)
		nTxAdm := nTot * (TFF->TFF_ADM / 100)
		
		nAux := ((nTot - nDescon + nTxLucr + nTxAdm) /;
					((TFF->TFF_PERFIM + 1) - TFF->TFF_PERINI)) *;
					diasPeriod(TFF->TFF_PERINI, TFF->TFF_PERFIM, dDataIni , dDataFim )
		
		AADD(aItens, {"TFF", nAux, cCodTFL, TFF->TFF_COD, cCodTFJ})
		
		nRet += nAux
					
		nTot := 0
		nDescon := 0
		nTxLucr := 0
		nTxAdm := 0
		
		If !lOrcPrc
			DbSelectArea("TFG")
			DbSetOrder(3)
			
			MSSeek(xFilial("TFG") + TFF->TFF_COD)
			While TFG->(!EOF()) .AND. TFF->TFF_COD == TFG->TFG_CODPAI .AND. xFilial("TFG") == TFG->TFG_FILIAL
					If ( ( TFG->TFG_PERINI <= dDataIni .AND. TFG->TFG_PERFIM >= dDataFim ) .OR.;  
							( TFG->TFG_PERFIM >= dDataFim .AND. (TFG->TFG_PERINI >= dDataIni .AND. TFG->TFG_PERINI <= dDataFim) ) .OR.;
							( dDataIni <= TFG->TFG_PERINI .AND. dDataFim >= TFG->TFG_PERFIM ) .OR.;
							( TFG->TFG_PERINI <= dDataIni .AND. (TFG->TFG_PERFIM >= dDataIni .AND. TFG->TFG_PERFIM <= dDataFim) ))
							
						nTot := (TFG->TFG_QTDVEN * TFG->TFG_PRCVEN)
						nDescon := nTot * (TFG->TFG_DESCON / 100)
						nTxLucr := nTot * (TFG->TFG_LUCRO / 100)
						nTxAdm := nTot * (TFG->TFG_ADM / 100)
						
						nAux := ((nTot - nDescon + nTxLucr + nTxAdm) /;
									((TFG->TFG_PERFIM + 1) - TFG->TFG_PERINI)) *;
									diasPeriod(TFG->TFG_PERINI, TFG->TFG_PERFIM, dDataIni , dDataFim )
									
						AADD(aItens, {"TFG", nAux, cCodTFL, TFG->TFG_COD, cCodTFJ})						

						nRet += nAux

						nTot := 0
						nDescon := 0
						nTxLucr := 0
						nTxAdm := 0
					EndIf
				TFG->(DbSkip())
			End
			
			DbSelectArea("TFH")
			DbSetOrder(3)
			
			MSSeek(xFilial("TFH") + TFF->TFF_COD)
			While TFH->(!EOF()) .AND. TFF->TFF_COD == TFH->TFH_CODPAI .AND. xFilial("TFH") == TFH->TFH_FILIAL
					If ( ( TFH->TFH_PERINI <= dDataIni .AND. TFH->TFH_PERFIM >= dDataFim ) .OR.;  
							( TFH->TFH_PERFIM >= dDataFim .AND. (TFH->TFH_PERINI >= dDataIni .AND. TFH->TFH_PERINI <= dDataFim) ) .OR.;
							( dDataIni <= TFH->TFH_PERINI .AND. dDataFim >= TFH->TFH_PERFIM ) .OR.;
							( TFH->TFH_PERINI <= dDataIni .AND. (TFH->TFH_PERFIM >= dDataIni .AND. TFH->TFH_PERFIM <= dDataFim) ))
							
						nTot := (TFH->TFH_QTDVEN * TFH->TFH_PRCVEN)
						nDescon := nTot * (TFH->TFH_DESCON / 100)
						nTxLucr := nTot * (TFH->TFH_LUCRO / 100)
						nTxAdm := nTot * (TFH->TFH_ADM / 100)
						
						nAux := ((nTot - nDescon + nTxLucr + nTxAdm) /;
									((TFH->TFH_PERFIM + 1) - TFH->TFH_PERINI)) *;
									diasPeriod(TFH->TFH_PERINI, TFH->TFH_PERFIM, dDataIni , dDataFim )
						
						AADD(aItens, {"TFH", nAux, cCodTFL, TFH->TFH_COD, cCodTFJ})
						
						nRet += nAux
									
						nTot := 0
						nDescon := 0
						nTxLucr := 0
						nTxAdm := 0
					EndIf
				TFH->(DbSkip())
			End
		EndIf
	EndIf
	TFF->(DbSkip())
End

If lOrcPrc
	DbSelectArea("TFG")
	DbSetOrder(3)
	
	MSSeek(xFilial("TFG") + cCodTFL)
	While TFG->(!EOF()) .AND. cCodTFL == TFG->TFG_CODPAI .AND. xFilial("TFG") == TFG->TFG_FILIAL
			If ( ( TFG->TFG_PERINI <= dDataIni .AND. TFG->TFG_PERFIM >= dDataFim ) .OR.;  
					( TFG->TFG_PERFIM >= dDataFim .AND. (TFG->TFG_PERINI >= dDataIni .AND. TFG->TFG_PERINI <= dDataFim) ) .OR.;
					( dDataIni <= TFG->TFG_PERINI .AND. dDataFim >= TFG->TFG_PERFIM ) .OR.;
					( TFG->TFG_PERINI <= dDataIni .AND. (TFG->TFG_PERFIM >= dDataIni .AND. TFG->TFG_PERFIM <= dDataFim) ))
					
				nTot := (TFG->TFG_QTDVEN * TFG->TFG_PRCVEN)
				nDescon := nTot * (TFG->TFG_DESCON / 100)
				nTxLucr := nTot * (TFG->TFG_LUCRO / 100)
				nTxAdm := nTot * (TFG->TFG_ADM / 100)
				
				nAux := ((nTot - nDescon + nTxLucr + nTxAdm) /;
							((TFG->TFG_PERFIM + 1) - TFG->TFG_PERINI)) *;
							diasPeriod(TFG->TFG_PERINI, TFG->TFG_PERFIM, dDataIni , dDataFim )
							
				AADD(aItens, {"TFG", nAux, cCodTFL, TFG->TFG_COD, cCodTFJ})						

				nRet += nAux
							
				nTot := 0
				nDescon := 0
				nTxLucr := 0
				nTxAdm := 0
			EndIf
		TFG->(DbSkip())
	End
	
	DbSelectArea("TFH")
	DbSetOrder(3)
	
	MSSeek(xFilial("TFH") + cCodTFL)
	While TFH->(!EOF()) .AND. cCodTFL == TFH->TFH_CODPAI .AND. xFilial("TFH") == TFH->TFH_FILIAL
			If ( ( TFH->TFH_PERINI <= dDataIni .AND. TFH->TFH_PERFIM >= dDataFim ) .OR.;  
					( TFH->TFH_PERFIM >= dDataFim .AND. (TFH->TFH_PERINI >= dDataIni .AND. TFH->TFH_PERINI <= dDataFim) ) .OR.;
					( dDataIni <= TFH->TFH_PERINI .AND. dDataFim >= TFH->TFH_PERFIM ) .OR.;
					( TFH->TFH_PERINI <= dDataIni .AND. (TFH->TFH_PERFIM >= dDataIni .AND. TFH->TFH_PERFIM <= dDataFim) ))
					
				nTot := (TFH->TFH_QTDVEN * TFH->TFH_PRCVEN)
				nDescon := nTot * (TFH->TFH_DESCON / 100)
				nTxLucr := nTot * (TFH->TFH_LUCRO / 100)
				nTxAdm := nTot * (TFH->TFH_ADM / 100)
				
				nAux := ((nTot - nDescon + nTxLucr + nTxAdm) /;
							((TFH->TFH_PERFIM + 1) - TFH->TFH_PERINI)) *;
							diasPeriod(TFH->TFH_PERINI, TFH->TFH_PERFIM, dDataIni , dDataFim )
				
				AADD(aItens, {"TFH", nAux, cCodTFL, TFH->TFH_COD, cCodTFJ})
				
				nRet += nAux
							
				nTot := 0
				nDescon := 0
				nTxLucr := 0
				nTxAdm := 0
			EndIf
		TFH->(DbSkip())
	End
EndIf

DbSelectArea("TFI")
DbSetOrder(3)

MSSeek(xFilial("TFI") + cCodTFL)
While TFI->(!EOF()) .AND. cCodTFL == TFI->TFI_CODPAI .AND. xFilial("TFI") == TFI->TFI_FILIAL
		If ( ( TFI->TFI_PERINI <= dDataIni .AND. TFI->TFI_PERFIM >= dDataFim ) .OR.;  
				( TFI->TFI_PERFIM >= dDataFim .AND. (TFI->TFI_PERINI >= dDataIni .AND. TFI->TFI_PERINI <= dDataFim) ) .OR.;
				( dDataIni <= TFI->TFI_PERINI .AND. dDataFim >= TFI->TFI_PERFIM ) .OR.;
				( TFI->TFI_PERINI <= dDataIni .AND. (TFI->TFI_PERFIM >= dDataIni .AND. TFI->TFI_PERFIM <= dDataFim) ))
				
			nTot := TFI->TFI_TOTAL
			nDescon := 0
			nTxLucr := 0
			nTxAdm := 0 //Desconto, ADM e Lucro já inclusos no TFI_TOTAL
			
			nAux := ((nTot - nDescon + nTxLucr + nTxAdm) /;
						((TFI->TFI_PERFIM + 1) - TFI->TFI_PERINI)) *;
						diasPeriod(TFI->TFI_PERINI, TFI->TFI_PERFIM, dDataIni , dDataFim )
			
			AADD(aItens, {"TFI", nAux, cCodTFL, TFI->TFI_COD, cCodTFJ})
			
			nRet += nAux
						
			nTot := 0
			nDescon := 0
			nTxLucr := 0
			nTxAdm := 0
		EndIf
	TFI->(DbSkip())
End

RestArea(aAreaTFJ)
RestArea(aAreaTFF)
RestArea(aAreaTFI)
RestArea(aAreaTFG)
RestArea(aAreaTFH)
RestArea(aArea)

Return nRet

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} diasPeriod
@description Recebe dois períodos de datas e retorna quantos dias do período 1 existem no período 2
@param dDtIni, date, Inicio do período 1
@param dDtFim, date, Fim do período 1
@param dSelectD, date, Inicio do período 2
@param dSelectAt, date, Fim do período 2
@author  Mateus Boiani
@version P12
@since 	 28/06/2018
@return nRet, int, quantidade de dias 
/*/
//--------------------------------------------------------------------------------------
Static Function diasPeriod(dDtIni, dDtFim, dSelectD, dSelectAt)

Return TecDaysIn(dDtIni, dDtFim, dSelectD, dSelectAt)
//-------------------------------------------------------------------------------------
/*/{Protheus.doc} diasPeriod
@description Função utilizada para limpar a variável estática aItens. Utilizada na automação de testes
@author Diego Bezerra
@version P12
@since 	 13/11/2018
@return aItens 
/*/
//--------------------------------------------------------------------------------------
User Function ATR012CLR()

Return aItens := {}