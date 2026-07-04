/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER540.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER540  ³ Autor ³ R.H. - Kleber D. Gomes³ Data ³ 17.01.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ GFIP - Guia de Recolhimento do FGTS e Inform. … Previdˆncia³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER540(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ Requisito³  Motivo da Alteracao                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Bruno Nunes ³20/12/14|          | Unificacao da V1   				  ³±±
±±³Renan Borges³19/10/15| TTOL24   |Ajuste para imprimir relatório da GFIP³±±
±±³            ³        |          |corretamente, sem gerar error.log.    ³±±
±±³M. Silveira ³24/11/15| TTRBMS   |Ajuste na chave de pesquisa do periodo³±±
±±³            ³        |          |considerar ano com 2 ou 4 digitos.    ³±±
±±³Victor A.   ³31/05/16| TVEOF5   |Ajuste na quebra de paginas           ³±±
±±³Isabel N.   ³09/01/17| MRH-4394 |Ajuste no nome dos campos CTT_PERFPAS ³±±
±±³            ³        |          |p/CTT_PERFPA, CTT_PERCACI p/CTT_PERCAC³±±
±±³            ³        |          |conforme cadastrados no ATUSX.        ³±±
±±³Paulo O.    ³05/05/17|DRHPAG-119|Ajuste para não cortar a totalização  ³±±
±±³Inzonha     ³        |          |na impressão/XPS/PDF                  ³±±
±±³Jaqueline   ³08/02/18|DRHPAG-   |Ajuste para filtrar também os funciona³±±
±±³Laurenti    ³        |10569     |rios afastados                        ³±±
±±³Jaqueline   ³07/03/18|DRHPAG-   |Ajuste para filtrar também os funciona³±±
±±³Laurenti    ³        |13957     |rios DEMITIDOS                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER540()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aArea			:= GetArea()
Local cString 		:= "SRA"	//Alias do arquivo principal (Base)
Local aOrd    		:= {STR0001,STR0002,STR0003,STR0004}    //"Filial+Mat"###"Filial+Cc+Mat"###"Filial+Nome"###"Filial+Cc+Nome"
Local cDesc1  		:= STR0005	//"GFIP - Guia de Recolhimento do FGTS e Informa‡äes a Previdencia Social"
Local cDesc2  		:= STR0006  //"Ser  impresso de acordo com os parametros solicitados pelo usu rio."
Local aRegs			:= {}
Local aOfusca		:= If(FindFunction('ChkOfusca'), ChkOfusca(), { .T., .F., {"",""} }) //[1]Acesso; [2]Ofusca; [3]Mensagem
Local aFldRel		:= {"RA_PIS", "RA_NOME", "RA_NUMCP", "RA_SERCP"}
Local lBlqAcesso	:= aOfusca[2] .And. !Empty( FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRel ) )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn  	:= {STR0008,1,STR0009,1,2,1,"",1 }   // "Zebrado"###"Administra‡„o"
Private NomeProg 	:= "GPER540"
Private aLinha   	:= {}
Private nLastKey 	:= 0
Private cPerg    	:= "GPR540"
Private aCabecalho  := {}
Private aDetalhe	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Utilizadas na funcao IMPR                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private Titulo   	:= STR0005   //"GFIP - Guia de Recolhimento do FGTS e Informa‡äes a Previdencia Social"
Private AT_PRG   	:= "GPER540"
Private wCabec0  	:= 2
Private wCabec1  	:= ""
Private wCabec2  	:= ""
Private Contfl   	:= 1
Private Li       	:= 0
Private nTamanho 	:= "G"
Private colunas	 	:= 220

	If lBlqAcesso
		Help(" ",1,aOfusca[3,1],,aOfusca[3,2],1,0)
		//"Dados Protegidos- Acesso Restrito: Este usuário não possui permissão de acesso aos dados dessa rotina. Saiba mais em {link documentação centralizadora}"
	Else
		aAdd(aRegs, {cPerg,"19","Versao             ?","¨Version           ?","Version            ?","mv_ch+","N",01,0,02,"C" ,"","mv_par19","4.0","4.0","4.0","",""	,"5.0","5.0","5.0",""	,""	,"Atual","Atual","Atual",""	,""	,""	,""	,""	,""	,""	,""	,""	,"","","","","",{}})
		ValidPerg(aRegs, cPerg, .T.)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica as perguntas selecionadas                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Pergunte("GPR540",.F.)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Variaveis utilizadas para parametros                         ³
		//³ mv_par01        //  Filial  De                               ³
		//³ mv_par02        //  Filial  Ate                              ³
		//³ mv_par03        //  C.Custo De                               ³
		//³ mv_par04        //  C.Custo Ate                              ³
		//³ mv_par05        //  Matricula De                             ³
		//³ mv_par06        //  Matricula Ate                            ³
		//³ mv_par07        //  Nome De                                  ³
		//³ mv_par08        //  Nome Ate                                 ³
		//³ mv_par09        //  Data de Referencia                       ³
		//| mv_par10        //  Precisa incluir Mes / Ano Competencia    ³
		//³ mv_par11        //  Filial Centralizadora                    ³
		//³ mv_par12        //  Pessoa para contato                      ³
		//³ mv_par13        //  DDD/Telefone                             ³
		//³ mv_par14        //  Movimento  1- Mensal   2- Acumulado      ³
		//³ mv_par15        //  Opcao imposto SIMPLES   1-Nao  2-Sim     ³
		//³ mv_par16        //  Valor da Receita Bruta ( SENAR )         ³
		//³ mv_par17        //  Recolhimento FGTS 1-no prazo 2-em atraso ³
		//³ mv_par18        //  Percentual do JAM                        ³
		//³ mv_par19        //  Codigo Recolhimento                      ³
		//³ mv_par20        //  Versao Sefip( 4.3/Atual)                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Envia controle para a funcao SETPRINT                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		wnRel := "GPER540" //Nome Default do relatorio em Disco
		wnRel := SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,,.F.,aOrd,.F.,nTamanho)

		If nLastKey == 27
			Return()
		Endif
		SetDefault(aReturn,cString)
		If nLastKey == 27
			Return()
		Endif

		RptStatus({|lEnd| GR540Imp(@lEnd,wnRel,cString)},Titulo)

		RestArea(aArea)
	EndIf

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GR540IMP ³ Autor ³ R.H. - Kleber D. Gomes³ Data ³ 08.01.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ GFIP - Guia de Recolhimento do FGTS e Inform. … Previdˆncia³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ GR540Imp(lEnd,wnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - Acao do Codelock                             ³±±
±±³          ³ wnRel       - T¡tulo do relat¢rio                          ³±±
±±³          ³ cString     - Mensagem                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function gr540imp(lEnd,WnRel,cString )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aInfo   		:= {}
Local cAuxCompet	:= ""
Local nAliqSat   	:= 0
Local cAliqSat   	:= "0,0 %"
Local nPercFPAS  	:= 0
Local aInssEmp   	:= Array(23,2)
Local cCateg     	:= Space(2)
Local cOcorr     	:= Space(2)
Local cCodAfast  	:= ""
Local dDtAfast		:= CtoD("")
Local dtUltRes		:= CtoD("")
Local lExiste    	:= .F.
Local aInfEmp    	:= Array(9)

Local aTomador		:= {Space(14), Space(9), Space(25)}
	//01 - cITomador
	//02 - cTomador
	//03 - cDTomador

Local aTotais    	:= Array(11)
	//01 - Remuneracao(sem parcela do 13o. salario)
	//02 - Remuneracao 13o. salario(somente parcela do 13o.sal.)
	//03 - Soma das ocorrencias
	//04 - Rem + 13o.(Cat.1,2,3 e 5)
	//05 - Rem + 13o.(Cat 4)
	//06 - nValFGTS
	//07 - nBaseINSS
	//08 - nINSSFunc
	//09 - nDeducao
	//10 - nAciTra
	//11 - nSalFam

Local aValFunc		:= Array(9)
	//1 - nBASE,
	//2 - n13BASE,
	//3 - nBaseINSS,
	//4 - nINSSFunc,
	//5 - nDeducao,
	//6 - nValFGTS,
	//7 - nSalFam,
	//8 - nBaseFun,
	//9 - nAciTra

Local cAcessaSRA	:= &("{ || " + ChkRH("GPER540","SRA","2") + "}")
Local nVezes		:= 0
Local nAfast		:= 0
Local cAliasQry  	:= GetNextAlias()
Local nRec 			:= 0
Local nVerba 		:= 0
Local aVerba		:= {}
Local aGrpAberto	:= {}
Local aGrpFechado	:= {}
Local nTotFun		:= 0
Local nTotVer		:= 0
Local aVerbas		:= {}

Local aPdMat		:= {}
Local cAux			:= ""
Local cVerba		:= ""
Local nX			:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private (Programa)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aCodFol      := {}
Private cTerceiros   := Space(4)
Private cDiasMes     := Getmv("MV_DIASMES")
Private DiasDsr      := 0
Private nTotDias     := 0
Private aAfast       := {}
Private cFilAnterior := ''
Private cCcAnt       := ''

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private nOrdem      := aReturn[8]
Private cFilDe  	:= mv_par01
Private cFilAte    	:= mv_par02
Private cCcDe      	:= mv_par03
Private cCcAte     	:= mv_par04
Private cMatDe     	:= mv_par05
Private cMatAte    	:= mv_par06
Private cNomDe     	:= mv_par07
Private cNomAte    	:= mv_par08
Private dDtRef   	:= mv_par09
Private cPeriodo   	:= ""
Private cCentra    	:= mv_par10
Private cContato   	:= PadR(mv_par11,30)
Private cFone      	:= PadR(mv_par12,16)
Private cSimples   	:= Right(Str(mv_par14),1)
Private nEvento 	:= mv_par15
Private nTipo 		:= mv_par16
Private nJam       	:= mv_par17
Private cRecol     	:= mv_par18
Private nVersao	   	:= mv_par19  //Versao 4.0/5.0/Atual
Private cPeriRel    := Right(Str(Year(dDtRef)),4) + Substr(DtoC(dDtRef),3,3)
Private nLinha 		:= 0
Private cVerbasCP00 := ""
Private lVerAfa00	:= .F.
Private lVerAfa15	:= .F.

SetMnemonicos( , , .T. )

cPeriodo   	:= cValToChar(Year(mv_par09)) + StrZero(Month(mv_par09),2)
//Verificação de verbas a reduzir da contribuição patronal - SEFIP 8.4
If cPeriodo >= "202011"
	P_ENCEMP	:= Iif(Type("P_ENCEMP")=="U", "", P_ENCEMP) //Define quais encargos terão as verbas de maternidade deduzidas. 1 = Todos
	P_DEDMAT	:= Iif(!Empty(P_ENCEMP) .And. Type("P_DEDMAT") <> "U", P_DEDMAT, "") //Define quais verbas de maternidade serão deduzidas. 1 = Todos
	P_ENCEMPAF	:= Iif(Type("P_ENCEMPAF") == "U", "", P_ENCEMPAF) //Define quais encargos terão as verbas de incidência CP 15 deduzidas. 1 = Todos

	If !Empty(P_DEDMAT)
		cAux := ""
		If P_DEDMAT <> '1' .And. !("*" $ P_DEDMAT)
			For nX := 1 To Len(P_DEDMAT) Step 3
				cVerba := SubStr(P_DEDMAT, nX, 3)
				If RetValSrv( cVerba, SRA->RA_FILIAL, "RV_INSS" ) == "S"
					cAux += cVerba + "*"
				EndIf
			Next nX
			P_DEDMAT := cAux
		ElseIf P_DEDMAT == "1"
			aPdMat := fCarPdMat()
			For nX := 1 To Len(aPdMat)
				cAux += aPdMat[nX] + "*"
			Next nX
			P_DEDMAT := cAux
		EndIf 
	EndIf

	aPd00 	:= fCarPd00()
	cAux	:= ""
	For nX := 1 To Len(aPd00)
		cAux += aPd00[nX] + "*"
	Next nX
	
	cVerbasCP00 	:= cAux
	lVerAfa00		:= RCM->( ColumnPos("RCM_PDSUP") ) > 0
	lVerAfa15		:= !Empty(P_ENCEMPAF)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Zera Acumulador dos Totais                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LimpaTot(@aTotais)
LimpaTot(@aValFunc)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta array com os periodos que serao usadaos no processa-   ³
//³ mento. Obs: Tanto periodo aberto como fechado estarao no     ³
//³ array aPeriodo.           							         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !MntArrPer(@aGrpAberto, @aGrpFechado)
	Alert('Não encontrou periodos')
	EncerraImp()
	Return()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta query do cadastro de funcionarios para processamento   ³
//³ filtrando pelo pergunte.                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !MntFunPer(cAliasQry, @nRec)
	Alert('Não encontrou funcionários para o periodo selecionado')
	EncerraImp()
	Return()
EndIf

SetRegua(nRec)
(cAliasQry)->(dbGoTop())

While (cAliasQry)->(!Eof())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta Regua Processamento                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IncRegua()

	If lEnd
		Exit
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste se o funcionario existe e posiciona na SRA          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea('SRA')
	SRA->(dbSetOrder(1))
	If !SRA->(dbSeek((cAliasQry)->(RA_FILIAL+RA_MAT)))
		(cAliasQry)->(dbSkip())
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Passa para o proximo funcionario se nao possuir periodo      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If aScan(aGrpAberto , {|x| x[1] == SRA->RA_PROCES }) == 0 .And. ;
	   aScan(aGrpFechado, {|x| x[1] == SRA->RA_PROCES }) == 0
		(cAliasQry)->(dbSkip())
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Quebra de Filial para carregar dados da empresa              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SRA->RA_FILIAL # cFilAnterior

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Carrega dados de tomador                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		CarTomador(@aTomador, @nPercFPAS, @aInssEmp)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Carrega array com vervbas que serao usadas no processamento  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		RetVerPro(@aVerbas)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Carrega dados da empresa                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !CarEmp(@cCentra, @aInfo, @aInssEmp, @aInfEmp)
			(cAliasQry)->(dbSkip())
			Loop
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta rodape da filial corrente                              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ExisteTot(aTotais)
			If (SRA->RA_CC #  cCcAnt .And. (nOrdem == 1 .Or. nOrdem == 3)) .Or. ;//A quebra sera feita no centro de custo
			   (SRA->RA_CC == cCcAnt .And. (nOrdem == 2 .Or. nOrdem == 4))
				fTotFol(@aTotais, aInssEmp, nPercFPAS, .T., aValFunc)
			EndIf
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta cabecalho da proxima filial                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fCabecalho(.T.,aInssEmp,nPercFPAS,cAliqSat,cTerceiros,aInfEmp, aTomador)
	End

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Quebra de Centro de Custro                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SRA->RA_CC # cCcAnt .And. (nOrdem == 2 .Or. nOrdem == 4)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta rodape do ccentro de custo corrente                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ExisteTot(aTotais)
			fTotFol(@aTotais, aInssEmp, nPercFPAS, .T., aValFunc)
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Carrega dados de tomador                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		CarTomador(@aTomador, @nPercFPAS, @aInssEmp)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta cabecalho do proximo centro de custo                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fCabecalho(.T., aInssEmp, nPercFPAS, cAliqSat, cTerceiros, aInfEmp, aTomador)
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste se funcionario esta no parametro                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If 	(SRA->RA_NOME < cNomDe) .Or. (SRA->RA_NOME > cNomAte) .Or. ;
		(SRA->RA_MAT  < cMatDe) .Or. (SRA->RA_MAT  > cMatAte) .Or. ;
		(SRA->RA_CC   < cCcDe)  .Or. (SRA->RA_CC   > cCcAte)  .Or. ;
		SRA->RA_SITFOLH $ "E,T" .Or. Empty(SRA->RA_PIS)
		(cAliasQry)->(dbSkip())
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste controle de acessos e filiais validas               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
		(cAliasQry)->(dbSkip())
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste data de admissao                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SRA->RA_ADMISSA > dDtRef .OR. SRA->RA_OPCAO > dDtRef
		(cAliasQry)->(dbSkip())
		Loop
	EndIf

	cRot     := ''

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carrega todos os periodos aberto do processo do funcionario   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aPerAberto  := {}
	If (nPos := aScan(aGrpAberto, {|x| x[1] == SRA->RA_PROCES })) > 0
		aPerAberto := aGrpAberto[nPos][2]
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carrega todos os periodos fechado do processo do funcionario  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aPerFechado := {}
	If (nPos := aScan(aGrpFechado, {|x| x[1] == SRA->RA_PROCES })) > 0
		aPerFechado := aClone(aGrpFechado[nPos][2])
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carrega todas verbas do funcionario para processamento        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ aVerbasFunc                                                   ³
	//³ 01 Filial                                                     ³
	//³ 02 Matricula                                                  ³
	//³ 03 PD                                                         ³
	//³ 04 Tipo 1                                                     ³
	//³ 05 QtdSem                                                     ³
	//³ 06 Horas                                                      ³
	//³ 07 Valor                                                      ³
	//³ 08 Semana                                                     ³
	//³ 09 Parcela                                                    ³
	//³ 10 Periodo                                                    ³
	//³ 11 Roteiro                                                    ³
	//³ 12 CC                                                         ³
	//³ 13 DataPgt                                                    ³
	//³ 14 DataArq                                                    ³
	//³ 15 Sequencia                                                  ³
	//³ 16 NumId                                                      ³
	//³ 17 Tipo 2                                                     ³
	//³ 18 Nulo                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cProcesso   := SRA->RA_PROCES
	aVerbasFunc := RetornaVerbasFunc(	SRA->RA_FILIAL	,;	//-01 Filial
										SRA->RA_MAT		,;	//-02 Matricula
										SRA->RA_CC		,;	//-03 Centro de Custo
										''				,;	//-04 Roteiro
										aVerbas			,;	//-05 Verbas
										aPerAberto		,;	//-06 Periodo Aberto
										aPerFechado		,;	//-07 Periodo Fechado
										Nil			    ,;	//-08 Semana
										Nil	)				//-09

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula verbas do funcionario                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	CalcVerba(aVerbasFunc, @aValFunc)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Deducao do Salario Maternidade do 13o Salario                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aValFunc[5] += FSDSMatern(aCodFol, aVerbasFunc)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula acidente de trabalho                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aValFunc[9] := fCalcAci(aInssEmp, aValFunc, SRA->RA_FILIAL, SRA->RA_CC)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Nao deve aparecer no arquivo pois nao recolhe FGTS            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SRA->RA_SITFOLH == "A" .And. SRA->RA_AFASFGT $ "X/Y/P/ "
		(cAliasQry)->(dbSkip())
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Funcionario desligado                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dtUltRes	:= fGetDtRes(SRA->RA_FILIAL,SRA->RA_MAT)
	If (SRA->RA_SITFOLH == "D") .And.(dtUltRes < FirstDay(dDtRef))
		(cAliasQry)->(dbSkip())
		Loop
	EndIf


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do Funcionario                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ImpDetalhe(dDtAfast, @aTotais, aInssEmp, nPercFPAS, aInfEmp, @aValFunc, aTomador)

	If lEnd
		Set device to Print
		@Prow()+1,0 PSAY cCancel
		Set Device To Screen
		Exit
	Endif
	(cAliasQry)->(dbSkip())
EndDo

If ExisteTot(aTotais)
	fTotFol(@aTotais, aInssEmp, nPercFPAS, .T., aValFunc)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do Relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( "SRA" )
dbSetOrder(1)
dbSelectArea( "SI3" )
dbSetOrder(1)
dbSelectArea( "SR8" )
dbSetOrder(1)

Set Device To Screen

EncerraImp()

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³FSDSMaternºAutor  ³Microsiga           º Data ³  04/26/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Totaliza a deducao de Sal.Maternidade                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FSDSMatern(aCodFol, aVerbasFunc)
Local nValDed13 := 0
Local nVl13Sal	:= 0
Local nDiasSM   := 0
Local nAvos		:= 0
Local nVerba    := 0
Local nDeducao  := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Deducao de Sal.Matern. no 13o.Salario                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If GetMv("MV_SALMGRP") = "N"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Apura os dias de licenca maternidade ocorridos no ano da data de referencia³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nDiasSM	:= fDiasSm13(Left(Dtos(dDtRef),4))
	If nDiasSM > 0
		For nVerba := 1 To Len(aVerbasFunc)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica a existencia da verba de deducao de sal.maternidade para 13o salario³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If aVerbasFunc[nVerba][03] == aCodFol[670][1] //Deducao Sal rio Maternidade de 13o sal rio na GPS
				nValDed13 += Round(aVerbasFunc[nVerba][07],2)
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Acumulo os valores ja calculados de deducao de sal maternidade para 13o salario ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If aVerbasFunc[nVerba][03] == aCodFol[251,1] .Or.; //Media 13o. Salario Rescisao
			   aVerbasFunc[nVerba][03] == aCodFol[253,1] .Or.; //Media 13o. Salario Sobre Aviso Indenizado Rescisao
			   aVerbasFunc[nVerba][03] == aCodFol[114,1] .Or.; //13§ na Indenizacao Rescisao
			   aVerbasFunc[nVerba][03] == aCodFol[115,1]	   //13§ Sobre Aviso Previo
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verif. 13.Salario Indenizado e 13. Sal. Av. Previo                              ³
				//³ Media 13o. Salario Rescisao e Media 13o. Salario Sobre Aviso Indenizado Rescisao³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If aVerbasFunc[nVerba][03] == aCodFol[114,1] .Or.; //13§ na Indenizacao Rescisao
				   aVerbasFunc[nVerba][03] == aCodFol[115,1]       //13§ Sobre Aviso Previo
					nAvos += Int(aVerbasFunc[nVerba][06])
				EndIf
				nVl13Sal += aVerbasFunc[nVerba][07]
			EndIf

			If PosSrv(aVerbasFunc[nVerba][03], aVerbasFunc[nVerba][01],"RV_TIPOCOD") == "1" .And.;
			   PosSrv(aVerbasFunc[nVerba][03], aVerbasFunc[nVerba][01],"RV_INSS"   ) == "S"
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Considera Id 123 e 124 - Total medias em hrs e vlrs          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If aVerbasFunc[nVerba][03] == aCodFol[024,1] .Or.; //Parcela Final do 13o.Salario
				   aVerbasFunc[nVerba][03] == aCodFol[123,1] .Or.; //Media Total 13o. em Valor
				   aVerbasFunc[nVerba][03] == aCodFol[124,1]       //Media Total 13o. em Horas
					nAvos := Int(If(nAvos==0 ,aVerbasFunc[nVerba][06], nAvos ) )
				Endif
				nVl13Sal += aVerbasFunc[nVerba][07]
			EndIf
		Next nVerba

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Acumulo a deducao do salario maternidade quando houver valor de deducao calculado ou      ³
		//³ quando houver o valor bruto com a quantidade de avos de direito e dias de sal.maternidade.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (nVl13Sal > 0 .Or. nValDed13 > 0).And. nDiasSM > 0 .And. ;
		   (nAvos    > 0 .Or. nValDed13 > 0).And. nDiasSM > 0
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Se o valor da deducao ja estiver acumulado utilizo o proprio valor, senao calculo a deducao ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nDeducao := If(nValDed13==0, Round(((nVl13Sal/nAvos)/30)*nDiasSM,2),nValDed13)
		EndIf
	EndIf
EndIf

Return(nDeducao)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³TransformaºAutor  ³Microsiga           º Data ³  04/26/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Transforma as datas no formato DDMMAAAA                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Transforma(dData)

If Empty(dData)
	Return(Space(10))
Else
	Return(StrZero(Day(dData),2) +"/"+ StrZero(Month(dData),2) +"/"+ Right(Str(Year(dData)),4))
EndIf

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³FCabecalhoºAutor  ³Microsiga           º Data ³  04/26/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Carrega dados do cabecalho                                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FCabecalho(lNew,aInssEmp,nPercFPAS,cAliqSat,cTerceiros,aInfEmp,aTomador)
//            10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220
//  01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//01                                                                                                                                                                | Carimbo CIEF                  | |Para uso da CAIXA       |
//02                                                                                                                                                                |                               | |                        |
//03                                                                                               G F I P - Guia de Recolhimento do FGTS e                         |                               | +------------------------+
//04  CAIXA ECONOMICA FEDERAL - CAIXA          INSTITUTO NACIONAL DO SEGURO SOCIAL - INSS          Informacoes a Previdencia Social                                 |                               | | Competencia mes/ano    |
//05                                                                                                                                                                |                               | | XX/XXXX                |
//06                                                                                                                                                                |                               | +------------------------+
//07                                                                                                                                                                |                               | | Codigo recolhimento    |
//08  | Razao Social/Nome                                         | Pessoa para contato/DDD/telefone                               | CGC/CNPJ/CEI                 | |                               | | XXX                    |
//09  | XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                  | XXXXXXXXXXXXXXXXXXXXXXXXXXXXX  / (XXXX) XXXX-XXXX              | XXXXXXXXXXXXXX               | |                               | +------------------------+
//10  +-----------------------------------------------------------+----------------------------------------------------------------+------------------------------+ +-------------------------------+ OUTRAS INFORMACOES
//11  | Endereco (logradouro,No.,andar,apartamento)                                              | Bairro/distrito                               | CEP            | Municipio                  | UF | | No.Processo Judicial   |
//12  | XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                                                           | XXXXXXXXXXXXXXXXXXXX                          | XXXXXXXX       | XXXXXXXXXXXXXXXXXXXX       | XX | |                        |
//13  +------------------------------------------------------------------------------------------+-----------------------------------------------+----------------+----------------------------+----+ +------------------------+
//14  | FPAS     | Codigo terceiros    | SIMPLES     | Aliquota SAT  | CNAE  | Tomador de servico(CGC/CNPJ/CEI)  | Tomador de Servico (razao social)                                                | | Vara/JCJ               |
//15  | XXX      | XXXX                | X           | X,X %         | XXXXX | XXXXXXXXXXXXXX                    | XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                                         | |                        |
//16  +----------+---------------------+-------------+---------------+-------+-----------------------------------+----------------------------------------------------------------------------------+ +------------------------+
//17  | Valor devido Prev. Social | Contrib. desc. empregado | Valor salario-familia | Comerc.de producao rural | Receira evento desp./patroc. | Compensacao Prev.Social | Somatorio                | |Periodo (de-ate)        |
//18  |        999,999,999,999.99 |       999,999,999,999.99 |    999,999,999,999.99 |                          |           999,999,999,999.99 |                         |       999,999,999,999.99 | |                        |
//19  +---------------------------+--------------------------+-----------------------+--------------------------+------------------------------+-------------------------+--------------------------+ +------------------------+
//20  | No.PIS-PASEP/Inscricao | Adimissao | Carteira de trabalho | Cat | Remuneracao                  | Remuneracao 13o.salario       | Ocor. | Nome do trabalhador                        | Movimentacao |      | Nascimento |
//21  | do contrib. individual | (data)    | (No./serie)          |     | (sem parcela do 13o.salario) | (somente parcela do 13o.Sal.) |       |                                            | (data)       | Cod. | (data)     |
//22  |                        |           |                      |     |                              |                               |       |                                            |              |      |            |

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Nao permite a inclusao de cabecalhos                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  Len(aCabecalho) # 0
	Return()
EndIf

//"Carimbo CIEF"###"Para uso da CAIXA"
aAdd(aCabecalho, Space(158)+"| "+STR0010+Space(18)+"| "+"|"+STR0011+Space(7)+"|")
aAdd(aCabecalho, Space(158)+"|"+Space(31)+"| "+"|"+Space(24)+"|")

//"G F I P - Guia de Recolhimento do FGTS e"
aAdd(aCabecalho, Space(93)+STR0012+Space(25)+"|"+Space(31)+"| "+"+"+Repl("-",24)+"+")

//"CAIXA ECONOMICA FEDERAL - CAIXA"###"INSTITUTO NACIONAL DO SEGURO SOCIAL - INSS"###"Informacoes a Previdencia Social"###"Competencia mes/ano"
aAdd(aCabecalho, STR0013+Space(10)+STR0014+Space(10)+STR0015+Space(33)+"|"+Space(31)+"| "+"| "+STR0016+Space(4)+"|")
aAdd(aCabecalho, Space(158)+"|"+Space(31)+"| "+"| "+cPeriRel+Space(16)+"|")
aAdd(aCabecalho, Space(158)+"|"+Space(31)+"| "+"+"+Repl("-",24)+"+")

//"Codigo recolhimento"
aAdd(aCabecalho, Space(158)+"|"+Space(31)+"| "+"| "+STR0017+Space(4)+"|")

//"Razao Social/Nome"###"Pessoa para contato/DDD/telefone"###"CGC/CNPJ/CEI"
aAdd(aCabecalho, "| "+STR0018+Space(41)+"| "+STR0019+Space(31)+"| "+STR0020+Space(17)+"| |"+Space(31)+"| "+"| "+cRecol+Space(20)+"|")
aAdd(aCabecalho, "| "+aInfEmp[1]+Space(18)+"| "+cContato+" | "+cFone+Space(14)+"| "+aInfEmp[2]+Space(15)+"| "+"|"+Space(31)+"|"+" "+"+"+Repl("-",24)+"+")

//" OUTRAS INFORMACOES"
aAdd(aCabecalho, "+"+Repl("-",59)+"+"+Repl("-",64)+"+"+Repl("-",30)+"+ +"+Repl("-",31)+"+"+STR0021 )
aAdd(aCabecalho, "| "+STR0022+Space(46)+"| "+STR0023+Space(31)+"| "+STR0024+Space(12)+"| "+STR0025+Space(18)+"| "+STR0026+"| | "+STR0027+Space(3)+"|")

//"Endereco (logradouro,No.,andar,apartamento)"###"Bairro/distrito"###"CEP"###"Municipio"###"UF "###"No.Processo Judicial"
aAdd(aCabecalho, "| "+aInfEmp[3]+Space(59)+"| "+aInfEmp[4]+Space(11)+"| "+aInfEmp[5]+Space(7)+"| "+aInfEmp[6]+Space(7)+"| "+aInfEmp[7]+" | |"+Space(24)+"|")
aAdd(aCabecalho, "+"+Repl("-",90)+"+"+Repl("-",47)+"+"+Repl("-",16)+"+"+Repl("-",28)+"+"+Repl("-",4)+"+ +"+Repl("-",24)+"+")

//"FPAS"###"Codigo terceiros"###"SIMPLES"###"Aliquota SAT"###"CNAE"###"Tomador de servico(CGC/CNPJ/CEI)"###"Tomador de servico (razao social)"###"Vara/JCJ"
aAdd(aCabecalho, "| "+STR0028+Space(5)+"| "+STR0029+Space(4)+"| "+STR0030+Space(5)+"| "+STR0031+Space(2)+"| "+STR0032+Space(2)+"| "+STR0033+Space(2)+"| "+STR0034+Space(48)+"| | "+STR0035+Space(15)+"|")
If nOrdem == 2 .Or. nOrdem == 4
	aAdd(aCabecalho, "| "+aInfEmp[9]+Space(6)+"| "+cTerceiros+Space(16)+"| "+cSimples+Space(11)+"| "+cAliqSat+Space(9)+"|"+aInfEmp[8]+"| "+aTomador[1]+Space(20)+"| "+aTomador[2]+Space(1) +"-"+ Space(1) +aTomador[3]+Space(44)+"| |"+Space(24)+"|")
Else
	aAdd(aCabecalho, "| "+aInfEmp[9]+Space(6)+"| "+cTerceiros+Space(16)+"| "+cSimples+Space(11)+"| "+cAliqSat+Space(9)+"|"+aInfEmp[8]+"| "+aTomador[1]+Space(20)+"| "+aTomador[2]+Space(1) + Space(1) +aTomador[3]+Space(45)+"| |"+Space(24)+"|")
EndIf
aAdd(aCabecalho, "+"+Repl("-",10)+"+"+Repl("-",21)+"+"+Repl("-",13)+"+"+Repl("-",15)+"+"+Repl("-",7)+"+"+Repl("-",35)+"+"+Repl("-",82)+"+ +"+Repl("-",24)+"+")

nEvento  := 0

Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³ FDetalhe ºAutor  ³Microsiga           º Data ³  04/26/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Monta linha com dados do funcionario                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FDetalhe(cCateg,cOcorr,cCodAfast,dDtAfast,aTotais,aInssEmp,nPercFPAS,cAliqSat,cTerceiros,aInfEmp,aTomador, aValFunc, cTipoAfast)
//          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//	 | XXXXXXXXXXX            |DD/MM/AAAA | XXXXXXX / XXXXX      | XX  |           999,999,999,999.99 |            999,999,999,999.99 | XX    | XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  | DD/MM/AAAA   | XX   | DD/MM/AAAA |
Local cDet := ''
Local nTotAux := 0

Set Device To Printer

dbSelectArea("SRA")
SRA->(dbSetOrder(1))

If SRA->RA_CATFUNC # "A" .Or. (SRA->RA_CATFUNC == "A" .AND. aValFunc[1]+aValFunc[2]+aValFunc[6] >= 0 )

	if !empty(cTipoAfast) .and. cTipoAfast == "A"
		nTotAux := Transform((aValFunc[1]),"@E 999,999,999,999.99")
	Elseif !empty(cTipoAfast) .and. cTipoAfast == "R"
		nTotAux := Transform((0),"@E 999,999,999,999.99")
	else
		nTotAux := Transform((aValFunc[1]),"@E 999,999,999,999.99")
	endif

	cDet := "| "+PadR( AllTrim(SRA->RA_PIS), 11 )+Space(12)+"|"+Transforma(SRA->RA_ADMISSA)+" | "
	cDet += PadR(SRA->RA_NUMCP + " / " + SRA->RA_SERCP, 21) + "| " + cCateg + "  |"
	cDet += Space(10)+ nTotAux +" |"+Space(12)
	cDet += Transform((aValFunc[2]),"@E 999,999,999,999.99")+" |"+Space(4)+cOcorr+" | "
	cDet += PadR(SRA->RA_NOME,40)+Space(4)+"| "+Transforma(dDtAfast)+Space(3)+"| "
	cDet += PadR(cCodAfast,2)+Space(3)+"| "+Transforma(SRA->RA_NASC)+ " | "

	aAdd(aDetalhe, cDet)

	nLinha++

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acumula totais                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	AcumTot(@aTotais, aValFunc, cOcorr, cCateg)
Endif

LimpaTot(@aValFunc)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Salto de pagina                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLinha > 37
	fTotFol(@aTotais, aInssEmp, nPercFPAS, .F., aValFunc)
	fCabecalho(.F.,aInssEmp,nPercFPAS,cAliqSat,cTerceiros,aInfEmp,aTomador)
Endif

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³ fTotFol  ºAutor  ³Microsiga           º Data ³  04/26/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Imprime a pagina com todos os dados da folha               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fTotFol(aTotais, aInssEmp, nPercFPAS, lNew, aValFunc)
//          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//  +------------------------+-----------+----------------------+-----+------------------------------+-------------------------------+-------+--------------------------------------------+--------------+------+------------+
//                                                                    | Somatorio                    | Somatorio                     | Soma  | | Rem + 13o.(Cat.1,2,3 e 5 | Rem + 13o.(Cat. 4) | | Total a recolher FGTS     |
//                                                                    |           999,999,999,999.99 |            999,999,999,999.99 | 99999 | |       999,999,999,999.99 | 999,999,999,999.99 | |        999,999,999,999.99 |
//                                                                    +------------------------------+---------------------------------------+ +--------------------------+--------------------+ +---------------------------+
//
//                                                                                                                                                     | Autenticacao
//                   -------------------------------------------------          ---------------------------------------------------------------------  |
//                   Local e data                                               Assinatura                                                             |

Local nContrib 	:= 0
Local i 		:= 0
Local nINSS		:= 0.00
Local nValINSS	:= 0.00

Li  := 0
@ 00,00 PSAY AvalImp(Colunas)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For i := 1 To Len(aCabecalho)
	Li++
	@ Li,02 PSAY aCabecalho[i]
Next i
aCabecalho := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Soma valores INSS para impressao no cabecalho                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTotais[10] := If (aTotais[10] == NIL,0.00,aTotais[10])
If aTotais[7] >= 0 .And. lNew
	nINSS += ROUND(aTotais[7] * aInssEmp[1][1],2) // Inss Emp.
	nINSS += ROUND(aTotais[7] * If (nPercFPAS > 0, nPercFPAS , aInssEmp[2][1]),2)   // Terceiros
	nINSS += aTotais[10]
	nValINSS += (nINSS + aTotais[8]) - aTotais[9]
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime INSS no cabecalho                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Li++
@ Li,02 PSAY "| "+STR0036+" | "+STR0037+" | "+STR0038+" | "+STR0039+" | "+STR0040+" | "+STR0041+" | "+STR0042+Space(16)+"| |"+STR0043+Space(8)+"|"

Li++
@ Li,02 PSAY "|"+Space(8)+If(lNew,Transform((nValINSS),"@E 999,999,999,999.99"),Space(18))+" |"+Space(7)+If(lNew,Transform((aTotais[8]),"@E 999,999,999,999.99"),Space(18))+" |"+Space(4)+If(lNew,Transform((aTotais[11]),"@E 999,999,999,999.99"),Space(18))+" |"+Space(26)+"|"+Space(11)+If(lNew,Transform((nEvento),"@E 999,999,999,999.99"),Space(18))+" |"+Space(25)+"| "+Space(6)+If(lNew,Transform((nValINSS+aTotais[8]+aTotais[11]+nEvento),"@E 999,999,999,999.99"),Space(18))+" | |"+Space(24)+"|"

Li++
@ Li,02 PSAY "+"+Repl("-",27)+"+"+Repl("-",26)+"+"+Repl("-",23)+"+"+Repl("-",26)+"+"+Repl("-",30)+"+"+Repl("-",25)+"+"+Repl("-",26)+"+ +"+Repl("-",24)+"+"

Li++
//"No.PIS-PASEP/Inscricao"###"Adimissao"###"Carteira de trabalho"###"Cat"###"Remuneracao"###"Remuneracao 13o.salario"###"Ocor."###"Nome do trabalhador"###"Movimentacao"###"Nascimento"
@ Li,02 PSAY "| "+STR0044+" | "+STR0045+" | "+STR0046+" | "+STR0047+" | "+STR0048+Space(17)+"| "+STR0049+Space(6)+" | "+STR0050+" | "+STR0051+Space(24)+" | "+STR0052+" |"+Space(6)+"| "+STR0053+" |"


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime nome dos campos de funcionario                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Li++
//"do contrib. individual"###"(data)"###"(No./serie)"###"(sem parcela do 13o.salario)"###"(somente parcela do 13o.sal.)"###"(data)"###"Cod."###"(data)"
@ Li,02 PSAY "| "+STR0054+" | "+STR0055+Space(4)+"| "+STR0056+Space(10)+"|"+Space(5)+"| "+STR0057+"| "+STR0058+" |"+Space(7)+"| "+Space(44)+"| "+STR0059+Space(7)+"| "+STR0060+" | "+STR0061+Space(5)+"|"

Li++
@ Li,02 PSAY "|"+Space(24)+"|"+Space(11)+"|"+Space(22)+"|"+Space(5)+"|"+Space(29)+"|"+Space(31)+"|"+Space(7)+"|"+Space(45)+"|"+Space(14)+"|"+Space(6)+"|"+Space(12)+"|"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime dados do funcionario                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For i := 1 To Len(aDetalhe)
	Li++
	@ Li,02 PSAY aDetalhe[i]
Next i
aDetalhe := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Completa pagina caso numero de funcionarios seja inferior a 38³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Li < 38
	For i = Li To 38
		Det := "|"+Space(24)+"|"+Space(11)+"|"+Space(22)+"|"+Space(5)
		Det += "|"+Space(29)+"|"+Space(31)+"|"+Space(7)+"|"+Space(45)
		Det += "|"+Space(14)+"|"+Space(6)+"|"+Space(12)+"|"
		@ i,02 PSAY Det
	Next i
	Li := i-1 //Sai no 39
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime dados do rodape                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nTipo == 1 .And. aTotais[6] == 0 // Total a Recolher FGTS  no prazo
	If 	!Empty(aCodFol[298,1]) .and. !Empty( aCodFol[299,1] )
		nContrib 	:= (aTotais[4]+aTotais[5])*0.005
	EndIf
	aTotais[6] 	:= Round((aTotais[4]*0.08)+(aTotais[5]*0.02),2)+nContrib
ElseIf nTipo == 2 .And. cPeriRel > "09/1989" //Total a recolher em atraso
	aTotais[6] := If(nJam#0.00,Round((aTotais[4]*(nJam/100))+If(aTotais[5]#0.00,(aTotais[5]*(nJam/100))/4,0.00),2),0.00)
EndIf
Li++
Det := "+"+Repl("-",24)+"+"+Repl("-",11)+"+"+Repl("-",22)+"+"+Repl("-",5)
Det += "+"+Repl("-",29)+"+"+Repl("-",31)+"+"+Repl("-",7)+"+"+Repl("-",45)
Det += "+"+Repl("-",14)+"+"+Repl("-",6)+"+"+Repl("-",12)+"+"
@Li,02 PSAY Det

Li++
Det := Space(66)+"| "+STR0062+Space(19)+"| "+STR0062+Space(21)+"| " //"Somatorio"
Det += STR0063+"  | | "+STR0064+"| "+STR0065 //"Soma"###"Rem + 13o.(Cat.1,2,3 e 5)"###"Rem + 13o.(Cat. 4)"
Det += "  | | "+STR0066+Space(5)+"|" //"Total a recolher FGTS"
@Li,02 PSAY Det

Li++
Det := Space(66)+"|"+Space(10)+Transform((aTotais[1]),"@E 999,999,999,999.99")+" |"
Det += Space(12)+Transform((aTotais[2]),"@E 999,999,999,999.99")+" | "
Det += Space(2)+Transform((aTotais[3]),"@E 999")+" | |"+Space(7)+Transform((aTotais[4]),"@E 999,999,999,999.99")
Det += " |  "+Transform((aTotais[5]),"@E 999,999,999,999.99")+" | |"+Space(8)
Det += Transform((aTotais[6]),"@E 999,999,999,999.99")+" |"
@Li,02 PSAY Det

Li++
Det := Space(66)+"+"+Repl("-",29)+"+"+Repl("-",31)+"+"+Repl("-",7)+"+ +"+Repl("-",26)+"+"+Repl("-",21)+"+ +"+Repl("-",27)+"+"
@Li,02 PSAY Det

Li ++
Det := Space(149)+"| "+STR0067 //"Autenticacao"
@Li,02 PSAY Det

Li ++
Det := Space(149)+"|"
@Li,02 PSAY Det

Li ++
Det := Space(19)+Repl("-",49)+Space(10)+Repl("-",69)+"  |"
@Li,02 PSAY Det

Li ++
Det := Space(19)+STR0068+Space(47)+STR0069+Space(61)+"|" //"Local e data"###"Assinatura"
@Li,02 PSAY Det

Li 		:= 0
nLinha 	:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Limpa totais                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lNew
	LimpaTot(@aTotais)
Else
	For i := 1 To 6
		aTotais[i] := 0
	Next i
EndIf

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³fCalcAci  ºAutor  ³Microsiga           º Data ³  04/26/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Calculo do percentual de acidente de trabalho               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fCalcAci(aInssEmp, aValFunc, cFil, cCCto)
Local aAreaSI3 := SI3->(GetArea())
Local nValAci  := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calculo do % Acid. de Trabalho Por Funcionario / C.Custo ou Filial ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nPercAci := aInssEmp[3][1]  //Ac.Trab.
If Type("SRA->RA_PERCSAT") # "U" .And. SRA->RA_PERCSAT > 0
	nPercAci := SRA->RA_PERCSAT / 100
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o % de Acidente do C.Custo ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SI3")
	If ( cFil # Nil .And. cFilial == Space(FWGETTAMFILIAL) ) .Or. cFil == Nil
		cFil := cFilial
	Endif
	If dbSeek( cFil + cCCto ) .And. SI3->I3_PercAci > 0
		nPercAci := SI3->I3_PercAci / 100
	Endif
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montar a Base Total de Inss         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nValAci := Round(aValFunc[1] * nPercAci,2)
RestArea(aAreaSI3)
Return(nValAci)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³LimpaTot  ºAutor  ³Microsiga           º Data ³  12/31/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Limpa array de valores                                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function LimpaTot(aArrSel)
Local nZera := 0
For nZera := 1 To Len(aArrSel)
	aArrSel[nZera] := 0.00
Next nZera
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³MntFunPer ºAutor  ³Microsiga           º Data ³  12/31/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Monta tabela com dados do funcionario que sera usado        º±±
±±º          ³no processamento                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function MntFunPer(cAliasQry, nRec)
Local lRetorno  := .F.
Local cQuery 	:= ''
Local cOrdem    := ''

cQuery := " SELECT 	"+CRLF
cQuery += "		RA_PROCES,  "+CRLF
cQuery += "		RA_FILIAL,  "+CRLF
cQuery += " 	RA_CC,  "+CRLF
cQuery += " 	RA_MAT  "+CRLF
cQuery += " FROM  	"+CRLF
cQuery += " 	"+RetSqlName('SRA')+"   "+CRLF
cQuery += " WHERE  "+CRLF
cQuery += " 	"+RetSqlName('SRA')+".D_E_L_E_T_ 	= ' '  "+CRLF
cQuery += " 	AND RA_FILIAL 	BETWEEN '"+cFilDe+"' AND '"+cFilAte+"' "+CRLF
cQuery += " 	AND RA_CC 		BETWEEN '"+cCcDe+ "' AND '"+cCcAte+ "' "+CRLF
cQuery += " 	AND RA_MAT 		BETWEEN '"+cMatDe+"' AND '"+cMatAte+"' "+CRLF
cQuery += " 	AND RA_NOME 	BETWEEN '"+cNomDe+"' AND '"+cNomAte+"' "+CRLF

If nOrdem == 1
	cOrdem  := " RA_FILIAL, RA_MAT "
ElseIf nOrdem == 2
	cOrdem   := " RA_FILIAL, RA_CC, RA_MAT"
ElseIf nOrdem == 3
	cOrdem   := " RA_FILIAL, RA_NOME, RA_MAT "
ElseIf nOrdem == 4
	cOrdem   := " RA_FILIAL, RA_CC, RA_NOME "
Endif

cQuery += "ORDER BY "+cOrdem

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)
Count to nRec

cFilAnterior := Replicate("!", FWGETTAMFILIAL)
cCcAnt       := Replicate("!", GetSx3Cache("RA_CC", "X3_TAMANHO"))

If nRec > 0
	lRetorno := .T.
EndIf

Return(lRetorno)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³MntArrPer ºAutor  ³Microsiga           º Data ³  12/31/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Carrega em array os periodos que serao usados no proces-    º±±
±±º          ³samento                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function MntArrPer(aGrpAberto, aGrpFechado)
Local lRetorno	  := .F.
Local cAliasGrp   := GetNextAlias()
Local aPerAberto  := {}
Local aPerFechado := {}
Local aAuxAberto  := {}
Local aAuxFechado := {}
Local nPer		  := 0
Local aAreaRCH

If MntGrpPer(cAliasGrp)
	(cAliasGrp)->(dbGoTop())
	While (cAliasGrp)->(!Eof())
		dbSelectArea('RCH')
		RCH->(dbSetOrder(1))
		If RCH->(dbSeek(xFilial('RCH',(cAliasGrp)->RA_FILIAL)+(cAliasGrp)->RA_PROCES+cPeriodo))
			aPerAberto 	:= {}
			aPerFechado	:= {}
			While RCH->(!Eof()) .And. RCH->(RCH_FILIAL+RCH_PROCES+RCH_PER) == xFilial('RCH',(cAliasGrp)->RA_FILIAL)+(cAliasGrp)->RA_PROCES+cPeriodo
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Carregar os periodos abertos (aPerAberto) e/ou os periodos   ³
				//³ fechados (aPerFechado), dependendo do periodo (ou intervalo  ³
				//³ de periodos) selecionado									 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				aAuxAberto  := {}
				aAuxFechado	:= {}

				aAreaRCH    := RCH->( GetArea() )

				RetPerAbertFech(RCH->RCH_PROCES	,; // Processo selecionado na Pergunte.
								RCH->RCH_ROTEIR	,; // Roteiro selecionado na Pergunte.
								RCH->RCH_PER	,; // Periodo selecionado na Pergunte.
								RCH->RCH_NUMPAG	,; // Numero de Pagamento selecionado na Pergunte.
								NIL				,; // Periodo Ate - Passar "NIL", pois neste relatorio eh escolhido apenas um periodo.
								NIL				,; // Numero de Pagamento Ate - Passar "NIL", pois neste relatorio eh escolhido apenas um numero de pagamento.
								@aAuxAberto		,; // Retorna array com os Periodos e NrPagtos Abertos
								@aAuxFechado    ,; // Retorna array com os Periodos e NrPagtos Fechados
								                ,;
								RCH->RCH_FILIAL ,; // Filial para filtrar quando o período for exclusivo
								RCH->RCH_FILIAL	)  // Filial para filtrar quando o período for exclusivo

				RestArea(aAreaRCH)

				For nPer := 1 To Len(aAuxAberto)
					aAdd(aPerAberto , aAuxAberto[nPer] )
				Next
				For nPer := 1 To Len(aAuxFechado)
					aAdd(aPerFechado, aAuxFechado[nPer])
				Next

				RCH->(dbSkip())
			End
			aAdd(aGrpAberto , {(cAliasGrp)->RA_PROCES , aPerAberto })
			aAdd(aGrpFechado, {(cAliasGrp)->RA_PROCES , aPerFechado})
		EndIf
		(cAliasGrp)->(dbSkip())
	End
	(cAliasGrp)->(dbCloseArea())
EndIf

If Len(aGrpAberto) > 0 .Or. Len(aGrpFechado) > 0
	lRetorno := .T.
EndIf

Return(lRetorno)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³MntGrpPer ºAutor  ³Microsiga           º Data ³  12/31/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Monta tabela agrupando por processo dos funcionarios        º±±
±±º          ³para poder carregar somente os periodos necessarios         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function MntGrpPer(cAliasQry)
Local lRetorno  := .F.
Local cQuery 	:= ''

cQuery := " SELECT 	"+CRLF
cQuery += "		RA_FILIAL,RA_PROCES  "+CRLF
cQuery += " FROM  	"+CRLF
cQuery += " 	"+RetSqlName('SRA')+"   "+CRLF
cQuery += " WHERE  "+CRLF
cQuery += " 	"+RetSqlName('SRA')+".D_E_L_E_T_ 	= ' '  "+CRLF
cQuery += " 	AND RA_FILIAL 	BETWEEN '"+cFilDe+"' AND '"+cFilAte+"' "+CRLF
cQuery += " 	AND RA_CC 		BETWEEN '"+cCcDe+ "' AND '"+cCcAte+ "' "+CRLF
cQuery += " 	AND RA_MAT 		BETWEEN '"+cMatDe+"' AND '"+cMatAte+"' "+CRLF
cQuery += " 	AND RA_NOME 	BETWEEN '"+cNomDe+"' AND '"+cNomAte+"' "+CRLF
cQuery += " GROUP BY RA_FILIAL,RA_PROCES "

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)

(cAliasQry)->(dbGoTop())
If (cAliasQry)->(!Eof())
	lRetorno := .T.
EndIf

Return(lRetorno)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³RetVerPro ºAutor  ³Microsiga           º Data ³  12/31/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Carrega verbas que serao usadas no processamento, asssim    º±±
±±º          ³evita processamento desnecessario                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function RetVerPro(aVerbas)
Local nVerba := 0

If FP_CODFOL(@aCodFol)
	aAdd(aVerbas, {aCodFol[013][1]}) //Base Salario Contribuicao Ate o Limite
	aAdd(aVerbas, {aCodFol[014][1]}) //Base Salario Contribuicao Acima do Limite
	aAdd(aVerbas, {aCodFol[017][1]}) //Base do F.G.T.S.
	aAdd(aVerbas, {aCodFol[018][1]}) //Codigo do F.G.T.S. Depositado
	aAdd(aVerbas, {aCodFol[019][1]}) //Salario Contribuicao Ate o Limite ( 13o.Salario )
	aAdd(aVerbas, {aCodFol[020][1]}) //Salario Contribuicao Acima do Limite ( 13o.Salario )
	aAdd(aVerbas, {aCodFol[034][1]}) //Salario Familia
	aAdd(aVerbas, {aCodFol[064][1]}) //Desconto de I.N.S.S.
	aAdd(aVerbas, {aCodFol[065][1]}) //Desconto I.N.S.S. Ferias
	aAdd(aVerbas, {aCodFol[070][1]}) //Desconto do I.N.S.S. sobre 13§ Salario
	aAdd(aVerbas, {aCodFol[108][1]}) //Base FGTS 13o.Salario
	aAdd(aVerbas, {aCodFol[109][1]}) //Valor FGTS 13o.Salario
	aAdd(aVerbas, {aCodFol[114][1]}) //'13§ na Indenizacao Rescisao
	aAdd(aVerbas, {aCodFol[115][1]}) //13§ Sobre Aviso Previo
	aAdd(aVerbas, {aCodFol[251][1]}) //Media 13o. Salario Rescisao
	aAdd(aVerbas, {aCodFol[253][1]}) //Media 13o. Salario Sobre Aviso Indenizado Rescisao
	aAdd(aVerbas, {aCodFol[298][1]}) //Contrib. 0.5% s/Rem. Folha
	aAdd(aVerbas, {aCodFol[299][1]}) //Contrib. 0.5% s/Rem. 13o. Folha
	aAdd(aVerbas, {aCodFol[670][1]}) //Deducao Sal rio Maternidade de 13o sal rio na GPS
	aAdd(aVerbas, {aCodFol[024][1]}) //Parcela Final do 13o.Salario
	aAdd(aVerbas, {aCodFol[123][1]}) //Media Toal 13o. em Valor
	aAdd(aVerbas, {aCodFol[124][1]}) //Media Total 13o. em Horas

	For nVerba := 1 To Len(aCodFol)
		If PosSrv(aCodFol[nVerba][1], xFilial('SRV'), "RV_DEDINSS") == "S"
			If aScan(aVerbas , {|x| x[1] == aCodFol[nVerba][1] }) == 0
				aAdd(aVerbas, {aCodFol[nVerba][1]})
			EndIf
		EndIf
		If PosSrv(aCodFol[nVerba][1], xFilial('SRV'), "RV_TIPOCOD") == "1" .And. ;
		   PosSrv(aCodFol[nVerba][1], xFilial('SRV'), "RV_INSS")    == "S"
			If aScan(aVerbas , {|x| x[1] == aCodFol[nVerba][1] }) == 0
				aAdd(aVerbas, {aCodFol[nVerba][1]})
			EndIf
		EndIf
	Next nVerba
Endif

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³EncerraImpºAutor  ³Microsiga           º Data ³  12/31/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Finaliza a impressao do relatorio                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function EncerraImp()
If aReturn[5] = 1
	Set Printer To
	Commit
	ourspool(wnrel)
EndIf

MS_FLUSH()
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³ExisteTot ºAutor  ³Microsiga           º Data ³  12/31/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica se existe valor totalizado                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ExisteTot(aTotais)
Local lRetorno := .F.
Local nTot := 0

For  nTot := 1 To Len(aTotais)
	If aTotais[nTot] >= 0
		lRetorno := .T.
		Exit
	EndIf
Next nTot

Return(lRetorno)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³CalcVerba ºAutor  ³Microsiga           º Data ³  12/31/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Carrega valores das verbas do funcionario para o array      º±±
±±º          ³aValFunc para impressao                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function CalcVerba(aVerbasFunc, aValFunc)
Local nVerba := 0

For nVerba := 1 To Len(aVerbasFunc)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Base I.N.S.S.                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If aVerbasFunc[nVerba][03] == aCodFol[13,1] .Or.; //Base Salario Contribuicao Ate o Limite
	   aVerbasFunc[nVerba][03] == aCodFol[14,1] .Or.; //Base Salario Contribuicao Acima do Limite
	   aVerbasFunc[nVerba][03] == aCodFol[19,1] .Or.; //Salario Contribuicao Ate o Limite ( 13o.Salario )
	   aVerbasFunc[nVerba][03] == aCodFol[20,1]		  //Salario Contribuicao Acima do Limite ( 13o.Salario )

		aValFunc[3]  += Round(aVerbasFunc[nVerba][07],2)
		aValFunc[8]  += Round(aVerbasFunc[nVerba][07],2)
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Desconto de I.N.S.S.                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If aVerbasFunc[nVerba][03] == aCodFol[64,1] .Or.; //Desconto de I.N.S.S.
	   aVerbasFunc[nVerba][03] == aCodFol[65,1] .Or.; //Desconto I.N.S.S. Ferias
	   aVerbasFunc[nVerba][03] == aCodFol[70,1]		  //Desconto do I.N.S.S. sobre 13§ Salario
		aValFunc[4] += Round(aVerbasFunc[nVerba][07],2)
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Base do F.G.T.S.                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If aVerbasFunc[nVerba][03] == aCodFol[17,1] //Base do F.G.T.S.
		aValFunc[1] += Round(aVerbasFunc[nVerba][07],2) //Remuneracao(sem parcela do 13o. salario)
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Base FGTS 13o.Salario                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If aVerbasFunc[nVerba][03] == aCodFol[108,1] //Base FGTS 13o.Salario
		aValFunc[2] += Round(aVerbasFunc[nVerba][07],2)
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valor FGTS                                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If aVerbasFunc[nVerba][03] == aCodFol[018,1] .Or.; //Codigo do F.G.T.S. Depositado
	   aVerbasFunc[nVerba][03] == aCodFol[109,1] .or.; //Valor FGTS 13o.Salario
	   aVerbasFunc[nVerba][03] == aCodFol[298,1] .or.; //Contrib. 0.5% s/Rem. Folha
	   aVerbasFunc[nVerba][03] == aCodFol[299,1]	   //Contrib. 0.5% s/Rem. 13o. Folha
		aValFunc[6] += Round(aVerbasFunc[nVerba][07],2)
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Salario Familia                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If aVerbasFunc[nVerba][03] == aCodFol[34,1] //Salario Familia
		aValFunc[7] += Round(aVerbasFunc[nVerba][07],2)
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se a verba entra nas Deducoes FPAS                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If PosSrv(aVerbasFunc[nVerba][03], aVerbasFunc[nVerba][01], "RV_DEDINSS") == "S"
		aValFunc[5] += Round(aVerbasFunc[nVerba][07],2)
	Endif
Next nVerba

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³ImpDetalheºAutor  ³Microsiga           º Data ³  12/31/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Carrega dados do funcionarios para impressao                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ImpDetalhe(dDtAfast, aTotais, aInssEmp, nPercFPAS, aInfEmp, aValFunc, aTomador)
Local cCateg     := FCateg(aValFunc[6]) //Funcao que define a categoria do empregados
Local nAfast     := 0
Local nAliqSat   := 0
Local cOcorr 	 := ''
Local cTerceiros := ''
Local cAliqSat   := ''

Local cTipoAfast := ""


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Optou pelo SIMPLES                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cSimples == "2" .Or. aInfEmp[9] $ "582/639/655"
	cTerceiros := Space(4)
EndIf

If aInfEmp[9] $ "604/639/647" .Or. cSimples == "2"
	nAliqSat := 0
Else
	nAliqSat := aInssEmp[3][1] * 100
EndIf

If nAliqSat == 1
	cAliqSat := "1,0 %"
ElseIf nAliqSat == 2
	cAliqSat := "2,0 %"
ElseIf nAliqSat == 3
	cAliqSat := "3,0 %"
Else
	cAliqSat := "0,0 %"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica Ocorrencia do Funcionario                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Type("SRA->RA_OCORREN") # "U"
	cOcorr := SRA->RA_OCORREN
Else
	cOcorr := Space(02)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega array de afastamento                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cAuxCompet:= Right(Str(Year(dDtRef)),4) + Substr(DtoC(dDtRef),4,2)
aAfast   := {}
dDtAfast := CTOD("")
cCodAfast:= ""

FMontaSR8(cAuxCompet,@aAfast,,dDtRef,cCateg)
If Len(aAfast) # 0
	For nAfast := 1 To Len(aAfast)
		dDtAfast  := aAfast[nAfast][1]
		cCodAfast := aAfast[nAfast][2]
		cTipoAfast:= aAfast[nAfast][3]
		If cTipoAfast == "D" .AND. dDtAfast > LastDay(dDtRef)
			Loop
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime detalhe (infomacoes de funcionario)                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fDetalhe(cCateg,cOcorr,cCodAfast,dDtAfast,@aTotais,aInssEmp,nPercFPAS,cAliqSat,cTerceiros,aInfEmp, aTomador, aValFunc, cTipoAfast)
	Next nAfast
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime detalhe (infomacoes de funcionario)                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	fDetalhe(cCateg,cOcorr,cCodAfast,dDtAfast,@aTotais,aInssEmp,nPercFPAS,cAliqSat,cTerceiros,aInfEmp,aTomador, aValFunc, cTipoAfast)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Limpa valores de funcionario                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LimpaTot(@aValFunc)

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³ AcumTot  ºAutor  ³Microsiga           º Data ³  12/31/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Acumala totais para impressao do cabecalho e rodape        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function AcumTot(aTotais, aValFunc, cOcorr, cCateg)
	aTotais[01] += aValFunc[1] //Remuneracao(sem parcela do 13o. salario)
	aTotais[02] += aValFunc[2] //Remuneracao 13o. salario(somente parcela do 13o.sal.)
	aTotais[03] += Val(cOcorr) //Soma das ocorrencias
	If cCateg $ "01/02/03/05"
		aTotais[04] += aValFunc[1] + aValFunc[2] //Rem + 13o.(Cat.1,2,3 e 5)
	ElseIf cCateg $ "04"
		aTotais[05] += aValFunc[1] + aValFunc[2] //Rem + 13o.(Cat 4)
	EndIF
	aTotais[06] += aValFunc[6]
	aTotais[07] += aValFunc[3]
	aTotais[08] += aValFunc[4]
	aTotais[09] += aValFunc[5]
	aTotais[10] += aValFunc[9]
	aTotais[11] += aValFunc[7]
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³ AcumTot  ºAutor  ³Microsiga           º Data ³  12/31/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Carrega dados de tomador para o array aTomador              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function CarTomador(aTomador, nPercFPAS, aInssEmp)

cCcAnt      := SRA->RA_CC
aTomador[1] := Space(14)	// CGC/CNPJ/CEI(Tomador de servi‡o)
aTomador[2] := Space(9)		// Centro de Custo(Tomador de servi‡o)
aTomador[3] := Space(25)	// Descricao C.Custo(Tomador de servi‡o)

dbSelectArea("CTT")
dbSetOrder(1)
nPercFPAS:=0
If dbSeek(If (cFilial == Space(FWGETTAMFILIAL), Space(FWGETTAMFILIAL), SRA->RA_FILIAL)+SRA->RA_CC)
	If TYPE("CTT->CTT_CEI") # "U" .And. !Empty(CTT->CTT_CEI)
		aTomador[1] := PadR(CTT->CTT_CEI,14)
		If TYPE("CTT->CTT_CUSTO") # "U"
			aTomador[2] := PadR(CTT->CTT_CUSTO,09)
		EndIf
		If TYPE("CTT->CTT_DESC01") # "U"
			aTomador[3] := PadR(CTT->CTT_DESC01,25)
		EndIf
	Endif
	aInssEmp[21][1] := CTT->CTT_PERCAC / 100
	nPercFPAS       := CTT->CTT_PERFPA / 100
Endif

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³ AcumTot  ºAutor  ³Microsiga           º Data ³  12/31/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Carrega dados da empresa para o array aInfEmp               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function CarEmp(cCentra, aInfo, aInssEmp, aInfEmp)

If !Empty(cCentra)
	If !fInfo(@aInfo,cCentra) .Or. !fInssEmp(cCentra,@aInssEmp,.T.,MesAno(dDtRef))
		Return(.F.)
	EndIf
	cFilAnterior := cCentra
Else
	If !fInfo(@aInfo,SRA->RA_FILIAL) .Or. !fInssEmp(SRA->RA_FILIAL,@aInssEmp,.T.,MesAno(dDtRef))
		Return(.F.)
	EndIf
	cFilAnterior := SRA->RA_FILIAL
Endif

cTerceiros := aInssEmp[25,1]

aInfEmp[1] := PadR(aInfo[03],40)  // 1- Razao Social
aInfEmp[2] := PadR(If( Len(aInfo) >= 27 .And. !Empty( aInfo[27] ), aInfo[27], aInfo[8] ),14)  // 2- CGC/CNPJ/CEI
aInfEmp[3] := PadR(aInfo[04],30)  // 3- Endereco
aInfEmp[4] := PadR(aInfo[13],35)  // 4- Bairro
aInfEmp[5] := PadR(aInfo[07],08)  // 5- CEP
aInfEmp[6] := PadR(aInfo[05],20)  // 6- Cidade
aInfEmp[7] := PadR(aInfo[06],02)  // 7- UF
aInfEmp[8] := PadR(aInfo[16],07)  // 8- N§ CNAE

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verificando o Tamanho do FPAS                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Substr(aInfo[17],1,1) == "0" //9- FPAS
	aInfEmp[9] := Substr(aInfo[17],2,3)
Else
	aInfEmp[9] := Substr(aInfo[17],1,3)
EndIf
Return(.T.)

/*/{Protheus.doc} fGetDtRes
Retorna Data de Homologação da última rescisão do funcionário
@author raquel.andrade
@since 18/08/2022
@version 1.0
/*/
Static Function fGetDtRes(cFilMat,cMat)
Local aArea		:= GetArea()
Local cAliasQry	:= GetNextAlias()
Local cFromTable := "% " + RetSqlName("SRG") + " SRG %"
Local cWhere	:= ""
Local dtResMat	:= CtoD("//")

DEFAULT cFilMat := ""
DEFAULT cMat	:= ""

cWhere := "%"
cWhere += " SRG.RG_FILIAL = '" + cFilMat + "' AND "
cWhere += " SRG.RG_MAT  = '" + cMat + "' AND "
cWhere += "%"

BeginSql alias cAliasQry
	SELECT SRG.RG_FILIAL, SRG.RG_MAT, SRG.RG_DATAHOM
	FROM
			%exp:cFromTable%
	WHERE
		 	%exp:cWhere%
			SRG.%NotDel%
			ORDER BY SRG.RG_FILIAL, SRG.RG_MAT,SRG.RG_DATAHOM DESC
		 	
EndSql

If (cAliasQry)->( !Eof() )
	dtResMat	:= StoD((cAliasQry)->RG_DATAHOM)
EndIf

(cAliasQry)->(dbCloseArea())

RestArea(aArea)
	
Return dtResMat
