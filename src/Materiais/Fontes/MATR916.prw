/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include	"RwMake.Ch"
#Include 	"Matr916.Ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Matr916   ³ Autor ³Gustavo G. Rueda       ³ Data ³01.08.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao das entradas e saidas de mercadorias em estabele-   ³±±
±±³          ³cimento de produtor de acordo com a portaria CAT de         ³±±
±±³          ³20/02/2003.                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL1                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Matr916 ()
	Local 	aArea		:= 	GetArea ()
	Local 	cPerg		:= 	"MTR916"
	Local 	nOpca		:=	0
	Local	lRet		:=	.T.
	Local 	cTitulo  	:= "Relacao das Entradas e Saidas das Mercadorias - Produtores Rurais"
	Local 	cDesc1  	:= STR0061	//"Este relatorio imprime a listagem de acompanhamento dos meios-magnetivos"
	Local 	cDesc2  	:= ""
	Local 	cDesc3  	:= ""
	Local 	wnrel   	:= "Matr916"
	Local 	NomeProg	:= "Matr916"	
	Local	cString		:=	""
	Local 	Tamanho 	:= 	"P" 	// P/M/G
	Local 	lVerpesssen := Iif(FindFunction("Verpesssen"),Verpesssen(),.T.)
	Private Limite      :=  80    	// 80/132/220
	Private lEnd    	:= 	.F.		// Controle de cancelamento do relatorio
	Private m_pag   	:= 	1  		// Contador de Paginas
	Private nLastKey	:=	0  		// Controla o cancelamento da SetPrint e SetDefault
	Private aReturn 	:= {STR0001, 1, STR0002, 2, 2, 1, "", 1 }	//"Zebrado"###"Administracao"
	//
	
	If lVerpesssen
		Pergunte (cPerg, .F.)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//| STR0003 = "Matr916 - Relacao das entradas e saidas de mercadorias em estabelecimento de produtor." |
		//| STR0004	= "Esta rotina tem como objetivo gerar um relatorio de acordo com a portaria CAT de "      |
		//| STR0005	= "20/02/2003 considerando o disposto nos artigos 16 a 20, 36 a 38, 67 a 69 da Lei "       |
		//| STR0006	= "n. 6.374, de 1/03/1989, e nos artigos 19 a 35, 70, 139 a 145, 214 e 8 das "             |
		//| STR0007	= "Disposicoes Transitorias."                                                              |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		FormBatch (OemToAnsi (STR0003), {;
			OemToAnsi (STR0004), OemToAnsi (STR0005), OemToAnsi (STR0006), OemToAnsi (STR0007)},;
			{{5, .T., {|o| Pergunte (cPerg, .T.)}},;
			{ 1, .T., {|o| nOpca := 1, o:oWnd:End()}},;
			{ 2, .T., {|o| nOpca := 2, o:oWnd:End()}}})
		//
		If (nOpca==1)				
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Envia para a SetPrinter                                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			wnrel	:=	SetPrint (cString, NomeProg, cPerg, @cTitulo, cDesc1, cDesc2, cDesc3, .F.,, .F., Tamanho,, .F.)
			//
			If (nLastKey==27)
				Return (lRet)
			Endif
			//
			SetDefault (aReturn, cString)
			//
			If (nLastKey==27)
				Return (lRet)
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Preparacao do inicio de processamento do arquivo pre-formatado          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			RptStatus ({|lEnd|sfResmep (@lEnd, MV_PAR01, MV_PAR02, Left (MV_PAR03, 40), Left (sfValidDoc (MV_PAR04), 9),;
				MV_PAR05, Left (MV_PAR06, 20), Left (sfValidDoc (MV_PAR07), 11))}, cTitulo)
			//
			If (aReturn[5]==1)
				Set Printer To 	
				ourspool(wnrel)
			Endif
			MS_FLUSH()
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Restaura area ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	EndIf
	RestArea (aArea)
