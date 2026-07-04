/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PMSR350.ch"
#INCLUDE "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PmsImpGantt³ Autor ³ Reynaldo T. Miyashita   ³ Data ³ 21/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gera a impressao grafica do Gantt                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³      [x][1] : Array contendo os dados das tarefas.         	  ³±±
±±³          ³ExpA2:Array contendo os dados do Gantt                      	  ³±±
±±³          ³      [x][1] : Array contendo os dados das tarefas.         	  ³±±
±±³          ³               Ex: {"Tarefa 1","29/11/01","20h"}            	  ³±±
±±³          ³      [x][2] : Array contendo os intervalos das tarefas    	  ³±±
±±³          ³               Ex: {{dIni,HoraIni,dFim,HoraFim,cTexto..}..} 	  ³±±
±±³          ³                    dIni : Data inicial                     	  ³±±
±±³          ³                    HoraIni : Hora Inicial (XX:XX)          	  ³±±
±±³          ³                    dFim : Data Final                       	  ³±±
±±³          ³                    HoraFim : Hora Final   (XX:XX)          	  ³±±
±±³          ³                    cTexto  : Texto a ser exibido na barra  	  ³±±
±±³          ³                    cColor  : Cor do Gantt                  	  ³±±
±±³          ³                    bClick  : Code Block no Click           	  ³±±
±±³          ³                    nAlign  : Metodo de Alinhamento         	  ³±±
±±³          ³                              1 - Normal                    	  ³±±
±±³          ³                              2 - Acima a Direita           	  ³±±
±±³          ³ExpA3 : Array contendo as configuracoes do Gantt            	  ³±±
±±³          ³        [1] Escala - 1-Diario,2-Semanal,3-Mensal            	  ³±±
±±³          ³        [2],[3]...[n] - Indica os campos da exibicao .T.,.F.	  ³±±
±±³          ³ExpD4 : Data Inicial da Escala ( opcional )                 	  ³±±
±±³          ³ExpD5 : Data Final da Escala ( opcional )                   	  ³±±
±±³          ³ExpA6 : Array contendo a descricao e tamanho dos               ³±±
±±³          ³               dados das tarefas.                              ³±±
±±³          ³               Ex : {{"Descricao",40},{"Duracao",30},..}    	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Observacao³Uma vez criado o objeto ele nao podera ser alterado.        	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PmsImpGantt( cTitulo ,aGantt ,aConfig ,dIni ,dFim ,aCampos ,aDep ,lProject)

Local lLoop := .T.
Local lDescricao := .F.

Local oFntArial08   := TFont():New( "Arial"       ,08  ,08 ,,.T. ,,,,.T. ,.F. )
Local oFntArial10   := TFont():New( "Arial"       ,10  ,10 ,,.T. ,,,,.T. ,.F. )
Local oFont10n      := TFont():New( "Courier New" ,10 , 10 ,,.T. ,,,,.T. ,.F. )
/////////////////////////////////
// nFonte para usar no PcoPrtSize
// oFntArial08	-> Nao Possui fonte exata
// oFntArial10	-> 5
// oFont10n		-> 4


// tamanho do papel a ser impresso
Local aPos := { 10 ,10 ,2400 ,3200 }


Local nColIni	:= 30

Local nCol1	:= 0
Local nCol2 := 0

Local nCol := 0
Local nLin := 0

Local nX ,nY
Local aMeses	:= {}

Local dDateAtu	:= MsDate()
Local nPage := 0
Local dComeco := ctod( "  /  /  " )
Local dTermino := ctod( "  /  /  " )
Local dAuxIni := ctod( "  /  /  " )
Local aRetorno := {}

Local nXIni := 0
Local nXQuebra := 0
Local nColor := 0
Local cBMP := ""
Local cTexto := ""
Local i := 0

DEFAULT aDep 		:= {}
DEFAULT lProject 	:= .T.

For i:=1 to 12 
	Aadd(aMeses, SubSTR(MesExtenso(i),1,3) )
Next

//Escala diaria
//"|       16/08/01       | Terca 17, Abril 2001  |"
//"|     6    12    18    |                       |"
//"||||||||||||||||||||||||||||||||||||||||||||||||"
//Escala semanal
//"|  30 Setembro 2001   |   07 Outubro 2001   |"
//"| D  S  T  Q  Q  S  S | D  S  T  Q  Q  S  S |"
//"|||||||||||||||||||||||||||||||||||||||||||||"
//Escala mensal 100%
//"|        Janeiro/2001         |      Fevereiro/2001        |"
//"|    5        15        25    |    5        15        25   |"
//"||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
//Escala mensal 30%
//"|Jan/2001  |Fev/2001  |"
//"|   15     |   15     |"
//"|||||||||||||||||||||||"
//Escala bimestral
//"|01/2001   |03/2001   |"
//"|    1     |     1    |"
//"|||||||||||||||||||||||"

