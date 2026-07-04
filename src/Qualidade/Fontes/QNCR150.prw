/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.CH"
#INCLUDE "QNCR150.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QNCR100   ºAutor  ³Leandro             º Data ³  29/06/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio de Follow-Up Estatitisco - Totais                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function QNCR150(aAnos,nAnoAtual,nFncTot,nFncBai,nFncPen,nPlnTot,nPlnBai,nPlnPen,nPlnTot,nPlnBai,nPlnPen)
Local oFont10, oFont10A, oFont15 
Local lin := 200
Local cAno:= StrZero(Year(dDataBase),4)

Private oPrint
                                         
oFont10A := TFont():New("Arial",10,10,,.T.,,,,.T.,.F.)
oFont10	 := TFont():New("Courier New",10,10,,.F.,,,,.T.,.F.)
oFont15	 := TFont():New("Courier New",15,15,,.T.,,,,.T.,.F.)

oPrint:= TMSPrinter():New("")
oPrint:SetPortrait()
oPrint:StartPage() 		

oPrint:Say(lin,0520,OemToAnsi(STR0001), oFont15)//"Relatorito de Follow-up Estatistico - Totais"
oPrint:Box(350,0310, 550, 2030)
lin += 180

oPrint:Line(0350,0900, 0550, 0900)
oPrint:Line(0350,1300, 0550, 1300)
oPrint:Line(0350,1700, 0550, 1700)

oPrint:Say(lin,0340,OemToAnsi(STR0002),oFont10A) // "Totalizadores/Tipos Lactos"       
oPrint:Say(lin,1000,OemToAnsi(STR0003),oFont10A) // "Total"       		
oPrint:Say(lin,1400,OemToAnsi(STR0004),oFont10A) // "Baixados"       		
oPrint:Say(lin,1800,OemToAnsi(STR0005),oFont10A) // "Pendentes"       		  

lin += 60
oPrint:Line(lin,0310, lin, 2030)
oPrint:Say(lin,0340,OemToAnsi(STR0006),oFont10A)  // "Fichas N.C." 
oPrint:Say(lin,0950,Transform(nFncTot,"@e 999999"),oFont10)        		
oPrint:Say(lin,1350,Transform(nFncBai,"@e 999999"),oFont10)        		
oPrint:Say(lin,1750,Transform(nFncPen,"@e 999999"),oFont10)        		

lin += 60
oPrint:Line(lin-5,0310, lin-5, 2030)
oPrint:Say(lin,0340,OemToAnsi(STR0007),oFont10A)  // "Plano Acao"      		
oPrint:Say(lin,0950,Transform(nPlnTot,"@e 999999"),oFont10)        		
oPrint:Say(lin,1350,Transform(nPlnBai,"@e 999999"),oFont10)        		
oPrint:Say(lin,1750,Transform(nPlnPen,"@e 999999"),oFont10)        	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tela de Totalizadores de Ficha N.C. do ano corrente          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lin += 150 
oPrint:Box(lin,0310, 950, 2030)
lin += 10
oPrint:Say(lin,0550,OemToAnsi(STR0008)+" "+cAno+")",oFont10A)// "Totais de Ficha de Ocorrencias/Nao-Conformidades por Mes (Ano"
lin += 60 
oPrint:Line(lin,0310, lin, 2030)  
oPrint:Say(lin,0995,OemToAnsi(STR0009),oFont10A)//MESES        		
lin += 10
oPrint:Line(lin+30,0310, lin+30, 2030)  
lin += 50 
oPrint:Line(760, 425, 880,  425)
oPrint:Line(760, 555, 880,  555)
oPrint:Line(760, 700, 880,  700)
oPrint:Line(760, 850, 880,  850)
oPrint:Line(760,1005, 880, 1005)
oPrint:Line(760,1160, 880, 1160)
oPrint:Line(760,1310, 880, 1310)
oPrint:Line(760,1475, 880, 1475)
oPrint:Line(760,1610, 880, 1610)
oPrint:Line(760,1770, 880, 1770)
oPrint:Line(760,1900, 880, 1900)

