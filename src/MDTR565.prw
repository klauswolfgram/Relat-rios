/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr565.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 2 //Versao do fonte
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR565  ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 23.04.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio do Registro de Adventencia 		                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/   
User Function MDTR565()                                                
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO) 

lSigaMdtPS    := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

Private cPerg := If(!lSigaMdtPS,"MDT565    ","MDT565PS  ")

/*-----------------------------------------
//PERGUNTAS PADRÃO							|
| MDT565    ¦01      ¦Tipo Impressao ?		|
| MDT565    ¦02      ¦Funcionario ?		|
| MDT565    ¦03      ¦De Data ?				|
| MDT565    ¦04      ¦Ate Data ?			|
|												|	
//PERGUNTAS PRESTADOR DE SERVIÇO			|
| 01      |Cliente ?							|
| 02      |Loja								|
| 03      ¦Funcionario ?						|
| 04      ¦De Data ?							|
| 05      ¦Ate Data ?						|
| 06      ¦Tipo Impressao ?					|
-------------------------------------------*/

If pergunte(cPerg,.t.)   
	U_MDT565IMP()
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
±±³Fun‡„o    ³ MDT565IMP³ Autor ³Denis Hyroshi de Souza ³ Data ³02/04/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT565IMP()
Local oPrint
Private cAlias := "SI3"   
Private cDescr := "SI3->I3_DESC"
Private lin := 0    
Private oFont11,oFont12,oFont13,oFont16,oFont20
oFont11	:= TFont():New("COURIER NEW",11,11,,.T.,,,,.F.,.F.)
oFont12	:= TFont():New("COURIER NEW",12,12,,.T.,,,,.F.,.F.)
oFont13	:= TFont():New("COURIER NEW",13,13,,.T.,,,,.F.,.F.)
oFont16	:= TFont():New("COURIER NEW",16,16,,.F.,,,,.F.,.F.)
oFont20	:= TFont():New("COURIER NEW",20,20,,.T.,,,,.F.,.F.)

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAlias := "CTT"
	cDescr := "CTT->CTT_DESC01"
Endif   

oPrint	:= TMSPrinter():New(OemToAnsi(STR0001)) //"Advertencia Verbal"
oPrint:Setup()

U_ADVMDT565(oPrint)  

If lSigaMdtps
	If Mv_par06 = 2
		oPrint:Print()
	Else
		oPrint:Preview()
	Endif
Else
	If Mv_par01 = 2
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
±±³Fun‡„o    ³ ADVMDT565³ Autor ³Denis Hyroshi de Souza ³ Data ³02/04/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Modelo Individual                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ADVMDT565(oPrint)

Local cSMCOD := FWGrpCompany()
Local cSMFIL := FWCodFil()

lin := 250

