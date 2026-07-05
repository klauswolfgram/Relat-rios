/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Matr921.ch"
/*

ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Matr921      ³Autor³ Juan Jose Pereira    ³ Data ³ 07.01.97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime listagem para transcricao manual de entradas/saidas ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcelo Pim.³24/11/97³13523A³ Ajustar incremento de controle de paginas³±±
±±³Eduardo     ³26/05/98³15671A³ Impressao de valores com F4_LIPI == Z    ³±±
±±³M.Simidu    ³15/06/98³XXXXXX³ Ajustes na impressao de valores Zerados. ³±±
±±³M.Simidu    ³03/11/98³XXXXXX³ Acertos no ano para 4 bytes.             ³±±
±±³M.Simidu    ³10/11/98³18744A³ Impressao de ICMS isentas/outros.        ³±±
±±³Andreia     ³27/01/99³19443A³ Correcao de bound error quando icms isen-³±±
±±³            ³        ³      ³ to e com base de calculo reduzida.       ³±±
±±³Andreia     ³06/05/99³20734A³ Tratamento da impressao do nome do forne-³±±
±±³            ³        ³      ³ cedor quando nota fiscal de entrada com  ³±±
±±³            ³        ³      ³ formulario proprio.                      ³±±
±±³Andreia     ³23/11/99³24026a³ Impressao de ICMS isentas.               ³±± 
±±³Eduardo Fer.³27/09/06³XXXXXX³ Processamento por multiplas filiais      ³±±
±±³Marcos Kato ³07/07/09³16489 ³ Considerar a decricao do emitente para   ³±±
±±³            ³        ³      ³ Nota Fiscal Complementar - CH:SBVLJA     ³±±
±±³Vogas Júnior³22/02/18³Issue - DSERFIS2-2769 Ajuste da separacao infor- ³±±
±±³            ³        ³      ³ macao da base de calculo e aliquota.     ³±±
±±³Vogas Junior ³30/05/18³DSERFIS2-3691 (MATR920) Criado pergunte p/ sele ³±±
±±³            ³        ³      ³ cionar coluna para apresentar ICMS-ST.	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß 
*/
User Function MatR921
// Variaveis de controle de multiplas filiais
Local aFilsCalc := {} 
Local nForFilial
Local cFilBack  := cFilAnt
Local MVIsento	:= mv_par16

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa Variaveis            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                      
Private lEnd:=.F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Largura do campo de observacoes ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLargObs:= IIf(nTipoMov==2,24,20)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Largura do campo de cod.emitente³                                                           
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLargEmi:=42
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pictures de campos numericos ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPictVl:="@E 999,999,999,999.99"	// Colunas Valores
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recebe layout do modelo escolhido ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aL:=NIL
R921LayOut()

aFilsCalc := MatFilCalc(MV_PAR13 == 1,,,MV_PAR18 == 1,,Iif(MV_PAR18 == 1,2,0))
If Empty( aFilsCalc )
	dbSelectArea(cString)
	dbSetOrder(1)
	dbClearFilter()
	Return
Endif

For nForFilial := 1 to Len( aFilsCalc )
	If aFilsCalc[nForFilial][1]
		
		cFilAnt   := aFilsCalc[nForFilial][2]
		nLin      := 80  // faz a quebra de pagina por filial 
		SM0->(DbSeek(cEmpAnt+cFilAnt))
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Nome da filial a ser impressa no cabecalho do relatorio.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cNomEmp	:=Trim(SM0->M0_NOMECOM)
		cNomFil :=Trim(SM0->M0_FILIAL)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cria Arquivo a ser Impresso com um indice de mesmo nome            ³
		//³ Ordem (1) = F3_FILIAL+DTOS(F3_ENTRADA)+F3_SERIE+F3_NFISCAL+F3_CFO  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cArqTemp:=EmiteLivro(If(nTipoMov==1,"E","S"),dDtIni,dDtFim,lLacuna,lServico,lDesconto,cNrLivro,cFilterUser,,2,MV_PAR04,2,cFilAnt,cFilAnt,NIL,"MATR921",MVIsento)
	   
	   	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Salva periodos de Apuracao ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nSvApurICM:=DefPeriodo(F3_ENTRADA,nApurICM)
		nSvApurIPI:=DefPeriodo(F3_ENTRADA,nApurIPI)
		If !lAbortPrint
			R921Listagem( F3_CREDST )
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Restaura area ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cArqTemp)
		dbClearFilter()
		dbCloseArea()
		Ferase(cArqTemp+GetDBExtension())
		Ferase(cArqTemp+OrdBagExt())
		dbSelectArea(aSvArea[1])
		dbSetOrder(aSvArea[2])
		dbGoto(aSvArea[3])
		
	EndIf
   		If FWModeAccess("SF3",3)=="C" .And. aFilsCalc[nForFilial][1]
			Exit
	 	EndIf
Next nForFilial

cFilAnt := cFilBack 


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R921Listagem   ³Autor³ Juan Jose Pereira  ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime Listagem de Entradas/Saidas                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R921Listagem( cCredST )

Local ncw		:=	0
Local lHistTab   := GetNewPar ("MV_HISTTAB", .F.)
Local cCGC := ""
Local cNome:= ""
Local cEspecie:= ""
Local cEstFat:= ""
Local aArea	:= 	{}
Local cEstado := GetNewPar ("MV_ESTADO", " ")
Local lCliFat := GetNewPar ("MV_CLIFAT", .F.)
Local lMV_ESTCLI 	:= GetNewPar ("MV_ESTCLI", .F.)	//Parametro para mudar a pesquisa do estado do cliente. F3_ESTADO pelo A1_EST ou A2_EST.
Local lImprZero	:= GetNewPar ("MV_IMPZNFC",.F.)
Local cUfForCte	:= GetNewPar( "MV_NFCTEUF", '0' )
Local aAreaAnt := ""
Local cCliFor := ""
Local cLoja	   := ""
Local nTam_Obs := 0
Local nH		:= 0
Local nMaxLin	:= 0
Local nIniPos	:= 0
Local nMaxCol	:= 14
Local cQuebraCon:= ""
Local nI		:= 0

Private aObsTransp:= {}
Private aLinCont	:= {}

aGrade:=NIL
dbSelectArea(cArqTemp)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Avalia filtro do usuario                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dDiaAnt:=F3_ENTRADA
dDia:=dDiaAnt


