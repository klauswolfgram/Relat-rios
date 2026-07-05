/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER370.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER370  ³ Autor ³ R.H. - Fernando Joly       ³ Data ³ 06.05.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Boletim de Valores / Horas                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER370(void)                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS      ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Cecilia Car.³19/05/14³TPQAJ1     ³Incluido o fonte da 11 para a 12 e efetua-³±±
±±³            ³        ³           ³da a limpeza.                             ³±±
±±³Emerson Camp³25/07/14³TQDFMM     ³Ajuste na linha da função que estava maior³±±
±±³            ³        ³           ³que o limite que a linha suporta.         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER370()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1  := STR0001				//'Boletim de Valores / Horas'
Local cDesc2  := STR0002	//'Ser  impresso de acordo com os parametros solicitados pelo'
Local cDesc3  := STR0003	//'usu rio.'
Local cString := 'SRA' 					// alias do arquivo principal (Base)
Local aOrd    := { STR0004,STR0005,STR0006,STR0007 } //'Matricula'###'Centro de Custo'###'Nome'###'Chapa'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn  := { STR0008,1,STR0009,1,2,1,'',1 }	//'Zebrado'###'Administra‡„o'
Private NomeProg := 'GPER370'
Private aLinha   := {}
Private nLastKey := 0
Private cPerg    := 'GPR370'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aPosicao1 := {} // Array das posicoes
Private aTotCc1   := {}
Private aTotFil1  := {}
Private aTotEmp1  := {}
Private aInfo     := {}
Private aMes[14]
Private lDepSf	  := Iif(SRA->(FieldPos("RA_DEPSF"))>0,.T.,.F.)
Afill(aMes,0)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Utilizadas na funcao IMPR                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private Titulo   := STR0010		//'BOLETIM DE VALORES / HORAS'
Private AT_PRG   := 'GPER370'
Private wCabec0  := 0
Private Contfl   := 1
Private Li       := 0
Private nTamanho := 'M'
Private cPict1	:=	If (MsDecimais(1)== 2,"@E 999,999,999.99",TM(999999999,14,MsDecimais(1)))  // "@E 99,999,999,999.99
Private cPict2	:=	If (MsDecimais(1)== 2,"@E 99,999,999.99",TM(99999999,13,MsDecimais(1)))  // "@E 99,999,999,999.99

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	pergunte('GPR370',.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                         ³
	//³ mv_par01        //  Filial De                                ³
	//³ mv_par02        //  Filial Ate                               ³
	//³ mv_par03        //  Centro de Custo De                       ³
	//³ mv_par04        //  Centro de Custo Ate                      ³
	//³ mv_par05        //  Matricula De                             ³
	//³ mv_par06        //  Matricula Ate                            ³
	//³ mv_par07        //  Nome De                                  ³
	//³ mv_par08        //  Nome At‚                                 ³
	//³ mv_par09        //  Chapa de                                 ³
	//³ mv_par10        //  Chapa At‚                                ³
	//³ mv_par11        //  Impr. Salario                            ³
	//³ mv_par12        //  Situacoes                                ³
	//³ mv_par13        //  Categorias                               ³
	//³ mv_par14        //  Quebra de p gina por Centro de Custo     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cTit := STR0010			//'BOLETIM DE VALORES / HORAS'

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Envia controle para a funcao SETPRINT                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	WnRel :='GPER370' //Nome Default do relatorio em Disco
	WnRel :=SetPrint(cString,WnRel,cPerg,cTit,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)

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
	nImpSal    := mv_par11
	cSituacao  := mv_par12
	cCategoria := mv_par13
	lSalta	  := If( mv_par14 == 1 , .T. , .F. )	//  Salta Pagina Quebra C.Custo

	Titulo  := STR0011		//'       BOLETIM DE VALORES / HORAS          '

	If nLastKey == 27
		Return Nil
	Endif
	SetDefault(aReturn,cString)
	If nLastKey == 27
		Return Nil
	Endif

	RptStatus({|lEnd| GR370Imp(@lEnd,WnRel,cString)},titulo)

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³ GPER370  ³ Autor ³ R.H. - Fernando Joly  ³ Data ³ 04.01.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Boletim de Valores / Horas                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER370(lEnd,WnRel,cString)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - A‡Æo do Codelock                             ³±±
±±³          ³ WnRel       - T¡tulo do relat¢rio                          ³±±
±±³Parametros³ cString     - Mensagem                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Gen‚rico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GR370Imp(lEnd,WnRel,cString)
Local Aux1     := STR0012			//'|  C O D  TIPO   HORAS          V A L O R '
Local Aux2     := '| I_____I I__I I______I I________________I '
Local cFilAnt  := replicate("!", FWGETTAMFILIAL)
Local cCcAnt   := '!!!!!!!!!'
Local cAcessaSRA:= &("{ || " + ChkRH("GPER370","SRA","2") + "}")
Local cAcessaSRC:= &("{ || " + ChkRH("GPER370","SRC","2") + "}")
Local nLenStr	:= 0

Local aOfusca	:= If(FindFunction('ChkOfusca'), ChkOfusca(), { .T., .F., {} }) //[1]Acesso; [2]Ofusca; [3]Mensagem
Local lOfusca	:= aOfusca[2] .And. !Empty( FwProtectedDataUtil():UsrNoAccessFieldsInList( {"RA_NOME"} ) )

dbSelectArea('Sra')
SetRegua(Sra->(RecCount()))

If nOrdem == 1
	dbSetOrder(1)
ElseIf nOrdem == 2
	dbSetOrder(2)
ElseIf nOrdem == 3
	dbSetOrder(3)
ElseIf nOrdem == 4
	dbSetOrder(1)
Endif

SRA->(dbGoTop())

If nOrdem == 1
	dbSeek(cFilDe + cMatDe,.T.)
	cInicio := SRA->RA_FILIAL + SRA->RA_MAT
	cFim    := cFilAte + cMatAte
ElseIf nOrdem == 2
	dbSeek(cFilDe + cCcDe + cMatDe,.T.)
	cInicio := SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT
	cFim    := cFilAte + cCcAte + cMatAte
ElseIf nOrdem == 3
	dbSeek(cFilDe + cNomeDe + cMatDe,.T.)
	cInicio := SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT
	cFim    := cFilAte + cNomeAte + cMatAte
ElseIf nOrdem == 4
	dbSeek(cFilDe + cMatDe,.T.)
	cInicio := SRA->RA_FILIAL + SRA->RA_MAT
	cFim    := cFilAte + cMatAte
Endif

If nOrdem == 4
	cIndCond:= 'SRA->RA_FILIAL + SRA->RA_CHAPA'
	cFor :='(SRA->RA_FILIAL + SRA->RA_CHAPA >= cFilDe + cChapaDe) '
	cFor +='.And. (SRA->RA_FILIAL + SRA->RA_CHAPA <= cFilAte + cChapaAte)'
Endif

If nOrdem == 4
	cArqNtx  := CriaTrab(Nil,.F.)
	IndRegua('SRA',cArqNtx,cIndCond,,cFor,'Selecionando Registros...')
Endif

While !SRA->(Eof()) .And. &(SRA->(IndexKey())) <= cFim
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta Regua Processamento                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IncRegua()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Aborta Impresao ao se clicar em cancela			               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lEnd
		@ Prow()+1,0 pSay cCancela
		Exit
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste Parametriza‡Æo do Intervalo de ImpressÆo            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (SRA->RA_CHAPA < cChapaDe) .Or. (SRA->RA_CHAPA > cChapaAte) .Or. ;
		(SRA->RA_NOME < cNomeDe)   .Or. (SRA->RA_NOMe > cNomeAte)   .Or. ;
		(SRA->RA_MAT < cMatDe)     .Or. (SRA->RA_MAT > cMatAte)     .Or. ;
		(SRA->RA_CC < cCcDe)       .Or. (SRA->RA_CC > cCCAte)
		fTestaTotal()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste Parametriza‡Æo de Situa‡Æo e Categoria              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !(SRA->RA_SITFOLH $ cSituacao) .Or. !(SRA->RA_CATFUNC $ cCategoria)
		ftestaTotal()
		Loop
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste controle de acessos e filiais validas               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
		fTestaTotal()
		Loop
	EndIf

	If Li >= 50
		Impr('','P')
	Endif

	Det := STR0013+SRA->RA_Filial+STR0014+Sra->Ra_Mat+STR0015+Sra->Ra_Chapa 		//'| FIL.: '###' MAT.: '###' CHAPA: '
	Det += iIf((nLenStr:=Len(Det))>=47, "", Space(47-nLenStr)) + Aux1 + Aux1
	Impr(Det,'C')

	Det := STR0016 + Iif( lOfusca, Replicate('*',30), Subs(SRA->RA_NOME,1,30) )
	Det += iIf((nLenStr:=Len(Det))>=47, "", Space(47-nLenStr)) + Aux2 + Aux2		//'| NOME: '
	Impr(Det,'C')

	Det := STR0017+Subs(AllTrim(Sra->Ra_CC)+'-'+DescCc(Sra->Ra_Cc,Sra->Ra_Filial),1,26) 		//'| CCTO: '
	Det += iIf((nLenStr:=Len(Det))>=47, "", Space(47-nLenStr)) + Aux2 + Aux2
	Impr(Det,'C')

	If nImpSal == 1
		nSalario := Transform(Sra->Ra_Salario,cPict1)
	Else
		nSalario := Space(14)
	Endif

	Det := STR0018+ nSalario +STR0019		//'| SAL: '###' CATEG: '
	Det += fDesc("SX5","28"+SRA->RA_CATFUNC,"X5DESCRI()",11,SRA->RA_FILIAL)
	Det += iIf((nLenStr:=Len(Det))>=47, "", Space(47-nLenStr)) + Aux2 + Aux2
	Impr(Det,'C')

	If lDepSf
		Det := STR0024 + Sra->Ra_DepIR +STR0025 + Sra->Ra_DepSF +STR0026 	//'| DEP.IR: '###'  DEP.SF: '###'  N.HOR: '
	Else
		Det := STR0024 + Sra->Ra_DepIR +STR0026 	//'| DEP.IR: '###'  DEP.SF: '###'  N.HOR: '
	EndIf
	Det += Transform(Sra->Ra_HrsMes,'999') + STR0027 + Sra->Ra_SitFolh // ' SIT.: '
	Det += iIf((nLenStr:=Len(Det))>=47, "", Space(47-nLenStr)) + Aux2 + Aux2
	Impr(Det,'C')

  	Det := STR0028+SRA->RA_CODFUNC+'-'+DescFun(SRA->RA_CODFUNC,SRA->RA_FILIAL)	//'| FUNCAO: '
	Det += iIf((nLenStr:=Len(Det))>=47, "", Space(47-nLenStr)) + Aux2 + Aux2
	Impr(Det,'C')

	Det := STR0029 						//'| COD PR         VALOR   COD PR         VALOR  '
	Det += iIf((nLenStr:=Len(Det))>=47, "", Space(47-nLenStr)) + Aux2 + Aux2
	Impr(Det,'C')

	SRC->(dbSetOrder(1))
	SRC->(dbSeek(SRA->RA_FILIAL+SRA->RA_MAT,.F.))
	Det   := ''
	Cont  := 0
	QTCod := 0

	If Src->(Found())
		While !Src->(Eof()) .And. Src->Rc_Filial+Src->Rc_Mat == Sra->Ra_Filial+Sra->Ra_Mat

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Consiste controle de acessos								 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Eval(cAcessaSRC)
				dbSkip()
				Loop
			EndIf

			If Src->Rc_Parcela # 0
				Det += ' ' + Src->Rc_PD+' '+Transform(Src->Rc_Parcela,'99')
				Det += ' ' + Transform(Src->Rc_Valor,cPict2) + Space(2)
				Cont++
				SRC->(dbSkip(1))
			Else
				SRC->(dbSkip(1))
			EndIf

			If Cont == 2
				Det := '|' + Det + Aux2 + Aux2
				Impr(Det,'C')
				QTCod ++
				Cont := 0
				Det  := ''
			EndIf
		EndDo
	EndIf

	If Cont == 1
		Det  := '|' + Det + Space(23) + Aux2 + Aux2
		Impr(Det,'C')
		QTCod ++
	EndIf

	While QTCod < 3
		Det := '|' + Space(46) + Aux2 + Aux2
		Impr(Det,'C')
		QTCod ++
	EndDo

	Impr(Replicate('-',132),'C')
	fTestaTotal()
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do Relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( 'SRA' )
Set Filter to
If nOrdem == 4
	RetIndex('SRA')
Endif
dbSetOrder(1)

If nOrdem == 4 .And. File( cArqNtx + OrdBagExt() )
	fErase( cArqNtx + OrdBagExt() )
Endif

Set Device To Screen

If aReturn[5] == 1
	Set Printer To
	dbCommit()
	OurSpool(WnRel)
Endif

MS_Flush()

Return Nil

*---------------------------------------------------
static function fTestaTotal()
*---------------------------------------------------
dbSelectArea("SRA")
cFilAnt  := SRA->RA_FILIAL
cCcAnt   := SRA->RA_CC
SRA->(dbSkip(1))
If (SRA->RA_FILIAL # cFILANT .and. nOrdem # 2)  .or. eof()
	If eof()
		Impr('','F')
	Else
		Impr(' ','P')
	Endif
ElseIf SRA->RA_CC # cCcAnt .And. nOrdem == 2  .and. !eof()
	If lSalta
		Impr('','P')
	Endif
Endif
Return
