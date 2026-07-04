/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "protheus.ch"
#INCLUDE "ATFR320.ch"

// 17/08/2009 - Ajuste para filiais com mais de 2 caracteres.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR320   º Autor ³ Marcos S. Lobo.    º Data ³  24/11/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatório Responsáveis x Bens.					      	  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ATFR320(cRespINI,cRespFIM,cCBASEINI,cItemINI,cCBaseFIM,cItemFIM)
Local oReport

oReport:=ReportDef(cRespINI,cRespFIM,cCBASEINI,cItemINI,cCBaseFIM,cItemFIM)
oReport:PrintDialog()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Claudio D. de Souza    ³ Data ³28/06/2006³±±
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
Static Function ReportDef(cRespINI,cRespFIM,cCBASEINI,cItemINI,cCBaseFIM,cItemFIM)
Local oReport,oSection1, oSection2
Local cReport := "ATFR320"
Local cAlias1 := "SND"
Local cAlias2 := "SN1"
Local cTitulo := STR0002 //"Responsáveis x Bens"
Local cDescri := STR0001 // "Este programa emite o relatório Responsáveis x Bens"
Local bReport := { |oReport| ReportPrint( oReport, cRespINI,cRespFIM,cCBASEINI,cItemINI,cCBaseFIM,cItemFIM ) }
Local aOrd := {}
Local cIdioma :=  Upper( Left( FWRetIdiom(), 2 ) )

DbSelectArea("SN1") // Forca a abertura do SN1

dbSelectArea("SIX")
dbSetOrder(1)
If MsSeek("SND",.F.)
	While !SIX->(Eof()) .and. SIX->INDICE == "SND" .and. SIX->ORDEM <= "2"


		If ( cIdioma == "ES" )
			aAdd(aOrd,SIX->DESCSPA)
		Else
			If ( cIdioma =="EN" )
				aAdd(aOrd,SIX->DESCENG)
			Else
				aAdd(aOrd,SIX->DESCRICAO)
			Endif
		Endif 

		SIX->(dbSkip())
	EndDo
Else
	aOrd 	:= {STR0005,STR0006}	///" Responsável + Bem "#" Bem + Responsáveis "
Endif

