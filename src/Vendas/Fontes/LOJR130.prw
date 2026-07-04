/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "LOJR130.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWADAPTEREAI.CH"

//Posicoes do array aLivro
#DEFINE _LFTES     1
#DEFINE _LFCF      2
#DEFINE _LFALQIMP  3
#DEFINE _LFVALCONT 4

STATIC lFisLivro	:= (SuperGetMV("MV_LJLVFIS",,1) == 2)		// Utiliza novo conceito para geracao do SF3
Static lMultiplo	:= (SuperGetMV("MV_LJ130MN",,.F.) == .T.)		// Permite gerar uma nota para multiplos cupons
STATIC lLegislacao	:= 	(((LjAnalisaLeg(43)[1] .OR. lMultiplo).AND. cPaisLoc == "BRA") .OR. (cPaisLoc  == "MEX" .AND. SA1->(ColumnPos("A1_MODCFD")) > 0 )) .AND. AliasInDic("MDL")
Static lIsMexico	:= cPaisLoc == "MEX"
Static lRelMacroMex	:= cPaisLoc == "MEX" .AND. (Substr(SuperGetMV("MV_SCRNFCP"),1,1) == "&")
Static cMexNota		:= ""									//Numero da nota para impressão da nota no Mexico
Static cMexSerie	:= ""									//Serie da nota no Mexico
Static aMexRegSF2	:= {}									//Contem registros da SF2 para o Mexico
Static lConfProc	:= .F.									//Variavel que controla se foi confirmado o processamento das notas
Static lIntDefPro	:= .F.									//processamento por mensagem única
Static cKeyNF       := ""                                   //Chave da nota quando já trasmitida
Static oTempTable	:= Nil									//Objeto tabela temporaria 
Static cMarca		:= ""

//-------------------------------------------------------------------------------------------------
/*/{Protheus.doc} LOJR130
Emissao de NF de Cupom Fiscal (Decreto 4.373-N de 02/12/98) 

27/09/17  DMINA-725      	En Func LjR130Exec Se asigna valor a campos
							F2_USOCFDI,F2_RELSAT y F2_UUIDREL con las    
							preguntas MV_PAR12,MV_PAR13 y MV_PAR14 y se  
							inicializan las Mafis(MaFisIniLoad ).En fun  
							LojR130 se agrega msg de aviso para la opci  
							Fac.P/Comp.Fisc.(Infores/Gestion Ventas)MEX  
							
Marco A.  06/03/18    	    DMINA-726    Se replican para V12.1.17, los issues:       
						    DMINA-64, DMINA-445, DMINA-871, DMINA-817,  
						    DMINA-1082 y DMINA-1337; para Esquema CFDI 3.3 (MEX) 

@param aParam	   	    - Array de Parametros quando execauto
@param lNota	    	- Determina se Nota(.T.) ou Estorno(.F.)
@param cCliNF           - Cliente identificado na nota sobre cupom
@return cLojNF	        - Loja do liente identificado na nota sobre cupom
@return lItgDef	        - Indica se esta sendo executado via Integracao
@return aNFReceiver	    - Array de dados quando a nota já foi emitida
@author  Varejo
@since 	 14/02/05
@version 1.0				
/*/	
//-------------------------------------------------------------------------------------------------
User Function LojR130( aParam   , lNota      , cCliNF, cLojNF ,;
                  lItgDef  , aNFReceiver)

Local cTesNota := SuperGetMV("MV_TESNOTA")                              		// Parametro que indica Tipo de Saida para geracao de Nota Fiscal s/Cupom
Local cTesServ := SuperGetMV("MV_LJNCUPS",,"")									// TES de servico para nota sobre cupom (F3 OnLine)
Local lRet     := .T.

Private aReturn  := { 	STR0005,;												// [1] Reservado para Formulario	"Zebrado,Especial"
						1,;														// [2] Reservado para N§ de Vias	
						STR0006,;												// [3] Destinatario					"Administracao"
						2,;														// [4] Formato => 1-Comprimido 2-Normal	
						2,;														// [5] Midia   => 1-Disco 2-Impressora
						1,;														// [6] Porta ou Arquivo 1-LPT1... 4-COM1...	
						"",;													// [7] Expressao do Filtro
						1 }														// [8] Ordem a ser selecionada
																				// [9]..[10]..[n] Campos a Processar (se houver)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private nLastKey := 0															// Controla o cancelamento da SetPrint e SetDefault
Private cPerg	 := "LJR130"													// Pergunte do Relatorio - SX1
Private cSerie   := ""										                    // Serie da Nota Fiscal - SIGALOJA	
Private cNumNota := ""										                    // Numero da NF 
Private oDlgLoja

Static lExecAt	:= .F.
Static lExecAtM := .F.
Static lEstorno := .F.
Static cCliExec := ""
Static cLojExec := ""
Static lLjMenno := SuperGetMV("MV_LJMENNO",,.F.)
Static lF2MenNota := SF2->(ColumnPos("F2_MENNOTA") > 0)
Static lMenNota	:= lLjMenno .AND. lF2MenNota			//Verifica se esta habilitado a apresentacao do campo de observacao da nota fiscal
Static cMenNota	:= ""									//Mensagem da Nota Fiscal

Default aParam	:= {}
Default lNota	:= .T.
Default cCliNF	:= Alltrim(SuperGetMV("MV_CLIPAD",,"000001"))
Default cLojNF	:= Alltrim(SuperGetMV("MV_LOJAPAD",,"01"))
Default lItgDef	:= .F.
Default aNFReceiver := {}

//Integracao Mensagem Unica
lIntDefPro := Len(aParam) > 0 .And. lItgDef

If lIntDefPro .And. Len(aNFReceiver) >= 3
    cSerie   := aNFReceiver[1]											
    cNumNota := aNFReceiver[2]	
    cKeyNF   := aNFReceiver[3]  									
Else
    cSerie   := SuperGetMV("MV_LOJANF")										
    cNumNota := CriaVar("L1_DOC",.F.)										
EndIf    

If !lNota
	lEstorno := .T.
	mv_par09 := 2 
EndIf

If Len(aParam) > 0
	lExecAt	:= .T.	// Indica que eh execauto
EndIf

/*
	Não podemos tratar como multiplas notas quando o lLesgislacao é verdadeira
	pois este o parâmetro MV_LJ130MN está como falso. Enfretamos problemas com a lojas de GO, pois
	a LjAnalisaLeg(43)[1] retorna verdadeira e logo a lLegislacao fica verdadeira e é realizada a trativa
	de multiplas notas.
*/
	
If Len(aParam) > 0 .AND. lMultiplo //lLegislacao
	lExecAtM := .T.	// Indica que eh execauto para multiplas notas
EndIf

If !lExecAt .AND. lLegislacao
	cPerg := "LJR131"
EndIf

If lLjMenno .AND. !lF2MenNota .AND. !lExecAt
	Ljr130Msg(STR0083, NIL ,2)			//"O parâmetro MV_LJMENNO está ativo, e para seu funcionamento é necessário o campo F2_MENNOTA da tabela SF2 estar configurado no dicionário de dados."
ElseIf lMenNota 
	cMenNota	:= CriaVar("F2_MENNOTA",.F.)
EndIf

lRet := LjR130Val(cTesNota,cTesServ) 

If !lRet
	If lExecAt
		lMsErroAuto := .T.
	EndIf
	lRet := .F.
EndIf

If lRet
	If lExecAt
		MV_PAR01	:= aParam[1][1] // Doc Cupom
		MV_PAR02	:= aParam[1][2] // Serie Cupom             	
		MV_PAR03	:= aParam[1][3] // Cliente
		MV_PAR04	:= aParam[1][4] // Loja
		If Len(aParam[1]) > 4
            MV_PAR05    := aParam[1][5]	// Transmite cancelamento ? 1=Sim; 2=Nao
        Else
            MV_PAR05    := 2 			// Transmite cancelamento ? 1=Sim; 2=Nao
        EndIf		
	Else
		If !Pergunte(cPerg,.T.)
			lRet := .F.
		Else
			If lIsMexico
				MsgInfo(STR0088, STR0089) //"El Uso de CFDI y Tipo de Relación, aplicara para todos los Comprobantes que seleccione en la próxima pantalla." / "Aviso"
			EndIf
			If !U_LjR130Cli(.F.)	//valida dados do cliente
				lRet := .F.
			EndIf
		Endif
	EndIf

	If lRet 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Valida se o processo deve ou nao continuar                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
		If lRet
			If ExistBlock("LJR130")
				If !ExecBlock("LJR130", .F., .F.,{lExecAt})
					lRet := .F.
				Endif
			Endif
			
			If lRet 
				If lLegislacao .AND. !lExecAtM
					U_LjR130MkBrw()
				ElseIf lExecAtM .AND. lLegislacao
					cCliExec := cCliNF
					cLojExec := cLojNF
			   		If Empty(Mv_par10)
						Mv_par10 := cCliExec
					EndIf
			   		If Empty(Mv_par11)
						Mv_par11 := cLojExec
					EndIf						
					U_LJ131ProcM(aParam)
				Else
					lRet := U_LjR130VerInf()
				EndIf
				            
				If !lRet .AND. lExecAt
					lMsErroAuto := .T.
				EndIf
			EndIf
		EndIf
	EndIf
EndIf

If !lIntDefPro //Integracao nao controla transacao
	If InTransact()
		Disarmtransaction()
	EndIf 
EndIf

Return lRet

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ºFuncao    LjR130VerInfºAutor  ³Vendas Clientes	 º Data ³  03/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Validacao dos dados antes do processamento                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³LOJR130                                                     º±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function LjR130VerInf(aNfsSF2)

Local cString  		:= "SL1"													// Alias principal para a impressao do relatorio
Local titulo   		:= STR0001													// "Emiss„o de Nota Fiscal para Cupom Fiscal"
Local cDesc1   		:= STR0002													// "Este programa tem a fun‡„o de emitir Nota Fiscal com base em um Cupom Fiscal j "
Local cDesc2   		:= STR0003 													// "emitido na Venda atendendo ao Decreto 4.373-N de 02/12/1998. Para tanto, ser "	
Local cDesc3   		:= STR0004										  			// "utilizado o script de Nota Fiscal gravado no Parƒmetro MV_SCRNFCP (" +GetMV("MV_SCRNFCP")+")"				
Local aAreaSX3   	:= SX3->(GetArea())										// Salva area do SX3	
Local lRet			:= .T.														// Retorno da funcao
Local lOk	   		:= .T.														// Flag de validacao para continuar a gravacao
Local wnrel			:= "NFISCAL"            									// Nome DEFAULT do relatorio em Disco
Local aHeader  		:= {}														// aHeader auxiliar para gravacao da tabela SF2	
Local aHeader1		:= {}														// aHeader auxiliar para gravacao da tabela SD2	
Local cLojaNF  		:= Alltrim(SuperGetMV("MV_LOJANF"))							// Parametro com a serie da Nota Fiscal - Somente para o SIGALOJA
Local aSeekNF		:= {}
Local nX 			:= 0
Local nTamSerie     := TamSx3("F2_SERIE")[1]                                  	// Tamanho do campo F2_SERIE
Local lNfeMex       := If(cPaisLoc  == "MEX" .AND. SA1->(ColumnPos("A1_MODCFD")) > 0 .AND. AliasInDic("MDL"),.T.,.F.)
Local cTiposDoc 	:= AllTrim( SuperGetMv( 'MV_ESPECIE' ) )   					// Tipos de documento (busca no param. MV_ESPECIE)
Local cTpEspecie    := ""								                        // Tipo da especie
Local nCount        := 0                                                        // Variavel contador
Local nPosSign      := 0 														// Contador de posicao dentro de sring
Local cEspecie      := PadR("SPED",Len(SF1->F1_ESPECIE))                        // Especie igual a SPED
Local lSped         := .F.                                                      // Verifica se a especie eh SPED
Local cCliente		:= If(Empty(Mv_Par03),"",Mv_Par03)							//Cliente
Local cLoja			:= If(Empty(Mv_Par04),"",Mv_Par04)							//Loja
Local cCliPad   	:= Alltrim(SuperGetMV("MV_CLIPAD",,"000001"))               //Cliente padrao
Local cLojPad 		:= Alltrim(SuperGetMV("MV_LOJAPAD",,"01"))					//Loja padrao
Local lAlterou   	:= .F.                                                      //Verifica se o cliente ou a loja foram alterados.  
Local lClLjPad      := .F. 														//Verifica se e cliente e loja padrao.
Local lIntegDef	    := lExecAt .And. lIntDefPro 								//Integracao Mensagem Unica
Local lIntegHtl	    := lIntegDef .And. SuperGetMv("MV_INTHTL",, .F.)			//Integracao Hotelaria
Local cMV_LJIMPFA	:= AllTrim( SuperGetMV("MV_LJIMPFA",.F.,"2") )				//Verifica se pergunta se deseja imprimir a nota - Opção 2 - Imprime sem apresentar a pergunta
Local lImprime		:= .T.														// Determina se imprime a NF de Conferência

Default aNfsSF2 := {}

// Verifica atraves do parametro MV_ESPECIE se a especie eh SPED   
If cTiposDoc <> NIL
	cTiposDoc := StrTran( cTiposDoc, ";", CHR(13)+CHR(10))
	For nCount := 1 TO MLCount( cTiposDoc )
		cTpEspecie := ALLTRIM( StrTran( MemoLine( cTiposDoc,, nCount ), CHR(13), CHR(10) ) )
		nPosSign := Rat( "=", cTpEspecie)
		If nPosSign > 0 .AND. ALLTRIM( cSerie ) == ALLTRIM( SUBSTR( cTpEspecie, 1, nPosSign - 1 ) ) .AND.;
			Alltrim(cEspecie) == AllTrim( SubStr( cTpEspecie, nPosSign + 1 ))  
			lSped := .T.
			Exit
		EndIf
	Next nCount
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se existe um sinal de & (macro substituicao), dessa forma³
//³possibilita ao usuario executar uma customizacao.                 ³
//³Foi necessario fazer dessa forma, pois caso contrario acarretaria ³
//³erro na base de clientes ja implantada.                           ³
//³Solicitado por: Projeto Kodak                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If LEFT(cLojaNF,1) == "&" 
	cLojaNF := &( SUBSTR(cLojaNF,2,LEN(cLojaNF)) )
Endif	                                       

If Empty(cKeyNF) 
    cLojaNF := PadR(cLojaNF,nTamSerie)
    cSerie  := cLojaNF
Else
    cLojaNF := cSerie
EndIf

If !lLegislacao
	Aadd(aSeekNF,{Mv_par01,Mv_par02})
Else
	aSeekNF		:= aClone(aNfsSF2)
	 	
 	//Integracao nao altera cliente pois ja informado na integracao
	If !lIntegDef
		cCliente 	:= If(Empty(Mv_Par10),"",Mv_Par10) //carregar a partir do array
	 	cLoja 		:= If(Empty(Mv_Par11),"",Mv_Par11) //carregar a partir do array
	EndIf
EndIf

If lExecAtM
	If Empty(cCliente)
   		cCliente :=	cCliExec 	
	EndIf     
	
	If Empty(cLoja)
		cLoja := cLojExec
	EndIf
EndIf           

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros			  ³
//³ mv_par01				// Numero do Cupom Fiscal ³
//³ mv_par02				// Serie 				  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nX := 1 To Len(aSeekNF)
	DbSelectArea("SL1")     
	SL1->(DbSetOrder(2))
	
	If SL1->(DbSeek(xFilial("SL1") + aSeekNF[nX][2] +  aSeekNF[nX][1]) )

		While !SL1->(EOF()) .And. SL1->L1_FILIAL == xFilial("SL1") .AND. ;
				(SL1->L1_SERIE == aSeekNF[nX][2] .AND. SL1->L1_DOC == aSeekNF[nX][1])

			If  AllTrim(SL1->L1_SITUA) == 'OK' .OR. AllTrim(SL1->L1_SITUA) == 'X2'
				lOk := .T.
				Exit
			Else
				SL1->(DbSkip())
				lOk := .F.
			Endif
		EndDo
	EndIf

	If lOk
		If !LjR130VlLeg(lSped)
			Ljr130Msg(STR0082, NIL ,1) //"Emissão de Nota não permitida por Legislação"			
			lOk	:= .F.
			Return .F.			
		EndIf
	
		lAlterou := Alltrim(SL1->L1_CLIENTE) <> Alltrim(cCliente) .OR. Alltrim(SL1->L1_LOJA) <> Alltrim(cLoja)
	    lClLjPad := Alltrim(SL1->L1_CLIENTE) == cClipad .AND. Alltrim(SL1->L1_LOJA) == cLojPad 
	     
		If lAlterou .AND. !lClLjPad				//Nao permite alterar o cliente se o cupom nao foi gerado para o cliente e loja padrao.
			Ljr130Msg(STR0053+AllTrim(SL1->L1_DOC)+CHR(13)+CHR(10)+STR0054+CHR(13)+CHR(10)+STR0090+Alltrim(SL1->L1_CLIENTE)+"/"+Alltrim(SL1->L1_LOJA), NIL, 1)//Favor informar o cliente e a loja referentes ao numero do cupom fiscal: ## "Está venda está registrada para o cliente/loja:"	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿		
			//³ Limpa F2_OK para poder escolher o registro posteriormente.		³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lLegislacao
				Lj130F2OK(aSeekNF)
            EndIf
			Return .F.
		EndIf
		
		// Nao permite a impressao de Nota sobre cupom para o cliente padrao
		If AllTrim(cCliente+cLoja) == AllTrim(cCliPad+cLojPad)
			Ljr130Msg(STR0057, NIL ,1)			//"Não é permitido a impressão de Nota Fiscal para o cliente  padrão"
			Return .F.
		EndIf		
		
		If Empty( SL1->L1_PDV )
			lOk := .F.
			Exit
		EndIf
		
		If !Empty(SL1->L1_STATUES)
			Help(" ","1", "CUPESTORN")  //"Este cupom já foi estornado."
				Return .F.
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se tem SF2 se não tiver da mensagem  |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		DbSelectArea("SF2")
		SF2->(DbSetOrder(1))
		lOk  := SF2->(DbSeek(xFilial("SF2") + SL1->L1_DOC + SL1->L1_SERIE ))
	Endif
Next nX

If !lLegislacao
	aSeekNF := {}
EndIf

If !lOk
	Help(" ","1","CUPFISCAL")
	Return .F.
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Funcao para verificar se ja existe a nota sobre cupom	³
//³ Caso ja exista oferece a opcao de excluir-la  			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If !lNfeMex .And. !lIntegHtl //Integracao Hotel nao efetua exclusao de Documento
	lOk := !Lj130ChkNf(SL1->L1_DOC , SL1->L1_SERIE , cCliente , cLoja)
EndIf          

If !lOk
	Return(.T.)
Endif

// Verificar necessidade de digitar mensagem para NF-e
If !lExecAt .AND. lMenNota
	Ljr130Compl()
EndIf 

If !lIsMexico 
	If cMV_LJIMPFA == "1" .AND. !lExecAt
		lImprime := MsgYesNo(STR0100) // "Deseja realizar a impressão para conferência?"
	ElseIf cMV_LJIMPFA == "3" .OR. lExecAt
		lImprime := .F.
	Endif	
EndIf
  
//Avisar que é uma nota que deverá ser transmitida pela NF-e
If lImprime .AND. lSped .AND. (!lExecAt)
	Ljr130Msg(STR0091+Chr(13)+Chr(10)+STR0092, NIL ,2)			//"Impressão a seguir é somente para simples conferência!"###"Necessário transmitir a nota na rotina NF-e Sefaz (SPEDNFE)."
EndIf

If !lIsMexico .AND. lImprime //Para o Mexico a impressão deste comprvante é depois da impressão do CFD
	
		If !( lExecAt ) // Para NF-e e Rotina Aut. nao imprime
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Envia controle para a funcao SETPRINT 						 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"")
		EndIf			
		
		If nLastKey == 27
			Return .F.
		EndIf
	
EndIf

DbSelectArea("SX3")
SX3->(DbSetOrder(1))
SX3->(DbSeek("SF2"))
While !SX3->(Eof()) .AND. (SX3->X3_ARQUIVO == "SF2")
	If SX3->X3_CONTEXT <> "V"
		AADD( aHeader,{	TRIM(x3titulo())	,;		// 1  
						SX3->X3_CAMPO		,;		// 2
						SX3->X3_PICTURE		,;		// 3
						SX3->X3_TAMANHO		,;		// 4
						SX3->X3_DECIMAL		,;		// 5
						SX3->X3_VALID		,;		// 6
						SX3->X3_USADO		,;		// 7
						SX3->X3_TIPO		,;		// 8 	
						SX3->X3_ARQUIVO } )			// 9 
	Endif
	SX3->( DbSkip() )
End

SX3->(DbSeek("SD2"))
While !SX3->(Eof()) .AND. ( SX3->X3_ARQUIVO == "SD2" )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Carrega somente os campos REAIS³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SX3->X3_CONTEXT <> "V" .And. AllTrim(SX3->X3_CAMPO) <> "D2_ITEMCC"
		AADD( aHeader1,{	TRIM(x3titulo())	,;	// 1	
						 	SX3->X3_CAMPO		,;	// 2
						  	SX3->X3_PICTURE		,;	// 3
							SX3->X3_TAMANHO		,;	// 4
						 	SX3->X3_DECIMAL		,;	// 5
						 	SX3->X3_VALID		,;	// 6
							SX3->X3_USADO		,;	// 7
						 	SX3->X3_TIPO		,;	// 8	
						  	SX3->X3_ARQUIVO		,;	// 9
						   	SX3->X3_CONTEXT } )		// 10	
						   	
	Endif
	SX3->( DbSkip() )
End
RestArea(aAreaSX3) //Retorna o SX3 para a posicao original...

If !lIsMexico .AND. lImprime	//Para o Mexico a impressão deste comprvante é depois da impressão do CFD
	If !( lExecAt ) // Para NF-e e Rotina Aut. nao imprime
		SetDefault(aReturn,cString)		
	EndIf 
	
	If nLastKey == 27
		lOk := .F.
	Endif
EndIf

