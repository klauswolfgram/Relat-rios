/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR049.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR049  ³ Autor ³ Jacson Soares         ³ Data ³ 21/12/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio do Cadastro de Prospects                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_TMKR049(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±            
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ANALISTA  ³ DATA   ³ BOPS ³MOTIVO DA ALTERACAO                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³        ³      ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TMKR049()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local wnrel   	:= "TMKR049"  	 	// Nome do Arquivo utilizado no Spool
Local Titulo 	:= STR0045			// "Relação de Prospects"
Local cDesc1 	:= STR0001			// "Este relatório tem como objetivo imprimir os prospects "
Local cDesc2 	:= STR0002			// "existentes no cadastro. "
Local cDesc3 	:= STR0003			// "A emissao ocorrerá baseada nos parâmetros do relatorio"
Local nReg   	:= 0
Local nomeprog	:= "TMKR049.PRW"	// nome do programa
Local cString 	:= "SUS"			// Alias utilizado na Filtragem
Local lDic    	:= .F. 				// Habilita/Desabilita Dicionario
Local lComp   	:= .F. 				// Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro 	:= .T. 				// Habilita/Desabilita o Filtro

Private Tamanho := "G" 				// P/M/G
Private Limite  := 220 				// 80/132/220
Private aReturn := { STR0004,;		//[1] Reservado para Formulario		//"Zebrado"
					 1,;			//[2] Reservado para N§ de Vias
					 STR0005,;		//[3] Destinatario					//"Administracao"
					 2,;			//[4] Formato => 1-Comprimido 2-Normal	
					 2,;	    	//[5] Midia   => 1-Disco 2-Impressora
					 1,;			//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
					 "",;			//[7] Expressao do Filtro
					 1 } 			//[8] Ordem a ser selecionada
					 				//[9]..[10]..[n] Campos a Processar (se houver)
Private m_pag   := 1  				// Contador de Paginas
Private nLastKey:= 0  				// Controla o cancelamento da SetPrint e SetDefault
Private cPerg   := "TMK049"  		// Pergunta do Relatorio
Private aOrdem  := {}  				// Ordem do Relatorio

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("TMK049",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ Mv_Par01           // Do Prospect                            ³
//³ Mv_Par02           // Da Loja                                ³
//³ Mv_Par03           // Ate o Prospect                         ³
//³ Mv_Par04           // Ate Loja                               ³
//³ Mv_Par05           // Exibe Contatos              			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,Tamanho,lFiltro)

If (nLastKey == 27)
	DbSelectArea(cString)
	DbSetOrder(1)
	Set Filter to
	Return
Endif

SetDefault(aReturn,cString)

If (nLastKey == 27)
	DbSelectArea(cString)
	DbSetOrder(1)
	Set Filter to
	Return
Endif

RptStatus({|lEnd| TR049Imp(@lEnd,wnRel,cString,nomeprog,Titulo)},Titulo)

Return(.T.)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TR049Imp ³ Autor ³ Jacson Soares         ³ Data ³ 21/12/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TMKR010			                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ANALISTA  ³ DATA   ³ BOPS ³MOTIVO DA ALTERACAO                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³        ³      ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function TR049Imp(lEnd,wnrel,cString,nomeprog,Titulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao Do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nLi		:= 0			// Linha a ser impressa
Local nMax		:= 58			// Maximo de linhas suportada pelo relatorio
Local cbCont	:= 0			// Numero de Registros Processados
Local cbText	:= SPACE(10)	// Mensagem do Rodape
Local cCabec1	:= "" 			// Label dos itens
Local cCabec2	:= "" 			// Label dos itens

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Declaracao de variaveis especificas para este relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cQuery		:= ""					// Guarda a expressao da query para top
Local cCodCont		:= ""					// Quebra do relatorio por codigo do contato
Local cSUS			:= "SUS"				// Gerencia o alias entre top e dbf (Tabela de Prospects)
Local cCampos		:= ""					// Campos do alias principal para select
Local aSetField		:= {}					// Parametros para SetField do alias principal
Local aUS_TIPO      := TkSx3Box("US_TIPO") 	// Le as opcoes do campo no dd SX3
Local aUS_ORIGEM    := TkSx3Box("US_ORIGEM")// Le as opcoes do campo no Origem SX3
Local aUS_STATUS    := TkSx3Box("US_STATUS")// Le as opcoes do campo no Status SX3
Local aTotOrigem    := {0,0,0,0,0}			// Totalizador por Origem (1=Mailing, 2=Campanha, 3=Web, 4=Indicacao, 5=Evento)
Local aTotStatus    := {0,0,0,0,0,0} 		// Totalizador por Status (1=Classificado, 2=Desenvolvimento, 3=Gerente, 4=Stand By, 5=Cancelado, 6=Cliente)
Local nI			:= 0					// Controle
Local nPos			:= 0					// Posicao do array
Local nTotProspect	:= 0					// Total de prospects
Local nTotRel		:= 0					// Total de Prospects com relacionamento

DbSelectArea(cSUS)
DbSetOrder(1)
SetRegua(RecCount())						// Total de Elementos da regua

#IFDEF TOP

	TkSelect(cString, @cCampos, @aSetField)
	
	cQuery :=	" SELECT	" + cCampos +;
				" FROM 		" + RetSqlName("SUS") + " SUS " 
	cQuery +=  	" WHERE		SUS.US_FILIAL = '" + xFilial("SUS") + "' AND" +;
				"			SUS.US_COD  BETWEEN '" + Mv_Par01 + "' AND '" + Mv_Par03 + "' AND" +;
				"			SUS.US_LOJA BETWEEN '" + Mv_Par02 + "' AND '" + Mv_Par04 + "' AND" +;
				" 			SUS.D_E_L_E_T_ = ' '"+; 
				" ORDER BY " + SqlOrder(IndexKey())
                //MEMOWRITE("TMKR049.SQL",cQuery)
                
	cQuery	:= ChangeQuery(cQuery)
	DbSelectArea("SUS")
	DbCloseArea()
	DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SUS', .F., .T.)
	
	For nI := 1 To Len(aSetField)
		TCSetField(cString, aSetField[nI][1], aSetField[nI][2], aSetField[nI][3], aSetField[nI][4])
	Next nI

#ELSE
	MsSeek(xFilial("SUS")+Mv_Par01, .T.)
#ENDIF


While	(!Eof()) 				     	    .AND.;
		(cSUS)->US_FILIAL == xFilial(cSUS)	.AND.;
		(cSUS)->US_COD  >= Mv_Par01			.AND.;
		(cSUS)->US_COD  <= Mv_Par03			
	              
	IncRegua()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Filtra apenas a loja informada no parametro³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (cSUS)->US_LOJA < Mv_Par02 .OR. (cSUS)->US_LOJA > Mv_Par04
		Dbselectarea(cSUS)
		Dbskip()
		Loop
	Endif		

	If lEnd
		@ Prow()+1,000 PSay STR0006 //"CANCELADO PELO OPERADOR"
		Exit
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro do usuario                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (!Empty(aReturn[7])) .AND. (!&(aReturn[7]))
		DbSkip()
		Loop
	Endif
	
	If cCodCont <> (cSUS)->US_COD
		cCodCont := (cSUS)->US_COD
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Controle das Linhas para a quebra de pagina				  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ((nLi+ 8) > nMax)
		  nLi := (nMax+1) 
  		  TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		Endif
		
		// Atualizo contador de Prospect 
		nTotProspect++
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Funcao que incrementa a linha e verifica a quebra de pagina³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0008,25)+":" // "Prospect " 
		@ nLi,PCol()+1	PSay PadR((cSUS)->US_COD+" "+(cSUS)->US_LOJA+"-"+(cSUS)->US_NOME,80)
		@ nLi,Limite/2 	PSay PadR(STR0024,25)+":" // "Data Última Visita  " 
		@ nLi,PCol()+1	PSay PadR((cSUS)->US_ULTVIS,80) 

		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0011,25)+":" // "Nome Reduzido " 
		@ nLi,PCol()+1	PSay PadR((cSUS)->US_NREDUZ,80)
		@ nLi,Limite/2 	PSay PadR(STR0012,25)+":" // "TIPO " 
		nPos := Ascan(aUS_TIPO,{|x| (cSUS)->US_TIPO+"=" $ x})
        If nPos > 0
        	@ nLi,PCol()+1	PSay PadR(IIF(!Empty((cSUS)->US_TIPO), aUS_TIPO[nPos] ,"") ,80)
        Endif
        
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0013,25)+":" // "Endereço " 
		@ nLi,PCol()+1	PSay PadR((cSUS)->US_END,80)    
		@ nLi,Limite/2 	PSay PadR(STR0018,25)+":" // "DDI " 
		@ nLi,PCol()+1	PSay PadR((cSUS)->US_DDI,80) Picture "@R (999)"
	
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
 		@ nLi,000		PSay PadR(STR0014,25)+":" // "Cidade " 
		@ nLi,PCol()+1	PSay PadR((cSUS)->US_MUN,80)    
		@ nLi,Limite/2	PSay PadR(STR0019,25)+":" // "DDD " 
		@ nLi,PCol()+1	PSay PadR((cSUS)->US_DDD,80)  Picture "@R (999)"   

		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0015,25)+":" // "Bairro " 
		@ nLi,PCol()+1	PSay PadR((cSUS)->US_BAIRRO,80) 
		@ nLi,Limite/2	PSay PadR(STR0020,25)+":" // "Telefone " 
		@ nLi,PCol()+1	PSay PadR((cSUS)->US_TEL,80)  Picture "@R 9999-9999"

		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0017,25)+":" // "Estado " 
		@ nLi,PCol()+1	PSay PadR((cSUS)->US_EST,80)    
		@ nLi,Limite/2	PSay PadR(STR0021,25)+":" // "FAX " 
		@ nLi,PCol()+1	PSay PadR((cSUS)->US_FAX,80)  Picture "@R 9999-9999"  

		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0016,25)+":" // "CEP " 
		@ nLi,PCol()+1	PSay PadR((cSUS)->US_CEP,80)  Picture "@R 99999-999"  
		@ nLi,Limite/2 	PSay PadR(STR0022,25)+":" // "E-mail " 
		@ nLi,PCol()+1	PSay PadR((cSUS)->US_EMAIL,80)  
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0027,25)+":" // "ORIGEM " 
		nPos := Ascan(aUS_ORIGEM,{|x| (cSUS)->US_ORIGEM+"=" $ x})
        If nPos > 0
        	// Atualizo contador por Origem
 	      	aTotOrigem[nPos]++
        	@ nLi,PCol()+1	PSay PadR(IIF(!Empty((cSUS)->US_ORIGEM), aUS_ORIGEM[nPos] ,"") ,80)
        Endif

		@ nLi,Limite/2 	PSay PadR(STR0028,25)+":" // "STATUS " 
		nPos := Ascan(aUS_STATUS,{|x| (cSUS)->US_STATUS+"=" $ x})
        If nPos > 0
        	// Atualizo contador por Status
			aTotStatus[nPos]++
        	@ nLi,PCol()+1	PSay PadR(IIF(!Empty((cSUS)->US_STATUS), aUS_STATUS[nPos] ,"") ,80)
        Endif

		//Exibe os contatos relacionados para o prospect
	    If Mv_Par05 == 1
    		Dbselectarea("AC8")
    		DbsetOrder(2)//Filial + Entidade + Filial da Entidade + Chave 
	   		If Dbseek(xFilial("AC8")+ cSUS + xFilial(cSUS)+ (cSUS)->US_COD+(cSUS)->US_LOJA)
                // Atualizo contador de Prospect com Relacionamento
                nTotRel++
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Controle das Linhas para a quebra de pagina				  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If (nLi+ 8) > nMax
				  nLi := nMax+1 
		  		  TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
				Endif

				TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
   				@ nLi,000		PSay __PrtThinLine()
  				TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
   				@ nLi,000		PSAY STR0026 //"CONTATO                                     DDD    FONE       CELULAR    FAX        FOME COM. 1  FOME COM. 2  ESTADO  E-MAIL"
				TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
				@ nLi,000		PSay __PrtThinLine()
				
    			While !EOF() .AND. cSUS + xFilial(cSUS)+ (cSUS)->US_COD+(cSUS)->US_LOJA == AC8->AC8_ENTIDA + AC8->AC8_FILENT + AllTrim(AC8->AC8_CODENT)  
  				    
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nLi,000		PSay PadR(TkDadosContato(AC8->AC8_CODCON,6),40)					// NOME
					@ nLi,PCol()+4	PSay TkDadosContato(AC8->AC8_CODCON,8) Picture "@R (999)"		// DDD   
					@ nLi,PCol()+2	PSay TkDadosContato(AC8->AC8_CODCON,1) Picture "@R 9999-9999" 	// FONE
					@ nLi,PCol()+2	PSay TkDadosContato(AC8->AC8_CODCON,2) Picture "@R 9999-9999" 	// CELULAR 
					@ nLi,PCol()+2	PSay TkDadosContato(AC8->AC8_CODCON,3) Picture "@R 9999-9999" 	// FAX
					@ nLi,PCol()+2	PSay TkDadosContato(AC8->AC8_CODCON,4) Picture "@R 9999-9999" 	// FOME COM. 1
					@ nLi,PCol()+4	PSay TkDadosContato(AC8->AC8_CODCON,5) Picture "@R 9999-9999" 	// FOME COM. 2
					@ nLi,PCol()+4	PSay PadR(TkDadosContato(AC8->AC8_CODCON,7) ,6) 				// ESTADO
					@ nLi,PCol()+2	PSay PadR(TkDadosContato(AC8->AC8_CODCON,10),40) 				// E-MAIL

    				Dbselectarea("AC8")
    				Dbskip()
    			End
    	    Endif
    	Endif
	Endif

    TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay __PrtFatLine()
	DbSelectArea(cSUS)
	DbSkip()
