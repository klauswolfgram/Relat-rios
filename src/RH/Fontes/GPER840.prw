/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER840.CH"

#DEFINE   nColMax	2350
#DEFINE   nLinMax  2900

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER840   ºAutor  ³Erika Kanamori      º Data ³  05/11/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programador  ³ Data     ³ FNC            ³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³±±
±±³Rogerio R.   ³29/07/2009³00000018278/2009³Compatibilizacao dos fontes para aumento do³±±
±±³             ³          ³                ³campo filial e gestão corporativa.         ³±±
±±³Alex         ³17/03/2010³00000004209/2010³Alterada a comparação do xFilial para o    ³±±
±±³             ³          ³                ³parametro 62.                              ³±±
±±³             ³          ³                ³                                           ³±±
±±³Jonathan Glez³07/05/2015³      PCREQ-4256³Se elimina funcion AjustaSX1 la cual       ³±±
±±³             ³          ³                ³realiza la modificacion a diccionario de   ³±±
±±³             ³          ³                ³datos(SX1) por motivo de adecuacion nueva  ³±±
±±³             ³          ³                ³estructura de SXs para V12                 ³±±
±±³             ³          ³                ³                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GPER840()
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Define Variaveis Locais (Basicas)                            ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Local cDesc1 		:= STR0001		//"Aviso de Iniciacion/Cesacion de Servicios"
Local cDesc2 		:= STR0002		//"Se imprimira de acuerdo con los parametros solicitados por el usuario."
Local cDesc3 		:= ""
Local cString		:= "SRA"        // alias do arquivo principal (Base)

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Define Variaveis Private(Basicas)                            ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Private nomeprog	:= "GPER840"
Private aReturn 	:={ , 1,, 2, 2, 1,"",1 }
Private nLastKey 	:= 0
Private cPerg   	:= "GPR840"

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis Utilizadas na funcao IMPR                          ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Private Titulo	    := STR0001		//"Aviso de Iniciacion/Cesacion de Servicios"
Private nTamanho    := "M"
Private nTipo		:= 0
Private cMes		:= ""
Private cFilialDe   := ""
Private cFilialAte  := ""
Private cMatDe      := ""
Private cMatAte     := ""
Private cCustoDe    := ""
Private cCustoAte   := ""
Private cNomeDe     := ""
Private cNomeAte    := ""
Private cCat        := ""
Private oPrint

pergunte("GPR840",.F.)
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Envia controle para a funcao SETPRINT                        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
wnrel:="GPER840"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,,,nTamanho)

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para parametros                         ³
³ mv_par01        //  Tipo de Relatorio (Iniciacao/Cessacao)   ³
³ mv_par02        //  Per.Inicial(MMAAAA)?  				   ³
³ mv_par03        //  Per.Final(MMAAAA)? 					   ³
³ mv_par04        //  Filial De?                               |
³ mv_par05        //  Filial Ate?                              |
³ mv_par06        //  Matricula De                             ³
³ mv_par07        //  Matricula Ate                            ³
³ mv_par08        //  Centro de Custo De                       ³
³ mv_par09        //  Centro de Custo Ate                      ³
³ mv_par10        //  Nome De                                  ³
³ mv_par11        //  Nome Ate                                 ³
³ mv_par12        //  Categorias a Imp?                        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
nOrdem   := aReturn[8]

nTipo		:= mv_par01
cPerDe		:= mv_par02
cPerAte		:= mv_par03
cFilialDe   := mv_par04
cFilialAte  := mv_par05
cMatDe      := mv_par06
cMatAte     := mv_par07
cCustoDe    := mv_par08
cCustoAte   := mv_par09
cNomeDe     := mv_par10
cNomeAte    := mv_par11
cCat        := mv_par12


	//-- Objeto para impressao grafica
	oPrint 	:= TMSPrinter():New( If(nTipo == 1, STR0003, STR0004 ) ) //"Aviso de Iniciacion de Servicios" ou "Aviso de Cesacion de Servicios"

	oPrint:SetPortrait()


Titulo := If(nTipo == 1, STR0003, STR0004 )//"Aviso de Iniciacion de Servicios" ou "Aviso de Cesacion de Servicios"


RptStatus({|lEnd| IMPAFC(@lEnd)},Capital(Titulo))

	oPrint:Preview()  							// Visualiza impressao grafica antes de imprimir

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IMPAFC    ºAutor  ³Erika Kanamori      º Data ³  05/11/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function IMPAFC(lEnd)

