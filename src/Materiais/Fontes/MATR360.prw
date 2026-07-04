/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR360.CH"
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR360  ³ Autor ³ Wagner Xavier         ³ Data ³ 05.09.91 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Variacao no Consumo de Materiais de Apropriacao Indireta    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Rodrigo     ³23/06/98³XXXXXX³Acerto no tamanho do documento para 12    ³±±
±±³            ³        ³      ³posicoes                                  ³±±
±±³FernandoJoly³10/11/98³XXXXXX³Ajuste para o Ano 2000.                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Matr360()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL Tamanho:= "M"
LOCAL titulo :=STR0001	//"Variacao no consumo de materias de Apropriacao Indireta"
LOCAL cDesc1 :=STR0002	//"Este relatorio ira imprimir as movimentacoes dos produtos,"
LOCAL cDesc2 :=STR0003	//"tendo as seguintes opcoes: Mat.Aprop.Indireta, Por Produto,"
LOCAL cDesc3 :=STR0004	//"Por Produto Produzido e Por Materia Prima."
LOCAL cString:="SB1"
LOCAL aOrd   := {OemToAnsi(STR0005),OemToAnsi(STR0006),OemToAnsi(STR0007),OemToAnsi(STR0008)}		//"Mat.Aprop.Indireta."###"Por Ordem Produto."###"Por Prod.Produzido."###"Por Materia Prima"
LOCAL nOrdem := 0

PRIVATE aLinha := { },nLastKey := 0
PRIVATE cPerg  :="MTR360"
PRIVATE aReturn:= { STR0009, 1,STR0010, 1, 2, 1, "",1 }	//"Zebrado"###"Administracao"

Static cFilSG1 := ""
Static cFilSB1 := ""
Static cFilSB2 := ""
Static cFilSD3 := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Funcao utilizada para verificar a ultima versao dos fontes      ³
//³ SIGACUS.PRW, SIGACUSA.PRX e SIGACUSB.PRX, aplicados no rpo do   |
//| cliente, assim verificando a necessidade de uma atualizacao     |
//| nestes fontes. NAO REMOVER !!!							        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !(FindFunction("SIGACUS_V") .And. SIGACUS_V() >= 20050512)
	Aviso("Atencao","Atualizar patch do programa SIGACUS.PRW !!!",{"Ok"})
	Return
EndIf
If !(FindFunction("SIGACUSA_V") .And. SIGACUSA_V() >= 20050512)
	Aviso("Atencao","Atualizar patch do programa SIGACUSA.PRX !!!",{"Ok"})
	Return
EndIf
If !(FindFunction("SIGACUSB_V") .And. SIGACUSB_V() >= 20060915)
	Aviso("Atencao","Atualizar patch do programa SIGACUSB.PRX !!!",{"Ok"})
	Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("MTR360",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01         // Filial                                   ³
//³ mv_par02         // Almox.                                   ³
//³ mv_par03	   	 // Data de                                  ³
//³ mv_par04         // Data ate                                 ³
//³ mv_par05         // Qual Moeda (1 a 5)                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="MATR360"            //Nome Default do relatorio em Disco

wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho)

If nLastKey = 27
	Set Filter to
	Return
EndIf

SetDefault(aReturn,cString)

If nLastKey = 27
	Set Filter to
	Return
EndIf

cFilSG1 := xFilial("SG1",mv_par01)
cFilSB1 := xFilial("SB1",mv_par01)
cFilSB2 := xFilial("SB2",mv_par01)
cFilSD3 := xFilial("SD3",mv_par01)

RptStatus({|lEnd| C360Imp(@lEnd,aOrd,wnRel,cString,tamanho,titulo)},titulo)

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ C360IMP  ³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 13.12.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR360			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function C360Imp(lEnd,aOrd,WnRel,cString,tamanho,titulo)
Local oTempTable
Local aStruTb

PRIVATE bBloco := {|nX,nY| Trim(nX)+Str(nY,1)}

aStruTb := { 	{ "D3_FILIAL" ,"C",TamSx3("D3_FILIAL"	)[1],0 } , ;
				{ "D3_TIPO"   ,"C",TamSx3("D3_TIPO"		)[1],0 } , ;
				{ "D3_COD"    ,"C",TamSx3("D3_COD"		)[1],0 } , ;
				{ "D3_OP"     ,"C",TamSx3("D3_OP"		)[1],0 } , ;
				{ "D3_QUANT"  ,"N",TamSx3("D3_QUANT"	)[1],TamSx3("D3_QUANT"	)[2] } , ;
				{ "D3_CUSTO1" ,"N",TamSx3("D3_CUSTO1"	)[1],TamSx3("D3_CUSTO1"	)[2] } , ;
				{ "D3_CUSTO2" ,"N",TamSx3("D3_CUSTO2"	)[1],TamSx3("D3_CUSTO2"	)[2] } , ;
				{ "D3_CF"     ,"C",TamSx3("D3_CF"		)[1],0 } , ;
				{ "D3_EMISSAO","D",TamSx3("D3_EMISSAO"	)[1],0 } , ;
				{ "D3_CONTA"  ,"C",TamSx3("D3_CONTA"	)[1],0 } , ;
				{ "D3_LOCAL"  ,"C",TamSx3("D3_LOCAL"	)[1],0 } , ;
				{ "D3_SUBCF"  ,"C",1,0 } }

//Criacao do Arquivo de Trabalho
oTempTable := FWTemporaryTable():New( "TRBMTR" )
oTempTable:SetFields( aStruTb )
oTempTable:AddIndex("Ind01", {"D3_FILIAL","D3_OP","D3_SUBCF","D3_COD"} )
oTempTable:AddIndex("Ind02", {"D3_FILIAL","D3_CONTA","D3_SUBCF","D3_COD"} )
oTempTable:AddIndex("Ind03", {"D3_FILIAL","D3_COD"} )
oTempTable:Create()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li       := 80
m_pag    := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa os codigos de caracter Comprimido/Normal da impressora ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

nOrdem := aReturn[8]

