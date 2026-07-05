/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QDOR300.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QDOR300  ³ Autor ³ Leandro Sabino        ³ Data ³ 14/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Destinatario de Envio de documentos                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR300                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALiZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function QDOR300(lBat)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variavel utiLizada para verificar se o relatorio foi iniciado³
//³ pelo MNU ou pela rotina de documentos.                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lBat:= If(lBat == NIL,.F.,lBat)
Private cPerg	 	:= If(lBat,"","QDR300")
Private aReturn 	:= { STR0003,1,STR0004, 2, 2, 1, "",1 } //"Zebrado"###"Administra‡„o"
Private nLastKey	:= 0
Private INCLUI	 	:= .F.	// Colocada para utiLizar as funcoes
Private wnrel	 	:= "QDOR300"
Private cTitulo		:= OemToAnsi(STR0001) //"Destinatario(s) de Documentos"
Private cDesc1 		:= OemToAnsi(STR0002) //"Este programa ir  imprimir os usuarios que receberao os Documentos"
Private cString		:= "QDH"
Private Tamanho		:= "P"
Private cTamanho	:= "P"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Salva a posicao do Documento  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lBat
	Private cChave:= M->QDH_FILIAL+M->QDH_DOCTO+M->QDH_RV
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.F.)

wnrel  := SetPrint(cString,wnrel,cPerg,ctitulo,cDesc1,'','',.F.,,,Tamanho)
cTitulo:= If(TYPE("NewHead") <> "U",NewHead,cTitulo)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

RptStatus({|lEnd| QDOR300Imp(@lEnd,ctitulo,wnRel,tamanho,lBat)},ctitulo)

Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QDOR300Imp³ Autor ³ Leandro Sabino        | Data ³ 14/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Envia para funcao que faz a impressao do relatorio.        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR300                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QDOR300Imp(lEnd,ctitulo,wnRel,tamanho,lBat)

Local cCabec1   := ""
Local cOldDoc	:= ""
Local cOldDepto := ""
Local cOldDocto := ""
Local cCompara	:= ""
Local cCompara2 := ""
Local cIndex1	:= ""
Local cIndex2	:= ""
Local cFiltro	:= ""
Local cKey		:= ""
Local cFilDep   := xFilial("QAD")
Local cTipPro   := GETMV("MV_QDOTPPR") // Parametro para impressao de somente copias em papel ou nao
Local aRegQDG   := {}
Local aTxtCopia := {	OemToAnsi(STR0009),; // " Eletronicas"
						OemToAnsi(STR0010),; // " Em Papel"
						OemToAnsi(STR0011),; // " Eletronica/Papel"
						OemToAnsi(STR0012)}  // " Nao Recebe"

Private aDriver := ReadDriver()

DbSelectArea("QD2")
DbSetOrder(1)

DbSelectArea("QDG")
DbSetOrder(3)

DbSelectarea("QD1")
DbSetOrder(1)

DbSelectarea("QDH")
DbSetOrder(1)

If !lBat
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria Indice Condicional nos arquivos utiLizados ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cIndex1:= CriaTrab(Nil,.F.)
	cKey   := QDH->(IndexKey())	
	cFiltro:= 'QDH->QDH_FILIAL == "'+xFiLial("QDH")+'".And. '
	cFiltro+= 'QDH->QDH_DOCTO >= "'+mv_par03+'".And. QDH->QDH_DOCTO <= "'+mv_par04+'".And. '
	cFiltro+= 'QDH->QDH_RV >= "'+mv_par05+'".And. QDH->QDH_RV <= "'+mv_par06+'"'
	IndRegua("QDH",cIndex1,cKey,,cFiltro,OemToAnsi(STR0005))	//"Selecionando Registros.."
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Retorna a Posicao do QDH - Documentos  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	QDH->(DbSeek(cChave))
EndIf

cIndex2:= CriaTrab(Nil,.F.)
cKey   := QD1->(IndexKey())
If !lBat
	cFiltro:= 'QD1->QD1_FILIAL == "'+xFiLial("QD1")+'".And. '
	cFiltro+= 'QD1->QD1_DOCTO >= "'+mv_par03+'".And. QD1->QD1_DOCTO <= "'+mv_par04+'".And. '
	cFiltro+= 'QD1->QD1_RV >= "'+mv_par05+'".And. QD1->QD1_RV <= "'+mv_par06+'".And. '
	cFiltro+= 'QD1->QD1_DEPTO >= "'+mv_par07+'".And. QD1->QD1_DEPTO <= "'+mv_par08+'".And. '
	cFiltro+= 'QD1->QD1_TPPEND == "L  " .And. QD1->QD1_SIT <> "I"'
