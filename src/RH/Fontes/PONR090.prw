/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "PONR090.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ PONR090  ³ Autor ³ Fernando Joly Siquini   ³ Data ³ 03.02.98  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio por Codigos                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_PONR090(void)                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data     ³ BOPS ³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Leandro Dr. ³14/04/2014³      ³Retirada de ajustes, database e FieldPos   ³±±
±±³            ³          ³      ³que nao serao utilizados na P12.		     ³±±
±±³Luis Artuso ³16/09/2014³      ³Ajuste para considerar as filiais na gera- ³±±
±±³            ³          ³      ³cao do relatorio personalizavel. 			 ³±±
±±³Allyson M   ³15/08/2016³TVOOPG³Ajuste p/ separar impressão de acordo com o³±±
±±³            ³          ³      ³tipo da verba p/ facilitar conferência. 	 ³±±
±±³Oswaldo L.  ³03/04/17³DRHPONTP-164  ³Projeto cTree                        ³±±
±±³Oswaldo L   ³24/08/2017³DRHPON³Tratar valores negativos nos calculos.     ³±±
±±³            ³          ³TP-780³                                           ³±±  
±±³Oswaldo L   ³29/08/2017³DRHPON³Aproveitei para ajustar minha liberação    ³±±
±±³            ³          ³TP1672³anterior qto ao formato campo qtde dias    ³±±
±±³Oswaldo L   ³29/08/2017³DRHPON³Ajuste evitar paginas em branco no relat   ³±±
±±³            ³          ³TP1351³sintetico por matricula                    ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function PonR090()

//Local aArqTrab	:= {}
Local nx		 := 0
Local oReport 
Private oBreak, oBreakCc, oBreakMat
Private lSrvAs400 := ( TcSrvType() == "AS/400" )	
Private oTmpTRBSRA 
	//-- Cria arquivo temporario para o ambiente CDX ou AS/400
	If lSrvAs400
		CriaTRBSRA()
	EndIf

	Pergunte("PO090R",.F.)
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()
	
	//-- Apaga os arquivos temporarios
	If Select("TRBSRA") > 0
		TRBSRA->(DbClosearea())
	EndIf
	
	If oTmpTRBSRA <> Nil
		oTmpTRBSRA:Delete()
		Freeobj(oTmpTRBSRA)
	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Ricardo Duarte Costa  ³ Data ³ 21.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do relatorio                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport 
Local oSection, oSection1, oSection2, oSection3
Local aOrd		:= {STR0004 , STR0005 , STR0006 , STR0028 } // 'Matricula'###'Centro de Custo'###'Nome'###'C.Custo+Nome'

Local bTipVHoras:= {|| If((cAliasSPB)->PB_TIPO1 == "H", If(lSexaCent, fConvHr((cAliasSPB)->PB_HORAS,'H') * TpVerba((cAliasSPB)->RV_TIPOCOD), (cAliasSPB)->PB_HORAS * TpVerba((cAliasSPB)->RV_TIPOCOD) ), 0) }
Local bTipVDias	:= {|| If((cAliasSPB)->PB_TIPO1 == "D", (cAliasSPB)->PB_HORAS  * TpVerba((cAliasSPB)->RV_TIPOCOD) , 0) } 
Local bTipVValor:= {|| If((cAliasSPB)->PB_TIPO1 == "V", (cAliasSPB)->PB_VALOR  * TpVerba((cAliasSPB)->RV_TIPOCOD) , 0) }
Local bTipHHrs01:= {|| If((cAliasSRA)->TP01 == "H", If(lSexaCent, fConvHr((cAliasSRA)->PD01,'H') * TpVerba((cAliasSRA)->RVCOD01), (cAliasSRA)->PD01  * TpVerba((cAliasSRA)->RVCOD01)), (cAliasSRA)->PD01  * TpVerba((cAliasSRA)->RVCOD01) ) }
Local bTipHHrs02:= {|| If((cAliasSRA)->TP02 == "H", If(lSexaCent, fConvHr((cAliasSRA)->PD02,'H') * TpVerba((cAliasSRA)->RVCOD02), (cAliasSRA)->PD02  * TpVerba((cAliasSRA)->RVCOD02)), (cAliasSRA)->PD02  * TpVerba((cAliasSRA)->RVCOD02) ) }
Local bTipHHrs03:= {|| If((cAliasSRA)->TP03 == "H", If(lSexaCent, fConvHr((cAliasSRA)->PD03,'H') * TpVerba((cAliasSRA)->RVCOD03), (cAliasSRA)->PD03  * TpVerba((cAliasSRA)->RVCOD03)), (cAliasSRA)->PD03  * TpVerba((cAliasSRA)->RVCOD03) ) }
Local bTipHHrs04:= {|| If((cAliasSRA)->TP04 == "H", If(lSexaCent, fConvHr((cAliasSRA)->PD04,'H') * TpVerba((cAliasSRA)->RVCOD04), (cAliasSRA)->PD04  * TpVerba((cAliasSRA)->RVCOD04)), (cAliasSRA)->PD04  * TpVerba((cAliasSRA)->RVCOD04) ) }
Local bTipHHrs05:= {|| If((cAliasSRA)->TP05 == "H", If(lSexaCent, fConvHr((cAliasSRA)->PD05,'H') * TpVerba((cAliasSRA)->RVCOD05), (cAliasSRA)->PD05  * TpVerba((cAliasSRA)->RVCOD05)), (cAliasSRA)->PD05  * TpVerba((cAliasSRA)->RVCOD05) ) }
Local bTipHHrs06:= {|| If((cAliasSRA)->TP06 == "H", If(lSexaCent, fConvHr((cAliasSRA)->PD06,'H') * TpVerba((cAliasSRA)->RVCOD06), (cAliasSRA)->PD06  * TpVerba((cAliasSRA)->RVCOD06)), (cAliasSRA)->PD06  * TpVerba((cAliasSRA)->RVCOD06) ) }
Local bTipHHrs07:= {|| If((cAliasSRA)->TP07 == "H", If(lSexaCent, fConvHr((cAliasSRA)->PD07,'H') * TpVerba((cAliasSRA)->RVCOD07), (cAliasSRA)->PD07  * TpVerba((cAliasSRA)->RVCOD07)), (cAliasSRA)->PD07  * TpVerba((cAliasSRA)->RVCOD07) ) }
Local bTipHHrs08:= {|| If((cAliasSRA)->TP08 == "H", If(lSexaCent, fConvHr((cAliasSRA)->PD08,'H') * TpVerba((cAliasSRA)->RVCOD08), (cAliasSRA)->PD08  * TpVerba((cAliasSRA)->RVCOD08)), (cAliasSRA)->PD08  * TpVerba((cAliasSRA)->RVCOD08) ) }
Local bTipHHrsTT:= {|| If(lSexaCent, fSomaTot("H") , fSomaTot("C") ) }
Local bTipHHrsTD:= {|| fSomaTot("D") }
Local bTipHHrsTV:= {|| fSomaTot("V") }

	DEFINE REPORT oReport NAME "PONR090" TITLE OemToAnsi(STR0012) PARAMETER "PO090R" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION OemtoAnsi(STR0046)
	//"Emite Relacao de resultados do Ponto Eletronico."

	//-- Indica que o tal sera em coluna. Os campos numericos serao totalizados abaixo de suas colunas onde foram impressos.
	oReport:SetTotalInLine(.F.)
   	
		DEFINE SECTION oSection1 OF oReport TABLES "SRA" ORDERS aOrd TITLE STR0047
		oSection1:SetTotalInLine(.F.)
		
			DEFINE CELL NAME "RA_FILIAL" 	OF oSection1 ALIAS "SRA" 
			DEFINE CELL NAME "RA_CC"		OF oSection1 ALIAS "SRA" 
			DEFINE CELL NAME "RA_MAT" 		OF oSection1 ALIAS "SRA" 
			DEFINE CELL NAME "RA_NOME"		OF oSection1 ALIAS "SRA" 

			DEFINE SECTION oSection2 OF oSection1 TABLES "SPB", "SRV" TITLE STR0048
		
			DEFINE CELL NAME "PB_PD" 		OF oSection2 ALIAS "SPB" 
			DEFINE CELL NAME "RV_DESC"		OF oSection2 ALIAS "SRV" 
			
			DEFINE CELL NAME "PB_HORAS"		OF oSection2 ALIAS "SPB"	TITLE OemToAnsi(STR0033) PICTURE "@E 999,999,999.99"  SIZE 11    BLOCK  bTipVHoras	  ALIGN RIGHT
			DEFINE CELL NAME "PB_DIAS"		OF oSection2 ALIAS "SPB"	TITLE OemToAnsi(STR0060) PICTURE "@E 999,9999"  SIZE 11    BLOCK  bTipVDias	  ALIGN RIGHT
			DEFINE CELL NAME "PB_VALOR"		OF oSection2 ALIAS "SPB"	TITLE OemToAnsi(STR0061) PICTURE "@E 999,999,999.99"  SIZE 11    BLOCK  bTipVValor	  ALIGN RIGHT
			
			oSection2:SetLeftMargin(8)

			TRPosition():New(oSection2,"SRV",1,{|| xFilial("SRV",(cAliasSPB)->PB_FILIAL)+(cAliasSPB)->PB_PD},.T.)

		DEFINE SECTION oSection3 OF oReport TABLES "TRBSRA" ORDERS aOrd TITLE STR0049
		oSection3:SetTotalInLine(.F.)
		oSection3:SetAutoSize()
		
			DEFINE CELL NAME "RA_FILIAL" 	OF oSection3 ALIAS "TRBSRA" AUTO SIZE
			DEFINE CELL NAME "RA_CC"		OF oSection3 ALIAS "TRBSRA" AUTO SIZE
			DEFINE CELL NAME "RA_MAT" 		OF oSection3 ALIAS "TRBSRA" AUTO SIZE
			DEFINE CELL NAME "RA_NOME"		OF oSection3 ALIAS "TRBSRA" AUTO SIZE 
			DEFINE CELL NAME "PD01"	 		OF oSection3 				TITLE STR0034	PICTURE PesqPict("SPB","PB_HORAS") BLOCK  bTipHHrs01 ALIGN RIGHT	// #"COD 01"
			DEFINE CELL NAME "PD02"	 		OF oSection3 				TITLE STR0035	PICTURE PesqPict("SPB","PB_HORAS") BLOCK  bTipHHrs02 ALIGN RIGHT	// #"COD 02"
			DEFINE CELL NAME "PD03"	 		OF oSection3 				TITLE STR0036	PICTURE PesqPict("SPB","PB_HORAS") BLOCK  bTipHHrs03 ALIGN RIGHT	// #"COD 03"
			DEFINE CELL NAME "PD04"	 		OF oSection3 				TITLE STR0037	PICTURE PesqPict("SPB","PB_HORAS") BLOCK  bTipHHrs04 ALIGN RIGHT	// #"COD 04"
			DEFINE CELL NAME "PD05"	 		OF oSection3 				TITLE STR0038	PICTURE PesqPict("SPB","PB_HORAS") BLOCK  bTipHHrs05 ALIGN RIGHT	// #"COD 05"
			DEFINE CELL NAME "PD06"	 		OF oSection3 				TITLE STR0039	PICTURE PesqPict("SPB","PB_HORAS") BLOCK  bTipHHrs06 ALIGN RIGHT	// #"COD 06"
			DEFINE CELL NAME "PD07"	 		OF oSection3 				TITLE STR0040	PICTURE PesqPict("SPB","PB_HORAS") BLOCK  bTipHHrs07 ALIGN RIGHT	// #"COD 07"
			DEFINE CELL NAME "PD08"	 		OF oSection3 				TITLE STR0041	PICTURE PesqPict("SPB","PB_HORAS") BLOCK  bTipHHrs08 ALIGN RIGHT	// #"COD 08"
			DEFINE CELL NAME "PD09"	 		OF oSection3 				TITLE ""		PICTURE PesqPict("SPB","PB_HORAS") BLOCK  bTipHHrs08 ALIGN RIGHT	// #"COD 08"
			DEFINE CELL NAME "PDTOTAL" 		OF oSection3 				TITLE STR0030+CRLF+STR0031 PICTURE "@E 999,999,999.99" SIZE 11 BLOCK  bTipHHrsTT ALIGN RIGHT	// ### TOTAL ### DE HORAS
			DEFINE CELL NAME "PDTOTDI" 		OF oSection3 				TITLE STR0030+CRLF+STR0062 PICTURE "@E 9999" SIZE 3 BLOCK  bTipHHrsTD ALIGN RIGHT	// ### TOTAL ### DE DIAS
			DEFINE CELL NAME "PDTOTVL" 		OF oSection3 				TITLE STR0030+CRLF+STR0063 PICTURE "@E 999,999,999.99" SIZE 11 BLOCK  bTipHHrsTV ALIGN RIGHT	// ### TOTAL ### DE VALOR

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PrintRepor³ Autor ³ Ricardo Duarte Costa  ³ Data ³ 21.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do relatorio                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PrintReport(oReport)

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Acessa parametros do relatorio...                                        ³
³ Variaveis utilizadas para parametros                                     ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/