IF nOrdem == 1
	ImpOpt1(@lEnd)
Else
	ImpOptAll(@lEnd)
EndIf

IF nOrdem = 2
	ImpOpt2(@lEnd)
ElseIF nOrdem = 3
	ImpOpt3(@lEnd)
ElseIF nOrdem = 4
	ImpOpt4(@lEnd)
EndIf

//Deleta arquivo de Trabalho
oTempTable:Delete()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Volta os arquivos para os Indices Principais                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SD1")
dbSetOrder(1)
dbSelectArea("SD3")
dbSetOrder(1)
dbSelectArea("SG1")
dbSetOrder(1)
dbSelectArea("SB1")
Set Filter To
dbSetOrder(1)

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
EndIf
MS_FLUSH()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpOpt1  ³ Autor ³ Wagner Xavier         ³ Data ³ 05.09.91 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime a 1. Opcao do Matr360                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpOpt1(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FuncTion ImpOpt1(lEnd)
LOCAL titulo := STR0011 + mv_par01 + STR0012+ mv_par02		//"VARIACAO NO CONSUMO DE MATERIAIS DE APROPRIACAO INDIRETA DA FILIAL : "###" LOCAL : "
LOCAL cabec1 := STR0013	//"CODIGO           M  A  T  E  R  I  A  L          ORDEM     R/D DOCUMENTO     DATA       QUANTIDADE    UM     CUSTO    V A L O R"
LOCAL cabec2 := STR0014	//"                                                PRODUCAO                                                  UNITARIO             "
//                         123456789012345 123456789012345123456789012345 12345678901 123 123456789012 1234567890 12345678901234 XX 123456789 12345678901234
//                                   1         2         3         4         5         6         7         8         9        1         11        12        13
//                         0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
LOCAL Tamanho := "G"
LOCAL nAgs   :=0,nAgr:=0
LOCAL nPrimo :=0,nAqrp:=0,nAvrp:=0,nAqsp:=0,nAvsp:=0,nAq:=0,nAv:=0
LOCAL cProdant,cOpant
LOCAL nTipo  := 0
LOCAL cbcont :=0,cbtxt:=SPACE(10)
LOCAL wnrel:="MATR360"
LOCAL cFil := If (Empty(xFilial("SB1")),xFilial("SB1"),MV_PAR01)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona o arquivo a ser impresso                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SD3")
SetRegua(LastRec())
dbSetOrder(5)
dbGoTop()
Set SoftSeek On
dbSeek(cFilSD3)
Set SoftSeek Off

Do While D3_FILIAL == cFilSD3 .And. !Eof()
	IF lEnd
		@PROW()+1,001 PSay STR0015	//"CANCELADO PELO OPERADOR"
		EXIT
	EndIf
	IncRegua()
	IF D3_LOCAL !=  mv_par02
		dbSkip()
		Loop
	EndIf
	SB1->(dbSeek(cFilSB1+SD3->D3_COD))
	If SB1->B1_APROPRI == "D"
	   dbSkip()
	   Loop
	EndIf
	IF !(D3_CF = "RE2" .Or. (D3_CF != "RE3") .And. Empty(D3_OP))
		dbSkip()
		Loop
	EndIf
	IF D3_EMISSAO < mv_par03 .OR. D3_EMISSAO > mv_par04
		dbSkip()
		Loop
	EndIf
	nPrimo:=0;nAqrp:=0;nAvrp:=0;nAqsp:=0;nAvsp:=0
	cProdant := D3_COD
	Do While D3_FILIAL == cFilSD3 .And. cProdant == D3_COD .And. !Eof()
		IncRegua()
		IF li > 55
			cabec(titulo,cabec1,cabec2,wnrel,Tamanho,nTipo)
		EndIf
		cOpant := D3_OP
		Do While D3_FILIAL == cFilSD3 .And. cOpant == D3_OP .And. D3_COD == cProdant .And. !Eof()
			IncRegua()
			IF li > 55
				cabec(titulo,cabec1,cabec2,wnrel,Tamanho,nTipo)
			EndIf
			@ li,00 PSay D3_COD
			If nPrimo = 0
				nPrimo := 1
				dbSelectArea("SB1")
				dbSeek(xFilial("SB1",cFil)+SD3->D3_COD)
				@ li,16 PSay Substr(B1_DESC,1,30)
				dbSelectArea("SB2")
				dbSeek(cFilSB2+SD3->D3_COD+SD3->D3_LOCAL)
				dbSelectArea("SD3")
			EndIf
			@ li,046 PSay D3_OP+" "+D3_CF+" "+D3_DOC
			@ li,076 PSay D3_EMISSAO
			@ li,087 PSay D3_QUANT    PicTure PesqPictQt("D3_QUANT",14)
			@ li,102 PSay SB1->B1_UM
			@ li,105 PSay &(Eval(bBloco,"D3_CUSTO",mv_par05))/D3_QUANT PicTure tm(&(Eval(bBloco,"D3_CUSTO",mv_par05))/D3_QUANT,9)
			@ li,115 PSay &(Eval(bBloco,"D3_CUSTO",mv_par05))    PicTure tm(&(Eval(bBloco,"D3_CUSTO",mv_par05)),14)
			li++
			nAq := nAq+D3_QUANT
			nAv := nAv+&(Eval(bBloco,"D3_CUSTO",mv_par05))
			dbSkip()
		EndDo
		IF Empty(cOpant)
			@ li,046 PSay STR0016	//"Consumo Real ---> "
			@ li,087 PSay nAq	PicTure 	PesqPictQt("D3_QUANT",14)
			@ li,115 PSay nAv	Picture 	Tm(nAv,14)
			nAqrp+=nAq
			nAvrp+=nAv
			li++;li++
		Else
			nAqsp+=nAq
			nAvsp+=nAv
		EndIf
	EndDo
	li++
	@ li,046 PSay STR0017	//"Consumo std --->"
	@ li,087 PSay nAqsp 	PicTure PesqPictQt("D3_QUANT",14)
	@ li,115 PSay nAvsp	PicTure Tm(nAvsp,14)
	li++;li++
	@ li,046 PSay STR0018	//"Variacao --->"
	@ li,087 PSay nAqsp-nAqrp 	PicTure PesqPictQt("D3_QUANT",14)
	@ li,115 PSay nAvsp-nAvrp 	PicTure Tm(nAvsp-nAvrp,14)
	li++;li++
	nAGr+=nAvrp
	nAgs+=nAvsp
EndDo

If li!= 80
	@ li,046 PSay STR0019	//"T o t a l   S t d --->"
	@ li,115 PSay nAgs 	PicTure Tm(nAgs,14)
	li++
	@ li,046 PSay STR0020	//"T o t a l   R e a l --->"
	@ li,115 PSay nAgr 	PicTure Tm(nAgr,14)
	li++
	@ li,046 PSay STR0021	//"T o t a l   V a r i a c a o --->"
	@ li,115 PSay nAgs-nAgr  PicTure Tm(nAgs-nAgr,14)
	Roda(cbcont,cbtxt,Tamanho)
EndIf
Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpOptAll³ Autor ³ Wagner Xavier         ³ Data ³ 05.09.91 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina utilizada para as opcoes 2,3 e 4                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpOptAll(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FuncTion ImpOptAll(lEnd)
Local cIndSG1	:= GetNextAlias()
Local cFiliant	:= ""
Local nIndSG1
Local lPr		:= .F.
local lPCPREVATU := FindFunction('PCPREVATU') 

dbSelectArea("SG1")
nIndSG1 := RetIndex("SG1")
IndRegua("SG1",cIndSG1,"G1_FILIAL+G1_NIVINV+G1_COD",,,STR0022)	//"Selecionando Registros..."
SetRegua(LastRec())
dbGoTop()
dbSeek(cFilSG1,.T.)
Do While !Eof() .And. G1_FILIAL == cFilSG1
	IncRegua()
	cCodAnt := g1_cod
	nCuTot  := 0
	cFiliant:= g1_filial
	Do While G1_FILIAL == cFiliant .And. cCodAnt == g1_cod .And. !Eof()
		IncRegua()
		dbSelectArea("SB1")
		dbSetOrder(1)
		dbSeek(cFilSB1+SG1->g1_comp)
		dbSelectArea("SB2")
		dbSeek(cFilSB2+SG1->g1_comp+mv_par02)
		dbSelectArea("SB1")
		If (RetFldProd(SB1->B1_COD,"B1_UPRC")/Iif(mv_par05==1,1,RecMoeda(RetFldProd(SB1->B1_COD,"B1_UCOM"),mv_par05))) = 0
			nCu := RetFldProd(SB1->B1_COD,"B1_CUSTD")/iif(mv_par05==1,1,RecMoeda(RetFldProd(SB1->B1_COD,"B1_DATREF"),mv_par05))
			dDatRef := RetFldProd(SB1->B1_COD,"B1_DATREF")
			cCusta = "s"
		Else
			nCu := (RetFldProd(SB1->B1_COD,"B1_UPRC")/Iif(mv_par05==1,1,RecMoeda(RetFldProd(SB1->B1_COD,"B1_UCOM"),mv_par05)))
			dDataRef := RetFldProd(SB1->B1_COD,"B1_UCOM")
			cCusta= "u"
		EndIf
		nIcm1 := 1.00
		nCusto := nCu*nIcm1
		dbSelectArea("SB1")
		dbSeek(cFilSB1+SG1->g1_cod)
		cCodPad := SB1->b1_cod
		dbSelectArea("SG1")
		nValliq:= Round(ExplEstr(nCusto),4)
		nCuTot += nValliq
		dbSelectArea("SG1")
		dbSkip()
	EndDo
	If RetArqProd(cCodAnt)
		dbSelectArea("SB1")
		dbSeek(xFilial("SB1",cFiliant)+cCodAnt)
		If Found()
			RecLock("SB1",.F.)
			Replace B1_CUSTD  With nCuTot
			Replace B1_DATREF With dDataBase
			MsUnlock()
		EndIf
	Else
		RecLock("SBZ",.F.)
		Replace BZ_CUSTD  With nCuTot
		Replace BZ_DATREF With dDataBase
		MsUnlock()
	Endif	
	dbSelectArea("SG1")
EndDo
RetIndex("SG1")
Ferase(cIndSG1+OrdBagExt())
dbSelectArea("SG1")
dbSetOrder(2)

SC2->(dbSetOrder(1))

dbSelectArea("SD3")
dbSetOrder(1)
dbGoTop()
Set SoftSeek On
dbSeek(cFilSD3)
Set SoftSeek Off

Do While D3_FILIAL == cFilSD3 .And. !Eof()
	IF (D3_LOCAL != mv_par02 .Or.  D3_CF != "PR") .And. (D3_EMISSAO < mv_par03 .Or. D3_EMISSAO > mv_par04)
		dbSkip()
		Loop
	EndIf
	
	If Empty(D3_OP)
		dbSkip()
		Loop
	EndIf
	
	SB1->(dbSeek(xFilial("SB1")+SD3->D3_COD))
	cCodPad := SB1->B1_COD
	
	If D3_CF != "PR"
		If !SC2->(dbSeek(cFilSD3+SD3->D3_OP))
			dbSkip()
			Loop
		EndIf
		lPr := .F.
	Else
		lPr := .T.	
	EndIf	
			
	dbSelectArea("SG1")
	dbSetOrder(If(lPr,1,2))
	dbSeek(cFilSG1+cCodPad)
	Do While !Eof() .And. cFilSG1+cCodPad+If(lPr,"",SC2->C2_PRODUTO) == G1_FILIAL+If(lPr,G1_COD,G1_COMP+G1_COD)
		nQuant := ExplEstr(SD3->D3_QUANT,,RetFldProd(SB1->B1_COD,"B1_OPC"),IIF(lPCPREVATU , PCPREVATU(SB1->B1_COD), SB1->B1_REVATU))
		dbSelectArea("SB1")
		dbSeek(cFilSB1+SG1->G1_COMP)
		If SB1->B1_TIPO != "BN" .And. !Eof()
			IF RetFldProd(SB1->B1_COD,"B1_FANTASM") = "S" // Projeto Implementeacao de campos MRP e FANTASM no SBZ
				cCodPad2 := SB1->B1_COD
				dbSelectArea("SG1")
				nSalva  := RecNO()
				dbSeek(cFilSG1+cCodPad2)
				Do While cFilSG1+cCodPad2 == G1_FILIAL+G1_COD .And. !Eof()
					nQuant:= ExplEstr(SD3->D3_QUANT,,RetFldProd(SB1->B1_COD,"B1_OPC"),IIF(lPCPREVATU , PCPREVATU(SB1->B1_COD), SB1->B1_REVATU))
					dbSelectArea("SB1")
					dbSeek(cFilSB1+SG1->G1_COMP)
					If SB1->b1_tipo != "BN" .And. !Eof()
						dbSelectArea("TRBMTR")
						RecLock("TRBMTR",.T.)
						Replace D3_FILIAL   With cFilSD3	,;
								D3_TIPO    	With "S"				,;
								D3_COD 		With SG1->G1_COMP		,;
								D3_OP      	With SD3->D3_OP         ,;
								D3_QUANT   	With SD3->D3_QUANT      ,;
								D3_EMISSAO 	With SD3->D3_EMISSAO    ,;
								D3_CF      	With If(lPr,"PA0",SD3->D3_CF),;
								D3_SUBCF	With SubStr(SD3->D3_CF,2,1),;
								D3_CONTA   	With SD3->D3_CONTA	    ,;
								D3_LOCAL   	With SD3->D3_LOCAL		,;
								D3_CUSTO1  	With &(Eval(bBloco,"SD3->D3_CUSTO",mv_par05))
								MsUnlock()
					EndIf
					dbSelectArea("SG1")
					dbSkip()
				EndDo
				MsUnLockAll()
				dbSelectArea("SG1")
				GoTo nSalva
				cCodPad:= cCodPad2
			Else
				dbSelectArea("TRBMTR")
				RecLock("TRBMTR",.T.)

				Replace D3_FILIAL	With cFilSD3	,;
						D3_TIPO  	With "S"			,;
						D3_COD 		With SG1->G1_COMP	,;
						D3_OP    	With SD3->D3_OP		,;
						D3_QUANT 	With nQuant			,;
						D3_EMISSAO 	With SD3->D3_EMISSAO,;
						D3_CF 		With If(lPr,"PA0",SD3->D3_CF),;
						D3_SUBCF	With SubStr(SD3->D3_CF,2,1),; 
						D3_CONTA 	With SD3->D3_COD	,;
						D3_LOCAL 	With SD3->D3_LOCAL	,;
						D3_CUSTO1  	With &(Eval(bBloco,"SD3->D3_CUSTO",mv_par05))
				MsUnlock()
			EndIf
		EndIf
		dbSelectArea("SG1")
		dbSkip()
	EndDo
	dbSelectArea("SD3")
	dbSkip()
EndDo
Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpOpt2  ³ Autor ³ Wagner Xavier         ³ Data ³ 05.09.91 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina utilizada para a opcao 2                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FuncTion ImpOpt2(lEnd)
LOCAL titulo := STR0023 + STR0024+ mv_par01 +STR0012 + mv_par02		//"** CONSUMO REAL x STANDARD POR ORDEM DE PRODUCAO **"###" FILIAL : "###" LOCAL : "
LOCAL cabec1 := STR0025	//"CODIGO           DESCRICAO DO MATERIAL         UM    C  O  N  S  U  M  O   R  E  A  L          C  O  N  S  U  M  O         S T D          VARIACAO QUANT.           VARIACAO   VARIACAO    "
LOCAL cabec2 := STR0026	//"                                                   QUANTIDADE   CUSTO UNITARIO  T O T A L    QUANTIDADE  CUSTO UNITARIO  T O T A L    QUANTIDADE  VALOR        %    P/ CUSTO   T O T A L  %"
//                         123456789012345 123456789012345123456789012345 12 1234567890   123456789012    123456789012 1234567890  123456789012    123456789012 12345678901 123456789012 123 123456789012 1234567   1234
//                                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18
//                         012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678
LOCAL Tamanho:= "G"
LOCAL nGrq,nGrv,nGsq,nGsv,nGpq,nGpv,nGst,nQuebra
LOCAL cOpant,cProdant,cCf
LOCAL nPrq,nPrv,nPsq,nPpq,nPpv
LOCAL nOrq,nOrv,nOsq,nOsv,nOpq,nOpv,nOst,nTempr
LOCAL cbcont :=0,cbtxt:=SPACE(10)
LOCAL wnrel:="MATR360"
LOCAL nIcm,nIpi
dbSelectArea("TRBMTR")
DbSetOrder(1)
dbGoTop()
MSUnlock()
nGrq:=0;nGrv:=0;nGsq:=0;nGsv:=0;nGpq:=0;nGpv:=0;nGst:=0;nQuebra:=0
SetRegua(LastRec())
Set SoftSeek On
dbSeek(cFilSD3)
Set SoftSeek Off

Do While !Eof() .And. D3_FILIAL == cFilSD3
	IncRegua()
	IF D3_LOCAL != mv_par02
		dbSkip()
		Loop
	EndIf
	cOpant := D3_OP
	nOrq:=0;nOrv:=0;nOsq:=0;nOsv:=0;nOpq:=0;nOpv:=0;nOst:=0;nTempr:=0
	Do While D3_FILIAL = cFilSD3 .And. cOpant = D3_OP .And. !Eof()
		IncRegua()
		cProdant := D3_COD
		nPrq:=0;nPrv:=0;nPsq:=0;nPpq:=0;nPpv:=0
		Do While D3_FILIAL = cFilSD3 .And. !Eof() .And. cOpant = D3_OP .And. cProdant = D3_COD
			IncRegua()
			Do Case
				Case D3_TIPO = "M" .And. D3_CF != "PA"
					nPrq += D3_QUANT
					nPrv += D3_CUSTO1
				Case D3_TIPO ="S"
					nPsq += D3_QUANT
				Case D3_CF = "PA"
					nPpq += D3_QUANT
					nPpv += D3_CUSTO1
			EndCase
			cCf := D3_CF
			dbSkip()
		EndDo
		
		If li > 55
			cabec(titulo,cabec1,cabec2,wnrel,Tamanho,nTipo)
		EndIf
		
		dbSelectArea("SB1")
		dbSeek(cFilSB1+cProdant)
		If cCf = "PA"
			nTempr := 1
			//                        11         15             30             2
			@ li,000 PSay STR0027 + cOpant+" "+cProdant+" "+Substr(SB1->B1_DESC,1,30)+SB1->B1_UM		//"OP : "
			@ li,050 PSay nPpq		PicTure PesqPictQt("D3_QUANT",10)
			@ li,063 PSay nPpv		PicTure tm(nPpv,12)
			li++
			nOpq += nPpq
			nOpv += nPpv
		Else
			If nTempr = 1
				If nPrq = 0
					dbSelectArea("SB2")
					dbSeek(xFilial("SB2",TRBMTR->D3_FILIAL)+cProdant+mv_par02)
					If B2_QATU <= 0 .Or. &(Eval(bBloco,"B2_VATU",mv_par05)) <= 0
						nCu := &(Eval(bBloco,"B2_CM",mv_par05))
					Else
						nCu := &(Eval(bBloco,"B2_VATU",mv_par05))/B2_QATU
					EndIf
				Else
					nCu := nPrv/nPrq
				EndIf
				nCustd := RetFldProd(SB1->B1_COD,"B1_CUSTD")/Iif(mv_par05==1,1,RecMoeda(RetFldProd(SB1->B1_COD,"B1_DATREF"),mv_par05))
				nIcm   := 0
				nIpi   := 0
				dbSelectArea("SF4")
				dbSeek(xFilial("SF4",TRBMTR->D3_FILIAL)+RetFldProd(SB1->B1_COD,"B1_TE"))
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Calcula o valor do ICM a ser retirado do custo do material   ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If F4_CREDICM == "S"
					nIcm := nCustd * Iif(SB1->B1_FORAEST=="S",.12,(SB1->B1_PICM/100))
				EndIf
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Calcula o valor do IPI a ser somado ao custo do material     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If F4_CREDIPI == "N"
					nIpi := nCustd * (SB1->B1_IPI/100)
				EndIf
				nCustd -= nIcm
				nCustd += nIpi
				@ li,000 PSay cProdant
				@ li,017 PSay Substr(SB1->B1_DESC,1,30)
				@ li,048 PSay SB1->B1_UM
				@ li,050 PSay nPrq		PicTure PesqPictQt("D3_QUANT",10)
				@ li,063 PSay nCu		PicTure tm(nCu,12)
				@ li,079 PSay nPrv		PicTure tm(nPrv,12)
				@ li,092 PSay nPsq		PicTure PesqPictQt("D3_QUANT",10)
				@ li,104 PSay nCustd	PicTure tm(nCustd,12)
				@ li,120 PSay nPsq*nCustd PicTure tm(nPsq*nCustd,12)
				@ li,133 PSay nPsq-nPrq PicTure PesqPictQt("D3_QUANT",11)
				@ li,145 PSay (nPsq*nCu)-nPrv PicTure tm((nPsq*nCu)-nPrv,12)
				@ li,158 PSay ((nPsq-nPrq)*100/IIF(nPsq!=0,nPsq,1)) PicTure "999"
				@ li,162 PSay ((nPsq*nCustd)-nPrv)-((nPsq*nCu)-nPrv) PicTure tm(((nPsq*nCustd)-nPrv)-((nPsq*nCu)-nPrv),12)
				@ li,175 PSay ((nPsq*nCustd)-nPrv)	PicTure tm(((nPsq*nCustd)-nPrv),7)
				@ li,185 PSay ((nPsq*nCustd)-nPrv)*100/IIF(nPrv!=0,nPrv,1)  PicTure tm(((nPsq*nCustd)-nPrv)*100/IIF(nPrv!=0,nPrv,1),4)
				li++
				nOrq += nPrq
				nOrv += nPrv
				nOsq += nPsq
				nOsv += (nPsq*nCustd)
				nOst += (nPsq*nCu)
			EndIf
		EndIf
		dbSelectArea("TRBMTR")
	EndDo
	If li!= 80
		@ li,000 PSay STR0028	//"Total : "
		@ li,050 PSay nOrq		PicTure PesqPictQt("D3_QUANT",10)
		@ li,063 PSay nOrv/IIF(nOpq#0,nOpq,1) PicTure tm(nOrv/IIF(nOpq#0,nOpq,1),12)
		@ li,079 PSay nOrv		PicTure tm(nOrv,12)
		@ li,092 PSay nOsq		PicTure PesqPictQt("D3_QUANT",10)
		@ li,104 PSay nOsv/IIF(nOpq!=0,nOpq,1) PicTure tm(nOsv/IIF(nOpq!=0,nOpq,1),12)
		@ li,120 PSay nOsv		PicTure tm(nOsv,12)
		@ li,133 PSay nOsq-nOrq	PicTure PesqPictQt("D3_QUANT",11)
		@ li,145 PSay nOst-nOrv	PicTure tm(nOst-nOrv,11)
		@ li,158 PSay (nOsq-nOrq)*100/IIF(nOsq!=0,nOsq,1) 	PicTure "999"
		@ li,162 PSay ((nOsv)-nOrv)-((nOst)-nOrv) 		 	PicTure tm(((nOsv)-nOrv)-((nOst)-nOrv),12)
		@ li,175 PSay nOsv-nOrv					 	PicTure tm(nOsv-nOrv,7)
		@ li,185 PSay (nOsv-nOrv)*100/IIF(nOrv!=0,nOrv,1)	PicTure "9999"
		li++
		@ li,00 PSay Repl("-",220)
		li++
		nGrq += nOrq
		nGrv += nOrv
		nGsq += nOsq
		nGsv += nOsv
		nGst += nOst
	EndIf
EndDo

If li!= 80
	@ li,000 PSay STR0029	//"Total Geral : "
	@ li,050 PSay nGrq		PicTure PesqPictQt("D3_QUANT",10)
	@ li,063 PSay nGrv/IIF(nGpq#0,nGpq,1)   PicTure tm(nGrv/IIF(nGpq#0,nGpq,1),12)
	@ li,079 PSay nGrv		PicTure tm(nGrv,12)
	@ li,092 PSay nGsq		PicTure PesqPictQt("D3_QUANT",10)
	@ li,104 PSay nGsv/IIF(nGpq!=0,nGpq,1)    PicTure tm(nGsv/IIF(nGpq!=0,nGpq,1),12)
	@ li,120 PSay nGsv		PicTure 	tm(nGsv,12)
	@ li,133 PSay nGsq-nGrq	PicTure  PesqPictQt("D3_QUANT",11)
	@ li,145 PSay nGst-nGrv	PicTure	tm(nGst-nGrv,11)
	@ li,158 PSay (nGsq-nGrq)*100/IIF(nGsq#0,nGsq,1)	PicTure "999"
	@ li,162 PSay ((nGsv)-nGrv)-((nGst)-nGrv)PicTure tm(((nGsv)-nGrv)-((nGst)-nGrv),12)
	@ li,175 PSay nGsv-nGrv			PicTure tm(nGsv-nGrv,7)
	@ li,185 PSay (nGsv-nGrv)*100/IIF(nGrv#0,nGrv,1) PicTure "9999"
	roda(cbcont,cbtxt,Tamanho)
EndIf

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpOpt3  ³ Autor ³ Wagner Xavier         ³ Data ³ 05.09.91 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina utilizada para a opcao 3                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpOpt3(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FuncTion ImpOpt3(lEnd)
LOCAL titulo
LOCAL cabec1 := STR0030	//"CODIGO          M  A  T  E  R  I  A  L         UM	 	  C O N S U M O  R E A L   		 C O N S U M O  S T A N D A R D        	     V A R I A C A O       "
LOCAL cabec2 := STR0031	//"                                                     QUANTIDADE   CUSTO UNITARIO     T O T A L   QUANTIDADE   CUSTO UNITARIO    T O T A L   QUANTIDADE    V A L O R  %"
//                         123456789012345 123456789012345123456789012345 12345678901 123 123456789012 12345678 12345678901234 XX 123456789 12345678901234
//                                   1         2         3         4         5         6         7         8         9        1         11        12        13
//                         0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
LOCAL Tamanho:= "G"
LOCAL nGrq,nGrv,nGsq,nGsv,nGpq,nGpv
LOCAL cContant,cProdant,cChave
LOCAL nCrq,nCrv,nCsq,nCsv,nCpq,nCpv,nTempr
LOCAL nPrq,nPrv,nPsq,nPpq,nPpv
LOCAL cCf,nCu,cbcont:=0,cbtxt:=SPACE(10)
LOCAL wnrel:="MATR360"

dbSelectArea("TRBMTR")
Replace all D3_CF		With "PA0" FOR D3_CF = "PR"
Replace all D3_SUBCF	With "A" FOR D3_CF = "PR"
MSUnlock()
SetRegua(LastRec())
titulo := STR0032 +STR0024+mv_par01+STR0012+mv_par02		//"** CONSUMO REAL x STANDARD POR PRODUTO **"###" FILIAL : "###" LOCAL : "

Do While !Eof()
	IncRegua()
	IF D3_TIPO = "M" .And. D3_LOCAL != mv_par02
		dbSkip()
		Loop
	EndIf
	cChave := "O" + SubStr(D3_OP,1,6)
	dbSelectArea("SC2")
	dbSeek(SD3->D3_LOCAL+cChave)
	dbSelectArea("TRBMTR")
	RecLock("SC2",.F.)
	Replace D3_CONTA With SD3->D3_COD
	dbSkip()
EndDo
DbSetOrder(2)
dbGoTop()
MsUnLockAll()
nGrq:=0;nGrv:=0;nGsq:=0;nGsv:=0;nGpq:=0;nGpv:=0
SetRegua(LastRec())
Set SoftSeek On
dbSeek(cFilSD3)
Set SoftSeek Off
Do While !Eof() .And. D3_FILIAL == cFilSD3
	IncRegua()
	IF D3_LOCAL != mv_par02
		dbSkip()
		Loop
	EndIf
	cContant := D3_CONTA
	nCrq:=0;nCrv:=0;nCsq:=0;nCsv:=0;nCpq:=0;nCpv:=0;nTempr:=0
	Do While D3_FILIAL == cFilSD3 .And. !Eof() .And. cContant = D3_CONTA
		IncRegua()
		IF D3_LOCAL != mv_par02
			dbSkip()
			Loop
		EndIf
		cProdant := D3_COD
		nPrq:=0;nPrv:=0;nPsq:=0;nPpq:=0;nPpv:=0
		Do While !Eof() .And. D3_FILIAL == cFilSD3 .And. cContant == D3_CONTA .And. cProdant == D3_COD
			IncRegua()
			IF D3_LOCAL != mv_par02
				dbSkip()
				Loop
			EndIf
			Do Case
				Case D3_TIPO="M" .And. D3_CF != "PA"
					nPrq += D3_QUANT
					nPrv += D3_CUSTO1
				Case D3_TIPO = "S"
					nPsq += D3_QUANT
				Case D3_CF = "PA"
					nPpq += D3_QUANT
					nPpv += D3_CUSTO1
			EndCase
			cCf := D3_CF
			dbSkip()
		EndDo
		If li > 55
			cabec(titulo,cabec1,cabec2,wnrel,Tamanho,nTipo)
		EndIf
		dbSelectArea("SB1")
		dbSeek(cFilSB1+cProdant)
		dbSetOrder(1)
		If TRBMTR->D3_CF = "PA"
			nTempr := 1
			@ li,000 PSay cProdant
			@ li,016 PSay Substr(SB1->B1_DESC,1,30)
			@ li,047 PSay SB1->B1_UM
			@ li,053 PSay nPpq		PicTure PesqPictQt("D3_QUANT",10)
			@ li,068 PSay nPpv		PicTure tm(nPpv,12)
			li++
			nCpq+=nPpq
			nCpv+=nPpv
		Else
			If nTempr = 1
				IF nPrq = 0
					dbSelectArea("SB2")
					dbSeek(xFilial("SB2",TRBMTR->D3_FILIAL)+cProdant+mv_par02)
					If B2_QATU <= 0 .Or. &(Eval(bBloco,"B2_VATU",mv_par05)) <= 0
						nCu := &(Eval(bBloco,"B2_CM",mv_par05))
					Else
						nCu := &(Eval(bBloco,"B2_VATU",mv_par05))/B2_QATU
					EndIf
				Else
					nCu := nPrv/nPrq
				EndIf
				@ li,000 PSay cProdant
				@ li,016 PSay Substr(SB1->B1_DESC,1,30)
				@ li,047 PSay SB1->B1_UM
				@ li,053 PSay nPrq				PicTure PesqPictQt("D3_QUANT",10)
				@ li,068 PSay nCu				PicTure tm(nCu,12)
				@ li,082 PSay nPrv				PicTure tm(nPrv,12)
				@ li,097 PSay nPsq				PicTure PesqPictQt("D3_QUANT",10)
				@ li,112 PSay RetFldProd(SB1->B1_COD,"B1_CUSTD")/Iif(mv_par05==1,1,Recmoeda(RetFldProd(SB1->B1_COD,"B1_DATREF"),mv_par05)) 	PicTure tm(SB1->B1_CUSTD,12)
				@ li,125 PSay nPsq*(RetFldProd(SB1->B1_COD,"B1_CUSTD")/Iif(mv_par05==1,1,Recmoeda(RetFldProd(SB1->B1_COD,"B1_DATREF"),mv_par05))) PicTure tm(nPsq*SB1->B1_CUSTD,12)
				@ li,138 PSay nPsq-nPrq			PicTure PesqPictQt("D3_QUANT",10)
				@ li,151 PSay (nPsq*(RetFldProd(SB1->B1_COD,"B1_CUSTD")/Iif(mv_par05==1,1,Recmoeda(RetFldProd(SB1->B1_COD,"B1_DATREF"),mv_par05))))-nPrv	PicTure tm((nPsq*SB1->B1_CUSTD)-nPrv,12)
				@ li,164 PSay (nPsq-nPrq)*100/IIF(nPsq#0,nPsq,1)	PicTure "999"
				li++
				nCrq+=nPrq
				nCrv+=nPrv
				nCsq+=nPsq
				nCsv+=(nPsq*(RetFldProd(SB1->B1_COD,"B1_CUSTD")/Iif(mv_par05==1,1,Recmoeda(RetFldProd(SB1->B1_COD,"B1_DATREF"),mv_par05))))
			EndIf
		EndIf
		dbSelectArea("TRBMTR")
	EndDo
	If li!= 80
		@ li,000 PSay STR0028	//"Total : "
		@ li,053 PSay nCrq	PicTure PesqPictQt("D3_QUANT",10)
		@ li,068 PSay nCrv/IIF(nCpq#0,nCpq,1)	PicTure tm(nCrv/IIF(nCpq#0,nCpq,1),12)
		@ li,082 PSay nCrv	PicTure tm(nCrv,12)
		@ li,097 PSay nCsq	PicTure PesqPictQt("D3_QUANT",10)
		@ li,112 PSay nCsv/IIF(nCpq#0,nCpq,1)	PicTure tm(nCsv/IIF(nCpq#0,nCpq,1),12)
		@ li,125 PSay nCsv	PicTure tm(nCsv,12)
		@ li,138 PSay nCsq-nCrq	PicTure PesqPictQt("D3_QUANT",10)
		@ li,151 PSay nCsv-nCrv	PicTure tm(nCsv-nCrv,12)
		@ li,164 PSay (nCsq-nCrq)*100/IIF(nCsq#0,nCsq,1) PicTure "999"
		li++
		@ li,00 PSay Repl("-",220)
		li++
		nGrq += nCrq
		nGrv += nCrv
		nGsq += nCsq
		nGsv += nCsv
	EndIf
EndDo

If li!= 80
	@ li,000 PSay STR0029	//"Total Geral : "
	@ li,053 PSay nGrq		PicTure PesqPictQt("D3_QUANT",10)
	@ li,068 PSay nGrv/IIF(nGrq#0,nGrq,1)	PicTure tm(nGrv/IIF(nGrq#0,nGrq,1),12)
	@ li,082 PSay nGrv       PicTure tm(nGrv,12)
	@ li,097 PSay nGsq		PicTure PesqPictQt("D3_QUANT",10)
	@ li,112 PSay nGsv/IIF(nGsq#0,nGsq,1)	PicTure tm(nGsv/IIF(nGsq#0,nGsq,1),12)
	@ li,125 PSay nGsv		PicTure tm(nGsv,12)
	@ li,138 PSay nGsq-nGrq	PicTure PesqPictQt("D3_QUANT",10)
	@ li,151 PSay nGsv-nGrv	PicTure tm(nGsv-nGrv,12)
	@ li,164 PSay (nGsq-nGrq)*100/IIF(nGsq#0,nGsq,1)	PicTure "999"
	roda(cbcont,cbtxt,Tamanho)
EndIf
Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpOpt4  ³ Autor ³ Wagner Xavier         ³ Data ³ 05.09.91 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina utilizada para a opcao 4                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpOpt4(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FuncTion ImpOpt4(lEnd)
LOCAL titulo := STR0033 + STR0024+mv_par01 + STR0012 + mv_par02		//"** VARIACAO NO CONSUMO DE MATERIA PRIMA ** "###" FILIAL : "###" LOCAL : "
LOCAL cabec1 := STR0034	//"CODIGO 	    MATERIA PRIMA / COMPONENTE      UM       C O N S U M O  R E A L 					   C O N S U M O  S T A N D A R D     	 V A R I A C A O		 "
LOCAL cabec2 := STR0035	//"                                                       QUANTIDADE CUSTO UNITARIO        T O T A L   QUANTIDADE CUSTO UNITARIO      T O T A L  QUANTIDADE    V A L O R    %"
//                         123456789012345 123456789012345123456789012345 12345678901 123 123456789012 12345678 12345678901234 XX 123456789 12345678901234
//                                   1         2         3         4         5         6         7         8         9        1         11        12        13
//                         0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
LOCAL Tamanho:= "G"
LOCAL wnrel:="MATR360"
LOCAL nGrq,nGrv,nGsq,nGsv
LOCAL cProdant
LOCAL nPrq,nPrv,nPsq
LOCAL nCu := 0
LOCAL cbcont :=0,cbtxt:=SPACE(10)
dbSelectArea("TRBMTR")
DbSetOrder(3)
dbGoTop()
nGrq:=0;nGrv:=0;nGsq:=0;nGsv:=0
SetRegua(LastRec())
Set SoftSeek ON
dbSeek(cFilSD3)
Set SoftSeek Off
Do While !Eof() .And. D3_FILIAL == cFilSD3
	IncRegua()
	IF D3_LOCAL != mv_par02
		dbSkip()
		Loop
	EndIf
	IF SubStr(D3_CF,1,1) != "P"
		dbSkip()
		Loop
	EndIf
	cProdant := D3_COD
	nPrq:=0;nPrv:=0;nPsq:=0
	Do While D3_FILIAL == cFilSD3 .And. !Eof() .And. cProdant == D3_COD
		IncRegua()
		IF D3_LOCAL != mv_par02
			dbSkip()
			Loop
		EndIf
		Do Case
			Case D3_TIPO = "M"
				nPrq += D3_QUANT
				nPrv += D3_CUSTO1
			Case D3_TIPO= "S"
				nPsq += D3_QUANT
		EndCase
		dbSkip()
	EndDo
	If li > 55
		cabec(titulo,cabec1,cabec2,wnrel,Tamanho,nTipo)
	EndIf
	dbSelectArea("SB1")
	dbSeek(cFilSB1+cProdant)
	If nPrq = 0
		dbSelectArea("SB2")
		dbSeek(xFilial("SB2",TRBMTR->D3_FILIAL)+cProdant+mv_par02)
		If B2_QATU <= 0 .Or. &(Eval(bBloco,"B2_VATU",mv_par05)) <= 0
			nCu := &(Eval(bBloco,"B2_CM",mv_par05))
		Else
			nCu := &(Eval(bBloco,"B2_VATU1",mv_par05))/B2_QATU
		EndIf
	Else
		nCu := nPrv/nPrq
	EndIf
	@ li,000 PSay cProdant
	@ li,016 PSay Substr(SB1->B1_DESC,1,30)
	@ li,048 PSay SB1->B1_UM
	@ li,055 PSay nPrq		PicTure PesqPictQt("D3_QUANT",10)
	@ li,068 PSay nCu			PicTure tm(nCu,12)
	@ li,085 PSay nPrv		PicTure tm(nPrv,12)
	@ li,098 PSay nPsq		PicTure PesqPictQt("D3_QUANT",12)
	@ li,113 PSay RetFldProd(SB1->B1_COD,"B1_CUSTD")/Iif(mv_par05==1,1,Recmoeda(RetFldProd(SB1->B1_COD,"B1_DATREF"),mv_par05))	PicTure tm(SB1->B1_CUSTD,12)
	@ li,128 PSay nPsq*(RetFldProd(SB1->B1_COD,"B1_CUSTD")/Iif(mv_par05==1,1,Recmoeda(RetFldProd(SB1->B1_COD,"B1_DATREF"),mv_par05))) PicTure tm(nPsq*SB1->B1_CUSTD,12)
	@ li,142 PSay nPsq-nPrq	PicTure PesqPictQt("D3_QUANT",10)
	@ li,153 PSay (nPsq*(RetFldProd(SB1->B1_COD,"B1_CUSTD")/Iif(mv_par05==1,1,Recmoeda(RetFldProd(SB1->B1_COD,"B1_DATREF"),mv_par05))))-nPrv PicTure tm((nPsq*SB1->B1_CUSTD)-nPrv,12)
	@ li,168 PSay (nPsq-nPrq)*100/IIF(nPsq#0,nPsq,1)	PicTure "999"
	li++
	nGrq+=nPrq
	nGrv+=nPrv
	nGsq+=nPsq
	nGsv+=(nPsq*nCu)
	dbSelectArea("TRBMTR")
EndDo
If li!= 80
	li++
	@ li,000 PSay STR0029	//"Total Geral : "
	@ li,055 PSay nGrq		PicTure PesqPictQt("D3_QUANT",10)
	@ li,068 PSay nGrv/IIF(nGrq#0,nGrq,1)	PicTure tm(nGrv/IIF(nGrq#0,nGrq,1),12)
	@ li,085 PSay nGrv		PicTure tm(nGrv,12)
	@ li,098 PSay nGsq		PicTure PesqPictQt("D3_QUANT",12)
	@ li,113 PSay nGsv/IIF(nGsq#0,nGsq,1)	PicTure tm(nGsv/IIF(nGsq#0,nGsq,1),12)
	@ li,128 PSay nGsv		PicTure tm(nGsv,12)
	@ li,142 PSay nGsq-nGrq	PicTure PesqPictQt("D3_QUANT",10)
	@ li,153 PSay nGsv-nGrv  PicTure tm(nGsv-nGrv,12)
	@ li,168 PSay (nGsq-nGrq)*100/IIF(nGsq#0,nGsq,1)	PicTure "999"
	roda(cbcont,cbtxt,Tamanho)
EndIf
Return .T.