Else
	cFiltro:= 'QD1->QD1_FILIAL == "'+QDH->QDH_FILIAL+'".And. '
	cFiltro+= 'QD1->QD1_DOCTO == "'+QDH->QDH_DOCTO+'".And. '
	cFiltro+= 'QD1->QD1_RV == "'+QDH->QDH_RV+'".And. '
	cFiltro+= 'QD1->QD1_TPPEND == "L  " .And. QD1->QD1_SIT <> "I"'
EndIf

If cTipPro == "S"
	cFiltro+= '.And. QD1->QD1_TPDIST $ "2,3"'
Endif

IndRegua("QD1",cIndex2,cKey,,cFiltro,OemToAnsi(STR0005))	//"Selecionando Registros.."

//          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6  
//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXX  XXXXXXXXXX     XXXXXXXXXXXXXXXX
//RESPONSAVEL                    TIPO     1234567890     COPIA

cCabec1:= OemToAnsi(STR0017)//"RESPONSAVEL                    TIPO                     COPIA"

Li   := 80
m_pag:= 1

SetRegua(If(!lBat,QDH->(LastRec()),QD1->(LastRec()))) // Total de Elementos da Regua

While QDH->(!Eof())
	cCompara:= "QD1->QD1_FILIAL+QD1->QD1_DOCTO+QD1->QD1_RV"	
	If QD1->(DbSeek(QDH->QDH_FILIAL+QDH->QDH_DOCTO+QDH->QDH_RV))
		While QD1->(!Eof()) .And. QDH->QDH_FILIAL+QDH->QDH_DOCTO+QDH->QDH_RV == &(cCompara)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Caso parametrizado, quebra de pagina por documento destino   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
			If mv_par01 == 1 
				If QDH->QDH_DOCTO+QDH->QDH_RV <> cOldDoc
					cOldDoc:= QDH->QDH_DOCTO+QDH->QDH_RV
				   	Li:= 80 
				EndIf
			EndIf
   		
   			If QDH->QDH_DOCTO+QDH->QDH_RV <> cOldDoc
		 		cOldDoc:= QDH->QDH_DOCTO+QDH->QDH_RV
				If Li > 58
					Cabec300(@Li,cTitulo)
				Else
					@ Li,000 PSay Upper(OemToAnsi(STR0013))+AllTrim(QDH->QDH_DOCTO)+"/"+QDH->QDH_RV	
					Li++
					@ Li,000 PSay OemToAnsi(STR0014)+Substr(Alltrim(QDH->QDH_TITULO),1,70) 
					Li++
				EndIf			
			EndIf			
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Caso parametrizado, quebra de pagina por departamento destino³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
			If QD1->QD1_DEPTO <> cOldDepto 
				If !Empty(cOldDepto) .And. mv_par02 == 1
				  	Li:= 80
				Else  
					If Li > 54
						Cabec300(@Li,cTitulo)
					EndIf
					cOldDepto:= QD1->QD1_DEPTO
				EndIf
			EndIf 
			If Li > 58
				Cabec300(@Li,cTitulo)
			EndIf   
			
			If lEnd
				Li++
				@ PROW()+1,001 PSAY OemToAnsi(STR0007) //"CANCELADO PELO OPERADOR"
				Exit
			EndIf
			If !Empty(cFilDep)
				cFilDep:= QD1->QD1_FILMAT
			EndIf
			
			@ Li,000 PSay Upper(OemToAnsi(STR0008))+AllTrim(QD1->QD1_DEPTO)+" - "+QA_NDEPT(QD1->QD1_DEPTO,.T.,cFilDep) //"Departamento: "
			Li++			
			cSeek2   := QD1->QD1_FILIAL+QD1->QD1_DOCTO+QD1->QD1_RV+QD1->QD1_DEPTO
			cCompara2:= "QD1->QD1_FILIAL+QD1->QD1_DOCTO+QD1->QD1_RV+QD1->QD1_DEPTO"
			If QD1->(DbSeek(cSeek2))
				@ Li,000 PSay cCabec1
				Li++
				@ Li,000 PSay __PrtFatLine()
				Li++
				aRegQDG := {}
				While QD1->(!Eof()) .And. cSeek2 == &(cCompara2)

					If QD1->QD1_SIT == "I"
						QD1->(DbSkip())
						Loop
					EndIf

					IncRegua()
					If Li > 58
						Cabec300(@Li,cTitulo)
						If !Empty(cFilDep)
							cFilDep:= QD1->QD1_FILMAT
						EndIf
						@ Li,000 PSay Upper(OemToAnsi(STR0008))+AllTrim(QD1->QD1_DEPTO)+" - "+QA_NDEPT(QD1->QD1_DEPTO,.T.,cFilDep) //"Departamento: "
						Li++
						@ Li,000 PSay cCabec1
						Li++
						@ Li,000 PSay __PrtFatLine()
						Li++
					EndIf
					If lEnd
						Li++
						@ PROW()+1,001 PSAY OemToAnsi(STR0009) //"CANCELADO PELO OPERADOR"
						Exit
					EndIf
					@ Li,000 PSay SubsTr(QA_NUSR(QD1->QD1_FILMAT,QD1->QD1_MAT,.T.),1,23)
					
					If QDG->(DbSeek(QD1->QD1_FILIAL+QD1->QD1_DOCTO+QD1->QD1_RV+QD1->QD1_FILMAT+QD1->QD1_DEPTO+QD1->QD1_MAT))
						While QDG->(!Eof()) .And. QDG->QDG_DOCTO+QDG->QDG_RV+QDG->QDG_FILMAT+QDG->QDG_DEPTO+QDG->QDG_MAT == QD1->QD1_DOCTO+QD1->QD1_RV+QD1->QD1_FILMAT+QD1->QD1_DEPTO+QD1->QD1_MAT
							If aScan(aRegQDG,{ |X| X == QDG->(Recno()) }) == 0 .AND. QDG->QDG_TPRCBT == QD1->QD1_TPDIST
								aAdd(aRegQDG,QDG->(Recno()))
								Exit
							Endif							
							QDG->(DbSkip())
						Enddo						
						@ Li,031 PSay If(QDG->QDG_TIPO == "D",OemToAnsi(STR0015),OemToAnsi(STR0016)) // "Usuario" ### "Pasta"
						@ Li,040 PSay If(QDG->QDG_TIPO == "D",QDG->QDG_MAT,QDG->QDG_CODMAN)					
					EndIf
					
					@ Li,055 PSay aTxtCopia[IF(Val(QD1->QD1_TPDIST)==0,4,Val(QD1->QD1_TPDIST))]
					Li++
					QD1->(DbSkip())
				EndDo
			EndIf
			@ Li,000 Psay __PrtThinLine()
			Li+=2
		EndDo
	EndIf
	If lBat
		Exit
	EndIf
	QDH->(DbSkip())
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve as ordens originais dos arquivos                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("QDH")
Set Filter to

