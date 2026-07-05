/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR490.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR	23
#DEFINE TAM_NUMERO Len(CT2->(CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_LINHA))

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR490  ³ Autor ³ Simone Mie SAto       ³ Data ³ 11.05.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao do Razao por Classe de Valor                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CTBR490R3(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR490(cCLVLIni, cCLVLFim,dDataIni, dDataFim, cMoeda, cSaldo,;
			cBook, cContaIni, cContaFim, lCusto, cCustoIni, cCustoFim, lItem,;
	  		cItemIni, cItemFim,lSalLin,aSelFil)
	  		
Local lExterno		:= cCLVLIni <> Nil
Local aArea			:= GetArea()
Local lOk 			:= .T.	
Private NomeProg	:= "CTBR490"
Private cPerg		:= "CTR490"
Private lSaltLin  := .T.

DEFAULT aSelFil 	:= {}
DEFAULT lCusto		:= .T.
DEFAULT lItem		:= .T.
DEFAULT lSalLin	:= .T.


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01            // Da Classe de Valor                    ³
//³ mv_par02            // Ate a Classe de Valor                 ³
//³ mv_par03            // da data                               ³
//³ mv_par04            // Ate a data                            ³
//³ mv_par05            // Moeda			                     ³   
//³ mv_par06            // Saldos		                         ³   
//³ mv_par07            // Set Of Books                          ³
//³ mv_par08            // Analitico ou Resumido dia (resumo)    ³
//³ mv_par09            // Imprime conta sem movimento?          ³
//³ mv_par10            // Imprime Cod (Normal / Reduzida)       ³
//³ mv_par11            // Totaliza tb por Conta?                ³
//³ mv_par12            // Da Conta                              ³
//³ mv_par13            // Ate a Conta                           ³
//³ mv_par14            // Imprime Centro de Custo?		         ³	
//³ mv_par15            // Do Centro de Custo                    ³
//³ mv_par16            // Ate o Centro de Custo                 ³
//³ mv_par17            // Imprime Item?                         ³	
//³ mv_par18            // Do Item                               ³
//³ mv_par19            // Ate o Item                            ³
//³ mv_par20            // Salta folha por Classe de Valor?      ³
//³ mv_par21            // Pagina Inicial                        ³
//³ mv_par22            // Pagina Final                          ³
//³ mv_par23            // Numero da Pag p/ Reiniciar            ³	   
//³ mv_par24            // Imprime Cod. CCusto(Normal/Reduzido)  ³
//³ mv_par25            // Imprime Cod. Item (Normal/Reduzido)   ³
//³ mv_par26            // Imprime Cod. Cl.Valor(Normal/Reduzido)³	   	   
//³ mv_par27            // Imprime Valor 0.00					 ³	   	   
//³ mv_par29            // Seleciona filiais ?				        ³	   	   
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


dbSelectArea("CT1")
dbSelectArea("CT2")
dbSelectArea("CTT")
dbSelectArea("CTD")
dbSelectArea("CTH")

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	lOk := .F.
EndIf

If lOk
	If !lExterno
		If ! Pergunte(cPerg, .T. )
			lOk := .F.
		Endif
		// Se aFil nao foi enviada, exibe tela para selecao das filiais
		If lOk .And. mv_par29 == 1 .And. Len( aSelFil ) <= 0
			aSelFil := AdmGetFil()
			If Len( aSelFil ) <= 0
				lOk := .F.
			EndIf 
		EndIf     
	Else 
		Pergunte(cPerg, .F.)
	Endif
	                      
	//Verifica se o relatorio foi chamado a partir de outro programa. Ex. CTBC490
	If !lExterno
		lCusto	:= Iif(mv_par14 == 1,.T.,.F.)
		lItem	:= Iif(mv_par17 == 1,.T.,.F.)
	Else //Caso seja externo, atualiza os parametros do relatorio com os dados passados como parametros.
	   mv_par01 := cClVlIni 
		mv_par02 := cClVlFim
		mv_par03 := dDataIni
		mv_par04 := dDataFim
		mv_par05 := cMoeda
		mv_par06 := cSaldo
		mv_par07 := cBook
		mv_par12 := cContaIni
		mv_par13 := cContaFim
		mv_par14 := If(lCusto =.T.,1,2)
		mv_par15 := cCustoIni
		mv_par16 := cCustoFim
		mv_par17 := If(lItem =.T.,1,2)
		mv_par18 := cItemIni
		mv_par19 := cItemFim
		MV_PAR28 := Iif(lSalLin == .T.,1,2)
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se usa Set Of Books -> Conf. da Mascara / Valores   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Ct040Valid(mv_par07)
		lOk := .F.
	Else
		aSetOfBook := CTBSetOf(mv_par07)
	EndIf
	
	If lOk 
		aCtbMoeda  	:= CtbMoeda(mv_par05)
	   If Empty(aCtbMoeda[1])
	      Help(" ",1,"NOMOEDA")
	      lOk := .F.
	   Endif
	Endif
EndIf

If lOk	
	U_CTBR490R4(cCLVLIni, cCLVLFim,dDataIni, dDataFim, cMoeda, cSaldo,;
			cBook, cContaIni, cContaFim, lCusto, cCustoIni, cCustoFim, lItem,;
			cItemIni, cItemFim,lSalLin,aSelFil)	
EndIf

If Select("cArqTmp") > 0
	dbSelectArea("cArqTmp")
	Set Filter To
	dbCloseArea()
EndIf

//Limpa os arquivos temporários 
CtbRazClean()

RestArea(aArea)

Return              

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR490R4 ºAutor  ³Paulo Carnelossi    º Data ³  15/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Construcao Release 4                                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CTBR490R4(cCLVLIni, cCLVLFim,dDataIni, dDataFim, cMoeda, cSaldo,;
			cBook, cContaIni, cContaFim, lCusto, cCustoIni, cCustoFim, lItem,;
	  		cItemIni, cItemFim,lSalLin,aSelFil)

Local oReport := Nil
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef(cCLVLIni, cCLVLFim,dDataIni, dDataFim, cMoeda, cSaldo,;
			cBook, cContaIni, cContaFim, lCusto, cCustoIni, cCustoFim, lItem,;
	  		cItemIni, cItemFim,lSalLin,aSelFil)

oReport:PrintDialog()

oReport := Nil
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Paulo Carnelossi    º Data ³  15/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Definicao das colunas do relatorio (R4)                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef(cCLVLIni, cCLVLFim,dDataIni, dDataFim, cMoeda, cSaldo,;
			cBook, cContaIni, cContaFim, lCusto, cCustoIni, cCustoFim, lItem,;
	  		cItemIni, cItemFim,lSalLin,aSelFil)

Local aArea			:= GetArea()
Local cSayCusto	:= CtbSayApro("CTT")
Local cSayItem		:= CtbSayApro("CTD")
Local cSayClVl		:= CtbSayApro("CTH")
Local cString		:= "CT2"

Local cTitulo		:= STR0006 + Alltrim(cSayClVl)	//"Emissao do Razao Contabil por Classe de Valor"
Local cDesc1		:= STR0001 + Alltrim(cSayClVl) 	//"Este programa ira imprimir o Razao por "
Local cDesc2		:= STR0002	//" de acordo com os parametros sugeridos pelo usuario. "
Local cDesc3		:= ""
Local nTamCel		:= 0

Local oReport
Local oRazao, oClValor, oConta, oTotais, oComplemento

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
oReport := TReport():New("CTBR490",cTitulo, cPerg, ;
			{|oReport| If(!Ct040Valid(mv_par07), ;
									oReport:CancelPrint(), ;
									ReportPrint(oReport, cSayCusto, cSayItem, cSayClVl, cString, cTitulo, ;
									cCLVLIni, cCLVLFim,dDataIni, dDataFim, cMoeda, cSaldo,;
									cBook, cContaIni, cContaFim, lCusto, cCustoIni, cCustoFim, lItem,;
							  		cItemIni, cItemFim,lSalLin,aSelFil) ) }, ;
									cDesc1+CRLF+cDesc2+CRLF+cDesc3 )
oReport:ParamReadOnly()
oReport:SetLandScape()
oReport:SetTotalInLine(.F.)

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
oRazao := TRSection():New(oReport, Capital(STR0007)+" "+Alltrim(cSayClVl), {"CT2","cArqTmp"},  /*{}*/, .F., .F.)  //STR0007 "RAZAO POR "
oRazao:SetLinesBefore(0)
TRCell():New(oRazao,"CLN_DATA"				,"",STR0028 /*Titulo*/,/*Picture*/,11/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,"LEFT",,"LEFT")//"DATA"
TRCell():New(oRazao,"CLN_NUMERO"			,"",STR0029 /*Titulo*/,/*Picture*/,TAM_NUMERO/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)//"LOTE/SUB/DOC/LINHA"
TRCell():New(oRazao,"CLN_HISTORICO"			,"",STR0030 /*Titulo*/,/*Picture*/,40/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)//"HISTORICO"
TRCell():New(oRazao,"CLN_CONTRA_PARTIDA"	,"",STR0031 /*Titulo*/,/*Picture*/,Len(CT1->CT1_CONTA)/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)//"C/PARTIDA"
TRCell():New(oRazao,"CLN_CENTRO_CUSTO"		,"",Upper(cSayCusto)/*Titulo*/,/*Picture*/,Len(CTT->CTT_CUSTO)+3/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oRazao,"CLN_ITEM_CONTABIL"		,"",Upper(cSayItem)/*Titulo*/,/*Picture*/,Len(CTD->CTD_ITEM)/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oRazao,"CLN_VLR_DEBITO"		,"",STR0032 /*Titulo*/,/*Picture*/,TAM_VALOR/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,/*"RIGHT"*/,,"RIGHT") //"DEBITO"
TRCell():New(oRazao,"CLN_VLR_CREDITO"		,"",STR0033 /*Titulo*/,/*Picture*/,TAM_VALOR/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,/*"RIGHT"*/,,"RIGHT")//"CREDITO"
TRCell():New(oRazao,"CLN_VLR_SALDO"			,"",STR0034/*Titulo*/,/*Picture*/ ,IIF(lIsRedStor,TAM_VALOR+2,TAM_VALOR)/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,/*"RIGHT"*/,,"RIGHT") //"SALDO ATUAL"


oRazao:Cell("CLN_VLR_DEBITO"):lHeaderSize  := .F.
oRazao:Cell("CLN_VLR_CREDITO"):lHeaderSize := .F.
oRazao:Cell("CLN_VLR_SALDO"):lHeaderSize   := .F.

oRazao:Cell("CLN_HISTORICO"):SetLineBreak()
oRazao:SetHeaderPage()

oClValor := TRSection():New(oReport, Alltrim(cSayClVl), {"cArqTmp","CTH"},  /*{}*/, .F., .F.)
oClValor:SetLinesBefore(0)   
oClValor:SetHeaderSection(.F.) 

TRCell():New(oClValor,"CLN_CLVALOR"		,"",Upper(Alltrim(cSayClVl))/*Titulo*/,/*Picture*/,Len(CTH->CTH_CLVL)/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oClValor,"CLN_CLVLRDESC"	,"",STR0035/*Titulo*/,/*Picture*/,90/*Tamanho*/,/*lPixel*/,/*{|| STR0035})*/) //"DESCRICAO"
TRCell():New(oClValor,"CLN_FILLER1"	,"",STR0027/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AllTrim(STR0027) + " "},/*"RIGHT"*/,,"RIGHT")  // "SALDO ANTERIOR:"
TRCell():New(oClValor,"CLN_SALDOANT"	,"",STR0027/*Titulo*/,/*Picture*/,TAM_VALOR/*Tamanho*/,/*lPixel*/,/*{|| }*/,/*"RIGHT"*/,,"LEFT")  // "SALDO ANTERIOR:"
             
