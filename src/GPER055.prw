/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.CH"
#INCLUDE "GPER055.CH"

Static aTab_Fol	:= If( Type("aTab_Fol") == "A", aTab_Fol, {} )//Array com as Tabelas da Folha
Static aInssEmp	:= If( Type("aInssEmp") == "A", aInssEmp, {} )//Array com os dados da tabela S037

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER055  ³ Autor ³ Ricardo Duarte Costa     ³    Data  ³  24/03/05   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±          
±±³Descri‡„o ³ Darf do PIS                                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data       ³ BOPS      ³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Carlos E. O.³13/11/2013  ³M12RH01  	³ Inclusao do relatorio na P12. Retirada de ³±±
±±³            ³            ³RQ0325     ³ funcao de ajuste do dicionario, alteracao ³±±
±±³            ³            ³           ³ na funcao fBuscaTomador para usar tabela  ³±±
±±³            ³            ³           ³ CTT e nao mais SI3.                       ³±±
±±³Flavio Correa³07/05/14	³TPKHR3     ³Replica V11  Desoneração  				  . ³±±
±±³M. Silveira ³07/08/2015  ³TSVXE6  	³Incluido tratamento p/ o filtro da SetPrint³±±
±±³Christiane V³05/11/2015  ³TTRODQ  	³Inclusão da função fGeraFolSRZ() para gerar³±±
±±³            ³            ³        	³resumo da folha como é feito na P11.       ³±±
±±³Gustavo M.  ³30/05/2016  ³TVFFAD  	³Ajuste para considerar o controle de acesso³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function gper055()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1 := STR0001					//	"DARF de Recolhimento do PIS s/Folha"
Local cDesc2 := STR0002	//"Ser  impresso de acordo com os parametros solicitados pelo usuario."
Local cDesc3 := STR0003	//"Obs. Deve ser impresso um Darf por Filial ou entao Centralizado"
Local cString:= "SRZ"					// Alias do Arquivo Principal (Base)
Local aOrd   := {}    					// Ordem
Local cMsgYesNo		:= ""
Local cTitLog		:= ""
                        
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn := {STR0004,1,STR0005, 1, 2, 1, "",1 }		//"Zebrado"###"Administra‡„o"
Private nomeprog:= "GPER055"
Private aLinha  := {}
Private aRegs	:= {}
Private nLastKey:= 0
Private cPerg   := "GP055R"
Private m_pag   := 1
Private nTamanho:= "P"
Private nColunas:= 080
Private nTpImpre:= 0
Private cFiltro := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aCRA   := {STR0006,STR0007,STR0008}		//"Confirma"###"Repete"###"Abandona"
Private Titulo := STR0009						//"EMISSŽO DARF RECOLHIMENTO PIS S/FOLHA"
Private aFolIR[4]  , aAdiIR[4]  , aFerIR[4]  , a13IR[4]
Private aInfoObs	:= {} 
Private aInfo     	:= {}
Private aPerAberto 	:= {}
Private aPerFechado	:= {}

