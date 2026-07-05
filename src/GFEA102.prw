/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GFEA102.ch"
#include "protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} GFEA102

Contrato com Autônomo

@author Jorge Matos Valcanaia 
@since 17/02/10
@version 1.0
/*/
//-------------------------------------------------------------------
User Function GFEA102()
	Local wnrel
	Local cString  := "GW2"
	Local titulo   := "IMPRESSÃO DE CONTRATOS / RPA"
	Local NomeProg := "GFEA102"
	Local Tamanho  := "M"
	Local nContCont := 0
	Local nContImp := 0

	Private GFEContLog := GFEViewProc():New()

	GFEContLog:EnableLog("impressao_contrato_autonomo", "Impressão de Contrato Autônomo")

	If !Pergunte("GFEA102",.T.) /*Abre o grupo de perguntas para o usuario e se for cancelado o grupo fecha e não executa ação nenhuma*/
		Return Nil
	Endif

	GFEContLog:GFELog:ShowParameters("GFEA102")

	DbSelectArea("GW2")
	DbSetOrder(1)
	DbSeek(xFilial("GW2") + MV_PAR01, .T. )
	While !Eof() .And. GW2->GW2_NRCONT >= MV_PAR01 .And. GW2->GW2_NRCONT <= MV_PAR02
		nContCont := nContCont + 1
	GW2->( dbSkip() )
	EndDo

	DbSelectArea("GW2")
	DbSetOrder(1)
	DbSeek(xFilial("GW2") + MV_PAR01, .T. )
	While !Eof() .And. GW2->GW2_NRCONT >= MV_PAR01 .And. GW2->GW2_NRCONT <= MV_PAR02
		If  GW2->GW2_SITCON $ "1;4"
			GFEContLog:AddDetail("O Contrato " + Alltrim(GW2->GW2_NRCONT) + " está com situação "+Iif(GW2->GW2_SITCON=="1","Criado","Cancelado")+", portanto não é possível imprimí-lo.")
	        //Help( ,, 'Help',, "Não é possível imprimir contratos que estejam com situação Criado ou Cancelado.", 1, 0 )
			//Return
			nContImp := nContImp + 1
		ElseIf MV_PAR03 == 2 .And. GW2->GW2_SITCON == "3"
			GFEContLog:AddDetail("O contrato número " + Alltrim(GW2->GW2_NRCONT) + " já foi impresso oficialmente.")
			//Help( ,, 'Help',, "O contrato número " + Alltrim(GW2->GW2_NRCONT) + " já foi impresso oficialmente.", 1, 0 )
			//Return
			nContImp := nContImp + 1
		EndIf
	GW2->( dbSkip() )
	EndDo

	If (nContCont == nContImp)
		GFEContLog:AddDetail("Não há nenhum contrato para ser impresso. Verifique os parâmetros informados e tente novamente.")
		GFEContLog:Show("Impressão de Contratos Autônomos", "Contratos não impressos.", "Detalhes", "Há contratos que não podem ser impressos. Clique no botão 'Detalhes' para mais detalhes.")
		Return
	EndIf

	PRIVATE aReturn := { STR0002, 1,STR0003, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
	
	wnrel := SetPrint(cString,NomeProg,"",@titulo,STR0004, "", "",.F.,.F.,.F.,Tamanho,,.F.) //"Este Rélatorio ira Imprimir o Contrato"
	
	If nLastkey == 27
		Return
	EndIf 
	
	SetDefault(aReturn,cString)
	
	If nLastkey == 27
		Return
	EndIf
	
	RptStatus({|lEnd| U_GFEA102RE(@lEnd,wnRel,cString,Tamanho,NomeProg)},titulo)
Return 
          
//-------------------------------------------------------------------
/*/{Protheus.doc} GFEA102

Função que busca os registros para serem mostrados no Contrato

@author Jorge Matos Valcanaia
@since 17/02/10
@version 1.0
/*/
//-------------------------------------------------------------------
User Function GFEA102RE(lEnd,WnRel,cString,Tamanho,NomeProg)
LOCAL cabec1,cabec2
Local nCntImpr 
Local nTipo   

/*Variaveis para o Primeiro Veículo*/
Local cCdVei1
Local cUfVei1 
Local cTipo1
Local nCargUt1
Local cVolum1

/*Variaveis para o Segundo Veículo*/
Local cCdVei2
Local cUfVei2 
Local cTipo2
Local nCargUt2
Local cVolum2
              
/*Variaveis para o Terceiro Veículo*/
Local cCdVei3
Local cUfVei3 
Local cTipo3
Local nCargUt3
Local cVolum3  
            
/*Variaveis do Proprietario*/
Local cNmEmit 
Local cIdFed  
Local cEnder  
Local cNmCid  
Local cUf     
Local cCep    
Local cFone1  
Local cFone2 
           
/*Variaveis do Motorista*/
Local cNmMtr
Local cCpfMtr 

/**/
Local dData
Local cOrigem
Local cUfOri
Local cDest
Local cUfDEst
Local nValorFret
Local nPE := 0 // Utilizado no Ponto de Entrada GFE102VA
Local nPEVal := 0	// Utilizado no Ponto de Entrada GFE102VA
Local s_GFE102VA := ExistBlock("GFE102VA")
Local s_GFEI17   := SuperGetMV('MV_GFEI17',,'1')
Local s_GFEI18   := SuperGetMV('MV_GFEI18',,'1')
Local s_GFEI19   := SuperGetMV('MV_GFEI19',,'1')   
Local s_ERPGFE   := SuperGetMV('MV_ERPGFE',,'1')  

nCntImpr := 0

li := 80 
m_pag := 1

//³ Inicializa os codigos de caracter Comprimido da impressora ³
nTipo := 15
   
dbSelectArea("GW2")
dbSetOrder(1)
SetRegua(LastRec())
dbSeek(xFilial("GW2")+MV_PAR01,.T.)
While !Eof() .And. xFilial("GW2") == GW2->GW2_FILIAL .And. /*GW2->GW2_NRCONT >= MV_PAR01 .And.*/ GW2->GW2_NRCONT <= MV_PAR02
	// Só imprime se for impressão oficial e o status do contrato for igual a 2 - Confirmado
	// ou se for prévia/reimpressão e o status for igual a 2 - Confirmado ou 3 - Emitido
	If (GW2->GW2_SITCON == "2" .And. MV_PAR03 == 2) .Or. (GW2->GW2_SITCON $ "23" .And. MV_PAR03 == 1)
		/*Grava o número do contrato e o cabeçalho*/
		titulo:= oemtoansi(STR0006) //"Contrato com Autônomo   "
		cabec1:= oemtoansi(STR0007+GW2->GW2_NRCONT) //"Nr: "
		cabec2:= "" 
	    
		/*Limpa as variaveis do contrato para não ficar sujeira e não ser impressos valores em lugares errados*/
		cCdVei1 := cUfVei1 := cTipo1 := nCargUt1 :=	cVolum1 := ""
		cCdVei2 := cUfVei2 := cTipo2 := nCargUt2 :=	cVolum2 := ""
		cCdVei3 := cUfVei3 := cTipo3 := nCargUt3 :=	cVolum3 := ""    
		
		cNmEmit := cIdFed := cEnder := cNmCid := cUf := cCep := cFone1 := cFone2 := ""   
		
		cNmMtr := cCpfMtr := ""   
		
		nVlFrete := nVlAdic := nVlTotFret := ""
		/*----------------------------------------------------------------------------*/
		                                          
		/*Grava os valores do primeiro veículo*/
		dbSelectArea("GU8")
		dbSetOrder(1)
		If dbSeek(xFilial("GU8")+GW2->GW2_CDVEI1)	
			cCdVei1 := GW2->GW2_CDVEI1
			cCdVei1  := GU8->GU8_PLACA
			cUfVei1  := GU8->GU8_UFPLAC
			cTipo1   := GU8->GU8_CDTPVC
			nCargUt1 := GU8->GU8_CARGUT 
			cVolum1  := GU8->GU8_VOLUT		
		Endif
	
		/*Grava os valores do segundo veículo*/
		dbSelectArea("GU8")
		dbSetOrder(1)
		If dbSeek(xFilial("GU8")+GW2->GW2_CDVEI2)	
			cCdVei2 := GW2->GW2_CDVEI2
			cCdVei2  := GU8->GU8_PLACA
			cUfVei2  := GU8->GU8_UFPLAC
			cTipo2   := GU8->GU8_CDTPVC
			nCargUt2 := GU8->GU8_CARGUT 
			cVolum2  := GU8->GU8_VOLUT		
		Endif	                     
		
		/*Grava os valores do terceiro veículo*/
		dbSelectArea("GU8")
		dbSetOrder(1)
		If dbSeek(xFilial("GU8")+GW2->GW2_CDVEI3)	
			cCdVei3 := GW2->GW2_CDVEI3
			cCdVei3  := GU8->GU8_PLACA
			cUfVei3  := GU8->GU8_UFPLAC
			cTipo3   := GU8->GU8_CDTPVC
			nCargUt3 := GU8->GU8_CARGUT 
			cVolum3  := GU8->GU8_VOLUT		
		Endif
		                              
		/*Grava os valores do proprietario*/
		dbSelectArea("GU3")	
		dbSetOrder(1)
		If dbSeek(xFilial("GU3")+GW2->GW2_CDPROP)
		   cNmEmit := GU3->GU3_NMEMIT
		   cIdFed  := GU3->GU3_IDFED
		   cEnder  := GU3->GU3_ENDER
		   cNmCid  := posicione("GU7",1,xFilial("GU7")+GU3->GU3_NRCID,"GU7_NMCID")	
		   cUf     := posicione("GU7",1,xFilial("GU7")+GU3->GU3_NRCID,"GU7_CDUF")                                       
		   cCep    := GU3->GU3_CEP
		   cFone1  := GU3->GU3_FONE1
		   cFone2  := GU3->GU3_FONE2
		Endif
	
		/*Grava os valores do motorista*/	
		dbSelectArea("GUU")
		dbSetOrder(1)
		If dbSeek(xFilial("GUU")+GW2->GW2_CDMTR)
			cNmMtr  := GUU->GUU_NMMTR
			cCpfMtr := GUU->GUU_IDFED
		Endif	
		
	    IncRegua()
	    If Li > 60
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
		Endif
	    nCntImpr++
	   	@ Li,50 PSAY STR0008   	                                                 //"CONTRATADOS"
	   	Li++
		@ Li,0  PSAY   "--------------------------------------------------------------------------------------------------------------"  	
		Li++
	    @ Li,0  PSAY STR0009   //"Veículos: Placa      UF      Tipo              Carga Útil              Volume"
	    If !Empty(cCdVei1)
	    Li++
	    @ Li,10 PSAY cCdVei1
	    @ Li,21 PSAY cUfVei1 
	    @ Li,29 PSAY cTipo1
	    @ Li,47 PSAY nCargUt1 Picture PesqPict("GU8","GU8_CARGUT")
	    @ Li,71 PSAY cVolum1  Picture PesqPict("GU8","GU8_VOLUT" )
	    Endif
	    If !Empty(cCdVei2)
	   	Li++
	    @ Li,10 PSAY cCdVei2 
	    @ Li,21 PSAY cUfVei2 
	    @ Li,29 PSAY cTipo2
	    @ Li,47 PSAY nCargUt2 Picture PesqPict("GU8","GU8_CARGUT")
	    @ Li,71 PSAY cVolum2  Picture PesqPict("GU8","GU8_VOLUT" )
	    Endif
	    If !Empty(cCdVei3)
	   	Li++
	    @ Li,10 PSAY cCdVei3
	    @ Li,21 PSAY cUfVei3 
	    @ Li,29 PSAY cTipo3
	    @ Li,47 PSAY nCargUt3 Picture PesqPict("GU8","GU8_CARGUT")
	    @ Li,71 PSAY cVolum3  Picture PesqPict("GU8","GU8_VOLUT" )
	    Endif 
	  	Li++
	  	Li++
	    @ Li,0  PSAY STR0010   //"Proprietário:                                               Motorista: "
	    Li++
	    @ Li,0  PSAY cNmEmit 
	    @ Li,60 PSAY cNmMtr
	    Li++
	    @ Li,0  PSAY "CPF: "  //"CPF: "
	    @ Li,10 PSAY cIdFed 
	    @ Li,60 PSAY "CPF: " //"CPF: "
		@ Li,70 PSAY cCpfMtr
	    Li++
	    @ Li,0  PSAY cEnder
	    Li++
	    @ Li,0  PSAY cNmCid
	    @ Li,30 PSAY cUf
		@ Li,35 PSAY cCep
		Li++
		@ Li,0 PSAY STR0012 //"Fone: "
	    @ Li,6 PSAY cFone1  
		If !Empty(cFone2)
	    @ Li,15 PSAY "/"
	    @ Li,18 PSAY cFone2
	    Endif 
	    Li++
	    Li++
	    Li++ 
	    @ Li,0  PSAY   "--------------------------------------"+STR0034+"--------------------------------------" //"DESCRIÇÃO DO FRETAMENTO CONTRATADO"
	    Li++
		@ Li,0 PSAY STR0013 //"Data               Origem            UF           Destino            UF                Valor Frete"
		 
		/*Grava os cálculos do contrato*/		
		dbSelectArea("GWF")
		dbSetOrder(2)
		dbSeek(xFilial("GWF")+GW2->GW2_NRCONT)
		While !Eof() .And. xFilial("GWF") == GWF->GWF_FILIAL .And. GWF->GWF_NRCONT == GW2->GW2_NRCONT	
			/*Limpa as variaveis para não ficar sujeira em tela*/
			dData := cOrigem := cUfOri := cDest := cUfDEst := nValorFret := ""
			
			dData      := GWF->GWF_DTCRIA
			cOrigem    := posicione("GU7",1,xFilial("GU7")+GWF->GWF_CIDORI,"GU7_NMCID")                                       
			cUfOri     := posicione("GU7",1,xFilial("GU7")+GWF->GWF_CIDORI,"GU7_CDUF" )                                       
			cDest      := posicione("GU7",1,xFilial("GU7")+GWF->GWF_CIDDES,"GU7_NMCID")                                       
			cUfDEst    := posicione("GU7",1,xFilial("GU7")+GWF->GWF_CIDDES,"GU7_CDUF" )
			nValorFret := VLTOTFRET(GWF->GWF_NRCALC)
		
			Li++
			@ Li,0  PSAY dData
			@ Li,19 PSAY cOrigem
			@ Li,38 PSAY cUfOri
			@ Li,51 PSAY cDest
			@ Li,70 PSAY cUfDEst
			@ Li,88 PSAY nValorFret Picture "@E 999,999,999.99"
			dbSelectArea("GWF")
			dbSkip()
		EndDo 
		
		nVlFrete   := GW2->GW2_VLFRET
		nVlAdic    := GW2->GW2_VLADIC
		nVlTotFret := nVlAdic + nVlFrete
		
		// Início Ponto de Entrada Usina Colombo - Chamado TP9972
		If s_GFE102VA
		   	aValorC := ExecBlock("GFE102VA",.f.,.f.,{GW2->GW2_FILIAL, GW2->GW2_NRCONT, GW2->GW2_VLFRET})
			For nPE := 1 to Len(aValorC)
				nVlTotFret := nVlTotFret - aValorC[nPE][2]
				nPEVal += aValorC[nPE][2]
			Next nPE					   	
		EndIf
		// Fim Ponto de Entrada Usina Colombo		
		
		Li++ 
		Li++
		@ Li,0  PSAY STR0014 //"Peso Bruto: "
		@ Li,12 PSAY GW2->GW2_QTPESO Picture PesqPict("GW2","GW2_QTPESO")
		@ Li,30 PSAY STR0015 //"Kg"
		Li++ 
		@ Li,0  PSAY   "----------------------------------------------"+STR0035+"-----------------------------------------------" //"ACERTO FINANCEIRO"
		Li++ 
		@ Li,25 PSAY   STR0016 //"(+) Frete Contratado"
		@ Li,65 PSAY nVlFrete Picture PesqPict("GW2","GW2_VLFRET")
		Li++						
		@ Li,25 PSAY   STR0017  //"(+) Adicionais"
		@ Li,65 PSAY nVlAdic Picture PesqPict("GW2","GW2_VLADIC")
						
		// Início Ponto de Entrada Usina Colombo - Chamado TP9972
		If s_GFE102VA
			For nPE := 1 to Len(aValorC)
				Li++			
				@ Li,25 PSAY aValorC[nPE][1] 
				@ Li,65 PSAY aValorC[nPE][2] Picture PesqPict("GW2","GW2_VLADIC")							
			Next nPE			
		EndIf
		// Fim Ponto de Entrada Usina Colombo			
		
		Li++ 
		@ Li,63 PSAY   "------------------" 
		Li++ 
		@ Li,29 PSAY   STR0018 //"Total do Fretamento"
		@ Li,65 PSAY nVlTotFret Picture PesqPict("GW2","GW2_VLADIC")
		Li++        
		Li++  
		@ Li,25 PSAY   STR0019 //"(-) Descontos"
		@ Li,65 PSAY GW2->GW2_VLDESC Picture PesqPict("GW2","GW2_VLDESC")
		Li++   
		@ Li,25 PSAY   STR0020   //"(-) SEST/SENAT"
		@ Li,65 PSAY GW2->GW2_VLSEST Picture PesqPict("GW2","GW2_VLSEST")
		Li++                          
		@ Li,25 PSAY   STR0021  //"(-) ISS"
		@ Li,65 PSAY GW2->GW2_VLISS Picture PesqPict("GW2","GW2_VLISS")
		Li++ 
		@ Li,25 PSAY   STR0022  //"(-) INSS Autônomo"
		@ Li,65 PSAY GW2->GW2_VLINSS Picture PesqPict("GW2","GW2_VLINSS")
		Li++ 
		@ Li,25 PSAY   STR0023 //"(-) IRRF"
		@ Li,65 PSAY GW2->GW2_VLIRRF Picture PesqPict("GW2","GW2_VLIRRF")
		Li++  
		@ Li,63 PSAY   "------------------" 
		Li++ 
		@ Li,29 PSAY   STR0024  //"Total Descontos"
		@ Li,65 PSAY GW2->GW2_VLIMP Picture PesqPict("GW2","GW2_VLIMP")
		Li++                                                           
		Li++ 
		@ Li,25 PSAY   STR0025 //"Valor Liquido a Recolher no Destino:"
		@ Li,65 PSAY   GW2->GW2_VLLIQ Picture PesqPict("GW2","GW2_VLLIQ")
		Li++
		@ Li,56 PSAY "CIOT:" //"CIOT:"
		@ Li,67 PSAY Space(TamSX3("GW2_CIOT")[1] - Len(AllTrim(GW2->GW2_CIOT))) + AllTrim(GW2->GW2_CIOT)  Picture PesqPict("GW2","GW2_CIOT")
		Li++  
		Li++   
		@ Li,0  PSAY  "--------------------------------------------"+STR0036+"----------------------------------------------" //"RECIBO DO FRETAMENTO"
		Li++      
	 	@ Li,0  PSAY  STR0026  //"Recebi(emos) a importancia de "
		@ Li,40 PSAY GW2->GW2_VLLIQ Picture PesqPict("GW2","GW2_VLLIQ")+" ***************************"  
		Li++
		@ Li,0  PSAY  "("+EXTENSO(GW2->GW2_VLLIQ)+")"
		Li++       
		@ Li,0  PSAY  STR0027  //"provenientes de Fretamento de Carga acima caracterizado."
		Li++  
		Li++      
		@ Li,0  PSAY Alltrim(STR(DAY(DDATABASE)))+STR0028+MESEXTENSO(DDATABASE)+STR0028+Alltrim(STR(YEAR(DDATABASE))) //" de "###" de "
		Li++ 
		
		Li++ 
		@ Li,0  PSAY  "Declaro ter recebido o valor de R$" 		
		
		// Início Ponto de Entrada Usina Colombo - Chamado TP9972
		If s_GFE102VA			
			@ Li,35 PSAY nPEVal			
		Else 	
			@ Li,35 PSAY  "_________________" 	
		EndIf
		// Fim Ponto de Entrada Usina Colombo	
		
		@ Li,52 PSAY " referente ao vale-pedágio"			
						
	/*	Li++ 
		@ Li,0  PSAY  STR0029 	 //"Declaro ter recebido o valor de R$ _________________ referente ao vale-pedágio" */
		Li++                                                                                                
		@ Li,0  PSAY  STR0030  //"que será restituído caso não seja utilizado."
		Li++ 
		Li++ 
		Li++ 
	    @ Li,0  PSAY  "-----------------------------------     -----------------------------------"    
	    Li++ 
  		@ Li,0  PSAY STR0031 //"Filial: "
		@ Li,8 PSAY GetAdvFVal( 'SM0', 'M0_FILIAL'	 , cEmpAnt + cFilAnt, 1, '' )
		@ Li,40  PSAY cNmEmit                                                                        
	    Li++ 
	    @ Li,40  PSAY  STR0032 //"pelo Proprietário"
	    Li++ 
	    Li++
		@ Li,0  PSAY  STR0033   //"Observações: "
	   	@ Li,14 PSAY GW2->GW2_OBS 
	   	
		Li+=100 
		
		// Se é tipo de impressão oficial e o status é igual a 2 - Confirmado
		If MV_PAR03 == 2 .And. GW2->GW2_SITCON == "2"
			GFERatCon(.F., GW2->GW2_NRCONT) 

			/*Cria a tabela GW9*/
			GFEACTBCON( GW2->GW2_NRCONT, GW2->GW2_CDPROP)

			RecLock("GW2",.F.)
			GW2->GW2_SITCON := "3" // Emitido
			GW2->GW2_DTIMPR := DDATABASE
			MsUnlock("GW2")

			//Testa Integração Automatica
			If s_GFEI17 == "2"// Financeiro
				GFEA100X("1",.T.)
			EndIf
			If s_GFEI18 == "2" // Recebimento
				GFEA100X("3",.T.)
			EndIf
			If s_GFEI19 == "2" .AND. GW2->GW2_SITFIN == "4" .AND. s_ERPGFE != "2" // RH  - Verifica se o ERP é Protheus   
				GFEA100X("2",.T.)
			EndIf
		EndIf 
	EndIf

	dbSelectArea("GW2")
	dbSkip()
EndDO

If !Empty(GFEContLog:cBodyDetail)
	GFEContLog:Show("Impressão de Contratos Autônomos", "Status dos contratos.", "Detalhes", "Clique no botão 'Detalhes' para mais detalhes.")
EndIf

Set Device to Screen

If aReturn[5] = 1
   	Set Printer To
   	dbCommitAll()
   	OurSpool(wnrel)
Endif

MS_FLUSH()
Return