oClValor:Cell("CLN_SALDOANT"):lHeaderSize := .F.

oClValor:SetLeftMargin(10)

oConta := TRSection():New(oReport, STR0037 , {"cArqTmp","CT1"},  /*{}*/, .F., .F.)   //"Conta"oClValor
oConta:SetHeaderSection(.F.)
oConta:SetLinesBefore(0)

TRCell():New(oConta,"CLN_CONTA"		,"",Upper(STR0037)/*Titulo*/,/*Picture*/,LEN(CT1->CT1_CONTA)+4/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"CONTA - "
TRCell():New(oConta,"CLN_CTADESC"	,"",STR0035/*Titulo*/,/*Picture*/,50/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) //"DESCRICAO"

//oConta:SetLineStyle()

oTotais := TRSection():New( oReport,	STR0036+" "+STR0037 ,,, .F., .F. )//"Total"
oTotais:SetLinesBefore(0)  
oTotais:SetHeaderSection(.F.)

nTamCel := 5
nTamCel += oRazao:Cell("CLN_DATA"):GetSize()
nTamCel += oRazao:Cell("CLN_NUMERO"):GetSize()
nTamCel += oRazao:Cell("CLN_HISTORICO"):GetSize()
nTamCel += oRazao:Cell("CLN_CONTRA_PARTIDA"):GetSize()
nTamCel += oRazao:Cell("CLN_CENTRO_CUSTO"):GetSize()
nTamCel += oRazao:Cell("CLN_ITEM_CONTABIL"):GetSize()

TRCell():New(oTotais,"TOT_DESCRI"	,"","",/*Picture*/,nTamCel,/*lPixel*/,{|| STR0020}) //"T o t a i s  d a  C o n t a  ==> "
TRCell():New(oTotais,"TOT_DEBITO"	,"",STR0032,/*Picture*/,TAM_VALOR,/*lPixel*/,/*{|| code-block de impressao }*/,/*"RIGHT"*/,,"RIGHT")	//"DEBITO"
TRCell():New(oTotais,"TOT_CREDITO"	,"",STR0033,/*Picture*/,TAM_VALOR,/*lPixel*/,/*{|| code-block de impressao }*/,/*"RIGHT"*/,,"RIGHT")		//"CREDITO"
TRCell():New(oTotais,"TOT_SALDO"	,"",STR0034,/*Picture*/,TAM_VALOR + 2,/*lPixel*/,/*{|| code-block de impressao }*/,/*"RIGHT"*/,,"RIGHT")		//"SALDO ATUAL"

oTotais:Cell("TOT_DESCRI"	):HideHeader() 
oTotais:Cell("TOT_DEBITO"	):HideHeader() 
oTotais:Cell("TOT_CREDITO"	):HideHeader() 
oTotais:Cell("TOT_SALDO"	):HideHeader()  

oTotais:Cell("TOT_DEBITO"):lHeaderSize  := .F.
oTotais:Cell("TOT_CREDITO"):lHeaderSize := .F.
oTotais:Cell("TOT_SALDO"):lHeaderSize   := .F.


//oComplemento := TRSection():New(oReport, STR0038,,/*{}*/, .F., .F.) //"Complemento"

//TRCell():New(oComplemento,"CMP_DATA"		,"",STR0028 /*Titulo*/,/*Picture*/,8/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)//"DATA"
//TRCell():New(oComplemento,"CMP_NUMERO"		,"",STR0029,/*Picture*/,TAM_NUMERO/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)	//"LOTE/SUB/DOC/LINHA"
//TRCell():New(oComplemento,"CMP_HISTORICO"	,"",STR0039,/*Picture*/,40/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)//"COMPL.HISTORICO"

//oComplemento:Cell("CMP_HISTORICO"):SetLineBreak()

oTotCLVL := TRSection():New( oReport,	STR0036+" "+Alltrim(cSayClVl),,, .F., .F. )  //"Total"
oTotCLVL:SetLinesBefore(0)  
oTotCLVL:SetHeaderSection(.F.)

TRCell():New(oTotCLVL,"TCL_DESCRI"	,"",Upper(STR0036),/*Picture*/,nTamCel,/*lPixel*/,{|| STR0020 }) //"T o t a i s  d a  C o n t a  ==> "  
TRCell():New(oTotCLVL,"TCL_DEBITO"	,"",STR0032,/*Picture*/,TAM_VALOR,/*lPixel*/,/*{|| code-block de impressao }*/,/*"RIGHT"*/,,"CENTER")
TRCell():New(oTotCLVL,"TCL_CREDITO"	,"",STR0033,/*Picture*/,TAM_VALOR,/*lPixel*/,/*{|| code-block de impressao }*/,/*"RIGHT"*/,,"CENTER")
TRCell():New(oTotCLVL,"TCL_SALDO"	,"",STR0034,/*Picture*/,TAM_VALOR + 2,/*lPixel*/,/*{|| code-block de impressao }*/,/*"RIGHT"*/,,"CENTER")

oTotCLVL:Cell("TCL_DESCRI"	):HideHeader() 
oTotCLVL:Cell("TCL_DEBITO"	):HideHeader() 
oTotCLVL:Cell("TCL_CREDITO"):HideHeader() 
oTotCLVL:Cell("TCL_SALDO"	):HideHeader() 

oTotCLVL:Cell("TCL_DEBITO"):lHeaderSize  := .F.
oTotCLVL:Cell("TCL_CREDITO"):lHeaderSize := .F.
oTotCLVL:Cell("TCL_SALDO"):lHeaderSize   := .F.


Return(oReport)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Microsiga           º Data ³  09/16/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Logica para impressao dos dados                             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport, cSayCusto, cSayItem, cSayClVl, cString, cTitulo, ;
									cCLVLIni, cCLVLFim,dDataIni, dDataFim, cMoeda, cSaldo,;
									cBook, cContaIni, cContaFim, lCusto, cCustoIni, cCustoFim, lItem,;
							  		cItemIni, cItemFim,lSalLin,aSelFil)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local oRazao		:= oReport:Section(1)
