/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.Ch"
#Include "CTBR461.Ch"

STATIC aTamVal

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤยฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณ CTBR461  ณ Autor ณMARCOS HIRAKAWA        ณ Data ณ 30.03.10    ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Demonstrativo Contas diversas por cobrar                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ U_CTBR461(void)                                                 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณ Generico                                                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ Generico                                                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ Nenhum                                                        ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณProgramador ณData       ณ BOPS     ณ Motivo da Alteracao                  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณJonathan Glzณ26/06/2015 ณPCREQ-4256ณSe elimina la funcion AjustaSx1() la  ณฑฑ
ฑฑณ            ณ           ณ          ณcual realiza modificacion a SX1 por   ณฑฑ
ฑฑณ            ณ           ณ          ณmotivo de adecuacion a fuentes a nuevaณฑฑ
ฑฑณ            ณ           ณ          ณestructura de SX para Version 12.     ณฑฑ
ฑฑณJonathan Glzณ09/10/2015 ณPCREQ-4261ณMerge v12.1.8                         ณฑฑ
ฑฑณVer๓nica Floณ05/01/2021 ณDMINA-    ณSe agrega el titulo en la posicion delณฑฑ
ฑฑณ            ณ           ณ     10753ณobjeto TRSection()                    ณฑฑ
ฑฑณARodriguez  ณ21/01/2021 ณDMINA-    ณLimpieza de c๓digo, revisi๓n de buenasณฑฑ
ฑฑณ            ณ           ณ     10959ณprแcticas. Campo correlativo en el TXTณฑฑ
ฑฑณ            ณ           ณ          ณdebe ser CT2_LINHA para no generar dupณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Ctbr461()
Local cProg		:= ""
Local cCta		:= ""
Local nX		:= 0
Local nCombo	:= 0
Local nOpca		:= 0
Local aCtasRel	:= {}
Local aItens	:= {}
Local oDlg0
Local oCombo
Local cFilCT1	:= xFilial("CT1")

Private aRelatorio	:= {}
Private cSelCta		:= ""

aCtasRel := {{"10","","CTBR462"},{"12","","CTBR461A"},{"14","","CTBR461A"},{"16","","CTBR461A"},{"19","","CTBR461A"},{"40","","CTBR461A"},{"41","","CTBR461A"},{"42","","CTBR463"},{"46","","CTBR463"},{"47","","CTBR463"},{"49","","CTBR461A"},{"50","","CTBR461A"}}
CT1->(DbSetOrder(1))

For nX := 1 To Len(aCtasRel)
	If CT1->(msSeek(cFilCT1 + aCtasRel[nX,1]))
		aCtasRel[nX,2] := "(" + "Conta" + " " + aCtasRel[nX,1] + ") " + Lower(Alltrim(CT1->CT1_DESC01))
		Aadd(aItens,aCtasRel[nX,2])
	Else
		Aadd(aItens,aCtasRel[nX,2])
	Endif
Next

nOpca := 0

DEFINE MSDIALOG oDlg0 TITLE STR0013 FROM 000,000 TO 250,450 PIXEL
	@10,10 SAY (STR0014 + ": ") PIXEL OF oDlg0 SIZE 200, 9
	@20,10 LISTBOX oCombo VAR nCombo ITEMS aItens PIXEL OF oDlg0 SIZE 200, 90 ON DBLCLICK {||nOpca := oCombo:nAt,oDlg0:End()}
	oCombo:nAt := 1
	DEFINE SBUTTON FROM 115, 185 TYPE 1 ENABLE OF oDlg0 PIXEL ACTION ( (nOpca := oCombo:nAt ) , oDlg0:END() )
ACTIVATE DIALOG oDlg0 CENTER ON INIT {|| oCombo:SetFocus()}

If nOpca > 0
	cProg := "{|nOpca,cCta|," + aCtasRel[nOpca,3] + "(nOpca,cCta)" + "}"
	cCta := aCtasRel[nOpca,1]
	cSelCta:=cCta
	Eval(&cProg,nOpca,cCta)
Endif
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณ CTBR461A ณ Autor ณMarcos Hirakawa        ณ Data ณ 19.04.10    ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ 1 - "CLIENTES (CUENTA 12)"                                    ณฑฑ
ฑฑณDescri…o ณ 2- Demonstrativo Contas diversas por cobrar (CUENTA 16)       ณฑฑ
ฑฑณ          ณ 3 -PROVISIำN PARA CUENTAS DE COBRANZA DUDOSA (CUENTA 19)      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ U_CTBR461(nOpca)                                                ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณ Generico                                                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ Generico                                                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ nOpca 1- Demonstrativo de Contas de Cliente (CUENTA 12)       ณฑฑ
ฑฑณ          ณ nOpca 2- Demonstrativo Contas diversas por cobrar  (CUENTA 16)ณฑฑ
ฑฑณ          ณ nOpca 3- Demonstrativo de Provisi๓n para Contas de Cobranza   ณฑฑ
ฑฑณ          ณ          Dudosa (CUENTA 19)                                   ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Ctbr461A(nOpca,cCta)
Local lRet		 	:= .T.
Local CREPORT		:= ""
Local CTITULO		:= ""
Local CDESC			:= ""

Private titulo		:= ""
Private cDescMoeda	:= ""
Private cPicture	:= ""
Private cPerg	  	:= "CTR461"
Private nDecimais	:= 2
Private l1StQb		:= .T.
Private aSelFil  	:= {}
private aPergs      := {}
Private oReport
Private cCONTA1		:= cCta
Private cCONTA2		:= cCONTA1 + "zzz"

/*BEGINDOC
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCtDelSx1 -> Diminuiu a qtd de perguntas para PERU em relacao ao ATUSX .ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
ENDDOC*/

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCriacao da secao utilizada pelo relatorio                               ณ
//ณ                                                                        ณ
//ณTRSection():New                                                         ณ
//ณExpO1 : Objeto TReport que a secao pertence                             ณ
//ณExpC2 : Descricao da se็ao                                              ณ
//ณExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ณ
//ณ        sera considerada como principal para a se็ใo.                   ณ
//ณExpA4 : Array com as Ordens do relat๓rio                                ณ
//ณExpL5 : Carrega campos do SX3 como celulas                              ณ
//ณ        Default : False                                                 ณ
//ณExpL6 : Carrega ordens do Sindex                                        ณ
//ณ        Default : False                                                 ณ
//ณ                                                                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If !Pergunte( cperg , .T. )
	lRet := .F.
EndIf

IF lRet
 	// seta a moeda
 	aCtbMoeda	:= CtbMoeda(mv_par03)
 	If Empty(aCtbMoeda[1])
 		Help(" ",1,"NOMOEDA")
 		lRet := .F.
 	EndIf
Endif

If lRet .And. mv_par04 == 1 .And. Len( aSelFil ) <= 0 //SELECIONA FILIAIS
	aSelFil := AdmGetFil()
	If Len( aSelFil ) <= 0
		lRet := .F.
	EndIf
Else
	aSelFil := {cFilAnt}
EndIf

If !lRet
	Set Filter To
	Return
EndIf

cDescMoeda	:= aCtbMoeda[2]
nDecimais	:= aCtbMoeda[5]
cPicture	:= U_Ctb461Pic(nDecimais)

If CT1->(msSeek(xFilial("CT1") + cConta1))
	CTITULO := STR0013
	CREPORT := STR0013

	If cConta1 == "14
		CDESC := STR0037 + " " + cConta1 + " - " + "Cuentas por cobrar a accionistas(o socios) y personal."
	Else
		CDESC := STR0037 + " " + cConta1 + " " + Lower(Alltrim(CT1->CT1_DESC01))
	EndIf
Endif

