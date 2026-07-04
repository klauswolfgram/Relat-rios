/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "MDTR450.ch"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR450
Relatorio da programacao dos exames periodicos.
O usuario pode selecionar o codigo do exame, obtendo como resultado a
relacao de Funcionarios programado para realizar o Exame.Tambem podera
selecionar o codigo do Centro de Custo obtendo a relacao de exames por
funcionario por centro de custo, bem como o periodo desejado.
O usuario define se deseja relacionar todos os funcionarios
so os que nao realizaram, ou somente os que ja realizaram.

@type    function
@author  Marcio Costa
@since   12/01/2000
@sample  U_MDTR450()

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function MDTR450()

	Local nTamGrupExa := 0

	//Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	//Define Variaveis
	Local wnrel   := "MDTR450"
	Local limite  := 132
	Local cDesc1  := STR0001 //"Relatorio dos exames programados por funcionario. Atraves dos parametros o "
	Local cDesc2  := STR0002 //"usuario deve informar o numero do PCMSO, e podera selecionar: Exame, Periodo,"
	Local cDesc3  := STR0003 //"C.Custo entre outras opcoes disponiveis para um melhor aproveitamento.     "
	Local cString := "TM5"
	Local cF3CC := "SI3001"  //SI3 apenas do cliente

	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cF3CC := "CTT001"  //CTT apenas do cliente
	EndIf

	lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .T. , .F. )

	Private nomeprog    := "MDTR450"
	Private tamanho     := "M"
	Private aReturn     := { STR0008, 1,STR0004, 2, 2, 1, "",1 } //"Administracao" //"Zebrado"
	Private titulo      := STR0005   //"Programacao de Exames"
	Private ntipo       := 0
	Private nLastKey    := 0
	Private cPerg       := If(!lSigaMdtPS,"MDT450    ","MDT450PS  ")
	Private cabec1      := ''
	Private cabec2      := ''
	Private nSizeSI3    := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
	Private nSizeSRJ    := If((TAMSX3("RJ_FUNCAO")[1])< 1,4,(TAMSX3("RJ_FUNCAO")[1]))
	Private nSizeSQB    := If((TAMSX3("QB_DEPTO")[1]) < 1,9,(TAMSX3("QB_DEPTO")[1]))
	Private lTMW_Filial
	Private aVetinr     := {}
	Private cArqTrab    := ''
	Private aPerg	    := {}
	//Variaveis para impressão do modo Personalizado
	Private oReport
	Private oSection0, oSection1, oSection2, oSection3, oSection4, oSection5
	Private oCel0, oCel1, oCel2, oCel3

	cAliasCTT := "SI3"
	cCodCTT := "I3_CUSTO"
	cDescCTT := "SI3->I3_DESC"

	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cAliasCTT := "CTT"
		cCodCTT := "CTT_CUSTO"
		cDescCTT := "CTT->CTT_DESC01"
		nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
	EndIf

	If !MDTRESTRI(cPrograma)
		//Devolve variaveis armazenadas (NGRIGHTCLICK)
		NGRETURNPRM(aNGBEGINPRM)
		Return .F.
	EndIf

	/*----------------------------------------
	//PERGUNTA PADRÕES							|
	| 01  De PCMSO ?                     		|
	| 02  Até PCMSO ?                    		|
	| 03  De  Exame ?                    		|
	| 04  Ate Exame ?                    		|
	| 05  De  Data Programac. ?          		|
	| 06  Ate Data Programac. ?          		|
	| 07  De  Centro de Custo ?          		|
	| 08  Ate Centro de Custo ?          		|
	| 09  Imprimir Todos ?               		|
	| 10  Classificar por ?              		|
	|			1- Ficha, Exame, data    		|
	|	        2- Exame, Data          		|
	|	        3- Nome , Exame, data    		|
	|			4- C.Cus,Func,Data       		|
	|			5- Data,Ficha,Exam	     		|
	| 11  Listar Demitidos ?             		|
	|			1- NAO                   		|
	|			2- SIM                   		|
	| 12  Listar Totalizador ?           		|
	|			1- SIM                   		|
	|			2- NAO                   		|
	| 13  Tipo de Relatorio ?	       		    |
	|			1- ANALITICO             		|
	|			2- SINTETICO 			        |
	| 14  De Filial ?						    |
	| 15  Ate Filial ?           				|
	| 16  Considerar por ?						|
	|			1- Centro de Custo 				|
	|			2- Departamento					|
	| 17  Situações ?						    |
	//PERGUNTAS PRESTADOR DE SERVIÇO			|
	| 01  De Cliente ?                   		|
	| 02  Loja                           		|
	| 03  Até Cliente ?                  		|
	| 04  Loja	                         		|
	| 05  De PCMSO ?                     		|
	| 06  Até PCMSO ?                    		|
	| 07  De  Exame ?                    		|
	| 08  Ate Exame ?                    		|
	| 09  De  Data Programac. ?          		|
	| 10  Ate Data Programac. ?          		|
	| 11  De  Centro de Custo ?          		|
	| 12  Ate Centro de Custo ?          		|
	| 13  Imprimir Todos ?               		|
	| 14  Classificar por ?              		|
	|			1- Ficha, Exame, data    		|
	|	        2- Exame, Data          		|
	|	        3- Nome , Exame, data   		|
	|			4- C.Cus,Func,Data       		|
	|			5- Data,Ficha,Exam	     		|
	| 15  Listar Demitidos ?            		|
	|			1- NAO                   		|
	|			2- SIM                   		|
	| 16  Listar Totalizador ?          		|
	|			1- SIM                   		|
	|			2- NAO                   		|
	| 17  Tipo de Relatorio ?	       	        |
	|			1- ANALITICO             		|
	|			2- SINTETICO 					|
	| 18  De Filial ?							|
	| 19  Ate Filial ?           				|
	-----------------------------------------*/

	// Adicionando as perguntas relacionadas a Exames ao grupo de
	// campos 048 - "Exame".

	If TRepInUse()// Verifica se será o personalizado ou padrão
		// Interface de impressao
		oReport := ReportDef()
		oReport:SetLandscape(.T.)
		oReport:PrintDialog()
	Else
		// Verifica as perguntas selecionadas
		pergunte(cPerg,.F.)

		// Envia controle para a funcao SETPRINT
		wnrel:="MDTR450"

		wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

		If nLastKey == 27
			Set Filter to

			// Devolve variaveis armazenadas (NGRIGHTCLICK)

			NGRETURNPRM(aNGBEGINPRM)
			Return
		EndIf

		SetDefault(aReturn,cString)

		If nLastKey == 27
		Set Filter to
			// Devolve variaveis armazenadas (NGRIGHTCLICK)

			NGRETURNPRM(aNGBEGINPRM)
		Return
		EndIf

		If lSigaMdtps
			lTMW_Filial := .F.
			RptStatus({|lEnd| _R450Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
		Else
			RptStatus({|lEnd|R450Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
		EndIf
	EndIf

	//  Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT450FLVL
Valida os campos De/Ate Filial

@type    function
@author  Julia Kondlatsch
@since   04/08/2008
@sample  U_MDT450FLVL(1)

@param   nTipo, Numérico, Indica qual dos parâmetros irá validar 1 (De),
2 (Até)

@return  lRet, Lógico, Verdadeiro se o parâmetro é válido
/*/
//-------------------------------------------------------------------
User Function MDT450FLVL(nTipo)

	Local lRet := .T.
	Local cArea := Alias()
	Local aArea := SM0->(GetArea())

	If nTipo == 1
		If !Empty(Mv_par14)
			dbSelectArea("SM0")
			If !dbSeek(cEmpAnt+Mv_par14)
				Help(" ",1,"REGNOIS")
				lRet := .F.
			EndIf
			If Mv_par14 > Mv_par15
				Mv_par15 := Mv_par14
			EndIf
		EndIf
	Else
		If !Empty(Mv_par15)
			If  Mv_par15 <> Replicate("Z",Len(Mv_par15)) .And. Mv_par15 <> Replicate("9",Len(Mv_par15))
				If Mv_par14 > Mv_par15
					Help(" ",1,"DEATEINVAL")
					lRet := .F.
				Else
					dbSelectArea("SM0")
					If !dbSeek(cEmpAnt+Mv_par15)
						Help(" ",1,"REGNOIS")
						lRet := .F.
					EndIf
				EndIf
			EndIf
		Else
			Help( ' ', 1, STR0111,, STR0112, 2, 0,,,,,, {STR0113} )
			// "Atenção" # "É obrigatório informar o valor da pergunta 'Até Filial'" # "Favor inserir um valor na pergunta"
			lRet := .F.
		EndIf
	EndIf

	If Empty(Mv_par14) .And. (!Empty(Mv_par15) .And. Mv_par15 <> Replicate("Z",Len(Mv_par15)) )
		Help( ' ', 1, STR0111,, STR0114 + Replicate("Z",Len(Mv_par15)), 2, 0,,,,,, {STR0115} )
		// "Atenção" # "O parâmetro 'De filial' só pode ser vazio se o parâmetro de 'Até Filial' for preenchido com " #
		// "Favor inserir um intervalo de filiais válido"
		lRet := .F.
	EndIf

	RestArea(aArea)
	dbSelectArea(cArea)

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} R450Imp
Chamada do Relatório

@type    function
@author  Julia Kondlatsch
@since   01/06/1997
@sample  R450Imp(@lEnd, 'MDTR450', 'Programacao de Exames', 'M' )

@param   lEnd, Lógico, Indica o fim da impressão
@param   wnRel, Caracter, Nome do relatório
@param   titulo, Caracter, Título do relatório
@param   tamanho, Caracter, Tamanho do relatório

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
Static Function R450Imp(lEnd,wnRel,titulo,tamanho)

	Local cPCMSO	:= ""//Controla os PCMSO's impressos
	Local lFstPCMSO := .F.//Controle PCMSO impresso por Filial
	Local lMDTPS    := GetMv("MV_NGMDTPS") == 'S'

	//  Define Variaveis
	Local cRodaTxt := ""
	Local nCntImpr := 0, x, y, cont, nXYZ

	// Variaveis para controle do cursor de progressao do relatorio  -
	Local nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

	// Variaveis locais exclusivas deste programa
	Local cChave           := SPACE(16)
	Local lContinua        := .T.

	Private oTempExa

	//  Contadores de linha e pagina
	Private li := 80 ,m_pag := 1

	// Variaveis locais exclusivas deste programa
	// Private
	Private  cFicAnt := SPACE(9)
	Private  cNomAnt := SPACE(30)
	Private  aTotal450 := {}
	Private  nTotal450 := 0
	Private nTotReal :=0
	Private nTotNaoR :=0
	Private nTotAtra :=0
	Private nTotExam :=0

	//  Verifica se deve comprimir ou nao
	nTipo  := IIF(aReturn[4]==1,15,18)

	//  Monta os Cabecalhos
	If mv_par16 == 1 //Imprimir Centro de Custo
						// 0	        11      19                   40    46             61         72                      96                          124
		cabec1 := STR0009 //"Ficha      Mat.    Nome Funcionario     Sit.  Exame          Dt.Prog.   Centro Custo            Função                      Realizado"
	Else//Imprimir Departamento
		cabec1 := STR0006 //"Ficha      Mat.    Nome Funcionario     Sit.  Exame          Dt.Prog.   Departamento            Função                      Realizado"
	EndIf
	cabec2 := " "

			//           1         2         3         4         5         6         7         8         9         0         1         2         3
			// 0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
			// xx/xx/xx   xxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx/xx/xxxx   xxxxxxxxx     xx/xx/xxxx

			//           1         2         3         4         5         6         7         8         9         0         1         2         3
			// 0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345
			//"Ficha      Mat.    Nome Funcionario                Exame       Dt.Prog.   Centro Custo          Função                    Realizado"

	// Função que Monta a TRB
	oTempExa := MDT450TRB()//Chama função que monta TRB

	If Mv_par13 == 2
		cabec1 :=  STR0018 + MV_PAR01 //"Resumo da Programação de Exames - "
		somalinha()
		@ Li,000 PSay STR0019+Alltrim( Str(nTotReal,9) )  //"Exames Realizados.................: "
		somalinha()
		@ Li,000 PSay STR0020+Alltrim( Str(nTotNaoR,9) )  //"Exames Não Realizados - Pendentes.: "
		somalinha()
		@ Li,000 PSay STR0021+Alltrim( Str(nTotAtra,9) )  //"Exames Não Realizados - Atrasados.: "
		somalinha()
		@ Li,000 PSay STR0022+Alltrim( Str(nTotExam,9) )  //"Total de Exames Programados.......: "
		somalinha()
	Else
		Dbselectarea("TRB")
		Dbgotop()
		lFirst := .T.
		aExame:={}
		cSvFilial := "--"
		cPcmso := ""
		While !EoF()
			If cPCMSO <> TRB->PCMSO
				cPCMSO := TRB->PCMSO
				lFstPCMSO := .T.
				li := 80
				SomaLinha()
				@ Li,000 Psay "PCMSO: " + cPCMSO
				cSvFilial := ""
			EndIf
			If lTMW_Filial
				If TRB->FILFUN <> cSvFilial
					If !lFstPCMSO
						li := 80
						SomaLinha()
						@ Li,000 Psay "PCMSO: " + cPCMSO
					Else
						lFstPCMSO := .F.
					EndIf
					SomaLinha()
					cSvFilial := TRB->FILFUN
					@ Li,000 Psay STR0031 + ": " + TRB->FILFUN //"Filial"
					SomaLinha()
				EndIf
			ElseIf lMDTPS
			If lFirst
				SomaLinha()
				cCliente := SubStr(TRB->CC,1,6)

				DbSelectArea("SA1")
				DbSetOrder(01)
				DbSeek(xFilial("SA1")+cCliente)
				cNome := SA1->A1_NOME

				@ Li,000 Psay STR0010+cCliente //"Cliente :"
				@ Li,017 Psay cNome Picture "@!"
				SomaLinha()
				lFirst := .F.
			EndIf
			EndIf

			SomaLinha()
			IF mv_par10 == 1
				If cFicAnt <> TRB->FICHA
					cFicAnt := TRB->FICHA
					@ Li,000 PSay TRB->FICHA
					@ Li,011 PSay TRB->MAT
					@ LI,019 PSay SubStr(TRB->NOME,1,20)
				EndIf
			ElseIf mv_par10 == 2 .Or. mv_par10 == 5
				@ Li,000 PSay TRB->FICHA
				@ Li,011 PSay TRB->MAT
				@ LI,019 PSay SubStr(TRB->NOME,1,20)
				cFicAnt := TRB->FICHA
			ElseIf mv_par10 == 3
				IF cNomAnt <> TRB->NOME
					cNomAnt := TRB->NOME
					@ Li,000 PSay TRB->FICHA
					@ Li,011 PSay TRB->MAT
					@ LI,019 PSay SubStr(TRB->NOME,1,20)
				EndIf
			ELSE
				@ Li,000 PSay TRB->FICHA
				@ Li,011 PSay TRB->MAT
				@ Li,019 PSay SubStr(TRB->NOME,1,20)
				@ Li,040 PSay TRB->SITUAC
				@ Li,046 PSay SubStr(Alltrim(TRB->EXAME) + "-" + Alltrim(TRB->NOMEXA),1,13)
				@ Li,061 PSay TRB->DTPROG
				If mv_par16 == 1
					@ Li,072 PSay SubStr(Alltrim(TRB->CC) + "-" + Alltrim(TRB->DESCC),1,22)
				Else
					@ Li,072 PSay SubStr(Alltrim(TRB->DEPTO) + "-" + Alltrim(TRB->DESDP),1,22)
				EndIf
				@ Li,096 PSay SubStr(Alltrim(TRB->CODFUN) + "-" + Alltrim(TRB->NOMEFUN),1,26)
				@ Li,124 PSay TRB->DTREAL
				IF ASCAN(aEXAME,{|x| x[1]==TRB->EXAME})=0 // Matriz armazena codigo/nome da funcao para
					AADD(aEXAME,{TRB->EXAME,TRB->NOMEXA}) // imprimir resumo no final do relatorio.
				EndIf
			EndIf
			IF mv_par10 <> 4
				@ Li,040 PSay TRB->SITUAC
				@ Li,046 PSay SubStr(Alltrim(TRB->EXAME) + "-" + Alltrim(TRB->NOMEXA),1,13)
				@ Li,061 PSay TRB->DTPROG
				If mv_par16 == 1
					@ Li,072 PSay SubStr(Alltrim(TRB->CC) + "-" + Alltrim(TRB->DESCC),1,22)
				Else
					@ Li,072 PSay SubStr(Alltrim(TRB->DEPTO) + "-" + Alltrim(TRB->DESDP),1,22)
				EndIf
				@ Li,096 PSay SubStr(Alltrim(TRB->CODFUN) + "-" + Alltrim(TRB->NOMEFUN),1,26)
				@ Li,124 PSay TRB->DTREAL
			EndIf
			DbSelectArea("TRB")
			Dbskip()
		End
	EndIf
	// Imprime um totalizador de exames por centro de custo / funcao

	If mv_par12 == 1
		Cabec1 := " "

		ASORT(aTotal450,,,{|x,y| x[6]+x[1]+x[2] < y[6]+y[1]+y[2] })

			//           1         2         3         4         5         6         7         8         9         0         1         2         3
			// 0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
			// Total de exames por Centro de Custo / Função
			// -------------------------------------------------------------------------------------------------------------------------------------
			// Centro de Custo   Descrição                        Função    Descrição                        Quantidade Exames
			// -------------------------------------------------------------------------------------------------------------------------------------
			// 123456789         123456789012345678901234567890   12345     123456789012345678901234567890   9.999.999.999.999
			// Centro de Custo        Descrição                        Função    Descrição                        Quantidade Exames
			// 12345678901234567890   123456789012345678901234567890   12345     123456789012345678901234567890           9.999.999

		nCol01 := 0
		nCol02 := 18
		nCol03 := 51
		nCol04 := 61
		nCol05 := 94
		If nSizeSI3 > 15
			nCol02 += nSizeSI3 - 15
			nCol03 += nSizeSI3 - 15
			nCol04 += nSizeSI3 - 15
			nCol05 += nSizeSI3 - 15
		EndIf
		If lTMW_Filial
			nCol01 += 15
			nCol02 += 15
			nCol03 += 15
			nCol04 += 15
			nCol05 += 15
		EndIf

		For x := 1 to Len(aTotal450)
			If x == 1
				li := 80
				somalinha()
				@ Li,000 PSay STR0011 //"Total de exames por Centro de Custo / Função"
				somalinha()
				@ Li,000 PSAY __PrtThinLine()
				somalinha()
				If lTMW_Filial
					@ Li,000 PSay STR0031 //"Filial"
				EndIf
				@ Li,nCol01 PSay STR0012 //"Centro de Custo"
				@ Li,nCol02 PSay STR0013 //"Descrição"
				@ Li,nCol03 PSay STR0014 //"Função"
				@ Li,nCol04 PSay STR0013 //"Descrição"
				@ Li,nCol05 PSay STR0015 //"Quantidade Exames"
				somalinha()
				@ Li,000 PSAY __PrtThinLine()
			EndIf
			somalinha()
			If lTMW_Filial
				@ Li,000 PSay aTotal450[x,6] //Filial
			EndIf
			@ Li,nCol01 PSay aTotal450[x,1] //Cod. Centro Custo
			@ Li,nCol02 PSay aTotal450[x,5] //Desc Centro Custo
			@ Li,nCol03 PSay aTotal450[x,2] //Cod. Funcao
			@ Li,nCol04 PSay aTotal450[x,4] //Desc Funcao
			@ Li,nCol05 PSay aTotal450[x,3] Picture "@E 9,999,999,999,999" //Quantidade
		Next x

		If nTotal450 > 0
			Somalinha()
			Somalinha()
			@ Li,nCol04 PSay STR0016 //"Total Geral:"
			@ Li,nCol05 PSay nTotal450 Picture "@E 9,999,999,999,999" //Quantidade
		EndIf
	EndIf

	// Imprime um relatorio com a relacao dos codigos/nome das funcoes
	IF mv_par10 == 4
		For x:=1 to len(aExame)-1
			For y:=x+1 to len(aExame)
				IF aExame[x,1] > aExame[y,1]
					aAux:= aCLONE(aExame[x])
					aExame[x]:=aCLONE(aExame[y])
					aExame[y]:=aCLONE(aAux)
				EndIf
			NEXT y
		NEXT x
		somalinha()
		somalinha()
		@ Li,000 PSay STR0017 //"Relação dos códigos listados acima:"

		For cont:=1 to len(aEXAME)
			IF cont > 1
				SomaLinha()
			EndIf
			@ Li,038 PSay Alltrim(aEXAME[cont,1]) + " :  " + aEXAME[cont,2]
		NEXT cont
	EndIf

	// Devolve a condicao original do arquivo principal
	dbSelectArea("TRB")
	dbGotop()
	If RecCount()==0
		MsgInfo(STR0028)  //"Não há nada para imprimir no relatório."
		oTempExa:Delete()
		RetIndex("TM5")
		Set Filter To
		MS_FLUSH()
		Return .F.
	EndIf

	oTempExa:Delete()
	RetIndex("TM5")

	Set Filter To

	Set device to Screen

	If aReturn[5] = 1
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	EndIf
	//SET CENTURY ON
	MS_FLUSH()

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} _R450Imp
Chamada do Relatório p/ Prestador

@type    function
@author  Andre E. Perez Alvarez
@since   22/02/2008
@sample  R450Imp(@lEnd, 'MDTR450', 'Programacao de Exames', 'M' )

@param   lEnd, Lógico, Indica o fim da impressão
@param   wnRel, Caracter, Nome do relatório
@param   titulo, Caracter, Título do relatório
@param   tamanho, Caracter, Tamanho do relatório

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
Static Function _R450Imp(lEnd,wnRel,titulo,tamanho)

	// Define Variaveis
	Local cRodaTxt := ""
	Local x, y, cont
	Local cCliente := ""

	// Variaveis tipo Private padrao de todos os relatorios
	Private aVetinr := {}
	// Contadores de linha e pagina
	Private li := 80, m_pag := 1

	// Verifica se deve comprimir ou nao
	nTipo  := IIF(aReturn[4]==1,15,18)

	// Monta os Cabecalhos
	cabec1 := STR0023  //"PCMSO   Médico Responsável                        Dt. ini.   Dt. Fim   Dt. Gerac.  Descrição"
	cabec2 := STR0024  //"Ficha      Matric   Nome Funcionario                  Exame                              Dt.Progr.  Centro Custo          Realizado"

	IF mv_par14 == 4
		cabec2 := STR0025  //"Ficha     Mat.   Nome Funcionario                Exame   Dt.Prog.  Centro Custo          Função                             Realizado"
	EndIf

	//mv_par14 != 4
	/*        1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	-------------------------------------------------------------------------------------------------------------------------------------
	PCMSO   Médico Responsável                        Dt. ini.   Dt. Fim   Dt. Gerac.  Descrição
	Ficha      Matric   Nome Funcionario                  Exame                              Dt.Progr.  Centro Custo          Realizado
	-------------------------------------------------------------------------------------------------------------------------------------
	Cliente: 000001-0000 - Vale do Rio Doce S.A.

	123456  1234567890123456789012345678901234567890  01/01/08   01/01/08  01/01/08    1234567890123456789012345678901234567890
	123456789  123456   123456789012345678901234567890    123456789012345678901234567890123  01/01/08   12345678901234567890  01/01/08
	123456789  123456   123456789012345678901234567890    123456789012345678901234567890123  01/01/08   12345678901234567890  01/01/08
	123456789  123456   123456789012345678901234567890    123456789012345678901234567890123  01/01/08   12345678901234567890  01/01/08

	123456  1234567890123456789012345678901234567890  01/01/08   01/01/08  01/01/08    1234567890123456789012345678901234567890
	123456789  123456   123456789012345678901234567890    123456789012345678901234567890123  01/01/08   12345678901234567890  01/01/08
	123456789  123456   123456789012345678901234567890    123456789012345678901234567890123  01/01/08   12345678901234567890  01/01/08

	Total de Exames por Centro de Custo / Função
	-------------------------------------------------------------------------------------------------------------------------------------
	Centro de Custo       Descrição                                 Função  Descrição                                 Quantidade Exames
	-------------------------------------------------------------------------------------------------------------------------------------
	12345678901234567890  1234567890123456789012345678901234567890  12345   1234567890123456789012345678901234567890  1234567890
	12345678901234567890  1234567890123456789012345678901234567890  12345   1234567890123456789012345678901234567890  1234567890

	=====================================================================================================================================
	Cliente: 000001-0000 - Vale do Rio Doce S.A.

	123456  1234567890123456789012345678901234567890  01/01/08   01/01/08  01/01/08    1234567890123456789012345678901234567890
	123456789  123456   123456789012345678901234567890    123456789012345678901234567890123  01/01/08   12345678901234567890  01/01/08
	123456789  123456   123456789012345678901234567890    123456789012345678901234567890123  01/01/08   12345678901234567890  01/01/08
	123456789  123456   123456789012345678901234567890    123456789012345678901234567890123  01/01/08   12345678901234567890  01/01/08

	123456  1234567890123456789012345678901234567890  01/01/08   01/01/08  01/01/08    1234567890123456789012345678901234567890
	123456789  123456   123456789012345678901234567890    123456789012345678901234567890123  01/01/08   12345678901234567890  01/01/08
	123456789  123456   123456789012345678901234567890    123456789012345678901234567890123  01/01/08   12345678901234567890  01/01/08

	Total de Exames por Centro de Custo / Função
	-------------------------------------------------------------------------------------------------------------------------------------
	Centro de Custo       Descrição                                 Função  Descrição                                 Quantidade Exames
	-------------------------------------------------------------------------------------------------------------------------------------
	12345678901234567890  1234567890123456789012345678901234567890  12345   1234567890123456789012345678901234567890  1234567890
	12345678901234567890  1234567890123456789012345678901234567890  12345   1234567890123456789012345678901234567890  1234567890
	*/

	//mv_par14 = 4
	/*        1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	-------------------------------------------------------------------------------------------------------------------------------------
	PCMSO   Médico Responsável                        Dt. ini.   Dt. Fim   Dt. Gerac.  Descrição
	Ficha     Mat.   Nome Funcionario                Exame   Dt.Prog.  Centro Custo          Função                             Realizado
	-------------------------------------------------------------------------------------------------------------------------------------
	Cliente: 000001-0000 - Vale do Rio Doce S.A.

	123456  1234567890123456789012345678901234567890  01/01/08   01/01/08  01/01/08    1234567890123456789012345678901234567890
	123456789 123456 123456789012345678901234567890  123456  01/01/08  12345678901234567890  1234567890123456789012345678901234 01/01/08
	123456789 123456 123456789012345678901234567890  123456  01/01/08  12345678901234567890  12345-1234567890123456789012345678 01/01/08

	123456  1234567890123456789012345678901234567890  01/01/08   01/01/08  01/01/08    1234567890123456789012345678901234567890
	123456789 123456 123456789012345678901234567890  123456  01/01/08  12345678901234567890  1234567890123456789012345678901234 01/01/08
	123456789 123456 123456789012345678901234567890  123456  01/01/08  12345678901234567890  12345-1234567890123456789012345678 01/01/08

	Total de Exames por Centro de Custo / Função
	-------------------------------------------------------------------------------------------------------------------------------------
	Centro de Custo       Descrição                                 Função  Descrição                                 Quantidade Exames
	-------------------------------------------------------------------------------------------------------------------------------------
	12345678901234567890  1234567890123456789012345678901234567890  12345   1234567890123456789012345678901234567890  1234567890
	12345678901234567890  1234567890123456789012345678901234567890  12345   1234567890123456789012345678901234567890  1234567890

	Relação dos códigos listados acima:   NR7: Avaliação Clínica

	=====================================================================================================================================
	Cliente: 000001-0000 - Vale do Rio Doce S.A.

	123456  1234567890123456789012345678901234567890  01/01/08   01/01/08  01/01/08    1234567890123456789012345678901234567890
	123456789 123456 123456789012345678901234567890  123456  01/01/08  12345678901234567890  1234567890123456789012345678901234 01/01/08
	123456789 123456 123456789012345678901234567890  123456  01/01/08  12345678901234567890  12345-1234567890123456789012345678 01/01/08

	123456  1234567890123456789012345678901234567890  01/01/08   01/01/08  01/01/08    1234567890123456789012345678901234567890
	123456789 123456 123456789012345678901234567890  123456  01/01/08  12345678901234567890  1234567890123456789012345678901234 01/01/08
	123456789 123456 123456789012345678901234567890  123456  01/01/08  12345678901234567890  12345-1234567890123456789012345678 01/01/08

	Total de Exames por Centro de Custo / Função
	-------------------------------------------------------------------------------------------------------------------------------------
	Centro de Custo       Descrição                                 Função  Descrição                                 Quantidade Exames
	-------------------------------------------------------------------------------------------------------------------------------------
	12345678901234567890  1234567890123456789012345678901234567890  12345   1234567890123456789012345678901234567890  1234567890
	12345678901234567890  1234567890123456789012345678901234567890  12345   1234567890123456789012345678901234567890  1234567890

	Relação dos códigos listados acima:   NR7: Avaliação Clínica
	*/
	// Chama função que monta TRB
	oTempExa := MDT450TRBPS()

	If Mv_par17 == 2  //Sintetico

		cabec1 :=  STR0026  //"Resumo da Programação de Exames"
		cabec2 := ""

		Dbselectarea("TRBPCMSO")
		Dbgotop()
		While !EoF()

			cCliente := TRBPCMSO->CLIENT + TRBPCMSO->LOJA

			SomaLinha()
			@ Li,000 Psay STR0027 + TRBPCMSO->CLIENT + "-" + TRBPCMSO->LOJA + " - " + TRBPCMSO->NOMECLI  //"Cliente/Loja: "
			SomaLinha()
			SomaLinha()

			While !EoF() .And. cCliente == TRBPCMSO->CLIENT+TRBPCMSO->LOJA

				@ Li,000 PSay STR0030 + TRBPCMSO->PCMSO  //"PCMSO: "
				SomaLinha()

				@ Li,000 PSay STR0019+Alltrim( Str(TRBPCMSO->TOTREAL,9) )  //"Exames Realizados.................: "
				somalinha()
				@ Li,000 PSay STR0020+Alltrim( Str(TRBPCMSO->TOTNAOR,9) )  //"Exames Não Realizados - Pendentes.: "
				somalinha()
				@ Li,000 PSay STR0021+Alltrim( Str(TRBPCMSO->TOTATRA,9) )  //"Exames Não Realizados - Atrasados.: "
				somalinha()
				@ Li,000 PSay STR0022+Alltrim( Str(TRBPCMSO->TOTEXAM,9) )  //"Total de Exames Programados.......: "
				somalinha()
				somalinha()

				dbSkip()
			End

			@ Li,000 PSAY __PrtThinLine()

		End

	Else

		If mv_par14 == 4  //CC, Func., Data

			Dbselectarea("TRB")
			Dbgotop()

			While !EoF()

				cCliente := TRB->CLIENT+TRB->LOJA
				SomaLinha()
				@ Li,000 Psay STR0027 + TRB->CLIENT + "-" + TRB->LOJA + " - " + TRB->NOMECLI  //"Cliente/Loja: "
				SomaLinha()

				While !EoF() .And. cCliente == TRB->CLIENT+TRB->LOJA
					SomaLinha()
					cPCMSO := TRB->TMW_PCMSO
					@ Li,000 Psay TRB->TMW_PCMSO
					@ Li,008 Psay TRB->TMW_NOMUSU
					@ Li,050 Psay TRB->TMW_DTINIC
					@ Li,061 Psay TRB->TMW_DTFIM
					@ Li,072 Psay TRB->TMW_DTGERA
					@ Li,084 Psay TRB->TMW_DESCRI
					SomaLinha()
					While !EoF() .And. cCliente == TRB->CLIENT+TRB->LOJA .And. cPCMSO == TRB->TMW_PCMSO
						@ Li,000 PSay TRB->FICHA
						@ Li,011 PSay TRB->MAT
						@ LI,019 PSay substr(TRB->NOME,1,30)
						@ Li,051 PSay TRB->EXAME
						@ Li,063 PSay TRB->DTPROG
						@ LI,073 PSay substr(TRB->CC,1,20)
						@ Li,093 Psay Alltrim(TRB->CODFUN) + "-" + SubSTR(TRB->NOMEFUN,1,28-Len(Alltrim(TRB->CODFUN))+1 )
						@ Li,123 PSay TRB->DTREAL
						SomaLinha()
						dbSkip()
					End
				End

				SomaLinha()

				// Imprime um totalizador de exames por centro de custo / funcao

				If mv_par16 == 1

					nCol01 := 0
					nCol02 := 22
					nCol03 := 55
					nCol04 := 65
					nCol05 := 98
					If nSizeSI3 > 15
						nCol02 += nSizeSI3 - 15
						nCol03 += nSizeSI3 - 15
						nCol04 += nSizeSI3 - 15
						nCol05 += nSizeSI3 - 15
					EndIf

					//           1         2         3         4         5         6         7         8         9         0         1         2         3
					// 0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
					// Total de exames por Centro de Custo / Função
					// -------------------------------------------------------------------------------------------------------------------------------------
					// Centro de Custo       Descrição                        Função    Descrição                        Quantidade Exames
					// -------------------------------------------------------------------------------------------------------------------------------------
					// 12345678901234567890  123456789012345678901234567890   12345     123456789012345678901234567890   9.999.999.999.999

					@ Li,000 PSay STR0011 //"Total de exames por Centro de Custo / Função"
					somalinha()
					@ Li,000 PSAY __PrtThinLine()
					somalinha()
					@ Li,nCol01 PSay STR0012 //"Centro de Custo"
					@ Li,nCol02 PSay STR0013 //"Descrição"
					@ Li,nCol03 PSay STR0014 //"Função"
					@ Li,nCol04 PSay STR0013 //"Descrição"
					@ Li,nCol05 PSay STR0015 //"Quantidade Exames"
					somalinha()
					@ Li,000 PSAY __PrtThinLine()

					dbSelectArea("TRBCC")
					dbSeek( cCliente )

					While !EoF() .And. cCliente == TRBCC->(CLIENT+LOJA)
						somalinha()
						@ Li,nCol01 PSay TRBCC->CC //Cod. Centro Custo
						@ Li,nCol02 PSay SubSTR(TRBCC->DESCC,1,30) //Desc Centro Custo
						@ Li,nCol03 PSay TRBCC->CODFUN //Cod. Funcao
						@ Li,nCol04 PSay Substr(TRBCC->DESCFUN,1,30) //Desc Funcao
						@ Li,nCol05 PSay TRBCC->TOTAL Picture "@E 9,999,999,999,999" //Quantidade
						dbSkip()
					End

					dbSelectArea("TRBCCG")
					dbSeek( cCliente )

					Somalinha()
					Somalinha()
					@ Li,nCol04 PSay STR0016 //"Total Geral:"
					@ Li,nCol05 PSay TRBCCG->TOTAL Picture "@E 9,999,999,999,999" //Quantidade
					SomaLinha()
					SomaLinha()
				EndIf

				@ Li,000 PSAY __PrtThinLine()

				DbSelectArea("TRB")
				Dbskip()
			End

			// Imprime um relatorio com a relacao dos codigos/nome das funcoes
			somalinha()
			somalinha()
			@ Li,000 PSay STR0029 //"Relação dos códigos listados anteriormente:"

			dbSelectArea("TRBEXA")
			dbGoTop()

			While !EoF()
				@ Li,045 PSay Alltrim(TRBEXA->EXAME) + " :  " + TRBEXA->NOMEXA
				somalinha()
				dbSkip()
			End

		Else

			Dbselectarea("TRB")
			Dbgotop()

			While !EoF()

				cCliente := TRB->CLIENT+TRB->LOJA
				SomaLinha()
				@ Li,000 Psay STR0027 + TRB->CLIENT + "-" + TRB->LOJA + " - " + TRB->NOMECLI  //"Cliente/Loja: "
				SomaLinha()

				While !EoF() .And. cCliente == TRB->CLIENT+TRB->LOJA
					SomaLinha()
					cPCMSO := TRB->TMW_PCMSO
					@ Li,000 Psay TRB->TMW_PCMSO
					@ Li,008 Psay TRB->TMW_NOMUSU
					@ Li,050 Psay TRB->TMW_DTINIC
					@ Li,061 Psay TRB->TMW_DTFIM
					@ Li,072 Psay TRB->TMW_DTGERA
					@ Li,084 Psay TRB->TMW_DESCRI
					SomaLinha()
					While !EoF() .And. cCliente == TRB->CLIENT+TRB->LOJA .And. cPCMSO == TRB->TMW_PCMSO
						@ Li,000 PSay TRB->FICHA
						@ Li,011 PSay TRB->MAT
						@ LI,020 PSay TRB->NOME
						@ Li,054 PSay Substr(Alltrim(TRB->EXAME) + " - " + Alltrim(TRB->NOMEXA),1,34)
						@ Li,089 PSay TRB->DTPROG
						@ LI,100 PSay TRB->CC
						@ Li,122 PSay TRB->DTREAL
						SomaLinha()
						dbSkip()
					End
				End

				SomaLinha()

				// Imprime um totalizador de exames por centro de custo / funcao

				If mv_par16 == 1

					nCol01 := 0
					nCol02 := 22
					nCol03 := 55
					nCol04 := 65
					nCol05 := 98
					If nSizeSI3 > 15
						nCol02 += nSizeSI3 - 15
						nCol03 += nSizeSI3 - 15
						nCol04 += nSizeSI3 - 15
						nCol05 += nSizeSI3 - 15
					EndIf

					//           1         2         3         4         5         6         7         8         9         0         1         2         3
					// 0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
					// Total de exames por Centro de Custo / Função
					// -------------------------------------------------------------------------------------------------------------------------------------
					// Centro de Custo       Descrição                        Função    Descrição                        Quantidade Exames
					// -------------------------------------------------------------------------------------------------------------------------------------
					// 12345678901234567890  123456789012345678901234567890   12345     123456789012345678901234567890   9.999.999.999.999

					@ Li,000 PSay STR0011 //"Total de exames por Centro de Custo / Função"
					somalinha()
					@ Li,000 PSAY __PrtThinLine()
					somalinha()
					@ Li,nCol01 PSay STR0012 //"Centro de Custo"
					@ Li,nCol02 PSay STR0013 //"Descrição"
					@ Li,nCol03 PSay STR0014 //"Função"
					@ Li,nCol04 PSay STR0013 //"Descrição"
					@ Li,nCol05 PSay STR0015 //"Quantidade Exames"
					somalinha()
					@ Li,000 PSAY __PrtThinLine()

					dbSelectArea("TRBCC")
					dbSeek( cCliente )

					While !EoF() .And. cCliente == TRBCC->(CLIENT+LOJA)
						somalinha()
						@ Li,nCol01 PSay TRBCC->CC //Cod. Centro Custo
						@ Li,nCol02 PSay SubSTR(TRBCC->DESCC,1,30) //Desc Centro Custo
						@ Li,nCol03 PSay TRBCC->CODFUN //Cod. Funcao
						@ Li,nCol04 PSay Substr(TRBCC->DESCFUN,1,30) //Desc Funcao
						@ Li,nCol05 PSay TRBCC->TOTAL Picture "@E 9,999,999,999,999" //Quantidade
						dbSkip()
					End

					dbSelectArea("TRBCCG")
					dbSeek( cCliente )

					Somalinha()
					Somalinha()
					@ Li,nCol04 PSay STR0016 //"Total Geral:"
					@ Li,nCol05 PSay TRBCCG->TOTAL Picture "@E 9,999,999,999,999" //Quantidade
					SomaLinha()
					SomaLinha()
				EndIf

				@ Li,000 PSAY __PrtThinLine()

				DbSelectArea("TRB")
				Dbskip()
			End

		EndIf

	EndIf

	// Devolve a condicao original do arquivo principa
	If mv_par17 == 1  //Rel. Analitico
		dbSelectArea("TRB")
		dbGotop()
	Else
		dbSelectArea("TRBPCMSO")
		dbGotop()
	EndIf

	If RecCount()==0
		MsgInfo(STR0028)  //"Não há nada para imprimir no relatório."

		oTempExa:Delete()
		oTempCC:Delete()
		oTempCCG:Delete()
		oTempLisEx:Delete()
		oTempPCMSO:Delete()
		RetIndex("TM5")
		Set Filter To
		Return .F.
	EndIf

	oTempExa:Delete()
	oTempCC:Delete()
	oTempCCG:Delete()
	oTempLisEx:Delete()
	oTempPCMSO:Delete()
	RetIndex("TM5")

	Set Filter To

	Set device to Screen

	If aReturn[5] = 1
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	EndIf

	MS_FLUSH()

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} function
Incrementa Linha e Controla Salto de Pagina

@type    function
@author  Inacio Luiz Kolling
@since   01/06/1997
@sample  SomaLinha()
@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
Static Function Somalinha()
    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
    EndIf
Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT450TRB
Função responsavel pela montagem da TRB e por trazer os registros

@author Guilhrme Freudenburg
@since 13/08/2014
@return oTempTRB, Objeto, Estrutura da tabela temporária
/*/
//---------------------------------------------------------------------
Static Function MDT450TRB()

	Local nXYZ
	Local oTempTRB

	//  Define o Indice conforme a classificacao selecionada.
	aDBF := {}
	AADD(aDBF,{ "FILFUN"  , "C" ,Len(TMW->TMW_FILIAL), 0 })
	AADD(aDBF,{ "FICHA"   , "C" ,09, 0 })
	AADD(aDBF,{ "MAT"     , "C" ,06, 0 })
	AADD(aDBF,{ "NOME"    , "C" ,30, 0 })
	AADD(aDBF,{ "SITUAC"  , "C" ,01, 0 })
	AADD(aDBF,{ "EXAME"   , "C" ,If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1]), 0 })
	AADD(aDBF,{ "NOMEXA"  , "C" ,30, 0 })
	AADD(aDBF,{ "DTREAL"  , "D" ,08, 0 })
	AADD(aDBF,{ "DTPROG"  , "D" ,08, 0 })
	AADD(aDBF,{ "DEPTO"	  , "C" ,nSizeSQB, 0 })
	AADD(aDBF,{ "DESDP"	  , "C" ,34, 0 })
	AADD(aDBF,{ "CC"      , "C" ,nSizeSI3, 0 })
	AADD(aDBF,{ "DESCC"	  , "C" ,20, 0 })
	AADD(aDBF,{ "CODFUN"  , "C" ,nSizeSRJ, 0 })
	AADD(aDBF,{ "NOMEFUN" , "C" ,30, 0 })
	AADD(aDBF,{ "PCMSO"   , "C" ,06, 0 })

	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	IF mv_par10 == 1
		oTempTRB:AddIndex( "1", {"PCMSO","FILFUN","FICHA","EXAME","DTPROG" } )
	ElseIf mv_par10 == 2
		oTempTRB:AddIndex( "1", {"PCMSO","FILFUN","EXAME","DTPROG","FICHA" } )
	ElseIf mv_par10 == 3
		oTempTRB:AddIndex( "1", {"PCMSO","FILFUN","NOME","EXAME","DTPROG" } )
	ElseIf mv_par10 == 4
		oTempTRB:AddIndex( "1", {"PCMSO","FILFUN","CC","CODFUN","DTPROG" } )
	Else
		oTempTRB:AddIndex( "1", {"PCMSO","FILFUN","DTPROG","FICHA","EXAME" } )
	EndIf
	oTempTRB:Create()

	If mv_par13 == 2
		mv_par12 := 2
		mv_par10 := 1
	EndIf

	nTotExam := 0
	nTotNaoR := 0
	nTotAtra := 0
	nTotReal := 0

	aFilRelat := {}

	lTMW_Filial := !Empty(xFilial("TM5")) .And. Mv_par14 <> Mv_par15

	If lTMW_Filial
		aAreaSM0 := SM0->(GetArea())

		dbSelectArea("SM0")
		dbGoTop()
		If Empty(Mv_par14)
			dbSeek(cEmpAnt)
		Else
			dbSeek( cEmpAnt + Mv_par14 )
		EndIf
		While !EoF() .And. SM0->M0_CODIGO == cEmpAnt .And. SM0->M0_CODFIL <= Mv_par15
			aAdd( aFilRelat , FWCodFil())
			dbSkip()
		End
		RestArea(aAreaSM0)

	ElseIf Mv_par14 == Mv_par15
		aAdd( aFilRelat , Mv_par14 )
	Else
		aAdd( aFilRelat , FWCodFil())
	EndIf

	dbSelectArea("TM5")
	// SetRegua(LastRec())

	For nXYZ := 1 To Len(aFilRelat)

		dbSelectArea("TM5")
		dbSetOrder(03)
		dbSeek(xFilial("TM5",aFilRelat[nXYZ]) + MV_PAR01,.T.)
		While !EoF() .And. TM5->TM5_FILIAL == xFilial('TM5', aFilRelat[nXYZ]) .And. TM5->TM5_PCMSO <= MV_PAR02
			//IncRegua()

			If !Empty(TM5->TM5_FILFUN)
				If lTMW_Filial
					If TM5->TM5_FILFUN < Mv_par14 .Or. TM5->TM5_FILFUN > Mv_par15
						dbSelectArea("TM5")
						dbskip()
						Loop
					EndIf
				Else
					If TM5->TM5_FILFUN <> aFilRelat[nXYZ]
						dbSelectArea("TM5")
						dbskip()
						Loop
					EndIf
				EndIf
			EndIf

			If mv_par09 == 1 .Or. mv_par09 == 2 .And. Empty(TM5->TM5_DTRESU) .Or. mv_par09 == 3 .And. !Empty(TM5->TM5_DTRESU)

				If  TM5->TM5_EXAME   >= MV_PAR03  .And.;
					TM5->TM5_EXAME   <= MV_PAR04  .And.;
					TM5->TM5_DTPROG  >= MV_PAR05  .And.;
					TM5->TM5_DTPROG  <= MV_PAR06  .And.;
					TM5->TM5_CC      >= MV_PAR07  .And.;
					TM5->TM5_CC      <= MV_PAR08

					If mv_par11 == 1
						DbSelectArea("SRA")
						DbSetOrder(01)
						DbSeek(xFilial("SRA",TM5->TM5_FILFUN)+ TM5->TM5_MAT)
						If !Empty(SRA->RA_DEMISSA) .Or. SRA->RA_SITFOLHA == "D"
							dbSelectArea("TM5")
							dbskip()
							Loop
						EndIf
					EndIf

					DbSelectArea("TM0")
					DbSetOrder(01)
					DbSeek(xFilial("TM0",TM5->TM5_FILFUN)+TM5->TM5_NUMFIC)

					DbSelectArea("TM4")
					DbSetOrder(01)
					DbSeek(xFilial("TM4",TM5->TM5_FILFUN)+ TM5->TM5_EXAME)

					DbSelectArea("SRJ")
					DbSetOrder(01)
					DbSeek(xFilial("SRJ",TM5->TM5_FILFUN)+ TM5->TM5_CODFUN)

					DbSelectArea("TMW")
					DbSetOrder(01)
					DbSeek(xFilial("TMW")+ TM5->TM5_PCMSO)

					DbSelectArea("SRA")
					DbSetOrder(01)
					DbSeek(xFilial("SRA")+ TM5->TM5_MAT)

					If SRA->RA_SITFOLH $ MV_PAR17

						TRB->(DbAppend())
						TRB->FILFUN  := TM5->TM5_FILFUN
						TRB->FICHA   := TM5->TM5_NUMFIC
						TRB->MAT     := TM5->TM5_MAT
						TRB->NOME    := SUBSTR(TM0->TM0_NOMFIC,1,30)
						TRB->SITUAC  := SRA->RA_SITFOLH
						TRB->EXAME   := TM5->TM5_EXAME
						TRB->NOMEXA  := SUBSTR(TM4->TM4_NOMEXA,1,30)
						TRB->DTREAL  := TM5->TM5_DTRESU
						TRB->DTPROG  := TM5->TM5_DTPROG
						TRB->CC      := TM5->TM5_CC
						TRB->DESCC   := Posicione( 'CTT', 1, FWxFilial( 'CTT' ) + TM5->TM5_CC, 'CTT_DESC01' )
						TRB->DEPTO   := SRA->RA_DEPTO
						TRB->DESDP   := If( !Empty(SRA->RA_DEPTO) ,  Posicione("SQB",1,xFilial("SQB")+SRA->RA_DEPTO,"QB_DESCRIC") , "" )
						TRB->CODFUN  := TM5->TM5_CODFUNad
						TRB->NOMEFUN := SRJ->RJ_DESC
						TRB->PCMSO   := TM5->TM5_PCMSO

						If mv_par12 == 1
							nPosCC := aScan( aTotal450 ,{|x| x[1]+x[2]+x[6] == TRB->CC + TRB->CODFUN + TRB->FILFUN })
							If nPosCC == 0
								dbSelectArea(cAliasCTT)
								dbSetOrder(1)
								dbSeek( xFilial(cAliasCTT,TM5->TM5_FILFUN) + TRB->CC )
								aADD( aTotal450 , { TRB->CC , ;
													TRB->CODFUN , ;
													1 , ;
													Substr( TRB->NOMEFUN ,1,30) , ;
													Substr( &(cDescCTT) ,1,30),;
													TRB->FILFUN } )
							Else
								aTotal450[nPosCC,3] ++
							EndIf
							nTotal450 ++
						EndIf
						If mv_par13 == 2
							nTotExam++
							If Empty(TM5->TM5_DTRESU)
								If TM5->TM5_DTPROG < dDataBase
									nTotAtra++
								Else
									nTotNaoR++
								EndIf
							Else
								nTotReal++
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
			dbSelectArea("TM5")
			dbskip()
		End
	Next nXYZ

Return oTempTRB

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT450TRBPS
Função responsavel pela montagem da TRB e a busca das informações,
que serão impressas.
OBS. Modo Prestador de Serivço

@author Guilhrme Freudenburg
@since 13/08/2014
@return oTempExa, Objeto, Estrutura da tabela temporária
/*/
//---------------------------------------------------------------------
Static Function MDT450TRBPS()

	Local nXYZ
	Local oTempExa, oTempCC, oTempCCG, oTempLisEx, oTempPCMSO

	//Exames
	aDBF := {}
	AADD(aDBF,{ "FICHA"   , "C" ,09, 0 })
	AADD(aDBF,{ "MAT"     , "C" ,06, 0 })
	AADD(aDBF,{ "NOME"    , "C" ,30, 0 })
	AADD(aDBF,{ "EXAME"   , "C" ,If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1]), 0 })
	AADD(aDBF,{ "NOMEXA"  , "C" ,30, 0 })
	AADD(aDBF,{ "DTREAL"  , "D" ,08, 0 })
	AADD(aDBF,{ "DTPROG"  , "D" ,08, 0 })
	AADD(aDBF,{ "CC"      , "C" ,nSizeSI3, 0 })
	AADD(aDBF,{ "CODFUN"  , "C" ,nSizeSRJ, 0 })
	AADD(aDBF,{ "NOMEFUN" , "C" ,24, 0 })

	AADD(aDBF,{ "TMW_PCMSO"  , "C" ,06, 0 })
	AADD(aDBF,{ "TMW_NOMUSU" , "C" ,40, 0 })
	AADD(aDBF,{ "TMW_DTINIC" , "D" ,08, 0 })
	AADD(aDBF,{ "TMW_DTFIM"  , "D" ,08, 0 })
	AADD(aDBF,{ "TMW_DTGERA" , "D" ,08, 0 })
	AADD(aDBF,{ "TMW_DESCRI" , "C" ,40, 0 })

	AADD(aDBF,{ "CLIENT"  , "C" ,nTa1, 0 })
	AADD(aDBF,{ "LOJA"    , "C" ,nTa1L, 0 })
	AADD(aDBF,{ "NOMECLI" , "C" ,40, 0 })

	oTempExa := FWTemporaryTable():New( "TRB", aDBF )
	//Define o Indice conforme a classificacao selecionada
	IF mv_par14 == 1
		oTempExa:AddIndex( "1", {"CLIENT","LOJA","TMW_PCMSO","FICHA","EXAME","DTPROG" } )
	ElseIf mv_par14 == 2
		oTempExa:AddIndex( "1", {"CLIENT","LOJA","TMW_PCMSO","EXAME","DTPROG","FICHA" } )
	ElseIf mv_par14 == 3
		oTempExa:AddIndex( "1", {"CLIENT","LOJA","TMW_PCMSO","NOME","EXAME","DTPROG" } )
	ElseIf mv_par14 == 4
		oTempExa:AddIndex( "1", {"CLIENT","LOJA","TMW_PCMSO","CC","CODFUN","DTPROG" } )
	Else
		oTempExa:AddIndex( "1", {"CLIENT","LOJA","TMW_PCMSO","DTPROG","FICHA","EXAME" } )
	EndIf
	oTempExa:Create()

	//Total C.C. - Funcao
	aDBF := {}
	AADD(aDBF,{ "CLIENT" , "C", nTa1 , 0 })
	AADD(aDBF,{ "LOJA"   , "C", nTa1L, 0 })
	AADD(aDBF,{ "CC"     , "C", nSizeSI3, 0 })
	AADD(aDBF,{ "DESCC"  , "C", 40, 0 })
	AADD(aDBF,{ "CODFUN" , "C", nSizeSRJ, 0 })
	AADD(aDBF,{ "DESCFUN", "C", 40, 0 })
	AADD(aDBF,{ "TOTAL"  , "N", 14, 0 })

	//Cria TRB
	oTempCC := FWTemporaryTable():New( "TRBCC", aDBF )
	oTempCC:AddIndex( "1", {"CLIENT","LOJA","CC","CODFUN" } )
	oTempCC:Create()

	//Total Geral C.C. - Funcao
	aDBF := {}
	AADD(aDBF,{ "CLIENT" , "C", nTa1, 0 })
	AADD(aDBF,{ "LOJA"   , "C", nTa1L, 0 })
	AADD(aDBF,{ "TOTAL"  , "N", 14, 0 })

	//Cria TRB
	oTempCCG := FWTemporaryTable():New( "TRBCCG", aDBF )
	oTempCCG:AddIndex( "1", {"CLIENT","LOJA" } )
	oTempCCG:Create()

	//Listagem dos Exames (mv_par14 == 4)  (classificacao por CC, Funcao, Data)
	aDBF := {}
	AADD(aDBF,{ "EXAME"  , "C" ,If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1]), 0 })
	AADD(aDBF,{ "NOMEXA" , "C" ,20, 0 })

	//Cria TRB
	oTempLisEx := FWTemporaryTable():New( "TRBEXA", aDBF )
	oTempLisEx:AddIndex( "1", {"EXAME" } )
	oTempLisEx:Create()

	//Total Exames  (mv_par17 = 2)  (sintetico)
	aDBF := {}
	AADD(aDBF,{ "CLIENT" , "C", nTa1, 0 })
	AADD(aDBF,{ "LOJA"   , "C", nTa1L, 0 })
	AADD(aDBF,{ "NOMECLI", "C" ,40, 0 })
	AADD(aDBF,{ "PCMSO"  , "C" ,06, 0 })
	AADD(aDBF,{ "TOTEXAM", "N", 8, 0 })  //Total Geral
	AADD(aDBF,{ "TOTATRA", "N", 8, 0 })  //Nao realizados atrasados
	AADD(aDBF,{ "TOTNAOR", "N", 8, 0 })  //Nao realizados
	AADD(aDBF,{ "TOTREAL", "N", 8, 0 })  //Realizados

	//Cria TRB
	oTempPCMSO := FWTemporaryTable():New( "TRBPCMSO", aDBF )
	oTempPCMSO:AddIndex( "1", {"CLIENT","LOJA","PCMSO" } )
	oTempPCMSO:Create()

	If mv_par17 == 2  //Sintetico
		mv_par16 := 2  //Nao listar totalizador
		mv_par14 := 1  //Classificar por ficha, exame, data
	EndIf

	dbSelectArea("TM5")
	dbSetOrder(07)  //TM5_FILIAL+TM5_CC+TM5_EXAME
	dbSeek(xFilial("TM5") + MV_PAR11,.T.)

	//SetRegua(LastRec())
	// Correr TM5 para ler os  Exames Programados

	While !EoF() .And. TM5->TM5_FILIAL  == xFilial('TM5') .And. TM5->TM5_CC <= MV_PAR12

	//	IncRegua()

		cCliente := Substr(TM5->TM5_CC,1,nSizeTD)

		//Imprimir
		//1. Todos
		//2. Nao realizados
		//3. Ja realizados
		If mv_par13 == 1 .Or. ( mv_par13 == 2 .And. EMPTY(TM5->TM5_DTRESU) ) .Or. ( mv_par13 == 3 .And. !EMPTY(TM5->TM5_DTRESU) )

			IF TM5->TM5_EXAME   >= MV_PAR07    .And.;
			TM5->TM5_EXAME   <= MV_PAR08    .And.;
			TM5->TM5_DTPROG  >= MV_PAR09    .And.;
			TM5->TM5_DTPROG  <= MV_PAR10    .And.;
			TM5->TM5_PCMSO   >= MV_PAR05    .And.;
			TM5->TM5_PCMSO   <= MV_PAR06    .And.;
			!Empty(TM5->TM5_PCMSO)		   .And.;
			cCliente >= MV_PAR01+MV_PAR02   .And.;
			cCliente <= MV_PAR03+MV_PAR04

				If mv_par15 == 1      //Nao listar demitidos
					DbSelectArea("SRA")
					DbSetOrder(01)
					DbSeek(xFilial("SRA")+ TM5->TM5_MAT)
					If !Empty(SRA->RA_DEMISSA) .Or. SRA->RA_SITFOLHA == "D"
						dbSelectArea("TM5")
						dbskip()
						Loop
					EndIf
				EndIf

				DbSelectArea("TM0")
				DbSetOrder(01)
				DbSeek(xFilial("TM0")+TM5->TM5_NUMFIC)

				If mv_par17 == 1  //Rel. Analitico

					DbSelectArea("TM4")
					DbSetOrder(01)
					DbSeek(xFilial("TM4")+ TM5->TM5_EXAME)

					DbSelectArea("SRJ")
					DbSetOrder(01)
					DbSeek(xFilial("SRJ")+ TM5->TM5_CODFUN)

					DbSelectArea("TMW")
					DbSetOrder(01)
					DbSeek(xFilial("TMW")+ TM5->TM5_PCMSO)

					DbSelectArea(cAliasCTT)
					DbSetOrder(01)
					DbSeek(xFilial(cAliasCTT)+ TM5->TM5_CC)

					TRB->(DbAppend())
					TRB->FICHA   := TM5->TM5_NUMFIC
					TRB->MAT     := TM5->TM5_MAT
					TRB->NOME    := SUBSTR(TM0->TM0_NOMFIC,1,30)
					TRB->EXAME   := TM5->TM5_EXAME
					TRB->NOMEXA  := SUBSTR(TM4->TM4_NOMEXA,1,30)
					TRB->DTREAL  := TM5->TM5_DTRESU
					TRB->DTPROG  := TM5->TM5_DTPROG
					TRB->CC      := TM5->TM5_CC
					TRB->CODFUN  := TM5->TM5_CODFUN
					TRB->NOMEFUN := SRJ->RJ_DESC
					TRB->TMW_PCMSO  := TM5->TM5_PCMSO
					TRB->TMW_NOMUSU := NGSEEK("TMK",TMW->TMW_CODUSU,1,"TMK->TMK_NOMUSU")
					TRB->TMW_DTINIC := TMW->TMW_DTINIC
					TRB->TMW_DTFIM  := TMW->TMW_DTFIM
					TRB->TMW_DTGERA := TMW->TMW_DTGERA
					TRB->TMW_DESCRI := TMW->TMW_DESCRI
					TRB->CLIENT     := TM0->TM0_CLIENT
					TRB->LOJA       := TM0->TM0_LOJA
					TRB->NOMECLI    := NGSEEK("SA1",TM0->TM0_CLIENT+TM0->TM0_LOJA,1,"SA1->A1_NOME")

					If mv_par16 == 1  //Listar totalizador
						dbSelectArea("TRBCC")  //Total do C.C.-Funcao
						If dbSeek(TM0->TM0_CLIENT+TM0->TM0_LOJA+TM5->TM5_CC+TM5->TM5_CODFUN)
							RecLock("TRBCC",.F.)
							TRBCC->TOTAL ++
							MSUnlock("TRBCC")
						Else
							TRBCC->(DbAppend())
							TRBCC->CLIENT := TM0->TM0_CLIENT
							TRBCC->LOJA   := TM0->TM0_LOJA
							TRBCC->CC     := TM5->TM5_CC
							TRBCC->DESCC  := &(cDescCTT)
							TRBCC->CODFUN := TM5->TM5_CODFUN
							TRBCC->DESCFUN := SRJ->RJ_DESC
							TRBCC->TOTAL  := 1
						EndIf

						dbSelectArea("TRBCCG")  //Total Geral dos C.C.-Funcao
						If dbSeek(TM0->TM0_CLIENT+TM0->TM0_LOJA)
							RecLock("TRBCCG",.F.)
							TRBCCG->TOTAL ++
							MSUnlock("TRBCCG")
						Else
							TRBCCG->(DbAppend())
							TRBCCG->CLIENT := TM0->TM0_CLIENT
							TRBCCG->LOJA   := TM0->TM0_LOJA
							TRBCCG->TOTAL  := 1
						EndIf
					EndIf

					If mv_par14 == 4  //Classificar por CC, Func, Data
						dbSelectArea("TRBEXA")
						If !dbSeek(TM5->TM5_EXAME)
							TRBEXA->(DbAppend())
							TRBEXA->EXAME  := TM5->TM5_EXAME
							TRBEXA->NOMEXA := TM4->TM4_NOMEXA
						EndIf
					EndIf

				Else  //Rel. Sintetico

					dbSelectArea("TRBPCMSO")
					If dbSeek(TM0->TM0_CLIENT+TM0->TM0_LOJA+TM5->TM5_PCMSO)
						RecLock("TRBPCMSO",.F.)
						TRBPCMSO->TOTEXAM ++
						If Empty(TM5->TM5_DTRESU)
							If TM5->TM5_DTPROG < dDataBase
								TRBPCMSO->TOTATRA ++
							Else
								TRBPCMSO->TOTNAOR ++
							EndIf
						Else
							TRBPCMSO->TOTREAL ++
						EndIf
						MSUnlock("TRBPCMSO")
					Else
						RecLock("TRBPCMSO",.T.)
						TRBPCMSO->CLIENT  := TM0->TM0_CLIENT
						TRBPCMSO->LOJA    := TM0->TM0_LOJA
						TRBPCMSO->NOMECLI := NGSEEK("SA1",TM0->TM0_CLIENT+TM0->TM0_LOJA,1,"SA1->A1_NOME")
						TRBPCMSO->PCMSO   := TM5->TM5_PCMSO
						TRBPCMSO->TOTEXAM := 1
						If Empty(TM5->TM5_DTRESU)
							If TM5->TM5_DTPROG < dDataBase
								TRBPCMSO->TOTATRA := 1
							Else
								TRBPCMSO->TOTNAOR := 1
							EndIf
						Else
							TRBPCMSO->TOTREAL := 1
						EndIf
						MSUnlock("TRBPCMSO")
					EndIf

				EndIf

			EndIf

		EndIf

		dbSelectArea("TM5")
		dbskip()
	End

