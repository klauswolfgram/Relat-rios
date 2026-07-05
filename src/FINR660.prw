/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR660.CH"
#Include "PROTHEUS.cH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR660  ³ Autor ³ Daniel Batori         ³ Data ³ 05/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impress„o do Arquivo de Envio de Titulos ao Banco  - SE1    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FINR660()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR660()

Local oReport

If TRepInUse()
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	Return U_FINR660R3() // Executa versão anterior do fonte
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Daniel Batori         ³ Data ³ 05/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impress„o do Arquivo de Envio de Titulos ao Banco  - SE1   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport
Local oSection, oSection1
Local oBreak
Local cAliasQry := GetNextAlias()
Local cTmpE5	:= GetNextAlias()
Local cAliasSA6 := "SA6"

oReport := TReport():New("FINR660",OemToAnsi(STR0004),"FIN660",; //"Registro de Apuração de Antecipação"
{|oReport| ReportPrint(oReport,@cAliasQry,cAliasSA6, @cTmpE5)},OemToAnsi(STR0001)+OemToAnsi(STR0002)+OemToAnsi(STR0003)) 

pergunte("FIN660",.F.)

oSection := TRSection():New(oReport,STR0015,{"SE1"})
oSection1:= TRSection():New(oReport,"Valor IOF",{"SE5"})

// obloco de codigo esta definido no report print
TRCell():New(oSection,"E1_NUMBOR"    ,"SE1",,,,.F.,{|| (cAliasQry)->E1_NUMBOR })
TRCell():New(oSection,"E1_DATABOR"   ,"SE1",,,,.F.,{|| (cAliasQry)->E1_DATABOR })
TRCell():New(oSection,"E1_PREFIXO"   ,"SE1",,,,.F.,{|| (cAliasQry)->E1_PREFIXO })
TRCell():New(oSection,"E1_NUM"       ,"SE1",,,,.F.,{|| (cAliasQry)->E1_NUM })
TRCell():New(oSection,"E1_PARCELA"   ,"SE1",,,,.F.,{|| (cAliasQry)->E1_PARCELA})
TRCell():New(oSection,"E1_TIPO"      ,"SE1",,,,.F.,{|| (cAliasQry)->E1_TIPO})
TRCell():New(oSection,"E1_NATUREZ"  ,"SE1",,,,.F.,{|| (cAliasQry)->E1_NATUREZ})
TRCell():New(oSection,"A6_NREDUZ"    ,"SA6",,,,.F.,{|| (cAliasSA6)->A6_NREDUZ})
TRCell():New(oSection,"E1_AGEDEP"    ,"SE1",,,,.F.,{|| (cAliasQry)->E1_AGEDEP})
TRCell():New(oSection,"E1_HIST"      ,"SE1",,,,.F.,{|| SubStr((cAliasQry)->E1_HIST,1,25)})
TRCell():New(oSection,"EB_DESCRI"    ,"SEB",,,,.F.,{|| Iif(!Empty(SEB->EB_DESCRI),SEB->EB_DESCRI,OemToAnsi(STR0009))})
TRCell():New(oSection,"E1_MOEDA"     ,"SE1",,,,.F.,{||GetMv("MV_MOEDA"+AllTrim(STR((cAliasQry)->E1_MOEDA,2)))})
TRCell():New(oSection,"SITUACA0"     ,,STR0016,"@!",15,.F.,{|| Substr(FN022SITCB((cAliasQry)->E1_SITUACA)[9],1,20) })		//"Situação Título"
TRCell():New(oSection,"E1_NUMBCO"    ,"SE1",,,,.F.,{|| (cAliasQry)->E1_NUMBCO})
TRCell():New(oSection,"E1_CLIENTE"   ,"SE1",,,,.F.,{|| (cAliasQry)->E1_CLIENTE})
TRCell():New(oSection,"E1_LOJA"      ,"SE1",,,,.F.,{|| (cAliasQry)->E1_LOJA})
TRCell():New(oSection,"E1_NOMCLI"    ,"SE1",,,,.F.,{|| (cAliasQry)->E1_NOMCLI})
TRCell():New(oSection,"E1_EMISSAO"   ,"SE1",,,,.F.,{|| (cAliasQry)->E1_EMISSAO})
TRCell():New(oSection,"E1_VENCREA"   ,"SE1",,,,.F.,{|| (cAliasQry)->E1_VENCREA})
TRCell():New(oSection,"E1_SALDO"     ,"SE1",,Tm(SE1->E1_SALDO,14),,.F.,)       								// o bloco de codigo esta definido no report print
TRCell():New(oSection,"E1_IRRF"      ,"SE1",,Tm(SE1->E1_IRRF,14),,.F.,   {||(cAliasQry)->E1_IRRF})
TRCell():New(oSection,"E1_ISS"       ,"SE1",,Tm(SE1->E1_ISS,14),,.F.,    {||(cAliasQry)->E1_ISS})  
TRCell():New(oSection,"E1_INSS"      ,"SE1",,Tm(SE1->E1_INSS,14),,.F.,   {||(cAliasQry)->E1_INSS})
TRCell():New(oSection,"E1_PIS"       ,"SE1",,Tm(SE1->E1_PIS,14),,.F.,    {||(cAliasQry)->E1_PIS})
TRCell():New(oSection,"E1_COFINS"    ,"SE1",,Tm(SE1->E1_COFINS,14),,.F., {||(cAliasQry)->E1_COFINS})  
TRCell():New(oSection,"E1_CSLL"      ,"SE1",,Tm(SE1->E1_CSLL,14),,.F.,   {||(cAliasQry)->E1_CSLL})       // obloco de codigo esta definido no report print
TRCell():New(oSection,"E1_VALJUR"    ,"SE1",,,,.F.,                       {|| If(!empty( (cAliasQry)->E1_VALJUR ),(cAliasQry)->E1_VALJUR,(cAliasQry)->E1_PORCJUR)})   // obloco de codigo esta definido no report print
TRCell():New(oSection,"VALOR_MOEDA"  ,,"Vlr.Moeda Nacional",Tm(SE1->E1_VLCRUZ,14),,.F.,)     // obloco de codigo esta definido no report print

