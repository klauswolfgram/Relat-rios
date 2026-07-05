/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "topconn.ch"
#INCLUDE "SHELL.CH"
#INCLUDE "Protheus.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "JURR095.CH"

#DEFINE IMP_SPOOL 2
#DEFINE IMP_PDF 6
#DEFINE nColIni   50   // Coluna inicial
#DEFINE nColFim   2350 // Coluna final
#DEFINE nSalto    40   // Salto de uma linha a outra
#DEFINE nFimL     3000 // Linha Final da página de um relatório
#DEFINE nTamCarac 20.5 // Tamanho de um caractere no relatório
#DEFINE cCpoExcec "NSZ_TIPOAS|NSZ_CRESCO|NSZ_CODRES|NSZ_CONMES" // Campos que não devem aparecer no relatório e que não possuem F3
#DEFINE cSesTotal "TotalPed|TotalCus|TotalGar|TotalO0W"

Static __x3Cache  := {}      // Informacoes diversas dos SX3
Static lNumPag := .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} U_JURR095()
Relatório de Assuntos Jurídicos

@param cAssJur  Tipo de Assunto Jurídico
@param cUser    Usuário de emissão do relatório
@param cThread  Código da fila de emissão
@param cParams  Parâmetros usados para filtros
		aParams[1]  == cUser
		aParams[2]  == cThread
		aParams[3]  == cImpAnd
		aParams[4]  == cAndCli
		aParams[5]  == cAndUlt
		aParams[6]  == cAndQtd
		aParams[7]  == cIntDat
		aParams[8]  == cDtIni
		aParams[9]  == cDtFim
		aParams[10] == cImpPag
		aParams[11] == cImpGar
		aParams[12] == cFilAnt
		aParams[13] == cImphist
		aParams[14] == cAnoMes
@param cCfgRel   Configuração do relatório
@param lAutomato define se vem da automação de testes
@param cNomerel  Nome do relatório
@param cCaminho  Caminho onde o arquivo será gerado
@param cJsonRel  Dados da gestão de relatório do Totvs Jurídico

@author Jorge Luis Branco Martins Junior
@since 11/01/16
@version 1.0

/*/
//-------------------------------------------------------------------
User Function JURR095(cAssJur, cUser, cThread, cParams, cCfgRel, lAutomato, cNomerel, cCaminho, cJsonRel)

If !lAutomato
	Processa({|| U_JURRel095(cAssJur, cUser, cThread, cParams, cCfgRel, lAutomato, cNomerel, cCaminho, cJsonRel)},STR0031,STR0032) //"Aguarde" # "Emitindo relatório"
Else
	U_JURRel095(cAssJur, cUser, cThread, cParams, cCfgRel, lAutomato, cNomerel,, cJsonRel)
Endif

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} U_JURRel095()
Regras do relatório de Assuntos Jurídicos

@param cAssJur  Tipo de Assunto Jurídico
@param cUser    Usuário de emissão do relatório
@param cThread  Código da fila de emissão
@param cParams  Parâmetros usados para filtros
		aParams[1]  == cUser
		aParams[2]  == cThread
		aParams[3]  == cImpAnd
		aParams[4]  == cAndCli
		aParams[5]  == cAndUlt
		aParams[6]  == cAndQtd
		aParams[7]  == cIntDat
		aParams[8]  == cDtIni
		aParams[9]  == cDtFim
		aParams[10] == cImpPag
		aParams[11] == cImpGar
		aParams[12] == cFilAnt
		aParams[13] == cImphist
		aParams[14] == cAnoMes
@param cCfgRel   Configuração do relatório
@param lAutomato define se vem da automação de testes
@param cNomerel  Nome do relatório
@param cCaminho  Caminho do arquivo quando chamado pelo TOTVS LEGAL
@param cJsonRel  Dados da gestão de relatório do Totvs Jurídico

@author Jorge Luis Branco Martins Junior
@since 11/01/16
@version 1.0

/*/
//-------------------------------------------------------------------
User Function JURRel095(cAssJur, cUser, cThread, cParams, cCfgRel, lAutomato, cNomerel, cCaminho, cJsonRel)
Local cQuery     := ""
Local nI         := 0
Local aRelat     := {}
Local aCabec     := {}
Local aSessao    := {}
Local aNSZ       := {}
Local aSessaoAux := {}
Local aParams    := STRTOKARR(cParams, ";") // Array com cada palavra a ser escrita.
Local aAssuntos  := ASORT(STRTOKARR(cAssJur, ","))

Default cNomerel := ""
Default cCaminho := ""

ProcRegua(0)
IncProc(0)
IncProc(0)

// Query Principal do relatório
cQuery := JA095QryPri(cUser, cThread)

If Empty(cNomerel) .AND. Len(aAssuntos) == 1
	cNomerel := ALLTRIM(JurGetDados("NYB",1,XFILIAL("NYB") + aAssuntos[1], "NYB_DESC"))
EndIf

lNumPag := Iif((Len(aParams) >= 10) .And. (aParams[10]=="S"),.T.,.F.)

For nI := 1 To Len(aAssuntos)
	aSessao := {}
	aRelat  := {}
	aCabec  := {}
	aNSZ := J095Campos(aAssuntos[nI], "NSZ",cCfgRel) // Campos a serem impressos na Área de Assuntos Jurídicos
	JRSetSessao(aAssuntos[nI], aRelat, aCabec, aSessao, aNSZ, cCfgRel, aParams)
	aAdd( aSessaoAux, { aAssuntos[nI], aClone(aSessao), aClone(aRelat), aClone(aCabec) } )
Next nI

JRelatorio(aSessaoAux, cQuery, lAutomato, cNomerel, cCaminho, cJsonRel) //Chamada da função de impressão do relatório em TMSPrinter

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} JA095QryPri()
Monta a query principal do relatório de assuntos jurídicos
 
Uso Geral.

@param cUser    Usuário de emissão do relatório
        cThread  Código da fila de emissão

