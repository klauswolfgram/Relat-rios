/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Protheus.ch"
#INCLUDE "pmsr140.ch"
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)

//--------------------------------RELEASE 4-----------------------------------------//
User Function PMSR140()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte("PMR140", .F.)

oReport := ReportDef()
oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Paulo Carnelossi    º Data ³  22/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Release 4                                                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportDef()
Local cPerg			:= "PMR140"
Local cDesc1   := STR0001 //"Este relatorio ira imprimir a curva ABC dos custos previstos para a execucao do projeto de acordo com parametros solicitados."
Local cDesc2   := "" 
Local cDesc3   := ""

Local oReport
Local oProjeto
Local oTarefa1Rec, oTarefa2Rec, oTarefa3Rec, oTarefa4Rec, oTarefa5Rec, oTarefa6Rec 

Local aOrdem  := {	STR0003,; //"PROJETO+PRODUTO+DESPESA"###"TAREFA+PRODUTO+DESPESA"
					STR0004,; //"TAREFA"###"COMPOSICAO"###"SUB-COMPOSICAO"
					STR0012,; 
					STR0013,; 
					STR0014,; 
               STR0024 } // "GRUPO DE COMPOSICAO"

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

oReport := TReport():New("PMSR140",STR0002, cPerg, ;
			{|oReport| ReportPrint(oReport)},;
			cDesc1 )

oReport:SetLandScape()

