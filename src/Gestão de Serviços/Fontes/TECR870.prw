/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "TECR870.CH"

Static cAutoPerg := "TECR870"

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} TECR870

Relatorio de Armas Movimentadas - GESP
@author Serviços
@since 06/01/2013
@version P11 R9
@return Nil,Não Retorna Nada
/*/ 
//----------------------------------------------------------------------------------------------------------------------
User Function TECR870()
	Local oReport
	Local cPerg  	:= "TECR870"
	Local aAreaTFQ 	:= {} //WorkArea TFQ
	Local aAreaSM0  := {} //WorkArea SM0
   	
	If TRepInUse()  .AND. 	Pergunte(cPerg, .T.) 
		aAreaTFQ	:= IF(Select("TFQ") > 0, TFQ->(GetArea()), {})
		aAreaSM0 := SM0->(GetArea())
		oReport := ReportDef() 
		oReport:SetLandScape(.t.)
		oReport:PrintDialog()	
		
		If Len(aAreaTFQ ) > 0
			RestArea(aAreaTFQ)
		Else	
			TFQ->(DbCloseArea())
		EndIf

		RestArea(aAreaSM0)
	EndIf
	
Return

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportDef

Relatorio de Armas Movimentadas - GESP
@author Serviços
@since 06/01/2013
@version P11 R9
@return oReport - Objeto report
/*/ 
//----------------------------------------------------------------------------------------------------------------------
Static Function ReportDef()
Local cPerg  	:= "TECR870"
Local cAlias 	:= GetNextAlias()
Local oReport		:= Nil							//Objeto para armazenar a seção pai
Local oSection0		:= Nil							//Objeto para armazenar a seção 0 do objeto pai
Local oSection1		:= Nil							//Objeto para armazenar a seção 1 do objeto pai
Local oSection2		:= Nil							//Objeto para armazenar a seção 2 do objeto pai
Local oSection3		:= Nil							//Objeto para armazenar a seção 3 do objeto pai
Local nLoc			:= TamSX3("ABS_LOCAL")[1]	//Variável para ajustar tamanho do campo Código do local de atendimento
Local nLocDes		:= TamSX3("ABS_DESCRI")[1]	//Variável para ajustar tamanho do campo Descrição do local de atendimento
Local nNome			:= TamSx3("RA_NOME")[1]		//Variável para ajustar tamanho do campo Nome do Funcionário
Local nGuia			:= TamSx3("TFQ_NGUIA")[1]	//Variável para ajustar tamanho do campo Numero da Guia
Local nJust			:= TamSx3("TFQ_JUSTIF")[1]	//Variável para ajustar tamanho do campo Justificativa
Local nEnder		:= AtR870End("T")				//Variável para ajustar tamanho do campo Endereço
Local nEndEmpr		:= Len(SM0->M0_ENDENT)+Len(SM0->M0_BAIRENT)+Len(AllTrim(STR0025))+Len(AllTrim(X3Picture("ABS_CEP")))+Len(SM0->M0_CIDENT)+Len(SM0->M0_ESTENT)+9	//Variável para ajustar tamanho do campo Endereço da Empresa/Filial
Local cTitCNPJ		:= GetSx3Cache("A1_CGC","X3_TITULO")
Local nCodCli		:= If(TamSX3("A1_COD")[1] > Len(SM0->M0_NOME), TamSX3("A1_COD")[1], Len(SM0->M0_NOME)) 
Local nFilCli		:= If(TamSX3("A1_LOJA")[1] > Len(SM0->M0_FILIAL), TamSX3("A1_LOJA")[1], Len(SM0->M0_FILIAL))
Local nNomeCli		:= If(TamSX3("A1_NOME")[1] > Len(SM0->M0_NOMECOM), TamSX3("A1_NOME")[1], Len(SM0->M0_NOMECOM))
Local nTamDt		:= 15 //Tamanho da coluna data
Local cTitle1 		:= GetSx3Cache("TE0_VALIDA","X3_TITULO")
Local cTitle2 		:= GetSx3Cache("TE0_DTREG","X3_TITULO")
Local cTitle3 		:= GetSx3Cache("TFQ_DMOVIM","X3_TITULO")
Local lMultFil 		:= TFQ->(ColumnPos("TFQ_FILORI")) .And. TFQ->(ColumnPos("TFQ_FILDES")) .And. FindFunction("TecMtFlArm") .And. TecMtFlArm()
Local aCBox     	:= {}
Local cCbox			:= Posicione("SX3", 2, "TE0_ESPEC", "X3_CBOX")

