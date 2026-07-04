/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "INKEY.CH"
#Include "RPTDEF.CH"
#Include "TBICONN.CH"
#INCLUDE "GPER032.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER032  ³ Autor ³ Bruno Sobieski        ³ Data ³ 22.02.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Libro de remuneraciones de Chile                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER032(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcos Kato ³--------³------³Ajuste no relatorio para a impressao de   ³±±
±±³            ³--------³------³um novo modelo para a localizacao Chile.  ³±±
±±³            ³--------³------³O novo modelo podera imprimir mais de uma ³±±
±±³            ³--------³------³coluna nao tendo o limite determinado no  ³±±
±±³            ³--------³------³modelo anterior(8 colunas). 			    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programador  ³ Data     ³ FNC            ³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³±±
±±³Rogerio R.   ³29/07/2009³00000018278/2009³Compatibilizacao dos fontes para aumento do³±±
±±³             ³          ³                ³campo filial e gestão corporativa.         ³±±
±±³Alex         ³16/11/2009³00000028005/2009³Adaptação gestão corporativa               ³±±
±±³             ³		      ³                ³                                           ³±±
±±³Jonathan glez³05/05/2015³      PCREQ-4256³Se elimina la funcion AjustSx1, la cual    ³±±
±±³             ³		      ³                ³realiza la modificacion aldiccionario de   ³±±
±±³             ³		      ³                ³datos(SX1) por motivo de adecuacion a nueva³±±
±±³             ³		      ³                ³estructura de SXs para version 12          ³±±
±±³Alex hdez    ³07/01/2016³PCREQ-7943      ³Se paso a la v12 a partir del fuente de v11³±±
±±³             |          |                |con la fecha 28/09/15                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function GPER032()

Local 		oReport
Local 		aAreaL := getArea()
private 	cPerg 	:= 'GPR032CHI'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Preguntas selecionadas - GPR032CHI                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variable utilizadas para parametros                                    ³
//³ mv_par01     // ¿Proceso?                                              ³
//³ mv_par02     // ¿Tipo Procedimiento?                                   ³
//³ mv_par03     // ¿Periodo?                                              ³
//³ mv_par04     // ¿No. Pago?                                             ³
//³ mv_par05     // ¿De Sucursal?                                          ³
//³ mv_par06     // ¿A Sucursal?                                           ³
//³ mv_par07     // ¿De Centro de Costo?                                   ³
//³ mv_par08     // ¿A Centro de Costo?                                    ³
//³ mv_par09     // ¿De Matricula?                                         ³
//³ mv_par10     // ¿A Matricula?                                          ³
//³ mv_par11     // ¿De Nombre?                                            ³
//³ mv_par12     // ¿A Nombre?                                             ³
//³ mv_par13     // ¿De Chapa?                                             ³
//³ mv_par14     // ¿A Chapa?                                              ³
//³ mv_par15     // ¿Situaciones a Imp.?                                   ³
//³ mv_par16     // ¿Categorias a Imp.?                                    ³
//³ mv_par17     // ¿Tipo Total?                                           ³
//³ mv_par18     // ¿Versión a Imprimir?                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    
If pergunte(cPerg,.T.)

	If FindFunction("TRepInUse") .And. TRepInUse() .and. mv_par18==1 //11.3 o superior
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impresión                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	    oReport:= ReportDef()
	    oReport:PrintDialog()
	Elseif mv_par18==2  //Anterior a 11.3
		    
		U_GPER032A()
		
	EndIf

EndIf

