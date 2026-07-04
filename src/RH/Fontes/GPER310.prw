/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER310.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER310  ³ Autor    ³ R.H. - Marcos Stiefano³ Data ³ 04.01.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emiss„o da Etiqueta / Cart„o de Ponto                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER310(void)                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³           ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS    ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Cecilia Car.³16/05/14³TPQAJ1   ³Incluido o fonte da 11 para a 12 e efetua-³±±
±±³            ³        ³         ³da a limpeza.                             ³±±
±±³Renan Borges|24/02/15|TRNJY7   |Ajuste para comprimir letra na impressão  ³±±
±±³            |        |         |direto na porta e para formulários de 1 a ³±±
±±³            |        |         |2 colunas.                                ³±±
±±³Renan Borges|25/02/16|TUOBK5   |Ajuste para imprimir linha de função e CGC³±±
±±³Esther V.   |        |         |corretamente sem espaços indevidos.       ³±±
±±³Paulo O.    |24/10/16|TVKQM7   |Ajuste em gr310imp() para tratar o tamanho³±±
±±³            |        |         |do número da CTPS.                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function GPER310()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cString := "SRA"  // alias do arquivo principal (Base)
Local aOrd    := {STR0001,STR0002,STR0003,STR0004}	//"Matricula"###"Centro de Custo"###"Nome"###"Chapa"
Local cDesc1  := STR0005		//"Emiss„o da Etiqueta / Cart„o de Ponto"
Local cDesc2  := STR0006		//"Ser  impresso de acordo com os parametros solicitados pelo"
Local cDesc3  := STR0007		//"usuario."

Local aOfusca		:= If(FindFunction('ChkOfusca'), ChkOfusca(), { .T., .F., {} }) //[1]Acesso; [2]Ofusca; [3]Mensagem
Local aMsg			:= aOfusca[3]
Local aFldRel		:= {"RA_NOME", "RA_NUMCP", "RA_SERCP"}
Local lBlqAcesso	:= aOfusca[2] .And. !Empty( FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRel ) )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn  := {STR0008,1,STR0009,2,2,1,"",1 }	//"Zebrado"###"Administra‡„o"
Private NomeProg := "GPER310"
Private aLinha   := {}
Private nLastKey := 0
Private cPerg    := "GPR310"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aInfo := {}
Private cLin[8]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Utilizadas na funcao IMPR                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private Titulo
Private AT_PRG   := "GPER310"
Private wCabec0  := 2
Private wCabec1  := ""
Private wCabec2  := ""
Private Contfl   := 1
Private Li       := 0
Private nTamanho := "M"