SetRegua(LastRec())
While !Eof()

	IncRegua()
	If Interrupcao(@lAbortPrint)
		Exit
	Endif

	LivrAcumula(cArqTemp,@aTotDia,@aTotPerICM,@aTotPerIPI,@aTotMes,@aTransp,@aResumo,@aResCFO,,.T.,,@aTotObs, MV_PAR19)
	


	If (!lLacuna .AND. !Empty(F3_DTCANC))
		dbSelectArea(cArqTemp)
		dbSkip()
		If Eof()
			dDia:=F3_ENTRADA
			R921Totais( cCredST )
		Else
			dbSkip(-1)
		Endif
	Endif

	//
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime os periodos sem movimento³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SEMMOV
		dDia:=F3_ENTRADA
		R921Cabec(dDia)
		FmtLin({"*** NAO HOUVE MOVIMENTO ***"},aL[10],,,@nLin)
		nLin	:=	99
		dbSkip()
		dDia:=F3_ENTRADA
		Loop
	Endif
	

	//ÚÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cabecalho ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÙ
	If nLin>nLimPag .Or. (Month(dDiaAnt)<>Month(dDia) .Or. Year(dDiaAnt)<>Year(dDia))
		If nLin<60 .And. !(Month(dDiaAnt)<>Month(dDia) .Or. Year(dDiaAnt)<>Year(dDia))
			FmtLin(,aL[01],,,@nLin)
		Endif
		R921Cabec()
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Contador de Tamanho de nota ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nTamNota:=nLin

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica o parametro para cada filial processada³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	lMV_ESTCLI 	:= GetNewPar ("MV_ESTCLI", .F.)	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona nos cadastros de Clientes/Fornecedores³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	cEmitente	:=""
	cEstFat		:= ""

		// Para operações internas (UF do emitente igual a UF do cliente de entrega) serão considerado os dados do cliente de faturamento.
		 // Parecer SP = http://tdn.totvs.com/pages/releaseview.action?pageId=344460112
		If lCliFat .And. !Empty(F3_CLIENT) .And. F3_CLIEFOR+F3_LOJA<>F3_CLIENT+F3_LOJENT
			If nTipoMov == 2 .And. !F3_TIPO$"DB" .And. cEstado == F3_ESTADO .And. !(AllTrim(F3_ESPECIE) $ "CTR/CTE/CTA/CA/CTF" .Or. "NFST"$AllTrim(cEspecie))
			
				cClieFor:=F3_CLIEFOR+F3_LOJA
				aArea := GetArea()				
				dbSelectArea("SA1")
				dbSeek(F3Filial(Alias())+cClieFor)
				cEstFat := A1_EST				
				RestArea(aArea)
				
				If cEstFat <> cEstado //Somente aplica regra quando MV_ESTADO == ESTADO ENTREGA == ESTADO FATURAMENTO
					cEstFat := ""
				Endif
			Endif		
		Endif
		
		If !Empty(cEstFat)
			//-- Cliente emitente
			cClieFor:=F3_CLIEFOR+F3_LOJA
		ElseIf !Empty(F3_CLIENT) .And. F3_CLIEFOR+F3_LOJA<>F3_CLIENT+F3_LOJENT .And. !(AllTrim(F3_ESPECIE) $ "CTR/CTE/CTA/CA/CTF" .Or. "NFST"$AllTrim(cEspecie))
			//-- Cliente de entrega
			cClieFor:=F3_CLIENT+F3_LOJENT
		Else
			//-- Cliente emitente
			cClieFor:=F3_CLIEFOR+F3_LOJA
		EndIf	

		If nTipoMov==1
			If F3_TIPO$"DB"
				dbSelectArea("SA1")
			Else
				dbSelectArea("SA2")
			Endif
		Else
			If F3_TIPO$"DB"
				if (substr(F3_CFO,1,3)=="999".and. F3_FORMUL=="S") .Or. (substr(F3_CFO,1,1)$"123".and. F3_FORMUL=="S") // Quando a NF e cancelada, traz o CFOP preenchido e nao 999
					dbSelectArea("SA1")
				else
					dbSelectArea("SA2")
				endif
			Else
				if (substr(F3_CFO,1,3)=="999".and. F3_FORMUL=="S") .Or. (substr(F3_CFO,1,1)$"123".and. F3_FORMUL=="S") // Quando a NF e cancelada, traz o CFOP preenchido e nao 999 
					dbSelectArea("SA2")
				else
					dbSelectArea("SA1")
				EndIf
			Endif
		Endif

		dbSeek(F3Filial(Alias())+cClieFor)
		If Alias()=="SA1"
			cEmitente:=If(nCodigo==1,TRIM(A1_COD),Transform(A1_CGC,PicPesFJ(RetPessoa(A1_CGC))))
			cEmitente:=cEmitente+IIf(RetPessoa(A1_CGC)=="F",Space(4),Space(0))+" - "+TRIM(A1_NOME)
		Else
			If lHistTab
				DbSelectArea("AIF")
				AIF->(DbSetOrder(1))
				AIF->(dbSeek(xFilial("AIF")+"  "+"SA2"+SA2->A2_COD+SA2->A2_LOJA+ DTOS(dDia)))
				While !AIF->(Eof()) .And. AIF_TABELA == "SA2" .And. AIF_FILTAB=="  " .And. AIF_CODIGO==SA2->A2_COD .And. AIF_LOJA==SA2->A2_LOJA .And. dDia<AIF->AIF_DATA   
						If Alltrim(AIF->AIF_CAMPO)=="A2_CGC" .And. Empty(cCGC)
							cCGC := Alltrim(Transform(AIF->AIF_CONTEU,PicPesFJ(RetPessoa(AIF->AIF_CONTEU))))
						Elseif Alltrim(AIF->AIF_CAMPO)=="A2_NOME" .And. Empty(cNome)
							cNome := Alltrim(AIF->AIF_CONTEU)
						Endif
					DbSkip()
				Enddo
				If cCGC<>"" .And. cNome==""
					cEmitente:=If(nCodigo==1,TRIM(SA2->A2_COD),cCGC)
					cEmitente:=cEmitente+IIf(RetPessoa(SA2->A2_CGC)=="F",Space(4),Space(0))+" - "+TRIM(SA2->A2_NOME)
				Elseif cCGC=="" .And. cNome<>""
					cEmitente:=If(nCodigo==1,TRIM(SA2->A2_COD),Transform(SA2->A2_CGC,PicPesFJ(RetPessoa(SA2->A2_CGC))))+" - "+cNome
				Elseif cCGC<>"" .And. cNome<>"" 
					cEmitente:=If(nCodigo==1,TRIM(SA2->A2_COD),cCGC)+" - "+cNome
				Else
					cEmitente:=If(nCodigo==1,TRIM(SA2->A2_COD),Transform(SA2->A2_CGC,PicPesFJ(RetPessoa(SA2->A2_CGC))))
					cEmitente:=cEmitente+IIf(RetPessoa(SA2->A2_CGC)=="F",Space(4),Space(0))+" - "+TRIM(SA2->A2_NOME)	
				Endif
				DbGotop()
			Else
				cEmitente:=Space(1)+ If(nCodigo==1,TRIM(SA2->A2_COD),Transform(SA2->A2_CGC,PicPesFJ(RetPessoa(SA2->A2_CGC))))
				cEmitente:=cEmitente+IIf(RetPessoa(A2_CGC)=="F",Space(4),Space(0))+" - "+TRIM(A2_NOME)
			Endif
			cCGC:=""
			cNome:=""
		Endif
		cEmitente:=Substr(cEmitente,1,nLargEmi)

		If ( substr((cArqTemp)->F3_CFO,1,3) == "999" ) //Notas Canceladas
			cEspecie := a460Especie((cArqTemp)->F3_SERIE)
		EndIf

		dbSelectArea(cArqTemp)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cria Array com mensagens a serem impressas na coluna de Observacao ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aObs:=LivrArrayObs(nLargObs,,lListaNFO,,.T., MV_PAR19,;
			(cArqTemp)->F3_CLIEFOR+(cArqTemp)->F3_LOJA+(cArqTemp)->F3_SERIE+(cArqTemp)->F3_NFISCAL+(cArqTemp)->F3_IDENTFT;
		)


		for nTam_Obs:= 1 to len( aObs )
			nSepTrib := at(":",aObs[nTam_Obs,1])
			if nSepTrib > 0
				cNomeTrib := substr( aObs[nTam_Obs,1], 1, nSepTrib )
				if aScan( aObsTransp, cNomeTrib ) == 0 .and. cNomeTrib <> "N.F.:"
					aAdd( aObsTransp, cNomeTrib )
				endif 
			endif
		next

		R921IniGrade()

		If lImpZer.or.F3_BASEICM+F3_VALICM>0
			aGrade[1,2]:=F3_BASEICM
			aGrade[1,3]:=F3_VALICM
		Else
			aGrade[1,1]:=""
		Endif

		If lImpZer.Or.( F3_BASERET+F3_ICMSRET>0 .And. F3_CREDST <> '4')
			aGrade[7,2]:= F3_BASERET
			aGrade[7,3]:= F3_ICMSRET 
		Else
			aGrade[7,1]:= ""
		EndIF

		If lImpZer.or.F3_ISENICM>0
			ncw:=Ascan(aGrade,{|x|x[1]=="" .or. x[1]=="2"})
			aGrade[ncw,1]:="2"
			aGrade[ncw,2]:=F3_ISENICM
		Endif

		If lImpZer.or.F3_OUTRICM>0
			ncw:=Ascan(aGrade,{|x|x[1]=="".or. x[1]=="3"})
			aGrade[ncw,1]:="3"
			aGrade[ncw,2]:=F3_OUTRICM
		Endif
		If lImpZer.or. F3_BASEIPI > 0 
			aGrade[4,2]:=F3_BASEIPI
		EndIf	
		IF lImpZer.or. F3_VALIPI > 0 
			aGrade[4,3]:=F3_VALIPI
		EndIF	
		IF lImpZer.or. F3_ISENIPI > 0 
			aGrade[5,2]:=F3_ISENIPI
		EndIF	
		IF lImpZer.or. F3_OUTRIPI > 0 
			aGrade[6,2]:=F3_OUTRIPI
		EndIF
		aDados:=Array(16)
		aDados[1]:=If(nTipoMov==1,DTOC(F3_ENTRADA),DTOC(F3_EMISSAO))
		aDados[2]:=If(Empty(F3_ESPECIE),If((Substr(F3_CFO,2,2)$"62").OR.(Substr(F3_CFO,2,3)$"352"),STR0001,Iif(!Empty(cEspecie),cEspecie,STR0002)),F3_ESPECIE) //"CT"###"NF"
		aDados[3]:=SerieNfId(cArqTemp,2,"F3_SERIE")
		aDados[4]:=F3_NFISCAL+" A "+IF(F3_TIPO$"L",F3_DOCOR,F3_NFISCAL)
		aDados[5]:=If(nTipoMov==1,DTOC(F3_EMISSAO),)
		aDados[6]:=cEmitente
		aDados[7]:= Iif(nTipoMov==1 .And. cUfForCte=="1" .And. AllTrim(F3_ESPECIE)=="CTE", SA2->A2_EST, F3_ESTADO)
		If (lMV_ESTCLI) .AND. (nTipoMov==2) .AND. F3_CLIEFOR<>F3_CLIENT
			cCliFor := F3_CLIEFOR
			cLoja	 := F3_LOJA
			aAreaAnt := GetArea()
			If SA1->(dbSeek(xFilial("SA1")+cCliFor+cLoja))
				aDados[7]:= SA1->A1_EST
			EndIf
			RestArea(aAreaAnt)
		EndIf

		aLinCont:= {}	//zera array devido a carga R931ImpGrade para impressao de conhecimento de frete
		If Empty(F3_DTCANC) .Or. lImprZero
			aDados[8]:=F3_VALCONT
			aDados[9]:=Alltrim(EvalMacro(cContaContab))

			//Tratativa para imprimir conta contabil com tamanho maior que 20 sem quebrar a coluna do relatorio
			nTamCon := IIF(Valtype(aDados[9]) == "C", Len(Alltrim(aDados[9])), 0) //checa a quantidade de caracteres da conta contabil
			If nTamCon > nMaxCol //verifica necessidade de tratativa para quebra de linha devido ao tamanho da conta contabil
				nMaxLin := Ceiling(nTamCon/nMaxCol) //qtd total de quebras de linhas
				cContaFor := aDados[9]
				aAdd(aLinCont,Substr(cContaFor,1,nMaxCol)) //limita o tamanho da conta contabil para impressao na primeira linha

				//Cria array para armazenar os dados da conta contabil por quebra de linha
				For nH:=2 to nMaxLin
					nIniPos :=(nMaxCol*nH)-13
					cQuebraCon := Substr(cContaFor,nIniPos,nMaxCol)
					If !Empty(cQuebraCon)
						aAdd(aLinCont,cQuebraCon) //alimenta o array das quebras da conta contabil por linha
					EndIf
				Next nH
			EndIf

			aDados[10]:=If(substr(F3_CFO,1,3)$"999#000",,Transform(F3_CFO,PESQPICT("SF3","F3_CFO")))	//F3_CFO
			aDados[14]:= Transform( F3_ALIQICM, '@E 999.99' )


			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime Linhas de detalhe              ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			R921ImpGrade()

			//Verifica necessidade de impressao da conta contabil por quebra de linha
			If Len(aLinCont) > 0
				For nI:=1 to Len(aLinCont)
					aDados[9] := aLinCont[nI]
					FmtLin(@aDados,aL[9],cPictVl,,@nLin)
				Next nI
				aLinCont:= {}
			EndIf
		Endif

		nPosObs:=Ascan(aObs,{|x|x[2]})
		While nPosObs>0
			R921LoadObs()
			If nPosObs>0
				FmtLin(@aDados,aL[9],cPictVl,,@nLin)
			Endif
		End
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Acumula valores ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nLinNec:=nLin-nTamNota
		aTamNotas[1]:=Max(aTamNotas[1],nLinNec)

		dDiaAnt:=F3_ENTRADA
		dbSelectArea(cArqTemp)
		dbSkip()
		If Empty(F3_ENTRADA)
			dDiaAnt := dDia
		Endif
		dDia:=F3_ENTRADA
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Totais e finaliza relatorio ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		R921Totais( cCredST )
	
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quando mudar a filial, reinicia os totalizadores³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTotDia    := NIL
aTotPerICM := NIL
aTotPerIPI := NIL
aTotMes    := NIL
aTransp    := NIL
aResumo    := NIL
aResCFO    := NIL

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R921Cabec ³Autor ³ Juan Jose Pereira     ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao de Cabecalho                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R921Cabec