Return (lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³sfResmep  ³ Autor ³Gustavo G. Rueda       ³ Data ³01.08.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Processa relatorio.                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL1                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpD1 -> cPerg = Nome da pergunta a ser criada.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function sfResmep (lEnd, dDataIni, dDataFim, cNomeSignat, cRgSignat, dDataEntreg, cTipoEstab, cCpfSignat)
	Local	lRet			:=	(.T.)
	Local	nIndImp			:=	0
	Local	aQuadro1		:=	{}
	Local	aQuadro2		:=	{}
	Local	aQuadro3		:=	{}
	Local	aQuadro4		:=	{}
//	Local	aQuadro5		:=	{}
	Local	aQuadro6		:=	{}
	Local	aQuadro9		:=	{}
//	Local	aLayOut			:=	{}
	Local	nLin			:=	2
//	Local	nSldCredorAnt	:=	0
	Local	nAcIcms			:=	0
	Local	nAcCred			:=	0
	Local	nAcTrans		:=	0
	Local	nQtdQuadros		:=	9
	//
	If Interrupcao(lEnd)
		Return (lRet)
	Endif
	//
	SetRegua (nQtdQuadros)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta quadro 1 -> Cabecalho.                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aQuadro1	:=	sfQuadro1 ()
	IncRegua ()
	//
	FmtLin (, aQuadro1[1],,, @nLin++)
	FmtLin (, aQuadro1[2],,, @nLin++)
	FmtLin (, aQuadro1[3],,, @nLin++)
	FmtLin ({SubStr (DToS (dDataIni), 5, 2)+"/"+SubStr (DToS (dDataIni), 1, 4)}, aQuadro1[4],,, @nLin++)
	FmtLin (, aQuadro1[5],,, @nLin++)
	//	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta quadro 2 -> Dados relativos ao estabelecimento.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nLin++
	aQuadro2	:=	sfQuadro2 (cNomeSignat, cTipoEstab, SM0->M0_NOMECOM, SM0->M0_ENDENT,;
		sfValidDoc (SM0->M0_INSC), SM0->M0_CIDENT, cCpfSignat)
	IncRegua ()
	//
	FmtLin (,aQuadro2[01][01],,, @nLin++)
	FmtLin (,aQuadro2[01][02],,, @nLin++)
	FmtLin (,aQuadro2[01][03],,, @nLin++)
	FmtLin ({aQuadro2[02][01]}, aQuadro2[1][4],,, @nLin++)
	FmtLin (,aQuadro2[01][05],,, @nLin++)
	FmtLin ({aQuadro2[02][02], aQuadro2[2][3]}, aQuadro2[1][6],,, @nLin++)
	FmtLin (,aQuadro2[01][07],,, @nLin++)
	FmtLin ({aQuadro2[02][04], aQuadro2[2][5]}, aQuadro2[1][8],,, @nLin++)
	FmtLin (,aQuadro2[01][09],,, @nLin++)
	FmtLin ({aQuadro2[02][06], aQuadro2[2][7]}, aQuadro2[1][10],,, @nLin++)
	FmtLin (,aQuadro2[01][11],,, @nLin++)
	//
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta quadro 3 -> Saldo anterior.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nLin++
	aQuadro3	:=	sfQuadro3 (dDataIni)
	IncRegua ()
	//
	FmtLin (, aQuadro3[1][1],,, @nLin++)
	FmtLin ({Transform (aQuadro3[2], "@er 9,999,999,999.99")}, aQuadro3[1][2],,, @nLin++)
	FmtLin (, aQuadro3[1][3],,, @nLin++)
	//
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta Quadro 4 -> Documentos fiscais relativos a aquisicoes³
	//³de mercadorias e de servicos tomados.                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nLin++
	aQuadro4	:=	sfQuadro4(dDataIni, dDataFim)
	IncRegua ()
	//
	FmtLin (, aQuadro4[1][1],,, @nLin++)
	FmtLin (, aQuadro4[1][2],,, @nLin++)
	FmtLin (, aQuadro4[1][3],,, @nLin++)
	FmtLin (, aQuadro4[1][4],,, @nLin++)
	FmtLin (, aQuadro4[1][5],,, @nLin++)	
	//
	If (Len (aQuadro4[2])>0)
		For nIndImp := 1 To (Len (aQuadro4[2]))
			FmtLin ({aQuadro4[2][nIndImp][1], aQuadro4[2][nIndImp][2], aQuadro4[2][nIndImp][3],;
				aQuadro4[2][nIndImp][4], Transform (aQuadro4[2][nIndImp][5], "@ER 999,999,999.99"),;
				Transform (aQuadro4[2][nIndImp][6], "@ER 999,999,999.99")}, aQuadro4[1][6],,,@nLin++)
			//
			nAcIcms	+=	aQuadro4[2][nIndImp][6]
			//
			If (nLin>=60)
				nLin	:=	2
			EndIf
		Next (nIndImp)
	EndIf
	//
	FmtLin (, aQuadro4[1][7],,, @nLin++)
	FmtLin ({Transform (nAcIcms, "@E 999,999,999.99")}, aQuadro4[1][8],,, @nLin++)
	FmtLin (, aQuadro4[1][9],,, @nLin++)	
	/*
	
	QUADRO 5 ESTA COMENTADO POIS ATUALMENTE O SISTEMA NAO ATENDE ESTA INFORMACAO NESCESSARIA.
	
	//
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta quadro 5 -> Creditos utilizados para abatimentos de ³
	//³impostro recolhido em seu proprio nome.                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (nLin>=60) .Or. ((60-nLin)<5)
		nLin	:=	2
	EndIf
	//
	nLin++
	aQuadro5	:=	sfQuadro5 ()
	IncRegua ()
	//
	FmtLin (,aQuadro5[1][1],,,@nLin++)	
	FmtLin (,aQuadro5[1][2],,,@nLin++)	
	FmtLin (,aQuadro5[1][3],,,@nLin++)	
	FmtLin (,aQuadro5[1][4],,,@nLin++)	
	FmtLin (,aQuadro5[1][5],,,@nLin++)	
	//
	For nIndImp := 1 To (Len (aQuadro5[2]))
		FmtLin ({aQuadro5[2][nIndImp][1], aQuadro5[2][nIndImp][2], aQuadro5[2][nIndImp][3],;
			aQuadro5[2][nIndImp][4], aQuadro5[2][nIndImp][5], aQuadro5[2][nIndImp][6]}, aQuadro5[1][6],,,@nLin++)
		//
		nAcCred	+=	Val (aQuadro5[2][nIndImp][6])
		//
		If (nLin>=60)
			nLin	:=	2
		EndIf
	Next (nIndImp)
	//
	FmtLin (,aQuadro5[1][7],,,@nLin++)
	FmtLin ({Transform (nAcCred, "@E 999,999,999.99")},aQuadro5[1][8],,,@nLin++)
	FmtLin (,aQuadro5[1][9],,,@nLin++)	
	*/
	//
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta quadro 6 -> Saidas de mercadorias³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (nLin>=60) .Or. ((60-nLin)<5)
		nLin	:=	2
	EndIf
	nLin++
	aQuadro6	:=	sfQuadro6 (dDataIni, dDataFim)
	IncRegua ()
	//
	FmtLin (, aQuadro6[1][1],,, @nLin++)
	FmtLin (, aQuadro6[1][2],,, @nLin++)
	FmtLin (, aQuadro6[1][3],,, @nLin++)
	FmtLin (, aQuadro6[1][4],,, @nLin++)
	FmtLin (, aQuadro6[1][5],,, @nLin++)	
	//
	If (Len (aQuadro6[2])>0)
		For nIndImp := 1 To (Len (aQuadro6[2]))
			FmtLin ({aQuadro6[2][nIndImp][1], aQuadro6[2][nIndImp][2], aQuadro6[2][nIndImp][3],;
				aQuadro6[2][nIndImp][4], Transform (aQuadro6[2][nIndImp][5], "@ER 999,999,999.99"),;
				Transform (aQuadro6[2][nIndImp][6], "@ER 999,999,999.99")}, aQuadro6[1][6],,,@nLin++)
			//
			nAcTrans	+=	aQuadro6[2][nIndImp][6]
			//
			If (nLin>=60)
				nLin	:=	2
			EndIf
		Next (nIndImp)
	EndIf
	//
	FmtLin (,aQuadro6[1][7],,, @nLin++)
	FmtLin ({Transform (nAcTrans, "@E 999,999,999.99")}, aQuadro6[1][8],,, @nLin++)
	FmtLin (,aQuadro6[1][9],,, @nLin++)	
	//
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta quadro 7 -> Creditos estornados no periodo.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (nLin>=60) .Or. ((60-nLin)<3)
		nLin	:=	1
	EndIf
	//
	nLin++
	aQuadro7	:=	sfQuadro7 (dDataIni)
	IncRegua ()
	//
	FmtLin (, aQuadro7[1][1],,, @nLin++)
	FmtLin ({aQuadro7[2]}, aQuadro7[1][2],,, @nLin++)
	FmtLin (, aQuadro7[1][3],,, @nLin++)
	//
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta quadro 8 -> Saldo credor do periodo.       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (nLin>=60)
		nLin	:=	1
	EndIf
	//
	nLin++
	aQuadro8	:=	sfQuadro8 (aQuadro3[2]+nAcIcms-nAcCred-nAcTrans-aQuadro7[2])
	IncRegua ()
	//
	FmtLin (, aQuadro8[1][1],,, @nLin++)
	FmtLin ({aQuadro8[2]}, aQuadro8[1][2],,, @nLin++)
	FmtLin (, aQuadro8[1][3],,, @nLin++)
	//
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta quadro 9/10 -> Dados referente o signatario/Protocolo.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (nLin>=60) .Or. ((60-nLin)<21)
		nLin	:=	1
	EndIf
	//
	nLin++
	aQuadro9	:=	sfQuadro9 (cNomeSignat, cRgSignat, dDataEntreg)
	IncRegua ()	
	//
	FmtLin (, aQuadro9[1][1],,, @nLin++)
	FmtLin (, aQuadro9[1][2],,, @nLin++)
	FmtLin (, aQuadro9[1][3],,, @nLin++)
	FmtLin ({aQuadro9[2][1]}, aQuadro9[1][4],,, @nLin++)
	FmtLin (, aQuadro9[1][5],,, @nLin++)
	FmtLin ({aQuadro9[2][2], DToC (aQuadro9[2][3])}, aQuadro9[1][6],,, @nLin++)
	//
	For nIndImp := 7 To Len (aQuadro9[1])	
		FmtLin (, aQuadro9[1][nIndImp],,, @nLin++)
	Next (nIndImp)
	//
	FmtLin ({"."}, "#",,, @nLin++)
	//
Return (lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³sfQuadro1 ³ Autor ³Gustavo G. Rueda       ³ Data ³01.08.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta layout do quadro 1 para o relatorio.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpA1 -> aRet = Array contendo estrutura do layout.         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static function sfQuadro1 ()
	Local	aRet	:=	{}
	//
	aAdd (aRet, STR0053)	//01 - "+------------+------------------------------------------------+---+--------------+"
	aAdd (aRet, STR0054)	//02 - "|            |  RELACAO DAS ENTRADAS E SAIDAS DAS MERCADORIAS | 1 |REF.MES/ANO   |"
	aAdd (aRet, STR0055)	//03 - "|            |                                                +---+--------------+"
	aAdd (aRet, STR0056)	//04 - "|            |         EM ESTABELECIMENTO DE PRODUTOR         |    #######       |"
	aAdd (aRet, STR0057)	//05 - "+------------+------------------------------------------------+------------------+"
	//
Return (aRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³sfQuadro2 ³ Autor ³Gustavo G. Rueda       ³ Data ³01.08.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta layout do quadro 2 para o relatorio.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpA1 -> aRet = Array contendo estrutura do layout.         ³±±
±±³          ³ExpA2 -> aRet = Array contendo a informacao a ser impressa. ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static function sfQuadro2 (cNomeSignat, cTipoEstab, cNomeCom, cEndereco, cIe, cMunicipio, cCpfSignat)
	Local	aRet1	:=	{}
	Local	aRet2	:=	{}
	//             				   0	     1         2         3         4         5         6         7         8
	// 							   012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Layout da secao 2³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aAdd (aRet1, STR0009)	//"+---+----------------------------------------------------------------------------+"
	aAdd (aRet1, STR0010)	//"| 2 |                  DADOS RELATIVOS AO ESTABELECIMENTO                        |"
	aAdd (aRet1, STR0009)	//"+---+----------------------------------------------------------------------------+"
	aAdd (aRet1, STR0011)	//"|NOME PRODUTOR: ########################################                         |"
	aAdd (aRet1, STR0012)	//"+--------------------------+-----------------------------------------------------+"
	aAdd (aRet1, STR0013)	//"|TIPO: ####################|NOME: ########################################       |"
	aAdd (aRet1, STR0014)	//"+--------------------------+-------------------------------+---------------------+"
	aAdd (aRet1, STR0015)	//"|ENDERECO: ########################################        |IE: ##############   |"
	aAdd (aRet1, STR0016)	//"+----------------------------------------------------------+---------------------+"
	aAdd (aRet1, STR0017)	//"|MUNICIPIO: ####################                           |CPF: ###########     |"
	aAdd (aRet1, STR0016)	//"+----------------------------------------------------------+---------------------+"
	//
	aAdd (aRet2, Left (cNomeSignat, 40))
	aAdd (aRet2, Left (cTipoEstab, 20))
	aAdd (aRet2, Left (cNomeCom, 40))
	aAdd (aRet2, Left (cEndereco, 40))
	aAdd (aRet2, Left (cIe, 14))
	aAdd (aRet2, Left (cMunicipio, 20))
	aAdd (aRet2, Left (cCpfSignat, 11))
Return ({aRet1,aRet2})
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³sfQuadro3 ³ Autor ³Gustavo G. Rueda       ³ Data ³01.08.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta layout do quadro 3 para o relatorio.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpA1 -> aRet = Array contendo estrutura do layout.         ³±±
±±³          ³ExpN2 -> nValor = Var. contendo o valor do saldo a imprimir.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static function sfQuadro3 (dDataIni)
	Local	aRet	:=	{}
	Local	nValor	:=	0
	//
	aAdd (aRet, STR0009)	//"+---+----------------------------------------------------------------------------+"
	aAdd (aRet, STR0019)	//"| 3 |SALDO CREDOR ANTERIOR:                                     ################ |"
	aAdd (aRet, STR0009)	//"+---+----------------------------------------------------------------------------+"
	//
	FisApur ("IC", Year (dDataIni), Month (dDataIni), 3, 1, "*", .F., {}, 1, .T., "FIS")
	FIS->(DbSeek ("009"))
	nValor	:=	FIS->VALOR
	//
	FIS->(DbCloseArea ())
	DbSelectArea ("SA1")
Return ({aRet, nValor})

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³sfQuadro4 ³ Autor ³Gustavo G. Rueda       ³ Data ³01.08.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta layout do quadro 4 para o relatorio.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpA1 -> aRet = Array contendo estrutura do layout.         ³±±
±±³          ³ExpA2 -> aRet = Array contendo a informacao a ser impressa. ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static function sfQuadro4 (dDataIni, dDataFim)
	Local	aRet1		:=	{}
	Local	aRet2		:=	{}
	Local	cAliasSf3	:=	"SF3"
	#IFDEF TOP
	Local	aStruSf3	:=	{}
	Local	cQuery		:=	""
	Local	nSf3		:=	1
	#ENDIF	 
	Local	cindSf3		:=	""
	Local	cChave		:=	""
	Local	cFiltro		:=	""
	Local	cAliasSa2	:=	""
	//             				   0	     1         2         3         4         5         6         7         8
	// 							   012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Layout da secao 4³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aAdd (aRet1, STR0009)	//01 - "+---+----------------------------------------------------------------------------+"
	aAdd (aRet1, STR0021)	//02 - "| 4 |DOC. FISCAIS RELATIVOS A AQUISICOES DE MERCADORIAS E DE SERVICOS TOMADOS    |"
	aAdd (aRet1, STR0022)	//03 - "+---+----------+---------+----------------+----+--------------+------------------+"
	aAdd (aRet1, STR0023)	//04 - "|   N. NF      | DIA/MES | IE FORNECEDOR  | UF |  VALOR(R$)   |ICMS DESTACADO(R$)|"
	aAdd (aRet1, STR0024)	//05 - "+--------------+---------+----------------+----+--------------+------------------+"
	aAdd (aRet1, STR0052)	//06 - "|##############|  #####  | ############## | ## |##############|   ############## |"
	aAdd (aRet1, STR0024)	//07 - "+--------------+---------+----------------+----+--------------+------------------+"
	aAdd (aRet1, STR0026)	//08 - "|TOTAL DOS CREDITOS ESCRITURADOS NO MES:                          ############## |"
	aAdd (aRet1, STR0025)	//09 - "+--------------------------------------------------------------------------------+"
	//
	#IFDEF TOP
		If (TcSrvType ()<>"AS/400")
		    cAliasSF3	:= 	"sfQuadro4"
			aStruSF3  	:= 	SF3->(dbStruct())
			//
			cQuery	:=	"SELECT "
			cQuery	+=	"SF3.F3_NFISCAL, SF3.F3_SERIE, "
			cQuery	+=  Iif(SerieNfId("SF3",3,"F3_SERIE")<>"F3_SERIE","SF3."+SerieNfId("SF3",3,"F3_SERIE")+",","")
			cQuery	+=  "SF3.F3_EMISSAO, SA2.A2_INSCR, SA2.A2_EST, SF3.F3_VALCONT, SF3.F3_VALICM "
			cQuery	+=	"FROM "
			cQuery	+=	RetSqlName("SF3")+" SF3 JOIN "+RetSqlName("SA2")+" SA2 ON (SF3.F3_CLIEFOR=SA2.A2_COD AND SF3.F3_LOJA=SA2.A2_LOJA) "
			cQuery	+=	"WHERE "
			cQuery	+=	"SF3.F3_FILIAL='"+xFilial ("SF3")+"' AND "
			cQuery	+=	"SF3.F3_ENTRADA>='"+DToS (dDataIni)+"' AND "
			cQuery	+=	"SF3.F3_ENTRADA<='"+DToS (dDataFim)+"' AND "
			cQuery	+=	"SF3.D_E_L_E_T_<>'*' AND "
			cQuery	+=	"SA2.D_E_L_E_T_<>'*' AND "
			cQuery	+=	"SUBSTRING(SF3.F3_CFO,1,1) IN('1','2','3')"
			//
			cQuery 	:= 	ChangeQuery (cQuery)
	    	//
			DbUseArea (.T., "TOPCONN", TcGenQry (,,cQuery), cAliasSF3, .T., .T.)
			//
			For nSF3 := 1 To (Len (aStruSF3))
				If (aStruSF3[nSF3][2]<>"C") .And. (FieldPos (aStruSF3[nSF3][1])>0)
					TcSetField (cAliasSF3, aStruSF3[nSF3][1], aStruSF3[nSF3][2], aStruSF3[nSF3][3], aStruSF3[nSF3][4])
				EndIf
			Next (nSF3)
		    
		Else
	#ENDIF	 
			DbSelectArea (cAliasSF3)
			cIndSF3		:=	CriaTrab (NIL,.F.)
			cChave		:=	IndexKey ()
			cFiltro		:=	"SF3->F3_FILIAL=='"+xFilial ("SF3")+"' "
			cFiltro		+=	".And. (DToS(SF3->F3_ENTRADA)>='"+DToS (dDataIni)+"') .And. (DToS (SF3->F3_ENTRADA)<='"+DToS (dDataFim)+"') "
			cFiltro		+=	".And. (Left (SF3->F3_CFO, 1)$'123')"
			//
			IndRegua (cAliasSF3, cIndSF3, cChave,, cFiltro, STR0060) //"Selec.Notas fiscais..."
	#IFDEF TOP
		Endif
	#ENDIF
	//
	DbSelectArea (cAliasSf3)
		(cAliasSf3)->(DbGoTop ())
	Do while .Not. (cAliasSf3)->(Eof ())
		#IFNDEF TOP
	    	DbSelectArea ("SA2")
	    		SA2->(DbSetOrder (1))
	    	SA2->(DbSeek (xFilial ("SA2")+(cAliasSf3)->F3_CLIEFOR+(cAliasSf3)->F3_LOJA))
	    	cAliasSa2	:=	"SA2"
	    #ELSE
	    	cAliasSa2	:=	cAliasSf3
        #ENDIF
        //
		aAdd (aRet2, {Alltrim ((cAliasSf3)->F3_NFISCAL)+"/"+AllTrim ((cAliasSf3)->&(SerieNfId("SF3",3,"F3_SERIE"))),;
			SubStr (AllTrim (DToS ((cAliasSf3)->F3_EMISSAO)), 7, 2)+"/"+SubStr (AllTrim (DToS ((cAliasSf3)->F3_EMISSAO)), 5, 2),;
			AllTrim ((cAliasSa2)->A2_INSCR), AllTrim ((cAliasSa2)->A2_EST), (cAliasSf3)->F3_VALCONT, (cAliasSf3)->F3_VALICM})
		//
		(cAliasSf3)->(DbSkip ())
	EndDo
	//
	#IFDEF TOP
		(cAliasSf3)->(DbCloseArea ())
		DbSelectArea ("SA1")
	#ENDIF
Return ({aRet1, aRet2})                       

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³sfQuadro5 ³ Autor ³Gustavo G. Rueda       ³ Data ³01.08.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta layout do quadro 5 para o relatorio.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpA1 -> aRet = Array contendo estrutura do layout.         ³±±
±±³          ³ExpA2 -> aRet = Array contendo a informacao a ser impressa. ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

Static function sfQuadro5 ()
	Local	aRet1	:=	{}
	Local	aRet2	:=	{}
	//             				   0	     1         2         3         4         5         6         7         8
	// 							   012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Layout da secao 5³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aAdd (aRet1, STR0009)	//01 - "+---+----------------------------------------------------------------------------+"
	aAdd (aRet1, STR0028)	//02 - "| 5 |CRED.  UTILIZADO PARA ABATIMENTO DE IMPOSTO RECOLHIDO EM SEU PROPRIO NOME   |"
	aAdd (aRet1, STR0029)	//03 - "+---+------+-------+--------------+-----------------+----------+-----------------+"
	aAdd (aRet1, STR0030)	//04 - "|  NFP N.  |DIA/MES| VALOR NFP(R$)|VLR IMP. DEV.{R$}|   GR N.  |CRED. UTIL(R$)   |"
	aAdd (aRet1, STR0031)	//05 - "+----------+-------+--------------+-----------------+----------+-----------------+"
	aAdd (aRet1, STR0058)	//06 - "|##########| ##### |##############|################ |##########|  ############## |"
	aAdd (aRet1, STR0031)	//07 - "+----------+-------+--------------+-----------------+----------+-----------------+"
	aAdd (aRet1, STR0032)	//08 - "|TOTAL DOS CREDITOS UTILIZADOS EM GRS:                            ############## |"
	aAdd (aRet1, STR0025)	//09 - "+--------------------------------------------------------------------------------+"
	//
	aAdd (aRet2, {"", "", 0, 0, "", 0})
Return ({aRet1, aRet2})
*/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³sfQuadro6 ³ Autor ³Gustavo G. Rueda       ³ Data ³01.08.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta layout do quadro 6 para o relatorio.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpA1 -> aRet = Array contendo estrutura do layout.         ³±±
±±³          ³ExpA2 -> aRet = Array contendo a informacao a ser impressa. ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static function sfQuadro6 (dDataIni, dDataFim)
	Local	aRet1		:=	{}
	Local	aRet2		:=	{}
	Local	cAliasSf3	:=	"SF3"
	#IFDEF TOP
	Local	aStruSf3	:=	{}
	Local	cQuery		:=	""
	Local	nSf3		:=	1
	#ENDIF	 
	Local	cIndSF3		:=	""
	Local	cChave		:=	""
	Local	cFiltro		:=	""
	Local	cAliasSa1	:=	""
	//             				   0	     1         2         3         4         5         6         7         8
	// 							   012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Layout da secao 6³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aAdd (aRet1, STR0009)	//01 - "+---+----------------------------------------------------------------------------+"
	aAdd (aRet1, STR0034)	//02 - "| 6 |                          SAIDAS DE MERCADORIAS                             |"
	aAdd (aRet1, STR0035)	//03 - "+---+----------+---------+-----------------+----+--------------+-----------------+"
	aAdd (aRet1, STR0036)	//04 - "|  N. NFP      | DIA/MES | IE DESTINATARIO | UF |  VLR NFP(R$) | ICMS TRANSF.(R$)|"
	aAdd (aRet1, STR0037)	//05 - "+--------------+---------+-----------------+----+--------------+-----------------+"
	aAdd (aRet1, STR0059)	//06 - "|##############|  #####  |  ############## | ## |##############|  ############## |"
	aAdd (aRet1, STR0037)	//07 - "+--------------+---------+-----------------+----+--------------+-----------------+"
	aAdd (aRet1, STR0038)	//08 - "|TOTAL DOS CREDITOS TRANSFERIDO:                                  ############## |"
	aAdd (aRet1, STR0025)	//09 - "+--------------------------------------------------------------------------------+"
	//
	#IFDEF TOP
		If (TcSrvType ()<>"AS/400")
		    cAliasSF3	:= 	"sfQuadro6"
			aStruSF3  	:= 	SF3->(dbStruct())
			//
			cQuery	:=	"SELECT "
			cQuery	+=	"SF3.F3_NFISCAL, SF3.F3_SERIE,"
			cQuery	+=  Iif(SerieNfId("SF3",3,"F3_SERIE")<>"F3_SERIE","SF3."+SerieNfId("SF3",3,"F3_SERIE")+",","") 
			cQuery	+=  "SF3.F3_EMISSAO, SA1.A1_INSCR, SA1.A1_EST, SF3.F3_VALCONT, SF3.F3_VALICM "
			cQuery	+=	"FROM "
			cQuery	+=	RetSqlName("SF3")+" SF3 JOIN "+RetSqlName("SA1")+" SA1 ON (SF3.F3_CLIEFOR=SA1.A1_COD AND SF3.F3_LOJA=SA1.A1_LOJA) "
			cQuery	+=	"WHERE "
			cQuery	+=	"SF3.F3_FILIAL='"+xFilial ("SF3")+"' AND "
			cQuery	+=	"SF3.F3_ENTRADA>='"+DToS (dDataIni)+"' AND "
			cQuery	+=	"SF3.F3_ENTRADA<='"+DToS (dDataFim)+"' AND "
			cQuery	+=	"SF3.D_E_L_E_T_<>'*' AND "
			cQuery	+=	"SA1.D_E_L_E_T_<>'*' AND "
			cQuery	+=  "SUBSTRING(SF3.F3_CFO,1,1) IN('5','6','7') AND "
			cQuery	+=	"(SF3.F3_OBSERV NOT LIKE '%CANCELAD%' OR SF3.F3_DTCANC='')"
			//
			cQuery 	:= 	ChangeQuery (cQuery)
	    	//
			DbUseArea (.T., "TOPCONN", TcGenQry (,,cQuery), cAliasSF3, .T., .T.)
			//
			For nSF3 := 1 To (Len (aStruSF3))
				If (aStruSF3[nSF3][2]<>"C") .And. (FieldPos (aStruSF3[nSF3][1])>0)
					TcSetField (cAliasSF3, aStruSF3[nSF3][1], aStruSF3[nSF3][2], aStruSF3[nSF3][3], aStruSF3[nSF3][4])
				EndIf
			Next (nSF3)
		    
		Else
	#ENDIF	 
			DbSelectArea (cAliasSF3)
			cIndSF3		:=	CriaTrab (NIL,.F.)
			cChave		:=	IndexKey ()
			cFiltro		:=	"F3_FILIAL=='"+xFilial ("SF3")+"'"
			cFiltro		+=	".And. (DTOS(F3_ENTRADA)>='"+DToS (dDataIni)+"') .And. (DToS (F3_ENTRADA)<='"+DToS(dDataFim)+"') "
			cFiltro		+=	".And. (Left (SF3->F3_CFO, 1)$'567') .And. (!('CANCELAD'$SF3->F3_OBSERV) .Or. Empty (SF3->F3_DTCANC))"
			//
			IndRegua (cAliasSF3, cIndSF3, cChave,, cFiltro, STR0060) //"Selec.Notas fiscais..."
	#IFDEF TOP
		Endif
	#ENDIF
	//
	DbSelectArea (cAliasSf3)
		(cAliasSf3)->(DbGoTop ())
	Do while .Not. (cAliasSf3)->(Eof ())
		#IFNDEF TOP
	    	DbSelectArea ("SA1")
	    		SA1->(DbSetOrder (1))
	    	SA1->(DbSeek (xFilial ("SA1")+(cAliasSf3)->F3_CLIEFOR+(cAliasSf3)->F3_LOJA))
	    	cAliasSa1	:=	"SA1"
	    #ELSE
	    	cAliasSa1	:=	cAliasSf3
        #ENDIF
        //
		aAdd (aRet2, {Alltrim ((cAliasSf3)->F3_NFISCAL)+"/"+AllTrim ((cAliasSf3)->&(SerieNfId("SF3",3,"F3_SERIE"))),;
			SubStr (AllTrim (DToS ((cAliasSf3)->F3_EMISSAO)), 7, 2)+"/"+SubStr (AllTrim (DToS ((cAliasSf3)->F3_EMISSAO)), 5, 2),;
			AllTrim ((cAliasSa1)->A1_INSCR), AllTrim ((cAliasSa1)->A1_EST), (cAliasSf3)->F3_VALCONT, (cAliasSf3)->F3_VALICM})
		//
		(cAliasSf3)->(DbSkip ())
	EndDo
	//
	#IFDEF TOP
		(cAliasSf3)->(DbCloseArea ())
		DbSelectArea ("SA1")
	#ENDIF
Return ({aRet1, aRet2})
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³sfQuadro7 ³ Autor ³Gustavo G. Rueda       ³ Data ³01.08.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta layout do quadro 7 para o relatorio.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpA1 -> aRet = Array contendo estrutura do layout.         ³±±
±±³          ³ExpN2 -> nValor = Var. contendo o valor a ser impresso.     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static function sfQuadro7 (dDataIni)
	Local	aRet	:=	{}
	Local	nValor	:=	0
	//             				   0	     1         2         3         4         5         6         7         8
	// 							   012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Layout da secao 7³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aAdd (aRet, STR0009)	//"+---+----------------------------------------------------------------------------+"
	aAdd (aRet, STR0040)	//"| 7 |CREDITOS ESTORNADOS NO PERIODO:                              ############## |"
	aAdd (aRet, STR0009)	//"+---+----------------------------------------------------------------------------+"
	//
	FisApur ("IC", Year (dDataIni), Month (dDataIni), 3, 1, "*", .F., {}, 1, .T., "FIS")
	FIS->(DbSeek ("003"))
	nValor	:=	FIS->VALOR
	//
	FIS->(DbCloseArea ())
	DbSelectArea ("SA1")
Return ({aRet, nValor})
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³sfQuadro8 ³ Autor ³Gustavo G. Rueda       ³ Data ³01.08.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta layout do quadro 8 para o relatorio.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpA1 -> aRet = Array contendo estrutura do layout.         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpN1 -> nValor - Var. contendo o valor a ser impresso.     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static function sfQuadro8 (nValor)
	Local	aRet	:=	{}
	//             				   0	     1         2         3         4         5         6         7         8
	// 							   012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Layout da secao 8³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aAdd (aRet, STR0009)	//"+---+----------------------------------------------------------------------------+"
	aAdd (aRet, STR0042)	//"| 8 |SALDO CREDOR DO PERIODO(QUADROS: 3+4-5-6-7):                 ############## |"
	aAdd (aRet, STR0009)	//"+---+----------------------------------------------------------------------------+"
	//
Return ({aRet, nValor})
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³sfQuadro9 ³ Autor ³Gustavo G. Rueda       ³ Data ³01.08.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta layout do quadro 9/10 para o relatorio.               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpA1 -> aRet = Array contendo estrutura do layout.         ³±±
±±³          ³ExpA2 -> aRet = Array contendo a informacao a ser impressa. ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static function sfQuadro9 (cNomeSignat, cRgSignat, dDataEntreg)
	Local	aRet1	:=	{}
	Local	aRet2	:=	{}
	//             				   0	     1         2         3         4         5         6         7         8
	// 							   012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Layout da secao 9/10³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aAdd (aRet1, STR0044)	//01 - "+---+---------------------------------+ +----+-----------------------------------+"
	aAdd (aRet1, STR0045)	//02 - "| 9 |         SIGNATARIO              | | 10 |           PROTOCOLO               |"
	aAdd (aRet1, STR0044)	//03 - "+---+---------------------------------+ +----+-----------------------------------+"
	aAdd (aRet1, STR0046)	//04 - "|NOME: ############################## | |LOCAL E DATA                            |"
	aAdd (aRet1, STR0047)	//05 - "+-------------+-----------------------+ |                                        |"
	aAdd (aRet1, STR0048)	//06 - "|RG: #########|DATA ENTREGA:##########| |                                        |"
	aAdd (aRet1, STR0047)	//07 - "+-------------+-----------------------+ |                                        |"
	aAdd (aRet1, STR0049)	//08 - "|ASSINATURA:                          | |                                        |"
	aAdd (aRet1, STR0050)	//09 - "|                                     | |                                        |"	
	aAdd (aRet1, STR0050)	//10 - "|                                     | |                                        |"	
	aAdd (aRet1, STR0050)	//11 - "|                                     | |                                        |"	
	aAdd (aRet1, STR0050)	//12 - "|                                     | |                                        |"	
	aAdd (aRet1, STR0050)	//13 - "|                                     | |                                        |"	
	aAdd (aRet1, STR0050)	//14 - "|                                     | |                                        |"	
	aAdd (aRet1, STR0050)	//15 - "|                                     | |                                        |"	
	aAdd (aRet1, STR0050)	//16 - "|                                     | |                                        |"	
	aAdd (aRet1, STR0050)	//17 - "|                                     | |                                        |"	
	aAdd (aRet1, STR0050)	//18 - "|                                     | |                                        |"	
	aAdd (aRet1, STR0050)	//19 - "|                                     | |                                        |"	
	aAdd (aRet1, STR0050)	//20 - "|                                     | |                                        |"
	aAdd (aRet1, STR0051)	//21 - "+-------------------------------------+ +----------------------------------------+"
	//
	aAdd (aRet2, Left (cNomeSignat, 30))
	aAdd (aRet2, Left (cRgSignat, 11))
	aAdd (aRet2, dDataEntreg)
Return ({aRet1, aRet2})
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³sfValidDoc³ Autor ³Gustavo G. Rueda       ³ Data ³01.08.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Valida numero do Documento tirando caracteres nao validos.  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpC1 -> cRet = Numero RG valido.                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1 -> cDoc = Numero do documento.                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function sfValidDoc (cDoc)
	Local cRet	:=	""
	Local nI	:=	1
	//	
	For nI := 1 To (Len (cDoc))
		If (Isdigit (SubStr (cDoc, nI, 1))) .Or. (IsAlpha (SubStr (cDoc, nI, 1)))
			cRet	+=	SubStr (cDoc, nI, 1)
		Endif
	Next
	If (Empty (cRet))
		cRet	:=	"ISENTO"
	EndIf
Return (cRet)
