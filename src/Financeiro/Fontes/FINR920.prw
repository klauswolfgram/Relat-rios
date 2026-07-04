/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "finr920.ch"
#INCLUDE "Protheus.ch"

//-----------------------------------------------------------------------
/*/{Protheus.doc} FinA39Finr9200
Relacao de titulos a pagar pendente liberacao.  

@author  Nilton Pereira
@since 22/01/2005
@version 12
/*/
//-----------------------------------------------------------------------
User Function Finr920()

Local cDesc1		:= STR0001 //"Imprime relação de titulos a pagar mostrando quais "
Local cDesc2		:= STR0002 //"titulos ja foram liberados ou que ainda estão "
Local cDesc3		:= STR0003 //"aguardando liberação."
Local titulo		:= STR0004 //"Liberação de Titulos a Pagar"
Local nLin			:= 80
Local Cabec1		:= "" 
Local Cabec2      	:= ""
Local imprime		:= .T.
Local aOrd			:= {STR0005,STR0006,STR0007} //"Por Codigo Fornecedor"###"Por Nome Fornecedor"###"Por Data de Emissao"
Local cPerg			:= "FIN920"

Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 132
Private tamanho      := "M"
Private nomeprog     := "Finr920"
Private nTipo        := 18
Private aReturn      := { STR0008, 1, STR0009, 2, 2, 1, "", 1} //"Zebrado"###"Administracao"
Private nLastKey     := 0
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "Finr920"
Private cString      := "SE2"

//----------------------------------------------------------------------
// So imprime caso o parametro MV_CTLIPAG estiver ligado.
//----------------------------------------------------------------------
If !GetMV("MV_CTLIPAG")
	MsgInfo(STR0010,STR0011) //"Para impressao deste relatório, os titulos devem esta usando controle de liberação manual (MV_CTLIPAG)"###"Relatório Desativado"
	Return
Endif	

//----------------------------------------------------------------------
// Verifica as perguntas selecionadas
//----------------------------------------------------------------------
SetKey (VK_F12,{|a,b| AcessaPerg(cPerg,.T.)})

//----------------------------------------------------------------------
// Variaveis utilizadas para parametros
// mv_par01		 // Fornecedor de?
// mv_par02		 // Fornecedor ate?
// mv_par03		 // Da Loja ?
// mv_par04		 // Ate Loja ?
// mv_par05		 // De Emissao?
// mv_par06		 // Ate Emissao?
// mv_par07		 // Imprime: (Pendentes/Liberados/Ambos)
//----------------------------------------------------------------------
Pergunte(cPerg,.F.)

dbSelectArea("SE2")
dbSetOrder(1)

