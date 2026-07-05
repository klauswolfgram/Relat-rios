/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TOTVS.CH"
#INCLUDE "PONCALEN.CH"
#INCLUDE "PONR210.CH"

Static cSRAWhere := ""
Static cAliasSPC := ""
Static cAliasAbo := ""

/*/{Protheus.doc} PONR210
Relatório de absenteísmo.
@type Function
@version 12.1.2210
@author Cícero Alves
@since 21/08/2023
@see https://tdn.totvs.com/pages/viewpage.action?pageId=781854828
/*/
User Function PONR210()
	
	Local oReport
	
	Private cAliasSRA	:= GetNextAlias()
	Private cAliasPer 	:= GetNextAlias()
	Private cAliasLanc 	:= GetNextAlias()
	Private oTmpPer   	:= NIL
	Private oTmpLanc	:= NIL
	
	oReport := ReportDef()
	// Não imprime o total geral
	oReport:bTotalcanprint := {|| .F. }
	oReport:PrintDialog()
	
	cSRAWhere := ""
	
	If oTmpPer <> Nil
		oTmpPer:Delete()
		Freeobj(oTmpPer)
    EndIf
	
	If oTmpLanc <> Nil
		oTmpLanc:Delete()
		Freeobj(oTmpLanc)
    EndIf
	
Return

/*/{Protheus.doc} ReportDef
Definição dos Componentes de impressão do relatório
@type Static Function
@author Cícero Alves
@since 21/08/2023
/*/
Static Function ReportDef()
	
	Local oReport
	Local oSecFunc
	Local oSecPer
	Local oSecLanc2
	Local cPerg 	:= "PONR210"
	Local aOrdens	:= {STR0001, STR0002, STR0003, STR0004, STR0005} // "Matrícula", "Centro de Custo", "Nome", "Turno", "C.Custo + Nome"
	
	oReport := TReport():New("PONR210", STR0006, cPerg, {|oReport| ReportPrint(oReport)}, STR0006) // "Relatório de Absenteísmo"
	
	// Não imprime a página de parâmetros
	oReport:HideParamPage()
	
	// Funcionários
	oSecFunc := TRSection():New(oReport, STR0007, "SRA", aOrdens, , , , , .F., .F., .F., , , , , .T.)
	
	TRCell():New(oSecFunc, "RA_FILIAL"		, "SRA", 		, 				,  FWGETTAMFILIAL, .F.										)
	TRCell():New(oSecFunc, "RA_MAT"   		, "SRA", 		, 				, 			  	8, .F.										)
	TRCell():New(oSecFunc, "RA_NOME"  		, "SRA", 		, 				,	 		   30, .F.										)
	TRCell():New(oSecFunc, "RA_CC"  		, "SRA", 		, 				,	 		    9, .F.										)
	TRCell():New(oSecFunc, "CTT_DESC01"		, "SRA", STR0008, 				,	 		   30, .F., {|| (cAliasSRA)->(DescCC(RA_CC,RA_FILIAL))}) // "Desc. C. Custo"
	
	// Posiciona na SRA
	TRPosition():New( oSecFunc, "SRA", 1, {|| (cAliasSRA)->(RA_FILIAL + RA_MAT)}, .T.)
	
	// Períodos
	oSecPer := TRSection():New(oSecFunc, STR0009, cAliasPer, , , , , , .T., .F., .F., , , , , .T.)
	oSecPer:SetRelation({|| (cAliasSRA)->(RA_FILIAL + RA_MAT) }, cAliasPer, 1, .T.)
	oSecPer:SetParentFilter({|cParam| (cAliasPer)->(FILIAL + MAT) == cParam} , {|| (cAliasSRA)->(RA_FILIAL + RA_MAT) })
	oSecPer:SetTotalInLine(.F.)
	oSecPer:SetLeftMargin(2)
	
	TRCell():New(oSecPer, "PERIODO"  		, cAliasPer, STR0010,			    , 23, .F., , , , "RIGHT"	) // "Período de Apontamento"
	TRCell():New(oSecPer, "HPREVISTAS"  	, cAliasPer, STR0011, "@E 999.99"	,  6, .F., , , , "RIGHT"	) // "Hrs. Prev."
	TRCell():New(oSecPer, "HREAL"  			, cAliasPer, STR0012, "@E 999.99"	,  6, .F., , , , "RIGHT"	) // "Hrs. Real."
	TRCell():New(oSecPer, "HREALPER"		, cAliasPer, STR0013, "@E 999.99"	,  6, .F., , , , "RIGHT"	) // "%Hrs. Real."
	TRCell():New(oSecPer, "HNTRAB"  		, cAliasPer, STR0014, "@E 999.99"	,  6, .F., , , , "RIGHT"	) // "Hrs. N. Trab."
	TRCell():New(oSecPer, "HNTRABPER"		, cAliasPer, STR0015, "@E 999.99"	,  6, .F., , , , "RIGHT"	) // "%Hrs. N. Trab."
	TRCell():New(oSecPer, "HABO"  			, cAliasPer, STR0016, "@E 999.99"	,  6, .F., , , , "RIGHT"	) // "Hrs. Abonadas"
	TRCell():New(oSecPer, "HABOPER"			, cAliasPer, STR0017, "@E 999.99"	,  6, .F., , , , "RIGHT"	) // "%Hrs. Abonadas"
	TRCell():New(oSecPer, "HAFAST" 			, cAliasPer, STR0018, "@E 999.99"	,  6, .F., , , , "RIGHT"	) // "Hrs. Afast."
	TRCell():New(oSecPer, "HAFASTPER"		, cAliasPer, STR0019, "@E 999.99"	,  6, .F., , , , "RIGHT"	) // "%Hrs. Afast."
	
	//*** Utilizada na impressão em planilha ****\\
	// Lançamentos
	oSecLanc2 := TRSection():New(oSecFunc, STR0020, cAliasLanc, , , , , , .F., .F., .F., , , , , .T.)
	oSecLanc2:SetRelation({|| (cAliasSRA)->(RA_FILIAL + RA_MAT) }, cAliasLanc, 1, .T.)
	oSecLanc2:SetParentFilter({|cParam| (cAliasLanc)->(FILIAL + MAT) == cParam} , {|| (cAliasSRA)->(RA_FILIAL + RA_MAT) })
	oSecLanc2:SetLeftMargin(4)
	
	// Eventos
	TRCell():New(oSecLanc2, "PD"    	, cAliasLanc, STR0021, 			  ,	 3, .F.					) // "Cod"
	TRCell():New(oSecLanc2, "PDDESC"	, cAliasLanc, STR0022, 			  , 20, .F.					) // "Evento"
	TRCell():New(oSecLanc2, "PDQUANTC"	, cAliasLanc, STR0023, "@E 999.99",  6, .F., , , , "RIGHT"	) // "Horas"
	TRCell():New(oSecLanc2, "PDPERC"	, cAliasLanc, STR0024, "@E 999.99",	 6, .F., , , , "RIGHT"	) // "%Horas"
	// Abono
	TRCell():New(oSecLanc2, "ABO"  		, cAliasLanc, STR0025, 			  ,	 3, .F.					) // "Abono"
	TRCell():New(oSecLanc2, "ABODESC"	, cAliasLanc, STR0026, 			  , 20, .F.					) // "Motivo"
	TRCell():New(oSecLanc2, "ABOQUANTC"	, cAliasLanc, STR0027, "@E 999.99",  6, .F., , , , "RIGHT"	) // "Hrs. Abonadas"
	TRCell():New(oSecLanc2, "ABOPERC"	, cAliasLanc, STR0028, "@E 999.99",	 6, .F., , , , "RIGHT"	) // "%Hrs. Abonadas"
	// Afastamento
	TRCell():New(oSecLanc2, "AFAS"  	, cAliasLanc, STR0029, 			  ,	 3, .F.					) // "Afastamento"
	TRCell():New(oSecLanc2, "AFASDESC"	, cAliasLanc, STR0030, 			  , 20, .F.					) // "Descrição"
	TRCell():New(oSecLanc2, "AFASQUANTC", cAliasLanc, STR0031, "@E 999.99",  6, .F., , , , "RIGHT"	) // "Hrs. Afast."
	TRCell():New(oSecLanc2, "AFASPERC"	, cAliasLanc, STR0032, "@E 999.99",  6, .F., , , , "RIGHT"	) // "%Hrs. Afast."
	
