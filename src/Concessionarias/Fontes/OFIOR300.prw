/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 09     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼
#INCLUDE "OFIOR300.ch"
#include "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³OFIOR300  ³ Autor ³Ricardo Farinelli      ³ Data ³ 31/10/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Impressao de Checklist de Oficina                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Gestao de Concessionarias                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function OFIOR300()

Local oPrint
Local i 	:= 1
Local lin 	:= 0
Private aImpCpo := {}
Private oFont16, oFont08, oFont10,oFont07, oFont12 , oFont06,oFont12w

oFont16	:= TFont():New("Arial",16,16,,.T.,,,,.T.,.F.)
oFont06	:= TFont():New("Arial",06,06,,.F.,,,,.T.,.F.)
oFont08	:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
oFont07	:= TFont():New("Arial",07,07,,.F.,,,,.T.,.F.)
oFont10	:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFont12	:= TFont():New("Arial",12,12,,.T.,,,,.T.,.F.)

dbSelectArea("SX3")
dbSetOrder(1)
Dbseek("VA8")
While !Eof() .And. (SX3->X3_ARQUIVO == "VA8")
	IF X3USO(SX3->X3_USADO) .AND. cNivel >= SX3->X3_NIVEL
		AADD(aImpCpo,{ Alltrim(SX3->X3_CAMPO) , Alltrim(SX3->X3_TITULO) })
	EndIf
	dbSelectArea("SX3")
	dbSkip()
EndDo
 
if !Empty(M->VA8_NUMOSV)
	If !VA8->(Dbseek(xFilial("VA8")+M->VA8_NUMOSV))
		MsgStop(STR0001) //"Checklist ainda nao foi gravado"
		Return
	Endif
Else
	If !VA8->(Dbseek(xFilial("VA8")+space(Len(M->VA8_NUMOSV))+M->VA8_PLAVEI))
		MsgStop(STR0001) //"Checklist ainda nao foi gravado"
		Return
	Endif
Endif
oPrint	:= TMSPrinter():New( OemToAnsi(STR0002) ) //"Checklist de Veículos (Oficina)"
oPrint:Setup()

MontaRel(oPrint,@i,@lin)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MONTAREL  ºAutor  ³Ricardo Farinelli   º Data ³  11/06/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao principal para confeccao do relatorio                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Gestao de Concessionarias                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function MontaRel(oPrint,i,lin)

Cabecalho(oPrint,@i)  			// Funcao que monta o cabecalho
lin := Detail(oPrint,@i)  		// Funcao que monta o cabecalho
If lin > 2700				// Espaco minimo para colocacao do rodape
	i++
	oPrint:EndPage() 		// Finaliza a pagina
	Cabecalho(oPrint,@i)
	lin := 330
Endif
Resumo(oPrint,@i,@lin) // imprime o resumo da avaliacao

oPrint:Preview()  				// Visualiza antes de imprimir

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabecalho³ Autor ³ Ricardo Farinelli     ³ Data ³ 31/10/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cabecalho do relatorio                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabecalho(ExpO1,ExpN1)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Capabili                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabecalho(oPrint,i)
Local cFig := GetSrvProfString("StartPath","")
Local aSM0     := {}
If File(cFig+"LGRL"+cEmpAnt+cFilAnt+".BMP")
	cFig +="LGRL"+cEmpAnt+cFilAnt+".BMP"
Elseif File(cFig+"LGRL"+cEmpAnt+".BMP")
	cFig +="LGRL"+cEmpAnt+".BMP"
Else
	cFig +="LGRL.BMP"
Endif
oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(20,30,cFig ,250,80)

oPrint:Say(075,750,STR0002,oFont16 ) //"CHECKLIST DE VEÍCULOS (OFICINA)"

oPrint:Box( 150, 30, 310, 2350 )

VO1->(DbsetOrder(1))
VO1->(Dbseek(xFilial("VO1")+VA8->(VA8_NUMOSV)))
SA1->(DbsetOrder(1))
SA1->(Dbseek(xFilial("SA1")+VO1->(VO1_PROVEI+VO1_LOJPRO)))
VV1->(DbsetOrder(1))
VV1->(Dbseek(xFilial("VV1")+VO1->VO1_CHAINT))

