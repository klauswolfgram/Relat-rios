/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"  
#INCLUDE "PONR010.CH" 
#INCLUDE "RPTDEF.CH"  
#INCLUDE "FWPrintSetup.ch" 
#INCLUDE "PONCALEN.CH" 

/*Fonte padrão correspondente ao Rdmake IMPESP.PRX; Alterações realizadas neste fonte devem ser compatibilizadas também no Rdmake.*/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Versão 1 ³ Autor ³ Equipe Advanded RH              ³ Data ³ 07.04.96 ³±±
±±³          ³ Versão 2 ³ Autor ³ Leandro Drumond                 ³ Data ³ 17.03.15 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Espelho do Ponto                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_PONR010(void)                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³    Data   ³     FNC     ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Leandro Dr. ³17/03/2015 ³      		 ³Conversão para FWMSPRINTER.               ³±±
±±³Luis Artuso ³16/06/2015 ³       TSADU0³Ajuste na chamada da rotina DescAbono em  ³±±
±±³            ³           ³      		 ³fTotaliza para enviar a filial do funcio- ³±±
±±³            ³           ³      		 ³nario quando o modo de compartilhamento da³±±
±±³            ³           ³      		 ³tabela SP6 estiver exclusivo.             ³±±
±±³Leandro Dr. ³22/07/2015 ³      TSWKZ1 ³Inclusão de totalizador de banco de horas.³±±
±±³Luis Artuso ³06/10/2015 ³      TTIRVP ³Ajuste para corrigir o totalizador de ho- ³±±
±±³            ³           ³      		 ³ras extras, para informar corretamente o  ³±±
±±³            ³           ³      		 ³valor das horas informadas.               ³±±
±±³Luis Artuso ³26/10/2015 ³       TTRDY0³Ajuste para corrigir a exibicao de horas  ³±±
±±³            ³           ³      		 ³no formato Centesimal/Sexagenal.          ³±±
±±³Renan Borges³29/11/2015 ³       TTXSEM³Ajuste para imprimir saldo anterior e sal-³±±
±±³            ³           ³             ³do atual do Banco de Horas no Espelho de  ³±±
±±³            ³           ³             ³Ponto gráfico corretamente.               ³±±
±±³            ³           ³             ³Ajuste para gerar horas do banco de horas ³±±
±±³            ³           ³             ³respeitando o parametro "Horas em?" que   ³±±
±±³            ³           ³             ³diz se é Centesimal ou Sexagenal.         ³±±
±±³            ³           ³             ³Ajuste para quando nome da empresa possuir³±±
±±³            ³           ³             ³50 caracteres não seja impresso o CNPJ em ³±±
±±³            ³           ³             ³cima do nome da empresa.                  ³±±
±±³            ³           ³             ³Ajuste para imprimir o espelho de ponto   ³±±
±±³            ³           ³             ³corretamente, ajustando os valores impres-³±±
±±³            ³           ³             ³sos nas colunas de Absenteismo e Horas Ex-³±±
±±³            ³           ³             ³tras, por serem horas não utilizam a para-³±±
±±³            ³           ³             ³metrização de Sexagenal/Centesimal, apenas³±±
±±³            ³           ³             ³valores (Totais/Banco de Horas) utilizam  ³±±
±±³            ³           ³             ³essa parametrização. ajustando a impressão³±±
±±³            ³           ³             ³dos turnos quando há troca de turnos, para³±±
±±³            ³           ³             ³não encavalar e sendo impresso as informa-³±±
±±³            ³           ³             ³ções de observação na coluna correta de   ³±±
±±³            ³           ³             ³Observação, como era realizado no espelho ³±±
±±³            ³           ³             ³de ponto antigo.                          ³±±
±±³Renan Borges³17/02/2016 ³       TUEMC7³Ajuste para gerar horas do banco de horas ³±±
±±³            ³           ³             ³respeitando o parametro "Horas em?" que   ³±±
±±³            ³           ³             ³diz se é Centesimal ou Sexagenal.         ³±±
±±³Renan Borges³21/03/2016 ³       TURWDO³Ajuste para que descrição de departamento ³±±
±±³            ³           ³      		 ³não sejam impressa sobreposta com o turno.³±±
±±³Renan Borges³13/05/2016 ³       TUXRXC³Ajuste para imprimir horas de absenteísmo ³±±
±±³            ³           ³      		 ³corretamente.                             ³±±
±±³Matheus M.  ³10/08/2016 ³       TVMTGF³Ajuste para exibir o item Descrição da    ³±±
±±³            ³           ³      		 ³categoria.                                ³±±
±±³M. Silveira ³09/02/2017 ³     MRH-6012³Incluida a funcao Pnr010Afas para fazer a ³±±
±±³            ³           ³             ³impressao da situacao no cabecalho.       ³±±
±±³Eduardo K.  ³16/02/2017 ³MPRIMESP-9116³Ajuste na impressão de informações geradas³±±
±±³            ³           ³      		 ³sobrepostas.		                        ³±±
±±³M. Silveira ³31/03/2017 ³     MRH-9208³Ajuste na avaliacao dos afastamentos na   ³±±
±±³            ³           ³             ³Pnr010Afas p/ considerar somente aqueles  ³±±
±±³            ³           ³             ³que estao dentro do periodo do ponto.     ³±±
±±³Renan Borges³03/04/2017 ³     MRH-9141³Ajuste para mostrar Centro de Custo corre-³±±
±±³            ³           ³             ³tamente do período de impressão do espelho³±±
±±³            ³           ³             ³do ponto.                                 ³±±
±±³Renan Borges³09/05/2017 ³ DRHPONTP-287³Melhoria para que a rotina de listagem de ³±±
±±³            ³           ³             ³marcações na portal apresente as marcações³±±
±±³            ³           ³             ³quando informado no parâmetro MV_COLMARC  ³±±
±±³            ³           ³             ³mais que 6 conjutos de marcações.         ³±±
±±³Renan Borges³05/07/2017 ³ DRHPONTP-903³Ajuste para trazer a observação de afasta-³±±
±±³            ³           ³             ³mento sem ultrapassar a borda do relatório³±±
±±³Isabel N.   ³18/07/2017 ³DRHPONTP-1120³Ajuste no cabecalho p/ exibir CPF, CNPJ ou³±±
±±³            ³           ³             ³CEI da empresa conforme definido pelo CFG;³±±
±±³            ³           ³             ³Ajuste p/quebra de pág. ao imprimir totais³±±
±±³            ³           ³             ³de banco de horas quando necessário.      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Ponr010( lTerminal, cFilTerminal, cMatTerminal, cPerAponta, lPortal, aRetPortal, lMeuRH, cFileName, aProcFun )

Local aArea			:= GetArea()
Local cHtml			:= ""
Local cAviso	
Local aFilesOpen	:= {"SP5", "SPN", "SP8", "SPG","SPB","SPL","SPC", "SPH", "SPF"}
Local bCloseFiles	:= {|cFiles| If( Select(cFiles) > 0, (cFiles)->( DbCloseArea() ), NIL) }
Local lNoWeb		:= .T.
Private lTAE		:= .F. // Variável que define se envia para o TAE
Private oSign		:= Nil
Private aLogTAE     := Array(2)
Private aLogTitle   := Array(2) 
Private nTpNotTae	:= SuperGetMv("MV_RHTAENT", .F., 1)

// Define Variaveis Private(Basicas)
Private nomeprog := 'PONR010'
Private nLastKey := 0
Private cPerg    := 'PNR010'
Private oPrinter

// Define variaveis Private utilizadas no programa RDMAKE ImpEsp
Private aImp      := {}
Private aTotais   := {}
Private aAbonados := {}
Private aAfast    := {}
Private nImpHrs   := 0

// Variaveis Utilizadas na funcao IMPR
Private Titulo   := OemToAnsi(STR0001 ) // 'Espelho do Ponto'

// Define Variaveis Private(Programa)
Private dPerIni  := Ctod("//")
Private dPerFim  := Ctod("//")
Private cMenPad1 := Space(30)
Private cMenPad2 := Space(19)
Private cLocal	 := ""
Private cFilSPA	 := xFilial("SPA", SRA->RA_FILIAL)
Private nOrdem   := 1
Private aInfo    := {}
Private aTurnos  := {}
Private aPrtTurn := {}
Private nColunas := 0
Private aNaES	 := {}
Private nCol	 := 0
Private nColTot	 := 0
Private nLinTot	 := 0
Private aMargRel := {}
Private nLin	 := 0
Private nPxData	 :=	0
Private nPxSemana:= 0
Private nPxAbonos:= 0
Private nPxHe	 := 0
Private nPxHrVal := 0
Private nPxJor	 := 0
Private nPxFalta := 0
Private nPxAdnNot:= 0
Private nPxObser := 0
Private lImpMarc := .T.
Private lImpHrVal:= .F.
Private lCodeBar := .F.
Private lBigLine := .T.
Private nTamRAMAT := TamSx3("RA_MAT")[1]
Private lPort671 := SuperGetMV("MV_PORT671",, .F.)
Private lMRHTae  := SuperGetMv("MV_MRHTAE", NIL, .F.) // Método de assinatura do TAE caso o cliente utilize o MeuRH

DEFAULT lTerminal := .F.
DEFAULT lMeuRH    := .F.
DEFAULT aProcFun  := {}

#DEFINE Imp_Spool      	2
#DEFINE ALIGN_H_LEFT   	0
#DEFINE ALIGN_H_RIGHT  	1
#DEFINE ALIGN_H_CENTER 	2
#DEFINE ALIGN_V_CENTER 	0
#DEFINE ALIGN_V_TOP	   	1
#DEFINE ALIGN_V_BOTTON 	2
#DEFINE oFontT 			TFont():New( "Verdana", 09, 09, , .T., , , , .T., .F. )//Titulo
#DEFINE oFontP 			TFont():New( "Verdana", 09, 09, , .T., , , , .T., .F. )//Linhas
#DEFINE oFontM 			TFont():New( "Verdana", 07, 07, , .F., , , , .T., .F. )//Marcacoes
#DEFINE oFontO 			TFont():New( "Verdana", 04, 04, , .F., , , , .T., .F. )//Marcacoes
#DEFINE oFont06 		TFont():New( "Verdana", 06, 06, , .T., , , , .T., .F. )//CodeBar

aFill(aLogTitle, "")
aLogTAE[1] := {}
aLogTAE[2] := {}

lPortal   := IF( lPortal == NIL , .F. , lPortal )
lNoWeb    := !lTerminal .And. !lMeuRH

// Parâmetro MV_COLMARC
IF lPortal .OR. fValMVCOL() == .T.
	nColunas := SuperGetmv("MV_COLMARC")
Else
	Help("", 1,OemToAnsi( STR0086 ),,OemToAnsi( STR0080 ),1,0) // "Para esse relatório o parametro MV_COLMARC deve ser menor ou igual à 5."
	Return( .F. )
ENDIF

If ( nColunas == NIL )
	Help("", 1, "MVCOLNCAD")
	Return( .F. )
EndIf

// O numero de colunas eh sempre aos pares
nColunas *= 2

// Chamada da função para criar o objeto FWMSPrinter
SetUpPrint(@oPrinter, lTerminal, lMeuRH, cFileName)

// Cancelar a impressão
If !lTerminal .And. oPrinter == NIL
	Return
EndIf

// Verifica as perguntas selecionadas
Pergunte( cPerg, .F. )

// Carregando variaveis MV_PAR?? para Variaveis do Sistema.
FilialDe	:= IF( lNoWeb , MV_PAR01, cFilTerminal )			//Filial  De
FilialAte	:= IF( lNoWeb , MV_PAR02, cFilTerminal )			//Filial  Ate
CcDe		:= IF( lNoWeb , MV_PAR03, SRA->RA_CC   )			//Centro de Custo De
CcAte		:= IF( lNoWeb , MV_PAR04, SRA->RA_CC   )			//Centro de Custo Ate
TurDe		:= IF( lNoWeb , MV_PAR05, SRA->RA_TNOTRAB)			//Turno De
TurAte		:= IF( lNoWeb , MV_PAR06, SRA->RA_TNOTRAB)			//Turno Ate
MatDe		:= IF( lNoWeb , MV_PAR07, cMatTerminal)				//Matricula De
MatAte		:= IF( lNoWeb , MV_PAR08, cMatTerminal)				//Matricula Ate
NomDe		:= IF( lNoWeb , MV_PAR09, SRA->RA_NOME)				//Nome De
NomAte		:= IF( lNoWeb , MV_PAR10, SRA->RA_NOME)				//Nome Ate
cSit		:= IF( lNoWeb , MV_PAR11, fSituacao( NIL , .F. ))	//Situacao
cCat		:= IF( lNoWeb , MV_PAR12, fCategoria( NIL , .F. ))	//Categoria
nImpHrs		:= IF( lNoWeb , MV_PAR13, 3 )						//Imprimir horas Calculadas/Inform/Ambas/NA
nImpAut		:= IF( lNoWeb , MV_PAR14, 1 )						//Demonstrar horas Autoriz/Nao Autorizadas
nCopias		:= IF( lNoWeb , If(MV_PAR15>0,MV_PAR15,1),1)		//N£mero de C¢pias
lSemMarc	:= IF( lNoWeb , (MV_PAR16==1), IIF(lPortal .Or. lMeuRH,.T.,.F.) )//Imprime para Funcion rios sem Marca‡oes
cMenPad1	:= IF( lNoWeb , MV_PAR17, "" )						//Mensagem padr„o anterior a Assinatura
cMenPad2	:= IF( lNoWeb , MV_PAR18, "" )						//Mens. padr„o anterior a Assinatura(Cont.)
dPerIni     := IF( lNoWeb , MV_PAR19, Stod(Subst(cPerAponta, 1, 8)) )	//Data Contendo o Inicio do Periodo de Apontamento
dPerFim     := IF( lNoWeb , MV_PAR20, Stod( Subst(cPerAponta, 9, 8)) )	//Data Contendo o Fim  do Periodo de Apontamento
lSexagenal	:= IF( lNoWeb , (MV_PAR21==1), .T.  )				//Horas em  (Sexagenal/Centesimal)
lImpRes		:= IF( lNoWeb , (MV_PAR22==1), .F.	)				//Imprime eventos a partir do resultado ?
lImpTroca   := IF( lNoWeb , (MV_PAR23==1), .F.	)				//Imprime Descricao Troca de Turnos ou o Atual 
lImpExcecao := IF( lNoWeb , (MV_PAR24==1), .F.	)				//Imprime Descricao da Excecao no Lugar da do Afastamento  
DeptoDe		:= IF( lNoWeb , MV_PAR25, SRA->RA_DEPTO   )			//Departamento De
DeptoAte	:= IF( lNoWeb , MV_PAR26, SRA->RA_DEPTO   )			//Departamento Ate
lImpMarc 	:= IF( lNoWeb , MV_PAR27==1, .T.   )		 		//Imprime marcações? .T.
lCodeBar 	:= IF( lNoWeb , MV_PAR28==1, .F.   ) 				//Imprime código de barras? .F.
lBigLine 	:= IF( lNoWeb , MV_PAR29==1, .T.   ) 				//Destaca linhas? .T.
lImpBh 		:= IF( lNoWeb , MV_PAR30==1, If( lMeuRH,.T.,.F. ) )	//Imprime banco de horas
RegDe		:= IF( lNoWeb , MV_PAR31, SRA->RA_REGRA)			//Regra De
RegAte		:= IF( lNoWeb , MV_PAR32, SRA->RA_REGRA)			//Regra Ate

If Type("MV_PAR33") == "N"
	lImpHrVal 	:= IF( lNoWeb , MV_PAR33 == 1, .T.)		 		//Imprime Horas Valorizadas?	
EndIf

If Type("MV_PAR34") == "N"
	lTAE := If( lNoWeb, MV_PAR34 == 1, .F.)		 				//Integração totvs assinatura eletrônica
EndIf

If lTAE .And. !U_SetUpSign(@oSign)
	Return .F.
EndIf

If lTAE .And. nTpNotTae > 1
	If !MsgNoYes(STR0122) // "Ao utilizar a notificação via WhatsAPP/SMS poderá ser gerado um custo adicional, verifique se o seu contrato já possui essa funcionalidade. Deseja continuar?"
		Return .F.
	EndIf
EndIf

// Redefine o Tamanho das Mensagens Padroes
cMenpad1 := IF(Empty( cMenPad1 ) , Space( 30 ) , cMenPad1 )
cMenpad2 := IF(Empty( cMenPad2 ) , Space( 19 ) , cMenPad2 )