If(!EMPTY(cCbox))
	aCBox := StrToKArr(Posicione("SX3", 2, "TE0_ESPEC", "X3_CBOX"), ";")
EndIf

//Relatório
DEFINE REPORT oReport NAME "TECR870" TITLE STR0001 ACTION {|oReport| PrintReport(oReport, cPerg, cAlias )} //"Armas Movimentadas"
		 
	//Seção 0
	DEFINE SECTION oSection0 OF oReport TITLE STR0030 TABLES "SM0" BREAK HEADER //"Prestadora do serviço"
      
   		//Células Seção 0
	      	DEFINE CELL NAME "Empr_Emp"	  	OF oSection0 TITLE STR0026	SIZE Len(SM0->M0_NOME)					BLOCK {|| AllTrim(SM0->M0_NOME)}
	      	DEFINE CELL NAME "Fili_Emp"		OF oSection0 TITLE STR0027	SIZE Len(SM0->M0_FILIAL)				BLOCK {|| AllTrim(SM0->M0_FILIAL)}
	      	DEFINE CELL NAME "Nome_Emp"		OF oSection0 TITLE STR0028	SIZE Len(SM0->M0_NOMECOM)				BLOCK {|| AllTrim(SM0->M0_NOMECOM)}
	      	DEFINE CELL NAME "CNPJ_Emp"		OF oSection0 TITLE cTitCNPJ	SIZE Len(AllTrim(X3Picture("A1_CGC")))	BLOCK {|| If(!Empty(SM0->M0_CGC),AllTrim(Transform(SM0->M0_CGC, X3Picture("A1_CGG"))),Space(Len(AllTrim(X3Picture("A1_CGC")))))}
	      	DEFINE CELL NAME "Ende_Emp"		OF oSection0 TITLE STR0023	SIZE nEndEmpr							BLOCK {|| AtR870End("E", SM0->M0_ENDENT, SM0->M0_BAIRENT, SM0->M0_CEPENT, SM0->M0_CIDENT, SM0->M0_ESTENT)}
	      	DEFINE CELL NAME "Usua_Emp"		OF oSection0 TITLE STR0032	SIZE 25									BLOCK {|| SubStr(cUsuario,7,25)}

	//Seção 1
	DEFINE SECTION oSection1 OF oReport TITLE STR0002 TABLES "SA1" BREAK HEADER //"Clientes"

   		//Células Seção 1
	      	DEFINE CELL NAME "A1_COD"	  		OF oSection1 ALIAS "SA1"				SIZE nCodCli								BLOCK {|| If (MV_PAR01 == 1, (cAlias)->A1_COD,  AllTrim(SM0->M0_NOME))}
	      	DEFINE CELL NAME "A1_LOJA"			OF oSection1 ALIAS "SA1"				SIZE nFilCli								BLOCK {|| If (MV_PAR01 == 1, (cAlias)->A1_LOJA, AllTrim(SM0->M0_FILIAL))}	
	      	DEFINE CELL NAME "A1_NOME"			OF oSection1 ALIAS "SA1"				SIZE nNomeCli								BLOCK {|| If (MV_PAR01 == 1, (cAlias)->A1_NOME, AllTrim(SM0->M0_NOMECOM))}
	      	DEFINE CELL NAME "A1_CGC"			OF oSection1 ALIAS "SA1"				SIZE Len(AllTrim(X3Picture("A1_CGC")))	BLOCK {|| AllTrim( Transform( If (MV_PAR01 == 1, (cAlias)->A1_CGC, SM0->M0_CGC ), X3Picture("A1_CGG") ) )}
	      	If Type("MV_PAR01") == 'N' .AND. MV_PAR01 == 2
	      		DEFINE CELL NAME "End_Cli"		OF oSection1 TITLE STR0023			SIZE nEnder								BLOCK {|| AtR870End("E", SM0->M0_ENDENT, SM0->M0_BAIRENT, SM0->M0_CEPENT, SM0->M0_CIDENT, SM0->M0_ESTENT)}
	      		DEFINE CELL NAME "Usua_Cli"		OF oSection1 TITLE STR0032			SIZE 25									BLOCK {|| SubStr(cUsuario,7,25)}
	      	EndIf
		
	//Seção 2
	DEFINE SECTION oSection2 OF oSection1 TITLE STR0024 TABLES "TFQ" BREAK HEADER LEFT MARGIN 05 //"Armas do Local"

     	DEFINE CELL NAME "Filial Movimentação"	 OF oSection2 TITLE  STR0036		SIZE nLoc		BLOCK {|| (cAlias)->TFQ_FILIAL}	 //"Filial Movimentação" 

   		//Células Seção 2
		If lMultFil
			DEFINE CELL NAME "Filial Orig."	 OF oSection2 TITLE  STR0037		SIZE nLoc		BLOCK {|| (cAlias)->TFQ_FILORI}	 //"Filial Orig."
		Endif

		DEFINE CELL NAME "Local Orig."	 OF oSection2 TITLE STR0034		SIZE nLoc		BLOCK {|| (cAlias)->TFQ_ORIGEM}										//"Local Orig."
		If lMultFil
			DEFINE CELL NAME "Descri Orig."		OF oSection2 TITLE STR0033		SIZE nLocDes 	BLOCK {|| GetDescri((cAlias)->TFQ_ENTORI,(cAlias)->TFQ_ORIGEM,(cAlias)->TFQ_FILORI)}		//"Descrição Orig."
		Else
			DEFINE CELL NAME "Descri Orig."		OF oSection2 TITLE STR0033		SIZE nLocDes 	BLOCK {|| GetDescri((cAlias)->TFQ_ENTORI,(cAlias)->TFQ_ORIGEM)}		//"Descrição Orig."
		Endif
		
		DEFINE CELL NAME "Tipo Orig."		OF oSection2 TITLE STR0005 		SIZE 10			BLOCK {|| If ((cAlias)->TFQ_ENTORI  == '1', STR0007,  STR0006)}		//"Tipo" ## "Cofre" ## "Cliente"
		
		If lMultFil
			DEFINE CELL NAME "Filial Dest."	OF oSection2 TITLE  STR0038		SIZE nLoc		BLOCK {|| (cAlias)->TFQ_FILDES } 	//"Filial Dest."
		Endif
		DEFINE CELL NAME "Local Dest."	OF oSection2 TITLE STR0003		SIZE nLoc		BLOCK {|| (cAlias)->TFQ_DESTIN } 	//"Local Dest."
		If lMultFil
			DEFINE CELL NAME "Descri Dest."		OF oSection2 TITLE STR0004 		SIZE nLocDes 	BLOCK {|| GetDescri(IIF((cAlias)->TFQ_ENTDES=='1','2','1'),(cAlias)->TFQ_DESTIN,(cAlias)->TFQ_FILDES) } 	//"Descrição Dest."
		Else
			DEFINE CELL NAME "Descri Dest."		OF oSection2 TITLE STR0004 		SIZE nLocDes 	BLOCK {|| GetDescri(IIF((cAlias)->TFQ_ENTDES=='1','2','1'),(cAlias)->TFQ_DESTIN) } 	//"Descrição Dest."			
		Endif
		DEFINE CELL NAME "Tipo Dest."		OF oSection2 TITLE STR0005		SIZE 10			BLOCK {|| If ((cAlias)->TFQ_ENTDES  == '1', STR0006,  STR0007)}				//"Tipo" ## "Cliente" ## "Cofre"	

 	//Seção 3
	DEFINE SECTION oSection3 OF oSection2 TITLE STR0024 TABLE "TE0","TFQ" BREAK HEADER LEFT MARGIN 10	//"Armas do Local"

		//Células Seção 3
   			DEFINE CELL NAME "TE0_COD"		OF oSection3 ALIAS "TE0" BLOCK {|| (cAlias)->TE0_COD}
			DEFINE CELL NAME "TE0_ESPEC"	OF oSection3 ALIAS "TE0" SIZE 20 BLOCK {|| Iif(!EMPTY(cCBox),SubStr(aCBox[Val((cAlias)->TE0_ESPEC)], 3),TecSx5Desc("GS",(cAlias)->TE0_ESPEC))}
			DEFINE CELL NAME "TE0_ATIVO"	OF oSection3 ALIAS "TE0" BLOCK {|| (cAlias)->TE0_ATIVO}
			
			DEFINE CELL NAME "TE0_MARCA"	OF oSection3 ALIAS "TE0" BLOCK {|| Posicione("SX5",1,xFilial("SX5")+"79"+(cAlias)->TE0_MARCA,"X5_DESCRI")}
			DEFINE CELL NAME "TE0_CALIBR"	OF oSection3 ALIAS "TE0" BLOCK {|| (cAlias)->TE0_CALIBR}
			DEFINE CELL NAME "TE0_MODELO"	OF oSection3 ALIAS "TE0" BLOCK {|| (cAlias)->TE0_MODELO}
			DEFINE CELL NAME "VALIDA"	OF oSection3 TITLE cTitle1 Size nTamDt BLOCK {||  IIF(oReport:GetOrientation() == 1, ;
																				Transform(Left(StrTran(DtoC((cAlias)->TE0_VALIDA),"/"),4) +;
																				          Right(dtoc((cAlias)->TE0_VALIDA), 2), "@R 99/99/99"), Transform((cAlias)->TE0_VALIDA, "@R 99/99/9999")) }
			DEFINE CELL NAME "TE0_NUMREG"	OF oSection3 ALIAS "TE0" BLOCK {|| (cAlias)->TE0_NUMREG}
			DEFINE CELL NAME "DTREG"	OF oSection3  TITLE cTitle2  Size nTamDt  BLOCK {||  IIF(oReport:GetOrientation() == 1, ;
																				Transform(Left(StrTran(DtoC((cAlias)->TE0_DTREG),"/"),4) +;
																				          Right(dtoc((cAlias)->TE0_DTREG), 2), "@R 99/99/99"), Transform((cAlias)->TE0_DTREG, "@R 99/99/9999")) }
			DEFINE CELL NAME "TE0_SINAE"	OF oSection3 ALIAS "TE0" BLOCK {|| (cAlias)->TE0_SINAE}
			DEFINE CELL NAME "TE0_SINARM"	OF oSection3 ALIAS "TE0" BLOCK {|| (cAlias)->TE0_SINARM}
			DEFINE CELL NAME "TE0_SITUA"	OF oSection3 ALIAS "TE0" BLOCK {|| (cAlias)->TE0_SITUA}
			DEFINE CELL NAME "TFQ_CODIGO"   OF oSection3 TITLE STR0035 ALIAS "TFQ" BLOCK {|| (cAlias)->TFQ_CODIGO}
			DEFINE CELL NAME "DMOVIM"	OF oSection3 TITLE cTitle3 Size nTamDt BLOCK {||  IIF(oReport:GetOrientation() == 1, ;
																				Transform(Left(StrTran(DtoC((cAlias)->TFQ_DMOVIM),"/"),4) +;
																				          Right(dtoc((cAlias)->TFQ_DMOVIM), 2), "@R 99/99/99"), Transform((cAlias)->TFQ_DMOVIM, "@R 99/99/9999")) }
			DEFINE CELL NAME "Retirado"		OF oSection3 TITLE STR0009			SIZE nNome		BLOCK {|| (cAlias)->RA_NOME}	//"Retirado Por:"
			DEFINE CELL NAME "Num. Guia"	OF oSection3 TITLE STR0010			SIZE nGuia		BLOCK {|| IIF (EMPTY((cAlias)->TFQ_NGUIA),STR0012,(cAlias)->TFQ_NGUIA)}//"Guia de Transporte"
			DEFINE CELL NAME "Justif"		OF oSection3 TITLE STR0011			SIZE nJust		BLOCK {|| TFQ->(DbGoTo((cAlias)->TFQREC)),TFQ->TFQ_JUSTIF} //"Justificativa"

	DEFINE FUNCTION FROM oSection3:Cell("TE0_COD") OF oSection0 FUNCTION COUNT TITLE STR0014 NO END SECTION	//"Total de Armas"

