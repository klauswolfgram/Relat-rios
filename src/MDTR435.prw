/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "MDTR435.ch"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR435
Relatorio dos Funcionários Afastados. O usuario pode selecionar o
codigo do afastamento, obtendo apenas os funcionarios afastados
por motivo de deoeça ou acidente de trabalho.

@type    function
@author  Rafael Diogo Richter
@since   04/08/2006
@sample  U_MDTR435()
@return  Nil, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function MDTR435()

	Local aNGBEGINPRM  := NGBEGINPRM()//Guarda Variáveis
	Local oReport
	Private nTamCTT    := If(TAMSX3("CTT_CUSTO")[1] == 0, 9, TAMSX3("CTT_CUSTO")[1])
	Private lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .T. , .F. ) // Variavel de Prestador de Servico
	Private nTotDias   := 0, nDiasAf := 0, aTotFunc := {}, aFuncAf := {} // Variaveis para totalizadores
	Private cPerg      := If(!lSigaMdtPS,"MDT435    ","MDT435PS  ") // Codigo de pergunta do relatorio
	//Alias para o TRB
	Private cTRB := GetNextAlias()
	Private oTempTRB

	If AMiIn( 35 ) // Somente autorizado para SIGAMDT

		If !MDTRESTRI(cPrograma)
			// Devolve variaveis armazenadas (NGRIGHTCLICK)
			NGRETURNPRM(aNGBEGINPRM)
			Return Nil
		EndIf

		/*----------------------------------
		//PERGUNTAS PADRÃO					|
		|  01  De  Cod.Afastamento ?      	|
		|  02  Ate Cod.Afastamento ?      	|
		|  03  De  Data Afast. ?          	|
		|  04  Ate Data Afast. ?          	|
		|  05  Situação Funcionário ?  		|
		|  06  Imprimir ?					|
		|  07  De Centro de Custo ?			|
		|  08  Ate Centro de Custo ?        |
		|  09  De CID ?						|
		|  10  Ate CID ?					|
		|  11  Todos os afastamentos ?		|
		|  12  De Tipo Ausência ?           |
		|  13  Até Tipo Ausência ?          |
		| 									|
		//PERGUNTAS PRESTADO DE SERVIÇO		|
		|  01  De  Cliente ?                |
		|  02  Loja                       	|
		|  03  Até Cliente ?              	|
		|  04  Loja                       	|
		|  05  De  Cod.Afastamento ?      	|
		|  06  Ate Cod.Afastamento ?      	|
		|  07  De  Data Afast. ?          	|
		|  08  Ate Data Afast. ?          	|
		|  09  Situação do Funcionário?  	|
		|  10  Imprimir ?					|
		|  11  De Centro de Custo ?			|
		|  12  De CID ?						|
		|  13  Ate CID ?					|
		|  14  Todos os afastamentos ?		|
		------------------------------------*/

		If TRepInUse()
			// Interface de impressao
			oReport := ReportDef()
			oReport:SetPortrait()
			oReport:PrintDialog()
		Else
			U_MDTR435R3()
		EndIf
	EndIf

	// Retorna Variaveis e Indice
	NGRETURNPRM(aNGBEGINPRM)

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Define as sessoes impressas no relatorio.