nSinAna    := MV_PAR05				//Relatorio Analitico ou Sintetica
cSituacao  := MV_PAR06				//Situacoes a Imprimir
cCateg     := MV_PAR07				//Categorias a Imprimir
lTodos     := (MV_PAR08==1)			//Se lista todos os codigos encontrados
cCodigos   := ALLTRIM(MV_PAR09)		//Codigos a Listar
nVerHor    := IF(lTodos .Or. Len(cCodigos)/3 > 8,1,MV_PAR10) //Formato de Impressao. Vertical somente quando selecionar menos de 15 verbas
lConsidPer := (MV_PAR11==1)			//Considera Periodo de Apontamento
dPerMVIni  := MV_PAR12				//Periodo Inicial
dPerMVFim  := MV_PAR13				//Periodo Final
lSexaCent  := MV_PAR14 == 1			//Horas em  (Sexagesimal/Centesimal)

If nVerHor == 1
	RepVertical(oReport)
Else
	RepHorizontal(oReport)
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³RepVertical  ³ Autor ³ Ricardo Duarte Costa  ³ Data ³ 21.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do relatorio                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function RepVertical(oReport)
                     
//-- Objeto
Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oReport:Section(1):Section(1)

//-- String
Local cFiltroSRA	:= ""  
Local cFiltroSPB	:= ""
Local cQVerba		:= ""  
Local cAcessaSRA	:= &( " { || " + ChkRH( "PONR090" , "SRA" , "2" ) + " } " )
Local cPerg			:= "PO090R"
Local cPerIni		:= ""
Local cPerFim		:= ""
Local cFiltraPd		:= ""
Local cOrdem		:= ""
Local cTitMat		:= ""       
Local cTitCc		:= ""  
Local cTitFil		:= ""
Local cFilSpb		:= ""
Local cFilSrv		:= ""
Local cFunction		:= If(lSexaCent,"TIMESUM","SUM")

//-- Numerica
Local nOrdem   		:= oReport:Section(1):GetOrder()
Local nVer			:= 0
Local nReg			:= 0

//-- Data
Local dPerIni    := Ctod("  /  /  ")
Local dPerFim    := Ctod("  /  /  ")

//-- Array
Local aInfo			:= {}
Local cTexto        := ""
                        
If nSinAna == 2
	DEFINE BREAK oBreakMat	OF oReport WHEN oSection1:Cell("RA_MAT") 	TITLE STR0050		// ### T O T A L ### DO FUNCIONARIO
	TRFunction():New(oSection2:Cell("PB_HORAS"),,cFunction,oBreakMat,,"@E 9,999,999.99",,.F.,.F.)
	TRFunction():New(oSection2:Cell("PB_DIAS"),,"SUM",oBreakMat,,"@E 999,9999",,.F.,.F.)
	TRFunction():New(oSection2:Cell("PB_VALOR"),,"SUM",oBreakMat,,"@E 9,999,999.99",,.F.,.F.)
	oBreakMat:OnBreak({|x,y|cTitMat:=OemToAnsi(STR0050)+x})	//"TOTAL DO FUNCIONARIO"
    oBreakMat:SetTotalText({||cTitMat})  
           
