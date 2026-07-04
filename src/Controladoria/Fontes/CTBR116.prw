/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR116.Ch"
#Include "PROTHEUS.Ch"


// 17/08/2009 -- Filial com mais de 2 caracteres

STATIC __lCusto		:= CtbMovSaldo("CTT")//Define se utiliza C.Custo
STATIC __lItem 		:= CtbMovSaldo("CTD")//Define se utiliza Item
STATIC __lClVl		:= CtbMovSaldo("CTH")//Define se utiliza Cl.Valor 
STATIC _oCTBR116

//Tradução PTG


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR116  ³ Autor ³ Simone Mie Sato       ³ Data ³ 08.01.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Diario Gerencial                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CTBR116(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR116()

Local WnRel
Local aCtbMoeda:={}
LOCAL cString	:= "CT2"
LOCAL cDesc1 	:= OemToAnsi(STR0001)  //"Este programa ira imprimir o Diario Gerencial, de acordo"
LOCAL cDesc2 	:= OemToAnsi(STR0002)  //"com os parƒmetros sugeridos pelo usuario.
Local Titulo 	:= OemToAnsi(STR0006)	// "Emissao do Diario Gerencial"
Local lRet		:= .T.

PRIVATE Tamanho	:= "M"
PRIVATE aReturn 	:= { OemToAnsi(STR0004), 1,OemToAnsi(STR0005), 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE nomeprog	:= "CTBR116"
PRIVATE aLinha  	:= { }
PRIVATE nLastKey	:= 0
PRIVATE cPerg   	:= "CTR116"
PRIVATE lCodImp		:= .F.

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf

wnrel :="CTBR116"

Pergunte("CTR116",.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01			// Set Of Books				    	     ³
//³ mv_par02  	      	// Data Inicial                          ³
//³ mv_par03            // Data Final                            ³
//³ mv_par04            // Moeda?                                ³
//³ mv_par05			// Tipo Lcto? Real / Orcad / Gerenc / Pre³
//³ mv_par06  	        // Pagina Inicial                        ³
//³ mv_par07            // Pagina Final                          ³
//³ mv_par08            // Pagina ao Reiniciar                   ³
//³ mv_par09            // So Livro/Livro e Termos/So Termos     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,,.F.,"",,Tamanho,,.F.)

If nLastKey = 27
	Set Filter To
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)		     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ct040Valid(mv_par01)
	lRet := .F.
Else
	aSetOfBook := CTBSetOf(mv_par01)
EndIf

If lRet
	aCtbMoeda	:= CtbMoeda(mv_par04)
	If Empty(aCtbMoeda[1])
		Help(" ",1,"NOMOEDA")
		lRet := .F.
	EndIf	
EndIf

If !lRet	
	Set Filter To
	Return
EndIf

SetDefault(aReturn,cString)

If nLastKey = 27
	Set Filter To
	Return
Endif

RptStatus({|lEnd| CTR116Imp(@lEnd,wnRel,cString,aSetOfBook,aCtbMoeda)})

dbSelectArea("CT2")
Set Filter To

Return 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CTR116IMP ³ Autor ³ Simone Mie Sato       ³ Data ³ 08/01/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Impressao do Diario Gerencial                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³ CTR114Imp(lEnd,wnRel,cString,aSetOfBook,aCtbMoeda)         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅ±±
±±³Parametros ³ ExpL1   - A‡ao do Codeblock                                ³±±
±±³           ³ ExpC1   - T¡tulo do relat¢rio                              ³±±
±±³           ³ ExpC2   - Mensagem                                         ³±±
±±³           ³ ExpA1   - Matriz ref. Config. Relatorio                    ³±±
±±³           ³ ExpA2   - Matriz ref. a moeda                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CTR116Imp(lEnd,WnRel,cString,aSetOfBook,aCtbMoeda)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local CbTxt
Local Cbcont
Local Cabec1		:= OemToAnsi(STR0007)
Local Cabec2		:= Iif (cPaisLoc<>"MEX",OemToAnsi(STR0008),OemToAnsi(STR0020))
Local Titulo		:= ""

Local cPicture
Local cDescMoeda
Local cCodMasc
Local cSeparador	:= ""
Local cMascara
Local cGrupo
Local cLote			:= ""
Local cSubLote		:= ""
Local cDoc			:= ""
Local cCancel		:= OemToAnsi(STR0012)
Local cFilCT1		:= xFilial("CT1")
Local cCodPlGer		:= aSetOfBook[5]
Local cArqTmp		:= ""
Local cSaldo		:= mv_par05

Local dDataIni		:= mv_par02
Local dDataFim		:= mv_par03

Local lData			:= .T.    
Local lFirst		:= .T.
Local lImpLivro		:=.t., lImpTermos:=.f.								
Local l1StQb	 	:= .T.

Local nQuebra		:= 0
Local nTotDiaD		:= 0
Local nTotDiaC		:= 0
Local nTotMesD		:= 0
Local nTotMesC		:= 0
Local nTotDeb		:= 0
Local nTotCred	 	:= 0
Local nDia
Local nMes
Local nTamDeb		:= 15			// Tamanho da coluna de DEBITO
Local nTamCrd		:= 14			// Tamanho da coluna de CREDITO
Local nRecCT2		:= 0
Local nColDeb		:= 102			// Coluna de impressao do DEBITO
Local nColCrd		:= 118			// Coluna de impressao do CREDITO
Local nPagIni		:= mv_par06
Local nPagFim		:= mv_par07
Local nReinicia		:= mv_par08
Local nBloco		:= 0
Local nBlCount		:= 0
Local i				:= 0 

m_pag    := 1

CtbQbPg(.T.,@nPagIni,@nPagFim,@nReinicia,@m_pag,@nBloco,@nBlCount)		/// FUNCAO PARA TRATAMENTO DA QUEBRA //.T. INICIALIZA VARIAVEIS
								
Private cMoeda

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
cMoeda	:= mv_par04

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando definicoes para impressao -> Decimais, Picture,   ³
//³ Mascara da Conta                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cDescMoeda 	:= aCtbMoeda[2]
nDecimais 	:= DecimalCTB(aSetOfBook,cMoeda)

If Empty(aSetOfBook[2])
	cMascara := GetMv("MV_MASCARA")
Else
	cMascara := RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf
cPicture 	:= aSetOfBook[4]

Titulo		:= 	OemToAnsi(STR0009) + DTOC(mv_par02) + OemToAnsi(STR0010) +;
				DTOC(mv_par03) + OemToAnsi(STR0011) + cDescMoeda + CtbTitSaldo(mv_par05)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao de Termo / Livro                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
	Case mv_par09==1 ; lImpLivro:=.t. ; lImpTermos:=.f.
	Case mv_par09==2 ; lImpLivro:=.t. ; lImpTermos:=.t.
	Case mv_par09==3 ; lImpLivro:=.f. ; lImpTermos:=.t.
EndCase		
				
			
If lImpLivro		  

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Arquivo Temporario para Impressao   					 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				U_CTB116Cria(oMeter,oText,oDlg,lEnd,@cArqTmp,cMoeda,dDataIni,dDataFim,aSetOfBook,cSaldo,cCodPlGer)},;
				STR0021,;		// "Criando Arquivo Tempor rio..."
				STR0006)		// "Emissao do Razao"

	dbSelectArea("cArqTmp")
	SetRegua(RecCount())
	dbGoTop()
