/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR015.CH"
#INCLUDE "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR015  ³ Autor ³ Alexandre Inacio Lemes³ Data ³22/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rela‡„o entre NFs Originais X NFs Frete/Importa‡„o.        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MATR015(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Matr015()

Local oReport

TRepInUse()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³Autor  ³Alexandre Inacio Lemes ³Data  ³22/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rela‡„o entre NFs Originais X NFs Frete/Importa‡„o.        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local aOrdem   := {}
Local oReport 
Local oSection1 
Local oSection2 
Local oSection3 
Local oSection4 
Local oCell         
Local cAliasSF8 := GetNextAlias()

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
oReport := TReport():New("MATR015",STR0001,"MTR015", {|oReport| ReportPrint(oReport,cAliasSF8)},STR0002+" "+STR0003+" "+STR0004) //"Este relatorio ira imprimir a relacao entre as notas fiscais de Frete/Importacao e as notas fiscais que originaram as mesmas.
Pergunte("MTR015",.F.)
Aadd( aOrdem, STR0005 ) //"Por NF Frete/Importacao" # "F8_FILIAL+F8_NFDIFRE+F8_SEDIFRE+F8_FORNECE+F8_LOJA"
Aadd( aOrdem, STR0006 ) //"Por NF Original"         # "F8_FILIAL+F8_NFORIG+F8_SERORIG+F8_FORNECE+F8_LOJA"
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
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New(oReport,STR0022,{"SF8","SF1"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/) //"Carga"
TRCell():New(oSection1,"F8_NFDIFRE","SF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,SerieNfId("SF8",3,"F8_SEDIFRE"),"SF8",SerieNfId("SF8",7,"F8_SEDIFRE"),/*Picture*/,SerieNfId("SF8",6,"F8_SEDIFRE"),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"F8_FORNECE","SF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"F8_LOJA"   ,"SF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"F8_TIPO"   ,"SF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIF((cAliasSF8)->F8_TIPO == "F",OemToAnsi(STR0020),OemToAnsi(STR0021)) })

