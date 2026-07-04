/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "COMR100.ch"
#INCLUDE "PROTHEUS.CH"
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³COMR100   ³ Autor ³ Nereu Humberto Junior ³ Data ³23.06.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao dos documentos de cobertura                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
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
User Function COMR100()
Local oReport

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()
oReport:PrintDialog()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Nereu Humberto Junior  ³ Data ³23.06.2006³±±
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

Local oReport 
Local oSection1
Local oSection2 
Local oCell         
Local aOrdem := {}
Local aTabelas := {"SDH"}
Local cAliasSDH := GetNextAlias()
Local cTamQtd := TamSX3('DH_QUANT')[1]
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
oReport:= TReport():New("COMR100",STR0001,"COM100", {|oReport| ReportPrint(oReport,cAliasSDH)},STR0002+" "+STR0003) // "Relação dos documentos de cobertura "##"Este relatório demonstra os documentos de cobertura recebidos e pendentes"##"com o objetivo de auxiliar no follow-up destes documentos."
oReport:SetLandscape() 
oReport:SetTotalInLine(.F.)
oReport:SetUseGC(.F.)

Pergunte("COM100",.F.)

Aadd( aOrdem, STR0004 ) // "Documento"
Aadd( aOrdem, STR0005 ) // "Cliente/Fornecedor+Documento"

//-- Só adiciona SA1 e SA2 no personalizável quando não compartilhado ou sem gestão de empresas
//-- Isto para habilitar o recurso de impressão em N filiais (botão Gestão de Empresas)
If FWModeAccess("SA1",1) == "E" .Or. (At("E",FWSM0Layout()) == 0 .And. At("U",FWSM0Layout()) == 0)
	aAdd(aTabelas,"SA1")
EndIf
If FWModeAccess("SA2",1) == "E" .Or. (At("E",FWSM0Layout()) == 0 .And. At("U",FWSM0Layout()) == 0)
	aAdd(aTabelas,"SA2")
EndIf
oSection1 := TRSection():New(oReport,STR0027,aTabelas,aOrdem) //"Relação dos documentos de cobertura "
oSection1 :SetTotalInLine(.F.)

