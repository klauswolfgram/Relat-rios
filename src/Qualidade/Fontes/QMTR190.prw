/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TOTVS.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "QMTR190.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "FWPRINTSETUP.CH"

#DEFINE ANALISE_RR "1" 
                                                                
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QMTR190  ³ Autor ³ Cicero Odilio Cruz    ³ Data ³ 08.12.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Performance de Sistemas de Medicao            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMTR190(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Metrologia/PPAP                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Autor     ³ BOPs ³ Alteracao                                           ³±± 
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±± 
±±³          ³      ³https://tdn.totvs.com/display/tec/TMSPrinter         ³±± 
±±³          ³      ³                                                     ³±± 
±±³          ³      ³                                                     ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMTR190

Local oPrint
Local lPergunte := .F.

Private cStartPath 	:= GetSrvProfString("Startpath","")
Private lExistChart := FindFunction("QIEMGRAFIC") .AND. GetBuild() >= "7.00.170117A" //controle se executa o grafico modelo novo ou por DLL


If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

oPrint := TMSPrinter():New(STR0001) //"Performance de Sistema de Medicao R&R"

If nModulo == 47 // Modulo PPAP  
	lPergunte := Pergunte("QMR191",.T.) 
Else
	lPergunte := Pergunte("QMR190",.T.) 
EndIf

If lPergunte
	DbSelectArea("QM4")
	If nModulo == 47 // Modulo PPAP  
		DbSetOrder(3)
	Else
		DbSetOrder(1)
	EndIf
	If DbSeek(xFilial("QM4")+MV_PAR01+MV_PAR02+Iif(nModulo == 47,MV_PAR03+DTOS(MV_PAR04)+MV_PAR05,DTOS(MV_PAR03)+MV_PAR04)) .AND. QMT150VUsr()
		If QM4->QM4_TIPO $ "EP"
			If nModulo == 47 // Modulo PPAP  
				DbSelectArea("QK1")
				DbSetOrder(1)     
				DbSeek(xFilial("QK1")+MV_PAR01+MV_PAR02)  
			
				DbSelectArea("QK2")
				DbSetOrder(2)     
				DbSeek(xFilial("QK2")+MV_PAR01+MV_PAR02+MV_PAR03) 
			Else
				DbSelectArea("QM2")
				DbSetOrder(1)     
				DbSeek(xFilial("QM2")+QM4->QM4_INSTR+Inverte(QM4->QM4_REVINS))    
			EndIf
			
			DbSelectArea("QM4")
			MontaRel(oPrint)
		
			oPrint:Preview()  		// Visualiza antes de imprimir
			
		Else
			
			MsgInfo( OemToAnsi( STR0036 ) , OemToAnsi( STR0037 ) ) //"Tipo de ensaio inválido, use somente (Tolerancia de Processo ou Tolerancia de Especificação), para gerar este estudo."###"Aviso de Inconsitencia!"
			
		EndIf
	EndIf
EndIf
		
Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MontaRel ³ Autor ³ Cicero Odilio Cruz    ³ Data ³ 08.12.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio de Performance de Sistemas de Medicao            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MotaRel(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR190                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontaRel(oPrint)
Local aAnalise 	 := {}
Local aMed		 := {}
Local aTexto   	 := {} 
Local cArqPNG	 := "" 
Local col		 := 30
Local i 		 := 1
Local lin		 := 0
Local nX    	 := 0
Local oQLGrafico := GraficosQualidadeX():New()

Private oFArial08  := TFont():New("Arial"      ,08,08,,.F.,,,,.T.,.F.)
Private oFArial09  := TFont():New("Arial"      ,09,09,,.F.,,,,.T.,.F.)
Private oFArial10  := TFont():New("Arial"      ,10,10,,.F.,,,,.T.,.F.)
Private oFArial12  := TFont():New("Arial"      ,12,12,,.F.,,,,.T.,.F.)
Private oFArial14  := TFont():New("Arial"      ,14,14,,.F.,,,,.T.,.F.)
Private oFCouri08  := TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)
Private oFCouri10  := TFont():New("Courier New",10,10,,.F.,,,,.T.,.F.)
Private oFCouri10N := TFont():New("Courier New",10,10,,.T.,,,,.T.,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//|aAnalise: [1] - Operador (Limitado a  5)                             |
//|	   	     [1][1] - Ciclo                                             |
//|	    	 [1][1][1] - Medicoes Ciclo                                 |
//|	     	 [1][1][1][1] - Medicao 1                                   |
//|		     [1][3] - Media Medicoes                                    |
//|		     [1][2] - Amplitude Medicoes                                |
//|		     [N] - Valor Real                                           |
//|  	     [N][1] - Valor Real Peca 01                                |
//| N representa o ultimo elemento que  tem o valor  real das amostras. |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
U_Q190RecDad(@aAnalise, @aTexto)

IF !lExistChart //controle se executa o grafico modelo novo ou por DLL
	//Gero o Texto
	GERATXT32(aTexto,"QIP00022.SPC","C:\")
ENDIF

oPrint:SetPortraint() 
//Impressao dos Dados do Cabecalho
Cabecalho(oPrint, i, @lin)
//Imprime  os dados do grafico Media por Operador
aMed := aClone(U_Q190ImpMOp(oPrint, aAnalise, @lin ))
//Finaliza a Pagina
oPrint:EndPage()   

lin := 0
i++ //Nova Pagina
//Impressao dos Dados do Cabecalho
Cabecalho(oPrint, i, @lin)    
//Imprime a analise estatistica do estudo de RR
U_Q190ImpFAn(oPrint, aAnalise, @lin, aMed ) 
//Finaliza a Pagina
oPrint:EndPage()   

lin := 0
i++ //Nova Pagina
//Impressao dos Dados do Cabecalho
Cabecalho(oPrint, i, @lin)

IF lExistChart //controle se executa o grafico modelo novo ou por DLL

	For nX := 1 to 99999
		cArqPNG := "QMTR190" + StrZero(nX,4) + ".PNG"
		If !File(oQLGrafico:retorna_Local_Imagens_Graficos()+cArqPNG)
			Exit
		EndIf
	Next nX

	//STR0048 - "Média por Operador"
	//STR0049 - "Amplitude por Operador"
	QIEMGRAFIC(aTexto, 7,/* aMedicoes */, {STR0048, STR0049},,, cArqPNG)

	cImgGraf := oQLGrafico:retorna_Local_Imagens_Graficos()+cArqPNG

	//Imprime o grafico no relatorio
	     //SayBitmap( < nLinha>, < nCol>, < cBitmap>, [ nWidth], [ nHeight] )
	oPrint:SayBitmap(lin,col, cImgGraf,2001,col+1620) //667 * 3, (550 * 3) - 30

ELSE
	//Imprime o grafico no relatorio
	Calldll32("ShowChart","QIP00022.SPC","6","C:\","12","PADRAO",,"FALSE")
	oPrint:SayBitmap(lin,col, "C:\ESTUDORR1.BMP",2350,col+850)
	lin += 900
	//Imprime o grafico no relatorio
	oPrint:SayBitmap(lin,col, "C:\ESTUDORR2.BMP",2350,col+850)
ENDIF

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³Cabecalho ³ Autor ³ Cicero Odilio Cruz    | Data ³ 08.12.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio de Performance de Sistemas de Medicao            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabecalho(ExpO1,ExpN1)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR130                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabecalho(oPrint, i, lin)

Local cFileLogo := "LGRL"+SM0->M0_CODIGO+SM0->M0_CODFIL+".BMP" // Empresa+Filial
Local aTxt      := {}
Local cNome		:= ""
Local cCodMat	:= ""

lin := 5

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa                             ?
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(lin,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(lin,2200, "Logo.bmp",237,58) 
lin += 60
oPrint:Say(lin,2250,STR0002+StrZero(i,2),oFArial08 ) // "Pagina  "

lin -= 15
oPrint:Say(lin,0700,STR0001,oFArial14 ) //"Performance de Sistema de Medicao R&R"   

lin += 100
//Box Cabecalho
oPrint:Box( lin, 0030,lin+360, 2375 )

oPrint:Line(lin+1, 0030, lin+1 , 2375 )   	
oPrint:Line(lin+2, 0030, lin+2 , 2375 )   	
oPrint:Line(lin+3, 0030, lin+3 , 2375 )   	
oPrint:Line(lin+4, 0030, lin+4 , 2375 )   

oPrint:Line(lin+66, 0030, lin+66 , 2375 )   	
oPrint:Line(lin+67, 0030, lin+67 , 2375 )  
oPrint:Line(lin+68, 0030, lin+68 , 2375 )   	
oPrint:Line(lin+69, 0030, lin+69 , 2375 )  

oPrint:Line(lin+361, 0030, lin+361 , 2375 )   	
oPrint:Line(lin+362, 0030, lin+362 , 2375 )  
oPrint:Line(lin+363, 0030, lin+363 , 2375 )   	
oPrint:Line(lin+364, 0030, lin+364 , 2375 )
 	
oPrint:Line(lin   , 1200, lin+360, 1200 )   		// Vertical 2

If nModulo == 47 
	oPrint:Say(lin+20,0365,STR0003,oFArial09 ) 	// "DADOS DA PECA"
Else
	oPrint:Say(lin+20,0365,STR0004,oFArial09 ) 	// "INSTRUMENTO DE MEDICAO"
EndIf

oPrint:Say(lin+20,1565,STR0005,oFArial09 ) 		// "ESPECIFICACOES ESTUDO"

If nModulo == 47 // Modulo PPAP  
	oPrint:Say(lin+100,0040,STR0006+" :"	   ,oFArial08 ) 	// "Nome"
	aTxt := JustificaTXT(QK1->QK1_DESC,47,.T.)	
	oPrint:Say(lin+100,0140,aTxt[1],oFCouri10N)
	If Len(aTxt) > 1
		oPrint:Say(lin+130,0140,aTxt[2],oFCouri10N)
	EndIf

	oPrint:Say(lin+160,0040,STR0007+" :" ,oFArial08 ) 	// "Codigo"
	oPrint:Say(lin+160,0190,QK1->QK1_PECA,oFCouri10 )

	If !Empty(AllTrim(QM4->QM4_INSTRP))
		oPrint:Say(lin+220,0040,STR0008+" :" ,oFArial08 ) 	// "Instrumento"
		oPrint:Say(lin+220,0210,QM4->QM4_INSTRP,oFCouri10 )
	EndIf
	
	oPrint:Say(lin+70,1240,STR0009+" :" 	,oFArial08 ) 	// "Caracteristica"
	aTxt := JustificaTXT(QK2->QK2_DESC,30,.T.)	
	oPrint:Say(lin+70,1480,aTxt[1],oFCouri10N)
	If Len(aTxt) > 1
		oPrint:Say(lin+100,1480,aTxt[2],oFCouri10N)
	EndIf
Else
	oPrint:Say(lin+130,0040,STR0006+" :"	   ,oFArial08 ) 	// "Nome"
	oPrint:Say(lin+130,0140,QM2->QM2_DESCR,oFCouri10N)  
	
	oPrint:Say(lin+190,0040,STR0007+" :" ,oFArial08 ) 	// "Codigo"
	oPrint:Say(lin+190,0190,QM2->QM2_INSTR,oFCouri10 )
	
	oPrint:Say(lin+70,1240,STR0009+" :" 	,oFArial08 ) 	// "Caracteristica"
	oPrint:Say(lin+70,1480,QM4->QM4_CARACT,oFCouri10N)
EndIf

oPrint:Say(lin+120,1240,STR0010+" :" 			,oFArial08 ) 	// "Especificacao Minima"
oPrint:Say(lin+120,1550,QM4->QM4_LIE,oFCouri10N)
oPrint:Say(lin+120,1800,STR0011+" :" 			,oFArial08 ) 	// "Maxima"
oPrint:Say(lin+120,1950,QM4->QM4_LSE,oFCouri10N)
oPrint:Say(lin+170,1240,STR0012+" :" ,oFArial08 ) 	// "Unidade de Medida"
oPrint:Say(lin+170,1550,QM4->QM4_UM,oFCouri10N )

oPrint:Say(lin+220,1240,STR0039+" :" 			,oFArial08 ) 	// "Tipo Estudo" 
oPrint:Say(lin+220,1550,QM4->QM4_TIPO + "-" + x3combo("QM4_TIPO",QM4->QM4_TIPO),oFCouri10N )
oPrint:Say(lin+270,1240,STR0040+" :" 			,oFArial08 ) 	//"Edição do MSA"  
oPrint:Say(lin+270,1550,QM4->QM4_TPMSA + "-" + x3combo("QM4_TPMSA",QM4->QM4_TPMSA),oFCouri10N )
oPrint:Say(lin+320,1240,STR0041+" :" 			,oFArial08 ) 	//"Data do Estudo"  
oPrint:Say(lin+320,1550,dtoc(QM4->QM4_DATA),oFCouri10N )
oPrint:Say(lin+320,1800,STR0042+" :" 			,oFArial08 ) 	//"Horário do Estudo" 
oPrint:Say(lin+320,2100,QM4->QM4_HORA,oFCouri10N )    

oPrint:Box(lin+370,0030,lin+570, 2375)

oPrint:Say(Lin+380,0035,STR0043,oFArial08)		//"Realizado por: "
oPrint:Say(lin+380,0240,QM4->QM4_REAPOR,oFCouri10N)
oPrint:Line(lin+420, 0030, lin+420 , 2375 )   	

oPrint:Say(Lin+430,0035,STR0045,oFArial08)		//"Observações: "
oPrint:Say(lin+430,0240,QM4->QM4_OBS,oFCouri10N)
oPrint:Line(lin+470, 0030, lin+470 , 2375 )   	

oPrint:Say(Lin+480,0035,STR0046,oFArial08)		//"Disponivel: "
oPrint:Say(lin+480,0240,QM4->QM4_DISPOS,oFCouri10N)
oPrint:Line(lin+520, 0030, lin+520 , 2375 )   	

oPrint:Say(Lin+530,0035,STR0047,oFArial08)		//"Responsável: "

cCodMat := QM4->QM4_RESP
DbSelectArea("QAA")
DbSetOrder(1)   

If DbSeek(xFilial("QAA")+cCodMat)
	cNome := QAA->QAA_NOME
Endif

oPrint:Say(lin+530,0240,cNome,oFCouri10N)

oPrint:Line(lin+570, 0030, lin+570 , 2375 )   	

lin += 580

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³Q190RecDad³ Autor ³ Cicero Odilio Cruz    | Data ³ 11.12.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Recupera dados do Estudo de R&R a ser analisado            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabecalho(ExpO1,ExpN1)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR130                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Q190RecDad(aAnalise, aTexto)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//|Estrutura do array gerado:                                           |
//|                                                                     |
//|  aAnalise: [1] - Operador (Limitado a  5)                           |
//|	     	   [1][1] - ID                                              |
//|	     	   [1][2] - Ciclos                                          |
//|	     	   [1][2][1] - Ciclo ID                                     |
//|	      	   [1][2][1][1] - Medicao 1                                 |
//|		       [1][3] - Media Medicoes                                  |
//|		       [1][4] - Amplitude Medicoes                              |
//|		       [N] - Valor Real                                         |
//|  	       [N][1] - Peca 01                                         |
//|  	       [N][1][1] - Numero da Peca		                        |
//|  	       [N][1][2] - Valor Real Peca 01                           |
//|                                                                     |
//| N representa o ultimo elemento que  tem o valor  real das amostras. |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local n       := 0
Local nO 	  := 0     
Local nC 	  := 0    
Local nX	  := 0     
Local nY 	  := 0      
Local nMin    := 0
Local nMax    := 0
Local nMinG   := 0
Local nMaxG   := 0
Local nAux    := 0
Local nMed    := 0
Local nAmpMin := 0
Local nAmpMax := 0
Local nHdl    := 0   

Local aMed    := {}
Local aAmp    := {}
Local aAux 	  := {}
Local aAux2	  := {}    

Local cRef        := qmt150VIni("QM4","QM4_LIE")

For nY := 1 To QM4->QM4_NENSR // Monto a estrutura dos Operadores
	aAdd(aAnalise,{STRZERO(nY,3),{}})    
    For nX := 1 To QM4->QM4_NPECAS
	    aAdd(aAux2, padr(STRZERO(nY,3),6," "))
	Next 
    For nX := 1 to QM4->QM4_NCICLO // Monto a estrutura dos Clicos    
		aAdd(aAnalise[nY][2],{STRZERO(nX,3),{}})
	Next	
Next

QM5->(DbSetOrder())
QM5->(DbSeek(xFilial("QM5")+QM4->QM4_INSTR+QM4->QM4_REVINS+DtoS(QM4->QM4_DATA))) 
nO   := 1  
nC   := QM5->QM5_CICLO 
nX   := 0
cOperAnt := QM5->QM5_ENSR 
aAux := {}  
While !QM5->(Eof()) .AND. QM4->QM4_INSTR+QM4->QM4_REVINS+DtoS(QM4->QM4_DATA) == QM5->QM5_INSTR+QM5->QM5_REVINS+DtoS(QM5->QM5_DATA)
	If QM4->QM4_HORA <> QM5->QM5_HORA
		QM5->(DBSkip())	
		Loop           
	EndIf
    
	If cOperAnt <> QM5->QM5_ENSR   
		aAnalise [nO][1] := cOperAnt  
		aAnalise [nO][2][nC][2] := aClone(aAux)
		aAux := {}
        cOperAnt := QM5->QM5_ENSR 
		nC := QM5->QM5_CICLO
		nO ++
	ElseIf nC <> QM5->QM5_CICLO
		aAnalise [nO][2][nC][2] := aClone(aAux)
		aAux := {}
		nC := QM5->QM5_CICLO
	EndIf
	
	aAdd(aAux, QM5->QM5_MEDIC)

	QM5->(DBSkip())
	nX := 1
Enddo

If nX == 1 // insiro o ultimo array
	aAnalise [nO][1] := cOperAnt 
	aAnalise [nO][2][nC][2] := aClone(aAux)
EndIf

nO := 1
nC := 1
aAux := {}
For nX := 1 to Len(aAnalise[nO][2][nC][2])   
	aAdd(aMed,"")  
	aAdd(aAmp,"")  
Next

For nY := 1 To QM4->QM4_NENSR // Monto a estrutura dos Operadores
	aAdd(aAnalise[nY],aClone(aMed))
	aAdd(aAnalise[nY],aClone(aAmp))
Next

aAux := {}
nHdl  := QMT150RAPer(@aAux)
aAdd(aAnalise,aClone(aAux))
FClose(nHdl)

aAux  := {}
nMinG := 99999999999
nMaxG := 0                  
nAmpMin := 99999999999
nAmpMax := 0
n := 1
nVal := 0
For nO := 1 To QM4->QM4_NENSR
	For nY := 1 to Len(aAnalise[nO][2][nC][2]) 
	    nMin := 99999999999
	    nMax := 0
	    nAux := 0
		For nX := 1 to Len(aAnalise[nO][2])
		    If nMin > Val(aAnalise[nO][2][nX][2][nY])
		   	    nMin := Val(aAnalise[nO][2][nX][2][nY])
		   	EndIf    
	    	If nMax < Val(aAnalise[nO][2][nX][2][nY])
	    		nMax := Val(aAnalise[nO][2][nX][2][nY])
		    EndIF   
		    If nMinG > Val(aAnalise[nO][2][nX][2][nY])
	   		    nMinG := Val(aAnalise[nO][2][nX][2][nY])
		   	EndIf    
		    If nMaxG < Val(aAnalise[nO][2][nX][2][nY])
		    	nMaxG := Val(aAnalise[nO][2][nX][2][nY])
	    	EndIF 
		    nAux += Val(aAnalise[nO][2][nX][2][nY])
		Next
		aAnalise[nO][4][nY] := Iif((nMax - nMin) == 0,Right(StrTran(STRZERO(0,LEN(cRef)+1,(qa_numdec(cRef)+1)),".",","),LEN(cRef)),;
									  					AllTrim(Transform(nMax - nMin, "@E "+Replicate("9",AT(".",ALLTRIM(STR(nAux/QM4->QM4_NCICLO)))-1)+"."+Replicate("9",qa_numdec(cRef)+1))))
		aAnalise[nO][3][nY] := Iif(nAux == 0,Right(StrTran(STRZERO(0,LEN(cRef)+1,(qa_numdec(cRef)+1)),".",","),LEN(cRef)),;
								StrTran(Transform((nAux/QM4->QM4_NCICLO),if(AT(".",ALLTRIM(STR(nAux/QM4->QM4_NCICLO))) > 0,Replicate("9",AT(".",ALLTRIM(STR(nAux/QM4->QM4_NCICLO)))-1),Replicate("9",AT(".",ALLTRIM(STR(nAux/QM4->QM4_NCICLO)+"."))-1))+"."+Replicate("9",qa_numdec(cRef)+1)),".",","))
		aAdd(aAux, padr(AllTrim(aAux2[n]),6," ") + Iif(AT("*",aAnalise[nO][4][nY]) > 0,padr(cRef,10," "),padr(aAnalise[nO][4][nY],10," ")))
		aAux2[n] := aAux2[n] + Iif(AT("*",aAnalise[nO][3][nY]) > 0,padr(cRef,10," "),padr(aAnalise[nO][3][nY],10," ")) + padr(aAnalise[Len(aAnalise)][nY][2],10," ")
		nMed  := nMed + SuperVal(aAnalise[nO][3][nY]) 
		If nAmpMin > SuperVal(aAnalise[nO][4][nY]) 
		    nAmpMin := SuperVal(aAnalise[nO][4][nY]) 
		EndIf    
		If nAmpMax < SuperVal(aAnalise[nO][4][nY]) 
		  	nAmpMax := SuperVal(aAnalise[nO][4][nY]) 
		EndIF 
		If AT("*",aAnalise[nO][3][nY]) > 0    // Evito valores zuados na tabela
			aAnalise[nO][3][nY] := cRef
		EndIf 
		If AT("*",aAnalise[nO][4][nY]) > 0    // Evito valores zuados na tabela
			aAnalise[nO][4][nY] := cRef
		EndIf		
		n++
	Next
Next

// Montagem do arquivo NAO USAR STRs
aAdd(aTexto,"QACHART.DLL - ESTUDO RR")
aAdd(aTexto,"[VALOR MEDIDO]")
aAdd(aTexto,StrTran(str(nMinG+((nMaxG-nMinG)/2)),".",","))
aAdd(aTexto,"[VALOR REAL]")
aAdd(aTexto,StrTran(str(nMinG+((nMaxG-nMinG)/2)),".",","))
aAdd(aTexto,"[MEDIA AMPLITUDE]")
aAdd(aTexto,StrTran(str(nAmpMin+((nAmpMax-nAmpMin)/2)),".",","))
aAdd(aTexto,"[OPERADORES]")
aAdd(aTexto,StrTran(str(QM4->QM4_NENSR),".",","))
aAdd(aTexto,"[INICIO DE DADOS]")

For nX := 1 To n-1 
	aAdd(aTexto,aAux2[nX])
Next                     
aAdd(aTexto,"[FIM DE DADOS]")
aAdd(aTexto,"[INICIO AMPLITUDE]")
For nX := 1 To n-1 
	aAdd(aTexto,aAux[nX])
Next                     
aAdd(aTexto,"[FIM AMPLITUDE]")

Aadd(aTexto,"[LANGUAGE]")
Aadd(aTexto,Upper(__Language) )

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³Q190ImpMOp³ Autor ³ Cicero Odilio Cruz    | Data ³ 14.12.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprime os dados de Media por operador plotados no Grafico ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Q190ImpMOp(ExpO1, ExpO2)                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpO2 = Array com os Dados                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR130                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Q190ImpMOp(oPrint, aAnalise, lin)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//|aAnalise: [1] - Operador (Limitado a  5)                             |
//|	   	     [1][1] - Ciclo                                             |
//|	    	 [1][1][1] - Medicoes Ciclo                                 |
//|	     	 [1][1][1][1] - Medicao 1                                   |
//|		     [1][3] - Media Medicoes                                    |
//|		     [1][2] - Amplitude Medicoes                                |
//|		     [N] - Valor Real                                           |
//|  	     [N][1] - Valor Real Peca 01                                |
//| N representa o ultimo elemento que  tem o valor  real das amostras. |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Declaração de Variaveis.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local i 	 := 	160		// Fator de impressao do quadro
Local nEC	 :=		 80 	// Tamanho das linhas   
Local nCol   :=  	  0 	// Fator de movimentacao da coluna
Local nFatC	 :=  	200		// Tamanho das Colunas
Local nCtr   := 	  0 	// Controle dos divisores
Local nC     :=		  0 	// 
Local nL     :=		  0 	// 
Local nMed	 :=		  0		// Somatoria das Medias
Local nAmp	 := 	  0		// Somatoria das Amplitudes  
Local nVReal := 	  0		// Somatoria do Valor Real
Local nDecM  := 	  0		// Numero de Decimais Media
Local nDecA  := 	  0     // Numero de Decimais Amplitude
Local linAnt := 	  0 	// Variavel auxiliar para o controle da linha de impressao
Local aAux   := 	  {}	// Array com a somatoria

//Box Cabecalho
oPrint:Box ( lin   , 0030, lin+i+(QM4->QM4_NPECAS*nEC)+(2*nEC), 2375 		 	 )
oPrint:Line( lin+i , nFatC, lin+i                   	     	, 2375-(nFatC-25)) 	// horizontal
oPrint:Line( lin, nFatC, lin+i+(QM4->QM4_NPECAS*nEC)+(2*nEC)	, nFatC 		  ) // Vertical 2

For nCol := (2 * nFatC)  to 2200 step nFatC
	nCtr++
	If Round(nCtr/2,0) == (nCtr/2)
		oPrint:Line( lin , nCol, lin+i+(QM4->QM4_NPECAS*nEC)+(2*nEC)	, nCol )   	// Vertical 1
	Else
		oPrint:Line( lin+i, nCol, lin+i+(QM4->QM4_NPECAS*nEC)+(2*nEC)	, nCol )   	// Vertical 2
	EndIf
Next 

linAnt := lin
For nC:=0 to QM4->QM4_NPECAS
	lin += nEC
	oPrint:Line(lin+i, 0030, lin+i , 2375 )   	// horizontal
Next

lin   := linAnt
lin   += 80
nOper := 0      
For nC := 1 To (QM4->QM4_NENSR*2)
	If Round(nC/2,0) <> (nC/2)
		nAmp := 0
		nMed := 0
		nOper ++
		If nC == 1
			nCol := 200
			oPrint:Say(lin+20 ,0050     ,STR0013,oFArial10 )	// "Amostra" 
			oPrint:Say(lin+100,nCol+0020,STR0014,oFArial10 )	// "Amplitude"
			oPrint:Say(lin+100,nCol+0240,STR0015,oFArial10 )	// "Media"
			oPrint:Say(lin+100,nCol+0420,STR0014,oFArial10 )	// "Amplitude"
			oPrint:Say(lin+100,nCol+0640,STR0015,oFArial10 )	// "Media"
			oPrint:Say(lin+100,nCol+0820,STR0014 ,oFArial10 )	// "Amplitude"
			oPrint:Say(lin+100,nCol+1040,STR0015,oFArial10 )	// "Media"
			oPrint:Say(lin+100,nCol+1220,STR0014 ,oFArial10 )	// "Amplitude"
			oPrint:Say(lin+100,nCol+1440,STR0015,oFArial10 )	// "Media"
			oPrint:Say(lin+100,nCol+1620,STR0014 ,oFArial10 )	// "Amplitude"
			oPrint:Say(lin+100,nCol+1840,STR0015,oFArial10 )	// "Media"
			oPrint:Say(lin-20 ,nCol+2050,STR0016,oFArial10 )	// "Valor"
			oPrint:Say(lin+20 ,nCol+2055,STR0017,oFArial10 )	// "Real"
			oPrint:Say(lin+60 ,nCol+2030,STR0013,oFArial10 )	// "Amostra" 
			lin   += 80
		EndIf
		nCol := (nFatC*nC)+50  
		oPrint:Say(lin-160,nCol-40,STR0018+" - "+U_Q190ImpAlf(nOper)+": ",oFArial10 ) 	// "Operador"
		oPrint:Say(lin-120,nCol-40,Posicione("QAA", 1, XFILIAL("QAA")+aAnalise[nOper][1], "QAA_APELID" ),oFCouri10) 
		oPrint:Say(lin-80 ,nCol-40,STR0019+" : ",oFArial10 ) 	// "Codigo : "
		oPrint:Say(lin-40 ,nCol-40,aAnalise[nOper][1],oFCouri10)
		For nL := 1 To Len(aAnalise[nOper][4]) 
			If nC == 1
				oPrint:Say(lin+(nL*nEC)+20,0100,STRZERO(nL,2),oFCouri08) 
				nDecA := len(aAnalise[nOper][4][nL])-At(",",aAnalise[nOper][4][nL] )
			EndIf
			oPrint:Say(lin+(nL*nEC)+20,(nC * nFatC)+10,SubStr(aAnalise[nOper][4][nL],1,10),oFCouri08)    
			nAmp  += SuperVal(aAnalise[nOper][4][nL])
		Next
	Else 
		For nL := 1 To Len(aAnalise[nOper][3]) 
			oPrint:Say(lin+(nL*nEC)+20,(nC * nFatC)+10,SubStr(aAnalise[nOper][3][nL],1,10),oFCouri08)    
			nMed += SuperVal(aAnalise[nOper][3][nL])
		Next
		aAdd(aAux,{nAmp, nMed})
	EndIf
	
Next

lin := linAnt + 160
nVReal := 0
For nL := 1 To Len(aAnalise[Len(aAnalise)]) 
	oPrint:Say(lin+(nL*nEC)+20,2375-(nFatC-30),SubStr(aAnalise[Len(aAnalise)][nL][2],1,10),oFCouri08)    
	nVReal += SuperVal(aAnalise[Len(aAnalise)][nL][2])
	nDecM := len(aAnalise[Len(aAnalise)][nL][2])-At(",",aAnalise[Len(aAnalise)][nL][2] )
Next

oPrint:Say(linAnt+i+(QM4->QM4_NPECAS*nEC)+(2*nEC)-(nEC-20),0070            ,STR0015,oFArial10) 
oPrint:Say(linAnt+i+(QM4->QM4_NPECAS*nEC)+(2*nEC)-(nEC-20),2375-(nFatC-30),StrTran(SubStr(AllTrim(Str(Round(nVReal/QM4->QM4_NPECAS,nDecM))),1,10),".",","),oFCouri08) 

nOper := 0
For nC := 1 To (QM4->QM4_NENSR*2)
	If Round(nC/2,0) <> (nC/2)	
		nOper ++
		oPrint:Say(linAnt+i+(QM4->QM4_NPECAS*nEC)+(2*nEC)-(nEC-20),(nC * nFatC)+10,StrTran(SubStr(AllTrim(Str(Round(aAux[nOper][1]/QM4->QM4_NPECAS,nDecA))),1,10),".",","),oFCouri08) 
	Else
		oPrint:Say(linAnt+i+(QM4->QM4_NPECAS*nEC)+(2*nEC)-(nEC-20),(nC * nFatC)+10,StrTran(SubStr(AllTrim(Str(Round(aAux[nOper][2]/QM4->QM4_NPECAS,nDecA))),1,10),".",","),oFCouri08)    
	EndIf
Next 


Return aAux

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³Q190ImpAOp³ Autor ³ Cicero Odilio Cruz    | Data ³ 14.12.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprime a analise Estatistica do estudo de RR              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Q190ImpAOp(ExpO1, ExpO2)                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpO2 = Array com os Dados                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR190                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Q190ImpFAn(oPrint, aAnalise, lin, aMed)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//|aAnalise: [1] - Operador (Limitado a  5)                             |
//|	   	     [1][1] - Ciclo                                             |
//|	    	 [1][1][1] - Medicoes Ciclo                                 |
//|	     	 [1][1][1][1] - Medicao 1                                   |
//|		     [1][3] - Media Medicoes                                    |
//|		     [1][2] - Amplitude Medicoes                                |
//|		     [N] - Valor Real                                           |
//|  	     [N][1] - Valor Real Peca 01                                |
//| N representa o ultimo elemento que  tem o valor  real das amostras. |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local linAnt  := lin
Local nX	  := 0
Local nXf	  := 0
Local nRg	  := 0
Local nVe	  := 0
Local npVe	  := 0
Local nVo	  := 0
Local npVo	  := 0
Local nT	  := 0
Local nDecA   := len(aAnalise[1][4][1])-At(",",aAnalise[1][4][1] )
Local nMinX   := 999999999
Local nMaxX   := 0
Local nSumR   := 0
Local nSumX   := 0
Local nSumRl  := 0
Local D4	  := 0
Local K1	  := 0    
Local K2	  := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//|aTab: 	[N][1] -  Indice D4 posicionado por Ciclo                   |
//|	    	[N][2] -  Indice K1 posicionado por Ciclo                   |
//|	    	[N][3] -  Indice K2 quando for posicionado por No ensaiad.es|
//|					  ou                                                |
//|					  Indice K3 quando for posicionado por No pecas     |
//|	    	[N][4] -  Indice D3 posicionado por Ciclo                   |
//|	    	[N][5] -  Indice D2*                                        |
//|	    	[N][6] -  Indice D2                                         |
//|                                                                     |
//| N representa o Numero de Ciclos/Operadoes ou Pecas dependendo do    |
//| indice que se posicionar.		                                    |
//| OBS: Verificar que  para o MSA 3 Edicao                             |
//| 	 K1 = 5.15 / [N][6] onde N posicionado por ciclo                |
//| 	 K2 = 5.15 / (Valor do d2* Apendice C MSA 3 Edicao em Portugues |
//|      posicionados da seguinte Maneira:                              |
//|      g = 1 e                                                        |
//|      m = Numero de Ciclos                                           |
//|      pegar 2 linha da celula posicionada                            |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aTab    := {}

If Alltrim(QM4->QM4_TPMSA) <> "1"
	aTab    := array(25,6) //15
Else
	aTab    := array(25,6) //15
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Dados fornecidos por tabela                                                                  ³
//³ OBS.: Para trabalhar com a tabela deve-se observar os valores por coluna e nao por linha     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Alltrim(QM4->QM4_TPMSA) == "1"
	atab[ 1,1] := 0.000; atab[ 1,2] := 0.00  ; atab[ 1,3] := 0.00  ; atab[ 1,4] := 0.00; atab[ 1,5] := 1.41 // Nao utiliza
	atab[ 2,1] := 3.267; atab[ 2,2] := 0.8862; atab[ 2,3] := 0.7071; atab[ 2,4] := 0.00; atab[ 2,5] := 1.28
	atab[ 3,1] := 2.575; atab[ 3,2] := 0.5908; atab[ 3,3] := 0.5231; atab[ 3,4] := 0.00; atab[ 3,5] := 1.23
	atab[ 4,1] := 2.282; atab[ 4,2] := 0.4857; atab[ 4,3] := 0.4467; atab[ 4,4] := 0.00; atab[ 4,5] := 1.21
	atab[ 5,1] := 2.115; atab[ 5,2] := 0.4299; atab[ 5,3] := 0.4030; atab[ 5,4] := 0.00; atab[ 5,5] := 1.19
	
	atab[ 6,1] := 2.004; atab[ 6,2] := 0.3946; atab[ 6,3] := 0.3742; atab[ 6,4] := 0.00; atab[ 6,5] := 1.18
	atab[ 7,1] := 1.924; atab[ 7,2] := 0.3698; atab[ 7,3] := 0.3534; atab[ 7,4] := 0.08; atab[ 7,5] := 1.17
	atab[ 8,1] := 1.864; atab[ 8,2] := 0.3512; atab[ 8,3] := 0.3375; atab[ 8,4] := 0.14; atab[ 8,5] := 1.17
	atab[ 9,1] := 1.816; atab[ 9,2] := 0.3367; atab[ 9,3] := 0.3249; atab[ 9,4] := 0.18; atab[ 9,5] := 1.16
	atab[10,1] := 1.777; atab[10,2] := 0.3249; atab[10,3] := 0.3146; atab[10,4] := 0.22; atab[10,5] := 1.16
	
	atab[11,1] := 1.744; atab[11,2] := 0.3152; atab[11,3] := 0.3051; atab[11,4] := 0.26; atab[11,5] := 1.16
	atab[12,1] := 1.716; atab[12,2] := 0.3061; atab[12,3] := 0.2985; atab[12,4] := 0.28; atab[12,5] := 1.15
	atab[13,1] := 1.692; atab[13,2] := 0.2998; atab[13,3] := 0.2921; atab[13,4] := 0.31; atab[13,5] := 1.15
	atab[14,1] := 1.671; atab[14,2] := 0.2935; atab[14,3] := 0.2864; atab[14,4] := 0.33; atab[14,5] := 1.15
	atab[15,1] := 1.652; atab[15,2] := 0.2880; atab[15,3] := 0.2814; atab[15,4] := 0.35; atab[15,5] := 1.15
	
	atab[16,1] := 1.636; atab[16,2] := 0.2831; atab[16,3] := 0.2768; atab[16,4] := 0.26; atab[16,5] := 1.16
	atab[17,1] := 1.621; atab[17,2] := 0.2787; atab[17,3] := 0.2729; atab[17,4] := 0.28; atab[17,5] := 1.15
	atab[18,1] := 1.608; atab[18,2] := 0.2747; atab[18,3] := 0.2692; atab[18,4] := 0.31; atab[18,5] := 1.15
	atab[19,1] := 1.596; atab[19,2] := 0.2711; atab[19,3] := 0.2659; atab[19,4] := 0.33; atab[19,5] := 1.15
	atab[20,1] := 1.586; atab[20,2] := 0.2677; atab[20,3] := 0.2628; atab[20,4] := 0.35; atab[20,5] := 1.15
	
	atab[21,1] := 1.575; atab[21,2] := 0.2831; atab[21,3] := 0.2768; atab[21,4] := 0.26; atab[21,5] := 1.16
	atab[22,1] := 1.566; atab[22,2] := 0.2787; atab[22,3] := 0.2729; atab[22,4] := 0.28; atab[22,5] := 1.15
	atab[23,1] := 1.557; atab[23,2] := 0.2747; atab[23,3] := 0.2692; atab[23,4] := 0.31; atab[23,5] := 1.15
	atab[24,1] := 1.548; atab[24,2] := 0.2711; atab[24,3] := 0.2659; atab[24,4] := 0.33; atab[24,5] := 1.15
	atab[25,1] := 1.541; atab[25,2] := 0.2677; atab[25,3] := 0.2628; atab[25,4] := 0.35; atab[25,5] := 1.15
Else
	atab[ 1,1] := 0.000; atab[ 1,2] := 0.00     ; atab[ 1,3] := 0.00     ; atab[ 1,4] := 0.00; atab[ 1,5] := 1.41; atab[ 1,6] := 0.00 // Nao utiliza
	atab[ 2,1] := 3.267; atab[ 2,2] := 4.5640653; atab[ 2,3] := 3.6416091; atab[ 2,4] := 0.00; atab[ 2,5] := 1.28; atab[ 2,6] := 1.12838
	atab[ 3,1] := 2.575; atab[ 3,2] := 3.0427101; atab[ 3,3] := 2.6941487; atab[ 3,4] := 0.00; atab[ 3,5] := 1.23; atab[ 3,6] := 1.69257
	atab[ 4,1] := 2.282; atab[ 4,2] := 2.5015179; atab[ 4,3] := 2.3002675; atab[ 4,4] := 0.00; atab[ 4,5] := 1.21; atab[ 4,6] := 2.05875
	atab[ 5,1] := 2.115; atab[ 5,2] := 2.2141680; atab[ 5,3] := 2.0755751; atab[ 5,4] := 0.00; atab[ 5,5] := 1.19; atab[ 5,6] := 2.32593
	
	atab[ 6,1] := 2.004; atab[ 6,2] := 2.0320311; atab[ 6,3] := 1.9270130; atab[ 6,4] := 0.00; atab[ 6,5] := 1.18; atab[ 1,6] := 2.53441
	atab[ 7,1] := 1.924; atab[ 7,2] := 1.9043323; atab[ 7,3] := 1.8199102; atab[ 7,4] := 0.08; atab[ 7,5] := 1.17; atab[ 1,6] := 2.70436
	atab[ 8,1] := 1.864; atab[ 8,2] := 1.8087946; atab[ 8,3] := 1.7381737; atab[ 8,4] := 0.14; atab[ 8,5] := 1.17; atab[ 1,6] := 2.84720
	atab[ 9,1] := 1.816; atab[ 9,2] := 1.7339892; atab[ 9,3] := 1.6731970; atab[ 9,4] := 0.18; atab[ 9,5] := 1.16; atab[ 1,6] := 2.97003
	atab[10,1] := 1.777; atab[10,2] := 1.6734308; atab[10,3] := 1.6199808; atab[10,4] := 0.22; atab[10,5] := 1.16; atab[ 1,6] := 3.07751
	
	atab[11,1] := 1.744; atab[11,2] := 1.6231362; atab[11,3] := 1.5753620; atab[11,4] := 0.26; atab[11,5] := 1.16; atab[ 1,6] := 3.17287
	atab[12,1] := 1.716; atab[12,2] := 1.5805012; atab[12,3] := 1.5372400; atab[12,4] := 0.28; atab[12,5] := 1.15; atab[ 1,6] := 3.25846
	atab[13,1] := 1.692; atab[13,2] := 1.5437742; atab[13,3] := 1.5041854; atab[13,4] := 0.31; atab[13,5] := 1.15; atab[ 1,6] := 3.33598
	atab[14,1] := 1.671; atab[14,2] := 1.5117003; atab[14,3] := 1.4751544; atab[14,4] := 0.33; atab[14,5] := 1.15; atab[ 1,6] := 3.40676
	atab[15,1] := 1.652; atab[15,2] := 1.4833248; atab[15,3] := 1.4493447; atab[15,4] := 0.35; atab[15,5] := 1.15; atab[ 1,6] := 3.47193
	
	atab[16,1] := 1.636; atab[16,2] := 1.4581057; atab[16,3] := 1.4263123; atab[16,4] := 0.26; atab[16,5] := 1.16; atab[ 1,6] := 3.53198
	atab[17,1] := 1.621; atab[17,2] := 1.4353880; atab[17,3] := 1.4054833; atab[17,4] := 0.28; atab[17,5] := 1.15; atab[ 1,6] := 3.58788
	atab[18,1] := 1.608; atab[18,2] := 1.4148118; atab[18,3] := 1.3865555; atab[18,4] := 0.31; atab[18,5] := 1.15; atab[ 1,6] := 3.64006
	atab[19,1] := 1.596; atab[19,2] := 1.3960574; atab[19,3] := 1.3692511; atab[19,4] := 0.33; atab[19,5] := 1.15; atab[ 1,6] := 3.68896
	atab[20,1] := 1.586; atab[20,2] := 1.3788487; atab[20,3] := 1.3533507; atab[20,4] := 0.35; atab[20,5] := 1.15; atab[ 1,6] := 3.73500
	
	atab[21,1] := 1.575; atab[21,2] := 1.3631551; atab[21,3] := 0.2768   ; atab[21,4] := 0.26; atab[21,5] := 1.16; atab[ 1,6] := 3.778
	atab[22,1] := 1.566; atab[22,2] := 1.3485206; atab[22,3] := 0.2729   ; atab[22,4] := 0.28; atab[22,5] := 1.15; atab[ 1,6] := 3.819
	atab[23,1] := 1.557; atab[23,2] := 1.3348885; atab[23,3] := 0.2692   ; atab[23,4] := 0.31; atab[23,5] := 1.15; atab[ 1,6] := 3.858
	atab[24,1] := 1.548; atab[24,2] := 1.3222080; atab[24,3] := 0.2659   ; atab[24,4] := 0.33; atab[24,5] := 1.15; atab[ 1,6] := 3.895
	atab[25,1] := 1.541; atab[25,2] := 1.3100992; atab[25,3] := 0.2628   ; atab[25,4] := 0.35; atab[25,5] := 1.15; atab[ 1,6] := 3.931
Endif


D4 := atab[QM4->QM4_NCICLO,1]
K1 := Round(atab[QM4->QM4_NCICLO,2],nDecA)   // (Formula - MSA 3Edicao = (1/(Nr.Ensaiadores*Nr.Pecas)))
K2 := Round(atab[QM4->QM4_NENSR,3] ,nDecA)   // (Formula - MSA 3Edicao - (1/Nr.Ensaiadores)

oPrint:Line(lin    , 0030, lin     , 2375 )   	// horizontal Negrito
oPrint:Line(lin+1  , 0030, lin+1   , 2375 )   	
oPrint:Line(lin+2  , 0030, lin+2   , 2375 )   	
oPrint:Line(lin+3  , 0030, lin+3   , 2375 )   	
oPrint:Line(lin+4  , 0030, lin+4   , 2375 ) 

oPrint:Say(lin+10 , 0220, STR0020 , oFArial10 )	// "AMPLITUDE DA MEDIA"
oPrint:Say(lin+60 , 0220, STR0021 , oFArial10 )	// "DOS OPERADORES"
oPrint:Say(lin+10 , 1025, STR0022 , oFArial10 )	// "AMPLITUDE MEDIA"
oPrint:Say(lin+10 , 1760, STR0023 , oFArial10 )	// "LIMITE SUPERIOR DE CONTROLE"
oPrint:Say(lin+60 , 1840, STR0024 , oFArial10 )	// "DA AMPLITUDE MEDIA" 

lin += 125
oPrint:Line(lin    , 0030, lin     , 2375 )   	// horizontal Negrito
oPrint:Line(lin+1  , 0030, lin+1   , 2375 )   	
oPrint:Line(lin+2  , 0030, lin+2   , 2375 )   	
oPrint:Line(lin+3  , 0030, lin+3   , 2375 )   	
oPrint:Line(lin+4  , 0030, lin+4   , 2375 )  

oPrint:Say(lin+10 , 0220, "Xf = Max(X) - Min(X)",oFArial10 )
oPrint:Say(lin+10 , 0925, "Rg = (Ra + ... + Rn)/"+STR0025,oFArial10 ) //"No Operadores"
oPrint:Say(lin+10 , 1840, "LSC(Rg) = R * D4",oFArial10 )

lin += 60
For nX := 1 to Len(aMed)

	oPrint:Say(lin+10 , 0100, "X"+U_Q190ImpAlf(nX, .F.)+" = " ,oFArial10)
	oPrint:Say(lin+10 , 0470, StrTran(SubStr(AllTrim(Str(Round(aMed[nX][2]/QM4->QM4_NPECAS,nDecA))),1,10),".",",") ,oFCouri10)

	oPrint:Say(lin+10 , 0925, "R"+U_Q190ImpAlf(nX, .F.)+" = " ,oFArial10)
	oPrint:Say(lin+10 , 1295, StrTran(SubStr(AllTrim(Str(Round(aMed[nX][1]/QM4->QM4_NPECAS,nDecA))),1,10),".",",") ,oFCouri10)

    If nMinX > Round(aMed[nX][2]/QM4->QM4_NPECAS,nDecA)
   	    nMinX := Round(aMed[nX][2]/QM4->QM4_NPECAS,nDecA)
   	EndIf    
    If nMaxX < Round(aMed[nX][2]/QM4->QM4_NPECAS,nDecA)
   		nMaxX := Round(aMed[nX][2]/QM4->QM4_NPECAS,nDecA)
    EndIf 
    nSumR += Round(aMed[nX][1]/QM4->QM4_NPECAS,nDecA)
    nSumX += Round(aMed[nX][2]/QM4->QM4_NPECAS,nDecA)
    
		    
	lin += 60
Next

nXf := nMaxX-nMinX  
nT := SuperVal(QM4->QM4_LSE) - SuperVal(QM4->QM4_LIE)
nRg := MATHC(nSumR,"/",QM4->QM4_NENSR)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³---------------------- Calculo da Repetibilidade (Ve) ----------------------³
//³                                                                            ³
//³formula: nVe = Rg  *  K1                                                    ³
//³                                                                            ³
//³onde: K1 e o 2 coluna da tabela aTab posicionada por Ciclo                  |
//³                                                                            ³
//³formula: npVe = 100 * nVe / nT                                              ³
//³                                                                            ³
//³onde: K1 e o 2 coluna da tabela aTab posicionada por Ciclo                  |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nVe  := MATHC(nRg,"*",K1)
npVe := MATHC(MATHC(100,"*",nVe),"/",nT )

oPrint:Say(lin+10 , 0100, "Max(X) =",oFArial10 )
oPrint:Say(lin+10 , 0470, StrTran(SubStr(AllTrim(Str(nMaxX)),1,10),".",","),oFCouri10)
oPrint:Say(lin+10 , 0925, STR0026+" =",oFArial10 ) //"Soma"
oPrint:Say(lin+10 , 1295, SubStr(AllTrim(Str(nSumR)),1,10),oFCouri10)
lin += 60

oPrint:Say(lin+10 , 0100, "Min(X) =",oFArial10 )
oPrint:Say(lin+10 , 0470, StrTran(SubStr(AllTrim(Str(nMinX)),1,10),".",","),oFCouri10)
oPrint:Say(lin+10 , 0925, STR0025+" =",oFArial10 )
oPrint:Say(lin+10 , 1295, SubStr(AllTrim(Str(QM4->QM4_NENSR)),1,10),oFCouri10)  

oPrint:Say(lin-(60*nX)+10       	, 1840, "Rg = ",oFArial10)	
oPrint:Say(lin-(60*nX)+10       	, 2210, StrTran(SubStr(AllTrim(Str(val(nRg))),1,10),".",","),oFArial10)
oPrint:Say(lin-((60*nX)-60)+10  	, 1840, "D4 = "+SubStr(AllTrim(Str(QM4->QM4_NENSR)),1,10),oFArial10)	
oPrint:Say(lin-((60*nX)-60)+10  	, 2100, STR0027+"= "+StrTran(SubStr(AllTrim(Str(D4)),1,10),".",","),oFArial10)

lin += 60
oPrint:Line(lin    , 0030, lin     , 2375 )   	// horizontal Negrito
oPrint:Line(lin+1  , 0030, lin+1   , 2375 )   	
oPrint:Line(lin+2  , 0030, lin+2   , 2375 )   	
oPrint:Line(lin+3  , 0030, lin+3   , 2375 )   	
oPrint:Line(lin+4  , 0030, lin+4   , 2375 )  

oPrint:Say(lin+10  	, 0100, "Xf = ",oFArial10)	
oPrint:Say(lin+10  	, 0470, StrTran(SubStr(AllTrim(Str(nXf)),1,10),".",","),oFCouri10)
oPrint:Say(lin+10  	, 0925, "Rg = ",oFArial10)	
oPrint:Say(lin+10  	, 1295, StrTran(SubStr(AllTrim(Str(Val(nRg))),1,10),".",","),oFArial10)
oPrint:Say(lin+10	, 1840, "LSC(Rg) = ",oFArial10)
oPrint:Say(lin+10 	, 2210, StrTran(SubStr(AllTrim(Str(Round((nSumR/QM4->QM4_NENSR)*D4,nDecA))),1,10),".",","),oFArial10)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³--------------------- Calculo da Reprodutibilidade ( Vo) ----------- ³
//³                                                                     ³
//³ formula:    nVo = sqrt({[(nXf)*(K2)]^2} - [(Ve^2)/(n*r)])           ³
//³ sendo que : Xdif = diferenca das medias mais alta e media mais baixa³
//³             n  = numero de pecas                                    ³
//³             r  = numero de medicoes                                 ³
//³                                                                     ³
//³formula: npVo = 100 * nVo / nT                                       ³
//³                                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
nVo := MATHC(MATHC(MATHC(nXf,"*",K2),"e",2),"-",	MATHC(MATHC(Round(Val(nVe),nDecA),"e",2),"/",MATHC(QM4->QM4_NCICLO,"*",QM4->QM4_NPECAS)))
nVo := iif(val(nVo)<=0,"0",MATHC(nVo,"e",0.5))
npVo := MATHC(MATHC("100","*",nVo),"/",nT)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³---- Calculo de Repetibilidade e Reprodutibilidade ( R & R )  ---³
//³                                                                 ³
//³formula: nRR = sqrt((Ve^2) + (Vo^2))                             ³
//³                                                                 ³
//³formula: npRR = 100 * nVo / nT                                   ³
//|																	|
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nRR := MATHC(MATHC(MATHC(nVe,"e",2),"+",MATHC(nVo,"e",2)),"e",0.5)
npRR := MATHC(MATHC(MATHC(npVe,"e",2),"+",MATHC(nVo,"e",2)),"e",0.5)

lin += 60
oPrint:Line(lin    , 0030, lin     , 2375 )   	// horizontal Negrito
oPrint:Line(lin+1  , 0030, lin+1   , 2375 )   	
oPrint:Line(lin+2  , 0030, lin+2   , 2375 )   	
oPrint:Line(lin+3  , 0030, lin+3   , 2375 )   	
oPrint:Line(lin+4  , 0030, lin+4   , 2375 ) 

oPrint:Line(lin+10 , 0030, lin+10  , 2375 )   	// horizontal Negrito
oPrint:Line(lin+11 , 0030, lin+11  , 2375 )   	
oPrint:Line(lin+12 , 0030, lin+12  , 2375 )   	
oPrint:Line(lin+13 , 0030, lin+13  , 2375 )   	
oPrint:Line(lin+14 , 0030, lin+14  , 2375 ) 

oPrint:Say(lin+10  	, 0100, STR0028, oFArial10)	 // "ERRO DE EXATIDAO"
oPrint:Say(lin+10  	, 0600, STR0029, oFArial10)	 // "REPETIBILIDADE"
oPrint:Say(lin+10  	, 1150, STR0030, oFArial10)	 // "REPRODUTIBILIDADE"
oPrint:Say(lin+10  	, 1670, STR0031, oFArial10) // "REPETIBILIDADE - REPRODUTIBILIDADE"

lin += 60
oPrint:Line(lin    , 0030, lin     , 2375 )   	// horizontal Negrito
oPrint:Line(lin+1  , 0030, lin+1   , 2375 )   	
oPrint:Line(lin+2  , 0030, lin+2   , 2375 )   	
oPrint:Line(lin+3  , 0030, lin+3   , 2375 )   	
oPrint:Line(lin+4  , 0030, lin+4   , 2375 )  

oPrint:Say(lin+10  	, 0100, "Ee = Xg - Xr",oFArial10)	
oPrint:Say(lin+10  	, 0600, "Ve = Rg * K1",oFArial10)	
oPrint:Say(lin+10  	, 1150, "Vo = SQR[(Xf*K2)^2-Ve^2/n*r]",oFArial10)	
oPrint:Say(lin+10  	, 1800, "R&R = SQR(Ve^2+Vo^2)",oFArial10)	

lin += 60
oPrint:Say(lin+10  	, 0030, "Xg = (Xa + ... + Xn)/"+STR0025,oFArial08)	// "No Operadores"
oPrint:Say(lin+10  	, 0550, "%Ve = 100 * Ve / "+STR0032,oFArial08)	// "Tolerancia"
oPrint:Say(lin+10  	, 1150, "%Vo = 100 * Vo / "+STR0032,oFArial08)	// "Tolerancia"	
oPrint:Say(lin+10  	, 1800, "%R&R = SQR(%Ve^2 + Vo^2)",oFArial08)	

lin += 60
oPrint:Say(lin+10  	, 0100, "Xg = ",oFArial10)	
oPrint:Say(lin+10 	, 0270, StrTran(SubStr(AllTrim(Str(Round((nSumX/QM4->QM4_NENSR),nDecA))),1,10),".",","),oFArial10)
oPrint:Say(lin+10  	, 0600, "Rg = ",oFArial10)	
oPrint:Say(lin+10  	, 0770, StrTran(SubStr(AllTrim(Str(nSumR/QM4->QM4_NENSR)),1,10),".",","),oFArial10)
oPrint:Say(lin+10  	, 1150, "Xf = ",oFArial10)	
oPrint:Say(lin+10  	, 1320, StrTran(SubStr(AllTrim(Str(nXf)),1,10),".",","),oFArial10)
oPrint:Say(lin+10  	, 1800, "Ve = ",oFArial10)	
oPrint:Say(lin+10  	, 1970, StrTran(SubStr(AllTrim(Str(Round(Val(nVe),nDecA+1))),1,10),".",","),oFArial10)

lin += 60
oPrint:Say(lin+10  	, 0600, "K1 = "+StrTran(SubStr(AllTrim(Str(K1)),1,10),".",","),oFArial10)	
oPrint:Say(lin+10  	, 1150, "K2 = "+StrTran(SubStr(AllTrim(Str(K2)),1,10),".",","),oFArial10)	
oPrint:Say(lin+10  	, 1800, "%Ve ="+StrTran(SubStr(AllTrim(Str(Round(Val(npVe),1))),1,10),".",","),oFArial10)	


lin += 60
For nX := 1 To Len(aAnalise[Len(aAnalise)]) 
	nSumRl += SuperVal(aAnalise[Len(aAnalise)][nX][2])
Next 
oPrint:Say(lin+10  	, 0100, "Xr = ",oFArial10)	
oPrint:Say(lin+10 	, 0270, StrTran(SubStr(AllTrim(Str(Round((nSumRl/(nX-1)),nDecA))),1,10),".",","),oFArial10)
oPrint:Say(lin+10  	, 0700, AllTrim(Str(QM4->QM4_NCICLO))+" "+STR0027, oFArial10)	//"ciclos"
oPrint:Say(lin+10  	, 1250, AllTrim(Str(QM4->QM4_NENSR))+" "+STR0033, oFArial10)	//"operadores"

lin += 60
oPrint:Say(lin+10  	, 0600, STR0032+" = "+StrTran(SubStr(AllTrim(Str(nT)),1,10),".",","),oFArial10)	// "Tolerancia"	
oPrint:Say(lin+10  	, 1150, STR0034+" = "+AllTrim(Str(QM4->QM4_NPECAS)),oFArial10) // "n(No Amostras)"	
oPrint:Say(lin+10  	, 1800, "Vo ="+StrTran(SubStr(AllTrim(Str(Round(Val(nVo),nDecA+2))),1,10),".",","),oFArial10)	

lin += 60
oPrint:Say(lin+10  	, 1150, STR0035+" = "+AllTrim(Str(QM4->QM4_NCICLO)),oFArial10)	
oPrint:Say(lin+10  	, 1800, "%Vo = "+StrTran(SubStr(AllTrim(Str(Round(Val(npVo),1))),1,10),".",","),oFArial10)

lin += 60
oPrint:Say(lin+10  	, 11500, STR0032+" = "+StrTran(SubStr(AllTrim(Str(nT)),1,10),".",","),oFArial10)		// "Tolerancia"	

lin += 60
oPrint:Line(lin    , 0030, lin     , 2375 )   	// horizontal Negrito
oPrint:Line(lin+1  , 0030, lin+1   , 2375 )   	
oPrint:Line(lin+2  , 0030, lin+2   , 2375 )   	
oPrint:Line(lin+3  , 0030, lin+3   , 2375 )   	
oPrint:Line(lin+4  , 0030, lin+4   , 2375 )  

oPrint:Say(lin+10  	, 0100, "Ee = ",oFArial10)	
oPrint:Say(lin+10 	, 0270, StrTran(SubStr(AllTrim(Str(Round((nSumX/QM4->QM4_NENSR),nDecA)-Round((nSumRl/(nX-1)),nDecA))),1,10),".",","),oFArial10)
oPrint:Say(lin+10  	, 0600, "Ve = ",oFArial10)	
oPrint:Say(lin+10  	, 0770, StrTran(SubStr(AllTrim(Str(Round(Val(nVe),nDecA))),1,10),".",","),oFArial10)
oPrint:Say(lin+10  	, 1200, "Vo = ",oFArial10)	
oPrint:Say(lin+10  	, 1370, StrTran(SubStr(AllTrim(Str(Round(Val(nVo),nDecA))),1,10),".",","),oFArial10)
oPrint:Say(lin+10  	, 1800, "R&R = ",oFArial10)	
oPrint:Say(lin+10  	, 1970, StrTran(SubStr(AllTrim(Str(Round(Val(nRR),nDecA+1))),1,10),".",","),oFArial10)

lin += 60
oPrint:Say(lin+10  	, 0550, "%Ve = ",oFArial10)	
oPrint:Say(lin+10  	, 0770, StrTran(SubStr(AllTrim(Str(Round(Val(npVe),1))),1,10),".",",")+" %",oFArial10)
oPrint:Say(lin+10  	, 1150, "%Vo = ",oFArial10)	
oPrint:Say(lin+10  	, 1370, StrTran(SubStr(AllTrim(Str(Round(Val(npVo),1))),1,10),".",",")+" %",oFArial10)
oPrint:Say(lin+10  	, 1750, "%R&R = ",oFArial10)	
oPrint:Say(lin+10  	, 1970, StrTran(SubStr(AllTrim(Str(Round(Val(npRR),1))),1,10),".",",")+" %",oFArial10)

lin += 60
oPrint:Line(lin    , 0030, lin     , 2375 )   	// horizontal Negrito
oPrint:Line(lin+1  , 0030, lin+1   , 2375 )   	
oPrint:Line(lin+2  , 0030, lin+2   , 2375 )   	
oPrint:Line(lin+3  , 0030, lin+3   , 2375 )   	
oPrint:Line(lin+4  , 0030, lin+4   , 2375 ) 

lin := linAnt

Return Nil



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³Q190ImpAlf³ Autor ³ Cicero Odilio Cruz    | Data ³ 14.12.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprime a Letra do Alfabeto ref ao numero                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Q190ImpAlf(ExpO1)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Numero                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR190                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Q190ImpAlf(nAux, lUpperCase)
Local aAux := {}

Default lUpperCase  := .T.

If lUpperCase
	aAux := {"A","B","C","D","E"}
Else
	aAux := {"a","b","c","d","e"}
EndIf

Return aAux[nAux] 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³QM190Fil  ³ Autor ³ Cicero Odilio Cruz    | Data ³ 22.12.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Filtro que separa registros do PPAP / QMT                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QM190Fil()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR190                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QM190Fil()
Local lRet := .T.

If nModulo == 47 // Modulo PPAP  
	If Empty(AllTrim(QM4->QM4_PECA1))
		lRet := .F.
	EndIf
Else
	If Empty(AllTrim(QM4->QM4_INSTR))
		lRet := .F.
	EndIf
EndIf

Return lRet
