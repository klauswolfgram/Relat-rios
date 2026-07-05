/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "atfr051.ch"
#Include "Protheus.ch"


// 17/08/2009 - Ajuste para filiais com mais de 2 caracteres.

// TRADUCAO DE CH'S PARA PORTUGAL

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ATFR051    ³ Autor ³ Paulo Augusto         ³ Data ³ 12.02.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Saldo Atualizado- Legislacao Mexico                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ATFR051                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR051()
Private nInpcOri:=0
Private oReport,oSection1,oSection11,oSection2,oSection3
Private aTotais:={}
oReport:=ReportDef()
oReport:PrintDialog()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Paulo Augusto          ³ Data ³12/02/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local cReport := "ATFR051"
Local cAlias1 := "SN3"
Local cTitulo :=  STR0001 //"Saldo a depreciar"
Local cDescri := STR0001 + " " +  STR0002 //"Saldo a depreciar"###"Este programa ir  emitir a rela‡Æo dos valores que ainda faltam depreciar para cada bem"
Local bReport := { |oReport|	oReport:SetTitle( oReport:Title() +" " ),; 
									 	ReportPrint( oReport ) }
Local aOrd := {}
Local cMoeda                                                                

DbSelectArea("SIE")   
DbSetOrder(1)

DbSelectArea("SN1") // Forca a abertura do SN1

aOrd  := {	OemToAnsi(STR0004),;  //"Conta"
				OemToAnsi(STR0005)}  //"C.Custo"