Begin Sequence
	
	If ( lTerminal .Or. lMeuRH)
		//-- Verifica se foi possivel abrir os arquivos sem exclusividade
		If Pn090Open(@cHtml, @cAviso)
			cHtml := ""	
			cHtml := Pnr010Imp( NIL , lTerminal, lPortal, aRetPortal, oPrinter, lMeuRH, cFileName, aProcFun )
			/*
			ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			³ Apos a obtencao da consulta solicitada fecha os arquivos     ³
			³ utilizados no fechamento mensal para abertura exclusiva      ³
			ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
			Aeval(aFilesOpen, bCloseFiles)
		Else
			cHtml := HtmlDefault( cAviso , cHtml )   
		Endif    
	ElseIf !( nLastKey == 27 )
		
		If Pn090Open(@cHtml, @cAviso)
			
			If Empty( dPerIni ) .or. Empty( dPerFim )
				Help(" ",1,"PONFORAPER" , , OemToAnsi( STR0039 ) , 5 , 0  )	//'Periodo de Apontamento Invalido.'
				Break
			EndIf
			
			If !( nLastKey == 27 )
				
				RptStatus( { |lEnd| Pnr010Imp(@lEnd, lTerminal, ,,oPrinter ) } , Titulo )
				
			EndIf
		Else
			MsgStop( cHtml, cAviso )
			cHtml := ""
		EndIf
		
	EndIf
	
End Sequence

If !lTAE .And. !lTerminal .And. !lMeuRH
	oPrinter:lViewPDF := .F.
	oPrinter:Preview()
	ShellExecute("Open", StrTran(oPrinter:cPathPDF + oPrinter:cFileName, ".rel", ".PDF"), "", "",1)
EndIf

If lTAE
	
	If oSign != NIL
		oSign:destroy()
	EndIf
	
	MsAguarde( { || fMakeLog( aLogTAE, aLogTitle, cPerg, , "PONR010", STR0101 )}, STR0101 ) //"Log de ocorrências na integração com TAE"
EndIf

RestArea(aArea)

Return( cHtml )

/*/{Protheus.doc} SetUpPrint
Instacia a classe FWMSPrinter e realiza as configurações para impressão do relatório
@type  Static Function
@author Cícero Alves
@since 24/01/2022
@param oPrinter, Objeto, Instância da classe FWMSPrinter - deve ser passado por referência
@param lTerminal, Lógico, Define se a rotina está sendo executada sem interface - Portal
@param lMeuRH, Lógico, Indica se a chamada da rotina foi realizada pelo Meu RH
@param cFileName, Caracter, Nome do arquivo que será gerado
/*/
Static Function SetUpPrint(oPrinter, lTerminal, lMeuRH, cFileName)
	
	Local cSession	 := GetPrinterSession()
	Local cDestino	 := fwGetProfString(cSession, "DEFAULT", "c:\", .T.)
	Local cDevice    := fwGetProfString(cSession, "PRINTTYPE", "PDF", .T.)
	Local aMargProf	 := {}
	Local nFlags   	 := PD_ISTOTVSPRINTER +  PD_DISABLEORIENTATION
	Local oSetup
	Local aOrdem     := {STR0004 , STR0005 , STR0006 , STR0007, STR0038, STR0060, STR0061  } // 'Matricula'###'Centro de Custo'###'Nome'###'Turno'###'C.Custo + Nome'###'Departamento'###'Departamento + Nome'
	Local cFile		 := ""
	Static cPathTmp	 := GetTempPath(.F.)
	
	// Envia controle para a funcao SETPRINT
	If !lTAE .and. !lTerminal .And. !lMeuRH 
		aDevice := {}
		
		// Define os Tipos de Impressao validos
		AADD(aDevice,"DISCO") 
		AADD(aDevice,"SPOOL") 
		AADD(aDevice,"EMAIL") 
		AADD(aDevice,"EXCEL") 
		AADD(aDevice,"HTML" ) 
		AADD(aDevice,"PDF"  )  
		
		// Realiza as configuracoes necessarias para a impressao
		nPrintType := aScan(aDevice,{|x| x == cDevice }) 
		nLocal     := If( fWGetProfString( cSession, "LOCAL", "SERVER", .T. ) == "SERVER", 1, 2 )                                                                                                                                                                                                                          
		
		aMargProf := {fwGetProfString(cSession,"MARG1","10",.T.),fwGetProfString(cSession,"MARG2","10",.T.),fwGetProfString(cSession,"MARG3","10",.T.),fwGetProfString(cSession,"MARG4","10",.T.) }
		
		oSetup := FWPrintSetup():New(nFlags, Titulo)
		oSetup:SetUserParms( {|| Pergunte(cPerg, .T.) } ) 
		oSetup:SetPropert(PD_PRINTTYPE   , nPrintType)
		oSetup:SetPropert(PD_ORIENTATION , 2) 
		oSetup:SetPropert(PD_DESTINATION , nLocal)
		oSetup:SetPropert(PD_MARGIN      , {Val(aMargProf[1]),Val(aMargProf[2]),Val(aMargProf[3]),Val(aMargProf[4])})
		oSetup:SetPropert(PD_PAPERSIZE   , 2)
		oSetup:SetPropert(PD_PREVIEW, .T.)
		oSetup:SetOrderParms(aOrdem, @nOrdem)
		
		If cDevice == "PDF"
			oSetup:aOptions[PD_VALUETYPE] := cDestino
		EndIf
		
		oPrinter := FWMSPrinter():New( 'PONR010', IMP_PDF , .F., , .T., , oSetup )
		
		If !(oSetup:Activate() == PD_OK)
			oPrinter:Deactivate() 
			oPrinter := NIL
			Return
		EndIf
		
		oPrinter:lServer := oSetup:GetProperty( PD_DESTINATION ) == AMB_SERVER                      
		oPrinter:SetResolution( 75 )
		
		If oSetup:GetProperty( PD_ORIENTATION ) == 2
			oPrinter:SetLandscape()
		Else
			oPrinter:SetPortrait()
		EndIf
		
		oPrinter:SetPaperSize( oSetup:GetProperty( PD_PAPERSIZE ) )
		oPrinter:SetMargin(oSetup:GetProperty( PD_MARGIN )[1],oSetup:GetProperty( PD_MARGIN )[2],oSetup:GetProperty( PD_MARGIN )[3],oSetup:GetProperty( PD_MARGIN )[4])
		aMargRel := {oSetup:GetProperty( PD_MARGIN )[1],oSetup:GetProperty( PD_MARGIN )[2],oSetup:GetProperty( PD_MARGIN )[3],oSetup:GetProperty( PD_MARGIN )[4]}
		
		fwWriteProfString(cSession,"LOCAL", If(oSetup:GetProperty(PD_DESTINATION)==1,"SERVER","LOCAL"), .T.)
		fwWriteProfString(cSession,"PRINTTYPE", aDevice[oSetup:GetProperty( PD_PRINTTYPE )], .T.)
		fwWriteProfString(cSession,"MARG1", alltrim(str(aMargRel[1])), .T.)
		fwWriteProfString(cSession,"MARG2", alltrim(str(aMargRel[2])), .T.)
		fwWriteProfString(cSession,"MARG3", alltrim(str(aMargRel[3])), .T.)
		fwWriteProfString(cSession,"MARG4", alltrim(str(aMargRel[4])), .T.)
		
		If oSetup:GetProperty( PD_PRINTTYPE ) == Imp_Spool  
		
			oPrinter:nDevice := Imp_Spool
			fwWriteProfString(cSession,"DEFAULT", oSetup:aOptions[PD_VALUETYPE], .T.)
			oPrinter:cPrinter := oSetup:aOptions[PD_VALUETYPE]
			
		ElseIf oSetup:GetProperty( PD_PRINTTYPE ) == IMP_PDF
			
			oPrinter:nDevice := IMP_PDF
			fwWriteProfString(cSession,"DEFAULT", oSetup:aOptions[PD_VALUETYPE], .T.)	
			oPrinter:cPathPDF := oSetup:aOptions[PD_VALUETYPE]
			cPathTmp := oSetup:aOptions[PD_VALUETYPE]
		EndIf
		
	ElseIf lMeuRH .Or. lTAE
		aMargRel := {10,10,10,10}
		cFile    := cFileName
		cLocal	 := GetSrvProfString ("STARTPATH", "")
		If lTAE
			oPrinter := FWMSPrinter():New( cFileName, IMP_PDF, .F., cPathTmp, .T., , , , , , , .F. )
			oPrinter:nDevice := IMP_PDF
			fwWriteProfString(cSession, "DEFAULT", cPathTmp, .T.)	
			oPrinter:cPathPDF := cPathTmp
		Else
			oPrinter := FWMSPrinter():New( cFile + ".rel", IMP_PDF, .F.,   cLocal, .T., , , , .T., , .F., )
		EndIf
		oPrinter:SetResolution( 75 )
		oPrinter:SetLandscape()
		oPrinter:SetMargin(10, 10, 10, 10)
		oPrinter:SetPaperSize( 1 )
	EndIf
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ POR010Imp³ Autor ³ EQUIPE DE RH          ³ Data ³ 07.04.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Espelho do Ponto                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ Pnr010Imp(lEnd)					                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - A‡Æo do Codelock                             ³±±
±±³          ³ cString     - Mensagem                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Pnr010Imp( lEnd, lTerminal, lPortal, aRetPortal, oPrinter, lMeuRH, cFileName, aProcFun )

Local aAbonosPer	:= {}
Local cOrdem		:= ""
Local cWhere		:= ""
Local cSituacao		:= ""
Local cCategoria	:= ""
Local cLastFil		:= "__cLastFil__"
Local cAcessaSRA	:= &("{ || " + ChkRH("PONR010","SRA","2") + "}")
Local cSeq			:= ""
Local cTurno		:= ""
Local cHtml			:= ""
Local cAliasSRA		:= GetNextAlias()
Local cAliasQTD		:= GetNextAlias()
Local lSPJExclu		:= !Empty( xFilial("SPJ") )
Local lSP9Exclu		:= !Empty( xFilial("SP9") )
Local nCount		:= 0.00
Local nX			:= 0.00
Local nY			:= 0
Local lMvAbosEve	:= .F.
Local lMvSubAbAp	:= .F.
Local cFile			:= ""
Local cPathFile		:= ""
Local lOk			:= .F.
Local lPrinter		:= .F.

Private aFuncFunc  := {SPACE(1), SPACE(1), SPACE(1), SPACE(1), SPACE(1), SPACE(1)}		
Private aMarcacoes := {}
Private aMarcDes   := {}
Private aTabPadrao := {}
Private aTabCalend := {}
Private aPeriodos  := {}
Private aId		   := {}
Private aResult	   := {}
Private aBoxSPC	   := LoadX3Box("PC_TPMARCA") 
Private aBoxSPH	   := LoadX3Box("PH_TPMARCA")
Private cCodeBar   := ""
Private dIniCale   := Ctod("//")	//-- Data Inicial a considerar para o Calendario
Private dFimCale   := Ctod("//")	//-- Data Final a considerar para o calendario
Private dMarcIni   := Ctod("//")	//-- Data Inicial a Considerar para Recuperar as Marcacoes
Private dMarcFim   := Ctod("//")	//-- Data Final a Considerar para Recuperar as Marcacoes
Private dIniPonMes := Ctod("//")	//-- Data Inicial do Periodo em Aberto 
Private dFimPonMes := Ctod("//")	//-- Data Final do Periodo em Aberto 
Private lImpAcum   := .F.
Private aCodAut	:= {}

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Como a Cada Periodo Lido reinicializamos as Datas Inicial e Fi³
³nal preservamos-as nas variaveis: dCaleIni e dCaleFim.		   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
dIniCale   := dPerIni   //-- Data Inicial a considerar para o Calendario
dFimCale   := dPerFim   //-- Data Final a considerar para o calendario

For nX:=1 to Len(cSit)
	If Subs(cSit,nX,1) <> "*"
		cSituacao += "'"+Subs(cSit,nX,1)+"'"
		If ( nX+1 ) <= Len(cSit)
			cSituacao += "," 
		EndIf
	EndIf
Next nX

If !Empty(cSituacao) .and. Subs(cSituacao,Len(cSituacao),1) == ","
	cSituacao := Subs(cSituacao,1,Len(cSituacao)-1)
EndIf     

For nX:=1 to Len(cCat)
	If Subs(cCat,nX,1) <> "*"
		cCategoria += "'"+Subs(cCat,nX,1)+"'"
		If ( nX+1 ) <= Len(cCat)
			cCategoria += "," 
		EndIf
	EndIf
Next nX

If !Empty(cCategoria) .and. Subs(cCategoria,Len(cCategoria),1) == ","
	cCategoria := Subs(cCategoria,1,Len(cCategoria)-1)
EndIf 

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Inicializa Variaveis Static								   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
( CarExtAut() , RstGetTabExtra() )

//--Seleciona funcionários de acordo com filtros
cWhere += "%"
If !lMeuRH .Or. (lMeuRH .And. Empty(aProcFun))
	cWhere += "SRA.RA_FILIAL >= '" + FilialDe + "' AND "
	cWhere += "SRA.RA_FILIAL <= '" + FilialAte + "' AND "
	cWhere += "SRA.RA_CC >= '" + CCDe + "' AND "
	cWhere += "SRA.RA_CC <= '" + CCAte + "' AND "
	cWhere += "SRA.RA_TNOTRAB >= '" + TurDe + "' AND "
	cWhere += "SRA.RA_TNOTRAB <= '" + TurAte + "' AND "
	cWhere += "SRA.RA_MAT >= '" + MatDe + "' AND "
	cWhere += "SRA.RA_MAT <= '" + MatAte + "' AND "
	cWhere += "SRA.RA_NOME >= '" + NomDe + "' AND "
	cWhere += "SRA.RA_NOME <= '" + NomAte + "' AND "
	If !Empty(RegAte)
		cWhere += "SRA.RA_REGRA >= '" + RegDe + "' AND "
		cWhere += "SRA.RA_REGRA <= '" + RegAte + "' AND "
	EndIf
	cWhere += "SRA.RA_DEPTO >= '" + DeptoDe + "' AND "
	cWhere += "SRA.RA_DEPTO <= '" + DeptoAte + "'"
Else
	For nY := 1 To Len(aProcFun)
		cWhere += If( nY > 1, " OR ", "" )
		cWhere += "(SRA.RA_FILIAL ='" + aProcFun[nY, 1] + "' AND SRA.RA_MAT = '" + aProcFun[nY, 2] + "')"
	Next nY
EndIf

If !Empty( cSituacao )
	cWhere += " AND SRA.RA_SITFOLH IN ( " + cSituacao + ") " 
EndIf
If !Empty(cCategoria)
	cWhere += " AND SRA.RA_CATFUNC IN ( " + cCategoria + ") "
EndIf
cWhere += " AND SRA.D_E_L_E_T_ = ' ' " 
cWhere += "%"

//'Matricula'###'Centro de Custo'###'Nome'###'Turno'###'C.Custo + Nome'###'Departamento'###'Departamento + Nome'
If ( ( nOrdem == 1 ) .or. ( lTerminal .Or. lMeuRH ) )
	cOrdem := "%SRA.RA_FILIAL, SRA.RA_MAT%"
ElseIf ( nOrdem == 2 )
	cOrdem := "%SRA.RA_FILIAL, SRA.RA_CC%"
ElseIf ( nOrdem == 3 )
	cOrdem := "%SRA.RA_FILIAL, SRA.RA_NOME, SRA.RA_MAT%"
ElseIf ( nOrdem == 4 )
	cOrdem := "%SRA.RA_FILIAL, SRA.RA_TNOTRAB%"
ElseIf ( nOrdem == 5 )
	cOrdem := "%SRA.RA_FILIAL, SRA.RA_CC, SRA.RA_NOME%"
ElseIf ( nOrdem == 6 )
	cOrdem := "%SRA.RA_FILIAL, SRA.RA_DEPTO, SRA.RA_MAT%"
ElseIf ( nOrdem == 7 )
	cOrdem := "%SRA.RA_FILIAL, SRA.RA_DEPTO, SRA.RA_NOME%"
EndIf

BeginSql Alias cAliasSRA
	
	SELECT SRA.RA_FILIAL, SRA.RA_MAT
	FROM 
		%Table:SRA% SRA
	WHERE %Exp:cWhere%
	ORDER BY %Exp:cOrdem%	
	
EndSql 	

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Inicializa R‚gua de Impress„o								   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
If !lTerminal .And. !lMeuRH
	BeginSql Alias cAliasQTD
	
	SELECT Count(*) AS QTDREG
		FROM 
			%Table:SRA% SRA
		WHERE %Exp:cWhere%
	EndSql
	
	SetRegua( (cAliasQTD)->QTDREG )
	(cAliasQTD)->(DbCloseArea())
EndIf

If lCodeBar .Or. lTAE
	DbSelectArea("RS4")
	DbSetOrder(1)
EndIf

dbSelectArea('SRA')
SRA->( dbSetOrder( 1 ) )	

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Processa o Cadastro de Funcionarios						   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
While (cAliasSRA)->( !Eof() )
	
	//Posiciona no funcionário atual
	SRA->(DbSeek((cAliasSRA)->RA_FILIAL + (cAliasSRA)->RA_MAT))
	
	lPrinter := .F.
	
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³So Faz Validacoes Quando nao for Terminal					   ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If !lTerminal .And. !lMeuRH 
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Incrementa a R‚gua de Impress„o							   ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		IncRegua()
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Cancela a Impress„o 										   ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		If ( lEnd )
			Exit
		EndIf
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Consiste controle de acessos e filiais validas               ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		If SRA->( !( RA_FILIAL $ fValidFil() ) .or. !Eval( cAcessaSRA ) )
			(cAliasSRA)->( dbSkip() )
			Loop
		EndIf
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Consiste a data de Demiss„o								   ³
		³Se o Funcionario Foi Demitido Anteriormente ao Inicio do Perio³
		³do Solicitado Desconsidera-o								   ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		If !Empty(SRA->RA_DEMISSA) .and. ( SRA->RA_DEMISSA < dIniCale )
			(cAliasSRA)->( dbSkip() )
			Loop
		EndIf
		
	EndIf
	
    /*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Verifica a Troca de Filial           						  ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If !( SRA->RA_FILIAL == cLastFil )
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Alimenta as variaveis com o conteudo dos MV_'S correspondetes³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/		
		lMvAbosEve	:= ( Upper(AllTrim(SuperGetMv("MV_ABOSEVE",NIL,"N",cLastFil))) == "S" )	//--Verifica se Deduz as horas abonadas das horas do evento Sem a necessidade de informa o Codigo do Evento no motivo de abono que abona horas
		lMvSubAbAp	:= ( Upper(AllTrim(SuperGetMv("MV_SUBABAP",NIL,"N",cLastFil))) == "S" )	//--Verifica se Quando Abono nao Abonar Horas e Possuir codigo de Evento, se devera Gera-lo em outro evento e abater suas horas das Horas Calculadas
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Atualiza a Filial Corrente           						  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		cLastFil := SRA->RA_FILIAL
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Carrega periodo de Apontamento Aberto						  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		If !CheckPonMes( @dPerIni , @dPerFim , .F. , .T. , .F. , cLastFil )
			Exit
		EndIf
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Obtem datas do Periodo em Aberto							  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		GetPonMesDat( @dIniPonMes , @dFimPonMes , cLastFil )
		
    	/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Atualiza o Array de Informa‡”es sobre a Empresa.			  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		aInfo := {}
		fInfo( @aInfo , cLastFil )
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Carrega as Tabelas de Horario Padrao						  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		If ( lSPJExclu .or. Empty( aTabPadrao ) )
			aTabPadrao := {}
			fTabTurno(@aTabPadrao, If(lSPJExclu, cLastFil, NIL),,, SRA->RA_TNOTRAB)
		EndIf
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Carrega TODOS os Eventos da Filial						  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		If ( Empty( aId ) .or. ( lSP9Exclu ) )
			aId := {}
			CarId( fFilFunc("SP9") , @aId , "*" )
		EndIf
		
		aCodAut := {}
		fTabSP4(@aCodAut,xFilial("SP4",cLastFil))
		
	EndIf
	
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Retorna Periodos de Apontamentos Selecionados				  ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If ( lTerminal .Or. lMeuRH )
		dPerIni	:= dIniCale
		dPerFim := dFimCale
	EndIf
	
	aPeriodos := Monta_Per( dIniCale, dFimCale, cLastFil, SRA->RA_MAT, If(lTerminal .Or. lMeuRH, dPerIni, dIniPonMes), If(lTerminal .Or. lMeuRH, dPerFim, dFimPonMes))
	
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Corre Todos os Periodos 									  ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	naPeriodos := Len( aPeriodos )
	For nX := 1 To naPeriodos
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Reinicializa as Datas Inicial e Final a cada Periodo Lido.	  ³
		³Os Valores de dPerIni e dPerFim foram preservados nas   varia³
		³veis: dCaleIni e dCaleFim.									  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
        dPerIni		:= aPeriodos[ nX , 1 ]
        dPerFim		:= aPeriodos[ nX , 2 ] 
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Obtem as Datas para Recuperacao das Marcacoes				  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
        dMarcIni	:= aPeriodos[ nX , 3 ]
        dMarcFim	:= aPeriodos[ nX , 4 ]
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Verifica se Impressao eh de Acumulado						  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		lImpAcum := ( dPerFim < dIniPonMes )
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Retorna Turno/Sequencia das Marca‡”es Acumuladas			  ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		If ( lImpAcum )
			If SPF->( dbSeek( SRA->( RA_FILIAL + RA_MAT ) + Dtos( dPerIni) ) ) .and. !Empty(SPF->PF_SEQUEPA)
				cTurno	:= SPF->PF_TURNOPA
				cSeq	:= SPF->PF_SEQUEPA
			Else
				/*
				ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				³ Tenta Achar a Sequencia Inicial utilizando RetSeq()³
				ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
				If !RetSeq(cSeq,@cTurno,dPerIni,dPerFim,dDataBase,aTabPadrao,@cSeq) .or. Empty( cSeq )
					/*
					ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					³Tenta Achar a Sequencia Inicial utilizando fQualSeq()		  ³
					ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
					cSeq := fQualSeq( NIL , aTabPadrao , dPerIni , @cTurno )
				EndIf
			EndIf
			
			If ( Empty(cTurno) )
				SPF->( dbSeek( SRA->( RA_FILIAL + RA_MAT ) ) )
				Do While	( !EOF() ) .AND.;
						 	( SRA->RA_FILIAL + SRA->RA_MAT == SPF->PF_FILIAL + SPF->PF_MAT )
					If ( SPF->PF_DATA >= dPerIni .AND. SPF->PF_DATA <= dPerFim )						
						cTurno	:= SPF->PF_TURNOPA
						cSeq	:= SPF->PF_SEQUEPA
						Exit
					Else
						SPF->( dbSkip() )
					EndIf
				EndDo
			EndIf
			
		Else
			/*
			ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			³Considera a Sequencia e Turno do Cadastro            		  ³
			ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
			cTurno	:= SRA->RA_TNOTRAB
			cSeq	:= SRA->RA_SEQTURN  
		EndIf
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Obtem Codigo e Descricao da Funcao do Trabalhador na Epoca   ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/			
		//Limpa array a cada funcionario processado
		aFuncFunc  := {SPACE(1), SPACE(1), SPACE(1), SPACE(1), SPACE(1), SPACE(1)}
		fBuscaCC(dMarcFim, @aFuncFunc[1], @aFuncFunc[2], Nil, .F. , .T.  ) 
		aFuncFunc[2]:= Substr(aFuncFunc[2], 1, 25)
		fBuscaFunc(dMarcFim, @aFuncFunc[3], @aFuncFunc[4],@aFuncFunc[6],.T. )
		
		If Empty(aFuncFunc[6])
			aFuncFunc[6] := DescCateg(SRA->RA_CATFUNC , 25)
		EndIf	
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Carrega Arrays com as Marca‡”es do Periodo (aMarcacoes), com³
		³o Calendario de Marca‡”es do Periodo (aTabCalend) e com    as³	
		³Trocas de Turno do Funcionario (aTurnos)					  ³	
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		( aMarcacoes := {} , aTabCalend := {} , aTurnos := {}, aMarcDes := {} )
		
		If lImpMarc .Or. lImpTroca
			/*
			ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			³ Importante: 												  ³
			³ O periodo fornecido abaixo para recuperar as marcacoes   cor³
			³ respondente ao periodo de apontamentoo Calendario de 	 Marca³	
			³ ‡”es do Periodo ( aTabCalend ) e com  as Trocas de Turno  do³	
			³ Funcionario ( aTurnos ) integral afim de criar o  calendario³	
			³ com as ordens correspondentes as gravadas nas marcacoes	  ³	
			ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
			If !GetMarcacoes(	@aMarcacoes					,;	//Marcacoes dos Funcionarios
								@aTabCalend					,;	//Calendario de Marcacoes
								@aTabPadrao					,;	//Tabela Padrao
								@aTurnos					,;	//Turnos de Trabalho
								dPerIni 					,;	//Periodo Inicial
								dPerFim						,;	//Periodo Final
								SRA->RA_FILIAL				,;	//Filial
								SRA->RA_MAT					,;	//Matricula
								cTurno						,;	//Turno
								cSeq						,;	//Sequencia de Turno
								SRA->RA_CC					,;	//Centro de Custo
								If(lImpAcum,"SPG","SP8")	,;	//Alias para Carga das Marcacoes
								NIL							,;	//Se carrega Recno em aMarcacoes
								.T.							,;	//Se considera Apenas Ordenadas
							    .T.    						,;	//Se Verifica as Folgas Automaticas
								.F.    			 			,;	//Se Grava Evento de Folga Automatica Periodo Anterior
								NIL							,;	//17 -> Se Carrega as Marcacoes Automaticas
								NIL							,;	//18 -> Registros de Marcacoes Automaticas que deverao ser Desprezadas
								NIL							,;	//19 -> Bloco para avaliar as Marcacoes Automaticas que deverao ser Desprezadas
								NIL							,;	//20 -> Se Considera o Periodo de Apontamento das Marcacoes
								NIL							,;	//21 -> Se Efetua o Sincronismo dos Horarios na Criacao do Calendario
								.T.							,;  //22 -> Se carrega as marcacoes desconsideradas (Uso com lPort1510)
								NIL							 ;  //23 -> Se carrega as marcacoes das duas tabelas SP8 e SPG
						 )
				Loop
			EndIf
			
			If lImpMarc
				//Carrega as marcações desconsideradas no aMarcDes e as excluí do aMarcacoes
				GetMarcDes(@aMarcacoes, @aMarcDes)
			EndIf
			
		EndIf					 
		
		aPrtTurn:={}
		Aeval(aTurnos, {|x| If( x[2] >= dPerIni .AND. x[2]<= dPerFim, Aadd(aPrtTurn, x),Nil )} ) 
		
		//Reinicializa os Arrays
		( aTotais := {} , aAbonados := {} )
		aAfast := {}
		
	    //Carrega os Abonos Conforme Periodo.
		If 	lImpMarc
			fAbonosPer( @aAbonosPer , dPerIni , dPerFim , cLastFil , SRA->RA_MAT )
		EndIf
		
	    //Carrega os Totais de Horas e Abonos.
		If 	lImpMarc	
			CarAboTot( @aTotais , @aAbonados , aAbonosPer, lMvAbosEve, lMvSubAbAp )
		EndIf
		
		/*Carrega o Array a ser utilizado na Impressao.
		aPeriodos[nX,3] --> Inicio do Periodo para considerar as marcacoes e tabela
		aPeriodos[nX,4] --> Fim do Periodo para considerar as marcacoes e tabela */
		If ( !fMontaAimp( aTabCalend, aMarcacoes, @aImp,dMarcIni,dMarcFim, lTerminal, lImpAcum, lMeuRH) .and. !( lSemMarc ) )
			Loop
		EndIf
		
	    //Carrega a situacao e os afastamentos.
		Pnr010Afas( dMarcIni, dMarcFim, @aAfast )
		
		// Quando integração com o TAE verifica se o funcionário tem email no cadastro
		If lTAE .And. Empty(SRA->RA_EMAIL)
			// "E-mail não cadastrado. Não foi enviado solicitação de assinatura para o colaborador."
			aAdd(aLogTAE[2], SRA->RA_FILIAL + " - " + SRA->RA_MAT + ": " + STR0108 ) 
			
			If Empty(aLogTitle[1])
				aLogTitle[2] := STR0107 // "Espelhos de Ponto não enviados: "
			EndIf
			LOOP
		EndIf
		
		If lTAE .And. !lPrinter
			cFile := "PON_" + SRA->RA_FILIAL + SRA->RA_MAT + "_" + AnoMes(dMarcIni)
			SetUpPrint(@oPrinter, lTerminal, lMeuRH, cFile)
			lPrinter := .T.
		EndIf
		
	    //Imprime o Espelho para um Funcionario.
		For nCount := 1 To nCopias
			If !lTerminal .Or. lMeuRH
				oPrinter:StartPage()
				If lCodeBar .Or. lTAE
					cCodeBar := cEmpAnt + SRA->RA_FILIAL + PADL(alltrim(SRA->RA_MAT),nTamRAMAT,"0") + DtoS(dPerIni) + DtoS(dPerFim) + DtoS(dDataBase) + StrTran(Time(),":","")
				EndIf
				fImpFun( aImp , nColunas, ,oPrinter )
				If lCodeBar .And. !lTAE //Grava o código de barras gerado na tabela RS4
					GravaSR4()
				EndIf
				oPrinter:EndPage()
			Else
				If lPortal
					aRetPortal  := aClone(aImp)
				Else
					cHtml := fImpFun( aImp , nColunas , lTerminal )
				EndIf
			EndIf		    
		Next nCount
		
	    //Reinicializa Variaveis
		aImp      := {}
		aTotais   := {}
		aAbonados := {}
		
	Next nX
	
	// Integração TAE
	If lTAE .And. lPrinter
		cPathFile := oPrinter:cPathPDF + cFile + ".pdf"
		
		oPrinter:lInJob := .T.
		oPrinter:Preview()
		FreeObj(oPrinter)
		oPrinter := Nil
		
		// Faz upload do documento para o TAE
		SendEsp(cPathFile, cFile + ".pdf")
		
		// Exclui o arquivo
		If File(cPathFile)
			fErase(cPathFile)
		EndIf		
		
	EndIf
	
    (cAliasSRA)->( dbSkip() )
	
EndDo

