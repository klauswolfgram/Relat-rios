/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "matrar2b.ch"        
#INCLUDE "PROTHEUS.CH"   

//-------------------------------------------------------------------------//
//Variables declaradas para el tratamiento del automatizado				   //
//-------------------------------------------------------------------------//


Static cPictAlq:= PesqPict("SF3","F3_ALQIMP1")
Static cPictDt := PesqPict("SF3","F3_ENTRADA",FWSX3Util():GetFieldStruct( "F3_ENTRADA")[3]+2)

Static nTam	:= 	  FWSX3Util():GetFieldStruct( "F3_VALCONT")[3]+4
Static nTamNF:=	  FWSX3Util():GetFieldStruct("F3_NFISCAL")[3]+2 
Static nTamTP  := FWSX3Util():GetFieldStruct("F2_TIPO")[3]
Static cPictTP := PesqPict("SF2","F2_TIPO",nTamTP)

Static cPictVr := PesqPict("SF3","F3_VALCONT",nTam	)
Static cPictNF	:= PesqPict("SF3","F3_NFISCAL",nTamNF )

Static nTotOtros:=0 
Static cAliasA := ""
Static nColTot:=1, nColGra:=2, nColExen:=3, nColIVA:=4, nColIVAP:=5, nColIBP:=6, nColOtros:=7, nColExcl:=8 ,nColAliq:=9  //Colunas de Posições das Totalizações
Static aTotales:={}//Array para totalização dos tipos de Fornecedores (Resp.Insc./Resp.No Inscr./Exentos/No Responsables/Monotributista)
Static aSTotales := {   0.00,   0.00,      0.00,    0.00,     0.00,    0.00,      0.00,     0.00}
Static aTVariosIVA :={}//Totalização Fornecedores Extrangeiros para Totales Generales del IVA
Static cCveActPro 		:= SuperGetMv("MV_RG3711",,"")
Static aNoGrav := {{0,0,0,0,0},{0,0,0,0,0}}
Static aSelFil := { FWGETCODFILIAL }
Static aNFs := {}
Static aSucEmp := {}
Static aEstrSF3 := SF3->(DBSTRUCT())
Static aConfSFB:= {}

/*/                                                                                                       
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ                       
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±                            
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MATRAR2B  ³ Autor ³ Wagner Montenegro   ³ Data ³ 05.02.2010 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±                   
±±³Descricao ³Livro Fiscal de Vendas  c/ Resumo DDJJ-IVA                  ³±±         
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³Argentina                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³22/10/2013³ ANTONIO TREJO ³ THIMZY: Agreger el campo A2_AFIP (Tipo Doc)³±±
±±³          ³               ³ y se modifico la etiq "EFECTIVO" por "EFE".³±±
±±³19/12/2016³Jonathan Glz   ³Se elimina ajuste a SX, por motivo de       ³±±
±±³          ³SERINN001-510  ³limpieza de CTREE y SX.                     ³±±
±±³15/03/2017³ Dora Vega     ³MMI-132:Merge de Replica del llamado TVUKDJ.³±±
±±³          ³               ³MMI-152:Merge de Replica del llamado TVVXFI.³±±
±±³          ³               ³MMI-224:Merge de Replica del llamado TWKQFI.³±±
±±³          ³               ³Se Muestra descuento aplicado en la columna ³±±
±±³          ³               ³otros. Se puede generar reporte a partir de ³±±
±±³          ³               ³varias sucursales al ser seleccionadas.(ARG)³±±
±±³21/03/2017³ Dora Vega     ³MMI-4545:Merge de Replica del issue MMI-4465³±±
±±³          ³               ³MMI-4565:Merge de Replica del issue MMI-4529³±±
±±³          ³               ³Modificar el calculo de IVA Percep cuando el³±±
±±³          ³               ³doc. es NF debe ser positivo, cuando el doc.³±±
±±³          ³               ³es NCC debe ser negativo.(ARG)              ³±±
±±³24/03/2017³ Dora Vega     ³MMI-4778:Merge de replica del issue MMI-4627³±±
±±³          ³               ³Se elimina encabezado de sucursales.Se agre-³±±
±±³          ³               ³ga hoja de parametros sobre los filtros(ARG)³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MatrAr2B()
Local I:=0
Local   lError  :=.T.
Local   nLoop := 0
Local   nOpcA := 0
Local   aSays := {}
Local   aButtons := {}
Local 	 cMVPAR05	:= ""

Private cPerg   := ""
Private cQuebraTipo:=""

// Variaveis de armazenamento dinamico dos campos para uso nas celulas do objeto
Private cF3VrIB  :=""
Private cF3AlqIVA:=""
Private cF3BaseIVA:=""
Private cF3VrIVA :=""
Private cF3VrIVAP:=""
Private cF3VrEXCL:=""

// Variaveis de armazenamento dinamico dos cmapos para uso na query
Private cSF3VrIB  :=""
Private cSF3AlqIVA:=""
Private cSF3BaseIVA:=""
Private cSF3VrIVA :=""
Private cSF3VrIVAP:=""
Private cSF3VrEXCL:=""

// Variaves de armazenamento dinamico do Alias da Query com os campos para uso na funçoes de totalização
Private cTF3VrIB  :=""
Private cTF3AlqIVA:=""
Private cTF3BaseIVA:=""
Private cTF3VrIVA :=""
Private cTF3VrIVAP:=""
Private cTF3VrEXCL:=""

Private nContab:=0 
Private nTotEXEN:=0 
Private cA2COD:=""
Private cA2NOME:=""
Private cA2CGC:=""
Private cA2TIPO:=""
Private aTipo:={}
Private aTMP:={}  

Private nLinRI:=1, nLinRNI:=2, nLinE:=3, nLinNR:=4, nLinCF:=5, nLinRM:=6 //Linhas de aTotales
Private aSTipos  :={   0.00,   0.00,      0.00,    0.00,     0.00,    0.00,      0.00,     0.00}
Private aResumoIVA:={} //Totalizador do RESUMO DDJJ-IVA
Private aColIVA :={} //Armazena o nro das colunas IVA no SF3 conforme cadastro no SFB
Private aColIVAP:={} //Armazena o nro das colunas IVAp no SF3 conforme cadastro no SFB
Private aColIB  :={} //Armazena o nro das colunas IB no SF3 conforme cadastro no SFB
Private aColEXCL:={} //Armazena o nro das colunas Impostos INTERNOS no SF3 conforme cadastro no SFB
Private aImpostos:={} //Totalização para Outros Impostos diferentes de IVA IVAP IB
Private aTLocalIVA  :={} //Totalização Fornecedores Interno para Totales Generales del IVA
Private cExpCampos:="" //Composição dinamica dos Campos necessários para Query
Private cExpC1:=""
Private cExpC2:=""
Private cExpC3:=""
Private cExpC4:=""
Private cExpC5:=""
Private cColIVA :=""
Private cColIVAP:=""
Private cColIB  :=""
Private cColEXCL:=""
Private aResumoPro := {}
Private cCuitEmp := ""
Private aCposTmp1 := {}
Private aComp	:= {}

	If !Empty(cCveActPro) .and. cPaisLoc == "ARG"
		cPerg := "MTRAR2B2"
	Else
		cPerg := "MTRAR2B"
	EndIf

	Pergunte(cPerg,.F.) 
	aAdd(aSays,OemToAnsi( STR0001) ) 
	aAdd(aButtons, { 5,.T.,{ || Pergunte(cPerg,.T. ) } } )
	aAdd(aButtons, { 1,.T.,{ |o| nOpcA := 1, o:oWnd:End() }} )
	aAdd(aButtons, { 2,.T.,{ |o| nOpcA := 2, o:oWnd:End() }} )             
	FormBatch( oemtoansi(STR0001), aSays , aButtons )    
	                                        
	If nOpcA == 2
		Return
	EndIf

	cMVPAR05 := MV_PAR05
	If MV_PAR05 == 2
		aSelFil := AdmGetFil()
	Else
		aSelFil := { FWGETCODFILIAL }
	EndIf
	
   //Montagem do array aTotales com (Identificador e Descrição) dos tipos existentes de Clientes conforme SX3
	VldCuitEmp()
	IniTotales()
   If Len(aTotales)=0
      Alert(STR0043)
      Return
	EndIf  
      If SFB->(FieldPos("FB_TIPO")) == 0 .and. SFB->(FieldPos("FB_CLASSE")) == 0 .and. SFB->(FieldPos("FB_CLASSIF")) == 0
         *///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*
         //Busca posicionamento dos Impostos no SFB  FB_CLASSIF(1=IB 3=IVA Classe) FB_CLASSIF("I"=Imposto  "P"=Percepcion) FB_CLASSE("R"=Retencion)
         //Alimenta os Arrays de Posicionamento das Colunas em SF3 
         lError:=.F.
         Alert(STR0048)
         Return
      Endif
      oReport := Nil      
      IF lError
			For nLoop := 1 To Len(aSucEmp)
				CreaTemp(aCposTmp1, @cAliasA)
				oReport := ReportDef(nLoop)
				oReport:PrintDialog()
				oReport := Nil
				InitReport()
			Next
      ENDIF
      MV_PAR05 := cMVPAR05
Return

User Function Automato(oReport,oSection,oTotal1,oTotal2,oTotal3,oTotal4,oTotal5,oTotal6,oTotal7,oTotal8,oSectionP)
	Local cReport := "MATRAR2B"
	Local cTitulo	:= STR0001 //"Emissao do Livro Fiscal de Vendas"
	Local cDesc		:= STR0004 //"El objetivo de este programa es imprimir el Libro Fiscal de Vendas."
	Local cDesc2    := STR0005 //"Libros Fiscales "
	Local nLoop := 1
	Private cExpCampos:="" //Composição dinamica dos Campos necessários para Query
	Private cExpC1:=""
	Private cExpC2:=""
	Private cExpC3:=""
	Private cExpC4:=""
	Private cExpC5:=""
	Private ObtImpSFB
	Private aImpostos := {}
	Private aCposTmp1 := {}
	Private aSTipos  :={   0.00,   0.00,      0.00,    0.00,     0.00,    0.00,      0.00,     0.00}
	Private aResumoIVA:={} //Totalizador do RESUMO DDJJ-IVA
	Private aTotales :={}
	Private aSelFil := {}
	Private cColIB:=""
	Private cColIVA :=""
	Private cColIVAP:=""
	Private cColEXCL:=""
	Private nContab:= 0
	Private aColIVA :={} //Armazena o nro das colunas IVA no SF3 conforme cadastro no SFB
	Private aColIVAP:={} //Armazena o nro das colunas IVAp no SF3 conforme cadastro no SFB
	Private aColIB  :={} //Armazena o nro das colunas IB no SF3 conforme cadastro no SFB
	Private aColEXCL:={} //Armazena o nro das colunas Impostos INTERNOS no SF3 conforme cadastro no SFB
	Private aTLocalIVA  :={}

	VldCuitEmp()
	IniTotales()
	
	CreaTemp(aCposTmp1, @cAliasA)
	PrintReport(oReport,cAliasA,oSection,oTotal1,oTotal2,oTotal3,oTotal4,oTotal5,oTotal6,oTotal7,oTotal8,oSectionP, nLoop)

Return

Static Function ReportDef(nLoop)
Local oReport
Local oSection
Local oSectionP
Local oTotal1
Local oTotal2
Local oTotal3
Local oTotal4
Local oTotal5
Local oTotal6
Local oTotal7
Local oTotal8
Local cReport := "MATRAR2B"
Local cTitulo	:= STR0001 //"Emissao do Livro Fiscal de Vendas"
Local cDesc		:= STR0004 //"El objetivo de este programa es imprimir el Libro Fiscal de Vendas."
Local cDesc2    := STR0005 //"Libros Fiscales "
Local nTaAlqImp1:= FWSX3Util():GetFieldStruct("F3_ALQIMP1")[3]  
Local nTamB1Cod:=  FWSX3Util():GetFieldStruct("B1_COD")[3]  
Local nTamA1Cod:=  FWSX3Util():GetFieldStruct("A1_COD")[3]+1
Local nTamA1CGC:=  FWSX3Util():GetFieldStruct("A1_CGC")[3]+3
Local nTamF3   :=  IIF(AllTrim(STR(nTam)) $ "18",nTam+3,nTam+1)


*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*
//Tratamento dos objetos TREPORT
oReport  := TReport():New(cReport,cTitulo,"",{|oReport| Iif(!isblind(),PrintReport(oReport,cAliasA,oSection,oTotal1,oTotal2,oTotal3,oTotal4,oTotal5,oTotal6,oTotal7,oTotal8,oSectionP, nLoop),U_Automato(oReport,oSection,oTotal1,oTotal2,oTotal3,oTotal4,oTotal5,oTotal6,oTotal7,oTotal8,oSectionP))},cDesc)
		
oReport:uParam:= cPerg
oReport:lParamReadOnly := .T.
oReport:ShowParamPage()
oReport:lParamPage := .T.
oReport:SetTotalInLine(.F.)
oReport:SetLandscape(.T.)

oSection := TRSection():New(oReport,cDesc2,{cAliasA})
oSection:lReadOnly := .T.
oSection:SetTotalInLine(.F.)

	oSectionP := TRSection():New(oReport,cDesc2,)
	oSectionP:lReadOnly := .T.
	oSectionP:SetTotalInLine(.F.)

