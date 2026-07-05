/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR650.CH" 
#Include "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR650  ³ Autor ³ Marco Bianchi         ³ Data ³ 30/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Notas Fiscais por Transportadora                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT - R4                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR650()

Local aOldArea	:= GetArea()
Local oReport	:= NIL
Local aPDFields := {"A1_NOME","A2_NOME","A1_MUN","A2_MUN"}

FATPDLoad(Nil,Nil,aPDFields)
If FindFunction("TRepInUse") .And. TRepInUse()
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	U_MATR650R3()
EndIf
FATPDUnload()  
  
RestArea(aOldArea)
aSize(aOldArea,0)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 30/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport		:= Nil
Local nQuant		:= 0
Local lValAdi		:= cPaisLoc == "MEX" .AND. SD2->(FieldPos("D2_VALADI")) > 0 //  Adiantamentos Mexico 
Local cAliasQry 	:= GetNextAlias()
Local nTmF2DOC		:= TamSX3("F2_DOC")[1] + 5
Local nTmF2VOLUM	:= TamSX3("F2_VOLUME1")[1] + 5
Local nTmA1NOME		:= 30
Local nTmD2QUANT	:= TamSX3("D2_QUANT")[1] + 2
Local nTmF2VALADI	:= If(lValAdi, TamSX3("F2_VALADI")[1], 0)
Local nTmF2VALBRUT	:= TamSX3("F2_VALBRUT")[1] + 2
Local nTmA1MUN		:= 30
Local nTmA1EST		:= TamSX3("A1_EST")[1]
Local nTmF2PBRUTO	:= TamSX3("C5_PBRUTO")[1] + 5
Local cPcF2VOLUM	:= PesqPict("SF2","F2_VOLUME1")
Local cPcF2VALBRUT	:= PesqPict("SF2","F2_VALBRUT")

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
oReport := TReport():New("MATR650",STR0013,"MTR650", {|oReport| ReportPrint(oReport,cAliasQry)},STR0014 + " " + STR0015)	// "Relacao das Notas Fiscais para as Transportadoras"###"Este programa ira emitir a relacao de notas fiscais por"###"ordem de Transportadora."
oReport:SetPortrait() 
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(oReport:uParam,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao da Secao                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oNFTransp := TRSection():New(oReport, STR0024, {"SF2", "SD2", "SA4"}, /*{Array com as ordens do relatório}*/, /*Campos do SX3*/, /*Campos do SIX*/)	// "Relacao das Notas Fiscais para as Transportadoras"	
oNFTransp:SetTotalInLine(.F.)

TRCell():New(oNFTransp, "CTEXTO",                      /*Tabela*/, STR0016,                       /*Picture*/,                  11,                            /*lPixel*/, {|| STR0017})                                                      // "Data Hora"
TRCell():New(oNFTransp, "F2_DOC",                      "SF2",      RetTitle("F2_DOC"),            PesqPict("SF2","F2_DOC"),     nTmF2DOC,                      /*lPixel*/, {|| (cAliasQry)->F2_DOC},,,,,,.F.)                                 // Numero da Nota Fiscal
TRCell():New(oNFTransp, SerieNfId("SF2",3,"F2_SERIE"), "SF2",      SerieNfId("SF2",7,"F2_SERIE"), PesqPict("SF2","F2_SERIE"),   SerieNfId("SF2",6,"F2_SERIE"), /*lPixel*/, {|| Alltrim((cAliasQry)->&(SerieNfId("SF2",3,"F2_SERIE")))})       // Serie
TRCell():New(oNFTransp, "F2_VOLUME1",                  "SF2",      STR0023,                       cPcF2VOLUM,                   nTmF2VOLUM,                    /*lPixel*/, {|| (cAliasQry)->F2_VOLUME1})                                      // "Volume"
TRCell():New(oNFTransp, "CNOME",                       /*Tabela*/, STR0018,                       PesqPict("SA1","A1_NOME"),    nTmA1NOME,                     /*lPixel*/, {|| IIF((cAliasQry)->F2_TIPO $ "NCIP", FATPDObfuscate(SA1->A1_NOME,"A1_NOME"),  FATPDObfuscate(SA2->A2_NOME,"A2_NOME") )}) // "N o m e  do  C l i e n t e"
TRCell():New(oNFTransp, "NQUANT",                      /*Tabela*/, STR0019,                       PesqPict("SD2","D2_QUANT"),   nTmD2QUANT,                    /*lPixel*/, {|| nQuant})                                                       // "Quantidade"
If lValAdi
	TRCell():New(oNFTransp, "NVALADI",                 /*Tabela*/, RetTitle("F2_VALADI"),         PesqPict("SF2","F2_VALADI"),  nTmF2VALADI,                   /*lPixel*/, {|| nValadi})                                                      // "Adiantamento"
EndIf
TRCell():New(oNFTransp, "F2_VALBRUT",                  "SF2",      RetTitle("F2_VALBRUT"),        cPcF2VALBRUT,                 nTmF2VALBRUT,                  /*lPixel*/, {|| xMoeda((cAliasQry)->F2_VALBRUT,1,mv_par05,(cAliasQry)->F2_EMISSAO)}) // Valor Bruto
TRCell():New(oNFTransp, "CMUN",                        /*Tabela*/, STR0020,                       PesqPict("SA1","A1_MUN"),     nTmA1MUN,                      /*lPixel*/, {|| IIF((cAliasQry)->F2_TIPO $ "NCIP",FATPDObfuscate(SA1->A1_MUN,"A1_MUN"),FATPDObfuscate(SA2->A2_MUN,"A2_MUN"))})         // "Municipio"
TRCell():New(oNFTransp, "CEST",                        /*Tabela*/, RetTitle("A1_EST"),            PesqPict("SA1","A1_EST"),     nTmA1EST,                      /*lPixel*/, {|| IIF((cAliasQry)->F2_TIPO $ "NCIP",SA1->A1_EST,SA2->A2_EST)})         // Estado
TRCell():New(oNFTransp, "F2_PBRUTO",                   "SF2",      RetTitle("F2_PBRUTO"),         PesqPict("SC5","C5_PBRUTO"),  nTmF2PBRUTO,                   /*lPixel*/, {|| (cAliasQry)->F2_PBRUTO})                                             // Peso Bruto

TRFunction():New(oNFTransp:Cell("F2_DOC"),      /* cID */, "COUNT", /*oBreak*/, /*cTitle*/, /*cPicture*/,              /*uFormula*/, .T./*lEndSection*/, .F./*lEndReport*/, /*lEndPage*/)
TRFunction():New(oNFTransp:Cell("F2_VOLUME1"),  /* cID */, "SUM",   /*oBreak*/, /*cTitle*/, "@E 999999999999999" /*cPicture*/,   /*uFormula*/, .T./*lEndSection*/, .F./*lEndReport*/, /*lEndPage*/)
TRFunction():New(oNFTransp:Cell("NQUANT"),      /* cID */, "SUM",   /*oBreak*/, /*cTitle*/, /*cPicture*/,              /*uFormula*/, .T./*lEndSection*/, .F./*lEndReport*/, /*lEndPage*/)
If lValAdi
	TRFunction():New(oNFTransp:Cell("NVALADI"), /* cID */, "SUM",   /*oBreak*/, /*cTitle*/, /*cPicture*/,              /*uFormula*/, .T./*lEndSection*/, .F./*lEndReport*/, /*lEndPage*/)
EndIf
TRFunction():New(oNFTransp:Cell("F2_VALBRUT"),  /* cID */, "SUM",   /*oBreak*/, /*cTitle*/, cPcF2VALBRUT /*cPicture*/, /*uFormula*/, .T./*lEndSection*/, .F./*lEndReport*/, /*lEndPage*/)
TRFunction():New(oNFTransp:Cell("F2_PBRUTO"),   /* cID */, "SUM",   /*oBreak*/, /*cTitle*/, "@E 99,999,999,999.9999",  , .T./*lEndSection*/, .F./*lEndReport*/, /*lEndPage*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Cabecalho no top da pagina                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):SetHeaderPage()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Salta Pagina na Quebra da Secao                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oNFTransp:SetPageBreak(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Trsnsportadora                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oReport:Section(1),"SA4",1,{|| xFilial("SA4")+(cAliasQry)->F2_TRANSP})

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³ 30/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cAliasQry)

Local cTransp 	:= ""
Local lValAdi	:= cPaisLoc == "MEX" .AND. SD2->(FieldPos("D2_VALADI")) > 0 //  Adiantamentos Mexico
Local cExpAdi	:= Iif(lValAdi,"MIN(F2_VALADI) F2_VALADI,","")
Local cSelect	:= ""
Local cWhere    := ""
Local cFilSA1	:= xFilial("SA1")
Local cFilSA2	:= xFilial("SA2")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SetBlock: faz com que as variaveis locais possam ser         ³
//³ utilizadas em outras funcoes nao precisando declara-las      ³
//³ como private											  	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Cell("NQUANT" 	):SetBlock({|| nQuant		})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Altera o Titulo do Relatorio de acordo com parametros	 	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + " - " + GetMv("MV_MOEDA"+STR(mv_par05,1)) )	// "Relacao das Notas Fiscais para as Transportadoras"	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cWhere := "% AND NOT ("+IsRemito(2,'F2_TIPODOC')+")"
If mv_par09 == 1
	cWhere += " AND F2_TIPO <> 'D'"
EndIf
If mv_par08 == 1
	cWhere += " AND F2_TIPO <> 'B'"
EndIf
cWhere += "%"

dbSelectArea("SF2")				// Cabecalho da Nota de Saida
dbSetOrder(1)					// Documento,Serie,Cliente,Loja

cSelect := "%"
cSelect += "(F2_FILIAL) F2_FILIAL, MIN(F2_TIPO) F2_TIPO, F2_DOC,"
If Alltrim(SerieNfId("SF2",3,"F2_SERIE")) <> "F2_SERIE"
	cSelect += SerieNfId("SF2",3,"F2_SERIE") + ", "
Endif
cSelect += "F2_SERIE, MIN(F2_EMISSAO) F2_EMISSAO,"
cSelect += "MIN(F2_CLIENTE) F2_CLIENTE ,MIN(F2_LOJA) F2_LOJA ,MIN(F2_TRANSP) F2_TRANSP ,MIN(F2_VOLUME1) F2_VOLUME1,"
cSelect += cExpAdi+"%"

oReport:Section(1):BeginQuery()
BeginSql Alias cAliasQry
   SELECT MIN %Exp:cSelect%
          MIN(SF2.F2_VALBRUT) F2_VALBRUT,MIN(SF2.F2_PBRUTO) F2_PBRUTO ,MIN(SA4.A4_NOME) A4_NOME ,SUM(SD2.D2_QUANT) TOTQUANT
     FROM %Table:SF2% SF2
          LEFT JOIN %Table:SA4% SA4 ON SA4.A4_FILIAL = %xFilial:SA4%
                                   AND SA4.A4_COD = SF2.F2_TRANSP
                                   AND SA4.%notdel%,
          %Table:SD2% SD2
    WHERE SF2.F2_FILIAL = %xFilial:SF2%
      AND SD2.D2_FILIAL = %xFilial:SD2%
      AND SF2.%NotDel%
      AND SD2.%NotDel%
      AND SF2.F2_DOC >= %Exp:mv_par03%
      AND SF2.F2_DOC <= %Exp:mv_par04%
      AND SF2.F2_EMISSAO >= %Exp:DTOS(mv_par06)%
      AND SF2.F2_EMISSAO <= %Exp:DTOS(mv_par07)%
      AND SF2.F2_TRANSP >= %Exp:mv_par01%
      AND SF2.F2_TRANSP <= %Exp:mv_par02%
      AND SF2.F2_DOC = SD2.D2_DOC
      AND SF2.F2_SERIE = SD2.D2_SERIE
      %Exp:cWhere%
   GROUP BY SF2.F2_FILIAL, SF2.F2_TRANSP, SF2.F2_DOC, SF2.F2_SERIE
   ORDER BY SF2.F2_FILIAL, SF2.F2_TRANSP, SF2.F2_DOC, SF2.F2_SERIE
EndSql
 
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter((cAliasQry)->(LastRec()))
dbSelectArea(cAliasQry)
oReport:Section(1):Init()
                          
While !oReport:Cancel() .And. !(cAliasQry)->(Eof())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona Transportadora                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cTransp := (cAliasQry)->F2_TRANSP

	oReport:PrintText(STR0022 + " " + (cAliasQry)->F2_TRANSP + " - " + (cAliasQry)->A4_NOME)	// "Transportadora"
	oReport:SkipLine()

	dbSelectArea(cAliasQry)	
	While ! oReport:Cancel() .And. !(cAliasQry)->(Eof()) .And. (cAliasQry)->F2_TRANSP == cTransp 
		nQuant := (cAliasQry)->TOTQUANT
		nValadi	:= IIf(lValAdi,(cAliasQry)->F2_VALADI,0)
		If !(cAliasQry)->F2_TIPO $ "DB"
			TRPosition():New(oReport:Section(1),"SA1",1,{|| cFilSA1+(cAliasQry)->F2_CLIENTE+(cAliasQry)->F2_LOJA })
		Else
			TRPosition():New(oReport:Section(1),"SA2",1,{|| cFilSA2+(cAliasQry)->F2_CLIENTE+(cAliasQry)->F2_LOJA })
		Endif	
		oReport:Section(1):PrintLine()
		dbSelectArea(cAliasQry)
		dbSkip()
		oReport:IncMeter()
	EndDo
	
	oReport:Section(1):SetTotalText(STR0021 + " " + cTransp)	// "Total da Transportadora"
	oReport:Section(1):Finish()

	// Forca salto de pagina no fim da secao
	oReport:nrow := 5000			
	oReport:skipLine()
	oReport:Section(1):Init()
EndDo

oReport:Section(1):SetPageBreak(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha Query/SetFilter                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
(cAliasQry)->(dbCloseArea())
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR650R3³ Autor ³ Wagner Xavier         ³ Data ³ 05.09.91 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Notas Fiscais por Transportadora                ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_MATR650R3(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Verificar indexacao dentro de programa (provisoria)        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Viviani       ³09/11/98³Melhor³Conversao utillizando xMoeda            ³±±
±±³Viviani       ³23/12/98³18923 ³Acerto do calculo do valor total da nota³±±
±±³              ³        ³      ³para aceitar produto negativo(desconto) ³±±
±±³ Edson   M.   ³30/03/99³XXXXXX³Passar o tamanho na SetPrint.           ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Matr650R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local CbTxt
Local titulo
Local cDesc1 := OemToAnsi(STR0001)	//"Este programa ira emitir a relacao de notas fiscais por"
Local cDesc2 := OemToAnsi(STR0002)	//"ordem de Transportadora."
Local cDesc3 :=""
Local CbCont
Local wnrel
Local tamanho:="M"
Local limite := 132
Local cString:="SF2"

PRIVATE aReturn := { STR0003, 1,STR0004, 1, 2, 1, "",1 }		//"Zebrado"###"Administracao"
PRIVATE nomeprog:="MATR650"
PRIVATE aLinha  := { }
PRIVATE nLastKey := 0
PRIVATE cPerg   :="MTR650"
PRIVATE cVolPict:= PesqPict("SF2","F2_VOLUME1",8)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta cabecalhos e verifica tipo de impressao                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := OemToAnsi(STR0005)	//"Relacao das Notas Fiscais para as Transportadoras"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Imporessao do Cabecalho e Rodape   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       :=80
m_pag    :=1
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("MTR650",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01        	// Da Transportadora                        ³
//³ mv_par02        	// Ate a Transportadora                     ³
//³ mv_par03        	// Da Nota                                  ³
//³ mv_par04        	// Ate a Nota                               ³
//³ mv_par05        	// Qual moeda                               ³
//³ mv_par06        	// Da Emissao                               ³
//³ mv_par07        	// Ate Emissao                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="MATR650"            //Nome Default do relatorio em Disco

wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If nLastKey==27
	dbClearFilter()
   Return
Endif

SetDefault(aReturn,cString)

If nLastKey==27
	dbClearFilter()
   Return
Endif

RptStatus({|lEnd| C650Imp(@lEnd,wnRel,cString)},Titulo)
Return 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ C650IMP  ³ Autor ³ Rosane Luciane Chene  ³ Data ³ 09.11.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR650			                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function C650Imp(lEnd,WnRel,cString)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local CbTxt
Local titulo
Local CbCont
Local cabec1
Local cabec2
Local tamanho	:= "M"
Local nNumNota
Local nTotVol
Local nTotQtde
Local nTotPeso
Local nTotVal
Local nQuant
Local lContinua	:= .T.
Local nTamNF	:= TamSX3("F2_DOC")[1]
Local cCond		:= ""
Local cSerieView:= ""
Local cFilSF2	:= xFilial("SF2")
Local cFilSA1	:= xFilial("SA1")
Local cFilSA2	:= xFilial("SA2")
Local cFilSA4	:= xFilial("SA4")
Local cFilSD2	:= xFilial("SD2")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta cabecalhos e verifica tipo de impressao                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := STR0006 + " - " + GetMv("MV_MOEDA" + STR(MV_PAR05,1))//"RELACAO DAS NOTAS FISCAIS PARA AS TRANSPORTADORAS - MOEDA"
cabec1 := IIF(mv_par08==1,STR0007,STR0012)	//"REC.DEP  |EMPRESA N.FISCAL          VOLUME  N O M E  D O  C L I E N T E    QUANTIDADE        VALOR  MUNICIPIO        UF  PESO BRUTO "
//      				012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//      				0         1         2         3         4         5         6         7         8         9        10        11        12        13        14
cabec2 := STR0008	//"DATA HORA|"

nTipo  := IIF(aReturn[4]==1,15,18)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Imporessao do Cabecalho e Rodape   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

SD2->(dbSetorder(3))

dbSelectArea("SF2")
cIndice := criatrab("",.f.)
cCond   := "Dtos(F2_EMISSAO)>='"+Dtos(mv_par06)+"'.And.Dtos(F2_EMISSAO)<='"+Dtos(mv_par07)+"'"
cCond   += " .And. !("+IsRemito(2,'SF2->F2_TIPODOC')+")"

IndRegua("SF2",cIndice,"F2_FILIAL+F2_TRANSP+F2_DOC+F2_SERIE",,cCond,STR0009)		//"Selecionando Registros..."
SetRegua(RecCount())		// Total de Elementos da regua

SF2->(dbSeek(cFilSF2+mv_par01,.T.))
While SF2->(! Eof()) .And. SF2->F2_FILIAL == cFilSF2 .And. SF2->F2_TRANSP >= mv_par01 .And. SF2->F2_TRANSP <= mv_par02 .And. lContinua

	IF lEnd
		@PROW()+1,001 Psay STR0010	//"CANCELADO PELO OPERADOR"
		EXIT
	ENDIF
	IncRegua()

	If	( mv_par09 == 1 .And. SF2->F2_TIPO == "D" ) .OR.;
		( mv_par08 == 1 .And. SF2->F2_TIPO == "B" ) .OR.;
		SF2->F2_DOC < mv_par03                      .OR.;
		SF2->F2_DOC > mv_par04
		SF2->(DbSkip())
		Loop
	EndIf

	li := 80
	nNumNota := nTotVol := nTotQtde := nTotPeso := nTotVal := nQuant := 0
	cTransp := SF2->F2_TRANSP
	dbSelectArea("SF2")
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	@ li,04 Psay '|    | ' + SF2->F2_TRANSP + ' - ' + Posicione("SA4",1,cFilSA4+cTransp,"PadR(SA4->A4_NOME,40)")
	li++
	@ li,04 Psay '|    | '
	While SF2->(! Eof()) .And. SF2->F2_FILIAL == cFilSF2 .And. SF2->F2_TRANSP == cTransp 

		IF lEnd
			@PROW()+1,001 Psay STR0010		//"CANCELADO PELO OPERADOR"
			lContinua := .F.
			Exit
		Endif
		IncRegua()

		IF	( mv_par09 == 1 .And. SF2->F2_TIPO == "D" ) .OR.;
			( mv_par08 == 1 .And. SF2->F2_TIPO == "B" ) .OR.;
			SF2->F2_DOC < mv_par03                      .OR.;
			SF2->F2_DOC > mv_par04
			SF2->(dbSkip())
			Loop
		EndIF
		
		cNota      := SF2->F2_DOC + SF2->F2_SERIE
		cSerieView := SerieNfId("SF2",2,"F2_SERIE")
		SD2->(dbSeek(cFilSD2+SF2->F2_DOC+SF2->F2_SERIE))
		While SD2->(! Eof()) .And. SD2->D2_FILIAL == cFilSD2 .And. SD2->D2_DOC == SF2->F2_DOC .AND. SD2->D2_SERIE == SF2->F2_SERIE
			nQuant += SD2->D2_QUANT
			SD2->(dbSkip())
		EndDo

		IF li > 53
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		EndIF
		
		li++
		@ li,004 Psay '|    | '
		@ li,018 Psay Substr(cNota,1,ntamNF) +"-"+cSerieView
		@ li,035 Psay SF2->F2_VOLUME1   PicTure cVolPict 
		If SF2->F2_TIPO <> "B"
			IF SA1->(dbSeek(cFilSA1+SF2->F2_CLIENTE+SF2->F2_LOJA))
				@ li,044 Psay FATPDObfuscate(SUBSTR(SA1->A1_NOME,1,25),"A1_NOME") 
			EndIF
		Else
			IF SA2->(dbSeek(cFilSA2+SF2->F2_CLIENTE+SF2->F2_LOJA))
				@ li,044 Psay FATPDObfuscate(SUBSTR(SA2->A2_NOME,1,25),"A2_NOME")      
			EndIF
		Endif	
		@ li,071 Psay nQuant                                             PicTure TM(nQuant,11)
		@ li,083 Psay xMoeda(SF2->F2_VALBRUT,1,mv_par05,SF2->F2_EMISSAO) PicTure TM(SF2->F2_VALBRUT,15)  
		@ li,100 Psay IIF(SF2->F2_TIPO<>"B",FATPDObfuscate(PadR(SA1->A1_MUN,15),"A1_MUN"),FATPDObfuscate(PadR(SA2->A2_MUN,15),"A2_MUN"))  
		@ li,117 Psay IIF(SF2->F2_TIPO<>"B",SA1->A1_EST,SA2->A2_EST)
		@ li,122 Psay SF2->F2_PBRUTO                                     Picture PesqPict("SC5","C5_PBRUTO")
		nNumNota++
		nTotVol		+= SF2->F2_VOLUME1
		nTotQtde	+= nQuant
		nTotVal		+= SF2->F2_VALBRUT
		nTotPeso	+= SF2->F2_PBRUTO
		nQuant		:= 0
		SF2->(dbSkip())
	EndDo
	@ ++li, 04 Psay '|    |'
	@ ++li, 00 Psay __PrtFatLine()
	@ ++li, 02 Psay STR0011	//"TOTAL ------->"
	@ li,   18 Psay nNumNota                                   PicTure '999'
	@ li,   35 Psay nTotVol                                    PicTure cVolPict
	@ li,   71 Psay nTotQtde                                   PicTure TM(nTotQtde,11)
	@ li,   82 Psay xMoeda(nTotVal,1,mv_par05,SF2->F2_EMISSAO) PicTure TM(nTotVal,16)
	@ li,  120 Psay nTotPeso                                   PicTure TM(nTotPeso,11,4)
	@ ++li, 00 Psay __PrtFatLine()
	dbSelectArea("SF2")
	nNumNota := 0
	nTotVol := 0
	nTotQtde := 0
	nTotVal := 0
	nTotPeso := 0
EndDo

If li != 80
	roda(cbcont,cbtxt)
Endif

SD2->(dbSetOrder(1))

RetIndex("SF2")
dbClearFilter()
fErase(cIndice+OrdBagExt())

If aReturn[5] == 1
	Set Printer TO 
	dbCommitAll()
	ourspool(wnrel)
Endif

MS_FLUSH()
Return .T.




//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDLoad
    @description
    Inicializa variaveis com lista de campos que devem ser ofuscados de acordo com usuario.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cUser, Caractere, Nome do usuário utilizado para validar se possui acesso ao 
        dados protegido.
    @param aAlias, Array, Array com todos os Alias que serão verificados.
    @param aFields, Array, Array com todos os Campos que serão verificados, utilizado 
        apenas se parametro aAlias estiver vazio.
    @param cSource, Caractere, Nome do recurso para gerenciar os dados protegidos.
    
    @return cSource, Caractere, Retorna nome do recurso que foi adicionado na pilha.
    @example FATPDLoad("ADMIN", {"SA1","SU5"}, {"A1_CGC"})
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDLoad(cUser, aAlias, aFields, cSource)
	Local cPDSource := ""

	If FATPDActive()
		cPDSource := FTPDLoad(cUser, aAlias, aFields, cSource)
	EndIf

Return cPDSource


//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDUnload
    @description
    Finaliza o gerenciamento dos campos com proteção de dados.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cSource, Caractere, Remove da pilha apenas o recurso que foi carregado.
    @return return, Nulo
    @example FATPDUnload("XXXA010") 
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDUnload(cSource)    

    If FATPDActive()
		FTPDUnload(cSource)    
    EndIf

Return Nil

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @sample FATPDObfuscate("999999999","U5_CEL")
    @author Squad CRM & Faturamento
    @since 04/12/2019
    @version P12
    @param xValue, (caracter,numerico,data), Valor que sera ofuscado.
    @param cField, caracter , Campo que sera verificado.
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado

    @return xValue, retorna o valor ofuscado.
/*/
//-----------------------------------------------------------------------------
Static Function FATPDObfuscate(xValue, cField, cSource, lLoad)
    
    If FATPDActive()
		xValue := FTPDObfuscate(xValue, cField, cSource, lLoad)
    EndIf

Return xValue   


//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    Função que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive  