// Para armazenar o valor total do IOF
TRCell():New(oSection1,"IOF"    	,"SE5","Vlr. IOF",,18,.F.,{|| "Valor total do IOF: Borderô: "+mv_par01 })
TRCell():New(oSection1,"VALOR_IOF" ,"SE5",,Tm(SE5->E5_VALOR,14),,.F.,{|| (cTmpE5)->E5_VALOR })


TRFunction():New(oSection:Cell("E1_SALDO")    ,"TOTAL1","SUM",,,,,.F.,.T.,.F.)
TRFunction():New(oSection:Cell("E1_IRRF")     ,"TOTAL2","SUM",,,,,.F.,.T.,.F.)
TRFunction():New(oSection:Cell("E1_ISS")      ,"TOTAL3","SUM",,,,,.F.,.T.,.F.)
TRFunction():New(oSection:Cell("E1_INSS")     ,"TOTAL4","SUM",,,,,.F.,.T.,.F.)
TRFunction():New(oSection:Cell("E1_PIS")      ,"TOTAL5","SUM",,,,,.F.,.T.,.F.)
TRFunction():New(oSection:Cell("E1_COFINS")   ,"TOTAL6","SUM",,,,,.F.,.T.,.F.)                                                            
TRFunction():New(oSection:Cell("E1_CSLL")     ,"TOTAL7","SUM",,,,,.F.,.T.,.F.)
TRFunction():New(oSection:Cell("VALOR_MOEDA") ,"TOTAL8","SUM",,,,,.F.,.T.,.F.)

oSection1:SetHeaderSection(.F.)

oReport:SetTotalInLine(.F.)
oSection:SetLineBreak()

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Daniel Batori          ³ Data ³05/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport, cAliasQry, cAliasSA6, cTmpE5 )
Local cDesOco	:= ""
Local cDesSit	:= ""
Local nTotPIS	:= 0
Local nTotCOF	:= 0
Local nTotCSLL	:= 0
Local nAbatim	:= 0
Local cQuery	:= ""
Local cGem		:= "%%"
Local cFiltro	:= ""
Local oSection := oReport:Section(1)