RestArea( aAreaL )
Return( NIL )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Alf. Medrano           ³ Data ³28/08/2015³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³funcion estatica ReportDef                                  ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ReportDef()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ GPER032                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
static Function ReportDef()
    Local cTitulo  	:= ""
    Local cDescrip 	:= ""
    Local aOrdem		:= {}
    Local nX			:= 0
    Local nTam 		:= 40
    cDescrip			:= OemToAnsi(STR0014) // TOTALES LIBRO DE REMUNERACIONES
    cTitulo			:= OemToAnsi(STR0004) // LIBRO DE REMUNERAC.
   
    //  aOrdem  
    Aadd(aOrdem, STR0001)  // Matricula 
    Aadd(aOrdem, STR0002)  // Centro de Trabajo
    Aadd(aOrdem, STR0003)  // Centro de Costos
       
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    oReport:= TReport():New("GPER032",cTitulo,cPerg, {|oReport| ReportPrint(oReport)},cDescrip) 
    oReport:SetLandscape() 			//orientación horizontal.       
    oReport:SetTotalInLine(.F.) 	//True = imprime totalizadores 
    oReport:nFontBody   := 5    	//Tamaño fuente del documento
    oReport:nLineHeight := 30   	//Altura de linea 
    oReport:nColSpace   := 2    	//Espacio entre las columnas de información
   	oReport:nLeftMargin := 3	  	//Tamaño margen izquierda
    oReport:ShowHeader()			//imprimir el encabezado del informe (por default)
    oReport:cFontBody   := "COURIER NEW" // tipo de letra
    

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
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 1  (oSection)                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    oSection1 := TRSection():New(oReport,,,aOrdem)
    oSection1 :SetHeaderPage() //Muestra el encabezado de la sección
    oSection1 :SetLinesBefore(0) //Define a quantidade de linhas que serão saltadas antes da impressão da seção
    oSection1 :SetLineBreak(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 2  (oSection)                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    oSection2 := TRSection():New(oReport,,,)
    oSection2:SetHeaderPage()
    oSection2:SetLineBreak(.F.) //.T. imprime una o mas lineas - .F.= no imprime linea    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criação da celulas (columnas) da seção do relatório                     ³
//³                                                                        ³
//³ TRCell():New                                                           ³  
//³ ExpO1 : Objeto TSection que a secao pertence                           ³
//³ ExpC2 : Nome da celula do relatório. O SX3 será consultado             ³
//³ ExpC3 : Nome da tabela de referencia da celula                         ³
//³ ExpC4 : Titulo da celula                                               ³ 
//³ Default : X3Titulo()                                                   ³
//³ ExpC5 : Picture                                                        ³
//³ Default : X3_PICTURE                                                   ³
//³ ExpC6 : Tamanho                                                        ³
//³ Default : X3_TAMANHO                                                   ³
//³ ExpL7 : Informe se o tamanho esta em pixel                             ³
//³ Default : False                                                        ³      
//³ ExpB8 : Bloco de código para impressao.                                ³
//³ Default : ExpC2                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    TRCell():New(oSection2,'NOMBRE'	, 	,STR0021  ,,nTam, /*lPixel*/,/*{|| code-block de impressao }*/) //"Nomb. del trabajador"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 3  (oSection)                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    oSection3 := TRSection():New(oReport,,,)
    oSection3:SetHeaderPage()
    oSection3:SetLineBreak(.F.) //.T. imprime una o mas lineas - .F.= no imprime linea     
	 TRCell():New(oSection3,'TITULO'	, 	,STR0022  ,,nTam, /*lPixel*/,/*{|| code-block de impressao }*/) // "Cargo"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 4  (oSection)                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    oSection4 := TRSection():New(oReport,,,)
    oSection4:SetHeaderPage()
    oSection4:SetLineBreak(.F.) //.T. imprime una o mas lineas - .F.= no imprime linea         
 	TRCell():New(oSection4,'TITULO'	, 	,STR0023 +" "+ STR0024  ,,nTam, /*lPixel*/,/*{|| code-block de impressao }*/) // "Dias " + "Trab.Rut"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 5  (oSection)                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    oSection5 := TRSection():New(oReport,,,)
    oSection5:SetHeaderPage()
    oSection5:SetLineBreak(.F.) //.T. imprime una o mas lineas - .F.= no imprime linea  
 	TRCell():New(oSection5,''	, 	,''  ,,nTam, /*lPixel*/,/*{|| code-block de impressao }*/)    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 6  (oSection)                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    oSection6 := TRSection():New(oReport,,,)
    oSection6:SetHeaderPage()
    oSection6:SetLineBreak(.F.) //.T. imprime una o mas lineas - .F.= no imprime linea      
 	 TRCell():New(oSection6,''	, 	,''  ,,nTam, /*lPixel*/,/*{|| code-block de impressao }*/)  
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 7  (oSection)                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    oSection7 := TRSection():New(oReport,,,)
    oSection7:SetHeaderPage()
    oSection7:SetLineBreak(.F.) //.T. imprime una o mas lineas - .F.= no imprime linea
    TRCell():New(oSection7,''	, 	,''  ,,nTam, /*lPixel*/,/*{|| code-block de impressao }*/)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 8  (oSection)                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    oSection8 := TRSection():New(oReport,,,)
    oSection8:SetHeaderPage()
    oSection8:SetLineBreak(.F.) //.T. imprime una o mas lineas - .F.= no imprime linea  
 	 TRCell():New(oSection8,''	, 	,''  ,,nTam, /*lPixel*/,/*{|| code-block de impressao }*/)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 9  (oSection)                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    oSection9 := TRSection():New(oReport,,,)
    oSection9:SetHeaderPage()
    oSection9:SetLineBreak(.F.) //.T. imprime una o mas lineas - .F.= no imprime linea  
    TRCell():New(oSection9,''	, 	,''  ,,nTam, /*lPixel*/,/*{|| code-block de impressao }*/)   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 10  (oSection)                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    oSection10 := TRSection():New(oReport,,,)
    oSection10:SetHeaderPage()
    oSection10:SetLineBreak(.F.) //.T. imprime una o mas lineas - .F.= no imprime linea  
	 TRCell():New(oSection10,'RA_MAT',	'SRA',	'',/*Picture*/,TamSx3("RA_MAT")[1],		/*lPixel*/,/*{|| code-block de impressao }*/) //MATRICULA
	 TRCell():New(oSection10,'RA_NOME',	'SRA',	'',/*Picture*/,TamSx3("RA_NOME")[1],		/*lPixel*/,/*{|| code-block de impressao }*/) //NOMBRE
    TRCell():New(oSection10,'RA_RG',   'SRA',	'',/*Picture*/,TamSx3("RA_RG")[1]  ,		/*lPixel*/,/*{|| code-block de impressao }*/) //RG
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 11  (oSection)                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    oSection11 := TRSection():New(oReport,,,)
    oSection11:SetHeaderPage()
    oSection11:SetLineBreak(.F.) //.T. imprime una o mas lineas - .F.= no imprime linea  
	 TRCell():New(oSection11,'RA_CODFUNC',	'SRA',	'',/*Picture*/,TamSX3('RJ_DESC')[1],		/*lPixel*/,/*{|| code-block de impressao }*/) //CARGO

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 12  (oSection)                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    oSection12 := TRSection():New(oReport,,,)
    oSection12:SetHeaderPage()
    oSection12:SetLineBreak(.F.) //.T. imprime una o mas lineas - .F.= no imprime linea  
	 TRCell():New(oSection12,'RA_CIC',	'SRA',	'',/*Picture*/,TamSX3('RA_CIC')[1] + 3,		/*lPixel*/,/*{|| code-block de impressao }*/) //RUT
	 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 13  (oSection)                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    oSection13 := TRSection():New(oReport,,,)	
    oSection13:SetHeaderPage()
    oSection13:SetLineBreak(.F.) //.T. imprime una o mas lineas - .F.= no imprime linea  
    oSection13:SetPageBreak(.t.)
	 TRCell():New(oSection13,'TOTAL',	'',	'',/*Picture*/,nTam,		/*lPixel*/,/*{|| code-block de impressao }*/) //total
Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint ³ Autor ³ ALf Medrano         ³ Data ³28/08/2015³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos  ³±±
±±³          ³os relatorios que poderao ser agendados pelo usuario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ReportDef                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aArea		:= GetArea()
Local cString 	:="SRA"        					// alias do arquivo principal (Base)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn		:= {STR0009, 1,STR0010, 2, 2, 1, "",1 }	//"Zebrado"###"Administra‡„o"
Private nomeprog		:= "GPER032CHI"
Private cOrdem		:= ""
Private cCategoria	:= ""
Private nLastKey		:= 0
Private nPagina		:=	0
Private aCabec 		:= {}
Private aValores		:= {}
Private Li     		:= 80   
Private Titulo 		:= STR0011		//"EMISSŽO DE RECIBOS DE PAGAMENTOS"
Private cTamanho		:= "P"
Private lImprCab		:= .F.
Private cProceso 		:= "" //Proceso
Private cTpoNomina	:= "" //Tipo Nomina
Private cPeriodo		:= "" //Periodo
Private cNoPago		:= "" //Numero pago


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cProceso 	:= mv_par01 //Proceso
cTpoNomina	:= mv_par02 //Tipo Nomina
cPeriodo	:= mv_par03 //Periodo
cNoPago	:= mv_par04 //Numero pago
cFilDe 	:= mv_par05 //Filial De
cFilAte	:= mv_par06 //Filial Ate
cCcDe		:= mv_par07 //Centro de Custo De
cCcAte		:= mv_par08 //Centro de Custo Ate
cMatDe		:= mv_par09 //Matricula DesS
cMatAte	:= mv_par10 //Matricula Ate
cNomDe		:= mv_par11 //Nome De
cNomAte	:= mv_par12 //Nome Ate
ChapaDe	:= mv_par13 //Chapa De
ChapaAte	:= mv_par14 //Chapa Ate
cSituacao	:= mv_par15 //Situacoes a Imprimir
cCategoria	:= mv_par16 //Categorias a Imprimir


//Valida que no este vacio el proceso
IF empty(cProceso)
	MSGALERT(STR0028, STR0027) //"El campo de Proceso esta vacio" + "Campo Vacio"
	Return
endif

//Valida que no este vacio el Roteiro
IF empty(cTpoNomina)
	MSGALERT(STR0029, STR0027) //"El campo de Tipo Nomina esta vacio" + "Campo Vacio"
	Return
endif

//Valida que no este vacio el Periodo
IF empty(cPeriodo)
	MSGALERT(STR0030, STR0027)//"El campo de Periodo esta vacio" + "Campo Vacio"
	Return
endif

//Valida que no este vacio el No. Pago
IF empty(cNoPago)
	MSGALERT(STR0031, STR0027) //"El campo de No. Pago esta vacio" +  "Campo Vacio"  
	Return
endif

	
//Imprime cabecalho detalhado
If mv_par17==2 //1-Vertical|2-Horizontal
	lImprCab:=.T.                   
Endif	
//SetDefault(aReturn,cString,,,"G",aReturn[4]) //define letra grande

R032ImpTR(oReport,cString,cProceso, cTpoNomina, cPeriodo, cNoPago)

RestArea(aArea)

Return( NIL )
    
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R032ImpTR³ Autor ³ Alf Medrano                 ³ Data ³ 07.09.15 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processamento Para emissao do Libro de Remuneraciones            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ R032ImpTR(ExpO1,ExpC2,ExpC3,ExpC4,ExpC5,ExpC6)                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1: Objeto del Reporte   ExpC2: Alias tabla    ExpC3: Porceso ³±±
±±³          ³ ExpC4: Tipo Nomina          ExpC5: Periodo        ExpC6: No. Pago³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ReportPrint                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R032ImpTR(oReport,cString,cProceso, cTpoNomina, cPeriodo, cNoPago)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aOrdBag     := {}
Local cArqMov     := ""

Local cAcessaSRA  := &("{ || " + ChkRH("GPER032","SRA","2") + "}")

Local aInfo
Local nX:=0, nY:=0, nQtdDias:=0
Local nLine := nCol := 0
Local oSection1 := oReport:Section(1)	// seccion de Titulos 
Local oSection2 := oReport:Section(2)	// seccion de contenido conceptos SX5  
Local oSection3 := oReport:Section(3)	// seccion de contenido conceptos SX5  
Local oSection4 := oReport:Section(4)	// seccion de contenido conceptos SX5  
Local oSection5 := oReport:Section(5)	// seccion de contenido conceptos SX5  
Local oSection6 := oReport:Section(6)	// seccion de contenido conceptos SX5  
Local oSection7 := oReport:Section(7)	// seccion de contenido conceptos SX5  
Local oSection8 := oReport:Section(8)	// seccion de contenido conceptos SX5  
Local oSection9 := oReport:Section(9)	// seccion de contenido conceptos SX5  
Local oSection10:= oReport:Section(10)// seccion de contenido empleado
Local oSection11:= oReport:Section(11)// seccion de contenido empleado
Local oSection12:= oReport:Section(12)// seccion de contenido empleado
Local oSection13:= oReport:Section(13)// Totales
local nOrdem		:= oSection1:GetOrder() 
local cValor		:= ""

If  SRV->(ColumnPos("RV_IMPLBRE")) * SRV->(ColumnPos("RV_POSLBRE")) == 0 
	Return .F.
EndIf

Private cVerba      := ""
Private aTotais     := {}
Private cAliasMov := ""
Private Desc_Fil  := "" 
Private Desc_End  := "" 
Private Desc_CGC  := ""
Private nColMax   := 0
Private nRenMax   := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Selecionando a Ordem de impressao escolhida no parametro.    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( "SRA")

If nOrdem == 1
	dbSetOrder(1)
ElseIf nOrdem == 2
	dbSetOrder(2)
ElseIf nOrdem == 3
	dbSetOrder(3)
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Selecionando o Primeiro Registro e montando Filtro.          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOrdem == 1
	cInicio := "SRA->RA_FILIAL + SRA->RA_MAT"
	cOrdem	:= STR0001 //"Matricula"
	MsSeek(cFilDe + cMatDe,.T.)
	cFim    := cFilAte + cMatAte
ElseIf nOrdem == 2
	MsSeek(cFilDe + cCcDe + cMatDe,.T.)
	cOrdem	 := STR0002 //"C Costo"
	cInicio  := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
	cFim     := cFilAte + cCcAte + cMatAte
ElseIf nOrdem == 3
	MsSeek(cFilDe + cNomDe + cMatDe,.T.)
	cOrdem	:= STR0003 //"Nomb"
	cInicio := "SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT"
	cFim    := cFilAte + cNomAte + cMatAte
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica o tamanho maximo de coluna                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 nColMax:=8

	nRenMax:=0
	DbselectArea("SX5")
	SX5->(DbSetOrder(1)) // X5_FILIAL+X5_TABELA+X5_CHAVE
	SX5->(DbGoTop()) // iniciar en la 1ra posicion
	If MsSeek(xFilial("SX5")+"O0")
		While SX5->X5_FILIAL+SX5->X5_TABELA==xFilial("SX5")+"O0" .And. !SX5->(EOF())
		   If Val(Substr(SX5->X5_CHAVE,3,2)) > nColMax
		      nColMax:=Val(Substr(SX5->X5_CHAVE,3,2))
		   EndIf                                        
		   If Val(Substr(SX5->X5_CHAVE,1,2)) > nRenMax
		      nRenMax:=Val(Substr(SX5->X5_CHAVE,1,2))
		   EndIf                                       
		   
		   SX5->(DbSkip())
		Enddo                        
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verba que ira trazer a quantidade de dias                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SRV")
	SRV->(DbSetOrder(2)) // RV_FILIAL+RV_CODFOL
	SRV->(DbGoTop())
	If MsSeek(xFilial("SRV")+"0031")//031-indentificador de calculo
		cVerba:=SRV->RV_COD//Codigo da Verba	
	Endif               
	SRV->(DbSetOrder(1))


aTotais:=Array(nRenMax,nColmax)
for nx:=1 to nRenMax
	aFill(aTotais[nx],0)
next	

dDtPesqAf :=  CTOD("01/" + SubStr(cPeriodo,5,6) + "/" + SubStr(cPeriodo,0,4),"DDMMYY")

dbSelectArea("SRA")
SRA->(dbGoTop())
cFilialAnt := Space(FWGETTAMFILIAL)
fCabecTR(dDtPesqAf,oReport )


oReport:SetMeter(RecCount())   
While SRA->( !Eof() .And. &cInicio <= cFim )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta Regua Processamento                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:IncMeter()
		If oReport:Cancel() //termina proceso si se cancela el reporte
			Exit
		EndIf
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste Parametrizacao do Intervalo de Impressao            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (SRA->RA_CHAPA < ChapaDe) .Or. (SRA->Ra_CHAPa > ChapaAte) .Or. ;
		(SRA->RA_NOME < cNomDe)    .Or. (SRA->Ra_NOME > cNomAte)    .Or. ;
		(SRA->RA_MAT < cMatDe)     .Or. (SRA->Ra_MAT > cMatAte)     .Or. ;
		(SRA->RA_CC < cCcDe)       .Or. (SRA->Ra_CC > cCcAte)
		SRA->(dbSkip(1))
		Loop
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica Data Demissao         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSitFunc := SRA->RA_SITFOLH
	//dDtPesqAf :=  CTOD("01/" + SubStr(cPeriodo,5,6) + "/" + SubStr(cPeriodo,0,4),"DDMMYY")
	If cSitFunc == "D" .And. (!Empty(SRA->RA_DEMISSA) .And. MesAno(SRA->RA_DEMISSA) > MesAno(dDtPesqAf))
		cSitFunc := " "
	Endif	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste situacao e categoria dos funcionarios			     |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !( cSitFunc $ cSituacao ) .OR.  ! ( SRA->RA_CATFUNC $ cCategoria )
		dbSkip()
		Loop
	Endif
	
	If cSitFunc $ "D" .And. Mesano(SRA->RA_DEMISSA) # Mesano(dDtPesqAf)
		dbSkip()
		Loop
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste controle de acessos e filiais validas				 |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   	If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
  	   dbSkip()
      Loop
  	EndIf
    
	If SRA->RA_Filial # cFilialAnt
		If ! fInfo(@aInfo,Sra->Ra_Filial)
			Exit
		Endif
		Desc_Fil := aInfo[3]
		Desc_End := Alltrim(aInfo[4]) + space(2) + Alltrim(aInfo[14]) + space(2) + aInfo[13]                // Dados da Filial
		Desc_CGC := Transform( aInfo[8] , "@R 99.999.999-9")
		dbSelectArea("SRA")
		cFilialAnt := SRA->RA_FILIAL
	Endif
	nQtdDias:=0	

	IF U_TablaMov()
		            
				oSection10:Init()
				oSection11:Init()
				oSection12:Init()
			For nX:=	1	To	LEN(aValores) 
				
				If nX==1
					oSection10:cell("RA_MAT"):SetValue(SRA->RA_MAT) //MATRICULA
					oSection10:cell("RA_NOME"):SetValue(alltrim(SRA->RA_NOME))//NOMBRE
					oSection10:cell("RA_RG"):SetValue(SRA->RA_RG)//RG
					oSection10:PrintLine()
				ElseIf	nX== 2
					oSection11:cell("RA_CODFUNC"):SetValue(Substr(FDESC('SRJ',SRA->RA_CODFUNC,'RJ_DESC',TamSX3('RJ_DESC'),SRA->RA_FILIAL),1,22)) // PUESTO
					oSection11:PrintLine()
				ElseIf nX==3 
					oSection12:cell("RA_CIC"):SetValue(Alltrim(Str(nQtdDias))+"|"+SRA->RA_CIC) //RUT
					oSection12:PrintLine()
				Endif		
					
				For nY	:=	1	To Len(aValores[1])
						//@Li, (nY*14)+14 PSAY ABS(aValores[nX][nY]) Picture TM(aValores[nX][nY],13,MsDecimais(1))
						
					cValor:=	 alltrim(Transform( ABS(aValores[nX][nY]) , TM(aValores[nX][nY],13,MsDecimais(1))))
						
					If nx == 1
						oSection2:Init()
						oSection2:cell('TITULO' + ALLTRIM(STR(nY))):SetValue(cValor) 
					EndIf
					If nx == 2
						oSection3:Init()
						oSection3:cell('TITULO' + ALLTRIM(STR(nY))):SetValue(cValor) 
					EndIf
					If nx == 3
						oSection4:Init()
						oSection4:cell('TITULO' + ALLTRIM(STR(nY))):SetValue(cValor) 			
					EndIf
					If nx == 4
						oSection5:Init()
						oSection5:cell('TITULO' + ALLTRIM(STR(nY))):SetValue(cValor) 
					EndIf
					If nx == 5
						oSection6:Init()
						oSection6:cell('TITULO' + ALLTRIM(STR(nY))):SetValue(cValor) 
					EndIf
					If nx == 6
						oSection7:Init()
						oSection7:cell('TITULO' + ALLTRIM(STR(nY))):SetValue(cValor) 	
					EndIf
					If nx == 7
						oSection8:Init()
						oSection8:cell('TITULO' + ALLTRIM(STR(nY))):SetValue(cValor) 	
					EndIf
					If nx == 8
						oSection9:Init()
						oSection9:cell('TITULO' + ALLTRIM(STR(nY))):SetValue(cValor) 	
					EndIf
				Next
			Next  
			
			If ny > 0
				oSection2:PrintLine()
				oSection3:PrintLine()
				oSection4:PrintLine()
				oSection5:PrintLine()
				oSection6:PrintLine()
				oSection7:PrintLine()
				oSection8:PrintLine()
				oSection9:PrintLine()
			
				oSection2:Finish()
				oSection3:Finish()
				oSection4:Finish()
				oSection5:Finish()
				oSection6:Finish()
				oSection7:Finish()
				oSection8:Finish()
				oSection9:Finish()
			
				oReport:ThinLine()
			EndIf
	EndIf
	dbSelectArea("SRA")
	SRA->( dbSkip() )
EndDo

	IIF( oSection2:LineCount()== 0, oSection2:Hide(),)
	IIF( oSection3:LineCount()== 0, oSection3:Hide(),)
	IIF( oSection4:LineCount()== 0, oSection4:Hide(),)
	IIF( oSection5:LineCount()== 0, oSection5:Hide(),)
	IIF( oSection6:LineCount()== 0, oSection6:Hide(),)
	IIF( oSection7:LineCount()== 0, oSection7:Hide(),)
	IIF( oSection8:LineCount()== 0, oSection8:Hide(),)
	IIF( oSection9:LineCount()== 0, oSection9:Hide(),)
	


If lImprCab //Total Horizonal

	oSection13:Init()
	oSection13:cell("TOTAL"):SetValue(STR0015) //"TOT. "
	oSection13:PrintLine()
	For nX:=	1	To	nRenMax
		
		oSection13:cell("TOTAL" ):SetValue('') 
		For nY	:=	1	To nColMax
			
			oSection13:cell("TOTAL"):SetValue('')
			cValor:=	 alltrim(Transform( abs( aTotais[nX][nY]) , TM(aTotais[nX][nY],13,MsDecimais(1))))
			oSection13:cell("TOTAL" + ALLTRIM(STR(nY)) ):SetValue(cValor) //
                 
		Next
		oSection13:PrintLine()
		
		Li++
	Next 
	oSection13:Finish() 			
Else //Total Vertical

	oSection13:Init()	
	oSection13:cell("TOTAL"):SetValue(STR0014) //"TOTALES LIBRO DE REMUNERACIONES"
	oSection13:PrintLine()

	SX5->(MsSeek(xFilial("SX5")+"O0"))
	While SX5->X5_FILIAL+SX5->X5_TABELA==xFilial("SX5")+"O0" .And. !SX5->(EOF())
			cTmpCod:=Substr(SX5->X5_CHAVE,1,2)
			While SX5->X5_FILIAL+SX5->X5_TABELA==xFilial("SX5")+"O0" .And. !SX5->(EOF()) .and. cTmpCod==Substr(SX5->X5_CHAVE,1,2) 
                      nLine := Val(Substr(SX5->X5_CHAVE,1,2))
                      nCol := Val(Substr(SX5->X5_CHAVE,3,2))
		   						cValor:=	 alltrim(Transform( abs(aTotais[nLine][nCol]) , TM(aTotais[nLine][nCol],18,MsDecimais(1))))
								oSection13:cell("TOTAL"):SetValue(Substr(X5Descri(),1,20))
								oSection13:cell("TOTAL1"):SetValue(cValor)
								oSection13:PrintLine()
				SX5->(DbSkip())
			enddo
			oReport:SkipLine()
			//Li++
	Enddo
	oSection13:Finish() 		
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona arq. defaut do Siga caso Imp. Mov. Anteriores      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty( cAliasMov )
	fFimArqMov( cAliasMov , aOrdBag , cArqMov )
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SRC")
dbSetOrder(1)          // Retorno a ordem 1

dbSelectArea("SRA")
DbClearFilter()
RetIndex("SRA")
Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fCabecTR  ³ Autor ³ Alf Medrano           ³ Data ³ 08.09.15 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMRESSAO Cabe‡alho                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fCabecTR(ExpD1,ExpO2)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1: Fecha                                               ³±±
±±³          ³ ExpO2: Objeto de reporte                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fCabecTR(dDtPesqAf,oReport )   // Cabecalho
Local aCabecTmp:=	Array(nRenMax,nColMax)//datos encabezado    
Local nX,nY 
Local nPosCol:=0
Local oSection1 := oReport:Section(1)	// seccion de Titulos 
Local oSection2 := oReport:Section(2)	// seccion de contenido conceptos SX5  
Local oSection3 := oReport:Section(3)	// seccion de contenido conceptos SX5  
Local oSection4 := oReport:Section(4)	// seccion de contenido conceptos SX5  
Local oSection5 := oReport:Section(5)	// seccion de contenido conceptos SX5  
Local oSection6 := oReport:Section(6)	// seccion de contenido conceptos SX5  
Local oSection7 := oReport:Section(7)	// seccion de contenido conceptos SX5  
Local oSection8 := oReport:Section(8)	// seccion de contenido conceptos SX5  
Local oSection9 := oReport:Section(9)	// seccion de contenido conceptos SX5  
Local oSection13 := oReport:Section(13)	// totales
nPagina++    

If nColMax>8 //lImprCab
   nPosCol:=180
else
	nPosCol:=100
endif   

// Imprime titulos de las columnas
TRCell():New(oSection1,'PERIO','',STR0018+MesExtenso(SubStr(cPeriodo,5,6))+STR0032+ SubStr(cPeriodo,0,4),,15, /*lPixel*/,/*{|| code-block de impressao }*/) //"Periodo: remuneracao do Mes "" del " 
TRCell():New(oSection1,'GROUP','',STR0019+cOrdem ,,15, /*lPixel*/,/*{|| code-block de impressao }*/) //"Agrupados por: "
TRCell():New(oSection1,'SELEC','',STR0020+cCategoria ,,15, /*lPixel*/,/*{|| code-block de impressao }*/)//"Selec. : "

	If Len(aCabec) == 0
		aCabec	:=	array(nRenMax)
		for nx:=1 to nRenMax
			aFill(aCabecTmp[nx],"")
			aCabec[nx]:=""
		next	
		
		SX5->(MsSeek(xFilial("SX5")+"O0"))
		While SX5->X5_Filial+SX5->X5_TABELA	 == xFilial('SX5') + 'O0'
			If Val(Substr(SX5->X5_CHAVE,3,2))<=LEN(aCabecTmp[1])
				aCabecTmp[Val(Substr(SX5->X5_CHAVE,1,2))][Val(Substr(SX5->X5_CHAVE,3,2))]	:=	Substr(X5Descri(),1,13)
			Endif
			SX5->(DbSkip())
		Enddo
		For nX:=1	To	Len(aCabecTmp)
			For nY:=1	To	Len(aCabecTmp[nX])		
				If Empty(aCabecTmp[nX][nY])
					aCabecTmp[nX][nY]:=Space(13)
				Endif
				
				If nx == 1
					TRCell():New(oSection2,'TITULO' + ALLTRIM(STR(nY)) ,'',aCabecTmp[nX][nY] ,,15, /*lPixel*/,/*{|| code-block de impressao }*/)
					TRCell():New(oSection13,'TOTAL' + ALLTRIM(STR(nY)) ,'','' ,,15, /*lPixel*/,/*{|| code-block de impressao }*/)
				EndIf
				If nx == 2
					TRCell():New(oSection3,'TITULO' + ALLTRIM(STR(nY)) ,'',aCabecTmp[nX][nY] ,,15, /*lPixel*/,/*{|| code-block de impressao }*/)
				EndIf
				If nx == 3
					TRCell():New(oSection4,'TITULO' + ALLTRIM(STR(nY)) ,'',aCabecTmp[nX][nY] ,,15, /*lPixel*/,/*{|| code-block de impressao }*/)
				EndIf
				If nx == 4
					TRCell():New(oSection5,'TITULO' + ALLTRIM(STR(nY)) ,'',aCabecTmp[nX][nY] ,,15, /*lPixel*/,/*{|| code-block de impressao }*/)
				EndIf
				If nx == 5
					TRCell():New(oSection6,'TITULO' + ALLTRIM(STR(nY)) ,'',aCabecTmp[nX][nY] ,,15, /*lPixel*/,/*{|| code-block de impressao }*/)
				EndIf
				If nx == 6
					TRCell():New(oSection7,'TITULO' + ALLTRIM(STR(nY)) ,'',aCabecTmp[nX][nY] ,,15, /*lPixel*/,/*{|| code-block de impressao }*/)
				EndIf
				If nx == 7
					TRCell():New(oSection8,'TITULO' + ALLTRIM(STR(nY)) ,'',aCabecTmp[nX][nY] ,,15, /*lPixel*/,/*{|| code-block de impressao }*/)
				EndIf
				If nx == 8
					TRCell():New(oSection9,'TITULO' + ALLTRIM(STR(nY)) ,'',aCabecTmp[nX][nY] ,,15, /*lPixel*/,/*{|| code-block de impressao }*/)
				EndIf
				
				
				aCabec[nX]	+=	aCabecTmp[nX][nY]+" "
			Next
		Next		
	Endif	

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GPER032A  ³ Autor ³ Alf Medrano           ³ Data ³ 21.09.15 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ impresion de informe versiones anteriores a v11            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER032A()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER032A()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cString :="SRA"        // alias do arquivo principal (Base)
Local aOrd    := {STR0001,STR0002,STR0003} //"Matricula"###"C.Custo"###"Nome"
Local cDesc1  := STR0006		//"Emiss„o de Recibos de Pagamento."
Local cDesc2  := STR0007		//"Ser  impresso de acordo com os parametros solicitados pelo"
Local cDesc3  := STR0008		//"usu rio."


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn		:= {STR0009, 1,STR0010, 2, 2, 1, "",1 }	//"Zebrado"###"Administra‡„o"
Private nomeprog		:= "GPER032CHI"
Private cOrdem		:= ""
Private cCategoria	:= ""
Private nLastKey		:= 0
Private nPagina		:=	0
Private aCabec 		:= {}
Private aValores		:= {}
Private Li     		:= 80   
Private Titulo 		:= STR0011		//"EMISSŽO DE RECIBOS DE PAGAMENTOS"
Private cTamanho		:= "P"
Private lImprCab		:= .F.
Private cProceso 		:= "" //Proceso
Private cTpoNomina	:= "" //Tipo Nomina
Private cPeriodo		:= "" //Periodo
Private cNoPago		:= "" //Numero pago

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=nomeprog           //Nome Default do relatorio em Disco

wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,cTamanho)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a Ordem do Relatorio                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nOrdem := aReturn[8]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cProceso 	:= mv_par01 //Proceso
cTpoNomina	:= mv_par02 //Tipo Nomina
cPeriodo	:= mv_par03 //Periodo
cNoPago	:= mv_par04 //Numero pago
cFilDe 	:= mv_par05 //Filial De
cFilAte	:= mv_par06 //Filial Ate
cCcDe		:= mv_par07 //Centro de Custo De
cCcAte		:= mv_par08 //Centro de Custo Ate
cMatDe		:= mv_par09 //Matricula Des
cMatAte	:= mv_par10 //Matricula Ate
cNomDe		:= mv_par11 //Nome De
cNomAte	:= mv_par12 //Nome Ate
ChapaDe	:= mv_par13 //Chapa De
ChapaAte	:= mv_par14 //Chapa Ate
cSituacao	:= mv_par15 //Situacoes a Imprimir
cCategoria	:= mv_par16 //Categorias a Imprimir

