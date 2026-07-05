/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr720.ch"
#Include "Protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³MDTR720   ³ Autor ³Thiago Olis Machado    ³ Data ³ 01/07/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Impressao de Atendimento Ambulatorial.                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAMDT                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   		     |		  |   	|                   					  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR720()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM()

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

Private oTempTRB

cPerg :="MDT72R    "
nRecno := 0

If !MDTRESTRI(cPrograma)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

/*----------------------------------
// PERGUNTAS PADRÃO					|
| 01  Data Atendimento ?   			|
| 02  De Motivo ?          			|
| 03  Ate Motivo ?         			|
| 04  Tipo Impressao ?     			|
|										|
//PERGUNTAS PRESTADOR DE SERVIÇO	|
| 01  De  Cliente ?        			|
| 02  Loja                  		|
| 03  Até Cliente ?         		|
| 04  Loja                  		|
| 05  Data Atendimento ?    		|
| 06  De Motivo ?           		|
| 07  Ate Motivo ?          		|
| 08  Tipo Impressao ?      		|
------------------------------------*/

If lSigaMdtps

	cPerg    :=  "MDT72RPS  "

	aDBF := {}
	AADD(aDBF,{ "CLIENT"  , "C" ,nTa1 , 0 })
	AADD(aDBF,{ "LOJA"    , "C" ,nTa1L, 0 })
	AADD(aDBF,{ "NOMECLI" , "C" ,40, 0 })
	AADD(aDBF,{ "RG"      , "C" ,15, 0 })
	AADD(aDBF,{ "NOME"    , "C" ,30, 0 })
	AADD(aDBF,{ "MOTIVO"  , "C" ,02, 0 })
	AADD(aDBF,{ "CID"     , "C" ,08, 0 })
	AADD(aDBF,{ "TPCON"   , "C" ,01, 0 })
	AADD(aDBF,{ "ATESTA"  , "C" ,03, 0 })
	AADD(aDBF,{ "COMENTA" , "C" ,80, 0 })
	AADD(aDBF,{ "NUMFIC"  , "C" ,09, 0 })
	AADD(aDBF,{ "HRCONS"  , "C" ,05, 0 })

	//Cria TRB
	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	oTempTRB:AddIndex( "1", {"CLIENT","LOJA","MOTIVO","NUMFIC","HRCONS"} )
	oTempTRB:Create()
Else

	aDBF := {}
	AADD(aDBF,{ "RG"      , "C" ,15, 0 })
	AADD(aDBF,{ "NOME"    , "C" ,30, 0 })
	AADD(aDBF,{ "MOTIVO"  , "C" ,02, 0 })
	AADD(aDBF,{ "CID"     , "C" ,08, 0 })
	AADD(aDBF,{ "TPCON"   , "C" ,01, 0 })
	AADD(aDBF,{ "ATESTA"  , "C" ,03, 0 })
	AADD(aDBF,{ "COMENTA" , "C" ,80, 0 })
	AADD(aDBF,{ "NUMFIC"  , "C" ,09, 0 })
	AADD(aDBF,{ "HRCONS"  , "C" ,05, 0 })

	//Cria TRB
	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	oTempTRB:AddIndex( "1", {"MOTIVO","NUMFIC","HRCONS"} )
	oTempTRB:Create()
Endif

If Pergunte(cPerg,.T.)
	U_MDT720DADO()

	TRB->(DbGoTop())
	If TRB->(Eof())
		MsgStop(STR0007)  //"Não há nada para imprimir no relatório."
		DbSelectArea("TRB")
		//Use
		oTempTRB:Delete()
		Return Nil
	EndIf

	U_MDT720IMP()
EndIf

DbSelectArea("TRB")
//Use
oTempTRB:Delete()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³MDT720DADO³ Autor ³ Thiago Olis Machado   ³ Data ³ 01/07/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Busca de Dados para Impressao.                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAMDT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT720DADO()
Local cMotivo := If( lSigaMdtPs , MV_PAR06 , MV_PAR02 )