Pergunte( "AFR320" , .F. )
oReport  := TReport():New( cReport, cTitulo, "AFR320" , bReport, cDescri )
/*
GESTAO - inicio */
oReport:SetUseGC(.F.)
/* GESTAO - fim
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0009+STR0011 , {cAlias1}, aOrd )	//"Dados do Responsavel - "##"(Ordem 1)"
oSection1:SetHeaderSection(.T.)
oSection1:SetHeaderPage(.T.)
oSection1:SetLinesBefore(2)	
TRCell():New( oSection1, "ND_FILIAL"  , cAlias1  ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New( oSection1, "ND_CODRESP" , cAlias1  ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New( oSection1, "RD0_NOME"   , "RD0" 	 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)	
TRCell():New( oSection1, "RD0_FONE"   , "RD0" 	 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)	
TRCell():New( oSection1, "FILLER"     , "" 	     ,"   " /*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| "" },,,,,,.T.)
oSection1:Cell("ND_CODRESP"):SetBorder("BOTTOM")
oSection1:Cell("ND_FILIAL"):SetBorder("BOTTOM")		
oSection1:Cell("RD0_FONE"):SetBorder("BOTTOM")	
oSection1:Cell("RD0_NOME"):SetBorder("BOTTOM")	
oSection1:Cell("FILLER"):SetBorder("BOTTOM")

oSection2 := TRSection():New( oSection1, STR0010+STR0011 , {cAlias2} )		//"Dados dos Bens - "##"(Ordem 1)"
oSection2:SetHeaderPage(.T.)
oSection2:SetLinesBefore(0) 
oSection2:SetAutoSize(.T.)
TRCell():New( oSection2, "N1_FILIAL" , cAlias2 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection2, "N1_CBASE"  , cAlias2 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection2, "N1_ITEM"   , cAlias2 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection2, "N1_DESCRIC", cAlias2 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection2, "N1_CHAPA"  , cAlias2 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection2, "N1_LOCAL"  , cAlias2 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection2, "N1_QUANTD" , cAlias2 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection3 := TRSection():New( oReport, STR0010+STR0012 , {cAlias2} )		//	//"Dados dos Bens - "##"(Ordem 2)"
oSection3:SetHeaderSection(.T.)
oSection3:SetHeaderPage(.T.)
oSection3:SetAutoSize(.T.)
oSection3:SetLinesBefore(2) 
TRCell():New( oSection3, "N1_FILIAL" , cAlias2 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection3, "N1_CBASE"  , cAlias2 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection3, "N1_ITEM"   , cAlias2 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection3, "N1_DESCRIC", cAlias2 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection3, "N1_CHAPA"  , cAlias2 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection3, "N1_LOCAL"  , cAlias2 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection3, "N1_QUANTD" , cAlias2 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection3:Cell("N1_CBASE"):SetBorder("BOTTOM")
oSection3:Cell("N1_ITEM"):SetBorder("BOTTOM")
oSection3:Cell("N1_FILIAL"):SetBorder("BOTTOM")
oSection3:Cell("N1_DESCRIC"):SetBorder("BOTTOM")
oSection3:Cell("N1_CHAPA"):SetBorder("BOTTOM")
oSection3:Cell("N1_LOCAL"):SetBorder("BOTTOM")
oSection3:Cell("N1_QUANTD"):SetBorder("BOTTOM")

oSection4 := TRSection():New( oSection3, STR0009+STR0012 , {cAlias1}, aOrd )		//"Dados do Responsavel - "##"(Ordem 1)"
oSection4:SetHeaderPage(.T.)
oSection4:SetLinesBefore(0)
oSection4:SetAutoSize(.T.) 
TRCell():New( oSection4, "ND_CODRESP" , cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	
TRCell():New( oSection4, "ND_FILIAL"  , cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection4, "RD0_NOME"   , "RD0" 	 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	
TRCell():New( oSection4, "RD0_FONE"   , "RD0" 	 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Claudio D. de Souza º Data ³  23/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport, cRespINI,cRespFIM,cCBASEINI,cItemINI,cCBaseFIM,cItemFIM )
Local oSection1 := Nil
Local oSection2 := Nil
Local cChave	:= ""
Local cQuery 	:= "SND"
Local nOrder	:= 0
/* GESTAO */
Local nPos		:= 0
Local cTmpFil	:= ""
Local cFilSND	:= ""
Local cFilSN1	:= ""
Local cFilRD0	:= ""
Local cFilChv	:= ""
Local lSelFil	:= .T.
Local aSelFil	:= {}
Local aTmpFil	:= {}

nOrder	:= oReport:Section(1):GetOrder()

lSecFil := (FWSizeFilial() > 2)

// Verifica como serao impressas as secoes, conforme a ordem escolhida pelo usuario
If nOrder == 1
	oSection1 := oReport:Section(1)
	oSection2 := oReport:Section(1):Section(1)
	oReport:Section(2):Hide()
	oReport:Section(2):Section(1):Hide()
	If FWModeAccess("RD0",1) == "C" .Or. !lSecFil
		oSection1:Cell("ND_FILIAL"):Disable()
	Endif
	If FWModeAccess("SN1",1) == "C" .Or. !lSecFil
		oSection2:Cell("N1_FILIAL"):Disable()
	Endif
Else
	oSection1 := oReport:Section(2)
	oSection2 := oReport:Section(2):Section(1)
	oReport:Section(1):Hide()
	oReport:Section(1):Section(1):Hide()
	If FWModeAccess("RD0",1) == "C" .Or. !lSecFil
		oSection2:Cell("ND_FILIAL"):Disable()
	Endif
	If FWModeAccess("SN1",1) == "C" .Or. !lSecFil
		oSection1:Cell("N1_FILIAL"):Disable()
	Endif
Endif

SND->(dbSetOrder(nOrder))

If !Empty(cRespINI) .or. !Empty(cRespFim)
	mv_par01 := cRespINI
	mv_par02 := cRespFIM
	lSelFil := .F.
Endif

If !Empty(cCBaseINI) .or. !Empty(cCBaseFIM)
	mv_par03 := cCBaseINI
	mv_par05 := cCBaseFIM
	lSelFil := .F.
Endif

If !Empty(cItemINI) .or. !Empty(cItemFIM)
	mv_par04 := cItemINI
	mv_par06 := cItemFIM
	lSelFil := .F.
Endif