Do Case
	Case cConta1 == "19"
		aRelatorio := {{.12,.12,.34,.17,.20,.22},{},{},{},{},{},{}}	//tamanho das celulas,detalhe,total,cabec1,cabec2
		/* Linha de detalhe */
		Aadd(aRelatorio[2],Nil)
		Aadd(aRelatorio[2],{"CTIPO",,"CENTER",,"14"})
		Aadd(aRelatorio[2],{"CNUMERO",,"CENTER",,"14"})
		Aadd(aRelatorio[2],{"CNOME",,"LEFT",,"14"})
		Aadd(aRelatorio[2],{"CDOCUM",,"CENTER",,"14"})
		Aadd(aRelatorio[2],{"DTPGTO",,"CENTER",,"14"})
		Aadd(aRelatorio[2],{"NVALOR",cPicture,"CENTER",,"134"})
		/* Linha de total */
		Aadd(aRelatorio[3],Nil)
		Aadd(aRelatorio[3],{"TOTFIL1",,"CENTER",,""})
		Aadd(aRelatorio[3],{"TOTFIL2",,"CENTER",,""})
		Aadd(aRelatorio[3],{"TOTFIL3",,"CENTER",,""})
		Aadd(aRelatorio[3],{"TOTFIL4",,"CENTER",{|| STR0015 },""})
		Aadd(aRelatorio[3],{"TOTFIL5",,"CENTER", {|| STR0016 },""})
		Aadd(aRelatorio[3],{"TOTVAL",cPicture,"CENTER",,"134"})
		/* Linha de cabecalho 1 */
		Aadd(aRelatorio[4],Nil)
		Aadd(aRelatorio[4],{"CABFIL1",,"CENTER",,"124"})
		Aadd(aRelatorio[4],{"CABFIL2",,"CENTER",,"24"})
		Aadd(aRelatorio[4],{"CABTER",,"LEFT",{|| STR0017 },"24"})
		Aadd(aRelatorio[4],{"CABDOC",,"RIGHT",{|| STR0018 },"124"})
		Aadd(aRelatorio[4],{"CABDAT",,"LEFT",{|| STR0019 },"24"})
		Aadd(aRelatorio[4],{"CABVAL",,"LEFT",{|| ""},"234"})
		/* Cabecalho 2 */
		Aadd(aRelatorio[5],Nil)
		Aadd(aRelatorio[5],{"CABTIPO",,"RIGHT",{|| STR0047 },"14"})
		Aadd(aRelatorio[5],{"CABNUM",,"LEFT",{|| STR0048},"4"})
		Aadd(aRelatorio[5],{"CABNOM",,"CENTER",{|| ""},"1"})
		Aadd(aRelatorio[5],{"CABDOC",,"CENTER",{|| ""},"1"})
		Aadd(aRelatorio[5],{"CABVAL",,"CENTER",{|| STR0026},"1"})
		Aadd(aRelatorio[5],{"CABDAT",,"CENTER",{|| ""},"13"})
		/* Linha de cabecalho 3 */
		Aadd(aRelatorio[6],Nil)
		Aadd(aRelatorio[6],{"CABTIPO",,"CENTER",{|| STR0021 },"1"})
		Aadd(aRelatorio[6],{"CABNUM",,"CENTER", {|| STR0022 },"1"})
		Aadd(aRelatorio[6],{"CABNOM",,"CENTER", {|| STR0059},"1"})
		Aadd(aRelatorio[6],{"CABDOC",,"CENTER", {|| STR0025 },"1"})
		Aadd(aRelatorio[6],{"CABDAT",,"CENTER", {|| STR0029+STR0061},"1"})
		Aadd(aRelatorio[6],{"CABVAL",,"RIGHT",  {|| STR0027 },"13"})
		/* Linha de cabecalho 4 */
		Aadd(aRelatorio[7],Nil)
		Aadd(aRelatorio[7],{"CABFIL1",,"CENTER",,"14"})
		Aadd(aRelatorio[7],{"CABFIL2",,"CENTER",,"14"})
		Aadd(aRelatorio[7],{"CABTER",,"CENTER",{|| STR0060 },"14"})
		Aadd(aRelatorio[7],{"CABDOC",,"LEFT",{|| ""},"14"})
		Aadd(aRelatorio[7],{"CABDAT",,"RIGHT",{|| STR0062 },"14"})
		Aadd(aRelatorio[7],{"CABVAL",,"LEFT",,"134"})

	Case cConta1 $ "12"
		aRelatorio := {{.1,.1,.54,.15,.12},{},{},{},{},{}}	//tamanho das celulas,detalhe,total,cabec1,cabec2
		//detalhe
		Aadd(aRelatorio[2],Nil)
		Aadd(aRelatorio[2],{"CTIPO",,"CENTER",,"14"})
		Aadd(aRelatorio[2],{"CNUMERO",,"CENTER",,"14"})
		Aadd(aRelatorio[2],{"CNOME",,"LEFT",,"14"})
		Aadd(aRelatorio[2],{"NVALOR",cPicture,"CENTER",,"14"})
		Aadd(aRelatorio[2],{"DTPGTO",,"CENTER",,"134"})
		//total
		Aadd(aRelatorio[3],Nil)
		Aadd(aRelatorio[3],{"TOTFIL1",,"CENTER",,""})
		Aadd(aRelatorio[3],{"TOTFIL2",,"CENTER",,""})
		Aadd(aRelatorio[3],{"TOTFIL3",,"CENTER",{|| STR0030 },""})
		Aadd(aRelatorio[3],{"TOTVAL",cPicture,"CENTER",,"14"})
		Aadd(aRelatorio[3],{"TOTFIL4",,"CENTER",,"1"})
		//Cabecalho 1
		Aadd(aRelatorio[4],Nil)
		Aadd(aRelatorio[4],{"CABFIL1",,"CENTER",,"124"})
	 	Aadd(aRelatorio[4],{"CABFIL2",,"CENTER",,"24"})
	 	Aadd(aRelatorio[4],{"CABTER",,"LEFT",  {|| STR0063 },"24"})
		Aadd(aRelatorio[4],{"CABVAL",,"CENTER",{|| STR0032 },"12"})
		Aadd(aRelatorio[4],{"CABDAT",,"CENTER",{|| STR0026 },"123"})
		/* Cabecalho 2 */
		Aadd(aRelatorio[5],Nil)
		Aadd(aRelatorio[5],{"CABTIPO",,"RIGHT",{|| STR0047 },"14"})
		Aadd(aRelatorio[5],{"CABNUM",,"LEFT",{|| STR0048},"4"})
		Aadd(aRelatorio[5],{"CABNOM",,"CENTER",{|| STR0059},"1"})
		Aadd(aRelatorio[5],{"CABVAL",,"CENTER",{|| ""},"1"})
		Aadd(aRelatorio[5],{"CABDAT",,"CENTER",{|| ""},"13"})
		/* Cabecalho 3 */
		Aadd(aRelatorio[6],Nil)
		Aadd(aRelatorio[6],{"CABTIPO",,"CENTER", {|| STR0021 },"14"})
		Aadd(aRelatorio[6],{"CABNUM",,"CENTER",  {|| STR0022 },"14"})
		Aadd(aRelatorio[6],{"CABNOM",,"CENTER",  {|| STR0060 },"14"})
		Aadd(aRelatorio[6],{"CABVAL",,"CENTER",  {|| STR0035 },"14"})
		Aadd(aRelatorio[6],{"CABDAT",,"CENTER",  {|| STR0036 },"134"})

	Case cConta1 $ "14"
		aRelatorio := {{.1,.1,.48,.2,.12},{},{},{},{},{}}	//tamanho das celulas,detalhe,total,cabec1,cabec2
		//detalhe
		Aadd(aRelatorio[2],Nil)
		Aadd(aRelatorio[2],{"CTIPO"	,,"CENTER",,"14"})
		Aadd(aRelatorio[2],{"CNUMERO",,"CENTER",,"14"})
		Aadd(aRelatorio[2],{"CNOME",,"LEFT",,"14"})
		Aadd(aRelatorio[2],{"NVALOR",cPicture,"CENTER",,"14"})
		Aadd(aRelatorio[2],{"DTPGTO",,"CENTER",,"134"})
		//total
		Aadd(aRelatorio[3],Nil)
		Aadd(aRelatorio[3],{"TOTFIL1",,"CENTER",,""})
		Aadd(aRelatorio[3],{"TOTFIL2",,"CENTER",,""})
		Aadd(aRelatorio[3],{"TOTFIL3",,"CENTER",{|| STR0030 },""})
		Aadd(aRelatorio[3],{"TOTVAL",cPicture,"CENTER",,"14"})
		Aadd(aRelatorio[3],{"TOTFIL4",,"CENTER",,"1"})
		//Cabecalho 1
		Aadd(aRelatorio[4],Nil)
		Aadd(aRelatorio[4],{"CABFIL1",,"CENTER",,"124"})
	 	Aadd(aRelatorio[4],{"CABFIL2",,"CENTER",,"24"})
	 	Aadd(aRelatorio[4],{"CABTER",,"LEFT",  {|| STR0052 },"24"})
		Aadd(aRelatorio[4],{"CABVAL",,"CENTER",{|| STR0054 },"12"})
		Aadd(aRelatorio[4],{"CABDAT",,"CENTER",{|| STR0055 },"123"})
		/* Cabecalho 2 */
		Aadd(aRelatorio[5],Nil)
		Aadd(aRelatorio[5],{"CABTIPO",,"RIGHT",{|| STR0047 },"14"})
		Aadd(aRelatorio[5],{"CABNUM",,"LEFT",{|| STR0048},"4"})
		Aadd(aRelatorio[5],{"CABNOM",,"CENTER",{|| STR0059},"1"})
		Aadd(aRelatorio[5],{"CABVAL",,"CENTER",{|| ""},"1"})
		Aadd(aRelatorio[5],{"CABDAT",,"CENTER",{|| ""},"13"})
		/* Cabecalho 3 */
		Aadd(aRelatorio[6],Nil)
		Aadd(aRelatorio[6],{"CABTIPO",,"CENTER", {|| STR0021 },"14"})
		Aadd(aRelatorio[6],{"CABNUM",,"CENTER",  {|| STR0022 },"14"})
		Aadd(aRelatorio[6],{"CABNOM",,"CENTER",  {|| STR0060 },"14"})
		Aadd(aRelatorio[6],{"CABVAL",,"CENTER",  {|| STR0035 },"14"})
		Aadd(aRelatorio[6],{"CABDAT",,"CENTER",  {|| STR0056 },"134"})

	Case cConta1 $ "16"
		aRelatorio := {{.1,.1,.54,.15,.16},{},{},{},{},{}}	//tamanho das celulas,detalhe,total,cabec1,cabec2
		//detalhe
		Aadd(aRelatorio[2],Nil)
		Aadd(aRelatorio[2],{"CTIPO",,"CENTER",,"14"})
		Aadd(aRelatorio[2],{"CNUMERO",,"CENTER",,"14"})
		Aadd(aRelatorio[2],{"CNOME",,"LEFT",,"14"})
		Aadd(aRelatorio[2],{"NVALOR",cPicture,"CENTER",,"14"})
		Aadd(aRelatorio[2],{"DTPGTO",,"CENTER",,"134"})
		//total
		Aadd(aRelatorio[3],Nil)
		Aadd(aRelatorio[3],{"TOTFIL1",,"CENTER",,""})
		Aadd(aRelatorio[3],{"TOTFIL2",,"CENTER",,""})
		Aadd(aRelatorio[3],{"TOTFIL3",,"CENTER",{|| STR0030 },""})
		Aadd(aRelatorio[3],{"TOTVAL",cPicture,"CENTER",,"14"})
		Aadd(aRelatorio[3],{"TOTFIL4",,"CENTER",,"1"})
		//Cabecalho 1
		Aadd(aRelatorio[4],Nil)
		Aadd(aRelatorio[4],{"CABFIL1",,"CENTER",,"124"})
	 	Aadd(aRelatorio[4],{"CABFIL2",,"CENTER",,"24"})
	 	Aadd(aRelatorio[4],{"CABTER",,"LEFT",  {|| STR0031 },"24"})
		Aadd(aRelatorio[4],{"CABVAL",,"CENTER",{|| STR0032 },"12"})
		Aadd(aRelatorio[4],{"CABDAT",,"CENTER",{|| STR0026 },"123"})
		/* Cabecalho 2 */
		Aadd(aRelatorio[5],Nil)
		Aadd(aRelatorio[5],{"CABTIPO",,"RIGHT",{|| STR0047 },"14"})
		Aadd(aRelatorio[5],{"CABNUM",,"LEFT",{|| STR0048},"4"})
		Aadd(aRelatorio[5],{"CABNOM",,"CENTER",{|| STR0059},"1"})
		Aadd(aRelatorio[5],{"CABVAL",,"CENTER",{|| ""},"1"})
		Aadd(aRelatorio[5],{"CABDAT",,"CENTER",{|| STR0029 + " "+ STR0061},"13"})
		/* Cabecalho 3 */
		Aadd(aRelatorio[6],Nil)
		Aadd(aRelatorio[6],{"CABTIPO",,"CENTER", {|| STR0021 },"14"})
		Aadd(aRelatorio[6],{"CABNUM",,"CENTER",  {|| STR0022 },"14"})
		Aadd(aRelatorio[6],{"CABNOM",,"CENTER",  {|| STR0060 },"14"})
		Aadd(aRelatorio[6],{"CABVAL",,"CENTER",  {|| STR0035 },"14"})
		Aadd(aRelatorio[6],{"CABDAT",,"CENTER",  {|| STR0062 },"134"})

	Case cConta1 == "40"
		aRelatorio	:= {{.20,.60,.20,},{},{},{},{}/*,{}*/}	//tamanho das celulas,detalhe,total,cabec1,cabec2
		//detalhe
		Aadd(aRelatorio[2],Nil)
		Aadd(aRelatorio[2],{"CCODIGO",,"LEFT",,"14"})
		Aadd(aRelatorio[2],{"CDESCRI",,"LEFT",,"14"})
		Aadd(aRelatorio[2],{"NVALOR",cPicture,"RIGHT",,"134"})
		//total
		Aadd(aRelatorio[3],Nil)
		Aadd(aRelatorio[3],{"TOTFIL1",,"CENTER",,""})
		Aadd(aRelatorio[3],{"TOTFIL2",,"RIGHT",{|| STR0015},""})
		Aadd(aRelatorio[3],{"TOTVAL",cPicture,"RIGHT",,"134"})
		//Cabecalho 1
		Aadd(aRelatorio[4],Nil)
		Aadd(aRelatorio[4],{"CABFIL1",,"CENTER",,"124"})
	 	Aadd(aRelatorio[4],{"CABTER",,"LEFT",{|| STR0039 },"24"})
		Aadd(aRelatorio[4],{"CABVAL",,"CENTER",{|| STR0040 },"1234"})
		/* Cabecalho 2 */
		Aadd(aRelatorio[5],Nil)
		Aadd(aRelatorio[5],{"CABTIPO",,"CENTER",{|| STR0041 },"14"})
		Aadd(aRelatorio[5],{"CABNOM",,"CENTER", {|| STR0042 },"14"})
		Aadd(aRelatorio[5],{"CABVAL",,"CENTER", {|| ""},"13"})

	Case cConta1 == "41"
		aRelatorio	:= {{.06,.24,.07,.24,.1,.1,.19},{},{},{},{},{} }	//tamanho das celulas,detalhe,total,cabec1,cabec2
		//detalhe
		Aadd(aRelatorio[2],Nil)
		Aadd(aRelatorio[2],{"CCODIGO",,"CENTER",,"14"})
		Aadd(aRelatorio[2],{"CDESCRI",,"LEFT",,"14"})
		Aadd(aRelatorio[2],{"CCODIGO2",,"CENTER",,"14"})
		Aadd(aRelatorio[2],{"CDESCRI2",,"LEFT",,"14"})
		Aadd(aRelatorio[2],{"CTIPO",,"CENTER",,"14"})
		Aadd(aRelatorio[2],{"CRG",,"CENTER",,"14"})
		Aadd(aRelatorio[2],{"NVALOR",cPicture,"RIGHT",,"134"})
		//total
		Aadd(aRelatorio[3],Nil)
		Aadd(aRelatorio[3],{"TOTFIL1",,"CENTER",,""})
		Aadd(aRelatorio[3],{"TOTFIL2",,"CENTER",,""})
		Aadd(aRelatorio[3],{"TOTFIL3",,"CENTER",,""})
		Aadd(aRelatorio[3],{"TOTFIL4",,"CENTER",,""})
		Aadd(aRelatorio[3],{"TOTFIL5",,"CENTER",,""})
		Aadd(aRelatorio[3],{"TOTFIL6",,"RIGHT",{|| STR0015},""})
		Aadd(aRelatorio[3],{"TOTVAL",cPicture,"RIGHT",,"134"})
		//Cabecalho 1
		Aadd(aRelatorio[4],Nil)
		Aadd(aRelatorio[4],{"CABFIL1",,"CENTER",,"12"})
	 	Aadd(aRelatorio[4],{"CABTER",,"LEFT",{|| STR0045},	"2"})
		Aadd(aRelatorio[4],{"CABFIL1",,"CENTER",,"124"})
	 	Aadd(aRelatorio[4],{"CABTER2",,"RIGHT",{|| STR0046},"24"})
		Aadd(aRelatorio[4],{"CABFIL1",,"CENTER",,"24"})
		Aadd(aRelatorio[4],{"CABFIL1",,"CENTER",,"24"})
		Aadd(aRelatorio[4],{"CABVAL",,"CENTER",{|| STR0040},"123"})
		/* Cabecalho 2 */
		Aadd(aRelatorio[5],Nil)
		Aadd(aRelatorio[5],{"CABFIL1",,"CENTER",{|| ""},"1"})
		Aadd(aRelatorio[5],{"CABFIL2",,"CENTER",{|| ""},""})
		Aadd(aRelatorio[5],{"CABCOD2",,"CENTER",{|| STR0041},"1"})
		Aadd(aRelatorio[5],{"CABNOM2",,"CENTER",{|| STR0023},"1"})
		Aadd(aRelatorio[5],{"CABRG" ,,"RIGHT",  {|| STR0047},"12"})
		Aadd(aRelatorio[5],{"CABFIL3",,"LEFT",  {|| STR0048},""})
		Aadd(aRelatorio[5],{"CABFIL4",,"CENTER",{|| ""},"13"})
		/* Cabecalho 3 */
		Aadd(aRelatorio[6],Nil)
		Aadd(aRelatorio[6],{"CABCOD1",,"CENTER",{|| STR0041 },"124"})
		Aadd(aRelatorio[6],{"CABNOM",,"CENTER", {|| STR0042 },"124"})
		Aadd(aRelatorio[6],{"CABFIL1",,"CENTER",{|| ""},"14"})
		Aadd(aRelatorio[6],{"CABFIL2",,"CENTER",{|| ""},"14"})
		Aadd(aRelatorio[6],{"CABFIL3",,"CENTER",{|| STR0021 },"124"})
		Aadd(aRelatorio[6],{"CABFIL2",,"CENTER",{|| STR0022 },"124"})
		Aadd(aRelatorio[6],{"CABVAL",,"CENTER", {|| ""},"134"})

	Case cConta1 == "49"
		aRelatorio	:= {{.60,.22,.20,},{},{},{}/*,{}*/}	//tamanho das celulas,detalhe,total,cabec1,cabec2
		//detalhe
		Aadd(aRelatorio[2],Nil)
		Aadd(aRelatorio[2],{"CDESCRI",,"LEFT",,"14"})
		Aadd(aRelatorio[2],{"CNUM",,"LEFT",,"14"})
		Aadd(aRelatorio[2],{"NVALOR",cPicture,"RIGHT",,"134"})
		//total
		Aadd(aRelatorio[3],Nil)
		Aadd(aRelatorio[3],{"TOTFIL1",,"CENTER",,""})
		Aadd(aRelatorio[3],{"TOTFIL2",,"RIGHT",{|| STR0015 },""})
		Aadd(aRelatorio[3],{"TOTVAL",cPicture,"RIGHT",,"134"})
		/* Cabecalho 2 */
		Aadd(aRelatorio[4],Nil)
		Aadd(aRelatorio[4],{"CABTIPO",,"CENTER",{|| "Concepto" },"124"})
		Aadd(aRelatorio[4],{"CABNOM",,"CENTER", {|| "N๚mero de Comprobante de Pago Relacionado" },"124"})
		Aadd(aRelatorio[4],{"CABVAL",,"CENTER", {|| STR0040},"1234"})

	Case cConta1 == "50"
		aRelatorio	:= {{.60,.22,.20,},{},{},{}/*,{}*/}	//tamanho das celulas,detalhe,total,cabec1,cabec2
		//detalhe
		Aadd(aRelatorio[2],Nil)
		Aadd(aRelatorio[2],{"CDESCRI",,"LEFT",,"14"})
		Aadd(aRelatorio[2],{"CNUM",,"LEFT",,"14"})
		Aadd(aRelatorio[2],{"NVALOR",cPicture,"RIGHT",,"134"})
		//total
		Aadd(aRelatorio[3],Nil)
		Aadd(aRelatorio[3],{"TOTFIL1",,"CENTER",,""})
		Aadd(aRelatorio[3],{"TOTFIL2",,"RIGHT",{|| STR0015 },""})
		Aadd(aRelatorio[3],{"TOTVAL",cPicture,"RIGHT",,"134"})
		/* Cabecalho 2 */
		Aadd(aRelatorio[4],Nil)
		Aadd(aRelatorio[4],{"CABTIPO",,"CENTER",{|| "Concepto" },"124"})
		Aadd(aRelatorio[4],{"CABNOM",,"CENTER", {|| "N๚mero de Comprobante de Pago Relacionado" },"124"})
		Aadd(aRelatorio[4],{"CABVAL",,"CENTER", {|| STR0040},"1234"})

