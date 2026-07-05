/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "pcor500.ch"
#INCLUDE "PROTHEUS.CH"

#DEFINE CELLTAMDATA 280
#DEFINE NLIMITEMAX 2700

#define TAM_CEL		15
#define PIC_VALOR		"@E 999,999,999,999.99"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³FUNCAO    ³ PCOR500  ³ AUTOR ³ Edson Maricate        ³ DATA ³ 07/01/2004 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³DESCRICAO ³ Programa de impressao do balancete configuravel por Tp. Saldo³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ USO      ³ SIGAPCO                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³_DOCUMEN_ ³ PCOR500                                                      ³±±
±±³_DESCRI_  ³ Programa de impressao do balancete configuravel por Tp.Saldo ³±±
±±³_FUNC_    ³ Esta funcao devera ser utilizada com a sua chamada normal a  ³±±
±±³          ³ partir do Menu do sistema.                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PCOR500(aPerg)
Local aArea		:= GetArea()
Local lPrint	:= .T.

Private aSavPar	
Private cCadastro := STR0001 //"Comparativo de Cubos - Balancete"
Private nLin	:= 10000
Default aPerg := {}

If Len(aPerg) == 0
	If Pergunte("PCRCUB",.T.)
		cCubo	:=	mv_par01

		SetMVValue("PCR500","MV_PAR01",cCubo) 

		COD_CUBO := cCubo

		Pergunte("PCR500",.F.)
	   	oReport	:= PCOR500Def( "PCR500", cCubo)
	Else
		lPrint	:=	.F.
	Endif
Else
	aEval(aPerg, {|x, y| &("MV_PAR"+StrZero(y,2)) := x})
   	oReport	:= PCOR500Def( "PCR500", cCubo)
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
±±ºPrograma  ³ PCOR500Defº Autor ³ Gustavo Henrique   º Data ³  21/06/06  º±±
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
Static Function PCOR500Def( cPerg, cCubo )

Local cReport	:= "PCOR500" 	// Nome do relatorio

Local aNiveis	:= {}
Local aSections := {}
            
Local nTotSec	:= 0
Local nSection	:= 0

Local oReport
Local oValores
Local oObjSec

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

// "Este relatorio ira imprimir o Comparativo de Cubos - Balancete de acordo com os parâmetros solicitados pelo usuário. Para mais informações sobre este relatorio consulte o Help do Programa ( F1 )."
oReport := TReport():New( cReport, STR0001, cPerg, { |oReport| PrintReport( oReport, aNiveis, aSections ) }, STR0023 )

oReport:SetLandscape()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define as secoes do relatorio a partir dos niveis do cubo selecionado  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PCOTRCubo( @oReport, cCubo, @aNiveis, @aSections, .T. )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define as secoes especificas do relatorio                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTotSec := Len( aSections )