Endif

//Centro de Custo ou C.Custo + Nome - ANALITICO
If ( nOrdem == 2 .Or. nOrdem == 4 ) .And. nSinAna == 2

	DEFINE BREAK oBreakCc	OF oReport WHEN oSection1:Cell("RA_CC") 	
	TRFunction():New(oSection2:Cell("PB_HORAS"),,cFunction,oBreakCC,,"@E 9,999,999.99",,.F.,.F.)
	TRFunction():New(oSection2:Cell("PB_DIAS"),,"SUM",oBreakCC,,"@E 999,9999",,.F.,.F.)
	TRFunction():New(oSection2:Cell("PB_VALOR"),,"SUM",oBreakCC,,"@E 9,999,999.99",,.F.,.F.)
	oBreakCc:OnBreak({|x,y|cTitCc:=OemToAnsi(STR0051)+x+" - "+fDesc("CTT",x,"CTT->CTT_DESC01",,oBreak:GetLastValue())})	//"TOTAL DO CENTRO DE CUSTO"
    oBreakCc:SetTotalText({||cTitCc})

	DEFINE COLLECTION OF oSection2 FUNCTION COUNT FORMULA {|| oSection2:Cell("PB_PD"):GetValue(.T.) + " - " + Left(oSection2:Cell("RV_DESC"):GetValue(.T.)+Space(20),20)+"."} CONTENT oSection2:Cell("PB_PD") 		BREAK oBreakCc TITLE OemToAnsi(STR0032)	PICTURE "999"			NO END REPORT NO END SECTION			//"TOT. LINHAS"
	If lSexaCent
		DEFINE COLLECTION OF oSection2 FUNCTION TIMESUM FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_HORAS")	BREAK oBreakCc TITLE OemToAnsi(STR0033)	PICTURE "@E 999,999.99"	NO END REPORT NO END SECTION			//"Horas"
	Else
		DEFINE COLLECTION OF oSection2 FUNCTION SUM     FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_HORAS")	BREAK oBreakCc TITLE OemToAnsi(STR0033)	PICTURE "@E 999,999.99"	NO END REPORT NO END SECTION			//"Horas"
	EndIf                                              
	DEFINE COLLECTION OF oSection2 FUNCTION SUM 	FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_DIAS")	BREAK oBreakCc TITLE OemToAnsi(STR0060) PICTURE "@E 999" NO END REPORT NO END SECTION 						//"Dias"
	DEFINE COLLECTION OF oSection2 FUNCTION SUM 	FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_VALOR")	BREAK oBreakCc TITLE OemToAnsi(STR0061) PICTURE "@E 999,999,999.99"	NO END REPORT NO END SECTION 			//"Valor"

	DEFINE BREAK oBreak 	OF oReport WHEN oSection1:Cell("RA_FILIAL")	
	TRFunction():New(oSection2:Cell("PB_HORAS"),,cFunction,oBreak,,"@E 9,999,999.99",,.F.,.T.)
	TRFunction():New(oSection2:Cell("PB_DIAS"),,"SUM",oBreak,,"@E 999,999",,.F.,.T.)
	TRFunction():New(oSection2:Cell("PB_VALOR"),,"SUM",oBreak,,"@E 9,999,999.99",,.F.,.T.)
	oBreak:OnBreak({|x,y| fInfo(@aInfo,x),cTitFil:=OemToAnsi(STR0052)+x+" - "+aInfo[1]})	//"TOTAL DA FILIAL"
	oBreak:SetTotalText({||cTitFil})
	
	DEFINE COLLECTION OF oSection2 FUNCTION COUNT FORMULA {|| oSection2:Cell("PB_PD"):GetValue(.T.) + " - " + Left(oSection2:Cell("RV_DESC"):GetValue(.T.)+Space(20),20)+"."} CONTENT oSection2:Cell("PB_PD") 		BREAK oBreak TITLE OemToAnsi(STR0032) PICTURE "999"			NO END SECTION			//"TOT. LINHAS"
	If lSexaCent
		DEFINE COLLECTION OF oSection2 FUNCTION TIMESUM FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_HORAS")	BREAK oBreak TITLE OemToAnsi(STR0033) PICTURE "@E 999,999.99"	NO END SECTION 			//"Horas"
	Else
		DEFINE COLLECTION OF oSection2 FUNCTION SUM 	FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_HORAS")	BREAK oBreak TITLE OemToAnsi(STR0033) PICTURE "@E 999,999.99"	NO END SECTION 			//"Horas"
	EndIf	
	DEFINE COLLECTION OF oSection2 FUNCTION SUM 	FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_DIAS")	BREAK oBreak TITLE OemToAnsi(STR0060) PICTURE "@E 999" NO END SECTION 						//"Dias"
	DEFINE COLLECTION OF oSection2 FUNCTION SUM 	FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_VALOR")	BREAK oBreak TITLE OemToAnsi(STR0061) PICTURE "@E 999,999,999.99"	NO END SECTION 			//"Valor"

//Centro de Custo ou C.Custo + Nome - SINTETICO	
ElseIf ( nOrdem == 2 .Or. nOrdem == 4 ) .And. nSinAna == 1

	DEFINE BREAK oBreakCc	OF oReport WHEN oSection1:Cell("RA_CC") 	
	TRFunction():New(oSection2:Cell("PB_HORAS"),,cFunction,oBreakCC,,"@E 9,999,999.99",,.F.,.F.)
	TRFunction():New(oSection2:Cell("PB_DIAS"),,"SUM",oBreakCC,,"@E 999,9999",,.F.,.F.)
	TRFunction():New(oSection2:Cell("PB_VALOR"),,"SUM",oBreakCC,,"@E 9,999,999.99",,.F.,.F.)
	oBreakCc:OnBreak({|x,y| oReport:SetRow(305), cTitCc:=OemToAnsi(STR0051)+x+" - "+fDesc("CTT",x,"CTT->CTT_DESC01",10,oBreak:GetLastValue())})	//"TOTAL DO CENTRO DE CUSTO"
    oBreakCc:SetTotalText({||cTitCc})
	oBreakCc:SetPageBreak()
	
	DEFINE COLLECTION OF oSection2 FUNCTION COUNT FORMULA {|| oSection2:Cell("PB_PD"):GetValue(.T.) + " - " + Left(oSection2:Cell("RV_DESC"):GetValue(.T.)+Space(20),20)+"."} CONTENT oSection2:Cell("PB_PD") 		BREAK oBreakCc TITLE OemToAnsi(STR0032)	PICTURE "999"			NO END REPORT NO END SECTION			//"TOT. LINHAS"
	If lSexaCent
		DEFINE COLLECTION OF oSection2 FUNCTION TIMESUM FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_HORAS")	BREAK oBreakCc TITLE OemToAnsi(STR0033)	PICTURE "@E 999,999.99"	NO END REPORT NO END SECTION			//"Horas"
	Else
		DEFINE COLLECTION OF oSection2 FUNCTION SUM     FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_HORAS")	BREAK oBreakCc TITLE OemToAnsi(STR0033)	PICTURE "@E 999,999.99"	NO END REPORT NO END SECTION			//"Horas"
	EndIf                                              
	DEFINE COLLECTION OF oSection2 FUNCTION SUM 	FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_DIAS")	BREAK oBreakCc TITLE OemToAnsi(STR0060)  PICTURE "@E 999" NO END REPORT NO END SECTION 						//"Dias"
	DEFINE COLLECTION OF oSection2 FUNCTION SUM 	FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_VALOR")	BREAK oBreakCc TITLE OemToAnsi(STR0061) PICTURE "@E 999,999,999.99"	NO END REPORT NO END SECTION 			//"Valor"
	
	DEFINE BREAK oBreak 	OF oReport WHEN oSection1:Cell("RA_FILIAL")	
	TRFunction():New(oSection2:Cell("PB_HORAS"),,cFunction,oBreak,,"@E 9,999,999.99",,.F.,.T.)
	TRFunction():New(oSection2:Cell("PB_DIAS"),,"SUM",oBreak,,"@E 999,999",,.F.,.T.)
	TRFunction():New(oSection2:Cell("PB_VALOR"),,"SUM",oBreak,,"@E 9,999,999.99",,.F.,.T.)
	oBreak:OnBreak({|x,y| fInfo(@aInfo,x),cTitFil:=OemToAnsi(STR0052)+x+" - "+aInfo[1]})	//"TOTAL DA FILIAL"
	oBreak:SetTotalText({||cTitFil})
	oBreak:SetPageBreak()
	
	DEFINE COLLECTION OF oSection2 FUNCTION COUNT FORMULA {|| oSection2:Cell("PB_PD"):GetValue(.T.) + " - " + Left(oSection2:Cell("RV_DESC"):GetValue(.T.)+Space(20),20)+"."} CONTENT oSection2:Cell("PB_PD") 		BREAK oBreak TITLE OemToAnsi(STR0032) PICTURE "999"			NO END SECTION			//"TOT. LINHAS"
	If lSexaCent
		DEFINE COLLECTION OF oSection2 FUNCTION TIMESUM FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_HORAS")	BREAK oBreak TITLE OemToAnsi(STR0033) PICTURE "@E 999,999.99"	NO END SECTION 			//"Horas"
	Else
		DEFINE COLLECTION OF oSection2 FUNCTION SUM 	FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_HORAS")	BREAK oBreak TITLE OemToAnsi(STR0033) PICTURE "@E 999,999.99"	NO END SECTION 			//"Horas"
	EndIf
	DEFINE COLLECTION OF oSection2 FUNCTION SUM 	FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_DIAS")	BREAK oBreak TITLE OemToAnsi(STR0060) PICTURE "@E 999"	NO END SECTION 						//"Dias"
	DEFINE COLLECTION OF oSection2 FUNCTION SUM 	FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_VALOR")	BREAK oBreak TITLE OemToAnsi(STR0061) PICTURE "@E 999,999,999.99"	NO END SECTION 			//"Valor"

