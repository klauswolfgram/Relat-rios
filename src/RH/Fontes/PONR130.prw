/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "PONR130.CH"
#INCLUDE "PONCALEN.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PONR130   ºAutor  ³RH                  º Data ³  15/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.        ³ Relatorio de visita - Ponto Eletronico.                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso          ³ AP                                                      º±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador  ³ Data   ³ FNC   ³  Motivo da Alteracao                   º±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³±±
±±ºCecilia C.   ³21/05/14³TPQAN3  ³Incluido o fonte da 11 para a 12 e     º±± 
±±º             ³        ³        ³efetuada a limpeza.                    º±±
±±ºPaulo O      ³22/02/17³MRH-7340³Alterado o tamanho das celulas 2ENTRADAº±± 
±±ºInzonha      ³        ³426495  ³e 2SAIDA de 15 para 17                 º±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function PONR130()
Local oReport 

Static aInfo		:= {}
Static lOfuscaNom	:= .F. //PW_NOME
Static nNumVisita	:= 1
Static aVisitas		:= {}
Static cAliasQry	:= "SPY"

Private aFldRot		:= {'PW_NOME'}
Private aOfusca		:= If(FindFunction('ChkOfusca'), ChkOfusca(), {.T.,.F.}) //[1] Acesso; [2]Ofusca
Private aFldOfusca	:= {}

If aOfusca[2]
	aFldOfusca := FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRot ) // CAMPOS SEM ACESSO
	IF aScan( aFldOfusca , { |x| x:CFIELD == "PW_NOME" } ) > 0
		lOfuscaNom := FwProtectedDataUtil():IsFieldInList( "PW_NOME" )
	ENDIF
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ MV_PAR01        //  Filial  De                               ³
//³ MV_PAR02        //  Filial  Ate                              ³
//³ MV_PAR03        //  Visitante De                             ³
//³ MV_PAR04        //  Viistante Ate                            ³
//³ MV_PAR05        //  Empresa De                               ³
//³ MV_PAR06        //  Empresa Ate                              ³
//³ MV_PAR07        //  Dia Inicial                              ³
//³ MV_PAR08        //  Dia Final                                ³
//³ MV_PAR09        //  Data Baixa Inicial                       ³
//³ MV_PAR10        //  Data Baixa Final                         ³
//³ MV_PAR11        //  Cracha    De                             ³
//³ MV_PAR12        //  Cracha    Ate                            ³
//³ MV_PAR13        //  Lista Acessos                            ³  
//³ MV_PAR14        //  Hora Ref. Inicio                         ³
//³ MV_PAR15        //  Hora Ref. Fim                            ³
//³ MV_PAR16        //  Tipo Visita		                         ³
//³ MV_PAR17        //  Status Visita                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//-- Interface de impressao
Pergunte("PNR130",.F.)

oReport := ReportDef()
oReport:PrintDialog()	

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PONR130   ºAutor  ³Equipe - RH         º Data ³  15/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
	
Static Function ReportDef()
Local oReport 
Local  aOrd       	:= {STR0104 , STR0105, STR0106, STR0107, STR0108   } // "Visitante + Data Visita"###"Cracha + Data Visita""###"Data Visita + Cracha"###"Baixa + Cracha###"Empresa + Data Visita"