Local oClValor		:= oReport:Section(2)
Local oConta		:= oReport:Section(3)
Local oTotais		:= oReport:Section(4)
//Local oComplemento:= oReport:Section(5)
Local oTotCLVL		:= oReport:Section(5)
Local cFilterUser := oRazao:GetAdvplExp()    
Local cFilterCta 	:= oConta:GetAdvplExp('CT1')    

Local aCtbMoeda	:= {}
Local aSaldo		:= {}
Local aSaldoAnt	:= {}
Local cDescMoeda
Local cMascara1
Local cMascara2
Local cMascara3
Local cMascara4
Local cPicture
Local cTitTot 		:= ""
Local cSepara1		:= ""
Local cSepara2		:= ""
Local cSepara3		:= ""
Local cSepara4		:= ""
Local cContaAnt	:= ""
Local cCodRes		:= ""
Local cResCC		:= ""
Local cResItem 	:= ""
Local cResCLVL		:= ""		
Local cArqTmp
Local cNormal 		:= ""
Local dDataAnt		:= CTOD("  /  /  ")
Local lTotConta
Local nDecimais
Local nTotDeb		:= 0
Local nTotCrd		:= 0
Local nVlrDeb		:= 0
Local nVlrCrd		:= 0
Local lQbPg			:= .F.
Local l1StQb 		:= .T.
Local nBloco		:= 0
Local nBlCount		:= 0
Local lEmissUnica	:= If(GetNewPar("MV_CTBQBPG","M") == "M",.T.,.F.)			/// U=Quebra única (.F.) ; M=Multiplas quebras (.T.)
Local lNewPAGFIM
Local lFirst		:= .T.
Local nSpacCta		:= 70
Local nCells	:=1
Local lNoMov
Local lSalto
Local nPagIni
Local nPagFim
Local nReinicia
Local lPrintZero
Local cFilOld := cFilAnt
Local nX
Local cFil := ""
Local lColDbCr 		:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local cNormalCL		:= ""

