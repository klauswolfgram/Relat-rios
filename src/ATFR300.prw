/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "protheus.ch"
#INCLUDE "ATFR300.ch"

// 17/08/2009 - Ajuste para filiais com mais de 2 caracteres.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR300   º Autor ³ Marcos S. Lobo.    º Data ³  14/10/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatório de Cadastro das apolices de seguro.		      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ATFR300 (cApolIni,cApolFim,cCodSegIni,cCodSegFim)
Local oReport
Pergunte( "AFR300" , .F. )

oReport:=ReportDef(cApolIni,cApolFim,cCodSegIni,cCodSegFim)
oReport:PrintDialog()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Claudio D. de Souza    ³ Data ³23/06/2006³±±
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
Static Function ReportDef(cApolIni,cApolFim,cCodSegIni,cCodSegFim)
Local oReport,oSection1, oSection2, oSection3, oSection4, oSection5
Local cReport := "ATFR300"
Local cAlias1 := "SNB"
Local cTitulo := STR0003 //"Apólice de Seguro"
Local cDescri :=	STR0001 + " " +;	// "Este programa emite o relatório de cadastro das Apólices de Seguro."
					  	STR0002 + " " +;	// "Utilize o dicionario de dados para mudar a ordem/campos na impressao,"
					  	STR0018				// "exceto os campos Apolice/Cia.Seguradora/Vigencia do cabecalho."
					  	
Local bReport := { |oReport|	ReportPrint( oReport, cApolIni,cApolFim,cCodSegIni,cCodSegFim ) }
Local aOrd := {}

dbSelectArea("SIX")
dbSetOrder(1)
If MsSeek("SNB",.F.)

	While !SIX->(Eof()) .and. SIX->INDICE == "SNB" .and. SIX->ORDEM <= "2"

		aAdd(aOrd, SixDescricao())
		
		SIX->(dbSkip())
	EndDo
Else
	aOrd 	:= {STR0008,STR0009}	///"Número da Apólice + Cod. Cia. Seguro"#"Cod. Cia. Seguro + Número da Apólice"
Endif

Pergunte( "AFR300" , .F. )
oReport  := TReport():New( cReport, cTitulo, "AFR300" , bReport, cDescri )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define as secoes do relatorio		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport, STR0019 , {cAlias1}, aOrd )		//"Dados Cadastrais"
TRCell():New( oSection1, "NB_APOLICE"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "NB_DESCRIC"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection1:Cell("NB_DESCRIC"):SetCellBreak(.T.)

TRCell():New( oSection1, "NB_CODSEG"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "NB_NOMESEG"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "NB_DTINI"		, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "NB_DTVENC"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection1:Cell("NB_DTVENC"):SetCellBreak(.T.)

TRCell():New( oSection1, "NB_NMSEGUR"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "NB_NMBENEF"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection1:Cell("NB_NMBENEF"):SetCellBreak(.T.)

TRCell():New( oSection1, "NB_TIPOSEG"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "NB_DCTPSEG"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection1:Cell("NB_DCTPSEG"):SetCellBreak(.T.)

TRCell():New( oSection1, "NB_TIPOCOB"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "NB_DCTPCOB"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection1:Cell("NB_DCTPCOB"):SetCellBreak(.T.)

TRCell():New( oSection1, "NB_RENOVAC"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection1:Cell("NB_RENOVAC"):SetCellBreak(.T.)

TRCell():New( oSection1, "NB_VLRSEG"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "NB_VLRFRAN"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection1:Cell("NB_VLRFRAN"):SetCellBreak(.T.)

TRCell():New( oSection1, "NB_VLRPREM"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "NB_VLRDESC"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection1:Cell("NB_VLRDESC"):SetCellBreak(.T.)

TRCell():New( oSection1, "NB_PARCELA"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "NB_VLRPARC"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection1:Cell("NB_VLRPARC"):SetCellBreak(.T.)

TRCell():New( oSection1, "NB_DIAVENC"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection1:Cell("NB_DIAVENC"):SetCellBreak(.T.)

TRCell():New( oSection1, "NB_CODCORR"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "NB_CORRET"	, cAlias1 ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection1:Cell("NB_CORRET"):SetCellBreak(.T.)

TRCell():New( oSection1, "NB_DADOS"		, cAlias1 ,/*X3Titulo*/,/*Picture*/, 80 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection1:Cell("NB_DADOS"):SetCellBreak(.T.)

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
Static Function ReportPrint( oReport, cApolIni,cApolFim,cCodSegIni,cCodSegFim )
Local oSection1 := oReport:Section(1)
Local cQuery 	:= "SNB"
Local cChave 	:= SNB->(IndexKey(oSection1:GetOrder()))
Local oBreak

If !Empty(cApolIni) .or. !Empty(cApolFim)
	mv_par01 := cApolIni
	mv_par02 := cApolFim
Endif

If !Empty(cCodSegIni) .or. !Empty(cCodSegFim)
	mv_par01 := cCodSegIni
	mv_par02 := cCodSegFim
Endif

cQuery 	:= GetNextAlias()
cChave 	:= "%"+SqlOrder(cChave)+"%"

oSection1:BeginQuery()

BeginSql Alias cQuery
	SELECT *
	FROM 
		%table:SNB% SNB
	WHERE
		SNB.NB_FILIAL = %xfilial:SNB% AND
		SNB.NB_APOLICE >= %Exp:mv_par01% AND 
		SNB.NB_APOLICE <= %Exp:mv_par02% AND
		SNB.NB_CODSEG  >= %Exp:mv_par03% AND 
		SNB.NB_CODSEG  <= %Exp:mv_par04% AND
		SNB.%notDel% 
	ORDER BY %Exp:cChave%
EndSql
oSection1:EndQuery()


oSection1:Cell("NB_NOMESEG"):SetBlock( { || Posicione("SX5",1,xFilial("SX5")+"AS"+(cQuery)->NB_CODSEG,"X5_DESCRI") } )
oSection1:Cell("NB_DCTPSEG"):SetBlock( { || Posicione("SX5",1,xFilial("SX5")+"AT"+(cQuery)->NB_CODSEG,"X5_DESCRI") } )
oSection1:Cell("NB_DCTPCOB"):SetBlock( { || Posicione("SX5",1,xFilial("SX5")+"AU"+(cQuery)->NB_CODSEG,"X5_DESCRI") } )
oSection1:Cell("NB_DADOS"):SetBlock( { || StrTran(MEUMEMO("SNE",(cQuery)->(NB_APOLICE+NB_CODSEG),"",2), Chr(13)+Chr(10), " " ) } )

oSection1:SetLineBreak()
oSection1:SetLineStyle()
oSection1:SetLeftMargin(5)

If oSection1:GetOrder() == 1
	oBreak := TRBreak():New( oSection1, { || (cQuery)->NB_CODSEG } )
Else
	oBreak := TRBreak():New( oSection1, { || (cQuery)->NB_APOLICE } )
Endif	

oBreak:SetPageBreak(.T.)
oSection1:Print()

Return Nil