If lMeuRH
	cFilePrint := cFileName + ".pdf"	
	oPrinter:cPathPDF:= cLocal 
	oPrinter:lViewPDF := .F.
	oPrinter:Print()					
EndIf

(cAliasSRA)->(DbCloseArea())

Return( cHtml )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FImpFun   ³ Autor ³ J.Ricardo             ³ Data ³ 09/04/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o espelho do ponto do funcionario                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ POR010IMP                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpFun( aImp , nColunas , lTerminal, oPrinter , lMeuRH )

Local cHtml			:= ""    
Local cOcorr		:= ""   
Local cAbHora		:= ""
Local lZebrado		:= .F.
Local nX        	:= 0.00
Local nY        	:= 0.00
Local nColMarc  	:= 0.00
Local nTamLin   	:= 0.00
Local nMin			:= 0.00
Local nLenImp		:= 0.00
Local nLenImpnX		:= 0.00
Local nTamAuxlin	:= 0.00   
Local nSaldoAnt		:= 0.00
Local nSaldoAtu		:= 0.00
Local nCredito		:= 0.00
Local nDebito		:= 0.00   
Local nTotHrVal		:= 0.00
Local nSaldAntVl	:= 0
Local nAbHora		:= 0
Local nPosES		:= 0
Local nValAux		:= 0
Local nValHrV		:= 0
Local nValHrV2		:= 0
Local nContEve		:= 0
Local oBrushC	    := TBrush():New( ,  RGB(228, 228, 228)  )
Local oBrushI	    := TBrush():New( ,  RGB(242, 242, 242)  )
local lBrush		:= .F.
Local nPxTurno		:= 0

//-- Define o tamanho da linha com base no MV_ColMarc.
aEval(aImp, { |x| nColMarc := If(Len(x)-3>nColMarc, Len(x)-3, nColMarc) } )
nColMarc += If(nColMarc%2 == 0, 0, 1)
 
//-- Calcula a Maior das Qtdes de Colunas existentes
nColunas := Max(nColunas, nColMarc)

//-- Define configura‡”es da impress„o
nTamAuxLin	:= 19+(nColunas*6)+50
nTamLin    	:= If(nTamAuxLin <= 80,80,If(nTamAuxLin<=132,132,220))

If lTerminal .And. !lMeuRH
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Inicio da Estrutura do Codigo HTML						   ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	cHtml += HtmlProcId() + CRLF
	cHtml += '<html>'  + CRLF
	cHtml += 	'<head>'  + CRLF
	cHtml += 		'<title>RH Online</title>'  + CRLF
	cHtml +=		'<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">'  + CRLF
	cHtml +=		'<link rel="stylesheet" href="css/rhonline.css" type="text/css">'  + CRLF
	cHtml +=	'</head>'  + CRLF
	cHtml +=	'<body bgcolor="#FFFFFF" text="#000000">' + CRLF
	cHtml +=		'<table width="515" border="0" cellspacing="0" cellpadding="0">'  + CRLF
  	cHtml +=			'<tr>'  + CRLF
    cHtml +=				'<td class="titulo">'  + CRLF
    cHtml +=					'<p>' + CRLF
    cHtml +=						'<img src="'+TcfRetDirImg()+'/icone_titulo.gif" width="7" height="9">' + CRLF
    cHtml +=							'<span class="titulo_opcao">' + CRLF
    cHtml +=								STR0040 + CRLF	//'Consultar Marca&ccedil;&otilde;es'
    cHtml +=							'</span>' + CRLF
    cHtml +=							'<br><br>' + CRLF
	cHtml +=					'</p>' + CRLF
	cHtml +=				'</td>' + CRLF
  	cHtml +=			'</tr>' + CRLF
  	cHtml +=			'<tr>' + CRLF
    cHtml +=				'<td>' + CRLF
    cHtml +=					'<table width="515" border="0" cellspacing="0" cellpadding="0">' + CRLF
    cHtml +=						'<tr>' + CRLF
    cHtml +=							'<td background="'+TcfRetDirImg()+'/tabela_conteudo_1.gif" width="10">&nbsp;</td>' + CRLF
    cHtml +=							'<td class="titulo" width="498">' + CRLF
    cHtml +=								'<table width="498" border="0" cellspacing="2" cellpadding="1">' + CRLF
	cHtml += Imp_Cabec( nTamLin , nColunas , lTerminal )
Else
	//-- Imprime Cabecalho Especifico.
	Imp_Cabec( nTamLin , nColunas ,  lTerminal, 1, oPrinter )
EndIf

//-- Imprime Marcações
nLenImp := Len(aImp)
For nX := 1 To nLenImp
	If !lTerminal .And. !lMeuRH
		nLin += 12
		
		If nLin > nLinTot - 40
			fImpSign(oPrinter)
			oPrinter:EndPage()
			oPrinter:StartPage()
			Imp_Cabec( nTamLin , nColunas ,  lTerminal, 1, oPrinter )
		EndIf
	
		oPrinter:Box( nLin, nCol	, nLin+13, nColTot, "-6" )			// Caixa da linha total
		
		If lBigLine .and. nX%2 == 0 //Pinta somente as linhas pares
			oPrinter:Fillrect( {nLin+1, nCol+1, nLin+12, nColTot-1 }, oBrushI, "-2") // Quadro na Cor Cinza
		EndIf
		
		oPrinter:Line( nLin, nPxData	, nLin+13, nPxData	, 0 , "-6") 	// Linha Pos Data

		oPrinter:SayAlign(nLin,nCol+2,DtoC(aImp[nX,1]),oFontM,500,100,,ALIGN_H_LEFT)
		oPrinter:SayAlign(nLin,nPxData+2,DiaSemana(aImp[nX,1],8),oFontM,nPxSemana-nPxData,100,,ALIGN_H_LEFT)
		
		nMin := Len(aImp[nX])
				
		If Len(aImp[nX]) >= 4 .or. !lImpMarc
		
			For nPosES := 1 to Len(aNaES)
				oPrinter:Line( nLin, aNaES[nPosES]-6, nLin+13, aNaES[nPosES]-6, 0 , "-6")	
				nY := nPosES + 3
				If lImpMarc .and. nY <= nMin
					oPrinter:SayAlign(nLin,aNaES[nPosES]+2,aImp[nX,nY],oFontM,500,100,,ALIGN_H_LEFT)
				EndIf
			Next nPosES
		Else
			oPrinter:Line( nLin, aNaES[1]-6, nLin+13, aNaES[1]-6, 0 , "-6")
			oPrinter:SayAlign(nLin,aNaES[1],aImp[nX,2],oFontM,Len(aNaES)*40,100,,ALIGN_H_CENTER)
		EndIf
		
		oPrinter:Line( nLin, nPxAbonos-6, nLin+13	, nPxAbonos-6, 0 , "-6")
		If lImpHrVal
			oPrinter:Line( nLin, nPxHrVal-6	, nLin+13	, nPxHrVal-6, 0 , "-6")
		EndIf
		oPrinter:Line( nLin, nPxHE-6	, nLin+13	, nPxHE-6, 0 , "-6")
		oPrinter:Line( nLin, nPxFalta-6	, nLin+13	, nPxFalta-6, 0 , "-6")
		
		If lPort671
			oPrinter:Line( nLin, nPxJor-6, nLin+13, nPxJor-6, 0, "-6")
		EndIf
		
		oPrinter:Line( nLin, nPxAdnNot-6, nLin+13	, nPxAdnNot-6, 0 , "-6")
		oPrinter:Line( nLin, nPxObser	, nLin+13	, nPxObser, 0 , "-6")		
		
		If lImpMarc //Imprime abonos,He,Faltas,adicionais apenas se for para imprimir marcações.
			If ValType(aImp[nX,3]) == "A"
				oPrinter:SayAlign(nLin,nPxAbonos+2,aImp[nX,3,2],oFontM,500,100,,ALIGN_H_LEFT)
				If Len(aImp[nX,3,1]) > 50
					oPrinter:SayAlign(nLin,nPxObser+2,aImp[nX,3,1],oFontO,500,100,,ALIGN_H_LEFT)
				Else	
					oPrinter:SayAlign(nLin,nPxObser+2,aImp[nX,3,1],oFontM,500,100,,ALIGN_H_LEFT)
				EndIf
			Else
				If Len(aImp[nX,3]) > 50
					oPrinter:SayAlign(nLin,nPxObser+2,aImp[nX,3],oFontO,500,100,,ALIGN_H_LEFT)
				Else
					oPrinter:SayAlign(nLin,nPxObser+2,aImp[nX,3],oFontM,500,100,,ALIGN_H_LEFT)
				EndIf
			EndIf
			
			If Len(aResult) > 0
				nValAux := 0
				Aeval(aResult, {|x| If( x[1] == DtoS(aImp[nX,1]) .and. x[2] == "1", nValAux := __TimeSum(nValAux,x[3]),Nil )} )
				If nValAux > 0
					If !( lSexagenal ) // Centesimal
						nValAux := fConvHr(nValAux,'D',,5)
					Endif
					oPrinter:SayAlign(nLin,nPxHE+2,StrTran(StrZero(nValAux,5,2),'.',':'),oFontM,500,100,,ALIGN_H_LEFT)
					nValAux := 0
				EndIf
				//Apenas gero as horas de Absenteismo na ultima linha do Dia.
				If nX == Len(aImp) .Or. aScan(aImp,{|x| x[1] == aImp[nX,1]},nX + 1) == 0
					Aeval(aResult, {|x| If( x[1] == DtoS(aImp[nX,1]) .and. x[2] =="2", nValAux := __TimeSum(nValAux,x[3]),Nil )} )
					If nValAux > 0
						If !( lSexagenal ) // Centesimal
							nValAux := fConvHr(nValAux,'D',,5)
						Endif
						oPrinter:SayAlign(nLin,nPxFalta+2,StrTran(StrZero(nValAux,5,2),'.',':'),oFontM,500,100,,ALIGN_H_LEFT)
						nValAux := 0
					EndIf
					If lImpHrVal
						nValHrV  := 0
						nValHrV2 := 0
						Aeval(aResult, {|x| If( x[1] == DtoS(aImp[nX,1]) .and. x[2] $ "1*3", nValHrV  := __TimeSum(nValHrV,x[4]),Nil )} )
						Aeval(aResult, {|x| If( x[1] == DtoS(aImp[nX,1]) .and. x[2] == "2", nValHrV2 := __TimeSum(nValHrV2,x[4]),Nil )} )
						nValHrV  := __TimeSub(nValHrV,nValHrV2)
					EndIf
					If nValHrV != 0 .Or. nValHrV2 > 0
						If !( lSexagenal ) // Centesimal
							nValHrV := fConvHr(nValHrV, 'D', , 5, .T.)
						Endif
						oPrinter:SayAlign(nLin,nPxHrVal+2,StrTran(StrZero(nValHrV,5,2),'.',':'),oFontM,500,100,,ALIGN_H_LEFT)
						nValHrV := 0
					EndIf
				EndIf
				
				If lPort671
					Aeval(aResult, {|x| If( x[1] == DtoS(aImp[nX,1]) .and. x[2] == "4", nValAux := __TimeSum(nValAux, x[3]), Nil)})
					If nValAux > 0
						If !( lSexagenal ) // Centesimal
							nValAux := fConvHr(nValAux,'D',,5)
						Endif
						oPrinter:SayAlign(nLin, nPxJor+2, StrTran(StrZero(nValAux, 5, 2),'.',':'), oFontM, 500, 100,, ALIGN_H_LEFT)
						nValAux := 0
					EndIf
				EndIf
				
				Aeval(aResult, {|x| If( x[1] == DtoS(aImp[nX,1]) .and. x[2] == "3", nValAux := __TimeSum(nValAux,x[3]),Nil )} )
				If nValAux > 0
					If !( lSexagenal ) // Centesimal
						nValAux := fConvHr(nValAux,'D',,5)
					Endif
					oPrinter:SayAlign(nLin,nPxAdnNot+2,StrTran(StrZero(nValAux,5,2),'.',':'),oFontM,500,100,,ALIGN_H_LEFT)
					nValAux := 0
				EndIf
			EndIf
		EndIf							                                                                   
	Else
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Detalhes do Codigo HTML          							   ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		IF ( lZebrado := ( nX%2 == 0.00 ) )
			cHtml += '<tr bgcolor="#FAFBFC">' + CRLF
			cHtml += 	'<td class="dados_2" bgcolor="#FAFBFC" nowrap><div align="center">' + CRLF
			cHtml += 		Dtoc(aImp[nX,1]) + CRLF
			cHtml += 	'</td>' + CRLF
			cHtml += 	'<td class="dados_2" bgcolor="#FAFBFC" nowrap><div align="left">' + CRLF
			cHtml +=		DiaSemana(aImp[nX,1]) + CRLF
			cHtml += 	'</td>' + CRLF
		Else
			cHtml += '<tr>' + CRLF
			cHtml += 	'<td class="dados_2" nowrap><div align="center">' + CRLF
			cHtml += 		Dtoc(aImp[nX,1]) + CRLF
			cHtml += 	'</td>' + CRLF
			cHtml += 	'<td class="dados_2" nowrap><div align="left">' + CRLF
			cHtml +=		DiaSemana(aImp[nX,1]) + CRLF
			cHtml += 	'</td>' + CRLF
		EndIF
		If ( nLenImpnX := Len(aImp[nX]) ) < ( ( nColunas + nLenImpnX ) - 1 )
			For nY := Len(aImp[nX]) To ( ( nColunas + 3 ) - 1 )
				aAdd(aImp[nX] , Space(05) )
			Next nY
		EndIf
		nLenImpnX := Len(aImp[nX])
		For nY := 4 To nLenImpnX
			IF ( lZebrado )
				cHtml += 	'<td class="dados_2" bgcolor="#FAFBFC" nowrap><div align="center">' + CRLF
				cHtml += 		aImp[nX,nY] + CRLF
				cHtml += 	'</td>' + CRLF
			Else
				cHtml += 	'<td class="dados_2" nowrap><div align="center">' + CRLF
				cHtml += 		aImp[nX,nY] + CRLF
				cHtml += 	'</td>' + CRLF
			EndIF	
		Next nY
		
		//-- Trata Abonos e Excecoes
		If ValType(aImp[nX,3]) == "A"
			nAbHora:=  At( ":" , aImp[nX,3,2] )
		Else
			nAbHora:=  At( ":" , aImp[nX,3] )
		EndIf
		 
		If nAbHora > 0 
			cOcorr :=	Capital( If (ValType(aImp[nX,3]) == "A",aImp[nX,3,1],SubStr( aImp[nX,3] , 1 , nAbHora - 3 )) ) 
			cAbHora:= 	Capital( If (ValType(aImp[nX,3]) == "A",aImp[nX,3,2],SubStr( aImp[nX,3] , nAbHora - 2 ) ) ) 
		Else                                                                      
			cOcorr :=	Capital( If (ValType(aImp[nX,3]) == "A",aImp[nX,3,1],AllTrim( aImp[nX,3] ) ))
			cAbHora:= 	'&nbsp;'	
		EndIf                                                
		
		If ( lZebrado )
			cHtml += 		'<td class="dados_2" bgcolor="#FAFBFC" nowrap><div align="center">' + CRLF
			cHtml +=			Capital( AllTrim( aImp[nX,2] ) )
			cHtml += 		'</td>' + CRLF
			cHtml += 		'<td class="dados_2" bgcolor="#FAFBFC" nowrap><div align="left">' + CRLF
			cHtml +=	 		cOcorr   						
			cHtml += 		'</td>' + CRLF
			cHtml += 		'<td class="dados_2" bgcolor="#FAFBFC" nowrap><div align="left">' + CRLF
			cHtml +=	 		cAbHora	
			cHtml += 		'</td>' + CRLF
		Else
			cHtml += 		'<td class="dados_2" nowrap><div align="center">' + CRLF
			cHtml +=			Capital( AllTrim( aImp[nX,2] ) )
			cHtml += 		'</td>' + CRLF
			cHtml += 		'<td class="dados_2" nowrap><div align="left">' + CRLF
			cHtml +=	 		cOcorr   						
			cHtml += 		'</td>' + CRLF
			cHtml += 		'<td class="dados_2" nowrap><div align="left">' + CRLF
			cHtml +=			cAbHora
			cHtml += 		'</td>' + CRLF
		EndIf	
	EndIf
Next nX