EndIf

	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio da Impressao do Relatorio                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

While 	lImpLivro .And. !Eof() .and. DTOS(cArqTmp->DATAL) <= DTOS(dDataFim)

	IF lEnd
		@Prow()+1, 0 PSAY cCancel 
		Exit
	EndIF

	nMes := Month(cArqTmp->DATAL)
			
	While ! Eof() .And. DTOS(cArqTmp->DATAL) <= DTOS(dDataFim) .And.	Month(cArqTmp->DATAL) == nMes

		nDia := Day(cArqTmp->DATAL)
		lData:= .T.		
		While !Eof() .And. 	DTOS(cArqTmp->DATAL) <= DTOS(dDataFim) .And.;
			Month(cArqTmp->DATAL) == nMes .And. Day(cArqTmp->DATAL) == nDia
			
			IF lEnd
				@Prow()+1, 0 PSAY cCancel 
				Exit
			EndIF
			
			IncRegua()
	
			cDoc 		:= cArqTmp->DOC
			cLote		:= cArqTmp->LOTE
			cSubLote	:= cArqTmp->SUBLOTE

			// Loop para imprimir mesmo lote / documento / continuacao de historico
			While !Eof() .And. cArqTmp->DOC == cDoc 				.And.;
								cArqTmp->LOTE == cLote 				.And.;
								cArqTmp->SUBLOTE == cSubLote 		.And.;
						   DTOS(cArqTmp->DATAL) <= DTOS(dDataFim) 	.And.;
			    	      Month(cArqTmp->DATAL) == nMes 			.And.;
			        	    Day(cArqTmp->DATAL) == nDia
			
				If li > 55
					li++
					//	Imprime "a transportar ----->" ao final da pagina
					If !lFirst .And. (nTotDiaD <> 0 .or. nTotDiaC <> 0)
						@li,055 PSAY OemToAnsi(STR0013)						// A transportar
						If nTotDiaD <> 0
							ValorCTB(nTotDiaD,li,nColDeb,nTamDeb,nDecimais,.F.,cPicture,"1")
						EndIf
						If nTotDiaC <> 0
							ValorCTB(nTotDiaC,li,nColCrd,nTamCrd,nDecimais,.F.,cPicture,"2")
						EndIf                                               
						li++
					EndIF             

					CtbQbPg(.F.,@nPagIni,@nPagFim,@nReinicia,@m_pag,@nBloco,@nBlCount)		/// FUNCAO PARA TRATAMENTO DA QUEBRA //.F. EFETUA QUEBRA
					CtCGCCabec(,,,Cabec1,Cabec2,dDataFim,Titulo,,"2",Tamanho)
					// Imprime "de transporte -------->" no inicio da pagina
					If !lFirst .And. (nTotDiaD <> 0 .or. nTotDiaC <> 0)
						li++                 
						@ li, 000 PSAY DTOC(cArqTmp->DATAL)
						@li,055 PSAY OemToAnsi(STR0014)
						If nTotDiaD <> 0
							ValorCTB(nTotDiaD,li,nColDeb,nTamDeb,nDecimais,.F.,cPicture,"1")
						EndIf
						If nTotDiaC <> 0
							ValorCTB(nTotDiaC,li,nColCrd,nTamCrd,nDecimais,.F.,cPicture,"2")
						EndIf                                               
						li+=2
					EndIF
					lFirst := .F.
				EndIF

				If lData
					li++
					@ li, 000 PSAY DTOC(cArqTmp->DATAL)
					li++
					lData := .F.
				EndIf                   
					
				IncRegua()								
					
				If !Empty(cArqTmp->DEBITO)					/// Se a Conta a Debito estiver preenchida
					EntidadeCTB(cArqTmp->DEBITO,li,00,20,.F.,cMascara,cSeparador)
				Endif                              
				
				If !Empty(cArqTmp->CREDIT)
					EntidadeCTB(cArqTmp->CREDIT,li,21,20,.F.,cMascara,cSeparador)					
				Endif
			
				@ li, 042 PSAY Substr(cArqTmp->HISTORICO,1,40)
				@ li, 083 PSAY cArqTmp->LOTE+cArqTmp->SUBLOTE+cArqTmp->DOC+cArqTmp->LINHA
							   
				If cArqTmp->DC == "1" .Or. cArqTmp->DC == "3"
					ValorCTB(LANCDEB,li,nColDeb,nTamDeb,nDecimais,.F.,cPicture,"1")
				EndIf
				If cArqTmp->DC == "2" .Or. cArqTmp->DC == "3"
					ValorCTB(LANCCRD,li,nColCrd,nTamCrd,nDecimais,.F.,cPicture,"2")
				EndIf

				If cArqTmp->DC == "1" .Or. cArqTmp->DC == "3"	
					nTotDeb 	+= cArqTmp->LANCDEB
					nTotDiaD	+= cArqTmp->LANCDEB
					nTotMesD	+= cArqTmp->LANCDEB
				EndIf
				If cArqTmp->DC == "2" .Or. cArqTmp->DC == "3"
					nTotCred += cArqTmp->LANCCRD
					nTotdiaC += cArqTmp->LANCCRD
					nTotMesC += cArqTmp->LANCCRD
				EndIf
				
				// Procura pelo complemento de historico        
				nRecCT2 := CT2->(Recno())
				
				dbSelectArea("CT2")
				dbSetOrder(10)
				If MsSeek(xFilial()+DTOS(cArqTmp->DATAL)+cArqTmp->LOTE+cArqTmp->SUBLOTE+cArqTmp->DOC+cArqTmp->SEQLAN+cArqTmp->EMPORI+cArqTmp->FILORI)
					dbSkip()
					If CT2->CT2_DC == "4"
						While !Eof() .And. CT2->CT2_FILIAL == xFilial() 			.And.;
											CT2->CT2_LOTE == cArqTmp->LOTE 			.And.;
											CT2->CT2_SBLOTE == cArqTmp->SUBLOTE 	.And.;
											CT2->CT2_DOC == cArqTmp->DOC 			.And.;
											CT2->CT2_SEQLAN == cArqTmp->SEQLAN		.And.;
											CT2->CT2_EMPORI == cArqTmp->EMPORI		.And.;
											CT2->CT2_FILORI == cArqTmp->FILORI		.And.;
											CT2->CT2_DC == "4" 			.And.;
						        	       Dtos(CT2->CT2_DATA) == DTOS(cArqTmp->DATAL) 
							li++
							@ li, 042 PSAY Substr(CT2->CT2_HIST,1,40)
							cLinha := CT2->CT2_LINHA
							dbSkip()
						EndDo	
					EndIf				
				EndIf 							
				li++						
				DBSelectArea("cArqTmp")
				dbSkip()
			EndDo
		EndDO
		If lEnd
			Exit
		Endif	
		IF (nTotDiad+nTotDiac)>0
			li++
			@li,055 PSAY OemToAnsi(STR0015)			// Totais do Dia
			ValorCTB(nTotDiaD,li,nColDeb,nTamDeb,nDecimais,.F.,cPicture,"1")
			ValorCTB(nTotDiaC,li,nColCrd,nTamCrd,nDecimais,.F.,cPicture,"2")
			nTotDiaD	:= 0
			nTotDiaC	:= 0
			li+=2
		EndIF
	EndDO
	If lEnd
		Exit
	EndIf	
		// Totais do Mes
	IF (nTotMesd+nTotMesc) > 0
		@li,055 PSAY OemToAnsi(STR0016)				// Totais do Mes
		ValorCTB(nTotMesD,li,nColDeb,nTamDeb,nDecimais,.F.,cPicture,"1")
		ValorCTB(nTotMesC,li,nColCrd,nTamCrd,nDecimais,.F.,cPicture,"2")
		nTotMesD := 0
		nTotMesC := 0
		li+=2
	EndIF