For nSection := 1 To nTotSec
                       
	If nSection == 1
		oObjSec := aSections[nSection]
	Else
		oObjSec := oObjSec:Section(1)
	EndIf				

	oObjSec:SetHeaderSection(.F.)
    oObjSec:SetHeaderPage(.F.)
    
	oValores1 := TRSection():New( oObjSec, "1-" + STR0024 + AllTrim(aNiveis[nSection,5]) )	// "Movimentos do nivel "

	TRCell():New( oValores1, "SALDO_ANT_A1"   ,/*Alias*/,STR0004, PIC_VALOR, TAM_CEL,/*lPixel*/,)	//"Saldo Anterior (A1)"
	TRCell():New( oValores1, "SALDO_ANT_A2"   ,/*Alias*/,STR0005, PIC_VALOR, TAM_CEL,/*lPixel*/,)	//"Saldo Anterior (A2)"
	TRCell():New( oValores1, "DIF_VALOR_A1_A2",/*Alias*/,STR0006, PIC_VALOR, TAM_CEL,/*lPixel*/,)	//"Diferenca (A1-A2)"
	TRCell():New( oValores1, "DIF_PERC_A2_A1" ,/*Alias*/,STR0007, PIC_VALOR, TAM_CEL,/*lPixel*/,)	//"Diferenca (A2/A1 %)"
	TRCell():New( oValores1, "MOV_CREDITO_C1" ,/*Alias*/,STR0008, PIC_VALOR, TAM_CEL,/*lPixel*/,)	//"Mov.Credito (C1)"
	TRCell():New( oValores1, "MOV_CREDITO_C2" ,/*Alias*/,STR0009, PIC_VALOR, TAM_CEL,/*lPixel*/,)	//"Mov.Credito (C2)"
	TRCell():New( oValores1, "DIF_VALOR_C1_C2",/*Alias*/,STR0010, PIC_VALOR, TAM_CEL,/*lPixel*/,)	//"Diferenca (C1-C2)"
	TRCell():New( oValores1, "DIF_PERC_C2_C1" ,/*Alias*/,STR0011, PIC_VALOR, TAM_CEL,/*lPixel*/,)	//"Diferenca (C2/C1 %)"
	oValores1:SetLinesBefore(0)
	oValores1:SetLeftMargin(20)
	oValores1:SetHeaderPage( .F.)
	
	oValores2 := TRSection():New( oObjSec, "2-" + STR0024 + AllTrim(aNiveis[nSection,5]) )	// "Movimentos do nivel "

	TRCell():New( oValores2, "MOV_DEBITO_D1"  ,/*Alias*/,STR0012, PIC_VALOR, TAM_CEL,/*lPixel*/,)	//"Mov.Debito (D1)"
	TRCell():New( oValores2, "MOV_DEBITO_D2"  ,/*Alias*/,STR0013, PIC_VALOR, TAM_CEL,/*lPixel*/,)	//"Mov.Debito (D2)"
	TRCell():New( oValores2, "DIF_VALOR_D1_D2",/*Alias*/,STR0014, PIC_VALOR, TAM_CEL,/*lPixel*/,)	//"Diferenca (D1-D2)"
	TRCell():New( oValores2, "DIF_PERC_D2_D1" ,/*Alias*/,STR0015, PIC_VALOR, TAM_CEL,/*lPixel*/,)	//"Diferenca (D2/D1 %)"
	TRCell():New( oValores2, "SALDO_FINAL_F1" ,/*Alias*/,STR0016, PIC_VALOR, TAM_CEL,/*lPixel*/,)	//"Saldo Final (F1)"
	TRCell():New( oValores2, "SALDO_FINAL_F2" ,/*Alias*/,STR0017, PIC_VALOR, TAM_CEL,/*lPixel*/,)	//"Saldo Final (F2)"
	TRCell():New( oValores2, "DIF_VALOR_F1_F2",/*Alias*/,STR0018, PIC_VALOR, TAM_CEL,/*lPixel*/,)	//"Diferenca(F1-F2)"
	TRCell():New( oValores2, "DIF_PERC_F2_F1" ,/*Alias*/,STR0019, PIC_VALOR, TAM_CEL,/*lPixel*/,)	//"Diferenca (F2/F1 %)"
	oValores2:SetLinesBefore(0)
	oValores2:SetLeftMargin(20)
	oValores2:SetHeaderPage( .F. )
	
Next nSection

oDescComp := TRSection():New( oReport, STR0025 )	// "Comparativo entre configurações" 

TRCell():New( oDescComp, "DESCRI_COMP1",/*Alias*/,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/)
TRCell():New( oDescComp, "DESCRI_COMP2",/*Alias*/,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/)

oDescComp:SetHeaderPage()

Return oReport      


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PrintReport ºAutor³ Gustavo Henrique   º Data ³  21/06/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Impressao das secoes do relatorio definida em cima da      º±±
±±º          ³ configuracao do cubo no array aSections.                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPO1 - Objeto TReport do relatorio                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Planejamento e Controle Orcamentario                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport( oReport, aNiveis, aSections )