@Return cQuery Query a ser executada

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JA095QryPri(cUser, cThread)
Local cQuery  := ""

	cQuery := "SELECT DISTINCT ISNULL(SA1.A1_NOME,'') NSZ_DCLIEN, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_CCLIEN,'') NSZ_CCLIEN, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_LCLIEN,'') NSZ_LCLIEN, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_TIPOAS,'') NSZ_TIPOAS, " + CRLF
	cQuery +=       " ISNULL(NVE.NVE_NUMCAS,'') || ' - ' || ISNULL(NVE.NVE_TITULO,'') NSZ_DCASO, " + CRLF
	cQuery +=       " ISNULL(ACY.ACY_DESCRI,'') NSZ_DGRCLI, " + CRLF
	cQuery +=       " ISNULL(NW7.NW7_DESC,'') NSZ_DFCORR, " + CRLF
	cQuery +=       " ISNULL(NS7.NS7_NOME,'') NSZ_DESCRI, " + CRLF
	cQuery +=       " ISNULL(NRB.NRB_DESC,'') NSZ_DAREAJ, " + CRLF
	cQuery +=       " ISNULL(NRL.NRL_DESC,'') NSZ_DSUBAR, " + CRLF
	cQuery +=       " ISNULL(RD0SOC.RD0_SIGLA,'') || ' - ' || ISNULL(RD0SOC.RD0_NOME,'') NSZ_DPART1, " + CRLF
	cQuery +=       " ISNULL(RD0ADV.RD0_SIGLA,'') || ' - ' || ISNULL(RD0ADV.RD0_NOME,'') NSZ_DPART2, " + CRLF
	cQuery +=       " ISNULL(RD0EST.RD0_SIGLA,'') || ' - ' || ISNULL(RD0EST.RD0_NOME,'') NSZ_DPART3, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_SITUAC,'') NSZ_SITUAC, " + CRLF
	cQuery +=       " ISNULL(NUQPROC.NUQ_CAJURI,'') NSZ_CPRORI, " + CRLF
	cQuery +=       " ISNULL(NUQPROC.NUQ_NUMPRO,'') NSZ_NPRORI, " + CRLF
	cQuery +=       " ISNULL(NUQPROC.NUQ_FILIAL,'') NSZ_FPRORI, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTENTR,'') NSZ_DTENTR, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_INSMUN,'') NSZ_INSMUN, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_INSEST,'') NSZ_INSEST, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_NIRE,'') NSZ_NIRE, " + CRLF
	cQuery +=       " ISNULL(NT9.NT9_NOME,'') NSZ_SOCIED, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_FLAG01,'') NSZ_FLAG01, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_FLAG02,'') NSZ_FLAG02, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_PERMUL,'') NSZ_PERMUL, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_NOMEFT,'') NSZ_NOMEFT, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTSOLI,'') NSZ_DTSOLI, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_NUMPED,'') NSZ_NUMPED, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_SITREL,'') NSZ_SITREL, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_NOMEMA,'') NSZ_NOMEMA, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTSITU,'') NSZ_DTSITU, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_BITMAP,'') NSZ_BITMAP, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTPROR,'') NSZ_DTPROR, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_ALVARA,'') NSZ_ALVARA, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_LOGRAD,'') NSZ_LOGRAD, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_LOGNUM,'') NSZ_LOGNUM, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_COMPLE,'') NSZ_COMPLE, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_BAIRRO,'') NSZ_BAIRRO, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_CEP,'') NSZ_CEP, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_ULTCON,'') NSZ_ULTCON, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_ALTPOS,'') NSZ_ALTPOS, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_OBJSOC,'') NSZ_OBJSOC, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_OPOSIC,'') NSZ_OPOSIC, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_ELABOR,'') NSZ_ELABOR, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTJPRO,'') NSZ_DTJPRO, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_INDCON,'') NSZ_INDCON, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTREAB,'') NSZ_DTREAB, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTCONT,'') NSZ_DTCONT, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VLCONT,0) NSZ_VLCONT, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VACONT,0) NSZ_VACONT, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_MULCON,0) NSZ_MULCON, " + CRLF
	cQuery +=       " ISNULL(SX5JY.X5_DESCRI,'') NSZ_DREGIO, " + CRLF
	cQuery +=       " ISNULL(SX5JZ.X5_DESCRI,'') NSZ_DDPSOL, " + CRLF
	cQuery +=       " ISNULL(SX5J4.X5_DESCRI,'') NSZ_DTPSOC, " + CRLF
	cQuery +=       " ISNULL(SX5J5.X5_DESCRI,'') NSZ_DSBPRO, " + CRLF
	cQuery +=       " ISNULL(NY6.NY6_DESC,'') NSZ_DTIPMA, " + CRLF
	cQuery +=       " ISNULL(NY7.NY7_DESC,'') NSZ_DSITMA, " + CRLF
	cQuery +=       " ISNULL(NY8.NY8_DESC,'') NSZ_DNATMA, " + CRLF
	cQuery +=       " ISNULL(NY9.NY9_DESC,'') NSZ_DAREAN, " + CRLF
	cQuery +=       " ISNULL(NYA.NYA_DESC,'') NSZ_DTPSOL, " + CRLF
	cQuery +=       " ISNULL(CC3.CC3_DESC,'') NSZ_CNAE, " + CRLF
	cQuery +=       " ISNULL(CTOCON.CTO_SIMB,'') NSZ_DMOCON, " + CRLF
	cQuery +=       " ISNULL(SE4.E4_DESCRI,'') NSZ_DCPCON, " + CRLF
	cQuery +=       " ISNULL(NQO.NQO_DESC,'') NSZ_DRITO, " + CRLF
	cQuery +=       " ISNULL(NQ4.NQ4_DESC,'') NSZ_DOBJET, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTINCL,'') NSZ_DTINCL, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_USUINC,'') NSZ_USUINC, " + CRLF
	cQuery +=       " ISNULL(NQ7.NQ7_DESC,'') NSZ_DPROGN, " + CRLF
	cQuery +=       " ISNULL(NQ7HIS.NQ7_DESC,'') NSZ_DPRHIS, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VLINES,'') NSZ_VLINES, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTCAUS,'') NSZ_DTCAUS, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTENVO,'') NSZ_DTENVO, " + CRLF
	cQuery +=       " ISNULL(CTOCAU.CTO_SIMB,'') NSZ_DMOCAU, " + CRLF
	cQuery +=       " ISNULL(CTOENV.CTO_SIMB,'') NSZ_DMOENV, " + CRLF
	cQuery +=       " ISNULL(CTOFIN.CTO_SIMB,'') NSZ_DMOFIN, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VLCAUS,0) NSZ_VLCAUS, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VACAUS,0) NSZ_VACAUS, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VLENVO,0) NSZ_VLENVO, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VAENVO,0) NSZ_VAENVO, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTHIST,'') NSZ_DTHIST, " + CRLF
	cQuery +=       " ISNULL(CTOHIS.CTO_SIMB,'') NSZ_DMOHIS, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VLHIST,0) NSZ_VLHIST, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTENCE,'') NSZ_DTENCE, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_CANCEL,'') NSZ_CANCEL, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_PRETER,'') NSZ_PRETER, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_USUENC,'') NSZ_USUENC, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VLFINA,0) NSZ_VLFINA, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VAFINA,0) NSZ_VAFINA, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_ESTTER,'') NSZ_ESTTER, " + CRLF
	cQuery +=       " ISNULL(NQI.NQI_DESC,'') NSZ_DMOENC, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_CMOENC,'') NSZ_CMOENC, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_COD,'') NSZ_COD, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_TOMBO,'') NSZ_TOMBO, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_PERENC,0) NSZ_PERENC, " + CRLF
	cQuery +=       " ISNULL(NQ3.NQ3_CUSER,'') NQ3_CUSER, " + CRLF
	cQuery +=       " ISNULL(NQ3.NQ3_SECAO,'') NQ3_SECAO, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_FILIAL,'') NSZ_FILIAL, " + CRLF
	cQuery +=       " ISNULL(NYB.NYB_DESC,'') NSZ_DTIPAS, " + CRLF
	cQuery +=       " ISNULL(NQ3.D_E_L_E_T_,''), " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_SJUIZA,0) NSZ_SJUIZA, " + CRLF
	cQuery +=       " ISNULL(CTT.CTT_DESC01,'') NSZ_DCCUST, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_LITISC,'') NSZ_LITISC, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTINVI,'') NSZ_DTINVI, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTTMVI,'') NSZ_DTTMVI, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_REGULA,'') NSZ_REGULA, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_RENOVA,'') NSZ_RENOVA, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_ADITIV,'') NSZ_ADITIV, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTADIT,'') NSZ_DTADIT, " + CRLF
	cQuery +=       " ISNULL(NSV.NSV_DESC,'') NSZ_DCLASS, " + CRLF
	cQuery +=       " ISNULL(NSW.NSW_DESC,'') NSZ_DSUBCL, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTCAPI,'') NSZ_DTCAPI, " + CRLF
	cQuery +=       " ISNULL(CTOCAP.CTO_SIMB,'') NSZ_DMOCAP, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VLCAPI,0) NSZ_VLCAPI, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VLACAO,0) NSZ_VLACAO, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTCONS,'') NSZ_DTCONS, " + CRLF
	cQuery +=       " ISNULL(RD0CON.RD0_SIGLA,'') || ' - ' || ISNULL(RD0CON.RD0_NOME,'') NSZ_DRESCO, " + CRLF
	cQuery +=       " ISNULL(NY0.NY0_DESC,'') NSZ_DESCON, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_MULTA,'') NSZ_MULTA, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTLANC,'') NSZ_DTLANC, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTASSI,'') NSZ_DTASSI, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_TPPROC,'') NSZ_TPPROC, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_SUBEST,'') NSZ_SUBEST, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_CSTATL,'') NSZ_CSTATL, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_CSITUL,'') NSZ_CSITUL, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTINLI,'') NSZ_DTINLI, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTFILI,'') NSZ_DTFILI, " + CRLF
	cQuery +=       " ISNULL(RD0LIC.RD0_SIGLA,'') || ' - ' || ISNULL(RD0LIC.RD0_NOME,'') NSZ_NOMRES, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTEMIS,'') NSZ_DTEMIS, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTCERT,'') NSZ_DTCERT, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_NUMLIC,'') NSZ_NUMLIC, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_NUMCON,'') NSZ_NUMCON, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTLICI,'') NSZ_DTLICI, " + CRLF
	cQuery +=       " ISNULL(CTOLIC.CTO_SIMB,'') NSZ_DMOLIC, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VLDOTA,0) NSZ_VLDOTA, " + CRLF
	cQuery +=       " ISNULL(NY4.NY4_DESC,'') NSZ_DMODLI, " + CRLF
	cQuery +=       " ISNULL(NY5.NY5_DESC,'') NSZ_DCRIJU, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTCONC,'') NSZ_DTCONC, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_IDENTI,'') NSZ_IDENTI, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_NUMREG,'') NSZ_NUMREG, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VAHIST,0) NSZ_VAHIST, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VCENVO,0) NSZ_VCENVO, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VJENVO,0) NSZ_VJENVO, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTULAT,'') NSZ_DTULAT, " + CRLF
	cQuery +=       " ISNULL(CC2.CC2_MUN,'') NSZ_DMUNIC, " + CRLF
	cQuery +=       " ISNULL(CC2.CC2_EST,'') NSZ_ESTADO, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_SOLICI,'') NSZ_SOLICI, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_LCORRE,'') NSZ_LCORRE, " + CRLF
	cQuery +=       " ISNULL(SA2.A2_NOME,'') NSZ_DCORRE, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VALOR,0) NSZ_VALOR, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VLPROV,0) NSZ_VLPROV, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VCPROV,0) NSZ_VCPROV, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VAPROV,0) NSZ_VAPROV, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_VJPROV,0) NSZ_VJPROV, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_SAPE,0) NSZ_SAPE, " + CRLF
	cQuery +=       " ISNULL(CTOPRO.CTO_SIMB,'') NSZ_DMOPRO, " + CRLF
	cQuery +=       " ISNULL(CTOVAL.CTO_SIMB,'') NSZ_DMOEDA, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTPROV,'') NSZ_DTPROV, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTUASJ,'') NSZ_DTUASJ, " + CRLF
	cQuery +=       " ISNULL(NSZ.NSZ_DTUASP,'') NSZ_DTUASP, " + CRLF
	cQuery +=       " NSZ.R_E_C_N_O_ RECNONSZ " + CRLF
	cQuery +=            " FROM " + RetSqlName("NQ3") + " NQ3 " + CRLF
	cQuery +=            " INNER JOIN " + RetSqlName("NSZ") + " NSZ ON ( " + CRLF
	cQuery +=               " NQ3.NQ3_FILORI = NSZ.NSZ_FILIAL AND " + CRLF
	cQuery +=               " NQ3.NQ3_CAJURI = NSZ.NSZ_COD AND " + CRLF
	cQuery +=               " NQ3.D_E_L_E_T_ = NSZ.D_E_L_E_T_ ) " + CRLF
	cQuery +=            " INNER JOIN " + RetSqlName("NYB") + " NYB ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_TIPOAS = NYB.NYB_COD AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NYB.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NYB.NYB_FILIAL = '"+xFilial("NYB")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("SA1") + " SA1 ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CCLIEN = SA1.A1_COD AND " + CRLF
	cQuery +=               " NSZ.NSZ_LCLIEN = SA1.A1_LOJA AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = SA1.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " SA1.A1_FILIAL = '"+xFilial("SA1")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NS7") + " NS7 ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CESCRI = NS7.NS7_COD AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NS7.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NS7.NS7_FILIAL = '"+xFilial("NS7")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NW7") + " NW7 ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CFCORR = NW7.NW7_COD AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NW7.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NW7.NW7_FILIAL = '"+xFilial("NW7")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NRB") + " NRB ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CAREAJ = NRB.NRB_COD AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NRB.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NRB.NRB_FILIAL = '"+xFilial("NRB")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("RD0") + " RD0ADV ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CPART2 = RD0ADV.RD0_CODIGO AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = RD0ADV.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " RD0ADV.RD0_FILIAL = '"+xFilial("RD0")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("RD0") + " RD0EST ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CPART3 = RD0EST.RD0_CODIGO AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = RD0EST.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " RD0EST.RD0_FILIAL = '"+xFilial("RD0")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NRL") + " NRL ON ( " + CRLF 
	cQuery +=               " NSZ.NSZ_CSUBAR = NRL.NRL_COD AND " + CRLF
	cQuery +=               " NSZ.NSZ_CAREAJ = NRL.NRL_CAREA AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NRL.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NRL.NRL_FILIAL = '"+xFilial("NRL")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NVE") + " NVE ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CCLIEN = NVE.NVE_CCLIEN AND " + CRLF
	cQuery +=               " NSZ.NSZ_LCLIEN = NVE.NVE_LCLIEN AND " + CRLF
	cQuery +=               " NSZ.NSZ_NUMCAS = NVE.NVE_NUMCAS AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NVE.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NVE.NVE_FILIAL = '"+xFilial("NVE")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("ACY") + " ACY ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CGRCLI = ACY.ACY_GRPVEN AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = ACY.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " ACY.ACY_FILIAL = '"+xFilial("ACY")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NUQ") + " NUQPROC ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CPRORI = NUQPROC.NUQ_CAJURI AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NUQPROC.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_FILIAL = NUQPROC.NUQ_FILIAL) " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NQO") + " NQO ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CRITO = NQO.NQO_COD AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NQO.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NQO.NQO_FILIAL = '"+xFilial("NQO")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NQ4") + " NQ4 ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_COBJET = NQ4.NQ4_COD AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NQ4.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NQ4.NQ4_FILIAL = '"+xFilial("NQ4")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NQ7") + " NQ7 ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CPROGN = NQ7.NQ7_COD AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NQ7.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NQ7.NQ7_FILIAL = '"+xFilial("NQ7")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NQ7") + " NQ7HIS ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CPRHIS = NQ7HIS.NQ7_COD AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NQ7HIS.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NQ7HIS.NQ7_FILIAL = '"+xFilial("NQ7")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("CTO") + " CTOCAU ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CMOCAU = CTOCAU.CTO_MOEDA AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = CTOCAU.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " CTOCAU.CTO_FILIAL = '"+xFilial("CTO")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("CTO") + " CTOENV ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CMOENV = CTOENV.CTO_MOEDA AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = CTOENV.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " CTOENV.CTO_FILIAL = '"+xFilial("CTO")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("CTO") + " CTOHIS ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CMOHIS = CTOHIS.CTO_MOEDA AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = CTOHIS.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " CTOHIS.CTO_FILIAL = '"+xFilial("CTO")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("CTO") + " CTOFIN ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CMOFIN = CTOFIN.CTO_MOEDA AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = CTOFIN.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " CTOFIN.CTO_FILIAL = '"+xFilial("CTO")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NQI") + " NQI ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CMOENC = NQI.NQI_COD AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NQI.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NQI.NQI_FILIAL = '"+xFilial("NQI")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("RD0") + " RD0SOC ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CPART1 = RD0SOC.RD0_CODIGO AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = RD0SOC.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " RD0SOC.RD0_FILIAL = '"+xFilial("RD0")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("CTT") + " CTT ON ( " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = CTT.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_CCUSTO = CTT.CTT_CUSTO AND " + CRLF
	cQuery +=               " CTT.CTT_FILIAL = '"+xFilial("CTT")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NSV") + " NSV ON ( " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NSV.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_CCLASS = NSV.NSV_COD AND " + CRLF
	cQuery +=               " NSV.NSV_FILIAL = '"+xFilial("NSV")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NSW") + " NSW ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CSUBCL = NSW.NSW_COD AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NSW.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSW.NSW_FILIAL = '"+xFilial("NSW")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("CTO") + " CTOCAP ON ( " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = CTOCAP.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_CMOCAP = CTOCAP.CTO_MOEDA AND " + CRLF
	cQuery +=               " CTOCAP.CTO_FILIAL = '"+xFilial("CTO")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("RD0") + " RD0CON ON ( " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = RD0CON.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_CRESCO = RD0CON.RD0_CODIGO AND " + CRLF
	cQuery +=               " RD0CON.RD0_FILIAL = '"+xFilial("RD0")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NY0") + " NY0 ON ( " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NY0.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_CODCON = NY0.NY0_COD AND " + CRLF
	cQuery +=               " NY0.NY0_FILIAL = '"+xFilial("NY0")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("RD0") + " RD0LIC ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CODRES = RD0LIC.RD0_CODIGO AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = RD0LIC.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " RD0LIC.RD0_FILIAL = '"+xFilial("RD0")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("CTO") + " CTOLIC ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CMOLIC = CTOLIC.CTO_MOEDA AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = CTOLIC.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " CTOLIC.CTO_FILIAL = '"+xFilial("CTO")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NY4") + " NY4 ON ( " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NY4.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_CMODLI = NY4.NY4_COD AND " + CRLF
	cQuery +=               " NY4.NY4_FILIAL = '"+xFilial("NY4")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NY5") + " NY5 ON ( " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NY5.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_CCRIJU = NY5.NY5_COD AND " + CRLF
	cQuery +=               " NY5.NY5_FILIAL = '"+xFilial("NY5")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("CC2") + " CC2 ON ( " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = CC2.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_CMUNIC = CC2.CC2_CODMUN AND " + CRLF
	cQuery +=               " NSZ.NSZ_ESTADO = CC2.CC2_EST AND " + CRLF
	cQuery +=               " CC2.CC2_FILIAL = '"+xFilial("CC2")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("SA2") + " SA2 ON ( " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = SA2.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_CCORRE = SA2.A2_COD AND " + CRLF
	cQuery +=               " NSZ.NSZ_LCORRE = SA2.A2_LOJA AND " + CRLF
	cQuery +=               " SA2.A2_FILIAL = '"+xFilial("SA2")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("CTO") + " CTOPRO ON ( " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = CTOPRO.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_CMOPRO = CTOPRO.CTO_MOEDA AND " + CRLF
	cQuery +=               " CTOPRO.CTO_FILIAL = '"+xFilial("CTO")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("CTO") + " CTOVAL ON ( " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = CTOVAL.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_CMOEDA = CTOVAL.CTO_MOEDA AND " + CRLF
	cQuery +=               " CTOVAL.CTO_FILIAL = '"+xFilial("CTO")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NT9") + " NT9 ON ( " + CRLF
	cQuery +=               " NT9.NT9_TIPOEN = '4' AND " + CRLF
	cQuery +=               " NT9.NT9_PRINCI = '1' AND " + CRLF
	cQuery +=               " NSZ.NSZ_COD = NT9.NT9_CAJURI AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NT9.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_FILIAL = NT9.NT9_FILIAL ) " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("CTO") + " CTOCON ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CMOCON = CTOCON.CTO_MOEDA AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = CTOCON.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " CTOCON.CTO_FILIAL = '"+xFilial("CTO")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("SE4") + " SE4 ON ( " + CRLF
	cQuery +=               " NSZ.NSZ_CCPCON = SE4.E4_CODIGO AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = SE4.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " SE4.E4_FILIAL = '"+xFilial("SE4")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("CC3") + " CC3 ON ( " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = CC3.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_CNAE = CC3.CC3_COD AND " + CRLF
	cQuery +=               " CC3.CC3_FILIAL = '"+xFilial("CC3")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NY6") + " NY6 ON ( " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NY6.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_CTIPMA = NY6.NY6_COD AND " + CRLF
	cQuery +=               " NY6.NY6_FILIAL = '"+xFilial("NY6")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NY7") + " NY7 ON ( " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NY7.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_CTIPMA = NY7.NY7_COD AND " + CRLF
	cQuery +=               " NY7.NY7_FILIAL = '"+xFilial("NY7")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NY8") + " NY8 ON ( " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NY8.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_CNATMA = NY8.NY8_COD AND " + CRLF
	cQuery +=               " NY8.NY8_FILIAL = '"+xFilial("NY8")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NY9") + " NY9 ON ( " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NY9.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_CAREAN = NY9.NY9_COD AND " + CRLF
	cQuery +=               " NY9.NY9_FILIAL = '"+xFilial("NY9")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("NYA") + " NYA ON ( " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = NYA.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " NSZ.NSZ_CTPSOL = NYA.NYA_COD AND " + CRLF
	cQuery +=               " NYA.NYA_FILIAL = '"+xFilial("NYA")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("SX5") + " SX5JY ON ( " + CRLF
	cQuery +=               " SX5JY.X5_TABELA = 'JY' AND " + CRLF
	cQuery +=               " NSZ.NSZ_CREGIO = SX5JY.X5_CHAVE AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = SX5JY.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " SX5JY.X5_FILIAL = '"+xFilial("SX5")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("SX5") + " SX5JZ ON ( " + CRLF
	cQuery +=               " SX5JZ.X5_TABELA = 'JZ' AND " + CRLF
	cQuery +=               " NSZ.NSZ_CDPSOL = SX5JZ.X5_CHAVE AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = SX5JZ.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " SX5JZ.X5_FILIAL = '"+xFilial("SX5")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("SX5") + " SX5J4 ON ( " + CRLF
	cQuery +=               " SX5J4.X5_TABELA = 'J4' AND " + CRLF
	cQuery +=               " NSZ.NSZ_CTPSOC = SX5J4.X5_CHAVE AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = SX5J4.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " SX5J4.X5_FILIAL = '"+xFilial("SX5")+"') " + CRLF
	cQuery +=            " LEFT OUTER JOIN " + RetSqlName("SX5") + " SX5J5 ON ( " + CRLF
	cQuery +=               " SX5J5.X5_TABELA = 'J5' AND " + CRLF
	cQuery +=               " NSZ.NSZ_CSBPRO = SX5J5.X5_CHAVE AND " + CRLF
	cQuery +=               " NSZ.D_E_L_E_T_ = SX5J5.D_E_L_E_T_ AND " + CRLF
	cQuery +=               " SX5J5.X5_FILIAL = '"+xFilial("SX5")+"') " + CRLF
	cQuery += " WHERE NQ3.NQ3_FILIAL = '" + xFilial("NQ3") + "' AND NQ3.NQ3_CUSER = '"+cUser+"' AND NQ3.NQ3_SECAO = '"+cThread+"' AND NQ3.D_E_L_E_T_ = ' '"
	cQuery += " ORDER BY NSZ_TIPOAS "
Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} JRelatorio()
Impressão de Relatórios SIGAJURI
Ferramenta TMSPrinter 
Uso Geral.

@param aSessaoAux - Dados da estrutura do layout do relatório
            aSessaoAux[1] - assunto jurídico
            aSessaoAux[2] - aSessao - Dados do conteúdo do relatório
            aSessaoAux[3] - aRelat  - Dados do título do relatório
            aSessaoAux[4] - aCabec  - Dados do cabeçalho do relatório

@param cQuery  Query Principal do Relatório
@param lAutomato define se vem da automação de testes
@param cNomerel  Nome do relatório
@param cCaminho  Caminho do arquivo quando chamado pelo TOTVS LEGAL
@param cJsonRel  Dados da gestão de relatório do Totvs Jurídico

@Return

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JRelatorio(aSessaoAux, cQuery, lAutomato, cNomerel, cCaminho, cJsonRel)
Local lHori     := .F.
Local lQuebPag  := .F.
Local lValor    := .F.
Local lTitulo   := .T. 
Local lLinTit   := .F.
Local lUltSes   := .T.
Local nX        := 0
Local nI        := 0    // Contador
Local nJ        := 0    // Contador
Local nLin      := 0    // Linha Corrente
Local nLinCalc  := 0    // Contator de linhas - usada para os cálculos de novas linhas
Local nLinCalc2 := 0
Local nLinFinal := 0
Local oPrint    := Nil
Local aDados    := {}
Local aSessao   := {}
Local aRelat    := {}
Local aCabec    := {}
Local TMP       := GetNextAlias()
Local lValores  := .F.
Local lO17      := FWAliasInDic('O17') .and. !Empty(cJsonRel)
Local oJsonRel  := NIL
Local cCpoTab   := ""
Local cCpoQry   := ""

Default lAutomato := .F.
Default cNomerel  := ""
Default cCaminho  := ""
Default cJsonRel  := ""

If (lO17)
	oJsonRel := JsonObject():New()
	oJsonRel:FromJson(cJsonRel)
EndIf

If !lAutomato
	oPrint := FWMsPrinter():New( cNomeRel, IMP_PDF,,, .T.,,, "PDF" ) // Inicia o relatório
Else
	oPrint := FWMsPrinter():New( cNomeRel, IMP_SPOOL,,, .T.,,,) // Inicia o relatório
	//Alterar o nome do arquivo de impressão para o padrão de impressão automatica
	oPrint:CFILENAME  := cNomeRel
	oPrint:CFILEPRINT := oPrint:CPATHPRINT + oPrint:CFILENAME
Endif

cQuery := ChangeQuery(cQuery)
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),TMP,.T.,.T.)

If lO17
	J288GestRel(oJsonRel)
	oJsonRel["O17_MIN"] := 0
	oJsonRel["O17_MAX"] := (TMP)->(ScopeCount())
	(TMP)->(DbGoTop())
Endif

If (TMP)->(!EOF())

	For nX := 1 To Len(aSessaoAux)

		aSessao := aSessaoAux[nX][2]
		aRelat  := aSessaoAux[nX][3][1]
		aCabec  := aSessaoAux[nX][4][1]

		While (TMP)->(!EOF()) .AND. Alltrim((TMP)->NSZ_TIPOAS) == Alltrim(aSessaoAux[nX][1])

			If lO17
				oJsonRel['O17_MIN']  := oJsonRel['O17_MIN']+1
				oJsonRel['O17_PERC'] := Round(oJsonRel['O17_MIN']*100/oJsonRel['O17_MAX'],0)
				J288GestRel(oJsonRel)
			Endif

			oPrint:EndPage() // Se for um novo assunto jurídico, encerra a página atual
			ImpCabec(@oPrint, @nLin, aRelat, aCabec, TMP) // Cria um novo cabeçalho
			nLinCalc := nLin // Inicia o controle das linhas impressas
			lTitulo := .T. // Indica que o título pode ser impresso 
			lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada

			For nI := 1 To Len(aSessao) // Inicia a impressão de cada sessão do relatório
				
				lValor := .F.
				lHori  := aSessao[nI][4]
				
				If !Empty(aSessao[nI][5]) // Nessa posição é indicada a query de um subreport
					lTitulo := .T. // Indica que o título pode ser impresso
					If aSessao[nI][1] $ cSesTotal // As sessões de Totalizadores de pedido/custas/garantias só serão impressos caso existam pedidos/custas/garantias impressos
						If lUltSes // Indica que a última sessão foi preenchida
							JImpSub(aSessao[nI][5], TMP, aSessao[nI],@nLinCalc,@lQuebPag, aRelat, aCabec, @oPrint, @nLin, @lTitulo, @lLinTit, @lUltSes) // Imprime os dados do subreport
						EndIf
					Else
						JImpSub(aSessao[nI][5], TMP, aSessao[nI],@nLinCalc,@lQuebPag, aRelat, aCabec, @oPrint, @nLin, @lTitulo, @lLinTit, @lUltSes) // Imprime os dados do subreport
					EndIf
					lTitulo := .T. // Indica que o título pode ser impresso
				Else

					nLinCalc2 := nLinCalc // Backup da próxima linha a ser usada, pois na função JDadosCpo abaixo a variavel tem seu conteúdo alterado para
										// que seja realizada uma simulação das linhas usadas para impressão do conteúdo. 

					nLinFinal := 0 // Limpa a variável

					For nJ := 7 to Len(aSessao[nI]) // Lê as informações de cada campo a ser impresso. O contador começa em 6 pois é a partir dessa posição que estão as informações sobre o campo
						cTabela  := aSessao[nI][nJ][2] //Tabela
						cCpoTab  := aSessao[nI][nJ][3] //Nome do campo na tabela
						cCpoQry  := aSessao[nI][nJ][4] //Nome do campo na query
						cTipo    := aSessao[nI][nJ][5] //Tipo do campo
						
						If (TMP)->(FieldPos(cCpoQry)) > 0 .And. SubStr(AllTrim(cCpoQry),1,3) <> "NUQ" 
						
							cValor := JTrataVal(cTabela,cCpoTab,cCpoQry,cTipo,TMP,,.F.) // Retorna o conteúdo/valor a ser impresso. Chama essa função para tratar o valor caso seja um memo ou data
							If !lValor .And. !Empty(AllTrim(cValor)) .AND. AllTrim(cValor) > '0,00'
								lValor := .T.
							EndIf
							aAdd(aDados,JDadosCpo(aSessao[nI][nJ],cValor,@nLinCalc,@lQuebPag)) // Título e conteúdo de cada campo são inseridos do array com os dados para serem impressos abaixo

						ElseIf (TMP)->(FieldPos(cCpoQry)) > 0 .And. SubStr(AllTrim(cCpoQry),1,3) == "NUQ"
							cValor := JTrataVal(cTabela,cCpoTab,cCpoQry,cTipo,TMP,,.F.) // Retorna o conteúdo/valor a ser impresso. Chama essa função para tratar o valor caso seja um memo ou data
							aAdd(aDados,JDadosCpo(aSessao[nI][nJ],cValor,@nLinCalc,@lQuebPag)) // Título e conteúdo de cada campo são inseridos do array com os dados para serem impressos abaixo

						EndIf
					Next 
		
					nLinCalc := nLinCalc2 // Retorno do valor original da variável
					
					If nI > 1 // Inclui uma linha em branco no final de cada sessão do relatório principal, desde que não seja a primeira sessão 
						nLin += nSalto
					EndIf		
					
					If lTitulo .And. !Empty(aSessao[nI][1])
						If (nLin + 80) >= nFimL // Verifica se o título da sessão cabe na página
							oPrint:EndPage() // Se for maior, encerra a página atual
							ImpCabec(@oPrint, @nLin, aRelat, aCabec, TMP) // Cria um novo cabeçalho
							nLinCalc := nLin // Inicia o controle das linhas impressas
							lTitulo := .T. // Indica que o título pode ser impresso 
							lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
						EndIf
						If lValor // Se existir valor a ser impresso na sessão imprime o título da sessão.
							JImpTitSes(@oPrint, @nLin, @nLinCalc, aSessao[nI]) //Imprime o título da sessão no relatório
						EndIf
					EndIf
					
					If !lHori // Caso a impressão dos títulos seja na vertical - Todos os títulos na mesma linha e os conteúdos vem em colunas abaixo dos títulos (Ex: Relatório de andamentos)
						// Os títulos devem ser impressos
						lTitulo := .T. // Indica que o título pode ser impresso 
						lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
					EndIf
					
					//Imprime os campos do relatório
					If(aSessao[nI][1] = STR0005 /*"Valores"*/)
						lValores := .T.
					EndIf

					JImpRel(aDados,@nLin,@nLinCalc,@oPrint, @nLinFinal,lHori, @lTitulo, @lLinTit, aRelat, aCabec, .F., TMP, lValores)
					
					//Limpa array de dados
					aSize(aDados,0)
					aDados := {}
		
					If nLinFinal > 0
						nLinCalc := nLinFinal //Indica a maior refência de uso de linhas para que sirva como referência para começar a impressão do próximo registro
					EndIf
					
					nLinFinal := 0 // Limpa a variável
					
					nLin := nLinCalc//+nSalto //Recalcula a linha de referência para impressão

				EndIf

			Next

			oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório
			oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório
			
			nLin += nSalto //Adiciona uma linha em branco após a linha impressa
			nLinCalc := nLin
			
			(TMP)->(DbSkip())
		End
	Next nX


	(TMP)->(dbCloseArea())

	aSize(aDados,0)  //Limpa array de dados
	aSize(aRelat,0)  //Limpa array de dados do relatório
	aSize(aCabec,0)  //Limpa array de dados do cabeçalho do relatório
	aSize(aSessao,0) //Limpa array de dados das sessões do relatório

	oPrint:EndPage() // Finaliza a página

	If !lAutomato
		If Empty(cCaminho)
			oPrint:CFILENAME  := Replace(AllTrim(cNomeRel),'.','') + '-' + SubStr(AllTrim(Str(ThreadId())),1,4) + RetCodUsr() + StrTran(Time(),':','') + '.rel'
			oPrint:CFILEPRINT := oPrint:CPATHPRINT + oPrint:CFILENAME
		Else
			oPrint:CFILENAME  := cNomeRel
			oPrint:CFILEPRINT := cCaminho + cNomeRel
		EndIf
	Endif

	oPrint:Print()

	If !lAutomato .And. Empty(cCaminho)
		FErase(oPrint:CFILEPRINT)
	Endif

	lRelOk := FILE(cCaminho + cNomeRel)

	If lO17 .AND. !lRelOk
		oJsonRel['O17_DESC']   := STR0036 // "Não foi possível gerar o relatório."
		oJsonRel['O17_STATUS'] := "1" // Erro
		J288GestRel(oJsonRel)
	Endif

EndIf

Return(Nil)

//-------------------------------------------------------------------
/*/{Protheus.doc} ImpCabec()
Imprime cabeçalho do relatório
 
Uso Geral.

@param oPrint  Objeto do Relatório
        nLin    Linha Corrente
        aRelat  Dados do título do relatório
        aCabec  Dados do cabeçalho do relatório

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function ImpCabec(oPrint, nLin, aRelat, aCabec, TMP)
Local cTit       := aRelat[1] // Título
Local nColTit    := aRelat[2] // Posição da Título
Local oFontTit   := aRelat[3] // Fonte do Título
Local cTitulo    := ""
Local cValor     := ""
Local nPosValor  := 0
Local nSaltoCabe := 40
Local nI         := 0
Local oFontValor
Local oFontRoda  := TFont():New("Arial",,-8,,.F.,,,,.T.,.F.) // Fonte usada no Rodapé

If aRelat[4] == "R"
	oPrint:SetPortrait()  // Define a orientação do relatório como retrato (Portrait).
Else
	oPrint:SetLandscape() // Define a orientação do relatório como paisagem (Landscape).
EndIf

oPrint:SetPaperSize(9) //A4 - 210 x 297 mm

// Inicia a impressao da pagina
oPrint:StartPage()
If lNumPag // Imprime número de páginas?
	oPrint:Say( nFimL, nColFim - 100, alltochar(oPrint:NPAGECOUNT), oFontRoda )
EndIf
oPrint:Line( nSaltoCabe, nColIni, nSaltoCabe, nColFim ) // Imprime uma linha na horizontal no relatório
oPrint:Line( nSaltoCabe, nColIni, nSaltoCabe, nColFim ) // Imprime uma linha na horizontal no relatório
nLin := 90

// Imprime o cabecalho
oPrint:Say( nLin, nColTit, cTit, oFontTit ) // Título do relatório
oPrint:Say( nLin, 2110   , IIf(Empty(AllTrim((TMP)->(NSZ_CPRORI))),STR0023,STR0030), oFontTit ) // Principal ou Incidente

If Len(aCabec) > 0
	For nI := 1 to Len(aCabec)
		cTitulo    := aCabec[nI][1] // Título
		cValor     := aCabec[nI][2] // Conteúdo
		If cValor == "CAJURI"
			cValor := (TMP)->(NSZ_COD)
		EndIf
		nPosValor  := aCabec[nI][3] // Posição do conteúdo (considere 20,5 para cada caractere do título, ou seja se o título tiver 6 caracteres indique 6x20,5 = 123. Indique esse número para todos os itens do cabeçalho, para que todos tenham o mesmo alinhamento. Para isso considere sempre a posição da maior descrição)
		oFontTit   := aCabec[nI][4] // Fonte do título
		oFontValor := aCabec[nI][5] // Fonte do conteúdo
		oPrint:Say( nLin += nSaltoCabe, 070                        , cTitulo + ":" , oFontTit   ) //Imprime o Título
		oPrint:Say( nLin              , nPosValor + (nTamCarac * 4), cValor        , oFontValor ) //Imprime o Conteúdo - Esse (nTamCarac * 4) é para dar um espaço de 4 caracteres a mais do que o tamanho da descrição
	Next
EndIf

//nLin+=2*nSaltoCabe // Inclui duas linhas em branco após a impressão do cabeçalho
nLin+=20
oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório
oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório

nLin+=40 //Recalcula a linha de referência para impressão

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} JTrataVal()
Trata os tipos de campos e imprime os valores
 
Uso Geral.

@param cTabela  Nome da tabela
        cCpoTab  Nome do campo na tabela
        cCpoQry  Nome do campo na query
        cTipo    Tipo do campo
        TMP      Alias da Query Principal
        SUB      Alias da Query do SubReport
        lSub     Indica se é um SubReport

@return cValor Valor do campo na Query

@author Jorge Luis Branco Martins Junior
@since 15/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JTrataVal(cTabela,cCpoTab,cCpoQry,cTipo,TMP,SUB,lSub)
Local cValor := ""
Local cParam := "TT"
Local cPicture := ""
Local lPicture := .F.

	// Tratamento para campos específicos
	If "J095SalAtu" $ cCpoQry
		If "TTSA" $ cCpoQry
			cParam := "TTSA"
		EndIf

		cValor   := TRANSFORM(J095SalAtu(AllTrim((SUB)->&(cCpoTab)), cParam), JURX3INFO("NT2_VALOR","X3_PICTURE"))
		cValor   := AllTrim(CVALTOCHAR(cValor)) //Conteúdo a ser gravado
	ElseIf cCpoQry == "J095CodEnt"
		cValor := AllTrim(AllToChar(J095Entida(1,AllTrim(AllToChar((SUB)->&(cCpoTab))),(SUB)->(NT9_CEMPCL),(SUB)->(NT9_CFORNE),(SUB)->(NT9_CODENT))))
	ElseIf cCpoQry == "J095LojEnt"
		cValor := AllTrim(AllToChar(J095Entida(1,AllTrim(AllToChar((SUB)->&(cCpoTab))),(SUB)->(NT9_LOJACL),(SUB)->(NT9_LFORNE))))
	ElseIf cCpoQry == "ENTIDADE"
		cValor := AllTrim(AllToChar(J095Entida(2,AllTrim(AllToChar((SUB)->&(cCpoTab))))))
	ElseIf cCpoQry == "NT9_CGC"
		cPicture := JURM1((SUB)->(NT9_TIPOP))
		cPicture := SUBSTR(cPicture,1,Len(cPicture)-2)
		cValor   := TRANSFORM(AllTrim((SUB)->&(cCpoQry)), cPicture)
		cValor   := AllTrim(CVALTOCHAR(cValor)) //Conteúdo a ser gravado
	Else
		// Tratamento em subreports
		If lSub
			If cTipo == "D" // Tipo do campo
				TCSetField(SUB, cCpoQry 	, "D") //Muda o tipo do campo para data.
				cValor   := AllTrim(AllToChar((SUB)->&(cCpoQry))) //Conteúdo a ser gravado
			ElseIf cTipo == "M"
				DbSelectArea(cTabela)
				(cTabela)->(dbGoTo((SUB)->&(cCpoQry))) // Esse seek é para retornar o valor de um campo MEMO
				cValor := AllTrim(  " " + (cTabela)->&(cCpoTab) ) //Retorna o valor do campo
			ElseIf cTipo == "N"
				TcSetField( SUB, cCpoQry, 'N', TamSX3(cCpoTab)[1], TamSX3(cCpoTab)[2] )
				cPicture := JURX3INFO(cCpoTab,"X3_PICTURE")
				lPicture := Iif(Empty(cPicture),.F.,.T.)
				If lPicture
					cValor   := TRANSFORM((SUB)->&(cCpoQry), cPicture)
					cValor   := AllTrim(CVALTOCHAR(cValor)) //Conteúdo a ser gravado
				Else
					cValor := AllTrim(CVALTOCHAR((SUB)->&(cCpoQry)))
				EndIf
			ElseIf cTipo == "O" // Lista de opções
				cValor := JTrataCbox( cCpoTab, AllTrim(AllToChar((SUB)->&(cCpoQry))) ) //Retorna o valor do campo
			Else
				cPicture := JURX3INFO(cCpoTab,"X3_PICTURE")

				If "@S" $ cPicture  //Tratamento para não limitar o tamanho do campo pela picture do dicionário
					lPicture := .F.
				Else
					lPicture := Iif(Empty(cPicture),.F.,.T.)
				EndIf
				
				If lPicture
					cValor := TRANSFORM((SUB)->&(cCpoQry), cPicture)
					cValor := AllTrim(cValor)
				Else
					cValor := AllTrim((SUB)->&(cCpoQry))
				EndIf

				If cCpoQry == "NOMEPRINCI" .And. AllTrim(AllToChar((SUB)->&(NT9_PRINCI))) == "1"
					cValor += " ("+STR0023+")" // Principal
				ElseIf cCpoQry == "TELEFONE"
					cValor := AllTrim(AllToChar((SUB)->&(NT9_DDD))) + ' ' + cValor
				EndIf
			EndIf
		Else
			//Tratamento na query principal
			If cTipo == "D" // Tipo do campo
				TCSetField(TMP, cCpoQry 	, "D") //Muda o tipo do campo para data.
				cValor   := AllTrim(AllToChar((TMP)->&(cCpoQry))) //Conteúdo a ser gravado
			ElseIf cTipo == "M"
				DbSelectArea(cTabela)
				(cTabela)->(dbGoTo((TMP)->&(cCpoQry))) // Esse seek é para retornar o valor de um campo MEMO
				cValor := AllTrim((cTabela)->&(cCpoTab)) //Retorna o valor do campo
			ElseIf cTipo == "N"
				TcSetField( TMP, cCpoQry, 'N', TamSX3(cCpoTab)[1], TamSX3(cCpoTab)[2] )
				cPicture := JURX3INFO(cCpoTab,"X3_PICTURE")
				lPicture := Iif(Empty(cPicture),.F.,.T.)
				If lPicture
					cValor   := TRANSFORM((TMP)->&(cCpoQry), cPicture)
					cValor   := AllTrim(CVALTOCHAR(cValor)) //Conteúdo a ser gravado
				Else
					cValor := AllTrim(CVALTOCHAR((TMP)->&(cCpoQry)))
				EndIf
			ElseIf cTipo == "O" // Lista de opções
				cValor := JTrataCbox( cCpoTab, AllTrim(AllToChar((TMP)->&(cCpoQry))) ) //Retorna o valor do campo
			Else
				cPicture := JURX3INFO(cCpoTab,"X3_PICTURE")
				lPicture := Iif(Empty(cPicture),.F.,.T.)
				If lPicture
					cValor   := TRANSFORM((TMP)->&(cCpoQry), cPicture)
					cValor   := AllTrim(CVALTOCHAR(cValor)) //Conteúdo a ser gravado
				Else
					cValor := AllTrim(AllToChar((TMP)->&(cCpoQry)))
				EndIf
			EndIf
		EndIf
	EndIf

Return cValor

//-------------------------------------------------------------------
/*/{Protheus.doc} JImpSub()
Imprime um subreport
 
Uso Geral.

@param cQuerySub Query do subreport
        TMP        Alias da query principal
        aSessao   Array com estrutura do subreport
        nLinCalc  Variável de controle de linhas usadas
        lQuebPag  Indica se é necessário ocorrer a quebra de pagina
        aRelat    Array com dados do relatório (Usado na impressão do cabeçalho)
        aCabec    Array com dados do cabeçalho (Usado na impressão do cabeçalho)
        oPrint    Objeto TMSPrinter (Estrutura do relatório)
        nLin      Linha Atual
        lTitulo   Indica que o título pode ser impresso
        lLinTit   Indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
        lUltSes   Indica que a sessão atual possuí registros - Será usada na construção da próxima sessão

@return

@author Jorge Luis Branco Martins Junior
@since 18/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JImpSub(cQuerySub, TMP, aSessao, nLinCalc,lQuebPag, aRelat, aCabec, oPrint, nLin, lTitulo, lLinTit, lUltSes)
Local nJ           := 0
Local xValor       // Valor do campo
Local nConta       := 0
Local nLinFinal    := 0
Local cValor       := ""
Local cHeadAgrup   := ""
Local cVar         := ""  // CAMPO
Local lTitSes      := .F. // Indica se já imprimiu o título da sessão
Local lHeaderAgrup := .F. // Indica se contém agrupamentos de informações
Local aDados       := {}
Local cTitSes      := aSessao[1]
Local lHori        := aSessao[4]
Local lIncLin      := aSessao[6] //Indica se deve incluir linha antes da impressão da sessão - Usado para sessões de totalizadores
Local cTxt         := cQuerySub
Local SUB          := GetNextAlias()
Local lNext        := .T.
Local lPulaCto     := .F.

While RAT("#@", cTxt) > 0 // Substitui os nomes dos campos passados na query por seus respectivos valores
	cVar     := SUBSTR(cTxt,AT("@#", cTxt) + 2,AT("#@", cTxt) - (AT("@#", cTxt) + 2))
	xValor   := (TMP)->(FieldGet(FieldPos(cVar)))
	cTxt     := SUBSTR(cTxt, 1,AT("@#", cTxt)-1) + ALLTRIM(xValor) + SUBSTR(cTxt, AT("#@", cTxt)+2)
End

cQuerySub := cTxt
cQuerySub := ChangeQuery(cQuerySub)
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuerySub),SUB,.T.,.T.)

lUltSes := .F.

If (SUB)->(!EOF()) .And. lIncLin
	If nLin+80 >= nFimL // Verifica se a linha corrente é maior que linha final permitida por página
		oPrint:EndPage() // Se for maior, encerra a página atual
		ImpCabec(@oPrint, @nLin, aRelat, aCabec, TMP) // Cria um novo cabeçalho
		nLinCalc := nLin // Inicia o controle das linhas impressas
		lTitulo := .T. // Indica que o título pode ser impresso 
		lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
	EndIf
	oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório
	oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório
	nLin += 30 //Adiciona uma linha em branco após a linha impressa
	nLinCalc := nLin
EndIf

While (SUB)->(!EOF())
	lHeaderAgrup := Iif(cTitSes $ (STR0017+"|"+STR0018+"|"+STR0019+"|"+STR0020)/*"Garantias|Alvarás|Custas|Detalhamento Envolvidos"*/,.T.,.F.) //Indica se contém agrupamentos de informações
	lUltSes := .T. //Indica que a sessão atual tem registros - Usada na construção da próxima sessão
	If nLin+80 >= nFimL // Verifica se a linha corrente é maior que linha final permitida por página
		oPrint:EndPage() // Se for maior, encerra a página atual
		ImpCabec(@oPrint, @nLin, aRelat, aCabec,TMP) // Cria um novo cabeçalho
		nLinCalc := nLin // Inicia o controle das linhas impressas
		lTitulo := .T. // Indica que o título pode ser impresso 
		lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
	EndIf
		//nLin += nSalto
		nLinCalc := nLin
		nLinCalc2 := nLinCalc // Backup da próxima linha a ser usada, pois na função JDadosCpo abaixo a variavel tem seu conteúdo alterado para
		                      // que seja realizada uma simulação das linhas usadas para impressão do conteúdo. 
		
		For nJ := 7 to Len(aSessao) // Lê as informações de cada campo a ser impresso. O contador começa em 7 pois é a partir dessa posição que estão as informações sobre o campo
			
			nLinFinal := 0 // Limpa a variável
			lNext := .T.
			
			cTabela  := aSessao[nJ][2] //Tabela
			cCpoTab  := aSessao[nJ][3] //Nome do campo na tabela
			cCpoQry  := aSessao[nJ][4] //Nome do campo na query
			cTipo    := aSessao[nJ][5] //Tipo do campo
			
			If  ( (SUB)->(FieldPos(cCpoTab)) > 0 .Or. (SUB)->(FieldPos(cCpoQry)) > 0 )   
				cValor   := JTrataVal(cTabela,cCpoTab,cCpoQry,cTipo,,SUB,.T.) // Retorna o conteúdo/valor a ser impresso. Chama essa função para tratar o valor caso seja um memo ou data
			
				If (cCpoTab == "NT2_VCPROV" .OR. cCpoTab == "NT2_VJPROV") .AND. AllTrim(cValor) == '0,00'
					lPulaCto := .T.
				endIf

				If cCpoTab == "CTO_SIMB" .AND. lPulaCto
					lPulaCto := .F.
					lNext    := .F.
				endif

				If lHeaderAgrup .AND. lNext
					lHeaderAgrup := .F.
					If Empty(cHeadAgrup) .Or. AllTrim(cHeadAgrup) <> AllTrim(cValor)
						cHeadAgrup := cValor
						aAdd(aDados,JDadosCpo(aSessao[nJ],cValor,@nLinCalc,@lQuebPag)) // Título e conteúdo de cada campo são inseridos do array com os dados para serem impressos abaixo
					EndIf
				Else
					If lNext
						aAdd(aDados,JDadosCpo(aSessao[nJ],cValor,@nLinCalc,@lQuebPag)) // Título e conteúdo de cada campo são inseridos do array com os dados para serem impressos abaixo
					EndIf
				EndIf
			EndIf
		Next
		
		nLinCalc := nLinCalc2 // Retorno do valor original da variável

		If lTitulo .And. (!Empty(cTitSes) .And. !(cTitSes $ "Env|TotalPed|TotalCus|TotalGar|TotalO0W")) // As sessões indicadas na condição não terão seus títulos impressos
			If (nLin + 80) >= nFimL // Verifica se o título da sessão cabe na página
				oPrint:EndPage() // Se for maior, encerra a página atual
				ImpCabec(@oPrint, @nLin, aRelat, aCabec,TMP) // Cria um novo cabeçalho
				nLinCalc := nLin // Inicia o controle das linhas impressas
				lTitulo := .T. // Indica que o título pode ser impresso 
				lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
			EndIf
			If !lTitSes
				JImpTitSes(@oPrint, @nLin, @nLinCalc, aSessao) //Imprime o título da sessão no relatório
				lTitSes := .T.
			EndIf
		EndIf

		If !lHori // Caso a impressão dos títulos seja na vertical - Todos os títulos na mesma linha e os conteúdos vem em colunas abaixo dos títulos (Ex: Relatório de andamentos)
			// Os títulos devem ser impressos
			lTitulo := .T. // Indica que o título pode ser impresso 
			lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
		EndIf

		//Sessões que são na vertical e aparecem o título somente no topo uma única vez, e não registro a registro
		If cTitSes $ "Env|" + STR0011 + "|" + STR0010 + "|" + STR0034 + "|" + STR0035 + "|" + STR0004 + "|" + STR0037 .And. nConta > 0	//Objetos | Custas | Incidentes | Vinculados | Relacionados | Pedidos
			lTitulo := .F.
			lLinTit := .T.
		Else
			nConta  := 1
		EndIf

		//Imprime os campos do relatório
		JImpRel(aDados,@nLin,@nLinCalc,@oPrint, @nLinFinal,lHori, @lTitulo, @lLinTit, aRelat, aCabec, .F., TMP)
		
		//Limpa array de dados
		aSize(aDados,0)
		aDados := {}

		If nLinFinal > 0
			nLinCalc := nLinFinal //Indica a maior refência de uso de linhas para que sirva como referência para começar a impressão do próximo registro
		EndIf
		
		nLinFinal := 0 // Limpa a variável
		
		nLin := nLinCalc
	
	(SUB)->(DbSkip())
End

aSize(aDados,0)

(SUB)->(dbCloseArea())

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} JDadosCpo()
Função para montar array de dados dos campos a serem impressos
 
Uso Geral.

@param aSessao   Dados do conteúdo do relatório
        cValor    Conteúdo a ser impresso
        nLinCalc  Variável de controle de linhas usadas
        lQuebPag  Indica se é necessário ocorrer a quebra de pagina

@return cValor Valor do campo na Query

@author Jorge Luis Branco Martins Junior
@since 18/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JDadosCpo(aSessao,cValor,nLinCalc,lQuebPag)
Local aDados    := {}
Local lQuebLin  := .F.
Local cTitulo   := ""
Local nPos      := 0
Local nQtdCar   := 0
Local nPosValor := 0
Local nPosTit   := 0
Local oFontVal
Local oFontTit

	cTitulo  := aSessao[1] //Título da Coluna
	nPosTit  := aSessao[6] //Indica a coordenada horizontal em pixels ou caracteres
	oFontTit := aSessao[8] //Fonte do título
	nPos     := aSessao[6] //Indica a coordenada horizontal para imprimir o valor do campo
	nQtdCar  := aSessao[7] //Quantidade de caracteres para que seja feita a quebra de linha
	oFontVal := aSessao[9] //Fonte usada para impressão do conteúdo
	nPosValor:= aSessao[10] //Fonte usada para impressão do conteúdo
	lQuebLin := aSessao[11] //Indica se deve existir a quebra de linha

	If !lQuebPag // Verifica se será necessária quebra de página para essa sessão
		lQuebPag := ((Int((Len(cValor)/nQtdCar) + 1) * nSalto) + nLinCalc) > nFimL
		nLinCalc += (Int((Len(cValor)/nQtdCar) + 1) * nSalto) // Indica a linha que será usada para cada valor quando forem impressos - Usado apenas para uma simulação.
	EndIf

	aDados := {cTitulo, nPosTit, oFontTit, cValor, nQtdCar, oFontVal, nPos, nPosValor, lQuebLin}

Return aDados

//-------------------------------------------------------------------
/*/{Protheus.doc} JImpRel(aDados)
Realiza a impressão dos dados no relatório
 
Uso Geral.

@param aDados Array com dados dos campos a serem impressos
        nLin   Linha Atual
        nLinCalc  Variável de controle de linhas usadas
        oPrint    Objeto TMSPrinter (Estrutura do relatório)
        nLinFinal Última Linha usada para escrever o conteúdo atual- Controle de linhas
        lHori     Indica se a impressão é na horizontal
                   Impressão na horizontal -> título e descrição na mesma linha (Ex: Data: 01/01/2016)
                   Impressão na vertical -> Todos os títulos na mesma linha e os conteúdos vem em colunas abaixo dos títulos (Ex: Data 01/01/2016 )
        lTitulo   Indica que o título pode ser impresso
        lLinTit   Indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
        aRelat    Dados do título do relatório
        aCabec    Dados do cabeçalho do relatório
        lSalta    Indica se é continuação de um conteúdo em outra página (conteúdo que não coube em uma página e precisou continuar na próxima)
        TMP       Variável temporária para armazenar o alias do conteúdo a ser impresso
        lValores  Determina que a linha não será quebrada na seção de valores

@return 

@author Jorge Luis Branco Martins Junior
@since 18/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JImpRel(aDados,nLin,nLinCalc,oPrint,nLinFinal,lHori, lTitulo, lLinTit, aRelat, aCabec, lSalta, TMP, lValores)
Local nJ         := 0
Local lQuebLin   := .F.
Local lImpTit    := .T.
Local cTitulo    := ""
Local cValor     := ""
Local nPosTit    := 0
Local nPos       := 0
Local nQtdCar    := 0
Local nPosValor  := 0
Local nLinTit    := 0
Local nLinAtu    := 0
Local aSobra     := aClone(aDados)
Local oFontTit   := 	NIL
Local oFontVal   := 	NIL

Default lSalta   := .F.
Default lHori    := .T.
Default lValores := .F.

	aEval(aSobra,{|x| x[4] := ""}) // Limpa a posição de conteúdo/valor dos campos no array de sobra, pois ele é preenchido com os dados do array aDados. Limpa para que seja preenchido com o conteúdo da sobra. 

	If lSalta // Se for continuação de impressão do conteúdo que não coube na página anterior 
		lImpTit := .F. // Indica que os títulos não precisam ser impressos
		lSalta  := .F. // Limpa variável
	EndIf

	For nJ := 1 to Len(aDados)
		cTitulo  := aDados[nJ][1] //Título da Coluna
		nPosTit  := aDados[nJ][2] //Indica a coordenada horizontal em pixels ou caracteres
		oFontTit := aDados[nJ][3] //Fonte do título
		cValor   := aDados[nJ][4] //Valor a ser impresso
		nQtdCar  := aDados[nJ][5] //Quantidade de caracteres para que seja feita a quebra de linha
		oFontVal := aDados[nJ][6] //Fonte usada para impressão do conteúdo
		nPos     := aDados[nJ][7] //Indica a coordenada horizontal para imprimir o valor do campo
		nPosValor:= aDados[nJ][8] + nPos //Indica a coordenada horizontal para imprimir o valor do campo
		lQuebLin := aDados[nJ][9] // Indica se deve existir quebra de linha após a impressão do campo

		// Se o valor for '0,00' não imprime a moeda
		If ( !Empty(AllTrim(cValor)) .AND. AllTrim(cValor) == '0,00' ) ;
			.And. (nJ < Len(aDados) .And. Empty(aDados[nj+1][1]))

			aDados[nJ+1][4] := "0,00"
		EndIf

		If lLinTit .Or. ( !Empty(AllTrim(cValor)) .AND. AllTrim(cValor) > '0,00' )	//Quando a Sessões é na vertical e o título aparece somente no topo, ou tem valor insere o titulo
			If lHori// Impressão na horizontal -> título e descrição na mesma linha (Ex: Data: 01/01/2016)
				If lImpTit
					nLinTit  := nLin
					nLinCalc := nLin
					oPrint:Say( nLinTit, nPosTit, cTitulo, oFontTit)// Imprime os títulos das colunas
				EndIf
			Else // Impressão na vertical -> Todos os títulos na mesma linha e os conteúdos vem em colunas abaixo dos títulos (Ex: Data
				//                                                                                                                01/01/2016 )
				
				If !Empty(cTitulo) .And. lImpTit // Essa variável indica se deve imprimir o título dos campos - Será .F. somente quando ocorrer quebra de um conteúdo em mais de uma página (lSalta == .T.).
					If !lLinTit // Como a linha onde será impresso o título dos campos ainda não foi definida entrará nessa condição
						nLinTit  := nLin
						nLin     += nSalto
						nLinCalc := nLin
						lLinTit := .T. // Indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
					EndIf
					
					If lTitulo // Indica que o título pode ser impresso
						oPrint:Say( nLinTit, nPosTit, cTitulo, oFontTit)// Imprime os títulos das colunas
						
						lTitulo := Len(aDados) <> nJ // Enquanto estiver preenchendo os títulos indica .T., para que os outros títulos sejam impressos. 
													// Após o preenchimento do último título indica .F., não premitindo mais a impressão dos títulos nessa página.
													
						// Deve imprimir apenas uma vez por página para que a letra não fique mais grossa.
						// Se não tiver esse tratamento a impressão será feita várias vezes sobre a mesma palavra devido as condições do laço, 
						// fazendo com que a grossura das letras nas palavras aumente e isso atrapalha.
						
					EndIf
				EndIf
				nPosValor := nPosTit // Indica que a posição (coluna) do conteúdo/valor a ser impresso é a mesma que foi impresso o titulo, ou seja, o conteúdo/valor ficará logo abaixo do título
			
			EndIf
			nLinAtu := nLinCalc // Controle de linhas usadas para imprimir o conteúdo atual
			JImpLin(@oPrint,@nLinAtu,nPosValor,cValor,oFontVal,nQtdCar,@aSobra[nJ], @lSalta, lImpTit) //Imprime as linhas com os conteúdos/valores
		ElseIf (lValores .And. lQuebLin .And. (nLin > nLinAtu))
			lQuebLin := .F.
		EndIf
		
		// Verifica qual campo precisou de mais linhas para ser impresso
		// para usar esse valor como referência para começar a impressão do próximo registro
		If nLinAtu > nLinFinal
			nLinFinal := nLinAtu
		EndIf

		If lSalta .And. lQuebLin // Se precisa continuar a impressão do conteúdo atual na próxima página 
			oPrint:EndPage() // Finaliza a página atual
			ImpCabec(@oPrint, @nLin, aRelat, aCabec, TMP) // Cria um novo cabeçalho na próxima página
			nLinCalc  := nLin // Inicia o controle das linhas a serem impressas
			nLinAtu   := nLinCalc // Atualiza variável linha atual
			lQuebPag  := .F. // Indica que não é necessário ocorrer a quebra de pagina, pois já está sendo quebrada nesse momento.
			lTitulo   := .T. // Indica que o título pode ser impresso 
			lLinTit   := .F. // Indica que a linha de impressão do título precisa ser definida, pois iniciará uma nova linha.
			nLinFinal := 0 // Limpa variável de controle da última linha impressa.
			
			// Imprime o restante do conteúdo que não coube na página anterior.
			JImpRel(aSobra,@nLin,@nLinCalc,@oPrint, @nLinFinal,lHori, @lTitulo, @lLinTit, aRelat, aCabec, @lSalta, TMP)
			aEval(aSobra,{|x| x[4] := ""})
		EndIf
		If lQuebLin // Indica que é necessária quebra de linha, ou seja, o próximo campo será impresso na próxima linha
			If nLinFinal >= nLin // Se a próxima linha a ser impressa (nLin) for menor que a última linha que tem conteúdo impresso (nLinFinal)
				nLin     := nLinFinal // Deve-se indicar a maior referência
			Else
				nLin     += nSalto // Caso contrário, pule uma linha.
			EndIf
			
			If nLin >= nFimL
				oPrint:EndPage() // Se for maior, encerra a página atual
				ImpCabec(@oPrint, @nLin, aRelat, aCabec, TMP) // Cria um novo cabeçalho
				nLinCalc := nLin // Inicia o controle das linhas impressas
				lTitulo := .T. // Indica que o título pode ser impresso 
				lLinTit := .F. // Indica que a linha de impressão do título precisa ser definida, pois iniciará uma nova linha.
				nLinFinal := 0 // Limpa variável de controle da última linha impressa.
			Else
				nLinTit  := nLin // Recebe a próxima linha disponível para impressão do título
				nLinCalc := nLin // Atualiza variável de cálculo de linhas
				lLinTit  := .F.  // Indica que a linha de impressão do título precisa ser definida, pois iniciará uma nova linha.
			EndIf
		EndIf
		
	Next nJ

	If lSalta // Se precisa continuar a impressão do conteúdo atual na próxima página 
		oPrint:EndPage() // Finaliza a página atual
		ImpCabec(@oPrint, @nLin, aRelat, aCabec, TMP) // Cria um novo cabeçalho na próxima página
		nLinCalc  := nLin // Inicia o controle das linhas a serem impressas
		nLinAtu   := nLinCalc // Atualiza variável linha atual
		lQuebPag  := .F. // Indica que não é necessário ocorrer a quebra de pagina, pois já está sendo quebrada nesse momento.
		lTitulo   := .T. // Indica que o título pode ser impresso 
		lLinTit   := .F. // Indica que a linha de impressão do título precisa ser definida, pois iniciará uma nova linha.
		nLinFinal := 0 // Limpa variável de controle da última linha impressa.
		
		// Imprime o restante do conteúdo que não coube na página anterior.
		JImpRel(aSobra,@nLin,@nLinCalc,@oPrint, @nLinFinal,lHori, @lTitulo, @lLinTit, aRelat, aCabec, @lSalta, TMP)
	EndIf

	aSize(aSobra,0)

Return nil

//-------------------------------------------------------------------
/*/{Protheus.doc} JImpLin(aDados)
Realiza a impressão do conteúdo de um campo
 
Uso Geral.

@param oPrint    Objeto TMSPrinter (Estrutura do relatório)
        nLinAtu   Linha para impresão
        nPosValor Orientação de posicionamento do campo na horizontal no relatório
        cTexto    Conteúdo a ser impresso
        oFontVal  Fonte usada na impressão do conteúdo
        nQtdCar   Tamanho limite para que seja feita a quebra de linha
        aSobra    Array com estrutura do campo e seu conteúdo a ser impresso 
                  (Usado quando é preciso continuar a impressão de um valor na próxima página)
        lSalta    Indica se é continuação de um conteúdo em outra página 
                  (Usado quando é preciso continuar a impressão de um valor na próxima página)
        lImpTit   Indica se os títulos precisam ser impressos

@return

@author Jorge Luis Branco Martins Junior
@since 18/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JImpLin(oPrint,nLinAtu,nPosValor,cTexto,oFontVal,nQtdCar,aSobra, lSalta, lImpTit)
Local nRazao    := oPrint:GetTextWidth( "oPrint:nPageWidth", oFontVal )
Local nTam      := (nRazao * nQtdCar) / 350
Local aCampForm := {} // Array com cada palavra a ser escrita.
Local cValor    := ""
Local cValImp   := "" // Valor impresso
Local nX        := 0

cTexto := StrTran(cTexto, Chr(13)+Chr(10), '')
cTexto := StrTran(cTexto, Chr(10), '')
aCampForm := STRTOKARR(cTexto, " ")

If Len(aCampForm) == 0 // Caso não exista conteúdo/valor
	If lImpTit // E o título do campo foi impresso 
		oPrint:Say(nLinAtu,nPosValor,cValor, oFontVal ) // Será inserida a linha com conteúdo em branco
		nLinAtu += nSalto // Pula uma linha
	EndIf
Else // Caso exista conteúdo/valor
	For nX := 1 To Len(aCampForm) // Laço para cada palavra a ser escrita
		If oPrint:GetTextWidth( cValor + aCampForm[nX], oFontVal ) <= nTam // Se a palavra atual for impressa e NÃO passar do limite de tamanho da linha
			cValor += aCampForm[nX] + " " // Preenche a linha com a palavra atual
		
			If Len(aCampForm) == nX // Caso esteja na última palavra
				oPrint:Say(nLinAtu,nPosValor,cValor, oFontVal ) // Insere a linha com o conteúdo que estava em cValor
				nLinAtu += nSalto // Pula para a próxima linha
			EndIf
	
		Else // Se a palavra atual for impressa e passar do limite de tamanho da linha
			oPrint:Say(nLinAtu,nPosValor,cValor, oFontVal ) // Insere a linha com o conteúdo que estava em cValor sem a palavra que ocasionou a quebra.
			nLinAtu += nSalto // Pula para a próxima linha
					
			If nLinAtu + 2*nSalto > nFimL // Se a próxima linha a ser impressa NÃO couber na página atual
				lSalta := .T. // Indica que precisa continuar a impressão do conteúdo atual na próxima página 
				If Empty(SubStr(cTexto,Len(cValImp+cValor)+2,1))
					aSobra[4] := AllTrim(SubStr(cTexto,Len(cValImp+cValor)+3,Len(cTexto))) // Preenche o array aSobra com o valor que falta ser impresso
				ElseIf Empty(SubStr(cTexto,Len(cValImp+cValor)+1,1))
					aSobra[4] := AllTrim(SubStr(cTexto,Len(cValImp+cValor)+2,Len(cTexto))) // Preenche o array aSobra com o valor que falta ser impresso
				ElseIf Empty(SubStr(cTexto,Len(cValImp+cValor),1))
					aSobra[4] := AllTrim(SubStr(cTexto,Len(cValImp+cValor),Len(cTexto))) // Preenche o array aSobra com o valor que falta ser impresso
				EndIf
				Exit
			Else // Se a próxima linha a ser impressa couber na página atual
				cValImp += cValor // Guarda todo o texto que já foi impresso para que caso necessite de quebra o sistema saiba até qual parte o texto já foi impresso.
				cValor := aCampForm[nX] + " " // Preenche a linha com a palavra atual
			EndIf
			
			If Len(aCampForm) == nX
				oPrint:Say(nLinAtu,nPosValor,cValor, oFontVal ) // Insere a linha com o conteúdo que estava em cValor sem a palavra que ocasionou a quebra.
				nLinAtu += nSalto // Pula para a próxima linha	
			EndIf
			
		EndIf
		
	Next
EndIf

//Limpa array
aSize(aCampForm,0)

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} JImpTitSes()
Imprime o título da sessão no relatório
 