TRCell():New(oSection,"A1_COD"     ,cAliasA,"CODIGO"  ,/*Picture*/   ,IiF(AllTrim(STR(MV_PAR07)) $ "3|4",nTamB1Cod,nTamA1Cod)/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,)
TRCell():New(oSection,"A1_NOME"    ,cAliasA,STR0006   ,/*Picture*/   ,                                              13         ,/*lPixel*/,/*{|| code-block de impressao }*/,,,) //"DENOMINACION" 
TRCell():New(oSection,"A1_AFIP"    ,cAliasA,STR0049   ,/*Picture*/   ,                                              /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,) //"TD"
TRCell():New(oSection,"A1_CGC"     ,cAliasA,STR0007   ,/*Picture*/   ,                                              nTamA1CGC,/*lPixel*/,/*{|| code-block de impressao }*/,,,) //"NRO DOCUMENTO"
TRCell():New(oSection,"A1_TIPO"    ,cAliasA,STR0008   ,cPictTP       ,                                              nTamTP     ,/*lPixel*/,/*{|| code-block de impressao }*/,,,) //"IVA"
TRCell():New(oSection,"F3_ENTRADA" ,cAliasA,STR0009   ,cPictDt       ,                                              /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,) //"FECHA"
TRCell():New(oSection,"F3_ESPECIE" ,cAliasa,STR0010   ,/*Picture*/   ,                                              /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,) //"ESPECIE"
TRCell():New(oSection,"F3_SERIE"   ,cAliasA,STR0011   ,/*Picture*/   ,                                              /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,) //"SERIE"
TRCell():New(oSection,"F3_NFISCAL" ,cAliasA,STR0012   ,cPictNF       ,                                              nTamNF+2     ,/*lPixel*/,/*{|| code-block de impressao }*/,,,) //"NUMERO"
TRCell():New(oSection,"cF3AlqIVA"  ,cAliasA,STR0013   ,cPictAlq      ,                                              nTaAlqImp1 ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")   //"% IVA"
TRCell():New(oSection,"F3_VALCONT" ,cAliasA,STR0014   ,cPictVr       ,                                              nTamF3     ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")   //"    TOTAL    "
TRCell():New(oSection,"cF3BaseIVA" ,cAliasA,STR0015   ,cPictVr       ,                                              nTamF3     ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")   //"   GRAVADO   " 
TRCell():New(oSection,"nExenNoGrav",       ,STR0016   ,cPictVr       ,                                              nTamF3     ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")   //"EXEN/NO GRAV "
TRCell():New(oSection,"cF3VrIVA"   ,cAliasA,STR0017   ,cPictVr       ,                                              nTam       ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")   //"     IVA     "
TRCell():New(oSection,"cF3VrIVAP"  ,cAliasA,STR0018   ,cPictVr       ,                                              nTam       ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")   //"  IVA Percep "
TRCell():New(oSection,"cF3VrIB"    ,cAliasA,STR0019   ,cPictVr       ,                                              nTam       ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")   //" IIBB Percep "
TRCell():New(oSection,"nOTROS"     ,       ,STR0020   ,cPictVr       ,                                              nTamF3     ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")   //"    OTROS    "

TRCell():New(oSectionP,"A1_COD"     ,cAliasA,"CODIGO" ,/*Picture*/   ,IiF(AllTrim(STR(MV_PAR07)) $ "3|4",nTamB1Cod,nTamA1Cod)/*Tamanho*/ ,/*lPixel*/,/*{|| code-block de impressao }*/,,,)
TRCell():New(oSectionP,"A1_NOME"    ,cAliasA,STR0006  ,/*Picture*/                                                  ,13         ,/*lPixel*/,/*{|| code-block de impressao }*/,,,) //"DENOMINACION"
TRCell():New(oSectionP,"cF3AlqIVA"  ,cAliasA,STR0013  ,cPictAlq                                                     ,nTaAlqImp1 ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")   //"% IVA"
TRCell():New(oSectionP,"F3_VALCONT" ,cAliasA,STR0014  ,cPictVr                                                      ,nTamF3     ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")   //"    TOTAL    "
TRCell():New(oSectionP,"cF3BaseIVA" ,cAliasA,STR0015  ,cPictVr                                                      ,nTamF3     ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")   //"   GRAVADO   "
TRCell():New(oSectionP,"nExenNoGrav",       ,STR0016  ,cPictVr                                                      ,nTamF3     ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")   //"EXEN/NO GRAV "
TRCell():New(oSectionP,"cF3VrIVA"   ,cAliasA,STR0017  ,cPictVr                                                      ,nTam       ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")   //"     IVA     "
TRCell():New(oSectionP,"cF3VrIVAP"  ,cAliasA,STR0018  ,cPictVr                                                      ,nTam       ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")   //"  IVA Percep "
                                               
TRFunction():New(oSection:Cell("nExenNoGrav"),NIL,NIL,NIL,NIL,NIL,NIL,.F.,.F.)
TRFunction():New(oSection:Cell("nOtros")     ,NIL,NIL,NIL,NIL,NIL,NIL,.F.,.F.)

oTotal1:= TRFunction():New(oSection:Cell("F3_VALCONT"  ),"F3CONT" ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal2:= TRFunction():New(oSection:Cell("cF3BaseIVA"    ),"F3BIVA" ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal3:= TRFunction():New(oSection:Cell("nExenNoGrav" ),"F3Exen" ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal4:= TRFunction():New(oSection:Cell("cF3VrIVA"      ),"F3VIVA" ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal5:= TRFunction():New(oSection:Cell("cF3VrIVAP"     ),"F3VIVAP","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal6:= TRFunction():New(oSection:Cell("cF3VrIB"       ),"F3VIB"  ,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal7:= TRFunction():New(oSection:Cell("nOTROS"      ),"F3OTROS","SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

Return oReport


Static Function PrintReport(oReport,cAliasA,oSection,oTotal1,oTotal2,oTotal3,oTotal4,oTotal5,oTotal6,oTotal7,oTotal8,oSectionP, nLoop)
Local i:=0,y:=0,nP:=0
Local   nI := 0
Local nY := 0
Local cFilTot := ""
Local lAutomato:= IsBlind()

If lAutomato
	nloop := 1
EndIf

MV_PAR05 := ""
For nY := 1 to len(aSelFil)
	If  nY  == len(aSelFil)
		cFilTot += aSelFil[ny]
		MV_PAR05 += aSelFil[ny]
	Else
		cFilTot += aSelFil[ny]+","
		MV_PAR05 += aSelFil[ny] + ","
	EndIf
Next

For nI := 1 To Len(aSucEmp[nLoop][1])
ObtImpSFB(nLoop, nI)
If Empty(cColIB) .or. Empty(cColIVA) .or. Empty(cColIVAP)
	Loop
EndIf

//Para uso no objeto TReport
cF3VrIB  :="F3_VALIMP"+cColIB  
cF3AlqIVA:="F3_ALQIMP"+cColIVA 
cF3BaseIVA:="F3_BASIMP"+cColIVA 
cF3VrIVA :="F3_VALIMP"+cColIVA 
cF3VrIVAP:="F3_VALIMP"+cColIVAP
cF3VrEXCL:="F3_VALIMP"+cColEXCL
//Para uso na Query
cSF3VrIB  :="SF3.F3_VALIMP"+cColIB
cSF3AlqIVA:="SF3.F3_ALQIMP"+cColIVA
cSF3BaseIVA:="SF3.F3_BASIMP"+cColIVA
cSF3VrIVA :="SF3.F3_VALIMP"+cColIVA
cSF3VrIVAP:="SF3.F3_VALIMP"+cColIVAP
cSF3VrEXCL:="SF3.F3_VALIMP"+cColEXCL
//Para uso na funções totalizadoras
cTF3VrIB  :="(cAliasA)->F3_VALIMP"+cColIB
cTF3AlqIVA:="(cAliasA)->F3_ALQIMP"+cColIVA
cTF3BaseIVA:="(cAliasA)->F3_BASIMP"+cColIVA
cTF3VrIVA :="(cAliasA)->F3_VALIMP"+cColIVA
cTF3VrIVAP:="(cAliasA)->F3_VALIMP"+cColIVAP
cTF3VrEXCL:="(cAliasA)->F3_VALIMP"+cColEXCL

	oReport:SetTitle(STR0001+STR0002+Transform(mv_par01,"@D")+STR0003+Transform(mv_par02,"@D")+"] ")	//"Emissao do Livro Fiscal de Vendas" //"Emision del Libro Fiscal de Vendas"###" de ["###" até "
	oReport:SetPageNumber(MV_PAR08)
	
	If MV_PAR04<>2 //Tipo do relatorio = analitico
	   oBreak := TRBreak():New(oReport,oSection:Cell("F3_ESPECIE"),"",.F.)
	   oTotal1:SetBreak(oBreak)
	   oTotal2:SetBreak(oBreak)
	   oTotal3:SetBreak(oBreak)
	   oTotal4:SetBreak(oBreak)
	   oTotal5:SetBreak(oBreak)
	   oTotal6:SetBreak(oBreak)
	   oTotal7:SetBreak(oBreak)
	Endif
	
	oSection:Cell("nExenNoGrav"):SetBlock({|| sfVlrExenNG(sfAliqIVA(),(cAliasA)->F3_VALCONT,sfBaseIVA(),sfVrIVA(),sfVrIVAP(),sfVrEXCL(),sfVrIB(),(cAliasA)->F3_EXENTAS, nLoop)})
	oSection:Cell("nOtros")     :SetBlock({|| nTotOtros })  
	
	*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*
	//Montagem da Query
	If mv_par03 == 1
	   cQry  := "SELECT SA1.A1_COD,SA1.A1_NOME,SA1.A1_AFIP,SA1.A1_CGC,SA1.A1_TIPO,SF3.F3_DTCANC,SF3.F3_CLIEFOR,SF3.F3_LOJA,SF3.F3_ENTRADA,SF3.F3_ESPECIE,SF3.F3_SERIE,SF3.F3_NFISCAL,SF3.F3_CFO,"
	   If AllTrim(Upper(TCGetDB())) $ "ORACLE|POSTGRES" 	
	   	cQry+=cSF3AlqIVA+",SF3.F3_VALCONT,SF3.F3_EXENTAS,"+cSF3BaseIVA+","+cSF3VrIVA+","+cSF3VrIVAP+","+cSF3VrIB+","+cSF3VrEXCL+","+cExpCampos + ", '" + aSucEmp[nLoop][1][nI] + "' AS SUCURSAL"
	   Else
	   	cQry+=cSF3AlqIVA+",SF3.F3_VALCONT,SF3.F3_EXENTAS,"+cSF3BaseIVA+","+cSF3VrIVA+","+cSF3VrIVAP+","+cSF3VrIB+","+cSF3VrEXCL+","+cExpCampos + ", '" + aSucEmp[nLoop][1][nI] + "' AS 'SUCURSAL'"
	   EndIf
	   cQry+=" FROM "+RetSqlName("SF3")+" SF3,"+RetSqlName("SA1")+" SA1 WHERE SF3.F3_CLIEFOR=SA1.A1_COD AND SF3.F3_LOJA=SA1.A1_LOJA AND SF3.F3_FILIAL='"
	   cQry+=xFilial("SF3", aSucEmp[nLoop][1][nI])+"' AND SA1.D_E_L_E_T_=' ' AND SF3.D_E_L_E_T_=' ' AND SF3.F3_ENTRADA >='"+DTOS(MV_PAR01)+"' AND SF3.F3_ENTRADA<='"+DTOS(MV_PAR02)+"' AND SA1.A1_FILIAL='"+xFilial("SA1", aSucEmp[nLoop][1][nI])
	   cQry+="' AND SF3.F3_DTCANC =  ' ' AND SF3.F3_TIPOMOV = 'V' AND  SF3.F3_ESPECIE IN('NF','NDC','NCC','NCE','NDE','CF') "
	  ElseIf mv_par03 == 2
	   cQry  := "SELECT SA1.A1_COD,SA1.A1_NOME,SA1.A1_AFIP,SA1.A1_CGC,SA1.A1_TIPO,SF3.F3_DTCANC,SF3.F3_CLIEFOR,SF3.F3_LOJA,SF3.F3_ENTRADA,SF3.F3_ESPECIE,SF3.F3_SERIE,SF3.F3_NFISCAL,SF3.F3_CFO,"
	   If AllTrim(Upper(TCGetDB())) $ "ORACLE|POSTGRES"
	   	cQry+=cSF3AlqIVA+",SF3.F3_VALCONT,SF3.F3_EXENTAS,"+cSF3BaseIVA+","+cSF3VrIVA+","+cSF3VrIVAP+","+cSF3VrIB+","+cSF3VrEXCL+","+cExpCampos + ", '" + aSucEmp[nLoop][1][nI] + "' AS SUCURSAL"
	   Else
	   	cQry+=cSF3AlqIVA+",SF3.F3_VALCONT,SF3.F3_EXENTAS,"+cSF3BaseIVA+","+cSF3VrIVA+","+cSF3VrIVAP+","+cSF3VrIB+","+cSF3VrEXCL+","+cExpCampos + ", '" + aSucEmp[nLoop][1][nI] + "' AS 'SUCURSAL'"
	   EndIf
	   cQry+=" FROM "+RetSqlName("SF3")+" SF3,"+RetSqlName("SA1")+" SA1 WHERE SF3.F3_CLIEFOR=SA1.A1_COD AND SF3.F3_LOJA=SA1.A1_LOJA AND SF3.F3_FILIAL='"
	   cQry+=xFilial("SF3", aSucEmp[nLoop][1][nI])+"' AND SA1.D_E_L_E_T_=' '  AND SF3.D_E_L_E_T_=' ' AND SF3.F3_ENTRADA >='"+DTOS(MV_PAR01)+"' AND SF3.F3_ENTRADA<='"+DTOS(MV_PAR02)+"' AND SA1.A1_FILIAL='"+xFilial("SA1", aSucEmp[nLoop][1][nI])
	   cQry+="' AND SF3.F3_DTCANC <> ' ' AND SF3.F3_TIPOMOV = 'V' AND  SF3.F3_ESPECIE IN('NF','NDC','NCC','NCE','NDE','CF') "
	  ElseIf mv_par03 == 3
	   cQry  := "SELECT SA1.A1_COD,SA1.A1_NOME,SA1.A1_AFIP,SA1.A1_CGC,SA1.A1_TIPO,SF3.F3_DTCANC,SF3.F3_CLIEFOR,SF3.F3_LOJA,SF3.F3_ENTRADA,SF3.F3_ESPECIE,SF3.F3_SERIE,SF3.F3_NFISCAL,SF3.F3_CFO,"
	   If AllTrim(Upper(TCGetDB())) $ "ORACLE|POSTGRES"
	   	cQry+=cSF3AlqIVA+",SF3.F3_VALCONT,SF3.F3_EXENTAS,"+cSF3BaseIVA+","+cSF3VrIVA+","+cSF3VrIVAP+","+cSF3VrIB+","+cSF3VrEXCL+","+cExpCampos + ", '" + aSucEmp[nLoop][1][nI] + "' AS SUCURSAL"
	   Else
	   	cQry+=cSF3AlqIVA+",SF3.F3_VALCONT,SF3.F3_EXENTAS,"+cSF3BaseIVA+","+cSF3VrIVA+","+cSF3VrIVAP+","+cSF3VrIB+","+cSF3VrEXCL+","+cExpCampos + ", '" + aSucEmp[nLoop][1][nI] + "' AS 'SUCURSAL'"
	   EndIf
	   cQry+=" FROM "+RetSqlName("SF3")+" SF3,"+RetSqlName("SA1")+" SA1 WHERE SF3.F3_CLIEFOR=SA1.A1_COD AND SF3.F3_LOJA=SA1.A1_LOJA AND SF3.F3_FILIAL='"
	   cQry+=xFilial("SF3", aSucEmp[nLoop][1][nI])+"' AND SA1.D_E_L_E_T_=' ' AND SF3.D_E_L_E_T_=' ' AND SF3.F3_ENTRADA >='"+DTOS(MV_PAR01)+"' AND SF3.F3_ENTRADA<='"+DTOS(MV_PAR02)+"' AND SA1.A1_FILIAL='"+xFilial("SA1", aSucEmp[nLoop][1][nI])
	   cQry+="' AND SF3.F3_TIPOMOV = 'V'  AND  SF3.F3_ESPECIE IN('NF','NDC','NCC','NCE','NDE','CF') "
	Endif  
	If mv_par09==1
	   cQry+="ORDER BY F3_ESPECIE,F3_ENTRADA,F3_SERIE,F3_NFISCAL,F3_CFO"
	  else 
	   cQry+="ORDER BY F3_ESPECIE,F3_EMISSAO,F3_SERIE,F3_NFISCAL,F3_CFO"
	Endif
	
	cQry := ChangeQuery(cQry)
	SqlToTrb(cQry,aCposTmp1,cAliasA)
	dbSelectArea(cAliasA)
	(cAliasA)->(dbSetOrder(1))
	(cAliasA)->(dbGoTop())
	InitVal()
	
Next
	
	oReport:SetMeter((cAliasA)->(Reccount()))  
	
	*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*
	//Impressao
	(cAliasA)->(DbGotop())
	While !( cAliasA )->(Eof()) 
		oReport:Section(1):Init() 
		oReport:Section(1):Cell("A1_COD")    :SetValue(IIF(!Empty((cAliasA)->F3_DTCANC),"Anul",( cAliasA )->A1_COD))  
		oReport:Section(1):Cell("A1_NOME")   :SetValue(IIF(!Empty((cAliasA)->F3_DTCANC),"Anulada",sUBS(( cAliasA )->A1_NOME,1,13))) 
		If  Empty((cAliasA)->A1_AFIP)  
	    	oReport:Section(1):Cell("A1_AFIP"):SetValue("80") 
	    Else   
	    	oReport:Section(1):Cell("A1_AFIP"):SetValue(STRZERO(VAL((cAliasA)->A1_AFIP),2))
	    Endif
	    oReport:Section(1):Cell("cF3AlqIVA"     ):SetValue(sfAliqIVA())
	    oReport:Section(1):Cell("F3_ENTRADA"  ):SetValue(Transform(( cAliasA )->F3_ENTRADA,"@D"))
	    oSection:Cell("F3_VALCONT"  ):SetBlock ({||nContab})
	    oReport:Section(1):Cell("cF3BaseIVA"    ):SetValue(sfBaseIVA())
	    oReport:Section(1):Cell("IVA"         ):SetValue((cAliasA)->A1_TIPO)
	    oReport:Section(1):Cell("cF3VrIVA"      ):SetValue(sfVrIVA()  )
	    oReport:Section(1):Cell("cF3VrIVAP"     ):SetValue(sfVrIVAP() )
	    oReport:Section(1):Cell("cF3VrIB"       ):SetValue(sfVrIB())
	    If MV_PAR04=1 //Relatorio Analitico
	       oReport:Section(1):PrintLine()
	       cQuebraTipo:=( cAliasA )->F3_ESPECIE
	      Else
	       oReport:Section(1):Hide()     
	       oReport:Section(1):PrintLine()
	    Endif
		( cAliasA )->(DbSkip())
		If MV_PAR04=1 //Relatorio Analitico
	       if( cAliasA )->F3_ESPECIE <> cQuebraTipo
	          oReport:SkipLine(1)
	          oReport:PrintText( STR0025+cQuebraTipo+"]")
	       Endif
	    Endif
	EndDo      
	*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*
	//Ordena Resumo DDJJ-IVA por CFO
	aSortRes := ASORT(aResumoIVA,,, { |x, y| x[19] < y[19] })
	If AllTrim(STR(MV_PAR07)) == "4" .and. cPaisLoc == "ARG"
		aResumoPro := ASORT(aResumoPro,,, { |x, y| x[19] < y[19] })
	EndIf	

	If MV_PAR04=2 
	   oReport:Section(1):Show()
	Endif                         
	
	oReport:Section(1):Finish()    
	
	*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*
	//IMPRESSAO DE TOTALES   
	oReport:Section(1):Cell("A1_COD"      ):SetTitle(Space(Len(oSection:ACELL[1]:GETTEXT())))
	oReport:Section(1):Cell("A1_NOME"     ):SetTitle(Space(Len(oSection:ACELL[2]:GETTEXT())))
	oReport:Section(1):Cell("A1_AFIP"     ):SetTitle(Space(Len(oSection:ACELL[3]:GETTEXT())))
	oReport:Section(1):Cell("A1_CGC"      ):SetTitle(Space(Len(oSection:ACELL[3]:GETTEXT())))
	oReport:Section(1):Cell("A1_TIPO"     ):SetTitle(Space(Len(oSection:ACELL[4]:GETTEXT())))
	oReport:Section(1):Cell("F3_ENTRADA"  ):SetTitle(Space(Len(oSection:ACELL[5]:GETTEXT())))
	oReport:Section(1):Cell("F3_ESPECIE"  ):SetTitle(Space(Len(oSection:ACELL[6]:GETTEXT())))
	oReport:Section(1):Cell("F3_SERIE"    ):SetTitle(Space(Len(oSection:ACELL[7]:GETTEXT())))
	oReport:Section(1):Cell("F3_NFISCAL"  ):SetTitle(Space(Len(oSection:ACELL[8]:GETTEXT())))
	oReport:Section(1):Cell("cF3AlqIVA"   ):SetTitle(Space(Len(oSection:ACELL[9]:GETTEXT())))
	oReport:Section(1):Cell("A1_TIPO"     ):Hide()
	oReport:Section(1):Cell("F3_ENTRADA"  ):Hide()
	
	oReport:Section(1):Cell("F3_ESPECIE"  ):SetValue("T01") 
	
	oReport:Section(1):Init()     
	
	For i:= 1 to Len(aTotales) 
	    nSomaTot:=0
	    For y:=1 to 8
	        nSomaTot+=aTotales[i][y]
	    Next
	    If nSomaTot<>0 //IMPRIME SE DIFERENTE DE ZERO
	       oReport:Section(1):Cell("A1_COD"      ):SetValue(STR0026)
	       oReport:Section(1):Cell("A1_NOME"     ):SetValue(aTotales[i][10]) 
	       oReport:Section(1):Cell("F3_ESPECIE"  ):SetValue("") 
	   	   oReport:Section(1):Cell("cF3AlqIVA"   ):SetValue("") 	    
	   	   oReport:Section(1):Cell("F3_VALCONT"  ):SetValue(aTotales[i][1])
	   	   oReport:Section(1):Cell("cF3BaseIVA"  ):SetValue(aTotales[i][2])
	   	   oReport:Section(1):Cell("nExenNoGrav" ):SetValue(aTotales[i][3])
	   	   oReport:Section(1):Cell("cF3VrIVA"    ):SetValue(aTotales[i][4])
	   	   oReport:Section(1):Cell("cF3VrIVAP"   ):SetValue(aTotales[i][5])
	   	   oReport:Section(1):Cell("cF3VrIB"     ):SetValue(aTotales[i][6])
	  	   oReport:Section(1):Cell("nOTROS"      ):SetValue(aTotales[i][7])
	       oReport:Section(1):PrintLine()
	    Endif
	Next
	If MV_PAR04=2 //IMPRISSAO DOS TOTAIS DE ATOTALES CASO RELATORIO FOR SINTETICO
	   oReport:Section(1):Init()
	   oReport:ThinLine()
	   oReport:Section(1):Cell("A1_COD"      ):SetValue("")
	   oReport:Section(1):Cell("A1_NOME"     ):SetValue("") 
	   oReport:Section(1):Cell("cF3AlqIVA"   ):SetValue("") 	    
	   oReport:Section(1):Cell("F3_VALCONT"  ):SetValue(aSTotales[1])
	   oReport:Section(1):Cell("cF3BaseIVA"  ):SetValue(aSTotales[2])
	   oReport:Section(1):Cell("nExenNoGrav" ):SetValue(aSTotales[3])
	   oReport:Section(1):Cell("cF3VrIVA"    ):SetValue(aSTotales[4])
	   oReport:Section(1):Cell("cF3VrIVAP"   ):SetValue(aSTotales[5])
	   oReport:Section(1):Cell("cF3VrIB"     ):SetValue(aSTotales[6])
	   oReport:Section(1):Cell("nOTROS"      ):SetValue(aSTotales[7])
	   oReport:Section(1):PrintLine()                          
	   oReport:Section(1):Finish()
	 ELSE
	   IF MV_PAR06=2 //IMPRESSAO DE TOTAIS DE ATOTALES CASO TOTALES GENERALES NAO SEJA SELECIONADO PARA IMPRESSAO
	      oReport:Section(1):Init()
	      oReport:Section(1):Cell("cF3AlqIVA"   ):SetValue(0)
	      oReport:Section(1):Cell("F3_VALCONT"  ):SetValue(0)
	      oReport:Section(1):Cell("cF3BaseIVA"  ):SetValue(0)
	      oReport:Section(1):Cell("nExenNoGrav" ):SetValue(0)
	      oReport:Section(1):Cell("cF3VrIVA"    ):SetValue(0)
	      oReport:Section(1):Cell("cF3VrIVAP"   ):SetValue(0)
	      oReport:Section(1):Cell("cF3VrIB"     ):SetValue(0)
	      oReport:Section(1):Cell("nOTROS"      ):SetValue(0)
	      oReport:Section(1):Cell("F3_ESPECIE"  ):SetValue(Iif(Len(aSortRes)>=1,SUBSTR(aSortRes[1][19],1,2),""))       
	
	      oReport:Section(1):Cell("A1_COD"      ):Disable()
	      oReport:Section(1):Cell("A1_NOME"     ):Disable()
	      oReport:Section(1):Cell("A1_AFIP"     ):Disable()
	      oReport:Section(1):Cell("A1_CGC"      ):Disable()
	      oReport:Section(1):Cell("A1_TIPO"     ):Disable()
	      oReport:Section(1):Cell("F3_ENTRADA"  ):Disable()
	      oReport:Section(1):Cell("F3_ESPECIE"  ):Disable()
	      oReport:Section(1):Cell("F3_SERIE"    ):Disable()
	      oReport:Section(1):Cell("F3_NFISCAL"  ):Disable()
	      oReport:Section(1):Cell("cF3AlqIVA"   ):Disable()
	      oReport:Section(1):Cell("F3_VALCONT"  ):Disable()
	      oReport:Section(1):Cell("cF3BaseIVA"  ):Disable()
	      oReport:Section(1):Cell("nExenNoGrav" ):Disable()
	      oReport:Section(1):Cell("cF3VrIVA"    ):Disable()
	      oReport:Section(1):Cell("cF3VrIVAP"   ):Disable()
	      oReport:Section(1):Cell("cF3VrIB"     ):Disable()
	      oReport:Section(1):Cell("nOTROS"      ):Disable()
	      oReport:PrintText( STR0026)
	      IF AllTrim(STR(MV_PAR07)) $ "1|2|3|4"
	         oReport:Section(1):PrintLine()
	      ENDIF
	      oReport:Section(1):Cell("A1_COD"      ):Enable()
	      oReport:Section(1):Cell("A1_NOME"     ):Enable()
	      oReport:Section(1):Cell("A1_AFIP"     ):Enable()
	      oReport:Section(1):Cell("A1_CGC"      ):Enable()
	      oReport:Section(1):Cell("A1_TIPO"     ):Enable()
	      oReport:Section(1):Cell("F3_ENTRADA"  ):Enable()
	      oReport:Section(1):Cell("F3_ESPECIE"  ):Enable()
	      oReport:Section(1):Cell("F3_SERIE"    ):Enable()
	      oReport:Section(1):Cell("F3_NFISCAL"  ):Enable()
	      oReport:Section(1):Cell("cF3AlqIVA"   ):Enable()
	      oReport:Section(1):Cell("F3_VALCONT"  ):Enable()
	      oReport:Section(1):Cell("cF3BaseIVA"  ):Enable()
	      oReport:Section(1):Cell("nExenNoGrav" ):Enable()
	      oReport:Section(1):Cell("cF3VrIVA"    ):Enable()
	      oReport:Section(1):Cell("cF3VrIVAP"   ):Enable()
	      oReport:Section(1):Finish()
	    ELSE
	      oReport:Section(1):Cell("F3_ESPECIE"  ):SetValue("T02") 
	      oReport:PrintText( STR0026)
	      oReport:Section(1):Finish()    	
	   ENDIF   
	Endif
	
	*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*
	//IMPRESSAO DE TOTALES GENERALES DEL IVA
	If MV_PAR06=1 //IMPRIME TOTALES GENERALES PARA CONTROL GLOBAL DEL IVA
	   oReport:Section(1):Cell("A1_COD"      ):SetTitle(Space(Len(oSection:ACELL[1]:GETTEXT())))
	   oReport:Section(1):Cell("A1_NOME"     ):SetTitle(Space(Len(oSection:ACELL[2]:GETTEXT())))
	   oReport:Section(1):Cell("F3_ESPECIE"  ):HIDE()
	   oReport:Section(1):Cell("cF3AlqIVA"   ):SetTitle("%IVA")
	   oReport:Section(1):Init()
	   IF Len(aTLocalIVA)>0
	      For i=1 to Len(aTLocalIVA)
	          oReport:Section(1):Cell("A1_COD"      ):SetValue(STR0028)  	    
	          oReport:Section(1):Cell("A1_NOME"     ):SetValue(aTLocalIVA[i][10])  	    
	          oReport:Section(1):Cell("cF3AlqIVA"   ):SetValue(aTLocalIVA[i][9])
	          oReport:Section(1):Cell("F3_VALCONT"  ):SetValue(aTLocalIVA[i][1])
	          oReport:Section(1):Cell("cF3BaseIVA"  ):SetValue(aTLocalIVA[i][2])
	          oReport:Section(1):Cell("nExenNoGrav" ):SetValue(aTLocalIVA[i][3])
	          oReport:Section(1):Cell("cF3VrIVA"    ):SetValue(aTLocalIVA[i][4])
	          oReport:Section(1):Cell("cF3VrIVAP"   ):SetValue(aTLocalIVA[i][5])
	          oReport:Section(1):Cell("cF3VrIB"     ):SetValue(aTLocalIVA[i][6])
	          oReport:Section(1):Cell("nOTROS"      ):SetValue(aTLocalIVA[i][7])
	          IF i<>Len(aTLocalIVA)
	             oReport:Section(1):PrintLine()
	          ENDIF   
	      Next
	      IF Len(aTVariosIVA)>0
	         oReport:Section(1):PrintLine()
	       ELSE
	         oReport:Section(1):PrintLine()
	         oReport:Section(1):Cell("cF3AlqIVA"   ):SetValue(0)
	         oReport:Section(1):Cell("F3_VALCONT"  ):SetValue(0)
	         oReport:Section(1):Cell("cF3BaseIVA"  ):SetValue(0)
	         oReport:Section(1):Cell("nExenNoGrav" ):SetValue(0)
	         oReport:Section(1):Cell("cF3VrIVA"    ):SetValue(0)
	         oReport:Section(1):Cell("cF3VrIVAP"   ):SetValue(0)
	         oReport:Section(1):Cell("cF3VrIB"     ):SetValue(0)
	         oReport:Section(1):Cell("nOTROS"      ):SetValue(0)
	         oReport:Section(1):Cell("F3_ESPECIE"  ):SetValue(Iif(Len(aSortRes)>=1,SUBSTR(aSortRes[1][19],1,2),""))       
	
	         oReport:Section(1):Cell("A1_COD"      ):Disable()
	         oReport:Section(1):Cell("A1_NOME"     ):Disable()
	         oReport:Section(1):Cell("A1_AFIP"     ):Disable()
	         oReport:Section(1):Cell("A1_CGC"      ):Disable()
	         oReport:Section(1):Cell("A1_TIPO"     ):Disable()
	         oReport:Section(1):Cell("F3_ENTRADA"  ):Disable()
	         oReport:Section(1):Cell("F3_ESPECIE"  ):Disable()
	         oReport:Section(1):Cell("F3_SERIE"    ):Disable()
	         oReport:Section(1):Cell("F3_NFISCAL"  ):Disable()
	         oReport:Section(1):Cell("cF3AlqIVA"   ):Disable()
	         oReport:Section(1):Cell("F3_VALCONT"  ):Disable()
	         oReport:Section(1):Cell("cF3BaseIVA"  ):Disable()
	         oReport:Section(1):Cell("nExenNoGrav" ):Disable()
	         oReport:Section(1):Cell("cF3VrIVA"    ):Disable()
	         oReport:Section(1):Cell("cF3VrIVAP"   ):Disable()
	
	         oReport:Section(1):Cell("cF3VrIB"     ):HIDE()
	         oReport:Section(1):Cell("nOTROS"      ):HIDE()
	    	       
	         oReport:Section(1):Cell("cF3VrIB"     ):Disable()
	         oReport:Section(1):Cell("nOTROS"      ):Disable()
	  
	         oReport:PrintText( STR0024)               
	         oReport:Section(1):PrintLine()
	         oReport:Section(1):Cell("A1_COD"      ):Enable()
	         oReport:Section(1):Cell("A1_NOME"     ):Enable()
	         oReport:Section(1):Cell("A1_AFIP"     ):Enable()
	         oReport:Section(1):Cell("A1_CGC"      ):Enable()
	         oReport:Section(1):Cell("A1_TIPO"     ):Enable()
	         oReport:Section(1):Cell("F3_ENTRADA"  ):Enable()
	         oReport:Section(1):Cell("F3_ESPECIE"  ):Enable()
	         oReport:Section(1):Cell("F3_SERIE"    ):Enable()
	         oReport:Section(1):Cell("F3_NFISCAL"  ):Enable()
	         oReport:Section(1):Cell("cF3AlqIVA"   ):Enable()
	         oReport:Section(1):Cell("F3_VALCONT"  ):Enable()
	         oReport:Section(1):Cell("cF3BaseIVA"  ):Enable()
	         oReport:Section(1):Cell("nExenNoGrav" ):Enable()
	         oReport:Section(1):Cell("cF3VrIVA"    ):Enable()
	         oReport:Section(1):Cell("cF3VrIVAP"   ):Enable()

	         oReport:Section(1):Cell("cF3VrIB"     ):Enable()
	         oReport:Section(1):Cell("nOTROS"      ):Enable()

	      ENDIF
	   ENDIF    
	   IF Len(aTVariosIVA)>0
	      For i=1 to Len(aTVariosIVA)
	      	  oReport:Section(1):Cell("A1_COD"      ):SetValue(STR0028)
	          oReport:Section(1):Cell("A1_NOME"     ):SetValue(aTVariosIVA[i][10])
	          oReport:Section(1):Cell("cF3AlqIVA"   ):SetValue(aTVariosIVA[i][9])
	          oReport:Section(1):Cell("F3_VALCONT"  ):SetValue(aTVariosIVA[i][1])
	          oReport:Section(1):Cell("cF3BaseIVA"  ):SetValue(aTVariosIVA[i][2])
	          oReport:Section(1):Cell("nExenNoGrav" ):SetValue(aTVariosIVA[i][3])
	          oReport:Section(1):Cell("cF3VrIVA"    ):SetValue(aTVariosIVA[i][4])
	          oReport:Section(1):Cell("cF3VrIVAP"   ):SetValue(aTVariosIVA[i][5])
	          oReport:Section(1):Cell("cF3VrIB"     ):SetValue(aTVariosIVA[i][6])
	          oReport:Section(1):Cell("nOTROS"      ):SetValue(aTVariosIVA[i][7])
	          IF i<>Len(aTVariosIVA)
	             oReport:Section(1):PrintLine()
	          ENDIF
	      Next
	      oReport:Section(1):PrintLine()
	      oReport:Section(1):Cell("cF3AlqIVA"   ):SetValue(0)
	      oReport:Section(1):Cell("F3_VALCONT"  ):SetValue(0)
	      oReport:Section(1):Cell("cF3BaseIVA"  ):SetValue(0)
	      oReport:Section(1):Cell("nExenNoGrav" ):SetValue(0)
	      oReport:Section(1):Cell("cF3VrIVA"    ):SetValue(0)
	      oReport:Section(1):Cell("cF3VrIVAP"   ):SetValue(0)
	      oReport:Section(1):Cell("cF3VrIB"     ):SetValue(0)
	      oReport:Section(1):Cell("nOTROS"      ):SetValue(0)
	
	      oReport:Section(1):Cell("F3_ESPECIE"  ):SetValue(Iif(Len(aSortRes)>=1,SUBSTR(aSortRes[1][19],1,2),""))       
	
	      oReport:Section(1):Cell("A1_COD"      ):Disable()
	      oReport:Section(1):Cell("A1_NOME"     ):Disable()
	      oReport:Section(1):Cell("A1_AFIP"     ):Disable()
	      oReport:Section(1):Cell("A1_CGC"      ):Disable()
	      oReport:Section(1):Cell("A1_TIPO"     ):Disable()
	      oReport:Section(1):Cell("F3_ENTRADA"  ):Disable()
	      oReport:Section(1):Cell("F3_ESPECIE"  ):Disable()
	      oReport:Section(1):Cell("F3_SERIE"    ):Disable()
	      oReport:Section(1):Cell("F3_NFISCAL"  ):Disable()
	      oReport:Section(1):Cell("cF3AlqIVA"   ):Disable()
	      oReport:Section(1):Cell("F3_VALCONT"  ):Disable()
	      oReport:Section(1):Cell("cF3BaseIVA"  ):Disable()
	      oReport:Section(1):Cell("nExenNoGrav" ):Disable()
	      oReport:Section(1):Cell("cF3VrIVA"    ):Disable()
	      oReport:Section(1):Cell("cF3VrIVAP"   ):Disable()
	      oReport:Section(1):Cell("cF3VrIB"     ):HIDE()
	      oReport:Section(1):Cell("nOTROS"      ):HIDE()

	      oReport:Section(1):Cell("cF3VrIB"     ):Disable()
	      oReport:Section(1):Cell("nOTROS"      ):Disable()

	      oReport:Section(1):Cell("cF3VrIB"     ):Enable()
	      oReport:Section(1):Cell("nOTROS"      ):Enable()

	      oReport:PrintText( STR0024)               
	      IF AllTrim(STR(MV_PAR07)) $ "1|2|3|4"//CASO RESUMO DDJJ-IVA SEJA HABILITADO PARA IMPRESSAO
	         oReport:Section(1):PrintLine()
	         oReport:Section(1):Cell("A1_COD"      ):Enable()
	         oReport:Section(1):Cell("A1_NOME"     ):Enable()
	         oReport:Section(1):Cell("A1_AFIP"     ):Enable()
	         oReport:Section(1):Cell("A1_CGC"      ):Enable()
	         oReport:Section(1):Cell("A1_TIPO"     ):Enable()
	         oReport:Section(1):Cell("F3_ENTRADA"  ):Enable()
	         oReport:Section(1):Cell("F3_ESPECIE"  ):Enable()
	         oReport:Section(1):Cell("F3_SERIE"    ):Enable()
	         oReport:Section(1):Cell("F3_NFISCAL"  ):Enable()
	         oReport:Section(1):Cell("cF3AlqIVA"   ):Enable()
	         oReport:Section(1):Cell("F3_VALCONT"  ):Enable()
	         oReport:Section(1):Cell("cF3BaseIVA"  ):Enable()
	         oReport:Section(1):Cell("nExenNoGrav" ):Enable()
	         oReport:Section(1):Cell("cF3VrIVA"    ):Enable()
	         oReport:Section(1):Cell("cF3VrIVAP"   ):Enable()
	      ENDIF
	   ENDIF
	   IF MV_PAR07=5 //CASO RESUMO DDJJ-IVA NAO SEJA HABILITADO PARA IMPRESSAO
	      oReport:Section(1):Cell("A1_COD"      ):Hide()
	      oReport:Section(1):Cell("A1_NOME"     ):Hide()
	      oReport:Section(1):Cell("A1_AFIP"     ):Hide()
	      oReport:Section(1):Cell("A1_CGC"      ):Hide()
	      oReport:Section(1):Cell("A1_TIPO"     ):Hide()
	      oReport:Section(1):Cell("F3_ENTRADA"  ):Hide()
	      oReport:Section(1):Cell("F3_ESPECIE"  ):Hide()
	      oReport:Section(1):Cell("F3_SERIE"    ):Hide()
	      oReport:Section(1):Cell("F3_NFISCAL"  ):Hide()
	      oReport:Section(1):Cell("cF3AlqIVA"   ):Hide()
	      oReport:Section(1):Cell("F3_VALCONT"  ):Hide()
	      oReport:Section(1):Cell("cF3BaseIVA"  ):Hide()
	      oReport:Section(1):Cell("nExenNoGrav" ):Hide()
	      oReport:Section(1):Cell("cF3VrIVA"    ):Hide()
	      oReport:Section(1):Cell("cF3VrIVAP"   ):Hide()
	      oReport:Section(1):Cell("cF3VrIB"     ):HIDE()
	      oReport:Section(1):Cell("nOTROS"      ):HIDE()
	   ENDIF
	   oReport:Section(1):Finish() 
	Endif
	
	*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*
	//IMPRESSAO DE RESUMO DDJJ-IVA
	If AllTrim(STR(MV_PAR07)) $ "1|2|3|4" //HABILITADO PARA IMPRESSAO
	   oReport:Section(1):Init()
	   //oReport:EndPage()
	   aTFiscal:={{"F1",0.00,0.00,0.00,0.00,0.00},{"F2",0.00,0.00,0.00,0.00,0.00}} //SUBTOTAIS
	   
	   oReport:Section(1):Cell("A1_COD"      ):SetTitle(Space(Len(oSection:ACELL[1]:GETTEXT())))
	   oReport:Section(1):Cell("A1_NOME"     ):SetTitle(Space(Len(oSection:ACELL[2]:GETTEXT())))
	   oReport:Section(1):Cell("A1_COD"      ):SetValue("")
	   oReport:Section(1):Cell("A1_AFIP"     ):Hide()
	   oReport:Section(1):Cell("A1_CGC"      ):Hide()
	   oReport:Section(1):Cell("A1_TIPO"     ):Hide()
	   oReport:Section(1):Cell("F3_ENTRADA"  ):Hide()    	
	   oReport:Section(1):Cell("F3_ESPECIE"  ):Hide()
	    	
	   oReport:Section(1):Cell("F3_SERIE"    ):SetTitle(Space(Len(oSection:ACELL[7]:GETTEXT())))
	   oReport:Section(1):Cell("F3_SERIE"    ):Hide()
	   oReport:Section(1):Cell("F3_NFISCAL"  ):SetTitle(Space(Len(oSection:ACELL[8]:GETTEXT())))
	   oReport:Section(1):Cell("F3_NFISCAL"  ):Hide()
	   oReport:Section(1):Cell("cF3AlqIVA"   ):SetTitle(STR0029 )
	   oReport:Section(1):Cell("F3_VALCONT"  ):SetTitle(STR0030 )
	   oReport:Section(1):Cell("cF3BaseIVA"  ):SetTitle(STR0031 )
	   oReport:Section(1):Cell("nExenNoGrav" ):SetTitle(STR0032 )
	   oReport:Section(1):Cell("cF3VrIVA"    ):SetTitle(STR0033 )
	   oReport:Section(1):Cell("cF3VrIVAP"   ):SetTitle(STR0034 )
	   oReport:Section(1):Cell("cF3VrIB"     ):SetTitle(Space(Len(oSection:ACELL[15]:GETTEXT())))
	   oReport:Section(1):Cell("nOTROS"      ):SetTitle(Space(Len(oSection:ACELL[16]:GETTEXT())))
	   cCFO := Iif(Len(aSortRes)>=1,aSortRes[1][19]," ")
	   nAliq:=Iif(Len(aSortRes)>=1,aSortRes[1][17]," ")
	   IF MV_PAR04=2
	      oReport:SkipLine()
	   ENDIF
	   oReport:PrintText(STR0035)
	   oReport:SkipLine()
	   For i=1 to Len(aSortRes)
	       
		   oReport:Section(1):Cell("F3_ESPECIE"  ):SetValue(SUBSTR(aSortRes[i][19],1,2))
	       y:=ASCAN(aTFiscal,{|x| x[1]==SUBSTR(aSortRes[i][19],1,2)})
	       aTFiscal[Y][2]+= aSortRes[i][ 1]+aSortRes[i][ 2]+aSortRes[i][ 3]
	       aTFiscal[Y][3]+= aSortRes[i][ 4]+aSortRes[i][ 5]+aSortRes[i][ 6]
	       aTFiscal[Y][4]+= aSortRes[i][ 7]+aSortRes[i][ 8]+aSortRes[i][ 9]
	       aTFiscal[Y][5]+= aSortRes[i][10]+aSortRes[i][11]+aSortRes[i][12]
	       aTFiscal[Y][6]+= aSortRes[i][13]+aSortRes[i][14]+aSortRes[i][15]
			
			
			If AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG"
				oReport:Section(1):Cell("A1_NOME"     ):SetValue(STR0050)
				oReport:Section(1):Cell("A1_COD"      ):SetValue(aSortRes[i][16])
				oReport:Section(1):Cell("cF3AlqIVA"   ):SetValue(0) 
				oReport:Section(1):Cell("F3_VALCONT"  ):SetValue(aSortRes[i][20])
				oReport:Section(1):Cell("cF3BaseIVA"  ):SetValue(aSortRes[i][21])
				oReport:Section(1):Cell("cF3BaseIVA"  ):Disable()
				oReport:Section(1):Cell("nExenNoGrav" ):SetValue(aSortRes[i][22])
				oReport:Section(1):Cell("cF3VrIVA"    ):SetValue(aSortRes[i][23])
				oReport:Section(1):Cell("cF3VrIVAP"   ):SetValue(aSortRes[i][24])
				oReport:Section(1):PrintLine()
			EndIf
			
	       oReport:Section(1):Cell("A1_NOME"     ):SetValue(STR0036)
	       oReport:Section(1):Cell("A1_COD"      ):SetValue(aSortRes[i][16])//SetValue(IIf (AllTrim(STR(MV_PAR07)) $ "2|3|4","codigo",aSortRes[i][16]))
	       oReport:Section(1):Cell("cF3AlqIVA"   ):SetValue(aSortRes[i][17]) 
		   oReport:Section(1):Cell("F3_VALCONT"  ):SetValue(aSortRes[i][ 1])
	       oReport:Section(1):Cell("cF3BaseIVA"  ):SetValue(aSortRes[i][ 4])
	       oReport:Section(1):Cell("cF3BaseIVA"  ):Disable()
	       oReport:Section(1):Cell("nExenNoGrav" ):SetValue(aSortRes[i][ 7])
	       oReport:Section(1):Cell("cF3VrIVA"    ):SetValue(aSortRes[i][10])
	       oReport:Section(1):Cell("cF3VrIVAP"   ):SetValue(aSortRes[i][13])
	       oReport:Section(1):PrintLine()
	       oReport:Section(1):Cell("A1_NOME"     ):SetValue(STR0037)
	       oReport:Section(1):Cell("cF3AlqIVA"   ):SetValue(aSortRes[i][17]) 
		   oReport:Section(1):Cell("F3_VALCONT"  ):SetValue(aSortRes[i][ 2])
	       oReport:Section(1):Cell("cF3BaseIVA"  ):Disable()
	       oReport:Section(1):Cell("cF3BaseIVA"  ):SetValue(aSortRes[i][ 5])
	       oReport:Section(1):Cell("nExenNoGrav" ):SetValue(aSortRes[i][ 8])
	       oReport:Section(1):Cell("cF3VrIVA"    ):SetValue(aSortRes[i][11])
	       oReport:Section(1):Cell("cF3VrIVAP"   ):SetValue(aSortRes[i][14])
	       //oReport:Section(1):Cell(cF3VrIB       ):SetValue(aSortRes[i][16]) //RETIRAR
	       oReport:Section(1):PrintLine()
	       oReport:Section(1):Cell("A1_NOME"     ):SetValue(STR0038)
	       oReport:Section(1):Cell("cF3AlqIVA"   ):SetValue(aSortRes[i][17]) 
	       oReport:Section(1):Cell("F3_VALCONT"  ):SetValue(aSortRes[i][ 3])
	       oReport:Section(1):Cell("cF3BaseIVA"  ):Disable()
	       oReport:Section(1):Cell("cF3BaseIVA"  ):SetValue(aSortRes[i][ 6])
	       oReport:Section(1):Cell("nExenNoGrav" ):SetValue(aSortRes[i][ 9])
	       oReport:Section(1):Cell("cF3VrIVA"    ):SetValue(aSortRes[i][12])
	       oReport:Section(1):Cell("cF3VrIVAP"   ):SetValue(aSortRes[i][15])
	       oReport:Section(1):PrintLine()
	       IF SX5->(MSSeek(XFILIAL("SX5")+IiF(AllTrim(STR(MV_PAR07)) $ "2|4" .and. cPaisLoc == "ARG",cCveActPro,"13")+aSortRes[i][16]))
	          oReport:PrintText(aSortRes[i][16]+"-"+x5Descri())
	       ElseIf	AllTrim(STR(MV_PAR07)) == "3" .and. cPaisLoc == "ARG"
	       	dbSelectArea("SB1")
	       	SB1->(dbSetOrder(1))
	       	If SB1->(dbseek(XFILIAL("SB1")+aSortRes[i][16]))
	       		oReport:PrintText(aSortRes[i][16]+"-"+SB1->B1_DESC)
	       	EndIf	
	       	SB1->(dbCloseArea())
	       ENDIF
	       
	       
	       /* Inicia desgloce de productos por Act. Declarada*/
	       
			If AllTrim(STR(MV_PAR07)) == "4" .and. cPaisLoc == "ARG"
				oReport:Section(2):Init()
				oReport:Section(2):Cell("A1_COD"      ):SetTitle("")
			   	oReport:Section(2):Cell("A1_NOME"     ):SetTitle("")
			   	oReport:Section(2):Cell("A1_COD"      ):SetValue("")
			   	oReport:Section(2):Cell("cF3AlqIVA"   ):SetTitle(STR0029 )
			   	oReport:Section(2):Cell("F3_VALCONT"  ):SetTitle(STR0030 )
			   	oReport:Section(2):Cell("cF3BaseIVA"  ):SetTitle(STR0031 )
			   	oReport:Section(2):Cell("nExenNoGrav" ):SetTitle(STR0032 )
			   	oReport:Section(2):Cell("cF3VrIVA"    ):SetTitle(STR0033 )
			   	oReport:Section(2):Cell("cF3VrIVAP"   ):SetTitle(STR0034 )
				For nP=1 to Len(aResumoPro)
					If aResumoPro[nP][19] == aSortRes[i][19]//aResumoPro[nP][20] == aSortRes[i][16] .and. aResumoPro[nP][17] == aSortRes[i][17]
						oReport:Section(2):Cell("A1_NOME"     ):SetValue(STR0050)
						oReport:Section(2):Cell("A1_COD"      ):SetValue(aResumoPro[nP][16])
						oReport:Section(2):Cell("cF3AlqIVA"   ):SetValue(0) 					
						oReport:Section(2):Cell("F3_VALCONT"  ):SetValue(aResumoPro[nP][20])
					   oReport:Section(2):Cell("cF3BaseIVA"  ):SetValue(aResumoPro[nP][21])
					   oReport:Section(2):Cell("cF3BaseIVA"  ):Disable()
					   oReport:Section(2):Cell("nExenNoGrav" ):SetValue(aResumoPro[nP][22])
					   oReport:Section(2):Cell("cF3VrIVA"    ):SetValue(aResumoPro[nP][23])
					   oReport:Section(2):Cell("cF3VrIVAP"   ):SetValue(aResumoPro[nP][24])
						oReport:Section(2):PrintLine()
						oReport:PrintText( aResumoPro[nP][16],,)
						
					   oReport:Section(2):Cell("A1_NOME"     ):SetValue(STR0036)
					   oReport:Section(2):Cell("A1_COD"      ):SetValue(aResumoPro[nP][16])//SetValue(IIf (AllTrim(STR(MV_PAR07)) $ "2|3|4","codigo",aSortRes[i][16]))
					   oReport:Section(2):Cell("cF3AlqIVA"   ):SetValue(aResumoPro[nP][17]) 
					   oReport:Section(2):Cell("F3_VALCONT"  ):SetValue(aResumoPro[nP][ 1])
					   oReport:Section(2):Cell("cF3BaseIVA"  ):SetValue(aResumoPro[nP][ 4])
					   oReport:Section(2):Cell("cF3BaseIVA"  ):Disable()
					   oReport:Section(2):Cell("nExenNoGrav" ):SetValue(aResumoPro[nP][ 7])
					   oReport:Section(2):Cell("cF3VrIVA"    ):SetValue(aResumoPro[nP][10])
					   oReport:Section(2):Cell("cF3VrIVAP"   ):SetValue(aResumoPro[nP][13])
					   
					   oReport:Section(2):PrintLine()
					   oReport:Section(2):Cell("A1_NOME"     ):SetValue(STR0037)
					   oReport:Section(2):Cell("cF3AlqIVA"   ):SetValue(aResumoPro[nP][17]) 
					   oReport:Section(2):Cell("F3_VALCONT"  ):SetValue(aResumoPro[nP][ 2])
					   oReport:Section(2):Cell("cF3BaseIVA"  ):Disable()
					   oReport:Section(2):Cell("cF3BaseIVA"  ):SetValue(aResumoPro[nP][ 5])
					   oReport:Section(2):Cell("nExenNoGrav" ):SetValue(aResumoPro[nP][ 8])
					   oReport:Section(2):Cell("cF3VrIVA"    ):SetValue(aResumoPro[nP][11])
					   oReport:Section(2):Cell("cF3VrIVAP"   ):SetValue(aResumoPro[nP][14])
					   oReport:Section(2):PrintLine()
					   oReport:Section(2):Cell("A1_NOME"     ):SetValue(STR0038)
					   oReport:Section(2):Cell("cF3AlqIVA"   ):SetValue(aResumoPro[nP][17]) 
					   oReport:Section(2):Cell("F3_VALCONT"  ):SetValue(aResumoPro[nP][ 3])
					   oReport:Section(2):Cell("cF3BaseIVA"  ):Disable()
					   oReport:Section(2):Cell("cF3BaseIVA"  ):SetValue(aResumoPro[nP][ 6])
					   oReport:Section(2):Cell("nExenNoGrav" ):SetValue(aResumoPro[nP][ 9])
					   oReport:Section(2):Cell("cF3VrIVA"    ):SetValue(aResumoPro[nP][12])
					   oReport:Section(2):Cell("cF3VrIVAP"   ):SetValue(aResumoPro[nP][15])
					   oReport:Section(2):PrintLine()
	
						dbSelectArea("SB1")
						SB1->(dbSetOrder(1))
						If SB1->(dbseek(XFILIAL("SB1")+aResumoPro[nP][16]))
							oReport:PrintText(aResumoPro[nP][16]+"-"+SB1->B1_DESC)
						EndIf	
						SB1->(dbCloseArea())
						oReport:SkipLine()
						oReport:SkipLine()
					EndIf
				Next
				oReport:Section(2):Finish() 
	       EndIf
	       /* Fin desgloce de productos por Act. Declarada*/
	       oReport:ThinLine()
	       cCFO :=aSortRes[i][19]          
	       nALIQ := aSortRes[i][17]
	       IF (i+1)<Len(aSortRes)
	          IF SUBSTR(aSortRes[i][19],1,2)="F1"
	             IF SUBSTR(aSortRes[(i+1)][19],1,2)="F2"
	                IF MV_PAR04=2
	                   oReport:PrintText(STR0039)
	                   oReport:ThinLine()
	                   oReport:Section(1):Cell("A1_COD"      ):SetValue(" ")
	                   oReport:Section(1):Cell("A1_NOME"     ):SetValue(" ")
	                   oReport:Section(1):Cell("cF3AlqIVA"   ):Hide()
	                   oReport:Section(1):Cell("F3_VALCONT"  ):SetValue(aTFiscal[1][ 2] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[2][1], 0))
	                   oReport:Section(1):Cell("cF3BaseIVA"  ):SetValue(aTFiscal[1][ 3] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[2][2], 0))
	                   oReport:Section(1):Cell("nExenNoGrav" ):SetValue(aTFiscal[1][ 4] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[2][3], 0))
	                   oReport:Section(1):Cell("cF3VrIVA"    ):SetValue(aTFiscal[1][ 5] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[2][4], 0))
	                   oReport:Section(1):Cell("cF3VrIVAP"   ):SetValue(aTFiscal[1][ 6] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[2][5], 0))
	                   oReport:Section(1):PrintLine()
	                   oReport:SkipLine()                   
	                 Else
	                   oReport:PrintText( STR0039)
	                Endif
	             ENDIF
	          ENDIF  
	       ENDIF
	   NEXT
	   IF MV_PAR04=1
	      oReport:Section(1):Cell("F3_ESPECIE"  ):SetValue("TS2")
	      oReport:PrintText( STR0040) 
	      oReport:Section(1):Cell("A1_COD"      ):SetValue(" ")
	
	      oReport:Section(1):Cell("A1_COD"      ):Hide()
	      oReport:Section(1):Cell("A1_NOME"     ):Hide() 
	      oReport:Section(1):Cell("A1_AFIP"     ):Hide()
	      oReport:Section(1):Cell("A1_CGC"      ):Hide()
	      oReport:Section(1):Cell("A1_TIPO"     ):Hide()
	      oReport:Section(1):Cell("F3_ENTRADA"  ):Hide()
	      oReport:Section(1):Cell("F3_ESPECIE"  ):Hide()
	      oReport:Section(1):Cell("F3_SERIE"    ):Hide()
	      oReport:Section(1):Cell("F3_NFISCAL"  ):Hide()
	      oReport:Section(1):Cell("cF3AlqIVA"   ):Hide()
	      oReport:Section(1):Cell("F3_VALCONT"  ):Hide()
	      oReport:Section(1):Cell("cF3BaseIVA"  ):Hide()
	      oReport:Section(1):Cell("nExenNoGrav" ):Hide()
	      oReport:Section(1):Cell("cF3VrIVA"    ):Hide()
	      oReport:Section(1):Cell("cF3VrIVAP"   ):Hide()
	      oReport:Section(1):Cell("cF3VrIB"     ):HIDE()
	      oReport:Section(1):Cell("nOTROS"      ):HIDE()
	   	       
	      oReport:Section(1):Cell("cF3VrIB"     ):Disable()
	      oReport:Section(1):Cell("nOTROS"      ):Disable()
	
	      oReport:Section(1):PrintLine()
	      
	      oReport:Section(1):Init()
	
	      oReport:Section(1):Cell("A1_COD"      ):Show()
	      oReport:Section(1):Cell("A1_NOME"     ):Show()                      
	      oReport:Section(1):Cell("A1_COD"      ):SetValue(STR0041)
	      oReport:Section(1):Cell("A1_NOME"     ):SetValue(STR0042)
	
	      oReport:Section(1):Cell("cF3AlqIVA"   ):Hide()                       
	      oReport:Section(1):Cell("F3_VALCONT"  ):SetValue((aTFiscal[1][ 2]+aTFiscal[2][ 2] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[1][1] + aNoGrav[2][1], 0)))
	      oReport:Section(1):Cell("cF3BaseIVA"  ):SetValue((aTFiscal[1][ 3]+aTFiscal[2][ 3] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[1][2] + aNoGrav[2][2], 0)))
	      oReport:Section(1):Cell("nExenNoGrav" ):SetValue((aTFiscal[1][ 4]+aTFiscal[2][ 4] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[1][3] + aNoGrav[2][3], 0)))
	      oReport:Section(1):Cell("cF3VrIVA"    ):SetValue((aTFiscal[1][ 5]+aTFiscal[2][ 5] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[1][4] + aNoGrav[2][4], 0)))
	      oReport:Section(1):Cell("cF3VrIVAP"   ):SetValue((aTFiscal[1][ 6]+aTFiscal[2][ 6] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[1][5] + aNoGrav[2][5], 0)))
	      oReport:Section(1):PrintLine()
	      oReport:Section(1):Finish()
	    ELSE
	      IF MV_PAR04=2
	         oReport:PrintText(STR0040) 
	         oReport:Section(1):Cell("A1_COD"      ):SetValue(" ")
	         oReport:Section(1):Cell("A1_NOME"     ):SetValue(" ")
	         oReport:Section(1):Cell("cF3AlqIVA"   ):Hide()
	         oReport:Section(1):Cell("F3_VALCONT"  ):SetValue(aTFiscal[2][ 2] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[1][1], 0))
	         oReport:Section(1):Cell("cF3BaseIVA"  ):SetValue(aTFiscal[2][ 3] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[1][2], 0))
	         oReport:Section(1):Cell("nExenNoGrav" ):SetValue(aTFiscal[2][ 4] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[1][3], 0))
	         oReport:Section(1):Cell("cF3VrIVA"    ):SetValue(aTFiscal[2][ 5] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[1][4], 0))
	         oReport:Section(1):Cell("cF3VrIVAP"   ):SetValue(aTFiscal[2][ 6] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[1][5], 0))
	         oReport:ThinLine()
	         oReport:Section(1):PrintLine()
	     
	         oReport:SkipLine()
	         oReport:PrintText(STR0041+" " + STR0042)// Debito               
	         oReport:ThinLine()
	         oReport:Section(1):Cell("A1_COD"      ):SetValue(" ")
	         oReport:Section(1):Cell("A1_NOME"     ):SetValue(" ")
	         oReport:Section(1):Cell("cF3AlqIVA"   ):Hide()
	         oReport:Section(1):Cell("F3_VALCONT"  ):SetValue((aTFiscal[1][ 2]+aTFiscal[2][ 2] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[1][1] + aNoGrav[2][1], 0)))
	         oReport:Section(1):Cell("cF3BaseIVA"  ):SetValue((aTFiscal[1][ 3]+aTFiscal[2][ 3] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[1][2] + aNoGrav[2][2], 0)))
	         oReport:Section(1):Cell("nExenNoGrav" ):SetValue((aTFiscal[1][ 4]+aTFiscal[2][ 4] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[1][3] + aNoGrav[2][3], 0)))
	         oReport:Section(1):Cell("cF3VrIVA"    ):SetValue((aTFiscal[1][ 5]+aTFiscal[2][ 5] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[1][4] + aNoGrav[2][4], 0)))
	         oReport:Section(1):Cell("cF3VrIVAP"   ):SetValue((aTFiscal[1][ 6]+aTFiscal[2][ 6] + IIF(AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG", aNoGrav[1][5] + aNoGrav[2][5], 0)))
	         oReport:Section(1):PrintLine()
	         oReport:Section(1):Finish()
	      ENDIF    
	   ENDIF
	Endif
Return

/*****************************************************************************************/
//FUNÇOÃO UTILIZADA NA CELULA "oSection:Cell("nExenNoGrav"):SetBlock({|| })"//
/*****************************************************************************************/
Static Function sfVlrExenNG(nALiqIVA,nContabil,nBIVA,nIVA,nIVAP,nEXCL,nIBP,nExentas,nLoop)//,cCLIEFOR)
Local nSomaVarios:=0
Local cCampoIMP:="(cAliasA)->F3_VALIMP"
Local cLerCampo  
Local i
Local nSinal:=1
Local cTabla := ""
Local cPref	:= ""
Local cQryTmp := ""
Local cCposTmp := ""
Local nI
Local sfAliqIV := 0
Local aResult := {0,0,0,0,0}
Local nPro := 0
Local nPosVal := 1
Local aImpTES := {}
Local lItemNoEx := .F.
Local lNFNoProc
Local nPosFil := aScan( aConfSFB,{|x| x[1] == (cAliasA)->SUCURSAL} )

Private cAliasTmp := GetNextAlias()

cQuebraTipo:=( cAliasA )->F3_ESPECIE 
If nPosFil <> 0     
	For i = 1 to Len(aConfSFB[nPosFil][2])
	    cLerCampo=cCampoIMP+aConfSFB[nPosFil][2][i]//aImpostos[i]
	    nSomaVarios+=&cLerCampo
	Next
EndIf
If Alltrim(( cAliasA )->F3_ESPECIE) $ "NCC|NDE"
	nSinal:=-1
EndIf
IF !Empty((cAliasA)->F3_DTCANC) .And. MV_PAR03 == 3 
    nContabil:= 0
EndIf
nTotOtros:=(nSomaVarios+nEXCL)*nSinal

If Alltrim(( cAliasA )->F3_ESPECIE) $ "NCC|NDE"
	nExentas := nExentas * nSinal
EndIf
If nExentas == 0 .and. cPaisLoc == "ARG" .and. (nIVA == 0 .and. nIVAP == 0)
	nExentas += ((cAliasA)->F3_VALCONT*nSinal)-(nIVA+nIVAP+nIBP+nTotOtros)
EndIf
If nExentas == 0
	nTotOtros += (nContabil*nSinal)-(nIVA+nIVAP+nIBP+nBIVA+nTotOtros)
EndIf
nTotEXEN := nExentas
nContabil:=nContabil*nSinal

////TOTALES 
i:=ASCAN(aTotales,{|x| x[9]==(cAliasA)->A1_TIPO})
If i<>0
	aTotales[i,nColTot  ]+=nContabil
	aTotales[i,nColGra  ]+=nBIVA
	aTotales[i,nColExen ]+=nTotEXEN
	aTotales[i,nColIVA  ]+=nIVA
	aTotales[i,nColIVAP ]+=nIVAP
	aTotales[i,nColIBP  ]+=nIBP
	aTotales[i,nColOtros]+=nTotOtros
	aSTotales[1]+=nContabil
	aSTotales[2]+=nBIVA
	aSTotales[3]+=nTotEXEN
	aSTotales[4]+=nIVA
	aSTotales[5]+=nIVAP
	aSTotales[6]+=nIBP
	aSTotales[7]+=(nTotOtros+nEXCL)
	X:=&cTF3AlqIVA
	
	If AllTrim(STR(MV_PAR07)) $ "2|3|4" .and. cPaisLoc == "ARG"
	
		cTabla := Iif(F3_ESPECIE<>"NDE" .AND.F3_ESPECIE<>"NCC","SD2","SD1")
		cPref := Substr(cTabla,2)
		
		For nI=1 to Len(aConfSFB[nPosFil][5])
			cCposTmp += ", " + cPref + "_ALQIMP" + aConfSFB[nPosFil][5][nI]
			
			cCposTmp += ", " + cPref + "_BASIMP" + aConfSFB[nPosFil][5][nI]
			
			cCposTmp += ", " + cPref + "_VALIMP" + aConfSFB[nPosFil][5][nI]
		Next
		
		For nI=1 to Len(aConfSFB[nPosFil][3])
			cCposTmp += ", " + cPref + "_VALIMP" + aConfSFB[nPosFil][3][nI]
		Next
		
		nPosFil := aScan( aSucEmp[nLoop][1],{|x| x == (cAliasA)->SUCURSAL} )
		
		cQryTmp := "SELECT " + cPref + "_DOC, " + cPref + "_TES, " + cPref + "_TOTAL" + cCposTmp + ", B1_ACTDEC, B1_COD"
		cQryTmp += "FROM " + RetSqlName(cTabla) + " " +  cTabla + " , "  + RetSqlName("SB1") + " SB1 "
		cQryTmp += "WHERE " + cPref + "_DOC = '" + ( cAliasA )->F3_NFISCAL +"' AND " + cPref + IIF(cTabla == "SD2", "_CLIENTE","_FORNECE" ) + " = '" + ( cAliasA )->F3_CLIEFOR + "' AND " + cPref + "_COD = B1_COD AND " + cPref +"_FILIAL='"
   		cQryTmp += xFilial(cTabla, aSucEmp[nLoop][1][nPosFil]) + "' AND " + cTabla + ".D_E_L_E_T_=' ' AND SB1.D_E_L_E_T_=' '"
		
		cQryTmp := ChangeQuery(cQryTmp)
		If Select( cAliasTmp ) > 0
		   dbSelectArea( cAliasTmp )
		   dbCloseArea()
		EndIf

		If Len(aNFs) == 0
			aAdd(aNFs, (cAliasA)->F3_NFISCAL)
		Else
			lNFNoProc := aScan(aNFs,{|x| (cAliasA)->F3_NFISCAL $ x}) <> 0
			If !lNFNoProc
				aAdd(aNFs, (cAliasA)->F3_NFISCAL)
			EndIf
		EndIf
		If !lNFNoProc
			//// *** Abre Tabelas *** //
			dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQryTmp), cAliasTmp , .F., .T.)
			dbSelectArea(cAliasTmp) 
			
			While !(cAliasTmp)->(Eof())
				aResult[4] = sfVrIVAPD(cPref, aSucEmp[nLoop][1][nPosFil])
				aResult[3] = sfVrIVAD(cPref, aSucEmp[nLoop][1][nPosFil])
				aResult[2] = sfBaseIVAD(cPref, aSucEmp[nLoop][1][nPosFil])
				aResult[1] = sfAliqIVAD(cPref, aSucEmp[nLoop][1][nPosFil])
				If Alltrim(( cAliasA )->F3_ESPECIE) $ "NCC|NDE"
					aResult[5] = &("(cAliasTmp)->"+cPref+"_TOTAL") + aResult[2]
					aResult[5] := aResult[5] * -1
					nPosVal := 2
				Else
					aImpTES := DefImposto(&("(cAliasTmp)->"+cPref+"_TES"))
					lItemNoEx := aScan(aImpTES,{|x| "IV" $ AllTrim(x[1])}) <> 0
					If !lItemNoEx
						aResult[5] = &("(cAliasTmp)->"+cPref+"_TOTAL")
					EndIf
				EndIf
				
				If Len(aResumoIVA)=0
					IF (cAliasA)->A1_TIPO="I"
						AADD(aResumoIVA,{aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD),aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+(IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD)+ALLTRIM(STR(aResult[1])))),aResult[5],0.00,0.00,0.00,0.00})
						aNoGrav[nPosVal][1] += aResult[5]
					ELSEIF (cAliasA)->A1_TIPO="N"
					  	AADD(aResumoIVA,{0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD),aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+(IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD)+ALLTRIM(STR(aResult[1])))),0.00,aResult[5],0.00,0.00,0.00})
					  	aNoGrav[nPosVal][2] += aResult[5]
					ELSEIF (cAliasA)->A1_TIPO$"X|F" .OR. (cAliasA)->A1_TIPO="S"
					  	AADD(aResumoIVA,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD),aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+(IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD)+ALLTRIM(STR(aResult[1])))),0.00,0.00,aResult[5],0.00,0.00})
					  	aNoGrav[nPosVal][3] += aResult[5]
					ELSEIF (cAliasA)->A1_TIPO="M"
					  	AADD(aResumoIVA,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD),aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+(IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD)+ALLTRIM(STR(aResult[1])))),0.00,0.00,0.00,aResult[5],0.00})
					  	aNoGrav[nPosVal][4] += aResult[5]
					ELSEIF (cAliasA)->A1_TIPO="E"
					  	AADD(aResumoIVA,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD),aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+(IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD)+ALLTRIM(STR(aResult[1])))),0.00,0.00,0.00,0.00,aResult[5]})
					  	aNoGrav[nPosVal][5] += aResult[5]
					ENDIF
					
					If (AllTrim(STR(MV_PAR07))) == "4"
						IF (cAliasA)->A1_TIPO="I"
							AADD(aResumoPro,{aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,(cAliasTmp)->B1_COD,aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+((cAliasTmp)->B1_ACTDEC+ALLTRIM(STR(aResult[1])))),aResult[5],0.00,0.00,0.00,0.00})
						ELSEIF (cAliasA)->A1_TIPO="N"
						  	AADD(aResumoPro,{0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,(cAliasTmp)->B1_COD,aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+((cAliasTmp)->B1_ACTDEC+ALLTRIM(STR(aResult[1])))),0.00,aResult[5],0.00,0.00,0.00})
						ELSEIF (cAliasA)->A1_TIPO$"X|F" .OR. (cAliasA)->A1_TIPO="S"
						  	AADD(aResumoPro,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,(cAliasTmp)->B1_COD,aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+((cAliasTmp)->B1_ACTDEC+ALLTRIM(STR(aResult[1])))),0.00,0.00,aResult[5],0.00,0.00})
						ELSEIF (cAliasA)->A1_TIPO="M"
						  	AADD(aResumoPro,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,(cAliasTmp)->B1_COD,aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+((cAliasTmp)->B1_ACTDEC+ALLTRIM(STR(aResult[1])))),0.00,0.00,0.00,aResult[5],0.00})
						ELSEIF (cAliasA)->A1_TIPO="E"
						  	AADD(aResumoPro,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],(cAliasTmp)->B1_COD,aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+((cAliasTmp)->B1_ACTDEC+ALLTRIM(STR(aResult[1])))),0.00,0.00,0.00,0.00,aResult[5]})
						EndIf
					EndIf
				ELSE
					IF((cAliasA)->F3_ESPECIE<>"NDE" .AND. (cAliasA)->F3_ESPECIE<>"NCC",y:=ASCAN(aResumoIVA,{|x| x[19]==("F2"+IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD)+ALLTRIM(STR(aResult[1])))}),y:=ASCAN(aResumoIVA,{|x| x[19]==("F1"+IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD)+ALLTRIM(STR(aResult[1])))}))
					IF Y<>0 
						IF (cAliasA)->A1_TIPO="I"
							aResumoIVA[Y][1]+=aResult[2]
							aResumoIVA[Y][2]+=aResult[3]
							aResumoIVA[Y][3]+=aResult[4]
							aResumoIVA[Y][20]+=aResult[5]
							aNoGrav[nPosVal][1] += aResult[5]
						ELSEIF (cAliasA)->A1_TIPO="N"
							aResumoIVA[Y][4]+=aResult[2]
							aResumoIVA[Y][5]+=aResult[3]
							aResumoIVA[Y][6]+=aResult[4]
							aResumoIVA[Y][21]+=aResult[5]
							aNoGrav[nPosVal][2] += aResult[5]
						ELSEIF (cAliasA)->A1_TIPO$"X|F" .OR. (cAliasA)->A1_TIPO="S"
							aResumoIVA[Y][7]+=aResult[2]
							aResumoIVA[Y][8]+=aResult[3]
							aResumoIVA[Y][9]+=aResult[4]
							aResumoIVA[Y][22]+=aResult[5]
							aNoGrav[nPosVal][3] += aResult[5]
						ELSEIF (cAliasA)->A1_TIPO="M"
							aResumoIVA[Y][10]+=aResult[2]
							aResumoIVA[Y][11]+=aResult[3]
							aResumoIVA[Y][12]+=aResult[4]
							aResumoIVA[Y][23]+=aResult[5]
							aNoGrav[nPosVal][4] += aResult[5]
						ELSEIF (cAliasA)->A1_TIPO="E"
							aResumoIVA[Y][13]+=aResult[2]
							aResumoIVA[Y][14]+=aResult[3]
							aResumoIVA[Y][15]+=aResult[4]
							aResumoIVA[Y][24]+=aResult[5]
							aNoGrav[nPosVal][5] += aResult[5]
						ENDIF
						
						If (AllTrim(STR(MV_PAR07))) == "4" 
							IF((cAliasA)->F3_ESPECIE<>"NDE" .AND. (cAliasA)->F3_ESPECIE<>"NCC",nPro:=ASCAN(aResumoPro,{|x| x[19]==("F2"+(cAliasTmp)->B1_ACTDEC+ALLTRIM(STR(aResult[1]))).and. x[16]==(cAliasTmp)->B1_COD}),nPro:=ASCAN(aResumoPro,{|x| x[19]==("F1"+(cAliasTmp)->B1_ACTDEC+ALLTRIM(STR(aResult[1]))) .and. x[16]==(cAliasTmp)->B1_COD}))
							IF nPro == 0 
								IF (cAliasA)->A1_TIPO="I"
									AADD(aResumoPro,{aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,(cAliasTmp)->B1_COD,aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+((cAliasTmp)->B1_ACTDEC+ALLTRIM(STR(aResult[1])))),aResult[5],0.00,0.00,0.00,0.00})
								ELSEIF (cAliasA)->A1_TIPO="N"
								  	AADD(aResumoPro,{0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,(cAliasTmp)->B1_COD,aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+((cAliasTmp)->B1_ACTDEC+ALLTRIM(STR(aResult[1])))),0.00,aResult[5],0.00,0.00,0.00})
								ELSEIF (cAliasA)->A1_TIPO$"X|F" .OR. (cAliasA)->A1_TIPO="S"
								  	AADD(aResumoPro,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,(cAliasTmp)->B1_COD,aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+((cAliasTmp)->B1_ACTDEC+ALLTRIM(STR(aResult[1])))),0.00,0.00,aResult[5],0.00,0.00})
								ELSEIF (cAliasA)->A1_TIPO="M"
								  	AADD(aResumoPro,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,(cAliasTmp)->B1_COD,aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+((cAliasTmp)->B1_ACTDEC+ALLTRIM(STR(aResult[1])))),0.00,0.00,0.00,aResult[5],0.00})
								ELSEIF (cAliasA)->A1_TIPO="E"
								  	AADD(aResumoPro,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],(cAliasTmp)->B1_COD,aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+((cAliasTmp)->B1_ACTDEC+ALLTRIM(STR(aResult[1])))),0.00,0.00,0.00,0.00,aResult[5]})
								EndIf
							Else		
								IF (cAliasA)->A1_TIPO="I"
									aResumoPro[nPro][1]+=aResult[2]
									aResumoPro[nPro][2]+=aResult[3]
									aResumoPro[nPro][3]+=aResult[4]
									aResumoPro[nPro][20]+=aResult[5]
								ELSEIF (cAliasA)->A1_TIPO="N"
									aResumoPro[nPro][4]+=aResult[2]
									aResumoPro[nPro][5]+=aResult[3]
									aResumoPro[nPro][6]+=aResult[4]
									aResumoPro[nPro][21]+=aResult[5]
								ELSEIF (cAliasA)->A1_TIPO$"X|F" .OR. (cAliasA)->A1_TIPO="S"
									aResumoPro[nPro][7]+=aResult[2]
									aResumoPro[nPro][8]+=aResult[3]
									aResumoPro[nPro][9]+=aResult[4]
									aResumoPro[nPro][22]+=aResult[5]
								ELSEIF (cAliasA)->A1_TIPO="M"
									aResumoPro[nPro][10]+=aResult[2]
									aResumoPro[nPro][11]+=aResult[3]
									aResumoPro[nPro][12]+=aResult[4]
									aResumoPro[nPro][23]+=aResult[5]
								ELSEIF (cAliasA)->A1_TIPO="E"
									aResumoPro[nPro][13]+=aResult[2]
									aResumoPro[nPro][14]+=aResult[3]
									aResumoPro[nPro][15]+=aResult[4]
									aResumoPro[nPro][24]+=aResult[5]
								ENDIF
							Endif
						EndIf
					Else
						IF (cAliasA)->A1_TIPO="I"
							AADD(aResumoIVA,{aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD),aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+(IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD)+ALLTRIM(STR(aResult[1])))),aResult[5],0.00,0.00,0.00,0.00})
							aNoGrav[nPosVal][1] += aResult[5]
						ELSEIF (cAliasA)->A1_TIPO="N"
						  	AADD(aResumoIVA,{0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD),aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+(IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD)+ALLTRIM(STR(aResult[1])))),0.00,aResult[5],0.00,0.00,0.00})
						  	aNoGrav[nPosVal][2] += aResult[5]
						ELSEIF (cAliasA)->A1_TIPO$"X|F" .OR. (cAliasA)->A1_TIPO="S"
						  	AADD(aResumoIVA,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD),aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+(IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD)+ALLTRIM(STR(aResult[1])))),0.00,0.00,aResult[5],0.00,0.00})
						  	aNoGrav[nPosVal][3] += aResult[5]
						ELSEIF (cAliasA)->A1_TIPO="M"
						  	AADD(aResumoIVA,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD),aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+(IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD)+ALLTRIM(STR(aResult[1])))),0.00,0.00,0.00,aResult[5],0.00})
						  	aNoGrav[nPosVal][4] += aResult[5]
						ELSEIF (cAliasA)->A1_TIPO="E"
						  	AADD(aResumoIVA,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD),aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+(IIF(AllTrim(STR(MV_PAR07)) $ "2|4",(cAliasTmp)->B1_ACTDEC,(cAliasTmp)->B1_COD)+ALLTRIM(STR(aResult[1])))),0.00,0.00,0.00,0.00,aResult[5]})
						  	aNoGrav[nPosVal][5] += aResult[5]
						ENDIF
						
						If (AllTrim(STR(MV_PAR07))) == "4"
							IF (cAliasA)->A1_TIPO="I"
								AADD(aResumoPro,{aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,(cAliasTmp)->B1_COD,aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+((cAliasTmp)->B1_ACTDEC+ALLTRIM(STR(aResult[1])))),aResult[5],0.00,0.00,0.00,0.00})
							ELSEIF (cAliasA)->A1_TIPO="N"
							  	AADD(aResumoPro,{0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,(cAliasTmp)->B1_COD,aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+((cAliasTmp)->B1_ACTDEC+ALLTRIM(STR(aResult[1])))),0.00,aResult[5],0.00,0.00,0.00})
							ELSEIF (cAliasA)->A1_TIPO$"X|F" .OR. (cAliasA)->A1_TIPO="S"
							  	AADD(aResumoPro,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,(cAliasTmp)->B1_COD,aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+((cAliasTmp)->B1_ACTDEC+ALLTRIM(STR(aResult[1])))),0.00,0.00,aResult[5],0.00,0.00})
							ELSEIF (cAliasA)->A1_TIPO="M"
							  	AADD(aResumoPro,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],0.00 ,0.00,0.00 ,(cAliasTmp)->B1_COD,aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+((cAliasTmp)->B1_ACTDEC+ALLTRIM(STR(aResult[1])))),0.00,0.00,0.00,aResult[5],0.00})
							ELSEIF (cAliasA)->A1_TIPO="E"
							  	AADD(aResumoPro,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,aResult[2],aResult[3],aResult[4],(cAliasTmp)->B1_COD,aResult[1],(cAliasA)->A1_TIPO,(IF((cAliasA)->F3_ESPECIE<>"NCC" .AND. (cAliasA)->F3_ESPECIE<>"NDE","F2","F1")+((cAliasTmp)->B1_ACTDEC+ALLTRIM(STR(aResult[1])))),0.00,0.00,0.00,0.00,aResult[5]})
							EndIf
						EndIf
						
					EndIF
				EndIF
					 
				( cAliasTmp )->(DbSkip())
			EndDo
			( cAliasTmp )->(dbCloseArea())
		EndIf
	Else
		If Len(aResumoIVA)=0
		   IF (cAliasA)->A1_TIPO="I"
			  AADD(aResumoIVA,{nBIVA,nIVA,nIVAP,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,(cAliasA)->F3_CFO,nALiqIVA,(cAliasA)->A1_TIPO,(IF(F3_ESPECIE<>"NCC" .AND.F3_ESPECIE<>"NDE","F2","F1")+((cAliasA)->F3_CFO+ALLTRIM(STR(nALiqIVA))))})
			 ELSEIF (cAliasA)->A1_TIPO="N"
			  AADD(aResumoIVA,{0.00 ,0.00,0.00 ,nBIVA,nIVA,nIVAP,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,(cAliasA)->F3_CFO,nALiqIVA,(cAliasA)->A1_TIPO,(IF(F3_ESPECIE<>"NCC" .AND.F3_ESPECIE<>"NDE","F2","F1")+((cAliasA)->F3_CFO+ALLTRIM(STR(nALiqIVA))))})
			 ELSEIF (cAliasA)->A1_TIPO$"X|F" .OR. (cAliasA)->A1_TIPO="S"
			  AADD(aResumoIVA,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,nBIVA,nIVA,nIVAP,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,(cAliasA)->F3_CFO,nALiqIVA,(cAliasA)->A1_TIPO,(IF(F3_ESPECIE<>"NCC" .AND.F3_ESPECIE<>"NDE","F2","F1")+((cAliasA)->F3_CFO+ALLTRIM(STR(nALiqIVA))))})
			 ELSEIF (cAliasA)->A1_TIPO="M"
			  AADD(aResumoIVA,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,nBIVA,nIVA,nIVAP,0.00 ,0.00,0.00 ,(cAliasA)->F3_CFO,nALiqIVA,(cAliasA)->A1_TIPO,(IF(F3_ESPECIE<>"NCC" .AND.F3_ESPECIE<>"NDE","F2","F1")+((cAliasA)->F3_CFO+ALLTRIM(STR(nALiqIVA))))})
			 ELSEIF (cAliasA)->A1_TIPO="E"
			  AADD(aResumoIVA,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,nBIVA,nIVA,nIVAP,(cAliasA)->F3_CFO,nALiqIVA,(cAliasA)->A1_TIPO,(IF(F3_ESPECIE<>"NCC" .AND.F3_ESPECIE<>"NDE","F2","F1")+((cAliasA)->F3_CFO+ALLTRIM(STR(nALiqIVA))))})
		   ENDIF
		 ELSE
		   IF(F3_ESPECIE<>"NCC" .AND.F3_ESPECIE<>"NDE",y:=ASCAN(aResumoIVA,{|x| x[19]==("F2"+(cAliasA)->F3_CFO+ALLTRIM(STR(nALiqIVA)))}),y:=ASCAN(aResumoIVA,{|x| x[19]==("F1"+(cAliasA)->F3_CFO+ALLTRIM(STR(nALiqIVA)))}))
		   IF Y<>0 
			  IF (cAliasA)->A1_TIPO="I"
				 aResumoIVA[Y][1]+=nBIVA
				 aResumoIVA[Y][2]+=nIVA
				 aResumoIVA[Y][3]+=nIVAP
				ELSEIF (cAliasA)->A1_TIPO="N"
				 aResumoIVA[Y][4]+=nBIVA
				 aResumoIVA[Y][5]+=nIVA
				 aResumoIVA[Y][6]+=nIVAP
				ELSEIF (cAliasA)->A1_TIPO$"X|F" .OR. (cAliasA)->A1_TIPO="S"
				 aResumoIVA[Y][7]+=nBIVA
				 aResumoIVA[Y][8]+=nIVA
				 aResumoIVA[Y][9]+=nIVAP
				ELSEIF (cAliasA)->A1_TIPO="M"
				 aResumoIVA[Y][10]+=nBIVA
				 aResumoIVA[Y][11]+=nIVA
				 aResumoIVA[Y][12]+=nIVAP
				ELSEIF (cAliasA)->A1_TIPO="E"
				 aResumoIVA[Y][13]+=nBIVA
				 aResumoIVA[Y][14]+=nIVA
				 aResumoIVA[Y][15]+=nIVAP
			  ENDIF         
			 ELSE 
			  IF (cAliasA)->A1_TIPO="I"
				 AADD(aResumoIVA,{nBIVA,nIVA,nIVAP,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,(cAliasA)->F3_CFO,nALiqIVA,(cAliasA)->A1_TIPO,(IF(F3_ESPECIE<>"NCC" .AND.F3_ESPECIE<>"NDE","F2","F1")+((cAliasA)->F3_CFO+ALLTRIM(STR(nALiqIVA))))})
				ELSEIF (cAliasA)->A1_TIPO="N"
				 AADD(aResumoIVA,{0.00 ,0.00,0.00 ,nBIVA,nIVA,nIVAP,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,(cAliasA)->F3_CFO,nALiqIVA,(cAliasA)->A1_TIPO,(IF(F3_ESPECIE<>"NCC" .AND.F3_ESPECIE<>"NDE","F2","F1")+((cAliasA)->F3_CFO+ALLTRIM(STR(nALiqIVA))))})
				ELSEIF (cAliasA)->A1_TIPO$"X|F" .OR. (cAliasA)->A1_TIPO="S"
				 AADD(aResumoIVA,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,nBIVA,nIVA,nIVAP,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,(cAliasA)->F3_CFO,nALiqIVA,(cAliasA)->A1_TIPO,(IF(F3_ESPECIE<>"NCC" .AND.F3_ESPECIE<>"NDE","F2","F1")+((cAliasA)->F3_CFO+ALLTRIM(STR(nALiqIVA))))})
				ELSEIF (cAliasA)->A1_TIPO="M"
				 AADD(aResumoIVA,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,nBIVA,nIVA,nIVAP,0.00 ,0.00,0.00 ,(cAliasA)->F3_CFO,nALiqIVA,(cAliasA)->A1_TIPO,(IF(F3_ESPECIE<>"NCC" .AND.F3_ESPECIE<>"NDE","F2","F1")+((cAliasA)->F3_CFO+ALLTRIM(STR(nALiqIVA))))})
				ELSEIF (cAliasA)->A1_TIPO="E"
				 AADD(aResumoIVA,{0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,0.00 ,0.00,0.00 ,nBIVA,nIVA,nIVAP,(cAliasA)->F3_CFO,nALiqIVA,(cAliasA)->A1_TIPO,(IF(F3_ESPECIE<>"NCC" .AND.F3_ESPECIE<>"NDE","F2","F1")+((cAliasA)->F3_CFO+ALLTRIM(STR(nALiqIVA))))})
			  ENDIF         
		   ENDIF
		ENDIF
	EndIf