Local nNivAtu 	:= 0
Local nLoop		:= 1  
Local nX		:= 1  
Local nY		:= 1  
Local nTotRecs	:= 0
Local nSections	:= Len( aSections )		// Total de secoes desconsiderando a ultima referente ao grupo de perguntas
Local nMaxCod	:= 0
Local nMaxDescr	:= 0
Local nLinImp	:= 0
Local nTotLin	:= 0
Local nPosComp	:= 0

Local aAcessoCfg_1
Local aAcessoCfg_2

Local aProcCube := {}
Local aConfig 	:= {}
Local cCodCube
Local cCfg_1
Local cCfg_2
Local oStructCube_1
Local oStructCube_2
Local aParametros
Local lZerado
Local lEditCfg1
Local lEditCfg2
Local cWhereTpSld_1
Local cWhereTpSld_2
Local dDataIni, dDataFim
Local aPerAux := {}
Local nQtdVal := 4

Local nMoeda
Local lContinua := .T.
Local cConfig1	:= ""
Local cConfig2	:= ""

Local lChangeNiv:= .T.					// Indica se houve troca de nivel durante a impressao do relatorio

Private aSavPar		:= {}
Private aProcessa	:= {}
Private aProcComp	:= {}

/* PERGUNTAS DO RELATORIO PCR500
01 - Codigo Cubo Gerencial ?
02 - Data de ?
03 - Data Ate ?
04 - Qual Moeda ?
05 - Configuracao do Cubo-1 ?
06 - Editar Configuracoes Cubo-1 ?
07 - Configuracao do Cubo-2 ?
08 - Editar Configuracoes Cubo-2 ?
09 - Considerar Zerados ?
10 - Imprime Tftulo ?
*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Salva parametros para nao conflitar com parambox                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aSavPar := { MV_PAR01, MV_PAR02, MV_PAR03, MV_PAR04, MV_PAR05, MV_PAR06, MV_PAR07, MV_PAR08, MV_PAR09, MV_PAR10 }

//processamento do relatorio
cCodCube := MV_PAR01
dDataIni := MV_PAR02 //manipula data base do sistema (tem que voltar depois para conteudo variavel dBase)
dDataFim := MV_PAR03 //manipula data base do sistema (tem que voltar depois para conteudo variavel dBase)

If ValType(MV_PAR04) == "C"
	nMoeda := Val(MV_PAR04)
Else
	nMoeda := MV_PAR04
EndIf

cCfg_1 := MV_PAR05
lEditCfg1 := ( MV_PAR06 == 1 )

cCfg_2 := MV_PAR07
lEditCfg2 := ( MV_PAR08 == 1 )

lZerado := ( MV_PAR09 == 1 )

If SuperGetMV("MV_PCOCNIV",.F., .F.)

	//modo utilizando querys para buscar os saldos nas datas em bloco
	//verificar se usuario tem acesso as configuracoes do cubo
	aAcessoCfg_1 := PcoVer_Acesso( cCodCube, cCfg_1 )  	//retorna posicao 1 (logico) .T. se tem acesso
	   													//							.F. se nao tem
	   													//        posicao 2 - Nivel acesso (0-Bloqueado 1-Visualiza 2-altera 
	lContinua := aAcessoCfg_1[1]
	
	If lContinua 
		aAcessoCfg_2 := PcoVer_Acesso( cCodCube, cCfg_2 )  	//retorna posicao 1 (logico) .T. se tem acesso
	   												   		//							.F. se nao tem
		   													//        posicao 2 - Nivel acesso (0-Bloqueado 1-Visualiza 2-altera 
		lContinua := aAcessoCfg_2[1]

	EndIf

	If ! lContinua

		Aviso(STR0026, STR0027,{"Ok"}) //"Atencao"###"Usuario sem acesso ao relatorio. Verifique as configuracoes."

	Else
	

		oStructCube_1 := PcoStructCube( cCodCube, cCfg_1 )
				
		If Empty(oStructCube_1:aAlias)  //se estiver vazio eh pq a estrutura nao esta correta
			lContinua := .F.
		EndIf
	                
		If lContinua

			//monta array aParametros para ParamBox
			aParametros := PcoParametro( oStructCube_1, lZerado, aAcessoCfg_1[1]/*lAcesso*/, aAcessoCfg_1[2]/*nDirAcesso*/ )
	
	        //exibe parambox para edicao ou visualizacao
			Pco_aConfig(aConfig, aParametros, oStructCube_1, lEditCfg1/*lViewCfg*/, @lContinua)
					
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
						
				aProcCube := { { dDataIni, dDataFim }, oStructCube_1, aAcessoCfg_1, lZerado, lSintetica, cWhereTpSld_1 }
	
				aProcessa := PcoProcCubo(aProcCube, nMoeda, nQtdVal)
					
			EndIf
		
		EndIf

		If lContinua

			oStructCube_2 := PcoStructCube( cCodCube, cCfg_2 )
				
			If Empty(oStructCube_2:aAlias)  //se estiver vazio eh pq a estrutura nao esta correta
				lContinua := .F.
			EndIf
	                
			If lContinua
	
				//monta array aParametros para ParamBox
				aParametros := PcoParametro( oStructCube_2, lZerado, aAcessoCfg_2[1]/*lAcesso*/, aAcessoCfg_2[2]/*nDirAcesso*/ )
		
		        //exibe parambox para edicao ou visualizacao
				Pco_aConfig(aConfig, aParametros, oStructCube_2, lEditCfg1/*lViewCfg*/, @lContinua)
						
				If lContinua
					lZerado	:=	aConfig[Len(aConfig)-1]          //penultimo informacao da parambox (check-box)
					lSintetica	:=	aConfig[Len(aConfig)]        //ultimo informacao da parambox (check-box)
					//veja se tipo de saldo inicial e final eh o mesmo e se nao ha filtro definido neste nivel
					cWhereTpSld_2 := ""
					If oStructCube_2:nNivTpSld > 0 .And. ;
						oStructCube_2:aIni[oStructCube_2:nNivTpSld] == oStructCube_2:aFim[oStructCube_2:nNivTpSld] .And. ;
						Empty(oStructCube_2:aFiltros[oStructCube_2:nNivTpSld])
							cWhereTpSld_2 := " AKT.AKT_TPSALD = '" + oStructCube_2:aIni[oStructCube_2:nNivTpSld] + "' AND "
					EndIf								
							
					aProcCube := { { dDataIni, dDataFim }, oStructCube_2, aAcessoCfg_2, lZerado, lSintetica, cWhereTpSld_2}
		
					aProcComp := PcoProcCubo(aProcCube, nMoeda, nQtdVal)
						
				EndIf
			
			EndIf
	    
		EndIf	
		
	EndIf