Return oReport

/*/{Protheus.doc} ReportPrint
Realiza a busca das informações e impressão do relatório, ajusta o layout para impressões em arquivo
@type Static Function
@author Cícero Alves
@since 21/08/2023
@param oReport, Objeto, Instância da classe treport
/*/
Static Function ReportPrint(oReport)
	
	Local nOrdem   		:= oReport:Section(1):GetOrder()
	Local oSecFunc		:= oReport:Section(1)
	Local oSecLanc2		:= oSecFunc:Section(2)
	Local lDiscri		:= .T.
	Local lAfastPrev	:= .T.
	Local lSintetico	:= .F.
	Local cWhere		:= GetSRAWhere()
	Local lBreakCC		:= MV_PAR12 == 1
	
	Pergunte("PONR210", .F.)
	
	lSintetico := MV_PAR09 == 2
	lDiscri := MV_PAR10 == 1
	lAfastPrev := MV_PAR11 == 1
	
	//Cria as tabelas temporárias
	If oTmpLanc == NIL
		CriaTabLan()
	EndIf
	If oTmpPer == NIL
		CriaTabPer()
	EndIf
	
	// Realiza ajustes no layout para impressões em arquivo 
	// Adiciona os totalizadores
	If !oReport:nDevice == 4 .Or. (oReport:nDevice = 4 .And. oReport:nExcelPrintType <= 2)
		oSecLanc2:Disable()
		oReport:setTitle(STR0006 + " " + dToC(MV_PAR07) + " - " + dToC(MV_PAR08))
		SetSecLanc(oReport)
		CriaBreak(oReport)
		
		If lSintetico
			oSecFunc:Hide()
			oSecFunc:Section(1):Hide()
			oSecFunc:Section(1):Section(1):Hide()
		EndIf
	EndIf
	
	// Ordena a busca na SRA de acordo com a ordem selecionada
	If nOrdem == 2 .Or. lBreakCC // Centro de Custo
		cOrder := "%RA_FILIAL, RA_CC%"
	ElseIf nOrdem == 3 // Nome
		cOrder := "%RA_FILIAL, RA_NOME%"
	ElseIf nOrdem == 4 // Turno
		cOrder := "%RA_FILIAL, RA_TNOTRAB%"
	ElseIf nOrdem == 5 // C.Custo + Nome"
		cOrder := "%RA_FILIAL, RA_CC, RA_NOME%"
	Else
		cOrder := "%RA_FILIAL, RA_MAT%"
	EndIf
	
	cWhere := "%" + cWhere + "%"
	
	// Busca as informações dos funcionários
	oSecFunc:BeginQuery()
		BEGINSQL ALIAS cAliasSRA
			SELECT RA_FILIAL, RA_MAT, RA_NOME, RA_CC, RA_TNOTRAB, R_E_C_N_O_ AS RECNO
			FROM %Table:SRA% SRA
			WHERE %Exp:cWhere% AND
				SRA.%NotDel%
			ORDER BY %Exp:cOrder%
		ENDSQL
	oSecFunc:EndQuery()
	
	// Busca as informações das horas por período de apontamento
	GetPer()
	
	oSecFunc:Print()
	
Return

/*/{Protheus.doc} SetSecLanc
Recria a seção de lançamentos tendo como owner a seção de períodos
@type Static Function
@author Cícero Alves
@since 21/08/2023
@param oReport, Objeto, Instância da classe treport
/*/
Static Function SetSecLanc(oReport)
	
	Local oSecPer := oReport:Section(1):Section(1)
	Local oSecLanc
	
	// Lançamentos
	oSecLanc := TRSection():New(oSecPer, , cAliasLanc, , , , , , .F., .F., .F., , , , , .T.)
	oSecLanc:SetRelation({|| (cAliasPer)->(FILIAL + MAT + PERIODO) }, cAliasLanc, 1, .T.)
	oSecLanc:SetParentFilter({|cParam| (cAliasLanc)->(FILIAL + MAT + PERIODO) == cParam} , {|| (cAliasPer)->(FILIAL + MAT + PERIODO) })
	oSecLanc:SetLeftMargin(4)
	
	//Eventos
	TRCell():New(oSecLanc, "PD"    		, cAliasLanc, STR0021, 			  ,	 3, .F.					) // "Cod"
	TRCell():New(oSecLanc, "PDDESC"		, cAliasLanc, STR0022, 			  , 20, .F.					) // "Evento"
	TRCell():New(oSecLanc, "PDQUANTC"	, cAliasLanc, STR0023, "@E 999.99",  6, .F., , , , "RIGHT"	) // "Horas"
	TRCell():New(oSecLanc, "PDPERC"		, cAliasLanc, STR0024, "@E 999.99",	 6, .F., , , , "RIGHT"	) // "%Horas"
	// Abono
	TRCell():New(oSecLanc, "ABO"  		, cAliasLanc, STR0025, 			  ,	 3, .F.					) // "Abono"
	TRCell():New(oSecLanc, "ABODESC"	, cAliasLanc, STR0026, 			  , 20, .F.					) // "Motivo"
	TRCell():New(oSecLanc, "ABOQUANTC"	, cAliasLanc, STR0027, "@E 999.99",  6, .F., , , , "RIGHT"	) // "Hrs. Abonadas"
	TRCell():New(oSecLanc, "ABOPERC"	, cAliasLanc, STR0028, "@E 999.99",	 6, .F., , , , "RIGHT"	) // "%Hrs. Abonadas"
	// Afastamento
	TRCell():New(oSecLanc, "AFAS"  		, cAliasLanc, STR0029, 			  ,	 3, .F.					) // "Afastamento"
	TRCell():New(oSecLanc, "AFASDESC"	, cAliasLanc, STR0030, 			  , 20, .F.					) // "Descrição"
	TRCell():New(oSecLanc, "AFASQUANTC"	, cAliasLanc, STR0031, "@E 999.99",  6, .F., , , , "RIGHT"	) // "Hrs. Afast."
	TRCell():New(oSecLanc, "AFASPERC"	, cAliasLanc, STR0032, "@E 999.99",	 6, .F., , , , "RIGHT"	) // "%Hrs. Afast."
	
Return

