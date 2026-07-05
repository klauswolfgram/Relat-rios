/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER564.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER564   ºAutor  ³Alexandre Silva     º Data ³  10/07/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gera o arquivo de exportacao para o programa BPS            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Liquidacion - Uruguai                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programador  ³ Data     ³ FNC            ³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³±±
±±³Rogerio R.   ³29/07/2009³00000018278/2009³Compatibilizacao dos fontes para aumento do³±±
±±³             ³          ³                ³campo filial e gestão corporativa.         ³±±
±±³Alex         ³17/03/2010³00000004209/2010³Compatibilizacao dos fontes para aumento do³±±
±±³             ³          ³                ³campo filial e gestão corporativa.         ³±±
±±³Alex         ³18/06/2010³00000013593/2010³Adaptacao da geracao BPS, respeitando as   ³±±
±±³             ³          ³                ³mudancas de Layout - Atyro Versao 3.1      ³±±
±±³Christiane V.³11/08/2010³00000017741/2010³Verificação dos campos criados pelo update ³±±
±±³Alex         ³03/09/2010³00000013593/2010³Carregamento do Parametro 99 - Dados       ³±±
±±³             ³          ³                ³mudancas de Layout - Atyro Versao 3.1      ³±±
±±³Alex         ³10/09/2010³00000013593/2010³Criacao de novas tabelas auxiliares para   ³±±
±±³             ³          ³                ³considerar nos registros gerados.          ³±±
±±³Alex         ³16/09/2010³00000013593/2010³Campo RA_CATCONS, pode nao ser preenchido  ³±±
±±³             ³          ³                ³controlar para respeitar no Array.         ³±±
±±³Raquel Hager ³07/03/12  ³00000004140/2012³Criacao de funcao AjustSx1 para remocao de ³±±
±±³        	  ³          ³                ³de validacao no grupo de perguntas GPR564. ³±±
±±³             ³          ³                ³                                           ³±±
±±³Jonathan Glez³06/05/2015³      PCREQ-4256³Se elimina la funcion AjustaSX1, la cual   ³±±
±±³             ³          ³                ³realiza la modificacion aldiccionario de   ³±±
±±³             ³          ³                ³datos(SX1) por motivo de adecuacion a nueva³±±
±±³             ³          ³                ³estructura de SXs para version 12          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GPER564()

Private NomeProg 	:= "GPER564"
Private WnRel		:= "GPER564"    //Nome Default do relatorio em Disco
Private cPerg    	:= "GPR564"
Private Titulo	:= FunDesc()

If cPaisLoc == "URU"
	DbSelectArea("SRA")
	IF !( SRA->( FieldPos( "RA_TIPTKAL" ) ) > 0 )  //Verificar se o campo existe, caso não exista não foi executado o update
		Aviso(STR0003, STR0004, { "OK" } )         //e os novos perguntes não foram criados.
	    Return
	Endif
Endif

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
  ³ mv_par09        //  Situa‡äes                                ³
  ³ mv_par10        //  Categorias                               ³
  ³ mv_par11        //  Periodo que desejado do relatorio.       ³
  ³ mv_par12        //  Opcao completo ou atualizacao            ³
  ³ mv_par13        //  Tipo de Declaracao                       ³
  ³ mv_par14        //  Nome do Gestor                           ³
  ³ mv_par15        //  Pessoa de contato com o BPS              ³
  ³ mv_par16        //  E-mail                                   ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/

If Pergunte("GPR564",.T.)
	RptStatus({|lEnd| U_GPER564Imp(@lEnd,wnRel,"SRA")},Titulo)
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER564Imp   ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao do Relatorio.                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPer564Imp(lEnd,wnRel,cAlias)

Local nArqSaida		:=	0
Local cSitFunc		:= ""
Local cFilialAnt 	:= ""
Local cFuncaoAnt 	:= ""
Local cCcAnt     	:= ""
Local cLinha1		:= ""
Local cLinha4		:= ""
Local cLinha6		:= ""
Local cLinha7		:= ""
Local cLinha7M		:= ""
Local cLinha7IRP	:= ""
Local cLinha7CESS	:= ""
Local cLinha8		:= ""
Local cLinha12		:= ""
Local cArqMov 		:= ""
Local cAliasMov 	:= ""
Local cSavDatPic	:= Set(4)//Salva o formato da data atual
Local dDtPesqAf		:= Ctod("")
Local aInfoFil		:= {}
Local aOrdBag    	:= {}
Local lOk			:= .F.
Local nBaseImpo		:=	0
Local nOpcao 		:= 0
Local nS			:= 0
#IFDEF TOP
	Local nX
#ENDIF

Private cArqSaida  		:= "" //Antigo mv_par01
Private cFilDe      	:= mv_par02
Private cFilAte     	:= mv_par03
Private cCcDe       	:= mv_par04
Private cCcAte      	:= mv_par05
Private cMatDe      	:= mv_par06
Private cMatAte     	:= mv_par07
Private cNomeDe     	:= mv_par08
Private cNomeAte    	:= mv_par09
Private cSituacao   	:= mv_par10
Private cCategoria   	:= mv_par11
Private dPeriodo		:= mv_par12
Private cNomeGestoria	:= mv_par15
Private cContato		:= mv_par13
Private cEmail			:= mv_par14

Private cTipoDecl		:= ""
Private cSitQuery		:= ""
Private cCatQuery		:= ""
Private cMesAnoRef	:= ""
Private cAnoMesRef	:= ""
Private aCodFol		:= {}
Private cPathSystem := ""
cAnoMesRef			:= AnoMes(dPeriodo)
cMesAnoRef			:= StrZero(Month(dPeriodo),2) + StrZero(Year(dPeriodo),4)

For nS:=1 to Len(cSituacao)
	cSitQuery += "'"+Subs(cSituacao,nS,1)+"'"
	If (nS+1) <= Len(cSituacao)
		cSitQuery += ","
	EndIf
Next

For nS:=1 to Len(cCategoria)
	cCatQuery += "'"+Subs(cCategoria,nS,1)+"'"
	If ( nS+1) <= Len(cCategoria)
		cCatQuery += ","
	EndIf
Next nS

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Cria o Arquivo BPS                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  mv_par01 == 1
	cTipoDecl := "N"
ElseIf mv_par01 == 2
	cTipoDecl := "R"
Else
	cTipoDecl := "D"
Endif
cArqSaida   := AllTrim(cTipoDecl) +"_"+ SM0->M0_CODIGO+FWGETCODFILIAL +"_"+cMesAnoRef+".bps"

If File(cArqSaida)
	nOpcao:= Aviso('Advertencia','lo archivo '+Alltrim(cArqSaida)+' ya existen y será sustituido.'+CRLF+'Confirma?',{'sin','No'})
	If nOpcao	<> 1
		Return
	Endif
Endif
nArqSaida := fCreate(cArqSaida)
If nArqSaida == -1
	If nOpcao == 1
		Aviso('Advertencia','lo archivo '+cArqSaida+' no se puede abrir en modo exclusivo',{'Ok'})
	Else
		Aviso('Advertencia','lo archivo '+cArqSaida+' no se puede crear',{'Ok'})
	Endif
	Return
Else
	fWrite(nArqSaida,Space(300)+CRLF)
EndIf

dbSelectArea("SRA")
dbSetOrder(1)
ProcRegua(SRA->(RecCount()))