Endif

//TOTALES GENERALES PARA CONTROL GLOBAL DEL IVA
IF (cAliasA)->A1_TIPO="E"
   IF Len(aTVariosIVA)=0
      AADD(aTVariosIVA,{nContabil,nBIVA,nTotEXEN,nIVA,nIVAP,nIBP,nTotOtros,nEXCL,nAliqIVA,STR0021}) //"Estrangeiros"
      aSTipos[1]+=nContabil
	  aSTipos[2]+=nBIVA
	  aSTipos[3]+=nTotEXEN
	  aSTipos[4]+=nIVA
	  aSTipos[5]+=nIVAP
	  aSTipos[6]+=nIBP
	  aSTipos[7]+= (nTotOtros+nEXCL)
	 Else
      nPosiASCAN:=ASCAN(aTVariosIVA,{|x| x[9]==nALiqIVA})
      If nPosiASCAN#0
	     aTVariosIVA[nPosiASCAN,ncolTot  ]+=nContabil
	 	 aTVariosIVA[nPosiASCAN,nColGra  ]+=nBIVA
	  	 aTVariosIVA[nPosiASCAN,nColExen ]+=nTotEXEN
	  	 aTVariosIVA[nPosiASCAN,nColIVA  ]+=nIVA
	  	 aTVariosIVA[nPosiASCAN,nColIVAP ]+=nIVAP
	  	 aTVariosIVA[nPosiASCAN,nColIBP  ]+=nIBP
	  	 aTVariosIVA[nPosiASCAN,nColOtros]+= (nTotOtros+nEXCL)
         aSTipos[1]+=nContabil
	     aSTipos[2]+=nBIVA
	     aSTipos[3]+=nTotEXEN
	     aSTipos[4]+=nIVA
	     aSTipos[5]+=nIVAP
	     aSTipos[6]+=nIBP
	     aSTipos[7]+= (nTotOtros+nEXCL)
	  	Else
	  	 AADD(aTVariosIVA,{nContabil,nBIVA,nTotEXEN,nIVA,nIVAP,nIBP,nTotOtros,nEXCL,nAliqIVA,STR0021}) //"Estrangeiros"
         aSTipos[1]+=nContabil
	     aSTipos[2]+=nBIVA
	     aSTipos[3]+=nTotEXEN
	     aSTipos[4]+=nIVA
	     aSTipos[5]+=nIVAP
	     aSTipos[6]+=nIBP
	     aSTipos[7]+=(nTotOtros+nEXCL)
	  Endif
   Endif	  
  Else
   IF Len(aTLocalIVA)=0
      AADD(aTLocalIVA,{nContabil,nBIVA,nTotEXEN,nIVA,nIVAP,nIBP,nTotOtros,nEXCL,nAliqIVA,STR0022}) //"Nacionais"
      aSTipos[1]+=nContabil
      aSTipos[2]+=nBIVA
      aSTipos[3]+=nTotEXEN
      aSTipos[4]+=nIVA
      aSTipos[5]+=nIVAP
      aSTipos[6]+=nIBP
      aSTipos[7]+=(nTotOtros+nEXCL)
	 Else
      nPosiASCAN:=ASCAN(aTLocalIVA,{|x| x[9]==nALiqIVA})
      If nPosiASCAN#0
	     aTLocalIVA[nPosiASCAN,ncolTot  ]+=nContabil
	 	 aTLocalIVA[nPosiASCAN,nColGra  ]+=nBIVA
	  	 aTLocalIVA[nPosiASCAN,nColExen ]+=nTotEXEN
	  	 aTLocalIVA[nPosiASCAN,nColIVA  ]+=nIVA
	  	 aTLocalIVA[nPosiASCAN,nColIVAP ]+=nIVAP
	  	 aTLocalIVA[nPosiASCAN,nColIBP  ]+=nIBP
	  	 aTLocalIVA[nPosiASCAN,nColOtros]+=(nTotOtros+nEXCL)
         aSTipos[1]+=nContabil
	     aSTipos[2]+=nBIVA
	     aSTipos[3]+=nTotEXEN
	     aSTipos[4]+=nIVA
	     aSTipos[5]+=nIVAP
	     aSTipos[6]+=nIBP
	     aSTipos[7]+= (nTotOtros+nEXCL)
	  	Else
	  	 AADD(aTLocalIVA,{nContabil,nBIVA,nTotEXEN,nIVA,nIVAP,nIBP,nTotOtros,nEXCL,nAliqIVA,STR0022}) //"Nacionais"
         aSTipos[1]+=nContabil
	     aSTipos[2]+=nBIVA
	     aSTipos[3]+=nTotEXEN
	     aSTipos[4]+=nIVA
	     aSTipos[5]+=nIVAP
	     aSTipos[6]+=nIBP
	     aSTipos[7]+=(nTotOtros+nEXCL)
	  Endif
   Endif	  