cMotivo := If( Empty( cMotivo ) , "" , cMotivo )

If lSigaMdtps

	DbSelectArea("TMJ")
	DbSetOrder(4)
	Dbseek(xFilial("TMJ")+cMotivo,.t.)

	While !Eof() .and. xFilial("TMJ") == TMJ->TMJ_FILIAL .and. TMJ->TMJ_MOTIVO <= MV_PAR07

		If TMJ->TMJ_DTCONS <> MV_PAR05
			DbSelectArea("TMJ")
			DbSkip()
			Loop
		EndIf

		dbSelectArea("TM0")
		dbSetOrder(1)
		If dbSeek(xFilial("TM0")+TMJ->TMJ_NUMFIC)
			If TM0->(TM0_CLIENT+TM0_LOJA) < mv_par01+mv_par02 .or. TM0->(TM0_CLIENT+TM0_LOJA) > mv_par03+mv_par04
				DbSelectArea("TMJ")
				DbSkip()
				Loop
			Endif
		Else
			DbSelectArea("TMJ")
			DbSkip()
			Loop
		Endif

		DbSelectArea("TMT")
		DbSetOrder(10)  //TMT_FILIAL+TMT_CLIENT+TMT_LOJA+TMT_NUMFIC+DTOS(TMT_DTCONS)+TMT_HRCONS
		If DbSeek(xFilial("TMT")+TM0->(TM0_CLIENT+TM0_LOJA)+TMJ->TMJ_NUMFIC+DtoS(TMJ->TMJ_DTCONS)+TMJ->TMJ_HRCONS)

			If TMT->TMT_OCORRE <> "5"
				DbSelectArea("TMJ")
				DbSkip()
				Loop
			EndIf

			DbSelectArea("SRA")
			DbSetOrder(1)
			If !DbSeek(xFilial("SRA")+TM0->TM0_MAT)
				DbSelectArea("TMJ")
				DbSkip()
				Loop
			Endif

			DbSelectArea("TRB")
			DbSetOrder(1)
			If !DbSeek(TM0->(TM0_CLIENT+TM0_LOJA)+TMJ->TMJ_MOTIVO+TMT->TMT_NUMFIC+TMJ->TMJ_HRCONS)
				RecLock("TRB",.t.)
				TRB->RG     := SRA->RA_RG
				TRB->NOME   := SRA->RA_NOME
				TRB->MOTIVO := TMJ->TMJ_MOTIVO
				TRB->CID    := TMT->TMT_CID
				DbSelectArea("TNY")
				DbSetOrder(1)
				If DbSeek(xFilial("TNY")+TMT->TMT_NUMFIC+DTOS(MV_PAR05)+TMJ->TMJ_HRCONS)
					TRB->ATESTA := STR0037 //"SIM"
				Else
				   TRB->ATESTA := STR0038 //"NAO"
				EndIf
				If NGCADICBASE( "TMT_DIASYP" , "A" , "TMT" , .F. )
					TRB->COMENTA:= MsMM(TMT->TMT_QUESYP,10)
				Else
					TRB->COMENTA:= TMT->TMT_QUEIXA
				EndIf
				TRB->NUMFIC := TMT->TMT_NUMFIC
				TRB->CLIENT := TMT->TMT_CLIENT
				TRB->LOJA   := TMT->TMT_LOJA
				TRB->NOMECLI := NGSEEK("SA1",TRB->CLIENT+TRB->LOJA,1,"SA1->A1_NOME")
				TRB->HRCONS  := TMJ->TMJ_HRCONS
				MsUnLock("TRB")
      		EndIf

		EndIf

		DbSelectArea("TMJ")
		DbSkip()
	End