EndDO

IF (nTotDiad+nTotDiac)>0 .And. !lEnd
	// Totais do Dia - Ultimo impresso
	li++
	@li,055 PSAY OemToAnsi(STR0015)				// Totais do Dia
	ValorCTB(nTotDiaD,li,nColDeb,nTamDeb,nDecimais,.F.,cPicture,"1")
	ValorCTB(nTotDiaC,li,nColCrd,nTamCrd,nDecimais,.F.,cPicture,"2")
	li++
	
	// Totais do Mes - Ultimo impresso
	@li,055 PSAY OemToAnsi(STR0016)  			// Totais do Mes
	ValorCTB(nTotMesD,li,nColDeb,nTamDeb,nDecimais,.F.,cPicture,"1")
	ValorCTB(nTotMesC,li,nColCrd,nTamCrd,nDecimais,.F.,cPicture,"2")
	li++
EndIF

// Total Geral impresso
IF (nTotDeb + nTotCred) > 0 .And. !lEnd
	@li,055 PSAY OemToAnsi(STR0017)				// Total Geral
	ValorCTB(nTotDeb ,li,nColDeb,nTamDeb,nDecimais,.F.,cPicture,"1")
	ValorCTB(nTotCred,li,nColCrd,nTamCrd,nDecimais,.F.,cPicture,"2")