Uso Geral.

@param oPrint    Objeto TMSPrinter (Estrutura do relatório)
        nLin      Linha Atual
        nLinCalc  Variável de controle de linhas usadas
        aSessao   Dados do conteúdo do relatório

@return

@author Jorge Luis Branco Martins Junior
@since 18/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JImpTitSes(oPrint, nLin, nLinCalc, aSessao)

	oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
	oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
	oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
	oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
		
	//aSessao[1] - Título da sessão do relatório
	//aSessao[2] - Posição da descrição
	//aSessao[3] - Fonte da sessão
	oPrint:Say( nLin+15, aSessao[2], aSessao[1], aSessao[3])
	
	nLin+=70
	nLinCalc := nLin

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} JDefSessao()
Monta array da sessão com os campos de Assuntos Jurídicos (Principal)
 
Uso Geral.

@param aCpoAgrup Array todos os campos do agrupamento atual
        aSessao   Sessão a ser preenchida
        oFontTit  Fonte dos títulos dos campos
        oFontDesc Fonte dos conteúdos dos campos

@return Nil

@author Jorge Luis Branco Martins Junior
@since 02/02/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JDefSessao(aCpoAgrup,aSessao,oFontTit,oFontDesc)
Local cTipo := ""
Local nI    := 0
Local lMemo := .F.
Local nCol  := 0 
Local nTam  := 0
Local cTabela := "NSZ"
Local cRecno  := "RECNONSZ"