End


If nTotProspect > 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Controle das Linhas para a quebra de pagina				  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (nLi+ 15) > nMax
	  nLi := nMax+1 
	  TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Totalizadores											  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TkIncLine(@nLi,2,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay PadR(STR0030,40)+":" // "TOTAL DE PROSPECTS " 
	@ nLi,PCol()+1	PSay PadR(nTotProspect,80)    
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Somente sera impresso o total de prospects com relacionamento caso³
	//³o parametro MV_PAR05 estiver como SIM. (Exibe detalhes do contato)³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF nTotRel > 0
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0031,40)+":" // "TOTAL DE PROSPECTS COM RELACIONAMENTO" 
		@ nLi,PCol()+1	PSay PadR(nTotRel,80)   
	Endif
		
	TkIncLine(@nLi,2,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay PadR(STR0042,25) // "ORIGEM " 
	@ nLi,Limite/2	PSay PadR(STR0043,25) // "STATUS" 
	                                      
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay PadR(STR0032,25)+":" // "1=Mailing " 
	@ nLi,PCol()+1	PSay PadR(aTotOrigem[1],80)    
	@ nLi,Limite/2	PSay PadR(STR0037,25)+":" // "1=Classificado" 
	@ nLi,PCol()+1	PSay PadR(aTotStatus[1],80)   
	
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay PadR(STR0033,25)+":" // "2=Campanha " 
	@ nLi,PCol()+1	PSay PadR(aTotOrigem[2],80)    
	@ nLi,Limite/2	PSay PadR(STR0038,25)+":" // "2=Desenvolvimento" 
	@ nLi,PCol()+1	PSay PadR(aTotStatus[2],80)   
	
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay PadR(STR0034,25)+":" // "3=Web " 
	@ nLi,PCol()+1	PSay PadR(aTotOrigem[3],80)    
	@ nLi,Limite/2	PSay PadR(STR0039,25)+":" // "3=Gerente" 
	@ nLi,PCol()+1	PSay PadR(aTotStatus[3],80)   
	
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay PadR(STR0035,25)+":" // "4=Web " 
	@ nLi,PCol()+1	PSay PadR(aTotOrigem[4],80)    
	@ nLi,Limite/2	PSay PadR(STR0040,25)+":" // "4=Gerente" 
	@ nLi,PCol()+1	PSay PadR(aTotStatus[4],80)   
	
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay PadR(STR0036,25)+":" // "5=Evento " 
	@ nLi,PCol()+1	PSay PadR(aTotOrigem[5],80)    
	@ nLi,Limite/2	PSay PadR(STR0041,25)+":" // "5=Cancelado" 
	@ nLi,PCol()+1	PSay PadR(aTotStatus[5],80)   
	                                             
	
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay PadR(" ",25)+" " // " " 
	@ nLi,PCol()+1	PSay PadR(" ",80)    
	@ nLi,Limite/2	PSay PadR(STR0060,25)+":" // "6=Cliente" 
	@ nLi,PCol()+1	PSay PadR(aTotStatus[6],80)   
	
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay __PrtFatLine()
Else
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi+1,000 PSay STR0044 //"Nao ha informacoes para imprimir este relatorio. Verifique os parametros informados."
Endif


Roda(cbCont,cbText,Tamanho)

DbSelectArea(cSUS)
DbCloseArea()
ChkFile(cSUS)

Set Device To Screen
If ( aReturn[5] = 1 )
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()

Return(.T.)