oSection2 := TRSection():New(oSection1,STR0023,{"SF8","SF1"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/) //"Carga"
TRCell():New(oSection2,"F8_NFORIG" ,"SF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,SerieNfId("SF8",3,"F8_SERORIG"),"SF8",SerieNfId("SF8",7,"F8_SERORIG"),/*Picture*/,SerieNfId("SF8",6,"F8_SERORIG"),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"F1_EMISSAO","SF1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection3:= TRSection():New(oReport,STR0024,{"SF8","SF1"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/) //"Carga"
TRCell():New(oSection3,"F8_NFORIG" ,"SF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,SerieNfId("SF8",3,"F8_SERORIG"),"SF8",SerieNfId("SF8",7,"F8_SERORIG"),/*Picture*/,SerieNfId("SF8",6,"F8_SERORIG"),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"F8_FORNECE","SF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"F8_LOJA"   ,"SF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection4 := TRSection():New(oSection3,STR0025,{"SF8","SF1"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/) //"Carga"
TRCell():New(oSection4,"F8_NFDIFRE","SF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,SerieNfId("SF8",3,"F8_SEDIFRE"),"SF8",SerieNfId("SF8",7,"F8_SEDIFRE"),/*Picture*/,SerieNfId("SF8",6,"F8_SEDIFRE"),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"F1_EMISSAO","SF1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"F8_TIPO"   ,"SF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIF((cAliasSF8)->F8_TIPO == "F",OemToAnsi(STR0020),OemToAnsi(STR0021)) })

oSection1:SetHeaderPage()
oSection2:SetHeaderPage()
oSection3:SetHeaderPage()
oSection4:SetHeaderPage()

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³Autor  ³Alexandre Inacio Lemes ³Data  ³19/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime o Relatorio definido pela funcao ReportDef MATR190. ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cAliasSF8)

Local oSection1 := oReport:Section(1) 
Local oSection2 := oReport:Section(1):Section(1)  

Local oSection3 := oReport:Section(2) 
Local oSection4 := oReport:Section(2):Section(1)  

Local nOrdem    := oReport:Section(1):GetOrder()

Local cNFE      := ""
Local cQuery    := ""
Local cQuebra   := "" 
LOCAL cSF8FilUsr:= ""
LOCAL cSF1FilUsr:= ""
LOCAL cIDWhere  := ""

If Len(oReport:Section(1):GetAdvplExp("SF1")) > 0     
	cSF1FilUsr   := oReport:Section(1):GetAdvplExp("SF1")
EndIf

If Len(oReport:Section(1):GetAdvplExp("SF8")) > 0     
	cSF8FilUsr   := oReport:Section(1):GetAdvplExp("SF8")
EndIf     

If Len(oReport:Section(2):GetAdvplExp("SF1")) > 0     
	cSF1FilUsr   := oReport:Section(2):GetAdvplExp("SF1")
EndIf

If Len(oReport:Section(2):GetAdvplExp("SF8")) > 0  
	cSF8FilUsr   := oReport:Section(2):GetAdvplExp("SF8")
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SF8")
dbSetOrder(nOrdem)

If nOrdem == 1
	cQuebra := "F8_NFDIFRE+F8_SEDIFRE+F8_FORNECE+F8_LOJA"
	oSection3:Disable()
	oSection4:Disable()
Else
	cQuebra := "F8_NFORIG+F8_SERORIG+F8_FORNECE+F8_LOJA"
	oSection1:Disable()
	oSection2:Disable()
EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao SQL                            ³	
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr(oReport:uParam)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query do relatório da secao 1                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nOrdem == 1
		oReport:Section(1):BeginQuery()	
	Else
		oReport:Section(2):BeginQuery()	
	Endif	
	
	cQuery :="%"
	If mv_par01 == 1 
		cQuery += "AND F8_TIPO = 'F' "	
	ElseIf mv_par01 == 2
		cQuery += "AND F8_TIPO = 'D' "	
	Endif
	cQuery +="%"	

	If nOrdem == 1
		cIdWhere:="%"
		cIdWhere+=SerieNfId("SF8",3,"F8_SEDIFRE")+" >= '"+mv_par04+"' AND " 
		cIdWhere+=SerieNfId("SF8",3,"F8_SEDIFRE")+" <= '"+mv_par05+"' AND"
		cIdWhere+="%" 
		
		BeginSql Alias cAliasSF8
		SELECT SF8.*
		
		FROM %table:SF8% SF8 
		
		WHERE F8_FILIAL = %xFilial:SF8% AND 
			F8_NFDIFRE >= %Exp:mv_par02% AND 
			F8_NFDIFRE <= %Exp:mv_par03% AND 
			%Exp:cIdWhere%
			SF8.%notDel%
			%Exp:cQuery%
			
		ORDER BY %Order:SF8% 
				
		EndSql 
	Else
		cIdWhere:="%"
		cIdWhere+=SerieNfId("SF8",3,"F8_SERORIG")+" >= '"+mv_par04+"' AND " 
		cIdWhere+=SerieNfId("SF8",3,"F8_SERORIG")+" <= '"+mv_par05+"' AND"
		cIdWhere+="%"
	
		BeginSql Alias cAliasSF8
		SELECT SF8.*
		
		FROM %table:SF8% SF8
		
		WHERE F8_FILIAL = %xFilial:SF8% AND 
			F8_NFORIG  >= %Exp:mv_par02% AND 
			F8_NFORIG  <= %Exp:mv_par03% AND 
			%Exp:cIdwhere%
			SF8.%notDel%
			%Exp:cQuery%
			
		ORDER BY %Order:SF8% 
				
		EndSql 
	EndIf		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Metodo EndQuery ( Classe TRSection )                                    ³
	//³                                                                        ³
	//³Prepara o relatório para executar o Embedded SQL.                       ³
	//³                                                                        ³
	//³ExpA1 : Array com os parametros do tipo Range                           ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nOrdem == 1
		oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)
	    oSection2:SetParentQuery()
	Else
		oReport:Section(2):EndQuery(/*Array com os parametros do tipo Range*/)
	    oSection4:SetParentQuery()
	Endif	
    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo TrPosition()                                                     ³
//³                                                                        ³
//³Posiciona em um registro de uma outra tabela. O posicionamento será     ³
//³realizado antes da impressao de cada linha do relatório.                ³
//³                                                                        ³
//³                                                                        ³
//³ExpO1 : Objeto Report da Secao                                          ³
//³ExpC2 : Alias da Tabela                                                 ³
//³ExpX3 : Ordem ou NickName de pesquisa                                   ³
//³ExpX4 : String ou Bloco de código para pesquisa. A string será macroexe-³
//³        cutada.                                                         ³
//³                                                                        ³				
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

TRPosition():New(oSection2,"SF1",1,{|| xFilial("SF1") + (cAliasSF8)->F8_NFDIFRE+(cAliasSF8)->F8_SEDIFRE+(cAliasSF8)->F8_TRANSP+(cAliasSF8)->F8_LOJTRAN})
TRPosition():New(oSection4,"SF1",1,{|| xFilial("SF1") + (cAliasSF8)->F8_NFORIG + (cAliasSF8)->F8_SERORIG + (cAliasSF8)->F8_FORNECE + (cAliasSF8)->F8_LOJA})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter(SF8->(LastRec()))

If nOrdem == 1
	oSection1:Init()
	oSection2:Init()
Else
	oSection3:Init()
	oSection4:Init()
EndIf

dbSelectArea(cAliasSF8)
While !oReport:Cancel() .And. !(cAliasSF8)->(Eof())

	If oReport:Cancel()
		Exit
	EndIf                                     
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro de usuario para secao 1 ou 2                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     
	If !Empty(cSF8FilUsr) 
		If !(&(cSF8FilUsr))
			(cAliasSF8)->(dbSkip())
	  		Loop
  		EndIf
	EndIf    
	
	If !Empty(cSF1FilUsr)         
		dbSelectArea("SF1")
		dbSetOrder(1)
		SF1->(dbSeek(xFilial("SF1")+(cAliasSF8)->F8_NFORIG+(cAliasSF8)->F8_SERORIG+(cAliasSF8)->F8_FORNECE+(cAliasSF8)->F8_LOJA))
		If !(SF1->&(cSF1FilUsr))
			(cAliasSF8)->(dbSkip())
	  		Loop
  		EndIf
  		dbSelectArea(cAliasSF8)
	EndIf    
	
    If &(cQuebra) <> cNFE 
		If nOrdem == 1
			dbselectarea("SF1")
			dbsetorder(1)
			SF1->(dbseek(xfilial("SF1")+(cAliasSF8)->F8_NFDIFRE + (cAliasSF8)->F8_SEDIFRE + (cAliasSF8)->F8_TRANSP + (cAliasSF8)->F8_LOJTRAN))
		 	oSection1:PrintLine()
		 	oSection2:PrintLine()	
			cNFE := (cAliasSF8)->F8_NFDIFRE+(cAliasSF8)->F8_SEDIFRE+(cAliasSF8)->F8_TRANSP+(cAliasSF8)->F8_LOJTRAN
		Else
		   	dbselectarea("SF1")
			dbsetorder(1)
			SF1->(dbseek(xfilial("SF1")+(cAliasSF8)->F8_NFORIG + (cAliasSF8)->F8_SERORIG +(cAliasSF8)->F8_FORNECE+(cAliasSF8)->F8_LOJA))
		 	oSection3:PrintLine()
		 	oSection4:PrintLine()
			cNFE := (cAliasSF8)->F8_NFORIG+(cAliasSF8)->F8_SERORIG+(cAliasSF8)->F8_FORNECE+(cAliasSF8)->F8_LOJA
		EndIf				
	Else	
		If nOrdem == 1
	 		oSection2:PrintLine()
        Else 
		 	oSection4:PrintLine()        
        EndIf
	EndIf
	    
   	DbSelectArea(cAliasSF8)
   	DbSkip()

    If &(cQuebra) <> cNFE 
		oReport:SkipLine()
		oReport:ThinLine() 
    EndIf
    
	oReport:IncMeter()
  
EndDo

oSection1:Finish()
oSection2:Finish()
oSection3:Finish()
oSection4:Finish()

(cAliasSF8)->(DbCloseArea())

Return NIL
