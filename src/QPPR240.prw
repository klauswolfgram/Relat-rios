/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE  "QPPR240.CH"
#INCLUDE  "PROTHEUS.CH"
                
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR240  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 08.03.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Aprovacao Interina GM                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR240(void)                                              ³±±
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

User Function QPPR240(lBrow,cPecaAuto,cJPEG)

Local oPrint
Local lPergunte := .F.

Private cStartPath 	:= GetSrvProfString("Startpath","")
Private cPecaRev 	:= ""
Private	axTex		:= {}
Private	cTextRet	:= ""

Default lBrow 		:= .F.
Default cPecaAuto	:= ""
Default cJPEG       := ""

If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

oPrint	:= TMSPrinter():New(STR0001) //"Aprovacao Interina GM"

oPrint:SetPortrait()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01				// Peca       							³
//³ mv_par02				// Revisao        						³
//³ mv_par03				// Impressora / Tela          			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA240"
		cPecaRev := Iif(!lBrow, M->QKH_PECA + M->QKH_REV, QKH->QKH_PECA + QKH->QKH_REV)
	Else
		lPergunte := Pergunte("PPR180",.T.)

		If lPergunte
			cPecaRev := mv_par01 + mv_par02	
		Else
			Return Nil
		Endif
	Endif
Endif

DbSelectArea("QK1")
DbSetOrder(1)
DbSeek(xFilial()+cPecaRev)

DbSelectArea("QKI")
DbSetOrder(1)
If !(DbSeek(xFilial()+cPecaRev))
	If Empty(cPecaAuto)
		Help(" ",1,"QPPA240SUB") // Nao existe Certificado de submissao
	Endif
	Return Nil
Endif