oPrint:Say(lin,0320,OemToAnsi(STR0013),oFont10A)//"Jan."        		
oPrint:Say(lin,0450,OemToAnsi(STR0014),oFont10A)//"Fev."
oPrint:Say(lin,0600,OemToAnsi(STR0015),oFont10A)//"Mar."
oPrint:Say(lin,0750,OemToAnsi(STR0016),oFont10A)//"Abr."
oPrint:Say(lin,0900,OemToAnsi(STR0017),oFont10A)//"Maio"
oPrint:Say(lin,1050,OemToAnsi(STR0018),oFont10A)//"Jun."
oPrint:Say(lin,1200,OemToAnsi(STR0019),oFont10A)//"Jul."
oPrint:Say(lin,1350,OemToAnsi(STR0020),oFont10A)//"Agos."
oPrint:Say(lin,1500,OemToAnsi(STR0021),oFont10A)//"Set."
oPrint:Say(lin,1650,OemToAnsi(STR0022),oFont10A)//"Out."
oPrint:Say(lin,1800,OemToAnsi(STR0023),oFont10A)//"Nov."
oPrint:Say(lin,1930,OemToAnsi(STR0024),oFont10A)//"Dez."
lin += 10
oPrint:Line(lin+30,0310, lin+30, 2030)  
lin += 40
oPrint:Say(lin,0325,Transform(aAnos[nAnoAtual,2,1,1]  ,"@e 9999"),oFont10)
oPrint:Say(lin,0425,Transform(aAnos[nAnoAtual,2,2,1]  ,"@e 9999"),oFont10)
oPrint:Say(lin,0575,Transform(aAnos[nAnoAtual,2,3,1]  ,"@e 9999"),oFont10)
oPrint:Say(lin,0725,Transform(aAnos[nAnoAtual,2,4,1]  ,"@e 9999"),oFont10)                         
oPrint:Say(lin,0875,Transform(aAnos[nAnoAtual,2,5,1]  ,"@e 9999"),oFont10)
oPrint:Say(lin,1025,Transform(aAnos[nAnoAtual,2,6,1]  ,"@e 9999"),oFont10)
oPrint:Say(lin,1175,Transform(aAnos[nAnoAtual,2,7,1]  ,"@e 9999"),oFont10)
oPrint:Say(lin,1325,Transform(aAnos[nAnoAtual,2,8,1]  ,"@e 9999"),oFont10)
oPrint:Say(lin,1475,Transform(aAnos[nAnoAtual,2,9,1]  ,"@e 9999"),oFont10)
oPrint:Say(lin,1625,Transform(aAnos[nAnoAtual,2,10,1] ,"@e 9999"),oFont10)
oPrint:Say(lin,1775,Transform(aAnos[nAnoAtual,2,11,1] ,"@e 9999"),oFont10)
oPrint:Say(lin,1900,Transform(aAnos[nAnoAtual,2,12,1] ,"@e 9999"),oFont10)
lin += 10
oPrint:Line(lin+40,0310, lin+40, 2030)  
lin += 50
oPrint:Say(lin,0675, OemToAnsi(STR0010+" = "+Transform(nTotFAno,"@e 9999")+Space(15)+STR0011+" "+Transform(nTotFPerc,"@e 999")+"%"),oFont10A) 	// "Total Ano" ### "Percentual Total"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tela de Totalizadores de Plano de Acao                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lin += 160
oPrint:Box(lin,0310, 1340, 2030)
lin += 10
oPrint:Say(lin,0800, OemToAnsi(STR0012)+" "+cAno+")" ,oFont10A)	// "Totais de Plano de Acao por Mes (Ano"
lin += 60
oPrint:Line(lin,0310, lin, 2030)  
oPrint:Say(lin,1000,OemToAnsi(STR0009),oFont10A)//MESES        		
lin += 10
oPrint:Line(lin+30,0310, lin+30, 2030) 
lin += 50
                   