DEFINE REPORT oReport NAME "PONR130" TITLE OemToAnsi(STR0001)  PARAMETER "PNR130" ACTION {|oReport| NR130Imp(oReport)}  DESCRIPTION OemtoAnsi(STR0109)  //'Este relatório apresenta a relação das visitas recebidas em um determinado periodo.'
	DEFINE SECTION o1SPY OF oReport TITLE OemToAnsi(STR0011) ORDERS aOrd TABLES "SM0","SPY" PAGE HEADER  			// 'Relatorio de Controle de Refeicoes'
		o1SPY:SetLineStyle()	// Impressao da descricao e conteudo do campo na mesma linha

		//-----------------------------------------
		// oSection1 = Impressao da empresa em uso 
		//-----------------------------------------
		DEFINE CELL NAME "M0_NOME" 		OF o1SPY ALIAS "SM0"	TITLE STR0020  	SIZE 20 BLOCK {|| SM0->M0_NOME   				}  // Empresa: 
		DEFINE CELL NAME "FILIAL" 		OF o1SPY ALIAS "SPY"	TITLE STR0016   SIZE 15 BLOCK {|| (cAliasQry)->PY_FILIAL+" - "+If(len(ainfo)>0,ainfo[2],"") }	// Filial

	DEFINE SECTION o2SPY OF oReport TITLE OemToAnsi(STR0001 ) ORDERS aOrd TABLE "SPY" TOTAL IN COLUMN
		//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		// oSection2 = usado para montar o cabeçalho do relatorio
		//	Empresa			"Visitante                         |Cracha     |  Data     |  Entrada         |  Saida           |  Baixa    | Contato              | C.Custo                           "
		//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		DEFINE CELL NAME "PYNOMEMP" 	OF o2SPY 				TITLE STR0020 	SIZE 12											//Empresa
		DEFINE CELL NAME "VISITANTE" 	OF o2SPY 				TITLE STR0024 	SIZE 30	BLOCK {|| Substr(aVisitas[nNumVisita,14],1,38) }				//"Visitante"
		DEFINE CELL NAME "PY_CRACHA" 	OF o2SPY 				TITLE STR0025	SIZE 10	BLOCK {|| aVisitas[nNumVisita, 01] }							//"Cracha"
		DEFINE CELL NAME "PY_DTVISIT" 	OF o2SPY 				TITLE STR0026	SIZE 10	BLOCK {|| Dtoc(aVisitas[nNumVisita,02]) }						//"Data" visita
		DEFINE CELL NAME "2ENTRADA" 	OF o2SPY 				TITLE STR0027	SIZE 17	BLOCK {|| Dtoc(aVisitas[nNumVisita,04])+" "+StrTran(StrZero(aVisitas[nNumVisita,05],5,2),'.',':')  }		//"Entrada" + "Saida"
		DEFINE CELL NAME "2SAIDA" 		OF o2SPY 				TITLE STR0028   SIZE 17	BLOCK {|| Dtoc(aVisitas[nNumVisita,06])+" "+StrTran(StrZero(aVisitas[nNumVisita,07],5,2),'.',':') }		//Entrada Saida
		DEFINE CELL NAME "2BAIXA" 		OF o2SPY 				TITLE STR0029	SIZE 10	BLOCK {|| Dtoc(aVisitas[nNumVisita,03]) }						//Data da baixa
		DEFINE CELL NAME "2CONTATO" 	OF o2SPY 				TITLE STR0030	SIZE 24	
		DEFINE CELL NAME "2CCUSTO" 		OF o2SPY 				TITLE STR0031	SIZE 21	BLOCK {|| aVisitas[nNumVisita, 10]+"  "+Substr(aVisitas[nNumVisita, 11],1,13) }

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PONR130   ºAutor  ³Microsiga           º Data ³  11/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function NR130Imp(oReport)
Local aAcessos		:= {}
Local aAreaSPY	 	:= SPY->( GetArea() )
Local aTempSPY	 	:= SPY->( dbStruct() )                      
Local cAcessaSPY 	:= &("{ || " + ChkRH("PONR130",'SPY',"2") + "}")  
Local cAliasQuery	:= 'SPY'
Local cCodMat		:= ''
Local cDbSeek		:= '' 
Local cEmpresa		:= ''
Local cFAnt    	 	:= ''   
Local cFilAlias	 	:= xFilial('SPY')
Local cFilSPW	 	:= xFilial('SPW')	
Local cFilSPZ    	:= xFilial('SPZ')                                    
Local cInicio	 	:= ''
Local cFim		 	:= ''
Local dDtAnt 		:= Ctod('')
Local lImpEmp	    := .F.
Local lSalta	    := .F.
Local nContField	:= Len(aTempSPY)   
Local nX			:= 0
Local cLastFil		:= "__cLastFil__"     
Local aNumAcessos	:= {0.00,0.00,0.00}
Local oBreakCc

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Declaracao de variaveis                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//-- Objeto
Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oReport:Section(2)
Local nOrdem		:= oSection1:GetOrder()
Local cTitFil		:= ""