EndCase

oReport := U_CTB461Def(CREPORT,CTITULO,CPERG,CDESC)
oReport:SetAction({|oReport| ReportPrint(oReport)})

IF Valtype( oReport ) == 'O'
	If !Empty( oReport:uParam )
		Pergunte( oReport:uParam, .F. )
	EndIf
	oReport:PrintDialog()
Endif

oReport := Nil
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณReportPrintณ Autor ณ Roberto Rog้rio Mezzalira ณ Data ณ 30/12/09 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณImprime o relatorio definido pelo usuario de acordo com as       ณฑฑ
ฑฑณ          ณsecoes/celulas criadas na funcao ReportDef definida acima.       ณฑฑ
ฑฑณ          ณNesta funcao deve ser criada a query das secoes se SQL ou        ณฑฑ
ฑฑณ          ณdefinido o relacionamento e filtros das tabelas em CodeBase.     ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ ReportPrint(oReport)                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณEXPO1: Objeto do relat๓rio                                       ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportPrint(oReport)
Local oSection1 	:= aRelatorio[2,1]
Local nToDiaD		:= 0
Local nToMesC		:= 0
Local nToMesD		:= 0
Local nK			:= 0
Local nSaldoFin		:= 0
Local cFilOld	    := cFilAnt
Local aArea			:= GetArea()
Local aAreaSM0		:= SM0->(GetArea())
Local nValor		:= 0
Local lOracle		:= "ORACLE"   $ Alltrim(Upper(TCGetDB()))
Local lPostgres 	:= "POSTGRES" $ Alltrim(Upper(TCGetDB()))
Local lDB2			:= "DB2"      $ Alltrim(Upper(TCGetDB()))
Local lInformix 	:= "INFORMIX" $ Alltrim(Upper(TCGetDB()))
Local nReg			:= 0
Local nTotQuebra	:= 0
Local cQuebra		:= ''
Local cFilCT1 		:= ''
Local cFilSRA 		:= ''
Local cFilCT2 		:= ''
Local cFilSA1 		:= ''
Local cFilCV3 		:= ''
Local cFilSE1 		:= ''
Local cFilCQ1 		:= ''
Local cFilSA2 		:= ''
Local cFilSE2 		:= ''
LOCAL cAliasCgc     := "QRYCGCFIS"
Local _cCgcFisica 	:= " "
Local _cNomeCli   	:= " "
local _cQuery     	:= " "
Local aCliCT2	  	:= {}
Local nPos 		  	:= 0
Local cCuenta 		:= ""
local cTipoDoc 		:= ""
Local cTpDoc		:= ""
Local cSerie		:= ""
Local cDoc			:= ""
Local cX3Uso		:= ""
Local cNoDoc		:= ""
Local cLinha		:= ""
Local lSerie2		:= (SF2->(ColumnPos("F2_SERIE2")) > 0 .And. GetNewPar("MV_LSERIE2", .F.))

Private cCampDoc	:= ""
Private cCampo		:= ""

U_Ctb461Dim(oReport)