cPeriodo:=""
If !Empty(dDiaAnt) .Or. !Empty(dDia)
	cPeriodo:=aMeses[Month(IIf(Empty(dDia),dDiaAnt,dDia))]+" / "+Str(Year(IIf(Empty(dDia),dDiaAnt,dDia)),4)
Endif	
cPagina :=StrZero(nPagina++,6)
cTitulo:=If(nTipoMov==1,STR0003,STR0004) //"ENTRADAS"###"SAIDAS"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Cabecalho  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLin:=0
FmtLin(,AvalImp(nLargMax),,,@nLin)
FmtLin({cNomEmp+" - "+STR0028+cFilAnt+" "+cNomFil,cTitulo,cPagina},aL[1],,,@nLin) //"Filial : "
FmtLin(,aL[2],,,@nLin)
FmtLin({cPeriodo},aL[3],,,@nLin)
FmtLin(,{aL[4],aL[5],aL[6],aL[7],aL[8]},,,@nLin)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R921LayOut³Autor ³ Juan Jose Pereira     ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Layout da Listagem                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R921LayOut

//aL[00]:=0         10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220                          
//aL[00]:=01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

aL:=Array(10)

aL[01]:=STR0005 //"#################################################################                                    REGISTRO DE ########                                                                                      PAGINA ######"
aL[02]:=""
If nTipoMov==1
	aL[03]:=STR0006 //"MES OU PERIODO/ANO: #######                                                                                                                                                               ----------- OPERACOES ------------"
	aL[04]:=STR0007 //"                                                                                                                                                                                          (1)TRIBUTADAS (2)ISENTAS (3)OUTRAS"
	aL[05]:="----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
	aL[06]:=STR0008 //"  DT       ESPE  SE                        DT                                                                                                  ICMS OPERACOES"
	aL[07]:=STR0009 //"ENTRADA    CIE   RIE        NUMERO         EMISSAO                     EMITENTE                   UF     VALOR CONTABIL CONTA CONTABIL       CFO  IPI (*)    BASE DE CALCULO ALIQ    VALOR DO IMPOSTO           OBSERVACOES "
	aL[08]:="----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    aL[09]:="########## ##### ### ##################### ######## ############################################# ## ################## #################### ##### #### # ############## ######## ################ ######################"
	//          [1]     [2]   [3]      [4]           [5]   <------------[6]------45--------------------> [7]      [8]               [9]            [10] [11][12]       [13]         [14]         [15]        <-------------35-[16]----------->
	//       x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789
	//		 0         10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220
