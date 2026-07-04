/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include	"RwMake.Ch"
#Include 	"Matr918.Ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Matr918   ³ Autor ³Gustavo G. Rueda       ³ Data ³13.04.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio de conferencia da DNF.                            ³±±
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
User Function Matr918 ()
	Local	lRet	:=	.T.
	Private lEnd		:=.F.
	Private lAbortPrint :=.F.
	Private cPerg	   :="MTA977"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para montar Get.                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private	aListBox	:={}
	Private	aMsg		:={}
	Private	aSel		:={}
	Private	aValid	    :={}
	Private	aConteudo   :={}
	Private	cArqTip0	:=""
	Private cArqTip1    :=""
	Private cArqTip2	:=""
	Private cArqTip3    :=""
	Private cArqTip9    :=""
	Private aCamTip0	:={}
	Private aCamTip1	:={}
	Private aCamTip2	:={}
	Private aCamTip3	:={}
	Private aCamTip9	:={}  
	Private cArq00      := ""
	Private cArq01      :=""

	If Pergunte (cPerg, .T.)
		A977ProcDNF(.T.)
	End
	
Return (lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ImpConfDnf³ Autor ³Gustavo G. Rueda       ³ Data ³13.04.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao de impressao.                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL1                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³MATA977                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ImpConfDnf ()
	Local 	aArea		:= 	GetArea ()
	Local 	cPerg		:= 	"MTA977"
	Local 	nOpca		:=	0
	Local	lRet		:=	.T.
	Local 	cTitulo  	:= STR0001	//"Relatorio de conferencia da DNF - Demonstrativo de Notas Fiscais."
	Local 	cDesc1  	:= STR0002	//"Este relatorio exibe uma previa do meio-magnetico a ser gerado."
	Local 	cDesc2  	:= ""
	Local 	cDesc3  	:= ""
	Local 	wnrel   	:= "Matr918"
	Local 	NomeProg	:= "Matr918"	
	Local	cString		:=	""
	Local 	Tamanho 	:= 	"G" 	// P/M/G
	Private Limite      :=  220   	// 80/132/220
	Private lEnd    	:= 	.F.		// Controle de cancelamento do relatorio
	Private m_pag   	:= 	1  		// Contador de Paginas
	Private nLastKey	:=	0  		// Controla o cancelamento da SetPrint e SetDefault
	Private aReturn 	:= {STR0003, 1, STR0004, 2, 2, 1, "", 1 }	//"Zebrado"###"Administracao"
	//
	Pergunte (cPerg, .F.)
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
	RptStatus ({|lEnd| ImpDnf ()}, cTitulo)
	//
	If (aReturn[5]==1)
		Set Printer To 	
	   	ourspool(wnrel)
	Endif
	MS_FLUSH()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Restaura area ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	RestArea (aArea)
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ImpDnf    ³ Autor ³Gustavo G. Rueda       ³ Data ³13.04.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao de impressao.                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL1                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³MATR918                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpDnf ()
	Local	lRet		:=	.T.
	Local	aLayMatr	:=	LayMatr ()
	Local	nLin		:=	99
	Local 	Titulo  	:= STR0001	//"Relatorio de conferencia da DNF - Demonstrativo de Notas Fiscais."
	Local 	Cabec1  	:= STR0002	//"Este relatorio exibe uma previa do meio-magnetico a ser gerado."
	Local 	Cabec2  	:= ""
	Local 	NomeProg	:= "Matr918"	
	Local 	Tamanho 	:= 	"G"
	Local	nTipo		:=	18
	Local	aTipo0		:=	{}
	Local	aTipo1		:=	{}
	Local	aTipo2		:=	{}
	Local	aTipo3		:=	{}
	Local   aFilsSel    :=  {}
	Local	cPict		:=	"@E 999,999,999,999.99"
	Local	cChaveTp2	:=	""
	Local	cChaveTp3	:=	""
	Local	nCfop		:=	5000
	Local	aIdent		:=	{}	//Identificacao dos registros tipo 2 e 3.
	Local	nCtdReg		:=	1
	Local	nPos		:=	0
	Local	nTotContr	:=	0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprimindo Registro Tipo 0 - informacoes do contribuinte.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aAdd (aTipo0, A977Fill (A977Num2Chr (Val (SM0->M0_CGC), 14, 0), 14))
	aAdd (aTipo0, A977Chk (SM0->M0_NOMECOM))
	aAdd (aTipo0, A977Fill (StrZero (nMes, 2), 2))
	aAdd (aTipo0, A977Fill (StrZero (nAno, 4), 4))
	If MV_PAR08==1
		aAdd (aTipo0, A977Fill("DNF001.1",8))
	ElseIf MV_PAR08==2
		aAdd (aTipo0, A977Fill("DNF001.2",8))
	ElseIf MV_PAR08==3
		aAdd (aTipo0, A977Fill("DNF002.0",8)) 
	Else
		aAdd (aTipo0, A977Fill("DNF003.0",8)) 			
	EndIf
	//
	If nLin>=55
		nLin	:=	cabec (Titulo, "", Cabec2, NomeProg, Tamanho, nTipo)
		nLin++
	EndIf
	//

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Versao 2004 VALIDADOR 2.0³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	                                                                             
	
	aFilsSel := MatFilCalc( (MV_PAR09==1), , , (MV_PAR10==1), , 3 )
	If mv_par08 ==3
		
		DNF2004(dDtIni,dDtFim,aFilsSel)
		
		FmtLin ({}, aLayMatr[25], cPict,, @nLin)
		FmtLin ({}, aLayMatr[15], cPict,, @nLin)
		FmtLin ({}, aLayMatr[2], cPict,, @nLin)
		FmtLin (aTipo0, aLayMatr[3], cPict,, @nLin)
		FmtLin ({}, aLayMatr[15], cPict,, @nLin)  
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprimindo Registro Tipo 0 para notas fiscais Versao 2004³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	                                                                             
	   
   	
		cArq00 := CriaTrab(Nil, .F.) 
		DbSelectArea ("R00")
		IndRegua ("R00", cArq00, "A00_REG",,, STR0021) //"Indexando Arquivo."
		R00->(DbGoTop ())
		// 
		If !R00->(Eof())
			nLin++
			FmtLin ({}, aLayMatr[23], cPict,, @nLin)
			FmtLin ({}, aLayMatr[33], cPict,, @nLin)
			FmtLin ({}, aLayMatr[30], cPict,, @nLin)
			FmtLin ({}, aLayMatr[33], cPict,, @nLin)

			//
			Do While !R00->(Eof ())
				If Interrupcao(@lAbortPrint)
					Exit
				Endif
				aAdd (aIdent, {R00->A00_REG, nCtdReg})
				//
				If nLin>=55
					nLin	:=	cabec(Titulo, "", Cabec2, NomeProg, Tamanho, nTipo)
					nLin++
				EndIf
				// 
//				aAdd (aTipo1, StrZero (nCtdReg, 10))
				aAdd (aTipo1, R00->A00_EMITE)
				aAdd (aTipo1, StrZero (Val (R00->A00_NF), 6))
				aAdd (aTipo1, StrZero (Val (R00->A00_SERIE), 3))
				aAdd (aTipo1, Substr(dtos(R00->A00_EMIS),7,2)+"/"+Substr(dtos(R00->A00_EMIS),5,2)+"/"+Substr(dtos(R00->A00_EMIS),1,4)) 
				aAdd (aTipo1, Substr(dtos(R00->A00_SAI),7,2)+"/"+Substr(dtos(R00->A00_SAI),5,2)+"/"+Substr(dtos(R00->A00_SAI),1,4)) 
				aAdd (aTipo1, R00->A00_DEST) 
				//
				FmtLin (aTipo1, aLayMatr[32], cPict,, @nLin)
				//
				R00->(DbSkip ())
				aTipo1	:=	{} 
				nCtdReg++
			EndDo
				FmtLin ({}, aLayMatr[33], cPict,, @nLin)
		EndIf                                        
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprimindo Registro Tipo 1 para notas fiscais de entrada Versao 2004³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	                                                                             
		cArq01 := CriaTrab(Nil, .F.) 
		DbSelectArea ("R01")
		IndRegua ("R01", cArq01, "A01_REG",,, STR0021) //"Indexando Arquivo."
		R01->(DbGoTop ())
		//
		If !R01->(Eof())
			nLin++
			FmtLin ({}, aLayMatr[24], cPict,, @nLin)
			FmtLin ({}, aLayMatr[29], cPict,, @nLin)
			FmtLin ({}, aLayMatr[26], cPict,, @nLin)
			FmtLin ({}, aLayMatr[29], cPict,, @nLin)

			//
			Do While !R01->(Eof ())
				If Interrupcao(@lAbortPrint)
					Exit
				Endif
				aAdd (aIdent, {R01->A01_REG, nCtdReg})
				//
				If nLin>=55
					nLin	:=	cabec(Titulo, "", Cabec2, NomeProg, Tamanho, nTipo)
					nLin++
				EndIf
				// 
				aAdd (aTipo2, StrZero (nCtdReg, 10))
				aAdd (aTipo2, R01->A01_EMITE)
				aAdd (aTipo2, StrZero (Val (R01->A01_NF), 6))
				aAdd (aTipo2, StrZero (Val (R01->A01_SERIE), 3))
				aAdd (aTipo2, Substr(Dtos(R01->A01_EMIS),7,2)+"/"+Substr(Dtos(R01->A01_EMIS),5,2)+"/"+Substr(dtos(R01->A01_EMIS),1,4))
				aAdd (aTipo2, R01->A01_ITEM)
				aAdd (aTipo2, StrZero (R01->A01_PROD, 3))
				aAdd (aTipo2, StrZero (R01->A01_CAPAC,5))
				aAdd (aTipo2, R01->A01_CFOP) 
				aAdd (aTipo2, R01->A01_UN)
				aAdd (aTipo2, TRANSFORM (R01->A01_QUANT, "@E 9,999,999.99"))
				aAdd (aTipo2, TRANSFORM (R01->A01_UNIT, "@E 9,999,999.99"))
				aAdd (aTipo2, TRANSFORM (R01->A01_TOTAL, "@E 9,999,999.99"))
				aAdd (aTipo2, TRANSFORM (R01->A01_IPI, "@E 99.99")) 
				aAdd (aTipo2, TRANSFORM (R01->A01_ESTAT, "@E 9,999,999.99"))
				//
				FmtLin (aTipo2, aLayMatr[27], cPict,, @nLin)
				//
				R01->(DbSkip ())
				aTipo2	:=	{}
				nCtdReg++
			EndDo
			FmtLin ({}, aLayMatr[29], cPict,, @nLin)
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Registro de controle - Registro tipo 9³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nLin++
		nTotContr	:=	1+R00->(LastRec ())+R01->(LastRec ())+1
		//
		FmtLin ({}, aLayMatr[07], cPict,, @nLin)
		FmtLin ({}, aLayMatr[37], cPict,, @nLin)
		FmtLin ({}, aLayMatr[34], cPict,, @nLin)
		FmtLin ({}, aLayMatr[37], cPict,, @nLin)
        
		
		aAdd (aTipo3, StrZero (R00->(LastRec ()), 7) )
		aAdd (aTipo3, StrZero (R01->(LastRec ()), 7) )
		aAdd (aTipo3, "0000001")
		aAdd (aTipo3, "0000001")
		
		FmtLin (aTipo3, aLayMatr[35], cPict,, @nLin)
		FmtLin ({}, aLayMatr[37], cPict,, @nLin)      
		
		U_ApagTempor("R00")
		U_ApagTempor("R01")
	Else  
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Versao 2010 VALIDADOR 3.0³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		FmtLin ({}, aLayMatr[1], cPict,, @nLin)
		FmtLin ({}, aLayMatr[15], cPict,, @nLin)
		FmtLin ({}, aLayMatr[2], cPict,, @nLin)
		FmtLin (aTipo0, aLayMatr[3], cPict,, @nLin)
		FmtLin ({}, aLayMatr[15], cPict,, @nLin)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprimindo Registro Tipo 1 para notas fiscais de entrada³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	                                                                             
		DbSelectArea (cArqTip1)
		IndRegua (cArqTip1, cArqTip1, "CFOP+NOTA+SERIE+EMISSAO",,, STR0021) //"Indexando Arquivo."
		(cArqTip1)->(DbGoTop ())
		//
		If !(cArqTip1)->(Eof ())
			nLin++
			FmtLin ({}, aLayMatr[16], cPict,, @nLin)
			FmtLin ({}, aLayMatr[20], cPict,, @nLin)
			FmtLin ({}, aLayMatr[4], cPict,, @nLin)
			FmtLin ({}, aLayMatr[5], cPict,, @nLin)
			FmtLin ({}, aLayMatr[20], cPict,, @nLin)
			//
			Do While !(cArqTip1)->(Eof ())
				If Interrupcao(@lAbortPrint)
					Exit
				Endif
				aAdd (aIdent, {(cArqTip1)->CFOP+(cArqTip1)->CNPJ+(cArqTip1)->NOTA+(cArqTip1)->SERIE, nCtdReg})
				//
				If nLin>=55
					nLin	:=	cabec(Titulo, "", Cabec2, NomeProg, Tamanho, nTipo)
					nLin++
				EndIf
				//
				aAdd (aTipo1, StrZero (nCtdReg, 10))
				aAdd (aTipo1, (cArqTip1)->CNPJ)
				aAdd (aTipo1, StrZero (Val ((cArqTip1)->NOTA), 6))
				aAdd (aTipo1, StrZero (Val ((cArqTip1)->SERIE), 3))
				aAdd (aTipo1, SubStr (AllTrim ((cArqTip1)->EMISSAO), 1, 2)+"/"+SubStr (AllTrim ((cArqTip1)->EMISSAO), 3, 2)+"/"+SubStr (AllTrim ((cArqTip1)->EMISSAO), 5, 4))
				aAdd (aTipo1, SubStr (AllTrim ((cArqTip1)->EFETIVA), 1, 2)+"/"+SubStr (AllTrim ((cArqTip1)->EFETIVA), 3, 2)+"/"+SubStr (AllTrim ((cArqTip1)->EFETIVA), 5, 4))
				aAdd (aTipo1, (cArqTip1)->CFOP)
				aAdd (aTipo1, IntToDec ((cArqTip1)->VALNF, "@E 9,999,999.99"))
				aAdd (aTipo1, IntToDec ((cArqTip1)->VALIPI, "@E 9,999,999.99"))
				aAdd (aTipo1, IntToDec ((cArqTip1)->ISENTO, "@E 9,999,999.99"))
				aAdd (aTipo1, Iif ("N"$(cArqTip1)->CANCEL, "NAO","SIM"))
				aAdd (aTipo1, Iif ("N"$(cArqTip1)->COMPL, "NAO","SIM"))
				aAdd (aTipo1, (cArqTip1)->NFVINCU)
				aAdd (aTipo1, (cArqTip1)->SERVINCU)
				aAdd (aTipo1, SubStr (AllTrim ((cArqTip1)->DTVINCU), 1, 2)+"/"+SubStr (AllTrim ((cArqTip1)->DTVINCU), 3, 2)+"/"+SubStr (AllTrim ((cArqTip1)->DTVINCU), 5, 4))
				//
				FmtLin (aTipo1, aLayMatr[6], cPict,, @nLin)
				//
				(cArqTip1)->(DbSkip ())
				aTipo1	:=	{}
				nCtdReg++
			EndDo
			FmtLin ({}, aLayMatr[20], cPict,, @nLin)
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Impriminto Registro Tipo 3 - Itens das notas fiscais de entrada.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbSelectArea (cArqTip3)
		IndRegua (cArqTip3, cArqTip3, "CFOP+NOTA+SERIE+EMISSAO",,, STR0021) //"Indexando Arquivo."
		(cArqTip3)->(DbGoTop ())
		//
		If !(cArqTip3)->(Eof ())
			nLin++
			FmtLin ({}, aLayMatr[21], cPict,, @nLin)
			FmtLin ({}, aLayMatr[19]+aLayMatr[18], cPict,, @nLin)
			FmtLin ({}, aLayMatr[09]+aLayMatr[13], cPict,, @nLin)
			FmtLin ({}, aLayMatr[19]+aLayMatr[18], cPict,, @nLin)
			//
			Do While !(cArqTip3)->(Eof ())
				If Interrupcao(@lAbortPrint)
					Exit
				Endif
				//
				If nLin>=55
					nLin	:=	cabec(Titulo, "", Cabec2, NomeProg, Tamanho, nTipo)
					nLin++
				EndIf
				//
				nPos	:=	aScan (aIdent, {|aX| aX[1]==(cArqTip3)->CFOP+(cArqTip3)->CNPJ+(cArqTip3)->NOTA+(cArqTip3)->SERIE})
				//
				aAdd (aTipo3, Iif (nPos==0, "", StrZero (aIdent[nPos][2], 10)))
				aAdd (aTipo3, (cArqTip3)->ITEM)
				aAdd (aTipo3, Left (AllTrim ((cArqTip3)->CODMERC), 15))
				aAdd (aTipo3, Left (AllTrim (A977Chk((cArqTip3)->DESMERC)), 40))
				aAdd (aTipo3, (cArqTip3)->NCM)
				If MV_PAR08==2
					aAdd (aTipo3, (cArqTip3)->PRODDNF)
				Else
					aAdd (aTipo3, (cArqTip3)->ESPECIE)
				EndIf
				aAdd (aTipo3, (cArqTip3)->CFOP)
				If (MV_PAR08==1)
					aAdd (aTipo3, (cArqTip3)->CODUNID)
				Else
					aAdd (aTipo3, "")
				EndIf
				aAdd (aTipo3, IntToDec ((cArqTip3)->QUANTIDADE, "@E 999,999.999", 3))
				aAdd (aTipo3, IntToDec ((cArqTip3)->VALUNIT, "@E 999,999.9999", 4))
				aAdd (aTipo3, IntToDec ((cArqTip3)->VALTOT, "@E 9,999,999.99"))
				aAdd (aTipo3, IntToDec ((cArqTip3)->BASEIPI, "@E 9,999,999.99"))
				aAdd (aTipo3, IntToDec ((cArqTip3)->VALIPI, "@E 9,999,999.99"))
				aAdd (aTipo3, IntToDec ((cArqTip3)->FATOR, "@E 999,999.999", 3))
				aAdd (aTipo3, IntToDec ((cArqTip3)->QTDEUNIPAD, "@E 999,999.999", 3))
				aAdd (aTipo3, (cArqTip3)->NUMERODI)
				//
				FmtLin (aTipo3, aLayMatr[10]+aLayMatr[14], cPict,, @nLin)
				//				
				(cArqTip3)->(Dbskip ())
				aTipo3	:=	{}
			EndDo
			FmtLin ({}, aLayMatr[19]+aLayMatr[18], cPict,, @nLin)
		EndIf	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Impriminto Registro Tipo 2 - Itens das notas fiscais de saida.  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbSelectArea (cArqTip2)
		IndRegua (cArqTip2, cArqTip2, "CFOP+NOTA+SERIE+EMISSAO",,, STR0021) //"Indexando Arquivo."
		(cArqTip2)->(DbGoTop ())
		//
		If !(cArqTip2)->(Eof ())
			nLin++
			FmtLin ({}, aLayMatr[22], cPict,, @nLin)
			FmtLin ({}, aLayMatr[19], cPict,, @nLin)
			FmtLin ({}, aLayMatr[9], cPict,, @nLin)
			FmtLin ({}, aLayMatr[19], cPict,, @nLin)
			//
			Do While !(cArqTip2)->(Eof ())
				If Interrupcao(@lAbortPrint)
					Exit
				Endif
				//
				If nLin>=55
					nLin	:=	cabec(Titulo, "", Cabec2, NomeProg, Tamanho, nTipo)
					nLin++
				EndIf
				//
				nPos	:=	aScan (aIdent, {|aX| aX[1]==(cArqTip2)->CFOP+(cArqTip2)->CNPJ+(cArqTip2)->NOTA+(cArqTip2)->SERIE})
				//
				aAdd (aTipo2, Iif (nPos==0, "", StrZero (aIdent[nPos][2], 10)))
				aAdd (aTipo2, (cArqTip2)->ITEM)
				aAdd (aTipo2, Left (AllTrim ((cArqTip2)->CODMERC), 15))
				aAdd (aTipo2, Left (AllTrim (A977Chk((cArqTip2)->DESMERC)), 40))
				aAdd (aTipo2, (cArqTip2)->NCM)
				If MV_PAR08==2
					aAdd (aTipo2, (cArqTip2)->PRODDNF)
				Else
					aAdd (aTipo2, (cArqTip2)->ESPECIE)
				EndIf
				aAdd (aTipo2, (cArqTip2)->CFOP)
				If (MV_PAR08==1)
					aAdd (aTipo2, (cArqTip2)->CODUNID)
				Else
					aAdd (aTipo2, "")
				EndIf
				aAdd (aTipo2, IntToDec ((cArqTip2)->QUANTIDADE, "@E 999,999.999", 3))
				aAdd (aTipo2, IntToDec ((cArqTip2)->VALUNIT, "@E 999,999.9999", 4))
				aAdd (aTipo2, IntToDec ((cArqTip2)->VALTOT, "@E 9,999,999.99"))
				aAdd (aTipo2, IntToDec ((cArqTip2)->BASEIPI, "@E 9,999,999.99"))
				aAdd (aTipo2, IntToDec ((cArqTip2)->VALIPI, "@E 9,999,999.99"))
				aAdd (aTipo2, IntToDec ((cArqTip2)->FATOR, "@E 999,999.999", 3))
				aAdd (aTipo2, IntToDec ((cArqTip2)->QTDEUNIPAD, "@E 999,999.999", 3))
				//
				FmtLin (aTipo2, aLayMatr[10], cPict,, @nLin)
				//				
				(cArqTip2)->(Dbskip ())
				aTipo2	:=	{}
			EndDo
			FmtLin ({}, aLayMatr[19], cPict,, @nLin)
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Registro de controle - Registro tipo 9³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nLin++
		nTotContr	:=	1+(cArqTip1)->(LastRec ())+(cArqTip2)->(LastRec ())+(cArqTip3)->(LastRec ())+1
		//
		FmtLin ({}, aLayMatr[07], cPict,, @nLin)
		FmtLin ({}, aLayMatr[11], cPict,, @nLin)
		FmtLin ({Transform (nTotContr, "@E 999,999,999")}, aLayMatr[08], cPict,, @nLin)
		FmtLin ({}, aLayMatr[11], cPict,, @nLin)
	Endif	
	//
Return (lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³LayMatr   ³ Autor ³Gustavo G. Rueda       ³ Data ³13.04.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao para montar o layout de impressao no array.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpA -> aLayMatr = Array contendo o layout.                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³MATA977                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function LayMatr ()
	Local	aLayMatr	:=	{}

	       		      			//    "         1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22"
			                  	//    "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	aAdd (aLayMatr, STR0007)	//01- "INFORMACOES DO CONTRIBUINTE - Registro Tipo 0."
	aAdd (aLayMatr, STR0008)	//02- "|CNPJ/MF:           |EMPRESA:                                |MES/ANO REF.: |VER LAYOUT|"
	aAdd (aLayMatr, STR0009)	//03- "|###################|########################################| ##/####      | ######## |"
	aAdd (aLayMatr, STR0010)	//04- "|          |                   |          |          |          |    |            |            |            |    |    |Documentos Vinculados|"
	aAdd (aLayMatr, STR0011)	//05- "|Ident.Reg.|CNPJ/MF ADQUIRENTE |NR  NF/SER|DT EMISSAO|DT ENTRADA|CFOP|VLR NF      |VLR IPI     |   ISENTO   |CANC|COMP|NR  NF/SER|EMISSAO NF|"
	aAdd (aLayMatr, STR0012)	//06- "|##########|###################|######/###|##########|##########|####|############|############|############|### |### |######/###|##########|"
	aAdd (aLayMatr, STR0013)	//07- "Dados de controle - Registro tipo 9."
	aAdd (aLayMatr, STR0014)	//08- "|Total de registros: ############  |"
	aAdd (aLayMatr, STR0015)	//09- "|Ident.Reg.|IT.|COD. MERCADORIA|DESC.MERCADORIA                              |NCM     |CP |CFOP|UM        |QUANTIDADE  |VLR. UNIT.  |VLR TOT IT  |BASE IPI    |VLR IPI     |FAT CONVERS |QTD UM ESTAT|"
	aAdd (aLayMatr, STR0016)	//10- "|##########|###|###############|#############################################|########|###|####|##########|############|############|############|############|############|############|############|"
	aAdd (aLayMatr, STR0017)	//11- "+----------------------------------+"
	aAdd (aLayMatr, STR0018)	//12- ""
	aAdd (aLayMatr, STR0019)	//13- "NUMERO  DI|"
	aAdd (aLayMatr, STR0020)	//14- "##########|"
	aAdd (aLayMatr, STR0022)	//15- "+-------------------+----------------------------------------+--------------+----------+"
	aAdd (aLayMatr, STR0023)	//16- "MESTRE DOS DOCUMENTOS FISCAIS DE ENTRADA - Registro Tipo 1."
	aAdd (aLayMatr, STR0024)	//17- "MESTRE DOS DOCUMENTOS FISCAIS DE SAIDA - Registro Tipo 1."
	aAdd (aLayMatr, STR0025)	//18- "----------+"
	aAdd (aLayMatr, STR0026)	//19- "+---+---------------+---------------------------------------------+--------+---+----+----------+------------+------------+------------+------------+------------+------------+------------+"
	aAdd (aLayMatr, STR0027)	//20- "+----------+-------------------+----------+----------+----------+----+------------+------------+------------+----+----+----------+----------+"
	aAdd (aLayMatr, STR0028)	//21- "ITENS DOS DOCUMENTOS FISCAIS DE ENTRADA - Registro Tipo 3."
	aAdd (aLayMatr, STR0029)	//22- "ITENS DOS DOCUMENTOS FISCAIS DE SAIDA - Registro Tipo 2."
	aAdd (aLayMatr, STR0030)	//23- "DADOS DA NOTA FISCAL - Registro Tipo 0."
	aAdd (aLayMatr, STR0031)	//24- "DADOS DOS ITENS (PRODUTOS) DA NOTA FISCAL - Registro Tipo 1."
	aAdd (aLayMatr, STR0032)	//25- "INFORMACOES DO CONTRIBUINTE."
	aAdd (aLayMatr, STR0033)	//26- "|Ident.Reg.|CNPJ/MF EMITENTE   |NR  NF/SER|DT EMISSAO|IT.|COD. |CP   |CFOP        |UNIDADE                       |QUANTIDADE  | VL UNIT.   | VLR TOTAL  |A. IPI|QTD UM ESTAT|" 
	aAdd (aLayMatr, STR0034)	//27- "|##########|###################|######/###|##########|###|#####|#####|############|##############################|############|############|############|######|############|"
	aAdd (aLayMatr, STR0035)	//28- "|          |                   |          |          |   |     |     |            |                              |            |            |            |      |            |"
	aAdd (aLayMatr, STR0036)	//29- "+----------+-------------------+----------+----------+---+-----+-----+------------+------------------------------+------------+------------+------------+------+------------+"
	aAdd (aLayMatr, STR0037)	//30- "|CNPJ/MF EMITENTE   |NR  NF/SER|DT EMISSAO|DT SAIDA  |CNPJ/MF DESTINATARIO|"
	aAdd (aLayMatr, STR0038)	//31- "|                   |          |          |          |                    |" 
	aAdd (aLayMatr, STR0039)	//32- "|###################|######/###|##########|##########|####################|"
	aAdd (aLayMatr, STR0040)	//33- "+-------------------+----------+----------+----------+--------------------|"
	aAdd (aLayMatr, STR0041)	//34- "|QTD REGISTRO 0|QTD REGISTRO 1|NR VOLUME|QTD DE VOLUMES|" 
	aAdd (aLayMatr, STR0042)	//35- "| #############| #############| ########| #############|"
	aAdd (aLayMatr, STR0043)	//36- "|              |              |         |              |"
	aAdd (aLayMatr, STR0044)	//37- "+--------------+--------------+---------+--------------+"



Return (aLayMatr)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³IntToDec  ³ Autor ³Gustavo G. Rueda       ³ Data ³16.04.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao para conversao dos valores gravados nos TRB's para   ³±±
±±³          ³ numeros com casas decimais.                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³NExp -> nDec - numero convertido.                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³NExp -> nInt - Numero a ser convertido.                     ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³MATR918                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function IntToDec (cInt, cMask, nDec)
	Local		cDec	:=	""
	//
	nDec := Iif (nDec==Nil, 2, nDec)
	//
	cDec	:=	Transform (Val (Left (AllTrim (cInt), Len (AllTrim (cInt))-nDec)+"."+Right (AllTrim (cInt), nDec)), cMask)
Return (cDec)   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao   ³ApagTempor ºAutor  ³ Sueli C.dos Santos º Data ³  18/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.    ³ Apaga arquivos temporarios criados para gerar o arquivo     º±±
±±º         ³ Magnetico                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso      ³                                                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±  
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/         

User Function ApagTempor(cAls)

If cAls=="R00"
	dbSelectArea("R00")
	dbCloseArea()
	Ferase("R00"+GetDBExtension())
	Ferase("R00"+OrdBagExt())
Endif

If cAls=="R01"
	dbSelectArea("R01")
	dbCloseArea()
	Ferase("R01"+GetDBExtension())
	Ferase("R01"+OrdBagExt())
Endif

Return