Begin Sequence
	
	pergunte("GPR055",.F.)
	
	If fRadioPerg(@nTpImpre) == 1
		Titulo := STR0009						//"EMISSŽO DARF RECOLHIMENTO PIS S/FOLHA"
		pergunte("GP055R",.F.)
	ElseIf nTpImpre == 2
		Titulo := STR0015						//"EMISSAO DARF RECOLHIMENTO CONTRIBUICAO PREVIDENCIARIA"	
	Else
		Break
	EndIf
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                         ³
	//³ mv_par01        //  Filial  De                               ³
	//³ mv_par02        //  Filial  Ate                              ³
	//³ mv_par03        //  Centralizado ( S/N )                     ³
	//³ mv_par04        //  Mes e Ano da Competencia                 ³
	//³ mv_par05        //  Folha/Ferias,13o.Salario                 ³
	//³ mv_par06        //  TP de Contrato                           ³
	//³ mv_par07        //  Codigo de Recolhimento                   ³
	//³ mv_par08        //  Data de Vencimento                       ³
	//³ mv_par09        //  Numero de Referencia                     ³
	//³ mv_par10        //  Imprime por CC                           ³
	//³ mv_par11        //  Centro de Custo De                       ³
	//³ mv_par12        //  Centro de Custo Ate                      ³ 
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Envia controle para a funcao SETPRINT                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	wnrel:="GPER055"            //Nome Default do relatorio em Disco
	wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F., ,.T.,nTamanho )
	
	If	nLastKey == 27
		Return
	Endif
	
	// SetDefault(aReturn,cString)
	
	If	nLastKey == 27
		Return
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cFilIni       := mv_par01
	cFilFim       := mv_par02
	cCentra       := mv_par03
	cMesAnoGuia   := mv_par04
	cTipo         := mv_par05
	cTipoSRZ      := If(mv_par05==1,"FL","13")
	cTpContr      := mv_par06
	cOldRet       := PadR(mv_par07,4)
	dVencto		  := mv_par08
	cNumRef		  := mv_par09
	nQuebraCC     := mv_par10
	cCCFrom		  := If(empty(mv_par11),"0", mv_par11) 
	cCCTo 		  := mv_par12
	 
	if empty(cTpContr)
		Help( "" , 1 , OemToAnsi(STR0019), NIL , OemToAnsi( STR0018 ) , 1 , 0 )//"Tipo de Contrato não preenchido, informe pelo menos um."
		return 
	EndIf

	If nTpImpre = 1 .And. cTipoSRZ = "13" 
		cMsgYesNo	:= OemToAnsi(;
										STR0020 + ;	//"Os valores de PIS Empresa ref. a 13º Salário são contemplados na Folha de Pagamento."
										CRLF	+ ;
										STR0021	  ;	//"Tem certeza que deseja seguir com a geração?"
									 )
		cTitLog		:= OemToAnsi( STR0022 )	//"DARF PIS sobre 13º Salário"
		IF !( MsgYesNo( OemToAnsi( cMsgYesNo ) ,  OemToAnsi( cTitLog ) ) )
			Return 
		EndIf
	EndIf

	// caso nao entre no parametro 
	If(Empty(cMesAnoGuia),cMesAnoGuia := Substr(Dtoc(mv_par08),4,2)+Substr(Dtos(mv_par08),1,4), cMesAnoGuia)
	
	//CARREGAR OS PERIODOS ABERTOS (APERABERTO) E/OU OS PERIODOS FECHADOS (APERFECHADO), DE ACORDO COM UMA DETERMINADA COMPETENCIA
	fRetPerComp( SubStr( mv_par04, 1, 2 ), SubStr( mv_par04, 3, 4 ), Nil, Nil, Nil, @aPerAberto, @aPerFechado)	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis para impressao do DARF                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nTipImp		  := 3	// Variavel para impressao do DARF
	dDataAte	  := ctod( "01/" + SubStr(cMesAnoGuia,1,2)+"/"+SubStr(cMesAnoGuia,3,4), "DDMMYY" )
	dDataAte	  := stod(right(cMesAnoGuia,4)+left(cMesAnoGuia,2)+strzero(f_UltDia(dDataAte),2))
	cFiltro		  := aReturn[7]
	Afill(aFolIR,0)
	Afill(aAdiIR,0)
	Afill(aFerIR,0)
	Afill(a13IR,0)
	
	RptStatus({|lEnd| U_GPM055Proc()},Titulo) //"Emissao do DARF de Recolhimento do PIS s/Folha"
	
End Sequence

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPM055PROCºAutor  ³Ricardo Duarte Costaº Data ³  28/03/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao do Darf do PIS s/folha de pagamento.              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GPM055PROC()