Local cAcessaSRA	:= &( " { || " + ChkRH( "GPER840" , "SRA", "2" ) + " } " )
Local aCodFol   := {}
Local cCateg := ""
Local nAux:= 0
Local nFor:= 0
Local cFilAnt:= ""
Local lAFP := .T.

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis para controle em ambientes TOP.                    ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Local cAlias   := ""
Local cQuery
Local aStruct  := {}
Local lQuery  := .F.



//Vaviaveis private para impressao
Private nLin := 20
Private nLinha:= 0850
Private cAFP := ""
Private aInfo:= {}
Private cQrySRA := "SRA"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Objetos para Impressao Grafica - Declaracao das Fontes Utilizadas.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private oFont08, oFont09, oFont10n, oFont12n


oFont06	:= TFont():New("Courier New",06,06,,.F.,,,,.T.,.F.)
oFont07	:= TFont():New("Courier New",07,07,,.F.,,,,.T.,.F.)
oFont08	:= TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)
oFont09	:= TFont():New("Courier New",09,09,,.F.,,,,.T.,.F.)
oFont10	:= TFont():New("Courier New",10,10,,.F.,,,,.T.,.F.)
oFont12 := TFont():New("Courier New",12,12,,.F.,,,,.T.,.F.)

oFont08n:= TFont():New("Courier New",08,08,,.T.,,,,.T.,.F.)
oFont09n:= TFont():New("Courier New",09,09,,.T.,,,,.T.,.F.)
oFont10n:= TFont():New("Courier New",10,10,,.T.,,,,.T.,.F.)     //Negrito//
oFont11n:= TFont():New("Courier New",11,11,,.T.,,,,.T.,.F.)     //Negrito//
oFont12n:= TFont():New("Courier New",12,12,,.T.,,,,.T.,.F.)     //Negrito//
oFont16n:= TFont():New("Courier New",16,16,,.T.,,,,.T.,.F.)     //Negrito//

nEpoca:= SET(5,1910)
//-- MUDAR ANO PARA 4 DIGITOS
SET CENTURY ON


#IfDef TOP

	//Filtra do SRA: filial, matricula de/ate, centro de custo de/ate, categoria e situacoes
	cAlias := "SRA"

	cQrySRA := "QSRA"

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Buscar Situacao e Categoria em formato para SQL              ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/

	cCateg   := "("
	For nAux := 1 To (Len( cCat )-1)
		cCateg += "'" + Substr( cCat, nAux, 1) + "',"
	Next nAux
		cCateg	+= "'" + Substr( cCat, len(cCat)-1, 1) + "')"


	//montagem da query
	cQuery := "SELECT "
 	cQuery += " RA_FILIAL, RA_MAT, RA_CC, RA_PRINOME, RA_PRISOBR, RA_SECSOBR, RA_ADMISSA, RA_DEMISSA, RA_TIPOCON, RA_RESCRAI,"
  	cQuery += " RA_CATFUNC, RA_CIC, RA_ENDEREC, RA_BAIRRO, RA_MUNICIP, RA_ESTADO, RA_SEXO, RA_HRSEMAN, RA_NASC, RA_AFP"
	cQuery += " FROM " + RetSqlName(cAlias)
	cQuery += " WHERE "
	cQuery += " RA_FILIAL BETWEEN '" + cFilialDe + "' AND '" + cFilialAte + "'"
	cQuery += "  AND "
	cQuery += " RA_MAT BETWEEN '" + cMatDe + "' AND '" + cMatAte + "'"
	cQuery += "  AND "
	cQuery += " RA_NOME BETWEEN '" + cNomeDe + "' AND '" + cNomeAte + "'"
	cQuery += "  AND "
	cQuery += " RA_CC BETWEEN '" + cCustoDe + "' AND '" + cCustoAte + "'"
	cQuery += "  AND "
	cQuery += " RA_CATFUNC IN " + cCateg
	cQuery += " ORDER BY RA_FILIAL, RA_MAT "

	cQuery := ChangeQuery(cQuery)
	aStruct := (cAlias)->(dbStruct())

	If  MsOpenDbf(.T.,"TOPCONN",TcGenQry(, ,cQuery),cQrySRA,.T.,.T.)
		For nAux := 1 To Len(aStruct)
			If ( aStruct[nAux][2] <> "C" )
				TcSetField(cQrySRA,aStruct[nAux][1],aStruct[nAux][2],aStruct[nAux][3],aStruct[nAux][4])
			EndIf
		Next nAux
	Endif

	lQuery := .T.
	dbSelectArea(cQrySRA)
	(cQrySRA)->(dbGoTop())