#IFDEF TOP                
                     
	MakeSqlExpr(oReport:uParam)

	oSection:BeginQuery()

	cQuery := " AND SE1.E1_TIPO NOT IN "+FormatIN(MVRECANT+"/"+MVPROVIS,"/") 
	cQuery += " AND SE1.E1_NUMBOR = '"  + mv_par01 + "' "

	If mv_par02 == 2 
		cQuery += " AND SE1.E1_SALDO > 0 "
	Endif 
                   
	cQuery := "%" + cQuery + "%"

	// Se titulo do Template GEM
	If HasTemplate("LOT") .And. SE1->(FieldPos("E1_NCONTR")) > 0
		cGem := "%, E1_NCONTR %"
	EndIf

	BeginSql Alias cAliasQry
		SELECT	E1_FILIAL, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, 
					E1_NATUREZ, E1_AGEDEP, E1_EMISSAO, E1_VENCREA, E1_NUMBOR, 
					E1_DATABOR, E1_SALDO, E1_IRRF, E1_ISS, E1_INSS, E1_VLCRUZ, 
					E1_VALJUR, E1_PORCJUR, E1_CLIENTE, E1_LOJA, E1_HIST, E1_MOEDA, E1_CONTA, 
					E1_NUMBCO, E1_PORTADO, E1_OCORREN, E1_SITUACA, E1_SALDO, E1_NOMCLI, 
					E1_PIS, E1_COFINS, E1_CSLL, E1_ACRESC, E1_DECRESC, 
					A1_FILIAL, A1_COD, A1_LOJA, A1_NREDUZ
					%Exp:cGem%
		FROM %table:SE1% SE1, %table:SA1% SA1 
		WHERE SE1.E1_FILIAL = %xFilial:SE1% AND 
				SA1.A1_FILIAL = %xFilial:SA1% AND 
				SE1.E1_CLIENTE = SA1.A1_COD AND 
				SE1.E1_LOJA    = SA1.A1_LOJA AND 
				SA1.%NotDel% AND
				SE1.%NotDel%       
				%Exp:cQuery%
	EndSql

	oSection:EndQuery(/*ExpA1*/)	
	
#ELSE
	cAliasQry := "SE1"
	
	dbSelectArea(cAliasQry)
	dbSetorder(5)
		
	//Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
	MakeAdvplExpr(oReport:uParam)
	
	//Adiciona no filtro o parametro tipo Range
	cFiltro := ' E1_FILIAL == "' + xFilial(cAliasQry) + '"'
	cFiltro += ' .And. ! (E1_TIPO $ '+FormatIN(MVRECANT+"/"+MVPROVIS,"/") + ")"
	cFiltro += ' .And. E1_NUMBOR = "'  + mv_par01 + '"'
	
	oSection:SetFilter(cFiltro,(cAliasQry)->(IndexKey()))
		
#ENDIF

oSection:Cell("E1_SALDO"):SetBlock( {|| nAbatim := SomaAbat((cAliasQry)->E1_PREFIXO,(cAliasQry)->E1_NUM,(cAliasQry)->E1_PARCELA,"R",(cAliasQry)->E1_MOEDA,,(cAliasQry)->E1_CLIENTE,(cAliasQry)->E1_LOJA,,,(cAliasQry)->E1_TIPO),;
													  CalcSaldo(nAbatim,cAliasQry,.F. ) } )

oSection:Cell("VALOR_MOEDA"):SetBlock( {|| CalcSaldo(nAbatim,cAliasQry,.T. ) } )

TRPosition():New(oSection, "SA6", 1, {|| xFilial("SA6")+(cAliasQry)->(E1_PORTADO+E1_AGEDEP+E1_CONTA)         }, .T. )
TRPosition():New(oSection, "SEB", 1, {|| xFilial("SEB")+(cAliasQry)->(E1_PORTADO+Substr(E1_OCORREN,1,2)+" E")}, .T. )
TRPosition():New(oSection, "FRV", 1, {|| xFilial("FRV")+(cAliasQry)->E1_SITUACA}, .T. )	//SITCOB

oSection:SetHeaderPage(.T.)