Local aArea			:= {}
Local aAreaSM0		:= SM0->(getarea())
Local aAreaSRZ		:= SRZ->(getarea())
Local aCodFol		:= {}
Local aFilProc		:= {}
Local aTabS033		:= {}
Local aTamCC		:= TamSx3("RZ_CC")
Local aTpc			:= {}
Local cAcessaSRZ	:= &("{ || " + ChkRH("GPER055","SRZ","2") + "}")
Local cAliasFat		:= ""
Local cCCFim		:= Replicate("z",aTamCC[1])
Local cCodEmp		:= SM0->M0_CODIGO
Local cFilCTT		:= ""
Local cRecFatEmp	:= ""
Local cSvFilAnt		:= ""
Local cTab			:= "S033"
Local cTipFat		:= ""
Local cWhereCTT		:= ""
Local cMsg			:= ""
Local dDataRef		:= cToD("//")
Local nCont			:= 0
Local nFatDes		:= 0
Local nFatFol		:= 0
Local nFatTot		:= 0
Local nFilial		:= 0
Local nProp			:= 0
Local nStart		:= 0
Local nTpc			:= 0
Local nx			:= 0
Local nEmpFatTot	:= 0
Local nEmpFatDes	:= 0
Local nEmpFatFol	:= 0
Local lGeraDarf		:= .T.
Local lRecDesTot	:= .F.
Local lFiltro		:= .F.
Local lDicInter		:= FindFunction("fChkInterm") .And. fChkInterm()
Local cRzMat		:= Replicate("z",TamSx3("RA_MAT")[1])
Local lImpDarf	 := ExistBlock( "IMPDARF",.F.,.T. )//variavel p/ PE "IMPDARF"
Private cAnoMes		:= ""
Private cAliasCTT	:= "CTT"
Private lCarrega	:= .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ //Objetos p/ Impresssao Grafica 							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private oFont07, oFont08, oFont10, oFont10n,oFont11,oFont13n, oFont15, oFont21n
Private oPrint

Private cCEI 		:= Space(14) 
Private cCCusto 	:= ""
Private cDescCEI	:= "" 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para geracao do SRZ via procedure     	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lFolPgto    := ( cTipo == 1 )
lFol13Sl    := ( cTipo == 2 ) 

oFont07	:= TFont():New("Arial",07,07,,.F.,,,,.T.,.F.)
oFont08	:= TFont():New("Arial",09,09,,.F.,,,,.T.,.F.)  
oFont10	:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFont10n:= TFont():New("Arial",10,10,,.T.,,,,.T.,.F.)		//negrito
oFont11	:= TFont():New("Courier New",10,10,,.F.,,,,.T.,.F.)
oFont15n:= TFont():New("Arial",15,15,,.T.,,,,.T.,.F.)		//negrito
oFont21n:= TFont():New("Arial",21,21,,.T.,,,,.T.,.F.)		//negrito
oPrint 	:= TMSPrinter():New("DARF - Guia de Recolhimento DARF")
oPrint:SetPortrait() 

lFiltro := !Empty(cFiltro)

