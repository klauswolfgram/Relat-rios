/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR118.Ch"
#Include "PROTHEUS.Ch"
//#Include "fwlibversion.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR118  ³ Autor ³ Patricia Ikari        ³ Data ³ 28/10/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Diario Geral                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CTBR118(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³Data    ³ BOPS     ³ Motivo da Alteracao                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Jonathan Glz³25/06/15³PCREQ-4256³Se elimina la funcion AjustaSX1() que ³±±
±±³            ³        ³          ³que modifica la tabla SX1 por motivo  ³±±
±±³            ³        ³          ³de adecuacion a fuentes para nuevas   ³±±
±±³            ³        ³          ³estructuras SX para Version 12.       ³±±
±±³            ³        ³          ³                                      ³±±
±±³Jonathan Glz³09/10/15³PCREQ-4261³Merge v12.1.8                         ³±±
±±³  Marco A.  ³12/02/18³ DMINA-772³Se replican modificaciones al Libro   ³±±
±±³            ³        ³          ³Mayor, de acuerdo al issue. (PER)     ³±±
±±³  Marco A.  ³08/02/18³DMINA-2136³Se modifica de posicion, la funcion   ³±±
±±³            ³        ³          ³utilizada para la eliminacion del     ³±±
±±³            ³        ³          ³objeto de FWTemporaryTable. (PER)     ³±±
±±³  Marco A.  ³15/05/18³DMINA-2607³Modificaciones para pais Peru que con-³±±
±±³            ³        ³          ³sisten en re-estructuracion y mod. de ³±±
±±³            ³        ³          ³orden de preguntas CTR118. (PER)      ³±±
±±³  Oscar G.  ³05/01/19³DMINA-4919³Se actualiza fuente de 11.8 a 12.1.17 ³±±
±±³            ³        ³          ³para estabilización. (PER)            ³±±
±±³Alf. Medrano³15/05/19³DMINA-6664³Replica de DMINA-6266 Libro diario,   ³±±
±±³            ³        ³          ³reformulación del campo 20 (PER)      ³±±
±±³            ³17/05/19³          ³Se quita static a la fun DetIGVFn     ³±±
±±³            ³        ³          ³Se deelcaran variables tipo fecha(PER)³±±
±±³gSantacruz  ³17/12/19³DMINA-7745³Ultimos cambios con RSM/Percy         ³±±
±±³gSantacruz  ³06/01/20³DMINA-7612³Ultimos cambios con RSM/Percy         ³±±
±±³Veronica F. ³26/05/20³DMINA-9162³Se modifica funcion GERARQ  para no   ³±±
±±³            ³        ³          ³mostrar documentos borrados(PER)      ³±±
±±³  Oscar G.  ³08/06/20³DMINA-9394³Se actualiza campo 9 y 11 para doctos.³±±
±±³            ³        ³          ³con longitud erronea.(PER)            ³±±
±±³ARodriguez  ³25/11/20³DMINA-    ³Uso de nuevos parámetros MV_SLAPERT y ³±±
±±³            ³        ³     10668³MV_SLCIERR para prefijo correlativo.  ³±±
±±³            ³        ³          ³Nueva función PrefijoCorr() en PERXTMP³±±
±±³            ³07/12/20³          ³Manejo de docs anulados y datos con   ³±±
±±³            ³        ³          ³errores, cambios en PERXTMP->fDocOri()³±±
±±³ARodriguez  ³26/03/21³DMINA-    ³Empalme de campos fecha y descripción ³±±
±±³            ³        ³     11225³                                      ³±±
±±³ARodriguez  ³26/05/21³DMINA-    ³Tipo y número de documento cte/prov.  ³±±
±±³            ³        ³     12227³Descripción moneda, del docto origen. ³±±
±±³            ³        ³          ³Docto de 20 caracs en No Domiciliados.³±±
±±³            ³        ³          ³Generar TXT solo si moneda = 01 (PEN).³±±
±±³            ³        ³          ³Omitir registros con valor 0.         ³±±
±±³            ³        ³          ³Decodificar CT2_LINHA para obtener    ³±±
±±³            ³        ³          ³consecutivo que corresponde y no      ³±±
±±³            ³        ³          ³generar duplicidades en el PLE.       ³±±
v±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR118()

Local cFilIni		:= cFilAnt

Private titulo		:= ""
Private cPerg	 	:= "CTR1182"
Private l1StQb		:= .T.
Private nTransC		:= 0
Private nTransD		:= 0
Private aSelFil		:= {}
Private cPlanRef	:= SuperGetMv("MV_PLANREF",,'01')
Private TMP
Private cTmpCT1Fil	:= ""
Private cTmpCT2Fil	:= ""
Private cTmpCVDFil	:= ""
Private cTmpCVNFil	:= ""
Private _aDocOrig	:= {}
Private lPrintZero	:= .f.
Private cMascara	:= ""
Private cDescMoeda	:= ""
Private cPicture	:= ""
Private nDecimais	:= 0
Private aTamVal		:= TAMSX3("CT2_VALOR")
Private nTamQuebra	:= 145
Private nTamData	:= 15
Private nTamDescOp	:= 26
Private nTamDocum	:= 24
Private nTamConta	:= 30
Private nTamDesc01	:= 32

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01  	      	// Data Inicial                          ³
//³ mv_par02            // Data Final                            ³
//³ mv_par03            // Moeda?                                ³
//³ mv_par04			// Set Of Books			    		     ³
//³ mv_par05			// Tipo Lcto? Real / Orcad / Gerenc / Pre³
//³ mv_par06  	      	// Pagina Inicial                        ³
//³ mv_par07         	// Pagina Final                          ³
//³ mv_par08         	// Pagina ao Reiniciar                   ³
//³ mv_par09         	// So Livro/Livro e Termos/So Termos     ³
//³ mv_par10         	// Imprime Plano de contas               ³
//³ mv_par11         	// Imprime Valor 0.00	                 ³
//³ mv_par12            // Num.linhas p/ o diario?				 ³
//| mv_par13               Salta linha entre contas?             |
//| mv_par14               Descricao na Moeda?                   |
//| mv_par15               Seleciona Filiais?					 |
//| mv_par16               ¿Genera ?  Archivo TXT/Informe		 |
//| mv_par17               ¿Directorio?							 |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private dPFecIni	//³ mv_par01  	      	// Data Inicial
Private dPFecFin	//³ mv_par02            // Data Final
Private cPMon		//³ mv_par03            // Moeda?
Private cPLibro		//³ mv_par04			// Set Of Books
Private cPTPSld		//³ mv_par05			// Tipo Lcto? Real / Orcad / Gerenc / Pr
Private nPPagIni	//³ mv_par06  	      	// Pagina Inicial
Private nPPagFin	//³ mv_par07         	// Pagina Final
Private nPPagRei	//³ mv_par08         	// Pagina ao Reiniciar
Private nPTipLibr	//³ mv_par09         	// So Livro/Livro e Termos/So Termos
Private nPPlan		//³ mv_par10         	// Imprime Plano de contas      Si/No
Private nPImp0		//³ mv_par11         	// Imprime Valor 0.00
Private nPLinD		//³ mv_par12            // Num.linhas p/ o diario?
Private nPSalta		//| mv_par13               Salta linha entre contas?
Private cPDesMnd	//| mv_par14               Descricao na Moeda?
Private nPSelFil	//| mv_par15               Seleciona Filiais?
Private nPTipPrc	//| mv_par16               ¿Genera ?  Archivo TXT/Informe
Private cPRuta		//| mv_par17               ¿Directorio?
Private nPlanCtas	//  mv_par18				1-Plan de cuentas del sistema, 2-Plan de cuentas referencial (PCGE)
Private cEntidad	//  mv_par19				Código Entidad
Private cPCGE		//  mv_par20				Código Plan de cuentas referencial
Private cVersion	//  mv_par21				Versión del Plan
Private nFormLib   	//  mv_par22               ¿Formato Libro ?  1-PLE, 2-SIRE
Private oReport
Private lAutomato	:= IsBlind() //Variable utilizada para identificar automatizados

If Pergunte( cPerg , .T. )

	If cPaisLoc == "PER" .And. MV_PAR16 == 1 .And. MV_PAR03 != "01"
		MsgAlert(OemToAnsi(STR0075),OemToAnsi(STR0020)) // "El archivo de texto solo se puede generar en PEN, cambie el valor de la pregunta 03-Moneda a '01'."##"FORMATO 5.1: LIBRO DIARIO"
		Return Nil
	EndIf

	dPFecIni	:= mv_par01  	      		// Data Inicial
	dPFecFin	:= mv_par02            		// Data Final
	cPMon 		:= mv_par03            		// Moeda?
    cPLibro		:= mv_par04					// Set Of Books
    cPTPSld 	:= mv_par05					// Tipo Saldo? Real / Orcad / Gerenc / Pre
    nPPagIni 	:= mv_par06  	      		// Pagina Inicial
    nPPagFin 	:= mv_par07         		// Pagina Final
    nPPagRei 	:= mv_par08         		// Pagina ao Reiniciar
    nPTipLibr	:= mv_par09         		// So Livro/Livro e Termos/So Termos
    nPPlan 		:= mv_par10         		// Imprime Plano de contas
    nPImp0 		:= mv_par11         		// Imprime Valor 0.00
    nPLinD 		:= mv_par12            		// Num.linhas p/ o diario?
    nPSalta 	:= mv_par13            		//   Salta linha entre contas?
    cPDesMnd 	:= mv_par14             	//  Descricao na Moeda?
    nPSelFil 	:= mv_par15            		//  Seleciona Filiais?
    nPTipPrc 	:= mv_par16             	// ¿Genera ?  Archivo TXT/Informe
    cPRuta   	:= ValidaDir(mv_par17)  	// ¿Directorio?
	nPlanCtas	:= fLeePreg(cPerg, 18, 1)	// Plan de cuentas a utilizar
	cEntidad	:= fLeePreg(cPerg, 19, "")	// Entidad
	cPCGE		:= fLeePreg(cPerg, 20, "")	// Plan de cuentas referencial
	cVersion	:= fLeePreg(cPerg, 21, "")	// Versión
	nFormLib	:= fLeePreg(cPerg, 22, 1) 	//¿Formato Libro ?  1-PLE, 2-SIRE

	If cPaisLoc == "PER" .And. nPlanCtas == 2
		If Empty(cEntidad) .Or. Empty(cPCGE) .Or. Empty(cVersion)
			MsgAlert(OemToAnsi(STR0077),OemToAnsi(STR0020)) // "Para usar un Plan de Cuentas Referencial, debe especificar los parámetros correspondientes."##"FORMATO 5.1: LIBRO DIARIO"
			Return Nil
		EndIf
		CVN->(dbSetOrder(4)) // CVN_FILIAL+CVN_CODPLA+CVN_VERSAO+CVN_CTAREF
		CVN->(msSeek(xFilial("CVN")+cPCGE+cVersion))
		If !CVN->(CVN_FILIAL + CVN_CODPLA + CVN_VERSAO == xFilial("CVN") + cPCGE + cVersion) .Or. !(CVN->CVN_ENTREF == cEntidad)
			MsgAlert(OemToAnsi(STR0078),OemToAnsi(STR0020)) // "Los parámetros del Plan de Cuentas Referencial no son válidos o no existe."##"FORMATO 5.1: LIBRO DIARIO"
			Return Nil
		EndIf
		cPlanRef := cEntidad			// Si se va a generar el archivo de Plan de Cuentas (nPPlan / mv_par10 = 1 - Si), informar el código de Entidad en MV_PAR19
	EndIf

	If nPTipPrc == 1 // Genera Archivo txt
		If nPSelFil == 1
			aSelFil := AdmGetFil()
			If Len( aSelFil ) < 1
				Return
			EndIf
		Else
			aSelFil := {cFilAnt}
		EndIf
		if !lAutomato
			If nPPlan == 1 //Imprime plan de ctas?= Si
				Processa({|| GerArqL1(AllTrim(cPRuta)) },STR0069) //"Generando Archivo del Plan de Cuentas..."
			Endif
			Processa({|| GerArq(AllTrim(cPRuta)) },STR0070) //"Generando Archivo TXT..."
		Else
			If nPPlan == 1
				GerArqL1(AllTrim(cPRuta))
			Endif
			GerArq(AllTrim(cPRuta))
		Endif

	Else //Imprime Informe
		oReport := ReportDef()
  		oReport:PrintDialog()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressão do Plano de Contas                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If nPPlan == 1 //Imprime plan de ctas?= Si
			Ctbr010R4( cPMon )
			GerArqL1(AllTrim(cPRuta))
		Endif

	EndIf