//oSection1:SetHeaderBreak(.f.) 

Private cFilDe     := ''
Private cFilAte    := ''
Private cVisDe     := ''
Private cVisAte    := ''
Private cEmpDe     := ''
Private cEmpAte    := ''
Private cTpVis     := ''
Private dIniVisita := CtoD('  /  /  ')
Private dFimVisita := CtoD('  /  /  ')
Private dIniBaixa  := CtoD('  /  /  ')
Private dFimBaixa  := CtoD('  /  /  ')
Private cCrachaDe  := ''
Private cCrachaAte := ''
Private lAcessos   := .F.
Private nHoraDe    := 00.00
Private nHoraAte   := 23.59
Private nStatusVis := 3

If nOrdem == 1
	oBreakCc 	:= TRBreak():New(oSection2,{|| (cAliasQry)->PY_FILIAL+(cAliasQry)->PY_VISITA},STR0024, .F.,,.F.) 							//-- Codigo do Visitante + Data 
	DEFINE FUNCTION FROM oSection2:Cell("VISITANTE") 	FUNCTION COUNT BREAK oBreakCC  PICTURE "@E 999.99"  NO END REPORT // [No End Report] -  nao faz a impressao no final geral do relatgorio.
ElseIf nOrdem == 2
	oBreakCc 	:= TRBreak():New(oSection2,{|| (cAliasQry)->PY_FILIAL+(cAliasQry)->PY_CRACHA},STR0025, .F.,,.f.)							//-- Filial + Cracha + Data Visita
	DEFINE FUNCTION FROM oSection2:Cell("PY_CRACHA") 	FUNCTION COUNT BREAK oBreakCC  PICTURE "@E 999.99"  NO END REPORT  // [No End Report] -  nao faz a impressao no final geral do relatgorio.
ElseIf nOrdem == 3
	oBreakCc 	:= TRBreak():New(oSection2,{|| Dtos((cAliasQry)->PY_DTVISIT) },STR0032, .F.,,.f.) 					//-- Filial + Data Visita + Cracha
	DEFINE FUNCTION FROM oSection2:Cell("PY_DTVISIT") 	FUNCTION COUNT BREAK oBreakCC  PICTURE "@E 999.99"  NO END REPORT  //	NO END REPORT  // [No End Report] -  nao faz a impressao no final geral do relatgorio.
	oBreakCc:SetTitle(STR0015)
ElseIf nOrdem == 4
	oBreakCc 	:= TRBreak():New(oSection2,{|| DTOS((cAliasQry)->PY_DTBAIXA) },STR0033, .F.,,.f.)  					//-- Filial + Data de Baixa + Cracha
	DEFINE FUNCTION FROM oSection2:Cell("2BAIXA") 		FUNCTION COUNT BREAK oBreakCC  PICTURE "@E 999.99"  NO END REPORT  //	[No End Report] -  nao faz a impressao no final geral do relatgorio.
	oBreakCc:SetTitle(STR0029)