If nTpImpre == 1 //DARF do PIS sobre Folha

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Prepara array de tipos de contratos para o resumo da folha.	 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lDicInter
		cTpContr	:= Replace(cTpContr, "*", "")
	EndIf
	
	For nx := 1 to Len(alltrim(cTpContr))
		aAdd(aTpc,val(substr(alltrim(cTpContr),nx,1)))
	next nx
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se deve gerar o arquivo SRZ com o resumo da folha.	 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !fGeraFolSRZ(cTipo,aTpc,cMesAnoGuia, aPerAberto, aPerFechado)
		Return
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta o array das filiais a processar com o codigo das verbas³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SM0")
	dbSeek(cCodEmp,.T.) 
	While !eof() .And. cCodEmp == SM0->M0_CODIGO
		If FWGETCODFILIAL >= cFilIni .And. FWGETCODFILIAL <= cFilFim .And. FWGETCODFILIAL $ fValidFil()
			If Fp_Codfol(@aCodFol, FWGETCODFILIAL) 
				If !Empty(aCodFol[223,1]) .And. !Empty(aCodFol[229,1]) 
					aAdd(aFilProc,{FWGETCODFILIAL, aCodFol[223,1],0.00,aCodFol[229,1],0.00,"" ,"",""})
				Endif 
			Endif
		Endif 
		SM0->(dbskip())
	Enddo 
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Retorna a area do arquivo de empresas. SIGAMAT.EMP           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	RestArea(aAreaSM0)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Pesquisa os valores de Pis no resumo da folha.               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SRZ")
	dbSetOrder(2)
	For nx := 1 to Len(aFilProc)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Salva o valor da base do pis.                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cCentra) .or. (Empty(cCentra) .and. nQuebraCC == 2)
			If Dbseek(aFilProc[nx,1]+aFilProc[nx,2])		
				While !eof() .And. aFilProc[nx,1]+aFilProc[nx,2]== SRZ->RZ_FILIAL+SRZ->RZ_PD
					If SRZ->RZ_TPC$cTpContr .And. SRZ->RZ_TIPO == cTipoSRZ .And. SRZ->RZ_MAT == cRzMat .and.;  
					   SRZ->RZ_CC>= cCcFrom .and. SRZ->RZ_CC<= cCCTo  .and. SRZ->RZ_CC <> cCCFim .And. If(lFiltro, SRZ->(&(cFiltro)), .T. )
						aFilProc[nx,3]	+= SRZ->RZ_VAL
					Endif
				SRZ->( DbSkip() )
				EndDo
			EndIf 
			If Dbseek(aFilProc[nx,1]+aFilProc[nx,4])
				While !eof() .And. aFilProc[nx,1]+aFilProc[nx,4]== SRZ->RZ_FILIAL+SRZ->RZ_PD 
					If SRZ->RZ_TPC$cTpContr .And. SRZ->RZ_TIPO == cTipoSRZ .And. SRZ->RZ_MAT == cRzMat .and.;  
					   SRZ->RZ_CC>= cCcFrom .and. SRZ->RZ_CC<= cCCTo  .and. SRZ->RZ_CC <> cCCFim .And. If(lFiltro, SRZ->(&(cFiltro)), .T. )
						aFilProc[nx,5] += SRZ->RZ_VAL
					Endif
					SRZ->(dbSkip()) 
				Enddo		
			Endif		
		ElseIf  nQuebraCC == 1     												// Se quebra por Centro de Custo 
			If Dbseek(aFilProc[nx,1]+aFilProc[nx,2])		
				While !eof() .And. aFilProc[nx,1]+aFilProc[nx,2]== SRZ->RZ_FILIAL+SRZ->RZ_PD 
					If SRZ->RZ_TPC$cTpContr .And. SRZ->RZ_TIPO == cTipoSRZ .and. SRZ->RZ_MAT == cRzMat .and.;  
					   SRZ->RZ_CC>= cCcFrom .and. SRZ->RZ_CC<= cCCTo  .and. SRZ->RZ_CC<> cCCFim .And. If(lFiltro, SRZ->(&(cFiltro)), .T. )
	  					fBuscaTomador( ) 
						If !Empty(cCEI ) .and. (nPos:= Ascan(aFilProc, {|x| x[1]+x[2]+ x[7] == SRZ->RZ_FILIAL+SRZ->RZ_PD + cCEI  } ) ) > 0 
							aFilProc[nPos,3]	+= SRZ->RZ_VAL  
						ElseIf (nPos:= Ascan(aFilProc, {|x| x[1]+ x[2]+ x[6] == SRZ->RZ_FILIAL + SRZ->RZ_PD + SRZ->RZ_CC + " "+ cCCusto   } ) ) > 0 
							aFilProc[nPos,3]	+= SRZ->RZ_VAL  
						Else 						
							aAdd(aFilProc,{SRZ->RZ_FILIAL, aCodFol[223,1],SRZ->RZ_VAL,aCodFol[229,1],0.00,SRZ->RZ_CC + " "+ cCCusto ,cCEI , cDescCEI })
						Endif 	
					Endif
					SRZ->(dbSkip()) 
				Enddo
			Endif 
			If Dbseek(aFilProc[nx,1]+aFilProc[nx,4])
				While !eof() .And. aFilProc[nx,1]+aFilProc[nx,4]== SRZ->RZ_FILIAL+SRZ->RZ_PD 
					If SRZ->RZ_TPC$cTpContr .And. SRZ->RZ_TIPO == cTipoSRZ .and. SRZ->RZ_MAT == cRzMat .and.;  
					   SRZ->RZ_CC>= cCcFrom .and. SRZ->RZ_CC<= cCCTo .and. SRZ->RZ_CC<> cCCFim .And. If(lFiltro, SRZ->(&(cFiltro)), .T. )
						fBuscaTomador( ) 
						If !Empty(cCEI ) .and. (nPos:= Ascan(aFilProc, {|x| x[1]+x[4]+ x[7] == SRZ->RZ_FILIAL+SRZ->RZ_PD + cCEI  } ) ) > 0 
							aFilProc[nPos,5]	+= SRZ->RZ_VAL  
						ElseIf (nPos:= Ascan(aFilProc, {|x| x[1]+x[4]+ x[6] == SRZ->RZ_FILIAL + SRZ->RZ_PD + SRZ->RZ_CC + " "+ cCCusto   } ) ) > 0 
							aFilProc[nPos,5]	+= SRZ->RZ_VAL  
						Else 						
							aAdd(aFilProc,{SRZ->RZ_FILIAL, aCodFol[223,1] ,0.00,aCodFol[229,1],SRZ->RZ_VAL,SRZ->RZ_CC + " "+ cCCusto ,cCEI , cDescCEI })	
						Endif 	
					Endif 	
					SRZ->(dbSkip()) 
				Enddo		
			Endif	
		Endif 
	Next nx
	