Else
	aL[03]:=STR0010 //"MES OU PERIODO/ANO: #######                                                                                                                                                               ----------- OPERACOES ------------"
	aL[04]:=STR0011 //"                                                                                                                                                                                          (1)TRIBUTADAS (2)ISENTAS (3)OUTRAS"
	aL[05]:="----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
	aL[06]:=STR0012 //"  DT       ESPE  SE                                                                                                                 ICMS OPERACOES"
	aL[07]:=STR0013 //"EMISSAO    CIE   RIE        NUMERO                              EMITENTE                   UF     VALOR CONTABIL CONTA CONTABIL       CFO  IPI (*)    BASE DE CALCULO ALIQ    VALOR DO IMPOSTO                  OBSERVACOES "
	aL[08]:="----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    aL[09]:="########## ##### ### ##################### # ############################################# ## ################## #################### ##### #### # ############## ######## ################ #############################"
	//          [1]     [2]   [3]       [4]      [5]<------------[6]------45--------------------> [7]      [8]               [9]            [10] [11][12]       [13]         [14]         [15]        <-------------------42-[16]------------>
	//       x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789
	//		 0         10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220
Endif
aL[10]:="#################################################################################"

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R921Transp³Autor ³ Juan Jose Pereira     ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime linhas de transporte                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R921Transp( lCredSt )

nMaior:=0
AEval(aTamNotas,{|x|nMaior:=Max(nMaior,x)})
aTamNotas[2]:=nMaior