RetIndex("QD1")
Set Filter to

QDG->(DbSetOrder(1))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga indices de trabalho                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cIndex1 += OrdBagExt()
Delete File &(cIndex1)

cIndex2 += OrdBagExt()
Delete File &(cIndex2)

Set Device To Screen

If aReturn[5] == 1
	Set Printer TO
	dbCommitAll()
	ourspool(wnrel)
Endif
MS_FLUSH()

Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Cabec300  ³ Autor ³ Leandro Sabino        ³ Data ³ 14/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime dados pertinentes ao cabecalho do programa.        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabec300(ExpN1,ExpC1)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1 - Posicao da Linha                                   ³±±
±±³          ³ ExpC1 - Titulo do Relatorio                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR300                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Cabec300(Li,cTitulo)
Local nTipo		:= GetMV("MV_COMP")
Li:= 0
Cabec(ctitulo,"","",wnRel,ctamanho,nTipo)  

@ Li,000 PSay Upper(OemToAnsi(STR0013))+AllTrim(QDH->QDH_DOCTO)+"/"+QDH->QDH_RV	// "Documento: "

Li++
@ Li,000 PSay OemToAnsi(STR0014)+Substr(Alltrim(QDH->QDH_TITULO),1,70) // "T¡tulo :"

If !Empty(Substr(Alltrim(QDH->QDH_TITULO),71))
	Li++
	@ Li,009 PSay Substr(Alltrim(QDH->QDH_TITULO),71)
EndIf
Li++

Return