For nK := 1 to Len(aSelFil)

	cFilAnt := aSelFil[nK]
	SM0->(msSeek(cEmpAnt+cFilAnt))
	nToDiaD		:= 0
	nToMesC		:= 0
	nToMesD		:= 0

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//| titulo do relatorio                                          |
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If cConta1 == "14"
		titulo := STR0037 + " " + cConta1 + " - " + "Cuentas por cobrar a accionistas(o socios) y personal."
	Else
		If CT1->(msSeek(cFilCT1 + cConta1))
			titulo := STR0037 + " " + cConta1 + " " + Lower(Alltrim(CT1->CT1_DESC01))
		Endif
	EndIf

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//| cabe็alho do relatorio                                       |
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤcฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oReport:SetCustomText( {|| U_CTB461CabL(oReport,titulo,MV_PAR01,MV_PAR02,(MV_PAR04 == 1))} )

	cAliasqry := GetNextAlias()
	IF Select( cAliasqry ) > 0
		dbSelectArea( cAliasqry )
		dbCloseArea()
	EndIf

	If cConta1 $ "12,16,19" // CLIENTES (CUENTA 12) // "POR COBRAR DIVERSAS (CUENTA 16)"
		If cConta1 ==  '16' //deve ser ordenado por conta -> Chamado TFJCIV
			cFilCT2 := xFilial('CT2')
			cFilCV3 := xFilial('CV3')
			cFilSE1 := xFilial('SE1')
			cFilSA1 := xFilial('SA1')
			cFilCT1 := xFilial('CT1')
   			cFilSF2 := xFilial('SF2')

			BeginSql alias cAliasqry

				SELECT CT1.CT1_CONTA,CT1.CT1_DESC01,CT2.CT2_DATA,CT2.CT2_VALOR,CT2.CT2_DEBITO,CT2.CT2_CREDIT,CT2_EC05DB,CT2_EC05CR,CT2.CT2_NODIA,CV3.CV3_SEQUEN,SA1.A1_NOME,SA1.A1_CGC,SA1.A1_PFISICA,SA1.A1_TIPDOC,SE1.E1_EMISSAO,SE1.E1_NUM,SF2.F2_EMISSAO,SF2.F2_DOC,SF2.F2_TPDOC,SF2.F2_SERIE,CT2.R_E_C_N_O_,CT2_SBLOTE,CT2_LINHA,CT2_ROTINA
				FROM %table:CT1% CT1
				LEFT JOIN %table:CT2% CT2 ON CT2.CT2_FILIAL=(%exp:cFilCT2%) AND CT2_DEBITO = CT1_CONTA AND CT2.CT2_DATA BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND CT2.%notDel%
				LEFT JOIN %table:CV3% CV3 ON CV3.CV3_FILIAL=(%exp:cFilCV3%) AND CV3_DEBITO = CT1_CONTA AND CV3.CV3_SEQUEN = CT2.CT2_SEQUEN AND CV3_TABORI = 'SD2' AND CV3.%notDel%
				LEFT JOIN %table:SE1% SE1 ON SE1.E1_FILIAL =(%exp:cFilSE1%) AND E1_NODIA = CT2_NODIA AND SE1.E1_EMISSAO BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND SE1.%notDel%
				LEFT JOIN %table:SF2% SF2 ON SF2.F2_FILIAL =(%exp:cFilSF2%) AND F2_NODIA = CT2_NODIA AND SF2.F2_EMISSAO BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND SF2.%notDel%
				LEFT JOIN %table:SA1% SA1 ON SA1.A1_FILIAL =(%exp:cFilSA1%) AND ((A1_COD = SF2.F2_CLIENTE AND SA1.A1_LOJA = SF2.F2_LOJA) or (A1_COD = SE1.E1_CLIENTE AND SA1.A1_LOJA = SE1.E1_LOJA)) AND SA1.%notDel%
				WHERE CT1.CT1_FILIAL = (%exp:cFilCT1%)
				AND SUBSTRING(CT1_CONTA,1,2) = (%exp:cSelCta%) AND CT1.%notDel%
				AND CT2.CT2_MOEDLC = (%exp:mv_par03%) AND CT2.CT2_VALOR <> 0
				UNION
				SELECT CT1.CT1_CONTA,CT1.CT1_DESC01,CT2.CT2_DATA,CT2.CT2_VALOR,CT2.CT2_DEBITO,CT2.CT2_CREDIT,CT2_EC05DB,CT2_EC05CR,CT2.CT2_NODIA,CV3.CV3_SEQUEN,SA1.A1_NOME,SA1.A1_CGC,SA1.A1_PFISICA,SA1.A1_TIPDOC,SE1.E1_EMISSAO,SE1.E1_NUM,SF2.F2_EMISSAO,SF2.F2_DOC,SF2.F2_TPDOC,SF2.F2_SERIE,CT2.R_E_C_N_O_,CT2_SBLOTE,CT2_LINHA,CT2_ROTINA
				FROM %table:CT1% CT1
				LEFT JOIN %table:CT2% CT2 ON CT2.CT2_FILIAL=(%exp:cFilCT2%) AND CT2_CREDIT = CT1_CONTA AND CT2.CT2_DATA BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND CT2.%notDel%
				LEFT JOIN %table:CV3% CV3 ON CV3.CV3_FILIAL=(%exp:cFilCV3%) AND CV3_CREDIT = CT1_CONTA AND CV3.CV3_SEQUEN = CT2.CT2_SEQUEN AND CV3_TABORI = 'SD2' AND CV3.%notDel%
				LEFT JOIN %table:SE1% SE1 ON SE1.E1_FILIAL =(%exp:cFilSE1%) AND E1_NODIA = CT2_NODIA AND SE1.E1_EMISSAO BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND SE1.%notDel%
				LEFT JOIN %table:SF2% SF2 ON SF2.F2_FILIAL =(%exp:cFilSF2%) AND F2_NODIA = CT2_NODIA AND SF2.F2_EMISSAO BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND SF2.%notDel%
				LEFT JOIN %table:SA1% SA1 ON SA1.A1_FILIAL =(%exp:cFilSA1%) AND A1_COD = E1_CLIENTE AND SA1.A1_LOJA = SE1.E1_LOJA AND SA1.%notDel%
				WHERE CT1.CT1_FILIAL = (%exp:cFilCT1%)
				AND SUBSTRING(CT1_CONTA,1,2) = (%exp:cSelCta%) AND CT1.%notDel%
				AND CT2.CT2_MOEDLC = (%exp:mv_par03%) AND CT2.CT2_VALOR <> 0
				ORDER BY CT1_CONTA

			EndSql

        Else
			cFilCT2 := xFilial('CT2')
			cFilCV3 := xFilial('CV3')
			cFilSE1 := xFilial('SE1')
			cFilSA1 := xFilial('SA1')
   			cFilCT1 := xFilial('CT1')
   			cFilSF2 := xFilial('SF2')

			BeginSql alias cAliasqry

				SELECT CT1.CT1_CONTA,CT1.CT1_DESC01,CT2.CT2_DATA,CT2.CT2_VALOR,CT2.CT2_DEBITO,CT2.CT2_CREDIT,CT2_EC05DB,CT2_EC05CR,CT2.CT2_NODIA,SF2.F2_DOC,CV3.CV3_SEQUEN,SA1.A1_NOME,SA1.A1_CGC,SA1.A1_PFISICA,SA1.A1_TIPDOC,SE1.E1_EMISSAO,SE1.E1_NUM,SF2.F2_EMISSAO,SF2.F2_TPDOC,SF2.F2_SERIE,CT2.R_E_C_N_O_,CT2_SBLOTE,CT2_LINHA,CT2_ROTINA
				FROM %table:CT1% CT1
				LEFT JOIN %table:CT2% CT2 ON CT2.CT2_FILIAL=(%exp:cFilCT2%) AND CT2_DEBITO = CT1_CONTA AND CT2.CT2_DATA BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND CT2.%notDel%
				LEFT JOIN %table:CV3% CV3 ON CV3.CV3_FILIAL=(%exp:cFilCV3%) AND CV3_DEBITO = CT1_CONTA AND CV3.CV3_SEQUEN = CT2.CT2_SEQUEN AND CV3_TABORI = 'SD2' AND CV3.%notDel%
				LEFT JOIN %table:SE1% SE1 ON SE1.E1_FILIAL =(%exp:cFilSE1%) AND E1_NODIA = CT2_NODIA AND SE1.E1_EMISSAO BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND SE1.%notDel%
				LEFT JOIN %table:SF2% SF2 ON SF2.F2_FILIAL =(%exp:cFilSF2%) AND F2_NODIA = CT2_NODIA AND SF2.F2_EMISSAO BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND SF2.%notDel%
				LEFT JOIN %table:SA1% SA1 ON SA1.A1_FILIAL =(%exp:cFilSA1%) AND ((A1_COD = SF2.F2_CLIENTE AND SA1.A1_LOJA = SF2.F2_LOJA) or (A1_COD = SE1.E1_CLIENTE AND SA1.A1_LOJA = SE1.E1_LOJA)) AND SA1.%notDel%
				WHERE CT1.CT1_FILIAL = (%exp:cFilCT1%)
				AND SUBSTRING(CT1_CONTA,1,2) = (%exp:cSelCta%) AND CT1.%notDel%
				AND CT2.CT2_MOEDLC = (%exp:mv_par03%) AND CT2.CT2_VALOR <> 0
				UNION
				SELECT CT1.CT1_CONTA,CT1.CT1_DESC01,CT2.CT2_DATA,CT2.CT2_VALOR,CT2.CT2_DEBITO,CT2.CT2_CREDIT,CT2_EC05DB,CT2_EC05CR,CT2.CT2_NODIA,SF2.F2_DOC,CV3.CV3_SEQUEN,SA1.A1_NOME,SA1.A1_CGC,SA1.A1_PFISICA,SA1.A1_TIPDOC,SE1.E1_EMISSAO,SE1.E1_NUM,SF2.F2_EMISSAO,SF2.F2_TPDOC,SF2.F2_SERIE,CT2.R_E_C_N_O_,CT2_SBLOTE,CT2_LINHA,CT2_ROTINA
				FROM %table:CT1% CT1
				LEFT JOIN %table:CT2% CT2 ON CT2.CT2_FILIAL=(%exp:cFilCT2%) AND CT2_CREDIT = CT1_CONTA AND CT2.CT2_DATA BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND CT2.%notDel%
				LEFT JOIN %table:CV3% CV3 ON CV3.CV3_FILIAL=(%exp:cFilCV3%) AND CV3_CREDIT = CT1_CONTA AND CV3.CV3_SEQUEN = CT2.CT2_SEQUEN AND CV3_TABORI = 'SD2' AND CV3.%notDel%
				LEFT JOIN %table:SE1% SE1 ON SE1.E1_FILIAL =(%exp:cFilSE1%) AND E1_NODIA = CT2_NODIA AND SE1.E1_EMISSAO BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND SE1.%notDel%
				LEFT JOIN %table:SF2% SF2 ON SF2.F2_FILIAL =(%exp:cFilSF2%) AND F2_NODIA = CT2_NODIA AND SF2.F2_EMISSAO BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND SF2.%notDel%
				LEFT JOIN %table:SA1% SA1 ON SA1.A1_FILIAL =(%exp:cFilSA1%) AND ((A1_COD = SF2.F2_CLIENTE AND SA1.A1_LOJA = SF2.F2_LOJA) or (A1_COD = SE1.E1_CLIENTE AND SA1.A1_LOJA = SE1.E1_LOJA)) AND SA1.%notDel%
				WHERE CT1.CT1_FILIAL = (%exp:cFilCT1%)
				AND SUBSTRING(CT1_CONTA,1,2) = (%exp:cSelCta%) AND CT1.%notDel%
				AND CT2.CT2_MOEDLC = (%exp:mv_par03%) AND CT2.CT2_VALOR <> 0
				ORDER BY CT2_DATA, CT1_CONTA, A1_CGC

			EndSql

		EndIf

	ElseIf cConta1 == "14" // CLIENTES (CUENTA 14)
		If lOracle .Or. lPostgres .Or. lDB2 .Or. lInformix
			cFilCT1 := xFilial('CT1')
			cFilCV3 := xFilial('CV3')
			cFilSE1 := xFilial('SE1')
			cFilSA1 := xFilial('SA1')

			BeginSql alias cAliasqry

				SELECT distinct SA1.A1_TIPDOC, SA1.A1_CGC, SA1.A1_PFISICA , SA1.A1_NOME , SE1.E1_VALOR , SE1.E1_EMISSAO, CV3_SEQUEN, CT2.CT2_DEBITO, CT2.CT2_VALOR
				FROM %table:CT1% CT1, %table:CT2% CT2, %table:SE1% SE1, %table:SA1% SA1, %table:CV3% CV3
				WHERE CT1.CT1_FILIAL = (%exp:cFilCT1%)                              // FILTRO CT1 FILIAL
				AND CT1.%notDel%                                                           	// FILTRO CT1 DELET
				AND CT1.CT1_CONTA  BETWEEN (%exp:cCONTA1%) AND (%exp:cCONTA2%)   			// FILTRO CT1_CONTA
				AND CT2.CT2_FILIAL = (%exp:cFilAnt%)                                       	// FILTRO CT2 FILIAL
				AND CT2.%notDel%                                                           	// FILTRO CT2 DELET
				AND CT2.CT2_MOEDLC = (%exp:mv_par03%)                                      	// FILTRO CT2_MOEDLC MV_PAR03 //
				AND CV3.CV3_FILIAL = (%exp:cFilCV3%)                                // FILTRO CV3 FILIAL
				AND CV3.%notDel%                                                           	// FILTRO CV3 DELET
				AND CV3_TABORI     = 'SE1'                                                 	// FILTRO CV3_TABORI PARA SE1
				AND SE1.E1_FILIAL  = (%exp:cFilSE1%)                                // FILTRO E1 FILIAL
				AND SE1.%notDel%                                                           	// FILTRO E1 DELET
				AND SE1.E1_EMISSAO BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%)           // FILTRO E1_EMISSAO MV_PAR01 / Data inicial e MV_PAR02 final)
				AND SA1.A1_FILIAL  = (%exp:cFilSA1%)                                // FILTRO A1 FILIAL
				AND SA1.%notDel%                                                           	// FILTRO A1 DELET
				AND CT1.CT1_CONTA  = CT2.CT2_DEBITO                                        	//  RELACIONAMENTO CT1 / CT2 devido ao parametro referente CT1_GRUPO.
				AND CT2.CT2_SEQUEN = CV3.CV3_SEQUEN                                        	//  RELACIONAMENTO CT2 / CV3 .
				AND SE1.E1_EMISSAO = CT2.CT2_DATA		                                    //  RELACIONAMENTO CT2 / SE1 .
				AND CT2_NODIA      = SE1.E1_NODIA                                          	//  RELACIONAMENTO CT2 / SE1 .
				AND SE1.E1_CLIENTE = SA1.A1_COD										       	//  RELACIONAMENTO SE1 / SA1 Referente ao cliente e RUC / CGC
				AND SE1.E1_LOJA    = SA1.A1_LOJA											//  RELACIONAMENTO SE1 / SA1 Referente ao cliente e RUC / CGC
				AND CT2.CT2_KEY    = SE1.E1_FILIAL || SE1.E1_PREFIXO || SE1.E1_NUM || SE1.E1_PARCELA || SE1.E1_TIPO
				ORDER BY SE1.E1_EMISSAO, SA1.A1_CGC , CV3_SEQUEN			                //  ORDENACAO

			EndSql

		Else
			cFilCT1 := xFilial('CT1')
			cFilCV3 := xFilial('CV3')
			cFilSE1 := xFilial('SE1')
			cFilSA1 := xFilial('SA1')

	 		BeginSql alias cAliasqry

				SELECT distinct SA1.A1_TIPDOC, SA1.A1_CGC,SA1.A1_PFISICA , SA1.A1_NOME , SE1.E1_VALOR , SE1.E1_EMISSAO, CV3_SEQUEN, CT2.CT2_DEBITO, CT2.CT2_VALOR,CT2_NODIA
				FROM %table:CT1% CT1, %table:CT2% CT2, %table:SE1% SE1, %table:SA1% SA1, %table:CV3% CV3
				WHERE CT1.CT1_FILIAL = (%exp:cFilCT1%)                              // FILTRO CT1 FILIAL
				AND CT1.%notDel%                                                           	// FILTRO CT1 DELET
				AND CT1.CT1_CONTA  BETWEEN (%exp:cCONTA1%) AND (%exp:cCONTA2%)   			// FILTRO CT1_CONTA
				AND CT2.CT2_FILIAL = (%exp:cFilAnt%)                                       	// FILTRO CT2 FILIAL
				AND CT2.%notDel%                                                           	// FILTRO CT2 DELET
				AND CT2.CT2_MOEDLC = (%exp:mv_par03%)                                      	// FILTRO CT2_MOEDLC MV_PAR03 //
				AND CV3.CV3_FILIAL = (%exp:cFilCV3%)                                // FILTRO CV3 FILIAL
				AND CV3.%notDel%                                                           	// FILTRO CV3 DELET
				AND CV3_TABORI     = 'SE1'                                                 	// FILTRO CV3_TABORI PARA SE1
				AND SE1.E1_FILIAL  = (%exp:cFilSE1%)                                // FILTRO E1 FILIAL
				AND SE1.%notDel%                                                           	// FILTRO E1 DELET
				AND SE1.E1_EMISSAO BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%)           // FILTRO E1_EMISSAO MV_PAR01 / Data inicial e MV_PAR02 final)
				AND SA1.A1_FILIAL  = (%exp:cFilSA1%)                                // FILTRO A1 FILIAL
				AND SA1.%notDel%                                                           	// FILTRO A1 DELET
				AND CT1.CT1_CONTA  = CT2.CT2_DEBITO                                        	//  RELACIONAMENTO CT1 / CT2 devido ao parametro referente CT1_GRUPO.
				AND CT2.CT2_SEQUEN = CV3.CV3_SEQUEN                                        	//  RELACIONAMENTO CT2 / CV3 .
				AND SE1.E1_EMISSAO = CT2.CT2_DATA		                                    //  RELACIONAMENTO CT2 / SE1 .
				AND CT2_NODIA      = SE1.E1_NODIA                                          	//  RELACIONAMENTO CT2 / SE1 .
				AND SE1.E1_CLIENTE = SA1.A1_COD										       	//  RELACIONAMENTO SE1 / SA1 Referente ao cliente e RUC / CGC
				AND SE1.E1_LOJA    = SA1.A1_LOJA											//  RELACIONAMENTO SE1 / SA1 Referente ao cliente e RUC / CGC
				AND CT2.CT2_KEY    = SE1.E1_FILIAL + SE1.E1_PREFIXO + SE1.E1_NUM + SE1.E1_PARCELA + SE1.E1_TIPO
				ORDER BY SE1.E1_EMISSAO, SA1.A1_CGC , CV3_SEQUEN			                //  ORDENACAO

			EndSql
		EndIf

	ElseIf cConta1 == "40" // DETALHE DE SALDO DA CONTA 40 - TRIBUTOS A PAGAR
		cFilCQ1 := xFilial('CQ1')
		cFilCT1 := xFilial('CT1')

		BeginSql alias cAliasqry

			SELECT CQ1_CONTA, CT1_DESC01, SUM( CQ1_DEBITO ) AS CQ1_DEBITO, SUM( CQ1_CREDIT ) AS CQ1_CREDIT
			FROM %table:CQ1% CQ1
			LEFT JOIN %table:CT1% CT1 ON CT1_CONTA = CQ1_CONTA
			WHERE CQ1.%notDel% AND
			CQ1_FILIAL = (%exp:cFilCQ1%) AND
			CQ1_TPSALD = '1' AND
			CQ1_MOEDA = (%exp:MV_PAR03%) AND
			substring( CQ1_CONTA, 1, 2 ) = '40' AND
			CQ1_DATA BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND
			CT1_FILIAL = (%exp:cFilCT1%) AND
			CT1.%notDel%
			GROUP BY CQ1_CONTA, CT1_DESC01
			ORDER BY CQ1_CONTA

		EndSql

	ElseIf cConta1 == "41" // DETALHE DE SALDO DA CONTA 41 - REMUNERACAO A PAGAR
		cFilCT1 := xFilial('CT1')
		cFilCT2 := xFilial('CT2')
		cFilSRA := xFilial('SRA')
		cX3Uso := GetSX3Cache("RA_RG","X3_USADO")

		If X3Uso(cX3Uso)
			cCampo:= "%" + "RA_RG" + "%"
		Else
			cCampo:= "%" + "RA_CIC" + "%"
		EndIf

		cX3Uso := GetSX3Cache("RA_TPDOCTO","X3_USADO")

		If X3Uso(cX3Uso)
			cCamDoc:= "%" + "RA_TPDOCTO" + "%"
		Else
			cCamDoc:= "%" + "RA_TPCIC" + "%"
		EndIf

		BeginSql alias cAliasqry

			SELECT CT1_CONTA, CT1_DESC01, RA_MAT, RA_NOME, %exp:cCamDoc%, %exp:cCampo%, CT2_DATA, CT2_DEBITO, CT2_CREDIT, CT2_VALOR, CT2_EC05DB, CT2_EC05CR, CT2_NODIA, CT2_SBLOTE, CT2_LINHA, CT2_ROTINA
			FROM %table:CT1% CT1
			LEFT JOIN %table:CT2% CT2 ON CT2.CT2_FILIAL=(%exp:cFilCT2%) AND CT2_DEBITO = CT1_CONTA AND CT2.CT2_DATA BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND CT2.%notDel%
			LEFT JOIN %table:SRA% SRA ON SRA.RA_FILIAL = (%exp:cFilSRA%) AND %exp:cCampo% <> ' ' AND ( %exp:cCampo% = CT2_EC05DB OR %exp:cCampo% = CT2_EC05CR ) AND SRA.%notDel%
			WHERE CT1.CT1_FILIAL = (%exp:cFilCT1%)
			AND SUBSTRING(CT1_CONTA,1,2) = (%exp:cSelCta%) AND CT1.%notDel%
			AND CT2.CT2_MOEDLC = (%exp:mv_par03%) AND CT2.CT2_VALOR <> 0
			UNION
			SELECT CT1_CONTA, CT1_DESC01, RA_MAT, RA_NOME, %exp:cCamDoc% , %exp:cCampo%, CT2_DATA, CT2_DEBITO, CT2_CREDIT, CT2_VALOR, CT2_EC05DB, CT2_EC05CR, CT2_NODIA, CT2_SBLOTE, CT2_LINHA, CT2_ROTINA
			FROM %table:CT1% CT1
			LEFT JOIN %table:CT2% CT2 ON CT2.CT2_FILIAL=(%exp:cFilCT2%) AND CT2_CREDIT = CT1_CONTA AND CT2.CT2_DATA BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND CT2.%notDel%
			LEFT JOIN %table:SRA% SRA ON SRA.RA_FILIAL = (%exp:cFilSRA%) AND	%exp:cCampo% <> ' ' AND ( %exp:cCampo% = CT2_EC05DB OR %exp:cCampo% = CT2_EC05CR ) AND SRA.%notDel%
			WHERE CT1.CT1_FILIAL = (%exp:cFilCT1%)
			AND SUBSTRING(CT1_CONTA,1,2) = (%exp:cSelCta%) AND CT1.%notDel%
			AND CT2.CT2_MOEDLC = (%exp:mv_par03%) AND CT2.CT2_VALOR <> 0
			ORDER BY CT2_DATA, CT1_CONTA, RA_MAT

		EndSql

	ElseIf cConta1 == "49" // DETALHE DE SALDO DA CONTA 49
		cFilCT1 := xFilial('CT1')
		cFilCT2 := xFilial('CT2')
		cFilCV3 := xFilial('CV3')
		cFilSA2 := xFilial('SA2')
		cFilSE2 := xFilial('SE2')

		BeginSql alias cAliasqry

	  		SELECT CT1.CT1_CONTA,CT1.CT1_DESC01,CT2.CT2_DATA,CT2.CT2_VALOR,CT2.CT2_DEBITO,CT2.CT2_CREDIT,CT2_EC05DB,CT2_EC05CR,CT2.CT2_NODIA,CV3.CV3_SEQUEN,SA2.A2_NOME,SA2.A2_CGC,SA2.A2_PFISICA,SA2.A2_TIPDOC,SE2.E2_EMISSAO,SE2.E2_NUM
			FROM %table:CT1% CT1
			LEFT JOIN %table:CT2% CT2 ON CT2.CT2_FILIAL=(%exp:cFilCT2%) AND CT2_DEBITO = CT1_CONTA AND CT2.CT2_DATA BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND CT2.%notDel%
			LEFT JOIN %table:CV3% CV3 ON CV3.CV3_FILIAL=(%exp:cFilCV3%) AND CV3_DEBITO = CT1_CONTA AND CV3.CV3_SEQUEN = CT2.CT2_SEQUEN AND CV3_TABORI = 'SE2' AND CV3.%notDel%
			LEFT JOIN %table:SE2% SE2 ON SE2.E2_FILIAL =(%exp:cFilSE2%) AND E2_NODIA = CT2_NODIA AND SE2.E2_EMISSAO BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND SE2.%notDel%
			LEFT JOIN %table:SA2% SA2 ON SA2.A2_FILIAL =(%exp:cFilSA2%) AND A2_COD = E2_FORNECE AND A2_LOJA = E2_LOJA AND SA2.%notDel%
			WHERE CT1.CT1_FILIAL = (%exp:cFilCT1%)
			AND SUBSTRING(CT1_CONTA,1,2) = (%exp:cSelCta%) AND CT1.%notDel%
			AND CT2.CT2_MOEDLC = (%exp:mv_par03%) AND CT2.CT2_VALOR <> 0
			UNION
	  		SELECT CT1.CT1_CONTA,CT1.CT1_DESC01,CT2.CT2_DATA,CT2.CT2_VALOR,CT2.CT2_DEBITO,CT2.CT2_CREDIT,CT2_EC05DB,CT2_EC05CR,CT2.CT2_NODIA,CV3.CV3_SEQUEN,SA2.A2_NOME,SA2.A2_CGC,SA2.A2_PFISICA,SA2.A2_TIPDOC,SE2.E2_EMISSAO,SE2.E2_NUM
			FROM %table:CT1% CT1
			LEFT JOIN %table:CT2% CT2 ON CT2.CT2_FILIAL=(%exp:cFilCT2%) AND CT2_CREDIT = CT1_CONTA AND CT2.CT2_DATA BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND CT2.%notDel%
			LEFT JOIN %table:CV3% CV3 ON CV3.CV3_FILIAL=(%exp:cFilCV3%) AND CV3_CREDIT = CT1_CONTA AND CV3.CV3_SEQUEN = CT2.CT2_SEQUEN AND CV3_TABORI = 'SE2' AND CV3.%notDel%
			LEFT JOIN %table:SE2% SE2 ON SE2.E2_FILIAL =(%exp:cFilSE2%) AND E2_NODIA = CT2_NODIA AND SE2.E2_EMISSAO BETWEEN (%exp:MV_PAR01%) AND (%exp:MV_PAR02%) AND SE2.%notDel%
			LEFT JOIN %table:SA2% SA2 ON SA2.A2_FILIAL =(%exp:cFilSA2%) AND A2_COD = E2_FORNECE AND A2_LOJA = E2_LOJA AND SA2.%notDel%
			WHERE CT1.CT1_FILIAL = (%exp:cFilCT1%)
			AND SUBSTRING(CT1_CONTA,1,2) = (%exp:cSelCta%) AND CT1.%notDel%
			AND CT2.CT2_MOEDLC = (%exp:mv_par03%) AND CT2.CT2_VALOR <> 0
			ORDER BY CT2_DATA, CT1_CONTA, A2_CGC

		EndSql

	Endif

	DBSelectArea(cAliasqry)
	DBGOTOP()

	oREPORT:SETMETER(RECCOUNT())
	nSaldoFin := 0

	If cConta1 $ '16;41' .And. (cAliasqry)->(!Eof())
		nTotQuebra := 0
		cQuebra := (cAliasqry)->(CT1_CONTA)
	EndIf

	If cConta1 == "19"
		SF2->(DbSetOrder(8))
	EndIf

	DO WHILE (cAliasqry)->(!Eof())
	 	nReg++
		IF oREPORT:CANCEL()
			EXIT
		ENDIF

		oSECTION1:INIT()

		If cConta1 == "40"
			nValor := (cAliasqry)->CQ1_CREDIT - (cAliasqry)->CQ1_DEBITO
			oSection1:Cell("CCODIGO" ):SetBlock( { || (cAliasqry)->CQ1_CONTA } )
			oSection1:Cell("CDESCRI" ):SetBlock( { || (cAliasqry)->CT1_DESC01  } )
			oSection1:Cell("NVALOR"  ):SetBlock( { || nValor } )

			nSaldoFin += nValor

		ElseIf cConta1 == "41"
			If Substr((cAliasqry)->CT2_CREDIT,1,2)=cConta1
				nValor=(cAliasqry)->CT2_VALOR*(-1)
			Else
				nValor=(cAliasqry)->CT2_VALOR
			Endif

			oSection1:Cell("CCODIGO" ):SetBlock( { || PadC( (cAliasqry)->CT1_CONTA,  10 ) } )
			oSection1:Cell("CDESCRI" ):SetBlock( { || PadR( (cAliasqry)->CT1_DESC01, 40 ) } )
			oSection1:Cell("CCODIGO2" ):SetBlock( { || (cAliasqry)->RA_MAT } )
			oSection1:Cell("CDESCRI2" ):SetBlock( { || (cAliasqry)->RA_NOME  } )

			If cCamDoc == "%RA_TPDOCTO%"
				cTipoDoc := (cAliasqry)->RA_TPDOCTO
			Else
				cTipoDoc := (cAliasqry)->RA_TPCIC
			EndIf

			oSection1:Cell("CTIPO" ):SetBlock( { || cTipoDoc  } )

			If cCampo == "%RA_RG%"
				cNoDoc := (cAliasqry)->RA_RG
			Else
				cNoDoc := (cAliasqry)->RA_CIC
			EndIf

			oSection1:Cell("CRG" ):SetBlock( { || cNoDoc } )
			oSection1:Cell("NVALOR"  ):SetBlock( { || nValor } )
			cCuenta := Trim ((cAliasqry)->CT2_NODIA)
			nPos := AScan(aCliCT2, {|y| AllTrim(y[1]) == cCuenta})

			If nPos == 0	//	1					2		3		4		5					6					7						8
				Aadd(aCliCT2,{cCuenta,(cAliasqry)->RA_MAT,cTipoDoc,cNoDoc,nValor,(cAliasqry)->RA_NOME,(cAliasqry)->CT1_CONTA,(cAliasqry)->CT2_LINHA})
			Else
				aCliCT2[nPos][5] := aCliCT2[nPos][5] + nValor
			EndIf

			nSaldoFin += nValor

		Elseif cConta1 == "49"
			If Substr((cAliasqry)->CT2_CREDIT,1,2)=cConta1
				nValor=(cAliasqry)->CT2_VALOR*(-1)
			Else
				nValor=(cAliasqry)->CT2_VALOR
			Endif

			oSection1:Cell("CDESCRI" )	:SetBlock( { || (cAliasqry)->CT1_DESC01 } )
			oSection1:Cell("CNUM" )		:SetBlock( { || (cAliasqry)->E2_NUM } )
			oSection1:Cell("NVALOR"  )	:SetBlock( { || nValor } )

			nSaldoFin += nValor

		Else
			If Substr((cAliasqry)->CT2_DEBITO,1,2)=cConta1
				nValor=(cAliasqry)->CT2_VALOR
			Else
				nValor=(cAliasqry)->CT2_VALOR*(-1)
			Endif

			oSection1:Cell("CTIPO"     ):SetBlock( { || (cAliasqry)->A1_TIPDOC } )

			If AllTrim((cAliasqry)->A1_TIPDOC) != ''
			   	cTipoDoc := (cAliasqry)->A1_TIPDOC
			EndIf

			If (cConta1 $ "12;14;16;19" .AND. rtrim((cAliasqry)->A1_PFISICA) == "" .AND. rtrim((cAliasqry)->A1_CGC) == "")
				_cQuery := "SELECT A1_NOME,A1_CGC,A1_PFISICA "
				_cQuery +=  " FROM "+ RetSQLName("SA1")
				_cQuery +=  " WHERE A1_FILIAL = '"+xFilial("SA1")+"' AND"

				If RTRIM((cAliasqry)->CT2_EC05DB)!= ""
					_cQuery +=  " ((A1_CGC ='"+(cAliasqry)->CT2_EC05DB +"' AND A1_PFISICA = '') OR "
					_cQuery +=  " (A1_PFISICA ='"+(cAliasqry)->CT2_EC05DB+"' AND A1_CGC = '')) AND "
				Else
					_cQuery +=  " ((A1_CGC ='"+(cAliasqry)->CT2_EC05CR +"' AND A1_PFISICA = '') OR "
					_cQuery +=  " (A1_PFISICA ='"+(cAliasqry)->CT2_EC05CR+"' AND A1_CGC = '')) AND "
				EndIF

				_cQuery += " D_E_L_E_T_  =  ' ' "
				dbUseArea( .T. , "TOPCONN" , TcGenQry(,,_cQuery) , cAliasCgc , .T. , .T. )
				_cCgcFisica := "Sin Registro"
				_cNomeCli   := "Sin Registro "

				If ((cAliasCgc)->(!eof()))
					_cCgcFisica :=  IIF (rtrim((cAliasCgc)->A1_CGC)!="",(cAliasCgc)->A1_CGC,(cAliasCgc)->A1_PFISICA)
					_cNomeCli   := (cAliasCgc)->A1_NOME
					If AllTrim((cAliasqry)->A1_TIPDOC) == '' .And. AllTrim((cAliasCgc)->A1_CGC) != ''
						cTipoDoc := '6'
					Else
						cTipoDoc := '0'
					EndIf
				Else
				     cTipoDoc := '0'
				EndIF

				(cAliasCgc)->(DbCloseArea())

			Else
				If AllTrim((cAliasqry)->A1_TIPDOC) == ''
					cTipoDoc := '0'
				EndIf
				_cCgcFisica :=  IIf ( (cAliasqry)->A1_TIPDOC == '01',(cAliasqry)->A1_PFISICA,(cAliasqry)->A1_CGC)
				_cNomeCli   := (cAliasqry)->A1_NOME

			EndIf

			If cConta1 == '16'
				nTotQuebra += nValor
				oSection1:Cell("CNUMERO"   ):SetBlock( { || _cCgcFisica })
			Else
				oSection1:Cell("CNUMERO"   ):SetBlock( { || _cCgcFisica })
			EndIf

			oSection1:Cell("CNOME"	   ):SetBlock( { || _cNomeCli} )
			oSection1:Cell("NVALOR"    ):SetBlock( { || nValor } )
			oSection1:Cell("DTPGTO"    ):SetBlock( { || STOD((cAliasqry)->E1_EMISSAO) } )
			cCuenta := Trim ((cAliasqry)->CT2_NODIA)

			If cConta1 == "19"
				If SF2->(msSeek(cFilSF2 + cCuenta ))
					cTpDoc  := SF2 -> F2_TPDOC
					cSerie	:= SF2 -> (IIf(lSerie2 .And. !Empty(F2_SERIE2), F2_SERIE2, F2_SERIE))
					cDoc	:= SF2 -> F2_DOC
				Else
					cTpDoc := cSerie := cDoc := ""
				Endif
				nPos := AScan(aCliCT2, {|y| AllTrim(y[9]) == cSerie .and. AllTrim(y[10]) == cDoc})
			Else
				nPos := AScan(aCliCT2, {|y| AllTrim(y[1]) == cCuenta})
			EndIf

			If nPos == 0
				If cConta1 $ "12;16;19"
					cLinha := (cAliasqry)->CT2_LINHA
				EndIf	//		1		2			3		4						5		6		7						8		9		10	11
				Aadd(aCliCT2,{cCuenta,_cCgcFisica,_cNomeCli,(cAliasqry)->E1_EMISSAO,nValor,cTipoDoc,(cAliasqry)->A1_PFISICA,cTpDoc,cSerie,cDoc,cLinha})
			Else
				aCliCT2[nPos][5] := aCliCT2[nPos][5] + nValor
			EndIf

			nSaldoFin += nValor
		EndIf

		IF cConta1 == "19"
 			oSection1:Cell("CDOCUM"    ):SetBlock( { || (cAliasqry)->E1_NUM  } )
		ENDIF

		oSECTION1:PRINTLINE()

		DBSELECTAREA(cAliasqry)
		DBSKIP()

		If cConta1 $ '16;41' .And. ( cQuebra != (cAliasqry)->CT1_CONTA .OR. (cAliasqry)->(Eof()) )
			U_CTB461Tot({{"TOTVAL",nTotQuebra}},"",cConta1)
			oSection1:SetCellBorder(1)
			cQuebra := (cAliasqry)->(CT1_CONTA)
			nTotQuebra := 0
		EndIf

		oREPORT:INCMETER()
	ENDDO

	If nReg == 0
		oReport:PrintText(" ")
		oReport:PrintText(" ")
		oReport:PrintText(STR0057)
	Else
		U_CTB461Tot({{"TOTVAL",nSaldoFin}})
		oReport:EndPage()
		oReport:SetPageNumber(1)
	Endif

