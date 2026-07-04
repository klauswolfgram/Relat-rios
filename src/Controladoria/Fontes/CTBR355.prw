/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CTBR355.ch"
#Include "PROTHEUS.Ch"
    
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR355  ³ Autor ³Felipe c. Cunha        ³ Data ³ 01.01.12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Lancamentos                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ CTBR355                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CTBR355()

Local oReport		As Object
Local lOk			As Logical
Local cPerg			As Character
Local lRelease24    As Logical
Private titulo		As Character
Private nomeprog	As Character
Private m_pag		As Numeric      
Private aSetOfBook	As Array

If !IsBlind() .And. FunName()=="CTBR355"
	lRelease24  := (GetRPORelease() >= "12.1.2410")

	Help(" ",1,STR0031,,;//"Ciclo de vida de Software"
			IIF(lRelease24, STR0034, STR0032)+CRLF+CRLF+; // "Esta rotina foi/será descontinuada no release 12.1.2410"
			STR0033,1,0) //"Para substituir esta funcionalidade, utilize a nova rotina de Conciliação (CTBA940)

	If lRelease24	
		Return
	EndIf
EndIf

oReport := Nil
lOk			:= .T.
cPerg		:= STR0025 //"CTR355"
titulo		:= STR0001 //"Relatorio de conferencia de lancamentos"
nomeprog	:= STR0026 //"CTBR355"
m_pag		:= 1       
aSetOfBook  := {}

If lOk
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualizacao das perguntas utilizadas pelo relatorio       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := CTBR355R4()	//R4
    If valtype( oReport ) == 'O'
		oReport:PrintDialog()
	Endif	
	oReport := nil
EndIf

Return                                


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡…o    ³ ReportDef ³ Autor ³Felipe C. Cunha       ³ Data ³ 01.01.12 ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CTBR355R4()
Local oSection1		//Cabecalho
Local oSection2		//Valores
Local oSection3		//SubTotais
Local oSection4		//Saldo
Local cAlias1 	:= ""
Local oReport 	:= STR0026 			 //"CTBR355"
Local cPerg	  	:= STR0025 			 //"CTR355"
Local cDescri 	:= STR0002 + STR0003 //"Este programa ir  imprimir a relacao de lancamentos de acordo com os parametros solicitados"
Local cTitulo 	:= STR0001 			 //"Relatorio de conferencia de lancamentos"
Local nDecimais := 0
Local oTRFDeb,oTRFCrd

Local oTotais
Local oBreak
Local oDebito
Local oCredito
Local oSecFil	