Else

	//modo atual utilizando a funcao pcoruncube()
	//processamento do relatorio
	aProcessa := PcoRunCube( aSavPar[01] /*confg.rel.*/, 4 /*Qtd.Colunas*/, "Pcor500Sld"/*funcao processa pcocube*/,aSavPar[05],aSavPar[06], (aSavPar[09]==1), /*aNiveis*/,/*aFilIni*/,/*aFilFim*/,/*lReserv*/, /*aCfgCube*/,/*lProcessa*/,.T./*lVerAcesso*/)
	aProcComp := PcoRunCube( aSavPar[01] /*confg.rel.*/, 4 /*Qtd.Colunas*/, "Pcor500Sld"/*funcao processa pcocube*/,aSavPar[07],aSavPar[08], (aSavPar[09]==1), /*aNiveis*/,/*aFilIni*/,/*aFilFim*/,/*lReserv*/, /*aCfgCube*/,/*lProcessa*/,.T./*lVerAcesso*/)
	ASORT(aProcessa,,,{|x,y|x[1]<y[1]})
EndIf

Pergunte("PCR500",.F.)

nTotRecs  := Len( aProcessa )

oReport:SetMeter( nTotRecs )

If nTotRecs > 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualiza conteudo das celulas com o valor que deve ser impresso a partir do array aProcessa ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nX := 1 To nSections
	
	    If nX == nSections                      
	    	oValores1 := aSections[nX]:Section(1)
	    	oValores2 := aSections[nX]:Section(2)    	
	    Else
	    	oValores1 := aSections[nX]:Section(2)
	    	oValores2 := aSections[nX]:Section(3)    	
	    EndIf
	    
		aSections[nX]:Cell(aNiveis[nX,2]):SetSize( 25, .F. )
		aSections[nX]:Cell(aNiveis[nX,3]):SetSize( 50, .F. )
		aSections[nX]:Cell(aNiveis[nX,2]):SetBlock( { || If( nLinImp == 1 .And. lChangeNiv, aNiveis[aProcessa[nLoop,8]], aProcessa[nLoop,9] ) } )
		aSections[nX]:Cell(aNiveis[nX,3]):SetBlock( { || aProcessa[nLoop,6]  } )
	
		   If aSavPar[10] == 2
		    If nX == 1
				oValores1:SetHeaderPage( .T. )
				oValores2:SetHeaderPage( .T. )
			Else
				oValores1:SetHeaderPage( .F. )
				oValores2:SetHeaderPage( .F. )
				oValores1:SetHeaderSection( .F. )
				oValores2:SetHeaderSection( .F. )
			EndIf
		Else
			oValores1:SetHeaderPage( .F. )
			oValores2:SetHeaderPage( .F. )
		EndIf	
	
		oValores1:Cell( "SALDO_ANT_A1"    ):SetBlock( { || aProcessa[nLoop,2,1] } )
		oValores1:Cell( "SALDO_ANT_A2"    ):SetBlock( { || If(nPosComp>0, aProcComp[nPosComp][2][1], 0) } )
		oValores1:Cell( "DIF_VALOR_A1_A2" ):SetBlock( { || If(nPosComp>0, aProcessa[nLoop][2][1]-aProcComp[nPosComp][2][1],0) } )
		oValores1:Cell( "DIF_PERC_A2_A1"  ):SetBlock( { || If(nPosComp>0 , aProcComp[nPosComp][2][1]/aProcessa[nLoop][2][1]*100, 0) } )
		oValores1:Cell( "MOV_CREDITO_C1"  ):SetBlock( { || aProcessa[nLoop][2][2] } )
		oValores1:Cell( "MOV_CREDITO_C2"  ):SetBlock( { || If(nPosComp>0 , aProcComp[nPosComp][2][2], 0) } )
		oValores1:Cell( "DIF_VALOR_C1_C2" ):SetBlock( { || If(nPosComp>0, aProcessa[nLoop][2][2]-aProcComp[nPosComp][2][2], 0) } )
		oValores1:Cell( "DIF_PERC_C2_C1"  ):SetBlock( { || If(nPosComp>0, aProcComp[nPosComp][2][2]/aProcessa[nLoop][2][2]*100, 0) } )
	
		oValores2:Cell( "MOV_DEBITO_D1"   ):SetBlock( { || aProcessa[nLoop][2][3] } )
		oValores2:Cell( "MOV_DEBITO_D2"   ):SetBlock( { || If(nPosComp>0, aProcComp[nPosComp][2][3], 0) } )
		oValores2:Cell( "DIF_VALOR_D1_D2" ):SetBlock( { || If(nPosComp>0, aProcessa[nLoop][2][3]-aProcComp[nPosComp][2][3], 0) } )
		oValores2:Cell( "DIF_PERC_D2_D1"  ):SetBlock( { || If(nPosComp>0, aProcComp[nPosComp][2][3]/aProcessa[nLoop][2][3]*100, 0) } )
		oValores2:Cell( "SALDO_FINAL_F1"  ):SetBlock( { || aProcessa[nLoop][2][4] } ) 
		oValores2:Cell( "SALDO_FINAL_F2"  ):SetBlock( { || If(nPosComp>0, aProcComp[nPosComp][2][4], 0) } )
		oValores2:Cell( "DIF_VALOR_F1_F2" ):SetBlock( { || If(nPosComp>0, aProcessa[nLoop][2][4]-aProcComp[nPosComp][2][4], 0) } )
		oValores2:Cell( "DIF_PERC_F2_F1"  ):SetBlock( { || If(nPosComp>0, aProcComp[nPosComp][2][4]/aProcessa[nLoop][2][4]*100, 0) } )
			
		aSections[nX]:SetRelation( { || xFilial( aNiveis[nLoop,1] ) + aProcessa[nLoop,14] }, aNiveis[nLoop,1], 3, .T. )
	
	Next
	
	oReport:Section(2):Cell("DESCRI_COMP1"):SetTitle( STR0020 + aProcessa[nLoop,13]+" (1)" )	// "COMPARATIVO ENTRE A CONFIGURACAO: " 
	
	nPosComp := aScan(aProcComp, { |x| x[1] == aProcessa[nLoop][1] })
	                                                                                                        
	If nPosComp > 0                             
		oReport:Section(2):Cell("DESCRI_COMP2"):SetTitle( STR0021 + aProcComp[nPosComp,13] +" (2)" )	// " E A CONFIGURAÇÃO: "
	Else
		oReport:Section(2):Cell("DESCRI_COMP2"):SetTitle( STR0021 + "(2)" )	// " E A CONFIGURAÇÃO: "
	EndIf
	
	Do While !oReport:Cancel() .And. nLoop <= nTotRecs
	                                         
		If oReport:Cancel()
			Exit
		EndIf
	
		oReport:IncMeter()
		
		nNivAtu	:= aProcessa[nLoop,8]
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicia a impressao da secao de valores para o nivel atual do cubo         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	    If aProcessa[nLoop,8] == nSections
	    	oValores1 := aSections[aProcessa[nLoop,8]]:Section(1)
			oValores2 := aSections[aProcessa[nLoop,8]]:Section(2)
	    Else
	    	oValores1 := aSections[aProcessa[nLoop,8]]:Section(2)
	    	oValores2 := aSections[aProcessa[nLoop,8]]:Section(3)
	    EndIf			       
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se existe posicao no array de comparacao, para utilizar na impressao      ³
		//³ das secoes de valores                                                              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPosComp := aScan(aProcComp, { |x| x[1] == aProcessa[nLoop][1] })
	                                                                                                        
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicia impressao da proxima secao, caso a atual for diferente da secao anterior    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lChangeNiv := (nNivAtu <> aProcessa[nLoop,8])
	
		If lChangeNiv
			nTotLin := 2	// Duas linhas para troca de nivel, sendo na 1a. nome do nivel e na 2a o detalhe
		Else
			nTotLin := 1	// Uma linha com o detalhe do nivel
		EndIf
	
	 	aSections[aProcessa[nLoop,8]]:Init()
		oValores1:Init()
		oValores2:Init()
	
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime o nome do nivel da chave do cubo na 1a. linha e o detalhe da chave na 2a.  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	 	For nLinImp := 1 To nTotLin
	 
	 		If nLinImp == 1 .And. lChangeNiv
	 			aSections[ nNivAtu ]:Cell( aNiveis[ nNivAtu, 3 ] ):Hide()
	 			aSections[ nNivAtu ]:PrintLine()
	 		Else
	 			aSections[ nNivAtu ]:Cell( aNiveis[ nNivAtu, 3 ] ):Show()
				aSections[ nNivAtu ]:PrintLine()
				oReport:ThinLine()
				oValores1:PrintLine()
				oValores2:PrintLine()
	 		EndIf
	
	 	Next nLinImp
	
		oValores1:Finish()
		oValores2:Finish()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Finaliza impressao da secao atual   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aSections[nNivAtu]:Finish()
	
		nLoop ++
		
	EndDo
	
	aSections[ nNivAtu ]:Finish()
	