VE1->(DbsetOrder(1))
VE1->(Dbseek(xFilial("VE1")+VV1->VV1_CODMAR))
VV2->(Dbseek(xFilial("VV2")+VV1->(VV1_CODMAR+VV1_MODVEI)))

aSM0 := FWArrFilAtu(cEmpAnt,cFilAnt) // Filial Origem (Filial logada)

// 1a Linha
oPrint:Say(160,0040,STR0003,oFont08 ) //"Numero Ordem Serviço"
oPrint:Say(160,0425,STR0004,oFont08 ) //"Checklist"
oPrint:Say(160,1150,STR0005,oFont08 ) //"Data Ordem de Serviço"
oPrint:Say(160,1590,STR0006,oFont08 ) //"Empresa"
oPrint:Say(160,2160,STR0007,oFont08 ) //"Página"

oPrint:Say(190,0040,VA8->VA8_NUMOSV,oFont10)
oPrint:Say(190,0425,Dtoc(dDataBase),oFont10 )
oPrint:Say(190,1150,Dtoc(VO1->VO1_DATABE),oFont10)
oPrint:Say(190,1590,aSM0[6],oFont10)
oPrint:Say(190,2160,STRZERO(i,2),oFont10)

// 2a Linha
oPrint:Say(240,0040,STR0008,oFont08 ) //"Marca"
oPrint:Say(240,0425,STR0009,oFont08 ) //"Modelo"
oPrint:Say(240,1150,STR0010,oFont08 ) //"Modelo/Fabricação"
oPrint:Say(240,1370,STR0011,oFont08 ) //"Combustível"
oPrint:Say(240,1590,STR0046,oFont08 ) //"Placa"
oPrint:Say(240,1735,STR0012,oFont08 ) //"Cliente"

oPrint:Say(270,0040,VO1->VO1_CODMAR+" - "+VE1->VE1_DESMAR,oFont08)
oPrint:Say(270,0425,VV2->VV2_MODVEI+" - "+substr(VV2->VV2_DESMOD,1,25),oFont08)
oPrint:Say(270,1150,Transform(VV1->VV1_FABMOD,"@R 9999/9999"),oFont08)
oPrint:Say(270,1370,X3Combo("VV1_COMVEI",VV1->VV1_COMVEI),oFont08)
oPrint:Say(270,1590,VA8->VA8_PLAVEI,oFont08)
oPrint:Say(270,1735,SA1->A1_COD+"/"+SA1->A1_LOJA+" - "+substr(SA1->A1_NOME,1,28),oFont08)

// Construcao das linhas do cabecalho
// Primeira linha
oPrint:Line( 230,  30, 230, 2350 )   	// horizontoal
oPrint:Line( 150, 415, 310, 415 )   	// vertical
oPrint:Line( 150, 1140, 310, 1140 )   	// vertical
oPrint:Line( 150, 1575, 310, 1575 )   	// vertical
oPrint:Line( 150, 2150, 230, 2150 )   	// vertical

// Segunda Linha
oPrint:Line( 230, 1360, 310, 1360 )   	// vertical
oPrint:Line( 230, 1720, 310, 1720 )   	// vertical

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Detail   ³ Autor ³ Ricardo Farinelli     ³ Data ³ 31/10/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Itens do relatorio                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Detail(ExpO1,ExpN1)                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Capabili                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Detail(oPrint,i)
Local lin  := 330
Local nPos := 0