Return oReport

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport

Função responsavél pela impressão do relatório
@author Serviços
@since 02/01/2013
@version P11 R9

@return Nil,Não Retorna Nada
/*/ 
//----------------------------------------------------------------------------------------------------------------------
Static Function PrintReport(oReport, cPerg, cAlias)
Local oSection0 	:= oReport:Section(1)	// Objeto secao 0 do relatorio
Local oSection1 	:= oReport:Section(2)	// Objeto secao 1 do relatorio
Local oSection2 	:= oSection1:Section(1)	// Objeto secao 2 do relatorio 
Local oSection3 	:= oSection2:Section(1)	// Objeto secao 3 do relatorio 
Local cFiltro	   	:= ""      				// String contendo o filtro de busca a ser utilizado com DBF
Local cSQL      	:= ""                 	// String contendo a expressão utilizada na query  
Local cRange		:= ""						// Contém a expressão Range
Local cBetween		:=  Replicate("Z", TE0->(TamSx3("TE0_LOCAL")[1]))				//String para realizar o between nas querys
Local cCdMov		:= ""
Local cFilBkp		:= cFilAnt
Local cSlc			:= "%%"
Local lMultFil 		:= TFQ->(ColumnPos("TFQ_FILORI")) .And. TFQ->(ColumnPos("TFQ_FILDES")) .And. FindFunction("TecMtFlArm") .And. TecMtFlArm()
Local lMvFil		:= TecHasPerg("MV_PAR11","TECR870")
Local cFilTFO		:= ""
Local cCodTFQ		:= ""
Local cFilTFQ		:= ""
Local cFilialTFQ 	:= "%%"
Local cFilialTFO    := "%%"
Local cFilialTE0 	:= "%%"
Local cFilialAA1 	:= "%%"
Local cFilialSRA 	:= "%%"

Default	cPerg		:= "TECR870"
Default cAlias		:= GetNextAlias()

MakeSqlExpr(cPerg)

If lMultFil
  	cSlc := "%, TFQ.TFQ_FILDES, TFQ.TFQ_FILORI %"
Endif

If lMvFil .And. !Empty(MV_PAR11)
	cFilialTE0 := "% "+MV_PAR11+" %"
	cFilialTFQ := "%" + FWJoinFilial("TE0" , "TFQ" , "TE0", "TFQ", .T.) + "%"
	cFilialTFO := "%" + FWJoinFilial("TFQ" , "TFO" , "TFQ", "TFO", .T.) + "%"
	cFilialAA1 := "%" + FWJoinFilial("TFQ" , "AA1" , "TFQ", "AA1", .T.) + "%"
	cFilialSRA := "%" + FWJoinFilial("AA1" , "SRA" , "AA1", "SRA", .T.) + "%"
Else
	cFilialTFQ := "% TFQ.TFQ_FILIAL = '"+xFilial("TFQ")+"' %"
	cFilialTFO := "% TFO.TFO_FILIAL = '"+xFilial("TFO")+"' %"
	cFilialTE0 := "% TE0.TE0_FILIAL = '"+xFilial("TE0")+"' %"
	cFilialAA1 := "% AA1.AA1_FILIAL = '"+xFilial("AA1")+"' %"
	cFilialSRA := "% SRA.RA_FILIAL  = '"+xFilial("SRA")+"' %"
Endif

If (MV_PAR01 == 1) //Local de Atendimento 
	cSQL += " TFQ.TFQ_ENTDES = '1' AND TFQ.TFQ_DESTIN BETWEEN "
	
	If !Empty(MV_PAR02) //Local de Atendimento De?
		cSQL += " '" + MV_PAR02 + "'"
	Else
		cSQL += " ' ' "
	EndIf
	
	If !Empty(MV_PAR03) //Local de Atendimento Ate?
		cBetween := MV_PAR03
	EndIf
	
	cSQL += " AND '" + cBetween + "' "
	
ElseIf (MV_PAR01 == 2) //Cofre

	cSQL += " TFQ.TFQ_ENTDES = '2' AND TFQ.TFQ_DESTIN BETWEEN "
	If !Empty(MV_PAR04) //Cofre De?
		cSQL += " '" + MV_PAR04 + "'"
	Else
		cSQL += " ' ' "
	EndIf
	
	If !Empty(MV_PAR05)
		cBetween := MV_PAR05
	EndIf		

	cSQL += " AND '" + cBetween + "' "
		
EndIf

If !Empty(MV_PAR06)

	If !EMPTY(cSQL)
		cSQL += " AND "
	EndIf
	
	cSQL += " TE0.TE0_SITUA ='" + MV_PAR06 + "' "
EndIf

If TYPE("MV_PAR09") == 'D' .AND. TYPE("MV_PAR10") == 'D'

	If !EMPTY(cSQL)
		cSQL += " AND "
	EndIf

	cSQL += " TFQ.TFQ_DMOVIM >= '" + DtoS(MV_PAR09) + "' "
	cSQL += " AND TFQ.TFQ_DMOVIM <= '" + DtoS(MV_PAR10) + "' "
EndIf

If TYPE("MV_PAR07") == 'C' .AND. TYPE("MV_PAR08") == 'C'

	If !EMPTY(cSQL)
		cSQL += " AND "
	EndIf

	cSQL += " TE0.TE0_COD >= '" + MV_PAR07 + "' "
	cSQL += " AND TE0.TE0_COD <= '" + MV_PAR08 + "' "
EndIf

cSQL := "%"+cSQL+"%"

BEGIN REPORT QUERY oSection1
	BeginSql Alias cAlias
		SELECT TFQ.TFQ_FILIAL,TE0.TE0_COD,TE0.TE0_DOC,TE0.TE0_SERIE, TE0.TE0_DTNOTA, TE0.TE0_COMPRA, 
			TE0.TE0_CODFOR, TE0.TE0_LOJA, TE0.TE0_CODPRO, TE0.TE0_ITEM, TE0.TE0_ATIVO, TE0.TE0_MARCA, TE0.TE0_CALIBR, 
			TE0.TE0_MODELO, TE0.TE0_VALIDA, TE0.TE0_NUMREG, TE0.TE0_DTREG, TE0.TE0_SINAE,  TE0.TE0_SINARM, TE0.TE0_CDPAIS, 
			TFQ.TFQ_DMOVIM, TE0.TE0_ESPEC,  TE0.TE0_LOCAL,  TE0.TE0_SITUA, TFQ.TFQ_RESTRA, TFQ.TFQ_NGUIA,   
			TFQ.TFQ_CODIGO, TFQ.TFQ_DESTIN, TFQ.TFQ_ENTDES , TFQ.TFQ_ENTORI , TFQ.TFQ_ORIGEM , AA1.AA1_CODTEC, AA1.AA1_CDFUNC, SRA.RA_MAT,
			SRA.RA_NOME	,	TFO.TFO_FILIAL, TFO.TFO_CDMOV , TFQ.R_E_C_N_O_ AS TFQREC %exp:cSlc%	
		FROM %Table:TFQ% TFQ
			INNER JOIN  %Table:TFO% TFO ON TFQ.TFQ_CODIGO = TFO.TFO_CDMOV AND %Exp:cFilialTFO% AND TFO.%NotDel%
			INNER JOIN %Table:TE0% TE0 ON TFO.TFO_ITCOD = TE0.TE0_COD AND %Exp:cFilialTE0% AND TE0.%NotDel%
			LEFT  JOIN %Table:AA1% AA1 ON AA1_CODTEC = TFQ.TFQ_RESTRA AND %Exp:cFilialAA1% AND AA1.%NotDel%
			LEFT  JOIN %Table:SRA% SRA ON SRA.RA_MAT = AA1.AA1_CDFUNC AND %Exp:cFilialSRA% AND  SRA.%NotDel%
		WHERE %Exp:cSQL% AND %Exp:cFilialTFQ% AND TFQ.%NotDel%
		AND TFO.TFO_ITMOV =  '1'
		ORDER BY TFQ.TFQ_FILIAL,TFQ.TFQ_CODIGO,TFO.TFO_CDMOV, TFQ.TFQ_DMOVIM
	EndSql
END REPORT QUERY oSection1 

oSection0:EndQuery()
oSection0:SetParentQuery(.F.)

If !IsBlind()
	oSection0:Init()
	oSection0:PrintLine()
	oSection0:Finish()
EndIf

oSection1:SetParentQuery(.F.)

If !IsBlind()
	oSection1:Init()
EndIf
oSection2:SetParentQuery(.F.)

oSection3:SetParentQuery(.F.)

MakeAdvplExpr(cPerg)

While !(cAlias)->(EOF())

	If MV_PAR01 == 3
		If LocInFilter( (cAlias)->(TFQ_ENTORI),;
						(cAlias)->(TFQ_ORIGEM),;
						(cAlias)->(TFQ_ENTDES),;
						(cAlias)->(TFQ_DESTIN))
			(cAlias)->(DbSkip())
			Loop
		Endif
	EndIf
	
	If !IsBlind()
		oSection2:Init()
		oSection2:PrintLine()
		oSection2:Finish()
	EndIf

	cFilTFQ := ""
	cCodTFQ := ""
	cFilTFO := (cAlias)->(TFO_FILIAL)
	cCdMov  := (cAlias)->(TFO_CDMOV)

	While !(cAlias)->(EOF()) .AND. cCdMov == (cAlias)->(TFO_CDMOV) .And. cFilTFO == (cAlias)->(TFO_FILIAL)

		If lMvFil .And. !Empty(MV_PAR11) .And. !Empty(cCodTFQ) .And. cCodTFQ == (cAlias)->(TFQ_CODIGO) .And. !Empty(cFilTFQ) .And. (cAlias)->(TFQ_FILIAL) <> cFilTFQ
			(cAlias)->(DbSkip())
			Loop
		Endif

		If !IsBlind()
			oSection3:Init()
			oSection3:PrintLine()
		EndIf

		cFilTFQ := (cAlias)->(TFQ_FILIAL)
		cCodTFQ := (cAlias)->(TFQ_CODIGO)

		(cAlias)->(DbSkip())
	End
	If !IsBlind()
		oSection3:Finish()
	EndIf
End

oSection1:Finish()
(cAlias)->(DbCloseArea())

Return Nil

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} AtR870End
Função responsavél pelo tratamento da informação do ENDEREÇO do cliente externo ou local interno
@author Serviços
@since 17/06/2015
@version P12
@return xRetorno (Quando cTpRetorno = "T", retorna o tamanho da string, e quando cTpRetorno = "E", retorna o endereço concatenado)
/*/ 
//----------------------------------------------------------------------------------------------------------------------
Static Function AtR870End(cTpRetorno, cEnder, cBairro, cCep, cMunic, cUF)
Local xRetorno	:= Nil	// Variável de retorno da função.
Local cEndCompl	:=	""
Local nTamanho	:=	0