oPrint:Line(1161, 425, 1274,  425)
oPrint:Line(1161, 555, 1274,  555)
oPrint:Line(1161, 700, 1274,  700)
oPrint:Line(1161, 850, 1274,  850)
oPrint:Line(1161,1005, 1274, 1005)
oPrint:Line(1161,1160, 1274, 1160)
oPrint:Line(1161,1310, 1274, 1310)
oPrint:Line(1161,1475, 1274, 1475)
oPrint:Line(1161,1610, 1274, 1610)
oPrint:Line(1161,1770, 1274, 1770)
oPrint:Line(1161,1900, 1274, 1900)

oPrint:Say(lin,0320,OemToAnsi(STR0013),oFont10A) //"Jan."        		
oPrint:Say(lin,0450,OemToAnsi(STR0014),oFont10A) //"Fev."       		
oPrint:Say(lin,0600,OemToAnsi(STR0015),oFont10A) //"Mar."       		
oPrint:Say(lin,0750,OemToAnsi(STR0016),oFont10A) //"Abr."       		
oPrint:Say(lin,0900,OemToAnsi(STR0017),oFont10A) //"Maio"       		
oPrint:Say(lin,1050,OemToAnsi(STR0018),oFont10A) //"Jun."       		
oPrint:Say(lin,1200,OemToAnsi(STR0019),oFont10A) //"Jul."       		
oPrint:Say(lin,1350,OemToAnsi(STR0020),oFont10A) //"Agos."       		
oPrint:Say(lin,1500,OemToAnsi(STR0021),oFont10A) //"Set."       		
oPrint:Say(lin,1650,OemToAnsi(STR0022),oFont10A) //"Out."       		
oPrint:Say(lin,1800,OemToAnsi(STR0023),oFont10A) //"Nov."
oPrint:Say(lin,1930,OemToAnsi(STR0024),oFont10A) //"Dez."       		
lin += 10
oPrint:Line(lin+30,0310, lin+30, 2030) 
lin += 40
//oPrint:Line(lin+30,0310, lin+30, 2030) 
//lin += 10
oPrint:Say(lin,0325,Transform(aAnos[nAnoAtual,2,1,2]  ,"@e 9999"),oFont10)
oPrint:Say(lin,0425,Transform(aAnos[nAnoAtual,2,2,2]  ,"@e 9999"),oFont10)
oPrint:Say(lin,0575,Transform(aAnos[nAnoAtual,2,3,2]  ,"@e 9999"),oFont10)
oPrint:Say(lin,0725,Transform(aAnos[nAnoAtual,2,4,2]  ,"@e 9999"),oFont10)
oPrint:Say(lin,0875,Transform(aAnos[nAnoAtual,2,5,2]  ,"@e 9999"),oFont10)
oPrint:Say(lin,1025,Transform(aAnos[nAnoAtual,2,6,2]  ,"@e 9999"),oFont10)
oPrint:Say(lin,1175,Transform(aAnos[nAnoAtual,2,7,2]  ,"@e 9999"),oFont10)
oPrint:Say(lin,1325,Transform(aAnos[nAnoAtual,2,8,2]  ,"@e 9999"),oFont10)
oPrint:Say(lin,1475,Transform(aAnos[nAnoAtual,2,9,2]  ,"@e 9999"),oFont10)
oPrint:Say(lin,1625,Transform(aAnos[nAnoAtual,2,10,2] ,"@e 9999"),oFont10)
oPrint:Say(lin,1775,Transform(aAnos[nAnoAtual,2,11,2] ,"@e 9999"),oFont10)
oPrint:Say(lin,1900,Transform(aAnos[nAnoAtual,2,12,2] ,"@e 9999"),oFont10)
lin += 10
oPrint:Line(lin+30,0310, lin+30, 2030) 

lin += 50
oPrint:Say(lin,0675, OemToAnsi(STR0010+" = "+Transform(nTotPAno,"@e 9999")+Space(15)+STR0011+" "+Transform(nTotPPerc,"@e 999")+"%") ,oFont10A)	// "Total Ano" ### "Percentual Total"

oPrint:EndPage() 		
oPrint:Preview()  		

Return(NIL)