Next nK

DBSelectArea(cAliasqry)
DBGOTOP()

If MV_PAR05 == 2
	IF MSGYESNO(STR0065,Capital(STR0013))
	   Processa({|| GerArq(AllTrim(MV_PAR06),cAliasqry,aCliCT2)},,STR0066) //Archivo generado correctamente
	Endif
EndIf

dbCloseArea()
cFilAnt := cFilOld
RestArea(aAreaSM0)
RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR461DefบAutor  ณMarcello            บFecha ณ  05/03/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณInicia o relatorio conforme especificacao                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTB - Inventarios e balancos - Peru                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CTB461Def(cReport,cTitulo,cPerg,cDesc,cAcao)
Local nX	:= 0
Local nY	:= 0

Default cReport	:= ""
Default cTitulo	:= ""
Default cPerg	:= ""
Default cDesc	:= ""
Default cAcao	:= ""

If Type("aRelatorio") <> "A"
	aRelatorio := {}
Endif

oReport	:= TReport():New(cReport,cTitulo,cPerg,,cDesc)
oReport:SetTotalInLine(.F.)
oReport:EndPage(.T.)
oReport:SetPortrait(.T.)
oReport:SetEdit(.T.)
oReport:OnPageBreak({|| U_CTB461Cab()})
oReport:HideFooter()
oReport:SetEdit(.F.)                   // Nใo permite personilizar o relat๓rio, desabilitando o botใo <Personalizar>