If !Empty(aGantt)
	//
	// Obtem a data que inicia e termina o projeto.
	//
	For nX := 1 to Len(aGantt)
		For nY := 1 to Len(aGantt[nX][2])
			If !Empty(aGantt[nX][2][nY][1]) .And. aGantt[nX][2][nY][1] < dComeco
				dComeco := aGantt[nX][2][nY][1]
			EndIf
			If !Empty(aGantt[nX][2][nY][3]).And. aGantt[nX][2][nY][3] > dTermino
				dTermino := aGantt[nX][2][nY][3]
			EndIf
		Next nY
	Next nX
	
	oQPrint := TMSPrinter():New( cTitulo )
	oQPrint:SetLandscape()
	//
	// calcula a data de inicio e fim.
	//
	Escala( @dIni ,@dFim ,@aConfig ,@aGantt ,aPos ,nColIni )
	
	If !Empty(dIni) .And. !Empty(dFim)
		nPage := 0
		lDescricao := .T.
		lLoop := .T.
		Do Case
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Cria o Gantt na escala 'horaria de 1 em 1 hora'         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Case aConfig[1] == -1
				While lLoop
					lLoop := .F.
					nXQuebra := 0
					nXIni := 0
					While ( nXIni < len(aGantt) )
						oQPrint:SetLandScape() // Paisagem
						oQPrint:StartPage() // Inicia uma nova pagina
						nPage++
						nLin := ImpCabec( dDateAtu ,nPage ,aPos ,oFntArial10 ,(nXIni == 0 ) ) // cabecalho
						Escala( @dIni ,@dFim ,@aConfig ,@aGantt ,aPos ,iIf(lDescricao ,nColIni ,10 ) ) // calcula a data de inicio e fim.
						
						If lDescricao
							nColIni := 30
							// monta a coluna de descricao( primeira coluna)
							ColDescr( oQPrint ,aGantt ,aCampos, aConfig ,nLin ,@nColIni ,aPos ,oFntArial08 ,oFntArial10,lProject)
							nCol := nColIni
						Else
							nCol := 10
						EndIf
						
						// monta os quadros dos dias
						aRetorno := QdroHora1( oQPrint ,aGantt ,aPos ,nLin ,nCol ,dDateAtu ,dTermino ,dIni ,dFim ,oFntArial08 ,oFont10n )
						lLoop := aRetorno[1]
						dAuxIni := aRetorno[2]
						nGrafTop := aRetorno[3][1]
						nGrafDown := aRetorno[3][2]
						
						nLin += 190
						// imprime todos as tarefas
						nXQuebra := 0
						For nX := 1 to Len(aGantt)
							If nX > nXIni .and. nXQuebra == 0
								If nLin >= (aPos[3]-100)
									nXQuebra := nX-1
								EndIf
							EndIf
							For nY := 1 to Len(aGantt[nx][2])
								If (nX > nXIni) .AND. (nLin < (aPos[3]-100)) .AND. lDescricao
									// Imprime as descricoes do projeto, edt ou tarefa
									ImprDescr( oQPrint ,@nLin ,@nCol ,aCampos ,aConfig ,aGantt[nX][1] ,oFntArial08)
								EndIf
								
								// TABELA DE CONVERSAO
								// 1 minuto = 1,47 tamanho
								// 15 minutos = 22 tamanho
								// 1 hora = 88 tamanho
								If aGantt[nx][2][ny][1] >= dIni
									nCol1 := nCol+(((aGantt[nx][2][ny][1]-dIni)*24)*88) // calcula o dia em horas
									nCol1 += Val(Substr(aGantt[nx][2][ny][2],1,2))*88   // calcula as horas
									nCol2 += Val(Substr(aGantt[nx][2][ny][2],4,2))*1.47 // calcula os minutos
								Else
									
									If lDescricao
										nCol1 := nCol
									Else
										nCol1 := -10
									Endif
								EndIf
								If aGantt[nx][2][ny][3]<= dFim
									nCol2 := nCol+(((aGantt[nx][2][ny][3]-dIni)*24)*88) // calcula o dia em horas
									nCol2 += Val(Substr(aGantt[nx][2][ny][4],1,2))*88   // calcula as horas
									nCol2 += Val(Substr(aGantt[nx][2][ny][4],4,2))*1.47 // calcula os minutos
								Else
									nCol2 := nCol+(((dFim-dIni)*24)*88)+aPos[4]  // calcula o dia em horas
								EndIf
								
								// limita a distancia ao tamanho da folha
								If nCol2 > aPos[4]
									nCol2 := aPos[4]
								EndIf
								
								If nCol2 > nCol1
									nColor := iIf(aGantt[nx][2][ny][6]!=Nil,aGantt[nx][2][ny][6],aGantt[nx][3])
									cBmp := OnePixBmp(ConvRGB(nColor),,"PMSBMP")
									oQPrint:SayBitmap( nLin+5 ,nCol1 ,cBmp,iIf(nCol2-nCol1>3,nCol2-nCol1,3),(nLin+20-nLin))
									If !Empty(aGantt[nx][2][ny][7])
										// barra de tarefa
										nColor := iIf(aGantt[nx][2][ny][6]!=Nil,aGantt[nx][2][ny][6],aGantt[nx][3])
										cBmp := OnePixBmp(ConvRGB(nColor),,"PMSBMP")
										oQPrint:SayBitmap( nLin+5 ,nCol1 ,cBmp,iIf(nCol2-nCol1>3,nCol2-nCol1,3),(nLin+20-nLin))
										
									EndIf
									
									// Dados sobre a tarefa POC
									If !Empty(aGantt[nx][2][ny][5]) .And. dFim >= aGantt[nx][2][ny][3] .And. dIni <= aGantt[nx][2][ny][3]
										Do Case
											Case aGantt[nX][2][nY][8] == 1
												// texto a ser impresso
												cTexto := TruncTexto( STRTRAN(AllTrim(aGantt[nX][2][nY][5]),"'",'"'), aRetorno[4]-(nCol2+50) )
												oQPrint:Say( nLin-10, nCol2+50, OemToAnsi( cTexto ), oFntArial08 )
											Case aGantt[nX][2][nY][8] == 2
												// texto a ser impresso
												cTexto := TruncTexto( STRTRAN(AllTrim(aGantt[nX][2][nY][5]),"'",'"'), aRetorno[4]-(nCol2-100) )
												oQPrint:Say( nLin-40, nCol2-100, OemToAnsi( cTexto ), oFntArial08 )
										EndCase
									EndIf
								EndIf
								
								// desenha as tarefas predecessoras
								preDecessora( aConfig[1] ,nX ,nXIni ,nXQuebra ,aGantt ,aDep ,{ aGantt[nX][1][1] ,nLin+05 ,nCol1 ,nCol2 };
								 ,nLin     ,nCol ,dIni ,dFim ,{nGrafTop ,iIf(lDescricao ,nCol ,aPos[2]) ,nGrafDown ,aPos[4]} )
								
							Next nY
							
							// avanço de linha
							If (nX > nXIni)
								If (nLin < (aPos[3]-100))
									nLin += 40
								Else
									nLin := aPos[3]
								Endif
							EndIf
							
						Next nX
						
						If nXQuebra <> 0
							nXIni := nXQuebra
							nXQuebra := 0
						Else
							If nLin < (aPos[3]-100)
								nXIni := len(aGantt)
							EndIf
						Endif
						
						// Linha de separacao
						oQPrint:Line( aPos[3]   ,aPos[2] ,aPos[3]   ,aPos[4] )
						oQPrint:Line( aPos[3]-1 ,aPos[2] ,aPos[3]-1 ,aPos[4] )
						oQPrint:Line( aPos[3]-2 ,aPos[2] ,aPos[3]-2 ,aPos[4] )
						oQPrint:Line( aPos[3]-3 ,aPos[2] ,aPos[3]-3 ,aPos[4] )
						oQPrint:Line( aPos[3]-4 ,aPos[2] ,aPos[3]-4 ,aPos[4] )
						oQPrint:Line( aPos[3]-5 ,aPos[2] ,aPos[3]-5 ,aPos[4] )
						
						oQPrint:EndPage() // fim de pagina
						
					End
					
					If lLoop
						dIni := dAuxIni
						lDescricao := .F.
					EndIf
					
				End
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Cria o Gantt na escala 'horaria de 2 em 2 hora'         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Case aConfig[1] == 0
				
				While lLoop
					lLoop := .F.
					nXQuebra := 0
					nXIni := 0
					While ( nXIni < len(aGantt) )
						oQPrint:SetLandScape() // Paisagem
						oQPrint:StartPage() // Inicia uma nova pagina
						nPage++
						nLin := ImpCabec( dDateAtu ,nPage ,aPos ,oFntArial10 ,(nXIni == 0 ) ) // cabecalho
						Escala( @dIni ,@dFim ,@aConfig ,@aGantt ,aPos ,iIf(lDescricao ,nColIni ,10 ) ) // calcula a data de inicio e fim.
						
						If lDescricao
							nColIni := 30
							// monta a coluna de descricao( primeira coluna)
							ColDescr( oQPrint ,aGantt ,aCampos, aConfig ,nLin ,@nColIni ,aPos ,oFntArial08 ,oFntArial10,lProject)
							nCol := nColIni
						Else
							nCol := 10
						EndIf
						
						// monta os quadros dos dias
						aRetorno := QdroHora2( oQPrint ,aGantt ,aPos ,nLin ,nCol ,dDateAtu ,dTermino ,dIni ,dFim ,oFntArial08 ,oFont10n )
						lLoop := aRetorno[1]
						dAuxIni := aRetorno[2]
						nGrafTop := aRetorno[3][1]
						nGrafDown := aRetorno[3][2]
						
						nLin += 190
						// imprime todos as tarefas
						nXQuebra := 0
						For nX := 1 to Len(aGantt)
							If nX > nXIni .and. nXQuebra == 0
								If nLin >= (aPos[3]-100)
									nXQuebra := nX-1
								EndIf
							EndIf
							nSize := 7
							For nY := 1 to Len(aGantt[nx][2])
								If lDescricao
									// Imprime as descricoes do projeto, edt ou tarefa
									ImprDescr( oQPrint ,@nLin ,@nCol ,aCampos ,aConfig ,aGantt[nX][1] ,oFntArial08)
									
								EndIf
								// TABELA DE CONVERSAO
								// 1 minuto = 0.73 tamanho
								// 30 minutos = 22 tamanho
								// 1 hora = 44 tamanho
								If aGantt[nx][2][ny][1] >= dIni
									nCol1 := nCol+(((aGantt[nx][2][ny][1]-dIni)*24)*44) // calcula o dia em horas
									nCol1 += Val(Substr(aGantt[nx][2][ny][2],1,2))*44   // calcula as horas
									nCol2 += Val(Substr(aGantt[nx][2][ny][2],4,2))*0.73 // calcula os minutos
								Else
									If lDescricao
										nCol1 := nCol
									Else
										nCol1 := -10
									Endif
								EndIf
								If aGantt[nx][2][ny][3]<= dFim
									nCol2 := nCol+(((aGantt[nx][2][ny][3]-dIni)*24)*44) // calcula o dia em horas
									nCol2 += Val(Substr(aGantt[nx][2][ny][4],1,2))*44   // calcula as horas
									nCol2 += Val(Substr(aGantt[nx][2][ny][4],4,2))*0.73 // calcula os minutos
								Else
									nCol2 := nCol+(((dFim-dIni)*24)*44)+aPos[4]  // calcula o dia em horas
								EndIf
								
								// limita a distancia ao tamanho da folha
								If nCol2 > aPos[4]
									nCol2 := aPos[4]
								EndIf
								
								If nCol2 > nCol1
									
									nColor := If(aGantt[nx][2][ny][6]!=Nil,aGantt[nx][2][ny][6],aGantt[nx][3])
									cBmp := OnePixBmp(ConvRGB(nColor),,"PMSBMP")
									oQPrint:SayBitmap( nLin+5 ,nCol1 ,cBmp,iIf(nCol2-nCol1>3,nCol2-nCol1,3),(nLin+20-nLin))
									If !Empty(aGantt[nx][2][ny][7])
										// barra de tarefa
										nColor := If(aGantt[nx][2][ny][6]!=Nil,aGantt[nx][2][ny][6],aGantt[nx][3])
										cBmp := OnePixBmp(ConvRGB(nColor),,"PMSBMP")
										oQPrint:SayBitmap( nLin+5 ,nCol1 ,cBmp,iIf(nCol2-nCol1>3,nCol2-nCol1,3),(nLin+20-nLin))
										
									EndIf
									// Dados sobre a tarefa POC
									If !Empty(aGantt[nx][2][ny][5]) .And. dFim >= aGantt[nx][2][ny][3] .And. dIni <= aGantt[nx][2][ny][3]
										Do Case
											Case aGantt[nx][2][ny][8] == 1
												//cTextSay:= "{||'"+STRTRAN(AllTrim(aGantt[nx][2][ny][5]),"'",'"')+"'}"
												//oSay	:= TSay():New( nLin-1,nCol2+10, MontaBlock(cTextSay) , oPanel , ,oArial,,,,.T.,aGantt[nx][2][ny][9],,,,,,,,)
												
												// texto a ser impresso
												cTexto := TruncTexto( STRTRAN(AllTrim(aGantt[nX][2][nY][5]),"'",'"'), aRetorno[4]-(nCol2+50) )
												oQPrint:Say( nLin-10 ,nCol2+50 ,OemToAnsi( cTexto ) ,oFntArial08 )
											Case aGantt[nx][2][ny][8] == 2
												//cTextSay:= "{||'"+STRTRAN(AllTrim(aGantt[nx][2][ny][5]),"'",'"')+"'}"
												//oSay	:= TSay():New( nLin-5,nCol2-25, MontaBlock(cTextSay) , oPanel , ,oArial,,,,.T.,aGantt[nx][2][ny][9],,,,,,,,)
												
												// texto a ser impresso
												cTexto := TruncTexto( STRTRAN(AllTrim(aGantt[nX][2][nY][5]),"'",'"'), aRetorno[4]-(nCol2-100) )
												oQPrint:Say( nLin-40 ,nCol2-100, OemToAnsi( cTexto ) ,oFntArial08 )
										EndCase
									EndIf
								EndIF
								// desenha as tarefas predecessoras
								preDecessora( aConfig[1] ,nX ,nXIni ,nXQuebra ,aGantt ,aDep ,{ aGantt[nX][1][1] ,nLin+05 ,nCol1 ,nCol2 } ;
								,nLin     ,nCol ,dIni ,dFim ,{nGrafTop ,iIf(lDescricao ,nCol ,aPos[2]) ,nGrafDown ,aPos[4]} )
							Next nY
							
							// avanço de linha
							If (nX > nXIni)
								If (nLin < (aPos[3]-100))
									nLin += 40
								Else
									nLin := aPos[3]
								Endif
							EndIf
							
						Next nX
						
						If nXQuebra <> 0
							nXIni := nXQuebra
							nXQuebra := 0
						Else
							If nLin < (aPos[3]-100)
								nXIni := len(aGantt)
							EndIf
						Endif
						
						// Linha de separacao
						oQPrint:Line( aPos[3]   ,aPos[2] ,aPos[3]   ,aPos[4] )
						oQPrint:Line( aPos[3]-1 ,aPos[2] ,aPos[3]-1 ,aPos[4] )
						oQPrint:Line( aPos[3]-2 ,aPos[2] ,aPos[3]-2 ,aPos[4] )
						oQPrint:Line( aPos[3]-3 ,aPos[2] ,aPos[3]-3 ,aPos[4] )
						oQPrint:Line( aPos[3]-4 ,aPos[2] ,aPos[3]-4 ,aPos[4] )
						oQPrint:Line( aPos[3]-5 ,aPos[2] ,aPos[3]-5 ,aPos[4] )
						
						oQPrint:EndPage() // fim de pagina
						
					End
					
					If lLoop
						dIni := dAuxIni
						lDescricao := .F.
					EndIf
				End
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Cria o Gantt na escala 'diario'                         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Case aConfig[1] == 1
				
				While lLoop
					lLoop := .F.
					nXQuebra := 0
					nXIni := 0
					While ( nXIni < len(aGantt) )
						oQPrint:SetLandScape() // Paisagem
						oQPrint:StartPage() // Inicia uma nova pagina
						nPage++
						nLin := ImpCabec( dDateAtu ,nPage ,aPos ,oFntArial10 ,(nXIni == 0 ) ) // cabecalho
						Escala( @dIni ,@dFim ,@aConfig ,@aGantt ,aPos ,iIf(lDescricao ,nColIni ,10 ) ) // calcula a data de inicio e fim.
						
						If lDescricao
							nColIni := 30
							// monta a coluna de descricao( primeira coluna)
							ColDescr( oQPrint ,aGantt ,aCampos, aConfig ,nLin ,@nColIni ,aPos ,oFntArial08 ,oFntArial10,lProject)
							nCol := nColIni
						Else
							nCol := 10
						EndIf
						
						// monta os quadros dos dias
						aRetorno := QdroDiario( oQPrint ,aGantt ,aPos ,nLin ,nCol ,dDateAtu ,dTermino ,dIni ,dFim ,oFntArial08 ,oFont10n )
						lLoop := aRetorno[1]
						dAuxIni := aRetorno[2]
						nGrafTop := aRetorno[3][1]
						nGrafDown := aRetorno[3][2]
						
						nLin += 190
						
						// imprime todos as tarefas
						nXQuebra := 0
						For nX := 1 to Len(aGantt)
							If nX > nXIni .and. nXQuebra == 0
								If nLin >= (aPos[3]-100)
									nXQuebra := nX-1
								EndIf
							EndIf
							
							For nY := 1 to Len(aGantt[nX][2])
								
								If (nX > nXIni) .AND. (nLin < (aPos[3]-100)) .AND. lDescricao
									// Imprime as descricoes do projeto, edt ou tarefa
									ImprDescr( oQPrint ,@nLin ,@nCol ,aCampos ,aConfig ,aGantt[nX][1] ,oFntArial08)
								EndIf
								
								If aGantt[nX][2][nY][1] >= dIni
									nCol1 := nCol + ((aGantt[nX][2][nY][1]-dIni)*(44*24))
									nCol1 += Val(Substr(aGantt[nX][2][nY][2],1,2))*44
									
								Else
									If lDescricao
										nCol1 := nCol
									Else
										nCol1 := -10
									Endif
								EndIf
								
								If aGantt[nX][2][nY][3]<= dFim
									nCol2 := nCol + ((aGantt[nX][2][nY][3]-dIni)*(44*24))
									nCol2 += Val(Substr(aGantt[nX][2][nY][4],1,2))*44
									
								Else
									nCol2 := nCol + ((dFim-dIni)*(44*24))+aPos[4]
									
								EndIf
								
								// limita a distancia ao tamanho da folha
								If nCol2 > aPos[4]
									nCol2 := aPos[4]
								EndIf
								
								If nCol2 > nCol1
									//
									If (nX > nXIni) .AND. (nLin < (aPos[3]-100))
										// barra de tarefa
										nColor := If(aGantt[nx][2][ny][6]!=Nil,aGantt[nx][2][ny][6],aGantt[nx][3])
										cBmp := OnePixBmp(ConvRGB(nColor),,"PMSBMP")
										oQPrint:SayBitmap( nLin+5 ,nCol1 ,cBmp,iIf(nCol2-nCol1>3,nCol2-nCol1,3),(nLin+20-nLin))
										//oQPrint:Box( nLin+05 ,nCol1 ,nLin+25 ,nCol2 )
										If !Empty(aGantt[nX][2][nY][5]) .And. dFim >= aGantt[nX][2][nY][3] .And. dIni <= aGantt[nX][2][nY][3]
											Do Case
												Case aGantt[nX][2][nY][8] == 1
													// texto a ser impresso
													cTexto := TruncTexto( STRTRAN(AllTrim(aGantt[nX][2][nY][5]),"'",'"'), aRetorno[4]-(nCol2+50) )
													oQPrint:Say( nLin-05, nCol2+50, OemToAnsi( cTexto  ) ,oFntArial08 )
													//oQPrint:Say( nLin-10 ,nCol2+50 ,OemToAnsi( STRTRAN(AllTrim(aGantt[nX][2][nY][5]),"'",'"') ) ,oFntArial08 )
												Case aGantt[nX][2][nY][8] == 2
													// texto a ser impresso
													cTexto := TruncTexto( STRTRAN(AllTrim(aGantt[nX][2][nY][5]),"'",'"'), aRetorno[4]-(nCol2-100) )
													oQPrint:Say( nLin-40 ,nCol2-100, OemToAnsi( cTexto ) ,oFntArial08 )
											EndCase
										EndIf
									Endif
								EndIf
								
								//
								If (nX > nXIni)
									// desenha os relacionamentos
									preDecessora( aConfig[1] ,nX ,nXIni ,nXQuebra ,aGantt ,aDep ,{ aGantt[nX][1][1] ,nLin+05 ,nCol1 ,nCol2 } ,nLin     ,;
														nCol ,dIni ,dFim ,{nGrafTop ,iIf(lDescricao ,nCol ,aPos[2]) ,nGrafDown ,aPos[4]} )
								Else
									// desenha os relacionamentos
									preDecessora( aConfig[1] ,nX ,nXIni ,nXQuebra ,aGantt ,aDep ,{ aGantt[nX][1][1] ,nLin+05 ,nCol1 ,nCol2 } ,nGrafTop ,;
														nCol ,dIni ,dFim ,{nGrafTop ,iIf(lDescricao ,nCol ,aPos[2]) ,nGrafDown ,aPos[4]} )
								EndIf
								
							Next nY
							
							//
							If (nX > nXIni)
								if (nLin < (aPos[3]-100))
									nLin += 40
								Else
									nLin := aPos[3]
								Endif
							EndIf
							
						Next nX
						
						If nXQuebra <> 0
							nXIni := nXQuebra
							nXQuebra := 0
						Else
							If nLin < (aPos[3]-100)
								nXIni := len(aGantt)
							EndIf
						Endif
						
						// Linha de separacao
						oQPrint:Line( aPos[3]   ,aPos[2] ,aPos[3]   ,aPos[4] )
						oQPrint:Line( aPos[3]-1 ,aPos[2] ,aPos[3]-1 ,aPos[4] )
						oQPrint:Line( aPos[3]-2 ,aPos[2] ,aPos[3]-2 ,aPos[4] )
						oQPrint:Line( aPos[3]-3 ,aPos[2] ,aPos[3]-3 ,aPos[4] )
						oQPrint:Line( aPos[3]-4 ,aPos[2] ,aPos[3]-4 ,aPos[4] )
						oQPrint:Line( aPos[3]-5 ,aPos[2] ,aPos[3]-5 ,aPos[4] )
						
						oQPrint:EndPage() // fim de pagina
						
					End
					
					If lLoop
						dIni := dAuxIni
						lDescricao := .F.
					EndIf
					
				End
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Cria o Gantt na escala 'semanal'                        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Case aConfig[1] == 2
				
				While lLoop
					lLoop := .F.
					nXQuebra := 0
					nXIni := 0
					While ( nXIni < len(aGantt) )
						oQPrint:SetLandScape() // Paisagem
						oQPrint:StartPage() // Inicia uma nova pagina
						nPage++ // avanca uma pagina
						nLin := ImpCabec( dDateAtu ,nPage ,aPos ,oFntArial10 ,(nXIni == 0 ) ) // imprime cabecalho
						Escala( @dIni ,@dFim ,@aConfig ,@aGantt ,aPos ,iIf(lDescricao ,nColIni ,10 ) ) // calcula a data de inicio e fim.
						
						If lDescricao
							nColIni := 30
							// monta a coluna de descricao( primeira coluna)
							ColDescr( oQPrint ,aGantt ,aCampos, aConfig ,nLin ,@nColIni ,aPos ,oFntArial08 ,oFntArial10,lProject)
							nCol := nColIni
						Else
							nCol := 10
						EndIf
						
						// desenha as colunas
						aRetorno := QdroSemanal( oQPrint ,aGantt ,aPos ,nLin ,nCol ,dDateAtu ,dTermino ,dIni ,dFim ,aMeses ,oFntArial08 ,oFont10n )
						lLoop := aRetorno[1]
						dAuxIni := aRetorno[2]
						nGrafTop := aRetorno[3][1]
						nGrafDown := aRetorno[3][2]
						
						nLin += 190
						nXQuebra := 0
						For nX := 1 to Len(aGantt)
							If nX > nXIni .and. nXQuebra == 0
								If nLin >= (aPos[3]-100)
									nXQuebra := nX-1
								EndIf
							EndIf
							
							For nY := 1 to Len(aGantt[nX][2])
								If (nX > nXIni) .AND. (nLin < (aPos[3]-100)) .AND. lDescricao
									// Imprime as descricoes do projeto, edt ou tarefa
									ImprDescr( oQPrint ,@nLin ,@nCol ,aCampos ,aConfig ,aGantt[nX][1] ,oFntArial08)
								EndIf
								
								If aGantt[nX][2][nY][1] >= dIni
									nCol1 := nCol + (aGantt[nX][2][nY][1]-dIni)*(22*3)
									nCol1 += (Val(Substr(aGantt[nX][2][nY][2],1,2))/24)*(22*3)
								Else
									If lDescricao
										nCol1 := nCol
									Else
										nCol1 := -10
									Endif
								EndIf
								If aGantt[nX][2][nY][3] <= dFim
									nCol2 := nCol + (Min(aGantt[nX][2][nY][3],dFim)-dIni)*(22*3)
									nCol2 += (Val(Substr(aGantt[nX][2][nY][4],1,2))/24)*(22*3)
									
								Else
									nCol2 := nCol + ((dFim-dIni)*(22*3))+aPos[4]
									
								EndIf
								// limita a distancia ao tamanho da folha
								If nCol2 > aPos[4]
									nCol2 := aPos[4]
								EndIf
								If nCol2 > nCol1
									//
									If (nX > nXIni) .AND. (nLin < (aPos[3]-100))
										// barra de tarefa
										nColor := If(aGantt[nx][2][ny][6]!=Nil,aGantt[nx][2][ny][6],aGantt[nx][3])
										cBmp := OnePixBmp(ConvRGB(nColor),,"PMSBMP")
										oQPrint:SayBitmap( nLin+5 ,nCol1 ,cBmp,iIf(nCol2-nCol1>3,nCol2-nCol1,3),(nLin+20-nLin))
										//oQPrint:Box( nLin+05 ,nCol1 ,nLin+25 ,nCol2 )
										
										If !Empty(aGantt[nX][2][nY][5]) .And. dFim >= aGantt[nX][2][nY][3] .And. dIni <= aGantt[nX][2][nY][3]
											Do Case
												Case aGantt[nX][2][nY][8] == 1
													// texto a ser impresso
													cTexto := TruncTexto( STRTRAN(AllTrim(aGantt[nX][2][nY][5]),"'",'"'), aRetorno[4]-(nCol2+50) )
													oQPrint:Say( nLin-10 ,nCol2+50 ,OemToAnsi( cTexto ) ,oFntArial08 )
												Case aGantt[nX][2][nY][8] == 2
													// texto a ser impresso
													cTexto := TruncTexto( STRTRAN(AllTrim(aGantt[nX][2][nY][5]),"'",'"'), aRetorno[4]-(nCol2-100) )
													oQPrint:Say( nLin-40 ,nCol2-100, OemToAnsi( cTexto ) ,oFntArial08 )
											EndCase
										EndIf
									EndIf
								EndIf
								
								// desenha os relacionamentos
								//
								If (nX > nXIni)
									// desenha os relacionamentos
									preDecessora( aConfig[1] ,nX ,nXIni ,nXQuebra ,aGantt ,aDep ,{ aGantt[nX][1][1] ,nLin+05  ,nCol1 ,nCol2 } ;
									,nLin     ,nCol ,dIni ,DFim  ,{nGrafTop ,iIf(lDescricao ,nCol ,aPos[2]) ,nGrafDown ,aPos[4]} )
								Else
									// desenha os relacionamentos
									preDecessora( aConfig[1] ,nX ,nXIni ,nXQuebra ,aGantt ,aDep ,{ aGantt[nX][1][1] ,nGrafTop ,nCol1 ,nCol2 };
									 ,nGrafTop ,nCol ,dIni, dFim  ,{nGrafTop ,iIf(lDescricao ,nCol ,aPos[2]) ,nGrafDown ,aPos[4]} )
								EndIf
								
							Next nY
							//
							If (nX > nXIni)
								if (nLin < (aPos[3]-100))
									nLin += 40
								Else
									nLin := aPos[3]
								Endif
							EndIf
							
						Next nX
						
						If nXQuebra <> 0
							nXIni := nXQuebra
							nXQuebra := 0
						Else
							If nLin < (aPos[3]-100)
								nXIni := len(aGantt)
							EndIf
						Endif
						
						// Linha de separacao
						oQPrint:Line( aPos[3]   ,aPos[2] ,aPos[3]   ,aPos[4] )
						oQPrint:Line( aPos[3]-1 ,aPos[2] ,aPos[3]-1 ,aPos[4] )
						oQPrint:Line( aPos[3]-2 ,aPos[2] ,aPos[3]-2 ,aPos[4] )
						oQPrint:Line( aPos[3]-3 ,aPos[2] ,aPos[3]-3 ,aPos[4] )
						oQPrint:Line( aPos[3]-4 ,aPos[2] ,aPos[3]-4 ,aPos[4] )
						oQPrint:Line( aPos[3]-5 ,aPos[2] ,aPos[3]-5 ,aPos[4] )
						
						oQPrint:EndPage() // fim de pagina
					End
					
					If lLoop
						dIni := dAuxIni
						lDescricao := .F.
						
					EndIf
				End
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Cria o Gantt na escala 'mensal' 100%                    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Case aConfig[1] == 3
				
				While lLoop
					lLoop := .F.
					nXQuebra := 0
					nXIni := 0
					While ( nXIni < len(aGantt) )
						oQPrint:SetLandScape() // Paisagem
						oQPrint:StartPage() // Inicia uma nova pagina
						nPage++ // avanca uma pagina
						nLin := ImpCabec( dDateAtu ,nPage ,aPos ,oFntArial10 ,(nXIni == 0 ) ) // imprime cabecalho
						Escala( @dIni ,@dFim ,@aConfig ,@aGantt ,aPos ,iIf(lDescricao ,nColIni ,10 ) ) // calcula a data de inicio e fim.
						
						If lDescricao
							nColIni := 30
							// monta a coluna de descricao( primeira coluna)
							ColDescr( oQPrint ,aGantt ,aCampos, aConfig ,nLin ,@nColIni ,aPos ,oFntArial08 ,oFntArial10,lProject)
							nCol := nColIni
						Else
							nCol := 10
						EndIf
						
						// monta os quadros dos meses
						aRetorno := QdroMensal( oQPrint ,aGantt ,aPos ,nLin ,nCol ,dDateAtu ,dTermino ,dIni ,dFim ,aMeses ,oFntArial08 ,oFont10n )
						lLoop := aRetorno[1]
						dAuxIni := aRetorno[2]
						nGrafTop := aRetorno[3][1]
						nGrafDown := aRetorno[3][2]
						
						nLin += 190
						nXQuebra := 0
						For nX := 1 to Len(aGantt)
							If nX > nXIni .and. nXQuebra == 0
								If nLin >= (aPos[3]-100)
									nXQuebra := nX-1
								EndIf
							EndIf
							
							For nY := 1 to Len(aGantt[nX][2])
								
								If (nX > nXIni) .AND. (nLin < (aPos[3]-100)) .AND. lDescricao
									// Imprime as descricoes do projeto, edt ou tarefa
									ImprDescr( oQPrint ,@nLin ,@nCol ,aCampos ,aConfig ,aGantt[nX][1] ,oFntArial08)
								EndIf
								
								If aGantt[nX][2][nY][1] >= dIni
									nCol1 := nCol + ((aGantt[nX][2][nY][1]-dIni)*22)
									nCol1 += (Val(Substr(aGantt[nX][2][nY][2],1,2))/720)*22
								Else
									If lDescricao
										nCol1 := nCol
									Else
										nCol1 := -10
									Endif
								EndIf
								If aGantt[nX][2][nY][3] <= dFim
									nCol2 := nCol + ((aGantt[nX][2][nY][3]-dIni)*22)
									nCol2 += (Val(Substr(aGantt[nX][2][nY][4],1,2))/720)*22
									
								Else
									nCol2 := nCol + ((dFim-dIni)*22)+aPos[4]
									
								EndIf
								
								// limita a distancia ao tamanho da folha
								If nCol2 > aPos[4]
									nCol2 := aPos[4]
								EndIf
								
								If nCol2 > nCol1
									//
									If (nX > nXIni) .AND. (nLin < (aPos[3]-100))
										// barra de tarefa
										nColor := If(aGantt[nx][2][ny][6]!=Nil,aGantt[nx][2][ny][6],aGantt[nx][3])
										cBmp := OnePixBmp(ConvRGB(nColor),,"PMSBMP")
										oQPrint:SayBitmap( nLin+5 ,nCol1 ,cBmp,iIf(nCol2-nCol1>3,nCol2-nCol1,3),(nLin+20-nLin))
										//oQPrint:Box( nLin+05 ,nCol1 ,nLin+25 ,nCol2 )
										
										If !Empty(aGantt[nX][2][nY][5]) .And. dFim >= aGantt[nX][2][nY][3] .And. dIni <= aGantt[nX][2][nY][3]
											
											Do Case
												Case aGantt[nX][2][nY][8] == 1
													// texto a ser impresso
													cTexto := TruncTexto( STRTRAN(AllTrim(aGantt[nX][2][nY][5]),"'",'"'), aRetorno[4]-(nCol2+50) )
													oQPrint:Say( nLin-10 ,nCol2+50 ,OemToAnsi( cTexto ) ,oFntArial08 )
												Case aGantt[nX][2][nY][8] == 2
													// texto a ser impresso
													cTexto := TruncTexto( STRTRAN(AllTrim(aGantt[nX][2][nY][5]),"'",'"'), aRetorno[4]-(nCol2-100) )
													oQPrint:Say( nLin-40 ,nCol2-100, OemToAnsi( cTexto ) ,oFntArial08 )
											EndCase
										EndIf
									EndIf
									
								EndIf
								// desenha os relacionamentos
								//
								If (nX > nXIni)
									// desenha os relacionamentos
									preDecessora( aConfig[1] ,nX ,nXIni ,nXQuebra ,aGantt ,aDep ,{ aGantt[nX][1][1] ,nLin+05  ,nCol1 ,nCol2 } ,;
									nLin     ,nCol ,dIni ,dFim  ,{nGrafTop ,iIf(lDescricao ,nCol ,aPos[2]) ,nGrafDown ,aPos[4]} )
								Else
									// desenha os relacionamentos
									preDecessora( aConfig[1] ,nX ,nXIni ,nXQuebra ,aGantt ,aDep ,{ aGantt[nX][1][1] ,nGrafTop ,nCol1 ,nCol2 } ,;
									nGrafTop ,nCol ,dIni, dFim  ,{nGrafTop ,iIf(lDescricao ,nCol ,aPos[2]) ,nGrafDown ,aPos[4]} )
								EndIf
								
							Next nY
							//
							If (nX > nXIni)
								if (nLin < (aPos[3]-100))
									nLin += 40
								Else
									nLin := aPos[3]
								Endif
							EndIf
							
						Next nX
						
						If nXQuebra <> 0
							nXIni := nXQuebra
							nXQuebra := 0
						Else
							If nLin < (aPos[3]-100)
								nXIni := len(aGantt)
							EndIf
						Endif
						
						// Linha de separacao
						oQPrint:Line( aPos[3]   ,aPos[2] ,aPos[3]   ,aPos[4] )
						oQPrint:Line( aPos[3]-1 ,aPos[2] ,aPos[3]-1 ,aPos[4] )
						oQPrint:Line( aPos[3]-2 ,aPos[2] ,aPos[3]-2 ,aPos[4] )
						oQPrint:Line( aPos[3]-3 ,aPos[2] ,aPos[3]-3 ,aPos[4] )
						oQPrint:Line( aPos[3]-4 ,aPos[2] ,aPos[3]-4 ,aPos[4] )
						oQPrint:Line( aPos[3]-5 ,aPos[2] ,aPos[3]-5 ,aPos[4] )
						oQPrint:EndPage() // fim de pagina
						
					End
					
					If lLoop
						dIni := dAuxIni
						lDescricao := .F.
					EndIf
				End
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Cria o Gantt na escala 'mensal' 30%                     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Case aConfig[1] == 4
				
				While lLoop
					lLoop := .F.
					nXQuebra := 0
					nXIni := 0
					While ( nXIni < len(aGantt) )
						oQPrint:SetLandScape() // Paisagem
						oQPrint:StartPage() // Inicia uma nova pagina
						nPage++ // avanca uma pagina
						nLin := ImpCabec( dDateAtu ,nPage ,aPos ,oFntArial10 ) // imprime cabecalho
						Escala( @dIni ,@dFim ,@aConfig ,@aGantt ,aPos ,iIf(lDescricao ,nColIni ,10 ) ) // calcula a data de inicio e fim.
						
						If lDescricao
							nColIni := 30
							// monta a coluna de descricao( primeira coluna)
							ColDescr( oQPrint ,aGantt ,aCampos, aConfig ,nLin ,@nColIni ,aPos ,oFntArial08 ,oFntArial10,lProject)
							nCol := nColIni
						Else
							nCol := 10
						EndIf
						
						// monta os quadros dos meses
						aRetorno := QdroMes30( oQPrint ,aGantt ,aPos ,nLin ,nCol ,dDateAtu ,dTermino ,dIni ,dFim ,aMeses ,oFntArial08 ,oFont10n )
						lLoop := aRetorno[1]
						dAuxIni := aRetorno[2]
						nGrafTop := aRetorno[3][1]
						nGrafDown := aRetorno[3][2]
						
						nLin += 190
						nXQuebra := 0
						For nX := 1 to Len(aGantt)
							If nX > nXIni .and. nXQuebra == 0
								If nLin >= (aPos[3]-100)
									nXQuebra := nX-1
								EndIf
							EndIf
							
							For nY := 1 to Len(aGantt[nX][2])
								
								If (nX > nXIni) .AND. (nLin < (aPos[3]-100)) .and. lDescricao
									// Imprime as descricoes do projeto, edt ou tarefa
									ImprDescr( oQPrint ,@nLin ,@nCol ,aCampos ,aConfig ,aGantt[nX][1] ,oFntArial08)
								EndIf
								
								If aGantt[nX][2][nY][1] >= dIni
									nCol1 := nCol + ((aGantt[nX][2][nY][1]-dIni)*7.3 )
									nCol1 += (Val(Substr(aGantt[nX][2][nY][2],1,2))/720) *7.3
								Else
									If lDescricao
										nCol1 := nCol
									Else
										nCol1 := -10
									Endif
									
								EndIf
								
								If aGantt[nX][2][nY][3] <= dFim
									nCol2 := nCol + ((aGantt[nX][2][nY][3]-dIni)*7.3 )
									nCol2 += (Val(Substr(aGantt[nX][2][nY][4],1,2))/720) *7.3
									
								Else
									nCol2 := nCol + ((dFim-dIni)*7.3 )+aPos[4]
									
								EndIf
								
								// limita a distancia ao tamanho da folha
								If nCol2 > aPos[4]
									nCol2 := aPos[4]
								EndIf
								
								If nCol2 > nCol1
									//
									If (nX > nXIni) .AND. (nLin < (aPos[3]-100))
										// barra de tarefa
										nColor := If(aGantt[nx][2][ny][6]!=Nil,aGantt[nx][2][ny][6],aGantt[nx][3])
										cBmp := OnePixBmp(ConvRGB(nColor),,"PMSBMP")
										oQPrint:SayBitmap( nLin+5 ,nCol1 ,cBmp,iIf(nCol2-nCol1>3,nCol2-nCol1,3),(nLin+20-nLin))
										//oQPrint:Box( nLin+05 ,nCol1 ,nLin+25 ,nCol2 )
										
										If !Empty(aGantt[nX][2][nY][5]) .And. dFim >= aGantt[nX][2][nY][3] .And. dIni <= aGantt[nX][2][nY][3]
											Do Case
												Case aGantt[nX][2][nY][8] == 1
													// texto a ser impresso
													cTexto := TruncTexto( STRTRAN(AllTrim(aGantt[nX][2][nY][5]),"'",'"'), aRetorno[4]-(nCol2+50) )
													oQPrint:Say( nLin-10, nCol2+50, OemToAnsi( cTexto ) , oFntArial08 )
												Case aGantt[nX][2][nY][8] == 2
													// texto a ser impresso
													cTexto := TruncTexto( STRTRAN(AllTrim(aGantt[nX][2][nY][5]),"'",'"'), aRetorno[4]-(nCol2-100) )
													oQPrint:Say( nLin-40, nCol2-100, OemToAnsi( cTexto ), oFntArial08 )
											EndCase
										EndIf
									EndIf
								EndIf
								
								// desenha os relacionamentos
								//
								If (nX > nXIni)
									// desenha os relacionamentos
									preDecessora( aConfig[1] ,nX ,nXIni ,nXQuebra ,aGantt ,aDep ,{ aGantt[nX][1][1] ,nLin+05  ,nCol1 ,nCol2 },;
													 nLin   ,nCol ,dIni ,dFim ,{nGrafTop ,iIf(lDescricao ,nCol ,aPos[2]) ,nGrafDown ,aPos[4]} )
								Else
									// desenha os relacionamentos
									preDecessora( aConfig[1] ,nX ,nXIni ,nXQuebra ,aGantt ,aDep ,{ aGantt[nX][1][1] ,nGrafTop ,nCol1 ,nCol2 } ,;
													nGrafTop ,nCol ,dIni ,dFim ,{nGrafTop ,iIf(lDescricao ,nCol ,aPos[2]) ,nGrafDown ,aPos[4]} )
								EndIf
							Next nY
							
							//
							If (nX > nXIni)
								if (nLin < (aPos[3]-100))
									nLin += 40
								Else
									nLin := aPos[3]
								Endif
							EndIf
							
						Next nX
						
						If nXQuebra <> 0
							nXIni := nXQuebra
							nXQuebra := 0
						Else
							If nLin < (aPos[3]-100)
								nXIni := len(aGantt)
							EndIf
						Endif
						
						// Linha de separacao
						oQPrint:Line( aPos[3]   ,aPos[2] ,aPos[3]   ,aPos[4] )
						oQPrint:Line( aPos[3]-1 ,aPos[2] ,aPos[3]-1 ,aPos[4] )
						oQPrint:Line( aPos[3]-2 ,aPos[2] ,aPos[3]-2 ,aPos[4] )
						oQPrint:Line( aPos[3]-3 ,aPos[2] ,aPos[3]-3 ,aPos[4] )
						oQPrint:Line( aPos[3]-4 ,aPos[2] ,aPos[3]-4 ,aPos[4] )
						oQPrint:Line( aPos[3]-5 ,aPos[2] ,aPos[3]-5 ,aPos[4] )
						oQPrint:EndPage() // fim de pagina
					End
					If lLoop
						dIni := dAuxIni
						lDescricao := .F.
					EndIf
					
				End
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Cria o Gantt na escala bimestral                        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Case aConfig[1] == 5
				
				While lLoop
					lLoop := .F.
					nXQuebra := 0
					nXIni := 0
					While ( nXIni < len(aGantt) )
						oQPrint:SetLandScape() // Paisagem
						oQPrint:StartPage() // Inicia uma nova pagina
						nPage++ // avanca uma pagina
						nLin := ImpCabec( dDateAtu ,nPage ,aPos ,oFntArial10 ) // imprime cabecalho
						Escala( @dIni ,@dFim ,@aConfig ,@aGantt ,aPos ,iIf(lDescricao ,nColIni ,10 ) ) // calcula a data de inicio e fim.
						
						If lDescricao
							nColIni := 30
							// monta a coluna de descricao( primeira coluna)
							ColDescr( oQPrint ,aGantt ,aCampos, aConfig ,nLin ,@nColIni ,aPos ,oFntArial08 ,oFntArial10,lProject)
							nCol := nColIni
						Else
							nCol := 10
						EndIf
						
						// monta os quadros dos meses
						aRetorno := QdroBimestral( oQPrint ,aGantt ,aPos ,nLin ,nCol ,dDateAtu ,dTermino ,dIni ,dFim ,aMeses ,oFntArial08 ,oFont10n )
						lLoop := aRetorno[1]
						dAuxIni := aRetorno[2]
						nGrafTop := aRetorno[3][1]
						nGrafDown := aRetorno[3][2]
						
						nLin += 190
						nXQuebra := 0
						For nX := 1 to Len(aGantt)
							If nX > nXIni .and. nXQuebra == 0
								If nLin >= (aPos[3]-100)
									nXQuebra := nX-1
								EndIf
							EndIf
							
							For nY := 1 to Len(aGantt[nX][2])
								
								If (nX > nXIni) .AND. (nLin < (aPos[3]-100)) .AND. lDescricao
									ImprDescr( oQPrint ,@nLin ,@nCol ,aCampos ,aConfig ,aGantt[nX][1] ,oFntArial08)
								EndIf
								
								If aGantt[nX][2][nY][1] >= dIni
									nCol1 := nCol +(((aGantt[nX][2][nY][1]-dIni)/2)*7.3)
									nCol1 += ((Val(Substr(aGantt[nX][2][nY][2],1,2))/720)/2)*7.3
								Else
									If lDescricao
										nCol1 := nCol
									Else
										nCol1 := -10
									Endif
									
								EndIf
								
								If aGantt[nX][2][nY][3] <= dFim
									nCol2 := nCol +(((aGantt[nX][2][nY][3]-dIni)/2)*7.3)
									nCol2 += (((Val(Substr(aGantt[nX][2][nY][4],1,2))/720)/2)*7.3)
									
								Else
									nCol2 := nCol +(((dFim-dIni)/2)*7.3)+aPos[4]
									
								EndIf
								
								// limita a distancia ao tamanho da folha
								If nCol2 > aPos[4]
									nCol2 := aPos[4]
								EndIf
								
								If nCol2 > nCol1
									//
									If (nX > nXIni) .AND. (nLin < (aPos[3]-100))
										// barra de tarefa
										nColor := If(aGantt[nx][2][ny][6]!=Nil,aGantt[nx][2][ny][6],aGantt[nx][3])
										cBmp := OnePixBmp(ConvRGB(nColor),,"PMSBMP")
										oQPrint:SayBitmap( nLin+5 ,nCol1 ,cBmp,iIf(nCol2-nCol1>3,nCol2-nCol1,3),(nLin+20-nLin))
										//oQPrint:Box( nLin+05 ,nCol1 ,nLin+25 ,nCol2 )
										
										If !Empty(aGantt[nX][2][nY][5]) .And. dFim >= aGantt[nX][2][nY][3] .And. dIni <= aGantt[nX][2][nY][3]
											Do Case
												Case aGantt[nX][2][nY][8] == 1
													// texto a ser impresso
													cTexto := TruncTexto( STRTRAN(AllTrim(aGantt[nX][2][nY][5]),"'",'"'), aRetorno[4]-(nCol2+50) )
													oQPrint:Say( nLin-10 ,nCol2+50 ,OemToANSI( cTexto ) ,oFntArial08 )
													
												Case aGantt[nX][2][nY][8] == 2
													// texto a ser impresso
													cTexto := TruncTexto( STRTRAN(AllTrim(aGantt[nX][2][nY][5]),"'",'"'), aRetorno[4]-(nCol2-100) )
													oQPrint:Say( nLin-40,nCol2-100 ,OemToANSI( cTexto ) ,oFntArial08 )
													
											EndCase
										EndIf
									EndIf
								EndIf
								
								// desenha os relacionamentos
								//
								If (nX > nXIni)
									// desenha os relacionamentos
									preDecessora( aConfig[1] ,nX ,nXIni ,nXQuebra ,aGantt ,aDep ,{ aGantt[nX][1][1] ,nLin+05  ,nCol1 ,nCol2 }, ;
									nLin     ,nCol ,dIni ,dFim  ,{nGrafTop ,iIf(lDescricao ,nCol ,aPos[2]) ,nGrafDown ,aPos[4]} )
								Else
									// desenha os relacionamentos
									preDecessora( aConfig[1] ,nX ,nXIni ,nXQuebra ,aGantt ,aDep ,{ aGantt[nX][1][1] ,nGrafTop ,nCol1 ,nCol2 },;
									nGrafTop ,nCol ,dIni ,dFim  ,{nGrafTop ,iIf(lDescricao ,nCol ,aPos[2]) ,nGrafDown ,aPos[4]} )
								EndIf
								
							Next nY
							
							//
							If (nX > nXIni)
								if (nLin < (aPos[3]-100))
									nLin += 40
								Else
									nLin := aPos[3]
								Endif
							EndIf
							
						Next nX
						
						If nXQuebra <> 0
							nXIni := nXQuebra
							nXQuebra := 0
						Else
							If nLin < (aPos[3]-100)
								nXIni := len(aGantt)
							EndIf
						Endif
						
						// Linha de separacao
						oQPrint:Line( aPos[3]   ,aPos[2] ,aPos[3]   ,aPos[4] )
						oQPrint:Line( aPos[3]-1 ,aPos[2] ,aPos[3]-1 ,aPos[4] )
						oQPrint:Line( aPos[3]-2 ,aPos[2] ,aPos[3]-2 ,aPos[4] )
						oQPrint:Line( aPos[3]-3 ,aPos[2] ,aPos[3]-3 ,aPos[4] )
						oQPrint:Line( aPos[3]-4 ,aPos[2] ,aPos[3]-4 ,aPos[4] )
						oQPrint:Line( aPos[3]-5 ,aPos[2] ,aPos[3]-5 ,aPos[4] )
						oQPrint:EndPage() // fim de pagina
						
					End
					If lLoop
						dIni := dAuxIni
						lDescricao := .F.
					EndIf
				End
		EndCase
	EndIf
	
	oQPrint:Preview()  // Visualiza o relatorio
	
