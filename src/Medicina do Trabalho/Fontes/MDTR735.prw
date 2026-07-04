/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr735.ch"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR735

Ficha de Investigação e Analise do Acidente

@author  Denis Hyroshi de Souza
@since   24/06/03

@return  Nulo, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function MDTR735()

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	Private cPerg := ""

	nTa1 := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
	nTa1L := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
	nSizeTD := nTa1+nTa1L

	lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
	cPerg := If(!lSigaMdtPS,"MDT735    ","MDT735PS  ")

	/*
	//PERGUNTAS PADRÃO
	Tipo Impressao ?
	Cliente ?
	Loja ?
	Numero do Acidente ?
	*/

	If lSigaMdtps
		cCliMdtps := ""

		If pergunte(cPerg,.t.)
			Dbselectarea("TNC")
			Dbsetorder(13)

			If !Dbseek(xFilial("TNC")+mv_par02+Mv_par03+mv_par04)
				MsgStop(STR0093,STR0002) //"O acidente selecionado não existe para o cliente."###"REGISTRO INVALIDO"
				U_MDTR735()
				Return
			Else
				U_MDT735IMP()
			Endif

		Endif

	Else

		If pergunte(cPerg,.t.)
			Dbselectarea("TNC")
			Dbsetorder(1)

			If !Dbseek(xFilial("TNC")+Mv_par02)
				MsgStop(STR0001,STR0002) //"Numero do Acidente nao existente."###"REGISTRO INVALIDO"
				U_MDTR735()
				Return
			Else
				U_MDT735IMP()
			Endif

		Endif

	Endif

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT735IMP

Chamada do Relatório

@author  Denis Hyroshi de Souza
@since   24/06/03