Endif      
Return (nTotEXEN)

/*****************************************************************************************/
//FUNÇOES UTILIZADAS NO BLOCO DE CODIGO EM "oSection:Cell("nExenNoGrav"):SetBlock({|| })"//
//sfBaseIVA() / sfVrIVA() / sfVrIVAP() / sfVrIB() / sfVrEXCL()
//Soma das colunas de forma dinamica atraves dos arrays de cada imposto
//aColIVA{}  = Armazena o nro das colunas IVA no SF3 conforme cadastro no SFB
//aColIVAP{} = Armazena o nro das colunas IVAp no SF3 conforme cadastro no SFB
//aColIB{}   = Armazena o nro das colunas IB no SF3 conforme cadastro no SFB
//aaColEXCL{}= Armazena o nro das colunas Impostos INTERNOS no SF3 conforme cadastro no SFB
/*****************************************************************************************/
STATIC FUNCTION sfAliqIVA() //FUNÇÃO DE RETORNO COLUNA VALOR ALIQ IVA
Local nResult:=0
Local nI
Local nPosFil := aScan( aConfSFB,{|x| x[1] == (cAliasA)->SUCURSAL} )
If nPosFil <> 0
	For nI=1 to Len(aConfSFB[nPosFil][5])
	    If nResult=0
	       cResult="(cAliasA)->F3_ALQIMP"+aConfSFB[nPosFil][5][nI]//aColIVA[nI]
	       nResult+=&cResult
	    Endif   
	Next 
	IF !Empty((cAliasA)->F3_DTCANC) .And. MV_PAR03 == 3 
	   nResult := 0
	Endif