lTransp2 := nLin+nLinNec+len(aObsTransp)-1>nLimPag 
If lTransp2
	nTamTransp:=nLin

	aObs:=LivrArrayObs(nLargObs,aTotMes,,,,MV_PAR19)

	R921IniGrade()

	aGrade[1,2]:=aTransp[ColF3("F3_BASEICM")]
	aGrade[1,3]:=aTransp[ColF3("F3_VALICM")]
	aGrade[2,2]:=aTransp[ColF3("F3_ISENICM")]
	aGrade[3,2]:=aTransp[ColF3("F3_OUTRICM")]

	aGrade[4,2]:=aTransp[ColF3("F3_BASEIPI")]
	aGrade[4,3]:=aTransp[ColF3("F3_VALIPI")]
	aGrade[5,2]:=aTransp[ColF3("F3_ISENIPI")]
	aGrade[6,2]:=aTransp[ColF3("F3_OUTRIPI")]
	If ! lCredSt
		aGrade[7,2]:=aTransp[ColF3("F3_BASERET")]	
		aGrade[7,3]:=aTransp[ColF3("F3_ICMSRET")]	
	EndIf
	aDados:=Array(16)
	FmtLin(@aDados,aL[9],,,@nLin)
	aDados[6]:=STR0014 //"A TRANSPORTAR"
	aDados[8]:=aTransp[ColF3("F3_VALCONT")]
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Linhas de detalhe              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R921ImpGrade()

	nPosObs:=Ascan(aObs,{|x|x[2]})
	While nPosObs>0
		R921LoadObs()
		If nPosObs>0
			FmtLin(@aDados,aL[9],cPictVl,,@nLin)
		Endif
	End

	nLinNec:=nLin-nTamTransp
	aTamNotas[2]:=Max(aTamNotas[2],nLinNec)

	R921Cabec()
Endif

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R921Totdia³Autor ³ Juan Jose Pereira     ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime total do dia                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R921TotDia( lCredSt )

lTotDia:=(dDiaAnt!=dDia)

If lTotDia .Or. Eof()
	aTamNotas[3]:=Max(aTamNotas[3],nLinNec)
	nLinNec:=aTamNotas[3]

	nTamTotDia:=nLin
	aObs:=LivrArrayObs(nLargObs,aTotDia,,,,MV_PAR19)

	R921IniGrade()

	If	aTotDia[ColF3("F3_BASEICM")]>0
		aGrade[1,2]:=aTotDia[ColF3("F3_BASEICM")]
	Endif
	If aTotDia[ColF3("F3_VALICM")]>0
		aGrade[1,3]:=aTotDia[ColF3("F3_VALICM")]
	Endif
	If aTotDia[ColF3("F3_ISENICM")]>0
		aGrade[2,2]:=aTotDia[ColF3("F3_ISENICM")]
	Endif
	If aTotDia[ColF3("F3_OUTRICM")]>0
		aGrade[3,2]:=aTotDia[ColF3("F3_OUTRICM")]
	Endif
	If MV_PAR19 <> 1
		If aTotDia[ColF3("F3_BASERET")] > 0 .And. ! lCredSt
			aGrade[7,2]:= aTotDia[ColF3("F3_BASERET")]
		EndIf
		If aTotDia[ColF3("F3_ICMSRET")] > 0 .And. ! lCredSt
			aGrade[7,3]:= aTotDia[ColF3("F3_ICMSRET")]
		Endif
	EndIf
	aGrade[4,2]:=aTotDia[ColF3("F3_BASEIPI")]
	aGrade[4,3]:=aTotDia[ColF3("F3_VALIPI")]
	aGrade[5,2]:=aTotDia[ColF3("F3_ISENIPI")]
	aGrade[6,2]:=aTotDia[ColF3("F3_OUTRIPI")]

	aDados:=Array(16)
	FmtLin(@aDados,aL[9],,,@nLin)
	aDados[6]:=STR0015+StrZero(Day(dDiaAnt),2) //"TOTAL DO DIA "
	aDados[8]:=aTotDia[ColF3("F3_VALCONT")]

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Linhas de detalhe              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R921ImpGrade()

	nPosObs:=Ascan(aObs,{|x|x[2]})
	While nPosObs>0
		R921LoadObs()
		If nPosObs>0
			FmtLin(@aDados,aL[9],cPictVl,,@nLin)
		Endif
	End

	FmtLin(@aDados,aL[9],,,@nLin)
	nLinNec:=nLin-nTamTotDia
	aTamNotas[3]:=Max(aTamNotas[3],nLinNec)

	If nLimPag<=nLin+nLinNec
		R921Transp( lCredSt )
	Endif

Endif
If lTotDia
	Afill(aTotDia,0)
Endif

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R921TotMes³Autor ³ Juan Jose Pereira     ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime total do Mes                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R921TotMes( lCredSt )

lTotMes:=(Month(dDiaAnt)!=Month(dDia))

If lTotMes .Or. Eof()
	If nLin>=nLimPag
		R921Transp( lCredSt )
	Endif
	aObs:=LivrArrayObs(nLargObs,aTotMes,,,,MV_PAR19)

	R921IniGrade()

	If	aTotMes[ColF3("F3_BASEICM")]>0
		aGrade[1,2]:=aTotMes[ColF3("F3_BASEICM")]
	Endif
	If aTotMes[ColF3("F3_VALICM")]>0
		aGrade[1,3]:=aTotMes[ColF3("F3_VALICM")]
	Endif
	If aTotMes[ColF3("F3_ISENICM")]>0
		aGrade[2,2]:=aTotMes[ColF3("F3_ISENICM")]
	Endif
	If aTotMes[ColF3("F3_OUTRICM")]>0
		aGrade[3,2]:=aTotMes[ColF3("F3_OUTRICM")]
	Endif
	If MV_PAR19 <> 1
		If aTotMes[ColF3("F3_BASERET")] > 0 .And. ! lCredSt
			aGrade[7,2]:= aTotMes[ColF3("F3_BASERET")]
		Endif
		If aTotMes[ColF3("F3_ICMSRET")] > 0 .And. ! lCredSt
			aGrade[7,3]:= aTotMes[ColF3("F3_ICMSRET")]
		Endif
	EndIf
	aGrade[4,2]:=aTotMes[ColF3("F3_BASEIPI")]
	aGrade[4,3]:=aTotMes[ColF3("F3_VALIPI")]
	aGrade[5,2]:=aTotMes[ColF3("F3_ISENIPI")]
	aGrade[6,2]:=aTotMes[ColF3("F3_OUTRIPI")]

	aDados:=Array(16)
	FmtLin(@aDados,aL[9],,,@nLin)
	aDados[6]:=STR0016 //"TOTAL DO MES"
	aDados[8]:=aTotMes[ColF3("F3_VALCONT")]

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Linhas de detalhe              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R921ImpGrade()

	nPosObs:=Ascan(aObs,{|x|x[2]})
	While nPosObs>0
		R921LoadObs()
		If nPosObs>0
			FmtLin(@aDados,aL[9],cPictVl,,@nLin)
		Endif
	End

	FmtLin(@aDados,aL[9],,,@nLin)