/*/{Protheus.doc} CriaBreak
Cria os totalizadores por centro de custo e por filial
@type Static Function
@author Cícero Alves
@since 21/08/2023
@param oReport, Objeto, Instância da classe treport
/*/
Static Function CriaBreak(oReport)
	
	Local oSecFunc	:= oReport:Section(1)
	Local oSecPer	:= oSecFunc:Section(1)
	Local oSecLanc	:= oSecPer:Section(1)
	Local oBreakFil
	Local oBreakCC
	Local nOrdem   		:= oReport:Section(1):GetOrder()
	Local bPercPrev 	:= {|| (oSecPer:GetFunction("TOTREA"):GetLastValue() / oSecPer:GetFunction("TOTPRE"):GetLastValue()) * 100  }
	Local bPercNTrab 	:= {|| (oSecPer:GetFunction("TOTNTRB"):GetLastValue() / oSecPer:GetFunction("TOTPRE"):GetLastValue()) * 100 }
	Local bPercAbo	 	:= {|| (oSecPer:GetFunction("TOTABO"):GetLastValue() / oSecPer:GetFunction("TOTNTRB"):GetLastValue()) * 100 }
	Local bPercAfast 	:= {|| (oSecPer:GetFunction("TOTAFAST"):GetLastValue() / oSecPer:GetFunction("TOTPRE"):GetLastValue()) * 100 	}
	Local bPerPreCC 	:= {|| (oSecPer:GetFunction("TOTREACC"):GetLastValue() / oSecPer:GetFunction("TOTPRECC"):GetLastValue()) * 100  }
	Local bPerNTraCC 	:= {|| (oSecPer:GetFunction("TOTNTRBCC"):GetLastValue() / oSecPer:GetFunction("TOTPRECC"):GetLastValue()) * 100 }
	Local bPerAboCC		:= {|| (oSecPer:GetFunction("TOTABOCC"):GetLastValue() / oSecPer:GetFunction("TOTNTRBCC"):GetLastValue()) * 100 }
	Local bPerAfasCC 	:= {|| (oSecPer:GetFunction("TOTAFASTCC"):GetLastValue() / oSecPer:GetFunction("TOTPRECC"):GetLastValue()) * 100 }
	Local lSintetico 	:= MV_PAR09 == 2
	Local lAfastPrev	:= MV_PAR11 == 1
	Local lBreakCC		:= MV_PAR12 == 1
	Local lCent			:= MV_PAR14 == 2
	Local lBreak		:= .F.
	Local cTitFil		:= ""
	Local aInfo			:= {}
	Local cFuncao		:= If(lCent, "SUM", "TIMESUM")
	
	If lBreakCC .Or. nOrdem == 5
		// Ajusta os totalizadares quando o relatório é impresso com horas em sexagesimal
		If !lCent
			bPerPreCC 	:= {|| (fConvHr(oSecPer:GetFunction("TOTREACC"):GetLastValue(), "D") / fConvHr(oSecPer:GetFunction("TOTPRECC"):GetLastValue(), "D")) * 100  }
			bPerNTraCC 	:= {|| (fConvHr(oSecPer:GetFunction("TOTNTRBCC"):GetLastValue(), "D") / fConvHr(oSecPer:GetFunction("TOTPRECC"):GetLastValue(), "D")) * 100  }
			bPerAboCC 	:= {|| (fConvHr(oSecPer:GetFunction("TOTABOCC"):GetLastValue(), "D") / fConvHr(oSecPer:GetFunction("TOTNTRBCC"):GetLastValue(), "D")) * 100  }
			bPerAfasCC 	:= {|| (fConvHr(oSecPer:GetFunction("TOTAFASTCC"):GetLastValue(), "D") / fConvHr(oSecPer:GetFunction("TOTPRECC"):GetLastValue(), "D")) * 100  }
		EndIf
		
		If lBreakCC
			lBreak := .T.
		ElseIf nOrdem == 5
			lBreak := .F. 
		EndIf

		oBreakCC := TRBreak():New(oReport, oSecFunc:Cell("RA_CC"), , lSintetico, , lBreak)
		oBreakCC:OnBreak({|x, y| oReport:SkipLine(), cTitFil := STR0033 + x }) // "Total para o Centro de Custo: "
		oBreakCC:SetTotalText({||cTitFil})
		
		TRFunction():New(oSecPer:Cell("HPREVISTAS"), "TOTPRECC"	, cFuncao, oBreakCC,, "@E 9,999,999.99", , .F., .T.)
		TRFunction():New(oSecPer:Cell("HREAL")	   , "TOTREACC"	, cFuncao, oBreakCC,,"@E 9,999,999.99", , .F., .F.)
		TRFunction():New(oSecPer:Cell("HREALPER")  , 		 	, "ONPRINT", oBreakCC,,"@E 9,999,999.99", bPerPreCC, .F., .F.)
		
		TRFunction():New(oSecPer:Cell("HNTRAB")	   , "TOTNTRBCC", cFuncao, oBreakCC,,"@E 9,999,999.99", , .F., .F.)
		TRFunction():New(oSecPer:Cell("HNTRABPER") , 		 	, "ONPRINT", oBreakCC,,"@E 9,999,999.99", bPerNTraCC, .F., .F.)
		
		TRFunction():New(oSecPer:Cell("HABO")	   , "TOTABOCC"	, cFuncao, oBreakCC,,"@E 9,999,999.99", , .F., .F.)
		TRFunction():New(oSecPer:Cell("HABOPER")   , 		 	, "ONPRINT", oBreakCC,,"@E 9,999,999.99", bPerAboCC, .F., .F.)
		
		TRFunction():New(oSecPer:Cell("HAFAST")	   , "TOTAFASTCC", cFuncao, oBreakCC,,"@E 9,999,999.99", , .F., .F.)
		If lAfastPrev
			TRFunction():New(oSecPer:Cell("HAFASTPER") , 		 , "ONPRINT", oBreakCC, ,"@E 9,999,999.99", bPerAfasCC, .F., .F.)
		EndIf
		
		// "Total por Evento"
		TRCollection():New( "EVENTOS", cFuncao, oBreakCC, STR0035, "@E 9,999,999.99", {|| oSecLanc:Cell("PD"):GetText() + " " + oSecLanc:Cell("PDDESC"):GetValue(.T.) }, .F., .F., oSecLanc, , {|| oSecLanc:Cell("PDQUANTC"):GetValue(.T.)} )
		// "Total por Motivo de Abono"
		TRCollection():New( "ABONOS" , cFuncao, oBreakCC, STR0036, "@E 9,999,999.99", {|| oSecLanc:Cell("ABO"):GetText() + " " + oSecLanc:Cell("ABODESC"):GetValue(.T.) }, .F., .F., oSecLanc, , {|| oSecLanc:Cell("ABOQUANTC"):GetValue(.T.)} )
		// "Total por Tipo de Afastamento"
		TRCollection():New( "AFASTA" , cFuncao, oBreakCC, STR0037, "@E 9,999,999.99", {|| oSecLanc:Cell("AFAS"):GetText() + " " + oSecLanc:Cell("AFASDESC"):GetValue(.T.) }, .F., .F., oSecLanc, , {|| oSecLanc:Cell("AFASQUANTC"):GetValue(.T.)} )
	EndIf
	
	// Ajusta os totalizadares quando o relatório é impresso com horas em sexagesimal
	If !lCent
		bPercPrev 	:= {|| (fConvHr(oSecPer:GetFunction("TOTREA"):GetLastValue(), "D") / fConvHr(oSecPer:GetFunction("TOTPRE"):GetLastValue(), "D")) * 100  }
		bPercNTrab 	:= {|| (fConvHr(oSecPer:GetFunction("TOTNTRB"):GetLastValue(), "D") / fConvHr(oSecPer:GetFunction("TOTPRE"):GetLastValue(), "D")) * 100  }
		bPercAbo 	:= {|| (fConvHr(oSecPer:GetFunction("TOTABO"):GetLastValue(), "D") / fConvHr(oSecPer:GetFunction("TOTNTRB"):GetLastValue(), "D")) * 100  }
		bPercAfast 	:= {|| (fConvHr(oSecPer:GetFunction("TOTAFAST"):GetLastValue(), "D") / fConvHr(oSecPer:GetFunction("TOTPRE"):GetLastValue(), "D")) * 100  }
	EndIf
	
	oBreakFil := TRBreak():New(oReport, oSecFunc:Cell("RA_FILIAL"),,,, lBreakCC)
	oBreakFil:OnBreak({|x, y| oReport:SkipLine(), fInfo(@aInfo, x), cTitFil := OemToAnsi(STR0034) + x + " - " + aInfo[1]}) // "Total para a Filial: "
	oBreakFil:SetTotalText({||cTitFil})
	oBreakFil:SetTotalInLine(lSintetico)
	oBreakFil:SetHeaderPage(.F.)
	oBreakFil:SetHeaderBreak(.F.)
	
	TRFunction():New(oSecPer:Cell("HPREVISTAS"), "TOTPRE"	,   cFuncao, oBreakFil,, "@E 9,999,999.99", , .F., .T.)
	TRFunction():New(oSecPer:Cell("HREAL")	   , "TOTREA"	,   cFuncao, oBreakFil,,"@E 9,999,999.99", , .F., .F.)
	TRFunction():New(oSecPer:Cell("HREALPER")  , 		 	, "ONPRINT", oBreakFil,,"@E 9,999,999.99", bPercPrev, .F., .F.)
	
	TRFunction():New(oSecPer:Cell("HNTRAB")	   , "TOTNTRB"	,   cFuncao, oBreakFil,,"@E 9,999,999.99", , .F., .F.)
	TRFunction():New(oSecPer:Cell("HNTRABPER") , 		 	, "ONPRINT", oBreakFil,,"@E 9,999,999.99", bPercNTrab, .F., .F.)
	
	TRFunction():New(oSecPer:Cell("HABO")	   , "TOTABO"	,   cFuncao, oBreakFil,,"@E 9,999,999.99", , .F., .F.)
	TRFunction():New(oSecPer:Cell("HABOPER")   , 		 	, "ONPRINT", oBreakFil,,"@E 9,999,999.99", bPercAbo, .F., .F.)
	
	TRFunction():New(oSecPer:Cell("HAFAST")	   , "TOTAFAST"	,   cFuncao, oBreakFil,,"@E 9,999,999.99", , .F., .F.)
	If lAfastPrev
		TRFunction():New(oSecPer:Cell("HAFASTPER") , 		 	, "ONPRINT", oBreakFil, ,"@E 9,999,999.99", bPercAfast, .F., .F.)
	EndIf
	
	// "Total por Evento"
	TRCollection():New( "EVENTOS", cFuncao, oBreakFil, STR0035, "@E 9,999,999.99", {|| oSecLanc:Cell("PD"):GetText() + " " + oSecLanc:Cell("PDDESC"):GetValue(.T.) }, .F., .F., oSecLanc, /*bCondition*/, {|| oSecLanc:Cell("PDQUANTC"):GetValue(.T.)} )
	// "Total por Motivo de Abono"
	TRCollection():New( "ABONOS" , cFuncao, oBreakFil, STR0036, "@E 9,999,999.99", {|| oSecLanc:Cell("ABO"):GetText() + " " + oSecLanc:Cell("ABODESC"):GetValue(.T.) }, .F., .F., oSecLanc, /*bCondition*/, {|| oSecLanc:Cell("ABOQUANTC"):GetValue(.T.)} )
	// "Total por Tipo de Afastamento"
	TRCollection():New( "AFASTA" , cFuncao, oBreakFil, STR0037, "@E 9,999,999.99", {|| oSecLanc:Cell("AFAS"):GetText() + " " + oSecLanc:Cell("AFASDESC"):GetValue(.T.) }, .F., .F., oSecLanc, /*bCondition*/, {|| oSecLanc:Cell("AFASQUANTC"):GetValue(.T.)} )