For nI := 1 to Len(aCpoAgrup)
	cTipo := aCpoAgrup[nI][5]//JURX3INFO(aCpoAgrup[nI][1],"X3_TIPO")

	If cTipo == "C"
		If !Empty(aCpoAgrup[nI][6])//)JURX3INFO(aCpoAgrup[nI][1],"X3_CBOX"))
			cTipo := "O" //Lista de OPÇÕES
		EndIf
	EndIf
                   
	If Mod(nI, 2) == 1 
		If cTipo == "M"
			aAdd(aSessao,{aCpoAgrup[nI][2],cTabela,aCpoAgrup[nI][1],cRecno   ,cTipo,65  ,2700,oFontTit,oFontDesc,(nTamCarac*20),.T.})
			lMemo := .T.			
		Else
			aAdd(aSessao,{aCpoAgrup[nI][2],cTabela,aCpoAgrup[nI][1],aCpoAgrup[nI][1],cTipo,65  ,1200,oFontTit,oFontDesc,(nTamCarac*20),.F.})
		EndIf
	Else
		If lMemo       // Se o campo anterior for memo deve quebrar linha
			nCol := 65   // Indica a coordenada horizontal em pixels ou caracteres, 
			nTam := 1200 // Tamanho que o conteúdo pode ocupar,
			lMemo := .F. // Limpa variável
		Else
			nCol := 1270
			nTam := 800
		EndIf
		
		If cTipo == "M"
			aSessao[LEN(aSessao)][11] := .T. // Indica quebra de linha após o último registro
			aAdd(aSessao,{aCpoAgrup[nI][2],cTabela,aCpoAgrup[nI][1],cRecno   ,cTipo,65,2700,oFontTit,oFontDesc,(nTamCarac*20),.T.})
		Else
			aAdd(aSessao,{aCpoAgrup[nI][2],cTabela,aCpoAgrup[nI][1],aCpoAgrup[nI][1],cTipo,nCol,nTam,oFontTit,oFontDesc,(nTamCarac*20),.T.})
		EndIf
	EndIf

Next

Return
//-------------------------------------------------------------------
/*/{Protheus.doc} J095QryAnd()
Query de Andamentos
 
Uso Geral.

@param aParams Array com parâmetros para filtro (parãmetros 
                 passados na emissão do relatório

@Return cQuery Query dos andamentos

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J095QryAnd(aParams)
Local cQuery  := ""
Local cBanco  := Upper( AllTrim( TcGetDb() ) )
Local cAndCli := aParams[4] // Apenas Andamento p/Cliente - Todos/Sim/Não
Local cAndUlt := aParams[5] // Os últimos x Andamentos - Sim/Não
Local cAndQtd := aParams[6] // Quantidade de andamentos
Local cIntDat := aParams[7] // Intervalo entre datas - Sim/Não
Local cDtIni  := aParams[8] // Data Inicial
Local cDtFim  := aParams[9] // Data Final

	cQuery := " SELECT "
	
	//-- SQL - para limitar a quantidade filtrada
	If ( cBanco == "MSSQL") .And. cAndUlt == "S" .And. !Empty(cAndQtd) 
		cQuery += " TOP " + cAndQtd
	EndIf

	cQuery += " NT4.NT4_DTANDA, NT4.R_E_C_N_O_ RECNONT4, NRO.NRO_DESC, NQG.NQG_DESC, NUQ.NUQ_NUMPRO NT4_NMPROC "
	cQuery += " FROM " + RetSqlName("NT4") + " NT4 "
	cQuery +=  " LEFT JOIN " + RetSqlName("NQG") + " NQG "
	cQuery +=      " ON NQG.NQG_FILIAL = '"+xFilial("NQG")+"' "
	cQuery +=     " AND NQG_COD = NT4.NT4_CFASE "
	cQuery +=     " AND NQG.D_E_L_E_T_ = ' '"
	cQuery +=  " LEFT JOIN " + RetSqlName("NRO") + " NRO " 
	cQuery +=      " ON NRO.NRO_FILIAL = '"+xFilial("NRO")+"' "
	cQuery +=     " AND NRO.NRO_COD = NT4.NT4_CATO "
	cQuery +=     " AND NRO.D_E_L_E_T_ = ' '"
	cQuery +=  " LEFT JOIN " + RetSqlName("NUQ") + " NUQ " 
	cQuery +=      " ON NUQ.NUQ_FILIAL = '"+xFilial("NUQ")+"' "
	cQuery +=     " AND NUQ.NUQ_COD    = NT4.NT4_CINSTA "
	cQuery +=     " AND NUQ.NUQ_CAJURI = '@#NSZ_COD#@' "
	cQuery +=     " AND NUQ.NUQ_FILIAL = '@#NSZ_FILIAL#@' "
	cQuery +=     " AND NUQ.D_E_L_E_T_ = ' '"
	cQuery += " WHERE NT4.D_E_L_E_T_ = ' ' "
	cQuery +=   " AND NT4.NT4_CAJURI = '@#NSZ_COD#@' "
	cQuery +=   " AND NT4.NT4_FILIAL = '@#NSZ_FILIAL#@' "
	
	If cAndCli <> "T"
		cQuery += " AND NT4.NT4_PCLIEN = '"+IIf(cAndCli=="S","1","2")+"' "
	EndIf	
	//-- Oracle - para limitar a quantidade filtrada
	If (cBanco == "ORACLE") .AND. cAndUlt == "S" .And. !Empty(cAndQtd)
		cQuery += " AND ROWNUM <= " + cAndQtd
	EndIf	
	If cIntDat == "S"
		cQuery +=   " AND NT4.NT4_DTANDA between '"+DtoS(CToD(cDtIni))+"' and '"+DtoS(CToD(cDtFim))+"' "
	EndIf
	
	cQuery += " ORDER BY NT4.NT4_DTANDA DESC, NT4.NT4_COD DESC"
	
	//-- Postgres - para limitar a quantidade filtrada 
	If (cBanco == "POSTGRES") .And. !Empty(cAndQtd)
		cQuery += " LIMIT " + cAndQtd
	EndIf

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J095QryAco()
Query de Acordos/Negociações
 
Uso Geral.

@param 

@Return cQuery Query dos Acordos/Negociações

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J095QryAco()
Local cQuery := ""

cQuery := "SELECT CTO.CTO_SIMB NYP_DMOEDA, " + CRLF
cQuery +=       " NYP.NYP_VALOR NYP_VALOR, " + CRLF
cQuery +=       " SE4.E4_DESCRI NYP_CONDPG, " + CRLF
cQuery +=       " NYP.NYP_DATA NYP_DATA, " + CRLF
cQuery +=       " NYP.NYP_DATALI NYP_DATALI, " + CRLF
cQuery +=       " NYP.NYP_TIPO NYP_TIPO, " + CRLF
cQuery +=       " NYP.NYP_REALIZ NYP_REALIZ, " + CRLF
cQuery +=       " NYP.NYP_COD NYP_COD, " + CRLF
cQuery +=       " NYP.NYP_CAJURI NYP_CAJURI, " + CRLF
cQuery +=       " NYP.R_E_C_N_O_ RECNONYP " + CRLF
cQuery += " FROM " + RetSqlName("NYP") + " NYP " + CRLF 
cQuery +=  " LEFT OUTER JOIN  " + RetSqlName("CTO") + " CTO ON ( " + CRLF 
cQuery +=            " NYP.D_E_L_E_T_ = CTO.D_E_L_E_T_ AND " + CRLF
cQuery +=            " NYP.NYP_CMOEDA = CTO.CTO_MOEDA AND " + CRLF
cQuery +=            " CTO.CTO_FILIAL = '"+xFilial("CTO")+"') " + CRLF
cQuery +=  " LEFT OUTER JOIN " + RetSqlName("SE4") + " SE4 ON ( " + CRLF 
cQuery +=            " NYP.D_E_L_E_T_ = SE4.D_E_L_E_T_ AND " + CRLF
cQuery +=            " NYP.NYP_CONDPG = SE4.E4_CODIGO AND " + CRLF
cQuery +=            " SE4.E4_FILIAL = '"+xFilial("SE4")+"') " + CRLF
cQuery += " WHERE  NYP.D_E_L_E_T_ = ' ' AND NYP.NYP_CAJURI = '@#NSZ_COD#@' " + CRLF
cQuery +=   " AND NYP.NYP_FILIAL = '@#NSZ_FILIAL#@' "
cQuery += " ORDER BY NYP.NYP_CAJURI "

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J095QryAdi()
Query de Aditivos
 
Uso Geral.

@param 

@Return cQuery Query de Aditivos

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J095QryAdi()
Local cQuery := ""

cQuery := "SELECT NXY.NXY_CAJURI NXY_CAJURI, " + CRLF
cQuery +=       " NXY.NXY_FILIAL NXY_FILIAL, " + CRLF
cQuery +=       " NXY.NXY_ADITIV NXY_ADITIV, " + CRLF
cQuery +=       " NXY.NXY_NUMCON NXY_NUMCON, " + CRLF
cQuery +=       " NXY.NXY_DTASSI NXY_DTASSI, " + CRLF
cQuery +=       " NXZ.NXZ_DESC NXY_DTIPO, " + CRLF
cQuery +=       " NXY.R_E_C_N_O_ RECNONXY " + CRLF
cQuery += " FROM " + RetSqlName("NXY") + " NXY " + CRLF 
cQuery +=  " INNER JOIN  " + RetSqlName("NXZ") + " NXZ ON ( " + CRLF 
cQuery +=            " NXY.D_E_L_E_T_ = NXZ.D_E_L_E_T_ AND " + CRLF
cQuery +=            " NXY.NXY_CTIPO = NXZ.NXZ_COD AND " + CRLF
cQuery +=            " NXZ.NXZ_FILIAL = '"+xFilial("NXZ")+"') " + CRLF
cQuery += " WHERE  NXY.D_E_L_E_T_ = ' ' AND NXY.NXY_CAJURI = '@#NSZ_COD#@' " + CRLF
cQuery +=    " AND NXY.NXY_FILIAL = '@#NSZ_FILIAL#@' "

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J095QryInc()
Query de Incidentes

@return cQuery - Query de incidentes

@author  Rafael Tenorio da Costa
@since 	 25/07/18
@version 2.0
/*/
//-------------------------------------------------------------------
Static Function J095QryInc()

	Local cQuery := ""
	
	cQuery := "SELECT NSZ.NSZ_FILIAL FILIAL,"
	cQuery += 		" NSZ.NSZ_COD CAJURI,"
	cQuery +=		" NSZ.NSZ_CCLIEN NSZ_CCLIEN,"
	cQuery +=		" NSZ.NSZ_LCLIEN NSZ_LCLIEN,"
	cQuery +=   	" ISNULL(NVE.NVE_NUMCAS,'') || ' - ' || ISNULL(NVE.NVE_TITULO,'') NVE_TITULO"	
	
	cQuery += " FROM " + RetSqlName("NSZ") + " NSZ"
	
	cQuery +=	" LEFT JOIN " + RetSqlName("NVE") + " NVE"
	cQuery +=		" ON NVE.NVE_FILIAL = '" + xFilial("NVE") + "' AND"
	cQuery +=   	   " NSZ.NSZ_CCLIEN = NVE.NVE_CCLIEN AND"
	cQuery +=          " NSZ.NSZ_LCLIEN = NVE.NVE_LCLIEN AND"
	cQuery +=          " NSZ.NSZ_NUMCAS = NVE.NVE_NUMCAS AND"
	cQuery +=          " NSZ.D_E_L_E_T_ = NVE.D_E_L_E_T_"
	
	cQuery += " WHERE NSZ.NSZ_FILIAL = '@#NSZ_FILIAL#@'"
	cQuery += 	" AND NSZ.NSZ_CPRORI = '@#NSZ_COD#@'"
	cQuery +=	" AND NSZ.D_E_L_E_T_ = ' '"
	cQuery += " ORDER BY NSZ.NSZ_FILIAL, NSZ.NSZ_COD"
	
Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J095QryVin()
Query de Vinculados

@return cQuery - Query de relacionados

@author  Rafael Tenorio da Costa
@since 	 25/07/18
@version 2.0
/*/
//-------------------------------------------------------------------
Static Function J095QryVin()

	Local cQuery := ""
	
	cQuery := "SELECT NVO.NVO_FILDES FILIAL," 
	cQuery +=		" NVO.NVO_CAJUR2 CAJURI,"
	cQuery +=		" NSZ.NSZ_CCLIEN NSZ_CCLIEN,"
	cQuery +=		" NSZ.NSZ_LCLIEN NSZ_LCLIEN,"
	cQuery +=   	" ISNULL(NVE.NVE_NUMCAS,'') || ' - ' || ISNULL(NVE.NVE_TITULO,'') NVE_TITULO"
	
	cQuery += " FROM " + RetSqlName("NVO") + " NVO"
	
	cQuery +=	" INNER JOIN " + RetSqlName("NSZ") + " NSZ"
	cQuery += 		" ON NVO.NVO_FILORI = NSZ.NSZ_FILIAL AND"
	cQuery +=		   " NVO.NVO_CAJUR1 = NSZ.NSZ_COD AND"
	cQuery +=		   " NVO.D_E_L_E_T_ = NSZ.D_E_L_E_T_"
	 
	cQuery +=	" LEFT JOIN " + RetSqlName("NVE") + " NVE"
	cQuery +=		" ON NVE.NVE_FILIAL = '" + xFilial("NVE") + "' AND"
	cQuery +=   	   " NSZ.NSZ_CCLIEN = NVE.NVE_CCLIEN AND"
	cQuery +=          " NSZ.NSZ_LCLIEN = NVE.NVE_LCLIEN AND"
	cQuery +=          " NSZ.NSZ_NUMCAS = NVE.NVE_NUMCAS AND"
	cQuery +=          " NSZ.D_E_L_E_T_ = NVE.D_E_L_E_T_"
	
	cQuery += " WHERE NVO.NVO_FILIAL = '" + xFilial("NVO") + "'"
	cQuery += 	" AND NVO.NVO_FILORI = '@#NSZ_FILIAL#@'"
	cQuery += 	" AND NVO.NVO_CAJUR1 = '@#NSZ_COD#@'"
	cQuery +=	" AND NVO.D_E_L_E_T_ = ' '"
	
	cQuery += " ORDER BY NVO.NVO_FILDES, NVO.NVO_CAJUR2"

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J095QryRel()
Query de Relacionados

@return cQuery - Query de relacionados

@author  Rafael Tenorio da Costa
@since 	 25/07/18
@version 2.0
/*/
//-------------------------------------------------------------------
Static Function J095QryRel()

	Local cQuery := ""
	
	cQuery := "SELECT NXX.NXX_FILDES FILIAL," 
	cQuery +=		" NXX.NXX_CAJURD CAJURI,"
	cQuery +=		" NSZ.NSZ_CCLIEN NSZ_CCLIEN,"
	cQuery +=		" NSZ.NSZ_LCLIEN NSZ_LCLIEN,"
	cQuery +=   	" ISNULL(NVE.NVE_NUMCAS,'') || ' - ' || ISNULL(NVE.NVE_TITULO,'') NVE_TITULO"
	
	cQuery += " FROM " + RetSqlName("NXX") + " NXX"
	
	cQuery +=	" INNER JOIN " + RetSqlName("NSZ") + " NSZ"
	cQuery += 		" ON NXX.NXX_FILORI = NSZ.NSZ_FILIAL AND"
	cQuery +=		   " NXX.NXX_CAJURO = NSZ.NSZ_COD AND"
	cQuery +=		   " NXX.D_E_L_E_T_ = NSZ.D_E_L_E_T_"
	 
	cQuery +=	" LEFT JOIN " + RetSqlName("NVE") + " NVE"
	cQuery +=		" ON NVE.NVE_FILIAL = '" + xFilial("NVE") + "' AND"
	cQuery +=   	   " NSZ.NSZ_CCLIEN = NVE.NVE_CCLIEN AND"
	cQuery +=          " NSZ.NSZ_LCLIEN = NVE.NVE_LCLIEN AND"
	cQuery +=          " NSZ.NSZ_NUMCAS = NVE.NVE_NUMCAS AND"
	cQuery +=          " NSZ.D_E_L_E_T_ = NVE.D_E_L_E_T_"
	
	cQuery += " WHERE NXX.NXX_FILIAL = '" + xFilial("NXX") + "'"
	cQuery += 	" AND NXX.NXX_FILORI = '@#NSZ_FILIAL#@'"
	cQuery += 	" AND NXX.NXX_CAJURO = '@#NSZ_COD#@'"
	cQuery +=	" AND NXX.D_E_L_E_T_ = ' '"
	
	cQuery += " ORDER BY NXX.NXX_FILDES, NXX.NXX_CAJURD"

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J095QryEnv()
Query de Envolvidos
 