Private lAnalitico	:= Iif(mv_par08 == 1,.T.,.F.)

lSaltLin	:= If(mv_par28==1,.T.,.F.)
lAnalitico	:= If(mv_par08 == 1,.T.,.F.)

aSetOfBook := CTBSetOf(mv_par07)
aCtbMoeda  	:= CtbMoeda(mv_par05)

cCLVLIni	:= mv_par01
cCLVLFim	:= mv_par02
cSaldo		:= mv_par06
dDataIni	:= mv_par03
dDataFim	:= mv_par04
cMoeda		:= mv_par05
lNoMov		:= Iif(mv_par09==1,.T.,.F.)
cContaIni	:= mv_par12
cContaFIm	:= mv_par13
cCustoIni	:= mv_par15
cCustoFim	:= mv_par16
cItemIni	:= mv_par18
cItemFim	:= mv_par19
lSalto		:= Iif(mv_par20==1,.T.,.F.)
nPagIni		:= mv_par21
nPagFim		:= mv_par22
nReinicia 	:= mv_par23
lPrintZero	:=	Iif(mv_par27 == 1,.T.,.F.)

lNewPAGFIM	:= If(nReinicia > nPagFim,.T.,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cDescMoeda 	:= Alltrim(aCtbMoeda[2])
nDecimais 	:= DecimalCTB(aSetOfBook,cMoeda)

// Mascara do Item Contabil
If Empty(aSetOfBook[7])
	cMascara3 := ""
Else
	cMascara3 := RetMasCtb(aSetOfBook[7],@cSepara3)
EndIf

// Mascara da Conta
If Empty(aSetOfBook[2])
	cMascara1 := GetMv("MV_MASCARA")
Else
	cMascara1	:= RetMasCtb(aSetOfBook[2],@cSepara1)
EndIf
 
// Mascara do Centro de Custo
If lCusto
	If Empty(aSetOfBook[6])
		cMascara2 := GetMv("MV_MASCCUS")
	Else
		cMascara2	:= RetMasCtb(aSetOfBook[6],@cSepara2)
	EndIf                                                
Endif 

If lItem
	// Mascara da Classe de Valor
	If Empty(aSetOfBook[8])
		cMascara4 := ""
	Else
		cMascara4 := RetMasCtb(aSetOfBook[8],@cSepara4)
	EndIf
EndIf	

cPicture 	:= aSetOfBook[4]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Titulo do Relatorio                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Type("NewHead")== "U"
	cTitulo	:= STR0007 + Upper(Alltrim(cSayClVl)) //"RAZAO POR CLASSE DE VALOR"
	IF lAnalitico
		cTitulo	+=	STR0008	//" ANALITICO EM "
	Else
		cTitulo	+=	STR0021	//" SINTETICO EM "
	EndIf
	cTitulo += 	cDescMoeda + space(01)+STR0009+ space(01)+DTOC(dDataIni) +;	// "DE"
					space(01)+STR0010+ space(01)+DTOC(dDataFim)						// "ATE"
	
	If mv_par06 > "1"
		cTitulo += " (" + Tabela("SL", mv_par06, .F.) + ")"
	EndIf
Else
	cTitulo := NewHead
EndIf

oReport:SetPageNumber(mv_par21)
oReport:SetTitle(cTitulo)
oReport:SetCustomText( {|| CtCGCCabTR(.F.,lCusto,lItem,,,dDataFim,oReport:Title(),If(mv_par08 == 1,.T.,.F.),,,,oReport) } )

// A TRANSPORTAR :  	
oReport:SetPageFooter( 5, {|| Iif(oRazao:Printing() .Or. oTotais:Printing(),;
									oReport:PrintText(DTOC(cArqTmp->DATAL)+Space(50)+STR0022 + ValorCTB(nSaldoAtu,,,TAM_VALOR,nDecimais,.T.,cPicture,Iif(lIsRedStor,cNormalCL,cNormal),,,,,,lPrintZero,.F.) );
								, NIL )})

//"DE TRANSPORTE : "
oReport:OnPageBreak( {|| Iif(oRazao:Printing() .Or. oTotais:Printing(),;
								(oReport:PrintText(DTOC(cArqTmp->DATAL)+Space(50)+STR0023 + ValorCTB(nSaldoAtu,,,TAM_VALOR,nDecimais,.T.,cPicture,Iif(lIsRedStor,cNormalCL,cNormal),,,,,,lPrintZero,.F.),oReport:Row(),10),oReport:Skipline());  //"DE TRANSPORTE : "
							,NIL)})

//redefinir o tamanho da coluna Conta
If !lCusto .and. !lItem
	If mv_par10 == 2
		nSpacCta := Len(CT1->CT1_RES)+Len(ALLTRIM(cMascara1))
	Else
		nSpacCta := Len(CT1->CT1_CONTA)
	EndIf
	oConta:Cell("CLN_CONTA"):SetSize(nSpacCta)	
EndIf

If ! lAnalitico							// Relatorio Analitico
	lCusto := .F.
	lItem  := .F.
	oRazao:Cell("CLN_NUMERO"):Hide()
	oRazao:Cell("CLN_HISTORICO"):Hide()
	oRazao:Cell("CLN_CONTRA_PARTIDA"):Hide()
	oRazao:Cell("CLN_CENTRO_CUSTO"):Hide()
	oRazao:Cell("CLN_ITEM_CONTABIL"):Hide()
	oRazao:Cell("CLN_NUMERO"):HideHeader()
	oRazao:Cell("CLN_HISTORICO"):HideHeader()
	oRazao:Cell("CLN_CONTRA_PARTIDA"):HideHeader()
	oRazao:Cell("CLN_CENTRO_CUSTO"):HideHeader()
	oRazao:Cell("CLN_ITEM_CONTABIL"):HideHeader()
Else
//	TrPosition():New(oRazao,'CT2',10,{|| xFilial("CT2")+cArqTMP->(DTOS(DATAL)+LOTE+SUBLOTE+DOC+SEQLAN+EMPORI+FILORI)})
EndIf	

//CLASSE DE VALOR
If mv_par26 == 1 //Se imprime cod. normal de classe de valor
	oClValor:Cell("CLN_CLVALOR"):SetBlock( {|| EntidadeCTB(cArqTmp->CLVL,,,20,.F.,cMascara4,cSepara4,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/) } )
Else
	oClValor:Cell("CLN_CLVALOR"):SetBlock( {|| EntidadeCTB(cResCLVL,,,20,.F.,cMascara4,cSepara4,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/) } )
Endif
oClValor:Cell("CLN_CLVLRDESC"):SetBlock( {|| CtbDescMoeda("CTH->CTH_DESC"+cMoeda) } )
If lIsRedStor
	oClValor:Cell("CLN_SALDOANT"):SetBlock( {|| ValorCTB(aSaldoAnt[6],,,TAM_VALOR,nDecimais,.T.,cPicture,cNormalCL,,,,,,,.F.) } )
Else
	oClValor:Cell("CLN_SALDOANT"):SetBlock( {|| ValorCTB(aSaldoAnt[6],,,TAM_VALOR,nDecimais,.T.,cPicture,,,,,,,,.F.) } )
EndIF


//CONTA
If mv_par10 == 1							// Imprime Cod Normal
	oConta:Cell("CLN_CONTA"):SetBlock( {|| EntidadeCTB(cArqTmp->CONTA,,,nSpacCta,.F.,cMascara1,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/) } )
Else
	oConta:Cell("CLN_CONTA"):SetBlock( {|| EntidadeCTB(cCodRes,,,20,.F.,cMascara1,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/) } )
EndIf

oConta:Cell("CLN_CTADESC"):SetBlock( {|| CtbDescMoeda("CT1->CT1_DESC"+cMoeda) } )

//RAZAO  (DETALHE)
oRazao:Cell("CLN_DATA")				:SetBlock( {|| IIf(CT2->CT2_DC == "4","", If(lAnalitico, cArqTmp->DATAL, dDataAnt) ) } )
oRazao:Cell("CLN_NUMERO")			:SetBlock( { ||cArqTmp->LOTE+cArqTmp->SUBLOTE+cArqTmp->DOC+cArqTmp->LINHA } )
oRazao:Cell("CLN_HISTORICO")		:SetBlock( { ||IIf(CT2->CT2_DC == "4",Subs(CT2->CT2_HIST,1,40),cArqTmp->HISTORICO) } )

If mv_par10 == 1
	oRazao:Cell("CLN_CONTRA_PARTIDA")	:SetBlock( {|| EntidadeCTB(cArqTmp->XPARTIDA,,,nSpacCta,.F.,cMascara1,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/) } )
Else
	oRazao:Cell("CLN_CONTRA_PARTIDA")	:SetBlock( {|| EntidadeCTB(cCodRes,,,20,.F.,cMascara1,cSepara1,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/) } )
Endif                              

If lCusto 				//Se imprime centro de custo
	If mv_par24 == 1 	//Se imprime cod. normal centro de custo
		oRazao:Cell("CLN_CENTRO_CUSTO")		:SetBlock( {|| EntidadeCTB(cArqTmp->CCUSTO,,,20,.F.,cMascara2,cSepara2,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/) } )
	Else
		oRazao:Cell("CLN_CENTRO_CUSTO")		:SetBlock( {|| EntidadeCTB(cResCC,,,20,.F.,cMascara2,cSepara2,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/) } )	
	Endif
Else
	oRazao:Cell("CLN_CENTRO_CUSTO")		:SetBlock( {|| "" })
Endif

If lItem						//Se imprime item           
	If mv_par25 == 1
		oRazao:Cell("CLN_ITEM_CONTABIL")	:SetBlock( {|| EntidadeCTB(cArqTmp->ITEM,,,20,.F.,cMascara3,cSepara3,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/) } )
	Else
		oRazao:Cell("CLN_ITEM_CONTABIL")	:SetBlock( {|| EntidadeCTB(cResItem,,,20,.F.,cMascara3,cSepara3,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/) } )
	Endif						
Else
	oRazao:Cell("CLN_ITEM_CONTABIL")	:SetBlock( {|| "" } )
Endif

If lAnalitico
	oRazao:Cell("CLN_VLR_DEBITO")		:SetBlock( {|| ValorCTB(cArqTmp->LANCDEB	,,,TAM_VALOR,nDecimais,.F.,cPicture,"1"	, , , , , ,lPrintZero,.F.,lColDbCr) } )
	oRazao:Cell("CLN_VLR_CREDITO")	:SetBlock( {|| ValorCTB(cArqTmp->LANCCRD	,,,TAM_VALOR,nDecimais,.F.,cPicture,"2"	, , , , , ,lPrintZero,.F.,lColDbCr) } )
	oRazao:Cell("CLN_VLR_SALDO")		:SetBlock( {|| ValorCTB(nSaldoAtu			,,,TAM_VALOR-2,nDecimais,.T.,cPicture,Iif(lIsRedStor,cNormalCL,cNormal), , , , , ,lPrintZero,.F.) } )
Else
	oRazao:Cell("CLN_VLR_DEBITO")		:SetBlock( {|| ValorCTB(nVlrDeb,,,TAM_VALOR,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero,.F.,lColDbCr) } )
	oRazao:Cell("CLN_VLR_CREDITO")	:SetBlock( {|| ValorCTB(nVlrCrd,,,TAM_VALOR,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero,.F.,lColDbCr) } )
	oRazao:Cell("CLN_VLR_SALDO")		:SetBlock( {|| ValorCTB(nSaldoAtu,,,TAM_VALOR,nDecimais,.T.,cPicture,Iif(lIsRedStor,cNormalCL,cNormal), , , , , ,lPrintZero,.F.) } )
EndIf

//COMPLEMENTO
/*oComplemento:Cell("CMP_NUMERO")		:SetBlock( { ||CT2->(CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_LINHA) } )
oComplemento:Cell("CMP_HISTORICO")	:SetBlock( { ||CT2->CT2_HIST } )
oComplemento:SetHeaderSection(.F.)
oComplemento:SetHeaderSection(.F.)
*/
//TOTALIZADORES
oTotais:Cell("TOT_DEBITO")			:SetBlock( { || ValorCTB(nTotCtaDeb,,,TAM_VALOR,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero,.F.,lColDbCr) } )
oTotais:Cell("TOT_CREDITO")			:SetBlock( { || ValorCTB(nTotCtaCrd,,,TAM_VALOR,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero,.F.,lColDbCr) } )
oTotais:Cell("TOT_SALDO")			:Hide()

cTitTot := STR0017 + Upper(Alltrim(cSayClVl)) + " ==> (" //"T o t a i s   C l a s s e   d e   V a l o r ==> " +
If mv_par26 == 1 //Imprime cod. normal Classe de valor
	oTotCLVL:Cell("TCL_DESCRI")			:SetBlock( {|| cTitTot + EntidadeCTB(cCLVLAnt,,,20,.F.,cMascara4,cSepara4,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)+ ")" } )
Else
	oTotCLVL:Cell("TCL_DESCRI")			:SetBlock( {|| cTitTot + EntidadeCTB(cResCLVL,,,20,.F.,cMascara4,cSepara4,/*cAlias*/,/*nOrder*/,.F./*lGraf*/,/*oPrint*/,.F./*lSay*/)+ ")" } )
Endif

oTotCLVL:Cell("TCL_DEBITO")			:SetBlock( { || ValorCTB(nTotDeb,,,TAM_VALOR,nDecimais,.F.,cPicture,"1", , , , , ,lPrintZero,.F.,lColDbCr) } )
oTotCLVL:Cell("TCL_CREDITO")		:SetBlock( { || ValorCTB(nTotCrd,,,TAM_VALOR,nDecimais,.F.,cPicture,"2", , , , , ,lPrintZero,.F.,lColDbCr) } )
If lIsRedStor
	oTotCLVL:Cell("TCL_SALDO")			:SetBlock( { || ValorCTB(nSaldoAtu,,,TAM_VALOR-2,nDecimais,.T.,cPicture,cNormalCL, , , , , ,lPrintZero,.F.) } )
Else
	oTotCLVL:Cell("TCL_SALDO")			:SetBlock( { || ValorCTB(nSaldoAtu,,,TAM_VALOR-2,nDecimais,.T.,cPicture, , , , , , ,lPrintZero,.F.) } )
EndIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao							  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				CTBGerRaz(oMeter,oText,oDlg,lEnd,@cArqTmp,cContaIni,cContaFim,cCustoIni,cCustoFim,;
				cItemIni,cItemFim,cCLVLIni,cCLVLFim,cMoeda,dDataIni,dDataFim,;
				aSetOfBook,lNoMov,cSaldo,.t.,"4",lAnalitico,,,cFilterUser,,aSelFil)},;
				STR0018,;		// "Criando Arquivo Temporario..."
				STR0006+Alltrim(cSayClVl))						// "Emissao do Razao"

