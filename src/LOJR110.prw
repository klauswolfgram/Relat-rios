/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "LOJR110.CH"

#INCLUDE "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³  DATA  ³ BOPS ³Program.³    ALTERACAO                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³03/12/01³065364³Edilson ³Implementacao na tela de opcoes de impressao  ³±±
±±³        ³      ³        ³onde o sistema passa a apresentar a opcao de  ³±±
±±³        ³      ³        ³formato de impressao setada como Retrato.     ³±±
±±ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

/*/ 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ LOJR110	³ Autor ³ Mario Angelo		    ³ Data ³ 12.01.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Reemissao de Nota Fiscal		     					      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_LOJR110(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÂÄÁÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³  DATA  ³ BOPS ³Program.³    ALTERACAO                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³10/10/01³086743³Adrianne³Implementacao do posicionamento correto da re-³±±
±±³        ³      ³        ³emissao no caso de NF para Cupom Fiscal.      ³±±
±±³16/02/07³119101³Norbert ³Ajuste na leitura do campo F2_NFCUPOM, para   ³±±
±±³        ³      ³        ³compatibilizacao com o SINIEF.                ³±±
±±³20/04/07³122547³Fernando³Corrigido o controle de impressão de NF		  ³±±
±±³        ³      ³        ³para localizações                             ³±±
±±ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LojR110(cNfEntrada,cSerEntrada,aDadosTefNf,aBreakNota)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis 										     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local CbTxt,cbcont,wnrel
Local lOk	   		:= .T.  
Local lRet			:= .T.
Local cMV_SCRNOTA	:= AllTrim(GetMV("MV_SCRNOTA"))                                                     // Conteúdo do parâmetro MV_SCRNOTA
Local cTitulo  	 	:= IIf(cPaisLoc!="SAL",STR0001,STR0009)  											// Reemiss„o de Notas Fiscais
Local cDesc1 	  	:= IIf(cPaisLoc!="SAL",STR0002,STR0010)  											// Este programa tem a fun‡„o de reemitir Notas Fiscais que nao
Local cDesc2	   	:= STR0003  														   				// foram Geradas quando da Venda. Para tanto, ser  utilizado o
Local cDesc3	   	:= IIf(cPaisLoc!="SAL",STR0004,STR0011) + cMV_SCRNOTA + ")"		  				//"script de Nota Fiscal gravado no Parametro MV_SCRNOTA ("
Local cString  		:= "SL1"                                                                            //Variavel contendo a string "SL1"
Local nReg			:= 0
Local nOrd			:= 0
Local cPorta		:= IIf(ExistBlock("LJPORTNF"),ExecBlock("LJPORTNF",.F.,.F.),GetMv("MV_PORTNOT"))
Local cProgOri		:= AllTrim(FunName())
LocaL lTroca		:= .F.
Local lProg   		:= cProgOri$"LOJA010|LOJA020|LOJA021|LOJA701|LOJA920|LOJA140|LOJA720|FATA701|FATA720|FRTA271" 
Local lNF_CF	 	:= .F.  							// Valida se eh NF para Cupom Fiscal.
Local lRelMacro		:= SubStr(cMV_SCRNOTA,1,1) == '&'	// Valida se o relatório será macro executado
Local nTamL1_DOC	:= TamSx3("L1_DOC")[1]
Local nTamL1_SERIE	:= TamSx3("L1_SERIE")[1]
Local aRegSF2		:= {}
Local lLocR5 		:=	GetRpoRelease("R5") .And.;
						SuperGetMv("MV_CTRLFOL",.F.,.F.) .And.;
						cPaisLoc$"CHI|COL"

Default aDadosTefNf	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Release 11.5                                              ³
//³Dados impressao de uma venda em mais de um formulário de  ³
//³factuta/boleta de acordo com o limite de itens de venda 	 ³
//³que podem ser impressos , estabelecido nos parametros 	 ³
//³MV_SERxxx ou MV_NUMITEN, onde XXX e a serie do formulario ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Default aBreakNota	:= {}																				

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Especial / Administracao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    		

Private aReturn := { STR0005, 1, STR0006 , 1, 2, 1, "",1 }
Private NomeProg:= "LOJR110"
Private aLinha  := { },nLastKey := 0
Private cPerg	:= "LJR110"  

cMV_SCRNOTA := SubStr(cMV_SCRNOTA,At("&",cMV_SCRNOTA) + 1,Len(cMV_SCRNOTA))
    
If At("(",cMV_SCRNOTA) > 0
	cMV_SCRNOTA := SubStr(cMV_SCRNOTA,At("(",cMV_SCRNOTA) + 1,Len(cMV_SCRNOTA)) //Pega somente o conteúdo entre o parenteses
EndIf                                                                                                               

If At(")",cMV_SCRNOTA) > 0
	cMV_SCRNOTA := SubStr(cMV_SCRNOTA,1,At(")",cMV_SCRNOTA)-1) //Pega somente o conteúdo entre o parenteses
EndIf

If lRelMacro 

	If ( cMV_SCRNOTA == "LJNFISCA" .OR. cMV_SCRNOTA == "LJSCNFISCA" ) .AND. ExistFunc("LJSCNFISCA")
		LJSCNFISCA( {cNfEntrada,cSerEntrada} )
	Else
		If ExistBlock(cMV_SCRNOTA)
			ExecBlock(cMV_SCRNOTA, .F., .F.,{cNfEntrada,cSerEntrada})
		Else
			Help( " ", 1, "HELP" ,,STR0017 + CHR(13)+CHR(10) +;
								STR0018 + MV_SCRNOTA + CHR(13)+CHR(10) +;
								STR0019 , 1, 0 ) // "A função indicada no parâmetro MV_SCRNOTA não esta compilada no RPO." "Função: " "Compile esta função e repita a operação."
		EndIf
	EndIf

Else
	//Verificação pois no Chile e Colômbia como é utilizado o Controle de Folios não se pode reimprimir um número de formulário já utilizado.
	If cProgOri == "LOJR110" .AND. lLocR5
		MsgInfo( STR0014 + IIf(cPaisLoc == "CHI",STR0015,STR0016)) // "Não é permitida a Reemissão de Nota Fiscal para ", "o Chile","a Colômbia"
		lRet	:= .F.
	EndIf 
	
	If lRet
		If Empty(cNfEntrada)
			lTroca      := .T.
			cNfEntrada  := Replicate("Z",nTamL1_DOC)
			cSerEntrada := Replicate("Z",nTamL1_SERIE)
		EndIf
	
		DbSelectArea("SL1")
		nOrd := IndexOrd()
		nReg := Recno()
	
		If lProg .Or. lTroca 
			cTitulo := IIf(cPaisLoc!="SAL",STR0007,STR0012)  // "Emiss„o de Notas Fiscais"
			cDesc1 := IIf(cPaisLoc!="SAL",STR0008,STR0013)  // "Este programa tem a fun‡„o de emitir Notas Fiscais."
			cDesc2 :=""
			cDesc3 :=""
		EndIf
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape	 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cbtxt 	:= SPACE(10)
		cbcont	:= 0
		li 		:= 80
		m_pag 	:= 1
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica as perguntas selecionadas 							 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Pergunte("LJR110",.F.)
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Variaveis utilizadas para parametros					    ³
		//³ mv_par01				// Nota Fiscal 						³
		//³ mv_par02				// Serie 							³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Envia controle para a funcao SETPRINT 				        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		wnrel := "NFISCAL"            //Nome Default do relatorio em Disco
		If lProg
			SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F. ,,,,,,,'EPSON.DRV',.T.,,cPorta)
		Else
			SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F. )
		EndIf
	
		If nLastKey == 27
			Return .F.
		EndIf
	
		SetDefault(aReturn,cString)
	
		If nLastKey == 27
			Return .F.
		EndIf
	
		mv_par02 	:= Padr(mv_par02,nTamL1_SERIE)
		mv_par01	:= Padr(mv_par01,nTamL1_DOC)
	                                      
		If !lProg
			dbSelectArea("SF2")
			dbSetOrder( 1 )
			If dbSeek(xFilial("SF2")+mv_par01+mv_par02)
				If !Empty( SF2->F2_NFCUPOM )
					
					If SF2->F2_NFCUPOM == "MDL-RECORDED"
						DbSelectArea("MDL")
						DbSetOrder(1)
						If DbSeek(xFilial("MDL") + SF2->F2_DOC + SF2->F2_SERIE)
							mv_par01 := MDL->MDL_CUPOM
							mv_par02 := MDL->MDL_SERCUP
							lNF_CF := .T.
							
							While !EOF() .AND. (MDL->MDL_FILIAL + MDL->MDL_NFCUP + MDL->MDL_SERIE) == (xFilial("MDL") + SF2->F2_DOC + SF2->F2_SERIE)
								Aadd(aRegSF2,MDL->MDL_F2RECN)
								DbSkip()
								Loop
							End
	        	        EndIf
					Else
						mv_par01 := SubStr(SF2->F2_NFCUPOM,(nTamL1_SERIE+1),nTamL1_DOC)	// Documento - MV_par01
						mv_par02 := SubStr(SF2->F2_NFCUPOM,1,nTamL1_SERIE) 				// Serie - MV_par02
						lNF_CF := .T.
					EndIf
				EndIf	
	    	EndIf
	    
			dbSelectArea("SL1")
			dbSetOrder( 2 )
			dbSeek(xFilial("SL1")+mv_par02+mv_par01)
			If !Empty( SL1->L1_PDV ) .and. !lNF_CF
				Set Device To Screen
				Help(" ","1","CUPFISCAL")
				Set Device to Print
				lOk := .F.
			EndIf
		Else
			DbSelectArea("SL1")
			DbSetOrder(nOrd)
			DbGoTo(nReg)
		EndIf
	
		If lOk
			If !(cProgOri$"LOJA020|LOJA021|LOJA140|LOJA720") .Or. lTroca
				
				If ( cMV_SCRNOTA == "LJNFISCA" .OR. cMV_SCRNOTA == "LJSCNFISCA" ) .AND. ExistFunc("LJSCNFISCA")
					LJSCNFISCA( {cNfEntrada,cSerEntrada,aRegSF2,aDadosTefNf} )
				Else
					If ExistBlock(cMV_SCRNOTA)
						ExecBlock( cMV_SCRNOTA, .F., .F.,{cNfEntrada,cSerEntrada,aRegSF2,aDadosTefNf})
					Else
						Help( " ", 1, "HELP" ,,STR0017 + CHR(13)+CHR(10) +;
											STR0018 + MV_SCRNOTA + CHR(13)+CHR(10) +;
											STR0019 , 1, 0 ) // "A função indicada no parâmetro MV_SCRNOTA não esta compilada no RPO." "Função: " "Compile esta função e repita a operação."
					EndIf
				EndIf

			Else
				ExecBlock( Getmv("MV_SCRTROC"), .F., .F.,{cNfEntrada,cSerEntrada})
			EndIf
		EndIf
	
		Set Device To Screen	
	
		If !lProg
			dbSelectArea("SL1")
			dbSetOrder(1)
			Set Filter To
		EndIf
	
		If aReturn[5] == 1
			Set Printer To
			dbCommitAll()
			OurSpool(wnrel)
		EndIf
	
		MS_FLUSH()
	EndIf	
EndIf

Return .T.