Return

/*/{Protheus.doc} GetSRAWhere
Retorna a cláusula where utitlizada para filtrar os funcinoários com base nas perguntas selecionadas e nas permissões de acesso do usuário
@type Static Function
@author Cícero Alves
@since 21/08/2023
@return cSRAWhere, Caracter, Filtro para a tabela de funcionários em formato SQL
/*/
Static Function GetSRAWhere()
	
	Local cAcessaSRA	:= ""
	Local dDataIni
	Local dDataFim
	
	If Empty(cSRAWhere)
		
		// Controle de acesso
		cAcessaSRA := fSFiltrSQL(ChkRH("PONR210", "SRA", "2"))
		
		Pergunte("PONR210", .F.)
		
		// Intervalo de datas 
		dDataIni := MV_PAR07
		dDataFim := MV_PAR08
		
		// Situações 
		MV_PAR05 := fSqlIn(StrTran(MV_PAR05, '*'), 1)
		
		// Categorias
		MV_PAR06 := fSqlIn(StrTran(MV_PAR06, '*'), 1)
		
		MakeSqlExp("PONR210")
		
		cSRAWhere := "RA_ADMISSA <= '" + dToS(dDataFim) + "' " 
		cSRAWhere += "AND ( RA_DEMISSA = '        ' OR RA_DEMISSA > '" + dToS(dDataIni) + "' )"
		
		cSRAWhere += If(!Empty(MV_PAR01), " AND " + MV_PAR01, "") 						// Filiais
		cSRAWhere += If(!Empty(MV_PAR02), " AND " + MV_PAR02, "") 						// Centros de Custo
		cSRAWhere += If(!Empty(MV_PAR03), " AND " + MV_PAR03, "")						// Turnos
		cSRAWhere += If(!Empty(MV_PAR04), " AND " + MV_PAR04, "") 						// Matrículas
		cSRAWhere += If(!Empty(MV_PAR05), " AND RA_SITFOLH IN (" + MV_PAR05 + ")", "") // Situações
		cSRAWhere += If(!Empty(MV_PAR06), " AND RA_CATFUNC IN (" + MV_PAR06 + ")", "") // Categorias
		
		// Controle de Acesso
		cSRAWhere += If(!Empty(cAcessaSRA) .And. cAcessaSRA != ".T.", " AND " + cAcessaSRA, "")
		
	EndIf
	
Return cSRAWhere