Pergunte( "ATR051" , .F. )
oReport  := TReport():New( cReport, cTitulo, "ATR051" , bReport, cDescri )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0038, {cAlias1,"SN3"}, aOrd )	 //"Cabecalho"
TRCell():New( oSection1, "N3_CCONTAB"	, cAlias1,/*X3Titulo*/,/*Picture*/,Len(CT1->CT1_DESC01)/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "N3_CCUSTO" 	, cAlias1,/*X3Titulo*/,/*Picture*/,Len(CTT->CTT_DESC01)/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection11 := TRSection():New( oSection1, STR0007, {cAlias1,"SN3"} )	 //"Dados do Bem"
TRCell():New( oSection11, "N1_DESCRIC"	, "SN1"  ,STR0008/*X3Titulo*/,/*Picture*/,Len(CT1->CT1_DESC01)/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"ATIVO FIXO"
TRCell():New( oSection11, "N1_AQUISIC"	, "SN1"  ,"FECHA" +CHR(13)+CHR(10)+STR0009/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"AQUISICAO"
TRCell():New( oSection11, "N3_VORIG1"	, "SN3"  ,"MOI"/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection11, "N3_TXDEPR1"	, "SN1"  ,STR0010+CHR(13)+CHR(10)+STR0011/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"TAXA DE"###"DEPREC."
TRCell():New( oSection11, "MESES"		, "   "  ,STR0012+CHR(13)+CHR(10)+STR0013+CHR(13)+CHR(10)+STR0014/*X3Titulo*/,"@E 99999"/*Picture*/,    5,/*lPixel*/,{|| 8 }) //"MESES"###"DE"###"USO"
TRCell():New( oSection11, "N3_VRDMES1"	, "SN3"  ,STR0015+CHR(13)+CHR(10)+STR0016/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"DEPRECIACAO"###"MENSAL"
TRCell():New( oSection11, "N3_VRDBAL1"	, "SN3"  ,STR0011+CHR(13)+CHR(10)+STR0017+CHR(13)+CHR(10)+STR0018/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"DEPREC."###"DO"###"EXERCICIO"
TRCell():New( oSection11, "INPCP"		, "   "  ,STR0019+CHR(13)+CHR(10)+STR0020+CHR(13)+CHR(10)+STR0021/*X3Titulo*/,PesqPict("SIE","IE_INDICE")/*Picture*/,TamSX3("IE_INDICE")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"INPC"###"MEDIO"###"UTILIZADO"
TRCell():New( oSection11, "INPCDATAAQ"	, "   "  ,STR0019+CHR(13)+CHR(10)+STR0022+CHR(13)+CHR(10)+STR0009/*X3Titulo*/,PesqPict("SIE","IE_INDICE")/*Picture*/,TamSX3("IE_INDICE")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"INPC"###"DATA"###"AQUISICAO"
TRCell():New( oSection11, "FATORATU"	, "   "  ,STR0023+CHR(13)+CHR(10)+STR0024/*X3Titulo*/,PesqPict("SIE","IE_INDICE")/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| atf051CM(N3_DINDEPR) }*/) //"FATOR"###"ATUALIZACAO"
TRCell():New( oSection11, "DPATUAL"		, "   "  ,STR0011+CHR(13)+CHR(10)+STR0025/*X3Titulo*/,PesqPict("SN3","N3_VRDMES1")/*Picture*/,TamSX3("N3_VRDMES1")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"DEPREC."###"ATUALIZADA"
TRCell():New( oSection11, "N3_VRDACM1"	, "   "  ,STR0011+CHR(13)+CHR(10)+STR0026/*X3Titulo*/,PesqPict("SN3","N3_VRDMES1")/*Picture*/,TamSX3("N3_VRDMES1")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"DEPREC."###"ACUMULADA"
TRCell():New( oSection11, "SALDORED"	, "   "  ,STR0027+CHR(13)+CHR(10)+STR0028/*X3Titulo*/,PesqPict("SN3","N3_VRDMES1")/*Picture*/,TamSX3("N3_VRDMES1")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"SALDO X"###"REDIMIR"
TRCell():New( oSection11, "SALDOREDA"	, "   "  ,"SALDO X"+CHR(13)+CHR(10)+STR0028+CHR(13)+CHR(10)+STR0029/*X3Titulo*/   ,PesqPict("SN3","N3_VRDMES1")/*Picture*/,TamSX3("N3_VRDMES1")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"REDIMIR"###"ATUALIZADO"
oSection11:SetHeaderPage(.T.)

oSection2 := TRSection():New( oReport, STR0039, {"",""}, aOrd )	 //"Totais"
TRCell():New( oSection2, "NOME"			, "	"  ,STR0008/*X3Titulo*/,/*Picture*/,Len( CT1->CT1_DESC01),/*lPixel*/,/*{|| code-block de impressao }*/) //"Ativo Fixo"
TRCell():New( oSection2, "N3_VORIG1"	, "SN3"  ,"MOI"/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection2, "N3_VRDBAL1"	, "SN3"  ,STR0011+CHR(13)+CHR(10)+STR0017+CHR(13)+CHR(10)+STR0018/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"DEPREC."###"DO"###"EXERCICIO"
TRCell():New( oSection2, "DPATUAL"		, "   "  ,STR0011+CHR(13)+CHR(10)+STR0025/*X3Titulo*/,PesqPict("SN3","N3_VRDMES1")/*Picture*/,TamSX3("N3_VRDMES1")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"DEPREC."###"ATUALIZADA"

oSection3:= TRSection():New( oReport, STR0040, {"",""}, aOrd )	//  Mensagem
TRCell():New( oSection3, "TEXTO"	, "	"  ," "/*X3Titulo*/,/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)

Return oReport
                                       
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Paulo Augusto       º Data ³  12/02/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )
Local oSection1  := oReport:Section(1)
Local oSection11 := oReport:Section(1):Section(1)
Local oSection2	:= oReport:Section(2)
Local cChave
Local cQuery		:= "SN3"
Local cAliasCT1	:= "CT1"
Local cAliasCTT	:= "CTT"
Local nOrder   := oSection1:GetOrder()
Local cWhere	:= ""
Local cQuebra	:= .T.
Local nx:=1    
Local nTotvOrig:= 0
Local nTotDep:=   0
Local nTotDpAt:=  0
Local nTotSlMed:= 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Localiza registro inicial                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF nOrder == 1
	SN3->(dbSetOrder(2))
	cWhere := "N3_CCONTAB <> ' ' AND "
	oSection1:Cell("N3_CCUSTO"):Disable()
	oSection11:SetTotalText({ || STR0035 + cQuebra } )		 //"Total da Conta: "
	oSection1:Cell("N3_CCONTAB"):SetBlock( { || (cAliasCT1)->CT1_DESC01 } )
ElseIF nOrder == 2
	SN3->(dbSetOrder(3))
	cWhere := "N3_CCUSTO <> ' ' AND "
	oSection1:Cell("N3_CCONTAB"):Disable()
	oSection1:Cell("N3_CCUSTO"):SetBlock( { || (cAliasCTT)->CTT_DESC01 } )
	oSection11:SetTotalText( {||STR0036 + cQuebra } )	 //"Total do Centro de Custo: "
End
cChave := SN3->(IndexKey())

#IFDEF TOP

	cQuery 		:= GetNextAlias()
	cAliasCT1	:= cQuery
	cAliasCTT	:= cQuery
	
	cChave 	:= "%"+SqlOrder(cChave)+"%"
	cWhere	:= "%" + cWhere + "%"
	
	oSection1:BeginQuery()
	
	BeginSql Alias cQuery
		SELECT
			N3_CBASE, N3_ITEM, N3_TIPO, N3_CCUSTO, N3_CCONTAB, N3_VORIG1, N3_AMPLIA1, N3_VRCACM1, N3_VRDACM1, N3_VRCDA1, 
			N3_VORIG2, N3_AMPLIA2, N3_VRDACM2, N3_VORIG3, N3_AMPLIA3, N3_VRDACM3, N3_VORIG4, N3_AMPLIA4, N3_VRDACM4,
			N3_VORIG5, N3_AMPLIA5, N3_VRDACM5, N3_CDEPREC, N3_CCDEPR, N1_DESCRIC, CTT_DESC01, CT1_DESC01,N3_TXDEPR1,
			N3_VORIG1,N1_AQUISIC,N3_DINDEPR,N3_VRDMES1,N3_VRDBAL1,N3_VRDMES1,N3_AQUISIC,N3_FIMDEPR,N3_BAIXA,N3_DTBAIXA
		FROM %table:SN3% SN3
			JOIN %table:SN1% SN1 ON 
			SN1.N1_FILIAL =  %xfilial:SN1%  
			AND SN1.N1_CBASE = SN3.N3_CBASE 
			AND SN1.N1_ITEM = SN3.N3_ITEM 
			AND SN1.%notDel%
			LEFT JOIN %table:CT1% CT1 ON
			CT1.CT1_FILIAL =  %xfilial:CT1%
			AND CT1.CT1_CONTA = SN3.N3_CCONTAB 
			AND CT1.%notDel%
			LEFT JOIN %table:CTT% CTT ON
			CTT.CTT_FILIAL =  %xfilial:CTT%
			AND CTT.CTT_CUSTO = SN3.N3_CCUSTO 
			AND CTT.%notDel%
		WHERE
			SN3.N3_FILIAL = %xfilial:SN3% AND
			SN3.N3_CBASE >= %Exp:mv_par01% AND 
			SN3.N3_CBASE <= %Exp:mv_par02% AND 
			SN3.N3_BAIXA = '0' AND
			SN3.N3_TXDEPR1 <> 0 AND
			(SN3.N3_CDEPREC <> ' ' OR
			 SN3.N3_CDESP <> ' ' OR
        	 SN3.N3_CCDEPR <> ' ' ) AND
			%Exp:cWhere%
			SN3.%notDel%
		ORDER BY %Exp:cChave%
	EndSql

	oSection1:EndQuery()
	oSection11:SetParentQuery()
	
#ELSE

	cFiltro := 'N3_FILIAL == "'+xFilial("SN3")+'" .And. '
	cFiltro += 'N3_CBASE>= "'+mv_par01+'" .And. '
	cFiltro += 'N3_CBASE<= "'+mv_par02+'" .And. '
	cFiltro += StrTran(cWhere, "AND", ".And." )
	cFiltro += 'Val(N3_BAIXA) = 0 .And.'
	cFiltro += '(!Empty(N3_CDEPREC) .Or. !Empty(N3_CDESP) .Or. !Empty(N3_CCDEPR)) .And. ' 
	cFiltro += 'N3_TXDEPR1 <> 0'
	oSection1:SetFilter(cFiltro,cChave)

	TRPosition():New(oSection1,"CT1",1,{|| xFilial("CT1")+SN3->N3_CCONTAB })
	TRPosition():New(oSection1,"CTT",1,{|| xFilial("CTT")+SN3->N3_CCUSTO })
	TRPosition():New(oSection11,"SN1",1,{|| xFilial("SN1")+SN3->(N3_CBASE+N3_ITEM) })

#ENDIF

oSection11:Cell("MESES"):SetBlock( {||U_Atf051Dt((cQuery)->N3_FIMDEPR,(cQuery)->N3_AQUISIC,(cQuery)->N3_BAIXA,(cQuery)->N3_DTBAIXA) } )
//oSection11:Cell("MESES"):SetValue(Atf051Dt((cQuery)->N3_FIMDEPR,(cQuery)->N3_AQUISIC) )
oSection11:Cell("INPCP"):SetBlock( {||atf051CM((cQuery)->N3_AQUISIC,(cQuery)->N3_VORIG1,(cQuery)->N3_VRDACM1,(cQuery)->N3_VRDBAL1,(cQuery)->N3_CCONTAB,(cQuery)->N3_CCUSTO,(cQuery)->N3_VRDMES1, (cQuery)->N1_AQUISIC, (cQuery)->N3_FIMDEPR,(cQuery)->N3_BAIXA,(cQuery)->N3_DTBAIXA) })

oSection11:Cell("N3_VRDMES1"):SetBlock( {||Atf051TDep((cQuery)->N3_CBASE, (cQuery)->N3_ITEM, (cQuery)->N3_TIPO, (cQuery)->N3_FIMDEPR, (cQuery)->N3_VRDMES1) } )


// Cria variável a ser usada para impressao do texto da quebra da secao
oSection11:SetLineCondition( { || If(nOrder==1, cQuebra := (Mascara(N3_CCONTAB) + " - " + (cAliasCT1)->CT1_DESC01), cQuebra := (N3_CCUSTO + " - " + (cAliasCTT)->CTT_DESC01)),.T. } )
oSection11:SetTotalInLine(.F.)
oReport:SetTotalInLine(.F.)
oReport:SetTotalText("TOTAIS") 

If nOrder == 1
	oSection11:SetParentFilter({|cParam| (cQuery)->N3_CCONTAB == cParam },{|| (cQuery)->N3_CCONTAB })
Else
	oSection11:SetParentFilter({|cParam| (cQuery)->N3_CCUSTO == cParam },{|| (cQuery)->N3_CCUSTO })
Endif	

TRFunction():New(oSection11:Cell("N3_VORIG1"),,"SUM",,,,, .T. ,.F. )	
TRFunction():New(oSection11:Cell("N3_VRDMES1"),,"SUM",,,,, .T., .F. )
TRFunction():New(oSection11:Cell("DPATUAL"   ),,"SUM",,,,, .T., .F. )		
TRFunction():New(oSection11:Cell("N3_VRDBAL1"),,"SUM",,,,, .T., .F. )	
TRFunction():New(oSection11:Cell("N3_VRDACM1"),,"SUM",,,,, .T., .F. )	

oSection1:Print()

If len(aTotais)>0
	oReport:SkipLine()
	oReport:SkipLine()
	oSection3:Init()
	oReport:SkipLine(2)
	oSection3:Cell("TEXTO"):SetValue(SM0->M0_NOMECOM) 
	oSection3:PrintLine()
	oSection3:Cell("TEXTO"):SetValue(STR0037)  //"Resumo das Depreciacoes"
	oSection3:PrintLine()
	oSection3:Finish()
	    
	oSection2:Init()
	For nx:=1 to Len(aTotais)

	oSection2:Cell("NOME"):SetValue(aTotais[nX][6]) 
	oSection2:Cell("N3_VORIG1"):SetValue(aTotais[nX][2]) 
	oSection2:Cell("N3_VRDBAL1"):SetValue(aTotais[nX][3]) 
	oSection2:Cell("DPATUAL"):SetValue(aTotais[nX][4]) 
	oSection2:PrintLine()
	
    nTotvOrig:=nTotvOrig+aTotais[nX][2]
    nTotDep:=nTotDep+aTotais[nX][3]
    nTotDpAt:=nTotDpAt+aTotais[nX][4]
    Next 
    
oReport:SkipLine(3)

oSection2:Cell("NOME"):SetValue("   ") 
oSection2:Cell("N3_VORIG1"):SetValue(nTotvOrig) 
oSection2:Cell("N3_VRDBAL1"):SetValue(nTotDep) 
oSection2:Cell("DPATUAL"):SetValue(nTotDpAt) 

oSection2:PrintLine()

    
oSection2:Finish()

End


Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³atf051CM   ºAutor  ³Paulo Augusto       º Data ³  12/02/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Taxa das moeda                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function atf051CM(dDatInDep,nVorig,nVlDpAc,nVlDpB,cContab,cCCusto,nvalDep,dDtAquis,nDtFimDp,cBaixaAt,dDtBaixa)

Local nTxMed:=0
Local nMesIni:=0
Local nMesMed:=0      
Local nTxAqui:=0
Local nTxAtua:=0
Local nSldAct:=0
Local nMesAquis:=0
Local nMesUso := 0

nMesUso := U_Atf051Dt(nDtFimDp,dDtAquis,cBaixaAt,dDtBaixa)

If Year(dDtAquis) == Year(dDataBase)
	nMesAquis := Month(dDtAquis)
Endif	
                           
nMesMed:=Int((nMesUso/2)+nMesAquis)
cMesMed:=Strzero(nMesMed,2)

DbSelectArea("SIE")   
DbSetOrder(1)
If DbSeek( xFilial("SIE")+Str(Year(dDataBase),4)+cMesMed) 
	nTxMed:=SIE->IE_INDICE
EndIf

If DbSeek( xFilial("SIE")+Str(Year(dDatInDep),4)+STRzero(Month(dDatInDep),2))
	nTxAqui:=SIE->IE_INDICE
EndIf
nTxAtua:=nTxMed/nTxAqui
nSldAct:=nVorig-nVlDpAc

oSection11:Cell("INPCDATAAQ"):SetValue(nTxAqui) 
oSection11:Cell("FATORATU"):SetValue(nTxAtua) 
oSection11:Cell("DPATUAL"):SetValue(nVlDpB*nTxAtua) 
oSection11:Cell("SALDORED"):SetValue(nSldAct)  //saldo redimir
oSection11:Cell("SALDOREDA"):SetValue(nSldAct*nTxAtua) //actualizado

If oSection1:GetOrder()==1

	nNum:= Ascan(aTotais, {|e| Alltrim(e[1]) == Alltrim(cContab) } ) 
    If nNum >0
	    aTotais[nNum][2]:=aTotais[nNum][2] + nVorig
	    aTotais[nNum][3]:=aTotais[nNum][3]+ nVlDpB
	    aTotais[nNum][4]:=aTotais[nNum][4]+ (nVlDpB*nTxAtua)
	    
    Else 
    
    	CT1->(dBSetOrder(1))
    	CT1->(DbSeek(xFilial("CT1")+cContab))
	    Aadd(aTotais,{cContab,nVorig,nVlDpB,(nVlDpB*nTxAtua),(((nSldAct*nTxAtua)-(nVlDpB*nTxAtua)/2)),CT1->CT1_DESC01})
    EndIf
Else	
	nNum:= Ascan(aTotais, {|e| Alltrim(e[1]) == Alltrim(cCCusto) } ) 
    If nNum>0
     	aTotais[nNum][2]:=aTotais[nNum][2] + nVorig
	   aTotais[nNum][3]:=aTotais[nNum][3] + nVlDpB
	   aTotais[nNum][4]:=aTotais[nNum][4] + (nVlDpB*nTxAtua)
	    
	Else 
		CTT->(dBSetOrder(1))
    	CTT->(DbSeek(xFilial("CT1")+cCCusto))
	    Aadd(aTotais,{cCCusto,nVorig,nVlDpB,(nVlDpB*nTxAtua),(((nSldAct*nTxAtua)-(nVlDpB*nTxAtua)/2)),CT1->CT1_DESC01})
	EndIf
EndIf

Return(nTxMed)

User Function Atf051Dt(dDtFimDp,dDtAquis,cBaixaAt,dDtBaixa)

Local nMes:= 0

If Empty(dDtFimDp)
	nMes := (dDataBase-dDtAquis)/30
	If nMes > 0 .And. nMes < 1
		nMes := 1
	Else
		nMes := NoRound(nMes,0)
	EndIf
ElseIf cBaixaAt != "0" .And. !Empty(dDtBaixa)//caso ja tenha sido baixado
	nMes := 0
Else
	nMes := (dDataBase-dDtAquis)/30
	If nMes > 0 .And. nMes < 1
		nMes := 1
	Else
		nMes := NoRound(nMes,0)
	EndIf
EndIf

Return(nMes)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATF051TDEPºAutor  ³Marcos Berto        º Data ³  31/10/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Atribui o valor da depreciacao mensal tanto para os que    º±±
±±º          ³ estao sendo depreciados quanto para os que ja terminaram   º±±
±±º          ³ de depreciar.                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ATF051TDEP(cCBase, cItem, cTipo, dDtFimDp, nValMes)
      
Local nValor := 0

//caso ja tenham sido depreciados totalmente
If nValMes == 0 .and. !Empty(dDtFimDp)
	DbSelectArea("SN4")
	DbSetOrder(1)
	
	If DbSeek(xFilial("SN4")+cCBase+cItem+cTipo+Dtos(dDtFimDp)+"06")
		nValor := SN4->N4_VLROC1
	Endif
	
	SN4->(DbCloseArea())
//senao atribui o valor da depreciacao mensal no SN3
Else
	nValor := nValMes
Endif

Return(nValor)

                                       
