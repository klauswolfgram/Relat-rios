/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prАtica e de fАcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.CH"
#INCLUDE "QNCR010.CH"
/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    Ё QNCR010  Ё Autor Ё Aldo Marini Junior    Ё Data Ё 08.03.00 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Relatorio de Plano de Acao                                 Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁSintaxe   Ё U_QNCR010(void)                                              Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё Generico                                                   Ё╠╠
╠╠цддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё         ATUALIZACOES SOFRIDAS DESDE A CONSTRU─AO INICIAL.             Ё╠╠
╠╠цддддддддддддбддддддддбддддддбдддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁProgramador Ё Data   Ё BOPS Ё  Motivo da Alteracao                     Ё╠╠
╠╠цддддддддддддеддддддддеддддддедддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁAldo        Ё22/08/01Ё 9495 Ё Alterado para imprimir cabecalho grafico Ё╠╠
╠╠ЁEduardo S.  Ё12/12/02Ё061393Ё Acerto para filtrar corretamente a etapa.Ё╠╠
╠╠ЁEduardo S.  Ё12/12/02Ё062109Ё Incluido o pergunta "Plano de Acao" (Pen-Ё╠╠
╠╠Ё            Ё        Ё      Ё dente / Baixado / Ambos).                Ё╠╠
╠╠юддддддддддддаддддддддаддддддадддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ*/
User Function QNCR010

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define Variaveis Locais (Basicas)                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Local cDesc1 	:= STR0001		//"Relatorio de Plano de Acao"
Local cDesc2 	:= STR0002		//"Ser═ impresso de acordo com os parametros solicitados pelo usuario."
Local cDesc3 	
Local cString	:= "QI3"       				// alias do arquivo principal (Base)
Local aOrd      := {STR0003,STR0004}		//"Ano+Plano de Acao+Revisao"###"Plano de Acao+Revisao"
Local wnRel

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define Variaveis Private(Basicas)                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Private aReturn  := { STR0005, 1,STR0006, 2, 2, 1,"",1 }	//"Zebrado"###"Administra┤└o"
Private nomeprog := "QNCR010"
Private aLinha   := {}
Private nLastKey := 0
Private cPerg    := "QNR010"
Private lFirst   := .T.

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis Utilizadas na funcao IMPR                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Private Titulo	 := STR0007		//"PLANO DE ACAO"
Private cCabec
Private AT_PRG  := "QNCR010"
Private wCabec0 := 3
Private wCabec1 := ""
Private	wCabec2	:= Padr("| ",131)+"|"
Private wCabec3 := ""
Private CONTFL  := 1
Private LI      := 0
Private nTamanho:= "M"
Private lTMKPMS := If(GetMv("MV_QTMKPMS",.F.,1) == 1,.F.,.T.)//Integracao do QNC com TMK e PMS: 1-Sem integracao,2-TMKxQNC,3-QNCxPMS,4-TMKxQNCxPMS Ё

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define Variaveis Private(Programa)                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Private nOrdem