/*/{Protheus.doc} GetPer
Busca as informações dos Funcionários
@type Static Function
@author Cícero Alves
@since 21/08/2023
/*/
Static Function GetPer()
	
	Local cLastFil		:= "!!!"
	Local cPeriodo		:= ""
	Local dPerIni		:= cToD("//")
	Local dPerFim		:= cToD("//")
	Local aPeriodos		:= {}
	Local nHoras		:= 0
	Local cHrsReal		:= 0
	Local lDiscri 		:= MV_PAR10 == 1
	Local lAfastPrev	:= MV_PAR11 == 1
	Local aHrsNTrab		:= {0, 0}
	Local aHrsAbo		:= {0, 0}
	Local aAfast		:= {0, {}}
	Local lTemApo		:= .F.
	Local nI			:= 0
	
	(cAliasSRA)->(dbGoTop())
	
	While (cAliasSRA)->(!EoF())
		
		//Posiciona no Funcionário
		SRA->(dbGoTo((cAliasSRA)->RECNO))
		
		If (cAliasSRA)->RA_FILIAL != cLastFil
			cLastFil := (cAliasSRA)->RA_FILIAL
			// Obtem as datas do Periodo em Aberto
			GetPonMesDat( @dPerIni, @dPerFim, cLastFil )
		EndIf
		
		aPeriodos := Monta_per(MV_PAR07, MV_PAR08, (cAliasSRA)->RA_FILIAL, (cAliasSRA)->RA_MAT, dPerIni, dPerFim )
		
		For nI := 1 To Len(aPeriodos)
			
			nHoras := 0
			aHrsNTrab := {0, 0}	// [1] Quantidade de registros para impressão, [2] soma das horas dos eventos
			aHrsAbo := {0, 0}	// [1] Quantidade de registros para impressão, [2] soma das horas abonadas
			aAfast := {0, {}}	// [1] Soma das Horas de afastamento, [2] afastamentos detalhados
			
			fHrsPrev(aPeriodos[nI], @nHoras, @aAfast)
			
			lTemApo := GetLanc(SRA->RA_FILIAL, SRA->RA_MAT, aPeriodos[nI][3], aPeriodos[nI][4], @aHrsNTrab)
			
			If lTemApo
				GetAbo(SRA->RA_FILIAL, SRA->RA_MAT, aPeriodos[nI][3], aPeriodos[nI][4], @aHrsAbo)
			EndIf
			
			// Calcula as horas efetivamente trabalhadas
			cHrsReal := SubHoras(nHoras, aHrsNTrab[2]) //  - Horas não trabalhadas dos eventos 
			If lAfastPrev
				cHrsReal := SubHoras(cHrsReal, aAfast[1]) // - Horas de afastamento
			EndIf
			
			cPeriodo := dToC(aPeriodos[nI, 1]) + "-" + dToC(aPeriodos[nI, 2])
			
			GravaPer(cPeriodo, nHoras, cHrsReal, aHrsNTrab[2], aHrsAbo[2], aAfast[1], lAfastPrev)
			
			If lDiscri .And. (lTemApo .Or. !Empty(aAfast[1]))
				GravaLanc(aAfast, aHrsNTrab, aHrsAbo, cPeriodo)
			Else
				// Fecha as querys abertas 
				(cAliasSPC)->(dbCloseArea())
				If lTemApo
					(cAliasAbo)->(dbCloseArea())
				EndIf
			EndIf
			
		Next nI
		
		(cAliasSRA)->(dbSkip())
	EndDo
	(cAliasSRA)->(dbGoTop())
Return

/*/{Protheus.doc} GravaPer
Grava as informações da seção período na tabela temporária
@type Static Function
@author Cícero Alves
@since 21/08/2023
@param cPeriodo, Caracter, Mes e ano do período de apontamento
@param nHoras, Numérico, Total de horas previstas para o funcionário no período
@param cHrsReal, Numérico, Total de horas Realizadas pelo funcionário no período
@param nHrsNTrab, Numérico, Total de horas não trabalhadas no período
@param nHrsAbo, Numérico, Total de horas abonadas no período
@param nAfast, Numérico, Total de horas de afastamento no período
@param lAfastPrev, Lógico, Define se as horas de afastamento estão contidas nas horas previstas
/*/
Static Function GravaPer(cPeriodo, nHoras, cHrsReal, nHrsNTrab, nHrsAbo, nAfast, lAfastPrev)
	
	Local lCent := MV_PAR14 == 2
	
	RecLock(cAliasPer, .T.)
		(cAliasPer)->FILIAL		:= SRA->RA_FILIAL
		(cAliasPer)->MAT 		:= SRA->RA_MAT
		(cAliasPer)->PERIODO 	:= cPeriodo
		(cAliasPer)->HPREVISTAS := If(lCent, fConvHr(nHoras, "D"), nHoras)
		(cAliasPer)->HREAL 		:= If(lCent, fConvHr(cHrsReal, "D"), cHrsReal)
		(cAliasPer)->HREALPER 	:= Round((fConvHr(cHrsReal, "D") / fConvHr(nHoras, "D")) * 100, 2)
		(cAliasPer)->HNTRAB 	:= If(lCent, fConvHr(nHrsNTrab, "D"), nHrsNTrab)
		(cAliasPer)->HNTRABPER 	:= Round((fConvHr(nHrsNTrab, "D") / fConvHr(nHoras, "D")) * 100, 2)
		(cAliasPer)->HABO 		:= If(lCent, fConvHr(nHrsAbo, "D"), nHrsAbo)
		(cAliasPer)->HABOPER 	:= Round((fConvHr(nHrsAbo, "D") / fConvHr(nHrsNTrab, "D")) * 100, 2)
		(cAliasPer)->HAFAST 	:= If(lCent, fConvHr(nAfast, "D"), nAfast)
		If lAfastPrev
			(cAliasPer)->HAFASTPER 	:= Round((fConvHr(nAfast, "D") / fConvHr(nHoras, "D")) * 100, 2)
		EndIf
	(cAliasPer)->(MsUnLock())
	
Return

/*/{Protheus.doc} CriaTabPer
Cria a tabela temporária para a seção de Períodos
@type Static Function
@author Cícero Alves
@since 21/08/2023
/*/
Static Function CriaTabPer()
	
	Local aStruct	:= {}
	Local aIndices	:= {}
	
	Aadd(aStruct, {"FILIAL"		, "C",   FWGETTAMFILIAL, 0})
	Aadd(aStruct, {"MAT"		, "C",   6, 0})
	Aadd(aStruct, {"PERIODO"	, "C",   23, 0})
	Aadd(aStruct, {"HPREVISTAS"	, "N",   6, 2})
	Aadd(aStruct, {"HREAL"		, "N",   6, 2})
	Aadd(aStruct, {"HREALPER"	, "N",   6, 2})
	Aadd(aStruct, {"HNTRAB"		, "N",   6, 2})
	Aadd(aStruct, {"HNTRABPER"	, "N",   6, 2})
	Aadd(aStruct, {"HABO"		, "N",   6, 2})
	Aadd(aStruct, {"HABOPER"	, "N",   6, 2})
	Aadd(aStruct, {"HAFAST"		, "N",   6, 2})
	Aadd(aStruct, {"HAFASTPER"	, "N",   6, 2})
	
	Aadd(aIndices, {"FILIAL", "MAT", "PERIODO"})
	
	oTmpPer := RhCriaTrab(cAliasPer, aStruct, aIndices)
	
Return