#IFDEF TOP
	If TcSrvType() != "AS/400"
		cQuery := " SELECT COUNT(*) TOTAL "
		cQuery += " FROM "+	RetSqlName("SRA")
		cQuery += " WHERE RA_FILIAL between '" + cFilDe + "' AND '" + cFilAte + "'"
		cQuery += " AND RA_MAT     between '" + cMatDe + "' AND '" + cMatAte + "'"
		cQuery += " AND RA_NOME    between '" + cNomeDe + "' AND '" + cNomeAte + "'"
		cQuery += " AND RA_CC      between '" + cCcDe  + "' AND '" + cCcate  + "'"
		cQuery += " AND RA_CATFUNC IN (" + Upper(cCatQuery) + ")"
		cQuery += " AND RA_SITFOLH IN (" + Upper(cSitQuery) + ")"
		cQuery += " AND D_E_L_E_T_ <> '*' "
	Else
		cQuery := " SELECT COUNT(*) TOTAL "
		cQuery += " FROM "+	RetSqlName("SRA")
		cQuery += " WHERE RA_FILIAL  >= '" + cFilDe + "' AND RA_FILIAL  <= '" + cFilAte + "'"
		cQuery += " AND RA_MAT     >= '" + cMatDe + "' AND RA_MAT     <= '" + cMatAte + "'"
		cQuery += " AND RA_NOME    >= '" + cNomeDe + "' AND RA_NOME    <= '" + cNomeAte + "'"
		cQuery += " AND RA_CC      >= '" + cCcDe  + "' AND RA_CC      <= '" + cCcate  + "'"
		cQuery += " AND @DELETED@ <> '*' "
	EndIf

	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'QUERY', .F., .T.)
	dbSelectArea("QUERY")
	nTotalQ := QUERY->TOTAL
	ProcRegua(nTotalQ)		// Total de Elementos da regua
	QUERY->( dbCloseArea() )
	dbSelectArea("SRA")

	If TcSrvType() != "AS/400"
		cQuery := " SELECT * "
		cQuery += " FROM "+	RetSqlName("SRA")
		cQuery += " WHERE RA_FILIAL between '" + cFilDe + "' AND '" + cFilAte + "'"
		cQuery += " AND RA_MAT      between '" + cMatDe + "' AND '" + cMatAte + "'"
		cQuery += " AND RA_NOME     between '" + cNomeDe + "' AND '" + cNomeAte + "'"
		cQuery += " AND RA_CC       between '" + cCcDe  + "' AND '" + cCcate  + "'"
		cQuery += " AND RA_CATFUNC IN (" + Upper(cCatQuery) + ")"
		cQuery += " AND RA_SITFOLH IN (" + Upper(cSitQuery) + ")"
		cQuery += " AND D_E_L_E_T_ <> '*' "
	Else
		cQuery := "SELECT * "
		cQuery += " FROM "+	RetSqlName("SRA")
		cQuery += " WHERE RA_FILIAL>= '" + cFilDe + "' AND RA_FILIAL  <= '" + cFilAte + "'"
		cQuery += " AND RA_MAT     >= '" + cMatDe + "' AND RA_MAT     <= '" + cMatAte + "'"
		cQuery += " AND RA_NOME    >= '" + cNomeDe + "' AND RA_NOME    <= '" + cNomeAte + "'"
		cQuery += " AND RA_CC      >= '" + cCcDe  + "' AND RA_CC      <= '" + cCcate  + "'"
		cQuery += " AND @DELETED@ <> '*' "
	EndIf
	cQuery   += " ORDER BY RA_FILIAL, RA_MAT"
	aStruSRA := SRA->(dbStruct())
	SRA->( dbCloseArea() )
	dbSelectArea("SRC")
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SRA', .F., .T.)
	For nX := 1 To Len(aStruSRA)
		If ( aStruSRA[nX][2] <> "C" )
			TcSetField('SRA',aStruSRA[nX][1],aStruSRA[nX][2],aStruSRA[nX][3],aStruSRA[nX][4])
		EndIf
	Next nX
#ELSE
	dbSetOrder(1)
	dbSeek(cFilDe + cMatDe , .T. )
#ENDIf

SetRegua(SRA->(RecCount()))

While ! Eof() .And. SRA->RA_FILIAL + SRA->RA_MAT <= cFilAte + cMatAte

  	IncRegua()  // Incrementa a regua

	If lEnd
		@Prow()+1,0 PSAY cCancel
		Exit
	Endif

	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  |        Incio Consistencia da Parametrizacao do Intervalo de Impressao          |
	  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If (SRA->RA_NOME < cNomeDe)  .Or. (SRA->Ra_NOME > cNomeAte)  .Or. ;
	   (SRA->RA_MAT < cMatDe)    .Or. (SRA->Ra_MAT > cMatAte)    .Or. ;
	   (SRA->RA_CC < cCcDe)      .Or. (SRA->Ra_CC > cCcAte)
		SRA->(dbSkip(1))
		Loop
	EndIf

	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  ³ Verifica Data Demissao         ³
	  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	cSitFunc := SRA->RA_SITFOLH
	dDtPesqAf:= CTOD("01/" + Str(Month(dPeriodo)) +  "/" + Str(Year(dPeriodo)),"DDMMYY")
	If cSitFunc == "D" .And. (!Empty(SRA->RA_DEMISSA) .And. MesAno(SRA->RA_DEMISSA) > MesAno(dDtPesqAf))
		cSitFunc := " "
	Endif
	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  ³ Consiste situacao e categoria dos funcionarios			     |
	  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If !( cSitFunc $ cSituacao ) .OR. !( SRA->RA_CATFUNC $ cCategoria )
	   SRA->(dbSkip())
	   Loop
	Endif

	If cSitFunc == "D"
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

	If SRA->RA_ADMISSA >= dPeriodo
		SRA->(dbSkip())
		Loop
	EndIf

	Private cTipoDoc	:= IIf(SRA->RA_TIPODOC == "1","DO","PA")

	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  |        Fim Consistencia da Parametrizacao do Intervalo de Impressao   		   |
	  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/

	If nArqSaida != 0
		/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		  ³Muda o formato da data.³
		  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		Set(4,"dd/mm/yyyy")

		If  mv_par01 == 1		//Nóminas
			cLinha4		:= GeraTipo4(aInfoFil,nBaseImpo)	//Gera um registro tipo 4
			cLinha5		:= GeraTipo5(aInfoFil)				//Gera um registro tipo 5
			cLinha6		:= GeraTipo6(aInfoFil)				//Gera um registro tipo 6
			cLinha7		:= GeraTipo7(aInfoFil)				//Gera um registro tipo 7 Aguinaldo
			cLinha7M      := GeraTipo7M(aInfoFil)				//Gera um registro tipo 7 Monto Mensal
			cLinha7IRP    := GeraTipo7IRP(aInfoFil)			//Gera um registro tipo 7 IRP
			cLinha7CESS	:= GeraTipo7Cess(aInfoFil)			//Gera um registro tipo 7 CESS
			If ! Empty(cLinha4) .And. ! Empty(cLinha5)  .And. ! Empty(cLinha6) .And. (! Empty(cLinha7) .OR. ! Empty(cLinha7M) .OR. ! Empty(cLinha7IRP) .OR. Empty(cLinha7CESS))
				GravaTxt(nArqSaida,cLinha4)
				GravaTxt(nArqSaida,cLinha5)
				GravaTxt(nArqSaida,cLinha6)
				If cLinha7M != ""
					GravaTxt(nArqSaida,cLinha7M)
				EndIf
				If cLinha7 != ""
					GravaTxt(nArqSaida,cLinha7)
				EndIf
				If cLinha7IRP != ""
					GravaTxt(nArqSaida,cLinha7IRP)
				EndIf
				If cLinha7CESS != ""
					GravaTxt(nArqSaida,cLinha7CESS)
				EndIf

				lOk	:= .T.
			EndIf
		ElseIf mv_par01 == 2	//Rectificativas
			cLinha4		:= GeraTipo4(aInfoFil,nBaseImpo)	//Gera um registro tipo 4
			cLinha5		:= GeraTipo5(aInfoFil)				//Gera um registro tipo 5
			If ! Empty(cLinha4) .And. ! Empty(cLinha5)
				GravaTxt(nArqSaida,cLinha4)
				GravaTxt(nArqSaida,cLinha5)
				lOk	:= .T.
			EndIf
		Else 					//Deducciones
			cLinha5		:= GeraTipo5(aInfoFil)				//Gera um registro tipo 5
			If ! Empty(cLinha5)
				GravaTxt(nArqSaida,cLinha5)
				lOk	:= .T.
			EndIf
			cLinha8		:= GeraTipo8(aInfoFil)				//Gera um registro tipo 8
			If cLinha8 != ""
				GravaTxt(nArqSaida,cLinha8)
			EndIf
		Endif
		/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		  ³Retorna o padrao anterior ³
		  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		Set(4,cSavDatPic)
	EndIf
	SRA->(dbSkip())