EndIF

If lImpTermos 							// Impressao dos Termos

	Pergunte( "CTR116", .F. )
	
	cArqAbert:=GetMv("MV_LDIARAB")
	cArqEncer:=GetMv("MV_LDIAREN")

	dbSelectArea("SM0")
	aVariaveis:={}

	For i:=1 to FCount()	
		If FieldName(i)=="M0_CGC"
			AADD(aVariaveis,{FieldName(i),Transform(FieldGet(i),"@R! NN.NNN.NNN/NNNN-99")})
		Else
            If FieldName(i)=="M0_NOME"
                Loop
            EndIf
			AADD(aVariaveis,{FieldName(i),FieldGet(i)})
		Endif
	Next

	dbSelectArea("SX1")
	dbSeek( Padr( "CTR110", Len( X1_GRUPO ) , ' ' ) + "01" )

	While SX1->X1_GRUPO == Padr( "CTR110", Len( X1_GRUPO ) , ' ' )
		AADD(aVariaveis,{Rtrim(Upper(X1_VAR01)),&(X1_VAR01)})
		dbSkip()
	End

	If !File(cArqAbert)
		aSavSet:=__SetSets()
		cArqAbert:=CFGX024(,"Diario Geral.") // Editor de Termos de Livros
		__SetSets(aSavSet)
		Set(24,Set(24),.t.)
	Endif

	If !File(cArqEncer)
		aSavSet:=__SetSets()
		cArqEncer:=CFGX024(,"Diario Geral.") // Editor de Termos de Livros
		__SetSets(aSavSet)
		Set(24,Set(24),.t.)
	Endif

	If cArqAbert#NIL
		ImpTerm(cArqAbert,aVariaveis,AvalImp(132))
	Endif

	If cArqEncer#NIL
		ImpTerm(cArqEncer,aVariaveis,AvalImp(132))
	Endif	 