EndIf

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Pcor500Sld³ Autor ³ Edson Maricate        ³ Data ³07-01-2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao de impressao da planilha orcamentaria.               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Pcor500Sld                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd - Variavel para cancelamento da impressao pelo usuario³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Pcor500Sld(cConfig,cChave)
Local aRetIni,aRetFim
Local nCrdIni
Local nDebIni
Local nCrdFim
Local nDebFim

aRetIni := PcoRetSld(cConfig,cChave, aSavPar[2]-1 ) //tem que ser o saldo final do dia anterior para partida
nCrdIni := aRetIni[1, aSavPar[4]]
nDebIni := aRetIni[2, aSavPar[4]]
aRetFim := PcoRetSld(cConfig,cChave,aSavPar[3])
nCrdFim := aRetFim[1, aSavPar[4]]
nDebFim := aRetFim[2, aSavPar[4]]

nSldIni := nCrdIni-nDebIni
nSldFim := nCrdFim-nDebFim
nMovCrd := nCrdFim-nCrdIni
nMovDeb := nDebFim-nDebIni


Return {nSldIni,nMovCrd,nMovDeb,nSldFim}
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
Local oStructCube, lZerado, lSintetica, lTotaliza
Local lMovimento 	:= .F.

nQtdVal     := 2