If !Empty(cAcao)
	oReport:SetAction(&cAcao.)
Endif

For nX := 2 To Len(aRelatorio)
	aRelatorio[nX,1] := TRSection():New( oReport,cTitulo,,,.F.,.F.,,,,,,,,,,.F./*AutoAjuste*/,)
	aRelatorio[nX,1]:SetHeaderBreak(.F.)
	aRelatorio[nX,1]:SetHeaderSection(.F.)
	aRelatorio[nX,1]:SetLinesBefore(0)
	For nY := 2 To Len(aRelatorio[nX])
		TRCell():New(aRelatorio[nX,1],aRelatorio[nX,nY,1],,,aRelatorio[nX,nY,2]/*Picture*/,,/*lPixel*/,If(!Empty(aRelatorio[nX,nY,4]),aRelatorio[nX,nY,4],Nil)/*CodeBlock*/,aRelatorio[nX,nY,3])  //"TIPO"
	Next
Next
Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR461CABบAutor  ณMarcello            บFecha ณ  05/03/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime o cabecalho padrao para os livros de inventario e   บฑฑ
ฑฑบ          ณbalancos                                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTB - Inventarios e balancos - Peru                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CTB461Cab()
Local nX	:= 0

If Type("aRelatorio") <> "A"
	aRelatorio := {}