Uso Geral.

@param 

@Return cQuery Query de Envolvidos

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J095QryEnv()
Local cQuery := ""

cQuery := "SELECT NT9.NT9_NOME NT9_NOME, " + CRLF
cQuery +=       " NQA.NQA_DESC NQA_DESC " + CRLF
cQuery += " FROM " + RetSqlName("NT9") + " NT9 " + CRLF 
cQuery +=  " INNER JOIN " + RetSqlName("NQA") + " NQA ON ( " + CRLF 
cQuery +=            " NT9.D_E_L_E_T_ = NQA.D_E_L_E_T_ AND " + CRLF
cQuery +=            " NT9.NT9_CTPENV = NQA.NQA_COD AND " + CRLF
cQuery +=            " NQA.NQA_FILIAL = '"+xFilial("NQA")+"') " + CRLF
cQuery += " WHERE  NT9.D_E_L_E_T_ = ' ' AND NT9.NT9_CAJURI = '@#NSZ_COD#@' " + CRLF
cQuery +=    " AND NT9.NT9_FILIAL = '@#NSZ_FILIAL#@' "
cQuery += " ORDER BY NT9.NT9_TIPOEN "

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J095QryVlH()
Query de Valores Históricos
 
Uso Geral.

@param 

@Return cQuery Query de Valores Históricos

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J095QryVlH(cAnoMes)
Local cQuery := ""

cQuery := "SELECT NYZ.NYZ_ANOMES NYZ_ANOMES, " + CRLF
cQuery +=       " NW7.NW7_DESC NW7_DESC, " + CRLF
cQuery +=       " NYZ.NYZ_VACAUS NYZ_VACAUS, " + CRLF
cQuery +=       " NYZ.NYZ_VAENVO NYZ_VAENVO, " + CRLF
cQuery +=       " NYZ.NYZ_VAHIST NYZ_VAHIST " + CRLF
cQuery += " FROM " + RetSqlName("NYZ") + " NYZ " + CRLF 
cQuery +=  " INNER JOIN " + RetSqlName("NW7") + " NW7 ON ( " + CRLF 
cQuery +=            " NYZ.D_E_L_E_T_ = NW7.D_E_L_E_T_ AND " + CRLF
cQuery +=            " NYZ.NYZ_CFCORR = NW7.NW7_COD AND " + CRLF
cQuery +=            " NW7.NW7_FILIAL = '"+xFilial("NW7")+"') " + CRLF
cQuery += " WHERE  NYZ.D_E_L_E_T_ = ' ' AND NYZ.NYZ_CAJURI = '@#NSZ_COD#@' " + CRLF
cQuery +=    " AND NYZ.NYZ_FILIAL = '@#NSZ_FILIAL#@' "

If !Empty(cAnoMes)
	cQuery +=  " AND NYZ.NYZ_ANOMES <= '"+cAnoMes+"' " 
EndIf

cQuery += " ORDER BY NYZ.NYZ_ANOMES "

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J095QryDes()
Query de Despesas
 
Uso Geral.

@param 

@Return cQuery Query de Despesas

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J095QryDes(nTipo)
Local cQuery := ""

If nTipo == 1
	cQuery := "SELECT NSR.NSR_DESC NSR_DESC, " + CRLF
	cQuery +=       " NT3.NT3_DATA NT3_DATA, " + CRLF
	cQuery +=       " CTO.CTO_SIMB CTO_SIMB, " + CRLF
	cQuery +=       " NT3.NT3_VALOR NT3_VALOR " + CRLF
	cQuery += " FROM " + RetSqlName("NT3") + " NT3 " + CRLF 
	cQuery +=  " LEFT OUTER JOIN " + RetSqlName("NSR") + " NSR ON ( " + CRLF 
	cQuery +=            " NT3.D_E_L_E_T_ = NSR.D_E_L_E_T_ AND " + CRLF
	cQuery +=            " NT3.NT3_CTPDES = NSR.NSR_COD AND " + CRLF
	cQuery +=            " NSR.NSR_FILIAL = '"+xFilial("NSR")+"') " + CRLF
	cQuery +=  " LEFT OUTER JOIN " + RetSqlName("CTO") + " CTO ON ( " + CRLF 
	cQuery +=            " NT3.D_E_L_E_T_ = CTO.D_E_L_E_T_ AND " + CRLF
	cQuery +=            " NT3.NT3_CMOEDA = CTO.CTO_MOEDA AND " + CRLF
	cQuery +=            " CTO.CTO_FILIAL = '"+xFilial("CTO")+"') " + CRLF
	cQuery += " WHERE NT3.D_E_L_E_T_ = ' ' AND NT3.NT3_CAJURI = '@#NSZ_COD#@' "
	cQuery +=   " AND NT3.NT3_FILIAL = '@#NSZ_FILIAL#@' "
Else // Total
	cQuery += " SELECT SUM(NT3_VALOR) TOTAL" + CRLF
	cQuery += " FROM " + RetSqlName("NT3") + " NT3 " + CRLF 
	cQuery += " WHERE NT3.D_E_L_E_T_ = ' ' AND NT3.NT3_CAJURI = '@#NSZ_COD#@' "
	cQuery +=   " AND NT3.NT3_FILIAL = '@#NSZ_FILIAL#@' "
EndIf

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J095QryVal()
Query de Valores em Discussão / Pedidos
 
Uso Geral.

@param nTipo - Tipo de Query a ser montada
				[1] Detalhe
				[2] Totalizador

@Return cQuery Query de Valores em Discussão / Pedidos

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J095QryVal(nTipo)
Local cQuery := ""
Local lO0WInDic:= FwAliasinDIc('O0W')

	If nTipo == 1

		cQuery := "SELECT NSP.NSP_DESC NSP_DESC, " + CRLF
		cQuery +=       " NQ7.NQ7_DESC NQ7_DESC, " + CRLF
		cQuery +=       " NSY.NSY_PEVLR NSY_PEVLR, " + CRLF
		cQuery +=       " NSY.NSY_PEVLRA NSY_PEVLRA, " + CRLF
		cQuery +=       " NSY.NSY_VLCONT NSY_VLCONT, " + CRLF
		cQuery +=       " NSY.NSY_VLCONA NSY_VLCONA " + CRLF
		cQuery += " FROM " + RetSqlName("NSY") + " NSY " + CRLF 
		cQuery +=  " LEFT OUTER JOIN " + RetSqlName("NSP") + " NSP ON ( " + CRLF 
		cQuery +=            " NSY.D_E_L_E_T_ = NSP.D_E_L_E_T_ AND " + CRLF
		cQuery +=            " NSY.NSY_CPEVLR = NSP.NSP_COD AND " + CRLF
		cQuery +=            " NSP.NSP_FILIAL = '"+xFilial("NSP")+"') " + CRLF
		cQuery +=  " LEFT OUTER JOIN " + RetSqlName("NQ7") + " NQ7 ON ( " + CRLF 
		cQuery +=            " NSY.D_E_L_E_T_ = NQ7.D_E_L_E_T_ AND " + CRLF
		cQuery +=            " NSY.NSY_CPROG = NQ7.NQ7_COD AND " + CRLF
		cQuery +=            " NQ7.NQ7_FILIAL = '"+xFilial("NQ7")+"') " + CRLF
		cQuery += " WHERE NSY.D_E_L_E_T_ = ' ' AND NSY.NSY_CAJURI = '@#NSZ_COD#@' "
		cQuery +=   " AND NSY.NSY_FILIAL = '@#NSZ_FILIAL#@' "

		If lO0WInDic
			cQuery +=   " AND NSY.NSY_CVERBA = '"+ PADR(' ', TamSx3("NSY_CVERBA")[1]) + "'"
		EndIf
	Else // Total
		cQuery := "SELECT SUM(NSY_PEVLR) TOTPEVLR," + CRLF
		cQuery +=       " SUM(NSY_PEVLRA) TOTPEVLRA," + CRLF
		cQuery +=       " SUM(NSY_VLCONT) TOTVLCONT," + CRLF
		cQuery +=       " SUM(NSY_VLCONA) TOTVLCONA" + CRLF
		cQuery += " FROM " + RetSqlName("NSY") + " NSY " + CRLF 
		cQuery += " WHERE NSY.D_E_L_E_T_ = ' ' AND NSY.NSY_CAJURI = '@#NSZ_COD#@' "
		cQuery +=   " AND NSY.NSY_FILIAL = '@#NSZ_FILIAL#@' "

		If lO0WInDic
			cQuery +=   " AND NSY.NSY_CVERBA = '"+ PADR(' ', TamSx3("NSY_CVERBA")[1]) + "'"
		EndIf
	EndIf

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J095QryGar()
Query de Garantias
 
Uso Geral.

@param 

@Return cQuery Query de Garantias

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J095QryGar()
Local cQuery := ""

cQuery := "SELECT NQW.NQW_DESC NQW_DESC, " + CRLF
cQuery +=       " NW7.NW7_DESC NW7_DESC, " + CRLF
cQuery +=       " NT2.NT2_DATA NT2_DATA, " + CRLF
cQuery +=       " CTO.CTO_SIMB CTO_SIMB, " + CRLF
cQuery +=       " NT2.NT2_VALOR NT2_VALOR, " + CRLF
cQuery +=       " NT2.NT2_VCPROV NT2_VCPROV, " + CRLF
cQuery +=       " NT2.NT2_VJPROV NT2_VJPROV, " + CRLF
cQuery +=       " NT2.NT2_VJPROV + NT2.NT2_VCPROV + NT2.NT2_VALOR TOTAL " + CRLF
cQuery += " FROM " + RetSqlName("NT2") + " NT2 " + CRLF 
cQuery +=  " INNER JOIN " + RetSqlName("NQW") + " NQW ON ( " + CRLF 
cQuery +=            " NT2.D_E_L_E_T_ = NQW.D_E_L_E_T_ AND " + CRLF
cQuery +=            " NT2.NT2_CTPGAR = NQW.NQW_COD AND " + CRLF
cQuery +=            " NQW.NQW_FILIAL = '"+xFilial("NQW")+"') " + CRLF
cQuery +=  " LEFT OUTER JOIN " + RetSqlName("NW7") + " NW7 ON ( " + CRLF 
cQuery +=            " NT2.D_E_L_E_T_ = NW7.D_E_L_E_T_ AND " + CRLF
cQuery +=            " NT2.NT2_CCOMON = NW7.NW7_COD AND " + CRLF
cQuery +=            " NW7.NW7_FILIAL = '"+xFilial("NW7")+"') " + CRLF
cQuery +=  " INNER JOIN " + RetSqlName("CTO") + " CTO ON ( " + CRLF 
cQuery +=            " NT2.D_E_L_E_T_ = CTO.D_E_L_E_T_ AND " + CRLF
cQuery +=            " NT2.NT2_CMOEDA = CTO.CTO_MOEDA AND " + CRLF
cQuery +=            " CTO.CTO_FILIAL = '"+xFilial("CTO")+"') " + CRLF
cQuery += " WHERE  NT2.D_E_L_E_T_ = ' ' AND NT2.NT2_MOVFIN = '1' AND NT2.NT2_CAJURI = '@#NSZ_COD#@' " + CRLF
cQuery +=    " AND NT2.NT2_FILIAL = '@#NSZ_FILIAL#@' "
cQuery += " ORDER BY NQW.NQW_DESC"

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J095QryAlv()
Query de Levantamentos/Alvarás
 
Uso Geral.

@param 

@Return cQuery Query de Levantamentos/Alvarás

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J095QryAlv(nTipo)
Local cQuery := ""

If nTipo == 1 
	cQuery := "SELECT NQW.NQW_DESC NQW_DESC, " + CRLF
	cQuery +=       " NT2.NT2_DATA NT2_DATA, " + CRLF
	cQuery +=       " NT2.NT2_CGARAN NT2_CGARAN, " + CRLF
	cQuery +=       " CTO.CTO_SIMB CTO_SIMB, " + CRLF
	cQuery +=       " NT2.NT2_VALOR NT2_VALOR " + CRLF
	cQuery += " FROM " + RetSqlName("NT2") + " NT2 " + CRLF 
	cQuery +=  " INNER JOIN " + RetSqlName("NQW") + " NQW ON ( " + CRLF 
	cQuery +=            " NT2.D_E_L_E_T_ = NQW.D_E_L_E_T_ AND " + CRLF
	cQuery +=            " NT2.NT2_CTPGAR = NQW.NQW_COD AND " + CRLF
	cQuery +=            " NQW.NQW_FILIAL = '"+xFilial("NQW")+"') " + CRLF
	cQuery +=  " INNER JOIN " + RetSqlName("CTO") + " CTO ON ( " + CRLF 
	cQuery +=            " NT2.D_E_L_E_T_ = CTO.D_E_L_E_T_ AND " + CRLF
	cQuery +=            " NT2.NT2_CMOEDA = CTO.CTO_MOEDA AND " + CRLF
	cQuery +=            " CTO.CTO_FILIAL = '"+xFilial("CTO")+"') " + CRLF
	cQuery += " WHERE  NT2.D_E_L_E_T_ = ' ' AND NT2.NT2_MOVFIN = '2' AND NT2.NT2_CAJURI = '@#NSZ_COD#@' AND NT2.NT2_FILIAL = '@#NSZ_FILIAL#@'" + CRLF
	cQuery += " ORDER BY NQW.NQW_DESC"
Else
	cQuery := "SELECT NT2.NT2_CAJURI NT2_CAJURI, CTO.CTO_SIMB CTO_SIMB, (" + CRLF
	cQuery += "( SELECT SUM(NT2_VALOR) + SUM(NT2_VJPROV) + SUM(NT2_VCPROV) " + CRLF
	cQuery += " FROM " + RetSqlName("NT2") + " NT2 " + CRLF 
	cQuery += " WHERE  NT2.D_E_L_E_T_ = ' ' AND NT2.NT2_MOVFIN = '1' AND NT2.NT2_CAJURI = '@#NSZ_COD#@' AND NT2.NT2_FILIAL = '@#NSZ_FILIAL#@') - " + CRLF
	cQuery += "(SELECT SUM(NT2_VALOR) " + CRLF
	cQuery += " FROM " + RetSqlName("NT2") + " NT2 " + CRLF 
	cQuery += " WHERE  NT2.D_E_L_E_T_ = ' ' AND NT2.NT2_MOVFIN = '2' AND NT2.NT2_CAJURI = '@#NSZ_COD#@' AND NT2.NT2_FILIAL = '@#NSZ_FILIAL#@') ) TOTAL " + CRLF
	cQuery += " FROM " + RetSqlName("NT2") + " NT2 " + CRLF 
	cQuery +=  " INNER JOIN " + RetSqlName("CTO") + " CTO ON ( " + CRLF 
	cQuery +=            " NT2.D_E_L_E_T_ = CTO.D_E_L_E_T_ AND " + CRLF
	cQuery +=            " NT2.NT2_CMOEDA = CTO.CTO_MOEDA AND " + CRLF
	cQuery +=            " CTO.CTO_FILIAL = '"+xFilial("CTO")+"') " + CRLF
	cQuery += " WHERE  NT2.D_E_L_E_T_ = ' ' AND NT2.NT2_CAJURI = '@#NSZ_COD#@' AND NT2.NT2_FILIAL = '@#NSZ_FILIAL#@'" + CRLF
	cQuery += " GROUP BY NT2.NT2_CAJURI, CTO.CTO_SIMB"
EndIf

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J095QryDtE()
Query de Detalhamento dos envolvidos
 
Uso Geral.

@param 

@Return cQuery Query de Detalhamento dos envolvidos

@author Jorge Luis Branco Martins Junior
@since 16/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J095QryDtE()
Local cQuery := ""

cQuery := "SELECT NQA.NQA_DESC NQA_DESC, " + CRLF
cQuery +=       " NT9.NT9_NOME NOMEPRINCI, " + CRLF
cQuery +=       " NT9.NT9_ENTIDA, " + CRLF
cQuery +=       " NT9.NT9_TIPOP NT9_TIPOP, " + CRLF
cQuery +=       " NT9.NT9_PRINCI NT9_PRINCI, " + CRLF
cQuery +=       " NT9.NT9_CODENT NT9_CODENT, " + CRLF
cQuery +=       " NT9.NT9_CEMPCL NT9_CEMPCL, " + CRLF
cQuery +=       " NT9.NT9_LOJACL NT9_LOJACL, " + CRLF
cQuery +=       " NT9.NT9_CFORNE NT9_CFORNE, " + CRLF
cQuery +=       " NT9.NT9_LFORNE NT9_LFORNE, " + CRLF
cQuery +=       " NT9.NT9_CGC NT9_CGC, " + CRLF
cQuery +=       " NT9.NT9_RG NT9_RG, " + CRLF
cQuery +=       " NT9.NT9_ESTADO NT9_ESTADO, " + CRLF
cQuery +=       " CC2.CC2_MUN CC2_MUN, " + CRLF
cQuery +=       " NT9.NT9_ENDECL NT9_ENDECL, " + CRLF
cQuery +=       " NT9.NT9_CEP NT9_CEP, " + CRLF
cQuery +=       " NT9.NT9_INSCR NT9_INSCR, " + CRLF
cQuery +=       " NT9.NT9_INSCRM NT9_INSCRM, " + CRLF
cQuery +=       " NT9.NT9_DTADM NT9_DTADM, " + CRLF
cQuery +=       " NT9.NT9_DTDEMI NT9_DTDEMI, " + CRLF
cQuery +=       " NT9.NT9_CTPS NT9_CTPS, " + CRLF
cQuery +=       " NT9.NT9_SERIE NT9_SERIE, " + CRLF
cQuery +=       " NT9.NT9_EMAIL NT9_EMAIL, " + CRLF
cQuery +=       " NT9.NT9_DDD NT9_DDD, " + CRLF
cQuery +=       " NT9.NT9_TELEFO TELEFONE, " + CRLF
cQuery +=       " SQ3.Q3_DESCSUM Q3_DESCSUM, " + CRLF
cQuery +=       " SRJ.RJ_DESC RJ_DESC " + CRLF

cQuery += " FROM " + RetSqlName("SRJ") + " SRJ " + CRLF 
cQuery +=  " RIGHT OUTER JOIN ( " + RetSqlName("SQ3") + " SQ3 " + CRLF 
cQuery +=        " RIGHT OUTER JOIN " + RetSqlName("NT9") + " NT9 ON ( " + CRLF 
cQuery +=                    " SQ3.D_E_L_E_T_ = NT9.D_E_L_E_T_ AND " + CRLF
cQuery +=                    " SQ3.Q3_FILIAL = '"+xFilial("SQ3")+"' AND " + CRLF
cQuery +=                    " SQ3.Q3_CARGO = NT9.NT9_CCRGDP) ) ON ( " + CRLF 
cQuery +=            " SRJ.D_E_L_E_T_ = NT9.D_E_L_E_T_ AND " + CRLF
cQuery +=            " SRJ.RJ_FILIAL = '"+xFilial("SRJ")+"' AND " + CRLF
cQuery +=            " SRJ.RJ_FUNCAO = NT9.NT9_CFUNDP) " + CRLF
cQuery +=  " INNER JOIN " + RetSqlName("NQA") + " NQA ON ( " + CRLF 
cQuery +=            " NT9.D_E_L_E_T_ = NQA.D_E_L_E_T_ AND " + CRLF
cQuery +=            " NQA.NQA_FILIAL = '"+xFilial("NQA")+"' AND " + CRLF
cQuery +=            " NT9.NT9_CTPENV = NQA.NQA_COD ) " + CRLF
cQuery +=  " LEFT OUTER JOIN " + RetSqlName("CC2") + " CC2 ON ( " + CRLF
cQuery +=            " NT9.D_E_L_E_T_ = CC2.D_E_L_E_T_ AND " + CRLF
cQuery +=            " NT9.NT9_CMUNIC = CC2.CC2_CODMUN AND " + CRLF
cQuery +=            " CC2.CC2_FILIAL = '"+xFilial("CC2")+"' AND " + CRLF
cQuery +=            " NT9.NT9_ESTADO = CC2.CC2_EST) " + CRLF
cQuery += " WHERE  NT9.D_E_L_E_T_ = ' ' AND NT9.NT9_ENTIDA > ' ' AND NT9.NT9_CAJURI = '@#NSZ_COD#@' " + CRLF
cQuery +=    " AND NT9.NT9_FILIAL = '@#NSZ_FILIAL#@' "
cQuery += " ORDER BY NT9.NT9_ENTIDA, NT9.NT9_TIPOEN "

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J095SalAtu
Função geral que retorna o resultado do calculo conforme o tipo solicitado
Usado para Saldo das garantias/alvarás

@param cAssJur Còdigo do assunto jurídico
@param cTipo   'TT'   para saldo atualizado'
			   'TTSA' para saldo sem atualização

@Return nRet   Saldo Juizo Atualizado

@author Jorge Luis Branco Martins Junior
@since 15/02/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J095SalAtu (cAssJur, cTipo)
Local aArea  := GetArea()
Local aSaldo := JA098CriaS(cAssJur)
Local nI     := 0
Local nTT    := 0
Local nTTSA  := 0
local nRet   := 0

Default cTipo := 'TT'

	For nI:= 1 to Len(aSaldo)
		If aSaldo[nI][4] == 'TT'
			nTT := nTT + aSaldo[nI][5]
		ElseIf aSaldo[nI][4] == 'TTSA'
			nTTSA := nTTSA + aSaldo[nI][5]
		End If
	Next

	If cTipo == 'TTSA' .Or. (cTipo == 'TT' .And. !JA098FrCor(cAssJur))
		nRet := nTTSA
	Else
		nRet := nTT
	End If


	RestArea( aArea )

Return nRet