ElseIf nTpImpre == 2 //DARF de contribuicao previdenciaria

    If nQuebraCC == 1
		Help("", 1, "GPR055VERFAT") //Não é permitido a geração da DARF de Contribuição Previdenciária com quebra por Centro de Custo. 
		Return Nil
    EndIf

	//Monta o array das filiais a processar.
	dbSelectArea("SM0")
	dbSeek( cCodEmp, .T. )
	While !EoF() .And. cCodEmp == SM0->M0_CODIGO
		If FWGETCODFILIAL >= cFilIni .And. FWGETCODFILIAL <= cFilFim .And. FWGETCODFILIAL $ fValidFil()
			aAdd( aFilProc, {FWGETCODFILIAL, " ", 0.00, " ", 0.00} )
		Endif
		SM0->( dbskip() )
	EndDo
    
	//Retorna a area do arquivo de empresas. SIGAMAT.EMP
	RestArea(aAreaSM0)

    //Monta variavel cAnoMes p/ busca do fInssEmp
    cAnoMes  := SubStr( cMesAnoGuia, 3, 4 )+SubStr( cMesAnoGuia, 1, 2 )
	//Monta variavel dDataRef p/ busca do fCarrTab
	dDataRef := cToD( "01/" + SubStr( cMesAnoGuia, 1, 2 ) + "/" + SubStr( cMesAnoGuia, 3, 4 ) )                    
	//Chama fCarrTab para carregar tabela auxiliar S033
	fCarrTab( @aTabS033, "S033", dDataRef )

	//Apura a receita bruta total da empresa
	aEval(aTabS033, {|aTabS033| nEmpFatTot += aTabS033[7] } )
	//Apura a receita bruta que nao e' sobre as atividades desoneradas
	aEval(aTabS033, {|aTabS033| If( aTabS033[6] == "2", nEmpFatFol += aTabS033[7], ) } )	
	//Apura a receita bruta que e' sobre as atividades desoneradas
	aEval(aTabS033, {|aTabS033| If( aTabS033[6] == "1", nEmpFatDes += aTabS033[7], ) } )
    //Verifica se a receita desonerada da empresa e' superior a 95% do total
	lRecDesTot := ( nEmpFatDes / nEmpFatTot >= 0.95 )
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Somente havera recolhimento sobre o Faturamento se o total nao³
	³desonerado da empresa for MENOR que 95% do total geral        ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If lGeraDarf := ( nEmpFatFol / nEmpFatTot ) < 0.95
    
		For nFilial := 1 to Len(aFilProc)	
			aArea	 	:= GetArea()
			
			//Busca na tabela S037 se a empresa recolhe contribuicao previdenciaria sobre a receita bruta (X14_RECFAT)
			fInssEmp(aFilProc[nFilial, 1], @aInssEmp, Nil, cAnoMes)			
			
			//Contrato indeterminado
			If lDicInter
				If "1" $ cTpContr .Or. "3" $ cTpContr
					cRecFatEmp 	:= aInssEmp[27, 1]
				//Contrato determinado
				ElseIf  "2" $ cTpContr 
					cRecFatEmp 	:= aInssEmp[27, 2]
				//Ambos
				ElseIf cTpContr == "123"		
					For nTpc := 1 To Len( aInssEmp[27] )
						cRecFatEmp	:= aInssEmp[27, nTpc] //
					If cRecFatEmp $ "S*M*C"
							Exit
						EndIf
					Next nTpc				
				//Nenhum
				Else
					cRecFatEmp 	:= "N"
				EndIf
			Else
				If cTpContr == "1*"
					cRecFatEmp 	:= aInssEmp[27, 1]
				//Contrato determinado
				ElseIf cTpContr == "*2"
					cRecFatEmp 	:= aInssEmp[27, 2]
				//Ambos
				ElseIf cTpContr == "12"		
					For nTpc := 1 To Len( aInssEmp[27] )
						cRecFatEmp	:= aInssEmp[27, nTpc] //
					If cRecFatEmp $ "S*M*C"
							Exit
						EndIf
					Next nTpc				
				//Nenhum
				Else
					cRecFatEmp 	:= "N"
				EndIf
			EndIf
			
			If cRecFatEmp == "M" .And. !lGeraDarf
				Exit
			EndIf
	        //Se a empresa recolhe contribuicao previdenciaria sobre a receita bruta
	        If cRecFatEmp $ "S*M*C"
				If cRecFatEmp != "S" .And. lRecDesTot
					nFatFol := 0
					//Apura a receita bruta que nao e' sobre as atividades beneficiadas da Lei no. 12.546/2011
					aEval(aTabS033, {|aTabS033| If( aTabS033[2] == aFilProc[nFilial, 1] .And. aTabS033[6] == "2", nFatFol += aTabS033[7], ) } )
					//Se a receita bruta da atividade desonerada for maior do que 95% do total devera ser 
					//considerado a receita bruta da atividade nao desonerada.Sera aplicado a proporcionalidade
					//das aliquotas das atividades desoneradas conforme correspondencia do percentual da receita 
					//desonerada em relacao ao total desonerado
					//Ex: Cod de atividade X possui receita bruta de 45.000 com aliquota de 1%. A receita bruta
					//    total de atividade desonerada e' igual a 98.000 e ha 2.000 de atividade nao desonerada.
					//	  Sera feito a regra de 3 para saber quanto da receita bruta da atividade corresponde
					//    ao total desonerado. Percentual = 45.000 * 100 / 98.000 = 45,91%. O percentual sera
					//    aplicado sobre os 2.000 da receita nao desonerada. Sobre o valorencontrado sera 
					//	  aplicado a aliquota correspondente ao codigo da atividade. Esse valor sera somado ao
					//    que a empresa ja recolhe de contribuicao sobre a atividade desonerada.
					For nCont := 1 To Len(aTabS033)
						If aTabS033[nCont, 6] == "1"
							nProp := ( aTabS033[nCont, 7] * 100 / nEmpFatDes ) / 100
							aFilProc[nFilial, 5] += ( nProp * nFatFol ) * ( aTabS033[nCont, 8] / 100 )
						EndIf
					Next nCont				
				EndIf
	
				//Verifica os registros da filial em processamento e guarda o valor da contribuicao calculada
				aEval(aTabS033, {|aTabS033| If( aTabS033[2]  ==  aFilProc[nFilial, 1] .And.  aTabS033[6] == "1", aFilProc[nFilial, 5] += aTabS033[9], ) } )
			EndIf        
		
			RestArea( aArea )
		Next nFilial
	
	EndIf
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do darf do pis/contribuicao previdenciaria.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If (lGeraDarf .Or. cRecFatEmp != "M") .And. !Empty(aFilProc)
	If !Empty(cCentra)	//-- Centralizado
		aEval(aFilProc,{|X| aFolIr[2] += X[5]})
		fInfo(@aInfo,cCentra)
		if lImpDarf
			ExecBlock("IMPDARF",.F.,.F.)
		else
			GPER989()
		endif
	Else 
		For nx := 1 to len(aFilProc)	//-- Por filial 
			If aFilProc[nx,5] > 0
				aFolIr[2]	:= aFilProc[nx,5] 
				If nQuebraCC == 1
					If Empty(aFilProc[nx,07]) 
						cCCusto := aFilProc[nx,06]
						cCEI 	:= ""
		            Else 
						cCEI 	:= aFilProc[nx,07] + " " + aFilProc[nx,08]
						cCCusto := "" 
					Endif 	
				Endif 
				fInfo(@aInfo,aFilProc[nx,1])			
				If Type("aInfo[15]") == "C"
					fInfo(@aInfo,aFilProc[1,1])			
				EndIf
				if lImpDarf
					ExecBlock("IMPDARF",.F.,.F.)
				else
					GPER989()
				endif
			Endif
		Next nx
	Endif
	
	oPrint:Preview() // Visualiza impressao grafica antes de imprimir