Default cEnder	:= ""
Default cBairro	:= ""
Default cCep		:= ""
Default cMunic	:= ""
Default cUF		:= ""

If cTpRetorno == "T" // Retorna o cálculo do Tamanho

	nTamanho	+=	If( TamSX3("ABS_END")[1]    > TamSX3("TER_END")[1],    TamSX3("ABS_END")[1],    TamSX3("TER_END")[1] ) + 2
	nTamanho	+=	If( TamSX3("ABS_BAIRRO")[1] > TamSX3("TER_BAIRRO")[1], TamSX3("ABS_BAIRRO")[1], TamSX3("TER_BAIRRO")[1] ) + 2
	nTamanho	+=	Len(AllTrim(STR0025)) + 1 + Len(AllTrim(X3Picture("ABS_CEP"))) + 2	//"Cep" 
	nTamanho	+=	If( TamSX3("ABS_MUNIC")[1]  > TamSX3("CC2_MUN")[1],    TamSX3("ABS_MUNIC")[1],  TamSX3("CC2_MUN")[1] ) + 2
	nTamanho	+=	If( TamSX3("ABS_ESTADO")[1] > TamSX3("TER_ESTADO")[1], TamSX3("ABS_ESTADO")[1], TamSX3("TER_ESTADO")[1] )
	xRetorno  := nTamanho