Enddo
/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Seleciona arq. defaut do Siga caso Imp. Mov. Anteriores      ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
If !Empty( cAliasMov )
	fFimArqMov( cAliasMov , aOrdBag , cArqMov )
EndIf

If lOk
	If fInfo(@aInfoFil,cFilAnt)
		cLinha12	:= GeraTipo12(aInfoFil)		//Gera um registro tipo 12
		If ! Empty(cLinha12)
			GravaTxt(nArqSaida,cLinha12)
		EndIf
		cLinha1	:= GeraTipo1(aInfoFil,nBaseImpo)//Gera um registro tipo 1
		If ! Empty(cLinha1)
			GravaTxt(nArqSaida,cLinha1,.T.)
		EndIf

		cPathSystem = GetPvProfString( GetEnvServer(), "StartPath", "", GetADV97() )
		MsgInfo(STR0001+ CRLF+ "En: "+ cPathSystem + cArqSaida,STR0001) //"La generacion del archivo fue concluida con exito."
	Endif
Else
	MsgInfo(STR0002)	 //"No fueron encontrados datos para generacion del archivo."
EndIf

If nArqSaida != 0
	fClose(nArqSaida)
EndIf

dbSelectArea("SRA")
dbCloseArea()

ChkFile("SRA")

dbSelectArea( "SRI" )
dbSelectArea( "SRA" )

Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GeraTipo1 ³ Autor ³Alexandre Silva        ³ Data ³ 21/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a geracao do arquivo de exportacao.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³GeraTipo1 	                							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³GPER564                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GeraTipo1(aInfoFil,nBaseImpo)
	Local cRetLinha	:= ""
	Local cBPS			:= ""
	Local cTipoCont	:= ""
	Local cTipoApor	:= ""
	Local cTipoVen	:= ""
	Local cEstNomi	:= ""
	Local cSeq			:=	"0"
	Local nX			:=	0
	Local aDados		:=	{}
	Local cTelefone	:=	aInfoFil[10]
	Local cFax			:=	aInfoFil[11]

	If  mv_par01 == 1
		cTipoDecl := "N"
	ElseIf mv_par01 == 2
		cTipoDecl := "R"
	Else
		cTipoDecl := "D"
	Endif

	If FpHist82(xFilial("SRX"),"99",RhTamFilial(Space(FWGETTAMFILIAL))+"01")
		cBPS    	:= SubStr(SRX->RX_TXT,01,15)
	EndIf

	If FpHist82(xFilial("SRX"),"99",RhTamFilial(Space(FWGETTAMFILIAL))+"04")
		cTipoCont   := Alltrim(Substr(SRX->RX_TXT,29,2))
		cTipoApor   := Alltrim(Substr(SRX->RX_TXT,28,1))
		cTipoVen		:= Alltrim(Substr(SRX->RX_TXT,35,1))
	EndIf

	If cSeq == "0"
		cEstNomi	:= "INI"
	EndIf

	cTelefone	:=	StrTran(cTelefone,'+','')
	cTelefone	:=	StrTran(cTelefone,'(','')
	cTelefone	:=	StrTran(cTelefone,')','')
	cFax     	:=	StrTran(cFax     ,'+','')
	cFax     	:=	StrTran(cFax     ,'(','')
	cFax     	:=	StrTran(cFax     ,')','')

	aDados		:=	Array(10)
	aDados[01]	:=	 "1"							//Tipo registro
	aDados[02]	:=	 cTipoDecl						//Tipo de declaracao
	aDados[03]	:=	 "3.1"							//Versao do arquivo
	aDados[04]	:=	 "Protheus - Microsiga"			//Aplicacao
	aDados[05]	:=	 Alltrim(cBPS)					//N da empresa
	aDados[06]	:=	 Alltrim(aInfoFil[08])			//N contribuinte
	aDados[07]	:=	 cTipoApor						//Tipo do pagamento
	aDados[08]	:=	 AllTrim(aInfoFil[03])			//Razao Social
	aDados[09]	:=	 Alltrim(aInfoFil[04])			//Endereco
	aDados[10]	:=	 cTelefone						//Telefone

	If ExistBLock('GPR564')
		aDados	:=	ExecBLock('GPR564',.F.,.F.,{'1',aDados})
	Endif

	For nX:= 1 To Len(aDados)
		cRetLinha	+=	'|'+aDados[nX]
	Next

	Return Substr(cRetLinha,2)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GeraTipo2 ³ Autor ³Alexandre Silva        ³ Data ³ 21/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a geracao REGISTRO TIPO 2 - Contratista/Sub contratista ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³GeraTipo2                			    					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³GPER564                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GeraTipo2()
	Local cRetLinha	:= ""
	Local cBPS			:= ""
	Local aDados		:=	Array(17)
	Local nX			:=	0

	If FpHist82(xFilial("SRX"),"99",RhTamFilial(Space(FWGETTAMFILIAL))+"01")
		cBPS    	:= SubStr(SRX->RX_TXT,01,15)
	EndIf

	aDados[01]	:=	"2"	   	   		//Tipo de registro
	aDados[02]	:=	Alltrim(cBPS)	//N° Empresa contratista
	aDados[03]	:=	aInfoFil[08]	//N° Contribuyente contratista
	aDados[04]	:=	aInfoFil[03]	//Denominación del contribuyente Contratista
	aDados[05]	:=	aInfoFil[04]	//Domicilio Empresa
	aDados[06]	:=	cTelefone		//Teléfono

	If ExistBLock('GPR564')
		aDados	:=	ExecBLock('GPR564',.F.,.F.,{'2',aDados})
	Endif

	For nX:= 1 To Len(aDados)
		cRetLinha	+=	'|'+aDados[nX]
	Next

	Return Substr(cRetLinha,2)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GeraTipo5 ³ Autor ³Alexandre Silva        ³ Data ³ 21/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a geracao do REGISTRO TIPO 5 - PERSONAS                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³GeraTipo5  		               							    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³GPER564                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GeraTipo5()
	Local cRetLinha	:= ""
	Local cNacion	:= "3"
	Local cSexo		:= Iif(SRA->RA_SEXO == "M","1","2")
	Local aDados	:=	Array(11)
	Local nX        :=	0
	Local cCodPais  := ""

	If FpHist82(xFilial("SRX"),"99",RhTamFilial(Space(FWGETTAMFILIAL))+"54")
		cCodPais := SubStr(SRX->RX_TXT,01,30)
	EndIf

	If SRA->RA_NACIONA == "10"
		cNacion	:= "1"
	ElseIF SRA->RA_NACIONA == "20"
		cNacion	:= "2"
	EndIf

	aDados[01]	:=	"5"								//Tipo de registro
	aDados[02]	:=	cNacion							//País del documento
	aDados[03]	:=	cTipoDoc 						//Tipo de Documento 	DO ou PA
	aDados[04]	:=	Alltrim(SRA->RA_RG)			    //Número de documento
	aDados[05]	:=	Alltrim(SRA->RA_APELIDO)		//Primer apellido
	aDados[06]	:=	Alltrim(Substr(SRA->RA_SECSOBR,1,15))	//Segundo apellido
	aDados[07]	:=	Alltrim(SRA->RA_PRINOME)		//Primer nombre
	aDados[08]	:=	Alltrim(SRA->RA_SECNOME)		//Segundo nombre
	aDados[09]	:=	Alltrim(Substr(LimpaStr(DtoC(SRA->RA_NASC)),1,8))		    //Fecha de nacimiento
	aDados[10]	:=	Alltrim(Substr(cSexo,1,01))	    //Sexo
	aDados[11]	:=	Alltrim(cNacion)				//Nacionalidad

	If ExistBLock('GPR564')
		aDados	:=	ExecBLock('GPR564',.F.,.F.,{'3',aDados})
	Endif

	For nX:= 1 To Len(aDados)
		cRetLinha	+=	'|'+aDados[nX]
	Next

	Return Substr(cRetLinha,2)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GeraTipo4 ³ Autor ³Alexandre Silva        ³ Data ³ 21/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a geracao do REGISTRO TIPO 4 - Cabezal de nomina        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³GeraTipo4                 							      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³GPER564                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GeraTipo4(aInfoFil,nBaseImpo)
	Local cRetLinha	:= ""
	Local cNacion	:= "3"
	Local cLocal	:= "1"
	Local cTipRem	:= "1"
	Local cTipoApor := ""
	Local cTipoCont := ""
	Local cTipoVen 	:= ""
	Local nX		:=	0
	Local aDados	:=	Array(6)
	Local cTelefone	:=	aInfoFil[10]
	Local cFax		:=	aInfoFil[11]
	Local cDtIniAt := Space(08)
	Local cDtIngr
	Local bCond	:=	{|| SRC->RC_PD<>aCodFol[25,1]} //A verba referente a 13ro na rescisao deve ser lancada separada
	Local aValBps	:= CalcBps(bCond)

	cTelefone	:=	StrTran(cTelefone,'+','')
	cTelefone	:=	StrTran(cTelefone,'(','')
	cTelefone	:=	StrTran(cTelefone,')','')
	cFax     	:=	StrTran(cFax     ,'+','')
	cFax     	:=	StrTran(cFax     ,'(','')
	cFax     	:=	StrTran(cFax     ,')','')

	If SRA->RA_NACIONA == "10"
		cNacion	:= "1"
	ElseIf SRA->RA_NACIONA == "20"
		cNacion	:= "2"
	EndIf

	If FpHist82(xFilial("SRX"),"99",RhTamFilial(Space(FWGETTAMFILIAL))+"02")
		cDtIniAt := Substr(SRX->RX_TXT, 1,8)
		cLocal   := Substr(SRX->RX_TXT,10,3)
	EndIf

	If FpHist82(xFilial("SRX"),"99",RhTamFilial(Space(FWGETTAMFILIAL))+"04")
		cTipoCont   := Alltrim(Substr(SRX->RX_TXT,29,2))
		cTipoApor   := Alltrim(Substr(SRX->RX_TXT,28,1))
		cTipoVen	:= Alltrim(Substr(SRX->RX_TXT,35,1))
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³A Data de Admissao do funcionario deve ser menor ou igual a Data de Inicio³
	//³ de Atividade da Empresa    bops 75897                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cDtIngr := DtoC(Max(Stod(cDtIniAt),SRA->RA_ADMISSA))

	Do Case
		Case Upper(SRA->RA_CATFUNC) $ "M"
			cTipRem	:= "1"
		Case Upper(SRA->RA_CATFUNC) $ "DHS"
			cTipRem	:= "2"
		Case Upper(SRA->RA_CATFUNC) $ "3"
			cTipRem	:= "3"
		Case Upper(SRA->RA_CATFUNC) $ "C"
			cTipRem	:= "4"
		Case Upper(SRA->RA_CATFUNC) $ ""
			cTipRem	:= "5"
	EndCase
	nBaseImpo := aValBps[1]
	aDados[01]	:=	"4"							 						//Tipo de registro
	aDados[02]	:=	cMesAnoRef							 				//Mes cargo
	aDados[03]	:=	"1"							 						//Tipo de contribuyente
	aDados[04]	:=	Alltrim(Transform(nBaseImpo,'999999999999999.99'))	//Total do pagamento (Monto)

	If Val(SRA->RA_CATCONS) == 2
		aDados[05]	:=	"1"												//Forma de realización de la obra
		aDados[06]	:=	"01"											//Actividad principal
	Else
		aDados[05]	:=	""												//Forma de realización de la obra
		aDados[06]	:=	""												//Actividad principal
	EndIf

	If ExistBLock('GPR564')
		aDados	:=	ExecBLock('GPR564',.F.,.F.,{'4',aDados})
	Endif

	For nX:= 1 To Len(aDados)
		cRetLinha	+=	'|'+aDados[nX]
	Next

	Return Substr(cRetLinha,2)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GeraTipo5d³ Autor ³Alexandre Silva        ³ Data ³ 21/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gera o regsitro tipo 5 para 13 salario.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³GeraTipo5d                							      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³GPER564                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GeraTipo5d(nValorAcum)

