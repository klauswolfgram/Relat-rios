/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PCOR320.CH"
#INCLUDE "PROTHEUS.CH"

#DEFINE	CELLTAMDATA	400
#DEFINE	DEF_SEMVAL	"..."

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³FUNCAO    ³ PCOR320  ³ AUTOR ³ Edson Maricate        ³ DATA ³ 18/02/2005 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³DESCRICAO ³ Programa de impressao do demonstrativo de saldos             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ USO      ³ SIGAPCO                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³_DOCUMEN_ ³ PCOR320                                                      ³±±
±±³_DESCRI_  ³ Programa de impressao do demonstrativo de saldos             ³±±
±±³_FUNC_    ³ Esta funcao devera ser utilizada com a sua chamada normal a  ³±±
±±³          ³ partir do Menu do sistema.                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PCOR320(aPerg)

Local aArea	  	:= GetArea()
Local lPrint		:=	.T.
Local cCubo		:=	""

Private COD_CUBO	

Default aPerg := {}

If Len(aPerg) == 0
	
	If Pergunte("PCR320",.T.)	

		cCubo		:=	mv_par01

		COD_CUBO 	:= cCubo

		aPeriodos		:= PcoRetPer( MV_PAR02/*dIniPer*/, MV_PAR03/*dFimPer*/, Str(MV_PAR05,1)/*cTipoPer*/, MV_PAR06==1/*lAcumul*/)
			If Len(aPeriodos) > 100 //limitar em 100 no maximo
				If cPaisLoc == "RUS"
					Aviso(STR0040, STR0039, {STR0041})
				Else
					Aviso("Atencao", STR0039, {"Ok"})  //"Consulta limitada a 100 periodos no maximo. Verifique a periodicidade."
				EndIf
				lPrint	:=	.F.			
			EndIf
			If lPrint
				oReport		:= PCOR320Def( "PCR320", cCubo, aPeriodos)
			EndIf
	Else
		lPrint		:=	.F.
		
	Endif

Else
	aEval(aPerg, {|x, y| &("MV_PAR"+StrZero(y,2)) := x})
	aPeriodos	:= PcoRetPer( MV_PAR02/*dIniPer*/, MV_PAR03/*dFimPer*/, Str(MV_PAR05,1)/*cTipoPer*/, MV_PAR06==1/*lAcumul*/)
	If Len(aPeriodos) > 100 //limitar em 100 no maximo
		If cPaisLoc == "RUS"
			Aviso(STR0040, STR0039, {STR0041})
		Else
			Aviso("Atencao", STR0039, {"Ok"})  //"Consulta limitada a 100 periodos no maximo. Verifique a periodicidade."	
		EndIf
		lPrint	:=	.F.			
	EndIf
	If lPrint
		oReport		:= PCOR320Def( "PCR320", cCubo, aPeriodos )
	EndIf		
EndIf

If lPrint	
	oReport:PrintDialog()
Endif