@return  Lógico, Sempre .T.
/*/
//-------------------------------------------------------------------
User Function MDT735IMP()
	Local oPrint

	Private cAlias := "SI3"
	Private cDescr := "SI3->I3_DESC"
	Private lin := 0
	Private oFont06	:= TFont():New("Courier New",07,07,,.T.,,,,.F.,.F.)
	Private oFont07	:= TFont():New("Courier New",07,07,,.F.,,,,.F.,.F.)
	Private oFont08	:= TFont():New("Courier New",08,08,,.T.,,,,.F.,.F.)
	Private oFont09	:= TFont():New("Courier New",09,09,,.T.,,,,.F.,.F.)
	Private oFont10 := TFont():New("Courier New",10,10,,.F.,,,,.F.,.F.)
	Private oFont11 := TFont():New("Courier New",11,11,,.F.,,,,.F.,.F.)
	Private oFont12	:= TFont():New("Courier New",12,12,,.T.,,,,.F.,.F.)
	Private oFontxt	:= TFont():New("Courier New",08,08,,.F.,,,,.F.,.F.)
	Private oFont14	:= TFont():New("Courier New",10,10,,.T.,,,,.F.,.F.)
	Private oFont15	:= TFont():New("Courier New",15,15,,.T.,,,,.F.,.F.)

	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cAlias := "CTT"
		cDescr := "CTT->CTT_DESC01"
	Endif

	oPrint	:= TMSPrinter():New(OemToAnsi(STR0003)) //"Investigação e Análise de Acidente"
	oPrint:Setup()

	U_RELMDT735(oPrint)
	If Mv_par01 = 2
		oPrint:Print()
	Else
		oPrint:Preview()
	Endif

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} RELMDT735

Impressao do Relatório

@author  Denis Hyroshi de Souza
@since   24/06/2003

@sample  U_RELMDT735(oPrint)

@param   oPrint, Objeto, Objeto que permite a visualização do relatório

@return  Lógico, Sempre .T.
/*/
//-------------------------------------------------------------------
User Function RELMDT735(oPrint)
	Local aSemana := {STR0004,STR0005,STR0006,STR0007,STR0008,STR0009,STR0010} //"DOMINGO"###"SEGUNDA-FEIRA"###"TERÇA-FEIRA"###"QUARTA-FEIRA"###"QUINTA-FEIRA"###"SEXTA-FEIRA"###"SÁBADO"
	Local aMes := {STR0011,STR0012,STR0013,STR0014,STR0015,STR0016,STR0017,; //" JANEIRO"###"FEVEREIRO"###"  MARÇO"###"  ABRIL"###"   MAIO"###"  JUNHO"###"  JULHO"
					STR0018,STR0019,	STR0020,STR0021,STR0022} //"  AGOSTO"###" SETEMBRO"###" OUTUBRO"###" NOVEMBRO"###" DEZEMBRO"
	Local cDiagnos := " ",cCid01 := " ",cCid02 := " ",cObserva := " "
	Local cTipAcid := " ",cAgente := " ",cTreinam := " ", nBold, nLinha, xx, cTreiner := " "
	Local cCargo := ""
	Local aMemo := {}
	Local cMemo := ""
	Local nAux := 0
	Local cIndex, nIndex, cChave, cFiltro, cExtIndex, nIndTNU  //Utilizados no filtro da tabela TNU
	Local cSMCOD := FWGrpCompany()
	Local cSMFIL := FWCodFil()
	Local lGes := If (GetMv("MV_MDTGPE") == "S",.T.,.F.)
	Local lCipatr := If( SuperGetMv("MV_NG2NR31" , .F. , "2") == "1" , .T. , .F. )
	Private dDtAfast := CtoD("  /  /  ")
	Private dDtAlta  := CtoD("  /  /  ")
	Private lAfasta  := .f.
	Private cDiasAf
	Private cCid
	lin := 250

	If lSigaMdtps

		Dbselectarea("TNC")
		Dbsetorder(13)
		If Dbseek(xFilial("TNC")+Mv_par02+Mv_par03+Mv_par04)

			Dbselectarea("TM0")
			Dbsetorder(1)
			Dbseek(xFilial("TM0")+TNC->TNC_NUMFIC)
			Dbselectarea("SRA")
			Dbsetorder(1)
			Dbseek(TM0->TM0_FILFUN+TM0->TM0_MAT)
			Dbselectarea(cAlias)
			Dbsetorder(1)
			Dbseek(TM0->TM0_FILFUN+SRA->RA_CC)
			Dbselectarea("SRJ")
			Dbsetorder(1)
			Dbseek(xFilial("SRJ")+SRA->RA_CODFUNC)
			If Empty(SRA->RA_CARGO)
				Dbselectarea("SQ3")
				Dbsetorder(1)
				If Dbseek(xFilial("SQ3")+SRJ->RJ_CARGO)
					cCargo := SQ3->Q3_DESCSUM
				Endif
			Else
				Dbselectarea("SQ3")
				Dbsetorder(1)
				If Dbseek(xFilial("SQ3")+SRA->RA_CARGO)
					cCargo := SQ3->Q3_DESCSUM
				Endif
			Endif
			If !Empty(TNC->TNC_CID)
					cCid := TNC->TNC_CID

				DbSelectArea("TMR")
				DbSetOrder(1)
				If DbSeek(xFilial("TMR")+cCid)
					cCid01 := TMR->TMR_DOENCA
				EndIF
			EndIF
			Dbselectarea("TMT")
			DbSetOrder(7)  //TMT_FILIAL+TMT_CLIENT+TMT_LOJA+TMT_ACIDEN+TMT_NUMFIC
			If DbSeek(xFilial("TMT")+TNC->TNC_CLIENT+TNC->TNC_LOJA+TNC->TNC_ACIDEN+TNC->TNC_NUMFIC)
				If NGCADICBASE( "TMT_DIASYP" , "A" , "TMT" , .F. )
					cDiagnos := MsMM(TMT->TMT_DIASYP,10)
				Else
					cDiagnos := Alltrim(TMT->TMT_DIAGNO)
				EndIf
				cObserva := Transform(TMT->TMT_OUTROS,"@!")
				If !Empty(TNC->TNC_CID)
					cCid := TNC->TNC_CID
				Else
					cCid := TMT->TMT_CID
				EndIf
				DbSelectArea("TMR")
				DbSetOrder(1)
				If DbSeek(xFilial("TMR")+cCid)
					cCid01 := TMR->TMR_DOENCA
				EndIf
			Endif
			Dbselectarea("TNG")
			DbSetOrder(3)  //TNG_FILIAL+TNG_CLIENT+TNG_LOJA+TNG_TIPACI
			If DbSeek(xFilial("TNG")+TNC->TNC_CLIENT+TNC->TNC_LOJA+TNC->TNC_TIPACI)
				cTipAcid := Substr(TNG->TNG_DESTIP,1,80)
			Endif
			Dbselectarea("TNH")
			DbSetOrder(3)  //TNH_FILIAL+TNH_CLIENT+TNH_LOJA+TNH_CODOBJ
			If DbSeek(xFilial("TNH")+TNC->TNC_CLIENT+TNC->TNC_LOJA+TNC->TNC_CODOBJ)
				cAgente := Substr(TNH->TNH_DESOBJ,1,80)
			Endif

			dDtInv	:= StoD( Space( 8 ) )
			cFiltro := 'TNU_FILIAL =="'  + xFilial("TNU")  + '".And.'
			cFiltro := 'TNU_CLIENT =="'  + mv_par02 + '".And.'
			cFiltro := 'TNU_LOJA =="'  + mv_par03 + '".And.'
			cFiltro += 'TNU_ACIDEN =="'  + TNC->TNC_ACIDEN + '"'

			dbSelectArea( "TNU" )
			Set Filter To &( cFiltro )
			dbGoTop()
			If TNU->( !Eof() )
				If TNU->TNU_DTINVE > dDtInv
					cTreinam := TNU->TNU_TREINA
					cTreiner := SubStr(NgSeek("TMK",TNU->TNU_RESINV,1,"TMK->TMK_NOMUSU"),1,25)
					dDtInv 	 := TNU->TNU_DTINVE
				EndIf
			End

			dbSelectArea( "TNU" )
			Set Filter To

			oPrint:StartPage() //Inicia nova pagina
			lin := 200

			If File("LGRL"+cSMCOD+cSMFIL+".BMP")
				oPrint:SayBitMap(50,1650,"LGRL"+cSMCOD+cSMFIL+".BMP",550,160)
			ElseIf File("LGRL"+cSMCOD+".BMP")
				oPrint:SayBitMap(50,1650,"LGRL"+cSMCOD+".BMP",550,160)
			ElseIf File("\SIGAADV\LGRL"+cSMCOD+cSMFIL+".BMP")
				oPrint:SayBitMap(50,1650,"\SIGAADV\LGRL"+cSMCOD+cSMFIL+".BMP",550,160)
			ElseIf File("\SIGAADV\LGRL"+cSMCOD+".BMP")
				oPrint:SayBitMap(50,1650,"\SIGAADV\LGRL"+cSMCOD+".BMP",550,160)
			Endif

			For nBold := 1 to 4
				oPrint:Line(lin+nBold,050,lin+nBold,2300)
			Next nBold
			oPrint:Say(lin+15,400,STR0023,oFont15) //"PROGRAMA DE CONTROLE MÉDICO DE SAÚDE OCUPACIONAL"
			oPrint:Line(lin+90,050,lin+90,2300)
			oPrint:Line(lin+91,050,lin+91,2300)
			oPrint:Say(lin+120,50,STR0024,oFont12) //"Unidade:"

			dbSelectArea("SA1")
			dbSetOrder(1)
			dbSeek(xFilial("SA1")+TNC->(TNC_CLIENT+TNC_LOJA))

			oPrint:Say(lin+120,300,Substr(SA1->A1_NOME,1,22),oFont10)
			oPrint:Line(lin+90,850,lin+180,850)
			oPrint:Line(lin+90,851,lin+180,851)
			oPrint:Say(lin+105,900,STR0003,oFont15)	 //"INVESTIGAÇÃO E ANÁLISE DE ACIDENTE"

			oPrint:Line(lin+180,050,lin+180,1900)
			oPrint:Line(lin+181,050,lin+181,1900)
			oPrint:Line(lin+182,050,lin+182,1900)
			oPrint:Line(lin+180,1900,lin+500,1900)
			oPrint:Line(lin+180,1901,lin+500,1901)
			oPrint:Line(lin+180,1902,lin+500,1902)

			oPrint:Line(lin+185,1930,lin+485,1930)
			oPrint:Line(lin+185,2300,lin+485,2300)
			oPrint:Line(lin+180,1935,lin+180,2295)
			oPrint:Line(lin+490,1935,lin+490,2295)
			oPrint:Line(lin+185,1930,lin+180,1935)
			oPrint:Line(lin+185,2300,lin+180,2295)
			oPrint:Line(lin+485,1930,lin+490,1935)
			oPrint:Line(lin+485,2300,lin+490,2295)

			lin := lin-40
			nDIA := DOW(TNC->TNC_DTACID)
			oPrint:Say(lin+235,1940,STR0095,oFont11) //"Nº:"
			oPrint:Say(lin+235,2050,TNC->TNC_ACIDEN,oFont12)
			oPrint:Line(lin+298,1930,lin+298,2300)
			oPrint:Say(lin+303,1940,STR0025,oFont07) //"DATA"
			oPrint:Say(lin+333,1940,Dtoc(TNC->TNC_DTACID),oFont08)
			oPrint:Line(lin+376,1930,lin+376,2300)
			oPrint:Say(lin+381,1940,STR0026,oFont07) //"DIA DA SEMANA"
			If nDIA > 0
				oPrint:Say(lin+411,1940,aSemana[nDIA],oFont08)
			Endif
			oPrint:Line(lin+454,1930,lin+454,2300)
			oPrint:Say(lin+459,1940,STR0027,oFont07) //"HORÁRIO"
			oPrint:Say(lin+489,1940,TNC->TNC_HRACID,oFont08)


			lin := 380
			oPrint:Say(lin+5,60,STR0028,oFont07) //"NOME"
			oPrint:Say(lin+35,60,TM0->TM0_NOMFIC,oFont08)
			oPrint:Line(lin,1500,lin+80,1500)
			oPrint:Say(lin+5,1510,STR0029,oFont07) //"R.G. FUNCIONAL"
			oPrint:Say(lin+35,1510,SRA->RA_RG,oFont08)
			oPrint:Line(lin+80,50,lin+80,1900)

			lin:=460
			cEstCiv := STR0030 //"SOLTEIRO(A)"
			IF SRA->RA_ESTCIVI = "C" ; cEstCiv := STR0031 //"CASADO(A)"
			ELSEIF SRA->RA_ESTCIVI = "D" ; cEstCiv := STR0032 //"DIVORCIADO(A)"
			ELSEIF SRA->RA_ESTCIVI = "M" ; cEstCiv := STR0033 //"MARITAL"
			ELSEIF SRA->RA_ESTCIVI = "Q" ; cEstCiv := STR0034 //"DESQUITADO(A)"
			ELSEIF SRA->RA_ESTCIVI = "S" ; cEstCiv := STR0030 //"SOLTEIRO(A)"
			ELSEIF SRA->RA_ESTCIVI = "V" ; cEstCiv := STR0035 //"VIUVO(A)"
			ENDIF

			cSexo := " "
			IF SRA->RA_SEXO = "M" ; cSexo := STR0036 //"MASCULINO"
			ELSEIF SRA->RA_SEXO = "F" ; cSexo := STR0037 //"FEMININO"
			ENDIF

			oPrint:Say(lin+5,60,STR0038,oFont07) //"DATA DE ADMISSÃO"
			oPrint:Say(lin+35,60,Dtoc(SRA->RA_ADMISSA),oFont08)
			oPrint:Line(lin,450,lin+80,450)
			oPrint:Say(lin+5,460,STR0039,oFont07) //"IDADE"
			oPrint:Say(lin+35,460,U_R735ID(SRA->RA_NASC)+STR0040,oFont08) //" ANOS"
			oPrint:Line(lin,700,lin+80,700)
			oPrint:Say(lin+5,710,STR0041,oFont07)	 //"ESTADO CIVIL"
			oPrint:Say(lin+35,710,cEstCiv,oFont08)
			oPrint:Line(lin,1000,lin+80,1000)
			oPrint:Say(lin+5,1010,STR0042,oFont07)      //"SEXO"
			oPrint:Say(lin+35,1010,cSexo,oFont08)
			oPrint:Line(lin+80,50,lin+80,1900)

			lin:=540
			oPrint:Say(lin+5,60,STR0044,oFont07)	 //"CENTRO DE CUSTO"
			oPrint:Say(lin+35,60,Substr(&cDescr,1,23),oFont08)
			oPrint:Line(lin,500,lin+80,500)
			oPrint:Say(lin+5,510,STR0045,oFont07) //"CARGO"
			oPrint:Say(lin+35,510,Substr(cCargo,1,37),oFont08)
			oPrint:Line(lin+80,50,lin+80,1900)


			lin:=620
			oPrint:Say(lin+5,60,STR0047,oFont07)	 //"FUNÇÃO"
			oPrint:Say(lin+35,60,Substr(SRJ->RJ_DESC,1,37),oFont08)
			oPrint:Line(lin,800,lin+80,800)
			oPrint:Say(lin+5,810,STR0048,oFont07) //"HORÁRIO DE TRABALHO"
			oPrint:Say(lin+35,810,Substr(TNC->TNC_HRRPAD,1,20),oFont08)

			lin:=700
			oPrint:Box(lin,050,lin+60,2300)
			oPrint:Box(lin+1,051,lin+59,2299)
			oPrint:Box(lin+2,052,lin+58,2298)
			oPrint:Box(lin+3,053,lin+57,2297)
			oPrint:Say(lin+10,750,STR0050,oFont14)	 //"PARA USO DA ÁREA DE MEDICINA DO TRABALHO"


			lin:=760

			If TNC->TNC_AFASTA == "1"
				If !U_MDTAFAS735(lGes)
					dDtAfast := TNC->TNC_DTACID
					dDtAlta  := (TNC->TNC_DTACID+TNC->TNC_QTAFAS)-1
					cDiasAf  := TNC->TNC_QTAFAS
					lAfasta := .T.
				EndIf
			Else
				If !U_MDTAFAS735(lGes)
					lAfasta := .F.
				EndIf
			EndIf

			oPrint:Line(lin+160,50,lin+160,2300)
			oPrint:Line(lin,1800,lin+160,1800)
			oPrint:Line(lin+80,1800,lin+80,2300)
			oPrint:Line(lin+160,1700,lin+240,1700)
			oPrint:Line(lin+240,50,lin+240,2300)

			oPrint:Say(lin+5,60,STR0051,oFont06) //"PARTES DO CORPO ATINGIDAS"
			oPrint:Say(lin+50,60,Memoline(TNC->TNC_PARTE,80,1),oFont10)
			oPrint:Say(lin+100,60,Memoline(TNC->TNC_PARTE,80,2),oFont10)
			oPrint:Say(lin+5,1810,STR0052,oFont06) //"DATA DE AFASTAMENTO"
			oPrint:Say(lin+35,1810,Dtoc(dDtAfast),oFont10)
			oPrint:Say(lin+85,1810,STR0053,oFont06) //"DATA DE ALTA"
			oPrint:Say(lin+115,1810,Dtoc(dDtAlta),oFont10)

			oPrint:Say(lin+165,60,STR0054,oFont06) //"AFASTAMENTO"
			oPrint:Line(lin+160,500,lin+240,500)
			oPrint:Say(lin+165,510,STR0055,oFont06) //"TEMPO PROVÁVEL DE AFASTAMENTO"
			If lAfasta
				oPrint:Say(lin+195,60,STR0056,oFont10) //"SIM"
				oPrint:Say(lin+195,510,Alltrim(Str(cDiasAf))+STR0057,oFont10) //" DIAS"
			Else
				oPrint:Say(lin+195,60,STR0058,oFont10) //"NAO"
			Endif
			oPrint:Say(lin+165,1710,STR0059,oFont06) //"COMUNICAÇÃO DE ACIDENTE DO TRABALHO"
			oPrint:Say(lin+195,1710,If(Empty(TNC->TNC_DTEMIS),STR0060,STR0056),oFont10) //"NÃO"###"SIM"


			lin:=1000

			oPrint:Say(lin+5,60,STR0061,oFont06) //"C.I.D. PRINCIPAL:"
			oPrint:Say(lin+08,416,Substr(cCid01,1,80),oFont10)
			oPrint:Line(lin+50,50,lin+50,2300)

			lin:=1050

			oPrint:Say(lin+5,60,STR0062,oFont06)          //"C.I.D. COMPLEMENTAR:"
			oPrint:Say(lin+08,400,MemoLine(cCid02,85,1),oFont10)
			oPrint:Say(lin+43,300,MemoLine(cCid02,85,2),oFont10)
			oPrint:Say(lin+78,300,MemoLine(cCid02,85,3),oFont10)
			oPrint:Say(lin+113,300,MemoLine(cCid02,85,4),oFont10)
			oPrint:Line(lin+170,50,lin+170,2300)

			//lin:=1100

		//	oPrint:Say(lin+5,60,STR0063,oFont06) //"DIAGNÓSTICO PROVISÓRIO"
			//


			lin:=1220

			oPrint:Say(lin+5,60,STR0064,oFont06)  //"DIAGNÓSTICO DEFINITIVO"
			oPrint:Say(lin+50,60,Substr(cDiagnos,1,90),oFont10)
			oPrint:Line(lin+120,50,lin+120,2300)


			lin:=1340

			oPrint:Say(lin+5,60,STR0065,oFont06) //"OBSERVAÇÕES"

			nMemo := MLCOUNT(cObserva,120)
			nMemo := If(nMemo > 10,10,nMemo)

			For nLinha := 1 to nMemo
				If !Empty(Memoline(cObserva,120,nLinha))
					If nLinha == 1
						oPrint:Say(lin+5+(nLinha*40),100,Memoline(cObserva,120,nLinha),oFontxt)
					Else
						oPrint:Say(lin+5+(nLinha*40),60,Memoline(cObserva,120,nLinha),oFontxt)
					Endif
				Endif
			Next nLinha

			oPrint:Line(lin+450,50,lin+450,2300)

			lin:=1790

			oPrint:Say(lin+15,60,STR0096,oFont09) //"Durante o seu tratamento, poderá ser aproveitado em ocupações compatíveis com seu estado de saúde?"
			oPrint:Box(lin+15,2050,lin+45,2080)
			oPrint:Say(lin+15,2090,STR0056,oFont09) //"NÃO"
			oPrint:Box(lin+15,2200,lin+45,2230)
			oPrint:Say(lin+15,2240,STR0060,oFont09)	 //"SIM"
			If NGCADICBASE( "TNC_INDAPR" , "A" , "TNC" , .F. ) .And. TNC->TNC_INDAPR == "1"
				oPrint:Line(lin+15,2050,lin+45,2080)
				oPrint:Line(lin+15,2080,lin+45,2050)
			ElseIf NGCADICBASE( "TNC_INDAPR" , "A" , "TNC" , .F. ) .And. TNC->TNC_INDAPR == "2"
				oPrint:Line(lin+15,2200,lin+45,2230)
				oPrint:Line(lin+15,2230,lin+45,2200)
			Else
				If TNC->TNC_TRANSF == "1"
					oPrint:Line(lin+15,2050,lin+45,2080)
					oPrint:Line(lin+15,2080,lin+45,2050)
				Else
					oPrint:Line(lin+15,2200,lin+45,2230)
					oPrint:Line(lin+15,2230,lin+45,2200)
				Endif
			Endif
			oPrint:Say(lin+75,60,STR0097,oFont09) //"Continua seu tratamento no:"
			oPrint:Say(lin+65,620,Substr(TNC->TNC_LOCATE,1,75),oFont10)
			oPrint:Line(lin+110,610,lin+110,2300)
			oPrint:Say(lin+135,60,STR0098,oFont09) //"Descrição da lesão:"
			oPrint:Say(lin+125,450,Substr(TNC->TNC_DESLES,1,80),oFont10)
			oPrint:Line(lin+170,440,lin+170,2300)


			lin:=1905

			oPrint:Line(lin+160,1700,lin+160,2300)
			oPrint:Say(lin+165,1900,STR0066,oFont09) //"MÉDICO"


			lin:=2120

			oPrint:Box(lin,050,lin+60,2300)
			oPrint:Box(lin+1,051,lin+59,2299)
			oPrint:Box(lin+2,052,lin+58,2298)
			oPrint:Box(lin+3,053,lin+57,2297)
			oPrint:Say(lin+10,750,STR0067,oFont14)	 //"PARA USO DA ÁREA DE SEGURANÇA DO TRABALHO"


			lin:=2180

			oPrint:Say(lin+08,1000,STR0068,oFont14)	 //"DADOS DO ACIDENTE"
			oPrint:Line(lin+50,50,lin+50,2300)


			lin:=2230

			Dbselectarea("SRJ")
			Dbsetorder(1)
			Dbseek(xFilial("SRJ")+TNC->TNC_CODFUN)

			oPrint:Say(lin+05,60,STR0069,oFont06) //"ATIVIDADE EXECUTADA NO ATO DO ACIDENTE"
			oPrint:Say(lin+35,60,SRJ->RJ_DESC,oFont10)
			oPrint:Line(lin+80,50,lin+80,2300)


			lin:=2310

			oPrint:Say(lin+05,60,STR0070,oFont06) //"LOCAL"
			oPrint:Say(lin+35,60,SubStr(TNC->TNC_LOCAL,1,15),oFont10)
			oPrint:Line(lin,600,lin+80,600)
			oPrint:Say(lin+25,610,STR0099,oFont09) //"APÓS ______ HORAS DE TRABALHO."
			oPrint:Say(lin+25,690,Alltrim(Transform(TNC->TNC_HRTRAB,"99:99")),oFont10)
			oPrint:Line(lin,1200,lin+80,1200)
			oPrint:Say(lin+05,1210,STR0071,oFont06) //"RECEBEU TREINAMENTO ?"
			oPrint:Box(lin+35,1210,lin+65,1240)
			oPrint:Say(lin+35,1250,STR0060,oFont09) //"NÃO"
			oPrint:Box(lin+35,1360,lin+65,1390)
			oPrint:Say(lin+35,1400,STR0100,oFont09)	 //"SIM
			If cTreinam != "1"
				oPrint:Line(lin+35,1210,lin+65,1240)
				oPrint:Line(lin+35,1240,lin+65,1210)
			Else
				oPrint:Line(lin+35,1360,lin+65,1390)
				oPrint:Line(lin+35,1390,lin+65,1360)

			Endif
			oPrint:Line(lin+80,50,lin+80,2300)


			lin:=2390

			oPrint:Say(lin+05,60,STR0072,oFont06) //"TIPO ACIDENTE"
			oPrint:Say(lin+35,60,cTipAcid,oFont10)
			oPrint:Line(lin+80,50,lin+80,2300)


			lin:=2470

			oPrint:Say(lin+05,60,STR0073,oFont06)	 //"AGENTE DA LESÃO"
			oPrint:Say(lin+35,60,cAgente,oFont10)
			oPrint:Line(lin+80,50,lin+80,2300)


			lin:=2550

			oPrint:Say(lin+05,60,STR0074,oFont06) //"PARTE ATINGIDA"
			oPrint:Say(lin+35,60,Substr(TNC->TNC_PARTE,1,80),oFont10)
			oPrint:Line(lin+80,50,lin+80,2300)


			lin:=2630

			oPrint:Say(lin+05,60,STR0075,oFont06) //"CAUSAS DO ACIDENTE:"

			dbSelectArea("TNZ")
			dbSetOrder(3)  //TNZ_FILIAL+TNZ_CLIENT+TNZ_LOJA+TNZ_ACIDEN+TNZ_CAUSA
			dbSeek(xFilial("TNZ")+mv_par02+mv_par03+TNC->TNC_ACIDEN)
			While !Eof() .and. xFilial("TNZ")+mv_par02+mv_par03+TNC->TNC_ACIDEN == TNZ->(TNZ_FILIAL+TNZ_CLIENT+TNZ_LOJA+TNZ_ACIDEN)
				AADD(aMemo, SubStr(NgSeek("TND",TNZ->TNZ_CAUSA,1,"TND->TND_NOME"),1,120) )
				dbSelectArea("TNZ")
				dbSkip()
			End

			For nLinha := 1 to Len(aMemo)
				oPrint:Say(lin+5+(nLinha*40),60,aMemo[nLinha],oFontxt)
			Next nLinha

			oPrint:Line(3060,50,3060,2300)
			oPrint:Line(3061,50,3061,2300)
			oPrint:Line(3062,50,3062,2300)
			oPrint:Line(3063,50,3063,2300)

			oPrint:EndPage()


			oPrint:StartPage()

			lin:=200
			oPrint:Box(lin,050,lin+60,2300)
			oPrint:Box(lin+1,051,lin+59,2299)
			oPrint:Box(lin+2,052,lin+58,2298)
			oPrint:Box(lin+3,053,lin+57,2297)
			oPrint:Say(lin+10,750,STR0067,oFont14)	 //"PARA USO DA ÁREA DE SEGURANÇA DO TRABALHO"

			oPrint:Say(lin+65,60,STR0076,oFont06) //"DESCRIÇÃO E ANÁLISE DO ACIDENTE:"

			For xx := 1 to 14
				oPrint:Line(lin+70+(xx*70),120,lin+70+(xx*70),2300)
			Next xx

			nLinha := 1
			dbSelectArea("TNU")
			dbSetOrder(1)  //TNU_FILIAL+TNU_CLIENT+TNU_LOJA+TNU_ACIDEN+TNU_MANDAT
			dbSeek(xFilial("TNU")+mv_par02+mv_par03+TNC->TNC_ACIDEN)
			While !Eof() .and. xFilial("TNU")+mv_par02+mv_par03+TNC->TNC_ACIDEN == TNU->(TNU_FILIAL+TNU_CLIENT+TNU_LOJA+TNU_ACIDEN)
				If nLinha == 1
					cMemo := TNU->TNU_INVEST
				Else
					cMemo += " " + TNU->TNU_INVEST
				Endif
				nLinha ++
				dbSkip()
			End

			nMemo := MLCOUNT(cMemo,120)
			nMemo := If(nMemo > 14,14,nMemo)
			nAux := 40

			For nLinha := 1 to nMemo
				If !Empty(Memoline(cMemo,120,nLinha))
					oPrint:Say(lin+65+nAux,120,Memoline(cMemo,120,nLinha),oFontxt)
					nAux += 70
				Endif
			Next nLinha

			oPrint:Line(lin+1070,50,lin+1070,2300)


			lin := 1270
			oPrint:Line(lin+80,50,lin+80,2300)
			oPrint:Line(lin+20,60,lin+20,2290)
			oPrint:Line(lin+840,60,lin+840,2290)
			oPrint:Line(lin+30,50,lin+830,50)
			oPrint:Line(lin+30,2300,lin+830,2300)//
			oPrint:Line(lin+20,60,lin+30,50)
			oPrint:Line(lin+840,60,lin+830,50)
			oPrint:Line(lin+20,2290,lin+30,2300)
			oPrint:Line(lin+840,2290,lin+830,2300)


			oPrint:Say(lin+30,1000,STR0077,oFont14)	 //"CUSTO DO ACIDENTE"
			oPrint:Line(lin+120,1050,lin+120,2300)
			oPrint:Say(lin+85,1120,STR0078,oFont06) //"MESES"
			oPrint:Line(lin+80,1050,lin+840,1050)
			oPrint:Say(lin+85,1340,STR0079,oFont06) //"VALOR DIÁRIO"
			oPrint:Line(lin+80,1250,lin+840,1250)
			oPrint:Say(lin+85,1718,STR0080,oFont06) //"DIAS"
			oPrint:Line(lin+80,1650,lin+840,1650)
			oPrint:Say(lin+85,1920,STR0081,oFont06) //"VALOR TOTAL DO MÊS"
			oPrint:Line(lin+80,1850,lin+840,1850)

			oPrint:Say(lin+230,70,STR0101,oFont10) //"VALOR DAS HORAS PAGAS - 1º DIA"
			oPrint:Line(lin+260,730,lin+260,1030)
			oPrint:Say(lin+310,70,STR0102,oFont10) //"   VALOR DAS DIÁRIAS RECEBIDAS"
			oPrint:Line(lin+340,730,lin+340,1030)
			oPrint:Say(lin+390,70,STR0103,oFont14) //"                      SUBTOTAL"
			oPrint:Line(lin+420,730,lin+420,1030)
			oPrint:Say(lin+470,70,STR0104,oFont10) //"       VALOR DO CUSTO INDIRETO"
			oPrint:Line(lin+500,730,lin+500,1030)
			oPrint:Say(lin+550,70,STR0105,oFont14) //"                   TOTAL GERAL"
			oPrint:Line(lin+580,730,lin+580,1030)


			For xx := 1 to 11
				If xx = 1
					oPrint:Say(lin+130,1060,aMes[1],oFontxt)
					oPrint:Say(lin+130,1660,"X",oFontxt)
					oPrint:Say(lin+130,1860,"=",oFontxt)
				Endif
				oPrint:Say(lin+130+(xx*60),1060,aMes[1+xx],oFontxt)
				oPrint:Say(lin+130+(xx*60),1660,"X",oFontxt)
				oPrint:Say(lin+130+(xx*60),1860,"=",oFontxt)

				oPrint:Line(lin+120+(xx*60),1050,lin+120+(xx*60),2300)
			Next xx


			lin := 2130
			oPrint:Box(lin,050,lin+60,2300)
			oPrint:Box(lin+1,051,lin+59,2299)
			oPrint:Box(lin+2,052,lin+58,2298)
			oPrint:Box(lin+3,053,lin+57,2297)
			oPrint:Say(lin+10,1020,If(lCipatr, STR0107, STR0082),oFont14) //"PARA USO DA CIPA"

			oPrint:Say(lin+65,60,STR0083,oFont06) //"CAUSA(S) DO ACIDENTE"
			For xx := 1 to 3
				oPrint:Line(lin+70+(xx*50),120,lin+70+(xx*50),2300)
			Next xx
			oPrint:Line(lin+240,50,lin+240,2300)


			lin := 2370
			oPrint:Say(lin+5,60,STR0084,oFont06) //"MEDIDA(S) PROPOSTA(S)"
			For xx := 1 to 3
				oPrint:Line(lin+10+(xx*50),120,lin+10+(xx*50),2300)
			Next xx
			oPrint:Line(lin+180,50,lin+180,2300)


			lin := 2550

			oPrint:Line(lin+150,50,lin+150,1050)
			oPrint:Line(lin+150,1300,lin+150,2300)

			oPrint:Line(lin+145,150,lin+100,155)
			oPrint:Line(lin+145,250,lin+100,255)
			oPrint:Line(lin+145,1400,lin+100,1405)
			oPrint:Line(lin+145,1500,lin+100,1505)

			oPrint:Say(lin+160,450,STR0085,oFont14) //"CIPEIRO"
			oPrint:Say(lin+160,1680,If(lCipatr,STR0086,STR0106),oFont14) //"COORDENADOR"


			lin := 2750
			oPrint:Box(lin,050,lin+60,2300)
			oPrint:Box(lin+1,051,lin+59,2299)
			oPrint:Box(lin+2,052,lin+58,2298)
			oPrint:Box(lin+3,053,lin+57,2297)
			oPrint:Say(lin+10,970,STR0087,oFont14) //"TRAMITAÇÃO E VISTOS"
			lin := 2810


			nSoma := 0
			For xx := 1 to 3
				If xx == 2
					nSoma := 850
					oPrint:Say(lin+15,220+nSoma,STR0088,oFont06)	 //"ÁREA DE PESSOAL"
				Elseif xx = 3
					nSoma := 1650
					oPrint:Say(lin+15,270+nSoma,STR0089,oFont06)	 //"SEGURANÇA"
				Else
					oPrint:Say(lin+15,190,STR0090,oFont06)	 //"MEDICINA DO TRABALHO"
				Endif
				oPrint:Line(lin+50,50+nSoma,lin+50,650+nSoma)
				oPrint:Line(lin+140,50+nSoma,lin+140,650+nSoma)
				oPrint:Line(lin+138,250+nSoma,lin+95,255+nSoma)
				oPrint:Line(lin+138,450+nSoma,lin+95,455+nSoma)

				oPrint:Line(lin+15,50+nSoma,lin+230,50+nSoma)
				oPrint:Line(lin+15,650+nSoma,lin+230,650+nSoma)
				oPrint:Line(lin+10,55+nSoma,lin+10,645+nSoma)
				oPrint:Line(lin+235,55+nSoma,lin+235,645+nSoma)
				oPrint:Line(lin+15,50+nSoma,lin+10,55+nSoma)
				oPrint:Line(lin+15,650+nSoma,lin+10,645+nSoma)
				oPrint:Line(lin+230,50+nSoma,lin+235,55+nSoma)
				oPrint:Line(lin+230,650+nSoma,lin+235,645+nSoma)
			Next xx


			oPrint:Line(3060,50,3060,2300)
			oPrint:Line(3061,50,3061,2300)
			oPrint:Line(3062,50,3062,2300)
			oPrint:Line(3063,50,3063,2300)

			oPrint:EndPage()

		EndIF

	Else

		Dbselectarea("TNC")
		Dbsetorder(1)
		If Dbseek(xFilial("TNC")+Mv_par02)

			Dbselectarea("TM0")
			Dbsetorder(1)
			Dbseek(xFilial("TM0")+TNC->TNC_NUMFIC)
			Dbselectarea("SRA")
			Dbsetorder(1)
			Dbseek(TM0->TM0_FILFUN+TM0->TM0_MAT)
			Dbselectarea(cAlias)
			Dbsetorder(1)
			Dbseek(TM0->TM0_FILFUN+SRA->RA_CC)
			Dbselectarea("SRJ")
			Dbsetorder(1)
			Dbseek(xFilial("SRJ")+SRA->RA_CODFUNC)
			If Empty(SRA->RA_CARGO)
				Dbselectarea("SQ3")
				Dbsetorder(1)
				If Dbseek(xFilial("SQ3")+SRJ->RJ_CARGO)
					cCargo := SQ3->Q3_DESCSUM
				Endif
			Else
				Dbselectarea("SQ3")
				Dbsetorder(1)
				If Dbseek(xFilial("SQ3")+SRA->RA_CARGO)
					cCargo := SQ3->Q3_DESCSUM
				Endif
			Endif
			//
			//Busca Cid Tabela de acidentes
			If !Empty(TNC->TNC_CID)
				DbSelectArea("TMR")
				DbSetOrder(1)
				If DbSeek(xFilial("TMR")+TNC->TNC_CID)
					cCid01 := TMR->TMR_DOENCA
				EndIF
			EndIf
			//
			//Busca Cid Complementar
			Dbselectarea("TKK")
			DbSetOrder(1)
		IF DbSeek(xFilial("TKK")+TNC->TNC_ACIDEN)
				While !Eof() .And. xFilial("TKK")+TNC->TNC_ACIDEN == TKK->(TKK_FILIAL+TKK_ACIDEN)
					DbSelectArea("TMR")
					DbSetOrder(1)
					If DbSeek(xFilial("TMR")+TKK->TKK_CID)
						If !Empty(cCid02)
							cCid02 += ";"
						EndIf
						cCid02 += AllTrim(TMR->TMR_DOENCA)
					EndIf
					DbSelectArea("TKK")
					DbSkip()
			End
		EndIf
			//
			// Busca Tabela de Diagnosticos

			Dbselectarea("TMT")
			DbSetOrder(7)
			If DbSeek(xFilial("TMT")+TNC->TNC_ACIDEN+TNC->TNC_NUMFIC)
				If NGCADICBASE( "TMT_DIASYP" , "A" , "TMT" , .F. )
					cDiagnos := MsMM(TMT->TMT_DIASYP,10)
				Else
					cDiagnos := Alltrim(TMT->TMT_DIAGNO)
				EndIf
					cObserva := Transform(TMT->TMT_OUTROS,"@!")
			If Empty(cCid01)
					//Cid Complementar na tabela de diagnosticos
					If Empty(cCid02)
						DbSelectArea("TKJ")
						DbSetOrder(1)
						If DbSeek(xFilial("TKJ")+TMT->(TMT_NUMFIC+DtoS(TMT_DTCONS)+TMT_HRCONS))
							While !Eof() .And. xFilial("TKJ")+TKJ->(TKJ_NUMFIC+DtoS(TKJ_DTCONS))== TMT->(TMT_FILIAL+TMT_NUMFIC+DtoS(TMT_DTCONS))
								DbSelectArea("TMR")
								DbSetOrder(1)
								If DbSeek(xFilial("TMR")+TKJ->TKJ_CID)
									If !Empty(cCid02)
										cCid02 += ";"
									EndIf
									cCid02 += AllTrim(TMR->TMR_DOENCA)
								EndIf
								DbSelectArea("TKJ")
								DbSkip()
						End
					EndIf
				EndIf
				DbSelectArea("TMR")
					DbSetOrder(1)
					If DbSeek(xFilial("TMR")+TMT->TMT_CID)
						cCid01 := TMR->TMR_DOENCA
					EndIf
			Endif
			EndIf
			//
			Dbselectarea("TNG")
			DbSetOrder(1)
			If DbSeek(xFilial("TNG")+TNC->TNC_TIPACI)
				cTipAcid := Substr(TNG->TNG_DESTIP,1,80)
			Endif
			Dbselectarea("TNH")
			DbSetOrder(1)
			If DbSeek(xFilial("TNH")+TNC->TNC_CODOBJ)
				cAgente := Substr(TNH->TNH_DESOBJ,1,80)
			Endif

			dDtInv	:= StoD( Space( 8 ) )
			cFiltro := 'TNU_FILIAL =="'  + xFilial("TNU")  + '".And.'
			cFiltro += 'TNU_ACIDEN =="'  + TNC->TNC_ACIDEN + '"'

			dbSelectArea( "TNU" )
			Set Filter To &( cFiltro )
			dbGoTop()
			If TNU->( !Eof() )
				If TNU->TNU_DTINVE > dDtInv
					cTreinam := TNU->TNU_TREINA
					cTreiner := SubStr(NgSeek("TMK",TNU->TNU_RESINV,1,"TMK->TMK_NOMUSU"),1,25)
					dDtInv 	 := TNU->TNU_DTINVE
				EndIf
			End

			dbSelectArea( "TNU" )
			Set Filter To

			oPrint:StartPage() //Inicia nova pagina
			lin := 200

			If File("LGRL"+cSMCOD+cSMFIL+".BMP")
				oPrint:SayBitMap(50,1650,"LGRL"+cSMCOD+cSMFIL+".BMP",550,160)
			ElseIf File("LGRL"+cSMCOD+".BMP")
				oPrint:SayBitMap(50,1650,"LGRL"+cSMCOD+".BMP",550,160)
			ElseIf File("\SIGAADV\LGRL"+cSMCOD+cSMFIL+".BMP")
				oPrint:SayBitMap(50,1650,"\SIGAADV\LGRL"+cSMCOD+cSMFIL+".BMP",550,160)
			ElseIf File("\SIGAADV\LGRL"+cSMCOD+".BMP")
				oPrint:SayBitMap(50,1650,"\SIGAADV\LGRL"+cSMCOD+".BMP",550,160)
			Endif

			For nBold := 1 to 4
				oPrint:Line(lin+nBold,050,lin+nBold,2300)
			Next nBold
			oPrint:Say(lin+15,400,STR0023,oFont15) //"PROGRAMA DE CONTROLE MÉDICO DE SAÚDE OCUPACIONAL"
			oPrint:Line(lin+90,050,lin+90,2300)
			oPrint:Line(lin+91,050,lin+91,2300)
			oPrint:Say(lin+120,50,STR0024,oFont12) //"Unidade:"
			oPrint:Say(lin+120,300,Substr(SM0->M0_NOMECOM,1,22),oFont10)
			oPrint:Line(lin+90,850,lin+180,850)
			oPrint:Line(lin+90,851,lin+180,851)
			oPrint:Say(lin+105,900,STR0003,oFont15)	 //"INVESTIGAÇÃO E ANÁLISE DE ACIDENTE"

			oPrint:Line(lin+180,050,lin+180,1900)
			oPrint:Line(lin+181,050,lin+181,1900)
			oPrint:Line(lin+182,050,lin+182,1900)
			oPrint:Line(lin+180,1900,lin+500,1900)
			oPrint:Line(lin+180,1901,lin+500,1901)
			oPrint:Line(lin+180,1902,lin+500,1902)

			oPrint:Line(lin+185,1930,lin+485,1930)
			oPrint:Line(lin+185,2300,lin+485,2300)
			oPrint:Line(lin+180,1935,lin+180,2295)
			oPrint:Line(lin+490,1935,lin+490,2295)
			oPrint:Line(lin+185,1930,lin+180,1935)
			oPrint:Line(lin+185,2300,lin+180,2295)
			oPrint:Line(lin+485,1930,lin+490,1935)
			oPrint:Line(lin+485,2300,lin+490,2295)

			lin := lin-40
			nDIA := DOW(TNC->TNC_DTACID)
			oPrint:Say(lin+235,1940,STR0095,oFont11) //"Nº:"
			oPrint:Say(lin+235,2050,TNC->TNC_ACIDEN,oFont12)
			oPrint:Line(lin+298,1930,lin+298,2300)
			oPrint:Say(lin+303,1940,STR0025,oFont07) //"DATA"
			oPrint:Say(lin+333,1940,Dtoc(TNC->TNC_DTACID),oFont08)
			oPrint:Line(lin+376,1930,lin+376,2300)
			oPrint:Say(lin+381,1940,STR0026,oFont07) //"DIA DA SEMANA"
			If nDIA > 0
				oPrint:Say(lin+411,1940,aSemana[nDIA],oFont08)
			Endif
			oPrint:Line(lin+454,1930,lin+454,2300)
			oPrint:Say(lin+459,1940,STR0027,oFont07) //"HORÁRIO"
			oPrint:Say(lin+489,1940,TNC->TNC_HRACID,oFont08)


			lin := 380
			oPrint:Say(lin+5,60,STR0028,oFont07) //"NOME"
			oPrint:Say(lin+35,60,TM0->TM0_NOMFIC,oFont08)
			oPrint:Line(lin,1500,lin+80,1500)
			oPrint:Say(lin+5,1510,STR0029,oFont07) //"R.G. FUNCIONAL"
			oPrint:Say(lin+35,1510,SRA->RA_RG,oFont08)
			oPrint:Line(lin+80,50,lin+80,1900)

			lin:=460
			cEstCiv := STR0030 //"SOLTEIRO(A)"
			IF SRA->RA_ESTCIVI = "C" ; cEstCiv := STR0031 //"CASADO(A)"
			ELSEIF SRA->RA_ESTCIVI = "D" ; cEstCiv := STR0032 //"DIVORCIADO(A)"
			ELSEIF SRA->RA_ESTCIVI = "M" ; cEstCiv := STR0033 //"MARITAL"
			ELSEIF SRA->RA_ESTCIVI = "Q" ; cEstCiv := STR0034 //"DESQUITADO(A)"
			ELSEIF SRA->RA_ESTCIVI = "S" ; cEstCiv := STR0030 //"SOLTEIRO(A)"
			ELSEIF SRA->RA_ESTCIVI = "V" ; cEstCiv := STR0035 //"VIUVO(A)"
			ENDIF

			cSexo := " "
			IF SRA->RA_SEXO = "M" ; cSexo := STR0036 //"MASCULINO"
			ELSEIF SRA->RA_SEXO = "F" ; cSexo := STR0037 //"FEMININO"
			ENDIF

			oPrint:Say(lin+5,60,STR0038,oFont07) //"DATA DE ADMISSÃO"
			oPrint:Say(lin+35,60,Dtoc(SRA->RA_ADMISSA),oFont08)
			oPrint:Line(lin,450,lin+80,450)
			oPrint:Say(lin+5,460,STR0039,oFont07) //"IDADE"
			oPrint:Say(lin+35,460,U_R735ID(SRA->RA_NASC)+STR0040,oFont08) //" ANOS"
			oPrint:Line(lin,700,lin+80,700)
			oPrint:Say(lin+5,710,STR0041,oFont07)	 //"ESTADO CIVIL"
			oPrint:Say(lin+35,710,cEstCiv,oFont08)
			oPrint:Line(lin,1000,lin+80,1000)
			oPrint:Say(lin+5,1010,STR0042,oFont07)      //"SEXO"
			oPrint:Say(lin+35,1010,cSexo,oFont08)
			oPrint:Line(lin+80,50,lin+80,1900)

			lin:=540
			oPrint:Say(lin+5,60,STR0044,oFont07)	 //"CENTRO DE CUSTO"
			oPrint:Say(lin+35,60,Substr(&cDescr,1,23),oFont08)
			oPrint:Line(lin,500,lin+80,500)
			oPrint:Say(lin+5,510,STR0045,oFont07) //"CARGO"
			oPrint:Say(lin+35,510,Substr(cCargo,1,37),oFont08)
			oPrint:Line(lin+80,50,lin+80,1900)


			lin:=620
			oPrint:Say(lin+5,60,STR0047,oFont07)	 //"FUNÇÃO"
			oPrint:Say(lin+35,60,Substr(SRJ->RJ_DESC,1,37),oFont08)
			oPrint:Line(lin,800,lin+80,800)
			oPrint:Say(lin+5,810,STR0048,oFont07) //"HORÁRIO DE TRABALHO"
			oPrint:Say(lin+35,810,Substr(TNC->TNC_HRRPAD,1,20),oFont08)

			lin:=700
			oPrint:Box(lin,050,lin+60,2300)
			oPrint:Box(lin+1,051,lin+59,2299)
			oPrint:Box(lin+2,052,lin+58,2298)
			oPrint:Box(lin+3,053,lin+57,2297)
			oPrint:Say(lin+10,750,STR0050,oFont14)	 //"PARA USO DA ÁREA DE MEDICINA DO TRABALHO"


			lin:=760

			If TNC->TNC_AFASTA == "1"
				If !U_MDTAFAS735(lGes)
					dDtAfast := TNC->TNC_DTACID
					dDtAlta  := (TNC->TNC_DTACID+TNC->TNC_QTAFAS) - 1
					cDiasAf  := TNC->TNC_QTAFAS
					lAfasta := .T.
				EndIf
			Else
				If !U_MDTAFAS735(lGes)
					lAfasta := .F.
				EndIf
			EndIf

			oPrint:Line(lin+160,50,lin+160,2300)
			oPrint:Line(lin,1800,lin+160,1800)
			oPrint:Line(lin+80,1800,lin+80,2300)
			oPrint:Line(lin+160,1700,lin+240,1700)
			oPrint:Line(lin+240,50,lin+240,2300)

			oPrint:Say(lin+5,60,STR0051,oFont06) //"PARTES DO CORPO ATINGIDAS"
			oPrint:Say(lin+50,60,Memoline(TNC->TNC_PARTE,80,1),oFont10)
			oPrint:Say(lin+100,60,Memoline(TNC->TNC_PARTE,80,2),oFont10)
			oPrint:Say(lin+5,1810,STR0052,oFont06) //"DATA DE AFASTAMENTO"
			oPrint:Say(lin+35,1810,Dtoc(dDtAfast),oFont10)
			oPrint:Say(lin+85,1810,STR0053,oFont06) //"DATA DE ALTA"
			oPrint:Say(lin+115,1810,Dtoc(dDtAlta),oFont10)

			oPrint:Say(lin+165,60,STR0054,oFont06) //"AFASTAMENTO"
			oPrint:Line(lin+160,500,lin+240,500)
			oPrint:Say(lin+165,510,STR0055,oFont06) //"TEMPO PROVÁVEL DE AFASTAMENTO"
			If lAfasta
				oPrint:Say(lin+195,60,STR0056,oFont10) //"SIM"
				oPrint:Say(lin+195,510,Alltrim(Str(cDiasAf))+STR0057,oFont10) //" DIAS"
			Else
				oPrint:Say(lin+195,60,STR0058,oFont10) //"NAO"
			Endif
			oPrint:Say(lin+165,1710,STR0059,oFont06) //"COMUNICAÇÃO DE ACIDENTE DO TRABALHO"
			oPrint:Say(lin+195,1710,If(Empty(TNC->TNC_DTEMIS),STR0060,STR0056),oFont10) //"NÃO"###"SIM"


			lin:=1000

			oPrint:Say(lin+5,60,STR0061,oFont06) //"C.I.D. PRINCIPAL:"
			oPrint:Say(lin+08,416,Substr(cCid01,1,80),oFont10)
			oPrint:Line(lin+50,50,lin+50,2300)

			lin:=1050

			oPrint:Say(lin+5,60,STR0062,oFont06)          //"C.I.D. COMPLEMENTAR:"
			oPrint:Say(lin+08,400,MemoLine(cCid02,85,1),oFont10)
			oPrint:Say(lin+43,300,MemoLine(cCid02,85,2),oFont10)
			oPrint:Say(lin+78,300,MemoLine(cCid02,85,3),oFont10)
			oPrint:Say(lin+113,300,MemoLine(cCid02,85,4),oFont10)
			oPrint:Line(lin+170,50,lin+170,2300)

			lin:=1220

			oPrint:Say(lin+5,60,STR0064,oFont06)  //"DIAGNÓSTICO DEFINITIVO"
			oPrint:Say(lin+50,60,Substr(cDiagnos,1,90),oFont10)
			oPrint:Line(lin+120,50,lin+120,2300)


			lin:=1340

			oPrint:Say(lin+5,60,STR0065,oFont06) //"OBSERVAÇÕES"

			nMemo := MLCOUNT(cObserva,120)
			nMemo := If(nMemo > 10,10,nMemo)

			For nLinha := 1 to nMemo
				If !Empty(Memoline(cObserva,120,nLinha))
					If nLinha == 1
						oPrint:Say(lin+5+(nLinha*40),100,Memoline(cObserva,120,nLinha),oFontxt)
					Else
						oPrint:Say(lin+5+(nLinha*40),60,Memoline(cObserva,120,nLinha),oFontxt)
					Endif
				Endif
			Next nLinha

			oPrint:Line(lin+450,50,lin+450,2300)

			lin:=1790

			oPrint:Say(lin+15,60,STR0096,oFont09) //"Durante o seu tratamento, poderá ser aproveitado em ocupações compatíveis com seu estado de saúde?"
			oPrint:Box(lin+15,2050,lin+45,2080)
			oPrint:Say(lin+15,2090,STR0056,oFont09) //"NÃO"
			oPrint:Box(lin+15,2200,lin+45,2230)
			oPrint:Say(lin+15,2240,STR0060,oFont09)	 //"SIM"
			If NGCADICBASE( "TNC_INDAPR" , "A" , "TNC" , .F. ) .And. TNC->TNC_INDAPR == "1"
				oPrint:Line(lin+15,2050,lin+45,2080)
				oPrint:Line(lin+15,2080,lin+45,2050)
			ElseIf NGCADICBASE( "TNC_INDAPR" , "A" , "TNC" , .F. ) .And. TNC->TNC_INDAPR == "2"
				oPrint:Line(lin+15,2200,lin+45,2230)
				oPrint:Line(lin+15,2230,lin+45,2200)
			Else
				If TNC->TNC_TRANSF == "1"
					oPrint:Line(lin+15,2050,lin+45,2080)
					oPrint:Line(lin+15,2080,lin+45,2050)
				Else
					oPrint:Line(lin+15,2200,lin+45,2230)
					oPrint:Line(lin+15,2230,lin+45,2200)
				Endif
			Endif
			oPrint:Say(lin+75,60,STR0097,oFont09) //"Continua seu tratamento no:"
			oPrint:Say(lin+65,620,Substr(TNC->TNC_LOCATE,1,75),oFont10)
			oPrint:Line(lin+110,610,lin+110,2300)
			oPrint:Say(lin+135,60,STR0098,oFont09) //"Descrição da lesão:"
			oPrint:Say(lin+125,450,Substr(TNC->TNC_DESLES,1,80),oFont10)
			oPrint:Line(lin+170,440,lin+170,2300)


			lin:=1905

			oPrint:Line(lin+160,1700,lin+160,2300)
			oPrint:Say(lin+165,1900,STR0066,oFont09) //"MÉDICO"


			lin:=2120

			oPrint:Box(lin,050,lin+60,2300)
			oPrint:Box(lin+1,051,lin+59,2299)
			oPrint:Box(lin+2,052,lin+58,2298)
			oPrint:Box(lin+3,053,lin+57,2297)
			oPrint:Say(lin+10,750,STR0067,oFont14)	 //"PARA USO DA ÁREA DE SEGURANÇA DO TRABALHO"


			lin:=2180

			oPrint:Say(lin+08,1000,STR0068,oFont14)	 //"DADOS DO ACIDENTE"
			oPrint:Line(lin+50,50,lin+50,2300)


			lin:=2230

			Dbselectarea("SRJ")
			Dbsetorder(1)
			Dbseek(xFilial("SRJ")+TNC->TNC_CODFUN)

			oPrint:Say(lin+05,60,STR0069,oFont06) //"ATIVIDADE EXECUTADA NO ATO DO ACIDENTE"
			oPrint:Say(lin+35,60,SRJ->RJ_DESC,oFont10)
			oPrint:Line(lin+80,50,lin+80,2300)


			lin:=2310

			oPrint:Say(lin+05,60,STR0070,oFont06) //"LOCAL"
			oPrint:Say(lin+35,60,SubStr(TNC->TNC_LOCAL,1,15),oFont10)
			oPrint:Line(lin,600,lin+80,600)
			oPrint:Say(lin+25,610,STR0099,oFont09) //"APÓS ______ HORAS DE TRABALHO."
			oPrint:Say(lin+25,690,Alltrim(Transform(TNC->TNC_HRTRAB,"99:99")),oFont10)
			oPrint:Line(lin,1200,lin+80,1200)
			oPrint:Say(lin+05,1210,STR0071,oFont06) //"RECEBEU TREINAMENTO ?"
			oPrint:Box(lin+35,1210,lin+65,1240)
			oPrint:Say(lin+35,1250,STR0060,oFont09) //"NÃO"
			oPrint:Box(lin+35,1360,lin+65,1390)
			oPrint:Say(lin+35,1400,STR0100,oFont09)
			If cTreinam != "1"
				oPrint:Line(lin+35,1210,lin+65,1240)
				oPrint:Line(lin+35,1240,lin+65,1210)
			Else
				oPrint:Line(lin+35,1360,lin+65,1390)
				oPrint:Line(lin+35,1390,lin+65,1360)
			Endif
			oPrint:Line(lin+80,50,lin+80,2300)


			lin:=2390

			oPrint:Say(lin+05,60,STR0072,oFont06) //"TIPO ACIDENTE"
			oPrint:Say(lin+35,60,cTipAcid,oFont10)
			oPrint:Line(lin+80,50,lin+80,2300)


			lin:=2470

			oPrint:Say(lin+05,60,STR0073,oFont06)	 //"AGENTE DA LESÃO"
			oPrint:Say(lin+35,60,cAgente,oFont10)
			oPrint:Line(lin+80,50,lin+80,2300)


			lin:=2550

			oPrint:Say(lin+05,60,STR0074,oFont06) //"PARTE ATINGIDA"
			oPrint:Say(lin+35,60,Substr(TNC->TNC_PARTE,1,80),oFont10)
			oPrint:Line(lin+80,50,lin+80,2300)


			lin:=2630

			oPrint:Say(lin+05,60,STR0075,oFont06) //"CAUSAS DO ACIDENTE:"

			dbSelectArea("TNZ")
			dbSetOrder(1)  //TNZ_FILIAL+TNZ_ACIDEN+TNZ_CAUSA
			dbSeek(xFilial("TNZ")+TNC->TNC_ACIDEN)
			While !Eof() .and. xFilial("TNZ")+TNC->TNC_ACIDEN == TNZ->(TNZ_FILIAL+TNZ_ACIDEN)
				AADD(aMemo, SubStr(NgSeek("TND",TNZ->TNZ_CAUSA,1,"TND->TND_NOME"),1,120) )
				dbSelectArea("TNZ")
				dbSkip()
			End

			For nLinha := 1 to Len(aMemo)
				oPrint:Say(lin+5+(nLinha*40),60,aMemo[nLinha],oFontxt)
			Next nLinha

			oPrint:Line(3060,50,3060,2300)
			oPrint:Line(3061,50,3061,2300)
			oPrint:Line(3062,50,3062,2300)
			oPrint:Line(3063,50,3063,2300)

			oPrint:EndPage()


			oPrint:StartPage()

			lin:=200
			oPrint:Box(lin,050,lin+60,2300)
			oPrint:Box(lin+1,051,lin+59,2299)
			oPrint:Box(lin+2,052,lin+58,2298)
			oPrint:Box(lin+3,053,lin+57,2297)
			oPrint:Say(lin+10,750,STR0067,oFont14)	 //"PARA USO DA ÁREA DE SEGURANÇA DO TRABALHO"

			oPrint:Say(lin+65,60,STR0076,oFont06) //"DESCRIÇÃO E ANÁLISE DO ACIDENTE:"

			For xx := 1 to 14
				oPrint:Line(lin+70+(xx*70),120,lin+70+(xx*70),2300)
			Next xx

			nLinha := 1
			dbSelectArea("TNU")
			dbSetOrder(1)  //TNU_FILIAL+TNU_ACIDEN+TNU_MANDAT
			dbSeek(xFilial("TNU")+TNC->TNC_ACIDEN)
			While !Eof() .and. xFilial("TNU")+TNC->TNC_ACIDEN == TNU->(TNU_FILIAL+TNU_ACIDEN)
				If nLinha == 1
					cMemo := TNU->TNU_INVEST
				Else
					cMemo += " " + TNU->TNU_INVEST
				Endif
				nLinha ++
				dbSkip()
			End

			nMemo := MLCOUNT(cMemo,120)
			nMemo := If(nMemo > 14,14,nMemo)
			nAux := 40

			For nLinha := 1 to nMemo
				If !Empty(Memoline(cMemo,120,nLinha))
					oPrint:Say(lin+65+nAux,120,Memoline(cMemo,120,nLinha),oFontxt)
					nAux += 70
				Endif
			Next nLinha

			oPrint:Line(lin+1070,50,lin+1070,2300)


			lin := 1270
			oPrint:Line(lin+80,50,lin+80,2300)
			oPrint:Line(lin+20,60,lin+20,2290)
			oPrint:Line(lin+840,60,lin+840,2290)
			oPrint:Line(lin+30,50,lin+830,50)
			oPrint:Line(lin+30,2300,lin+830,2300)//
			oPrint:Line(lin+20,60,lin+30,50)
			oPrint:Line(lin+840,60,lin+830,50)
			oPrint:Line(lin+20,2290,lin+30,2300)
			oPrint:Line(lin+840,2290,lin+830,2300)


			oPrint:Say(lin+30,1000,STR0077,oFont14)	 //"CUSTO DO ACIDENTE"
			oPrint:Line(lin+120,1050,lin+120,2300)
			oPrint:Say(lin+85,1120,STR0078,oFont06) //"MESES"
			oPrint:Line(lin+80,1050,lin+840,1050)
			oPrint:Say(lin+85,1340,STR0079,oFont06) //"VALOR DIÁRIO"
			oPrint:Line(lin+80,1250,lin+840,1250)
			oPrint:Say(lin+85,1718,STR0080,oFont06) //"DIAS"
			oPrint:Line(lin+80,1650,lin+840,1650)
			oPrint:Say(lin+85,1920,STR0081,oFont06) //"VALOR TOTAL DO MÊS"
			oPrint:Line(lin+80,1850,lin+840,1850)

			oPrint:Say(lin+230,70,STR0101,oFont10) //"VALOR DAS HORAS PAGAS - 1º DIA"
			oPrint:Line(lin+260,730,lin+260,1030)
			oPrint:Say(lin+310,70,STR0102,oFont10) //"   VALOR DAS DIÁRIAS RECEBIDAS"
			oPrint:Line(lin+340,730,lin+340,1030)
			oPrint:Say(lin+390,70,STR0103,oFont14) //"                      SUBTOTAL"
			oPrint:Line(lin+420,730,lin+420,1030)
			oPrint:Say(lin+470,70,STR0104,oFont10) //"       VALOR DO CUSTO INDIRETO"
			oPrint:Line(lin+500,730,lin+500,1030)
			oPrint:Say(lin+550,70,STR0105,oFont14) //"                   TOTAL GERAL"
			oPrint:Line(lin+580,730,lin+580,1030)


			For xx := 1 to 11
				If xx = 1
					oPrint:Say(lin+130,1060,aMes[1],oFontxt)
					oPrint:Say(lin+130,1660,"X",oFontxt)
					oPrint:Say(lin+130,1860,"=",oFontxt)
				Endif
				oPrint:Say(lin+130+(xx*60),1060,aMes[1+xx],oFontxt)
				oPrint:Say(lin+130+(xx*60),1660,"X",oFontxt)
				oPrint:Say(lin+130+(xx*60),1860,"=",oFontxt)

				oPrint:Line(lin+120+(xx*60),1050,lin+120+(xx*60),2300)
			Next xx


			lin := 2130
			oPrint:Box(lin,050,lin+60,2300)
			oPrint:Box(lin+1,051,lin+59,2299)
			oPrint:Box(lin+2,052,lin+58,2298)
			oPrint:Box(lin+3,053,lin+57,2297)
			oPrint:Say(lin+10,1020,If(lCipatr, STR0107, STR0082),oFont14) //"PARA USO DA CIPA"

			oPrint:Say(lin+65,60,STR0083,oFont06) //"CAUSA(S) DO ACIDENTE"
			For xx := 1 to 3
				oPrint:Line(lin+70+(xx*50),120,lin+70+(xx*50),2300)
			Next xx
			oPrint:Line(lin+240,50,lin+240,2300)


			lin := 2370
			oPrint:Say(lin+5,60,STR0084,oFont06) //"MEDIDA(S) PROPOSTA(S)"
			For xx := 1 to 3
				oPrint:Line(lin+10+(xx*50),120,lin+10+(xx*50),2300)
			Next xx
			oPrint:Line(lin+180,50,lin+180,2300)


			lin := 2550

			oPrint:Line(lin+150,50,lin+150,1050)
			oPrint:Line(lin+150,1300,lin+150,2300)

			oPrint:Line(lin+145,150,lin+100,155)
			oPrint:Line(lin+145,250,lin+100,255)
			oPrint:Line(lin+145,1400,lin+100,1405)
			oPrint:Line(lin+145,1500,lin+100,1505)

			oPrint:Say(lin+160,450,STR0085,oFont14) //"CIPEIRO"
			oPrint:Say(lin+160,1680,If(lCipatr,STR0086,STR0106),oFont14) //"COORDENADOR"


			lin := 2750
			oPrint:Box(lin,050,lin+60,2300)
			oPrint:Box(lin+1,051,lin+59,2299)
			oPrint:Box(lin+2,052,lin+58,2298)
			oPrint:Box(lin+3,053,lin+57,2297)
			oPrint:Say(lin+10,970,STR0087,oFont14) //"TRAMITAÇÃO E VISTOS"
			lin := 2810


			nSoma := 0
			For xx := 1 to 3
				If xx == 2
					nSoma := 850
					oPrint:Say(lin+15,220+nSoma,STR0088,oFont06)	 //"ÁREA DE PESSOAL"
				Elseif xx = 3
					nSoma := 1650
					oPrint:Say(lin+15,270+nSoma,STR0089,oFont06)	 //"SEGURANÇA"
				Else
					oPrint:Say(lin+15,190,STR0090,oFont06)	 //"MEDICINA DO TRABALHO"
				Endif
				oPrint:Line(lin+50,50+nSoma,lin+50,650+nSoma)
				oPrint:Line(lin+140,50+nSoma,lin+140,650+nSoma)
				oPrint:Line(lin+138,250+nSoma,lin+95,255+nSoma)
				oPrint:Line(lin+138,450+nSoma,lin+95,455+nSoma)

				oPrint:Line(lin+15,50+nSoma,lin+230,50+nSoma)
				oPrint:Line(lin+15,650+nSoma,lin+230,650+nSoma)
				oPrint:Line(lin+10,55+nSoma,lin+10,645+nSoma)
				oPrint:Line(lin+235,55+nSoma,lin+235,645+nSoma)
				oPrint:Line(lin+15,50+nSoma,lin+10,55+nSoma)
				oPrint:Line(lin+15,650+nSoma,lin+10,645+nSoma)
				oPrint:Line(lin+230,50+nSoma,lin+235,55+nSoma)
				oPrint:Line(lin+230,650+nSoma,lin+235,645+nSoma)
			Next xx


			oPrint:Line(3060,50,3060,2300)
			oPrint:Line(3061,50,3061,2300)
			oPrint:Line(3062,50,3062,2300)
			oPrint:Line(3063,50,3063,2300)

			oPrint:EndPage()

		EndIF

	Endif

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} R735ID