Local cRetLinha:=	""
Local nValBps	:=	0
Local nX			:=	0
Local aDados	:=	Array(28)
Local cTipoDoc	:= IIf(SRA->RA_TIPODOC == "1","DO","PA")

SRI->(dbSetOrder(1))
SRI->(dbSeek(xFilial("SRI")+SRA->RA_MAT))

Do While SRA->RA_FILIAL+SRA->RA_MAT == SRI->RI_FILIAL+SRI->RI_MAT
	If PosSrv(SRI->RI_PD ,SRA->RA_FILIAL, "RV_INSS" ) == "S" .And. cAnoMesRef	== AnoMes(SRI->RI_DATA)
		nValBps += SRI->RI_VALOR
	EndIf
	SRI->(dbSkip())
EndDo

//Procura os registros referentes a 13ro na rescisao
SRC->(dbSetOrder(1))
If SRC->(dbSeek(xFilial("SRC")+SRA->RA_MAT+aCodFol[25,1]))
	If PosSrv(SRC->RC_PD,SRC->RC_FILIAL,"RV_INSS") == "S"
		nValBps	+=	SRC->RC_VALOR
	Endif
Endif

nValorAcum	+=	nValBps
aDados[01]	:=	"5"							 					//Tipo de registro
aDados[02]	:=	Alltrim(SRA->RA_RG)							//Numero do documento
aDados[03]	:=	SRA->RA_ACUMLAB				 				//Acumalacion laboral
aDados[04]	:=	"2"							 					//Tipo de recebimento
aDados[05]	:=	Alltrim((Transform(nValBps,"99999999999.99")))	//Remuneracao
aDados[06]	:=	""							 						//Categoria (usado em RURAL e construcao CIVIL)
aDados[07]	:=	""						 							//Dias trabalhados
aDados[08]	:=	""						 							//Horas trabalhadas
aDados[09]	:=	""							 						//Asignacion familiar
aDados[10]	:=	""							 						//Seguro de saude
aDados[11]	:=	""							 						//Caixa de atividade (usado em construcao CIVIL)
aDados[12]	:=	""							 						//Jornal(usado em construcao CIVIL)
aDados[13]	:=	""							 						//Outros afazeres(usado em construcao CIVIL)
aDados[14]	:=	""					 								//Causa da dispensa
aDados[15]	:=	""													//Data de baixa
aDados[16]	:=	""													//Enviado
aDados[17]	:=	""							 						//Ratificado
aDados[18]	:=	""						 							//Marca de ratificacao de importe
aDados[19]	:=	""							 						//Marca de ratificacao de alta retroativa
aDados[20]	:=	""							 						//Marca de ratificacao de Baixa retroativa
aDados[21]	:=	""							 						//Marca de ratificacao de dados variaveis
aDados[22]	:=	""						 							//Marca de ratificacao de nova linha.
aDados[23]	:=	""							 						//Sequencia
aDados[24]	:=	""							 						//Marca de alta do ingresso do nomina
aDados[25]	:=	""							 						//Marca de baixa do ingresso do nomina
aDados[26]	:=	""							 						//Marca de modificacao  da nomina
aDados[27]	:=	Alltrim(Substr(cTipoDoc,1,02))					//Tipo do documento (nao esta no arquivo gerado pelo conexion BPS)
aDados[28]	:=	Alltrim(Substr(SRA->RA_CODPAIS,1,05))			//Pais do documento (nao esta no arquivo gerado pelo conexion BPS)

