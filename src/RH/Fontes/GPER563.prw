/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "GPER563.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER563   ºAutor  ³Alexandre Silva	 º Data º  02/04/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gera o arquivo de exportacao para o programa SIREN          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Liquidacion - Republica Dominicana                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºProgramador ³ Data   ³ BOPS ³  Motivo da Alteracao                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºLuiz Gustavo|29/01/07³116748³Retiradas funcoes de ajuste de dicionario.º±±  
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programador  ³ Data     ³ FNC            ³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³±±
±±³Rogerio R.   ³29/07/2009³00000018278/2009³Compatibilizacao dos fontes para aumento do³±±
±±³             ³          ³                ³campo filial e gestão corporativa.         ³±±
±±³Alex         ³05/11/2009³00000026596/2009³Adaptação Gestão Corporativa               ³±±
±±³             ³          ³                ³                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER563()

Private NomeProg 	:= "GPER563"
Private WnRel		:=	"GPER563"    //Nome Default do relatorio em Disco
Private cPerg    	:= "GPR563"
Private Titulo		:= FunDesc()


/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Variaveis utilizadas para parametros                         ³
  ³ mv_par01        //  Filial De                                ³
  ³ mv_par02        //  Filial Ate                               ³
  ³ mv_par03        //  Centro de Custo De                       ³
  ³ mv_par04        //  Centro de Custo Ate                      ³
  ³ mv_par05        //  Matricula De                             ³
  ³ mv_par06        //  Matricula Ate                            ³
  ³ mv_par07        //  Nome De                                  ³
  ³ mv_par08        //  Nome Ate                                 ³
  ³ mv_par09        //  Chapa De                                 ³
  ³ mv_par10        //  Chapa Ate                                ³
  ³ mv_par11        //  Situa‡äes                                ³
  ³ mv_par12        //  Categorias                               ³ 
  ³ mv_par13        //  Ordem de impressao do relatorio          ³
  ³ mv_par14        //  Perido que desejado do relatorio.        ³
  ³ mv_par15        //  Opcao completo ou atualizacao            ³
  ³ mv_par16        //  Verbas que compoem o valor do salario.   ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/

If Pergunte("GPR563",.T.)
	RptStatus({|lEnd| U_GPER563Imp(@lEnd,wnRel,"SRA")},Titulo)
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER563Imp   ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao do Relatorio.                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER563Imp(lEnd,wnRel,cAlias)

Local	cFilDe    	:= mv_par01
Local cFilAte   	:= mv_par02
Local cCcDe     	:= mv_par03
Local cCcAte    	:= mv_par04
Local cMatDe    	:= mv_par05
Local cMatAte   	:= mv_par06
Local cNomeDe   	:= mv_par07
Local cNomeAte  	:= mv_par08
Local cChapaDe  	:= mv_par09
Local cChapaAte 	:= mv_par10
Local cSituacao 	:= mv_par11
Local cCategoria	:= mv_par12
Local nOrdem     	:= mv_par13
Local cPeriodo   	:= mv_par14
Local nOpcao		:= mv_par15
Local nArquivo		:= 00
Local cInicio  	:= ""
Local cFim			:= ""
Local cArqGravar 	:= ""
Local cSitFunc		:= ""
Local cFilialAnt 	:= Space(FWGETTAMFILIAL)
Local cFuncaoAnt 	:= Space(4)
Local cCcAnt     	:= Space(9)
Local cMatAnt    	:= Space(6)
Local dDtPesqAf	:= Ctod("")
Local aInfoFil		:= {}
Local aCodFol		:= {}
Local	lPerNome 	:= .T.		

Private cForNome	:= GetNewPar("MV_FORNOME","N M S ") //Formato do nome
Private nVlrAtu	:= 0.00

dbSelectArea( "SRA" )
If nOrdem == 1
	dbSetOrder( 1 )
ElseIf nOrdem == 2
	dbSetOrder( 2 )