EndIf

cFilAnt := cFilIni
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Patricia Ikari    	³ Data ³ 28/10/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Esta funcao tem como objetivo definir as secoes, celulas,   ³±±
±±³          ³totalizadores do relatorio que poderao ser configurados     ³±±
±±³          ³pelo relatorio.                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGACTB                                    				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local CREPORT		:= "CTBR118"
Local CTITULO		:= OemToAnsi(STR0006)										// Emissao do Livro Diario Geral
Local CDESC			:= OemToAnsi(STR0001)+OemToAnsi(STR0002)+OemToAnsi(STR0003)	// 'Este programa imprimira el Libro Diario, de acuerdo' # 'con los parametros sugeridos por el usuario. Este modelo es ideal' # 'para Plan de Cuentas que tengan codigos poco extensos.'
Local cSeparador    := ""
Local cMoeda		:= ""
Local aCtbMoeda		:= {}
Local lRet		 	:= .T.

private cFilSF3 	:= XFILIAL('SF3')
private cFilSE2 	:= XFILIAL('SE2')

DEFAULT aSelFil		:= {}

lPrintZero	:= .f.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)		     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// faz a validação do livro
if lRet .And. !Empty( cPLibro )
	if ! VdSetOfBook( cPLibro , .F. )
		lRet := .F.
	endif
Endif

IF lRet
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Seta o Livro											 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aSetOfBook := CTBSetOf(cPLibro)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Seta a Moeda		 									 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aCtbMoeda	:= CtbMoeda(cPMon)
	If Empty(aCtbMoeda[1])
		Help(" ",1,"NOMOEDA")
		lRet := .F.
	EndIf
Endif

If !lRet
	Set Filter To
	Return
EndIf

cMoeda		:= cPMon
cDescMoeda 	:= aCtbMoeda[2]
nDecimais 	:= DecimalCTB(aSetOfBook,cMoeda)

If Empty(aSetOfBook[2])
	cMascara := SuperGetMv("MV_MASCARA",,"")
Else
	cMascara := RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Mascara do valor                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPicture 	:= aSetOfBook[4]
If Empty( cPicture ) .Or. cPicture == Nil
	cPicture := "@E " + TmContab(CT2->CT2_VALOR,aTamVal[1],nDecimais)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport	:= TReport():New( CREPORT,CTITULO,cPerg, { |oReport| ReportPrint( oReport, cPicture, nDecimais, cMascara, cSeparador, cDescMoeda ) }, CDESC )
oReport:SetTotalInLine(.F.)
oReport:EndPage(.T.)

oReport:SetPortrait(.T.)
//oReport:DisableOrientation(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oSection1  := TRSection():New( oReport, STR0007, {"TMP"},,.F.,.F.,,,,,,,,,,.F./*AutoAjuste*/,)    //"Totalizadores Data / Geral"
TRCell():New( oSection1, "DATA"    		,/*Alias*/, /*Titulo*/,/*Picture*/,nTamQuebra)
TRCell():New( oSection1, "CDEBITO"		,		  ,/*STR0022*/,/*Picture*/,20,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"CENTER")	//"Vlr.Debito"
TRCell():New( oSection1, "CCREDITO"		,	   	  ,/*STR0023*/,/*Picture*/,20,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"CENTER")	//"Vlr.Credito"

oSection1:Cell("CDEBITO"):lHeaderSize	:= .F.
oSection1:Cell("CCREDITO"):lHeaderSize	:= .F.
oSection1:SetHeaderSection(.F.)

oSection2  := TRSection():New( oReport, STR0008 , {"TMP"},, .F., .F.,,,,,,,,,,.F./*AutoAjuste*/, )    //"Lancamentos Contabeis"
TRCell():New( oSection2, "DOCTO"    	,"",STR0028 + CRLF + STR0029 + CRLF + STR0030 + CRLF + STR0031 + CRLF + STR0032 + CRLF + STR0033	,/*Picture*/,15			,/*lPixel*/,/*CodeBlock*/,"LEFT" 	,	,"CENTER") //"Número" # "Correlativo" # "del Asiento" # "o código" # "único de la" # "operación"
TRCell():New( oSection2, "DATA"	  		,"",STR0034 + CRLF + STR0035 + CRLF + STR0033						   	   							,/*Picture*/,nTamData	,/*lPixel*/,/*CodeBlock*/,"LEFT" 	,	,"CENTER") //"Fecha" # "de la " # "operación"
TRCell():New( oSection2, "DESCOP"	  	,"",STR0036		           																			,/*Picture*/,nTamDescOp	,/*lPixel*/,/*CodeBlock*/,"LEFT"	,	,"CENTER") //"Glosa o descripción de la operación "
TRCell():New( oSection2, "CODLIBRO"		,"",STR0037 + CRLF + STR0038 + CRLF + STR0039														,/*Picture*/,12			,/*lPixel*/,/*CodeBlock*/,"CENTER" 	,	,"CENTER") //"Codigo del" # " libro " # "o registro"
TRCell():New( oSection2, "CORREL"	  	,"",STR0028 + CRLF + STR0029																		,/*Picture*/,14			,/*lPixel*/,/*CodeBlock*/,"LEFT" 	,	,"CENTER") //"Numero" # "correlativo"
TRCell():New( oSection2, "DOCUM"    	,"",STR0040 + CRLF + STR0041 + CRLF + STR0042														,/*Picture*/,nTamDocum	,/*lPixel*/,/*CodeBlock*/,"LEFT" 	,	,"CENTER") //"Número del " # "documento" # "sustentario"
TRCell():New( oSection2, "CONTA"		,"",STR0043																							,/*Picture*/,nTamConta	,/*lPixel*/,/*CodeBlock*/,"LEFT" 	,  	,"CENTER") //"Código"
TRCell():New( oSection2, "DESC01"		,"",STR0044																							,/*Picture*/,nTamDesc01	,/*lPixel*/,/*CodeBlock*/,"LEFT"	,	,"CENTER") //"Denominación"
TRCell():New( oSection2, "CVALDEB"		,"",STR0045																							,/*Picture*/,20			,/*lPixel*/,/*CodeBlock*/,"RIGHT"	,	,"CENTER") //"Vlr.Debito"
TRCell():New( oSection2, "CVALCRED"		,"",STR0046						   																	,/*Picture*/,20			,/*lPixel*/,/*CodeBlock*/,"RIGHT"	,	,"CENTER") //"Vlr.Credito"
oSection2:Cell("DOCTO"):lHeaderSize  	:= .T.
oSection2:Cell("DESCOP"):lHeaderSize  	:= .T.
oSection2:Cell("CODLIBRO"):lHeaderSize 	:= .T.
oSection2:Cell("CORREL"):lHeaderSize  	:= .T.
oSection2:Cell("DOCUM"):lHeaderSize  	:= .T.
oSection2:Cell("CONTA"):lHeaderSize 	:= .T.
oSection2:Cell("DESC01"):lHeaderSize 	:= .T.
oSection2:Cell("CVALDEB"):lHeaderSize  	:= .T.
oSection2:Cell("CVALCRED"):lHeaderSize 	:= .T.

oSection2:SetLinesBefore(0)