Else

	DbSelectArea("TMJ")
	DbSetOrder(4)
	Dbseek(xFilial("TMJ")+cMotivo,.t.)

	While !Eof() .and. xFilial("TMJ") == TMJ->TMJ_FILIAL .and. TMJ->TMJ_MOTIVO <= MV_PAR03

		If TMJ->TMJ_DTCONS <> MV_PAR01
			DbSelectArea("TMJ")
			DbSkip()
			Loop
		EndIf

		DbSelectArea("TMT")
		DbSetOrder(3)  //TMT_FILIAL+TMT_NUMFIC+DTOS(TMT_DTCONS)+TMT_HRCONS
		If DbSeek(xFilial("TMT")+TMJ->TMJ_NUMFIC+DtoS(TMJ->TMJ_DTCONS)+TMJ->TMJ_HRCONS)

			If TMT->TMT_OCORRE <> "5"
				DbSelectArea("TMJ")
				DbSkip()
				Loop
			EndIf

			DbSelectArea("TM0")
			DbSetOrder(1)
			If !DbSeek(xFilial("TM0")+TMT->TMT_NUMFIC)
				DbSelectArea("TMJ")
				DbSkip()
				Loop
			Endif

			DbSelectArea("SRA")
			DbSetOrder(1)
			If !DbSeek(xFilial("SRA")+TM0->TM0_MAT)
				DbSelectArea("TMJ")
				DbSkip()
				Loop
			Endif

			DbSelectArea("TRB")
			DbSetOrder(1)
			If !DbSeek(TMJ->TMJ_MOTIVO+TMT->TMT_NUMFIC+TMJ->TMJ_HRCONS)
				RecLock("TRB",.t.)
				TRB->RG     := SRA->RA_RG
				TRB->NOME   := SRA->RA_NOME
				TRB->MOTIVO := TMJ->TMJ_MOTIVO
				TRB->CID    := TMT->TMT_CID
				DbSelectArea("TNY")
				DbSetOrder(1)
				If DbSeek(xFilial("TNY")+TMT->TMT_NUMFIC+DTOS(MV_PAR01)+TMJ->TMJ_HRCONS)
					TRB->ATESTA := STR0037 //"SIM"
				Else
				   TRB->ATESTA := STR0038 //"NAO"
				EndIf
				If NGCADICBASE( "TMT_DIASYP" , "A" , "TMT" , .F. )
					TRB->COMENTA:= MsMM(TMT->TMT_QUESYP,10)
				Else
					TRB->COMENTA:= TMT->TMT_QUEIXA
				EndIf
				TRB->NUMFIC := TMT->TMT_NUMFIC
				TRB->HRCONS := TMJ->TMJ_HRCONS
				MsUnLock("TRB")
			EndIf

		EndIf

		DbSelectArea("TMJ")
		DbSkip()
	End

Endif

DbSelectArea("TRB")
DbGoTop()
nRecno := Reccount()
Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³MDT720IMP ³ Autor ³ Thiago Olis Machado   ³ Data ³ 01/07/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Impressao do Relatorio.                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAMDT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT720IMP()

Local i := 1
Private oFont08,oFont11,oFont12,oFont13,oFont14,oFont16,oFont17,oFont18

oFont08 := TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)
oFont11 := TFont():New("Courier New",11,11,,.F.,,,,.T.,.F.)
oFont12 := TFont():New("Courier New",12,12,,.T.,,,,.T.,.F.)
oFont13 := TFont():New("Courier New",11,11,,.T.,,,,.T.,.F.)
oFont14 := TFont():New("Courier New",14,14,,.F.,,,,.T.,.F.)
oFont16 := TFont():New("Courier New",14,14,,.F.,,,,.F.,.F.)
oFont17 := TFont():New("Courier New",14,14,,.T.,,.T.,,.T.,.F.)
oFont18 := TFont():New("Courier New",16,16,,.T.,,.T.,,.T.,.F.)

oPrint := TMSPrinter():New( OemToAnsi( STR0008 ) )  //"Atendimento Ambulatorial"
oPrint:Setup()
oPrint:SetLandScape() //paisagem

U_MDT720Prin(oPrint,@i,1)

If lSigaMdtps
	If Mv_par08 = 2
		oPrint:Print()
	Else
		oPrint:Preview()
	Endif