Endif
If lTotMes .Or. Eof()
	Afill(aTransp,0)
	Afill(aTotMes,0)
	Afill(aTamNotas,0)
Endif

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R921TotPer³Autor ³ Juan Jose Pereira     ³ Data ³ 23.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime total do periodo de apuracao                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R921TotPer( lCredSt )

Local nX 	:=0
Local cICM	:= ''
Local cIPI	:= ''
Local cICMST:= ''

lTotPerICM:=(nSvApurICM!=DefPeriodo(dDia,nApurICM))
lTotPerIPI:=(nSvApurIPI!=DefPeriodo(dDia,nApurIPI))

nLinNec2:=0
If lTotPerICM
	aTamNotas[4]:=Max(aTamNotas[4],nLinNec)
	nLinNec2:=nLinNec2+aTamNotas[4]
Endif
If lTotPerIPI
	aTamNotas[5]:=Max(aTamNotas[5],nLinNec)
	nLinNec2:=nLinNec2+aTamNotas[5]
Endif

If lTotPerICM.or.lTotPerIPI
	nLinNec:=nLinNec2
	If nLimPag<=nLin+nLinNec
		R921Transp( lCredSt )
	Endif

	aObs:=LivrArrayObs(nLargObs,aTotPerICM,,,,MV_PAR19)

	R921IniGrade()

	If lTotPerICM
		aGrade[1,2]:=aTotPerICM[ColF3("F3_BASEICM")]
		aGrade[1,3]:=aTotPerICM[ColF3("F3_VALICM")]
		aGrade[2,2]:=aTotPerICM[ColF3("F3_ISENICM")]
		aGrade[3,2]:=aTotPerICM[ColF3("F3_OUTRICM")]
		If ! lCredSt
			aGrade[7,2]:=aTotPerICM[ColF3("F3_BASERET")]
			aGrade[7,3]:=aTotPerICM[ColF3("F3_ICMSRET")]
		EndIf
	Endif
	If lTotPerIPI
		aGrade[4,2]:=aTotPerIPI[ColF3("F3_BASEIPI")]
		aGrade[4,3]:=aTotPerIPI[ColF3("F3_VALIPI")]
		aGrade[5,2]:=aTotPerIPI[ColF3("F3_ISENIPI")]
		aGrade[6,2]:=aTotPerIPI[ColF3("F3_OUTRIPI")]
	Endif
	aDados:=Array(16)

	nTamTotPer:=nLin
	cICM:=	 "ICMS"
	cIPI:=	 "IPI "
	cICMST:= "RET."
	nTotVContICM:=aTotPerICM[ColF3("F3_VALCONT")]
	nTotVContIPI:=aTotPerIPI[ColF3("F3_VALCONT")]

	lImprime:=.F.
	For nx:=1 to Len(aGrade)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Colunas de ICMS³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lTotPerICM.and.nx<=3
			If !lImpZer.and.aGrade[nx,2]+aGrade[nx,3]==0
				Loop
			Endif
			If !Empty(cICM)
				aDados[6]:=STR0017 //"TOTAL DO PERIODO"
				aDados[8]:=nTotVContICM
			Endif
			aDados[11]:="ICMS"
			aDados[12]:=aGrade[nx,1]
			aDados[13]:=aGrade[nx,2]
			aDados[15]:=aGrade[nx,3]
			lImprime:=.T.
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Colunas de ICMS-ST³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lTotPerICM .And. nx = 7 .And. MV_PAR19 <> 1
			If !lImpZer .And. aGrade[nx, 2] + aGrade[nx, 3] = 0
				Loop
			EndIf
			If !Empty(cICMST)
				aDados[6]:= STR0017 //"TOTAL DO PERIODO"
				aDados[8]:= nTotVContICM
			EndIf
			aDados[11]:= "RET."
			aDados[12]:= aGrade[nx, 1]
			aDados[13]:= aGrade[nx, 2] 
			aDados[15]:= aGrade[nx, 3]
			lImprime:=.T.
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Colunas de IPI³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lTotPerIPI.and.nx>3 .And. nx<7
			If !lImpZer.and.aGrade[nx,2]+aGrade[nx,3]==0
				Loop
			Endif
			If !Empty(cIPI)
				aDados[6]:=STR0017 //"TOTAL DO PERIODO"
				aDados[8]:=nTotVContIPI
			Endif
			aDados[11]:="IPI "
			aDados[12]:=aGrade[nx,1]
			aDados[13]:=aGrade[nx,2]
			aDados[15]:=aGrade[nx,3]
			lImprime:=.T.
		Endif
		cICM  := ""
		cICMST:= ""
		cIPI  := ""
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Coluna de Observacoes³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lTotPerICM
			R921LoadObs()
		Endif
		If lImprime
			FmtLin(@aDados,aL[9],cPictVl,,@nLin)
			lImprime:=.F.
		Endif

		If lTotPerICM
			nPosObs:=Ascan(aObs,{|x|x[2]})
			While nPosObs>0
				R921LoadObs()
				If nPosObs>0
					FmtLin(@aDados,aL[9],cPictVl,,@nLin)
				Endif
			End
		Endif
	Next nx

	If lTotPerICM
		nLinNec:=nLin-nTamTotPer
		aTamNotas[4]:=Max(aTamNotas[4],nLinNec)
	Endif
	If lTotPerIPI
		nLinNec:=nLin-nTamTotPer
		aTamNotas[5]:=Max(aTamNotas[5],nLinNec)
	Endif
	FmtLin(@aDados,aL[9],,,@nLin)

	If lTotPerICM
		aFill(aTotPerICM,0)
		nSvApurICM:=DefPeriodo(dDia,nApurICM)
	Endif
	If lTotPerIPI
		aFill(aTotPerIPI,0)
		nSvApurIPI:=DefPeriodo(dDia,nApurIPI)
	Endif
Endif

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R921ResCfo³Autor ³ Juan Jose Pereira     ³ Data ³ 23.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Resumo por CFO                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R921ResCfo( lCredSt )
Local i	:=0