#ELSE

	dbSelectArea("SRA")
	nSavRec   := RecNo()
	nSavOrdem := IndexOrd()
	dbSetOrder(1)
	dbSeek( cFilialDe + cMatDe, .T. )
	cQrySRA:= "SRA"
#ENDIF

	cFim     := cFilialAte + cMatAte

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carrega Regua de Processamento                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SetPrc(0,0)

	SetRegua((cQrySRA)->(RecCount()))

	While (cQrySRA)->(!Eof()) .And. ((cQrySRA)->(RA_FILIAL+RA_MAT) <= cFim )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Movimenta Regua de Processamento                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	 	IncRegua()

		If lEnd
			@Prow()+1,0 PSAY cCancel
			Exit
	    Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Consiste Parametrizacao do Intervalo de Impressao            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  !lQuery .And. ;
			((SRA->RA_MAT < cMatDe)   .Or. (SRA->RA_MAT > cMatAte)    .Or. ;
			(SRA->RA_CC  < cCustoDe) .Or. (SRA->RA_CC  > cCustoAte)  .Or. ;
			(SRA->RA_NOME < cNomeDe) .Or. (SRA->RA_NOME > cNomeAte)  .Or. ;
			!(SRA->RA_CATFUNC $ cCat))

			SRA->(dbSkip(1))
			Loop
		EndIf

		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Consiste Filiais e Acessos                                             ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		IF !( (cQrySRA)->RA_FILIAL $ fValidFil() ) .or. !Eval( cAcessaSRA )
	      	(cQrySRA)->( dbSkip() )
	       	Loop
		Endif

		If cFilAnt <> (cQrySRA)->RA_FILIAL       //se filial eh diferente da anterior

			fInfo(@aInfo, (cQrySRA)->RA_FILIAL)

				If nTipo == 2
					If nLin < 20
						For nAux:= nLin to 20
							oPrint:line( nLinha, 0100, nLinha, 2250 ) //horizontal
							nLinha+=40
						Next nAux
					Endif

					oPrint:EndPage()
					GeraCesacion()

					nLin:= 1
					nLinha := 0850

				Endif

			cFilAnt:= (cQrySRA)->RA_FILIAL

		Endif

		nDia:= f_UltDia(CtoD("01/"+Substr(cPerAte,1,2)+"/"+Substr(cPerAte,3,4)))
		dDataFim:= CtoD(Transform(nDia,"99")+ "/"+Substr(cPerAte,1,2)+"/"+Substr(cPerAte,3,4))

		If nTipo == 1
			If (cQrySRA)->RA_ADMISSA >= CtoD("01/"+Substr(cPerDe,1,2)+"/"+Substr(cPerDe,3,4)) .And.;
			 (cQrySRA)->RA_ADMISSA <= dDataFim

			 	lAFP:= .T.
			 	cAFP:= ""

			 	If !Empty((cQrySRA)->RA_AFP)
				 	dbSelectArea("SRX")
				 	SRX->(dbSetOrder(RetOrder("SRX", "RX_FILIAL+RX_TIP+RX_COD" )))
				 	SRX->(dbSeek(xFilial("SRX")+"62"))
				 	While lAFP .And. SRX->(RX_FILIAL+RX_TIP) == (RhTamFilial(xFilial("SRX"))+"62")
					 	If AllTrim(SRX->RX_COD) == (cQrySRA)->RA_AFP+"1"
					 		cAFP:= (cQrySRA)->RA_AFP + " = " + Substr(SRX->RX_TXT, 1, 21)
					 		lAFP:= .F.
						Endif
						SRX->(dbSkip())
					End

				Endif

				GeraIniciacion()
			Endif
		Else
			If !Empty((cQrySRA)->RA_DEMISSA) .And. (cQrySRA)->RA_DEMISSA >= CtoD("01/"+Substr(cPerDe,1,2)+"/"+Substr(cPerDe,3,4)) ;
			.And. (cQrySRA)->RA_DEMISSA <= dDataFim

				If nLin > 20
					oPrint:EndPage()
					GeraCesacion()
					nLin:= 1
					nLinha:= 0850
				Endif

				ImpLin()
				nLin++
				nLinha+= 40

			Endif
		Endif

		(cQrySRA)->(dbSkip())
	End