EndIf

Return( NIL )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ImpCabec   ³ Autor ³ Reynaldo T. Miyashita   ³ Data ³ 21/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta o cabecalho principal, as paginas q ficam no topo 		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oQPrint - Objeto TMSPrinter                                   ³±±
±±³          ³ nPage - Numero da pagina corrente						     ³±±
±±³          ³ nLin - Linha corrente do relatorio, por referencia		     ³±±
±±³          ³ aPos - Tamanho da pagina                                      ³±±
±±³          ³ oFont08 - Objeto TFont, fonte de tamanho 08                   ³±±
±±³          ³ lTopPage - Se deve imprimir o cabecalho                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    	 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpCabec( dDateAtu ,nPage ,aPos ,oFont08 ,lTopPage )
Local aFil			:= IIf( FindFunction( "FWArrFilAtu" ), FWArrFilAtu( cEmpAnt, cFilAnt ), { cEmpAnt, cFilAnt }  )  
Local cFileLogo 	:= "LGRL" + aFil[1] + aFil[2] + ".BMP" // Empresa+Filial
Local nColEmp		:= 0
Local nLin			:= aPos[1]
Local cNomeProg		:= "PMSR350"

Local oFont18n	:= TFont():New( "Arial" ,18 ,23 ,,.T. ,,,,.T. ,.F. )