INCLUI := .F.	// Utilizado devido algumas funcoes de retorno de descricao/nome
                                       	
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica as perguntas selecionadas                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
pergunte("QNR010",.F.)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis utilizadas para parametros                         Ё
//Ё mv_par01        //  Filial  De                               Ё
//Ё mv_par02        //  Filial  Ate                              Ё
//Ё mv_par03        //  Ano De                                   Ё
//Ё mv_par04        //  Ano Ate                                  Ё
//Ё mv_par05        //  Plano de Acao                            Ё
//Ё mv_par06        //  Plano de Acao                            Ё
//Ё mv_par07        //  Revisao De                               Ё
//Ё mv_par08        //  Revisao Ate                              Ё
//Ё mv_par09        //  Etapas 1-Pendentes/2-Baixadas/3-Ambas    Ё
//Ё mv_par10        //  Acoes 1-Corretiva/2-Preventiva/3-Melhoria/4-Ambas
//Ё mv_par11        //  Status Acoes 1-Registrada/2-Em Analise/3-Procede/4-Nao Procede/5-Cancelada/6-Ambas
//Ё mv_par12        //  FNC Relacionadas 1-Sim/2-Nao			 |
//Ё mv_par13        //  Plano de Acao (1=Pendente/2=Baixado/3=Ambos)
//Ё mv_par14        //  Imprime Custo? Sim/Nao                   |
//Ё mv_par15        //  Cliente De                               |
//Ё mv_par16        //  Loja De                                  |
//Ё mv_par17        //  Cliente Ate                              |
//Ё mv_par18        //  Loja Ate                                 |
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Envia controle para a funcao SETPRINT                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
wnrel:="QNCR010"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Carregando variaveis mv_par?? para Variaveis do Sistema.     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nOrdem   := aReturn[8]
cFilDe   := mv_par01
cFilAte  := mv_par02
cAnoDe   := mv_par03
cAnoAte  := mv_par04
cAcaoDe  := mv_par05
cAcaoAte := mv_par06
cRevDe   := mv_par07
cRevAte  := mv_par08
nEtapa   := mv_par09
nAcao    := mv_par10
cStatus  := mv_par11
nRelac   := mv_par12
cImpCus	 := mv_par14

If	nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If	nLastKey == 27
	Return
Endif

RptStatus({|lEnd| QNCR010Imp(@lEnd,wnRel,cString)},Titulo)

Return

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    ЁQNCR010ImpЁ Autor Ё Aldo Marini Junior    Ё Data Ё 08.03.00 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Imprime o Relatorio                                        Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁSintaxe e ЁQNCR010Imp(lEnd,wnRel,cString)                              Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁParametrosЁ lEnd        - A┤фo do Codelock                             Ё╠╠
╠╠Ё          Ё wnRel       - T║tulo do relat╒rio                          Ё╠╠
╠╠ЁParametrosЁ cString     - Mensagem                                     Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё QNCR010                                                    Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ*/
Static Function QNCR010Imp(lEnd,WnRel,cString)

Local aTipQI3 := {OemToAnsi(STR0008),OemToAnsi(STR0009),OemToAnsi(STR0010)}	// "Corretiva" ### "Preventiva" ### "Melhoria"
Local aStatus := {OemtoAnsi(STR0011),OemToAnsi(STR0012),OemToAnsi(STR0013),OemToAnsi(STR0014),OemToAnsi(STR0015)}	// "Registrada" ### "Em Analise" ### "Procede" ### "Nao Procede" ### "Cancelada"
Local cTxtDet := ""
Local aTxtDet := {}
Local lPend   := .F.
Local cFiltro := "" 
Local cIndex1 := CriaTrab( Nil, .f. )
Local nT
Local cDescDet:= ""
Local aDescDet:= {} 

Local aUsrMat	:= QNCUSUARIO()
Local cMatFil  	:= aUsrMat[2]
Local cMatCod	:= aUsrMat[3]
Local lSigiloso := .F. 
Local cCodCli   := ""
Local cLojCli   := ""
Local nMVQTMKPMS := GetMv("MV_QTMKPMS",.F.,1)

dbSelectArea( "QI3" )
If nOrdem == 1
	QI3->(dbSetOrder( 1 ))
ElseIf nOrdem == 2
	QI3->(dbSetOrder( 2 ))
EndIf

cFiltro:= '( QI3->QI3_ANO >= "'+ cAnoDe  +'" ) .And. '
cFiltro+= '( QI3->QI3_ANO <= "'+ cAnoAte +'" ) .And. '
cFiltro+= '( QI3->QI3_REV >= "'+ cRevDe  +'" ) .And. '
cFiltro+= '( QI3->QI3_REV <= "'+ cRevAte +'" ) .And. '
If !lTMKPMS 
	cFiltro+= '( Right(Alltrim(QI3->QI3_CODIGO),4) + Left(QI3->QI3_CODIGO,15) >= "'+ Right(Alltrim(cAcaoDe ),4) + Left(cAcaoDe ,15) + '" ) .And. '
	cFiltro+= '( Right(Alltrim(QI3->QI3_CODIGO),4) + Left(QI3->QI3_CODIGO,15) <= "'+ Right(Alltrim(cAcaoAte),4) + Left(cAcaoAte,15) + '" ) '