If nTipo == 2 .And. nLin < 20
	For nAux:= nLin to 20
		ImpLin()
		nLinha+=40
	Next nAux
Endif

If lQuery
	If Select(cQrySRA) > 0
	 (cQrySRA)->(dbCloseArea())
	Endif
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GeraIniciaºAutor  ³Erika Kanamori      º Data ³  05/11/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GeraIniciacion()

oPrint:StartPage() 			//Inicia uma nova pagina

oPrint:say ( 0300, 0800, STR0005, oFont16n ) //"AVISO DE INICIACION DE SERVICIOS"
oPrint:say ( 0350, 1000, STR0006, oFont12n )  //"(Art. 5º Ley Nº19.728)"

oPrint:say ( 0380, 1630, STR0007, oFont09n )  //"FECHA"
oPrint:Box ( 0370, 1800, 0500, 2250 ) //BOX FECHA
oPrint:say ( 0380, 1850, STR0008, oFont08  )  //"Dia"
oPrint:say ( 0425, 1850, Transform(Day(Date()), "99"), oFont09  )
oPrint:line( 0370, 1950, 0500, 1950 )   //vertical
oPrint:say ( 0380, 2000, STR0009, oFont08  )  //"Mes"
oPrint:say ( 0425, 2000, Transform(Month(Date()), "99"), oFont09  )
oPrint:line( 0370, 2100, 0500, 2100 )   //vertical
oPrint:say ( 0380, 2150, STR0010, oFont08  )  //"Año"
oPrint:say ( 0425, 2150, Transform(Year(Date()), "9999"), oFont09  )
oPrint:line( 0420, 1800, 0420, 2250 ) //horizontal

oPrint:say ( 0500, 0120, STR0011, oFont11n )  //"ANTECEDENTES DEL AFILIADO"

oPrint:Box ( 0550, 0100, 0890, 2250 ) //BOX Antecedentes
oPrint:say ( 0560, 0110, STR0012, oFont08  )  //"Apellido Paterno"
oPrint:say ( 0590, 0110, (cQrySRA)->RA_PRISOBR, oFont09  )
oPrint:line( 0550, 0840, 0810, 0840 )   //vertical
oPrint:say ( 0560, 0850, STR0013, oFont08  )  //"Apellido Materno"
oPrint:say ( 0590, 0850, (cQrySRA)->RA_SECSOBR, oFont09  )
oPrint:line( 0550, 1640, 0630, 1640 )   //vertical
oPrint:say ( 0560, 1650, STR0014, oFont08  )  //"Nombres"
oPrint:say ( 0590, 1650, (cQrySRA)->RA_PRINOME, oFont09  )
oPrint:line( 0630, 0100, 0630, 2250 ) //horizontal

oPrint:say ( 0640, 0110, STR0015, oFont08  )  //"Cédula Nacional de Identidad"
oPrint:say ( 0670, 0110, (cQrySRA)->RA_CIC, oFont09  )
oPrint:say ( 0640, 0870, STR0016, oFont08  )  //"Fecha de"
oPrint:say ( 0670, 0850, STR0017, oFont08  )  //"Nacimiento"
oPrint:line( 0630, 1090, 0810, 1090 )   //vertical
oPrint:say ( 0640, 1100, STR0008, oFont08  )  //"Dia"
oPrint:say ( 0670, 1100, Transform(Day((cQrySRA)->RA_NASC), "99"), oFont09  )
oPrint:line( 0630, 1180, 0720, 1180 )   //vertical
oPrint:say ( 0640, 1200, STR0009, oFont08  )  //"Mes"
oPrint:say ( 0670, 1200, Transform(Month((cQrySRA)->RA_NASC), "99"), oFont09  )
oPrint:line( 0630, 1300, 0720, 1300 )   //vertical
oPrint:say ( 0640, 1320, STR0010, oFont08  )  //"Año"
oPrint:say ( 0670, 1320, Transform(Year((cQrySRA)->RA_NASC), "9999") , oFont09  )
oPrint:line( 0630, 1440, 0720, 1440 )   //vertical
oPrint:say ( 0640, 1450, STR0018, oFont08  )  //"Sexo"
oPrint:say ( 0670, 1480, If((cQrySRA)->RA_SEXO == "M", "1", "2"), oFont09  )
oPrint:line( 0630, 1590, 0720, 1590 )   //vertical
oPrint:say ( 0640, 1600, STR0019, oFont08  )  //"Masculino = 1"
oPrint:say ( 0670, 1600, STR0020, oFont08  )  //"Femenino = 2"
oPrint:line( 0720, 0100, 0720, 2250 ) //horizontal

