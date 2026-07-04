/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "FINR840.CH"
#Include "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FINR840  ³ Autor ³ J£lio Wittwer         ³ Data ³ 11.02.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Resumo Financeiro Sint‚tico                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FINR840(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Gen‚rico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Julio Witt. ³02.08.99³META  ³Interpretar MV_CRNEG e MV_CPNEG           ³±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FINR840()

Local oReport
Local aArea		 := GetArea()  

If TRepInUse()
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	Return U_Finr840R3() // Executa versão anterior do fonte
Endif

RestArea(aArea)  

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Marcio Menon		   º Data ³  21/08/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas.                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPC1 - Grupo de perguntas do relatorio                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ 												                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport
Local oSection1        
Local oSection2
/*
GESTAO - inicio */
Local oSecFil	:= Nil
/* GESTAO - fim
*/
Local cReport 	:= "FINR840" 				// Nome do relatorio
Local cDescri 	:= STR0001 +;				//"Emiss„o do Relat¢rio Resumo Financeiro Sint‚tico. Ser  usado a"
						" "+STR0002				//"a data-base do sistema como ponto de partida."
Local cTitulo 	:= STR0005					//"Resumo Financeiro Sintetico"
Local cPerg		:= "FIR840"					// Nome do grupo de perguntas
                   
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
oReport := TReport():New(cReport, cTitulo, cPerg, {|oReport| ReportPrint(oReport, cTitulo)}, cDescri) 

oReport:SetPortrait()	//Imprime o relatorio no formato retrato
/*
GESTAO - inicio */
oReport:SetUseGC(.F.)
/* GESTAO - fim
*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                                                                        ³
//³                      Definicao das Secoes                              ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 01                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New(oReport,STR0029, "SE5")

TRCell():New(oSection1, "TXTPER"    , "" , "TXTPERIODO" , , 15 ,/*lPixel*/,{ || STR0014 + Replicate(".",7) })	//"PERIODO"
TRCell():New(oSection1, "DATAPER"   , "" , "DATAPER" 		, , 25 ,/*lPixel*/,/*CodeBlock*/)
TRCell():New(oSection1, "TIPOPER"   , "" , "TIPOPER"		, , 19 ,/*lPixel*/,/*CodeBlock*/)

oSection1:Cell("TXTPER" ):SetTitle("")
oSection1:Cell("DATAPER"):SetTitle("")
oSection1:Cell("TIPOPER"):SetTitle("")	
oSection1:Cell("TIPOPER"):SetAlign("CENTER")	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 02                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New(oSection1,STR0030, "")

TRCell():New(oSection2, "TXTRECPAG" , "" , "TXTRECPAG" , , 15 ,/*lPixel*/,/*CodeBlock*/)
TRCell():New(oSection2, "EMABERTO"  , "" , STR0026 	  , , 22 ,/*lPixel*/,/*CodeBlock*/)	//"EM ABERTO"
TRCell():New(oSection2, "REALIZADO" , "" , STR0027		  , , 22 ,/*lPixel*/,/*CodeBlock*/)	//"REALIZADO"

oSection2:Cell("TXTRECPAG"):SetTitle("")
oSection2:SetHeaderSection(.F.)				//Nao imprime o cabecalho da secao
/*
GESTAO - inicio */
/* Relacao das filiais selecionadas para compor o relatorio */
oSecFil := TRSection():New(oReport,"SECFIL",{"SE1","SED"})
TRCell():New(oSecFil,"CODFIL",,STR0031,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)				//"Código"		
TRCell():New(oSecFil,"EMPRESA",,STR0032,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)				//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0033,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)				//"Unidade de negocio"
TRCell():New(oSecFil,"NOMEFIL",,STR0034,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)				//"Filial"
/* GESTAO - fim
*/
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrint ºAutor³ Marcio Menon       º Data ³  21/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime o objeto oReport definido na funcao ReportDef.     º±±                                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ oReport - Objeto TReport do relatorio                      º±±
±±º          ³ cTitulo - Titulo do relatorio										  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport, cTitulo)

Local oSection1 := oReport:Section(1) 
Local oSection2 := oReport:Section(1):Section(1)
Local lImpPag	 := .F.		//Flag para a impressao dos valores "RECEBER/PAGAR"
Local lImpCab   := .F. 		//Flag para a impressao do cabecalho "EM ABERTO/REALIZADO"

Local nMoeda
Local nSaldoTit	:= 0
Local nBancos		:= 0
Local nCaixas		:= 0
Local nAplicacao 	:= 0
Local nEmprestimo	:= 0
Local lPagina 		:= .T.
Local aSemana 		:= {OemToAnsi(STR0007),OemToAnsi(STR0008),OemToAnsi(STR0009),OemToAnsi(STR0010),;	//"Domingo"###"Segunda"###"Terca  "###"Quarta "
							 OemToAnsi(STR0011),OemToAnsi(STR0012),OemToAnsi(STR0013) }              			//"Quinta "###"Sexta  "###"Sabado " 
Local aBlocos		:= {}
Local nSaldoDoDia	:= 0
Local nAtual		:= 0
Local nTxMoedBc	:= 0
Local dPesqIni,dPesqFin
/*
GESTAO - inicio */
Local aSelFil		:= {}
Local nRegSM0		:= 0 
Local aSM0			:= {}
Local nTamEmp		:= 0
Local nTamUnNeg		:= 0
Local nTamTit		:= 0
Local nX			:= 0
Local nLencFil		:= 0
Local nLenSelFil	:= 0
Local cFilSel		:= ""
Local cTmpFil		:= ""
Local cFil			:= ""
Local aTmpFil		:= {}
Local oSecFil		:= oReport:Section("SECFIL")
Local lExcEmp	:= .F.
Local lExcUnN	:= .F.
Local lExcFil	:= .F.
Local lMovM2    := .F.
Local aSaldoSE8 := {}
/* GESTAO - fim
*/
Local cLstDesc		:= FN022LSTCB(2)	//Lista das situacoes de cobranca (Descontada)

#IFDEF TOP
	Local cQuery	:= 0
	Local cAliasTrb	:= ""
	Local cSepProv  := If("|"$MVPROVIS,"|",",") 
	Local cSepAbat  := If("|"$MVABATIM,"|",",")		/* GESTAO */
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("FIR840",.F.)
/*
GESTAO - inicio */
#IFDEF TOP
	If MV_PAR15 == 1
		nRegSM0 := SM0->(Recno())
		aSelFil := FwSelectGC()
		SM0->(DbGoTo(nRegSM0))
	Endif
	If Empty(aSelFil)
		Aadd(aSelFil,cFilAnt)
	Endif
	Asort(aSelFil)
#ELSE
	aSelFil := {}
#ENDIF
/* GESTAO - fim
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parƒmetros                               ³
//³ mv_par01               Per¡odo (D/S/Q/M). ?                        ³
//³ mv_par02               N£mero de Per¡odos ?                        ³
//³ mv_par03               Do Cliente         ?                        ³
//³ mv_par04               Ate o Cliente      ?                        ³
//³ mv_par05               Do Fornecedor      ?                        ³
//³ mv_par06               Ate o Fornecedor   ?                        ³
//³ mv_par07               Da Natureza        ?                        ³
//³ mv_par08               At‚ a Natureza     ?                        ³
//³ mv_par09               Considera Provisor.?                        ³
//³ mv_par10               Considera Comiss”es?                        ³
//³ mv_par11               Considera Data Base?                        ³
//³ mv_par12               Moeda              ?                        ³
//³ mv_par13					Inicio do Per¡odo  ?								  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicoes da secao 1. 					 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:Cell("DATAPER"):SetBlock( { || If(mv_par01 == 1, (padr(dtoc(aBlocos[nAtual][1])+" / "+aSemana[dow(aBlocos[nAtual][1])],28)),;
														+left(dtoc(aBlocos[nAtual][1]),6)+str(year(aBlocos[nAtual][1]),4)+STR0028+;
														left(dtoc(aBlocos[nAtual][2]),6)+str(year(aBlocos[nAtual][2]),4) ) } )

oSection1:Cell("TIPOPER"):SetBlock( { || If(mv_par01 == 1, str(nAtual,2)+". "+padr(cPeriodo,15),str(nAtual,2)+". "+padr(cPeriodo,20) ) } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicoes da secao 2. 					 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2:Cell("TXTRECPAG"):SetBlock( { || If(lImpCab, "", If(!lImpPag, STR0020+Replicate(".",7), STR0021+Replicate(".",9))) } )		//"RECEBER"###"PAGAR"
oSection2:Cell("EMABERTO" ):SetBlock( { || If(lImpCab, PadC(OemToAnsi(" "+STR0026+" "), 22, "-"), If(!lImpPag, Transform(aBlocos[nAtual][3],"@E 999,999,999,999.99"),; 	//"EM ABERTO"
																			Transform(aBlocos[nAtual][5],"@E 999,999,999,999.99"))) } )
oSection2:Cell("REALIZADO"):SetBlock( { || If(lImpCab, PadC(OemToAnsi(" "+STR0027+" "), 22, "-"), If(!lImpPag, Transform(aBlocos[nAtual][4],"@E 999,999,999,999.99"),; 	//"REALIZADO"
																			Transform(aBlocos[nAtual][6],"@E 999,999,999,999.99"))) } )

//Altera o titulo do relatorio
nMoeda  := mv_par12
cTitulo += " - " + GetMv("MV_MOEDA"+Str(nMoeda,1))
oReport:SetTitle(cTitulo)

aBlocos  :=U_CriaBlocos(mv_par01,mv_par02,mv_par13)
dPesqIni := aBlocos[1][1]
dPesqFin := aBlocos[len(aBlocos)][2]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³VerIfica se foi utilizada taxa contratada para moeda > 1          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTxMoedBc := SE5->E5_TXMOEDA	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se existe aplica‡„o a ser resgatada no dia           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*
GESTAO - inicio */
#IFDEF TOP
	cQuery := "select EG_VALOR,EG_TIPO from " + RetSQLName("SEG")
	cQuery += " where EG_FILIAL " + GetRngFil(aSelFil,"SEG",.T.,@cTmpFil)
	Aadd(aTmpFil,cTmpFil)
	cQuery += " and EG_DATARES >= '" + Dtos(dDataBase) + "'"
	cQuery += " and EG_DATARES <= '" + Dtos(dPesqFin) + "'"
	cQuery += " and D_E_L_E_T_ = ' '"
	cQuery += " order by EG_DATARES"
	cQuery := ChangeQuery(cQuery)
	cAliasTrb := GetNextAlias()
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTrb,.F.,.T.)
	While !((cAliasTrb)->(Eof()))
		If (cAliasTrb)->EG_TIPO == "EMP"
			nEmprestimo += xMoeda((cAliasTrb)->EG_VALOR,1,mv_par12,,,nTxMoedBc)
		Else
			nAplicacao  += xMoeda((cAliasTrb)->EG_VALOR,1,mv_par12,,,nTxMoedBc)
		EndIf
		(cAliasTrb)->(dbSkip())
	Enddo
	DbSelectArea(cAliasTrb)
	DbCloseArea()