oProjeto := TRSection():New(oReport, STR0029, {"AF8"}, aOrdem /*{}*/, .F., .F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRCell():New(oProjeto,	"AF8_PROJET","AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"AF8_DESCRI","AF8",/*Titulo*/,/*Picture*/,40/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"AF8_REVISA","AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
oProjeto:Cell("AF8_DESCRI"):SetLineBreak()
oProjeto:SetLineStyle()

//-------------------------------------------------------------
oTarefa1Rec := TRSection():New(oReport, STR0031, { "AF8", "SB1", "AE8" }, /*{aOrdem}*/, .F., .F.)

TRCell():New(oTarefa1Rec, "AFA_TP_REC","","Tp."/*Titulo*/,/*Picture*/,3/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa1Rec, "B1_COD","SB1",/*Titulo*/,/*Picture*/,15/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa1Rec, "B1_DESC","SB1",/*Titulo*/,/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa1Rec, "B1_UM","SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa1Rec, "AFA_QUANT","AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa1Rec, "AFA_CUSTD","AFA",STR0039/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa1Rec, "AFA_PERC1","","%"+STR0037/*Titulo*/,"@E 999.99%"/*Picture*/,7/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"Previsto"###"%Proj."
TRCell():New(oTarefa1Rec, "AFA_PERC2","","%"+STR0038/*Titulo*/,"@E 999.99%"/*Picture*/,7/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"Previsto"###"%Proj."

oTarefa1Rec:Cell("B1_DESC"):SetLineBreak()

//-------------------------------------------------------------
oTarefa2Rec := TRSection():New(oReport, STR0032, { "AF9", "AF8", "SB1", "AE8" }, /*{aOrdem}*/, .F., .F.)

TRCell():New(oTarefa2Rec, "AF9_TAREFA","AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa2Rec, "AF9_DESCRI","AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa2Rec, "AFA_TP_REC","","Tp."/*Titulo*/,/*Picture*/,3/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa2Rec, "B1_COD","SB1",/*Titulo*/,/*Picture*/,15/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa2Rec, "B1_DESC","SB1",/*Titulo*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa2Rec, "B1_UM","SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa2Rec, "AFA_QUANT","AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa2Rec, "AFA_CUSTD","AFA",STR0039/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa2Rec, "AFA_PERC1","","%"+STR0037/*Titulo*/,"@E 999.99%"/*Picture*/,7/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"Previsto"###"%Proj."
TRCell():New(oTarefa2Rec, "AFA_PERC2","","%"+STR0038/*Titulo*/,"@E 999.99%"/*Picture*/,7/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"Previsto"###"%Proj."


oTarefa2Rec:Cell("AF9_DESCRI"):SetLineBreak()
oTarefa2Rec:Cell("B1_DESC"):SetLineBreak()

//-------------------------------------------------------------
oTarefa3Rec := TRSection():New(oReport, STR0033, { "AF9", "AF8" }, /*{aOrdem}*/, .F., .F.)

TRCell():New(oTarefa3Rec, "AF9_TAREFA","AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa3Rec, "AF9_DESCRI","AF9",/*Titulo*/,/*Picture*/,55/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa3Rec, "B1_UM","SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa3Rec, "AFA_QUANT","AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa3Rec, "AFA_CUSTD","AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa3Rec, "AFA_PERC1","","%"+STR0037/*Titulo*/,"@E 999.99%"/*Picture*/,7/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"Previsto"###"%Proj."
TRCell():New(oTarefa3Rec, "AFA_PERC2","","%"+STR0038/*Titulo*/,"@E 999.99%"/*Picture*/,7/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"Previsto"###"%Proj."

oTarefa3Rec:Cell("AF9_DESCRI"):SetLineBreak()

//-------------------------------------------------------------
oTarefa4Rec := TRSection():New(oReport, STR0034, {"AE1"}, /*{aOrdem}*/, .F., .F.)

TRCell():New(oTarefa4Rec, "AE1_COMPOS","AE1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa4Rec, "AE1_DESCRI","AE1",/*Titulo*/,/*Picture*/,55/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa4Rec, "B1_UM","SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa4Rec, "AFA_QUANT","AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa4Rec, "AFA_CUSTD","AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa4Rec, "AFA_PERC1","","%"+STR0037/*Titulo*/,"@E 999.99%"/*Picture*/,7/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"Previsto"###"%Proj."
TRCell():New(oTarefa4Rec, "AFA_PERC2","","%"+STR0038/*Titulo*/,"@E 999.99%"/*Picture*/,7/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"Previsto"###"%Proj."

oTarefa4Rec:Cell("AE1_DESCRI"):SetLineBreak()

//-------------------------------------------------------------
oTarefa5Rec := TRSection():New(oReport, STR0035, { "AE1" }, /*{aOrdem}*/, .F., .F.)

TRCell():New(oTarefa5Rec, "AE1_COMPOS","AE1",STR0040/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa5Rec, "AE1_DESCRI","AE1",/*Titulo*/,/*Picture*/,55/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa5Rec, "B1_UM","SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa5Rec, "AFA_CUSTD","AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa5Rec, "AFA_PERC1","","%"+STR0037/*Titulo*/,"@E 999.99%"/*Picture*/,7/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"Previsto"###"%Proj."
TRCell():New(oTarefa5Rec, "AFA_PERC2","","%"+STR0038/*Titulo*/,"@E 999.99%"/*Picture*/,7/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"Previsto"###"%Proj."

oTarefa5Rec:Cell("AE1_DESCRI"):SetLineBreak()

//-------------------------------------------------------------
oTarefa6Rec := TRSection():New(oReport, STR0036, { "AE5"}, /*{aOrdem}*/, .F., .F.)

TRCell():New(oTarefa6Rec, "AE5_GRPCOM","AE5",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa6Rec, "AE5_DESCRI","AE5",/*Titulo*/,/*Picture*/,55/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa6Rec, "AFA_QUANT","AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa6Rec, "AFA_CUSTD","AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa6Rec, "AFA_PERC1","","%"+STR0037/*Titulo*/,"@E 999.99%"/*Picture*/,7/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"Previsto"###"%Proj."
TRCell():New(oTarefa6Rec, "AFA_PERC2","","%"+STR0038/*Titulo*/,"@E 999.99%"/*Picture*/,7/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"Previsto"###"%Proj."

oTarefa6Rec:Cell("AE5_DESCRI"):SetLineBreak()


Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Paulo Carnelossi   º Data ³  22/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Release 4                                                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrint(oReport)

Local nOrder  		:= oReport:Section(1):GetOrder()

Local oProjeto 		:= oReport:Section(1)
Local oTarefa1Rec	:= oReport:Section(2)
Local oTarefa2Rec	:= oReport:Section(3)
Local oTarefa3Rec	:= oReport:Section(4)
Local oTarefa4Rec	:= oReport:Section(5)
Local oTarefa5Rec	:= oReport:Section(6)
Local oTarefa6Rec	:= oReport:Section(7)
Local oTarefa
Local oBreak2
Local oTotal2

Local aABC	   	:= {}
Local nCusto   	:= 0
Local nCustoTsk	:= 0
Local nX       	:= 0
Local nPerAcum 	:= 0
Local AF9_FERRAM	:= 0
Local Cabec1 	:= ""
Local Cabec2 	:= ""
Local lUsaAJT	:= .F.
Local lQuebra   := .T.

Local lImpPrd 	:= (mv_par06 == 01 .Or. mv_par06 == 04) 
Local lImpIns 	:= (mv_par06 == 02 .Or. mv_par06 == 04)
Local lImpRec 	:= (mv_par06 == 03 .Or. mv_par06 == 04)

Local cParamRev := Mv_Par05
Local cObfNRecur := IIF(FATPDIsObfuscate("AE8_DESCRI",,.T.),FATPDObfuscate("RESOURCE NAME","AE8_DESCRI",,.T.),"")        

	oProjeto:Cell("AF8_REVISA")		:SetBlock( {|| cParamRev } )
	
	oTarefa1Rec:Cell("AFA_TP_REC")	:SetBlock( { || aABC[nx,1] } )
	oTarefa1Rec:Cell("B1_COD")		:SetBlock( { || If(aABC[nx,1]=="PRD", SB1->B1_COD,	If(aABC[nx,1]=="REC", AE8->AE8_RECURS, aABC[nx,2]                                                                                                                           )) } )
	oTarefa1Rec:Cell("B1_DESC")		:SetBlock( { || If(aABC[nx,1]=="PRD", SB1->B1_DESC, If(aABC[nx,1]=="REC", IIF(Empty(cObfNRecur),AE8->AE8_DESCRI,cObfNRecur), If(aABC[nx,1]=="DSP", Tabela("FD",aABC[nx,2],.F.), If(aABC[nx,1]=="INS", Left(AJY->AJY_DESC,55), If(aABC[nx,1]=="FER", STR0044, ""))))) } )
	oTarefa1Rec:Cell("B1_UM")		:SetBlock( { || If(aABC[nx,1]=="PRD", SB1->B1_UM,	If(aABC[nx,1]=="REC", "HR",            If(aABC[nx,1]=="INS", AJY->AJY_UM , "")                                                                                              )) } )
	oTarefa1Rec:Cell("AFA_QUANT")	:SetBlock( { || If(aABC[nx,1]=="PRD", aABC[nx,4],	If(aABC[nx,1]=="REC", aABC[nx,4],      If(aABC[nx,1]=="INS", aABC[nx,4], 0)                                                                                                 )) } )
	oTarefa1Rec:Cell("AFA_CUSTD")	:SetBlock( { || aABC[nx,5] } )
	oTarefa1Rec:Cell("AFA_PERC1")	:SetBlock( { || aABC[nx,5]/nCusto*100 } )
	oTarefa1Rec:Cell("AFA_PERC2")	:SetBlock( { || nPerAcum } )

	oTarefa2Rec:Cell("AFA_TP_REC")	:SetBlock( { || aABC[nx,1] } )
	oTarefa2Rec:Cell("B1_COD")		:SetBlock( { || If(aABC[nx,1]=="PRD", SB1->B1_COD,	If(aABC[nx,1]=="REC", AE8->AE8_RECURS, aABC[nx,2]                                                                                                                           )) } )
	oTarefa2Rec:Cell("B1_DESC")		:SetBlock( { || If(aABC[nx,1]=="PRD", SB1->B1_DESC, If(aABC[nx,1]=="REC", IIF(Empty(cObfNRecur),AE8->AE8_DESCRI,cObfNRecur), If(aABC[nx,1]=="DSP", Tabela("FD",aABC[nx,2],.F.), If(aABC[nx,1]=="INS", Left(AJY->AJY_DESC,55), If(aABC[nx,1]=="FER", STR0044, ""))))) } )
	oTarefa2Rec:Cell("B1_UM")		:SetBlock( { || If(aABC[nx,1]=="PRD", SB1->B1_UM,	If(aABC[nx,1]=="REC", "HR",            If(aABC[nx,1]=="INS", AJY->AJY_UM , "")                                                                                              )) } )
	oTarefa2Rec:Cell("AFA_QUANT")	:SetBlock( { || If(aABC[nx,1]=="PRD", aABC[nx,4],	If(aABC[nx,1]=="REC", aABC[nx,4],      If(aABC[nx,1]=="INS", aABC[nx,4], 0)                                                                                                 )) } )
	oTarefa2Rec:Cell("AFA_CUSTD")	:SetBlock( { || aABC[nx,5] } )
	oTarefa2Rec:Cell("AFA_PERC1")	:SetBlock( { || aABC[nx,5]/nCusto*100 } )
	oTarefa2Rec:Cell("AFA_PERC2")	:SetBlock( { || nPerAcum } )
	
	oBreak2:= TRBreak():New(oTarefa2Rec,{||lQuebra := !lQuebra},StrTran(STR0011,".....", " Trf."))
	oTotal2:= TRFunction():New(oTarefa2Rec:Cell("AFA_CUSTD"),"NCUSTOTSK" ,"SUM",oBreak2,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
	oTotal2:SetFormula({||nCustoTsk })
	oTotal2:SetTotalInLine(.F.) 
	
	oTarefa3Rec:Cell("AF9_TAREFA")	:SetBlock( { || aABC[nx,1] } )
	oTarefa3Rec:Cell("AF9_DESCRI")	:SetBlock( { || Left(aABC[nx,2],55)} )
	oTarefa3Rec:Cell("B1_UM")		:SetBlock( { || aABC[nx,3] } )
	oTarefa3Rec:Cell("AFA_QUANT")	:SetBlock( { || aABC[nx,4] } )
	oTarefa3Rec:Cell("AFA_CUSTD")	:SetBlock( { || aABC[nx,5] } )
	oTarefa3Rec:Cell("AFA_PERC1")	:SetBlock( { || aABC[nx,5]/nCusto*100 } )
	oTarefa3Rec:Cell("AFA_PERC2")	:SetBlock( { || nPerAcum } )
	
	oTarefa4Rec:Cell("AE1_COMPOS")	:SetBlock( { || aABC[nx,1] } )
	oTarefa4Rec:Cell("AE1_DESCRI")	:SetBlock( { || If(aABC[nx,1]=="OTR", STR0021, Left(AE1->AE1_DESCRI,55) ) } ) //"OUTROS" 
	oTarefa4Rec:Cell("B1_UM")		:SetBlock( { || aABC[nx,3] } )
	oTarefa4Rec:Cell("AFA_QUANT")	:SetBlock( { || aABC[nx,4] } )
	oTarefa4Rec:Cell("AFA_CUSTD")	:SetBlock( { || aABC[nx,5] } )
	oTarefa4Rec:Cell("AFA_PERC1")	:SetBlock( { || aABC[nx,5]/nCusto*100 } )
	oTarefa4Rec:Cell("AFA_PERC2")	:SetBlock( { || nPerAcum } )
	
	oTarefa5Rec:Cell("AE1_COMPOS")	:SetBlock( { || If(aABC[nx,1] == "OTR", aABC[nx,1], aABC[nx,2]) } )
	oTarefa5Rec:Cell("AE1_DESCRI")	:SetBlock( { || If(aABC[nx,1]=="OTR", STR0021, Left(AE1->AE1_DESCRI,55) ) } ) //"OUTROS"oTarefa5Rec:Cell("B1_UM")		:SetBlock( { || aABC[nx,3] }
	oTarefa5Rec:Cell("AFA_CUSTD")	:SetBlock( { || aABC[nx,5] } )
	oTarefa5Rec:Cell("AFA_PERC1")	:SetBlock( { || aABC[nx,5]/nCusto*100 } )
	oTarefa5Rec:Cell("AFA_PERC2")	:SetBlock( { || nPerAcum } )
	
	oTarefa6Rec:Cell("AE5_GRPCOM")	:SetBlock( { || aABC[nx,1] } )
	oTarefa6Rec:Cell("AE5_DESCRI")	:SetBlock( { || If(aABC[nx,1]=="OTR", STR0021, Left(AE5->AE5_DESCRI,55) ) } )  //"OUTROS"
	oTarefa6Rec:Cell("AFA_QUANT")	:SetBlock( { || aABC[nx,4] } )
	oTarefa6Rec:Cell("AFA_CUSTD")	:SetBlock( { || aABC[nx,5] } )
	oTarefa6Rec:Cell("AFA_PERC1")	:SetBlock( { || aABC[nx,5]/nCusto*100 } )
	oTarefa6Rec:Cell("AFA_PERC2")	:SetBlock( { || nPerAcum } )

/* DEFINICAO DO ARRAY aABC
PARA PRODUTOS/DESPESAS/INSUMOS
1- TIPO (PRD/DSP/INSUMOS)
2- CODIGO PRODUTO/DESCRICAO DESPESA
3- TAREFA   
4- QUANTIDADE PRODUTO
5- VALOR PRODUTO / VALOR DESPESA / VALOR INSUMO

PARA TAREFAS
1- TAREFA
2- DESCRICAO TAREFA
3- UNIDADE DE MEDIDA             
4- QUANTIDADE TAREFA
5- CUSTO TAREFA    

PARA COMPOSICAO E SUB-COMPOSICAO
1- COMPOSICAO DA TAREFA
2- SUB-COMPOSICAO
3- UNIDADE DE MEDIDA             
4- QUANTIDADE TAREFA
5- CUSTO TAREFA    

PARA GRUPO
1- GRUPO
2- DESCRICAO
3- UNIDADE DE MEDIDA             
4- QUANTIDADE TAREFA
5- CUSTO TAREFA    
*/

	Do Case 
		Case nOrder == 1
			oReport:SetTitle(STR0002) //"Curva ABC"
			oTarefa := oTarefa1Rec
			
		Case nOrder == 2
			oReport:SetTitle(STR0002) //"Curva ABC"
			oTarefa := oTarefa2Rec
			
		Case nOrder == 3
			oReport:SetTitle(STR0016) //"Curva ABC das Tarefas dos Orcamentos"
			oTarefa := oTarefa3Rec
	
		Case nOrder == 4
			oReport:SetTitle(STR0018) //"Curva ABC das Composicoes dos Orcamentos"
			oTarefa := oTarefa4Rec
	
		Case nOrder == 5
			oReport:SetTitle(STR0020) //"Curva ABC das Sub-Composicoes dos Orcamentos"
			oTarefa := oTarefa5Rec
			
		Case nOrder == 6
			oReport:SetTitle(STR0022) //"Curva ABC dos Grupos de Composicoes dos Orcamentos"
			oTarefa := oTarefa6Rec
	
	EndCase
	
	oTarefa:SetHeaderPage()
	oReport:SetMeter(AF8->(LastRec()))
	
	dbSelectArea("AF8")
	dbSetOrder(1)
	MsSeek(xFilial("AF8") + Mv_Par01,.T.)
	
	oProjeto:Init()

	While !Eof() .And. (xFilial("AF8") == AF8->AF8_FILIAL)  .And. (AF8->AF8_PROJET >= mv_par01) .And. (AF8->AF8_PROJET <= mv_par02).AND. !oReport:Cancel()

		oReport:IncMeter()

		// executa o filtro do usuario
		If !Empty(oProjeto:GetAdvplExp()) .And. !&(oProjeto:GetAdvplExp())
			dbSelectArea("AF8")
			dbSkip()
			Loop
		EndIf

		// verifica a data do projeto
		If AF8->AF8_DATA > mv_par04 .Or. AF8->AF8_DATA < mv_par03
			dbSelectArea("AF8")
			dbSkip()
			Loop
		EndIf
    	
		// versao do Projeto
		Mv_Par05 := iIf(Empty(cParamRev) ,AF8->AF8_REVISA ,cParamRev)

		// carrega os valores do projeto
		Pmr140_Ini(oReport, @aABC, @nCusto, lUsaAJT )
	
		If (Len(aABC) > 0)

			oProjeto:PrintLine()
			oTarefa:Init()
            
			For nX:= 1 To Len(aABC)

				Do Case 
					Case nOrder == 1 //Por Orcamento
						If aABC[nx,1]=="PRD"
							If lImpPrd 
								SB1->(dbSetOrder(1))
								SB1->(MsSeek(xFilial("SB1") + aABC[nx,2]))
								nPerAcum += aABC[nx,5]/nCusto*100

								oTarefa:PrintLine()

							EndIf
		
						ElseIf aABC[nx,1]=="REC"
							If lImpRec
								AE8->(dbSetOrder(1))
								AE8->(MsSeek(xFilial("AE8") + aABC[nx,2]))
								nPerAcum += aABC[nx,5]/nCusto*100

								oTarefa:PrintLine()

							EndIf

						ElseIf aABC[nx,1]=="DSP"
							SX5->(dbSetOrder(1))
							SX5->(MsSeek(xFilial() + "FD" + aABC[nx,2]))
							nPerAcum += aABC[nx,5]/nCusto*100				
							oTarefa:Cell("AFA_QUANT"):Hide()
							oTarefa:PrintLine()
							oTarefa:Cell("AFA_QUANT"):Show()
							
						ElseIf aABC[nx,1]=="INS"
							If lImpIns
								DbSelectArea( "AJY" )
								AJY->( DbSetOrder( 1 ) )
								AJY->( DbGoTo( aABC[nx,6] ) )
								If AJY->( !Eof() )
									nPerAcum += aABC[nx,5]/nCusto*100
									oTarefa:PrintLine()
								EndIf
							EndIf

						ElseIf aABC[nx,1]=="FER"
							nPerAcum += aABC[nx,5]/nCusto*100
							oTarefa:Cell("AFA_QUANT"):Hide()
							oTarefa:PrintLine()
							oTarefa:Cell("AFA_QUANT"):Show()

						EndIf

					Case nOrder == 2 //Por Tarefa

						nCustoTsk+= aABC[nx,5]
						AF9->(dbSetOrder(1))
						AF9->(dbSeek(xFilial("AF9")+AF8->AF8_PROJET+Mv_Par05+aABC[nx,3]))
		
						If aABC[nx,1] == "PRD"

							If lImpPrd

								SB1->(dbSetOrder(1))
								SB1->(dbSeek(xFilial("SB1")+aABC[nx,2]))
								nPerAcum += aABC[nx,5]/nCusto*100
								
								oTarefa:PrintLine()
																
							EndIf
														
						ElseIf aABC[nx,1]=="REC"
							If lImpRec
								AE8->(dbSetOrder(1))
								AE8->(MsSeek(xFilial("AE8") + aABC[nx,2]))
								nPerAcum += aABC[nx,5]/nCusto*100

								oTarefa:PrintLine()

							EndIf
						ElseIf aABC[nx,1] == "DSP"

							SX5->(dbSetOrder(1))
							SX5->(MsSeek(xFilial() + "FD" + aABC[nx,2]))
							nPerAcum += aABC[nx,5]/nCusto*100
							oTarefa:Cell("AFA_QUANT"):Hide()
							oTarefa:PrintLine()
							oTarefa:Cell("AFA_QUANT"):Show()

						ElseIf aABC[nx,1]=="INS"
							If lImpIns
								DbSelectArea( "AJY" )
								AJY->( DbSetOrder( 1 ) )
								AJY->( DbGoTo( aABC[nx,6] ) )
								If AJY->( !Eof() )
									nPerAcum += aABC[nx,5]/nCusto*100
									oTarefa:PrintLine()
								EndIf
							EndIf

						ElseIf aABC[nx,1]=="FER"
							nPerAcum += aABC[nx,5]/nCusto*100
							oTarefa:Cell("AFA_QUANT"):Hide()
							oTarefa:PrintLine()
							oTarefa:Cell("AFA_QUANT"):Show()

						EndIf	

					Case nOrder == 3 //Tarefas
					
						nPerAcum += aABC[nx,5]/nCusto*100

						AF9->(dbSetOrder(1))
						AF9->(dbSeek(xFilial("AF9")+AF8->AF8_PROJET+Mv_Par05+aABC[nx,1]))
						
						oTarefa:PrintLine()

					Case (nOrder == 4)  //Composicao 

						If (aABC[nx,1] != "OTR")
							AE1->(dbSetOrder(1))
							AE1->(MsSeek(xFilial("AE1") + aABC[nx,1]))
						EndIf
						nPerAcum += aABC[nx,5]/nCusto*100
						
						oTarefa:PrintLine()

					Case (nOrder == 5)  //Sub-Composicao

						If (aABC[nx,1] != "OTR")
							AE1->(dbSetOrder(1))
							AE1->(MsSeek(xFilial("AE1") + aABC[nx,2]))
						EndIf
						nPerAcum += aABC[nx,5]/nCusto*100
						
						oTarefa:PrintLine()
						
					Case (nOrder == 6)  //Grupo de Composicao

						If (aABC[nx,1] != "OTR")
							AE5->(dbSetOrder(1))
							AE5->(MsSeek(xFilial("AE5") + aABC[nx,1]))
						EndIf
						nPerAcum += aABC[nx,5]/nCusto*100
						
						oTarefa:PrintLine()
												
		        EndCase
						
                If nOrder == 2 //Por Tarefa+produto+Despesa
					nCustoTsk:= 0
				EndIf
				
			Next nX
            
            oTarefa:Finish()

			oReport:ThinLine()
		
			oReport:SkipLine()
			oReport:PrintText( STR0011, oReport:Row(), 10) //"Total....."
			oReport:PrintText( Transform(nCusto,PesqPict("AFA","AFA_CUSTD")), oReport:Row(), oTarefa:Cell("AFA_CUSTD"):ColPos()-20 ) 
			oReport:SkipLine()
	
			oReport:FatLine()
			oReport:SkipLine()
		
		EndIf

		aABC     := {}
		nPerAcum := 0
		nCustoTsk:= 0
		nCusto   := 0

		dbSelectArea("AF8")
		dbSkip()
		
	End

	// verifica o cancelamento pelo usuario..
	If oReport:Cancel()
		oReport:PrintText( STR0041, oReport:Row(), 10) //"*** CANCELADO PELO OPERADOR ***"
	EndIf
	

	oProjeto:Finish()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ PMR140_Ini  ³ Autor ³Fabio Rogerio Pereira³ Data ³16.09.2002³±±
±±³          ³             ³       ³Paulo Carnelossi(R4) ³      ³22.08.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Avalia os dados do PROJETO								   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Pmr140_Ini(oReport, aPar1, nPar1)				               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Pmr140_Ini(oReport, aABC,nCusto, lUsaAJT )
Local nOrder  		:= oReport:Section(1):GetOrder()
Local aArea    		:= GetArea()
Local nPos     		:= 0
Local nQuantAFA		:= 0
Local nValorAFB		:= 0
Local cCompos  		:= ""
Local nDecCst		:= TamSX3("AF9_CUSTO")[2]
Local cTrunca		:= "1"

DEFAULT lUsaAJT		:= .F.

/* DEFINICAO DO ARRAY aABC
PARA PRODUTOS/DESPESAS
1- TIPO (PRD/DSP)
2- CODIGO PRODUTO/DESCRICAO DESPESA
3- TAREFA   
4- QUANTIDADE PRODUTO
5- VALOR PRODUTO / VALOR DESPESA

PARA TAREFAS
1- TAREFA
2- DESCRICAO TAREFA
3- UNIDADE DE MEDIDA             
4- QUANTIDADE TAREFA
5- CUSTO TAREFA    

PARA COMPOSICAO E SUB-COMPOSICAO
1- COMPOSICAO DA TAREFA
2- SUB-COMPOSICAO
3- UNIDADE DE MEDIDA             
4- QUANTIDADE TAREFA
5- CUSTO TAREFA    
*/

If (nOrder == 1 .Or. nOrder == 2) 
	dbSelectArea("AF9")
	dbSetOrder(1)
	If MsSeek(xFilial("AF9")+AF8->AF8_PROJET+Mv_Par05)
		While !Eof() .And. (xFilial("AF9")+AF8->AF8_PROJET+Mv_Par05 == AF9->AF9_FILIAL+AF9->AF9_PROJET+AF9->AF9_REVISA)

			// verifica os produtos do orcamento
			dbSelectArea("AFA")
			dbSetOrder(1)
			If MsSeek(xFilial("AFA")+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA)

				DbSelectArea("AF8")
					DbSetOrder(1)
					If (MSseek(XFILIAL("AFA")+AFA->AFA_PROJET))
						cTrunca:=AF8->AF8_TRUNCA
					Else
						cTrunca:="1"
					EndIf
				
				While !Eof() .And. (xFilial("AFA")+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA == AFA->AFA_FILIAL+AFA->AFA_PROJET+AFA->AFA_REVISA+AFA->AFA_TAREFA)
									
					If nOrder == 1 //Por Orcamento
						If (Empty(AFA->AFA_RECURS))
							nPos     := aScan(aABC,{|x| x[1] == "PRD" .And. x[2] == AFA->AFA_PRODUT})
						Else                                                                         
							nPos     := aScan(aABC,{|x| x[1] == "REC" .And. x[2] == AFA->AFA_RECURS})
						EndIf
	
					ElseIf nOrder == 2 //Por Tarefa
						If (Empty(AFA->AFA_RECURS))
							nPos     := aScan(aABC,{|x| x[1] == "PRD" .And. x[2] == AFA->AFA_PRODUT .And. x[3]== AFA->AFA_TAREFA})
						Else                                                                         
							nPos     := aScan(aABC,{|x| x[1] == "REC" .And. x[2] == AFA->AFA_RECURS .And. x[3]== AFA->AFA_TAREFA})
						EndIf
					EndIf
		
					nQuantAFA:= PmsAFAQuant(AFA->AFA_PROJET,AFA->AFA_REVISA,AFA->AFA_TAREFA,AFA->AFA_PRODUT,AF9->AF9_QUANT,AFA->AFA_QUANT,AF9->AF9_HDURAC)
					If (nPos > 0)
						aABC[nPos,4]+= nQuantAFA
						aABC[nPos,5]+= xMoeda(PmsTrunca(cTrunca,nQuantAFA * AFA->AFA_CUSTD,nDecCst,AF9->AF9_QUANT),AFA->AFA_MOEDA,1)
					Else
						If (Empty(AFA->AFA_RECURS))
							aAdd(aABC,{"PRD",AFA->AFA_PRODUT,AFA->AFA_TAREFA,nQuantAFA,xMoeda(PmsTrunca(cTrunca,nQuantAFA * AFA->AFA_CUSTD,nDecCst,AF9->AF9_QUANT),AFA->AFA_MOEDA,1)})
						Else                                                                                                                                            
							aAdd(aABC,{"REC",AFA->AFA_RECURS,AFA->AFA_TAREFA,nQuantAFA,xMoeda(PmsTrunca(cTrunca,nQuantAFA * AFA->AFA_CUSTD,nDecCst,AF9->AF9_QUANT),AFA->AFA_MOEDA,1)})
						Endif
					EndIf
						
					nCusto += xMoeda(PmsTrunca(cTrunca,nQuantAFA * AFA->AFA_CUSTD,nDecCst,AF9->AF9_QUANT),AFA->AFA_MOEDA,1)
//					oReport:IncMeter()
					dbSelectArea("AFA")
					dbSkip()
				End
			EndIf
			
			// verifica as despesa do orcamento
			dbSelectArea("AFB")
			dbSetOrder(1)
			If MsSeek(xFilial("AFB")+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA)
				While !Eof() .And. (xFilial("AFB")+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA == AFB->AFB_FILIAL+AFB->AFB_PROJET+AFB->AFB_REVISA+AFB->AFB_TAREFA)
									
					If nOrder == 1 //Por Orcamento
						nPos     := aScan(aABC,{|x| x[1] == "DSP" .And. x[2] == AFB->AFB_TIPOD})
		
					ElseIf nOrder == 2 //Por Tarefa
						nPos     := aScan(aABC,{|x| x[1] == "DSP" .And. x[2] == AFB->AFB_TIPOD .And. x[3] == AFB->AFB_TAREFA})
					EndIf
		
					nValorAFB:= PmsTrunca(cTrunca,PmsAFBValor(AF9->AF9_QUANT,AFB->AFB_VALOR),nDecCst,AF9->AF9_QUANT)
					If (nPos > 0)
						aABC[nPos,5]+= xMoeda(nValorAFB,AFB->AFB_MOEDA,1)
					Else
						aAdd(aABC,{"DSP",AFB->AFB_TIPOD,AFB->AFB_TAREFA,0,xMoeda(nValorAFB,AFB->AFB_MOEDA,1)})
					EndIf
						
					nCusto += xMoeda(nValorAFB,AFB->AFB_MOEDA,1)
					
//					oReport:IncMeter()
					dbSelectArea("AFB")
					dbSkip()
				End
			EndIf
		    
//			oReport:IncMeter()
			dbSelectArea("AF9")
			dbSkip()
		End
	EndIf	
	
ElseIf nOrder == 3 //Tarefa
	dbSelectArea("AF9")
	dbSetOrder(1)
	If MsSeek(xFilial("AF9")+AF8->AF8_PROJET+Mv_Par05)
		While !Eof() .And. (xFilial("AF9")+AF8->AF8_PROJET+Mv_Par05 == AF9->AF9_FILIAL+AF9->AF9_PROJET+AF9->AF9_REVISA)

			nPos     := aScan(aABC,{|x| x[1] == AF9->AF9_TAREFA})
	
			If (nPos > 0)
				aABC[nPos,5]+= AF9->AF9_CUSTO
			Else
				aAdd(aABC,{AF9->AF9_TAREFA,AF9->AF9_DESCRI,AF9->AF9_UM,AF9->AF9_QUANT,AF9->AF9_CUSTO})
			EndIf
						
			nCusto += AF9->AF9_CUSTO
//			oReport:IncMeter()
			dbSelectArea("AF9")
			dbSkip()
		End
	EndIf

ElseIf nOrder == 4 //Composicao
	dbSelectArea("AF9")
	dbSetOrder(3)
	If MsSeek(xFilial("AF9")+AF8->AF8_PROJET+Mv_Par05)
		While !Eof() .And. (xFilial("AF9")+AF8->AF8_PROJET+Mv_Par05 == AF9->AF9_FILIAL+AF9->AF9_PROJET+AF9->AF9_REVISA)
	
			If !Empty(AF9->AF9_COMPOS)
				nPos     := aScan(aABC,{|x| x[1] == AF9->AF9_COMPOS})
		
				If (nPos > 0)
					aABC[nPos,5]+= AF9->AF9_CUSTO
				Else
					aAdd(aABC,{AF9->AF9_COMPOS,"",AF9->AF9_UM,AF9->AF9_QUANT,AF9->AF9_CUSTO})
				EndIf
			Else
				nPos     := aScan(aABC,{|x| x[1] == "OTR"})
		
				If (nPos > 0)
					aABC[nPos,5]+= AF9->AF9_CUSTO
					aABC[nPos,4]+= AF9->AF9_QUANT
				Else
					aAdd(aABC,{"OTR","--","--",AF9->AF9_QUANT,AF9->AF9_CUSTO})
				EndIf
			EndIf

			// soma o custo de todas as tarefas sempre
			nCusto += AF9->AF9_CUSTO
		    
//			oReport:IncMeter()
			dbSelectArea("AF9")
			dbSkip()
		End
	EndIf	

ElseIf nOrder == 5 //Sub-Composicao
	dbSelectArea("AF9")
	dbSetOrder(3)
	If MsSeek(xFilial("AF9")+AF8->AF8_PROJET+Mv_Par05)
		While !Eof() .And. (xFilial("AF9")+AF8->AF8_PROJET+Mv_Par05 == AF9->AF9_FILIAL+AF9->AF9_PROJET+AF9->AF9_REVISA)
			If !Empty(AF9->AF9_COMPOS)
				// verifica os produtos do orcamento
				dbSelectArea("AFA")
				dbSetOrder(1)
				If MsSeek(xFilial("AFA")+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA)
					While !Eof() .And. (xFilial("AFA")+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA == AFA->AFA_FILIAL+AFA->AFA_PROJET+AFA->AFA_REVISA+AFA->AFA_TAREFA)

						// calcula a quantidade de produtos pertencentes a sub-composicao
						nQuantAFA:= PmsAFAQuant(AFA->AFA_PROJET,AFA->AFA_REVISA,AFA->AFA_TAREFA,AFA->AFA_PRODUT,AF9->AF9_QUANT,AFA->AFA_QUANT,AF9->AF9_HDURAC)
						
						// verifica se o produto pertence a alguma sub-composicao
						// caso nao pertenca adiciona o valor do produto em Outros
						cCompos:= IIf(!Empty(AFA->AFA_COMPOS),AFA->AFA_COMPOS,AF9->AF9_COMPOS)
						nPos     := aScan(aABC,{|x| x[2]== cCompos})
						
						If (nPos > 0)
							aABC[nPos,5]+= xMoeda(PmsTrunca(cTrunca,nQuantAFA * AFA->AFA_CUSTD,nDecCst,AF9->AF9_QUANT),AFA->AFA_MOEDA,1)
						Else
							aAdd(aABC,{AF9->AF9_COMPOS,cCompos,AF9->AF9_UM,0,xMoeda(PmsTrunca(cTrunca,nQuantAFA * AFA->AFA_CUSTD,nDecCst,AF9->AF9_QUANT),AFA->AFA_MOEDA,1)})
						EndIf
							
						nCusto += xMoeda(PmsTrunca(cTrunca,nQuantAFA * AFA->AFA_CUSTD,nDecCst,AF9->AF9_QUANT),AFA->AFA_MOEDA,1)
//						oReport:IncMeter()
						dbSelectArea("AFA")
						dbSkip()
					End
				EndIf
				
				// verifica as despesa do orcamento
				dbSelectArea("AFB")
				dbSetOrder(1)
				If MsSeek(xFilial("AFB")+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA)
					While !Eof() .And. (xFilial("AFB")+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA == AFB->AFB_FILIAL+AFB->AFB_PROJET+AFB->AFB_REVISA+AFB->AFB_TAREFA)
										
						// calcula o valor da despesa da sub-composicao
						nValorAFB:= PmsTrunca(cTrunca,PmsAFBValor(AF9->AF9_QUANT,AFB->AFB_VALOR),nDecCst,AF9->AF9_QUANT)
						
						// verifica se a despesa pertence a alguma sub-composicao
						// caso nao pertenca adiciona o valor da despesa em Outros
						cCompos:= IIf(!Empty(AFB->AFB_COMPOS),AFB->AFB_COMPOS,AF9->AF9_COMPOS)
						nPos     := aScan(aABC,{|x| x[2]== cCompos})
			
						If (nPos > 0)
							aABC[nPos,5]+= xMoeda(nValorAFB,AFB->AFB_MOEDA,1)
						Else
							aAdd(aABC,{AF9->AF9_COMPOS,cCompos,AF9->AF9_UM,0,nValorAFB})
						EndIf
							
						nCusto += xMoeda(nValorAFB,AFB->AFB_MOEDA,1)
						
//						oReport:IncMeter()
						dbSelectArea("AFB")
						dbSkip()
					End
				EndIf
			Else

				// soma o custo de todas as tarefas sempre
				nCusto += AF9->AF9_CUSTO

				nPos     := aScan(aABC,{|x| x[1] == "OTR"})
				If (nPos > 0)
					aABC[nPos,5]+= AF9->AF9_CUSTO
				Else
					aAdd(aABC,{"OTR","--","--",0,AF9->AF9_CUSTO})
				EndIf
			EndIf
			    
//			oReport:IncMeter()
			dbSelectArea("AF9")
			dbSkip()
		End
	EndIf	
	
ElseIf nOrder == 6 //Grupo de Composicao
	dbSelectArea("AF9")
	dbSetOrder(4)
	If MsSeek(xFilial("AF9")+AF8->AF8_PROJET+Mv_Par05)
		While !Eof() .And. (xFilial("AF9")+AF8->AF8_PROJET+Mv_Par05+AF9->AF9_GRPCOM == AF9->AF9_FILIAL+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_GRPCOM)
	                                                                            
			If !Empty(AF9->AF9_GRPCOM)
				nPos     := aScan(aABC,{|x| x[1] == AF9->AF9_GRPCOM})
				If (nPos > 0)
					aABC[nPos,5]+= AF9->AF9_CUSTO
					aABC[nPos,4]+= AF9->AF9_QUANT
				Else
					aAdd(aABC,{AF9->AF9_GRPCOM,"",AF9->AF9_UM,AF9->AF9_QUANT,AF9->AF9_CUSTO})
				EndIf
			Else
				nPos     := aScan(aABC,{|x| x[1] == "OTR"})
		
				If (nPos > 0)
					aABC[nPos,5]+= AF9->AF9_CUSTO
					aABC[nPos,4]+= AF9->AF9_QUANT
				Else
					aAdd(aABC,{"OTR","--","--",AF9->AF9_QUANT,AF9->AF9_CUSTO})
				EndIf
		EndIf


			// soma o custo de todas os tarefas do grupo sempre
			nCusto += AF9->AF9_CUSTO
		    
//			oReport:IncMeter()
			dbSelectArea("AF9")
			dbSkip()
		End
	EndIf	

EndIf

aABC := aSort(aABC,,,{|x,y| x[5] > y[5]})

RestArea(aArea)

Return

//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDIsObfuscate
    @description
    Verifica se um campo deve ser ofuscado, esta função deve utilizada somente após 
    a inicialização das variaveis atravez da função FATPDLoad.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cField, Caractere, Campo que sera validado
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado
    @return lObfuscate, Lógico, Retorna se o campo será ofuscado.
    @example FATPDIsObfuscate("A1_CGC",Nil,.T.)
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDIsObfuscate(cField, cSource, lLoad)
    
	Local lObfuscate := .F.

    If FATPDActive()
		lObfuscate := FTPDIsObfuscate(cField, cSource, lLoad)
    EndIf 

Return lObfuscate


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