//----------------------------------------------------------------------
// Monta a interface padrao com o usuario...
//----------------------------------------------------------------------
wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//----------------------------------------------------------------------
// Processamento. RPTSTATUS monta janela com a regua de processamento.
//----------------------------------------------------------------------
RptStatus({|| Fr920Imp(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Return


//-----------------------------------------------------------------------
/*/{Protheus.doc} Fr920Imp
Impressão do relatório

@author  Nilton Pereira
@since 22/01/2005
@version 12
/*/
//-----------------------------------------------------------------------
Static Function Fr920Imp(Cabec1,Cabec2,Titulo,nLin)

//----------------------------------------------------------------------
// Declaracao de Variaveis
//----------------------------------------------------------------------
Local nOrdem    := aReturn[8]   
Local aCampos   := {}
Local nValSub   := 0
Local nValTot   := 0
Local cQuery    := ""
Local nCount    := 0
Local cArqTrab	:= GetNextAlias()
Local nValMinPg := SuperGetMV("MV_VLMINPG",.F.,0)

aCampos	:= {	{"PREFIXO"  ,"C",TamSx3("E2_PREFIXO")[1] ,0 },;
				{"NUM"		,"C",TamSx3("E2_NUM")[1]     ,0 },;
				{"PARCELA"	,"C",TamSx3("E2_PARCELA")[1] ,0 },;
				{"TIPO"		,"C",TamSx3("E2_TIPO")[1]    ,0 },;
				{"CODIGO"	,"C",TamSx3("E2_FORNECE")[1] ,0 },;
				{"LOJA"	    ,"C",TamSx3("E2_LOJA")[1]    ,0 },;
				{"NOMEFOR"	,"C",TamSx3("E2_NOMFOR")[1]  ,0 },;
				{"EMISSAO"	,"D",TamSx3("E2_EMISSAO")[1] ,0 },;
				{"VENCTO"	,"D",TamSx3("E2_VENCTO")[1]  ,0 },;
				{"VALOR"	,"N",TamSx3("E2_VALOR")[1]   ,2 },;
				{"DTLIBERA"	,"D",TamSx3("E2_DATALIB")[1] ,0 },;
				{"USULIBERA","C",TamSx3("E2_USUALIB")[1] ,0 }}


If nOrdem == 1      //Por Codigo
	cOrder := "CODIGO,LOJA"
ElseIf nOrdem == 2  //Por Nome
	cOrder := "NOMEFOR"
ElseIf nOrdem == 3  //Emissao
	cOrder := "EMISSAO"
Endif

cQuery := "SELECT A2_COD CODIGO,A2_LOJA LOJA,A2_NOME NOMEFOR,E2_PREFIXO PREFIXO,"
cQuery += "E2_NUM NUM,E2_PARCELA PARCELA,E2_TIPO TIPO,E2_EMISSAO EMISSAO,E2_VENCREA VENCTO,"
cQuery += "E2_VALOR VALOR,E2_DATALIB DTLIBERA, E2_USUALIB USULIBERA "
cQuery += "FROM "+RetSqlName("SE2")+" SE2,"
cQuery +=         RetSqlName("SA2")+" SA2 "
cQuery += " WHERE SE2.E2_FILIAL = '" + xFilial("SE2") + "'"
cQuery += " AND SA2.A2_FILIAL   = '" + xFilial("SA2") + "'"
cQuery += " AND SE2.D_E_L_E_T_  = ' ' "
cQuery += " AND SA2.D_E_L_E_T_  = ' ' "
cQuery += " AND SE2.E2_FORNECE  =  SA2.A2_COD"
cQuery += " AND SE2.E2_LOJA	  =  SA2.A2_LOJA"
cQuery += " AND SE2.E2_FORNECE  between '" + mv_par01 + "' AND '" + mv_par02 + "'"
cQuery += " AND SE2.E2_LOJA     between '" + mv_par03 + "' AND '" + mv_par04 + "'"
cQuery += " AND SE2.E2_SALDO = SE2.E2_VALOR "
cQuery += " AND SE2.E2_EMISSAO  between '" + DTOS(mv_par05)  + "' AND '" + DTOS(mv_par06) + "'"

If mv_par07 == 1 		//Liberados
	cQuery += " AND ( "
	cQuery +=      "(E2_DATALIB <> ' ') OR "
	cQuery +=      "(E2_DATALIB = ' ' AND E2_SALDO+E2_SDACRES-E2_SDDECRE <= " + Alltrim(Str(nValMinPg)) +") "
	cQuery +=      ") "
ElseIf mv_par07 == 2	//Não liberados
	cQuery += "AND (E2_DATALIB = ' ' AND "
	cQuery +=      "E2_SALDO+E2_SDACRES-E2_SDDECRE > "+ Alltrim(Str(nValMinPg)) +") "
Endif

cQuery += " ORDER BY "+ cOrder
cQuery := ChangeQuery(cQuery)

dbSelectArea("SE2")
dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cArqTrab, .F., .T.)

IncProc()
dbSelectArea(cArqTrab)
dbgotop()
dbeval({||nCount++})
dbgotop()
IncProc()
SetRegua(nCount)

TcSetField(cArqTrab,"EMISSAO"   ,"D", 08,0)
TcSetField(cArqTrab,"VENCTO"    ,"D", 08,0)
TcSetField(cArqTrab,"DTLIBERA"  ,"D", 08,0)

If nOrdem == 1 .Or. nOrdem == 2  //Por Codigo ou Nome
	If nOrdem == 1 //Por Codigo 
		titulo := STR0012 //"Liberação de Titulos a Pagar - Por Codigo Fornecedor"
	Else // Por Nome
		titulo := STR0013	 //"Liberação de Titulos a Pagar - Por Nome Fornecedor"
	Endif
	Cabec1      := STR0014 //"                                     Prf  Numero  Pc Tipo Emissao    Vencto.              Valor     Dt. Lib.    Usuario"
Else // Por Emissao 
	titulo      := STR0015	 //"Liberação de Titulos a Pagar - Por Emissao"
	Cabec1      := STR0016 //" Cod.   Loja   Nome                  Pre  Numero  Pc Tipo            Vencto.              Valor     Dt. Lib.    Usuario"
Endif

(cArqTrab)->(dbGoTop())

While (cArqTrab)->(!EOF())
	//----------------------------------------------------------------------
	// Verifica o cancelamento pelo usuario...
	//----------------------------------------------------------------------
	If lAbortPrint
		@nLin,00 PSAY STR0017 //"*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif          
	
	//----------------------------------------------------------------------
	// Impressao do cabecalho do relatorio. . .
	//----------------------------------------------------------------------
	If nLin > 55 
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 8
	Endif
	If nOrdem == 1 .Or. nOrdem == 2
		cForLoj := (cArqTrab)->CODIGO + (cArqTrab)->LOJA
		cCondFil := "cForLoj == (cArqTrab)->CODIGO + (cArqTrab)->LOJA" 
		cTexSub  := STR0018            //"Sub-Total Por Fornecedor  : "
		If nOrdem == 1
			@nLin, 001 PSAY STR0019 + cForLoj + " - " + (cArqTrab)->NOMEFOR //"Codigo Fornecedor: "
			nLin     := nLin + 1 		
		Else
			@nLin, 001 PSAY STR0020 + cForLoj + " - " + (cArqTrab)->NOMEFOR //"Nome Fornecedor: "
			nLin     := nLin + 1 		
		Endif
	Else
		dEmissao := (cArqTrab)->EMISSAO
		cCondFil := "dEmissao == (cArqTrab)->EMISSAO"
		cTexSub  := STR0021 //"Sub-Total Por Emissao     : "
		@nLin, 001 PSAY STR0022 + dtoc(dEmissao) //"Data de Emissao: "
		nLin     := nLin + 1 		
	Endif	

	While (cArqTrab)->(!Eof()) .And. &cCondFil
		//----------------------------------------------------------------------
		// Impressao do cabecalho do relatorio. . .
		//----------------------------------------------------------------------
		If nLin > 55 
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		Endif
		IncRegua((cArqTrab)->(PREFIXO+NUM+PARCELA+TIPO))
		If nOrdem == 3
			@nLin, 001 PSAY (cArqTrab)->CODIGO + " " + (cArqTrab)->LOJA
			@nLin, 015 PSAY Substr((cArqTrab)->NOMEFOR,1,20)
		Endif
		@nLin, 037 PSAY (cArqTrab)->PREFIXO	                
		@nLin, 042 PSAY (cArqTrab)->NUM	
		@nLin, 050 PSAY (cArqTrab)->PARCELA	
		@nLin, 053 PSAY (cArqTrab)->TIPO             
		If nOrdem <> 3
			@nLin, 058 PSAY (cArqTrab)->EMISSAO          
		Endif
		@nLin, 069 PSAY (cArqTrab)->VENCTO
		@nLin, 080 PSAY (cArqTrab)->VALOR PICTURE Tm((cArqTrab)->VALOR ,15)		
		@nLin, 0100 PSAY (cArqTrab)->DTLIBERA
		@nLin, 0112 PSAY (cArqTrab)->USULIBERA 
		                
		nValSub += (cArqTrab)->VALOR
		nLin    := nLin + 1 
		(cArqTrab)->(DbSkip())
	Enddo

	If nValSub <> 0
		nLin    := nLin + 1 
		@nLin,000 PSAY Replicate("-",132)
		nLin    := nLin + 1 
		@nLin, 053 PSAY cTexSub
		@nLin, 080 PSAY nValSub PICTURE Tm((cArqTrab)->VALOR ,15)				  
		nLin    := nLin + 1 
		@nLin,000 PSAY Replicate("-",132)
		nValTot += nValSub
		nValSub := 0
	Endif
	nLin := nLin + 2 
EndDo        

If nValTot <> 0      
	nLin    := nLin + 1 
	@nLin,000 PSAY Replicate("_",132)
	nLin    := nLin + 2 
	@nLin, 053 PSAY 	STR0023 //"Total Geral              : "
	@nLin, 080 PSAY nValTot PICTURE Tm((cArqTrab)->VALOR ,15)				  
	nLin    := nLin + 1 
	@nLin,000 PSAY Replicate("_",132)
	nValTot += nValSub
	nValSub := 0
Endif

//----------------------------------------------------------------------
// Efetua limpeza dos filtros e dos arquivos temporarios...
//----------------------------------------------------------------------
dbSelectArea("SE2")
dbSetOrder(1)
(cArqTrab)->(dbCloseArea())

//----------------------------------------------------------------------
// Se impressao em disco, chama o gerenciador de impressao...  
//----------------------------------------------------------------------
If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