ElseIf nOrdem == 5
	oBreakCc 	:= TRBreak():New(oSection2,{|| (cAliasQry)->PY_FILIAL+(cAliasQry)->PY_NOMEMP },STR0020, .F.,,.f.) 							//-- Filial + Empresa + Data Visita
	DEFINE FUNCTION FROM oSection2:Cell("PYNOMEMP") 	FUNCTION COUNT BREAK oBreakCC  PICTURE "@E 999.99"  NO END REPORT   //	[No End Report] -  nao faz a impressao no final geral do relatgorio.
	oBreakCc:SetTitle(STR0020)
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis MV_PAR?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cFilDe     := MV_PAR01
cFilAte    := MV_PAR02
cVisDe     := MV_PAR03
cVisAte    := MV_PAR04
cEmpDe     := MV_PAR05
cEmpAte    := MV_PAR06
dIniVisita := MV_PAR07
dFimVisita := MV_PAR08
dIniBaixa  := MV_PAR09
dFimBaixa  := MV_PAR10  
cCrachaDe  := MV_PAR11
cCrachaAte := MV_PAR12
lAcessos   := If(MV_PAR13=1,.T.,.F.) 
nHoraDe    := MV_PAR14
nHoraAte   := MV_PAR15   
cTpVis     := If(MV_PAR16=1,'1',If(MV_PAR16=2,'2','3')) 
nStatusVis := MV_PAR17

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz filtro no arquivo...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cAliasQry	:= GetNextAlias()

cQuery	:= ""
If !Empty(dFimBaixa) .And. !Empty(dIniBaixa)
	If nStatusVis == 2
		cQuery +="SPY.PY_DTBAIXA  Between	 '" + Dtos(dIniBaixa) + "' AND '" + Dtos(dFimBaixa) + "' AND "
	Else
		cQuery +="( ( SPY.PY_DTBAIXA  Between	 '" + Dtos(dIniBaixa) + "' AND '" + Dtos(dFimBaixa) + "' ) OR SPY.PY_DTBAIXA = '' ) AND "
    EndIf
EndIf
	
cQuery	:= "%"+cQuery+"%"

If nOrdem == 1				//-- Codigo do Visitante + Data
	cIndCond  := "%PY_FILIAL,PY_VISITA,PY_CRACHA%"
ElseIf nOrdem == 2			//-- Filial + Cracha + Data Visita
	cIndCond  := "%PY_FILIAL,PY_CRACHA,PY_DTVISIT%"
ElseIf nOrdem == 3			//-- Filial + Data Visita + Cracha
	cIndCond  := "%PY_FILIAL,PY_DTVISIT,PY_CRACHA%"
ElseIf nOrdem == 4			//-- Filial + Data de Baixa + Cracha
	cIndCond  := "%PY_FILIAL,PY_DTBAIXA,PY_CRACHA%"
ElseIf nOrdem == 5			//-- Filial + Empresa + Data Visita
	cIndCond  := "%PY_FILIAL,PY_NOMEMP,PY_DTVISIT%"
Endif

oSection2:BeginQuery()

   	BeginSql alias cAliasQry  //"SPY"

SELECT *
FROM %table:SPY% SPY   
WHERE   SPY.PY_FILIAL 			>= %exp:cFilDe% 			AND SPY.PY_FILIAL			<= %exp:cFilAte% AND
		SPY.PY_VISITA 			>= %exp:cVisDe% 			AND SPY.PY_VISITA			<= %exp:cVisAte% AND
		SPY.PY_DTVISIT 			>= %exp:DTOS(dIniVisita)%	AND SPY.PY_DTVISIT			<= %exp:DTOS(dFimVisita)% AND
		SPY.PY_CRACHA			>= %exp:cCrachaDe% 			AND SPY.PY_CRACHA			<= %exp:cCrachaAte% AND
		SPY.PY_NOMEMP			>= %exp:cEmpDe% 			AND SPY.PY_NOMEMP			<= %exp:cEmpAte% AND
		%exp:cQuery%	
	  	SPY.%notDel%   
		ORDER BY %exp:cIndCond%
EndSql       
oSection2:EndQuery()

oReport:OnPageBreak({|| oSection1:Init(), oSection1:PrintLine(),oSection1:Finish() })

//dbSelectArea("SPY")
dbSelectArea(cAliasQry)
dbGoTop()