DEFAULT lTopPage := .T.

If lTopPage
	
	// mostra o logotipo
	If !File(cFileLogo)
		cFileLogo := "LGRL" + aFil[1] +".BMP" // Empresa
	Endif
	oQPrint:SayBitmap( aPos[1]+10 ,aPos[2]+10 ,cFileLogo ,aPos[1]+510 ,aPos[2]+120) // imprime o logotipo
	// Titulo da empresa
	nColEmp := ( (aPos[4]-(aPos[2]+120+500))-(Len(oQPrint:cDocument)*30) )/2 // posicao do titulo
	nLin += 100
	oQPrint:Say( nLin ,nColEmp ,OemToAnsi(oQPrint:cDocument) ,oFont18n )
	
Else
	nLin += 50
EndIf

// Pagina
oQPrint:Say( nLin ,aPos[4]-500 ,OemToAnsi(STR0001 + alltrim(str(nPage)) ) ,oFont08 )

If lTopPage
	// database
	nLin += 40
	oQPrint:Say( nLin ,aPos[4]-500 ,OemToAnsi(STR0002 +  dtoc(dDateAtu)) ,oFont08 )
	
	// nome do arquivo e versao do sistema
	oQPrint:Say( nLin ,aPos[2]     ,OemToAnsi("SIGA /"+cNomeProg+" /v."+ cVersao ) ,oFont08 )
	
	// data de impressao
	nLin += 40
	oQPrint:Say( nLin ,aPos[4]-500 ,OemToAnsi(STR0003 + dtoc(date())) ,oFont08 )
	// hora de impressao
	oQPrint:Say( nLin ,aPos[2]     ,OemToAnsi(STR0004 + time()) ,oFont08 )
	nLin += 45
	
	// Linha de separacao
	oQPrint:Line( nLin   ,aPos[2] ,nLin ,aPos[4] )
	oQPrint:Line( nLin++ ,aPos[2] ,nLin ,aPos[4] )
	oQPrint:Line( nLin++ ,aPos[2] ,nLin ,aPos[4] )
	oQPrint:Line( nLin++ ,aPos[2] ,nLin ,aPos[4] )
	oQPrint:Line( nLin++ ,aPos[2] ,nLin ,aPos[4] )
	oQPrint:Line( nLin++ ,aPos[2] ,nLin ,aPos[4] )
	nLin += 20