Endif

If aReturn[5] = 1
	Set Printer To
	Commit
	Ourspool(wnrel)
End

If lImpLivro
	dbSelectArea("cArqTmp")
	Set Filter To
	dbCloseArea()
Endif

//Deleta tabela temporaria do banco de dados
If _oCTBR116 <> Nil
	_oCTBR116:Delete()
	_oCTBR116 := Nil
Endif

dbSelectArea("CT2")     
Set Filter to
MS_FLUSH()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CtbQbPg   ºAutor  ³Marcos S. Lobo      º Data ³  12/02/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Controla a quebra de pagina dos relatorios SIGACTB          º±±
±±º          ³quando possuem os parametros de PAG.INICAL-FINAL-REINICIAR  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametro1³ lNewVars  = (.T.=Inicializa variaveis/.F.=Trata Quebra)    º±±
±±º         2³ nPagIni 	 = Pagina Inicial do relatorio.               	  º±±
±±º         3³ nPagFim 	 = Pagina Final do relatorio               	 	  º±±
±±º         4³ nReinicia = Pagina ao Reiniciar do relatorio               º±±
±±º         5³ m_pag 	 = Numero da pagina usada na Cabec()              º±±
±±º         6³ nBloco    = Bloco de paginas (intervalo de quebra)		  º±±
±±º         7³ nBlCount  = Contador de páginas (zerado na qebra de bloco) º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CtbQbPg(lNewVars,nPagIni,nPagFim,nReinicia,m_pag,nBloco,nBlCount)