EndIf

//Matricula ou Nome - ANALITICO	
If ( nOrdem == 1 .Or. nOrdem == 3 ) .And. nSinAna == 2

	DEFINE BREAK oBreak 	OF oReport WHEN oSection1:Cell("RA_FILIAL")	
	TRFunction():New(oSection2:Cell("PB_HORAS"),,cFunction,oBreak,,"@E 9,999,999.99",,.F.,.T.)
	TRFunction():New(oSection2:Cell("PB_DIAS"),,"SUM",oBreak,,"@E 999,999",,.F.,.T.)
	TRFunction():New(oSection2:Cell("PB_VALOR"),,"SUM",oBreak,,"@E 9,999,999.99",,.F.,.T.)
	oBreak:OnBreak({|x,y| fInfo(@aInfo,x),cTitFil:=OemToAnsi(STR0052)+x+" - "+aInfo[1]})	//"TOTAL DA FILIAL"
	oBreak:SetTotalText({||cTitFil})
	
	DEFINE COLLECTION OF oSection2 FUNCTION COUNT FORMULA {|| oSection2:Cell("PB_PD"):GetValue(.T.) + " - " + Left(oSection2:Cell("RV_DESC"):GetValue(.T.)+Space(20),20)+"."} CONTENT oSection2:Cell("PB_PD") 		BREAK oBreak TITLE OemToAnsi(STR0032) PICTURE "999"			NO END SECTION			//"TOT. LINHAS"
	If lSexaCent
		DEFINE COLLECTION OF oSection2 FUNCTION TIMESUM FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_HORAS")	BREAK oBreak TITLE OemToAnsi(STR0033) PICTURE "@E 999,999.99"	NO END SECTION 			//"Horas"
	Else
		DEFINE COLLECTION OF oSection2 FUNCTION SUM 	FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_HORAS")	BREAK oBreak TITLE OemToAnsi(STR0033) PICTURE "@E 999,999.99"	NO END SECTION 			//"Horas"
	EndIf  
	DEFINE COLLECTION OF oSection2 FUNCTION SUM 	FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_DIAS")	BREAK oBreak TITLE OemToAnsi(STR0060) 	PICTURE "@E 999" NO END SECTION 					//"Dias"
	DEFINE COLLECTION OF oSection2 FUNCTION SUM 	FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_VALOR")	BREAK oBreak TITLE OemToAnsi(STR0061) PICTURE "@E 999,999,999.99"	NO END SECTION 			//"Valor"

//Matricula ou Nome - SINTETICO		
ElseIf ( nOrdem == 1 .Or. nOrdem == 3 ) .And. nSinAna == 1

	DEFINE BREAK oBreak 	OF oReport WHEN oSection1:Cell("RA_FILIAL")	
	TRFunction():New(oSection2:Cell("PB_HORAS"),,cFunction,oBreak,,"@E 9,999,999.99",,.F.,.T.)
	TRFunction():New(oSection2:Cell("PB_DIAS"),,"SUM",oBreak,,"@E 999,999",,.F.,.T.)
	TRFunction():New(oSection2:Cell("PB_VALOR"),,"SUM",oBreak,,"@E 9,999,999.99",,.F.,.T.)
	
	cTexto := space (35) + OemToAnsi(STR0033)
	cTexto += space (10) + OemToAnsi(STR0060)
	cTexto += space (10) + OemToAnsi(STR0061)
	
	oBreak:OnBreak({|x,y| oReport:SetRow(305), fInfo(@aInfo,x),cTitFil:=OemToAnsi(STR0052)+x+" - "+aInfo[1]})	//"TOTAL DA FILIAL"
	oBreak:SetTotalText({||cTitFil}) 
	oBreak:SetPageBreak()
	
	DEFINE COLLECTION OF oSection2 FUNCTION COUNT FORMULA {|| oSection2:Cell("PB_PD"):GetValue(.T.) + " - " + Left(oSection2:Cell("RV_DESC"):GetValue(.T.)+Space(20),20)+"."} CONTENT oSection2:Cell("PB_PD") 		BREAK oBreak TITLE OemToAnsi(STR0032) PICTURE "999"			NO END SECTION			//"TOT. LINHAS"
	If lSexaCent
		DEFINE COLLECTION OF oSection2 FUNCTION TIMESUM FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_HORAS")	BREAK oBreak TITLE OemToAnsi(STR0033) PICTURE "@E 999,999.99"	NO END SECTION 			//"Horas"
	Else
		DEFINE COLLECTION OF oSection2 FUNCTION SUM 	FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_HORAS")	BREAK oBreak TITLE OemToAnsi(STR0033) PICTURE "@E 999,999.99"	NO END SECTION 			//"Horas"
	EndIf  	
	DEFINE COLLECTION OF oSection2 FUNCTION SUM 	FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_DIAS")	BREAK oBreak TITLE OemToAnsi(STR0060) PICTURE "@E 999"	NO END SECTION 						//"Dias"
	DEFINE COLLECTION OF oSection2 FUNCTION SUM 	FORMULA oSection2:Cell("PB_PD") CONTENT oSection2:Cell("PB_VALOR")	BREAK oBreak TITLE OemToAnsi(STR0061) PICTURE "@E 999,999,999.99"	NO END SECTION 			//"Valor"

	oReport:OnPageBreak({||oReport:SkipLine(1), oReport:Printtext(cTexto),oReport:ThinLine()}) 
EndIf	

//-- Parƒmetro MV_PAPONTA
//-- Se Considerar Periodo de Apontamento
If lConsidPer
   If !PerAponta(@dPerIni,@dPerFim)
    	Return Nil
   Endif
Endif

//-- Monta string de periodo a ser utilizado para os filtros
If !lConsidPer
	dPerIni	:= dPerMVIni
	dPerFim	:= dPerMVFim
Endif
cPerIni		:= dtos(dPerIni)
cPerFim		:= dtos(dPerFim)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz filtro no arquivo...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cAliasSRA := GetNextAlias()
cAliasSPB := cAliasSRA

