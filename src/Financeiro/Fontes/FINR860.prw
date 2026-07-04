/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR860.CH"
#Include "PROTHEUS.Ch"
#INCLUDE "DBINFO.CH"
#INCLUDE "fwcommand.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ FINR860  ³ Autor ³ Daniel Tadashi Batori ³ Data ³ 24.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relaçãoo de titulos com retenção de INSS					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FINR580(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FinR860()
Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Daniel Batori         ³ Data ³ 24.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do layout do Relatorio							  ³±±
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
Local oSection1
Local oSection11
Local oSecFil	:= Nil

oReport := TReport():New("FINR860",STR0005,"FIN860",;
{|oReport| ReportPrint(oReport)},STR0001+STR0002)

pergunte("FIN860",.F.)

oReport:SetPortrait(.T.)

oSection1 := TRSection():New(oReport,STR0024,{"TRB"},)//Clientes
TRCell():New(oSection1,"CGC_CPF",,STR0012,"@!",18,.F.,)  //definido por SetBlock
TRCell():New(oSection1,"A1_NOME","SA1",STR0013,,,.F.,)  //definido por SetBlock

oSection1:SetHeaderSection(.F.)
oSection1:SetLinesBefore(2)

oSection11 := TRSection():New(oSection1,STR0025,{"TRB"},)  //Titulos a Receber
TRCell():New(oSection11,"E1_FILORIG","SE1","Filial",,,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"E1_PREFIXO","SE1",STR0014,,,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"E1_NUM","SE1",STR0015,,,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"E1_PARCELA","SE1",STR0016,,,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"E1_TIPO","SE1",STR0017,,,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"E1_EMISSAO","SE1",STR0018,,,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"E1_VALOR","SE1",STR0019,,,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"E1_INSS","SE1",STR0020,,,.F.,)  //definido por SetBlock
TRCell():New(oSection11,"E1_SALDO","SE1",STR0021,,,.F.,)  //definido por SetBlock