Endif
For nX := 4 To Len(aRelatorio)
	aRelatorio[nX,1]:Init()
	aRelatorio[nX,1]:PrintLine()
Next
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR461DimบAutor  ณMarcello            บFecha ณ  05/03/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณDefine o tamanho das celulas para impressao do relatorio    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTB - Inventarios e balancos - Peru                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CTB461Dim(oReport)
Local nAreaImp	:= 0
Local nX		:= 0
Local nY		:= 0

If Type("aRelatorio") <> "A"
	aRelatorio := {}
Endif

nAreaImp := oReport:GetWidth() / oReport:GetFontSize()[2]

For nX := 2 To Len(aRelatorio)
	For nY := 1 To (Len(aRelatorio[nX]) - 1)
		aRelatorio[nX,1]:Cell(nY):SetSize(nAreaImp * aRelatorio[1,nY])
		cBorda := aRelatorio[nX,nY+1,5]
		If "1" $ cBorda
			aRelatorio[nX,1]:Cell(nY):SetBorder("LEFT")
		Endif
		If "2" $ cBorda
			aRelatorio[nX,1]:Cell(nY):SetBorder("TOP")
		Endif
		If "3" $ cBorda
			aRelatorio[nX,1]:Cell(nY):SetBorder("RIGHT")
		Endif
		If "4" $ cBorda
			aRelatorio[nX,1]:Cell(nY):SetBorder("BOTTOM")
		Endif
	Next
Next
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR461TotบAutor  ณMarcello            บFecha ณ  05/03/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime a sessao de total do relatorio                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTB - Inventarios e balancos - Peru                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CTB461Tot(aValores, cTitulo,cConta)
Local nX	:= 0

Default aValores	:= {}
Default cTitulo		:= STR0030

If Type("aRelatorio") <> "A"
	aRelatorio := {}
Endif

If cTitulo != STR0030
	If cConta $  '16|42'
		aRelatorio[3,1]:Cell("TOTFIL3"):SetValue(cTitulo)
	ElseIf cConta == '41'
		aRelatorio[3,1]:Cell("TOTFIL6"):SetValue(cTitulo)
	ElseIf cConta == '46'
		aRelatorio[3,1]:Cell("TOTFIL5"):SetValue(cTitulo)
	EndIf
EndIf

If !Empty(aValores)
	aRelatorio[3,1]:Init()
	For nX := 1 To Len(aValores)
		aRelatorio[3,1]:Cell(aValores[nX,1]):SetValue(aValores[nX,2])
	Next nX
	aRelatorio[3,1]:PrintLine()
Endif

If cTitulo != STR0030
	If cConta $  '16|42'
		aRelatorio[3,1]:Cell("TOTFIL3"):SetValue(STR0040+ " " +STR0030)
	ElseIf cConta == '41'
		aRelatorio[3,1]:Cell("TOTFIL6"):SetValue(STR0030)
	ElseIf cConta == '46'
		aRelatorio[3,1]:Cell("TOTFIL5"):SetValue(STR0030)
	EndIf
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTB461CabLบAutor  ณMarcello            บFecha ณ  05/06/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime o cabecalho padrao para os livros                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTB - Inventarios e balancos - Peru                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CTB461CabL(oReport,titulo,dDataIni,dDataFim,lFilial)
Local aCabec	:= {}
Local cChar		:= chr(160)  // caracter dummy para alinhamento do cabe็alho
Local nAno		:= YEAR(dDataIni)
Local cConta	:= Alltrim(CT1->CT1_CONTA)

Default titulo		:= ""
Default dDataIni	:= dDataBase
Default dDataFim	:= dDataBase
Default lFilial		:= .F.

RptFolha := GetNewPar( "MV_CTBPAG" , RptFolha )

Aadd(aCabec,"__LOGOEMP__")
Aadd(aCabec,cChar)

If cConta = '10'
	Aadd(aCabec,STR0064 + " 3.2: " + Alltrim(STR0013) + ":" + cChar + AllTrim(titulo))
ElseIf cConta = '12'
	Aadd(aCabec,STR0064 + " 3.3: " + Alltrim(STR0013) + ":" + cChar + AllTrim(titulo))
ElseIf cConta = '14'
	Aadd(aCabec,STR0064 + " 3.4: " + Alltrim(STR0013) + ":" + cChar + AllTrim(titulo))
ElseIf cConta = '16'
	Aadd(aCabec,STR0064 + " 3.5: " + Alltrim(STR0013) + ":" + cChar + AllTrim(titulo))
ElseIf cConta = '19'
	Aadd(aCabec,STR0064 + " 3.6: " + Alltrim(STR0013) + ":" + cChar + AllTrim(titulo))
ElseIf cConta = '41'
	Aadd(aCabec,STR0064 + " 3.11: " + Alltrim(STR0013) + ":" + cChar + AllTrim(titulo))
ElseIf cConta = '42'
	Aadd(aCabec,STR0064 + " 3.12: " + Alltrim(STR0013) + ":" + cChar + AllTrim(titulo))
ElseIf cConta = '46'
	Aadd(aCabec,STR0064 + " 3.13: " + Alltrim(STR0013) + ":" + cChar + AllTrim(titulo))
ElseIf cConta = '47'
	Aadd(aCabec,STR0064 + " 3.14: " + Alltrim(STR0013) + ":" + cChar + AllTrim(titulo))
ElseIf cConta = '49'
	Aadd(aCabec,STR0064 + " 3.15: " + Alltrim(STR0013) + ":" + cChar + AllTrim(titulo))
Else
	Aadd(aCabec," " + Alltrim(STR0013) + ":" + cChar + AllTrim(titulo))
EndIf

Aadd(aCabec," Ejercicio:" + cChar + Alltrim(STR(nAno)))
Aadd(aCabec, STR0050 + cChar + Alltrim(SM0->M0_CGC))
Aadd(aCabec, STR0058 + cChar + AllTrim( SM0->M0_NOMECOM ))
If lFilial
	Aadd(aCabec,AllTrim(OemToAnsi(STR0007)) + cChar + cFilAnt)
Endif
Aadd(aCabec,Alltrim(RptFolha) + cChar + AllTrim(Transform(oReport:Page(),'999999')))
Return(Aclone(aCabec))

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTB461PIC บAutor  ณMicrosiga           บFecha ณ  04/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Ctb461Pic(nDecimais)
Local nTamPic		:= 0
Local nGrpMil		:= 0
Local nPos			:= 0
Local cPic			:= ""

Default nDecimais	:= 0
Default aTamVal		:= {GetSX3Cache("CT2_VALOR","X3_TAMANHO"),GetSX3Cache("CT2_VALOR","X3_DECIMAL")}