MakeSqlExpr(cPerg)

//-- Filtro das verbas
cQVerba 	:= ""
cFiltraPd	:= "%%"
If !lTodos
	For nReg:=1 to Len(cCodigos) Step 3
		cQVerba += "'"+Subs(cCodigos,nReg,3)+"'"
		If ( nReg+3 ) <= Len(cCodigos)
			cQVerba += "," 
		Endif
	Next nReg
	If !Empty(cQVerba)
		cFiltraPd	:= '% SPB.PB_PD IN('+Upper(cQVerba)+') AND %'
	EndIf	
Endif
//-- Eliminar o AND da string, sera incluido no select
//-- Filtro de Situacoes a imprimir
cSituacao	:= "% SRA.RA_SITFOLH IN("
For nReg:= 1 to Len(MV_PAR06)
	cSituacao  += "'"+substr(MV_PAR06,nReg,1)+"',"
next nReg
cSituacao	:= substr(cSituacao,1,len(cSituacao)-1)
cSituacao	+= ") %"

//-- Filtro de Categorias a imprimir
cCateg		:= "% SRA.RA_CATFUNC IN("
For nReg:= 1 to Len(MV_PAR07)
	cCateg	+= "'"+substr(MV_PAR07,nReg,1)+"',"
next nReg
cCateg		:= substr(cCateg,1,len(cCateg)-1)
cCateg		+= ") %"

//-- String da ordem e passar conforme a ordem selecionada no relatorio
If nOrdem == 1						//Matricula
	cOrdem	:= '%'+SqlOrder( SRA->( IndexKey(1) ) )+', PB_PD %'
ElseIf nOrdem == 2					//Centro de Custo
	cOrdem	:= '%'+SqlOrder( SRA->( IndexKey(2) ) )+', PB_PD %'
ElseIf nOrdem == 3					//Nome
	cOrdem	:= '%'+SqlOrder( SRA->( IndexKey(3) ) )+', PB_PD %'
ElseIf nOrdem == 4					//Centro de Custo + Nome
	cOrdem	:= '%'+SqlOrder( SRA->( IndexKey(8) ) )+', PB_PD %'
EndIf     

//-- Trata Filial para query
cFilSpb	:= '%'+ FWJoinFilial("SPB", "SRA") +'%'
cFilSrv	:= '%'+ FWJoinFilial("SRV", "SRA") +'%'

//-- Query a ser executada para a section 1
BEGIN REPORT QUERY oSection1

	BeginSql alias cAliasSRA                             

		SELECT 	RA_FILIAL, RA_MAT, RA_NOME, PB_PD, RV_DESC,RV_TIPOCOD, PB_TIPO1, PB_HORAS, PB_VALOR, PB_FILIAL, PB_MAT, RA_SITFOLH, RA_CATFUNC, RA_CC
	
		FROM %table:SPB% SPB, %table:SRA% SRA, %table:SRV% SRV
	
		WHERE 	SRA.RA_MAT = SPB.PB_MAT AND 
				SPB.PB_PD = SRV.RV_COD AND 
				%exp:cFiltraPd% 
				SPB.PB_DATA >= %exp:cPerIni% AND SPB.PB_DATA <= %exp:cPerFim% AND
				%exp:cFilSrv% AND 
				%exp:cFilSpb% AND 
				%exp:cSituacao% AND %exp:cCateg% AND
			   	SPB.%notDel% AND SRA.%notDel% AND SRV.%notDel%

		ORDER BY %exp:cOrdem%

	EndSql

END REPORT QUERY oSection1 PARAM MV_PAR01, MV_PAR02, MV_PAR03, MV_PAR04

//Instrucao para utilizar o resultado (dados) do filtro da section 1 para a section 2
oSection2:SetParentQuery()

//-- Condicao para a impressao da linha
//-- Pode ser usado uma linecondition para cada uma das sections.
oSection1:SetLineCondition({|| (cAliasSRA)->( ( RA_FILIAL $ fValidFil() ) .And. Eval( cAcessaSRA ) )} )

//-- Relacionamento da section pai com a section filha para determinar ate onde deverao ser impressos os registros
oSection2:SetParentFilter({|cParam| (cAliasSPB)->PB_FILIAL + (cAliasSPB)->PB_MAT == cParam},{|| (cAliasSRA)->RA_FILIAL + (cAliasSRA)->RA_MAT })

//-- Inibe a exibicao das informacoes de funcionarios
If nSinAna == 1
	oSection1:Hide()
	
	If ( nOrdem == 1 .Or. nOrdem == 3 )
		oSection2:Hide()
	Else
		oSection2:SetHeaderPage(.T.)
	EndIf
	oSection2:Cell("PB_PD"):Hide()
	oSection2:Cell("RV_DESC"):Hide()
	oSection2:Cell("PB_HORAS"):Hide()
	oSection2:Cell("PB_DIAS"):Hide()
	oSection2:Cell("PB_VALOR"):Hide()
	oSection2:Cell("PB_PD"):SetTitle("")
	oSection2:Cell("RV_DESC"):SetTitle("")
Endif

//-- Guarda dados do primeiro registro
cUltFil	:= (cAliasSRA)->RA_FILIAL
cUltCc	:= (cAliasSRA)->RA_CC

//-- Impressao do relatorio
oSection1:Print()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³RepHorizontal³ Autor ³ Ricardo Duarte Costa  ³ Data ³ 21.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do relatorio                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function RepHorizontal(oReport)

//-- String
Local cFiltroSRA	:= ""  
Local cFiltroSPB	:= ""
Local cQVerba		:= ""  
Local cAcessaSRA	:= &( " { || " + ChkRH( "PONR090" , "SRA" , "2" ) + " } " )
Local cPerg			:= "PO090R"
Local cPerIni		:= ""
Local cPerFim		:= ""
Local cPDS			:= ""
Local cOrdem		:= ""
Local cFunction		:= If(lSexaCent,"TIMESUM","SUM")
Local cAux			:= "" 
Local cTitFil		:= ""
Local cTitCc		:= ""
Local cFilMatQry	:= ""

//-- Numerica
Local nOrdem   		:= oReport:Section(1):GetOrder()
Local nVer			:= 0
Local nReg			:= 0
Local nCont			:= 0
Local nx			:= 0

//-- Data
Local dPerIni    	:= Ctod("  /  /  ")
Local dPerFim    	:= Ctod("  /  /  ")

//-- Array
Local aInfo			:= {}
                        
//-- Objeto
Private oSection1 	:= oReport:Section(2)