EndIf	 
Return(nResult)

STATIC FUNCTION sfBaseIVA() //FUNÇÃO DE RETORNO COLUNA VALOR BASE IVA
Local nResult:=0
Local nI        
Local nSinal:= 1
Local nPosFil := aScan( aConfSFB,{|x| x[1] == (cAliasA)->SUCURSAL} )
Local cIvExc := ""
Local nIvExc := 0

If nPosFil <> 0
	For nI=1 to Len(aConfSFB[nPosFil][5])
	    cIvExc := "(cAliasA)->F3_ALQIMP"+aConfSFB[nPosFil][5][nI]
		nIvExc := &cIvExc
	    If nResult == 0 .And. nIvExc > 0
	       cResult := "(cAliasA)->F3_BASIMP"+aConfSFB[nPosFil][5][nI]//aColIVA[nI]
	       nResult+=&cResult
	    Endif   
	Next 
	If Alltrim(( cAliasA )->F3_ESPECIE) $ "NCC|NDE"
		nSinal:=-1
	EndIf                    
	nContab:= ( cAliasA )->F3_VALCONT*nSinal
	IF !Empty((cAliasA)->F3_DTCANC) .And. MV_PAR03 == 3 
	   nResult := 0
	   nContab := 0
	Endif
EndIF
Return(nResult*nSinal)