/*/{Protheus.doc} GravaLanc
Grava as informações da seção de lançamentos na tabela temporária
@type Static Function
@author Cícero Alves
@since 21/08/2023
@param aAfasta, Array, Afastamentos ocorridos no período [n, 1] = Total de horas; [n, 2] = Array com o detalhamento do afastamento
@param aHrsNTrab, Array, horas não trabalhadas no período [n, 1] = Quantidade de registros na tabela; [n, 2] = Total de horas não trabalhadas
@param aHrsAbo, Array, horas abonadas no período [n, 1] = Quantidade de registros na tabela; [n, 2] = Total de horas não abonadas
/*/
Static Function GravaLanc(aAfasta, aHrsNTrab, aHrsAbo, cPeriodo)
	
	Local lTemApo	:= .F.
	Local nHorasApo	:= 0
	Local nHorasAbo	:= 0
	Local nLoops	:= Max(Max(aHrsNTrab[1], aHrsAbo[1]), Len(aAfasta[2]))
	Local nI		:= 1
	Local lCent		:= MV_PAR14 == 2
	
	lTemApo	:= (cAliasSPC)->(!EoF())
	
	For nI := 1 To nLoops
		
		RecLock(cAliasLanc, .T.)
			(cAliasLanc)->FILIAL	:= SRA->RA_FILIAL
			(cAliasLanc)->MAT 		:= SRA->RA_MAT
			(cAliasLanc)->PERIODO 	:= cPeriodo
			
			If lTemApo
				If (cAliasSPC)->(!EoF())
					
					nHorasApo := Min2Hrs((cAliasSPC)->PC_QUANTC)
					
					(cAliasLanc)->PD 		:= (cAliasSPC)->PC_PD
					(cAliasLanc)->PDDESC 	:= (cAliasSPC)->P9_DESC
					(cAliasLanc)->PDQUANTC 	:= If(lCent, fConvHr(nHorasApo, "D"), nHorasApo)
					(cAliasLanc)->PDPERC 	:= Round((fConvHr(nHorasApo, "D") / fConvHr(aHrsNTrab[2], "D")) * 100, 2)
					
					(cAliasSPC)->(dbSkip())
				EndIf
				
				If (cAliasAbo)->(!EoF())
					
					nHorasAbo := Min2Hrs((cAliasAbo)->PC_QTABONO)
					
					(cAliasLanc)->ABO 		:= (cAliasAbo)->PC_ABONO
					(cAliasLanc)->ABODESC 	:= (cAliasAbo)->P6_DESC
					(cAliasLanc)->ABOQUANTC := If(lCent, fConvHr(nHorasAbo, "D"), nHorasAbo)
					(cAliasLanc)->ABOPERC 	:= Round((fConvHr(nHorasAbo, "D") / fConvHr(aHrsAbo[2], "D")) * 100, 2)
					
					(cAliasAbo)->(dbSkip())
				EndIf
				
			EndIf
			
			If nI <= Len(aAfasta[2])
				(cAliasLanc)->AFAS 			:= aAfasta[2][nI][1]
				(cAliasLanc)->AFASDESC 		:= aAfasta[2][nI][2]
				(cAliasLanc)->AFASQUANTC	:= If(lCent, fConvHr(aAfasta[2][nI][3], "D"), aAfasta[2][nI][3])
				(cAliasLanc)->AFASPERC 		:= Round((fConvHr(aAfasta[2][nI][3], "D") / fConvHr(aAfasta[1], "D")) * 100, 2)
			EndIf
			
		(cAliasLanc)->(MsUnLock())
		
	Next nI
	
	If lTemApo
		// fechamento dentro do If pois a tabela de abonos só estará aberta se houver apontamentos
		(cAliasAbo)->(dbCloseArea())
	EndIf
	
	(cAliasSPC)->(dbCloseArea())
Return

/*/{Protheus.doc} CriaTabLan
Cria a tabela temporária para a seção de Lançamentos
@type Static Function
@author Cícero Alves
@since 21/08/2023
/*/
Static Function CriaTabLan()
	
	Local aStruct	:= {}
	Local aIndices	:= {}
	
	Aadd(aStruct, {"FILIAL"		, "C",   FWGETTAMFILIAL, 0})
	Aadd(aStruct, {"MAT"		, "C",   6, 0})
	Aadd(aStruct, {"PERIODO"	, "C",   23, 0})
	Aadd(aStruct, {"PD"			, "C",   3, 0})
	Aadd(aStruct, {"PDDESC"		, "C",  20, 0})
	Aadd(aStruct, {"PDQUANTC"	, "N",   6, 2})
	Aadd(aStruct, {"PDPERC"		, "N",   6, 2})
	Aadd(aStruct, {"ABO"		, "C",   3, 0})
	Aadd(aStruct, {"ABODESC"	, "C",  20, 0})
	Aadd(aStruct, {"ABOQUANTC"	, "N",   6, 2})
	Aadd(aStruct, {"ABOPERC"	, "N",   6, 2})
	Aadd(aStruct, {"AFAS"		, "C",   3, 0})
	Aadd(aStruct, {"AFASDESC"	, "C",  20, 0})
	Aadd(aStruct, {"AFASQUANTC"	, "N",   6, 2})
	Aadd(aStruct, {"AFASPERC"	, "N",   6, 2})
	
	Aadd(aIndices, {"FILIAL", "MAT", "PERIODO"})
	
	oTmpLanc := RhCriaTrab(cAliasLanc, aStruct, aIndices)
	
Return