//-- Variaveis montar a descricao dos totais
//Private	cUltFil	:= ""
//Private cUltCc	:= ""

	//-- Totais pela Ordem de Centro de Custo ou Centro de Custo + Nome -> ANALITICO
	If ( nOrdem == 2 .Or. nOrdem == 4 ) .And. nSinAna == 2
		oBreakCC 	:= TRBreak():New(oSection1, oSection1:Cell("RA_CC"))
		For nx := 1 to Len(cCodigos)/3
			TRFunction():New(oSection1:Cell("PD"+strzero(nx,2)),,cFunction,oBreakCC,,"@E 9,999,999.99",,.F.,.F.)
		next nx
		TRFunction():New(oSection1:Cell("PDTOTAL"),,cFunction,oBreakCC,,"@E 99,999,999.99",,.F.,.F.)
		TRFunction():New(oSection1:Cell("PDTOTDI"),,"SUM",oBreakCC,,"@E 999",,.F.,.F.)
		TRFunction():New(oSection1:Cell("PDTOTVL"),,"SUM",oBreakCC,,"@E 99,999,999.99",,.F.,.F.)
		oBreakCc:OnBreak({|x,y|cTitCc:=OemToAnsi(STR0051)+x+" - "+fDesc("CTT",x,"CTT->CTT_DESC01",,oBreak:GetLastValue())})	//"TOTAL DO CENTRO DE CUSTO"
	    oBreakCc:SetTotalText({||cTitCc})

	oBreak 	:= TRBreak():New(oSection1, oSection1:Cell("RA_FILIAL"))	//,{|| STR0052 + " " + fDescTot(2) })

	//-- Totalizacao da Filial
	For nx := 1 to Len(cCodigos)/3
		TRFunction():New(oSection1:Cell("PD"+strzero(nx,2)),,cFunction,oBreak,,"@E 9,999,999.99",,.F.,.T.)
	next nx
	TRFunction():New(oSection1:Cell("PDTOTAL"),,cFunction,oBreak,,"@E 99,999,999.99",,.F.,.T.)
	TRFunction():New(oSection1:Cell("PDTOTDI"),,"SUM",oBreak,,"@E 999",,.F.,.T.)
	TRFunction():New(oSection1:Cell("PDTOTVL"),,"SUM",oBreak,,"@E 99,999,999.99",,.F.,.T.)	
	oBreak:OnBreak({|x,y|fInfo(@aInfo,x),cTitFil:=OemToAnsi(STR0052)+x+" - "+aInfo[1]})	//"TOTAL DA FILIAL"
    oBreak:SetTotalText({||cTitFil})

	//-- Totais pela Ordem de Centro de Custo ou Centro de Custo + Nome => SINTETICO	
	ElseIf ( nOrdem == 2 .Or. nOrdem == 4 ) .And. nSinAna == 1  
		oBreakCC 	:= TRBreak():New(oSection1, oSection1:Cell("RA_CC"))
		For nx := 1 to Len(cCodigos)/3
			TRFunction():New(oSection1:Cell("PD"+strzero(nx,2)),,cFunction,oBreakCC,,"@E 9,999,999.99",,.F.,.F.)
		next nx
		TRFunction():New(oSection1:Cell("PDTOTAL"),,cFunction,oBreakCC,,"@E 99,999,999.99",,.F.,.F.)
		TRFunction():New(oSection1:Cell("PDTOTDI"),,"SUM",oBreakCC,,"@E 999",,.F.,.F.)
		TRFunction():New(oSection1:Cell("PDTOTVL"),,"SUM",oBreakCC,,"@E 99,999,999.99",,.F.,.F.)
		oBreakCc:OnBreak({|x,y| cTitCc:=OemToAnsi(STR0051)+x+" - "+fDesc("CTT",x,"CTT->CTT_DESC01",,oBreak:GetLastValue()),oReport:SetRow(325)})	//"TOTAL DO CENTRO DE CUSTO"
	    oBreakCc:SetTotalText({||cTitCc})
		oBreakCc:SetPageBreak()

		oBreak 	:= TRBreak():New(oSection1, oSection1:Cell("RA_FILIAL"))	//,{|| STR0052 + " " + fDescTot(2) })
	
		//-- Totalizacao da Filial
		For nx := 1 to Len(cCodigos)/3
			TRFunction():New(oSection1:Cell("PD"+strzero(nx,2)),,cFunction,oBreak,,"@E 9,999,999.99",,.F.,.T.)
		next nx
		TRFunction():New(oSection1:Cell("PDTOTAL"),,cFunction,oBreak,,"@E 99,999,999.99",,.F.,.T.)
		TRFunction():New(oSection1:Cell("PDTOTDI"),,"SUM",oBreak,,"@E 999",,.F.,.T.)
		TRFunction():New(oSection1:Cell("PDTOTVL"),,"SUM",oBreak,,"@E 99,999,999.99",,.F.,.T.)
		oBreak:OnBreak({|x,y| fInfo(@aInfo,x),cTitFil:=OemToAnsi(STR0052)+x+" - "+aInfo[1]})	//"TOTAL DA FILIAL"
	    oBreak:SetTotalText({||cTitFil}) 	
		oBreak:SetPageBreak()

	//Matricula ou Nome - ANALITICO	    
	ElseIf 	( nOrdem == 1 .Or. nOrdem == 3 ) .And. nSinAna == 2
		oBreak 	:= TRBreak():New(oSection1, oSection1:Cell("RA_FILIAL"))	//,{|| STR0052 + " " + fDescTot(2) })
	
		//-- Totalizacao da Filial
		For nx := 1 to Len(cCodigos)/3
			TRFunction():New(oSection1:Cell("PD"+strzero(nx,2)),,cFunction,oBreak,,"@E 9,999,999.99",,.F.,.T.)
		next nx
		TRFunction():New(oSection1:Cell("PDTOTAL"),,cFunction,oBreak,,"@E 99,999,999.99",,.F.,.T.)
		TRFunction():New(oSection1:Cell("PDTOTDI"),,"SUM",oBreak,,"@E 999",,.F.,.T.)
		TRFunction():New(oSection1:Cell("PDTOTVL"),,"SUM",oBreak,,"@E 99,999,999.99",,.F.,.T.)
		oBreak:OnBreak({|x,y| fInfo(@aInfo,x),cTitFil:=OemToAnsi(STR0052)+x+" - "+aInfo[1]})	//"TOTAL DA FILIAL"
	    oBreak:SetTotalText({||cTitFil})

	//Matricula ou Nome - SINTETICO
	ElseIf 	( nOrdem == 1 .Or. nOrdem == 3 ) .And. nSinAna == 1
		oBreak 	:= TRBreak():New(oSection1, oSection1:Cell("RA_FILIAL"))	//,{|| STR0052 + " " + fDescTot(2) }) 
	
		//-- Totalizacao da Filial
		For nx := 1 to Len(cCodigos)/3
			TRFunction():New(oSection1:Cell("PD"+strzero(nx,2)),,cFunction,oBreak,,"@E 9,999,999.99",,.F.,.T.)
		next nx
		TRFunction():New(oSection1:Cell("PDTOTAL"),,cFunction,oBreak,,"@E 99,999,999.99",,.F.,.T.) 
		TRFunction():New(oSection1:Cell("PDTOTDI"),,"SUM",oBreak,,"@E 999",,.F.,.T.)
		TRFunction():New(oSection1:Cell("PDTOTVL"),,"SUM",oBreak,,"@E 99,999,999.99",,.F.,.T.)
		oBreak:OnBreak({|x,y| oReport:SetRow(325), fInfo(@aInfo,x),cTitFil:=OemToAnsi(STR0052)+x+" - "+aInfo[1]})	//"TOTAL DA FILIAL"
	    oBreak:SetTotalText({||cTitFil})
	    oBreak:SetPageBreak()	

	Endif

	//-- Parƒmetro MV_PAPONTA
	//-- Se Considerar Periodo de Apontamento
	If lConsidPer
	   If !PerAponta(@dPerIni,@dPerFim)
	    	Return Nil
	   Endif
	Endif

	//-- Monta string de periodo a ser utilizado para os filtros
	If !lConsidPer
		dPerIni	:= dPerMVIni
		dPerFim	:= dPerMVFim
	Endif
	cPerIni		:= dtos(dPerIni)
	cPerFim		:= dtos(dPerFim)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz filtro no arquivo...                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cAliasSRA	:= GetNextAlias()
	cAliasSPB	:= cAliasSRA

	MakeSqlExpr(cPerg)

	//-- Filtro das verbas
	cPDS		:= "%"
	nCont		:= 0
	If !lTodos
		For nReg:=1 to Len(cCodigos) Step 3
			If ( nReg+2 ) <= Len(cCodigos)
				nCont ++
				cPDS	+= ", (SELECT (CASE WHEN SPB.PB_TIPO1 = 'V' THEN SUM(SPB.PB_VALOR) ELSE SUM(SPB.PB_HORAS) END) FROM "+RetSqlName("SPB")+" SPB where SPB.PB_FILIAL = SRA.RA_FILIAL "
				cPDS	+= "and SPB.PB_MAT = SRA.RA_MAT and SPB.PB_PD = '"+Subs(cCodigos,nReg,3)
				cPDS	+= "' and SPB.PB_DATA BETWEEN '"+cPerIni+"' AND '"+cPerFim+"' AND SPB.D_E_L_E_T_ = ' ' "
				cPDS	+= "GROUP BY SPB.PB_TIPO1 ) "
				cPDS	+= "PD"+strzero(nCont,2)+" "
				
				cPDS	+= ", (SELECT SPB.PB_TIPO1 FROM "+RetSqlName("SPB")+" SPB where SPB.PB_FILIAL = SRA.RA_FILIAL "
				cPDS	+= "and SPB.PB_MAT = SRA.RA_MAT and SPB.PB_PD = '"+Subs(cCodigos,nReg,3)
				cPDS	+= "' and SPB.PB_DATA BETWEEN '"+cPerIni+"' AND '"+cPerFim+"' AND SPB.D_E_L_E_T_ = ' ' "
				cPDS	+= "GROUP BY SPB.PB_TIPO1 ) "
				cPDS	+= "TP"+strzero(nCont,2)+" "  
				
				cPDS	+= ", (SELECT RV_TIPOCOD FROM " +RetSqlName("SRV")+" SRV where SRV.RV_FILIAL = '" + Fwxfilial('SRV') + "' "
				cPDS	+= "and SRV.RV_COD = '"+Subs(cCodigos,nReg,3) + "' AND SRV.D_E_L_E_T_ = ' ' ) "
				cPDS	+= "RVCOD"+strzero(nCont,2)+" "
			Endif
		Next nReg
	Endif
	cPDS	+= "%"
	
	//-- Filtro de Situacoes a imprimir
	cSituacao	:= "% SRA.RA_SITFOLH IN("
	For nReg:= 1 to Len(MV_PAR06)
		cSituacao  += "'"+substr(MV_PAR06,nReg,1)+"',"
	next nReg
	cSituacao	:= substr(cSituacao,1,len(cSituacao)-1)
	cSituacao	+= ") %"
	
	//-- Filtro de Categorias a imprimir
	cCateg		:= "% SRA.RA_CATFUNC IN("
	For nReg:= 1 to Len(MV_PAR07)
		cCateg	+= "'"+substr(MV_PAR07,nReg,1)+"',"
	next nReg
	cCateg		:= substr(cCateg,1,len(cCateg)-1)
	cCateg		+= ") %"
	
	cFilMatQry := "% "

	If !Empty(MV_PAR01)
		cFilMatQry += MV_PAR01 + " AND "
	EndIf

	If !Empty(MV_PAR03)
		cFilMatQry += MV_PAR03 + " AND "
	EndIf

	cFilMatQry += " %"
	
	//-- String da ordem e passar conforme a ordem selecionada no relatorio
	If nOrdem == 1						//Matricula
		cOrdem	:= '%'+SqlOrder( SRA->( IndexKey(1) ) )+' %'
	ElseIf nOrdem == 2					//Centro de Custo
		cOrdem	:= '%'+SqlOrder( SRA->( IndexKey(2) ) )+' %'
	ElseIf nOrdem == 3					//Nome
		cOrdem	:= '%'+SqlOrder( SRA->( IndexKey(3) ) )+' %'
	ElseIf nOrdem == 4					//Centro de Custo + Nome
		cOrdem	:= '%'+SqlOrder( SRA->( IndexKey(8) ) )+' %'
	EndIf
	
	//-- Query a ser executada para a section 1
	BEGIN REPORT QUERY oSection1

		BeginSql alias cAliasSRA                             

			SELECT SRA.RA_FILIAL, SRA.RA_CC, SRA.RA_MAT, SRA.RA_NOME, SRA.RA_SITFOLH, SRA.RA_CATFUNC
					%exp:cPDS%
		
			FROM %table:SRA% SRA
		
			WHERE 	%exp:cSituacao% AND %exp:cCateg% AND %exp:cFilMatQry% SRA.%notDel%

			ORDER BY %exp:cOrdem%

		EndSql

	END REPORT QUERY oSection1 PARAM MV_PAR02, MV_PAR04

	//-- Condicao para a impressao da linha
	//-- Pode ser usado uma linecondition para cada uma das sections.
	oSection1:SetLineCondition({|| (cAliasSRA)->( ( RA_FILIAL $ fValidFil() ) .And. Eval( cAcessaSRA ) .And. ;
									fCondLinha() ) } )

	//-- Ajuste do titulo das colunas
	nCont := 0
	For nx := 1 to Len(cCodigos) step 3
		nCont ++
		If ( nx+2 ) <= Len(cCodigos)
			cAux	:= FVerba(Substr(cCodigos,nx,3),10,(cAliasSRA)->RA_FILIAL,.F.)
			cAux	:= Substr(cAux,1,09)+CRLF+Substr(cAux,10,09)
			oSection1:Cell("PD"+strzero(nCont,2)):SetTitle(cAux)
		Endif
	next nx
	
	oSection1:Cell("PD09"):Disable()
	oSection1:Cell("PD09"):SetBlock({|| 0.00})
	
	//-- Desabilita as demais celulas pois as mesmas nao serao impressas
	For nReg := nCont + 1 to 8
		oSection1:Cell("PD"+strzero(nReg,2)):Disable()
		oSection1:Cell("PD"+strzero(nReg,2)):SetBlock({|| 0.00})
	Next nReg

	//-- Inibe a exibicao das informacoes de funcionarios
	If nSinAna == 1
		oSection1:SetHeaderPage(.T.)	
		oSection1:Cell("RA_FILIAL"):Hide()
		oSection1:Cell("RA_CC"):Hide()
		oSection1:Cell("RA_MAT"):Hide()
		oSection1:Cell("RA_NOME"):Hide()
		oSection1:Cell("RA_FILIAL"):SetTitle("")
		oSection1:Cell("RA_CC"):SetTitle("")
		oSection1:Cell("RA_MAT"):SetTitle("")
		oSection1:Cell("RA_NOME"):SetTitle("")
		oSection1:Cell("PD01"):Hide()
		oSection1:Cell("PD02"):Hide()
		oSection1:Cell("PD03"):Hide()
		oSection1:Cell("PD04"):Hide()
		oSection1:Cell("PD05"):Hide()
		oSection1:Cell("PD06"):Hide()
		oSection1:Cell("PD07"):Hide()
		oSection1:Cell("PD08"):Hide()
		oSection1:Cell("PDTOTAL"):Hide()	
		oSection1:Cell("PDTOTDI"):Hide()	
		oSection1:Cell("PDTOTVL"):Hide()	
	Endif

	//-- Guarda dados do primeiro registro
	cUltFil	:= (cAliasSRA)->RA_FILIAL
	cUltCc	:= (cAliasSRA)->RA_CC
	
	//-- Impressao do relatorio
	oSection1:Print()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fSomaTot       ³ Autor ³ Ricardo Duarte   ³ Data ³05/09/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Funcao que retorna a coluna PDTOTAL                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ A partir do Release 4                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fSomaTot(cTipo)

