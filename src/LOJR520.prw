/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "LOJR520.CH"
#INCLUDE "PROTHEUS.CH"

Static lCenVenda := SuperGetMv("MV_LJCNVDA",,.F.) //Indica a utilizacao do cenario de vendas

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ LOJR520  ³ Autor ³ Hanna Caroline        ³ Data ³ 26.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Lista de Precos                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ LOJR520     )                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGALOJA                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Lojr520()
Local oReport
Local aArea 	:= GetArea()
Local cPerg		:= "LJR520"

If lCenVenda
	cPerg := "LJR520A"
EndIf

If !FindFunction("TRepInUse") .OR. !TRepInUse()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Executa versao anterior do fonte³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	U_Lojr520R3()
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                         ³
	//³ mv_par01             // Produto de                           ³
	//³ mv_par02             // Produto ate   		                 ³
	//³ mv_par03             // Grupo De                             ³
	//³ mv_par04             // Grupo ate                            ³
	//³ mv_par05             // Mostra tabelas escolhidas (Ate 2)    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte(cPerg,.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := Ljr520RptDef()

	oReport:PrintDialog()
		
	EndIf	

RestArea( aArea )
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ DATA   ³ BOPS ³Prograd.³ALTERACAO                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³04.08.99³PROTH ³Julio W.³ Convers„o de Macros (&) para Protheus        ³±±
±±³06.06.05³082622³Cleber M³ Efetuado acerto na impressao das tabelas     ³±±
±±³        ³      ³        ³ de preco                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ LOJR520  ³ Autor ³ Wagner Xavier         ³ Data ³ 05.09.91 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Lista de Precos                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_LOJR520(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaLoja.                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LojR520R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cDesc1  := STR0001  // Este programa ira emitir a rela‡„o dos pre‡os
LOCAL cDesc2  := STR0002  // selecionados pelo usuario.
LOCAL cDesc3  := ""
LOCAL cString := "SB1"
// Codigo / Grupo / Alfabetica
LOCAL aOrd    := {STR0003,STR0004,STR0005 }

PRIVATE nomeprog:= "LOJR520"
PRIVATE wnrel
PRIVATE tamanho := Iif(cPaisLoc=="BRA","P","M")
PRIVATE titulo  := STR0006  // Lista de Precos
// Zebrado / Administracao
PRIVATE aReturn:= { STR0007 , 1, STR0008, 2, 2, 1, "",1 }
PRIVATE nLastKey := 0
PRIVATE cPerg  :="LJR520"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lCenVenda
	cPerg := "LJR520A"
EndIf

pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Produto de                           ³
//³ mv_par02             // Produto ate   		                 ³
//³ mv_par03             // Grupo De                             ³
//³ mv_par04             // Grupo ate                            ³
//³ mv_par05             // Mostra tabelas escolhidas (Ate 2)    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="LOJR520" 

wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

If nLastKey = 27
	Return
EndIf

SetDefault(aReturn,cString)

If  nLastKey = 27
	Return
EndIf

RptStatus({|lEnd| U_LJR520Imp(@lEnd,wnRel,cString)},Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ LJR520Imp³ Autor ³ Mario Angelo          ³ Data ³ 09.05.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Lista de Precos                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LjR520Imp(lEnd,wnRel,cString)
LOCAL cCondicao,cCampo
LOCAL CbTxt
LOCAL cbCont,cabec1,cabec2
LOCAL imprime := .T.
LOCAL nTipo:=0
LOCAL j,cSuf
LOCAL nColuna
LOCAL nMoeda  := 0
Local lImpPrc := .F.
Local nPreco  := 0

PRIVATE cPri,cSeg 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Imporessao do Cabecalho e Rodape   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := Space(10)
cbcont   := 00
li       := 80
m_pag    := 01
imprime  := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := STR0009   // TABELA DE PRECOS
cabec1 := STR0019
//        0        1         2         3         4         5         6         7         8         9
//        123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
// 		  CODIGO          DESCRICAO DO PRODUTO           GRUP UM
//        xxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xxxx xx 9,999,999.99 xxxxxxxxxxxxxxx 9,999,999.99
//        xxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xxxx xx 9,999,999.99 9,999,999.99
cabec2 := ""
cPri:=cSeg:=" "

If !lCenVenda
	For j := 1 To 2
		If Val(Substr(Str(mv_par05,2),j,1)) != 0
			cSuf  := "0"+Substr(Str(mv_par05,2),j,1)
			IIf(j == 1,cPri := Substr(cSuf,2,1),cSeg := Substr(cSuf,2,1))
			cabec1 += Space(2) + GetMv("MV_TABPR"+cSuf) + Space(13 - Len(GetMv("MV_TABPR"+cSuf)) )
	
		    // Acrescenta ao cabeçalho a palavra "MOEDA"...
		    If cPaisLoc != "BRA"
			    cabec1 += Space(1) + STR0012 + Space(15 - Len(STR0012) )   //"MOEDA"
			EndIf
		Else
			If Substr(Str(mv_par05,2),j,1) == "0"
				MsgAlert(STR0013)	 //"A tabela número '0', informada pelo usuário, é inválida. Digite um código de tabela válido e repita o processo."
				Return		
			EndIf
		EndIf
	Next j
	
	If cPaisLoc != "BRA" .And. (Empty(cPri) .And. !Empty(cSeg))
		cPri := cSeg
		cSeg := " "
	EndIf
Else
	cPri	:= Right(SuperGetMv("MV_TABPAD"),1)
	cSuf	:= "0"+cPri
	cabec1 	+= Space(2) + GetMv("MV_TABPR"+cSuf) + Space(13 - Len(GetMv("MV_TABPR"+cSuf)) )
EndIf  

nTipo:=GetMv("MV_NORM")
dbSelectArea( "SB1" )
IF aReturn[8] == 1
	dbSetOrder(1)
	dbSeek(cFilial+mv_par01,.T.)
	cCondicao := "!Eof() .And. b1_COD <= mv_par02"
	cCampo    := "B1_COD"
ElseIf aReturn[8] == 2
    dbSetOrder(4)
	dbSeek(cFilial+mv_par03,.T.)
	cCondicao := "!Eof() .And. b1_grupo <= mv_par04"
	cCampo    := "B1_GRUPO"
Else
	dbSetOrder(3)
	dbSeek(cFilial)
	cCondicao := "!Eof()"
	cCampo    := "B1_DESC"
End

SetRegua(Reccount( ))

While B1_FILIAL == cFilial .and. &cCondicao
    //Incrementa Regua
    IncRegua()
    
    IF  lEnd
		  @PROW()+1,001 PSay STR0011   // CANCELADO PELO OPERADOR
        Exit
    End

	IF B1_COD < mv_par01 .Or. B1_COD > mv_par02
		dbSkip( )
		Loop
	End

	IF B1_GRUPO < mv_par03 .Or. B1_GRUPO > mv_par04
		dbSkip( )
		Loop
	End
          
 	If !lCenVenda
		dbSelectArea( "SB0" )
		If !(	dbSeek( cFilial+ SB1->B1_COD ) )
			dbSelectArea( "SB1" )
			dbSkip( )
			Loop
		End
	EndIf

	IF li > 55
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	EndIf

	dbSelectArea( "SB1" )
    @li,00 PSay B1_COD
    @li,32 PSay SubStr(B1_DESC,1,30)
    @li,62 PSay B1_GRUPO
    @li,64 PSay B1_UM
	nColuna := 68
	
	If lCenVenda
		LjxeValPre(@nPreco, SB1->B1_COD, /*cCliente*/, /*cLoja*/)
	EndIf
			
	If cPri != " "              
		If lCenVenda
			@li,nColuna PSay nPreco Picture PesqPict("SB0","B0_PRV1",12)
		Else
			@li,nColuna PSay &('SB0->B0_PRV'+cPri) Picture PesqPict("SB0","B0_PRV1",12)
		EndIf	
		nColuna += 13
		lImpPrc := .T.
	EndIf

    If lImpPrc .And. cPaisLoc != "BRA" //Imprime a moeda correspondente do preco
    	If lCenVenda
    		nMoeda	:= 1
    	Else
            nMoeda  := Max(&('SB0->B0_MOEDA'+cPri),1)           
    	EndIf
        @li,nColuna PSay space(5) + GetMV('MV_MOEDA'+AllTrim(Str(nMoeda))) Picture "@!"
   		nColuna += 16
   		lImpPrc := .F.                                                      
	EndIf

	If !lCenVenda
		If cSeg != " "
			@li, nColuna PSay &('SB0->B0_PRV'+cSeg) Picture PesqPict("SB0","B0_PRV1",12)
			nColuna += 13
			lImpPrc := .T.
		End
	    If lImpPrc .And. cPaisLoc != "BRA" //Imprime a moeda correspondente do preco
			nMoeda  := Max(&('SB0->B0_MOEDA'+cSeg),1)
	       	@ li,nColuna PSay GetMV('MV_MOEDA'+AllTrim(Str(nMoeda))) Picture "@!"
			lImpPrc := .F.
	    EndIf
    EndIf

	li++
	dbSelectArea("SB1")
	dbSkip( )
End

IF li != 80
	Roda(cbCont,cbTxt,tamanho)
End

Set Device To Screen
dbSelectArea("SB1")
dbSetOrder(1)
dbSelectArea("SB0")
dbSetOrder(1)
Set Filter To

If aReturn[5] = 1
	Set Printer To 
	dbCommitAll()
	OurSpool(wnrel)
End

MS_FLUSH()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Ljr520RptDef³Autor  ³Hanna             ³ Data ³  26/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no re- º±±
±±º          ³latorio                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ LOJA520                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºData      ³Programador³ BOPS  ³ Descricao                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±                             
±±º09/10/06  ³Marcos     ³108460 ³ Alteracao para imprimir corretamente   º±±
±±º          ³           ³       ³ o cabecalho dos campos preco1 e preco2.º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Ljr520RptDef()
Local oReport										// Objeto do relatorio
Local oSection1										// Objeto da secao 1
Local aOrdem	:= {}								// Ordens disponiveis para escolha do usuario
Local cAlias1	:= GetNextAlias()					// Pega o proximo Alias Disponivel

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as ordens disponiveis para o usuario escolher³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Aadd( aOrdem, STR0015 ) // 'Filial + Codigo'
Aadd( aOrdem, STR0016 ) // 'Filial + Descricao + Codigo'
Aadd( aOrdem, STR0017 ) // 'Filial + Grupo + Codigo'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Gera a tela com os dados para a confirmação da geracao do relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// Lista de Precos
// Este programa ira emitir a relacao dos precos"|"selecionados pelo usuario."
oReport := TReport():New("LOJR520",STR0006,"LJR520",{|oReport| Ljr520PrtRpt(oReport, cAlias1 )},STR0001 + STR0002 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao1 do relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New(oReport,STR0018,{ "SB1", "SB0" }, aOrdem )	// Detalhes dos Produtos

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRCell():New ( oSection1,"B1_COD"		,"SB1" )
TRCell():New ( oSection1,"B1_DESC"		,"SB1" )
TRCell():New (oSection1, "B1_GRUPO"		,"SB1" )
TRCell():New (oSection1, "B1_UM"		,"SB1" )
TRCell():New (oSection1, "B0_PRV1"		,"SB0",,,,,{|| LJR520Pr( 1, cAlias1 ) })	// "Preço"     
TRCell():New (oSection1, "B0_PRV2"		,"SB0",,,,,{|| LJR520Pr( 2, cAlias1 ) })	// "Preço"

Return oReport
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Ljr520PrtRptºAutor  ³Hanna / FabioMr     º Data ³  17/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ LOJR520                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Ljr520PrtRpt( oReport, cAlias1 )
Local oSection1 := oReport:Section(1)				// Define a secao 1 do relatorio
Local cOrdem	:= ""								// Ordem escolhida pelo usuario
Local nIndice	:= 1								// Indice do SB1

If !lCenVenda
	oReport:Section(1):CELL("B0_PRV1"):SetTitle(STR0014 + Subs( Alltrim( STR( MV_PAR05 ) ),1,1))
	oReport:Section(1):CELL("B0_PRV2"):SetTitle(STR0014 + IIF( Len( Alltrim( STR( MV_PAR05 ) ) ) == 2, Subs( Alltrim( STR( MV_PAR05 ) ),2,1),"" ))
Else
	oReport:Section(1):CELL("B0_PRV1"):SetTitle(STR0014 + " " + AllTrim(SuperGetMv("MV_TABPAD")))
EndIf

DbSelectArea("SB1")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Relaciona a ordem escolhida pelo usuario, com a ordem no SIX³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If oSection1:GetOrder() == 1
	nIndice	:= 1
	cOrdem	:= "B1_FILIAL + B1_COD"
ElseIf oSection1:GetOrder() == 2
	nIndice := 3
	cOrdem	:= "B1_FILIAL + B1_DESC"
ElseIf oSection1:GetOrder() == 3
	nIndice := 4
	cOrdem	:= "B1_FILIAL + B1_GRUPO"
EndIf

SB1->( DbSetOrder( nIndice ) )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Desabilita este campo, caso soh tenha uma tabela informada no parametro³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lCenVenda .OR. Len( Alltrim( STR( MV_PAR05 ) ) ) == 1
	oSection1:Cell("B0_PRV2"):Disable()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Apresenta o cabecalho³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:SetHeaderSection(.T.)

#IFDEF TOP

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//³Exemplo Word, nao intervalos pre definidos (mais utilizado pelo RH - Ferias)     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("LJR520")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BeginSql alias cAlias1
		SELECT	B1_COD	, B1_DESC	, B1_GRUPO	, B1_UM		, 
				B0_PRV1	, B0_PRV2	, B0_PRV3	, B0_PRV4	, 
				B0_PRV5	, B0_PRV6	, B0_PRV7	, B0_PRV8	, 
				B0_PRV9
				
		FROM %table:SB1% SB1       
		INNER JOIN %table:SB0% SB0 ON B1_COD =	B0_COD
		WHERE	B1_COD		=	B0_COD			AND 
				B1_FILIAL	=	%xfilial:SB1%	AND		
				B1_COD		>=	%exp:mv_par01%	AND
				B1_COD		<=	%exp:mv_par02%	AND
				B1_GRUPO	>=	%exp:mv_par03%	AND
				B1_GRUPO	<=	%exp:mv_par04%	AND
				SB1.%notDel%					AND
				SB0.%notDel%
		ORDER BY %Order:SB1%
	EndSql
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Indica o fim da query, caso utilize range, deve-se informar como parametro ³
	//³{MV_?,MV_?} para que seja incluido no select automaticamente               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	END REPORT QUERY oSection1 //PARAM mv_par01,mv_par02
#ELSE

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("LJR520")

	cFiltro := "B1_FILIAL = '" + xFilial("SB1") + "'"
	cFiltro += " .AND. B1_COD	>= '" + MV_PAR01 + "' .AND. B1_COD		<= '" + MV_PAR02 + "'"
	cFiltro += " .AND. B1_GRUPO	>= '" + MV_PAR03 + "' .AND. B1_GRUPO	<= '" + MV_PAR04 + "'"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Efetua o filtro de acordo com a expressao e gera a indregua com a ordem escolhida pelo usuario ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:SetFilter( cFiltro, cOrdem )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Efetua a condicao do codeblock dentro do filtro jah efetuado ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TRPosition():New( oSection1,"SB0",1,'xFilial("SB0") + SB1->B1_COD' )
	oSection1:SetLineCondition( {|| !SB0->(EOF() ) } )
#ENDIF	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:Print()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LJR520Pr  ºAutor  ³Hanna Caroline      º Data ³  26/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna o valor que deve ser impresso da lista de preco     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³nVez = Se eh a primeira coluna ou a segunda                 º±±
±±º          ³cAlias1 = Alias caso esteja utilizando TOP                  º±±
±±º          ³Retorna o valor do preco da tabela                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function LJR520Pr( nVez, cAlias1 )
Local aAreaSB1	:= GetArea("SB1")			// Salva a area
Local nRet		:= 0						// Retorno

Default cAlias1	:= ""						// Alias do arquivo utilizado no TOP
Default nVez	:= 1						// Verifica se estou imprimindo qual campo

If !lCenVenda .AND. Alltrim( STR( MV_PAR05 ) ) == "0" 
    If cPaisLoc =="BRA"
		MsgAlert("A tabela de preço 0 é invalida, será substituida pela tabela 1")
    Else
		MsgAlert("La lista de precio 0 no es valida, se sustituira por la lista 1")    
	EndIf	
	MV_PAR05 := 1
EndIf	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define o nome do campo, para ser impresso de acordo com os parametros³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP
	cCampo	:= cAlias1 + "->B0_PRV"
#ELSE
	cCampo	:= "SB0->B0_PRV"
#ENDIF
If lCenVenda
	LjxeValPre(@nRet, (cAlias1)->B1_COD, /*cCliente*/, /*cLoja*/)
Else
	If Len( Alltrim( STR( MV_PAR05 ) ) ) == 2
		nRet	:= &( cCampo + Subs( Alltrim( STR( MV_PAR05 ) ),nVez,1 ) )
	Else
		nRet	:= &( cCampo + Alltrim( STR( MV_PAR05 ) ) )
	EndIf
EndIf

RestArea( aAreaSB1 )
Return( nRet ) 
