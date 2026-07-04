/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr590.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 2 //Versao do fonte
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR590  ³ Autor ³Denis Hyroshi de Souza ³ Data ³06/05/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio da Ficha de Investigacao do Acidente              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR590()                                                
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

PRIVATE cPerg := ""

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
cPerg    := If(!lSigaMdtPS,"MDT590    ","MDT590PS  ")

/*-----------------------
//PERGUNTAS PADRÃO		|
| 01 Tipo Impressao ?	|
| 02 Funcionario ?		| 
-------------------------*/

If pergunte(cPerg,.t.)   
	U_MDT590IMP()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ MDT590IMP³ Autor ³Denis Hyroshi de Souza ³ Data ³06/05/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT590IMP()
Local oPrint
Private cAlias := "SI3"   
Private cDescr := "SI3->I3_DESC"
Private lin := 0    
Private oFont08,oFont09,oFont10,oFont11,oFont12,oFont13,oFont14
oFont08	:= TFont():New("COURIER NEW",08,08,,.T.,,,,.F.,.F.)
oFont09	:= TFont():New("COURIER NEW",09,09,,.F.,,,,.F.,.F.)
oFont10 := TFont():New("COURIER NEW",10,10,,.T.,,,,.F.,.F.)
oFont11	:= TFont():New("COURIER NEW",11,11,,.T.,,,,.F.,.F.)
oFont12	:= TFont():New("COURIER NEW",12,12,,.T.,,,,.F.,.F.)
oFont13	:= TFont():New("COURIER NEW",13,13,,.F.,,,,.F.,.F.)
oFont14	:= TFont():New("COURIER NEW",13,13,,.T.,,,,.F.,.F.)

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAlias := "CTT"
	cDescr := "CTT->CTT_DESC01"
Endif

oPrint	:= TMSPrinter():New(OemToAnsi(STR0001)) //"Ficha Investigação"
oPrint:Setup()

U_INDMDT590(oPrint)  

If Mv_par01 = 2
	oPrint:Print()
Else
	oPrint:Preview()
Endif                  
       
Return .t.         
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ INDMDT590³ Autor ³Denis Hyroshi de Souza ³ Data ³06/05/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Relatorio                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function INDMDT590(oPrint)      

Local cFuncao
Local nTa1 := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
Local nTa1L := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
Local nSizeTD := nTa1+nTa1L

lin := 250