ElseIf Empty(aFilProc)
	MsgStop( OemToAnsi("Não há dados para serem impressos"), OemToAnsi(STR0014) )
Else
	cMsg := OemToAnsi(STR0016)  + CRLF + CRLF //"A DARF da Contribuição Previdenciária não será gerada."
	cMsg += OemToAnsi(STR0017)  //"MOTIVO: As receitas de atividades não desoneradas atingiram o limite de 95% do total geral."
	MsgStop( OemToAnsi(cMsg), OemToAnsi(STR0014) )
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retorna o ambiente do arquivo de resumo da folha.            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RestArea(aAreaSRZ)

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ fChkcomp055³ Autor ³ Pedro Eloy	        ³ Data ³ 17.10.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Checa a Competencia										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_fchkcomp055(competencia)									  ³±±
±±³			 ³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ competencia = mes/ano									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function fChkcomp055()
Local cMesAno := &(Alltrim(ReadVar()))
If Empty(cMesAno) .OR. Val(Left(cMesAno,2)) < 1 .OR. Val(Left(cMesAno,2)) > 12
	Help(" ",1,"GPR05504")
	Return (.F.)
Endif
If (Val(cMesAno) > 0 .AND. Val(cMesAno) < 10) .AND. Left(cMesAno,1) # "0"
	Help(" ",1,"GPR05504")
	Return (.F.)