TRCell():New(oSection1,"cCodigo","   ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIf(!Empty((cAliasSDH)->DH_CLIENTE),SA1->A1_COD,SA2->A2_COD) })
oSection1:Cell("cCodigo"):GetFieldInfo("A1_COD")
TRCell():New(oSection1,"cLoja","   ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIf(!Empty((cAliasSDH)->DH_CLIENTE),SA1->A1_LOJA,SA2->A2_LOJA) })
oSection1:Cell("cLoja"):GetFieldInfo("A1_LOJA")
TRCell():New(oSection1,"A1_NOME","   ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIf(!Empty((cAliasSDH)->DH_CLIENTE),SA1->A1_NOME,SA2->A2_NOME) })
oSection1:Cell("A1_NOME"):GetFieldInfo("A1_NOME")

//-- Só adiciona SB1 no personalizável quando não compartilhado ou sem gestão de empresas
//-- Isto para habilitar o recurso de impressão em N filiais (botão Gestão de Empresas)
If FWModeAccess("SB1",1) == "E" .Or. (At("E",FWSM0Layout()) == 0 .And. At("U",FWSM0Layout()) == 0)
	oSection2 := TRSection():New(oSection1,STR0028,{"SDH","SD1","SB6","SB1"})
Else
	oSection2 := TRSection():New(oSection1,STR0028,{"SDH","SD1","SB6"})
EndIf 
oSection2 :SetHeaderPage()
oSection2 :SetTotalInLine(.F.)

TRCell():New(oSection2,"D1_SERIE"	,"SD1",STR0015				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Serie"
TRCell():New(oSection2,"D1_DOC"		,"SD1",STR0016				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Numero"
TRCell():New(oSection2,"D1_ITEM"	,"SD1",STR0017				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Item"
TRCell():New(oSection2,"D1_FORNECE"	,"SD1",STR0018+CRLF+STR0020	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Cliente/Fornecedor"##"<--Doc.Entrada-->"
TRCell():New(oSection2,"D1_LOJA"	,"SD1",STR0019				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Loja"

TRCell():New(oSection2,"DH_SERIE"	,"SDH",STR0015				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"DH_DOC"		,"SDH",STR0016				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"DH_CLIENTE"	,"SDH",STR0018+CRLF+STR0021	,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIf(!Empty((cAliasSDH)->DH_CLIENTE),(cAliasSDH)->DH_CLIENTE,(cAliasSDH)->DH_FORNECE)})
TRCell():New(oSection2,"DH_LOJACLI"	,"SDH",STR0019				,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIf(!Empty((cAliasSDH)->DH_CLIENTE),(cAliasSDH)->DH_LOJACLI,(cAliasSDH)->DH_LOJAFOR) })

TRCell():New(oSection2,"cSerCob"	,"   ",STR0015,PesqPict("SD1","D1_SERIE"),3,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"cDocCob"	,"   ",STR0016,PesqPict("SD1","D1_DOC"),TamSX3("F2_DOC")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"cFornCob"	,"   ",STR0018+CRLF+STR0022,PesqPict("SD1","D1_FORNECE"),6,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"cLojaCob"	,"   ",STR0019,PesqPict("SD1","D1_LOJA"),2,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"dPrazCob"	,"   ",STR0024,TM(0,5,0),5,/*lPixel*/,/*{|| code-block de impressao }*/)

TRCell():New(oSection2,"B6_SERIE"	,"SB6",STR0015				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"B6_DOC"		,"SB6",STR0016				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"B6_CLIFOR"	,"SB6",STR0018+CRLF+STR0023	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"B6_LOJA"	,"SB6",STR0019				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"B6_QUANT"	,"SB6",/*Titulo*/			,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"B1_COD"		,"SB1",STR0025				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"nQtdOri"	,"   ",/*Titulo*/			,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection2:Cell("nQtdOri"):GetFieldInfo("DH_QUANT")
TRCell():New(oSection2,"nSaldo","   ",STR0026,PesqPict("SDH","DH_QUANT"),cTamQtd,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
	
Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Nereu Humberto Junior  ³ Data ³21.06.2006³±±
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
Static Function ReportPrint(oReport,cAliasSDH)

Local oSection1 := oReport:Section(1) 
Local oSection2 := oReport:Section(1):Section(1)  
Local nOrdem    := oReport:Section(1):GetOrder() 
Local cAliasSDH2:= GetNextAlias()
Local cSerie    := ""
Local cDoc      := ""
Local cItem     := ""
Local cCliente  := ""
Local cLojaCli  := ""
Local cFornece  := ""
Local cLojaFor  := ""
Local cArqInd   := ""
Local dDataEnt  := Ctod("")
Local dDataCob  := Ctod("")
Local lTemCob   := .F.
Local lTemSai   := .F.
Local nQtdOri   := 0
Local nSaldo    := 0
Local cQuebra   := ""
Local cOrder    := ""
Local cWhere    := ""
Local cIdWhere  := ""
Local cTES      := ""
Local cProduto  := ""
Local cQuebraSDH:= ""
Private cNDoc	:= ""
If nOrdem == 1
	oReport:SetTitle( oReport:Title()+" - "+STR0004) // "Documento"
	oSection1:Disable()
ElseIf nOrdem == 2
	oReport:SetTitle( oReport:Title()+" - "+STR0005) // "Cliente/Fornecedor+Documento"
Endif
TRFunction():New(oSection2:Cell("nQtdOri"),NIL,"SUM",/*oBreak*/,"",/*cPicture*/,/*uFormula*/,.F.,.T.) 
TRFunction():New(oSection2:Cell("nSaldo"),NIL,"SUM",/*oBreak*/,"",/*cPicture*/,/*uFormula*/,.F.,.T.) 

cArqInd := CriaTrab(,.F.)
dbSelectArea("SDH")
If FieldPos("DH_NDOC") > 0
	cNDoc := "S" 
EndIf

ChkFile("SDH",.F.,cAliasSDH2)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³	
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):BeginQuery()	

cWhere :="%"
cWhere += "AND ((DH_CLIENTE >= '"+MV_PAR01+"'   AND "
cWhere += "DH_CLIENTE		<= '"+MV_PAR02+"'   AND "
cWhere += "DH_LOJACLI	    >= '"+MV_PAR03+"'   AND "
cWhere += "DH_LOJAFOR	    <= '"+MV_PAR04+"')  OR  "
cWhere += "(DH_FORNECE		>= '"+MV_PAR01+"'   AND "
cWhere += "DH_FORNECE		<= '"+MV_PAR02+"'   AND "
cWhere += "DH_LOJAFOR		>= '"+MV_PAR03+"'   AND "
cWhere += "DH_LOJAFOR	    <= '"+MV_PAR04+"')) "	
Do Case
	Case mv_par11 == 2
		cWhere += " AND DH_SALDO <> 0 "
	Case mv_par11 == 3
		cWhere += " AND DH_SALDO  = 0 "
EndCase
cWhere +="%"	

cOrder := "%"
If nOrdem == 1
	cOrder += "DH_FILIAL,DH_SERIE,DH_DOC,DH_CLIENTE,DH_LOJACLI,DH_FORNECE,DH_LOJAFOR,DH_TPMOV" 
Else
	cOrder += "DH_FILIAL,DH_CLIENTE,DH_LOJACLI,DH_FORNECE,DH_LOJAFOR,DH_SERIE,DH_DOC,DH_TPMOV"
EndIf
cOrder += "%"


// Tratamento para queria com o novo numero de serie
cIdWhere := "%"
cIdWhere += SerieNfId("SDH",3,"DH_SERIE")+" >='" + mv_par05 + "' AND "
cIdWhere += SerieNfId("SDH",3,"DH_SERIE")+" <='" + mv_par06 + "' AND "
cIdWhere += "%"

BeginSql Alias cAliasSDH

SELECT SDH.*

FROM %table:SDH% SDH

WHERE DH_FILIAL = %xFilial:SDH% AND 
	  DH_OPER IN ('1','2','3') AND
	  DH_TPMOV IN ('1','2') AND 	  
	  %Exp:cIdWhere% 
	  DH_DOC >= %Exp:mv_par07% AND 
	  DH_DOC <= %Exp:mv_par08% AND 	 	  
	  DH_DTDIGIT >= %Exp:Dtos(mv_par09)% AND 
	  DH_DTDIGIT <= %Exp:Dtos(mv_par10)% AND 		  
	  SDH.%NotDel% 
	  %Exp:cWhere%
	  
ORDER BY %Exp:cOrder%
		
EndSql 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo EndQuery ( Classe TRSection )                                    ³
//³                                                                        ³
//³Prepara o relatório para executar o Embedded SQL.                       ³
//³                                                                        ³
//³ExpA1 : Array com os parametros do tipo Range                           ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

oSection2:SetParentQuery()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo TrPosition()                                                     ³
//³                                                                        ³
//³Posiciona em um registro de uma outra tabela. O posicionamento será     ³
//³realizado antes da impressao de cada linha do relatório.                ³
//³                                                                        ³
//³                                                                        ³
//³ExpO1 : Objeto Report da Secao                                          ³
//³ExpC2 : Alias da Tabela                                                 ³
//³ExpX3 : Ordem ou NickName de pesquisa                                   ³
//³ExpX4 : String ou Bloco de código para pesquisa. A string será macroexe-³
//³        cutada.                                                         ³
//³                                                                        ³				
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter(SDH->(LastRec()))

oSection2:Init()
dbSelectArea(cAliasSDH)
While !oReport:Cancel() .And. (cAliasSDH)->(!Eof()) .And. xFilial("SDH")==(cAliasSDH)->DH_FILIAL
	If oReport:Cancel()
		Exit
	EndIf

	// Tratamento para nao imprimir duas vezes as informacoes do mesmo doc.vinculado
	If (cAliasSDH)->(DH_FILIAL+DH_DOC+DH_SERIE+DH_ITEM+DH_CLIENTE+DH_LOJACLI+DH_FORNECE+DH_LOJAFOR) == cQuebraSDH
		(cAliasSDH)->(dbSkip())
		Loop
	EndIf

	oReport:IncMeter()
	
	If nOrdem == 2
		If cQuebra <> (cAliasSDH)->(DH_CLIENTE+DH_LOJACLI+DH_FORNECE+DH_LOJAFOR)
			If !Empty((cAliasSDH)->DH_CLIENTE)
				dbSelectArea("SA1")
				dbSetOrder(1)
				MsSeek(xFilial("SA1")+(cAliasSDH)->DH_CLIENTE+(cAliasSDH)->DH_LOJACLI)
				oSection1:Cell("cCodigo"):SetTitle(STR0011) //Cliente
			Else
				dbSelectArea("SA2")
				dbSetOrder(1)
				MsSeek(xFilial("SA2")+(cAliasSDH)->DH_FORNECE+(cAliasSDH)->DH_LOJAFOR)
				oSection1:Cell("cCodigo"):SetTitle(STR0012) //Fornecedor
			EndIf
			oSection1:Init()
			oSection1:PrintLine()
			oSection1:Finish()
		EndIf
	EndIf
	
	cQuebra   := (cAliasSDH)->(DH_CLIENTE+DH_LOJACLI+DH_FORNECE+DH_LOJAFOR)
	cSerie    := (cAliasSDH)->DH_SERIE
	cDoc      := (cAliasSDH)->DH_DOC
	cItem     := (cAliasSDH)->DH_ITEM
	cCliente  := (cAliasSDH)->DH_CLIENTE
	cLojaCli  := (cAliasSDH)->DH_LOJACLI
	cFornece  := (cAliasSDH)->DH_FORNECE
	cLojaFor  := (cAliasSDH)->DH_LOJAFOR
	nQtdOri   := (cAliasSDH)->DH_QUANT
	nSaldo    := (cAliasSDH)->DH_SALDO
	
	oSection2:Cell("nQtdOri"):SetValue(nQtdOri)
	oSection2:Cell("nSaldo"):SetValue(nSaldo)
	
	dbSelectArea("SD1")
	dbSetOrder(4)
	MsSeek(xFilial("SD1")+(cAliasSDH)->DH_IDENTNF)
	dDataEnt := SD1->D1_DTDIGIT
	
	dbSelectArea("SB1")
	dbSetOrder(1)
	MsSeek(xFilial("SB1")+SD1->D1_COD)
	
	oSection2:Cell("D1_SERIE"):SetValue(SerieNfId("SD1",2,"D1_SERIE"))
	oSection2:Cell("D1_DOC"):SetValue(SD1->D1_DOC)  
	oSection2:Cell("D1_ITEM"):SetValue(SD1->D1_ITEM)
	oSection2:Cell("D1_FORNECE"):SetValue(SD1->D1_FORNECE)
	oSection2:Cell("D1_LOJA"):SetValue(SD1->D1_LOJA)
	
	dbSelectArea(cAliasSDH2)
	dbSetOrder(2)
	MsSeek(xFilial("SDH")+"2"+cSerie+cDoc+cItem+cCliente+cLojaCli+cFornece+cLojaFor)
	
	lTemCob := .F.
	
	oSection2:Cell("cSerCob"):Show()
	oSection2:Cell("cDocCob"):Show()
	oSection2:Cell("cFornCob"):Show()
	oSection2:Cell("cLojaCob"):Show()
	oSection2:Cell("dPrazCob"):Show()	
    
	oSection2:Cell("B6_SERIE"):Show()
	oSection2:Cell("B6_DOC"):Show()
	oSection2:Cell("B6_CLIFOR"):Show()
	oSection2:Cell("B6_LOJA"):Show()
	oSection2:Cell("B6_QUANT"):Show()
	
	
	While ( !Eof() .And.;
		xFilial("SDH")==(cAliasSDH2)->DH_FILIAL .And.;
		cSerie == (cAliasSDH2)->DH_SERIE .And.;
		cDoc == (cAliasSDH2)->DH_DOC .And.;
		cItem == (cAliasSDH2)->DH_ITEM .And.;
		cCliente == (cAliasSDH2)->DH_CLIENTE .And.;
		cLojaCli == (cAliasSDH2)->DH_LOJACLI .And.;
		cFornece  == (cAliasSDH2)->DH_FORNECE .And.;
		cLojaFor == (cAliasSDH2)->DH_LOJAFOR ) 
		
		If !Empty(MV_PAR09) .And. ((cAliasSDH2)->DH_DTDIGIT<MV_PAR09 .Or. (cAliasSDH2)->DH_DTDIGIT>MV_PAR10 )
			(cAliasSDH2)->(dBSkip())
			Loop			
		EndIf

		lTemCob := .T.
	
		dbSelectArea("SD1")
		dbSetOrder(4)
		If MsSeek(xFilial("SD1")+(cAliasSDH2)->DH_IDENTNF)
			dDataCob := SD1->D1_DTDIGIT
			If cNDoc == "S" 
				If !Empty((cAliasSDH2)->DH_NDOC)
					oSection2:Cell("D1_DOC"):SetValue((cAliasSDH2)->DH_NDOC)
				EndIf	
			EndIf		
			oSection2:Cell("cSerCob"):SetValue(SerieNfId("SD1",2,"D1_SERIE"))
			oSection2:Cell("cDocCob"):SetValue(SD1->D1_DOC)
			oSection2:Cell("cFornCob"):SetValue(SD1->D1_FORNECE)
			oSection2:Cell("cLojaCob"):SetValue(SD1->D1_LOJA)
			oSection2:Cell("dPrazCob"):SetValue(dDataCob - dDataEnt)
			cTES := SD1->D1_TES
			cProduto := SD1->D1_COD
		Else
			dbSelectArea("SD2")
			dbSetOrder(4)
			If MsSeek(xFilial("SD2")+(cAliasSDH2)->DH_IDENTNF)
				dDataCob := SD2->D2_EMISSAO
				
				oSection2:Cell("cSerCob"):SetValue(SerieNfId("SD2",2,"D2_SERIE"))
				oSection2:Cell("cDocCob"):SetValue(SD2->D2_DOC)
				oSection2:Cell("cFornCob"):SetValue(SD2->D2_CLIENTE)
				oSection2:Cell("cLojaCob"):SetValue(SD2->D2_LOJA)
				oSection2:Cell("dPrazCob"):SetValue(dDataCob - dDataEnt)
				cTES := SD2->D2_TES
				cProduto := SD2->D2_COD
			EndIf
		EndIf

		dbSelectArea("SF4")
		dbSetOrder(1)
		MsSeek(xFilial("SF4")+cTES)
		
		If SF4->F4_PODER3 == "R"
			lTemSai := .F.
			
			dbSelectArea("SB6")
			dbSetOrder(3)
			MsSeek(xFilial("SB6")+(cAliasSDH2)->DH_IDENTNF+cProduto+"D")
			
			oSection2:Cell("B6_SERIE"):Show()
			oSection2:Cell("B6_DOC"):Show()
			oSection2:Cell("B6_CLIFOR"):Show()
			oSection2:Cell("B6_LOJA"):Show()
			oSection2:Cell("B6_QUANT"):Show()
		
			While (!Eof() .And. SB6->B6_FILIAL == xFilial("SB6") .And.;
				(cAliasSDH2)->DH_IDENTNF == SB6->B6_IDENT .And.;
				cProduto == SB6->B6_PRODUTO .And.;
				"D" == SB6->B6_PODER3)

				oSection2:Cell("B6_SERIE"):SetValue(SB6->B6_SERIE)
				oSection2:Cell("B6_DOC"):SetValue(SB6->B6_DOC)
				oSection2:Cell("B6_CLIFOR"):SetValue(SB6->B6_CLIFOR)
				oSection2:Cell("B6_LOJA"):SetValue(SB6->B6_LOJA)
				oSection2:Cell("B6_QUANT"):SetValue(SB6->B6_QUANT)

				lTemSai := .T.				

				dbSelectArea("SB6")
				dbSkip()
			EndDo
			
			If !lTemSai  
			 	oSection2:Cell("B6_SERIE"):SetValue("***")
				oSection2:Cell("B6_DOC"):SetValue("******") 
				oSection2:Cell("B6_CLIFOR"):SetValue("******") 
				oSection2:Cell("B6_LOJA"):SetValue("**") 
			 	oSection2:Cell("B6_QUANT"):Hide()
			Else
				oSection2:Cell("B6_SERIE"):Show()
				oSection2:Cell("B6_DOC"):Show()
				oSection2:Cell("B6_CLIFOR"):Show()
				oSection2:Cell("B6_LOJA"):Show()
				oSection2:Cell("B6_QUANT"):Show()
			EndIf				
		Else
		 	oSection2:Cell("B6_SERIE"):SetValue("***")
			oSection2:Cell("B6_DOC"):SetValue("******") 
			oSection2:Cell("B6_CLIFOR"):SetValue("******") 
			oSection2:Cell("B6_LOJA"):SetValue("**") 
		 	oSection2:Cell("B6_QUANT"):Hide()
		EndIf

		cTES := ""
		cProduto := ""

		oSection2:PrintLine()
		dbSelectArea(cAliasSDH2)
		dbSkip()
		
	EndDo
	
	If !lTemCob 
		oSection2:Cell("cSerCob"):SetValue("***")
		oSection2:Cell("cDocCob"):SetValue("******")  
		oSection2:Cell("cFornCob"):SetValue("******")
		oSection2:Cell("cLojaCob"):SetValue("**")  
		oSection2:Cell("dPrazCob"):Hide()
		
	 	oSection2:Cell("B6_SERIE"):SetValue("***")
		oSection2:Cell("B6_DOC"):SetValue("******") 
		oSection2:Cell("B6_CLIFOR"):SetValue("******") 
		oSection2:Cell("B6_LOJA"):SetValue("**") 
	 	oSection2:Cell("B6_QUANT"):Hide()
	 	
		oSection2:PrintLine()            
	EndIf

	cQuebraSDH := (cAliasSDH)->(DH_FILIAL+DH_DOC+DH_SERIE+DH_ITEM+DH_CLIENTE+DH_LOJACLI+DH_FORNECE+DH_LOJAFOR)

	dbSelectArea(cAliasSDH)
	dbSkip()

	oReport:IncMeter()
		
EndDo
If nOrdem == 2
	oSection1:Finish()
Endif	
        
oReport:SkipLine()
oReport:PrintText("* = "+STR0013)
oSection2:Finish()

Return NIL