oSection:Print()
oSection:Finish()
/* Imprime valor do IOF */
F660ValIOF(oReport,cTmpE5)

Return
   
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CalcSaldo  ³ Autor ³Daniel Batori          ³ Data ³22/10/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Calcula o saldo do titulo                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³nAbatim   : valor a ser abatido do titulo                    ³±±
±±³          ³cAliasQry : alias da tabela em uso                           ³±±
±±³          ³lNacional : altera para moeda nacional?                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Valor do saldo do titulo                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CalcSaldo(nAbatim,cAliasQry,lNacional)
Local nSaldo    := 0
Local aAuxGem   := {}
If lNacional
	nSaldo := (cAliasQry)->E1_SALDO - nAbatim+ (cAliasQry)->E1_ACRESC - (cAliasQry)->E1_DECRESC
Else
	If (cAliasQry)->E1_MOEDA > 1
		nSaldo := Round(NoRound(xMoeda((cAliasQry)->E1_SALDO - nAbatim,(cAliasQry)->E1_MOEDA,1,,3),3),2)	 + (cAliasQry)->E1_ACRESC - (cAliasQry)->E1_DECRESC
	Else
		nSaldo := (cAliasQry)->E1_SALDO - nAbatim + (cAliasQry)->E1_ACRESC - (cAliasQry)->E1_DECRESC
	Endif
EndIf

// Se titulo do Template Gem
If HasTemplate("LOT") .And. (cAliasQry)->(FieldPos("E1_NCONTR"))>0 .And. !Empty((cAliasQry)->E1_NCONTR)
	aAuxGem := ExecTemplate("CMDtPrc",.F.,.F.,{(cAliasQry)->E1_PREFIXO,(cAliasQry)->E1_NUM,(cAliasQry)->E1_PARCELA,(cAliasQry)->E1_VENCREA,(cAliasQry)->E1_VENCREA})
    nSaldo  += aAuxGem[2]
Endif

Return nSaldo




/*
---------------------------------------------------------- RELEASE 3 ---------------------------------------------
*/



                                                                          



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Finr660R3³ Autor ³ Wagner Xavier         ³ Data ³ 06/07/94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impress„o do Arquivo de Envio de Titulos ao Banco  - SE1   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Finr660R3()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Finr660R3
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local wnrel
Local cDesc1 := STR0001  //'Este programa tem como objetivo imprimir os dados'
Local cDesc2 := STR0002  //'que ser„o utilizados para o Envio da Comunica‡„o'
Local cDesc3 := STR0003  // 'Banc ria".'
Local cString := "SE1"
Local Tamanho := "G"

PRIVATE cTitulo:= OemToAnsi(STR0004)  //"Impressao do Envio da Comunicacao Bancaria"
PRIVATE cabec1
PRIVATE cabec2
Private aReturn := { OemToAnsi(STR0005), 1,OemToAnsi(STR0006), 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
Private cPerg   := "FIN660"
Private nomeprog:= "finr660" 
Private nLastKey:=0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variavel utilizada para parametro                            ³
//³ mv_par01            // No. do Bordero                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cabec1:= OemToAnsi(STR0007) //"  No.Bordero  Dt.Bordero  Prf-Numero-Parc.  Tipo    Natureza    Nome do Banco   Agen. Historico                Ocorrencia CNAB                Moeda do Titulo  Situacao do Titulo   Nosso Numero  "
cabec2:= OemToAnsi(STR0008) //"  Codigo do Cliente         Nome do Cliente         Emissao    Vencto.    Saldo Titulo   Valor IRRF          Valor ISS     Valor INSS      Valor PIS   Valor COFINS     Valor CSLL  Juros Vlr.Moeda Nacional"
							//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
							//                   10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       2200


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "FINR660"
wnrel := SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho,,.F.)

If nLastKey == 27
   Return
End

SetDefault(aReturn,cString)

If nLastKey == 27
   Return ( NIL )
End