Local nValor	:= 0
Local nx		:= 0

For nx := 1 to 8
	If (cAliasSRA)->(ColumnPos("PD"+strzero(nx,2))) > 0
		If cTipo $ "H*C" .And. (cAliasSRA)->&("TP"+strzero(nx,2)) == "H"
			If cTipo == "H"
				nValor := __TimeSum(nValor,oSection1:Cell("PD"+strzero(nx,2)):GetValue(.T.))
			Else
				nValor += oSection1:Cell("PD"+strzero(nx,2)):GetValue(.T.)
			EndIf
		ElseIf cTipo == "D" .And. (cAliasSRA)->&("TP"+strzero(nx,2)) == "D"
			nValor += oSection1:Cell("PD"+strzero(nx,2)):GetValue(.T.)	
		ElseIf cTipo == "V" .And. (cAliasSRA)->&("TP"+strzero(nx,2)) == "V"
			nValor += oSection1:Cell("PD"+strzero(nx,2)):GetValue(.T.)	
		EndIf
	EndIf
Next nx

Return(nValor)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fCondLinha     ³ Autor ³ Ricardo Duarte   ³ Data ³23/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Condicao para imprimir a linha horizontal                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ A partir do Release 4 - SO PARA TOP                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fCondLinha()

Local nValor	:= 0
Local nx		:= 0

For nx := 1 to Len(cCodigos)/3
	nValor += &("PD"+strzero(nx,2))
Next nx

Return(nValor>0)

