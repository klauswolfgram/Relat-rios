/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Protheus.Ch"
#Include "MATR922.Ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MATR922   ³ Autor ³Gustavo G. Rueda       ³ Data ³08.07.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³RIO - Relatorio de Informacoes Operacionais                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL1 -> lRet = Retorno sempre .T.                          ³±±
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
User Function MATR922 ()
	Local	cArqCfp		:=	"RELRIO.CFP"	//Arquivo .CFP que contem o nome das pastas que identificam oa classificacao de determinados produtos.
	Local	nOpca		:=	0
	Local 	NomeProg	:= 	"RELRIO"
	Local 	aArea		:= 	GetArea ()
	Local 	cPerg		:= 	"RELRIO"
	Local	lRet		:=	.T.
	Local 	cTitulo  	:= STR0001	//"Relatorio de Informacoes Operacionais - RIO."
	Local 	cDesc1  	:= STR0002	//"Este relatorio imprime a listagem de acompanhamento dos meios-magnetivos"
	Local 	cDesc2  	:= ""
	Local 	cDesc3  	:= ""
	Local 	wnrel   	:= NomeProg
	Local	cString		:=	""
	Local 	Tamanho 	:= 	"P" 	// P/M/G
	Local	nCompLinha	:=	248		//Caracteres de cada linha gerada no ARQGRV.CFP
	Local 	lVerpesssen := Iif(FindFunction("Verpesssen"),Verpesssen(),.T.)
	Private Limite 	:= 	80		// 80/132/220
	Private lEnd    	:= 	.F.		// Controle de cancelamento do relatorio
	Private m_pag   	:= 	1  		// Contador de Paginas
	Private nLastKey	:=	0  		// Controla o cancelamento da SetPrint e SetDefault
	Private aReturn 	:= {STR0003, 1, STR0004, 2, 2, 1, "", 1 }	//"Zebrado"###"Administracao"
	//
	If lVerpesssen
		Pergunte (cPerg, .F.)
		//
		FormBatch (OemToAnsi (STR0001),;
			{OemToAnsi (STR0005),;
			OemToAnsi (STR0006),;
			OemToAnsi (STR0007),;
			OemToAnsi (STR0008),;
			OemToAnsi (STR0024)},;
		{{05, .T., {|o| nOpca := 0, Pergunte (cPerg, .T.)}},;	//Configura as perguntas adicionais da rotina.
		{ 11, .T., {|o| nOpca := 1, CfpRio (cArqCfp, nCompLinha)}},;			//Configura o formato do relatorio de acordo com os folders identificados na primeira tela em seguida ao clique.
		{ 01, .T., {|o| nOpca := 2, o:oWnd:End()}},;
		{ 02, .T., {|o| nOpca := 3, o:oWnd:End()}}})
		//
		If (nOpca==3)
			Return (lRet)
		EndIf
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
		RptStatus ({|lEnd| MontRIO (@lEnd, cArqCfp, nCompLinha)}, cTitulo)
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
	EndIf
	