If LastKey() == 27 .OR. nLastKey == 27
   Return
Endif

//Valida que no este vacio el proceso
IF empty(cProceso)
	MSGALERT(STR0028, STR0027) //"El campo de Proceso esta vacio" + "Campo Vacio"
	Return
endif

//Valida que no este vacio el Roteiro
IF empty(cTpoNomina)
	MSGALERT(STR0029, STR0027) //"El campo de Tipo Nomina esta vacio" + "Campo Vacio"
	Return
endif

//Valida que no este vacio el Periodo
IF empty(cPeriodo)
	MSGALERT(STR0030, STR0027)//"El campo de Periodo esta vacio" + "Campo Vacio"
	Return
endif

//Valida que no este vacio el No. Pago
IF empty(cNoPago)
	MSGALERT(STR0031, STR0027) //"El campo de No. Pago esta vacio" +  "Campo Vacio"  
	Return
endif


aReturn[4]:=1
	
//Imprime cabecalho detalhado
If mv_par17==2 //1-Vertical|2-Horizontal
	lImprCab:=.T.                   
Endif	
SetDefault(aReturn,cString,,,"G",aReturn[4]) //define letra grande

If LastKey() == 27 .OR. nLastKey == 27
   Return
Endif


ProcGpe({|lEnd| R032Imp(@lEnd,wnRel,cString,cProceso, cTpoNomina, cPeriodo, cNoPago)},Titulo) 
Set Device To Screen
If aReturn[5] = 1
	Set Printer To
	Commit
	ourspool(wnrel)