DEFAULT lNewVars := .F.

If lNewVars					/// INICIALIZA AS VARIAVEIS
	nBloco		:= (nPagFim+1) - nPagIni				/// (PAG. FIM + 1) - PAG. INICIAL - BLOCO DE PAG. PARA IMPRESSAO
	nBlCount	:= 0
	m_pag		:= nPagIni
Else						/// NAO INICIALIZA - TRATA A QUEBRA DE PAGINA
	nBlCount++
	If nBlCount > nBloco 							/// SE A QUANTIDADE DE PAGINAS IMPRESSAO FOR IGUAL AO BLOCO DEFINIDO
		If nReinicia > nPagFim						/// SE A PAG. DE REINICIO FOR MAIOR QUE A PAGINA FINAL (ATUAL)
			nUltPg	  := m_pag						/// GUARDA A ULTIMA PAG. IMPRESSA
			m_pag 	  := nReinicia					/// REINICIA A NUMERACAO DE PAG. (m_pag atual ainda não foi)
			nPagFim   := nReinicia+nBloco 			/// DEFINE O NOVO NUMERO DA PAGINA FIM
			nReinicia := nPagFim+(nReinicia-nUltPg)	/// DEFINE A PROX. PAG. AO REINICIAR PELA DIFERENCA COM  FINAL
		Else										/// SE A PAG. DE REINICIO FOR MENOR OU IGUAL A PAGINA FINAL                                                                
			m_pag := nReinicia						/// SO REINICIA A NUMERACAO DE PAG.
		Endif
		nBlCount := 1
	EndIf	
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Ctb116CriaºAutor  ³Simone Mie Sato     º Data ³  09/01/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria arquivo de trabalho.									  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Ctb116Cria(oMeter,oText,oDlg,lEnd,cArqTmp,cMoeda,dDataIni,dDataFim,aSetOfBook,cSaldo,cCodPlGer)

Local aSaveArea	:= GetArea()
Local aCampos	:= {}
Local cChave	:= ""
Local aTamConta	:= TAMSX3("CTS_CONTAG") 
Local nTamHist	:= Len(CriaVar("CT2_HIST"))


aCampos :={	{ "DEBITO" 		, "C", aTamConta[1], 0 },;  		// Codigo da Conta Debito
			{ "CREDIT" 		, "C", aTamConta[1], 0 },;  		// Codigo da Conta Credito
			{ "LANCDEB"		, "N", 17			, nDecimais },; // Debito
			{ "LANCCRD"		, "N", 17			, nDecimais },; // Credito
			{ "TPSLD"   	, "C", 01, 0 },; 					// Sinal do Saldo Atual => Consulta Razao
			{ "DC"   		, "C", 01, 0 },; 					// Tipo do lancamento contabil
			{ "HISTORICO"	, "C", nTamHist   	, 0 },;			// Historico
			{ "DATAL"		, "D", 10			, 0 },;			// Data do Lancamento
			{ "LOTE" 		, "C", 06			, 0 },;			// Lote
			{ "SUBLOTE" 	, "C", 03			, 0 },;			// Sub-Lote
			{ "DOC" 		, "C", 06			, 0 },;			// Documento
			{ "LINHA"		, "C", 03			, 0 },;			// Linha
			{ "SEQLAN"		, "C", 03			, 0 },;			// Sequencia do Lancamento
			{ "SEQHIST"		, "C", 03			, 0 },;			// Seq do Historico
			{ "EMPORI"		, "C", 02			, 0 },;			// Empresa Original
			{ "FILORI"		, "C", 02			, 0 }}			// Filial Original
			