If ExistBLock('GPR564')
	aDados	:=	ExecBLock('GPR564',.F.,.F.,{'5D',aDados})
Endif

For nX:= 1 To Len(aDados)
	cRetLinha	+=	'|'+aDados[nX]
Next

Return Substr(cRetLinha,2)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GeraTipo5v³ Autor ³Alexandre Silva        ³ Data ³ 21/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a geracao do registro tipo 5 para verbas                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³GeraTipo5v                							      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³GPER564                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GeraTipo5v(nValorAcum)
/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³Valores do array a aValBps			   ³
  ³aValBps[1]:= Valor bps        		   ³
  ³aValBps[2]:= Quantidade de horas		   ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Local cRetLinha	:= 	""
Local cTipoDoc	:= 	IIf(SRA->RA_TIPODOC == "1","DO","PA")
Local cTipoRes	:=	""
Local cSalFam	:=	"N"
Local bCond	:=	{|| SRC->RC_PD<>aCodFol[25,1]} //A verba referente a 13ro na rescisao deve ser lancada separada
Local aValBps	:= CalcBps(bCond)
Local cDiasTra	:= "0"
Local nX	:=	0
Local aDados	:=	Array(28)

If aValBps[2] # 0
	cDiasTra := Alltrim((Transform(aValBps[2],"999")))
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Calcular a base imponivel que devera ser gravada ³
//³no registro Tipo 1 no final do arquivo de texto. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nValorAcum	+=	aValBps[1]

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³Verifico o tipo rescisao do funcionario.³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
SRG->(dbSetOrder(1))
If !Empty(SRA->RA_DEMISSA) .And. SRG->(dbSeek(SRA->RA_FILIAl+SRA->RA_MAT))
	While !SRG->(Eof()) .And. SRA->RA_FILIAL+SRA->RA_MAT == SRG->RG_FILIAL+SRG->RG_MAT
		If SRA->RA_DEMISSA 	== SRG->RG_DATADEM
			cTipoRes		:= SRG->RG_TIPORES
			Exit
		EndIf
		SRG->(dbSkip())
	EndDo
EndIf

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³Existe salario familia?³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
SRB->(dbSetOrder(1))
SRB->(dbSeek( SRA->RA_FILIAL + SRA->RA_MAT ))
While !Eof() .And. SRB->RB_FILIAL + SRB->RB_MAT == SRA->RA_FILIAL + SRA->RA_MAT
	If SRB->RB_FILIAL + SRB->RB_MAT == SRA->RA_FILIAL + SRA->RA_MAT .And. SRB->RB_TIPSF $ "1|2"
		cSalFam	:=	"S"
		Exit
	Endif
	SRB->(dbSkip())
EndDo

aDados[01]	:=	"5"							 					//Tipo de registro
aDados[02]	:=	Alltrim(SRA->RA_RG)							//Numero do documento
aDados[03]	:=	SRA->RA_ACUMLAB				 				//Acumulacion laboral
aDados[04]	:=	"1"						 						//Tipo de recebimento
aDados[05]	:=	Alltrim((Transform(aValBps[1],"99999999999.99")))//Remuneracao
aDados[06]	:=	""							 						//Categoria  (usado em RURAL e construcao CIVIL)
aDados[07]	:=	cDiasTra					 						//Dias trabalhados
aDados[08]	:=	"" //cHoraTra					 						//Horas trabalhadas
aDados[09]	:=	cSalFam						 					//Asignacion familiar
aDados[10]	:=	Alltrim(SRA->RA_SEGSAUD)	 				//Seguro de saude
aDados[11]	:=	""							 						//Caixa de atividade (usado em construcao CIVIL)
aDados[12]	:=	""							 						//Jornal(usado em construcao CIVIL)
aDados[13]	:=	""							 						//Outros afazeres(usado em construcao CIVIL)
aDados[14]	:=	cTipoRes					 						//Causa da dispensa
aDados[15]	:=	Alltrim(Substr(LimpaStr(DtoC(SRA->RA_DEMISSA)),1,8))//Data de baixa
aDados[16]	:=	Alltrim(Substr(LimpaStr(DtoC(dDataBase)),1,8))		//Enviado
aDados[17]	:=	""							 						//Ratificado
aDados[18]	:=	""						 							//Marca de ratificacao de importe
aDados[19]	:=	""							 						//Marca de ratificacao de alta retroativa
aDados[20]	:=	""							 						//Marca de ratificacao de Baixa retroativa
aDados[21]	:=	""							 						//Marca de ratificacao de dados variaveis
aDados[22]	:=	""						 							//Marca de ratificacao de nova linha.
aDados[23]	:=	""							 						//Sequencia
aDados[24]	:=	""							 						//Marca de alta do ingresso do nomina
aDados[25]	:=	""							 						//Marca de baixa do ingresso do nomina
aDados[26]	:=	""							 						//Marca de modificacao  da nomina
aDados[27]	:=	Alltrim(Substr(cTipoDoc,1,02))			//Tipo do documento (nao esta no arquivo gerado pelo conexion BPS)
aDados[28]	:=	Alltrim(Substr(SRA->RA_CODPAIS,1,05))	//Pais do documento (nao esta no arquivo gerado pelo conexion BPS)

If ExistBLock('GPR564')
	aDados	:=	ExecBLock('GPR564',.F.,.F.,{'5V',aDados})
Endif

For nX:= 1 To Len(aDados)
	cRetLinha	+=	'|'+aDados[nX]
Next


Return Substr(cRetLinha,2)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³CalcBps   ³ Autor ³Alexandre Silva        ³ Data ³ 21/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz o calculo do valor do bps para o funcionario            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³GeraTipo5                 							      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³CalcBPS                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function CalcBps(bCond,lFerias)

Local nSomVerb	:=	0
Local nHoras	:=	0
Local cVerbHoras:=	"" //Verba de horas.
DEFAULT lFerias	:=	.T.

If Upper(SRA->RA_CATFUNC) $ "M"
 	cVerbHoras	:=  aCodFol[031,01] //Verba de horas.
Else
	cVerbHoras	:=  aCodFol[360,01] //Verba de horas.
EndIf

SRC->(dbSetOrder(1))
SRC->(dbSeek(xFilial("SRC")+SRA->RA_MAT,.T.))

Do While SRA->RA_FILIAL == SRC->RC_FILIAL .And. SRA->RA_MAT == SRC->RC_MAT

	If SRC->RC_PD == cVerbHoras
		nHoras	+= SRC->RC_HORAS
	EndIf

	If bCond==Nil .Or. Eval(bCond)
		If PosSrv(SRC->RC_PD,SRC->RC_FILIAL,"RV_INSS") == "S"
			If PosSrv(SRC->RC_PD,SRC->RC_FILIAL,"RV_TIPOCOD") == "1"
				nSomVerb += SRC->RC_VALOR
			ElseIf PosSrv(SRC->RC_PD,SRC->RC_FILIAL,"RV_TIPOCOD") == "2"
				nSomVerb -= SRC->RC_VALOR
			Endif
		EndIf
	Endif
	SRC->(dbSkip())