Endif
MS_FLUSH()


Return( NIL )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R032IMP  ³ Autor ³ Bruno Sobieski              ³ Data ³ 22.02.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processamento Para emissao do Libro de Remuneraciones            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ R032Imp(lEnd,WnRel,cString,cProceso,cTpoNomina,cPeriodo,cNoPago) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R032Imp(lEnd,WnRel,cString,cProceso, cTpoNomina, cPeriodo, cNoPago)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aOrdBag     := {}
Local cArqMov     := ""
Local cVerba      := ""
Local cAcessaSRA  := &("{ || " + ChkRH("GPER032","SRA","2") + "}")
Local cAcessaSRC  := &("{ || " + ChkRH("GPER032","SRC","2") + "}")
Local aInfo
Local aTotais     := {}
Local nX:=0, nY:=0, nQtdDias:=0

If  SRV->(ColumnPos("RV_IMPLBRE")) * SRV->(ColumnPos("RV_POSLBRE")) == 0
	Return .F.
Endif

Private cAliasMov := ""
Private Desc_Fil  := "" 
Private Desc_End  := "" 
Private Desc_CGC  := ""
Private nColMax   := 0
Private nRenMax   := 0


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Selecionando a Ordem de impressao escolhida no parametro.    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( "SRA")

If nOrdem == 1
	dbSetOrder(1)