oReport:NoUserFilter()

dbSelectArea("cArqTmp")
oReport:SetMeter(RecCount())
dbGoTop()

//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial 
//nao esta disponivel e sai da rotina.
If RecCount() == 0 .And. !Empty(aSetOfBook[5])                                       
	dbCloseArea()
	oReport:CancelPrint()
	Return
Endif

While cArqTmp->(!Eof())
   
	cFilAnt := cArqTmp->FILORI
	
	IF oReport:Cancel()
		Exit
	EndIF

	oReport:IncMeter()

	//Se imprime centro de custo e item, ira considerar o filtro do centro de custo e do item para 
	//calculo do saldo ant. 	
	If lCusto .And. lItem
		aSaldoAnt	:= SaldTotCTI(cArqTmp->CLVL,cArqTMP->CLVL,cItemIni,cItemFim,;
							  cCustoIni,cCustoFim,cContaIni,cContaFim,;
							  dDataIni,cMoeda,cSaldo,aSelFil)
		aSaldo	:= SaldTotCTI(cArqTmp->CLVL,cArqTMP->CLVL,cItemIni,cItemFim,;
							  cCustoIni,cCustoFim,cContaIni,cContaFim,;
							  cArqTmp->DATAL,cMoeda,cSaldo,aSelFil)	
	//Se imprime centro de custo, ira considerar o filtro do centro de custo para 
	//calculo do saldo ant. 								  
	ElseIf lCusto .And. !lItem
		aSaldoAnt	:= SaldTotCTI(cArqTmp->CLVL,cArqTMP->CLVL,Space(Len(CTD->CTD_ITEM)),Repl("Z",Len(CTD->CTD_ITEM)),;
							  cCustoIni,cCustoFim,cContaIni,cContaFim,;
							  dDataIni,cMoeda,cSaldo,aSelFil)
		aSaldo	:= SaldTotCTI(cArqTmp->CLVL,cArqTMP->CLVL,Space(Len(CTD->CTD_ITEM)),Repl("Z",Len(CTD->CTD_ITEM)),;
							  cCustoIni,cCustoFim,cContaIni,cContaFim,;
							  cArqTmp->DATAL,cMoeda,cSaldo,aSelFil)	
	//Se imprime item, ira considerar o filtro do item para calculo do saldo anterior.
	ElseIf !lCusto .And. lItem
		aSaldoAnt	:= SaldTotCTI(cArqTmp->CLVL,cArqTMP->CLVL,cItemIni,cItemFim,;
							  Space(Len(CTT->CTT_CUSTO)),Repl("Z",Len(CTT->CTT_CUSTO)),cContaIni,cContaFim,;
							  dDataIni,cMoeda,cSaldo,aSelFil)
		aSaldo	:= SaldTotCTI(cArqTmp->CLVL,cArqTMP->CLVL,cItemIni,cItemFim,;
							  Space(Len(CTT->CTT_CUSTO)),Repl("Z",Len(CTT->CTT_CUSTO)),cContaIni,cContaFim,;
							  cArqTmp->DATAL,cMoeda,cSaldo,aSelFil)		

	ElseIf !lCusto .And. !lItem	
		aSaldoAnt	:= SaldTotCTI(cArqTmp->CLVL,cArqTMP->CLVL,Space(Len(CTD->CTD_ITEM)),Repl("Z",Len(CTD->CTD_ITEM)),;
							  Space(Len(CTT->CTT_CUSTO)),Repl("Z",Len(CTT->CTT_CUSTO)),cContaIni,cContaFim,;
							  dDataIni,cMoeda,cSaldo,aSelFil)
		aSaldo	:= SaldTotCTI(cArqTmp->CLVL,cArqTMP->CLVL,Space(Len(CTD->CTD_ITEM)),Repl("Z",Len(CTD->CTD_ITEM)),;
							  Space(Len(CTT->CTT_CUSTO)),Repl("Z",Len(CTT->CTT_CUSTO)),cContaIni,cContaFim,;
							  cArqTmp->DATAL,cMoeda,cSaldo,aSelFil)
	EndIf

	If !lNoMov //Se imprime sem movimento
		If aSaldo[6] == 0 .And. cArqTmp->LANCDEB ==0 .And. cArqTmp->LANCCRD == 0 
			dbSelectArea("cArqTmp")
			dbSkip()
			Loop
		Endif	
	Endif             
	
	If lNomov .And. aSaldo[6] == 0 .And. cArqTmp->LANCDEB ==0 .And. cArqTmp->LANCCRD == 0 
		If CtbExDtFim("CTH") 			
			dbSelectArea("CTH") 
			dbSetOrder(1) 
			If MsSeek(xFilial()+cArqTmp->CLVL)
				If !CtbVlDtFim("CTH",dDataIni) 		
					dbSelectArea("cArqTmp")
					dbSkip()
					Loop								
	            EndIf
		    EndIf
		    dbSelectArea("cArqTmp")
		EndIf
	EndIf
	
	nSaldoAtu:= 0
	nTotDeb	:= 0
	nTotCrd	:= 0


	dbSelectArea("CTH")
	dbSetOrder(1)
	dbSeek(xFilial()+cArqTMP->CLVL)  
	cResCLVL 	:= CTH->CTH_RES
	cNormalCL	:= CTH->CTH_NORMAL

	oClValor:Init()
	oClValor:PrintLine()
	oClValor:Finish()
	oReport:SkipLine()
    
	nSaldoAtu := aSaldoAnt[6]
	
	dbSelectArea("cArqTmp")
	
	cCLVLAnt := cArqTmp->CLVL
	While cArqTmp->(!Eof()) .And. cArqTmp->CLVL == cClVlAnt
	
		cContaAnt	:= cArqTmp->CONTA
		dDataAnt	:= cArqTmp->DATAL                      
	 	If !Empty(cFilterCta) .And. !Empty(cArqTmp->CONTA)
			dbSelectArea("CT1")
			dbSetOrder(1)
			MsSeek(xFilial()+cArqTmp->CONTA)
			If !&(cFilterCta)   //Alteração p/ filtro R4
				dbSelectArea("cArqTmp")
				DbSkip()
				Loop
			Endif		
		Endif
		If lAnalitico
			nTotCtaDeb  := 0
			nTotCtaCrd	:= 0
		
			If ! Empty(cArqTmp->CONTA)
				dbSelectArea("CT1")
				dbSetOrder(1)
				MsSeek(xFilial()+cArqTmp->CONTA)
				cCodRes := CT1->CT1_RES
				cNormal := CT1->CT1_NORMAL
				
				oConta:Init()
				oConta:PrintLine()
				oConta:Finish()
			Endif
			
        	lTotConta := .F.
        	oRazao:Init()
        	
			While cArqTmp->(! Eof() .And. CLVL == cClVlAnt .And. CONTA == cContaAnt)

				nSaldoAtu 	:= nSaldoAtu - cArqTmp->LANCDEB + cArqTmp->LANCCRD
				nTotDeb		+= cArqTmp->LANCDEB
				nTotCrd		+= cArqTmp->LANCCRD
				nTotCtaDeb  += cArqTmp->LANCDEB
				nTotCtaCrd  += cArqTmp->LANCCRD
	
				dbSelectArea("CT1")
				dbSetOrder(1)
				dbSeek(xFilial()+cArqTmp->XPARTIDA)
				cCodRes := CT1->CT1_RES

				If lCusto 				//Se imprime centro de custo
					If mv_par24 != 1 	//Se imprime cod. normal centro de custo
						dbSelectArea("CTT")
						dbSetOrder(1)
						dbSeek(xFilial()+cArqTMP->CCUSTO)  
						cResCC := CTT->CTT_RES
					Endif
				Endif
				
				If lItem						//Se imprime item           
					If mv_par25 != 1
						dbSelectArea("CTD")
						dbSetOrder(1)
						dbSeek(xFilial()+cArqTMP->ITEM)  
						cResItem := CTD->CTD_RES		
					Endif						
				Endif
				
				dbSelectArea("CT2")
				dbSetOrder(10)
				dbSeek(xFilial("CT2")+cArqTMP->(DTOS(DATAL)+LOTE+SUBLOTE+DOC+SEQLAN+EMPORI+FILORI),.F.)
				oRazao:PrintLine()
				
				// Procura pelo complemento de historico
				dbSelectArea("CT2")
				dbSetOrder(10)