Pergunte(STR0025,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Controle de Configuração de Livros                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aSetOfBook := CTBSetOf(mv_par04)
If !ct040Valid(mv_par04)
	lRet := .F.
Else
	aSetOfBook := CTBSetOf(mv_par04)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica o numero de decimais                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nDecimais := DecimalCTB(aSetOfBook,mv_par11)                    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio - Cabeçalho          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= TReport():New(oReport,titulo,cPerg, {|oReport| ReportDef(oReport, nDecimais, cAlias1)},cDescri)

oSection1 := TRSection():New( oReport, cTitulo, {"cAlias1"})

TRCell():New(oSection1,"CABEC"	,"cAlias1",/*Titulo*/	,/*Picture*/,800/*Tamanho*/	,/*lPixel*/,/*{|| }*/)	//Cabeçalho

oReport:SetUseGC(.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 2a. secao do relatorio - VALORES            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New( oReport, STR0024, {"cAlias1"})	//Lancamentos Contabeis-Detalhes
//oSection2:SetHeaderPage(.F.)
oSection2:setHeaderSection(.T.)
TRCell():New(oSection2,"CT2_LOTE"	,"cAlias1",/*Titulo*/			,X3Picture("CT2_LOTE"  )/*Picture*/,TamSX3("CT2_LOTE")[1]	/*Tamanho*/	,/*lPixel*/,/*{|| }*/)	//Lote
TRCell():New(oSection2,"CT2_SBLOTE"	,"cAlias1",/*Titulo*/			,X3Picture("CT2_SBLOTE")/*Picture*/,TamSX3("CT2_SBLOTE")[1]/*Tamanho*/	,/*lPixel*/,/*{|| }*/)	//SubLote
TRCell():New(oSection2,"CT2_DOC"	,"cAlias1",/*Titulo*/			,X3Picture("CT2_DOC"   )/*Picture*/,TamSX3("CT2_DOC")[1]	/*Tamanho*/	,/*lPixel*/,/*{|| }*/)	//Documento
TRCell():New(oSection2,"CT2_LINHA"	,"cAlias1",/*Titulo*/			,X3Picture("CT2_LINHA" )/*Picture*/,TamSX3("CT2_LINHA")[1]	/*Tamanho*/	,/*lPixel*/,/*{|| }*/)	//Linha
TRCell():New(oSection2,"CT2_DATA"	,"cAlias1",/*Titulo*/			,X3Picture("CT2_DATA"  )/*Picture*/,TamSX3("CT2_DATA")[1]+2	/*Tamanho*/	,/*lPixel*/,/*{|| }*/)	//Data
TRCell():New(oSection2,"CT2_HIST"	,"cAlias1",/*Titulo*/			,X3Picture("CT2_HIST"  )/*Picture*/,TamSX3("CT2_HIST")[1]	/*Tamanho*/	,/*lPixel*/,/*{|| }*/)	//Historico
TRCell():New(oSection2,"DEBITO"		,"cAlias1","Débito"	/*Titulo*/	,X3Picture("CT2_VALOR" )/*Picture*/,TamSX3("CT2_VALOR")[1]	/*Tamanho*/	,/*lPixel*/,{|| if(CT2_DC == "1" .Or. (CT2_DC == "3" .And. CT2_DEBITO == mv_par13) ,CT2_VALOR,0) })	//"Debito"
TRCell():New(oSection2,"CREDITO"	,"cAlias1","Crédito"/*Titulo*/	,X3Picture("CT2_VALOR" )/*Picture*/,TamSX3("CT2_VALOR")[1]	/*Tamanho*/	,/*lPixel*/,{|| if(CT2_DC == "2" .Or. (CT2_DC == "3" .And. CT2_CREDIT == mv_par13),CT2_VALOR,0) })	//"Credito"
TRCell():New(oSection2,"CT2_OBSCNF"	,"cAlias1",/*Titulo*/			,                       /*Picture*/,/*Tamanho*/		,/*lPixel*/,/*{|| }*/)	//"Historico"
TRFunction():New(oSection2:Cell("DEBITO")	,"TOTDEB"	,"SUM",,,"@E 999,999,999,999.99",,.T.,.f.)
TRFunction():New(oSection2:Cell("CREDITO")	,"TOTCRED"	,"SUM",,,"@E 999,999,999,999.99",,.T.,.F.)
oTRFDeb := TRFunction():New(oSection2:Cell("DEBITO")	,"SALDO"	,"ONPRINT", oBreak	 ,"Saldo","@E 999,999,999,999.99",{|| IIf(oSection2:GetFunction("TOTCRED"):GetLastValue() - oSection2:GetFunction("TOTDEB"):GetLastValue()<=0,ABS(oSection2:GetFunction("TOTCRED"):GetLastValue() - oSection2:GetFunction("TOTDEB"):GetLastValue()),oTRFDeb:Disable()) },.T.,.f.)
oTRFCrd := TRFunction():New(oSection2:Cell("CREDITO")	,"SALDO"	,"ONPRINT", oBreak	 ,"Saldo","@E 999,999,999,999.99",{|| IIf(oSection2:GetFunction("TOTCRED"):GetLastValue() - oSection2:GetFunction("TOTDEB"):GetLastValue()>0,ABS(oSection2:GetFunction("TOTCRED"):GetLastValue() - oSection2:GetFunction("TOTDEB"):GetLastValue()),oTRFCrd:Disable()) },.T.,.f.)

oSection2:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³GESTAO - inicio, Relacao das filiais selecionadas para compor o relatorio	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSecFil := TRSection():New(oReport,"SECFIL",{"CT2"})
TRCell():New(oSecFil,"CODFIL",,STR0026,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)					//"Código"	
TRCell():New(oSecFil,"EMPRESA",,STR0027,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)					//"Empresa"
TRCell():New(oSecFil,"UNIDNEG",,STR0028,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)					//"Unidade de negocio"
TRCell():New(oSecFil,"NOMEFIL",,STR0029,/*Picture*/,60,/*lPixel*/,/*{|| code-block de impressao }*/)					//"Filial"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³GESTAO - Fim	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Return oReport                            

/*                                                        
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ReportPrint³ Autor ³ Felipe C. Cunha     ³ Data ³ 01.01.12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±ºDesc.     ³Query de impressao do relatorio                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ATFR262                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/            
Static Function ReportPrint( oReport, nDecimais, cAlias1 )
Local cQuery  	:= "CT2"
Local cWhere  	:= ""

Local oSection2		:= oReport:Section(1)
Local aSelFil		:= {}
Local nRegSM0		:= 0 
Local aSM0			:= {}
Local nTamEmp		:= 0
Local nTamUnNeg		:= 0
Local nTamTit		:= 0
Local nX			:= 0
Local cFiLSel		:= ""
Local oSecFil		:= oReport:Section("SECFIL") 

If Empty(MV_PAR17)
	MV_PAR17 := 2
EndIf

If MV_PAR17 == 1
	nRegSM0 := SM0->(Recno())
	aSelFil := FwSelectGC()
	SM0->(DbGoTo(nRegSM0))
Endif

If Empty(aSelFil)
	Aadd(aSelFil,cFilAnt)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³GESTAO - inicio, imprime a lista de filiais selecionadas para o relatorio	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aSelFil) > 1 
	oSection2:SetHeaderSection(.F.)
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
	oSection2:SetHeaderSection(.T.)
	oReport:EndPage()
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³GESTAO - Fim	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia Section2 - Monta condicao padrão para querys	       	 ³	
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Imprime?
If mv_par01 == 1 	  //Nao Conferidos
	cWhere	:=	" CT2_CONFST   = ' ' "
ElseIf mv_par01 == 2 //
	cWhere	:=	" CT2_CONFST   = '2' "
ElseIf mv_par01 == 3 // Conferidos
	cWhere	:=	" CT2_CONFST   = '1' "
Endif 

//Seleciona Filial "SIM"
If mv_par17 == 1
	cWhere	+=	" AND CT2_FILIAL IN ("+SelectFil(aSelFil)+") "
Else
	cWhere	+=	" AND CT2_FILIAL = '"+xFilial("CT2")+"' "
EndIf

//Da Data/Ate a Data
cWhere	+=	" AND CT2_DATA BETWEEN '" + Dtos(mv_par02)+"' AND '" + Dtos(mv_par03)+"' "

//Do Lote/Ate o Lote
cWhere	+=	" AND CT2_LOTE BETWEEN '"+(mv_par05)+"' AND '"+(mv_par06)+"' "

//Do SubLote/Ate o SubLote
cWhere	+=	" AND CT2_SBLOTE BETWEEN '"+(mv_par07)+"' AND '"+(mv_par08)+"' "

//Do Documento/Ate o Documento
cWhere	+=	" AND CT2_DOC BETWEEN '"+(mv_par09)+"' AND '"+(mv_par10)+"' "

//Moeda
cWhere	+=	" AND CT2_MOEDLC     = '"+(mv_par11)+"' "

//Tipo de Saldo
cWhere	+=	" AND CT2_TPSALD    = '"+(mv_par12)+"' "

//Conta
cWhere	+=	" AND (CT2_CREDIT    = '" + (mv_par13) + "' OR CT2_DEBITO = '"+(mv_par13) + "')"



//Centro de Custo
If !Empty(mv_par14)
	cWhere	+=	" AND CT2_CCC    = '"+(mv_par14)+"' "
EndIf

//Item Contabil
If !Empty(mv_par15)
	cWhere	+=	" AND CT2_ITEMC    = '"+(mv_par15)+"' "
EndIf

//Classe de Valor
If !Empty(mv_par16)
	cWhere	+=	" AND CT2_CLVLCR   = '"+(mv_par16)+ "' "
EndIf	 

cAlias1 := GetNextAlias()
cQuery := "		SELECT  CT2_FILIAL,CT2_DATA,CT2_LOTE,CT2_SBLOTE,CT2_DOC,"  + CRLF
cQuery += "			CT2_LINHA,CT2_DC,CT2_TPSALD,CT2_DEBITO,CT2_CREDIT,	"  + CRLF
cQuery += "			CT2_VALOR,CT2_CONFST, CT2_OBSCNF,CT2_HIST,			"  + CRLF
cQuery += "			CT2_SEQLAN,CT2_EMPORI,CT2_FILORI,					"  + CRLF
cQuery += "			CT2_MOEDLC											"  + CRLF
cQuery += "	        FROM " + RetSqlName("CT2") + " CT2					"  + CRLF
cQuery += "      	WHERE " + CWHERE							 		   + CRLF
cQuery += "		    AND CT2_DC   IN  ('1', '2', '3')					"  + CRLF
cQuery += "		    AND D_E_L_E_T_ = ' '								"  + CRLF
cQuery += "		    ORDER BY CT2_DATA									"  + CRLF
cQuery := ChangeQuery(cQuery)

MemoWrite( 'CTBR355.SQL', cQuery )
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"cAlias1",.T.,.T.)
TcSetField("cAlias1","CT2_DATA","D",8,0)
("cAlias1")->(DbGoTop())
DbSelectArea("cAlias1")            

Return("cAlias1")

/*                                                        
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ReportPrint³ Autor ³ Felipe C. Cunha     ³ Data ³ 01.01.12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±ºDesc.     ³Query de impressao do relatorio                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ATFR262                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/            
Static Function ReportDef( oReport, nDecimais, cAlias1 )
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(2)
Local oSection3 := oReport:Section(3)
Local oSection4 := oReport:Section(4)
Private nSubTot := 0  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Cabeçalho             	                        	 ³	
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetCustomText( {|| Cabec262( oReport ) })  
titulo	:= oReport:Title()  

ReportPrint( oReport, nDecimais, cAlias1 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Dados Section1                        	             ³	
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(mv_par13)
	cConta	:=	Alltrim(mv_par13) + " - "+Alltrim(Posicione("CT1",1,xFilial()+mv_par13,"CT1_DESC01"))
Else                           
	cConta := STR0020 //"Todos"
EndIf

If !Empty(mv_par14)
	cCusto	:=Alltrim(mv_par14) + " - "+Alltrim(Posicione("CTT",1,xFilial('CTT')+mv_par14,"CTT_DESC01"))
Else
	cCusto := STR0020 //"Todos"
Endif                     

If !Empty(mv_par15)
	cItem	:=Alltrim(mv_par15) + " - "+Alltrim(Posicione("CTD",1,xFilial('CTD')+mv_par15,"CTD_DESC01"))
Else
	cItem	:= STR0020 //"Todos"
Endif

If !Empty(mv_par16)
	cClasse	:=Alltrim(mv_par16) + " - "+Alltrim(Posicione("CTH",1,xFilial('CTH')+mv_par16,"CTH_DESC01"))
Else
	cClasse	:= STR0021 //"Todas"
Endif

oSection1:SetHeaderSection(.F.) 
oReport:SkipLine() //Salta Linha
oSection1:init()             
oSection1:Cell("CABEC"):SetBlock({|| STR0008 + Alltrim(cConta) + STR0009 + Alltrim(cCusto) + STR0010 + Alltrim(cItem) + STR0011 + Alltrim(cClasse)})
oSection1:PrintLine()           
oReport:ThinLine() //Imprime Linha Fina

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Dados Section2                        	             ³	
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2:Print() // Imprime dados Section2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Linha Preparado Por                   	             ³	
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SkipLine() //Salta Linha
oReport:ThinLine() //Imprime Linha Fina
oReport:SkipLine() 
oReport:PrintText(STR0012 + cUserName)//"Preparado por: "
oReport:SkipLine() 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Linha Aprovado Por                   	             ³	
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:PrintText(STR0013)//"Aprovado por: "
oReport:SkipLine() 
oReport:ThinLine()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Linha Observação                    	             ³	
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SkipLine() 
oReport:PrintText(STR0014) //"Observacao: "
oReport:SkipLine() 
oReport:SkipLine() 
oReport:SkipLine() 
oReport:FatLine()  //Imprime Linha

DbCloseArea()

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ Cabec262   ³ Autor ³ Felipe C. Cunha     ³ Data ³ 01.01.12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±ºDesc.     ³Insere novas perguntas ao SX1                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ATFR262                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Cabec262( oReport )
Local aArea		:= GetArea()
Local aCabec	:= {}
Local cChar		:= chr(160)  // caracter dummy para alinhamento do cabeçalho

SX3->( DbSetOrder(2) )
SX3->( MsSeek( "A1_CGC" , .t.))

If SM0->(Eof())                                
	SM0->( MsSeek( cEmpAnt + cFilAnt , .T. ))
Endif

aCabec := {	"__LOGOEMP__" , cChar + "         " + SM0->M0_NOMECOM ;
	      + "         " + cChar + RptFolha+ TRANSFORM(oReport:Page(),'999999');
          , cChar + "         " + Transform( Alltrim( SM0->M0_CGC ), alltrim( SX3->X3_PICTURE ));
          + "         " + cChar;          
          , "SIGA / " + "CTBR355" + " /v." + cVersao ; //"SIGA / ATFR262 /v."
          + "         " + cChar + UPPER(AllTrim(titulo)) ;
          + "         " + cChar ;
          , RptHora + " " + time() ;
          + "         " + cChar + RptEmiss + " " + Dtoc(dDataBase) }
RestArea( aArea )

Return aCabec      
  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SelectFil ºAutor  ³Microsiga           º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Separa as filiais, inserindo aspas simples e virgula,      º±±
±±º          ³ Para ser usado na clausula IN do SQL                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                  	                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function SelectFil(aSelFil)

Local cFil	:=""
Local nX	:= 0

For nX:= 1 to len(aSelFil)
	
	cFil+="'"
	If len(aSelFil) > 0
		If aScan( aSelFil, { |x|x == SubStr(aSelFil[1],1,3)} ) > 0
			cFil+=SubStr(aSelFil[nX],1,3)
		EndIf
	Else
		cFil+="'"
	EndIf
	cFil+="',"

Next nX

Return SubStr(cFil,1,Len(cFil)-1)