oPrint:say ( 0730, 0110, STR0021, oFont08  )  //"Domicilio - Calle"
oPrint:say ( 0760, 0110, (cQrySRA)->RA_ENDEREC, oFont09  )
oPrint:say ( 0730, 0850, STR0022, oFont08  )  //"Número"
oPrint:say ( 0760, 0860, Transform(Val((cQrySRA)->RA_ENDEREC),"9999"), oFont09  )
oPrint:say ( 0730, 1100, STR0023, oFont08  )  //"Comuna"
oPrint:say ( 0760, 1100, (cQrySRA)->RA_BAIRRO, oFont09  )
oPrint:line( 0720, 1540, 0810, 1540 )   //vertical
oPrint:say ( 0730, 1550, STR0024, oFont08  )  //"Província"
oPrint:say ( 0760, 1550, (cQrySRA)->RA_MUNICIP, oFont09  )
oPrint:line( 0720, 2090, 0810, 2090 )   //vertical
oPrint:say ( 0730, 2100, STR0025, oFont08  )  //"Región"
oPrint:say ( 0760, 2110, (cQrySRA)->RA_ESTADO, oFont09  )
oPrint:line( 0810, 0100, 0810, 2250 ) //horizontal

oPrint:say ( 0820, 0110, STR0026, oFont08  )  //"Institución"
oPrint:say ( 0850, 0110, STR0027, oFont08  )  //"de Previsión"
oPrint:line( 0810, 0350, 0890, 0350 )   //vertical
oPrint:say ( 0830, 0410, (cQrySRA)->RA_AFP, oFont09  )
oPrint:line( 0810, 0490, 0890, 0490 )   //vertical
oPrint:say ( 0830, 0500, cAFP, oFont09  )

oPrint:say ( 0990, 0100, STR0035, oFont11n )  //IDENTIFICACION EMPLEADOR

oPrint:say ( 0940, 1450, STR0036, oFont09n )  //"FECHA DE INICIO"
oPrint:say ( 0970, 1450, STR0037, oFont09n )  //"SERVICIOS"

oPrint:Box ( 0930, 1800, 1040, 2250 ) //BOX FECHA
oPrint:say ( 0940, 1850, STR0008, oFont08  )  //"Dia"
oPrint:say ( 0990, 1800, Transform(Day((cQrySRA)->RA_ADMISSA), "99") , oFont09  )
oPrint:line( 0930, 1950, 1040, 1950 )   //vertical
oPrint:say ( 0940, 2000, STR0009, oFont08  )  //"Mes"
oPrint:say ( 0990, 2000, Transform(Month((cQrySRA)->RA_ADMISSA), "99") , oFont09  )
oPrint:line( 0930, 2100, 1040, 2100 )   //vertical
oPrint:say ( 0940, 2150, STR0010, oFont08  )  //"Año"
oPrint:say ( 0990, 2150, Transform(Year((cQrySRA)->RA_ADMISSA), "9999") , oFont09  )
oPrint:line( 0980, 1800, 0980, 2250 ) //horizontal

oPrint:Box ( 1040, 0100, 1270, 2250 ) //BOX Identificacion empleador
oPrint:say ( 1050, 0110, STR0038, oFont08  )  //"Nombre o Razón Social"
oPrint:say ( 1080, 0110, aInfo[3], oFont09  )
oPrint:line( 1040, 1570, 1220, 1570 )   //vertical
oPrint:say ( 1050, 1580, STR0039, oFont08  )  //"RUT"
oPrint:say ( 1080, 1580, aInfo[8], oFont09  )
oPrint:line( 1220, 0100, 1220, 2250 ) //horizontal

oPrint:say ( 1230, 0100, STR0040, oFont08n )  //"Tipo de Contrato"
oPrint:line( 1220, 0400, 1270, 0400 )   //vertical
oPrint:say ( 1230, 0430, Transform((cQrySRA)->RA_TIPOCON, "9"), oFont09  )
oPrint:line( 1220, 0570, 1270, 0570 )   //vertical
oPrint:say ( 1230, 0600, STR0041, oFont08  )  //"1. Duración Indefinida"
oPrint:say ( 1230, 1000, STR0042, oFont08  )  //"2. A Plazo Fijo"
oPrint:say ( 1230, 1300, STR0043, oFont08  )  //"3. Obra, Trabajo o Servicio Determinado"