/*/{Protheus.doc} GetLanc
Busca as horas não trabalhadas nas tabelas de apontamento
@type Static Function
@author Cícero Alves
@since 21/08/2023
@param cFilFunc, Caracter, Filial do funcinário
@param cMatFunc, Caracter, Matrícula do funcinário
@param dDataIni, Data, Data inicial da busca
@param dDataFim, Data, Data final da busca
@param aHrsNTrab, Array, Deve ser passado por referência; horas não trabalhadas no período [n, 1] = Quantidade de registros na tabela; [n, 2] = Total de horas não trabalhadas
@return lTemApo, Lógico, Indica se encontrou registros
/*/
Static Function GetLanc(cFilFunc, cMatFunc, dDataIni, dDataFim, aHrsNTrab)
	
	Local cSPC_SP9	:= "%" + FWJoinFilial( "SPC", "SP9" ) + "%"
	Local cSPH_SP9	:= "%" + FWJoinFilial( "SPH", "SP9" ) + "%"
	Local lTemApo	:= .F.
	
	aHrsNTrab := {0, 0}
	
	Default cFilFunc := SRA->RA_FILIAL
	Default cMatFunc := SRA->RA_Mat
	
	cAliasSPC := GetNextAlias()
	
	// Busca os eventos da SPC e SPH
	BEGINSQL ALIAS cAliasSPC
		SELECT PC_FILIAL, PC_MAT, P9_DESC,
			CASE 
				WHEN PC_PDI <> ' ' THEN 
					PC_PDI 
				ELSE 
					PC_PD 
			END AS PC_PD,
			CASE
				WHEN PC_QUANTI > 0 THEN
					SUM((FLOOR(PC_QUANTI) * 60) + ((PC_QUANTI - FLOOR(PC_QUANTI)) * 100)) 
				ELSE
					SUM((FLOOR(PC_QUANTC) * 60) + ((PC_QUANTC - FLOOR(PC_QUANTC)) * 100))
			END AS PC_QUANTC
			FROM %Table:SPC% SPC
			INNER JOIN %Table:SRA% SRA ON SPC.PC_FILIAL = SRA.RA_FILIAL AND SPC.PC_MAT = SRA.RA_MAT
			INNER JOIN %Table:SP9% SP9 ON %Exp:cSPC_SP9% AND (CASE WHEN PC_PDI <> ' ' THEN PC_PDI ELSE PC_PD END) = SP9.P9_CODIGO
			WHERE SPC.PC_DATA BETWEEN %Exp:dToS(dDataIni)% AND %Exp:dToS(dDataFim)% AND
				SPC.PC_DATA >= SRA.RA_ADMISSA AND
				(SRA.RA_DEMISSA = '        ' OR SPC.PC_DATA <= RA_DEMISSA) AND
				SPC.PC_FILIAL = %Exp:cFilFunc% AND
				SPC.PC_MAT = %Exp:cMatFunc% AND
				SP9.P9_TIPOCOD = '2' AND
				SP9.P9_IDPON NOT IN ('005A', '006A') AND
				SPC.%NotDel% AND
				SP9.%NotDel% AND
				SRA.%NotDel%
		GROUP BY PC_FILIAL, PC_MAT, PC_PD, PC_PDI, PC_QUANTI, P9_DESC
		UNION ALL
		SELECT SPH.PH_FILIAL, SPH.PH_MAT, SP9.P9_DESC,
			CASE
				WHEN PH_PDI <> ' ' THEN
					PH_PDI
				ELSE
					PH_PD
			END AS PH_PD,
			CASE
				WHEN PH_QUANTI > 0 THEN
					SUM((FLOOR(PH_QUANTI) * 60) + ((PH_QUANTI - FLOOR(PH_QUANTI)) * 100))
				ELSE
					SUM((FLOOR(PH_QUANTC) * 60) + ((PH_QUANTC - FLOOR(PH_QUANTC)) * 100)) 
			END AS PH_QUANTC
			FROM %Table:SPH% SPH
			INNER JOIN %Table:SRA% SRA ON SPH.PH_FILIAL = SRA.RA_FILIAL AND SPH.PH_MAT = SRA.RA_MAT
			INNER JOIN %Table:SP9% SP9 ON %Exp:cSPH_SP9% AND (CASE WHEN PH_PDI <> ' ' THEN PH_PDI ELSE PH_PD END) = SP9.P9_CODIGO
			WHERE SPH.PH_DATA BETWEEN %Exp:dToS(dDataIni)% AND %Exp:dToS(dDataFim)% AND
				SPH.PH_DATA >= SRA.RA_ADMISSA AND
				(SRA.RA_DEMISSA = '        ' OR SPH.PH_DATA <= RA_DEMISSA) AND
				SPH.PH_FILIAL = %Exp:cFilFunc% AND
				SPH.PH_MAT = %Exp:cMatFunc% AND
				SP9.P9_TIPOCOD = '2' AND
				SP9.P9_IDPON NOT IN ('005A', '006A') AND
				SPH.%NotDel% AND
				SP9.%NotDel% AND
				SRA.%NotDel%
		GROUP BY PH_FILIAL, PH_MAT, PH_PD, PH_PDI, PH_QUANTI, SP9.P9_DESC
		ORDER BY PC_FILIAL, PC_MAT, PC_PD
	ENDSQL
	
	lTemApo	:= (cAliasSPC)->(!EoF())
	
	//Totaliza as horas não trabalhadas para calcular os percentuais
	(cAliasSPC)->(dbEVal({|| aHrsNTrab[1]++, aHrsNTrab[2] += (cAliasSPC)->PC_QUANTC}))
	
	// A query retorna em minutos, então é necessário Converter em horas 
	aHrsNTrab[2] := Min2Hrs(aHrsNTrab[2])
	
	// Mantém a tabela aberta, pois será usada na impressão
	(cAliasSPC)->(dbGoTop())
	
Return lTemApo

/*/{Protheus.doc} fHrsPrev
Calcula as horas previstas e as horas de afastamento para o funcioário no período com base no calendário do ponto
@type Static Function
@author Cícero Alves
@since 21/08/2023
@param aPeriodo, Array, Informações do período de apontamento [1] = Data inicial do período, [2] = Data final do período, [3] = Data inicial para busca, [4] = Data Final para busca
@param nHoras, Numérico, Deve ser passado por referência; Total das horas previstas para o funcionário no período
@param aAfast, Array, Deve ser passado por referência; Afastamentos ocorridos no período [n, 1] = Total de horas; [n, 2] = Array com o detalhamento do afastamento
/*/
Static Function fHrsPrev(aPeriodo, nHoras, aAfast)
	
	Local aTabCalend 	:= {}
	Local aTurnos		:= {}
	Local aTabPadrao	:= {}
	Local lAfastPrev	:= MV_PAR11 == 1
	Local lFerAfast		:= MV_PAR13 == 1
	Local cDescAfas		:= ""
	Local cTipoAfas		:= ""
	Local nPosAfast		:= 0
	Local nI			:= 0
	
	aAfast := {0, {}}
	nHoras := 0
	
	If !CriaCalend(	aPeriodo[1] 		,;	//01 -> Data Inicial do Periodo
					aPeriodo[2]			,;	//02 -> Data Final do Periodo
					SRA->RA_TNOTRAB		,;	//03 -> Turno Para a Montagem do Calendario
					SRA->RA_SEQTURN		,;	//04 -> Sequencia Inicial para a Montagem Calendario
					@aTabPadrao			,;	//05 -> Array Tabela de Horario Padrao
					@aTabCalend			,;	//06 -> Array com o Calendario de Marcacoes
					SRA->RA_FILIAL     	,;	//07 -> Filial para a Montagem da Tabela de Horario
					SRA->RA_MAT   		,;	//08 -> Matricula para a Montagem da Tabela de Horario
					SRA->RA_CC   		,;	//09 -> Centro de Custo para a Montagem da Tabela
					@aTurnos			,;	//10 -> Array com as Trocas de Turno
					NIL					,;	//11 -> Array com Todas as Excecoes do Periodo
					NIL					,;	//12 -> Se executa Query para a Montagem da Tabela Padrao
					.T.					,;	//13 -> Se executa a funcao se sincronismo do calendario
					NIL			 		;	//14 -> Se Forca a Criacao de Novo Calendario
				)
		Return
	EndIf
	
	For nI := 1 To Len(aTabCalend)
		
		If Empty(aTabCalend[nI][CALEND_POS_HRS_TRABA]) .Or. aTabCalend[nI][CALEND_POS_DATA] < aPeriodo[3] ;
			.Or. aTabCalend[nI][CALEND_POS_DATA] < SRA->RA_ADMISSA .Or. (!Empty(SRA->RA_DEMISSA) .And. aTabCalend[nI][CALEND_POS_DATA] > SRA->RA_DEMISSA)
			LOOP
		ElseIf aTabCalend[nI][CALEND_POS_DATA] > aPeriodo[4] .Or. SRA->( RA_SITFOLH $ 'D*T' .And. aTabCalend[nI][CALEND_POS_DATA] > RA_DEMISSA )
			EXIT
		EndIf
		
		If aTabCalend[nI][CALEND_POS_TIPO_DIA] == 'S' .Or. ; 
			(aTabCalend[nI][CALEND_POS_AFAST] .And. aTabCalend[nI][CALEND_POS_TIPO_ORIG_DIA] == 'S' )
			
			If aTabCalend[nI][CALEND_POS_AFAST]
				
				If aTabCalend[nI][CALEND_POS_TIP_AFAST] == "F" .And. !lFerAfast
					LOOP
				EndIf
				
				aAfast[1] := SomaHoras(aAfast[1], aTabCalend[nI][CALEND_POS_HRS_TRABA])
				
				cTipoAfas := Posicione("SR8", RetOrder("SR8","R8_FILIAL+R8_NUMID"), SRA->RA_FILIAL + aTabCalend[nI][CALEND_POS_R8ID], "R8_TIPOAFA") 
				cDescAfas := fDesc( "RCM", cTipoAfas, "RCM_DESCRI", 20, SRA->RA_FILIAL, , .F. )
				
				
				If (nPosAfast := aScan(aAfast[2], {|x| x[1] == cTipoAfas})) > 0
					aAfast[2][nPosAfast][3] := SomaHoras(aAfast[2][nPosAfast][3], aTabCalend[nI][CALEND_POS_HRS_TRABA])
				Else
					aAdd(aAfast[2], {cTipoAfas, cDescAfas, aTabCalend[nI][CALEND_POS_HRS_TRABA]})
				EndIf
				
				// Adiciona o afastamento nas horas previstas
				If lAfastPrev
					nHoras := SomaHoras(nHoras, aTabCalend[nI][CALEND_POS_HRS_TRABA])
				EndIf
			Else
				nHoras := SomaHoras(nHoras, aTabCalend[nI][CALEND_POS_HRS_TRABA])
			EndIf
		EndIf
		
	Next nI
	