oSection3  :=  TRSection():New( oReport, STR0023 , {"TMP"},, .F., .F.,,,,,,,,,,.F./*AutoAjuste*/, )    //"Cabeçalho dos itens"
TRCell():New( oSection3, " "		,		,		,/*Picture*/,76,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"")
TRCell():New( oSection3, "TIT1"		,		,STR0023,/*Picture*/,45,/*lPixel*/,/*CodeBlock*/,"LEFT",,"") //"Referencia de la operacion"
TRCell():New( oSection3, "TIT2"		,		,STR0024,/*Picture*/,70,/*lPixel*/,/*CodeBlock*/,"LEFT",,"") //"Cuenta contable asociada a la operacion"
TRCell():New( oSection3, "TIT3"		,		,STR0025,/*Picture*/,51,/*lPixel*/,/*CodeBlock*/,"LEFT",,"") //"Movimiento"

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Patricia Ikari   	³ Data ³ 28/10/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime o relatorio definido pelo usuario de acordo com as  ³±±
±±³          ³secoes/celulas criadas na funcao ReportDef definida acima.  ³±±
±±³          ³Nesta funcao deve ser criada a query das secoes se SQL ou   ³±±
±±³          ³definido o relacionamento e filtros das tabelas em CodeBase.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportPrint(oReport)                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³EXPO1: Objeto do relatório                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport, cPicture, nDecimais, cMascara, cSeparador, cDescMoeda )

Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oReport:Section(2)
Local oSection3 	:= oReport:Section(3)
Local lImpLivro		:= .T.
Local lImpTermos	:= .F.
Local i				:= 0
Local nLinReport    := 8
Local nMaxLin		:= nPLinD
Local lResetPag		:= .T.
Local m_pag			:= 1 // controle de numeração de pagina
Local l1StQb		:= .T.
Local nPagIni		:= nPPagIni
Local nPagFim		:= nPPagFin
Local nReinicia		:= nPPagRei
Local nBloco		:= 0
Local nBlCount		:= 1
Local lNovoDoc		:= .T.
Local nToDocC		:= 0
Local nToDocD		:= 0
Local nGeralC		:= 0
Local nGeralD		:= 0
Local lFim			:= .F.
Local nK			:= 0
Local cFilOld	    := cFilAnt
Local aArea			:= GetArea()
Local aAreaSM0		:= SM0->(GetArea())
Local dDt			:= ''
Local lOpc4			:= oReport:nDevice == 4 //Generar Planilla

	If !Empty( oReport:uParam )
		Pergunte( oReport:uParam, .F. )
	EndIf

	dPFecIni	:= mv_par01  	      	// Data Inicial
	dPFecFin	:= mv_par02            // Data Final
	cPMon 		:= mv_par03            // Moeda?
    cPLibro		:= mv_par04				// Set Of Books
    cPTPSld 	:= mv_par05				// Tipo Saldo? Real / Orcad / Gerenc / Pre
    nPPagIni 	:= mv_par06  	      	// Pagina Inicial
    nPPagFin 	:= mv_par07         	// Pagina Final
    nPPagRei 	:= mv_par08         	// Pagina ao Reiniciar
    nPTipLibr	:= mv_par09         	// So Livro/Livro e Termos/So Termos
    nPPlan 		:= mv_par10         	// Imprime Plano de contas
    nPImp0 		:= mv_par11         	// Imprime Valor 0.00
    nPLinD 		:= mv_par12            // Num.linhas p/ o diario?
    nPSalta 	:= mv_par13            //   Salta linha entre contas?
    cPDesMnd 	:= mv_par14             //  Descricao na Moeda?
    nPSelFil 	:= mv_par15            //  Seleciona Filiais?
    nPTipPrc 	:= mv_par16             // ¿Genera ?  Archivo TXT/Informe
    cPRuta   	:= ValidaDir(mv_par17)  // ¿Directorio?

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao de Termo / Livro                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
	Case nPTipLibr == 1 ; lImpLivro := .T. ; lImpTermos := .F.
	Case nPTipLibr == 2 ; lImpLivro := .T. ; lImpTermos := .T.
	Case nPTipLibr == 3 ; lImpLivro := .F. ; lImpTermos := .T.
EndCase

aSetOfBook := CTBSetOf(cPLibro)
cPicture 	:= aSetOfBook[4]
If Empty( cPicture ) .Or. cPicture == Nil
	cPicture := "@E " + TmContab(CT2->CT2_VALOR,aTamVal[1],nDecimais)
Endif

If nPSelFil == 1
	aSelFil := AdmGetFil()
	If Len( aSelFil ) <= 0
		Return
	EndIf
Else
	aSelFil := {cFilAnt}
EndIf

Cursorwait()

QryCT2() //Hace consulta

Count to nTotREg

CursorArrow()

oReport:SetMeter(nTotREg)

DBSELECTAREA('TMP')
TMP->(DBGoTop())