EndDo

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³Calculo das ferias     ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
If lFerias
	SRH->(dbSetOrder(1))
	SRH->( MsSeek(SRA->RA_FILIAL+SRA->RA_MAT) )
	While !Eof() .And. SRA->RA_FILIAL+SRA->RA_MAT == SRH->RH_FILIAL+SRH->RH_MAT .And. cAnoMesRef == AnoMes(SRH->RH_DATAINI)
		SRR->(dbSetOrder(1))
		If SRR->(dbSeek(SRA->RA_FILIAL + SRA->RA_MAT +"F" ))
	   		While !Eof() .and. (SRA->RA_FIlIAL+SRA->RA_MAT+"F") == (SRR->RR_FILIAL+SRR->RR_MAT+SRR->RR_TIPO3)
	    		IF SRR->RR_DATA == SRH->RH_DTRECIB
	     			If  PosSrv(SRR->RR_PD,SRR->RR_FILIAL,"RV_INSS") == "S"
	       			If PosSrv(SRR->RR_PD,SRR->RR_FILIAL,"RV_TIPOCOD") == "1"
							nSomVerb += SRR->RR_VALOR
						Else
							nSomVerb -= SRR->RR_VALOR
						Endif
					EndIf
				Endif
				SRR->(dbSkip())
			Enddo
		Endif
		SRH->(dbSkip())
	Enddo
Endif
Return {nSomVerb,nHoras}

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GravaTxt  ³ Autor ³Alexandre Silva        ³ Data ³ 21/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a geracao do arquivo de exportacao.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³GravaTxt(nArqSaida,cLinha,lTopo)						      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³GPER564                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GravaTxt(nArqSaida,cLinha,lTopo)

Local nOpcao	:=	0
Local cVlrLinha	:= 	0
Default lTopo	:= 	.F.

If lTopo
	nOpcao		:= 0
	cVlrLinha	:= cLinha
Else
	nOpcao		:= 2
	cVlrLinha	:=	cLinha+chr(13)+chr(10)
EndIf

If nArqSaida != -1
	fSeek(nArqSaida,0,nOpcao)
	fWrite(nArqSaida,cVlrLinha)
EndIf

Return .T.
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³LimpaStr  ³ Autor ³Alexandre Silva        ³ Data ³ 21/10/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retira caracteres estranhos de um palavra.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³LimpaStr()											      ³±±
±±³Parametros³ExpC1 - Texto para limpeza.							      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function LimpaSTR(cTexto)
Local cTmpCar	:= ""
Local cCarac	:= "-.;/\*,:"
Local nItem		:= 1

For nItem := 1 to Len(cCarac)
	cTmpCar	:= Substr(cCarac,nItem,1)
	cTexto	:= StrTran(cTexto,cTmpCar)
Next nItem