If !( lTerminal )
	
	nLin += 35	
	
	// Marcações desconsideradas
	If lPort671 .And. lImpMarc .And. !Empty(aMarcDes)
		
		If(nLin > nLinTot - 40, fQuebra(oPrinter, nTamLin, nColunas,  lTerminal), NIL)
		
		oPrinter:SayAlign( nLin, nCol+5, STR0115, oFontT, 500, 150, , ALIGN_H_LEFT ) // "Marcações Desconsideradas"
		nLin += 13
		
		oPrinter:Box( nLin, nCol, nLin+17, nColTot, "-6" ) // Caixa da linha total
		
		If lBigLine
			oPrinter:Fillrect( {nLin+1, nCol+1, nLin+17, nColTot-1 }, oBrushC, "-2") // Quadro na Cor Cinza
		EndIf
		
		oPrinter:SayAlign( nLin+3, nCol+5, STR0042, oFontP, nPxData, 150, , ALIGN_H_LEFT ) //Data
		
		oPrinter:Line( nLin, nCol+94, nLin+17, nCol+94, 0, "-6")
		oPrinter:SayAlign( nLin+3, nCol+100, STR0116, oFontP, 500, 150, , ALIGN_H_LEFT ) //Hora da marcação
		
		oPrinter:Line( nLin, nCol+294, nLin+17, nCol+294, 0, "-6")
		oPrinter:SayAlign( nLin+3, nCol+300, STR0117, oFontP, 500, 150, , ALIGN_H_LEFT ) //Motivo
		
		For nX := 1 To Len(aMarcDes)
			
			If(nLin > nLinTot - 40, fQuebra(oPrinter, nTamLin, nColunas,  lTerminal), NIL)
			
			nLin += 13
			
			oPrinter:Box( nLin, nCol, nLin+13, nColTot, "-6" )			// Caixa da linha total
			
			If lBigLine .and. nX%2 == 0 //Pinta somente as linhas pares
				oPrinter:Fillrect( {nLin+1, nCol+1, nLin+12, nColTot-1 }, oBrushI, "-2") // Quadro na Cor Cinza
			EndIf
			
			oPrinter:SayAlign( nLin, nCol+5, dToC(aMarcDes[nX][1]), oFontP, nPxData, 150, , ALIGN_H_LEFT ) //Data
			
			oPrinter:Line( nLin, nCol+94, nLin+13, nCol+94, 0, "-6")
			oPrinter:SayAlign( nLin+3, nCol+100, aMarcDes[nX][2], oFontP, 500, 150, , ALIGN_H_LEFT ) //Hora da marcação
			
			oPrinter:Line( nLin, nCol+294, nLin+13, nCol+294, 0, "-6")
			oPrinter:SayAlign( nLin+3, nCol+300, aMarcDes[nX][3], oFontP, 500, 150, , ALIGN_H_LEFT ) //Motivo
			
		Next nX
		
		nLin += 35
	EndIf
	
	If lImpBH
		If Pnr010ImpBh(@nSaldoAnt, @nSaldoAtu, @nCredito, @nDebito, @nTotHrVal, @nSaldAntVl)
			
			If nLin > nLinTot - 40
				fImpSign(oPrinter)
				oPrinter:EndPage()
				oPrinter:StartPage()
				Imp_Cabec( nTamLin, nColunas,  lTerminal, 0, oPrinter )
				nLin += 13
			EndIf
			
			If lImpHrVal
				nTamCol	 := (nColTot - nCol) / 7
				nColCod1 := nCol + nTamCol
				nColCod2 := nColCod1 + nTamCol * 1.5
				nColCod3 := nColCod2 + nTamCol
				nColCod4 := nColCod3 + nTamCol
				nColCod5 := nColCod4 + nTamCol

				oPrinter:SayAlign( nLin, nCol, STR0081, oFontP, 500, 150, , ALIGN_H_LEFT )	//Banco de Horas

				nLin += 13

				oPrinter:Box( nLin, nCol, nLin + 17, nColTot, "-6" )	// Caixa com os valores do banco de horas

				If lBigLine
					oPrinter:Fillrect( {nLin+1, nCol+1, nLin+13, nColTot-1 }, oBrushC, "-2")	// Quadro na Cor Cinza
				EndIf

				oPrinter:Line( nLin, nColCod1, nLin+13, nColCod1, 0 , "-6")		// Inclusão de um "|" para separar as colunas
				oPrinter:Line( nLin, nColCod2, nLin+13, nColCod2, 0 , "-6")		// Inclusão de um "|" para separar as colunas
				oPrinter:Line( nLin, nColCod3, nLin+13, nColCod3, 0 , "-6")		// Inclusão de um "|" para separar as colunas
				oPrinter:Line( nLin, nColCod4, nLin+13, nColCod4, 0 , "-6")		// Inclusão de um "|" para separar as colunas
				oPrinter:Line( nLin, nColCod5, nLin+13, nColCod5, 0 , "-6")		// Inclusão de um "|" para separar as colunas

				oPrinter:SayAlign(nLin, nCol + 2, STR0082, oFontP, 500, 100,, ALIGN_H_LEFT)		//Saldo Anterior
				oPrinter:SayAlign(nLin, nColCod1 + 2, STR0124, oFontP, 500, 100,, ALIGN_H_LEFT)	//Saldo Anterior Valorizado
				oPrinter:SayAlign(nLin, nColCod2 + 2, STR0083, oFontP, 500, 100,, ALIGN_H_LEFT)	//Débito
				oPrinter:SayAlign(nLin, nColCod3 + 2, STR0084, oFontP, 500, 100,, ALIGN_H_LEFT)	//Crédito
				oPrinter:SayAlign(nLin, nColCod4 + 2, STR0085, oFontP, 500, 100,, ALIGN_H_LEFT)	//Saldo Atual
				oPrinter:SayAlign(nLin, nColCod5 + 2, STR0125, oFontP, 500, 100,, ALIGN_H_LEFT)	//Saldo Atual Valorizado
			
				nLin += 12
				
				oPrinter:Box( nLin, nCol, nLin+13, nColTot, "-6" )
				
				oPrinter:Line( nLin, nColCod1, nLin + 13, nColCod1, 0, "-6")
				oPrinter:Line( nLin, nColCod2, nLin + 13, nColCod2, 0, "-6")
				oPrinter:Line( nLin, nColCod3, nLin + 13, nColCod3, 0, "-6")
				oPrinter:Line( nLin, nColCod4, nLin + 13, nColCod4, 0, "-6")

				oPrinter:Line( nLin, nColCod5, nLin + 13, nColCod5, 0, "-6")
				oPrinter:SayAlign(nLin, nCol + 2 + 2, Transform(nSaldoAnt, '@E 99,999.99'), oFontM, 500, 100,, ALIGN_H_LEFT)	//Saldo Anterior
				oPrinter:SayAlign(nLin, nColCod1 + 2, Transform(nSaldAntVl, '@E 99,999.99'), oFontM, 500, 100,, ALIGN_H_LEFT)	//Saldo Anterior Valorizado
				oPrinter:SayAlign(nLin, nColCod2 + 2, Transform(nDebito, '@E 99,999.99'), oFontM, 500, 100,, ALIGN_H_LEFT)		//Débito
				oPrinter:SayAlign(nLin, nColCod3 + 2, Transform(nCredito, '@E 99,999.99'), oFontM, 500, 100,, ALIGN_H_LEFT)		//Crédito
				oPrinter:SayAlign(nLin, nColCod4 + 2, Transform(nSaldoAtu, '@E 99,999.99'), oFontM, 500, 100,, ALIGN_H_LEFT)	//Saldo Atual
				oPrinter:SayAlign(nLin, nColCod5 + 2, Transform(nTotHrVal, '@E 99,999.99'), oFontM, 500, 100,, ALIGN_H_LEFT)	//Saldo Atual Valorizado
			Else
				oPrinter:Box( nLin, nCol, nLin + 17, nColTot, "-6" )		// Caixa da linha total
				nTamCol	 := (nColTot - nCol) / 6
				nColCod1 := nCol + nTamCol * 2
				nColCod2 := nColCod1 + nTamCol
				nColCod3 := nColCod2 + nTamCol
				nColCod4 := nColCod3 + nTamCol
				
				If lBigLine
					oPrinter:Fillrect( {nLin+1, nCol+1, nLin+13, nColTot-1 }, oBrushC, "-2") // Quadro na Cor Cinza
				EndIf

				oPrinter:Line( nLin, nColCod1, nLin+13, nColCod1, 0 , "-6")		// Inclusão de um "|" para separar as colunas
				oPrinter:Line( nLin, nColCod2, nLin+13, nColCod2, 0 , "-6")		// Inclusão de um "|" para separar as colunas
				oPrinter:Line( nLin, nColCod3, nLin+13, nColCod3, 0 , "-6")		// Inclusão de um "|" para separar as colunas
				oPrinter:Line( nLin, nColCod4, nLin+13, nColCod4, 0 , "-6")		// Inclusão de um "|" para separar as colunas

				oPrinter:SayAlign(nLin, nCol + 2, STR0081, oFontP, 500, 100,, ALIGN_H_LEFT)		//Banco de Horas
				oPrinter:SayAlign(nLin, nColCod1 + 2, STR0082, oFontP, 500, 100,, ALIGN_H_LEFT)	//Saldo Anterior
				oPrinter:SayAlign(nLin, nColCod2 + 2, STR0083, oFontP, 500, 100,, ALIGN_H_LEFT)	//Débito
				oPrinter:SayAlign(nLin, nColCod3 + 2, STR0084, oFontP, 500, 100,, ALIGN_H_LEFT)	//Crédito
				oPrinter:SayAlign(nLin, nColCod4 + 2, STR0085, oFontP, 500, 100,, ALIGN_H_LEFT)	//Saldo Atual
			
				nLin += 12
				
				oPrinter:Box( nLin, nCol, nLin+13, nColTot, "-6" )
				
				oPrinter:Line( nLin, nColCod1, nLin + 13, nColCod1, 0, "-6")
				oPrinter:Line( nLin, nColCod2, nLin + 13, nColCod2, 0, "-6")
				oPrinter:Line( nLin, nColCod3, nLin + 13, nColCod3, 0, "-6")
				oPrinter:Line( nLin, nColCod4, nLin + 13, nColCod4, 0, "-6")

				oPrinter:SayAlign(nLin, nColCod1 + 2, Transform(nSaldoAnt, '@E 99,999.99'), oFontM, 500, 100,, ALIGN_H_LEFT)	//Saldo Anterior
				oPrinter:SayAlign(nLin, nColCod2 + 2, Transform(nDebito, '@E 99,999.99'), oFontM, 500, 100,, ALIGN_H_LEFT)		//Débito
				oPrinter:SayAlign(nLin, nColCod3 + 2, Transform(nCredito, '@E 99,999.99'), oFontM, 500, 100,, ALIGN_H_LEFT)		//Crédito
				oPrinter:SayAlign(nLin, nColCod4 + 2, Transform(nSaldoAtu, '@E 99,999.99'), oFontM, 500, 100,, ALIGN_H_LEFT)	//Saldo Atual
			EndIf
			
			nLin += 25									
		EndIf
	EndIf	
	
	If lPort671 .And. lImpTroca
		
		aHorarios := GetHorarios()
		
		If nLin > nLinTot - 40
			fImpSign(oPrinter)
			oPrinter:EndPage()
			oPrinter:StartPage()
			Imp_Cabec( nTamLin, nColunas,  lTerminal, 0, oPrinter )
		EndIf
		
		oPrinter:SayAlign( nLin, nCol+5, STR0111, oFontT, 500, 150, , ALIGN_H_LEFT ) //Horários
		nLin += 13
		
		oPrinter:Box( nLin, nCol, nLin+17, nColTot, "-6" ) // Caixa da linha total
		
		If lBigLine
			oPrinter:Fillrect( {nLin+1, nCol+1, nLin+17, nColTot-1 }, oBrushC, "-2") // Quadro na Cor Cinza
		EndIf
		
		oPrinter:SayAlign( nLin+3, nCol+5, STR0042, oFontP, nPxData, 150, , ALIGN_H_LEFT ) //Data
		
		nESAux := 1
		For nX := 1 to Len(aNaES)
			oPrinter:Line( nLin, aNaES[nX]-6, nLin+17, aNaES[nX]-6, 0, "-6")
			If nX%2 == 0
				oPrinter:SayAlign( nLin+3, aNaES[nX], AllTrim(Str(nESAux)) + STR0036, oFontP, aNaES[nX]+40, 150 , , ALIGN_H_LEFT ) //Saida
				nESAux++
			Else
				oPrinter:SayAlign( nLin+3, aNaES[nX], AllTrim(Str(nESAux)) + STR0035, oFontP, aNaES[nX]+40, 150 , , ALIGN_H_LEFT ) //Entrada
			EndIf
		Next nX
		
		nPxTurno := aNaES[Len(aNaES)] + 40
		oPrinter:Line( nLin, nPxTurno-6, nLin+17, nPxTurno-6, 0 , "-6")
		oPrinter:SayAlign( nLin+3, nPxTurno, STR0007, oFontP, 500, 150 , , ALIGN_H_LEFT ) // Turno
		
		//Imprime as informações
		For nX := 1 To Len(aHorarios)
			
			If nLin > nLinTot - 40
				fImpSign(oPrinter)
				oPrinter:EndPage()
				oPrinter:StartPage()
				Imp_Cabec( nTamLin, nColunas,  lTerminal, 0, oPrinter )
			EndIf
			
			nLin += 13
			
			oPrinter:Box( nLin, nCol, nLin+13, nColTot, "-6" )			// Caixa da linha total
			
			If lBigLine .and. nX%2 == 0 //Pinta somente as linhas pares
				oPrinter:Fillrect( {nLin+1, nCol+1, nLin+12, nColTot-1 }, oBrushI, "-2") // Quadro na Cor Cinza
			EndIf
			
			oPrinter:SayAlign( nLin, nCol+5, dToC(aHorarios[nX][1]), oFontP, nPxData, 150, , ALIGN_H_LEFT ) //Data
			
			aEval(aNaES, {|X| oPrinter:Line( nLin, X-6, nLin+13, X-6, 0, "-6") })
			
			oPrinter:Line( nLin, nPxTurno-6, nLin+13, nPxTurno-6, 0 , "-6")
			oPrinter:SayAlign( nLin+3, nPxTurno, aHorarios[nX][2], oFontP, 500, 150 , , ALIGN_H_LEFT ) // Turno
			
			For nPosES := 1 To Len(aHorarios[nX][3])
				If nPosES <= Len(aNaES)
					oPrinter:SayAlign(nLin+3, aNaES[nPosES]+2, StrTran( StrZero(aHorarios[nX][3][nPosES], 5,2),".", ":"), oFontM, 500, 100,, ALIGN_H_LEFT)
				Else
					EXIT
				EndIf
			Next nPosES
		Next nX
		
		nLin += 25
		
	EndIf
	
	//-- Se existirem totais, e se for selecionada sua impress„o, ser„o impressos.
	If lImpMarc .and. Len(aTotais) > 0 .and. nImpHrs # 4
		If nLin > nLinTot - 40
			fImpSign(oPrinter)
			oPrinter:EndPage()
			oPrinter:StartPage()
			Imp_Cabec( nTamLin , nColunas ,  lTerminal, 0, oPrinter )
			nLin+=20
		EndIf
		
		oPrinter:Box( nLin, nCol , nLin+13, nColTot, "-6" )			// Caixa da linha total
		
		nTamCol	 := (nColTot - nCol) / 21
		nColCod1 := nCol + nTamCol
		nColDesc1:= nColCod1 + (nTamCol*4)
		nColCalc1:= nColDesc1 + nTamCol
		nColInf1 := nColCalc1 + nTamCol
		nColCod2 := nColInf1 + nTamCol
		nColDesc2:= nColCod2 + (nTamCol*4)
		nColCalc2:= nColDesc2 + nTamCol
		nColInf2 := nColCalc2 + nTamCol
		nColCod3 := nColInf2 + nTamCol
		nColDesc3:= nColCod3 + (nTamCol*4)
		nColCalc3:= nColDesc3 + nTamCol
		
		If lBigLine
			oPrinter:Fillrect( {nLin+1, nCol+1, nLin+13, nColTot-1 }, oBrushC, "-2") // Quadro na Cor Cinza
		EndIf		 
		
		oPrinter:Line( nLin, nColCod1	, nLin+13, nColCod1		, 0 , "-6")
		If nImpHrs == 1 .or. nImpHrs == 3
			oPrinter:Line( nLin, nColDesc1	, nLin+13, nColDesc1	, 0 , "-6")
		EndIf
		oPrinter:Line( nLin, nColCalc1	, nLin+13, nColCalc1	, 0 , "-6")
		oPrinter:Line( nLin, nColInf1	, nLin+13, nColInf1		, 0 , "-6")
		oPrinter:Line( nLin, nColCod2	, nLin+13, nColCod2		, 0 , "-6")
		If nImpHrs == 1 .or. nImpHrs == 3
			oPrinter:Line( nLin, nColDesc2	, nLin+13, nColDesc2	, 0 , "-6")
		EndIf
		oPrinter:Line( nLin, nColCalc2	, nLin+13, nColCalc2	, 0 , "-6")
		oPrinter:Line( nLin, nColInf2	, nLin+13, nColInf2		, 0 , "-6")
		oPrinter:Line( nLin, nColCod3	, nLin+13, nColCod3		, 0 , "-6")
		If nImpHrs == 1 .or. nImpHrs == 3
			oPrinter:Line( nLin, nColDesc3	, nLin+13, nColDesc3	, 0 , "-6")
		EndIf
		oPrinter:Line( nLin, nColCalc3	, nLin+13, nColCalc3	, 0 , "-6")

		oPrinter:SayAlign(nLin,nCol+2,STR0064,oFontP,500,100,,ALIGN_H_LEFT)				//Codigo
		oPrinter:SayAlign(nLin,nColCod1+2,STR0065,oFontP,500,100,,ALIGN_H_LEFT)			//Descrição
		
		If nImpHrs == 1 .or. nImpHrs == 3
			oPrinter:SayAlign(nLin,nColDesc1+2,STR0066,oFontP,500,100,,ALIGN_H_LEFT)	//Calculado
		EndIf
		
		oPrinter:SayAlign(nLin,nColCalc1+2,STR0067,oFontP,500,100,,ALIGN_H_LEFT)		//Informado
		
		oPrinter:SayAlign(nLin,nColInf1+2,STR0064,oFontP,500,100,,ALIGN_H_LEFT)			//Codigo
		oPrinter:SayAlign(nLin,nColCod2+2,STR0065,oFontP,500,100,,ALIGN_H_LEFT)			//Descrição
		
		If nImpHrs == 1 .or. nImpHrs == 3		
			oPrinter:SayAlign(nLin,nColDesc2+2,STR0066,oFontP,500,100,,ALIGN_H_LEFT)	//Calculado
		EndIf
		oPrinter:SayAlign(nLin,nColCalc2+2,STR0067,oFontP,500,100,,ALIGN_H_LEFT)		//Informado
		
		oPrinter:SayAlign(nLin,nColInf2+2,STR0064,oFontP,500,100,,ALIGN_H_LEFT)			//Codigo
		oPrinter:SayAlign(nLin,nColCod3+2,STR0065,oFontP,500,100,,ALIGN_H_LEFT)			//Descrição
		
		If nImpHrs == 1 .or. nImpHrs == 3		
			oPrinter:SayAlign(nLin,nColDesc3+2,STR0066,oFontP,500,100,,ALIGN_H_LEFT)	//Calculado
		EndIf
		oPrinter:SayAlign(nLin,nColCalc3+2,STR0067,oFontP,500,100,,ALIGN_H_LEFT)		
		
		nMetade := nLin
		nContEve:= 1
		For nX := 1 To Len(aTotais)
			If nContEve == 1
				nMetade+=12
				If nMetade > nLinTot - 40
					fImpSign(oPrinter)
					oPrinter:EndPage()
					oPrinter:StartPage()
					Imp_Cabec( nTamLin , nColunas ,  lTerminal, 2, oPrinter )
					nLin+=12
					nMetade := nLin
				EndIf
				oPrinter:Box(  nMetade, nCol	, nMetade+13, nColTot	, "-6" )
				If lBigLine .and. lBrush
					oPrinter:Fillrect( {nMetade+1, nCol+1, nMetade+12, nColTot-1 }, oBrushI, "-2") // Quadro na Cor Cinza
					lBrush := .F.
				Else
					lBrush := .T.
				EndIf				
				oPrinter:Line( nMetade, nColCod1	, nMetade+13, nColCod1	, 0 , "-6")
				oPrinter:Line( nMetade, nColDesc1	, nMetade+13, nColDesc1	, 0 , "-6")
				oPrinter:Line( nMetade, nColCalc1	, nMetade+13, nColCalc1	, 0 , "-6")
				oPrinter:Line( nMetade, nColInf1	, nMetade+13, nColInf1	, 0 , "-6")
				oPrinter:Line( nMetade, nColCod2	, nMetade+13, nColCod2	, 0 , "-6")
				oPrinter:Line( nMetade, nColDesc2	, nMetade+13, nColDesc2	, 0 , "-6")
				oPrinter:Line( nMetade, nColCalc2	, nMetade+13, nColCalc2	, 0 , "-6")
				oPrinter:Line( nMetade, nColInf2	, nMetade+13, nColInf2	, 0 , "-6")
				oPrinter:Line( nMetade, nColCod3	, nMetade+13, nColCod3	, 0 , "-6")
				oPrinter:Line( nMetade, nColDesc3	, nMetade+13, nColDesc3	, 0 , "-6")
				oPrinter:Line( nMetade, nColCalc3	, nMetade+13, nColCalc3	, 0 , "-6")
				
				oPrinter:SayAlign(nMetade,nCol+2,aTotais[nX,1],oFontM,500,100,,ALIGN_H_LEFT)
				oPrinter:SayAlign(nMetade,nColCod1+2,aTotais[nX,2],oFontM,500,100,,ALIGN_H_LEFT)
				oPrinter:SayAlign(nMetade,nColDesc1,aTotais[nX,3],oFontM,500,100,,ALIGN_H_LEFT)
				oPrinter:SayAlign(nMetade,nColCalc1,aTotais[nX,4],oFontM,500,100,,ALIGN_H_LEFT)
				nContEve++
			ElseIf nContEve == 2
				oPrinter:SayAlign(nMetade,nColInf1+2,aTotais[nX,1],oFontM,500,100,,ALIGN_H_LEFT)
				oPrinter:SayAlign(nMetade,nColCod2+2,aTotais[nX,2],oFontM,500,100,,ALIGN_H_LEFT)
				oPrinter:SayAlign(nMetade,nColDesc2,aTotais[nX,3],oFontM,500,100,,ALIGN_H_LEFT)
				oPrinter:SayAlign(nMetade,nColCalc2,aTotais[nX,4],oFontM,500,100,,ALIGN_H_LEFT)
				nContEve++
			ElseIf nContEve == 3
				oPrinter:SayAlign(nMetade,nColInf2+2,aTotais[nX,1],oFontM,500,100,,ALIGN_H_LEFT)
				oPrinter:SayAlign(nMetade,nColCod3+2,aTotais[nX,2],oFontM,500,100,,ALIGN_H_LEFT)
				oPrinter:SayAlign(nMetade,nColDesc3,aTotais[nX,3],oFontM,500,100,,ALIGN_H_LEFT)
				oPrinter:SayAlign(nMetade,nColCalc3,aTotais[nX,4],oFontM,500,100,,ALIGN_H_LEFT)			
				nContEve++
			EndIf
			If nContEve > 3
				nContEve := 1
			EndIf
			nLin := nMetade
		Next nX
	EndIf
	
	fImpSign(oPrinter)
Else
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Final da Estrutura do Codigo HTML							   ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
    cHtml +=									'<tr>' + CRLF
    cHtml +=										'<td colspan="' + AllTrim( Str( nColunas + 5 ) ) + '" class="etiquetas_1" bgcolor="#FAFBFC"><hr size="1"></td>' + CRLF 
    cHtml +=									'</tr>' + CRLF
	cHtml +=								'</table>' + CRLF
	cHtml +=							'</td>' + CRLF
    cHtml +=							'<td background="'+TcfRetDirImg()+'/tabela_conteudo_2.gif" width="7">&nbsp;</td>' + CRLF
    cHtml +=						'</tr>' + CRLF
    cHtml +=					'</table>' + CRLF
    cHtml +=				'</td>' + CRLF
  	cHtml +=			'</tr>' + CRLF
	cHtml +=		'</table>' + CRLF
	cHtml +=		'<p align="right"><a href="javascript:self.print()"><img src="'+TcfRetDirImg()+'/imprimir.gif" width="90" height="28" hspace="20" border="0"></a></p>' + CRLF
	cHtml +=	'</body>' + CRLF
	cHtml += '</html>' + CRLF
EndIf
	
Return( cHtml )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FMontaaIMP³ aUTOR ³ EQUIPE DE RH          ³ dATA ³ 09/04/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Monta o Vetor aImp , utilizado na impressao do espelho     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ POR010IMP                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FMontaAimp(aTabCalend, aMarcacoes, aImp,dInicio,dFim, lTerminal, lImpAcum, lMeuRH)

Local aDescAbono := {}
Local cTipAfas   := ""
Local cDescAfas  := ""
Local cOcorr     := ""
Local cOrdem     := ""
Local cTipDia    := ""
Local lIsento	 := .F.
Local dData      := Ctod("//")
Local dDtBase    := dFim
Local lRet       := .T.
Local lFeriado   := .T.
Local lTrabaFer  := .F.
Local lAfasta    := .T.   
Local nX         := 0
Local nDia       := 0
Local nMarc      := 0
Local nLenMarc	 := Len( aMarcacoes )
Local nLenDescAb := Len( aDescAbono )
Local nTab       := 0
Local nContMarc  := 0
Local nDias		 := 0
Local cOriMarc	 := ""
Local cMotExce	 := ""

//-- Variaveis ja inicializadas.
aImp := {}

nDias := ( dDtBase - dInicio )
For nDia := 0 To nDias
	
	//-- Reinicializa Variaveis.
	dData      := dInicio + nDia
	aDescAbono := {}
	cOcorr     := ""
	cTipAfas   := ""
	cDescAfas  := ""
	cOcorr	   := ""
	
	If !lImpMarc	
		//-- Adiciona Nova Data a ser impressa.
		aAdd(aImp,{})
		aAdd(aImp[Len(aImp)], dData)
		aAdd(aImp[Len(aImp)], Space(1))
		nContMarc++
		Loop 
	EndIf	
	
	//-- o Array aTabcalend ‚ setado para a 1a Entrada do dia em questão.
	If ( nTab := aScan(aTabCalend, {|x| x[48] == dData .and. x[4] == '1E'}) ) == 0.00
		Loop
	EndIf
	
	//-- o Array aMarcacoes ‚ setado para a 1a Marcação do dia em questão.
	nMarc := aScan(aMarcacoes, { |x| x[3] == aTabCalend[nTab, 2] })
	
	//-- Consiste Afastamentos, Demissoes ou Transferencias.
	If ( ( lAfasta := aTabCalend[ nTab , 24 ] ) .or. SRA->( RA_SITFOLH $ 'DúT' .and. dData > RA_DEMISSA ) )
		lAfasta		:= .T.
		cTipAfas	:= IF(!Empty(aTabCalend[ nTab , 25 ]),aTabCalend[ nTab , 25 ],fDemissao(SRA->RA_SITFOLH, SRA->RA_RESCRAI) )
		cDescAfas	:= Alltrim(fDescAfast( cTipAfas, TamSx3("RCM_DESCRI")[1], Nil, SRA->( RA_SITFOLH == 'D' .and. dData > RA_DEMISSA ), aTabCalend[ nTab , 47 ], SRA->RA_FILIAL ))
	EndIf
	
	//Verifica Regra de Apontamento ( Trabalha Feriado ? )
	lTrabaFer := ( PosSPA( aTabCalend[ nTab , 23 ] , cFilSPA , "PA_FERIADO" , 01 ) == "S" )
	
	//-- Consiste Feriados.
	If ( lFeriado := aTabCalend[ nTab , 19 ] )  .AND. !lTrabaFer
		cOcorr := aTabCalend[ nTab , 22 ]
	EndIf
	
	//-- Carrega Array aDescAbono com os Abonos ocorridos no Dia
	nLenDescAb := Len(aAbonados)
	For nX := 1 To nLenDescAb
		If aAbonados[nX,1] == dData
			aAdd(aDescAbono, { aAbonados[nX,2] , aAbonados[nX,3] , aAbonados[nX,4] })
		EndIf
	Next nX
	
	//-- Ordem e Tipo do dia em questão.
	cOrdem  := aTabCalend[nTab, CALEND_POS_ORDEM]
	cTipDia := aTabCalend[nTab, CALEND_POS_TIPO_DIA]
	lIsento := aTabCalend[nTab, CALEND_POS_ISENTMARC]
	
    //-- Se a Data da marcacao for Posterior a Admissao
	If dData >= SRA->RA_ADMISSA
		//-- Se Afastado
		If ( lAfasta  .AND. aTabCalend[nTab,10] <> 'E' ) .OR. ( lAfasta  .AND. aTabCalend[nTab,10] == 'E' .AND. ( !lImpExcecao .OR. !aTabCalend[nTab,32] ) )
			cOcorr := cDescAfas 
		//-- Se nao for Afastado
		Else                    
			// Verifica se o funcionário é isento de marcação naquele dia
			If cTipDia == 'S' .And. lIsento
				cOcorr := STR0119 // "Isento de Marcação"
				
		    //-- Se tiver EXCECAO para o Dia  ------------------------------------------------
			ElseIf aTabCalend[nTab,10] == 'E'			
		       //-- Se excecao trabalhada
		       If cTipDia == 'S'  
		          //-- Se nao fez Marcacao
		          If Empty(nMarc)
					 cOcorr := STR0020  // '** Ausente **'
					
					 // Motivo da exceção
					 If !Empty(aTabCalend[nTab,11])
					 	cMotExce := AllTrim(aTabCalend[nTab,11])
					 EndIf
				  	//-- Se fez marcacao	 
		          Else
		          	 //-- Motivo da Marcacao
	          		 If !Empty(aTabCalend[nTab,11])
					 	cOcorr := AllTrim(aTabCalend[nTab,11])
					 Else
					 	cOcorr := STR0018  // '** Excecao nao Trabalhada **'
					 EndIf
		          EndIf	 
		       //-- Se excecao outros dias (DSR/Compensado/Nao Trabalhado)
		       Else
 					//-- Motivo da Marcacao
		       		If !Empty(aTabCalend[nTab,11])
						cOcorr := AllTrim(aTabCalend[nTab,11])
					Else
						cOcorr := STR0018  // '** Excecao nao Trabalhada **'  
					EndIf
			   EndIf	

		    //-- Se nao Tiver Excecao  no Dia ---------------------------------------------------
		    Else    
		        //-- Se feriado 
		       	If lFeriado 
		       	    //-- Se nao trabalha no Feriado
		       	    If !lTrabaFer 
						cOcorr := If(!Empty(cOcorr),cOcorr,STR0019 ) // '** Feriado **' 
					//-- Se trabalha no Feriado
					Else                  
					    //-- Se Dia Trabalhado e Nao fez Marcacao
				    	If cTipDia == 'S' .and. Empty(nMarc)
							cOcorr := STR0020  // '** Ausente **'
				    	ElseIf cTipDia == 'D'
							cOcorr := STR0021  // '** D.S.R. **'  
						ElseIf cTipDia == 'C'
							cOcorr := STR0022  // '** Compensado **'
						ElseIf cTipDia == 'N'
							cOcorr := STR0023  // '** Nao Trabalhado **'
						EndIf
					EndIf
		    	Else                                    
		    	    //-- Se Dia Trabalhado e Nao fez Marcacao
			    	If cTipDia == 'S' .and. Empty(nMarc)
						cOcorr := STR0020  // '** Ausente **'
			    	ElseIf cTipDia == 'D'
						cOcorr := STR0021  // '** D.S.R. **'
					ElseIf cTipDia == 'C'
						cOcorr := STR0022  // '** Compensado **'
					ElseIf cTipDia == 'N'
						cOcorr := STR0023  // '** Nao Trabalhado **'
					EndIf
				
				EndIf	
		    EndIf
		EndIf
	EndIf	    
	
	nLenDescAb := Len(aDescAbono) 
	
	//-- Adiciona Nova Data a ser impressa.
	aAdd(aImp,{})
	aAdd(aImp[Len(aImp)], aTabCalend[nTab,48])

	//-- Ocorrencia na Data.
	If (lTerminal .And. !lMeuRH) 
		aAdd( aImp[Len(aImp)], cOcorr) 
	EndIf	
	
	//-- Abono na Data.
	If ( nLenDescAb  > 0 )
	    If !lTerminal .Or. lMeuRH
	    	If cOcorr == STR0020  // '** Ausente **'
			  	aAdd( aImp[Len(aImp)], cOcorr ) // '** Ausente **'
			Else
				If !empty(cOcorr)
					aAdd( aImp[Len(aImp)],	Space(01)) 
				  	aAdd( aImp[Len(aImp)], cOcorr )
					aAdd( aImp,{})
					aAdd( aImp[Len(aImp)], aTabCalend[nTab,1])
					aAdd( aImp[Len(aImp)],	Space(01) )
				Else                                   
					aAdd( aImp[Len(aImp)],	Space(01)) 
				EndIf	
			EndIf
	    EndIf
		For nX := 1 To nLenDescAb
			If nX == 1
				aAdd( aImp[Len(aImp)], aDescAbono[nX])
			Else
				aAdd(aImp, {})
				aAdd(aImp[Len(aImp)], aTabCalend[nTab,1]		)
				aAdd(aImp[Len(aImp)], Space(01)			 	)
				aAdd(aImp[Len(aImp)], aDescAbono[nX]			)
			EndIf
		Next nX
	Else
		If ( lTerminal .And. !lMeuRH ) 
			aAdd( aImp[Len(aImp)], '' )
		Else
			If cOcorr == STR0020 .Or. (lIsento .And. Empty(nMarc)) // '** Ausente **'
				aAdd( aImp[Len(aImp)], cOcorr) 
				aAdd( aImp[Len(aImp)], If (!Empty(cMotExce), cMotExce, Space(01)))
				cMotExce := ""
			Else
				aAdd( aImp[Len(aImp)], Space(01)) 
				aAdd( aImp[Len(aImp)], cOcorr )
			EndIf	
		EndIf		
	EndIf
	
	//-- Marcacoes ocorridas na data.
	If nMarc > 0
		While nMarc <= nLenMarc .and. cOrdem == aMarcacoes[nMarc,3]						
			nContMarc ++
			cOriMarc := ""
			If lPort671
				cOriMarc := " " + aMarcacoes[nMarc, 28]
			ElseIf aMarcacoes[nMarc, 28] != "O"
				cOriMarc := " *"
			EndIf
			
			aAdd( aImp[Len(aImp)], StrTran(StrZero(aMarcacoes[nMarc,2],5,2),'.',':') + cOriMarc ) //Se nao for original, inclui asterisco na frente da marcacao
			nMarc ++
		EndDo
	EndIf
	