STATIC FUNCTION sfVrIVA() //FUNÇÃO DE RETORNO COLUNA VALOR IVA
Local nResult:=0
Local nI        
Local nSinal:= 1
Local nPosFil := aScan( aConfSFB,{|x| x[1] == (cAliasA)->SUCURSAL} )
If nPosFil <> 0
	For nI=1 to Len(aConfSFB[nPosFil][5])
	    cResult="(cAliasA)->F3_VALIMP"+aConfSFB[nPosFil][5][nI]//aColIVA[nI]
	    nResult+=&cResult
	Next 
	If Alltrim(( cAliasA )->F3_ESPECIE) $ "NCC|NDE"
		nSinal:=-1
	EndIf
	IF !Empty((cAliasA)->F3_DTCANC) .And. MV_PAR03 == 3 
	   nResult := 0
	Endif
EndIf   
Return(nResult*nSinal)
    
STATIC FUNCTION sfVrIVAP() //FUNÇÃO DE RETORNO COLUNA VALOR IVAP
Local nResult:=0
Local nI        
Local nSinal:= 1
Local nPosFil := aScan( aConfSFB,{|x| x[1] == (cAliasA)->SUCURSAL} )
If nPosFil <> 0
	For nI=1 to Len(aConfSFB[nPosFil][3])
	    cResult="(cAliasA)->F3_VALIMP"+aConfSFB[nPosFil][3][nI]//aColIVAP[nI]
	    nResult+=&cResult
	Next 
	If Alltrim(( cAliasA )->F3_ESPECIE) $ "NCC|NDE"
		nSinal:=-1
	EndIf
	IF !Empty((cAliasA)->F3_DTCANC) .And. MV_PAR03 == 3 
	   nResult := 0
	Endif