Return oTempExa

//---------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Função que trás as perguntas (SX1) no modo Personalizado e monta as Section

@author Guilhrme Freudenburg
@since 13/08/2014
@return oReport , Objeto, Contém a estrutura do Relatório
/*/
//---------------------------------------------------------------------
Static Function ReportDef()

	Local X := 0
	Local nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
	Local nSizeExa := If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1])
	Local nSizeNEx := If(TAMSX3("TM4_NOMEXA")[1] < 1, 40, TAMSX3("TM4_NOMEXA")[1])
	Local nSizeFun := If((TAMSX3("RJ_FUNCAO")[1]) < 1,4,(TAMSX3("RJ_FUNCAO")[1]))
	Local nTa1 := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
	Local nTa1L := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))

	Private nTotGeral:=0 //Total Geral da quantidade de Exames.
	Private aTotal450 := {}
	Private nTotal450 := 0
	Private nX:=0

	oReport := TReport():New("MDTR450",OemToAnsi(STR0078),cPerg,{|oReport| TReport(oReport)},STR0078+STR0079+STR0080)//Programação de Exames.

	Pergunte(oReport:uParam,.F.)

	If lSigaMdtPS
		oSection5 := TRSection():New (oReport,"Cliente/Loja", {"TRB"}) //Cliente/Loja
		oCel0 := TRCell():New (oSection5, "TRB->CLIENT"		, "TRB" , STR0079			, "@!"	, nTa1+8	, .T., /*{|| code-block de impressao }*/ ) //"Cliente/Loja"
		oCel0 := TRCell():New (oSection5, "TRB->LOJA"		, "TRB" , ""				, "@!"	, nTa1L+8	, .T., /*{|| code-block de impressao }*/ )
		oCel0 := TRCell():New (oSection5, "TRB->NOMECLI"	, "TRB" , ""				, "@!"	, 50		, .T., /*{|| code-block de impressao }*/ )
	EndIf

	oSection0 := TRSection():New (oReport,"PCMSO", {"TRB"}) //PCMSO
	If !lSigaMdtPs
		oCel0 := TRCell():New (oSection0, "TRB->PCMSO"	, "TRB" , STR0080	, "@!"	, 16, .T., /*{|| code-block de impressao }*/ ) //"PCMSO"
	Else
		oCel0 := TRCell():New (oSection0, "TMW_PCMSO"	, "TRB" , STR0080	, "@!"	, 16, .T., /*{|| code-block de impressao }*/ ) //"PCMSO"
	EndIf
	If lSigaMdtPs
		oCel0 := TRCell():New (oSection0, "TMW_NOMUSU"	, "TRB" , STR0081		, "@!"		  , 50, .T., /*{|| code-block de impressao }*/ ) //"Médico Responsavel"
		oCel0 := TRCell():New (oSection0, "TMW_DTINIC"	, "TRB" , STR0082		, "99/99/9999", 16, .T., /*{|| code-block de impressao }*/ ) //"Dt. Ini."
		oCel0 := TRCell():New (oSection0, "TMW_DTFIM"	, "TRB" , STR0083		, "99/99/9999", 16, .T., /*{|| code-block de impressao }*/ ) //"Dt. Fim"
		oCel0 := TRCell():New (oSection0, "TMW_DTGERA"	, "TRB" , STR0084		, "99/99/9999", 16, .T., /*{|| code-block de impressao }*/ ) //"Dt. Greac."
		oCel0 := TRCell():New (oSection0, "TMW_DESCRI"	, "TRB" , STR0085		, "@!"		  , 50, .T., /*{|| code-block de impressao }*/ ) //"Descrição"
	EndIf

	oSection1 := TRSection():New (oReport,, {"TRB"}) //PCMSO
	oCel1 := TRCell():New (oSection1, "TRB->FICHA" 	, "TRB" , STR0086	, "@!"			, 20			, .T., /*{|| code-block de impressao }*/ ) //"Ficha"
	oCel1 := TRCell():New (oSection1, "TRB->MAT" 	, "TRB" , STR0087	, "@!"			, 16			, .T., /*{|| code-block de impressao }*/ ) //"Mat."
	oCel1 := TRCell():New (oSection1, "TRB->NOME"  	, "TRB" , STR0088	, "@!"			, 30			, .T., /*{|| code-block de impressao }*/ ) //"Nome Funcionário"
	oCel1 := TRCell():New (oSection1, "TRB->SITUAC" , "TRB" , STR0109 	, "@!"			, 6				, .T., /*{|| code-block de impressao }*/ ) //"Sit."
	oCel1 := TRCell():New (oSection1, "TRB->EXAME"	, "TRB" , STR0089	, "@!"			, nSizeExa+10 	, .T., /*{|| code-block de impressao }*/ ) //"Exame"
	oCel1 := TRCell():New (oSection1, "TRB->NOMEXA"	, "TRB" , STR0085	, "@!"			, nSizeNEx+5 	, .T., /*{|| code-block de impressao }*/ ) //"Descrição"
	oCel1 := TRCell():New (oSection1, "TRB->DTPROG" , "TRB" , STR0090	, "99/99/9999"	, 20			, .T., /*{|| code-block de impressao }*/ ) //"Dt. Progr."
	oCel1 := TRCell():New (oSection1, "TRB->DTREAL" , "TRB" , STR0092	, "99/99/9999"	, 20 			, .T., /*{|| code-block de impressao }*/ ) //"Realizado"

	oCel1 := TRCell():New (oSection1, "TRB->CC"  	, "TRB" , STR0091	, "@!", nSizeSI3+5	, .T., {|| If( mv_par16 == 1, TRB->CC    , TRB->DEPTO) } ) //"C.Custo/Depart."
	oCel1 := TRCell():New (oSection1, "TRB->DESCC"  , "TRB" , STR0085	, "@!", 30			, .T., {|| If( mv_par16 == 1, TRB->DESCC , TRB->DESDP) }  ) //"Descrição"

	oCel1 := TRCell():New (oSection1, "TRB->CODFUN" , "TRB" , STR0110	, "@!"		  	, nSizeSRJ+5	, .T., /*{|| code-block de impressao }*/ ) //"Função"
	oCel1 := TRCell():New (oSection1, "TRB->NOMEFUN", "TRB" , STR0085	, "@!"		  	, 40 			, .T., /*{|| code-block de impressao }*/ ) //"Descrição"

	oSection2 := TRSection():New (oReport,STR0093, {"aTotal450"}) //"Total de exames por Centro de Custo / Função"
	oCel2 := TRCell():New (oSection2, "" ,"" , STR0093 	, "@!"	, 20, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Total de exames por Centro de Custo / Função"

	If !lSigaMdtPs
		oSection3 := TRSection():New (oReport,STR0093 ,{"TRB"} ) //"Total de exames por Centro de Custo / Função"
		oCel3 := TRCell():New (oSection3, "aTotal450[X,1]" ," " , STR0094	, "@!"						, nSizeSI3+10	, .T., {|| aTotal450[nX,1] } ) //"Centro de Custo"
		oCel3 := TRCell():New (oSection3, "aTotal450[X,5]" ," " , STR0085	, "@!"						, 40			, .T., {|| aTotal450[nX,5] } ) //"Descrição"
		oCel3 := TRCell():New (oSection3, "aTotal450[X,2]" ," " , STR0096	, "@!"						, nSizeFun+10	, .T., {|| aTotal450[nX,2] } ) //"Função"
		oCel3 := TRCell():New (oSection3, "aTotal450[X,4]" ," " , STR0085	, "@!"						, 40			, .T., {|| aTotal450[nX,4] } ) //"Descrição"
		oCel3 := TRCell():New (oSection3, "aTotal450[X,3]" ," " , STR0095	, "@E 9,999,999,999,999"	, 20			, .T., {|| aTotal450[nX,3] } ) //"Quantidade Exames"
	Else
		oSection3 := TRSection():New (oReport,STR0093,{"TRBCC"} ) //"Total de exames por Centro de Custo / Função"
		oCel3 := TRCell():New (oSection3, "TRBCC->CC" 		," " , STR0094	, "@!"						, nSizeSI3+10	, .T.,/* {|| }*/ ) //"Centro de Custo"
		oCel3 := TRCell():New (oSection3, "TRBCC->DESCC" 	," " , STR0085	, "@!"						, 40			, .T.,/* {|| }*/ ) //"Descrição"
		oCel3 := TRCell():New (oSection3, "TRBCC->CODFUN" 	," " , STR0096	, "@!"						, nSizeFun+10	, .T.,/* {|| }*/ ) //"Função"
		oCel3 := TRCell():New (oSection3, "TRBCC->DESCFUN" 	," " , STR0085	, "@!"						, 40			, .T.,/* {|| }*/ ) //"Descrição"
		oCel3 := TRCell():New (oSection3, "TRBCC->TOTAL" 	," " , STR0095	, "@E 9,999,999,999,999"	, 20			, .T.,/* {|| }*/ ) //"Quantidade Exames"
	EndIf
	oSection4 := TRSection():New (oReport,STR0097, {"aTotal450"}) //"Total Geral"
	oCel2 := TRCell():New (oSection4, "TOTGERAL" ,"" , STR0098	, "@E 9,999,999,999,999"	, 20, .T., {|| nTotGeral } ) //"Total Geral:"


Return oReport

//---------------------------------------------------------------------
/*/{Protheus.doc} TReport
Função responsavel por dar inicio a impressão

@author Guilhrme Freudenburg
@since  13/08/2014

@param  oReport - Objeto da impressão
@return Nil, Sempre Nulo
/*/
//---------------------------------------------------------------------
Static Function TReport(oReport)

	Local cPCMSO:=""
	Local X
	Local lRegTRB := .T.

	Private aTotal450 := {}//Array que recebe os centro de custo
	Private nTotal450 := 0//Variavel de controle dos centros de custo
	Private oTempExa

	nTotGeral:=0//Zera a variavel
	// Chama função que Monta TRB
	If !lSigaMdtPs
		oTempExa := MDT450TRB()
	Else
		oTempExa := MDT450TRBPS()
	EndIf

	//Deleta as TRBs criadas por estarem vazias.
	If Select("TRB") > 0 .Or. Select("TRBCC") > 0
		If Select("TRB") > 0 //Verifica se a TRB foi criada.
			dbSelectArea( "TRB" )
			If TRB->(reccount()) < 1
				lRegTRB := .F.
			EndIf
		EndIf
		If lRegTRB .And. Select("TRBCC") > 0 //Verifica se a TRB foi criada.
			dbSelectArea( "TRBCC" )
			If TRBCC->(reccount()) < 1
				lRegTRB := .F.
			EndIf
		EndIf
	Else
		lRegTRB := .F.
	EndIf

	If !lRegTRB
		MsgInfo(STR0028)  //"Não há nada para imprimir no relatório."
		If Select("TRB") > 0
			oTempExa:Delete()
		EndIf
		If Select("TRBCC") > 0
			oTempCC:Delete()
		EndIf
		Return .F.
	EndIf

	DbSelectArea("TRB")
	dbGoTop()
	If lSigaMdtPs
		oSection5:Init()
		oSection5:PrintLine()
		oSection5:Finish()
	EndIf
	While !EoF()
		If cPCMSO <> If(!lSigaMdtPs,TRB->PCMSO,TMW_PCMSO)
			cPCMSO := If(!lSigaMdtPs,TRB->PCMSO,TMW_PCMSO)
			oSection0:Init()
			oSection0:PrintLine()
			oSection0:Finish()
		EndIf
		oSection1:Init()
		oSection1:PrintLine()
		TRB->(dbSkip())
		If cPCMSO <>  If(!lSigaMdtPs,TRB->PCMSO,TMW_PCMSO)
			oSection0:SetPageBreak(.T.)//Pula de página
			oSection0:PageBreak()
			oSection1:Finish()
		EndIf
	End
	oTempExa:Delete()

	oSection2:SetPageBreak(.T.) //Pula de página
	oSection2:PageBreak()

	If If(!lSigaMdtPs,MV_PAR12,MV_PAR16) == 1
		oSection2:Init()
		oSection2:PrintLine()
		oSection2:Finish()
		If Len(aTotal450) > 0 .And. !lSigaMdtPs
			oSection3:Init()
		Else
			DbSelectArea("TRBCC")
			dbGoTop()
			oSection3:Init()
		EndIf
		If !lSigaMdtPS
			For X:=1 To Len(aTotal450)
				nX:=X
				nTotGeral += aTotal450[X,3]
				oSection3:PrintLine()
			Next X
		Else
			oSection3:Init()
			While !EoF()
				oSection3:PrintLine()
				nTotGeral += TRBCC->TOTAL
				TRBCC->(dbSkip())
			End
		EndIf
		oSection3:Finish()
		If lSigaMdtPs
			oTempCC:Delete()
		EndIf
		oSection4:Init()//Total Geral:
		oSection4:PrintLine()
		oSection4:Finish()
	EndIf

Return Nil