RptStatus({|lEnd| Fa660Imp(@lEnd,wnRel,cString)},cTitulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³ FA660Imp ³ Autor ³ Lu¡s C. Cunha         ³ Data ³ 05/11/93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Retorno Cnab                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³ FA660Imp(lEnd,wnRel,cString                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGAFIN                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FA660Imp(lEnd,wnRel,cString)
Local cbcont,cbtxt
Local tamanho:= "G"
Local cDesOco,cDesSit
Local nTotTit:=0
Local nTotIRF:=0
Local nTotISS:=0
Local nTotINSS:=0
Local nTotREAL:=0
Local nTipo
Local nSaldoT := 0  // Saldo na moeda do titulo
Local nSaldoR := 0  // Saldo em real na database da emissão do relatorio
Local nTotPIS  := 0
Local nTotCOF  := 0
Local nTotCSLL := 0
Local nAbatim := 0
Local nAux := 0
Local aAuxGem   := {}

#IFDEF TOP
	Local cQuery
	Local aStru := SE1->(dbStruct())
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

nTipo:=Iif(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM"))

#IFDEF TOP
	If TcSrvType() != "AS/400"
		cQuery := "SELECT	E1_FILIAL, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, "
		// Se titulo do Template GEM
		If HasTemplate("LOT") .And. SE1->(FieldPos("E1_NCONTR")) > 0
			cQuery += " E1_NCONTR, "
		EndIf
		cQuery += "			E1_NATUREZ, E1_AGEDEP, E1_EMISSAO, E1_VENCREA, E1_NUMBOR,E1_TITPAI, "
		cQuery += "			E1_DATABOR, E1_SALDO, E1_IRRF, E1_ISS, E1_INSS, E1_VLCRUZ, "
		cQuery += "			E1_VALJUR, E1_PORCJUR, E1_CLIENTE, E1_LOJA, E1_HIST, E1_MOEDA, E1_CONTA, "
		cQuery += "			E1_NUMBCO, E1_PORTADO, E1_OCORREN, E1_SITUACA, E1_SALDO, E1_NOMCLI, "
		cQuery += "			E1_PIS, E1_COFINS, E1_CSLL, E1_ACRESC, E1_DECRESC, "
		cQuery += "			A1_FILIAL, A1_COD, A1_LOJA, A1_NREDUZ "
		cQuery += " FROM " +	RetSqlName("SE1")+" SE1, "
		cQuery +=          +	RetSqlName("SA1")+" SA1 "
		cQuery += "	WHERE SE1.E1_FILIAL = '"+xFilial("SE1")+"' AND "
		cQuery += " 		SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND "
		cQuery += " 		SE1.E1_CLIENTE = SA1.A1_COD  AND "
		cQuery += " 		SE1.E1_LOJA    = SA1.A1_LOJA AND "
		cQuery += " 		SE1.E1_NUMBOR = '"+ mv_par01 + "' AND "
		cQuery += " 		SE1.E1_TIPO NOT IN "+FormatIN(MVRECANT+"/"+MVPROVIS,"/") + " AND "
		If mv_par02 == 2 
			cQuery += " 		SE1.E1_SALDO > 0 AND "
		Endif
		cQuery += "			SE1.D_E_L_E_T_ <> '*' AND "
		cQuery += "			SA1.D_E_L_E_T_ <> '*'"
		cQuery := ChangeQuery(cQuery)
		
		DbSelectArea("SE1")
		DbCloseArea()
		
      dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"SE1",.T.,.T.)
		aEval(aStru, {|e| If(e[2]!= "C" .And. SE1->(FieldPos(e[1])) > 0, TCSetField("SE1", e[1], e[2],e[3],e[4]),Nil)})
	Else
#ENDIF
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona no Bordero Informado pelo usuario                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SE1")
		dbSetorder(5)
		MsSeek(xFilial("SE1")+mv_par01)
#IFDEF TOP
	Endif
#ENDIF

If !Eof()	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia a leitura do arquivo de Titulos                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SE1")
	SetRegua(RecCount())
	
	While !SE1->(Eof()) .And. SE1->E1_FILIAL==xFilial("SE1") .And.;
			SE1->E1_NUMBOR==mv_par01
		
		IncRegua()
	
		IF Empty(SE1->E1_NUMBOR) .Or. ;
			(mv_par02 == 2 .And. SE1->E1_SALDO == 0)
			SE1->( dbSkip() )
			Loop
		Endif
	
		IF SE1->E1_TIPO $ MVRECANT+"/"+MVPROVIS
			SE1->( dbSkip() )
			Loop
		EndIF
	
		#IFNDEF TOP
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 			//³ Posiciona no Cliente                                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SA1")
		   dbSeek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA)
		#ENDIF
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona no Banco                                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SA6")
		dbSeek(xFilial("SA6")+SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona nas Ocorrencias da Transmissao Banc ria            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SEB")
	   If (dbSeek(xFilial("SEB")+SE1->E1_PORTADO+Substr(SE1->E1_OCORREN,1,2)+" E"))
			cDesOco:= SEB->EB_DESCRI
		Else
			cDesOco:= OemToAnsi(STR0009)  //"OCORRENCIA NAO ENCONTRADA"
	   End
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona no Arquivo de Tabelas                              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cDesSit:= Substr(FN022SITCB(SE1->E1_SITUACA)[9],1,20)

		If Empty(cDesSit)
			cDesSit:= OemToAnsi(STR0010)  //"SIT. NAO ENCONTRADA"
		Endif
	
		dbSelectArea("SE1")
	
		IF li > 58
			cabec(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		End
		
		nAbatim := SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",SE1->E1_MOEDA,,SE1->E1_CLIENTE,SE1->E1_LOJA,,,SE1->E1_TIPO)
		
		If SE1->E1_MOEDA > 1
			nSaldoT := Round(NoRound(xMoeda(SE1->E1_SALDO - nAbatim,SE1->E1_MOEDA,1,,3),3),2)	+ SE1->E1_ACRESC - SE1->E1_DECRESC
		Else
			nSaldoT := SE1->E1_SALDO - nAbatim + SE1->E1_ACRESC - SE1->E1_DECRESC
		Endif

		nSaldoR := SE1->E1_SALDO - nAbatim + SE1->E1_ACRESC - SE1->E1_DECRESC

		// Se titulo do Template GEM (tirulos do GEM sempre estao em real)
 		If HasTemplate("LOT") .And. SE1->(FieldPos("E1_NCONTR"))>0 .And. !Empty(SE1->E1_NCONTR)
			aAuxGem := ExecTemplate("CMDtPrc",.F.,.F.,{SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_VENCREA,SE1->E1_VENCREA})
            nAux := aAuxGem[2]
			nSaldoT += nAux
			nSaldoR += nAux
		Endif

		@li,002 PSAY SE1->E1_NUMBOR
		@li,014 PSAY SE1->E1_DATABOR
		@li,026 PSAY SE1->E1_PREFIXO
		@li,029 PSAY '-' + RTrim(SE1->E1_NUM) + Iif( ! Empty(SE1->E1_PARCELA), "-", "") + SE1->E1_PARCELA
		@li,049 PSAY SE1->E1_TIPO
		@li,055 PSAY SE1->E1_NATUREZ
		@li,066 PSAY SA6->A6_NREDUZ
		@li,082 PSAY SE1->E1_AGEDEP
		@li,088 PSAY SubStr(SE1->E1_HIST,1,25)
		@li,113 PSAY cDesOco
		@li,144 PSAY GetMv("MV_MOEDA"+AllTrim(STR(SE1->E1_MOEDA,2)))
		@li,161 PSAY cDesSit
		@li,182 PSAY SE1->E1_NUMBCO
		li++
	
		@li,002 PSAY SE1->E1_CLIENTE
		@li,023 PSAY SE1->E1_LOJA
		@li,028 PSAY SE1->E1_NOMCLI
		@li,052 PSAY SE1->E1_EMISSAO
		@li,063 PSAY SE1->E1_VENCREA
		@li,074 PSAY nSaldoT Picture Tm(SE1->E1_SALDO,14)
		@li,089 PSAY SE1->E1_IRRF	Picture Tm(SE1->E1_IRRF,14)
		@li,104 PSAY SE1->E1_ISS	Picture Tm(SE1->E1_ISS,14)
		@li,119 PSAY SE1->E1_INSS	Picture Tm(SE1->E1_INSS,14)
		@li,134 PSAY SE1->E1_PIS	Picture Tm(SE1->E1_PIS,14)
		@li,149 PSAY SE1->E1_COFINS Picture Tm(SE1->E1_COFINS,14)
		@li,164 PSAY SE1->E1_CSLL	Picture Tm(SE1->E1_CSLL,14)
	
		If !empty( SE1->E1_VALJUR )
			@li,179 PSAY SE1->E1_VALJUR Picture "@E 999.99"
		Else
			@li,179 PSAY SE1->E1_PORCJUR  Picture "@E 999.99"
		Endif
		@li,186 PSAY nSaldoR Picture Tm(nSaldoR,14)
	
		li++
		@li,000 PSAY replicate('-',220)
		li++
	   If E1_TIPO $ MVABATIM
	      nTotTit  -= nSaldoT
	      nTotIRF  -= SE1->E1_IRRF
	      nTotISS  -= SE1->E1_ISS
	      nTotINSS -= SE1->E1_INSS
	      nTotPIS  -= SE1->E1_PIS
	      nTotCOF  -= SE1->E1_COFINS
	      nTotCSLL -= SE1->E1_CSLL
	      nTotREAL -= nSaldoR
	   Else
	      nTotTit  += nSaldoT
	      nTotIRF  += SE1->E1_IRRF
	      nTotISS  += SE1->E1_ISS
	      nTotINSS += SE1->E1_INSS
	      nTotPIS  += SE1->E1_PIS
	      nTotCOF  += SE1->E1_COFINS
	      nTotCSLL += SE1->E1_CSLL
	      nTotREAL += nSaldoR
	   Endif
		dbSelectArea("SE1")
		SE1->(dbSkip( ))
	End
	
	IF li != 80
		li++
		@ li,000 PSAY OemToAnsi(STR0011)  //"Total dos Titulos : "
		@ li,074 PSAY nTotTit	Picture TM(nTotTit,14) 
		@ li,089 PSAY nTotIRF	Picture Tm(nTotIRF,14)
		@ li,104 PSAY nTotISS	Picture Tm(nTotISS,14)
		@ li,119 PSAY nTotINSS	Picture Tm(nTotINSS,14)
		@ li,134 PSAY nTotPIS	Picture Tm(nTotPIS,14)
		@ li,149 PSAY nTotCOF	Picture Tm(nTotCOF,14)
		@ li,164 PSAY nTotCSLL	Picture Tm(nTotCSLL,14)
		@ li,186 PSAY nTotREAL	Picture Tm(nTotREAL,14)
		roda(cbcont,cbtxt,tamanho)
	End
Else
	Help(" ",1,"BORD150")
Endif

#IFDEF TOP
	If TcSrvType() != "AS/400"
		dbSelectArea("SE1")
		dbCloseArea()
		ChKFile("SE1")
	Endif
#ENDIF
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera a Integridade dos dados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SE1")
dbSetOrder(1)

dbClearFilter()
Set Device To Screen

If aReturn[5] = 1
   Set Printer To
	dbCommitAll()
   OurSpool(wnrel)
Endif
MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³ F660ValIOF ³ Autor ³ igor.nascimento     ³ Data ³ 22/06/16 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Retorna valor do IOF do documento (bordero)                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³ F660ValIOF()				                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGAFIN                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function F660ValIOF(oReport,cTmpE5)
Local cDocumen := mv_par01
Local cQuery	 := ""
Local oSection1:= oReport:Section(2)
Default cTmpE5	 := "SE5"

cQuery := "SELECT E5_VALOR "
cQuery += "FROM "+RetSqlName("SE5")
cQuery += "WHERE "
cQuery += "E5_FILIAL = '" + xFilial("SE5") + "' "
cQuery += "AND E5_TIPODOC = 'I2' "
cQuery += "AND E5_DOCUMEN = '" + cDocumen + "' "
cQuery += "AND D_E_L_E_T_ = ''"
cQuery := ChangeQuery(cQuery)
dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cTmpE5, .T., .T.)

dbSelectArea(cTmpE5)

oSection1:Init()
oSection1:PrintLine()
oSection1:Finish()

(cTmpE5)->(dbClearFilter())
(cTmpE5)->(dbCloseArea())
MsErase(cTmpE5)

Return