If !Eof().or.Len(aResCFO)==0
	Return
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ordena CFOs³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÙ
aResCFO:=Asort(aResCFO,,,{|x,y|x[ColF3("F3_CFO")]<y[ColF3("F3_CFO")]})

aCFOS:={	STR0018,; //"1.00 ENTRADAS DO ESTADO"
			STR0019,; //"2.00 ENTRADAS DE FORA DO ESTADO"
			STR0020,; //"3.00 ENTRADAS DO EXTERIOR"
			"",;
			STR0021,; //"5.00 SAIDAS PARA O ESTADO"
			STR0022,; //"6.00 SAIDAS PARA FORA DO ESTADO"
			STR0023}  //"7.00 SAIDAS PARA O EXTERIOR"

cSvCFO:="X"
nLin:=80
For i:=1 to Len(aResCFO)
	If nLin>nLimPag .Or. nLin+len(aGrade)>nLimPag
		R921Cabec()
	EndIf
	aObs:=LivrArrayObs(nLargObs,aResCFO[i],,,,MV_PAR19)
	cCFO:=Trim(aResCFO[i,ColF3("F3_CFO")])

	R921IniGrade()

	If aResCFO[i,ColF3("F3_BASEICM")]>0
		aGrade[1,2]:=aResCFO[i,ColF3("F3_BASEICM")]
	Endif
	If aResCFO[i,ColF3("F3_VALICM")]>0
		aGrade[1,3]:=aResCFO[i,ColF3("F3_VALICM")]
	Endif
	If aResCFO[i,ColF3("F3_ISENICM")]>0
		aGrade[2,2]:=aResCFO[i,ColF3("F3_ISENICM")]
	Endif
	If aResCFO[i,ColF3("F3_OUTRICM")]>0
		aGrade[3,2]:=aResCFO[i,ColF3("F3_OUTRICM")]
	Endif
	If aResCFO[i,ColF3("F3_BASERET")] > 0 .And. ! lCredSt
		aGrade[7,2]:= aResCFO[i,ColF3("F3_BASERET")]
	EndIf
	If aResCFO[i,ColF3("F3_ICMSRET")] > 0  .And. ! lCredSt
		aGrade[7,3]:= aResCFO[I,ColF3("F3_ICMSRET")]
	EndIf
	If aResCFO[i,ColF3("F3_BASEIPI")] > 0  
		aGrade[4,2]:=aResCFO[i,ColF3("F3_BASEIPI")]
	EndIF
	If aResCFO[i,ColF3("F3_VALIPI")] > 0  
		aGrade[4,3]:=aResCFO[i,ColF3("F3_VALIPI")]
	EndIF
	If aResCFO[i,ColF3("F3_ISENIPI")] > 0  	
		aGrade[5,2]:=aResCFO[i,ColF3("F3_ISENIPI")]
	EndIF	
	If aResCFO[i,ColF3("F3_OUTRIPI")] > 0  	
		aGrade[6,2]:=aResCFO[i,ColF3("F3_OUTRIPI")]
	EndIF	

	aDados:=Array(16)
    If !(Substr(cCFO,1,1)==cSvCFO).and.!(ALLTRIM(cCFO)$"TTT") .And. !Empty (cCFO)
		FmtLin(@aDados,aL[9],,,@nLin)
		cSvCFO:=Substr(cCFO,1,1)
		aDados[6]:=aCFOS[Val(cSvCFO)]
		FmtLin(@aDados,aL[9],,,@nLin)
		aDados[6]:=Replic("=",Len(aCFOS[Val(cSvCFO)]))
		FmtLin(@aDados,aL[9],,,@nLin)
	Endif
	If ("TT"$cCFO)
		FmtLin(@aDados,aL[9],,,@nLin)
        aDados[6]:=If(ALLTRIM(cCFO)=="TTT",STR0024,STR0025) //"TOTAL GERAL"###"TOTAL"
	Else
		aDados[10]:=cCFO
	Endif
	aDados[8]:=aResCFO[i,ColF3("F3_VALCONT")]

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Linhas de detalhe              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R921ImpGrade()

	nPosObs:=Ascan(aObs,{|x|x[2]})
	While nPosObs>0
		R921LoadObs()
		If nPosObs>0
			FmtLin(@aDados,aL[9],cPictVl,,@nLin)
		Endif
	End
Next i    

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R921ResEst³Autor ³ Juan Jose Pereira     ³ Data ³ 23.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Resumo por Estado                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R921ResEst()
Local i :=0
Local j	:=0
Local aDescrm := Array(16)
If !Eof().or.Len(aResumo)==0
	Return
Endif

nLin:=80
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Arranja o resumo em ordem de CFO e Estado³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aResumo:=ASort(aResumo,,,{|x,y|x[1]+x[2]<y[1]+y[2]})
lFirstCO:=.T.
lFirstNC:=.T.
For i:=1 to Len(aResumo)
	If nLin>nLimPag
		R921Cabec()
	Endif
	aDados:=Array(16)
	If i==1
		FmtLin(@aDados,aL[9],,,@nLin)
		aDados[8]:=STR0026 //"DEMONSTRATIVO POR ESTADO DE ORIGEM DA MERCADORIA OU DE INICIO DA PRESTACAO DE SERVICO"
		FmtLin(@aDados,aL[9],,,@nLin)
		aDados[8]:="====================================================================================="
		FmtLin(@aDados,aL[9],,,@nLin)
		FmtLin(@aDados,aL[9],,,@nLin)
	Endif
	aGrade:={}
	If aResumo[i,4]>0 .Or. (aResumo[i,4]=0 .And. aResumo[i,3]>0)
		AADD(aGrade,{"1",aResumo[i,4]})
	Endif
	If aResumo[i,7]>0
		AADD(aGrade,{"2",aResumo[i,7]})
	Endif
	If aResumo[i,5]>0
		AADD(aGrade,{"3",aResumo[i,5]})
	Endif
	aDados[7]:=aResumo[i,2]
	aDados[8]:=aResumo[i,3]
	If aResumo[i,6]>0 
		aDados[16]:=STR0027+Alltrim(Transform(aResumo[i,6],PesqPict("SF3","F3_ICMSRET"))) //"ICMS RETIDO...: "
	Endif
	For j:=1 to Len(aGrade)
		aDados[12]:=aGrade[j,1]
		aDados[13]:=aGrade[j,2]
		    IF aResumo[i][1]=='CO'
		      If i>1 
		        If aResumo[i-1][1] <> aResumo[i][1]
		           aDescrm[7] := 'OPERAÇÕES REALIZADAS COM CONTRIBUINTES '
		           FmtLin(aDescrm,aL[9],cPictVl,,@nLin)
		           aDescrm[7] :="============================================"
		           FmtLin(aDescrm,aL[9],cPictVl,,@nLin)
		        EndIf   
		      Else
		           aDescrm[7] := 'OPERAÇÕES REALIZADAS COM CONTRIBUINTES '
                  FmtLin(aDescrm,aL[9],cPictVl,,@nLin)
                  aDescrm[7] :="============================================"
                  FmtLin(aDescrm,aL[9],cPictVl,,@nLin)
		      EndIf  
		   ElseIf aResumo[i][1]=='NC'
		      If i>1 
		        If aResumo[i-1][1]<>aResumo[i][1]
		           aDescrm[7] := 'OPERAÇÕES REALIZADAS COM NÃO CONTRIBUINTES'
                  FmtLin(aDescrm,aL[9],cPictVl,,@nLin)
                  aDescrm[7] :="============================================"
                  FmtLin(aDescrm,aL[9],cPictVl,,@nLin)  
               EndIf  
             Else
                  aDescrm[7] := 'OPERAÇÕES REALIZADAS COM NÃO CONTRIBUINTES'
                  FmtLin(aDescrm,aL[9],cPictVl,,@nLin)
                  aDescrm[7] :="============================================"
                  FmtLin(aDescrm,aL[9],cPictVl,,@nLin) 
             EndIf  
		   EndIf	
		FmtLin(@aDados,aL[9],cPictVl,,@nLin)
	Next j