ElseIf nOrdem == 3
	dbSetOrder(3)
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
Endif

SetRegua(SRA->(RecCount()))

cFilialAnt 	:= Space(FWGETTAMFILIAL)
cFuncaoAnt 	:= Space(4)
cCcAnt     	:= Space(9)
cMatAnt    	:= Space(6)

While !EOF() .And. &cInicio <= cFim .And.(SRA->RA_FILIAL+SRA->RA_MAT <> cFilialAnt+cMatAnt)

  	IncRegua()  // Incrementa a regua

   If lEnd
		@Prow()+1,0 PSAY cCancel
		Exit
	Endif

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  |        Incio Consistencia da Parametrizacao do Intervalo de Impressao          |
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If (SRA->RA_CHAPA < cChapaDe).Or. (SRA->Ra_CHAPa > cChapaAte).Or. ;
	   (SRA->RA_NOME < cNomeDe)  .Or. (SRA->Ra_NOME > cNomeAte)  .Or. ;
	   (SRA->RA_MAT < cMatDe)    .Or. (SRA->Ra_MAT > cMatAte)    .Or. ;
	   (SRA->RA_CC < cCcDe)      .Or. (SRA->Ra_CC > cCcAte)
		SRA->(dbSkip(1))
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica Data Demissao         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSitFunc := SRA->RA_SITFOLH
	dDtPesqAf:= CTOD("01/" + Substr(cPeriodo,3,2) +  "/" + Left(cPeriodo,4),"DDMMYY")
	If cSitFunc == "D" .And. (!Empty(SRA->RA_DEMISSA) .And. MesAno(SRA->RA_DEMISSA) > MesAno(dDtPesqAf))
		cSitFunc := " "
	Endif	
	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  ³ Consiste situacao e categoria dos funcionarios			        |
	  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If !( cSitFunc $ cSituacao ) .OR. !( SRA->RA_CATFUNC $ cCategoria )
	   SRA->(dbSkip())
	   Loop
	Endif
  
	If SRA->RA_FILIAL # cFilialAnt
		If ! Fp_CodFol(@aCodFol,Sra->Ra_Filial) .Or.  ! fInfo(@aInfoFil,Sra->Ra_Filial)
			Exit
		Endif
	   cFilialAnt := SRA->RA_FILIAL
	Endif

	If SRA->RA_CODFUNC # cFuncaoAnt           // Descricao da Funcao
		DescFun(Sra->Ra_Codfunc,Sra->Ra_Filial)
		cFuncaoAnt:= Sra->Ra_CodFunc
	Endif

	If SRA->RA_CC # cCcAnt                   // Centro de Custo
		DescCC(Sra->Ra_Cc,Sra->Ra_Filial)
		cCcAnt:=SRA->RA_CC
	Endif
	
	If MesAno(SRA->RA_ADMISSA) >= cPeriodo
		SRA->(dbSkip())		
		Loop		
	EndIf

	If	nOpcao == 2 .And. ! VerAlteracao(cPeriodo) 
		SRA->(dbSkip())
		Loop		
	Else
		If SRA->RA_CATFUNC == "M"						//Completa
			nVlrAtu := SRA->RA_SALARIO
		ElseIf SRA->RA_CATFUNC $ "H*T*G"
			nVlrAtu := SRA->RA_SALARIO * SRA->RA_HRSMES
		ElseIf SRA->RA_CATFUNC $ "D"
			nVlrAtu := ( SRA->RA_SALARIO * (SRA->RA_HRSMES/SRA->RA_HRSDIA) )
      Endif
	EndIf

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  |        Fim Consistencia da Parametrizacao do Intervalo de Impressao   		     |
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If Empty(cArqGravar) .And.	lPerNome 
		cArqGravar := cGetFile(STR0001,OemToAnsi(STR0002),,"C:\",.T.,GETF_LOCALHARD) //"Arquivo Texto|*.TXT"###"Salvar Pesquisa..."
		nArquivo := fOpen(cArqGravar,1)
		If nArquivo == -1 .And. !Empty(cArqGravar)
			nArquivo := fCreate(cArqGravar)
		Else
			lPerNome := .F.		
		Endif
	EndIf
	If nArquivo != 0 .And. nVlrAtu > 0
		GPER563Txt(nArquivo)
	EndIf			
	SRA->(dbSkip())
Enddo

If nArquivo != 0
	fClose(nArquivo)
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER563Txt   ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a geracao do Arquivo de exportacao no formato TXT.     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GPER563Txt(nArquivo)

Local cLinha		:= ""
Local aNomes		:= GPRSepNome(SRA->RA_NOME)
Local cTipPag		:= "C|D|H|P|S|T"

If (ExistBlock("SEPNOME"))
	aNomes := ExecBlock("SEPNOME",.F.,.F.)
EndIf

cLinha	:= SRA->RA_TIPODOC	+ ";"
cLinha 	+= Trim(SRA->RA_RG)	+ ";" 
cLinha 	+= aNomes[1]			+ ";"
cLinha 	+= aNomes[2]			+ ";"
cLinha 	+= aNomes[3]			+ ";"
cLinha	+= StrTran(Trans(Day(SRA->RA_NASC),"99")," ","0")
cLinha	+= StrTran(Trans(Month(SRA->RA_NASC),"99")," ","0")
cLinha	+= Alltrim(Str(Year(SRA->RA_NASC)))			+ ";" 
cLinha 	+= Alltrim(SRA->RA_NSEGURO)						+ ";" 
cLinha	+=	AllTrim(Trans(nVlrAtu,"@R 9999999.99"))	+ ";" 
cLinha	+= Iif(SRA->RA_CATFUNC $ cTipPag,"V","F")

If nArquivo != -1
	fSeek(nArquivo,0,2)
	fWrite(nArquivo,cLinha+chr(13)+chr(10)) 
EndIf

Return 

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ VerAlteracao ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se houve alteracao no salario do fuuncionario.    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function VerAlteracao(cPeriodo)

Local lRet		:= .F.  //Indica se houve alteracao no salario em determinado periodo     

nMes := Val(Substr(cPeriodo,5,2))
nAno := Val(Substr(cPeriodo,1,4))
If nMes == 1
	nMes := 12
	nAno := nAno - 1
Else
	nMes -= 1
Endif

If SRA->RA_CATFUNC == "M"						
	nVlrAtu := SRA->RA_SALARIO
ElseIf SRA->RA_CATFUNC $ "H*T*G"
	nVlrAtu := SRA->RA_SALARIO * SRA->RA_HRSMES
ElseIf SRA->RA_CATFUNC $ "D"
	nVlrAtu := ( SRA->RA_SALARIO * (SRA->RA_HRSMES/SRA->RA_HRSDIA) )
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica alteracao de salario³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If SR7->(dbSeek(SRA->RA_FILIAL+SRA->RA_MAT))
	Do While SRA->RA_FILIAL+SRA->RA_MAT == SR7->R7_FILIAL+SR7->R7_MAT
		If MesAno(SR7->R7_DATA) == cPeriodo .And. nVlrAtu > 0
			lRet := .T.
			Exit
		EndIf			
		SR7->(dbSkip())
		Loop
	EndDo
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se o funcionario foi admitido ou demitido no periodo³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MesAno(SRA->RA_ADMISSA) == cPeriodo .or. MesAno(SRA->RA_DEMISSA) == cPeriodo
	lRet := .T.
Endif

Return lRet

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ LoadConcepto ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Soma o total de recebimentos no mes com base no parametro  ³±±
±±³          ³ 16                                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function LoadConcepto(cPeriodo)

Local nValor 		:= 0
Local cConcptos	:= ""
Local cCorteCon	:= Alltrim(mv_par16)
Local nX

For nX = 1 to Len(mv_par16) Step 3
	cConcptos += Left(cCorteCon,3) + "|" 
	cCorteCon := SubStr(cCorteCon,4)	
Next nX

SRD->(dbSetOrder(1))
SRD->(dbSeek(xFilial("SRD")+SRA->RA_MAT+cPeriodo,.T.))

Do While SRA->RA_FILIAL == SRD->RD_FILIAL .And. SRA->RA_MAT == SRD->RD_MAT .And. SRD->RD_DATARQ == cPeriodo
	If SRD->RD_PD $ cConcptos 
		nValor += SRD->RD_VALOR
	EndIf
	SRD->(dbSkip())
EndDo

Return nValor
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPRSepNome   ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a separacao de nome,nome do meio e sobre nome.         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GPRSepNome(cNome)

Local cSepara1		:= Substr(cForNome,02,1) //Separador inicial.
Local cSepara2		:= Substr(cForNome,04,1) //Separador do nome do meio.
Local nNomeIni		:= At("N",cForNome)
Local nNomeMeio 	:= At("M",cForNome)
Local aNomeSep		:= {"","",""}//Nome, Nome do Meio, Sobre Nome.
Local aAuxCorte	:= {"","",""}
Local nPosCorte	:= 0

nPosCorte := At(cSepara1,cNome)-1
If nPosCorte > 0
	aAuxCorte[01]	:= Substr(cNome,1,nPosCorte)
	cNome				:= Alltrim(Right(cNome,Len(cNome)-1-Len(aAuxCorte[01])))
	nPosCorte 		:= 0
	nPosCorte 		:= At(cSepara2,aAuxCorte[01])
	If nPosCorte > 0
		aAuxCorte[01]:= Left(aAuxCorte[01],nPosCorte-1)
	EndIf
	nPosCorte 		:= 0
EndIf
nPosCorte:= Rat(cSepara2,cNome)
If nPosCorte > 0
	aAuxCorte[03]:= Substr(cNome,nPosCorte+1,Len(cNome)- nPoscorte)
	cNome		:= Left(cNome,Len(cNome)- Len(aAuxCorte[03])-1)
EndIf
If !Empty(cNome)
	aAuxCorte[02]	:= cNome
EndIf

Do Case
	Case Empty(aAuxCorte[03])
		If nNomeIni > nNomeMeio
			aNomeSep[01] := Alltrim(aAuxCorte[02])
			aNomeSep[02] := Alltrim(aAuxCorte[01])
		Else
			aNomeSep[01] := Alltrim(aAuxCorte[01])
			aNomeSep[02] := Alltrim(aAuxCorte[02])
		EndIf
	Case nNomeIni == 1
		aNomeSep[01] := Alltrim(aAuxCorte[01])
		If nNomeMeio == 3
			aNomeSep[02] := Alltrim(aAuxCorte[02])
			aNomeSep[03] := Alltrim(aAuxCorte[03])
		Else
			aNomeSep[02] := Alltrim(aAuxCorte[03])
			aNomeSep[03] := Alltrim(aAuxCorte[02])
		EndIf
	Case nNomeIni == 3
		aNomeSep[01] := Alltrim(aAuxCorte[02])
		If nNomeMeio == 1
			aNomeSep[02] := Alltrim(aAuxCorte[01])
			aNomeSep[03] := Alltrim(aAuxCorte[03])
		Else
			aNomeSep[02] := Alltrim(aAuxCorte[03])
			aNomeSep[03] := Alltrim(aAuxCorte[01])
		EndIf
	Case nNomeIni == 5
		aNomeSep[01] := Alltrim(aAuxCorte[03])
		If nNomeMeio == 3
			aNomeSep[02] := Alltrim(aAuxCorte[02])
			aNomeSep[03] := Alltrim(aAuxCorte[01])
		Else
			aNomeSep[02] := Alltrim(aAuxCorte[01])
			aNomeSep[03] := Alltrim(aAuxCorte[02])
		EndIf
EndCase

Return aNomeSep