aAdd(aDtSaldo, aProcCube[1,1]-1 )  //tem que ser o saldo final do dia anterior
aAdd(aDtSaldo, aProcCube[1,2] )

oStructCube := aProcCube[2]
lZerado 	:= aProcCube[4]
lSintetica 	:= aProcCube[5]
lTotaliza 	:= .F.
cWhereTpSld := aProcCube[6]
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

aQuery := PcoCriaQry( cCodCube, nNivel, nMoeda, cArqAS400, nQtdVal, aDtSaldo, aQryDim, cWhere, cWhereTpSld, oStructCube:nNivTpSld, lMovimento, aDtIni, .T./*lAllNiveis*/, aCposNiv, lDebito, lCredito )

PcoPopulaTemp(oStructCube, cArquivo, aQuery, nQtdVal, lZerado, cArqAS400, lDebito, lCredito )

dbSelectArea(cArquivo)
dbCloseArea()

CarregaProcessa(aProcCub, oStructCube, cArquivo, nQtdVal)

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


Static Function CarregaProcessa(aProcCub, oStructCube, cArquivo, nQtdVal)
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
			cDescrAux := STR0028 //"Outros (Nao Especificado)"
			lAuxSint := .F.		
		EndIf	
		
		aValor := {}
		For nY := 2 TO nQtdVal
            
			nSldIni := (cArquivo)->( FieldGet(FieldPos("AKT_CRD"+StrZero(1,3))) - FieldGet(FieldPos("AKT_DEB"+StrZero(1,3)))  ) // nCrdIni-nDebIni
			nMovCrd := (cArquivo)->( FieldGet(FieldPos("AKT_CRD"+StrZero(nY,3)))   - FieldGet(FieldPos("AKT_CRD"+StrZero(1,3))) )  // nCrdFim-nCrdIni	
			nMovDeb := (cArquivo)->( FieldGet(FieldPos("AKT_DEB"+StrZero(nY,3)))   - FieldGet(FieldPos("AKT_DEB"+StrZero(1,3))) ) // nDebFim-nDebIni
			nMovPer :=  nMovCrd-nMovDeb

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
							PadR(cChave, nTamNiv),;
							( nNivel  == oStructCube:nMaxNiveis ) })
	
		dbSelectArea(cArquivo)
		(cArquivo)->(dbSkip())
	
	EndDo	
	
	dbSelectArea(cArquivo)
	dbCloseArea()

Next // nX

ASORT(aProcCub,,,{|x,y|x[1]<y[1]})

Return