//-------------------------------------------------------------------
/*/{Protheus.doc} J095Entida
Função geral que retorna o código/loja da entidade usada ou nome da
entidade

@param nTipo     1 = Conteúdo, 2 = Nome da entidade
        cEntida   Tabela referênte a entidade (Ex: SA1, SA2)
        cCliente  Código/Loja do Cliente
        cFornec   Código/Loja do Fornecedor
        cCodEnt   Código do registro caso não seja Cliente ou Fornecedor

@Return cValor   Conteúdo (Cliente/Fornecedor/Loja ou outros códigos de entidade ) (nTipo==1)
                   Nome da Entidade (nTipo==2)

@author Jorge Luis Branco Martins Junior
@since 15/02/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J095Entida(nTipo,cEntida,cCliente,cFornec,cCodEnt)
Local cValor := ""

Default cCliente := ""
Default cFornec  := ""
Default cCodEnt  := ""

If nTipo == 1 // Conteúdo dos campos
	cValor := cCodEnt

	Do Case
		Case cEntida == 'SA1'
			cValor := cCliente
		Case cEntida == 'SA2'
			cValor := cFornec
	End Case

Else // Nome das entidades
	
	Do Case
		Case cEntida == 'SA1'
			cValor := STR0024 //'Cliente' 
		Case cEntida == 'SA2'
			cValor := STR0025 //'Fornecedor'
		Case cEntida == 'SU5'
			cValor := STR0026 //'Contato'
		Case cEntida == 'SRA'
			cValor := STR0027 //'Funcionário'
		Otherwise
			cValor := STR0028 //'Partes Contrárias'
	End Case

EndIf

Return AllTrim(cValor)

//-------------------------------------------------------------------
/*/{Protheus.doc} J095Campos
Função geral que retorna os campos que serão exibidos no relatório

@param cAssJur Código do assunto jurídico
        cTabela Tabela para que deve-se saber quais campos estão disponíveis

@Return aCampos Array com os campos e seus títulos

@author Jorge Luis Branco Martins Junior
@since 15/02/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J095Campos(cAssJur,cTabela,cCfgRel)
Local aNZN      := U_J95NznCpo(cAssJur,cTabela,cCfgRel)
Local aNZNVis   := aNZN[1] // Campos Visíveis que tiveram a descrição alterada
Local aNZNNot   := aNZN[2] // Campos que foram retirados da exibição no relatório
Local aNUZ      := J95NuzCpo(cAssJur,cTabela,.T.)
Local aObrig    := JurCpoObrig(cTabela)
Local aNUZB     := {}
Local nI        := 0
Local cCampo    := ""
Local aCampos    := {}
Local cCampoExce := cCpoExcec + "|"
Local aInfoX3    := {}
Local cF3        := ""
Local cOrdem     := ""
Local cAgrup     := ""
Local cTipo      := ""
Local cCBox      := ""

For nI := 1 To Len(aNZNNot)
	cCampoExce += aNZNNot[nI] + "|"
Next

For nI := 1 To Len(aNuz)
	cCampo  := aNuz[nI][1]
	aInfoX3 := JURX3INFOS(cCampo,{"X3_F3","X3_ORDEM","X3_AGRUP","X3_TIPO","X3_CBOX"})
	
	If Len(aInfoX3) > 0
		cF3     := aInfoX3[1]
		cOrdem  := aInfoX3[2]
		cAgrup  := aInfoX3[3]
		cTipo   := aInfoX3[4]
		cCBox   := aInfoX3[5]
		If !(cCampo $ cCampoExce) .And. ( Empty(cF3) .Or. cCampo $ "NT2_CGARAN|NYP_CONDPG|NSZ_CCLIEN")
			nPos := ASCAN(aNZNVis, { |x| x[1] == cCampo })
			If nPos > 0
				aAdd(aCampos,{aNZNVis[nPos][1],aNZNVis[nPos][2],cOrdem,cAgrup,cTipo,cCBox})
			Else
				aAdd(aCampos,{cCampo,aNuz[nI][2],cOrdem,cAgrup,cTipo,cCBox})
			EndIf
			cCampoExce += cCampo + "|"
		EndIf
	
	EndIf
Next

For nI := 1 To Len(aObrig)
	cCampo := aObrig[nI]
	aInfoX3 := JURX3INFOS(cCampo,{"X3_F3","X3_ORDEM","X3_AGRUP","X3_TIPO","X3_CBOX"})
	cF3     := aInfoX3[1]
	cOrdem  := aInfoX3[2]
	cAgrup  := aInfoX3[3]
	cTipo   := aInfoX3[4]
	cCBox   := aInfoX3[5]
	If !(cCampo $ cCampoExce) .And. ( Empty(cF3) .Or. cCampo $ "NT2_CGARAN|NYP_CONDPG|NSZ_CCLIEN")
		nPos := ASCAN(aNZNVis, { |x| x[1] == cCampo })
		If nPos > 0
			aAdd(aCampos,{aNZNVis[nPos][1],aNZNVis[nPos][2],cOrdem,cAgrup,cTipo,cCBox})
		Else
			aAdd(aCampos,{cCampo,RetTitle(cCampo),cOrdem,cAgrup,cTipo,cCBox})
		EndIf
		cCampoExce += cCampo + "|"
	EndIf
Next

ASORT(aCampos,,, { |x, y| x[3] < y[3] } ) 

aSize(aNUZB,0)
aSize(aNZN,0)
aSize(aNZNVis,0)
aSize(aNZNNot,0)
aSize(aNUZ,0)
aSize(aObrig,0)

Return aCampos

//-------------------------------------------------------------------
/*/{Protheus.doc} J95NznCpo
Campos a serem exibidos na tela

@param  cTipoAs   Tipo de Assunto Jurídico
         cTabela   Tabela a ser verificada
         
@Return {aNZNVis,aNZNNot} aNZNVis -> Array com campos que tiveram seus títulos alterados
                           aNZNNot -> Array com campos que foram retirados do relatório

@author Jorge Luis Branco Martins Junior
@since 22/02/16
@version 1.0
/*/
//-------------------------------------------------------------------
User Function J95NznCpo(cTipoAs,cTabela,cCfgRel)

Local cSQL      := ''
Local aArea     := GetArea()
Local cAliasQry := GetNextAlias()
Local aNZNVis   := {} // Campos Visíveis que tiveram a descrição alterada
Local aNZNNot   := {} // Campos que foram retirados da exibição no relatório

Default cTabela := ""


cSQL  := "SELECT NZN.NZN_CAMPO, NZN.NZN_TITULO, NZN.NZN_VISIVE, NZN.NZN_TIPOAS FROM "+ RetSqlname('NZN') +" NZN "+CRLF 
cSQL  += " WHERE NZN.D_E_L_E_T_ = ' ' " +CRLF
cSQL  += " AND NZN.NZN_TIPOAS = '"+cTipoAs+"' " +CRLF
cSQL  += " AND NZN.NZN_CFGREL = '"+cCfgRel+"' " +CRLF
cSQL  += " AND NZN.NZN_FILIAL = '" + xFilial('NZN') + "'"
If !Empty(cTabela)
	cSQL  += " AND NZN.NZN_CAMPO LIKE '" + (cTabela + '_') + "%' "
Endif
cSQL  += " UNION "
cSQL  += "SELECT NZN.NZN_CAMPO, NZN.NZN_TITULO, NZN.NZN_VISIVE, NZN.NZN_TIPOAS FROM "+ RetSqlname('NZN') +" NZN "+CRLF
cSQL  += " JOIN "+RetSqlname('NYB')+" NYB "+CRLF
cSQL  +=   " ON (NZN.NZN_TIPOAS = NYB.NYB_CORIG AND NYB.NYB_COD = '"+cTipoAs+"' "
cSQL  +=   " AND NYB.D_E_L_E_T_ = ' ' AND NYB.NYB_FILIAL = '" + xFilial('NYB') + "' )"+CRLF
cSQL  +=  " WHERE NZN.D_E_L_E_T_ = ' ' " +CRLF
cSQL  +=    " AND NZN.NZN_FILIAL = '" + xFilial('NZN') + "'"
If !Empty(cTabela)
	cSQL  += " AND NZN.NZN_CAMPO LIKE '" + (cTabela + '_') + "%' "	
Endif

cSQL := ChangeQuery(cSQL)
dbUseArea(.T., 'TOPCONN', TcGenQry( ,, cSQL ) , cAliasQry, .T., .F.)

While !(cAliasQry)->( EOF() )

	If (cAliasQry)->NZN_VISIVE == "1"
		aAdd(aNZNVis,{(cAliasQry)->NZN_CAMPO, (cAliasQry)->NZN_TITULO, (cAliasQry)->NZN_TIPOAS > "050"} )
	Else
		If ASCAN(aNZNVis, { |x| x[1] == (cAliasQry)->NZN_CAMPO .And. x[3]}) == 0 
			aAdd(aNZNNot,(cAliasQry)->NZN_CAMPO )
		EndIf
	EndIf
	(cAliasQry)->( dbSkip() )
	
End

(cAliasQry)->( dbcloseArea() )

RestArea(aArea)
	
Return {aNZNVis,aNZNNot}