U_LjR130Nota( @lOk     , @lRet   	, @wnrel 	, @aHeader	,;
            @aHeader1, @cLojaNF	, aSeekNF	, cString	,;
            @titulo  , cDesc1  	, cDesc2 	, cDesc3 	,;
			lImprime )

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³LjR130Nota ºAutor  ³Vendas Clientes	 º Data ³  03/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Geracao da nota no fiscal				                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³LOJR130                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function LjR130Nota( lOk     	, lRet   	, wnrel  	, aHeader ,;
                     aHeader1	, cLojaNF	, aSeekNF 	, cString ,;
                     titulo  	, cDesc1 	, cDesc2 	, cDesc3  ,;
					 lImprime	)

Local aAreaSL2   	:= {}														// Salva a area especifica para o SL2 - Livros Fiscais		   
Local nItensVenda	:= 0														// Quantidade de itens da NF
Local nMaxItens  	:= 0 														// Determina o numero maximo de itens que uma nf pode conter...															
Local nQtdNotas		:= 1														// Contador com o numero de NF's	
Local aTotNfs    	:= {}														// Array com os totalizadores para o SF2
Local aRegSF2    	:= {}														// Salva uma posicao de registro do SF2
Local cEstCF		:= ""														// Estado do Cupom Fiscal
Local cStrNfCup  	:= ""														// Associa o numero da NF ao cupom fiscal
Local nTamDoc       := TamSx3("F2_DOC")[1]                                    	// Tamanho do campo F2_DOC
Local nTamSerie     := TamSx3("F2_SERIE")[1]                                  	// Tamanho do campo F2_SERIE

Local aNotas		:={}														// Array com a numeracao das NF's  
Local cNfOri     	:= ""														// Numero da NF de origem		
Local cSerOri    	:= ""														// Serie da NF de origem
Local nX			:= 1
Local nFatNGlob		:= 0
Local aSeekNfG		:= {}
Local aSeekNfNG		:= {}
Local aBkpNotas		:= {}
Local lPergunta		:= .F.
Local abkpRegSF2   	:= {}
Local aMsgCert		:= {}
Local aSF2			:= {}
Local aAliasSF2		:= {}
Local lMsgFG		:= .T.
Local lGerCfd		:= .F.

Default lOk			:= .F.
Default lRet		:= .T.
Default wnrel		:= "NFISCAL"
Default aHeader		:= {}
Default aHeader1	:= {}
Default cString  	:= "SL1"													// Alias principal para a impressao do relatorio
Default titulo   	:= STR0001													// "Emiss„o de Nota Fiscal para Cupom Fiscal"
Default cDesc1   	:= STR0002													// "Este programa tem a fun‡„o de emitir Nota Fiscal com base em um Cupom Fiscal j "
Default cDesc2   	:= STR0003 													// "emitido na Venda atendendo ao Decreto 4.373-N de 02/12/1998. Para tanto, ser "	
Default cDesc3   	:= STR0004										  			// "utilizado o script de Nota Fiscal gravado no Parƒmetro MV_SCRNFCP (" +GetMV("MV_SCRNFCP")+")"
Default lImprime	:= .T.														// Determina se imprime a NF de Conferência

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Strutura - aGravaFT      ³
//³1 - Filial               ³
//³2 - Data Entrada         ³
//³3 - Data de emissao      ³
//³4 - Nota Fiscal          ³
//³5 - Serie                ³
//³6 - Cliente              ³
//³7 - Loja                 ³
//³8 - Estado               ³
//³9 - PDV                  ³
//³10 - Especie             ³
//³11 - Produto             ³
//³12 - Item                ³
//³13 - Tipo movimento      ³
//³14 - CFOP                ³
//³15 - Aliquota de ICMS    ³
//³16 - Valor contabil      ³
//³17 - Base ICMS           ³
//³18 - Valor ICMS          ³
//³19 - Isencao ICMS        ³
//³20 - Outro ICMS          ³
//³21 - Base IPI            ³
//³22 - Valor IPI           ³
//³23 - Isencao IPI         ³
//³24 - Outro IPI           ³
//³25 - Observacao          ³
//³26 - ICMS retido         ³
//³27 - TIPO                ³
//³28 - ICMS Com            ³
//³29 - Codigo ISS          ³
//³30 - Obs IPI             ³
//³31 - Numero Livro        ³
//³32 - Icms auto           ³
//³33 - Base retencao       ³
//³34 - Formula             ³
//³35 - Formula             ³
//³36 - Despesas            ³
//³37 - Diferenca Icms      ³
//³38 - Trf Icms            ³
//³39 - Observacao Icms     ³
//³40 - Observacao solidario³
//³41 - Sol. trib.          ³
//³42 - CFOExt              ³
//³43 - IssSt               ³
//³44 - Rec Iss             ³
//³45 - Iss Sub             ³
//³46 - Livro de ISS no ICMS³
//³47 - Credito estatual    ³
//³48 - CRDEst              ³
//³49 - Identificao SF3     ³
//³50 - Aliquota IPI        ³
//³51 - Base PS3            ³
//³52 - Aliq PS3            ³
//³53 - Val PS3             ³
//³54 - Base CF3            ³
//³55 - Aliq CF3            ³
//³56 - Val CF3             ³
//³57 - Desconto            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lOk
	//Pesquisa o Cupom Original...
	If !lLegislacao
		DbSelectArea("SF2")
		SF2->(DbSetOrder(1))
		If SF2->(DbSeek( xFilial("SF2") + SL1->L1_DOC + SL1->L1_SERIE + SL1->L1_CLIENTE + SL1->L1_LOJA ))
			Aadd(aSeekNF,{SF2->F2_DOC,SF2->F2_SERIE, SF2->F2_CLIENTE, SF2->F2_LOJA,SF2->F2_EST,SF2->(Recno())})
			Aadd(aRegSF2,SF2->(RecNo()))
			cEstCF	:= SF2->F2_EST
		Endif
	Else
		For nX := 1 To Len(aSeekNF)
			Aadd(aRegSF2,aSeekNF[nX][6])
			cEstCF	:= SF2->F2_EST
		Next nX 
		
	EndIf	
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se ha multiplas notas ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aAreaSL2 := SL2->(GetArea())

	DbSelectArea("SL2")
	SL2->(DbSetOrder(1))
	If SL2->(DbSeek( xFilial("SL2") + SL1->L1_NUM ))
		While 	!SL2->(Eof())					.AND.;
			 	L2_FILIAL == xFilial("SL2")	.AND.;
				L2_NUM == SL1->L1_NUM

			nItensVenda ++
			SL2->(DbSkip())
		End
	Endif
	RestArea(aAreaSL2)		
	
	//Determina o numero maximo de itens que uma nf pode conter...
	If cPaisLoc <> "CHI"
		nMaxItens := SuperGetMV("MV_SER"+cSerie,.F.,SuperGetMV("MV_NUMITEN"))
	Else
		nMaxItens := SuperGetMV("MV_NUMITEN")
	Endif
	
	//Determina a qtde de notas que serao geradas...
	If  lIsMexico .AND. lLegislacao
		nX	:= 1
		aAliasSF2	:= SF2->(GetArea())
		While nX <= Len(aSeekNF)
			If !Empty(aSeekNF[nX][8]).AND. !aSeekNF[nX][9]
				DBSelectArea("SF2")
				SF2->(DBSetOrder(1))
				If SF2->(DBSeek(xFilial("SF2") + aSeekNF[nX][8]))
					If Empty(SF2->F2_APROFOL)
						nFatGlob	+=	aSeekNF[nX][7]
						AADD( aSeekNfG , aSeekNF[nX] )
						lMsgFG	:= .F.
					Else
						ADel(aSeekNF ,nX)	
						ASize(aSeekNF , Len(aSeekNF) -1 )
						If nX > 1
							nX --							
						Else 
							nX := 0
						EndIf
					EndIf
				EndIf
			ElseIf !aSeekNF[nX][9]
				nFatNGlob	+=	aSeekNF[nX][7]
				AADD( aSeekNfNG , aSeekNF[nX] )
				lMsgFG	:= .F.
			ElseIf aSeekNF[nX][9]
				ADel(aSeekNF ,nX)	
				ASize(aSeekNK , Len(aSeekNK) -1 )
				If nX > 1
					nX --							
				Else 
					nX := 0
				EndIf				
			EndIf				
			nX ++
		End
	ElseIf nItensVenda > nMaxItens
		nQtdNotas := Int(nItensVenda/nMaxItens) + Iif(Mod(nItensVenda,nMaxItens) > 0,1,0)

		If nQtdNotas > 1
			Lj130CalcNFs(@aTotNfs,nMaxItens,Nil)
		Endif
	Endif


	If Len(aAliasSF2) > 0
		RestArea(aAliasSF2)
	EndIf

	If !Empty(SF2->F2_NFORI) .AND. lIsMexico .AND. lMsgFG
		cNfOri := SF2->F2_NFORI
		cSerOri:= SF2->F2_SERIORI
		
		If SF2->(DbSeek(xFilial("SF2") + cNfOri + cSerOri))
			If SF2->F2_GLOBAL == "1"
				Ljr130Msg(STR0008+SF2->F2_DOC+" "+SF2->F2_SERIE+")", NIL, 4) //"Nao se pode gerar uma nota fiscal para um cupom que ja pertence a uma nota fiscal global ("")
				If Len(aRegSF2) > 0
					SF2->(DbGoTo(aRegSF2[1]))
				EndIf
				lOk := .F.
			Endif
		Endif
	Endif
		
	If lOk
		If Len(aRegSF2) > 0
			SF2->(DbGoTo(aRegSF2[1]))
		EndIf
		If !Empty(SF2->F2_NFCUPOM)
			cStrNfCup := SubStr(SF2->F2_NFCUPOM,4,nTamDoc)+" "+SubStr(SF2->F2_NFCUPOM,1,nTamSerie)
			//"Ja existe uma Nota Fiscal ("") gerada para o Cupom "" Nao e possivel gerar outra Nota Fiscal para o mesmo Cupom Fiscal"
			Ljr130Msg(STR0009 + cStrNfCup + STR0010 + SF2->F2_DOC + STR0011, NIL ,4)
			lOk := .F.
		Endif
	Endif

Endif

If 	lLegislacao .AND. lIsMexico .AND. lOK

	If Len(aSeekNfG) > 0 
		If 	nFatGlob > nMaxItens
			nQtdNotas	:=	Int( (nFatGlob) /nMaxItens) + Iif(Mod( (nFatGlob) ,nMaxItens) > 0,1,0)

		EndIf

		Lj130CalcNFs(@aTotNfs,nMaxItens,aSeekNfG)

		aRegSF2	:= Array(Len(aSeekNfG))

		For nX := 1 to Len(aSeekNfG)
			aRegSF2[nx] := aSeekNfG[nX][6]			
		Next nX		
		abkpRegSF2	:= aRegSF2

		If lOk
		    If !LjxDNota(@cLojaNF, 2, NIL , nQtdNotas, @aNotas)
				lOk := .F.
			Endif
		Endif

		U_LjR130Exec(	@aNotas ,	@cLojaNF	,	@nTamDoc	,@nTamSerie		,;
					@aRegSF2,	@aHeader	,	aTotNfs		,@nFatGlob	,;	
					@aHeader1,	@cEstCF		,	@wnrel		,@lRet			,;
					@aSeekNfG, 	@lOk		,	Len(aSeekNfNG) > 0	)
		
		aBkpNotas	:= aNotas
	EndIf	

	If Len(aSeekNfNG) > 0 
		If nFatNGlob > nMaxItens
			nQtdNotas	:=	Int( (nFatNGlob) /nMaxItens) + Iif(Mod( (nFatNGlob) ,nMaxItens) > 0,1,0)
		Else
			nQtdNotas	:= 1
		EndIf
		aTotNfs	:= {}	
		Lj130CalcNFs(@aTotNfs,nMaxItens,aSeekNfNG)		
	
		aRegSF2	:= Array(Len(aSeekNfNG))

		For nX := 1 to Len(aSeekNfNG)
			aRegSF2[nx] := aSeekNfNG[nX][6]			
			AADD(aBkpRegSF2 , aSeekNfNG[nX][6])
		Next nX		
		
		aNotas	:= {}

		If lOk
			If !Lj010Nota(@cLojaNF, 2, NIL , nQtdNotas, @aNotas)
				lOk := .F.
			Endif
		Endif
		
		U_LjR130Exec(	@aNotas	,	@cLojaNF	,	@nTamDoc	,@nTamSerie		,;
					@aRegSF2,	@aHeader	,	aTotNfs		,@nFatNGlob	,;	
					@aHeader1,	@cEstCF		,	@wnrel		,@lRet			,;
					@aSeekNfNG, @lOk		)
		
		For	nX := 1 To Len(aNotas)
			AADD(aBkpNotas , aNotas[nX])			
		Next nX
	EndIf

	lGerCfd	:= Ljr130Msg(STR0049,NIL,3)			// "Confirma a geracao do comprovante fiscal digital ?"		
	
	If lGerCfd
		For nX := 1 To Len(aBkpNotas)
			DBSelectArea("SF2")
			SF2->(DBSetOrder(1))
			aSf2	:= SF2->(getArea())
			If SF2->(DBSeek( xFilial("SF2") + aBkpNotas[nX][2] + aBkpNotas[nX][1]))
				LOJXGERCFD(.F. , lPergunta , @aMsgCert)
				lPergunta	:= .F.
			EndIf
			RestArea(aSF2)
		Next nX
			
		LJXListFol(aMsgCert)
	EndIf
    
	If lIsMexico //No Mexico a impressão do Script deve ser após a geração do CFD
		If !(lExecAt .OR. lRelMacroMex) // Para NF-e e Rotina Aut. nao imprime
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Envia controle para a funcao SETPRINT 						 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"")
		EndIf			
		
		If nLastKey == 27
			lOk := .F.
		EndIf
		
		If lOK .AND. !(lExecAt .OR. lRelMacroMex) // Para NF-e e Rotina Aut. nao imprime
			SetDefault(aReturn,cString)		
		EndIf
		
		If nLastKey == 27
			lOk := .F.
		EndIf
		
		If lOk
			U_LjImpScript(cMexNota,cMexSerie,aMexRegSF2,wnrel)
			cMexNota	:= ""
			cMexSerie	:= ""
			aMexRegSF2	:= {}
		EndIf
	EndIf
		
ElseIf lOK 

	If !Empty(cKeyNF) //Caso seja nota já emitida
        aNotas := {{cSerie,cNumNota}}
    ElseIf !LjxDNota(@cLojaNF, 2, NIL , nQtdNotas, @aNotas,,,,,,,,,,,,, "SPED")
		lOk := .F.
	Endif
	
	U_LjR130Exec(	@aNotas	,	@cLojaNF	,	@nTamDoc	,@nTamSerie		,;
				@aRegSF2,	@aHeader	,	@aTotNfs	,@nItensVenda	,;	
				@aHeader1,	@cEstCF		,	@wnrel		,@lRet			,;
				@aSeekNF,	@lOk		,	nQtdNotas	,lImprime	)