DbSelectArea("QKH")
DbSetOrder(1)
If DbSeek(xFilial()+cPecaRev)

	If Empty(cPecaAuto)
		MsgRun(STR0002,"",{|| CursorWait(), MontaRel(oPrint) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
	Else
		MontaRel(oPrint)
	Endif

	If lPergunte .and. mv_par03 == 1 .or. !Empty(cPecaAuto)
		If !Empty(cJPEG)
			oPrint:SaveAllAsJPEG(cStartPath+cJPEG,865,1110,140)
		Else 
			oPrint:Print()
		EndIF
	Else
		oPrint:Preview()  		// Visualiza antes de imprimir
	Endif
Endif

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MontaRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 08.03.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Aprovacao Interina                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontaRel(ExpO1)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR150                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontaRel(oPrint)

Local cClasseA1, cClasseB1, cClasseC1, cClasseD1, cClasseE1
Local lin := 400
Local nx  :=1
Private oFont16, oFont08, oFont09, oFont10, oFont12, oFontCou08

oFont16		:= TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
oFont08		:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
oFont09		:= TFont():New("Arial",09,09,,.F.,,,,.T.,.F.)
oFont10		:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFont12		:= TFont():New("Arial",12,12,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)

Cabecalho(oPrint)  			// Funcao que monta o cabecalho

oPrint:Say(400,040,STR0004,oFont10) //"Nome do Fornecedor:"
oPrint:Say(400,400,SM0->M0_NOMECOM,oFontCou08 )

oPrint:Say(450,040,STR0005,oFont10) //"Codigo do Fornecedor:"

oPrint:Say(500,040,STR0060,oFont10) //"Data Ressubmissao:"
oPrint:Say(500,400,DtoC(QKH->QKH_DATA),oFontCou08)

oPrint:Say(550,040,STR0009,oFont10) //"Data Expiracao"
oPrint:Say(550,400,DtoC(QKH->QKH_DTATE),oFontCou08)

oPrint:Say(600,040,STR0061,oFont10) //"Aplicacao"
oPrint:Say(600,400,QKI->QKI_APLIC,oFontCou08)

oPrint:Say(650,040,STR0006,oFont10) //"Nivel de Submissao:"
oPrint:Say(650,400,QKI->QKI_FLNISU,oFontCou08)

oPrint:Say(400,1160,STR0012,oFont10) //"Nome da Peca:"
oPrint:Say(400,1550,Subs(QK1->QK1_DESC,1,45),oFontCou08)

oPrint:Say(450,1160,STR0011,oFont10) //"Numero da Peca:"
oPrint:Say(450,1550,QKH->QKH_PECA,oFontCou08)

oPrint:Box( 500, 1150, 600, 2300 ) // Box EWO#

oPrint:Say(500,1160,STR0010,oFont10) //"EWO#:"
oPrint:Say(500,1550,QKH->QKH_NRA,oFontCou08)

oPrint:Say(550,1160,STR0062,oFont10) //"ECL:"
oPrint:Say(550,1550,QKH->QKH_ECL,oFontCou08)

oPrint:Say(550,1900,STR0008,oFont10) //"Data:"
oPrint:Say(550,2050,DtoC(QKH->QKH_DTECL),oFontCou08)

oPrint:Say(650,1160,STR0015,oFont10) //"Peso(Kg):"
oPrint:Say(650,1550,QKH->QKH_PESO,oFontCou08)

oPrint:Say(750,0040,STR0016,oFont10) //"No. Amostras:"
oPrint:Say(750,0400,QKH->QKH_QTDE,oFontCou08)      

oPrint:Say(750,0600,STR0063+" __________",oFont10) //"Insp/EQF :"

oPrint:Say(750,1000,STR0017,oFont10) //"Amostras Adicionais:"
oPrint:Say(750,1400,QKH->QKH_AMADIC,oFontCou08)

oPrint:Say(750,1650,STR0064,oFont10) //"PKG:"
oPrint:Say(750,1800,QKH->QKH_PKG,oFontCou08)

oPrint:Say(750,2050,STR0065,oFont10) //"Interim#:"
oPrint:Say(750,2200,QKH->QKH_INTERI,oFontCou08)

cClasseA1 := STR0018 //"(     ) Classe A - Pecas foram produzidas usando 100% ferramental , "
cClasseA1 += STR0019 //"porem nem todos os requisitos foram satisfeitos"

cClasseB1 := STR0020 //"(     ) Classe B - Pecas foram produzidas usando 100% ferramental , "
cClasseB1 += STR0021 //"e requerem retrabalho para satisfazer os requisitos"

cClasseC1 := STR0022 //"(     ) Classe C - Pecas nao sao produzidas usando 100% ferramental "
cClasseC1 += STR0023 //"de producao, porem satisfaz as especificacoes"

cClasseD1 := STR0024 //"(     ) Classe D - Pecas nao satisfazem especificacoes de registro de projeto"

cClasseE1 := STR0025 //"(     ) Classe E - Pecas nao satisfazem especificacoes de registro de projeto, "
cClasseE1 += STR0026 //"Pecas Classe E exigem substituicao para venda"

oPrint:Say(0900,0040,STR0027,oFont10) //"CLASSE INTERINA"

oPrint:Say(1000,0040,cClasseA1,oFont10)

oPrint:Say(1050,0040,cClasseB1,oFont10)

oPrint:Say(1100,0040,cClasseC1,oFont10)

oPrint:Say(1150,0040,cClasseD1,oFont10)

oPrint:Say(1200,0040,cClasseE1,oFont10)

If !Empty(QKH->QKH_FLCLAS)
	Do Case
		Case QKH->QKH_FLCLAS == "A"
			oPrint:Say(1000,0065,"X",oFont10)
		Case QKH->QKH_FLCLAS == "B"
			oPrint:Say(1050,0065,"X",oFont10)
		Case QKH->QKH_FLCLAS == "C"
			oPrint:Say(1100,0065,"X",oFont10)
		Case QKH->QKH_FLCLAS == "D"
			oPrint:Say(1150,0065,"X",oFont10)
		Case QKH->QKH_FLCLAS == "E"
			oPrint:Say(1200,0065,"X",oFont10)
	Endcase
Endif

oPrint:Say(1350,0040,STR0028,oFont10) //"STATUS:"

oPrint:Say(1350,0700,STR0029,oFont10) //"A = Aprovado"
oPrint:Say(1350,1100,STR0030,oFont10) //"I = Interina"
oPrint:Say(1350,1500,STR0031,oFont10) //"N = Nao Realizado"
                                                    
oPrint:Say(1400,0350,STR0032,oFont10) //"DIM"
oPrint:Say(1400,0500,QKH->QKH_AVDIM,oFontCou08)

oPrint:Say(1400,0700,STR0033,oFont10) //"APAR"
oPrint:Say(1400,0850,QKH->QKH_AVAPA,oFontCou08)

oPrint:Say(1400,1050,STR0034,oFont10) //"LAB"
oPrint:Say(1400,1200,QKH->QKH_AVLAB,oFontCou08)

oPrint:Say(1400,1400,STR0035,oFont10) //"PROC"
oPrint:Say(1400,1600,QKH->QKH_AVCEP,oFontCou08)

oPrint:Say(1400,1750,STR0036,oFont10) //"ENG"
oPrint:Say(1400,1900,QKH->QKH_AVENG,oFontCou08)
                                                     
oPrint:Say(1500,40,STR0037,oFont10) //"RESUMO DAS RAZOES"

lin := 1550

If !Empty(QKH->QKH_CHAV01)
	axTex := {}
	cTextRet := ""
	cTextRet := QO_Rectxt(QKH->QKH_CHAV01,"QPPA240A",1,TamSX3("QKO_TEXTO")[1],"QKO")
	axTex := Q_MemoArray(cTextRet,axTex,TamSX3("QKO_TEXTO")[1])

	For nx :=1 To Len(axTex)
		If !Empty(axTex[nx])
			If lin > 2720
				oPrint:EndPage()
				Cabecalho(oPrint)
				lin := 400
			Endif
			oPrint:Say(lin,200,axTex[nx],oFontCou08)
			lin += 40
		Endif
	Next nx
Endif

lin += 50
oPrint:Say(lin,40,STR0038,oFont10) //"ASSUNTOS(Relacione DIM, APP, Questoes de Lancamento)"
lin += 50

If !Empty(QKH->QKH_CHAV01)
	axTex := {}
	cTextRet := ""
	cTextRet := QO_Rectxt(QKH->QKH_CHAV01,"QPPA240B",1,TamSX3("QKO_TEXTO")[1],"QKO")
	axTex := Q_MemoArray(cTextRet,axTex,TamSX3("QKO_TEXTO")[1])

	For nx :=1 To Len(axTex)
		If !Empty(axTex[nx])
			If lin > 2720
				oPrint:EndPage()
				Cabecalho(oPrint)
				lin := 400
			Endif
			oPrint:Say(lin,200,axTex[nx],oFontCou08)
		Endif
		lin += 40
	Next nx
Endif

lin += 50
oPrint:Say(lin,40,STR0039,oFont10) //"PLANO DE ACAO(Fornecer com prazos)"
lin += 50

If !Empty(QKH->QKH_CHAV01)
	axTex := {}
	cTextRet := ""
	cTextRet := QO_Rectxt(QKH->QKH_CHAV01,"QPPA240C",1,TamSX3("QKO_TEXTO")[1],"QKO")
	axTex := Q_MemoArray(cTextRet,axTex,TamSX3("QKO_TEXTO")[1])

	For nx :=1 To Len(axTex)
		If !Empty(axTex[nx])
			If lin > 2720
				oPrint:EndPage()
				Cabecalho(oPrint)
				lin := 400
			Endif
			oPrint:Say(lin,200,axTex[nx],oFontCou08)
		Endif
		lin += 40
	Next nx

Endif

lin += 50
oPrint:Say(lin,40,STR0040,oFont10) //"ESTAO OS ASSUNTOS REFERENTES A INTERINA MENCIONADAS NO PLANO GP-12 (Explique)"
lin += 50

If !Empty(QKH->QKH_CHAV01)
	axTex := {}
	cTextRet := ""
	cTextRet := QO_Rectxt(QKH->QKH_CHAV01,"QPPA240D",1,TamSX3("QKO_TEXTO")[1],"QKO")
	axTex := Q_MemoArray(cTextRet,axTex,TamSX3("QKO_TEXTO")[1])

	For nx :=1 To Len(axTex)
		If !Empty(axTex[nx])
			If lin > 2720
				oPrint:EndPage()
				Cabecalho(oPrint)
				lin := 400
			Endif
			oPrint:Say(lin,200,axTex[nx],oFontCou08)
		Endif
		lin += 40
	Next nx
Endif

lin += 100

If lin > 2200
	oPrint:EndPage()
	Cabecalho(oPrint)
	lin := 400
Endif

oPrint:Say(lin,0040,STR0041,oFont10) //"Representante GMB:"
oPrint:Say(lin,0365,SubStr(QKH->QKH_RGMB,1,TamSx3("QKH_RGMB")[1]-9),oFontCou08)

oPrint:Say(lin,1100,STR0042,oFont10) //"Assinatura:"
oPrint:Say(lin,1300,"________________________________" ,oFont10)
oPrint:Say(lin,1900,STR0008,oFont10) //"Data:"
oPrint:Say(lin,02000,DtoC(QKH->QKH_DTGMB),oFontCou08)

lin += 100
oPrint:Say(lin,40,STR0043 ,oFont10) //"FORNECEDOR:"
lin += 50

oPrint:Say(lin,0400,"________________________________" ,oFont10)
oPrint:Say(lin,1050,QKH->QKH_CARGO,oFontCou08)
oPrint:Say(lin,1050,"________________________________" ,oFont10)
oPrint:Say(lin,1900,DtoC(QKH->QKH_DTAPR),oFontCou08)
oPrint:Say(lin,1700,"________________________________" ,oFont10)

lin += 50
oPrint:Say(lin,0500,STR0044 ,oFont10) //"Assinatura Autorizada"
oPrint:Say(lin,1250,STR0045 ,oFont10) //"Funcao"
oPrint:Say(lin,1900,STR0046 ,oFont10) //"Data"

lin += 100
oPrint:Say(lin,0400,SubStr(QKH->QKH_APRFOR,1,TamSx3("QKH_APRFOR")[1]-3),oFontCou08)
oPrint:Say(lin,0400,"________________________________" ,oFont10)
oPrint:Say(lin,1050,QKH->QKH_TEL,oFontCou08)
oPrint:Say(lin,1050,"________________________________" ,oFont10)
oPrint:Say(lin,1700,QKH->QKH_FAX,oFontCou08)
oPrint:Say(lin,1700,"________________________________" ,oFont10)

lin += 50
oPrint:Say(lin,0500,STR0047 ,oFont10) //"Nome Legivel"
oPrint:Say(lin,1250,STR0048 ,oFont10) //"Telefone"
oPrint:Say(lin,1900,STR0049 ,oFont10) //"Fax"

lin += 100
oPrint:Say(lin,0040,STR0050 ,oFont10) //"Aprovacoes do Cliente:     Assinatura"
oPrint:Say(lin,1000,STR0051,oFont10) //"Nome"
oPrint:Say(lin,2000,STR0046,oFont10) //"Data"

lin += 100
oPrint:Say(lin,0100,"_____________________________________" ,oFont10)
lin += 50
oPrint:Say(lin,0100,STR0052 ,oFont10) //"Engenheiro de Qualidade do Fornecedor"
oPrint:Say(lin,1000,QKH->QKH_APRQUA,oFontCou08)
oPrint:Say(lin,2000,DtoC(QKH->QKH_DTQUA),oFontCou08)

lin += 100
oPrint:Say(lin,0100,"_____________________________________" ,oFont10)
lin += 50
oPrint:Say(lin,0100,STR0053,oFont10) //"Engenheiro de Produto (DRE)"
oPrint:Say(lin,1000,QKH->QKH_APRPRO,oFontCou08)
oPrint:Say(lin,2000,DtoC(QKH->QKH_DTPRO),oFontCou08)

lin += 100
oPrint:Say(lin,0100,"_____________________________________" ,oFont10)
lin += 50
oPrint:Say(lin,0100,STR0054 ,oFont10) //"Engenheiro de Materiais/Lab"
oPrint:Say(lin,1000,QKH->QKH_APRPRJ,oFontCou08)
oPrint:Say(lin,2000,DtoC(QKH->QKH_DTPRJ),oFontCou08)

lin += 100
oPrint:Say(lin,0100,"_____________________________________" ,oFont10)
lin += 50
oPrint:Say(lin,0100,STR0055 ,oFont10) //"Engenheiro de Aparencia/Pintura"
oPrint:Say(lin,1000,QKH->QKH_APRAPA,oFontCou08)
oPrint:Say(lin,2000,DtoC(QKH->QKH_DTAPA),oFontCou08)

lin += 100
oPrint:Say(lin,0100,"_____________________________________" ,oFont10)
lin += 50
oPrint:Say(lin,0100,STR0056 ,oFont10) //"OUTROS(Comprador, Unidade de Montagem)"
oPrint:Say(lin,1000,QKH->QKH_APRCOM,oFontCou08)
oPrint:Say(lin,2000,DtoC(QKH->QKH_DTCOM),oFontCou08)

oPrint:EndPage() 		// Finaliza a pagina

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabecalho³ Autor ³ Robson Ramiro A. Olive³ Data ³ 08.03.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cabecalho do relatorio                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabecalho(ExpO1)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR240                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabecalho(oPrint)

Local cFileLogo  := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(005,2100, "Logo.bmp",237,58) // Tem que estar abaixo do RootPath
oPrint:SayBitmap(005,0005, cFileLogo,328,82)

PPAPBMP("GM.BMP", cStartPath)
oPrint:SayBitmap(150,0040, "GM.BMP",192,210)

oPrint:Say(40,700,STR0057,oFont16) //"Processo de Aprovacao de Peca de Producao"

oPrint:Say(200,700,STR0058,oFont16) //"Formulario de Aprovacao Interina (GM 1411)"

Return