Return cTexto
Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GeraTipo6 ³ Autor ³Alex Sandro Fagundes   ³ Data ³ 21/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a geracao do REGISTRO TIPO 6 - ACTIVIDAD                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³GeraTipo6                 							      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³GPER564                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GeraTipo6(aInfoFil)
	Local cRetLinha	:= ""
	Local cNacion	:= "3"
	Local cLocal	:= "1"
	Local cTipRem	:= "1"
	Local nX			:=	0
	Local aDados	:=	Array(20)
	Local cTelefone:=	aInfoFil[10]
	Local cFax		:=	aInfoFil[11]
	Local cDtIniAt := Space(08)
	Local cSalFam	:=	"N"
	Local cDtIngr
	Local cDiasTra	:= "0"
	Local bCond	:=	{|| SRC->RC_PD<>aCodFol[25,1]} //A verba referente a 13ro na rescisao deve ser lancada separada
	Local aValBps	:= CalcBps(bCond)
	Local cCodEx	:= ""

	If aValBps[2] # 0
		cDiasTra := Alltrim((Transform(aValBps[2],"999")))
	EndIf

	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  ³Existe salario familia?³
	  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	SRB->(dbSetOrder(1))
	SRB->(dbSeek( SRA->RA_FILIAL + SRA->RA_MAT ))
	While !Eof() .And. SRB->RB_FILIAL + SRB->RB_MAT == SRA->RA_FILIAL + SRA->RA_MAT
		If SRB->RB_FILIAL + SRB->RB_MAT == SRA->RA_FILIAL + SRA->RA_MAT .And. SRB->RB_TIPSF $ "1|2"
			cSalFam	:=	"S"
			Exit
		Endif
		SRB->(dbSkip())
	EndDo

	cTelefone	:=	StrTran(cTelefone,'+','')
	cTelefone	:=	StrTran(cTelefone,'(','')
	cTelefone	:=	StrTran(cTelefone,')','')
	cFax     	:=	StrTran(cFax     ,'+','')
	cFax     	:=	StrTran(cFax     ,'(','')
	cFax     	:=	StrTran(cFax     ,')','')

	If SRA->RA_NACIONA == "10"
		cNacion	:= "1"
	ElseIf SRA->RA_NACIONA == "20"
		cNacion	:= "2"
	EndIf

	If FpHist82(xFilial("SRX"),"99",RhTamFilial(Space(FWGETTAMFILIAL))+"02")
		cDtIniAt := Substr(SRX->RX_TXT, 1,8)
		cLocal   := Substr(SRX->RX_TXT,10,3)
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³A Data de Admissao do funcionario deve ser menor ou igual a Data de Inicio³
	//³ de Atividade da Empresa    bops 75897                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cDtIngr := DtoC(Max(Stod(cDtIniAt),SRA->RA_ADMISSA))

	Do Case
		Case Upper(SRA->RA_CATFUNC) $ "M"
			cTipRem	:= "1"
		Case Upper(SRA->RA_CATFUNC) $ "DHS"
			cTipRem	:= "2"
		Case Upper(SRA->RA_CATFUNC) $ "3"
			cTipRem	:= "3"
		Case Upper(SRA->RA_CATFUNC) $ "C"
			cTipRem	:= "4"
		Case Upper(SRA->RA_CATFUNC) $ ""
			cTipRem	:= "5"
	EndCase

	aDados[01]	:=	"6"										//Tipo de registro
	aDados[02]	:=	cMesAnoRef								//Mes cargo
	aDados[03]	:=	Alltrim(SRA->RA_CODPAIS)				//País del documento
	aDados[04]	:=	Alltrim(cTipoDoc)						//Tipo de Documento
	aDados[05]	:=	Alltrim(SRA->RA_RG)						//Número de documento
	aDados[06]	:=	Alltrim(SRA->RA_ACUMLAB)				//Acumulación laboral
	aDados[07]	:=	Alltrim(Substr(LimpaStr(DtoC(SRA->RA_ADMISSA)),1,8))	//Fecha de ingreso
	aDados[08]	:=	cTipRem   								//Tipo de remuneración
	aDados[09]	:=	Alltrim(Transform(SRA->RA_HRSEMAN,"999"))		//Horas semanales
	aDados[10]	:=	Alltrim(SRA->RA_VINFUN)					//Vínculo Funcional
	aDados[11]	:=	Alltrim(SRA->RA_CODEXO)					//Código de exoneración
	//Cómputos especiales
	If (!Empty(SRA->RA_CATCONS))	//Categorias CT
		aDados[12]	:=	"99"
	Else
		aDados[12]	:=	Alltrim(SRA->RA_CBO)
	EndIf
	//Categoría
	If (!Empty(SRA->RA_CATCONS))	//Categorias CT
		aDados[13]	:=	Alltrim(SRA->RA_CATCONS)
	Else
		aDados[13]	:=	""
	EndIf
	//Caja de actividad
	If (!Empty(SRA->RA_CATCONS)) .AND. !Empty(SRA->RA_DEMISSA)//Categorias CT e Desligado
		aDados[14]	:=	"01"
	Else
		aDados[14]	:=	""
	EndIf

	aDados[15]	:=	cSalFam							 		//Asignación familiar
	aDados[16]	:=	cDiasTra								//Días trabajados
	aDados[17]	:=	Alltrim(Transform(SR6->R6_HRNORMA,"999"))	//Horas trabajadas
	//Seguro de Salud
	aDados[18]	:=	AllTrim(SRA->RA_SEGSAUD)			 	//Seguro de Salud
	//Causal de Baja
	If !Empty(SRA->RA_DEMISSA)
		aDados[19]	:=	"001" //Causal de Baja
	Else
		aDados[19]	:=	"" //Causal de Baja
	EndIf
	If MesAno(SRA->RA_DEMISSA) == cMesAnoRef
		aDados[20]	:=	Alltrim(Substr(LimpaStr(DtoC(SRA->RA_DEMISSA)),1,8))	//Fecha de Baja 1
	Else
		aDados[20]	:=	""
	EndIf

	If ExistBLock('GPR564')
		aDados	:=	ExecBLock('GPR564',.F.,.F.,{'4',aDados})
	Endif

	For nX:= 1 To Len(aDados)
		cRetLinha	+=	'|'+aDados[nX]
	Next

	Return Substr(cRetLinha,2)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GeraTipo7 ³ Autor ³Alex Sandro Fagundes   ³ Data ³ 21/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a geracao do REGISTRO TIPO 7 - Remuneración             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³GeraTipo7                 							      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³GPER564                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GeraTipo7(aInfoFil)
	Local cRetLinha	:= ""
	Local aDados	:=	Array(10)
	Local nX        :=	0

	Local nValAguinaldo		 :=	0

	If  mv_par01 == 1
		cTipoDecl := "N"
	ElseIf mv_par01 == 2
		cTipoDecl := "R"
	Else
		cTipoDecl := "D"
	Endif

	//Procura Valores de IR no 13o
	SRI->(dbSetOrder(1))
	SRI->(dbSeek(xFilial("SRI")+SRA->RA_MAT))

	Do While SRA->RA_FILIAL+SRA->RA_MAT == SRI->RI_FILIAL+SRI->RI_MAT
		If PosSrv(SRI->RI_PD ,SRA->RA_FILIAL, "RV_INSS" ) == "S" .And. cAnoMesRef == AnoMes(SRI->RI_DATA) .And. SubStr(cAnoMesRef,4,2) <> "06"
			nValAguinaldo += SRI->RI_VALOR
		EndIf
		SRI->(dbSkip())
	EndDo

	//Procura os registros referentes a 13ro na rescisao
	SRC->(dbSetOrder(1))
	If SRC->(dbSeek(xFilial("SRC")+SRA->RA_MAT+aCodFol[25,1]))
		If PosSrv(SRC->RC_PD,SRC->RC_FILIAL,"RV_INSS") == "S"
			nValAguinaldo += SRC->RC_VALOR
		Endif
	Endif

	If nValAguinaldo > 0 .And. Empty(SRA->RA_CATCONS)

		aDados[01]	:=	"7"														//Tipo de registro
		aDados[02]	:=	cMesAnoRef												//Mes cargo
		aDados[03]	:=	Alltrim(SRA->RA_CODPAIS)								//País del documento
		aDados[04]	:=	cTipoDoc												//Tipo de Documento
		aDados[05]	:=	Alltrim(SRA->RA_RG)							 			//Número de documento
		aDados[06]	:=	Alltrim(SRA->RA_ACUMLAB)								//Acumulación laboral
		//Verifica se considera como Nominas ou Rectificativas
		If cTipoDecl == "N"
			aDados[07]	:=	"2"													//Concepto
		ElseIf cTipoDecl == "R"
			aDados[07]	:=	"12"												//Concepto
		EndIf
		aDados[08]	:=	Alltrim((Transform(nValAguinaldo,"99999999999.99")))	//Remuneración
		aDados[09]	:=	""	//Jornal
		aDados[10]	:=	""	//Otros haberes

		If ExistBLock('GPR564')
			aDados	:=	ExecBLock('GPR564',.F.,.F.,{'4',aDados})
		Endif

		For nX:= 1 To Len(aDados)
			cRetLinha	+=	'|'+aDados[nX]
		Next
	EndIf

	Return Substr(cRetLinha,2)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GeraTipo7M³ Autor ³Alex Sandro Fagundes   ³ Data ³ 21/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a geracao do REGISTRO TIPO 7 - Remuneración             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³GeraTipo7M                							      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³GPER564                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GeraTipo7M(aInfoFil)
	Local cRetLinha	:= ""
	Local aDados	:=	Array(10)
	Local nX        :=	0
	Local cVerbHoras	:= ""

	Local nValMensal	:=	0

	If Upper(SRA->RA_CATFUNC) $ "M"
	 	cVerbHoras	:=  aCodFol[031,01] //Verba de horas.
	Else
		cVerbHoras	:=  aCodFol[360,01] //Verba de horas.
	EndIf

	If  mv_par01 == 1
		cTipoDecl := "N"
	ElseIf mv_par01 == 2
		cTipoDecl := "R"
	Else
		cTipoDecl := "D"
	Endif

	//Procura os registros referentes a Monta Mensual
	SRC->(dbSetOrder(1))
	If SRC->(dbSeek(xFilial("SRC")+SRA->RA_MAT+cVerbHoras))
		If PosSrv(SRC->RC_PD,SRC->RC_FILIAL,"RV_INSS") == "S"
			nValMensal += SRC->RC_VALOR
		Endif
	Endif

	If nValMensal > 0
		aDados[01]	:=	"7"														//Tipo de registro
		aDados[02]	:=	cMesAnoRef												//Mes cargo
		aDados[03]	:=	Alltrim(SRA->RA_CODPAIS)								//País del documento
		aDados[04]	:=	cTipoDoc												//Tipo de Documento
		aDados[05]	:=	Alltrim(SRA->RA_RG)							 			//Número de documento
		aDados[06]	:=	Alltrim(SRA->RA_ACUMLAB)								//Acumulación laboral
		//Verifica se considera como Nominas ou Rectificativas
		If cTipoDecl == "N"
			aDados[07]	:=	"1"													//Concepto
		ElseIf cTipoDecl == "R"
			aDados[07]	:=	"11"												//Concepto
		EndIf
		aDados[08]	:=	Alltrim((Transform(nValMensal,"99999999999.99")))		//Remuneración
		aDados[09]	:=	""	//Jornal
		aDados[10]	:=	""	//Otros haberes

		If ExistBLock('GPR564')
			aDados	:=	ExecBLock('GPR564',.F.,.F.,{'4',aDados})
		Endif

		For nX:= 1 To Len(aDados)
			cRetLinha	+=	'|'+aDados[nX]
		Next
	EndIf

	Return Substr(cRetLinha,2)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GeraTipo7IRP ³ Autor ³Alex Sandro Fagundes³ Data ³ 21/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a geracao do REGISTRO TIPO 7 - Adicional IRP            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³GeraTipo7IRP                 							      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³GPER564                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GeraTipo7IRP(aInfoFil)
	Local cRetLinha	:= ""
	Local aDados	:=	Array(10)
	Local nX        :=	0
	Local cVerbaIRP := aCodFol[015,01] //Código do IRP - Base de Cálculo IRP
	Local nValIRP	:= 0

	//Procura os registros referentes a Monta Mensual
	SRC->(dbSetOrder(1))
	If SRC->(dbSeek(xFilial("SRC")+SRA->RA_MAT+cVerbaIRP))
		nValIRP += SRC->RC_VALOR
	Endif

	If  mv_par01 == 1
		cTipoDecl := "N"
	ElseIf mv_par01 == 2
		cTipoDecl := "R"
	Else
		cTipoDecl := "D"
	Endif

	//Somente cria a linha do registro 7 se existir valor de IRP
	If nValIRP > 0
		aDados[01]	:=	"7"														//Tipo de registro
		aDados[02]	:=	cMesAnoRef												//Mes cargo
		aDados[03]	:=	Alltrim(SRA->RA_CODPAIS)								//País del documento
		aDados[04]	:=	cTipoDoc												//Tipo de Documento
		aDados[05]	:=	Alltrim(SRA->RA_RG)							 			//Número de documento
		aDados[06]	:=	Alltrim(SRA->RA_ACUMLAB)								//Acumulación laboral

		//Verifica se considera como Nominas ou Rectificativas
		If cTipoDecl == "N"
			aDados[07]	:=	"5"													//Concepto
		ElseIf cTipoDecl == "R"
			aDados[07]	:=	"15"												//Concepto
		EndIf

		aDados[08]	:=	Alltrim((Transform(nValIRP,"99999999999.99")))			//Valor do IRP
		aDados[09]	:=	""	//Jornal
		aDados[10]	:=	""	//Otros haberes

		If ExistBLock('GPR564')
			aDados	:=	ExecBLock('GPR564',.F.,.F.,{'4',aDados})
		Endif

		For nX:= 1 To Len(aDados)
			cRetLinha	+=	'|'+aDados[nX]
		Next
	EndIf

	Return Substr(cRetLinha,2)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GeraTipo7Cess³ Autor ³Alex Sandro Fagundes³ Data ³ 21/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a geracao do REGISTRO TIPO 7 - Adicional IRP            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³GeraTipo7Cess                							      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³GPER564                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GeraTipo7Cess(aInfoFil)
	Local cRetLinha	:= ""
	Local aDados	:=	Array(10)
	Local nX        :=	0
	Local cVerbaIRP := aCodFol[015,01] //Código do IRP
	Local nValIRP	:= 0
	Local bSocio	:= .F.

	//Verifica o Vinculo Funcional do funcionário para saber se é Sócio
	If Val(SRA->RA_VINFUN) > 2 .AND. Val(SRA->RA_VINFUN) < 6
		bSocio := .T.
	EndIf

	If bSocio == .T.
		//Procura os registros referentes a Monta Mensual
		SRC->(dbSetOrder(1))
		If SRC->(dbSeek(xFilial("SRC")+SRA->RA_MAT+cVerbaIRP))
			nValIRP += SRC->RC_VALOR
		Endif

		//Somente cria a linha do registro 7 se existir valor de IRP
		If nValIRP > 0
			aDados[01]	:=	"7"														//Tipo de registro
			aDados[02]	:=	cMesAnoRef												//Mes cargo
			aDados[03]	:=	Alltrim(SRA->RA_CODPAIS)								//País del documento
			aDados[04]	:=	cTipoDoc												//Tipo de Documento
			aDados[05]	:=	Alltrim(SRA->RA_RG)							 			//Número de documento
			aDados[06]	:=	Alltrim(SRA->RA_ACUMLAB)								//Acumulación laboral
			aDados[07]	:=	"8"														//Concepto
			aDados[08]	:=	Alltrim((Transform(nValIRP,"99999999999.99")))			//Valor do IRP
			aDados[09]	:=	""	//Jornal
			aDados[10]	:=	""	//Otros haberes

			If ExistBLock('GPR564')
				aDados	:=	ExecBLock('GPR564',.F.,.F.,{'4',aDados})
			Endif

			For nX:= 1 To Len(aDados)
				cRetLinha	+=	'|'+aDados[nX]
			Next
		EndIf
	EndIf

	Return Substr(cRetLinha,2)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GeraTipo8    ³ Autor ³Alex Sandro Fagundes³ Data ³ 24/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a geracao do REGISTRO TIPO 7 - Adicional IRP            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³GeraTipo8                 							      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³GPER564                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GeraTipo8(aInfoFil)
	Local cRetLinha	:= ""
	Local aDados	:=	Array(17)
	Local nX        :=	0
	Local cTipoDocSRB	:= ""
	Local cSexo		:= ""

	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  ³Existe salario familia?³
	  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	SRB->(dbSetOrder(1))
	SRB->(dbSeek( SRA->RA_FILIAL + SRA->RA_MAT ))
	While !Eof() .And. SRB->RB_FILIAL + SRB->RB_MAT == SRA->RA_FILIAL + SRA->RA_MAT
		If SRB->RB_FILIAL + SRB->RB_MAT == SRA->RA_FILIAL + SRA->RA_MAT .And. SRB->RB_TIPSF $ "1|2"
			cSalFam	:=	"S"
			Exit
		Endif
		SRB->(dbSkip())
	EndDo

	cTipoDocSRB	:= IIf(SRB->RB_TIPODOC == 1,"DO","PA")
	cSexo		:= Iif(SRB->RB_SEXO == "M","1","2")

	If cSalFam == "S"
		aDados[01]	:=	"8" 						//Tipo de registro
		aDados[02]	:=	Alltrim(SRA->RA_CODPAIS)	//País del documento
		aDados[03]	:=	cTipoDoc					//Tipo de Documento
		aDados[04]	:=	Alltrim(SRA->RA_RG)			//Nro. De documento
		aDados[05]	:=	"1" 						//País del documento del cónyuge
		aDados[06]	:=	cTipoDocSRB 				//Tipo de Documento del cónyuge
		aDados[07]	:=	Alltrim(SRB->RB_RG) 		//Nro. De documento del cónyuge
		aDados[08]	:=	Alltrim(SRB->RB_APELIDO)  	//Primer apellido del cónyuge
		aDados[09]	:=	""							//Segundo apellido del cónyuge
		aDados[10]	:=	Alltrim(SRB->RB_NOME)  		//Primer nombre del cónyuge
		aDados[11]	:=	Alltrim(SRB->RB_SECNOME)  	//Segundo nombre del cónyuge
		aDados[12]	:=	Alltrim(Substr(LimpaStr(DtoC(SRB->RB_DTNASC)),1,8))  	//Fecha de nacimiento del cónyuge
		aDados[13]	:=	cSexo						//Sexo del cónyuge
		aDados[14]	:=	Alltrim(SRB->RB_NACIONA)	//Nacionalidad del cónyuge
		aDados[15]	:=	Alltrim(Substr(LimpaStr(DtoC(SRB->RB_DTENTRA)),3,6))	//Fecha Desde
		aDados[16]	:=	""							//Causal baja/anulación
		aDados[17]	:=	Alltrim(Substr(LimpaStr(DtoC(SRB->RB_DTENTRA)),1,8))	//Fecha de presentación en empresa

		If ExistBLock('GPR564')
			aDados	:=	ExecBLock('GPR564',.F.,.F.,{'4',aDados})
		Endif

		For nX:= 1 To Len(aDados)
			cRetLinha	+=	'|'+aDados[nX]
		Next
	EndIf

	Return Substr(cRetLinha,2)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GeraTipo12³ Autor ³Alex Sandro Fagundes   ³ Data ³ 21/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a geracao do REGISTRO TIPO 12 - DATOS DE CONTACTO       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³GeraTipo12                							      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³GPER564                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GeraTipo12(aInfoFil)
	Local cRetLinha	:= ""
	Local aDados	:=	Array(7)
	Local nX        :=	0

	aDados[01]	:=	"12"						//Tipo de registro
	aDados[02]	:=	cNomeGestoria				//Nombre de la gestoría
	aDados[03]	:=	Alltrim(SM0->M0_ENDENT)		//Domicilio
	aDados[04]	:=	Alltrim(SM0->M0_TEL)		//Teléfono
	aDados[05]	:=	Alltrim(SM0->M0_FAX)		//Fax - Celular
	aDados[06]	:=	cContato					//Personal de contacto con BPS
	aDados[07]	:=	cEmail						//E-Mail

	If ExistBLock('GPR564')
		aDados	:=	ExecBLock('GPR564',.F.,.F.,{'4',aDados})
	Endif

	For nX:= 1 To Len(aDados)
		cRetLinha	+=	'|'+aDados[nX]
	Next

	Return Substr(cRetLinha,2)