If lSigaMdtps

	/* Perguntas
	  	       01      |Cliente ?
			   02      |Loja	
	MDT565    ¦03      ¦Funcionario ?
	MDT565    ¦04      ¦De Data ?
	MDT565    ¦05      ¦Ate Data ?
	MDT565    ¦06      ¦Tipo Impressao ?	
	*/

	Dbselectarea("SRA")
	Dbsetorder(01)
	If Dbseek(xFilial("SRA")+Mv_par03)
		Dbselectarea(cAlias)
		Dbsetorder(1)
		Dbseek(xFilial(cAlias)+SRA->RA_CC)
	
		Dbselectarea("TO8")
		Dbsetorder(5)  //TO8_FILIAL+TO8_CLIENT+TO8_LOJA+TO8_MAT+DTOS(TO8_DTOCOR)
		Dbseek(xFilial("TO8")+mv_par01+mv_par02+mv_par03)		

		While !eof() .and. xFilial("TO8") == TO8->TO8_FILIAL .and. mv_par01+mv_par02+mv_par03 = TO8->(TO8_CLIENT+TO8_LOJA+TO8_MAT)
			
			If (TO8->TO8_DTOCOR < Mv_par04 .or. TO8->TO8_DTOCOR  > Mv_par05)
				Dbselectarea("TO8")
				Dbskip()
				Loop
			Endif
			
			Dbselectarea("TO7")
			Dbsetorder(2)  //TO7_FILIAL+TO7_CLIENT+TO7_LOJA+TO7_CODOCO
			Dbseek(xFilial("TO7")+TO8->(TO8_CLIENT+TO8_LOJA)+TO8->TO8_CODOCO)		
	
			oPrint:StartPage()
			If File("LGRL"+cSMCOD+cSMFIL+".BMP")
				oPrint:SayBitMap(100,1850,"LGRL"+cSMCOD+cSMFIL+".BMP",300,120)
			ElseIf File("LGRL"+cSMCOD+".BMP")
				oPrint:SayBitMap(100,1850,"LGRL"+cSMCOD+".BMP",300,120)
			Endif
			                                                                
			oPrint:line(250,200,250,2150)
			lin := 400
			If TO8->TO8_GRAVID == '1'
				oPrint:Say(lin,500,STR0002,oFont20) //"REGISTRO DE ADVERTÊNCIA VERBAL"
			ElseIf TO8->TO8_GRAVID == '2'
				oPrint:Say(lin,500,STR0010,oFont20)  //"REGISTRO DE ADVERTÊNCIA ESCRITA"
			ElseIf TO8->TO8_GRAVID == '3'
				oPrint:Say(lin,650,STR0011,oFont20)  //"REGISTRO DE SUSPENSÃO"
			ElseIf TO8->TO8_GRAVID == '4'
				oPrint:Say(lin,650,STR0012,oFont20)  //"REGISTRO DE DEMISSÃO"
			Endif
			lin := 600
			oPrint:Say(lin,250,STR0003,oFont16) //"Nome:"
			oPrint:Say(lin,450,Alltrim(SRA->RA_NOME),oFont12)
			oPrint:line(lin+50,440,lin+50,1520)
			oPrint:Say(lin,1600,STR0004,oFont16)                 //"RG:"
			oPrint:Say(lin,1725,Alltrim(SRA->RA_RG),oFont12)
			oPrint:line(lin+50,1715,lin+50,2150)
			
			lin := 800
			oPrint:Say(lin,250,STR0005,oFont16) //"Área:"
			oPrint:Say(lin,450,Alltrim(&cDescr),oFont12)
			oPrint:line(lin+50,440,lin+50,1520)
			oPrint:Say(lin,1600,STR0006,oFont16) //"Data:"
			oPrint:Say(lin,1775,DTOC(TO8->TO8_DTOCOR),oFont12)
			oPrint:line(lin+50,1765,lin+50,2150)
		                
			lin := 1100
	
			oPrint:Say(lin,250,STR0007,oFont16) //"Motivo:"
			oPrint:Say(lin,490,Memoline(TO7->TO7_DESOCO,60,1),oFont12)
			oPrint:line(lin+50,480,lin+50,2150)
			lin += 80
			oPrint:Say(lin,490,Memoline(TO7->TO7_DESOCO,60,2),oFont12)
			oPrint:line(lin+50,480,lin+50,2150)
			lin += 600
	                             		
			oPrint:line(lin,250,lin,1125)
			oPrint:line(lin,1275,lin,2150)	
			oPrint:Say(lin+20,500,STR0008,oFont16)	 //"Supervisor"
			oPrint:Say(lin+20,1300,STR0009,oFont16)	 //"Hig. e Seg. do Trabalho"
			
			lin += 300                                
	
			oPrint:line(lin,750,lin,1625)
			oPrint:Say(lin+20,980,STR0013,oFont16)  //"Funcionário"
		
			oPrint:EndPage()
			Dbselectarea("TO8")
			Dbskip()		
		End	
	Endif