Endif
Return (.T.)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER055   ºAutor  ³Microsiga           º Data ³  02/01/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                              
Static Function  fBuscaTomador() 

Local aArea 	:= GetArea() 
                                  
cCEI 		:= Space(14) 
cCCusto 	:= ""
cDescCEI	:= "" 

If CTT->( dbSeek(XFILIAL("CTT") + SRZ->RZ_CC)) 
	cCCusto := CTT->(CTT_DESC01) 
	If TYPE("CTT->CTT_CEI") # "U" .and. !Empty(CTT->(CTT_CEI) ) .and. ( (TYPE("CTT->CTT_RECFAT") #"U" .and. CTT->CTT_RECFAT <> "S") .or. (TYPE("CTT->CTT_RECFAT") == "U") )
		cCei 		:= If(CTT->CTT_TIPO =="1",  Transform( CTT->CTT_CEI, "@R ##.###.###/####-##"), Transform( CTT->CTT_CEI, "@R ###.###.###-##" ) ) 
		cDescCEI 	:= Left(CTT->CTT_NOME,35) 
	Endif 	
Endif 

RestArea(aArea) 

Return() 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fRadioPerg³ Autor ³ Equipe RH             ³ Data ³06/01/2012³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Monta dialogo para selecao com botoes de radio             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±*/
Static Function fRadioPerg(nOpcRadio)

Local nOpcAux
Local oRadio
Local oDlg
Local oGroup
Local oFont
Local nReg

nOpcAux   := nOpcRadio
nOpcRadio := 0

DEFINE FONT oFont NAME "Arial" SIZE 0,-11 BOLD
DEFINE MSDIALOG oDlg FROM  094,001 TO 245,280 TITLE OemToAnsi(STR0012) PIXEL //"Guia de Recolhimento"

@ 005,005 GROUP oGroup TO 055,135 LABEL OemToAnsi(STR0011) OF oDlg PIXEL	//"Escolha uma opcao:"
oGroup:oFont:=oFont
         
@ 020,010 RADIO oRadio VAR nOpcAux	ITEMS OemToAnsi(STR0013),OemToAnsi(STR0014)	;	//"DARF do PIS s/ Folha"
									SIZE 115,010 OF oDlg PIXEL	//""DARF de Contribuicao Previdenciaria"

DEFINE SBUTTON FROM 60, 070 TYPE 1 ENABLE OF oDlg ACTION ( nOpcRadio := nOpcAux, oDlg:End() )
DEFINE SBUTTON FROM 60, 105 TYPE 2 ENABLE OF oDlg ACTION ( nOpcRadio := -1,      oDlg:End() )

ACTIVATE MSDIALOG oDlg CENTERED

Return( nOpcRadio )