oPrint:Box ( 1300, 0100, 1400, 1300 ) // BOX Nº de Trabajadores
oPrint:say ( 1310, 0100, STR0044, oFont08  )  //"Nº de Trabajadores"
oPrint:say ( 1350, 0100, STR0046, oFont08  )  //"Dependientes de la Empresa"
oPrint:line( 1300, 0600, 1400, 0600 )   //vertical
oPrint:line( 1300, 0790, 1400, 0790 )   //vertical
oPrint:say ( 1310, 0800, STR0045, oFont08  )  //"Nº de Horas Trabajo"
oPrint:say ( 1350, 0800, STR0047, oFont08  )  //"Semanal"
oPrint:line( 1300, 1200, 1400, 1200 )   //vertical
oPrint:say ( 1330, 1210, Transform((cQrySRA)->RA_HRSEMAN,"9999"), oFont09  )

oPrint:Box ( 1600, 0100, 1820, 1400 ) //BOX	 Uso exclusivo de la afc
oPrint:say ( 1610, 0250, STR0048, oFont09n )  //"USO EXCLUSIVO DE LA AFC"
oPrint:line( 1650, 0100, 1650, 0950 ) //horizontal
oPrint:line( 1600, 0950, 1820, 0950 )   //vertical
oPrint:say ( 1660, 0100, STR0049, oFont08  )  //"Nombre del Funcionario"
oPrint:line( 1650, 0590, 1820, 0590 )   //vertical
oPrint:say ( 1660, 0600, STR0039, oFont08  )  //"RUT"
oPrint:line( 1740, 0100, 1740, 0950 ) //horizontal
oPrint:say ( 1750, 0100, STR0049, oFont08  )  //"Nombre de la Sucursal"
oPrint:say ( 1750, 0600, STR0023, oFont08  )  //"Comuna"
oPrint:line( 1740, 0790, 1820, 0790 )   //vertical
oPrint:say ( 1750, 0800, STR0025, oFont08  )  //"Región"
oPrint:say ( 1790, 0980, STR0051, oFont08  )  //"Fecha, Firma y Timbre"

oPrint:Box ( 1820, 0100, 1900, 0500 ) //Box
oPrint:say ( 1830, 0100, STR0052, oFont08  )  //"AFP Receptora"

oPrint:Box ( 1600, 1600, 1900, 2250 ) //Box Declaracion del empleador
oPrint:say ( 1610, 1680, STR0053, oFont09n )  //"DECLARACION DEL EMPLEADOR"
oPrint:line( 1650, 1600, 1650, 2250 ) //horizontal
oPrint:say ( 1660, 1620, STR0054, oFont08  )  //"Declaro que los datos consignados en"
oPrint:say ( 1690, 1620, STR0055, oFont08  )  //"este documento son verdaderos."
oPrint:say ( 1870, 1740, STR0056, oFont08  )  //"Firma Representante Legal"

oPrint:say ( 1950, 0100, STR0057, oFont08  )  //"Distribución:"
oPrint:say ( 1950, 0500, STR0058, oFont08  )  //"Original: A.F.C."
oPrint:say ( 1950, 0800, STR0059, oFont08  )  //"Copia: Empleador"

oPrint:EndPage()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GeraCesaciºAutor  ³Erika Kanamori      º Data ³  11/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GeraCesacion()

oPrint:StartPage() 			//Inicia uma nova pagina

oPrint:say ( 0300, 0800, STR0060, oFont16n ) //"AVISO DE CESACION DE SERVICIOS"
oPrint:say ( 0350, 1000, STR0006, oFont12n )  //"(Art. 5º Ley Nº19.728)"

oPrint:say ( 0380, 1630, STR0007, oFont09n )  //"FECHA"
oPrint:say ( 0430, 1630, STR0061, oFont09n )  //"AVISO"
oPrint:Box ( 0370, 1800, 0500, 2250 ) //BOX FECHA
oPrint:say ( 0380, 1850, STR0008, oFont08  )  //"Dia"
oPrint:say ( 0430, 1860, Transform(Day(Date()), "99"), oFont09  )
oPrint:line( 0370, 1950, 0500, 1950 )   //vertical
oPrint:say ( 0380, 2000, STR0009, oFont08  )  //"Mes"
oPrint:say ( 0430, 2010, Transform(Month(Date()), "99"), oFont09  )
oPrint:line( 0370, 2100, 0500, 2100 )   //vertical
oPrint:say ( 0380, 2150, STR0010, oFont08  )  //"Año"
oPrint:say ( 0430, 2150, Transform(Year(Date()), "9999"), oFont09  )
oPrint:line( 0420, 1800, 0420, 2250 ) //horizontal