Else
	cFiltro+= '( Right(Alltrim(QI3->QI3_CODIGO),4) + Left(QI3->QI3_CODIGO,11) >= "'+ Right(Alltrim(cAcaoDe ),4) + Left(cAcaoDe ,11) + '" ) .And. '
	cFiltro+= '( Right(Alltrim(QI3->QI3_CODIGO),4) + Left(QI3->QI3_CODIGO,11) <= "'+ Right(Alltrim(cAcaoAte),4) + Left(cAcaoAte,11) + '" ) '
Endif

If mv_par13 == 1
	cFiltro+= ' .And. Empty(QI3->QI3_ENCREA)'
ElseIf mv_par13 == 2
	cFiltro+= ' .And. !Empty(QI3->QI3_ENCREA)'
EndIf

cFiltro+= ' .And. QI3->QI3_STATUS $ "'+ cStatus + '"'

QI3->(DbSeek(xFilial("QI3")))
If nOrdem == 1
	QI3->(dbSeek(IF((FWModeAccess("QI3") == "C"),xFilial("QI3"),cFilDe) + cAnoDe + cAcaoDe + cRevDe,.T.))
	cInicio  := "QI3->QI3_FILIAL + QI3->QI3_ANO + QI3->QI3_CODIGO + QI3->QI3_REV"
	cFim     := IF((FWModeAccess("QI3") == "C"),xFilial("QI3"),cFilAte) + cAnoAte + cAcaoAte + cRevAte
ElseIf nOrdem == 2
	QI3->(dbSeek(IF((FWModeAccess("QI3") == "C"),xFilial("QI3"),cFilDe) + cAcaoDe + cRevDe,.T.))
	cInicio  := "QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV"
	cFim     := IF((FWModeAccess("QI3") == "C"),xFilial("QI3"),cFilAte) + cAcaoAte + cRevAte
Endif

