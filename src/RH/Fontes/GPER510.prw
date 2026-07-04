/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GPER510.CH"
#include "Protheus.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ GPER510  ณ Autor ณ Equipe RH               ณ Data ณ 07/10/97 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Relatorio de Acumulados por Codigos                          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ GPER510                                                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณProgramador ณ Data     ณ FNC          ณ  Motivo da Alteracao             ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณMohanad Odehณ15/03/13  ณM12RH01 RQ4506ณUnificacao dos Fontes	V12         ณฑฑ  
ฑฑณRaquel Hagerณ24/10/13  ณM12RH01 RQ4506ณRemocao de tratamentos para quandoณฑฑ  
ฑฑณ            ณ          ณ              ณnao for TopConnect.				ณฑฑ
ฑฑณGabriel A.  ณ21/09/16  ณTVTQOB        ณAjuste para posicionar a primeira ณฑฑ
ฑฑณ            ณ          ณ              ณlinha.                            ณฑฑ
ฑฑณGabriel A.  ณ29/09/16  ณTWEIHM        ณAjuste no posicionamento dos      ณฑฑ
ฑฑณ            ณ          ณ              ณtotalizadores.                    ณฑฑ
ฑฑณRenan Borgesณ16/01/17  ณMRH-4250      ณAjuste para imprimir relat๓rio de ณฑฑ
ฑฑณ            ณ          ณ              ณacumulados corretamente quando funณฑฑ
ฑฑณ            ณ          ณ              ณcionแrio transferido possuir regisณฑฑ
ฑฑณ            ณ          ณ              ณtros nos acumulados de outras em- ณฑฑ
ฑฑณ            ณ          ณ              ณpresas.                           ณฑฑ
ฑฑณEduardo K.  ณ04/04/18  ณMPRIMESP-13918ณAjuste p/ alinhamento do cabe็alhoณฑฑ
ฑฑณ            ณ          ณ              ณcom as colunas na impressใo de    ณฑฑ
ฑฑณ            ณ          ณ              ณacumulados por competencia no modoณฑฑ
ฑฑณ            ณ          ณ              ณhorizontal.					    ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function GPER510()
Local cDesc1 	:= STR0001  // "Relatorio Acumulados por Codigo"
Local cDesc2 	:= STR0002  // "Ser  impresso de acordo com os parametros solicitados pelo"
Local cDesc3 	:= STR0003  // "usuario."
Local cString	:= "SRA"   
Local aOrd		:= {STR0004,STR0005,STR0006,STR0045}  //"Matricula"###"Centro de Custo do Funcionario"###"Nome"###"Centro de Custo do Movimento"
Local cSize	 	:= "G"      
Local nFor
Local aArea		:= GetArea()

Private aReturn := { STR0007, 1,STR0008, 2, 2, 1, "",1 }  // "Zebrado"###"Administrao"
Private aAC 	:= { STR0009,STR0010 }  // "Abandona"###"Confirma"
Private aLinha  := { },nLastKey := 0
Private aInfo	:={}
Private aTotais := {}
Private cPerg   :="GPR510"
Private cVerba, cCodigos, cVerbaCod, nCtSB, nCtcPd
Private Nomeprog:="GPER510"
Private nOrdem

Private aFldRot 	:= {'RA_NOME'}
Private aOfusca	 	:= If(FindFunction('ChkOfusca'), ChkOfusca(), {.T.,.F.}) //[1] Acesso; [2]Ofusca
Private lOfuscaNom 	:= .F. //RA_NOME
Private aFldOfusca	:= {}

If aOfusca[2]
	aFldOfusca := FwProtectedDataUtil():UsrNoAccessFieldsInList( aFldRot ) // CAMPOS SEM ACESSO
	IF aScan( aFldOfusca , { |x| x:CFIELD == "RA_NOME" } ) > 0
		lOfuscaNom := FwProtectedDataUtil():IsFieldInList( "RA_NOME" )
	ENDIF