ElseIf nOrdem == 2
	dbSetOrder(2)
ElseIf nOrdem == 3
	dbSetOrder(3)
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Selecionando o Primeiro Registro e montando Filtro.          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOrdem == 1
	cInicio := "SRA->RA_FILIAL + SRA->RA_MAT"
	cOrdem	:= STR0001 //"Matricula"
	MsSeek(cFilDe + cMatDe,.T.)
	cFim    := cFilAte + cMatAte
ElseIf nOrdem == 2
	MsSeek(cFilDe + cCcDe + cMatDe,.T.)
	cOrdem	 := STR0002 //"C Costo"
	cInicio  := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
	cFim     := cFilAte + cCcAte + cMatAte
ElseIf nOrdem == 3
	MsSeek(cFilDe + cNomDe + cMatDe,.T.)
	cOrdem	:= STR0003 //"Nomb"
	cInicio := "SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT"
	cFim    := cFilAte + cNomAte + cMatAte
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica o tamanho maximo de coluna                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 nColMax:=8

	nRenMax:=0
	DbselectArea("SX5")
	SX5->(DbSetOrder(1))
	SX5->(DbGoTop())
	If MsSeek(xFilial("SX5")+"O0")
		While SX5->X5_FILIAL+SX5->X5_TABELA==xFilial("SX5")+"O0" .And. !SX5->(EOF())
		   If Val(Substr(SX5->X5_CHAVE,3,2)) > nColMax
		      nColMax:=Val(Substr(SX5->X5_CHAVE,3,2))
		   Endif                                        
		   If Val(Substr(SX5->X5_CHAVE,1,2)) > nRenMax
		      nRenMax:=Val(Substr(SX5->X5_CHAVE,1,2))
		   Endif                                       
		   
		   SX5->(DbSkip())
		Enddo                        
	Endif      
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verba que ira trazer a quantidade de dias                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SRV")
	SRV->(DbSetOrder(2))
	SRV->(DbGoTop())
	If MsSeek(xFilial("SRV")+"0031")//031-indentificador de calculo
		cVerba:=SRV->RV_COD//Codigo da Verba	
	Endif               
	SRV->(DbSetOrder(1))