oPrint:say ( 0500, 0120, STR0035, oFont11n )  //IDENTIFICACION EMPLEADOR

oPrint:Box ( 0550, 0100, 0630, 2250 ) //BOX Identificacion empleador
oPrint:say ( 0560, 0110, STR0038, oFont08  )  //"Nombre o Razón Social"
oPrint:say ( 0590, 0110, aInfo[3], oFont09  )
oPrint:line( 0550, 1640, 0630, 1640 )   //vertical
oPrint:say ( 0560, 1650, STR0039, oFont08  )  //"RUT"
oPrint:say ( 0590, 1650, aInfo[8], oFont09  )

oPrint:say ( 0750, 1200, STR0062, oFont06   )  //"Tipo de contrato: (1)Indefinido; (2)A plazo; (3)Por obra, trabajo o servicio determ."

oPrint:Box ( 0780, 0100, 1670, 2250 ) //box antecedentes del afiliado 1650
oPrint:say ( 0730, 0100, STR0011, oFont09n  )  //"ANTECEDENTES DEL AFILIADO"
oPrint:say ( 0790, 0110, STR0012, oFont06  )  //"Apellido Paterno"
oPrint:line( 0780, 0550, 1670, 0550 )   //vertical
oPrint:say ( 0790, 0560, STR0013, oFont06  )  //"Apellido Materno"
oPrint:line( 0780, 1000, 1670, 1000 )   //vertical
oPrint:say ( 0790, 1010, STR0014, oFont06  )  //"Nombres"
oPrint:line( 0780, 1450, 1670, 1450 )   //vertical
oPrint:say ( 0790, 1455, STR0067, oFont06  )  //"Cédula Nacional"
oPrint:say ( 0820, 1460, STR0068, oFont06  )  //"de Identidad"
oPrint:line( 0780, 1650, 1670, 1650 )   //vertical
oPrint:say ( 0790, 1660, STR0069, oFont06  )  //"Tipo de"
oPrint:say ( 0820, 1660, STR0070, oFont06  )  //"Contrato"
oPrint:line( 0780, 1790, 1670, 1790 )   //vertical
oPrint:say ( 0790, 1800, STR0063, oFont06  )  //"Fecha Cese de Servicios"
oPrint:line( 0815, 1790, 0815, 2150 ) //horizontal
oPrint:say ( 0820, 1800, STR0008, oFont06  )  //"Dia"
oPrint:line( 0815, 1890, 1670, 1890 )   //vertical
oPrint:say ( 0820, 1900, STR0009, oFont06  )  //"Mes"
oPrint:line( 0815, 1990, 1670, 1990 )   //vertical
oPrint:say ( 0820, 2000, STR0010, oFont06  )  //"Año"
oPrint:line( 0780, 2150, 1670, 2150 )   //vertical
oPrint:say ( 0790, 2162, STR0064, oFont06  )  //"Causal"
oPrint:say ( 0820, 2162, STR0071, oFont06  )  //"Cese(*)"

oPrint:line( 0850, 1840, 1670, 1840 )   //vertical dia
oPrint:line( 0850, 1940, 1670, 1940 )   //vertical mes
oPrint:line( 0850, 2025, 1670, 2025 )   //vertical ano
oPrint:line( 0850, 2065, 1670, 2065 )   //vertical ano
oPrint:line( 0850, 2105, 1670, 2105 )   //vertical ano

oPrint:say ( 1680, 0100, STR0065, oFont06  )  //"Tipo de contrato: (1)Indefinido; (2)A plazo; (3)Por obra, trabajo o servicio determ."
oPrint:say ( 1710, 0100, STR0066, oFont06  )  //"(*) (1)Art. 159-1 (mutuo acuerdo); (2)Art. 159-2 (renuncia); (3)Art. 159-4 (vencimiento plazo); (4)Art. 159-5 (término obra, trabajo o servicio);"