Static Function CriaTRBSRA()


Local aArea		:= GetArea()
Local aCampos	:= {}
Local aTamFil	:= TamSx3("RA_FILIAL ")
Local aTamCC	:= TamSx3("RA_CC     ")
Local aTamMat	:= TamSx3("RA_MAT    ")
Local aTamNome	:= TamSx3("RA_NOME   ")
Local aTamDepto := TamSx3("RA_DEPTO  ")
Local aTamHoras	:= TamSx3("PB_HORAS  ")
Local cArq1		:= ""
Local cArq2		:= ""
Local cArq3		:= ""
Local cArq4		:= ""
Local cArq5		:= ""
Local cChave	:= ""
Local nx		:= 0
Local aLista    := {}
Local aLstIndices := {}

aAdd( aCampos, { "RA_FILIAL"	,"C",aTamFil[1]		,aTamFil[2] } )
aAdd( aCampos, { "RA_CC"	,"C",aTamCC[1]		,aTamCC[2] } )
aAdd( aCampos, { "RA_MAT"	,"C",aTamMat[1]		,aTamMat[2] } )
aAdd( aCampos, { "RA_NOME"	,"C",aTamNome[1]	,aTamNome[2] } )
aAdd( aCampos, { "RA_DEPTO"     ,"C",aTamDepto[1]   ,aTamDepto[2] } )

For nx := 1 to 10
	aAdd( aCampos, { "PD"+STRZERO(NX,2),"N",aTamHoras[1],aTamHoras[2] } )
next nx


aLista :=StrToArray(SRA->( IndexKey(1) ),"+")
AAdd( aLstIndices, aLista)
aLista :=StrToArray(SRA->( IndexKey(2) ),"+")
AAdd( aLstIndices, aLista)
aLista :=StrToArray(SRA->( IndexKey(3) ),"+")
AAdd( aLstIndices, aLista)
aLista :=StrToArray(SRA->( IndexKey(8) ),"+")
AAdd( aLstIndices, aLista)
aLista :=StrToArray(SRA->( IndexKey(22) ),"+")
AAdd( aLstIndices, aLista)

oTmpTRBSRA := RhCriaTrab('TRBSRA', aCampos, aLstIndices)


dbSelectArea( "TRBSRA" )
dbSetOrder(1)

RestArea(aArea)


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GeraTRBSRA    ³ Autor ³ Ricardo Duarte   ³ Data ³11/09/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Gera o arquivo temporario para a impressao horizontal.     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ A partir do Release 4                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GeraTRBSRA(cFiltroSRA,cAcessaSRA,nOrdem,cPerIni,cPerFim)

Local nVer		:= 0

Dbselectarea("SPB")
Dbsetorder(1)

Dbselectarea("SRA")
If nOrdem == 1
	Dbsetorder(1)
ElseIf nOrdem == 2
	Dbsetorder(2)
ElseIf nOrdem == 3
	Dbsetorder(3)
ElseIf nOrdem == 4
	Dbsetorder(8)
Endif
SRA->(DbGotop())

While !SRA->(Eof())	

	//-- Testa matricula e grava o arquivo temporario caso encontre quantidade de horas a imprimir.
	lImpFunc := SRA->(&cFiltroSRA) .And. SRA->( ( RA_FILIAL $ fValidFil() ) .And. Eval( cAcessaSRA ) )
	If lImpFunc

		//-- Pesquisa as verbas no movimento
		cQVerba		:= ""
		nValPD01	:= 	nValPD02	:= 	nValPD03	:= 	nValPD04	:= 	nValPD05	:= 0
		nValPD06	:= 	nValPD07	:= 	nValPD08	:= 	nValPD09	:= 	nValPD10	:= 0
		nValTot		:= 	nCont		:= 	nAux		:= 0
		cCodigos 	:= Alltrim(cCodigos)
		cAux		:= ""
		
		For nVer := 1 To Len(cCodigos) Step 3
			nCont	++
			nAux	:= 0
			cQVerba	:= Substr(cCodigos,nVer,3)
			cAux	:= ""
			If SPB->(Dbseek(SRA->(RA_FILIAL+RA_MAT)+cQVerba))
				While !SPB->(Eof()) .And. SRA->(RA_FILIAL+RA_MAT)+cQVerba == SPB->(PB_FILIAL+PB_MAT+PB_PD)
					If SPB->( Dtos(PB_DATA) >= cPerIni .AND. Dtos(PB_DATA) <= cPerFim )
						nAux	+= SPB->PB_HORAS
					Endif
					SPB->(Dbskip())
				Enddo
				cAux	:= "NVALPD"+strzero(nCont,2)
				&(cAux)	:= nAux
			Endif
		Next nVer

		nValTot	:= nValPD01	+ nValPD02 + nValPD03 + nValPD04 + nValPD05
		nValTot	+= nValPD06	+ nValPD07 + nValPD08 + nValPD09 + nValPD10

		//-- Gero registro do TRBSRA quando tiver horas a listas
		If nValTot > 0
			RecLock("TRBSRA",.T.)
			TRBSRA->RA_FILIAL	:= SRA->RA_FILIAL
			TRBSRA->RA_CC		:= SRA->RA_CC
			TRBSRA->RA_MAT		:= SRA->RA_MAT
			TRBSRA->RA_NOME		:= SRA->RA_NOME
			TRBSRA->PD01		:= nValPD01
			TRBSRA->PD02		:= nValPD02
			TRBSRA->PD03		:= nValPD03
			TRBSRA->PD04		:= nValPD04
			TRBSRA->PD05		:= nValPD05
			TRBSRA->PD06		:= nValPD06
			TRBSRA->PD07		:= nValPD07
			TRBSRA->PD08		:= nValPD08
			TRBSRA->PD09		:= nValPD09
			TRBSRA->PD10		:= nValPD10
			TRBSRA->(MsUnlock())
		Endif

	Endif
	SRA->(Dbskip())

Enddo

Return

**************************************
Static Function FVerba(cCod,nTam,cFil,lAlinha)
**************************************
Local aAreaSRA	:= (cAliasSRA)->(GetArea())	
Local cRet
Local lAchou	:= .F.

DEFAULT lAlinha := .T.

cRet := cCod + '-' + fDesc("SRV",cCod,"RV_DESC",nTam,cFil)

If !Empty( (cAliasSRA)->&("TP"+strzero((At(cCod, cCodigos) + 2) / 3,2)) )
	cRet += "(" + (cAliasSRA)->&("TP"+strzero((At(cCod, cCodigos) + 2) / 3,2)) + ")"
Else
	While (cAliasSRA)->( !EoF() )
		If !Empty( (cAliasSRA)->&("TP"+strzero((At(cCod, cCodigos) + 2) / 3,2)) )
			cRet	+= "(" + (cAliasSRA)->&("TP"+strzero((At(cCod, cCodigos) + 2) / 3,2)) + ")"
			lAchou	:= .T.
			Exit
		EndIf
		(cAliasSRA)->( dbSkip() )
	End While
	
	If !lAchou
		cRet += "(" + fDesc("SRV",cCod,"RV_TIPO",,cFil) + ")"
	EndIf
EndIf

IF lAlinha
	cRet := AllTrim(cCod + '-' + fDesc("SRV",cCod,"RV_DESC",nTam,cFil) )
	cRet := Space(nTam+4-Len(cRet)) + cRet
EndIF	

RestArea(aAreaSRA)

Return( cRet )                




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ TpVerba³ Autor ³ Oswaldo Leite      ³ Data ³      23.08.17 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se o valor das horas é positivo\negativo          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static function TpVerba (cTipo,lRelOld)
Local   nFator  := 1
Default lRelOld := .F.

If !lRelOld
	If cTipo == "2"//descontado
		nFator := nFator * (-1)
	EndIf
Else
	SRV->(DbSetOrder(1))
	SRV->(DbSeek(Fwxfilial('SRV')+SPB->PB_PD))
	
	If SRV->(!Eof())
		If SRV->RV_TIPOCOD == "2"
			nFator := nFator * (-1)
		EndIf
	EndIf
EndIf

return nFator