//				If dbSeek(xFilial("CT2")+cArqTMP->(DTOS(DATAL)+LOTE+SUBLOTE+DOC+SEQLAN+EMPORI+FILORI),.F.)
					dbSkip()
					If CT2->CT2_DC == "4"
//						oComplemento:Init()
						//oReport:SkipLine()
						For nCells := 1 To Len(oRazao:aCell)
							If oRazao:aCell[nCells]:cName <> "CLN_NUMERO" .And. oRazao:aCell[nCells]:cName <> "CLN_HISTORICO"
								oRazao:Cell(oRazao:aCell[nCells]:cName):Hide()
							Endif
						Next				
						While CT2->(!Eof()) .And. CT2->CT2_FILIAL == xFilial() 		 .And.;
											CT2->CT2_LOTE == cArqTMP->LOTE 	 .And.;
											CT2->CT2_SBLOTE == cArqTMP->SUBLOTE .And.;
											CT2->CT2_DOC == cArqTmp->DOC 		 .And.;
											CT2->CT2_SEQLAN == cArqTmp->SEQLAN .And.;
											CT2->CT2_EMPORI == cArqTmp->EMPORI	.And.;
											CT2->CT2_FILORI == cArqTmp->FILORI	.And.;
											CT2->CT2_DC == "4" 				 .And.;
											DTOS(CT2->CT2_DATA) == DTOS(cArqTmp->DATAL)

							oRazao:PrintLine()