While !EOF() .And. &cInicio <= cFim
	If !&(cFiltro)
		QI3->(DbSkip())
		Loop
	EndIf

	lPend:= .F.

	If lEnd
		@Prow()+1,0 PSAY cCancel
		Exit
	Endif

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
 	//Ё Consiste o tipo de Plano de Acao                             Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If nAcao <> 4 .And. Val(QI3->QI3_TIPO) <> nAcao
		dbSkip()
		Loop
	Endif
          
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
 	//Ё Realiza o Filtro do Cliente                                  Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	QI2->(DbSetOrder(5))      //QI2_FILIAL+QI2_CODACA+QI2_REVACA                                
	If QI2->(DbSeek(xFilial("QI2")+QI3->QI3_CODIGO))
   		ADE->(DbSetOrder(1))  //ADE_FILIAL+ADE_CODIGO
		If ADE->(dbSeek(xFilial("ADE")+QI2->QI2_NCHAMA))
			If (AllTrim(ADE->ADE_CHAVE) < mv_par15+mv_par16 .OR. AllTrim(ADE->ADE_CHAVE) > mv_par17+mv_par18)
				QI3->(dbSkip())
				Loop
			Else
				cCodCli:= Left(ADE->ADE_CHAVE,TAMSX3("A1_COD")[1])
				cLojCli:= Substr(ADE->ADE_CHAVE,TAMSX3("A1_COD")[1]+1,TAMSX3("A1_LOJA")[1])
			Endif
		ElseIf QI2->(QI2_CODCLI+QI2_LOJCLI) < mv_par15+mv_par16 .Or. QI2->(QI2_CODCLI+QI2_LOJCLI) > mv_par17+mv_par18
			QI3->(dbSkip())
			Loop
		Else
			cCodCli:= QI2->QI2_CODCLI
			cLojCli:= QI2->QI2_LOJCLI
		Endif
	Endif

	If nEtapa == 1 // Pendente
		If QI5->(DbSeek(QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV))
			While QI5->(!Eof()) .And. QI5->QI5_FILIAL+QI5->QI5_CODIGO+QI5->QI5_REV == QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV
				If QI5->QI5_STATUS <> "4"
					lPend:= .T.
					Exit
				EndIf
				QI5->(DbSkip())
			EndDo		
		EndIf			

	ElseIf nEtapa == 2 // Baixada
		If QI5->(DbSeek(QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV))
			While QI5->(!Eof()) .And. QI5->QI5_FILIAL+QI5->QI5_CODIGO+QI5->QI5_REV == QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV
				If QI5->QI5_STATUS == "4"
					lPend:= .T.
					Exit
				EndIf
				QI5->(DbSkip())
			EndDo		
		EndIf			
	Else 
		lPend:= .T.
	EndIf

	If !lPend
		DbSkip()
		Loop
	EndIf

	WCabec1	:= Padr("| "+OemToAnsi(STR0016)+TransForm(QI3->QI3_CODIGO,PesqPict("QI3","QI3_CODIGO"))+"  "+;			// "No. "
				OemToAnsi(STR0017)+QI3->QI3_REV+"   "+OemToAnsi(STR0018)+PADR(DTOC(QI3->QI3_ABERTU),10)+;		// "Revisao: " ### "Data Abertura: "
				"   "+OemToAnsi(STR0019)+PADR(DTOC(QI3->QI3_ENCREA),10)+"   "+OemToAnsi(STR0020)+;	// "Data Encerramento: " ### "Acao "
				Padr(aTipQI3[Val(QI3->QI3_TIPO)],10),131)+"|"
				
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Verifica se hА IntegraГЦo TMK/QNC/PMS. Caso afirmativo Imprime o Nome/CСd Cliente   Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If (nMVQTMKPMS == 4)
		WCabec2	:= Padr("| "+OemToAnsi(STR0021)+Padr(QA_NUSR(QI3->QI3_FILMAT,QI3->QI3_MAT,.F.),30)+SPACE(2)+OemToAnsi(STR0022)+Padr(aStatus[Val(QI3->QI3_STATUS)],11)+; // "Responsavel: " ### "Status: "
							Space(2)+OemToAnsi(STR0041)+": "+cCodCli+"/"+cLojCli+"-"+FQNCDESCLI(cCodCli,cLojCli,"1"),131)+"|"
	Else
		WCabec2	:= Padr("| "+OemToAnsi(STR0021)+QA_NUSR(QI3->QI3_FILMAT,QI3->QI3_MAT,.F.)+SPACE(34)+OemToAnsi(STR0022)+aStatus[Val(QI3->QI3_STATUS)],131)+"|"	// "Responsavel: " ### "Status: "
	EndIf
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Verifica se Plano eh Sigiloso. Somente Responsavel (plano e etapas) pode Imprimir   Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды	
	lSigiloso := .f.

	If QI3->QI3_SIGILO == "1"	
		If cMatFil+cMatCod <> QI3->QI3_FILMAT+QI3->QI3_MAT 
			lSigiloso := .T.
			QI5->(dbSetOrder(1))
			If QI5->(dbSeek(QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV))
				While QI5->(!Eof()) .And. QI5->QI5_FILIAL+QI5->QI5_CODIGO+QI5->QI5_REV == QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV
					If QI5->QI5_FILMAT + QI5->QI5_MAT == cMatFil + cMatCod 
						lSigiloso := .f.
						Exit
					Endif
					QI5->(dbSkip())
				Enddo
			Endif							
		Endif
	Endif
	
	If lSigiloso
		QImpr("|-"+OemToAnsi(STR0038)+Replicate("-",114)+"|","C")		// "Dados Sigilosos"
		QImpr("|"+Space(130)+"|","C")
		nPos := TamSx3("QAA_NOME")[1]
		QImpr("| "+OemToAnsi(STR0039 + Posicione("QAA",1, QI3->QI3_FILMAT+QI3->QI3_MAT,"QAA_NOME")+ STR0040)+Space(78-nPos)+"|","C")		// "Acesso permitido a " ### " e aos responsАveis pelas etapas"
	Else

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
 	//Ё Imprime a Descricao Detalhada                                Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

	cTxtDet := MSMM(QI3->QI3_PROBLE)
	If !Empty(cTxtDet)
		aTxtDet := {}
		Q_MemoArray(cTxtDet, @aTxtDet, 128)
		If Len(aTxtDet) > 0
			QImpr("|-"+OemToAnsi(STR0023)+Replicate("-",110)+"|","C")		// "Descricao Detalhada"
			QImpr("|"+Space(130)+"|","C")
			For nT:=1 to Len(aTxtDet)
				QImpr("| "+aTxtDet[nT]+" |","C")
			Next
	    Endif
	Endif
    
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
 	//Ё Imprime a Descricao Resumida das Possiveis Causas            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If QI6->(dbSeek( QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV ))
		QImpr("|"+Space(130)+"|","C")
		QImpr("|-"+OemToAnsi(STR0024)+Replicate("-",113)+"|","C")				// "Possiveis Causas"
		QImpr(Padr("| "+OemToAnsi(STR0035),131)+"|","C")//"Causa                                                Descricao detalhada"
		QImpr("|"+Space(130)+"|","C")
		While !Eof() .And. QI6->QI6_FILIAL + QI6->QI6_CODIGO + QI6->QI6_REV == QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV
		   	cDescDet := MSMM(QI6->QI6_DESCR)

			If !Empty(cDescDet)
				aDescDet := {}
				Q_MemoArray(cDescDet, @aDescDet, 75)
				For nT:=1 to Len(aDescDet)
					If nT == 1
						QImpr(PADR("| "+QI6->QI6_SEQ+" "+FQNCNTAB("1",QI6->QI6_CAUSA)+Alltrim(aDescDet[nT]),131)+"|","C")	
					Else
						QImpr("| "+Space(53) +aDescDet[nT]+" |","C")
					Endif	
				Next
			Endif

			QI6->(dbSkip())
		Enddo
	Endif

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
 	//Ё Imprime as Etapas das Acoes                                  Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	IF QI5->(dbSeek( QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV ))
		QImpr("|"+Space(130)+"|","C")
		QImpr("|-"+OemToAnsi(STR0025)+Replicate("-",124)+"|","C")				// "Acoes"
		QImpr(Padr("| "+OemToAnsi(STR0026),131)+"|","C")  					// "Responsavel                    Previsao   Conclusao   Descricao"
		QImpr("|"+Space(130)+"|","C")
		While !Eof() .And. QI5->QI5_FILIAL + QI5->QI5_CODIGO + QI5->QI5_REV == QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV
         IF nEtapa == 3 .Or. ;
            ( nEtapa == 1 .And. QI5->QI5_STATUS <> "4" ) .Or. ;
            ( nEtapa == 2 .And. QI5->QI5_STATUS == "4" ) 
				QImpr(PADR("| "+PADR(QA_NUSR(QI5->QI5_FILMAT,QI5->QI5_MAT,.F.),30)+" "+PADR(DTOC(QI5->QI5_PRAZO),10)+" "+PADR(DTOC(QI5->QI5_REALIZ),10)+"  "+QI5->QI5_DESCRE,131)+"|","C")
			Endif
			QI5->(dbSkip())
		Enddo
	Endif

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
 	//Ё Imprime a Descricao do Resultado Esperado                    Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

	cTxtDet := MSMM(QI3->QI3_RESESP)
	If !Empty(cTxtDet)
		aTxtDet := {}
		Q_MemoArray(cTxtDet, @aTxtDet, 128)
		If Len(aTxtDet) > 0
			QImpr("|"+Space(130)+"|","C")
			QImpr("|-"+OemToAnsi(STR0027)+Replicate("-",111)+"|","C")		// "Resultado Esperado"
			QImpr("|"+Space(130)+"|","C")
			For nT:=1 to Len(aTxtDet)
				QImpr("| "+aTxtDet[nT]+" |","C")
			Next
	    Endif
	Endif
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
 	//Ё Imprime a Descricao do Resultado Atingido                    Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

	cTxtDet := MSMM(QI3->QI3_RESATI)
	If !Empty(cTxtDet)
		aTxtDet := {}
		Q_MemoArray(cTxtDet, @aTxtDet, 128)
		If Len(aTxtDet) > 0
			QImpr("|"+Space(130)+"|","C")
			QImpr("|-"+OemToAnsi(STR0028)+Replicate("-",111)+"|","C")		// "Resultado Atingido"
			QImpr("|"+Space(130)+"|","C")
			For nT:=1 to Len(aTxtDet)
				QImpr("| "+aTxtDet[nT]+" |","C")
			Next
	    Endif
	Endif

	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
 	//Ё Imprime as Fichas de Ocorrencias/Nao-conformidades Relacionadas Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды        
	QI2->(DbSetOrder(1))
	If nRelac == 1	// Sim
		If QI9->(dbSeek(QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV))
			QImpr("|"+Space(130)+"|","C")
			QImpr("|-"+OemToAnsi(STR0029)+Replicate("-",129-Len(OemToAnsi(STR0029)))+"|","C")		// "Ficha Ocorrencias/Nao-conformidades Relacionadas"	
			QImpr(Padr("| "+OemToAnsi(STR0030),131)+"|","C")				// "No.FNC.     Rv Originador                     Abertura   Descricao"
			QImpr("|"+Space(130)+"|","C")
			While !Eof() .And. QI9->QI9_FILIAL + QI9->QI9_CODIGO + QI9->QI9_REV == QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV
				IF QI2->(dbSeek(QI9->QI9_FILIAL+Right(QI9->QI9_FNC,4)+QI9->QI9_FNC+QI9->QI9_REVFNC))
					QImpr(Padr("| "+Transform(QI2->QI2_FNC,PesqPict("QI2","QI2_FNC"))+" "+QI2->QI2_REV+" "+;
						  Padr(QA_NUSR(QI2->QI2_FILMAT,QI2->QI2_MAT,.F.),30)+" "+;
						  PADR(DTOC(QI2->QI2_OCORRE),10)+" "+QI2->QI2_DESCR,131)+"|" , "C")
				Endif
				QI9->(dbSkip())
			Enddo
			Endif
		Endif	
		If mv_par14 == 1
			IF QI8->(dbSeek( QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV ))
				QImpr("|"+Space(130)+"|","C")
				QImpr("|"+OemToAnsi(STR0036)+Replicate("-",124)+"|","C")	// "Custos"
				QImpr(Padr("| "+OemToAnsi(STR0037),131)+"|","C")  			// "DescrГЦo           Vlr.Custo"
				QImpr("|"+Space(130)+"|","C")
				While !Eof() .And. QI8->QI8_FILIAL + QI8->QI8_CODIGO + QI8->QI8_REV == QI3->QI3_FILIAL + QI3->QI3_CODIGO + QI3->QI3_REV
					QImpr("| "+Padr(FQNCDSX5("QB",QI8->QI8_CUSTO),53)+STR(QI8->QI8_VLCUST,10,2)+Space(66)+"|")
					QI8->(dbSkip())
				Enddo
			Endif           
		Endif
    Endif
    IF Li < 60
		QImpr("|"+Space(130)+"|","C")	
		QImpr(" "+Replicate("-",130)+" ","C")
		QImpr("","P")
	Endif
	dbSkip()
Enddo

If !lFirst
	Roda(0," ",nTamanho)
Endif

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Devolve as ordens originais dos arquivos                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
RetIndex("QI3")
Set Filter to

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Apaga indices de trabalho                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cIndex1 += OrdBagExt()
Delete File &(cIndex1)

Set Device To Screen

If aReturn[5] == 1
	Set Printer To
	dbCommit()
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return Nil