While !EOF()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta Regua Processamento                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//-- Incrementa a régua da tela de processamento do relatório
  	oReport:IncMeter()
                                
	//-- Verifica se o usuário cancelou a impressão do relatorio
	If oReport:Cancel()
		Exit
	EndIf      

	 //-- Verifica a quebra de Filial e atualiza o Gauge de Filial
	IF !( cLastFil == (cAliasQry)->PY_FILIAL ) 
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Atualiza o Filial Anterior								   ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		cLastFil := (cAliasQry)->PY_FILIAL  
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Atualiza a Empresa Visitante								   ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		cEmpresa  := (cAliasQry)->PY_NOMEMP
		 
		/*	
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Carrega as Filiais dos Arquivoss                             ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		cFilSPZ 	:= xFilial("SPZ", cLastFil)   
		cFilSPW 	:= xFilial("SPW", cLastFil)   
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Obtem Informacoes Empresa	      					     	   ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/ 
		If !fInfo( @aInfo , cLastFil )
//			dbSelectArea("SPY")
			dbSelectArea(cAliasQry)
			dbSkip()
			Loop
    	EndIf  
	Endif
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste controle de acessos e filiais validas				 |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    If !((cAliasQry)->PY_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSPY)
//		dbSelectArea("SPY")
		dbSelectArea(cAliasQry)
		dbSkip()
		Loop
    EndIf

   	//-- Verifica Tipo de Visita
	If cTpVis <> '3'
		If	(cAliasQry)->PY_TIPOVIS <> cTpVis  	
//			dbSelectArea("SPY")
			dbSelectArea(cAliasQry)
			dbSkip()
			Loop
		Endif	    
	Endif 
	
	//-- Verifica Status da Visita
	If nStatusVis <> 3
		If	EMPTY((cAliasQry)->PY_DTBAIXA) .AND. nStatusVis == 2  	
			dbSelectArea(cAliasQry)
			dbSkip()
			Loop
		ElseIf	!EMPTY((cAliasQry)->PY_DTBAIXA) .AND. nStatusVis == 1  	
			dbSelectArea(cAliasQry)
			dbSkip()
			Loop
		Endif
			    
	Endif
		
	//-- Verifica Horarios (ATENCAO: Nao Fazer Data + Horas)
	If	(cAliasQry)->( PY_ENTRADA < nHoraDe .OR. 	PY_SAIDA    > nHoraAte ) 
//		dbSelectArea("SPY")
		dbSelectArea(cAliasQry)
		dbSkip()
		Loop
	Endif

     //-- Zera Acumuladores 
	aVisitas	:={}
		
	aAdd( aVisitas , Array( 15 )  )
	nLenVisitas 	:= Len( aVisitas )                                                                          
	cCodMat			:= 	(cAliasQry)->PY_MAT

	If !Empty(cCodMat)
		SRA->(DbSeek((cAliasQry)->PY_FILIAL+cCodMat))
		cNome	:= SRA->RA_NOME
		cCC		:= SRA->RA_CC
		cDescCC	:= Upper( AllTrim( fDesc("SI3",cCC,"I3_DESC",,fFilfunc('SRA') ) ) )
	Else
	    cNome	:= SPACE(len(SRA->RA_NOME))
	    cCC     := 	(cAliasQry)->PY_CC  
		cDescCC	:= Upper( AllTrim( fDesc("SI3",cCC,"I3_DESC",,(cAliasQry)->PY_FILIAL ) ) )				    
	Endif                                                                       
	
	(cAliasQry)->( aVisitas[ nLenVisitas , 1   ] 	:= PY_CRACHA	)	//01 - Cracha da Visita
	(cAliasQry)->( aVisitas[ nLenVisitas , 2   ] 	:= PY_DTVISIT	)	//02 - Data da Visita
	(cAliasQry)->( aVisitas[ nLenVisitas , 3   ] 	:= PY_DTBAIXA	)	//03 - Data da Baixa
	(cAliasQry)->( aVisitas[ nLenVisitas , 4   ] 	:= PY_DATAE		)	//04 - Data da Entrada 
	(cAliasQry)->( aVisitas[ nLenVisitas , 5   ] 	:= PY_ENTRADA	)	//05 - Hora de Entrada
	(cAliasQry)->( aVisitas[ nLenVisitas , 6   ]	:= PY_DATAS	    )	//06 - Data da Saida
	(cAliasQry)->( aVisitas[ nLenVisitas , 7   ] 	:= PY_SAIDA		)	//07 - Hora da Saida
				
	aVisitas[ nLenVisitas , 8   ] 		  	:= cCodMat 			//08 - Cracha do Contato
	aVisitas[ nLenVisitas , 9   ] 			:= cNome 			//09 - Cracha do Contato
	aVisitas[ nLenVisitas , 10  ]			:= cCC 				//10 - Cracha do Contato
	aVisitas[ nLenVisitas , 11  ] 			:= cDescCC 			//11 - Cracha do Contato
				
	(cAliasQry)->( aVisitas[ nLenVisitas , 12] 		:= 	PY_TIPOVIS 	)	//12 - Tipo da Visita
	(cAliasQry)->( aVisitas[ nLenVisitas , 13] 		:=  PY_CLASSIF 	)	//13 - Classifica da Visita

    SPW->(DBSEEK(cFilSPW+(cAliasQry)->PY_VISITA))                                                                                                                                                          //+SPACE(150)
   	SPW->( aVisitas[ nLenVisitas , 14]) 	:= SPW->PW_VISITA + ' ' 
	SPW->( aVisitas[ nLenVisitas , 14]) 	+= If(lOfuscaNom, Replicate('*',15), ALLTRIM(SPW->PW_NOME))+SPACE(1)
	SPW->( aVisitas[ nLenVisitas , 14]) 	+= If(lOfuscaNom, Replicate('*',15), ALLTRIM(SPW->PW_POSNOM1))+SPACE(1)
	SPW->( aVisitas[ nLenVisitas , 14]) 	+= If(lOfuscaNom, Replicate('*',15), ALLTRIM(SPW->PW_POSNOM2))+SPACE(1)
	SPW->( aVisitas[ nLenVisitas , 14]) 	+= If(lOfuscaNom, Replicate('*',15), ALLTRIM(SPW->PW_POSNOM3))+SPACE(1)
	SPW->( aVisitas[ nLenVisitas , 14]) 	+= If(lOfuscaNom, Replicate('*',15), ALLTRIM(SPW->PW_POSNOM4))   		                             

    aAcessos:={}                

	If lAcessos
		GetAcessos(	@aAcessos						,;	//01 -> Acessos
					aVisitas[ nLenVisitas , 4   ]	,;	//02 -> Periodo Inicial
					aVisitas[ nLenVisitas , 5	]	,;  //03 -> Hora Inicial
					aVisitas[ nLenVisitas , 6   ]	,;	//04 -> Periodo Final
					aVisitas[ nLenVisitas , 7	]	,;  //05 -> Hora Final
					(cAliasQry)->PY_FILIAL					,;	//06 -> Filial
					aVisitas[ nLenVisitas , 1   ]	,;  //07 -> Cracha
					'SPZ'							;	//08 -> Alias para Carga das Marcacoes
			       ) 
        aVisitas[nLenVisitas, 15]			:= aClone(aAcessos)
	Endif						

    //--Se houve Marcacoes
    If !EMPTY(Len(aVisitas))
		If Empty(aVisitas[nNumVisita, 08])                        
			oSection2:Cell("2CONTATO"):SetBlock({|| Replicate('X',Len(aVisitas[nNumVisita, 08])) +"  "+ Replicate('X',21) })	//  Cod.Mat   +  Nome
		Else
			oSection2:Cell("2CONTATO"):SetBlock({|| aVisitas[nNumVisita, 08] +"  "+ Substr(aVisitas[nNumVisita, 09],1,21) })	// Cod.Mat   +  Nome
		Endif

		oSection2:Cell("PYNOMEMP"):SetBlock({|| (cAliasQry)->PY_NOMEMP })

		oSection2:Init()
		oSection2:PrintLine()   
	Endif

	dbSelectArea(cAliasQry)
	dbSkip()
EndDo

oSection2:Finish()

Return
