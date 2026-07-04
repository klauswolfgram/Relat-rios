/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "mdtr700.ch"
#Include "Protheus.ch"
#Include "FWPrintSetup.ch"
#include "ap5mail.ch"
#INCLUDE "RPTDEF.CH"

Static nLimite_Dias_Epi
Static nDiaAntAdm
Static __cArqTab
Static cQryVlCC

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR700

Perfil Profissiografico Previdenciario  -  P.P.P.

@author Denis Hyroshi de Souza
@since 21/10/2002
/*/
//---------------------------------------------------------------------
User Function MDTR700()

	Local aNGBEGINPRM := NGBEGINPRM() // Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local nTamMvPar09 := 0

	// Inicializa constante.
	nLimite_Dias_Epi := 0
	nDiaAntAdm       := U_MDT700MES() // Mes Antes Admissao (De 1 ate 12 meses)
	__cArqTab        := cArqTab

	Private titulo   := STR0006 // "Perfil Profissiografico Previdenciario"
	Private cPerg
	Private cabec1, cabec2
	Private cEmpPPP 	:= cEmpAnt
	Private nSizeSI3 	:= IIf( ( TAMSX3( "I3_CUSTO" )[1] ) < 1, 9, ( TAMSX3( "I3_CUSTO" )[1] ) )
	Private nSizeSRJ 	:= IIf( ( TAMSX3( "RJ_FUNCAO" )[1] ) < 1, 5, ( TAMSX3( "RJ_FUNCAO" )[1] ) )
	Private nSizeTN5 	:= IIf( ( TAMSX3( "TN5_CODTAR" )[1] ) < 1, 6, ( TAMSX3( "TN5_CODTAR" )[1] ) )
	Private nSizeSQB 	:= IIf( ( TAMSX3( "QB_DEPTO" )[1] ) < 1, 6, ( TAMSX3( "QB_DEPTO" )[1] ) )
	Private nSizeTD 	:= 6
	Private lNGMDTPS 	:= .F.
	Private lSigaMdtps 	:= .F.
	Private lEpiCompl  	:= .F.  // Indica se a empresa utiliza EPI em carater complementar, mesmo quando o EPC for eficaz.
	Private lMV_PPPRISC := .F.
	Private nTamanRES 	:= 6
	Private lNG2M400  	:= .F.
	Private lMudEmpr  	:= .F.
	Private lMudFilial 	:= .T.
	Private lTrocaDes  	:= .F.
	Private nTamTable  	:= Len( cArqTab )
	Private cSvFilAnt  	:= cFilAnt	// Salva a Filial Corrente
	Private cSvEmpAnt  	:= cEmpAnt	// Salva a Empresa Corrente
	Private aSM0Area   	:= SM0->(GetArea())
	Private cModo      	:= " "
	Private lCposTNX 	:= .T.
	Private lParEnd    	:= .T.
	Private lConsEPC   	:= .T.
	Private lConsEPI   	:= 2 // Consiste Automaticamente
	Private nOpca      	:= 0
	Private cCliMdtPs
	Private aRespLaudo 	:= {}
	Private cStartPath := AllTrim( GetSrvProfString( "StartPath", "\" ) ) // Caminho do logoppp.bmp

	// Variaveis utilizadas para envio de email do relatorio
	Private aUsuario  := "", cTitulo, oDlgMail, cDiretorio:="", x:=1, cBody:=""
	Private cServer   := AllTrim( GetMV( "MV_RELSERV", , " " ) )
	Private cAccount  := AllTrim( GetMV( "MV_RELACNT", , " " ) )
	Private cPassword := AllTrim( GetMV( "MV_RELPSW", , " " ) )
	Private cUserAut  := AllTrim( GetMV( "MV_RELAUSR", , cAccount ) )//Usuário para Autenticação no Servidor de Email
	Private cPassAut  := AllTrim( GetMV( "MV_RELAPSW", , cPassword ) )//Senha para Autenticação no Servidor de Email
	Private lSmtpAuth := GetMv( "MV_RELAUTH", , .F. )
	Private cFrom     := cAccount
	Private cAnexos   := ""
	Private cTo       := Space( 200 )
	Private cCC       := Space( 200 )
	Private cSubject  := Space( 250 )
	Private lOk       := .T.
	Private lAutOk    := .F.
	Private aFiles    := {} // Array que irá conter todas as páginas geradas
	Private cSRisc    := " "
	Private lRespFim  := .T.
	Private cAlias    := "CTT"
	Private cDescr    := "CTT->CTT_DESC01"
	Private cF3CC     := "CTT"
	Private nSizeCC   := IIf( ( TAMSX3( "CTT_CUSTO" )[1] ) < 1, 9, ( TAMSX3( "CTT_CUSTO" )[1] ) )

	//Variaveis relacionadas a pergunta Representante Empresa?
	Private cNumSX1 	:= IIf( lSigaMDTPs, "13", "09" )
	Private cAliasRES 	:= "SRA" //Representante Funcionario
	Private cCNomeRES 	:= "SRA->RA_NOME"
	Private cCpfRes 	:= 'SRA->RA_CIC'
	Private cValRES		:= "ExCpoMDT('SRA',mv_par" + cNumSX1 + ")" //Valid da Consulta
	Private cRetF3		:= ""
	Private cMdtGenFun	:= "U_MDT700SXB()"
	Private cMdtGenRet	:= "U_MDT700RSXB()"
	Private cFilRES     :=  xFilial( "SRA" )

	If AMiIn( 35 )

		U_SX6PPPRES() //Verifica conteudo do parametro MV_MDTRESP

		// Recolhimento informacoes sobre parametros que impactam o PPP

		//Texto a ser impresso no PPP, caso o funcionario nao esteja exposto a nenhum risco.
		cSRisc := SuperGetMv( "MV_NG2SRIS", .F., "" )

		//Indica se o cliente e um prestador de servico de medicina S-SIM N-NAO
		lNGMDTPS := SuperGetMv( "MV_NGMDTPS", .F., "N" ) == "S"

		//Indica se o cliente e um prestador de servico de medicina. S-SIM N-NAO
		lSigaMdtPS := SuperGetMv( "MV_MDTPS", .F., "N" ) == "S"

		//Indica se a empresa utiliza EPI em carater complementar, mesmo quando o EPC for eficaz. S=Sim ou N=Nao
		lEpiCompl  := SuperGetMv( "MV_NG2KEPI", .F., "N" ) == "S"

		//Indica se a descricao das atividades do cargo tera todo o seu conteudo impresso no PPP ou apenas sera impresso os 400 primeiros caracteres. S=Sim;N=Nao
		lNG2M400 := SuperGetMv( "MV_NG2M400", .F., "N" ) == "S"

		//Indica se deve ser exibido na impressao do PPP do funcionario, o historico em todas as empresas em que trabalhou.  S=Sim;N=Nao
		lMudEmpr := SuperGetMv( "MV_NG2MEMP", .F., "N" ) == "S"

		//Indica se deve ser exibido na impressao do PPP do funcionario, o historico em todas as filiais em que trabalhou.  S=Sim;N=Nao
		lMudFilial := SuperGetMv( "MV_NG2MFIL", .F., "N" ) == "S"

		//Indica se deve ser trocado na impressao do PPP o conteudo da coluna do Cargo com a coluna da Funcao S=Sim;N=Nao
		lTrocaDes := SuperGetMv( "MV_NG2INVE", .F., "N" ) == "S"

		//Nos relatorios de Folha de Pagto deseja imprimir Endereco de Cobranca ou Endereco Fiscal? C = Cobranca ou F = Fiscal
		lParEnd := SuperGetMv( "MV_PAREND", .F., "C" ) == "C"

		//Indica se a empresa consiste o EPC S=Sim, N=Nao
		lConsEPC := SuperGetMv( "MV_NG2CEPC", .F., "N" ) == "S"

		//Indica se a empresa consiste o EPI S=Sim, N=Nao
		lConsEPI := SuperGetMv( "MV_NG2CEPI", .F., "N" ) == "N"

		//Indica quais datas serao consideradas na impressao das secoes do P.P.P. 1 - Responsaveis; 2 - Funcionarios
		lRespFim  := SuperGetMv( "MV_MDTDTFI", .F., "1" ) == "1"

		//Indica se o relatorio PPP listara somente funcionarios expostos a riscos ambientais. S=SIM / N=NAO
		lMV_PPPRISC := SuperGetMv( "MV_PPPRISC", .F., "N" ) == "S"

		//Quantidade de dias de tolerancia que o funcionario podera ficar sem receber o EPI, a partir do inicio de exposicao a um agente de risco.
		nLimite_Dias_Epi := SuperGetMv( "MV_PPPDTRI", .F., 30 )

		If lNGMDTPS
			lCposTNX := .F.
		EndIf

		cPerg := PADR( "MDT700", 10 )

		/* Perguntas
		MDT700    ¦01      ¦De Matricula ?
		MDT700    ¦02      ¦Ate Matricula ?
		MDT700    ¦03      ¦De Centro de Custo ?
		MDT700    ¦04      ¦Ate Centro de Custo ?
		MDT700    ¦05      ¦De Funcao ?
		MDT700    ¦06      ¦Ate Funcao ?
		MDT700    ¦07      ¦Considerar Risco ?
		MDT700    ¦08      ¦Desc. das Atividad.?
		MDT700    ¦09      ¦Representante Empresa ?
		MDT700    ¦10      ¦Comprovante de Entrega ?
		MDT700    ¦11      ¦Termo Responsab. ?
		MDT700    ¦12      ¦Somente a partir JAN/2004 ?
		MDT700    ¦13      ¦Tipo de Impressao ?
		MDT700    ¦14      ¦Observacao ?
		MDT700    ¦15      ¦Exames Complementares ?
		MDT700    ¦16      ¦Imprime Resultados de Exames ?
		MDT700    ¦17      ¦Exames NR7 ?
		MDT700    ¦18      ¦Situacao Funcionario ?
		MDT700    ¦19      ¦De Data Demissao ?
		MDT700    ¦20      ¦Ate Data Demissao ?
		MDT700    ¦21      ¦Data Emissao PPP ?
		MDT700    ¦22      ¦Informe a Data ?
		MDT700    ¦23      ¦Listar Observ. Epis ?
		MDT700    ¦24      ¦Observacao EPI \ EPC. ?
		MDT700    ¦25      ¦Imagem PPP enviada p. e-mail ?
		MDT700    ¦26      ¦Ordenar nomes por ?
		MDT700    ¦27      ¦Imp. Resp. Monit. Biologica ?
		MDT700    ¦28      ¦Funcao
		MDT700    ¦29      ¦Considerar SESMT?
		MDT700    ¦30      ¦Desagrupa datas ?
		MDT700    ¦31      ¦Responsável Ambiental ?
		MDT700    ¦32      ¦Filtrar SESMT?
		MDT700    ¦33      ¦Imp. Título Atividade ?
		MDT700    ¦34      ¦Desc. da Lotação ?
		*/

		If lSigaMdtps
			cCliMdtPs := "Z"

			/* Perguntas
			MDT700PS    ¦01      ¦De Cliente ?
			MDT700PS    ¦02      ¦Loja
			MDT700PS    ¦03      ¦Até Cliente ?
			MDT700PS    ¦04      ¦Loja
			MDT700PS    ¦05      ¦De Matricula ?
			MDT700PS    ¦06      ¦Ate Matricula ?
			MDT700PS    ¦07      ¦De Centro de Custo ?
			MDT700PS    ¦08      ¦Ate Centro de Custo ?
			MDT700PS    ¦09      ¦De Funcao ?
			MDT700PS    ¦10      ¦Ate Funcao ?
			MDT700PS    ¦11      ¦Considerar Risco ?
			MDT700PS    ¦12      ¦Desc. das Atividad.?
			MDT700PS    ¦13      ¦Representante Empresa ?
			MDT700PS    ¦14      ¦Comprovante de Entrega ?
			MDT700PS    ¦15      ¦Termo Responsab. ?
			MDT700PS    ¦16      ¦Somente a partir JAN/2004 ?
			MDT700PS    ¦17      ¦Tipo de Impressao ?
			MDT700PS    ¦18      ¦Observacao ?
			MDT700PS    ¦19      ¦Exames Complementares ?
			MDT700PS    ¦20      ¦Imprime Resultados de Exames ?
			MDT700PS    ¦21      ¦Exames NR7 ?
			MDT700PS    ¦22      ¦Situacao Funcionario ?
			MDT700PS    ¦23      ¦De Data Demissao ?
			MDT700PS    ¦24      ¦Ate Data Demissao ?
			MDT700PS    ¦25      ¦Data Emissao PPP ?
			MDT700PS    ¦26      ¦Informe a Data ?
			MDT700PS    ¦27      ¦Listar Observ. Epis ?
			MDT700PS    ¦28      ¦Observacao EPI \ EPC. ?
			MDT700PS    ¦29      ¦Imagem PPP enviada p. e-mail ?
			MDT700PS    ¦30      ¦Ordenar nomes por ?
			MDT700PS    ¦31      ¦Imp. Resp. Monit. Biologica ?
			MDT700PS    ¦32      ¦Funcao
			MDT700PS    ¦33      ¦Considerar SESMT?
			MDT700PS    ¦34      ¦Desagrupa datas ?
			MDT700PS    ¦35      ¦Responsável Ambiental ?
			MDT700PS    ¦36      ¦Filtrar SESMT?
			MDT700PS    ¦37      ¦Imp. Título Atividade ?
			*/

			cPerg    :=  PADR( "MDT700PS", 10 )
		EndIf

		nProcessa := 1

		If Pergunte( cPerg, .T. )

			// Mapeamento das perguntas comuns às empresas "Prestadoras de Serviço" e às empresas "Não-Prestadoras de Serviço"
			// As variáveis mv_par01 até mv_par04 só devem ser usadas em "Prestadoras de Serviço"
			If lSigaMdtps
				xm_par01 := mv_par05
				xm_par02 := mv_par06
				xm_par03 := mv_par07
				xm_par04 := mv_par08
				xm_par05 := mv_par09
				xm_par06 := mv_par10
				xm_par07 := mv_par11
				xm_par08 := mv_par12
				xm_par09 := mv_par13
				xm_par10 := mv_par14
				xm_par11 := mv_par15
				xm_par12 := mv_par16
				xm_par13 := mv_par17
				xm_par14 := mv_par18
				xm_par15 := mv_par19
				xm_par16 := mv_par20
				xm_par17 := mv_par21
				xm_par18 := mv_par22
				xm_par19 := mv_par23
				xm_par20 := mv_par24
				xm_par21 := mv_par25
				xm_par22 := mv_par26
				xm_par23 := mv_par27
				xm_par24 := mv_par28
				xm_par25 := mv_par29
				xm_par26 := mv_par30
				xm_par27 := mv_par31
				xm_par28 := mv_par32
				xm_par29 := mv_par33
				xm_par30 := mv_par34
				xm_par31 := mv_par35
				xm_par32 := mv_par36
				xm_par33 := mv_par37
				xm_par34 := 1
				xm_par35 := 2
			Else
				xm_par01 := mv_par01
				xm_par02 := mv_par02
				xm_par03 := mv_par03
				xm_par04 := mv_par04
				xm_par05 := mv_par05
				xm_par06 := mv_par06
				xm_par07 := mv_par07
				xm_par08 := mv_par08
				xm_par09 := mv_par09
				xm_par10 := mv_par10
				xm_par11 := mv_par11
				xm_par12 := mv_par12
				xm_par13 := mv_par13
				xm_par14 := mv_par14
				xm_par15 := mv_par15
				xm_par16 := mv_par16
				xm_par17 := mv_par17
				xm_par18 := mv_par18
				xm_par19 := mv_par19
				xm_par20 := mv_par20
				xm_par21 := mv_par21
				xm_par22 := mv_par22
				xm_par23 := mv_par23
				xm_par24 := mv_par24
				xm_par25 := mv_par25
				xm_par26 := mv_par26
				xm_par27 := mv_par27
				xm_par28 := mv_par28
				xm_par29 := mv_par29
				xm_par30 := mv_par30
				xm_par31 := mv_par31
				xm_par32 := mv_par32
				xm_par33 := mv_par33
				xm_par34 := mv_par34
				xm_par35 := mv_par35
				xm_par36 := mv_par36
			EndIf

			// Define o tamanho correto da informação de acordo com o tipo de representante, funcionario ou usuario
			If Alltrim( GetMV( "MV_MDTRESP" ) ) == "1"
				nTamMvPar09 := TAMSX3( "RA_MAT" )[1]
			Else
				nTamMvPar09 := TAMSX3( "TMK_CODUSU" )[1]
			EndIf

			xm_par09 := SubStr( xm_par09, 1, nTamMvPar09 )

			If xm_par13 != 1 // Impressão via e-mail
				nProcessa := U_PPPCONFMAIL()
			EndIf

			If nProcessa == 1
				Processa( { |lEnd| R700Imp() } ) // MONTE TELA PARA ACOMPANHAMENTO DO PROCESSO.
			EndIf

		EndIf

		cArqTab := __cArqTab    // Devolve o valor original por Variavel Estatica

		cFilAnt := cSvFilAnt

		dbSelectArea( "SM0" )
		dbSeek( cSvEmpAnt + cSvFilAnt )

		NGRETURNPRM( aNGBEGINPRM ) // Devolve variaveis armazenadas (NGRIGHTCLICK)

	EndIf

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} R700Imp

Chamada do relatório

@author Denis Hyroshi de Souza
@since 21/10/2002

@param lEnd, Logico - Controle de Encerramento do Relatório
@param wnRel, Caracter - Arquivo de saida do relatorio
@param titulo, Caracter	- Titulo do relatorio
@param tamanho, Caracter - Tamanho do relatorio

@return Logico, .F. se a geração do relatorio foi cancelada
/*/
//---------------------------------------------------------------------
Static Function R700Imp( lEnd, wnRel, titulo, tamanho )

	Local nRecnoSRA

	Local aDBF := {}

	Local aTamCpo   := TamSX3( "TN0_QTAGEN" )
	Local nSizeCod  := IIf( ( TAMSX3( "B1_COD" )[1] ) < 1, 15, ( TAMSX3( "B1_COD" )[1] ) )
	Local nTamExa   := IIf( TAMSX3( "TM4_EXAME" )[1] < 1, 6, TAMSX3( "TM4_EXAME" )[1] )
	Local oTempTN0, oTempPPP, oTempTMK, oTempTNF
	Local lRet 	    := .T.
	Local lImpMsgPPP:= .F.
	Local lExistReg := .F.
	Local cBarraRem := "\"

	Private cPathEst := Alltrim( GetMv( "MV_DIREST" ) ) // PATH DO ARQUIVO A SER ARMAZENADO NA ESTACAO DE TRABALHOZ
	Private nSizeFil := IIf( lMudEmpr, NGMTAMFIL(), FwSizeFilial() )

	Private aVETINR   := {} // Usado pela funcao que cria arq. temporario
	Private aTM5Combo := U_PPPMDTCbox( "TM5_NATEXA", " ", 1 )
	Private aTMBCombo := U_PPPMDTCbox( "TMB_MATBIO", " ", 1 )
	Private aTMACombo := U_PPPMDTCbox( "TMA_GRISCO", " ", 1 )
	Private aTN0Combo := U_PPPMDTCbox( "TN0_EPC", " ", 1 )

	Private dDtDemiss  := CToD( "//" )
	Private dDtAdmiss  := CToD( "//" )
	Private dDatacorte := SuperGetMv( "MV_NG2PPPD", .F., CtoD( "" ) )

	Private lDemitido

	Private lin := 0
	Private nLin2 := 0
	Private nPaginaPPP := 0
	Private cFonte := "Verdana"
	Private oPrintPPP

	Private oFont07_ 	:= TFont():New( cFonte, Nil, 10, Nil, .F., Nil, Nil, Nil, .F., .F. )
	Private oFont07  	:= TFont():New( cFonte, Nil, 12, Nil, .F., Nil, Nil, Nil, .F., .F. )
	Private oFont08  	:= TFont():New( cFonte, Nil, 12, Nil, .F., Nil, Nil, Nil, .F., .F. )
	Private oFont09  	:= TFont():New( cFonte, Nil, 11, Nil, .F., Nil, Nil, Nil, .F., .F. )
	Private oFont09n 	:= TFont():New( cFonte, Nil, 12, Nil, .T., Nil, Nil, Nil, .F., .F. ) // Títulos das seções 1 ~ 11 e 13.1, 13.2, 14.1 ...
	Private oFont08_ 	:= TFont():New( cFonte, Nil, 11, Nil, .T., Nil, Nil, Nil, .F., .F. )
	Private oFont10  	:= TFont():New( cFonte, Nil, 11, Nil, .F., Nil, Nil, Nil, .F., .F. )
	Private oFont11  	:= TFont():New( cFonte, Nil, 12, Nil, .F., Nil, Nil, Nil, .F., .F. )
	Private oFont13  	:= TFont():New( cFonte, Nil, 16, Nil, .T., Nil, Nil, Nil, .F., .F. )
	Private oFonte14N	:= TFont():New( cFonte, Nil, 14, Nil, .T., Nil, Nil, Nil, .F., .F. )

	// Criação das alias de TRB
	Private cTRBPPP := GetNextAlias()
	Private cTRBTN0 := GetNextAlias()
	Private cTRBTMK := GetNextAlias()
	Private cTRBTNF := GetNextAlias()
	Private cTRBSRA := GetNextAlias()

	If xm_par13 != 1 // Impressão via e-mail

		If GetRemoteType() == 2  //estacao com sistema operacional unix
			cBarraRem := "/"
		Endif

		cPathEst += IIf( Substr( cPathEst, Len( cPathEst ), 1 ) != cBarraRem, cBarraRem, "" )
		//Cria diretorio se nao existir
		MontaDir( cPathEst )
		//Força a geração de PDF para envio no e-mail
		oPrintPPP := FwMsPrinter():New( OemToAnsi( STR0006 ), IMP_PDF, , , .T. ) //"Perfil Profissiografico Previdenciario"
		oPrintPPP:cPathPDF := cPathEst //Salva o arquivo na Estação de Trabalho
		oPrintPPP:nModalResult := 1 //Garante a "confirmação da tela"
		oPrintPPP:lViewPDF := .F. //Indica que não visualizará o PDF após a impressão
	Else
		oPrintPPP := FwMsPrinter():New( OemToAnsi( STR0006 ) ) // "Perfil Profissiografico Previdenciario"
	EndIf

	// Se a geração do relatorio for cancelada
	If oPrintPPP:nModalResult != PD_OK
		lRet := .F.
	ElseIf oPrintPPP:GetOrientation() == 1 //Caso o tipo de impressão for igual a 'Retrato'
		Help( ' ', 1, STR0262, , STR0322, 2, 0, , , , , , { STR0323 } ) //"O tipo de impressão 'Retrato' não está disponível para o PPP"##"Favor selecionar o tipo de impressão 'Paisagem'"
		lRet := .F.
	Else
		oPrintPPP:SetLandscape() // Paisagem
		oPrintPPP:SetMargin( 30, 30, 30, 30 )
		oPrintPPP:setPaperSize( 9 ) // A4

		If aTamCpo[1] < 12
			nQTAGENt := 12
		Else
			nQTAGENt := aTamCpo[1]
		Endif

		nQTAGENd := aTamCpo[2]
		cQTAGtra := "@E "+Replicate( "9", nQTAGENt - nQTAGENd - 1 ) + "." + Replicate( "9", nQTAGENd )

		// TRBTN0
		aAdd( aDBF, { "NUMRIS", "C", 09, 0 } )
		aAdd( aDBF, { "CODAGE", "C", 06, 0 } )
		aAdd( aDBF, { "AGENTE", "C", 40, 0 } )
		aAdd( aDBF, { "MAT", "C", TamSx3( 'RA_MAT' )[ 1 ], 0 } )
		aAdd( aDBF, { "DT_DE", "D", 08, 0 } )
		aAdd( aDBF, { "DT_ATE", "D", 08, 0 } )
		aAdd( aDBF, { "SETOR", "C", nSizeSI3, 0 } )
		aAdd( aDBF, { "FUNCAO", "C", nSizeSRJ, 0 } )
		aAdd( aDBF, { "TAREFA", "C", 06, 0 } )
		aAdd( aDBF, { "DEPTO", "C", nSizeSQB, 0 } )
		aAdd( aDBF, { "INTENS", "N", nQTAGENt, nQTAGENd } )
		aAdd( aDBF, { "UNIDAD", "C", 100, 0 } )
		aAdd( aDBF, { "TECNIC", "C", 40, 0 } )
		aAdd( aDBF, { "PROTEC", "C", 02, 0 } )
		aAdd( aDBF, { "EPC", "C", 01, 0 } )
		aAdd( aDBF, { "GRISCO", "C", 01, 0 } )
		aAdd( aDBF, { "NUMCAP", "C", 12, 0 } )
		aAdd( aDBF, { "INDEXP", "C", 01, 0 } )
		aAdd( aDBF, { "ATIVO", "C", 01, 0 } )
		aAdd( aDBF, { "OBSINT", "C", 20, 0 } )
		aAdd( aDBF, { "CODEPI", "C", nSizeCod, 0 } )
		aAdd( aDBF, { "AVALIA", "C", 01, 0 } )
		aAdd( aDBF, { "NECEPI", "C", 01, 0 } )
		aAdd( aDBF, { "MEDCON", "C", 06, 0 } )
		aAdd( aDBF, { "TIPCTR", "C", 01, 0 } )
		aAdd( aDBF, { "PRZTNF", "C", 01, 0 } )
		aAdd( aDBF, { "PRZDUR", "C", 01, 0 } )
		aAdd( aDBF, { "HIGIEN", "C", 01, 0 } )

		oTempTN0 := FWTemporaryTable():New( cTRBTN0, aDBF )
		oTempTN0:AddIndex( "1", { "DT_DE", "DT_ATE", "NUMRIS" } )
		oTempTN0:AddIndex( "2", { "GRISCO", "AGENTE", "INTENS", "TECNIC", "EPC", "PROTEC", "CODEPI", "NUMCAP" } )
		oTempTN0:AddIndex( "3", { "GRISCO", "AGENTE", "INTENS", "TECNIC", "DT_DE", "DT_ATE" } )
		oTempTN0:Create()

		// TRBPPP
		aDBF := {}
		aAdd( aDBF, { "DTDE", "D", 8, 0 } )
		aAdd( aDBF, { "DTATE", "D", 8, 0 } )
		aAdd( aDBF, { "CNPJ", "C", 20, 0 } )
		aAdd( aDBF, { "SEQ", "C", 01, 0 } )
		aAdd( aDBF, { "TIPINS", "N", 01, 0 } )
		aAdd( aDBF, { "CUSTO", "C", nSizeSI3, 0 } )
		aAdd( aDBF, { "DEPTO", "C", nSizeSQB, 0 } )
		aAdd( aDBF, { "FILIAL", "C", nSizeFil, 0 } )
		aAdd( aDBF, { "MAT", "C", TamSx3( 'RA_MAT' )[ 1 ], 0 } )
		aAdd( aDBF, { "CARGO", "C", 5, 0 } )
		aAdd( aDBF, { "CODFUN", "C", nSizeSRJ, 0 } )
		aAdd( aDBF, { "DESFUN", "C", 30, 0 } )
		aAdd( aDBF, { "DESCAR", "C", 30, 0 } )
		aAdd( aDBF, { "GFIP", "C", 2, 0 } )
		aAdd( aDBF, { "EMP", "C", 2, 0 } )

		oTempPPP := FWTemporaryTable():New( cTRBPPP, aDBF )
		oTempPPP:AddIndex( '1', { 'DTDE', 'DTATE', 'CNPJ' } )
		oTempPPP:Create()

		// TRBTMK
		aDBF := {}
		aAdd( aDBF, { "DTINI", "D", 08, 0 } )
		aAdd( aDBF, { "DTFIM", "D", 08, 0 } )
		aAdd( aDBF, { "FILIAL", "C", nSizeFil, 0 } )
		aAdd( aDBF, { "CODIGO", "C", 12, 0 } )
		aAdd( aDBF, { "NOME", "C", TAMSX3( "TMK_NOMUSU" )[1], 0 } )
		aAdd( aDBF, { "NIT", "C", 11, 0 } )
		aAdd( aDBF, { "INDFUN", "C", 01, 0 } )
		aAdd( aDBF, { "REGNUM", "C", 12, 0 } )
		aAdd( aDBF, { "MAT", "C", TamSx3( 'RA_MAT' )[ 1 ], 0 } )
		aAdd( aDBF, { "RESAMB", "C", 01, 0 } )
		aAdd( aDBF, { "MONBIO", "C", 01, 0 } )
		aAdd( aDBF, { 'CIC', 'C', TamSX3( 'TMK_CIC' )[1], 0 } )

		oTempTMK := FWTemporaryTable():New( cTRBTMK, aDBF )
		oTempTMK:AddIndex( "1", { "INDFUN", "DTINI", "DTFIM", "REGNUM", "NOME" } )
		oTempTMK:AddIndex( "2", { "REGNUM", "NOME", "DTINI" } )
		oTempTMK:AddIndex( "3", { "INDFUN", "REGNUM", "NOME", "DTINI" } )
		oTempTMK:AddIndex( "4", { "FILIAL", "MAT", "CODIGO", "DTINI", "DTFIM" } )
		oTempTMK:Create()

		// TRBTM5
		aDBF := {}
		aAdd( aDBF, { "EXAME", "C", nTamExa, 0 } )
		aAdd( aDBF, { "NOMEXA", "C", 50, 0 } )
		aAdd( aDBF, { "DTPRO", "D", 08, 0 } )
		aAdd( aDBF, { "DTRES", "D", 08, 0 } )
		aAdd( aDBF, { "NATEXA", "C", 01, 0 } )
		aAdd( aDBF, { "RESULT", "C", 01, 0 } )
		aAdd( aDBF, { "REFERE", "C", 01, 0 } )
		aAdd( aDBF, { "ESTAVE", "C", 01, 0 } )
		aAdd( aDBF, { "AGRAVA", "C", 01, 0 } )
		aAdd( aDBF, { "AUDIO", "C", 01, 0 } )

		// TRBTNF
		aDBF := {}
		aAdd( aDBF, { "DTINI", "D", 08, 0 } )
		aAdd( aDBF, { "NUMCAP", "C", 12, 0 } )
		aAdd( aDBF, { "PROTEC", "C", 02, 0 } )
		aAdd( aDBF, { "DTREAL", "D", 08, 0 } )
		aAdd( aDBF, { "SITUAC", "C", 01, 0 } )
		aAdd( aDBF, { "DTDEVO", "D", 08, 0 } )
		aAdd( aDBF, { "CODEPI", "C", nSizeCod, 0 } )
		aAdd( aDBF, { "PRZTNF", "C", 01, 0 } )
		aAdd( aDBF, { "PRZDUR", "C", 01, 0 } )
		aAdd( aDBF, { "HIGIEN", "C", 01, 0 } )

		oTempTNF := FWTemporaryTable():New( cTRBTNF, aDBF )
		oTempTNF:AddIndex( "1", { "DTINI", "NUMCAP", "PROTEC", "DTREAL" } )
		oTempTNF:AddIndex( "2", { "SITUAC", "NUMCAP", "DTINI", "PROTEC", "DTREAL" } )
		oTempTNF:Create()

		// Inicio do Relatorio
		If xm_par26 = 1
			cOrdem := "%SRA.RA_FILIAL, SRA.RA_NOME, SRA.RA_MAT%"
		Else
			cOrdem := "%SRA.RA_FILIAL, SRA.RA_CC, SRA.RA_NOME, SRA.RA_MAT%"
		EndIf

		// Condição para Prestador
		cSQLPrest := "%%"
		If lSigaMdtps
			cSQLPrest := "%SUBSTRING( RA_CC, 1, " + ValToSQL( nSizeTD ) + " ) BETWEEN " + ;
							ValToSQL( mv_par01+mv_par02 ) + " AND " + ValToSQL( mv_par03+mv_par04 ) + " AND%"
		EndIf

		BeginSQL Alias cTRBSRA
			SELECT SRA.RA_FILIAL, SRA.RA_MAT, SRA.RA_NOME, SRA.RA_CC
				FROM %table:SRA% SRA
				WHERE
					RA_FILIAL = %xFilial:SRA% AND
					RA_MAT BETWEEN %exp:xm_par01% AND %exp:xm_par02% AND
					RA_CC BETWEEN %exp:xm_par03% AND %exp:xm_par04% AND
					RA_CODFUNC BETWEEN %exp:xm_par05% AND %exp:xm_par06% AND
					%exp:cSQLPrest%
					SRA.%notDel%
				ORDER BY %exp:cOrdem%
		EndSQL

		ProcRegua( RecCount() ) // MONTA A REGUA DE ACOMPANHAMENTO

		While ( cTRBSRA )->( !Eof() )

			dbSelectArea( "SRA" )
			dbSetOrder( 1 )
			dbSeek( ( cTRBSRA )->RA_FILIAL + ( cTRBSRA )->RA_MAT )

			IncProc()  // INCREMENTO DA REGUA DE ACOMPAHAMENTO.
			dDtAdmiss := CToD( "//" )
			dDtDemiss := IIf( Empty( SRA->RA_DEMISSA ), U_PPPDTDEMIS(), SRA->RA_DEMISSA ) //Busca data demissao do SRG
			lDemitido := !Empty( dDtDemiss )

			If xm_par12 == 1 .And. Year( SRA->RA_ADMISSA ) < 2004 // Somente a partir JAN/2004 ?

				dDtAdmiss := CtoD( '01/01/2004' )

				If !Empty( dDatacorte ) .And. dDtAdmiss < dDatacorte
					dDtAdmiss := dDatacorte
				EndIf

			Else

				If !Empty( dDatacorte ) .And. SRA->RA_ADMISSA < dDatacorte
					dDtAdmiss := dDatacorte
				Else
					dDtAdmiss := SRA->RA_ADMISSA
				EndIf

			EndIf

			If xm_par01 != xm_par02 //De Matricula ? // Ate Matricula ?

				If xm_par18 == 1 //Situacao Funcionario ?

					If !Empty( SRA->RA_SITFOLH ) .Or. lDemitido
						dbSelectArea( cTRBSRA )
						dbSkip()
						Loop
					EndIf

				ElseIf xm_par18 == 2 //Situacao Funcionario ?

					If lDemitido .Or. SRA->RA_SITFOLH == "D"
						dbSelectArea( cTRBSRA )
						dbSkip()
						Loop
					EndIf

				ElseIf xm_par18 == 3 //Situacao Funcionario ?

					If !lDemitido .Or. SRA->RA_SITFOLH != "D"
						dbSelectArea( cTRBSRA )
						dbSkip()
						Loop
					EndIf

					If dDtDemiss < xm_par19 .Or. dDtDemiss > xm_par20 // De Data Demissao ? // Ate Data Demissao ?
						dbSelectArea( cTRBSRA )
						dbSkip()
						Loop
					EndIf

				ElseIf xm_par18 == 4 // Situacao Funcionario ?

					If lDemitido .And. SRA->RA_SITFOLH == "D"

						If dDtDemiss < xm_par19 .Or. dDtDemiss > xm_par20 // De Data Demissao ? // Ate Data Demissao ?
							dbSelectArea( cTRBSRA )
							dbSkip()
							Loop
						EndIf

					EndIf

				EndIf

			EndIf

			dbSelectArea( cTRBTN0 )
			Zap
			dbSelectArea( cTRBPPP )
			Zap
			dbSelectArea( cTRBTMK )
			Zap
			dbSelectArea( cTRBTNF )
			Zap

			nPaginaPPP := 1
			dbSelectArea( "SRA" )
			nRecnoSRA := Recno()

			lRet := U_NGMDT700( @lImpMsgPPP, @lExistReg ) // Chamada da funcao que imprime o PPP

			If xm_par10 == 2 // Comprovante de Entrega ?
				U_MDTERMO700()
			EndIf

			dbSelectArea( "SRA" )
			dbGoTo( nRecnoSRA )

			( cTRBSRA )->( dbSkip() )
		End

		// Deleta o arquivo temporario fisicamente
		oTempTN0:Delete()
		oTempPPP:Delete()
		oTempTMK:Delete()
		oTempTNF:Delete()

		If lRet .Or. lExistReg

			If xm_par13 == 1 // Impressora
				oPrintPPP:Print()
			Else // Via email
				oPrintPPP:Print()
				U_PPPSENDMAIL()
			EndIf

		EndIf

		dbSelectArea( "TM0" )
		dbSetorder( 1 )
		dbSelectArea( "TM5" )
		dbSetorder( 1 )
		dbSelectArea( "TMY" )
		dbSetorder( 1 )
	EndIf

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} NGMDT700
Imprime o Perfil Profissiografico Previdenciario

@type function
@source MDTR700.prx

@author Denis Hyroshi de Souza
@since 21/10/2002

@sample U_MDTR700()

@return Nulo, Sempre Nulo
/*/
//---------------------------------------------------------------------
User Function NGMDT700( lImpMsgPPP, lExistReg )
	Local aHist := {}, nx, i, nInd
	Local cCNAE := "NA"
	Local cEPCefic := ""
	Local dDataCat
	Local dDataIni
	Local dDataFim
	Local lRespAmb  := .T.
	Local lProtec 	:= .F.  // Indica se todos os campos 15.7-Epi Eficaz = NA
	Local lEPCprot 	:= .F.  // Indica se todos os campos 15.6-Epc Eficaz = NA
	Local cEficEPC 	:= "NA"
	Local cEPIefic 	:= "NA"
	Local cCondInd	:= ""   // Verifica a funcao do Responsavel Ambiental, item 16.4
	Local cCNPJ
	Local cCargoDesc
	Local cIntens   := ""

	Local nLinhasCC 	:= 0
	Local nLinhasCargo 	:= 0
	Local nLinhasFuncao := 0

	// Variaveis para controle de quebra de lina na secao 15
	Local nLinTec := 0
	Local nLinFat := 0
	Local nLinInt := 0

	Local aHisSal		:= {} // Faz um backup do array de histórico para ajustar a impressão do item 13
	Local nLinAtu	 	:= 0
	Local nMaxLin	 	:= 0 // Maior numero de linhas secao 13
	Local lExist1001 	:= ExistBlock( "MDTR7001" )

	Private aNUMCAPS 	:= {}
	Private aFuncao 	:= {}
	Private aFichasUsa 	:= {}
	Private aCargoSv  	:= {}
	Private aCargo  	:= {}
	Private aMatriculas := {}
	Private aRiscos		:= {}
	Private aCat  		:= {}
	Private lEpcNec		:= .F.
	Private lEpiNec 	:= .F.
	Private aAREASRA 	:= SRA->(GetArea())
	Private cCliFun 	:= Space( 6 )

	lEpiEntregue:= .F.
	lPrazoTNF 	:= .F. // Indica se algum EPI foi entregue fora do prazo de validade
	lPrazoDur 	:= .F. // Indica se algum EPI foi utilizado mais do que o seu prazo de durabilidade
	lHigiene  	:= .F. // Indica se algum EPI não teve higienização

	aHist := aClone( fVerBusHis() ) // Histórico do funcionário

	If !lEpiEntregue      // Se nenhum EPI foi entregue
		lPrazoTNF := .T.  // Nao foi observado o prazo de validade pois nenhum EPI foi entregue
		lPrazoDur := .T.  // Nao foi observada a periodicidade de troca pois  nenhum EPI foi entregue
		lHigiene  := .T.  // Nao foi observada a higienizacao pois nenhum EPI foi entregue
	EndIf

	RestArea( aAREASRA )

	If lMV_PPPRISC
		dbSelectArea( cTRBTN0 )
		dbSetOrder( 1 )
		dbGoTop()

		If (cTRBTN0)->(RECCOUNT()) == 0
			Return .F.
		EndIf

	EndIf

	If Empty( aHist ) 

		If !lImpMsgPPP
			lImpMsgPPP := .T.
			MsgStop( STR0339, STR0255 )
			Return .F.
		Else
			Return .F.
		EndIf

	Else

		lExistReg := .T.
	
	EndIf

	dbSelectArea( "TM0" )
	dbSetOrder( 3 )
	dbSeek( xFilial( "SRA" ) + SRA->RA_MAT )

	dbSelectArea( "SR6" )
	dbSetOrder( 1 )
	dbSeek( xFilial( "SR6" ) + SRA->RA_TNOTRAB )

	U_NG700SESMT() // Busca os Usuarios do SESMT

	lin := 100
	oPrintPPP:StartPage()

	oPrintPPP:SayAlign( lin, 50, STR0146, oFont13, 2940, lin + 30, CLR_BLACK, 2, 1 ) // "ANEXO XVII"
	oPrintPPP:SayAlign( lin + 65, 50, STR0147, oFont13, 2940, lin + 110, CLR_BLACK, 2, 1 ) // "INSTRUÇÃO NORMATIVA PRES/INSS Nº 128, DE 28 DE MARÇO DE 2022"
	oPrintPPP:SayAlign( lin + 140, 50, STR0340, oFonte14N, 2940, lin + 110, CLR_BLACK, 2, 1 ) // "(Alterado pela Instrução Normativa PRES/INSS n° 133, de 26 de maio de 2022)"

	lin += 100

	// Imprime logotipo da previdencia social
	cLogo := cStartPath + "\LOGOPPP.BMP" // Empresa

	If File( cLogo )
		oPrintPPP:SayBitMap( 170, 180, cLogo, 270, 135 )
	ElseIf File( "\SIGAADV\LOGOPPP.BMP" ) // Imprime logotipo da previdencia social
		oPrintPPP:SayBitMap( 170, 180, "\SIGAADV\LOGOPPP.BMP", 270, 135 )
	EndIf

	lin += 80
	oPrintPPP:SayAlign( lin + 90, 50, STR0149, oFont13, 2940, lin + 110, CLR_BLACK, 2, 1 ) // "PERFIL PROFISSIOGRÁFICO PREVIDENCIÁRIO - PPP"
	oPrintPPP:Box( lin + 200, 50, lin + 580, 2940 )

	// PRIMEIRA PARTE
	SomaLinha( 260 )
	oPrintPPP:Say( lin, 70, STR0150, oFont13 ) // "DADOS ADMINISTRATIVOS"

	oPrintPPP:Line( lin + 20, 50, lin + 20, 2940 )
	oPrintPPP:Line( lin + 20, 1000, lin + 120, 1000 )

	// "1-CNPJ do Domicílio Tributário/CEI/CAEPF/CNO"
	oPrintPPP:Say( lin + 50, 60, Memoline( STR0151, 41, 1 ), oFont09n )
	oPrintPPP:Say( lin + 80, 60, Memoline( STR0151, 41, 2 ), oFont09n )

	oPrintPPP:Line( lin + 20, 2200, lin + 120, 2200 )

	// Ponto de entrada MDTR7003 para CNPJ
	If ExistBlock( "MDTR7003" )
		cCNPJ:= ExecBlock( "MDTR7003", .F., .F. )
	EndIf

	// Caso não teha ponto de entrada
	If ValType( cCNPJ ) <> "C" .Or. Empty( cCNPJ )

		If lNGMDTPS .Or. lSigaMdtps
			cCNPJ:= SA1->A1_CGC
		Else
			cCNPJ:= SM0->M0_CGC
		EndIf

	EndIf

	If !Empty( cCNPJ )

		If SM0->M0_TPINSC != 2
			oPrintPPP:Say( lin + 110, 60, Transform( cCNPJ, "@R 99.999.99999/99" ), oFont10 )
		Else
			oPrintPPP:Say( lin + 110, 60, Transform( cCNPJ, "@!R NN.NNN.NNN/NNNN-99" ), oFont10 )
		EndIf

	EndIf

	oPrintPPP:Say( lin + 50, 1010, STR0152, oFont09n ) // "2-Nome Empresarial"	
	oPrintPPP:Say( lin + 110, 1010, Substr( SM0->M0_NOMECOM, 1, 40 ), oFont10 )
	oPrintPPP:Say( lin + 50, 2210, STR0153, oFont09n ) // "3-CNAE"
	
	If !Empty( SM0->M0_CNAE )
		nSizeCNAE := Len( AllTrim( SM0->M0_CNAE ) )

		If nSizeCNAE > 5
			cCNAE := Transform( SM0->M0_CNAE, "@R 99.99-9/99" )
		Else
			cCNAE := Transform( SM0->M0_CNAE, "@R 99.99-9" )
		EndIf

	EndIf
	oPrintPPP:Say( lin + 110, 2210, cCNAE, oFont10 )

	oPrintPPP:Line( lin + 120, 50, lin + 120, 2940 )
	oPrintPPP:Say( lin + 150, 60, STR0154, oFont09n ) // "4-Nome do Trabalhador"

	If !Empty( SRA->RA_NOMECMP )
		oPrintPPP:Say( lin + 210, 60, SRA->RA_NOMECMP, oFont10 )
	Else
		oPrintPPP:Say( lin + 210, 60, SRA->RA_NOME, oFont10 )
	EndIf

	oPrintPPP:Line( lin + 120, 1525, lin + 220, 1525 )
	oPrintPPP:Say( lin + 150, 1535, STR0155, oFont09n ) // "5-BR/PDH"
	cBRPDH := "NA"

	If SRA->RA_BRPDH == "1"
		cBRPDH := "BR"
	ElseIf SRA->RA_BRPDH == "2"
		cBRPDH := "PDH"
	EndIf

	oPrintPPP:Say( lin + 210, 1535, cBRPDH, oFont10 )

	oPrintPPP:Line( lin + 120, 1925, lin + 220, 1925 )
	oPrintPPP:Say( lin + 150, 1935, STR0156, oFont09n ) // "6-CPF"

	If !Empty( SRA->RA_CIC )
		oPrintPPP:Say( lin + 210, 1935, Transform( SRA->RA_CIC, '@R 999.999.999-99' ), oFont10 )
	EndIf

	oPrintPPP:Line( lin + 220, 50, lin + 220, 2940 )
	oPrintPPP:Line( lin + 220, 500, lin + 320, 500 )
	oPrintPPP:Line( lin + 220, 750, lin + 320, 750 )
	oPrintPPP:Line( lin + 220, 1370, lin + 320, 1370 )
	oPrintPPP:Line( lin + 220, 1760, lin + 320, 1760 )
	oPrintPPP:Say( lin + 250, 60, STR0157, oFont09n ) //"7-Data do Nascimento"
	oPrintPPP:Say( lin + 310, 60, U_NGPPPDATE( SRA->RA_NASC ), oFont10 )
	oPrintPPP:Say( lin + 250, 510, STR0158, oFont09n ) //"8-Sexo(F/M)"
	oPrintPPP:Say( lin + 310, 510, Upper( SRA->RA_SEXO ), oFont10 )

	// "9 - Matrícula do Trabalhador no eSocial"
	oPrintPPP:Say( lin + 250, 760, Memoline( STR0159, 29, 1 ), oFont09n )
	oPrintPPP:Say( lin + 280, 760, Memoline( STR0159, 29, 2 ), oFont09n )
	oPrintPPP:Say( lin + 310, 760, AllTrim( SRA->RA_CODUNIC ), oFont10 )

	oPrintPPP:Say( lin + 250, 1380, STR0160, oFont09n ) //"10-Data de Admissão"
	oPrintPPP:Say( lin + 310, 1380, U_NGPPPDATE( SRA->RA_ADMISSA ), oFont10 )
	oPrintPPP:Say( lin + 250, 1770, STR0161, oFont09n ) //"11-Regime Revezamento"

	If !Empty( Substr( SR6->R6_REVEZAM, 1, 20 ) )
		oPrintPPP:Say( lin + 310, 1770, Substr( SR6->R6_REVEZAM, 1, 20 ), oFont09 )
	Else
		oPrintPPP:Say( lin + 310, 1770, "NA", oFont10 )
	EndIf

	lin += 320
	oPrintPPP:Line( lin, 50, lin + 60, 50 )
	oPrintPPP:Say( lin + 45, 70, "12", oFont11 )
	oPrintPPP:Line( lin, 150, lin + 60, 150 )
	oPrintPPP:Say( lin + 45, 160, STR0162, oFont11 ) //"CAT REGISTRADA:"
	oPrintPPP:Line( lin, 2940, lin + 60, 2940 )
	oPrintPPP:Line( lin + 60, 50, lin + 60, 2940 )

	SomaLinha()
	oPrintPPP:Line( lin, 50, lin + 50, 50 )
	oPrintPPP:Say( lin + 40, 60, STR0163, oFont09n ) // "12.1-Data do Registro"
	oPrintPPP:Line( lin, 475, lin + 50, 475 )
	oPrintPPP:Say( lin + 40, 485, STR0164, oFont09n ) // "12.2-Número da CAT"
	oPrintPPP:Line( lin, 1400, lin + 50, 1400 )
	oPrintPPP:Say( lin + 40, 1410, STR0163, oFont09n ) // "12.1-Data do Registro"
	oPrintPPP:Line( lin, 1825, lin + 50, 1825 )
	oPrintPPP:Say( lin + 40, 1835, STR0164, oFont09n ) // "12.2-Número da CAT"
	oPrintPPP:Line( lin, 2940, lin + 50, 2940 )
	oPrintPPP:Line( lin + 50, 50, lin + 50, 2940 )

	lPosi := .F.
	lLen  := .F.

	If Len( aCat ) > 0

		For nX := 1 To Len( aCat )

			If len( aCat ) == nx
				lLen := .T.
			EndIf

			nResto := Mod( nX, 2 )

			If nResto == 1 .And. lLen

				SomaLinha( 50 )
				oPrintPPP:Line( lin, 50, lin + 50, 50 )

				// Data do Registro
				If !Empty( dDataCat := U_NGPPPDATE( aCat[nx][1] ) )
					oPrintPPP:Say( lin + 35, 60, dDataCat, oFont10 )
				EndIf

				oPrintPPP:Line( lin, 475, lin + 50, 475 )

				// Numero da Cat
				If !Empty( aCat[ nx, 2 ] )

					If aCat[ nx, 4 ]
						oPrintPPP:Say( lin + 35, 485, Transform( aCat[ nx, 2 ], '@R 9.9.9999999999999999999' ), oFont10 ) // Formato eSocial
					Else
						oPrintPPP:Say( lin + 35, 485, Transform( aCat[ nx, 2 ], '@R 9999999999-9/99' ), oFont10 ) // Formato comum
					EndIf

					oPrintPPP:Say( lin + 35, 1410, 'NA', oFont10 )
					oPrintPPP:Say( lin + 35, 1835, 'NA', oFont10 )

				EndIf

				oPrintPPP:Line( lin, 1400, lin + 50, 1400 )
				oPrintPPP:Line( lin, 1825, lin + 50, 1825 )
				oPrintPPP:Line( lin, 2940, lin + 50, 2940 )
				oPrintPPP:Line( lin + 50, 50, lin + 50, 2940 )

			ElseIf nResto == 0

				SomaLinha( 50 )

				oPrintPPP:Line( lin, 50, lin + 50, 50 )

				If !Empty( dDataCat := U_NgPppDate( aCat[ nX - 1, 1 ] ) ) // Data do registro
					oPrintPPP:Say( lin + 35, 60, dDataCat, oFont10 )
				EndIf

				oPrintPPP:Line( lin, 475, lin + 50, 475 )

				If !Empty( aCat[ nX - 1, 2 ] ) // Número da cat

					If aCat[ nX - 1, 4 ]
						oPrintPPP:Say( lin + 35, 485, Transform( aCat[ nx - 1, 2 ], '@R 9.9.9999999999999999999' ), oFont10 ) // Formato eSocial
					Else
						oPrintPPP:Say( lin + 35, 485, Transform( aCat[ nx - 1, 2 ], '@R 9999999999-9/99' ), oFont10 ) // Formato comum
					EndIf

				EndIf

				oPrintPPP:Line( lin, 1400, lin + 50, 1400 )

				If !Empty( dDataCat := U_NgPppDate( aCat[ nX, 1 ] ) ) // Data do registro
					oPrintPPP:Say( lin + 35, 1410, dDataCat, oFont10 )
				EndIf

				oPrintPPP:Line( lin, 1825, lin + 50, 1825 )

				If !Empty( aCat[ nX, 2 ] ) // Número da cat

					If aCat[ nX, 4 ]
						oPrintPPP:Say( lin + 35, 1835, Transform( aCat[ nx, 2 ], '@R 9.9.9999999999999999999' ), oFont10 ) // Formato eSocial
					Else
						oPrintPPP:Say( lin + 35, 1835, Transform( aCat[ nx, 2 ], '@R 9999999999-9/99' ), oFont10 ) // Formato comum
					EndIf

				EndIf

				oPrintPPP:Line( lin, 2940, lin + 50, 2940 )
				oPrintPPP:Line( lin + 50, 50, lin + 50, 2940 )

			EndIf

		Next nX

	Else
		SomaLinha( 50 )
		oPrintPPP:Say( lin + 35, 60, "NA", oFont10 )
		oPrintPPP:Say( lin + 35, 485, "NA", oFont10 )
		oPrintPPP:Say( lin + 35, 1410, "NA", oFont10 )
		oPrintPPP:Say( lin + 35, 1835, "NA", oFont10 )
		oPrintPPP:Line( lin, 50, lin + 50, 50 )
		oPrintPPP:Line( lin, 475, lin + 50, 475 )
		oPrintPPP:Line( lin, 1400, lin + 50, 1400 )
		oPrintPPP:Line( lin, 1825, lin + 50, 1825 )
		oPrintPPP:Line( lin, 2940, lin + 50, 2940 )
		oPrintPPP:Line( lin + 50, 50, lin + 50, 2940 )
	EndIf

	SomaLinha( 50 )
	oPrintPPP:Line( lin, 50, lin + 60, 50 )
	oPrintPPP:Say( lin + 45, 70, "13", oFont11 )
	oPrintPPP:Line( lin, 150, lin + 60, 150 )
	oPrintPPP:Say( lin + 45, 160, STR0165, oFont11 )   //"LOTAÇÃO E ATRIBUIÇÃO:"
	oPrintPPP:Line( lin, 2940, lin + 60, 2940 )
	oPrintPPP:Line( lin + 60, 50, lin + 60, 2940 )

	SomaLinha()

	oPrintPPP:Line( lin, 50, lin + 90, 50 )
	oPrintPPP:Say( lin + 30, 60, STR0166, oFont08_ )   //"13.1-Período"

	// "13.2-CNPJ/CEI/CAEPF/CNO"
	oPrintPPP:Line( lin, 510, lin + 90, 510 )
	oPrintPPP:Say( lin + 30, 520, Memoline( STR0167, 14, 1 ), oFont08_ )
	oPrintPPP:Say( lin + 60, 520, Memoline( STR0167, 14, 2 ), oFont08_ )

	oPrintPPP:Line( lin, 870, lin + 90, 870 )
	oPrintPPP:Say( lin + 30, 880, STR0168, oFont08_ )  //"13.3-Setor"

	oPrintPPP:Line( lin, 1200, lin + 90, 1200 )
	oPrintPPP:Say( lin + 30, 1210, STR0169, oFont08_ ) //"13.4-Cargo"

	oPrintPPP:Line( lin, 1460, lin + 90, 1460 )
	oPrintPPP:Say( lin + 30, 1470, STR0170, oFont08_ ) //"13.5-Função"

	oPrintPPP:Line( lin, 1710, lin + 90, 1710 )
	oPrintPPP:Say( lin + 30, 1720, STR0171, oFont08_ ) //"13.6-CBO"

	// "13.7-Código GFIP/eSocial"
	oPrintPPP:Line( lin, 1890, lin + 90, 1890 )
	oPrintPPP:Say( lin + 30, 1900, Memoline( STR0172, 14, 1 ), oFont08_ )
	oPrintPPP:Say( lin + 60, 1900, Memoline( STR0172, 14, 2 ), oFont08_ )

	oPrintPPP:Line( lin, 2940, lin + 90, 2940 )
	oPrintPPP:Line( lin + 70, 50, lin + 70, 2940 )//Linha de baixo

	SomaLinha( 90 )

	aHisSal := aClone( aHist ) // Realiza um backup do histórico

	aHist := aClone( fValHisRep( aHist ) )

	If Len( aHist ) > 0

		For i := 1 To Len( aHist )

			// Conta o numero de linhas dos conteudos a serem impressos
			nLinhasCC 		:=  MLCount( aHist[i][5], 15 ) //Centro de Custo
			nLinhasCargo 	:=  MLCount( aHist[i][IIf( lTrocaDes, 7, 6 )], 15 )  //Cargo
			nLinhasFuncao 	:=  MLCount( aHist[i][IIf( !lTrocaDes, 7, 6 )], 15 ) //Funcao

			// Busca do maior numero de linhas
			nMaxLin := nLinhasCC
			nMaxLin := IIf( nLinhasCargo > nMaxLin, nLinhasCargo, nMaxLin )
			nMaxLin := IIf( nLinhasFuncao > nMaxLin, nLinhasFuncao, nMaxLin )
			nMaxLin := IIf( nMaxLin <= 0, 1, nMaxLin ) //Garante que irá passar ao menos por uma linha

			dDataIni := aHist[i][3]

			If !fVerAte()
				dDataFim := IIf( i == Len( aHist ) .And. !lDemitido, CToD( '//' ), aHist[ i, 4 ] )
			Else
				dDataFim := aHist[ i, 4 ]
			EndIf

			aDatasPPP := fDesagData( dDataIni, dDataFim )

			For nX := 1 To Len( aDatasPPP )

				// Se uma linha da seção 13 ficar dividida entre paginas, quebra a pagina
				If lin + nMaxLin > 1900
					SomaLinha( , , .T. )
				EndIf

				oPrintPPP:Line( lin, 50, lin + 50, 50 )

				// Salva os conteudos a serem impressos
				cCentroCusto:= aHist[i][5] //Centro de Custo
				cCargoDesc 	:= aHist[i][IIf( lTrocaDes, 7, 6 )] //Cargo
				cFuncaoDesc := aHist[i][IIf( !lTrocaDes, 7, 6 )] //Funcao

				For nLinAtu := 1 To nMaxLin

					If nLinAtu == 1
						oPrintPPP:Say( lin + 30, 60, aDatasPPP[nX], oFont10 ) // Período

						If aHist[i][11] == 2

							If Empty( aHist[i][10] )
								oPrintPPP:Say( lin + 30, 520, "NA", oFont10 ) // CNPJ
							Else
								oPrintPPP:Say( lin + 30, 520, Transform( aHist[i][10], "@!R NN.NNN.NNN/NNNN-99" ), oFont09 ) // CNPJ
							EndIf

						Else

							If Empty( aHist[i][10] )
								oPrintPPP:Say( lin + 30, 520, "NA", oFont10 ) // CEI
							Else
								oPrintPPP:Say( lin + 30, 520, Transform( aHist[i][10], "@R 99.999.99999/99" ), oFont10 ) // CEI
							EndIf

						EndIf

						If !Empty( aHist[ i, 8 ] ) // Imprime CBO
							oPrintPPP:Say( lin + 30, 1720, Strzero( Val( aHist[ i, 8 ] ), 6 ), oFont10 )
						EndIf

						If lExist1001
							 ExecBlock('MDTR7001',.F.,.F., {@aHist[i]})
						EndIf

						// GFIP
						If !Empty( aHist[i][9] )
							oPrintPPP:Say( lin + 30, 1900, aHist[i][9], oFont09 )
						EndIf

					EndIf

					// Setor
					If !Empty( MemoLine( cCentroCusto, 16, nLinAtu ) )
						oPrintPPP:Say( lin + 30, 880, Memoline( cCentroCusto, 16, nLinAtu ), oFont10 )
					EndIf

					// Cargo
					If Empty( cCargoDesc ) .And. nLinAtu == 1
						oPrintPPP:Say( lin + 30, 1210, "NA", oFont10 )
					ElseIf !Empty( MemoLine( cCargoDesc, 13, nLinAtu ) )
						oPrintPPP:Say( lin + 30, 1210, Memoline( cCargoDesc, 13, nLinAtu ), oFont10 )
					EndIf

					// Funcao
					If Empty( cFuncaoDesc ) .And. nLinAtu == 1
						oPrintPPP:Say( lin + 30, 1470, "NA", oFont10 )
					ElseIf !Empty( MemoLine( cFuncaoDesc, 13, nLinAtu ) )
					   	oPrintPPP:Say( lin + 30, 1470, Memoline( cFuncaoDesc, 13, nLinAtu ), oFont10 )
					EndIf

					// Imprime as linhas verticais
					oPrintPPP:Line( lin, 50,	lin + 40, 50 	)
					oPrintPPP:Line( lin, 510, 	lin + 40, 510 	)
					oPrintPPP:Line( lin, 870, 	lin + 40, 870 	)
					oPrintPPP:Line( lin, 1200, 	lin + 40, 1200 	)
					oPrintPPP:Line( lin, 1460, 	lin + 40, 1460 	)
					oPrintPPP:Line( lin, 1710, 	lin + 40, 1710 	)
					oPrintPPP:Line( lin, 1890, 	lin + 40, 1890 	)
					oPrintPPP:Line( lin, 2940, 	lin + 40, 2940	)

					SomaLinha( 40, .T. )

				Next nLinAtu

				oPrintPPP:Line( lin, 50, lin, 2940 )

			Next nx

		Next i

	Else
		oPrintPPP:Line( lin, 50, lin + 50, 50 )
		oPrintPPP:Say( lin + 30, 60, "__/__/____" + STR0173 + "__/__/____", oFont10 )
		oPrintPPP:Say( lin + 30, 560, "NA", oFont10 )  // CNPJ
		oPrintPPP:Say( lin + 30, 855, "NA", oFont10 )  // Setor
		oPrintPPP:Say( lin + 30, 1205, "NA", oFont10 ) // Cargo
		oPrintPPP:Say( lin + 30, 1555, "NA", oFont10 ) // Funcao
		oPrintPPP:Say( lin + 30, 1910, "NA", oFont10 ) // CBO
		oPrintPPP:Say( lin + 30, 2090, "", oFont10 )   // GFIP
		oPrintPPP:Line( lin, 550, lin + 50, 550 )
		oPrintPPP:Line( lin, 850, lin + 50, 850 )
		oPrintPPP:Line( lin, 1200, lin + 50, 1200 )
		oPrintPPP:Line( lin, 1550, lin + 50, 1550 )
		oPrintPPP:Line( lin, 1900, lin + 50, 1900 )
		oPrintPPP:Line( lin, 2080, lin + 50, 2080 )
		oPrintPPP:Line( lin, 2210, lin + 50, 2210 )
		oPrintPPP:Line( lin + 50, 50, lin + 50, 2210 )
		SomaLinha( 50 )
	EndIf

	aHist := aClone( aHisSal ) // Restaura o backup do histórico

	oPrintPPP:Line( lin, 50, lin + 60, 50 )
	oPrintPPP:Say( lin + 45, 70, "14", oFont11 )
	oPrintPPP:Line( lin, 150, lin + 60, 150 )
	oPrintPPP:Say( lin + 45, 160, STR0174, oFont11 ) //"PROFISSIOGRAFIA:"
	oPrintPPP:Line( lin, 2940, lin + 60, 2940 )
	oPrintPPP:Line( lin + 60, 50, lin + 60, 2940 )
	SomaLinha()
	oPrintPPP:Line( lin, 50, lin + 50, 50 )
	oPrintPPP:Say( lin + 40, 60, STR0175, oFont09n ) //"14.1-Período"
	oPrintPPP:Line( lin, 550, lin + 50, 550 )
	oPrintPPP:Say( lin + 40, 560, STR0176, oFont09n ) //"14.2-Descrição das Atividades"
	oPrintPPP:Line( lin, 2940, lin + 50, 2940 )
	oPrintPPP:Line( lin + 50, 50, lin + 50, 2940 )
	SomaLinha( 50 )

	If !U_ATIV700R()//IMPRIME DESCRICAO DAS ATIVIDADES
		oPrintPPP:Line( lin, 50, lin + 50, 50 )
		oPrintPPP:Line( lin, 550, lin + 50, 550 )
		oPrintPPP:Line( lin, 2940, lin + 50, 2940 )
		oPrintPPP:Line( lin + 50, 50, lin + 50, 2940 )
		oPrintPPP:Say( lin + 45, 60, "NA", oFont10 )
		oPrintPPP:Say( lin + 45, 560, "NA", oFont10 )
		SomaLinha( 50 )
	EndIf

	// SEGUNDA PARTE

	SomaLinha( 30 )

	// Quebra de pagina devido ao tamanho do cabecalho da secao 15
	If lin >= 1900
		SomaLinha( , .F., .T. )
	EndIf

	oPrintPPP:Line( lin, 50, lin, 2940 )
	oPrintPPP:Line( lin, 50, lin + 80, 50 )
	oPrintPPP:Line( lin, 2940, lin + 80, 2940 )
	oPrintPPP:Line( lin + 80, 50, lin + 80, 2940 )
	oPrintPPP:Say( lin + 60, 70, STR0177, oFont13 ) //"REGISTROS AMBIENTAIS"
	SomaLinha( 80 )
	oPrintPPP:Line( lin, 50, lin + 60, 50 )
	oPrintPPP:Say( lin + 45, 70, "15", oFont11 )
	oPrintPPP:Line( lin, 150, lin + 60, 150 )
	oPrintPPP:Say( lin + 45, 160, STR0178, oFont11 ) //"EXPOSIÇÃO A FATORES DE RISCOS:"
	oPrintPPP:Line( lin, 2940, lin + 60, 2940 )
	oPrintPPP:Line( lin + 60, 50, lin + 60, 2940 )
	//IMPRIMIR RISCO
	SomaLinha()
	oPrintPPP:Line( lin, 50, lin + 115, 50 )
	oPrintPPP:Say( lin + 35, 60, STR0179, oFont09n ) //"15.1-Período"
	oPrintPPP:Line( lin, 300, lin + 115, 300 )
	oPrintPPP:Say( lin + 35, 310, STR0180, oFont09n ) //"15.2-"
	oPrintPPP:Say( lin + 70, 310, STR0046, oFont09n ) //"Tipo"
	oPrintPPP:Line( lin, 410, lin + 115, 410 )
	oPrintPPP:Say( lin + 35, 420, "15.3-", oFont09n ) //"15.3-"
	oPrintPPP:Say( lin + 70, 420, STR0181, oFont09n ) //"Fator de"
	oPrintPPP:Say( lin + 105, 420, STR0182, oFont09n ) //"Risco"
	oPrintPPP:Line( lin, 600, lin + 115, 600 )
	oPrintPPP:Say( lin + 35, 610, STR0183, oFont09n ) //"15.4-Intens."
	oPrintPPP:Say( lin + 70, 610, STR0184, oFont09n ) //"/Conc."
	oPrintPPP:Line( lin, 850, lin + 115, 850 )
	oPrintPPP:Say( lin + 35, 860, "15.5-", oFont09n ) //"15.5-"
	oPrintPPP:Say( lin + 70, 860, STR0185, oFont09n ) //"Técnica"
	oPrintPPP:Say( lin + 105, 860, STR0040, oFont09n ) //"Utilizada"
	oPrintPPP:Line( lin, 1030, lin + 115, 1030 )
	oPrintPPP:Say( lin + 35, 1040, "15.6-", oFont09n ) //"15.6-"
	oPrintPPP:Say( lin + 70, 1040, STR0186, oFont09n ) //"EPC"
	oPrintPPP:Say( lin + 105, 1040, STR0187, oFont09n ) //"Eficaz"
	oPrintPPP:Line( lin, 1160, lin + 115, 1160 )
	oPrintPPP:Say( lin + 35, 1170, "15.7-", oFont09n ) //"15.7-"
	oPrintPPP:Say( lin + 70, 1170, STR0188, oFont09n ) //"EPI"
	oPrintPPP:Say( lin + 105, 1170, STR0187, oFont09n ) //"Eficaz"
	oPrintPPP:Line( lin, 1290, lin + 115, 1290 )
	oPrintPPP:Say( lin + 35, 1300, "15.8-", oFont09n ) //"15.8-"
	oPrintPPP:Say( lin + 70, 1300, STR0189, oFont09n ) //"C.A."
	oPrintPPP:Say( lin + 105, 1300, STR0188, oFont09n ) //"EPI"
	oPrintPPP:Line( lin, 1490, lin + 115, 1490 )
	oPrintPPP:Say( lin + 35, 1500, STR0101, oFont09n ) //"15.9-Atendimento aos requisitos das NR-06 e NR-01 do MTP" 
	oPrintPPP:Say( lin + 70, 1500, STR0333 + Space( 1 ) + '(*)', oFont09n ) //"pelos EPI's informados"
	oPrintPPP:Line( lin, 2940, lin + 115, 2940 )
	oPrintPPP:Line( lin + 115, 50, lin + 115, 2940 )
	
	SomaLinha( 115 )

	oPrintPPP:Line( lin, 50, lin + 115, 50 )
	oPrintPPP:Line( lin, 300, lin + 115, 300 )
	oPrintPPP:Line( lin, 410, lin + 115, 410 )
	oPrintPPP:Line( lin, 600, lin + 115, 600 )
	oPrintPPP:Line( lin, 850, lin + 115, 850 )
	oPrintPPP:Line( lin, 1030, lin + 115, 1030 )
	oPrintPPP:Line( lin, 1160, lin + 115, 1160 )
	oPrintPPP:Line( lin, 1290, lin + 115, 1290 )
	oPrintPPP:Line( lin, 1490, lin + 115, 1490 )

	oPrintPPP:Say( lin + 35, 1500, STR0324, oFont09n ) // "Medida de"
	oPrintPPP:Say( lin + 70, 1500, STR0334, oFont09n ) // "proteção"
	
	oPrintPPP:Line( lin, 1710, lin + 115, 1710 )
	oPrintPPP:Say( lin + 35, 1720, STR0325, oFont09n )  // "Condição de"
	oPrintPPP:Say( lin + 70, 1720, STR0335, oFont09n )  // "Funcionamento"
	oPrintPPP:Say( lin + 105, 1720, STR0336, oFont09n ) // "do EPI"

	oPrintPPP:Line( lin, 2020, lin + 115, 2020 )
	oPrintPPP:Say( lin + 35, 2030, STR0326, oFont09n ) // "Prazo de"
	oPrintPPP:Say( lin + 70, 2030, STR0337, oFont09n ) // "Validade"
	oPrintPPP:Say( lin + 105, 2030, STR0336, oFont09n ) // "do EPI"

	oPrintPPP:Line( lin, 2370, lin + 115, 2370 )
	oPrintPPP:Say( lin + 35, 2380, STR0327, oFont09n ) // "Periodicidade"
	oPrintPPP:Say( lin + 70, 2380, STR0338, oFont09n ) // "da Troca"
	oPrintPPP:Say( lin + 105, 2380, STR0336, oFont09n ) // "EPI"

	oPrintPPP:Line( lin, 2690, lin + 115, 2690 )
	oPrintPPP:Say( lin + 35, 2700, STR0328, oFont09n ) // "Higienização"
	oPrintPPP:Say( lin + 70, 2700, STR0336, oFont09n ) // "do EPI"

	oPrintPPP:Line( lin, 2940, lin + 115, 2940 )
	oPrintPPP:Line( lin + 115, 50, lin + 115, 2940 )

	SomaLinha( 115 )

	U_RECLASS_RISCOS() // Reclassifica os riscos
	lNot := .T.
	lEPIefic := .F.  // Indica se há pelo menos um EPI necessario que nao foi entregue.
	dbSelectArea( cTRBTN0 )
	dbSetOrder( 1 )
	dbGoTop()

	While !Eof()

		If (cTRBTN0)->ATIVO != "S"
			dbSelectArea( cTRBTN0 )
			dbSkip()
			Loop
		EndIf

		dDataIni := (cTRBTN0)->DT_DE
		dDataFim := IIf( (cTRBTN0)->DT_ATE == dDataBase .And. !lDemitido, CToD( "//" ), (cTRBTN0)->DT_ATE )

		aDatasPPP := fDesagData( dDataIni, dDataFim )

		For nX := 1 To Len( aDatasPPP )

			cGrau_Risco := " "

			If Len( aTMACombo ) == 0
				Do Case
				Case (cTRBTN0)->GRISCO == "1" ; cGrau_Risco := "F"
				Case (cTRBTN0)->GRISCO == "2" ; cGrau_Risco := "Q"
				Case (cTRBTN0)->GRISCO == "3" ; cGrau_Risco := "B"
				Case (cTRBTN0)->GRISCO == "4" ; cGrau_Risco := "E"
				Case (cTRBTN0)->GRISCO == "5" ; cGrau_Risco := "A"
				Case (cTRBTN0)->GRISCO == "6" ; cGrau_Risco := "M"
				End Case
			ElseIf ( nIND := aScan( aTMAcombo, { |x| Upper( Substr( x, 1, 1 ) ) == Substr( (cTRBTN0)->GRISCO, 1, 1 ) } ) ) > 0
				cGrau_Risco := Upper( Substr( aTMAcombo[nIND], 3, 1 ) )
			EndIf

			// EPC Eficaz
			If lConsEPC

				// Indica se esta condicao e satisfeita: 1-MV_NG2CEPC=S  2-TN0_EPC=2(Nao) 3-Medida de controle do risco é do tipo Proteção Coletiva
				// ou Medida de controle de riscos administrativas
				lEPCefic := .F.

				If ( nIND := aScan( aTN0combo, { |x| Upper( Substr( x, 1, 1 ) ) == Substr( (cTRBTN0)->EPC, 1, 1 ) } ) ) > 0
					cEPCefic := SubStr( aTN0combo[nIND], 1, 1 )

					If cEPCefic == "2"
						cEPCefic := "N"
						lEPCprot := .T.

						If lEpiCompl

							// Tipo da Medida de Controle = "2" (Protecao Coletiva) ou Medida de Controle = "4" ( Administrativas )
							If ( cTRBTN0 )->TIPCTR != " "
								lEPCefic := .T.
							EndIf

						EndIf

					ElseIf cEPCefic == "1"
						cEPCefic := "S"
						lEPCprot := .T.

						//Indica que empresa utiliza EPI em carater complementar mesmo quando o EPC for eficaz
						If lEpiCompl .And. !lEPCefic

							// Tipo da Medida de Controle = "2" (Protecao Coletiva) ou Medida de Controle = "4" ( Administrativas )
							If ( cTRBTN0 )->TIPCTR != " "
								lEPCefic := .T.
							EndIf

						EndIf

					Else
						cEPCefic := "NA"
					EndIf

				Else
					cEPCefic := "NA"
				EndIf

			EndIf

			If (cTRBTN0)->PROTEC == "N "

				If (cTRBTN0)->NECEPI != "2"
					lEPIefic := .T.
				EndIf

				lProtec := .T.

			ElseIf (cTRBTN0)->PROTEC == "S "
				lProtec := .T.
			EndIf

			// Trata a Intensidade para a impressao (Intensidade + Unidade de medida)
			If Empty( (cTRBTN0)->INTENS ) .And. (cTRBTN0)->AVALIA <> "1" .And. !Empty( (cTRBTN0)->OBSINT )
				cIntens := AllTrim( cValToChar( (cTRBTN0)->OBSINT ) )
			ElseIf !Empty( (cTRBTN0)->INTENS )
				cIntens := AllTrim( Substr( Transform( (cTRBTN0)->INTENS, cQTAGtra ), 1, IIf( "," $ cQTAGtra, nQTAGENt + 1, nQTAGENt ) ) +;
								    " " + Alltrim( (cTRBTN0)->UNIDAD ) )
			Else
				cIntens := "NA"
			EndIf

			nLinTec := MlCount( AllTrim( (cTRBTN0)->TECNIC ), 11 )
			nLinFat := MlCount( AllTrim( (cTRBTN0)->AGENTE ), 10 )
			nLinInt := MlCount( cIntens, 13 )

			// Busca do maior numero de linhas
			nMaxLin := nLinFat
			nMaxLin := IIf( nLinInt > nMaxLin, nLinInt, nMaxLin )
			nMaxLin := IIf( nLinTec > nMaxLin, nLinTec, nMaxLin )
			nMaxLin := IIf( nMaxLin <= 0, 1, nMaxLin ) // Garante que irá passar ao menos por uma linha

			// Se uma linha da seção 15 ficar dividida entre paginas, quebra a pagina
			If lin + nMaxLin > 1900
				SomaLinha( , , .T. )
			EndIf

			If lConsEPC

				If lEPCprot
					cEficEPC := IIf( lEPCefic, "S", "N" )
				EndIf

			EndIf

			If !lConsEPI

				If lProtec .And. lEpiNec
					cEPIefic  := IIf( lEPIefic, "N", "S" )
				EndIf

			EndIf

			If !lConsEPC .And. lEpiCompl
				If cEPIefic == "S" .And. ( cTRBTN0 )->PRZTNF == "S" .And. ( cTRBTN0 )->PRZDUR == "S"
					lEPCefic := .T.
					cEficEPC := "S"
					cEPCefic := "N"
				EndIf
			EndIf

			For nLinAtu := 1 To nMaxLin

				If nLinAtu == 1
					oPrintPPP:Say( lin + 35, 60, SubStr( aDatasPPP[nX], 1, 12 ), oFont09 ) // Periodo de Exposicao
					oPrintPPP:Say( lin + 70, 60, SubStr( aDatasPPP[nX], 14, 24 ), oFont09 )    // Periodo de Exposicao
					
					oPrintPPP:Say( lin + 35, 310, cGrau_Risco, oFont11 ) // Tipo de Risco

					oPrintPPP:Say( lin + 35, 1040, cEPCefic, oFont09 ) // EPC Eficaz

					// EPI Eficaz
					If !lConsEPI
						oPrintPPP:Say( lin + 35, 1170, IIf( Empty( (cTRBTN0)->PROTEC ), "NA", (cTRBTN0)->PROTEC ), oFont10 )
					EndIf

					// N. Cert. Aprov. EPI
					oPrintPPP:Say( lin + 35, 1300, IIf( Empty( (cTRBTN0)->NUMCAP ), "NA", (cTRBTN0)->NUMCAP ), oFont10 )
	
					oPrintPPP:Say( lin + 35, 1500, cEficEPC, oFont09 )
					oPrintPPP:Say( lin + 35, 1720, cEPIefic, oFont09 )
					oPrintPPP:Say( lin + 35, 2030, IIf( Empty( (cTRBTN0)->PRZTNF ), "NA", (cTRBTN0)->PRZTNF ), oFont09 )
					oPrintPPP:Say( lin + 35, 2380, IIf( Empty( (cTRBTN0)->PRZDUR ), "NA", (cTRBTN0)->PRZDUR ), oFont09 )
					oPrintPPP:Say( lin + 35, 2700, IIf( Empty( (cTRBTN0)->HIGIEN ), "NA", (cTRBTN0)->HIGIEN ), oFont09 )

				EndIf
				
				// Impressao da linhas verticais
				If nMaxLin != 1

					oPrintPPP:Line( lin, 50, lin + 50, 50 )
					oPrintPPP:Line( lin, 300, lin + 50, 300 )
					oPrintPPP:Line( lin, 410, lin + 50, 410 )
					oPrintPPP:Line( lin, 600, lin + 50, 600 )
					oPrintPPP:Line( lin, 850, lin + 50, 850 )
					oPrintPPP:Line( lin, 1030, lin + 50, 1030 )
					oPrintPPP:Line( lin, 1160, lin + 50, 1160 )
					oPrintPPP:Line( lin, 1290, lin + 50, 1290 )
					oPrintPPP:Line( lin, 1490, lin + 50, 1490 )
					oPrintPPP:Line( lin, 1710, lin + 50, 1710 )
					oPrintPPP:Line( lin, 2020, lin + 50, 2020 )
					oPrintPPP:Line( lin, 2370, lin + 50, 2370 )
					oPrintPPP:Line( lin, 2690, lin + 50, 2690 )
					oPrintPPP:Line( lin, 2940, lin + 50, 2940 )
				
				Else

					oPrintPPP:Line( lin, 50, lin + 100, 50 )
					oPrintPPP:Line( lin, 300, lin + 100, 300 )
					oPrintPPP:Line( lin, 410, lin + 100, 410 )
					oPrintPPP:Line( lin, 600, lin + 100, 600 )
					oPrintPPP:Line( lin, 850, lin + 100, 850 )
					oPrintPPP:Line( lin, 1030, lin + 100, 1030 )
					oPrintPPP:Line( lin, 1160, lin + 100, 1160 )
					oPrintPPP:Line( lin, 1290, lin + 100, 1290 )
					oPrintPPP:Line( lin, 1490, lin + 100, 1490 )
					oPrintPPP:Line( lin, 1710, lin + 100, 1710 )
					oPrintPPP:Line( lin, 2020, lin + 100, 2020 )
					oPrintPPP:Line( lin, 2370, lin + 100, 2370 )
					oPrintPPP:Line( lin, 2690, lin + 100, 2690 )
					oPrintPPP:Line( lin, 2940, lin + 100, 2940 )

				EndIf

				If !Empty( MemoLine( (cTRBTN0)->AGENTE, 10, nLinAtu ) )
					oPrintPPP:Say( lin + 35, 420, MemoLine( (cTRBTN0)->AGENTE, 10, nLinAtu ), oFont07 ) // Fator de Risco
				EndIf

				// Intensidade / Concentracao
				If !Empty( MemoLine( cIntens, 13, nLinAtu ) )
					oPrintPPP:Say( lin + 35, 610, MemoLine( cIntens, 13, nLinAtu ), oFont07 )
				EndIf

				If !Empty( MemoLine( (cTRBTN0)->TECNIC, 11, nLinAtu ) )
					oPrintPPP:Say( lin + 35, 860, MemoLine( (cTRBTN0)->TECNIC, 11, nLinAtu ), oFont07 ) // Tecnica Utilizada
				ElseIf nLinAtu == 1
					oPrintPPP:Say( lin + 35, 860, "NA", oFont07 )
				EndIf

				SomaLinha( 50, .T. ) // Registro sera impresso em uma linha
			Next nLinAtu

			If Empty( MemoLine( (cTRBTN0)->AGENTE, 10, nLinAtu ) ) .And. nLinAtu = 2

				SomaLinha( 50, .T. )
				oPrintPPP:Line( lin, 50, lin, 2940 )

			Else

				oPrintPPP:Line( lin, 50, lin, 2940 )
			
			EndIf
			
			lNot := .F.

		Next nX

		dbSelectArea( cTRBTN0 )
		dbSkip()

	End

	If lNot
		oPrintPPP:Line( lin, 50, lin + 115, 50 )
		oPrintPPP:Say( lin + 35, 60, "__/__/____" + STR0173, oFont09 )
		oPrintPPP:Say( lin + 70, 60, "__/__/____", oFont09 )
		oPrintPPP:Line( lin, 300, lin + 115, 300 )
		oPrintPPP:Line( lin, 410, lin + 115, 410 )
		oPrintPPP:Line( lin, 600, lin + 115, 600 )
		oPrintPPP:Line( lin, 850, lin + 115, 850 )
		oPrintPPP:Line( lin, 1030, lin + 115, 1036 )
		oPrintPPP:Line( lin, 1160, lin + 115, 1160 )
		oPrintPPP:Line( lin, 1290, lin + 115, 1290 )
		oPrintPPP:Line( lin, 1490, lin + 115, 1490 )
		oPrintPPP:Say( lin + 35, 1500, "NA", oFont10 )
		oPrintPPP:Line( lin, 1710, lin + 115, 1710 )
		oPrintPPP:Say( lin + 35, 1720, "NA", oFont10 )
		oPrintPPP:Line( lin, 2020, lin + 115, 2020 )
		oPrintPPP:Say( lin + 35, 2030, "NA", oFont10 )
		oPrintPPP:Line( lin, 2370, lin + 115, 2370 )
		oPrintPPP:Say( lin + 35, 2380, "NA", oFont10 )
		oPrintPPP:Line( lin, 2690, lin + 115, 2690 )
		oPrintPPP:Say( lin + 35, 2710, "NA", oFont10 )
		oPrintPPP:Line( lin, 2940, lin + 115, 2940 )
		oPrintPPP:Line( lin + 115, 50, lin + 115, 2940 )

		If Empty( cSRisc )
			oPrintPPP:Say( lin + 35, 310, "NA", oFont10 )  // 15.2 - Tipo
			oPrintPPP:Say( lin + 35, 420, "NA", oFont10 )  // 15.3 - Fator de Risco
			oPrintPPP:Say( lin + 35, 610, "NA", oFont10 ) // 15.4 - Intensidade
			oPrintPPP:Say( lin + 35, 860, "NA", oFont10 ) // 15.5 - Tecnica Utilizada
			oPrintPPP:Say( lin + 35, 1040, "NA", oFont10 ) // 15.6 - EPC Eficaz
			oPrintPPP:Say( lin + 35, 1170, "NA", oFont10 ) // 15.7 - EPI Eficaz
			oPrintPPP:Say( lin + 35, 1300, "NA", oFont10 ) // 15.8 - C.A. EPI
		Else
			oPrintPPP:Say( lin + 35, 310, Substr( cSRisc, 1, 4 ), oFont11 )
			oPrintPPP:Say( lin + 35, 420, Substr( cSRisc, 1, 11 ), oFont11 )
			oPrintPPP:Say( lin + 35, 610, Substr( cSRisc, 1, 15 ), oFont11 )
			oPrintPPP:Say( lin + 35, 860, Substr( cSRisc, 1, 10 ), oFont11 )
			oPrintPPP:Say( lin + 35, 1040, Substr( cSRisc, 1, 7 ), oFont11 )
			oPrintPPP:Say( lin + 35, 1170, Substr( cSRisc, 1, 7 ), oFont11 )
			oPrintPPP:Say( lin + 35, 1300, Substr( cSRisc, 1, 12 ), oFont11 )
		EndIf

		SomaLinha( 115 )

	EndIf

	oPrintPPP:Line( lin, 50, lin + 50, 50 ) // Linha da esquerda
	oPrintPPP:Say( lin + 40, 60, '*' + STR0329 + Space( 1 ) + '15.9:', oFont09 ) // "Legenda do item"
	oPrintPPP:Line( lin, 2940, lin + 50, 2940 ) // Linha da direita

	oPrintPPP:Line( lin + 50, 50, lin + 50, 2940 ) // Linha de baixo

	SomaLinha( 50, .T. )

	oPrintPPP:Line( lin, 50, lin + 50, 50 ) // Linha da esquerda
	oPrintPPP:Say( lin + 40, 90, MemoLine( STR0324 + Space( 1 ) + STR0334 + ':' + Space( 1 ) + STR0330, 150, 1 ), oFont09 )
	oPrintPPP:Line( lin, 2940, lin + 50, 2940 ) // Linha da direita

	SomaLinha( 50, .T. )

	oPrintPPP:Line( lin, 50, lin + 50, 50 ) // Linha da esquerda
	oPrintPPP:Say( lin + 40, 90, MemoLine( STR0324 + ':' + Space( 1 ) + STR0330, 150, 2 ), oFont09 )
	oPrintPPP:Line( lin, 2940, lin + 50, 2940 ) // Linha da direita

	SomaLinha( 50, .T. )

	oPrintPPP:Line( lin, 50, lin + 50, 50 ) // Linha da esquerda
	oPrintPPP:Say( lin + 40, 90, MemoLine( STR0324 + ':' + Space( 1 ) + STR0330, 150, 3 ), oFont09 )
	oPrintPPP:Line( lin, 2940, lin + 50, 2940 ) // Linha da direita

	SomaLinha( 50, .T. )

	oPrintPPP:Line( lin, 50, lin + 50, 50 ) // Linha da esquerda
	oPrintPPP:Say( lin + 40, 90, MemoLine( STR0324 + ':' + Space( 1 ) + STR0330, 150, 4 ), oFont09 )
	oPrintPPP:Line( lin, 2940, lin + 50, 2940 ) // Linha da direita

	oPrintPPP:Line( lin + 50, 50, lin + 50, 2940 ) // Linha de baixo

	SomaLinha( 50, .T. )

	oPrintPPP:Line( lin, 50, lin + 50, 50 ) // Linha da esquerda
	oPrintPPP:Say( lin + 40, 90, MemoLine( STR0325 + Space( 1 ) + STR0335 + Space( 1 ) + STR0336 +':' + Space( 1 ) + STR0331, 150, 1 ), oFont09 )
	oPrintPPP:Line( lin, 2940, lin + 50, 2940 ) // Linha da direita

	SomaLinha( 50, .T. )

	oPrintPPP:Line( lin, 50, lin + 50, 50 ) // Linha da esquerda
	oPrintPPP:Say( lin + 40, 90, MemoLine( STR0325 + ':' + Space( 1 ) + STR0331, 150, 2 ), oFont09 )
	oPrintPPP:Line( lin, 2940, lin + 50, 2940 ) // Linha da direita

	SomaLinha( 50, .T. )

	oPrintPPP:Line( lin, 50, lin + 50, 50 ) // Linha da esquerda
	oPrintPPP:Say( lin + 40, 90, MemoLine( STR0325 + ':' + Space( 1 ) + STR0331, 150, 3 ), oFont09 )
	oPrintPPP:Line( lin, 2940, lin + 50, 2940 ) // Linha da direita

	oPrintPPP:Line( lin + 50, 50, lin + 50, 2940 ) // Linha de baixo

	SomaLinha( 50, .T. )

	oPrintPPP:Line( lin, 50, lin + 50, 50 ) // Linha da esquerda
	oPrintPPP:Say( lin + 40, 90, MemoLine( STR0326 + Space( 1 ) + STR0337 + Space( 1 ) + STR0336 + ':' + Space( 1 ) + STR0107, 150, 1 ), oFont09 )
	oPrintPPP:Line( lin, 2940, lin + 50, 2940 ) // Linha da direita

	SomaLinha( 50, .T. )

	oPrintPPP:Line( lin, 50, lin + 50, 50 ) // Linha da esquerda
	oPrintPPP:Say( lin + 40, 90, MemoLine( STR0326 + ':' + Space( 1 ) + STR0107, 150, 2 ), oFont09 )
	oPrintPPP:Line( lin, 2940, lin + 50, 2940 ) // Linha da direita

	oPrintPPP:Line( lin + 50, 50, lin + 50, 2940 ) // Linha de baixo

	SomaLinha( 50, .T. )

	oPrintPPP:Line( lin, 50, lin + 50, 50 ) // Linha da esquerda
	oPrintPPP:Say( lin + 40, 90, MemoLine( STR0327 + Space( 1 ) + STR0338 + Space( 1 ) + STR0336 +':' + Space( 1 ) + STR0332, 150, 1 ), oFont09 )
	oPrintPPP:Line( lin, 2940, lin + 50, 2940 ) // Linha da direita

	SomaLinha( 50, .T. )

	oPrintPPP:Line( lin, 50, lin + 50, 50 ) // Linha da esquerda
	oPrintPPP:Say( lin + 40, 90, MemoLine( STR0327 + ':' + Space( 1 ) + STR0332, 150, 2 ), oFont09 )
	oPrintPPP:Line( lin, 2940, lin + 50, 2940 ) // Linha da direita

	oPrintPPP:Line( lin + 50, 50, lin + 50, 2940 ) // Linha de baixo

	SomaLinha( 50, .T. )

	oPrintPPP:Line( lin, 50, lin + 50, 50 ) // Linha da esquerda
	oPrintPPP:Say( lin + 40, 90, STR0328 + Space( 1 ) + STR0336 + ':' + Space( 1 ) + STR0110, oFont09 )
	oPrintPPP:Line( lin, 2940, lin + 50, 2940 ) // Linha da direita

	oPrintPPP:Line( lin + 50, 50, lin + 50, 2940 ) // Linha de baixo

	SomaLinha( 50, .T. )

	// FIM RISCO
	oPrintPPP:Line( lin, 50, lin + 60, 50 )
	oPrintPPP:Say( lin + 45, 70, "16", oFont11 )
	oPrintPPP:Line( lin, 150, lin + 60, 150 )
	oPrintPPP:Say( lin + 45, 160, STR0191, oFont11 ) //"RESPONSÁVEL PELOS REGISTROS AMBIENTAIS:"
	oPrintPPP:Line( lin, 2940, lin + 60, 2940 )
	oPrintPPP:Line( lin + 60, 50, lin + 60, 2940 )
	SomaLinha()
	oPrintPPP:Line( lin, 50, lin + 80, 50 )
	oPrintPPP:Say( lin + 35, 60, STR0192, oFont09n ) //"16.1-Período"
	oPrintPPP:Line( lin, 550, lin + 80, 550 )
	oPrintPPP:Say( lin + 35, 560, STR0193, oFont09n ) // "16.2-CPF"
	oPrintPPP:Line( lin, 880, lin + 80, 880 )
	oPrintPPP:Say( lin + 35, 890, STR0194, oFont09n ) //"16.3-Registro Conselho"
	oPrintPPP:Say( lin + 70, 890, STR0195, oFont09n ) //"de Classe"
	oPrintPPP:Line( lin, 1350, lin + 80, 1350 )
	oPrintPPP:Say( lin + 35, 1360, STR0196, oFont09n ) //"16.4-Nome do Profissional Legalmente "
	oPrintPPP:Say( lin + 70, 1360, STR0320, oFont09n ) // "Habilitado"
	oPrintPPP:Line( lin, 2940, lin + 80, 2940 )
	oPrintPPP:Line( lin + 80, 50, lin + 80, 2940 )
	SomaLinha( 30 )

	lFirst := .T.

	dbSelectArea( cTRBTMK )
	dbSetOrder( 1 )
	dbGoTop()

	// Verifica o conteudo da pergunta "Reponsavel Ambiental ?"
	If xm_par31 == 1 // Somente Médicos
		cCondInd := "1"
	ElseIf xm_par31 == 2 // Somente Engenheiros
		cCondInd := "4"
	ElseIf xm_par31 == 3 // Ambos
		cCondInd := "1/4"
	EndIf

	While !Eof()

		If NGCADICBASE( "TMK_RESAMB", "A", "TMK", .F. ) // Existe o campo TMK_RESAMB
			lRespAmb := ( (cTRBTMK)->RESAMB == "1" ) // Verifica se e Responsavel Ambiental
		EndIf

		// Se nao for Responsavel Ambiental ou nao for da funcao definida pela pergunta Mv_Par31 pula o registro
		If (!Empty( cCondInd ) .And. !( (cTRBTMK)->INDFUN $ cCondInd )) .Or. !lRespAmb
			dbSelectArea( cTRBTMK )
			dbSkip()
			Loop
		EndIf

		If ((cTRBTMK)->DTINI > (IIf( !lDemitido, dDataBase, dDtDemiss ))) .Or. ;
			(!Empty( (cTRBTMK)->DTFIM ) .And. (cTRBTMK)->DTFIM < dDtAdmiss)

			dbselectArea( cTRBTMK )
			dbSkip()
			Loop
		EndIf

		If lRespFim
			dDataIni := (cTRBTMK)->DTINI
			dDataFim := (cTRBTMK)->DTFIM
		Else
			dDataIni := IIf( (cTRBTMK)->DTINI < dDtAdmiss, dDtAdmiss, (cTRBTMK)->DTINI )

			If Empty( (cTRBTMK)->DTFIM )
				dDataFim := dDtDemiss
			Else

				If !lDemitido
					dDataFim := IIf( (cTRBTMK)->DTFIM >= dDataBase, dDtDemiss, (cTRBTMK)->DTFIM )
				Else
					dDataFim := IIf( (cTRBTMK)->DTFIM >= dDtDemiss, dDtDemiss, (cTRBTMK)->DTFIM )
				EndIf

			EndIf

		EndIf

		aDatasPPP := fDesagData( dDataIni, dDataFim )

		For nX := 1 To Len( aDatasPPP )

			If lin != 380 .Or. !lFirst
				SomaLinha( 50, lFirst )
			EndIf

			lFirst := .F.
			oPrintPPP:Line( lin, 50, lin + 50, 50 )
			oPrintPPP:Say( lin + 35, 60, aDatasPPP[nX], oFont09 )
			oPrintPPP:Line( lin, 550, lin + 50, 550 )

			If !Empty( ( cTRBTMK )->CIC )
				oPrintPPP:Say( lin + 35, 560, Transform( ( cTRBTMK )->CIC, '@R 999.999.999-99' ), oFont08 ) // CPF
			EndIf

			oPrintPPP:Line( lin, 880, lin + 50, 880 )

			If !Empty( (cTRBTMK)->REGNUM )
				oPrintPPP:Say( lin + 35, 890, (cTRBTMK)->REGNUM, oFont09 ) // Registro MTB
			Else
				oPrintPPP:Say( lin + 35, 890, "NA", oFont10 ) // Registro MTB
			EndIf

			oPrintPPP:Line( lin, 1350, lin + 50, 1350 )
			oPrintPPP:Say( lin + 35, 1360, Substr( (cTRBTMK)->NOME, 1, 40 ), oFont09 ) // Nome
			oPrintPPP:Line( lin, 2940, lin + 50, 2940 )
			oPrintPPP:Line( lin + 50, 50, lin + 50, 2940 )
		Next nX

		dbSelectArea( cTRBTMK )
		dbSkip()
	End

	If lFirst

		If lin != 380
			SomaLinha( 50, .T. )
		EndIf

		oPrintPPP:Line( lin, 50, lin + 50, 50 )
		oPrintPPP:Say( lin + 35, 60, "__/__/____" + STR0173 + "__/__/____", oFont09 )
		oPrintPPP:Say( lin + 35, 890, "NA", oFont10 )   //16.3-Registro MTB
		oPrintPPP:Say( lin + 35, 1360, "NA", oFont10 ) //16.4-Nome
		oPrintPPP:Line( lin, 550, lin + 50, 550 )
		oPrintPPP:Line( lin, 880, lin + 50, 880 )
		oPrintPPP:Line( lin, 1350, lin + 50, 1350 )
		oPrintPPP:Line( lin, 2940, lin + 50, 2940 )
		oPrintPPP:Line( lin + 50, 50, lin + 50, 2940 )
	EndIf

	// QUARTA PARTE
	SomaLinha( 80 )

	If ( lin + 715 ) > 2000
		SomaLinha( , , .T. )
	EndIf

	If lin != 380
		oPrintPPP:Line( lin, 50, lin, 2940 )
	EndIf

	oPrintPPP:Line( lin, 50, lin + 80, 50 )
	oPrintPPP:Line( lin, 2940, lin + 80, 2940 )
	oPrintPPP:Line( lin + 80, 50, lin + 80, 2940 )
	oPrintPPP:Say( lin + 60, 70, STR0219, oFont13 ) //"RESPONSÁVEIS PELAS INFORMAÇÕES"
	SomaLinha( 80 )
	txtPPP := STR0220 //"Declaramos, para todos os fins de direito, que as informações prestadas neste documento são "
	txtPPP += STR0221 //"verídicas e foram transcritas fielmente dos registros administrativos, das demonstrações "
	txtPPP += STR0222 //"ambientais e dos programas médicos de responsabilidade da empresa. É de nosso conhecimento que "
	txtPPP += STR0223 //"a prestação de informações falsas neste documento constitui crime de falsificação de documento "
	txtPPP += STR0224 //"público, nos termos do art. 297 do Código Penal e, também, que tais informações são de caráter "
	txtPPP += STR0225 //"privativo do trabalhador, constituindo crime, nos termos da Lei nº 9.029 de 13 de Abril de 1995, práticas "
	txtPPP += STR0226 //"discriminatórias decorrentes de sua exigibilidade por outrem, bem como se sua divulgação para "
	txtPPP += STR0227 //"terceiros, ressalvado quando exigida pelos órgãos públicos competentes."

	fImpMemo( txtPPP )

	dbSelectArea( cAliasRES )
	dbSetOrder( 1 )
	dbSeek( xFilial( cAliasRES, cFilRES ) + xm_par09 ) // Representante Empresa ?

	SomaLinha( 55 )
	oPrintPPP:Line( lin, 50, lin + 60, 50 )
	oPrintPPP:Say( lin + 50, 60, STR0228, oFont10 ) // "19-Data Emissão PPP"
	oPrintPPP:Line( lin, 500, lin + 60, 500 )
	oPrintPPP:Say( lin + 45, 520, '18', oFont11 )
	oPrintPPP:Line( lin, 580, lin + 60, 580 )
	oPrintPPP:Say( lin + 45, 590, STR0229, oFont11 ) // "REPRESENTANTE LEGAL DA EMPRESA"
	oPrintPPP:Line( lin, 2940, lin + 60, 2940 )
	oPrintPPP:Line( lin + 60, 50, lin + 60, 2940 )
	SomaLinha()

	// Ponto de Entrada para adicionar um responsavel Legal
	If ExistBlock( "MDTR7002" )
		ExecBlock( "MDTR7002", .F., .F., { oPrintPPP, lin } )
	Else
		oPrintPPP:Line( lin, 50, lin + 500, 50 )
		oPrintPPP:Line( lin, 2940, lin + 500, 2940 )
		oPrintPPP:Line( lin + 500, 50, lin + 500, 2940 )
		oPrintPPP:Line( lin + 100, 500, lin + 100, 2940 )
		oPrintPPP:Line( lin, 500, lin + 500, 500 )
		oPrintPPP:Say( lin + 30, 510, STR0230, oFont09 ) // "18.1-CPF do Representante Legal"

		If !Empty( &cCpfRes )
			oPrintPPP:Say( lin + 90, 510, Transform( &cCpfRes, '@R 999.999.999-99' ), oFont10 )
		Else
			oPrintPPP:Say( lin + 90, 510, "NA", oFont10 )
		EndIf

		oPrintPPP:Line( lin, 1300, lin + 500, 1300 )
		oPrintPPP:Say( lin + 30, 1310, STR0231, oFont09 ) // "18.2-Nome do Representante Legal"


		If	( !Empty( SRA->RA_NOMECMP ) ) .And. ( Alltrim( GETMV( "MV_MDTRESP" ) ) == "1" )
			oPrintPPP:Say( lin + 90, 1310, AllTrim( SubSTR( SRA->RA_NOMECMP, 1, 45 ) ), oFont10 )
		Else
			oPrintPPP:Say( lin + 90, 1310, Substr( &cCNomeRES, 1, 40 ), oFont10 )
		EndIf

		oPrintPPP:Say( lin + 210, 150, U_NGPPPDATE( IIf( xm_par21 == 3, xm_par22, IIf( xm_par21 == 2, dDtDemiss, dDataBase ) ), .T. ), oFont10 ) //Data Emissao PPP ?//Informe a Data ?
		oPrintPPP:Say( lin + 480, 700, STR0232, oFont09 ) // "(Carimbo da Empresa)"
		oPrintPPP:Line( lin + 430, 1400, lin + 430, 2110 )
		oPrintPPP:Say( lin + 480, 1450, STR0233, oFont09 ) // "(Assinatura física ou eletrônica)"
	EndIf

	SomaLinha( 520 )
	oPrintPPP:Line( lin, 50, lin, 2940 )
	oPrintPPP:Line( lin, 50, lin + 80, 50 )
	oPrintPPP:Line( lin, 2940, lin + 80, 2940 )
	oPrintPPP:Line( lin+ 80, 50, lin + 80, 2940 )
	oPrintPPP:Say( lin + 60, 60, STR0234, oFont13 ) // "OBSERVAÇÕES"
	SomaLinha( 80 )

	dbSelectArea( "TMZ" )
	dbSetOrder( 1 )
	dbSeek( xFilial( "TMZ" ) + xm_par14 ) // Observacao ?

	If !Empty( xm_par14 ) .And. !Empty( TMZ->TMZ_DESCRI ) // Se a pergunta de Observações está vazia não imprime
		fImpMemo( TMZ->TMZ_DESCRI )

		If xm_par23 == 1// .And. !Empty( xm_par24 )
			SomaLinha( 55, .F. )
		EndIf

	EndIf

	If xm_par23 == 1 // Listar Observ. Epis ?

		oPrintPPP:Line( lin, 50, lin + 60, 50 )
		oPrintPPP:Say( lin + 50, 70, STR0235, oFont11 ) // "OBSERVAÇÕES REFERENTES AOS EPI'S"
		oPrintPPP:Line( lin, 2940, lin + 60, 2940 )
		oPrintPPP:Line( lin + 60, 50, lin + 60, 2940 )
		SomaLinha( 60 )

		For nInd := 1 To Len( aNUMCAPS )
			oPrintPPP:Line( lin, 50, lin + 40, 50 )
			oPrintPPP:Line( lin, 2940, lin + 40, 2940 )
			oPrintPPP:Say( lin + 40, 60, Substr( STR0236 + Alltrim( aNUMCAPS[nInd, 1] ) + " - " + aNUMCAPS[nInd, 2], 1, 105 ), oFont09 ) //"C.A.: "

			If nInd == Len( aNUMCAPS )
				oPrintPPP:Line( lin + 40, 50, lin + 55, 50 )
				oPrintPPP:Line( lin + 40, 2940, lin + 55, 2940 )
				oPrintPPP:Line( lin + 55, 50, lin + 55, 2940 )
				SomaLinha( 40, .F. )
			Else
				SomaLinha( 40, .T. )
			EndIf

		Next nInd

	EndIf

	If !Empty( xm_par24 ) .And. xm_par23 == 1 // Observacao EPI \ EPC. ? //Listar Observ. Epis ?
		oPrintPPP:Line( lin, 50, lin + 60, 50 )
		oPrintPPP:Say( lin + 50, 70, STR0237, oFont11 ) // "OBSERVAÇÕES REFERENTES AOS EPI's / EPC's"
		oPrintPPP:Line( lin, 2940, lin + 60, 2940 )
		oPrintPPP:Line( lin + 60, 50, lin + 60, 2940 )
		SomaLinha( 60 )
		dbSelectArea( "TMZ" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "TMZ" ) + xm_par24 ) // Observacao EPI \ EPC. ?

		fImpMemo( TMZ->TMZ_DESCRI )

	EndIf

	RestArea( aAreaSRA )
	RestArea( aSM0Area )

	oPrintPPP:SayAlign( 2200, 50, Str( nPaginaPPP, 3 ), oFont09n, 2940, 280, CLR_BLACK, 2, 1 )
	oPrintPPP:EndPage()
	nPaginaPPP++

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} fValHisRep
Valida se há informações repetidas na impressão do item 13

@author Gabriel Sokacheski
@since 11/09/2024

@param aHistorico, histórico do funcionário

@return aNovo, histórico do funcionário para impressão do item 13
/*/
//-------------------------------------------------------------------
Static Function fValHisRep( aHistorico )

	Local aNovo			:= {}

	Local nAnterior 	:= 0
	Local nHistorico 	:= 0

	// Remove as linhas duplicadas que não devem ser impressas e ajusta as datas do histórico
	For nHistorico := 1 To Len( aHistorico )

		If nHistorico != 1

			nAnterior := nHistorico - 1

			If aHistorico[ nHistorico, 5 ] == aHistorico[ nAnterior, 5 ] .And. aHistorico[ nHistorico, 6 ] == aHistorico[ nAnterior, 6 ];
			.And. aHistorico[ nHistorico, 7 ] == aHistorico[ nAnterior, 7 ] .And. aHistorico[ nHistorico, 8 ] == aHistorico[ nAnterior, 8 ];
			.And. aHistorico[ nHistorico, 9 ] == aHistorico[ nAnterior, 9 ] .And. aHistorico[ nHistorico, 10 ] == aHistorico[ nAnterior, 10 ]

				aNovo[ Len( aNovo ), 4 ] :=  aHistorico[ nHistorico, 4 ]

			Else

				aAdd( aNovo, aHistorico[ nHistorico ] )

			EndIf

		Else

			aAdd( aNovo, aHistorico[ nHistorico ] )

		EndIf

	Next nHistorico

Return aNovo

//-------------------------------------------------------------------
/*/{Protheus.doc} fVerAte
Verifica se o funcionário é um atendente prestador de
serviço (SIGATEC)

@author Gabriel Sokacheski
@since 02/03/2023

@return lAtendente, verdadeiro caso o funcionário seja um atendente
/*/
//-------------------------------------------------------------------
Static Function fVerAte()

	Local aArea := GetArea( 'AA1' )

	Local lAtendente := .F.

	If SuperGetMv( 'MV_NG2GS', .F., .F. ) // Integração com o módulo prestador de serviço (SIGATEC)

		DbSelectArea( 'AA1' )
		DbSetOrder( 7 )

		If DbSeek( xFilial( 'AA1' ) + SRA->RA_MAT + SRA->RA_FILIAL ) // Caso o funcionário seja um atendente
			lAtendente := .T.
		EndIf

	EndIf

	RestArea( aArea )

Return lAtendente

//-------------------------------------------------------------------
/*/{Protheus.doc} fVerBusHis
Verifica como deve ser e retorna o histórico correto do funcionário

@author Gabriel Sokacheski
@since 02/03/2023

@return aHistorico, contém o histórico do funcionário
/*/
//-------------------------------------------------------------------
Static Function fVerBusHis()

	Local aArea := GetArea( 'AA1' )

	Local aHistorico := {}

	If SuperGetMv( 'MV_NG2GS', .F., .F. ) // Integração com o módulo prestador de serviço (SIGATEC)

		DbSelectArea( 'AA1' )
		DbSetOrder( 7 )

		If DbSeek( xFilial( 'AA1' ) + SRA->RA_MAT + SRA->RA_FILIAL ) // Caso o funcionário seja um atendente
			aHistorico := aClone( fHisPreSer( AA1->AA1_CODTEC ) )
		Else // Caso o funcionário não seja um atendente
			aHistorico := aClone( U_NG700HISTO() )
		EndIf

	Else

		aHistorico := aClone( U_NG700HISTO() )

	EndIf

	RestArea( aArea )

Return aHistorico

//-------------------------------------------------------------------
/*/{Protheus.doc} fHisPreSer
Busca o histórico do funcionário atendente no módulo prestador de
serviço (SIGATEC)

@author Gabriel Sokacheski
@since 02/03/2023

@param cAtendente, código de atendente no módulo prestador de serviço

@return aHistorico, contém o histórico do funcionário
/*/
//-------------------------------------------------------------------
Static Function fHisPreSer( cAtendente )

	Local aDados		:= { { cEmpAnt, cFilAnt, SRA->RA_MAT } } // Dados da empresa e filial atual do funcionário
	Local aTabelas		:= {;
		{ 'TGY', 01 },;
		{ 'TFF', 01 },;
		{ 'ABS', 01 },;
		{ 'SA1', 01 },;
		{ 'SRA', 01 },;
		{ 'CTT', 01 },;
		{ 'SR9', 01 },;
		{ 'SR7', 01 },;
		{ 'SRJ', 01 },;
		{ 'SQ3', 01 },;
		{ 'TM0', 01 };
	} // Tabelas utilizadas na query
	Local aHistorico	:= {}

	Local cGFIP 		:= ''
	Local cBusEmp		:= cEmpAnt
	Local cBusFil		:= cFilAnt
	Local cBusMat		:= SRA->RA_MAT
	Local cVerEmp		:= SuperGetMv( 'MV_NG2MEMP', .F., 'N' ) // Considera histórico em outras empresas
	Local cVerFil		:= SuperGetMv( 'MV_NG2MFIL', .F., 'N' ) // Considera histórico em outras filiais
	Local cAliasTGY		:= ''
	Local cAliasSRE 	:= ''
	Local cEmpBackup	:= cEmpAnt
	Local cEmpDad       := ''
	Local cFilBackup	:= cFilAnt
	Local cR7CARGO		:= Space( TamSx3( 'R7_CARGO' 	)[ 1 ] )
	Local cRJCARGO		:= Space( TamSx3( 'RJ_CARGO' 	)[ 1 ] )
	Local cR7FUNCAO		:= Space( TamSx3( 'R7_FUNCAO' 	)[ 1 ] )
	Local cTFFCARGO		:= Space( TamSx3( 'TFF_CARGO' 	)[ 1 ] )
	Local cABSCCUSTO	:= Space( TamSx3( 'ABS_CCUSTO' 	)[ 1 ] )
	Local cTFFFUNCAO	:= Space( TamSx3( 'TFF_FUNCAO' 	)[ 1 ] )

	Local dCorte 		:= fBusDatCor() // Data de corde do PPP
	Local dInicio		:= CtoD( '//' )
	Local dFim			:= CtoD( '//' )

	Local lCorta		:= .T.
	Local lVerTra		:= .T.

	Local nReg			:= 1
	Local nDado 		:= 0

	If mv_par37 == 2 .And. cVerFil == 'S' // Busca as empresas e filiais em que o funcionário trabalhou

		While lVerTra

			cAliasSRE := GetNextAlias()

			BeginSQL Alias cAliasSRE
				SELECT
					RE_EMPD, RE_FILIALD, RE_MATD
				FROM
					%table:SRE% SRE
				WHERE
					RE_EMPP = %exp:cBusEmp%
					AND RE_FILIALP = %exp:cBusFil%
					AND RE_MATP = %exp:cBusMat%
					AND %notDel%
			EndSQL

			( cAliasSRE )->( DbGoTop() )

			If ( cAliasSRE )->( !EoF() )

				If ( cVerEmp == 'S' .Or. cEmpAnt == ( cAliasSRE )->RE_EMPD )

					aAdd( aDados, {;
						( cAliasSRE )->RE_EMPD,;
						( cAliasSRE )->RE_FILIALD,;
						( cAliasSRE )->RE_MATD;
					} )

					cBusEmp := ( cAliasSRE )->RE_EMPD
					cBusFil := ( cAliasSRE )->RE_FILIALD
					cBusMat := ( cAliasSRE )->RE_MATD

				EndIf

			Else

				lVerTra := .F.

			EndIf

			( cAliasSRE )->( DbCloseArea() )

		End

	EndIf

	For nDado := 1 To Len( aDados )

		cAliasTGY := GetNextAlias()

		cEmpDad := aDados[ nDado, 1 ]

		If cEmpAnt != aDados[ nDado, 1 ] // Abre as tabelas e posiciona em outra empresa caso necessário
			fOpenSX( { 'SX3' }, aDados[ nDado, 1 ] )
			NGPrepTBL( aTabelas, aDados[ nDado, 1 ], aDados[ nDado, 2 ] )
			cR7CARGO	:= Space( TamSx3( 'R7_CARGO' 	)[ 1 ] )
			cRJCARGO	:= Space( TamSx3( 'RJ_CARGO' 	)[ 1 ] )
			cABSCUSTO	:= Space( TamSx3( 'ABS_CCUSTO' 	)[ 1 ] )
			cR7FUNCAO	:= Space( TamSx3( 'R7_FUNCAO' 	)[ 1 ] )
			cTFFCARGO	:= Space( TamSx3( 'TFF_CARGO' 	)[ 1 ] )
			cTFFFUNCAO	:= Space( TamSx3( 'TFF_FUNCAO' 	)[ 1 ] )
		EndIf

		If cFilAnt != aDados[ nDado, 2 ] // Posiciona em outra filial caso necessário
			cFilAnt := aDados[ nDado, 2 ]
		EndIf

		BeginSQL Alias cAliasTGY
			SELECT
				SRA.RA_FILIAL, SRA.RA_MAT, TGY.TGY_DTINI, TGY.TGY_DTFIM, SA1.A1_CGC, CTT.CTT_DESC01, SQ3.Q3_DESCSUM,
				SRJ.RJ_DESC, SRJ.RJ_CODCBO, SR9.R9_DESC, CTT.CTT_OCORRE, SRA.RA_OCORREN, CTT.CTT_CUSTO, SRA.RA_DEPTO,
				SQ3.Q3_CARGO, SRJ.RJ_FUNCAO, TM0.TM0_NUMFIC
			FROM
				%table:SRA% SRA
				INNER JOIN
					%table:AA1% AA1 ON
						AA1.AA1_FUNFIL = SRA.RA_FILIAL
						AND AA1.AA1_CDFUNC = SRA.RA_MAT
						AND AA1.%notDel%
				INNER JOIN
					%table:TGY% TGY ON
						TGY.TGY_FILIAL = %xFilial:TGY%
						AND TGY.TGY_ATEND = AA1.AA1_CODTEC
						AND TGY.%notDel%
				INNER JOIN
					%table:TFF% TFF ON
						TFF.TFF_FILIAL = %xFilial:TFF%
						AND TFF.TFF_COD = TGY.TGY_CODTFF
						AND TFF.%notDel%
				INNER JOIN
					%table:ABS% ABS ON
						ABS.ABS_FILIAL = %xFilial:ABS%
						AND ABS.ABS_LOCAL = TFF.TFF_LOCAL
						AND ABS.%notDel%
				INNER JOIN
					%table:SA1% SA1 ON
						SA1.A1_FILIAL = %xFilial:SA1%
						AND SA1.A1_COD = ABS.ABS_CODIGO
						AND SA1.A1_LOJA = ABS.ABS_LOJA
						AND SA1.%notDel%
				INNER JOIN
					%table:CTT% CTT ON
						CTT.CTT_FILIAL = %xFilial:CTT%
						AND CTT.CTT_CUSTO = 
							CASE
								WHEN ABS.ABS_CCUSTO != %exp:cABSCCUSTO% THEN
									ABS.ABS_CCUSTO
								ELSE
									SRA.RA_CC
							END
						AND CTT.%notDel%
				LEFT JOIN
					%table:SR9% SR9 ON
						SR9.R9_FILIAL = SRA.RA_FILIAL
						AND SR9.R9_MAT = SRA.RA_MAT
						AND SR9.R9_CAMPO = "RA_OCORREN"
						AND SR9.R9_DATA >= TGY.TGY_DTINI
						AND SR9.R9_DATA <= TGY.TGY_DTFIM
						AND SR9.%notDel%
				LEFT JOIN
					%table:SR7% SR7 ON
						SR7.R7_FILIAL = SRA.RA_FILIAL
						AND SR7.R7_MAT = SRA.RA_MAT
						AND SR7.R7_DATA >= TGY.TGY_DTINI
						AND SR7.R7_DATA <= TGY.TGY_DTFIM
						AND SR7.%notDel%
				LEFT JOIN
					%table:SRJ% SRJ ON
						SRJ.RJ_FILIAL = %xFilial:SRJ%
						AND SRJ.RJ_FUNCAO = 
							CASE 
								WHEN TFF.TFF_FUNCAO != %exp:cTFFCARGO% THEN
									TFF.TFF_FUNCAO
								WHEN SR7.R7_FUNCAO != %exp:cR7FUNCAO% THEN
									SR7.R7_FUNCAO
								ELSE
									SRA.RA_CODFUNC
							END
						AND SRJ.%notDel%
				LEFT JOIN
					%table:SQ3% SQ3 ON
						SQ3.Q3_FILIAL = %xFilial:SQ3%
						AND SQ3.Q3_CARGO = 
							CASE
								WHEN TFF.TFF_CARGO != %exp:cTFFFUNCAO% THEN
									TFF.TFF_CARGO
								WHEN SR7.R7_CARGO != %exp:cR7CARGO% THEN
									SR7.R7_CARGO
								WHEN SRJ.RJ_CARGO != %exp:cRJCARGO% THEN
									SRJ.RJ_CARGO
								ELSE
									SRA.RA_CARGO
							END
						AND SQ3.Q3_CC = CTT.CTT_CUSTO
						AND SQ3.%notDel%
				LEFT JOIN
					%table:TM0% TM0 ON
						TM0.TM0_FILFUN = SRA.RA_FILIAL
						AND TM0.TM0_MAT = SRA.RA_MAT
						AND TM0.%notDel%
			WHERE
				SRA.RA_FILIAL = %exp:aDados[ nDado, 2 ]%
				AND SRA.RA_MAT = %exp:aDados[ nDado, 3 ]%
				AND SRA.%notDel%
			GROUP BY
				SRA.RA_FILIAL, SRA.RA_MAT, TGY.TGY_DTINI, TGY.TGY_DTFIM, SA1.A1_CGC, CTT.CTT_DESC01, SQ3.Q3_DESCSUM,
				SRJ.RJ_DESC, SRJ.RJ_CODCBO, SR9.R9_DESC, CTT.CTT_OCORRE, SRA.RA_OCORREN, CTT.CTT_CUSTO, SRA.RA_DEPTO,
				SQ3.Q3_CARGO, SRJ.RJ_FUNCAO, TM0.TM0_NUMFIC
			ORDER BY
				TGY.TGY_DTINI, TGY.TGY_DTFIM
		EndSQL

		( cAliasTGY )->( DbGoTop() )

		While ( cAliasTGY )->( !EoF() )

			fRedDat( cAliasTGY, @dInicio, @dFim )

			// Se existir uma data de corte verifica quais registros devem ser impressos e qual é a data de início
			If !Empty( dCorte )

				While lCorta

					If dCorte > dInicio .And. !Empty( dInicio ) // Pula para o próximo registro

						nReg := ( cAliasTGY )->( Recno() )
						( cAliasTGY )->( DbSkip() )
						fRedDat( cAliasTGY, @dInicio, @dFim )

					Else

						If dCorte != dInicio // Volta para o registro anterior

							( cAliasTGY )->( DbGoTop() )
							( cAliasTGY )->( DbGoTo( nReg ) )
							fRedDat( cAliasTGY, @dInicio, @dFim )

							If dCorte > dInicio // Define a data de início com o valor da data de corte
								dInicio := dCorte
							EndIf

							lCorta := .F.

						EndIf

					EndIf

				End

			EndIf

			If dCorte <= dFim

				If !Empty( ( cAliasTGY )->CTT_OCORRE )
					cGFIP := ( cAliasTGY )->CTT_OCORRE
				ElseIf !Empty( ( cAliasTGY )->R9_DESC )
					cGFIP := ( cAliasTGY )->R9_DESC
				ElseIf !Empty( ( cAliasTGY )->RA_OCORREN )
					cGFIP := ( cAliasTGY )->RA_OCORREN
				EndIf

				aAdd( aHistorico, {;
					( cAliasTGY )->RA_FILIAL,; 			// [1]
					( cAliasTGY )->RA_MAT,; 			// [2]
					dInicio,;							// [3]
					dFim,; 								// [4]
					( cAliasTGY )->CTT_DESC01,; 		// [5]
					( cAliasTGY )->Q3_DESCSUM,; 		// [6]
					( cAliasTGY )->RJ_DESC,; 			// [7]
					( cAliasTGY )->RJ_CODCBO,; 			// [8]
					cGFIP,;								// [9]
					( cAliasTGY )->A1_CGC,; 			// [10]
					2,; 								// [11]
					aDados[ nDado, 1 ]; 				// [12]
				} )

				//-----------------------------
				// Utilizado nos itens 14 e 15
				//-----------------------------

				RecLock( cTrbPPP, .T. )

					( cTrbPPP )->DTDE   := dInicio
					( cTrbPPP )->DTATE  := dFim
					( cTrbPPP )->CNPJ   := ( cAliasTGY )->A1_CGC
					( cTrbPPP )->TIPINS := 2
					( cTrbPPP )->CUSTO  := ( cAliasTGY )->CTT_CUSTO
					( cTrbPPP )->DEPTO  := ( cAliasTGY )->RA_DEPTO
					( cTrbPPP )->FILIAL := ( cAliasTGY )->RA_FILIAL
					( cTrbPPP )->MAT    := ( cAliasTGY )->RA_MAT
					( cTrbPPP )->CARGO  := ( cAliasTGY )->Q3_CARGO
					( cTrbPPP )->CODFUN	:= ( cAliasTGY )->RJ_FUNCAO
					( cTrbPPP )->GFIP   := cGFIP
					( cTrbPPP )->EMP    := aDados[ nDado, 1 ]

				( cTrbPPP )->( MsUnlock() )

				aAdd( aMatriculas, {;
					( cAliasTGY )->RA_FILIAL,;
					( cAliasTGY )->RA_MAT,;
					aDados[ nDado, 1 ];
				} )

				U_NG700TAREF(;
					( cAliasTGY )->RA_FILIAL,;
					( cAliasTGY )->RA_MAT,;
					dInicio,;
					dFim,;
					( cAliasTGY )->CTT_CUSTO,;
					( cAliasTGY )->RA_DEPTO,;
					( cAliasTGY )->RJ_FUNCAO,;
					( cAliasTGY )->TM0_NUMFIC,;
					aDados[ nDado, 1 ];
				)

			EndIf

			nReg := ( cAliasTGY )->( Recno() )
			( cAliasTGY )->( DbSkip() )

		End

		( cAliasTGY )->( DbCloseArea() )

	Next nDado

	aSort( aHistorico, Nil, Nil, { | x, y | x[ 3 ] + x [ 4 ] < y[ 3 ] + y[ 4 ] } ) // Ordena de acordo com a data de início e fim

	If cEmpAnt != cEmpDad // Volta a empresa logada caso necessário
		fOpenSX( { 'SX3' }, cEmpAnt )
		NGPrepTBL( aTabelas, cEmpAnt, cFilBackup )
	EndIf

Return aHistorico

//-------------------------------------------------------------------
/*/{Protheus.doc} fRedDat
Redefine as datas de início e fim

@author Gabriel Sokacheski
@since 14/03/2023

@param, cAliasTGY, alias das informações
@param, dInicio, data início
@param, dFim, data fim

/*/
//-------------------------------------------------------------------
Static Function fRedDat( cAliasTGY, dInicio, dFim )

	dInicio := StoD( ( cAliasTGY )->TGY_DTINI )
	dFim 	:= StoD( ( cAliasTGY )->TGY_DTFIM )

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fBusDatCor
Retorna a data de corte do PPP caso exista

@author Gabriel Sokacheski
@since 13/03/2023

@return aCorte, data de corte do PPP
/*/
//-------------------------------------------------------------------
Static Function fBusDatCor()

	Local dCorte 	:= CtoD( '//' )
	Local dCorPar	:= SuperGetMv( 'MV_NG2PPPD', .F., CtoD( '//' ) )

	If xm_par12 == 1 // Somente a partir de janeiro de 2004
		dCorte := CtoD( '01/01/2004' )
	EndIf

	If !Empty( dCorPar ) // Data de corte informada
		If Empty( dCorte ) .Or. dCorPar > dCorte
			dCorte := dCorPar
		EndIf
	EndIf

Return dCorte

//-------------------------------------------------------------------
/*/{Protheus.doc} NG700VECAT

Verifica se o Funcionario tem Cat impresso.

@author  Denis Hyroshi de Souza
@since   21/10/02

@sample  U_NG700VECAT(cFilFichas,TM0->TM0_NUMFIC,(cTRBPPP)->EMP)

@param   cFilialTM0, Caracter, Filial da ficha medica do funcionario
@param   nFicha, Numerico, Numero da ficha medica do funcionario
@param   cEmpTM0, Caracter, Empresada ficha medica do funcionario
/*/
//-------------------------------------------------------------------
User Function NG700VECAT( cFilialTM0, nFicha, cEmpTM0 )

	Local cFilTNC := ""
	Local cModoCom := ""

	If lMudEmpr .And. cEmpTM0 != cEmpPPP
		cModo := FWModeAccess( "TNC" )
		U_EMP700OPEN( "TNC", "TNC", 1, cEmpTM0, @cModo, cFilialTM0 )
	EndIf

	cModoCom := f700RetCom( "TNC" )
	cFilTNC := FwxFilial( "TNC", cFilialTM0, Substr( cModoCom, 1, 1 ), Substr( cModoCom, 2, 1 ), Substr( cModoCom, 3, 1 ) )
	dbSelectArea( "TNC" )
	dbSetOrder( 7 )
	dbSeek( cFilTNC + nFicha)

	While !Eof() .And. cFilTNC == TNC->TNC_FILIAL

		If nFicha == TNC->TNC_NUMFIC .And. !Empty( TNC->TNC_DTEMIS ) .And. TNC->TNC_DTEMIS >= dDtAdmiss

			cCat := TNC->TNC_ACIDEN

			If !Empty( TNC->TNC_CATINS )
				cCat := TNC->TNC_CATINS
			EndIf

			// Busca o retorno do eSocial
			If !Empty( TNC->TNC_RECIBO ) .Or. !Empty( TNC->TNC_RECORI )

				If aScan( aCat, { | x | DtoS( x[ 1 ] ) + x[ 2 ] + x[ 3 ] == DtoS( TNC->TNC_DTEMIS ) + TNC->TNC_RECIBO + TNC->TNC_RECORI } ) <= 0
					aAdd( aCat, { TNC->TNC_DTEMIS, TNC->TNC_RECIBO, TNC->TNC_RECORI, .T. } )
				EndIf

			ElseIf !Empty( TNC->TNC_CATINS ) .Or. !Empty( TNC->TNC_CATORI ) // Busca da maneira antiga

				If aScan( aCat, { | x | Dtos( x[ 1 ] ) + x[ 2 ] + x[ 3 ] == Dtos( TNC->TNC_DTEMIS ) + TNC->TNC_CATINS + TNC->TNC_CATORI } ) <= 0
					aAdd( aCat, { TNC->TNC_DTEMIS, TNC->TNC_CATINS, TNC->TNC_CATORI, .F. } )
				EndIf

			EndIf

		EndIf

		( 'TNC' )->( DbSkip() )

	End

	If lMudEmpr .And. cEmpTM0 != cEmpPPP
		U_EMP700OPEN( "TNC", "TNC", 1, cEmpPPP, @cModo )
	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} NG700HISTO

Carrega os dados do historico do funcionario

@author  Denis Hyroshi de Souza
@since   21/10/02

@sample  lMDTA102(.T.)

@param   lMDTA102, Logico, Verifica se o funcionario executou alguma tarefa

@return  Array, Informacoes sobre o historico do funcionario
/*/
//-------------------------------------------------------------------
User Function NG700HISTO( lMDTA102 )

	Local aHistory := {}
	Local nWWW
	Local nXYZ
	Local nBeg
	Local nSizeSRE    := IIf( TAMSX3( "RE_FILIALD" )[1] > 0, TAMSX3( "RE_FILIALD" )[1], Len( SRE->RE_FILIALD ) )
	Local cCBO        := "" // Guarda o CBO da Funcao
	Local lFimPPP     := .F. // Verifica se acabou o historico de setores
	Local dINITMP     := SRA->RA_ADMISSA //Data Admissao
	Local dINIPPP     := dINITMP //Data Inicio do PPP
	Local dFIMPPP     := IIf( !lDemitido, dDataBase, dDtDemiss ) // Data limite p/ uma transferencia
	Local dFINALPPP   := dFIMPPP //Data final do PPP
	Local aDadosPPP   := {} //Grava dados do historico de setores
	Local cDesFunPPP  := Space( 25 ) //Descricao da Funcao do periodo anterior
	Local cDesFunFOR  := Space( 25 ) //Descricao da Funcao do periodo anterior
	Local cFuncaoPPP  := Space( Len( SRA->RA_CODFUNC ) ) // Funcao do periodo anterior
	Local cFuncaoFOR  := Space( Len( SRA->RA_CODFUNC ) ) // Funcao do periodo anterior
	Local cCargoPPP   := Space( 5 )
	Local cDesCarPPP  := Space( 30 )
	Local cCargoFOR   := Space( 5 )
	Local cDesCarFOR  := Space( 30 )
	Local cGFIP       := "" //Variavel para receber o ultimo código da SR9, antes de 01/01/2004
	Local lAchou      := .T. //Variavel de Controle
	Local lInicio     := .T. //Variavel de Controle
	Local lEntra      := .T. //Variavel de Controle
	Local lTemSR7     := .F. //Variavel de Controle
	Local dDataFOR    := CToD( "  /  /  " )
	Local cKeyEmp     := SM0->M0_CODIGO // Empresa origem
	Local cKeyFil     := Padr( SRA->RA_FILIAL, nSizeSRE )// Filial origem
	Local cKeyMat     := SRA->RA_MAT // Matricula origem
	Local cKeyCus     := SRA->RA_CC // Centro Custo origem
	Local cKeyDep     := SRA->RA_DEPTO // Departamento origem
	Local cCondCus    := Space( Len( SRA->RA_CC ) )
	Local cCondDep    := Space( Len( SRA->RA_DEPTO ) )
	Local cCondALL    := Space( 10 )
	Local lFirstSRE   := .T. //Indica se eh o primeiro SRE
	Local lFirst      := .T.
	Local lAchouSRE   := .F.
	Local nTotRegPPP  := 0
	Local nRegPPP     := 0
	Local lPrimeiro   := .T.
	Local _dFimPPP    := ctod( "  /  /  " )
	Local cFunAnter   := Space( 5 ) //Funcao Anterior, para verificar se nao esta gravando funcao igual
	Local cCarAnter   := Space( 5 )
	Local cRA_CODFUNC := SRA->RA_CODFUNC //Se nao achar transf. de funcao o programa adota a funcao atual
	Local lCposSR7    := IIf( Empty( SRA->RA_CARGO ), .F., .T. )
	Local cRA_CARGO   := IIf( lCposSR7, SRA->RA_CARGO, Space( 5 ) ) //Se nao achar transf. de funcao o programa adota a funcao atual
	Local dDateAte    //Data final do funcionario em uma determinada funcao
	Local aDadosTmp   := {} //temporario
	Local lCNPJCC     := (SuperGetMv( "MV_NG2PPPC", .F., "2" ) == "1")
	Local dDataSRE    := CTOD( "" )
	Local aAreaSRE	  := {}
	Local dDataCorte  := SuperGetMv( "MV_NG2PPPD", .F., CtoD( "" ) )
	Local cModoTM0
	Local cXFilTM0
	Local cModoSRA
	Local cXFilSRA
	Local cModoCTT
	Local cXFilCTT
	Local cModoSRJ
	Local cXFilSRJ
	Local cModoSQ3
	Local cXFilSQ3
	Local cModoSR9
	Local cXFilSR9

	Local lVldMat	 := ValType( MV_PAR37 ) == "N" //Caso o parâmetro exista no Pergunte
	Local lUpdDates	 := .T.
	Local lReutMat	 := SuperGetMv( "MV_REUTMAT", .F., .F. )
	Local lCurrBrnch := IIf( lVldMat, MV_PAR37 == 1, .F. )

	Default lMDTA102 := .F.

	Private dDtTransf := CtoD( "  /  /  " ), cFilTNF := "  "

	// Busca se houve alguma transferencia do funcionario (MV_NG2MFIL e MV_NG2MEMP)
	If lMudEmpr .Or. lMudFilial
		lNaoAchou := .T.

		While !lFimPPP
			lPrimeiro := .T.
			_dFimPPP  := CToD( "  /  /  " )
			cCondCus  := cKeyCus
			cCondDep  := cKeyDep
			cCondALL  := cKeyEmp + cKeyFil + cKeyMat

			dbSelectArea( "SRE" )
			dbSetOrder( 1 )
			dbSeek( cCondALL )

			While !Eof() .And. cCondALL == SRE->RE_EMPD + SRE->RE_FILIALD + SRE->RE_MATD

				If SRE->RE_DATA < dDataSRE
					dbSelectArea( "SRE" )
					dbSkip()
					Loop
				EndIf

				If SRE->RE_EMPP == SRE->RE_EMPD .And. SRE->RE_FILIALP == SRE->RE_FILIALD .And. ;
				   SRE->RE_MATP == SRE->RE_MATD .And. SRE->RE_CCP == SRE->RE_CCD .And. SRE->RE_DEPTOP == SRE->RE_DEPTOD
					dbSelectArea( "SRE" )
					dbSkip()
					Loop
				EndIf

				If (IIf( lFirstSRE, SRE->RE_DATA > dDataBase, SRE->RE_DATA >= dDataBase )) .Or. ;
					SRE->RE_DATA < dINITMP
					dbSelectArea( "SRE" )
					dbSkip()
					Loop
				EndIf

				If SRE->RE_CCD <> cCondCus .Or. SRE->RE_DEPTOD <> cCondDep
					dbSelectArea( "SRE" )
					dbSkip()
					Loop
				EndIf

				lFirstSRE := .F.

				If lPrimeiro
					dDataSRE := SRE->RE_DATA


					If lMudEmpr
						cKeyEmp := SRE->RE_EMPP
					EndIf

					If lMudFilial
						cKeyFil := SRE->RE_FILIALP
					EndIf

					cKeyMat := SRE->RE_MATP
					cKeyCus := SRE->RE_CCP
					cKeyDep := SRE->RE_DEPTOP


					aAdd( aDadosTmp, { SRE->RE_DATA, dDataBase, SRE->RE_FILIALD, SRE->RE_MATD, SRE->RE_CCD, SRE->RE_EMPD, SRE->RE_DEPTOD } )
					_dFimPPP := SRE->RE_DATA


				ElseIf SRE->RE_DATA < aDadosTmp[Len( aDadosTmp )][1]

					dDataSRE := SRE->RE_DATA

					If lMudEmpr
						cKeyEmp := SRE->RE_EMPP
					EndIf

					If lMudFilial
						cKeyFil := SRE->RE_FILIALP
					EndIf

					cKeyMat := SRE->RE_MATP
					cKeyCus := SRE->RE_CCP
					cKeyDep := SRE->RE_DEPTOD
					aDadosTmp[Len( aDadosTmp )][1] := SRE->RE_DATA
					_dFimPPP := SRE->RE_DATA

				EndIf

				lPrimeiro := .F.

				// O funcionario esta mudando de Empresa/Filial, portanto, o processo para aqui
				lFimPPP := (SRE->RE_EMPP != cEmpPPP .And. !lMudEmpr ) .Or. (SRE->RE_EMPP+SRE->RE_FILIALP != cSvEmpAnt+cSvFilAnt .And. !lMudFilial)

				dbSelectArea( "SRE" )
				dbSkip()

			End

			If lPrimeiro
				lFimPPP := .T.

				If dINITMP < dFIMPPP
					aAdd( aDadosTmp, { dINITMP, dFIMPPP, cKeyFil, cKeyMat, cKeyCus, cKeyEmp, cKeyDep } )
				EndIf

			Else
				dFimPPP := _dFimPPP
			EndIf

		End

		If Len( aDadosTmp ) > 0
			aSRArea := SRA->(GetArea())
			cKeyEmp := aDadosTmp[Len( aDadosTmp ), 6] // Empresa origem
			cKeyFil := aDadosTmp[Len( aDadosTmp ), 3] // Filial origem
			cKeyMat := aDadosTmp[Len( aDadosTmp ), 4] // Matricula origem
			cKeyCus := aDadosTmp[Len( aDadosTmp ), 5] // Centro Custo origem
			cKeyDep := aDadosTmp[Len( aDadosTmp ), 7] // Departamento origem

			If lMudEmpr .And. cKeyEmp != cEmpPPP .And. !Empty( cKeyEmp )
				cModo := FWModeAccess( "SRA" )
				U_EMP700OPEN( "SRA", "SRA", 1, cKeyEmp, @cModo, Substr( cKeyFil, 1, Len( SRA->RA_FILIAL ) ) )
			EndIf

			cModoSRA := f700RetCom( "SRA" )
			cFilSRA := FwxFilial( "SRA", Substr( cKeyFil, 1, Len( SRA->RA_FILIAL ) ), Substr( cModoSRA, 1, 1 ), Substr( cModoSRA, 2, 1 ), Substr( cModoSRA, 3, 1 ) )
			dbSelectArea( "SRA" )
			dbSetOrder( 1 )
			dbSeek( cFilSRA + cKeyMat )
			dFIMPPP   := IIf( Empty( SRA->RA_DEMISSA ), dDataBase, SRA->RA_DEMISSA ) // Data limite p/ uma transferencia
			dDtDemiss := IIf( Empty( SRA->RA_DEMISSA ), U_PPPDTDEMIS(), SRA->RA_DEMISSA ) //Busca data demissao do SRG
			lDemitido := !Empty( dDtDemiss )

			If lMudEmpr .And. cKeyEmp != cEmpPPP .And. !Empty( cKeyEmp )
				U_EMP700OPEN( "SRA", "SRA", 1, cEmpPPP, @cModo )
			EndIf

			RestArea( aSRArea )
		EndIf

	EndIf

	// Busca informações do funcionario quando transferido para outra empresa
	lFirstSRE := .T.
	lFimPPP   := .F.

	While !lFimPPP
		lPrimeiro := .T.
		_dFimPPP  := CToD( "  /  /  " )
		cCondCus  := cKeyCus
		cCondDep  := cKeyDep
		cCondALL  := cKeyEmp + cKeyFil + cKeyMat
		dbSelectArea( "SRE" )
		dbSetOrder( 2 )
		dbSeek( cCondALL )

		While !Eof() .And. cCondALL == SRE->RE_EMPP + SRE->RE_FILIALP + SRE->RE_MATP

			If SRE->RE_EMPP == SRE->RE_EMPD .And. SRE->RE_FILIALP == SRE->RE_FILIALD .And. SRE->RE_MATP == SRE->RE_MATD;
			.And. SRE->RE_CCP == SRE->RE_CCD .And. SRE->RE_DEPTOD == SRE->RE_DEPTOP
				dbSelectArea( "SRE" )
				dbSkip()
				Loop
			EndIf

			If (IIf( lFirstSRE, SRE->RE_DATA > dFIMPPP, SRE->RE_DATA >= dFIMPPP )) .Or. ;
				SRE->RE_DATA < dINITMP
				dbSelectArea( "SRE" )
				dbSkip()
				Loop
			EndIf

			If Alltrim( SRE->RE_CCP ) <> Alltrim( cCondCus ) .Or. ( Alltrim( SRE->RE_DEPTOP ) <> Alltrim( cCondDep ) )
				dbSelectArea( "SRE" )
				dbSkip()
				Loop
			EndIf

			lFirstSRE := .F.

			If lPrimeiro

				If lMudEmpr
					cKeyEmp := SRE->RE_EMPD
				EndIf

				If lMudFilial
					cKeyFil := SRE->RE_FILIALD
				EndIf

				cKeyMat := SRE->RE_MATD
				cKeyCus := SRE->RE_CCD
				cKeyDep := SRE->RE_DEPTOD

				If lVldMat //Caso o parâmetro exista no Pergunte
					If !lCurrBrnch .Or. AllTrim( xFilial( 'SRA' ) ) == AllTrim( SRE->RE_FILIALP )
						aAdd( aDadosPPP, { SRE->RE_DATA, dFimPPP, SRE->RE_FILIALP, SRE->RE_MATP, SRE->RE_CCP, SRE->RE_EMPP, SRE->RE_DEPTOP } )
					ElseIf lReutMat
						lUpdDates := .F.
					EndIf
				Else
					aAdd( aDadosPPP, { SRE->RE_DATA, dFimPPP, SRE->RE_FILIALP, SRE->RE_MATP, SRE->RE_CCP, SRE->RE_EMPP, SRE->RE_DEPTOP } )
				EndIf

				_dFimPPP := SRE->RE_DATA

			ElseIf SRE->RE_DATA > aDadosPPP[Len( aDadosPPP )][1]

				If lMudEmpr
					cKeyEmp := SRE->RE_EMPD
				EndIf

				If lMudFilial
					cKeyFil := SRE->RE_FILIALD
				EndIf

				cKeyMat := SRE->RE_MATD
				cKeyCus := SRE->RE_CCD
				cKeyDep := SRE->RE_DEPTOD
				aDadosPPP[Len( aDadosPPP )][1] := SRE->RE_DATA
				_dFimPPP := SRE->RE_DATA

			EndIf

			lPrimeiro := .F.

			// O funcionario esta mudando de Empresa/Filial, portanto, o processo para aqui
			lFimPPP := (SRE->RE_EMPD != cEmpPPP .And. !lMudEmpr) .Or. ;
					(SRE->RE_EMPD+SRE->RE_FILIALD != cSvEmpAnt+cSvFilAnt .And. !lMudFilial)
			dbSelectArea( "SRE" )
			dbSkip()

		End

		If lPrimeiro
			lFimPPP := .T.

			If dINITMP < dFimPPP
				aAdd( aDadosPPP, { dINITMP, dFimPPP, cKeyFil, cKeyMat, cKeyCus, cKeyEmp, cKeyDep } )
			EndIf

		Else
			dFimPPP := _dFimPPP
		EndIf

	End

	If Len( aDadosPPP ) == 0
		aAdd( aDadosPPP, { dINITMP, dFINALPPP, SRA->RA_FILIAL, SRA->RA_MAT, SRA->RA_CC, SM0->M0_CODIGO, SRA->RA_DEPTO } )
	EndIf

	// Busca pelas informações de função e cargo (SRA ou SR7) que serão utilizadas como referência na construção da TRB
	For nWWW := 1 To Len( aDadosPPP )
		cFilSR7 := Substr( aDadosPPP[nWWW][3], 1, FwSizeFilial( aDadosPPP[nWWW][6] ) )

		If lMudEmpr .And. aDadosPPP[nWWW][6] != cEmpPPP
			cModo := FWModeAccess( "SR7" )
			U_EMP700OPEN( "SR7", "SR7", 1, aDadosPPP[nWWW][6], @cModo, cFilSR7 )
		EndIf

		cModoSR7 := f700RetCom( "SR7" )
		cXFilSR7 := FwxFilial( "SR7", cFilSR7, Substr( cModoSR7, 1, 1 ), Substr( cModoSR7, 2, 1 ), Substr( cModoSR7, 3, 1 ) )
		lTemSR7 := .F.
		cSeqSR7 := "Z"
		dbSelectArea( "SR7" )
		dbSetOrder( 1 ) // R7_FILIAL + R7_MAT + DTOS(R7_DATA) + R7_TIPO

		// Se não encontrar, pode ser devido a uma restrição criada na busca por transferências de filial/empresa
		If !dbSeek( cXFilSR7 + aDadosPPP[nWWW][4] + DTOS( aDadosPPP[nWWW][1] ), .T. ) .And. (!lMudEmpr .Or. !lMudFilial)
			dbSkip( -1 ) // Volta um registro e verifica se ainda é do funcionário em questão

			If SR7->R7_MAT == aDadosPPP[nWWW][4]
				cFuncaoPPP := SR7->R7_FUNCAO
				cDesFunPPP := SR7->R7_DESCFUN

				If lCposSR7
					cCargoPPP  := SR7->R7_CARGO
					cDesCarPPP := SR7->R7_DESCCAR
				EndIf

				lTemSR7 := .T.
			EndIf

		Else

			While !Eof() .And. SR7->R7_FILIAL == cXFilSR7     .And. ;
							SR7->R7_MAT == aDadosPPP[nWWW][4] .And. ;
							SR7->R7_DATA <= aDadosPPP[nWWW][2]

				If SR7->R7_SEQ <= cSeqSR7
					cFuncaoPPP := SR7->R7_FUNCAO
					cDesFunPPP := SR7->R7_DESCFUN
					cSeqSR7    := SR7->R7_SEQ

					If lCposSR7
						cCargoPPP  := SR7->R7_CARGO
						cDesCarPPP := SR7->R7_DESCCAR
					EndIf

					lTemSR7 := .T.
				EndIf

				dbselectArea( "SR7" )
				dbSkip()
			End

		EndIf

		If !lTemSR7 // Caso não ocorreu mudança de função (SR7) busca informações na função atual.
			dbSelectArea( "SRA" )
			dbSetOrder( 1 ) // RA_FILIAL + RA_MAT

			If dbSeek( xFilial( "SRA", Substr( aDadosPPP[nWWW][3], 1, FwSizeFilial() ) )  + aDadosPPP[nWWW, 4] )
				cFuncaoPPP	:= SRA->RA_CODFUNC
				cDesFunPPP	:= Posicione( "SRJ", 1, xFilial( "SRJ" ) + cFuncaoPPP, "RJ_DESC" )

				If lCposSR7 // Caso tenha Cargo na SRA
					cCargoPPP := SRA->RA_CARGO
				Else // Caso contrário busca o cargo da Função
					cCargoPPP := Posicione( "SRJ", 1, xFilial( "SRJ" ) + cFuncaoPPP, "RJ_CARGO" )
				EndIf

				cDesCarPPP	:= Posicione( "SQ3", 1, xFilial( "SQ3" ) + cCargoPPP, "Q3_DESCSUM" )
			EndIf

		EndIf

		If lMudEmpr .And. aDadosPPP[nWWW][6] != cEmpPPP
			U_EMP700OPEN( "SR7", "SR7", 1, cEmpPPP, @cModo )
		EndIf

	Next nWWW

	lAchouSRE := .F.
	aSRArea := SRA->(GetArea())

	For nXYZ := Len( aDadosPPP ) To 1 Step -1

		If nXYZ != Len( aDadosPPP )
			cFunAnter := cFuncaoPPP

			If lCposSR7
				cCarAnter := cCargoPPP
			EndIf

		Else
			cFunAnter := Space( 5 )

			If lCposSR7
				cCarAnter := Space( 5 )
			EndIf

		EndIf

		cFilMat := Substr( aDadosPPP[nXYZ][3], 1, FwSizeFilial( aDadosPPP[nXYZ][6] ) )

		If (aScan( aMatriculas, { |x| x[1] + x[2] + x[3] == cFilMat+aDadosPPP[nXYZ][4] + aDadosPPP[nXYZ][6] } )) <= 0
			aAdd( aMatriculas, { cFilMat, aDadosPPP[nXYZ][4], aDadosPPP[nXYZ][6] } ) // MAtriculas Utilizadas pelo funcionario na empresa
		EndIf

		aAreaAtual := {}
		aAreaVelha := {}
		dDtTermino := CtoD( "  /  /    " )
		lAchou     := .T.
		lInicio    := .T.
		lFirst     := .T.

		If lMudEmpr .And. aDadosPPP[nXYZ][6] != cEmpPPP
			cModo := FWModeAccess( "SR7" )
			U_EMP700OPEN( "SR7", "SR7", 1, aDadosPPP[nXYZ][6], @cModo, cFilMat )
			cModo := FWModeAccess( "SRJ" )
			U_EMP700OPEN( "SRJ", "SRJ", 1, aDadosPPP[nXYZ][6], @cModo, cFilMat )
			cModo := FWModeAccess( "SQ3" )
			U_EMP700OPEN( "SQ3", "SQ3", 1, aDadosPPP[nXYZ][6], @cModo, cFilMat )
		EndIf

		cModoSR7 := f700RetCom( "SR7" )
		cXFilSR7 := FwxFilial( "SR7", cFilMat, Substr( cModoSR7, 1, 1 ), Substr( cModoSR7, 2, 1 ), Substr( cModoSR7, 3, 1 ) )

		cModoSRJ := f700RetCom( "SRJ" )
		cXFilSRJ := FwxFilial( "SRJ", cFilMat, Substr( cModoSRJ, 1, 1 ), Substr( cModoSRJ, 2, 1 ), Substr( cModoSRJ, 3, 1 ) )

		cModoSQ3 := f700RetCom( "SQ3" )
		cXFilSQ3 := FwxFilial( "SQ3", cFilMat, Substr( cModoSQ3, 1, 1 ), Substr( cModoSQ3, 2, 1 ), Substr( cModoSQ3, 3, 1 ) )

		dbSelectArea( "SR7" )
		dbSetOrder( 1 )
		dbSeek( cFilMat + aDadosPPP[nXYZ][4] + Dtos( aDadosPPP[nXYZ][1] ), .T. )

		While !Eof() .And. cFilMat+aDadosPPP[nXYZ][4] == SR7->R7_FILIAL+SR7->R7_MAT .And.;
			  (IIf( nXYZ != 1, SR7->R7_DATA < aDadosPPP[nXYZ][2], SR7->R7_DATA <= aDadosPPP[nXYZ][2] ))

			cCNPJ := Space( 10 )
			nTIPINS := 2
			aAreaEMP := SM0->( GetArea() )

			If lNGMDTPS .Or. lSigaMdtps

				If lMudEmpr .And. aDadosPPP[nXYZ][6] != cEmpPPP
					cModo := FWModeAccess( "SA1" )
					U_EMP700OPEN( "SA1", "SA1", 1, aDadosPPP[nXYZ][6], @cModo, cFilMat )
				EndIf

				cModoSA1 := f700RetCom( "SA1" )
				cXFilSA1 := FwxFilial( "SA1", cFilMat, Substr( cModoSA1, 1, 1 ), Substr( cModoSA1, 2, 1 ), Substr( cModoSA1, 3, 1 ) )

				dbSelectArea( "SA1" )
				dbSetOrder( 1 )
				dbSeek( cXFilSA1 + Substr( aDadosPPP[nXYZ][5], 1, nSizeTD ) )
				cCNPJ := SA1->A1_CGC

				If lMudEmpr .And. aDadosPPP[nXYZ][6] != cEmpPPP
					U_EMP700OPEN( "SA1", "SA1", 1, cEmpPPP, @cModo )
				EndIf
			Else
				dbSelectArea( "SM0" )
				dbSeek( aDadosPPP[nXYZ][6] + cFilMat )
				cCNPJ := SM0->M0_CGC
				nTIPINS := SM0->M0_TPINSC
			EndIf

			RestArea( aAreaEMP )

			dbSelectArea( "SRJ" )
			dbSetOrder( 1 )
			dbSeek( cXFilSRJ + SR7->R7_FUNCAO )

			dbSelectArea( "SQ3" )
			dbSetOrder( 1 )
			dbSeek( cXFilSQ3 + IIf( lCposSR7, SR7->R7_CARGO, SRJ->RJ_CARGO ) )

			dbSelectArea( cTRBPPP )
			dbSetOrder( 1 )

			If (SR7->R7_FUNCAO != cFunAnter .Or. IIf( lCposSR7, SR7->R7_CARGO != cCarAnter, .F. ))
				lAchouSRE := .T.
				Reclock( cTRBPPP, .T. )
					(cTRBPPP)->DTDE   := SR7->R7_DATA
					(cTRBPPP)->DTATE  := aDadosPPP[nXYZ][2]
					(cTRBPPP)->CNPJ   := cCNPJ
					(cTRBPPP)->TIPINS := nTIPINS
					(cTRBPPP)->SEQ    := SR7->R7_SEQ
					(cTRBPPP)->FILIAL := cFilMat
					(cTRBPPP)->MAT    := aDadosPPP[nXYZ][4]
					(cTRBPPP)->CUSTO  := aDadosPPP[nXYZ][5]
					(cTRBPPP)->DEPTO  := aDadosPPP[nXYZ][7]
					(cTRBPPP)->EMP    := aDadosPPP[nXYZ][6]
					(cTRBPPP)->CARGO  := IIf( lCposSR7, SR7->R7_CARGO, SRJ->RJ_CARGO )
					(cTRBPPP)->CODFUN := SR7->R7_FUNCAO

					If !Empty( SR7->R7_DESCFUN ) .And. (Len( Alltrim( SRJ->RJ_DESC ) ) <= 25 .Or. Len( Alltrim( SR7->R7_DESCFUN ) ) > 25)
						(cTRBPPP)->DESFUN := SR7->R7_DESCFUN
					Else
						(cTRBPPP)->DESFUN := SRJ->RJ_DESC
					EndIf

					If lCposSR7

						If !Empty( SR7->R7_DESCCAR ) .And. (Len( Alltrim( SQ3->Q3_DESCSUM ) ) <= 25 .Or. Len( Alltrim( SR7->R7_DESCCAR ) ) > 25)
							(cTRBPPP)->DESCAR := SR7->R7_DESCCAR
						Else
							(cTRBPPP)->DESCAR := SQ3->Q3_DESCSUM
						EndIf

					EndIf

				(cTRBPPP)->( Msunlock())
				cFunAnter := SR7->R7_FUNCAO

				If lCposSR7
					cCarAnter := SR7->R7_CARGO
				EndIf

			Else
				dbSelectArea( "SR7" )
				dbSkip()
				Loop
			EndIf

			//Guarda ultimo registro do arquivo de trabalho cTRBPPP. Para alterar a data fim no proximo laco.
			aAreaAtual := (cTRBPPP)->(GetArea())
			cFuncaoFOR := SR7->R7_FUNCAO
			cDesFunFOR := SR7->R7_DESCFUN

			If lCposSR7
				cCargoFOR  := SR7->R7_CARGO
				cDesCarFOR := SR7->R7_DESCCAR
			EndIf

			dDtTermino := SR7->R7_DATA // Variavel para alterar a data fim do registro anterior
			cSeqTabR7  := (cTRBPPP)->SEQ

			lVelha := .T.

			If lFirst // Se for a primeira vez que entrou no laco
				dDataFOR := SR7->R7_DATA
				lFirst := .F.
			Else
				RestArea( aAreaVelha )

				If !Eof() .And. !Bof()

					If dDtTermino == (cTRBPPP)->DTDE .And. (cTRBPPP)->SEQ > cSeqTabR7
						cFunAnter := (cTRBPPP)->CODFUN

						If lCposSR7
							cCarAnter := (cTRBPPP)->CARGO
						EndIf

						RestArea( aAreaAtual )
						lVelha := .F.
					EndIf

					Reclock( cTRBPPP, .F. )
						(cTRBPPP)->DTATE  := dDtTermino //Altera a data fim do registro anterior
					(cTRBPPP)->( Msunlock())
				EndIf

				RestArea( aAreaAtual )
			EndIf

			If lVelha
				aAreaVelha := (cTRBPPP)->(GetArea())
			EndIf

			// Variavel de controle. Para saber se existe mudanca de funcao no comeco da transferencia
			If aDadosPPP[nXYZ][1] == SR7->R7_DATA
				lInicio := .F.
			EndIf

			// Variavel de controle. Para saber se houve mudanca de funcao
			lAchou := .F.

			dbSelectArea( "SR7" )
			dbSkip()
		End

		// Verifica se existe registro do funcionário na SRE
		aAreaSRE := SRE->(GetArea())
		dbSelectArea( "SRE" )
		dbSetOrder( 2 )

		If dbSeek( cCondAll )
			lAchouSRE := .T.
		EndIf

		RestArea( aAreaSRE )

		If lMudEmpr .And. aDadosPPP[nXYZ][6] != cEmpPPP
			U_EMP700OPEN( "SR7", "SR7", 1, cEmpPPP, @cModo )
			U_EMP700OPEN( "SQ3", "SQ3", 1, cEmpPPP, @cModo )
		EndIf

		If lAchou // Se nao achou nenhuma mudanca de funcao
			cCNPJ := Space( 10 )
			nTIPINS := 2
			aAreaEMP := SM0->(GetArea())

			If lNGMDTPS .Or. lSigaMdtps

				If lMudEmpr .And. aDadosPPP[nXYZ][6] != cEmpPPP
					cModo := FWModeAccess( "SA1" )
					U_EMP700OPEN( "SA1", "SA1", 1, aDadosPPP[nXYZ][6], @cModo, cFilMat )
				EndIf

				cModoSA1 := f700RetCom( "SA1" )
				cXFilSA1 := FwxFilial( "SA1", cFilMat, Substr( cModoSA1, 1, 1 ), Substr( cModoSA1, 2, 1 ), Substr( cModoSA1, 3, 1 ) )

				dbSelectArea( "SA1" )
				dbSetOrder( 1 )
				dbSeek( cXFilSA1 + Substr( aDadosPPP[nXYZ][5], 1, nSizeTD ) )
				cCNPJ := SA1->A1_CGC

				If lMudEmpr .And. aDadosPPP[nXYZ][6] != cEmpPPP
					U_EMP700OPEN( "SA1", "SA1", 1, cEmpPPP, @cModo )
				EndIf

			Else
				dbSelectArea( "SM0" )
				dbSeek( aDadosPPP[nXYZ][6] + cFilMat )
				cCNPJ := SM0->M0_CGC
				nTIPINS := SM0->M0_TPINSC
			EndIf

			RestArea( aAreaEMP )

			dbSelectArea( "SRJ" )
			dbSetOrder( 1 )
			dbSeek( cXFilSRJ + cFuncaoPPP )

			dbSelectArea( "SQ3" )
			dbSetOrder( 1 )
			dbSeek( cXFilSQ3 + IIf( lCposSR7, cCargoPPP, SRJ->RJ_CARGO ) )

			dbSelectArea( cTRBPPP )
			dbSetOrder( 1 )

			If !dbSeek( DTOS( aDadosPPP[nXYZ][1] ) )
				Reclock( cTRBPPP, .T. )
					(cTRBPPP)->DTDE   := aDadosPPP[nXYZ][1]
					(cTRBPPP)->DTATE  := aDadosPPP[nXYZ][2]
					(cTRBPPP)->CNPJ   := cCNPJ
					(cTRBPPP)->TIPINS := nTIPINS
					(cTRBPPP)->CUSTO  := aDadosPPP[nXYZ][5]
					(cTRBPPP)->DEPTO  := aDadosPPP[nXYZ][7]
					(cTRBPPP)->FILIAL := cFilMat
					(cTRBPPP)->EMP    := aDadosPPP[nXYZ][6]
					(cTRBPPP)->MAT    := aDadosPPP[nXYZ][4]
					(cTRBPPP)->CARGO  := IIf( lCposSR7, cCargoPPP, SRJ->RJ_CARGO )
					(cTRBPPP)->CODFUN := cFuncaoPPP

					If !Empty( SRJ->RJ_DESC )
						(cTRBPPP)->DESFUN := SRJ->RJ_DESC
					Else
						(cTRBPPP)->DESFUN := cDesFunPPP
					EndIf

					If lCposSR7

						If !Empty( SQ3->Q3_DESCSUM )
							(cTRBPPP)->DESCAR := SQ3->Q3_DESCSUM
						Else
							(cTRBPPP)->DESCAR := cDesCarPPP
						EndIf

					EndIf

					cFuncaoFOR := cFuncaoPPP
					cDesFunFOR := cDesFunPPP

					If lCposSR7
						cCargoFOR  := IIf( lCposSR7, cCargoPPP, SRJ->RJ_CARGO )
						cDesCarFOR := (cTRBPPP)->DESCAR
					EndIf

				(cTRBPPP)->( Msunlock())
			EndIf

		Elseif lInicio // Se nao achou nenhuma mudanca de funcao no inicio da mudanca de setor
			cCNPJ := Space( 10 )
			nTIPINS := 2
			aAreaEMP := SM0->(GetArea())

			If lNGMDTPS .Or. lSigaMdtps

				If lMudEmpr .And. aDadosPPP[nXYZ][6] != cEmpPPP
					cModo := FWModeAccess( "SA1" )
					U_EMP700OPEN( "SA1", "SA1", 1, aDadosPPP[nXYZ][6], @cModo, cFilMat )
				EndIf

				cModoSA1 := f700RetCom( "SA1" )
				cXFilSA1 := FwxFilial( "SA1", cFilMat, Substr( cModoSA1, 1, 1 ), Substr( cModoSA1, 2, 1 ), Substr( cModoSA1, 3, 1 ) )

				dbSelectArea( "SA1" )
				dbSetOrder( 1 )
				dbSeek( cXFilSA1 + Substr( aDadosPPP[nXYZ][5], 1, nSizeTD ) )
				cCNPJ := SA1->A1_CGC

				If lMudEmpr .And. aDadosPPP[nXYZ][6] != cEmpPPP
					U_EMP700OPEN( "SA1", "SA1", 1, cEmpPPP, @cModo )
				EndIf

			Else
				dbSelectArea( "SM0" )
				dbSeek( aDadosPPP[nXYZ][6] + cFilMat )
				cCNPJ := SM0->M0_CGC
				nTIPINS := SM0->M0_TPINSC
			EndIf

			RestArea( aAreaEMP )

			dbSelectArea( "SRJ" )
			dbSetOrder( 1 )
			dbSeek( cXFilSRJ + cFuncaoPPP )

			dbSelectArea( "SQ3" )
			dbSetOrder( 1 )
			dbSeek( cXFilSQ3 + IIf( lCposSR7, cCargoPPP, SRJ->RJ_CARGO ) )

			dbSelectArea( cTRBPPP )
			dbSetOrder( 1 )

			If !dbSeek( DTOS( aDadosPPP[nXYZ][1] ) )
				Reclock( cTRBPPP, .T. )
					(cTRBPPP)->DTDE   := aDadosPPP[nXYZ][1]
					(cTRBPPP)->DTATE  := dDataFOR
					(cTRBPPP)->CNPJ   := cCNPJ
					(cTRBPPP)->TIPINS := nTIPINS
					(cTRBPPP)->CUSTO  := aDadosPPP[nXYZ][5]
					(cTRBPPP)->DEPTO  := aDadosPPP[nXYZ][7]
					(cTRBPPP)->FILIAL := cFilMat
					(cTRBPPP)->EMP    := aDadosPPP[nXYZ][6]
					(cTRBPPP)->MAT    := aDadosPPP[nXYZ][4]
					(cTRBPPP)->CARGO  := IIf( lCposSR7, cCargoPPP, SRJ->RJ_CARGO )
					(cTRBPPP)->CODFUN := cFuncaoPPP

					If !Empty( SRJ->RJ_DESC )
						(cTRBPPP)->DESFUN := SRJ->RJ_DESC
					Else
						(cTRBPPP)->DESFUN := cDesFunPPP
					EndIf

					If lCposSR7

						If !Empty( SQ3->Q3_DESCSUM )
							(cTRBPPP)->DESCAR := SQ3->Q3_DESCSUM
						Else
							(cTRBPPP)->DESCAR := cDesCarPPP
						EndIf

					EndIf

				(cTRBPPP)->( Msunlock())
			EndIf

		EndIf

		cFuncaoPPP := cFuncaoFOR
		cDesFunPPP := cDesFunFOR

		If lCposSR7
			cCargoPPP  := cCargoFOR
			cDesCarPPP := cDesCarFOR
		EndIf

		If lMudEmpr .And. aDadosPPP[nXYZ][6] != cEmpPPP
			U_EMP700OPEN( "SRJ", "SRJ", 1, cEmpPPP, @cModo )
		EndIf

	Next

	RestArea( aSRArea )

	If !lAchouSRE

		Begin Sequence
			dbSelectArea( "SRJ" )
			dbSetOrder( 1 )

			If dbSeek( xFilial( "SRJ" ) + cRA_CODFUNC )

				If lCposSR7
					dbSelectArea( "SQ3" )
					dbSetOrder( 1 )
					dbSeek( xFilial( "SQ3" ) + cRA_CARGO )
				EndIf

				dbSelectArea( cTRBPPP )
				dbGoTop()

				While !Eof()
					RecLock( cTRBPPP, .F. )
						(cTRBPPP)->CODFUN := cRA_CODFUNC
						(cTRBPPP)->DESFUN := SRJ->RJ_DESC
						(cTRBPPP)->CARGO  := SRJ->RJ_CARGO

						If lCposSR7
							(cTRBPPP)->CARGO  := cRA_CARGO
							(cTRBPPP)->DESCAR := SQ3->Q3_DESCSUM
						EndIf

					(cTRBPPP)->( MsUnlock())
					dbskip()
				End

				Break
			EndIf

			For nBeg := Len( aMatriculas ) To 1 step -1

				If lMudEmpr .And. aMatriculas[nBeg][3] != cEmpPPP
					cModo := FWModeAccess( "SRJ" )
					U_EMP700OPEN( "SRJ", "SRJ", 1, aMatriculas[nBeg][3], @cModo, aMatriculas[nBeg][1] )
				EndIf

				dbSelectArea( "SRJ" )
				dbSetOrder( 1 )

				If dbSeek( xFilial( "SRJ", aMatriculas[nBeg, 1] ) + cRA_CODFUNC )
					dbSelectArea( cTRBPPP )
					dbGoTop()

					While !Eof()
						RecLock( cTRBPPP, .F. )
							(cTRBPPP)->CODFUN := cRA_CODFUNC
							(cTRBPPP)->DESFUN := SRJ->RJ_DESC
							(cTRBPPP)->CARGO  := SRJ->RJ_CARGO
						(cTRBPPP)->( Msunlock())
						dbSkip()
					End

					Break
				EndIf

				If lMudEmpr .And. aMatriculas[nBeg][3] != cEmpPPP
					U_EMP700OPEN( "SRJ", "SRJ", 1, cEmpPPP, @cModo )
				EndIf

			Next nBeg

		End Sequence

	EndIf

	If xm_par12 == 1 .Or. (xm_par12 == 2 .And. !Empty( dDatacorte ))//Somente a partir JAN/2004 ?
		lDelBK := .F.
		dbSelectArea( cTRBPPP )
		dbSetOrder( 1 )
		dbSeek( DToS( dINIPPP ), .T. )

		If dINIPPP == (cTRBPPP)->DTDE
			lDelBK := .T.
		Else
			dbSkip( -1 )

			If !Eof() .And. !Bof() .And. dINIPPP > (cTRBPPP)->DTDE
				lDelBK := .T.
				Reclock( cTRBPPP, .F. )
					(cTRBPPP)->DTDE := dINIPPP
				(cTRBPPP)->( Msunlock())
			EndIf

		EndIf

		If lDelBK
			dbSelectArea( cTRBPPP )
			dbGoTop()

			While !Eof()

				If (cTRBPPP)->DTDE < dINIPPP .Or. (cTRBPPP)->DTDE < dDtAdmiss
					RecLock( cTRBPPP, .F. )
						dbDelete()
					(cTRBPPP)->( MsUnlock())
				EndIf

				dbSkip()
			End

		EndIf

	EndIf

	nRegPPP  := 0
	cGFIPant := "  "
	lGfipAll := .F. // Se achou alguma alteracao de GFIP

	dbSelectArea( cTRBPPP )
	nTotRegPPP := (cTRBPPP)->(Reccount())
	dbSetOrder( 1 )
	dbGoTop()

	While !Eof()

		If !Empty( (cTRBPPP)->GFIP )
			dbSelectArea( cTRBPPP )
			dbSkip()
			Loop
		EndIf

		aAreaSv := (cTRBPPP)->(GetArea())
		aAreaAnt := {}
		lAchou := .F.
		nRegPPP++
		cFilSR9 := Substr( (cTRBPPP)->FILIAL, 1, FwSizeFilial( (cTRBPPP)->EMP ) )

		If lMudEmpr .And. (cTRBPPP)->EMP != cEmpPPP
			cModo := FWModeAccess( "SR9" )
			U_EMP700OPEN( "SR9", "SR9", 1, (cTRBPPP)->EMP, @cModo, cFilSR9 )
		EndIf

		cModoSR9 := f700RetCom( "SR9" )
		cXFilSR9 := FwxFilial( "SR9", cFilSR9, Substr( cModoSR9, 1, 1 ), Substr( cModoSR9, 2, 1 ), Substr( cModoSR9, 3, 1 ) )

		cChavePPP := cXFilSR9+(cTRBPPP)->MAT
		svDTDE    := (cTRBPPP)->DTDE
		svDTATE   := (cTRBPPP)->DTATE

		dbSelectArea( "SR9" )
		dbSetOrder( 1 )
		dbSeek( cXFilSR9 + (cTRBPPP)->MAT + "RA_OCORREN" )

		While !Eof() .And. cChavePPP == SR9->R9_FILIAL+SR9->R9_MAT .And.;
			"RA_OCORREN" == SR9->R9_CAMPO

			aAreaSR9 := ( "SR9" )->(GetArea())

				// Validação para pegar o ultimo código antes de 01/01/2004
				// e adicionar no TRB do GFIP
				If xm_par12 == 1 .And. lEntra
					dbSelectArea( "SR9" ) // Feito posicionamento para trazer as datas corretas
					dbSetOrder( 2 ) // R9_FILIAL + R9_MAT + DTOS(R9_DATA) + R9_CAMPO
					dbSeek( xFilial( "SR9" ) + SRA->RA_MAT )
					lEntra := .F.

					While !Eof() .And. xFilial( "SR9" ) == SR9->R9_FILIAL

						If SR9->R9_DATA < CTOD( "01/01/2004" )
							cGFIP := Alltrim( SR9->R9_DESC ) // Ultimo código recebido antes de 01/01/2004
							dbSelectArea( "SR9" )
							dbSkip()
						Else
							Exit
						EndIf

					End

				EndIf

			RestArea( aAreaSR9 )

			If svDTDE > SR9->R9_DATA .Or. svDTATE < SR9->R9_DATA
				dbSelectArea( "SR9" )
				dbSkip()
				Loop
			EndIf

			tmpDTDE   := (cTRBPPP)->DTDE
			tmpDTATE  := (cTRBPPP)->DTATE
			tmpCNPJ   := (cTRBPPP)->CNPJ
			tmpTIPINS := (cTRBPPP)->TIPINS
			tmpCUSTO  := (cTRBPPP)->CUSTO
			tmpDEPTO  := (cTRBPPP)->DEPTO
			tmpFILIAL := (cTRBPPP)->FILIAL
			tmpMAT    := (cTRBPPP)->MAT
			tmpCARGO  := (cTRBPPP)->CARGO
			tmpCODFUN := (cTRBPPP)->CODFUN
			tmpDESFUN := (cTRBPPP)->DESFUN
			tmpEMP    := (cTRBPPP)->EMP

			lInsertTRB := .F.
			dbSelectArea( cTRBPPP )

			If !lAchou

				If (cTRBPPP)->DTDE >= SR9->R9_DATA-5
					RecLock( cTRBPPP, .F. )
						(cTRBPPP)->GFIP  := AllTrim( SR9->R9_DESC )
					(cTRBPPP)->( Msunlock())
				Else
					RecLock( cTRBPPP, .F. )
						(cTRBPPP)->DTATE := SR9->R9_DATA
						(cTRBPPP)->GFIP  := IIf( !Empty( cGFIP ), cGFIP, cGFIPant )
					(cTRBPPP)->( Msunlock())
					lInsertTRB := .T.
				EndIf

			Else
				lInsertTRB := .T.
				RestArea( aAreaAnt )
				RecLock( cTRBPPP, .F. )
					(cTRBPPP)->DTATE := SR9->R9_DATA
				(cTRBPPP)->( Msunlock())
			EndIf

			If lInsertTRB
				RecLock( cTRBPPP, .T. )
					(cTRBPPP)->DTDE   := SR9->R9_DATA
					(cTRBPPP)->DTATE  := tmpDTATE
					(cTRBPPP)->CNPJ   := tmpCNPJ
					(cTRBPPP)->TIPINS := tmpTIPINS
					(cTRBPPP)->CUSTO  := tmpCUSTO
					(cTRBPPP)->DEPTO  := tmpDEPTO
					(cTRBPPP)->FILIAL := tmpFILIAL
					(cTRBPPP)->MAT    := tmpMAT
					(cTRBPPP)->CARGO  := tmpCARGO
					(cTRBPPP)->CODFUN := tmpCODFUN
					(cTRBPPP)->DESFUN := tmpDESFUN
					(cTRBPPP)->EMP    := tmpEMP
					(cTRBPPP)->GFIP   := Alltrim( SR9->R9_DESC )
				(cTRBPPP)->( Msunlock())
			EndIf

			aAreaAnt := (cTRBPPP)->(GetArea())

			lAchou     := .T. //Controle p/ ver se houve alguma alteracao de GFIP em cada periodo de trabalho
			lGfipAll   := .T.
			cGFIPant   := Alltrim( SR9->R9_DESC )

			dbSelectArea( "SR9" )
			dbSkip()
		End

		RestArea( aAreaSv )

		If lMudEmpr .And. (cTRBPPP)->EMP != cEmpPPP
			U_EMP700OPEN( "SR9", "SR9", 1, cEmpPPP, @cModo )
		EndIf

		dbSelectArea( cTRBPPP )

		If !lAchou
			RecLock( cTRBPPP, .F. )
				(cTRBPPP)->GFIP := cGFIPant
			(cTRBPPP)->( Msunlock())
		EndIf

		RestArea( aAreaSv )
		dbSelectArea( cTRBPPP )
		dbSkip()
	End

	dbSelectArea( cTRBPPP )
	dbSetOrder( 1 )
	dbGoTop()

	While !Eof()

		If Empty( (cTRBPPP)->GFIP ) .Or. (cTRBPPP)->GFIP == "00"

			If lMudEmpr .And. (cTRBPPP)->EMP != cEmpPPP
				cModo := FWModeAccess( cAlias )
				U_EMP700OPEN( cAlias, cAlias, 1, (cTRBPPP)->EMP, @cModo, Substr( (cTRBPPP)->FILIAL, 1, FwSizeFilial( (cTRBPPP)->EMP ) ) )
			EndIf

			cModoCTT := f700RetCom( cAlias )
			cXFilCTT := FwxFilial( cAlias, Substr( (cTRBPPP)->FILIAL, 1, FwSizeFilial( (cTRBPPP)->EMP ) ), Substr( cModoCTT, 1, 1 ),;
				 Substr( cModoCTT, 2, 1 ), Substr( cModoCTT, 3, 1 ) )

			dbSelectArea( cAlias )
			dbSetOrder( 1 )

			If dbSeek( cXFilCTT + (cTRBPPP)->CUSTO )

				If cAlias == "SI3"

					If !Empty( SI3->I3_OCORREN )
						dbSelectArea( cTRBPPP )
						RecLock( cTRBPPP, .F. )
							(cTRBPPP)->GFIP := SI3->I3_OCORREN
						(cTRBPPP)->( Msunlock())
					EndIf

				ElseIf !Empty( CTT->CTT_OCORRE )
					dbSelectArea( cTRBPPP )
					RecLock( cTRBPPP, .F. )
						(cTRBPPP)->GFIP := CTT->CTT_OCORRE
					(cTRBPPP)->( Msunlock())
				EndIf

			EndIf

			If lMudEmpr .And. ( cTRBPPP )->EMP != cEmpPPP
				U_EMP700OPEN( cAlias, cAlias, 1, cEmpPPP, @cModo )
			EndIf

			If !Empty( SRA->RA_OCORREN ) .And. (Empty( (cTRBPPP)->GFIP ) .Or. (cTRBPPP)->GFIP == "00" ) .And. !lGfipAll
				RecLock( cTRBPPP, .F. )
					(cTRBPPP)->GFIP := SRA->RA_OCORREN
				(cTRBPPP)->( Msunlock())
			EndIf

		EndIf

		dbSelectArea( cTRBPPP )
		dbSkip()
	End

	dbSelectArea( cTRBPPP )
	dbSetOrder( 1 )
	dbGoTop()

	While !Eof() .And. lUpdDates
		aAreaTmp := (cTRBPPP)->(GetArea())
		dDtFimsv := CTOD( "  /  /  " )
		svPPPchv := (cTRBPPP)->CNPJ+Str( (cTRBPPP)->TIPINS, 1 ) + (cTRBPPP)->CUSTO + (cTRBPPP)->DEPTO + (cTRBPPP)->FILIAL + (cTRBPPP)->MAT+;
					(cTRBPPP)->CARGO + (cTRBPPP)->CODFUN + (cTRBPPP)->DESFUN + (cTRBPPP)->EMP + (cTRBPPP)->GFIP
		dbSkip()

		If !Eof()
			dbSelectArea( cTRBPPP )
			While !Eof() .And.;
				svPPPchv == (cTRBPPP)->CNPJ+Str( (cTRBPPP)->TIPINS, 1 )+(cTRBPPP)->CUSTO+(cTRBPPP)->DEPTO+(cTRBPPP)->FILIAL+;
				(cTRBPPP)->MAT+(cTRBPPP)->CARGO+(cTRBPPP)->CODFUN+(cTRBPPP)->DESFUN+(cTRBPPP)->EMP+(cTRBPPP)->GFIP

				If dDtFimsv < (cTRBPPP)->DTATE
					dDtFimsv := (cTRBPPP)->DTATE
				EndIf

				RecLock( cTRBPPP, .F. )
					dbDelete()
				(cTRBPPP)->( Msunlock())
				dbSelectArea( cTRBPPP )
				dbSkip()
			End

			If !Empty( dDtFimsv )
				RestArea( aAreaTmp )
				RecLock( cTRBPPP, .F. )
					(cTRBPPP)->DTATE := dDtFimsv
				(cTRBPPP)->( Msunlock())
			EndIf

		EndIf

		RestArea( aAreaTmp )
		dbSelectArea( cTRBPPP )
		dbSkip()
	End

	lTroca    := .T.
	cTrocaFun := " "
	// Executa os historicos
	dbSelectArea( cTRBPPP )
	Pack

	nRegTRB := (cTRBPPP)->(RECCOUNT())
	nConTRB := 0
	dbGoTop()

	While !EoF()
		nConTRB++

		If nConTRB > 1

			If cFilTNF != (cTRBPPP)->EMP+(cTRBPPP)->FILIAL
				dDtTransf := (cTRBPPP)->DTDE
				cFilTNF   := (cTRBPPP)->EMP+(cTRBPPP)->FILIAL
			EndIf

		Else
			cFilTNF := (cTRBPPP)->EMP+(cTRBPPP)->FILIAL
		EndIf

		cFilFichas := Substr( (cTRBPPP)->FILIAL, 1, FwSizeFilial( (cTRBPPP)->EMP ) )

		If lMudEmpr .And. (cTRBPPP)->EMP != cEmpPPP
			cModo := FWModeAccess( "TM0" )
			U_EMP700OPEN( "TM0", "TM0", 1, (cTRBPPP)->EMP, @cModo, cFilFichas )
			cModo := FWModeAccess( "SRJ" )
			U_EMP700OPEN( "SRJ", "SRJ", 1, ( cTRBPPP )->EMP, @cModo, cFilFichas )
			cModo := FWModeAccess( "SQ3" )
			U_EMP700OPEN( "SQ3", "SQ3", 1, ( cTRBPPP )->EMP, @cModo, cFilFichas )
			cModo := FWModeAccess( cAlias )
			U_EMP700OPEN( cAlias, cAlias, 1, ( cTRBPPP )->EMP, @cModo, cFilFichas )
		EndIf

		cModoTM0 := f700RetCom( "TM0" )
		cXFilTM0 := FwxFilial( "TM0", cFilFichas, Substr( cModoTM0, 1, 1 ), Substr( cModoTM0, 2, 1 ), Substr( cModoTM0, 3, 1 ) )

		cModoSRA := f700RetCom( "SRA" )
		cXFilSRA := FwxFilial( "SRA", cFilFichas, Substr( cModoSRA, 1, 1 ), Substr( cModoSRA, 2, 1 ), Substr( cModoSRA, 3, 1 ) )

		cModoSRJ := f700RetCom( "SRJ" )
		cXFilSRJ := FwxFilial( "SRJ", cFilFichas, Substr( cModoSRJ, 1, 1 ), Substr( cModoSRJ, 2, 1 ), Substr( cModoSRJ, 3, 1 ) )

		cModoSQ3 := f700RetCom( "SQ3" )
		cXFilSQ3 := FwxFilial( "SQ3", cFilFichas, Substr( cModoSQ3, 1, 1 ), Substr( cModoSQ3, 2, 1 ), Substr( cModoSQ3, 3, 1 ) )

		cModoCTT := f700RetCom( cAlias )
		cXFilCTT := FwxFilial( cAlias, cFilFichas, Substr( cModoCTT, 1, 1 ), Substr( cModoCTT, 2, 1 ), Substr( cModoCTT, 3, 1 ) )

		If (cTRBPPP)->DTDE == (cTRBPPP)->DTATE
			dDateAte := (cTRBPPP)->DTATE
		Else
            // No caso de demissão real, deve-se utilizar a mesma data, do contrário, subtrair um dia 
			dDateAte := ( cTRBPPP )->DTATE - IIf( nRegTRB == nConTRB, 0, 1 )
		EndIf

		dbSelectArea( "TM0" )
		dbSetOrder( 3 )

		If dbSeek( cXFilSRA + (cTRBPPP)->MAT )

			If (aScan( aFichasUsa, { |x| x[5] + x[1] + x[2] + DTOS( x[3] ) + DTOS( x[4] ) == (cTRBPPP)->EMP + cFilFichas +;
				 TM0->TM0_NUMFIC + DTOS( (cTRBPPP)->DTDE ) + DTOS( dDateAte ) } ) ) <= 0
				aAdd( aFichasUsa, { cFilFichas, TM0->TM0_NUMFIC, (cTRBPPP)->DTDE, dDateAte, (cTRBPPP)->EMP } )//Fichas Utilizadas pelo funcionario na empresa
				U_NG700VECAT( cFilFichas, TM0->TM0_NUMFIC, (cTRBPPP)->EMP ) //Verifica se existe CAT para a Ficha Medica do Funcionario
			EndIf

		EndIf

		strFuncao := (cTRBPPP)->DESFUN
		dbSelectArea( "SRJ" )
		dbSetOrder( 1 )

		// Determina se a descricao da funcao sera impressa no PPP verificando
		// os campos "Impr. no PPP?" e "Func. Lider" no registro da função (SRJ)
		If dbSeek( cXFilSRJ + (cTRBPPP)->CODFUN )
			nRJ_IMP := -1
			nRJ_IMP := Val( SRJ->RJ_PPPIMP )

			If nRJ_IMP <> 1
				nRJ_IMP := Val( SRJ->RJ_LIDER )

				If nRJ_IMP == 0
					nRJ_IMP := 2
				EndIf

			EndIf

			If nRJ_IMP == 2
				strFuncao := Space( 25 )
			EndIf

		EndIf

		If Empty( strFuncao )
			strFuncao := "NA"
		EndIf

		cCBO  := SRJ->RJ_CBO

		If Year( (cTRBPPP)->DTATE-1 ) >= 2003
			lTroca := .F.

			If !Empty( SRJ->RJ_CODCBO )
				cCBO := SRJ->RJ_CODCBO
			EndIf

		EndIf

		cTrocaFun := (cTRBPPP)->CODFUN

		dbSelectArea( "SQ3" )
		dbSetOrder( 1 )

		If  !dbSeek( cXFilSQ3+(cTRBPPP)->CARGO + (cTRBPPP)->CUSTO )
			dbSelectArea( "SQ3" )
			dbSetOrder( 1 )
			dbSeek( cXFilSQ3 + (cTRBPPP)->CARGO )

			If aScan( aCargoSv, { |x| x[1] + x[2] + x[4] == cFilFichas + (cTRBPPP)->CARGO + (cTRBPPP)->EMP } ) <= 0
				aAdd( aCargoSv, { cFilFichas, (cTRBPPP)->CARGO, "", (cTRBPPP)->EMP } )
			EndIf
		Else

			If aScan( aCargoSv, { |x| x[1] + x[2] + x[3] + x[4] == cFilFichas + (cTRBPPP)->CARGO + (cTRBPPP)->CUSTO + (cTRBPPP)->EMP } ) <= 0
				aAdd( aCargoSv, { cFilFichas, (cTRBPPP)->CARGO, (cTRBPPP)->CUSTO, (cTRBPPP)->EMP } )
			EndIf

		EndIf

		strCargo := SQ3->Q3_DESCSUM

		If Empty( strCargo )
			strCargo := (cTRBPPP)->DESCAR
		EndIf

		cCNPJtrb := (cTRBPPP)->CNPJ
		cTIPOtrb := (cTRBPPP)->TIPINS
		dbSelectArea( cAlias )
		dbSetOrder( 1 )

		If dbSeek( cXFilCTT + (cTRBPPP)->CUSTO ) .And. lCNPJCC

			If cAlias == "SI3" .And. !Empty( SI3->I3_CEI )
				cTIPOtrb := IIf( SI3->I3_TIPO == "1", 2, 1 )
				cCNPJtrb := SI3->I3_CEI
			ElseIf !Empty( CTT->CTT_CEI )
				cTIPOtrb := IIf( CTT->CTT_TIPO == "1", 2, 1 )
				cCNPJtrb := CTT->CTT_CEI
			EndIf

		EndIf

		If xm_par34 == 1 // Desc. da Lotação ?
			strCCusto := IIf( xm_par35 == 1, AllTrim( (cTRBPPP)->CUSTO ) + " - ", "" ) + &cDescr
		Else
			dbSelectArea( "SQB" )
			dbSetOrder( 1 )
			dbSeek( xFilial( "SQB", (cTRBPPP)->FILIAL ) + (cTRBPPP)->DEPTO )
			strCCusto := IIf( xm_par35 == 1, (cTRBPPP)->DEPTO + " - ", "" ) + SQB->QB_DESCRIC
		EndIf


		// Adiciona dados para o Historico do Funcionario
		nPosHist := aScan( aHistory, { | x | x[10] == cCNPJtrb                                 .And.;
											 x[5] == Alltrim( strCCusto )                      .And.;
											 x[IIf( lTrocaDes, 7, 6 )] == Alltrim( strCargo )  .And.;
											 x[IIf( !lTrocaDes, 7, 6 )] == Alltrim( strFuncao ).And.;
											 x[8] == cCBO                                      .And.;
											 x[9] == (cTRBPPP)->GFIP                           .And.;
											 x[1] == cFilFichas                                .And.;
											 x[2] == (cTRBPPP)->MAT                            .And.;
											 x[3] == (cTRBPPP)->DTDE                           .And.;
											 x[4] == dDateAte } )

		If nPosHist == 0

			If lSigaMdtps
				aAdd( aHistory,{ cFilFichas             ,;
								(cTRBPPP)->MAT          ,;
								(cTRBPPP)->DTDE         ,;
								dDateAte                ,;
								Alltrim( strCCusto )    ,;
								Alltrim( strCargo )     ,;
								Alltrim( strFuncao )    ,;
								cCBO                    ,;
								(cTRBPPP)->GFIP         ,;
								cCNPJtrb                ,;
								cTIPOtrb                ,;
								(cTRBPPP)->EMP          ,;
								(cTRBPPP)->CUSTO        ,;
								(cTRBPPP)->CODFUN       ,;
								(cTRBPPP)->CARGO } )	//Usado no MDTA102
			Else
				aAdd( aHistory, { cFilFichas         ,;
					            (cTRBPPP)->MAT     ,;
					            (cTRBPPP)->DTDE    ,;
					            dDateAte           ,;
					            Alltrim( strCCusto ) ,;
					            Alltrim( strCargo )  ,;
					            Alltrim( strFuncao ) ,;
					            cCBO               ,;
					            (cTRBPPP)->GFIP    ,;
					            cCNPJtrb           ,;
					            cTIPOtrb           ,;
								(cTRBPPP)->EMP } )
			EndIf

		Else
			aHistory[ nPosHist, 4 ] := dDateAte
		EndIf

		// Verifica se o funcionario executou alguma tarefa
		If !lMDTA102
			U_NG700TAREF( cFilFichas, (cTRBPPP)->MAT, (cTRBPPP)->DTDE, dDateAte,;
						 (cTRBPPP)->CUSTO, (cTRBPPP)->DEPTO, (cTRBPPP)->CODFUN, TM0->TM0_NUMFIC,;
						 (cTRBPPP)->EMP )
		EndIf

		If lMudEmpr .And. (cTRBPPP)->EMP != cEmpPPP
			U_EMP700OPEN( "TM0", "TM0", 1, cEmpPPP, @cModo )
			U_EMP700OPEN( "SRJ", "SRJ", 1, cEmpPPP, @cModo )
			U_EMP700OPEN( "SQ3", "SQ3", 1, cEmpPPP, @cModo )
			U_EMP700OPEN( cAlias, cAlias, 1, cEmpPPP, @cModo )
		EndIf

		dbSelectArea( cTRBPPP )
		dbSkip()
	End

Return aHistory

//-------------------------------------------------------------------
/*/{Protheus.doc} NG700RISCO

Verifica os riscos que o funcionario esteve exposto

@author  Denis Hyroshi de Souza
@since   21/10/02

@sample  U_NG700RISCO("D MG 01", "000000001", "*", "10.001", "", "00001", "000001", 01/01/2018, 19/07/2018, 1, "T1")

@param   cFilFun, Caracter, Filial do funcionario
@param   cFichaM, Caracter, Numero da ficha medica do funcionario
@param   cTarefa, Caracter, Codigo da tarefa do funcionario, "*" representa todas
@param   cCusto, Caracter, Codigo do centro de custo do funcionario, "*" representa todos
@param   cDepto, Caracter, Codigo do departamento do funcionario, "*" representa todos
@param   cFuncc, Caracter, Codigo da funcao do funcionario, "*" representa todas
@param   Mat, Caracter, Matricula do funcioario
@param   dIniRisco, Date, Data inicio da exposicao
@param   dFinRisco, Date, Data funal da exposicao
@param   nParam, Numerico, Quantidade de vezes que sarao executadas as operacoes da funcao
@param   cEmpFun, Caracter, Codigo da empresa no sistema
/*/
//-------------------------------------------------------------------
User Function NG700RISCO( cFilFun, cFichaM, cTarefa, cCusto, cDepto, cFuncc, Mat, dIniRisco, dFinRisco, nParam, cEmpFun )

	Local xEpis
	Local nx
	Local ny
	Local nFor1
	Local nFor2
	Local nTam := 8
	Local cModoTN0
	Local cModoTNX
	Local cModoTNF
	Local cXFilTNF
	Local cModoTN3
	Local cXFilTN3
	Local aAfasTip := ""
	Local nW

	Local cPrazoTNF
	Local cPrazoDur
	Local cHigiene
	Local nQtdeAfast


	Private cXFilTNX, cXFilTN0, cXFilTJF, cXFilTO4

	Default dDtTransf := CtoD( '//' )

	_cTarefa     := cTarefa
	_centrCusto  := cCusto
	_cFunccRis   := cFuncc
	_cDeptoRis   := cDepto
	cMatric      := Mat
	nRisco       := Space( 9 )

	If lMudEmpr .And. cEmpFun != cEmpPPP
		cModo := FWModeAccess( "TN0" )
		U_EMP700OPEN( "TN0", "TN0", 1, cEmpFun, @cModo, cFilFun )
		cModo := FWModeAccess( "TNX" )
		U_EMP700OPEN( "TNX", "TNX", 1, cEmpFun, @cModo, cFilFun )
		cModo := FWModeAccess( "TNF" )
		U_EMP700OPEN( "TNF", "TNF", 1, cEmpFun, @cModo, cFilFun )
		cModo := FWModeAccess( "TN3" )
		U_EMP700OPEN( "TN3", "TN3", 1, cEmpFun, @cModo, cFilFun )
		cModo := FWModeAccess( "TMA" )
		U_EMP700OPEN( "TMA", "TMA", 1, cEmpFun, @cModo, cFilFun )
		cModo := FWModeAccess( "SR8" )
		U_EMP700OPEN( "SR8", "SR8", 1, cEmpFun, @cModo, cFilFun )
		cModo := FWModeAccess( "TJF" )
		U_EMP700OPEN( "TJF", "TJF", 1, cEmpFun, @cModo, cFilFun )
		cModo := FWModeAccess( "TO4" )
		U_EMP700OPEN( "TO4", "TO4", 1, cEmpFun, @cModo, cFilFun )
	EndIf

	cModoTN0 := f700RetCom( "TN0" )
	cXFilTN0 := FwxFilial( "TN0", cFilFun, Substr( cModoTN0, 1, 1 ), Substr( cModoTN0, 2, 1 ), Substr( cModoTN0, 3, 1 ) )

	cModoTNX := f700RetCom( "TNX" )
	cXFilTNX := FwxFilial( "TNX", cFilFun, Substr( cModoTNX, 1, 1 ), Substr( cModoTNX, 2, 1 ), Substr( cModoTNX, 3, 1 ) )

	cModoTNF := f700RetCom( "TNF" )
	cXFilTNF := FwxFilial( "TNF", cFilFun, Substr( cModoTNF, 1, 1 ), Substr( cModoTNF, 2, 1 ), Substr( cModoTNF, 3, 1 ) )

	cModoTN3 := f700RetCom( "TN3" )
	cXFilTN3 := FwxFilial( "TN3", cFilFun, Substr( cModoTN3, 1, 1 ), Substr( cModoTN3, 2, 1 ), Substr( cModoTN3, 3, 1 ) )

	cModoTL0 := f700RetCom( "TL0" )
	cXFilTL0 := FwxFilial( "TL0", cFilFun, Substr( cModoTL0, 1, 1 ), Substr( cModoTL0, 2, 1 ), Substr( cModoTL0, 3, 1 ) )

	cModoTJF := f700RetCom( "TJF" )
	cXFilTJF := FwxFilial( "TJF", cFilFun, Substr( cModoTJF, 1, 1 ), Substr( cModoTJF, 2, 1 ), Substr( cModoTJF, 3, 1 ) )

	cModoTO4 := f700RetCom( "TO4" )
	cXFilTO4 := FwxFilial( "TO4", cFilFun, Substr( cModoTO4, 1, 1 ), Substr( cModoTO4, 2, 1 ), Substr( cModoTO4, 3, 1 ) )


	If nParam > 0

		For nx := 1 to nTam

			For nY := 1 To nParam

				If nx == 1
					_centrCusto := cCusto
					_cFunccRis  := cFuncc
					_cDeptoRis  := cDepto
				ElseIf nx == 2
					_centrCusto:= Padr( "*", nSizeSI3 )
					_cFunccRis := cFuncc
					_cDeptoRis := cDepto
				ElseIf nx == 3
					_centrCusto := cCusto
					_cFunccRis := Padr( "*", nSizeSRJ )
					_cDeptoRis := cDepto
				ElseIf nx == 4
					_centrCusto:= Padr( "*", nSizeSI3 )
					_cFunccRis := Padr( "*", nSizeSRJ )
					_cDeptoRis := cDepto
				ElseIf nx == 5
					_centrCusto := cCusto
					_cFunccRis  := cFuncc
					_cDeptoRis  := Padr( "*", nSizeSQB )
				ElseIf nx == 6
					_centrCusto:= Padr( "*", nSizeSI3 )
					_cFunccRis := cFuncc
					_cDeptoRis := Padr( "*", nSizeSQB )
				ElseIf nx == 7
					_centrCusto := cCusto
					_cFunccRis := Padr( "*", nSizeSRJ )
					_cDeptoRis := Padr( "*", nSizeSQB )
				ElseIf nx == 8
					_centrCusto:= Padr( "*", nSizeSI3 )
					_cFunccRis := Padr( "*", nSizeSRJ )
					_cDeptoRis := Padr( "*", nSizeSQB )
				EndIf

				dbSelectArea( "TN0" )
				dbSetOrder( 5 )

				If dbSeek( cXFilTN0 + _centrCusto + _cFunccRis + _cTarefa + _cDeptoRis )

					Do While !Eof() .And.AllTrim( TN0->TN0_CC ) == AllTrim( _centrCusto ) .And.;
						AllTrim( TN0->TN0_CODFUN ) == AllTrim( _cFunccRis ) .And.;
						AllTrim( TN0->TN0_CODTAR ) == AllTrim( _cTarefa ) .And.;
						AllTrim( TN0->TN0_DEPTO  ) == AllTrim( _cDeptoRis ) .And.;
						TN0->TN0_FILIAL == cXFilTN0 .And.;
						IIf( lSigaMdtps, TN0->(TN0_CODCLI+TN0_LOJACL) == SubStr( SRA->RA_CC, 1, nSizeTD ), .T. )


						If xm_par07 == 2 .And. TN0->TN0_LISASO $ "12" //Considerar Risco ?
							TN0->( dbSkip() )
							Loop
						EndIf

						aAfasTip := MDT700AFAS( Mat, dIniRisco, dFinRisco )//Verifica afastamentos durante período do risco.

						For nW := 1 To Len( aAfasTip )
							lStart     := .F.
							dInicioRis := aAfasTip[nW, 1] //dIniRisco
							dFimRis    := aAfasTip[nW, 2]//dFinRisco
							dtAval     := TN0->TN0_DTRECO

							If dtAval > dFimRis .Or. Empty( TN0->TN0_DTAVAL )
								Loop
							EndIf

							If !Empty( TN0->TN0_DTELIM ) .And. TN0->TN0_DTELIM <  dInicioRis
								Loop
							EndIf

							If dtAval >= dInicioRis  .And. dtAval <= dFimRis
								lStart  := .T.

								If !Empty( TN0->TN0_DTELIM ) .And. TN0->TN0_DTELIM < dFimRis
									dFimRis := TN0->TN0_DTELIM
								EndIf

								dInicioRis := dtAval
							ElseIf dtAval < dInicioRis .And. (Empty( TN0->TN0_DTELIM ) .Or. TN0->TN0_DTELIM >= dInicioRis )
								lStart  := .T.

								If !Empty( TN0->TN0_DTELIM ) .And. TN0->TN0_DTELIM < dFimRis
									dFimRis := TN0->TN0_DTELIM
								EndIf

							EndIf

							If lStart .And. lConsEPI // Se não consiste EPI
								U_NGGRAVA700( cFilFun, cFichaM, cCusto, cDepto, cFuncc, Mat, dInicioRis, dFimRis, Space( 12 ), "NA", cEmpFun, Space( 15 ) )
							ElseIf lStart .And. !lConsEPI // Se consiste EPI

								//Apaga todos os registros do arquivo temporario onde estao os EPI's entregues
								aTNFobr := {}
								aTNFalt := {}
								aTNFfam := {}
								Dbselectarea( cTRBTNF )
								ZAP
								lFirst     := .T.

								dbSelectArea( "TNX" )
								dbSetOrder( 1 )
								dbSeek( cXFilTNX + TN0->TN0_NUMRIS )

								While !Eof() .And. cXFilTNX == TNX->TNX_FILIAL .And. TN0->TN0_NUMRIS == TNX->TNX_NUMRIS

									If TNX->TNX_TIPO == "1"
										aAdd( aTNFobr, TNX->TNX_EPI )
									Else

										If (nPosi := aScan( aTNFfam, {|x| x == TNX->TNX_FAMIL } )) > 0
											aAdd( aTNFalt[nPosi], TNX->TNX_EPI )
										Else
											aAdd( aTNFfam, TNX->TNX_FAMIL )
											aAdd( aTNFalt, { TNX->TNX_EPI } )
										EndIf

									EndIf

									dbSelectArea( "TNX" )
									dbSkip()
								End

								// Epi nao esta previsto p/ funcionario
								If Len( aTNFobr ) == 0 .And. Len( aTNFalt ) == 0
									U_NGGRAVA700( cFilFun, cFichaM, cCusto, cDepto, cFuncc, Mat, dInicioRis, dFimRis, Space( 12 ), "NA", cEmpFun, Space( 15 ) )
								Else  // Epi esta previsto p/ funcionario
									lEpiObr   := .T. //Verifica se houve utilizacao de todos os EPIs necessarios
									dDtEficaz := CTOD( "//" ) //Data inicio Eficaz dos EPIs

									For nFor1 := 1 To Len( aTNFobr )
										dDtEfica2 := dFimRis
										lEpiSub := .F.
										dbSelectArea( "TNF" )
										dbSetOrder( 3 ) // TNF_FILIAL+TNF_MAT+TNF_CODEPI+DTOS(TNF_DTENTR)+TNF_HRENTR

										If Dbseek( cXFilTNF + Mat + aTNFobr[nFor1] )

											While !Eof() .And. cXFilTNF+Mat+aTNFobr[nFor1] == TNF->(TNF_FILIAL+TNF_MAT+TNF_CODEPI)

												cNUMCAP := Space( 12 )

												If TNF->TNF_INDDEV == "3" .Or. TNF->TNF_DTENTR > dFimRis
													dbSelectArea( "TNF" )
													dbSkip()
													Loop
												EndIf

												If TNF->TNF_DTDEVO < dInicioRis .And. !Empty( TNF->TNF_DTDEVO )
													dbSelectArea( "TNF" )
													dbSkip()
													Loop
												EndIf

												cNUMCAP := TNF->TNF_NUMCAP
												dbSelectArea( "TN3" )
												dbSetOrder( 1 )
												If dbSeek( cXFilTN3 + TNF->TNF_FORNEC + TNF->TNF_LOJA + TNF->TNF_CODEPI + TNF->TNF_NUMCAP )

													If aScan( aNUMCAPS, { |x| x[1] == TNF->TNF_NUMCAP } ) == 0 .And. !Empty( TN3->TN3_OBSAVA )
														aAdd( aNUMCAPS, { TNF->TNF_NUMCAP, TN3->TN3_OBSAVA } )
													EndIf

												EndIf

												lEpiSub := .T.
												lFirst  := .F.
												dDtEfica2 := IIf( TNF->TNF_DTENTR > dDtEfica2, dDtEfica2, TNF->TNF_DTENTR )
												dDtEntr   := IIf( TNF->TNF_DTENTR < dInicioRis, dInicioRis, TNF->TNF_DTENTR )
												cPROTEC := "S "

												If TNF->TNF_EPIEFI == "2"
													cPROTEC := "N "
												ElseIf TNF->TNF_EPIEFI == "3"
													cPROTEC := "  "
												EndIf

												dDtDevo := dFimRis

												If !Empty( TNF->TNF_DTDEVO ) .And. TNF->TNF_DTDEVO >= dInicioRis .And. TNF->TNF_DTDEVO < dFimRis
													dDtDevo := TNF->TNF_DTDEVO
												ElseIf Empty( TNF->TNF_DTDEVO )
													dbSelectArea( "TNF" )  //TNF_FILIAL+TNF_MAT+TNF_CODEPI+DTOS(TNF_DTENTR)+TNF_HRENTR
													dbSkip()

													If cXFilTNF+Mat+aTNFobr[nFor1] == TNF->(TNF_FILIAL+TNF_MAT+TNF_CODEPI);
															.And. TNF->(!Eof()) .And. TNF->TNF_INDDEV != "3"

														If dDtEntr < TNF->TNF_DTENTR .And. (TNF->TNF_DTENTR-1) >= dInicioRis .And. (TNF->TNF_DTENTR-1) < dFimRis
															dDtDevo := TNF->TNF_DTENTR-1
														ElseIf dDtEntr == TNF->TNF_DTENTR .And. TNF->TNF_DTENTR >= dInicioRis .And. TNF->TNF_DTENTR < dFimRis
															dDtDevo := TNF->TNF_DTENTR
														EndIf

													EndIf

													dbSkip( -1 )
												EndIf

												If !( TNF->TNF_DTENTR <= TN3->TN3_DTVENC .And. dDtDevo <= TN3->TN3_DTVENC )
													cPrazoTNF := "N"
												Else
													cPrazoTNF := "S"
												EndIf

												// Verifica se funcionario ficou afastado
												nQtdeAfast := 0

												If TN3->TN3_TPDURA == "U"
													nQtdeAfast := fQtdeAfast( cFilFun, cMatric, TNF->TNF_DTENTR, dDtDevo )
												EndIf

												// Verifica se pelo menos um EPI foi utilizado mais do que o seu prazo de durabilidade
												If TN3->TN3_INDEVO == "2"
													cPrazoDur := 'S'
												Else
													nDiasUtilizados := ( dDtDevo - TNF->TNF_DTENTR ) - nQtdeAfast
													If nDiasUtilizados > TN3->TN3_DURABI
														cPrazoDur := 'N'
													Else 
														cPrazoDur := 'S'
													EndIf
												EndIf

												If TN3->TN3_PERMAN > 0 .And. Empty( TNF->TNF_DTMANU )
													cHigiene := 'N'
												Else 
													cHigiene := 'S'
												EndIf

												lIncEpi := .F.
												dbSelectArea( cTRBTNF )
												dbSetOrder( 1 )

												If !dbSeek( DTOS( dDtEntr ) + cNUMCAP + cPROTEC + DTOS( TNF->TNF_DTENTR ) )
													lIncEpi := .T.
													RecLock( cTRBTNF, .T. )
														(cTRBTNF)->DTINI  := dDtEntr
														(cTRBTNF)->NUMCAP := cNUMCAP
														(cTRBTNF)->PROTEC := cPROTEC
														(cTRBTNF)->DTREAL := TNF->TNF_DTENTR
														(cTRBTNF)->DTDEVO := dDtDevo
														(cTRBTNF)->CODEPI := TNF->TNF_CODEPI
														(cTRBTNF)->PRZTNF := cPrazoTNF
														(cTRBTNF)->PRZDUR := cPrazoDur
														(cTRBTNF)->HIGIEN := cHigiene
													Msunlock()
												ElseIf (cTRBTNF)->CODEPI == TNF->TNF_CODEPI .And. dDtDevo > (cTRBTNF)->DTDEVO
													lIncEpi := .T.
													RecLock( cTRBTNF, .F. )
														(cTRBTNF)->DTDEVO := dDtDevo
													Msunlock()
												EndIf

												If lIncEpi
													lEpiEntregue := .T.
												EndIf

												dbSelectArea( "TNF" )
												dbSkip()
											End

										ElseIf NGCADICBASE( "TN3_GENERI", "D", "TN3", .F. )
											dbSelectArea( "TN3" )
											dbSetOrder( 2 )
											dbSeek( cXFilTN3 + aTNFobr[nFor1] )

											While TN3->(!Eof()) .And. TN3->TN3_CODEPI == aTNFobr[nFor1]

												If TN3->TN3_GENERI == '2'
													dbSelectArea( "TL0" )
													dbSetOrder( 1 )
													dbSeek( cXFilTL0 + aTNFobr[nFor1] + TN3->TN3_FORNEC + TN3->TN3_LOJA )

													While TL0->(!Eof()) .And. TL0->TL0_EPIGEN == aTNFobr[nFor1] .And. ;
														TL0->TL0_FORNEC = TN3->TN3_FORNEC .And. TL0->TL0_LOJA == TN3->TN3_LOJA
														dbSelectArea( "TNF" )
														dbSetOrder( 1 )

														If dbSeek( cXFilTNF+TL0->TL0_FORNEC+TL0->TL0_LOJA+TL0->TL0_EPIFIL+TL0->TL0_NUMCAP+Mat )

															While TNF->(!Eof()) .And. cXFilTNF+Mat+TL0->TL0_EPIFIL == TNF->(TNF_FILIAL+TNF_MAT+TNF_CODEPI)

																cNUMCAP := Space( 12 )

																If TNF->TNF_INDDEV == "3" .Or. TNF->TNF_DTENTR > dFimRis .Or. TNF->TNF_DTENTR < dDtTransf
																	dbSelectArea( "TNF" )
																	dbSkip()
																	Loop
																EndIf

																If TNF->TNF_DTDEVO < dInicioRis .And. !Empty( TNF->TNF_DTDEVO )
																	dbSelectArea( "TNF" )
																	dbSkip()
																	Loop
																EndIf

																cNUMCAP := TNF->TNF_NUMCAP

																If aScan( aNUMCAPS, {|x| x[1] == TNF->TNF_NUMCAP } ) == 0 //.and. !Empty(TN3->TN3_OBSAVA)
																	aAdd( aNUMCAPS, {TNF->TNF_NUMCAP, "" } )
																EndIf

																lEpiSub := .T.
																lFirst  := .F.
																dDtEfica2 := IIf (TNF->TNF_DTENTR > dDtEfica2, dDtEfica2, TNF->TNF_DTENTR )
																dDtEntr   := IIf (TNF->TNF_DTENTR < dInicioRis, dInicioRis, TNF->TNF_DTENTR )
																cPROTEC := "S "

																If TNF->TNF_EPIEFI == "2"
																	cPROTEC := "N "
																ElseIf TNF->TNF_EPIEFI == "3"
																	cPROTEC := "  "
																EndIf

																dDtDevo := dFimRis

																If !Empty( TNF->TNF_DTDEVO ) .And. TNF->TNF_DTDEVO >= dInicioRis .And. TNF->TNF_DTDEVO < dFimRis
																	dDtDevo := TNF->TNF_DTDEVO
																Elseif Empty( TNF->TNF_DTDEVO )
																	dbSelectArea( "TNF" )  //TNF_FILIAL+TNF_MAT+TNF_CODEPI+DTOS(TNF_DTENTR)+TNF_HRENTR
																	dbSkip()

																	If cXFilTNF+Mat+TL0->TL0_EPIFIL == TNF->(TNF_FILIAL+TNF_MAT+TNF_CODEPI) .And.;
																	   TNF->(!Eof()) .And. TNF->TNF_INDDEV != "3"

																		If dDtEntr < TNF->TNF_DTENTR .And. (TNF->TNF_DTENTR-1) >= dInicioRis .And. (TNF->TNF_DTENTR-1) < dFimRis
																			dDtDevo := TNF->TNF_DTENTR-1
																		ElseIf dDtEntr == TNF->TNF_DTENTR .And. TNF->TNF_DTENTR >= dInicioRis .And. TNF->TNF_DTENTR < dFimRis
																			dDtDevo := TNF->TNF_DTENTR
																		EndIf

																	EndIf

																	dbSkip( -1 )
																EndIf

																// Verifica se pelo menos um EPI foi entregue fora do prazo de validade
																	If !( TNF->TNF_DTENTR <= TL0->TL0_DTVENC .And. dDtDevo <= TL0->TL0_DTVENC )
																	cPrazoTNF := "N"
																Else
																	cPrazoTNF := "S"
																EndIf

																// Verifica se funcionario ficou afastado
																nQtdeAfast := 0

																If NGSEEK( 'TN3', TL0->TL0_FORNEC + TL0->TL0_LOJA + TL0->TL0_EPIGEN, 1, 'TN3->TN3_TPDURA' ) == "U"
																	nQtdeAfast := fQtdeAfast( cFilFun, cMatric, TNF->TNF_DTENTR, dDtDevo )
																EndIf

																// Verifica se pelo menos um EPI foi utilizado mais do que o seu prazo de durabilidade
																If NGSEEK( 'TN3', TL0->TL0_FORNEC + TL0->TL0_LOJA + TL0->TL0_EPIGEN, 1, 'TN3->TN3_INDEVO' ) == "2"
																	cPrazoDur := 'S'
																Else
																	nDiasUtilizados := ((cTRBTNF)->DTDEVO - (cTRBTNF)->DTREAL) - nQtdeAfast

																	If nDiasUtilizados > NGSEEK( 'TN3', TL0->TL0_FORNEC + TL0->TL0_LOJA + TL0->TL0_EPIGEN, 1, 'TN3->TN3_DURABI' )
																		cPrazoDur := 'N'
																	Else 
																		cPrazoDur := 'S'
																	EndIf

																EndIf

																// Verifica se pelo menos um EPI nao teve higienização
																If TN3->TN3_PERMAN > 0 .And. Empty( TNF->TNF_DTMANU )
																	cHigiene := 'N'
																Else 
																	cHigiene := 'S'
																EndIf

																lIncEpi := .F.
																dbSelectArea( cTRBTNF )
																dbSetOrder( 1 )

																If !dbSeek( DTOS( dDtEntr ) + cNUMCAP + cPROTEC + DTOS( TNF->TNF_DTENTR ) )
																	lIncEpi := .T.
																	RecLock( cTRBTNF, .T. )
																		(cTRBTNF)->DTINI  := dDtEntr
																		(cTRBTNF)->NUMCAP := cNUMCAP
																		(cTRBTNF)->PROTEC := cPROTEC
																		(cTRBTNF)->DTREAL := TNF->TNF_DTENTR
																		(cTRBTNF)->DTDEVO := dDtDevo
																		(cTRBTNF)->CODEPI := TNF->TNF_CODEPI
																		(cTRBTNF)->PRZTNF := cPrazoTNF
																		(cTRBTNF)->PRZDUR := cPrazoDur
																		(cTRBTNF)->HIGIEN := cHigiene
																	MsUnlock()
																ElseIf (cTRBTNF)->CODEPI == TNF->TNF_CODEPI .And. dDtDevo > (cTRBTNF)->DTDEVO
																	lIncEpi := .T.
																	RecLock( cTRBTNF, .F. )
																		(cTRBTNF)->DTDEVO := dDtDevo
																		/*(cTRBTNF)->PRZTNF := cPrazoTNF
																		(cTRBTNF)->PRZDUR := cPrazoDur
																		(cTRBTNF)->HIGIEN := cHigiene ****Condição não atendida no ADVPR*/
																	MsUnlock()
																EndIf

																If lIncEpi
																	lEpiEntregue := .T.
																EndIf

																dbSelectArea( "TNF" )
																dbSkip()
															End

														EndIf

														dbSelectArea( "TL0" )
														TL0->(dbSkip())
													End

												EndIf

												dbSelectArea( "TN3" )
												TN3->(dbSkip())
											End

										EndIf

										If !lEpiSub
											lEpiObr := .F.
										EndIf

										If dDtEfica2 > dDtEficaz
											dDtEficaz := dDtEfica2
										EndIf

									Next nFor1

									For nFor1 := 1 To Len( aTNFalt )
										lEpiAltOK := .F.
										dDtEfica2 := dFimRis

										For nFor2 := 1 To Len( aTNFalt[nFor1] )
											dbselectarea( "TNF" )
											dbsetorder( 3 )  //TNF_FILIAL+TNF_MAT+TNF_CODEPI+DTOS(TNF_DTENTR)+TNF_HRENTR

											If dbSeek( cXFilTNF+Mat+aTNFalt[nFor1, nFor2] )

												While !Eof() .And. cXFilTNF+Mat+aTNFalt[nFor1, nFor2] == TNF->(TNF_FILIAL+TNF_MAT+TNF_CODEPI)

													cNUMCAP := Space( 12 )

													If TNF->TNF_INDDEV == "3" .Or. TNF->TNF_DTENTR > dFimRis
														dbSelectArea( "TNF" )
														dbSkip()
														Loop
													EndIf

													If TNF->TNF_DTDEVO < dInicioRis .And. !Empty( TNF->TNF_DTDEVO )
														dbSelectArea( "TNF" )
														dbSkip()
														Loop
													EndIf

													cNUMCAP := TNF->TNF_NUMCAP
													dbSelectArea( "TN3" )
													dbSetOrder( 1 )

													If dbSeek( xFilial( "TN3", cFilFun ) + TNF->TNF_FORNEC + TNF->TNF_LOJA + TNF->TNF_CODEPI + TNF->TNF_NUMCAP ) .And.;
													   aScan( aNUMCAPS, { |x| x[1] == TNF->TNF_NUMCAP } ) == 0 .And. !Empty( TN3->TN3_OBSAVA )

														aAdd( aNUMCAPS, { TNF->TNF_NUMCAP, TN3->TN3_OBSAVA } )
													EndIf

													lEpiAltOK := .T.
													lFirst    := .F.
													dDtEfica2 := IIf( TNF->TNF_DTENTR > dDtEfica2, dDtEfica2, TNF->TNF_DTENTR )
													dDtEntr := IIf( TNF->TNF_DTENTR < dInicioRis, dInicioRis, TNF->TNF_DTENTR )
													cPROTEC := "S "

													If TNF->TNF_EPIEFI == "2"
														cPROTEC := "N "
													ElseIf TNF->TNF_EPIEFI == "3"
														cPROTEC := "  "
													EndIf

													dDtDevo := dFimRis

													If !Empty( TNF->TNF_DTDEVO ) .And. TNF->TNF_DTDEVO >= dInicioRis .And. TNF->TNF_DTDEVO < dFimRis
														dDtDevo := TNF->TNF_DTDEVO
													Elseif Empty( TNF->TNF_DTDEVO )
														dbSelectArea( "TNF" )  //TNF_FILIAL+TNF_MAT+TNF_CODEPI+DTOS(TNF_DTENTR)+TNF_HRENTR
														dbSkip()

														If cXFilTNF + Mat + aTNFalt[nFor1, nFor2] == TNF->(TNF_FILIAL+TNF_MAT+TNF_CODEPI);
																.And. TNF->(!Eof()) .And. TNF->TNF_INDDEV != "3"

															If dDtEntr < TNF->TNF_DTENTR

																If (TNF->TNF_DTENTR-1) >= dInicioRis .And. (TNF->TNF_DTENTR-1) < dFimRis
																	dDtDevo := TNF->TNF_DTENTR-1
																EndIf

															ElseIf dDtEntr == TNF->TNF_DTENTR

																If TNF->TNF_DTENTR >= dInicioRis .And. TNF->TNF_DTENTR < dFimRis
																	dDtDevo := TNF->TNF_DTENTR
																EndIf

															EndIf

														EndIf

														dbSkip( -1 )
													EndIf

													// Verifica se pelo menos um EPI foi entregue fora do prazo de validade
													If !( TNF->TNF_DTENTR <= TN3->TN3_DTVENC .And. dDtDevo <= TN3->TN3_DTVENC )
														cPrazoTNF := "N"
													Else
														cPrazoTNF := "S"
													EndIf

													// Verifica se funcionario ficou afastado
													nQtdeAfast := 0

													If TN3->TN3_TPDURA == "U"
														nQtdeAfast := fQtdeAfast( cFilFun, cMatric, TNF->TNF_DTENTR, dDtDevo )
													EndIf

													// Verifica se pelo menos um EPI foi utilizado mais do que o seu prazo de durabilidade
													If TN3->TN3_INDEVO == "2"
														cPrazoDur := 'S'
													Else
														nDiasUtilizados := ( dDtDevo - TNF->TNF_DTENTR ) - nQtdeAfast

														If nDiasUtilizados > TN3->TN3_DURABI
															cPrazoDur := 'N'
														Else 
															cPrazoDur := 'S'
														EndIf

													EndIf

													// Verifica se pelo menos um EPI nao teve higienização
													If TN3->TN3_PERMAN > 0 .And. Empty( TNF->TNF_DTMANU )
														cHigiene := 'N'
													Else 
														cHigiene := 'S'
													EndIf

													lIncEpi := .F.
													dbSelectArea( cTRBTNF )
													dbSetOrder( 1 )

													If !dbSeek( DTOS( dDtEntr ) + cNUMCAP + cPROTEC + DTOS( TNF->TNF_DTENTR ) )
														lIncEpi := .T.
														RecLock( cTRBTNF, .T. )
															(cTRBTNF)->DTINI  := dDtEntr
															(cTRBTNF)->NUMCAP := cNUMCAP
															(cTRBTNF)->PROTEC := cPROTEC
															(cTRBTNF)->DTREAL := TNF->TNF_DTENTR
															(cTRBTNF)->DTDEVO := dDtDevo
															(cTRBTNF)->CODEPI := TNF->TNF_CODEPI
															(cTRBTNF)->PRZTNF := cPrazoTNF
															(cTRBTNF)->PRZDUR := cPrazoDur
															(cTRBTNF)->HIGIEN := cHigiene
														MsUnlock()
													ElseIf (cTRBTNF)->CODEPI == TNF->TNF_CODEPI .And. dDtDevo > (cTRBTNF)->DTDEVO
														lIncEpi := .T.
														RecLock( cTRBTNF, .F. )
															(cTRBTNF)->DTDEVO := dDtDevo
														/*	(cTRBTNF)->PRZTNF := cPrazoTNF
															(cTRBTNF)->PRZDUR := cPrazoDur
															(cTRBTNF)->HIGIEN := cHigiene*/
														MsUnlock()
													EndIf

													If lIncEpi
														lEpiEntregue := .T.
													EndIf

													dbSelectArea( "TNF" )
													dbSkip()
												End

											ElseIf NGCADICBASE( "TN3_GENERI", "D", "TN3", .F. )
												dbSelectArea( "TN3" )
												dbSetOrder( 2 )
												dbSeek( cXFilTN3 + aTNFalt[nFor1, nFor2] )

												While TN3->(!Eof()) .And. TN3->TN3_CODEPI == aTNFalt[nFor1, nFor2]

													If TN3->TN3_GENERI == '2'
														dbSelectArea( "TL0" )
														dbSetOrder( 1 )
														dbSeek( cXFilTL0 + aTNFalt[nFor1, nFor2] + TN3->TN3_FORNEC + TN3->TN3_LOJA )

														While TL0->(!Eof()) .And. TL0->TL0_EPIGEN == aTNFalt[nFor1, nFor2] .And. ;
															TL0->TL0_FORNEC = TN3->TN3_FORNEC .And. TL0->TL0_LOJA == TN3->TN3_LOJA
															dbSelectArea( "TNF" )
															dbSetOrder( 1 )

															If dbSeek( cXFilTNF+TL0->TL0_FORNEC+TL0->TL0_LOJA+TL0->TL0_EPIFIL+TL0->TL0_NUMCAP+Mat )

																While TNF->(!Eof()) .And. cXFilTNF+Mat+TL0->TL0_EPIFIL == TNF->(TNF_FILIAL+TNF_MAT+TNF_CODEPI)

																	cNUMCAP := Space( 12 )

																	If TNF->TNF_INDDEV == "3" .Or. TNF->TNF_DTENTR > dFimRis .Or. TNF->TNF_DTENTR < dDtTransf
																		dbSelectArea( "TNF" )
																		dbSkip()
																		Loop
																	EndIf

																	If TNF->TNF_DTDEVO < dInicioRis .And. !Empty( TNF->TNF_DTDEVO )
																		dbSelectArea( "TNF" )
																		dbSkip()
																		Loop
																	EndIf

																	cNUMCAP := TNF->TNF_NUMCAP

																	If aScan( aNUMCAPS, { |x| x[1] == TNF->TNF_NUMCAP } ) == 0
																		aAdd( aNUMCAPS, { TNF->TNF_NUMCAP, "" } )
																	EndIf

																	lEpiAltOK := .T.
																	lFirst    := .F.
																	dDtEfica2 := IIf( TNF->TNF_DTENTR > dDtEfica2, dDtEfica2, TNF->TNF_DTENTR )
																	dDtEntr := IIf( TNF->TNF_DTENTR < dInicioRis, dInicioRis, TNF->TNF_DTENTR )
																	cPROTEC := "S "

																	If TNF->TNF_EPIEFI == "2"
																		cPROTEC := "N "
																	ElseIf TNF->TNF_EPIEFI == "3"
																		cPROTEC := "  "
																	EndIf

																	dDtDevo := dFimRis

																	If !Empty( TNF->TNF_DTDEVO ) .And. TNF->TNF_DTDEVO >= dInicioRis .And. TNF->TNF_DTDEVO < dFimRis
																		dDtDevo := TNF->TNF_DTDEVO
																	ElseIf Empty( TNF->TNF_DTDEVO )
																		dbSelectArea( "TNF" )  //TNF_FILIAL+TNF_MAT+TNF_CODEPI+DTOS(TNF_DTENTR)+TNF_HRENTR
																		dbSkip()

																		If cXFilTNF+Mat+TL0->TL0_EPIFIL == TNF->(TNF_FILIAL+TNF_MAT+TNF_CODEPI);
																				.And. TNF->(!Eof()) .And. TNF->TNF_INDDEV != "3"

																			If dDtEntr < TNF->TNF_DTENTR

																				If (TNF->TNF_DTENTR-1) >= dInicioRis .And. (TNF->TNF_DTENTR-1) < dFimRis
																					dDtDevo := TNF->TNF_DTENTR-1
																				EndIf

																			ElseIf dDtEntr == TNF->TNF_DTENTR

																				If TNF->TNF_DTENTR >= dInicioRis .And. TNF->TNF_DTENTR < dFimRis
																					dDtDevo := TNF->TNF_DTENTR
																				EndIf

																			EndIf

																		EndIf

																		dbSkip( -1 )
																	EndIf

																	lIncEpi := .F.
	
																	If !( TNF->TNF_DTENTR <= TL0->TL0_DTVENC .And. dDtDevo <= TL0->TL0_DTVENC )
																		cPrazoTNF := "N"
																	Else
																		cPrazoTNF := "S"
																	EndIf

																	// Verifica se funcionario ficou afastado
																	nQtdeAfast := 0

																	If TN3->TN3_TPDURA == "U"
																		nQtdeAfast := fQtdeAfast( cFilFun, cMatric, TNF->TNF_DTENTR, dDtDevo )
																	EndIf

																	If NGSEEK( 'TN3', TL0->TL0_FORNEC+TL0->TL0_LOJA+TL0->TL0_EPIGEN, 1, 'TN3->TN3_INDEVO' ) == "2"
																		cPrazoDur := 'S'
																	Else
																		nDiasUtilizados := ( dDtDevo - TNF->TNF_DTENTR ) - nQtdeAfast
																		If nDiasUtilizados > NGSEEK( 'TN3', TL0->TL0_FORNEC+TL0->TL0_LOJA+TL0->TL0_EPIGEN, 1, 'TN3->TN3_DURABI' )
																			cPrazoDur := 'N'
																		Else 
																			cPrazoDur := 'S'
																		EndIf
																	EndIf

																	If TN3->TN3_PERMAN > 0 .And. Empty( TNF->TNF_DTMANU )
																		cHigiene := 'N'
																	Else 
																		cHigiene := 'S'
																	EndIf

																	dbSelectArea( cTRBTNF )
																	dbSetOrder( 1 )

																	If !dbSeek( DTOS( dDtEntr )+cNUMCAP+cPROTEC+DTOS( TNF->TNF_DTENTR ) )
																		lIncEpi := .T.
	
																		RecLock( cTRBTNF, .T. )
																			(cTRBTNF)->DTINI  := dDtEntr
																			(cTRBTNF)->NUMCAP := cNUMCAP
																			(cTRBTNF)->PROTEC := cPROTEC
																			(cTRBTNF)->DTREAL := TNF->TNF_DTENTR
																			(cTRBTNF)->DTDEVO := dDtDevo
																			(cTRBTNF)->CODEPI := TNF->TNF_CODEPI
																			(cTRBTNF)->PRZTNF := cPrazoTNF
																			(cTRBTNF)->PRZDUR := cPrazoDur
																			(cTRBTNF)->HIGIEN := cHigiene
																		Msunlock()

																	ElseIf (cTRBTNF)->CODEPI == TNF->TNF_CODEPI .And. dDtDevo > (cTRBTNF)->DTDEVO
																		lIncEpi := .T.

																		RecLock( cTRBTNF, .F. )
																			(cTRBTNF)->DTDEVO := dDtDevo
																		Msunlock()
																		
																	EndIf

																	If lIncEpi
																		lEpiEntregue := .T.
																	EndIf

																	dbSelectArea( "TNF" )
																	dbSkip()
																End

															EndIf

															dbSelectArea( "TL0" )
															TL0->(dbSkip())
														End

													EndIf

													dbSelectArea( "TN3" )
													TN3->(dbSkip())
												End

											EndIf

										Next nFor2

										If dDtEfica2 > dDtEficaz
											dDtEficaz := dDtEfica2
										EndIf

										If !lEpiAltOK
											lEpiObr := .F.
										EndIf

									Next nFor1

									dDtEficaz := IIf( dInicioRis+nLimite_Dias_Epi >= dDtEficaz, dInicioRis, dDtEficaz )

									//Cria historico de epi's entregues
									If !lFirst  //Epi esta previsto p/ funcionario e foi entregue

										If dDtEficaz != dInicioRis
											U_NGGRAVA700( cFilFun, cFichaM, cCusto, cDepto, cFuncc, Mat, dInicioRis, dDtEficaz-1, Space( 12 ), "N ", cEmpFun, Space( 15 ) )
										EndIf

										U_fPPP_EPI( dInicioRis )
										aEPIS := {}

										dbSelectArea( cTRBTNF )
										dbSetOrder( 1 )
										dbGoTop()
										dDtTNFfi2 := (cTRBTNF)->DTDEVO

										While !Eof()
											dDtTNFini := (cTRBTNF)->DTINI

											If (cTRBTNF)->DTDEVO > dDtTNFfi2
												dDtTNFfi2 := (cTRBTNF)->DTDEVO
											EndIf

											dbSkip()

											If !Eof()

												If (cTRBTNF)->DTINI > dDtTNFfi2+nLimite_Dias_Epi .And. (dDtTNFfi2+1) <= ((cTRBTNF)->DTINI-1)
													aAdd( aEPIS, { dDtTNFfi2 + 1, (cTRBTNF)->DTINI - 1, Space( 12 ), "N ", Space( 15 ) } )
													dDtTNFfi2 := (cTRBTNF)->DTDEVO
												EndIf

											Else

												If dFimRis > dDtTNFfi2+nLimite_Dias_Epi
													aAdd( aEPIS, { dDtTNFfi2+1, dFimRis, Space( 12 ), "N ", Space( 15 ) } )
												EndIf

											EndIf
										End

										dbSelectArea( cTRBTNF )
										dbSetOrder( 2 )
										dbSeek( " " )

										While !Eof() .And. (cTRBTNF)->SITUAC == " "

											If lEpiObr

												If (cTRBTNF)->DTINI >= dDtEficaz
													aAdd( aEPIS, { (cTRBTNF)->DTINI, (cTRBTNF)->DTDEVO, (cTRBTNF)->NUMCAP, (cTRBTNF)->PROTEC,;
														(cTRBTNF)->CODEPI, (cTRBTNF)->PRZTNF, (cTRBTNF)->PRZDUR, (cTRBTNF)->HIGIEN } )
												ElseIf dDtEficaz <= (cTRBTNF)->DTDEVO
													aAdd( aEPIS, { dDtEficaz, (cTRBTNF)->DTDEVO, (cTRBTNF)->NUMCAP, (cTRBTNF)->PROTEC,;
														(cTRBTNF)->CODEPI, (cTRBTNF)->PRZTNF, (cTRBTNF)->PRZDUR, (cTRBTNF)->HIGIEN } )
												EndIf

											Else
												aAdd( aEpis, { ( cTRBTNF )->DTINI, ( cTRBTNF )->DTDEVO, ( cTRBTNF )->NUMCAP, 'N ',;
													( cTRBTNF )->CODEPI, (cTRBTNF)->PRZTNF, (cTRBTNF)->PRZDUR, (cTRBTNF)->HIGIEN } )
											EndIf

											dbSelectArea( cTRBTNF )
											dbSkip()
										End

										For xEpis := 1 to Len( aEPIS )

											// Adiciona no array as posições faltantes
											If Len( aEpis[ xEpis ] ) == 5
												aAdd( aEpis[ xEpis ], aEpis[ xEpis, 4 ] )
												aAdd( aEpis[ xEpis ], aEpis[ xEpis, 4 ] )
												aAdd( aEpis[ xEpis ], aEpis[ xEpis, 4 ] )
											EndIf

											U_NGGRAVA700( cFilFun, cFichaM, cCusto, cDepto, cFuncc, Mat, aEPIS[xEpis, 1], aEPIS[xEpis, 2],;
												 aEPIS[xEpis, 3], aEPIS[xEpis, 4], cEmpFun, aEPIS[xEpis, 5], aEPIS[xEpis, 6], aEPIS[xEpis, 7], aEPIS[xEpis, 8] )

										Next xEpis

									Else //Epi esta previsto p/ funcionario e nao foi entregue
										U_NGGRAVA700( cFilFun, cFichaM, cCusto, cDepto, cFuncc, Mat, dInicioRis, dFimRis, Space( 12 ), "N ", cEmpFun, Space( 15 ) )
									EndIf

								EndIf //Fim - Tem EPI previsto

							EndIf //Fim - Consiste EPI

						Next nW

						dbSelectArea( "TN0" )
						dbSkip()
					EndDo

				EndIf

			Next ny

		Next nx

	EndIf

	If lMudEmpr .And. cEmpFun != cEmpPPP
		U_EMP700OPEN( "TN0", "TN0", 1, cEmpPPP, @cModo )
		U_EMP700OPEN( "TNX", "TNX", 1, cEmpPPP, @cModo )
		U_EMP700OPEN( "TNF", "TNF", 1, cEmpPPP, @cModo )
		U_EMP700OPEN( "TN3", "TN3", 1, cEmpPPP, @cModo )
		U_EMP700OPEN( "TMA", "TMA", 1, cEmpPPP, @cModo )
		U_EMP700OPEN( "SR8", "SR8", 1, cEmpPPP, @cModo )
	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} NG700TAREF

Busca as tarefas do funcionario no periodo

@author  Denis Hyroshi de Souza
@since   21/10/02

@sample  U_NG700TAREF("D MG 01 ", "000001", 01/01/2018, 19/07/2018, "10.001   ", "", "00001", "000000001", "T1")

@param   Fil, Caracter, Filial do funcionario
@param   Mat, Caracter, Matricula do funcionario
@param   dDTde, Date, Data inicio do periodo das tarefas
@param   dDTate, Date, Data fim do periodo das tarefas
@param   cCusto, Caracter, Codigo do centro de custo do funcionario
@param   cDepto, Caracter, Codigo do departamento do funcionario
@param   cFuncc, Caracter, Codigo da funcao do funcionario
@param   cFicha, Caracter, Numero da ficha medica do funcionario
@param   cEmpNG, Caracter, Empresa no sistema
/*/
//-------------------------------------------------------------------
User Function NG700TAREF( Fil, Mat, dDTde, dDTate, cCusto, cDepto, cFuncc, cFicha, cEmpNG )

	Local cTarefa := "*"
	Local cModoTN6
	Local cXFilTN6

	_cEmpNG := cEmpNG
	_Fil    := Fil
	_cFicha := cFicha
	_cCusto := cCusto
	_cDepto := cDepto
	_cFuncc := cFuncc
	_Mat := Mat
	_dDTinicio  := dDTde
	_dDTfim := dDTate
	lStart  := .F.

	If lMudEmpr .And. _cEmpNG != cEmpPPP
		cModo := FWModeAccess( "TN6" )
		U_EMP700OPEN( "TN6", "TN6", 1, _cEmpNG, @cModo, Fil )
	EndIf

	cModoTN6 := f700RetCom( "TN6" )
	cXFilTN6 := FwxFilial( "TN6", _Fil, Substr( cModoTN6, 1, 1 ), Substr( cModoTN6, 2, 1 ), Substr( cModoTN6, 3, 1 ) )

	// Busca os riscos que o funcinario esta exposto nessas condicoes
	dbSelectArea( "TN6" )
	dbSetOrder( 2 )
	dbSeek( cXFilTN6 + _Mat )

	While !Eof() .And. cXFilTN6 == TN6->TN6_FILIAL .And. _Mat == TN6->TN6_MAT

		_dDTinicio  := dDTde
		_dDTfim := dDTate

		If TN6->TN6_DTINIC > _dDTfim .Or. (TN6->TN6_DTTERM < _dDTinicio  .And. !Empty( TN6->TN6_DTTERM ))
			dbSelectArea( "TN6" )
			dbSkip()
			Loop
		EndIf

		If TN6->TN6_DTINIC >= _dDTinicio  .And. TN6->TN6_DTINIC <= _dDTfim
			lStart  := .T.

			If TN6->TN6_DTTERM < _dDTfim .And. !Empty( TN6->TN6_DTTERM )
				_dDTfim := TN6->TN6_DTTERM
			EndIf

			_dDTinicio := TN6->TN6_DTINIC

		ElseIf TN6->TN6_DTINIC < _dDTinicio .And. (TN6->TN6_DTTERM >= _dDTinicio .Or. Empty( TN6->TN6_DTTERM ))
			lStart  := .T.

			If TN6->TN6_DTTERM < _dDTfim .And. !Empty( TN6->TN6_DTTERM )
				_dDTfim := TN6->TN6_DTTERM
			EndIf

		EndIf

		cTarefa := TN6->TN6_CODTAR

		If lStart
			U_NG700RISCO( _Fil, _cFicha, cTarefa, _cCusto, _cDepto, _cFuncc, _Mat, _dDTinicio, _dDTfim, 1, _cEmpNG )
		EndIf

		dbSelectArea( "TN6" )
		dbSkip()
	EndDo

	If lMudEmpr .And. _cEmpNG != cEmpPPP
		U_EMP700OPEN( "TN6", "TN6", 1, cEmpPPP, @cModo )
	EndIf

	cTarefa := Padr( "*", nSizeTN5 )
	U_NG700RISCO( _Fil, _cFicha, cTarefa, _cCusto, _cDepto, _cFuncc, _Mat, _dDTinicio, _dDTfim, 1, _cEmpNG )

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} NGGRAVA700

Grava arquivo de trabalho contendo os riscos do funcionario

@author  Denis Hyroshi de Souza
@since   21/10/02

@sample  U_NGGRAVA700("D MG 01 ", "000000001", "10.001   ", "", "00001", "000001", 20/04/2018, 20/04/2018, "", "NA", "T1", "")

@param   cFilFun, Caracter, Filial do funcionario
@param   cFichaM, Caracter, Numero da ficha medica do funcionario
@param   cCusto, Caracter, Codigo do centro de custo do funcionario
@param   cDepto, Caracter, Codigo do departamento do funcionario
@param   cFuncc, Caracter, Codigo da funcao do funcionario
@param   Mat, Caracter, Matricula do funcionario
@param   dInicioRis, Date, Inicio do periodo de exposicao aos riscos que serao gravados
@param   dFimRis, Date, Fim do periodo de exposicao aos riscos que serao gravados
@param   cNUMCAP, Caracter, Numero do certificado de aprovacao do epi relacionado ao risco
@param   cEpiFunc, Caracter, Indica se há EPI eficaz
@param   cEmpFun, Caracter, Empresa do sistema
@param   cCodEPI, Caracter, Codigo do Epi relacionado ao risco
@param   cPrazoTNF, Caracter, Prazo de validade do EPI
@param   cPrazoDur, Caracter, Durabilidade do EPI
@param   cHigiene, Caracter, Indica se EPI teve higienização
@param   cFilRis, Caracter, Filial do funcionario
/*/
//-------------------------------------------------------------------
User Function NGGRAVA700( cFilFun, cFichaM, cCusto, cDepto, cFuncc, Mat, dInicioRis, dFimRis, cNUMCAP, cEpiFunc, cEmpFun, cCodEPI, cPrazoTNF, cPrazoDur, cHigiene, cFilRis )

	Local lSave  := .F.
	Local lAchouRisco := .F.
	Local cEXPOSICAO := " "
	Local cModoTMA, cXFilTMA
	Local nAtual := 0
	Local nTotalFch := 0
	Local nTotalAbr := 0
	Local cUnidade := ""

	Private lEpiFunc := Substr( cEpiFunc, 1, Len( cEpiFunc ) )
	Private lEpcFunc := TN0->TN0_EPC
	Private _cNUMCAP := cNUMCAP
	Private cTECNICA := Space( 40 )
	Default cCodEpi := ""
	Private _cCodEpi := cCodEPI

	cCondRis := cFilFun+TN0->TN0_NUMRIS+DTOS( dInicioRis )+DTOS( dFimRis )+cFichaM+cEmpFun

	If aScan( aRiscos, { |x| x[1]+x[2]+DTOS( x[3] )+DTOS( x[4] )+x[5]+x[7] == cCondRis } ) <= 0
		aAdd( aRiscos, { cFilFun, TN0->TN0_NUMRIS, dInicioRis, dFimRis, cFichaM, TN0->TN0_AGENTE, cEmpFun } ) // Adiciona o numero do risco na array aRISCOS
	EndIf

	cEXPOSICAO := TN0->TN0_INDEXP
	cTECNICA := TN0->TN0_TECUTI+Space( 40 - Len( TN0->TN0_TECUTI ) )
	cEpiant := " "
	cModoTMA := f700RetCom( "TMA" )
	cXFilTMA := FwxFilial( "TMA", cFilFun, Substr( cModoTMA, 1, 1 ), Substr( cModoTMA, 2, 1 ), Substr( cModoTMA, 3, 1 ) )

	dbSelectArea( "TMA" )
	dbSetOrder( 1 )

	If !dbSeek( cXFilTMA+TN0->TN0_AGENTE )
		Return .T.
	EndIf

	cNOME_AGENTE := 'TMA->TMA_NOMAGE'

	// Se for agente quimico, pegar a substancia ativa como descricao.
	If TMA->TMA_GRISCO == "2" .And. !Empty( TMA->TMA_SUBATI )
		cNOME_AGENTE := 'Substr(TMA->TMA_SUBATI,1,40)'
	EndIf

	cKeyRisco := 'TMA->TMA_GRISCO+'+cNOME_AGENTE+'+Str(TN0->TN0_QTAGEN,nQTAGENt,nQTAGENd)+'
	cKeyRisco += 'cTECNICA+lEpcFunc+lEpiFunc+_cCodEpi+_cNUMCAP'

	dbSelectArea( cTRBTN0 )
	dbSetOrder( 2 )  // GRISCO + AGENTE + Str(INTENS,9,3) + TECNIC + EPC + PROTEC + CODEPI + NUMCAP

	If !dbSeek( &cKeyRisco )
		lSave  := .T.
	Else
		dtstart := dInicioRis
		dtstop  := dFimRis
		nRecOld := Nil
		dbSelectArea( cTRBTN0 )
		dbSetOrder( 2 )
		dbSeek( &cKeyRisco )
		While !Eof() .And. &cKeyRisco == (cTRBTN0)->(GRISCO+AGENTE+Str( INTENS, nQTAGENt, nQTAGENd )+TECNIC+EPC+PROTEC+CODEPI+NUMCAP)


			If (cTRBTN0)->DT_DE <= dtstart .And. (cTRBTN0)->DT_ATE >= dtstart-1

				If dtStop > (cTRBTN0)->DT_ATE
					RecLock( cTRBTN0, .F. )
						(cTRBTN0)->DT_ATE := dtstop
						dtstart := (cTRBTN0)->DT_DE
					Msunlock()
					aAreaTRB := (cTRBTN0)->(GetArea())

					If nRecOld != nil
						dbSelectArea( cTRBTN0 )
						dbGoTo( nRecOld )
						(cTRBTN0)->(Dbdelete())
					EndIf

					RestArea( aAreaTRB )
				EndIf

				lAchouRisco := .T.
				nRecOld := recno()

			ElseIf (cTRBTN0)->DT_DE <= dtstop + 1 .And. (cTRBTN0)->DT_ATE >= dtstop

				If dtstart < (cTRBTN0)->DT_DE
					RecLock( cTRBTN0, .F. )
						(cTRBTN0)->DT_DE := dtstart
						dtstop := (cTRBTN0)->DT_ATE
					MsUnlock()
					aAreaTRB := (cTRBTN0)->(GetArea())

					If nRecOld != Nil
						dbSelectArea( cTRBTN0 )
						dbGoTo( nRecOld )
						(cTRBTN0)->(Dbdelete())
					EndIf

					RestArea( aAreaTRB )
				EndIf

				lAchouRisco := .T.
				nRecOld := recno()

			ElseIf (cTRBTN0)->DT_DE > dtstart .And. (cTRBTN0)->DT_ATE < dtstop
				RecLock( cTRBTN0, .F. )
					(cTRBTN0)->DT_DE := dtstart
					(cTRBTN0)->DT_ATE := dtstop
				MsUnlock()
				aAreaTRB := (cTRBTN0)->(GetArea())

				If nRecOld != nil
					dbSelectArea( cTRBTN0 )
					dbGoTo( nRecOld )
					(cTRBTN0)->(dbDelete())
				EndIf

				RestArea( aAreaTRB )
				lAchouRisco := .T.
				nRecOld := Recno()
			EndIf

			dbSkip()
		End

		If !lAchouRisco
			lSave := .T.
		EndIf

	EndIf

	If lSave

		// Procura pela sigla da Unidade de Medida (TN0 / V3F)
		dbSelectArea( "V3F" )
		dbSetOrder( 2 ) // V3F_FILIAL + V3F_CODIGO + DTOS(V3F_VALIDA)
		dbSeek( xFilial( "V3F" ) + TN0->TN0_UNIMED )
		cUnidade := AllTrim( SubStr( V3F->V3F_DESCRI, At( "-", V3F->V3F_DESCRI ) + 1, Len( V3F->V3F_DESCRI ) ) ) // Eliminacao do codigo na descricao

		// Percorre todas as letras da palavra de tras pra frente a partir do ultimo ")"
		For nAtual := RAt( ")", cUnidade ) To 1 Step -1

			If SubStr( cUnidade, nAtual, 1 ) == ")"
				nTotalFch++
			EndIf

			If SubStr( cUnidade, nAtual, 1 ) == "("
				nTotalAbr++

				If nTotalAbr == nTotalFch // Quando encontrar a sigla completa
					cUnidade := SubStr( cUnidade, nAtual + 1, (RAt( ")", cUnidade ) - 1 ) - (nAtual) )
					Exit
				EndIf

			EndIf

		Next

		dbSelectArea( cTRBTN0 )
		(cTRBTN0)->(dbAppend())
		(cTRBTN0)->NUMRIS := TN0->TN0_NUMRIS
		(cTRBTN0)->CODAGE := TN0->TN0_AGENTE

		If !Empty( TMA->TMA_SUBATI ) .And. TMA->TMA_GRISCO == "2"
			(cTRBTN0)->AGENTE := Substr( TMA->TMA_SUBATI, 1, 40 )
		Else
			(cTRBTN0)->AGENTE := TMA->TMA_NOMAGE
		EndIf

		(cTRBTN0)->GRISCO := TMA->TMA_GRISCO
		(cTRBTN0)->NUMCAP := _cNUMCAP
		(cTRBTN0)->MAT    := cMatric
		(cTRBTN0)->DT_DE  := dInicioRis
		(cTRBTN0)->DT_ATE := dFimRis
		(cTRBTN0)->SETOR  := _centrCusto
		(cTRBTN0)->DEPTO  := _cDepto
		(cTRBTN0)->FUNCAO := _cFuncc
		(cTRBTN0)->TAREFA := _cTarefa
		(cTRBTN0)->INTENS := TN0->TN0_QTAGEN   //Transform(TN0->TN0_QTAGEN,cQTAGtra)
		(cTRBTN0)->UNIDAD := IIf( !Empty( cUnidade ), cUnidade, TN0->TN0_UNIMED )
		(cTRBTN0)->TECNIC := Substr( cTECNICA, 1, 40 )
		(cTRBTN0)->PROTEC := lEpiFunc
		(cTRBTN0)->EPC    := lEpcFunc
		(cTRBTN0)->INDEXP := cEXPOSICAO
		(cTRBTN0)->ATIVO  := "S"

		If TN0->(FieldPos( "TN0_OBSINT" )) > 0//Campo especifico
			(cTRBTN0)->OBSINT := TN0->TN0_OBSINT
		EndIf

		(cTRBTN0)->CODEPI := _cCodEpi
		(cTRBTN0)->AVALIA := TMA->TMA_AVALIA
		(cTRBTN0)->MEDCON := TN0->TN0_MEDCON
		( cTRBTN0 )->TIPCTR := fVlMedCon( cFilRis )
		(cTRBTN0)->NECEPI := TN0->TN0_NECEPI
		(cTRBTN0)->PRZTNF := cPrazoTNF
		(cTRBTN0)->PRZDUR := cPrazoDur
		(cTRBTN0)->HIGIEN := cHigiene


		// Verifica se existe algum EPI necessário
		dbSelectArea( "TNX" )
		dbSetOrder( 2 ) // TNX_FILIAL+TNX_NUMRIS

		If dbSeek( xFilial( "TNX", cXFilTNX )+(cTRBTN0)->NUMRIS )
			lEpiNec := .T.
		EndIf

		dbSelectArea( "TJF" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "TJF", cXFilTJF ) + (cTRBTN0)->NUMRIS )
		While TJF->( !Eof() ) .And. TJF->TJF_FILIAL == xFilial( "TJF", cXFilTJF ) .And. TJF->TJF_NUMRIS == (cTRBTN0)->NUMRIS

			If NgSeek( "TO4", TJF->TJF_MEDCON, 1, "TO4_TIPCTR", cXFilTO4 ) == "2" .Or. NgSeek( "TO4", TJF->TJF_MEDCON, 1, "TO4_TIPCTR", cXFilTO4 ) == "1" 
				lEpcNec := .T.
				Exit
			EndIf

			TJF->( dbSkip() )
		End

		If xm_par29 == 2 // Somente quem gerou o laudo para o risco
			aRespLaudo := {}
			dbSelectArea( "TO1" )
			dbSetOrder( 2 ) // TO1->TO1_FILIAL+TO1->TO1_NUMRIS+TO1->TO1_LAUDO
			dbSeek( xFilial( "TO1" ) + TN0->TN0_NUMRIS )

			While !Eof() .And. xFilial( "TO1" ) == TO1->TO1_FILIAL .And. TN0->TN0_NUMRIS == TO1->TO1_NUMRIS//Laudos X Risco
				dbSelectArea( "TO0" )
				dbSetOrder( 1 )
				dbSeek( xFilial( "TO0" ) + TO1->TO1_LAUDO )

				If aScan( aRespLaudo, { | x | x == TO0->TO0_CODUSU } ) == 0 // Se o código for diferente add no array
					aAdd( aRespLaudo, TO0->TO0_CODUSU )
				EndIf

				dbSelectArea( "TO1" )
				dbSkip()
			End

		EndIf

	EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} ATIV700R

Imprime a descricao das Atividades

@author Denis Hyroshi de Souza
@since 04/04/03
/*/
//---------------------------------------------------------------------
User Function ATIV700R()

	Private cCodCustoCar := ""
	Private lCusto := .F.

	If xm_par08 == 1 //Desc. das Atividad.? //"Tarefa"

		If !U_IMPTAR700()

			If U_IMPCGO700()
				Return .T.
			EndIf

		Else
			Return .T.
		EndIf

	ElseIf xm_par08 == 2 //Desc. das Atividad.?//"Cargo"

		If !U_IMPCGO700()

			If U_IMPTAR700()
				Return .T.
			EndIf

		Else
			Return .T.
		EndIf

	ElseIf xm_par08 == 4 //Desc. das Atividad.?//"Funcao"

		If !U_IMPFUN700()

			If !U_IMPCGO700()

				If U_IMPTAR700()
					Return .T.
				EndIf

			Else
				Return .T.
			EndIf

		Else
			Return .T.
		EndIf

	Else //"Cargo e Tarefa"

		If U_IMPTAR700()
			U_IMPCGO700()
			Return .T.
		ElseIf U_IMPCGO700()
			Return .T.
		EndIf

	EndIf

Return .F.

//-------------------------------------------------------------------
/*/{Protheus.doc} IMPTAR700

Executa a impressao da secao de tarefas

@author  Denis Hyroshi de Souza
@since   04/04/03

@return  return, return_type, return_descr
/*/
//-------------------------------------------------------------------
User Function IMPTAR700()
	Local aTarFunc := {}
	Local aImpDesc	:= {}
	Local aDatasPPP := {}
	Local lRetorno := .F.
	Local cModoTN5
	Local cModoTN6
	Local cFilTN5
	Local cFilTN6
	Local lDescriTN5:= "!Empty(TN5->TN5_DESCRI)"
	Local nTar
	Local nTary
	Local nDesc
	Local LinhaCorrente

	nLinTar := 3

	For nTar := 1 to Len( aMatriculas )

		If lMudEmpr .And. aMatriculas[nTar, 3] != cEmpPPP
			cModo := FWModeAccess( "TN6" )
			U_EMP700OPEN( "TN6", "TN6", 1, aMatriculas[nTar, 3], @cModo, aMatriculas[nTar, 1] )
			cModo := FWModeAccess( "TN5" )
			U_EMP700OPEN( "TN5", "TN5", 1, aMatriculas[nTar, 3], @cModo, aMatriculas[nTar, 1] )
		EndIf

		cModoTN5 := f700RetCom( "TN5" )
		cModoTN6 := f700RetCom( "TN6" )

		cFilTN5 := FwxFilial( "TN5", aMatriculas[nTar, 1], Substr( cModoTN5, 1, 1 ), Substr( cModoTN5, 2, 1 ), Substr( cModoTN5, 3, 1 ) )
		cFilTN6 := FwxFilial( "TN6", aMatriculas[nTar, 1], Substr( cModoTN6, 1, 1 ), Substr( cModoTN6, 2, 1 ), Substr( cModoTN6, 3, 1 ) )

		dbSelectArea( "TN6" )
		dbSetOrder( 2 )// TN6_FILIAL+TN6_MAT
		dbSeek( cFilTN6+aMatriculas[nTar, 2] )

		While !Eof() .And. cFilTN6 == TN6->TN6_FILIAL .And. aMatriculas[nTar, 2] == TN6->TN6_MAT

			If TN6->TN6_DTINIC > dDataBase .Or. (TN6->TN6_DTTERM < dDtAdmiss  .And. !Empty( TN6->TN6_DTTERM ))
				dbSelectArea( "TN6" )
				dbSkip()
				Loop
			EndIf

			dbSelectArea( "TN5" )
			dbSetOrder( 1 )

			If dbSeek( cFilTN5+TN6->TN6_CODTAR )

				If &lDescriTN5
					_dDTfim    := TN6->TN6_DTTERM
					_dDTinicio := TN6->TN6_DTINIC

					If TN6->TN6_DTINIC < dDtAdmiss
						_dDTinicio := dDtAdmiss
					EndIf

					If TN6->TN6_DTTERM > dDataBase
						_dDTfim := dDataBase
					EndIf

					aAdd( aTarFunc, { SubStr( TN5->TN5_NOMTAR, 1, 40 ), TN6->TN6_CODTAR, aMatriculas[nTar, 1], _dDTinicio, _dDTfim, aMatriculas[nTar, 3] } )
				EndIf

			EndIf

			dbSelectArea( "TN6" )
			dbSkip()
		End

		If lMudEmpr .And. aMatriculas[nTar, 3] != cEmpPPP
			U_EMP700OPEN( "TN6", "TN6", 1, cEmpPPP, @cModo )
			U_EMP700OPEN( "TN5", "TN5", 1, cEmpPPP, @cModo )
		EndIf

	Next nTar

	// Ordenando tarefas por ordem cronologica
	For nTar := 1 to Len( aTarFunc )-1

		For nTary := nTar+1 To Len( aTarFunc )

			If aTarFunc[nTar, 4] > aTarFunc[nTary, 4]
				aTemp           := aClone( aTarFunc[nTar] )
				aTarFunc[nTar]  := aClone( aTarFunc[nTary] )
				aTarFunc[nTary] := aClone( aTemp )
			EndIf

		Next nTary

	Next nTar

	// Se existir no dicionario TN5_DESCRI, imprimira o campo memo
	aAdd( aImpDesc, { 'TN5_DESCRI' } )

	For nTar := 1 to Len( aTarFunc )

		If lMudEmpr .And. aTarFunc[nTar, 6] != cEmpPPP
			cModo := FWModeAccess( "TN5" )
			U_EMP700OPEN( "TN5", "TN5", 1, aTarFunc[nTar, 6], @cModo, aTarFunc[nTar, 3] )
		EndIf

		cModoTN5 := f700RetCom( "TN5" )
		cFilTN5 := FwxFilial( "SQ3", aTarFunc[nTar, 3], Substr( cModoTN5, 1, 1 ), Substr( cModoTN5, 2, 1 ), Substr( cModoTN5, 3, 1 ) )

		dbSelectArea( "TN5" )
		dbSetOrder( 1 )

		If !dbSeek( cFilTN5+aTarFunc[nTar, 2] )

			If lMudEmpr .And. aTarFunc[nTar, 6] != cEmpPPP
				U_EMP700OPEN( "TN5", "TN5", 1, cEmpPPP, @cModo )
			EndIf

			Loop
		EndIf

		aDatasPPP := fDesagData( aTarFunc[nTar, 4], IIf( Empty( aTarFunc[nTar, 5] ), dDtDemiss, aTarFunc[nTar, 5] ) )
		lTemDesc := .F.

		For nTary := 1 To Len( aDatasPPP )

			For nDesc := 1 To Len( aImpDesc[1] )
				nLinhasMemo := MlCount( TN5->&(aImpDesc[1][nDesc]), 140 )

				For LinhaCorrente := 1 To nLinhasMemo

					If nDesc == 1 .And. LinhaCorrente == 1
						lTemDesc := .T.
						oPrintPPP:Line( lin, 50, lin + 50, 50 )
						oPrintPPP:Say( lin + 30, 60, aDatasPPP[nTary], oFont09 )
						oPrintPPP:Line( lin, 550, lin + 50, 550 )

						If xm_par33 == 1 // Titulo da tarefa
							oPrintPPP:Say( lin + 30, 560, SubStr( TN5->TN5_NOMTAR, 1, 40 ), oFont08 )
							oPrintPPP:Line( lin, 2940, lin + 50, 2940 )
							SomaLinha( 50, .T. )
						EndIf

					EndIf

					If nDesc > 1 .And. !lTemDesc
						Exit
					EndIf

					If !Empty( MemoLine( TN5->&( aImpDesc[1][nDesc]), 140, LinhaCorrente ) )
						lRetorno := .T.
						oPrintPPP:Line( lin, 50, lin + 40, 50 )
						oPrintPPP:Line( lin, 550, lin + 40, 550 )
						oPrintPPP:Line( lin, 2940, lin + 40, 2940 )
						oPrintPPP:Say( lin + 30, 560, Transform( MemoLine( TN5->&(aImpDesc[1][nDesc] ), 140, LinhaCorrente ), "@!" ), oFont07_ )
						SomaLinha( 40, .T. )
					EndIf

				Next LinhaCorrente

			Next nDesc

			If lRetorno .And. lin != 380
				oPrintPPP:Line( lin, 50, lin, 2940 )
			EndIf

		Next nTary

		If lMudEmpr .And. aTarFunc[nTar, 6] != cEmpPPP
			U_EMP700OPEN( "TN5", "TN5", 1, cEmpPPP, @cModo )
		EndIf

	Next nTar

Return lRetorno

//-------------------------------------------------------------------
/*/{Protheus.doc} IMPCGO700

Executa a impressao da secao de cargos

@author  Denis Hyroshi de Souza
@since   04/04/03

@return  Logico, .T. se houve a impressao de algum cargo
/*/
//-------------------------------------------------------------------
User Function IMPCGO700()

	Local LinhaCorrente
	Local nFx
	Local nX
	Local lRetorno := .F.
	Local lFirst := .T.
	Local dIniCar
	Local dFimCar
	Local cFilialCar
	Local dDataIni
	Local dDataFim
	Local aDatasPPP := {}
	Local cModoSQ3
	Local cFilSQ3

	dbSelectArea( cTRBPPP )
	dbGoTop()

	While !Eof()

		Store CtoD( "  /  /    " ) to dIniCar, dFimCar
		cCodCargo := (cTRBPPP)->CARGO
		cEmpCargo := (cTRBPPP)->EMP
		cFilialCar:= Substr( (cTRBPPP)->FILIAL, 1, FwSizeFilial( (cTRBPPP)->EMP ) )

		If lMudEmpr .And. (cTRBPPP)->EMP != cEmpPPP
			cModo := FWModeAccess( "SQ3" )
			U_EMP700OPEN( "SQ3", "SQ3", 1, (cTRBPPP)->EMP, @cModo, cFilialCar )
		EndIf

		cModoSQ3 := f700RetCom( "SQ3" )
		cFilCargo := FwxFilial( "SQ3", cFilialCar, Substr( cModoSQ3, 1, 1 ), Substr( cModoSQ3, 2, 1 ), Substr( cModoSQ3, 3, 1 ) )

		If lMudEmpr .And. (cTRBPPP)->EMP != cEmpPPP
			U_EMP700OPEN( "SQ3", "SQ3", 1, cEmpPPP, @cModo )
		EndIf

		cCusCargo := U_CARGOCC700( (cTRBPPP)->EMP, cFilialCar, (cTRBPPP)->CARGO, (cTRBPPP)->CUSTO )
		lFirst := .T.

		While !Eof() .And. cCusCargo == U_CARGOCC700( (cTRBPPP)->EMP, cFilialCar, (cTRBPPP)->CARGO, (cTRBPPP)->CUSTO )

			If lFirst
				dIniCar := (cTRBPPP)->DTDE
				dFimCar := (cTRBPPP)->DTATE
				lFirst  := .F.
			Else

				If dFimCar < (cTRBPPP)->DTATE
					dFimCar := (cTRBPPP)->DTATE
				EndIf

			EndIf

			dbSelectArea( cTRBPPP )
			dbSkip()
		End

		aAdd( aCargo, { dIniCar, dFimCar, cFilCargo, cCodCargo, cCusCargo, cEmpCargo, cCodCustoCar } )
		lCusto := .F.
	End

	For nFx := 1 To Len( aCargo )

		If lMudEmpr .And. aCargo[nFx, 6] != cEmpPPP
			cModo := FWModeAccess( "SQ3" )
			U_EMP700OPEN( "SQ3", "SQ3", 1, aCargo[nFx, 6], @cModo, aCargo[nFx][3] )
			cModo := FWModeAccess( "SYP" )
			U_EMP700OPEN( "SYP", "SYP", 1, aCargo[nFx, 6], @cModo, aCargo[nFx][3] )
		EndIf

		cModoSQ3 := f700RetCom( "SQ3" )
		cFilSQ3 := FwxFilial( "SQ3", aCargo[nFx][3], Substr( cModoSQ3, 1, 1 ), Substr( cModoSQ3, 2, 1 ), Substr( cModoSQ3, 3, 1 ) )

		dbSelectArea( "SQ3" )
		dbSetOrder( 1 )

		If dbSeek( cFilSQ3+aCargo[nFx][4]+aCargo[nFx][7] )

			dDataIni := aCargo[nFx][1]

			If aCargo[nFx][1] == aCargo[nFx][2]
				dDataFim := aCargo[nFx][2]
			Else
				dDataFim := aCargo[nFx][2] - 1
			EndIf

			If !fVerAte()
				dDataFim := IIf( nFx == Len( aCargo ), IIf( !lDemitido, CToD( '//' ), aCargo[ nFx, 2 ] ), dDataFim )
			Else
				dDataFim := aCargo[ nFx, 2 ]
			EndIf

			aDatasPPP := fDesagData( dDataIni, dDataFim )
			cMemo := MSMM( SQ3->Q3_DESCDET, , , , , , , , , "RDY" )
			nLinhasMemo := IIf( Empty( cMemo ), 1, MLCOUNT( cMemo, 100 ) )

			If lNG2M400
				nLinhasMemo := IIf( nLinhasMemo > 5, 5, nLinhasMemo )
			EndIf

			For nX := 1 To Len( aDatasPPP )

				For linhaCorrente := 1 To nLinhasMemo
					lRetorno := .T.

					If linhaCorrente == 1
						oPrintPPP:Line( lin, 50, lin + 50, 50 )
						oPrintPPP:Say( lin + 30, 60, aDatasPPP[ nX ], oFont09 )
						oPrintPPP:Line( lin, 550, lin + 50, 550 )

						If xm_par33 == 1 // Titulo do cargo
							oPrintPPP:Say( lin + 30, 560, Transform( SQ3->Q3_DESCSUM, "@!" ), oFont08 )
							oPrintPPP:Line( lin, 2940, lin + 50, 2940 )
							SomaLinha( 50, .T. )
						EndIf

					EndIf

					oPrintPPP:Line( lin, 50, lin + 40, 50 )
					oPrintPPP:Line( lin, 550, lin + 40, 550 )
					oPrintPPP:Line( lin, 2940, lin + 40, 2940 )
					oPrintPPP:Say( lin + 30, 560, SubStr( Transform( MemoLine( cMemo, 140, LinhaCorrente ), "@!" ), 1, 999 ), oFont07_ )

					If LinhaCorrente == nLinhasMemo
						oPrintPPP:Line( lin + 40, 50, lin + 40, 2940 )
					EndIf

					SomaLinha( 40, linhaCorrente != nLinhasMemo )

				Next LinhaCorrente

			Next nX

		EndIf

		If lMudEmpr .And. aCargo[nFx, 6] != cEmpPPP
			U_EMP700OPEN( "SQ3", "SQ3", 1, cEmpPPP, @cModo )
			U_EMP700OPEN( "SYP", "SYP", 1, cEmpPPP, @cModo )
		EndIf

	Next nFx

Return lRetorno

//-------------------------------------------------------------------
/*/{Protheus.doc} CARGOCC700

Retorna a descricao de um cargo na SQ3

@author  Denis Hyroshi de Souza
@since   04/04/03

@sample  U_CARGOCC700((cTRBPPP)->EMP,cFilialCar,(cTRBPPP)->CARGO,(cTRBPPP)->CUSTO)

@param   cEmpresa, Caracter, Codigo da empresa para abrir o arquivo pela EmpOpenFile
@param   cFilPar, Caracter, Filial usada para a busca do cargo
@param   cCargo, Caracter, Codigo do cargo
@param   cCusto, Caracter, Centro de custo usado para a busca do cargo

@return  Caracter, Descricao do cargo pesquisado
/*/
//-------------------------------------------------------------------
User Function CARGOCC700(cEmpresa, cFilPar, cCargo, cCusto)

	Local cRet := Space( nSizeSI3 )
	Local aAreaTRBE := (cTRBPPP)->(GetArea())
	Local aArea     := GetArea()
	Local aIndex    := {}
	Local lTemQ3CC  := .F.
	Local cModoSQ3, cFilSQ3
	Local cChave    := ""

	lFlagEmp1 := .F.

	If lMudEmpr .And. cEmpresa != cEmpPPP
		lFlagEmp1 := .T.
		cModo := FwModeAccess( "SQ3" )
		U_EMP700OPEN( "SQ3", "SQ3", 1, cEmpresa, @cModo, cFilPar )
		cModo := FWModeAccess( "SYP" )
		U_EMP700OPEN( "SYP", "SYP", 1, cEmpresa, @cModo, cFilPar )
	EndIf

	cModoSQ3 := f700RetCom( "SQ3" )
	cFilSQ3  := FwxFilial( "SQ3", cFilPar, Substr( cModoSQ3, 1, 1 ), Substr( cModoSQ3, 2, 1 ), Substr( cModoSQ3, 3, 1 ) )

	aIndex := NGRETINDTAB( "SQ3" )

	If Len( aIndex ) > 0

		cChave := aIndex[ 1 ]

		If "Q3_CARGO" $ cChave .And. "Q3_CC" $ cChave
			dbselectArea( "SQ3" )
			dbSetOrder( 1 )

			If dbSeek( cFilSQ3 + cCargo + cCusto )
				cRet := cCusto + Alltrim( SQ3->Q3_DESCSUM )+Substr( Alltrim( MSMM( SQ3->Q3_DESCDET, , , , , , , , , "RDY" ) ), 1, 100 )

				If !lCusto
					cCodCustoCar := SQ3->Q3_CC
					lCusto := .T.
				EndIf

				lTemQ3CC := .T.
			EndIf

		EndIf

	EndIf

	If !lTemQ3CC
		dbSelectArea( "SQ3" )
		dbSetOrder( 1 )

		If dbSeek( cFilSQ3+cCargo )
			cRet += Alltrim( SQ3->Q3_DESCSUM ) + Substr( Alltrim( MSMM( SQ3->Q3_DESCDET, , , , , , , , , "RDY" ) ), 1, 100 )

			If !lCusto
				cCodCustoCar := SQ3->Q3_CC
				lCusto := .T.
			EndIf

		EndIf

	EndIf

	If lFlagEmp1
		U_EMP700OPEN( "SQ3", "SQ3", 1, cEmpPPP, @cModo )
		U_EMP700OPEN( "SYP", "SYP", 1, cEmpPPP, @cModo )
	EndIf

	RestArea( aAreaTRBE )
	RestArea( aArea )

Return cRet

//-------------------------------------------------------------------
/*/{Protheus.doc} IMPFUN700

Faz a impressao das funcoes dos funcionarios

@author  Denis Hyroshi de Souza
@since   04/04/03

@return  Logico, return_descr
/*/
//-------------------------------------------------------------------
User Function IMPFUN700()

	Local lRetorno := .T.
	Local lFirst := .T.
	Local lPerOk := .T.
	Local dIniFun
	Local dFimFun
	Local LinhaCorrente
	Local nFx
	Local nX
	Local dDateAte
	Local cFilialFun
	Local cModoCom := ""
	Local cMemo := ""
	Local cFilBkp := ""
	Local aDatasPPP := {}
	Local cFilFuncao := ""
	Local cEmpFuncao := ""
	Local cCodFuncao := ""
	Local cCodCC     := ""
	Local cCodDepto  := ""
	Local oFontPrint := oFont07_

	dbSelectArea( cTRBPPP )
	dbGoTop()

	While (cTRBPPP)->(!Eof())
		lFlagEmp1 := .F.
		cFilialFun := Substr( (cTRBPPP)->FILIAL, 1, FwSizeFilial( (cTRBPPP)->EMP ) )

		If lMudEmpr .And. (cTRBPPP)->EMP != cEmpPPP
			lFlagEmp1 := .T.
			cModo := FWModeAccess( "SRJ" )
			U_EMP700OPEN( "SRJ", "SRJ", 1, (cTRBPPP)->EMP, @cModo, cFilialFun )
			cModo := FWModeAccess( "SYP" )
			U_EMP700OPEN( "SYP", "SYP", 1, (cTRBPPP)->EMP, @cModo, cFilialFun )
			cModo := FWModeAccess( "RDY" )
			U_EMP700OPEN( "RDY", "RDY", 1, (cTRBPPP)->EMP, @cModo, cFilialFun )

			If AliasInDic( "TYA" )
				cModo := FWModeAccess( "TYA" )
				U_EMP700OPEN( "TYA", "TYA", 1, (cTRBPPP)->EMP, @cModo, cFilialFun )
			EndIf

		EndIf

		cModoCom := f700RetCom( "SRJ" )

		// Realizado a troca da Variavel cFilAnt
		// pois estava vindo posicionada sempre na ultima filial
		// assim não encontrava os valores de memo, com essa alteração
		// a filial posicionada sempre será a atual da TRB.
		If cFilAnt <> (cTRBPPP)->FILIAL
			cFilBkp := cFilAnt
			cFilAnt := (cTRBPPP)->FILIAL
		EndIf

		dbSelectArea( "SRJ" )
		Store CtoD( "  /  /    " ) To dIniFun, dFimFun
		cCodCC	   := (cTRBPPP)->CUSTO
		cCodDepto  := (cTRBPPP)->DEPTO
		cCodFuncao := (cTRBPPP)->CODFUN
		cFilFuncao := FwxFilial( "SRJ", cFilialFun, Substr( cModoCom, 1, 1 ), Substr( cModoCom, 2, 1 ), Substr( cModoCom, 3, 1 ) )
		cEmpFuncao := (cTRBPPP)->EMP
		lFirst := .T.

		While (cTRBPPP)->(!Eof()) .And. cCodFuncao == (cTRBPPP)->CODFUN .And. cEmpFuncao == (cTRBPPP)->EMP .And. ;
					FwxFilial( "SRJ", (cTRBPPP)->FILIAL, Substr( cModoCom, 1, 1 ), Substr( cModoCom, 2, 1 ), Substr( cModoCom, 3, 1 ) ) ==;
					FwxFilial( "SRJ", cFilialFun, Substr( cModoCom, 1, 1 ), Substr( cModoCom, 2, 1 ), Substr( cModoCom, 3, 1 ) )
			If lFirst
				dIniFun := (cTRBPPP)->DTDE
				dFimFun := (cTRBPPP)->DTATE
				lFirst  := .F.
			Else
				If dFimFun < (cTRBPPP)->DTATE
					dFimFun := (cTRBPPP)->DTATE
				EndIf
			EndIf

			dbSelectArea( cTRBPPP )
			(cTRBPPP)->(Dbskip())
		End

		// Responsavel por buscar o valor do campo MEMO
		dbSelectArea( "SRJ" )
		dbSetOrder( 1 )
		dbSeek( cFilFuncao + cCodFuncao )

		If SRJ->(FieldPos( "RJ_MEMOATI" )) > 0
			cMemo := SRJ->RJ_MEMOATI
		Else
			cMemo := MSMM( SRJ->RJ_DESCREQ, , , , , , , , , "RDY" )
		EndIf

		If AliasInDic( "TYA" )
			dbSelectArea( "TYA" )
			dbSetOrder( 1 )

			If dbSeek( cFilFuncao + cCodFuncao )

				While TYA->( !EoF() ) .And. TYA->TYA_FILIAL == cFilFuncao .And. ;
					TYA->TYA_CODFUN == cCodFuncao .And. TYA->TYA_PERINI <= dFimFun //Caso tenha um periodo de função menor que o inicio da função.
					lPerOk := .T.

					If TYA->( ColumnPos( "TYA_CC" ) ) > 0

						If ( !Empty( TYA->TYA_CC ) .And. Alltrim( TYA->TYA_CC ) <> Alltrim( cCodCC ) ) .Or. ;
							( !Empty( TYA->TYA_DEPTO ) .And. Alltrim( TYA->TYA_DEPTO ) <> Alltrim( cCodDepto ) )
							lPerOk := .F.
						EndIf

					EndIf

					If lPerOk

						If TYA->TYA_PERINI > dIniFun
							aAdd( aFuncao, { dIniFun, DaySub( TYA->TYA_PERINI, 1 ), cFilFuncao, cCodFuncao, cEmpFuncao, cMemo } )
							dIniFun := TYA->TYA_PERINI
							cMemo := MSMM( TYA->TYA_ODESFU, TAMSX3( "TYA_MDESFU" )[1] )
						Else
							cMemo := MSMM( TYA->TYA_ODESFU, TAMSX3( "TYA_MDESFU" )[1] )
						EndIf

					EndIf

					TYA->(dbSkip())
				End

			EndIf

		EndIf

		aAdd( aFuncao, { dIniFun, dFimFun, cFilFuncao, cCodFuncao, cEmpFuncao, cMemo } )

		// Caso ocorreu alteração do cFilAnt retorna o valor do backup.
		If cFilAnt <> cFilBkp .And. !Empty( cFilBkp )
			cFilAnt := cFilBkp
		EndIf

		If lFlagEmp1
			U_EMP700OPEN( "SRJ", "SRJ", 1, cEmpPPP, @cModo )
			U_EMP700OPEN( "SYP", "SYP", 1, cEmpPPP, @cModo )
			U_EMP700OPEN( "RDY", "RDY", 1, cEmpPPP, @cModo )

			If AliasInDic( "TYA" )
				U_EMP700OPEN( "TYA", "TYA", 1, cEmpPPP, @cModo )
			EndIf

		EndIf

	End

	For nFx := 1 to Len( aFuncao )

		If lMudEmpr .And. aFuncao[nFx, 5] != cEmpPPP
			cModo := FWModeAccess( "SRJ" )
			U_EMP700OPEN( "SRJ", "SRJ", 1, aFuncao[nFx, 5], @cModo, aFuncao[nFx][3] )
			cModo := FWModeAccess( "SYP" )
			U_EMP700OPEN( "SYP", "SYP", 1, aFuncao[nFx, 5], @cModo, aFuncao[nFx][3] )

			If AliasInDic( "TYA" )
				cModo := FWModeAccess( "TYA" )
				U_EMP700OPEN( "TYA", "TYA", 1, aFuncao[nFx, 5], @cModo, aFuncao[nFx][3] )
			EndIf

		EndIf

		cModoCom := f700RetCom( "SRJ" )
		dbSelectArea( "SRJ" )
		dbSetOrder( 1 )

		If dbSeek( FwxFilial( "SRJ", aFuncao[nFx][3], Substr( cModoCom, 1, 1 ), Substr( cModoCom, 2, 1 ), Substr( cModoCom, 3, 1 ) )+aFuncao[nFx][4] )

			If Len( aFuncao ) > nFx
				dDateAte :=  aFuncao[nFx + 1 ][1] - 1
			Else
				dDateAte := aFuncao[nFx][2]
			EndIf

			If !fVerAte()
				dDateAte := IIf( nFx == Len( aFuncao ), IIf( !lDemitido, CToD( '//' ), aFuncao[ nFx, 2 ] ), dDateAte )
			Else
				dDateAte := aFuncao[ nFx, 2 ]
			EndIf

			aDatasPPP := fDesagData( aFuncao[nFx][1], dDateAte )
			cMemo := aFuncao[nFx, 6]

			nLinhasMemo := MLCOUNT( cMemo, 140 )

			If lNG2M400
				nLinhasMemo := IIf( nLinhasMemo > 5, 5, nLinhasMemo )
			EndIf

			For nX := 1 To Len( aDatasPPP )

				For LinhaCorrente := 1 To nLinhasMemo
					lRetorno := .T.

					If LinhaCorrente == 1
						oPrintPPP:Line( lin, 50, lin + 45, 50 )
						oPrintPPP:Say( lin + 30, 60, aDatasPPP[ nX ], oFont09 )
						oPrintPPP:Line( lin, 550, lin + 45, 550 )

						If xm_par33 == 1
							oPrintPPP:Say( lin + 30, 560, Transform( SRJ->RJ_DESC, "@!" ), oFont08 )
							oPrintPPP:Line( lin, 2940, lin + 45, 2940 )
							oFontPrint := oFont08
							SomaLinha( 45 )
						EndIf

					Else
						oFontPrint := oFont07_
					EndIf

					oPrintPPP:Line( lin, 50, lin + 45, 50 )
					oPrintPPP:Line( lin, 550, lin + 45, 550 )
					oPrintPPP:Line( lin, 2940, lin + 45, 2940 )
					oPrintPPP:Say( lin + 30, 560, Transform( MemoLine( cMemo, 140, LinhaCorrente ), "@!" ), oFontPrint )

					If LinhaCorrente == nLinhasMemo
						oPrintPPP:Line( lin + 45, 50, lin + 45, 2940 )
					EndIf

					SomaLinha( 45, LinhaCorrente != nLinhasMemo )
				Next LinhaCorrente

			Next nX

		EndIf

		If lMudEmpr .And. aFuncao[nFx, 5] != cEmpPPP
			U_EMP700OPEN( "SRJ", "SRJ", 1, cEmpPPP, @cModo )
			U_EMP700OPEN( "SYP", "SYP", 1, cEmpPPP, @cModo )

			If AliasInDic( "TYA" )
				U_EMP700OPEN( "TYA", "TYA", 1, cEmpPPP, @cModo )
			EndIf

		EndIf

	Next nFx

Return lRetorno

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTERMO700

Executa a impressao da secao de Comprovante de entrega

@author  Denis Hyroshi de Souza
@since   04/04/03

@return  Logico, Sempre .T.
/*/
//-------------------------------------------------------------------
User Function MDTERMO700()

	Local cCNPJ

	dbSelectArea( "TM0" )
	dbSetOrder( 3 )
	dbSeek( xFilial( "SRA" ) + SRA->RA_MAT )

	dbSelectArea( cAlias )
	dbSetOrder( 1 )
	dbSeek( xFilial( cAlias ) + SRA->RA_CC )

	dbSelectArea( "SRJ" )
	dbSetOrder( 1 )
	dbSeek( xFilial( "SRJ" ) + SRA->RA_CODFUNC )

	dbSelectArea( "SR6" )
	dbSetOrder( 1 )
	dbSeek( xFilial( "SR6" ) + SRA->RA_TNOTRAB )

	oPrintPPP:StartPage()
	lin := 180
	oPrintPPP:SayAlign( lin + 70, 50, STR0238, oFont13, 2160, lin + 100, CLR_BLACK, 2, 1 ) // "COMPROVANTE DE ENTREGA DO PERFIL PROFISSIOGRÁFICO PREVIDENCIÁRIO ( PPP)"
	oPrintPPP:Box( lin + 200, 50, lin + 580, 2940 )
	oPrintPPP:Say( lin + 260, 60, STR0239, oFont13 ) // "DADOS ADMINISTRATIVOS"
	oPrintPPP:Line( lin + 280, 50, lin + 280, 2940 )
	oPrintPPP:Line( lin + 280, 800, lin + 380, 800 )
	oPrintPPP:Line( lin + 280, 2000, lin + 380, 2000 )
	// "CNPJ do Domicílio Tributário/CEI/CAEPF/CNO"
	oPrintPPP:Say( lin + 310, 60, Memoline( STR0240, 41, 1 ), oFont09n )
	oPrintPPP:Say( lin + 340, 60, Memoline( STR0240, 41, 2 ), oFont09n )

	// Ponto de entrada MDTR7003 para CNPJ
	If ExistBlock( "MDTR7003" )
		cCNPJ:= ExecBlock( "MDTR7003", .F., .F. )
	EndIf

	// Caso não teha ponto de entrada
	If ValType( cCNPJ ) <> "C" .Or. Empty( cCNPJ )

		If lNGMDTPS .Or. lSigaMdtps
			cCNPJ:= SA1->A1_CGC
		Else
			cCNPJ:= SM0->M0_CGC
		EndIf

	EndIf

	If !Empty( cCNPJ )

		If SM0->M0_TPINSC != 2
			oPrintPPP:Say( lin + 370, 60, Transform( cCNPJ, "@R 99.999.99999/99" ), oFont10 )
		Else
			oPrintPPP:Say( lin + 370, 60, Transform( cCNPJ, "@!R NN.NNN.NNN/NNNN-99" ), oFont10 )
		EndIf

	EndIf

	oPrintPPP:Say( lin + 310, 810, STR0241, oFont09 ) // "Nome Empresarial"

	If lNGMDTPS .Or. lSigaMdtps
		oPrintPPP:Say( lin + 370, 810, Substr( SA1->A1_NOME, 1, 40 ), oFont10 )
	Else
		oPrintPPP:Say( lin + 370, 810, Substr( SM0->M0_NOMECOM, 1, 40 ), oFont10 )
	EndIf

	oPrintPPP:Say( lin + 310, 2010, "CNAE", oFont09 )

	If lNGMDTPS .Or. lSigaMdtps
		nSizeCNAE := Len( alltrim( SA1->A1_ATIVIDA ) )

		If nSizeCNAE > 5
			oPrintPPP:Say( lin + 370, 2010, Transform( SA1->A1_ATIVIDA, "@R 99.99-9/99" ), oFont10 )
		ElseIf Empty( SA1->A1_ATIVIDA )
			oPrintPPP:Say( lin + 370, 2010, "NA", oFont10 )
		Else
			oPrintPPP:Say( lin + 370, 2010, Transform( SA1->A1_ATIVIDA, "@R 99.99-9" ), oFont10 )
		EndIf

	Else
		nSizeCNAE := Len( AllTrim( SM0->M0_CNAE ) )

		If nSizeCNAE > 5
			oPrintPPP:Say( lin + 370, 2010, Transform( SM0->M0_CNAE, "@R 99.99-9/99" ), oFont10 )
		ElseIf Empty( SA1->A1_ATIVIDA )
			oPrintPPP:Say( lin + 370, 2010, "NA", oFont10 )
		Else
			oPrintPPP:Say( lin + 370, 2010, Transform( SM0->M0_CNAE, "@R 99.99-9" ), oFont10 )
		EndIf

	EndIf

	oPrintPPP:Line( lin + 380, 50, lin + 380, 2940 )
	oPrintPPP:Say( lin + 410, 60, STR0015, oFont09 ) // "Nome do Trabalhador"

	If !Empty(SRA->RA_NOMECMP)
		oPrintPPP:Say( lin + 470, 60, SRA->RA_NOMECMP, oFont10 )
	Else
		oPrintPPP:Say( lin + 470, 60, SRA->RA_NOME, oFont10 )
	EndIf

	oPrintPPP:Line( lin + 380, 1525, lin + 480, 1525 )
	oPrintPPP:Say( lin + 410, 1535, "BR/PDH", oFont09 )
	cBRPDH := "NA"

	If SRA->RA_BRPDH == "1"
		cBRPDH := "BR"
	ElseIf SRA->RA_BRPDH == "2"
		cBRPDH := "PDH"
	EndIf

	oPrintPPP:Say( lin + 470, 1535, cBRPDH, oFont10 )
	oPrintPPP:Line( lin + 380, 1925, lin + 480, 1925 )
	oPrintPPP:Say( lin + 410, 1935, "NIT", oFont09 )

	If !Empty( SRA->RA_PIS )
		oPrintPPP:Say( lin + 470, 1935, Transform( SRA->RA_PIS, "@R 999.99999.99-9" ), oFont10 )
	Else
		oPrintPPP:Say( lin + 470, 1935, "NA", oFont10 )
	EndIf

	oPrintPPP:Line( lin + 480, 50, lin + 480, 2940 )
	oPrintPPP:Line( lin + 480, 500, lin + 580, 500 )
	oPrintPPP:Line( lin + 480, 800, lin + 580, 800 )
	oPrintPPP:Line( lin + 480, 1400, lin + 580, 1400 )
	oPrintPPP:Line( lin + 480, 1800, lin + 580, 1800 )
	oPrintPPP:Say( lin + 510, 60, STR0242, oFont09 ) // "Data do Nascimento"
	oPrintPPP:Say( lin + 570, 60, U_NGPPPDATE( SRA->RA_NASC ), oFont10 )
	oPrintPPP:Say( lin + 510, 510, STR0243, oFont09 ) // "Sexo( F/M )"
	oPrintPPP:Say( lin + 570, 510, Upper( SRA->RA_SEXO ), oFont10 )
	oPrintPPP:Say( lin + 510, 810, STR0244, oFont09 ) // "CTPS( Nº,  Série e UF )"
	oPrintPPP:Say( lin + 570, 810, SRA->RA_NUMCP + "/" + SRA->RA_SERCP + " - " + SRA->RA_UFCP, oFont10 )
	oPrintPPP:Say( lin + 510, 1410, STR0245, oFont09 ) // "Data de Admissão"
	oPrintPPP:Say( lin + 570, 1410, U_NGPPPDATE( SRA->RA_ADMISSA ), oFont10 )
	oPrintPPP:Say( lin + 510, 1810, STR0246, oFont09 ) // "Regime Revezamento"

	If !Empty( Substr( SR6->R6_REVEZAM, 1, 20 ) )
		oPrintPPP:Say( lin + 570, 1810, Substr( SR6->R6_REVEZAM, 1, 20 ), oFont09 )
	Else
		oPrintPPP:Say( lin + 570, 1810, "NA", oFont10 )
	EndIf

	SomaLinha( 580 )
	oPrintPPP:Line( lin, 50, lin + 100, 50 )
	oPrintPPP:Say( lin + 30, 60, STR0247, oFont09 ) // "Matrícula"
	oPrintPPP:Say( lin + 90, 60, SRA->RA_MAT, oFont10 )
	oPrintPPP:Line( lin, 500, lin + 100, 500 )
	oPrintPPP:Say( lin + 30, 510, STR0248, oFont09 ) // "Centro de Custo"
	oPrintPPP:Say( lin + 90, 510, &cDescr, oFont10 )
	oPrintPPP:Line( lin, 1400, lin + 100, 1400 )
	oPrintPPP:Say( lin + 30, 1410, STR0277, oFont09 ) // "Função"

	If !Empty( SRJ->RJ_DESC )
		oPrintPPP:Say( lin + 90, 1410, SRJ->RJ_DESC, oFont10 )
	Else
		oPrintPPP:Say( lin + 90, 1410, "NA", oFont10 )
	EndIf

	oPrintPPP:Line( lin, 2940, lin + 100, 2940 )
	oPrintPPP:Line( lin + 100, 50, lin + 100, 2940 )
	SomaLinha( 100 )

	If !Empty( xm_par11 ) // Termo Responsab. ?
		oPrintPPP:Line( lin, 50, lin + 80, 50 )
		oPrintPPP:Say( lin + 60, 60, STR0250, oFont13 ) // "TERMO DE RESPONSABILIDADE"
		oPrintPPP:Line( lin, 2940, lin + 80, 2940 )
		oPrintPPP:Line( lin + 80, 50, lin + 80, 2940 )
		SomaLinha( 80 )
		dbSelectArea( "TMZ" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "TMZ" ) + xm_par11 ) // Termo Responsab. ?
		fImpMemo( TMZ->TMZ_DESCRI )

		If Empty( TMZ->TMZ_DESCRI )
			oPrintPPP:Line( lin, 50, lin + 90, 50 )
			oPrintPPP:Line( lin, 2940, lin + 90, 2940 )
			oPrintPPP:Line( lin + 90, 50, lin + 90, 2940 )
			SomaLinha( 60 )
		EndIf

		SomaLinha( 30 )
	EndIf

	If lin > 2770
		SomaLinha( , , .T. )
	EndIf

	oPrintPPP:Line( lin, 50, lin + 250, 50 )
	oPrintPPP:Line( lin, 2940, lin + 250, 2940 )
	oPrintPPP:Line( lin + 250, 50, lin + 250, 2940 )
	dDtEmiR  := CTOD( U_NGPPPDATE( IIf( xm_par21==3, xm_par22, IIf( xm_par21==2, dDtDemiss, dDataBase ) ), .T. ) ) //Data Emissao PPP ?//Informe a Data ?
	cDataCid := " "

	If lNGMDTPS .Or. lSigaMdtps
		cDataCid := AllTrim( SA1->A1_MUN ) + ",  " + StrZero( Day( dDtEmiR ), 2 ) + STR0251 + MesExtenso( Month( dDtEmiR ) )
		cDataCid  += STR0251 + Str( Year( dDtEmiR ), 4 )
	Else
		cDataCid := AllTrim( IIf( lParEnd, SM0->M0_CIDCOB, SM0->M0_CIDENT ) ) + ",  " + StrZero( Day( dDtEmiR ), 2 ) + STR0251
		cDataCid  += MesExtenso( Month( dDtEmiR ) ) + " de " + Str( Year( dDtEmiR ), 4 )
	EndIf

	oPrintPPP:Say( lin + 60, 60, cDataCid, oFont09 )

	oPrintPPP:Line( lin + 190, 850, lin + 190, 1550 )
	oPrintPPP:Say( lin + 240, 950, STR0252, oFont08 )

	oPrintPPP:SayAlign( 2200, 50, Str( nPaginaPPP, 3 ), oFont09n, 2940, 280, CLR_BLACK, 2, 1 )
	oPrintPPP:EndPage()
	nPaginaPPP++
Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT640

Retorna a data em formato correto para ser usada no PPP

@author Thiago Machado
@since 03/01/00

@sample U_NGPPPDATE(SRA->RA_NASC)

@param   dDtPPP, Date, Data a ser manipulada
@param   lDtAtual, Logico, Define se será usada a data base do sistema

@return Caracter, Data base ou passada por parametro em formato "99/99/9999"
/*/
//---------------------------------------------------------------------
User Function NGPPPDATE( dDtPPP, lDtAtual )

	Local cRet := ""
	Local cDia := ""
	Local cMes := ""
	Local cAno := ""

	Default lDtAtual := .F.

	If Empty( dDtPPP ) .And. lDtAtual
		dDtPPP := dDataBase
	EndIf

	If Empty( dDtPPP )
		cRet := "__/__/____"
	EndIf

	If Empty( cRet )
		cDia := Strzero( Day( dDtPPP ), 2 )
		cMes := Strzero( Month( dDtPPP ), 2 )
		cAno := Substr( Str( Year( dDtPPP ), 4 ), 1, 4 )

		cRet := cDia + "/" + cMes + "/" + cAno
	EndIf

Return cRet

//-------------------------------------------------------------------
/*/{Protheus.doc} NG700SESMT

Busca usuarios do sesmt para impressao do PPP

@author  Denis Hyroshi de Souza
@since   14/12/03
/*/
//-------------------------------------------------------------------
User Function NG700SESMT()

	Local aArea := SM0->(GetArea())
	Local dDtFim, dDtIni
	Local dDateIni
	Local dDateFim
	Local lEntrou
	Local cModoTMK
	Local cModoTMW
	Local cFilTMK
	Local cFilTMW
	Local cFiltroTRB
	Local cFilSESMT
	Local cTipFun := IIf( xm_par28 == 1, "5", "1" )

	Private cMat
	Private cCodUser
	Private cFilMat

	dbSelectArea( cTRBPPP )
	dbGoTop()

	While ( cTRBPPP )->( !Eof() )

		lFlagEmp1 := .F.

		If lMudEmpr .And. (cTRBPPP)->EMP != cEmpPPP
			lFlagEmp1 := .T.
			cModo := FWModeAccess( "TMK" )
			U_EMP700OPEN( "TMK", "TMK", 1, (cTRBPPP)->EMP, @cModo, Substr( (cTRBPPP)->FILIAL, 1, FwSizeFilial( (cTRBPPP)->EMP ) ) )
			cModo := FWModeAccess( "TMW" )
			U_EMP700OPEN( "TMW", "TMW", 1, (cTRBPPP)->EMP, @cModo, Substr( (cTRBPPP)->FILIAL, 1, FwSizeFilial( (cTRBPPP)->EMP ) ) )
		EndIf

		cModoTMK := f700RetCom( "TMK" )
		cModoTMW := f700RetCom( "TMW" )

		cFilSESMT := Substr( ( cTRBPPP )->FILIAL, 1, FwSizeFilial( ( cTRBPPP )->EMP ) )
		// Altera variaveis para o xFilial
		dbSelectArea( "SM0" )
		dbSeek( ( cTRBPPP )->EMP+cFilSESMT )
		cFilAnt := cFilSESMT

		cFilTMK := FwxFilial( "TMK", cFilSESMT, Substr( cModoTMK, 1, 1 ), Substr( cModoTMK, 2, 1 ), Substr( cModoTMK, 3, 1 ) )
		cFilTMW := FwxFilial( "TMW", cFilSESMT, Substr( cModoTMW, 1, 1 ), Substr( cModoTMW, 2, 1 ), Substr( cModoTMW, 3, 1 ) )

		dbSelectArea( "TMW" )
		dbSetOrder( 1 )
		dbSeek( cFilTMW )

		dbSelectArea( "TMK" )
		dbSetOrder( 1 )
		dbSeek( cFilTMK )

		While ( 'TMK' )->( !Eof() ) .And. cFilTMK == TMK->TMK_FILIAL

			If TMK->TMK_DTINIC >= (cTRBPPP)->DTATE .Or. ( !Empty( TMK->TMK_DTTERM ) .And. TMK->TMK_DTTERM <= (cTRBPPP)->DTDE )
				dbSelectArea( "TMK" )
				dbSkip()
				Loop
			EndIf

			If !Empty( TMK->TMK_CC ) .And. TMK->TMK_CC <> (cTRBPPP)->CUSTO .And. !fVlCCSRE()
				dbSelectArea( "TMK" )
				dbSkip()
				Loop
			EndIf

			If xm_par32 == 1 .And. TMK->TMK_SESMT <> "1" // Se não Compoe SESMT
				dbSelectArea( "TMK" )
				dbSkip()
				Loop
			EndIf

			// Somente quem gerou laudo.
			If xm_par29 == 2 .And. aScan( aRespLaudo, { | x | x == TMK->TMK_CODUSU } ) == 0
				dbSelectArea( "TMK" )
				dbSkip()
				Loop
			EndIf


			If lRespFim
				dDtIni := TMK->TMK_DTINIC
				dDtFim := TMK->TMK_DTTERM
			Else
				dDtIni := (cTRBPPP)->DTDE
				dDtFim := (cTRBPPP)->DTATE

				If TMK->TMK_DTINIC > dDtIni
					dDtIni := TMK->TMK_DTINIC
				EndIf

				If TMK->TMK_DTTERM < dDtFim .And. !Empty( TMK->TMK_DTTERM )
					dDtFim := TMK->TMK_DTTERM
				EndIf

			EndIf

			DbSelectArea( cTRBTMK )
			( cTRBTMK )->( DbSetOrder( 3 ) )

			If !( cTRBTMK )->( DbSeek( TMK->TMK_INDFUN + TMK->TMK_NUMENT + TMK->TMK_NOMUSU ) )

				( cTRBTMK )->( dbAppend() )
				( cTRBTMK )->DTINI  := dDtIni
				( cTRBTMK )->DTFIM  := dDtFim
				( cTRBTMK )->FILIAL := TMK->TMK_FILIAL
				( cTRBTMK )->CODIGO := TMK->TMK_CODUSU
				( cTRBTMK )->NOME   := TMK->TMK_NOMUSU
				( cTRBTMK )->INDFUN := TMK->TMK_INDFUN
				( cTRBTMK )->NIT    := TMK->TMK_NIT
				( cTRBTMK )->REGNUM := TMK->TMK_NUMENT
				( cTRBTMK )->MAT 	:= ( cTRBPPP )->MAT
				( cTRBTMK )->RESAMB := TMK->TMK_RESAMB
				( cTRBTMK )->MONBIO := TMK->TMK_MONBIO
				( cTRBTMK )->CIC    := TMK->TMK_CIC

			EndIf

			( 'TMK' )->( dbSkip() )

		End

		If lFlagEmp1
			U_EMP700OPEN( "TMK", "TMK", 1, cEmpPPP, @cModo )
			U_EMP700OPEN( "TMW", "TMW", 1, cEmpPPP, @cModo )
		EndIf

		( cTRBPPP )->( dbSkip() )

	End

	// Verifica se os usuarios SESMT gravados na tabela cTRBTMK possuem registros reduntantes, rela-
	// cionados 'a matricula do funcionario. Para cada usuario nesta tabela sera'
	// mantido apenas um unico registro, com a menor data inicial e a maior data final do usuario.
	dbSelectArea( cTRBTMK )
	dbSetOrder( 4 ) //MAT + CODIGO + DTOS(DTINI) + DTOS(DTFIM)
	dbGoTop()

	While ( cTRBTMK )->( !Eof() )

		nRecnoTRB := Recno()
		cMat := (cTRBTMK)->MAT
		cCodUser := (cTRBTMK)->CODIGO
		dDateIni := (cTRBTMK)->DTINI
		cFilMat  := (cTRBTMK)->FILIAL
		lEntrou := .F.

		cFiltroTRB := 'cFilMat == (cTRBTMK)->FILIAL .And. cMat == (cTRBTMK)->MAT .And. cCodUser == (cTRBTMK)->CODIGO'
		dbSetFilter( {|| &cFiltroTRB}, cFiltroTRB )
		dbGoBottom()
		dDateFim := (cTRBTMK)->DTFIM
		dbClearFilter()

		dbGoTo( nRecnoTRB )
		Reclock( cTRBTMK, .F. )
			(cTRBTMK)->DTFIM := dDateFim
		MsUnLock()
		dbSkip()

		While !Eof() .And. cFilial + cMat + cCodUser == (cTRBTMK)->FILIAL + (cTRBTMK)->MAT + (cTRBTMK)->CODIGO
			Reclock( cTRBTMK, .F. )
				dbDelete()
			MsUnLock()
			dbSkip()
			lEntrou := .T.
		End

		If !lEntrou
			dbSkip()
		EndIf

	End

	RestArea( aArea )
Return

//-------------------------------------------------------------------
/*/{Protheus.doc} RECLASS_RISCOS

Reclassifica os riscos

@author  Denis Hyroshi de Souza
@since   14/12/03

@return  Nulo, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function RECLASS_RISCOS()
	Local cChave

	// Agrupa riscos que foram separados na mudanca de Filial/Matricula/Setor/Funcao
	dbSelectArea( cTRBTN0 )
	dbSetOrder( 3 )
	dbGoTop()

	While !Eof()

		If (cTRBTN0)->PROTEC != "S "
			dbSelectArea( cTRBTN0 )
			dbSkip()
			Loop
		EndIf

		cChave    := (cTRBTN0)->(GRISCO+AGENTE+Str( INTENS, nQTAGENt, nQTAGENd )+TECNIC)
		dtstart   := (cTRBTN0)->DT_DE
		dtstop    := (cTRBTN0)->DT_ATE
		nRecOld   := Recno()

		dbSelectArea( cTRBTN0 )
		dbSkip()

		While !Eof() .And. cChave == (cTRBTN0)->(GRISCO + AGENTE + Str( INTENS, nQTAGENt, nQTAGENd ) + TECNIC)

			If (cTRBTN0)->PROTEC != "S "
				dbSelectArea( cTRBTN0 )
				dbSkip()
				Loop
			EndIf

			If (cTRBTN0)->DT_DE == dtstop + 1

				RecLock( cTRBTN0, .F. )
					(cTRBTN0)->ATIVO := "N"
				MsUnlock()
				aAreaTRB := (cTRBTN0)->(GetArea())
				dtstop   := (cTRBTN0)->DT_ATE

				dbSelectArea( cTRBTN0 )
				dbGoTo( nRecOld )
				RecLock( cTRBTN0, .F. )
					(cTRBTN0)->DT_ATE := dtstop
				Msunlock()

				RestArea( aAreaTRB )
			EndIf

			dbSkip()
		End

		dbSelectArea( cTRBTN0 )
		dbGoTo( nRecOld )
		dbSkip()
	End

	dbSelectArea( cTRBTN0 )
	dbSetOrder( 2 )
	dbGoTop()

	While !Eof()

		If (cTRBTN0)->ATIVO != "S"
			dbSelectArea( cTRBTN0 )
			dbSkip()
			Loop
		EndIf

		cKeyRisco := (cTRBTN0)->(GRISCO+AGENTE+Str( INTENS, nQTAGENt, nQTAGENd )+TECNIC+EPC+PROTEC+NUMCAP)
		dtstart   := (cTRBTN0)->DT_DE
		dtstop    := (cTRBTN0)->DT_ATE
		nRecOld   := Recno()

		While !Eof() .And. cKeyRisco == (cTRBTN0)->(GRISCO+AGENTE+Str( INTENS, nQTAGENt, nQTAGENd )+TECNIC+EPC+PROTEC+NUMCAP)

			If (cTRBTN0)->ATIVO != "S"
				dbSelectArea( cTRBTN0 )
				dbSkip()
				Loop
			EndIf

			If (cTRBTN0)->DT_DE == dtstop+1
				RecLock( cTRBTN0, .F. )
					(cTRBTN0)->ATIVO := "N"
				MsUnlock()
				aAreaTRB := (cTRBTN0)->(GetArea())
				dtstop   := (cTRBTN0)->DT_ATE

				dbSelectArea( cTRBTN0 )
				dbGoTo( nRecOld )
				RecLock( cTRBTN0, .F. )
					(cTRBTN0)->DT_ATE := dtstop
				Msunlock()

				RestArea( aAreaTRB )
			EndIf

			dbSkip()
		End

		dbSelectArea( cTRBTN0 )
		dbGoTo( nRecOld )
		dbSkip()
	End

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTCBOX

Monta Combo Box para exibir na tela

@author  Denis Hyroshi de Souza
@since   27.11.03

@sample  sample

@param   cCampo, Caracter, Campo que tera o Combo Box anex
@param   cForaCombo, Caracter, String contendo item a nao ser apresentado "56
@param   nLenGrava, Numerico, Tamanho a ser verificado a cada item da string

@return  return, return_type, Array com combo box
/*/
//-------------------------------------------------------------------
User Function PPPMDTCbox( cCampo, cForaCombo, nLenGrava )

	Local aArray1	:= {}
	Local aArray2	:= {}
	Local aSaveArea	:= GetArea()
	Local cVar
	Local nCont

	Default cForaCombo := ""
	Default nLenGrava  := 1

	dbSelectArea( "SX3" )
	dbSetOrder( 2 )
	MsSeek( cCampo )

	cVar := X3CBox()

	If Empty( cVar )
		Return aArray2
	EndIf

	aArray1	:= RetSx3Box( cVar, , , 1 )

	For nCont := 1 To Len( aArray1 )

		If cForaCombo <> "" .And. Left( aArray1[nCont][1], nLenGrava ) $ cForaCombo
			Loop
		EndIf

		aAdd( aArray2, aArray1[nCont][1] )
	Next nCont

	RestArea( aSaveArea )

Return aArray2

//---------------------------------------------------------------------
/*/{Protheus.doc} SX6PPPRES

Verifica conteudo do parametro sx6 MV_MDTRESP

@author Denis Hyroshi de Souza
@since 26/01/04
/*/
//---------------------------------------------------------------------
User Function SX6PPPRES()

	// Representante Medico
	If Alltrim( GetMV( "MV_MDTRESP" ) ) == "2"
		cFilRES     := xFilial( "TMK" )
		cAliasRES 	:= "TMK"
		cCNomeRES 	:= "TMK->TMK_NOMUSU"
		cCpfRes 	:= "TMK->TMK_CIC"
		cValRES		:= "ExistCPO('TMK',mv_par" + cNumSX1 + ")"
	EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT700SXB

Consulta padrao da pergunta Representante Empresa?

@author Jorge Luis Siementkowski
@since 19/10/2017

@return Logico, Define se o usuario clicou em Ok na consulta padrao
/*/
//---------------------------------------------------------------------
User Function MDT700SXB()

	Local lRet	:= .F.

	If Alltrim( GetMV( "MV_MDTRESP" ) ) == "2"
		dbSelectArea( "TMK" )
		dbSetOrder( 1 ) //TMK_FILIAL + TMK_CODUSU
		If (lRet := ConPad1( , , , "TMK", "cRetF3", , .F. ) )
			cRetF3 := TMK->TMK_CODUSU
		EndIf
	Else
		dbSelectArea( "SRA" )
		dbSetOrder( 1 ) //RA_FILIAL + RA_MAT
		If (lRet := ConPad1( , , , "SRA", "cRetF3", , .F. ) )
			cRetF3 := SRA->RA_MAT
		EndIf
	EndIf

Return lRet

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT700RSXB

Retorna o resultado da consulta padrão da pergunta Representante Empresa?

@author Jorge Luis Siementkowski
@since 19/10/2017

@return Caracter, Retorno da consulta de Representante Empresa?
/*/
//---------------------------------------------------------------------
User Function MDT700RSXB()
Return IIf( Type( 'cRetF3' ) != 'U' .And. !Empty( cRetF3 ), cRetF3, Space( TAMSX3( ReadVar() )[1] ) )

//-------------------------------------------------------------------
/*/{Protheus.doc} EMP700OPEN

Abre arquivo de outra empresa

@author  Denis Hyroshi de Souza
@since   07/05/04

@sample  sample

@param   cAlias1, Caracter, Nome do Alias conforme X2_CHAVE
@param   cAlias2, Caracter, Nome do Alias com a qual a Tabela será aberta
@param   nIndice, Numerico, Ordem com a qual a Tabela sera aberta
@param   MvEmpresa, Caracter, Codigo da Empresa do arquivo
@param   cMd, Caracter, Modo de Acesso do arquivo conforme X2_MODO
@param   MvFilial, Caracter, Filial usada para posicionamentos na SM0

@return  Logico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function EMP700OPEN(cAlias1, cAlias2, nIndice, MvEmpresa, cMd, MvFilial)

	Local nAT := 0
	Local aArea := GetArea()//Salva area posicionada

	Default nIndice := 1
	Default cAlias1 := Alias()
	Default cAlias2 := Alias()
	Default MvEmpresa := cEmpAnt
	Default cMd := FWModeAccess( Alias() )
	Default MvFilial  := cSvFilAnt

	// Restaura variaveis para alteracao da tabela
	dbSelectArea( "SM0" )
	dbSeek( cEmpPPP + cSvFilAnt )
	cFilAnt := cSvFilAnt

	UniqueKey( NIL, cAlias1, .T. )
	EmpOpenFile( cAlias2, cAlias1, nIndice, .T., MvEmpresa, @cMd )   // Abre arquivo da empresa selecionada
	nAT := AT( cAlias1, cArqTab )

	If nAT > 0
		cArqTab := Subs( cArqTab, 1, nAT + 2 ) + cMd + Subs( cArqTab, nAT + 4 )
	EndIf

	cArqTab := Subs( cArqTab, 1, nTamTable )

	// Altera variaveis para o xFilial
	dbSelectArea( "SM0" )
	dbSeek( MvEmpresa + MvFilial )
	cFilAnt := MvFilial

	RestArea( aArea )

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} PPPDTDEMIS

Busca data de demissao do funcionaro na tabela SRG

@author  Denis Hyroshi de Souza
@since   07/05/04

@return  Date, Data de demissao do funcionario na tabela de Rescisoes
/*/
//-------------------------------------------------------------------
User Function PPPDTDEMIS()

	Local dDtDem := Stod( Space( 8 ) )
	Local aArea := GetArea()

	Dbselectarea( "SRG" )
	Dbsetorder( 1 )
	Dbseek( SRA->RA_FILIAL+SRA->RA_MAT )

	While !Eof() .And. SRA->RA_FILIAL+SRA->RA_MAT == SRG->RG_FILIAL+SRG->RG_MAT

		If SRG->RG_DATADEM >= dDataBase-30
			dDtDem := SRG->RG_DATADEM
		EndIf

		dbSkip()
	End

	RestArea( aArea )
Return dDtDem

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT700VLDD

Verifica se a data de emissao do PPP foi informada

@author  Denis Hyroshi de Souza
@since   07/05/04

@sample  U_MDT700VLDD("01/02/2010")

@param   cpar22, Caracter, Conteudo do campo de data de emissao

@return  Logico, .T. se o campo foi preenchido
/*/
//-------------------------------------------------------------------
User Function MDT700VLDD( cpar22 )

	If Empty( cpar22 )
		MsgInfo( STR0253 ) // "Esse campo devera ser preenchido com a data de emissao que sera exibida no PPP."
		Return .F.
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT700MES

Verifica a quantidade de meses do parametro MV_NG2MEAN

@author  Denis Hyroshi de Souza
@since   17/06/04

@return  Numerico, Quantidade de meses do parametro ajustado para uso no PPP
/*/
//-------------------------------------------------------------------
User Function MDT700MES()

	Local nQtdMes := 1
	Local nMes

	nMes := GETMV( "MV_NG2MEAN" )

	If Valtype( nMes ) == "N"

		If nMes == 0
			nQtdMes := 0
		ElseIf nMes < 0
			nQtdMes := 1
		ElseIf nMes > 12
			nQtdMes := 12
		Else
			nQtdMes := nMes
		EndIf

	EndIf

Return nQtdMes

//-------------------------------------------------------------------
/*/{Protheus.doc} fPPP_EPI

Ajusta os Epis entregues em outra funcao/setor

@author  Denis Hyroshi de Souza
@since   17/06/04

@sample  U_fPPP_EPI(TN0->TN0_DTRECO)

@param   dInicio, Date, Data a ser comparada com a date de entrega do epi

@return  Nulo, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function fPPP_EPI(dInicio)

	Local aRecnos := {}
	Local nFor

	dbSelectArea( cTRBTNF )
	dbSetOrder( 1 )
	dbSeek( DTOS( dInicio ) )

	While !Eof() .And. dInicio == (cTRBTNF)->DTINI

		cSvCA     := (cTRBTNF)->NUMCAP
		dDtIniTRB := (cTRBTNF)->DTREAL
		nRecnoTRB := (cTRBTNF)->(Recno())
		lFirstTRB := .T.

		While !Eof() .And. dInicio == (cTRBTNF)->DTINI .And. cSvCA == (cTRBTNF)->NUMCAP

			If !lFirstTRB .And. (cTRBTNF)->DTREAL > dDtIniTRB
				dDtIniTRB := (cTRBTNF)->DTREAL
				nRecnoTRB := (cTRBTNF)->(Recno())
			EndIf

			RecLock( cTRBTNF, .F. )
				(cTRBTNF)->SITUAC := "S"
			MsUnLock()

			lFirstTRB := .F.

			dbSelectArea( cTRBTNF )
			dbSkip()
		End

		aAdd( aRecnos, nRecnoTRB )
	End

	For nFor := 1 To Len( aRecnos )
		dbSelectArea( cTRBTNF )
		dbGoTo( aRecnos[nFor] )

		If !Eof() .And. !Bof()
			RecLock( cTRBTNF, .F. )
				(cTRBTNF)->SITUAC := " "
			MsUnLock()
		EndIf

	Next nFor

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} PPPSENDMAIL

Envia email do relatorio, conforme parametros definidos no
SX6 e informacoes entradas pelo usuario

@author  Liber De Esteban
@since   01/09/04

@sample  U_PPPSENDMAIL("\RELATORIO\MDT700_20040505_161040_PAG1.JPEG")

@param   cPrefixo, Caracter, Caminho para salvar os arquivos

@return  Logico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function PPPSENDMAIL(cPrefixo)

	Local cBarraSrv := "\"
	Local cNameArq  := Lower( OemToAnsi( STR0006 ) ) + ".PDF"
	Local cArqLocal := cPathEst + cNameArq

	If isSRVunix()  //servidor eh da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
		cBarraSrv := "/"
	Endif

	If nProcessa == 1

		cDiretorio := AllTrim( GetMV( "MV_RELT", , " " ) )
		cAnexos    := ""

		If Empty( cDiretorio )
			cDiretorio := cBarraSrv
		EndIf

		//imagem boa qualidade
		nLargura := 920
		nAltura  := 1300
		nZoom    := 145

		//imagem pessima qualidade
		If xm_par25 == 2 //Imagem PPP enviada p. e-mail ?
			nLargura := 745.5
			nAltura  := 1050
			nZoom    := 115.5
		EndIf

		If CpyT2S( cArqLocal, cDiretorio )
			cAnexos := cDiretorio + cNameArq
		Else
			MsgStop( STR0254, STR0255 ) // "Não foi possível gravar o relatório"###"AVISO"
			Return .F.
		EndIf

		cBody  := STR0256 + OemToAnsi( STR0006 ) + ": " + SRA->RA_MAT + " - " + AllTrim( SRA->RA_NOME ) // "Segue em anexo relatório de "

		CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword Result lOk

		If !lAutOk

			If ( lSmtpAuth )
				lAutOk := MailAuth( cUserAut, cPassAut )
			Else
				lAutOk := .T.
			EndIf

		EndIf

		If lOk .And. lAutOk

			If !Empty( cCC )
				SEND MAIL FROM cFrom To cTo CC cCC SUBJECT Alltrim( cSubject ) BODY cBody ATTACHMENT cAnexos Result lOk
			Else
				SEND MAIL FROM cFrom To cTo SUBJECT Alltrim( cSubject ) BODY cBody ATTACHMENT cAnexos Result lOk
			EndIf

			If lOk
				MsgInfo( STR0257 ) // "Email enviado com sucesso"
			Else
				GET MAIL ERROR cErro
				MsgStop( STR0258 +Chr( 13 ) + Chr( 10 ) + cErro, STR0255 ) // "Não foi possível enviar o Email."###"AVISO"
				Return .F.
			EndIf

		Else
			GET MAIL ERROR cErro
			MsgStop( STR0259 + Chr( 13 ) + Chr( 10 ) + cErro, STR0255 ) // "Erro na conexão com o SMTP Server."###"AVISO"
			Return .F.
		EndIf

		DISCONNECT SMTP SERVER

	EndIf

	If MsgYesNo( STR0260 ) // "Deseja visualizar o relatório?"
		 shellExecute( "Open", cArqLocal, "", cBarraSrv, 1 )
	EndIf

	//Apaga os arquivos da Estação de Trabalho e do Servidor
	FErase( cArqLocal )
	FErase( cAnexos )

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} PPPCONFMAIL

Verifica os parametros do SX6 usados para enviar email.
Exibe janela para o usuario entrar os dados.

@author  Liber De Esteban
@since   01/09/04

@return  Numerico, Opcao feita na tela de emails
/*/
//-------------------------------------------------------------------
User Function PPPCONFMAIL()

	// Verifica se existe o SMTP Server
	If 	Empty( cServer )
		MsgStop( STR0261, STR0262 ) // "O Servidor de SMTP não foi configurado !!!"###"Atenção"
		Return 0
	EndIf

	If lSmtpAuth

		// Verifica se existe a CONTA
		If 	Empty( cAccount )
			Msgstop( STR0263, STR0262 ) // "A Conta do email não foi configurada !!!"###"Atenção"
			Return 0
		EndIf

		// Verifica se existe a Senha
		If 	Empty( cPassword )
			Msgstop( STR0264, STR0262 ) // "A Senha do email não foi configurada !!!"###"Atenção"
			Return 0
		EndIf

	EndIf

	PswOrder( 1 )
	PswSeek( __CUSERID, .T. )
	aUsuario := PswRet( 1 )

	DEFINE MSDIALOG oDlgMail OF oMainWnd FROM 0, 0 To 200, 544 PIXEL TITLE STR0265 // "Dados do E-mail"

		@ 05, 04 To 079, 268 OF oDlgMail PIXEL
		@ 18, 08 Say STR0266	Size 012, 08 OF oDlgMail PIXEL
		@ 33, 08 Say STR0267	Size 016, 08 OF oDlgMail PIXEL
		@ 48, 08 Say STR0268	Size 016, 08 OF oDlgMail PIXEL
		@ 63, 08 Say STR0269	Size 021, 08 OF oDlgMail PIXEL

		@ 18, 33 MSGet cFrom    Size 233, 10 When .F. OF oDlgMail PIXEL
		@ 33, 33 MSGet cTo      Size 233, 10          OF oDlgMail PIXEL
		@ 48, 33 MSGet cCC      Size 233, 10          OF oDlgMail PIXEL
		@ 63, 33 MSGet cSubject Size 233, 10          OF oDlgMail PIXEL

		DEFINE SBUTTON FROM 85, 100 TYPE 1 ACTION (IIf( !Empty( cTo ), IIf( oDlgMail:End(), nOpca:=1, nOpca:=1 ), Help( "", 1, "AVG0001054" ) ) ) ENABLE OF oDlgMail PIXEL
		DEFINE SBUTTON FROM 85, 140 TYPE 2 ACTION ( oDlgMail:End() ) ENABLE OF oDlgMail PIXEL

	ACTIVATE MSDIALOG oDlgMail CENTERED

Return nOpca

//-------------------------------------------------------------------
/*/{Protheus.doc} R700VL19

Verifica se as perguntas de data de demissao estao preenchidas

@author  Denis Hyroshi Souza
@since   05/09/05

@return  return, return_type, return_descr
/*/
//-------------------------------------------------------------------
User Function R700VL19()

	If lSigaMdtps

		If mv_par22==3 .Or. mv_par22==4

			If Empty( mv_par23 )
				HELP( " ", 1, "NVAZIO" )
				Return .F.
			EndIf

		EndIf

	Else

		// Situacao e data de demissao dos funcionarios
		If (mv_par18==3 .Or. mv_par18==4) .And. Empty( mv_par19 )
			Help( " ", 1, "NVAZIO" )
			Return .F.
		EndIf

	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} R700VL20

Verifica a validade das perguntas de data de demissao

@author  Denis Hyroshi Souza
@since   05/09/05

@return  Logico, Define se as datas de demissao sao validas
/*/
//-------------------------------------------------------------------
User Function R700VL20()

	Local lRet := .T.

	If lSigaMdtps

		If mv_par22==3 .Or. mv_par22==4

			If mv_par23 > mv_par24
				Help( " ", 1, "DEATEINVAL" )
				lRet := .F.
			EndIf

		EndIf

	Else

		// Situacao e data de demissao dos funcionarios
		If ( mv_par18==3 .Or. mv_par18==4 ) .And. mv_par19 > mv_par20
			Help( " ", 1, "DEATEINVAL" )
			lRet := .F.
		EndIf

	EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} fQtdeAfast

Verifica se houve afastamento e retorna a quantidade de dias

@author  Denis Hyroshi Souza
@since   05/09/05

@sample  fQtdeAfast( "D MG 01" , "000001" , (cTRBTNF)->DTREAL , (cTRBTNF)->DTDEVO )

@param   cFilFun, Caracter, Filial do funcionario
@param   cMatric, Caracter, Matricula do funcionario
@param   _dtIniRis, Date, Data inicial a ser comparada
@param   _dtFimRis, Date, Data final a ser comparada

@return  Numerico, Quantidade de dias do afastamento
/*/
//-------------------------------------------------------------------
Static Function fQtdeAfast( cFilFun, cMatric, _dtIniRis, _dtFimRis )

	Local nPos
	Local nX
	Local nCont   := 0
	Local lMudou  := .F.
	Local nDias   := 0
	Local nVetID  := 0
	Local dTmpSR8 := StoD( "" )
	Local dIniAfa := StoD( "" )
	Local dFimAfa := StoD( "" )
	Local aAfasta := {}
	Local cModoSR8
	Local cXFilSR8

	cModoSR8 := f700RetCom( "SR8" )
	cXFilSR8 := FwxFilial( "SR8", cFilFun, Substr( cModoSR8, 1, 1 ), Substr( cModoSR8, 2, 1 ), Substr( cModoSR8, 3, 1 ) )

	dbSelectArea( "SR8" )
	dbSetOrder( 1 )
	dbSeek( cXFilSR8 + cMatric )

	While !Eof(  ) .And. SR8->R8_FILIAL + SR8->R8_MAT == cXFilSR8 + cMatric
		dTmpSR8 := IIf( Empty( SR8->R8_DATAFIM ), _dtFimRis, SR8->R8_DATAFIM )

		If SR8->R8_DATAINI <= _dtFimRis .And. dTmpSR8 >= _dtIniRis .And. !Empty( SR8->R8_DATAINI )
			dIniAfa := IIf( SR8->R8_DATAINI < _dtIniRis, _dtIniRis, SR8->R8_DATAINI )
			dFimAfa := IIf( dTmpSR8 > _dtFimRis, _dtFimRis, dTmpSR8 )
			nVetID++
			aAdd( aAfasta, { dIniAfa, dFimAfa, .T., nVetID } )
		EndIf

		dbSelectArea( "SR8" )
		dbSkip()
	EndDo

	While nCont < 1000
		nCont++
		lMudou := .F.

		For nX := 1 To Len( aAfasta )

			If aAfasta[nX, 3]
				nPos := aScan( aAfasta, { |x| x[1] <= aAfasta[nX, 2] .And. x[2] >= aAfasta[nX, 1] .And. nX <> x[4] .And. x[3] } )

				If nPos > 0
					aAfasta[nX, 1] := IIf( aAfasta[nX, 1] > aAfasta[nPos, 1], aAfasta[nPos, 1], aAfasta[nX, 1] )
					aAfasta[nX, 2] := IIf( aAfasta[nX, 2] < aAfasta[nPos, 2], aAfasta[nPos, 2], aAfasta[nX, 2] )
					aAfasta[nPos, 3] := .F.
					lMudou := .T.
				EndIf

			EndIf

		Next nX

		If !lMudou
			Exit
		EndIf

	End

	For nX := 1 To Len( aAfasta )

		If aAfasta[nX, 3]
			nDias += (aAfasta[nX, 2]-aAfasta[nX, 1]) + 1
		EndIf

	Next nX

Return nDias

//---------------------------------------------------------------------
/*/{Protheus.doc} f700RetCom
Retorna compartilhamento da tabela

@param cAlias - Alias utilizado.
@return - (SX2->(X2_MODOEMP+X2_MODOUN+X2_MODO))

@author Roger Rodrigues
@since 12/11/10

/*/
//---------------------------------------------------------------------
Static Function f700RetCom(cAlias)

	dbSelectArea( "SX2" )
	dbSetOrder( 1 )
	dbSeek( cAlias )

Return FWModeAccess( cAlias, 1 ) + FWModeAccess( cAlias, 2 ) + FWModeAccess( cAlias, 3 )

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR700ATE
Função para validação do parâmetro até .... ?

@return

@sample
U_MDTR700ATE("SRA",Mv_par05,Mv_par06,6)

@author Bruno Lobo de Souza
@since 09/12/2013
@version 1.0
/*/
//---------------------------------------------------------------------
User Function MDTR700ATE( cTabela, cMvParDe, cMvParAte, nTam )

	If Empty( cMvParAte )
		ShowHelpDlg( STR0262, { STR0273 }, 2, { STR0275 }, 2 )
		Return .F.
	Elseif cMvParAte < cMvParDe
		ShowHelpDlg( STR0262, { STR0274 }, 2, { STR0275 }, 2 )
		Return .F.
	EndIf

	If cMvParAte = Replicate( 'Z', Len( cMvParAte ) )
		Return .T.
	Else

		If cTabela == "SRA"

			If !ExCpoMDT( cTabela, cMvParAte )
				Return .F.
			EndIf

		ElseIf !ExistCpo( cTabela, cMvParAte )
			Return .F.
		EndIf

	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} fDesagData
Desagrupa datas para impressão.

@author Guilherme Benkendorf

@since 27/01/2015

@sample fDesagData( 11/01/2012 , 15/01/2014 )

@return Retorna array aBloco, onde cada posição corresponde a impressão
@return { "11/01/2012 a 31/12/2012" , "01/01/2013 a 31/12/2013" , "01/01/2014 a 15/01/2014" }
/*/
//---------------------------------------------------------------------

Static Function fDesagData( dDtIni, dDtFim )

	Local aBloco  := {}
	Local nRepete := 1
	Local nX
	Local nAnoAux // Auxilia na soma dos anos

	// Variaveis para auxiliar na impressão das datas
	Local dDtAuxIni
	Local dDtAuxFim

	/*/---------------------------------------------------------------------------------
		Campos 13.1, 14.1, 15.1, 16.1 e 18.1 - As informações a partir de 01/01/2004,
		deverão ser discriminadas anualmente, não se admitindo a informação em bloco em
		virtude do contido no § 3º, artigo 254 e § 7º, artigo 272 da IN 45/2010
	---------------------------------------------------------------------------------/*/

	// Será desmembrado a impressão apenas se o parâmetro estiver habilitado
	// e seguir a regra do INSS, a partir de 2004, antes é jogado em um único bloco
	If xm_par30 == 1

		If Year( dDtIni ) < 2004
			aAdd( aBloco, U_NGPPPDATE( dDtIni ) + STR0173 + IIf( !Empty( dDtFim ) .And. dDtFim < StoD( "20031231" ), U_NGPPPDATE( dDtFim ), U_NGPPPDATE( StoD( "20031231" ) ) ) ) //" a "

			If !Empty( dDtFim ) .And. dDtFim < StoD( "20040101" )
				dDtIni := dDtFim
			Else
				dDtIni := StoD( "20040101" )
			EndIf

		EndIf

		nRepete := IIf( !Empty( dDtFim ), Year( dDtFim ), Year( dDataBase ) ) - Year( dDtIni )
		nRepete := IIf( nRepete > 0, nRepete + 1, 1 )
	EndIf

	nAnoAux := Year( dDtIni )

	For nX := 1 To nRepete

		dDtAuxIni:= IIf( nX == 1, dDtIni, CToD( "01/01/" + Str( nAnoAux+1, 4 ) ) )
		nAnoAux  := Year( dDtAuxIni )

		dDtAuxFim:= IIf( nX <> nRepete, CToD( "31/12/" + Str( nAnoAux, 4 ) ), dDtFim )
		nAnoAux  := Year( dDtAuxFim )

		aAdd( aBloco, U_NGPPPDATE( dDtAuxIni ) + STR0173 + U_NGPPPDATE( dDtAuxFim ) ) //" a "

	Next nX

Return aBloco

//---------------------------------------------------------------------------------------
/*/{Protheus.doc} MDT700AFAS
Responsavel por verificar afastamento do funcionário durante o período de
exposição ao risco, e dividir em períodos o tempo de exposição.

@type function

@source MDTR700.prx

@author Guilherme Freudenburg
@since 12/01/2017

@param cMat		, Caracter	, Matrícula do funcionário utilizado
@param dIniRis	, Date		, Data Início do Risco
@param dFimRis	, Date		, Data Fim do Risco

@sample MDT700AFAS( '00001', 01/01/2017 , 01/01/2017  )

@return aEficaz, Array , Retorna a data de início e fim de cada período.
/*/
//----------------------------------------------------------------------------------------
Static Function MDT700AFAS( cMat, dIniRis, dFimRis  )

	Local cVarAfas := xm_par36
	Local nX := 0
	Local aEficaz := {}
	Local aAfasta := {}
	Local aVarFas := {}

	While !Empty( cVarAfas )
		aAdd( aVarFas, SubStr( cVarAfas, 1, 3 ) )
		cVarAfas := SubSTr( cVarAfas, 4 )
	End

	dbSelectArea( "SR8" )
	dbSetOrder( 1 )//R8_FILIAL+R8_MAT+DTOS( R8_DATAINI )+R8_TIPO

	If dbSeek( xFilial( "SR8" )+cMat )//Verifica se houve algum afastamento para o funcionário.

		While !Eof() .And. SR8->R8_MAT == cMat

			If aScan( aVarFas, { | x | x == SR8->R8_TIPOAFA } ) > 0 .And.; // Verifica se o tipo de afastamento está contido nos selecionados através do SX1.
			   dIniRis <= SR8->R8_DATAFIM .And. dFimRis >= SR8->R8_DATAINI  // Verifica se o risco esta contido no periodo de afastamento
				aAdd( aAfasta, { SR8->R8_DATAINI, SR8->R8_DATAFIM } ) // Adiciona o período de afastado.
			EndIf

			SR8->(dbSkip())
		End

	EndIf

	If Len( aAfasta ) > 0

		For nX := 1 To Len( aAfasta ) //Percorre todos os períodos afastados.

			If nX == 1

				If aAfasta[nX, 1]-1 >= dIniRis //Inicio do afastamento deve ser maior que o inicio do risco.
					aAdd( aEficaz, { dIniRis, aAfasta[nX, 1]-1 } )
				EndIf

				If nX + 1 <= Len( aAfasta )
					aAdd( aEficaz, { aAfasta[nX, 2]+1, aAfasta[nX+1, 1]-1 } )
				ElseIf nX == Len( aAfasta ) .And. aAfasta[nX, 2]+1 <= dFimRis
					aAdd( aEficaz, { aAfasta[nX, 2]+1, dFimRis } )
				EndIf

			Else

				If nX == Len( aAfasta )
					aAdd( aEficaz, { aAfasta[nX, 2]+1, dFimRis } )
				Else
					aAdd( aEficaz, { aAfasta[nX, 2]+1, aAfasta[nX+1, 1]-1 } )
				EndIf

			EndIf

		Next nX

	Else // Caso não encontre nenhum afastamento.
		aAdd( aEficaz, { dIniRis, dFimRis } )
	EndIf

Return aEficaz

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT700FAST
Permite selecionar os tipos dos afastamentos desejados.

@type User Function

@source MDTR700.prx

@author Guilherme Freudenburg
@since 17/01/2017

@sample U_MDT700FAST()

@return lRet,Lógico, Retorna verdadeiro quando função estiver correta
/*/
//---------------------------------------------------------------------
User Function MDT700FAST()

	Local aArea := GetArea()
	// Variaveis para montar TRB
	Local aDBF, aTRBSX5
	// Variaveis de Tela
	Local oDlgAfas
	// Varivaeis operacionais
	Local cKeyAfas   := ""
	Local cResultAfas := Space( 60 )
	Local aAfasCombo := {STR0311, STR0312, STR0313}//"Código","Descrição","Marcados"
	Local oAfasCombo
	Local oPanelAfas
	Local oButtonAfas
	Local oGetAfas
	Local oMarkAfas
	Local cAfasta := ""

	// Variaveis da TRB
	Local nOpcao
	Local lInverte, lRet
	Local cTRB700 := GetNextAlias()

	Private cMarca := GetMark()

	lInverte:= .F.

	//Valores e Caracteristicas da TRB
	aDBF := {}
	aAdd( aDBF, { "TRB_OK", "C", 02, 0 } )
	aAdd( aDBF, { "TRB_COD", "C", 03, 0 } )
	aAdd( aDBF, { "TRB_DESC", "C", 75, 0 } )

	aTRBSX5 := {}
	aAdd( aTRBSX5, { "TRB_OK", NIL, " ", } )
	aAdd( aTRBSX5, { "TRB_COD", NIL, STR0309, } )  //"Afastamento"
	aAdd( aTRBSX5, { "TRB_DESC", NIL, STR0310, } )  //"Descrição"

	//Cria TRB
	oTemp700 := FWTemporaryTable():New( cTRB700, aDBF )
	oTemp700:AddIndex( "1", {"TRB_COD"} )
	oTemp700:AddIndex( "2", {"TRB_DESC"} )
	oTemp700:AddIndex( "3", {"TRB_OK"} )
	oTemp700:Create()

	Processa( {|lEnd| FSeachAfas( cTRB700 )}, STR0307, STR0308 )//"Buscando Afastamentos..."//"Espere"
	dbSelectArea( cTRB700 )
	dbGoTop()

	If (cTRB700)->(Reccount()) <= 0
		oTemp700:Delete()
		RestArea( aArea )
		Msgstop( STR0306, STR0262 )  //"Não existem Afastamentos cadastrados" //"ATENÇÃO"
		Return .T.
	EndIf

	nOpcao := 0

	DEFINE MSDIALOG oDlgAfas TITLE OemToAnsi( STR0305 ) From 150, 0 To 735, 550 PIXEL OF oMainWnd //"Afastamentos"

		oPanelAfas	:= TPanel():New( , , , oDlgAfas, , , , , , , , .F., .F. )
			oPanelAfas:Align	:= CONTROL_ALIGN_ALLCLIENT

			TGroup():New(8, 8, 40, 270, , oPanelAfas, , , .T.)
			TSay():New( 16, 12, {|| OemtoAnsi( STR0303 ) }, oPanelAfas, , , .F., .F., .F., .T., CLR_BLACK, CLR_WHITE, 200, 010 )//"Estes são os Afastamentos cadastrados no sistema."
			TSay():New( 26, 12, {|| OemtoAnsi( STR0304 ) }, oPanelAfas, , , .F., .F., .F., .T., CLR_BLACK, CLR_WHITE, 200, 010 )//"Selecione aqueles que são necessários a tarefa."


			//Campo combo de indice para busca
			oAfasCombo := TComboBox():New( 45, 5, {|u| IIf( Pcount()>0, cKeyAfas:= u, cKeyAfas ) }, aAfasCombo,;
														 190, 10, oPanelAfas, , {|| MDT700ORAF( @oAfasCombo, @oGetAfas, @oMarkAfas, cTRB700 ) }, , , CLR_BLACK,;
														 .T., , , , , , , , , cKeyAfas, , , , CLR_BLACK )
			//Campo de busca
			oGetAfas := TGet():New( 58, 5, {|u| IIf( Pcount()>0, cResultAfas:= u, cResultAfas ) }, oPanelAfas, 190, 7, "@!",;
													 , CLR_BLACK, , , , , .T., , , {|| oAfasCombo:nAt <> 3 },;
													 , , , , , , cResultAfas, , , , , , , , , )
			//Botão de pesquisa
			oButtonAfas := TButton():New( 44, 200, STR0302, oPanelAfas, {|| IIf( oAfasCombo:nAt <> 3, MDT700SEAR( @oAfasCombo, @oGetAfas, @oMarkAfas, cTRB700 ), .T. ) },;
														 73, 12, , , , .T., , , , {|| oAfasCombo:nAt <> 3  }, , )//"Pesquisar"

			oMarkAfas:= MsSelect():NEW( cTRB700, "TRB_OK", , aTRBSX5, @lINVERTE, @cMARCA, { 73, 5, 260, 272 }, , , oPanelAfas )
				oMarkAfas:bMARK               := {|| U_MDT700MK( cMarca, cTRB700, @oAfasCombo, @oMarkAfas )}
				oMarkAfas:oBROWSE:lHASMARK    := .T.
				oMarkAfas:oBROWSE:lCANALLMARK := .T.
				oMarkAfas:oBROWSE:bALLMARK    := {|| U_MDT700INV( cTRB700, cMarca ) }

	ACTIVATE MSDIALOG oDlgAfas ON INIT EnchoiceBar( oDlgAfas, { || nOpcao := 1, oDlgAfas:End() }, { || nOpcao := 2, oDlgAfas:End() } ) Centered

	lRet := ( nOpcao == 1 )

	If lRet //Caso seja confirmado
		dbSelectArea( cTRB700 )
		dbGoTop()

		While !Eof()

			If !Empty( (cTRB700)->TRB_OK )
				cAfasta += (cTRB700)->TRB_COD
			Else
				cAfasta += "***"
			EndIf

			dbSkip()
		End

		If !Empty( cAfasta )
			mv_par36 := cAfasta
		EndIf

	ElseIf Empty( Mv_par36 )
		Mv_par36 := cAfasta
	EndIf

	oTemp700:Delete()

	RestArea( aArea )

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} FSeachAfas
Função responsável por realizar a busca de todos os tipos de
afastamentos cadastrados no sistema.

@type function

@source MDTR700.prx

@author Guilherme Freudenburg
@since 17/01/2017

@param cAliasTRB, 	 Caracter	, Alias da TRB utilizada.

@sample FSeachAfas( "SGN0005" )

@return Nil, vazio.
/*/
//---------------------------------------------------------------------
Static Function FSeachAfas( cAliasTRB )
	Local aArea   := GetArea()

	//----------------------------------------
	//| Adiciona os tipos de Afastamentos.   |
	//----------------------------------------
	dbSelectArea( "RCM" )
	dbSetOrder( 1 )
	dbSeek( xFilial( "RCM" ) )

	While RCM->(!Eof()) .And. xFilial( "RCM" ) == RCM->RCM_FILIAL

		If RCM->RCM_TIPOAF == "1" //Afastamentos
			RecLock( cAliasTRB, .T. )
				(cAliasTRB)->TRB_OK := IIf( Len( AllTrim( Mv_par36 ) ) > 1, IIf( AllTrim( RCM->RCM_TIPO ) $ Mv_par36, cMarca, "" ),;
				 IIf( Alltrim( RCM->RCM_TIPO ) $ "003,004,010,011,012", cMarca, "" ) )
				(cAliasTRB)->TRB_COD := RCM->RCM_TIPO
				(cAliasTRB)->TRB_DESC := RCM->RCM_DESCRI
			(cAliasTRB)->(MsUnLock())
		EndIf

		RCM->(dbSkip())
	End

	RestArea( aArea )

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT700ORAF
Função de ordenação para o MarkBrose conforme selecionado
no ComboBox

@type function

@source MDTR700.prx

@author Guilherme Freudenburg
@since 17/01/2017

@param oCombo	,	 Object		, Objeto do comboBox
@param oGet		,	 Object		, Objeto do campo Get
@param oMark 	, 	 Object		, Objeto do MarkBrowse
@param cAliasTRB, 	 Caracter	, Alias da TRB utilizada.

@sample MDT700ORAF( oCombo , oGet , oMark, "SGN0005" )

@return Lógico, sempre verdadeiro
/*/
//---------------------------------------------------------------------
Static Function MDT700ORAF( oCombo, oGet, oMark, cAliasTRB )

	Local nIndAfas := oCombo:nAt

	// Ordena TRB conforme selecionado no combo
	dbSelectArea( cAliasTRB )
	dbSetOrder( nIndAfas )
	dbGoTop()

	// Caso for marcação, limpa Get
	If nIndAfas == 3 //TRB_OK
		oGet:cText	:= Space( 60 )
	EndIf

	oMark:oBrowse:Refresh()

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT700SEAR
Função de busca do EPI para o Mark Browse.

@type function

@source MDTR700.prx

@author Guilherme Freudenburg
@since 17/01/2017

@param oCombo	,	 Object		, Objeto do comboBox
@param oGet		,	 Object		, Objeto do campo Get
@param oMark 	, 	 Object		, Objeto do MarkBrowse
@param cAliasTRB, 	 Caracter	, Alias da TRB utilizada.

@sample MDT700SEAR( oCombo , oGet , oMark, "SGN0005" )

@return lRet,Lógico, caso encontre valores retorna .T.
/*/
//---------------------------------------------------------------------
Static Function MDT700SEAR( oCombo, oGet, oMark, cAliasTRB )
	Local lRet    := .T.
	Local nInd    := oCombo:nAt
	Local cResult := AllTrim( oGet:cText )

	dbSelectArea( cAliasTRB )
	dbSetOrder( nInd )

	If ! ( lRet := dbSeek( cResult ) )
		MsgInfo( STR0301, STR0262 )//"Valor não encontrado."##"ATENÇÃO"
		(cAliasTRB)->(dbGoTop())
	Else
		oMark:oBrowse:SetFocus()//Se encontra resultado, focaliza tela do mark
	EndIf

Return lRet

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT700MK
Efetua Ações na marcações do MarkBrowse.

@type function

@source MDTR700.prx

@author Guilherme Freudenburg
@since 17/01/2017


@param cMARCA	, Caracter, Determina a marcação dos afastamentos.
@param cAliasTRB, Caracter, Alias da TRB utilizada.
@param oCombo	, Object,	Objeto do campo combo.
@param oMark	, Object,	Objeto do markbrowser.

@sample U_MDT700MK( * , "SGN00005" , oComb , oMark )

@return Lógico, sempre verdadeiro.
/*/
//---------------------------------------------------------------------
User Function MDT700MK( cMarca, cAliasTRB, oCombo, oMark )
	Local nIndAfas := oCombo:nAt

	// Ordena o marcado quando for o indice 3 - Marcado
	If nIndAfas == 3
		dbSelectArea( cAliasTRB )
		dbSetOrder( nIndAfas )
		//Atualiza tela do Mark, para exibir a ordem
		oMark:oBrowse:Refresh()
	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT700INV
Responsavel por inveter a marcação do Browser.

@type function

@source MDTR700.prx

@author Guilherme Freudenburg
@since 17/01/2017

@param cAliasTRB, Caracter, Alias da TRB utilizada.
@param cMARCA	, Caracter, Determina a marcação dos afastamentos.

@sample U_MDT700INV( 'SG0005' ,  '*' )

@return Lógico, sempre verdadeiro.
/*/
//---------------------------------------------------------------------
User Function MDT700INV(cAliasTRB, cMARCA)
	Local aArea := (cAliasTRB)->(GetArea()) // Salva área posicionada.

	dbSelectArea( cAliasTRB )
	dbSetOrder( 1 )
	dbGoTop()

	While !Eof()
		(cAliasTRB)->TRB_OK := IIf( Empty( (cAliasTRB)->TRB_OK), cMARCA, Space( Len( cMARCA ) ) )
		dbSelectArea( cAliasTRB )
		( cAliasTRB )->( dbSkip() )
	End

	RestArea( aArea )
Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT700RCM
Busca a quantidade de afastamentos.

@type function

@source MDTR700.prx

@author Guilherme Freudenburg
@since 17/01/2017

@sample MDT700RCM()

@return nQuant, Numérico, Quantidade de afastamentos.
/*/
//---------------------------------------------------------------------
Static Function MDT700RCM()

	Local nQuant := 0

	dbSelectArea( "RCM" )
	dbGoTop()

	While RCM->(!Eof()) .And. xFilial( "RCM" ) == RCM->RCM_FILIAL

		If RCM->RCM_TIPOAF == "1"
			nQuant++
		EndIf

		RCM->(dbSkip())
	End

	nQuant := nQuant * 3 //Multiplica por 3 mediante ao tamanho do campo RCM_TIPO

Return nQuant

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT700VALF
Função responsavel por realizar a validação do SX1 - Mv_par36

@type function

@source MDTR700.prx

@author Guilherme Freudenburg
@since 17/01/2017

@sample U_MDT700VALF()

@return lRet, Lógico, Verdadeiro quando não ocorrer alguma inconsistência.
/*/
//---------------------------------------------------------------------
User Function MDT700VALF()

	Local lRet := .T.
	Local aAfast := {} // Recebe os tipos de afastamentos.
	Local cMvAfas := mv_par36
	Local aMvAfas := {}
	Local nX := 0

	While !Empty( cMvAfas ) .And. lRet

		If ( SubStr( cMvAfas, 1, 3 ) <> "***" .And. aScan( aMvAfas, { |x| x == SubStr( cMvAfas, 1, 3 ) } ) == 0  .Or. SubStr( cMvAfas, 1, 3 ) == "***" )
			aAdd( aMvAfas, SubStr( cMvAfas, 1, 3 ) )
			cMvAfas := SubSTr( cMvAfas, 4 )
		Else
			lRet := .F.
			ShowHelpDlg( STR0262, { STR0316 }, 2, { STR0317 }, 2 ) //Atenção ## "Não é permitido incluir tipos de afastamentos iguais." ## "Favor selecionar apenas um de cada tipo de afastamento."
		EndIf

	End

	// Adiciona os tipos de Afastamentos.
	If lRet
		dbSelectArea( "RCM" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "RCM" ) )
		While RCM->(!Eof()) .And. xFilial( "RCM" ) == RCM->RCM_FILIAL

			If RCM->RCM_TIPOAF == "1" //Afastamentos
				aAdd( aAfast, Alltrim( RCM->RCM_TIPO ) )
			EndIf

			RCM->(dbSkip())
		End

		If Len( aMvAfas ) > 0

			For nX := 1 To Len( aMvAfas )

				If aScan( aAfast, { |x| x == aMvAfas[nX] } ) == 0 .And. aMvAfas[nX] <> '***'
					lRet := .F.
					Help( " ", 1, "REGNOIS" )
					Exit
				EndIf

			Next nX

		EndIf

	EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} fImpMemo

Faz a impressao de memos para o PPP

@author  Jorge Luis Siementkowski
@since   11/07/2018

@sample  fImpMemo(STR0321)

@param   cMemo, Caracter, Memo a ser impresso
/*/
//-------------------------------------------------------------------
Static Function fImpMemo(cMemo)

	Local linhaCorrente
	Local nLinhasMemo := MlCount( cMemo, 148 )

	// Cria um pequeno espacamento entre o titulo e o memo
	If !Empty( cMemo )
		oPrintPPP:Line( lin, 50, lin + 25, 50 )
		oPrintPPP:Line( lin, 2940, lin + 25, 2940 )
		SomaLinha( 25, .T. )
	EndIf

	// Faz a impressao do memo
	For linhaCorrente := 1 To nLinhasMemo

		oPrintPPP:Line( lin, 50, lin + 40, 50 )
		oPrintPPP:Line( lin, 2940, lin + 40, 2940 )

		// Verifica se o texto a ser impresso tem tamanho maior do que 80% do tamanho máximo da linha
		If Len( AllTrim( MemoLine( cMemo, 148, LinhaCorrente ) ) ) > 118
			oPrintPPP:Say( lin + 30, 60, AV_Justifica( MemoLine( cMemo, 148, LinhaCorrente ) ), oFont08 )
		Else // Não justifica para não fazer espaçamentos grandes demais entre as palavras
			oPrintPPP:Say( lin + 30, 60, MemoLine( cMemo, 148, LinhaCorrente ), oFont08 )
		EndIf

		// Quando acaba a impressao desenha as linhas que fecham a secao
		If linhaCorrente == nLinhasMemo
			oPrintPPP:Line( lin + 40, 50, lin + 55, 50 )
			oPrintPPP:Line( lin + 40, 2940, lin + 55, 2940 )
			oPrintPPP:Line( lin + 55, 50, lin + 55, 2940 )
		Else
			SomaLinha( 40, .T. )
		EndIf

	Next

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} SomaLinha

Incrementa linha e quebra pagina

@author Denis Hyroshi de Souza
@since 21/10/02

@sample SomaLinha(80)

@param   nLi, Numerico, Espacamento que tera a quebra de linha
@param   lLinha, Logico, Se .T., faz uma linha no final da pagina
@param   lPula, Logico, Se .T., quebra a pagina independente da posicao atual da linha
/*/
//---------------------------------------------------------------------
Static Function SomaLinha( nLi, lLinha, lPula )

	If nLi != Nil
		lin += nLi
	Else
		lin += 60
	EndIf

	If lin > 2000 .Or. lPula

		If lLinha
			oPrintPPP:Line( lin, 50, lin, 2940 )
		EndIf

		oPrintPPP:SayAlign( 2200, 50, Str( nPaginaPPP, 3 ), oFont09n, 2940, 280, CLR_BLACK, 2, 1 )
		oPrintPPP:EndPage()
		nPaginaPPP++
		oPrintPPP:StartPage()
		lin := 380
		oPrintPPP:SayAlign( 250, 50, STR0149, oFont13, 2940, 280, CLR_BLACK, 2, 1 ) // "PERFIL PROFISSIOGRÁFICO PREVIDENCIÁRIO - PPP"
		oPrintPPP:Line( lin, 50, lin, 2940 )
	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fVlCCSRE
Valida centro de custo caso o funcionário tenha sido transferido

@type   Function

@author Eduardo Mussi
@since  03/10/2022

@return Lógico, .T. caso encontre um centro de custo compativel
/*/
//-------------------------------------------------------------------
Static Function fVlCCSRE()

	Local aBind     := {}
	Local cAliasSRE := GetNextAlias()
	Local lReturn   := .T.

	/*----------------------------------------+
	| Verifica a existência da query em cache |
	+----------------------------------------*/
	If Empty( cQryVlCC )
		
		cQryVlCC :=	'SELECT SRE.RE_CCD '
		cQryVlCC +=	'	FROM ' + RetSqlName( 'SRE' ) + ' SRE '
		cQryVlCC +=	'WHERE SRE.RE_EMPD    = ? '
		cQryVlCC +=	'  AND SRE.RE_FILIALD = ? '
		cQryVlCC +=	'  AND SRE.RE_MATD    = ? '
		cQryVlCC +=	'  AND SRE.RE_DATA   >= ? '
		cQryVlCC +=	'  AND SRE.RE_CCD     = ? '
		cQryVlCC +=	'  AND SRE.D_E_L_E_T_ = ? '

		cQryVlCC := ChangeQuery( cQryVlCC )
	
	EndIf
	
	aBind := {}
	aAdd( aBind, (cTRBPPP)->EMP    )
	aAdd( aBind, (cTRBPPP)->FILIAL )
	aAdd( aBind, (cTRBPPP)->MAT    )
	aAdd( aBind, DtoS( (cTRBPPP)->DTATE ) )
	aAdd( aBind, (cTRBPPP)->CUSTO  )
	aAdd( aBind, Space( 1 )        )

	dbUseArea( .T., 'TOPCONN', TcGenQry2( , , cQryVlCC, aBind ), cAliasSRE, .T., .T. )

	lReturn := (cAliasSRE)->( !EoF() )

	(cAliasSRE)->( dbCloseArea() )

	/*------------------------------------------------+
	| Libera consumo de memória p/ melhor performance |
	+------------------------------------------------*/
	aSize( aBind, 0 )
	aBind := Nil

Return lReturn

//-------------------------------------------------------------------
/*/{Protheus.doc} fVlMedCon 

Valida se os tipos de medidade controle são: 
Tipo da Medida de Controle = "2" (Protecao Coletiva) ou Medida de Controle = "4" ( Administrativas )

@type  Static Function

@author Elisson França
@since 07/03/2023

@param   cFilRis, Caracter, Filial do funcionario

@return cTipCtr, Caracter, retorna a medida de controle

/*/
//-------------------------------------------------------------------
Static Function fVlMedCon( cFilRis )
	
	Local cTipCtr   := ""
	Local lExisMed  := .T.
	Local cNumRis   := ( cTRBTN0 )->NUMRIS

	dbSelectArea( "TJF" )
	dbSetOrder( 1 )
	dbSeek( XFilial( "TJF" , cFilRis ) + cNumRis )

	While !Eof() .And. lExisMed

		dbSelectArea( "TO4" )
		dbSetOrder( 1 )
		If dbSeek( xFilial( "TO4" ) + TJF->TJF_MEDCON )

			If TO4->TO4_TIPCTR == "2"

				lExisMed := .F.
				cTipCtr := TO4->TO4_TIPCTR 
				Exit

			ElseIf TO4->TO4_TIPCTR == "4"

				cTipCtr := TO4->TO4_TIPCTR 

			Else
				
				lExisMed := .F.
				Exit

			EndIf
			
		EndIf

		( 'TJF' )->( DbSkip() )
		
	End

Return cTipCtr