#ELSE
	dbSelectArea("SEG")
	dbSetOrder(2)
	dbSeek(cFilial+Dtos(dDataBase),.T.)
	While !Eof() .And. SEG->EG_DATARES<=dPesqFin .and. SEG->EG_FILIAL == xFilial("SEG")
		If SEG->EG_TIPO == "EMP"
			nEmprestimo += xMoeda(SEG->EG_VALOR,1,mv_par12,,,nTxMoedBc)
		Else
			nAplicacao  += xMoeda(SEG->EG_VALOR,1,mv_par12,,,nTxMoedBc)
		EndIf
		SEG->(dbSkip())
	Enddo
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se existe Operacao Financeira a ser resgatada no dia ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP
	DbSelectArea("SEH")
	DbSetOrder(2)
	lExcEmp := (FwModeAccess("SEH",1) == "E")
	lExcUnN := (FwModeAccess("SEH",2) == "E")
	lExcFil := (FwModeAccess("SEH",3) == "E")
	nLenSelFil := Len(aSelFil)
	nX := 1
	cFilSel := cFilAnt
	While nX <= nLenSelFil
		cFilAnt := aSelFil[nX]
		cTmpFil := xFilial("SEH",aSelFil[nX])
		SEH->(DbSeek(cTmpFil + "A",.T.))
		While !(SEH->(Eof())) .And. SEH->EH_FILIAL == cTmpFil .And. SEH->EH_STATUS == "A"
			aCalc := Fa171Calc(dPesqFin)
			If SEH->EH_APLEMP == "EMP"
				nEmprestimo += xMoeda(aCalc[2,1],1,mv_par12,,,nTxMoedBc)
			Else
				nAplicacao += xMoeda(aCalc[1],1,mv_par12,,,nTxMoedBc)
			EndIf
			SEH->(dbSkip())
		EndDo
		cFil := ""
		If lExcEmp
			cFil := FWCompany("SEH")
			If lExcUnN
				cFil += FWUnitBusiness("SEH")
				If lExcFil
					cFil += FwFilial("SEH")
				Endif
			Endif
		Endif
		If Empty(cFil)
			nX := nLenSelFil + 1
		Else
			nLencFil := Len(cFil)
			While (nX <= nLenSelFil) .And. (cFil == Substr(aSelFil[nX],1,nLencFil))
				nX++
			Enddo
		Endif
	Enddo
	cFilAnt := cFilSel
#ELSE
	dbSelectArea("SEH")
	dbSetOrder(2)
	dbSeek(xFilial("SEH")+"A",.T.)
	While !Eof() .And. SEH->EH_FILIAL == xFilial("SEH") .And. SEH->EH_STATUS == "A"
		aCalc := Fa171Calc(dPesqFin)
		If SEH->EH_APLEMP == "EMP"
			nEmprestimo += xMoeda(aCalc[2,1],1,mv_par12,,,nTxMoedBc)
		Else
			nAplicacao += xMoeda(aCalc[1],1,mv_par12,,,nTxMoedBc)
		EndIf
		SEH->(dbSkip())
	EndDo
#ENDIF
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica disponibilidade banc ria                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nCaixas := nBancos := 0
#IFDEF TOP
	SE8->( DbSetOrder(1) )
	dbSelectArea("SA6")
	lExcEmp := (FwModeAccess("SA6",1) == "E")
	lExcUnN := (FwModeAccess("SA6",2) == "E")
	lExcFil := (FwModeAccess("SA6",3) == "E")
	nLenSelFil := Len(aSelFil)
	nX := 1
	cFilSel := cFilAnt
	While nX <= nLenSelFil
		cFilAnt := aSelFil[nX]
		cTmpFil := xFilial("SA6",aSelFil[nX])
		SA6->(DbSeek(cTmpFil))
		While !(SA6->(Eof())) .and. SA6->A6_FILIAL == cTmpFil
			IF SA6->A6_FLUXCAI == "N"
				SA6->(dbSkip())
				Loop
			Endif
			If aScan( aSaldoSE8, SE8->( xFilial() ) + SA6->A6_COD + SA6->A6_AGENCIA + SA6->A6_NUMCON ) == 0
				IF SubStr(SA6->A6_COD,1,2) == "CX"
					nCaixas += RecSalBco(SA6->A6_COD,SA6->A6_AGENCIA,SA6->A6_NUMCON,dDataBase)
				Else
					nBancos += RecSalBco(SA6->A6_COD,SA6->A6_AGENCIA,SA6->A6_NUMCON,dDataBase)
				EndIf
				AADD( aSaldoSE8, SE8->( xFilial() ) + SA6->A6_COD + SA6->A6_AGENCIA + SA6->A6_NUMCON ) 
			EndIf
			SA6->(dbSkip())
		Enddo
		cFil := ""
		If lExcEmp
			cFil := FWCompany("SA6")
			If lExcUnN
				cFil += FWUnitBusiness("SA6")
				If lExcFil
					cFil += FwFilial("SA6")
				Endif
			Endif
		Endif
		If Empty(cFil)
			nX := nLenSelFil + 1
		Else
			nLencFil := Len(cFil)
			While (nX <= nLenSelFil) .And. (cFil == Substr(aSelFil[nX],1,nLencFil))
				nX++
			Enddo
		Endif
	Enddo
	cFilAnt := cFilSel
#ELSE
	dbSelectArea("SA6")
	dbSeek(cFilial)
	While !Eof() .and. SA6->A6_FILIAL == cFilial
	
		IF SA6->A6_FLUXCAI == "N"
			SA6->(dbSkip())
			Loop
		Endif
	
		IF SubStr(SA6->A6_COD,1,2) = "CX"
			nCaixas += RecSalBco(SA6->A6_COD,SA6->A6_AGENCIA,SA6->A6_NUMCON,dDataBase)
		Else
			nBancos += RecSalBco(SA6->A6_COD,SA6->A6_AGENCIA,SA6->A6_NUMCON,dDataBase)
		EndIf
		SA6->(dbSkip())
	Enddo
#ENDIF
nBancos := xMoeda(nBancos,1,mv_par12,,,nTxMoedBc)
nCaixas := xMoeda(nCaixas,1,mv_par12,,,nTxMoedBc)
/* GESTAO - fim
*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona o arquivo SE1 - Contas a Receb, atualizando vetor totaliz.³
//³ aBlocos, filtrando de acordo com os parametros.                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SE1")
dbSetOrder(7) 				// Ordem por Vencimento Real
#IFDEF TOP
	aStru     := SE1->(dbStruct())
	cAliasTrb := GetNextAlias()
	cTmpFil   := ""
	cQuery 	  := ""
	aEval(aStru,{|x| cQuery += ","+AllTrim(x[1])})
	cQuery := "SELECT "+SubStr(cQuery,2)
	cQuery +=         ",SE1.R_E_C_N_O_ SE1RECNO "
	cQuery += "FROM "+RetSqlName("SE1")+ " SE1 "
	cQuery += "WHERE "
	/*
	GESTAO - inicio */
	cQuery += "E1_FILIAL " + GetRngFil(aSelFil,"SE1",.T.,@cTmpFil) + " AND "
	Aadd(aTmpFil,cTmpFil)
	/* GESTAO - fim
	*/
	cQuery += "E1_VENCREA >='"+DTOS(dPesqIni)+"' AND "
	cQuery += "E1_VENCREA <='"+DTOS(dPesqFin)+"' AND "
	cQuery += "E1_CLIENTE >='"+MV_PAR03+"' AND "
	cQuery += "E1_CLIENTE <='"+MV_PAR04+"' AND "
	cQuery += "E1_NATUREZ >='"+MV_PAR07+"' AND "
	cQuery += "E1_NATUREZ <='"+MV_PAR08+"' AND "
	cQuery += "E1_EMISSAO <='"+DTOS(dDataBase)+"' AND "
	cQuery += "E1_TIPO NOT IN "+FormatIn(MVABATIM,cSepAbat) + " AND "
	cQuery += "E1_SITUACA NOT IN "+ FormatIn(cLstDesc,'|')+" AND "	
	cQuery += "E1_FLUXO <> 'N' AND "
	If mv_par09 == 2
		cQuery += "E1_TIPO NOT IN " + FormatIn(MVPROVIS,cSepProv)+" AND "
	Endif
	If mv_par11 == 2
		cQuery += "E1_SALDO  > 0 AND "
	Endif
	/*
	GESTAO - inicio */
	If MV_PAR14 == 2
		cQuery += " (NOT (E1_FATURA = '" + Padr("NOTFAT",TamSX3("E1_FATURA")[1]) + "')) AND " 
	Endif
	/* GESTAO - fim
	*/
	cQuery += "SE1.D_E_L_E_T_=' ' "
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTrb,.T.,.T.)
	aEval(aStru, {|e| If(e[2]!= "C" .And. (cAliasTrb)->(FieldPos(e[1])) > 0,TCSetField(cAliasTrb, e[1], e[2],e[3],e[4]),Nil)})
	cFilSel := cFilAnt	
	Do While !((cAliasTrb)->(Eof()))
		cFilAnt := (cAliasTrb)->E1_FILORIG