If nColMax>8
	@ 0,0 PSAY AvalImp(220)
Else
	SendPrtInfo("G",15)
Endif

aTotais:=Array(nRenMax,nColmax)
for nx:=1 to nRenMax
	aFill(aTotais[nx],0)
next	

dDtPesqAf :=  CTOD("01/" + SubStr(cPeriodo,5,6) + "/" + SubStr(cPeriodo,0,4),"DDMMYY")

dbSelectArea("SRA")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega Regua Processamento                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
GPProcRegua(RecCount())// Total de elementos da regua

cFilialAnt := Space(FWGETTAMFILIAL)

While SRA->( !Eof() .And. &cInicio <= cFim )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta Regua Processamento                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	GPIncProc(SRA->RA_FILIAL+" - "+SRA->RA_MAT+" - "+SRA->RA_NOME)

	If lEnd
      @Prow()+1,0 PSAY STR0033 //"Cancelado por el operador"
		Exit
	Endif	 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste Parametrizacao do Intervalo de Impressao            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (SRA->RA_CHAPA < ChapaDe) .Or. (SRA->Ra_CHAPa > ChapaAte) .Or. ;
		(SRA->RA_NOME < cNomDe)    .Or. (SRA->Ra_NOME > cNomAte)    .Or. ;
		(SRA->RA_MAT < cMatDe)     .Or. (SRA->Ra_MAT > cMatAte)     .Or. ;
		(SRA->RA_CC < cCcDe)       .Or. (SRA->Ra_CC > cCcAte)
		SRA->(dbSkip(1))
		Loop
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica Data Demissao         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSitFunc := SRA->RA_SITFOLH
	//dDtPesqAf :=  CTOD("01/" + SubStr(cPeriodo,5,6) + "/" + SubStr(cPeriodo,0,4),"DDMMYY")
	If cSitFunc == "D" .And. (!Empty(SRA->RA_DEMISSA) .And. MesAno(SRA->RA_DEMISSA) > MesAno(dDtPesqAf))
		cSitFunc := " "
	Endif	


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste situacao e categoria dos funcionarios			     |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !( cSitFunc $ cSituacao ) .OR.  ! ( SRA->RA_CATFUNC $ cCategoria )
		dbSkip()
		Loop
	Endif
	
	If cSitFunc $ "D" .And. Mesano(SRA->RA_DEMISSA) # Mesano(dDtPesqAf)
		dbSkip()
		Loop
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste controle de acessos e filiais validas				 |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
  	   dbSkip()
      Loop
  	EndIf
    
	If SRA->RA_Filial # cFilialAnt
		If ! fInfo(@aInfo,Sra->Ra_Filial)
			Exit
		Endif
		Desc_Fil := aInfo[3]
		Desc_End := Alltrim(aInfo[4]) + space(2) + Alltrim(aInfo[14]) + space(2) + aInfo[13]                // Dados da Filial
		Desc_CGC := Transform( aInfo[8] , "@R 99.999.999-9")
		dbSelectArea("SRA")
		cFilialAnt := SRA->RA_FILIAL
	Endif
	nQtdDias:=0	
	dbSelectArea("SRC")
	SRC->(dbSetOrder(6)) //Filial + Mat + Cod. Proceso + Procedimiento + Cod. Periodo + No. Semana
	IF SRC-> (MsSeek(SRA->RA_FILIAL + SRA->RA_MAT + cProceso + cTpoNomina + cPeriodo + cNoPago ))
		aValores	:=	Array(nRenMax,nColMax) //Iif(lImprCab,Array(4,nColMax),Array(4,8))
		For nx:=1 to nRenMax
			aFill(aValores[nx],0)
		Next
		
		While SRC->(!Eof()) .And. SRC->RC_FILIAL+SRC->RC_MAT+SRC->RC_PROCES+SRC->RC_ROTEIR+SRC->RC_PERIODO+SRC->RC_SEMANA == SRA->RA_FILIAL+SRA->RA_MAT+cProceso+cTpoNomina+cPeriodo+cNoPago
		  	If !Eval(cAcessaSRC)
		      SRC->(dbSkip())
		      Loop
		    EndIf
		
		    IF SRV->(MsSeek(xFilial("SRV")+SRC->RC_PD))
		    
				    SX5->(DbSetOrder(1))
					If SX5->(MsSeek(xFilial("SX5")+"O0"+PADR(SRV->RV_POSLBRE,6," ")) )//Si no esta en sx5 no la pone
						If !Empty(SRV->RV_POSLBRE) .And. Val(Substr(SRV->RV_POSLBRE,3,2)) <= Len(aValores[1])
							If SRV->RV_IMPLBRE == "1"
								IF SRV->RV_TIPOCOD $ "1/3"
									aValores[Val(Substr(SRV->RV_POSLBRE,1,2))][Val(Substr(SRV->RV_POSLBRE,3,2))]	+=	SRC->RC_VALOR
			                  	aTotais[Val(Substr(SRV->RV_POSLBRE,1,2))][Val(Substr(SRV->RV_POSLBRE,3,2))]  += SRC->RC_VALOR
			                  ELSE //"2/4"
									aValores[Val(Substr(SRV->RV_POSLBRE,1,2))][Val(Substr(SRV->RV_POSLBRE,3,2))]	-=	SRC->RC_VALOR
			                  	aTotais[Val(Substr(SRV->RV_POSLBRE,1,2))][Val(Substr(SRV->RV_POSLBRE,3,2))]  -= SRC->RC_VALOR
			                  ENDIF
							Else
								IF SRV->RV_TIPOCOD $ "1/3"				
									aValores[Val(Substr(SRV->RV_POSLBRE,1,2))][Val(Substr(SRV->RV_POSLBRE,3,2))]	+=	SRC->RC_HORAS
			                 		aTotais[Val(Substr(SRV->RV_POSLBRE,1,2))][Val(Substr(SRV->RV_POSLBRE,3,2))] := -1
			                 	ELSE // "2/4"
			                 		aValores[Val(Substr(SRV->RV_POSLBRE,1,2))][Val(Substr(SRV->RV_POSLBRE,3,2))]	-=	SRC->RC_HORAS
			                 		aTotais[Val(Substr(SRV->RV_POSLBRE,1,2))][Val(Substr(SRV->RV_POSLBRE,3,2))] := -1
			                 	ENDIF
			                 	
							Endif
							If !Empty(cVerba).And.cVerba==SRC->RC_PD     
						  	    nQtdDias+=SRC->RC_HORAS
						  	Endif	
						Endif
				ENDIF	
			ENDIF

			dbSelectArea("SRC")
			SRC->(dbSkip())
		Enddo
		If Li > 60
				li	:=	0
				fCabec(.F.,dDtPesqAf)
		Endif	     
				            
			For nX:=	1	To	LEN(aValores) //Len(aValores)
				If nX==1
					@Li,00 PSAY SRA->RA_MAT+'-'+alltrim(SRA->RA_NOME)+"  "+SRA->RA_RG
					li++
				ElseIf	nX== 2
					@Li,00 PSAY Substr(FDESC('SRJ',SRA->RA_CODFUNC,'RJ_DESC',TamSX3('RJ_DESC'),SRA->RA_FILIAL),1,22)
				ElseIf nX==3        
					@Li,00 PSAY Alltrim(Str(nQtdDias))+"|"+SRA->RA_CIC
				Endif						

				For nY	:=	1	To Len(aValores[1])
						@Li, (nY*14)+14 PSAY ABS(aValores[nX][nY]) Picture TM(aValores[nX][nY],13,MsDecimais(1))
				Next

				Li++
			Next  
		          
		@ Li,00 PSAY __PrtThinLine()
		Li++			
	Endif
	dbSelectArea("SRA")
	SRA->( dbSkip() )