Calcula a idade do funcionario

@author  Denis Hyroshi de Souza
@since   02/04/2003

@sample  U_R735ID(SRA->RA_NASC)

@param   dNasc, Data, Data de nascimento usada para calcular a idade
@param   dFim, Data, Data de fim do período para o calculo da idade,
                     caso vazia é considerada a data atual

@return  Data, Idade calculada de acordo com os parametros, em até 3 digitos
/*/
//-------------------------------------------------------------------
User Function R735ID(dNasc,dFim)

	Local nIdade := 0

	If dFim == nil
		dFim := Date()
	Endif

	nIdade := Year(dFim) - Year(dNasc)

	If Month(dFim) < Month(dNasc)
		nIdade := nIdade - 1
	Elseif Month(dFim) == Month(dNasc)

		If Day(dFim) < Day(dNasc)
			nIdade := nIdade - 1
		Endif

	Endif

Return Alltrim(Str(nIdade,3))

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTAFAS735

Procura por periodos de afastamento

@author  Pedro Cardoso Furst
@since   22/02/2012

@sample  U_MDTAFAS735(.T.)

@param   lGes, Lógico, Define se o períodos serão calculados de acordo com a SR8 ou a TNY

@return  return_type, return_descr
/*/
//-------------------------------------------------------------------
User Function MDTAFAS735(lGes)
	Local aArea := GetArea()

	If lGes
		Dbselectarea("SR8")
		Dbsetorder(1)

		If Dbseek(xFilial("SR8")+SRA->RA_MAT)

			While !eof() .and. xFilial("SR8") == SR8->R8_FILIAL .and. SRA->RA_MAT == SR8->R8_MAT

				If SR8->R8_DATAINI >= TNC->TNC_DTACID .and. SR8->R8_DATAINI <= (TNC->TNC_DTACID+5)
					dDtAfast := SR8->R8_DATAINI
					dDtAlta  := SR8->R8_DATAFIM
					cDiasAf  := If(!Empty(SR8->R8_DATAFIM),SR8->R8_DATAFIM,dDataBase)-(SR8->R8_DATAINI)+1
					lAfasta  := .T.
					Exit
				Endif

				Dbselectarea("SR8")
				Dbskip()
			End

			Restarea(aArea)
			Return .T.
		EndIf

	EndIf

	Dbselectarea("TNY")
	Dbsetorder(1)

	If Dbseek(xFilial("TNY")+TM0->TM0_NUMFIC)

		While !eof() .and. xFilial("TNY") == TNY->TNY_FILIAL .and. TM0->TM0_NUMFIC == TNY->TNY_NUMFIC

			If TNY->TNY_DTINIC >= TNC->TNC_DTACID .and. TNY->TNY_DTINIC <= (TNC->TNC_DTACID+5)
				dDtAfast := TNY->TNY_DTINIC
				dDtAlta  := TNY->TNY_DTFIM
				cDiasAf  := If(!Empty(TNY->TNY_DTFIM),TNY->TNY_DTFIM,dDataBase)-(TNY->TNY_DTINIC)+1
				lAfasta  := .T.
				Exit
			Endif

			Dbselectarea("TNY")
			Dbskip()
		End

		Return .T.
	EndIf

	Restarea(aArea)
Return .F.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT735VL01
Valida o cliente (no mod prestador)
@author  Andre E. P. Alvarez
@since   12/12/2007
@sample  U_MDT735VL01(1)
@param   nTipo, Numérico, Define qual parâmetro será validado
@return  Lógico, Sempre .T.
/*/
//-------------------------------------------------------------------
User Function MDT735VL01(nTipo)
	Local nTa1 := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
	Local nTa1L := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
	Default nTipo := 1

	If nTipo == 1 .and. Empty(mv_par02)
		NaoVazio(mv_par02)
		Return .F.
	ElseIf nTipo == 2 .and. Empty(mv_par03)
		NaoVazio(mv_par03)
		Return .F.
	Endif

	If !ValCli(nTipo,mv_par02,'mv_par03',mv_par02,'mv_par03',nTa1,nTa1L)
		Return .F.
	Endif

Return .T.