Next i

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R921LoadObs³Autor ³ Juan Jose Pereira     ³ Data ³ 23.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Carrega observacao para ser impressa                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R921LoadObs
Local lRemoved	:= .F. //Protecao para nao refazer o ajuste de tamanho

nPosObs:=Ascan(aObs,{|x|x[2]})
If  nPosObs>0
	If nPosObs == 1 .And. !("NF CANCELADA" $ aObs[1,1])
		aDados[16]:= iIf( nTipoMov == 2, Space(8), Space(4) ) + aObs[nPosObs,1]
	Else
		aDados[16]:= iIf( nTipoMov == 2, Space(9), Space(5) ) + aObs[nPosObs,1]
	Endif
	aObs[nPosObs,2]:=.F.
	//Verifica necessidade de impressao da conta contabil por quebra de linha
	If Len(aLinCont) > 0
		aDados[9] := aLinCont[1] 			//Preenche a continuacao da conta contabil
		ADel( aLinCont, 1 )					//Remove a dimensao que foi utilizada
		ASize( aLinCont, Len(aLinCont)-1 )	//Redimensiona o array
		lRemoved := .T.
	EndIf
Endif


//Verifica necessidade de impressao da conta contabil por quebra de linha
If Len(aLinCont) > 0 .AND. !lRemoved
	aDados[9] := aLinCont[1] 			//Preenche a continuacao da conta contabil
	ADel( aLinCont, 1 )					//Remove a dimensao que foi utilizada
	ASize( aLinCont, Len(aLinCont)-1 )	//Redimensiona o array
EndIf

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R921Totais ³Autor ³ Juan Jose Pereira     ³ Data ³ 23.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Aciona funcoes de totalizacao                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R921Totais( cCredSt )

Local lP1IcmST	:= GetNewPar("MV_P1ICMST",.F.)
Local lProcST	:= (cCredSt == '4')

R921Transp(IIf(lP1IcmST,IIf(lProcST,.T.,.F.),.F.))
R921TotDia(IIf(lP1IcmST,IIf(lProcST,.T.,.F.),.F.))
R921TotPer(IIf(lP1IcmST,IIf(lProcST,.T.,.F.),.F.))
R921TotMes(IIf(lP1IcmST,IIf(lProcST,.T.,.F.),.F.))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Resumo por CFO ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
R921ResCfo(IIf(lP1IcmST,IIf(lProcST,.T.,.F.),.F.))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Resumo por Estado ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
R921ResEst()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R921IniGrade³Autor³ Juan Jose Pereira     ³ Data ³ 23.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Inicializa array aGrade do registro de entradas            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R921IniGrade
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta grade de impressao            ³
//³ [1]=Codigo de Operacao              ³
//³ [2]=Base / Isentas / Outras         ³
//³ [3]=Valor do imposto                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aGrade:=Array(7)
aGrade[1]:={"1",0,0} //
aGrade[2]:={"2",0,0} // ICMS
aGrade[3]:={"3",0,0} //
aGrade[4]:={"1",0,0} //
aGrade[5]:={"2",0,0} // IPI
aGrade[6]:={"3",0,0} //
aGrade[7]:={"1",0,0} // ICMS-ST

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R921ImpGrade³Autor³ Juan Jose Pereira     ³ Data ³ 23.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime aGrade do registro de entradas                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R921ImpGrade

Local nVlrCont:=aDados[8]
Local nX 		:= 0
Local cICMS		:= "ICMS"
Local cIPI 		:= "IPI "
LOcal cICMST	:= "RET." 
Local nMaxCol	:= 14

For nx:=1 to Len(aGrade)
	If !lImpZer.and.(aGrade[nx,2]+aGrade[nx,3]+IIf(nx==1,nVlrCont,0))==0
		Loop
	Endif
	If nx<=3				// nx=1 (ICMS Tributado), nx=2 (ICMS Isento), nx=3 (ICMS Outros)
		aDados[11]:=cICMS
	Elseif nx>3 .and. nx<7  // nx=4 (IPI Tributado), nx=5 (IPI Isento), nx=6 (IPI Outros)
		aDados[11]:=cIPI
	ElseIf nx = 7 .and. MV_PAR19 <> 1 
		aDados[11]:= cICMST
	Endif
	If MV_PAR19 <> 1 .Or. nx <> 7
		aDados[12]:=aGrade[nx,1]
		aDados[13]:=aGrade[nx,2]
		aDados[15]:=aGrade[nx,3]
	EndIF
	R921LoadObs()
	FmtLin(@aDados,aL[9],cPictVl,,@nLin)

	nPosObs:=Ascan(aObs,{|x|x[2]})
	While nPosObs>0
		R921LoadObs()
		If nPosObs>0
			FmtLin(@aDados,aL[9],cPictVl,,@nLin)
		Endif
	End
Next nx

Return