#ELSE
	DbSeek(xFilial("SE1")+dtos(dPesqIni),.T.)
	cAliasTrb := "SE1"	
	Do While (cAliasTrb)->E1_FILIAL == xFilial("SE1") .And. (cAliasTrb)->E1_VENCREA <= dPesqFin .and. (cAliasTrb)->(!Eof())
		If (cAliasTrb)->E1_Cliente < mv_par03 .or. (cAliasTrb)->E1_CLIENTE > mv_par04 
			(cAliasTrb)->(dbSkip())
			Loop
		Endif
		If (cAliasTrb)->E1_NATUREZ < mv_par07 .or. (cAliasTrb)->E1_NATUREZ > mv_par08
			(cAliasTrb)->(dbSkip())
			Loop
		EndIf
		If (cAliasTrb)->E1_EMISSAO > dDataBase .or. (cAliasTrb)->E1_TIPO $ MVABATIM .OR. (cAliasTrb)->E1_SITUACA $ cLstDesc	
			(cAliasTrb)->(dbSkip())
			Loop
		Endif	
		If (cAliasTrb)->E1_FLUXO == "N" 
			(cAliasTrb)->(dbSkip())
			Loop	
		EndIf
		If mv_par09 = 2 .and. (cAliasTrb)->E1_TIPO $ MVPROVIS
			(cAliasTrb)->(dbSkip())
			Loop
		EndIf                          

		If mv_par14 = 2 .and. Alltrim((cAliasTrb)->E1_FATURA) $ "NOTFAT"
		   (cAliasTrb)->(dbSkip())
	   		Loop
		EndIf	
#ENDIF
			
	If mv_par11 == 1
		#IFDEF TOP
			SE1->(MsGoto((cAliasTrb)->SE1RECNO)) // SaldoTit, precisa do SE1 posicionado
		#ENDIF	
		nSaldoTit := SaldoTit((cAliasTrb)->E1_PREFIXO,(cAliasTrb)->E1_NUM,(cAliasTrb)->E1_PARCELA,;
							(cAliasTrb)->E1_TIPO,(cAliasTrb)->E1_NATUREZ,"R",(cAliasTrb)->E1_CLIENTE,1,,,(cAliasTrb)->E1_LOJA)
	Else
		nSaldoTit := Round(NoRound(xMoeda(((cAliasTrb)->E1_SALDO+(cAliasTrb)->E1_SDACRES-(cAliasTrb)->E1_SDDECRE),(cAliasTrb)->E1_MOEDA,mv_par12,,3,nTxMoedBc),3),2)
	Endif
	If !(cAliasTrb)->E1_TIPO $ MVRECANT .And. !((cAliasTrb)->E1_TIPO $ MV_CRNEG) .And. ;
		!( MV_PAR11 == 2 .And. nSaldoTit == 0 ) 
		//*** nao deve olhar abatimento pois ‚ zerado o saldo na liquidacao final do titulo
		nSaldoTit -=SomaAbat((cAliasTrb)->E1_PREFIXO,(cAliasTrb)->E1_NUM,(cAliasTrb)->E1_PARCELA,"R",1)
	EndIf
	If Abs(nSaldoTit) > 0.0001
		dDataTrab := (cAliasTrb)->E1_VENCREA
		nPosicao  := ascan(aBlocos,;	// Acha o elemento do Vetor a Atualizar
						{|_vet| dDataTrab>=_vet[1] .and. dDataTrab<=_vet[2]})
		If (cAliasTrb)->E1_TIPO $ MVRECANT+"/"+MV_CRNEG
			aBlocos[nPosicao][3] -= nSaldoTit
		Else
			aBlocos[nPosicao][3] += nSaldoTit
		Endif
	Endif
   (cAliasTrb)->(dbSkip())
EndDo
/*
GESTAO - inicio */
#IFDEF TOP
	cFilAnt := cFilSel
	DbSelectArea(cAliasTrb)
	DbCloseArea()
#ENDIF
/* GESTAO - fim
*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona o arquivo SE2 - Contas a pagar, atualizando vetor totaliz.³
//³ aBlocos, filtrando de acordo com os parametros.                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SE2")
dbSetOrder(3) 			// Ordem por Vencimento Real
#IFDEF TOP
	aStru     := SE2->(dbStruct())
	cAliasTrb := GetNextAlias()
	cTmpFil   := ""
	cQuery    := ""
	aEval(aStru,{|x| cQuery += ","+AllTrim(x[1])})
	cQuery := "SELECT "+SubStr(cQuery,2)
	cQuery +=         ",SE2.R_E_C_N_O_ SE2RECNO "
	cQuery += "FROM "+RetSqlName("SE2")+ " SE2 "
	cQuery += "WHERE "
	/*
	GESTAO - inicio */
	cQuery += "E2_FILIAL " + GetRngFil(aSelFil,"SE2",.T.,@cTmpFil) + " AND "
	Aadd(aTmpFil,cTmpFil)
	/* GESTAO - fim
	*/
	cQuery += "E2_VENCREA >='"+DTOS(dPesqIni)+"' AND "
	cQuery += "E2_VENCREA <='"+DTOS(dPesqFin)+"' AND "
	cQuery += "E2_FORNECE >='"+MV_PAR05+"' AND "
	cQuery += "E2_FORNECE <='"+MV_PAR06+"' AND "
	cQuery += "E2_NATUREZ >='"+MV_PAR07+"' AND "
	cQuery += "E2_NATUREZ <='"+MV_PAR08+"' AND "
	cQuery += "E2_EMISSAO <='"+DTOS(dDataBase)+"' AND "
	cQuery += "E2_TIPO NOT IN "+FormatIn(MVABATIM,cSepAbat) + " AND "
	cQuery += "E2_FLUXO <> 'N' AND "
	If mv_par09 == 2
		cQuery += "E2_TIPO NOT IN " + FormatIn(MVPROVIS,cSepProv)+" AND "
	Endif
	If mv_par11 == 2
		cQuery += "E2_SALDO  > 0 AND "
	Endif
	/*
	GESTAO - inicio */
	If MV_PAR14 == 2
		cQuery += " (NOT (E2_FATURA = '" + Padr("NOTFAT",TamSX3("E2_FATURA")[1]) + "')) AND " 
	Endif
	/* GESTAO - fim
	*/
	cQuery += "SE2.D_E_L_E_T_=' ' "
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTrb,.T.,.T.)
	aEval(aStru, {|e| If(e[2]!= "C" .And. (cAliasTrb)->(FieldPos(e[1])) > 0,TCSetField(cAliasTrb, e[1], e[2],e[3],e[4]),Nil)})
	cSelFil := cFilAnt	
	Do While !((cAliasTrb)->(Eof()))
		cFilAnt := (cAliasTrb)->E2_FILORIG
#ELSE
	DbSeek(cFilial+dtos(dPesqIni),.T.)
	cAliasTrb := "SE2"	
	Do While (cAliasTrb)->E2_FILIAL == xFilial("SE2") .And. (cAliasTrb)->E2_VENCREA <= dPesqFin .and. (cAliasTrb)->(!Eof())
	If (cAliasTrb)->E2_FORNECE < mv_par05 .or. (cAliasTrb)->E2_FORNECE > mv_par06 
		(cAliasTrb)->(dbSkip())
		Loop
	Endif
	If (cAliasTrb)->E2_NATUREZ < mv_par07 .or. (cAliasTrb)->E2_NATUREZ > mv_par08
		(cAliasTrb)->(dbSkip())
		Loop
	EndIf
	If (cAliasTrb)->E2_EMISSAO > dDataBase .or. (cAliasTrb)->E2_TIPO $ MVABATIM
		(cAliasTrb)->(dbSkip())
		Loop
	Endif
	If (cAliasTrb)->E2_FLUXO == "N"
		dbSkip()
		Loop
	EndIf
	If mv_par09 = 2 .and. (cAliasTrb)->E2_TIPO $ MVPROVIS
		(cAliasTrb)->(dbSkip())
		Loop
	EndIf
	If mv_par14 = 2 .and. Alltrim((cAliasTrb)->E2_FATURA) $ "NOTFAT"
	   (cAliasTrb)->(dbSkip())
	   Loop
	EndIf	
