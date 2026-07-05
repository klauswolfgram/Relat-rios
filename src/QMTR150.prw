/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QMTR150.CH"
#INCLUDE "PROTHEUS.CH"


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QMTR150  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 08.04.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Estudo de R&R                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMTR150(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PPAP                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QMTR150(lBrow,cPecaAuto,cJPEG)

Local lPergunte := .F.
Local cFiltro	:= ""
Local aArea		:= GetArea()
Local cStartPath 	:= GetSrvProfString("Startpath","")
Local nReg:=0

Private oPrint
Private cPecaRev	:= ""
Private cPict		:= ""
Private nPosEns  	// Posicao do Ensaiador na aCols
Private nPosCic  	// Posicao do Ciclo na aCols
Private nPosPec  	// Posicao da Peca na aCols
Private nPosAtr  	// Posicao do Atributo na aCols
Private nPosali     // Posicao do Alias do Arquivo
Private nPosrec     // Posicao do Recno do registro
Private bCampo 		:= { |nField| Field(nField) }
Private aResult 	:= {}
Private aTabela 	:= {}
Private aFIM 		:= {} // Guarda resultados na array para impressao
Private cQM5Tmp		:= ""
Private aMger 		:= {}
Private aNMedp 		:= {}
Private aCols 		:= {}
Private aHeader 	:= {}
Private lExist 		:= .T.
Private lLand		:= .F.
Private lMenu		:= .F.
Private Inclui		:= .F.
Private cQM5ATP		:= ""  // Var private do QMTA150
Private aCont := {}
Private oMedi 
Private aTot	:= {}
Private aComb	:= {}
Private	aNew	:= {}
Private	aUseRef	:= {}
Private	aRef	:= {}
Private aSomRef	:= {}
Private nRefere := 0
Private nVlRef 	:= 0
Private nCodig	:= 0
Private nSomRef	:= 0
Private nRep1	:= 0
Private nRep2	:= 0
Private nRep3	:= 0
Private nRep4	:= 0
Private nReptot := 0
Private nRepRer := 0
Private aCoUser := {}
Private nCtUser	:= 0

If AllTrim(FunName()) <> AllTrim("QMTA150")
	ALTERA := .F.
EndIf

Default lBrow 		:= .F.
Default cPecaAuto	:= ""
Default cJPEG     := "" 
                                                          
If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01				// Peca       							³
//³ mv_par02				// Revisao        						³
//³ mv_par03				// Caracteristica              			³
//³ mv_par04				// Impressora / Tela          			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QMTA150"
		cPecaRev := Iif(!lBrow, M->QM4_PECA1 + M->QM4_REV + M->QM4_CARAC, QM4->QM4_PECA1 + QM4->QM4_REV + QM4->QM4_CARAC)
		lMenu := .F.
	Else
		lMenu := .T.

		lPergunte := Pergunte("PPR150",.T.)

		If lPergunte
			cPecaRev := mv_par01 + mv_par02	 + mv_par03
		Else
			Return Nil
		Endif
	Endif
Endif

DbSelectArea("QK1")
DbSetOrder(1)
DbSeek(xFilial()+SubStr(cPecaRev,1,42))

DbSelectArea("QK2")
DbSetOrder(2)
DbSeek(xFilial()+cPecaRev)

DbSelectArea("SA1")
DbSetOrder(1)
DbSeek(xFilial("SA1") + QK1->QK1_CODCLI + QK1->QK1_LOJCLI)

DbSelectArea("QM4")
DbSetOrder(3)
If DbSeek(xFilial("QM4")+cPecaRev)
	nreg:=recno()

	DbSelectArea("QM5")
	DbSetOrder(2)
	DbSeek(xFilial()+cPecaRev)

	If lMenu .or. lBrow .or. !Empty(cPecaAuto)
		RegToMemory("QM4")
	Endif

	cPict := QA_PICT("QM4_LIE",QM4->QM4_LIE)

	If (Alltrim(QM4->QM4_TPMSA) == "1" .OR. Alltrim(QM4->QM4_TPMSA) == "3") .and. QM4->QM4_TIPO == "A"
		a150TabEns()
		a150Monta()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Guarda posicao dos elementos nos acols 		³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		a150PosCol()
		
		If (Alltrim(M->QM4_TPMSA) == "1" .OR. Alltrim(M->QM4_TPMSA) == "3") .and. M->QM4_TIPO == "A"
			qmt150UseRef()
		Endif	
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Recupera medicoes cadastradas                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		a150Recup()
		a150Calculo(Nil,Nil,Nil,.T.)
		QMTR270(Iif(lPergunte,mv_par04,0),cPecaAuto)
	Else
		oPrint	:= TMSPrinter():New("R&R")

		If QM4->QM4_NPECAS <= 11
			oPrint:SetPortrait()
			lLand := .F.
		Else
			oPrint:SetLandscape()
			lLand := .T.
		Endif

		If Empty(cPecaAuto)
			MsgRun(STR0002,"",{|| CursorWait(), MontaRel(oPrint) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
		Else
			MontaRel(oPrint)
		Endif
	EndIF   
	DbSelectArea("QM4")
	Dbgoto(nreg)
	If (QM4->QM4_TIPO <> "A").and. (lPergunte .and. mv_par04 == 1 .or. !Empty(cPecaAuto))
		If !Empty(cJPEG) 
			If lLand
				oPrint:SaveAllAsJPEG(cStartPath+cJPEG,1120,855,140)
			Else
				oPrint:SaveAllAsJPEG(cStartPath+cJPEG,870,840,140)
			EndIf
		Else 
			oPrint:Print()
		EndIF
	Elseif QM4->QM4_TIPO <> "A"
		oPrint:Preview()  		// Visualiza antes de imprimir
	Endif
else
	msgalert(STR0045)//"Não há dados a serem visualizados"
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga arquivo temporario (se existir)                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
A150DelTmp()
A150DelATP()

If !lPergunte
	RestArea(aArea)
Endif

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MontaRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 08.04.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³R&R                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontaRel(ExpO1)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR150                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontaRel(oPrint)

Local i 	:= 1
Local x 	:= 0
Local lin 	:= 0
Local cFileLogo  := "LGRL"+SM0->M0_CODIGO+SM0->M0_CODFIL+".BMP" // Empresa+Filial

Private oFont16, oFont08, oFont10, oFont07, oFont06,oFont11,oFont71	
Private nLinMax 	:= Iif(lLand, 2200, 2810)
Private	TRB_TIPQM4 	:= M->QM4_TIPO
Private	TRB_INSTR	:= M->QM4_INSTR
Private	TRB_REVINS	:= M->QM4_REVINS
Private	TRB_TIPO	:= M->QM4_TIPO
Private	TRB_NENSR	:= M->QM4_NENSR
Private	TRB_NCICLO	:= M->QM4_NCICLO

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oFont16		:= TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
oFont08		:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
oFont09		:= TFont():New("Arial",09,09,,.F.,,,,.T.,.F.)
oFont10		:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFont07		:= TFont():New("Arial",07,07,,.T.,,,,.T.,.F.)
oFont71		:= TFont():New("Arial",07,07,,.F.,,,,.T.,.F.)
oFont06		:= TFont():New("Arial",06,06,,.F.,,,,.T.,.F.)
oFont11		:= TFont():New("Arial",10,10,,.T.,,,,.T.,.F.)

Cabecalho(oPrint,i)  			// Funcao que monta o cabecalho

nPosali	:= aScan(aHeader,{|x| AllTrim(x[2]) = "QM5_ALI_WT"	})
nPosRec := ASCAN(aHeader,{|x| alltrim(x[2]) = "QM5_REC_WT" })
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calcula R&R                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aFim := {}
R220CalRR()

nPosEns := aScan(aHeader,{|x| AllTrim(x[2]) = "QM5_ENSR"	})
nPosCic := aScan(aHeader,{|x| AllTrim(x[2]) = "QM5_CICLO"	})
nPosPec	:= aScan(aHeader,{|x| AllTrim(x[2]) = "QM5_PECA"	})
nPosAtr	:= aScan(aHeader,{|x| AllTrim(x[2]) = "QM5_ATRIB"	})

lin := Detail(oPrint,@i)  	// Funcao que monta os detalhes

If lin > nLinMax			// Espaco minimo para colocacao do rodape	
	i++
	oPrint:EndPage() 		// Finaliza a pagina
	Cabecalho(oPrint,i)		// Funcao que monta o cabecalho
	lin := 700
Endif

Foot(oPrint,i,@lin)			// Funcao que monta o rodape

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabecalho³ Autor ³ Robson Ramiro A. Olive³ Data ³ 08.04.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cabecalho do relatorio                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabecalho(ExpO1,ExpN1)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR150                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabecalho(oPrint,i)

Local cFileLogo  	:= "LGRL"+SM0->M0_CODIGO+SM0->M0_CODFIL+".BMP" // Empresa+Filial
Local cStartPath 	:= GetSrvProfString("Startpath","")
Local cTipo			:= ""

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,Iif(lLand,2800, 2100), cStartPath+"\Logo.bmp",237,58) 

oPrint:Say(075,Iif(lLand,1250,850),STR0003,oFont16 ) //"ESTUDO DE R&R"

//Box Cabecalho
oPrint:Box( 150, 30, 550, 2350 )

// Descricao do Cabecalho
// 1a Linha
oPrint:Say(160,0040,STR0004,oFont08 )  //"Cliente"
oPrint:Say(200,0040,SubsTr(SA1->A1_NOME,1,37),oFont07 )

oPrint:Say(160,1010,STR0005,oFont08 )  //"No. Peca (Cliente)"
oPrint:Say(200,1010,Subs(QK1->QK1_PCCLI,1,29),oFont07 )

oPrint:Say(160,1800,STR0006,oFont08 )  //"Revisao/Data Desenho"
oPrint:Say(200,1800,AllTrim(SubStr(QK1->QK1_REVDES,1,13))+Space(02)+DtoC(QK1->QK1_DTRDES),oFont07 )

oPrint:Say(115,2160,STR0007,oFont08 )  //"Pagina"
oPrint:Say(115,2300,StrZero(i,3),oFont07 )

// 2a Linha
oPrint:Say(240,0040,STR0008,oFont08 )  //"Fornecedor"
oPrint:Say(280,0040,SM0->M0_NOMECOM,oFont07 )

oPrint:Say(240,1010,STR0009,oFont08 )  //"No. da Peca (Fornecedor)"
oPrint:Say(280,1010,Subs(QK1->QK1_PECA,1,33),oFont07 )

oPrint:Say(240,1800,STR0010,oFont08 )  //"Revisao da Peca (Fornecedor)"
oPrint:Say(280,1800,QK1->QK1_REV,oFont07 )

oPrint:Say(240,2220,STR0016,oFont08 ) //"UM"
oPrint:Say(280,2220,QK2->QK2_UM,oFont07 )

// 3a Linha
oPrint:Say(320,0040,STR0012,oFont08 )  //"Nome da Peca"
oPrint:Say(360,0040,Subs(QK1->QK1_DESC,1,47),oFont07 )

oPrint:Say(320,1300,STR0027,oFont08 ) //"No. Ciclos"
oPrint:Say(360,1300,Str(QM4->QM4_NCICLO),oFont07 )


oPrint:Say(320,1595,STR0015,oFont08 ) //"Nominal"
oPrint:Say(360,1595,QK2->QK2_TOL,oFont07 )

oPrint:Say(320,2060,STR0011,oFont08 )  //"Data do Estudo"
oPrint:Say(360,2060,DtoC(QM4->QM4_DATA),oFont07 )

// 4a Linha                                              
oPrint:Say(400,0040,STR0017,oFont08 )  //"Carac. No."
oPrint:Say(440,0040,QK2->QK2_CODCAR,oFont07 )

oPrint:Say(400,0310,STR0018,oFont08 )  //"Caracteristica"
oPrint:Say(440,0310,Subs(QK2->QK2_DESC,1,40),oFont07 )

oPrint:Say(400,1300,STR0020,oFont08 ) //"No. Ensaiadores"
oPrint:Say(440,1300,Str(QM4->QM4_NENSR),oFont07 )

oPrint:Say(400,1595,STR0021,oFont08 ) //"Tipo de Ensaio"

Do Case
	Case QM4->QM4_TIPO == STR0022 //"E"
		cTipo := STR0023 //"Tolerancia de Especificacao"
	Case QM4->QM4_TIPO == "P"
		cTipo := STR0024 //"Tolerancia de Processo"
	Case QM4->QM4_TIPO == "C"
		cTipo := STR0025 //"Metodo Curto"
	Case QM4->QM4_TIPO == "A"
		cTipo := STR0026	 //"Atributo"
Endcase
	
oPrint:Say(440,1595,cTipo,oFont07 )

// Construcao das linhas do cabecalho
oPrint:Line( 230, 0030, 230, 2350 )   	// horizontal
oPrint:Line( 150, 1000, 310, 1000 )   	// vertical - Nro.Peca Cliente
oPrint:Line( 150, 1780, 310, 1780 )   	// vertical - Revisao Data
oPrint:Line( 390, 0300, 470, 0300 )   	// vertical
oPrint:Line( 310, 0030, 310, 2350 )   	// horizontal
oPrint:Line( 310, 1290, 545, 1290 )   	// vertical
oPrint:Line( 310, 1587, 545, 1587 )   	// vertical - Nominal
oPrint:Line( 230, 2208, 310, 2208 )   	// vertical - Data do Estudo
oPrint:Line( 310, 2053, 390, 2053 )   	// vertical - Unidade de Medida
oPrint:Line( 390, 0030, 390, 2350 )   	// horizontal
oPrint:Line( 390, 0300, 545, 0300 )   	// vertical - Caracteristica 310
oPrint:Line( 470, 0030, 470, 2350 )   	// horizontal - linha
oPrint:Line( 520, 0030, 780, 0030 )   	// vertical - inicio
oPrint:Line( 520, 2349.9, 780, 2349.9 )   	// vertical - final
oPrint:Line( 630, 0030, 630, 2350 )   	// horizontal - linha
oPrint:Line( 780, 0030, 780, 2350 )   	// horizontal - linha

//4a. Linha
oPrint:Say(480,0040,STR0013,oFont08 ) //"LIE"
oPrint:Say(520,0040,QM4->QM4_LIE,oFont07 )

oPrint:Say(480,310,STR0014,oFont08 ) //"LSE"
oPrint:Say(520,310,QM4->QM4_LSE,oFont07 )

oPrint:Say(480,1300,STR0019,oFont08 ) //"No. Pecas"
oPrint:Say(520,1300,Str(QM4->QM4_NPECAS),oFont07 )
oPrint:Say(480,1595,STR0044,oFont08 ) //"Instrumento"
oPrint:Say(520,1595,SubStr(QM4->QM4_INSTPP,1,27),oFont07 ) 

oPrint:Say(560,0040,STR0046,oFont08 ) //"Realizado por"
oPrint:Say(600,0040,QM4->QM4_REAPOR,oFont07 )

oPrint:Say(640,0040,STR0047,oFont08 ) //"Observacoes"
oPrint:Say(680,0040,SubStr(QM4->QM4_OBS,1,95),oFont07 )   
oPrint:Say(730,0060,SubStr(QM4->QM4_OBS,96,84),oFont07 )
Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Detail   ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 10.04.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Itens do relatorio                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Detail(ExpO1,ExpN1)                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR150                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Detail(oPrint,i)

Local lin 		:= 820
Local nLin1A	:= 810
Local nLin1B	:= 880
Local nLin2A	:= 820
Local nTotPecas	:= ( Len(aCols[1]) - 2 )
Local cFileLogo	:= "LGRL"+SM0->M0_CODIGO+SM0->M0_CODFIL+".BMP" // Empresa+Filial
Local nLimite 	:= IIf( nTotPecas > 17, 2, 1 )
Local nCodEns   := ""
Local cNomeEns  := ""

Local nCont1, x, nCoord, nFimBox, cEns, nX, nXBB, nI, nDe, nAte

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

For nI := 1 To nLimite
	
	If nI == 1
		lin		:= 820
		nLin1A	:= 810
		nLin1B	:= 880
		nLin2A	:= 820
		nCoord	:= 650
	Else
		lin		+= 100
		nLin1A	:= lin-10
		nLin1B	:= lin+60
		nLin2A	:= lin
		nCoord	:= 279
	Endif

	If nLimite == 1
		nDe		:= 4
		nAte	:= nTotPecas
	Else
		If nI == 1
			nDe		:= 4
			nAte	:= 17
		Else
			nDe		:= 18
			nAte	:= nTotPecas
		Endif
	Endif
	
	For x := nDe To nAte
		nCoord += 110
	Next x
		
	nFimBox := nCoord+110
		
	// Construcao da grade
	oPrint:Line(nLin1A, 0030, nLin1B, 0030)   	// vertical
	oPrint:Line(nLin1A, 0563, nLin1B, 0563)   	// vertical
	If nI == 1
		oPrint:Line(nLin1A, 0650, nLin1B, 0650)   	// vertical
	Endif
		
	// Descricao Detalhes
	oPrint:Say(nLin2A, 0070, STR0028, oFont07 )		//"Ensaiador"
	oPrint:Say(nLin2A, 0580, STR0029, oFont07 )		//"Ciclo"
	If nI == 1
		oPrint:Say(nLin2A, 0670, STR0030, oFont07 )		//"Peca  1"
	Endif
		
	If nI == 1
		nCoord := 650
	Else
		nCoord := 319
	Endif
		
	For x := nDe To nAte
		nCoord += 110
		oPrint:Line(nLin1A, nCoord, nLin1B, nCoord) 	  	// vertical
		oPrint:Say(nLin2A, nCoord+20, STR0031+Str(x-2,2), oFont07 )	//"Peca "
	Next x
		
	For nCont1 := 1 To Len(aCols)

		nCodEns  := SubStr( aCols[nCont1,nPosEns],1, TamSX3("QAA_MAT")[1])
		cNomeEns := SubStr( aCols[nCont1,nPosEns],TamSX3("QAA_MAT")[1]+4, TamSX3("QAA_NOME")[1])
        
		oPrint:Line( nLin1A, 0030, nLin1A, nFimBox+20 )  		// Horizontal
		oPrint:Line( nLin1A, nFimBox+20, nLin1B, nFimBox+20 )		// Vertical
			
		If lin > nLinMax
			i++
			oPrint:EndPage() 		// Finaliza a pagina
			Cabecalho(oPrint,@i)  	// Funcao que monta o cabecalho
			lin 	:= 820
			nLin1A	:= 810
			nLin1B	:= 880
			nLin2A	:= 820

			oPrint:Line( nLin1A, 0030, nLin1A, nFimBox )  		// Horizontal
			oPrint:Line( nLin1A, nFimBox, nLin1B, nFimBox )		// Vertical			
			oPrint:Line(nLin1A, 0030, nLin1B, 0030)   			// vertical
			oPrint:Line(nLin1A, 0360, nLin1B, 0360)   			// vertical
			If nI == 1
				oPrint:Line(nLin1A, 0450, nLin1B, 0450)   	// vertical
			Endif
				
			oPrint:Say(nLin2A, 0070, STR0028, oFont08 )		//"Ensaiador"
			oPrint:Say(nLin2A, 0370, STR0029, oFont08 )		//"Ciclo"
			If nI == 1
				oPrint:Say(nLin2A, 0490, STR0030, oFont08 )		//"Peca  1"
			Endif
				
			If nI == 1
				nCoord := 490
			Else
				nCoord := 319
			Endif
				
			For x := nDe To nAte
				nCoord += 171
				oPrint:Line(nLin1A, nCoord-40, nLin1B, nCoord-40 )   		// vertical
				oPrint:Say(nLin2A, nCoord, STR0031+Str(x-2,2), oFont08 )	//"Peca "
			Next x
		Endif
			
		lin += 80
			
		oPrint:Box( lin-20, 30, lin+60, nFimBox+20 )
			
		// Construcao da grade
		oPrint:Line( lin-20, 0563, lin+60, 0563 )   	// vertical
		oPrint:Line( lin-20, 0650, lin+60, 0650 )   	// vertical
			
		If cEns <> aCols[nCont1,nPosEns]
			oPrint:Say(lin,0040,nCodEns,oFont07) // Código Ensaiador
			oPrint:Say(lin+30,0040,cNomeEns,oFont07) // Nome Ensaiador
		Endif
			
		oPrint:Say(lin,0590,Alltrim(Str(aCols[nCont1,nPosCic])),oFont07) // Ciclo
			
		If nI == 1
			If M->QM4_TIPO <> "A"
				oPrint:Say(lin,0643,Transform(aCols[nCont1,nPosPec],cPict),oFont07) // Peca1
			Else
				If aCols[nCont1,nPosAtr] == "1"
					oPrint:Say(lin,0460,STR0032,oFont07) //"Passa"
				Else
					oPrint:Say(lin,0460,STR0033,oFont07) //"Nao Passa"
				Endif
			Endif
		Endif
					
		If nI == 1
			nCoord := 650
		Else
			nCoord := 319
		Endif

		If nLimite == 1
			nDe		:= (Iif(nPosPec == 0, nPosAtr, nPosPec) + 1)
			nAte	:= nTotPecas
		Else
			If nI == 1
				nDe		:= (Iif(nPosPec == 0, nPosAtr, nPosPec) + 1)
				nAte	:= 17
			Else
				nDe		:= 18
				nAte	:= nTotPecas
			Endif
		Endif

		For x := nDe To nAte
			nCoord += 110
				
			oPrint:Line( lin-20, nCoord, lin+60, nCoord )   	// vertical
				
			If M->QM4_TIPO <> "A"
				oPrint:Say(lin,nCoord+10,Transform(aCols[nCont1,x], cPict),oFont07)
			Else
				If aCols[nCont1,x] == "1"
					oPrint:Say(lin,nCoord-20,STR0032,oFont07) //"Passa"
				Else
					oPrint:Say(lin,nCoord-20,STR0033,oFont07) //"Nao Passa"
				Endif
			Endif

		Next x
			
		cEns := aCols[nCont1,nPosEns]
		
	Next nCont1

	If M->QM4_TIPO $ "EP"
		nCoord	:= 540
		lin		+= 80
	
		If lin > nLinMax
			i++
			oPrint:EndPage() 		// Finaliza a pagina
			Cabecalho(oPrint,@i)  	// Funcao que monta o cabecalho
			lin := 820
		Endif
			
		oPrint:Box( lin-20, 30, lin+60, nFimBox+20 )
		oPrint:Say( lin, 70, STR0034, oFont07 )		//"Medias da Peca"
		
		If nLimite == 1
			nDe		:= 1
			nAte	:= M->QM4_NPECAS
		Else
			If nI == 1
				nDe		:= 1
				nAte	:= 15
			Else
				nDe		:= 16
				nAte	:= M->QM4_NPECAS
			Endif
		Endif
	
		For x := nDe To nAte
			nCoord += 110
				
			oPrint:Line( lin-20, nCoord, lin+60, nCoord )   	// vertical
			oPrint:Say(lin,nCoord,Transform(aNMedp[x], cPict),oFont07)
		Next x
	Endif
	
Next nI

If M->QM4_TIPO $ "EP"

	lin += 80
		
	If lin > nLinMax
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabecalho(oPrint,@i)  	// Funcao que monta o cabecalho
		lin := 820
	Endif
		
	nXBB := 0
			
	For nX := 1 To M->QM4_NENSR
		nXBB += aMger[nX,2]
	Next nX
			
	nXBB := nXBB/M->QM4_NENSR
			
	oPrint:Line( lin-10, 095, lin-10, 120 ) 	// XBB
	oPrint:Line( lin-05, 095, lin-05, 120 )
	oPrint:Say(lin,100,"X:",oFont08 )
	oPrint:Say(lin,150,AllTrim(Transform(nXBB, cPict)),oFont08)

	oPrint:Say(lin,620,"Rp:", oFont08)
	oPrint:Say(lin,670,AllTrim(Transform(aFim[1,6], cPict)), oFont08) // nRp
	
	oPrint:Line( lin-10, 795, lin-10, 825 ) 	// RBB
	oPrint:Line( lin-05, 795, lin-05, 825 )
	oPrint:Say(lin,800,"R:", oFont08)
	oPrint:Say(lin,850,AllTrim(Transform(aFim[1,7], cPict)), oFont08) // RBB
		
	lin += 80

Elseif M->QM4_TIPO $ "C"

	lin += 80

	oPrint:Say(lin,070,STR0035,oFont08 ) //"Amplitude Media:"
	oPrint:Say(lin,400,AllTrim(Transform(aFim[1,2], qmt140pics("aFim[1,2]",M->QM4_LIE,.T.))),oFont08)

	lin += 80

Endif

Return lin

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Foot     ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 11.04.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Rodape do relatorio                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Foot(ExpO1,ExpN1, ExpN2)                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±³          ³ ExpN2 = Contador de linhas                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR150                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Foot(oPrint,i,lin)

Local cResu
Local nTole
Local nTipoRR
Local nTamFoot
Local cNome := ""
Local cCodMat := 0

If M->QM4_TIPO $ "AC"
	nTamFoot := 560
Elseif M->QM4_TIPO $ "E"
	nTamFoot := 640
Elseif M->QM4_TIPO $ "P"
	nTamFoot := 720
Endif

If lin > (nLinMax-nTamFoot) // Espaco minimo para colocacao do rodape
	i++
	oPrint:EndPage() 		// Finaliza a pagina
	Cabecalho(oPrint,i)		// Funcao que monta o cabecalho
	lin := 720
Endif

oPrint:EndPage()
Cabecalho(oPrint,i)		// Funcao que monta o cabecalho
lin := 720 
lin += 80
oPrint:Say(lin,Iif(lLand,1250,850),STR0036,oFont16 ) //"RESULTADOS DO ESTUDO"
lin += 160

If M->QM4_TIPO == "A" // Atributo
	
	oPrint:Box( lin-40, 30, lin+320, 2350 )

	oPrint:Say(lin,100,STR0037,oFont10) //"Resultado.:"
	oPrint:Say(lin,600,AllTrim(aFim[1,2]),oFont10)
	lin += 80
	
	oPrint:Say(lin,100,STR0038,oFont10) //"Total de Leitura.:"
	oPrint:Say(lin,600,AllTrim(Str(aFim[1,3]+aFim[1,4])),oFont10)
	lin += 80

	oPrint:Say(lin,100,STR0039,oFont10) //"Leitura(s) Capaz(es).:"
	oPrint:Say(lin,600,AllTrim(Str(aFim[1,3])),oFont10)
	lin += 80

	oPrint:Say(lin,100,STR0040,oFont10) //"Leitura(s) Nao Capaz(es).:"
	oPrint:Say(lin,600,AllTrim(Str(aFim[1,4])),oFont10)
	lin += 80

	lin += 300
Elseif M->QM4_TIPO == "C" // Metodo Curto

	oPrint:Box( lin-40, 30, lin+320, 2350 )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime G R&R                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	oPrint:Say(lin,100,STR0041,oFont10) //"G R&R.:"
	oPrint:Say(lin,650,AllTrim(Transform(aFim[1,3],qmt140pics("nAmp",QM4->QM4_LIE,.t.))),oFont10)
	lin += 80

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Tolerancia                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nTole := Abs(SuperVal(QM4->QM4_LSE) - SuperVal(QM4->QM4_LIE))

	oPrint:Say(lin,100,STR0042,oFont10) //"Variacao do Processo/Tolerancia.:"
	oPrint:Say(lin,650,AllTrim(Transform(nTole, cPict)),oFont10)
	lin += 80

	oPrint:Say(lin,100,"% R&R.:",oFont10)
	oPrint:Say(lin,650,AllTrim(Transform(aFim[1,4],qmt140pics("aFim[1,4]",QM4->QM4_LIE,.t.))),oFont10)
	lin += 80
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Resultado                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	If aFim[1,4]  <= GetMv("MV_QRRIAPR")  			// nprr
		cResu := AllTrim(GetMv("MV_QRRTAPR"))    	// "BOM"
	Elseif aFim[1,4] <= GetMv("MV_QRRICON")  		// nprr
		cResu := AllTrim(GetMv("MV_QRRTCON"))    	// "ACEITAVEL"
	Else
		cResu := AllTrim(GetMv("MV_QRRTREP"))    	// "INACEITAVEL"
	Endif

	oPrint:Say(lin,100,STR0037,oFont10) //"Resultado.:"
	oPrint:Say(lin,650,cResu,oFont10)

	lin+= 200
	
Elseif M->QM4_TIPO $ "EP" // metodo longo
	nTipoRR := Iif(M->QM4_TIPO == "E" ,1,Iif(M->QM4_TIPO == "P",2,3))

	If nTipoRR == 2      //tolerancia de processo
		oPrint:Box(  lin-40, 0030, lin+1560, 2350 )     //traca o box
		oPrint:Line( lin-40, 1100, lin+1400, 1100 )	// vertical
	Else                  //tolerancia de especificacao
		oPrint:Box(  lin-40, 0030, lin+1300, 2350 ) //traca o box
		oPrint:Line( lin-40, 1100, lin+1160, 1100 )	// traca a linha vertical central
	Endif
	
    If nTipoRR == 2
        oPrint:Say(lin,0100,STR0051,oFont11) //"ANALISE NA UNIDADE DE MEDICAO"
        oPrint:Say(lin,1200,STR0052,oFont11)  //"% SOBRE A VARIACAO TOTAL (VT)"
    Else 
    	oPrint:Say(lin,0100,STR0053,oFont11) //"ANALISE DA GRANDEZA DE MEDICAO"
        oPrint:Say(lin,1200,STR0054,oFont11) //"% VARIACAO DO PROCESSO"
    EndIf
    
    //Valores de K1
    lin+=60
   	oPrint:Line( lin-20, 30, lin-20, 2350 )	// horizontal
   	oPrint:Line( lin-20, 810, lin+105, 810 )	// vertical
   	oPrint:Line( lin-20, 955, lin+105, 955 )	// vertical
   	oPrint:Say(lin,815,STR0055,oFont06)   //"Med Repetidas"
	oPrint:Say(lin,980,"K1",oFont07)      //K1
	oPrint:Say(lin+40,850,"2",oFont71)
	oPrint:Say(lin+40,960,"0,8862",oFont71)
	oPrint:Say(lin+80,850,"3",oFont71)
	oPrint:Say(lin+80,960,"0,5908",oFont71)
	oPrint:Line(lin+25, 810, lin+25, 1100 )	// horizontal
	oPrint:Line(lin+65, 810, lin+65, 1100 )	// horizontal
	oPrint:Line(lin+105, 810, lin+105, 1100 )	// horizontal
	
	//Representacao de VE e %VE
	oPrint:Say(lin,0100,STR0056,oFont09)   //"Repetitividade - Variacao do Equipamento (VE)"
	lin+=60
   	oPrint:Say(lin,0100,STR0057,oFont10)       //"VE=RBB * K1"
	oPrint:Say(lin,1200,If(nTipoRR == 1, STR0058, STR0059),oFont10)  //"%VE = 100[VE/TE]"###"%VE = 100[VE/VT]"
	lin+=60
    oPrint:Say(lin,0100," = "+AllTrim(Transform(aFim[1,7],cPict))+" * "+AllTrim(Transform(aFim[1,15],cPict)),oFont10)// valores   VE
   	oPrint:Say(lin,1200,If(nTipoRR == 1, " =100*( "+AllTrim(Transform(aFim[1,16],cPict))+" / "+AllTrim(Transform(aFim[1,17],cPict))+" )",;
   	" =100*( "+AllTrim(Transform(aFim[1,16],cPict))+"/"+AllTrim(Transform(aFim[1,18],cPict))+")"),oFont10)//valor de %ve
   	lin+=60
    oPrint:Say(lin,0100,STR0060,oFont11)  //"VE.:"
	oPrint:Say(lin,0600,AllTrim(Transform(aFim[1,16],cPict)) ,oFont11) // nVe
    oPrint:Say(lin,1200,STR0061,oFont11)  //"%VE.:"
 	oPrint:Say(lin,1700,AllTrim(Transform(aFim[1,1], "9999.99 %")),oFont11) //npve	
	lin += 80
	oPrint:Line( lin-20, 30, lin-20, 2350 )	// horizontal
	
	//Valores de K2
	oPrint:Line( lin-20, 810, lin+105, 810 )	// vertical
   	oPrint:Line( lin-20, 955, lin+105, 955 )	// vertical
   	oPrint:Say(lin,825,STR0062,oFont06)  //"Avaliadores"
	oPrint:Say(lin,980,"K2",oFont07)      //K2
	oPrint:Say(lin+40,850,"2",oFont71)
	oPrint:Say(lin+40,960,"0,7071",oFont71)
	oPrint:Say(lin+80,850,"3",oFont71)
	oPrint:Say(lin+80,960,"0,5231",oFont71)
	oPrint:Line(lin+25, 810, lin+25, 1100 )	// horizontal
	oPrint:Line(lin+65, 810, lin+65, 1100 )	// horizontal
	oPrint:Line(lin+105, 810, lin+105, 1100 )	// horizontal
  	
	//Representacao de VA e %VA
	oPrint:Say(lin,0100,STR0063,oFont09) //"Reprodutibilidade - Variacao do Avaliador (VA)"
	lin+=60
	oPrint:Say(lin,0100,STR0064,oFont10)    //"VA = RaizQ((XBdif x K2)^2 - (VE^2/nr))"
	oPrint:Say(lin,1200,If(nTipoRR == 1,STR0065,STR0066),oFont10)  //"%VA = 100[VA\TE]"###"%VA = 100[VA\VT]"
	lin +=60
	oPrint:Say(lin,0100,STR0067+"("+Alltrim(Transform(aFim[1,10],cPict))+"*"+AllTrim(str(aFim[1,19]))+")^2-("+;
	AllTrim(Transform(aFim[1,16],cPict))+"^2/"+AllTrim(Str(QM4->QM4_NCICLO))+"*"+AllTrim(Str(QM4->QM4_NPECAS))+"))",oFont10) //" =RaizQ("     //colocar os valores 
   	oPrint:Say(lin,1200,If(nTipoRR == 1, " =100*( "+AllTrim(Transform(aFim[1,20],cPict))+" / "+AllTrim(Transform(aFim[1,17],cPict))+" )",;
   	" =100*( "+AllTrim(Transform(aFim[1,20],cPict))+"/"+AllTrim(Transform(aFim[1,18],cPict))+")"),oFont10)//valor de %va 
	lin +=60
	oPrint:Say(lin,0100,STR0068,oFont11)  //"VA"
	oPrint:Say(lin,0600,AllTrim(Transform(aFim[1,20], cPict)), oFont11)  	//nva
	oPrint:Say(lin,1200,STR0069,oFont11)  //"%VA.:"
	oPrint:Say(lin,1700,AllTrim(Transform(aFim[1,2], "9999.99 %")), oFont11) //npva
	lin += 80
	
	//Valores de K3
	oPrint:Line( lin-20, 810, lin+400, 810 )	// vertical
   	oPrint:Line( lin-20, 955, lin+400, 955 )	// vertical
   	oPrint:Say(lin,830,STR0070,oFont07)         //"Pecas"
	oPrint:Say(lin,980,"K3",oFont07)             //K3
	oPrint:Say(lin+55,850,"2",oFont71)
	oPrint:Say(lin+55,960,"0,7071",oFont71)
	oPrint:Say(lin+95,850,"3",oFont71)
	oPrint:Say(lin+95,960,"0,5231",oFont71)
	oPrint:Say(lin+135,850,"4",oFont71)
	oPrint:Say(lin+135,960,"0,4467",oFont71)
	oPrint:Say(lin+175,850,"5",oFont71)
	oPrint:Say(lin+175,960,"0,4030",oFont71)
	oPrint:Say(lin+215,850,"6",oFont71)
	oPrint:Say(lin+215,960,"0,3742",oFont71)
	oPrint:Say(lin+255,850,"7",oFont71)
	oPrint:Say(lin+255,960,"0,3534",oFont71)
	oPrint:Say(lin+295,850,"8",oFont71)
	oPrint:Say(lin+295,960,"0,3375",oFont71)
	oPrint:Say(lin+335,850,"9",oFont71)
	oPrint:Say(lin+335,960,"0,3249",oFont71)
	oPrint:Say(lin+375,850,"10",oFont71)
	oPrint:Say(lin+375,960,"0,3146",oFont71)
	oPrint:Line(lin+40, 810, lin+40, 1100 )	// horizontal
	oPrint:Line(lin+80, 810, lin+80, 1100 )	// horizontal
	oPrint:Line(lin+120, 810, lin+120, 1100 )	// horizontal
	oPrint:Line(lin+160, 810, lin+160, 1100 )	// horizontal
	oPrint:Line(lin+200, 810, lin+200, 1100 )	// horizontal
	oPrint:Line(lin+240, 810, lin+240, 1100 )	// horizontal
	oPrint:Line(lin+280, 810, lin+280, 1100 )	// horizontal
	oPrint:Line(lin+320, 810, lin+320, 1100 )	// horizontal
	oPrint:Line(lin+360, 810, lin+360, 1100 )	// horizontal
	oPrint:Line(lin+400, 810, lin+400, 1100 )	// horizontal
	
	//Representacao de RR e %RR	
	oPrint:Line( lin-20, 30, lin-20, 2350 )	// horizontal
	oPrint:Say(lin,0100,STR0071,oFont10) //"Repetitividade & Reprodutibilidade (R&R)"
	lin+=60
	oPrint:Say(lin,0100,STR0072,oFont10) //"R&R= RaizQ(VE^2 + VA^2)"
	oPrint:Say(lin,1200,If(nTipoRR == 1,STR0073,STR0074),oFont10)   //"%R&R= RaizQ(%VE^2 + %VA^2)"###"%R&R = 100[R&R/VT]"
	lin+=60 
	oPrint:Say(	lin,0100,STR0067+"("+Alltrim(Transform(aFim[1,16],cPict))+"^2+"+AllTrim(Transform(aFim[1,20],cPict))+")^2)",oFont10)      //"RaizQ("
	oPrint:Say(lin,1200,If(	nTipoRR == 1, "="+STR0067+Alltrim(Transform(aFim[1,1],cPict))+"^2+"+Alltrim(Transform(aFim[1,2],cPict))+"^2)",;
	"=100*("+Alltrim(Transform(aFim[1,21],cPict))+"/"+AllTrim(Transform(aFim[1,18],cPict))+")"),oFont10)//"RaizQ("
	lin+=60
	oPrint:Say(lin,0100,"R&R.:",oFont11)   //
	oPrint:Say(lin,0600,AllTrim(Transform(aFim[1,21], cPict)),oFont11) // nrr
	oPrint:Say(lin,1200,"%R&R.:",oFont11)
	oPrint:Say(lin,1700,AllTrim(Transform(aFim[1,3], "9999.99 %")),oFont11) //nprr
	lin += 80
	oPrint:Line( lin-20, 30, lin-20, 2350 )         
   	
   	//Representacao de VP e %VP
   	oPrint:Say(lin,0100,STR0075,oFont10)  //"Variacao peca a peca (VP)"
   	lin+=60
   	oPrint:Say(lin,0100,STR0076,oFont10) //"VP =  Rp    x   K3"
	oPrint:Say(lin,1200,If(nTipoRR == 1,STR0077,STR0078),oFont10)  // "%VP = 100[VP\TE]"###"%VP = 100[VP\VT]"
	lin+=60 
	oPrint:Say(lin,0100,"= "+AllTrim(Transform(aFim[1,6],cPict)+"*"+Alltrim(Transform(aFim[1,22],cPict))),oFont10)      
	oPrint:Say(lin,1200,If(nTipoRR == 1, "=100*"+AllTrim(Transform(aFim[1,23],cPict))+"/"+Alltrim(Transform(aFim[1,17],cPict)),;
	"=100*"+Alltrim(Transform(aFim[1,23],cPict))+"/"+AllTrim(Transform(aFim[1,18],cPict))),oFont10)//valor de %vp 
	lin+=60	
	oPrint:Say(lin,0100,STR0079,oFont11) //"VP.:"
	oPrint:Say(lin,0600,AllTrim(Transform(aFim[1,23], cPict)), oFont11) //nvp
	oPrint:Say(lin,1200,STR0080,oFont11)    //"%VP.:"
	oPrint:Say(lin,1700,AllTrim(Transform(aFim[1,4], "9999.99 %")), oFont11) //npvp
	lin += 80 
   	oPrint:Line( lin-20, 30, lin-20, 2350 )	// horizontal
   
	//Representacao de VT	
	If nTipoRR == 2
		oPrint:Say(lin,0100,STR0081,oFont10)  //"Variacao total (VT)
 		lin+=60
   		oPrint:Say(lin,0100,STR0082,oFont10) //"VT = RaizQ(R&R^2 + VP^2)"
   		oPrint:Say(lin,1200,STR0083,oFont10)   //"ndc = 1,41(VP / R&R)"
   		lin+=60 
		oPrint:Say(lin,0100,STR0067+Alltrim(Transform(aFim[1,21],cPict))+"^2+"+AllTrim(Transform(aFim[1,23],cPict))+"^2)",oFont10)  //"=RaizQ("
		oPrint:Say(lin,1200,"= 1,41*("+AllTrim(Transform(aFim[1,23],cPict))+"/"+AllTrim(Transform(aFim[1,21],cPict))+")",oFont10)
		lin+=60
		oPrint:Say(lin,0100,STR0043,oFont11) //"Variacao Total (VT)"
		oPrint:Say(lin,0600,AllTrim(Transform(aFim[1,18], cPict)), oFont11) //nvt
		oPrint:Say(lin,1200,"="+AllTrim(Transform(aFim[1,24], cPict)), oFont11) //nvt				
   		lin+=60
   		oPrint:Line( lin-20, 30, lin-20, 2350 )	// horizontal 
	Endif
	
	If aFim[1,3]  <= GetMv("MV_QRRIAPR")  		// nprr
		cResu := AllTrim(GetMv("MV_QRRTAPR"))	// "BOM"
	Elseif aFim[1,3] <= GetMv("MV_QRRICON")		// nprr
		cResu := AllTrim(GetMv("MV_QRRTCON"))	// "ACEITAVEL"
	Else
		cResu := AllTrim(GetMv("MV_QRRTREP"))	// "INACEITAVEL"
	Endif
	
	oPrint:Say(lin,100,STR0037,oFont11) //"Resultado.:"
	oPrint:Say(lin,600,cResu,oFont11) 
	lin+= 80
	oPrint:Line( lin-20, 30, lin-20, 2350 )	// horizontal
	   
	If nTipoRR == 2	
		oPrint:Say(lin,0100,STR0084,oFont71)     //"Para informacoes sobre a teoria e valores das constantes utilizadas neste formulario veja o Manual de Referencia Analise dos Sistemas de Medicao (MSA)"
		lin+=80
		oPrint:Say(lin,0100,Iif(QM4->QM4_TPMSA == '3',STR0086,STR0085),oFont71)   //"Quarta Edicao"###"Terceira Edicao"
		lin+=250 
	
	ElseIf nTipoRR == 1	
		oPrint:Say(lin,0100,STR0084,oFont71) //"Para informacoes sobre a teoria e valores das constantes utilizadas neste formulario veja o Manual de Referencia Analise dos Sistemas de Medicao (MSA)"
		lin+=80
		oPrint:Say(lin,0100,Iif(QM4->QM4_TPMSA == '3',STR0086,STR0085),oFont71) //"Quarta Edicao"###"Terceira Edicao"
		lin+=250
	EndIf
		
Endif

oPrint:Say(lin,1000,STR0048,oFont16)		//"Disposicao"

Lin+= 80 
oPrint:Line(lin-10, 0030, lin-10, 2350 )	// Horizontal
oPrint:Line(lin-10, 0030, lin+100, 0030 )   	// vertical - Inicio
oPrint:Line(lin-10, 1500, lin+100, 1500 )   	// vertical - Responsavel
oPrint:Line(lin-10, 2100, lin+100, 2100 )   	// vertical - Data
oPrint:Line(lin-10, 2350, lin+100, 2350 )   	// vertical - Final
oPrint:Line(lin+100, 0030, lin+100, 2350 )	// Horizontal

cCodMat := QM4->QM4_RESP
DbSelectArea("QAA")
DbSetOrder(1)   

If DbSeek(xFilial("QAA")+cCodMat)
	cNome := QAA->QAA_NOME
Endif

oPrint:Say(lin,0040,STR0048,oFont08 ) //"Disposicao" 
oPrint:Say(lin,1510,STR0049,oFont08 ) //"Responsavel"
oPrint:Say(lin+40,1520,cNome,oFont07 )
oPrint:Say(lin,2110,STR0050,oFont08 ) //"Data"
oPrint:Say(lin+40,2120,DTOC(QM4->QM4_DATA),oFont07 )

oPrint:Say(lin+40,0050,SubStr(QM4->QM4_DISPOS,1,60),oFont07 )
lin+=40
oPrint:Say(lin+30,0050,SubStr(QM4->QM4_DISPOS,61,20),oFont07 )


Return