ENDIF

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVetor de Totalizacao Generico 1 Coluna = CODIGO                    ณ
//ณ                              2 Coluna = Total Horas do Funcionarioณ
//ณ                              3 Coluna = Total Valor do Funcionarioณ
//ณ                              4 Coluna = Total Horas Centro Custo  ณ
//ณ      aTotais                 5 Coluna = Total Valor Centro Custo  ณ
//ณ                              6 Coluna = Total Horas Filial        ณ
//ณ                              7 Coluna = Total Valor Filial        ณ
//ณ                              8 Coluna = Total Geral Horas         ณ
//ณ                              9 Coluna = Total Geral Valor         ณ
//ณ                             10 Coluna = Mes Referencia            ณ
//ณ                             11 Coluna = Data Pagamento            ณ
//ณ                             12 Coluna = Tipo 1                    ณ
//ณ                             13 Coluna = Tipo 2                    ณ
//ณ                             14 Coluna = Proventos/Base(-)Descontosณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
// Variaveis Utilizadas na funcao IMPR                         
Private titulo
Private AT_PRG 	:= "GPER510"
Private wCabec0
Private wCabec1
Private wCabec2
Private CONTFL  := 1
Private LI      := 0
Private COLUNAS := 220
Private nTamanho:= "G"
Private nChar	:= 15
Private cPict1	:=	If (MsDecimais(1)==2,"@E 99,999,999,999.99",TM( Val( Replicate( "9",13 - MsDecimais(1) ) ),17,MsDecimais(1) ) )  // "@E 99,999,999,999.99
Private cPict2	:=	cPict1
Private nNumLin := 9
Private cQuebraDet := ""
                       
	Pergunte("GPR510",.F.)
	cTit   	:= STR0011  // "VALORES ACUMULADOS POR CODIGO "
	wnrel	:="GPER510" // Nome Default do relatorio em Disco
	wnrel	:=SetPrint(cString,wnrel,cPerg,@cTit,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Variaveis utilizadas para parametros                         ณ
	//ณ mv_par01        //  Filial  De                               ณ
	//ณ mv_par02        //  Filial  Ate                              ณ
	//ณ mv_par03        //  Centro de Custo De                       ณ
	//ณ mv_par04        //  Centro de Custo Ate                      ณ
	//ณ mv_par05        //  Matricula De                             ณ
	//ณ mv_par06        //  Matricula Ate                            ณ
	//ณ mv_par07        //  Nome De                                  ณ
	//ณ mv_par08        //  Nome Ate                                 ณ
	//ณ mv_par09        //  Data De                                  ณ
	//ณ mv_par10        //  Data Ate                                 ณ
	//ณ mv_par11        //  Numero da Semana De                      ณ
	//ณ mv_par12        //  Numero da Semana Ate                     ณ
	//ณ mv_par13        //  Formato Vertical / Horizontal            ณ
	//ณ mv_par14        //  Listar Horas / Valores                   ณ
	//ณ mv_par15        //  Relatorio Analitico ou Sintetica         ณ
	//ณ mv_par16        //  Se lista todos os codigos encontrados    ณ
	//ณ mv_par17        //  Lista Salario do Cadastro ?              ณ
	//ณ mv_par18        //  Cria String com Situacao do Funcionario  ณ
	//ณ mv_par19        //  Cria String contendo Categorias          ณ
	//ณ mv_par20        //  Codigos a Listar                         ณ
	//ณ mv_par21        //  Cont. Codigos a Listar                   ณ
	//ณ mv_par22        //  Imprimir Totais                          ณ
	//ณ mv_par23        //  Imprimir Liquidos                        ณ
	//ณ mv_par24        //  Situacao Historica / Atual               ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
	// Carregando variaveis mv_par?? para Variaveis do Sistema.    
	FilialDe  	:= mv_par01
	FilialAte 	:= mv_par02
	CcDe      	:= mv_par03
	CcAte     	:= mv_par04
	MatDe     	:= mv_par05
	MatAte    	:= mv_par06
	NomDe     	:= mv_par07
	NomAte    	:= mv_par08
	DatDe     	:= mv_par09
	DatAte    	:= mv_par10
	cSemanaDe 	:= mv_par11 
	cSemanAte 	:= mv_par12
	nVerHor   	:= If(mv_par16=1,1,mv_par13)
	nValHor   	:= mv_par14
	nSinAna   	:= mv_par15
	lTodos    	:= If(Empty(mv_par20),.T.,If(mv_par16=1,.T.,.F.))
	lSalario  	:= If(mv_par17=1,.T.,.F.)
	cSituacao 	:= mv_par18
	cCategoria	:= mv_par19
	cCodigos  	:= AllTrim(mv_par20)
	cCodigos  	+= AllTrim(mv_par21)
	lTotais   	:= If(mv_par22=1,.T.,.F.)
	lLiquido  	:= If(mv_par23=1,.T.,.F.)  
	lSitHist  	:= If(mv_par24=1,.T.,.F.)
	cAnoMesI	:=	SubStr(DatDe,3,4) + SubStr(DatDe,1,2) 
	cAnoMesF 	:=	SubStr(DatAte,3,4)  + SubStr(DatAte,1,2)
	
	If	nLastKey = 27
		Return
	EndIf

	// Separa os Codigos das verbas solicitadas a listar
	cVerba := ""
	If nVerHor =  2
		If lLiquido
			cCodigos += "LIQ"
		EndIf
		If lTotais
			cCodigos += "TOT"
		EndIf	
	EndIf 
	
	cCodigos := Replace(cCodigos,"*","")
	If !Empty(cCodigos)
		For nFor := 1 To Len(ALLTRIM(cCodigos)) Step 3
			cVerba += "'"+Subs(cCodigos,nFor,3)+"'"
			If Len(ALLTRIM(cCodigos)) > ( nFor+3 )
				cVerba += "," 
			EndIf
		Next nFor
	EndIf

	If nVerHor = 2   //Horizontal
		// Cria no vetor de totalizacao, as verbas solicitadas
		If !Empty(cCodigos)
			For nFor := 1 To Len(ALLTRIM(cCodigos)) Step 3
				cVerbaCod := Subs(cCodigos,nFor,3)
				//--Incluir Salario Base nos codigos a listar
				Aadd(aTotais,{cVerbaCod,0,0,0,0,0,0,0,0,cAnoMesI," "," "," ",0,0,0,0,0})
			Next
		EndIf        
		//--Limite de Verbas Horizontal em Valor           
		If Len(aTotais) > 10 .And. nValHor  = 1
	        Help(" ",1,"R100MAIO8") // "Nao e possivel listar mais do que 8 codigos na horizontal, quando os mesmos forem solicitados em valores." 
			Return                              
		//--Limite de Verbas Horizontal em Horas		
		ElseIf Len(aTotais) > 16 .And. nValHor = 2
			Help(" ",1,"R100MAIO15") // "Nao e possivel listar mais do que 15 codigos na horizontal, quando os mesmos forem solicitados em horas."
			Return
		EndIf
		If (Len(aTotais) > 4 .AND. nValHor = 1) .OR. (Len(aTotais) > 6 .AND. nValHor = 2)
			cSize   	:= "G"
			nTamanho	:= "G"
			COLUNAS    	:= 220
	        nChar		:= 15
	        aReturn[4]	:= 2
		EndIf
	Else
		cSize   	:= "M"
		nTamanho	:= "M"
		COLUNAS    	:= 132
		nChar		:= 15
		aReturn[4]	:= 1
	EndIf             

	TITULO := STR0044+" "+aOrd[ aReturn[8] ]  //'VALORES ACUMULADOS POR COMPETENCIA 
	wCabec0 := 2
	If nVerHor = 1
		wCabec1 := Space(50)+STR0014+Space(4)+STR0015 		//'DATA'###'T T |- PROVENTO/DESCONTO -|'
		wCabec2 := 	STR0028+Space(09-Len(STR0028))+;		//FIL.
					STR0030+Space(06-Len(STR0028))+;		//MAT.
					STR0031+Space(34-Len(STR0031))+;		//NOME
					STR0032+Space(8-Len(STR0032))+;			//REF.
					STR0033+Space(1)+;						//1 2
					STR0034+Space(1)+;						//COD
					STR0035+Space(24-Len(STR0035))+;       	//DESCRIPC.
					STR0018+Space(13-Len(STR0018))+;		//HORAS
					STR0017+Space(20-Len(STR0017))+;		//V A L O R
					STR0036   								//Dta Pagto
		********************************************************************************************************************************************
		//             99 999999999999999999999 999999 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 99/9999 X X 999 XXXXXXXXXXXXXXXXXXX 999999,99 999.999.999,99 99/99/99
		//             99 999999999 - XXXXXXXXXXXXXXXXXXXX                                                                999999,99 999.999.999,99 99/99/99
		//             99 XXXXXXXXXXXXXXX                                             99/9999 X X 999 XXXXXXXXXXXXXXXXXXX 999999,99 999.999.999,99 99/99/99
		//             99 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                           99/9999 X X 999 XXXXXXXXXXXXXXXXXXX 999999,99 999.999.999,99 99/99/99
		//                                                                            TOTAL DA VERBA                      999999,99 999.999.999,99 99/99/99
		//                   T O T A L     D O     F U N C I O N A R I O                                                  999999,99 999.999.999,99          
		//                   T O T A L     D O     C E N T R O  D E  C U S T O                                            999999,99 999.999.999,99          
		//            01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456
		//    				    1         2         3         4         5         6         7         8         9         0         1         2         3
		*******************************************************************************************************************************************
	Else
		aTotais := aSort(aTotais,,,{ |x,y| x[10]+x[1] < y[10]+y[1] })
		wCabec1 :=	STR0028+Space(1)+STR0030+Space(2)+STR0031+Space(35)+STR0014+;	
					Space(19-(Len(STR0028)+Len(STR0030) + Len(STR0031)+ Len(STR0014)))+Space(1)
					//"FI C.CUSTO   MATR.  NOME                           DATA  " 
		wCabec2 := space(59)
	*********************************************************************************
	// cabec.1     99 999999999999999999999 999999 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 99/9999 999-xxxxxxxxxxxxx  
	// cabec.2                                                          V A L O R
	// cabec.1     99 999999999999999999999 999999 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 99/9999 999-xxxxx
	// cabec.2                                                          HORAS
	//             99 999999999999999999999-XXXXXXXXXXXXXXXXXXXXXXXXXXXXX       999999,99
	//             99 999999999899999999999-XXXXXXXXXXXXXXXXXXXXXXXXXXXXX       99,999,999,999.99
	//             99 XXXXXXXXXXXXXXX                                           999999,99
	//             99 XXXXXXXXXXXXXXX                                           99,999,999,999.99
	//             Empresa: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                   999999,99
	//             T O T A L     D O     F U N C I O N A R I O                  999999,99 999.999.999,99
	//             T O T A L     D O     C E N T R O  D E  C U S T O            999999,99 999.999.999,99
	//             22                    TOTAL DO FUNCIONARIO                   999999,99 999.999.999,99
	//            01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456
	//    				    1         2         3         4         5         6         7         8         9         0         1         2         3
	*******************************************************************************************
	EndIf

	If	nLastKey = 27
		Return
	EndIf

	// Passa parametros de controle da impressora 
	SetDefault(aReturn,cString,,,cSize)
	
	RptStatus({|lEnd| GR510Imp(@lEnd,wnRel,cString)},titulo)
	
	RestArea( aArea ) 

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ GPER510  ณ Autor ณ Equipe RH             ณ Data ณ 03/03/95 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Relatorio Acumulados por Codigos                           ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ lEnd        - Acaoo do Codelock                            ณฑฑ
ฑฑณ          ณ wnRel       - Titulo do relatorio                          ณฑฑ
ฑฑณ          ณ cString     - Mensagem			                          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ GPER510                                                    ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function GR510Imp(lEnd,wnRel,cString)
Local CbTxt // Ambiente
Local CbCont
Local cAcessaSRA  := &("{ || " + ChkRH("GPER510","SRA","2") + "}")
Local cAcessaSRD  := &("{ || " + ChkRH("GPER510","SRD","2") + "}")
Local nPos
// Variaveis para Query SRD             
Local cAliasSRD := "SRD" 
Local DtPagto	
Local lQuery    := .F. 		// Indica se a query foi executada
Local aArray := {} 			// Variavel para gerar os filtros 
Local cAcessaConvSql      	// Variavel para conversoes de formato DBF para SQL
Local cQuery    := "" 	
Local aStruSRD  := {}     
Local nX
Local nFor		:= 0
Local lPrimeira := .T.
Local cSitBkp	:= cSituacao
Local lProc		:= .T.

	cSitBkp	:= StrTran(cSituacao , "*" , "")
	If ( Empty(ALLTRIM(cSitBkp)) )
		cSituacao	:= SPACE(1)
	EndIf

	cbtxt	:=	Space(10)
	cbcont	:=	0

	// Salvar Ordem Selecionada SETPRINT
	nOrdem    := aReturn[8]
	
	// Gera o filtro para DBF
	aArray := {"SRA","SRD"}
	ffiltro("GPER510",aArray,1) 
	
	dbSelectArea( "SRA" )
	dbGoTop()

	If nOrdem == 1
		dbSetOrder(1)
		dbSeek(FilialDe + MatDe,.T.)
		cInicio  := "SRA->RA_FILIAL + SRA->RA_MAT"
		cFim     := FilialAte + MatAte
	ElseIf nOrdem == 2 // centro do funcionario
		dbSetOrder(2)
		dbSeek(FilialDe + CcDe + MatDe,.T.)
		cInicio  := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
		cFim     := FilialAte + CcAte + MatAte
	ElseIf nOrdem == 3
		dbSetOrder(3)
		dbSeek(FilialDe + NomDe + MatDe,.T.)
		cInicio  := "SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT"
		cFim     := FilialAte + NomAte + MatAte
	ElseIf nOrdem == 4
		ProcSRD(lEnd,wnRel,cString) //relatorio processado pelo centro de custo do movimento 
		lProc := .F.
	EndIf

	If lProc
		cFilAnterior := Replicate("!", FWGETTAMFILIAL)
		cCcAnt  := "!!!!!!!!!"

		dbSelectArea("SRA")
		SetRegua(SRA->(RecCount()))
		
		While	!Eof() .And. &cInicio <= cFim
			
			IncRegua()
		
			If lEnd
				@Prow()+1,0 PSAY cCancel
				Exit
			EndIf

			If nVerHor <> 1 .and. lPrimeira
				For nFor := 1 To Len(aTotais) 
					WCabec1 += If(nValHor=1,Space(4),Space(6))+FVerba(aTotais[nFor,1],If(nValHor==1,11,6),SRA->RA_FILIAL)
					WCabec2 += If(nValHor=1,Space(9)+STR0017,Space(10)+STR0018)+" "  //"V A L O R"###"HORAS"
				Next
				lPrimeira := .F.
			EndIf

			If	SRA->RA_FILIAL # cFilAnterior
				If	cFilAnterior # Replicate("!", FWGETTAMFILIAL)
					fImpFil()    // Totaliza Filial
				EndIf
				cFilAnterior := SRA->RA_FILIAL
				cCcAnt       := SRA->RA_CC
				fInfo(@aInfo,cFilAnterior)
			EndIf
		
			// Despreza Registros Conforme Categoria dos Funcionarios  
			If	!( SRA->RA_CATFUNC $ cCategoria )
				fTestaTotal()		
				Loop
			EndIf     
			
			// Despreza Registros Conforme Situacao atual do funcionario
			If !lSitHist
				If !(SRA->RA_SITFOLH $ cSituacao)
					fTestaTotal()		
					Loop
				EndIf
			Endif    
		
			// Consiste Parametrizacao do Intervalo de Impressao            
			If (SRA->RA_NOME < NomDe) .Or. (SRA->RA_NOME > NomAte) .Or. ;
				(SRA->RA_MAT < MatDe) .Or. (SRA->RA_MAT > MatAte)
				fTestaTotal()
				Loop
			EndIf  
			
			// Consiste controle de acessos e filiais validas               
			If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
				fTestaTotal()
				Loop
			EndIf
			
			nCtSB  := 0
			nCtcPd := 0
			lQuery := .T.
			
			cAcessaConvSql := fConvExpPSql(cAcessaSRD)
			cAliasSRD	:= "QSRD"
			aStruSRD	:= If(Empty(aStruSRD),SRD->(dbStruct()),aStruSRD)
			cQuery		:= "SELECT * "
			cQuery		+= "FROM "+RetSqlName("SRD")+" SRD "
			If nOrdem == 2
				cQuery		+= "INNER JOIN " + RetSqlName("SRA") + " SRA ON SRA.RA_FILIAL = SRD.RD_FILIAL AND SRA.RA_MAT = SRD.RD_MAT "
			EndIf
			cQuery		+= "WHERE SRD.RD_FILIAL='"+SRA->RA_FILIAL+"' AND "
			cQuery		+= "SRD.RD_MAT='"+SRA->RA_MAT+"' AND "
			cQuery		+= "SRD.RD_DATARQ>='"+cAnoMesI+"' AND "
			cQuery		+= "SRD.RD_DATARQ<='"+cAnoMesF+"' AND "
			cQuery		+= "SRD.RD_SEMANA>='"+ cSemanaDe+"' AND "
			cQuery		+= "SRD.RD_SEMANA<='"+ cSemanAte+"' AND "
			cQuery		+= "(SRD.RD_EMPRESA = ' ' OR "
			cQuery		+= "SRD.RD_EMPRESA = '"+FwCodEmp("SRD")+"') AND "
			If nOrdem == 2
				cQuery		+= "SRA.RA_CC >= '"+ CcDe +"' AND "
				cQuery		+= "SRA.RA_CC <= '"+ CcAte +"' AND "
			Else
				cQuery		+= "SRD.RD_CC >= '"+ CcDe +"' AND "
				cQuery		+= "SRD.RD_CC <= '"+ CcAte +"' AND "
			EndIf
		
			If !lTodos .And. !Empty(cVerba) 
				cQuery += "SRD.RD_PD IN (" + Upper(cVerba) + ") AND " 
			EndIf
				
			cQuery += "SRD.D_E_L_E_T_=' ' "
			cQuery += cAcessaConvSql
			cQuery += "ORDER BY "+SqlOrder(SRD->(IndexKey()))
			cQuery := ChangeQuery(cQuery)
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSRD,.T.,.T.)
			
			For nX := 1 To Len(aStruSRD)
				If ( aStruSRD[nX][2] <> "C" )
					TcSetField(cAliasSRD,aStruSRD[nX][1],aStruSRD[nX][2],aStruSRD[nX][3],aStruSRD[nX][4])
				EndIf
			Next nX
		
			While	!Eof() .And. ((cAliasSRD)->RD_FILIAL+(cAliasSRD)->RD_MAT == SRA->RA_FILIAL+SRA->RA_MAT) .And. ;
							( (cAliasSRD)->RD_DATARQ<=cAnoMesF)
		
				SRD->(DBGOTO((cAliasSRD)->R_E_C_N_O_))

				If lSitHist	//Seleciona somente se quer considerar selecao historica
					// Verifica o tipo de Afastamentono mes que esta sendo listado 
					cTipAfas := " "
					dDtAfas  := dDtRet := CtoD("")
					dDtPesqAf:= CTOD("01/" + Right((cAliasSRD)->RD_DATARQ,2) + "/" + Left((cAliasSRD)->RD_DATARQ,4),"DDMMYY")
					fChkAfas((cAliasSRD)->RD_FILIAL,(cAliasSRD)->RD_MAT,dDtPesqAf,@dDtAfas,@dDtRet,@cTipAfas)
			
					If (!Empty(SRA->RA_DEMISSA) .And. MesAno(SRA->RA_DEMISSA)<= MesAno(dDtPesqAf))					
						cTipAfas := "D"
					EndIf
					
					If MesAno(dDtAfas) > MesAno(dDtPesqAf)
						cTipAfas := " "
					EndIf		
					If	!(cTipAfas $ cSituacao)
						dbSkip()
						Loop
					EndIf
				EndIf
				
				If (cAliasSRD)->RD_DATARQ < cAnoMesI 
					dbSkip()
					Loop
				EndIf
				
				If !Empty((cAliasSRD)->RD_EMPRESA) .And. (cAliasSRD)->RD_EMPRESA # FWCODEMP("SRD")
					dbSkip()
					Loop
				EndIf    
				
				If (cAliasSRD)->RD_SEMANA < cSemanaDe .Or. (cAliasSRD)->RD_SEMANA > cSemanAte
					dbSkip()
					Loop
				EndIf   
				
				If !lTodos .And. !Empty(cVerba) .And. !((cAliasSRD)->RD_PD $ cVerba) 
					dbSkip()
					Loop
				EndIf
		
				// Consiste controle de acessos							 
				If !Eval(cAcessaSRD)
					dbSkip()
					Loop
				EndIf 
				
				DtPagto:= LEFT(DTOC((cAliasSRD)->RD_DATPGT),6) + RIGHT(DTOC((cAliasSRD)->RD_DATPGT),2)
		
				FAcumula((cAliasSRD)->RD_PD,(cAliasSRD)->RD_HORAS,(cAliasSRD)->RD_VALOR,(cAliasSRD)->RD_DATARQ, DtPagto ,(cAliasSRD)->RD_TIPO1,(cAliasSRD)->RD_TIPO2)
				
				If PosSrv( (cAliasSRD)->RD_PD , SRA->RA_FILIAL , "RV_TIPOCOD" ) == "2"		//Proventos
					nValorM := (cAliasSRD)->RD_VALOR * (-1)
				Else
					nValorM := (cAliasSRD)->RD_VALOR                 
				EndIf
				
				// Somar no Liquido do Funcionario
				If lLiquido .And. nVerHor = 2 .And. aScan(aTotais,{ |x| x[1] = (cAliasSRD)->RD_PD}) > 0
					FAcumula("LIQ",(cAliasSRD)->RD_HORAS,nValorM,(cAliasSRD)->RD_DATARQ, DtPagto ,(cAliasSRD)->RD_TIPO1,(cAliasSRD)->RD_TIPO2)
				EndIf					
		
				// Somar no total do funcionario
				If lTotais .And.  nVerHor = 2 .And. Ascan(aTotais,{ |x| x[1] = (cAliasSRD)->RD_PD}) > 0
					FAcumula("TOT",(cAliasSRD)->RD_HORAS,(cAliasSRD)->RD_VALOR,(cAliasSRD)->RD_DATARQ, DtPagto ,(cAliasSRD)->RD_TIPO1,(cAliasSRD)->RD_TIPO2)
				EndIf					
			
				(cAliasSRD)->(dbSkip())
			Enddo 
			
			If ( lQuery )
				dbSelectARea(cAliasSRD)
				dbCloseArea()
				dbSelectArea("SRD")
			EndIf
			
			If	FTotaliza(2)+FTotaliza(3) > 0 .and. lSalario .And. nVerHor == 1
				FAcumula(" SB",SRA->RA_HRSMES,SRA->RA_SALARIO,cAnoMesI," "," "," ")
			ElseIf	FTotaliza(2)+FTotaliza(3) > 0 .and. lSalario .And. nVerHor == 2
				nPos := Ascan(aTotais,{|x|x[1]==" SB"})
				if nPos ==0
					Aadd(aTotais,{" SB",SRA->RA_HRSMES,SRA->RA_SALARIO,SRA->RA_HRSMES,SRA->RA_SALARIO,SRA->RA_HRSMES,SRA->RA_SALARIO,SRA->RA_HRSMES,SRA->RA_SALARIO,cAnoMesI,"","","",0.00,0,0,0,0})
				Else
					aTotais[nPos,02] += SRA->RA_HRSMES
					aTotais[nPos,03] += SRA->RA_SALARIO
					aTotais[nPos,04] += SRA->RA_HRSMES
					aTotais[nPos,05] += SRA->RA_SALARIO
					aTotais[nPos,06] += SRA->RA_HRSMES
					aTotais[nPos,07] += SRA->RA_SALARIO
					aTotais[nPos,08] += SRA->RA_HRSMES
					aTotais[nPos,09] += SRA->RA_SALARIO
					aTotais[nPos,10] := cAnoMesI
					aTotais[nPos,14] := 0
				EndIf	       
			Endif                    
			fImpFun()
			fTestaTotal()
		Enddo

		// Termino do relatorio                                         
		dbSelectArea( "SRA" )
		dbSetOrder(1)
	Endif

	Set Filter to

	ffiltro("GPER510",aArray,0)//0- LIMPA OS FILTROS
	
	Set Device To Screen
	If aReturn[5] = 1
		Set Printer To
		Commit
		ourspool(wnrel)
	EndIf  
	
	MS_FLUSH()    
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ fTestaTotal บ Autor ณ Equipe RH        บ Data ณ  29/10/02  บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Pula funcinario e verifica as quebras de centro de custo   บฑฑ
ฑฑบ          ณ filial / empresa.                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GPER510                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function fTestaTotal()     

	If nOrdem <> 4
		cCcAnt       := SRA->RA_CC
		cFilAnterior := SRA->RA_FILIAL

		dbSelectArea("SRA")
		dbSkip()
		
		If Eof() .Or. &cInicio > cFim
			fImpCc()
			fImpFil()
			fImpEmp()
		ElseIf cFilAnterior # SRA->RA_FILIAL
			fImpCc()
			fImpFil()
		ElseIf cCcAnt # SRA->RA_CC .And. !Eof()
			fImpCc()
			// Saltar a pagina quando quebra CC e Sim
			If mv_par25 = 1
				IMPR510("","P")
			EndIf
		EndIf
	Endif

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ fImpFun   บ Autor ณEquipe RH           บ Data ณ  27/11/12  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Imprime um Funcionario.                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GPER510                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function fImpFun   
         
	If nSinAna = 2 // Analitico
		fImprime(1,2)
	EndIf  
	
	FZera(2) // Zerar a Coluna de Funcionarios
	fZera(14)// Zerar a Coluna de Totalizacao de Funcionarios
	
	if nOrdem <> 4
		If !(Eof() .Or. &cInicio > cFim ) .And. !(cFilAnterior # SRA->RA_FILIAL) .And. ( (cCcAnt # SRA->RA_CC .And. !Eof()) .Or. !( cCcAnt # SRA->RA_CC .And. Eof()) ) .And. nOrdem # 2
			FZera(4)   
			fZera(14)
		EndIf 
	else
		If !(Eof() .Or. &cInicio > cFim ) .And. !(cFilAnterior # SRD->RD_FILIAL) .And. (cCcAnt # SRD->RD_CC .And. !Eof())
			FZera(4)   
			fZera(14)
		EndIf 		
	Endif

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ fImpCC    บ Autor ณEquipe RH           บ Data ณ  27/11/12  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Imprime Centro de Custo.                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GPER510                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function fImpCc

	If (nOrdem ==  2 .or. nOrdem ==  4) .And. FTotaliza(4)+FTotaliza(5) > 0
		fImprime(2,4) // Imprime
	EndIf 
	
	FZera(4)   
	fZera(15)// Zerar a Coluna de Totalizacao de Centro de Custo

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ fImpFil   บ Autor ณEquipe RH           บ Data ณ  27/11/12  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Imprime Filial.                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GPER510                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function fImpFil
	
	If fTotaliza(6)+fTotaliza(7) > 0
		fImprime(3,6)
	EndIf	  
	
	FZera(6)
	fZera(16)// Zerar a Coluna de Totalizacao de Filial

Retu Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ fImpEmp   บ Autor ณ Equipe RH          บ Data ณ  27/11/12  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Imprime Geral.                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GPER510                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function fImpEmp

	fImprime(4,8)
	FZera(8)  

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ fImprime  บ Autor ณ Equipe RH          บ Data ณ  27/11/12  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Impressao.                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GPER510                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function fImprime(nTipo,nCol)
Local nEspaco	:= 0
// nTipo: 1- Funcionario
//        2- Centro de Custo
//        3- Filial
//        4- Geral

	If nTipo == 1
		DET:= SRA->RA_FILIAL + " " + SRA->RA_MAT + "-"
		nEspaco := Len(DET)     
	   		 
		DET +=  If(lOfuscaNom,Replicate('*',30),Padr(SRA->RA_NOME,30))
		DET := PadR(DET,50) 
		
		cQuebraDet := DET	
		FImpDet(2,3,1)
		
	ElseIf nTipo == 2
		If nVerHor = 2 // Horizontal
			IMPR510(REPL("-",COLUNAS),"C")
		EndIf  // 64
		
		DET:= cFilAnterior + Space( 12 - Len(cFilAnterior) ) + " " + Substr(cCcAnt+"-"+DescCC(cCcAnt,cFilAnterior,18)+Space(28),1,28)
		DET+= If(nVerHor==1,Space(0),Space(1))
		cQuebraDet := DET
		FImpDet(4,5,2) 
		
	ElseIf nTipo == 3
		DET:= cFilAnterior + Space( 12 - Len(cFilAnterior) ) + "  " + Subs(aInfo[1],1,15) +   Space(If(nVerHor==1,16,16))
		DET := Padr(Left(DET,50),50)  // Tratamento para o caso de utilizar gestao corporativa nao desposicionar a primeira linha.
		cQuebraDet := DET
		If nSinAna == 2
			IMPR510(" ","C")
		Endif
		FImpDet(6,7,3)
	ElseIf nTipo == 4
		DET:= STR0021 + If(nVerHor==1,Subs(aInfo[3],1,30)+Space(11),Subs(aInfo[3],1,33)+Space(1))  //"Empresa: "
		cQuebraDet := DET
		FImpDet(8,9,4)
		IMPR510("","P")                // Salta Pagina apos Quebra Cc/Filial/Empresa
	EndIf  

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ FAcumula  บAutor  ณ Equipe RH          บ Data ณ  27/11/12  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Acumula valores das verbas em aTotais.                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GPER510                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function FAcumula(cPd,nHoras,nValor,AnoMes,DtPagto,Tipo1,Tipo2)
Local n := 0, nCt, nAchou          
Local nValLiq := 0

	n := Ascan(aTotais,{ |x| x[1]+X[10] = cPd+AnoMes } )
	If n = 0 
		If nVerHor == 2
			For nCt:=1 to Len(cCodigos) Step 3
				nAchou := Ascan(aTotais,{ |x| x[1]+X[10] = SubStr(cCodigos,nCt,3)+AnoMes } )
				If nAchou = 0
					Aadd(aTotais,{SubStr(cCodigos,nCt,3),0,0,0,0,0,0,0,0,AnoMes," "," "," ",0,0,0,0,0})
				EndIf
			Next
			n := Ascan(aTotais,{ |x| x[1]+X[10] = cPd+AnoMes } )
			If n > 0
				aTotais[n,2] += nHoras
				aTotais[n,3] += nValor
				aTotais[n,4] += nHoras
				aTotais[n,5] += nValor
				aTotais[n,6] += nHoras
				aTotais[n,7] += nValor
				aTotais[n,8] += nHoras
				aTotais[n,9] += nValor
				aTotais[n,11] := Left(DtPagto,6)+ right(DtPagto,2)
				aTotais[n,12] := Tipo1
				aTotais[n,13] := Tipo2
				If PosSrv(cPd,SRA->RA_FILIAL,"RV_TIPOCOD") == "1"
					nValLiq := nValor
				ElseIf SRV->RV_TIPOCOD == "2"
					nValLiq = nValor * (-1)
				EndIf
				aTotais[n,14] += nValLiq
				// Acumula Liquido Func.
				aTotais[n,15] += nValLiq 
				// Liquido Centro de Custo
				aTotais[n,16] += nValLiq
				// Liquido Filial
				aTotais[n,17] += nValLiq
				// Liquido Empresa
				aTotais[n,18] += nValLiq
			EndIf	
		Else
			Aadd(aTotais,{cPd,nHoras,nValor,nHoras,nValor,nHoras,nValor,nHoras,nValor,AnoMes,DtPagto,Tipo1,Tipo2,0.00,0.00,0,0,0})
			If PosSrv(cPd,SRA->RA_FILIAL,"RV_TIPOCOD") == "1"
				nValLiq := nValor
			ElseIf SRV->RV_TIPOCOD == "2"
				nValLiq := nValor * (-1)
			EndIf
			aTotais[Len(aTotais),14] += nValLiq
			// Liquido Funcionario
			aTotais[Len(aTotais),15] += nValLiq
			// Liquido Centro de Custo
			aTotais[Len(aTotais),16] += nValLiq
			// Liquido Filial
			aTotais[Len(aTotais),17] += nValLiq
			// Liquido Empresa
			aTotais[Len(aTotais),18] += nValLiq
		EndIf	
	Else
		aTotais[n,2] += nHoras
		aTotais[n,3] += nValor
		aTotais[n,4] += nHoras
		aTotais[n,5] += nValor
		aTotais[n,6] += nHoras
		aTotais[n,7] += nValor
		aTotais[n,8] += nHoras
		aTotais[n,9] += nValor
		aTotais[n,11] := Left(DtPagto,6)+ right(DtPagto,2)
		aTotais[n,12] := Tipo1
		aTotais[n,13] := Tipo2
		If PosSrv(cPd,SRA->RA_FILIAL,"RV_TIPOCOD") == "1"
			nValLiq := nValor
		ElseIf SRV->RV_TIPOCOD == "2"
			nValLiq := nValor * (-1)
		EndIf
		aTotais[n,14] += nValLiq
		// Liquido Funcionario
		aTotais[Len(aTotais),15] += nValLiq
		// Liquido Centro de Custo
		aTotais[n,16] += nValLiq
		// Liquido Filial
		aTotais[n,17] += nValLiq
		// Liquido Empresa
		aTotais[n,18] += nValLiq
	EndIf

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ FZera     บ Autor ณ Equipe RH          บ Data ณ  27/11/12  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Zera totais em aTotais.                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GPER510                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function FZera(nCol)
Local nFor

	For nFor := 1 To Len(aTotais)
		aTotais [nFor,nCol]   := 0   	// Zera Totais de horas
		If nCol # 14 .And. nCol # 15 .And. nCol # 16
			aTotais [nFor,nCol+1] := 0   // Zera Totais de Valores
		EndIf	
	Next   

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ FTotaliza บ Autor ณ Equipe RH          บ Data ณ  27/11/12  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Reordena aTotais.                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GPER510                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function FTotaliza(nCol)
Local nTot := 0    

	AEVAL(aTotais,{ |x| nTot += If(x[1] <> " SB",x[nCol],0.00) })	// Despreza o salario base ao calcular os totais.

Return nTot

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ FImpDet   บ Autor ณ Equipe RH          บ Data ณ  27/11/12  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GPER510                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function FImpDet(nCol1,nCol2,nMsgTot)
Local lImprime := .F.
Local cMsg[4]
Local nTotHoras:=0, nTotValor:=0, cPdAnt:=Space(3)
Local cMesAno, nCt, SubTotais:={}
Local nFor
Local nValorLiquido	:= 0

	If nVerHor == 1 // Vertical
		aTotais := aSort(aTotais,,,{ |x,y| x[1]+x[10] < y[1]+y[10] })
	Else
		aTotais := aSort(aTotais,,,{ |x,y| x[10]+x[1] < y[10]+y[1] })
	EndIf   

	cMsg[1] := OemtoAnsi(STR0037)  // DO FUNCIONARIO
	cMsg[2] := OemtoAnsi(STR0039)  // DO CENTRO DE CUSTO
	cMsg[3] := OemtoAnsi(STR0040)  // DA FILIAL
	cMsg[4] := OemtoAnsi(STR0038)  // DA EMPRESA
	
	//Impressao Vertical
	If nVerHor == 1		
		For nFor := 1 To Len(aTotais)
			If aTotais[nFor,nCol1]+aTotais[nFor,nCol2] # 0
				If aTotais[nFor,1] # " SB"
					If cPdAnt==Space(3)
						cPdAnt:=aTotais[nFor,1]
					EndIf
					If cPdAnt # aTotais[nFor,1]
						If lTotais
							IMPR510(Space(57) + STR0022 + Space(13) + TRANSFORM(nTotHoras,'@E 999999.99') + Space(5) + TRANSFORM(nTotValor,cPict2),'C')  //"TOTAL DA VERBA      "						
							IMPR510(" ","C")
						EndIf
						cPdAnt:=aTotais[nFor,1] 	
						nTotHoras:=0
						nTotValor:=0
					EndIf
					nTotHoras+=aTotais[nFor,nCol1]
					nTotValor+=aTotais[nFor,nCol2]
				Endif                                      
				// Montagem da impressao meses diferentes da mesma verba
				If aTotais[nFor,1] # " SB" .And. ( nFor > 1 .And. aTotais[nFor,1] == aTotais[nFor-1,1])
					DET += Right(aTotais[nFor,10],2)+"/"+Left(aTotais[nFor,10],4)+" "
				   	If nFor > 1
						DET += aTotais[nFor,12]+" "+aTotais[nFor,13]+Space(1)
						DET += If(aTotais[nFor,1]=" SB","   ",aTotais[nFor,1])+" "+If(aTotais[nFor,1]=" SB",SPACE(1)+STR0026+SPACE(19-LEN(STR0026)),DescPd(aTotais[nFor,1],xFilial("SRV",cFilAnterior),19))  //"SALARIO BASE"
				  	EndIf
				Else
					// Montagem da 1o. impressใo de uma determinada verba
					If aTotais[nFor,1] # " SB"
						DET += Right(aTotais[nFor,10],2)+"/"+Left(aTotais[nFor,10],4)+" "
						DET += aTotais[nFor,12]+" "+aTotais[nFor,13]+" "
					Else
						DET += Space(11)
					Endif
					// Descricao da Verba	
					DET += If(aTotais[nFor,1]=" SB","   ",aTotais[nFor,1])+" "+If(aTotais[nFor,1]=" SB",SPACE(1)+STR0026+SPACE(19-LEN(STR0026)),DescPd(aTotais[nFor,1],xFilial("SRV",cFilAnterior),19))  //"SALARIO BASE"
				EndIf
				// Valores/Horas da verba a ser impressa.
	 			DET +="     "+TRANSFORM(aTotais[nFor,nCol1],'@E 999999.99')+'     '+TRANSFORM(aTotais[nFor,nCol2],cPict2)
				DET +="  "+If(nMsgTot==1,aTotais[nFor,11]," ")
				IMPR510(DET,'C')
				lImprime := .T.
			EndIf
			If lImprime = .T.
				DET := Space(50)
			EndIf
		Next	 
		
		// Impressao dos Totais ou Liquido conforme parametro
		If lTotais .Or. lLiquido
			nValorLiquido	:= (nTotHoras+nTotValor)
			If (nTotHoras+nTotValor) > 0 
				If lTotais
					IMPR510(Space(57) + STR0022 + Space(27-Len(ALLTRIM(STR0022))) + TRANSFORM(nTotHoras,'@E 999999.99') + Space(5) + TRANSFORM(nTotValor,cPict2),'C')  //"TOTAL DA VERBA      "
					IMPR510(" ","C")
				EndIf
				nTotHoras:=0
				nTotValor:=0
			EndIf
			If lLiquido .And. nValorLiquido # 0
				DET := Space(57) + Repl("-",55)
				IMPR510(DET,'C')
				DET := Space(57) + STR0027 + Space(47 - Len(STR0027)) + TRANSFORM(FTotaliza(13+nMsgTot),cPict1)  //"TOTAL LIQUIDO"
				IMPR510(DET,'C')
			EndIf
			nValorLiquido	:= 0
			DET := Space(5)+STR0043+Space(1)+cMsg[nMsgTot]+Space(60-Len(STR0043)-Len(cMsg[nMsgTot]))+">>>>>" //"T O T A L"
			DET += Space(19)+TRANSFORM(FTotaliza(nCol1),'@E 999999.99')+space(5)
			DET += TRANSFORM(FTotaliza(nCol2),cPict2)
		EndIf
		If FTotaliza(nCol1)+FTotaliza(nCol2) # 0
			IMPR510(" ","C")
			If(lTotais,IMPR510(DET,"C"),)
			IMPR510(REPLICATE('-',COLUNAS),'C')
		EndIf 
		// Impressao Horizontal	
	Else                                        
		// Quebra por centro de custo
		If nMsgTot == 2
			IMPR510(DET,"C")
		EndIf	    
		
		For nFor := 1 To Len(aTotais)	
			If aTotais[nFor,1] == " SB"
				cDetalhe := Space(49 -len(STR0026))+STR0026+Space(If (nValHor = 1,0,0)) //"SALARIO BASE"
				If (nValHor=2 .and. aTotais[nFor,nCol1] > 0) .Or. (nValHor=1 .and. aTotais[nFor,nCol2]>0 )
		 			cDetalhe +="  "+If(nValHor=2,TRANSFORM(aTotais[nFor,nCol1],'@E 9999999.99'),TRANSFORM(aTotais[nFor,nCol2],cPict2))
					If nMsgTot == 1 .Or. nMsgTot == 3
						IMPR510(cDetalhe,'C')
					EndIf
				EndIf
			EndIf
	
			If aTotais[nFor,1] # " SB"
		
				cMesAno := aTotais[nFor,10]
				//-- Se for impressao do Funcionario/Analitico ou Filial/Sintetico
				If (nSinAna==2 .And. nMsgTot==1) .Or. (nMsgTot == 3 .And. nSinAna == 1)
					DET += Space(1)+Right(aTotais[nFor,10],2)+"/"+Left(aTotais[nFor,10],4)
				Else
					DET += Space(8)
				EndIf		
				For nCt:=nFor to Len(aTotais)
					If cMesAno # aTotais[nCt,10]
						Exit
					Endif
					DET += '  ' + If(nValHor=2,space(5)+TRANSFORM(aTotais[nCt,nCol1],'@E 999999.99'),TRANSFORM(aTotais[nCt,nCol2],cPict2))
					nMesAchou:= Ascan(SubTotais,{ |x| x[1] = aTotais[nCt,1] } )
					If nMesAChou == 0
						aadd(SubTotais,{aTotais[nCt,1] ,If(nValHor=2,aTotais[nCt,nCol1],aTotais[nCt,nCol2])})
					Else
						SubTotais[nMesAchou,2] += If(nValHor=2,aTotais[nCt,nCol1],aTotais[nCt,nCol2])
					EndIf
				Next
				If FTotalHor(nCol1,nFor,(nCt-1))+FTotalHor(nCol2,nFor,(nCt-1) ) # 0
					If nMsgTot == 1 .Or. nMsgTot == 3
						IMPR510(DET,'C')
					Endif
					lImprime := .T.
				EndIf
				nFor:=(nCt-1)
		
				If lImprime
					DET := Space(50)
				Else
					DET := PadR(DET,50)
				EndIf
			EndIf	
		Next   
		
		If Len(SubTotais) # 0 .And. !(nMsgTot==1 .And. cAnoMesI==cAnoMesF)
			SubTotais := aSort(SubTotais,,,{ |x,y| x[1] < y[1] })
			DET := STR0043+Space(1)+cMsg[nMsgTot] + SPACE(59-LEN(STR0043)-LEN(cMsg[nMsgTot])) //"T O T A L"
	
			For nCt:=1 to Len(SubTotais)
				If nCt==1
				 	nTotHoras+= SubTotais[nCt,2]
				 	nTotValor+= SubTotais[nCt,2]
					DET  += If(nValHor=2,Space(5)+TRANSFORM(nTotHoras,'@E 999999.99'),TRANSFORM(nTotValor,cPict2)) + '  '
				Else
					DET += If(nValHor=2,Space(5)+TRANSFORM(SubTotais[nCt,2],'@E 999999.99'),TRANSFORM(SubTotais[nCt,2] ,cPict2)) + '  '
				EndIf
			Next
			If lImprime
				IMPR510(" ","C")
				IMPR510(DET,"C")
				IMPR510(REPLICATE('-',COLUNAS),'C')
			EndIf
		EndIf	
	EndIf

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ FVerba    บ Autor ณ Equipe RH          บ Data ณ  27/11/12  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GPER510                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function FVerba(cCod,nTam,cFil)
Local cRet 

	If cCod = " SB"
		cRet := TRIM(Space(3)+"-"+Subs(STR0026,1,nTam))
		cRet := Space(nTam+4-Len(cRet))+ cRet
	ElseIf cCod = "LIQ"
		cRet := TRIM(Subs(STR0027,1,nTam))
	
		cRet := Space(nTam+4-Len(cRet))+ cRet
	ElseIf cCod = "TOT"
		cRet := TRIM(Space(1)+" "+Subs(STR0043,1,nTam))
		cRet := Space(nTam+4-Len(cRet))+ cRet
	Else
		cRet := TRIM(cCod+"-"+DescPd(cCod,xFilial("SRV",cFil),nTam))
		cRet := Space(nTam+4-Len(cRet))+ cRet
	EndIf 

Return cRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ FTotalHor บAutor  ณ Equipe RH          บ Data ณ  27/11/12  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Totaliza as horas.                                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GPER510                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function FTotalHor(nCol,Inicio,Fim)
Local nTot := 0, nConta 

	For nConta:=Inicio to Fim
	    nTot += IF(aTotais[nConta,nCol] > 0, aTotais[nConta,nCol], 0)
	Next

Return nTot

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณ IMPR510   บ Autor ณ Equipe RH          บ Data ณ  27/11/12  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDescricao ณ Impressao.                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GPER510                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function IMPR510(cDetalhe, cFimFolha)

	If nNumLin >= 58
		IMPR(cQuebraDet, "C")
		nNumLin := 10
	EndIF                    
	
	IMPR(cDetalhe, cFimFolha)
	nNumLin ++

	If cFimFolha == "P"	
		nNumLin := 9
	EndIf
	
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} function ProcSRD(lEnd,wnRel,cString)
Funcao para emitir o relatorio ordenado pelo centro de custo do movimento SRD
@author  Gisele Nuncherino
@since   13/11/2020
/*/
//-------------------------------------------------------------------
Static Function ProcSRD(lEnd,wnRel,cString)
Local aStruSRD		:= SRD->(dbStruct())
Local cQuery		:= ''	
Local cAcessaSRD  	:= &("{ || " + ChkRH("GPER510","SRD","2") + "}")
Local cAcessaSRA    := &("{ || " + ChkRH("GPER510","SRA","2") + "}")
Local cAcessaConvSql:= fConvExpPSql(cAcessaSRD)
Local nX			:= 0
Local nFor			:= 0
Local lPrimeira		:= .T.

Private cAliasSRD		:= "QSRD"
Private cInicio  		:= "SRA->RA_FILIAL + SRA->RA_CC"
Private cFim     		:= FilialAte + CcAte// + MatAte

cQuery		:= "SELECT * "
cQuery		+= "FROM "+RetSqlName("SRD")+" SRD "
cQuery		+= "WHERE SRD.RD_FILIAL >= '"+mv_par01+"' AND "
cQuery		+= "SRD.RD_FILIAL 		<= '"+mv_par02+"' AND "
cQuery		+= "SRD.RD_MAT 			>= '"+mv_par05+"' AND "
cQuery		+= "SRD.RD_MAT 			<= '"+mv_par06+"' AND "
cQuery		+= "SRD.RD_DATARQ>='"+cAnoMesI+"' AND "
cQuery		+= "SRD.RD_DATARQ<='"+cAnoMesF+"' AND "
cQuery		+= "SRD.RD_SEMANA>='"+ cSemanaDe+"' AND "
cQuery		+= "SRD.RD_SEMANA<='"+ cSemanAte+"' AND "
cQuery		+= "(SRD.RD_EMPRESA = ' ' OR "
cQuery		+= "SRD.RD_EMPRESA = '"+FwCodEmp("SRD")+"') AND "
cQuery		+= "SRD.RD_CC >= '"+ CcDe +"' AND "
cQuery		+= "SRD.RD_CC <= '"+ CcAte +"' AND "
		
If !lTodos .And. !Empty(cVerba) 
	cQuery += "SRD.RD_PD IN (" + Upper(cVerba) + ") AND " 
EndIf
				
cQuery += "SRD.D_E_L_E_T_=' ' "
cQuery += cAcessaConvSql
cQuery += "ORDER BY RD_FILIAL, RD_CC, RD_MAT "
cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSRD,.T.,.T.)

For nX := 1 To Len(aStruSRD)
	If ( aStruSRD[nX][2] <> "C" )
		TcSetField(cAliasSRD,aStruSRD[nX][1],aStruSRD[nX][2],aStruSRD[nX][3],aStruSRD[nX][4])
	EndIf
Next nX

cFilAnterior := Replicate("!", FWGETTAMFILIAL)
cCcAnt  := "!!!!!!!!!"

While !(cAliasSRD)->(Eof()) 

	SRD->(DBGOTO((cAliasSRD)->R_E_C_N_O_))
		
	If lEnd
		@Prow()+1,0 PSAY cCancel
		Exit
	EndIf	 

	SRA->(DBSetOrder(1))
	IF SRA->(DBSeek(xFilial("SRA",(cAliasSRD)->RD_FILIAL)+(cAliasSRD)->RD_MAT))
		If	SRA->RA_FILIAL# cFilAnterior
			If	cFilAnterior # Replicate("!", FWGETTAMFILIAL)
				fImpFil()    // Totaliza Filial
			EndIf
			cFilAnterior := SRA->RA_FILIAL
			cCcAnt       := (cAliasSRD)->RD_CC
			fInfo(@aInfo,cFilAnterior)
		EndIf
		
		// Despreza Registros Conforme Categoria dos Funcionarios  
		If	!( SRA->RA_CATFUNC $ cCategoria )
			(cAliasSRD)->(dbSkip())	
			Loop
		EndIf     
			
		// Despreza Registros Conforme Situacao atual do funcionario
		If !lSitHist
			If !(SRA->RA_SITFOLH $ cSituacao)
				(cAliasSRD)->(dbSkip())		
				Loop
			EndIf
		Endif    
		
		// Consiste Parametrizacao do Intervalo de Impressao            
		If (SRA->RA_NOME < NomDe) .Or. (SRA->RA_NOME > NomAte) .Or. ;
			(SRA->RA_MAT < MatDe) .Or. (SRA->RA_MAT > MatAte)
			(cAliasSRD)->(dbSkip())
			Loop
		EndIf  
			
		// Consiste controle de acessos e filiais validas               
		If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
			(cAliasSRD)->(dbSkip())
			Loop
		EndIf

		If nVerHor <> 1 .and. lPrimeira
			For nFor := 1 To Len(aTotais) 
				WCabec1 += If(nValHor=1,Space(4),Space(6))+FVerba(aTotais[nFor,1],If(nValHor==1,11,6),SRA->RA_FILIAL)
				WCabec2 += If(nValHor=1,Space(9)+STR0017,Space(10)+STR0018)+" "  //"V A L O R"###"HORAS"
			Next
			lPrimeira := .F.
		EndIf
			
		nCtSB  := 0
		nCtcPd := 0
		lQuery := .T.
		
		
		If lSitHist	//Seleciona somente se quer considerar selecao historica
			// Verifica o tipo de Afastamentono mes que esta sendo listado 
			cTipAfas := " "
			dDtAfas  := dDtRet := CtoD("")
			dDtPesqAf:= CTOD("01/" + Right((cAliasSRD)->RD_DATARQ,2) + "/" + Left((cAliasSRD)->RD_DATARQ,4),"DDMMYY")
			fChkAfas((cAliasSRD)->RD_FILIAL,(cAliasSRD)->RD_MAT,dDtPesqAf,@dDtAfas,@dDtRet,@cTipAfas)
	
			If (!Empty(SRA->RA_DEMISSA) .And. MesAno(SRA->RA_DEMISSA)<= MesAno(dDtPesqAf))					
				cTipAfas := "D"
			EndIf
					
			If MesAno(dDtAfas) > MesAno(dDtPesqAf)
				cTipAfas := " "
			EndIf		
			If	!(cTipAfas $ cSituacao)
				(cAliasSRD)->(dbSkip())
				Loop
			EndIf
		EndIf
				
		If (cAliasSRD)->RD_DATARQ < cAnoMesI 
			(cAliasSRD)->(dbSkip())
			Loop
		EndIf
				
		If !Empty((cAliasSRD)->RD_EMPRESA) .And. (cAliasSRD)->RD_EMPRESA # FWCODEMP("SRD")
			(cAliasSRD)->(dbSkip())
			Loop
		EndIf    
				
		If (cAliasSRD)->RD_SEMANA < cSemanaDe .Or. (cAliasSRD)->RD_SEMANA > cSemanAte
			(cAliasSRD)->(dbSkip())
			Loop
		EndIf   
				
		If !lTodos .And. !Empty(cVerba) .And. !((cAliasSRD)->RD_PD $ cVerba) 
			(cAliasSRD)->(dbSkip())
			Loop
		EndIf
		
		// Consiste controle de acessos							 
		If !Eval(cAcessaSRD)
			(cAliasSRD)->(dbSkip())
			Loop
		EndIf 
				
		DtPagto:= LEFT(DTOC((cAliasSRD)->RD_DATPGT),6) + RIGHT(DTOC((cAliasSRD)->RD_DATPGT),2)
		
		FAcumula((cAliasSRD)->RD_PD,(cAliasSRD)->RD_HORAS,(cAliasSRD)->RD_VALOR,(cAliasSRD)->RD_DATARQ, DtPagto ,(cAliasSRD)->RD_TIPO1,(cAliasSRD)->RD_TIPO2)
				
		If PosSrv( (cAliasSRD)->RD_PD , SRA->RA_FILIAL , "RV_TIPOCOD" ) == "2"		//Proventos
			nValorM := (cAliasSRD)->RD_VALOR * (-1)
		Else
			nValorM := (cAliasSRD)->RD_VALOR                 
		EndIf
			
		// Somar no Liquido do Funcionario
		If lLiquido .And. nVerHor = 2 .And. aScan(aTotais,{ |x| x[1] = (cAliasSRD)->RD_PD}) > 0
			FAcumula("LIQ",(cAliasSRD)->RD_HORAS,nValorM,(cAliasSRD)->RD_DATARQ, DtPagto ,(cAliasSRD)->RD_TIPO1,(cAliasSRD)->RD_TIPO2)
		EndIf					
		
		// Somar no total do funcionario
		If lTotais .And.  nVerHor = 2 .And. Ascan(aTotais,{ |x| x[1] = (cAliasSRD)->RD_PD}) > 0
			FAcumula("TOT",(cAliasSRD)->RD_HORAS,(cAliasSRD)->RD_VALOR,(cAliasSRD)->RD_DATARQ, DtPagto ,(cAliasSRD)->RD_TIPO1,(cAliasSRD)->RD_TIPO2)
		EndIf	

		If	FTotaliza(2)+FTotaliza(3) > 0 .and. lSalario .And. nVerHor == 1
			FAcumula(" SB",SRA->RA_HRSMES,SRA->RA_SALARIO,cAnoMesI," "," "," ")
		ElseIf	FTotaliza(2)+FTotaliza(3) > 0 .and. lSalario .And. nVerHor == 2
			nPos := Ascan(aTotais,{|x|x[1]==" SB"})
			if nPos ==0
				Aadd(aTotais,{" SB",SRA->RA_HRSMES,SRA->RA_SALARIO,SRA->RA_HRSMES,SRA->RA_SALARIO,SRA->RA_HRSMES,SRA->RA_SALARIO,SRA->RA_HRSMES,SRA->RA_SALARIO,cAnoMesI,"","","",0.00,0,0,0,0})
			Else
				aTotais[nPos,02] += SRA->RA_HRSMES
				aTotais[nPos,03] += SRA->RA_SALARIO
				aTotais[nPos,04] += SRA->RA_HRSMES
				aTotais[nPos,05] += SRA->RA_SALARIO
				aTotais[nPos,06] += SRA->RA_HRSMES
				aTotais[nPos,07] += SRA->RA_SALARIO
				aTotais[nPos,08] += SRA->RA_HRSMES
				aTotais[nPos,09] += SRA->RA_SALARIO
				aTotais[nPos,10] := cAnoMesI
				aTotais[nPos,14] := 0
			EndIf	       
		Endif    

		(cAliasSRD)->(dbSkip())
		IF !(cAliasSRD)->(Eof()) 
			if (cAliasSRD)->(RD_FILIAL + RD_CC + RD_MAT) <> SRD->(RD_FILIAL+RD_CC+RD_MAT)      
				fImpFun()
				TotalCCSRD()
			ENDIF
		Else
			fImpFun()
			cCcAnt       := SRD->RD_CC
			cFilAnterior := SRD->RD_FILIAL	
			fImpCc()
			fImpFil()
			fImpEmp()

		ENDIF
	Else
		(cAliasSRD)->(dbSkip())			
	ENDIF
Enddo

(cAliasSRD)->(DBCloseArea())

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function TotalCCSRD
Imprime o total por centro de custo, filial e empresa quando a ordenacao for pelo centro de custo da SRD
@author  Gisele Nuncherino
@since   13/11/2020
/*/
//-------------------------------------------------------------------
Static Function TotalCCSRD() 

cCcAnt       := SRD->RD_CC
cFilAnterior := SRD->RD_FILIAL	
				
If (cAliasSRD)->(Eof()) .Or. SRD->RD_FILIAL + SRD->RD_CC > cFim
	fImpCc()
	fImpFil()
	fImpEmp()
ElseIf cFilAnterior # (cAliasSRD)->(RD_FILIAL)
	fImpCc()
	fImpFil()
ElseIf cCcAnt # (cAliasSRD)->(RD_CC) .And. !(cAliasSRD)->(Eof())
	fImpCc()
	// Saltar a pagina quando quebra CC e Sim
	If mv_par25 = 1
		IMPR510("","P")
	EndIf
EndIf

cCcAnt       := (cAliasSRD)->RD_CC
cFilAnterior := (cAliasSRD)->RD_FILIAL

Return