nTamPic := aTamVal[1]

If aTamVal[2] <> 0
	nTamPic -= (aTamVal[2] + 1)
Endif

nTamPic += 4
nGrpMil := nTamPic / 3
nTamPic += NoRound(nGrpMil,0)

If (nGrpMil - NoRound(nGrpMil,0)) == 0
   nTamPic--
Endif

If nDecimais > 0
	nTamPic += (nDecimais + 1)
Endif

cPic := TM(0,nTamPic,nDecimais)
nPos := At("9",cPic)
cPic := AllTrim(Substr(cPic,1,nPos-1)) + ") " + Alltrim(Substr(cPic,nPos))
Return(cPic)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณ Funcao     ณ GerArq   ณ Autor ณ                     ณ Data ณ 10.05.2016 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Descricao  ณ 3.3, 3.4, 3.5, 3.6, 3.11 LIBRO DE INVENTARIOS Y BALANCES   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Parametros ณ cDir    - Diretorio de criacao do arquivo.                 ณฑฑ
ฑฑณ            ณ cArq    - Nome do arquivo com extensao do arquivo.         ณฑฑ
ฑฑณ            ณ aCliCT2 - Nombre del Arreglo que contiene info del Infome. ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Retorno    ณ Nulo                                                       ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso        ณ Fiscal Peru                  - Arquivo Magnetico           ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function GerArq(cDir,cAliasqry,aCliCT2)

Local nHdl		:= 0
Local cLin		:= ""
Local cSep		:= "|"
Local nCont		:= 0
Local cArq		:= ""
Local nT1		:= 0
Local nMes		:= Month(MV_PAR02)
Local nReg		:= 0
Local cDateFmt	:= SET(_SET_DATEFORMAT)
Local cSerieNf	:= ""
Local cSerie	:= ""
Local cCUO		:= ""
Local cLinha	:= ""
Local nLinha	:= 0
Local nLenLinha	:= GetSX3Cache("CT2_LINHA","X3_TAMANHO")

FOR nCont:=LEN(ALLTRIM(cDir)) TO 1 STEP -1
	IF SUBSTR(cDir,nCont,1)=='\'
		cDir:=Substr(cDir,1,nCont)
		EXIT
	ENDIF
NEXT

DBSelectArea(cAliasqry)
DBGOTOP()

cArq += "LE"                                  // Fixo  'LE'
cArq +=  AllTrim(SM0->M0_CGC)                 // Ruc
cArq +=  AllTrim(Str(Year(MV_PAR02)))         // Ano
cArq +=  AllTrim(Strzero(Month(MV_PAR02),2))  // Mes
cArq +=  AllTrim(Strzero(Day(MV_PAR02),2))    // Dia
If cConta1 == "14"
	cArq += "030400" 						  // Fixo '030400'
ElseIf 	cConta1 == "16" .Or. cConta1 == "17"
	cArq += "030500" 	                      // Fixo '030500'
ElseIf 	cConta1 == "19"
	cArq += "030600"                          // Fixo '030600'
ElseIf cConta1 == "41"
	cArq += "031100"                          // Fixo '031100'
ElseIf cConta1 == "12"	.Or. cConta1 == "13"
	cArq += "030300"                          // conta12  Fixo '030300'
EndIf
//C๓digo de Oportunidad
If nMes == 12
	cArq += "01"
ElseIf nMes == 1
	cArq += "02"
ElseIf nMes == 6
	cArq += "04"
Else
	cArq += "07"
EndIf
cArq += "1"
cArq += "1"
cArq += "1"
cArq += "1"
cArq += ".TXT" // Extensao

nHdl := fCreate(cDir+cArq)

If nHdl <= 0
	ApMsgStop(STR0067)

Else
	SET(_SET_DATEFORMAT, "DD/MM/YYYY")

	If cConta1 == "12" .or. cConta1 == "16" .or. cConta1 == "19" .or. cConta1 == "14" .or. cConta1 == "41"
		For nReg := 1 to Len(aCliCT2)
			cLin := ""

			//01 - Periodo
			cLin += SubStr(DTOS(mv_par02),1,8)
			cLin += cSep

			//02 - C๓digo ฺnico de la Operaci๓n (CUO), que es la llave ๚nica o clave ๚nica o clave primaria del software contable que identifica de
			//     manera unํvoca el asiento contable. Debe ser el mismo consignado en el Libro Diario.
			cLin += AllTrim(aCliCT2[nReg][1])
			cLin += cSep

			//03 - N๚mero correlativo del asiento contable identificado en el campo 2.
			If cConta1 $ "12;16;19"
				cLinha := aCliCT2[nReg][11]
			ElseIf cConta1 == "41"
				cLinha := aCliCT2[nReg][8]
			Else	// 14
				cLinha := ""
			EndIf

			If Empty(cLinha)
				If cCUO <> aCliCT2[nReg][1]
					nLinha := 0
				EndIf
				cLinha := Strzero( ++nLinha , nLenLinha )
			EndIf

			cCUO := aCliCT2[nReg][1]

			cLin += "M" + cLinha
			cLin += cSep

			If cConta1 == "41"
				//04 - C๓digo de la cuenta contable desagregado en subcuentas al nivel mแximo de dํgitos utilizado, seg๚n la estructura 5.3
				cLin += AllTrim(aCliCT2[nReg][7])
			Else
				//04 - Tipo de Documento de Identidad del cliente
				cLin += Right(AllTrim(aCliCT2[nReg][6]),1)
			EndIf
			cLin += cSep

			If cConta1 == "41"
				//05 - Tipo de Documento de Identidad del trabajador
				cLin += Right(AllTrim(aCliCT2[nReg][3]),1)
			Else
				//05 - N๚mero de Documento de Identidad del cliente
				If AllTrim(aCliCT2[nReg][2])!=""
					cLin += StrTran(AllTrim(aCliCT2[nReg][2])," ", "")
				Else
					cLin += AllTrim(aCliCT2[nReg][7])
				EndIf
			EndIf
			cLin += cSep

			If cConta1 == "41"
				//06 - N๚mero de Documento de Identidad del trabajador
				cLin += AllTrim(aCliCT2[nReg][4])
			Else
				//06 - Apellidos y Nombres, Denominaci๓n o Raz๓n Social del cliente
				cLin += AllTrim(aCliCT2[nReg][3])
			EndIf
			cLin += cSep

			If cConta1 =="19"
				//07 - Tipo de Comprobante de Pago de la cuenta por cobrar
				If AllTrim(aCliCT2[nReg][8]) != ""
					cLin += AllTrim(aCliCT2[nReg][8])
				Else
					cLin += "00"
				EndIf
			ElseIf cConta1 =="41"
				//07 - C๓digo del trabajador
				cLin += AllTrim(aCliCT2[nReg][2])
			Else
				//07 - Fecha de emisi๓n o fecha de referencia del Comprobante de Pago
				cData := STOD(E1_EMISSAO)
				If Alltrim(E1_EMISSAO)==""
					cLin += DTOC(MV_PAR02)
				Else
					cLin  += SubStr(DTOC(cData),1,6)+SubStr(DTOS(cData),1,4)
				EndIf
			EndIf
			cLin += cSep

			If cConta1 == "19"
				//08 - Serie del comprobante de pago
				cSerie	 := AllTrim(aCliCT2[nReg][9])
				cSerieNf := SUBSTR(cSerie, 1,1)

				For nT1:= Len(cSerie)+1 to 4
					cSerieNf:=cSerieNf + "0"
				Next
				cLin += cSerieNf + IIf(Empty(cSerie),"",RIGHT(cSerie,LEN(cSerie)-1))
			ElseIf cConta1== "41"
				//08 - Apellidos y Nombres del trabajador
				cLin += AllTrim(aCliCT2[nReg][6])
			Else
				//08 - Monto de cada cuenta por cobrar del cliente
				If aCliCT2[nReg][5] <> 0
					cLin += Alltrim(STR(aCliCT2[nReg][5]))
				Else
					cLin += "0.00"
				EndIf
			EndIf
			cLin += cSep

			If cConta1 != "41"
				If cConta1 == "19"
					//09 - Numero de Comprobante de Pago
					cLin += AllTrim(aCliCT2[nReg][10])
				Else
					//09 - Indica el estado de la operaci๓n
					cLin += "1"
				EndIf
				cLin += cSep
			EndIf

			If cConta1 == "19"
				//10 - Numero de Comprobante de Pago
				cData := STOD(E1_EMISSAO)
				If Alltrim(E1_EMISSAO)==""
					cLin += DTOC(MV_PAR02)
				Else
					cLin  += SubStr(DTOC(cData),1,6)+SubStr(DTOS(cData),1,4)
				EndIf
				cLin += cSep
			EndIf

			If cConta1 == "19" .or. cConta1 == "41"
				// Monto de cada provisi๓n
				If aCliCT2[nReg][5] <> 0
					cLin += Alltrim(STR(aCliCT2[nReg][5]))
				Else
					cLin += "0.00"
				EndIf
				cLin += cSep
			EndIf

			If cConta1 == "19" .or. cConta1 == "41"
				// Indica el estado de la operaci๓n
				cLin += "1"
				cLin += cSep
			EndIf

			cLin += chr(13)+chr(10)
			fWrite(nHdl,cLin)
		Next nReg

	Else
		DO WHILE (cAliasqry)->(!Eof())
			cLin := ""
			//01 - Periodo
			cLin += SubStr(DTOS(mv_par02),1,8)
			cLin += cSep

			//02 - C๓digo ฺnico de la Operaci๓n (CUO), que es la llave ๚nica o clave ๚nica o clave primaria del software contable que identifica de
			//     manera unํvoca el asiento contable. Debe ser el mismo consignado en el Libro Diario.
			cLin += AllTrim(CT2_NODIA)
			cLin += cSep

			//03 - N๚mero correlativo del asiento contable identificado en el campo 2.
			cLin += "M" + Right(AllTrim(CT2_NODIA),9)
			cLin += cSep

			//04 - Tipo de Documento de Identidad del cliente
			cLin += Right(AllTrim(A1_TIPDOC),1)
			cLin += cSep

			//05 - N๚mero de Documento de Identidad del cliente
			cLin += AllTrim(A1_CGC)
			cLin += cSep

			//06 - Apellidos y Nombres, Denominaci๓n o Raz๓n Social del cliente
			cLin += AllTrim(A1_NOME)
			cLin += cSep

			//07 - Fecha de emisi๓n o fecha de referencia del Comprobante de Pago
			cData := ""
			cData := STOD(E1_EMISSAO)
			If Alltrim(E1_EMISSAO)==""
				cLin += DTOC(MV_PAR02)
			Else
				cLin  += SubStr(DTOC(cData),1,6)+SubStr(DTOS(cData),1,4)
			EndIf
			cLin += cSep

			//08 - Monto de cada cuenta por cobrar del cliente
			cLin += AllTrim(StrTran(Transform(CT2_VALOR,"@E 999999999.99"),",","."))
			cLin += cSep

			//09 - Indica el estado de la operaci๓n
			cLin += "1"
			cLin += cSep

			cLin += chr(13)+chr(10)
			fWrite(nHdl,cLin)
			dbSelectArea(cAliasqry)
			dbSkip()
		EndDo

	EndIf

	SET(_SET_DATEFORMAT,cDateFmt)
	fClose(nHdl)
	MsgAlert(STR0068,"")
EndIf

Return Nil