If lSelFil
	If MV_PAR07 == 1 
		AdmSelecFil("AFR320",07,.F.,@aSelFil,"SN1",.F.)
		If Empty(aSelFil)
			Aadd(aSelFil,cFilAnt)
		Endif
	Endif
	MsgRun(STR0013,STR0002 ,{|| cFilSND := GetRngFil(aSelFil,"SND",.T.,@cTmpFil)})		// "Favor Aguardar..."
	Aadd(aTmpFil,cTmpFil)
	cFilSND := "%SND.ND_FILIAL " + cFilSND + "%"
	/*-*/
	MsgRun(STR0013,STR0002 ,{|| cFilSN1 := GetRngFil(aSelFil,"SN1",.T.,@cTmpFil)})		//"Favor Aguardar..."
	Aadd(aTmpFil,cTmpFil)
	cFilSN1 := "%SN1.N1_FILIAL " + cFilSN1 + "%"
	/*-*/
	MsgRun(STR0013,STR0002 ,{|| cFilRD0 := GetRngFil(aSelFil,"RD0",.T.,@cTmpFil)})		//"Favor Aguardar..."
	Aadd(aTmpFil,cTmpFil)
	cFilRD0 := "%RD0.RD0_FILIAL " + cFilRD0 + "%"
	/*-*/
	cChave 	:= SqlOrder(SND->(IndexKey(nOrder)))
	If (nOrder == 1 .And. FWModeAccess("RD0",1) == "C") .Or. (nOrder == 2 .And. FWModeAccess("SN1",1) == "C")
		nPos := At("ND_FILIAL,",cChave)
		If nPos > 0
			cChave := Stuff(cChave,nPos,10,"")
		Endif
	Endif
	cChave := "%" + cChave + "%"
Else
	cFilSND := "%SND.ND_FILIAL = '" + xFilial("SND") + "'%"  
	cFilSN1 := "%SN1.N1_FILIAL = '" + xFilial("SN1") + "'%"
	cFilRD0 := "%RD0.RD0_FILIAL = '" + xFilial("RD0") + "'%"
	cChave 	:= "%"+SqlOrder(SND->(IndexKey(nOrder)))+"%"
Endif
/*-*/
cQuery 	:= GetNextAlias()

oSection1:BeginQuery()

BeginSql Alias cQuery
	SELECT
		ND_FILIAL,ND_CODRESP, RD0_CODIGO, RD0_FONE, RD0_NOME, ND_CBASE, ND_ITEM,
		N1_FILIAL,N1_CBASE, N1_ITEM, N1_DESCRIC, N1_CHAPA, N1_LOCAL, N1_QUANTD
	FROM 
		%table:SN1% SN1, %table:SND% SND, %table:RD0% RD0
	WHERE
		%Exp:cFilSND% AND
		SND.ND_CODRESP >= %Exp:mv_par01% AND 
		SND.ND_CODRESP <= %Exp:mv_par02% AND
		SND.ND_CBASE   >= %Exp:mv_par03% AND 
		SND.ND_ITEM    >= %Exp:mv_par04% AND 
		SND.ND_CBASE   <= %Exp:mv_par05% AND
		SND.ND_ITEM    <= %Exp:mv_par06% AND
		SND.ND_STATUS = '1' AND
		SND.%notDel% AND
		%Exp:cFilSN1% AND
		SN1.N1_CBASE = SND.ND_CBASE AND
		SN1.N1_ITEM  = SND.ND_ITEM AND
		SN1.%notDel% AND
		%Exp:cFilRD0% AND
		RD0.RD0_CODIGO = SND.ND_CODRESP AND
		RD0.%notDel%
	ORDER BY %Exp:cChave%
EndSql

oSection1:EndQuery()
oSection2:SetParentQuery()
	

If nOrder == 1
	oSection2:SetParentFilter({|cParam| (cQuery)->ND_CODRESP == cParam },{|| (cQuery)->ND_CODRESP })
Else
	oSection2:SetParentFilter({|cParam| (cQuery)->(ND_CBASE+ND_ITEM) == cParam },{|| (cQuery)->(ND_CBASE+ND_ITEM) })
Endif	

// Inclui condicao para imprimir a apolice caso encontre o Bem ou se nao encontrar, verifica se imprime apolice sem bens.
oSection1:SetLineCondition({||	SN1->(DbSetOrder(1)),SN1->(MsSeek(xFilial("SN1",(cQuery)->N1_FILIAL)+(cQuery)->(ND_CBASE+ND_ITEM))) } )

oSection1:Print()
/*
GESTAO */
If !Empty(aTmpFil) 
	MsgRun(STR0013,STR0002 ,{|| AEval(aTmpFil,{|tmpfil| CtbTmpErase(tmpFil)})})		//"Favor Aguardar..."
Endif
Return Nil