Dbselectarea("SRA")
Dbsetorder(01)
If Dbseek(xFilial("SRA")+Mv_par02)
	oPrint:StartPage()
                                     
	Dbselectarea(cAlias)
	Dbsetorder(1)
	Dbseek(xFilial(cAlias)+SRA->RA_CC)  
	Dbselectarea("SRJ")
	Dbsetorder(1)
	Dbseek(xFilial("SRJ")+SRA->RA_CODFUNC)	
	Dbselectarea("SQ3")
	Dbsetorder(1)
	Dbseek(xFilial("SQ3")+SRJ->RJ_CARGO)

	If lSigaMdtps
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial("SA1")+SubStr(SRA->RA_CC,1,nSizeTd))
		cEmpresa  := Alltrim(SA1->A1_NOME)
	Else
		cEmpresa  := Alltrim(SM0->M0_NOMECOM)
	Endif

	lin := 200
	oPrint:Say(lin,50,STR0025,oFont14) //"REF: ACIDENTE DO TRABALHO - COM/SEM AFASTAMENTO (UNIDADE:_______________________)"
	oPrint:Say(lin,1660,Substr(cEmpresa,1,25),oFont10)

	lin := 400
	oPrint:Say(lin,50,STR0002,oFont13)	 //"NOME:"
	oPrint:Say(lin,210,Substr(Alltrim(SRA->RA_NOME),1,35),oFont10)
	oPrint:Line(lin+40,200,lin+40,1020)

	oPrint:Say(lin,1040,STR0003,oFont13)	 //"RG:"
	oPrint:Say(lin,1140,Alltrim(SRA->RA_RG),oFont10)
	oPrint:Line(lin+40,1130,lin+40,1500)
	
	oPrint:Say(lin,1520,STR0004,oFont13)	 //"ÁREA:"
	oPrint:Say(lin,1680,Substr(Alltrim(&cDescr),1,25),oFont10)
	oPrint:Line(lin+40,1670,lin+40,2300)

	lin := 520

	oPrint:Say(lin,50,STR0005,oFont13)	 //"ADMISSÃO:"
	oPrint:Say(lin,350,DtoC(SRA->RA_ADMISSA),oFont10)
	oPrint:Line(lin+40,340,lin+40,700)

	oPrint:Say(lin,740,STR0006,oFont13) //"TEMPO DE SERVIÇO:"
	oPrint:Say(lin,1290,U_R590ID(SRA->RA_ADMISSA)+STR0007,oFont10) //" ANOS"
	oPrint:Line(lin+40,1280,lin+40,1780)

	oPrint:Say(lin,1820,STR0008,oFont13)	 //"IDADE:"
	oPrint:Say(lin,2020,U_R590ID(SRA->RA_NASC)+STR0007,oFont10) //" ANOS"
	oPrint:Line(lin+40,2010,lin+40,2300)

	lin := 640
                     
	cFuncao := Alltrim(SQ3->Q3_DESCSUM)
	If Empty(cFuncao)                   
		cFuncao := Alltrim(SRJ->RJ_DESC)
	Endif	
	oPrint:Say(lin,50,STR0009,oFont13) //"CARGO:"
	oPrint:Say(lin,250,cFuncao,oFont10)
	oPrint:Line(lin+40,240,lin+40,1710)

	oPrint:Say(lin,1750,STR0010,oFont13)	 //"(DESDE:"
	If !Empty(cFuncao)
		oPrint:Say(lin,2030,U_MDTDAY980(),oFont10)
	Endif	
	oPrint:Line(lin+40,2020,lin+40,2220)
	oPrint:Say(lin,2250,")",oFont13)

	lin := 760

	oPrint:Say(lin,50,STR0011,oFont13) //"REGIME/HORÁRIO DE TRABALHO:"
	oPrint:Line(lin+40,900,lin+40,2300)

	lin += 180                                               
	
	oPrint:Say(lin,50,STR0012,oFont13) //"DATA DO ACIDENTE:"
	oPrint:Line(lin+40,600,lin+40,680)
	oPrint:Line(lin,690,lin+40,680)
	oPrint:Line(lin+40,690,lin+40,770)
	oPrint:Line(lin,780,lin+40,770)
	oPrint:Line(lin+40,780,lin+40,860)
	
	oPrint:Say(lin,950,STR0013,oFont13) //"HORA:"
	oPrint:Line(lin+40,1100,lin+40,1350)
	
	oPrint:Say(lin,1450,STR0014,oFont13) //"APÓS"
	oPrint:Say(lin,1710,STR0015,oFont13) //"HORAS DE TRABALHO"
	oPrint:Line(lin+40,1580,lin+40,1700)	

	lin += 120

	oPrint:Say(lin,50,STR0016,oFont13) //"LOCAL DO ACIDENTE:"
	oPrint:Line(lin+40,600,lin+40,2300)

	lin += 120

	oPrint:Say(lin,50,STR0017,oFont13) //"DESCRIÇÃO DO ACIDENTE:"
	oPrint:Line(lin+40,720,lin+40,2300)    
	U_IMPLIN590(oPrint,4)
	
	lin += 120

	oPrint:Say(lin,50,STR0018,oFont13) //"PROVIDÊNCIAS TOMADAS:"
	oPrint:Line(lin+40,700,lin+40,2300)              
	U_IMPLIN590(oPrint,4)
	
	lin += 120

	oPrint:Say(lin,50,STR0019,oFont13) //"ANÁLISE PRELIMINAR DO HSMT:"
	oPrint:Line(lin+40,850,lin+40,2300)
	U_IMPLIN590(oPrint,4)

	lin += 120

	oPrint:Say(lin,50,STR0020,oFont13) //"SUGESTÃO DE TEXTO PARA A CAT:"
	oPrint:Line(lin+40,900,lin+40,2300)
	U_IMPLIN590(oPrint,2)                                                       

	oPrint:EndPage()
Endif
Return .t.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R590ID   ³ Autor ³Denis Hyroshi de Souza ³ Data ³06/05/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Calcula a idade do funcionario                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R590ID(dNasc,dFim)
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
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³implin590 ³ Autor ³Denis Hyroshi de Souza ³ Data ³06/05/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime linhas                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function  IMPLIN590(oPrint,nQtd)
LOCAL xx
lin+=40
For xx := 1 to nQtd            
	lin+=60
	oPrint:Line(lin,50,lin,2300)
Next xx	   
Return .t.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³MDTDAY980 |Autor  ³Denis Hyroshi de Souza ³ Data ³02/05/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Data inicio na funcao                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTDAY980()
Local aArea := GetArea()
Local dIni
dIni := SRA->RA_ADMISSA

Dbselectarea("SR7")
Dbsetorder(1)
dbSeek(SRA->RA_FILIAl+SRA->RA_MAT)
While !eof() .And. SR7->R7_FILIAL == SRA->RA_FILIAL .And. SR7->R7_MAT == SRA->RA_MAT
		If SRA->RA_CODFUNC == SR7->R7_FUNCAO
			If SR7->R7_DATA > dIni
				dIni := SR7->R7_DATA
			Endif			
		Endif		
	Dbselectarea("SR7")
	Dbskip()
End
RestArea(aArea)
Return Dtoc(dIni)