@type    function
@author  Rafael Diogo Richter
@since   04/08/2006
@sample  ReportDef()
@return  oReport, Objeto, Informações do relatório
/*/
//-------------------------------------------------------------------
Static Function ReportDef()

	Local oReport
	Local oSection0
	Local oSection1
	Local oSection2
	Local oCell
	Local oCell2

	//Criacao do componente de impressao

	//TReport():New
	//ExpC1 : Nome do relatorio
	//ExpC2 : Titulo
	//ExpC3 : Pergunte
	//ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
	//ExpC5 : Descricao

	oReport := TReport():New( "MDTR435", OemToAnsi(STR0021), cPerg, { |oReport| ReportPrint(oReport) }, ;
				AllTrim(STR0001)+ " " + AllTrim(STR0002) + " " + AllTrim(STR0003) )  // "Funcionários Afastados"

	Pergunte(oReport:uParam,.T.)

	//Criacao da seço utilizada pelo relatorio

	//TRSection():New
	//ExpO1 : Objeto TReport que a secao pertence
	//ExpC2 : Descricao da seçao
	//ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela
	//        sera considerada como principal para a seção.
	//ExpA4 : Array com as Ordens do relatório
	//ExpL5 : Carrega campos do SX3 como celulas
	//        Default : False
	//ExpL6 : Carrega ordens do Sindex
	//        Default : False

	//Criacao da celulas da secao do relatorio

	//TRCell():New
	//ExpO1 : Objeto TSection que a secao pertence
	//ExpC2 : Nome da celula do relatório. O SX3 será consultado
	//ExpC3 : Nome da tabela de referencia da celula
	//ExpC4 : Titulo da celula
	//        Default : X3Titulo()
	//ExpC5 : Picture
	//        Default : X3_PICTURE
	//ExpC6 : Tamanho
	//        Default : X3_TAMANHO
	//ExpL7 : Informe se o tamanho esta em pixel
	//        Default : False
	//ExpB8 : Bloco de código para impressao.
	//        Default : ExpC2

	If lSigaMdtps
		// Secao 0 - Cliente
		oSection0 := TRSection():New (oReport, STR0022, {cTRB,"SA1"} ) // "Cliente"
		oCell := TRCell():New(oSection0, "(cTRB)->CLIENT" , cTRB , STR0022, "@!", nTa1  )  // "Cliente"
		oCell := TRCell():New(oSection0, "(cTRB)->LOJA"   , cTRB , STR0016, "@!", nTa1L  )  // "Loja"
		oCell := TRCell():New(oSection0, "SA1->A1_NOME", "SA1" , STR0023, "@!", 40  )  // "Nome"
		TRPosition():New (oSection0, "SA1", 1, {|| xFilial("SA1") + (cTRB)->CLIENT + (cTRB)->LOJA } )
	EndIf

	oSection1 := TRSection():New(oReport,STR0024,{cTRB,"SR8"})  // "Tipo Afastamento"
	oCell := TRCell():New(oSection1,"(cTRB)->AFASTA",cTRB,STR0025,"@!",06,/*lPixel*/,/*{|| code-block de impressao }*/ )  // "Afastamento"
	oCell := TRCell():New(oSection1,"(cTRB)->DESCRI",cTRB,STR0026,"@!",60,/*lPixel*/,/*{|| code-block de impressao }*/ )  // "Descrição"

	oSection2 := TRSection():New(oReport,STR0027,{cTRB,"SRA"})  // "Funcionários"
	oCell2 := TRCell():New(oSection2,"(cTRB)->MATRIC" , cTRB , STR0028 , "@!"         , 10 , /*lPixel*/, /*{|| code-block de impressao }*/ ) // "Matrícula"
	oCell2 := TRCell():New(oSection2,"RA_NOME"        , "SRA", STR0029 , "@!"         , 44 , /*lPixel*/, /*{|| code-block de impressao }*/ ) // "Funcionário"
	oCell2 := TRCell():New(oSection2,"(cTRB)->CID"    , cTRB , STR0030 , "@!"         , 14 , /*lPixel*/, /*{|| code-block de impressao }*/ ) // "CID"
	oCell2 := TRCell():New(oSection2,"(cTRB)->DTAINI" , cTRB , STR0031 , "99/99/9999" , 14 , /*lPixel*/, /*{|| code-block de impressao }*/ ) // "Dt. Afast."
	oCell2 := TRCell():New(oSection2,"(cTRB)->DTAFIM" , cTRB , STR0032 , "99/99/9999" ,	14 , /*lPixel*/, /*{|| code-block de impressao }*/ ) // "Dt. Ret."
	oCell2 := TRCell():New(oSection2,"(cTRB)->DIAS"   , cTRB , STR0033 , "@E 99999"   , 09 , /*lPixel*/, /*{|| code-block de impressao }*/ ) // "Dias"
	oCell2 := TRPosition():New(oSection2,"SRA",1,{|| xFilial("SRA")+(cTRB)->MATRIC})
	oSection2:Cell("(cTRB)->DIAS"):SetHeaderAlign("RIGHT")

	If lSigaMdtps
		If MV_PAR15 == 1
			oBreak := TRBreak():New(oSection2,oSection2:Cell("(cTRB)->MATRIC"),STR0034,.F.)  // "Total Dias Afastado"
			TRFunction():New(oSection2:Cell("(cTRB)->DIAS"),/*cId*/,"SUM",oBreak,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
		EndIf
	Else
		If MV_PAR11 == 1
			oBreak := TRBreak():New(oSection2,oSection2:Cell("(cTRB)->MATRIC"),STR0034,.F.)  // "Total Dias Afastado"
			TRFunction():New(oSection2:Cell("(cTRB)->DIAS"),/*cId*/,"SUM",oBreak,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
		EndIf
	EndIf

	oSection3 := TRSection():New(oReport,STR0041) // "Total do Afastamento"
	oCell3    := TRCell():New(oSection3,"DIAS"	,,STR0042 ,"@E 99999"	,89) // "Total Dias Afastamento"
	oBreak3 := TRBreak():New(oSection3,oSection3:Cell("DIAS"),STR0042,.F.) // "Total Dias Afastamento"
	TRFunction():New(oSection3:Cell("DIAS"),,"SUM",oBreak3,,"@E 99999",{|| nDiasAF },.F.,.F.,.F.)
	oBreak4 := TRBreak():New(oSection3,oSection3:Cell("DIAS"),STR0043,.F.) // "Total Funcionários"
	TRFunction():New(oSection3:Cell("DIAS"),,"SUM",oBreak4,,"@E 99999",{|| len(aFuncAF) },.F.,.F.,.F.)
	oSection3 :Cell("DIAS"):SetHeaderAlign("RIGHT")

	oSection4 := TRSection():New(oReport,STR0044) // "Total Geral"
	oCell4    := TRCell():New(oSection4,"DIAS"	,,STR0045,"@E 99999"	,89) // "Total Geral de Dias"
	oBreak5 := TRBreak():New(oSection4,oSection4:Cell("DIAS"),STR0045,.F.) // "Total Geral de Dias"
	TRFunction():New(oSection4:Cell("DIAS"),,"SUM",oBreak5,,"@E 99999",{|| nTotDias },.F.,.F.,.F.)
	oBreak6 := TRBreak():New(oSection4,oSection4:Cell("DIAS"),STR0046,.F.) // "Total Geral Funcionários"
	TRFunction():New(oSection4:Cell("DIAS"),,"SUM",oBreak6,,"@E 99999",{|| len(aTotFunc) },.F.,.F.,.F.)
	oSection4 :Cell("DIAS"):SetHeaderAlign("RIGHT")

Return oReport

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR435R3
Chama a impresso do relatório.

@type    function
@author  Marcio Costa
@since   12/01/2000
@sample  U_MDTR435R3()
@return  Nil, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function MDTR435R3()

	// Define Variaveis
	Local wnrel   := "MDTR435"
	Local limite  := 80
	Local cDesc1  := STR0001 // "Relatorio das Funcionarios afastados do trabalho."
	Local cDesc2  := STR0002 // "Atraves dos parametros podera ser selecionado o codigo do  "
	Local cDesc3  := STR0003 // "afastamento, e o periodo desejado."
	Local cString := "SR8"

	Local lTipoAfast := TNY->( FieldPos( "TNY_CODAFA" ) ) > 0

	Private nomeprog := "MDTR435"
	Private tamanho  := "M"
	Private aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 } // "Zebrado"###"Administracao"
	Private titulo   := STR0006   // "Funcionarios Afastados"
	Private ntipo    := 0
	Private nLastKey := 0
	Private cabec1, cabec2

	// Verifica as perguntas selecionadas

	Pergunte(cPerg,.F.)

	// Envia controle para a funcao SETPRINT
	wnrel:="MDTR435"

	wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

	If nLastKey == 27
		Set Filter to
		Return
	EndIf

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Set Filter to
		Return
	EndIf

	RptStatus({|lEnd| R435Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} R435Imp
Chamada do Relatório

@type    function
@author  Inacio Luiz Kolling
@since   14/04/2000
@sample  R435Imp( @lEnd, "MDTR435", "Título", "M" )

@param   lEnd, Lógico, Indica o fim da impressão
@param   wnRel, Caracter, Programa utilizado
@param   titulo, Caracter, Título do relatório
@param   tamanho, Caracter, Tamanho do relatório

@return  Nil, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function R435Imp( lEnd, wnRel, titulo, tamanho )

	// Define Variaveis
	Local cRodaTxt := ""
	Local nCntImpr := 0
	Local dDataIni // Data inicial, caso for o último afastamento
	Local dDataFim // Data final, caso for o último afastamento

	// Variaveis para controle do cursor de progressao do relatorio
	Local nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

	// Variaveis locais exclusivas deste programa
	Local cChave := SPACE(16), lFirst := .T.

	// Contadores de linha e pagina
	Private li := 80 ,m_pag := 1

	// Verifica se deve comprimir ou nao
	nTipo := IIF(aReturn[4]==1,15,18)

	// Monta os Cabecalhos
	cabec1 := STR0007
	cabec2 := STR0008

	/*
	--------------------------------------------------------------------------------
	|<empresa>                                                    Folha..: xxxxx   |
	|SIGA /<nome .04         <Relatorio de Questionario Medico>   DT.Ref.: dd/mm/aa|
	|Hora...: xx:xx:xx                                            Emissao: dd/mm/aa|
	--------------------------------------------------------------------------------
	0         1         2         3         4         5         6         7         8
	012345678901234567890123456789012345678901234567890123456789012345678901234567890
	--------------------------------------------------------------------------------
	Cod.  Descricao do Afastamento
	Mat.    Funcionário                    CID         Data Afast.  Data Ret.  Dias
	--------------------------------------------------------------------------------
	--    -------------------------------
	------  -----------------------------  ----------  99/99/99   99/99/99  9999
	------
	Total Dias Afastado     9999
	*/

	Processa({|lEND| MDTR435SR8(@lEnd,1)},STR0035)  // "Processando Arquivo..."

	If lSigaMdtps

		dbSelectArea(cTRB)
		dbGOTOP()
		If !EoF()
			Somalinha()
		EndIf

		While ! EoF()

			cCliente := (cTRB)->CLIENT+(cTRB)->LOJA
			aTotFunc := {}
			nTotDias  := 0
			Somalinha()
			@Li,000 PSAY STR0036 + AllTrim((cTRB)->CLIENT) + "-" + AllTrim((cTRB)->LOJA) + " - " + NGSEEK("SA1",cCliente,1,"A1_NOME")  // "Cliente/Loja: "

			While !EoF() .And. cCliente == (cTRB)->CLIENT+(cTRB)->LOJA

				cAFASTA := (cTRB)->AFASTA
				If !lFirst
					Somalinha()
					SomaLinha()
					@Li,054 PSAY STR0042 // "Total Dias Afastamento"
					@Li,078 PSAY nDiasAf PICTURE "@E 99999"

					Somalinha()
					SomaLinha()
					@Li,054 PSAY STR0043 // "Total Funcionários"
					@Li,078 PSAY Len(aFuncAf) PICTURE "@E 99999"
					Somalinha()
					Somalinha()
				EndIf
				Somalinha()
				Somalinha()
				@Li,000 PSAY cAFASTA PICTURE "@!"

				@Li,006 PSAY (cTRB)->DESCRI

				nDiasAf := 0
				aFuncAf := {}
				Somalinha()

				dbSelectArea(cTRB)

				While ! EoF() .And. (cTRB)->AFASTA == cAFASTA .And. cCliente == (cTRB)->CLIENT+(cTRB)->LOJA

					cMATRIC := (cTRB)->MATRIC

					Somalinha()

					@Li,003 PSAY cMATRIC  PICTURE "@!"
					dbSelectArea("SRA")
					dbSetOrder(01)
					dbSeek(xFilial("SRA")+cMATRIC)

					@Li,011 PSAY Substr(Alltrim(SRA->RA_NOME),1,27)

					nTOTAFASFU := 0

					While ! EoF() .And. (cTRB)->AFASTA == cAFASTA .And. (cTRB)->MATRIC == cMATRIC .And. cCliente == (cTRB)->CLIENT+(cTRB)->LOJA

						If MV_PAR15 == 1
							@Li,042 PSAY (cTRB)->CID
							@Li,054 PSAY (cTRB)->DTAINI     PICTURE "99/99/99"
							@Li,067 PSAY (cTRB)->DTAFIM		PICTURE "99/99/99"
							@Li,078 PSAY (cTRB)->DIAS		PICTURE "@E 99999"
							nTOTAFASFU := nTOTAFASFU + (cTRB)->DIAS
							Somalinha()
							nDiasAf    += (cTRB)->DIAS
							nTotDias   += (cTRB)->DIAS
						Else
							dDataIni := (cTRB)->DTAINI
							dDataFim := (cTRB)->DTAFIM
							nDiasAf  := (cTRB)->DIAS
						EndIf
						If aScan( aFuncAf, { |x| Trim(Upper(x[1])) == Trim(Upper((cTRB)->MATRIC))} ) == 0
							aADD( aFuncAf, { (cTRB)->MATRIC} )
						EndIf
						If aScan( aTotFunc, { |x| Trim(Upper(x[1])) == Trim(Upper((cTRB)->MATRIC))} ) == 0
							aADD( aTotFunc, { (cTRB)->MATRIC} )
						EndIf
						dbSelectArea(cTRB)
						dbskip()
					End

					If MV_PAR15 == 2 // Somente o último afastamento
						@Li,054 PSAY dDataIni	PICTURE "99/99/99"
						@Li,067 PSAY dDataFim	PICTURE "99/99/99"
						@Li,078 PSAY nDiasAf		PICTURE "@E 99999"
						nTotDias := nTotDias + nDiasAf
						Somalinha()
					EndIf

					If nTOTAFASFU > 0
						@Li,077 PSAY "------"
						SomaLinha()
						@Li,054 PSAY STR0010 // "Total Dias Afastado"
						@Li,078 PSAY nTOTAFASFU PICTURE "@E 99999"
						SomaLinha()
					EndIf

				End

			End  // Fim - CLIENTE

			If Len(aTotFunc) > 0
			Somalinha()
			SomaLinha()
			If MV_PAR15 == 1
				@Li,054 PSAY STR0042 // "Total Dias Afastamento"
				@Li,078 PSAY nDiasAf PICTURE "@E 99999"
				Somalinha()
				Somalinha()
				@Li,054 PSAY STR0043 // "Total Funcionários"
				@Li,078 PSAY Len(aFuncAf) PICTURE "@E 99999"
				Somalinha()
				Somalinha()
				Somalinha()
				SomaLinha()
			EndIf
			@Li,054 PSAY STR0045 // "Total Geral de Dias"
			@Li,078 PSAY nTotDias PICTURE "@E 99999"
			Somalinha()
			Somalinha()
			@Li,054 PSAY STR0046 // "Total Geral Funcionários"
			@Li,078 PSAY Len(aTotFunc) PICTURE "@E 99999"
			EndIf

			Somalinha()
			@ Li,000 PSAY __PrtThinLine()

		End

	Else

		dbSelectArea(cTRB)
		dbGOTOP()

		While ! EoF()

			cAFASTA := (cTRB)->AFASTA
			If !lFirst
				Somalinha()
				SomaLinha()
				@Li,054 PSAY STR0042 // "Total Dias Afastamento"
				@Li,078 PSAY nDiasAf PICTURE "@E 99999"

				Somalinha()
				SomaLinha()
				@Li,054 PSAY STR0043 // "Total Funcionários"
				@Li,078 PSAY Len(aFuncAf) PICTURE "@E 99999"
				Somalinha()
				Somalinha()
			EndIf

			Somalinha()
			Somalinha()
			@Li,000 PSAY cAFASTA PICTURE "@!"

			@Li,006 PSAY (cTRB)->DESCRI

			Somalinha()
			nDiasAf := 0
			aFuncAf := {}
			dbSelectArea(cTRB)

			While ! EoF() .And. (cTRB)->AFASTA == cAFASTA

				cMATRIC := (cTRB)->MATRIC
				lFirst := .F.
				Somalinha()

				@Li,003 PSAY cMATRIC  PICTURE "@!"
				dbSelectArea("SRA")
				dbSetOrder(01)
				dbSeek(xFilial("SRA")+cMATRIC)

				@Li,011 PSAY Substr(Alltrim(SRA->RA_NOME),1,27)

				nTOTAFASFU := 0

				While ! EoF() .And. (cTRB)->AFASTA == cAFASTA .And. (cTRB)->MATRIC == cMATRIC

					If MV_PAR11 == 1
						@Li,042 PSAY (cTRB)->CID
						@Li,054 PSAY (cTRB)->DTAINI   PICTURE "99/99/99"
						@Li,067 PSAY (cTRB)->DTAFIM   PICTURE "99/99/99"
						@Li,078 PSAY (cTRB)->DIAS		PICTURE "@E 99999"
						nTOTAFASFU := nTOTAFASFU + (cTRB)->DIAS
						Somalinha()
						nDiasAf    += (cTRB)->DIAS
						nTotDias   += (cTRB)->DIAS
					Else
						dDataIni := (cTRB)->DTAINI
						dDataFim := (cTRB)->DTAFIM
						nDiasAf  := (cTRB)->DIAS
					EndIf

					If aScan( aFuncAf, { |x| Trim(Upper(x[1])) == Trim(Upper((cTRB)->MATRIC))} ) == 0
						aADD( aFuncAf, { (cTRB)->MATRIC} )
					EndIf
					If aScan( aTotFunc, { |x| Trim(Upper(x[1])) == Trim(Upper((cTRB)->MATRIC))} ) == 0
						aADD( aTotFunc, { (cTRB)->MATRIC} )
					EndIf
					dbSelectArea(cTRB)
					dbskip()
				End
				If MV_PAR11 == 2 // Somente o último afastamento
					@Li,054 PSAY dDataIni	PICTURE "99/99/99"
					@Li,067 PSAY dDataFim	PICTURE "99/99/99"
					@Li,078 PSAY nDiasAf		PICTURE "@E 99999"
					nTotDias := nTotDias + nDiasAf
					Somalinha()
				EndIf

				If nTOTAFASFU > 0
					@Li,077 PSAY "------"
					SomaLinha()
					@Li,054 PSAY STR0010 // "Total Dias Afastado"
					@Li,078 PSAY nTOTAFASFU PICTURE "@E 99999"
					SomaLinha()
				EndIf
			End
		End

		If Len(aTotFunc) > 0
			Somalinha()
			SomaLinha()
			If MV_PAR11 == 1
				@Li,054 PSAY STR0042 // "Total Dias Afastamento"
				@Li,078 PSAY nDiasAf PICTURE "@E 99999"
				Somalinha()
				Somalinha()
				@Li,054 PSAY STR0043 // "Total Funcionários"
				@Li,078 PSAY Len(aFuncAf) PICTURE "@E 99999"
				Somalinha()
				Somalinha()
				Somalinha()
				SomaLinha()
			EndIf
			@Li,054 PSAY STR0045 // "Total Geral de Dias"
			@Li,078 PSAY nTotDias PICTURE "@E 99999"
			Somalinha()
			Somalinha()
			@Li,054 PSAY STR0046 // "Total Geral Funcionários"
			@Li,078 PSAY Len(aTotFunc) PICTURE "@E 99999"
		EndIf

	EndIf

	If (cTRB)->(RecCount()) == 0
		MsgInfo(STR0037)  // "Não há nada para imprimir no relatório."
		RetIndex("SR8")
		Set Filter To
		// Deleta o arquivo temporario fisicamente
		oTempTRB:Delete()
		Return .F.
	EndIf

	Roda(nCntImpr,cRodaTxt,Tamanho)

	// Devolve a condicao original do arquivo principal
	RetIndex("SR8")

	Set Filter To

	Set device to Screen

	If aReturn[5] = 1
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	EndIf
	MS_FLUSH()

	//Deleta o arquivo temporario fisicamente
	oTempTRB:Delete()

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Chamada do Relatório

@type    function
@author  Heverson Vitoreti
@since   18/07/2006
@sample  ReportPrint( oReport )

@param   oReport, Objeto, Informações do relatório

@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
Static Function ReportPrint( oReport )

	Local oSection1
	Local oSection2
	Local oSection3
	Local oSection4

	Local lFirst

	Local nDias := 0

	Processa({|lEND| MDTR435SR8(@lEnd,2,oReport)},STR0035)  // "Processando Arquivo..."

	If lSigaMdtps

		oSection0 := oReport:Section(1)
		oSection1 := oReport:Section(2)
		oSection2 := oReport:Section(3)
		oSection3 := oReport:Section(4)
		oSection4 := oReport:Section(5)

		dbSelectArea(cTRB)
		dbGOTOP()
		oReport:SetMeter(RecCount())

		While !EoF()

			cCliente := (cTRB)->CLIENT+(cTRB)->LOJA
			oSection0:Init()
			oSection0:PrintLine()
			nTotDias := 0
			aTotFunc := {}
			While !EoF() .And. cCliente == (cTRB)->CLIENT+(cTRB)->LOJA .And. cCliente == (cTRB)->CLIENT+(cTRB)->LOJA

				cAFASTA := (cTRB)->AFASTA

				oSection1:Init()
				oSection1:PrintLine()
				oSection2:Init()
				If MV_PAR15 == 1
					oSection3:Init()
				EndIf
				nDiasAf := 0
				aFuncAf := {}
				DbSelectArea(cTRB)
				While ! EoF() .And. (cTRB)->AFASTA == cAFASTA .And. cCliente == (cTRB)->CLIENT+(cTRB)->LOJA

					cMATRIC := (cTRB)->MATRIC
					nTOTAFASFU := 0
					lFirst := .T.

					While ! EoF() .And. (cTRB)->AFASTA == cAFASTA .And. (cTRB)->MATRIC == cMATRIC .And. cCliente == (cTRB)->CLIENT+(cTRB)->LOJA
						oReport:IncMeter()

						If lFirst
							oSection2:Cell("(cTRB)->MATRIC"):Show()
							oSection2:Cell("RA_NOME"):Show()
							lFirst := .F.
						Else
							oSection2:Cell("(cTRB)->MATRIC"):Hide()
							oSection2:Cell("RA_NOME"):Hide()
						EndIf

						If MV_PAR15 == 1 // Pegar todos afastamentos.
							oSection2:PrintLine()
							nDiasAf += (cTRB)->DIAS
							nTotDias += (cTRB)->DIAS
						Else
							nDias := (cTRB)->DIAS
						EndIf

						If aScan( aFuncAf, { |x| Trim(Upper(x[1])) == Trim(Upper((cTRB)->MATRIC))} ) == 0
							aADD( aFuncAf, { (cTRB)->MATRIC} )
						EndIf

						If aScan( aTotFunc, { |x| Trim(Upper(x[1])) == Trim(Upper((cTRB)->MATRIC))} ) == 0
							aADD( aTotFunc, { (cTRB)->MATRIC} )
						EndIf

						dbSelectArea(cTRB)
						dbskip()
					End
					If MV_PAR15 == 2
						dbSelectArea(cTRB)
						nDiasAf := nDiasAf + nDias
						nTotDias := nDiasAf
						oSection2:Cell("(cTRB)->MATRIC"):Show()
						oSection2:Cell("RA_NOME"):Show()
						(cTRB)->( dbSkip(-1) )
						oSection2:PrintLine()
						dbSkip()
					EndIf
				End

				oSection1:Finish()
				oSection2:Finish()
				// Totais do Afastamento
				oSection3:Hide()
				oSection3:PrintLine()
				oSection3:Finish()
			End

			If (cTRB)->(RecCount()) > 0
				// Totais Gerais
				oSection4:Init()
				oSection4:Hide()
				oSection4:PrintLine()
				oSection4:Finish()
			EndIf
			oSection0:Finish()
		End

	Else

		oSection1 := oReport:Section(1)
		oSection2 := oReport:Section(2)
		oSection3 := oReport:Section(3)
		oSection4 := oReport:Section(4)

		dbSelectArea(cTRB)
		dbGOTOP()
		oReport:SetMeter(RecCount())
		While !EoF()

			oReport:IncMeter()

			cAFASTA := (cTRB)->AFASTA

			oSection1:Init()
			oSection1:PrintLine()
			oSection2:Init()
			If MV_PAR11 == 1
				oSection3:Init()
			EndIf
			nDiasAf := 0
			aFuncAf := {}
			DbSelectArea(cTRB)
			While ! EoF() .And. (cTRB)->AFASTA == cAFASTA

				cMATRIC := (cTRB)->MATRIC
				lFirst := .T.

				While ! EoF() .And. (cTRB)->AFASTA == cAFASTA .And. (cTRB)->MATRIC == cMATRIC

					If lFirst
						oSection2:Cell("(cTRB)->MATRIC"):Show()
						oSection2:Cell("(cTRB)->MATRIC"):Show()
						oSection2:Cell("RA_NOME"):Show()
						lFirst := .F.
					Else
						oSection2:Cell("(cTRB)->MATRIC"):Hide()
						oSection2:Cell("RA_NOME"):Hide()
					EndIf

					If MV_PAR11 == 1 // Pegar todos afastamentos.
						oSection2:PrintLine()
						nDiasAf += (cTRB)->DIAS
						nTotDias += (cTRB)->DIAS
					Else
						nDias := (cTRB)->DIAS
					EndIf

					If aScan( aFuncAf, { |x| Trim(Upper(x[1])) == Trim(Upper((cTRB)->MATRIC))} ) == 0
						aADD( aFuncAf, { (cTRB)->MATRIC} )
					EndIf
					If aScan( aTotFunc, { |x| Trim(Upper(x[1])) == Trim(Upper((cTRB)->MATRIC))} ) == 0
						aADD( aTotFunc, { (cTRB)->MATRIC} )
					EndIf

					dbSelectArea(cTRB)
					dbskip()
				End
				If MV_PAR11 == 2
					dbSelectArea(cTRB)
					nDiasAf := nDiasAf + nDias
					nTotDias := nDiasAf
					oSection2:Cell("(cTRB)->MATRIC"):Show()
					oSection2:Cell("RA_NOME"):Show()
					(cTRB)->( dbSkip(-1) )
					oSection2:PrintLine()
					dbSkip()
				EndIf
			End
			oSection1:Finish()
			oSection2:Finish()
			// Totais do Afastamento
			oSection3:Hide()
			oSection3:PrintLine()
			oSection3:Finish()
		Enddo

		If (cTRB)->(RecCount()) > 0
			// Totais Gerais
			oSection4:Init()
			oSection4:Hide()
			oSection4:PrintLine()
			oSection4:Finish()
		EndIf
	EndIf

	If (cTRB)->(RecCount()) == 0
		MsgInfo(STR0037)  // "No há nada para imprimir no relatório."
		// Deleta o arquivo temporario fisicamente
		oTempTRB:Delete()
		dbSelectArea("SR8")
		Set Filter To
		dbSetOrder(01)
		Return .F.
	EndIf

	// Deleta o arquivo temporario fisicamente
	oTempTRB:Delete()
	dbSelectArea("SR8")
	Set Filter To
	dbSetOrder(01)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina

@type    function
@author  Inacio Luiz Kolling
@since   14/04/2000
@sample  Somalinha()

@return  Nil, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function Somalinha()

	Li++

	If Li > 58
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		Li := Li - 1
	EndIf

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR435SR8
Processa o arquivo de roteio.

@type    function
@author  Rafael Diogo Richter
@since   03/08/2006
@sample  MDTR435SR8( @lEnd, 1, oReport )

@param   lEnd, Lógico, Indica o fim da impressão
@param   nTipoRel, Numérico, param_descr
@param   oReport, Objeto, Informações do relatório

@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
Static Function MDTR435SR8( lEnd, nTipoRel, oReport )

	Local lTodos := .F.,cFilTmp,nPos1,nPos2,nPos3,lSimples
	Local lContinua := .T.
	Local cCondSR8 := ".T."
	Local cTipoAfas := ""

	Local nTamMat  := TAMSX3("RA_MAT")[1]

	Local aDBF := {}
	Local aIND435 := {}

	Private lTipoAfast:= TNY->( FieldPos( "TNY_CODAFA" ) ) > 0

	If lTipoAfast
		cTipoAfas := "If(Empty( SR8->R8_TIPOAFA ), SR8->R8_TIPO, SR8->R8_TIPOAFA )"
		cTipoDesc := "If(Empty( SR8->R8_TIPOAFA ), FDESC('SX5','30'+SR8->R8_TIPO,'X5_DESCRI',30), NGSeek( 'RCM' , SR8->R8_TIPOAFA , 1 , 'RCM_DESCRI' ) )"
	Else
		cTipoAfas := "SR8->R8_TIPO"
		cTipoDesc := "FDESC('SX5','30'+SR8->R8_TIPO,'X5_DESCRI',30)"
	EndIf

	If nTipoRel == 1
		If Type("aReturn[7]") == "C"
			If !Empty(aReturn[7])
				cCondSR8 := Alltrim(aReturn[7])
			EndIf
		EndIf
	Else
		If ValType(oReport) == "O"
			Private oRepSR8	:= oReport
		EndIf
		If Type("oRepSR8:aSection[1]:aUserFilter[1][2]") == "C"
			If !Empty(oRepSR8:aSection[1]:aUserFilter[1][2])
				cCondSR8 := Alltrim(oRepSR8:aSection[1]:aUserFilter[1][2])
			EndIf
		EndIf
	EndIf

	//Verifica se todos os afastamentos devem ser impressos
	If lSigaMdtPs
		lTodos := MV_PAR10 == 2

		//Cria Arquivo Temporario
		AADD(aDBF,{"CLIENT","C",nTa1,0})
		AADD(aDBF,{"LOJA"  ,"C",nTa1L,0})

		cCondAfast := "SubStr( SR8->R8_TIPO , 1 , 1 ) >= mv_par05 .And. SubStr( SR8->R8_TIPO , 1 , 1 ) <= mv_par06"

	Else
		lTodos := MV_PAR06 == 2

		cCondAfast := "SubStr( SR8->R8_TIPO , 1 , 1 ) >= mv_par01 .And. SubStr( SR8->R8_TIPO , 1 , 1 ) <= mv_par02"
	EndIf

	AADD(aDBF,{"AFASTA","C",03,0})
	AADD(aDBF,{"DESCRI","C",30,0})
	AADD(aDBF,{"MATRIC","C",nTamMat,0})
	AADD(aDBF,{"CID"   ,"C",10,0})
	AADD(aDBF,{"DTAINI","D",08,0})
	AADD(aDBF,{"DTAFIM","D",08,0})
	AADD(aDBF,{"DIAS"  ,"N",05,0})

	oTempTRB := FWTemporaryTable():New( cTRB, aDBF )
	If lSigaMdtPs
		oTempTRB:AddIndex( "1", {"CLIENT","LOJA","AFASTA","MATRIC"} )
	Else
		oTempTRB:AddIndex( "1", {"AFASTA","MATRIC"} )
	EndIf
	oTempTRB:Create()

	If lTodos
		cCond := ".T."
	Else
		cCond := "( SubStr( SR8->R8_TIPO, 1 , 1 ) $ 'O#P#S#Y#F' )"
		If lTipoAfast
			cCond += " .Or. SubStr( NGSeek( 'RCM' , R8_TIPOAFA  , 1 , 'RCM_CODSEF' ) , 1 , 1 ) $ 'O#P#S#Y#F'"
		EndIf
	EndIf

	// NAO TEM CHAVE DE ACESSO DIRETO POR TIPO NO SR8
	// POR ISSO FOI CRIADO O BLOCO ABAIXO

	dbSelectArea("SR8")
	SET FILTER TO R8_FILIAL == xFilial('SR8') .And. &(cCondAfast) .And. &(cCondSR8)

	If lSigaMdtps

		dbSetOrder(01)   //R8_FILIAL+R8_MAT+DTOS(R8_DATAINI)+R8_TIPO
		dbSeek(xFilial("SR8") + "000000" + DTOS(mv_par07) + mv_par05,.T.)

		ProcRegua(LastRec())

		// Correr SR8 para ler os Afastamentos

		While lContinua .And. !EoF().And. SR8->R8_FILIAL == xFIlial('SR8') .And. &(cCondAfast) .And. &(cCondSR8)

			IncProc()

			If lTipoAfast .And. ( SR8->R8_TIPOAFA < mv_par16 .Or. SR8->R8_TIPOAFA > mv_par17 )

				dbSelectArea("SR8")
				dbSKIP()
				loop
			EndIf

			If ( !Empty( SR8->R8_DATAFIM ) .And. SR8->R8_DATAFIM < MV_PAR07 ) .Or. SR8->R8_DATAINI > MV_PAR08
				dbSelectArea("SR8")
				dbSKIP()
				loop
			EndIf

			If &(cCond)
				DbSelectArea("SRA")
				DbSetOrder(01)
				dbSeek(xFilial("SRA")+SR8->R8_MAT)

				cCliente := SubStr(SRA->RA_CC,1,nSizeTD)
				If cCliente < mv_par01+mv_par02 .Or. cCliente > mv_par03+mv_par04
					dbSelectArea("SR8")
					dbSKIP()
					loop
				EndIf

				If SRA->RA_CC < mv_par11 .Or. SRA->RA_CC > mv_par12
					dbSelectArea("SR8")
					dbSKIP()
					loop
				EndIf

				If mv_par09 == 1 .And. SRA->RA_SITFOLH != "A"      //Apenas Afastados
					dbSelectArea("SR8")
					dbSKIP()
					loop
				ElseIf mv_par09 == 2 .And. SRA->RA_SITFOLH != "D"       //Apenas demitidos
					dbSelectArea("SR8")
					dbSKIP()
					loop
				Elseif mv_par09 == 3 .And. SRA->RA_SITFOLH != "F"   //Apenas férias
					dbSelectArea("SR8")
					dbSKIP()
					loop
				Elseif mv_par09 == 4 .And. !Empty(SRA->RA_SITFOLH)   //Apenas férias
					dbSelectArea("SR8")
					dbSKIP()
					loop
				EndIf

				cCid := " "
				If SR8->(FieldPos("R8_CID")) > 0
					If !Empty(SR8->R8_CID)
						cCid := SR8->R8_CID
					EndIf
				EndIf

				If Empty(cCid)
					dbSelectArea("TM0")
					dbSetOrder(3)
					dbSeek(xFilial("SRA")+SR8->R8_MAT)

					dbSelectArea("TNY")
					dbSetOrder(1)
					dbSeek(xFilial("TNY")+TM0->TM0_NUMFIC+DTOS(SR8->R8_DATAINI))
					cCid := TNY->TNY_CID
				EndIf

				If cCid < mv_par13 .Or. cCid > mv_par14
					dbSelectArea("SR8")
					dbSKIP()
					loop
				EndIf
				dbSelectArea(cTRB)
				(cTRB)->(DbAppend())
				(cTRB)->AFASTA := &(cTipoAfas)
				(cTRB)->DESCRI := &(cTipoDesc)
				(cTRB)->MATRIC := SR8->R8_MAT
				(cTRB)->CID    := cCid
				(cTRB)->DTAINI := SR8->R8_DATAINI
				(cTRB)->DTAFIM := SR8->R8_DATAFIM
				If !Empty((cTRB)->DTAFIM)
					(cTRB)->DIAS := ((cTRB)->DTAFIM-(cTRB)->DTAINI+1)
				Else
					(cTRB)->DIAS := (dDataBase-(cTRB)->DTAINI+1)
				EndIf

				(cTRB)->CLIENT := SubStr(cCliente,1,nTa1)
				(cTRB)->LOJA   := SubStr(cCliente,nTa1+1,nTa1L)

			EndIf

			dbSelectArea("SR8")
			dbSKIP()

		End

	Else

		dbSetOrder(1)
		dbSeek(xFilial("SR8") + "000000" + DTOS(mv_par03) + mv_par01,.T.)

		ProcRegua(LastRec())
		// Correr SR8 para ler os Afastamentos
		While lContinua .And. !EoF() .And. SR8->R8_FILIAL == xFilial('SR8') .And. &(cCondAfast) .And. &(cCondSR8)

			IncProc()

			If  lTipoAfast .And. ( SR8->R8_TIPOAFA < mv_par12 .Or.	SR8->R8_TIPOAFA > mv_par13 )

				dbSelectArea("SR8")
				dbSKIP()
				loop
			EndIf

			If ( !Empty( SR8->R8_DATAFIM ) .And. SR8->R8_DATAFIM < MV_PAR03 ) .Or. SR8->R8_DATAINI > MV_PAR04
				dbSelectArea("SR8")
				dbSKIP()
				loop
			EndIf

			If &(cCond)
				dbSelectArea("SRA")
				dbSetOrder(01)
				dbSeek(xFilial("SRA")+SR8->R8_MAT)

				If SRA->RA_CC < mv_par07 .Or. SRA->RA_CC > mv_par08
					dbSelectArea("SR8")
					dbSKIP()
					loop
				EndIf

				If mv_par05 == 1 .And. SRA->RA_SITFOLH != "A"      //Apenas Afastados
					dbSelectArea("SR8")
					dbSKIP()
					loop
				EndIf
				If mv_par05 == 2 .And. SRA->RA_SITFOLH != "D"       //Apenas demitidos
					dbSelectArea("SR8")
					dbSKIP()
					loop
				Elseif mv_par05 == 3 .And. SRA->RA_SITFOLH != "F"   //Apenas férias
					dbSelectArea("SR8")
					dbSKIP()
					loop
				Elseif mv_par05 == 4 .And. !Empty(SRA->RA_SITFOLH)   //Apenas férias
					dbSelectArea("SR8")
					dbSKIP()
					loop
				EndIf

				cCid := " "
				If SR8->(FieldPos("R8_CID")) > 0
					If !Empty(SR8->R8_CID)
						cCid := SR8->R8_CID
					EndIf
				EndIf

				If Empty(cCid)
					dbSelectArea("TM0")
					dbSetOrder(3)
					dbSeek(xFilial("SRA")+SR8->R8_MAT)

					dbSelectArea("TNY")
					dbSetOrder(1)
					dbSeek(xFilial("TNY")+TM0->TM0_NUMFIC+DTOS(SR8->R8_DATAINI))
					cCid := TNY->TNY_CID
				EndIf

				If cCid < mv_par09 .Or. cCid > mv_par10
					dbSelectArea("SR8")
					dbSKIP()
					loop
				EndIf

				dbSelectArea(cTRB)
				(cTRB)->(DbAppend())
				(cTRB)->AFASTA := SR8->( &(cTipoAfas) )
				(cTRB)->DESCRI := &(cTipoDesc)
				(cTRB)->MATRIC := SR8->R8_MAT
				(cTRB)->CID    := cCid
				(cTRB)->DTAINI := SR8->R8_DATAINI
				(cTRB)->DTAFIM := SR8->R8_DATAFIM
				If !Empty((cTRB)->DTAFIM)
					(cTRB)->DIAS := ((cTRB)->DTAFIM-(cTRB)->DTAINI+1)
				Else
					(cTRB)->DIAS := (dDataBase-(cTRB)->DTAINI+1)
				EndIf

			EndIf

			dbSelectArea("SR8")
			dbSKIP()
		End
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} VALIDATE
Valida o campo Até

@type    function
@author  Rafael Reinert
@since   05/04/2011
@sample  U_VALIDATE( 'SRA', '', 'ZZZZ')

@param   cALIAS, Caractere, Alias da tabela
@param   cPAR01, Caractere, Codigo de pesquisa  ( De .... )
@param   cPAR02, Caractere, Codigo de pesquisa  ( Ate ... )

@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function VALIDATE( cALIAS, cPAR01, cPAR02 )

	If Empty(cPAR02)
		ShowHelpDlg("ATENÇÃO",{"Para opção de parâmetro Até no arquivo de perguntas esta opção é inválida."},2, ;
					{"Informe uma opção válida para este parâmetro."},2)
		Return .F.
	Elseif cPAR02 < cPAR01
		ShowHelpDlg("ATENÇÃO",{"Para opção de parâmetro De/Até no arquivo de perguntas esta opção é inválida."},2,;
					{"Informe uma opção válida para este parâmetro."},2)
		Return .F.
	EndIf

	If cPAR02 = replicate('Z',Len(cPAR02))
		Return .T.
	Else
		If cAlias == "SRA"
			If !ExCpoMDT(cAlias,cPAR02)
				Return .F.
			EndIf
		Else
			If !ExistCpo(cAlias,cPAR02)
				Return .F.
			EndIf
		EndIf
	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} U_MDTR435Val()