RestArea(aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PCOR320Defº Autor ³ Gustavo Henrique   º Data ³  12/06/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPC1 - Grupo de perguntas do relatorio                    º±±
±±º          ³ EXPC2 - Codigo do cubo em que o relatorio deve ser impressoº±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Planejamento e Controle Orcamentario                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PCOR320Def( cPerg, cCubo, aPeriodos )

Local cReport	:= "PCOR320" 	// Nome do relatorio
Local cTitulo	:= STR0001		// Titulo do relatorio
Local cDescri	:= STR0010 		// Descricao do relatorio

Local aNiveis	:= {}
Local aSections := {}
            
Local nTotSec	:= 0
Local nTotPer	:= 0
Local nSection	:= 1	// Contador de secoes
Local nSldPer	:= 1	// Contador de celulas de saldos por periodo

Local oReport

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TReport():New( cReport, cTitulo, cPerg, { |oReport| PrintReport( oReport, aNiveis, aSections, aPeriodos ) }, cDescri ) // "Este relatorio ira imprimir o Demonstrativo de Saldos por Periodo de acordo com os parâmetros solicitados pelo usuário. Para mais informações sobre este relatorio consulte o Help do Programa ( F1 )."
oReport:ParamReadOnly()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define as secoes do relatorio a partir dos niveis do cubo selecionado  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aRet := PCOTRCubo( @oReport, cCubo, @aNiveis, @aSections)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define as secoes especificas do relatorio                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTotSec := Len( aSections )
nTotPer := Len( aPeriodos )

For nSection := 1 To nTotSec
	If cPaisLoc == "RUS"
		TRCell():New( aSections[nSection], "MOVIMENTOS", /*Alias*/, STR0042, /*Picture*/, 16/*Tamanho*/, .T. )
	Else
		TRCell():New( aSections[nSection], "MOVIMENTOS", /*Alias*/, "Movimentos", /*Picture*/, 16/*Tamanho*/, .T. )
	EndIf
	For nSldPer := 1 To nTotPer
		cTitulo := Alltrim(SubStr(aPeriodos[ nSldPer ], 1 , 10)) + "-" + Alltrim(SubStr(aPeriodos[ nSldPer ], 14 , 10))
		TRCell():New( aSections[nSection], aPeriodos[ nSldPer ],/*Alias*/,cTitulo,"@E 999,999,999,999.99"/*Picture*/,18/*Tamanho*/,.T.,,,.T.,,,,.T.)
	Next nSldPer
	aSections[nSection]:Cell( aNiveis[nSection,2] ):SetSize( 20,.F. )
	aSections[nSection]:Cell( aNiveis[nSection,3] ):SetSize( 40,.F. )
	aSections[nSection]:Cell( aNiveis[nSection,3] ):SetLineBreak()

Next nSection	

Return oReport      

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PrintReport ºAutor³ Gustavo Henrique   º Data ³  12/06/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Impressao das secoes do relatorio definida em cima da      º±±
±±º          ³ configuracao do cubo no array aSections.                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPO1 - Objeto TReport do relatorio                        º±±
±±º          ³ EXPA2 - Array com os niveis do cubo selecionado            º±±
±±º          ³ EXPA3 - Array com os objetos das secoes de cada nivel      º±±
±±º          ³ EXPA4 - Array com os periodos selecionados para impressao  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Planejamento e Controle Orcamentario                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport( oReport, aNiveis, aSections, aPeriodos )

Local nX		:= 1 					// Contador generico
Local nZ		:= 1 					// Contador generico
Local nNivCub	:= 0					// Total de niveis do cubo selecionado
Local nTotPer	:= Len( aPeriodos )

Local aFilIni	:= {}
Local aFilFim	:= {}
Local aCfgCube	:= {}
Local nSection 

Local aAcessoCfg_1
Local aProcCube := {}
Local aConfig 	:= {}
Local cCodCube
Local cCfg_1
Local oStructCube_1
Local aParametros
Local lZerado
Local lEditCfg1
Local cWhereTpSld_1
Local dDataIni, dDataFim, lAcumul, nTpPer
Local aPerAux := {}

Local nMoeda
Local lContinua := .T.

Private aSavPar		:= {}
Private aProcessa	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pergunte do Relatorio                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*
01 - Codigo Cubo Gerencial ?
02 - Periodo de ?
03 - Periodo Ate ?
04 - Qual Moeda ?
05 - Tipo Periodo ?
06 - Acumulado ?
07 - Configuracao do Cubo ?
08 - Editar Configuracoes do Cubo ?
09 - Considerar Zerados ?
10 - Relat.Resumido ?*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Salva parametros para nao conflitar com parambox                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aSavPar := { MV_PAR01, MV_PAR02, MV_PAR03, MV_PAR04, MV_PAR05, MV_PAR06, MV_PAR07, MV_PAR08, MV_PAR09, MV_PAR10 }

cCodCube := MV_PAR01
dDataIni := MV_PAR02 //manipula data base do sistema (tem que voltar depois para conteudo variavel dBase)
dDataFim := MV_PAR03 //manipula data base do sistema (tem que voltar depois para conteudo variavel dBase)

If ValType(MV_PAR04) == "C"
	nMoeda := Val(MV_PAR04)
Else
	nMoeda := MV_PAR04
EndIf

nTpPer  := MV_PAR05
lAcumul := ( MV_PAR06 == 1 )

cCfg_1 := MV_PAR07
lEditCfg1 := ( MV_PAR08 == 1 )

lZerado := ( MV_PAR09 == 1 )

If SuperGetMV("MV_PCOCNIV",.F., .F.)

	//modo utilizando querys para buscar os saldos nas datas em bloco
	//verificar se usuario tem acesso as configuracoes do cubo
	aAcessoCfg_1 := PcoVer_Acesso( cCodCube, cCfg_1 )  	//retorna posicao 1 (logico) .T. se tem acesso
	   													//							.F. se nao tem
	   													//        posicao 2 - Nivel acesso (0-Bloqueado 1-Visualiza 2-altera 
	lContinua := aAcessoCfg_1[1]
	
	If ! lContinua

		Aviso(STR0011, STR0012,{"Ok"}) //"Atencao"###"Usuario sem acesso ao relatorio. Verifique as configuracoes."

	Else
	

		oStructCube_1 := PcoStructCube( cCodCube, cCfg_1 )
				
		If Empty(oStructCube_1:aAlias)  //se estiver vazio eh pq a estrutura nao esta correta
			lContinua := .F.
		EndIf
	                
		If lContinua

			PcoRetPer( aSavPar[02]/*dIniPer*/, aSavPar[03]/*dFimPer*/, Str(aSavPar[05],1)/*cTipoPer*/, aSavPar[06]==1/*lAcumul*/, aPerAux)
	
			//monta array aParametros para ParamBox
			aParametros := PcoParametro( oStructCube_1, lZerado, aAcessoCfg_1[1]/*lAcesso*/, aAcessoCfg_1[2]/*nDirAcesso*/ )
	
	        //exibe parambox para edicao ou visualizacao
			Pco_aConfig(aConfig, aParametros, oStructCube_1, lEditCfg1/*lViewCfg*/, @lContinua)
					
			Pergunte("PCR320",.F.)
			If lContinua
				lZerado	:=	aConfig[Len(aConfig)-1]          //penultimo informacao da parambox (check-box)
				lSintetica	:=	aConfig[Len(aConfig)]        //ultimo informacao da parambox (check-box)
				//veja se tipo de saldo inicial e final eh o mesmo e se nao ha filtro definido neste nivel
				cWhereTpSld_1 := ""
				If oStructCube_1:nNivTpSld > 0 .And. ;
					oStructCube_1:aIni[oStructCube_1:nNivTpSld] == oStructCube_1:aFim[oStructCube_1:nNivTpSld] .And. ;
					Empty(oStructCube_1:aFiltros[oStructCube_1:nNivTpSld])
						cWhereTpSld_1 := " AKT.AKT_TPSALD = '" + oStructCube_1:aIni[oStructCube_1:nNivTpSld] + "' AND "
				EndIf								
						
				aProcCube := { aPerAux, oStructCube_1, aAcessoCfg_1, lZerado, lSintetica, cWhereTpSld_1, lAcumul }
	
				aProcessa := PcoProcCubo(aProcCube, nMoeda, Len(aPerAux)/*nQtdVal*/)
				
				//processamento normal do relatorio
				If aSavPar[10] == 2    //Relatorio Normal
					R320Imp( oReport, aProcessa, aSections, aNiveis, aPeriodos, aSavPar[10] )
					
				ElseIf aSavPar[10] == 1    //Novo Relatorio Resumido
					R320Imp( oReport, aProcessa, aSections, aNiveis, aPeriodos, aSavPar[10] )
				
				ElseIf aSavPar[10] == 3   //Relatorio Norma + Relatorio resumido
				
					aCfgCube	:= {}
                    aSavPar[10] := 2
					R320Imp( oReport, aProcessa, aSections, aNiveis, aPeriodos, aSavPar[10] )
				                        
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Forca quebra de pagina antes da impressao do relatorio resumido ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					oReport:EndPage()	
				
					For nX := 1 To Len( aSections )
						For nZ := 1 To nTotPer
							aSections[nX]:Cell( aPeriodos[nZ] ):SetBlock( { || 0 } )
						Next nZ
					Next nX
						
					aFilIni 	:= {}
					aFilFim 	:= {}
					nNivCub 	:= Len( aNiveis )	
				
					For nX := 1 + nNivCub To Len(aCfgCube)-2 STEP 3
						aAdd(aFilIni, aCfgCube[nX])
						aAdd(aFilFim, aCfgCube[nX+1])
					Next		
				
					aSavPar[10] := 1
					R320Imp( oReport, aProcessa, aSections, aNiveis, aPeriodos, aSavPar[10] )
					
				EndIf
							
			EndIf
		
		EndIf
		
	EndIf

Else

	//processamento normal do relatorio
	If aSavPar[10] == 2    //Relatorio Normal
		aProcessa 	:= PcoRunCube( aSavPar[1], nTotPer*4, "Pcor320Sld", aSavPar[7], aSavPar[8], (aSavPar[9]==1), /*aNiveis*/,/*aFilIni*/,/*aFilFim*/,/*lReserv*/, /*aCfgCube*/,/*lProcessa*/,.T./*lVerAcesso*/)
		ASORT(aProcessa,,,{|x,y|x[1]<y[1]})
		R320Imp( oReport, aProcessa, aSections, aNiveis, aPeriodos, aSavPar[10] )
		
	ElseIf aSavPar[10] == 1    //Novo Relatorio Resumido
		aProcessa	:= PcoRunCube( aSavPar[1], nTotPer*4, "Pcor320Sld", aSavPar[7], aSavPar[8], (aSavPar[9]==1), /*aNiveis*/,/*aFilIni*/,/*aFilFim*/,/*lReserv*/, /*aCfgCube*/,/*lProcessa*/,.T./*lVerAcesso*/)
		ASORT(aProcessa,,,{|x,y|x[1]<y[1]})
		R320Imp( oReport, aProcessa, aSections, aNiveis, aPeriodos, aSavPar[10] )
	
	ElseIf aSavPar[10] == 3   //Relatorio Norma + Relatorio resumido
	
		aCfgCube	:= {}
		aProcessa	:= PcoRunCube( aSavPar[1], nTotPer*4, "Pcor320Sld", aSavPar[7], aSavPar[8], (aSavPar[9]==1), /*aNiveis*/,/*aFilIni*/,/*aFilFim*/,/*lReserv*/, aCfgCube,/*lProcessa*/,.T./*lVerAcesso*/)
		ASORT(aProcessa,,,{|x,y|x[1]<y[1]})
		R320Imp( oReport, aProcessa, aSections, aNiveis, aPeriodos, 2 )
	                        
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Forca quebra de pagina antes da impressao do relatorio resumido ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:EndPage()	
	
		For nX := 1 To Len( aSections )
			For nZ := 1 To nTotPer
				aSections[nX]:Cell( aPeriodos[nZ] ):SetBlock( { || 0 } )
			Next nZ
		Next nX
			
		aFilIni 	:= {}
		aFilFim 	:= {}
		nNivCub 	:= Len( aNiveis )	
	
		For nX := 1 + nNivCub To Len(aCfgCube)-2 STEP 3
			aAdd(aFilIni, aCfgCube[nX])
			aAdd(aFilFim, aCfgCube[nX+1])
		Next	

		aProcessa := PcoRunCube( aSavPar[1], nTotPer*4, "Pcor320Sld", aSavPar[7], 2/*aSavPar[8]*/, (aSavPar[9]==1), /*aNiveis*/,aFilIni,aFilFim,/*lReserv*/, /*aCfgCube*/,/*lProcessa*/,.F./*lVerAcesso*/)
		ASORT(aProcessa,,,{|x,y|x[1]<y[1]})
		R320Imp( oReport, aProcessa, aSections, aNiveis, aPeriodos, 1 )
		
	EndIf
EndIf

Return      


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ R320Imp  ºAutor  ³ Gustavo Henrique   º Data ³  14/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime os relatorios nas opcoes do parametro MV_PAR10     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPO1 - Objeto TReport para impressao                      º±±
±±º          ³ EXPA2 - Array com os valores por periodo                   º±±
±±º          ³ EXPA3 - Array com os objetos das secoes                    º±±
±±º          ³ EXPA4 - Array com os niveis do cubo selecionado            º±±
±±º          ³ EXPA5 - Array com os periodos selecionados para impressao  º±±
±±º          ³ EXPN6 - Tipo de impressao (1=Resumido;2=Normal)            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Planejamento e Controle Orcamentario                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R320Imp( oReport, aProcessa, aSections, aNiveis, aPeriodos, nTipo )

Local nX		:= 1					// Contador generico
Local nY		:= 1					// Contador generico
Local nLinImp	:= 0
Local nNivAtu 	:= 0
Local nTotLin	:= 0
Local nLoop		:= 1
Local nPerAtu	:= 0
Local nSections	:= Len( aSections )		// Total de secoes desconsiderando a ultima referente ao grupo de perguntas
Local nTotRecs	:= Len( aProcessa )
Local nTotPer	:= Len( aPeriodos )		// Total de periodos

Local lChangeNiv:= .T.					// Indica se houve troca de nivel durante a impressao do relatorio

Local bShowCod	:= { ||		aSections[ nNivAtu ]:Cell( aNiveis[ nNivAtu, 2 ] ):ShowHeader(),;
							aSections[ nNivAtu ]:Cell( aNiveis[ nNivAtu, 2 ] ):Show() } 
							
Local bShowDes	:= { || 	aSections[ nNivAtu ]:Cell( aNiveis[ nNivAtu, 3 ] ):ShowHeader(),;
							aSections[ nNivAtu ]:Cell( aNiveis[ nNivAtu, 3 ] ):Show() }

Local bHideCod	:= { |lParam|	aSections[ nNivAtu ]:Cell( aNiveis[ nNivAtu, 2 ] ):HideHeader(),;
								If( lParam, .T., aSections[ nNivAtu ]:Cell( aNiveis[ nNivAtu, 2 ] ):Hide() ) }
							
Local bHideDes	:= { || 	aSections[ nNivAtu ]:Cell( aNiveis[ nNivAtu, 3 ] ):HideHeader(),;
							aSections[ nNivAtu ]:Cell( aNiveis[ nNivAtu, 3 ] ):Hide() }
                                                          
Pergunte("PCR320", .F.)

If nTotRecs > 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualiza conteudo das celulas com o valor que deve ser impresso a partir do array aProcessa ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nX := 1 To nSections

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza conteudo das colunas codigo e descricao                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aSections[nX]:Cell(aNiveis[nX,2]):SetBlock( { || If( nLinImp == 1 .And. lChangeNiv, aNiveis[aProcessa[nLoop,8],5], aProcessa[nLoop,14] ) } )
		aSections[nX]:Cell(aNiveis[nX,3]):SetBlock( { || aProcessa[nLoop,6] } )
	
		aSections[nX]:SetRelation( { || xFilial( aNiveis[nLoop][1] ) + aProcessa[nLoop,14] }, aNiveis[nLoop][1], 3, .T. )
	
		//BLOCO PARA AJUSTE DA IMPRESSAO DA SECAO 1 NO RELATORIO (NAO RETIRAR SE NAO DESALINHA AS COLUNAS)
		aSections[nX]:Init()
		For nY := 1 TO Len(aSections[nX]:aCell)
			aSections[nX]:aCell[nY]:HideHeader()
		Next	
		aSections[nX]:PrintHeader()	
		For nY := 1 TO Len(aSections[nX]:aCell)
			aSections[nX]:aCell[nY]:ShowHeader()
		Next	
		aSections[nX]:Finish()
		//FIM DO BLOCO PARA AJUSTE DA IMPRESSAO DA SECAO 1 NO RELATORIO
	
	Next
	

	oReport:SetMeter( nTotRecs )

	Do While !oReport:Cancel() .And. nLoop <= nTotRecs
	                                         
		If oReport:Cancel()
			Exit
		EndIf
	
		oReport:IncMeter()
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicia impressao da proxima secao, caso a atual for diferente da secao anterior    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lChangeNiv 	:= (nNivAtu <> aProcessa[nLoop,8])
		nNivAtu		:= aProcessa[nLoop,8]
		
		If lChangeNiv
			aSections[nNivAtu]:Init()
			nTotLin := 2	// Duas linhas para troca de nivel, sendo na 1a. nome do nivel e na 2a o detalhe
		Else
			nTotLin := 1	// Uma linha com o detalhe do nivel
		EndIf
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime o nome do nivel da chave do cubo na 1a. linha e o detalhe da chave na 2a.  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	 	For nLinImp := 1 To nTotLin  
	 	
	 		If nLinImp == 1 .And. lChangeNiv
	                                 
	 			aSections[ nNivAtu ]:Cell( "MOVIMENTOS" ):Disable()
					
				For nPerAtu := 1 To nTotPer
		 			aSections[ nNivAtu ]:Cell( aPeriodos[ nPerAtu ] ):Disable()
		 		Next nPerAtu			
	
				Eval( bHideCod, .F. )
				Eval( bHideDes )	
	
				aSections[ nNivAtu ]:Cell( aNiveis[ nNivAtu, 2 ] ):Show()
	 			aSections[ nNivAtu ]:PrintLine()
	
		 	Else
	
				Eval( bShowCod )
				Eval( bShowDes )			
				
				R320ImpDet(	oReport, aSections, aPeriodos, aNiveis, { bHideCod, bHideDes }, nNivAtu, nTotPer, nLoop, nTipo )
		 				
	 		EndIf
	
	 	Next nLinImp    
	    
		nLoop ++
	
		If (nLoop <= nTotRecs .And. nNivAtu	<>aProcessa[nLoop,8]) 
			If aProcessa[nLoop,8] == 1
				oReport:SkipLine()
			EndIf	
			aSections[nNivAtu]:Finish()
		ElseIf nLoop > nTotRecs
			aSections[nNivAtu]:Finish()
		EndIf
	
	EndDo        
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ R320ImpDetºAutor  ³ Gustavo Henrique   º Data ³  14/06/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Impressao do relatorio detalhado. Parametro MV_PAR10       º±±
±±º          ³ igual a 2.                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPO1 - Objeto TReport para impressao                      º±±
±±º          ³ EXPA2 - Array com os objetos das secoes                    º±±
±±º          ³ EXPA3 - Array com os periodos selecionados para impressao  º±±
±±º          ³ EXPA4 - Array com os niveis do cubo selecionado            º±±
±±º          ³ EXPA5 - Array com os code blocks para desabilitar a        º±±
±±º          ³         impressao dos campos Codigo e Descricao do cubo    º±±
±±º          ³ EXPN6 - Nivel atual de impressao do cubo                   º±±
±±º          ³ EXPN7 - Total de periodos selecionados para impressao      º±±
±±º          ³ EXPN8 - Linha atual do vetor aProcessa                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Planejamento e Controle Orcamentario                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R320ImpDet( oReport, aSections, aPeriodos, aNiveis, aHide, nNivAtu, nTotPer, nLoop, nTipo )

Local cBlock	:= ""

Local aCelHide	:= {}
Local aLinTit	:= {	STR0005,;		// "Saldo Inicial: "
						STR0006,;		// "Mov.Credito (C):"
						STR0007,;		// "Mov.Debito (D)"
						STR0008 }		// "Res.Mov.(C - D):"
                                     
Local nPerAtu	:= 1		// Contador de periodo atual
Local nColPer	:= 1		// Contador das colunas referentes ao periodo de cada linha de movimento
Local nLinMov	:= 1		// Contador de linhas de movimento
Local nX		:= 1		// Contador generico
Local nLinInic  := 1
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia impressao na 3a. coluna subsequente as colunas de codigo e descricao do nivel do cubo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nTipo == 1   //resumo
	aSections[ nNivAtu ]:Cell( "MOVIMENTOS" ):Disable()
	nLinInic  := 4	
Else	   //normal
	aSections[ nNivAtu ]:Cell( "MOVIMENTOS" ):Enable()
	nLinInic  := 1
EndIf
 			
For nPerAtu := 1 To nTotPer Step 4
                    
	aCelHide := {}
	
	For nLinMov := nLinInic To 4		// Linhas de movimentos (Saldo Inicial/Debitos/Creditos/Credito-Debito)
                                                     
		aSections[ nNivAtu ]:Cell( "MOVIMENTOS" ):SetValue( aLinTit[ nLinMov ] )

		For nColPer := nPerAtu To (nPerAtu + 3)		// Total de 4 colunas para periodos
                            
			If nColPer <= nTotPer

 				cBlock := "{ || aProcessa[ " + AllTrim( Str( nLoop ) ) + ", 2, " + AllTrim( Str( nLinMov + (4*(nColPer-1)) ) ) + " ] }"
				aSections[ nNivAtu ]:Cell( aPeriodos[ nColPer ] ):SetBlock( MontaBlock( cBlock ) )

				If nLinMov == nLinInic
	 				aSections[ nNivAtu ]:Cell( aPeriodos[ nColPer ] ):Enable()
					AAdd( aCelHide, aPeriodos[ nColPer ] )
	 			EndIf
 			
 			EndIf

	 	Next nColPer
                        
		If nLinMov == nLinInic
			aSections[ nNivAtu ]:PrintHeader()
		EndIf
			
		aSections[ nNivAtu ]:PrintLine()
                                                      
		If nLinMov == nLinInic
            Eval( aHide[1], .F. )
			Eval( aHide[2] )
			aSections[ nNivAtu ]:Cell( "MOVIMENTOS" ):HideHeader()
		EndIf
                
	Next nLinMov

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Desabilita celulas jah impressas antes da quebra de periodos            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nX := 1 To Len( aCelHide )
		aSections[ nNivAtu ]:Cell( aCelHide[ nX ] ):Disable()
	Next nX                               

Next nPerAtu

aSections[ nNivAtu ]:Cell( "MOVIMENTOS" ):ShowHeader()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Pcor320Sld³ Autor ³ Edson Maricate        ³ Data ³18/02/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao de processamento do demonstrativo saldo / periodo.   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Pcor320Sld                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd - Variavel para cancelamento da impressao pelo usuario³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Pcor320Sld(cConfig,cChave)
Local aRetorno := {}
Local aRetIni,aRetFim
Local nCrdIni
Local nDebIni
Local nCrdFim
Local nDebFim
Local ny

For ny := 1 to Len(aPeriodos)

	dIni := CtoD(Subs(aPeriodos[ny],1,10))
	dFim := CtoD(Subs(aPeriodos[ny],14))

	aRetIni := PcoRetSld(cConfig,cChave, dIni-1 )
	nCrdIni := aRetIni[1, aSavPar[4]]
	nDebIni := aRetIni[2, aSavPar[4]]

	aRetFim := PcoRetSld(cConfig,cChave,dFim)
	nCrdFim := aRetFim[1, aSavPar[4]]
	nDebFim := aRetFim[2, aSavPar[4]]

	nSldIni := nCrdIni-nDebIni
	nMovCrd := nCrdFim-nCrdIni
	nMovDeb := nDebFim-nDebIni
	nMovPer := nMovCrd-nMovDeb

	aAdd(aRetorno,nSldIni)
	aAdd(aRetorno,nMovCrd)
	aAdd(aRetorno,nMovDeb)
	aAdd(aRetorno,nMovPer)

Next

Return aRetorno

//------------------------------------------------------------------------------------------------------------------//
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PcoProcCubo ºAutor  ³Paulo Carnelossi    º Data ³ 03/10/08  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Monta as querys baseados nos parametros e configuracoes de  º±±
±±º          ³cubo e executa essas querys para gerar os arquivos tempora- º±±
±±º          ³rios cujos nomes sao devolvidos no array aTabResult         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PcoProcCubo(aProcCube, nMoeda, nQtdVal)
Local cCodCube
Local cArquivo 		:= ""
Local aQueryDim, cArqTmp
Local nZ

Local cWhereTpSld 	:= ""
Local cWhere 		:= ""
Local nNivel 		:= 1 //sempre processar a partir do primeiro nivel
Local aCposNiv 		:= {}
Local aFilesErased 	:= {}
Local aProcCub 		:= {}
Local cArqAS400 	:= ""
Local cSrvType 		:= Alltrim(Upper(TCSrvType()))
Local lDebito 		:= .T.
Local lCredito 		:= .T.
Local aDtSaldo 		:= {}
Local aDtIni 		:= {}
Local nX, aPeriodo, oStructCube, lZerado, lSintetica, lTotaliza
Local lMovimento 	:= .F.
Local lAcumul
aPeriodo	:= aProcCube[1]
oStructCube := aProcCube[2]
lZerado 	:= aProcCube[4]
lSintetica 	:= aProcCube[5]
lTotaliza 	:= .F.
cWhereTpSld := aProcCube[6]
lAcumul		:= aProcCube[7]
cCodCube 	:= oStructCube:cCodeCube

If cSrvType == "ISERIES" //outros bancos de dados que nao DB2 com ambiente AS/400
	//cria arquivo para popular
	PcoCriaTemp(oStructCube, @cArqAS400, nQtdVal)
	aAdd(aFilesErased, cArqAS400)
EndIf

//cria arquivo para popular
PcoCriaTemp(oStructCube, @cArquivo, nQtdVal)
aAdd(aFilesErased, cArquivo)

aQryDim 	:= {}
For nZ := 1 TO oStructCube:nMaxNiveis
	If lSintetica .And. nZ > nNivel
		aQueryDim := PcoCriaQueryDim(oStructCube, nZ, lSintetica, .T./*lForceNoSint*/)
	Else
		aQueryDim := PcoCriaQueryDim(oStructCube, nZ, lSintetica)
	EndIf
	//aqui fazer tratamento quando expressao de filtro e expressao sintetica nao for resolvida
	If (aQueryDim[2] .And. aQueryDim[3])  //neste caso foi resolvida
		
		If ! aQueryDim[4]
			aAdd( aQryDim, { aQueryDim[1], ""} )
		Else	
			aAdd( aQryDim, { aQueryDim[1], aQueryDim[5]} )
		EndIf
		
	Else  //se filtro ou condicao de sintetica nao foi resolvida pela query

		aQueryDim := PcoQueryDim(oStructCube, nZ, @cArqTmp, aQueryDim[1] )
		aAdd(aFilesErased, cArqTmp)
		
		If ! aQueryDim[4]
			aAdd( aQryDim, { aQueryDim[1], ""} )
		Else	
			aAdd( aQryDim, { aQueryDim[1], aQueryDim[5]} )
		EndIf
	
	EndIf	
Next

For nZ := nNivel+1 TO oStructCube:nMaxNiveis
	If nZ == oStructCube:nNivTpSld
		aAdd(aCposNiv, "AKT_TPSALD")
	Else
		aAdd(aCposNiv, "AKT_NIV"+StrZero(nZ, 2) )
	EndIf
Next

For nX := 1 TO Len(aPeriodo)
	aAdd(aDtIni, STOD(aPeriodo[nX,1])) 
	aAdd(aDtSaldo, STOD(aPeriodo[nX, 2])) 
Next

aQuery := PcoCriaQry( cCodCube, nNivel, nMoeda, cArqAS400, nQtdVal, aDtSaldo, aQryDim, cWhere, cWhereTpSld, oStructCube:nNivTpSld, lMovimento, aDtIni, .T./*lAllNiveis*/, aCposNiv, lDebito, lCredito )

PcoPopulaTemp(oStructCube, cArquivo, aQuery, nQtdVal, lZerado, cArqAS400, lDebito, lCredito )

dbSelectArea(cArquivo)
dbCloseArea()

CarregaProcessa(aProcCub, oStructCube, cArquivo, nQtdVal, lAcumul)

If ! Empty(aFilesErased)
	//apaga os arquivos temporarios criado no banco de dados
	For nZ := 1 TO Len(aFilesErased)
		If Select(Alltrim(aFilesErased[nZ])) > 0
			dbSelectArea(Alltrim(aFilesErased[nZ]))
			dbCloseArea()
		EndIf	
		MsErase(Alltrim(aFilesErased[nZ]))
	Next
EndIf

Return aProcCub


Static Function CarregaProcessa(aProcCub, oStructCube, cArquivo, nQtdVal, lAcumul)
Local cChave, nTamNiv, nPai, cChavOri, cDescrAux, lAuxSint
Local nNivel
Local nX, nZ, nY
Local cQuery
Local aValor, nSldIni, nMovCrd, nMovDeb, nMovPer

For nX := 1 TO oStructCube:nMaxNiveis

	nNivel := nX
	nTamNiv := oStructCube:aTam[nNivel]

	cQuery := " SELECT "

	For nZ := 1 TO nNivel
		cQuery += If(nZ>1, ", ", "") + "AKT_NIV"+StrZero(nZ,2)
	Next //nZ

	For nY := 1 TO nQtdVal
		cQuery += " , SUM(AKT_DEB"+StrZero(nY,3)+") AKT_DEB"+StrZero(nY,3)
		cQuery += " , SUM(AKT_CRD"+StrZero(nY,3)+") AKT_CRD"+StrZero(nY,3)
		cQuery += " , SUM(AKT_SLD"+StrZero(nY,3)+") AKT_SLD"+StrZero(nY,3)
	Next //nY

	cQuery +=" FROM "+cArquivo

	cQuery += " GROUP BY "
	For nZ := 1 TO nNivel
		cQuery += If(nZ>1, ", ", "") + "AKT_NIV"+StrZero(nZ,2)
	Next //nZ
	cQuery += " ORDER BY "
	For nZ := 1 TO nNivel
		cQuery += If(nZ>1, ", ", "") + "AKT_NIV"+StrZero(nZ,2)
	Next //nZ

	cQuery := ChangeQuery( cQuery )
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cArquivo, .T., .T. )

	dbSelectArea(cArquivo)
	dbGoTop()
	
	While (cArquivo)->( ! Eof() )
		cChave := ""
		For nZ := 1 TO nX	
			cChave += PadR( (cArquivo)->(FieldGet(FieldPos("AKT_NIV"+StrZero(nZ,2)))) , oStructCube:aTamNiv[nZ])
		Next //nZ
		cChave := PadR( cChave , nTamNiv)

		nPai := 0
		cChavOri := cChave
		//descricao tem q macro executar a expressao contida em oStrucCube:aDescRel
		dbSelectArea(oStructCube:aAlias[nNivel])
		If dbSeek(xFilial()+PadR( (cArquivo)->(FieldGet(FieldPos("AKT_NIV"+StrZero(nNivel,2)))) , oStructCube:aTamNiv[nNivel]) )
			cDescrAux := &(oStructCube:aDescRel[nNivel])
			If ! Empty(oStructCube:aCondSint[nNivel])
				lAuxSint := &(oStructCube:aCondSint[nNivel])
			Else	
				lAuxSint := .F.	
			EndIf
		Else
			cDescrAux := "OUTROS ( NAO ESPECIFICADO )"
			lAuxSint := .F.		
		EndIf	
		
		aValor := {}

		nSldIni := (cArquivo)->( FieldGet(FieldPos("AKT_CRD"+StrZero(1,3))) - FieldGet(FieldPos("AKT_DEB"+StrZero(1,3)))  ) // nCrdIni-nDebIni
		nMovCrd := (cArquivo)->( FieldGet(FieldPos("AKT_CRD"+StrZero(1,3))) )  //nCrdIni	
		nMovDeb := (cArquivo)->( FieldGet(FieldPos("AKT_DEB"+StrZero(1,3))) ) // nDebIni
		nMovPer :=  nMovCrd-nMovDeb

		aAdd(aValor, nSldIni )
		aAdd(aValor, nMovCrd )
		aAdd(aValor, nMovDeb )
		aAdd(aValor, nMovPer )

		For nY := 2 TO nQtdVal
            
			If lAcumul
				nSldIni := (cArquivo)->( FieldGet(FieldPos("AKT_CRD"+StrZero(1,3))) - FieldGet(FieldPos("AKT_DEB"+StrZero(1,3)))  ) // nCrdIni-nDebIni
				nMovCrd := (cArquivo)->( FieldGet(FieldPos("AKT_CRD"+StrZero(nY,3)))   - FieldGet(FieldPos("AKT_CRD"+StrZero(1,3))) )  // nCrdFim-nCrdIni	
				nMovDeb := (cArquivo)->( FieldGet(FieldPos("AKT_DEB"+StrZero(nY,3)))   - FieldGet(FieldPos("AKT_DEB"+StrZero(1,3))) ) // nDebFim-nDebIni
				nMovPer :=  nMovCrd-nMovDeb
		    Else
				nSldIni := (cArquivo)->( FieldGet(FieldPos("AKT_CRD"+StrZero(nY-1,3))) - FieldGet(FieldPos("AKT_DEB"+StrZero(nY-1,3)))  ) // nCrdIni-nDebIni
				nMovCrd := (cArquivo)->( FieldGet(FieldPos("AKT_CRD"+StrZero(nY,3)))   - FieldGet(FieldPos("AKT_CRD"+StrZero(nY-1,3))) )  // nCrdFim-nCrdIni	
				nMovDeb := (cArquivo)->( FieldGet(FieldPos("AKT_DEB"+StrZero(nY,3)))   - FieldGet(FieldPos("AKT_DEB"+StrZero(nY-1,3))) ) // nDebFim-nDebIni
				nMovPer :=  nMovCrd-nMovDeb
		    EndIf

			aAdd(aValor, nSldIni )
			aAdd(aValor, nMovCrd )
			aAdd(aValor, nMovDeb )
			aAdd(aValor, nMovPer )

        Next  //nY

	  	aAdd(aProcCub, {	cChave, ;
	  						aClone(aValor), ;
		  					oStructCube:aConcat[nNivel], ;
		  					oStructCube:aAlias[nNivel], ;
	  						oStructCube:aDescri[nNivel], ;
	  						cDescrAux,;
		  					1,;
		  					nNivel,;
	  						cChavOri,;
	  						lAuxSint/*oStructCube:aCondSint[nNivel]*/,;
	  						nPai,;
		  					.T.,;
		  					oStructCube:aDescCfg[nNivel],;
							Right(cChave, oStructCube:aTamNiv[nNivel]),;
							( nNivel  == oStructCube:nMaxNiveis ) })
	
		dbSelectArea(cArquivo)
		(cArquivo)->(dbSkip())
	
	EndDo	
	
	dbSelectArea(cArquivo)
	dbCloseArea()

Next // nX

ASORT(aProcCub,,,{|x,y|x[1]<y[1]})

Return