For nK := 1 to Len(aSelFil)
	lFim := .F.
	lNovoDoc := .T.
	nGeralD := 0
	nGeralC := 0
	cFilAnt := aSelFil[nK]
	SM0->(MsSeek(cEmpAnt+cFilAnt))

	If lImpLivro
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//| titulo do relatorio                                          |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		titulo := OemToAnsi(STR0013) + DTOC(dPFecIni) + OemToAnsi(STR0014) + DTOC(dPFecFin) + OemToAnsi(STR0015) + cDescMoeda + CtbTitSaldo(cPTPSld) //' LIBRO DIARIO GENERAL DE' # ' A ' # '  EN '

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//| cabeçalho do relatorio                                       |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cPaisLoc == "PER" .and. FindFunction("CabRelPer")
			titulo := STR0020	// ##'FORMATO 5.1: "LIBRO DIARIO"'
			oReport:SetCustomText( {|| (Pergunte(cPerg,.F.),CabRelPer( ,,,,,dPFecFin,oReport:Title(),,,,,oReport,.T.,@lResetPag,@nPagIni,@nPagFim,@nReinicia,@m_pag,@nBloco,@nBlCount,@l1StQb,dPFecIni,titulo)) } )
		Else
			oReport:SetCustomText( {|| (Pergunte(cPerg,.F.),CtCGCCabTR(,,,,,dPFecFin,titulo,,,,,oReport,.T.,@lResetPag,@nPagIni,@nPagFim,@nReinicia,@m_pag,@nBloco,@nBlCount,@l1StQb)) } )
		EndIf
		If !lOpc4
			oSection1:OnPrintLine( {|| CTR118Maxl( nMaxLin, @nLinReport, cPicture )} )
		EndIf

		oSection2:Cell("DOCTO")	  :SetBlock( { || TMP->CT2_SEGOFI})
		oSection2:Cell("DATA")	  :SetBlock( { || TMP->CT2_DATA } )
		oSection2:Cell("DESCOP")  :SetBlock( { || (StrTran(StrTran(StrTran(TMP->CT2_HIST,"/"," "),"\"," "),"|"," ")) } )
		oSection2:Cell("CODLIBRO"):SetBlock( { || ALLTRIM(STR(VAL(TMP->CT2_DIACTB))) })
		oSection2:Cell("CORREL")  :SetBlock( { || PrefijoCorr(TMP->CT2_SBLOTE, TMP->CT2_ROTINA) + Strzero(DecodSoma1(TMP->CT2_LINHA),9) /*getxLinea()*/ })
		oSection2:Cell("CONTA" )  :SetBlock( { || EntidadeCTB(TMP->CT1_CONTA,0,0,nTamConta,.F.,cMascara,cSeparador,,,,,.F.) } )
		oSection2:Cell("DESC01")  :SetBlock( { || TMP->CT1_DESC01 })
		oSection2:Cell("CVALDEB" ):SetBlock( { || ValorCTB( IIf( TMP->CT1_CONTA == TMP->CT2_DEBITO,TMP->CT2_VALOR , 0 ) ,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.)})
		oSection2:Cell("CVALCRED"):SetBlock( { || ValorCTB( IIf( TMP->CT1_CONTA == TMP->CT2_CREDITO,TMP->CT2_VALOR ,0 ) ,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.)})

		oSection1:Cell("DATA"):SetBlock( { || Iif( lFim, STR0016, Iif (lNovoDoc, "", STR0073))}) //' Total General============> ' # ' Fecha ' # ' Total por Fecha ' # "Total por Asiento"
		oSection1:Cell("CDEBITO"):SetBlock( { || Iif( lFim, ValorCTB( nGeralD,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.), Iif(lNovoDoc, nil,;
					ValorCTB( nToDocD,,,aTamVal[1],nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.)))})
		oSection1:Cell("CCREDITO"):SetBlock( { || Iif( lFim, ValorCTB( nGeralC,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.), Iif(lNovoDoc, nil,;
					ValorCTB( nToDocC,,,aTamVal[1],nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.)))})
		oSection1:PrintLine()

		While TMP->(!Eof()) .And. IIf(lOpc4,TMP->CT2_FILIAL == cFilAnt, .T.)

			dDt := TMP->CT2_SEGOFI
			lNovoDoc := .T.
			nToDocC  := 0
			nToDocD  := 0
			nTransC  := 0
			nTransD  := 0

			oSection1:Init()
			oSection1:PrintLine()
			oSection1:Finish()

			oSection3:Init()
			oSection3:PrintLine()
			oSection3:Finish()

			oSection2:Init()

			While  TMP->(!Eof()) .and. TMP->CT2_SEGOFI == dDt .And. IIf(lOpc4,TMP->CT2_FILIAL == cFilAnt, .T.)
				If oReport:Cancel()
					Exit
				EndIf
				_aDocOrig := fDocOri(TMP->CT2_KEY,TMP->CTL_ALIAS,TMP->CTL_ORDER,TMP->CT2_LP,AllTrim(TMP->CTL_KEY), TMP->CT2_NODIA, TMP->CT1_CONTA, TMP->CT2_AGLUT)
				oSection2:Cell("DOCUM"):SetValue( IIf(!empty(_aDocOrig[1][3]),_aDocOrig[1][3],_aDocOrig[1][2])+"-"+_aDocOrig[1][4]) //Serie  Doc
				lNovoDoc := .F.
				oSection2:PrintLine()

				If TMP->CT1_CONTA == TMP->CT2_DEBITO
					nToDocD += TMP->CT2_VALOR
					nTransD += TMP->CT2_VALOR
					nGeralD += TMP->CT2_VALOR
				EndIf

				If TMP->CT1_CONTA == TMP->CT2_CREDITO
					nToDocC += TMP->CT2_VALOR
					nTransC += TMP->CT2_VALOR
					nGeralC += TMP->CT2_VALOR
				EndIf

				TMP->(dbSkip())
			EndDo

			oSection2:Finish()

			oSection1:Init()
			oSection1:PrintLine()
			oSection1:Finish()
			nLinReport++
			oReport:IncMeter()
		EndDo

		lFim := .T.
		oSection1:Init()
		oSection1:PrintLine()
		oSection1:Finish()
	Endif

	oReport:EndPage()
Next

nGeralD := 0
nGeralC	:= 0
lFim := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao dos Termos                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lImpTermos
	oReport:HideHeader()
	oSection2:Hide()

	cArqAbert := SuperGetMv("MV_LDIARAB",,"")
	cArqEncer := SuperGetMv("MV_LDIAREN",,"")

	dbSelectArea("SM0")
	aVariaveis := {}

	For i := 1 to FCount()
		If FieldName(i) == "M0_CGC"
			AADD(aVariaveis,{FieldName(i),Transform(FieldGet(i),"@!R NN.NNN.NNN/NNNN-99")})
		Else
            If FieldName(i) == "M0_NOME"
                Loop
            EndIf
			AADD(aVariaveis,{FieldName(i),FieldGet(i)})
		Endif
	Next

	dbSelectArea("SX1")
	dbSeek( padr(cPerg , Len( X1_GRUPO ) , ' ' ) + "01" )

	While !Eof() .And. SX1->X1_GRUPO == padr( cPerg , Len( X1_GRUPO ) , ' ' )
		AADD(aVariaveis,{Rtrim(Upper(X1_VAR01)),&(X1_VAR01)})
		dbSkip()
	End

	If AliasIndic( "CVB" )
		dbSelectArea( "CVB" )
		CVB->(MsSeek( xFilial( "CVB" ) ))
		For i := 1 to FCount()
			If FieldName(i) == "CVB_CGC"
				AADD(aVariaveis,{FieldName(i),Transform(FieldGet(i),"@!R NN.NNN.NNN/NNNN-99")})
			ElseIf FieldName(i) == "CVB_CPF"
				AADD(aVariaveis,{FieldName(i),Transform(FieldGet(i),"@R 999.999.999-99")})
			Else
				AADD(aVariaveis,{FieldName(i),FieldGet(i)})
			Endif
		Next
	EndIf

	AADD(aVariaveis,{"M_DIA",StrZero(Day(dDataBase),2)})
	AADD(aVariaveis,{"M_MES",MesExtenso()})
	AADD(aVariaveis,{"M_ANO",StrZero(Year(dDataBase),4)})

	If !File(cArqAbert)
		aSavSet := __SetSets()
		cArqAbert := CFGX024(,STR0054) // Editor de Termos de Livros - "Diario Geral."
		__SetSets(aSavSet)
		Set(24,Set(24),.t.)
	Endif

	If !File(cArqEncer)
		aSavSet := __SetSets()
		cArqEncer := CFGX024(,STR0054) // Editor de Termos de Livros - "Diario Geral."
		__SetSets(aSavSet)
		Set(24,Set(24),.t.)
	Endif

	If cArqAbert#NIL
		oReport:EndPage()
		ImpTerm2(cArqAbert,aVariaveis,,,,oReport)
	Endif

	If cArqEncer#NIL
		oReport:EndPage()
		ImpTerm2(cArqEncer,aVariaveis,,,,oReport)
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//| Cabeçalho do Relatorio                                       |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:EndPage()
	oReport:ShowHeader()
	oSection2:Show()
Endif

cFilAnt := cFilOld
RestArea(aAreaSM0)
RestArea(aArea)
TMP->(DbCloseArea())
CtbTmpErase(cTmpCT1Fil)
CtbTmpErase(cTmpCT2Fil)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  |CTR118MaxL    ºAutor ³ Renato F. Campos º Data ³ 01/03/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Faz a quebra de pagina de acordo com o parametro passado   º±±
±±º          ³ no relatorio.                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPL1 - Numero maximo de linhas definido no relatorio      º±±
±±º          ³ EXPL2 - Contador de linhas impressas no relatorio          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ nil                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Diario Geral                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CTR118MaxL(nMaxLin,nLinReport, cPicture )
Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oReport:Section(2)
Local oSection3 	:= oReport:Section(3)
Local nMaxLin1		:= nMaxLin

If oSection1:Printing()
	nLinReport += 2
Else
	nLinReport++
Endif

If nLinReport > nMaxLin1 - 2
	If nTransC > 0 .OR. nTransD > 0
		oSection3:Init()
  		oSection3:Printline()
		oSection3:Finish()

		oSection2:Init()
  		oSection2:Printline()
		oSection2:Finish()

		oReport:EndPage()

		nLinReport := 11

		oSection3:Init()
		oSection3:Printline()
		oSection3:Finish()

		oSection2:Init()
		oSection2:Printline()
		oSection2:Finish()

		oReport:Skipline()

    Else
  		nLinReport := 9
 		oReport:EndPage()

	EndIf
EndIf

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao     ³ GerArq   ³ Autor ³ Marivaldo           ³ Data ³ 23.04.2013 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descricao  ³ Gera o arquivo magnético do Diario contabil                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Parametros ³ cDir - Diretorio de criacao do arquivo.                    ³±±
±±³            ³ cArq - Nome do arquivo com extensao do arquivo.            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Retorno    ³ Nulo                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso        ³ Fiscal Peru - Diario contabil - Arquivo Magnetico          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GerArq(cDir)

local lSIRE 		:= nFormLIb == 2
private nHdl		:= 0
private cLin		:= ""
private cSep		:= "|"
private cArq		:= ""
private nCont		:= 0
private cHist		:= ""
private cFilSYF		:= xFilial("SYF")
private _cCliPad	:= SuperGetMv("MV_CLIPAD",,"") //Codigo de Cliente ESTANDAR para Cheques diferidos
private cDocX		:= space(TAMSX3("F2_DOC")[1])
private cOserie		:= ""
private cTienda		:= ""
private cOtienda	:= ""
private cMovtip		:= ""
private cEspecie	:= ""
private cVcto		:= ""
private dBaixa		:= Ctod("  /  /  ")
private dFecha		:= Ctod("  /  /  ")
private nDetra		:= 0
private cFilSF3		:= ""
private dFechsf3	:= Ctod("  /  /  ")
private cPrefixo	:= ""
private cNumero		:= ""
private cParcela	:= ""
private cTipo		:= ""
private dSfefecha	:= Ctod("  /  /  ")
private nPos		:= 0
private aRet		:= {}
private cDctb		:= ""
private cF1doc		:= ""
private cF1tienda	:= ""
private cLbSiDom	:= SuperGetMv("MV_LFSDOM",.t.,"080100")
private cLbNoDom	:= SuperGetMv("MV_LFNDOM",.t.,"080200")
private cLbVenta	:= SuperGetMv("MV_LFVENT",.t.,"140100")
private cCodLibr	:= ""
private aTID		:= {}
private nTotREg		:= 0
Private cMesInic	:= ""
Private cAnoInic	:= ""
Private cMesFin		:= ""
Private cAnoFin		:= ""
Private dDUtilInic	:= Ctod("  /  /  ")
Private dDUtilFin	:= Ctod("  /  /  ")
Private cMV_1DUP	:= padr(SuperGetMV("MV_1DUP",,"1"),TamSx3("E5_PARCELA")[1])
Private nMonOri		:= 0

//Nombre del archivo
cArq += IIf(!lSIRE,"LE","")             // Fixo  'LE'
cArq +=  AllTrim(SM0->M0_CGC)			// Ruc
cArq +=  IIf(!lSIRE,"","-RCEINEX-")		//Identificador del tipo de archivo (SIRE)
cArq +=  AllTrim(Str(Year(dPFecIni)))   // Ano
cArq +=  AllTrim(Strzero(Month(dPFecIni),2))  // Mes
cArq +=  IIf(!lSIRE,"","-01")		//Correlativo (SIRE)
If !lSIRE
	cArq += "00"
	cArq += "050100"
	cArq += "00"
	cArq += "1"
	cArq += "1"
	cArq += "1"
	cArq += "1"
EndIf
cArq += ".TXT" // Extensao

nHdl := fCreate(cDir+cArq,0,Nil,.F.)

If nHdl <= 0
	ApMsgStop(STR0055) //"Ha ocurrido un error durante la generación del archivo. Intente nuevamente."
	Return Nil
endif

IncProc(STR0074) //"Seleccionando información..."

QryCT2() //Crea Query

Count to nTotREg //Cuenta los registros a procesar

TMP->(DBGoTop())

ProcRegua(nTotREg)

DBSELECTAREA('TMP')

Do While TMP->( !Eof() )
	IncProc()

	aSize(aTID, 0)
	aSize(_aDocOrig, 0)

	// _aDocOrig (Compras, facturación, Cobros, Pagos, Movs Bancarios)
	// [1][1] _TPDOC|_TPDOC|_TPDOC|_TPDOC|00
	// [1][2] _SERIE|_SERIE|_SERIE|_SERIE|E5_PREFIXO
	// [1][3] _SERIE2|_SERIE2|_SERIE2|_SERIE2|
	// [1][4] _DOC|_DOC|EL_NUMERO|EK_NUM|(E5_DOCUMEN/E5_NUMCHEQ)
	// [1][5] _FORNECE|_CLIENTE|EL_CLIENTE|EK_FORNECE|E5_CLIFOR
	// [1][6] C|V|V/F|C/F|5
	// [1][7] _EMISSAO|_EMISSAO|_EMISSAO|_EMISSAO|
	// [1][8] _SERIE|_SERIE|_SERIE|_SERIE|
	// [1][9] _LOJA
	// [1][10] lBorrado?
	// [1][11] _MOEDA -> Númerico
	_aDocOrig := fDocOri(TMP->CT2_KEY,TMP->CTL_ALIAS,TMP->CTL_ORDER,TMP->CT2_LP,AllTrim(TMP->CTL_KEY), TMP->CT2_NODIA, TMP->CT1_CONTA, TMP->CT2_AGLUT)  //Obtiene informacion de las facturas o documentos relacionados al asiento

	// Moneda del documento original
	If Len(_aDocOrig) > 0 .And. Len(_aDocOrig[1]) == 11 .And. _aDocOrig[1][11] != 0
		nMonOri := _aDocOrig[1][11]
	Else
		nMonOri := VAL(TMP->CT2_MOEDLC)
	EndIf

	// aTID := { _TIPDOC, _PFISICA, _CGC, A2_DOMICIL}
	If empty(_aDocOrig[1,5]) .And. empty(_aDocOrig[1,9])
		Aadd( aTID, { "","","","" } )
	Else
		aTID := fFindA12Peru( _aDocOrig[1,5],_aDocOrig[1,9],_aDocOrig[1,6],TMP->CTL_ALIAS ) //Obtiene el tipo de Identificacion del cliente o del proveedor
	Endif

	If TMP->CT2_DEBITO == TMP->CT2_CREDITO	//Cargo y abono a la misma cuenta en el mismo movimiento (tipo 3), en este caso SQL genera solo un registro
		cLin:=""
		//01 - Periodo
		cLin += SubStr(DTOS(TMP->CT2_DATA),1,6)+"00"
		cLin += cSep

		//02 - Num correlativo
		cLin += AllTrim(TMP->CT2_SEGOFI)
		cLin += cSep

		//03 - M+Num correlativo
		cCodLibr := ''

		if left(AllTrim(TMP->CT2_SEGOFI),2)=="14"
			cCodLibr := cLbVenta
		elseif left(AllTrim(TMP->CT2_SEGOFI),2)=="08"
			if  !empty(aTID[1,4])
				cCodLibr := IIf(aTID[1,4]=='1',cLbSiDom,cLbNoDom)// domiciliados o no domiciliado
			endif
		endif

		cContAux := PrefijoCorr(TMP->CT2_SBLOTE, TMP->CT2_ROTINA) + Strzero(DecodSoma1(TMP->CT2_LINHA),9)
		cLin += cContAux
		cLin += cSep

		//04 - Codigo da conta contabil
		cLin += AllTrim(TMP->(IIf(nPlanCtas==1,CT1_CONTA,IIf(!Empty(CVD_CTAREF),CVD_CTAREF,"* "+CT1_CONTA))))
		cLin += cSep

		//05 - Código de la Unidad de Operación, de la Unidad Económica Administrativa, de la Unidad de Negocio, de la Unidad de Producción
		cLin += ""
		cLin += cSep

		//06 - Código del Centro de Costos, Centro de Utilidades o Centro de Inversión, de corresponder
		cLin += Trim(IIf(empty(TMP->CT2_CCD),TMP->CT2_CCC,TMP->CT2_CCD))
		cLin += cSep

		//07 - Tipo de Moneda de origen (TABLA 4)
		If SYF->(MsSeek(cFilSYF+(SuperGetMv("MV_SIMB"+AllTrim(STR(nMonOri)),,""))))
			If !Empty(AllTrim(SYF->YF_ISO))
				cLin += AllTrim(SYF->YF_ISO)
			Else
				cLin += ""
			Endif
		Else
			cLin += ""
		EndIf
		cLin += cSep

		cTipDoc := "00"
		cSerieN := ""

		If len(_aDocOrig)>0
			cTipDoc := alltrim(_aDocOrig[1][1])
			cSerieN := IIf(!empty(_aDocOrig[1][3]),_aDocOrig[1][3],_aDocOrig[1][2])
		EndIf

		//08 - tipo de documento de identidad del emisor
		_cTpDocCli := ""
		If len(_aDocOrig)>0
			_cTpDocCli := aTID[1,1]
			If alltrim(aTID[1,2])$_cCliPad			//"99999999999/00000000000"
				cLin += "0"
			ElseIf alltrim(aTID[1,3])$_cCliPad		//"99999999999/00000000000"
				cLin += "0"
			Else
				cLin += iif(empty(_cTpDocCli),"0",_cTpDocCli)
			EndIf
		Else
			cLin += "0"
		EndIf
		cLin += cSep

		//09 - numero de documento de identidad del emisor
		cFornece:=''
		If len(_aDocOrig)>0
			If _cTpDocCli$"0/1"
				If Empty(aTID[1,2])
					cLin += IIf(_cTpDocCli=="0","00000000000","00000000") // fisica
				Else
					cLin += Trim(aTID[1,2])
				EndIf
				cFornece := _aDocOrig[1][5]
			Else
			//	If empty(_aDocOrig[1][4])	// aunque Num Documento sea vacío, sí informar RUC
			//		cLin += "00000000000"	// no hay sustento de porqué enviaba ceros
			//	Else
					cLin += IIf(empty(aTID[1,3]),"00000000000",Trim(aTID[1,3])) // juridica
					cFornece := _aDocOrig[1][5]
			//	EndIf
			EndIf
		Else
			cLin += "00000000000"
		EndIf
		cLin += cSep

		//10 - Tipo de Comprobante de Pago o Documento asociada a la operación, de corresponder
		cLin += iif(AllTrim(cTipDoc)=="","00",AllTrim(cTipDoc))
		cLin += cSep

		//11 - Número de serie del comprobante de pago o documento asociada a la operación, de corresponder
		cTipDoc := Alltrim(cTipDoc)
		cSerieNf := Alltrim(cSerieN)

		If !(cTipDoc $ "50|05")
			If Len(cSerieNf) <= 3
				if left(cSerieNf,2) == "EB"
					cSerieNf := left(cSerieNf,2)+"0"+right(cSerieNf,1)
				elseif left(cSerieNf,1)$"E/F/B"
					cSerieNf := left(cSerieNf,1)+"0"+right(cSerieNf,2)
				elseif substr(cSerieNf,2,1)$"E/F/A/B/C/D"
					cSerieNf := left(cSerieNf,2)+"0"+right(cSerieNf,1)
				else
					cSerieNf := Replicate("0",4-Len(cSerieNf))+cSerieNf
				endif
			EndIf
		ElseIf cTipDoc == "05"
			cSerieNf := "3"
		Else
			If Len(cSerieNf) < 3 .Or. alltrim(cSerieNf)=="000"
				cSerieNf := Replicate("0",3-Len(cSerieNf))+cSerieNf
			else
				cSerieNf := right(cSerieNf,3)
			endif
		EndIf

		If cTipDoc == "00" .Or. empty(cTipDoc)
			cLin += "0000"
		Else
			cLin += AllTrim(cSerieNf)
		EndIf
		cLin += cSep

		//12 - Número del comprobante de pago o documento asociada a la operación
		cDocX := space(TamSX3("F2_DOC")[1])
		If len(_aDocOrig)>0
			If empty(_aDocOrig[1][4])
				cLin += "0000"
			Else	// número documento de proveedores no domiciliados o tipo documento = Otros, hasta 20 caracteres
				cLin += IIf( aTID[1,4]=="2" .Or. cTipDoc $ "00|37|43|46", LEFT(Alltrim(_aDocOrig[1][4]),20),right(Alltrim(_aDocOrig[1][4]),8) )
				cDocX := _aDocOrig[1][4]
			EndIf
		Else
			cLin += "0000"
		EndIf
		cLin += cSep

		//13 - Fecha contable
		cLin += SubStr(DTOC(TMP->CT2_DATA),1,6)+SubStr(DTOS(TMP->CT2_DATA),1,4)
		cLin += cSep

		//14 - Fecha de vencimiento
		cLin += ""
		cLin += cSep

		//15  - Data da contabilizacao Fecha de la operación o emisión
		If len(_aDocOrig) > 0
			If empty(_aDocOrig[1][7])
				cLin += SubStr(DTOC(TMP->CT2_DATA),1,6)+SubStr(DTOS(TMP->CT2_DATA),1,4)
			Else
				cLin += dtoc( stod( _aDocOrig[1][7] ) )
			EndIf
		Else
			cLin += SubStr(DTOC(TMP->CT2_DATA),1,6)+SubStr(DTOS(TMP->CT2_DATA),1,4)
		EndIf
		cLin += cSep

		//16 - Historico. Glosa o descripción de la naturaleza de la operación registrada, de ser el caso.
		cHist := AllTrim(TMP->CT2_HIST)
		cLin += StrTran(StrTran(StrTran(cHist,"/"," "),"\"," "),"|"," ")
		cLin += cSep

		//17 - Glosa referencial, de ser el caso
		cLin += ""
		cLin += cSep

		//18  - Conta Debito
		cLin += ALLTRIM(STR(TMP->CT2_VALOR,17,2))
		cLin += cSep

		//19 - Conta Credito
		cLin += '0.00'
		cLin += cSep

		//20 - Dato Estructurado: Código del libro, campo 1, campo 2 y campo 3 del Registro de Ventas e Ingresos o del Registro de Compras,
		//separados con el carácter "&", de corresponder.
		if Left(AllTrim(TMP->CT2_SEGOFI),2)<>"99" .and. _aDocOrig[1][1]<>"02" .and. !empty(_aDocOrig[1][1])  .and. !empty(cCodLibr) //.And. alltrim(_aDocOrig[1,1])<>"07"
			if !lSIRE //PLE
				cLin += fgenAnidado(cDocX,cFornece,dPFecIni,dPFecFin,cCodLibr,TMP->CT2_SEGOFI,cContAux,TMP->CT2_FILIAL)
			else //SIRE
				cLin += fGenCAR(AllTrim(cTipDoc),AllTrim(cSerieNf),cDocX)
			EndIf
		Else
			cLin += ""
		EndIf
		cLin += cSep

		//21 - Indica el estado de la operación
		cLin += '1'
		cLin += cSep

		cLin += chr(13)+chr(10)

		fWrite(nHdl,cLin)

		cLin:=""
		//01 - Periodo
		cLin += SubStr(DTOS(TMP->CT2_DATA),1,6)+"00"
		cLin += cSep

		//02 - Num correlativo
		cLin += AllTrim(TMP->CT2_SEGOFI)
		cLin += cSep

		//03 - M+Num correlativo
		cCodLibr := ''

		if left(AllTrim(TMP->CT2_SEGOFI),2)=="14"
			cCodLibr := cLbVenta
		elseif left(AllTrim(TMP->CT2_SEGOFI),2)=="08"
			if !empty(aTID[1,4])
				cCodLibr := IIf(aTID[1,4]=='1',cLbSiDom,cLbNoDom)// domiciliados o no domiciliado
			endif
		endif

		cContAux := PrefijoCorr(TMP->CT2_SBLOTE, TMP->CT2_ROTINA) + Strzero(10000+DecodSoma1(TMP->CT2_LINHA),9) // modifica correlativo para no generar código duplicado en TXT
		cLin += cContAux
		cLin += cSep

		//04 - Codigo da conta contabil
		cLin += AllTrim(TMP->(IIf(nPlanCtas==1,CT1_CONTA,IIf(!Empty(CVD_CTAREF),CVD_CTAREF,"* "+CT1_CONTA))))
		cLin += cSep

		//05 - Código de la Unidad de Operación, de la Unidad Económica Administrativa, de la Unidad de Negocio, de la Unidad de Producción
		cLin += ""
		cLin += cSep

		//06 - Código del Centro de Costos, Centro de Utilidades o Centro de Inversión, de corresponder
		cLin += Trim(IIf(empty(TMP->CT2_CCD),TMP->CT2_CCC,TMP->CT2_CCD))
		cLin += cSep

		//07 - Tipo de Moneda de origen (TABLA 4)
		If SYF->(MsSeek(cFilSYF+(SuperGetMv("MV_SIMB"+AllTrim(STR(nMonOri)),,""))))
			If !Empty(AllTrim(SYF->YF_ISO))
				cLin += AllTrim(SYF->YF_ISO)
			Else
				cLin += ""
			Endif
		Else
			cLin += ""
		EndIf
		cLin += cSep

		cTipDoc := "00"
		cSerieN := ""

		If len(_aDocOrig)>0
			cTipDoc := alltrim(_aDocOrig[1][1])
			cSerieN := IIf(!empty(_aDocOrig[1][3]),_aDocOrig[1][3],_aDocOrig[1][2])
		EndIf

		//08 - tipo de documento de identidad del emisor
		_cTpDocCli := ""
		If len(_aDocOrig)>0
			_cTpDocCli :=  aTID[1,1]
			If alltrim(aTID[1,2])$_cCliPad			//"99999999999/00000000000"
				cLin += "0"
			ElseIf alltrim(aTID[1,3])$_cCliPad		//"99999999999/00000000000"
				cLin += "0"
			Else
				cLin += iif(empty(_cTpDocCli),"0",_cTpDocCli)
			EndIf
		Else
			cLin += "0"
		EndIf
		cLin += cSep

		//09 - numero de documento de identidad del emisor
		cFornece:=''
		If len(_aDocOrig)>0
			If _cTpDocCli$"0/1"
				If Empty(aTID[1,2])
					cLin += IIf(_cTpDocCli=="0","00000000000","00000000") // fisica
				Else
					cLin += Trim(aTID[1,2])
				EndIf
				cFornece:=_aDocOrig[1][5]
			Else
			//	If empty(_aDocOrig[1][4])	// aunque Num Documento sea vacío, sí informar RUC
			//		cLin += "00000000000"	// no hay sustento de porqué enviaba ceros
			//	Else
					cLin += IIf(empty(aTID[1,3]),"00000000000",Trim(aTID[1,3])) // juridica
					cFornece:=_aDocOrig[1][5]
			//	EndIf
			EndIf
		Else
			cLin += "00000000000"
		EndIf
		cLin += cSep

		//10 - Tipo de Comprobante de Pago o Documento asociada a la operación, de corresponder
		cLin += iif(AllTrim(cTipDoc)=="","00",AllTrim(cTipDoc))
		cLin += cSep

		//11 - Número de serie del comprobante de pago o documento asociada a la operación, de corresponder
		cTipDoc:=Alltrim(cTipDoc)
		cSerieNf:=Alltrim(cSerieN)

		If !(cTipDoc $ "50|05")
			If Len(cSerieNf) <= 3
				if left(cSerieNf,2) == "EB"
					cSerieNf := left(cSerieNf,2)+"0"+right(cSerieNf,1)
				elseif left(cSerieNf,1)$"E/F/B"
					cSerieNf := left(cSerieNf,1)+"0"+right(cSerieNf,2)
				elseif substr(cSerieNf,2,1)$"E/F/A/B/C/D"
					cSerieNf := left(cSerieNf,2)+"0"+right(cSerieNf,1)
				else
					cSerieNf := Replicate("0",4-Len(cSerieNf))+cSerieNf
				endif
			EndIf
		ElseIf cTipDoc == "05"
			cSerieNf := "3"
		Else
			If Len(cSerieNf) < 3 .Or. alltrim(cSerieNf)=="000"
				cSerieNf := Replicate("0",3-Len(cSerieNf))+cSerieNf
			else
				cSerieNf := right(cSerieNf,3)
			endif
		EndIf

		If cTipDoc == "00" .Or. empty(cTipDoc)
			cLin += "0000"
		Else
			cLin += AllTrim(cSerieNf)
		EndIf
		cLin += cSep

		//12 - Número del comprobante de pago o documento asociada a la operación
		cDocX := space(TamSX3("F2_DOC")[1])
		If len(_aDocOrig)>0
			If empty(_aDocOrig[1][4])
				cLin += "0000"
			Else	// número documento de proveedores no domiciliados o tipo documento = Otros, hasta 20 caracteres
				cLin += IIf( aTID[1,4]=="2" .Or. cTipDoc $ "00|37|43|46", LEFT(Alltrim(_aDocOrig[1][4]),20),right(Alltrim(_aDocOrig[1][4]),8) )
				cDocX := _aDocOrig[1][4]
			EndIf
		Else
			cLin += "0000"
		EndIf
		cLin += cSep

		//13 - Fecha contable
		cLin += SubStr(DTOC(TMP->CT2_DATA),1,6)+SubStr(DTOS(TMP->CT2_DATA),1,4)
		cLin += cSep

		//14 - Fecha de vencimiento
		cLin += ""
		cLin += cSep

		//15  - Data da contabilizacao Fecha de la operación o emisión
		If len(_aDocOrig) > 0
			If empty(_aDocOrig[1][7])
				cLin += SubStr(DTOC(TMP->CT2_DATA),1,6)+SubStr(DTOS(TMP->CT2_DATA),1,4)
			Else
				cLin += dtoc( stod( _aDocOrig[1][7] ) )
			EndIf
		Else
			cLin += SubStr(DTOC(TMP->CT2_DATA),1,6)+SubStr(DTOS(TMP->CT2_DATA),1,4)
		EndIf
		cLin += cSep

		//16 - Historico. Glosa o descripción de la naturaleza de la operación registrada, de ser el caso.
		cHist := AllTrim(TMP->CT2_HIST)
		cLin += StrTran(StrTran(StrTran(cHist,"/"," "),"\"," "),"|"," ")
		cLin += cSep

		//17 - Glosa referencial, de ser el caso
		cLin += ""
		cLin += cSep

		//18  - Conta Debito
		cLin += '0.00'
		cLin += cSep

		//19 - Conta Credito
		cLin += ALLTRIM(STR(TMP->CT2_VALOR,17,2))
		cLin += cSep

		//20 - Dato Estructurado: Código del libro, campo 1, campo 2 y campo 3 del Registro de Ventas e Ingresos o del Registro de Compras,
		//separados con el carácter "&", de corresponder.
		if Left(AllTrim(TMP->CT2_SEGOFI),2)<>"99" .and. _aDocOrig[1][1]<>"02" .and. !empty(_aDocOrig[1][1])  .and. !empty(cCodLibr) //.And. alltrim(_aDocOrig[1,1])<>"07"
			if !lSIRE //PLE
				cLin += fgenAnidado(cDocX,cFornece,dPFecIni,dPFecFin,cCodLibr,TMP->CT2_SEGOFI,cContAux,TMP->CT2_FILIAL)
			else //SIRE
				cLin += fGenCAR(AllTrim(cTipDoc),AllTrim(cSerieNf),cDocX)
			EndIf
		Else
			cLin += ""
		EndIf
		cLin += cSep

		//21 - Indica el estado de la operación
		cLin += '1'
		cLin += cSep

		cLin += chr(13)+chr(10)

		fWrite(nHdl,cLin)

		cLin:=""

	Else //De TMP->CT2_DEBITO == TMP->CT2_CREDITO
		cLin:=""
		//01 - Periodo
		cLin += SubStr(DTOS(TMP->CT2_DATA),1,6)+"00"
		cLin += cSep

		//02 - Num correlativo
		cLin += AllTrim(TMP->CT2_SEGOFI)
		cLin += cSep

		//03 - M+Num correlativo
		cCodLibr := ''

		if left(AllTrim(TMP->CT2_SEGOFI),2)=="14"
			cCodLibr := cLbVenta
		elseif left(AllTrim(TMP->CT2_SEGOFI),2)=="08"
			if !empty(aTID[1,4])
				cCodLibr := IIf(aTID[1,4]=='1',cLbSiDom,cLbNoDom)// domiciliados o no domiciliado
			endif
		endif

		cContAux := PrefijoCorr(TMP->CT2_SBLOTE, TMP->CT2_ROTINA) + Strzero(DecodSoma1(TMP->CT2_LINHA),9)
		cLin += cContAux
		cLin += cSep

		//04 - Codigo da conta contabil
		cLin += AllTrim(TMP->(IIf(nPlanCtas==1,CT1_CONTA,IIf(!Empty(CVD_CTAREF),CVD_CTAREF,"* "+CT1_CONTA))))
		cLin += cSep

		//05 - Código de la Unidad de Operación, de la Unidad Económica Administrativa, de la Unidad de Negocio, de la Unidad de Producción
		cLin += ""
		cLin += cSep

		//06 - Código del Centro de Costos, Centro de Utilidades o Centro de Inversión, de corresponder
		cLin += Trim(IIf(empty(TMP->CT2_CCD),TMP->CT2_CCC,TMP->CT2_CCD))
		cLin += cSep

		//07 - Tipo de Moneda de origen (TABLA 4)
		If SYF->(MsSeek(cFilSYF+(SuperGetMv("MV_SIMB"+AllTrim(STR(nMonOri)),,""))))
			If !Empty(AllTrim(SYF->YF_ISO))
				cLin += AllTrim(SYF->YF_ISO)
			Else
				cLin += ""
			Endif
		Else
			cLin += ""
		EndIf
		cLin += cSep

		cTipDoc := "00"
		cSerieN := ""

		If len(_aDocOrig)>0
			cTipDoc := alltrim(_aDocOrig[1][1])
			cSerieN := IIf(!empty(_aDocOrig[1][3]),_aDocOrig[1][3],_aDocOrig[1][2])
		EndIf

		//08 - tipo de documento de identidad del emisor
		_cTpDocCli := ""
		If len(_aDocOrig)>0
			_cTpDocCli := aTID[1,1]
			If alltrim(aTID[1,2])$_cCliPad		//"99999999999/00000000000"
				cLin += "0"
			ElseIf alltrim(aTID[1,3])$_cCliPad	//"99999999999/00000000000"
				cLin += "0"
			Else
				cLin += iif(empty(_cTpDocCli),"0",_cTpDocCli)
			EndIf
		Else
			cLin += "0"
		EndIf
		cLin += cSep

		//09 - numero de documento de identidad del emisor
		cFornece:=''
		If len(_aDocOrig)>0
			If _cTpDocCli$"0/1"
				If Empty(aTID[1,2])
					cLin += IIf(_cTpDocCli=="0","00000000000","00000000") // fisica
				Else
					cLin += Trim(aTID[1,2])
				EndIf
				cFornece:=_aDocOrig[1][5]
			Else
			//	If empty(_aDocOrig[1][4])	// aunque Num Documento sea vacío, sí informar RUC
			//		cLin += "00000000000"	// no hay sustento de porqué enviaba ceros
			//	Else
					cLin += IIf(empty(aTID[1,3]),"00000000000",Trim(aTID[1,3])) // juridica
					cFornece:=_aDocOrig[1][5]
			//	EndIf
			EndIf
		Else
			cLin += "00000000000"
		EndIf
		cLin += cSep

		//10 - Tipo de Comprobante de Pago o Documento asociada a la operación, de corresponder
		cLin += iif(AllTrim(cTipDoc)=="","00",AllTrim(cTipDoc))
		cLin += cSep

		//11 - Número de serie del comprobante de pago o documento asociada a la operación, de corresponder
		cTipDoc := Alltrim(cTipDoc)
		cSerieNf := Alltrim(cSerieN)

		If !(cTipDoc $ "50|05")
			If Len(cSerieNf) <= 3
				if left(cSerieNf,2) == "EB"
					cSerieNf := left(cSerieNf,2)+"0"+right(cSerieNf,1)
				elseif left(cSerieNf,1)$"E/F/B"
					cSerieNf := left(cSerieNf,1)+"0"+right(cSerieNf,2)
				elseif substr(cSerieNf,2,1)$"E/F/A/B/C/D"
					cSerieNf := left(cSerieNf,2)+"0"+right(cSerieNf,1)
				else
					cSerieNf := Replicate("0",4-Len(cSerieNf))+cSerieNf
				endif
			EndIf
		ElseIf cTipDoc == "05"
			cSerieNf := "3"
		Else
			If Len(cSerieNf) < 3 .Or. alltrim(cSerieNf)=="000"
				cSerieNf := Replicate("0",3-Len(cSerieNf))+cSerieNf
			else
				cSerieNf := right(cSerieNf,3)
			endif
		EndIf

		If cTipDoc == "00" .Or. empty(cTipDoc)
			cLin += "0000"
		Else
			cLin += AllTrim(cSerieNf)
		EndIf
		cLin += cSep

		//12 - Número del comprobante de pago o documento asociada a la operación
		cDocX := space(TamSX3("F2_DOC")[1])
		If len(_aDocOrig)>0
			If empty(_aDocOrig[1][4])
				cLin += "0000"
			Else	// número documento de proveedores no domiciliados o tipo documento = Otros, hasta 20 caracteres
				cLin += IIf( aTID[1,4]=="2" .Or. cTipDoc $ "00|37|43|46", LEFT(Alltrim(_aDocOrig[1][4]),20),right(Alltrim(_aDocOrig[1][4]),8) )
				cDocX := _aDocOrig[1][4]
			EndIf
		Else
			cLin += "0000"
		EndIf
		cLin += cSep

		//13 - Fecha contable
		cLin += SubStr(DTOC(TMP->CT2_DATA),1,6)+SubStr(DTOS(TMP->CT2_DATA),1,4)
		cLin += cSep

		//14 - Fecha de vencimiento
		cLin += ""
		cLin += cSep

		//15  - Data da contabilizacao Fecha de la operación o emisión
		If len(_aDocOrig) > 0
			If empty(_aDocOrig[1][7])
				cLin += SubStr(DTOC(TMP->CT2_DATA),1,6)+SubStr(DTOS(TMP->CT2_DATA),1,4)
			Else
				cLin += dtoc( stod( _aDocOrig[1][7] ) )
			EndIf
		Else
			cLin += SubStr(DTOC(TMP->CT2_DATA),1,6)+SubStr(DTOS(TMP->CT2_DATA),1,4)
		EndIf
		cLin += cSep

		//16 - Historico. Glosa o descripción de la naturaleza de la operación registrada, de ser el caso.
		cHist := AllTrim(TMP->CT2_HIST)
		cLin += StrTran(StrTran(StrTran(cHist,"/"," "),"\"," "),"|"," ")
		cLin += cSep

		//17 - Glosa referencial, de ser el caso
		cLin += ""
		cLin += cSep

		//18  - Conta Debito
		cLin += IIF( TMP->CT1_CONTA == TMP->CT2_DEBITO,ALLTRIM(STR(TMP->CT2_VALOR,17,2)) ,'0.00' )
		cLin += cSep

		//19 - Conta Credito
		cLin += IIF( TMP->CT1_CONTA == TMP->CT2_CREDITO,ALLTRIM(STR(TMP->CT2_VALOR,17,2)) , '0.00'  )
		cLin += cSep

		//20 - Dato Estructurado: Código del libro, campo 1, campo 2 y campo 3 del Registro de Ventas e Ingresos o del Registro de Compras,
		//separados con el carácter "&", de corresponder.
		if Left(AllTrim(TMP->CT2_SEGOFI),2)<>"99" .and. _aDocOrig[1][1]<>"02" .and. !empty(_aDocOrig[1][1])   .and. !empty(cCodLibr) //.And. alltrim(_aDocOrig[1,1])<>"07"
			if !lSIRE //PLE
				cLin += fgenAnidado(cDocX,cFornece,dPFecIni,dPFecFin,cCodLibr,TMP->CT2_SEGOFI,cContAux,TMP->CT2_FILIAL)
			else //SIRE
				cLin += fGenCAR(AllTrim(cTipDoc),AllTrim(cSerieNf),cDocX)
			EndIf
		Else
			cLin += ""
		EndIf
		cLin += cSep

		//21 - Indica el estado de la operación
		cLin += '1'
		cLin += cSep

		cLin += chr(13)+chr(10)

		fWrite(nHdl,cLin)

		cLin:=""
	ENDIF

	TMP->(dbSkip())
EndDo

TMP->(dbClosearea())
fClose(nHdl)
CtbTmpErase(cTmpCT1Fil)
CtbTmpErase(cTmpCT2Fil)

If nPlanCtas == 2
	CtbTmpErase(cTmpCVDFil)
EndIf

IF nTotReg==0
	MSGINFO(STR0071, STR0020) //"No existe información con los parametros seleccionados!."
ELSE
if !lAutomato
	MSGINFO(STR0072, STR0020) //"Proceso Finalizado!!"
Else
	Conout(OemToAnsi(STR0072)+ OemToAnsi(STR0020))
EndIf

ENDIF

Return Nil

/*/
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao     ³ GerArqL1   ³                           ³ Data ³ 07.03.2016 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descricao  ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Parametros ³ cDir - Diretorio de criacao do arquivo.                    ³±±
±±³            ³ cArqL1 - Nome do arquivo com extensao do arquivo.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Retorno    ³ Nulo                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso        ³ Fiscal Peru - Livro Diario 5.3 detalhe plano de contas     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
/*/
Static Function GerArqL1(cDir)
Local nHdl			:= 0
Local cLin			:= ""
Local cSep			:= "|"
Local cArq			:= ""
Local cQuery		:= ""
Local cTMPTMP1Fil	:= ''
Local cFilCVD		:= " CVD_FILIAL " + GetRngFil( aSelFil, "CVD", .T., @cTmpCVDFil )
Local cFilCVN		:= " CVN_FILIAL " + GetRngFil( aSelFil, "CVN", .T., @cTmpCVNFil )

cArq += "LE"                            // Fixo  'LE'
cArq +=  AllTrim(SM0->M0_CGC)           // Ruc
cArq +=  AllTrim(Str(Year(dPFecIni)))   // Ano
cArq +=  AllTrim(Strzero(Month(dPFecIni),2))  // Mes
cArq +=  "00"                            // Fixo '00'
cArq += "050300"                         // Fixo '050300'
cArq += "00"                             // Fixo '00'
cArq += "1"
cArq += "1"
cArq += "1"
cArq += "1"
cArq += ".TXT" // Extensao

Pergunte("CTR010",.F.) // utilizando pergunte da rotina ctbr010
nHdl := fCreate(cDir+cArq,0,Nil,.F.)

If nHdl <= 0
	ApMsgStop(STR0055) //"Ha ocurrido un error durante la generación del archivo. Intente nuevamente."

Else
	TMP1 := GetNextAlias()

	cFilCt1  := " CT1_FILIAL " + GetRngFil( aSelFil, "CT1", .T., @cTMPTMP1Fil )

	If nPlanCtas == 1
		cQuery := " SELECT CT1_FILIAL"
		cQuery += "       , CT1_CONTA"
		cQuery += "       , CT1_DESC01"
		cQuery += "   FROM " + RetSqlName('CT1') + " CT1"
		cQuery += "  WHERE " + cFilCT1
		cQuery += "		AND CT1_CONTA  >= '" + mv_par01 + "'"
		cQuery += "     AND CT1_CONTA  <= '" + mv_par02 + "'"
		cQuery += "		AND CT1_CLASSE = '2'"
		cQuery += "		AND CT1.D_E_L_E_T_ = ' ' "
		cQuery += "  ORDER BY CT1_CONTA "

	ElseIf nPlanCtas == 2
		cQuery := "SELECT CVD_CTAREF"
		cQuery += "		, CVN_DSCCTA"
		cQuery += "   FROM " + RetSqlName('CT1') + " CT1"
		cQuery += "   INNER JOIN " + RetSqlName('CVD') + " CVD ON " + cFilCVD + " AND CVD.CVD_CODPLA = '" + cPCGE  + "' AND CVD.CVD_VERSAO = '" + cVersion  + "' AND CVD.CVD_ENTREF = '" + cEntidad + "' AND CVD.CVD_CONTA = CT1.CT1_CONTA AND CVD.D_E_L_E_T_ = ' ' "
		cQuery += "   INNER JOIN " + RetSqlName('CVN') + " CVN ON " + cFilCVN + " AND CVN.CVN_CODPLA = '" + cPCGE  + "' AND CVN.CVN_VERSAO = '" + cVersion  + "' AND CVN.CVN_ENTREF = '" + cEntidad + "' AND CVN.CVN_CTAREF = CVD.CVD_CTAREF AND CVN.D_E_L_E_T_ = ' ' "
		cQuery += "  WHERE " + cFilCT1
		cQuery += "		AND CT1_CONTA  >= '" + mv_par01 + "'"
		cQuery += "     AND CT1_CONTA  <= '" + mv_par02 + "'"
		cQuery += "		AND CT1_CLASSE = '2'"
		cQuery += "		AND CT1.D_E_L_E_T_ = ' ' "
		cQuery += "  GROUP BY CVD_CTAREF, CVN_DSCCTA "
		cQuery += "  ORDER BY CVD_CTAREF "
	EndIf

	ChangeQuery(cQuery)
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), 'TMP1', .T., .F. )
	dbSelectArea("TMP1")

	Count to nTotREg //Cuenta los registros a procesar
	ProcRegua(nTotREg)

	TMP1 ->(dbGoTop())

	Do While TMP1->(!EOF())
		IncProc()

		cLin:=""
		//01 - Periodo
		cLin += SubStr(DTOS(dPFecIni),1,8)
		cLin += cSep

		//02 - Código de la Cuenta Contable desagregada hasta el nivel máximo de dígitos utilizado
		cLin += AllTrim(TMP1->(IIf(nPlanCtas==1,CT1_CONTA,CVD_CTAREF)))
		cLin += cSep

		//03 - Descripción de la Cuenta Contable desagregada al nivel máximo de dígitos utilizado
		cLin += AllTrim(TMP1->(IIf(nPlanCtas==1,CT1_DESC01,CVN_DSCCTA)))
		cLin += cSep

		//04 - Código del Plan de Cuentas utilizado por el deudor tributario - TABELA 17
		cLin += cPlanRef
		cLin += cSep

		//05 - Descripción del Plan de Cuentas utilizado por el deudor tributario - TABELA17
		If AllTrim(cPlanRef) $ "01"
			cLin +=STR0057 + STR0058 //"PLAN CONTABLE " # "GENERAL EMPRESARIAL"
		ElseIf AllTrim(cPlanRef) $ "02"
			cLin +=STR0057 + STR0059 //"PLAN CONTABLE " # "GENERAL REVISAOO"
		ElseIf AllTrim(cPlanRef) $ "03"
			cLin +=STR0060 + STR0061//"PLAN DE CUENTAS " # "PARA EMPRESAS DEL SISTEMA FINANCIERO"
		ElseIf AllTrim(cPlanRef) $ "04"
			cLin +=STR0060 + STR0062 //"PLAN DE CUENTAS " # "PARA ENTIDADES PRESTADORAS DE SALUD"
		ElseIf AllTrim(cPlanRef) $ "05"
			cLin +=STR0060 + STR0063 //"PLAN DE CUENTAS " # "PARA EMPRESAS DEL SISTEMA ASEGURADOR"
		ElseIf AllTrim(cPlanRef) $ "06"
			cLin +=STR0064 //"PLAN DE CUENTAS, ADMIN. PRIVADAS DE FONDOS DE PENSIONES"
		ElseIf AllTrim(cPlanRef) $ "07"
			cLin +=STR0065 //"PLAN CONTABLE GUBERNAMENTAL"
		ElseIf AllTrim(cPlanRef) $ "99"
			cLin +=STR0066 //"OTROS"
		Else
			cLin +=STR0066 //"OTROS"
		EndIf
		cLin += cSep

		//06 - Código de la Cuenta Contable Corporativa desagregada hasta el nivel máximo de dígitos utilizadoo
		cLin += ""
		cLin += cSep

		//07 - Descripción de la Cuenta Contable Corporativa desagregada al nivel máximo de dígitos utilizado
		cLin += ""
		cLin += cSep

		//08 - Indica el estado de la operación
		If dPFecFin >= dPFecIni
			cLin += '1'
		Else
			cLin += '9'
		EndIf
		cLin += cSep

		cLin += chr(13)+chr(10)

		fWrite(nHdl,cLin)
		TMP1->(dbSkip())
	EndDo

	fClose(nHdl)

EndIf

TMP1->(DbCloseArea())
CtbTmpErase(cTMPTMP1Fil)

If nPlanCtas == 2
	CtbTmpErase(cTmpCVDFil)
	CtbTmpErase(cTmpCVNFil)
EndIf

Return Nil

Static function QryCT2
Local cFilCTL	:= " CTL_FILIAL = '" + XFILIAL("CTL") + "' "
Local cFilCT1	:= " CT1_FILIAL " + GetRngFil( aSelFil, "CT1", .T., @cTmpCT1Fil )
Local cFilCT2	:= " CT2_FILIAL " + GetRngFil( aSelFil, "CT2", .T., @cTmpCT2Fil )
Local cFilCVD	:= " CVD_FILIAL " + GetRngFil( aSelFil, "CVD", .T., @cTmpCVDFil )
Local cQuery	:= ''

DBSELECTAREA("CTL")
DBSELECTAREA("CT2")
DBSELECTAREA("CT1")

TMP := GetNextAlias()

cQuery := " SELECT CT2_FILIAL"
cQuery += "      , CT2_DATA"
cQuery += "      , CT2_LOTE"
cQuery += "      , CT2_SBLOTE"
cQuery += "      , CT2_DOC"
cQuery += "      , CT2_LINHA"
cQuery += "      , CT2_DC"
cQuery += "      , CT2_VALOR"
cQuery += "      , CT2_DIACTB"
cQuery += "      , CT2_SEGOFI"
cQuery += "      , CT2_NODIA"
cQuery += "      , CT2_ROTINA"
cQuery += "      , CT1_CONTA"
cQuery += "      , CT2_DEBITO"
cQuery += "      , CT2_CREDIT"
cQuery += "      , CT1_DESC01"
cQuery += "      , CVL_CTBCLA"
cQuery += "      , CVL_DESCR"
cQuery += "      , CT2_HIST"
cQuery += "      , CT2_MOEDLC"
cQuery += "      , CT2_CCD"
cQuery += "      , CT2_CCC"
cQuery += "      , CT2_KEY"
cQuery += "      , CT2_LP"
cQuery += "      , CT2.R_E_C_N_O_, CTL_KEY, CTL_ORDER, CTL_ALIAS, CT2_AGLUT"

If nPlanCtas == 2
	cQuery += ", CVD_CTAREF"
EndIf

cQuery += "   FROM " + RetSqlName('CT2') + " CT2"
cQuery += "        JOIN " + RetSqlName('CT1') + " CT1 ON " + cFilCT1 + " AND ( CT1_CONTA = CT2.CT2_DEBITO OR  CT1_CONTA = CT2.CT2_CREDIT ) AND CT1.D_E_L_E_T_ = ' ' "
cQuery += "   LEFT JOIN " + RetSqlName('CTL') + " CTL ON " + cFilCTL + " AND   CT2_LP = CTL_LP  AND CTL.D_E_L_E_T_ = ' ' "
cQuery += "   LEFT JOIN " + RetSqlName('CVL') + " CVL ON CVL.CVL_FILIAL = CT2.CT2_FILIAL AND CVL.CVL_COD = CT2.CT2_DIACTB AND CVL.D_E_L_E_T_ = ' ' "

If nPlanCtas == 2
	cQuery += "   LEFT JOIN " + RetSqlName('CVD') + " CVD ON " + cFilCVD + " AND CVD.CVD_CODPLA = '" + cPCGE  + "' AND CVD.CVD_VERSAO = '" + cVersion  + "' AND CVD.CVD_ENTREF = '" + cEntidad + "' AND CVD.CVD_CONTA = CT1.CT1_CONTA AND CVD.D_E_L_E_T_ = ' ' "
EndIf

cQuery += "  WHERE " + cFilCT2
cQuery += "    AND CT2_DATA BETWEEN '" + DTOS( dPFecIni ) + "' AND '" + DTOS ( dPFecFin ) + "' "
cQuery += "    AND CT2_MOEDLC = '" + cPMon + "' "
cQuery += "    AND CT2_TPSALD = '" + cPTPSld + "' "
cQuery += "    AND NOT (CT2_DEBITO = ' ' AND CT2_CREDIT = ' ')"
cQuery += "    AND CT2_VALOR <> 0 "
cQuery += "    AND CT2.D_E_L_E_T_ = ' ' "

If nPTipPrc == 2 .Or. nPlanCtas == 1
	cQuery += "  ORDER BY CT2_FILIAL,CT2_SEGOFI,CT2_DATA,CT1_CONTA "
Else
	cQuery += "  ORDER BY CT2_FILIAL,CT2_SEGOFI,CT2_DATA,CVD_CTAREF "
EndIf

ChangeQuery(cQuery)

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), 'TMP', .T., .F. )

DbSelectArea('TMP')

TcSetField("TMP","CT2_DATA" ,"D")

Return

/*/{Protheus.doc} ValidaDir
	Valida existencia carpeta/directorio, si no existe lo crea
	@type    Static Function
	@author  ARodriguez
	@since 	 04/07/2022
	@version 1.0
	@param   cDir, string, directorio a validar
	@return  lRet, logical, directorio válido
/*/
Static Function ValidaDir(cDir)
Local cDrive	:= ""
Local cPath		:= ""
Local cDest		:= ""
Local cExt		:= ""

SplitPath(Trim(cDir) + "dummy.txt", @cDrive, @cPath, @cDest, @cExt)
cDir := cDrive + cPath

If !ExistDir(cDir)
	If MakeDir(cDir) != 0
		MsgAlert( StrTran(STR0076, "#FERROR#", Alltrim(Str(FERROR()))), STR0020)	//"Directorio no válido (#FERROR#). El archivo será creado en SYSTEM." ## "FORMATO 5.1: LIBRO DIARIO"
		cDir := ""
	Endif
EndIf

Return cDir

/*/{Protheus.doc} fGenCAR
	Arma el Código de Anotación de Registro (CAR)
	@type    Static Function
	@author  Diego.Rivera
	@since 	 25/01/2024
	@version 1.0
	@param   cTipCP, caracter, Tipo de documento o comprobante de pago
	@param   cSerieCP, caracter, Número de serie del comprobante de pago
	@param   cNumCP, caracter, Número del documento o comprobante de pago
	@return  cKlin
/*/
Static Function fGenCAR(cTipCP,cSerieCP,cNumCP)

local cKlin := ""
local cRUC := AllTrim(SM0->M0_CGC)
Default cTipCP  := ""
Default cSerieCP:= ""
Default cNumCP:= ""

If Len(cRUC) > 11
	cRUC := RIGHT(cRUC,11)
ElseIf Len(cRUC) < 11
	cRUC := PadL(cRUC,11,"0")
Endif

cTipCP := iif(AllTrim(cTipCP)=="","00",AllTrim(cTipCP))

cSerieCP := alltrim(cSerieCP)
If Len(cSerieCP) > 4
	cSerieCP := RIGHT(cSerieCP,4)
ElseIf Len(cSerieCP) < 4
	cSerieCP := PadL(cSerieCP,4,"0")
Endif

cNumCP := alltrim(cNumCP)
If Len(cNumCP) > 10
	cNumCP := RIGHT(cNumCP,10)
ElseIf Len(cNumCP) < 10
	cNumCP := PadL(cNumCP,10,"0")
Endif

cKlin := cRUC + cTipCP + cSerieCP + cNumCP

Return(cKlin)