Validação para os parametro do grupo de pergunta MDT435.

@type    function
@author  Guilherme Benkendorf
@since   24/11/14
@sample  U_MDTR435Val( 12 , .T. )

@param   nPerg, Numérico, Número da pergunta a ser validada
@param   lPress, Lógico, Se é prestador de serviço

@return  Lógico, verdadeiro se a os parâmetors fores válidos
/*/
//---------------------------------------------------------------------
User Function MDTR435Val( nPerg , lPress )

	Local lRet := .T.

	Default lPress := .F.

	If !lPress
		If nPerg == 12
			lRet := If( !Empty( MV_PAR12 ) , ExistCPO( "RCM" , MV_PAR12 ) , lRet )
		Else
			lRet := ATECODIGO( "RCM" , MV_PAR12 , MV_PAR13 )
		EndIf
	Else
		If nPerg == 16
			lRet := If( !Empty( MV_PAR16 ) , ExistCPO( "RCM" , MV_PAR16 ) , lRet )
		Else
			lRet := ATECODIGO( "RCM" , MV_PAR16 , MV_PAR17 )
		EndIf
	EndIf

Return lRet

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT435RA
Função responsavel pelo X3_WHEN do campo TNY_AFRAIS

@type function
@author Guilherme Freudenburg
@since 22/09/2016
@sample U_MDT435RA()

@return Lógico, Retorna verdadeiro quando funço estiver correta
/*/
//---------------------------------------------------------------------
User Function MDT435RA()

	Local lRet := .T.
	Local oModel

	If IsInCallStack("MDTA685")
		oModel 	:= FWModelActive() //Ativa modelo utilizado.
		oModel:GetValue( 'TNYMASTER1', 'TNY_TIPAFA' )
		If !Empty(oModel:GetValue( 'TNYMASTER1', 'TNY_TIPAFA' )) .And. !Empty(Posicione("RCM",1,xFilial( 'RCM' ) + oModel:GetValue( 'TNYMASTER1', 'TNY_CODAFA' ),"RCM_CODRAI"))
			lRet := .F.
		EndIf
	Else
		If !Empty(M->TNY_TIPAFA) .And. !Empty(Posicione("RCM",1,xFilial( 'RCM' ) + M->TNY_CODAFA,"RCM_CODRAI"))
			lRet := .F.
		EndIf
	EndIf

Return lRet
