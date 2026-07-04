/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.ch"
#INCLUDE "GPER140.CH"

Static lCpoRGEfe	:= SRG->(ColumnPos("RG_EFETIVA")) > 0

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GPER140  ³Autor Mauro                              | Data ³30/05/95  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao de Rescisao                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER140(void)                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico                                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³Data	³    Chamado/Req ³ Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Mohanad Odeh|07/02/14|M12RH01         |UnIficacao da Folha V12                   ³±±
±±³            |        |197401          |                                          ³±±
±±³M. Silveira |06/08/14|TQFEHF          |Ajuste na composicao dos avos de ferias e ³±±
±±³            |        |                |para nao imprimir incorreto no TRCT.      ³±±
±±³Henrique V. |03/03/15|TRBBVQ          |Ajuste para imprimir corretamente Causa do³±±
±±³            |        |                |Afast. no TRCT. Réplica do Chamado TQVMH7 ³±±
±±³Allyson M.  |02/12/15|TTRFSO			 |Ajuste em U_GPER140Sum() p/ verificar campo ³±±
±±³            |        |      			 |de aglutinacao quando busca por valor e   ³±±
±±³            |        |      			 |codigo de verba.   						³±±
±±³Raquel Hager|28/06/16|TUZYQK          |Ajuste p/ validar preferencia de impressao³±±
±±³            |        |                |e setar uma impressora padrao caso nao    ³±±
±±³            |        |                |tenha p/ evitar erro no binario			³±±
±±³Gabriel A.  |19/07/16|TVPWW3          |Ajuste para imprimir corretamente os      ³±±
±±³            |        |                |valores de horas extras a partir da 2ª via³±±
±±³            |        |                |e não duplicar verbas.                    ³±±
±±³Claudinei S.|22/07/16|TVQQXK          |Ajustada U_gp140GrpVerb() foi incluído o 4º ³±±
±±³            |        |                |parametro que define se as verbas gravadas³±±
±±³            |        |                |na cVerbas_Aux terão ou não "/" entre os  ³±±
±±³            |        |                |códigos das verbas (lSomentePD).          ³±±
±±³Allyson M.  |26/10/16|TWHDNC			 |Ajuste p/ reiniciar as variavéis de verbas³±±
±±³            |        |      			 |a cada rescisão e p/ só demonstrar a insu-³±±
±±³            |        |      			 |ficiência no campo 99 do TRCT.			³±±
±±|Raquel Hager|17/11/16|TWEYLV          |Inclusão do pergunte MV_PAR39 para separa ³±±
±±|            |        |                |ção das verbas de Médias.                 ³±±
±±|Raquel Hager|20/12/16|TWEYLV          |Remoção dos ajustes do ch.TWEYLV para in- ³±±
±±|            |        |                |clusão na branch correta.                 ³±±
±±|Gustavo M.  |21/12/16|MRH-897    	 |Ajuste na impressao de varias vias. (dupl)³±±
±±³Oswaldo L.  |01/02/17|MRH-5781        |Trativa para que o sistema apenas utilize ³±±
±±³            |        |                |os campos de acordo com o pais conectado  ³±±
±±|Paulo       |10/02/17|MRH-208		 |Inclusão do campo SRR->RR_TIPO1 no array  ³±±
±±|Inzonha     |        |                |aHomV para ser apresentado no relatório   ³±±
±±|            |        |                |de rescisão o tipo e o valor da verba 95  ³±±
±±|Paulo       |31/07/17|DRHPAG-3771     |Ajuste para reconhecer o periodo          ³±±
±±|Inzonha     |        |                |aquisitivo de verbas com id de calculo    ³±±
±±|            |        |                |0086 lançadas manualmente.                ³±±
±±³Alf. Medrano|01/08/17|DMINA-66        |Replica de MMI-5527 Rep. Dominicana       ³±±
±±³            |        |                |En fun Gper140 se asigna grupo preguntas  ³±±
±±³            |        |                |GPER140, también se excluyen preguntas que³±±
±±³            |        |                |no serán utilizadas, en func GP140IMP se  ³±±
±±³            |        |                |asigna el calculo de Rescisión            ³±±
±±³WinstonCosta|        |                |Automação para funcionar com o ROBÔ       ³±±
±±³Alf. Medrano|05/04/20|DMINA-8744      |En fun ImpFun se realiza dbseek tabla SRG ³±±
±±³            |        |                |utilizando la filial del empleado RA_MAT  ³±±
±±³            |        |                |dentro while consulta a tabla SRC se agreg³±±
±±³            |        |                |loop cuando RC_VALOR = 0 MEX              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static __SRVKey  //-- Chave para carga das verbas com incidencia de DSR