// Construcao da grade
oPrint:Box(lin,0030,lin+70,2350)
lin+=10
oPrint:Say(lin,900,STR0013,oFont12) //"Check-List Itens do Veículo"
lin+=80
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_ESTEPE" })
If nPos > 0
	oPrint:Box(lin,0030,lin+70,550)
	oPrint:Say(lin+20,0040,aImpCpo[nPos,2]+":",oFont08) //"Possui Estepe: "
	oPrint:Say(lin+20,0480,Iif(VA8->VA8_ESTEPE =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_TOCACD" })
If nPos > 0
	oPrint:Box(lin,0930,lin+70,1450)
	oPrint:Say(lin+20,0940,aImpCpo[nPos,2]+":",oFont08) //"Possui Toca CD: "
	oPrint:Say(lin+20,1380,Iif(VA8->VA8_TOCACD =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_TOCAFT" })
If nPos > 0
	oPrint:Box(lin,1830,lin+70,2350)
	oPrint:Say(lin+20,1840,aImpCpo[nPos,2]+":",oFont08) //"Possui Toca-Fitas: "
	oPrint:Say(lin+20,2280,Iif(VA8->VA8_TOCAFT =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
lin+=80
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_SOMFR" })
If nPos > 0
	oPrint:Box(lin,0030,lin+70,550)
	oPrint:Say(lin+20,0040,aImpCpo[nPos,2]+":",oFont08) //"Frente Som Removível: "
	oPrint:Say(lin+20,0480,Iif(VA8->VA8_SOMFR =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_MODULO" })
If nPos > 0
	oPrint:Box(lin,0930,lin+70,1450)
	oPrint:Say(lin+20,0940,aImpCpo[nPos,2]+":",oFont08) //"Possui Módulo Som: "
	oPrint:Say(lin+20,1380,Iif(VA8->VA8_MODULO =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_TRIANG" })
If nPos > 0
	oPrint:Box(lin,1830,lin+70,2350)
	oPrint:Say(lin+20,1840,aImpCpo[nPos,2]+":",oFont08) //"Possui Triângulo: "
	oPrint:Say(lin+20,2280,Iif(VA8->VA8_TRIANG =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
lin+=80
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_DVD" })
If nPos > 0
	oPrint:Box(lin,0030,lin+70,550)
	oPrint:Say(lin+20,0040,aImpCpo[nPos,2]+":",oFont08) //"Possui DVD: "
	oPrint:Say(lin+20,0480,Iif(VA8->VA8_DVD =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_RODA" })
If nPos > 0
	oPrint:Box(lin,0930,lin+70,1450)
	oPrint:Say(lin+20,0940,aImpCpo[nPos,2]+":",oFont08) //"Roda Liga-Leve: "
	oPrint:Say(lin+20,1380,Iif(VA8->VA8_RODA =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_ANTENA" })
If nPos > 0
	oPrint:Box(lin,1830,lin+70,2350)
	oPrint:Say(lin+20,1840,aImpCpo[nPos,2]+":",oFont08) //"Possui Antena Externa: "
	oPrint:Say(lin+20,2280,Iif(VA8->VA8_ANTENA =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
lin+=80
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_DISQUE" })
If nPos > 0
	oPrint:Box(lin,0030,lin+70,550)
	oPrint:Say(lin+20,0040,aImpCpo[nPos,2]+":",oFont08) //"Disqueteira CD: "
	oPrint:Say(lin+20,0480,Iif(VA8->VA8_DISQUE =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_ESPELD" })
If nPos > 0
	oPrint:Box(lin,0930,lin+70,1450)
	oPrint:Say(lin+20,0940,aImpCpo[nPos,2]+":",oFont08) //"Espelho Retrovisor Direito: "
	oPrint:Say(lin+20,1380,Iif(VA8->VA8_ESPELD =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_CALOTA" })
If nPos > 0
	oPrint:Box(lin,1830,lin+70,2350)
	oPrint:Say(lin+20,1840,aImpCpo[nPos,2]+":",oFont08) //"Possui Calotas: "
	oPrint:Say(lin+20,2280,Iif(VA8->VA8_CALOTA =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
lin+=80
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_FAROLM" })
If nPos > 0
	oPrint:Box(lin,0030,lin+70,550)
	oPrint:Say(lin+20,0040,aImpCpo[nPos,2]+":",oFont08) //"Farol de Milha/Neblina: "
	oPrint:Say(lin+20,0480,Iif(VA8->VA8_FAROLM =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_TAPETE" })
If nPos > 0
	oPrint:Box(lin,0930,lin+70,1450)
	oPrint:Say(lin+20,0940,aImpCpo[nPos,2]+":",oFont08) //"Jogo de Tapetes: "
	oPrint:Say(lin+20,1380,Iif(VA8->VA8_TAPETE =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_ACENDE" })
If nPos > 0
	oPrint:Box(lin,1830,lin+70,2350)
	oPrint:Say(lin+20,1840,aImpCpo[nPos,2]+":",oFont08) //"Acendedor Cigarros: "
	oPrint:Say(lin+20,2280,Iif(VA8->VA8_ACENDE =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
lin+=80
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_BANCO" })
If nPos > 0
	oPrint:Box(lin,0030,lin+70,550)
	oPrint:Say(lin+20,0040,aImpCpo[nPos,2]+":",oFont08) //"Bancos em Couro: "
	oPrint:Say(lin+20,0480,Iif(VA8->VA8_BANCO =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_MACACO" })
If nPos > 0
	oPrint:Box(lin,0930,lin+70,1450)
	oPrint:Say(lin+20,0940,aImpCpo[nPos,2]+":",oFont08) //"Macaco Manual/Hidráulico: "
	oPrint:Say(lin+20,1380,Iif(VA8->VA8_MACACO =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_INSULF" })
If nPos > 0
	oPrint:Box(lin,1830,lin+70,2350)
	oPrint:Say(lin+20,1840,aImpCpo[nPos,2]+":",oFont08) //"Insulfilm nos Vidros: "
	oPrint:Say(lin+20,2280,Iif(VA8->VA8_INSULF =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
lin+=80
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_ALARME" })
If nPos > 0
	oPrint:Box(lin,0030,lin+70,550)
	oPrint:Say(lin+20,0040,aImpCpo[nPos,2]+":",oFont08) //"Alarme Sonoro: "
	oPrint:Say(lin+20,0480,Iif(VA8->VA8_ALARME =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_CORTAC" })
If nPos > 0
	oPrint:Box(lin,0930,lin+70,1450)
	oPrint:Say(lin+20,0940,aImpCpo[nPos,2]+":",oFont08) //"Corta Combustível: "
	oPrint:Say(lin+20,1380,Iif(VA8->VA8_CORTAC =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_VIDROS" })
If nPos > 0
	oPrint:Box(lin,1830,lin+70,2350)
	oPrint:Say(lin+20,1840,aImpCpo[nPos,2]+":",oFont08) //"Vidros Verdes: "
	oPrint:Say(lin+20,2280,Iif(VA8->VA8_VIDROS =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
lin+=80
nPos := aScan(aImpCpo,{|x| x[1] == "VA8_VIDROE" })
If nPos > 0
	oPrint:Box(lin,0030,lin+70,550)
	oPrint:Say(lin+20,0040,aImpCpo[nPos,2]+":",oFont08) //"Vidros Elétricos: "
	oPrint:Say(lin+20,0480,Iif(VA8->VA8_VIDROE =="0",STR0015,STR0016),oFont10) //"Sim"###"Nao"
EndIf
oPrint:Box(lin,0930,lin+120,1450) // Quadrado de Fora
oPrint:Say(lin+10,0940,"V",oFont08)
oPrint:Line(Lin+40,0950,Lin+60,0950) // Vazio
oPrint:Say(lin+10,0990,"R",oFont08)
oPrint:Line(Lin+40,1000,Lin+60,1000) // Reserva
oPrint:Say(lin+10,1060,"¼",oFont08)
oPrint:Line(Lin+40,1070,Lin+60,1070) // 1/4
oPrint:Say(lin+10,1180,"½",oFont08)
oPrint:Line(Lin+40,1190,Lin+60,1190) // 1/2
oPrint:Say(lin+10,1300,"¾",oFont08)
oPrint:Line(Lin+40,1310,Lin+60,1310) // 3/4
oPrint:Say(lin+10,1420,"C",oFont08)
oPrint:Line(Lin+40,1430,Lin+60,1430) // Cheio
oPrint:Box(lin+50,0930,lin+110,1450) // Quadrado de dentro
oPrint:Say(lin+80,1135,STR0011 + "  ",oFont06) //"Combustível"
lin+=110
nPos := 	Iif(VA8->VA8_COMBUS=="0",940,;
Iif(VA8->VA8_COMBUS=="1",990,;
Iif(VA8->VA8_COMBUS=="2",1060,;
Iif(VA8->VA8_COMBUS=="3",1180,;
Iif(VA8->VA8_COMBUS=="4",1300,1420)))))
oPrint:Line(Lin-40,nPos,Lin,nPos)
oPrint:Line(Lin-40,nPos+20,Lin,nPos+20)
oPrint:Line(Lin-60,nPos+10,Lin-40,nPos)
oPrint:Line(Lin-60,nPos+10,Lin-40,nPos+20)
Lin+=20

VSR->(DbsetOrder(1))
If VSR->(Dbseek(xFilial("VSR")+VA8->VA8_NUMOSV))
	// Construcao da grade
	oPrint:Box(lin,0030,lin+140,2350)
	lin+=10
	oPrint:Say(lin,0930,STR0038,oFont12) //"Check-List do Estado do Veiculo"
	lin+=60
	oPrint:Line(lin,0030,lin,2350)
	oPrint:Line( lin, 0170, lin+70, 0170 )   	// vertical
	oPrint:Line( lin, 0790, lin+70, 0790 )   	// vertical
	oPrint:Line( lin, 0940, lin+70, 0940 )   	// vertical
	oPrint:Line( lin, 1560, lin+70, 1560 )   	// vertical
	oPrint:Line( lin, 1690, lin+70, 1690 )   	// vertical
	lin+=10
	oPrint:Say(lin,0040,STR0039,oFont08) //"Grupo"
	oPrint:Say(lin,0180,STR0040,oFont08) //"Descrição"
	oPrint:Say(lin,0800,STR0041,oFont08) //"Item"
	oPrint:Say(lin,0950,STR0040,oFont08) //"Descrição"
	oPrint:Say(lin,1570,STR0042,oFont08)		 //"Avaria"
	oPrint:Say(lin,1700,STR0040,oFont08) //"Descrição"
	lin+=60
	Do While VSR->(VSR_FILIAL+VSR_NUMOSV) == xFilial("VSR")+VSR->VSR_NUMOSV .and. !VSR->(Eof())
		oPrint:Say(lin,0040,VSR->VSR_CODGRU,oFont07)
		VA0->(DbsetOrder(1))
		VA0->(Dbseek(xFilial("VA0")+VSR->VSR_CODGRU))
		oPrint:Say(lin,0180,VA0->VA0_DESCRI,oFont07)
		oPrint:Say(lin,0800,VSR->VSR_ITEM,oFont07)
		VA0->(DbsetOrder(2))
		VA0->(Dbseek(xFilial("VA0")+VSR->(VSR_CODGRU+VSR_ITEM)))
		oPrint:Say(lin,0950,VA0->VA0_DESCRI,oFont07)
		oPrint:Say(lin,1570,VSR->VSR_AVARIA,oFont07)
		VA4->(DbsetOrder(1))
		VA4->(Dbseek(xFilial("VA4")+VSR->VSR_AVARIA))
		oPrint:Say(lin,1700,VA4->VA4_DESCRI,oFont07)
		oPrint:Line( lin, 0030, lin+25, 0030 )   	// vertical
		oPrint:Line( lin, 0170, lin+25, 0170 )   	// vertical
		oPrint:Line( lin, 0790, lin+25, 0790 )   	// vertical
		oPrint:Line( lin, 0940, lin+25, 0940 )   	// vertical
		oPrint:Line( lin, 1560, lin+25, 1560 )   	// vertical
		oPrint:Line( lin, 1690, lin+25, 1690 )   	// vertical
		oPrint:Line( lin, 2350, lin+25, 2350 )   	// vertical
		lin+=25
		If lin > 2700				// Espaco minimo para colocacao do rodape
			i++
			oPrint:Line(lin,0030,lin,2350)
			oPrint:EndPage() 		// Finaliza a pagina
			Cabecalho(oPrint,@i)
			lin := 330
			oPrint:Box(lin,0030,lin+140,2350)
			lin+=10
			oPrint:Say(lin,0930,STR0038,oFont12) //"Check-List do Estado do Veiculo"
			lin+=60
			oPrint:Line(lin,0030,lin,2350)
			oPrint:Line( lin, 0170, lin+70, 0170 )   	// vertical
			oPrint:Line( lin, 0790, lin+70, 0790 )   	// vertical
			oPrint:Line( lin, 0940, lin+70, 0940 )   	// vertical
			oPrint:Line( lin, 1560, lin+70, 1560 )   	// vertical
			oPrint:Line( lin, 1690, lin+70, 1690 )   	// vertical
			lin+=10
			oPrint:Say(lin,0040,STR0039,oFont08) //"Grupo"
			oPrint:Say(lin,0180,STR0040,oFont08) //"Descrição"
			oPrint:Say(lin,0800,STR0041,oFont08) //"Item"
			oPrint:Say(lin,0950,STR0040,oFont08) //"Descrição"
			oPrint:Say(lin,1570,STR0042,oFont08)		 //"Avaria"
			oPrint:Say(lin,1700,STR0040,oFont08) //"Descrição"
			lin+=60
		Endif
		VSR->(Dbskip())
	Enddo
	oPrint:Line(lin,0030,lin,2350)
	lin+=80
Endif

Return lin

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RESUMO    ºAutor  ³Ricardo Farinelli   º Data ³  10/31/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime o Resumo da Avaliacao                               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Gestao de Concessionarias                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function Resumo(oPrint,i,lin)
Local cCampo := ""                                         
Local aSM0     := {}
oPrint:Box(lin,30,lin+70,2350)
lin+=10
oPrint:Say(lin,1100,STR0043,oFont12) //"Observações"
lin+=70
//oPrint:Line(lin,30,lin,2350)
dbSelectArea("SYP")
dbSetOrder(1)
If VA8->(FieldPos("VA8_OBSMEM")) > 0
	if dbSeek(xFilial("SYP")+VA8->VA8_OBSMEM)  
	    nNroLin := 0     
	    cUltima := ""
	    While !Eof() .and. xFilial("SYP") == SYP->YP_FILIAL .and. SYP->YP_CHAVE == VA8->VA8_OBSMEM
	
			nPos1 := AT("\13\10",SYP->YP_TEXTO)
			if nPos1 > 0
				nPos := len(alltrim(SYP->YP_TEXTO)) - 6
			else
				nPos := len(alltrim(SYP->YP_TEXTO))
			endif
			cCampo += " "+Substr(SYP->YP_TEXTO,1,nPos)
	    	dbSelectArea("SYP")
	    	dbSkip()
	    Enddo
	Endif 
Endif
cInicio := "Inicio" 
nPos := 1
While cInicio <> ""   
	oPrint:Line( lin, 030, lin+40, 030 )   	// vertical
	oPrint:Line( lin, 2350, lin+40, 2350 )   	// vertical
	oPrint:Say(lin,040,Alltrim(substr(cCampo,nPos,90)),oFont10)  
	lin+=40     
    nPos += 90 
    cInicio := substr(cCampo,nPos,80)
Enddo
aSM0 := FWArrFilAtu(cEmpAnt,cFilAnt) // Filial Origem (Filial logada)
oPrint:Line( lin, 030, lin+100, 030 )   	// vertical
oPrint:Line( lin, 2350, lin+100, 2350 )   	// vertical
lin+=100     
oPrint:Line(lin,30,lin,2350)
lin+=400
oPrint:Box(lin,650,lin+70,1150)
oPrint:Say(lin+10,660,STR0044,oFont08) //"Cliente:"
oPrint:Box(lin,1220,lin+70,1720)
oPrint:Say(lin+10,1230,Trim(aSM0[6])+":",oFont08)

Return lin 