//-------------------------------------------------------------------
/*/{Protheus.doc} JDefSubs
Função geral que define campos a serem utilizados em subreports

@param aCampos   Array com campos que podem ser adicionados
        aSessao   Array com estrutura da Sessão em que serão adicionados os campos
        oFontTit  Fonte usada nos títulos do relatório (Título de campos e títulos no cabeçalho)
        oFontDesc Fonte usada nos textos
        oFontSub  Fonte usada nos títulos das sessões
        cTabela   Tabela para que deve-se saber quais campos estão disponíveis
        cAssJur   Tipo do Assunto Jurídico
        cCfgRel   Código do relatório

@Return

@author Jorge Luis Branco Martins Junior
@since 15/02/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JDefSubs(aCampos,aSessao,oFontTit,oFontDesc,oFontSub,cTabela,cAssJur,cCfgRel)
Local nPos      := 0
Local nI,nX     := 0
Local nSessao   := 0
Local aNZN      := {}
Local aNZNVis   := {}
Local aNZNNot   := {}
Local cCampo    := ""
Local cDesc     := ""
Local cValor    := ""
Local cValorA   := ""
Local cCont     := ""
Local cContA    := ""
Local cData     := ""
Local aCpoNSY   := {}
Local aDescNSY  := {}
Local cTitulo   := ""
Local nEspaco   := 65
Local lRdrPoss  := .F.
Local lRdrRem   := .F.

Default aCampos := {}
Default oFontSub := oFontDesc

//Campos do Relatório
  //Exemplo da primeira parte -> aAdd(aSessao, {"Detalhe",65,oFontSub,.F.,"",.F.})
  // 1 - Título da sessão do relatório,
  // 2 - Posição de início da descrição, 
  // 3 - Fonte no quadro com título da sessão,
  // 4 - Impressão na horizontal? -> Título e descrição na mesma linha (Ex: Data: 01/01/2016)
  // 5 - Query do subreport - Se for parte do relatório principal não precisa ser indicado
  // 6 - Indica se deve incluir linha antes da impressão da sessão - Usado para sessões de totalizadores
    // Arrays a partir da 7ª posição
      // 1 - Título do campo,
      // 2 - Tabela do campo,
      // 3 - Nome do campo no dicionário,
      // 4 - Nome do Campo na Query,
      // 5 - Tipo do Campo,
      // 6 - Indica a coordenada horizontal em pixels ou caracteres, 
      // 7 - Tamanho que o conteúdo pode ocupar,
      // 8 - Fonte do título, 
      // 9 - Fonte da descrição
      // 10 - Posição de início da descrição
      // 11 - Quebra Linha após impressão do conteúdo?

Do Case

		//Incidentes \ Viculados \ Relacionados
		Case cTabela $ 'INC|NVO|NXX' 
		
			aAdd(aSessao, {STR0002,"NSZ","NSZ_COD","CAJURI","C",65,400 ,oFontTit,oFontDesc,(nTamCarac*10),.F.})	//"Assunto Jurídico"
		
			For nI := 1 To Len(aCampos)
				cCampo := AllTrim(aCampos[nI][1])
				cDesc  := aCampos[nI][2]
				
				Do Case 
					Case cCampo == "NSZ_CCLIEN"
						aAdd(aSessao, {cDesc ,"NSZ","NSZ_CCLIEN","NSZ_CCLIEN","C",400  ,1000 ,oFontTit,oFontDesc,(nTamCarac*7) ,.F.})
						
					Case cCampo == "NSZ_LCLIEN"
						aAdd(aSessao, {cDesc ,"NSZ","NSZ_LCLIEN","NSZ_LCLIEN","C",600 ,1000 ,oFontTit,oFontDesc,(nTamCarac*7) ,.F.})
						
					Case cCampo == "NSZ_DCASO"
						aAdd(aSessao, {cDesc ,"NVE","NVE_TITULO","NVE_TITULO","C",700 ,2000 ,oFontTit,oFontDesc,(nTamCarac*7) ,.F.})
				EndCase
			Next

			//Quebra de linha na ultima seção
			aSessao[ Len(aSessao) ][11] := .T.
			
		Case cTabela == 'NYZ' // Valores Históricos
			aNZN      := U_J95NznCpo(cAssJur,cTabela,cCfgRel)
			aNZNVis   := aNZN[1] // Campos Visíveis que tiveram a descrição alterada
			//Ano Mês
			aAdd(aSessao, {IIf( nPos := ASCAN(aNZNVis, { |x| x[1] == "NYZ_ANOMES" }) > 0,aNZNVis[nPos][2], JURX3INFO("NYZ_ANOMES","X3_TITULO")) ,"NYZ","NYZ_ANOMES","NYZ_ANOMES","C",65  ,500 ,oFontTit,oFontDesc,(nTamCarac*7) ,.F.})
			//F. Correção
			aAdd(aSessao, {IIf( nPos := ASCAN(aNZNVis, { |x| x[1] == "NYZ_DFCORR" }) > 0,aNZNVis[nPos][2], JURX3INFO("NYZ_DFCORR","X3_TITULO")) ,"NW7","NW7_DESC"  ,"NW7_DESC"  ,"C",500 ,500 ,oFontTit,oFontDesc,(nTamCarac*7) ,.F.})
			//Valor Causa
			aAdd(aSessao, {IIf( nPos := ASCAN(aNZNVis, { |x| x[1] == "NYZ_VACAUS" }) > 0,aNZNVis[nPos][2], JURX3INFO("NYZ_VACAUS","X3_TITULO")) ,"NYZ","NYZ_VACAUS","NYZ_VACAUS","N",800 ,500 ,oFontTit,oFontDesc,(nTamCarac*7) ,.F.})
			//Valor Envolvido
			aAdd(aSessao, {IIf( nPos := ASCAN(aNZNVis, { |x| x[1] == "NYZ_VAENVO" }) > 0,aNZNVis[nPos][2], JURX3INFO("NYZ_VAENVO","X3_TITULO")) ,"NYZ","NYZ_VAENVO","NYZ_VAENVO","N",1200,500 ,oFontTit,oFontDesc,(nTamCarac*7) ,.F.})
			//Valor Histórico
			aAdd(aSessao, {IIf( nPos := ASCAN(aNZNVis, { |x| x[1] == "NYZ_VAHIST" }) > 0,aNZNVis[nPos][2], JURX3INFO("NYZ_VAHIST","X3_TITULO")) ,"NYZ","NYZ_VAHIST","NYZ_VAHIST","N",1600,500 ,oFontTit,oFontDesc,(nTamCarac*10),.T.})
		
		Case cTabela == 'NT9' // Detalhamento de envolvidos
			If ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT9_DENTID" }) > 0 // Entidade
				aAdd(aSessao, {""               ,"NT9","NT9_ENTIDA","ENTIDADE"  ,"C",65                    ,1200 ,oFontSub,oFontSub ,(0)           ,.T.})//65,2000
				aAdd(aSessao, {""               ,"NQA","NQA_DESC"  ,"NQA_DESC"  ,"C",65                    ,1200 ,oFontTit,oFontTit ,(0)           ,.F.})//65,460
				aAdd(aSessao, {""               ,"NT9","NT9_NOME"  ,"NOMEPRINCI","C",65 + (nTamCarac*20)   ,1200 ,oFontTit,oFontDesc,(0)           ,.F.})//65,2000
				aAdd(aSessao, {""               ,"NT9","NT9_ENTIDA","ENTIDADE"  ,"C",1270                  ,1200 ,oFontTit,oFontTit ,(0)           ,.F.})//1270,1500
				aAdd(aSessao, {""               ,"NT9","NT9_ENTIDA","J095CodEnt","C",1270 + (nTamCarac*16) ,1200 ,oFontTit,oFontDesc,(0)           ,.F.})//1270,1500
				aAdd(aSessao, {STR0029/*"Loja"*/,"NT9","NT9_ENTIDA","J095LojEnt","C",1270 + (nTamCarac*27) ,1200 ,oFontTit,oFontDesc,(nTamCarac*5) ,.T.})//1270,500
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT9_TIPOP" })) > 0 // Tipo de Pessoa
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NT9","NT9_TIPOP" ,"NT9_TIPOP" ,"O",65                    ,1200 ,oFontTit,oFontDesc,(nTamCarac*20),.F.})
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT9_CGC" })) > 0 //CNPJ/CPF
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NT9","NT9_CGC"   ,"NT9_CGC"   ,"C",1270                  ,1200 ,oFontTit,oFontDesc,(nTamCarac*16),.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T. // Indica quebra de linha após o último registro
				EndIf
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT9_RG" })) > 0 //Num. RG
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NT9","NT9_RG"    ,"NT9_RG"    ,"C",65                    ,1200 ,oFontTit,oFontDesc,(nTamCarac*20),.F.})
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT9_DMUNIC" })) > 0 //Estado e Cidade
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NT9","NT9_ESTADO","NT9_ESTADO","C",1270                  ,1200 ,oFontTit,oFontDesc,(nTamCarac*16)	  ,.F.})
				aAdd(aSessao, {""    ,"CC2","CC2_MUN"   ,"CC2_MUN"   ,"C",1270 + (nTamCarac*19) ,1200 ,oFontTit,oFontDesc,(0)             ,.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT9_ENDECL" })) > 0 //Endereço
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NT9","NT9_ENDECL","NT9_ENDECL","C",65                    ,1200 ,oFontTit,oFontDesc,(nTamCarac*20),.F.})
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT9_CEP" })) > 0 //CEP
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NT9","NT9_CEP"   ,"NT9_CEP"   ,"C",1270                  ,1200 ,oFontTit,oFontDesc,(nTamCarac*16),.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT9_INSCR" })) > 0 //Inscr. Estadual
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NT9","NT9_INSCR" ,"NT9_INSCR" ,"C",65                    ,1200 ,oFontTit,oFontDesc,(nTamCarac*20),.F.})
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT9_INSCRM" })) > 0 //Inscr. Municipal
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NT9","NT9_INSCRM","NT9_INSCRM","C",1270                  ,1200 ,oFontTit,oFontDesc,(nTamCarac*16),.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT9_DTADM" })) > 0 //Data Admissão
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NT9","NT9_DTADM" ,"NT9_DTADM" ,"D",65                    ,1200 ,oFontTit,oFontDesc,(nTamCarac*20),.F.})
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT9_DTDEMI" })) > 0 //Data Demissão
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NT9","NT9_DTDEMI","NT9_DTDEMI","D",1270                  ,1200 ,oFontTit,oFontDesc,(nTamCarac*16),.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT9_CTPS" })) > 0 //Cart. Profis.
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NT9","NT9_CTPS"  ,"NT9_CTPS"  ,"C",65                    ,1200 ,oFontTit,oFontDesc,(nTamCarac*20),.F.})
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT9_SERIE" })) > 0 //Série Cart.
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NT9","NT9_SERIE" ,"NT9_SERIE" ,"C",1270                  ,1300 ,oFontTit,oFontDesc,(nTamCarac*16),.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT9_EMAIL" })) > 0 //Email
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NT9","NT9_EMAIL" ,"NT9_EMAIL" ,"C",65                    ,1200 ,oFontTit,oFontDesc,(nTamCarac*20),.F.})
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT9_TELEFO" })) > 0 //Telefone
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NT9","NT9_TELEFO","TELEFONE"  ,"C",1270                  ,1200 ,oFontTit,oFontDesc,(nTamCarac*16),.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT9_DCRGDP" })) > 0 //Cargo
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"SQ3","Q3_DESCSUM","Q3_DESCSUM","C",65                    ,1200 ,oFontTit,oFontDesc,(nTamCarac*20),.F.})
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT9_DFUNDP" })) > 0 //Função
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"SRJ","RJ_DESC"   ,"RJ_DESC"   ,"C",1270                  ,1200 ,oFontTit,oFontDesc,(nTamCarac*16),.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf
		
		Case cTabela == "NT2" // Garantias / Alvarás / Totalizador
			
			aNZN      := U_J95NznCpo(cAssJur,cTabela,cCfgRel)
			aNZNVis   := aNZN[1] // Campos Visíveis que tiveram a descrição alterada
			aNZNNot   := aNZN[2] // Campos Visíveis que tiveram a descrição alterada
			// Abre a seção garantias
			aAdd(aSessao, {STR0017/*"Garantias"*/,65,oFontSub,.T.,J095QryGar(),.F.})
			nSessao := Len(aSessao)
			// Tipo de Garantia
			aAdd(aSessao[nSessao], {""                              ,"NQW","NQW_DESC"  ,"NQW_DESC"  ,"C",65                    ,2500 ,oFontTit,oFontDesc,(0)           ,.T.})

			//Data
			If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == "NT2_DATA" }) == 0
				cData := (IIf( nPos := ASCAN(aNZNVis, { |x| x[1] == "NT2_DATA" }) > 0,aNZNVis[nPos][2], JURX3INFO("NT2_DATA","X3_TITULO")))
				aAdd(aSessao[nSessao],{cData                        ,"NT2","NT2_DATA"  ,"NT2_DATA"  ,"D",65                    ,500 ,oFontTit,oFontDesc,(nTamCarac*11),.F.})
			EndIf
			
			//Valor e Valor Atualizado
			If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == "NT2_VALOR" }) == 0 
				// Valor
				cValor := IIf( nPos := ASCAN(aNZNVis, { |x| AllTrim(x[1]) == "NT2_VALOR" }) > 0,aNZNVis[nPos][2], JURX3INFO("NT2_VALOR","X3_TITULO"))
				aAdd(aSessao[nSessao],{cValor                        ,"NT2","NT2_VALOR" ,"NT2_VALOR" ,"N",800                   ,2500 ,oFontTit,oFontDesc,(nTamCarac*15),.F.})
				aAdd(aSessao[nSessao],{""                            ,"CTO","CTO_SIMB"  ,"CTO_SIMB"  ,"C",800 + (nTamCarac*12)  ,2500 ,oFontTit,oFontDesc,(0)           ,.F.})
				// Valor Atualizado
				aAdd(aSessao[nSessao],{STR0022/*"Valor Atualizado"*/ ,"NT2","NT2_VALOR" ,"TOTAL"     ,"N",1570                  ,2500 ,oFontTit,oFontDesc,(nTamCarac*19),.F.})
				aAdd(aSessao[nSessao],{""                            ,"CTO","CTO_SIMB"  ,"CTO_SIMB"  ,"C",1570 + (nTamCarac*16) ,2500 ,oFontTit,oFontDesc,(0)           ,.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf

			//F. Correção
			If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == "NT2_DCOMON" }) == 0 
				cTitulo := IIf( nPos := ASCAN(aNZNVis, { |x| AllTrim(x[1]) == "NT2_DCOMON" }) > 0,aNZNVis[nPos][2], JURX3INFO("NT2_DCOMON","X3_TITULO"))
				aAdd(aSessao[nSessao],{cTitulo                      ,"NW7","NW7_DESC"   ,"NW7_DESC"  ,"C",65                    ,1000 ,oFontTit,oFontDesc,(nTamCarac*11),.F.})
			EndIf

			//Valor de Correção
			If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == "NT2_VCPROV" }) == 0 
				cTitulo := IIf( nPos := ASCAN(aNZNVis, { |x| AllTrim(x[1]) == "NT2_VCPROV" }) > 0,aNZNVis[nPos][2], JURX3INFO("NT2_VCPROV","X3_TITULO"))
				aAdd(aSessao[nSessao],{cTitulo                      ,"NT2","NT2_VCPROV"  ,"NT2_VCPROV","N",800                   ,2500 ,oFontTit,oFontDesc,(nTamCarac*15),.F.})
				aAdd(aSessao[nSessao],{""                           ,"CTO","CTO_SIMB"    ,"CTO_SIMB"  ,"C",800 + (nTamCarac*12)  ,2500 ,oFontTit,oFontDesc,(0)           ,.F.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf

			// Valor de Juros
			If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == "NT2_VJPROV" }) == 0 
				cTitulo := IIf( nPos := ASCAN(aNZNVis, { |x| AllTrim(x[1]) == "NT2_VJPROV" }) > 0,aNZNVis[nPos][2], JURX3INFO("NT2_VJPROV","X3_TITULO"))
				aAdd(aSessao[nSessao],{cTitulo                    ,"NT2","NT2_VJPROV"   ,"NT2_VJPROV" ,"N",1570                   ,2500 ,oFontTit,oFontDesc,(nTamCarac*19),.F.})
				aAdd(aSessao[nSessao],{""                         ,"CTO","CTO_SIMB"     ,"CTO_SIMB"   ,"C",1570 + (nTamCarac*16)  ,2500 ,oFontTit,oFontDesc,(0)           ,.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf

			// Abre seção Alvarás
			aAdd(aSessao, {STR0018/*"Alvarás"*/,65,oFontSub,.T.,J095QryAlv(1),.F.})
			nSessao := Len(aSessao)
			// Tipo de Alvará
			aAdd(aSessao[nSessao],{""      ,"NQW","NQW_DESC"  ,"NQW_DESC"  ,"C",65                    ,2500 ,oFontTit,oFontDesc,(0)           ,.T.})
			
			//Data
			If !Empty(cData) 
				aAdd(aSessao[nSessao],{cData ,"NT2","NT2_DATA"  ,"NT2_DATA"  ,"D",65                    ,500 ,oFontTit,oFontDesc,(nTamCarac*11),.F.})
			EndIf

				//Cód. Garantia
			If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == "NT2_CGARAN" }) == 0 
				cTitulo := IIf( nPos := ASCAN(aNZNVis, { |x| AllTrim(x[1]) == "NT2_CGARAN" }) > 0,aNZNVis[nPos][2], JURX3INFO("NT2_CGARAN","X3_TITULO"))
				aAdd(aSessao[nSessao],{cTitulo ,"NT2","NT2_CGARAN","NT2_CGARAN","C",800                   ,1000 ,oFontTit,oFontDesc,(nTamCarac*12),.F.})
			EndIf

			// Valor do Alvará
			If !Empty(cValor) 
				aAdd(aSessao[nSessao],{cValor ,"NT2","NT2_VALOR" ,"NT2_VALOR" ,"N",1570                  ,2500 ,oFontTit,oFontDesc,(nTamCarac*19),.F.})
				aAdd(aSessao[nSessao],{""     ,"CTO","CTO_SIMB"  ,"CTO_SIMB"  ,"C",1570 + (nTamCarac*16) ,500  ,oFontTit,oFontDesc,(0)           ,.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf
			
			// Abre a seção de totais
			If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == "NT2_SJUIZ" }) == 0 
				aAdd(aSessao, {"TotalGar",65,oFontSub,.T.,J095QryAlv(2),.T.})
				nSessao := Len(aSessao)
				
				//Saldo em juízo sem atualização
				cTitulo := IIf( nPos := ASCAN(aNZNVis, { |x| AllTrim(x[1]) == "NT2_SJUIZ" }) > 0,aNZNVis[nPos][2], JURX3INFO("NT2_SJUIZ","X3_TITULO"))
				aAdd(aSessao[nSessao],{cTitulo     ,"NT2","NT2_CAJURI","J095SalAtu('TTSA')","N",1570                  ,2500 ,oFontTit,oFontDesc,(nTamCarac*19),.F.})
				aAdd(aSessao[nSessao],{""          ,"CTO","CTO_SIMB"  ,"CTO_SIMB"          ,"C",1570 + (nTamCarac*16) ,2500 ,oFontTit,oFontDesc,(0)           ,.T.})

				If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == "NT2_SJUIZA" }) == 0 
					//Saldo em Juizo atualizado
					cTitulo := IIf( nPos := ASCAN(aNZNVis, { |x| AllTrim(x[1]) == "NT2_SJUIZA" }) > 0,aNZNVis[nPos][2], JURX3INFO("NT2_SJUIZA","X3_TITULO"))
					aAdd(aSessao[nSessao],{cTitulo ,"NT2","NT2_CAJURI","J095SalAtu"        ,"N",1570                  ,2500 ,oFontTit,oFontDesc,(nTamCarac*19),.F.})
					aAdd(aSessao[nSessao],{""      ,"CTO","CTO_SIMB"  ,"CTO_SIMB"          ,"C",1570 + (nTamCarac*16) ,2500 ,oFontTit,oFontDesc,(0)           ,.T.})
				Else
					If Len(aSessao) > 6
						aSessao[Len(aSessao)][11] := .T.
					EndIf
				EndIf
			EndIf
		
		Case cTabela == "NT3" // Despesas / Custas
		
			aNZN      := U_J95NznCpo(cAssJur,cTabela,cCfgRel)
			aNZNVis   := aNZN[1] // Campos Visíveis que tiveram a descrição alterada
			aNZNNot   := aNZN[2] // Campos Visíveis que tiveram a descrição alterada

			nSessao := Len(aSessao)
			
			aAdd(aSessao[nSessao], {""      ,"NSR","NSR_DESC" ,"NSR_DESC" ,"C",65  ,2500 ,oFontTit,oFontDesc,(0)          ,.T.})
			
			If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == "NT3_DATA" }) == 0
				//Data
				aAdd(aSessao[nSessao],{ IIf( nPos := ASCAN(aNZNVis, { |x| x[1] == "NT3_DATA" }) > 0,aNZNVis[nPos][2], JURX3INFO("NT3_DATA","X3_TITULO")) ,"NT3","NT3_DATA"  ,"NT3_DATA"  ,"D",65                    ,1000 ,oFontTit,oFontDesc,(nTamCarac*12),.F.})
			EndIf
			
			If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == "NT3_DMOEDA" }) == 0
				//Moeda
				aAdd(aSessao[nSessao],{ IIf( nPos := ASCAN(aNZNVis, { |x| x[1] == "NT3_DMOEDA" }) > 0,aNZNVis[nPos][2], JURX3INFO("NT3_DMOEDA","X3_TITULO")) ,"CTO","CTO_SIMB" ,"CTO_SIMB" ,"C",500 ,1500 ,oFontTit,oFontDesc,(nTamCarac*12),.F.})
			EndIf
			
			If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == "NT3_VALOR" }) == 0
				//Valor e Total
				aAdd(aSessao[nSessao],{ IIf( nPos := ASCAN(aNZNVis, { |x| x[1] == "NT3_VALOR" }) > 0,aNZNVis[nPos][2], JURX3INFO("NT3_VALOR","X3_TITULO")) ,"NT3","NT3_VALOR","NT3_VALOR","N",850 ,1500 ,oFontTit,oFontDesc,(nTamCarac*12),.T.})

				aAdd(aSessao, {"TotalCus",65,oFontSub,.T.,J095QryDes(2),.T.})
				nSessao := Len(aSessao)
				aAdd(aSessao[nSessao],{STR0021/*"Total"*/ ,"NT3","NT3_VALOR" ,"TOTAL"  ,"N",850  ,5200 ,oFontTit,oFontDesc,(nTamCarac*12),.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf

		Case cTabela == "O0W"
			DbSelectArea("O0W")
			lRdrPoss := ColumnPos('O0W_VRDPOS') > 0
			lRdrRem  := ColumnPos('O0W_VRDREM') > 0

			nSessao := Len(aSessao)
			aAdd(aSessao[nSessao],{STR0038,"NSP","NSP_DESC" ,"NSP_DESC" ,"C",65          ,600 ,oFontTit,oFontDesc,(nTamCarac*12),.F.})/*"Tipo do Pedido"*/
			aAdd(aSessao[nSessao],{STR0043,"O0W","O0W_PROGNO" ,"O0W_PROGNO" ,"C",475     ,750 ,oFontTit,oFontDesc,(nTamCarac*12),.F.})/*"Prognóstico"*/
			aAdd(aSessao[nSessao],{STR0044,"O0W","O0W_DATPED" ,"O0W_DATPED" ,"D",700     ,750 ,oFontTit,oFontDesc,(nTamCarac*12),.F.})/*"Data Pedido"*/
			aAdd(aSessao[nSessao],{STR0039,"O0W","O0W_VPEDID" ,"O0W_VPEDID" ,"N",930     ,750 ,oFontTit,oFontDesc,(nTamCarac*12),.F.})/*"Valor"*/
			aAdd(aSessao[nSessao],{STR0022,"O0W","O0W_VATPED" ,"O0W_VATPED" ,"N",1180    ,750 ,oFontTit,oFontDesc,(nTamCarac*12),.F.})/*"Valor Atualizado"*/
			aAdd(aSessao[nSessao],{STR0040,"O0W","O0W_VPROVA" ,"O0W_VPROVA" ,"N",1470    ,750 ,oFontTit,oFontDesc,(nTamCarac*12),.F.})/*"Provável"*/
			aAdd(aSessao[nSessao],{STR0041,"O0W","O0W_VATPRO" ,"O0W_VATPRO" ,"N",1710    ,750 ,oFontTit,oFontDesc,(nTamCarac*12),.F.})/*"Provável Atualizado"*/
			aAdd(aSessao[nSessao],{STR0042,"O0W","O0W_VLREDU" ,"O0W_VLREDU" ,"N",2020    ,750 ,oFontTit,oFontDesc,(nTamCarac*12),.T.})/*"Provavel com Redutor"*/

			aAdd(aSessao, {"TotalO0W",65,oFontSub,.F.,J095QryPed(2),.T.})

			nSessao := Len(aSessao)
			aAdd(aSessao[nSessao], {"" ,"O0W",""  ,"DescAgrupamento"  ,"C",65,2500 ,oFontSub,oFontDesc,(0),.T.}) // Resumo do Processo
			aAdd(aSessao[nSessao],{STR0040,"Total","O0W_VPROVA" ,"TOTVPROVA" ,"N", nEspaco       ,750 ,oFontTit,oFontDesc,(0),.F.})//"Provável"
			aAdd(aSessao[nSessao],{STR0051,"Total","O0W_VATPRO" ,"TOTVATPRO" ,"N", nEspaco += 290,750 ,oFontTit,oFontDesc,(0),.F.})//"Provável Atual"

			aAdd(aSessao[nSessao],{STR0053,"Total","O0W_VLREDU" ,"TOTVLREDU" ,"N", nEspaco += 290,750 ,oFontTit,oFontDesc,(0),.F.})//"% Historico Provavel"

			aAdd(aSessao[nSessao],{STR0045,"Total","O0W_VPOSSI" ,"TOTVPOSSI" ,"N", nEspaco += 290,750 ,oFontTit,oFontDesc,(0),.F.})//"Possível"
			aAdd(aSessao[nSessao],{STR0046,"Total","O0W_VATPOS" ,"TOTVATPOS" ,"N", nEspaco += 290,750 ,oFontTit,oFontDesc,(0),!lRdrPoss})//"Possível Atual"
			If lRdrPoss
				aAdd(aSessao[nSessao],{STR0054,"Total","O0W_VRDPOS" ,"TOTVRDPOS" ,"N", nEspaco += 290,750 ,oFontTit,oFontDesc,(0),.T.})//"% Historico Possível"
			EndIf

			aAdd(aSessao[nSessao],{STR0047,"Total","O0W_VREMOT" ,"TOTVREMOT" ,"N", nEspaco := 65     ,750 ,oFontTit,oFontDesc,(0),.F.})//"Remoto"
			aAdd(aSessao[nSessao],{STR0048,"Total","O0W_VATREM" ,"TOTVATREM" ,"N", nEspaco += 290    ,750 ,oFontTit,oFontDesc,(0),.F.})//"Remoto Atual"
			If lRdrRem
				aAdd(aSessao[nSessao],{STR0055,"Total","O0W_VRDREM" ,"TOTVRDREM" ,"N", nEspaco += 290,750 ,oFontTit,oFontDesc,(0),.F.})//"% Historico Remoto"
			EndIf
			aAdd(aSessao[nSessao],{STR0049,"Total","O0W_VINCON" ,"TOTVINCON" ,"N", nEspaco += 290    ,750 ,oFontTit,oFontDesc,(0),.F.})//"Incontroverso"
			aAdd(aSessao[nSessao],{STR0050,"Total","O0W_VATINC" ,"TOTVATINC" ,"N", nEspaco += 290    ,750 ,oFontTit,oFontDesc,(0),.F.})//"Incontroverso Atual"

		Case cTabela == "NSY" // Valores em Discussão / Pedidos

			aNUZ    := J095Campos(cAssJur,"NSY",cCfgRel)//Verifica os campos que foram alterados na configuração
			aNZN    := U_J95NznCpo(cAssJur,cTabela,cCfgRel)
			aNZNVis := aNZN[1] // Campos Visíveis que tiveram a descrição alterada
			aNZNNot := aNZN[2] // Campos Visíveis que tiveram a descrição alterada*/
			aCpoNSY := {"NSY_DPEVLR","NSY_DPROG","NSY_PEVLR","NSY_PEVLRA", "NSY_VLCONT", "NSY_VLCONA" }//campos apresentados no relatório
			
			nSessao := Len(aSessao)

			For nX := 1 to Len (aCpoNSY)
				If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == aCpoNSY[nX] }) == 0// Data
					If( nPos := ASCAN(aNUZ, { |x| AllTrim(x[1]) == aCpoNSY[nX] })) > 0
						Aadd(aDescNSY, aNUZ[nPos][2])
					ElseIf ( nPos := ASCAN(aNZNVis, { |x| AllTrim(x[1]) == aCpoNSY[nX]})) > 0
						Aadd(aDescNSY, aNZNVis[nPos][2])
					Else 
						Aadd(aDescNSY, JURX3INFO(aCpoNSY[nX],"X3_TITULO"))
					EndIf
				EndIf
			Next nX
			// Pedido
			If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == "NSY_DPEVLR" }) == 0
				aAdd(aSessao[nSessao],{aDescNSY[1], "NSP", "NSP_DESC", "NSP_DESC", "C", 65, 750, oFontTit, oFontDesc, (nTamCarac*16), .F.})
			EndIf
			// Prognóstico
			If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == "NSY_DPROG" }) == 0 
				aAdd(aSessao[nSessao],{aDescNSY[2], "NQ7", "NQ7_DESC", "NQ7_DESC", "C", 700, 500, oFontTit, oFontDesc, (nTamCarac*16), .F.})
			EndIf
			// Valor Pedido
			If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == "NSY_PEVLR" }) == 0	
				aAdd(aSessao[nSessao],{cValor := (aDescNSY[3]), "NSY", "NSY_PEVLR", "NSY_PEVLR", "N", 1070, 1000, oFontTit, oFontDesc, (nTamCarac*16), .F.})
			EndIf
			// Valor Pedido Atual
			If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == "NSY_PEVLRA" }) == 0	
				aAdd(aSessao[nSessao],{cValorA := (aDescNSY[4]), "NSY", "NSY_PEVLRA", "NSY_PEVLRA", "N", 1370, 1000, oFontTit, oFontDesc, (nTamCarac*16), .F.})
			EndIf
			// Valor Contingência
			If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == "NSY_VLCONT" }) == 0	
				aAdd(aSessao[nSessao],{cCont := (aDescNSY[5]), "NSY", "NSY_VLCONT", "NSY_VLCONT", "N", 1670, 1000, oFontTit, oFontDesc, (nTamCarac*16), .F.})
			EndIf
			// Valor Contingência Atual
			If ASCAN(aNZNNot, { |x| AllTrim(x[1]) == "NSY_VLCONA" }) == 0
				aAdd(aSessao[nSessao],{cContA := (aDescNSY[6]), "NSY", "NSY_VLCONA", "NSY_VLCONA", "N", 1970, 1000, oFontTit, oFontDesc, (nTamCarac*16), .T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf

			aAdd(aSessao, {"TotalPed",65,oFontSub,.T.,J095QryVal(2),.T.})
			nSessao := Len(aSessao)
	
			If !Empty(cValor)
				aAdd(aSessao[nSessao],{STR0021,"Total" ,"NSY","NSY_PEVLR" ,"TOTPEVLR","N",947  ,1000 ,oFontTit,oFontDesc,(nTamCarac*6),.F.})
			EndIf
			If !Empty(cValorA)
				aAdd(aSessao[nSessao],{""     ,"NSY","NSY_PEVLRA","TOTPEVLRA" ,"N",1370 ,1000 ,oFontTit,oFontDesc,(0)          ,.F.})
			EndIf
			If !Empty(cCont)
				aAdd(aSessao[nSessao],{""     ,"NSY","NSY_VLCONT","TOTVLCONT" ,"N",1670 ,1000 ,oFontTit,oFontDesc,(0)          ,.F.})
			EndIf
			If !Empty(cContA)
				aAdd(aSessao[nSessao],{""     ,"NSY","NSY_VLCONA","TOTVLCONA" ,"N",1970 ,1000 ,oFontTit,oFontDesc,(0)          ,.F.})
			EndIf
			aAdd(aSessao, {"TotalPed",65,oFontSub,.T.,J095QryVal(2),.T.})
			
			nSessao := Len(aSessao)
	
			If !Empty(cDesc)
				aAdd(aSessao[nSessao],{STR0021,"Total" ,"NSY","NSY_PEVLR" ,"TOTPEVLR"  ,"N",947  ,1000 ,oFontTit,oFontDesc,(nTamCarac*6),.F.})
			EndIf
			
		Case cTabela == "NT4" // Andamentos
		
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT4_DTANDA" })) > 0 // Data
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NT4","NT4_DTANDA","NT4_DTANDA","D",65  ,500  ,oFontTit,oFontDesc,(nTamCarac*16),.F.})
			EndIf
				
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT4_DATO" })) > 0 // Ato Processual
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NRO","NRO_DESC"  ,"NRO_DESC"  ,"C",300 ,400 ,oFontTit,oFontDesc,(nTamCarac*16),.F.})
			EndIf
			
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT4_NMPROC" })) > 0 // Num processo 
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NT4","NT4_NMPROC"  ,"NT4_NMPROC"  ,"C",800,400 ,oFontTit,oFontDesc,(nTamCarac*16),.F.})
			EndIf
				
			
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT4_DFASE" })) > 0 // Fase Processual
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NQG","NQG_DESC"  ,"NQG_DESC"  ,"C",1400,1300 ,oFontTit,oFontDesc,(nTamCarac*16),.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NT4_DESC" })) > 0 // Andamento
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NT4","NT4_DESC"  ,"RECNONT4"  ,"M",65  , 3000 ,oFontTit,oFontDesc,(nTamCarac*16),.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf

		Case cTabela == "NXY" // Aditivos

			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NXY_ADITIV" })) > 0 // Aditivo
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NXY","NXY_ADITIV","NXY_ADITIV","C",65  ,2800  ,oFontTit,oFontDesc,(nTamCarac*12) ,.T.})
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NXY_DTIPO" })) > 0 // Tipo
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NXY","NXY_DTIPO" ,"NXY_DTIPO" ,"C",65  ,1000 ,oFontTit,oFontDesc,(nTamCarac*12) ,.F.})
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NXY_DTASSI" })) > 0 // Data Assinatura
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NXY","NXY_DTASSI","NXY_DTASSI","D",1050 ,500 ,oFontTit,oFontDesc,(nTamCarac*12),.F.})
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NXY_NUMCON" })) > 0 // Número Contrato
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NXY","NXY_NUMCON","NXY_NUMCON","C",1550,2000 ,oFontTit,oFontDesc,(nTamCarac*12),.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NXY_OBJETO" })) > 0 // Observação
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NXY","NXY_OBJETO","RECNONXY"  ,"M",65  ,2800 ,oFontTit,oFontDesc,(nTamCarac*12),.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf

		Case cTabela == "NYP" // Acordos / Negociações
		
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NYP_DATA" })) > 0 // Data do Acordo
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NYP","NYP_DATA"  ,"NYP_DATA"  ,"D",65  ,500  ,oFontTit,oFontDesc,(nTamCarac*12),.F.})
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NYP_VALOR" })) > 0 // Valor
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {""    ,"NYP","NYP_DMOEDA","NYP_DMOEDA","C",550 + (nTamCarac*12),200  ,oFontTit,oFontDesc,(0)            ,.F.})
				aAdd(aSessao, {cDesc ,"NYP","NYP_VALOR" ,"NYP_VALOR" ,"N",550                 ,1500 ,oFontTit,oFontDesc,(nTamCarac*15) ,.F.})
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NYP_CONDPG" })) > 0 // Cond. Pagamento
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NYP","NYP_CONDPG","NYP_CONDPG","C",1200,2000 ,oFontTit,oFontDesc,(nTamCarac*12),.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NYP_DATALI" })) > 0 // Data Limite
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NYP","NYP_DATALI","NYP_DATALI","D",65  ,500  ,oFontTit,oFontDesc,(nTamCarac*12),.F.})
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NYP_TIPO" })) > 0 // Tipo
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NYP","NYP_TIPO"  ,"NYP_TIPO"  ,"O",550 ,2500 ,oFontTit,oFontDesc,(nTamCarac*12) ,.F.})
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NYP_REALIZ" })) > 0 // Realizado
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NYP","NYP_REALIZ","NYP_REALIZ","O",1200,2500 ,oFontTit,oFontDesc,(nTamCarac*12),.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NYP_OBSERV" })) > 0 // Observação
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NYP","NYP_OBSERV","RECNONYP"  ,"M",65  ,2800 ,oFontTit,oFontDesc,(nTamCarac*12),.T.})
			Else
				If Len(aSessao) > 6
					aSessao[Len(aSessao)][11] := .T.
				EndIf
			EndIf
			
		Case cTabela == "NUQ" // Instância
			
			/*
			Instância 1a Instancia 
			Natureza Judicial
			Núm Processo 15151515171
			Distribuição 02/12/2015 
			Tipo de Ação Vinculo empregaticio
			Comarca Sao Paulo 
			Foro/Tri Tribunal de Justica
			Vara/Cam 3a Camara do Tribunal de Justi
			
			*/

			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NUQ_INSTAN" })) > 0 
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NUQ","NUQ_INSTAN","NUQ_INSTAN","O",65  ,1000  ,oFontTit,oFontDesc,(nTamCarac*20),.F.})
			EndIf

			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NUQ_INSATU" })) > 0 
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NUQ","NUQ_INSATU","NUQ_INSATU","O",1270,1000  ,oFontTit,oFontDesc,(nTamCarac*20),.T.})
			EndIf

			
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NUQ_NUMPRO" })) > 0 
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NUQ","NUQ_NUMPRO","NUQ_NUMPRO","C",65,1000  ,oFontTit,oFontDesc,(nTamCarac*20),.F.})
			EndIf

			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NUQ_DTIPAC" })) > 0 
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NUQ","NUQ_DTIPAC","NUQ_DTIPAC","C",1270 ,1000  ,oFontTit,oFontDesc,(nTamCarac*20),.T.})
			EndIf
			
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NUQ_NUMANT" })) > 0 
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NUQ","NUQ_NUMANT","NUQ_NUMANT","C",65  ,1000  ,oFontTit,oFontDesc,(nTamCarac*20),.F.})
			EndIf

			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NUQ_NUMANT" })) > 0 
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NUQ","NUQ_NUMANT","NUQ_NUMANT","C",1270 ,1000    ,oFontTit,oFontDesc,(nTamCarac*20),.T.})
			EndIf			
			
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NUQ_DTDIST" })) > 0 
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NUQ","NUQ_DTDIST","NUQ_DTDIST","D",65  ,1000  ,oFontTit,oFontDesc,(nTamCarac*20),.F.})
			EndIf
			
						
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NUQ_DCOMAR" })) > 0 
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NUQ","NUQ_DCOMAR","NUQ_DCOMAR","C",1270 ,1000 ,oFontTit,oFontDesc,(nTamCarac*20),.T.})
			EndIf
			
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NUQ_DLOC2N" })) > 0 
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NUQ","NUQ_DLOC2N","NUQ_DLOC2N","C",65  ,1000   ,oFontTit,oFontDesc,(nTamCarac*20),.F.})
			EndIf
			
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NUQ_DLOC3N" })) > 0 
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NUQ","NUQ_DLOC3N","NUQ_DLOC3N","C",1270 ,1000  ,oFontTit,oFontDesc,(nTamCarac*20),.T.})
			EndIf
			
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NUQ_DLOC4N" })) > 0 
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NUQ","NUQ_DLOC4N","NUQ_DLOC4N","C",65  ,1000   ,oFontTit,oFontDesc,(nTamCarac*20),.F.})
			EndIf
			
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NUQ_DTEXEC" })) > 0 
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NUQ","NUQ_DTEXEC","NUQ_DTEXEC","D",1270  ,1000   ,oFontTit,oFontDesc,(nTamCarac*20),.T.})
			EndIf
			
			If (nPos := ASCAN(aCampos, { |x| AllTrim(x[1]) == "NUQ_DTDECI" })) > 0 
				cDesc := aCampos[nPos][2]
				aAdd(aSessao, {cDesc ,"NUQ","NUQ_DTDECI","NUQ_DTDECI","D",65  ,1000   ,oFontTit,oFontDesc,(nTamCarac*20),.F.})
			EndIf
			
			aSessao[6] := .T.

	End Case

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} JURX3INFOS
Função genérica para retornar mais de uma informação de um campo do SX3