Else
	If Mv_par04 = 2
		oPrint:Print()
	Else
		oPrint:Preview()
	Endif
Endif

Return .t.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³MDT720PRIN³ Autor ³ Thiago Olis Machado   ³ Data ³ 01/07/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Impressao do Relatorio.                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAMDT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT720PRIN(oPrint,i,t)

Local cSMCOD := IIf( FindFunction( "FWGrpCompany" ), FWGrpCompany(), SM0->M0_CODIGO )
Local cSMFIL := IIf( FindFunction( "FWCodFil" ), FWCodFil(), SM0->M0_CODFIL )
Local x, z
Local nVert2 := 1300  //vertical 2
Local nVert2_ := 1301  //vertical 2

If lSigaMdtps

	DbSelectArea("TRB")
	DbSetOrder(1)
	DbGotop()

	While !Eof()

		cCliente := TRB->CLIENT+TRB->LOJA
		i:= 0
		cMotivo := ''
		Lin := 280
		lFirst := .t.

		i++
		oPrint:StartPage()

		oPrint:Cmtr2Pix(130,080)//linha,coluna
		oPrint:Cmtr2Pix(500,150)//largura,altura
		oSend(oPrint, "SayBitmap",130,080,"LGRL"+cSMCOD+cSMFIL+".bmp" ,500,150 )//objeto,constante,linha,coluna,caminho,

		oPrint:Say(130,260,STR0009,oFont18) //"PROGRAMA DE CONTROLE MÉDICO DE SAÚDE OCUPACIONAL"
		oPrint:Line(200,240,200,2940)
		oPrint:Line(201,240,201,2940)
		oPrint:Say(220,290,STR0010,oFont17) //"CONTROLE DE ATENDIMENTO NO AMBULATÓRIO MÉDICO"
		oPrint:Line(110,1710,200,1710)
		oPrint:Line(110,1711,200,1711)
		oPrint:Say(140,1770,STR0033,oFont16)  //"Cliente/Loja: "
		oPrint:Say(140,2110,SubStr(TRB->NOMECLI,1,30),oFont16)
		oPrint:Line(200,1710,280,1710)
		oPrint:Line(200,1711,280,1711)
		oPrint:Say(220,1770,STR0012,oFont16) //"Data:"
		oPrint:Say(220,1920,DtoC( mv_par05 ),oFont16)
		oPrint:Line(200,2190,280,2190)
		oPrint:Line(200,2191,280,2191)
		oPrint:Say(220,2230,STR0013,oFont16) //"Folha nº"
		oPrint:Say(220,2490,AllTrim(Str(i)),oFont16)

		oPrint:Line(280,010,280,2940) //horizontal
		oPrint:Line(281,010,281,2940) //horizontal
		oPrint:Line(282,010,282,2940) //horizontal
		oPrint:Line(283,010,283,2940) //horizontal

		oPrint:Line(2029,010,2029,2940) //horizontal
		oPrint:Line(2030,010,2030,2940) //horizontal
		oPrint:Line(2031,010,2031,2940) //horizontal

		oPrint:Say(2069,560,STR0014,oFont12) //"* TC - TIPO DE CONSULTA"

		oPrint:Line(2139,010,2139,2940) //horizontal

		oPrint:Say(2153,100,"1",oFont13)
		oPrint:Say(2155,110,STR0015,oFont11)   //" - Retorno ao serviço imediatamente"
		oPrint:Say(2223,100,"2",oFont13)
		oPrint:Say(2225,110,STR0016,oFont11) //" - Dispensado do serviço por ordem médica"

		oPrint:Say(2153,1200,"3",oFont13)
		oPrint:Say(2155,1210,STR0017,oFont11) //" - Encaminhado ao hospital/especialista/exames especializados"
		oPrint:Say(2223,1200,"4",oFont13)
		oPrint:Say(2225,1210,STR0018,oFont11) //" - Encaminhado para exames complementares/laboratório/perícia"

		oPrint:Line(2300,080,2300,2940) //horizontal
		oPrint:Line(2301,080,2301,2940) //horizontal

		oPrint:Say(2319,100,STR0019,oFont12) //"ASSINATURA E IDENTIFICAÇÃO DO PROFISSIONAL:"
		oPrint:Line(2388,010,2388,2940) //horizontal
		oPrint:Line(2389,010,2389,2940) //horizontal
		oPrint:Line(2390,010,2390,2940) //horizontal
		oPrint:Line(2391,010,2391,2940) //horizontal

		While !Eof() .and. cCliente == TRB->CLIENT+TRB->LOJA

			If Lin > 2029
				I++
				oPrint:EndPage()
				If U_MDT720PRIN(oPrint,@i,x)
					Return .t.
				EndIf
			EndIf

			If cMotivo <> TRB->MOTIVO
				DbSelectArea("TMS")
				DbSetOrder(1)
				DbSeek(xFilial("TMS")+TRB->MOTIVO)
				oPrint:Say(Lin+15,150,STR0020,oFont12) //"MOTIVO : "
				oPrint:Say(Lin+20,370,TRB->MOTIVO,oFont11)
				oPrint:Say(Lin+20,800,TMS->TMS_NOMOTI,oFont11)
				cMotivo := TRB->MOTIVO
				oPrint:Line(lin+70,080,lin+70,2940) //horizontal
				Lin += 70

				If lFirst
					oPrint:Say(lin+10,300,STR0021,oFont12) //"R.G."
					oPrint:Say(lin+10,580,STR0022,oFont12) //"NOME"
					oPrint:Say(lin+10,1075,STR0023,oFont12) //"DIAGNÓSTICO"
					oPrint:Say(lin+10,1440,"TC*",oFont12)
					oPrint:Say(lin+10,1600,STR0024,oFont12) //"ATESTADO"
					oPrint:Say(lin+10,2185,STR0025,oFont12)                     //"COMENTÁRIO"
					oPrint:Line(Lin+70,010,lin+70,2940) //horizontal

					oPrint:Line(lin,370,lin+70,370) //vertical 	1
					oPrint:Line(lin,371,lin+70,371) //vertical 	1

					oPrint:Line(lin,nVert2,lin+70,nVert2) //vertical 	2
					oPrint:Line(lin,nVert2_,lin+70,nVert2_) //vertical 	2

					oPrint:Line(lin,1380,lin+70,1380)//vertical 	3
					oPrint:Line(lin,1381,lin+70,1381)//vertical 	3

					oPrint:Line(lin,1580,lin+70,1580)//vertical    4
					oPrint:Line(lin,1581,lin+70,1581)//vertical    4

					oPrint:Line(lin,1820,lin+70,1820)//vertical 	5
					oPrint:Line(lin,1821,lin+70,1821)//vertical 	5
					lfirst := .f.
					lin += 70
				EndIf

			EndIf

			oPrint:Say(Lin+10,100,Transform(TRB->RG,"@R 9.999.999.999/9"),oFont11)
			oPrint:Say(Lin+10,390,TRB->NOME,oFont11)
			oPrint:Say(Lin+10,1130,TRB->CID,oFont11)
			oPrint:Say(Lin+10,1660,TRB->ATESTA,oFont11)
			oPrint:Say(Lin+10,1880,SubStr( TRB->COMENTA, 1, 44 ),oFont11)
			If Len( AllTrim( TRB->COMENTA ) ) > 44
				oPrint:Line(lin,370,lin+70,370) //vertical 	1
				oPrint:Line(lin,371,lin+70,371) //vertical 	1

				oPrint:Line(lin,nVert2,lin+70,nVert2) //vertical 	2
				oPrint:Line(lin,nVert2_,lin+70,nVert2_) //vertical 	2

				oPrint:Line(lin,1380,lin+70,1380)//vertical 	4
				oPrint:Line(lin,1381,lin+70,1381)//vertical 	4

				oPrint:Line(lin,1580,lin+70,1580)//vertical 	5
				oPrint:Line(lin,1581,lin+70,1581)//vertical 	5

				oPrint:Line(lin,1820,lin+70,1820)//vertical 	6
				oPrint:Line(lin,1821,lin+70,1821)//vertical 	6

				lin += 50
				oPrint:Say(Lin,1880,SubStr( TRB->COMENTA, 45, 80 ),oFont11)
				lin += 20
			EndIf

			oPrint:Line(Lin+70,010,lin+70,2940) //horizontal
			//Divisao das colunas
			oPrint:Line(lin,370,lin+70,370) //vertical 	1
			oPrint:Line(lin,371,lin+70,371) //vertical 	1

			oPrint:Line(lin,nVert2,lin+70,nVert2) //vertical 	2
			oPrint:Line(lin,nVert2_,lin+70,nVert2_) //vertical 	2

			oPrint:Line(lin,1380,lin+70,1380)//vertical 	4
			oPrint:Line(lin,1381,lin+70,1381)//vertical 	4

			oPrint:Line(lin,1580,lin+70,1580)//vertical 	5
			oPrint:Line(lin,1581,lin+70,1581)//vertical 	5

			oPrint:Line(lin,1820,lin+70,1820)//vertical 	6
			oPrint:Line(lin,1821,lin+70,1821)//vertical 	6

			oPrint:Line(Lin+70,010,lin+70,2940) //horizontal

			Lin += 70

			DbSelectArea("TRB")
			DbSkip()
		End

		yLinhas := Round((( 2029-Lin )/70),0)+1

		For z := 1 to yLinhas
			oPrint:Line(lin,010,lin,2940) //horizontal

			oPrint:Line(lin-70,370,lin,370) //vertical 	1
			oPrint:Line(lin-70,371,lin,371) //vertical 	1

			oPrint:Line(lin-70,nVert2,lin,nVert2) //vertical 	2
			oPrint:Line(lin-70,nVert2_,lin,nVert2_) //vertical 	2

			oPrint:Line(lin-70,1380,lin,1380)//vertical 	4
			oPrint:Line(lin-70,1381,lin,1381)//vertical 	4

			oPrint:Line(lin-70,1580,lin,1580)//vertical 	5
			oPrint:Line(lin-70,1581,lin,1581)//vertical 	5

			oPrint:Line(lin-70,1820,lin,1820)//vertical 	6
			oPrint:Line(lin-70,1821,lin,1821)//vertical 	6

			lin += 70
		Next z

		oPrint:EndPage()

	End