EndIf	

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³LjR130Exec³ Autor ³ Vendas Clientes		³ Data ³ 14/02/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao de NF de Cupom Fiscal (Decreto 4.373-N de 02/12/98)³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_LOJR130(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGALOJA 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LjR130Exec(	aNotas	,	cLojaNF	,	nTamDoc		,nTamSerie	,;	
						aRegSF2	,	aHeader	,	aTotNfs		,nItensVenda,;	
						aHeader1,	cEstCF	,	wnrel		,lRet		,;
						aSeekNF	,	lOk		,	nQtdNotas	, lImprime  )

Local nI 			:= 0														// Contador de For
Local nX 			:= 0														// Contador de For
Local aAreaSF3   	:= {}														// Salva a area especifica para o SF3 - Livros Fiscais	
Local lGeraLivro 	:= .T.														// Flag que indica se o livro sera gerada ou nao
Local nCount        := 0 														// Contador auxiliar
Local cVar 			:= ""														// Variavel auxiliar para macro na gravacao dos registros
Local aRegsSF2 		:= {} 														// Registros do SF2 - Cabecalho das NF's de saida
Local cEspecie  	:= SPACE(5)													// Especie da NF	
Local cTiposDoc  	:= ALLTRIM( SuperGetMV( 'MV_ESPECIE' ) )					// Conten tipos de documentos fiscais utilizados na emissao de notas fiscais
Local nPosSign		:= 0 														// Contador de posicao dentro de sring
LocaL nTamItem      := TamSx3("D2_ITEM")[1]                                    	// Tamanho do campo D2_ITEM
Local cItem      	:= REPLICATE( "0", nTamItem )					            // Contador de itens para o SD2				
Local cTesNota 		:= SuperGetMV("MV_TESNOTA")                              	// Parametro que indica Tipo de Saida para geracao de Nota Fiscal s/Cupom
Local cCodISS		:= ""														// Codigo de servico
Local lExisteFT		:= AliasInDic("SFT")										// Se existe o indice do SFT
Local aImpVarSD2 	:= {}														// Array com os itens do SD2
Local aLivro     	:= {}														// Array para geracao do Livro Fiscal
Local aGetBook		:= {}														// Array 
Local nTaxaMoeda 	:= 1														// Moeda utilizada
Local nLinFT		:= 1														// Linha do Array
Local aRegsSD2 		:= {}														// Registros do SD2 - Itens de venda da NF de saida		
Local nRegSD2    	:= 0														// Variavel auxiliar para armazenar o recno do SD2 	
Local aStruSF3      := {}                                                      	// Estrutura do arquivo SF3
Local aGravaFT		:= {}														// Campos do SFT para serem gravados.
Local nRecnoSF2		:= 0
Local nSaveSx8      := GetSx8Len()                                             	// Controle da numeracao sequencial
Local aArea		   	:= GetArea()												// Salva a area atual
Local cMV_TPNRNFS	:= LjTpNrNFS()												// Retorno do parametro MV_TPNRNFS, utilizado pela Sx5NumNota() de onde serah controlado o numero da NF  1=SX5  2=SXE/SXF  3=SD9
Local cTesServ		:= SuperGetMV("MV_LJNCUPS",,"")								// TES de servico para nota sobre cupom (F3 OnLine)
Local cFormula		:= ""														// Formula que esta gravada no SF4
Local aAreaSF2		:= {}
Local cPadrao		:= "703"                                    				// Contabilizacao - Codigo Padrao (Lancamento Padrao: 703=Nota Sobre Cupom)
Local lPadrao  		:= VerPadrao(cPadrao)										// Contabilizacao - Verifica se o codigo Padronizado existe
Local nHdlPrv  		:= 0														// Contabilizacao
Local nTotal   		:= 0														// Contabilizacao
Local cArquivo 		:= ""														// Contabilizacao
Local lAglutina 	:= .T.														// Contabilizacao (Aglutina Lancamentos)
Local aLancCtb 		:= {} 														// Contabilizacao
Local aEstruSF2     := {}                                                       // Array contendo a estrutura da tabela SF2
Local aEstruSD2     := {}                                                       // Array contendo a estrutura da tabela SD2
Local aSF2			:= {}                                                       // Array com os valores da SF2
Local aSD2			:= {}                                                       // Array com os valores da SD2
Local nInd 			:= 0                                                        // Variavel contador
Local nRecAntSD2 	:= 0                                                        // Guarda o ultimo recno da SD2
Local nMaxItens  	:= 0 														// Determina o numero maximo de itens que uma nf pode conter...															
Local cArqSD2       := CriaTrab(Nil,.F.)                                        // Tabela temporaria com os registros da SD2
Local cFiltro       := ""                                                       // Filtro por item na SD2
Local nIndex        := 0                                                        // Indice por item na SD2
Local nItem         := 0                                                        // Item na tabela SD2
Local cCF 			:= ""														// CFOP
Local lLocxR130  	:= ExistBlock('LOCXR130')
Local aCondic    	:= {,.T.}
Local nY			:= 0
Local aValSF2		:= {}														// Array para acumular os valores para ser gravado no registro da nota sobre multiplos cupons
Local lIntegDef		:=  lIntDefPro												// Integracao Mensagem Unica
Local lIntegHtl		:= lIntegDef .And. SuperGetMv("MV_INTHTL",, .F.) 			// Integracao Hotelaria
Local cNaturez 		:= SuperGetMv("MV_HTLNADC",, "")	
Local aTitCR 		:= {}
Local aErroAuto 	:= {}
Local nTotalNfs 	:= 0
Local cErroAuto 	:= ""
Local aTimeUF		:= {} 														// Data/Hora da Nota
Local cHoraRMT		:=  ""
Local lHVerao		:= SuperGetMv("MV_HVERAO",.F.,.F.) 							// Verifica se o local fisico do servidor está em Horário de Verão  .F. Não / .T. Sim
Local cBkpSer       := ''
Local cBkpNF        := ''
Local cMvEstado		:= SuperGetMV("MV_ESTADO")
Local cSitTribD2    := ""
Local lCfgTrib      := If(FindFunction("LjCfgTrib"), LjCfgTrib(), .F.) //Verifica se Configurador de Tributos esta habilitado
//DOC/SERIE
Local lNewInvoic    := FindFunction("LjUsaNewIn") .And. LjUsaNewIn()
Local jTaxesConfig  := JsonObject():New()

Default aNotas		:= {}
Default cLojaNF		:= ""
Default nTamDoc		:= 0
Default nTamSerie	:= 0
Default aRegSF2		:= 0
Default aHeader		:= {}
Default aTotNfs		:= {}
Default nItensVenda	:= 0
Default aHeader1	:= {}
Default cEstCF		:= ""
Default wnrel		:= ""
Default lRet		:= .F.
Default nQtdNotas	:=	1
Default lImprime	:= .T.

Private lMsErroAuto    := .F.
Private lAutoErrNoFile := .T.

//Tratamento de escrituracao de f2_data/
cHoraRMT := SuperGetMv("MV_HORARMT",.F.,"2")
If ValType(cHoraRMT) == "L"
	If cHoraRMT
		cHoraRMT := "1"
	Else
		cHoraRMT := "2"
	EndIf
Else
	If cHoraRMT == NIL
		cHoraRMT := "2"
	EndIf
EndIf

//Determina o numero maximo de itens que uma nf pode conter...
If cPaisLoc <> "CHI"
	nMaxItens := SuperGetMV("MV_SER" + cSerie, .F., SuperGetMV("MV_NUMITEN"))
Else
	nMaxItens := SuperGetMV("MV_NUMITEN")
Endif

// Inicializa o array com os campos e valores que serão gravados na SF2 da Nota 
aAdd(aValSF2, { "F2_VALBRUT", 0 } )
aAdd(aValSF2, { "F2_VALICM"	, 0 } )
aAdd(aValSF2, { "F2_BASIMP5", 0 } )
aAdd(aValSF2, { "F2_BASIMP6", 0 } )
aAdd(aValSF2, { "F2_VALIMP5", 0 } )
aAdd(aValSF2, { "F2_VALIMP6", 0 } )

If lOk
	BEGIN TRANSACTION
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se eh para fazer o controle do numero da nota pelo SD9 (qdo ³
		//³ cMV_TPNRNFS = "3" e o numero de notas > 1							 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cMV_TPNRNFS == "3" .AND. nQtdnotas > 1 .And. !lNewInvoic
			For nI := 1 To nQtdNotas
				aAdd( aNotas, { cLojaNF,  MA461NumNf( .T., cLojaNF ) } )
				cSerie 		:= aNotas[1][1]
				cNumNota 	:= aNotas[1][2]
				cNumNota    := PadR( cNumNota ,nTamDoc )
			End
		Endif
		
	   	DbSelectArea("SA1")
	   	SA1->( DbSetOrder(1) )
		
		For nI := 1 To Len(aNotas)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se eh para fazer o controle do numero da nota pelo SD9 (qdo ³
			//³ cMV_TPNRNFS for igual a "3"                                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If cMV_TPNRNFS <> "3" .And. Empty(cKeyNF)			
				cSerie 	 := Padr(aNotas[nI][1],nTamSerie)
				cNumNota := Padr(aNotas[nI][2],nTamDoc)
				cNumNota := PadR( cNumNota , nTamDoc )				
			Endif
			
			If nI == 1
				If cPaisLoc <> "BRA"
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Verifica se foi gerado o registro no SF3 para o cupom original, caso tenha sido³
					//³gerado nao existe necessidade de gerar livro para a factura que sera gerada    ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aAreaSF3 := SF3->(GetArea())
					DbSelectArea("SF3")
					SF3->(DbSetOrder(4))
					If SF3->(DbSeek( xFilial("SF3") + SL1->L1_CLIENTE + SL1->L1_LOJA + SL1->L1_DOC + SL1->L1_SERIE ))
						If AllTrim(SF3->F3_ESPECIE) == "CF"
							lGeraLivro := .F.
						Endif
					Endif
					RestArea(aAreaSF3)
				Endif
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Posiciona o arquivo SF2 no cupom para o qual sera gerada nf e³
				//³faz a amaracao entre o cupom original e a nf gerada          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				nTotalNfs := 0
				DbSelectArea("SF2")
				SF2->(DbSetOrder(1))

				For nX := 1 To Len(aRegSF2)
					SF2->(DbGoTo(aRegSF2[nX]))
					
					// Soma os valores referente a cada campo no array
					For nY := 1 To Len(aValSF2)
						aValSF2[nY][2] += &(aValSF2[nY][1])
					Next nY
					
					Reclock("SF2",.F.)
					SF2->F2_NFCUPOM	:= cSerie + cNumNota
					SF2->F2_OK 		:= ""
					If SF2->(ColumnPos("F2_MENNOTA") > 0)
						SF2->F2_MENNOTA := cMenNota
					EndIf
					If lLegislacao .AND. lIsMexico 
			   			SF2->F2_USOCFDI	:= MV_PAR12 //Clave del uso del CFDI
						SF2->F2_RELSAT 	:= MV_PAR13 //Tipo de relación CFDI
						SF2->F2_UUIDREL	:= ALLTRIM(MV_PAR14) //UUID
					EndIf
					SF2->(MsUnlock())
					SF2->(FKCommit())
					aAreaSF2 := SF2->(GetArea())
					If lLegislacao
						DbSelectArea("MDL")
						MDL->(DbSetOrder(2))
						cBkpSer := cSerie
						cBkpNF  := cNumNota

						For nY := 1 to Len(aNotas)
							If cMV_TPNRNFS <> "3"			
								cSerie 	 := Padr(aNotas[nY][1],nTamSerie)
								cNumNota := Padr(aNotas[nY][2],nTamDoc)
								cNumNota := PadR( cNumNota , nTamDoc )				
							Endif
							
							If !MDL->(DbSeek(xFilial("MDL") + SF2->F2_DOC + SF2->F2_SERIE + cNumNota + cSerie))
								nTotalNfs += SF2->F2_VALBRUT
								
								Reclock("MDL",.T.)
							
								Replace MDL->MDL_FILIAL With xFilial("MDL")
								Replace MDL->MDL_NFCUP	With cNumNota
								SerieNfId("MDL",1,"MDL_SERIE",dDataBase,LjEspecieNF(),cSerie)
								Replace MDL->MDL_CUPOM	With SF2->F2_DOC
								Replace MDL->MDL_SERCUP	With SF2->F2_SERIE
								Replace MDL->MDL_F2RECN	With SF2->(Recno())
							
								MDL->(MsUnLock())
							EndIf	
						Next	

						cSerie   := cBkpSer
						cNumNota := cBkpNF
					EndIf
					RestArea(aAreaSF2)
				Next nX

				//Armazena os campos e os seus respectivos valores para posterior gravacao...
				For nCount := 1 TO LEN( aHeader )
					cVar := TRIM( aHeader[ nCount ][2] )
					AADD( aRegsSF2, Eval( FielDblock( cVar ) ) )
				Next nCount
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³	Antes de gerar o SF2 da NF carrega o array aSF2 com os valores do SF2 do Cupom ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DBSelectArea("SF2")
			SF2->(DBSetOrder(1)) //F2_FILIAL + F2_DOC + F2_SERIE + F2_CLIENTE + F2_LOJA
			If !SF2->(DbSeek( xFilial() + cNumNota + cSerie )) //verifica se a nota corrente ja nao esta em transacao
				aEstruSF2  := SF2->(DbStruct())
				For  nInd  := 1 To Len(aEstruSF2)
					If aEstruSF2[nInd,2] == "N"
		    			aADD(aSF2,{aEstruSF2[nInd,1], &(aEstruSF2[nInd,1]) })   
					EndIf
				Next nInd				
			Else
				Loop
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Gravando Registro no SF2 zerado conforme legisla‡ao, qdo pais igual a Brasil   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			RecLock("SF2",.T.)
			// LjAnalisaLeg == 52 // SC nao zera campos para geracao da tabela SF3			                   
			If !LjAnalisaLeg(52)[1]
				For nCount := 1 TO LEN( aHeader )
					cVar := TRIM( aHeader[ nCount ][2] )
					REPLACE &("SF2->"+cVar) WITH aRegsSF2[nCount]
				Next nCount
			Else
				//gravamos o campo FILIAL da NF sobre CUPOM, pois senao a nota nao estara disponivel para transmissão da NF-e
				REPLACE SF2->F2_FILIAL WITH aRegsSF2[ aScan(aHeader,{|x| AllTrim(x[2])=="F2_FILIAL"}) ]
		    Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Para o Mexico, grava o cliente e loja conforme informado ³
			//³nos parametro de pergunta                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lLegislacao .AND. lIsMexico 
			   	SF2->F2_CLIENTE	:= Mv_par10
				SF2->F2_LOJA 	:= Mv_par11
			ElseIf lLegislacao
				SF2->F2_CLIENTE	:= Mv_par10
				SF2->F2_LOJA 	:= Mv_par11
			Else		   		
		   		SF2->F2_CLIENTE	:= Mv_par03
				SF2->F2_LOJA 	:= Mv_par04
			EndIf 
			
			SF2->F2_DOC 	:= cNumNota
			SF2->F2_SERIE 	:= cSerie
			If SF2->(ColumnPos("F2_MENNOTA") > 0)
				SF2->F2_MENNOTA := cMenNota
			EndIf
			
            If !Empty(cKeyNF)
                SF2->F2_CHVNFE 	:= cKeyNF
			Else
				SF2->F2_CHVNFE 	:= ""
				SF2->F2_FIMP    := ""
            EndIf

			SA1->( DbSeek(xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA) ) 
			
		   	If lFisLivro
				//Reinicia a funcao fiscal
				If MaFisFound("NF")
					MaFisEnd()
				EndIf
				//Cria novos acumuladores de impostos para iniciar a nota
				MaFisIni(	SF2->F2_CLIENTE,;					//01 Codigo Cliente/Fornecedor
							SF2->F2_LOJA,;						//02 Loja do Cliente/Fornecedor
							IIF(SF2->F2_TIPO$'DB', "F", "C"),;	//03 C:Cliente, F:Fornecedor
							SF2->F2_TIPO,; 						//04 Tipo da NF
							SF2->F2_TIPOCLI,;					//05 Tipo do Cliente/Fornecedor
							{},;								//06 Relacao de Impostos que suportados no arquivo
							Nil,;								//07 Tipo de complemento
							Nil,;								//08 Permite Incluir Impostos no Rodape .T./.F.
							"SB1",;								//09 Alias do Cadastro de Produtos - ("SBI" P/ Front Loja)
							"LOJR130",;							//10 Nome da rotina que esta utilizando a funcao
							Nil,;								//11
							Nil,;								//12
							Nil,;								//13
							Nil,;								//14
							SF2->F2_RECISS,;					//15 Recolhe ISS
							SF2->F2_CLIENT,;					//16 Codigo do cliente de entrega na nota fiscal de saida
							SF2->F2_LOJENT,;					//17 Loja do cliente de entrega na nota fiscal de saida
							Nil,;								//18
							Nil,;								//19
							Nil,;  								//20
							Nil,;								//21
							Nil,;								//22
							Nil,;								//23
							Nil,;								//24
							Nil,;  								//25
							Nil,;								//26
							Nil,; 								//27
							Nil,; 								//28
							Nil,; 								//29
							Nil,; 								//30
							Nil,; 								//31
							Nil,; 								//32
							lCfgTrib ) 							//33 Flag para indicar se os tributos genéricos devem ou não ser calculados - deve ser passado como .T. 
																	//somente após a preparação da rotina para gravação, visualização e exclusão dos tributos genéricos
											          	
				If !Empty(cEstCF)
					MaFisAlt("NF_UFDEST", cEstCF) 							
				EndIf
			
			EndIf 
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Inicializa com "NF" se estiver fora do PAIS atualiza³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cEspecie := "NF"
			If cPaisLoc == "BRA"
				If cTiposDoc <> NIL
					cTiposDoc := StrTran( cTiposDoc, ";", CHR(13)+CHR(10))
					
					For nCount := 1 TO MLCount( cTiposDoc ) 
						cEspecie := ALLTRIM( StrTran( MemoLine( cTiposDoc,, nCount ), CHR(13), CHR(10) ) )
						nPosSign := Rat( "=", cEspecie)

						If nPosSign > 0 .AND. ALLTRIM( cSerie ) == ALLTRIM( SUBSTR( cEspecie, 1, nPosSign - 1 ) )
							DbSelectArea("SX5")
							DbSetOrder(1)
							If DbSeek( xFilial("SX5") + "42" + SUBSTR(cEspecie, nPosSign + 1) )
								cEspecie := SUBSTR( cEspecie, nPosSign + 1 )
							Else
								cEspecie := SPACE(5)
							Endif
						   
							Exit
						Else
							cEspecie := SPACE(5)
						Endif
					Next nCount
					
				Endif
			Endif
			
			SF2->F2_ESPECIE 	:= cEspecie 
			SF2->F2_PDV   		:= ""
			SF2->F2_ECF   		:= ""
			SF2->F2_TIPO 		:= "N" //Problema na visualização da nota via Nota fiscal de saida manual
			
			If !(lLegislacao)
				SF2->F2_NFCUPOM 	:= SL1->L1_SERIE+SL1->L1_DOC	// Aqui grava o numero do cupom na nota fiscal gerada
    		Else
				SF2->F2_NFCUPOM 	:= "MDL-RECORDED"
				SF2->F2_OK 			:= ""
    		EndIf
    		
    		// Grava os valores somado dos cupons no registro da Nota 
    		For nY := 1 To Len(aValSF2)
				SF2->&(aValSF2[nY][1]) := aValSF2[nY][2]
			Next nY

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Se o parametro MV_TPNRNFS for igual a 3 (controle de numeracao de NF ³
			//³ pelo SD9) grava o F2_NEXTDOC no final da rotina pq a numeracao das   ³
			//³ notas sao solicitadas apenas dentro da transacao.                    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If cMV_TPNRNFS <> "3" .And. Empty(cKeyNF)			
				If Len(aNotas) > 1 .AND. nI < Len(aNotas)
					SF2->F2_NEXTDOC := Padr( aNotas[nI+1][2], nTamDoc ) //Numero da Prox. Nota
				Else
					SF2->F2_NEXTDOC :=	""
				Endif	         
			Endif

			SF2->F2_PREFIXO 	:= cSerie
			//trocamos a data e hora de emissao, conforme configuração do parametro mv_horarmt
			aTimeUf := { dDataBase, Time()}
	
			If cPaisLoc == "BRA"
				If cHoraRMT == "3" 
					aTimeUf := FwTimeUF(SM0->M0_ESTENT,,lHVerao)
					aTimeUf[1] := StoD(aTimeUf[1])
				ElseIf cHoraRMT == "1" .AND. !IsBlind() 
					aTimeUf := { GetRmtDate(), GetRmtTime()}
				EndIf
	
			EndIf

			SF2->F2_EMISSAO	:= aTimeUf[1]
			SF2->F2_HORA 	:= aTimeUf[2]
			
			// LjAnalisaLeg == 52 // SC nao zera campos para geracao da tabela SF3			                   
			If cPaisLoc == "BRA" .AND. !LjAnalisaLeg(52)[1]
				SF2->F2_DUPL 	:= ""
				SF2->F2_VALMERC	:= 0
				SF2->F2_VALFAT 	:= 0
				SF2->F2_DESCONT	:= 0
			Endif
			
			If cPaisLoc <> "BRA"
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³E necessario gravar os campo F2_NFORI e F2_SERIORI   ³
				//³para que essa factura nao seja considerada na geracao³
				//³da fatura global                                     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				SF2->F2_NFORI	:= SL1->L1_DOC
				SF2->F2_SERIORI	:= SL1->L1_SERIE
				SF2->F2_HORA	:= SubStr(Time(),1,5)
				SF2->F2_TIPODOC	:= "01"
				If !Empty(aTotNfs)
					SF2->F2_VALBRUT := aTotNfs[nI][3]
					SF2->F2_VALMERC := aTotNfs[nI][1]
					SF2->F2_VALFAT  := aTotNfs[nI][2]
					SF2->F2_DESCONT := aTotNfs[nI][4]
					
					For nCount := 1 To Len(aTotNfs[nI][5])
						//Base do Imposto
						cVar := Trim(aTotNfs[ nI ][5][ nCount ][2])
						REPLACE &("SF2->"+cVar) WITH aTotNfs[ nI ][5][ nCount ][3]
						
						//Valor do Imposto
						cVar := Trim(aTotNfs[ nI ][5][ nCount ][4])
						REPLACE &("SF2->"+cVar) WITH aTotNfs[ nI ][5][ nCount ][5]
					Next nCount
				Endif
			Endif
			
			If lLegislacao
				If !Empty(aTotNfs)
					SF2->F2_VALBRUT := aTotNfs[nI][3]
					SF2->F2_VALMERC := aTotNfs[nI][1]
					SF2->F2_VALFAT  := aTotNfs[nI][2]
					SF2->F2_DESCONT := aTotNfs[nI][4]
					
					For nCount := 1 To Len(aTotNfs[nI][5])
						//Base do Imposto
						cVar := Trim(aTotNfs[ nI ][5][ nCount ][2])
						REPLACE &("SF2->"+cVar) WITH aTotNfs[ nI ][5][ nCount ][3]
						
						//Valor do Imposto
						cVar := Trim(aTotNfs[ nI ][5][ nCount ][4])
						REPLACE &("SF2->"+cVar) WITH aTotNfs[ nI ][5][ nCount ][5]
					Next nCount
				Endif			
			Endif
			
			// LjAnalisaLeg == 52 // SC nao zera campos para geracao da tabela SF3			                   
			If cPaisLoc == "BRA" .AND. !LjAnalisaLeg(52)[1]
				SF2->F2_ICMFRET		:= 0
				SF2->F2_FRETE		:= 0
				SF2->F2_SEGURO		:= 0
				SF2->F2_DESPESA		:= 0
				SF2->F2_VALICM		:= 0
				SF2->F2_BASEICM		:= 0
				SF2->F2_VALIPI		:= 0
				SF2->F2_BASEIPI		:= 0
				SF2->F2_ICMSRET		:= 0
				SF2->F2_BASEISS		:= 0
				SF2->F2_VALISS 		:= 0
				SF2->F2_BRICMS 		:= 0
				SF2->F2_ICMAUTO 	:= 0
				SF2->F2_VALINSS		:= 0
				SF2->F2_BASEINS		:= 0
				SF2->F2_VALIMP1		:= 0
				SF2->F2_VALIMP2		:= 0
				SF2->F2_VALIMP3		:= 0
				SF2->F2_VALIMP4		:= 0
				
				If !LjAnalisaLeg(83)[1]
					SF2->F2_VALIMP5		:= 0
					SF2->F2_VALIMP6		:= 0
				EndIf
				
				SF2->F2_VALPIS		:= 0
				SF2->F2_VALIRRF		:= 0
				
				If !LjAnalisaLeg(83)[1] .And. SF2->(ColumnPos('F2_BASIMP5')) > 0 .And. SF2->(ColumnPos('F2_BASIMP6')) > 0				
					SF2->F2_BASIMP5		:= 0				
					SF2->F2_BASIMP6		:= 0								
				Endif
			Endif
			
			SF2->(MsUnlock())
			SF2->(FKCommit())

			// verica se faz contabilização
			If lPadrao .AND. lIsMexico
				
				aLancCtb := {{"F2_DTLANC",dDataBase,"SF2",SF2->(Recno()),0,0,0}} //Campo Flag de Contabilizacao a ser atualizado
				
				nHdlPrv:=HeadProva("","LOJR130",Substr(cUsername,1,6),@cArquivo)
									
				If  nHdlPrv > 0
					nTotal+=DetProva(nHdlPrv,cPadrao,"LOJR130","")
				EndIf
											
				If  nTotal > 0
					RodaProva(nHdlPrv,nTotal)
					cA100Incl(cArquivo,nHdlPrv,3,"",.F.,lAglutina,,,,aLancCtb)
				EndIf				
					
			EndIf
						
			//Gravando Registro no SD2 zerado conforme legislacao, qdo pais igual a Brasil...
			nItensVenda := 0
			cFiltro		:= "D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_ITEM+D2_COD"
			
			For nX := 1 To Len(aSeekNF)
				If lLegislacao .AND. nI == 1
					nRegSD2 := 0
				EndIf
				
				If lLocxR130 .And. cPaisLoc == "MEX"
					aCondic := ExecBlock("LOCXR130",.F.,.F.,{})
					DbSelectArea("SD2")
					IndRegua("SD2",cArqSD2,cFiltro,aCondic[1],aCondic[2])
				Else
					DbSelectArea("SD2")
					IndRegua("SD2",cArqSD2,cFiltro)
				EndIf
				
				DbSelectArea("SD2")
				 
				#IFNDEF TOP
   					DbSetIndex(cArqSD2+OrdBagExt())
				#ENDIF
				
				nIndex	:= RetIndex("SD2")
				SD2->(DbSetOrder(nIndex+1))
				If nRegSD2 == 0
					SD2->(DbSeek( xFilial("SD2")+ aSeekNF[nX][1] + aSeekNF[nX][2] + aSeekNF[nX][3] + aSeekNF[nX][4] ))
				Else
					SD2->(DbGoTo(nRegSD2))
				Endif
				
				While 	SD2->(!Eof()) 					    .AND.;
						 SD2->D2_FILIAL	== xFilial("SD2") 	.AND.;
						 SD2->D2_DOC	== aSeekNF[nX][1]	.AND.;	
						 SD2->D2_SERIE	== aSeekNF[nX][2] 	.AND.;
						 SD2->D2_LOJA	== aSeekNF[nX][4]

					If Len(aNotas) > 1
						nItensVenda ++
						cItem := Soma1(cItem,Len(cItem))
						
						If nItensVenda > nMaxItens
							nItensVenda := 0
							cItem       := Replicate( "0", nTamItem )
							If lLegislacao
								nRegSD2  := SD2->(Recno())  // Guardo o registro da SD2 para voltar nesse item quando multiplas notas
							Endif	
							Exit
						Endif
					Endif
	
					If (cPaisLoc == "BRA" .OR. lIsMexico) .AND. lLegislacao	
						If Len(aNotas) < 2
							cItem := Soma1(cItem,Len(cItem))
						Endif	
					Endif
						
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Armazena os campos e os seus respectivos valores para posterior gravacao   ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If !lLegislacao
						For nCount := 1 TO LEN( aHeader1 )
							cVar := TRIM( aHeader1[ nCount ][2] )
							AADD( aRegsSD2, Eval( FielDblock( cVar ) ) )
						Next nCount
	                Else
						For nCount := 1 TO LEN( aHeader1 )

							cVar := TRIM( aHeader1[ nCount ][2] )

							If cVar <> "D2_ITEM" 
								AADD( aRegsSD2, Eval( FielDblock( cVar ) ) )
							Else
								AADD( aRegsSD2, cItem )						
							EndIf

						Next nCount	                
	                EndIf
						
					If cPaisLoc == "BRA"
						If !Empty(SD2->D2_CODISS)
							cCodIss 	:= SD2->D2_CODISS
						EndIf
					EndIf
	
					nRegSD2 := SD2->(Recno())
						
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Antes de gerar o SD2 da NF carrega o array aSD2 com os valores do SD2 do Cupom ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aAdd( aSD2, {0, {}} )
					aEstruSD2 := SD2->(DbStruct())
					For  nInd  := 1 To Len(aEstruSD2)
						If aEstruSD2[nInd,2] == "N"
			    			aADD(aSD2[Len(aSD2)][2],{aEstruSD2[nInd,1],&(aEstruSD2[nInd,1])})   
						EndIf
					Next nInd 
						
					Reclock("SD2",.T.)
					For nCount := 1 TO LEN( aHeader1 )
						cVar := TRIM( aHeader1[ nCount ][2] )
						REPLACE &("SD2->"+cVar) WITH aRegsSD2[ nCount ]
					Next nCount

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Para o Mexico, grava o cliente e loja conforme informado ³
					//³nos parametro de pergunta                                ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If lLegislacao .AND. lIsMexico 
						SD2->D2_CLIENTE	:= Mv_par10
						SD2->D2_LOJA 	:= Mv_par11
		   			ElseIf lLegislacao
						SD2->D2_CLIENTE	:= Mv_par10
						SD2->D2_LOJA 	:= Mv_par11
		   			Else
		   				SD2->D2_CLIENTE	:= Mv_par03
						SD2->D2_LOJA 	:= Mv_par04
					EndIf 
						
					SD2->D2_DOC     := cNumNota
					SD2->D2_SERIE   := cSerie
					SD2->D2_EMISSAO := dDatabase					
					SD2->D2_PDV    	:= ""
					SD2->D2_ESPECIE	:= cEspecie 
					SD2->D2_TIPODOC	:= "01" 
						
					// LjAnalisaLeg == 52 // SC nao zera campos para geracao da tabela SF3
					If cPaisLoc == "BRA" .AND. !LjAnalisaLeg(52)[1]
						SD2->D2_VALFRE	:= 0
						SD2->D2_DESPESA	:= 0
						SD2->D2_SEGURO	:= 0
						SD2->D2_VALIPI	:= 0
						SD2->D2_VALICM	:= 0
						SD2->D2_BASEICM	:= 0
						SD2->D2_IPI		:= 0
						SD2->D2_BRICMS	:= 0
						SD2->D2_BASEORI	:= 0
						SD2->D2_CODISS 	:= ""
						SD2->D2_ICMSRET	:= 0
						SD2->D2_BASIMP1	:= 0
						SD2->D2_BASIMP2	:= 0
						SD2->D2_BASIMP3	:= 0
						SD2->D2_BASIMP4	:= 0
						
						If !LjAnalisaLeg(83)[1]
							SD2->D2_BASIMP5	:= 0
							SD2->D2_BASIMP6	:= 0
							
							SD2->D2_VALIMP5	:= 0
							SD2->D2_VALIMP6	:= 0
						EndIf
						
						SD2->D2_VALIMP1	:= 0
						SD2->D2_VALIMP2	:= 0
						SD2->D2_VALIMP3	:= 0
						SD2->D2_VALIMP4	:= 0
						SD2->D2_ALIQINS	:= 0
						SD2->D2_BASEIPI	:= 0
						SD2->D2_BASEISS	:= 0
						SD2->D2_BASEINS	:= 0
						SD2->D2_BASEISS	:= 0
						SD2->D2_VALISS 	:= 0
						SD2->D2_ICMFRET	:= 0
						SD2->D2_VALINS	:= 0
						SD2->D2_SERIORI	:= SL1->L1_SERIE //Campos de amarracao entre nota fiscal e cupom fiscal.
					   	SD2->D2_ITEMORI := SD2->D2_ITEM
						
						If SD2->(ColumnPos("D2_NFCUP")) > 0 
							SD2->D2_NFCUP := aSeekNF[nX][1]	 
					   	EndIf
					   	
						If Len(aNotas) >  1
							SD2->D2_ITEM	:= cItem
							SD2->D2_ITEMPV 	:= cItem
						Endif												
					Else
						If Len(aNotas) >  1
							SD2->D2_ITEM	:= cItem
							SD2->D2_ITEMPV 	:= cItem
						Endif
						SD2->D2_REMITO	:= "NFCUP" //Gravar este campo para ser ignorado nos recalculos.
						SD2->D2_NUMSEQ	:= ProxNum()
						SD2->D2_NFORI	:= SL1->L1_DOC
						SD2->D2_SERIORI	:= SL1->L1_SERIE
					Endif

					nItem := FR271BPegaIT(SD2->D2_ITEM)
						
					// LjAnalisaLeg == 52 // SC nao zera campos para geracao da tabela SF3			                   
					If cPaisLoc == "BRA" .AND. !LjAnalisaLeg(52)[1]
						SD2->D2_CUSTO1  	:= 0
						SD2->D2_CUSTO2		:= 0
						SD2->D2_CUSTO3		:= 0
						SD2->D2_CUSTO4		:= 0
						SD2->D2_CUSTO5		:= 0
						SD2->D2_PRUNIT 		:= 0
						SD2->D2_DESCON 		:= 0
						SD2->D2_COMIS1   	:= 0
						SD2->D2_COMIS2   	:= 0
						SD2->D2_COMIS3   	:= 0
						SD2->D2_COMIS4   	:= 0
						SD2->D2_COMIS5   	:= 0
						SD2->D2_PRCVEN  	:= 0
						SD2->D2_TOTAL		:= 0
						SD2->D2_DESC		:= 0
						If SD2->(ColumnPos('D2_ALQIMP5')) > 0 .And. SD2->(ColumnPos('D2_ALQIMP6')) > 0
							SD2->D2_ALQIMP5		:= 0
							SD2->D2_ALQIMP6		:= 0						
						Endif							
					Endif
						
					If (cPaisLoc == "BRA" .OR. lIsMexico) .AND. !Empty(cTesNota)

						DbSelectArea("SB1")
						SB1->(DbSetOrder(1))
						SB1->(DbSeek( xFilial("SB1") + SD2->D2_COD ))

						DbSelectArea("SF4")
						SF4->(DbSetOrder(1))
						SF4->(DbSeek(xFilial()+cTesNota))
		
						If !Empty(SF4->F4_FORMULA)					
							cFormula := SF4->F4_FORMULA
						EndIf
																			
						If Empty(cCodIss)
							SD2->D2_TES		:= cTesNota							
						EndIf
		
						If cPaisLoc == "BRA"
							Posicione("SA1",1,xFilial("SA1")+SD2->D2_CLIENTE+SD2->D2_LOJA,"A1_EST")
							cCF := "5929"
							
							If lCfgTrib .Or. (!Empty(SF4->F4_VENPRES) .And. SF4->F4_VENPRES <> "1") //Tes configurado para venda presencial nao altera CFOP
								If SA1->A1_EST == cMvEstado .AND. SA1->A1_TIPO # "X"
									cCF := "5" + Subs(cCF,2,3)
								ElseIf SA1->A1_TIPO # "X"
									cCF := "6" + Subs(cCF,2,3)
								Else
									cCF := "7" + Subs(cCF,2,3)
								Endif
							EndIf
								
							SD2->D2_CF	:= cCF
						EndIf
					Endif
		
					//Grava o codigo de servico
					If !Empty(cCodIss)
						SD2->D2_CODISS 	:= cCodIss
						SD2->D2_TES		:= Alltrim(cTesServ)
						cCodIss 		:= ""					
						SF4->(DbSetOrder(1))
						SF4->(DbSeek(xFilial()+Alltrim(cTesServ)))
					EndIf                
		
					//Caso o parametro MV_LJLVFIS esteja como 1, realizada o tratamento no SF3 e SFT como no modo antigo (via MV_MAPARES)
					If lExisteFT .AND. cPaisLoc == "BRA" .AND. !lFisLivro
					
						Aadd(aGravaFT,(LjxCpsSft()))
							
						aGravaFT[nLinFT][1][2]  := xFilial("SD2") 
						aGravaFT[nLinFT][2][2]  := dDatabase	   
						aGravaFT[nLinFT][3][2]  := dDatabase	   
						aGravaFT[nLinFT][4][2]  := cNumNota
						aGravaFT[nLinFT][5][2]  := cSerie
						aGravaFT[nLinFT][6][2]  := SD2->D2_CLIENTE 
						aGravaFT[nLinFT][7][2]  := SD2->D2_LOJA    
						aGravaFT[nLinFT][8][2]  := cMvEstado						
						aGravaFT[nLinFT][9][2]  := SD2->D2_PDV
						aGravaFT[nLinFT][10][2] := "NF"
						aGravaFT[nLinFT][11][2] := SD2->D2_COD
						aGravaFT[nLinFT][12][2] := SD2->D2_ITEM				
							
						If !(lLegislacao)
							aGravaFT[nLinFT][25][2] := "NF/SERIE:" + SL1->L1_DOC + "/" + SL1->L1_SERIE +  " ECF:" + SL1->L1_PDV
						Else
							aGravaFT[nLinFT][25][2] := "F - Simples Faturamento"
						EndIf
						aGravaFT[nLinFT][14][2] := If(cPaisLoc == "BRA",cCf,"") 				
						aGravaFT[nLinFT][34][2] := "S"
						aGravaFT[nLinFT][13][2] := "S"
					
					Endif				
						
					SD2->(MsUnlock())
					SD2->(FKCommit())
		
				   	If lFisLivro
				   		If lIsMexico
				   			nItem := FR271BPegaIT(SD2->D2_ITEM)
				   		EndIf
				   		//Inicializa as funcoes  
						MaFisIniLoad(nItem,{	SD2->D2_COD,;		//IT_PRODUTO
												SD2->D2_TES,;		//IT_TES
												SD2->D2_CODISS,;	//IT_CODISS
												SD2->D2_QUANT,;		//IT_QUANT
												Nil,;				//IT_NFORI
												Nil,;				//IT_SERIORI
												SB1->(RecNo()),;	//IT_RECNOSB1
												SF4->(RecNo()),;	//IT_RECNOSF4
												0,;					//IT_RECORI
												Nil,;				//IT_LOTECTL
												Nil } )				//IT_NUMLOTE
										         				
						MaFisRecal("",nItem)
						If !Empty(cCF)
							MaFisLoad("IT_CF"		, cCF				, nItem)	//Ajusta o CFOP
							MaFisLoad("LF_CFO"		, cCF				, nItem)	//Ajusta o CFOP
							MaFisLoad("IT_VALMERC"	, SD2->D2_TOTAL + SD2->D2_DESCON , nItem) 
							MaFisLoad("IT_PRCUNI"	, SD2->D2_PRUNIT	, nItem)        
							MaFisLoad("IT_DESCONTO"	, SD2->D2_DESCON	, nItem)
						EndIf
						MaFisEndLoad(nItem,2)               //Finaliza a carga do item 
					EndIf 
	
					cSitTribD2 := ""
					If lCfgTrib //Configurador de Tributos - Todos os tributos da venda
						jTaxesConfig := LjCfgTaxes(, FRTPegaIT(SD2->D2_ITEM), {"regras_escrituracao"})
						
						If Len(jTaxesConfig) > 0
							cSitTribD2 := jTaxesConfig[1]["regras_escrituracao"]["cst"]
						EndIf
					EndIf
					
					If Empty(cSitTribD2) //Legado TES
						cSitTribD2 := SF4->F4_SITTRIB
					EndIf

					Reclock("SD2", .F.)
					SD2->D2_CLASFIS	:= (SubStr(SB1->B1_ORIGEM, 1, 1) + cSitTribD2)
					SD2->(MsUnlock())

					//Guarda o Recno do Registro SD2 que devera ser atualizado
					aSD2[Len(aSD2)][1] := SD2->(Recno())
						
					//Prepara os dados para a geracao do livro fiscal...
					If cPaisLoc <> "BRA"
						DbSelectArea("SF4")
						SF4->(DbSetOrder(1))
						SF4->(DbSeek(xFilial("SF4")+SD2->D2_TES))
						
						If !Empty(SF4->F4_FORMULA)					
							cFormula := SF4->F4_FORMULA
						EndIf
	
						aImpVarSD2 := Lj130SimSD2(SD2->D2_TES,"SD2")
						aLivro     := GetBook(@aGetBook,aImpVarSD2,"V",nTaxaMoeda,aLivro,"S",,lGeraLivro)
					Endif
						
					If ExistBlock("LJR130IT")
						ExecBlock("LJR130IT",.F.,.F.)
					Endif
					
					nLinFT++					
						
					DbSelectArea("SD2")					
					SD2->(DbGoto(nRegSD2))
					
					//Paliativo, algumas bases o Goto falha e fica no RecNo = 0
					nCount := 0
					If SD2->(Recno()) <> nRegSD2
						SD2->(DbSeek(xFilial("SD2") + aSeekNF[nX][1] + aSeekNF[nX][2] + aSeekNF[nX][3] + aSeekNF[nX][4]))
						While SD2->(!Eof()) .AND. SD2->(Recno()) <> nRegSD2 .AND. nCount <> 10000 
						  SD2->(DbSkip())
						  nCount++
						EndDo 				
					EndIf
						
					//Campos de amarracao entre nota fiscal e cupom fiscal.
					RecLock( "SD2", .F. )
					SD2->D2_SERIORI	:= cSerie 
					SD2->D2_ITEMORI := cItem 
					If SD2->(ColumnPos("D2_NFCUP")) > 0 
						SD2->D2_NFCUP	:= cNumNota
					EndIf  						 					
					SD2->(MsUnlock()) 

					SD2->(DbSkip())
					aRegsSD2:= {}
					nRegSD2 := SD2->(RecNo())
				End
					
				DbSelectArea("SD2")
				RetIndex("SD2")
				FErase(cArqSD2+OrdBagExt()) 
				Set Filter To
			Next nX
				
			//Grava o Livro Fiscal
			If cPaisLoc <> "BRA"
				Lj130Livro("NF",dDataBase,aLivro)
				aLivro     := {}
				aGetBook   := {}
				aImpVarSD2 := {}
			Else
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Executa a gravacao do SF3 via MATXFIS³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lFisLivro
					MaFisAtuSF3(1,"S",SF2->(Recno()),"SF2",NIL,NIL,"LOJR130")							
					MaFisEnd()
				EndIf
			
			EndIf    			
			  			
			// Apos geracao da tabela SF3 zera as tabelas SF2 e SD2			  			
			If lFisLivro .AND. LjAnalisaLeg(52)[1]
				    			
				DBSelectArea("SF2") 						//Posicionado no SF2 da NF e atualiza os campos de valores com os dados do CF referenciado
				SF2->(DBSetOrder(1))
				Lj7GeraSL( "SF2", aSF2, .F., .T.)
				
				RecLock("SF2",.F.)				
				SF2->F2_ICMFRET		:= 0
				SF2->F2_FRETE		:= 0
				SF2->F2_SEGURO		:= 0
				SF2->F2_DESPESA		:= 0
				SF2->F2_VALICM		:= 0
				SF2->F2_BASEICM		:= 0
				SF2->F2_VALIPI		:= 0
				SF2->F2_BASEIPI		:= 0
				SF2->F2_ICMSRET		:= 0
				SF2->F2_BASEISS		:= 0
				SF2->F2_VALISS 		:= 0
				SF2->F2_BRICMS 		:= 0
				SF2->F2_ICMAUTO 	:= 0
				SF2->F2_VALINSS		:= 0
				SF2->F2_BASEINS		:= 0
				SF2->F2_VALIMP1		:= 0
				SF2->F2_VALIMP2		:= 0
				SF2->F2_VALIMP3		:= 0
				SF2->F2_VALIMP4		:= 0
				SF2->F2_VALIMP5		:= 0
				SF2->F2_VALIMP6		:= 0
				SF2->F2_VALPIS		:= 0
				SF2->F2_VALIRRF		:= 0
				If SF2->(ColumnPos('F2_BASIMP5')) > 0 .And. SF2->(ColumnPos('F2_BASIMP6')) > 0				
					SF2->F2_BASIMP5		:= 0				
					SF2->F2_BASIMP6		:= 0								
				Endif	
				SF2->(MsUnlock())
				nRecAntSD2 := SD2->(Recno())    
				
				DBSelectArea("SD2")                         //Percorre Itens da NF para atualizar valores do CF referenciado
				SD2->(DBSetOrder(1))                               
				For  nInd := 1 to Len(aSD2)	                
					SD2->( dbGoTo ( aSD2[nInd][1] ) )
	   				Lj7GeraSL( "SD2", aSD2[nInd][2], .F., .T.)
	   				RecLock("SD2",.F.)
   					SD2->D2_VALFRE	:= 0
					SD2->D2_DESPESA	:= 0
					SD2->D2_SEGURO	:= 0
					SD2->D2_VALICM	:= 0
					SD2->D2_VALIPI	:= 0
					SD2->D2_BASEICM	:= 0
					SD2->D2_PICM	:= 0
					SD2->D2_IPI		:= 0
					SD2->D2_PICM	:= 0
					SD2->D2_BRICMS	:= 0
					SD2->D2_BASEORI	:= 0
					SD2->D2_CODISS 	:= ""
					SD2->D2_ICMSRET	:= 0
					SD2->D2_BASIMP1	:= 0
					SD2->D2_BASIMP2	:= 0
					SD2->D2_BASIMP3	:= 0
					SD2->D2_BASIMP4	:= 0
					SD2->D2_BASIMP5	:= 0
					SD2->D2_BASIMP6	:= 0
					SD2->D2_VALIMP1	:= 0
					SD2->D2_VALIMP2	:= 0
					SD2->D2_VALIMP3	:= 0
					SD2->D2_VALIMP4	:= 0
					SD2->D2_VALIMP5	:= 0
					SD2->D2_VALIMP6	:= 0
					SD2->D2_ALIQINS	:= 0
					SD2->D2_BASEIPI	:= 0
					SD2->D2_BASEISS	:= 0
					SD2->D2_BASEINS	:= 0
					SD2->D2_BASEISS	:= 0
					SD2->D2_VALISS 	:= 0
					SD2->D2_ICMFRET	:= 0
					SD2->D2_VALINS	:= 0
					SD2->(MsUnlock())
	   			Next nInd
				SD2->( dbGoTo ( nRecAntSD2 ) )				
			EndIf
				
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Grava o reg. no SF3 (Livro Fiscal) ref. a NF sobre cupom ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If cPaisLoc == "BRA" .AND. !lFisLivro
			   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			   //³ Se MV_MAPARES = N, gera o registro do livro fiscal    ³
			   //³ correspondente com valores zerados				     ³
			   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			   If SuperGetMV("MV_MAPARES") == "N"
			      RecLock("SF3",.T.)						
	             aStruSF3 := SF3->(dbStruct())		
	             For nX := 1 To Len(aStruSF3)
					If aStruSF3[nX][2] <> "N"
						FieldPut(FieldPos(aStruSF3[nX][1]),CriaVar(aStruSF3[nX][1]))	                    
					EndIf   
	             Next nX                                             	                    
				  REPLACE SF3->F3_FILIAL	WITH xFilial("SF3")	                    
				  REPLACE SF3->F3_ENTRADA	WITH dDatabase	                    
				  REPLACE SF3->F3_EMISSAO	WITH dDatabase	                    						
				  REPLACE SF3->F3_CLIEFOR	WITH SL1->L1_CLIENTE
				  REPLACE SF3->F3_LOJA	    WITH SL1->L1_LOJA						
				  REPLACE SF3->F3_CFO		WITH cCf
				  REPLACE SF3->F3_NFISCAL	WITH cNumNota
				  REPLACE SF3->F3_SERIE  	WITH cSerie
				  REPLACE SF3->F3_ESPECIE	WITH "NF"						
				  REPLACE SF3->F3_FORMUL	WITH "N"												
				  If !(lLegislacao)
				     REPLACE SF3->F3_OBSERV	WITH "CF/SERIE:" + SL1->L1_DOC + "/" + SL1->L1_SERIE +  " ECF:" + SL1->L1_PDV
				  Else
					 REPLACE SF3->F3_OBSERV	WITH "F - Simples Faturamento"
				  EndIf
				  REPLACE SF3->F3_TIPO	    WITH ""
				  REPLACE SF3->F3_ESTADO	WITH If(!Empty(cEstCF),cEstCF,cMvEstado)	
				  REPLACE SF3->F3_FORMULA	WITH cFormula
				  MsUnLock()
				  //ÚÄÄÄÄÄÄÄÄÄ¿
				  //³Gerao SFT³
				  //ÀÄÄÄÄÄÄÄÄÄÙ
			      If lExisteFT
			          LjxGerSft(aGravaFT)
			      EndIf
			   EndIf
			EndIf

			If cPaisLoc == "BRA" .AND. SF3->F3_NFISCAL == cNumNota .AND. SF3->F3_SERIE == cSerie .AND. SF3->F3_FILIAL == xFilial("SF3")  .AND. SF3->F3_LOJA == SL1->L1_LOJA
				Reclock("SF3",.F.)					
				REPLACE SF3->F3_CHVNFE	    WITH ""
				SF3->(MsUnLock())
			EndIf


			If ExistBlock("LJR130GR")
				ExecBlock("LJR130GR",.F.,.F.)
			Endif
		Next nI     
	    
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a gravacao do F2_NEXTDOC quando o parametro MV_TPNRNFS == "3"    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cMV_TPNRNFS == "3" .AND. Len( aNotas ) > 1
			nRecnoSF2 := SF2->( Recno() )
			SF2->( DbSetOrder( 1 ) )
		    For nX := 1 to Len( aNotas ) - 1
				If SF2->(DbSeek( xFilial("SF2") + aNotas[nX][2] + aNotas[nX][1] ))
					RecLock( "SF2", .F. )
					SF2->F2_NEXTDOC := aNotas[ nX + 1 ][2]
					SF2->( MsUnlock() )
				Endif
			Next nX 
			SF2->( dbGoTo ( nRecnoSF2 ) )
		Endif
		
		//Se for integração com hotelaria e o cliente da DANFE for empresa pública, então gera o financeiro da DANFE para gerar os abatimentos de impostos, conforme configuração da natureza parametrizada 
		If lIntegHtl				
			//Verifica se o cliente é empresa publica
			If SA1->A1_TPESSOA == "EP"			
				aAdd( aTitCR, {"E1_NUM", PadR(cNumNota, TamSX3("E1_NUM")[1]), Nil} )
				aAdd( aTitCR, {"E1_PREFIXO", PadR(cSerie, TamSX3("E1_PREFIXO")[1]), Nil} )
				aAdd( aTitCR, {"E1_PARCELA", PadR("A", TamSX3("E1_PARCELA")[1]), Nil} )
				aAdd( aTitCR, {"E1_TIPO", PadR("FA", TamSX3("E1_TIPO")[1]), Nil} )
				aAdd( aTitCR, {"E1_NATUREZ", PadR(cNaturez, TamSX3("E1_NATUREZ")[1]), Nil} )
				aAdd( aTitCR, {"E1_CLIENTE", PadR(SF2->F2_CLIENTE, TamSX3("E1_CLIENTE")[1] ), Nil} )
				aAdd( aTitCR, {"E1_LOJA", PadR( SF2->F2_LOJA, TamSX3("E1_LOJA")[1]), Nil} )
				aAdd( aTitCR, {"E1_EMISSAO", SF2->F2_EMISSAO, Nil} )
				aAdd( aTitCR, {"E1_VENCTO", SF2->F2_EMISSAO, Nil} )
				aAdd( aTitCR, {"E1_VENCREA", SF2->F2_EMISSAO, Nil} )
				aAdd( aTitCR, {"E1_VALOR", nTotalNfs, Nil} )
				aAdd( aTitCR, {"E1_VLCRUZ", nTotalNfs, Nil} )
				aAdd( aTitCR, {"E1_HIST", STR0084, NIL} ) //"DANFE org.pub.- Hotelaria"
				aAdd( aTitCR, {"E1_ORIGEM", "LOJR130", Nil} )
				aAdd( aTitCR, {"E1_MOEDA", 1, Nil} )
										
				MSExecAuto( {|x,y,z|FINA040(x,y)}, aTitCR, 3 )
				
				//Se houve erros no processamento do MSExecAuto
				If lMsErroAuto
					aErroAuto := GetAutoGRLog()
					
					cErroAuto := "" 
					For nI := 1 To Len(aErroAuto)
						cErroAuto += aErroAuto[nI] + Chr(10)
					Next nI
					Help( ,, "DANFETITCR",, STR0085 + Chr(10) + cErroAuto, 1, 0,,,,,, {""} ) //"Não foi possível incluir o título a receber referente a DANFE para empresa pública. Erro:"
					lRet := .F.
					
					DisarmTransaction()
					MsUnLockAll()
				EndIf				
			EndIf			
		EndIf
		    
	    While (GetSX8Len() > nSaveSx8)
		   ConfirmSX8()
	    End
	END TRANSACTION
	
	If lIsMexico //Para o México a impressão do Script deve ser após a geração do CFD
		cMexNota	:= cNumNota
		cMexSerie	:= cSerie
		aMexRegSF2	:= aRegSF2
	Else
		If lImprime .AND. !lIntegHtl //Hotelaria nao imprime script
			U_LjImpScript( cNumNota,cSerie,aRegSF2,wnrel)
		EndIf
	EndIf

EndIf

lRet := .T.
FwFreeObj(jTaxesConfig)
jTaxesConfig := Nil

//Retorna a Area Original...
RestArea(aArea)

Return lRet



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³Lj130Livro   ³ Autor ³ Vendas Clientes	³ Data ³ 12.11.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡ao³ Gerar os registros do Livro Fiscal                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ LOJR130                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Lj130Livro(cEspecie,dData,aLivro)
Local cEspec        := Padr(cEspecie,len(criavar("F3_ESPECIE",.f.)))
Local cEspTmp	    := MVNOTAFIS+"|"+GetSESNew('NDC',"1")+"|"+GetSESNew('NDI',"2")+"|"+GetSESNew('NCI',"2")+"|"+GetSESNew('NCC',"2")
Local cTipContNF    := If(ValType(lFiscal)== "L" .AND. lFiscal ,SuperGetMV("MV_CONTNFI",,"I"),SuperGetMV("MV_CONTNF"))
Local nX, nY

cNumNota := PadR(cNumNota,TamSX3("F3_NFISCAL")[1])

DbSelectArea("SF3")
DbSetOrder(5)
//Exclui os registros de mesma numeracao que estao cancelados
If DbSeek( xFilial("SF3")+cSerie+cNumNota)
	While !Eof() .AND. (xFilial("SF3")+cSerie+cNumNota) == (SF3->F3_FILIAL+SF3->F3_SERIE+SF3->F3_NFISCAL)
	   If !Empty(SF3->F3_DTCANC)
	      If cTipContNF == "M" .AND. Alltrim(F3_ESPECIE)$ cEspTmp .OR. (cTipContNF == "I" .AND. Alltrim(F3_ESPECIE)==	Alltrim(cEspec))	   
			 RecLock("SF3",.F.)
			 DbDelete()
			 MsUnLock()
			 SF3->(FKCommit()) //-- Atualiza as gravacoes pendentes na tabela
		  Endif
	   Endif
	   DbSkip()
	End
Endif

For nX := 2 To Len( aLivro )
	RecLock( "SF3",.T. )
	For nY := 1 To Len( aLivro[1] )
		SF3->( FieldPut(FieldPos(aLivro[1,nY]),aLivro[nX,nY]) )
	Next nY
	SF3->F3_FILIAL	:= xFilial("SF3")
	SF3->F3_NFISCAL	:= cNumNota
	SF3->F3_SERIE	:= cSerie	
	SF3->F3_ENTRADA	:= dData	
	MsUnLock()
	SF3->(FKCommit()) //-- Atualiza as gravacoes pendentes na tabela
Next nX

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Lj130SimSD2ºAutor  ³Vendas Clientes  	 º Data ³  20/11/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Preparacao de array para geracao do livro                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ LOJR130                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Lj130SimSD2(cTes,cAliasSD2)
Local nX								// Contador de For
Local cCampoBase:= ""					// Campo Base
Local cCampoVlr := ""					// Valor de campo
Local cCampoAliq:= ""					// Aliquota de campo
Local aInfo	    :=	TesImpInf(cTes)		// Informcao TES
Local aReturn	:=	{0,0,0,0,0,{}}		// Retorna da funcao

aReturn[1]	:=	(cAliasSD2)->D2_QUANT
aReturn[2]	:=	(cAliasSD2)->D2_PRCVEN
aReturn[3]	:=	(cAliasSD2)->D2_TOTAL
aReturn[4]	:=	0
aReturn[5]	:=	0

For nX	:=	1	To	Len(aInfo)
    cCampoBase  := (cAliasSD2)+"->"+aInfo[nX][7]
    cCampoVlr   := (cAliasSD2)+"->"+aInfo[nX][2]    
    cCampoAliq  := (cAliasSD2)+"->"+aInfo[nX][10]
    
    AAdd(aReturn[6],Array(18))
	aReturn[6][nX][1]	:= aInfo[nX][1]
	aReturn[6][nX][2]	:= &(cCampoAliq)
	aReturn[6][nX][3]	:= &(cCampoBase)
	aReturn[6][nX][4]	:= &(cCampoVlr)
	aReturn[6][nX][5]	:= aInfo[nX][3]+aInfo[nX][4]+aInfo[nX][5]
	aReturn[6][nX][6]	:= "D2_VALIMP"+Substr(aInfo[nX][2],10)
	aReturn[6][nX][7]	:= "D2_BASIMP"+Substr(aInfo[nX][2],10)
	aReturn[6][nX][8]	:= "F2_VALIMP"+Substr(aInfo[nX][2],10)
	aReturn[6][nX][9]	:= "F2_BASIMP"+Substr(aInfo[nX][2],10)
	aReturn[6][nX][17] := Substr(aInfo[nX][2],10)
Next nX                                     

Return(aReturn)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Lj130CalcNFºAutor  ³Vendas Clientes	 º Data ³  12/03/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Cria array com as diversas nfs criadas para o cupom.        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ LOJR130                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Lj130CalcNFs(aTotNfs, nMaxItens, aItms)
Local aAreaAtu		:= GetArea()		// GetArea
Local aAreaSD2		:= SD2->(GetArea())	// GetArea do SD2
Local nItensVenda	:= 0				// Itens da venda
Local aImpsInf		:= {}				// Impostos
Local nI			:= 0				// Contador de For
Local aImps			:= {}				// Impostos
Local nTotImp		:= 0				// Total de impostos
Local nPosImp		:= 0				// Posicao no Ascan
Local nReg			:= 0
Local cFilSD2		:= xFilial("SD2")

Private cCpoBase	:= ""
Private cCpoVal		:= ""

Default aItms		:= {}

//////////////////////////////////////////////////////////
//Estrutura do array aTotNfs                            //
//1 - F2_VALMERC										//
//2 - F2_VALFAT											//
//3 - F2_VALBRUT										//
//4 - F2_DESCONT										//
//5 - Array com a sumarizacao dos impostos variaveis	//
//////////////////////////////////////////////////////////

DbSelectArea("SD2")
SD2->(DbSetOrder(3))//
If cPaisLoc == 'MEX'
	For nReg := 1 to Len(aItms)
		If SD2->(DbSeek(cFilSD2+aItms[nReg][1]+SL1->(L1_SERIE+L1_CLIENTE+L1_LOJA)))
			While !SD2->(Eof()) .AND.	SD2->(D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA) == ;
					(cFilSD2+aItms[nReg][1]+SL1->(L1_SERIE+L1_CLIENTE+L1_LOJA))

				nItensVenda++		
				If (nItensVenda > nMaxItens)
					nItensVenda := 1
					aImps       := {}
				Endif
		
				nTotImp  := 0
				aImpsInf := TesImpInf(D2_TES)
				For nI := 1 To Len(aImpsInf)
					cCpoBase := aImpsInf[nI][7]
					cCpoVal  := aImpsInf[nI][2]
					If (nPosImp := aScan(aImps,{|x| Trim(x[1])==aImpsInf[nI][1]})) == 0  
						Aadd(aImps,{aImpsInf[nI][1],aImpsInf[nI][8],&cCpoBase.,;
					    	        aImpsInf[nI][6],&cCpoVal.,aImpsInf[nI][3]})
					Else
						aImps[nPosImp][3] += &cCpoBase.
						aImps[nPosImp][5] += &cCpoVal.
					Endif
					
					If aImpsInf[nI][3] == "1"
						nTotImp += &cCpoVal.
					Endif
				Next nI

				If (nItensVenda == 1)
					Aadd(aTotNfs,{D2_TOTAL,D2_TOTAL+nTotImp,D2_TOTAL+nTotImp,D2_DESCON,aClone(aImps)})
				Else  
					aTotNfs[Len(aTotNfs)][1] += D2_TOTAL
					aTotNfs[Len(aTotNfs)][2] += D2_TOTAL+nTotImp
					aTotNfs[Len(aTotNfs)][3] += D2_TOTAL+nTotImp				
					aTotNfs[Len(aTotNfs)][4] += D2_DESCON
					aTotNfs[Len(aTotNfs)][5] := aClone(aImps)
				Endif
				DbSkip()
			End
			RestArea(aAreaSD2)
		Endif
	Next
Else
	If SD2->(DbSeek(cFilSD2+SL1->(L1_DOC+L1_SERIE+L1_CLIENTE+L1_LOJA)))
		
		While !SD2->(Eof()) .AND.	SD2->(D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA) == ;
					        (cFilSD2+SL1->(L1_DOC+L1_SERIE+L1_CLIENTE+L1_LOJA))
	
			nItensVenda++		
			If (nItensVenda > nMaxItens)
				nItensVenda := 1
				aImps       := {}
			Endif
	
			nTotImp  := 0
			aImpsInf := TesImpInf(D2_TES)
			For nI := 1 To Len(aImpsInf)
				cCpoBase := aImpsInf[nI][7]
				cCpoVal  := aImpsInf[nI][2]
				If (nPosImp := aScan(aImps,{|x| Trim(x[1])==aImpsInf[nI][1]})) == 0  
					Aadd(aImps,{aImpsInf[nI][1],aImpsInf[nI][8],&cCpoBase.,;
				    	        aImpsInf[nI][6],&cCpoVal.,aImpsInf[nI][3]})
				Else
					aImps[nPosImp][3] += &cCpoBase.
					aImps[nPosImp][5] += &cCpoVal.
				Endif
				
				If aImpsInf[nI][3] == "1"
					nTotImp += &cCpoVal.
				Endif
			Next nI
	
			If (nItensVenda == 1)
				Aadd(aTotNfs,{D2_TOTAL,D2_TOTAL+nTotImp,D2_TOTAL+nTotImp,D2_DESCON,aClone(aImps)})
			Else  
				aTotNfs[Len(aTotNfs)][1] += D2_TOTAL
				aTotNfs[Len(aTotNfs)][2] += D2_TOTAL+nTotImp
				aTotNfs[Len(aTotNfs)][3] += D2_TOTAL+nTotImp				
				aTotNfs[Len(aTotNfs)][4] += D2_DESCON
				aTotNfs[Len(aTotNfs)][5] := aClone(aImps)
			Endif
			DbSkip()
		EndDo
		RestArea(aAreaSD2)
	Endif
EndIf
RestArea(aAreaAtu)

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³LjR130Cli  ºAutor  ³Vendas Clientes	 º Data ³  03/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Valida o codigo do cliente - localizacoes.                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³LOJR130                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function LjR130Cli(lValid)

Local lRet 		:= .T.															//Retorno da funcao
Local cCliPad   := Alltrim(SuperGetMV("MV_CLIPAD",,"000001"))                   //Cliente padrao
Local cLojPad   := Alltrim(SuperGetMV("MV_LOJAPAD",,"01"))                      //Loja padrao 
Local lAlterou  := .F.                                                          //Verifica se alterou o cliente ou a loja
Local cCliente  := ""                                                           //Cliente
Local cLoja     := ""                                                           //Loja 
Local cMvPar01	:= If(Empty(Mv_Par01),"",Mv_Par01)                              //Numero do cupom fiscal.
Local cMvPar02	:= If(Empty(Mv_Par02),"",Mv_Par02)                              //Serie do cupom fiscal. 
Local cMvPar03	:= If(Empty(Mv_Par03),"",Mv_Par03)								//Cliente
Local cMvPar04	:= If(Empty(Mv_Par04),SuperGetMV("MV_LOJAPAD",,"01"),Mv_Par04)	//Loja												 
Local cMvPar10	:= If(Empty(Mv_Par10),"",Mv_Par10)								//Para o cliente
Local cMvPar11	:= If(Empty(Mv_Par11),SuperGetMV("MV_LOJAPAD",,"01"),Mv_Par11)	//Para a loja 
Local lClLjPad    := .F.                                                          //Verifica se e cliente e loja padrao
Local nTamA1Cod   := TamSx3("A1_COD")[1] //Tamanho campo A1_COD no dicionario
Local nTamA1Loj   := TamSx3("A1_LOJA")[1] //Tamanho campo A1_LOJA no dicionario  

//Somente realiza a pesquisa completa se informou os dois parametros (Cliente+Loja), caso contrário a validação será no momento que confirmar o Pergunte
//Motivo: Essa rotina é utilizada no Valid do SX1 do cliente e loja, se validar sempre pode travar o usuário
Default lValid := .T. 

//Se confirmando a tela do pergunte, atualiza parametro da SX1 para considerar na rotina de validação de dados: LjR130VerInf
If !lValid
	Mv_Par04 := cMvPar04	//Loja
	Mv_Par11 := cMvPar11	//Loja
EndIf

If lLegislacao
	cCliente 	:= cMvPar10
	cLoja    	:= cMvPar11
Else
	cCliente := cMvPar03
	cLoja    := cMvPar04
EndIf 	

cCliente := PadR(cCliente,nTamA1Cod)
cLoja    := PadR(cLoja,nTamA1Loj)

// Nao permite a impressao de Nota sobre cupom para o cliente padrao
If AllTrim(cCliente+cLoja) == AllTrim(cCliPad+cLojPad)
	Ljr130Msg(STR0057, NIL ,1)			//"Não é permitido a impressão de Nota Fiscal para o cliente  padrão"
	lRet := .F.
EndIf		

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Realiza a busca no SA1 para validar o codigo do cliente³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lRet   
	DbSelectArea("SA1")
	SA1->(DbSetOrder(1))
	If SA1->(DbSeek(xFilial("SA1") + cCliente + cLoja))
		If SA1->A1_MSBLQL == "1"
			//"Cliente não está ativo."+"Atenção" 
			Ljr130Msg(STR0107,STR0018,1)
			lRet := .F.
		EndIf
		If lLegislacao
			If Empty(SA1->A1_CGC)
				//"Cliente não tem RCF. Não sera possível realizar a fatura."+"Atenção"
				Ljr130Msg(STR0017,STR0018,1)				
				lRet := .F.
			EndIf
		ElseIf cPaisLoc == "BRA"
			DbSelectArea("SL1")
			DbSetOrder(2)
			If DbSeek(xFilial("SL1")+ cMvPar02 + cMvPar01 ) //L1_FILIAL + L1_SERIE + L1_DOC
				
				lAlterou := Alltrim(SL1->L1_CLIENTE) <> Alltrim(cCliente) .OR. Alltrim(SL1->L1_LOJA) <> Alltrim(cLoja)
				lClLjPad := Alltrim(SL1->L1_CLIENTE) == cCliPad .AND. Alltrim(SL1->L1_LOJA) == cLojPad
				
				If lAlterou .AND. !lClLjPad 			//Nao permite alterar o cliente se o cupom nao foi gerado para o cliente e loja padrao.
					Ljr130Msg(STR0053+AllTrim(SL1->L1_DOC)+CHR(13)+CHR(10)+STR0054+CHR(13)+CHR(10)+STR0090+Alltrim(SL1->L1_CLIENTE)+"/"+Alltrim(SL1->L1_LOJA), NIL, 1)//Favor informar o cliente e a loja referentes ao numero do cupom fiscal: ## "Está venda está registrada para o cliente/loja:"
					lRet := .F.							//Somente e possivel alterar o cliente e a loja caso o cupom fiscal tenha sido gerado para o cliente e loja padrao.
				EndIf
			EndIf
		EndIf
	Else
		//"Código de cliente/loja não existe no cadastro de Clientes."+"Atenção"
		Ljr130Msg(STR0019,STR0018,1)
			
		If !lValid	//somente retorna erro .F. de cliente não encontrado
			lRet := .F.
		EndIf	
	EndIf
EndIf

If !lRet .AND. lExecAt
	lMsErroAuto := .T.
EndIf

Return lRet 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³LjR130Val  ºAutor  ³Vendas e CRM       º Data ³  18/07/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Valida se as TES estao configuradas corretamente no caso deº±±
±±º          ³ SF3 onLine.                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³LOJR130                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function LjR130Val(cTesNota,cTesServ)

Local lRet 			:= .T.		// Retorno da funcao
Local lVerTesProd 	:= .F.		// Se a TES de produto esta verificada
Local lVerTesServ 	:= .F.		// Se a TES de servico esta verificada
Local cMsgForm		:= ""		// Conteudo da formula utilizada
Local aMsg130Erro	:= {}		// Mensagens de erro na configuracao de TES
Local cMsgErro		:= ""		// Mensagem de erro
Local nX			:= 0		// Variavel de for.
Local oFont						// Objeto para apresentacao da tela
Local oDlg						// Objeto para apresentacao da tela
Local oMemo						// Objeto para apresentacao da tela

Default cTesNota := ""			// Parametro MV_TESNOTA
Default cTesServ := ""			// Parametro MV_LJNCUPS

If lFisLivro     

	lRet := .F.

	If !Empty(cTesServ) .AND. !Empty(cTesNota)

		DbSelectArea("SF4")
		
		SF4->(DbSetOrder(1))
		If SF4->(DbSeek(xFilial("SF4") + cTesNota))	
			
			If cPaisLoc == "BRA"
				If !Empty(SF4->F4_LFICM) .AND. SF4->F4_LFICM <> "N"
				
					If !Empty(SF4->F4_FORMULA)
	
						cMsgForm := Alltrim(Formula(SF4->F4_FORMULA))
	
						If Alltrim(cMsgForm) == "S" .OR. Empty(cMsgForm)
							lVerTesProd := .T.
						Else
							//"A fórmula (F4_FORMULA) utilizada na TES ("+ Alltrim(cTesNota) + ") de produto, informado no parâmetro MV_TESNOTA, deve ter o conteúdo de 'S' ou em branco."					
							Aadd(aMsg130Erro,STR0022 + Alltrim(cTesNota) + STR0023 + STR0024)
						EndIf
	
			        Else
						//"O campo de Formula (F4_FORMULA) do cadastro de TES ("+ Alltrim(cTesNota) + ") de produto,informado no parâmetro MV_TESNOTA, deve ter uma fórmula cadastrada."		        
						Aadd(aMsg130Erro,STR0025+ Alltrim(cTesNota) + STR0023 + STR0026)
			        EndIf
			    
				Else
					//"O campo L.Fisc. ICMS (F4_LFICM) do cadastro da TES ("+ Alltrim(cTesNota) + ") de produto, informado no parâmetro MV_TESNOTA, deve ser diferente de 'N'."			
					Aadd(aMsg130Erro,STR0027 + Alltrim(cTesNota) + STR0023 + STR0028)
				EndIf
			Else
				lVerTesProd := .T.
			EndIf
			
		Else
			//"TES " + Alltrim(cTesNota) + ", informado no parâmetro MV_TESNOTA, não está cadastrada na tabela de Tipos de Entrada e Saídas."		
			Aadd(aMsg130Erro,STR0029 + Alltrim(cTesNota) + STR0030)
		EndIf
			
		SF4->(DbSetOrder(1))
		If SF4->(DbSeek(xFilial("SF4") + cTesServ))	
			
			If cPaisLoc == "BRA"
				If !Empty(SF4->F4_LFISS) .AND. SF4->F4_LFISS <> "N"
					
					If SF4->F4_ISS == "S"
					
						If !Empty(SF4->F4_FORMULA)
		
							cMsgForm := Alltrim(Formula(SF4->F4_FORMULA))
		
							If Alltrim(cMsgForm) == "S" .OR. Empty(cMsgForm)
								lVerTesServ := .T.
							Else
								//"A fórmula (F4_FORMULA) utilizada na TES (" + Alltrim(cTesServ) + ") de serviço, informado no parâmetro MV_LJNCUPS, deve ter o conteúdo de 'S' ou em branco."
								Aadd(aMsg130Erro,STR0022 + Alltrim(cTesServ) + STR0031 + STR0024)					
							EndIf
				        Else
							//"O campo de Formula (F4_FORMULA) do cadastro de TES (" + Alltrim(cTesServ) + ") de serviço, informado no parâmetro MV_LJNCUPS, deve ter uma fórmula cadastrada."			        
				        	Aadd(aMsg130Erro,STR0025 + Alltrim(cTesServ) + STR0031 + STR0026)
				        EndIf
			    	Else
			    	    //"O campo Cálcula ISS (F4_ISS) do cadastro da TES (" + Alltrim(cTesServ) + ") de serviço, informado no parâmetro MV_LJNCUPS, deve estar como 'S'."
						Aadd(aMsg130Erro,STR0032 + Alltrim(cTesServ) + STR0031 + STR0033)		    	
			    	EndIf
				Else
					//"O campo L.Fisc. ISS (F4_LFISS) do cadastro da TES (" + Alltrim(cTesServ) + ") de serviço, informado no parâmetro MV_LJNCUPS, deve ser diferente de 'N'."			
					Aadd(aMsg130Erro,STR0034 + Alltrim(cTesServ) + STR0031 + STR0028)
				EndIf
			Else
				lVerTesServ := .T.
			EndIf
			
		Else
			//"TES " + Alltrim(cTesServ) + ", informado no parâmetro MV_LJNCUPS, não está cadastrada na tabela de Tipos de Entrada e Saídas."		
			Aadd(aMsg130Erro,STR0029 + Alltrim(cTesServ) + STR0035)
		EndIf
    Else
        //"Os parâmetros MV_TESNOTA e MV_LJNCUPS não estão preenchidos corretamente."
    	Aadd(aMsg130Erro,STR0036)
	EndIf

	If lVerTesProd .AND. lVerTesServ
		lRet := .T.
	EndIf
EndIf

If !lRet
	//"A configuracao das TES de produto e serviço não estão corretas. Verificar:"
	cMsgErro := STR0037 + Chr(10)
	
	For nX := 1 To Len(aMsg130Erro)
		cMsgErro += Chr(10) + "- " +  aMsg130Erro[nX] + Chr(10)
	Next nX
    //"Por favor, regularize as situações acima para prosseguir na emissão da nota sobre cupom."
	cMsgErro +=	Chr(10) + STR0038

	If !lExecAt
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Monta tela com as informacoes do erro de configuracao     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DEFINE FONT oFont NAME "ARIAL" SIZE 6,16
		//"Emissão de Nota sobre Cupom - Livro Fiscal OnLine"
		DEFINE MSDIALOG oDlg TITLE STR0039 From 3,0 to 340,417 PIXEL
			@ 5,5 GET oMemo  VAR cMsgErro MEMO SIZE 200,145 OF oDlg PIXEL
			oMemo:oFont:=oFont
		DEFINE SBUTTON  FROM 153,175 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg PIXEL
		ACTIVATE MSDIALOG oDlg CENTER
	Else
		Conout(cMsgErro)
		Help( " ", 1, "Help",, cMsgErro, 1, 0 ) 
	EndIf	
EndIf

Return lRet

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ºFuncao    ³LjR130MkBrwºAutor  ³Vendas Clientes	 º Data ³  03/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela para selecao dos cupons para geracao da nota          º±±
±±º          ³ somente para emissao para multiplos cupons                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³LOJR130                                                     º±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function LjR130MkBrw()

Local nTamF2NF      := Space(TamSx3("F2_NFCUPOM")[1])
Local cMvPar03      := If(Empty(Mv_Par03),"",Mv_Par03)	
Local cMvPar05      := If(Empty(Mv_Par05),"",Mv_Par05)
Local cCliente      := ""
Local cLoja         := ""
Local cEspecie 		:= LjRetEspec() //Retorna a Especie da NF para efetuar o filtro
Local aNotas		:= {}
Local cQuery		:= ""
Local lMarca		:= .F.
Local nX			:= 0
Local cDblClick		:= Nil
Local cAliasTmp		:= GetNextAlias()
Local cRealName		:= ""	//Nome real da tabela do banco de dados temporário
Local aStruTRB		:= {}	//Criação de Estrutura para FWTemporaryTable()
Local aAux			:= {}	//Para montagem da variável aStruTrb, essencial para definição de campos do temporário
Local cCampos		:= ""	//Campos para a Query
Local aColumns		:= {}
Local aSeek			:= {}

Private bFiltraBrw
Private cCadastro 	:= STR0040 //"Emissão de Nota Sobre Cupom"
Private aRotina		:= { {STR0042, "LJ131Proc"	, 0, 2 , , .T.}	} //Processar

cMarca := GetMark(,"SF2","F2_OK")

// Define o simbolo de concatenacao de acordo com o banco de dados
If Upper( TcGetDb() ) $ "ORACLE*POSTGRES*DB2*INFORMIX"
	cConcat := "||"
Else
	cConcat := "+"
EndIf

DbSelectArea("SF2")
SF2->(dbSetOrder(1)) 
cQrySF2     := "F2_FILIAL='"  + xFilial("SF2") + "' AND "

If !lExecAt								
	
	SF2->(DbSeek(xFilial("SF2")+cMvPar03+mv_par04))
	If mv_par09 == 1 .OR. AllTrim(SF2->F2_ESPECIE) == cEspecie					
		cLoja 		:= Padr(Mv_Par08, TamSx3("A1_LOJA")[1])
		cCliente 	:= Padr(Mv_Par07, TamSx3("A1_COD")[1])
	
		If !Empty(cCliente) .And. !Empty(cLoja)
			cQrySF2     += " F2_CLIENTE='" + cCliente + "' AND F2_LOJA = '" + cLoja + "' AND "
		Endif	
		
		cQrySF2    += "F2_EMISSAO>='" + DTOS(mv_par01) + "' AND F2_EMISSAO <= '" + DTOS(mv_par02) + "' AND "
		
		cQrySF2    += "F2_DOC>='" + cMvPar03 + "' AND F2_DOC <= '" + cMvPar05 + "' AND "
		
		cQrySF2    += "F2_SERIE>='" + mv_par04 + "' AND F2_SERIE <= '" + mv_par06 + "' AND "
		
		If mv_par09 == 1
			cQrySF2    += "F2_NFCUPOM = '" + nTamF2NF + "' AND F2_ESPECIE IN ('CF', 'SATCE', 'NFCE')"
		Else
			cQrySF2    += "F2_NFCUPOM <> '" + nTamF2NF + "' AND F2_ESPECIE ='"+cEspecie+"'"
		EndIf
	Else
		aNotas := U_LJ131NFEst()
		If Len(aNotas) > 0
			lMarca    := .T.
			cDblClick := "U_LjAllowChk()"
			
			For nX := 1 To Len(aNotas)
				cQuery  += aNotas[nX][3] + aNotas[nX][4]
				
				If nX <> Len(aNotas)
					cQuery  += "','"
				EndIf
			Next

			cQrySF2    += "F2_SERIE" + cConcat + "F2_DOC IN ('" + cQuery + "')"
			
		Else
			Return
		EndIf
	EndIf	
Else
	/*
	MV_PAR01	:= aParam[1][1] // Doc Cupom
	MV_PAR02	:= aParam[1][2] // Serie Cupom             	
	MV_PAR03	:= aParam[1][3] // Cliente
	MV_PAR04	:= aParam[1][4] // Loja
	*/
	cLoja 		:= Padr(MV_PAR04, TamSx3("A1_LOJA")[1])
	cCliente 	:= Padr(MV_PAR03, TamSx3("A1_COD")[1])
	
	If !Empty(AllTrim(cCliente)) .And. !Empty(AllTrim(cLoja))
		cQrySF2     += " F2_CLIENTE='" + cCliente + "' AND F2_LOJA = '" + cLoja + "' AND "
	Endif	

	cQrySF2    += "F2_DOC>='" + PadL(MV_PAR01,TamSx3("F2_DOC")[1],"0") + "' AND "
	
	If lIsMexico
		cQrySF2	   += "F2_NFORI = '' AND "
	EndIf
	
	cQrySF2    += "F2_SERIE='" + MV_PAR02 + "' "
EndIf

cQrySF2 += " AND D_E_L_E_T_ = ' ' "

//Montagem de estrutura para FWTemporaryTable()
aStruTRB := {}
	
aAux := TamSx3("F2_OK")
AADD(aStruTRB, {"F2_OK" 	,	aAux[3],	aAux[1],	aAux[2]}) 

aAux := TamSx3("F2_DOC")
AADD(aStruTRB, {"F2_DOC" 	,	aAux[3],	aAux[1],	aAux[2]})  
aAdd(aSeek, {STR0078		,	{ {	"", "C", aAux[1], 0, STR0078, "@!"	} } } )

aAux := TamSx3("F2_SERIE")
AADD(aStruTRB,{"F2_SERIE" 	,	aAux[3],	aAux[1],	aAux[2]})  
aAdd(aSeek, {STR0071		,	{ {	"", "C", aAux[1], 0, STR0071, "@!"	} } } )

aAux := TamSx3("F2_CLIENTE")
AADD(aStruTRB,{"F2_CLIENTE" ,	aAux[3],	aAux[1],	aAux[2]})  

aAux := TamSx3("F2_LOJA")
AADD(aStruTRB,{"F2_LOJA" 	,	aAux[3],	aAux[1],	aAux[2]})  

aAux := TamSx3("F2_EMISSAO")
AADD(aStruTRB,{"F2_EMISSAO"	,	aAux[3],	aAux[1],	aAux[2]})  

aAux := TamSx3("F2_NFCUPOM")
AADD(aStruTRB,{"F2_NFCUPOM"	,	aAux[3],	aAux[1],	aAux[2]})  

aAux := TamSx3("F2_ESPECIE")
AADD(aStruTRB,{"F2_ESPECIE"	,	aAux[3],	aAux[1],	aAux[2]})  

aAux := TamSx3("F2_NFORI")
AADD(aStruTRB,{"F2_NFORI" 	,	aAux[3],	aAux[1],	aAux[2]})  

aAux := TamSx3("F2_EST")
AADD(aStruTRB,{"F2_EST" 	,	aAux[3],	aAux[1],	aAux[2]})  

aAux := TamSx3("F2_COND")
AADD(aStruTRB,{"F2_COND" 	,	aAux[3],	aAux[1],	aAux[2]})  

aAux := TamSx3("F2_VALBRUT")
AADD(aStruTRB,{"F2_VALBRUT"	,	aAux[3],	aAux[1],	aAux[2]})  

//Cria a tabela temporária com base na estrutura
oTempTable := LjCrTmpTbl(cAliasTmp, aStruTRB,{"F2_DOC","F2_SERIE"})
cRealName  := oTempTable:GetRealName()
cRealName  := StrTran(cRealName,"dbo.","")			//Para funcionar a query, preciso omitir o 'dbo.' para utilizar em TCSqlExec().
cAliasTmp  := oTempTable:GetAlias()

cCampos := "F2_OK, F2_DOC, F2_SERIE, F2_CLIENTE, F2_LOJA, F2_EMISSAO, F2_NFCUPOM, F2_ESPECIE, F2_NFORI, F2_EST, F2_COND, F2_VALBRUT"

//Montagem da Query via TcSqlExec
cQuery := " SELECT " + cCampos + " FROM " + RetSqlName("SF2") + " SF2 "
cQuery += " WHERE " + cQrySF2
cQuery += " ORDER BY F2_FILIAL, F2_CLIENTE, F2_LOJA " 


nStatus := TCSqlExec( "INSERT INTO " + cRealName + " ( " +cCampos+ " ) " + cQuery )

If (nStatus < 0)
	LjGrvLog("NOTA_SOBRE_CUPOM","Erro SQL ao montar query: ",TCSQLError())
EndIf

DbSelectArea(cAliasTmp)
(cAliasTmp)->(DbGotop())
If (cAliasTmp)->(BOF()) .And. (cAliasTmp)->(EOF())
	Ljr130Msg(STR0043,NIL,1)		//"Não existem registros para serem apresentados com esses parâmetros."		
Else
	For nX := 1 To Len(aStruTRB)
		If	aStruTRB[nX][1] $ "F2_DOC|F2_SERIE|F2_CLIENTE|F2_LOJA|F2_EMISSAO|F2_NFCUPOM|F2_ESPECIE|F2_NFORI|F2_EST|F2_COND|F2_VALBRUT"
			AAdd(aColumns,FWBrwColumn():New())
			aColumns[Len(aColumns)]:SetData( &("{||"+aStruTRB[nX][1]+"}") )
			aColumns[Len(aColumns)]:SetTitle(RetTitle(aStruTRB[nX][1])) 
			aColumns[Len(aColumns)]:SetSize(aStruTRB[nX][3]) 
			aColumns[Len(aColumns)]:SetDecimal(aStruTRB[nX][4])
			aColumns[Len(aColumns)]:SetPicture(PesqPict("SF2",aStruTRB[nX][1])) 
		EndIf 	
	Next nX

	oMark:= FWMarkBrowse():New()		
	oMark:SetAlias(cAliasTmp)
	oMark:SetDescription(cCadastro)
	oMark:SetFieldMark('F2_OK')
	oMark:SetMark(cMarca,cAliasTmp,"F2_OK")
	oMark:SetColumns(aColumns)
	oMark:SetTemporary(.T.)
	oMark:oBrowse:SetSeek(.T.,aSeek)
	oMark:DisableDetails()
	oMark:bAllMark := { || U_LjR130All(cAliasTmp, oMark) }
	oMark:Activate()
EndIf

//Apaga os arquivos temporários
If (ValType(oTempTable) == "O")
	oTempTable:Delete()
	FreeObj(oTempTable)
	oTempTable := Nil
EndIf	

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³LJ131Proc  ºAutor  ³Vendas Clientes	 º Data ³  03/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Inclui perguntas no SX1 caso nao existe                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³LOJR130                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function LJ131Proc(cAliasTmp,nRecno,nOpcX)

Local cLjExec 	:= IIf(lExecAt,STR0045,IIF(mv_par09 == 1, STR0044, STR0045))//"Gerar Nota Sobre Cupom", "Estornar Nota Sobre Cupom"
Local aNfsSF2 	:= {}
Local cCondicao	:= ""
Local cEspecie 	:= AllTrim(LjRetEspec()) //Retorna a Especie da NF para efetuar o filtro
Local lLocxL130  := ExistBlock('LOCXL130')

//"Deseja realmente executar: "
If Ljr130Msg(STR0046 + cLjExec + "?" , NIL , 3)

	If !lExecAt
		If mv_par09 == 1
			cCondicao := "!Empty(SF2->F2_OK) .AND. Empty(SF2->F2_NFCUPOM) .And. Alltrim(SF2->F2_ESPECIE) $ 'CF|SATCE|NFCE'"
		Else
			cCondicao := "!Empty(SF2->F2_OK) .AND. !Empty(SF2->F2_NFCUPOM) .And. Alltrim(SF2->F2_ESPECIE) =='"+cEspecie+"'"
		EndIf
	Else
		cCondicao := "!Empty(SF2->F2_OK) .AND. Empty(SF2->F2_NFCUPOM) .And. Alltrim(SF2->F2_ESPECIE) $ 'CF|SATCE|NFCE'"
	EndIf
	
	If lLocxL130 .And. cPaisLoc == "MEX"
		cCondicao := ExecBlock("LOCXL130",.F.,.F.,{cCondicao})
	EndIf
	
	DbSelectArea("SF2")	
	SF2->(dbSetOrder(1))		//F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO                                                                                                  
	DbSelectArea(cAliasTmp)	
	(cAliasTmp)->(DbGotop())
	
	While !(cAliasTmp)->(EOF())

	    If Empty((cAliasTmp)->F2_OK) .OR. Empty((cAliasTmp)->F2_DOC + (cAliasTmp)->F2_SERIE)
	       (cAliasTmp)->(DbSkip())
	       Loop
	    Endif
	    
	    //Posicionar, preparando para a gravação
	    If SF2->(DbSeek(xFilial("SF2")+(cAliasTmp)->F2_DOC + (cAliasTmp)->F2_SERIE + (cAliasTmp)->F2_CLIENTE + (cAliasTmp)->F2_LOJA ))	

			If lLegislacao .AND. lIsMexico
				nQtdItens := 0
				DBSelectarea("SD2")
				SD2->(DBSetOrder(3))
				If SD2->(DBSeek(xFilial("SF2") + SF2->F2_DOC + SF2->F2_SERIE + SF2->F2_CLIENTE + SF2->F2_LOJA))
					While !SD2->(EOF()) .AND. (xFilial("SF2") + SD2->D2_DOC + SD2->D2_SERIE + SD2->D2_CLIENTE + SD2->D2_LOJA == ;
						xFilial("SF2") + SF2->F2_DOC + SF2->F2_SERIE + SF2->F2_CLIENTE + SF2->F2_LOJA)
						nQtdItens ++
						SD2->(DBSkip())
					End
				EndIf
				Aadd(aNfsSF2,{SF2->F2_DOC,SF2->F2_SERIE, SF2->F2_CLIENTE, SF2->F2_LOJA,SF2->F2_EST,SF2->(Recno()),	;
				nQtdItens , SF2->F2_NFORI , IIf(!Empty(SF2->F2_APROFOL), .T. , .F. ) })	   
			Else
				Aadd(aNfsSF2,{SF2->F2_DOC,SF2->F2_SERIE, SF2->F2_CLIENTE, SF2->F2_LOJA,SF2->F2_EST,SF2->(Recno())})	   
			EndIf
		Else
			LjGrvLog("NOTA_SOBRE_CUPOM","U_Lj131Proc(): Registro em SF2 não encontrado!",;
					xFilial("SF2")+(cAliasTmp)->F2_DOC + (cAliasTmp)->F2_SERIE + (cAliasTmp)->F2_CLIENTE + (cAliasTmp)->F2_LOJA)
		EndIf
		(cAliasTmp)->(DbSkip())
		Loop
	End

	dbSelectArea("SF2")

	If Len(aNfsSF2) > 0
		If mv_par09 == 1
			If lExecAt
				U_LjR130VerInf(aNfsSF2)
			Else	
				Processa( {|lEnd| U_LjR130VerInf(aNfsSF2) } ,STR0047,,.T. ) //'Aguarde restaurando'
			EndIf	
   		Else
			If lExecAt
				U_LjR130Estorn(aNfsSF2)
			Else	
				Processa( {|lEnd| U_LjR130Estorn(aNfsSF2) } ,STR0047,,.T. ) //'Aguarde restaurando'	   		
			EndIf	
		EndIf
		// Altera valor para confirmado processamento 
		lConfProc := .T.
    Else
    	//Nenhum registro selecionado
    	Ljr130Msg(STR0048,NIL,1)
    EndIf

	CloseBrowse(.T.)

EndIf

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³LJ131Proc  ºAutor  ³Vendas Clientes	 º Data ³  03/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Inclui perguntas no SX1 caso nao existe                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³LOJR130                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function LjR130Estorn(aNfsSF2)

Local nX 				:= 0
Local lLj7072			:= ExistBlock("LJ7072")								//Ponto de entrada LJ7072 que permite realizar tratamentos antes do estorno.
Local lIntegDef			:= lIntDefPro 										//Integracao Mensagem Unica
Local lIntegHtl			:= lIntegDef .And. SuperGetMv("MV_INTHTL",, .F.) 	//Integracao Hotelaria
Local cDocInt			:= "" 												//Chave interna para excluir registro no XXF - Integracao Hotelaria
Local aEstTitCR 		:= {}
Local cCliEst 			:= ""
Local cLojaEst 			:= ""
Local cNumDocEst 		:= "" 
Local cSerieEst 		:= ""
Local cParcEst 			:= "A"
Local cTipoEst 			:= "FA"
Local cChaveEst 		:= ""
Local aErroAuto 		:= {}
Local cErroAuto 		:= ""
Local nI 				:= 0
Local lContinua			:= .T.

Private lMsErroAuto 	:= .F.
Private lAutoErrNoFile	:= .T.

If lLj7072	// Permite realizar tratamentos antes do estorno.
	ExecBlock( "LJ7072", .F., .F., { aNfsSF2 } )
EndIf

For nX := 1 To Len(aNfsSF2)

	DbSelectArea("SF2")
	SF2->(DbSetOrder(1)) //F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
	If SF2->(DbSeek(xFilial("SF2") + aNfsSF2[nX][1] + aNfsSF2[nX][2]))
		//Valida se pode cancelar a Nota Sobre Cupom
		lContinua := Lj7SpedExc(.T.)

		If !lContinua
			Loop		
		EndIf
	EndIf
	
	DbSelectArea("MDL")
	MDL->(DbSetOrder(1))
	If MDL->(DbSeek(xFilial("MDL") + aNfsSF2[nX][1] + aNfsSF2[nX][2]))
		While !MDL->(EOF()) .AND. (MDL->MDL_FILIAL + MDL->MDL_NFCUP + MDL->MDL_SERIE) == (xFilial("MDL") + aNfsSF2[nX][1] + aNfsSF2[nX][2])
			
			DbSelectArea("SF2")
			SF2->(DbSetOrder(1))
			If SF2->(DbSeek(xFilial("SF2") + Padr(MDL->MDL_CUPOM,TamSx3("F2_DOC")[1]) + Padr(MDL->MDL_SERCUP,TamSx3("F2_SERIE")[1])))

				Reclock("SF2",.F.)
				Replace SF2->F2_NFCUPOM With ""
				Replace SF2->F2_OK 		With ""
				SF2->(MsUnLock())

			EndIf

			DbSelectArea("SD2")
			SD2->(DbSetOrder(3))
			If SD2->(DbSeek(xFilial("SD2") + Padr(MDL->MDL_CUPOM,TamSx3("D2_DOC")[1]) + Padr(MDL->MDL_SERCUP,TamSx3("D2_SERIE")[1])))
				While !SD2->(EOF()) .AND. ;
				(SD2->D2_FILIAL + SD2->D2_DOC + SD2->D2_SERIE) == (xFilial("SD2") + Padr(MDL->MDL_CUPOM,TamSx3("D2_DOC")[1]) + Padr(MDL->MDL_SERCUP,TamSx3("D2_SERIE")[1]))
					Reclock("SD2",.F.)
					Replace SD2->D2_NFCUP With ""
					SD2->(MsUnLock())
					SD2->(DBSkip())
				End
			EndIf

			Reclock("MDL",.F.)
			MDL->(dbDelete())
			MDL->(MsUnLock())

			MDL->(DbSkip())
			Loop
		End

		DbSelectArea("SF3")
		SF3->(DbSetOrder(6))
		If SF3->(DbSeek(xFilial("SF3") + aNfsSF2[nX][1] + aNfsSF2[nX][2]))
			While !SF3->(EOF()) .AND. (SF3->F3_FILIAL + SF3->F3_NFISCAL + SF3->F3_SERIE) == (xFilial("SF3") + aNfsSF2[nX][1] + aNfsSF2[nX][2])

				Reclock("SF3",.F.)
				Replace SF3->F3_DTCANC With dDataBase
				Replace SF3->F3_OBSERV With "NF CANCELADA"
				SF3->(MsUnLock())
				SF3->(DbSkip())
				Loop
	        End
		EndIf

		DbSelectArea("SFT")
		SFT->(DbSetOrder(1))
		If SFT->(DbSeek(xFilial("SFT") + "S" + aNfsSF2[nX][2] + aNfsSF2[nX][1]))
			While !SFT->(EOF()) .AND. 	(	SFT->FT_FILIAL + SFT->FT_TIPOMOV + SFT->FT_NFISCAL + SFT->FT_SERIE) == ;
								(	xFilial("SFT") + "S" + aNfsSF2[nX][1] + aNfsSF2[nX][2]		)

				Reclock("SFT",.F.)
				Replace SFT->FT_DTCANC With dDataBase
				Replace SFT->FT_OBSERV With "NF CANCELADA"
				SFT->(MsUnLock())

				SFT->(DbSkip())
				Loop
	        End
		EndIf
            
		DbSelectArea("SD2")
		SD2->(DbSetOrder(3))
		If SD2->(DbSeek(xFilial("SD2") + aNfsSF2[nX][1] + aNfsSF2[nX][2]))
			While !SD2->(EOF()) .AND. ((SD2->D2_FILIAL + SD2->D2_DOC + SD2->D2_SERIE) == (xFilial("SD2") + aNfsSF2[nX][1] + aNfsSF2[nX][2]))
				
				Reclock("SD2",.F.)
				SD2->(dbDelete())
				SD2->(MsUnLock())

				SD2->(DbSkip())
				Loop
			End
		EndIf

		DbSelectArea("SF2")
		SF2->(DbSetOrder(1))
		If SF2->(DbSeek(xFilial("SF2") + aNfsSF2[nX][1] + aNfsSF2[nX][2]))
			//Integracao armazena InternalId para exclusao
			If lIntegDef 				
				cDocInt := IntNFCupExt(/*Empresa*/, /*Filial*/, SF2->F2_DOC, SF2->F2_SERIE, SF2->F2_CLIENTE, SF2->F2_LOJA, /*Versão*/)[2]				
			EndIf
			
			Reclock("SF2",.F.)
			SF2->(dbDelete())
			SF2->(MsUnLock())
			
			If lIntegDef						
				//Se for hotelaria, verifica se é danfe para órgão público e, se for, deleta o título criado para controle das retenções de PIS/COFINS				
				If lIntegHtl
					cCliEst  := PadR(cCliEst, TamSX3("E1_CLIENTE")[1])
					cLojaEst := PadR(cLojaEst, TamSX3("E1_LOJA")[1])				
				
					If LjVerfCliEP( cCliEst, cLojaEst )					
						cSerieEst := PadR(cSerieEst, TamSX3("E1_PREFIXO")[1])
						cNumDocEst := PadR(cNumDocEst, TamSX3("E1_NUM")[1])					
						cParcEst := PadR(cParcEst, TamSX3("E1_PARCELA")[1])
						cTipoEst := PadR(cTipoEst, TamSX3("E1_TIPO")[1])
						
						aEstTitCR := {}
						aAdd( aEstTitCR, {"E1_CLIENTE", cCliEst, Nil} )
						aAdd( aEstTitCR, {"E1_LOJA", cLojaEst, Nil} )
						aAdd( aEstTitCR, {"E1_PREFIXO", cSerieEst, Nil} )
						aAdd( aEstTitCR, {"E1_NUM", cNumDocEst, Nil} )
						aAdd( aEstTitCR, {"E1_PARCELA", cParcEst, Nil} )
						aAdd( aEstTitCR, {"E1_TIPO", cTipoEst, Nil} )
										
						MSExecAuto( {|x, y| FINA040(x, y)}, aEstTitCR, 5 )
					
						If lMsErroAuto
							aErroAuto := GetAutoGRLog()
						
							cErroAuto := ""
							For nI := 1 To Len(aErroAuto)
								cErroAuto += aErroAuto[nI] + Chr(10)
							Next nI
							cChaveEst := cCliEst + cLojaEst + cSerieEst + cNumDocEst + cParcEst + cTipoEst
							Help( ,, "EXCDANFETITCR",, STR0086 + Chr(10) + cErroAuto, 1, 0,,,,,, {STR0087 + cChaveEst} ) //"Não foi possível excluir o título a receber gerado na DANFE para empresa pública. Erro:", "Verifique o título a receber: " 
							
							DisarmTransaction()
							MsUnLockAll()
							Exit
						EndIf
					EndIf
				EndIf				
			EndIf
		EndIf
	EndIf
Next nX

Return    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Lj130ChkNf ºAutor  ³Vendas e CRM       º Data ³  19/08/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Verifica se ja existe uma Nf sobre cupom , caso exista     º±±
±±º          ³ pergunt se deve excluir                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³LOJR130                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
//--------------------------------------------------------
/*/{Protheus.doc}Lj130ChkNf
Verifica se ja existe uma Nf sobre cupom , caso exista 
pergunta se deve excluir

@author  	Varejo
@version 	P11.8
@since   	19/08/09
@return  	lRet (logico)
@obs     
@sample
/*/
//--------------------------------------------------------
Static Function Lj130ChkNf( cDoc , cSerie , cCliente , cLoja)

Local lRet			:= .F.
Local cStrNfCup	:= ""
Local lDelet		:= .F.
Local cCliSF2		:= ""
Local cLjSF2		:= ""
Local nTamF2Doc	:= TamSx3("F2_DOC")[1]
Local nTamF2Ser	:= TamSx3("F2_SERIE")[1]
Local lContinua	:= .T.
Local cDocStrNf	:= ""
Local cSerStrNf	:= ""
Local cNextDoc	:= ""
Local cEspecie	:= ""								// Especie da nota fiscal sobre cupom.
Local nQtdHoras	:= 0								// Quantidade de horas em relacao a hora atual.
Local dDtDigit	:= dDataBase						// Data da emissao da nota.
Local nMvSpedExc	:= SuperGetMV("MV_SPEDEXC",,72)	// Indica a quantidade de horas que a NF ainda pode ser cancelada.
Local cFilSD2		:= xFilial("SD2")				// Para nao chamar diversas vezes e em loops
Local lCancNFSCp	:= .T.							// Indica se a NF Sobre Cupom foi Cancelada / Inutilizada
Local oLOJCNFCE		:= NIL							// Objeto da Classe LOJCNFCE
Local oPergLJR13	:= FWSX1Util():New() 			// Dados do pergunte utilizado
Local aPergunte		:= {}							// Perguntas

DEFAULT cDoc		:= ""
DEFAULT cSerie	:= ""
DEFAULT cCliente	:= ""
DEFAULT cLoja		:= ""

oPergLJR13:AddGroup( "LJR130" )
oPergLJR13:SearchGroup()
aPergunte := oPergLJR13:GetGroup( "LJR130" )

DbSelectArea("SF2")
SF2->(DbSetOrder(1)) //"F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO"
If SF2->(DbSeek( xFilial("SF2") + cDoc + cSerie ))
	If !Empty(SF2->F2_NFCUPOM)
		cStrNfCup := Padr(SubStr(SF2->F2_NFCUPOM,nTamF2Ser+1,nTamF2Doc),nTamF2Doc) + SubStr(SF2->F2_NFCUPOM,1,nTamF2Ser)

		//"Ja existe uma Nota Fiscal ("xxx") gerada para o Cupom "xxx" - Deseja estornar/excluir esta NF sobre Cupom?" , Atencao
		If Ljr130Msg(STR0009 + cStrNfCup + STR0010 + cDoc + CHR(10)+CHR(13) + STR0050 , STR0018,3)

			//Validacao do F2_NEXTDOC antes de excluir            
			cDocStrNf := Substr(cStrNfCup, 1			,nTamF2Doc)
			cSerStrNf := Substr(cStrNfCup, nTamF2Doc+1	,nTamF2Ser)
            
			While lContinua
				SF2->(DbSetOrder(1))//"F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO"
				If SF2->( DbSeek(xFilial("SF2") + cDocStrNf + cSerStrNf) )
					
					cEspecie := SF2->F2_ESPECIE 
					cCliSF2  := SF2->F2_CLIENTE
					cLjSF2   := SF2->F2_LOJA
 	
					//Verifica a quantidade de horas indicada no parametro MV_SPEDEXC e valida se a NF pode ser excluida
	  				If SF2->(FieldPos("F2_DAUTNFE")) > 0 .And. !Empty(SF2->F2_DAUTNFE)
		  				dDtDigit := SF2->F2_DAUTNFE
	  				ElseIf SF2->(FieldPos('F2_DTDIGIT')) > 0 .AND. !Empty(SF2->F2_DTDIGIT)
	  					dDtDigit := SF2->F2_DTDIGIT
	  				Else
	  					dDtDigit := SF2->F2_EMISSAO
	  		   		EndIf 
					
					nQtdHoras := SubtHoras( dDtDigit, iIf( SF2->(FieldPos("F2_HAUTNFE")) > 0 .And. !Empty(SF2->F2_HAUTNFE),SF2->F2_HAUTNFE,SF2->F2_HORA ), dDataBase, SubStr(Time(),1,2)+":"+SubStr(Time(),4,2) )
					
					If "SPED" $ cEspecie .AND. (AllTrim(SF2->F2_FIMP) $ "TS") //Verifica apenas a especie como SPED e notas que foram transmitidas ou impresso o DANFE
						If nQtdHoras > nMvSpedExc
							Ljr130Msg(STR0058+Alltrim(Str(nMvSpedExc))+STR0059,NIL,4)//"Nao foi possivel excluir a nota, pois o prazo definido para cancelamento foi de "#" hora(s)."
							lRet := .T.
							Return lRet
		    			EndIf
		    		EndIf

					// Cancelamento sincrono - On-Line
					If cPerg == "LJR130" .AND. Len(aPergunte[02]) > 4 .AND. AllTrim(cPaisLoc) == "BRA" .AND.;
						MV_PAR05 == 1 .AND. "SPED" $ cEspecie
					
						oLOJCNFCE := LOJCNFCE():NEW()
						oLOJCNFCE:LjCancInut(SF2->F2_SERIE + SF2->F2_DOC, "55" ) // modelo 55 NF-e
						
						If oLOJCNFCE:aResultMetodo[1]				
							LjGrvLog(SF2->F2_SERIE + SF2->F2_DOC,"Inutilização / Cancelamento da Nota Sobre Cupom Realizado DOC: " + SF2->F2_DOC + " Serie: " + SF2->F2_SERIE )
						Else
							LjGrvLog(SF2->F2_SERIE + SF2->F2_DOC,"Não foi possivel Inutilizar / Cancelar a Nota Sobre Cupom.")
							LjGrvLog(SF2->F2_SERIE + SF2->F2_DOC,"Motivo: " + oLOJCNFCE:aResultTSS[3])
							Help(,1,STR0104,,; // "Cancelamento NF sobre Cupom"
									STR0105 + CHR(10)+CHR(13) + ; // "Não foi possivel Inutilizar / Cancelar a Nota Sobre Cupom."
									STR0106 + AllTrim(oLOJCNFCE:aResultTSS[3]),1,0) // "Motivo: "
									
							lCancNFSCp	:= .F.
							lContinua	:= .F.	
						EndIf
					EndIf

					If lCancNFSCp

						cNextDoc := SF2->F2_NEXTDOC
						Reclock("SF2",.F.)
						SF2->(dbDelete())
						SF2->(MsUnLock())
						lDelet := .T.

						//Exclusao dos SD2 da NF sobre cupom.
						DbSelectArea("SD2")
						SD2->(DbSetOrder(3)) //"D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM"
						If SD2->(DbSeek(cFilSD2 + cDocStrNf + cSerStrNf))
							While !SD2->(EOF()) .AND. (SD2->D2_FILIAL + SD2->D2_DOC + SD2->D2_SERIE) == (cFilSD2 + cDocStrNf + cSerStrNf)
								Reclock("SD2",.F.)
								SD2->(dbDelete())
								SD2->(MsUnLock())
								SD2->(DbSkip())
								Loop
							End
						EndIf           

						//Limpa os campos do Cupom fiscal
						If SD2->(DbSeek(cFilSD2 + cDoc + cSerie ))
							While !SD2->(EOF()) .AND. (SD2->D2_FILIAL + SD2->D2_DOC + SD2->D2_SERIE) == (cFilSD2 + cDoc + cSerie)
								If Reclock("SD2",.F.)
									Replace SD2->D2_NFCUP With ""
									SD2->(MsUnLock())
								EndIf
								SD2->(DBSkip())
							End
						EndIf

						//Limpa os campos do Cupom Fiscal
						SF2->(DbSetOrder(1))//"F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO"
						If SF2->(DbSeek(xFilial("SF2") + cDoc + cSerie ))
							Reclock("SF2",.F.)
							Replace SF2->F2_NFCUPOM With ""
							Replace SF2->F2_OK 		With ""
							SF2->(MsUnLock())
						EndIf
															
						//Exclusao dos SF3 da NF sobre cupom.
						DbSelectArea("SF3")
						SF3->(DbSetOrder(5))//F3_FILIAL+F3_SERIE+F3_NFISCAL+F3_CLIEFOR+F3_LOJA                           
						If SF3->(DbSeek(xFilial("SF3") + cSerStrNf + cDocStrNf + cCliSF2 + cLjSF2))
							While !SF2->(EOF()) .AND. (SF3->F3_FILIAL + SF3->F3_SERIE + SF3->F3_NFISCAL + SF3->F3_CLIEFOR + SF3->F3_LOJA) == (xFilial("SF3") + cSerStrNf + cDocStrNf + cCliSF2 + cLjSF2)
								Reclock("SF3",.F.)
								Replace SF3->F3_DTCANC With dDataBase
								Replace SF3->F3_OBSERV With "NF CANCELADA"
								SF3->(MsUnLock())
								SF3->(DbSkip())
								Loop
							End
						EndIf

						//Exclusao dos SFT da NF sobre cupom.
						DbSelectArea("SFT")
						SFT->(DbSetOrder(4)) //FT_FILIAL+FT_TIPOMOV+FT_CLIEFOR+FT_LOJA+FT_SERIE+FT_NFISCAL+FT_CFOP
						If SFT->(DbSeek(xFilial("SFT") + "S" + cCliSF2 + cLjSF2 + cSerStrNf + cDocStrNf ))
							While !SFT->(EOF()) .AND. 	(SFT->FT_FILIAL + SFT->FT_TIPOMOV + SFT->FT_CLIEFOR + SFT->FT_LOJA + SFT->FT_SERIE + SFT->FT_NFISCAL) == (xFilial("SFT") + "S" + cCliSF2 + cLjSF2 + cSerStrNf + cDocStrNf)
								Reclock("SFT",.F.)
								Replace SFT->FT_DTCANC With dDataBase
								Replace SFT->FT_OBSERV With "NF CANCELADA"
								SFT->(MsUnLock())
								SFT->(DbSkip())
								Loop
							End
						EndIf							
								
						cDocStrNf := cNextDoc				

					EndIf

					If Empty(cDocStrNf)
						lcontinua := .F.	
					EndIf
				EndIf
			End
				                                  
			If lDelet
				If lExecAt
					Conout(STR0052)
				Else
					Aviso(STR0051,STR0052,{STR0014})
					//"Exclusão concluída" , "Nota Fiscal sobre Cupom excluída com Sucesso!!!" , OK
				EndIf	
			EndIf
			
		EndIf
		lRet := .T.
	Endif
Endif

Return( lRet )
          
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Lj130F2OK	 ºAutor  ³Vendas Clientes  	 º Data ³  14/09/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Limpa F2_OK                    							  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ LOJR130                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Lj130F2OK(aSeekNF)
Local nX		:= 0			// Contador de For
Local aAreaAtu	:= GetArea() 	// armazena a area local

DbSelectArea("SF2")
SF2->( DbSetOrder(1) )	//F2_FILIAL + F2_DOC + F2_SERIE + F2_CLIENTE + F2_LOJA

For nX := 1 To Len(aSeekNF)   
	If SF2->( DbSeek(xFilial("SF2") + aSeekNF[nX][1] + aSeekNF[nX][2]) )
		Reclock("SF2",.F.)
	 		Replace SF2->F2_OK With ""
		SF2->(MsUnlock())
		SF2->(FKCommit()) 
	EndIf
Next nX                                  

RestArea(aAreaAtu)  

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Ljr130Msg	 ºAutor  ³Vendas Clientes  	 º Data ³  14/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Mostra a mensagem na tela com tratamento de execauto       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ LOJR130                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Ljr130Msg(cMsgShow,cMsgCab, nTipo)

Local lRet := .T.
Local lIntegDef := lExecAt .And. lIntDefPro //Integracao Mensagem Unica

DEFAULT cMsgShow := ""
DEFAULT nTipo	 := 1
DEFAULT cMsgCab	 := ""

If lExecAt 
	Conout(cMsgShow)
	
	If lIntegDef
    	Help( " ", 1, "Help",, cMsgShow, 1, 0 ) 
    	lMsErroAuto := .T.
    	lRet := .F.
    EndIf
Else
	Do Case
		Case nTipo == 1 
			MsgStop(cMsgShow,cMsgCab)		
		Case nTipo == 2
			MsgInfo(cMsgShow,cMsgCab)						
		Case nTipo == 3
			lRet := MsgYesNo(cMsgShow,cMsgCab)	
	OtherWise
		MsgAlert(cMsgShow,cMsgCab)						
	EndCase		
EndIf

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LjRetEspec ºAutor  ³ Varejo          	 º Data ³ 05/05/2014  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Retorna a Especie a ser utilizada de acordo com a configu- º±±
±±º          ³ racao dos parametros MV_LOJANF e MV_ESPECIE.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ LOJR130                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function LjRetEspec()
Local cEspecie 	:= "NF" // Especie da NF
Local cTiposDoc	:= "" 	// Tipos de documentos fiscais utilizados na emissao de notas fiscais
Local nCount 	:= 0
Local nPosSign	:= 0

If cPaisLoc == "BRA"
	cTiposDoc := AllTrim( SuperGetMV( 'MV_ESPECIE' ) ) // Tipos de documentos fiscais utilizados na emissao de notas fiscais
	DbSelectArea("SX5")
	SX5->( DbSetOrder(1) )
	If cTiposDoc <> NIL
		cTiposDoc := StrTran( cTiposDoc, ";", CHR(13)+CHR(10))
		
		For nCount := 1 TO MLCount( cTiposDoc )
			cEspecie := ALLTRIM( StrTran( MemoLine( cTiposDoc,, nCount ), CHR(13), CHR(10) ) )
			nPosSign := Rat( "=", cEspecie)
			
			If nPosSign > 0 .AND. ALLTRIM( cSerie ) == ALLTRIM( SUBSTR( cEspecie, 1, nPosSign - 1 ) )
				If SX5->( DbSeek( xFilial("SX5") + "42" + SUBSTR(cEspecie, nPosSign + 1) ) )
					cEspecie := SUBSTR( cEspecie, nPosSign + 1 )
				Else
					cEspecie := SPACE(5)
				Endif
				Exit
			Else
				cEspecie := SPACE(5)
			Endif
		Next nCount
		
	Endif
Endif

Return cEspecie


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LjImpScriptºAutor  ³ Varejo          	 º Data ³ 07/05/2014  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Efetua a impressão do Script de Impressão da Nota          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ LOJR130                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function LjImpScript(cNumNota,cSerie,aRegSF2,wnrel)
Local cScript  		:= SuperGetMV("MV_SCRNFCP")									// Parametro que indica o Arquivo de Script de impressao de NF para Cupom Fiscal
Local cMV_LJIMPFA	:= SuperGetMV("MV_LJIMPFA",.F.,"1")							//Verifica se pergunta se deseja imprimir a nota
Local lImprime		:= .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chama o script de impressão da nota depois da gravação        ³
//³de todas as informacoes da NF                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SF2")
SF2->(DbSetOrder(1))
SF2->(DbGoTo(aRegSF2[1]))

If lIsMexico
	If cMV_LJIMPFA == "1"
		lImprime := MsgYesNo(STR0060) //"Deseja realizar a impressão da fatura de venda?"
	ElseIf cMV_LJIMPFA == "2"
	    lImprime := .T.
	Else
	    lImprime := .F.
	EndIf
EndIf

If lImprime
	If lRelMacroMex
	    cScript := SubStr(cScript,At("&",cScript) + 1,Len(cScript))
	    
	    If At("(",cScript) > 0
		    cScript := SubStr(cScript,At("(",cScript) + 1,Len(cScript)) //Pega somente o conteudo entre o parenteses
		EndIf                                                                                                               
		
		If At(")",cScript) > 0
			cScript := SubStr(cScript,1,At(")",cScript)-1) //Pega somente o conteudo entre o parenteses
		EndIf
		
		//aParam[1] =
		// [1] Doc Cupom
		// [2] Serie Cupom                                                         
		// [3] aRegSF2
		ExecBlock(cScript, .F., .F.,{cNumNota,cSerie,aRegSF2})	
	Else	
		ExecBlock(cScript, .F., .F.,{cNumNota,cSerie,aRegSF2})
	EndIf
EndIf

If !lExecAt .OR. !lRelMacroMex
	Set Device To Screen
	
	DbSelectArea("SL1")
	SL1->( DbSetOrder(1) )
	Set Filter To
	
	If aReturn[5] == 1  
	   	Set Printer To
		DbCommitAll()
		OurSpool(wnrel)
	Endif
	
	MS_FLUSH()
Else
	DbCommitAll()
EndIf

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³LJ131ProcM ºAutor  ³Vendas Clientes	 º Data ³  28/01/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Processamento nota sobre multiplos cupons via execauto     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³LOJR130                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function LJ131ProcM(aNFAuto)

Local aNfsSF2 	:= {}
Local cEspecie 	:= AllTrim(LjRetEspec()) //Retorna a Especie da NF para efetuar o filtro 
Local nX		:= 0 
Local lRet      := .T.

Default aNFAuto := {}

If Len(aNFAuto) > 0

	For nX := 1 To Len(aNFAuto)   
		DbSelectArea("SF2")
		DbSetOrder(1)
		If SF2->(DbSeek( xFilial("SF2") + PadR(aNFAuto[nX][1] ,TamSx3("F2_DOC")[1]) + aNFAuto[nX][2]))       
			If !lEstorno
				If Empty(SF2->F2_NFCUPOM) .AND. AllTrim(SF2->F2_ESPECIE) $ "CF|NFCE|SATCE" 
					Aadd(aNfsSF2,{SF2->F2_DOC,SF2->F2_SERIE, SF2->F2_CLIENTE, SF2->F2_LOJA,SF2->F2_EST,SF2->(Recno())})	   		
			    EndIf
		    Else
			    If !Empty(SF2->F2_NFCUPOM) .AND. Alltrim(SF2->F2_ESPECIE) == cEspecie
					Aadd(aNfsSF2,{SF2->F2_DOC,SF2->F2_SERIE, SF2->F2_CLIENTE, SF2->F2_LOJA,SF2->F2_EST,SF2->(Recno())})	   		    
				EndIf
		    EndIf		     
		EndIf
	
	Next Nx		
	
	If Len(aNfsSF2) > 0
		If !lEstorno
			If lExecAt
				lRet := U_LjR130VerInf(aNfsSF2)
			Else	
				Processa( {|lEnd| U_LjR130VerInf(aNfsSF2) } ,STR0047,,.T. ) //'Aguarde restaurando'
			EndIf	
   		Else
			If lExecAt
				U_LjR130Estorn(aNfsSF2)
			Else	
				Processa( {|lEnd| U_LjR130Estorn(aNfsSF2) } ,STR0047,,.T. ) //'Aguarde restaurando'	   		
			EndIf	
		EndIf
		// Altera valor para confirmado processamento 
		lConfProc := .T.
    Else
    	//Nenhum registro selecionado
    	Ljr130Msg("LOJR130 - LJ131ProcM: " + STR0048,NIL,1)
    EndIf
	
EndIf

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³LJ131NFEst ºAutor  ³ Varejo            º Data ³  16/06/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Tela para selecionar as notas a serem estornadas            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³LOJR130                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function LJ131NFEst()

Local oOk      := LoadBitmap(GetResources(), "LBOK")		// Desenho do Checked
Local oNo      := LoadBitmap(GetResources(), "LBNO")		// Desenho do Not Checked
Local cMvPar03 := If(Empty(Mv_Par03),"",Mv_Par03)	
Local cMvPar05 := If(Empty(Mv_Par05),"",Mv_Par05)
Local cWhere   := "%%"										// Expressão
Local oListBox 
Local aDados   := {}
Local aRet     := {}

LjGrvLog("NOTA_SOBRE_CUPOM","Seleção de notas para estorno","ID_INICIO")

cQryTemp := GetNextAlias()

cWhere := "%F2_CLIENTE ='" + Mv_Par07 + "' "
cWhere += " AND F2_LOJA ='" + Mv_Par08 + "' "
cWhere += " AND F2_EMISSAO >='" + DTOS(mv_par01) + "' AND F2_EMISSAO <= '" + DTOS(mv_par02) + "' "
cWhere += " AND F2_DOC >='" + cMvPar03 + "' AND F2_DOC <= '" + cMvPar05 + "' "
cWhere += " AND F2_SERIE >='" + mv_par04 + "' AND F2_SERIE <= '" + mv_par06 + "' "
cWhere += "%"

BeginSql alias cQryTemp  
	
	SELECT F2_FILIAL, F2_NFCUPOM, Count(F2_NFCUPOM) AS QTD_CUPOM
	
	FROM %table:SF2% 
	
	WHERE F2_FILIAL = %xFilial:SF2%     AND 
	      %exp:cWhere%                  AND
	      F2_NFCUPOM <> ''              AND 
	      F2_ESPECIE IN ('CF', 'SATCE', 'NFCE') AND
	      %notDel%
	
	GROUP BY F2_FILIAL, F2_ESPECIE, F2_NFCUPOM
	
EndSql

(cQryTemp)->(DbGoTop())
While !(cQryTemp)->(EOF())
	AAdd(aDados, { .F., (cQryTemp)->F2_FILIAL, SubStr((cQryTemp)->F2_NFCUPOM, 1, 3), SubStr((cQryTemp)->F2_NFCUPOM, 4, Len((cQryTemp)->F2_NFCUPOM)), (cQryTemp)->QTD_CUPOM  })
	(cQryTemp)->(DbSkip())
End

(cQryTemp)->(DbCloseArea())

If Len(aDados) > 0

	LjGrvLog("NOTA_SOBRE_CUPOM","Notas retornadas da consulta da SF2 - aDados",aDados)
	
	// Montagem da Tela
	DEFINE MSDIALOG oDlgCons TITLE STR0066 FROM 9,0 TO 30,53 OF oMainWnd // "Estorno de Nota Sobre Cupom"
	
	// "Selecione as notas a serem estornadas:"
	@ 03,06 SAY STR0067 SIZE 180,30 OF oDlgCons PIXEL 	
	
	// Botões ( Detalhes / Confirmar )
	TButton():New( 138,168,STR0068,oDlgCons,{|| U_LJ131NFDet(aDados[oListBox:nAt,3]+aDados[oListBox:nAt,4]) }, 37,12,,,.F.,.T.,.F.,,.F.,,,.F. ) // "Detalhes"
	TButton():New( 138,127,STR0069,oDlgCons,{|| IIf(U_Lj131Conf(aDados, oListBox, @aRet), oDlgCons:End(), Nil) }, 37,12,,,.F.,.T.,.F.,,.F.,,,.F. ) // "Confirmar"
	
	// Listbox
	@ 1,.7 LISTBOX oListBox VAR cListBox Fields HEADER "", STR0070, STR0071, STR0072, STR0073 SIZE 200,120 // Filial, Serie, Numero Nota, Qtd. Cupom
	
	// Faz a configuracao da ListBox
	oListBox:SetArray(aDados)
	oListBox:bLine := { || { IIf(aDados[oListBox:nAt][1],oOk,oNo), aDados[oListBox:nAt,2],aDados[oListBox:nAt,3],aDados[oListBox:nAt,4],aDados[oListBox:nAt,5]} }
	
	// Configura o Duplo Clique
	oListBox:bLDblClick := {||  U_LjDblClick(@oListBox, @aDados) }
	
	ACTIVATE MSDIALOG oDlgCons CENTERED
Else
	Ljr130Msg(STR0043,NIL,1) //"Não existem registros para serem apresentados com esses parâmetros."
EndIf

Return aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³LjDblClick ºAutor  ³ Varejo            º Data ³  16/06/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tratamento para duplo clique do botão da função            º±±
±±º          ³ U_LJ131NFEst()                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³LOJR130                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function LjDblClick(oListBox, aDados)

If oListBox:NCOLPOS == 1
	aDados[oListBox:nAt, 1] := !aDados[oListBox:nAt, 1] 
Else
	U_LJ131NFDet(aDados[oListBox:nAt,3]+aDados[oListBox:nAt,4])
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Lj131Conf  ºAutor  ³ Varejo            º Data ³  16/06/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tratamento confirmar o estorno das notas selecionadas      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³LOJR130                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Lj131Conf(aDados, oListBox, aRet)

Local lRet := .F.
Local nX   := 0

LjGrvLog("NOTA_SOBRE_CUPOM","Notas selecionadas para estorno - aDados",aDados)

DbSelectArea("SF2")
SF2->(DbSetOrder(1))

For nX := 1 To Len(aDados)
	If (aDados[nX][1])
		SF2->(DbSeek(xFilial("SF2") + aDados[nX][4] + aDados[nX][3])) // F2_FILIAL+F2_DOC+F2_SERIE
		RecLock("SF2", .F.)
		SF2->F2_OK := GetMark(,"SF2","F2_OK")
		SF2->(MsUnlock())
		AAdd(aRet, aDados[nX])
		lRet := .T.
	EndIF		
Next

If !lRet
	Ljr130Msg(STR0048,NIL,2) // Nenhum registro selecionado..
EndIf

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³LjAllowChk ºAutor  ³ Varejo            º Data ³  16/06/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna a permissão para o duplo clique no MarkBrow        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³LOJR130                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function LjAllowChk()

Local lRet := .F.

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³LJ131NFDet ºAutor  ³ Varejo            º Data ³  16/06/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Tela para exibir detalhes da nota                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³LOJR130                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function LJ131NFDet(nNota)

Local cWhere   := "%%"										// Expressão
Local oListCup
Local aCupons  := {}

// Montagem da Tela
DEFINE MSDIALOG oDlgCup TITLE STR0074 FROM 9,0 TO 34,55 OF oMainWnd // "Nota x Cupom"

// Cupons relacionados com a Nota:     Serie:
@ 03,06 SAY STR0075 + SubStr(nNota, 4, Len(nNota)) + STR0076 + SubStr(nNota, 1, 3)   SIZE 180,30 OF oDlgCup PIXEL 	

// Botões ( Fechar)
TButton():New( 170,173,STR0077,oDlgCup,{|| oDlgCup:End() }, 37,12,,,.F.,.T.,.F.,,.F.,,,.F. ) // Fechar

// Listbox
@ 1,.7 LISTBOX oListCup VAR cListCup Fields HEADER STR0070, STR0071, STR0078, STR0079, SIZE 205,150 // Filial, Serie, Numero Cupom, Emissão

cQryTemp := GetNextAlias()

cWhere := "%F2_CLIENTE ='" + Mv_Par07 + "' "
cWhere += " AND F2_LOJA ='" + Mv_Par08 + "' "
cWhere += " AND F2_NFCUPOM = '" + nNota + "' "
cWhere += "%"

BeginSql alias cQryTemp  
	
	SELECT F2_FILIAL, F2_SERIE, F2_DOC, F2_EMISSAO
	
	FROM %table:SF2% 
	
	WHERE F2_FILIAL = %xFilial:SF2%     AND 
	      %exp:cWhere%                  AND
	      F2_ESPECIE IN ('CF', 'SATCE', 'NFCE') AND
	      %notDel%
	
EndSql

(cQryTemp)->(DbGoTop())
While !(cQryTemp)->(EOF())
	AAdd(aCupons, { (cQryTemp)->F2_FILIAL, (cQryTemp)->F2_SERIE, (cQryTemp)->F2_DOC, STOD((cQryTemp)->F2_EMISSAO)  })
	(cQryTemp)->(DbSkip())
End

(cQryTemp)->(DbCloseArea())

// Faz a configuracao da ListBox
oListCup:SetArray(aCupons)
oListCup:bLine := { || { aCupons[oListCup:nAt,1],aCupons[oListCup:nAt,2],aCupons[oListCup:nAt,3],aCupons[oListCup:nAt,4]} }

ACTIVATE MSDIALOG oDlgCup CENTERED

Return

//--------------------------------------------------------
/*/{Protheus.doc}LjR30Sped
Função criada para retorno dos cupons na geração do Sped

Pré-requisito : SF2 posicionada para uso

@author  	Varejo
@version 	P11.8
@since   	03/05/2012
@return  	Nil
@obs     
@sample
/*/
//--------------------------------------------------------
User Function LjR30Sped()

Local aRet		:= {}
Local aArea		:= GetArea()
Local aAreaSD2	:= {}

Local cNumNota	:= ""
Local cSerNota	:= ""
Local cFilNota	:= ""
Local cAlias	:= "SD2"
Local cQuery	:= ""

If !Empty(AllTrim(SF2->F2_NFCUPOM)) .And. (AllTrim(SF2->F2_NFCUPOM) == "MDL-RECORDED")

	cNumNota := SF2->F2_DOC
	cSerNota := SF2->F2_SERIE
	cFilNota := SF2->F2_FILIAL
	
	If !(Select("SD2") > 0)
		DbSelectArea("SD2")
	EndIf

	aAreaSD2	:= SD2->(GetArea())

	cAlias	:= "SD2TMP"
	
	If Select(cAlias) > 0
		(cAlias)->(DbCloseArea())
	EndIf
	
	cQuery	:= "SELECT D2_FILIAL,D2_DOC,D2_SERIE,D2_ITEM,D2_PDV,D2_CLIENTE,D2_LOJA,R_E_C_N_O_ SD2Recno "
	cQuery	+= " FROM " + RetSqlName("SD2") + " SD2 "
	cQuery	+= " WHERE D_E_L_E_T_ = ''  "
	cQuery	+= " AND D2_FILIAL = '" + cFilNota + "'"
	cQuery	+= " AND D2_NFCUP = '"+ cNumNota +"' "  
	cQuery	+= " AND D2_SERIORI = '" + cSerNota + "'"
	
	cQuery := ChangeQuery( cQuery )
	DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery),cAlias, .F., .T.)
	(cAlias)->(DbGoTop())

	While !(cAlias)->(Eof())
		Aadd( aRet ,{	(cAlias)->D2_FILIAL,;
						(cAlias)->D2_DOC,;
						(cAlias)->D2_SERIE,;
						(cAlias)->SD2Recno,;
						(cAlias)->D2_CLIENTE,;
						(cAlias)->D2_LOJA} )

		(cAlias)->(DbSkip())
	EndDo

	RestArea(aAreaSD2)
EndIf

RestArea(aArea)

Return aRet

//--------------------------------------------------------
/*/{Protheus.doc}LjR130Compl
Função criada para inserir mensagem complementar na NF-e e gravar em F2_MENNOTA

@author  	Varejo
@version 	P11.8
@since   	03/04/2017
@return  	Nil
@obs     
@sample
/*/
//--------------------------------------------------------
Static Function LjR130Compl()

Local	oDlg	:= nil
Local	nOpd	:= 0					//Retorno dos botões Sim/Não
Local	cSL1Nota := SL1->L1_MENNOTA		//Mensagem da Nota Fiscal digitado na Venda Assistida

If Empty(cMenNota) .AND. !Empty(cSL1Nota)
	cMenNota := cSL1Nota
EndIf

DEFINE MSDIALOG oDlg TITLE STR0080 FROM 13,21 TO 17,110 //"Mensagem NF (MV_LJMENNO):"
@ .074,.1 TO 1.8,44
@ 06,12  SAY	STR0081   	SIZE 135,10 OF oDlg PIXEL  //"Informe a Mensagem para Nota Fiscal :"
@ 06,130 MSGET	cMenNota	SIZE 150,10 OF oDlg PIXEL PICTURE PesqPict("SF2","F2_MENNOTA") 

DEFINE SBUTTON FROM 06,290 TYPE  1 PIXEL ACTION ( nOpd:=1,oDlg:End()) ENABLE OF oDlg
DEFINE SBUTTON FROM 06,320 TYPE  2 PIXEL ACTION ( nOpd:=3,oDlg:End()) ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg CENTERED                                                                                           
                                                                                                              
If nOpd<>1	                                                                                                                
	cMenNota := ""		//Se escolheu "Não", a gravação continuará em branco
EndIf					

Return nil

//--------------------------------------------------------
/*/{Protheus.doc}LjR130VlLeg

Valida se possui alguma legislação que impeça a emissão 
da Nota Sobre Cupom

@author  	Varejo
@version 	P12
@since   	03/04/2017
@param 		lSped, Lógico, Indica se a Especie utilizada para geração da Nota é SPED (NF-e)
@return  	lRet - pode prosseguir com a emissao da nota?
/*/
//--------------------------------------------------------
Static Function LjR130VlLeg(lSped)
Local lRet		:= .T.
Local lL1_KeyNfce:= SL1->(ColumnPos("L1_KEYNFCE")) > 0
Local lVendaSAT := .F.
Local aLegis	:= {}
Local cTitMsg	:= ""
Local cTxtMsg	:= ""

If	cPaisLoc == "BRA"
	lVendaSAT := IIF(!Empty(AllTrim(SL1->L1_SERSAT)),.T.,.F.)
	
	If !lVendaSAT .And. lL1_KeyNfce .And. !Empty(AllTrim(SL1->L1_KEYNFCE))
		aLegis := LjAnalisaLeg(79)  
		If aLegis[1]
			cTitMsg	:= aLegis[5]
			cTxtMsg	:= aLegis[4]
			lRet := .F.
		EndIf

		//Verifica o tipo de Indicador de Presença da NFC-e é (tag:indPres=4) - Entrega em Domicilio
		//Não permite gerar a Nota para NFC-e que tenha esse tipo de Indicador de Presença, pois é específico para uso da NFC-e.
		//Ocorre rejeição na transmissão da NF-e com tag:indPres=4 (Entrega em Domicilio)
		If lRet .And. lSped .And. SL1->(ColumnPos("L1_INDPRES")) > 0 .And. SL1->L1_INDPRES == "4" //4=NFC-e em operação com entrega a domicílio
			aLegis := LjAnalisaLeg(89)  
			If aLegis[1]
				cTitMsg	:= aLegis[5]
				cTxtMsg	:= aLegis[4]
				cTxtMsg += CHR(13) + CHR(13) + "DOC: " + SL1->L1_DOC + "/ SERIE: " + SL1->L1_SERIE
				lRet := .F.
			EndIf
		EndIf

		If !Empty(cTxtMsg)
			If !lExecAtM
				STPosMSG(cTitMsg, cTxtMsg, .T., .F., .F.)
			EndIf
			LjGrvLog("Legislação Nota", cTxtMsg)
		EndIf
	EndIf
EndIf

Return lRet

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} LjR130All
Função para marcar todos as linhas do Nota Sobre Cupom

@author    eduardo.sales
@version   11.8
@since     18.05.2017
@param -
@return NIL

/*/
//------------------------------------------------------------------------------------------
User Function LjR130All(cAliasTmp, oMark)
Local lMarcaAll	 := .F. //.T.=Marca Todos; .F.=Desmarca todos

dbSelectArea(cAliasTmp)
(cAliasTmp)->(dbGotop())

//Verifica se tem registros não marcados para definir se deve MARCAR ou DESMARCAR todos
(cAliasTmp)->( DBEval( { || lMarcaAll := .T. } , { || Empty((cAliasTmp)->F2_OK) } ) )

(cAliasTmp)->(dbGotop())
While (cAliasTmp)->(!Eof())
	If (lMarcaAll .And. Empty((cAliasTmp)->F2_OK)) .Or. !lMarcaAll
		oMark:MarkRec()
	EndIf
	(cAliasTmp)->(dbSkip())
End

oMark:Refresh(.T.)

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} LjVerfCliEP
Função que verifica se o cliente é empresa pública 

@param cCliente, Código do Cliente
@param cLoja, Código da loja do Cliente
@return lRet, Indica se o cliente é empresa pública  

@author Pedro Alencar
@since 18/05/2017
@version P12.1.17
/*/
Static Function LjVerfCliEP( cCliente, CLoja )
	
Local lRet := .F.
Local aAreaSA1 := SA1->( GetArea() )

SA1->( DbSetOrder( 1 ) ) //A1_FILIAL+A1_COD+A1_LOJA
	
If SA1->( MsSeek( FWxFilial("SA1") + cCliente + CLoja ) )
	If SA1->A1_TPESSOA == "EP"
		lRet := .T.
	EndIf 
EndIf 

RestArea( aAreaSA1 )

Return lRet

/*/{Protheus.doc} IntegDef
Rotina para Definicao de Integracao via Mensagem Unica. 

@param cXml, Conteudo da mensagem (XML)  
@param nType, Tipo da transacao
@param cTypeMsg, Tipo da mensagem
@return aRet, Aray com resultado da execucao e a mensagem Xml de retorno
				aRet[1]-(boolean) Indica o resultado da execução da função
				aRet[2]-(caracter) Mensagem Xml para envio

@author alessandrosantos
@since 18/05/2017
@version P12.1.17
/*/

Static Function IntegDef(cXml, nType, cTypeMsg)

Local aRet := {}

lIntDefPro := .T.
aRet := LOJI130(cXml, nType, cTypeMsg)
lIntDefPro := .F.

Return aRet

//--------------------------------------------------------
/*/{Protheus.doc}Lj7SpedExc
Valida se pode cancelar a Nota Sobre Cupom conforme configuração do parâmetro MV_SPEDEXC(

@author  	Gilmar Costa
@version 	P12
@since   	17/02/2022
@param 		.F. - Não Apresenta mensagem / .T. - Apresenta Mensagem
@return  	lRet - pode prosseguir com o cancelamento da nota?
/*/
//--------------------------------------------------------
Static Function Lj7SpedExc(lMExibMsg)
Local lRet				:= .T. 											// Retorno da função
Local nSpedExc 			:= SuperGetMV("MV_SPEDEXC",,72)					// Indica a quantidade de horas q a NFe pode ser cancelada
Local lEndFis   		:= SuperGetMv("MV_SPEDEND",, .F.)				// Se estiver como F refere-se ao endere? de Cobran? se estiver T  ao  endere? de Entrega.
Local cEstSM0			:= IIf(!lEndFis, SM0->M0_ESTCOB, SM0->M0_ESTENT)// Estado de emissão
Local cHoraUF 			:= FwTimeUF(cEstSM0)[2]							// Horario do UF	
Local dDtdigit			:=  dDataBase									// Data da emissao da nota
Local nHoras			:= 0											// Quantidade de horas da hora atual
Local cMsgHelp			:=  CRLF + "[ " + STR0070 + ": " + Alltrim(SF2->F2_FILIAL) + " / " + STR0072 + ": " +Alltrim(SF2->F2_DOC) + " / " + STR0071 + ": " + Alltrim(SF2->F2_SERIE) + "]" + CRLF +;
							STR0101 + " " + cValToChar(nSpedExc) + STR0102

If "SPED" $ SF2->F2_ESPECIE //Validação para NF-e
	dDtdigit := SF2->F2_EMISSAO
	nHoras   := SubtHoras( dDtdigit, SF2->F2_HORA, dDATABASE, SubStr(cHoraUF,1,2) + ":" + SubStr(cHoraUF,4,2) )

	If nHoras > nSpedExc 
		If lMExibMsg
			Help(nil,nil, CRLF + STR0103, nil, cMsgHelp, 1, 0, NIL, NIL, NIL, NIL, NIL) //"NOTA FISCAL FORA DO PRAZO!"#"Não foi possivel excluir a nota, pois o prazo para o cancelamento do documento de saída é de"#" horas. Conforme configurado no parâmetro MV_SPEDEXC "
		EndIf
		lRet := .F.
	EndIf
EndIf

Return(lRet)