#ENDIF
	
	If mv_par11 == 1
		#IFDEF TOP
			SE2->(MsGoto((cAliasTrb)->SE2RECNO)) // SaldoTit, precisa do SE2 posicionado
		#ENDIF	
		nSaldoTit := SaldoTit((cAliasTrb)->E2_PREFIXO,(cAliasTrb)->E2_NUM,(cAliasTrb)->E2_PARCELA,;
							(cAliasTrb)->E2_TIPO,(cAliasTrb)->E2_NATUREZ,"P",(cAliasTrb)->E2_FORNECE,1,,,(cAliasTrb)->E2_LOJA)
	Else
		nSaldoTit := xMoeda(((cAliasTrb)->E2_SALDO+(cAliasTrb)->E2_SDACRES-(cAliasTrb)->E2_SDDECRE),(cAliasTrb)->E2_MOEDA,mv_par12,,,nTxMoedBc)
	Endif
	If !(cAliasTrb)->E2_TIPO$MVPAGANT+"/"+MV_CPNEG .And. !( MV_PAR11 == 2 .And. nSaldoTit == 0 ) 
		//*** nao deve olhar abatimento pois e zerado o saldo na liquidacao final do titulo
		nSaldoTit -=SomaAbat((cAliasTrb)->E2_PREFIXO,(cAliasTrb)->E2_NUM,(cAliasTrb)->E2_PARCELA,"P",1)
	EndIf
	If Abs(nSaldoTit) > 0.0001
		dDataTrab := (cAliasTrb)->E2_VENCREA
		nPosicao  := ascan(aBlocos,;	// Acha o elemento do vetor a Atualizar
						{|_vet| dDataTrab>=_vet[1] .and. dDataTrab<=_vet[2]})
		If (cAliasTrb)->E2_TIPO $ MVPAGANT+"/"+MV_CPNEG
			aBlocos[nPosicao][5] -= nSaldoTit
		Else
			aBlocos[nPosicao][5] += nSaldoTit
		Endif
	Endif
	(cAliasTrb)->(dbSkip())
Enddo

cFilAnt := cSelFil
DbSelectArea(cAliasTrb)
DbCloseArea()

//Seleciona o arquivo SE5 - Movim/o Bancario, atualizando vetor totaliz.aBlocos, filtrando de acordo com os parametros
dbSelectArea("SE5")
DbSetOrder(1)

aStru     := SE5->(dbStruct())
cAliasTrb := GetNextAlias()
cTmpFil   := ""
cQuery := "SELECT * "
cQuery += "FROM "+RetSqlName("SE5")+ " SE5 "
cQuery += "WHERE "
cQuery += "E5_FILIAL " + GetRngFil(aSelFil,"SE5",.T.,@cTmpFil) + " AND "

Aadd(aTmpFil,cTmpFil)

cQuery += "E5_DATA >='"+DTOS(dPesqIni)+"' AND "
cQuery += "E5_DATA <='"+DTOS(dPesqFin)+"' AND "
cQuery += "((E5_RECPAG = 'R' AND E5_CLIFOR >='"+MV_PAR03+"' AND E5_CLIFOR <='"+MV_PAR04+"') OR "
cQuery += "(E5_RECPAG = 'P' AND E5_CLIFOR >='"+MV_PAR05+"' AND E5_CLIFOR <='"+MV_PAR06+"')) AND "
cQuery += "E5_NATUREZ >='"+MV_PAR07+"' AND "
cQuery += "E5_NATUREZ <='"+MV_PAR08+"' AND "
cQuery += "E5_TIPODOC NOT IN " + FormatIn("DC/JR/MT/CM/D2/J2/M2/C2/V2/CP/TL","/") + " AND "
// ignora baixas automaticas com cheque, pois o proprio cheque ser  considerado
cQuery += "NOT (E5_TIPODOC = 'BA' AND E5_NUMCHEQ <> ' ') AND "
cQuery += "E5_SITUACA <> 'C' AND "
cQuery += "E5_VALOR > 0 AND "
cQuery += "SE5.D_E_L_E_T_=' ' "
cQuery := ChangeQuery(cQuery)
cAliasTrb := GetNextAlias()
	
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTrb,.T.,.T.)
aEval(aStru, {|e| If(e[2]!= "C" .And. (cAliasTrb)->(FieldPos(e[1])) > 0,TCSetField(cAliasTrb, e[1], e[2],e[3],e[4]),Nil)})	

Do While !((cAliasTrb)->(Eof()))
	If (cAliasTrb)->E5_RECPAG == "R"		// Carteira RECEBIDA
		IF (cAliasTrb)->E5_CLIFOR < mv_par03 .Or. (cAliasTrb)->E5_CLIFOR > mv_par04
			(cAliasTrb)->(dbSkip())
			Loop
		EndIF
		
		lMovM2    := MovMoedEs((cAliasTrb)->E5_MOEDA, (cAliasTrb)->E5_TIPODOC, (cAliasTrb)->E5_MOTBX, (cAliasTrb)->E5_DATA, (cAliasTrb)->E5_RECPAG)
		dDataTrab := (cAliasTrb)->E5_DATA
		
		nSaldoTit := xMoeda(If(lMovM2, (cAliasTrb)->E5_VLMOED2, (cAliasTrb)->E5_VALOR),;
							IIf(cPaisLoc # "BRA", MoedaBco((cAliasTrb)->E5_BANCO, (cAliasTrb)->E5_AGENCIA, (cAliasTrb)->E5_CONTA), 1), mv_par12,,,nTxMoedBc)
		
		nPosicao  := ascan(aBlocos,{|_vet| dDataTrab>=_vet[1] .and. dDataTrab<=_vet[2]})	// Acha o elemnento do vetor a Atualizar
		aBlocos[nPosicao][4] += nSaldoTit
		
		If (cAliasTrb)->E5_RECPAG == "R" .And. (cAliasTrb)->E5_TIPODOC == "BL" 
			aBlocos[nPosicao][4] -= nSaldoTit
		EndIf	
	Else									// Carteira PAGA
		IF (cAliasTrb)->E5_CLIFOR < mv_par05 .Or. (cAliasTrb)->E5_CLIFOR > mv_par06
			(cAliasTrb)->(dbSkip())
			Loop
		EndIF
		
		dDataTrab := (cAliasTrb)->E5_DATA

		If mv_par14 != 2 .or. AllTrim((cAliasTrb)->E5_MOTBX) != "FAT" 
			lMovM2    := MovMoedEs((cAliasTrb)->E5_MOEDA, (cAliasTrb)->E5_TIPODOC, (cAliasTrb)->E5_MOTBX, (cAliasTrb)->E5_DATA, (cAliasTrb)->E5_RECPAG) 
			
			nSaldoTit := xMoeda(If(lMovM2, (cAliasTrb)->E5_VLMOED2, (cAliasTrb)->E5_VALOR),;
								IIf(cPaisLoc # "BRA", MoedaBco((cAliasTrb)->E5_BANCO, (cAliasTrb)->E5_AGENCIA, (cAliasTrb)->E5_CONTA), 1), mv_par12,,,nTxMoedBc)
			
			nPosicao  := ascan(aBlocos,{|_vet| dDataTrab>=_vet[1] .and. dDataTrab<=_vet[2]})
			aBlocos[nPosicao][6] += nSaldoTit						
		EndIf

		If ((cAliasTrb)->E5_TIPODOC == "EP" .And. (cAliasTrb)->E5_RECPAG=="P") .Or.;// Estorno de Emprestimo				
			((cAliasTrb)->E5_TIPODOC == "PE" .And. (cAliasTrb)->E5_RECPAG=="R")		  // Estorno de pagamento de emprestimo
			aBlocos[nPosicao][6] -= nSaldoTit
		EndIf
	EndIf
	(cAliasTrb)->(dbSkip())
EndDo

DbSelectArea(cAliasTrb)
DbCloseArea()
DbSelectArea("SE5")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona o arquivo SE3 - Comiss”es de Vendas, atualizando o Vetor    ³
//³ totalizador aBlocos, caso solicitada a op‡„o Considerar Comiss”es     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par10 ==1 
	/*
	GESTAO - inicio */
	#IFDEF TOP
		cTmpFil:= ""
		cQuery := "select E3_COMIS,E3_DATA,E3_VENCTO from " + RetSQLName("SE3")
		cQuery += " where E3_FILIAL " + GetRngFil(aSelFil,"SE3",.T.,@cTmpFil)
		Aadd(aTmpFil,cTmpFil)
		cQuery += " and D_E_L_E_T_ = ' '" 
		cQuery := ChangeQuery(cQuery)
		cAliasTrb := GetNextAlias()
		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTrb,.T.,.T.)
		TCSetField(cAliasTrb,"E3_DATA","D",8,0)
		TCSetField(cAliasTrb,"E3_VENCTO","D",8,0)
		While !((cAliasTrb)->(Eof()))
			nSaldoTit := (cAliasTrb)->E3_COMIS
			dDataTrab := If(empty((cAliasTrb)->E3_DATA),(cAliasTrb)->E3_VENCTO,(cAliasTrb)->E3_DATA)
			If (nPosicao := ascan(aBlocos,{|_vet| dDataTrab>=_vet[1] .and. dDataTrab<=_vet[2]})) > 0
				If empty((cAliasTrb)->E3_DATA)
					aBlocos[nPosicao][5] += nSaldoTit	// Pagar (em Aberto)
				Else
					aBlocos[nPosicao][6] += nSaldoTit	// Pagar (Realizado)
				Endif
			ENDIF
			(cAliasTrb)->(dbSkip())
		EndDo
		DbSelectArea(cAliasTrb)
		DbCloseArea()
	#ELSE
		dbSelectArea("SE3")
		dbSeek(xFilial())
		Do While SE3->(!Eof()) .and. E3_FILIAL == xFilial()
			nSaldoTit := E3_COMIS
			dDataTrab := if(empty(E3_DATA),E3_VENCTO,E3_DATA)
			IF (nPosicao := ascan(aBlocos,{|_vet| dDataTrab>=_vet[1] ;
					.and. dDataTrab<=_vet[2]})) > 0
				If empty(E3_DATA)
					aBlocos[nPosicao][5] += nSaldoTit	// Pagar (em Aberto)
				Else
					aBlocos[nPosicao][6] += nSaldoTit	// Pagar (Realizado)
				Endif
			ENDIF
			SE3->(dbSkip())
		EndDo
	#ENDIF
	/* GESTAO - fim
	*/
Endif
/*
GESTAO - inicio */
/* imprime a lista de filiais selecionadas para o relatorio */
If Len(aSelFil) > 1 .And. !Empty(aBlocos)
	oSection1:SetHeaderSection(.F.)
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0035 + ")")		//"Filiais selecionadas para o relatorio"
	nTamTit := Len(oReport:Title())
	oSecFil:Init()  
	oSecFil:Cell("CODFIL"):SetBlock({||cFilSel})
	oSecFil:Cell("EMPRESA"):SetBlock({||aSM0[nLinha,SM0_DESCEMP]})
	oSecFil:Cell("UNIDNEG"):SetBlock({||aSM0[nLinha,SM0_DESCUN]})
	oSecFil:Cell("NOMEFIL"):SetBlock({||aSM0[nLinha,SM0_NOMRED]})
	For nX := 1 To Len(aSelFil)
		nLinha := Ascan(aSM0,{|sm0|,sm0[SM0_CODFIL] == aSelFil[nX]})
		If nLinha > 0
			cFilSel := Substr(aSM0[nLinha,SM0_CODFIL],1,nTamEmp)
			cFilSel += " "
			cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + 1,nTamUnNeg)
			cFilSel += " "
			cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + nTamUnNeg + 1)
			oSecFil:PrintLine()
		Endif
	Next
	oReport:SetTitle(cTitulo)
	oSecFil:Finish()
	oSection1:SetHeaderSection(.T.)
	oReport:EndPage()