If _oCTBR116 <> Nil
	_oCTBR116:Delete()
	_oCTBR116 := Nil
Endif

_oCTBR116 := FWTemporaryTable():New( "cArqTmp" )  
_oCTBR116:SetFields(aCampos) 
_oCTBR116:AddIndex("1", {"DATAL","LOTE","SUBLOTE","DOC","LINHA","TPSLD","EMPORI","FILORI"})

//------------------
//Criação da tabela temporaria
//------------------
_oCTBR116:Create()  

dbSelectArea("cArqTmp")
dbSetOrder(1)  

// Monta Arquivo para gerar o Razao
U_Ctbr116Ger(oMeter,oText,oDlg,lEnd,cMoeda,dDataIni,dDataFim,aSetOfBook,cSaldo,cCodPlGer)        			

Restarea(aSaveArea)

Return(cArqTmp)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Ctbr116GerºAutor  ³Simone Mie Sato     º Data ³  13/01/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Grava arquivo de trabalho.								  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/    
User Function Ctbr116Ger(oMeter,oText,oDlg,lEnd,cMoeda,dDataIni,dDataFim,aSetOfBook,cSaldo,cCodPlGer)        


Local aSaveArea	:= GetArea()

Local cContaG	:= ""                                                                                                   

Local bPular		:= { || 	CT2->CT2_MOEDLC <> cMoeda .Or.;                    
								CT2->CT2_VALOR = 0 .Or.;
								(CT2->CT2_TPSALD # cSaldo .And. cSaldo # "*") }


dbSelectArea("CTS")
dbSetOrder(1)
If MsSeek(xFilial()+cCodPlGer,.T.)
	While !Eof() .And. xFilial("CTS") == CTS->CTS_FILIAL .And. cCodPlGer == CTS->CTS_CODPLA
	
		If CTS->CTS_CLASSE == "1"
			dbSkip()
			Loop
		EndIf		
		
	   cContaG	 := CTS->CTS_CONTAG	

		//Grava debito 		
		dbSelectArea("CT2")
		SetRegua(Reccount())		
		dbSetOrder(2)
		dbGoTop()
		MsSeek(xFilial()+CTS->CTS_CT1INI,.T.)
		While !Eof() .And. xFilial() == CT2->CT2_FILIAL .And. CT2->CT2_DEBITO <= CTS->CTS_CT1FIM 					
			
			If CT2->CT2_DATA < dDataIni .Or. CT2->CT2_DATA > dDataFim
				dbSkip()
				Loop
			EndIf

			If __lCusto
				If CT2->CT2_CCD < CTS->CTS_CTTINI .or. CT2->CT2_CCD > CTS->CTS_CTTFIM
					dbSkip()
					Loop
				EndIf
			EndIf
			
			If __lItem
				If CT2->CT2_ITEMD < CTS->CTS_CTDINI .or. CT2->CT2_ITEMD > CTS->CTS_CTDFIM
					dbSkip()
					Loop
				EndIf
			EndIf
			
			If __lClVl
				If CT2->CT2_CLVLDB < CTS->CTS_CTHINI .or. CT2->CT2_CLVLDB > CTS->CTS_CTHFIM
					dbSkip()
					Loop
				EndIf
			EndIf
							
			If Eval(bPular)
				dbSkip()
				Loop
			EndIf
								
			IncRegua()				
			
			U_Ctb116Grv(cContaG,"1",cMoeda)			
			dbSkip()
		End									
        
   	    //Grava credito
        dbSelectarea("CT2")
		SetRegua(Reccount())        
     	dbSetOrder(3)
		dbGoTop()        
   	    MsSeek(xFilial()+CTS->CTS_CT1INI,.T.)
   		While !Eof() .And. xFilial() == CT2->CT2_FILIAL .And. CT2->CT2_CREDIT <= CTS->CTS_CT1FIM        
      	
			If CT2->CT2_DATA < dDataIni .Or. CT2->CT2_DATA > dDataFim
				dbSkip()
				Loop
			EndIf
				
			If __lCusto
				If CT2->CT2_CCC < CTS->CTS_CTTINI .or. CT2->CT2_CCC > CTS->CTS_CTTFIM
					dbSkip()
					Loop
				EndIf
			EndIf
			
			If __lItem
				If CT2->CT2_ITEMC < CTS->CTS_CTDINI .or. CT2->CT2_ITEMC > CTS->CTS_CTDFIM
					dbSkip()
					Loop
				EndIf
			EndIf
			
			If __lClVl
				If CT2->CT2_CLVLCR < CTS->CTS_CTHINI .or. CT2->CT2_CLVLCR > CTS->CTS_CTHFIM
					dbSkip()
					Loop
				EndIf
			EndIf					

			If Eval(bPular)
				dbSkip()
				Loop
			EndIf
				                               
			IncRegua()				
				
			U_Ctb116Grv(cContaG,"2",cMoeda)						        
           	dbSkip()
	   	End
    	dbSelectArea("CTS")
    	dbSkip()
	End    					
EndIf

RestArea(aSaveArea)


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Ctb116Grv ºAutor  ³Simone Mie Sato     º Data ³  09/01/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Grava arquivo de trabalho.								  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Ctb116Grv(cContaG,cTipo,cMoeda)

Local aSaveArea	:= GetArea()
Local lCriaReg	:= .F.	//Variavel que define se devera ser criado novo registro no arquivo temporario.

dbSelectArea("cArqTmp")
dbSetOrder(1)
If !MsSeek(DTOS(CT2->CT2_DATA)+CT2->CT2_LOTE+CT2->CT2_SBLOTE+CT2->CT2_DOC+CT2->CT2_LINHA+CT2->CT2_TPSALD+CT2->CT2_EMPORI+CT2->CT2_FILORI,.F.)
	lCriaReg	:= .T.
Else	
	//Se achou registro gravado com a mesma chave 1, devera verificar se ira criar novo registro ou nao.
	If cTipo == '1'		
		If !Empty(cArqTmp->DEBITO)		
			lCriaReg	:= .T.
		EndIf
	ElseIf cTipo == '2'
		If !Empty(cArqTmp->CREDIT) 
			lCriaReg	:= .T.
		EndIf	
	EndIf
EndIf     

If lCriaReg
	RecLock("cArqTmp",.T.)
	Replace	TPSLD		With CT2->CT2_TPSALD
	Replace	DC			With CT2->CT2_DC
	Replace	HISTORICO	With CT2->CT2_HIST
	Replace	DATAL		With CT2->CT2_DATA
	Replace	LOTE		With CT2->CT2_LOTE
	Replace	SUBLOTE		With CT2->CT2_SBLOTE
	Replace	DOC			With CT2->CT2_DOC
	Replace	LINHA		With CT2->CT2_LINHA
	Replace	SEQLAN		With CT2->CT2_SEQLAN
	Replace	SEQHIST		With CT2->CT2_SEQHIS
	Replace	EMPORI		With CT2->CT2_EMPORI	
	Replace	FILORI		With CT2->CT2_FILORI
	If cTipo == '1'
		Replace	DEBITO		With cContaG	
		Replace	LANCDEB		With CT2->CT2_VALOR
	ElseIf cTipo == '2'
		Replace	CREDIT		With cContaG	
		Replace	LANCCRD		With CT2->CT2_VALOR
	EndIf
Else                      
	RecLock("cArqTmp",.F.)
	If cTipo == '1'
		Replace	DEBITO		With cContaG	
		Replace	LANCDEB		With  CT2->CT2_VALOR
	ElseIf cTipo == '2'
		Replace	CREDIT		With cContaG	
		Replace	LANCCRD		With  CT2->CT2_VALOR
	EndIf
EndIf
MsUnlock()

RestArea(aSaveArea)

Return