User Function GPER140

	Local cString		:="SRA"						// Alias do arquivo principal (Base)
	Local aOrd			:= {STR0001, STR0002}		//" Matricula "###" Centro de Custo "
	Local aRegs			:= {}
	Local nTotregs, nMult, nPosAnt, nPosAtu, nPosCnt, cSav20, cSav7 //Regua
	Local cDesc1		:= STR0003					//"Termo de Recis„o do Contrato "
	Local cDesc2		:= STR0004					//"Ser  impresso de acordo com os parametros solicitados pelo"
	Local cDesc3		:= STR0005					//"usuario."
	Local cSavAlias, nSavRec, nSavOrdem
	Local aVPensao		:= {}
	Local cPensao		:=""
	Local cSession		:= GetPrinterSession()
	Local cDestino		:= fwGetProfString(cSession, "DEFAULT", "C:\", .T.)
	Local lCentury		:= __SetCentury()
	Local aOfusca		:= If(FindFunction('ChkOfusca'), ChkOfusca(), { .T., .F., {"",""} }) //[1]Acesso; [2]Ofusca; [3]Mensagem
	Local aFldRel		:= {"RA_NOMECMP", "RA_NOME", "RA_ENDEREC", "RA_BAIRRO", "RA_MUNICIP", "RA_ESTADO", "RA_CEP", "RA_NUMCP", "RA_SERCP", "RA_CIC", "RA_MAE", "RA_PIS"}
	Local lBlqAcesso	:= aOfusca[2] .And. !Empty( FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRel ) )

	Private aReturn 	:= {STR0006, 1,STR0007, 1, 2, 1, "",1 }	//"Zebrado"###"Administracao"
	Private nomeprog	:="GPER140"
	Private anLinha 	:= { },nLastKey := 0
	Private aAreaSRA	:= SRA->(getarea())
	Private lBrasil		:= cPaisLoc == "BRA"
	//IMPR
	Private Titulo  	:= STR0008		//"EMISSO TERMO RESCISO DO CONTRATO"
	Private AT_PRG  	:= "GPER140"
	Private wCabec0 	:= 3
	Private wCabec1 	:= ""
	Private wCabec2 	:= ""
	Private wCabec3 	:= ""
	Private Contfl  	:= 1
	Private nLi     	:= 0
	Private nTamanho	:="M"
	Private cVerCodFol
	Private lGPEM040B	:= .F.
	Private cGrpVerbas	:= ""

	//OBJETOS P/ IMPRESSSAO GRAFICA
	Private oFont07,oFont08, oFont10, oFont15, oFont10n, oFont21, oFont12,oFont16
	Private oPrint

	Private lGestPubl	:= IIF(ExistFunc("fUsaGFP"),fUsaGFP(),.F.)
	Private lGrpR3		:= .F.
	Private cPerg   	:= fVldPerg()
	Private lImpDif     := .F.
	Private lImpVerbas  := .T.

	If lBlqAcesso
		//"Dados Protegidos- Acesso Restrito: Este usuário não possui permissão de acesso aos dados dessa rotina. Saiba mais em {link documentação centralizadora}"
		Help(" ",1,aOfusca[3,1],,aOfusca[3,2],1,0)
		Return
	EndIf

	If lGPEM040B .And. Len(_MarcReg) < 1
		Help(' ', 1, "NUMFUNC", , OemToAnsi( "Selecione um Funcionário" ), 1, 0)
		Return
	EndIf

	SetMnemonicos(NIL,NIL,.T.)

	oFont07  := TFont():New("Courier New", 07, 07, , .F., ,,, .T., .F.)
	oFont08  := TFont():New("Courier New", 08, 08, , .T., ,,, .T., .F.)		//Negrito
	oFont10  := TFont():New("Courier New", 10, 10, , .F., ,,, .T., .F.)
	oFont10n := TFont():New("Courier New", 10, 10, , .T., ,,, .T., .F.)
	oFont12  := TFont():New("Courier New", 12, 12, , .F., ,,, .T., .F.)		//Normal s/negrito
	oFont15  := TFont():New("Courier New", 15, 15, , .T., ,,, .T., .F.)
	oFont21  := TFont():New("Courier New", 21, 21, , .T., ,,, .T., .T.)
	oFont16  := TFont():New("Arial", 16, 16, , .T.,,,, .T., .F.)

	cSavAlias := Alias()
	nSavRec   := RecNo()
	nSavOrdem := IndexOrd()

	Pergunte(cPerg, .F.)

	//	VARIAVEIS UTILIZADAS PARA PARAMETROS - GPER140
	//	VARIAVEL  ORDEM
	//	MV_PAR01  01	//	ZEBRADO/GRAFICO/PRE-IMPR/GRFC ZEBRADO/GRFC GRAFICA
	//	MV_PAR02  02	//	FILIAL DE
	//	MV_PAR03  03	//	FILIAL ATE
	//	MV_PAR04  04	//	MATRICULA DE
	//	MV_PAR05  05	//	MATRICULA ATE
	//	MV_PAR06  06	//	CENTRO DE CUSTO DE
	//	MV_PAR07  07	//	CENTRO DE CUSTO ATE
	//	MV_PAR08  08	//	NORMAL OU COMPLEMENTAR
	//	MV_PAR09  09	//	IMPRIME CGC  SIM OU NAO
	//	MV_PAR10  10	//	DATA DEMISSAO DE
	//	MV_PAR11  11	//	DATA DEMISSAO ATE
	//	MV_PAR12  12	//	DATA GERACAO DE
	//	MV_PAR13  13	//	DATA GERACAO ATE
	//	MV_PAR14  14	//	IMPRIME DATA DE HOMOLOGACAO
	//	MV_PAR15  15	//	Nº DE VIAS
	//	MV_PAR16  16	//	IMP. FERIAS    		 AVOS OU DIAS
	//	MV_PAR17  17	//	DATA DE HOMOLOGA‡CAO DE
	//	MV_PAR18  18	//	DATA DE HOMOLOGA‡CAO AT
	//	MV_PAR19  19	//	NOME PARA CONTATO
	//	MV_PAR20  20	//	RODAPE DO RECIBO
	//	MV_PAR21  21	//	COMP. VERB 50
	//	MV_PAR22  22	//	RG
	//	MV_PAR23  23	//	NOME DO EMPREGADOR
	//	MV_PAR24  24	//	TIPO DO ORGAO HOMOLOGADOR
	//	MV_PAR25  25	// CODIGO DO MINISTERIO
	//	MV_PAR26  26	//	DT PUBLIC.DISS/ACOR
	//	MV_PAR27  27	//	TIPO DO SALARIO?
	//	MV_PAR28  28	//	IMPRIMIR INF. EXTRA?
	//	MV_PAR29  29	//	GRUPO DE VERBAS QUE COMPOEM A REMUNERACAO
	//	MV_PAR30  30	//	IMPRIME CABECALHO EM OUTRA PAGINA?
	//	MV_PAR31  31	//	AJUSTA LINHAS EM BRANCO?
	//	MV_PAR32  32	//	IMP. 13º SALÁRIO
	//	MV_PAR33  33	//	DDD/TELEFONE
	//	MV_PAR34  34	//	OPTANTE DO SIMPLES
	//	MV_PAR35  35	//	DT. ENTREGA GRFC
	//	MV_PAR36  36	//	TODAS RESCISOES COMPL?
	//	MV_PAR37  37	//	NOME EMPREGADOR/PREPOSTO?
	//	MV_PAR38  38	//	DOC NOME EMPREGADOR/PREPOSTO?
	//	MV_PAR39  39	//	Imp.Medias.Separadas ?
	//	MV_PAR40  40	//	Imp.Disc.Verb.Resc.?

	//ENVIA CONTROLE PARA A FUNCAO SETPRINT
	wnrel := "GPER140"		//NOME DEFAULT DO RELATORIO EM DISCO
	wnrel := SetPrint(cString, wnrel, cPerg, @Titulo, cDesc1, cDesc2, cDesc3, .F., aOrd, , nTamanho)
	If nLastKey = 27
		Return
	EndIf

	If !lGrpR3
		If MV_PAR01 == 4
			If lGPEM040B
				MV_PAR10	:= 1
				MV_PAR26	:= 1
			Else
				MV_PAR16	:= 1
				MV_PAR32	:= 1
			EndIf
		EndIf
	EndIf

	// AJUSTE PARA IMPRESSAO GRAFICA DO RELATRIO DE RESCISAO PARA ANGOLA
	If cPaisLoc $ "ANG|BOL|COL"
		nTipo		:= 2
		cTipoRes	:= 1
	Else
		nTipo	:= MV_PAR01
	EndIf

	Do Case
		Case lGPEM040B
			cFilialDe		:= ""
			cFilialAte		:= ""
			cMatDe			:= ""
			cMatAte			:= ""
			cCCDe			:= ""
			cCCAte			:= ""
			cTipoRes		:= MV_PAR02
			cImprCGC		:= MV_PAR03
			dDtDemDe		:= MV_PAR04
			dDtDemAte		:= MV_PAR05
			dDtGerDe		:= MV_PAR06
			dDtGerAte		:= MV_PAR07
			nImprDtHom		:= MV_PAR08
			nNumVias		:= Max(MV_PAR09,1)
			cImprFerias		:= MV_PAR10
			dDtHomDe		:= MV_PAR11
			dDtHomAte		:= MV_PAR12
			cContato		:= MV_PAR13

		Case lGrpR3
			cFilialDe		:= MV_PAR01
			cFilialAte		:= MV_PAR02
			cMatDe			:= MV_PAR03
			cMatAte			:= MV_PAR04
			cCCDe			:= MV_PAR05
			cCCAte			:= MV_PAR06
			dDtDemDe		:= MV_PAR07
			dDtDemAte		:= MV_PAR08
			dDtGerDe		:= MV_PAR09
			dDtGerAte		:= MV_PAR10
			nNumVias		:= Max(MV_PAR11, 1)

		OtherWise
			cFilialDe		:= MV_PAR02
			cFilialAte		:= MV_PAR03
			cMatDe			:= MV_PAR04
			cMatAte			:= MV_PAR05
			cCCDe			:= MV_PAR06
			cCCAte			:= MV_PAR07
			cTipoRes		:= MV_PAR08
			cImprCGC		:= MV_PAR09
			dDtDemDe		:= MV_PAR10
			dDtDemAte		:= MV_PAR11
			dDtGerDe		:= MV_PAR12
			dDtGerAte		:= MV_PAR13
			nImprDtHom		:= MV_PAR14
			nNumVias		:= Max(MV_PAR15,1)
			cImprFerias		:= MV_PAR16
			dDtHomDe		:= MV_PAR17
			dDtHomAte		:= MV_PAR18
			cContato		:= MV_PAR19
	EndCase

	If !cPaisLoc $ "DOM|BOL"
		If lGPEM040B
			dDtDissidio		:= MV_PAR20
			nTipSal			:= MV_PAR21
			lImpInfExt		:= IIf(MV_PAR22 == 1, .T., .F.)
			cGrpVerbas		:= MV_PAR23
			nImpr13Sal		:= MV_PAR26
			cTelefone		:= MV_PAR27
			nSimples		:= MV_PAR28
			dEntregaGRFC	:= MV_PAR29
		Else
			dDtDissidio		:= MV_PAR26
			nTipSal			:= MV_PAR27
			lImpInfExt		:= IIf(MV_PAR28 == 1, .T., .F.)
			cGrpVerbas		:= MV_PAR29
			nImpr13Sal		:= MV_PAR32
			cTelefone		:= MV_PAR33
			nSimples		:= MV_PAR34
			dEntregaGRFC	:= MV_PAR35
		EndIf
	EndIf

	cTipoRot	:= "4"

	//SE LOCALIZACAO BOLIVIA, APRESENTA JANELAS COM CAMPOS ADICIONAIS AO RELATORIO
	If nTipo == 2 .And. cPaisLoc == "BOL"
		pergunte("GPER142", .T.)
		nPagTipo:= MV_PAR01

		If nPagTipo == 2
			pergunte("GPER143", .T.)
			cNCheque    := mv_par01
			cNomeBanco  := mv_par02
		EndIf
	EndIf

	//VE RODAPE DO RECIBO
	If cPaisLoc == "MEX"
		cRodape	:= AllTrim( fPosTab( "S022", If(lGPEM040B, MV_PAR14, MV_PAR20), "=", 4,,,,5) )
	EndIf

	If IsBlind()
		aReturn[5] := 1
		aReturn[6] := "GPER140"
	EndIf

	SetDefault(aReturn, cString)

	If nLastKey = 27
		Return
	EndIf

	If cPerg == "GPE140R" .And. ValType(MV_PAR40) == "N"
		lImpVerbas  := MV_PAR40 == 1 .Or. !lCpoRGEfe
	EndIf

	If nTipo = 2 .OR. nTipo = 4 .OR. nTipo = 5
		//OBJETO PARA IMPRESSAO GRAFICA
		If cPaisLoc $ "ANG*EQU"
			oPrint	:= TMSPrinter():New(STR0019)
		Else
			oPrint	:= TMSPrinter():New(If(nTipo = 2 .or. nTipo = 4, STR0020, STR0021)) // "Termo de Rescisao de Contrato de Trabalho " ### "GRFC - Guia de Recolhimento Rescisorio do FGTS e da Contribuicao Social"
		EndIf

		//Caso as preferencias de impressao do usuario tenha um diretória no caminho padrao
		//executa funcao para definicao de impressora afim de evitar erro no binario
		//Obs.: esse procedimento foi orientado pela TotvsTec
		If At( ":", cDestino ) > 0
			oPrint:Setup()
		EndIf

		If nTipo == 4
			oPrint:SetPaperSize(9)
		Else
			oPrint:SetPaperSize(5)
		EndIf

		oPrint:SetPortrait()
	EndIf

	RptStatus({|lEnd| GP140Imp(@lEnd,wnRel,cString)},Titulo)

	If nTipo == 5 .or. nTipo == 2 .or. nTipo == 4
		oPrint:Preview()		// VISUALIZA IMPRESSAO GRAFICA ANTES DE IMPRIMIR
	EndIf

	dbselectarea(cSavAlias)
	dbsetorder(nSavOrdem)
	dbgoto(nSavrec)

	//restaura o valor do SET CENTURY, alterado durante o processamento do relatório
	If lCentury
		SET CENTURY ON
	Else
		SET CENTURY OFF
	EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GP140imp ³ Autor ³ R.H. - Mauro          ³ Data ³ 26.04.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Recibo de Quitacao                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER140(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GP140IMP(lEnd, WnRel, cString)

	Local nJ, nX
	Local nAuxP				:= 0
	Local nAuxD				:= 0

	Local nS				:= 1
	Local cIndCond			:= ""
	Local cExpHom			:= Iif( lGrpR3, "%%", "%SRG.RG_DATAHOM >= '" + DtoS(dDtHomDe) + "' AND SRG.RG_DATAHOM <= '" + DtoS(dDtHomAte) + "' AND %")
	Local cFiltraRh			:= ""
	Local nContIni			:= 0
	Local lRateioCC		:= GetMv("MV_RATPROV",,"N") == "S"	//Define se vai trabalhar com Rateio de Centro de Custo
	Local cAliasSRA			:= GetNextAlias()

	Private cAcessaSRG		:= ""
	Private cAcessaSRR		:= ""
	Private cAcessaSRC		:= ""
	Private cAcessaSRA		:= ""
	Private nOrdSRC			:= 0

	//BUSCA DE REMUNERACAO ANTERIOR
	Private cFilProc		:= ""
	Private dDtDemi
	Private nProv			:= nDesc := 0.00
	Private nNProv			:= 0.00
	Private cCausa			:= Space(30)
	Private cCodSaq			:= "  "
	Private cImpSac			:= " "
	Private cAvPrevio		:= " "
	Private cDtDissid		:= " "
	Private aPdv			:= {}
	Private aPdd			:= {}
	Private aPdn			:= {}
	Private aHomV			:= {}
	Private aHomD			:= {}
	Private aPdpm			:= {}
	Private aPddm			:= {}
	Private aBol			:= {}         //Matriz com campos especIficos para o Finiquito da Bolivia
	Private aCodFol			:= {}         // Matriz com Codigo da folha
	Private nLin			:= 1
	Private aInfo			:= {}         // Matriz com dados da empresa
	Private cArqWord		:= If(lGPEM040B, MV_PAR20, MV_PAR26)
	Private aDtResc			:= {}		  // Matriz com  data Geracao da Rescisao/complemento
	Private aResc			:= {}
	Private nPerPensa		:= 0
	Private nRrValor		:= 0
	Private nPerFGTS		:= 0
	Private cCodR			:= " "
	Private aTitulo			:= {}
	Private lDissidio		:= If(lGPEM040B, ! Empty(MV_PAR20), ! Empty(MV_PAR26))
	Private cFilter			:= aReturn[7]
	If lBrasil
		Private lImpCabec	:= If(lGPEM040B, If(mv_par24 == 2, .T., .F.), If(mv_par30 == 2, .T., .F.)) //  Imp. Cabec. Outra Pag.?
		Private lAjustaLin	:= If(lGPEM040B, If(mv_par25 == 2, .T., .F.), If(mv_par31 == 2, .T., .F.)) //  Ajusta linhas em branco?
	EndIf
	If !lGrpR3
		Private lComplem		:= If(lGPEM040B, If(mv_par02 == 2, .T., .F.), If(mv_par08 == 2, .T., .F.)) //	Tipo de Rescisao(Normal/Complementar)
	EndIf
	Private lImpRefD		:= GetMv("MV_REFFER",,"A") == "D" //Impede a divisao por 2.5 de Referencia que ja esta em avos.
	Private dDataDem		:= Ctod("")  //Data Demissao
	Private dDemSabDom		:= Ctod("")  //Data Demissao se pagar Sabado e Domingo
	Private nDiasAv			:= 0 		 // Dias de Aviso
	//Busca de remuneracao anterior
	Private cVerbas_Aux		:= ""
	Private lRatSRR			:= .F.	//Tem Rateio por Centro de Custo (SRR)

	If !lGrpR3 .And. cPaisLoc = "BRA" .And. nTipo = 4
		If !lComplem
			cExpHom	:= "%SRG.RG_DATAHOM >= '" + DtoS(dDtHomDe) + "' AND SRG.RG_DATAHOM <= '" + DtoS(dDtHomAte) + "' AND SRG.RG_RESCDIS IN ('0',' ') AND %"
		Else
			cExpHom	:= "%SRG.RG_DATAHOM >= '" + DtoS(dDtHomDe) + "' AND SRG.RG_DATAHOM <= '" + DtoS(dDtHomAte) + "' AND SRG.RG_RESCDIS <> '0' AND %"
		Endif
	Endif

	If MV_MODFOL == "2"
		If cPaisLoc $ "MEX"
			cAcessaSRC	:= &( " { || " + ChkRH( "GPER140" , "SRC" , "2" ) + " } " )
		Else
			cAcessaSRG	:= &( " { || " + ChkRH( "GPER140" , "SRG" , "2" ) + " } " )
			cAcessaSRC	:= &( " { || " + ChkRH( "GPER140" , "SRC" , "2" ) + " } " )
		EndIf
	Else
		cAcessaSRG	:= &( " { || " + ChkRH( "GPER140" , "SRG" , "2" ) + " } " )
		cAcessaSRR	:= &( " { || " + ChkRH( "GPER140" , "SRR" , "2" ) + " } " )
		cAcessaSRC	:= &( " { ||  } " )
	EndIf

	cAcessaSRA		:= &( " { || " + ChkRH( "GPER140" , "SRA" , "2" ) + " } " )
	//DEFINE ORDEM DO RELATORIO
	If lGPEM040B
		nOrdem  := 1
	Else
		nOrdem  := aReturn[8]
	EndIf

	DbSelectArea("SRC")
	nOrdSRC	:= RetOrdem("SRC","RC_FILIAL+RC_MAT+RC_PROCES+RC_ROTEIR+RC_PERIODO+RC_SEMANA")

	//POSICIONA NO PRIMEIRO REGISTRO SELECIONADO
	dbSelectArea("SRA")
	nSavRec   := RecNo()
	nSavOrdem := IndexOrd()

	If nOrdem == 1
		SRA->(dbSetOrder(1))
	ElseIf nOrdem == 2
		SRA->(dbSetOrder(2))
	EndIf

	If nOrdem == 1
		If lGPEM040B
			SRA->( dbSeek( _MarcReg[1], .T. ) )
		Else
			SRA->(DBGOTOP())
			SRA->( dbSeek( cFilialDe + cMatDe, .T. ) )
			cOrdem 	 := "%RA_FILIAL,RA_MAT%"
		EndIF
	ElseIf nOrdem == 2
		SRA->( dbSeek( cFilialDe + cCCDe + cMatDe, .T. ) )
		cOrdem   := "%RA_FILIAL, RA_CC, RA_MAT%"
	EndIf

	Private cFiliAnt := "__cFiliAnt__"

	//CARREGA REGUA DE PROCESSAMENTO
	SRA->( SetRegua(RecCount()) )
	SetPrc(0,0)

	If cPaisLoc == "BRA"
		If !Empty( cGrpVerbas )
			cFilProc := xFilial('SRV',SRA->RA_FILIAL )
			U_gp140GrpVerb(cFilProc,@cVerbas_Aux,cGrpVerbas)
		EndIf
	EndIf


	If lGPEM040B
		For nJ := 1 To Len(_MarcReg)

			dbSelectArea("SRA")
			SRA->( dbSeek( _MarcReg[nJ], .T. ))

			If lEnd
				@Prow() + 1, 0 PSAY cCancel
				Exit
			EndIf

			ImpFunc()

		Next
	Else

		BEGINSQL ALIAS cAliasSRA
			SELECT RA_FILIAL, RA_MAT, RA_CC, RA_SITFOLH
			FROM %table:SRA% SRA
			INNER JOIN %table:SRG% SRG ON SRA.RA_FILIAL = SRG.RG_FILIAL AND SRA.RA_MAT = SRG.RG_MAT
			WHERE	SRA.RA_FILIAL 	>= %exp:cFilialDe% AND SRA.RA_FILIAL<= %exp:cFilialAte% AND
					SRA.RA_CC 		>= %exp:cCCDe% AND SRA.RA_CC		<= %exp:cCCAte% AND
					SRA.RA_MAT 		>= %exp:cMatDe% AND SRA.RA_MAT		<= %exp:cMatAte% AND
					SRG.RG_DATADEM 	>= %exp:DtoS(dDtDemDe)% AND SRG.RG_DATADEM <= %exp:DtoS(dDtDemAte)% AND
					SRG.RG_DTGERAR 	>= %exp:DtoS(dDtGerDe)% AND SRG.RG_DTGERAR <= %exp:DtoS(dDtGerAte)% AND
					%exp:cExpHom%
					SRA.%notDel%   AND
					SRG.%notDel%
					ORDER BY %exp:cOrdem%
		ENDSQL

		While (cAliasSRA)->( !Eof() )

			If lEnd
				@Prow() + 1, 0 PSAY cCancel
				Exit
			EndIf

			//CONSISTE FILIAIS E ACESSOS
			SRA->(dbSetOrder(1))
			SRA->(dbSeek((cAliasSRA)->(RA_FILIAL+RA_MAT)))
			If (cAliasSRA)->( !( RA_FILIAL $ fValidFil() ) .or. !Eval( cAcessaSRA ) )
				(cAliasSRA)->( dbSkip() )
				Loop
			EndIf

			//CARREGA VARIAVEIS CODIGOS DA FOLHA
			If ( cFiliAnt # (cAliasSRA)->RA_FILIAL )
				cFiliAnt := (cAliasSRA)->RA_FILIAL
				If !fP_CodFol(@aCodFol,cFiliAnt)
					Return
				EndIf
				If cPaisLoc == "BRA"
					//CARREGA CODIGOS DE VERBA COM INCIDENCIA DE DSR
					U_LoadCodDSR(.F., cFiliAnt)
					//ATUALIZA O GRUPO DE VERBAS CONForME A FILIAL QUE ESTA SENDO PROCESSADA
					If  !Empty( cGrpVerbas ) .And. xFilial('SRV',cFilAnt) <> cFilProc
						cVerbas_Aux	:= ""
						U_gp140GrpVerb(cFilAnt,@cVerbas_Aux,cGrpVerbas)
						cFilProc	:= xFilial('SRV',cFilAnt)
					EndIf
				EndIf
			EndIf

			cChave	:= If (nOrdem == 1, (cAliasSRA)->RA_FILIAL + (cAliasSRA)->RA_MAT, (cAliasSRA)->RA_FILIAL + (cAliasSRA)->RA_CC + (cAliasSRA)->RA_MAT)
			SRA->(dbSetOrder(nOrdem))
			If SRA->( dbSeek(cChave) )
				If lRateioCC
					lRatSRR := fBusRatSRR()	//Buscando possíveis rateios na SRR
				EndIf
				ImpFunc()
			EndIf
			(cAliasSRA)->( dbSkip() )
		EndDo
	EndIf

	//TERMINO DO RELATORIO
	dbSelectArea("SRA")
	Set Filter to
	dbSetOrder(1)

	SetPgEject(.T.)
	nlin:= 0
	Set Device To Screen
	If (aReturn[5] = 1 .and. nTipo # 5 .And. nTipo # 2 .And. nTipo # 4)
		Set Printer To
		Commit
		ourspool(wnrel)
	EndIf

	MS_FLUSH()

	//ELIMINA VARIAVEIS STATICS
	U_LoadCodDSR(.T.)
	__SRVKey:= Nil

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER140   ºAutor  ³Microsiga           º Data ³  09/27/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function fSelGrfc()
&(ReadVar()) := cGetFile("GRFC.DOT | GRFC.DOT ", "Selecione arquivo ")
Return(.T.)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GeraTituloºAuthor ³Alexandre Silva     º Date ³  13-03-03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Alimenta a matriz a  aTitulo que sera usada no relatorio    º±±
±±º          ³IMPLIfIN, com os titulos dos campos constantes no SX3.      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUse       ³ SigaGPE - Localizacoes                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GeraTitulo()
Local i := 0

If Len(aTitulo) = 0
	If cPaisLoc== "PER"
		aAdd(aTitulo,"RUC ")
	Else
		aAdd(aTitulo,RetTitle("A2_CGC"))
	EndIf

	aAdd(aTitulo,RetTitle("A2_FILIAL"))
	aAdd(aTitulo,RetTitle("RA_CC"))
	aAdd(aTitulo,RetTitle("RA_NOME"))
	aAdd(aTitulo,RetTitle("RA_MAT"))
	aAdd(aTitulo,RetTitle("RA_ENDEREC"))
	aAdd(aTitulo,RetTitle("RA_BAIRRO"))
	aAdd(aTitulo,RetTitle("RA_MUNICIP"))
	aAdd(aTitulo,RetTitle("RA_ESTADO"))
	aAdd(aTitulo,RetTitle("RA_CEP"))
	aAdd(aTitulo,RetTitle("RA_CIC"))
	aAdd(aTitulo,RetTitle("RA_NASC"))
	aAdd(aTitulo,RetTitle("RA_MAE"))
	aAdd(aTitulo,RetTitle("RG_SALMES"))
	aAdd(aTitulo,RetTitle("RA_ADMISSA"))
	aAdd(aTitulo,RetTitle("RG_DTAVISO"))
	aAdd(aTitulo,RetTitle("RG_DATADEM"))
	aAdd(aTitulo,RetTitle("RA_RG"))

	If cPaisLoc != "ARG"
		aAdd(aTitulo,RetTitle("RA_CURP"))
		aAdd(aTitulo,RetTitle("RA_KEYLOC"))
    EndIf
    //FIXACAO DE TAMANHO
    For i:= 1 to Len(aTitulo)
    	aTitulo[i]+= Space((12-Len(aTitulo[i])))
    	aTitulo[i]:= SubStr(aTitulo[i],1,12)
    Next

EndIf

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³fOpSimples³ Autor ³ Ricardo Duarte Costa  ³ Data ³ 07/01/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Selecionar o tipo de Opcao pelo Simples.                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³fSituacao()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³Generico                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function fOpSimples()
Local aArea		:= GetArea()
Local cTitulo:=""
Local lRet := .F.
Local MvPar
Local MvParDef:=""

Private aSimples :={}
l1Elem := .T.


MvPar:=&(Alltrim(ReadVar()))		 // Carrega Nome da Variavel do Get em Questao
mvRet:=Alltrim(ReadVar())			 // Iguala Nome da Variavel ao Nome variavel de Retorno

aSimples := {;
			STR0010,; 	//	"1 - nao optante"
			STR0011,;	//  "2 - optante - faturamento anual ate R$ 1.200.000,00"
			STR0012,;	//  "3 - optante - faturamento anual superior a R$ 1.200.000,00"
			STR0013,;	//  "4 - nao optante - produtor rural pessoa fisica (CEI e FPAS 604)"
			STR0014,;	//  "5 - nao optante - Liminar para nao recolhimento da C.Social"
			STR0015;	//  "6 - optante - fat.anual > R$1.200.000,00 - Liminar p/nao recolh.C.Social"
		}
MvParDef:="123456"
cTitulo :=STR0016  //	"Opcao Simples"

While !lRet
	If f_Opcoes(@MvPar,cTitulo,aSimples,MvParDef,,,l1Elem)  // Chama funcao f_Opcoes
		&MvRet := mvpar                                                                          // Devolve Resultado
	EndIf
	If !Empty(mvpar)
		lRet := .T.
	EndIf
Enddo

RestArea(aArea)
Return( MvParDef )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³fGetOrgao	 ³ Autor ³ Tania Bronzeri       ³ Data ³27/07/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna Dados do Sindicato, baseado na SRA 			  	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function fGetOrgao(cSindic,cFilSindic)
Local aSaveSRA	:= SRA->( GetArea() )
Local cOrgao	:=	space(155)

DbSelectArea("RCE")
If RCE->(IndexOrd()) != 0
	dbSetOrder(1)
	dbSeek(cFilSindic+cSindic)
EndIf
If !Eof()
	cOrgao	:=	AllTrim(cOrgao) + RCE->RCE_ENTSIN
	cOrgao	:=	AllTrim(cOrgao)
	If !Empty(RCE->RCE_ENTSIN)
		cOrgao	:=	cOrgao+" - "
	EndIf
	cOrgao	:=	cOrgao+RCE->RCE_DESCRI
	cOrgao	:=	AllTrim(cOrgao)
	If !Empty(RCE->RCE_DESCRI)
		cOrgao	:=	cOrgao+" - "
	EndIf
	cOrgao	:=	cOrgao+RCE->RCE_ENDER
	cOrgao	:=	AllTrim(cOrgao)
	If !Empty(RCE->RCE_ENDER)
		cOrgao	:=	cOrgao+", " +RCE->RCE_NUMER
	EndIf
	cOrgao	:=	AllTrim(cOrgao)
	If !Empty(RCE->RCE_ENDER) .And. !Empty(RCE->RCE_NUMER)
		cOrgao	:=	cOrgao+" - "
	EndIf
	cOrgao	:=	cOrgao+RCE->RCE_MUNIC
	cOrgao	:=	AllTrim(cOrgao)
	If !Empty(RCE->RCE_MUNIC)
		cOrgao	:=	cOrgao+" - "
	EndIf
	cOrgao	:=	cOrgao+RCE->RCE_UF
	cOrgao	:=	AllTrim(cOrgao)
	If !Empty(RCE->RCE_UF)
		cOrgao	:=	cOrgao+" - "
	EndIf
	If !Empty(FieldGet(FieldPos("RCE_DDD"))) .And. !Empty(FieldGet(FieldPos("RCE_Fone")))
		cOrgao	:=	cOrgao+"Fone: "
	EndIf
	If !Empty(FieldGet(FieldPos("RCE_DDD")))
		cOrgao	:=	cOrgao+"("+FieldGet(FieldPos("RCE_DDD"))
		cOrgao	:=	AllTrim(cOrgao)+")"
	EndIf
	If !Empty(FieldGet(FieldPos("RCE_FONE")))
		cOrgao	:=	cOrgao+FieldGet(FieldPos("RCE_FONE"))
	EndIf
	cOrgao	:=	AllTrim(cOrgao)
EndIf

RestArea(aSaveSRA)

Return(cOrgao)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER140IV ºAutor  ³WAGNER MONTENEGRO   º Data ³  15/12/2010 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³FUNÇÃO DE RETORNO PARA IDENTIfICADOR OU VERBA               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER140IV(cCampo,nOrdem)
	Local aAreaOld:=GetArea()
	Local cRet
	SRV->(DbSetOrder(1))
	If SRV->(DbSeek(xFilial("SRV",SRA->RA_FILIAL)+cCampo))
		If cPaisLoc == "BRA"
			If nOrdem==1
				If len(SRV->RV_CODFOL) = 4 .and. Left(SRV->RV_CODFOL,1) = '0'
					cRet:= Right(SRV->RV_CODFOL,3)
				Else
					cRet:=SRV->RV_CODFOL
				EndIf
			Else
				cRet:=SRV->RV_HOMOLOG
			EndIf
		Else
			cRet:=SRV->RV_CODFOL
		EndIf
	EndIf
	RestArea(aAreaOld)
Return(cRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma ³GPER140Sum ºAutor  ³WAGNER MONTENEGRO   º Data ³  15/12/2010 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.    ³FUNÇÃO DE CONTROLE DE SOMA PARA IMPRESSAO DA RESCISAO        º±±
±±º         ³HOMOLOGNET                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso      ³ AP                                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER140Sum(nOp,nColSum,cCond,lCampo,nRef,nType,lPD,cCondID,aCVb,cSeq)
//nOp = 1 PROVENTOS 2=DESCONTOS
//nColSum = 1=CODFOL 2=RV_HOMOLOG
Local nX,nY
Local nValor	:= 0.00
Local nAvos		:= 0
Local lPagVal	:= .T.       //PAGINAR VALOR
Local cIdCalcAnt:= "000"
Local nValRat	:= 0
Default lCampo	:=.F.
Default nColSum	:= 0
Default cCond	:=""
Default nRef	:= 3
Default nType	:= 0
Default lPD		:= .F.
Default cCondID	:=""
Default aCVb	:= {}
Default cSeq	:= ' '

cSeq := Iif(cSeq == '0', ' ', cSeq)

If !lCampo
	If nOp==1
		For nX:=1 to Len(aHomV)
			If nColSum==1
				If Empty(cCondID) .or. ( !Empty(cCondID) .and. aHomV[nX,9] = cCondID ) .OR. (!Empty(cSeq) .and. aHomV[nX,8] = cSeq)
					//PELA VERBA
					If lPD
						If aHomV[nX,4] $ cCond
							If Posicione("SRV", 1, xFilial("SRV", SRA->RA_FILIAL)+aHomV[nX,4], "RV_AGLTRCT") == "2"
								aAdd( aCVb, {aHomV[nX,4], Transform(aHomV[nX,nRef], "@E 99,999,999.99")} )
							Else
								nValor += aHomV[nX,nRef]
							EndIf
							aHomV[nX,7] := 1
						EndIf
					Else //PELO IDENTIFICADOR
						If aHomV[nX,5] $ cCond
							If lRatSRR
								cIdCalcAtu := aHomV[nX,5]

								If cIdCalcAnt != cIdCalcAtu
									nValRat := nValRat + aHomV[nX,nRef]
									aAdd( aCVb , {aHomV[nX,4],Transform(nValRat,"@E 99,999,999.99"),aHomV[nX,9],aHomV[nX,2]} )
									cIdCalcAnt  := cIdCalcAtu
									nLinAlterar	:= Len(aCVb)
								Else
									nValRat := nValRat + aHomV[nX,nRef]
									aCVb[nLinAlterar,2] := Transform(nValRat,"@E 99,999,999.99")
									aCVb[nLinAlterar,4] := aCVb[nLinAlterar,4] + aHomV[nX,2]
								Endif
							Else
								aAdd( aCVb , {aHomV[nX,4],Transform(aHomV[nX,nRef],"@E 99,999,999.99"),aHomV[nX,9],aHomV[nX,2]} )
							Endif

							nValor += aHomV[nX,nRef]
							aHomV[nX,7]:=1
						Endif
					EndIf
				EndIf
			EndIf
			If nColSum==2
				If aHomV[nX,6]$cCond
					If Empty(cCondID) .or. ( !Empty(cCondID) .AND. aHomV[nX,9] = cCondID )
						If aHomV[nX,6]$"013/014" .AND. nRef == 2
							nValor := 0
							lPagVal := .F.
						Else
							nValor+= aHomV[nX,nRef]
						EndIf
						aHomV[nX,7]:=1
						If aHomV[nX,6]$"013/004/012/014"
							cPercSRV:=TransForm(PosSrv(aHomV[nX,4],xFilial("SRR"),"RV_PERC"),"@E 999.99")
						EndIf
					EndIf
				EndIf
			EndIf
		Next
	EndIf

	//Quando existir verba de férias informada, o campo NUM ID não estará preenchido, ira buscar apenas pela verba
	If ( ( nValor == 0 .and. "086" $ cCond ) .Or. "248" $ cCond ) .and. nOp == 1 .and. nRef == 3 .and. !Empty(cCondID) .and. nColSum == 1
		For nX:=1 to Len(aHomV)
			If Empty(aHomV[nX,9])
				//PELA VERBA
				If lPD
					If aHomV[nX,4] $ cCond
						If Posicione("SRV", 1, xFilial("SRV", SRA->RA_FILIAL)+aHomV[nX,4], "RV_AGLTRCT") == "2"
							aAdd( aCVb, {aHomV[nX,4], Transform(aHomV[nX,nRef], "@E 99,999,999.99")} )
						Else
							nValor += aHomV[nX,nRef]
						EndIf
						aHomV[nX,7] := 1
					EndIf
				Else //PELO IDENTIFICADOR
					If aHomV[nX,5] $ cCond
						aAdd( aCVb , {aHomV[nX,4],Transform(aHomV[nX,nRef],"@E 99,999,999.99"),aHomV[nX,9],aHomV[nX,2]} )
						nValor += aHomV[nX,nRef]
						aHomV[nX,7]:=1
					Endif
				EndIf
			EndIf
		Next nX
	EndIf
	If nOp==2
		For nX:=1 to Len(aHomD)
			If nColSum==1
				If aHomD[nX,5]$cCond
					nValor+=aHomD[nX,nRef]
					aHomD[nX,7]:=1
				EndIf
			EndIf
			If nColSum==2
				If aHomD[nX,6]$cCond
					nValor+=aHomD[nX,nRef]
					aHomD[nX,7]:=1
				EndIf
			EndIf
			If nColSum==3
				If aHomD[nX,4] $ cPensao
					nValor+=aHomD[nX,nRef]
					aHomD[nX,7]:=1
				EndIf
			EndIf
		Next
	EndIf
Else
	If nOp==1
		For nY:= 1 to Len(aCpoForm)
			For nX:=1 to Len(aHomV)
				If aCpoForm[nY,2]==1
					If aHomV[nX,5]$aCpoForm[nY,4]
						nValor+=aHomV[nX,3]
						nAvos+=aHomV[nX,2]
						aHomV[nX,7]:=1
					EndIf
				EndIf
				If aCpoForm[nY,2]==2
					If aHomV[nX,6]$aCpoForm[nY,4]
						nValor+=aHomV[nX,3]
						nAvos+=aHomV[nX,2]
						aHomV[nX,7]:=1
					EndIf
				EndIf
			Next
			aCpoForm[nY,5]:=TransForm(nValor,"@E 99,999,999.99")
			aCpoForm[nY,6]:=TransForm(nAvos,"@E 999")
			nValor:=0
			nAvos:=0
		Next
		For nY:= 1 to Len(aCpoFor1)
			For nX:=1 to Len(aHomV)
				If aCpoFor1[nY,2]==1
					If aHomV[nX,5]$aCpoFor1[nY,4]
						nValor+=aHomV[nX,3]
						nAvos+=aHomV[nX,2]
						aHomV[nX,7]:=1
					EndIf
				EndIf
				If aCpoFor1[nY,2]==2
					If aHomV[nX,6]$aCpoFor1[nY,4]
						nValor+=aHomV[nX,3]
						nAvos+=aHomV[nX,2]
						aHomV[nX,7]:=1
					EndIf
				EndIf
			Next
			aCpoFor1[nY,5]:=TransForm(nValor,"@E 99,999,999.99")
			aCpoFor1[nY,6]:=TransForm(nAvos,"@E 999")
			nValor:=0
			nAvos:=0
		Next
	EndIf
	If nOp==2
		For nY:= 1 to Len(aCpoFormD)
			For nX:=1 to Len(aHomD)
				If aCpoFormD[nY,1]<>"115"
					If aCpoFormD[nY,2]==1
						If aHomD[nX,5]$aCpoFormD[nY,4]
							nValor+=aHomD[nX,3]
							nAvos+=aHomD[nX,2]
							aHomD[nX,7]:=1
						EndIf
					EndIf
					If aCpoFormD[nY,2]==2
						If aHomD[nX,6]$aCpoFormD[nY,4]
							nValor+=aHomD[nX,3]
							nAvos+=aHomD[nX,2]
							aHomD[nX,7]:=1
						EndIf
					EndIf
				EndIf
			Next
			aCpoFormD[nY,5]:=TransForm(nValor,"@E 99,999,999.99")
			aCpoFormD[nY,6]:=TransForm(nAvos,"@E 999")
			nValor:=0
			nAvos:=0
		Next
	EndIf
EndIf

Return(If(lCampo,.T.,If(nRef=3,If(nType==0,TransForm(nValor,"@E 99,999,999.99"),nValor),If(nType==1,If(nValor > 0 .or. lPagVal, nValor,),TransForm(nValor,"@E 999")))))

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GP140imp ³ Autor ³ R.H. - Alex Fagundes  ³ Data ³ 08.02.11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Calcula Periodo Aquisitivo para TRCT Homolognet            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_fPerAquisitivo(void)                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ IMPRESH 		                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function fPerAquisitivo()
Local dFPerAqui   	:= Ctod("")
Local dIPerAqui		:= Ctod("")
Local dDtBasFim 	:= Ctod("")
Local dSvDtDem		:= dDataDem
Local nDiasVenc 	:= 0
Local nDiasProp 	:= 0

aPerFerias := {}

//GARANTE A EXISTENCIA DE REGISTRO NA PROGRAMACAO DE FERIAS
If !SRF->( dbSeek( SRA->RA_FILIAL + SRA->RA_MAT ) )
	SRF->(RecLock("SRF",.T.))
	SRF->RF_FILIAL := SRA->RA_FILIAL
	SRF->RF_MAT    := SRA->RA_MAT
	SRF->RF_DATABAS:= SRA->RA_ADMISSA
	SRF->(MsUnlock())
EndIf

dIPerAqui:=SRF->RF_DATABAS

Calc_Fer(@aPerFerias,dDtDemi,@nDiasVenc,@nDiasProp,,,,.F.)

dFPerAqui := If (Empty(dDtBasFim), fCalcFimAq(dIPerAqui), dDtBasFim)

dDemSabDom := dDataDem
dDataDem := dSvDtDem

Return(aPerFerias)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ LoadCodDSR ³ Autor ³ R.H. - Mauricio MR  ³ Data ³ 13.01.11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Carrega Verbas com incidencia de DSR.                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER140(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ IMPRESH 		                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function LoadCodDSR(lLimpa,cFilPar)
Local aArea		:= GetArea()
Local aSRVArea	:= SRV->(GetArea())
Local cFilSRV
Local cSRV			:= ''
DEFAULT cFilPar	:= cFilAnt
DEFAULT lLimpa	:= .F.

Static cDSRSLV	:= {}

If lLimpa
	cDSRSLV := NIL
Else
	cFilSRV:= xFilial('SRV',cFilPar)
    //VERIfICA A NECESSIDADE DE CARREGAR SRV
    If ( __SRVKey <> cFilSRV )
    	__SRVKey := cFilSRV
		cDSRSLV:=''   //CODIGOS DE VERBAS DE DSR S/ SALARIO VARIAVEL CAMPO 59'

		SRV->(Dbseek(cFilSRV))
		While !SRV->(EOF()) .and. xFilial('SRV',SRV->RV_FILIAL) == cFilSRV

			If cPaisLoc == "BRA"
				//VERBAS COM INCIDENCIA DE DSR (COM EXCEÇÃO DE HORAS EXTRAS)
				IF !Empty(SRV->RV_CODDSR) .and. ( Upper(Alltrim(SRV->RV_DSRHE)) == "N" ) .And. !(SRV->RV_CODFOL $ "0032*0048")
					cSRV  := Alltrim(Upper(SRV->RV_CODDSR))
					If ! ( cSRV $  cDSRSLV )
						cDSRSLV +='/'+cSRV
					EndIf
				Else
					//0035 - DSR HORA EXTRA
					//0122 - DSR SOBRE COMISSOES RESCISAO
					//0166 - DSR SOBRE COMISSOES
					If ( SRV->RV_CODFOL $"0035/0122/0166" )
						cSRV  := Alltrim(Upper(SRV->RV_COD))
						cDSRSLV +='/'+cSRV
					EndIf
				EndIf
			Else
				//VERBAS COM INCIDENCIA DE DSR (COM EXCEÇÃO DE HORAS EXTRAS)
				IF ( Upper(Alltrim(SRV->RV_DSRHE)) == "N" ) .And. !(SRV->RV_CODFOL $ "0032*0048")
					cSRV  := ' '
					If ! ( cSRV $  cDSRSLV )
						cDSRSLV +='/'+cSRV
					EndIf
				Else
					//0035 - DSR HORA EXTRA
					//0122 - DSR SOBRE COMISSOES RESCISAO
					//0166 - DSR SOBRE COMISSOES
					If ( SRV->RV_CODFOL $"0035/0122/0166" )
						cSRV  := Alltrim(Upper(SRV->RV_COD))
						cDSRSLV +='/'+cSRV
					EndIf
				EndIf
			EndIf

			SRV->(DbSkip())
		Enddo
    EndIf
EndIf

RestArea(aSRVArea)
RestArea(aArea)

Return(cDSRSLV)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³gp140GrpVerb ºAutor ³Mauricio MR       º Data ³  29/03/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Obter os codigos das verbas conForme o grupo selecionado.   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER140                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function gp140GrpVerb(cFilProc,cVerbas_Aux,cGrpVerbas,lSomentePD)
Local aArea			:= GetArea()
Local aAreaSRV
Local cPrefix 		:= ""
Local cFrom			:= ""
Local cWhere		:= ""
Local cOrder		:= ""
Local cQrySRV 		:= ""
Local cAliasSRV 	:= ""

Static __oSt1
Static __cEmpAux

DEFAULT lSomentePD  := .F.

If __oSt1 == Nil .or. ( __cEmpAux == Nil .or. __cEmpAux <> cEmpAnt )

	__cEmpAux := cEmpAnt

	__oSt1 := FWPreparedStatement():New()

	cQuery := "SELECT RV_COD FROM " + RetSqlName('SRV') + " WHERE "
	cQuery += "RV_FILIAL = ? AND "
	If cPaisLoc == "BRA"
		cQuery += "RV_GRPVERB LIKE ? AND "
	EndIf
	cQuery += "D_E_L_E_T_ = ' ' "
	cQuery := ChangeQuery(cQuery)

	__oSt1:SetQuery(cQuery)

EndIf

__oSt1:SetString(1,cFilProc)

If cPaisLoc == "BRA"
	cGrpVerbas := "%" + cGrpVerbas + "%"
	__oSt1:SetString(2,cGrpVerbas)
EndIf

cQuery := __oSt1:getFixQuery()

cAliasSRV := GetNextAlias()

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSRV)

aAreaSRV := SRV->(getArea())
dbSelectArea(cAliasSRV)

While (cAliasSRV)->(!Eof())
	// lSomentePd 4º parâmetro da função, se ativo grava somente os códigos de verba sem o "/"
	If !lSomentePD
		cVerbas_Aux += AllTrim( (cAliasSRV)->RV_COD ) + "/"
	Else
		cVerbas_Aux += AllTrim( (cAliasSRV)->RV_COD )
	Endif
	(cAliasSRV)->(dbSkip())
Enddo

( cAliasSRV )->( dbCloseArea() )

RestArea(aAreaSRV)

RestArea(aArea)

Return

Static Function ImpFunc

	Local cVerCodFol
	Local cFilMat
	Local nI
	Local nImprVias
	Local nImp
	Local aImpr				:= {}
	Local aCodBenef 		:= {}
	Local nHoras			:= ""
	Local cRoteir			:= fGetCalcRot('4')	// RESCISAO
	Local cSvRoteir			:= ""
	Local lSelec			:= .T.
	Local cRotCalc			:= ""
	Local cTabRes			:= If(cPaisLoc $ "MEX", "S025", If((cPaisLoc $ "BOL"), "S013", "S043"))
	Local nCont				:= 0
	Local aAreaSRQ			:= {}
	Local aTS019			:= {}
	Local nPos				:= 0
	Local cAcessaSRA		:= &( " { || " + ChkRH( "GPER140" , "SRA" , "2" ) + " } " )
	Local cRotP				:= ""
	Local cRecSRG			:= ""
	Local nT
	Local cSRG_A			:= ""
	Local cSRG_B			:= ""
	Local nImpr13Sal		:= 0
	Local lIMPGRFC	 := ExistBlock( "IMPGRFC",.F.,.T. )//variavel p/ PE "IMPGRFC"
	Local lIMPLIfIN := ExistBlock("IMPLIfIN")//variavel p/ PE "IMPLIfIN"
	Local lIMPRESC := ExistBlock("IMPRESC")//variavel p/ PE "IMPRESC"
	Local lIMPRESG := ExistBlock("IMPRESG")//variavel p/ PE "IMPRESG"
	Local lIMPRESH := ExistBlock("IMPRESH")//variavel p/ PE "IMPRESH"
	Local lIMPRESZ := ExistBlock("IMPRESZ")//variavel p/ PE "IMPRESZ"


	//MOVIMENTA REGUA DE PROCESSAMENTO
	IncRegua()

	aPdv 	:= {}
	aHomV	:= {}
	aHomD	:= {}
	aPdd 	:= {}
	aPdn	:= {}
	aPdpm	:= {}
	aPddm	:= {}
	aImpr	:= {}
	aResc	:= {}

	If !lGrpR3
		cSRG_A := "SRG->((RG_DATADEM >= dDtDemDe .And. RG_DATADEM <= dDtDemAte) .And. (RG_DTGERAR >= dDtGerDe .And. RG_DTGERAR <= dDtGerAte) .And. (RG_DATAHOM >= dDtHomDe .And. RG_DATAHOM <= dDtHomAte))"
		cSRG_B := '(	(SRG->RG_DATADEM >= dDtDemDe .And. SRG->RG_DATADEM <= dDtDemAte) .OR. (SRG->RG_DTGERAR >= dDtGerDe .And. SRG->RG_DTGERAR <= dDtGerAte) .OR. (SRG->RG_DATAHOM >= dDtHomDe .And. SRG->RG_DATAHOM <= dDtHomAte)) .AND. SRG->RG_EFETIVA <> "1" '
	Else
		cSRG_A := 'SRG->((RG_DATADEM >= dDtDemDe .And. RG_DATADEM <= dDtDemAte) .And. (RG_DTGERAR >= dDtGerDe .And. RG_DTGERAR <= dDtGerAte))'
		cSRG_B := '((SRG->RG_DATADEM >= dDtDemDe .And. SRG->RG_DATADEM <= dDtDemAte) .OR. (SRG->RG_DTGERAR >= dDtGerDe .And. SRG->RG_DTGERAR <= dDtGerAte)) .AND. SRG->RG_EFETIVA <> "1"'
	EndIf

	cFilMat	:= ( SRA->RA_FILIAL + SRA->RA_MAT )

	//DEFINE CODIGOS DE IDENTIfICADORES PARA O PERGUNTE MV_PAR16 PARA CALCULAR FERIAS EM AVOS OU EM HORAS
	If cPaisLoc == "ANG"
		cVerCodFol:=aCodFol[086,1]+"*"+ ;	//  Ferias Indenizadas
		            aCodFol[087,1]+"*"+ ;	//  Ferias Proporcionais
		            aCodFol[230,1]+"*"+ ;	//	Ferias s/ Av.Previo Indenizado
		            aCodFol[1100,1]			//	Remuneracao de Ferias na Folha.
	ElseIf cPaisLoc == "BOL"
		cVerCodFol:=  aCodFol[754,1]+"*"+ ; // Promedio 1 Mes Indemnizacion
				      aCodFol[755,1]+"*"+ ;	// Promedio 2 Mes Indemnizacion
				      aCodFol[756,1]+"*"+ ;	// Promedio 3 Mes Indemnizacion
				      aCodFol[760,1]+"*"+ ; // Promedio 4 Mes Indemnizacion
				      aCodFol[757,1]+"*"+ ;	// Indemnizacion Ano
				      aCodFol[758,1]+"*"+ ;	// Indemnizacion Mes
				      aCodFol[759,1]+"*"+ ;	// Indemnizacion Dia
				      aCodFol[761,1]+"*"+ ;	// Promedio Indemnizacion
				      aCodFol[762,1]+"*"+ ;	// Aguinaldo Mes Finiquito
				      aCodFol[763,1]+"*"+ ;	// Aguinaldo Dias Finiquito
				      aCodFol[086,1]+"*"+ ;	// Vacaciones Mes Finiquito   // 764
				      aCodFol[087,1]+"*"+ ;	// Vacaciones Dias Finiquito  // 765
				      aCodFol[768,1]+"*"+ ;	// Deahucio
				      aCodFol[084,1]+"*"+ ; // Otros
				      aCodFol[048,1]+"*"+ ;	// Gestion de dias
				      aCodFol[766,1]+"*"+ ;	// Prima Anual Mes Finiquito
		              aCodFol[767,1]+"*"+ ;	// Prima Anual Dias Finiquito
		              aCodFol[779,1]+"*"+ ; // Domingo Pagado
  		              aCodFol[1211,1]	    // Aporte Adicional AFP

	ElseIf cPaisLoc == "EQU"
	    cVerCodFol:= aCodFol[0072,1]+"*"+ ; //  Pagto de Ferias
	    			 aCodFol[1207,1]+"*"+ ;	//  Dias adicionais gozados
	    			 aCodFol[1004,1]+"*"+ ;	//  BonIficacao de Ferias
	    			 aCodFol[0086,1]+"*"+ ;	//  Ferias Indenizadas
	    			 aCodFol[0087,1]		//  Ferias Proporcionais
	ElseIf cPaisLoc == "ARG"
	    cVerCodFol:= aCodFol[0072,1]+"*"+ ; //  Pagto de Ferias
	    			 aCodFol[0086,1]+"*"+ ;	//  Ferias Indenizadas
	    			 aCodFol[0087,1]		//  Ferias Proporcionais
	Else
		cVerCodFol:=aCodFol[086,1]+"*"+ ;	//  Ferias Indenizadas
		            aCodFol[087,1]+"*"+ ;	//  Ferias Proporcionais
		            aCodFol[230,1]+"*"+ ;	//	Ferias s/ Av.Previo Indenizado
		            aCodFol[248,1]+"*"+ ;	//	Media Ferias Vencidas Rescisao
		            aCodFol[249,1]+"*"+ ;	//	Media Ferias Proporcionais Rescisao
		            aCodFol[252,1]			//	Media Ferias Sobre Aviso Indenizado Rescisao
	EndIf

	//DEFINE CODIGOS DE IDENTIfICADORES PARA O PERGUNTE MV_PAR32 PARA CALCULAR 13 SAL.EM AVOS OU EM HORAS.
	If cPaisLoc == "EQU"
		cVerCod13 :=aCodFol[0025,1]+"*"+ ;	 //  13§ Pago na Rescisao
	            	aCodFol[1205,1]          //  14 Salário na Rescisão
	Else
		cVerCod13 :=aCodFol[114,1]+"*"+ ;	//  13o. na Indenizacao
	            	aCodFol[115,1]+"*"+ ;  	//  13o. Sobre Aviso Previo
	            	aCodFol[251,1]+"*"+ ; 	//	Media 13o. Salario Rescisao
	            	aCodFol[253,1]        	//	Media 13o. Salario Sobre Aviso Indenizado Rescisao
	EndIf

	If !(cPaisLoc $ "MEX|COS") .And. MV_MODFOL <> "2"
		//PROCURA NO ARQUIVO DE CABECALHO DA RESCISAO "SRG"
		DbSelectArea("SRG")
		If SRG->( dbSeek( cFilMat ) .and. ( RG_FILIAL $ fValidFil() .and. Eval( cAcessaSRG ) ) ) //Consiste Filial e Acessos
			While SRG->( !Eof() .And. ( cFilMat ) == ( RG_FILIAL + RG_MAT ) )
				Aadd(aResc,{SRG->(RECNO()),SRG->RG_FILIAL+SRG->RG_MAT,SRG->RG_DTGERAR,SRG->RG_DATADEM,SRG->RG_DATAHOM})
				If cPaisLoc == "BRA" .And. SRG->RG_RESCDIS == '1'
					// Adiciona somente os cabecalhos das rescisoes complementares. Utilizado no fonte IMPGRFC.
					Aadd(aDtResc,{SRG->RG_FILIAL+SRG->RG_MAT,SRG->RG_DTGERAR,SRG->RG_DATADEM,SRG->RG_DATAHOM})		//-- Data da ultima Geracao da Rescisao/complemento
				EndIf
				SRG->( dbSkip() )
			End
			aSort(aResc,,,{ |x,y| x[4]+x[3] < y[4]+y[3] })
			nCont := 1
			If cTipoRes = 1
				aAdd(aImpr,aResc[1])
			EndIf
			dDtDemi := aResc[1][4]
			nCont++
			While nCont <= Len(aResc)
				If ( cTipoRes = 1 .And. dDtDemi <> aResc[nCont][4] ) .Or. ( cTipoRes = 2 .And. dDtDemi = aResc[nCont][4] )
					aAdd(aImpr,aResc[nCont])
				EndIf
				dDtDemi := aResc[nCont][4]
				nCont++
			End

			For nImp := 1 to Len(aImpr)
				SRG->(DbGoTo(aImpr[nImp][1]))
				//CONSISTE PERIODOS DO SRG
				If &(cSRG_A)
					aPdv 	:= {}
					aHomV	:= {}
					aHomD	:= {}
					aPdd 	:= {}
					//PROCURA ARQUIVO DE VERBAS DA RESCISAO
					DbSelectArea("SRR")
					nProv := nDesc := nNProv := 0.00

					DbSetOrder( 1 )
					If SRR->( dbSeek( cFilMat + "R" ) )
						If !(!lImpVerbas .And. SRG->RG_EFETIVA == "N")
							While SRR->( !Eof() .And. ( cFilMat + "R" ) == ( RR_FILIAL + RR_MAT + RR_TIPO3 ) )

								//CONSISTE FILIAIS E ACESSOS
								If SRR->( !( RR_FILIAL $ fValidFil() ) .or. !Eval( cAcessaSRR ) )
									dbSelectArea("SRR")
									SRR->( dbSkip() )
									Return
								EndIf

								//CONSISTE DATA DE GERACAO
								If ( SRR->RR_DATA == SRG->RG_DTGERAR )
									//NAO IMPRIME VALORES ZERADOS
									If ( SRR->RR_VALOR == 0.00 )
										SRR->( dbSkip() )
										Loop
									EndIf

									//VERIfICA O TIPO DA VERBA E CARREGA NO APD? CORRESPONDENTE
									If RetValSRV(SRR->RR_PD, SRA->RA_FILIAL, "RV_CODFOL") == "1446" .And. SRR->RR_HORAS - Int(SRR->RR_HORAS) != 0.12

										nHoras	:= Int(SRR->RR_HORAS)
                                        If (SRR->RR_HORAS - Int(SRR->RR_HORAS)) >= 0.5
                                            nHoras++
                                        Endif
									Else
										nHoras	:= SRR->RR_HORAS
									EndIf

									If PosSrv(SRR->RR_PD,SRA->RA_FILIAL,"RV_TIPOCOD") == "1" //Provento
										If cPaisLoc == "MEX"
											Aadd(aPdv,{Str(nHoras,6,2),Substr(DescPd(SRR->RR_PD,SRA->RA_FILIAL,20),1,20),TransForm(SRR->RR_VALOR,"99,999,999.99"),SRR->RR_PD} )
										ElseIf (cPaisLoc == "COL")
											Aadd(aPdv,Substr(DescPd(SRR->RR_PD,SRA->RA_FILIAL),1,19)+' '+Str(nHoras,6,2)+' '+TransForm(SRR->RR_VALOR,"@E 999,999,999.99") )
										Else
											If !lGrpR3
												//Ferias
												If cImprFerias==2 .and. SRR->RR_PD$cVerCodFol .And. (SRR->RR_HORAS - Int(SRR->RR_HORAS)) = 0.12
													Aadd(aPdv,DescPd(SRR->RR_PD,SRA->RA_FILIAL)+' '+Str(Int(nHoras)*2.5,6,2)+' '+TransForm(SRR->RR_VALOR,"@E 99,999,999.99") )
													Aadd(aHomV ,{DescPd(SRR->RR_PD,SRA->RA_FILIAL),    (Int(nHoras)*2.5) ,    SRR->RR_VALOR,SRR->RR_PD,U_GPER140IV(SRR->RR_PD,1),U_GPER140IV(SRR->RR_PD,2),0,SRR->RR_SEQ,AllTrim(SRR->RR_NUMID),SRR->RR_TIPO1 })
												ElseIf cImprFerias==1 .and. SRR->RR_PD$cVerCodFol .And. (SRR->RR_HORAS - Int(SRR->RR_HORAS)) # 0.12 .And. lImpRefD
													Aadd(aPdv,DescPd(SRR->RR_PD,SRA->RA_FILIAL)+' '+Str((SRR->RR_HORAS / 2.5) + 0.12 ,6,2)+' '+TransForm(SRR->RR_VALOR,"@E 99,999,999.99") )
													Aadd(aHomV	,{DescPd(SRR->RR_PD,SRA->RA_FILIAL),    ((SRR->RR_HORAS / 2.5) + 0.12),    SRR->RR_VALOR,SRR->RR_PD,U_GPER140IV(SRR->RR_PD,1),U_GPER140IV(SRR->RR_PD,2),0,SRR->RR_SEQ,AllTrim(SRR->RR_NUMID),SRR->RR_TIPO1 })
												Else
													//13º SALARIO
													If nImpr13Sal==2 .and. SRR->RR_PD$cVerCod13 .And. (SRR->RR_HORAS - Int(SRR->RR_HORAS)) = 0.12
														Aadd(aPdv,DescPd(SRR->RR_PD,SRA->RA_FILIAL)+' '+Str(Int(SRR->RR_HORAS)*2.5,6,2)+' '+ TransForm(SRR->RR_VALOR,"@E 99,999,999.99") )
														Aadd(aHomV,{DescPd(SRR->RR_PD,SRA->RA_FILIAL),  (Int(SRR->RR_HORAS)*2.5)     ,SRR->RR_VALOR,SRR->RR_PD,U_GPER140IV(SRR->RR_PD,1),U_GPER140IV(SRR->RR_PD,2),0,SRR->RR_SEQ,AllTrim(SRR->RR_NUMID),SRR->RR_TIPO1 })
													ElseIf nImpr13Sal==1 .and. SRR->RR_PD$cVerCod13 .And. (SRR->RR_HORAS - Int(SRR->RR_HORAS)) # 0.12 .And. lImpRefD
														Aadd(aPdv,DescPd(SRR->RR_PD,SRA->RA_FILIAL)+' '+Str((nHoras / 2.5) + 0.12 ,6,2)+' '+TransForm(SRR->RR_VALOR,"@E 99,999,999.99") )
														Aadd(aHomV,{DescPd(SRR->RR_PD,SRA->RA_FILIAL),  ((nHoras / 2.5) + 0.12),    SRR->RR_VALOR,SRR->RR_PD,U_GPER140IV(SRR->RR_PD,1),U_GPER140IV(SRR->RR_PD,2),0,SRR->RR_SEQ,AllTrim(SRR->RR_NUMID),SRR->RR_TIPO1 })
													Else
														Aadd(aPdv,DescPd(SRR->RR_PD,SRA->RA_FILIAL)+' '+Str(nHoras,6,2)+' '+TransForm(SRR->RR_VALOR,"@E 99,999,999.99") )
														Aadd(aHomV,{DescPd(SRR->RR_PD,SRA->RA_FILIAL),  nHoras,    SRR->RR_VALOR,SRR->RR_PD,U_GPER140IV(SRR->RR_PD,1),U_GPER140IV(SRR->RR_PD,2),If(SRR->RR_PD # aCodfol[045,1],0,1),SRR->RR_SEQ,AllTrim(SRR->RR_NUMID),SRR->RR_TIPO1 })
													EndIf
												EndIf
											EndIf
										EndIf
										nProv += SRR->RR_VALOR
									ElseIf PosSrv(SRR->RR_PD,SRA->RA_FILIAL,"RV_TIPOCOD") == "2" .And. SRR->RR_PD # aCodfol[126,1]  // Desconto e Despreza Liq. da Rescisao
										If cPaisLoc == "MEX"
											Aadd(aPdd,{Str(nHoras,6,2),Substr(DescPd(SRR->RR_PD,SRA->RA_FILIAL,20),1,20),TransForm(SRR->RR_VALOR,"99,999,999.99"),SRR->RR_PD} )
										ElseIf (cPaisLoc == "COL")
											Aadd(aPdd,Substr(DescPd(SRR->RR_PD,SRA->RA_FILIAL),1,19)+' '+Str(nHoras,6,2)+' '+TransForm(SRR->RR_VALOR,"@E 999,999,999.99") )
										ElseIf (cPaisLoc $ "BOL")	//# Usado no rdmake IMPLIfIN
											Aadd(aPdd,{Str(nHoras,6,2),Substr(DescPd(SRR->RR_PD,SRA->RA_FILIAL,20),1,20),SRR->RR_VALOR})
										Else
											Aadd(aPdd,DescPd(SRR->RR_PD,SRA->RA_FILIAL)+' '+Str(nHoras,6,2)+" "+TransForm(SRR->RR_VALOR,"@E 99,999,999.99") )
											Aadd(aHomD,{DescPd(SRR->RR_PD,SRA->RA_FILIAL),nHoras,SRR->RR_VALOR,SRR->RR_PD,U_GPER140IV(SRR->RR_PD,1),U_GPER140IV(SRR->RR_PD,2),0,SRR->RR_SEQ,AllTrim(SRR->RR_NUMID) })
										EndIf
										nDesc += SRR->RR_VALOR
									ElseIf cPaisLoc == "COL" .AND. PosSrv(SRR->RR_PD,SRA->RA_FILIAL,"RV_TIPOCOD") $ "34" .And. SRV->RV_IMPRIPD == "1" //Base Provento
										Aadd(aPdpm,Substr(DescPd(SRR->RR_PD,SRA->RA_FILIAL),1,19)+' '+Str(nHoras,6,2)+' '+TransForm(SRR->RR_VALOR,"@E 999,999,999.99") )
									ElseIf PosSrv(SRR->RR_PD,SRA->RA_FILIAL,"RV_TIPOCOD") == "3" .And. cPaisLoc == "MEX" //Base Provento
										Aadd(aPdpm,{Str(nHoras,6,2),Substr(DescPd(SRR->RR_PD,SRA->RA_FILIAL,20),1,20),TransForm(SRR->RR_VALOR,"99,999,999.99"),SRR->RR_PD} )
									ElseIf PosSrv(SRR->RR_PD,SRA->RA_FILIAL,"RV_TIPOCOD") == "4" .And. cPaisLoc == "MEX" //Base Desconto
										Aadd(aPddm,{Str(nHoras,6,2),Substr(DescPd(SRR->RR_PD,SRA->RA_FILIAL,20),1,20),TransForm(SRR->RR_VALOR,"99,999,999.99"),SRR->RR_PD} )
									EndIf

									If cPaisLoc == "BOL"		//SE BOLIVIA, COLOCA EM aBol CAMPOS ESPECIfICOS PARA IMPRESSAO
										If SRR->RR_PD $ cVerCodFol
											Aadd(aBol,{PosSRV(SRR->RR_PD,SRA->RA_FILIAL,"RV_CODFOL"),DescPd(SRR->RR_PD,SRA->RA_FILIAL),Str(nHoras,6,2),SRR->RR_VALOR,If(SRR->(FieldPos("RR_MESMED"))> 0,SRR->RR_MESMED,Space(6))})
										//ID 9999 USADO PARA OBTER VALORES DA RESCISAO QUE NAO ESTIVERAM NA MEDIA DOS ULTIMOS 3 MESES
										//DESTE MODO O LIQUIDO DO TERMO DA RESCISAO SERA IGUAL AO LIQUIDO QUE FOI GERADO NO CALCULO
										ElseIf PosSRV(SRR->RR_PD,SRA->RA_FILIAL,"RV_TIPOCOD") == "1"
											Aadd(aBol,{"9999",DescPd(SRR->RR_PD,SRA->RA_FILIAL),Str(nHoras,6,2),SRR->RR_VALOR,If(SRR->(FieldPos("RR_MESMED"))> 0,SRR->RR_MESMED,Space(6))})
										EndIf
									EndIf
								EndIf

								If SRR->RR_PD == aCodfol[318,1]
									nRrValor := SRR->RR_VALOR
								EndIf
								SRR->(dbSkip())
							Enddo
						EndIf

						//CARREGA MATRIZ COM DADOS DA EMPRESA
						fInfo(@aInfo,SRA->RA_FILIAL)
						cCausa  	:= Space(30)
						cCodSaq 	:= "  "
						cImpSac 	:= " "
						cCodR		:= " "
						fCarrTab( @aTS019,"S019")

						If cPaisLoc == "MEX"
							nPos	:= fPosTab(cTabRes, SRG->RG_TIPORES, "==", 04)
							For nCont := 1 to Len(aTS019)
								If( aTS019[nCont][5] == fTabela(cTabRes,nPos,25) )
									cCausa := aTS019[nCont][6]
									Exit
								Endif
							Next
						Else
							nPos		:= fPosTab(cTabRes, SRG->RG_TIPORES, "==", 04)
							For nCont := 1 to Len(aTS019)
								If( aTS019[nCont][5] == fTabela(cTabRes,nPos,25) )
									cCausa := aTS019[nCont][6]
									Exit
								Endif
							Next
							If Empty(cCausa)
								cCausa := fTabela(cTabRes,nPos,5)
							EndIf
							cCodSaq		:= fTabela(cTabRes,nPos,19)
							cImpSac		:= fTabela(cTabRes,nPos,24)
							cAvPrevio	:= fTabela(cTabRes,nPos,07)
							cCodR		:= fTabela(cTabRes,nPos,17)

							//CODIGO DE MOVIMENTACAO DO FGTS
							//SE FUNCIONARIO ESTIVER DEMITIDO NO CADASTRO CONSIDERA AFASTAMENTO DO CADASTRO
							//CASO CONTRARIO UTILIZA O AFASTAMENTO DO TIPO DA RESCISAO PARAMETRO 32.
							cCodR 	:= If (SRA->RA_SITFOLH = "D" , SRA->RA_AFASFGT , cCodR)
							If cCodR == "I"
								cCodR := "I1"
							ElseIf cCodR == "U"
								cCodR := "U1"
							ElseIf cCodR == "1"
								cCodR := "U3"
							ElseIf cCodR == "2"
								cCodR := "I2"
							ElseIf cCodR == "3"
								cCodR := "I3"
							ElseIf cCodR == "4"
								cCodR := "I4"
							ElseIf cCodR =="N"
						   		cCodR := "N2"
							ElseIf cCodR =="5"
				   				cCodR := "N1"
							ElseIf cCodR =="V"
				   				cCodR := "U2"
							ElseIf cCodR =="9"
				   				cCodR := "S3"
							ElseIf cCodR =="S"
				   				cCodR := "S2"
							EndIf

							//CODIGO DA EMPRESA NO FGTS
							cCodFgts	:= Space(13)
							nPos		:= fPosTab(cTabRes, SRA->RA_TPCONTR, "==", 04)
							cCodFgts	:= fTabela(cTabRes, nPos, 13)

							//BUSCA PERCENTUAL DE PENSAO ALIMENTICIA NO CADASTRO DE BENEFICIARIOS
							aCodBenef := {}
							nPerPensa := 0
							aVPensao  := {}
							cPensao   := ""

							If(cPaisLoc == "BRA")
								nPerFGTS	:= 0
								aAreaSRQ	:= GetArea()
								//BUSCA BENEFICIARIOS DE ACORDO COM A FILIAL E MATRICULA ATUAL
								If SRQ->( DbSeek( cFilMat ) )
									While SRQ->(RQ_FILIAL+RQ_MAT) == cFilMat
										nPerFGTS+=SRQ->RQ_PERFGTS
										If !Empty(SRQ->RQ_VERBFOL)
											aAdd(avPensao,SRQ->RQ_VERBFOL)
										EndIf
										If !Empty(SRQ->RQ_VERBFER)
											aAdd(avPensao,SRQ->RQ_VERBFER)
										EndIf
										If !Empty(SRQ->RQ_VERB131)
											aAdd(avPensao,SRQ->RQ_VERB131)
										EndIf
										If !Empty(SRQ->RQ_VERB132)
											aAdd(avPensao,SRQ->RQ_VERB132)
										EndIf
										If !Empty(SRQ->RQ_VERBPLR)
											aAdd(avPensao,SRQ->RQ_VERBPLR)
										EndIf
										SRQ->(DBSKIP())
									Enddo
								EndIf
								RestArea(aAreaSRQ)
								If len(avPensao)<>0
									For nI := 1 to len(aVpensao)
										cPensao := cPensao + avPensao[nI]
										If nI < len(avPensao)
											cPensao := cPensao +"/"
										EndIf
									next nI
								EndIf
							EndIf

							cRotCalc := fGetCalcRot("4") //"FOL"
							fBusCadBenef(@aCodBenef,cRotCalc)
							For nI := 1 to len(aCodBenef)
								If ( aCodBenef[nI,15] == "S" ) //Apenas se Imprime % no Termo de Rescisao.
									nPerPensa += aCodBenef[nI,2]
								EndIf
							Next nI
						EndIf

						aBkpHomv:= aClone(aHomv)
						//Imprime o Numero de Vias EspecIficado
						SET CENTURY OFF
						For nImprVias := 1 to nNumVias
							aHomV:= aClone(aBkpHomv)

							If nTipo == 1
			    				If cPaisLoc == "BRA"
									If ExistBlock("IMPRESZ1")
										ExecBlock('IMPRESZ1',.F.,.F.)
									Else
										if lIMPRESZ
											ExecBlock('IMPRESZ',.F.,.F.)
										else
											GPER1002()
										endif
									EndIf
								Else
									GeraTitulo() // Carrega o nome dos titulos dos campos para impressao.
				    				If cPaisLoc == "MEX"
										If ExistBlock("IMPRESMEX")
											ExecBlock("IMPRESMEX",.F.,.F.)
										EndIf
				    				Else
										If lIMPLIfIN
											ExecBlock('IMPLIfIN',.F.,.F.)
										else
											GPER997()
										EndIf
									EndIf
								EndIf
							ElseIf nTipo == 2 .AND. cPaisLoc == "ANG"
						   		ExecBlock('IMPRESAN',.F.,.F.)
							ElseIf nTipo == 2 .AND. cPaisLoc == "COL"
						   		ExecBlock('IMPRESCOL',.F.,.F.)
							ElseIf nTipo == 2
								If ExistBlock("IMPRESG1")
									ExecBlock('IMPRESG1',.F.,.F.)
								Else
								   	If cPaisLoc <> "BOL"
										if lIMPRESG
											ExecBlock('IMPRESG',.F.,.F.)
										else
											GPER1000()
										endif
									Else
										ExecBlock('IMPRESBOL',.F.,.F.)
									EndIf
								EndIf
							ElseIf nTipo == 3
								If ExistBlock("IMPRESC1")
									ExecBlock('IMPRESC1',.F.,.F.)
								Else
									if lIMPRESC
										ExecBlock('IMPRESC',.F.,.F.)
									else
										GPER999()
									endif
								EndIf
							ElseIf nTipo == 4
								If ( ExistBlock("IMPRESGSP")  .and. lGestPubl )
									ExecBlock("IMPRESGSP" , .F. , .F.)
								EndIf
								If ExistBlock("IMPRESH1")
									ExecBlock('IMPRESH1',.F.,.F.)
								Else
									if lIMPRESH
										ExecBlock('IMPRESH',.F.,.F.)
									else
										GPER1001()
									endif
								Endif
							ElseIf nTipo == 5
								If ExistBlock("IMPGRFC1")
									ExecBlock('IMPGRFC1',.F.,.F.)
								Else
									if lIMPGRFC
										ExecBlock('IMPGRFC',.F.,.F.)
									else
										GPER994()
									endif
								EndIf
							EndIf
						Next nImprVias
						If nTData == 10
							SET CENTURY ON
						Else
							SET CENTURY OFF
						EndIf
					EndIf
				EndIf
			Next nImp
		EndIf
	ElseIf cPaisLoc == 'DOM'
		lSelec	:= .F.
		dbSelectArea("SRG")
		If SRG->(dbSeek(xFilial("SRG")+SRA->RA_MAT))
			While SRG->( !Eof() .And. ( cFilMat ) == ( RG_FILIAL + RG_MAT ) )

				cRecSRG:= SRG->(RECNO())

				If &(cSRG_B)
					DbSelectArea("SRC")
					DbSetOrder(nOrdSRC)
					DbSeek(SRA->(RA_FILIAL+RA_MAT+RA_PROCES)+cRoteir, .F.)
					If SRC->(Eof())
						cSvRoteir	:= cRoteir
					  	cRoteir 	:= fGetCalcRot('A')	// Aplicacao de Rescisao
					   	DbSeek(SRA->(RA_FILIAL+RA_MAT+RA_PROCES)+cRoteir, .F.)
					   	If SRC->(Eof())
					   	   cRoteir := cSvRoteir
					   	Else
					   		lSelec	:= .T.
					   	EndIf
					Else
						lSelec	:= .T.
					EndIf
					nProv := nDesc := nNProv := 0.00

					While SRC->(!Eof()) .And.	;
						 (SRC->RC_FILIAL + SRC->RC_MAT + SRC->RC_PROCES + SRC->RC_ROTEIR) == ;
						 (SRG->RG_FILIAL + SRG->RG_MAT + SRG->RG_PROCES + cRoteir)
						/*
						ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						³Consiste Filiais e Acessos                                             ³
						ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
						If SRC->(!(RC_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRC))
							dbSelectArea("SRC")
					      	SRC->( dbSkip() )
					       	Return
						EndIf

						/*
						ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						³Nao imprime valores Zerados                                            ³
						ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
						If (SRC->RC_VALOR == 0.00 )
							SRC->( dbSkip() )
							Return
						EndIf
						/*
						ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						³Verifica o Tipo da Verba e Carrega no aPd? correspondente              ³
						ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
						nHoras	:= If(SRC->RC_TIPO1=="H",fConvHoras(SRC->RC_HORAS,"1"),SRC->RC_HORAS)

						If PosSrv(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),"RV_TIPOCOD") == "1" //Provento
			           	Aadd(aPdv,{Str(nHoras,6,2),Substr(DescPd(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),20),1,20),Transform(SRC->RC_VALOR,"99,999,999.99"),SRC->RC_PD} )
	               		nProv += SRC->RC_VALOR
						Elseif PosSrv(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),"RV_TIPOCOD") == "2" .And. SRC->RC_PD # aCodfol[126,1]  // Desconto e Despreza Liq. da Rescisao
							Aadd(aPdd,{Str(nHoras,6,2),Substr(DescPd(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),20),1,20),Transform(SRC->RC_VALOR,"99,999,999.99"),SRC->RC_PD} )
							nDesc += SRC->RC_VALOR
						ElseIf PosSrv(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),"RV_TIPOCOD") == "3"
							Aadd(aPdpm,{Str(nHoras,6,2),Substr(DescPd(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),20),1,20),Transform(SRC->RC_VALOR,"99,999,999.99"),SRC->RC_PD} )
						ElseIf PosSrv(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),"RV_TIPOCOD") == "4"
							Aadd(aPddm,{Str(nHoras,6,2),Substr(DescPd(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),20),1,20),Transform(SRC->RC_VALOR,"99,999,999.99"),SRC->RC_PD} )
						EndIf

						SRC->( dbSkip() )
		          EndDo
	          EndIf
	         cRoteir := cRotP
	      		SRG->( dbSkip() )
	      EndDo
	      SRG->(DbGoTo(cRecSRG))
	      cRecSRG:=""
		EndIf

	Else
		dbSelectArea("SRG")
		If SRG->(dbSeek(cFilMat))
 			If SRG->RG_EFETIVA != "1"
				dDtDemi := SRG->RG_DATADEM
			EndIf
		EndIf

		lSelec	:= .F.
		DbSelectArea("SRC")
		DbSetOrder(nOrdSRC)
		DbSeek(SRA->(RA_FILIAL+RA_MAT+RA_PROCES)+cRoteir, .F.)
		If SRC->(Eof())
		  	cSvRoteir	:= cRoteir
		  	cRoteir 	:= fGetCalcRot('A')	// Aplicacao de Rescisao
		   	DbSeek(SRA->(RA_FILIAL+RA_MAT+RA_PROCES)+cRoteir, .F.)
		   	If SRC->(Eof())
		   	   cRoteir := cSvRoteir
		   	Else
		   		lSelec	:= .T.
		   	EndIf
		Else
			lSelec	:= .T.
		EndIf

		nProv := nDesc := nNProv := 0.00

		If lSelec
			While SRC->(!Eof()) .And.	;
					(SRC->RC_FILIAL + SRC->RC_MAT + SRC->RC_PROCES + SRC->RC_ROTEIR) == ;
					(SRA->RA_FILIAL + SRA->RA_MAT + SRA->RA_PROCES + cRoteir)
				//CONSISTE FILIAIS E ACESSOS
				If SRC->(!(RC_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRC))
					dbSelectArea("SRC")
					SRC->( dbSkip() )
					Return
				EndIf
				//NAO IMPRIME VALORES ZERADOS
				If (SRC->RC_VALOR == 0.00 )
					SRC->( dbSkip() )
					Loop
				EndIf
				//VERIfICA O TIPO DA VERBA E CARREGA NO aPd CORRESPONDENTE
				nHoras	:= If(SRC->RC_TIPO1=="H",fConvHoras(SRC->RC_HORAS,"1"),SRC->RC_HORAS)

				If cPaisLoc == "MEX"
					If PosSrv(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),"RV_TIPOCOD") == "1" //Provento
						Aadd(aPdv,{Str(nHoras,6,2),Substr(DescPd(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),20),1,20),TransForm(SRC->RC_VALOR,"99,999,999.99"),SRC->RC_PD} )
						nProv += SRC->RC_VALOR
					ElseIf PosSrv(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),"RV_TIPOCOD") == "2" .And. SRC->RC_PD # aCodfol[126,1]  // Desconto e Despreza Liq. da Rescisao
						Aadd(aPdd,{Str(nHoras,6,2),Substr(DescPd(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),20),1,20),TransForm(SRC->RC_VALOR,"99,999,999.99"),SRC->RC_PD} )
						nDesc += SRC->RC_VALOR
					ElseIf PosSrv(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),"RV_TIPOCOD") == "3" .And. cPaisLoc == "MEX" //Base Provento
						Aadd(aPdpm,{Str(nHoras,6,2),Substr(DescPd(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),20),1,20),TransForm(SRC->RC_VALOR,"99,999,999.99"),SRC->RC_PD} )
					ElseIf PosSrv(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),"RV_TIPOCOD") == "4" .And. cPaisLoc == "MEX" //Base Desconto
						Aadd(aPddm,{Str(nHoras,6,2),Substr(DescPd(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),20),1,20),TransForm(SRC->RC_VALOR,"99,999,999.99"),SRC->RC_PD} )
					EndIf
				ElseIf cPaisLoc == "ARG"
					If PosSrv(SRC->RC_PD,SRA->RA_FILIAL,"RV_TIPOCOD") == "1" .AND. ;
							!Empty(PosSrv(SRC->RC_PD,SRA->RA_FILIAL,"RV_CLASIf" )) .AND. PosSrv(SRC->RC_PD,SRA->RA_FILIAL,"RV_CLASIf" ) != "N"//Provento
						Aadd(aPdv, SRC->RC_PD + "   " + Substr(DescPd(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),20),1,20) + space(32) +Str(nHoras,6,2) + space(06)  + TransForm(SRC->RC_VALOR,"99,999,999.99") )
						nProv += SRC->RC_VALOR
					ElseIf PosSrv(SRC->RC_PD,SRA->RA_FILIAL,"RV_TIPOCOD") == "2" // Desconto e Despreza Liq. da Rescisao
						Aadd(aPdd, SRC->RC_PD + "   " + Substr(DescPd(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),20),1,20) + space(32) +Str(nHoras,6,2) + space(06)  + TransForm(SRC->RC_VALOR,"99,999,999.99") )
						nDesc += SRC->RC_VALOR
					ElseIf PosSrv(SRC->RC_PD,SRA->RA_FILIAL,"RV_TIPOCOD") == "1" .AND. ;
							!Empty(PosSrv(SRC->RC_PD,SRA->RA_FILIAL,"RV_CLASIf" )) .AND. PosSrv(SRC->RC_PD,SRA->RA_FILIAL,"RV_CLASIf" ) == "N" //NAO REMUNERATIVO
						Aadd(aPdn, SRC->RC_PD + "   " + Substr(DescPd(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),20),1,20) + space(32) +Str(nHoras,6,2) + space(06)  + TransForm(SRC->RC_VALOR,"99,999,999.99") )
						nNProv += SRC->RC_VALOR
					EndIf
				Else
					If PosSrv(SRC->RC_PD,SRA->RA_FILIAL,"RV_TIPOCOD") == "1" //Provento
						Aadd(aPdv, Str(nHoras,6,2) + " " + Substr(DescPd(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),20),1,20) + " " + TransForm(SRC->RC_VALOR,"99,999,999.99") )
						nProv += SRC->RC_VALOR
					ElseIf PosSrv(SRC->RC_PD,SRA->RA_FILIAL,"RV_TIPOCOD") == "2" .And. SRC->RC_PD # aCodfol[126,1]  // Desconto e Despreza Liq. da Rescisao
						Aadd(aPdd, Str(nHoras,6,2) + " " + Substr(DescPd(SRC->RC_PD,xFilial( "SRV", SRA->RA_FILIAL),20),1,20) + " " + TransForm(SRC->RC_VALOR,"99,999,999.99") )
						nDesc += SRC->RC_VALOR
					EndIf
				EndIf
				SRC->(dbSkip())
			EndDo
		EndIf
	EndIf

	If lSelec
		fInfo(@aInfo,SRA->RA_FILIAL)
		cCodSaq 	:= "  "
		cImpSac 	:= " "
		cCodR		:= " "
		If cPaisLoc == "MEX"
			cCausa := fDesc("SX5","27"+SRA->RA_TIPOAFA,"X5_DESCSPA",30)
		ElseIf cPaisLoc == "ARG"
			cCausa := fTabela("S012",1,5,SRG->RG_TIPORES)
		Else
			cCausa := Space(30)
		EndIf

		//IMPRIME O NUMERO DE VIAS ESPECIfICADO
		SET CENTURY OFF
		For nImprVias := 1 to nNumVias
			If nTipo == 1
				GeraTitulo() // Carrega o nome dos titulos dos campos para impressao.
				If cPaisLoc == "MEX"
					If ExistBlock("IMPRESMEX")
						ExecBlock("IMPRESMEX",.F.,.F.)
					EndIf
				ElseIf cPaisLoc == "DOM"
					If ExistBlock("IMPRESDOM")
						ExecBlock("IMPRESDOM",.F.,.F.)
					EndIf
				ElseIf cPaisLoc $ "COS|ARG|TRI"
					If ExistBlock("IMPRESGEN")
						ExecBlock("IMPRESGEN",.F.,.F.)
					EndIf
				EndIf
			EndIf
		Next nImprVias

		If nTData == 10
			SET CENTURY ON
		Else
			SET CENTURY OFF
		EndIf
	EndIf
	SRA->(dbSkip(1))
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    fBusRatSRR Autor ³ Winston Costa  ³ Data       ³ 21/02/19 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Busca valores rateados na tabela de rescisão (SRR)             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   fBusRatSRR                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³Generico                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fBusRatSRR()

Local aArea			:= GetArea()
Local sVerbAnt		:= '!!!'
Local sVerbAtu		:= ''
Local sCCAnt		:= "!!!!!!!!!"
Local sCCAtu		:= ''
Local lTemRatSRR	:= .F.
Local lItemClVl		:= SuperGetMv( "MV_ITMCLVL", .F., "2" ) $ "1*3" // Define se trabalha com item e classe contabil
Local cItemAnt		:= ""
Local cItemAtu		:= ""
Local cClvlAnt		:= ""
Local cClvlAtu		:= ""

dbSelectArea("SRR")
dbSetOrder(1)
dbGoTop()
If dbSeek ( xFilial("SRR") + SRA->RA_MAT + "R"+ DTOS(SRA->RA_DEMISSA) )
	While !Eof() .And. ( SRR->(RR_FILIAL + RR_MAT + "R" + DTOS(RR_DATA)) == xFilial("SRR") + SRA->RA_MAT + "R"+ DTOS(SRA->RA_DEMISSA) )
		sVerbAtu := SRR->RR_PD
		sCCAtu	 := SRR->RR_CC
		If lItemClVl
			cItemAtu	:= SRR->RR_ITEM
			cClvlAtu	:= SRR->RR_CLVL
		EndIf

		If sVerbAnt == sVerbAtu
			If sCCAnt != sCCAtu .Or. cItemAnt != cItemAtu .Or. cClvlAnt != cClvlAtu
				lTemRatSRR := .T.
				Exit
			Endif
		Else
			sVerbAnt := sVerbAtu
			sCCAnt	 := sCCAtu
			cItemAnt := cItemAtu
			cClvlAnt := cClvlAtu
		Endif
		dbSkip()
	End
Endif

RestArea(aArea)

Return(lTemRatSRR)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³fVldPerg³ Autor ³ Silvio C. Stecca  ³ Data       ³ 09/08/19 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Valida qual grupo de perguntas será usado.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³Generico                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fVldPerg()

	Local cPergOk := ""

	DbSelectArea("SX1")
	If IsInCallStack("GPEM040B") .And. SX1->(dbSeek("GPE140R2"))
		lGPEM040B := .T.
	EndIf

	// VERIFICA QUAL O GRUPO DE PERGUNTAS SERÁ USADO.
	Do Case
		Case cPaisLoc == 'DOM'
			cPergOk := 'GPER140'

		Case lGPEM040B
			cPergOk := "GPE140R2"

		Case cPaisLoc == 'BOL' .And. SX1->(dbSeek("GPE140R3"))
			lGrpR3	:= .T.
			cPergOk := "GPE140R3"

		OtherWise
			cPergOk := "GPE140R"
	EndCase

Return cPergOk