EndIf
Return(nResult*nSinal)

STATIC FUNCTION sfVrIB() //FUNÇÃO DE RETORNO COLUNA VALOR IB
Local nResult:=0
Local nI 
Local nSinal:= 1
Local nPosFil := aScan( aConfSFB,{|x| x[1] == (cAliasA)->SUCURSAL} )
If nPosFil <> 0
	For nI=1 to Len(aConfSFB[nPosFil][6])
	    cResult="(cAliasA)->F3_VALIMP"+aConfSFB[nPosFil][6][nI]//aColIB[nI]
	    nResult+=&cResult
	Next                 
	If Alltrim(( cAliasA )->F3_ESPECIE) $ "NCC|NDE"
		nSinal:=-1
	eNDiF
	IF !Empty((cAliasA)->F3_DTCANC) .And. MV_PAR03 == 3 
	   nResult := 0
	Endif
EndIf
Return(nResult*nSinal)
  
STATIC FUNCTION sfVrEXCL() //FUNÇÃO DE RETORNO COLUNA VALOR EXCL
Local nResult:=0
Local nI        
Local nSinal:= 1
Local nPosFil := aScan( aConfSFB,{|x| x[1] == (cAliasA)->SUCURSAL} )
If nPosFil <> 0
	For nI=1 to Len(aConfSFB[nPosFil][4])
	    cResult="(cAliasA)->F3_VALIMP"+aConfSFB[nPosFil][4][nI]//aColEXCL[nI]
	    nResult+=&cResult
	Next 
	If Alltrim(( cAliasA )->F3_ESPECIE) $ "NCC|NDE"
		nSinal:=-1
	EndIf
	IF !Empty((cAliasA)->F3_DTCANC) .And. MV_PAR03 == 3 
	   nResult := 0
	Endif
EndIf
Return(nResult*nSinal)  

/*Para uso de Actividad Declarada, Producto o Ambos */
STATIC FUNCTION sfAliqIVAD(cPref, cSucursal) //FUNÇÃO DE RETORNO COLUNA VALOR ALIQ IVA
Local nResult:=0
Local nI
Local nPosFil := aScan( aConfSFB,{|x| x[1] == cSucursal} )
If nPosFil <> 0
	For nI=1 to Len(aConfSFB[nPosFil][5])
	    If nResult=0
	       cResult="(cAliasTmp)->"+cPref+"_ALQIMP"+aConfSFB[nPosFil][5][nI]//aColIVA[nI]
	       nResult+=&cResult
	    Endif   
	Next 
	IF !Empty((cAliasA)->F3_DTCANC) .And. MV_PAR03 == 3 
	   nResult := 0
	Endif