Next nDia

If lImpMarc .And. (!lTerminal .Or. lMeuRH) //Carrega o array aResult para exibicao das HE, faltas e adc. noturno.
	aResult := {}
	fGetApo(@aResult, dInicio, dFim, lImpAcum, aTabCalend, aMarcacoes)
EndIf

lRet := If(nContMarc>=1,.T.,.F.)

Return( lRet )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Imp_Cabec ³ Autor ³ EQUIPE DE RH          ³ Data ³ 09/04/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o cabecalho do espelho do ponto                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ POR010IMP                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function Imp_Cabec(nTamLin ,nColunas, lTerminal, nTipoCab, oPrinter )

Local cDet			:= ""
Local cHtml			:= ""
Local lImpTurnos	:=.F.
Local nVezes		:= ( nColunas / 2 )
Local nQtdeTurno	:= 0.00
Local nX			:= 0.00
Local nTamTno		:= ( Min(TamSx3("R6_DESC")[1], nTamLin) ) - 1
Local nSizePage		:= 0
Local nColCab12		:= 0
Local nColCab13		:= 0
Local nVarAux		:= 0
Local nESAux		:= 0
Local oBrush		:= TBrush():New( ,  RGB(228, 228, 228)  )

DEFAULT lTerminal := .F.
DEFAULT nTipoCab  := 3 // 1 - Cab para as Marcacoes / 2 - Totais / 3 - Sem Cab Auxiliar

lImpTurnos := nTipoCab <> 2