Else
	nLin += 50
Endif

Return( nLin )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Escala     ³ Autor ³ Reynaldo T. Miyashita   ³ Data ³ 21/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Escala de tempo pro grafico                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ dIni - Data de Inicio                                         ³±±
±±³          ³ dFim - Data de Fim                                            ³±±
±±³          ³ aConfig - Escala do tempo escolhido                           ³±±
±±³          ³ aGantt - Tarefas do Projeto corrente                          ³±±
±±³          ³ aPos - Tamanho da pagina                                      ³±±
±±³          ³ nColIni - Posicao da coluna do relatorio                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    	 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Escala( dIni ,dFim ,aConfig ,aGantt ,aPos ,nColIni )

Local nY := 0
Local nX := 0

DEFAULT dFim := CTOD( "  /  /  " )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as datas iniciais e finais da escala.          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Empty(dIni) .Or. (aConfig[1]==6)
	dIni := CTOD("01/01/2020")
	dFim := CTOD("01/01/1980")
	For nX := 1 to Len(aGantt)
		For nY := 1 to Len(aGantt[nX][2])
			If !Empty(aGantt[nX][2][nY][1]) .And. aGantt[nX][2][nY][1] < dIni
				dIni := aGantt[nX][2][nY][1]
			EndIf
			If !Empty(aGantt[nX][2][nY][3]).And. aGantt[nX][2][nY][3] > dFim
				dFim := aGantt[nX][2][nY][3]
			EndIf
		Next nY
	Next nX
EndIf
If (aConfig[1] == Nil) .Or. (aConfig[1]==6)
	Do Case
		Case dFim-dIni > 240
			aConfig[1] := 5
		Case dFim-dIni > 89
			aConfig[1] := 4
		Case dFim-dIni > 21
			aConfig[1] := 3
		Case dFim-dIni > 3
			aConfig[1] := 2
		OtherWise
			aConfig[1] := 1
	EndCase
EndIf

Do Case
	Case aConfig[1] == -1
		dFim := dIni+(((aPos[4])-nColIni)/288)
	Case aConfig[1] == 0
		dFim := dIni+(((aPos[4])-nColIni)/144)
	Case aConfig[1] == 1
		dFim := dIni+((aPos[4]-nColIni)/72)
	Case aConfig[1] == 2
		If DOW(dIni)<>1
			dIni -= DOW(dIni)-1
		EndIf
		dFim := dIni+(((aPos[4]-nColIni)/9))
	Case aConfig[1] == 3
		dFim := dIni+((aPos[4]-nColIni)/22)
	Case aConfig[1] == 4
		dFim := dIni+((aPos[4]-nColIni)/7.3)
	Case aConfig[1] == 5
		dFim := dIni+(((aPos[4]-nColIni)*2)/7.3)
EndCase

Return( NIL )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QdroHora1  ³ Autor ³ Reynaldo T. Miyashita   ³ Data ³ 21/07/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta os quadros de separacao por hora no relatorio            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oQPrint - objeto TMSPrinter                                   ³±±
±±³          ³ aGantt - Tarefas do Projeto corrente                          ³±±
±±³          ³ nLin - Posicao da linha corrente do relatorio                 ³±±
±±³          ³ nCol - Posicao da coluna corrente do relatorio                ³±±
±±³          ³ dDateAtu - Data de referencia                                 ³±±
±±³          ³ dTermino - Data de termino do projeto                         ³±±
±±³          ³ dIni-  Data de Inicio                                         ³±±
±±³          ³ dFim - Data de Fim                                            ³±±
±±³          ³ aConfig - Escala do tempo escolhido                           ³±±
±±³          ³ oFntArial08 - Objeto TFont, fonte Arial de tamanho 08        ³±±
±±³          ³ oFont10n - Objeto TFont, fonte de tamanho 10                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    	 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function QdroHora1( oQPrint ,aGantt ,aPos ,nLin ,nCol ,dDateAtu ,dTermino ,dIni ,dFim ,oFntArial08 ,oFont10n )
Local dX := ctod( "  /  /  " )
Local lLoop := .F.
Local nLin2 := 0
Local nLinQdo2 := 0

Local nLargura := 2050

nLinQdo2 := nLin+150

//dFim += 5
For dx := dIni to dFim
	If (nLinQdo2+((Len(aGantt)+1)*40)) > aPos[3]
		nLin2 := aPos[3]-60
	Else
		nLin2 := (nLinQdo2+((Len(aGantt)+1)*40))
	Endif
	
	oQPrint:Box( nLin     ,nCol ,nLinQdo2 ,nCol+nLargura )
	oQPrint:Box( nLinQdo2 ,nCol ,nLin2    ,nCol+nLargura )
	If dx == dDateAtu
		
		oQPrint:Box( nLinQdo2+20 ,nCol-2+(Val(Substr(Time(),1,2))*88)+(Val(Substr(Time(),3,2))*1.47) ;
		,nLin2-20    ,nCol  +(Val(Substr(Time(),1,2))*88)+(Val(Substr(Time(),3,2))*1.47) )
		//@ -2,nCol-2+(Val(Substr(Time(),1,2))*12) To ;
		//iIf( aPos[3]-28 > 27+((nMaxTsk+1)*8) ,aPos[3]-28 ,27+((nMaxTsk+1)*8) ) ,nCol+(Val(Substr(Time(),1,2))*12) Label "" Of oPanel PIXEL
	EndIf
	
	// data da faixa
	oQPrint:Say( nLin+60 ,nCol+05 ,OemToAnsi( SPACE(18)+DTOC(dX) ) ,oFntArial08 )
	
	// horas da data
	oQPrint:Say( nLin+100 ,nCol ,;
					OemToAnsi( "   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19  20  21  22  23 " ) ,;
					oFont10n )
	
	//// TESTE DE IMPRESSAO
	//oQPrint:Box( 420 ,nCol+(22*79)    ,440 ,nCol+(22*80))
	//oQPrint:Say( 410 ,nCol      ,OemToAnsi( "XXXXXXXXX1XXXXXXXXX2XXXXXXXXX3XXXXXXXXX4XXXXXXXXX5XXXXXXXXX6XXXXXXXXX7XXXXXXXXX8XXXXXXXXX9XXX" ) ,oFont10n )
	
	nCol += nLargura
	
	If dX > dTermino
		// a proxima coluna vai ser maior
		If ((nCol+nLargura) > aPos[4])
			Exit
		Endif
	Else
		// a coluna vai ser maior
		If (nCol > aPos[4])
			lLoop := .T.
			Exit
		Endif
		
	EndIf
Next dx

Return( { lLoop ,dX ,{nLinQdo2 ,nLin2 }, nCol } )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QdroHora2  ³ Autor ³ Reynaldo T. Miyashita   ³ Data ³ 23/07/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta os quadros de separacao por dia calculado de 2 em 2 horas³±±
±±³           no relatorio                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oQPrint - objeto TMSPrinter                                   ³±±
±±³          ³ aGantt - Tarefas do Projeto corrente                          ³±±
±±³          ³ nLin - Posicao da linha corrente do relatorio                 ³±±
±±³          ³ nCol - Posicao da coluna corrente do relatorio                ³±±
±±³          ³ dDateAtu - Data de referencia                                 ³±±
±±³          ³ dTermino - Data de termino do projeto                         ³±±
±±³          ³ dIni-  Data de Inicio                                         ³±±
±±³          ³ dFim - Data de Fim                                            ³±±
±±³          ³ aConfig - Escala do tempo escolhido                           ³±±
±±³          ³ oFntArial08 - Objeto TFont, fonte Arial de tamanho 08        ³±±
±±³          ³ oFont10n - Objeto TFont, fonte de tamanho 10                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    	 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function QdroHora2( oQPrint ,aGantt ,aPos ,nLin ,nCol ,dDateAtu ,dTermino ,dIni ,dFim ,oFntArial08 ,oFont10n )
Local dX := ctod( "  /  /  " )
Local lLoop := .F.
Local nLin2 := 0
Local nLinQdo2 := 0

Local nLargura := 1016

nLinQdo2 := nLin+150

For dx := dIni to dFim
	If (nLinQdo2+((Len(aGantt)+1)*40)) > aPos[3]
		nLin2 := aPos[3]-60
	Else
		nLin2 := (nLinQdo2+((Len(aGantt)+1)*40))
	Endif
	
	oQPrint:Box( nLin     ,nCol ,nLinQdo2 ,nCol+nLargura )
	oQPrint:Box( nLinQdo2 ,nCol ,nLin2    ,nCol+nLargura )
	
	If dx == dDateAtu
		oQPrint:Box( nLinQdo2+20 ,nCol-2+(Val(Substr(Time(),1,2))*44)+(Val(Substr(Time(),3,2))*0.73) ;
		,nLin2-20    ,nCol  +(Val(Substr(Time(),1,2))*44)+(Val(Substr(Time(),3,2))*0.73) )
	EndIf
	// data da faixa
	oQPrint:Say( nLin+60 ,nCol+05 ,OemToAnsi( SPACE(18)+DTOC(dX) ) ,oFntArial08 )
	
	// horas da data
	oQPrint:Say( nLin+100 ,nCol ,OemToAnsi( "   2   4   6   8  10  12  14  16  18  20  22  " ) ,oFont10n )
	//		// TESTE DE IMPRESSAO
	//		oQPrint:Box( 420 ,nCol+(22*79)    ,440 ,nCol+(22*80))
	//		oQPrint:Say( 410 ,nCol      ,OemToAnsi( "XXXXXXXXX1XXXXXXXXX2XXXXXXXXX3XXXXXXXXX4XXXXXX" ) ,oFont10n )
	//		oQPrint:Say( 410 ,nCol      ,OemToAnsi( "XXX XXX XXX XXX XXX XXX XXX XXX XXX XXX XXX XX" ) ,oFont10n )
	
	nCol += nLargura
	
	If dX > dTermino
		// a proxima coluna vai ser maior
		If ((nCol+nLargura) > aPos[4])
			Exit
		Endif
	Else
		// a coluna vai ser maior
		If (nCol > aPos[4])
			lLoop := .T.
			Exit
		Endif
		
	EndIf
Next dx

Return( { lLoop ,dX ,{nLinQdo2 ,nLin2 }, nCol } )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QdroDiario ³ Autor ³ Reynaldo T. Miyashita   ³ Data ³ 21/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta os quadros de separacao por dia no relatorio             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oQPrint - objeto TMSPrinter                                   ³±±
±±³          ³ aGantt - Tarefas do Projeto corrente                          ³±±
±±³          ³ nLin - Posicao da linha corrente do relatorio                 ³±±
±±³          ³ nCol - Posicao da coluna corrente do relatorio                ³±±
±±³          ³ dDateAtu - Data de referencia                                 ³±±
±±³          ³ dTermino - Data de termino do projeto                         ³±±
±±³          ³ dIni-  Data de Inicio                                         ³±±
±±³          ³ dFim - Data de Fim                                            ³±±
±±³          ³ aConfig - Escala do tempo escolhido                           ³±±
±±³          ³ oFntArial08 - Objeto TFont, fonte Arial de tamanho 08        ³±±
±±³          ³ oFont10n - Objeto TFont, fonte de tamanho 10                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    	 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function QdroDiario( oQPrint ,aGantt ,aPos ,nLin ,nCol ,dDateAtu ,dTermino ,dIni ,dFim ,oFntArial08 ,oFont10n )
Local dX := ctod( "  /  /  " )
Local lLoop := .F.
Local nLin2 := 0
Local nLinQdo2 := 0

nLinQdo2 := nLin+150

For dX := dIni to dFim
	If ((nLinQdo2)+((Len(aGantt)+1)*40)) > aPos[3]
		nLin2 := aPos[3]-60
	Else
		nLin2 := ((nLinQdo2)+((Len(aGantt)+1)*40))
	Endif
	oQPrint:Box( nLin     ,nCol ,nLinQdo2 ,nCol+522 )
	oQPrint:Box( nLinQdo2 ,nCol ,nLin2    ,nCol+522 )
	
	// desenha a linha vertical da data atual
	If dX == dDateAtu
		oQPrint:Box( nLinQdo2+20 ,nCol-2+((dDateAtu-dx)*(22))+((Val(Substr(Time(),1,2))/24)*(22*24)) ;
		,nLin2-20    ,nCol+  ((dDateAtu-dx)*(22))+((Val(Substr(Time(),1,2))/24)*(22*24))   )
	EndIf
	// data da faixa
	oQPrint:Say( nLin+60 ,nCol+05 ,OemToAnsi( SPACE(7)+DTOC(dX)+SPACE(7) ) ,oFntArial08 )
	
	// horas da data
	oQPrint:Say( nLin+100 ,nCol ,OemToAnsi( STR0005 ) ,oFont10n ) //"      6    12    18     "
	//						oQPrint:Box( 420 ,nCol ,440 ,nCol+22)
	//						oQPrint:Say( 410 ,nCol ,OemToAnsi( "XXXXXX1XXXXX2XXXXX3XXXXX" ) ,oFont10)
	//						oQPrint:Box( 420 ,nCol+44 ,440,nCol+88)
	
	nCol += 522
	
	If dX > dTermino
		// a proxima coluna vai ser maior
		If ((nCol+522) > aPos[4])
			Exit
		Endif
	Else
		// a coluna vai ser maior
		If (nCol > aPos[4])
			lLoop := .T.
			Exit
		Endif
		
	EndIf
	
Next dX