Endif
/* GESTAO - fim
*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime o Relatorio a partir do Vetor aBlocos...                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lPagina := .T.
oReport:SetMeter(mv_par02)
nAtual  := 1

Do While nAtual <= mv_par02 .And. !oReport:Cancel()
	If oReport:Cancel()
		Exit
	EndIf	
	lImpPag := .F.
	lImpCab := .T.
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa o Vetor de Impressao de um Bloco de Linhas              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lPagina
		lPagina := .F.
		oReport:PrintText("")		
		oReport:PrintText(OemToAnsi(STR0015)+Space(10)+Transform(nCaixas    , tm(nCaixas,22)))	//"SALDO EM CAIXA      : "
		oReport:PrintText(OemToAnsi(STR0016)+Space(10)+Transform(nBancos    , tm(nBancos,22)))	//"SALDO EM BANCOS     : "
		oReport:PrintText(OemToAnsi(STR0017)+Space(10)+Transform(nAplicacao , tm(nAplicacao,22)))	//"SALDO EM APLICACOES : "
		oReport:PrintText(OemToAnsi(STR0018)+Space(10)+Transform(nEmprestimo, tm(nEmprestimo,22)))	//"SALDO EM EMPRESTIMOS: "		
		nSaldoDoDia += nCaixas
		nSaldoDoDia += nBancos
		nSaldoDoDia += nAplicacao
		nSaldoDoDia -= nEmprestimo		
		oReport:PrintText(OemToAnsi(STR0019)+Space(10)+Transform(nSaldoDoDia,"@E 999,999,999,999,999.99"))	//"TOTAL DO DISPONIVEL : "
		oReport:PrintText("")
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao dos periodos.										              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cPeriodo := If(mv_par01=1,STR0022,; 				// Dia
					If(mv_par01=2,STR0023,; 				// Semana
					If(mv_par01=3,STR0024,STR0025)))		// Quinzena ### Mes

	oSection1:Init()
	oSection1:PrintLine()
	oSection1:Finish()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao dos valores a RECEBER/PAGAR						              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   oSection2:Init()
	oSection2:PrintLine()
	lImpCab := .F.				
	oSection2:PrintLine()
	lImpPag := .T.      		
	oSection2:PrintLine()	
	oSection2:Finish()	

   oReport:IncMeter()
	nAtual++
EndDo
/*
GESTAO - inicio */
#IFDEF TOP
	If !Empty(aTmpFil)
		For nX := 1 To Len(aTmpFil)
			CtbTmpErase(aTmpFil[nX])
		Next
	Endif
#ENDIF

FwFreeArray( aSaldoSE8 )

Return