EndDo
Li:=0
fCabec(.T.,dDtPesqAf)

If lImprCab //Total Horizonal
	@ Li,001 PSAY STR0015//TOTALES
	For nX:=	1	To	nRenMax
		For nY	:=	1	To nColMax
					@Li, (nY*14)+14 PSAY abs( aTotais[nX][nY]) ;
		                       PICTURE TM(aTotais[nX][nY],13,MsDecimais(1))                     
		Next
		Li++
	Next  			
Else //Total Vertical
	SX5->(MsSeek(xFilial("SX5")+"O0"))
	While SX5->X5_FILIAL+SX5->X5_TABELA==xFilial("SX5")+"O0" .And. !SX5->(EOF())
			cTmpCod:=Substr(SX5->X5_CHAVE,1,2)
			While SX5->X5_FILIAL+SX5->X5_TABELA==xFilial("SX5")+"O0" .And. !SX5->(EOF()) .and. cTmpCod==Substr(SX5->X5_CHAVE,1,2) 

		   					Li++ 
					      @Li,10   PSAY  Substr(X5Descri(),1,20)
					      @Li,35   PSAY  abs(aTotais[Val(Substr(SX5->X5_CHAVE,1,2))][Val(Substr(SX5->X5_CHAVE,3,2))]) ;
					                        PICTURE TM(aTotais[Val(Substr(SX5->X5_CHAVE,1,2))][Val(Substr(SX5->X5_CHAVE,3,2))],18,MsDecimais(1))
				   
				SX5->(DbSkip())
			enddo
			Li++
	Enddo
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona arq. defaut do Siga caso Imp. Mov. Anteriores      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty( cAliasMov )
	fFimArqMov( cAliasMov , aOrdBag , cArqMov )
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SRC")
dbSetOrder(1)          // Retorno a ordem 1


dbSelectArea("SRA")
DbClearFilter()
RetIndex("SRA")

	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fCabec    ³ Autor ³ Bruno Sobieski        ³ Data ³ 22.02.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMRESSAO Cabe‡alho                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fCabec()                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fCabec(lTotal,dDtPesqAf)   // Cabecalho
Local aCabecTmp:=	Array(nRenMax,nColMax)//IIF(lImprcab,Array(4,nColMax),Array(4,8))    
Local nX,nY 
Local nPosCol:=0
nPagina++    

If nColMax>8 //lImprCab
   nPosCol:=180
else
	nPosCol:=100
endif   

//                       Imprime Titulos

@ LI,001 PSAY STR0012+StrZero(nPagina,6)//"Pagina : "
@ LI,nPosCol PSAY STR0016+UsrRetname(__cUserId)//"Emitido por: "
LI++ 
@ LI,001 PSAY DESC_Fil      //Nombre empresa
@ Li,100 PSAY STR0004 //"LIBRO DE REMUNERAC."
@ LI,nPosCol PSAY STR0013+MesExtenso(MONTH(dDatabase))+"/"+STR(YEAR(dDatabase),4)	//"Fecha  : "
LI++
@ LI,001 PSAY Desc_End //Direccion
@ Li,100 PSAY Replicate('=',Len(STR0004))
@ LI,nPosCol PSAY STR0017+Time()//"Hora   :"
LI++
@ Li,080 PSAY STR0018+MesExtenso(SubStr(cPeriodo,5,6))+STR0032+ SubStr(cPeriodo,0,4) //"Periodo: remuneracao do Mes "" del "
Li++	
@ Li,080 PSAY STR0019+cOrdem //"Agrupados por: "
Li++	
@ Li,080 PSAY STR0020+cCategoria//"Selecao: "
Li += 2
if !lImprCab  
	If lTotal
		@ Li,001 PSAY STR0014//"TOTALES LIBRO DE REMUNERACIONES"
		Li++
	Endif
	Li += 2