Return( { lLoop ,dX ,{nLinQdo2 ,nLin2 }, nCol } )


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QdroSemanal ³ Autor ³ Reynaldo T. Miyashita   ³ Data ³ 21/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta os quadros de separacao por semana no relatorio           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oQPrint - objeto TMSPrinter                                    ³±±
±±³          ³ aGantt - Tarefas do Projeto corrente                           ³±±
±±³          ³ nLin - Posicao da linha corrente do relatorio                  ³±±
±±³          ³ nCol - Posicao da coluna corrente do relatorio                 ³±±
±±³          ³ dDateAtu - Data de referencia                                  ³±±
±±³          ³ dTermino - Data de termino do projeto                          ³±±
±±³          ³ dIni-  Data de Inicio                                          ³±±
±±³          ³ dFim - Data de Fim                                             ³±±
±±³          ³ aConfig - Escala do tempo escolhido                            ³±±
±±³          ³ aMeses - Array com o nome do mes resumido.                     ³±±
±±³          ³ oFntArial08 - Objeto TFont, fonte Arial de tamanho 08         ³±±
±±³          ³ oFont10n - Objeto TFont, fonte de tamanho 10 em negrito        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function QdroSemanal( oQPrint ,aGantt ,aPos ,nLin ,nCol ,dDateAtu ,dTermino ,dIni ,dFim ,aMeses ,oFntArial08 ,oFont10n )
Local dX := ctod("  /  /  ")
Local lLoop := .F.
Local nLin2 := 0
Local nLinQdo2 := 0

nLinQdo2 := nLin+150

For dX := dIni to (dFim-1) Step 7
	If (nLinQdo2+((Len(aGantt)+1)*40)) > aPos[3]
		nLin2 := aPos[3]-60
	Else
		nLin2 := (nLinQdo2+((Len(aGantt)+1)*40))
	Endif
	
	oQPrint:Box( nLin     ,nCol ,nLin+150 ,nCol+457 )
	oQPrint:Box( nLinQdo2 ,nCol ,nLin2    ,nCol+457 )
	
	// desenha a linha vertical da data atual
	If dDateAtu>=dX .And. dDateAtu<=(dX+6)
		oQPrint:Box( nLinQdo2+20 ,nCol-2+((dDateAtu-dx)*(22*3))+((Val(Substr(Time(),1,2))/24)*(22*3)) ;
		,nLin2-20    ,nCol  +((dDateAtu-dx)*(22*3))+((Val(Substr(Time(),1,2))/24)*(22*3)) )
	EndIf
	
	// data do inicio da semana, parte superior
	oQPrint:Say( nLin+60 ,nCol+05 ,OemToAnsi( DTOC(dX)+SPACE(12) ) ,oFntArial08 )
	// dias da semana , parte superior
	oQPrint:Say( nLin+100 ,nCol ,OemToAnsi( STR0006 ) ,oFont10n )
	////							oQPrint:Box( 420 ,nCol ,440,nCol+22)
	////							oQPrint:Say( 410 ,nCol ,OemToAnsi( "X1XX2XX3XX4XX5XX6XX7X" ) ,oFont10)
	////							oQPrint:Box( 420 ,nCol+44 ,440,nCol+88)
	
	nCol += 457
	
	// se a proxima coluna ultrapassa o tamanho da folha
	
	If dX > dTermino
		// a proxima coluna vai ser maior
		If ((nCol+457) > aPos[4])
			Exit
		Endif
	Else
		// a coluna vai ser maior
		If (nCol > aPos[4])
			lLoop := .T.
			Exit
		Endif
		
	EndIf
	
Next dX

Return( { lLoop ,dX ,{nLinQdo2 ,nLin2 }, nCol } )


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QdroMensal  ³ Autor ³ Reynaldo T. Miyashita   ³ Data ³ 21/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta os quadros de separacao por Mes no relatorio              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oQPrint - objeto TMSPrinter                                    ³±±
±±³          ³ aGantt - Tarefas do Projeto corrente                           ³±±
±±³          ³ nLin - Posicao da linha corrente do relatorio                  ³±±
±±³          ³ nCol - Posicao da coluna corrente do relatorio                 ³±±
±±³          ³ dDateAtu - Data de referencia                                  ³±±
±±³          ³ dTermino - Data de termino do projeto                          ³±±
±±³          ³ dIni-  Data de Inicio                                          ³±±
±±³          ³ dFim - Data de Fim                                             ³±±
±±³          ³ aConfig - Escala do tempo escolhido                            ³±±
±±³          ³ aMeses - Array com o nome do mes resumido.                     ³±±
±±³          ³ oFntArial10 - Objeto TFont, fonte Arial de tamanho 10         ³±±
±±³          ³ oFont10n - Objeto TFont, fonte de tamanho 10                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function QdroMensal( oQPrint ,aGantt ,aPos ,nLin ,nCol ,dDateAtu ,dTermino ,dIni ,dFim ,aMeses ,oFntArial08 ,oFont10n )
Local nYear := 0
Local nMonthIni := 0
Local nMonthEnd := 0
Local nDias := 0
Local nMes := 0
Local dAuxIni := ctod( "  /  /  " )
Local lContinua := .F.
Local nLin2 := 0
Local nLinQdo2 := 0

nLinQdo2 := nLin+150

dIni	:= CTOD("01/"+StrZero(MONTH(dIni),2,0)+"/"+StrZero(YEAR(dIni),4,0))
nYear	:= YEAR(dIni)
nMonthIni := MONTH(dIni)
nMonthEnd := ((dFim-dIni)/30)+nMonthIni
For nMes := nMonthIni to nMonthEnd
	nDias 	:= DAY(LastDay(CTOD("01/"+StrZero(nMes,2,0)+"/"+StrZero(nYear,4,0))))
	If (nLinQdo2+((Len(aGantt)+1)*40)) > aPos[3]
		nLin2 := aPos[3]-60
	Else
		nLin2 := (nLinQdo2+((Len(aGantt)+1)*40))
	Endif
	//
	oQPrint:Box( nLin     ,nCol ,nLin+150 ,nCol+1+(22*nDias) )
	oQPrint:Box( nLinQdo2 ,nCol ,nLin2    ,nCol+1+(22*nDias) )
	
	If nMes==Month(dDateAtu)
		oQPrint:Box( nLinQdo2+20  ,nCol-2+((dDateAtu-CTOD("01/"+StrZero(nMes,2,0)+"/"+StrZero(nYear,4,0)))*22)+(Val(Substr(Time(),1,2))/720) ;
		,nLin2 -20    ,nCol  +((dDateAtu-CTOD("01/"+StrZero(nMes,2,0)+"/"+StrZero(nYear,4,0)))*22)+(Val(Substr(Time(),1,2))/720) )
		
	EndIf
	// data do inicio da semana, parte superior
	oQPrint:Say( nLin+60 ,nCol+05 ,OemToAnsi(aMeses[nMonthIni]+"/"+STRZERO(nYear,4,0) ) ,oFntArial08 )
	// dias da semana , parte superior
	oQPrint:Say( nLin+100 ,nCol ,OemToAnsi( STR0007 ) ,oFont10n ) //"    5        15        25"
	//oQPrint:Box( 420 ,nCol ,440,nCol+22)
	//oQPrint:Say( 410 ,nCol ,OemToAnsi( "XXXX1XXXXXXXXX2XXXXXXXXX3XXXX4HHHHH" ) ,oFont10)
	//oQPrint:Box( 420 ,nCol+44 ,440,nCol+88)
	
	dAuxIni := CTOD("01/"+StrZero(nMonthIni,2,0)+"/"+StrZero(nYear,4,0))
	
	nCol += (nDias*22)+1
	
	If dAuxIni > dTermino
		// a proxima coluna vai ser maior
		If ((nCol+(nDias*22)+1) > aPos[4])
			lContinua := .F.
			Exit
		Endif
	Else
		// a coluna vai ser maior
		If (nCol > aPos[4])
			lContinua := .T.
			Exit
		Endif
		
	EndIf
	
	nMonthIni++
	If nMonthIni > 12
		nYear++
		nMonthIni := 1
	EndIf
	
Next nMes

Return( { lContinua ,dAuxIni ,{nLinQdo2 ,nLin2 }, nCol } )


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QdroMes30   ³ Autor ³ Reynaldo T. Miyashita   ³ Data ³ 21/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta os quadros de separacao por Mes numa visao de 30% no      ³±±
±±³          ³relatorio.                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oQPrint - objeto TMSPrinter                                    ³±±
±±³          ³ aGantt - Tarefas do Projeto corrente                           ³±±
±±³          ³ nLin - Posicao da linha corrente do relatorio                  ³±±
±±³          ³ nCol - Posicao da coluna corrente do relatorio                 ³±±
±±³          ³ dDateAtu - Data de referencia                                  ³±±
±±³          ³ dTermino - Data de termino do projeto                          ³±±
±±³          ³ dIni-  Data de Inicio                                          ³±±
±±³          ³ dFim - Data de Fim                                             ³±±
±±³          ³ aConfig - Escala do tempo escolhido                            ³±±
±±³          ³ aMeses - Array com o nome do mes resumido.                     ³±±
±±³          ³ oFntArial08 - Objeto TFont, fonte Arial de tamanho 08         ³±±
±±³          ³ oFont10n - Objeto TFont, fonte de tamanho 10                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function QdroMes30( oQPrint ,aGantt ,aPos ,nLin ,nCol ,dDateAtu ,dTermino ,dIni ,dFim ,aMeses ,oFntArial08 ,oFont10n )
Local nYear := 0
Local nMonthIni := 0
Local nMonthEnd := 0
Local nDias := 0
Local nMes := 0
Local dAuxIni := ctod( "  /  /  " )
Local lLoop := .F.
Local nLin2 := 0
Local nLinQdo2 := 0

nLinQdo2 := nLin+150

dIni	:= CTOD("01/"+StrZero(MONTH(dIni),2,0)+"/"+StrZero(YEAR(dIni),4,0))
nYear	:= YEAR(dIni)
nMonthIni := MONTH(dIni)
nMonthEnd := ((dFim-dIni)/30)+nMonthIni
For nMes := nMonthIni to nMonthEnd
	nDias 	:= DAY(LastDay(CTOD("01/"+StrZero(nMes,2,0)+"/"+StrZero(nYear,4,0))))
	If (nLinQdo2+((Len(aGantt)+1)*40)) > aPos[3]
		nLin2 := aPos[3]-60
	Else
		nLin2 := (nLinQdo2+((Len(aGantt)+1)*40))
	Endif
	oQPrint:Box( nLin     ,nCol ,nLin+150 ,nCol+((nDias+1)*7.3) )
	oQPrint:Box( nLinQdo2 ,nCol ,nLin2    ,nCol+((nDias+1)*7.3) )
	
	If nMes==Month(dDateAtu)
		// database
		oQPrint:Box( nLinQdo2+20 ,nCol-2+((dDateAtu-CTOD("01/"+StrZero(nMonthIni,2,0)+"/"+StrZero(nYear,4,0)))*7.3)+((Val(Substr(Time(),1,2))/720) *7.3) ;
		,nLin2-20 ,nCol + ((dDateAtu-CTOD("01/"+StrZero(nMonthIni,2,0)+"/"+StrZero(nYear,4,0)))*7.3)+((Val(Substr(Time(),1,2))/720) *7.3) )
	EndIf
	
	// data do inicio do mes, parte superior
	oQPrint:Say( nLin+60 ,nCol+05 ,OemToAnsi( aMeses[nMonthIni]+"/"+STRZERO(nYear,4,0) ) ,oFntArial08 )
	// dias do mes , parte superior
	oQPrint:Say( nLin+100 ,nCol ,OemToAnsi( "    15 " ) ,oFont10n )
	//oQPrint:Box( 420 ,nCol ,440,nCol+((nDias+1)*7.3))
	//oQPrint:Say( 410 ,nCol ,OemToAnsi( "XXXXX1X" ) ,oFont10)
	//oQPrint:Box( 420 ,nCol+44 ,440,nCol+((nDias+1)*7.3))
	nCol += ((nDias+1)*7.3)
	
	//
	dAuxIni := CTOD("01/"+StrZero(nMonthIni,2,0)+"/"+StrZero(nYear,4,0))
	
	If dAuxIni > dTermino
		// a proxima coluna vai ser maior
		If ((nCol+((nDias+1)*7.3)) > aPos[4])
			Exit
		Endif
	Else
		// a coluna vai ser maior
		If nCol > aPos[4]
			lLoop := .T.
			Exit
		EndIf
		
	EndIf
	
	nMonthIni++
	If nMonthIni > 12
		nYear++
		nMonthIni := 1
	EndIf
	
Next nMes

Return( {lLoop ,dAuxIni ,{nLinQdo2 ,nLin2 }, nCol } )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QdroBimestral³ Autor ³ Reynaldo T. Miyashita   ³ Data ³ 21/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta os quadros de separacao por Bimestre no relatorio.         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oQPrint - objeto TMSPrinter                                     ³±±
±±³          ³ aGantt - Tarefas do Projeto corrente                            ³±±
±±³          ³ nLin - Posicao da linha corrente do relatorio                   ³±±
±±³          ³ nCol - Posicao da coluna corrente do relatorio                  ³±±
±±³          ³ dDateAtu - Data de referencia                                   ³±±
±±³          ³ dTermino - Data de termino do projeto                           ³±±
±±³          ³ dIni-  Data de Inicio                                           ³±±
±±³          ³ dFim - Data de Fim                                              ³±±
±±³          ³ aConfig - Escala do tempo escolhido                             ³±±
±±³          ³ aMeses - Array com o nome do mes resumido.                      ³±±
±±³          ³ oFntArial08 - Objeto TFont, fonte Arial de tamanho 08          ³±±
±±³          ³ oFont10n - Objeto TFont, fonte de tamanho 10                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    	   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function QdroBimestral( oQPrint ,aGantt ,aPos ,nLin ,nCol ,dDateAtu ,dTermino ,dIni ,dFim ,aMeses ,oFntArial08 ,oFont10n )
Local nYear := 0
Local nMonthIni := 0
Local nMonthEnd := 0
Local nDias := 0
Local nMes := 0
Local dAuxIni := ctod( "  /  /  " )
Local lContinua := .F.
Local nLin2 := 0
Local nLinQdo2 :=0

nLinQdo2 := nLin +150