EndIf 
Return(nResult)

STATIC FUNCTION sfBaseIVAD(cPref, cSucursal) //FUNÇÃO DE RETORNO COLUNA VALOR BASE IVA
Local nResult:=0
Local nI        
Local nSinal:= 1
Local nPosFil := aScan( aConfSFB,{|x| x[1] == cSucursal} )
Local cIvExc := ""
Local nIvExc := 0

If nPosFil <> 0
	For nI=1 to Len(aConfSFB[nPosFil][5])
		cIvExc := "(cAliasTmp)->"+cPref+"_ALQIMP"+aConfSFB[nPosFil][5][nI]
		nIvExc := &cIvExc
	    If nResult == 0 .And. nIvExc > 0
	       cResult := "(cAliasTmp)->"+cPref+"_BASIMP"+aConfSFB[nPosFil][5][nI]//aColIVA[nI]
	       nResult+=&cResult
	    Endif   
	Next 
	If Alltrim(( cAliasA )->F3_ESPECIE) $ "NCC|NDE"
		nSinal:=-1
	EndIf                    
	IF !Empty((cAliasA)->F3_DTCANC) .And. MV_PAR03 == 3 
	   nResult := 0
	Endif
EndIF
Return(nResult*nSinal)

STATIC FUNCTION sfVrIVAD(cPref, cSucursal) //FUNÇÃO DE RETORNO COLUNA VALOR IVA
Local nResult:=0
Local nI        
Local nSinal:= 1
Local nPosFil := aScan( aConfSFB,{|x| x[1] == cSucursal} )
If nPosFil <> 0
	For nI=1 to Len(aConfSFB[nPosFil][5])
	    cResult="(cAliasTmp)->"+cPref+"_VALIMP"+aConfSFB[nPosFil][5][nI]//aColIVA[nI]
	    nResult+=&cResult
	Next 
	If Alltrim(( cAliasA )->F3_ESPECIE) $ "NCC|NDE"
		nSinal:=-1
	EndIf
	IF !Empty((cAliasA)->F3_DTCANC) .And. MV_PAR03 == 3 
	   nResult := 0
	Endif
EndIf   
Return(nResult*nSinal)
    
STATIC FUNCTION sfVrIVAPD(cPref, cSucursal) //FUNÇÃO DE RETORNO COLUNA VALOR OTROS
Local nResult:=0
Local nI        
Local nSinal:= 1
Local nPosFil := aScan( aConfSFB,{|x| x[1] == cSucursal} )
If nPosFil <> 0
	For nI=1 to Len(aConfSFB[nPosFil][3])
	    cResult="(cAliasTmp)->"+cPref+"_VALIMP"+aConfSFB[nPosFil][3][nI]//aColIVAP[nI]
	    nResult+=&cResult
	Next 
	If Alltrim(( cAliasA )->F3_ESPECIE) $ "NCC|NDE"
		nSinal:=-1
	EndIf
	IF !Empty((cAliasA)->F3_DTCANC) .And. MV_PAR03 == 3 
	   nResult := 0
	Endif
EndIF
Return(nResult*nSinal)

Static Function ObtImpSFB(nLoop, nI)
Local lError  :=.T.
Local I:=0

	DbSelectArea("SFB")
	SFB->(DBGOTOP())
	While !SFB->(EOF())
		If SFB->FB_FILIAL+SFB->FB_CLASSIF+SFB->FB_CLASSE==xFilial("SFB", aSucEmp[nLoop][1][nI])+"1P"  //IB
			If SFB->FB_CLASSE<>"R"
				cColIB    :=SFB->FB_CPOLVRO
				IF(LEN(SFB->FB_CPOLVRO)<>0,lError:=lError,lError:=.F.)
				If Len(aColIB)<>0
					If ASCAN(aColIB,SFB->FB_CPOLVRO)=0
						AADD(aColIB,SFB->FB_CPOLVRO)
					Endif
				Else 
					AADD(aColIB,SFB->FB_CPOLVRO)
				Endif  
			Endif
		Endif
		SFB->(DBSkip())
	Enddo
	
	SFB->(DBGOTOP())
	While !SFB->(EOF())
		If SFB->FB_FILIAL+SFB->FB_CLASSIF+SFB->FB_CLASSE==xFilial("SFB", aSucEmp[nLoop][1][nI])+"3I"  //IVA
			If SFB->FB_CLASSE=="I"
				cColIVA   :=SFB->FB_CPOLVRO
				IF(LEN(SFB->FB_CPOLVRO)<>0,lError:=lError,lError:=.F.)         
				If Len(aColIVA)<>0
					If ASCAN(aColIVA,SFB->FB_CPOLVRO)=0
						AADD(aColIVA,SFB->FB_CPOLVRO)
					Endif
				Else 
					AADD(aColIVA,SFB->FB_CPOLVRO)
				Endif              
			Endif
		Endif
		SFB->(DBSkip())
	Enddo
         
	SFB->(DBGOTOP())
	While !SFB->(EOF())
		If SFB->FB_FILIAL+SFB->FB_CLASSIF+SFB->FB_CLASSE==xFilial("SFB", aSucEmp[nLoop][1][nI])+"3P"  //IVAP
			If SFB->FB_CLASSE=="P"
				cColIVAP  :=SFB->FB_CPOLVRO
				IF(LEN(SFB->FB_CPOLVRO)<>0,lError:=lError,lError:=.F.)         
				If Len(aColIVAP)<>0
					If ASCAN(aColIVAP,SFB->FB_CPOLVRO)=0
						AADD(aColIVAP,SFB->FB_CPOLVRO)
					Endif
				Else 
					AADD(aColIVAP,SFB->FB_CPOLVRO)
				Endif              
			Endif
		Endif                              
		SFB->(DBSkip())
	Enddo 
           
	SFB->(DBGOTOP())
	While !SFB->(EOF())
		If SFB->FB_FILIAL+SFB->FB_CLASSIF+SFB->FB_CLASSE==xFilial("SFB", aSucEmp[nLoop][1][nI])+"2I"  //INTERNOS
			If SFB->FB_CLASSE=="I"
				cColEXCL  :=SFB->FB_CPOLVRO
				IF(LEN(SFB->FB_CPOLVRO)<>0,lError:=lError,lError:=.F.)         
				If Len(aColEXCL)<>0
					If ASCAN(aColEXCL,SFB->FB_CPOLVRO)=0
						AADD(aColEXCL,SFB->FB_CPOLVRO)
					Endif
				Else 
					AADD(aColEXCL,SFB->FB_CPOLVRO)
				Endif              
			Endif
		Endif      
		SFB->(DBSkip())
	Enddo
	
	IF !lError
		Alert(STR0044)
	ENDIF
	
	*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*
	//Busca posicionamento para Outros Impostos 
	//Alimenta o Array de Posicionamento das Colunas em SF3 para outros impostos adicionando as colunas não utilizadas para IVA IVAP e IB
	SFB->(DbGoTop())                        
	While !SFB->(EOF())
		If SFB->FB_CLASSE="R"  
			SFB->(DBSkip())
			LOOP
		Endif
		If ASCAN(aColEXCL,SFB->FB_CPOLVRO)<>0 .or. ASCAN(aColIVA ,SFB->FB_CPOLVRO)<>0 .or. ASCAN(aColIVAP,SFB->FB_CPOLVRO)<>0 .or. ASCAN(aColIB  ,SFB->FB_CPOLVRO)<>0
			SFB->(DBSkip())
			LOOP   
		Endif   
		IF ASCAN(aImpostos,SFB->FB_CPOLVRO)=0
			AADD(aImpostos,SFB->FB_CPOLVRO)
		Endif
		SFB->(DBSkip())
	Enddo   
	
	aAdd(aConfSFB, {aSucEmp[nLoop][1][nI], aImpostos, aColIVAP, aColEXCL, aColIVA, aColIB})
	
	*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*
	//Montagem dos campos necessarios para uso na query 
	For i = 1 to Len(aColIB)
		cLerCampo:="SF3.F3_VALIMP"+aColIB[i]
		cExpC1+=cLerCampo
		if i<Len(aColIB)
			cExpC1=cExpC1+","
		Endif
	Next
	
	For i = 1 to Len(aColIVA)
		cLerCampo:="SF3.F3_VALIMP"+aColIVA[i]
		cExpC2+=cLerCampo+","
		cLerCampo:="SF3.F3_ALQIMP"+aColIVA[i]
		cExpC2+=cLerCampo+","    
		cLerCampo:="SF3.F3_BASIMP"+aColIVA[i]
		cExpC2+=cLerCampo
		if i<Len(aColIVA)
			cExpC2:=cExpC2+","
		Endif
	Next
	
	For i = 1 to Len(aColIVAP)
		cLerCampo:="SF3.F3_VALIMP"+aColIVAP[i]
		cExpC3+=cLerCampo
		if i<Len(aColIVAP)
			cExpC3:=cExpC3+","
		Endif
	Next
	
	For i = 1 to Len(aColEXCL)
		cLerCampo:="SF3.F3_VALIMP"+aColEXCL[i]
		cExpC4+=cLerCampo
		if i<Len(aColEXCL)
			cExpC4:=cExpC4+","
		Endif
	Next 
	
	For i = 1 to Len(aImpostos)
		cLerCampo:="SF3.F3_VALIMP"+aImpostos[i]
		cExpC5+=cLerCampo
		if i<Len(aImpostos)
			cExpC5:=cExpC5+","
		Endif
	Next
	
	If Len(cExpC1)<>0
		cExpCampos:=cExpC1
	Endif
	If Len(cExpC2)<>0
		If Len(cExpCampos)<>0
			cExpCampos+=","+cExpC2
		else
			cExpCampos:=cExpC2
		Endif   
	Endif
	If Len(cExpC3)<>0
		If Len(cExpCampos)<>0
			cExpCampos+=","+cExpC3
		Else
			cExpCampos:=cExpC3
		Endif   
	Endif
	If Len(cExpC4)<>0
		If Len(cExpCampos)<>0
			cExpCampos+=","+cExpC4
		Else
			cExpCampos:=cExpC4
		Endif 
	Endif
	If Len(cExpC5)<>0
		If Len(cExpCampos)<>0
			cExpCampos+=","+cExpC5
		Else
			cExpCampos:=cExpC5
		Endif   
	Endif
	IF LEN(aColIVA)=0
		Alert(STR0045)
		lError:=.F.
	ENDIF   
	IF LEN(aColIVAP)=0
		Alert(STR0046)
		lError:=.F.
	ENDIF   
	IF LEN(aColIB)=0
		Alert(STR0047)
		lError:=.F.
	ENDIF   
Return

Static Function IniTotales()

Local I := 0

	aSx3Box := RetSx3Box( Posicione("SX3", 2, "A1_TIPO", "X3CBox()" ),,, 1 )
	FOR I=1 TO LEN(aSx3Box)
		IF aSx3Box[I][2]<>" "
			AADD(aTotales  ,{0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,aSx3Box[I][2],aSx3Box[I][3] } )                  
		ENDIF
	NEXT
Return

Static Function InitVal()
	
	cA2COD := ""; cA2NOME := "";cA2CGC := "";cA2TIPO := ""
	cColIVA := ""; cColIVAP := ""; cColIB := ""; cColEXCL := ""
	cExpCampos := ""; cExpC1 := ""; cExpC2 := ""; cExpC3 := ""; cExpC4 := ""; cExpC5 := ""
	cF3VrIB := ""; cF3AlqIVA := ""; cF3BaseIVA := ""; cF3VrIVA := ""; cF3VrIVAP := ""; cF3VrEXCL := ""
	cSF3VrIB := ""; cSF3AlqIVA := ""; cSF3BaseIVA := ""; cSF3VrIVA := ""; cSF3VrIVAP := ""; cSF3VrEXCL := ""
	cTF3VrIB := ""; cTF3AlqIVA := ""; cTF3BaseIVA := ""; cTF3VrIVA := ""; cTF3VrIVAP := ""; cTF3VrEXCL := ""

	nTotOtros := 0; nContab := 0; nTotEXEN := 0
	nLinRI := 1; nLinRNI := 2; nLinE := 3; nLinNR := 4; nLinCF := 5; nLinRM := 6
	nColTot := 1; nColGra := 2; nColExen := 3; nColIVA := 4; nColIVAP := 5; nColIBP := 6; nColOtros := 7; nColExcl := 8; nColAliq :=9 

Return

Static Function VldCuitEmp()
Local nPosCuit := 0
Local nLoop := 0
Local aFiliAct := { FWGETCODFILIAL }

	dbSelectArea("SM0")
	dbSetOrder(1)
	
	For nLoop := 1 To Len(aSelFil)
		If SM0->(DbSeek(FwGrpCompany() + aSelFil[nLoop]))
			nPosCuit := aScan( aSucEmp,{|x| x[2] == Alltrim(SM0->M0_CGC)} )
			If nPosCuit == 0
				aAdd(aSucEmp, {{}, Alltrim(SM0->M0_CGC)})
				aAdd(aSucEmp[Len(aSucEmp)][1], aSelFil[nLoop])
			Else
				aAdd(aSucEmp[nPosCuit][1], aSelFil[nLoop])
			EndIf
		EndIf
	Next
	SM0->(DbSeek(FwGrpCompany() + aFiliAct[1]))
Return

Static Function CreaTemp(aTemp,cAliasTemp)
	Local nI := 0 
	Local aOrdem := {}
	
	AADD(aTemp,{ "A1_COD",  "C", FWSX3Util():GetFieldStruct("A1_COD")[3],  FWSX3Util():GetFieldStruct("A1_COD") [4]  }) 
	AADD(aTemp,{ "A1_NOME", "C", FWSX3Util():GetFieldStruct("A1_NOME")[3], FWSX3Util():GetFieldStruct("A1_NOME")[4] })  
	AADD(aTemp,{ "A1_AFIP", "C", FWSX3Util():GetFieldStruct("A1_AFIP")[3], FWSX3Util():GetFieldStruct("A1_AFIP")[4] })  
	AADD(aTemp,{ "A1_CGC",  "C", FWSX3Util():GetFieldStruct("A1_CGC")[3],  FWSX3Util():GetFieldStruct("A1_CGC") [4]  }) 
	AADD(aTemp,{ "A1_TIPO", "C", FWSX3Util():GetFieldStruct("A1_TIPO")[3], FWSX3Util():GetFieldStruct("A1_TIPO")[4] }) 
	
	For nI := 1 To Len(aEstrSF3)
		AADD(aTemp, { aEstrSF3[nI][1], aEstrSF3[nI][2], aEstrSF3[nI][3], aEstrSF3[nI][4] })
	Next
	
	AADD(aTemp,{ "SUCURSAL", "C", FWSX3Util():GetFieldStruct("F3_FILIAL")[3],  FWSX3Util():GetFieldStruct("F3_FILIAL") [4] }) 
	
	If MV_PAR09 == 1
		aOrdem	:=	{"F3_ESPECIE","F3_ENTRADA","F3_SERIE", "F3_NFISCAL", "F3_CFO"}
	Else
		aOrdem	:=	{"F3_ESPECIE","F3_EMISSAO","F3_SERIE", "F3_NFISCAL", "F3_CFO"}
	EndIf
	
	cAliasTemp  := "TMP911A"
	oTmpTable := FWTemporaryTable():New(cAliasTemp) 
	oTmpTable:SetFields( aTemp ) 
	oTmpTable:AddIndex("IN1", aOrdem)
	oTmpTable:Create()

Return

Static Function InitReport()
	
	If Select( cAliasA ) > 0
		dbSelectArea( cAliasA )
		dbCloseArea()
	EndIf
				
	InitVal()
	aCposTmp1 := {}
	aConfSFB  := {}
	aNoGrav   := {{0,0,0,0,0},{0,0,0,0,0}}
	aSTipos   :={ 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00}
	aSTotales :={ 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00}

	aTotales := {}; aResumoIVA := {}; aColIVA := {}; aColIVAP := {}; aColIB := {}; aColEXCL := {}
	aImpostos := {}; aTLocalIVA := {}; aTVariosIVA := {}; aResumoPro := {}; aNFs := {}; aTipo := {}; aTMP := {}

	IniTotales()
	
Return

User Function Compania()
	Local aComp := {}
Return aComp