Endif

//                       Imprime titulos de las columnas

@ Li,00 PSAY __PrtFatLine()
Li++
If !lTotal .Or. lImprCab
	If Len(aCabec) == 0
		aCabec	:=	array(nRenMax)
		for nx:=1 to nRenMax
			aFill(aCabecTmp[nx],"")
			aCabec[nx]:=""
		next	
		
		SX5->(MsSeek(xFilial("SX5")+"O0"))
		While SX5->X5_Filial+SX5->X5_TABELA	 == xFilial('SX5') + 'O0'
			If Val(Substr(SX5->X5_CHAVE,3,2))<=LEN(aCabecTmp[1])
				aCabecTmp[Val(Substr(SX5->X5_CHAVE,1,2))][Val(Substr(SX5->X5_CHAVE,3,2))]	:=	Substr(X5Descri(),1,13)
			Endif
			SX5->(DbSkip())
		Enddo
		For nX:=1	To	Len(aCabecTmp)
			For nY:=1	To	Len(aCabecTmp[nX])		
				If Empty(aCabecTmp[nX][nY])
					aCabecTmp[nX][nY]:=Space(13)
				Endif
				aCabec[nX]	+=	aCabecTmp[nX][nY]+" "
			Next
		Next		
	Endif	                                       

	@ Li,01 PSAY STR0021 //"Nomb. del trabajador"
	if nRenMax>0
		@ Li,28 PSAY aCabec[1]
	endif	
	Li++       
	if nRenMax>1
		@ Li,28 PSAY aCabec[2]
	endif
	Li++
	@ Li,01 PSAY STR0022//Cargo
	if nRenMax>2
		@ Li,28 PSAY aCabec[3]
	endif
	Li++
	@ Li,01 PSAY STR0023//Dias
	@ Li,07 PSAY STR0024//Trab.Rut
	if nRenMax>3
		@ Li,28 PSAY aCabec[4]
	endif			
	Li++     
	@ Li,00 PSAY __PrtFatLine()
	Li++
Endif
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³TablaMov³ Autor ³                         ³ Data ³ 28.01.20 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Busca os movimentos para a geração do relatorio            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_TablaMov()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TablaMov()

Local lRet := .T.
Local nx := 0
Local cAcessaMov  := ""
Local cAliasAux   := ""
Local cPrefixo    := ""
Local nOrdem	  := 0

Private aPerAberto	:= {}
Private aPerFechado	:= {}


RetPerAbertFech(cProceso,cTpoNomina,cPeriodo,cNoPago,,,@aPerAberto,@aPerFechado)

If Empty(aPerAberto) .And. Empty(aPerFechado)
   MsgAlert(STR0034,STR0035)	//"Nao foi encontrado nenhum periodo" ### "Verifique Parâmetros de Impressão."
   Return .F.
Endif          

If (nPos:=aScan(aPerAberto, {|x| x[1] == cPeriodo .And. x[2] == cNoPago})) > 0 
	cAliasAux   := "SRC"
	cPrefixo    := "RC_"	
	nOrdem		:= 6
	cAcessaMov  := &("{ || " + ChkRH("GPER032","SRC","2") + "}")
Elseif (nPos:=aScan(aPerFechado, {|x| x[1] == cPeriodo .And. x[2] == cNoPago})) > 0 
	cAliasAux   := "SRD"
	cPrefixo    := "RD_"	
	nOrdem		:= 5
	cAcessaMov  := &("{ || " + ChkRH("GPER032","SRD","2") + "}")
Endif 

dbSelectArea(cAliasAux)
(cAliasAux)->(dbSetOrder(nOrdem)) //Filial + Mat + Cod. Proceso + Procedimiento + Cod. Periodo + No. Semana
IF (cAliasAux)-> (MsSeek(SRA->RA_FILIAL + SRA->RA_MAT + cProceso + cTpoNomina + cPeriodo + cNoPago ))
	aValores	:=	Array(nRenMax,nColMax) 
	For nx:=1 to nRenMax
		aFill(aValores[nx],0)
	Next
	
	While (cAliasAux)->(!Eof()) .And. (cAliasAux)->&((cPrefixo)+"FILIAL")+(cAliasAux)->&((cPrefixo)+"MAT")+(cAliasAux)->&((cPrefixo)+"PROCES")+(cAliasAux)->&((cPrefixo)+"ROTEIR")+(cAliasAux)->&((cPrefixo)+"PERIODO")+(cAliasAux)->&((cPrefixo)+"SEMANA") == SRA->RA_FILIAL+SRA->RA_MAT+cProceso+cTpoNomina+cPeriodo+cNoPago
		If !Eval(cAcessaMov)
			(cAliasAux)->(dbSkip())
			Loop
		EndIf
	
		IF SRV->(MsSeek(xFilial("SRV")+(cAliasAux)->&((cPrefixo)+"PD")))
		
				SX5->(DbSetOrder(1))
				If SX5->(MsSeek(xFilial("SX5")+"O0"+PADR(SRV->RV_POSLBRE,6," ")) )//Si no esta en sx5 no la pone
					If !Empty(SRV->RV_POSLBRE) .And. Val(Substr(SRV->RV_POSLBRE,3,2)) <= Len(aValores[1])
						If SRV->RV_IMPLBRE == "1"
							IF SRV->RV_TIPOCOD $ "1/3"
								aValores[Val(Substr(SRV->RV_POSLBRE,1,2))][Val(Substr(SRV->RV_POSLBRE,3,2))]	+=	(cAliasAux)->&((cPrefixo)+"VALOR")
							aTotais[Val(Substr(SRV->RV_POSLBRE,1,2))][Val(Substr(SRV->RV_POSLBRE,3,2))]  += (cAliasAux)->&((cPrefixo)+"VALOR")
							ELSE //"2/4"
								aValores[Val(Substr(SRV->RV_POSLBRE,1,2))][Val(Substr(SRV->RV_POSLBRE,3,2))]	-=	(cAliasAux)->&((cPrefixo)+"VALOR")
							aTotais[Val(Substr(SRV->RV_POSLBRE,1,2))][Val(Substr(SRV->RV_POSLBRE,3,2))]  -= (cAliasAux)->&((cPrefixo)+"VALOR")
							ENDIF
						Else
							IF SRV->RV_TIPOCOD $ "1/3"				
								aValores[Val(Substr(SRV->RV_POSLBRE,1,2))][Val(Substr(SRV->RV_POSLBRE,3,2))]	+=	(cAliasAux)->&((cPrefixo)+"HORAS")
								aTotais[Val(Substr(SRV->RV_POSLBRE,1,2))][Val(Substr(SRV->RV_POSLBRE,3,2))] := -1
							ELSE // "2/4"
								aValores[Val(Substr(SRV->RV_POSLBRE,1,2))][Val(Substr(SRV->RV_POSLBRE,3,2))]	-=	(cAliasAux)->&((cPrefixo)+"HORAS")
								aTotais[Val(Substr(SRV->RV_POSLBRE,1,2))][Val(Substr(SRV->RV_POSLBRE,3,2))] := -1
							ENDIF
				
						Endif
						If !Empty(cVerba).And.cVerba==(cAliasAux)->&((cPrefixo)+"PD")     
							nQtdDias+=(cAliasAux)->&((cPrefixo)+"HORAS")
						Endif	
					Endif
			ENDIF	
		ENDIF

		dbSelectArea(cAliasAux)
		(cAliasAux)->(dbSkip())
	Enddo    
	lRet := .T.			       		
Else
	lRet := .F.	
EndIf	
Return lRet