If !lBlqAcesso

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	pergunte("GPR310",.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                         ³
	//³ mv_par01        //  Filial De                                ³
	//³ mv_par02        //  Filial Ate                               ³
	//³ mv_par03        //  Centro de Custo De                       ³
	//³ mv_par04        //  Centro de Custo Ate                      ³
	//³ mv_par05        //  Matricula De                             ³
	//³ mv_par06        //  Matricula Ate                            ³
	//³ mv_par07        //  Nome De                                  ³
	//³ mv_par08        //  Nome Ate                                 ³
	//³ mv_par09        //  Chapa De                                 ³
	//³ mv_par10        //  Chapa Ate                                ³
	//³ mv_par11        //  Situa‡äes                                ³
	//³ mv_par12        //  Categorias                               ³
	//³ mv_par13        //  Data Referencia                          ³
	//³ mv_par14        //  Tipo Formulario 1-Etiqueta 2-Cartao Ponto³
	//³ mv_par15        //  Tamanho da Etiqueta                      ³
	//³ mv_par16        //  Informe Numero Linhas para Salto         ³
	//³ mv_par17        //  Numero de Colunas                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Titulo := STR0010		//"EMISSO ETIQUETA / CARTO DE PONTO"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Envia controle para a funcao SETPRINT                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	wnrel:="GPER310"            //Nome Default do relatorio em Disco
	wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa Impressao                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ! fInicia(cString)
		Return
	Endif

	RptStatus({|lEnd| GR310Imp(@lEnd,wnRel,cString)},Titulo)
Else
	Help(" ",1,aMsg[1],,aMsg[2],1,0)
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GR310IMP ³ Autor ³ R.H. - Marcos Stiefano³ Data ³ 24.05.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emiss„o da Etiqueta / Cart„o de Ponto                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ GR310Imp(lEnd,wnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - A‡Æo do Codelock                             ³±±
±±³          ³ wnRel       - T¡tulo do relat¢rio                          ³±±
±±³          ³ cString     - Mensagem			                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function gr310imp(lEnd,WnRel,cString )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local CbTxt //Ambiente
Local CbCont
Local aCodFol    := {}
Local nCont   	 := 0
Local cAcessaSRA := &("{ || " + ChkRH("GPER310","SRA","2") + "}")
Local X			 := 0
Local cTxtFun	 := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nOrdem     := aReturn[8]
cFilDe     := mv_par01
cFilAte    := mv_par02
cCcDe      := mv_par03
cCcAte     := mv_par04
cMatDe     := mv_par05
cMatAte    := mv_par06
cNomeDe    := mv_par07
cNomeAte   := mv_par08
cChapaDe   := mv_par09
cChapaAte  := mv_par10
cSituacao  := mv_par11
cCategoria := mv_par12
dDataref   := mv_par13
nTipFor    := mv_par14
nTamEtiq   := mv_par15
nNumLin    := mv_par16
nColunas   := If( mv_par17 > 4 , 4 , mv_par17 )

If nNumLin = 0
	nNumLin := 1
Endif
Private cNormal_A := ""
Private cNormal_D := ""
Private cCompri_A := ""
Private cCompri_D := ""
Private cExpand_A := ""
Private cExpand_D := ""
Private cSexto_A  := ""
Private cSexto_D  := ""
Private cOitavo_A := ""
Private cOitavo_D := ""
Private cExpoen_A := ""
Private cExpoen_D := ""
Private cIndice_A := ""
Private cIndice_D := ""

//-- Se nao for para disco, obtem os codigos para impressao normal, comprimida e
//-- reduzida.
//-- Pois, na tela, esses comandos nao tem efeito e as informacoes saem desposicionadas.

If aReturn[5] # 1
	 cExpand_A := Chr(14)
	 cExpand_D := Chr(20)
	 cSexto_A  := Chr(50)
	 cSexto_D  := Chr(27)+"0"
	 cOitavo_A := Chr(27)+"0"
	 cOitavo_D := Chr(27)+"2"
	 cExpoen_A := Chr(27)+"S"+Chr(0)
	 cExpoen_D := Chr(27)+"T"
	 cIndice_A := Chr(27)+"S"+Chr(0)
	 cIndice_D := Chr(27)+"T"

	If nColunas <= 2
		If (aReturn[5] == 3,aReturn[4] := 1,nil)  //Quando for Direto na porta e tiver a 2 colunas ou menos, deverá comprimir a impressão.
		cNormal_A := AvalImp(132)
		cNormal_D := AvalImp(132)
		cCompri_A := AvalImp(132)
		cCompri_D := AvalImp(132)
	Else
		cNormal_A := AvalImp(220)
		cNormal_D := AvalImp(220)
		cCompri_A := AvalImp(220)
		cCompri_D := AvalImp(220)
	Endif
Endif

dbSelectArea( "SRA" )
If nOrdem == 1
	dbSetOrder( 1 )
ElseIf nOrdem == 2
	dbSetOrder( 2 )
ElseIf nOrdem == 3
	dbSetOrder(3)
ElseIf nOrdem == 4
	dbSetOrder(1)
Endif

dbGoTop()

If nOrdem == 1
	dbSeek(cFilDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_MAT"
	cFim    := cFilAte + cMatAte
ElseIf nOrdem == 2
	dbSeek(cFilDe + cCcDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
	cFim    := cFilAte + cCcAte + cMatAte
ElseIf nOrdem == 3
	DbSeek(cFilDe + cNomeDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT"
	cFim    := cFilAte + cNomeAte + cMatAte
ElseIf nOrdem == 4
	dbSeek(cFilDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_MAT"
	cFim    := cFilAte + cMatAte
Endif

#IFNDEF TOP
	If nOrdem == 4
		cIndCond:= "SRA->RA_FILIAL + SRA->RA_CHAPA"
		cFor :="(SRA->RA_FILIAL + SRA->RA_CHAPA >= cFilDe + cChapaDe) "
		cFor +=".And. (SRA->RA_FILIAL + SRA->RA_CHAPA <= cFilAte + cChapaAte)"
	Endif
#ELSE
	If nOrdem == 4
		cIndCond:= "SRA->RA_FILIAL + SRA->RA_CHAPA"
		cFor :='(RA_FILIAL + RA_CHAPA >= "'+cFilDe + cChapaDe+'")'
		cFor +='.And. (RA_FILIAL + RA_CHAPA <= "'+cFilAte + cChapaAte+'")'
	Endif
#ENDIF

If nOrdem == 4
	cArqNtx  := CriaTrab(Nil,.F.)
	IndRegua("SRA",cArqNtx,cIndCond,,cFor,STR0011)	//"Selecionando Registros..."
Endif


dbSelectArea( "SRA" )
SetRegua(SRA->(RecCount()))

If nTamEtiq == 2
	@ Li,0 PSAY cOitavo_A
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime etiqueta Teste                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5] # 1
	TesteEtq(nTipFor,cString)
Endif

SetPrc(0,0)
Chave      := 0
cFilialAnt := Space(FwGetTamFilial)
cCcAnt     := Space(9)

dbSelectArea( "SRA" )
While !Eof() .And. Chave = 0
	Afill(cLin,"")
	nFunc   := 0
	nCont   := 1
	cLinha1 := ""

	While !Eof() .And. Chave = 0 .And. nFunc < nColunas
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Movimenta Regua Processamento                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		IncRegua()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cancela ImpresÆo ao se pressionar <ALT> + <A>                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If lEnd
			@Prow()+1,0 PSAY cCancel
			Exit
		EndIF

		If SRA->RA_FILIAL # cFilialAnt
			If !fInfo(@aInfo,SRA->RA_FILIAL)
				Chave := 1
				Exit
			Endif
			dbSelectArea( "SRA" )
			cFilialAnt := SRA->RA_FILIAL
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica o De / Ate Solicitado                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nOrdem == 1
			If SRA->RA_FILIAL + SRA->RA_MAT > cFilAte + cMatAte
				Chave := 1
				Exit
			Endif
		Elseif nOrdem == 2
			If SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT > cFilAte + cCcAte + cMatAte
				Chave := 1
				Exit
			Endif
		Elseif nOrdem == 3
			If SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT > cFilAte + cNomeAte + cMatAte
				Chave := 1
				Exit
			Endif
		Elseif nOrdem == 4
			If SRA->RA_FILIAL + SRA->RA_CHAPA > cFilAte + cChapaAte
				Chave := 1
				Exit
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cancela ImpresÆo ao se pressionar <ALT> + <A>                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If lEnd
			@Prow()+1,0 PSAY cCancel
			Exit
		EndIF

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Consiste Parametriza‡Æo do Intervalo de ImpressÆo            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (Sra->Ra_Chapa < cChapaDe) .Or. (Sra->Ra_Chapa > cChapaAte) .Or. ;
			(Sra->Ra_Nome < cNomeDe) .Or. (Sra->Ra_Nome > cNomeAte) .Or. ;
		   (Sra->Ra_Mat < cMatDe) .Or. (Sra->Ra_Mat > cMatAte) .Or. ;
			(Sra->Ra_CC < cCcDe) .Or. (Sra->Ra_CC > cCCAte)
			dbSkip()
			Loop
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica Situacao e Categoria do Funcionario                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !( SRA->RA_SITFOLH $ cSituacao ) .OR. !( SRA->RA_CATFUNC $ cCategoria )
			dbSkip()
			Loop
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Consiste controle de acessos e filiais validas               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
			dbSkip()
			Loop
		EndIf

		cLin[nCont] += cCompri_A + STR0012	//"CHAPA:"

		//-- Para saida em disco não utiliza caracteres de compressao/expansao
		//-- Logo imprimimos a chapa em seguida ao "dizer" "CHAPA:"
		If aReturn[5] == 1
				cLin[nCont] += Space(1) + Padr(SRA->RA_CHAPA ,17)
		Else
		    //-- Espaco reservado para posteriormente imprimir a Chapa em tamanho expandido
			cLin[nCont] += Space(18)
		Endif

		cLin[nCont] += STR0013+fDesc("SX5","28"+SRA->RA_CATFUNC,"X5DESCRI()",11,SRA->RA_FILIAL)+" "+Upper(FDESC_MES(Month(dDataRef),3))+"/"+PADR(Right(Str(Year(dDataRef)),IF(nTData=8,2,4)),4)+If(nfunc < 3,SPACE(6),"")

		//-- Para saida na impressora alimenta cLinha1 que sera utilizado para imprimir a chapa
		//-- no "espaco" reservada a mesma (Space(18)) como programado acima.
		If aReturn[5] <> 1
			cLinha1     += cCompri_A + Space(7) + cNormal_A + cExpand_A + SRA->RA_CHAPA + cExpand_D + cNormal_A + cCompri_A + If(nFunc < 3,Space(If(nFunc=1,39,40)),"")
		Endif


		nCont ++
		cLin[nCont] += STR0020+SubStr(SRA->RA_NOME, 1, Len(SRA->RA_NOME) + 6 - Len(Alltrim(SRA->RA_MAT)))+STR0021+Alltrim(SRA->RA_MAT)+If(nFunc < 3,Space(14-Len(STR0020)),"")	//"NOME:"###" MATR:"
		nCont ++
		If cPaisLoc == "BRA"
			cTxtFun	    := STR0022+Alltrim(DescFun(SRA->RA_CODFUNC,SRA->RA_FILIAL,20))+STR0023+Alltrim(SRA->RA_NUMCP)+ "/" +Alltrim(SRA->RA_SERCP)	//"FUNCAO:"###" CTPS:"
			cLin[nCont] += SubStr(cTxtFun,1,56)
			cLin[nCont] += If(Len(cTxtFun) < 56 ,Space(56 - Len(cTxtFun)) , "" )

		Else
			cLin[nCont] += STR0022+DescFun(SRA->RA_CODFUNC,SRA->RA_FILIAL)+Space(Len(STR0023)+TamSx3("RA_NUMCP")[1]+TamSx3("RA_SERCP")[1]+1)+ If(nFunc<3 , Space(11) , "" )	//"FUNCAO:"###" CTPS:"
		EndIf

		cDescEmp  := aInfo[03]									// Razao Social
		cDescEnd  := aInfo[04]									// Endereco
		cDescAtiv := StrZero(Val(Subst(aInfo[16],1,7)),7)		// Atividade Economica CNAE
		cDescCgc  := If( Len(aInfo) >= 27 .And. !Empty( aInfo[27] ), aInfo[27], aInfo[8] )// CGC/CEI
		nTpInsc   := aInfo[15]									// Tipo de Inscricao

		If nTpInsc = 1 .Or. ( Len(aInfo) >= 27 .And. !Empty( aInfo[27] ) )
			cDescCgc  := cDescCgc+Space(4)
		Elseif nTpInsc = 2
			cDescCgc  := Transform(cDescCgc,"@R ##.###.###/####-##")
		Else
			cDescCgc  := Transform(Subs(cDescCgc,1,11),"@R ###.###.###-##")+Space(4)
		Endif

		If nTamEtiq == 1
			nCont ++
			cLin[nCont] += STR0024+Left(cDescEmp,30)+STR0025+cDescAtiv+If(nFunc < 3,Space(8),"")	//"EMPR: "###" ATIV:"
			nCont ++
			cLin[nCont] += STR0026+Left(cDescEnd,30)+STR0027+SUBS(SRA->RA_CC+SPACE(9),1,9)+IF(nFunc < 3,Space(8),"")	//"END:"###" C.C:"
		Endif

		nCont ++
		wCcto := DescCc(SRA->RA_CC,SRA->RA_FILIAL)
		If cPaisLoc == "BRA"
			If nTamEtiq == 1
				If nTpInsc = 1 .Or. ( Len(aInfo) >= 27 .And. !Empty( aInfo[27] ) )
					cLin[nCont] += STR0042+cDescCgc+" "+Space(50-27-Len(Rtrim(wCcto)))+Rtrim(wCcto)+If(nFunc < 3,Space(9),"")	//"CGC: "
				Else
					cLin[nCont] += STR0028+cDescCgc+" "+Space(50-27-Len(Rtrim(wCcto)))+Rtrim(wCcto)+If(nFunc < 3,Space(9),"")	//"CGC: "
				EndIf
			Else
				cLin[nCont] += STR0028+cDescCgc+" "+SRA->RA_CC+"-"+Left(wCcto,If(Len(SRA->RA_CC)=9,13,18))+If(nFunc < 3,Space(9),"")	//"CGC: "
			Endif
		Else
			If nTamEtiq == 1
				cLin[nCont] += Rtrim(wCcto) + Space(47-Len(Rtrim(wCcto)))+If(nFunc < 3,Space(9),"")	//"Desc. C.C."
			Else
				cLin[nCont] += Left(wCcto,If(Len(SRA->RA_CC)=9,13,18))+ Space(Len(STR0028+cDescCgc)+TamSx3("RA_CC")[1])+If(nFunc < 3,Space(11),"")	//"Desc. C.C. "
			Endif
		EndIf
		cLin[nCont] := Substr(cLin[nCont],1,Len(cLin[1]))
		nCont ++
		cLin[nCont] += if(nfunc >0,space(3),"") +  STR0029+If(nFunc < 3,Space(10),"")	//"   HORARIO DE TRABALHO               INTERVALO"

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Busca o SR6 Horario de Trabalho e Intervalo                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea( "SR6" )
		dbSeek(xFilial( "SR6" ) + SRA->RA_TNOTRAB )
		If !Found()
			wTurno := SPACE(50)
		Endif
		wTurno := SR6->R6_DESC
		nCont ++
		cLin[nCont] += wTurno + IF(nFunc < 3,Space(6),"")
		nFunc ++
		nCont := 1
		dbSelectArea( "SRA" )
		dbSkip()
	Enddo

	If lEnd
		Exit
	EndIF

 	If cLin[1] # NIL
		For X := 1 To If(nTamEtiq = 1,8,6)
			@ LI, 0 PSAY cLin[X]
			IF X = 1 .and.  ( aReturn[5] # 1 )
				@ Li, 0 PSAY cLinha1
				@ Li, 0 PSAY cLinha1
			Endif
			Li ++
		Next X
	Endif
 	IF nTipFor == 2   // Se For Cartao de Ponto Salta para a Impressao do Proximo
		Li += nNumLin
	Elseif nTamEtiq == 1
		Li ++
	Elseif nTamEtiq == 2
		Li += 2
	Endif
	If ( aReturn[5] ) == 1
		If ( Li > 60 )
			Li	:= 0
		EndIf
	EndIf
Enddo
If nTamEtiq == 2
	@ Li,0 PSAY cOitavo_D
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do Relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( "SRA" )
Set Filter to
If nOrdem == 4
	RetIndex( "SRA" )
Endif
dbSetOrder(1)
If nOrdem == 4
	fErase( cArqNtx + OrdBagExt() )
Endif

Set Device To Screen

If aReturn[5] = 1
	Set Printer To
	Commit
	ourspool(wnrel)
Endif

MS_FLUSH()

Return( .T. )


*---------------------------------*
Static Function TesteEtq(cTipoetq,cString)
*---------------------------------*
Local cDescEmp  := Replicate("X",30)
Local cDescCgc  := Replicate("9",19)
Local cDescEnd  := Replicate("X",30)
Local cDescAtiv := "9999999"
Local cDescFunc := Replicate("X",10)
Local XW		:= 0
Local MZ		:= 0

lTeste := .T.

While lTeste
	nCont := 1
	nCol  := 0

	While nCont <= nColunas
		@ Li,nCol PSAY cCompri_A +STR0030+SPACE(15)+STR0031	//"CHAPA:"###"CATEG:XXXXXXXXXXX XXX/9999"
		nCont ++
		nCol  += 58
	Enddo
	For XW := 1 To 2
		Vez := IIF(nCont = 5, 4 , Iif(nCont = 4 , 3 , Iif(nCont= 3 , 2 , 1)))
		Ini := 001
		For MZ = 1 To Vez
			Ini=Iif(MZ=1,1,Iif(MZ=2,61,Iif(MZ=3,103,154)))
			@ Li,Ini PSAY cCompri_A + Space(7) + cNormal_A + cExpand_A + "99999" + cExpand_D + cNormal_A + cCompri_A + SPACE(15)
		Next MZ
	Next XW

	Li ++
	nCol := 0
	nCont:= 1
	While nCont <= nColunas
		@ Li,nCol PSAY STR0032+SRA->RA_NOME+STR0033+SRA->RA_MAT	//"NOME:"###" MATR.:"
		nCol += 56
		nCont++
	Enddo

	Li ++
	nCol := 0
	nCont:= 1
	While nCont <= nColunas
		@ Li,nCol PSAY STR0034+cDescFunc+STR0035+alltrim(SRA->RA_NUMCP)+"/"+SRA->RA_SERCP	//"FUNCAO:"###" CTPS:"
		nCol += 56
		nCont++
	Enddo

	If nTamEtiq = 1
		Li ++
		nCol := 0
		nCont:= 1
		While nCont <= nColunas
			@ Li,nCol PSAY STR0024+cDescEmp+STR0025+cDescAtiv	//"EMPR:"###" ATIV:"
			nCol += 56
			nCont++
		Enddo
		Li ++
		nCol := 0
		nCont:= 1
		While nCont <= nColunas
			@ Li,nCol PSAY STR0038+cDescEnd+STR0039	//"END.:"###' CCUSTO:9999'
			nCol += 56
			nCont++
		Enddo
	Endif

	Li ++
	nCol := 0
	nCont:= 1
	While nCont <= nColunas
		cDescCcto := Replicate("X",24)
		@ Li,nCol PSAY STR0040+cDescCgc + Space(50-26-len(Rtrim(cDescCcto)))+Rtrim(cDescCcto)	//"CGC: "
		nCol += 56
		nCont++
	Enddo

	Li++
	nCol := 0
	Soma := 1
	While Soma <= Vez
		@ Li,nCol PSAY STR0041	//"   HORARIO DE TRABALHO               INTERVALO"
		nCol += 56
		Soma++
	Enddo

	nCol := 0
	Li ++
	nCont:= 1
	While nCont <= nColunas
		cDescTurn := Replicate("X",51)
		@ Li,nCol PSAY Subst(cDescTurn,1,30)+Subst(cDescTurn,31,22)
		nCol := nCol + 56
		nCont++
	Enddo

	IF cTipoEtq = 2   // se for cartao salta para o proximo
		LI += nNumLin + 1
	Elseif nTamEtiq = 1
		LI += 2
	Elseif nTamEtiq = 2
		LI += 3
	Endif

	If ( aReturn[5] == 1 )
		If ( Li > 60 )
			Li	:= 0
		EndIf
	EndIf


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Testa impressao                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	fImpTeste(cString)


Enddo
Return Li
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fImpTeste ºAutor  ³R.H. - Natie        º Data ³  11/29/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Testa impressao de Formulario Teste                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static function fImpTeste(cString)

//--Comando para nao saltar Comando para não saltar folha apos o MsFlush.
SeTPgEject(.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Descarrega teste de impressao                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MS_Flush()


fInicia(cString)

LI := 2

Pergunte("GPR30A",.T.)
lTeste:= If(mv_par01 = 1 ,.F. , .T. )

Return lTeste


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fInicia   ºAutor  ³R.H.Natie           º Data ³  11/12/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Inicializa Impressao                                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fInicia(cString)

If nLastKey == 27
	Return .F.
Endif
SetDefault(aReturn,cString)
If nLastKey == 27
	Return .F.
Endif

Return .T.