/*
GESTAO - inicio TO DO STRINGS*/
/* Relacao das filiais selecionadas para compor o relatorio */
oSecFil := TRSection():New(oReport,"SECFIL",{"SE1","SED"})
TRCell():New(oSecFil,"CODFIL" ,,STR0026,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Código"
TRCell():New(oSecFil,"EMPRESA",,STR0027,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0028,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Unidade de negócio"
TRCell():New(oSecFil,"NOMEFIL",,STR0029,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Filial"
/* GESTAO - fim
*/

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Daniel Batori          ³ Data ³24/07/2006³±±
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
*/
Static Function ReportPrint(oReport)
Local oSection1		:= oReport:Section(1)
Local oSection11	:= oReport:Section(1):Section(1)
Local cAliasQry1	:= GetNextAlias()
Local nCont			:= 0
Local nSecao		:= 0
Local nTotal		:= 0
//Gestao
Local nRegSM0		:= SM0->(Recno())
Local lGestao		:= FWSizeFilial() > 2	// Indica se usa Gestao Corporativa
Local lSE1Access	:= Iif( lGestao, FWModeAccess("SE1",1) == "E", FWModeAccess("SE1",3) == "E")
Local aSelFil		:= {}
Local aTmpFil		:= {}
Local cTmpSE1Fil	:= ""
Local cTmpSA1Fil	:= ""
Local nX			:= 0
Local cFilAtu		:= cFilAnt
Local cRngFilSE1	:= ""
Local cRngFilSA1	:= ""
Local cQueryFil		:= ""
Local cQuery		:= ""
Local oSecFil		:= oReport:Section("SECFIL")
Local cFilterUser	:= ""
Local cSGBD         := Upper(TCGetDB())
Local lBancoA		:= cSGBD $'ORACLE.DB2.INFORMIX'

//Gestao
nRegSM0 := SM0->(Recno())
If mv_par07 == 1 .AND. lSE1Access 	//filial nao totalmente compartilhada  //TO DO
	aSelFil := FwSelectGC()
Endif
If Empty(aSelFil)
	aSelFil := {cFilAnt}
Endif
SM0->(DbGoTo(nRegSM0))

If Len(aSelFil) > 1
	cRngFilSE1 := GetRngFil( aSelFil, "SE1", .T., @cTmpSE1Fil )
	aAdd(aTmpFil, cTmpSE1Fil)
	cRngFilSA1 := GetRngFil( aSelFil, "SA1", .T., @cTmpSA1Fil )
	aAdd(aTmpFil, cTmpSA1Fil)

	// Imprime a lista de filiais selecionadas para o relatorio
	aSM0 := FWLoadSM0()
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	cTitulo := oReport:Title()
	oReport:SetTitle(cTitulo + " (" + STR0030 + ")")		//"Filiais selecionadas para o relatorio"
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
	oReport:EndPage()
Endif

dbSelectArea("SE1")
dbSetorder(2)

cFilterUser := SE1->(oSecFIL:GetSqlExp("SE1"))

If Len(aSelFil) > 1
	If FWModeAccess("SA1",3) == "E" .AND. FWModeAccess("SE1",3) == "E" 
		cQueryFil += " SE1.E1_FILIAL = SA1.A1_FILIAL   AND "
		cQueryFil += " SA1.A1_FILIAL "+ cRngFilSA1 + " AND "	
	ElseIf FWModeAccess("SA1",3) == "C" .AND. FWModeAccess("SE1",3) == "E" .And.  FWModeAccess("SA1",2) == "E"//Filial SA1-Compartilhada/Filial SE1-exclusiva/Unidade SA1-Exclusiva
		cQueryFil += " RTRIM(SUBSTRING(A1_FILIAL, 1, " + Str(nTamEmp + nTamUnNeg) + ") ) = RTRIM(SUBSTRING(E1_FILORIG, 1, " + Str(nTamEmp + nTamUnNeg) + ") )  AND"
	ElseIf  FWModeAccess("SE1",3) == "E" .And.  FWModeAccess("SA1",1) == "E" .And. FWModeAccess("SA1",2) == "C" .And. FWModeAccess("SA1",3) == "C" //Filial SA1-Compartilhada/Filial SE1-exclusiva/Unidade SA1-Compartilhada/Empresa SA1-Exclusiva 
	 	cQueryFil += " RTRIM(SUBSTRING(A1_FILIAL, 1, " + Str(nTamEmp) + ") ) = RTRIM(SUBSTRING(E1_FILORIG, 1, " + Str(nTamEmp) + ") ) AND "
	Else
		cQueryFil += " SE1.E1_FILIAL "+ cRngFilSE1 + " AND "
		cQueryFil += " SA1.A1_FILIAL "+ cRngFilSA1 + " AND "
	Endif
Else
	cQueryFil += " SE1.E1_FILIAL = '"+ xFilial("SE1",aSelFil[1]) + "' AND "
	cQueryFil += " SA1.A1_FILIAL = '"+ xFilial("SA1",aSelFil[1]) + "' AND "
Endif

If lBancoA //banco oracle-db2-informix
    cQueryFil := StrTran(cQueryFil,"SUBSTRING","SUBSTR")
EndiF

If !Empty(mv_par08) .AND. mv_par08 == 2
	cQuery += " AND SE1.E1_TIPOLIQ = '' "
EndIf

If !Empty(cFilterUser)
	cQuery += " AND " + cFilterUser
EndIf

cQuery += " ORDER BY E1_CLIENTE,E1_LOJA,E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO"
cQueryFil := "%" + cQueryFil + "%"
cQuery := "%" + cQuery + "%"


oSection1:BeginQuery()
	BeginSql Alias cAliasQry1
		SELECT A1_NOME, A1_CGC, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, E1_EMISSAO,E1_VALOR, E1_INSS, E1_FILORIG
		FROM %table:SE1% SE1, %table:SA1% SA1
		WHERE
		%exp:cQueryFil%
		SE1.E1_CLIENTE = SA1.A1_COD AND
		SE1.E1_LOJA	 = SA1.A1_LOJA AND
		SE1.E1_CLIENTE BETWEEN %exp:mv_par01% AND %exp:mv_par02% AND
		SE1.E1_LOJA    BETWEEN %exp:mv_par03% AND %exp:mv_par04% AND
		SE1.E1_INSS > 0 AND
		SE1.E1_EMISSAO between %exp:mv_par05% AND %exp:mv_par06% AND
		SE1.E1_EMISSAO <= %exp:dDataBase% AND
		SE1.%NotDel% AND
		SA1.%NotDel%
		%exp:cQuery%
	EndSQL
oSection1:EndQuery()

oSection11:SetParentQuery()

oSection11:SetParentFilter({|cParam| (cAliasQry1)->A1_CGC == cParam},{|| (cAliasQry1)->A1_CGC })

oSection1:Cell("CGC_CPF"):SetBlock( { || If(Len(AllTrim((cAliasQry1)->A1_CGC))==11, ;
														PadR(Transform((cAliasQry1)->A1_CGC,"@R 999.999.999-99"),18), ;
														Transform((cAliasQry1)->A1_CGC,"@R 99.999.999/9999-99") ) })
oSection1:Cell("A1_NOME"):SetBlock( { || (cAliasQry1)->A1_NOME })

oSection11:Cell("E1_FILORIG"):SetBlock(	{ || nCont++,(cAliasQry1)->E1_FILORIG }) // a variavel nCont serve para totalizar o numero de titu
oSection11:Cell("E1_PREFIXO"):SetBlock(	{ || (cAliasQry1)->E1_PREFIXO }) // a variavel nCont serve para totalizar o numero de tituloslos
oSection11:Cell("E1_NUM"):SetBlock(			{ || (cAliasQry1)->E1_NUM })
oSection11:Cell("E1_PARCELA"):SetBlock(	{ || (cAliasQry1)->E1_PARCELA })
oSection11:Cell("E1_TIPO"):SetBlock(		{ || (cAliasQry1)->E1_TIPO })
oSection11:Cell("E1_EMISSAO"):SetBlock(	{ || (cAliasQry1)->E1_EMISSAO })
oSection11:Cell("E1_VALOR"):SetBlock(		{ || (cAliasQry1)->E1_VALOR })
oSection11:Cell("E1_INSS"):SetBlock(		{ || (cAliasQry1)->E1_INSS })
oSection11:Cell("E1_SALDO"):SetBlock(		{ || (cAliasQry1)->(E1_VALOR-E1_INSS) })

oSection1:Cell("CGC_CPF"):SetObfuscate( RetGlbLGPD('A1_CGC') )

TRFunction():New(oSection11:Cell("E1_VALOR")	,"T_VALOR","SUM",,,,,.T.,.T.)
TRFunction():New(oSection11:Cell("E1_INSS")		,"T_INSS" ,"SUM",,,,,.T.,.T.)
TRFunction():New(oSection11:Cell("E1_SALDO")	,"T_SALDO","SUM",,,,,.T.,.T.)

oSection11:SetTotalInLine(.F.)
oSection11:SetHeaderPage(.T.)
oReport:SetTotalInLine(.F.)

oSection11:SetTotalText	({ || nSecao:=nCont, nTotal+=nCont, nCont:=0 ,  STR0022 + "  ( " + AllTrim(Str(nSecao)) + " " + If(nSecao > 1, STR0008, STR0009) + " )" } )
oReport:SetTotalText		({ || STR0023 + "  ( " + AllTrim(Str(nTotal)) + " " + If(nTotal > 1, STR0008, STR0009) + " )" } )

oSection1:Print()

Return