//							oComplemento:PrintLine()
														
							CT2->(dbSkip())
							
						EndDo
						For nCells := 1 To Len(oRazao:aCell)
							oRazao:Cell(oRazao:aCell[nCells]:cName):Show()
						Next				
//						oComplemento:Finish()
						
//					EndIf
					
				EndIf
				
				dbSelectArea("cArqTmp")
				lTotConta := ! Empty(cArqTmp->CONTA)
				dDataAnt := cArqTmp->DATAL
				
      			dbSkip()
	      		
			EndDo      	
   
			If lTotConta
				If mv_par11 == 1						// Totaliza tb por Conta
					oReport:ThinLine()
					oTotais:Init()
					oTotais:PrintLine()
					oTotais:Finish()
				
					nTotCtaDeb := 0
					nTotCtaCrd := 0
				Endif
				If lSaltLin
					oReport:SkipLine(2)
				Endif
			EndIf	

			oRazao:Finish()

		Else					//Se for resumido
		
			dbSelectArea("cArqTmp")
			If ! Empty(cArqTmp->CONTA)
				CT1->(dbSeek(xFilial()+cArqTmp->CONTA))
				cCodRes := CT1->CT1_RES
				cNormal := CT1->CT1_NORMAL
			Else
				cNormal := ""
			Endif

            oRazao:Init()

			While  dDataAnt == cArqTmp->DATAL .And. cCLVLAnt == cArqTmp->CLVL
				nVlrDeb	+= cArqTmp->LANCDEB		                                         
				nVlrCrd	+= cArqTmp->LANCCRD		                                         
				dbSkip()                                                                    				
			End		   
			
			nSaldoAtu := nSaldoAtu - nVlrDeb + nVlrCrd

			oRazao:PrintLine()
            
			oRazao:Finish()

			nTotDeb	+= nVlrDeb
			nTotCrd	+= nVlrCrd
			nVlrDeb	:= 0
			nVlrCrd	:= 0

		Endif 

		dbSelectArea("cArqTmp")

	EndDo	

	If lSaltLin .And. !lAnalitico
		oReport:ThinLine()
    EndIf
		
	If mv_par26 != 1 //Imprime cod. normal Classe de valor
		dbSelectArea("CTH")
		dbSetOrder(1)
		dbSeek(xFilial()+cCLVLAnt)  
		cResCLVL 	:= CTH->CTH_RES
		cNormalCL	:= CTH->CTH_NORMAL
	Endif

	oReport:FatLine()
    oTotCLVL:Init()
    oTotCLVL:PrintLine()
    oTotCLVL:Finish()
	
	dbSelectArea("cArqTmp")
	
	If lSalto
		oReport:EndPage()
	Else
		oReport:SkipLine(3)	
	EndIf	

EndDo	

cFilAnt := cFilOld
dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()

dbselectArea("CT2")

Return