dIni	:= CTOD("01/"+StrZero(MONTH(dIni),2,0)+"/"+StrZero(YEAR(dIni),4,0))
nYear	:= YEAR(dIni)
nMonthIni := MONTH(dIni)
nMonthEnd := ((dFim-dIni)/30)+nMonthIni
For nMes := nMonthIni to nMonthEnd Step 2
	nDias 	:= DAY(LastDay(CTOD("01/"+StrZero(nMes,2,0)+"/"+StrZero(nYear,4,0))))+DAY(LastDay(CTOD("01/"+StrZero(nMes+1,2,0)+"/"+;
			StrZero(If(nMes+1>12,nYear+1,nYear),4,0))))
	If (nLinQdo2+((Len(aGantt)+1)*40)) > aPos[3]
		nLin2 := aPos[3]-60
	Else
		nLin2 := (nLinQdo2+((Len(aGantt)+1)*40))
	Endif
	oQPrint:Box( nLin     ,nCol ,nLin+150 ,nCol+((nDias/2)*7.3)+1 )
	oQPrint:Box( nLinQdo2 ,nCol ,nLin2    ,nCol+((nDias/2)*7.3)+1 )
	
	If nMes==Month(dDateAtu)
		// database
		oQPrint:Box( nLinQdo2+20 ,nCol-2+((dDateAtu-CTOD("01/"+StrZero(nMonthIni,2,0)+"/"+StrZero(nYear,4,0)))*7.3)+;
		((Val(Substr(Time(),1,2))/720) *7.3) ,nLin2-20 ,nCol + ((dDateAtu-CTOD("01/"+StrZero(nMonthIni,2,0)+"/"+;
		StrZero(nYear,4,0)))*7.3)+((Val(Substr(Time(),1,2))/720) *7.3) )
	EndIf
	// mes e ano
	oQPrint:Say( nLin+60 ,nCol+05 ,OemToAnsi( aMeses[nMonthIni]+"/"+STRZERO(nYear,4,0) ) ,oFntArial08 )
	nCol += 1+((nDias/2)*7.3)
	
	//
	dAuxIni := CTOD("01/"+StrZero(nMonthIni,2,0)+"/"+StrZero(nYear,4,0))
	
	If dAuxIni > dTermino
		// a proxima coluna vai ser maior
		If ((nCol+((nDias+1)*7.3)) > aPos[4])
			Exit
		Endif
	Else
		// a coluna vai ser maior
		If nCol > aPos[4]
			lContinua := .T.
			Exit
		EndIf
		
	EndIf
	
	nMonthIni++
	nMonthIni++
	If nMonthIni > 12
		nYear++
		nMonthIni := 1
	EndIf
	
Next nMes

Return( {lContinua ,dAuxIni ,{nLinQdo2 ,nLin2 }, nCol} )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ColDescr     ³ Autor ³ Reynaldo T. Miyashita   ³ Data ³ 21/10/03      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta a primeira coluna que tem das informacoes sobre as tarefas      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oQPrint - objeto TMSPrinter                                          ³±±
±±³          ³ aGantt - Tarefas do Projeto corrente                                 ³±±
±±³          ³ aCampos - Informacoes sobre as tarefas, que serao impressas          ³±±
±±³          ³ aConfig - Escala de tempo escolhido                                  ³±±
±±³          ³ nLin - Posicao da linha corrente do relatorio                        ³±±
±±³          ³ nColIni - Posicao da coluna corrente do relatorio                    ³±±
±±³          ³ aPos - Tamanho da pagina                                             ³±±
±±³          ³ oFontArial08 - Objeto TFont, fonte Arial de tamanho 08 negrito       ³±±
±±³          ³ oFontArial10n - Objeto TFont, fonte Arial de tamanho 10 negrito      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    	   	    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ColDescr( oQPrint ,aGantt ,aCampos, aConfig ,nLin ,nColIni ,aPos ,oFntArial08 ,oFntArial10 ,lProject)
Local aLegenda := {}
Local nX := 0
Local nLin2 := 0
DEFAULT lProject := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calcula a coluna inicial do Gantt e cria a legenda      ³
//³ das tarefas.                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

For nX := 1 to Len(aCampos)
	If aConfig[nX+1]
		aadd( aLegenda ,{nLin+110 ,nColIni ,STRTRAN(aCampos[nX][1],"'",'"') ,oFntArial08} )
		nColIni += aCampos[nX][2]*4.7
		
	EndIf
Next

// tamanho maximo da coluna de descricoes das tarefas
nColIni := MAX(nColIni ,900)

If ((nLin+150)+((Len(aGantt)+1)*40)) > aPos[3]
	nLin2 := aPos[3]-60
Else
	nLin2 := ((nLin+150)+((Len(aGantt)+1)*40))
Endif

// box do codigo,data de inicio e fim do projeto
oQPrint:Box( nLin       ,20 ,nLin+150 ,nColIni+1 ) //box do projeto
oQPrint:Box( (nLin+150) ,20 ,nLin2    ,nColIni+1 ) // box do grafico

// se houver mais de um projeto no array agantt, não imprime o codigo do projeto

// Codigo do projeto, data de inicio e data fim
If lProject
	oQPrint:Say( nLin+20 ,30  ,OemToAnsi(AF8->AF8_PROJET )               ,oFntArial10 )
EndIf
oQPrint:Say( nLin+60 ,30  ,OemToAnsi(STR0008+DTOC(AF8->AF8_START ) ) ,oFntArial10 )
oQPrint:Say( nLin+60 ,480 ,OemToAnsi(STR0009+DTOC(AF8->AF8_FINISH) ) ,oFntArial10 )

// legenda das tarefas
For nX := 1 to Len(aLegenda)
	oQPrint:Say( aLegenda[nX][1] ,aLegenda[nX][2] ,aLegenda[nX][3] ,aLegenda[nX][4] )
Next nX