Else

	Dbselectarea("SRA")
	Dbsetorder(01)
	If Dbseek(xFilial("SRA")+Mv_par02)
		Dbselectarea(cAlias)
		Dbsetorder(1)
		Dbseek(xFilial(cAlias)+SRA->RA_CC)
	
		Dbselectarea("TO8")
		Dbsetorder(1)
		Dbseek(xFilial("TO8"))
		While !eof() .and.	xFilial("TO8") == TO8->TO8_FILIAL 
			If (TO8->TO8_DTOCOR < Mv_par03 .or. TO8->TO8_DTOCOR  > Mv_par04)
				Dbselectarea("TO8")
				Dbskip()
				Loop
			Endif
			If Mv_par02 != TO8->TO8_MAT
				Dbselectarea("TO8")
				Dbskip()
				Loop
			Endif   
			Dbselectarea("TO7")
			Dbsetorder(1)
			Dbseek(xFilial("TO7")+TO8->TO8_CODOCO)		
	
			oPrint:StartPage()
		
			If File("LGRL"+cSMCOD+cSMFIL+".BMP")
				oPrint:SayBitMap(100,1850,"LGRL"+cSMCOD+cSMFIL+".BMP",300,120)
			ElseIf File("LGRL"+cSMCOD+".BMP")
				oPrint:SayBitMap(100,1850,"LGRL"+cSMCOD+".BMP",300,120)
			Endif
			                                                                
			oPrint:line(250,200,250,2150)
			lin := 400
			If TO8->TO8_GRAVID == '1'
				oPrint:Say(lin,500,STR0002,oFont20) //"REGISTRO DE ADVERTÊNCIA VERBAL"
			ElseIf TO8->TO8_GRAVID == '2'
				oPrint:Say(lin,500,STR0010,oFont20)  //"REGISTRO DE ADVERTÊNCIA ESCRITA"
			ElseIf TO8->TO8_GRAVID == '3'
				oPrint:Say(lin,650,STR0011,oFont20)  //"REGISTRO DE SUSPENSÃO"
			ElseIf TO8->TO8_GRAVID == '4'
				oPrint:Say(lin,650,STR0012,oFont20)  //"REGISTRO DE DEMISSÃO"
			Endif
			lin := 600
			oPrint:Say(lin,250,STR0003,oFont16) //"Nome:"
			oPrint:Say(lin,450,Alltrim(SRA->RA_NOME),oFont12)
			oPrint:line(lin+50,440,lin+50,1520)
			oPrint:Say(lin,1600,STR0004,oFont16)                 //"RG:"
			oPrint:Say(lin,1725,Alltrim(SRA->RA_RG),oFont12)
			oPrint:line(lin+50,1715,lin+50,2150)
			
			lin := 800
			oPrint:Say(lin,250,STR0005,oFont16) //"Área:"
			oPrint:Say(lin,450,Alltrim(&cDescr),oFont12)
			oPrint:line(lin+50,440,lin+50,1520)
			oPrint:Say(lin,1600,STR0006,oFont16) //"Data:"
			oPrint:Say(lin,1775,DTOC(TO8->TO8_DTOCOR),oFont12)
			oPrint:line(lin+50,1765,lin+50,2150)
		                
			lin := 1100
	
			oPrint:Say(lin,250,STR0007,oFont16) //"Motivo:"
			oPrint:Say(lin,490,Memoline(TO7->TO7_DESOCO,60,1),oFont12)
			oPrint:line(lin+50,480,lin+50,2150)
			lin += 80
			oPrint:Say(lin,490,Memoline(TO7->TO7_DESOCO,60,2),oFont12)
			oPrint:line(lin+50,480,lin+50,2150)
			lin += 600
	                             		
			oPrint:line(lin,250,lin,1125)
			oPrint:line(lin,1275,lin,2150)	
			oPrint:Say(lin+20,500,STR0008,oFont16)	 //"Supervisor"
			oPrint:Say(lin+20,1300,STR0009,oFont16)	 //"Hig. e Seg. do Trabalho"
			
			lin += 300                                
	
			oPrint:line(lin,750,lin,1625)
			oPrint:Say(lin+20,980,STR0013,oFont16)  //"Funcionário"
		
			oPrint:EndPage()
			Dbselectarea("TO8")
			Dbskip()		
		End	
	Endif

Endif

Return .t.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ MDT565MAT³ Autor ³Andre Perez Alvarez    ³ Data ³08/02/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Valida a pergunta Matricula.                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT565MAT()

Return ExCpoMDT('SRA',Mv_par03) .AND. MDTMATVAL(mv_par03,mv_par01+mv_par02)