@param 	cCampo	 	Nome do campo
@param 	cInfo	 	Informacao a retornar
@Return aRet		Array com as informações da X3
@author Jorge Luis Branco Martins Junior
@since 13/05/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JURX3INFOS( cCampo, aInfo )
Local xRet 		:= ""
Local aRet 		:= {}
Local aAreaSAV  := GetArea()
Local nPos		:= 0
Local nI := 0

Default aInfo  := {"X3_TITULO"}

If !Empty(cCampo)

	For nI := 1 to Len(aInfo)
	
		cInfo := AllTrim(aInfo[nI])
		
		nPos := aScan( __x3Cache, { |x| AllTrim( Upper( x[1] ) ) == AllTrim( Upper( cCampo ) ) .AND. ;
		AllTrim( Upper( x[2] ) ) == AllTrim( Upper( cInfo ) ) } )
		
		If nPos == 0
		
			Do Case
				Case cInfo == "X3_TITULO"	
					xRet :=	AllTrim( GetSx3Cache(cCampo, 'X3_TIPO') )
		
				Case cInfo == "X3_DESCRIC"
					xRet := AllTrim( GetSx3Cache(cCampo, 'X3_DESCRIC') )
				
				Case cInfo == "X3_CBOX"
					xRet := AllTrim( GetSx3Cache(cCampo, 'X3_CBOX') )
				
				OtherWise
					cVar := cInfo
					xRet := AllTrim( GetSx3Cache(cCampo, cVar) )
			End Case		
		
			aAdd( __x3Cache, { cCampo, cInfo, xRet } )
			nPos := Len( __x3Cache )
			
		EndIf
		
		aAdd(aRet,__x3Cache[nPos][3])
	
	Next

EndIf

RestArea( aAreaSAV )

Return aRet

//-------------------------------------------------------------------
/*/{Protheus.doc} J095QryIns()
Monta a Query de Instancia
 
@Return cQuery Query dos andamentos

@author Marcelo Araujo Dente
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J095QryIns()
Local cQuery  := " SELECT NUQ.D_E_L_E_T_ "
Local cRelacao := ""
Local aCampos := {}
Local aTabelas := {'NQ6','NQC', 'NQE', 'NY3', 'NQ1', 'NQU'}
Local nI      := 0

public cTipoAsJ := Iif(Empty(cTipoAsJ), "001", cTipoAsJ)

	// Busca os campos da NUQ
	 aCampos := aFields := aClone(FWFormStruct( 2, 'NUQ',  ):aFields) 

	// Insere os campos no select
	For nI := 1 To Len(aCampos)

		cRelacao := AllTrim(aCampos[nI][15])

		If Rat("_",cRelacao) > 0 
			cRelacao := SubStr(cRelacao, Rat("_", cRelacao) -3)
			cRelacao = SubStr(cRelacao, 0, Rat("'", cRelacao) -1)

			If aScan(aTabelas,SubStr(cRelacao,0,3)) > 0
				cQuery += ", " + cRelacao + " " + AllTrim(aCampos[nI][1])
			EndIf
		ElseIf (! aCampos[nI][16]) // Se não for virtual
			cQuery += ", " + AllTrim(aCampos[nI][1])
		EndIf
	Next nI

	cQuery += " FROM " + RetSqlName("NUQ") + " NUQ "
	
	cQuery += " LEFT JOIN " + RetSqlName("NQ6") + " NQ6 "
	cQuery +=   " ON (NQ6.NQ6_FILIAL = '"+xFilial("NQ6")+"' "
	cQuery +=        " AND NQ6_COD = NUQ.NUQ_CCOMAR "
	cQuery +=        " AND NQ6.D_E_L_E_T_ = ' ')"
	
	cQuery += " LEFT JOIN " + RetSqlName("NQC") + " NQC "
	cQuery +=   " ON (NQC.NQC_FILIAL = '"+xFilial("NQC")+"' "
	cQuery +=        " AND NQC_COD = NUQ.NUQ_CLOC2N "
	cQuery +=        " AND NQC.D_E_L_E_T_ = ' ')"
	
	cQuery += " LEFT JOIN " + RetSqlName("NQE") + " NQE "
	cQuery +=   " ON (NQE.NQE_FILIAL = '"+xFilial("NQE")+"' "
	cQuery +=        " AND NQE_COD = NUQ.NUQ_CLOC3N "
	cQuery +=        " AND NQE.D_E_L_E_T_ = ' ')"
	
	cQuery += " LEFT JOIN " + RetSqlName("NY3") + " NY3 "
	cQuery +=   " ON (NY3.NY3_FILIAL = '"+xFilial("NY3")+"' "
	cQuery +=        " AND NY3_COD = NUQ.NUQ_CLOC4N "
	cQuery +=        " AND NY3.D_E_L_E_T_ = ' ')"
		
	cQuery += " LEFT JOIN " + RetSqlName("NQ1") + " NQ1 "
	cQuery +=   " ON (NQ1.NQ1_FILIAL = '"+xFilial("NQ1")+"' "
	cQuery +=        " AND NQ1_COD = NUQ.NUQ_CNATUR "
	cQuery +=        " AND NQ1.D_E_L_E_T_ = ' ')"
		
	cQuery += " LEFT JOIN " + RetSqlName("NQU") + " NQU "
	cQuery +=   " ON (NQU.NQU_FILIAL = '"+xFilial("NQU")+"' "
	cQuery +=        " AND NQU_COD = NUQ.NUQ_CTIPAC "
	cQuery +=        " AND NQU.D_E_L_E_T_ = ' ')"

	cQuery += " WHERE NUQ.D_E_L_E_T_ = ' ' "
	cQuery +=   " AND NUQ.NUQ_CAJURI = '@#NSZ_COD#@' "
	cQuery +=   " AND NUQ.NUQ_FILIAL = '@#NSZ_FILIAL#@' "

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} JRSetSessao()
Cria a estrutura do relatório de acordo com o assunto jurídico

@param cAssJur - Assunto jurídico
@param aRelat  - Dados do título do relatório
@param aCabec  - Dados do cabeçalho do relatório
@param aSessao - Dados do conteúdo do relatório
@param aNSZ    - Campos do relatório por agrupamento
@param cCfgRel - Código da configuração do relatório
@param aParams - Parametros de definição de layout do relatório

@Return aSessaoAux - Dados da estrutura do layout do relatório

@since 06/08/2021
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JRSetSessao(cAssJur, aRelat, aCabec, aSessao, aNSZ, cCfgRel, aParams)

Local oFont      := TFont():New("Arial",,-20,,.T.,,,,.T.,.F.) // Fonte usada no nome do relatório
Local oFontDesc  := TFont():New("Arial",,-12,,.F.,,,,.T.,.F.) // Fonte usada nos textos
Local oFontTit   := TFont():New("Arial",,-12,,.T.,,,,.F.,.F.) // Fonte usada nos títulos do relatório (Título de campos e títulos no cabeçalho)
Local oFontSub   := TFont():New("Arial",,-14,,.T.,,,,.F.,.F.) // Fonte usada nos títulos do dos antigos subreports no relatório
Local aDetalhe   := {}
Local aValores   := {}
Local aLiminar   := {}
Local aEncerra   := {}
Local aSessaoAux := {}
Local cRelat     := ""

Default cAssJur := "001"

	cRelat := JurGetDados("NYB",1,XFILIAL("NYB")+cAssJur, "NYB_DESC")

	//Título do Relatório
	// 1 - Título,
	// 2 - Posição da descrição,
	// 3 - Fonte do título
	// 4 - Indica se a orientação do relatório será Retrato (R) ou Paisagem (P)
	// aRelat := {cRelat,((2440-(10*Len(cRelat)))/2),oFont,"R"}
	aAdd( aRelat, { cRelat,((2440-(10*Len(cRelat)))/2),oFont,"R"} )

	//Cabeçalho do Relatório
	// 1 - Título, 
	// 2 - Conteúdo, 
	// 3 - Posição de início da descrição(considere 20,5 para cada caractere do título, ou seja se o título tiver 6 caracteres indique 6x20,5 = 123. 
	//     Indique esse número para todos os itens do cabeçalho, para que todos tenham o mesmo alinhamento. 
	//     Para isso considere sempre a posição da maior descrição),
	// 4 - Fonte do título, 
	// 5 - Fonte da descrição
	// aCabec := {{STR0001 /*"Impressão"*/       ,DToC(Date()),(nTamCarac*16),oFontTit,oFontDesc},;
	// 		{STR0002 /*"Assunto Jurídico"*/,"CAJURI"    ,(nTamCarac*16),oFontTit,oFontDesc}}
	aAdd( aCabec, {{STR0001 /*"Impressão"*/       ,DToC(Date()),(nTamCarac*16),oFontTit,oFontDesc},;
			{STR0002 /*"Assunto Jurídico"*/,"CAJURI"    ,(nTamCarac*16),oFontTit,oFontDesc}} )

	// Organização dos campos em seus agrupamentos para divisão no relatório
	aEval(aNSZ,{|aX| Iif(aX[4] == "002", aAdd(aDetalhe,aX),) })
	aEval(aNSZ,{|aX| Iif(aX[4] == "003", aAdd(aValores,aX),) })
	aEval(aNSZ,{|aX| Iif(aX[4] == "004", aAdd(aLiminar,aX),) })
	aEval(aNSZ,{|aX| Iif(aX[4] == "005", aAdd(aEncerra,aX),) })

	//Campos do Relatório
	//Exemplo da primeira parte -> aAdd(aSessao, {"Detalhe",65,oFontSub,.F.,"",.F.,;// 
	// 1 - Título da sessão do relatório,
	// 2 - Posição de início da descrição, 
	// 3 - Fonte no quadro com título da sessão,
	// 4 - Impressão na horizontal? -> Título e descrição na mesma linha (Ex: Data: 01/01/2016)
	// 5 - Query do subreport - Se for parte do relatório principal não precisa ser indicado
	// 6 - Indica se deve incluir linha antes da impressão da sessão - Usado para sessões de totalizadores
	// 7 - Arrays a partir da 7ª posição
		// 1 - Título do campo,
		// 2 - Tabela do campo,
		// 3 - Nome do campo no dicionário,
		// 4 - Nome do Campo na Query,
		// 5 - Tipo do Campo,
		// 6 - Indica a coordenada horizontal em pixels ou caracteres, 
		// 7 - Tamanho que o conteúdo pode ocupar,
		// 8 - Fonte do título, 
		// 9 - Fonte da descrição
		// 10 - Posição de início da descrição
		// 11 - Quebra Linha após impressão do conteúdo?

	// Sessão Detalhe terá Envolvidos, Detalhe do assunto jurídico e Instância

	//Envolvidos
	aAdd(aSessao, {STR0003 /*"Detalhe"*/,65,oFontSub,.F.,J095QryEnv(),.F.,;
					{"" ,"NQA","NQA_DESC","NQA_DESC","C",65 ,460 ,oFontTit,oFontTit ,(0) ,.F.},;  //65,460
					{"" ,"NT9","NT9_NOME","NT9_NOME","C",470,2800,oFontTit,oFontDesc,(0) ,.T.}})  //470,2000

	//Detalhes do assunto
	aAdd(aSessao, {"" ,65,oFontSub,.T.,"",.F.})// Título da sessão do relatório
	JDefSessao(aDetalhe,@aSessao[Len(aSessao)],oFontTit,oFontDesc) // Monta array com os campos da sessão

	// Instâncias
	aAdd(aSessao, {STR0033 /*"Instancias"*/,65,oFontSub,.T.,J095QryIns(),.F.})// Título da sessão do relatório
	JDefSubs(J095Campos(cAssJur,"NUQ",cCfgRel),@aSessao[Len(aSessao)],oFontTit,oFontDesc,,"NUQ",cAssJur,cCfgRel) // Monta array com os campos da sessão

	aAdd(aSessao, {STR0034 /*"Incidentes"*/,65,oFontSub,.F.,J095QryInc(),.F.})
	JDefSubs(aDetalhe,@aSessao[Len(aSessao)],oFontTit,oFontDesc,,"INC",,cCfgRel)

	aAdd(aSessao, {STR0035 /*"Vinculados"*/,65,oFontSub,.F.,J095QryVin(),.F.})
	JDefSubs(aDetalhe,@aSessao[Len(aSessao)],oFontTit,oFontDesc,,"NVO",,cCfgRel)

	aAdd(aSessao, {STR0004 /*"Relacionados"*/,65,oFontSub,.F.,J095QryRel(),.F.})
	JDefSubs(aDetalhe,@aSessao[Len(aSessao)],oFontTit,oFontDesc,,"NXX",,cCfgRel)

	aAdd(aSessao, {STR0005 /*"Valores"*/,65,oFontSub,.T.,"",.F.})// Título da sessão do relatório
	JDefSessao(aValores,@aSessao[Len(aSessao)],oFontTit,oFontDesc) // Monta array com os campos da sessão

	aAdd(aSessao, {STR0006 /*"Liminar"*/,65,oFontSub,.T.,"",.F.})// Título da sessão do relatório
	JDefSessao(aLiminar,@aSessao[Len(aSessao)],oFontTit,oFontDesc) // Monta array com os campos da sessão

	If (Len(aParams) >= 13) .And.(aParams[13] == "S") // Imprime Valores Históricos?
		aAdd(aSessao, {STR0007 /*"Valores Históricos"*/,65,oFontSub,.F.,J095QryVlH(aParams[14]),.F.})
		JDefSubs(,@aSessao[Len(aSessao)],oFontTit,oFontDesc,,"NYZ",cAssJur,cCfgRel)
	EndIf

	aAdd(aSessao, {STR0008 /*"Encerramento"*/,65,oFontSub,.T.,"",.F.})// Título da sessão do relatório
	JDefSessao(aEncerra,@aSessao[Len(aSessao)],oFontTit,oFontDesc) // Monta array com os campos da sessão

	aAdd(aSessao, {STR0009 /*"Detalhamento Envolvidos"*/,65,oFontSub,.T.,J095QryDtE(),.F.})
	JDefSubs(J095Campos(cAssJur,"NT9",cCfgRel),@aSessao[Len(aSessao)],oFontTit,oFontDesc,oFontSub,"NT9",,cCfgRel)

	If (Len(aParams) >= 11) .And. (aParams[11] == "S") // Imprime garantias?
		JDefSubs(,@aSessao,oFontTit,oFontDesc,oFontSub,"NT2",cAssJur,cCfgRel)
	EndIf

	aAdd(aSessao, {STR0010 /*"Custas"*/,65,oFontSub,.T.,J095QryDes(1),.F.})
	JDefSubs(,@aSessao,oFontTit,oFontDesc,oFontSub,"NT3",cAssJur,cCfgRel)

	aAdd(aSessao, {STR0011 /*"Objetos"*/,65,oFontSub,.F.,J095QryVal(1),.F.})
	JDefSubs(, @aSessao, oFontTit, oFontDesc, oFontSub, "NSY", cAssJur, cCfgRel)

	If FwAliasinDIc('O0W')
		aAdd(aSessao, {STR0037/*"Pedidos"*/,65,oFontSub,.F.,J095QryPed(),.F.})
		JDefSubs(, @aSessao, oFontTit, oFontDesc, oFontSub, "O0W", cAssJur, cCfgRel)
	EndIf
	
	If (Len(aParams) >= 9) .And. (aParams[3] == "S") // Imprime Andamentos?
		aAdd(aSessao, {STR0012 /*"Andamentos"*/,65,oFontSub,.F.,J095QryAnd(aParams),.F.})
		JDefSubs(J095Campos(cAssJur,"NT4",cCfgRel),@aSessao[Len(aSessao)],oFontTit,oFontDesc,,"NT4",cAssJur,cCfgRel)
	EndIf

	aAdd(aSessao, {STR0013 /*"Aditivos"*/,65,oFontSub,.T.,J095QryAdi(),.F.})
	JDefSubs(J095Campos(cAssJur,"NXY",cCfgRel),@aSessao[Len(aSessao)],oFontTit,oFontDesc,,"NXY",cAssJur,cCfgRel)

	aAdd(aSessao, {STR0014 /*"Negociações"*/,65,oFontSub,.T.,J095QryAco(),.F.})
	JDefSubs(J095Campos(cAssJur,"NYP",cCfgRel),@aSessao[Len(aSessao)],oFontTit,oFontDesc,,"NYP",cAssJur,cCfgRel)

	aAdd( aSessaoAux, aSessao )

Return aSessaoAux

//-------------------------------------------------------------------
/*/{Protheus.doc} J095QryPed
Função para a geração da query do relatório padrão em PDF

@param nTipo   Variável para gerar a query, 1 = detalhe 2 = totalizadores
        

@Return cQuery

@author Glória Maria Ribeiro Souza
@author Carolina Neiva Ribeiro
@since 12/07/2022
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J095QryPed(nTipo)
Local cQuery := ""
Default nTipo  := 1

	If nTipo = 1

		cQuery := "SELECT NSP.NSP_DESC NSP_DESC, " 
		cQuery +=       " O0W.O0W_DATPED O0W_DATPED, " 
		cQuery +=       " O0W.O0W_VPEDID O0W_VPEDID, " 
		cQuery +=       " O0W.O0W_VATPED O0W_VATPED, " 
		cQuery +=       " O0W.O0W_VPROVA O0W_VPROVA, " 
		cQuery +=       " O0W.O0W_VATPRO O0W_VATPRO, " 
		cQuery +=       " O0W.O0W_PROGNO O0W_PROGNO,  " 
		cQuery +=       " O0W.O0W_VLREDU O0W_VLREDU  "
		cQuery += " FROM " + RetSqlName("O0W") + " O0W "  
		cQuery +=  " LEFT OUTER JOIN " + RetSqlName("NSP") + " NSP ON ( "  
		cQuery +=            " O0W.D_E_L_E_T_ = NSP.D_E_L_E_T_ AND " 
		cQuery +=            " O0W.O0W_CTPPED = NSP.NSP_COD AND " 
		cQuery +=            " NSP.NSP_FILIAL = '"+xFilial("NSP")+"') " 
		cQuery += " WHERE O0W.D_E_L_E_T_ = ' ' AND O0W.O0W_CAJURI = '@#NSZ_COD#@' "
		cQuery +=   " AND O0W.O0W_FILIAL = '@#NSZ_FILIAL#@' "
	Else  
		cQuery := "SELECT '" + STR0052 + "' DescAgrupamento, " // Resumo do Processo 
		cQuery +=       " SUM(O0W_VPEDID) TOTVPEDID, "
		cQuery +=       " SUM(O0W_VATPED) TOTVATPED, "
		cQuery +=       " SUM(O0W_VPROVA) TOTVPROVA, " 
		cQuery +=       " SUM(O0W_VATPRO) TOTVATPRO, "
		cQuery +=       " SUM(O0W_VPOSSI) TOTVPOSSI, "
		cQuery +=       " SUM(O0W_VATPOS) TOTVATPOS, " 
		cQuery +=       " SUM(O0W_VREMOT) TOTVREMOT, "
		cQuery +=       " SUM(O0W_VATREM) TOTVATREM, "
		cQuery +=       " SUM(O0W_VINCON) TOTVINCON, " 
		cQuery +=       " SUM(O0W_VATINC) TOTVATINC, " 
		cQuery +=       " SUM(O0W_VLREDU) TOTVLREDU  "
		DbSelectArea("O0W")
		If ColumnPos('O0W_VRDPOS') > 0 .And. ColumnPos('O0W_VRDREM') > 0
			cQuery +=       " ,SUM(O0W_VRDREM) TOTVRDREM,  "
			cQuery +=       " SUM(O0W_VRDPOS) TOTVRDPOS  "
		EndIf
		cQuery += "FROM " + RetSqlName("O0W") + " O0W " 
		cQuery += " WHERE O0W.D_E_L_E_T_ = ' ' "
		cQuery +=   " AND O0W.O0W_CAJURI = '@#NSZ_COD#@' "
		cQuery +=   " AND O0W.O0W_FILIAL = '@#NSZ_FILIAL#@' "
	EndIf
Return cQuery