Return

/*/{Protheus.doc} GetAbo
Busca as horas não trabalhadas nas tabelas de apontamento
@type Static Function
@author Cícero Alves
@since 21/08/2023
@param cFilFunc, Caracter, Filial do funcinário
@param cMatFunc, Caracter, Matrícula do funcinário
@param dDataIni, Data, Data inicial da busca
@param dDataFim, Data, Data final da busca
@param aHrsAbo, Array, Deve ser passado por referência; horas abonadas no período [n, 1] = Quantidade de registros na tabela; [n, 2] = Total de horas Abonadas
/*/
Static Function GetAbo(cFilFunc, cMatFunc, dDataIni, dDataFim, aHrsAbo)
	
	Local cSPC_SP6	:= "%" + FWJoinFilial( "SPC", "SP6" ) + "%"
	Local cSPC_SP9	:= "%" + FWJoinFilial( "SPC", "SP9" ) + "%"
	Local cSPH_SP9	:= "%" + FWJoinFilial( "SPH", "SP9" ) + "%"
	Local cSPH_SP6	:= "%" + FWJoinFilial( "SPH", "SP6" ) + "%"
	
	aHrsAbo := {0, 0}
	
	Default cFilFunc := SRA->RA_FILIAL
	Default cMatFunc := SRA->RA_Mat
	
	cAliasAbo := GetNextAlias()
	
	//Busca os abonos
	BeginSql Alias cAliasAbo
		SELECT SPC.PC_FILIAL, SPC.PC_MAT, SPC.PC_ABONO, SUM((FLOOR(SPC.PC_QTABONO) * 60) + ((SPC.PC_QTABONO - FLOOR(SPC.PC_QTABONO)) * 100)) AS PC_QTABONO, SP6.P6_DESC
			FROM  %Table:SPC% SPC
			INNER JOIN %Table:SRA% SRA ON SPC.PC_FILIAL = SRA.RA_FILIAL AND SPC.PC_MAT = SRA.RA_MAT
			INNER JOIN %Table:SP6% SP6 ON %Exp:cSPC_SP6% AND SPC.PC_ABONO = SP6.P6_CODIGO
			INNER JOIN %Table:SP9% SP9 ON %Exp:cSPC_SP9% AND SPC.PC_PD = SP9.P9_CODIGO
			WHERE SPC.PC_DATA BETWEEN %Exp:dToS(dDataIni)% AND %Exp:dToS(dDataFim)% AND
				SPC.PC_DATA >= SRA.RA_ADMISSA AND
				(SRA.RA_DEMISSA = '        ' OR SPC.PC_DATA <= RA_DEMISSA) AND
				SPC.PC_FILIAL = %Exp:SRA->RA_FILIAL% AND
				SPC.PC_MAT = %Exp:SRA->RA_MAT% AND
				SP9.P9_TIPOCOD = '2' AND
				SP9.P9_IDPON NOT IN ('005A', '006A') AND
				SPC.%NotDel% AND
				SP6.%NotDel% AND
				SRA.%NotDel% AND
				SP9.%NotDel%
			GROUP BY SPC.PC_FILIAL, SPC.PC_MAT, PC_ABONO, P6_DESC
		UNION ALL
		SELECT SPH.PH_FILIAL, SPH.PH_MAT, SPH.PH_ABONO, SUM((FLOOR(SPH.PH_QTABONO) * 60) + ((SPH.PH_QTABONO - FLOOR(SPH.PH_QTABONO)) * 100)) AS PC_QTABONO, SP6.P6_DESC
			FROM %Table:SPH% SPH
			INNER JOIN %Table:SRA% SRA ON SPH.PH_FILIAL = SRA.RA_FILIAL AND SPH.PH_MAT = SRA.RA_MAT
			INNER JOIN %Table:SP6% SP6 ON %Exp:cSPH_SP6% AND SPH.PH_ABONO = SP6.P6_CODIGO
			INNER JOIN %Table:SP9% SP9 ON %Exp:cSPH_SP9% AND SPH.PH_PD = SP9.P9_CODIGO
			WHERE SPH.PH_DATA BETWEEN %Exp:dToS(dDataIni)% AND %Exp:dToS(dDataFim)% AND
				SPH.PH_DATA >= SRA.RA_ADMISSA AND
				(SRA.RA_DEMISSA = '        ' OR SPH.PH_DATA <= RA_DEMISSA) AND
				SPH.PH_FILIAL = %Exp:SRA->RA_FILIAL% AND
				SPH.PH_MAT = %Exp:SRA->RA_MAT% AND
				SP9.P9_TIPOCOD = '2' AND
				SP9.P9_IDPON NOT IN ('005A', '006A') AND
				SPH.%NotDel% AND
				SP9.%NotDel% AND
				SP6.%NotDel% AND
				SRA.%NotDel%
			GROUP BY SPH.PH_FILIAL, SPH.PH_MAT, SPH.PH_ABONO, SP6.P6_DESC
			ORDER BY PC_FILIAL, PC_MAT, PC_ABONO
	ENDSQL
	
	//Totaliza as horas abonadas para calcular os percentuais
	(cAliasAbo)->(dbEVal({|| aHrsAbo[1]++, aHrsAbo[2] += (cAliasAbo)->PC_QTABONO}))
	
	// A query retorna em minutos, então é necessário Converter em horas 
	aHrsAbo[2] := Min2Hrs(aHrsAbo[2])
	
	// Mantém a tabela aberta, pois será usada na impressão
	(cAliasAbo)->(dbGoTop())
	
Return