Return( NIL )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    | preDecessora ³ Autor ³ Reynaldo T. Miyashita  ³ Data ³ 19-11-2003 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ encontra a predecessora da tarefa e faz o relacionamento          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³	nTipo - Escala (1-Diario,2-semanal,etc..                          ³±±
±±³          ³  nPos - posicao da tarefa corrente no array aGantt                ³±±
±±³          ³  nXIni - posicao da primeira tarefa a ser impressa na folha       ³±±
±±³          ³          corrente                                                 ³±±
±±³          ³  nXLastPage - posicao da ultima tarefa impressa na folha antes    ³±±
±±³          ³               da quebra de pagina corrente                        ³±±
±±³          ³  aGantt - array que contem as informacoes das tarefas             ³±±
±±³          ³  aDep -  array com os predecessores das tarefas                   ³±±
±±³          ³  aTarefa -  Dados da tarefa corrente                              ³±±
±±³          ³  nLin - Posicao da linha corrente do relatorio                    ³±±
±±³          ³  nCol - Posicao da coluna corrente do relatorio                   ³±±
±±³          ³  dIni - Data de inicio corrente do relatorio                      ³±±
±±³          ³  dFim - Data de fim corrente do relatorio                         ³±±
±±³          ³  aPos - Area de impressao da folha                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function preDecessora( nTipo ,nPos ,nXIni ,nXLastPage ,aGantt ,aDep ,aTarefa ,nLin ,nCol ,dIni ,dFim ,aPos)

Local nPos1   := 0
Local nX      := 0
Local nY      := 0
Local nZ      := 0
Local nCol1   := 0
Local nCol2   := 0
Local nLinPre := 0
Local aTskInt := {}

// verifica se a tarefa tem predecessora
nPos1 := aScan( aDep,{|aTar| aTar[1] == aGantt[nPos ,01 ,01] })
If nPos1 > 0 
	// varre todas as tarefas predecessoras referentes a Tarefa
	For nZ := 1 to Len(aDep[nPos1 ,02])
	
		// Verifica se existe a tarefa predecessora.
		//
		// Se conter mais q 8 elementos, existe a identificação se a tarefa é prevista ou realizada. 
		// Senão é o formato antigo e será mantido por segurança
		If Len(aGantt[nPos ,01]) >8
			nX := aScan( aGantt ,{|aTar|aTar[01 ,01]+aTar[01 ,09] == aDep[nPos1 ,02 ,nZ ,01]+aGantt[nPos ,01 ,09] })
		Else
			nX := aScan( aGantt ,{|aTar|aTar[01 ,01] == aDep[nPos1 ,02 ,nZ ,01] })
		EndIf
	
		If nX > 0
		    //
		    // gera referencia para o array com os intervalos da tarefa
		    //
			aTskInt := aGantt[nX ,02]
		
			// dados da tarefa predecessora
			For nY := 1 to Len(aTskInt)
				Do Case
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Cria o Gantt na escala 'horaria de 1 em 1 hora'         ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					Case nTipo == -1
						If aTskInt[nY ,01] >= dIni
							nCol1 := nCol+(((aTskInt[nY ,01]-dIni)*24)*88) // calcula o dia em horas
							nCol1 += Val(Substr(aTskInt[nY ,02],1,2))*88   // calcula as horas
							nCol2 += Val(Substr(aTskInt[nY ,02],4,2))*1.47 // calcula os minutos
						Else
							nCol1 := nCol
						EndIf
						
						If aTskInt[nY ,03]<= dFim
							nCol2 := nCol+(((aTskInt[nY ,03]-dIni)*24)*88) // calcula o dia em horas
							nCol2 += Val(Substr(aTskInt[nY ,04],1,2))*88   // calcula as horas
							nCol2 += Val(Substr(aTskInt[nY ,04],4,2))*1.47 // calcula os minutos
						Else
							nCol2 := nCol+(((dFim-dIni)*24)*88)+aPos[4]  // calcula o dia em horas
						EndIf
						If nCol2 < nCol
							nCol2 := nCol
						EndIf
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Cria o Gantt na escala 'horaria de 2 em 2 hora'         ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					Case nTipo == 0
						If aTskInt[nY ,01] >= dIni
							nCol1 := nCol+(((aTskInt[nY ,01]-dIni)*24)*44) // calcula o dia em horas
							nCol1 += Val(Substr(aTskInt[nY ,02],1,2))*44   // calcula as horas
							nCol2 += Val(Substr(aTskInt[nY ,02],4,2))*0.73 // calcula os minutos
						Else
							nCol1 := nCol
						EndIf
						
						If aTskInt[nY ,03]<= dFim
							nCol2 := nCol+(((aTskInt[nY ,03]-dIni)*24)*44) // calcula o dia em horas
							nCol2 += Val(Substr(aTskInt[nY ,04],1,2))*44   // calcula as horas
							nCol2 += Val(Substr(aTskInt[nY ,04],4,2))*0.73 // calcula os minutos
						Else
							nCol2 := nCol+(((dFim-dIni)*24)*44)+aPos[4]  // calcula o dia em horas
						EndIf
						If nCol2 < nCol
							nCol2 := nCol
						EndIf
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Cria o Gantt na escala 'diario'                         ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					Case nTipo == 1
						If aTskInt[nY ,01] >= dIni
							nCol1 := nCol + ((aTskInt[nY ,01]-dIni)*(22*24))
							nCol1 += Val(Substr(aTskInt[nY ,02],1,2))*22
							
						Else
							nCol1 := nCol
							
						EndIf
						If aTskInt[nY ,03]<= dFim
							nCol2 := nCol + ((aTskInt[nY ,03]-dIni)*(22*24))
							nCol2 += Val(Substr(aTskInt[nY ,04],1,2))*22
							
						Else
							nCol2 := nCol + ((dFim-dIni)*(22*24))+aPos[4]
							
						EndIf
						If nCol2 < nCol
							nCol2 := nCol
						EndIf
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Cria o Gantt na escala 'semanal'                        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					Case nTipo == 2
						If aTskInt[nY ,01] >= dIni
							nCol1 := nCol + (aTskInt[nY ,01]-dIni)*(22*3)
							nCol1 += (Val(Substr(aTskInt[nY ,02],1,2))/24)*(22*3)
						Else
							nCol1 := nCol
						EndIf
						
						If aTskInt[nY ,03] <= dFim
							nCol2 := nCol + (Min(aTskInt[nY ,03],dFim)-dIni)*(22*3)
							nCol2 += (Val(Substr(aTskInt[nY ,04],1,2))/24)*(22*3)
							
						Else
							nCol2 := nCol + ((dFim-dIni)*(22*3))+aPos[4]
							
						EndIf
						If nCol2 < nCol
							nCol2 := nCol
						EndIf
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Cria o Gantt na escala 'mensal' 100%                    ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					Case nTipo == 3
						If aTskInt[nY ,01] >= dIni
							nCol1 := nCol + ((aTskInt[nY ,01]-dIni)*22)
							nCol1 += (Val(Substr(aTskInt[nY ,02],1,2))/720)*22
						Else
							nCol1 := nCol
						EndIf
						If aTskInt[nY ,03] <= dFim
							nCol2 := nCol + ((aTskInt[nY ,03]-dIni)*22)
							nCol2 += (Val(Substr(aTskInt[nY ,04],1,2))/720)*22
							
						Else
							nCol2 := nCol + ((dFim-dIni)*22)+aPos[4]
							
						EndIf
						If nCol2 < nCol
							nCol2 := nCol
						EndIf
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Cria o Gantt na escala 'mensal' 30%                     ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					Case nTipo == 4
						If aTskInt[nY ,01] >= dIni
							nCol1 := nCol + ((aTskInt[nY ,01]-dIni)*7.3 )
							nCol1 += (Val(Substr(aTskInt[nY ,02],1,2))/720) *7.3
						Else
							nCol1 := nCol
							
						EndIf
						If aTskInt[nY ,03] <= dFim
							nCol2 := nCol + ((aTskInt[nY ,03]-dIni)*7.3 )
							nCol2 += (Val(Substr(aTskInt[nY ,04],1,2))/720) *7.3
							
						Else
							nCol2 := nCol + ((dFim-dIni)*7.3 )+aPos[4]
							
						EndIf
						If nCol2 < nCol
							nCol2 := nCol
						EndIf
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Cria o Gantt na escala bimestral                        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					Case nTipo == 5
						If aTskInt[nY ,01] >= dIni
							nCol1 := nCol +(((aTskInt[nY ,01]-dIni)/2)*7.3)
							nCol1 += ((Val(Substr(aTskInt[nY ,02],1,2))/720)/2)*7.3
						Else
							nCol1 := nCol
						EndIf
						If aTskInt[nY ,03] <= dFim
							nCol2 := nCol +(((aTskInt[nY ,03]-dIni)/2)*7.3)
							nCol2 += (((Val(Substr(aTskInt[nY ,04],1,2))/720)/2)*7.3)
							
						Else
							nCol2 := nCol +(((dFim-dIni)/2)*7.3)+aPos[4]
							
						EndIf
						If nCol2 < nCol
							nCol2 := nCol
						EndIf
				EndCase
				
				If nX > nXIni
					// se NAO houve quebra de pagina
					If nXLastPage > 0
						// pula "1 linha"
						nLinPre :=  aPos[3] - ( 40*((nXLastPage +1)- nX ))
					Else
						// se tarefa corrente "esta dentro" da pagina
						if nPos > nXIni
							nLinPre :=  nLin - ( 40*( nPos - nX ) )
						Else
							nLinPre :=  nLin - ( 40*( nXIni - nX ) )
						Endif
					EndIf
				Else
					// pula "1 linha"
					nLinPre := aPos[1]
					
				Endif
				
				//imprime a linha de relacionamento entre tarefas
				RelacTarefa( aDep[nPos1 ,02 ,nZ ,02] ,{aDep[nPos1 ,02 ,nZ ,01] ,nLinPre ,nCol1 ,nCol2 } ,aTarefa ,aPos )
			Next nZ
		EndIf
	Next nY
Endif

Return( NIL )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    | RelacTarefa ³ Autor ³ Reynaldo T. Miyashita  ³ Data ³ 19-11-2003 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime a linha de relacionamento entre as tarefas               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cTipo - Tipo do relacionamento("1"-fim no inicio,"2"-inicio no   ³±±
±±³          ³         inicio, etc...)                                          ³±±
±±³          ³ aPosTar1 -  array com a tarefa predecessora                      ³±±
±±³          ³ aPosTar2 -  array com a tarefa corrente                          ³±±
±±³          ³ aTamanho - Area de impressao da folha                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RelacTarefa( cTipo ,aPosTar1 ,aPosTar2 ,aTamanho )
Local nMinLi := 0
Local nMaxLi := 0
Local nMinCol := 0
Local nMaxCol := 0
Local nLinA := 0
Local nLinB := 0
Local lCimaBaixo := .T.

// Posiciona a linha da Tarefa A
If aPosTar1[2] > aTamanho[1]
	nLinA := aPosTar1[2]+12.5
	If nLinA > aTamanho[3]
		nLinA := aTamanho[3]
	EndIf
	
Else
	nLinA := aTamanho[1]
Endif

// Posiciona a linha da Tarefa B
If aPosTar2[2] > aTamanho[1]
	nLinB := aPosTar2[2]+12.5
	If nLinB > aTamanho[3]
		nLinB := aTamanho[3]
	EndIf
Else
	nLinB := aTamanho[1]
Endif

// se as linhas da tarefa A for igual a B, nao processa.
If nLinA <> nLinB
	
	If aPosTar1[3] < aTamanho[2]
		aPosTar1[3] := -100
	Endif
	
	If aPosTar2[3] < aTamanho[2]
		aPosTar2[3] := -100
	Endif
	
	If aPosTar1[4] < aTamanho[2]
		aPosTar1[4] := -100
	Endif
	
	If aPosTar2[4] < aTamanho[2]
		aPosTar1[4] := -100
	Endif
	
	If nLinA < nLinB
		nMinLi := nLinA
		nMaxLi := nLinB
		lCimaBaixo := .T.
	Else
		nMinLi := nLinB
		nMaxLi := nLinA
		lCimaBaixo := .F.
	Endif
	
	If aPosTar1[3] < aPosTar2[3]
		nMinCol := aPosTar1[3]+1
	Else
		nMinCol := aPosTar2[3]+1
	Endif
	
	If aPosTar1[4] > aPosTar2[4]
		nMaxCol := aPosTar1[4]
	Else
		nMaxCol := aPosTar2[4]
	Endif
	
	Do Case
		// fim no inicio
		Case cTipo == "1"
			oQPrint:Line( nLinA ,aPosTar1[4] ,nLinA ,aPosTar2[3]+10 )
			
			If lCimaBaixo
				If nMaxLi-22.5 < aTamanho[1]
					nMinLi = aTamanho[1]-22.5
				EndIf
				oQPrint:Line( nMinLi ,aPosTar2[3]+10 ,nMaxLi-22.5 ,aPosTar2[3]+10 )
				If (nMaxLi > aTamanho[1]) .AND. (nMaxLi < aTamanho[3])
					// o triangulo para baixo
					TriagLine( "B" ,nMaxLi-12.5 ,aPosTar2[3]+10 )
				EndIf
				
			Else
				oQPrint:Line( iIf(nMinLi+22.5 >= aTamanho[3] ,aTamanho[3] ,nMinLi+22.5) ,aPosTar2[3]+10 ,nMaxLi ,aPosTar2[3]+10 )
				If (nMinLi > aTamanho[1]) .AND. (nMinLi < aTamanho[3])
					// o triangulo para cima
					TriagLine( "C" ,nMinLi+22.5 ,aPosTar2[3]+10 )
				EndIf
			Endif
			
			// inicio no inicio
		Case cTipo == "2"
			nColA := nMinCol-20
			If nColA < aTamanho[2]
				nColA := aTamanho[2]
			EndIf
			oQPrint:Line( nLinA  ,nColA ,nLinA  ,aPosTar1[3] )
			oQPrint:Line( nMinLi ,nColA ,nMaxLi ,nColA  )
			oQPrint:Line( nLinB  ,nColA ,nLinB  ,aPosTar2[3]-10 )
			
			If nLinB >= aTamanho[1]+10 .AND. nLinB <= aTamanho[3]-10
				// o triangulo para direita
				TriagLine( "D" ,nLinB ,aPosTar2[3] )
			Endif
			
			// fim no fim
		Case cTipo == "3"
			oQPrint:Line( nLinA  ,aPosTar1[4]    ,nLinA  ,nMaxCol+20 )
			oQPrint:Line( nMinLi ,nMaxCol+20     ,nMaxLi ,nMaxCol+20 )
			oQPrint:Line( nLinB  ,aPosTar2[4]+10 ,nLinB  ,nMaxCol+20 )
			If nLinB >= aTamanho[1]+10 .AND. nLinB <= aTamanho[3]-10
				// o triangulo para esquerda
				TriagLine( "E" ,nLinB ,aPosTar2[4] )
			Endif
			
			// inicio no fim
		Case cTipo == "4"
			nColA := aPosTar1[3]-20
			If nColA > aTamanho[2]
				nColB := aPosTar1[3]
				If nColB < aTamanho[2]
					nColB := aTamanho[2]
				EndIf
				oQPrint:Line( nLinA  ,nColA ,nLinA ,nColB ) // desenha a linha vertical da tarefa predecessora
			Else
				nColA := aTamanho[2]
			EndIf
			
			nColB := aPosTar2[4]+20
			If nColB > aTamanho[4]
				nColB := aTamanho[4]
			EndIf
			oQPrint:Line( nMinLi+((nMaxLi-nMinLi)/2) ,nColA ,nMinLi+((nMaxLi-nMinLi)/2) ,nColB ) // desenha a linha horizontal de ligacao da tarefa predecessora com a tarefa
			
			nColA := aPosTar2[4]+10
			If nColA < aTamanho[4]
				nColB := aPosTar2[4]+20
				If nColB > aTamanho[4]
					nColB := aTamanho[4]
				EndIf
				oQPrint:Line( nLinB ,nColA ,nLinB ,nColB )  // desenha a linha vertical da tarefa
			EndIf
			
			If nLinB >= aTamanho[1]+10 .AND. nLinB <= aTamanho[3]-10
				// o triangulo para esquerda
				TriagLine( "E" ,nLinB ,aPosTar2[4] )
			Endif
			
			If lCimaBaixo
				nColA := aPosTar1[3]-20
				If nColA < aTamanho[2]
					nColA := aTamanho[2]
				EndIf
				nColB := aPosTar2[4]+20
				If nColB > aTamanho[4]
					nColB := aTamanho[2]
				EndIf
				
				oQPrint:Line( nMinLi                     ,nColA ,nMinLi+((nMaxLi-nMinLi)/2) ,nColA )
				oQPrint:Line( nMinLi+((nMaxLi-nMinLi)/2) ,nColB ,nMaxLi                     ,nColB )
			Else
				nColA := aPosTar2[4]+20
				If nColA < aTamanho[2]
					nColA := aTamanho[2]
				EndIf
				nColB := aPosTar1[3]-20
				If nColB > aTamanho[4]
					nColB := aTamanho[2]
				EndIf
				oQPrint:Line( nMinLi                     ,nColA ,nMinLi+((nMaxLi-nMinLi)/2) ,nColA )
				oQPrint:Line( nMinLi+((nMaxLi-nMinLi)/2) ,nColB ,nMaxLi                     ,nColB )
			EndIF
			
	EndCase
	
EndIf

Return( NIL )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    | TriagLine ³ Autor ³ Reynaldo T. Miyashita  ³ Data ³ 19-11-2003 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ desenha um triangulo, base 20 pixel e altura 5 pixel           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cLado - Lado q aponta o triangulo("C"-Cima,"B"-Baixo,          ³±±
±±³          ³         "E"-Esquerdo, "D"-Direito                              ³±±
±±³          ³         inicio, etc...)                                        ³±±
±±³          ³ nLin - Linha inicial, base do triangulo                        ³±±
±±³          ³ nCol - Coluna inicial, base do triangulo                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TriagLine( cLado ,nLin ,nCi )

cLado := upper(cLado)

Do Case
	// para cima
	Case cLado = "C"
		oQPrint:Line( nLin-10 ,nCi   ,nLin ,nCi-5 )
		oQPrint:Line( nLin-10 ,nCi   ,nLin ,nCi+5 )
		oQPrint:Line( nLin    ,nCi-5 ,nLin ,nCi+5 )
		// para baixo
	Case cLado = "B"
		oQPrint:Line( nLin-10 ,nCi-5 ,nLin-10 ,nCi+5 )
		oQPrint:Line( nLin-10 ,nCi-5 ,nLin    ,nCi   )
		oQPrint:Line( nLin-10 ,nCi+5 ,nLin    ,nCi   )
		// para direita
	Case cLado = "D"
		oQPrint:Line( nLin-5 ,nCi-10 ,nLin   ,nCi    )
		oQPrint:Line( nLin+5 ,nCi-10 ,nLin   ,nCi    )
		oQPrint:Line( nLin-5 ,nCi-10 ,nLin+5 ,nCi-10 )
		// para esquerda
	Case cLado = "E"
		oQPrint:Line( nLin-5 ,nCi+10 ,nLin   ,nCi    )
		oQPrint:Line( nLin+5 ,nCi+10 ,nLin   ,nCi    )
		oQPrint:Line( nLin-5 ,nCi+10 ,nLin+5 ,nCi+10 )
		
EndCase

Return( NIL )


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³TruncTexto ³ Autor ³ Cristiano Denardi       ³ Data ³ 04.04.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Trunca texto para a impressao do relatorio, fazendo com que ele³±±
±±³          ³respeite o tamanho dos quadros do Gantt.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function TruncTexto( cTexto ,nTamMax, nFont )
Local nTamTexto	:= 0
Local nCntTxt 		:= 1
Default nFont 		:= 4
/////////////////////////////////
// nFonte para usar no PcoPrtSize
// oFntArial08	-> Nao Possui fonte exata
// oFntArial10	-> 4
// oFont10n		-> 5

For nCntTxt := 1 To Len(cTexto)
	// tamanho do texto convertido conforme fonte usada
	nTamTexto += U_FontSize( SubStr(cTexto,nCntTxt,1), nFont )
	
	If nTamTexto > nTamMax
		Exit
	EndIf
	
Next nCntTxt

cNewTexto := Left( cTexto ,nCntTxt )

Return( cNewTexto )


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FontSize   ³ Autor ³ Cristiano Denardi       ³ Data ³ 04.04.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Copia da funcao PcoPrtSize() em PcoXimp.					        ³±±
±±³          ³Funcao original de Edson Maricate                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FontSize(cSay,nFonte)
Local nSize := 0
Local nx
Local aSize := {	{14.793,6.25  ,13.793,11.25	},;
{18.241,2.692 ,15.241,13.692	},;
{20    ,11.112,18    ,16		},;
{21.05 ,10.028,19.05 ,17		},;
{31.500,15.384,29.500,27		},;
{41.66 ,20.20 ,38.66 ,36		},;
{14.793,6.25  ,13.793,11.25	},;
{17.241,2.692 ,15.241,13.692	}}

For nx := 1 to Len(cSay)
	If Substr(cSay,nx,1)=="." .Or. Substr(cSay,nx,1)=="," .or.  Substr(UPPER(cSay),nx,1)=="I"
		nSize += aSize[nFonte,2]
	ElseIf Substr(cSay,nx,1)$"abcdefghijklmnopqrstuvxyzw"
		nSize += aSize[nFonte,4]
	ElseIf Substr(UPPER(cSay),nx,1)$"ABCDEFGHIJKLMNOPQRSTUVXWYZ""
		nSize += aSize[nFonte,3]
	Else
		nSize += aSize[nFonte,1]
	EndIf
Next
Return nSize

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ImprDescr ³ Autor ³ Reynaldo Miyashita       ³ Data ³ 17.04.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³imprime a descricao do projeto, edt ou tarefa                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    	 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImprDescr( oQPrint ,nLin ,nCol ,aCampos ,aConfig ,aGantt ,oFntArial08 )
Local Z           := 0
Local cTexto      := ""
Local cPtoFin     := "..."	// Pontos finais
Local nRealEspaco := 0
Local nLeftDescr  := 0
Local nTamTxt     := 0 		// Tamanho para corte do texto
Local nTamImp	  := 28		// Tamanho maximo de impressao do trecho no grafico
Local nSpcFrt     := 0      // Espaco Frontal
Local nSize       := 30

For Z := 1 to Len(aCampos)
	
	cTexto := alltrim(aGantt[z])
	
	If aConfig[z+1]
		If !Empty(CTOD(aGantt[z]))
			//formata data de DD/MM/AAAA para DD/MM/AA
			If Len(aGantt[z]) == 10 
				aGantt[z] := Substr(aGantt[z],1,6)+Substr(aGantt[z],9,2)
			Endif	
		EndIF
		If Z==2
			// se o tamanho da string for menor q 30 deve calcular o novo tamanho.
			nRealEspaco := (( len(rTrim(aGantt[z]))-len(cTexto) )/3)
			nLeftDescr := nRealEspaco + len(cTexto)
			/////////////////////
			// Variaveis de apoio
			nSpcFrt := nRealEspaco*3
			nTamTxt := nTamImp - Len(cPtoFin)
			
			If ( nLeftDescr < nTamImp )
				oQPrint:Say( nLin ,nSize ,OemToAnsi(STRTRAN( aGantt[z] ,"'",'"')) ,oFntArial08)
			Else
				oQPrint:Say( nLin ,nSize ,OemToAnsi(STRTRAN( space(nSpcFrt) + left( cTexto ,(nTamTxt-nSpcFrt) ) + iIf( right(left( cTexto ,(nTamTxt-nSpcFrt) ) ,2);
					 <> space(2) ,"...","" ) ,"'",'"')) ,oFntArial08)
			Endif
		Else
			oQPrint:Say( nLin ,nSize ,OemToAnsi(STRTRAN( aGantt[z],"'",'"')) ,oFntArial08)
		Endif
		nSize += aCampos[z][2]*4.7
	EndIf
Next Z

Return( .T. )