If !( lTerminal )

	nSizePage	:= oPrinter:nPageWidth / oPrinter:nFactorHor //Largura da página em cm dividido pelo fator horizontal, retorna tamanho da página em pixels
	nLin		:= aMargRel[2] + 10
	nCol		:= aMargRel[1] + 10
	nPxData	 	:= nCol+50
	nPxSemana	:= nPxData+50
	nVarAux		:= nPxSemana
	nColTot		:= nSizePage-(aMargRel[1]+aMargRel[3])
	nLinTot		:= ((oPrinter:nPageHeight / oPrinter:nFactorVert) -20 ) - (aMargRel[2]+aMargRel[4])
	nColCab12	:= nColTot / 3
	nColCab13	:= ( nColTot / 3 ) * 2
	aNaES		:= Array(nColunas)
	
	For nX := 1 to Len(aNaES)
		aNaES[nX] := nVarAux
		nVarAux += 40	
	Next nX
	
	If lImpHrVal
		nPxAbonos 	:= nVarAux
		nPxHe	 	:= nPxAbonos + 40
		nPxHrVal	:= nPxHe + 40
		nPxFalta 	:= nPxHrVal + 40
		If lPort671
			nPxJor 		:= nPxFalta + 40
			nPxAdnNot	:= nPxJor + 40
		Else
			nPxAdnNot	:= nPxFalta + 40
		EndIf
		nPxObser  	:= nPxAdnNot + 40 
	Else
		nPxAbonos 	:= nVarAux
		nPxHe	 	:= nPxAbonos + 40
		nPxFalta 	:= nPxHe + 40
		If lPort671
			nPxJor 		:= nPxFalta + 40
			nPxAdnNot	:= nPxJor + 40
		Else
			nPxAdnNot	:= nPxFalta + 40
		EndIf
		nPxObser  	:= nPxAdnNot + 40 
	EndIf
	
	If lCodeBar
		If lBigLine
			oPrinter:Fillrect( {nLin, nCol, nLin+17, nColTot-210 }, oBrush, "-2") 	// Quadro na Cor Cinza
		EndIf
		If lPort671
			oPrinter:SayAlign(nLin+2, nCol, STR0001 + " " + dToC(dPerIni) + " - " + dToC(dPerFim), oFontT, nColTot-210, 100,, ALIGN_H_CENTER)  	// 'Espelho do Ponto'	
		Else
			oPrinter:SayAlign(nLin+2,nCol,STR0001,oFontT,nColTot-210,100,,ALIGN_H_CENTER)  	// 'Espelho do Ponto'	
		EndIf
		
		oPrinter:Box( nLin+3, nColTot-200	, nLin+38, nColTot-5, "-6" )				// Caixa da linha total
		oPrinter:Code128c(nLin+30, nColTot-176, cCodeBar, 20)
		oPrinter:SayAlign(nLin+30,nColTot-200,cCodeBar,oFont06,(nColTot-(nColTot-200)),100,,ALIGN_H_CENTER)
	Else
		If lBigLine
			oPrinter:Fillrect( {nLin, nCol, nLin+17, nColTot }, oBrush, "-2") 	// Quadro na Cor Cinza
		EndIf
		If lPort671
			oPrinter:SayAlign(nLin+2,nCol, STR0001 + " " + dToC(dPerIni) + " - " + dToC(dPerFim), oFontT,nColTot,100,,ALIGN_H_CENTER)  	// 'Espelho do Ponto'
		Else
			oPrinter:SayAlign(nLin+2,nCol,STR0001,oFontT,nColTot,100,,ALIGN_H_CENTER)  	// 'Espelho do Ponto'	
		EndIf
	EndIf
	
	nLin += 18	
	
	cDet := STR0071  + PADR( If(Len(aInfo)>0,aInfo[03],SM0->M0_NomeCom) , 50)  // 'Empresa: '
	oPrinter:SayAlign(nLin,nCol,cDet,oFontP,500,100,,ALIGN_H_LEFT)
	
	If ( Len(aInfo) > 0 ) .And. ( aInfo[28] == 1 )
		cDet := STR0095  + PADR(Transform( If(!Empty(aInfo[27]), aInfo[27], SM0->M0_CEI),'@R ##.###.#####/##'),50)   // 'CEI: '
	ElseIf ( Len(aInfo) > 0 ) .And. ( aInfo[28] == 3 )
		cDet := STR0096  + PADR(Transform( If((aInfo[08]#""), aInfo[08], SM0->M0_CGC),'@R ###.###.###-##'),50)   // 'CPF: '
	Else
		cDet := STR0075  + PADR(Transform( If(Len(aInfo)>0,aInfo[08],SM0->M0_CGC),'@R ##.###.###/####-##'),50)   // 'CGC: '
	EndIf
	oPrinter:SayAlign(nLin,nColCab12,cDet,oFontP,500,100,,ALIGN_H_CENTER)
	
	nLin += 13
	cDet := PADR( If(Len(aInfo)>0,aInfo[04],SM0->M0_EndCob) , 50)
	oPrinter:SayAlign(nLin,nCol,cDet,oFontP,500,100,,ALIGN_H_LEFT)
	
	If lPort671
		cDet := "Emissão: " + dToC(Date())
		oPrinter:SayAlign(nLin, nColCab12, cDet, oFontP, 500, 100,, ALIGN_H_LEFT)
	EndIf
	
	nLin += 13
	
	oPrinter:Line(nLin,nCol,nLin,nColTot)

	nLin += 5
	cDet := STR0072  + AllTrim(SRA->RA_FILIAL) + ' - ' + SRA->RA_MAT  // ' Matr..: '
	oPrinter:SayAlign(nLin,nCol,cDet,oFontP,500,100,,ALIGN_H_LEFT)
	
	cDet := STR0074  + SRA->RA_NOME  // ' Nome..: '
	oPrinter:SayAlign(nLin, If(lPort671, 250, nColCab12), cDet, oFontP, 500, 100, , ALIGN_H_LEFT)
	
	cDet := STR0073  + SRA->RA_CHAPA // '  Chapa : '
	oPrinter:SayAlign(nLin, If(lPort671, 500, nColCab13), cDet, oFontP, 300, 100, , ALIGN_H_LEFT)
	
	If lPort671
		cDet := STR0112 + dToC(SRA->RA_ADMISSA) // 'Admissão: '
		oPrinter:SayAlign(nLin, 700, cDet, oFontP, 300, 100, , ALIGN_H_LEFT)
	EndIf
	
	If !Empty(SRA->RA_NSOCIAL)
		nLin += 13
		cDet := STR0100 + SRA->RA_NSOCIAL  // ' Nome Social: '
		oPrinter:SayAlign(nLin, nCol, cDet, oFontP, 500, 100, , ALIGN_H_LEFT)
	EndIf
	
	nLin += 13
	
	cDet := STR0078  + aFuncFunc[6] // ' Categ.: '
	oPrinter:SayAlign(nLin, If(lPort671, 700, nCol), cDet, oFontP, 500, 100,,ALIGN_H_LEFT)
	
	cDet := STR0077  + PADR(AllTrim(aFuncFunc[1]) + ' - ' + aFuncFunc[2] , 50) // 'C.C...: '
	oPrinter:SayAlign(nLin, If(lPort671, 250, nColCab12), cDet, oFontP, 500, 100,,ALIGN_H_LEFT)
	
	cDet := STR0076  + AllTrim(aFuncFunc[3]) + ' - ' + aFuncFunc[4]  // 'Funcao: '
	oPrinter:SayAlign(nLin, If(lPort671, nCol, nColCab13), cDet, oFontP, 500, 100,,ALIGN_H_LEFT)
	
	If lPort671
		cDet := STR0096 + Transform( SRA->RA_CIC, '@R ###.###.###-##') // "CPF: "
		oPrinter:SayAlign(nLin, 500, cDet, oFontP, 500, 100,,ALIGN_H_LEFT)
		
		//-- Imprime a Situação: XXXXXXXXXXXXXXXX - Período: 99/99/9999 a 99/99/9999
		If Len( aAfast ) > 0
			For nX := 1 To Len( aAfast )
				nLin += 13
				cDet := aAfast[nX][1]
				oPrinter:SayAlign(nLin, nCol, cDet, oFontP, 500, 100, , ALIGN_H_LEFT)
			Next nX
		EndIf
		
		cDet := STR0060 + ": " + AllTrim(SRA->RA_DEPTO) + " - " + fDesc("SQB", SRA->RA_DEPTO, "QB_DESCRIC", Nil, SRA->RA_FILIAL)
		oPrinter:SayAlign(nLin, 250, cDet, oFontP, 500, 100,, ALIGN_H_LEFT)
		
		cDet := STR0118 // "Legenda das marcações: O: Original, I: incluída, P:Pré-assinalada"
		oPrinter:SayAlign(nLin, 500, cDet, oFontP, 500, 100,, ALIGN_H_LEFT)
		
	EndIf
	
	nLin += 13
	oPrinter:Line(nLin,nCol,nLin,nColTot)
	
	If !lPort671
		nLin += 5
		//-- Imprime Trocas de turnos
		nQtdeTurno:=Len(aPrtTurn)
		
		If !lImpTroca .OR. nQtdeTurno<2   //-- Imprime Somente a descricao do turno atual
		   If !lImpTroca .OR. nQtdeTurno == 0 //-- Periodo Atual ou Superior
		   	  cDet := STR0079  + AllTrim(SRA->RA_TnoTrab) + ' ' + fDescTno(SRA->RA_FILIAL,SRA->RA_TnoTrab, nTamTno) 
		   Else	 //Periodo Anterior 
			  cDet := STR0079  + AllTrim(Alltrim(aPrtTurn[1,1])) + ' ' + fDescTno(SRA->RA_FILIAL,aPrtTurn[1,1], nTamTno)
		   EndIf
		   oPrinter:SayAlign(nLin,nColCab12,cDet,oFontP,500,100,,ALIGN_H_CENTER)
		   cDet := STR0060 + ": " + AllTrim(SRA->RA_DEPTO) + " - " + fDesc("SQB", SRA->RA_DEPTO, "QB_DESCRIC", Nil, SRA->RA_FILIAL)
		   oPrinter:SayAlign(nLin,nCol,cDet,oFontP,500,100,,ALIGN_H_LEFT)
		Else
			
	        If lImpTurnos // Se for o mesmo funcionario nao imprime trocas de turnos a partir da 2 pagina
	        	//-- Imprime Trocas de Turnos no Periodo
				For nX := 1 To nQtdeTurno
					cDet:= If(nX==1,STR0049,SPACE(Len(STR0049)))
			    	cDet:= cDet+DTOC(aPrtTurn[nX,2])+" "+STR0048+Alltrim(aPrtTurn[nX,1])+": "+fDescTno( SRA->RA_FILIAL, aPrtTurn[nX,1], nTamTno)
			    	oPrinter:SayAlign(nLin,nColCab12+12,cDet,oFontP,500,100,,ALIGN_H_LEFT)
			    	If nX == 1
			    		cDet := ' ' + STR0060 + ": " + AllTrim(SRA->RA_DEPTO)  + " - " + fDesc("SQB", SRA->RA_DEPTO, "QB_DESCRIC", Nil, SRA->RA_FILIAL) // 'Departamento: '
			    		oPrinter:SayAlign(nLin,nCol,cDet,oFontP,500,100,,ALIGN_H_LEFT)
			    	EndIf
			    	If nX <> nQtdeTurno
			    		nLin += 13
			    	EndIf
				Next nX 
			EndIf	
		EndIf
		
		//-- Imprime a Situação: XXXXXXXXXXXXXXXX - Período: 99/99/9999 a 99/99/9999
		If Len( aAfast ) > 0
			For nX := 1 To Len( aAfast )
				nLin += 13
				cDet := aAfast[nX][1]
				oPrinter:SayAlign(nLin, nCol, cDet, oFontP, 500, 100, , ALIGN_H_LEFT)
			Next nX
		EndIf
	EndIf 
	
	If nTipoCab==1 //Monta e Imprime Cabecalho das Marcacoes
	
		// Desenho do cabecalho //
		oPrinter:Box( nLin+=18, nCol	, nLin+20, nColTot, "-6" )				// Caixa da linha total

		If lBigLine
			oPrinter:Fillrect( {nLin+1, nCol+1, nLin+17, nColTot-1 }, oBrush, "-2") // Quadro na Cor Cinza
		EndIf
		
		oPrinter:Line( nLin, nPxData	, nLin+20, nPxData	, 0 , "-6") 		// Linha Pos Data
		
		For nX := 1 to Len(aNaES)
			oPrinter:Line( nLin, aNaES[nX]-6	, nLin+20	, aNaES[nX]-6, 0 , "-6")			// Linha Pos Na. Entrada/Saída
		Next nX
		
		oPrinter:Line( nLin, nPxAbonos-6	, nLin+20	, nPxAbonos-6, 0 , "-6")
		
		If lImpHrVal
			oPrinter:Line( nLin, nPxHrVal-6		, nLin+20	, nPxHrVal-6, 0 , "-6")
		EndIf

		oPrinter:Line( nLin, nPxHe-6		, nLin+20	, nPxHe-6, 0 , "-6")
		oPrinter:Line( nLin, nPxFalta-6		, nLin+20	, nPxFalta-6, 0 , "-6")
		
		If lPort671
			oPrinter:Line( nLin, nPxJor-6, nLin+20, nPxJor-6, 0 , "-6")
		EndIf
		
		oPrinter:Line( nLin, nPxAdnNot-6	, nLin+20	, nPxAdnNot-6, 0 , "-6")
		
		oPrinter:Line( nLin, nPxObser	, nLin+20	, nPxObser, 0 , "-6")
		
		oPrinter:SayAlign( nLin+=3 , nCol+5		, STR0042	, oFontP, nPxData, 150 , , ALIGN_H_LEFT ) //Data
		oPrinter:SayAlign( nLin, nPxData+6	, STR0043		, oFontP, nPxSemana, 150 , , ALIGN_H_LEFT ) //Semana

		nESAux := 1
		For nX := 1 to Len(aNaES)
			If nX%2 == 0
				oPrinter:SayAlign( nLin, aNaES[nX], AllTrim(Str(nESAux)) + STR0036, oFontP, aNaES[nX]+40, 150 , , ALIGN_H_LEFT ) //Saida
				nESAux++
			Else
				oPrinter:SayAlign( nLin, aNaES[nX], AllTrim(Str(nESAux)) + STR0035, oFontP, aNaES[nX]+40, 150 , , ALIGN_H_LEFT ) //Entrada
			EndIf
		Next nX
		
		oPrinter:SayAlign( nLin, nPxAbonos	, STR0062		, oFontP, 500, 150 , , ALIGN_H_LEFT ) //Abonos

		If lImpHrVal
			oPrinter:SayAlign( nLin, nPxHrVal	, STR0098		, oFontP, 500, 150 , , ALIGN_H_LEFT ) //Hr.Val
		EndIf

		oPrinter:SayAlign( nLin, nPxHe		, STR0068		, oFontP, 500, 150 , , ALIGN_H_LEFT ) //H.E.
		oPrinter:SayAlign( nLin, nPxFalta	, STR0069		, oFontP, 500, 150 , , ALIGN_H_LEFT ) //Falt/Atra
		
		If lPort671
			oPrinter:SayAlign( nLin, nPxJor, STR0113, oFontP, 500, 150, , ALIGN_H_LEFT ) // Jornada
		EndIf
		
		oPrinter:SayAlign( nLin, nPxAdnNot	, STR0070		, oFontP, 500, 150 , , ALIGN_H_LEFT ) //Ad. Not.
		oPrinter:SayAlign( nLin, nPxObser+6	, STR0063		, oFontP, 500, 150 , , ALIGN_H_LEFT ) //Observação
		
	ElseIf nTipoCab == 2
		nLin += 18
		oPrinter:Box( nLin, nCol , nLin+13, nColTot, "-6" )			// Caixa da linha total
		
		nTamCol	 := (nColTot - nCol) / 21
		nColCod1 := nCol + nTamCol
		nColDesc1:= nColCod1 + (nTamCol*4)
		nColCalc1:= nColDesc1 + nTamCol
		nColInf1 := nColCalc1 + nTamCol
		nColCod2 := nColInf1 + nTamCol
		nColDesc2:= nColCod2 + (nTamCol*4)
		nColCalc2:= nColDesc2 + nTamCol
		nColInf2 := nColCalc2 + nTamCol
		nColCod3 := nColInf2 + nTamCol
		nColDesc3:= nColCod3 + (nTamCol*4)
		nColCalc3:= nColDesc3 + nTamCol
		
		If lBigLine
			oPrinter:Fillrect( {nLin+1, nCol+1, nLin+13, nColTot-1 }, oBrush, "-2") // Quadro na Cor Cinza
		EndIf		 
		
		oPrinter:Line( nLin, nColCod1	, nLin+13, nColCod1		, 0 , "-6")
		If nImpHrs == 1 .or. nImpHrs == 3
			oPrinter:Line( nLin, nColDesc1	, nLin+13, nColDesc1	, 0 , "-6")
		EndIf
		oPrinter:Line( nLin, nColCalc1	, nLin+13, nColCalc1	, 0 , "-6")
		oPrinter:Line( nLin, nColInf1	, nLin+13, nColInf1		, 0 , "-6")
		oPrinter:Line( nLin, nColCod2	, nLin+13, nColCod2		, 0 , "-6")
		If nImpHrs == 1 .or. nImpHrs == 3
			oPrinter:Line( nLin, nColDesc2	, nLin+13, nColDesc2	, 0 , "-6")
		EndIf
		oPrinter:Line( nLin, nColCalc2	, nLin+13, nColCalc2	, 0 , "-6")
		oPrinter:Line( nLin, nColInf2	, nLin+13, nColInf2		, 0 , "-6")
		oPrinter:Line( nLin, nColCod3	, nLin+13, nColCod3		, 0 , "-6")
		If nImpHrs == 1 .or. nImpHrs == 3
			oPrinter:Line( nLin, nColDesc3	, nLin+13, nColDesc3	, 0 , "-6")
		EndIf
		oPrinter:Line( nLin, nColCalc3	, nLin+13, nColCalc3	, 0 , "-6")		

		oPrinter:SayAlign(nLin,nCol+2,STR0064,oFontP,500,100,,ALIGN_H_LEFT) //Codigo
		oPrinter:SayAlign(nLin,nColCod1+2,STR0065,oFontP,500,100,,ALIGN_H_LEFT) //Descricao
		
		If nImpHrs == 1 .or. nImpHrs == 3 //Calculado
			oPrinter:SayAlign(nLin,nColDesc1+2,STR0066,oFontP,500,100,,ALIGN_H_LEFT)
		EndIf
		
		oPrinter:SayAlign(nLin,nColCalc1+2,STR0067,oFontP,500,100,,ALIGN_H_LEFT) //Informado
		
		oPrinter:SayAlign(nLin,nColInf1+2,STR0064,oFontP,500,100,,ALIGN_H_LEFT) //Codigo
		oPrinter:SayAlign(nLin,nColCod2+2,STR0065,oFontP,500,100,,ALIGN_H_LEFT) //Descricao
		
		If nImpHrs == 1 .or. nImpHrs == 3 //Calculado		
			oPrinter:SayAlign(nLin,nColDesc2+2,STR0066,oFontP,500,100,,ALIGN_H_LEFT)
		EndIf
		oPrinter:SayAlign(nLin,nColCalc2+2,STR0067,oFontP,500,100,,ALIGN_H_LEFT) //Informado
		oPrinter:SayAlign(nLin,nColInf2+2,STR0064,oFontP,500,100,,ALIGN_H_LEFT) //Codigo
		oPrinter:SayAlign(nLin,nColCod3+2,STR0065,oFontP,500,100,,ALIGN_H_LEFT) //Descricao
		If nImpHrs == 1 .or. nImpHrs == 3 //Calculado		
			oPrinter:SayAlign(nLin,nColDesc3+2,STR0066,oFontP,500,100,,ALIGN_H_LEFT)
		EndIf
		oPrinter:SayAlign(nLin,nColCalc3+2,STR0067,oFontP,500,100,,ALIGN_H_LEFT)//Informado
	EndIf
Else
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Monta o Cabecalho das Marcacoes							   ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
    cHtml +=									'<tr>' + CRLF
    cHtml +=										'<td colspan="' + AllTrim( Str( nColunas + 5 ) ) + '" class="etiquetas_1" bgcolor="#FAFBFC"><hr size="1"></td>' + CRLF
    cHtml +=									'</tr>' + CRLF
	cHtml +=									'<tr>' + CRLF
	cHtml +=											'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=												'<div align="left">' + CRLF
	cHtml +=													STR0042 + CRLF	//'Data'
    cHtml +=												'</div>' + CRLF
	cHtml +=											'</td>' + CRLF
	cHtml +=											'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=												'<div align="left">' + CRLF
	cHtml +=													STR0043 + CRLF	//'Dia'
    cHtml +=												'</div>' + CRLF
	cHtml +=											'</td>' + CRLF
	For nX := 1 To nVezes
		cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
   		cHtml +=											'<div align="center">' + CRLF
    	cHtml +=												StrZero(nX,If(nX<10,1,2)) + STR0044 + CRLF	// '&#170;E.'
   		cHtml +=											'</div>' + CRLF
    	cHtml +=										'</td>' + CRLF
		cHtml +=										'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
   		cHtml +=											'<div align="center">' + CRLF
    	cHtml +=												StrZero(nX,If(nX<10,1,2)) + STR0045 + CRLF	//'&#170;S.'
   		cHtml +=											'</div>' + CRLF
    	cHtml +=										'</td>' + CRLF
	Next nX
	cHtml +=											'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=												'<div align="left">' + CRLF
	cHtml +=													STR0046 + CRLF //'Observa&ccedil;&otilde;s
    cHtml +=												'</div>' + CRLF
	cHtml +=											'</td>' + CRLF
	cHtml +=											'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=												'<div align="left">' + CRLF
	cHtml +=													STR0041 + CRLF	//'Motivo de Abono           Horas  Tipo da Marca&ccedil;&atilde;o'
    cHtml +=												'</div>' + CRLF
	cHtml +=											'</td>' + CRLF
	cHtml +=											'<td class="etiquetas_1" bgcolor="#FAFBFC" nowrap>' + CRLF
    cHtml +=												'<div align="left">' + CRLF
	cHtml +=													STR0047 + CRLF	//'Horas  Tipo da Marca&ccedil;&atilde;o'
    cHtml +=												'</div>' + CRLF
	cHtml +=											'</td>' + CRLF
    cHtml +=									'</tr>' + CRLF
    cHtml +=									'<tr>' + CRLF
    cHtml +=										'<td colspan="' + AllTrim( Str( nColunas + 5 ) ) + '" class="etiquetas_1" bgcolor="#FAFBFC"><hr size="1"></td>' + CRLF
    cHtml +=									'</tr>' + CRLF
EndIF
	
Return( cHtml )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³CarAboTot ³ Autor ³ EQUIPE DE RH          ³ Data ³ 08/08/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Carrega os totais do SPC e os abonos                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ POR010IMP                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function CarAboTot( aTotais , aAbonados , aAbonosPer, lMvAbosEve, lMvSubAbAp ) 

Local aTotSpc		:= {} //-- 1-SPC->PC_PD/2-SPC->PC_QUANTC/3-SPC->PC_QUANTI/4-SPC->PC_QTABONO
Local aCodAbono		:= {}
Local cFilSP9   	:= xFilial( "SP9" , SRA->RA_FILIAL )
Local cFilSRV		:= xFilial( "SRV" , SRA->RA_FILIAL )
Local cImpHoras 	:= If(nImpHrs==1,"C",If(nImpHrs==2,"I","*")) //-- Calc/Info/Ambas
Local cAutoriza 	:= If(nImpAut==1,"A",If(nImpAut==2,"N","*")) //-- Aut./N.Aut./Ambas
Local cAliasRes		:= IF( lImpAcum , "SPL" , "SPB" )
Local cAliasApo		:= IF( lImpAcum , "SPH" , "SPC" )
Local bAcessaSPC 	:= &("{ || " + ChkRH("PONR010","SPC","2") + "}")
Local bAcessaSPH 	:= &("{ || " + ChkRH("PONR010","SPH","2") + "}")
Local bAcessaSPB 	:= &("{ || " + ChkRH("PONR010","SPB","2") + "}")
Local bAcessaSPL 	:= &("{ || " + ChkRH("PONR010","SPL","2") + "}")
Local bAcessRes		:= IF( lImpAcum , bAcessaSPH , bAcessaSPC )
Local bAcessApo		:= IF( lImpAcum , bAcessaSPL , bAcessaSPB )
Local nColSpc   	:= 0.00
Local nCtSpc    	:= 0.00
Local nPass     	:= 0.00
Local nHorasCal 	:= 0.00
Local nHorasInf 	:= 0.00
Local nX        	:= 0.00

If ( lImpRes )
	//Totaliza Codigos a partir do Resultado	
	fTotalSPB(;
				@aTotSpc		,;
				SRA->RA_FILIAL	,;
				SRA->RA_Mat		,;
				dMarcIni		,;
				dMarcFim		,;
				bAcessRes		,;
				cAliasRes		;
			  )
	
	If !lSexagenal
		For nCtSpc := 1 To Len(aTotSpc)
			For nColSpc := 2 To 4
				aTotSpc[nCtSpc, nColSpc] := fConvHr(aTotSpc[nCtSpc, nColSpc], 'D')
			Next nColSpc
		Next nCtSpc
	EndIf
EndIf

//Totaliza Codigos a partir do Movimento
fTotaliza(;
			@aTotSpc,;
			SRA->RA_FILIAL,;
			SRA->RA_MAT,;
			bAcessApo,;
			cAliasApo,;
			cAutoriza,;
			@aCodAbono,;
			aAbonosPer,;
			lMvAbosEve,;
			lMvSubAbAp;
	 	)
//-- Converte as horas para Centesimal quando impressao for a partir do apontamento
If !( lImpRes ) .and. !( lSexagenal ) // Centesimal
	For nCtSpc :=1 To Len(aTotSpc)
		For nColSpc :=2 To 4
			aTotSpc[nCtSpc,nColSpc]:=fConvHr(aTotSpc[nCtSpc,nColSpc],'D',,5)
		Next nColSpc
	Next nCtSpc
EndIf

//-- Monta Array com Totais de Horas
If nImpHrs # 4  //-- Se solicitado para Listar Totais de Horas
	For nPass := 1 To Len(aTotSpc)
		If ( lImpRes ) //Impressao dos Resultados
			//-- Se encontrar o Codigo da Verba ou For um codigo de hora extra valido de acordo com o solicitado  
			If PosSrv( aTotSpc[nPass,1] , cFilSRV , NIL , 01 )
		   	   nHorasCal 	:= aTotSpc[nPass,2] //-- Calculado - Abonado
			   nHorasInf 	:= aTotSpc[nPass,3] //-- Informado
			   If nHorasCal > 0 .and. cImpHoras $ 'Cú*' .or. nHorasInf > 0 .and. cImpHoras $ 'Iú*'
			  	  cHorCal := If(cImpHoras$'Cú*',Transform(nHorasCal, '@E 999.99'),Space(9)) + Space(1)
				  cHorInf := If(cImpHoras$'Iú*',Transform(nHorasInf, '@E 999.99'),Space(9))
				  aAdd(aTotais, { aTotSpc[nPass,1], SRV->RV_DESC , cHorCal, cHorInf } )
		  	   EndIf	
	        EndIf
		ElseIf PosSP9( aTotSpc[nPass,1] , cFilSP9 , NIL , 01 )
			//-- Impressao a Partir do Movimento
			nHorasCal 	:= aTotSpc[nPass,2] //-- Calculado - Abonado
			nHorasInf 	:= aTotSpc[nPass,3] //-- Informado
			If nHorasCal > 0 .and. cImpHoras $ 'Cú*' .or. nHorasInf > 0 .and. cImpHoras $ 'Iú*'
				cHorCal := If(cImpHoras$'Cú*',Transform(nHorasCal, '@E 999.99'),Space(9)) + Space(1)
				cHorInf := If(cImpHoras$'Iú*',Transform(nHorasInf, '@E 999.99'),Space(9))
				aAdd(aTotais, { aTotSpc[nPass,1] , DescPDPon(aTotSpc[nPass,1], cFilSP9 ) , cHorCal, cHorInf } )
			EndIf  
		EndIf
	Next nPass
	
	//-- Acrescenta as informacoes referentes aos eventos associados aos motivos de abono
	//-- Condicoes: Se nao For Impressao de Resultados 
	//-- 			e Se For para Imprimir Horas Calculadas ou Ambas
	If !( lImpRes ) .and. (nImpHrs == 1 .or. nImpHrs == 3) 
		For nX := 1 To Len(aCodAbono) 
			// Converte as horas para Centesimal
			If !( lSexagenal ) // Centesimal
				aCodAbono[nX,2]:=fConvHr(aCodAbono[nX,2],'D',,5)
			EndIf
			aAdd(aTotais, { aCodAbono[nX,1] , DescPDPon(aCodAbono[nX,1], cFilSP9) , '  0,00'  , Transform(aCodAbono[nX,2],'@E 999.99') } )
		Next nX
	EndIf
EndIf

Return( NIL )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³fTotaliza ³ Autor ³ Mauricio MR           ³ Data ³ 27/05/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Totalizar as Verbas do SPC (Apontamentos) /SPH (Acumulado) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function fTotaliza(	aTotais		,;
							cFil		,;
							cMat		,;
							bAcessa 	,;
							cAlias		,;
							cAutoriza	,;
							aCodAbono	,;
							aAbonosPer	,;
							lMvAbosEve	,;
							lMvSubAbAp 	 ;
						 )

Local aJustifica	:= {}
Local cCodigo		:= ""
Local cPrefix		:= SubStr(cAlias,-2)
Local cTno			:= ""
Local cCodExtras	:= ""
Local cEvento		:= ""
Local cPD			:= ""
Local cPDI			:= ""
Local cCC			:= ""
Local cTPMARCA		:= ""
Local lExtra		:= .T.
Local lShow			:= .F.
Local lAbHoras		:= .T.
Local nQuaSpc		:= 0.00
Local nX			:= 0.00 
Local nEfetAbono	:= 0.00
Local nQUANTC		:= 0.00
Local nQuanti		:= 0.00
Local nQTABONO		:= 0.00
Local cAliasSP6		:= "SP6"
Local lRemonta		:= .F.
Local lContinua		:= .F.
Local cDSRMS		:= ""

If((nPos := aScan( aID, { |x| x[2] == "022A" })) > 0, cDSRMS := aID[nPos, 1], )
If((nPos := aScan( aID, { |x| x[2] == "021N" })) > 0, cDSRMS += "*" + aID[nPos, 1], )

If ( cAlias )->(dbSeek( cFil + cMat ) )
	While (cAlias)->( !Eof() .and. cFil+cMat == &(cPrefix+"_FILIAL")+&(cPrefix+"_MAT") )
        
        dData	:= (cAlias)->(&(cPrefix+"_DATA"))  		//-- Data do Apontamento
        cPD		:= (cAlias)->(&(cPrefix+"_PD"))    		//-- Codigo do Evento
        cPDI	:= (cAlias)->(&(cPrefix+"_PDI"))     	//-- Codigo do Evento Informado
        nQUANTC	:= (cAlias)->(&(cPrefix+"_QUANTC"))  	//-- Quantidade Calculada pelo Apontamento
        nQuanti	:= (cAlias)->(&(cPrefix+"_QUANTI"))  	//-- Quantidade Informada
        nQTABONO:= (cAlias)->(&(cPrefix+"_QTABONO")) 	//-- Quantidade Abonada
		cTPMARCA:= (cAlias)->(&(cPrefix+"_TPMARCA")) 	//-- Tipo da Marcacao
		cCC		:= (cAlias)->(&(cPrefix+"_CC")) 		//-- Centro de Custos
		
		If (cAlias)->( !Eval(bAcessa) )
			(cAlias)->( dbSkip() )
			Loop
		EndIf
		
		If dData < dMarcIni .or. dDATA > dMarcFim 
			(cAlias)->( dbSkip() )
			Loop
		EndIf
        
		If cPD $ cDSRMS
			(cAlias)->(dbSkip())
			Loop
		EndIf
		
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Obtem TODOS os ABONOS do Evento							   ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
        //-- Trata a Qtde de Abonos
        aJustifica 	:= {} //-- Reinicializa aJustifica
        nEfetAbono	:=	0.00
		If nQuanti == 0 .and. fAbonos( dData , cPD , NIL , @aJustifica , cTPMARCA , cCC , aAbonosPer ) > 0
            
            //-- Corre Todos os Abonos
			For nX := 1 To Len(aJustifica)
			    
			   /*
				ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				³ Cria Array Analitico de Abonos com horas Convertidas.		   ³
				ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
				//-- Obtem a Quantidade de Horas Abonadas
				nQuaSpc := aJustifica[nX,2] //_QtAbono
				
				//-- Converte as horas Abonadas para Centesimal
				If !( lSexagenal ) // Centesimal
					nQuaSpc:= fConvHr(nQuaSpc,'D',,5)
				EndIf
                
                //-- Cria Novo Elemento no array ANALITICO de Abonos 
				aAdd( aAbonados, {} )
				aAdd( aAbonados[Len(aAbonados)], dData )
				aAdd( aAbonados[Len(aAbonados)], DescAbono(aJustifica[nX,1],'C' , NIL , SRA->RA_FILIAL) )
				
				aAdd( aAbonados[Len(aAbonados)], StrTran(StrZero(nQuaSpc,5,2),'.',':') )
				aAdd( aAbonados[Len(aAbonados)], DescTpMarca(aBoxSPC,cTPMARCA))
				
				If !( lImpres )
					/*
					ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					³ Trata das Informacoes sobre o Evento Associado ao Motivo corrente ³
					ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/ 
					//-- Obtem Evento Associado
					cEvento := PosSP6( aJustifica[nX,1] , SRA->RA_FILIAL , "P6_EVENTO" , 01 )
					If ( lAbHoras := ( PosSP6( aJustifica[nX,1] , SRA->RA_FILIAL , "P6_ABHORAS" , 01 ) $ " S" ) )
					    //-- Se o motivo abona Horas
						If ( lAbHoras )
							If !Empty( cEvento )
								If ( nPos := aScan( aCodAbono, { |x| x[1] == cEvento } ) ) > 0
									aCodAbono[nPos,2] := __TimeSum(aCodAbono[nPos,2], aJustifica[nX,2] ) //_QtAbono
								Else
									aAdd(aCodAbono, {cEvento,  aJustifica[nX,2] }) // Codigo do Evento e Qtde Abonada
								EndIf
							Else 
								/*
								ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								³ A T E N C A O: Neste Ponto deveriamos tratar o paramentro MV_ABOSEVE  ³
								³                no entanto, como ja havia a deducao abaixo e caso al-  ³
								³                guem migra-se da versao 609 com o cadastro de motivo   ³
								³                de abonos abonando horas mas sem o codigo, deixariamos ³
								³                de tratar como antes e o cliente argumentaria alteracao³
								³                de conceito.											³
								ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/ 
							    //-- Se o motivo  nao possui abono associado
							    //-- Calcula o total de horas a abonar efetivamente
							    nEfetAbono:= __TimeSum(nEfetAbono, aJustifica[nX,2] ) //_QtAbono
							EndIf
						EndIf
					Else	
						/*
						ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						³Se Motivo de Abono Nao Abona Horas e o Codigo do Evento Relaci³
						³onado ao Abono nao Estiver Vazio, Eh como se fosse uma  altera³
						³racao do Codigo de Evento. Ou seja, Vai para os Totais      as³
						³Horas do Abono que serao subtraidas das Horas Calculadas (  Po³
						³deriamos Chamar esta operacao de "Informados via Abono" ).	   ³
						³Para que esse processo seja feito o Parametro MV_SUBABAP  deve³
						³ra ter o Conteudo igual a "S"								   ³
						ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
						If ( ( lMvSubAbAp ) .and. !Empty( cEvento ) )
						   //-- Se o motivo  nao possui abono associado
						   //-- Calcula o total de horas a abonar efetivamente 
						   If ( nPos := aScan( aCodAbono, { |x| x[1] == cEvento } ) ) > 0
								aCodAbono[nPos,2] := __TimeSum(aCodAbono[nPos,2], aJustifica[nX,2] ) //_QtAbono
						   Else
								aAdd(aCodAbono, {cEvento,  aJustifica[nX,2] }) // Codigo do Evento e Qtde Abonada
						   EndIf
						   //-- O total de horas acumulado em nEfetAbono sera deduzido do 
						   //-- total de horas apontadas.
						   nEfetAbono:= __TimeSum(nEfetAbono, aJustifica[nX,2] ) //_QtAbono
						EndIf
					EndIf
				EndIf	
			Next nX 
		EndIf
        
        If !( lImpres )
	        //-- Obtem o Codigo do Evento  (Informado ou Calculado)
			cCodigo:= If(!Empty(cPDI), cPDI, cPD )
			
	        //-- Obtem a posicao no Calendario para a Data
			If ( nPos 	:= aScan(aTabCalend, {|x| x[1] ==dDATA .and. x[4] == '1E' }) ) > 0 
			    //-- Obtem o Turno vigente na Data
				cTno	:=	aTabCalend[nPos,14]  
			    //-- Carrega ou recupera os codigos correspondentes a horas extras na Data
				cCodExtras	:= ''
				lRemonta	:= .F.
				If ( cAutoriza $ "A|N" .AND. !Empty(ALLTRIM(cPdi) ) ) 
					lRemonta	:= .T.
				EndIf
				
				CarExtAut( @cCodExtras, cTno, "*", lRemonta )
				
				lExtra := .F.
				lShow := .F.
				
				If cCodigo $ cCodExtras
					lExtra := .T.
					If cAutoriza != "*"
						cCodExtras := ""
						CarExtAut( @cCodExtras, cTno, cAutoriza, lRemonta )
						If cCodigo $ cCodExtras
							lShow := .T.
						EndIf
					EndIf
				EndIf   
			EndIf      
			
	        //-- Se o Evento for Alguma HE Solicitada (Autorizada ou Nao Autorizada) 
	        //-- Ou  Valido Qquer Evento (Autorizado e Nao Autorizado)
	        //-- OU  Evento possui um identificador correspondente a Evento Autorizado ou Nao Autorizado.
			//-- Ou  Evento e' referente a banco de horas 
			lContinua	:= .F.
			
			If ( cAutoriza == '*' .Or. (lExtra .And. lShow) .Or. ( !lExtra .And. aScan(aId, {|aEvento| ( aEvento[1] == cCodigo .and. Right(aEvento[2],1) == cAutoriza ) .Or. ( aEvento[1] == cCodigo .And. cAutoriza == 'A' .And. Empty(aEvento[2]) .And. aEvento[4] == "S" ) }  ) > 0.00))
				lContinua	:= .T.
			EndIf	
			
			If ( lContinua )
	           
		        //-- Procura em aTotais pelo acumulado do Evento Lido
				If ( nPos := aScan(aTotais,{|x| x[1] = cCodigo  }) ) > 0    
				   //-- Subtrai do evento a qtde de horas que efetivamente abona horas conforme motivo de abono
			       aTotais[nPos,2] := __TimeSum(aTotais[nPos,2],If(nQuanti>0, 0, __TimeSub(nQUANTC,nEfetAbono)))
				   aTotais[nPos,3] := __TimeSum(aTotais[nPos,3],nQuanti)
				   aTotais[nPos,4] := __TimeSum(aTotais[nPos,4],nQTABONO)
			    
				Else 
				   //-- Adiciona Evento em Acumulados
				   //-- Subtrai do evento a qtde de horas que efetivamente abona horas conforme motivo de abono
	           	   aAdd(aTotais,{cCodigo,If(nQuanti > 0, 0, __TimeSub(nQUANTC,nEfetAbono)), nQuanti,nQTABONO,lExtra })
	            EndIf
	        EndIf
         EndIf
		(cAlias)->( dbSkip() )
	End While
EndIf

Return( NIL )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³fTotalSPB ³ Autor ³ EQUIPE DE RH		    ³ Data ³ 05/06/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Totaliza eventos a partir do SPB.                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function fTotalSPB(aTotais,cFil,cMat,dDataIni,dDataFim,bAcessa,cAlias)

Local cPrefix := ""

cPrefix		:= SubStr(cAlias, -2)

If ( cAlias )->( dbSeek( cFil + cMat ) )
	While (cAlias)->( !Eof() .and. cFil+cMat == &(cPrefix+"_FILIAL")+&(cPrefix+"_MAT") )
		
		If (cAlias)->( &(cPrefix+"_DATA") < dDataIni .or. &(cPrefix+"_DATA") > dDataFim )
			(cAlias)->( dbSkip() )
			Loop
		EndIf
		
		If (cAlias)->( !Eval(bAcessa) )
			(cAlias)->( dbSkip() )
			Loop
		EndIf
		
		If ( nPos := aScan(aTotais,{|x| x[1] == (cAlias)->( &(cPrefix+"_PD") ) }) ) > 0
			aTotais[nPos, 2] := SomaHoras(aTotais[nPos, 2], fConvHr((cAlias)->(&(cPrefix+"_HORAS")), 'H'))
		Else
			aAdd(aTotais, {(cAlias)->(&(cPrefix+"_PD") ), fConvHr((cAlias)->(&(cPrefix+"_HORAS")), 'H'), 0, 0})
		EndIf
		(cAlias)->( dbSkip() )
	EndDo
EndIf

Return( NIL )

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³LoadX3Box ³ Autor ³ Mauricio MR           ³ Data ³ 10.12.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna array da ComboBox                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cCampo - Nome do Campo                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function LoadX3Box(cCampo)

Local aRet:={},nCont,nIgual
Local cCbox,cString
Local aSvArea := SX3->(GetArea())

SX3->(DbSetOrder(2))
SX3->(DbSeek(cCampo))

cCbox := SX3->(X3Cbox())
//-- Opcao 1   |Opcao 2 |Opcao 3|Opcao 4
//-- 01=Amarelo;02=Preto;03=Azul;04=Vermelho  
//   | À->nIgual        À->nCont
//   À->cString: 01=Amarelo
//aRet:={{01,Amarelo},{02.Preto},...}

While !Empty(cCbox) 
   nCont:=AT(";",cCbox) 
   nIgual:=AT("=",cCbox)
   cString:=AllTrim(SubStr(cCbox,1,nCont-1)) //Opcao
   IF nCont == 0
       aAdd(aRet,{SubStr(cString,1,nigual-1),SubStr(cString,nigual+1)})
      Exit
   Else
       aAdd(aRet,{SubStr(cString,1,nigual-1),SubStr(cString,nigual+1)})
   Endif 
   cCbox:=SubStr(cCbox,nCont+1)
Enddo
   
RestArea(aSvArea)

Return( aRet )

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³DescTPMarc³ Autor ³ Mauricio MR           ³ Data ³ 10.12.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna Descricao do Tipo da Marcacao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aBox     - Array Contendo as Opcoes do Combox Ja Carregadas³±±
±±³          ³ cTpMarca - Tipo da Marcacao                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Ponr010                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function DescTpMarca(aBox,cTpMarca)

Local aTpMarca:={},cRet:='',nTpMarca:=0
//-- SE Existirem Opcoes Realiza a Busca da Marcacao
If Len(aBox)>0
   nTpmarca:=aScan(aBox,{|xtp| xTp[1] == cTpMarca})
   cRet:=If(nTpMarca>0,aBox[nTpmarca,2],"")
EndIf

Return( cRet )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ CarExtAut³ Autor ³ Mauricio MR           ³ Data ³ 24/05/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna Relacao de Horas Extras por Filial/Turno           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cCodExtras --> String que Contem ou Contera os Codigos     ³±±
±±³          ³ cTnoCad    --> Turno conforme o Dia                        ³±±
±±³          ³ cAutoriza  --> "*" Horas Autorizadas/Nao Autorizadas       ³±± 
±±³          ³                "A" Horas Autorizadas                       ³±± 
±±³          ³                "N" Horas Nao Autorizadas                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONM010                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function CarExtAut( cCodExtras , cTnoCad , cAutoriza , lRemonta )

Local aTabExtra		:= {}
Local cFilSP4		:= fFilFunc("SP4")
Local cTno			:= ""
Local lFound		:= .F.
Local lRet			:= .T.
Local nX			:= 0
Local naTabExtra	:= 0    
Local ncTurno	    := 0.00

Static aExtrasTno

If ( PCount() == 0.00 )

	aExtrasTno	:= NIL              

Else

	DEFAULT aExtrasTno	:= {} 
		
	//-- Procura Tabela (Filial + Turno corrente)
	If ( lFound	:= ( SP4->( dbSeek( cFilSP4 + cTnoCad , .F. ) ) ) )
	   cTno		:=	cTnoCad
	   lFound	:=	.T.
	Else      
	    //-- Procura Tabela (Filial)    
	    cTno	:= Space(Len(SP4->P4_TURNO))
		lFound	:= SP4->( dbSeek(  cFilSP4 + cTno , .F.) )
	EndIf    
	
	//-- Se Existe Tabela de HE
	If ( lFound )
	   //-- Verifica se a Tabela de HE para o Turno ainda nao foi carregada
   	   If (lRemonta) .OR. (ncTurno:=aScan(aExtrasTno,{|aTurno| aTurno[1]  == cFilSP4 .and. aTurno[2] == cTno .And. aTurno[4] == cAutoriza} )) == 0.00
	      //-- Se nao Encontrou Carrega Tabela para Filial e Turno especificos
	      GetTabExtra( @aTabExtra , cFilSP4 , cTno , .F. , .F. )     
	      //-- Posiciona no inicio da Tabela de HE da Filial Solicitada
		  If !Empty(aTabExtra)
			  naTabExtra:=	Len(aTabExtra)
			  //-- Corre C¢digos de Hora Extra da Filial
			  For nX:=1 To naTabExtra
					//-- Se Ambos os Tipos de Eventos ou Autorizados
					If cAutoriza == '*' .or. (cAutoriza == 'A' .and. !Empty(aTabExtra[nX,4]))
						cCodExtras += aTabExtra[nX,4]+'A' //-- Cod Autorizado                
					EndIf
					//-- Se Ambos os Tipos de Eventos ou Nao Autorizados					
					If cAutoriza == '*' .or. (cAutoriza == 'N' .and. !Empty(aTabExtra[nX,5]))
						cCodExtras += aTabExtra[nX,5]+'N' //-- Cod Nao Autorizado                
					EndIf
			  Next nX
		  EndIf	  
		  //-- Cria Nova Relacao de Codigos Extras para o Turno Lido
		  aAdd(aExtrasTno,{cFilSP4, cTno, cCodExtras, cAutoriza})
	    Else
	        //-- Recupera Tabela Anteriormente Lida
	        cCodExtras:=aExtrasTno[ncTurno,3] 
	    EndIf                    
	    
	EndIf	

EndIf

Return( lRet )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ CarId    ³ Autor ³ Mauricio MR           ³ Data ³ 24/05/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna Relacao de Eventos da Filial						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cFil       --> Codigo da Filial desejada					  ³±±
±±³          ³ aId    	  --> Array com a Relacao	                      ³±±
±±³          ³ cAutoriza  --> "*" Horas Autorizadas/Nao Autorizadas       ³±± 
±±³          ³                "A" Horas Autorizadas                       ³±± 
±±³          ³                "N" Horas Nao Autorizadas                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PONM010                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/	
Static Function CarId( cFil , aId , cAutoriza )

Local nPos	:= 0.00

//-- Preenche o Array aCodAut com os Eventos (Menos DSR Mes Ant.)
SP9->( dbSeek( cFil , .T. ) )
While SP9->( !Eof() .and. cFil == P9_FILIAL )
	If ( ( Right(SP9->P9_IDPON,1) == cAutoriza ) .or. ( cAutoriza == "*" ) )
		aAdd( aId , Array( 04 ) )
		nPos := Len( aId )
		aId[ nPos , 01 ] := SP9->P9_CODIGO	//-- Codigo do Evento 
		aId[ nPos , 02 ] := SP9->P9_IDPON 	//-- Identificador do Ponto 
		aId[ nPos , 03 ] := SP9->P9_CODFOL	//-- Codigo do da Verba Folha
		aId[ nPos , 04 ] := SP9->P9_BHORAS	//-- Evento para B.Horas
	EndIf
	SP9->( dbSkip() )
EndDo

Return( NIL )

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fGetApo   ³ Autor ³ Leandro Dr.           ³ Data ³ 23.03.15 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna Apontamentos do funcionario.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Ponr010                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function fGetApo(aResult,dInicio,dFim,lImpAcum, aTabCalend, aMarcacoes)
Local aArea		:= GetArea()
Local cAliasQry	:= GetNextAlias()
Local cWhere	:= ""
Local cPrefixo	:= If(lImpAcum,"PH_","PC_")
Local cJoinFil	:= ""
Local cJoinSPI	:= ""
Local cJoinSP6	:= ""
Local cAutoriza	:= If(nImpAut == 1, "A", If(nImpAut == 2, "N", "*"))
Local aEvtDesc	:= {}
Local aEvtHe	:= {}
Local lSomaValo	:= .T.
Local nCont		:= 0
Local dLastApo	:= Ctod("//")

//Carrega tabela de Eventos do Tipo de Hora Extra

cWhere += "%"
cWhere += cPrefixo + "FILIAL = '" + SRA->RA_FILIAL + "' AND "
cWhere += cPrefixo + "MAT = '" + SRA->RA_MAT + "' AND "
cWhere += cPrefixo + "DATA >= '" + DtoS(dInicio) + "' AND "
cWhere += cPrefixo + "DATA <= '" + DtoS(dFim) + "' "
cWhere += "%"

If lImpAcum
	cJoinFil:= "%" + FWJoinFilial("SPH", "SP9") + "%"
	cJoinSPI:= "%" + FWJoinFilial("SPH", "SPI") + "%"
	cJoinSP6:= "%" + FWJoinFilial("SPH", "SP6") + "%"
	
	BeginSql Alias cAliasQry
		
		SELECT             
			SPH.PH_DATA, SPH.PH_PD, SPH.PH_TPMARCA, SPH.PH_PDI , SPH.PH_QUANTC, SPH.PH_QUANTI, SP9.P9_CLASEV, SP9.P9_IDPON, SP6.P6_CODIGO, SP6.P6_EVENTO, SPI.PI_QUANTV
		FROM 
			%Table:SPH% SPH
		INNER JOIN %Table:SP9% SP9
		ON %exp:cJoinFil% AND SP9.%NotDel% AND (CASE WHEN SPH.PH_PDI <> '   ' THEN SPH.PH_PDI ELSE SPH.PH_PD END) = SP9.P9_CODIGO
		LEFT JOIN  %Table:SP6% SP6
		ON %exp:cJoinSP6% AND SP6.%NotDel% AND SPH.PH_ABONO = SP6.P6_CODIGO
		LEFT JOIN  %Table:SPI% SPI
		ON %exp:cJoinSPI% AND SPI.%NotDel% AND ((CASE WHEN SPH.PH_PDI <> '   ' THEN SPH.PH_PDI ELSE SPH.PH_PD END) = SPI.PI_PD OR SP6.P6_EVENTO = SPI.PI_PD) AND SPH.PH_MAT = SPI.PI_MAT AND SPH.PH_DATA = SPI.PI_DATA 
		WHERE
			%Exp:cWhere% AND SPH.%NotDel%
		ORDER BY SPH.PH_DATA, SPH.PH_PD
	
	EndSql 	
Else
	cJoinFil:= "%" + FWJoinFilial("SPC", "SP9") + "%"
	cJoinSPI:= "%" + FWJoinFilial("SPC", "SPI") + "%"
	cJoinSP6:= "%" + FWJoinFilial("SPC", "SP6") + "%"
	
	BeginSql Alias cAliasQry
		
		SELECT             
			SPC.PC_DATA, SPC.PC_PD, SPC.PC_TPMARCA, SPC.PC_PDI, SPC.PC_QUANTC, SPC.PC_QUANTI, SP9.P9_CLASEV, SP9.P9_IDPON, SP6.P6_CODIGO, SP6.P6_EVENTO, SPI.PI_QUANTV 
		FROM 
			%Table:SPC% SPC
		INNER JOIN %Table:SP9% SP9
		ON %exp:cJoinFil% AND SP9.%NotDel% AND (CASE WHEN SPC.PC_PDI <> '   ' THEN SPC.PC_PDI ELSE SPC.PC_PD END) = SP9.P9_CODIGO
		LEFT JOIN  %Table:SP6% SP6
		ON %exp:cJoinSP6% AND SP6.%NotDel% AND SPC.PC_ABONO = SP6.P6_CODIGO
		LEFT JOIN  %Table:SPI% SPI
		ON %exp:cJoinSPI% AND SPI.%NotDel% AND ((CASE WHEN SPC.PC_PDI <> '   ' THEN SPC.PC_PDI ELSE SPC.PC_PD END) = SPI.PI_PD OR SP6.P6_EVENTO = SPI.PI_PD) AND SPC.PC_MAT = SPI.PI_MAT AND SPC.PC_DATA = SPI.PI_DATA 
		WHERE
			%Exp:cWhere%  AND SPC.%NotDel%
		ORDER BY SPC.PC_DATA, SPC.PC_PD	
	EndSql 	
EndIf

While !(cAliasQry)->(Eof())
	
	//Hora Extra
	If (cAliasQry)->P9_CLASEV == "01"
		
		If &("PI_QUANTV") > 0
			lSomaValo := aScan(aEvtHe, {|x| x[1] == &(cPrefixo+"DATA") .And. (x[4] == &(cPrefixo+"PD") .Or. x[4] == &(cPrefixo+"PDI"))}) == 0 // Mesmo evento no mesmo dia
		EndIf
		
		// Filtra hora extra de acordo com tipo selecionado no parâmetro MV_PAR14 (Autorizada/ Não autorizada)
		If cAutoriza == '*' .or. ( cAutoriza != 'N' .AND. (cAliasQry)->P9_IDPON == "029A")  //Tratamento incluido para considerar InterJornada no Relatório.
			If aScan(aEvtHe,{|x| x[1] == &(cPrefixo+"DATA") .And. x[2] == If(&(cPrefixo+"QUANTI")>0,&(cPrefixo+"QUANTI"),&(cPrefixo+"QUANTC")) .And. x[3] == &(cPrefixo+"TPMARCA") .And. x[4] == &(cPrefixo+"PD")}) > 0
				(cAliasQry)->(aAdd(aResult,{&(cPrefixo+"DATA"),"1",0,If(&("PI_QUANTV") > 0 .And. lSomaValo, &("PI_QUANTV"), "")}))
			Else
				(cAliasQry)->(aAdd(aResult,{&(cPrefixo+"DATA"),"1",If(&(cPrefixo+"QUANTI")>0,&(cPrefixo+"QUANTI"),&(cPrefixo+"QUANTC")),If(&("PI_QUANTV") > 0 .And. lSomaValo, &("PI_QUANTV"),"")}))
				aAdd(aEvtHe,{&(cPrefixo+"DATA"),If(&(cPrefixo+"QUANTI")>0,&(cPrefixo+"QUANTI"),&(cPrefixo+"QUANTC")),&(cPrefixo+"TPMARCA"),&(cPrefixo+"PD")})
			EndIf
		ElseIf Ascan(aCodAut, { |x| x[3] == Iif(Empty((cAliasQry)->(&(cPrefixo+"PDI"))),(cAliasQry)->(&(cPrefixo+"PD")),(cAliasQry)->(&(cPrefixo+"PDI"))) .AND. x[4] == cAutoriza } ) > 0
			If aScan(aEvtHe,{|x| x[1] == &(cPrefixo+"DATA") .And. x[2] == If(&(cPrefixo+"QUANTI")>0,&(cPrefixo+"QUANTI"),&(cPrefixo+"QUANTC")) .And. x[3] == &(cPrefixo+"TPMARCA") .And. x[4] == &(cPrefixo+"PD")}) > 0
				(cAliasQry)->(aAdd(aResult,{&(cPrefixo+"DATA"), "1", 0, If(&("PI_QUANTV") > 0 .And. lSomaValo, &("PI_QUANTV"), "")}))
			Else
				(cAliasQry)->(aAdd(aResult,{&(cPrefixo+"DATA"),"1",If(&(cPrefixo+"QUANTI")>0,&(cPrefixo+"QUANTI"),&(cPrefixo+"QUANTC")),If(&("PI_QUANTV") > 0 .And. lSomaValo, &("PI_QUANTV"),"")}))
				aAdd(aEvtHe,{&(cPrefixo+"DATA"),If(&(cPrefixo+"QUANTI")>0,&(cPrefixo+"QUANTI"),&(cPrefixo+"QUANTC")),&(cPrefixo+"TPMARCA"),&(cPrefixo+"PD")})
			EndIf
		EndIf
		
	//Faltas/Atrasos/Saida antecipada	
	ElseIf (cAliasQry)->P9_CLASEV $ "02*03*04*05" 
		If cAutoriza == '*' .Or. Empty((cAliasQry)->P9_IDPON) .Or. Right((cAliasQry)->P9_IDPON, 1) == cAutoriza
			If aScan(aEvtDesc,{|x| x[1] == &(cPrefixo+"DATA") .And. x[2] == If(&(cPrefixo+"QUANTI")>0,&(cPrefixo+"QUANTI"),&(cPrefixo+"QUANTC")) .And. x[3] == &(cPrefixo+"TPMARCA") .And. x[6] == &(cPrefixo+"PD")}) > 0
				(cAliasQry)->(aAdd(aResult,{&(cPrefixo+"DATA"),"2",0,If(&("PI_QUANTV") > 0,&("PI_QUANTV"),"")}))
			Else
				If &("PI_QUANTV") > 0
					If !Empty(&("P6_EVENTO"))
						lSomaValo := aScan(aEvtDesc,{|x| (x[1] == &(cPrefixo+"DATA") .And. x[4] == &("P6_EVENTO") .And. x[5] == &("PI_QUANTV"))}) == 0
					Else
						lSomaValo := aScan(aEvtDesc,{|x| (x[1] == &(cPrefixo+"DATA") .And. x[4] == &("P6_EVENTO") .And. x[5] == &("PI_QUANTV") .And. x[6] == &(cPrefixo+"PD"))}) == 0
					EndIf
				EndIf
				(cAliasQry)->(aAdd(aResult,{&(cPrefixo+"DATA"),"2",If(&(cPrefixo+"QUANTI")>0,&(cPrefixo+"QUANTI"),&(cPrefixo+"QUANTC")),If(&("PI_QUANTV") > 0 .And. lSomaValo, &("PI_QUANTV"),"")}))
				aAdd(aEvtDesc,{&(cPrefixo+"DATA"),If(&(cPrefixo+"QUANTI")>0,&(cPrefixo+"QUANTI"),&(cPrefixo+"QUANTC")),&(cPrefixo+"TPMARCA"), &("P6_EVENTO"), &("PI_QUANTV"), &(cPrefixo+"PD")})
			EndIf
		EndIf
		
	//Adicional Noturno
	ElseIf (cAliasQry)->P9_IDPON $ "003N*004A*027N*028A*045A*046A" .Or. (cAliasQry)->P9_CLASEV == "06"
		// Filtra adicional noturno de acordo com tipo selecionado no parâmetro MV_PAR14 (Autorizada/ Não autorizada)
		If cAutoriza == '*'
			(cAliasQry)->(aAdd(aResult,{&(cPrefixo+"DATA"),"3",If(&(cPrefixo+"QUANTI")>0,&(cPrefixo+"QUANTI"),&(cPrefixo+"QUANTC")),If(&("PI_QUANTV") > 0,&("PI_QUANTV"),"")}))
		Elseif cAutoriza == 'A'
			If (cAliasQry)->P9_IDPON $ "004A*028A" .Or. (Empty((cAliasQry)->P9_IDPON) .And. (cAliasQry)->P9_CLASEV == "06")
				(cAliasQry)->(aAdd(aResult,{&(cPrefixo+"DATA"),"3",If(&(cPrefixo+"QUANTI")>0,&(cPrefixo+"QUANTI"),&(cPrefixo+"QUANTC")),If(&("PI_QUANTV") > 0,&("PI_QUANTV"),"")}))
			Endif
		Else
			If (cAliasQry)->P9_IDPON $ "003N*027N" .Or. (Empty((cAliasQry)->P9_IDPON) .And. (cAliasQry)->P9_CLASEV == "06")
				(cAliasQry)->(aAdd(aResult,{&(cPrefixo+"DATA"),"3",If(&(cPrefixo+"QUANTI")>0,&(cPrefixo+"QUANTI"),&(cPrefixo+"QUANTC")),If(&("PI_QUANTV") > 0,&("PI_QUANTV"),"")}))
			Endif
		Endif
	EndIf
	(cAliasQry)->(DbSkip())
EndDo

(cAliasQry)->(DbCloseArea())

RestArea(aArea)

If lPort671
	// Obtem a duração da jornada realizada
	For nCont := 1 To Len(aMarcacoes)
		If aMarcacoes[nCont][AMARC_DATAAPO] != dLastApo
			dLastApo := aMarcacoes[nCont][AMARC_DATAAPO]
			nHorasJor := CalcHoraJor(dLastApo, nCont, aMarcacoes, aTabCalend)
			If nHorasJor > 0 
				aAdd(aResult, {DtoS(dLastApo), "4", nHorasJor, ""})
			EndIf
		EndIf
	Next nCont
EndIf

Return Nil

/*/{Protheus.doc} CalcHoraJor
Calcula a duração da jornada de acordo com as marcações, considerando também as Horas extras e o Horário noturno
@type  Static Function
@author Cícero Alves
@since 24/06/2022
@param dDataApo, Data, Dia que será avaliado
@param nPosMarc, Numérico, Posição no aMarcacoes da primeira marcação do dia
@param aMarcacoes, Array, Marcações realizadas no período
@param aTabCalend, Array, Calendário do ponto
@return nHorasJor, Numérico, Duração da jornada realizada, incluindo as horas extras e considerado o horário noturno reduzido
/*/
Static Function CalcHoraJor(dDataApo, nPosMarc, aMarcacoes, aTabCalend)
	
	Local nCont 		:= 0
	Local nHoras 		:= 0
	Local nHorasTot		:= 0
	Local nHorasNTot	:= 0
	Local nHorasNot		:= 0
	Local nHorasJor		:= 0
	Local nLenMarc		:= Len(aMarcacoes)
	Local nTab			:= AScan(aTabCalend, {|x| x[CALEND_POS_DATA_APO] == dDataApo })
	
	If nTab > 0 .And. aTabCalend[nTab][CALEND_POS_TIPO_DIA] == "S" // Apenas para dias trabalhados
		For nCont := nPosMarc To nLenMarc Step 2
			
			If nCont == nLenMarc .Or. aMarcacoes[nCont][AMARC_DATAAPO] != dDataApo .Or. aMarcacoes[nCont + 1 ][AMARC_DATAAPO] != dDataApo
				Exit
			EndIf
			
			If "E" $ aMarcacoes[nCont][AMARC_TIPOMARC]
				fCalHoras(	aMarcacoes[nCont][AMARC_DATA]			,;
							aMarcacoes[nCont][AMARC_HORA]			,;
							aMarcacoes[nCont + 1][AMARC_DATA]		,;
							aMarcacoes[nCont + 1][AMARC_HORA]		,;
							@nHoras    								,;	//05 -> <@>Horas Normais Apontadas
							@nHorasNot      						,;	//06 -> <@>Horas Noturnas Apontadas
							.T.										,;	//07 -> Apontar Horas Noturnas
							aMarcacoes[nCont][AMARC_DATA]			,;	//08 -> Data Inicial Para a Hora Noturna
							NIL										,;	//09 -> <@>Horas de Acrescimo Noturno
							aTabCalend[nTab][CALEND_POS_INI_H_NOT]	,;	//10 -> Inicio do Horario Noturno
							aTabCalend[nTab][CALEND_POS_FIM_H_NOT]	,;	//11 -> Final do Horario Noturno
							aTabCalend[nTab][CALEND_POS_MIN_H_NOT]	,;	//12 -> Minutos do Horario Noturno (Não deve reduzir as horas noturnas)
							NIL     								,;	//13 -> Apenas Acrescimo Noturno
							NIL										 ;	//14 -> Periodo da Hora Noturna
						)
				
				nHorasTot := SomaHoras(nHorasTot, nHoras)
				nHorasNTot := SomaHoras(nHorasNTot, nHorasNot)
				nHoras := 0
				nHorasNot := 0
			EndIf
		Next
		
		nHorasJor := SomaHoras(nHorasTot, Round(nHorasNTot,2))
		
	EndIf
	
Return nHorasJor

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fImpSign  ³ Autor ³ Leandro Dr.           ³ Data ³ 23.03.15 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime espaço para assinatura do funcionario.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Ponr010                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function fImpSign(oPrinter)
	
	
	//Mensagem antes da assinatura
	If !Empty(cMenPad1) .or. !Empty(cMenPad2)
		oPrinter:SayAlign(nLinTot-15,nCol+2,cMenPad1 + cMenPad2,oFontM,500,100,,ALIGN_H_LEFT)
	EndIf
	
	oPrinter:SayAlign(nLinTot-20,nCol,Replicate("_",50),oFontP,nColTot,100,,ALIGN_H_CENTER)
	
	oPrinter:SayAlign(nLinTot-10,nCol,STR0013,oFontP,nColTot,100,,ALIGN_H_CENTER) // 'Assinatura do Funcionario'
Return Nil

/*/{Protheus.doc} fValMVCOL
Valida o Numero maximo de Entrada e Saida (MV_COLMARC).
@type	function
@author	Mick William da Silva
@since	09/06/2015
/*/
Static Function fValMVCOL()
	Local lRet := .F.

	IF SuperGetmv("MV_COLMARC") <= 5 .And. SuperGetmv("MV_COLMARC") >= 1 
		lRet := .T.
	Endif 
	
Return lRet

/*/{Protheus.doc} Imp_Cabec
Imprime o cabecalho do espelho do ponto
@type	function
@author	EQUIPE DE RH
@since	09/04/1996
/*/
Static Function Pnr010ImpBh(nSaldoAnt, nSaldoAtu, nCredito, nDebito, nTotHrVal, nSaldAntVl)
	
	Local aArea 	:= GetArea()
	Local nValor 	:= 0
	Local nHrValori	:= 0
	Local lRet		:= .F.

	nSaldoAnt	:= 0
	nDebito		:= 0
	nCredito	:= 0
	nSaldoAtu	:= 0
	nTotHrVal	:= 0
	nSaldAntVl	:= 0
	
	dbSelectArea( "SPI" )
	dbSetOrder(2)
	dbSeek( SRA->RA_FILIAL + SRA->RA_MAT )
	While SPI->( !Eof() .And. PI_FILIAL + PI_MAT == SRA->( RA_FILIAL + RA_MAT ) )
		
		PosSP9(SPI->PI_PD, SRA->RA_FILIAL, "P9_TIPOCOD")
			// Totaliza Saldo Anterior
			If SPI->PI_DATA < dPerIni
				If !(SPI->PI_STATUS == 'B' .AND. SPI->PI_DTBAIX < dPerIni)
					If (SPI->PI_STATUS == 'B' .AND. SPI->PI_DTBAIX <= dPerFim)
						nValor := SPI->PI_QUANT
						nHrValori := SPI->PI_QUANTV

						If SP9->P9_TIPOCOD $  "1*3"
							If lSexagenal
								nSaldoAnt	:= __TimeSum(nSaldoAnt,nValor)  
								nSaldoAtu 	:= __TimeSub(nSaldoAtu,nValor)
								nSaldAntVl	:= __TimeSum(nSaldAntVl,nHrValori)
								nTotHrVal 	:= __TimeSub(nTotHrVal,nHrValori)
							Else
								nSaldoAnt	:= nSaldoAnt + fConvhR(nValor,"D",,5) 
								nSaldoAtu 	:= nSaldoAtu - fConvhR(nValor,"D",,5) 
								nSaldAntVl	:= nSaldAntVl + fConvhR(nHrValori,"D",,5)
								nTotHrVal 	:= nTotHrVal - fConvhR(nHrValori,"D",,5) 
							EndIf 
						Else
							If lSexagenal
								nSaldoAnt 	:= __TimeSub(nSaldoAnt,nValor)
								nSaldoAtu 	:= __TimeSum(nSaldoAtu,nValor)  
								nSaldAntVl	:= __TimeSub(nSaldAntVl,nHrValori)
								nTotHrVal 	:= __TimeSum(nTotHrVal,nHrValori)  
							Else
								nSaldoAnt	:= nSaldoAnt - fConvhR(nValor,"D",,5)
								nSaldoAtu 	:= nSaldoAtu + fConvhR(nValor,"D",,5)  
								nSaldAntVl	:= nSaldAntVl - fConvhR(nHrValori,"D",,5)
								nTotHrVal 	:= nTotHrVal + fConvhR(nHrValori,"D",,5)  
							EndIf
						EndIf
					Else
						nValor := SPI->PI_QUANT
						nHrValori := SPI->PI_QUANTV

						If SP9->P9_TIPOCOD $  "1*3"
							If lSexagenal
								nSaldoAnt	:= __TimeSum(nSaldoAnt,nValor)
								nSaldAntVl	:= __TimeSum(nSaldAntVl,nHrValori)
							Else
								nSaldoAnt	:= nSaldoAnt + fConvhR(nValor,"D",,5) 
								nSaldAntVl	:= nSaldAntVl + fConvhR(nHrValori,"D",,5) 
							EndIf 
						Else
							If lSexagenal
								nSaldoAnt	:= __TimeSub(nSaldoAnt,nValor)
								nSaldAntVl	:= __TimeSub(nSaldAntVl,nHrValori)
							Else
								nSaldoAnt	:= nSaldoAnt - fConvhR(nValor,"D",,5) 
								nSaldAntVl	:= nSaldAntVl - fConvhR(nHrValori,"D",,5) 
							EndIf
						EndIf
					EndIf
				EndIf
			ElseIf SPI->PI_DATA <= dPerFim
				If !(SPI->PI_STATUS == 'B' .AND. SPI->PI_DTBAIX <= dPerFim)
					If SP9->P9_TIPOCOD $  "1*3"
						nValor := SPI->PI_QUANT
						nHrValori := SPI->PI_QUANTV
						If lSexagenal
							nCredito  := __TimeSum(nCredito,nValor)
							If lImpHrVal
								nTotHrVal := __TimeSum(nTotHrVal,nHrValori)
							EndIf 
						Else
							nCredito  := nCredito + fConvhR(nValor,"D",,5) 
							If lImpHrVal
								nTotHrVal += fConvhR(nHrValori,"D",,5)
							EndIf
						EndIf 
					Else
						nValor		:= SPI->PI_QUANT
						nHrValori	:= SPI->PI_QUANTV
						If lSexagenal
							nDebito   := __TimeSum(nDebito,nValor)  
							If lImpHrVal
								nTotHrVal := __TimeSub(nTotHrVal,nHrValori)
							EndIf
						Else
							nDebito	  := nDebito + fConvhR(nValor,"D",,5) 
							If lImpHrVal
								nTotHrVal -= fConvhR(nHrValori,"D",,5)
							EndIf
						EndIf
					EndIf
				EndIf	
			Else
				Exit
			Endif
			
		dbSelectArea( "SPI" )
		dbSkip()
		
	Enddo
	
	If nSaldoAnt <> 0 .or. nCredito > 0 .or. nDebito > 0
		lRet := .T.
		If lSexagenal
			nSaldoAtu := __TimeSum(nSaldoAtu, __TimeSub( __TimeSum( nSaldoAnt , nCredito ) , nDebito ))
		Else
			nSaldoAtu := ( nSaldoAtu + nSaldoAnt + nCredito ) - nDebito
		EndIf
	EndIf
	
	If lImpHrVal .And. nSaldAntVl <> 0
		If lSexagenal
			nTotHrVal := SomaHoras(nTotHrVal, nSaldAntVl)
		Else
			nTotHrVal := nTotHrVal + nSaldAntVl
		EndIf
	EndIf

	RestArea(aArea)
	
Return lRet

/*/{Protheus.doc} Pnr010Afas
Busca a situacao e afastamentos do funcionario.
@type	function
@author	M. Silveira
@since	09/02/2017
@history 21/03/2019, Cícero Alves, DRHPONTP-3178 - Aloteração para mostrar apenas a situação atual do funcionário e o período correto do afastamento
/*/
Static Function Pnr010Afas( dDtIniP, dDtFimP, aAfast )
	
	Local nX		:= 0
	Local nReg		:= 0
	Local cSitu		:= ""
	Local aAux  	:= {}
	Local aArea 	:= GetArea()
	Local aSitFunc  := RetSituacao( SRA->RA_FILIAL, SRA->RA_MAT, .F., dDtFimP,,,, dDtIniP )
	
	If Len(aSitFunc) > 0
	
		Do Case
			Case aSitFunc[1] == "A"
				cSitu := STR0090 //"AFASTADO"
			Case aSitFunc[1] == "F"
				cSitu := STR0091 //"FERIAS"
			Case aSitFunc[1] == "T"
				cSitu := STR0092 //"TRANSFERIDO"
			Case aSitFunc[1] == "D"
				cSitu := STR0093 //"DEMITIDO"
			OtherWise
				cSitu := STR0094 //"NORMAL"
		EndCase
		
		If aSitFunc[1] $ "A/F"
			
			aAfast	:= {}
			fRetAfas( dDtIniP, dDtFimP,,,,, @aAux )
			nReg := Len(aAux)
			aSort(aAux,,, {|x| x[3] > x[3]}) // Ordena do mais rescente para o mais antigo
			If nReg > 0
				For nX := 1 To nReg
					
					//Considera somente os afastamentos contidos, que começam ou terminam no periodo de apontamento
					If ( dDtIniP >= aAux[nX][3] .And. dDtFimP <= aAux[nX][4] ) .Or.;
						( aAux[nX][4] >= dDtIniP .And. aAux[nX][4] <= dDtFimP ) .Or.;
						( aAux[nX][3] >= dDtIniP .And. aAux[nX][3] <= dDtFimP ) .Or.;
						( Empty(aAux[nX][4])     .And. aAux[nX][3] <= dDtFimP )
						
						// Atualiza a situação para o afastamento que será utilizado.
						Do Case
							Case aAux[nX,5] == "A"
								cSitu := STR0090 //"AFASTADO"
							Case aAux[nX,5] == "F"
								cSitu := STR0091 //"FERIAS"
						EndCase

						// Exibe apenas o afastamento mais recente, para coicidir com a situação atual do funcionário
						aAdd( aAfast, { STR0088 + cSitu + " - " + STR0089 + dToC(aAux[nX][3]) + " a " + dToC(aAux[nX][4]) } ) // "Sit...: "#" Período: "
						EXIT
					EndIf
					
				Next nX
				
				If Empty( aAfast )
					cSitu := STR0094 //"NORMAL"
					aAdd( aAfast, { STR0088 + cSitu } )	
				EndIf
				
			EndIf
		Else
			aAdd( aAfast, { STR0088 + cSitu } )	
		EndIf
		
	EndIf
	
	RestArea( aArea )
	
Return()

/*/{Protheus.doc} SetUpSign
intacia a classe FwTotvsSign e realiza o login no totvs assinatura eletrônica
@type  Static Function
@author Cícero Alves
@since 02/02/2022
@param oSign, Objeto, Instância da classe FwTotvsSign - deve ser passado por referência
@return lRetorno, Lógico, Indica se foi possível criar o objeto e realizar o login
/*/
User Function SetUpSign(oSign)
	
	Local cUser     := AllTrim(GetMv('MV_RHTAEUS', , ""))
	Local cPassword := AllTrim(GetMv('MV_RHTAEPW', , ""))
	Local lRetorno 	:= .T.
	
	If !Empty(cUser) .And. !Empty(cPassword) .And. !("@" $ cUser )
		
		cUser := rc4crypt( cUser, "123456789", .F., .T.)
		cPassword := rc4crypt( cPassword, "123456789", .F., .T.)
		
		If FindFunction("FwTotvsSign")
			If !Empty(SuperGetMv('MV_SIGNURL',, ""))
				oSign := PONXTAE():New()
				oSign:authenticate(cUser, cPassword)
				If !oSign:isAuthenticated()
					// "Não foi possível efetuar autenticação no TAE" - "Verifique os parâmetros MV_SIGNURL, MV_RHTAEUS e MV_RHTAEPW"
					Help( ,, STR0086,, STR0102, 1,,,,,,, {STR0103} )
					lRetorno := .F.
				EndIf
			Else
				//"Não foi possível efetuar autenticação no TAE" - "Verifique os parâmetros MV_SIGNURL, MV_RHTAEUS e MV_RHTAEPW"
				Help( ,, STR0086,, STR0102, 1,,,,,,, {STR0103} ) 
				lRetorno := .F.
			EndIf
		Else
			// "LIB desatualizada" - "Para execução da integração com o Totvs Assinatura Eletrônica é necessário que a LIB esteja atualizada com versão igual ou superior a 02/12/2021"
			Help( ,, STR0086,, STR0104, 1,,,,,,, {STR0105})
			lRetorno := .F.
		EndIf
	Else
		// 'Acesse a opção "Config. Assina. Eletr." na rotina Controle de Espelho de Ponto 
		// para configurar o usuário e senha de integração com o Totvs Assinatura Eletrônica'
		Help( ,, STR0086,, STR0102, 1,,,,,,, {STR0110})
		lRetorno := .F.
	EndIf
	
Return lRetorno

/*/{Protheus.doc} SendEsp
Realiza o envio de um arquivo para o TAE e solicita a assinatura
@type  Static Function
@author Cícero Alves
@since 02/02/2022
@param cPathFile, Caractere, diretório e nome do arquivo que será enviado
@param cNameFile, Caractere, Nome do arquivo enviado para o TAE
@return lretorno, Lógico, Indica se o arquivo foi enviado com sucesso
/*/
Static Function SendEsp(cPathFile, cNameFile)
	Local lretorno 	:= .T.
	local nId		:= 0
	Local cMsg		:= ""
	Local cRespBck	:= ""
	Local aResp		:= {}
	
	Default cPathFile := ""
	Default cNameFile := ""
	
	lOk := oSign:uploadDocument( cPathFile )
	jResponse := oSign:getResponse()
	
	If lOk
		nId := jResponse["data"]
		
		aResp := oSign:NotifFunc(cValToChar(nId), lMRHTae, nTpNotTae)

		If aResp[1]
			// // "Solicitação enviada"
			If nTpNotTae == 2 .And. lMRHTae
				aAdd(aLogTAE[1], SRA->RA_FILIAL + " - " + SRA->RA_MAT + ": " + STR0123) // "A notificação foi enviada para o celular do colaborador."
			Else
				aAdd(aLogTAE[1], SRA->RA_FILIAL + " - " + SRA->RA_MAT + ": " + STR0109 + AllTrim(SRA->RA_EMAIL))
			EndIf

			If Empty(aLogTitle[1])
				aLogTitle[1] := STR0106 // "Espelhos de Ponto enviados: "
			EndIf
		Else
			// Se falhou o envio e é por WhatsApp tenta enviar por e-mail
			If nTpNotTae == 2 .And. lMRHTae
				cRespBck := aResp[2]

				aResp := oSign:NotifFunc(cValToChar(nId), lMRHTae, 1)

				If aResp[1]
					// // "Solicitação enviada"
					aAdd(aLogTAE[1], SRA->RA_FILIAL + " - " + SRA->RA_MAT + ": " + cRespBck)
					aAdd(aLogTAE[1], SRA->RA_FILIAL + " - " + SRA->RA_MAT + ": " + STR0109 + AllTrim(SRA->RA_EMAIL))

					If Empty(aLogTitle[1])
						aLogTitle[1] := STR0106 // "Espelhos de Ponto enviados: "
					EndIf
				Else
					aAdd(aLogTAE[2], SRA->RA_FILIAL + " - " + SRA->RA_MAT + ": " + cRespBck)
					
					If (cRespBck <> aResp[2], aAdd(aLogTAE[2], SRA->RA_FILIAL + " - " + SRA->RA_MAT + ": " + aResp[2]), Nil)

					If Empty(aLogTitle[2])
						aLogTitle[2] := STR0107	//"Espelhos de Ponto não enviados:"
					EndIf
				EndIf
			Else	
				aAdd(aLogTAE[2], SRA->RA_FILIAL + " - " + SRA->RA_MAT + ": " + aResp[2])

				If Empty(aLogTitle[2])
					aLogTitle[2] := STR0107	//"Espelhos de Ponto não enviados:"
				EndIf
			EndIf
		EndIf
		
		// Atualiza a tabela RS4
		GravaSR4( cNameFile, nId )
	Else
		
		cMsg := oSign:GetTypeErro403()
		cMsg := If(cMsg == "1", STR0114 + STR0121, "") // "O arquivo foi bloqueado pelo firewall do servidor onde o TAE está hospedado."
		
		If Empty(cMsg)
			cMsg := If(jResponse[ "description" ] != NIL, jResponse[ "description" ], STR0114 + STR0120) //"Não foi possível realizar o upload do arquivo para o TAE. Verifique se o usuário utilizado para a integração possui permissão para enviar arquivos."
		EndIf
		
		aAdd(aLogTAE[2], SRA->RA_FILIAL + " - " + SRA->RA_MAT + ": " + cMsg)
		
		If Empty(aLogTitle[2])
			aLogTitle[2] := STR0107	//"Espelhos de Ponto não enviados:"
		EndIf
	EndIf
	
Return lretorno

/*/{Protheus.doc} GravaSR4
Grava na tabela SR4 o controle dos arquivos gerados com código de barras ou que foram enviados para o TAE
@type  Static Function
@author Cícero Alves
@since 23/02/2022
@param cNomeDoc, Caractere, Nome do arquivo
@param cID, Caractere, ID do arquivo no TAE
/*/
Static Function GravaSR4(cNomeDoc, cID)
	
	Local aRS4Area	:= GetArea()
	Local lAtualiza	:= .F.
	Local cPerIni	:= DtoS(dPerIni)
	Local cPerFim	:= DtoS(dPerFim)
	Local cFilRS4	:= xFilial("RS4", SRA->RA_FILIAL)
	Local lCpoRS4	:= RS4->(ColumnPos("RS4_TPDOC")) > 0
	Local lOk		:= .F.
	
	Static lAtuTae	:= .T.
	
	Default cNomeDoc := ""
	Default cID := 0
	
	If lAtuTae .And. lTAE .And. lCpoRS4
		fStatusTAE(cFilRS4, SRA->RA_MAT, .F., @oSign) // Atualiza o status dos documentos na RS4
		lAtuTae := .F.
	EndIf
	
	If RS4->( dbSeek(cFilRS4 + SRA->RA_MAT + cPerIni + cPerFim ))
		While RS4->(RS4_FILIAL + RS4_MAT + RS4_PER) == SRA->(RA_FILIAL + RA_MAT + cPerIni + cPerFim)
			If RS4->RS4_STATUS == "2" //Pendente
				
				If !lCpoRS4 .Or. (lCpoRS4 .And. RS4->RS4_TPDOC == "2")
					lAtualiza := .T.
					EXIT
				ElseIf lTAE .And. lCpoRS4 .And. RS4->RS4_TPDOC == "1"
					// Verifica o Status do documento no TAE
					lOk := oSign:documentStatus(RS4->RS4_ID)
					jResponse := oSign:getResponse()
					If lOk .And. jResponse["data"]["status"] == 0 // Rascunho
						If oSign:deleteDocument(RS4->RS4_ID) // Exclui o documento
							lAtualiza := .T.
							EXIT
						EndIf
					EndIf
				EndIf
			EndIf
			RS4->(dbSkip())
		EndDo
	EndIf
	
	RecLock("RS4", !lAtualiza)
		RS4->RS4_FILIAL := SRA->RA_FILIAL
		RS4->RS4_MAT	:= SRA->RA_MAT
		RS4->RS4_PER	:= cPerIni + cPerFim 
		RS4->RS4_DATAI	:= dPerIni
		RS4->RS4_DATAF	:= dPerFim
		RS4->RS4_CODEBA	:= cCodeBar
		RS4->RS4_STATUS	:= "2" //Pendente
		If lCpoRS4
			RS4->RS4_TPDOC	:= If(lTAE, "1", "2")
			If lTAE
				RS4->RS4_NDOC	:= cNomeDoc
				RS4->RS4_ID		:= cId
				RS4->RS4_DTINTE	:= Date()
			EndIf
		EndIf
	MsUnLock()
	
	RestArea(aRS4Area)
	
Return

/*/{Protheus.doc} GetHorarios
Retorna os horários previstos para o funcionário de acordo com o calendário
@type Static Function
@author Cícero Alves
@since 27/06/2022
@return aHorarios, Array, Array com a data, turno e horários
/*/
Static Function GetHorarios()
	
	Local aHorarios := {}
	Local nI		:= 0
	Local cOrdem	:= ""
	Local aAux		:= {}
	Local nSum		:= 0
	Local aLastAux	:= {}
	Local dDataAlt	:= cTod("//")
	
	For nI := 1 To Len(aTabCalend)
		
		nSum := 0
		aAux := {}
		cOrdem := aTabCalend[nI][CALEND_POS_ORDEM]
		dDataAlt := aTabCalend[nI][CALEND_POS_DATA]
		
		While nI <= Len(aTabCalend) .And. aTabCalend[nI][CALEND_POS_ORDEM] == cOrdem
			Aadd(aAux, aTabCalend[nI][CALEND_POS_HORA])
			nSum += aTabCalend[nI][CALEND_POS_HORA]
			nI++
		EndDo
		
		//Retorna para a sequência anterior
		nI--
		
		//Se tiver horário cadastrado para o dia e for diferente do horário anterior
		If nSum > 0  .And. !ArrayCompare( aAux, aLastAux)
			aLastAux := aAux
			
			Aadd(aHorarios, {})
			Aadd(aTail(aHorarios), dDataAlt)
			Aadd(aTail(aHorarios), aTabCalend[nI][CALEND_POS_TURNO] + " - " + fDescTno( SRA->RA_FILIAL, aTabCalend[nI][CALEND_POS_TURNO]))
			Aadd(aTail(aHorarios), aAux)
			
		EndIf
	Next nI
	
Return aHorarios

/*/{Protheus.doc} fQuebra
Realiza a quebra de página no relatório
@type  Static Function
@author Cícero Alves
@since 06/10/2022
/*/
Static Function fQuebra(oPrinter, nTamLin, nColunas,  lTerminal)
	
	fImpSign(oPrinter)
	oPrinter:EndPage()
	oPrinter:StartPage()
	Imp_Cabec( nTamLin, nColunas,  lTerminal, 0, oPrinter )
	
Return 

/*/{Protheus.doc} GetMarcDes
Carrega as marcações desconsideradas no aMarcDes e as excluí do aMarcacoes
@type  Static Function
@author Cícero Alves
@since 06/10/2022
/*/
Static Function GetMarcDes(aMarcacoes, aMarcDes)
	
	Local nI := 1
	Local nNewTam := Len(aMarcacoes)
	
	While nI <= nNewTam
		If aMarcacoes[nI, 27] == "D"
			aAdd(aMarcDes, {aMarcacoes[nI, 1], StrTran(StrZero(aMarcacoes[nI,2],5,2),'.',':'), aMarcacoes[nI, 29]})
			aDel(aMarcacoes, nI)
			nNewTam--
		Else
			nI++
		EndIf
	EndDo
	
	aSize(aMarcacoes, nNewTam)
	
Return