/*
---------------------------------------------- Release 3 ---------------------------------------------------------
*/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FINR840  ³ Autor ³ J£lio Wittwer         ³ Data ³ 11.02.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Resumo Financeiro Sint‚tico                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FINR840(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Gen‚rico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Julio Witt. ³02.08.99³META  ³Interpretar MV_CRNEG e MV_CPNEG           ³±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FINR840R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Vari veis  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel
LOCAL cDesc1 :=STR0001  //"Emiss„o do Relat¢rio Resumo Financeiro Sint‚tico. Ser  usado a"
LOCAL cDesc2 :=STR0002  //"a data-base do sistema como ponto de partida."
LOCAL cDesc3 :=""
LOCAL cString:="SE7"
Local nMoeda, cTexto

PRIVATE Titulo  := ""
PRIVATE cabec1  := ""
PRIVATE cebec2  := ""
PRIVATE tamanho := "M"
PRIVATE aReturn := { OemToAnsi(STR0003), 1,OemToAnsi(STR0004), 1, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE nomeprog:= "FINR840"
PRIVATE aLinha  := { },nLastKey := 0
PRIVATE cPerg   := "FIR840"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impress„o do Cabe‡alho e Rodap‚    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li       := 80
m_pag    := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("FIR840",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parƒmetros                               ³
//³ mv_par01               Per¡odo (D/S/Q/M). ?                        ³
//³ mv_par02               N£mero de Per¡odos ?                        ³
//³ mv_par03               Do Cliente         ?                        ³
//³ mv_par04               Ate o Cliente      ?                        ³
//³ mv_par05               Do Fornecedor      ?                        ³
//³ mv_par06               Ate o Fornecedor   ?                        ³
//³ mv_par07               Da Natureza        ?                        ³
//³ mv_par08               At‚ a Natureza     ?                        ³
//³ mv_par09               Considera Provisor.?                        ³
//³ mv_par10               Considera Comiss”es?                        ³
//³ mv_par11               Considera Data Base?                        ³
//³ mv_par12               Moeda              ?                        ³
//³ mv_par13					Inicio do Per¡odo  ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Defini‡„o dos cabe‡alhos      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Titulo := OemToAnsi(STR0005)  //"Resumo Financeiro Sintetico"
cabec1 := OemToAnsi(STR0006)  //"Resumo Financeiro Sintetico"
cabec2 := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a fun‡„o SETPRINT   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "FINR840"            //Nome Default do relat¢rio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nMoeda	:= mv_par12
cTexto	:= " - " + GetMv("MV_MOEDA"+Str(nMoeda,1))
Titulo	+= cTexto

RptStatus({|lEnd| U_FA840Imp(@lEnd,wnRel,cString)},Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FA840IMP ³ Autor ³ J£lio Wittwer         ³ Data ³ 11.02.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Resumo Financeiro Sint‚tico                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FA840Imp(lEnd,wnRel,cString)
LOCAL cbCont		:=0
LOCAL CbTxt			:= Space(10)
LOCAL nSaldoTit		:= 0
LOCAL nBancos		:= 0
LOCAL nCaixas		:= 0
LOCAL nAplicacao 	:= 0
Local nEmprestimo	:= 0
LOCAL lPrimeiraPagina := .T.
LOCAL aSemana 		:= {OemToAnsi(STR0007),OemToAnsi(STR0008),OemToAnsi(STR0009),OemToAnsi(STR0010),;     //"Domingo"###"Segunda"###"Terca  "###"Quarta "
						OemToAnsi(STR0011),OemToAnsi(STR0012),OemToAnsi(STR0013) }              //"Quinta "###"Sexta  "###"Sabado " 
Local aBlocos		:= {}
Local nSaldoDoDia	:= 0
Local dPesqIni      := CTOD("//")
Local dPesqFin		:= CTOD("//")
Local nAtual		:= 0
Local nX			:= 0
Local nTxMoedBc		:= 0
Local cLstDesc		:= FN022LSTCB(2)	//Lista das situacoes de cobranca (Descontada)

#IFDEF TOP
	Local cQuery	:= 0
	Local cAliasTrb
	Local cSepProv  := If("|"$MVPROVIS,"|",",") 
#ENDIF
aBlocos:=U_CriaBlocos(mv_par01,mv_par02,mv_par13)

dPesqIni := aBlocos[1][1]
dPesqFin := aBlocos[len(aBlocos)][2]
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³VerIfica se foi utilizada taxa contratada para moeda > 1          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTxMoedBc := SE5->E5_TXMOEDA	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se existe aplica‡„o a ser resgatada no dia           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SEG")
dbSetOrder(2)
dbSeek(cFilial+Dtos(dDataBase),.t.)
While !Eof() .And. SEG->EG_DATARES<=dPesqFin .and. SEG->EG_FILIAL == xFilial("SEG")
	If SEG->EG_TIPO == "EMP"
		nEmprestimo += xMoeda(SEG->EG_VALOR,1,mv_par12,,,nTxMoedBc)
	Else
		nAplicacao  += xMoeda(SEG->EG_VALOR,1,mv_par12,,,nTxMoedBc)
	EndIf
	dbSkip()
Enddo
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se existe Operacao Financeira a ser resgatada no dia ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SEH")
dbSetOrder(2)
dbSeek(xFilial("SEH")+"A",.T.)
While ( !Eof() .And. SEH->EH_FILIAL == xFilial("SEH") .And. SEH->EH_STATUS == "A" )
	aCalc := Fa171Calc(dPesqFin)
	If ( SEH->EH_APLEMP == "EMP" )
		nEmprestimo += xMoeda(aCalc[2,1],1,mv_par12,,,nTxMoedBc)
	Else
		nAplicacao += xMoeda(aCalc[1],1,mv_par12,,,nTxMoedBc)
	EndIf
	dbSelectArea("SEH")
	dbSkip()
EndDo
dbSelectArea("SEH")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica disponibilidade banc ria                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nCaixas := nBancos := 0
dbSelectArea("SA6")
dbSeek(cFilial)
While ! Eof() .and. SA6->A6_FILIAL == cFilial

	IF SA6->A6_FLUXCAI == "N"
		dbSkip()
		Loop
	Endif

	IF SubStr(SA6->A6_COD,1,2) = "CX"
		nCaixas += RecSalBco(SA6->A6_COD,SA6->A6_AGENCIA,SA6->A6_NUMCON,dDataBase)
	Else
		nBancos += RecSalBco(SA6->A6_COD,SA6->A6_AGENCIA,SA6->A6_NUMCON,dDataBase)
	EndIf
	dbSelectArea("SA6")
	dbSkip()
Enddo
nBancos := xMoeda(nBancos,1,mv_par12,,,nTxMoedBc)
nCaixas := xMoeda(nCaixas,1,mv_par12,,,nTxMoedBc)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona o arquivo SE1 - Contas a Receb, atualizando vetor totaliz.³
//³ aBlocos, filtrando de acordo com os parametros.                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SE1")
dbSetOrder(7) 				// Ordem por Vencimento Real
#IFDEF TOP
	aStru     := SE1->(dbStruct())
	cAliasTrb := GetNextAlias()
	cQuery := ""
	aEval(aStru,{|x| cQuery += ","+AllTrim(x[1])})
	cQuery := "SELECT "+SubStr(cQuery,2)
	cQuery +=         ",SE1.R_E_C_N_O_ SE1RECNO "
	cQuery += "FROM "+RetSqlName("SE1")+ " SE1 "
	cQuery += "WHERE "
	cQuery += "E1_FILIAL='"+xFilial("SE1")+"' AND "
	cQuery += "E1_VENCREA >='"+DTOS(dPesqIni)+"' AND "
	cQuery += "E1_VENCREA <='"+DTOS(dPesqFin)+"' AND "
	cQuery += "E1_CLIENTE >='"+MV_PAR03+"' AND "
	cQuery += "E1_CLIENTE <='"+MV_PAR04+"' AND "
	cQuery += "E1_NATUREZ >='"+MV_PAR07+"' AND "
	cQuery += "E1_NATUREZ <='"+MV_PAR08+"' AND "
	cQuery += "E1_EMISSAO <='"+DTOS(dDataBase)+"' AND "
	cQuery += "E1_TIPO NOT IN "+FormatIn(MVABATIM,"/") + " AND "
	cQuery += "E1_SITUACA NOT IN "+ Formatin(cLstDesc,'|') +" AND "	
	cQuery += "E1_FLUXO <> 'N' AND "
	If mv_par09 == 2
		cQuery += "E1_TIPO NOT IN " + FormatIn(MVPROVIS,cSepProv)+" AND "
	Endif
	If mv_par11 == 2
		cQuery += "E1_SALDO  > 0 AND "
	Endif
	cQuery += "SE1.D_E_L_E_T_=' ' "
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTrb,.T.,.T.)
	aEval(aStru, {|e| If(e[2]!= "C" .And. (cAliasTrb)->(FieldPos(e[1])) > 0,TCSetField(cAliasTrb, e[1], e[2],e[3],e[4]),Nil)})
#ELSE
	DbSeek(xFilial("SE1")+dtos(dPesqIni),.t.)
	cAliasTrb := "SE1"
#ENDIF	
Do While (cAliasTrb)->E1_FILIAL == xFilial("SE1") .And. (cAliasTrb)->E1_VENCREA <= dPesqFin .and. (cAliasTrb)->(!eof())

	If (cAliasTrb)->E1_Cliente < mv_par03 .or. (cAliasTrb)->E1_CLIENTE > mv_par04 
		(cAliasTrb)->(DbSkip())
		Loop
	Endif
	If (cAliasTrb)->E1_NATUREZ < mv_par07 .or. (cAliasTrb)->E1_NATUREZ > mv_par08
		(cAliasTrb)->(DbSkip())
		Loop
	EndIf
	If (cAliasTrb)->E1_EMISSAO > dDataBase .or. (cAliasTrb)->E1_TIPO $ MVABATIM .OR. (cAliasTrb)->E1_SITUACA $ cLstDesc
		(cAliasTrb)->(dbSkip())
		Loop
	Endif
	If (cAliasTrb)->E1_FLUXO == "N" 
		(cAliasTrb)->(dbSkip())
		Loop
	EndIf
	If mv_par09 = 2 .and. (cAliasTrb)->E1_TIPO $ MVPROVIS
		(cAliasTrb)->(DbSkip())
		Loop
	EndIf
	If mv_par14 = 2 .and. Alltrim((cAliasTrb)->E1_FATURA) $ "NOTFAT"
	   (cAliasTrb)->(dbSkip())
	   Loop
	EndIf	
	
	If mv_par11 == 1
		#IFDEF TOP
			MsGoto((cAliasTrb)->SE1RECNO) // SaldoTit, precisa do SE1 posicionado
		#ENDIF	
		nSaldoTit := SaldoTit((cAliasTrb)->E1_PREFIXO,(cAliasTrb)->E1_NUM,(cAliasTrb)->E1_PARCELA,;
							(cAliasTrb)->E1_TIPO,(cAliasTrb)->E1_NATUREZ,"R",(cAliasTrb)->E1_CLIENTE,1,,,(cAliasTrb)->E1_LOJA)
	Else
		nSaldoTit := Round(NoRound(xMoeda(((cAliasTrb)->E1_SALDO+(cAliasTrb)->E1_SDACRES-(cAliasTrb)->E1_SDDECRE),(cAliasTrb)->E1_MOEDA,mv_par12,,3,nTxMoedBc),3),2)
	Endif
	If !(cAliasTrb)->E1_TIPO $ MVRECANT .And. !((cAliasTrb)->E1_TIPO $ MV_CRNEG) .And. ;
		!( MV_PAR11 == 2 .And. nSaldoTit == 0 ) 
		*** nao deve olhar abatimento pois ‚ zerado o saldo na liquidacao final do titulo
		nSaldoTit -=SomaAbat((cAliasTrb)->E1_PREFIXO,(cAliasTrb)->E1_NUM,(cAliasTrb)->E1_PARCELA,"R",1)
	EndIf
	If Abs(nSaldoTit) > 0.0001
		dDataTrab := (cAliasTrb)->E1_VENCREA
		nPosicao  := ascan(aBlocos,;	// Acha o elemento do Vetor a Atualizar
						{|_vet| dDataTrab>=_vet[1] .and. dDataTrab<=_vet[2]})
		If (cAliasTrb)->E1_TIPO $ MVRECANT+"/"+MV_CRNEG
			aBlocos[nPosicao][3] -= nSaldoTit
		Else
			aBlocos[nPosicao][3] += nSaldoTit
		Endif
	Endif
	DbSelectArea(cAliasTrb)
   DbSkip()
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona o arquivo SE2 - Contas a pagar, atualizando vetor totaliz.³
//³ aBlocos, filtrando de acordo com os parametros.                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SE2")
dbSetOrder(3) 			// Ordem por Vencimento Real
#IFDEF TOP
	aStru     := SE2->(dbStruct())
	cAliasTrb := GetNextAlias()
	cQuery := ""
	aEval(aStru,{|x| cQuery += ","+AllTrim(x[1])})
	cQuery := "SELECT "+SubStr(cQuery,2)
	cQuery +=         ",SE2.R_E_C_N_O_ SE2RECNO "
	cQuery += "FROM "+RetSqlName("SE2")+ " SE2 "
	cQuery += "WHERE "
	cQuery += "E2_FILIAL='"+xFilial("SE2")+"' AND "
	cQuery += "E2_VENCREA >='"+DTOS(dPesqIni)+"' AND "
	cQuery += "E2_VENCREA <='"+DTOS(dPesqFin)+"' AND "
	cQuery += "E2_FORNECE >='"+MV_PAR05+"' AND "
	cQuery += "E2_FORNECE <='"+MV_PAR06+"' AND "
	cQuery += "E2_NATUREZ >='"+MV_PAR07+"' AND "
	cQuery += "E2_NATUREZ <='"+MV_PAR08+"' AND "
	cQuery += "E2_EMISSAO <='"+DTOS(dDataBase)+"' AND "
	cQuery += "E2_TIPO NOT IN "+FormatIn(MVABATIM,"/") + " AND "
	cQuery += "E2_FLUXO <> 'N' AND "
	If mv_par09 == 2
		cQuery += "E2_TIPO NOT IN " + FormatIn(MVPROVIS,cSepProv)+" AND "
	Endif
	If mv_par11 == 2
		cQuery += "E2_SALDO  > 0 AND "
	Endif
	cQuery += "SE2.D_E_L_E_T_=' ' "
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTrb,.T.,.T.)
	aEval(aStru, {|e| If(e[2]!= "C" .And. (cAliasTrb)->(FieldPos(e[1])) > 0,TCSetField(cAliasTrb, e[1], e[2],e[3],e[4]),Nil)})
#ELSE
	DbSeek(cFilial+dtos(dPesqIni),.t.)
	cAliasTrb := "SE2"
#ENDIF	
Do While (cAliasTrb)->E2_FILIAL == xFilial("SE2") .And. (cAliasTrb)->E2_VENCREA <= dPesqFin .and. (cAliasTrb)->(!eof())
	If (cAliasTrb)->E2_FORNECE < mv_par05 .or. (cAliasTrb)->E2_FORNECE > mv_par06 
		(cAliasTrb)->(DbSkip())
		Loop
	Endif
	If (cAliasTrb)->E2_NATUREZ < mv_par07 .or. (cAliasTrb)->E2_NATUREZ > mv_par08
		(cAliasTrb)->(DbSkip())
		Loop
	EndIf
	If (cAliasTrb)->E2_EMISSAO > dDataBase .or. (cAliasTrb)->E2_TIPO $ MVABATIM
		(cAliasTrb)->(dbSkip())
		Loop
	Endif
	If (cAliasTrb)->E2_FLUXO == "N"
		dbSkip()
		Loop
	EndIf
	If mv_par09 = 2 .and. (cAliasTrb)->E2_TIPO $ MVPROVIS
		(cAliasTrb)->(DbSkip())
		Loop
	EndIf
	If mv_par14 = 2 .and. Alltrim((cAliasTrb)->E2_FATURA) $ "NOTFAT"
	   (cAliasTrb)->(dbSkip())
	   Loop
	EndIf	
	If mv_par11 == 1
		#IFDEF TOP
			MsGoto((cAliasTrb)->SE2RECNO) // SaldoTit, precisa do SE2 posicionado
		#ENDIF	
		nSaldoTit := SaldoTit((cAliasTrb)->E2_PREFIXO,(cAliasTrb)->E2_NUM,(cAliasTrb)->E2_PARCELA,;
							(cAliasTrb)->E2_TIPO,(cAliasTrb)->E2_NATUREZ,"P",(cAliasTrb)->E2_FORNECE,1,,,(cAliasTrb)->E2_LOJA)
	Else
		nSaldoTit := xMoeda(((cAliasTrb)->E2_SALDO+(cAliasTrb)->E2_SDACRES-(cAliasTrb)->E2_SDDECRE),(cAliasTrb)->E2_MOEDA,mv_par12,,,nTxMoedBc)
	Endif
	If !(cAliasTrb)->E2_TIPO$MVPAGANT+"/"+MV_CPNEG .And. !( MV_PAR11 == 2 .And. nSaldoTit == 0 ) 
		*** nao deve olhar abatimento pois e zerado o saldo na liquidacao final do titulo
		nSaldoTit -=SomaAbat((cAliasTrb)->E2_PREFIXO,(cAliasTrb)->E2_NUM,(cAliasTrb)->E2_PARCELA,"P",1)
	EndIf
	If Abs(nSaldoTit) > 0.0001
		dDataTrab := (cAliasTrb)->E2_VENCREA
		nPosicao  := ascan(aBlocos,;	// Acha o elemento do vetor a Atualizar
						{|_vet| dDataTrab>=_vet[1] .and. dDataTrab<=_vet[2]})
		If (cAliasTrb)->E2_TIPO $ MVPAGANT+"/"+MV_CPNEG
			aBlocos[nPosicao][5] -= nSaldoTit
		Else
			aBlocos[nPosicao][5] += nSaldoTit
		Endif
	Endif
	dbSelectArea(cAliasTrb)
	dbSkip()
Enddo
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona o arquivo SE5 - Movim/o Bancario, atualizando vetor totaliz.³
//³ aBlocos, filtrando de acordo com os parametros.                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SE5")
DbSetOrder(1)
#IFDEF TOP
	aStru     := SE5->(dbStruct())
	cAliasTrb := GetNextAlias()
	cQuery := "SELECT * "
	cQuery += "FROM "+RetSqlName("SE5")+ " SE5 "
	cQuery += "WHERE "
	cQuery += "E5_FILIAL='"+xFilial("SE5")+"' AND "
	cQuery += "E5_DATA >='"+DTOS(dPesqIni)+"' AND "
	cQuery += "E5_DATA <='"+DTOS(dPesqFin)+"' AND "
	cQuery += "(E5_RECPAG = 'R' AND E5_CLIFOR >='"+MV_PAR03+"' AND E5_CLIFOR <='"+MV_PAR04+"') OR "
	cQuery += "(E5_RECPAG = 'P' AND E5_CLIFOR >='"+MV_PAR05+"' AND E5_CLIFOR <='"+MV_PAR06+"') AND "
	cQuery += "E5_NATUREZ >='"+MV_PAR07+"' AND "
	cQuery += "E5_NATUREZ <='"+MV_PAR08+"' AND "
	cQuery += "E5_TIPODOC NOT IN " + FormatIn("DC/JR/MT/CM/D2/J2/M2/C2/V2/CP/TL","/") + " AND "
	// ignora baixas automaticas com cheque, pois o proprio cheque ser  considerado
	cQuery += "NOT (E5_TIPODOC = 'BA' AND E5_NUMCHEQ <> ' ') AND "
	cQuery += "E5_SITUACA <> 'C' AND "
	cQuery += "E5_VALOR > 0 AND "
	cQuery += "SE5.D_E_L_E_T_=' ' "
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTrb,.T.,.T.)
	aEval(aStru, {|e| If(e[2]!= "C" .And. (cAliasTrb)->(FieldPos(e[1])) > 0,TCSetField(cAliasTrb, e[1], e[2],e[3],e[4]),Nil)})
#ELSE
	DbSeek(xFilial("SE5")+dtos(dPesqIni),.t.)
	cAliasTrb := "SE5"
#ENDIF	

Do While (cAliasTrb)->E5_FILIAL == xFilial("SE5") .and. (cAliasTrb)->(!eof()) .And. (cAliasTrb)->E5_DATA <= dPesqFin
	If (cAliasTrb)->E5_TIPODOC $ "DC/JR/MT/CM/D2/J2/M2/C2/V2/CP/TL"
		(cAliasTrb)->(dbSkip())
		Loop
	End
	
	// ignora baixas automaticas com cheque, pois o proprio cheque ser  considerado
	IF (cAliasTrb)->E5_TIPODOC $ "BA" .and. !Empty((cAliasTrb)->E5_NUMCHEQ)
		dbSkip()
		Loop
	Endif

	If (cAliasTrb)->E5_SITUACA = "C" .Or. (cAliasTrb)->E5_VALOR = 0 .Or. ;
		(cAliasTrb)->E5_DATA < dPesqIni .Or. (cAliasTrb)->E5_DATA > dPesqFin
		(cAliasTrb)->(DbSkip())
		Loop
	Endif
	If ( (cAliasTrb)->E5_NATUREZ < mv_par07 .Or. (cAliasTrb)->E5_NATUREZ > mv_par08 )
		(cAliasTrb)->(dbSkip())
		Loop
	EndIf
	If (cAliasTrb)->E5_RECPAG == "R"		// Carteira RECEBIDA
		IF (cAliasTrb)->E5_CLIFOR < mv_par03 .Or. (cAliasTrb)->E5_CLIFOR > mv_par04
			(cAliasTrb)->(dbSkip())
			Loop
		EndIF
		dDataTrab := (cAliasTrb)->E5_DATA
		nSaldoTit := xMoeda((cAliasTrb)->E5_VALOR,IIf(cPaisLoc # "BRA",MoedaBco((cAliasTrb)->E5_BANCO,(cAliasTrb)->E5_AGENCIA,(cAliasTrb)->E5_CONTA),1),mv_par12,,,nTxMoedBc)
		nPosicao  := ascan(aBlocos,;	// Acha o elemnento do vetor a Atualizar
						{|_vet| dDataTrab>=_vet[1] .and. dDataTrab<=_vet[2]})
		aBlocos[nPosicao][4] += nSaldoTit 
		If (cAliasTrb)->E5_RECPAG == "R" .And. (cAliasTrb)->E5_TIPODOC == "BL" 
			aBlocos[nPosicao][4] -= nSaldoTit
		EndIf	
	Else									// Carteira PAGA
		IF (cAliasTrb)->E5_CLIFOR < mv_par05 .Or. (cAliasTrb)->E5_CLIFOR > mv_par06
			(cAliasTrb)->(dbSkip())
			Loop
		EndIF

		dDataTrab := (cAliasTrb)->E5_DATA
		If mv_par14 != 2 .or. AllTrim((cAliasTrb)->E5_MOTBX) != "FAT" 
			nSaldoTit := xMoeda((cAliasTrb)->E5_VALOR,IIf(cPaisLoc # "BRA",MoedaBco((cAliasTrb)->E5_BANCO,(cAliasTrb)->E5_AGENCIA,(cAliasTrb)->E5_CONTA),1),mv_par12,,,nTxMoedBc)
			nPosicao  := ascan(aBlocos,;
							{|_vet| dDataTrab>=_vet[1] .and. dDataTrab<=_vet[2]})
			aBlocos[nPosicao][6] += nSaldoTit						
		EndIf

		If ((cAliasTrb)->E5_TIPODOC == "EP" .And. (cAliasTrb)->E5_RECPAG=="P") .Or.;// Estorno de Emprestimo				
			((cAliasTrb)->E5_TIPODOC == "PE" .And. (cAliasTrb)->E5_RECPAG=="R")		  // Estorno de pagamento de emprestimo
			aBlocos[nPosicao][6] -= nSaldoTit
		EndIf
	EndIf
	DbSelectArea(cAliasTrb)
	DbSkip()
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona o arquivo SE3 - Comiss”es de Vendas, atualizando o Vetor    ³
//³ totalizador aBlocos, caso solicitada a op‡„o Considerar Comiss”es     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par10 ==1 

	dbSelectArea("SE3")

	dbSeek(xFilial())

	Do while !Eof() .and. E3_FILIAL == xFilial()
		nSaldoTit := E3_COMIS
		dDataTrab := if(empty(E3_DATA),E3_VENCTO,E3_DATA)
		IF (nPosicao := ascan(aBlocos,{|_vet| dDataTrab>=_vet[1] ;
				.and. dDataTrab<=_vet[2]})) > 0
			If empty(E3_DATA)
				aBlocos[nPosicao][5] += nSaldoTit	// Pagar (em Aberto)
			Else
				aBlocos[nPosicao][6] += nSaldoTit	// Pagar (Realizado)
			Endif
		ENDIF
		DbSkip()
	EndDo
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime o Relatorio a partir do Vetor aBlocos...                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lPrimeiraPagina := .T.
SetRegua(mv_par02)
aImprime:= {}
nAtual:=1

Do While nAtual<= mv_par02

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa o Vetor de Impressao de um Bloco de Linhas              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aImprime:={}

	aadd(aImprime,"+----------------+")
	aadd(aImprime,"| "+padr(STR0014,14,".")+" |") // PERIODO
	aadd(aImprime,"+----------------+")
	aadd(aImprime,"| "+padr(STR0020,14,".")+" |") // RECEBER
	aadd(aImprime,"| "+padr(STR0021,14,".")+" |") // PAGAR
	aadd(aImprime,"+----------------+")

	If li+7 > 58
		cabec(Titulo,cabec1,cabec2,nomeprog,tamanho,GetMv("MV_NORM") )
		If lPrimeiraPagina
			lPrimeiraPagina := .F.
			Li++
			@LI++,00 PSAY OemToAnsi(STR0015)  //"SALDO EM CAIXA      : "
			@Prow(),Pcol()+7 PSAY nCaixas    Picture tm(nCaixas,22) //"@E 999,999,999,999,999.99"
			@LI++,00 PSAY OemToAnsi(STR0016)  //"SALDO EM BANCOS     : "
			@Prow(),Pcol()+7 PSAY nBancos    Picture tm(nBancos,22) //"@E 999,999,999,999,999.99"
			@LI++,00 PSAY OemToAnsi(STR0017)  //"SALDO EM APLICACOES : "
			@Prow(),Pcol()+7 PSAY nAplicacao Picture tm( nAplicacao,22) //"@E 999,999,999,999,999.99"
			@LI++,00 PSAY OemToAnsi(STR0018)  //"SALDO EM EMPRESTIMOS: "
			@Prow(),Pcol()+7 PSAY nEmprestimo Picture tm(nEmprestimo,22) //"@E 999,999,999,999,999.99"

			nSaldoDoDia += nCaixas
			nSaldoDoDia += nBancos
			nSaldoDoDia += nAplicacao
			nSaldoDoDia -= nEmprestimo

			@li++,00 PSAY OemToAnsi(STR0019)  //"TOTAL DO DISPONIVEL : "
			@Prow(),Pcol()+7 PSAY nSaldoDoDia Picture tm(nSaldoDoDia,22) //"@E 999,999,999,999,999.99"
			li++
		Endif
	Endif       
	If nAtual > 1
		li++				// Se ja imprimiu 1 bloco, pula uma linha
	Endif        
	Do While len(aImprime[1]) + 42 < 132 .and. nAtual<= mv_par02
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se cabe mais um bloco de dados, e ainda tem blocos a acrescentar, ³
		//³ entao acrescenta nos elementos do vetor de impress„o.             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cPeriodo := if(mv_par01=1,STR0022,; // Dia
						if(mv_par01=2,STR0023,; // Semana
						if(mv_par01=3,STR0024,STR0025))) // Quinzena ### Mes

		aImprime[1] += "---------------------------------------------------+"
		IF mv_par01=1		// Usa descricao diferenciada de cabe‡alho p/ Di rio
			aImprime[2] += " "+padr(dtoc(aBlocos[nAtual][1])+" / "+aSemana[dow(aBlocos[nAtual][1])],28)+" - "+;
								str(nAtual,2)+". "+padr(cPeriodo,15)+"|"
		Else
			aImprime[2] += " "+left(dtoc(aBlocos[nAtual][1]),6)+str(year(aBlocos[nAtual][1]),4)+STR0028+;
									left(dtoc(aBlocos[nAtual][2]),6)+str(year(aBlocos[nAtual][2]),4)+" - "+;
									str(nAtual,2)+". "+padr(cPeriodo,20)+"|"
		EndIf
		aImprime[3] += padc(">"+STR0026+"<",25,"-")+"-"+; // EM ABERTO
							padc(">"+STR0027+"<",25,"-")+"|"   // REALIZADO
		aImprime[4] += "      "+transform(aBlocos[nAtual][3],"@E 999,999,999,999.99")+" |      "+;
								transform(aBlocos[nAtual][4],"@E 999,999,999,999.99")+" |"
		aImprime[5] += "      "+transform(aBlocos[nAtual][5],"@E 999,999,999,999.99")+" |      "+;
								transform(aBlocos[nAtual][6],"@E 999,999,999,999.99")+" |"
		aImprime[6] += "-------------------------+-------------------------+"
		nAtual++
		IncRegua()
	Enddo
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime os dados da Matriz de Impress„o.                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nX:=1 to 6
		@ li++,0 PSAY aImprime[nX]
	Next
EndDo

roda(cbcont,cbtxt,"M")

Set Device To Screen
Set Filter To

dbSelectArea("SE1")
If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	ourspool(wnrel)
Endif
MS_FLUSH()
Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ RetSegund³ Autor ³ J£lio Wittwer         ³ Data ³ 12.02.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna a segunda-feira da semana da data passada como     ³±±
±±³          ³ parametro.                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_RetSegunda(<dData>)                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ dData  := Data a ser considerada                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINR840                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function RetSegunda(dDataAjusta)

IF dow(dDataAjusta)>=2				// Se passou de segunda-feira...
	Do While dow(dDataAjusta)<>2	// Volta at‚ Segunda-Feira
		dDataAjusta--
	Enddo
Else										// Sen„o avan‡a at‚ Segunda
	dDataAjusta++	
EndIf
Return dDataAjusta

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ CriaBloco³ Autor ³ J£lio Wittwer         ³ Data ³ 12.02.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna vetor inicializado para totaliza‡„o por per¡odo,   ³±±
±±³          ³ levando em conta o Tipo da Quebra, o Numero de Quebras e   ³±±
±±³          ³ o tipo de calculo da Data inicial. Obs.: Os saldos s„o     ³±±
±±³          ³ inicializados com 0 (Zero)                                 ³±±
±±³          ³ ---------+------+----------------------------------------- ³±±
±±³          ³ N§ Elem. | Tipo | Conte£do                                 ³±±
±±³          ³ ---------+------+----------------------------------------- ³±±
±±³          ³ [1]      | Data |  Data do Inicio do Periodo               ³±±
±±³          ³ [2]      | Data |  Data do Final do Periodo                ³±±
±±³          ³ [3]      | Num. |  Saldo Total a Receber em Aberto  (0)    ³±±
±±³          ³ [4]      | Num. |  Saldo Total a Receber Realizado  (0)    ³±±
±±³          ³ [5]      | Num. |  Saldo Total a Pagar em Aberto    (0)    ³±±
±±³          ³ [6]      | Num. |  Saldo Total a Pagar Realizado    (0)    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CriaBlocos(<nTipQuebra>,<nNumQuebras>,<nTipInicio>)        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ <nTipQuebra>  = Tipo da Quebra / Periodo                   ³±±
±±³          ³ 1 = Diario               2 = Semanal                       ³±±
±±³          ³ 3 = Quinzenal            4 = Mensal                        ³±±
±±³          ³ <nNumQuebras> = Numero de Periodos do Relatorio            ³±±
±±³          ³ <nTipInicio>  = Tipo do calculo da data inicial :          ³±±
±±³          ³ 1 = Data Base           2 = 1§ dia ref. ao periodo         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINR840                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CriaBlocos(nTipQuebra,nNumQuebras,nTipInicio)
Local dInicio:=dDataBase
Local nAtual,dFinal
Local aMontar:={}
IF nTipInicio == 2		// Inicio do Periodo <> Data Base
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula a Data de Inicio caso <> Data Base       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF nTipQuebra=2
		dInicio:=DataValida(U_RetSegunda(dInicio))
	ENDIF
	IF nTipQuebra=3		// Relatorio Quinzenal
		If day(dInicio)>15
			dInicio:=ctod("15/"+str(month(dInicio),2)+"/"+str(year(dInicio),4),"ddmmyy")
		Else
			dInicio:=ctod("01/"+str(month(dInicio),2)+"/"+str(year(dInicio),4),"ddmmyy")
		EndIf
	ENDIF
	IF nTipQuebra=4		// Relatorio Mensal
		dInicio:=ctod("01/"+str(month(dInicio),2)+"/"+str(year(dInicio),4),"ddmmyy")
	ENDIF
ENDIF
For nAtual := 1 to nNumQuebras
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Preenche o Vetor c/ Intervalo de Data e valores 0 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dFinal:=dInicio
	If nTipQuebra=2		// Relatorio Semanal
		dFinal += 6
	ElseIf nTipQuebra=3	// Relatorio Quinzenal
		dFinal += 14
	ElseIf nTipQuebra=4	// Relatorio Mensal
		If nTipInicio == 2
			dFinal:=LastDay(dfinal)
		Else
			dFinal += 29
		Endif
	Endif
	aadd(aMontar,{dInicio,dFinal,0,0,0,0})
	dInicio :=dFinal+1
Next

Return aMontar