Else

	oPrint:StartPage()

	oPrint:Cmtr2Pix(150,080)//linha,coluna
	oPrint:Cmtr2Pix(500,150)//largura,altura
	oSend(oPrint, "SayBitmap",130,080,"LGRL"+cSMCOD+cSMFIL+".bmp" ,500,150 )//objeto,constante,linha,coluna,caminho,

	oPrint:Say(130,660,STR0009,oFont18) //"PROGRAMA DE CONTROLE MÉDICO DE SAÚDE OCUPACIONAL"
	oPrint:Line(200,640,200,2940)
	oPrint:Line(201,640,201,2940)
	oPrint:Say(220,690,STR0010,oFont17) //"CONTROLE DE ATENDIMENTO NO AMBULATÓRIO MÉDICO"
	oPrint:Line(110,2340,200,2340)
	oPrint:Line(110,2341,200,2341)
	oPrint:Say(140,2350,STR0011,oFont12) //"Unidade:"
	oPrint:Say(140,2560,SM0->M0_NOME,oFont12)
	oPrint:Line(200,2100,280,2100)
	oPrint:Line(200,2101,280,2101)
	oPrint:Say(220,2140,STR0012,oFont12) //"Data:"
	oPrint:Say(220,2290,DtoC( mv_par01 ),oFont12)
	oPrint:Line(200,2560,280,2560)
	oPrint:Line(200,2561,280,2561)
	oPrint:Say(220,2600,STR0013,oFont12) //"Folha nº"
	oPrint:Say(220,2860,AllTrim(Str(i)),oFont12)

	oPrint:Line(280,010,280,2940) //horizontal
	oPrint:Line(281,010,281,2940) //horizontal
	oPrint:Line(282,010,282,2940) //horizontal
	oPrint:Line(283,010,283,2940) //horizontal

	oPrint:Line(2029,010,2029,2940) //horizontal
	oPrint:Line(2030,010,2030,2940) //horizontal
	oPrint:Line(2031,010,2031,2940) //horizontal

	oPrint:Say(2069,560,STR0014,oFont12) //"* TC - TIPO DE CONSULTA"

	oPrint:Line(2139,010,2139,2940) //horizontal

	oPrint:Say(2153,100,"1",oFont13)
	oPrint:Say(2155,110,STR0015,oFont11)   //" - Retorno ao serviço imediatamente"
	oPrint:Say(2223,100,"2",oFont13)
	oPrint:Say(2225,110,STR0016,oFont11) //" - Dispensado do serviço por ordem médica"

	oPrint:Say(2153,1200,"3",oFont13)
	oPrint:Say(2155,1210,STR0017,oFont11) //" - Encaminhado ao hospital/especialista/exames especializados"
	oPrint:Say(2223,1200,"4",oFont13)
	oPrint:Say(2225,1210,STR0018,oFont11) //" - Encaminhado para exames complementares/laboratório/perícia"

	oPrint:Line(2300,010,2300,2940) //horizontal
	oPrint:Line(2301,010,2301,2940) //horizontal

	oPrint:Say(2319,100,STR0019,oFont12) //"ASSINATURA E IDENTIFICAÇÃO DO PROFISSIONAL:"
	oPrint:Line(2388,010,2388,2940) //horizontal
	oPrint:Line(2389,010,2389,2940) //horizontal
	oPrint:Line(2390,010,2390,2940) //horizontal
	oPrint:Line(2391,010,2391,2940) //horizontal


	DbSelectArea("TRB")
	DbSetOrder(1)
	DbGoto(t)
	cMotivo := ''
	Lin := 280
	lFirst := .t.
	For x:= t To nRecno
		If Lin > 2029
			I++
			oPrint:EndPage()
			If U_MDT720PRIN(oPrint,@i,x)
				Return .t.
			EndIf
		EndIf

		If cMotivo <> TRB->MOTIVO
			DbSelectArea("TMS")
			DbSetOrder(1)
			DbSeek(xFilial("TMS")+TRB->MOTIVO)
			oPrint:Say(Lin+15,50,STR0020,oFont12) //"MOTIVO : "
			oPrint:Say(Lin+20,300,TRB->MOTIVO,oFont11)
			oPrint:Say(Lin+20,400,TMS->TMS_NOMOTI,oFont11)
			cMotivo := TRB->MOTIVO
			oPrint:Line(lin+70,010,lin+70,2940) //horizontal
			Lin += 70

			If lFirst

				oPrint:Say(lin+10,250,STR0021,oFont12) //"R.G."
				oPrint:Say(lin+10,570,STR0022,oFont12) //"NOME"
				oPrint:Say(lin+10,1320,STR0023,oFont12) //"DIAGNÓSTICO"
				oPrint:Say(lin+10,1640,"TC*",oFont12)
				oPrint:Say(lin+10,1810,STR0024,oFont12) //"ATESTADO"
				oPrint:Say(lin+10,2215,STR0025,oFont12) //"COMENTÁRIO"

				oPrint:Line(Lin+70,010,lin+70,2940) //horizontal

				oPrint:Line(lin,550,lin+70,550) //vertical 	1
				oPrint:Line(lin,551,lin+70,551) //vertical 	1

				oPrint:Line(lin,nVert2,lin+70,nVert2) //vertical 	2
				oPrint:Line(lin,nVert2_,lin+70,nVert2_) //vertical 	2

				oPrint:Line(lin,1620,lin+70,1620)//vertical 	3
				oPrint:Line(lin,1621,lin+70,1621)//vertical 	3

				oPrint:Line(lin,1790,lin+70,1790)//vertical 	4
				oPrint:Line(lin,1791,lin+70,1791)//vertical 	4

				oPrint:Line(lin,2030,lin+70,2030)//vertical 	5
				oPrint:Line(lin,2031,lin+70,2031)//vertical 	5


				lfirst := .F.
				lin += 70
			EndIf

		EndIf

		oPrint:Say(Lin+10,50,Transform(TRB->RG,"@R 9.999.999/9"),oFont11)
		oPrint:Say(Lin+10,570,TRB->NOME,oFont11)
		oPrint:Say(Lin+10,1320,TRB->CID,oFont11)
		oPrint:Say(Lin+10,1810,TRB->ATESTA,oFont11)
		oPrint:Say(Lin+10,2060,SubStr( TRB->COMENTA, 1, 37 ),oFont11)
		If Len( AllTrim( TRB->COMENTA ) ) > 37

			oPrint:Line(lin,550,lin+70,550) //vertical 	1
			oPrint:Line(lin,551,lin+70,551) //vertical 	1

			oPrint:Line(lin,nVert2,lin+70,nVert2) //vertical 	2
			oPrint:Line(lin,nVert2_,lin+70,nVert2_) //vertical 	2

			oPrint:Line(lin,1620,lin+70,1620)//vertical 	3
			oPrint:Line(lin,1621,lin+70,1621)//vertical 	3

			oPrint:Line(lin,1790,lin+70,1790)//vertical 	4
			oPrint:Line(lin,1791,lin+70,1791)//vertical 	4

			oPrint:Line(lin,2030,lin+70,2030)//vertical 	5
			oPrint:Line(lin,2031,lin+70,2031)//vertical 	5

			lin += 50
			oPrint:Say(Lin,2060,SubStr( TRB->COMENTA, 38, 37 ),oFont11)
			lin += 20
		EndIf

		oPrint:Line(Lin+70,010,lin+70,2940) //horizontal
		//Divisao das colunas
		oPrint:Line(lin,550,lin+70,550) //vertical 	1
		oPrint:Line(lin,551,lin+70,551) //vertical 	1

		oPrint:Line(lin,nVert2,lin+70,nVert2) //vertical 	2
		oPrint:Line(lin,nVert2_,lin+70,nVert2_) //vertical 	2

		oPrint:Line(lin,1620,lin+70,1620)//vertical 	3
		oPrint:Line(lin,1621,lin+70,1621)//vertical 	3

		oPrint:Line(lin,1790,lin+70,1790)//vertical 	4
		oPrint:Line(lin,1791,lin+70,1791)//vertical 	4

		oPrint:Line(lin,2030,lin+70,2030)//vertical 	5
		oPrint:Line(lin,2031,lin+70,2031)//vertical 	5

		oPrint:Line(Lin+70,010,lin+70,2940) //horizontal

		Lin += 70

		DbSelectArea("TRB")
		DbSkip()
	Next x

	yLinhas := Round((( 2029-Lin )/70),0)+1

	For z := 1 to yLinhas

		oPrint:Line(lin,010,lin,2940) //horizontal

		oPrint:Line(lin-70,550,lin,550) //vertical 	1
		oPrint:Line(lin-70,551,lin,551) //vertical 	1

		oPrint:Line(lin-70,nVert2,lin,nVert2) //vertical 	2
		oPrint:Line(lin-70,nVert2_,lin,nVert2_) //vertical 	2

		oPrint:Line(lin-70,1620,lin,1620)//vertical 	3
		oPrint:Line(lin-70,1621,lin,1621)//vertical 	3

		oPrint:Line(lin-70,1790,lin,1790)//vertical 	4
		oPrint:Line(lin-70,1791,lin,1791)//vertical 	4

		oPrint:Line(lin-70,2030,lin,2030)//vertical 	5
		oPrint:Line(lin-70,2031,lin,2031)//vertical 	5

		lin += 70
	Next z

	oPrint:EndPage()

Endif

Return .T.