Return (lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MontRio   ³ Autor ³Gustavo G. Rueda       ³ Data ³08.07.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao de processamento para montagem da estrutura dos TRB's³±±
±±³          ³  utilizado na geracao do relatorio.                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL1                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpL -> lEnd - Indica se a operacao foi cancelada.          ³±±
±±³          ³ExpC -> Nome do arquivo .CFP que contem os folders.         ³±±
±±³          ³ExpN -> nCompLinha = Qtd caracteres de cada linha do CFP    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MontRIO (lEnd, cArqCfp, nCompLinha)
	Local		lRet		:=	.T.
	Local		cQuery		:=	""
	Local		cChave		:=	""
	Local		cIndSd3		:=	""
	Local		aInfCfp		:=	{}
	Local		aTrb		:=	CriaDelTrb (1)	//Funcao de criacao das estruturas dos TRB's temporarios.
	Local		cArqGrvRIo	:=	"ARQGRV.CFP"	//Nome do arquivo .CFP de configuracao do relatorio.
	Local		aColsX		:=	{}
	Local		nQtdFolders	:=	0
	Local		nX			:=	0
	Local		aArqCfp		:=	LeCfpRio (cArqCfp)	//Funcao utilizada para armazenar o .CFP inicial(que contem os folders utilizados na outra tela) em um array.
	Private	cAlsSd3		:=	"SD3"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Processo o array que contem a qtd de folders utilizados na estrutura do relatorio.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nX := 1 To Len (aArqCfp)
		If !(Empty (aArqCfp[nX][2]))
			nQtdFolders++
		EndIf
	Next (nX)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializo o array aColsX utilizado no filtro para determinados produtos conforme mensionado na tela de configuracao do relatorio.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aColsX	:=	Array (nQtdFolders)
	For nX := 1 To nQtdFolders
		aColsX[nX] 		:= {}
 	Next (nX)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Funcao de atualizacao do conteudo do array aColsX com a estrutura de configuracao do relatorio conforme arquivo ARQGRV.CFP contido no sigaadv.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	LoadRio (cArqGrvRIo, 2, @aColsX, nQtdFolders, nCompLinha)
	//	
	#IFDEF TOP
		If (TcSrvType ()<>"AS/400")
		    cAlsSd3	:= 	"MontRIO"
			//
			cQuery	:=	"SELECT "
			cQuery	+=	"SD3.D3_FILIAL, SD3.D3_COD, SD3.D3_QUANT, SD3.D3_UM, SD3.D3_SEGUM, SB1.B1_CONV "
			cQuery	+=	"FROM "
			cQuery	+=	RetSqlName("SD3")+" SD3, "+RetSqlName("SB1")+" SB1 "
			cQuery	+=	"WHERE "
			//
			//Join SB1
			cQuery	+=	"SD3.D3_FILIAL='"+xFilial ("SD3")+"' AND SB1.B1_FILIAL='"+xFilial ("SB1")+"' AND SD3.D3_COD=SB1.B1_COD AND "
			//
			//Where
			cQuery	+=	"SD3.D3_FILIAL='"+xFilial ("SD3")+"' AND "
			cQuery	+=	"SD3.D3_EMISSAO>='"+DToS (MV_PAR01)+"' AND "
			cQuery	+=	"SD3.D3_EMISSAO<='"+DToS (MV_PAR02)+"' AND "
			cQuery	+=	"SD3.D3_CF IN ('PR0', 'PR1') AND "
			cQuery	+=	"SD3.D3_ESTORNO NOT IN ('S') AND "
			cQuery	+=	"SD3.D_E_L_E_T_='' AND SB1.D_E_L_E_T_='' "
			//
			cQuery 	:= 	ChangeQuery (cQuery)
	    	//
			DbUseArea (.T., "TOPCONN", TcGenQry (,,cQuery), cAlsSd3, .T., .T.)
		Else
	#ENDIF	 
			DbSelectArea (cAlsSd3)
			cIndSd3		:=	CriaTrab (NIL,.F.)
			cChave		:=	IndexKey ()
			cQuery		:=	"SD3->D3_FILIAL=='"+xFilial ("SD3")+"' "
			cQuery		+=	".And. (DToS (SD3->D3_EMISSAO)>='"+DToS (MV_PAR01)+"') .And. (DToS (SD3->D3_EMISSAO)<='"+DToS (MV_PAR02)+"') "
			cQuery		+=	".And.  AllTrim (SD3->D3_CF)$'PR0/PR1' .And. !'S'$SD3->D3_ESTORNO "
			//
			IndRegua (cAlsSd3, cIndSd3, cChave,, cQuery, STR0025)
	#IFDEF TOP
		Endif
	#ENDIF
	//
	DbSelectArea (cAlsSd3)
		SetRegua ((cAlsSd3)->(LastRec ()))
	(cAlsSd3)->(DbGoTop ())
	Do while !(cAlsSd3)->(Eof ())
		//
		IncRegua ()
		If Interrupcao(lEnd)
			Return (lRet)
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³informacoes de realizacoes para o quadro B.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aInfCfp	:=	{}
		aInfCfp	:=	VerGrupoPr (aColsX, cAlsSd3)	//Funcao utilizada para validar o grupo do produto com o digitado na tela de configuracao do relatorio. Tambem retorna algumas informacoes configuradas.
		If (Len (aInfCfp)>0)
			#IFNDEF TOP		
				DbSelectArea ("SB1")
					SB1->(DbSelectArea (1))
				SB1->(DbSeek (xFilial ("SB1")+(cAlsSd3)->D3_COD))
			#ENDIF
			//
			DbSelectArea (aTrb[1][1])
			If ((aTrb[1][1])->(DbSeek (aInfCfp[1]+aInfCfp[2])))
				RecLock (aTrb[1][1], .F.)
					#IFDEF TOP
						(aTrb[1][1])->TRB_QUANT	+=	(cAlsSd3)->D3_QUANT*(cAlsSd3)->B1_CONV
					#ELSE
						(aTrb[1][1])->TRB_QUANT	+=	(cAlsSd3)->D3_QUANT*SB1->B1_CONV
					#ENDIF
				MsUnLock ()
			Else
				nPos	:=	aScan (aArqCfp, {|aArq| AllTrim (aInfCfp[1])$aArq[1]})
				//
				DbSelectArea (aTrb[1][1])
				RecLock (aTrb[1][1], .T.)
					(aTrb[1][1])->TRB_CODGRP	:=	aInfCfp[1]
					(aTrb[1][1])->TRB_DESGRP	:=	aArqCfp[nPos][2]
					(aTrb[1][1])->TRB_CODITE	:=	aInfCfp[2]
					(aTrb[1][1])->TRB_DESITE	:=	aInfCfp[3]
					#IFDEF TOP
						(aTrb[1][1])->TRB_QUANT	:=	(cAlsSd3)->D3_QUANT*(cAlsSd3)->B1_CONV
					#ELSE
						(aTrb[1][1])->TRB_QUANT	:=	(cAlsSd3)->D3_QUANT*SB1->B1_CONV
					#ENDIF
					(aTrb[1][1])->TRB_UM  		:=	(cAlsSd3)->D3_UM
					(aTrb[1][1])->TRB_SEGUM	:=	(cAlsSd3)->D3_SEGUM
				MsUnLock ()
			EndIf
		EndIf
		//
		DbSelectArea (cAlsSd3)
		(cAlsSd3)->(DbSkip ())
	EndDo			
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Prodcessamento do TRB para o quadro C envolvendo as notas fiscais de saida.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	GerQuaCS (lEnd, aTrb)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Prodcessamento do TRB para o quadro C envolvendo as notas fiscais de entrada.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	GerQuaCE (lEnd, aTrb)
	//
	ImpRio (aTrb)	//Geracao do relatorio em spool
	//
	CriaDelTrb (2, aTrb)	//Apago todos os temporarios criados pela rotina.
	//
	#IFDEF TOP
		(cAlsSd3)->(DbCloseArea ())
	#ENDIF
Return (lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³GerQuaCS  ³ Autor ³Gustavo G. Rueda       ³ Data ³15.07.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gera informacoes das Notas Fiscais de Saida para o quadro   ³±±
±±³          ³ C e armazena no TRC para futuros processamentos.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL -> lRet = .T./.F.                                      ³±±
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
Static Function GerQuaCS (lEnd, aTrb)
	Local	lRet		:=	.T.
	Local	cAlsSf2		:=	"SF2"
	Local	cQuery		:=	""
	Local	cChave		:=	""
	Local	cIndSf2		:=	""
	Local	cDescPais	:=	""
	Local	cQuadroC	:=	""
	//	
	#IFDEF TOP
		If (TcSrvType ()<>"AS/400")
		    cAlsSf2	:= 	"GerQuaC"
			//
			cQuery	:=	"SELECT "
			cQuery	+=	"SF2.F2_FILIAL,SF2.F2_DOC,SF2.F2_SERIE,SF2.F2_CLIENTE,SF2.F2_LOJA,SF2.F2_EMISSAO,SD2.D2_TES,SD2.D2_CF,SD2.D2_COD,SD2.D2_QUANT,SD2.D2_UM,SD2.D2_SEGUM,SA1.A1_EST,SA1.A1_PAIS,SB1.B1_CONV "
			cQuery	+=	"FROM "
			cQuery	+=	RetSqlName("SF2")+" SF2, "+RetSqlName("SD2")+" SD2, "+RetSqlName("SF4")+" SF4, "+RetSqlName("SA1")+" SA1, "+RetSqlName("SB1")+" SB1 "
			cQuery	+=	"WHERE 
			//
			//Join SD2
			cQuery	+=	"SF2.F2_FILIAL='"+xFilial ("SF2")+"' AND "
			cQuery	+=	"SD2.D2_FILIAL='"+xFilial ("SD2")+"' AND "
			cQuery	+=	"SF2.F2_DOC=SD2.D2_DOC AND "
			cQuery	+=	"SF2.F2_SERIE=SD2.D2_SERIE AND "
			cQuery	+=	"SF2.F2_CLIENTE=SD2.D2_CLIENTE AND "
			cQuery	+=	"SF2.F2_LOJA=SD2.D2_LOJA AND "
			//
			//join SF4
			cQuery	+=	"SF4.F4_FILIAL='"+xFilial ("SF4")+"' AND "
			cQuery	+=	"SF4.F4_CODIGO=SD2.D2_TES AND "
			//
			//join SA1
			cQuery	+=	"SA1.A1_FILIAL='"+xFilial ("SA1")+"' AND "
			cQuery	+=	"SA1.A1_COD=SF2.F2_CLIENTE AND "
			cQuery	+=	"SA1.A1_LOJA=SF2.F2_LOJA AND "
			//
			//join SB1
			cQuery	+=	"SD2.D2_FILIAL='"+xFilial ("SD2")+"' AND "
			cQuery	+=	"SB1.B1_FILIAL='"+xFilial ("SB1")+"' AND "
			cQuery	+=	"SD2.D2_COD=SB1.B1_COD AND "
			//
			//Where
			cQuery	+=	"SF2.F2_FILIAL='"+xFilial ("SF2")+"' AND SF4.F4_DUPLIC IN ('S') AND "
			cQuery	+=	"SF2.F2_EMISSAO>='"+DToS (MV_PAR01)+"' AND "
			cQuery	+=	"SF2.F2_EMISSAO<='"+DToS (MV_PAR02)+"' AND "
			cQuery	+=	"SF2.F2_TIPO NOT IN ('C', 'B', 'D') AND "
			cQuery	+=	"SUBSTRING(SD2.D2_CF, 1, 1) IN ('6', '7') AND "
			cQuery	+=	"SF2.D_E_L_E_T_='' AND SD2.D_E_L_E_T_='' AND SF4.D_E_L_E_T_='' AND SA1.D_E_L_E_T_='' AND SB1.D_E_L_E_T_='' "
			//
			cQuery 	:= 	ChangeQuery (cQuery)
	    	//
			DbUseArea (.T., "TOPCONN", TcGenQry (,,cQuery), cAlsSF2, .T., .T.)
		Else
	#ENDIF	 
			DbSelectArea (cAlsSf2)
			cIndSf2		:=	CriaTrab (NIL,.F.)
			cChave		:=	IndexKey ()
			cQuery		:=	"SF2->F2_FILIAL=='"+xFilial ("SF2")+"' "
			cQuery		+=	".And. (DToS(SF2->F2_EMISSAO)>='"+DToS (MV_PAR01)+"') .And. (DToS (SF2->F2_EMISSAO)<='"+DToS (MV_PAR02)+"') "
			cQuery		+=	".And. !SF2->F2_TIPO$'CBD' "
			//
			IndRegua (cAlsSf2, cIndSf2, cChave,, cQuery, STR0025)
	#IFDEF TOP
		Endif
	#ENDIF
	//
	DbSelectArea (cAlsSf2)
		SetRegua ((cAlsSf2)->(LastRec ()))
	(cAlsSf2)->(DbGoTop ())
	Do while !(cAlsSf2)->(Eof ())
		//
		IncRegua ()
		If Interrupcao(lEnd)
			Return (lRet)
		Endif
		//
		#IFNDEF TOP
			DbSelectArea ("SA1")
				SA1->(DbSetOrder (1))
			SA1->(DbSeek (xFilial ("SA1")+(cAlsSf2)->F2_CLIENTE+(cAlsSf2)->F2_LOJA))
			//
			DbSelectArea ("SYA")
				SYA->(DbSetOrder (1))
			cDescPais	:=	Space (20)
			If (SYA->(DbSeek (xFilial ("SYA")+SA1->A1_PAIS)))
				cDescPais	:=	SubStr (SYA->YA_DESCR, 1, 20)
			EndIf
			//
			DbSelectArea ("SD2")
				SD2->(DbSetOrder (3))
			SD2->(DbSeek (xFilial ("SD2")+(cAlsSf2)->F2_DOC+(cAlsSf2)->F2_SERIE+(cAlsSf2)->F2_CLIENTE+(cAlsSf2)->F2_LOJA))
			//
			Do While !SD2->(Eof ()) .And. (xFilial ("SF2")==xFilial ("SD2")) .And. ((cAlsSf2)->F2_DOC==SD2->D2_DOC) .And.;
				((cAlsSf2)->F2_SERIE==SD2->D2_SERIE) .And. ((cAlsSf2)->F2_CLIENTE==SD2->D2_CLIENTE) .And. ((cAlsSf2)->F2_LOJA==SD2->D2_LOJA)
				//
				DbSelectArea ("SF4")
					SF4->(DbSetOrder (1))
				SF4->(DbSeek (xFilial ("SF4")+SD2->D2_TES))
				If !("S"$SF4->F4_DUPLIC)
					SD2->(DbSkip ())
					Loop
				EndIf
				//
				DbSelectArea ("SB1")
					SB1->(DbSelectArea (1))
				SB1->(DbSeek (xFilial ("SB1")+SD2->D2_COD))
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Gravo as informacoes de comercializacao para o quadro C³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If (SubStr (AllTrim (SD2->D2_CF), 1, 1)$"67")
					cQuadroC	:=	""
					If (SubStr (AllTrim (SD2->D2_CF), 1, 1)$"6")
						cQuadroC	:=	"1"
					Else
						cQuadroC	:=	"2"
					EndIf
					//
					DbSelectArea (aTrb[2][1])
					If ((aTrb[2][1])->(DbSeek (cQuadroC+cDescPais+SA1->A1_EST+SD2->D2_COD+"E")))
						RecLock (aTrb[2][1], .F.)
							(aTrb[2][1])->TRC_QUANT	+=	SD2->D2_QUANT*SB1->B1_CONV
						MsUnLock ()
					Else
						RecLock (aTrb[2][1], .T.)
							(aTrb[2][1])->TRC_ITQC		:=	cQuadroC
							(aTrb[2][1])->TRC_PAIS		:=	cDescPais
							(aTrb[2][1])->TRC_UF		:=	SA1->A1_EST
							(aTrb[2][1])->TRC_PROD		:=	SD2->D2_COD
							(aTrb[2][1])->TRC_IMPEXP	:=	"E"
							(aTrb[2][1])->TRC_QUANT	:=	SD2->D2_QUANT*SB1->B1_CONV
							(aTrb[2][1])->TRC_UM  		:=	SD2->D2_UM
							(aTrb[2][1])->TRC_SEGUM	:=	SD2->D2_SEGUM
						MsUnLock ()
					EndIf
				EndIf
				//
				DbSelectArea ("SD2")
				SD2->(DbSkip ())
			EndDo			
		#ELSE
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³informacoes de realizacoes para o quadro B.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DbSelectArea ("SYA")
				SYA->(DbSetOrder (1))
			cDescPais	:=	Space (20)
			If (SYA->(DbSeek (xFilial ("SYA")+(cAlsSf2)->A1_PAIS)))
				cDescPais	:=	SubStr (SYA->YA_DESCR, 1, 20)
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Gravo as informacoes de comercializacao para o quadro C³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If (SubStr (AllTrim ((cAlsSf2)->D2_CF), 1, 1)$"67")
				cQuadroC	:=	""
				If (SubStr (AllTrim ((cAlsSf2)->D2_CF), 1, 1)$"6")
					cQuadroC	:=	"1"
				Else
					cQuadroC	:=	"2"
				EndIf
				//
				DbSelectArea (aTrb[2][1])
				If ((aTrb[2][1])->(DbSeek (cQuadroC+cDescPais+(cAlsSf2)->A1_EST+(cAlsSf2)->D2_COD+"E")))
					RecLock (aTrb[2][1], .F.)
						(aTrb[2][1])->TRC_QUANT	+=	(cAlsSf2)->D2_QUANT*(cAlsSf2)->B1_CONV
					MsUnLock ()
				Else
					RecLock (aTrb[2][1], .T.)
						(aTrb[2][1])->TRC_ITQC		:=	cQuadroC
						(aTrb[2][1])->TRC_PAIS		:=	cDescPais
						(aTrb[2][1])->TRC_UF		:=	(cAlsSf2)->A1_EST
						(aTrb[2][1])->TRC_PROD		:=	(cAlsSf2)->D2_COD
						(aTrb[2][1])->TRC_IMPEXP	:=	"E"
						(aTrb[2][1])->TRC_QUANT	:=	(cAlsSf2)->D2_QUANT*(cAlsSf2)->B1_CONV
						(aTrb[2][1])->TRC_UM  		:=	(cAlsSf2)->D2_UM
						(aTrb[2][1])->TRC_SEGUM	:=	(cAlsSf2)->D2_SEGUM
					MsUnLock ()
				EndIf
			EndIf
		#ENDIF	
		//
		(cAlsSf2)->(DbSkip ())
	EndDo
	//
	#IFDEF TOP
		(cAlsSf2)->(DbCloseArea ())
	#ENDIF
Return (lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³GerQuaCE  ³ Autor ³Gustavo G. Rueda       ³ Data ³15.07.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gera informacoes das Notas Fiscais de Entrada para o quadro ³±±
±±³          ³ C e armazena no TRC para futuros processamentos.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL -> lRet = .T./.F.                                      ³±±
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
Static Function GerQuaCE (lEnd, aTrb)
	Local	cAlsSf1		:=	"SF1"
	Local	cIndSf1		:=	""
	Local	cQuery		:=	""
	Local	cChave		:=	""
	Local	lRet		:=	.T.
	Local	cDescPais	:=	""
	Local	cQuadroC	:=	""
	//
	#IFDEF TOP
		If (TcSrvType ()<>"AS/400")
		    cAlsSf1	:= 	"GerQuaC"
			//
			cQuery	:=	"SELECT "
			cQuery	+=	"SF1.F1_FILIAL,SF1.F1_DOC,SF1.F1_SERIE,SF1.F1_FORNECE,SF1.F1_LOJA,SF1.F1_EMISSAO,SD1.D1_TES,SD1.D1_CF,SD1.D1_COD,SD1.D1_QUANT,SD1.D1_UM,SD1.D1_SEGUM,SA2.A2_EST,SA2.A2_PAIS,SB1.B1_CONV "
			cQuery	+=	"FROM "
			cQuery	+=	RetSqlName("SF1")+" SF1, "+RetSqlName("SD1")+" SD1, "+RetSqlName("SF4")+" SF4, "+RetSqlName("SA2")+" SA2, "+RetSqlName("SB1")+" SB1 "
			cQuery	+=	"WHERE "
			//
			//Join SD1
			cQuery	+=	"SF1.F1_FILIAL='"+xFilial ("SF1")+"' AND "
			cQuery	+=	"SD1.D1_FILIAL='"+xFilial ("SD1")+"' AND "
			cQuery	+=	"SF1.F1_DOC=SD1.D1_DOC AND "
			cQuery	+=	"SF1.F1_SERIE=SD1.D1_SERIE AND "
			cQuery	+=	"SF1.F1_FORNECE=SD1.D1_FORNECE AND "
			cQuery	+=	"SF1.F1_LOJA=SD1.D1_LOJA AND "
			//
			//Join SF4
			cQuery	+=	"SF4.F4_FILIAL='"+xFilial ("SF4")+"' AND "
			cQuery	+=	"SF4.F4_CODIGO=SD1.D1_TES AND "
			//
			//Join SA2
			cQuery	+=	"SA2.A2_FILIAL='"+xFilial ("SA2")+"' AND "
			cQuery	+=	"SA2.A2_COD=SF1.F1_FORNECE AND "
			cQuery	+=	"SA2.A2_LOJA=SF1.F1_LOJA AND "
			//
			//Join SB1
			cQuery	+=	"SD1.D1_FILIAL='"+xFilial ("SD1")+"' AND "
			cQuery	+=	"SB1.B1_FILIAL='"+xFilial ("SB1")+"' AND "
			cQuery	+=	"SD1.D1_COD=SB1.B1_COD AND "
			//
			//Where
			cQuery	+=	"SF1.F1_FILIAL='"+xFilial ("SF1")+"' AND SF4.F4_DUPLIC IN ('S') AND "
			cQuery	+=	"SF1.F1_EMISSAO>='"+DToS (MV_PAR01)+"' AND "
			cQuery	+=	"SF1.F1_EMISSAO<='"+DToS (MV_PAR02)+"' AND "
			cQuery	+=	"SF1.F1_TIPO NOT IN ('C', 'B', 'D') AND "
			cQuery	+=	"SUBSTRING(SD1.D1_CF, 1, 1) IN ('2', '3') AND "
			cQuery	+=	"SF1.D_E_L_E_T_='' AND SD1.D_E_L_E_T_='' AND SF4.D_E_L_E_T_='' AND SA2.D_E_L_E_T_='' AND SB1.D_E_L_E_T_='' "
			//
			cQuery 	:= 	ChangeQuery (cQuery)
	    	//
			DbUseArea (.T., "TOPCONN", TcGenQry (,,cQuery), cAlsSF1, .T., .T.)
		Else
	#ENDIF	 
			DbSelectArea (cAlsSf1)
			cIndSf1		:=	CriaTrab (NIL,.F.)
			cChave		:=	IndexKey ()
			cQuery		:=	"SF1->F1_FILIAL=='"+xFilial ("SF1")+"' "
			cQuery		+=	".And. (DToS(SF1->F1_EMISSAO)>='"+DToS (MV_PAR01)+"') .And. (DToS (SF1->F1_EMISSAO)<='"+DToS (MV_PAR02)+"') "
			cQuery		+=	".And. !SF1->F1_TIPO$'CBD' "
			//
			IndRegua (cAlsSf1, cIndSf1, cChave,, cQuery, "Selec.Notas fiscais...")
	#IFDEF TOP
		Endif
	#ENDIF
	//
	DbSelectArea (cAlsSf1)
		SetRegua ((cAlsSf1)->(LastRec ()))
	(cAlsSf1)->(DbGoTop ())
	Do While !(cAlsSf1)->(Eof ())
		//
		IncRegua ()
		If Interrupcao(lEnd)
			Return (lRet)
		Endif
		//
		#IFNDEF TOP
			DbSelectArea ("SA2")
				SA2->(DbSetOrder (1))
			SA2->(DbSeek (xFilial ("SA2")+(cAlsSf1)->F1_FORNECE+(cAlsSf1)->F1_LOJA))			
			//
			DbSelectArea ("SYA")
				SYA->(DbSetOrder (1))
			cDescPais	:=	Space (20)
			If (SYA->(DbSeek (xFilial ("SYA")+SA2->A2_PAIS)))
				cDescPais	:=	SubStr (SYA->YA_DESCR, 1, 20)
			EndIf
			//
			DbSelectArea ("SD1")
				SD1->(DbSetOrder (1))
			SD1->(DbSeek (xFilial ("SD1")+(cAlsSf1)->F1_DOC+(cAlsSf1)->F1_SERIE+(cAlsSf1)->F1_FORNECE+(cAlsSf1)->F1_LOJA))
			//
			Do While !SD1->(Eof ()) .And. (xFilial ("SF1")==xFilial ("SD1")) .And. ((cAlsSf1)->F1_DOC==SD1->D1_DOC) .And.;
				((cAlsSf1)->F1_SERIE==SD1->D1_SERIE) .And. ((cAlsSf1)->F1_FORNECE==SD1->D1_FORNECE) .And. ((cAlsSf1)->F1_LOJA==SD1->D1_LOJA)
				//
				DbSelectArea ("SF4")
					SF4->(DbSetOrder (1))
				SF4->(DbSeek (xFilial ("SF4")+SD1->D1_TES))
				If !("S"$SF4->F4_DUPLIC)
					SD1->(DbSkip ())
					Loop
				EndIf
				//
				DbSelectArea ("SB1")
					SB1->(DbSelectArea (1))
				SB1->(DbSeek (xFilial ("SB1")+SD1->D1_COD))
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Gravo as informacoes de comercializacao para o quadro C³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If (SubStr (AllTrim (SD1->D1_CF), 1, 1)$"23")
					cQuadroC	:=	""
					If (SubStr (AllTrim (SD1->D1_CF), 1, 1)$"2")
						cQuadroC	:=	"1"
					Else
						cQuadroC	:=	"2"
					EndIf
					//
					DbSelectArea (aTrb[2][1])	
					If ((aTrb[2][1])->(DbSeek (cQuadroC+cDescPais+SA2->A2_EST+SD1->D1_COD+"I")))
						RecLock (aTrb[2][1], .F.)
							(aTrb[2][1])->TRC_QUANT	+=	SD1->D1_QUANT*SB1->B1_CONV
						MsUnLock ()
					Else
						RecLock (aTrb[2][1], .T.)
							(aTrb[2][1])->TRC_ITQC		:=	cQuadroC
							(aTrb[2][1])->TRC_UF		:=	SA2->A2_EST
							(aTrb[2][1])->TRC_PAIS		:=	cDescPais
							(aTrb[2][1])->TRC_PROD		:=	SD1->D1_COD
							(aTrb[2][1])->TRC_IMPEXP	:=	"I"
							(aTrb[2][1])->TRC_QUANT	:=	SD1->D1_QUANT*SB1->B1_CONV
							(aTrb[2][1])->TRC_UM  		:=	SD1->D1_UM
							(aTrb[2][1])->TRC_SEGUM	:=	SD1->D1_SEGUM
						MsUnLock ()
					EndIf
				EndIf
				//
				DbSelectArea ("SD1")
				SD1->(DbSkip ())
			EndDo			
		#ELSE
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Gravo as informacoes de comercializacao para o quadro C³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DbSelectArea ("SYA")
				SYA->(DbSetOrder (1))
			cDescPais	:=	Space (20)
			If (SYA->(DbSeek (xFilial ("SYA")+(cAlsSf1)->A2_PAIS)))
				cDescPais	:=	SubStr (SYA->YA_DESCR, 1, 20)
			EndIf
			//
			If (SubStr (AllTrim ((cAlsSf1)->D1_CF), 1, 1)$"23")
				cQuadroC	:=	""
				If (SubStr (AllTrim ((cAlsSf1)->D1_CF), 1, 1)$"2")
					cQuadroC	:=	"1"
				Else
					cQuadroC	:=	"2"
				EndIf
				//
				DbSelectArea (aTrb[2][1])
				If ((aTrb[2][1])->(DbSeek (cQuadroC+cDescPais+(cAlsSf1)->A2_EST+(cAlsSf1)->D1_COD+"I")))
					RecLock (aTrb[2][1], .F.)
						(aTrb[2][1])->TRC_QUANT	+=	(cAlsSf1)->D1_QUANT*(cAlsSf1)->B1_CONV
					MsUnLock ()
				Else
					RecLock (aTrb[2][1], .T.)
						(aTrb[2][1])->TRC_ITQC		:=	cQuadroC
						(aTrb[2][1])->TRC_PAIS		:=	cDescPais
						(aTrb[2][1])->TRC_UF		:=	(cAlsSf1)->A2_EST
						(aTrb[2][1])->TRC_PROD		:=	(cAlsSf1)->D1_COD
						(aTrb[2][1])->TRC_IMPEXP	:=	"I"
						(aTrb[2][1])->TRC_QUANT	:=	(cAlsSf1)->D1_QUANT*(cAlsSf1)->B1_CONV
						(aTrb[2][1])->TRC_UM  		:=	(cAlsSf1)->D1_UM
						(aTrb[2][1])->TRC_SEGUM	:=	(cAlsSf1)->D1_SEGUM
					MsUnLock ()
				EndIf
			EndIf
		#ENDIF	
		//
		(cAlsSf1)->(DbSkip ())
	EndDo
	//
	#IFDEF TOP
		(cAlsSf1)->(DbCloseArea ())
	#ENDIF
Return (lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³VerGrupoPr³ Autor ³Gustavo G. Rueda       ³ Data ³08.07.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Utilizada para validar os produtos digitados na tela de     ³±±
±±³          ³  configuracao do relatorio.                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpA1 -> aInfCfp = Array contendo informacoes de gravacao   ³±±
±±³          ³  nos TRB's obitidas atraves do ARQGRV.CFP                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpA1 -> aColsX = Array contendo o ARQGRV.CFP.              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function VerGrupoPr (aColsX, cAlsSd3)
	Local	aInfCfp	:=	{}
	Local	nInd	:=	0
	Local	nY		:=	0
	Local	lAchou	:=	.F.
	//
	For nInd	:= 1 To Len (aColsX)
		For nY := 1 To Len (aColsX[nInd])
			If (AllTrim ((cAlsSd3)->D3_COD)$AllTrim (aColsX[nInd][nY][3]))
				aAdd (aInfCfp, aColsX[nInd][nY][1])	//Codigo Grupo
				aAdd (aInfCfp, aColsX[nInd][nY][2])	//Codigo Item do Grupo
				aAdd (aInfCfp, aColsX[nInd][nY][4])	//Descricao Item do Grupo
				aAdd (aInfCfp, aColsX[nInd][nY][5])	//Fator
				lAchou	:=	.T.
				Exit
			EndIf			
		Next (nY)
		//
		If (lAchou)
			Exit
		EndIf
	Next (nInd)	
Return (aInfCfp)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CfpRio    ³ Autor ³Gustavo G. Rueda       ³ Data ³08.07.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta o CFP que contera os folders para a tela de configura-³±±
±±³          ³ seguinte.                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL1 -> lRet = (.T./.F.) Retorno indica se foi conirmado ou³±±
±±³          ³ nao o processamento do CFP.                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1 -> cArqCfp = Variavel com o nome do arquivo CFP a ser ³±±
±±³          ³  gerado com os folders.                                    ³±±
±±³          ³ExpN -> nCompLinha = Qtd caracteres de cada linha do CFP    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CfpRio (cArqCfp, nCompLinha)
	Local 	cValid 		:= ""
	Local 	nI	 		:= 1
	Local 	nOpcA	 	:= 2
	Local 	oDlgGet
	Local	cBarra		:=	STR0026	//"Parametros adicionais da Rotina"
	Local	cTitJan		:=	STR0027	//"Entrar com os grupos de produtos respectivos a cada item."
	Local	aArqCfp		:=	{}
    //
	Private	aSel		:= {}
	Private 	aListBox	:= {}
	Private	aMsg	  	:= {}
	Private	aValid	  	:= {}
	Private	aConteudo 	:= {}
	//
	aAdd (aListBox, Upper (OemToAnsi (STR0028)))		; aAdd (aSel, .F.); aAdd (aMsg, "")					; aAdd (aValid, "") 	//"Titulos das pastas que se refere o Item B-Realizacoes do Estabelecimento do relatorio RIO."
	aAdd (aListBox, "") 	  	 						; aAdd (aSel, .F.); aAdd (aMsg, "")                	; aAdd (aValid, "")
	aAdd (aListBox, OemToAnsi (STR0009))				; aAdd (aSel, .T.); aAdd (aMsg, OemToAnsi(STR0009))	; aAdd (aValid, "VldCfp ('C', 'NOMEPAST')") 	//"0001"
	aAdd (aListBox, OemToAnsi (STR0010))				; aAdd (aSel, .T.); aAdd (aMsg, OemToAnsi(STR0010))	; aAdd (aValid, "VldCfp ('C', 'NOMEPAST')") 	//"0002"
	aAdd (aListBox, OemToAnsi (STR0011))				; aAdd (aSel, .T.); aAdd (aMsg, OemToAnsi(STR0011))	; aAdd (aValid, "VldCfp ('C', 'NOMEPAST')") 	//"0003"
	aAdd (aListBox, OemToAnsi (STR0012))				; aAdd (aSel, .T.); aAdd (aMsg, OemToAnsi(STR0012))	; aAdd (aValid, "VldCfp ('C', 'NOMEPAST')") 	//"0004"
	aAdd (aListBox, OemToAnsi (STR0013))				; aAdd (aSel, .T.); aAdd (aMsg, OemToAnsi(STR0013))	; aAdd (aValid, "VldCfp ('C', 'NOMEPAST')") 	//"0005"
	aAdd (aListBox, OemToAnsi (STR0014))				; aAdd (aSel, .T.); aAdd (aMsg, OemToAnsi(STR0014))	; aAdd (aValid, "VldCfp ('C', 'NOMEPAST')") 	//"0006"
	aAdd (aListBox, OemToAnsi (STR0015))				; aAdd (aSel, .T.); aAdd (aMsg, OemToAnsi(STR0015))	; aAdd (aValid, "VldCfp ('C', 'NOMEPAST')") 	//"0007"
	aAdd (aListBox, OemToAnsi (STR0016))				; aAdd (aSel, .T.); aAdd (aMsg, OemToAnsi(STR0016))	; aAdd (aValid, "VldCfp ('C', 'NOMEPAST')") 	//"0008"
	aAdd (aListBox, OemToAnsi (STR0017))				; aAdd (aSel, .T.); aAdd (aMsg, OemToAnsi(STR0017))	; aAdd (aValid, "VldCfp ('C', 'NOMEPAST')") 	//"0009"
	aAdd (aListBox, OemToAnsi (STR0018))				; aAdd (aSel, .T.); aAdd (aMsg, OemToAnsi(STR0018))	; aAdd (aValid, "VldCfp ('C', 'NOMEPAST')") 	//"0010"
	aAdd (aListBox, OemToAnsi (STR0019))				; aAdd (aSel, .T.); aAdd (aMsg, OemToAnsi(STR0019))	; aAdd (aValid, "VldCfp ('C', 'NOMEPAST')") 	//"0011"
	aAdd (aListBox, OemToAnsi (STR0020))				; aAdd (aSel, .T.); aAdd (aMsg, OemToAnsi(STR0020))	; aAdd (aValid, "VldCfp ('C', 'NOMEPAST')") 	//"0012"
	aAdd (aListBox, OemToAnsi (STR0021))				; aAdd (aSel, .T.); aAdd (aMsg, OemToAnsi(STR0021))	; aAdd (aValid, "VldCfp ('C', 'NOMEPAST')") 	//"0013"
	aAdd (aListBox, OemToAnsi (STR0022))				; aAdd (aSel, .T.); aAdd (aMsg, OemToAnsi(STR0022))	; aAdd (aValid, "VldCfp ('C', 'NOMEPAST')") 	//"0014"
	aAdd (aListBox, OemToAnsi (STR0023))				; aAdd (aSel, .T.); aAdd (aMsg, OemToAnsi(STR0023))	; aAdd (aValid, "VldCfp ('C', 'NOMEPAST')") 	//"0015"
	aAdd (aListBox, "") 	  	 						; aAdd (aSel, .F.); aAdd (aMsg, "")                	; aAdd (aValid, "")	
	//
	For nI := 1 To (Len (aListBox))
		aListBox [nI]	:=	OemToAnsi (aListBox [nI])
		aMsg [nI]		:=	OemToAnsi (aMsg [nI])
	Next (nI)                
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Carrego as informacoes do RELRIO.CFP caso exista para exibi-las.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	LoadRio (cArqCfp)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ativa ListBox com opcoes para o array da configuracao ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Define MSDialog oDlgGet Title OemToAnsi (cBarra) From 180, 110 To 550, 700 Pixel Of oMainWnd
	@ 010, 020 Say OemToAnsi (cTitJan) Size 140, 007 Of oDlgGet Pixel
	@ 026, 018 To 155, 277 LABEL "" OF oDlgGet Pixel
	@ 033, 022 ListBox oListBox Var cVar Fields Header "" On DBLCLICK (ListRio (oListBox)) Size 250, 115 Pixel
	//	
	oListBox:SetArray (aListBox)
	oListBox:bLine := {||{aListBox[oListBox:nAt]}}
	//
	Define SButton From 165, 220 Type 1 Action (nOpca := 1, oDlgGet:End ()) Enable Of oDlgGet
	Define SButton From 165, 248 Type 2 Action (nOpca := 2, oDlgGet:End ()) Enable Of oDlgGet
	//
	Activate MSDialog oDlgGet Centered
	//
	If (nOpcA==1)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava itens no arquivo de configuracao RELRIO.CFP   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		GravaItRio (cArqCfp)
		//
		aArqCfp		:=	LeCfpRio (cArqCfp)	//Array contendo os folders.
		EditRel (aArqCfp, nCompLinha)	//Funcao de montagem da tela de configuracao do relatorio.
	Endif
Return (aArqCfp)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³LoadRio   ³ Autor ³Gustavo G. Rueda       ³ Data ³27.08.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Carrega conteudo do arquivo .CFP passado como parametro.    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL -> lRet (.T.)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC -> Arquivo .CFP a ser carregado.                       ³±±
±±³          ³ExpN -> nOpcao = 1 para .CFP folder / 2 para .CFP tela conf.³±±
±±³          ³ExpA -> aColsX = aCols passado como referencia para ser     ³±±
±±³          ³ atualizado e utilizado na funcao EditRel, caso o paramentro³±±
±±³          ³ nOpcao esteja como 2.                                      ³±±
±±³          ³ExpN -> nQtdFolders = Quantidade de folders existentes no   ³±±
±±³          ³ .CFP. Tambem serve indice para o array aColsX.             ³±±
±±³          ³ExpN -> nCompLinha = Qtd caracteres de cada linha do CFP    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function LoadRio (ArqIni, nOpcao, aColsX, nQtdFolders, nCompLinha)
	Local 	nI			:=	0
	Local 	cConteudo	:=	""
	Local 	lRet		:=	.T.
	Local	aPart		:=	{}
	Local	nX			:=	0
	Local	cPart		:=	""
	Local	nIAcols		:=	1
	//
	Default	nOpcao	:=	1
	//
	If (File (ArqIni))
		If (nOpcao==1)	//Carrego as informacoes da primeira tela de configuracao dos folders. RELRIO.CFP
			For nI := 1 To (Len (aListBox))
				cConteudo	:=	""
				If (IsDigit (SubStr (aListBox[nI], 2, 4)))
					cConteudo	:=	LerRio (ArqIni, Substr (aListBox[nI], 2, 4))
					If (Len (cConteudo)<254)
						cConteudo	:=	cConteudo+Space (254-Len (cConteudo))
					EndIf
				Endif
				aAdd (aConteudo, cConteudo)
			Next
		ElseIf (nOpcao==2)	//Carrego as informacoes da segunda tela de configura do relatorio. ARQGRV.CFP
			nIAcols	:=	1
			For nI := 1 To (Len (aColsX))
				cConteudo	:=	LerRio (ArqIni, StrZero (nIAcols, 3),, 2, nCompLinha)	//Leio linha-a-linha passando uma chave unica na funcao.
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Verifico se as informacoes a serem adicionadas no array aColsX³
				//³  ja possuem uma respectiva pasta ou se deve ser criada uma   ³
				//³  nova. Esta verificacao e feita atraves do DO WHILE abaixo.  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				Do While SubStr (cConteudo, 1, 3)==StrZero (nI, 3)
					If (Len (cConteudo)<nCompLinha)
						cConteudo	:=	cConteudo+Space (nCompLinha-Len (cConteudo))
					EndIf
					//
					aPart	:=	{}
					cPart	:=	""
					For nX := 1 To Len (cConteudo)
						If (SubStr (cConteudo, nX, 1)=="|") .Or. (Len (cConteudo)==nX)	//Como delimitador de cada registro foi adotado o separador "|"
							If	(Len (cConteudo)==nX)
								aAdd (aPart, Val (cPart))
							Else
								aAdd (aPart, cPart)
							EndIf
							cPart	:=	""
						Else
							cPart	+=	SubStr (cConteudo, nX, 1)
						EndIf					
					Next (nX)					
					aAdd (aPart, .F.)
					//
					aAdd (aColsX[nI], aPart)
					//
					nIAcols++
					cConteudo	:=	LerRio (ArqIni, StrZero (nIAcols, 3),, 2, nCompLinha)
				EndDo
			Next (nI)		
		EndIf
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³No caso de .CFP de folders nao existir, sera assumido branco em todas as opcoes ³
		//³do listbox.                                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (nOpcao==1)
			For nI := 1 To (Len (aListBox))
				aAdd (aConteudo, Space (254))
			Next
		EndIf
	Endif
Return (lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³GravaItRio³ Autor ³Gustavo G. Rueda       ³ Data ³27.08.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Grava arquivo INI.                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL -> lRet (.T.)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC -> Arquivo .CFP a ser criado.                          ³±±
±±³          ³ExpN -> nOpcao=Se sera gravado o RELRIO.CFP / ARQGRV.CFP    ³±±
±±³          ³ExpA -> aArrayGrv=Caso parametro nOpcao=2 este contem o     ³±±
±±³          ³ o array a ser gravado no ARQGRV.CFP.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GravaItRio (ArqIni, nOpcao, aArrayGrv)
	Local	cArqBkp	:=	StrTran (ArqIni, ".CFP", ".#CF")
	Local	aGravar	:=	{}
	Local	nI		:=	0
	Local	lRet	:=	.T.
	Local	cGravar	:=	""
	//
	Default	nOpcao	:=	1
	//
	If File(cArqBkp)
		Ferase(cArqBkp)
	Endif
	FRename(ArqIni,cArqBkp)
	nHandle	:=	MSFCREATE(ArqIni)
	//
	If (nOpcao==1)
		For nI := 1 To (Len (aListBox))
			If (IsDigit (Substr (aListBox[nI], 2, 4)))
				aAdd (aGravar, "["+Substr (aListBox[nI], 2, 4)+"]="+Rtrim (aConteudo[nI])+Chr(13)+Chr(10))
			EndIf
		Next
		For nI := 1 To (Len (aGravar))
			FWrite (nHandle, aGravar[nI], Len(aGravar[nI]))
		Next
	Else
		For nI := 1 To (Len (aArrayGrv))
			cGravar	:=	aArrayGrv[nI]+Chr(13)+Chr(10)
			FWrite (nHandle, cGravar, Len(cGravar))
		Next
	EndIF
	FClose(nHandle)
Return (lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ListRio   ³ Autor ³Gustavo G. Rueda       ³ Data ³15.07.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Atualiza parametro clicando.                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL -> lRet (.T.)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO -> oListBox = Objeto listbox.                          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ListRio (oListBox)
	Local oDlgGet2
	Local nOpcaGet	:=	2
	Local lUpdated	:=	.F.
	Local bValid
	Local lRet		:=	.T.
	Private cCampo	:=	"cCpoItem"
	//
	nAt	:=	oListBox:nAt
	//
	Private cValid	:=	"{||"+aValid[nAt]+"}"
	//
	If (aSel[nAt])
		&cCampo	:=	aConteudo[nAt]
		bValid	:=	&(cValid)
		//
		Define MSDialog oDlgGet2 Title aMsg[nAt] From  300,100 To 400,620 Pixel Of oListBox
		@ 08, 20 To 27, 237 LABEL "" Of oDlgGet2 Pixel
		@ 15, 24 MSGet &cCampo Picture "@!" Valid Eval (bValid) Size 210, 08 Of oDlgGet2 Pixel
		//
		Define SButton From 032, 182 Type 1 Action (lUpdated:=.t.,oDlgGet2:End ()) Enable Of oDlgGet2
		Define SButton From 032, 210 Type 2 Action (lUpdated:=.f.,oDlgGet2:End ()) Enable Of oDlgGet2
		//
		Activate MSDialog oDlgGet2 Centered
		//
		If (lUpdated)
			aConteudo[nAt]	:=	StrTran (&cCampo,'"',"'")
		Endif
	Endif
Return (lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³LerRio    ³ Autor ³Gustavo G. Rueda       ³ Data ³15.07.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Le o CFP.                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL -> lRet (.T.)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpL -> lEnd                                                ³±±
±±³          ³ExpC -> cCpo                                                ³±±
±±³          ³ExpN -> nCompLinha = Qtd caracteres de cada linha do CFP    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function LerRio (cArqIni, cCPO, lEnd, nOpcao, nCompLinha)
	Local cIni		:=	""
	Local cConteudo	:=	""
	Local nI		:=	0
	//
	Default	nOpcao	:=	1
	//
	lEnd := If (lEnd==NIL, .F., lEnd)
	If (nOpcao==1)
		cCPO := "["+cCPO+"]="
	EndIf
	//
	If !File (cArqIni)
		If (nOpcao==1)
			Help (" ",1,"RELRIO.CFP")
		ElseIf (nOpcao==2)
			Help (" ",1,"ARQGRV.CFP")
		EndIf
		lContinua	:=	.F.
		lEnd		:=	.T.
		Return (cIni)
	Else	
		cConteudo	:=	MemoRead (cArqIni)
		If (nOpcao==1)
			nLinhas		:=	MlCount (cConteudo, 254)
			//
			For nI := 1 To nLinhas
				cLinha	:=	AllTrim (MemoLine (cConteudo, 254, nI))
				If (cCPO$cLinha)
					cIni := SubStr (cLinha, 7)
					Exit
				Endif
			Next
		ElseIf (nOpcao==2)
			nLinhas		:=	MlCount (cConteudo, nCompLinha)
			//
			For nI := 1 To nLinhas			
				cLinha	:=	AllTrim (MemoLine (cConteudo, nCompLinha, nI))
				If (cCPO$SubStr (cLinha, 1, 3))
					cIni := SubStr (cLinha, 5)
					Exit
				EndIf
			Next		
		EndIf
	Endif
Return(cIni)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³VldCfp    ³ Autor ³Gustavo G. Rueda       ³ Data ³15.07.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Valida string do CFP.                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL -> lRet (.T./.F.)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC -> cTipo - Tipo do campo.                              ³±±
±±³          ³ExpC -> cCampo - Campo a ser tratado.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function VldCfp (cTipo, cCampo)
	Local	lRet		:=	.T.
	Local	cConteudo	:=	&(ReadVar())
	Local	nI			:=	0
	//
	Default	cTipo	:=	""
	Default	cCampo	:=	""
	//
	cConteudo	:=	Alltrim (cConteudo)
	//
	If (cCampo=="NOMEPAST")
	/*
		If !(AllTrim (cConteudo)$"1234") .Or. (Len (AllTrim (cConteudo))>1)
			Help (" ", 1, "EXCONT",, STR0123, 3, 0)	//"Permitido somente 1 digito! [1=Orig. prz., 2=Retif. prz., 3=Orig. fora prz., 4=Retif. fora prz.]"
			lRet	:=	.F.
		Endif
	*/
	EndIf	
Return(lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³LeCfpRio  ³ Autor ³Gustavo G. Rueda       ³ Data ³27.08.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Monta o CFP em um array para ser utilizado no INI.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL -> aRet - array conteudo CFP.                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC -> cArquivo - Arquivo CFP.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function LeCfpRio (cArquivo)
	Local	cConteudo	:=	MemoRead (cArquivo)
	Local	nLinhas		:= MlCount (cConteudo, 254)
	Local	nI			:=	0
	Local	aRet		:=	{}
	//
	For nI := 1 To nLinhas
		cLinha	:=	AllTrim (MemoLine (cConteudo, 254, nI))
		aAdd (aRet, {SubStr (cLinha, 2, 3), SubStr (cLinha, 7)})
	Next
Return (aRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CriaDelTrb³ Autor ³Gustavo G. Rueda       ³ Data ³27.08.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Criacao/Delecao do TRB utilizado para impressao.            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpA1 -> Array conteudo o Alias e nome do TRB criado.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpN1 -> nOpc - Opcao que define se o TRB sera criado ou    ³±±
±±³          ³  deletado.                                                 ³±±
±±³          ³ExpA1 -> Array contendo o Alias e o nome do TRB utilizado.  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CriaDelTrb (nOpc, aTrb)
	Local	aStruTrb	:=	{}
	Local	cArqTrb		:=	""
	Local	cArqTrb1	:=	""
	Local	nX			:=	0
	//
	If nOpc==1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Estrutura da tabela utilizada na montagem do quadro B.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aStruTrb	:=	{}
		aAdd (aStruTrb, {"TRB_CODGRP",	"C",	003,	0})
		aAdd (aStruTrb, {"TRB_DESGRP",	"C",	030,	0})
		aAdd (aStruTrb, {"TRB_CODITE",	"C",	006,	0})
		aAdd (aStruTrb, {"TRB_DESITE",	"C",	030,	0})
		aAdd (aStruTrb, {"TRB_QUANT",	"N",	011,	2})
		aAdd (aStruTrb, {"TRB_UM",		"C",	002,	0})
		aAdd (aStruTrb, {"TRB_SEGUM",	"C",	002,	0})
		//
		cArqTrb	:=	CriaTrab (aStruTrb)
		dbUseArea (.T., __LocalDriver, cArqTrb, "TRB")
		IndRegua ("TRB", cArqTrb, "TRB_CODGRP+TRB_CODITE")
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Estrutura da tabela utilizada na montagem do quadro C.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aStruTrb	:=	{}
		aAdd (aStruTrb, {"TRC_ITQC",	"C",	001,	0})
		aAdd (aStruTrb, {"TRC_PAIS",	"C",	020,	0})
		aAdd (aStruTrb, {"TRC_UF",		"C",	002,	0})		
		aAdd (aStruTrb, {"TRC_PROD",	"C",	030,	0})
		aAdd (aStruTrb, {"TRC_IMPEXP",	"C",	001,	0})
		aAdd (aStruTrb, {"TRC_QUANT",	"N",	011,	2})
		aAdd (aStruTrb, {"TRC_UM",		"C",	002,	0})
		aAdd (aStruTrb, {"TRC_SEGUM",	"C",	002,	0})
		//
		cArqTrb1	:=	CriaTrab (aStruTrb)
		dbUseArea (.T., __LocalDriver, cArqTrb1, "TRC")
		IndRegua ("TRC", cArqTrb1, "TRC_ITQC+TRC_PAIS+TRC_UF+TRC_PROD+TRC_IMPEXP")
	Else
		For nX := 1 To Len (aTrb)
			DbSelectArea (aTrb[nX][1])
			dbCloseArea()
			Ferase (aTrb[nX][2]+GetDBExtension())
			Ferase (aTrb[nX][2]+OrdBagExt())
		Next (nX)
	EndIf
Return ({{"TRB", cArqTrb}, {"TRC", cArqTrb1}})
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³LayRio    ³ Autor ³Gustavo G. Rueda       ³ Data ³27.08.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Estrutra do layout de impressao.                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpA1 -> aLayrio = Array contendo o layout de impressao.    ³±±
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
Static Function LayRio ()
	Local	aLayRio	:=	{}
	//       					     	    1         2         3         4         5          6         7         8         9
	//							   1234567890123456789012345678901234567890123456789012345674890123456789012345678901234567890
	aAdd (aLayRio, 	STR0029)	//"+------------------------------------------------------------------+------------+"
	aAdd (aLayRio, 	STR0030)	//"|MINISTERIO DA AGRICULTURA                                         |RELATORIO   |"
	aAdd (aLayRio, 	STR0031)	//"|DELEGACIA FEDERAL DE AGRICULTURA EM SANTA CATARINA                |INFORMACOES |"
	aAdd (aLayRio, 	STR0032)	//"|SERVICO DE FISCALIZACAO E FOMENTO DA PRODUCAO ANIMAL              |OPERACIONAIS|"
	aAdd (aLayRio, 	STR0033)	//"+------------------------------------------------------------------+------------+"
	aAdd (aLayRio, 	STR0034)	//"                                                                                 "
	aAdd (aLayRio, 	STR0035)	//"                                             De:#################################"
	aAdd (aLayRio, 	STR0036)	//"+-------------------------------------------------------------------------------+"
	aAdd (aLayRio, 	STR0037)	//"|A. IDENTIFICACAO                                                               |"
	aAdd (aLayRio, 	STR0038)	//"+------------------------------------------------------------------+------------+"
	aAdd (aLayRio, 	STR0039)	//"|01-Nome do Estabelecimento                                        |02-S.I.F.   |"
	aAdd (aLayRio, 	STR0040)	//"+------------------------------------------------------------------+------------+"
	aAdd (aLayRio, 	STR0041)	//"|##################################################################|############|"
	aAdd (aLayRio, 	STR0042)	//"+------------------------------------------------------------------+------------+"
	aAdd (aLayRio, 	STR0043)	//"|03-Razao Social                                                                |"
	aAdd (aLayRio, 	STR0044)	//"+-------------------------------------------------------------------------------+"
	aAdd (aLayRio, 	STR0045)	//"|###############################################################################|"
	aAdd (aLayRio, 	STR0046)	//"+------------------------------------------------------------------------+------+"
	aAdd (aLayRio, 	STR0047)	//"|04-Localidade                                                           |05-UF |"
	aAdd (aLayRio, 	STR0048)	//"+------------------------------------------------------------------------+------+"
	aAdd (aLayRio, 	STR0049)	//"|########################################################################|  SC  |"
	aAdd (aLayRio, 	STR0050)	//"+-----------------------------------------------------------------+------+------+"
	aAdd (aLayRio, 	STR0051)	//"|06-Nome Diretor/Gerente de Operacoes                             |07-Mes|08-Ano|"
	aAdd (aLayRio, 	STR0052)	//"+-----------------------------------------------------------------+------+------+"
	aAdd (aLayRio, 	STR0053)	//"|################################################################ |  ##  | #### |"
	aAdd (aLayRio, 	STR0054)	//"+-----------------------------------------------------------------+------+------+"
	aAdd (aLayRio, 	STR0055)	//"                                                                                 "	27
	aAdd (aLayRio, 	STR0056)	//"+-------------------------------------------------------------------------------+"
	aAdd (aLayRio, 	STR0057)	//"|B. REALIZACOES DO ESTABELECIMENTO                                              |"
	aAdd (aLayRio, 	STR0058)	//"+---------------------------------------+---------------------------------------+"
	aAdd (aLayRio, 	STR0059)	//"|##-####################################|##-####################################|"
	aAdd (aLayRio, 	STR0060)	//"+-------------------+-------------------+-------------------+-------------------+"
	aAdd (aLayRio, 	STR0061)	//"|Discriminacao      |Quantidade (KG)    |Discriminacao      |Quantidade (KG)    |"
	aAdd (aLayRio, 	STR0062)	//"+-------------------+-------------------+-------------------+-------------------+"
	aAdd (aLayRio, 	STR0063)	//"|###################|###################|###################|###################|"
	aAdd (aLayRio, 	STR0064)	//"+-------------------+-------------------+-------------------+-------------------+"
	aAdd (aLayRio, 	STR0065)	//"                                                                                 "
	aAdd (aLayRio, 	STR0066)	//"+-------------------------------------------------------------------------------+"
	aAdd (aLayRio, 	STR0067)	//"|C. COMERCIALIZACAO                                                             |"
	aAdd (aLayRio, 	STR0068)	//"+-------------------------------------------------------------------------------+"	//40
	aAdd (aLayRio, 	STR0069)	//"|##-Interestadual                                                               |"
	aAdd (aLayRio, 	STR0070)	//"+--+------------------------------------+--+------------------------------------+"
	aAdd (aLayRio, 	STR0071)	//"|  |            Exportacao              |  |          Importacao                |"
	aAdd (aLayRio, 	STR0072)	//"|UF+----------------+-------------------+UF+----------------+-------------------+"
	aAdd (aLayRio, 	STR0073)	//"|  |Produto         |Quantidade (T)     |  |Produto         |Quantidade (T)     |"
	aAdd (aLayRio, 	STR0074)	//"+--+----------------+-------------------+--+----------------+-------------------+"
	aAdd (aLayRio, 	STR0075)	//"|##|############### |###################|##|############### |###################|"
	aAdd (aLayRio, 	STR0076)	//"+--+----------------+-------------------+--+----------------+-------------------+"
	aAdd (aLayRio, 	STR0077)	//"|##-Internacional                                                               |"
	aAdd (aLayRio, 	STR0078)	//"+--------------------+----------------------------+-----------------------------+"	//50
	aAdd (aLayRio, 	STR0079)	//"|Paises              |          Exportacao        |          Importacao         |"
	aAdd (aLayRio, 	STR0121)	//"|                    |Produto        |Qtd (T)     |Produto        |Qtd (T)      |"
	aAdd (aLayRio, 	STR0080)	//"+--------------------+---------------+------------+---------------+-------------+"
	aAdd (aLayRio, 	STR0081)	//"|####################|###############|############|###############|############ |"
	aAdd (aLayRio, 	STR0082)	//"+--------------------+---------------+------------+---------------+-------------+"
	aAdd (aLayRio, 	STR0083)	//"                                                                                 "
	aAdd (aLayRio, 	STR0084)	//"+-------------------------------------------------------------------------------+"
	aAdd (aLayRio, 	STR0085)	//"|D. FONTE DAS INFORMACOES                                                       |"
	aAdd (aLayRio, 	STR0086)	//"+---------------------------------------------+---------------------------------+"
	aAdd (aLayRio, 	STR0087)	//"|##-Local e Data Emissao                      |##-Responsavel pelas informacoes |"
	aAdd (aLayRio, 	STR0088)	//"+----------------------------------+--+--+----+---------------------------------+"
	aAdd (aLayRio, 	STR0089)	//"|##################################|##|##|####|#################################|"
	aAdd (aLayRio, 	STR0090)	//"+----------------------------------+--+--+----+---------------------------------+"
Return (aLayRio)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ImpRio    ³ Autor ³Gustavo G. Rueda       ³ Data ³15.07.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³funcao de impressao conforme layout.                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL -> lRet = .T.                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpA -> aTrb = Array contendo os TRB'S.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpRio (aTrb)
	Local	lFlag		:=	.F.
	Local	lRet		:=	.T.
	Local  aLayRio		:=	LayRio ()
	Local	nInd		:=	0
	Local	nLinInicial	:=	2
	Local	nLin		:=	nLinInicial
	Local	nQtdLinPag	:=	55
	Local	aColE		:=	{}
	Local	aColD		:=	{}
	Local	lImp1		:=	.T.
	Local	lImp2		:=	.T.
	Local	cChave		:=	""
	Local	cChaveTrb	:=	""
	Local	nX			:=	0
	Local	cDescAcol	:=	""
	Local	aTitQuadro	:=	Array (1)
	Local	aBaseQuadro	:=	{}
	Local	nControle	:=	0        
	
	dbSelectArea("SM0")
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Impressao do quadro A-IDENTIFICACAO³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nInd := 1 To 6
		FmtLin (, aLayRio[nInd],,, @nLin++)
	Next (nInd)
	FmtLin ({""}, aLayRio[7],,, @nLin++)
	//
	For nInd := 8 To 12
		FmtLin (, aLayRio[nInd],,, @nLin++)
	Next (nInd)
	FmtLin ({SM0->M0_NOME, MV_PAR03}, aLayRio[13],,, @nLin++)
	//
	For nInd := 14 To 16
		FmtLin (, aLayRio[nInd],,, @nLin++)
	Next (nInd)
	FmtLin ({SM0->M0_NOMECOM}, aLayRio[17],,, @nLin++)
	//
	For nInd := 18 To 20
		FmtLin (, aLayRio[nInd],,, @nLin++)
	Next (nInd)
	FmtLin ({SM0->M0_ENDENT}, aLayRio[21],,, @nLin++)
	//
	For nInd := 22 To 24
		FmtLin (, aLayRio[nInd],,, @nLin++)
	Next (nInd)
	nInd	:=	25
	FmtLin ({MV_PAR04,StrZero (Month (MV_PAR01), 2), StrZero (Year (MV_PAR01), 4)}, aLayRio[nInd],,, @nLin++)
	nInd	:=	26
	FmtLin (, aLayRio[nInd],,, @nLin++)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³              QUADRO B               ³
	//³Adicionando nos array:               ³
	//³aColE = Array para a coluna esquerda.³
	//³aColD = Array para a coluna direita. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea (aTrb[1][1])
		(aTrb[1][1])->(DbGoTop ())
	//
	cChave		:=	"E"
	cChaveTrb	:=	(aTrb[1][1])->TRB_CODGRP
	Do While !((aTrb[1][1])->(Eof ()))
		If (cChaveTrb<>(aTrb[1][1])->TRB_CODGRP)
			If ("D"$cChave)
				cChave	:=	"E"
			Else
				cChave	:=	"D"
			EndIf
			//
			cChaveTrb	:=	(aTrb[1][1])->TRB_CODGRP
		EndIf
		//
		If ("E"$cChave)
			aAdd (aColE, {(aTrb[1][1])->TRB_DESGRP, SubStr ((aTrb[1][1])->TRB_DESITE, 1, 19), Transform ((aTrb[1][1])->TRB_QUANT, "@E 999,999,999,999.99")})
		Else
			aAdd (aColD, {(aTrb[1][1])->TRB_DESGRP, SubStr ((aTrb[1][1])->TRB_DESITE, 1, 19), Transform ((aTrb[1][1])->TRB_QUANT, "@E 999,999,999,999.99")})
		EndIf
		//
		(aTrb[1][1])->(DbSkip ())
	EndDo
	//
	If Len (aColE)>0
		For nInd := 27 To 29
			FmtLin (, aLayRio[nInd],,, @nLin++)
		Next (nInd)
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Impressao do quadro B conforme array's aColE e aColD.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cDescAcol	:=	""
	nInd		:=	30
	If (Len (aColE)>=Len (aColD))	.And. (Len (aColE)>0)//Apesar de sempre o aColE ser maior que o aColD, fiz a verificacao para desencargo.
		aBaseQuadro	:=	Array (1)
		//
		For nX := 1 To Len (aColE)
			If (nLin>=nQtdLinPag)
				nInd	:=	36
				FmtLin (, aLayRio[nInd],,, @nLin++)
				@ nLin, 0 PSAY STR0091
				nLin	:=	nLinInicial
				@ nLin, 0 PSAY STR0092
				nLin++
				FmtLin (, aLayRio[nInd],,, @nLin++)
			EndIf
			//
			If !(aColE[nX][1]$cDescAcol)	//Verificacao para gerar o label da coluna do relatorio
				cDescAcol	:=	aColE[nX][1]
				If (Len (aColD)>=nX) .And. (Len (aColD)<>0)
					nInd	:=	36
					FmtLin (, aLayRio[nInd],,, @nLin++)
					nInd	:=	31
					aTitQuadro	:=	{StrZero (nX+8, 2), aColE[nX][1], StrZero (nX+9, 2), aColD[nX][1]}
					FmtLin (aTitQuadro, aLayRio[nInd],,, @nLin++)
					nInd	:=	32
					FmtLin (, aLayRio[nInd],,, @nLin++)
					nInd	:=	33
					FmtLin (, aLayRio[nInd],,, @nLin++)
					nInd	:=	34
					FmtLin (, aLayRio[nInd],,, @nLin++)
				Else 
					nInd	:=	36
					FmtLin (, aLayRio[nInd],,, @nLin++)
					nInd	:=	31
					aTitQuadro	:=	{StrZero (nX+8, 2), aColE[nX][1], "", ""}
					FmtLin (aTitQuadro, aLayRio[nInd],,, @nLin++)
					nInd	:=	32
					FmtLin (, aLayRio[nInd],,, @nLin++)
					nInd	:=	33
					FmtLin (, aLayRio[nInd],,, @nLin++)
					nInd	:=	34
					FmtLin (, aLayRio[nInd],,, @nLin++)
				EndIf
			EndIf
			//
			nInd	:=	35
			If (Len (aColD)>=nX) .And. (Len (aColD)<>0)
				aBaseQuadro	:=	{aColE[nX][2], aColE[nX][3], aColD[nX][2], aColD[nX][3]}
			Else
				aBaseQuadro	:=	{aColE[nX][2], aColE[nX][3], "", ""}
			EndIf
			FmtLin (aBaseQuadro, aLayRio[nInd],,, @nLin++)
			//
		Next (nX)
		nInd	:=	36
		If (Len (aBaseQuadro)>0)
			FmtLin (, aLayRio[nInd],,, @nLin++)
		EndIf
	EndIf
	aBaseQuadro	:=	{}
	nControle	:=	0
	nControle	:=	Len (aColE)+8
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³              QUADRO C               ³
	//³Imprimindo Quadro C - Interestadual  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lFlag	:=	.F.
	lImp1	:=	.T.		//Controle de impressao do cabecalho para itens Interestaduais
	lImp2	:=	.T.		//Controle de impressao do cabecalho para itens Internacionais
	DbSelectArea (aTrb[2][1])
		(aTrb[2][1])->(DbGoTop ())
	If !(aTrb[2][1])->(DbSeek ("1"))			//Interestadual
		If ((aTrb[2][1])->(DbSeek ("2")))	//Internacional
			aBaseQuadro	:=	Array (1)
		EndIf
	EndIF
	//
	lFlag	:=	"1"$(aTrb[2][1])->TRC_ITQC	//Chave utilizada para quando o primeiro item for diretamente o 2
	cItQuadroC	:=	""
	//	
	Do While !((aTrb[2][1])->(Eof ()))
		If !((aTrb[2][1])->TRC_ITQC$cItQuadroC)
			cItQuadroC	+=	(aTrb[2][1])->TRC_ITQC
		EndIf
		//
		If ("2"$(aTrb[2][1])->TRC_ITQC)
			If (lImp2)	//Verifico se ja foi impresso uma vez
				If (lFlag)	//Flag de impressao do cabecalho das colunas para o item Internacional, caso somente o item internacional seja impresso. Para este caso o cabecalho deve mudar.
					For nInd := 48 To 53
						If (nInd==49)	//Numeracao automatica para os Titulos
							FmtLin ({StrZero (++nControle, 2)}, aLayRio[nInd],,, @nLin++)
						Else
							FmtLin (, aLayRio[nInd],,, @nLin++)
						EndIf
					Next (nInd)
				Else
					For nInd := 49 To 53
						If !(nInd==49)	//Numeracao automatica para os Titulos
							FmtLin (, aLayRio[nInd],,, @nLin++)
						Else
							FmtLin (, aLayRio[37],,, @nLin++)
							FmtLin (, aLayRio[38],,, @nLin++)
							FmtLin (, aLayRio[39],,, @nLin++)
							FmtLin (, aLayRio[40],,, @nLin++)
							FmtLin ({StrZero (++nControle, 2)}, aLayRio[nInd],,, @nLin++)
						EndIf					
					Next (nInd)
				EndIf
				lImp2	:=	.F.
			EndIf
			nInd := 54
		Else
			If (lImp1)
				For nInd := 37 To 46
					If nInd==41
						FmtLin ({StrZero (++nControle, 2)}, aLayRio[nInd],,, @nLin++)
					Else
						FmtLin (, aLayRio[nInd],,, @nLin++)
					EndIF
				Next (nInd)
				lImp1	:=	.F.
			EndIf
			nInd	:=	47
		EndIf
		//
		If ("E"$(aTrb[2][1])->TRC_IMPEXP)	//Coluna da esquerda ou direita
			If ((aTrb[2][1])->TRC_ITQC=="1")
				aBaseQuadro	:=	{(aTrb[2][1])->TRC_UF, (aTrb[2][1])->TRC_PROD, Transform ((aTrb[2][1])->TRC_QUANT, "@E 9,999,999.99"), "", "", ""}
			Else
				aBaseQuadro	:=	{(aTrb[2][1])->TRC_PAIS, (aTrb[2][1])->TRC_PROD, Transform ((aTrb[2][1])->TRC_QUANT, "@E 9,999,999.99"), "", ""}
			EndIf
		Else
			If ((aTrb[2][1])->TRC_ITQC=="1")
				aBaseQuadro	:=	{"", "", "", (aTrb[2][1])->TRC_UF, (aTrb[2][1])->TRC_PROD, Transform ((aTrb[2][1])->TRC_QUANT, "@E 9,999,999.99")}
			Else
				aBaseQuadro	:=	{(aTrb[2][1])->TRC_PAIS, "", "", (aTrb[2][1])->TRC_PROD, Transform ((aTrb[2][1])->TRC_QUANT, "@E 9,999,999.99")}
			EndIf
		EndIf
		FmtLin (aBaseQuadro, aLayRio[nInd],,, @nLin++)
		//
		If (nLin>=nQtdLinPag)	//Verificacao de mudanca de pagina
			If ("2"$(aTrb[2][1])->TRC_ITQC)
				nInd	:=	55
				FmtLin (, aLayRio[nInd],,, @nLin++)
			Else
				nInd	:=	46
				FmtLin (, aLayRio[nInd],,, @nLin++)
			EndIF
			@ nLin, 0 PSAY STR0091
			nLin	:=	nLinInicial
			@ nLin, 0 PSAY STR0092
			nLin++
		EndIf
		//
		(aTrb[2][1])->(DbSkip ())
	EndDo
	//
	If (Len (aBaseQuadro)>0)
		If ("1"$cItQuadroC)
			nInd	:=	48
		EndIf
		//
		If ("2"$cItQuadroC)
			nInd	:=	55
		EndIf
		//
		FmtLin (, aLayRio[nInd],,, @nLin++)
	EndIf
	//
	aBaseQuadro	:=	{}
	//
	If (nLin>=nQtdLinPag)
		@ nLin, 0 PSAY STR0091
		nLin	:=	nLinInicial
		@ nLin, 0 PSAY STR0092
		nLin++
	EndIf	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Impressao do quadro D-Fonte das Informacoes.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nInd := 56 To 61
		If nInd==60
			FmtLin ({StrZero (++nControle, 2), StrZero (++nControle, 2)}, aLayRio[nInd],,, @nLin++)
		Else
			FmtLin (, aLayRio[nInd],,, @nLin++)
		EndIf
	Next (nInd)	
	aBaseQuadro	:=	{SubStr (SM0->M0_CIDENT, 1, 34), StrZero (Day (dDataBase), 2), StrZero (Month (dDataBase), 2), StrZero (Year (dDataBase), 4), SubStr ("", 1, 33)}
	//
	nInd	:=	62
	FmtLin (aBaseQuadro, aLayRio[nInd],,, @nLin++)
	nInd	:=	63
	FmtLin (aBaseQuadro, aLayRio[nInd],,, @nLin++)
Return (lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³EditRel   ³ Autor ³Gustavo G. Rueda       ³ Data ³14.07.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Funcao de montagem da tela de configuracao do relatorio.    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL1 -> lRet = .T.                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpA -> aArqCfp = Contem array com os folders a considerar. ³±±
±±³          ³ExpN -> nCompLinha = Qtd caracteres de cada linha do CFP    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function EditRel (aArqCfp, nCompLinha)
	Local		lRet		:=	.T.
	Local 		nX
	Local		nOpcx 		:= 	4
	Local		nOpca 		:= 	1
	Local 		cCadastro 	:= 	STR0108
	Local 		aPosObj   	:= 	{} 
	Local 		aObjects  	:= 	{}                        
	Local 		aSize     	:= 	MsAdvSize() 	//Ajuste de resolucao.
	Local 		aTitles   	:= 	{}
	Local 		nGd1      	:= 	2
	Local 		nGd2      	:= 	2
	Local 		nGd3      	:= 	0 
	Local 		nGd4      	:= 	0 
	Local 		nQtdFolders	:= 	0
	Local 		oDlg
	Local	 	aColsX		:=	{}
	Local	 	aHeaderX	:=	{}
	Local	 	aAlterX		:=	{}
	Local	 	aColsY		:=	{}
	Local	 	aHeaderY	:=	{}
	Local		aGetDad		:= 	{}
	Local		cArqGrvRIo	:=	"ARQGRV.CFP"
	Local		aArrayGrv	:=	{}
	Local		nY			:=	0
	Local		nLin		:=	0
	Local		nColDelete	:=	6
	Private 	oFolder
	Private	aRotina 	:= 	{	{ OemToAnsi(STR0005)	,"AxPesqui"  	,0,1},;	 //"Pesquisar"
									{ OemToAnsi(STR0006)	,"AxAlter"		,0,2},;	 //"Visual"
									{ OemToAnsi(STR0007)	,"AxInclui"		,0,3},;	 //"Incluir"
									{ OemToAnsi(STR0008)	,"AxAlter"		,0,4},;   //"Alterar"
									{ OemToAnsi(STR0009)	,"AxAlter"		,0,5} }    //"Exclusao"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Crio o array aTitles com todos os titulos dos folders a serem criados.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nX := 1 To Len (aArqCfp)
		If !(Empty (aArqCfp[nX][2]))
			aAdd (aTitles, aArqCfp[nX][2])
		EndIf
	Next (nX)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializacao dos array's a serem utilizados na criacao do GETDADOS.³
	//³- Cada elemento deste array equivale a um objeto da GETDADOS.       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nQtdFolders	:= 	Len (aTitles)
	aGetDad		:=	Array (nQtdFolders)
	aColsX 		:= 	Array (nQtdFolders)	//1 para cada folder
	aAlterX		:=	Array (nQtdFolders)	//1 para cada folder
	aHeaderX	:=	Array (nQtdFolders)	//1 para cada folder
	For nX := 1 To nQtdFolders
		aColsX[nX] 		:= {}
		aAlterX[nX]		:=	{}
 		aHeaderX[nX]	:=	{}
 	Next (nX)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Caso ja exista no sigaadv o arquivo ARQGRV.CFP, carrego as informacoes nele contido para o array aColsX, ³
	//³  caso contrario, inicializo-o em branco para ser preenchido manualmente.                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	LoadRio (cArqGrvRIo, 2, @aColsX, nQtdFolders, nCompLinha)
	//
	For nX := 1 To nQtdFolders
		If (Len (aColsX[nX])==0)
			aAdd (aColsX[nX], {StrZero (nX, 3),StrZero (nX, 3)+".00", Space (15), Space (100), 0, .F.})
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Definicao do aHeader utilizado no GETDADOS.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aAdd (aHeaderX[nX], {STR0110,	"cLinha",	"@!",			003,	0,	".T.",			"û",	"C",	" ",	" "}) //"Linha"
		aAdd (aHeaderX[nX], {STR0111,	"cCodigo",	"@!",			006,	0,	"U_VldCod()",		"û",	"C",	" ",	" "}) //"Codigo"
		aAdd (aHeaderX[nX], {STR0112,	"cCodProd",	"@!",			015,	0,	"U_VldCodPr()",	"û",	"C",	" ",	" "}) //"Cod. Produto"
		aAdd (aHeaderX[nX], {STR0113,	"cDescPrd",	"@!",			100,	0,	".T.",			"û" ,	"C",	" ",	" "}) //"Descricao Produto"
		aAdd (aHeaderX[nX], {STR0120,	"cFator",	"999,999.99",	010,	2,	".T.",			"û" ,	"N",	" ",	" "}) //"Fator Conversao"
 	Next (nX) 	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Ajustes do padrao de resolucao do video automatico.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aObjects := {} 
	AAdd (aObjects, {  60, 100, .t., .t. })
	//
	aInfo 	:= { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 } 
	aPosObj := MsObjSize( aInfo, aObjects ) 
	//
	nGd3 	:= aPosObj[1,3]-aPosObj[1,1]-15 
	nGd4 	:= aPosObj[1,4]-aPosObj[1,2]-4
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Montagem da Tela                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE MSDIALOG oDlg TITLE cCadastro From aSize[7],00 To aSize[6],aSize[5] OF oMainWnd PIXEL 
	oFolder := TFolder ():New (aPosObj[1,1], aPosObj[1,2], aTitles, {"","","","","","",""}, oDlg,,,, .T., .F., aPosObj[1,4]-aPosObj[1,2], aPosObj[1,3]-aPosObj[1,1])
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Criacao de um GETDADO para cada folder que e armazenado no array aGetDad³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nX := nQtdFolders To 1 Step -1
		aColsY		:=	aColsX[nX]
		aHeaderY	:=	aHeaderX[nX]
		//
		aHeader  := aClone (aHeaderY)
		aCols    := aClone (aColsY)
		//
		aGetDad[nX] := MSGetDados():New (nGd1, nGd2, nGd3, nGd4, nOpcX, "xLinOk", "AlwaysTrue", "", nOpcx!=2, aAlterX[nX], 3,, Len (aColsY),,,,, oFolder:aDialogs[nX])
		aGetDad[nX]:oBrowse:lDisablePaint := .T.
		aGetDad[nX]:oBrowse:bDrawSelect 	:= {|| aGetDad[oFolder:nOption]:oBrowse:aAlter := {"cCodigo", "cCodProd"}, aGetDad[oFolder:nOption]:oBrowse:oMother:aAlter := {"cCodigo", "cCodProd"}}
	Next (nX)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Funcao de atualizacao do GETDADO do folder quando houver uma mudanca de um folder para outro.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oFolder:bSetOption := {|nAtu| FtFld (nAtu, oFolder:nOption, oFolder, @aGetDad, @aColsX, @aHeaderX)}
	//
	ACTIVATE MSDIALOG oDlg ON INIT (FtRefre(@aGetDad),;	//Funcao de refresh do GETDADOS
	EnchoiceBar (oDlg,;
		{||nOpca := Iif (FtFld (oFolder:nOption, oFolder:nOption, oFolder, @aGetDad, @aColsX, @aHeaderX), 1, 0), Iif (nOpcA==1, oDlg:End(), Nil)},;
                {||nOpca := 0, oDlg:End ()},,{{"BMPINCLUIR",{|| AddAcols (@aGetDad[oFolder:nOption], nColDelete, oFolder:nOption)}, STR0114, STR0114}})) //Funcao AddAcols inclui Linhas no GETDADOS do folder em questao.
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Caso a configuracao do relatorio seja confirmada, gravo-o no arquivo ARQGRV.CFP³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (nOpca==1)
		nLin	:=	1	//Indice unico para a linha.
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Estrutura do ARQGRV.CFP:                        ³
		//³001=001|001.00|000001...|AAAAAAA|0.15           ³
		//³                                                ³
		//³Onde,                                           ³
		//³                                                ³
		//³001=Indice unico linha-a-linha.                 ³
		//³001=Codigo da linha da estrutura configurada.   ³
		//³001.00=Sub-codigo da linha.                     ³
		//³000001...=Codigo produto.                       ³
		//³AAAAAAA=Descricao produto.                      ³
		//³0.15=Falor fator conversao.                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nX := 1 To Len (aColsX)
			For nY := 1 To Len (aColsX[nX])
				If !(aColsX[nX][nY][Len (aColsX[nX][nY])])
					aAdd (aArrayGrv, StrZero (nLin, 3)+"="+aColsX[nX][nY][1]+"|"+aColsX[nX][nY][2]+"|"+aColsX[nX][nY][3]+"|"+aColsX[nX][nY][4]+"|"+StrZero (aColsX[nX][nY][5], 10, 2))
					//
					nLin++
				EndIf
			Next (nY)
		Next (nX)
		//
		GravaItRio (cArqGrvRio, 2, aArrayGrv)	//Gravacao do ARQGRV.CFP
	EndIf

Return (lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³FtFld     ³ Autor ³Gustavo G. Rueda       ³ Data ³15.07.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Funcao de refresh quando mudado de um folder para outro.    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL1 -> lRet = .T./.F.                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpN -> nFldDst=Numero do folder destino.                   ³±±
±±³          ³ExpN -> nFldAtu=Numero do folder atual.                     ³±±
±±³          ³ExpO -> oFolder=Objeto folder.                              ³±±
±±³          ³ExpA -> agetDad=GETDADO do folder a ser dado refresh.       ³±±
±±³          ³ExpA -> aColsX=aCols com as informacoes atuais e  destino.  ³±±
±±³          ³ExpA -> aHeaderX=aHeader com as informacoes origem/destino. ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FtFld (nFldDst, nFldAtu, oFolder, aGetDad, aColsX, aHeaderX)
	Local lRet	:=	.F.
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Efetua a Validacao da GetDados                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (Len (aColsX)>0)
		If (aGetDad[nFldAtu]:TudoOk ()) 
			lRet	:=	.T.
			aGetDad[nFldAtu]:oBrowse:lDisablePaint := .T.
			
			aColsX[nFldAtu] 	:= aClone(aCols)
			aHeaderX[nFldAtu] 	:= aClone(aHeader)
		
			N := Max (aGetDad[nFldDst]:oBrowse:nAt, 1)
			
			aCols  	:= aClone(aColsX[nFldDst])
			aHeader := aClone(aHeaderX[nFldDst])
			
			aGetDad[nFldDst]:oBrowse:lDisablePaint := .F.
			aGetDad[nFldDst]:oBrowse:Refresh(.T.)
		EndIf
	Else
		lRet	:=	.T.
	EndIf
Return (lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³AddAcols  ³ Autor ³Gustavo G. Rueda       ³ Data ³15.07.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Funcao para insercao da linha no aColsX.                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL1 -> lRet = .T.                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO -> oGetDad = GETDADO a ser atualizado.                 ³±±
±±³          ³ExpN -> nColDelete = Numero da coluna DELETE do GETDADOS.   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AddAcols (oGetDad, nColDelete, nFolder)
	Local 	nI		:=	0
	Local	nPos	:=	0
	Local 	cTipo	:=	""
	Local	lRet	:=	.T.
	Local	aGetDad	:=	{}
    //
	If (oGetDad<>NIL)
		If (".00"$AllTrim (aCols[n][2]))	//Sera permitido a insercao de uma nova linha quando o aCols estiver posicionado na primeira linha do GETDADO.
		    If (Empty (aCols[n][3])) .And. !aCols[n][nColDelete]
				Help (" ", 1, "CONTINVAL",, STR0115, 3, 0)		//"Todos os campos devem ser informados."
				Return (lRet)
		    EndIf
		    //
			nPos := n-1
		    aEval (aCols, {|x| Iif (x[nColDelete]==.F., nPos++,)})
		    nPos++
			aCols := Asize (aCols, Len(aCols)+1)
			aCols := Ains (aCols, nPos)
			aCols[nPos] := Array (Len (aHeader)+1)
			//
			For nI := 1 To Len(aHeader)
				cTipo := aHeader[nI][8]
				If cTipo $ "CM"
					aCols[nPos][nI] := Space(aHeader[nI][4])
				ElseIf cTipo == "N"
					aCols[nPos][nI] := 0
				ElseIf cTipo == "L"
					aCols[nPos][nI] := .F.
				ElseIf cTipo == "D"
					aCols[nPos][nI] := Ctod("")
				EndIf
			Next
			//
			aCols[nPos][1] := StrZero (nFolder, 3)
			aCols[nPos][Len (aHeader)+1] := .F.
			oGetDad:GOTO (nPos)
			Eval (oGetDad:obrowse:bDrawSelect)
		EndIf 
		aGetDad	:=	{oGetDad}
		FtRefre (@aGetDad)
	EndIf	
Return (lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³FtRefre   ³ Autor ³Gustavo G. Rueda       ³ Data ³15.07.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Atualizado de todos os objetos GETDADOS.                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL -> lRet = .T.                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpA -> aGetDad = Array contendo todos os objetos.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FtRefre (aGetDad) 
	Local 	nLoop 	:= 0 
	Local	lRet	:=	.T.
	//
	For nLoop := 1 To Len (aGetDad) 
		aGetDad[nLoop]:oBrowse:lDisablePaint := .F.
		aGetDad[nLoop]:oBrowse:Refresh(.T.)
	Next (nLoop)
Return (lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³xLinOk    ³ Autor ³Gustavo G. Rueda       ³ Data ³15.07.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Validacao da linha do GETDADO corrente.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL1 -> lRet = .T.                                         ³±±
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
User Function xLinOk ()
	Local	lRet	:=	.T.
	//
	If !(SubStr (AllTrim (aCols[n][2]), 4, 3)$".00") .And. !aCols[n][6]
		If (Empty (aCols[n][3])) .Or. (Empty (aCols[n][4]))
			Help (" ", 1, "CONTINVAL",, STR0115, 3, 0)
			lRet	:=	.F.
		EndIf
	EndIf
Return (lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³VldCod    ³ Autor ³Gustavo G. Rueda       ³ Data ³15.07.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Funcao de validacao do codigo inserido na coluna Sub-Codigo.|±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL1 -> lRet = .T.                                         ³±±
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
User Function VldCod ()
	Local	lRet	:=	.T.
	Local	nX		:=	0
	//
	For nX := 1 To Len (aCols)
		If (AllTrim (M->cCodigo)$aCols[nX][2]) .And. !aCols[nX][6] .And. nX<>n
			Help (" ", 1, "CCODEXST",, STR0116, 3, 0)
			lRet	:=	.F.
		EndIf
	Next (nX)
	//
	If !(Left (M->cCodigo, 3)$aCols[n][1])
		Help (" ", 1, "CCODCONT",, STR0117, 3, 0)
		lRet	:=	.F.	
	EndIf
	//
	If (n==1) .And. !(".00"$SubStr (AllTrim (M->cCodigo),4,3))
		Help (" ", 1, "NAOALT",, STR0118, 3, 0)
		lRet	:=	.F.	
	EndIf
Return (lRet)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³VldCodPr  ³ Autor ³Gustavo G. Rueda       ³ Data ³15.07.2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Funcao de validacao do codigo do produto inserido no aCols. |±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpL1 -> lRet = .T./.F.                                     ³±±
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
User Function VldCodPr ()
	Local	lRet	:=	.T.
	//
	SB1->(DbSetOrder (1))
	If (SB1->(DbSeek (xFilial ("SB1")+M->cCodProd)))
		aCols[n][4]	:=	SB1->B1_DESC
		aCols[n][5]	:=	SB1->B1_CONV
	Else
		Help (" ", 1, "NAOPRD",, STR0119, 3, 0)	//"Produto nao encontrado no cadastro."
		lRet	:=	.F.
	EndIf
Return (lRet)