oPrint:Box ( 1800, 0100, 2020, 1400 ) //BOX	 Uso exclusivo de la afc
oPrint:say ( 1810, 0250, STR0048, oFont09n )  //"USO EXCLUSIVO DE LA AFC"
oPrint:line( 1850, 0100, 1850, 0950 ) //horizontal
oPrint:line( 1800, 0950, 2020, 0950 )   //vertical
oPrint:say ( 1860, 0100, STR0049, oFont08  )  //"Nombre del Funcionario"
oPrint:line( 1850, 0590, 2020, 0590 )   //vertical
oPrint:say ( 1860, 0600, STR0039, oFont08  )  //"RUT"
oPrint:line( 1940, 0100, 1940, 0950 ) //horizontal
oPrint:say ( 1950, 0100, STR0049, oFont08  )  //"Nombre de la Sucursal"
oPrint:say ( 1950, 0600, STR0023, oFont08  )  //"Comuna"
oPrint:line( 1940, 0790, 2020, 0790 )   //vertical
oPrint:say ( 1950, 0800, STR0025, oFont08  )  //"Región"
oPrint:say ( 1990, 0980, STR0051, oFont08  )  //"Fecha, Firma y Timbre"

oPrint:Box ( 2020, 0100, 2100, 0500 ) //Box
oPrint:say ( 2030, 0100, STR0052, oFont08  )  //"AFP Receptora"

oPrint:Box ( 1800, 1600, 2100, 2250 ) //Box Declaracion del empleador
oPrint:say ( 1810, 1650, STR0053, oFont09n )  //"DECLARACION DEL EMPLEADOR"
oPrint:line( 1850, 1600, 1850, 2250 ) //horizontal
oPrint:say ( 1860, 1620, STR0054, oFont08  )  //"Declaro que los datos consignados en"
oPrint:say ( 1890, 1620, STR0055, oFont08  )  //"este documento son verdaderos."
oPrint:say ( 2070, 1740, STR0056, oFont08  )  //"Firma Representante Legal"

oPrint:say ( 2150, 0100, STR0057, oFont08  )  //"Distribución:"
oPrint:say ( 2150, 0500, STR0058, oFont08  )  //"Original: A.F.C."
oPrint:say ( 2150, 0800, STR0059, oFont08  )  //"Copia: Empleador"

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ImpLin    ºAutor  ³Erika Kanamori      º Data ³  11/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ImpLin()

Local cDiaA :=  Substr(DtoC((cQrySRA)->RA_DEMISSA), 1, 1)
Local cDiaB :=  Substr(DtoC((cQrySRA)->RA_DEMISSA), 2, 1)
Local cMesA :=  Substr(DtoC((cQrySRA)->RA_DEMISSA), 4, 1)
Local cMesB :=  Substr(DtoC((cQrySRA)->RA_DEMISSA), 5, 1)
Local cAnoA :=  Substr(DtoC((cQrySRA)->RA_DEMISSA), 7, 1)
Local cAnoB :=  Substr(DtoC((cQrySRA)->RA_DEMISSA), 8, 1)
Local cAnoC :=  Substr(DtoC((cQrySRA)->RA_DEMISSA), 9, 1)
Local cAnoD :=  Substr(DtoC((cQrySRA)->RA_DEMISSA), 10, 1)

oPrint:line( nLinha, 0100, nLinha, 2250 ) //horizontal

oPrint:say ( nLinha, 0110, (cQrySRA)->RA_PRISOBR, oFont07  ) // nome
oPrint:say ( nLinha, 0560, (cQrySRA)->RA_SECSOBR, oFont07  )
oPrint:say ( nLinha, 1010, (cQrySRA)->RA_PRINOME, oFont07  )
oPrint:say ( nLinha, 1460, (cQrySRA)->RA_CIC, oFont07  )
oPrint:say ( nLinha, 1700, (cQrySRA)->RA_TIPOCON, oFont07  )

oPrint:say ( nLinha, 1800, cDiaA, oFont07  )
oPrint:say ( nLinha, 1855, cDiaB, oFont07  )

oPrint:say ( nLinha, 1900, cMesA, oFont07  )
oPrint:say ( nLinha, 1955, cMesB, oFont07  )

oPrint:say ( nLinha, 2000, cAnoA, oFont07  )
oPrint:say ( nLinha, 2040, cAnoB, oFont07  )
oPrint:say ( nLinha, 2070, cAnoC, oFont07  )
oPrint:say ( nLinha, 2120, cAnoD, oFont07  )

If !(Empty((cQrySRA)->RA_RESCRAI))
	oPrint:say ( nLinha, 2170, (cQrySRA)->RA_RESCRAI, oFont07  )
Endif
Return