ElseIf cTpRetorno == "E" // Retorna a string com o endereço completo (concatenado)

	cEndCompl += If(!Empty(cEnder), AllTrim(cEnder)+", ",															"")
	cEndCompl += If(!Empty(cBairro),AllTrim(cBairro)+", ",															"")
	cEndCompl += If(!Empty(cCep),   AllTrim(STR0025)+":"+AllTrim(Transform(cCep,X3Picture("ABS_CEP")))+", ",	"")	//"Cep"
	cEndCompl += If(!Empty(cMunic), AllTrim(cMunic)+", ",															"")
	cEndCompl += If(!Empty(cUF),    AllTrim(cUF),																		"")
	xRetorno  := cEndCompl

EndIf
Return xRetorno

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} GetDescri
Retorna a descrição de um Cofre ou Local de Atendimento

@author Mateus.Boiani

@param	cTipo, char, indica o tipo da busca 
			(cTipo == 1 -> Cofre ;
			cTipo == 2 -> Cliente)
@param cCod, caracter, PK da busca

@since 10/12/2018
@version P12
@return nRet, caracter, descrição do cofre/local
/*/ 
//----------------------------------------------------------------------------------------------------------------------
Static Function GetDescri(cTipo, cCod, cFil)
Local cRet := ""
Local aArea := GetArea()
Local cAliasAux := GetNextAlias()
Local cFilBkp := cFilAnt
Default cTipo := ""
Default cFil  := ""

If !Empty(cFil) .And. cFil <> cFilAnt
	cFilAnt := cFil
Endif

IF cTipo == "1"

	BeginSQL Alias cAliasAux
		SELECT  TER.TER_DESCRI
		FROM %Table:TER% TER
	WHERE
		TER.TER_FILIAL = %xFilial:TER% AND
		TER.TER_CODIGO = %Exp:cCod% AND
		TER.%notDel%
	EndSql
	
	cRet := (cAliasAux)->(TER_DESCRI)
	(cAliasAux)->(DbCloseArea())
ElseIf cTipo == "2"
	
	BeginSQL Alias cAliasAux
		SELECT  ABS.ABS_DESCRI
		FROM %Table:ABS% ABS
	WHERE
		ABS.ABS_FILIAL = %xFilial:ABS% AND
		ABS.ABS_LOCAL = %Exp:cCod% AND
		ABS.%notDel%
	EndSql
	
	cRet := (cAliasAux)->(ABS_DESCRI)
	(cAliasAux)->(DbCloseArea())
EndIf

If cFilAnt <> cFilBkp
	cFilAnt := cFilBkp
Endif
RestArea(aArea)
Return RTRIM(cRet)

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} LocInFilter
Aplica o filtro de Local/Cofre no local de origem/destino

@author Mateus.Boiani

@param cEntOri, caracter, TFQ_ENTORI
@param cOrigem, caracter, Código do local/cofre de origem
@param cEntDes, caracter, TFQ_ENTDES
@param cDestino, caracter, Código do local/cofre de destino

@since 13/12/2018
@version P12
@return lRet, bool, Retorna .T. caso esteja fora dos filtros
/*/ 
//----------------------------------------------------------------------------------------------------------------------
Static Function LocInFilter(cEntOri,cOrigem,cEntDes,cDestino)
Local lRet := .F.

If cEntOri == '1' .And. !lRet
	lRet := cOrigem < MV_PAR04 .OR. cOrigem > MV_PAR05
EndIf

If cEntOri == '2' .And. !lRet
	lRet := cOrigem < MV_PAR02 .OR. cOrigem > MV_PAR03
EndIf

If cEntDes == '1' .And. !lRet
	lRet := cDestino < MV_PAR02 .OR. cDestino > MV_PAR03
EndIf

If cEntDes == '2' .And. !lRet
	lRet := cDestino < MV_PAR04 .OR. cDestino > MV_PAR05
EndIf

Return lRet

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
