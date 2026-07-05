/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "DBTREE.CH"
#INCLUDE "MSOLE.CH"
#INCLUDE "FATR600.CH"
#INCLUDE "CRMDEF.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FATR600     ³ Autor ³Eduardo Gomes Junior   ³ Data ³ 30/06/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao de documentos via integracao com WORD.				³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                      	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum					 									³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            	³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FATR600(cTemplate)

Local aArea			:= GetArea()						//Guarda area atual
Local cPais			:= Criavar("AG4_PAIS")				//Pais selecionado
Local cIdioma		:= Criavar("AG4_IDIOMA")			//Idiona selecionado
Local cCodigo		:= SPACE(len(AG1->AG1_CODIGO))		//Codigo do modelo selecionado

Local aComponente	:= {}								//Array para os componentes do modelo selecionado
Local oObrigat 											//Objeto utilizado no Tree  (Obrigatorio)
Local oOpcSelec   										//Objeto utilizado no Tree  (Opcional Selecionado)
Local oOpcNSelec 										//Objeto utilizado no Tree  (Opcional nao selecionado)
Local oTree												//Objeto para o Tree do aComponentes
Local oDlg
Local oPanel
Local lHtml 		:= IsHTML()  // Verifica se e Html

Local cDescri		:= SPACE(10)		//Codigo do modelo selecionado
Local oGet1         

Default cTemplate := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Nao e permitido realizar impressao pelo remote HTML   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lHtml
	FWAvisoHTML()
	Return(.T.)
EndIf 

oDlg := FWDialogModal():New()
	oDlg:SetBackground(.T.) // .T. -> escurece o fundo da janela 
	oDlg:SetTitle(STR0001) //"Impressão de Modelo - Integração com Word"
	oDlg:SetEscClose(.T.)//permite fechar a tela com o ESC
	oDlg:SetSize(250,225) //cria a tela maximizada (chamar sempre antes do CreateDialog)
	oDlg:EnableFormBar(.T.) 
	oDlg:CreateDialog() //cria a janela (cria os paineis)
	oDlg:addCloseButton({|| oDlg:Deactivate() }, STR0035)	//Cria o botão 'Cancelar'

	oPanel := oDlg:getPanelMain()

	oDlg:createFormBar()//cria barra de botoes 

	@ 07,015  	Say STR0008 OF oPanel PIXEL //"Pais"
	@ 06,040  	MSGET cPais	Picture "@!" F3 "SYA" Valid (Empty(cPais) .Or. ExistCpo( "SYA", cPais )) When(IIF(Empty(Alltrim(cPais)),.T.,.F.)) OF oPanel PIXEL
	
	@ 07,072    Say STR0009 OF oPanel  pixel //"Idioma"
	@ 06,097  	MSGET cIdioma Picture "@!" F3 "F8" Valid (Empty(cIdioma) .Or. ExistCpo( "SX5","F8" + cIdioma )) When(IIF(Empty(Alltrim(cIdioma)),.T.,.F.)) OF oPanel  PIXEL
	
	@ 21,015  	SAY STR0003		OF oPanel PIXEL //"Modelo"
	@ 19,040  	MSGET cCodigo	Picture "@!" F3 "AZ1AGR"  Valid Empty(cCodigo) .Or. (U_r600Posic(M->cCodigo,@oGet1,@cDescri).AND. MsgRun(STR0004,STR0016,{||R600Tree(cCodigo,@aComponente,cPais,cIdioma,oTree)})) When(IIF(Empty(Alltrim(cCodigo)),.T.,.F.)) OF oPanel PIXEL //"Carregando modelo ..."
	@ 19,073   	MSGET oGet1 VAR cDescri   When .F.  Size 135,10 OF oPanel PIXEL

	///--- tree
	oTree := DbTree():New(050,015,185,210,oPanel,{||R600MudaStatus(aComponente,@oTree:GetCargo(),oTree),oTree:Refresh()},,.T.,.F.)
	
	///--- legenda
	oObrigat 	:= TBitmap():New(002.7,002,008,008,"br_vermelho",,.T.,oPanel)
	@ 37,025 	SAY STR0005		OF oPanel PIXEL //"Item Obrigatorio"
	
	oOpcSelec	:= TBitmap():New(002.7,009,008,008,"br_azul",,.T.,oPanel)
	@ 37,081  	SAY STR0006		OF oPanel PIXEL //"Opcional Selecionado"
	
	oOpcNSelec 	:= TBitmap():New(002.7,018,008,008,"br_cinza",,.T.,oPanel)
	@ 37,153  	SAY STR0007	OF oPanel PIXEL //"Opcional nao selecinado"
	
		///--- botoes
	oDlg:AddButton( STR0034,{|| R600Impressao(aComponente,cIdioma,cCodigo,cTemplate),oDlg:Deactivate()  }, STR0034, , .T., .F., .T., )//Fechar

	oDlg:Activate() //Ativa a Janela Modal

RestArea( aArea )

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³R600Tree    ³ Autor ³Eduardo Gomes Junior   ³ Data ³ 30/06/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Monta TREE contento a estrutura de impressa do modelo		³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                      	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cCodigo	   - Modelo selecionado				 				³±±
±±³			 ³ aComponente - Array contendo os componentes da proposta		³±±
±±³			 ³ cPais	   - Pais informado				 					³±±
±±³			 ³ cIdioma     - Idiona informado								³±±
±±³			 ³ oTree	   - Objeto contento o Tree							³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            	³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R600Tree(cCodigo,aComponente,cPais,cIdioma,oTree)

Local nItemArray	:= 0
Local cProcessa		:= "2"

aComponente:={}

If 	Empty(cCodigo) .or. Empty(cPais) .or. Empty(cIdioma)
	Return (.T.)
Endif

oTree:Reset() 			//Limpar a tree
oTree:BeginUpdate() 	//Iniciar Inclusao de itens

oTree:AddTree(PADR(STR0001,TAMSX3("AG3_DESCRI")[1]),.T.,"MENUDOWN","MENURIGHT",,,"!") //"Impressão de Proposta Comercial"

DbSelectArea("AG2")
DbSetOrder(1)
MsSeek(xFilial("AG2")+cCodigo)

cComp  	:=	AG2->AG2_COMPPR //Componente Capitulo
cCompAs	:=  AG2->AG2_COMPAS //Componente Item

DbSelectArea("AG3")
DbSetOrder(1)
MsSeek(xFilial("AG3")+AG2->AG2_COMPPR)

cCompPrDs 	:=AG3->AG3_DESCRI// Descricao do componente capitulo

MsSeek(xFilial("AG3")+AG2->AG2_COMPAS)

cCompAsDs 	:=  AG3->AG3_DESCRI //Descricao do componente item

DbSelectArea("AG4")
DbSetorder(2)

If 	MsSeek(xFilial("AG4")+cCompAs+cPais+cIdioma)
	cRotina 	:=  AG4->AG4_FUNCAO //Rotina que ira realizar a integracao com word
	cAtualiza	:=  AG4->AG4_ATUALI //Se atualiza o documento via web
Else
	oTree:EndTree()
	oTree:EndUpdate()
	Return .F.
Endif

If 	Empty(AG4->AG4_VLDCOM)
	cProcessa:=AG2->AG2_OBRIGA
Else
	cProcessa:=&(AllTrim(AG4->AG4_VLDCOM))
Endif

If 	cProcessa <> "3"
	
	nItemArray:=1
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Estrutura do aComponente:    ³
	//³------------------------------³
	//³01 Cod Capitulo               ³
	//³02 Nm Capitulo                ³
	//³03 Nm Componente              ³
	//³04 Obrigat                    ³
	//³05 DocWord                    ³
	//³06 cCargo                     ³
	//³07 Vai para o Dot?[.T./.F.]   ³
	//³08 Rotina que aciona macros   ³
	//³09 Quantidade Niveis do doc   ³
	//³10 Quantidade SubNiveis do doc³
	//³11 Incrementa Cap [1|2]       ³
	//³12 Atualiza o doc via web     ³
	//³13 Cod Componente associado   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aadd(aComponente,{cComp,cCompPrDs,cCompAsDs,cProcessa,alltrim(AG4->AG4_DOCWOR),chr(nItemArray+33),iif(cProcessa=="1",.T.,.F.),AllTrim(cRotina),AG4->AG4_NIVEL,AG4->AG4_SUBNIV,AG2->AG2_INCCAP,cAtualiza,cCompAs})
	
	///-> Alimenta 1.o item da Tree
	oTree:AddTree(aComponente[nItemArray][2],.T.,"MENUDOWN","MENURIGHT",,,"!")
	oTree:AddTreeItem(aComponente[nItemArray][3],,R600Status(aComponente,aComponente[nItemArray][6]),chr(nItemArray+33))
Endif

cComp   	:=	AG2->AG2_COMPPR

AG2->(DbSkip())

While cCodigo == AG2->AG2_COD .and. AG2->(!Eof())
	
	DbSelectArea("AG3")
	DbSetOrder(1)
	MsSeek(xFilial("AG3")+AG2->AG2_COMPPR)
	
	cCompPrDs 	:=AG3->AG3_DESCRI// Descricao do componente capitulo
	
	MsSeek(xFilial("AG3")+AG2->AG2_COMPAS)
	
	cCompAsDs 	:=  AG3->AG3_DESCRI //Descricao do componente item
	
	DbSelectArea("AG4")
	DbSetorder(2)
	
	If 	MsSeek(xFilial("AG4")+AG2->AG2_COMPAS+cPais+cIdioma)
		cRotina 	:=  AG4->AG4_FUNCAO //Rotina que ira realizar a integracao com word
		cAtualiza	:=  AG4->AG4_ATUALI //Se atualiza o documento via web
	Else
		oTree:EndTree()
		oTree:EndUpdate()
		//"Este modelo não está disponível para impressao nesse PAIS/IDIOMA. Tradução não encontrada para: "####"Atencao"
		MsgAlert(STR0012 + cCompAsDs, STR0002)
	Endif
	
	cCompPr		:=  AG2->AG2_COMPPR
	cCompAs		:=	AG2->AG2_COMPAS
	
	If 	Empty(AG4->AG4_VLDCOM)
		cProcessa:=AG2->AG2_OBRIGA
	Else
		cProcessa:=&(AllTrim(AG4->AG4_VLDCOM))
	Endif
	
	If 	cProcessa <> "3"
		
		nItemArray++
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Estrutura do aComponente:    ³
		//³------------------------------³
		//³01 Cod Capitulo               ³
		//³02 Nm Capitulo                ³
		//³03 Nm Componente              ³
		//³04 Obrigat                    ³
		//³05 DocWord                    ³
		//³06 cCargo                     ³
		//³07 Vai para o Dot?[.T./.F.]   ³
		//³08 Rotina que aciona macros   ³
		//³09 Quantidade Niveis do doc   ³
		//³10 Quantidade SubNiveis do doc³
		//³11 Incrementa Cap [1|2]       ³
		//³12 Atualiza o doc via web     ³
		//³13 Cod Componente associado   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		//Adiciona cada Item do BD de modelo para o Array
		aadd(aComponente,{cCompPr,cCompPrDs,cCompAsDs,cProcessa,alltrim(AG4->AG4_DOCWOR),chr(nItemArray+33),iif(cProcessa=="1",.T.,.F.),AllTrim(cRotina),AG4->AG4_NIVEL,AG4->AG4_SUBNIV,AG2->AG2_INCCAP,cAtualiza,cCompAs})
		//Se o componente capitulo for diferente, encerra o capitulo atual da tree e abre um novo
		If 	cComp<> AG2->AG2_COMPPR
			If 	nItemArray > 1
				oTree:EndTree()
			Endif
			oTree:AddTree(aComponente[nItemArray][2],.T.,"MENUDOWN","MENURIGHT",,,"!")
		Endif
		
		// Adiciona Item no capitulo
		oTree:AddTreeItem(aComponente[nItemArray][3],,R600Status(aComponente,aComponente[nItemArray][6]),chr(nItemArray+33))
	Endif
	
	cComp := AG2->AG2_COMPPR
	AG2->(DbSkip())
	
Enddo

oTree:EndTree()
oTree:EndUpdate()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³R600Tree    ³ Autor ³Eduardo Gomes Junior   ³ Data ³ 30/06/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Status do componente											³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                      	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aComponente - Array contendo os componentes do modelo		³±±
±±³			 ³ oTree	   - Objeto contento o Tree							³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            	³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R600Status(aComponente,cItens)

Local cRetorno	:= ""
Local nPos		:= Ascan(aComponente,{|x|x[6]==cItens})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Estrutura do aComponente:    ³
//³------------------------------³
//³01 Cod Capitulo               ³
//³02 Nm Capitulo                ³
//³03 Nm Componente              ³
//³04 Obrigat                    ³
//³05 DocWord                    ³
//³06 cCargo                     ³
//³07 Vai para o Dot?[.T./.F.]   ³
//³08 Rotina que aciona macros   ³
//³09 Quantidade Niveis do doc   ³
//³10 Quantidade SubNiveis do doc³
//³11 Incrementa Cap [1|2]       ³
//³12 Atualiza o doc via web     ³
//³13 Cod Componente associado   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If cItens == "!" .or. cItens == " " .or. nPos == 0
	Return Iif (nFunc == 1,NIL,cRetorno)
ElseIf aComponente[nPos][4]=="1"
	Return ("br_vermelho") //-> Bitmap do Componente obrigatorio
ElseIf aComponente[nPos][4]=="2" .and. aComponente[nPos][7]== .F.
	Return("br_cinza")  //-> Bitmap do componente opcional não selecionado
ElseIf aComponente[nPos][4]=="2" .and. aComponente[nPos][7]== .T.
	Return ("br_azul")//-> Bitmap do componente opcional selecionado
Else
	//-> Se tiver alguma coisas diferente no BD, o bitmap sera de componente nao selecionado,
	//	porem nao conseguira selecionar o componente
	Return ("br_cinza")
Endif

//Atualiza Tree
oTree:Refresh()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³R600MudaStatus³ Autor ³Eduardo Gomes Junior   ³ Data ³ 30/06/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Muda o status do componente.									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aComponente - Array contendo os componentes do modelo		  ³±±
±±³			 ³ cItens	   - Item do Tree posicionando						  ³±±
±±³			 ³ oTree	   - Objeto contento o Tree							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R600MudaStatus(aComponente,cItens,oTree)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Estrutura do aComponente:    ³
//³------------------------------³
//³01 Cod Capitulo               ³
//³02 Nm Capitulo                ³
//³03 Nm Componente              ³
//³04 Obrigat                    ³
//³05 DocWord                    ³
//³06 cCargo                     ³
//³07 Vai para o Dot?[.T./.F.]   ³
//³08 Rotina que aciona macros   ³
//³09 Quantidade Niveis do doc   ³
//³10 Quantidade SubNiveis do doc³
//³11 Incrementa Cap [1|2]       ³
//³12 Atualiza o doc via web     ³
//³13 Cod Componente associado   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nPos:=Ascan(aComponente,{|x|x[6]==cItens})

If 	cItens == "!" .or. cItens == " "
	//-> Se for capitulo, ou houver dados errados no BD, não fara nada
	Return
ElseIf 	aComponente[nPos][4]=="1"
	//-> Se for item obrigatorio, chumbar que o componente ira para o Doc, mesmo que ja estaja marcado
	aComponente[nPos][7]:= .T.
ElseIf 	aComponente[nPos][7]== .F. .and. aComponente[nPos][4]=="2"
	//-> troca componente opcional de desmarcado para marcado
	aComponente[nPos][7]:= .T.
	//-> muda bitmap de desmarcado para marcado
	oTree:ChangeBMP("br_azul","br_azul")
	oTree:Refresh()
ElseIf aComponente[nPos][7]== .T. .and. aComponente[nPos][4]=="2"
	//-> troca componente opcional de marcado para desmarcado
	aComponente[nPos][7]:= .F.
	//-> muda bitmap de marcado para desmarcado
	oTree:ChangeBMP("br_cinza","br_cinza")
	oTree:Refresh()
Else
	//-> caso haja erro no cadastro, o componente nao ira para o dot e permanecera desmarcado
	aComponente[nPos][7]:= .F.
	oTree:ChangeBMP("br_cinza","br_cinza")
Endif

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³R600Impressao ³ Autor ³Eduardo Gomes Junior   ³ Data ³ 30/06/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Realiza a impressao do modelo (DOT) selecionado.				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum					 									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R600Impressao(aComponente,cIdioma,cCodigo,cTemplate)

Local aArea			:= GetArea()													//Aguarda area atual
Local hWord 		:= Nil															//Conexao com o Word
Local cPathOri		:= AllTrim(SuperGetMv("MV_PATWORD"))							//Diretorio que esta todos componentes ( c:\wordstd )
Local cPathFinal 	:= AllTrim(SuperGetMv("MV_PATTERM"))							//Diretorio que sera gravado o documento final ( c:\wordtmp )
Local cPathServer	:= Alltrim(SuperGetMv("MV_DOCAR"))								//Diretorio que estao os DOTS originais ("\Sigaadv\WORD\DOC_AR\")
Local cDotMacros	:= IIf(cTemplate == "VistoriaTec",Alltrim(SuperGetMv("MV_VISTDOT",.F.,"CRM-Exec_Macro_Vistoria.dot")),Alltrim(SuperGetMv("MV_NOMEDOT",,"CRM-Exec_Macro.dot")))	//Documento WORD contendo todas as macro usadas na impressao do modelo
Local lMsDocument	:= SuperGetMv("MV_FTMSDOC",,.F.)                               //Define se a proposta comercial sera vinculada ao banco de conhecimento
Local lFR600Val		:= ExistBlock("FR600VAL") 										//Ponto de entrada para validacao de usuario
Local lRet600Val	:= .T. 															//Trata o retorno do ponto de entrada
Local cRevisao		:= ''                                                           //Revisao da Proposta Comercial
Local cArqUsr		:= ''                                                           //cPathFinal+cNomeWord+cRevisao+'.doc'
LocaL nCount 		:= 1                                                            //Contador utilizado na revisao do documento

Local lPdf 		:= IIf( Type("M->AD1_PROVEN")<>"U", U_R600ImpPDF(), .F. ) 	//Verifica se o tipo de impressão será PDF

Private cNomeWord	:= STR0010														// Nome do arquivo Word gerado

If	!File(cPathServer+cDotMacros)
	//"Modelo do WORD :"###"" usado na integração não encontrado no servidor. Impressão cancelada !"###"Atenção"
	MsgAlert(STR0013+cDotMacros+STR0014,STR0002) //""###"Atenção"
	Return NIL
Endif

If	lFR600Val
	//Passa por parametro o numero da proposta comercial
	lRet600Val := ExecBlock( "FR600VAL",.F.,.F.)
	If 	ValType(lRet600Val) <> "L"
		lRet600Val := .T.
	EndIf
Endif

If	!lRet600Val
	Return(.T.)
Endif

//"Verificando documentos na estaçãoo..."###"Aguarde"
Processa({|| R600Dots(aComponente,cPathOri,cPathFinal,cPathServer,cDotMacros)},STR0015,STR0016,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Cria link com o WORD ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
hWord := OLE_CreateLink("TMSOLEWORD97")

OLE_SetProperty(hWord,oleWdWindowState,"MAX" )
OLE_SetProperty(hWord,oleWdVisible,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Reune componentes que farao parte do documento final ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
R600IniDoc(@hWord,cPathOri,cDotMacros,aComponente)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Numera os capitulos ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
R600Numera(aComponente,hWord)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa os programas que alimentam as DOCVARIABLE e MACROS para tabelas. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
R600Macros(aComponente,hWord)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Atualiza os campos de DocVariable ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
OLE_UpDateFields(hWord)


If lMsDocument
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz revisao do documento pelo banco de conhecimento. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	DbSelectArea("ACB")
	DbSetOrder(2)
	
	If lPdf
		If !DbSeek(xFilial("ACB")+Upper(cNomeWord+'.pdf'))
			OLE_SaveAsFile(hWord,cPathFinal+cNomeWord,,,.F.,oleWdFormatDocument)
			MsgRun(STR0031,STR0032,{||U_ConvPDF(hWord,cPathFinal,cNomeWord)}) //"Aguarde"##Impressão em PDF...
			MsgInfo(cNomeWord+STR0017+cPathFinal,STR0002)
		Else
			While ACB->(!Eof())
				cRevisao := ' - R'+cValToChar(nCount)
				If !DbSeek(xFilial("ACB")+Upper(cNomeWord+cRevisao+'.pdf'))
					OLE_SaveAsFile(hWord,cPathFinal+cNomeWord+cRevisao,,,.F.,oleWdFormatDocument)
					MsgRun(STR0031,STR0032,{||U_ConvPDF(hWord,cPathFinal,cNomeWord,cRevisao)})//"Aguarde"##Impressão em PDF...
					MsgInfo(cNomeWord+cRevisao+STR0017+cPathFinal,STR0002)
					Exit
				EndIf
				nCount++
				ACB->(DbSkip())
			End
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava a proposta comercial no Banco de Conhecimento. ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cArqUsr := cPathFinal+cNomeWord+cRevisao+'.pdf'
		R600GrvBco(cArqUsr)
		
	Else		
		If !DbSeek(xFilial("ACB")+Upper(cNomeWord+'.doc'))
			OLE_SaveAsFile(hWord,cPathFinal+cNomeWord,,,.F.,oleWdFormatDocument)
			MsgInfo(cNomeWord+STR0017+cPathFinal,STR0002)
		Else
			While ACB->(!Eof())
				cRevisao := ' - R'+cValToChar(nCount)
				If !DbSeek(xFilial("ACB")+Upper(cNomeWord+cRevisao+'.doc'))
					OLE_SaveAsFile(hWord,cPathFinal+cNomeWord+cRevisao,,,.F.,oleWdFormatDocument)
					MsgInfo(cNomeWord+cRevisao+STR0017+cPathFinal,STR0002)
					Exit
				EndIf
				nCount++
				ACB->(DbSkip())
			End
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Grava a proposta comercial no Banco de Conhecimento. ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
		cArqUsr := cPathFinal+cNomeWord+cRevisao+'.doc'
		R600GrvBco(cArqUsr)
		
	EndIf
	
Else
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Salva o documento ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	OLE_SaveAsFile(hWord,cPathFinal+cNomeWord,,,.F.,oleWdFormatDocument)
	
	If lPdf
		MsgRun(STR0031,STR0032,{||U_ConvPDF(hWord,cPathFinal,cNomeWord)})//"Aguarde"##Impressão em PDF...
	EndIf
	
	MsgInfo(cNomeWord+STR0017+cPathFinal,STR0002) //" salva no diretório:"###"Atenção"
	
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha o link com o WORD³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
hWord := OLE_CloseLink()

RestArea(aArea) //Restaura a area


Return cArqUsr

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³R600IniDoc	³ Autor ³Eduardo Gomes Junior   ³ Data ³ 30/06/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Reune os componentes que farao parte do documento final		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ hWord 		- Conexao com WORD								  ³±±
±±³			 ³ cPathOri	   	- Diretorio que esta todos componentes			  ³±±
±±³			 ³ cDotMacros	- Documento WORD contendo todas as macro 		  ³±±
±±³			 ³ aComponente	- Array contendo os componentes do modelo		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R600IniDoc(hWord,cPathOri,cDotMacros,aComponente)

Local i
Local nComponente	:= 0
Local cCapitulo		:= " "

Ole_NewFile(hWord,cPathOri+cDotMacros)

Ole_SetDocumentVar(hWord,'cDiretorio',alltrim(cPathOri))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Estrutura do aComponente:    ³
//³------------------------------³
//³01 Cod Capitulo               ³
//³02 Nm Capitulo                ³
//³03 Nm Componente              ³
//³04 Obrigat                    ³
//³05 DocWord                    ³
//³06 cCargo                     ³
//³07 Vai para o Dot?[.T./.F.]   ³
//³08 Rotina que aciona macros   ³
//³09 Quantidade Niveis do doc   ³
//³10 Quantidade SubNiveis do doc³
//³11 Incrementa Cap [1|2]       ³
//³12 Atualiza o doc via web     ³
//³13 Cod Componente associado   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

For i := 1 To Len(aComponente)
	
	If	!Empty(alltrim(aComponente[i][5])) .and. aComponente[i][7]==.T.
		
		nComponente++
		OLE_SetDocumentVar(hWord,'cComponente'+alltrim(str(nComponente)),ALLTRIM(aComponente[i][5]))
		
		IF 	I==1
			OLE_SetDocumentVar(hWord,'nAltCap'+alltrim(str(nComponente)),"0")
		Else
			If 	aComponente[ i,1 ] != cCapitulo
				cCapitulo 	:= alltrim( aComponente[ i ,1 ] )
				OLE_SetDocumentVar(hWord,'nAltCap'+alltrim(str(nComponente)),"1")
			Else
				OLE_SetDocumentVar(hWord,'nAltCap'+alltrim(str(nComponente)),"0")
			EndIf
		Endif
		
	Endif
	
Next i

Ole_SetDocumentVar(hWord,'nComponente',alltrim(str(nComponente)))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Macro para passar um array com nome dos dots ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
OLE_ExecuteMacro(hWord,"AlimentaArray")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Macro para juntar os componentes que irao para o documento final³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
OLE_ExecuteMacro(hWord,"Insere_Componente")

Return nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³R600Dots	 	³ Autor ³Eduardo Gomes Junior   ³ Data ³ 30/06/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida a existencia dos DOTS na estacao de trabalho 			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aComponente	- Array contendo os componentes do modelo		  ³±±
±±³			 ³ cPathOri	   	- Diretorio que esta todos componentes			  ³±±
±±³			 ³ cPathFinal	- Diretorio que sera gravado o modelo final 	  ³±±
±±³			 ³ cPathServer	- Diretorio que estao os DOTS originais			  ³±±
±±³			 ³ cDotMacros	- Documento WORD contendo todas as macro 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R600Dots(aComponente,cPathOri,cPathFinal,cPathServer,cDotMacros)

Local i
Local nPosLocal:=0
Local nPosServer:=0
nHandle := fCreate(cPathOri+"TESTE")

If nHandle <> -1 // Testa para ver se consegue ou nao criar o arquivo
	fClose(nHandle)
	fErase(cPathOri+"TESTE") // apaga o arquivo de teste de gravacao
Else
	If	MAKEDIR(cPathOri)!= 0
		//		Aviso(STR0001,STR0026+cPathOri+STR0027,{"OK"}) //"Inconsistencia"###"Nao foi possivel criar diretorio "###".Finalizando ..."
		return nil
	EndIf
EndIf

nHandle := fCreate(cPathFinal+"TESTE")

If nHandle <> -1 // Testa para ver se consegue ou nao criar o arquivo
	fClose(nHandle)
	fErase(cPathFinal+"TESTE") // apaga o arquivo de teste de gravacao
Else
	If	MAKEDIR(cPathFinal)!= 0
		//		Aviso(STR0001,STR0026+cPathFinal+STR0027,{"OK"}) //"Inconsistencia"###"Nao foi possivel criar diretorio "###".Finalizando ..."
		return nil
	EndIf
EndIf


//->Carrega os modelo de documento existentes no Server
aDocServer:=Directory(cPathServer+"*.DOT")
//->Carrega os modelo de documento existentes na maquina do usuario
aDocLocal:=Directory(cPathOri+"*.dot")

// Ordena os arrays de modelos de documentos por ordem de nome
aSort(aDocServer,,,{|x,y| UPPER(x[1]) < UPPER(y[1])})
aSort(aDocLocal,,, {|x,y| UPPER(x[1]) < UPPER(y[1])})

///-> Varre todos os componentes do modelo verificando se existe o modelo na maquina do usario
//	   e se os modelos estao iguais aos que estao no servidos,
//		exceto os que estiverem marcado no cadastro de componente(AG3) para nao atualizar.
ProcRegua(len(aComponente))

For i:=1 to len(aComponente)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Estrutura do aComponente:    ³
	//³------------------------------³
	//³01 Cod Capitulo               ³
	//³02 Nm Capitulo                ³
	//³03 Nm Componente              ³
	//³04 Obrigat                    ³
	//³05 DocWord                    ³
	//³06 cCargo                     ³
	//³07 Vai para o Dot?[.T./.F.]   ³
	//³08 Rotina que aciona macros   ³
	//³09 Quantidade Niveis do doc   ³
	//³10 Quantidade SubNiveis do doc³
	//³11 Incrementa Cap [1|2]       ³
	//³12 Atualiza o doc via web     ³
	//³13 Cod Componente associado   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	IncProc(aComponente[i][3])
	nPosLocal:=aScan(aDocLocal,{|x|alltrim(x[1])==Upper(alltrim(aComponente[i][5]))+".DOT"})
	nPosServer:=aScan(aDocServer,{|x|alltrim(x[1])==Upper(alltrim(aComponente[i][5]))+".DOT"})
	if nPosServer <=0
		MsgStop(Upper(alltrim(aComponente[i][5]))+".DOT"+ STR0011 ) //" não encontrado no servidor."
	Endif
	if aComponente[i][12] <> "2" .and. nPosLocal == 0
		__CopyFile( cPathServer+alltrim(aComponente[i][5])+".DOT" , cPathOri+alltrim(aComponente[i][5])+".DOT" )
	Elseif aComponente[i][12] <> "2" .and. nPosServer > 0 .and. (aDocLocal[nPosLocal][2] != aDocServer[nPosServer][2].or. aDocLocal[nPosLocal][3] != aDocServer[nPosServer][3] .or. aDocLocal[nPosLocal][4] != aDocServer[nPosServer][4])
		__CopyFile( cPathServer+alltrim(aComponente[i][5])+".DOT" , cPathOri+alltrim(aComponente[i][5])+".DOT" )
	Endif
Next

__CopyFile( cPathServer+cDotMacros , cPathOri+cDotMacros  )

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³R600Numera	³ Autor ³Eduardo Gomes Junior   ³ Data ³ 30/06/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Numera os capitulos											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aComponente - Array contendo os componentes do modelo		  ³±±
±±³			 ³ hWord	   - Conexao com WORD								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R600Numera(aComponente,hWord)

Local nCapitulo	:= 0
Local nItem		:= 0
Local nSubitem	:= 0
Local cCapitulo	:= ""
Local nx1
Local nx2
Local nx3

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Estrutura do aComponente:    ³
//³------------------------------³
//³01 Cod Capitulo               ³
//³02 Nm Capitulo                ³
//³03 Nm Componente              ³
//³04 Obrigat                    ³
//³05 DocWord                    ³
//³06 cCargo                     ³
//³07 Vai para o Dot?[.T./.F.]   ³
//³08 Rotina que aciona macros   ³
//³09 Quantidade Niveis do doc   ³
//³10 Quantidade SubNiveis do doc³
//³11 Incrementa Cap [1|2]       ³
//³12 Atualiza o doc via web     ³
//³13 Cod Componente associado   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

For nx1 := 1 to Len( aComponente )
	
	lMarcado 	:= acomponente[nx1,7]
	cIncrementa := alltrim( acomponente[nx1,11] )
	
	///--- verifica componente
	If !lMarcado
		Loop
	Endif
	
	///--- incrementa capitulo
	If 	aComponente[ nx1,1 ] != cCapitulo .and. cIncrementa == "1"
		nCapitulo 	++
		nItem		:= 0
		cCapitulo 	:= alltrim( aComponente[ nx1 ,1 ] )
	EndIf
	
	///--- atribui codigo componente
	cComponente	:= alltrim (aComponente[ nx1,13 ] )
	
	///--- criacao de variaveis -> P99 CAPITULO
	cVWordCap 	:= cComponente
	cConteudo	:= alltrim (str( nCapitulo ) )
	Ole_SetDocumentVar(hWord,cVWordCap,cConteudo+" - ")
	
	nCItem 		:= aComponente[ nx1 , 9 ]
	nCSubitem	:= aComponente[ nx1 , 10 ]
	
	///--- criacao de variaveis -> P99.9 ITEM
	For nx2 := 1 To nCItem
		
		nItem 		++
		cVWordItem	:= cComponente + '.' + alltrim (str( nx2 ) )
		cConteudo	:= alltrim( str( nCapitulo ) )+ '.' + alltrim( str( nItem ) )
		Ole_SetDocumentVar(hWord,cVWordItem,cConteudo+" - ")
		nSubItem	:= 0
		
		///--- criacao de variaveis -> P99.9 ITEM
		For nx3 := 1 To nCSubItem
			
			nSubItem 		++
			cVWordSubItem	:= cComponente + '.' + alltrim( str( nx2 ) ) + '.' + alltrim( str( nx3 ) )
			cConteudo		:= alltrim( str( nCapitulo ) ) + '.' + alltrim( str( nItem ) ) + '.' + alltrim( str( nSubitem ) )
			
			Ole_SetDocumentVar(hWord,cVWordSubItem,cConteudo+" - ")
			
		Next nx3
		
	Next nx2
	
Next nx1

return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³R600Macros	³ Autor ³Eduardo Gomes Junior   ³ Data ³ 30/06/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Executa os programas que alimentam as DOCVARIABLE e MACROS 	  ³±±
±±³			 ³ para tabelas 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aComponente - Array contendo os componentes do modelo		  ³±±
±±³			 ³ hWord	   - Conexao com WORD								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R600Macros(aComponente,hWord)

Local nfuncao:=0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Estrutura do aComponente:    ³
//³------------------------------³
//³01 Cod Capitulo               ³
//³02 Nm Capitulo                ³
//³03 Nm Componente              ³
//³04 Obrigat                    ³
//³05 DocWord                    ³
//³06 cCargo                     ³
//³07 Vai para o Dot?[.T./.F.]   ³
//³08 Rotina que aciona macros   ³
//³09 Quantidade Niveis do doc   ³
//³10 Quantidade SubNiveis do doc³
//³11 Incrementa Cap [1|2]       ³
//³12 Atualiza o doc via web     ³
//³13 Cod Componente associado   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

For nfuncao:=1 To Len(aComponente)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Se o nome do doc nao estiver em branco, estiver marcado para ir para o WORD e tiver 	  ³
	//³nome de rotina no campo AG2_FUNCAO.													  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(alltrim(aComponente[nfuncao][5])) .AND. aComponente[nfuncao][7] == .T. .AND. !Empty(alltrim(aComponente[nfuncao][8]))
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Executa a funcao informada no campo AG4_FUNCAO ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		ExecBlock(aComponente[nfuncao][8],.F.,.F.,{hWord} )
		
	Endif
	
Next nfuncao

Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R600GrvBcoºAutor  ³Vendas CRM          º Data ³  03/01/2011 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gravacao da proposta comercial no banco de conhecimento.    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³FatR600                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function R600GrvBco(cPathUsr)

Local cFile      := ""  					//Nome do arquivo
Local cExten     := "" 						//Extensao do documento
Local aAreaACB	 := ACB->(GetArea())  		//Salva a area atual
Local aAreaAD1   := AD1->(GetArea()) 		//Salva a area atual
Local aAreaAC9   := AC9->(GetArea()) 		//Salva a area atual
Local nReg		 := AD1->(RecNo())  		//Retorna o numero do recno selecionado
Local lMultDir   := .T.  					//Ativa a gravacao em varios niveis de diretorio quando o parametro MV_MULTDIR for .T. e o campo ACB->ACB_PATH for criado.
Local lRet 		 := Ft340CpyObj(cPathUsr) 	//Grava o objeto no Banco de Conhecimento


If lRet
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Transforma o path completo em arquivo / extensao ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	SplitPath(cPathUsr,,,@cFile, @cExten )
	cObjeto := Left(Upper(cFile+cExten ),Len(cPathUsr))
	cCodObj := GetSXENum("ACB","ACB_CODOBJ")
	
	dbSelectArea( "ACB" )
	dbSetOrder(1)
	
	RecLock("ACB",.T.)
	ACB->ACB_FILIAL  := xFilial( "ACB" )
	ACB->ACB_CODOBJ  := cCodObj
	ACB->ACB_OBJETO	 := cObjeto
	ACB->ACB_DESCRI	 :=	cFile
	If MsMultDir()
		ACB->ACB_PATH	:= MsDocPath(lMultDir)
	Endif
	
	ACB->(MsUnLock())
	ACB->(ConfirmSX8())
	
	dbSelectArea("AD1")
	DbGoto(nReg)
	cCodEnt  := PadR(AD1_NROPOR, TamSX3("AC9_CODENT")[1])
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inclui e grava os campos chave                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	RecLock( "AC9", .T. )
	AC9->AC9_FILIAL := xFilial("AC9")
	AC9->AC9_FILENT := xFilial("AD1")
	AC9->AC9_ENTIDA := "AD1"
	AC9->AC9_CODENT := cCodEnt
	AC9->AC9_CODOBJ := cCodObj
	AC9->(MsUnLock())
	
Endif

RestArea(aAreaACB)
RestArea(aAreaAD1)
RestArea(aAreaAC9)

Return(lRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R600TWrd  ºAutor  ³Vendas CRM          º Data ³  01/06/11     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Criacao de um template de proposta comercial para integracao, º±±
±±º          ³com Microsoft Word.                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ R600TWrd                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function R600TWrd()

Local lTempWord 	:= SuperGetMv("MV_TEMPWRD",,.T.)   	//Cria um template para proposta comercial.
Local cPathDot 		:= ' '   								//Caminho onde se encontra os dots salvos no servidor
Local cMacroPdr 	:= 'CRM-Exec_Macro.dot'   				//Arquivo dot que contem as macros que serao utilizado pela funcao de integracao com word.
Local cMacroVt		:= 'CRM-Exec_Macro_Vistoria.dot'		//Arquivo dot que contem as macros da vistoria que serao utilizado pela funcao de integracao com word
Local cPathUsr 		:= 'c:\wordtmp\'  						//Diretorio na maquina do usuario que sera gravado os documento word
Local cPathUsrDot 	:= 'c:\wordstd\' 						//Diretorio na maquina do usuario que sera gravado os dot.
Local cIdioma 		:= ""

Static cCodigo		:= A620NUMSEQ('AG1','AG1_CODIGO')      //Codigo do Modelo
Static cCodVist		:= Soma1(cCodigo)

If lTempWord
	cIdioma := Upper( Left( FWRetIdiom(), 2 ) )
	Do Case
		Case cIdioma == 'ES'
			cPathDot := 'samples\documents\crm\espanhol\'
		Case cIdioma == 'EN'
			cPathDot := 'samples\documents\crm\ingles\'
		Otherwise
			cPathDot := 'samples\documents\crm\portugues\'
	EndCase
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Ajusta os parametros relacionado a integracao com word. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If AllTrim(SuperGetMv("MV_DOCAR")) <> cPathDot
		PutMv("MV_DOCAR",cPathDot)
	EndIf
	
	If AllTrim(SuperGetMv("MV_NOMEDOT")) <> cMacroPdr
		PutMv("MV_NOMEDOT",cMacroPdr)
	EndIf
	If AllTrim(SuperGetMv("MV_VISTDOT",.F.,"")) <> cMacroVt
		PutMv("MV_VISTDOT",cMacroVt)
	EndIf
	If AllTrim(SuperGetMv("MV_PATTERM")) <> cPathUsr
		PutMv("MV_PATTERM",cPathUsr)
	EndIf
	If AllTrim(SuperGetMv("MV_PATWORD")) <> cPathUsrDot
		PutMv("MV_PATWORD",cPathUsrDot)
	EndIf
	
	DbSelectArea("AG1")
	DbSetOrder(1)
	
	If !DbSeek(xFilial("AG1")+cCodigo)
		CriaAG1()
	EndIf
	
	DbSelectArea("AG2")
	DbSetOrder(1)
	
	If !DbSeek(xFilial("AG2")+cCodigo)
		CriaAG2()
	EndIf
	
	DbSelectArea("AG3")
	DbSetOrder(1)
	CriaAG3()

	DbSelectArea("AG4")
	DbSetOrder(1)
	CriaAG4()
		
	PutMv("MV_TEMPWRD",.F.)
	
EndIf


Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaAG1   ºAutor  ³Vendas CRM          º Data ³  01/06/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Criacao do cabecalho do modelo.                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ R600TWrd                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CriaAG1()

DbSelectArea("AG1")
DbSetOrder(1)

RecLock("AG1", .T. )
AG1->AG1_FILIAL := xFilial("AG1")
AG1->AG1_CODIGO := cCodigo
AG1->AG1_DESCRI := STR0018 //TEMPLATE DE PROPOSTA COMERCIAL
AG1->(MsUnLock())

RecLock("AG1", .T. )
AG1->AG1_FILIAL := xFilial("AG1")
AG1->AG1_CODIGO := cCodVist
AG1->AG1_DESCRI := STR0027 //TEMPLATE DE VISTORIA TECNICA
AG1->(MsUnLock())

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaAG2   ºAutor  ³Vendas CRM          º Data ³  01/06/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Criacao dos itens do modelo.                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ R600TWrd                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CriaAG2()

Local aAG2 	:= {}
Local aAG2V	:= {}
Local nX	:= 0
Local nY	:= 0

aAG2 := {{cCodigo,'001',STR0018,'P01','P02','1','2'},;
{cCodigo,'002',STR0018,'P01','P03','1','2'},;
{cCodigo,'003',STR0018,'P01','P04','1','2'},;
{cCodigo,'004',STR0018,'P01','P05','1','2'},;
{cCodigo,'005',STR0018,'P01','P06','1','2'},;
{cCodigo,'006',STR0018,'P01','P07','1','2'}}

aAG2V := {{cCodVist,'001',STR0027,'V01','V02','1','2'},;
{cCodVist,'002',STR0027,'V01','V03','1','2'}}

DbSelectArea("AG2")
DbSetOrder(1)

For nX := 1 To Len(aAG2)
	RecLock("AG2",.T.)
	AG2->AG2_FILIAL := xFilial("AG2")
	AG2->AG2_COD    := aAG2[nX][1]
	AG2->AG2_ORDEM  := aAG2[nX][2]
	AG2->AG2_DESCRI := aAG2[nX][3]
	AG2->AG2_COMPPR := aAG2[nX][4]
	AG2->AG2_COMPAS := aAG2[nX][5]
	AG2->AG2_OBRIGA := aAG2[nX][6]
	AG2->AG2_INCCAP := aAG2[nX][7]
	AG2->(MsUnlock())
Next nX

For nY := 1 To Len(aAG2V)
	RecLock("AG2",.T.)
	AG2->AG2_FILIAL := xFilial("AG2")
	AG2->AG2_COD    := aAG2V[nY][1]
	AG2->AG2_ORDEM  := aAG2V[nY][2]
	AG2->AG2_DESCRI := aAG2V[nY][3]
	AG2->AG2_COMPPR := aAG2V[nY][4]
	AG2->AG2_COMPAS := aAG2V[nY][5]
	AG2->AG2_OBRIGA := aAG2V[nY][6]
	AG2->AG2_INCCAP := aAG2V[nY][7] 
	AG2->(MsUnlock())
Next nY

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaAG3   ºAutor  ³Vendas CRM          º Data ³  01/06/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Criacao do cabecalho do componente.                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ R600TWrd                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CriaAG3()

Local aAG3  	:= {}
Local aAG3V		:= {}
Local nX		:= 0
Local nW		:= 0
Local lNewReg	:= .F.

aAG3 := {{'P01',STR0019,'1','1',0,0},;
{'P02',STR0020,'2','1',0,0},;
{'P03',STR0021,'2','1',0,0},;
{'P04',STR0022,'2','1',0,0},;
{'P05',STR0023,'2','1',0,0},;
{'P06',STR0024,'2','1',0,0},;
{'P07',STR0025,'2','1',0,0}}

aAG3V := {{'V01',STR0028,'1','1',0,0},;
{'V02',STR0029,'2','1',0,0},;
{'V03',STR0030,'2','1',0,0}}

DbSelectArea("AG3")
DbSetOrder(1)

For nX := 1 To Len(aAG3)
	lNewReg := AG3->( !DbSeek( xFilial( "AG3" ) + aAG3[nX][1] ) )

	RecLock( "AG3", lNewReg )
	AG3->AG3_FILIAL	:= xFilial("AG3")
	AG3->AG3_CODIGO	:= aAG3[nX][1]
	AG3->AG3_DESCRI	:= aAG3[nX][2]
	AG3->AG3_TIPO	:= aAG3[nX][3]
	AG3->AG3_ATUALI	:= aAG3[nX][4]
	AG3->AG3_NIVEL	:= aAG3[nX][5]
	AG3->AG3_SUBNIV	:= aAG3[nX][6]
	AG3->(MsUnlock())
Next nX

For nW := 1 To Len(aAG3V)
	lNewReg := AG3->( !DbSeek( xFilial( "AG3" ) + aAG3V[nW][1] ) )
	RecLock( "AG3", lNewReg )
	AG3->AG3_FILIAL	:= xFilial("AG3")
	AG3->AG3_CODIGO	:= aAG3V[nW][1]
	AG3->AG3_DESCRI	:= aAG3V[nW][2]
	AG3->AG3_TIPO	:= aAG3V[nW][3]
	AG3->AG3_ATUALI	:= aAG3V[nW][4]
	AG3->AG3_NIVEL	:= aAG3V[nW][5]
	AG3->AG3_SUBNIV	:= aAG3V[nW][6]
	AG3->(MsUnlock())
Next nW

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaAG3   ºAutor  ³Vendas CRM          º Data ³  01/06/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Criacao dos itens do componente.                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ R600TWrd                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CriaAG4()

Local aAG4 	  := {}
Local aAG4V	  := {}
Local nX 	  := 0
Local nZ	  := 0
Local lNewReg := .F.
Local cIdioma := ""

cIdioma := Upper( Left( FWRetIdiom(), 2 ) )
Do Case
	Case cIdioma == 'ES'
		aAG4 :=  {{'P01','','','','','','',0,0},;
		{'P02','01','105','003','','CRM01-CAR_SPA','1',0,0},;  
		{'P03','01','105','003','','CRM02-CARTA_SPA','1',0,0},;  
		{'P04','01','105','003','FT600EXE','CRM03-PROPUESTA_SPA','1',0,0},;    
		{'P05','01','105','003','','CRM04-SERVICIOS_SPA','1',0,0},;  
		{'P06','01','105','003','','CRM05-CONDICION_PAGO_SPA','1',0,0},;  
		{'P07','01','105','003','','CRM06-ACEPTACION_SPA','1',0,0}}   
		aAG4V :=  {{'V01','','','','','','',0,0},;
		{'V02','01','105','003','','CRM07-CAR_VIST_SPA','1',0,0},;  
		{'V03','01','105','003','FV600EXE','CRM08-ESTUDIO_SPA','1',0,0}}
	Case cIdioma == 'EN'
		aAG4 :=  {{'P01','','','','','','',0,0},;
		{'P02','01','105','002','','CRM01-CAPA_ENG','1',0,0},;  
		{'P03','01','105','002','','CRM02-LETTER_ENG','1',0,0},;  
		{'P04','01','105','002','FT600EXE','CRM03-PROPOSAL_ENG','1',0,0},;    
		{'P05','01','105','002','','CRM04-SERVICE_ENG','1',0,0},;  
		{'P06','01','105','002','','CRM05-PAYMENT_TERM_ENG','1',0,0},;  
		{'P07','01','105','002','','CRM06-ACCEPTANCE_ENG','1',0,0}}   
		aAG4V :=  {{'V01','','','','','','',0,0},;
		{'V02','01','105','002','','CRM07-CAPA_VIST_ENG','1',0,0},;  
		{'V03','01','105','002','FV600EXE','CRM08-SURVEY_ENG','1',0,0}}
	Otherwise
		aAG4 :=  {{'P01','','','','','','',0,0},;
		{'P02','01','105','001','','CRM01-CAPA_POR','1',0,0},;  
		{'P03','01','105','001','','CRM02-CARTA_POR','1',0,0},;  
		{'P04','01','105','001','FT600EXE','CRM03-PROPOSTA_POR','1',0,0},;   
		{'P05','01','105','001','','CRM04-SERVICOS_POR','1',0,0},;  
		{'P06','01','105','001','','CRM05-COND_PAGAMENTO_POR','1',0,0},;  
		{'P07','01','105','001','','CRM06-ACEITE_POR','1',0,0}}
		aAG4V :=  {{'V01','','','','','','',0,0},;
		{'V02','01','105','001','','CRM07-CAPA_VIST_POR','1',0,0},;  
		{'V03','01','105','001','FV600EXE','CRM08-VISTORIA_POR','1',0,0}}
EndCase


DbSelectArea("AG4")
DbSetOrder(1)

For nX := 1 To Len(aAG4)
	lNewReg := AG4->( !DbSeek( xFilial( "AG4" ) + aAG4[nX][1] + aAG4[nX][2] ) )

	RecLock( "AG4", lNewReg )
	AG4->AG4_FILIAL := xFilial("AG4")
	AG4->AG4_CODIGO := aAG4[nX][1]
	AG4->AG4_ITEM   := aAG4[nX][2]
	AG4->AG4_PAIS   := aAG4[nX][3]
	AG4->AG4_IDIOMA := aAG4[nX][4]
	AG4->AG4_FUNCAO := aAG4[nX][5]
	AG4->AG4_DOCWOR := aAG4[nX][6]
	AG4->AG4_ATUALI := aAG4[nX][7]
	AG4->AG4_NIVEL  := aAG4[nX][8]
	AG4->AG4_SUBNIV := aAG4[nX][9]
	AG4->(MsUnlock())
Next nX

For nZ := 1 To Len(aAG4V)
	lNewReg := AG4->( !DbSeek( xFilial( "AG4" ) + aAG4V[nZ][1] + aAG4V[nZ][2] ) )
	RecLock( "AG4", lNewReg )
	AG4->AG4_FILIAL := xFilial("AG4")
	AG4->AG4_CODIGO := aAG4V[nZ][1]
	AG4->AG4_ITEM   := aAG4V[nZ][2]
	AG4->AG4_PAIS   := aAG4V[nZ][3]
	AG4->AG4_IDIOMA := aAG4V[nZ][4]
	AG4->AG4_FUNCAO := aAG4V[nZ][5]
	AG4->AG4_DOCWOR := aAG4V[nZ][6]
	AG4->AG4_ATUALI := aAG4V[nZ][7]
	AG4->AG4_NIVEL  := aAG4V[nZ][8]
	AG4->AG4_SUBNIV := aAG4V[nZ][9]
	AG4->(MsUnlock())
Next nZ

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R600ImpPDF   ºAutor  ³CRM      			 º Data ³  07/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica se o tipo de impressão é PDF						    º±±
±±º          ³ 		                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FATR600                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R600ImpPDF()
Local lRetorno	:= .F.
Local cTipImp	:= M->AD1_PROVEN		

//Verifica no Processo de Venda(Tabela AC1) se o tipo de impressão é 2=PDF

DbSelectArea("AC1")
DbSetOrder(1) // AC1_FILIAL+AC1_PROVEN
If DbSeek(xFilial("AC1")+cTipImp)
	If AC1->AC1_TPIMP == "2"
		lRetorno := .T.
	EndIf	
EndIf	

Return(lRetorno)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ConvPDF   ºAutor  ³CRM      			 º Data ³  07/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao de proposta em PDF 								    º±±
±±º          ³ 		                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FATR600                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ConvPDF(hWord,cPathFinal,cNomeWord,cRevisao)

Default cRevisao	:= ""

// Salva com PDF
wdFormatPDF = '17' //' PDF format.

If Empty(cRevisao)
	OLE_SaveAsFile(hWord,cPathFinal+cNomeWord+'.pdf',,,.F.,wdFormatPDF)
	ShellExecute("open",cPathFinal+cNomeWord+'.pdf',"","",5) // 5=SW_SHOW
	
	// Fecha conexao com OLE
	OLE_CloseFile(hWord)
	hWord := OLE_CloseLink()

	DELETE FILE &cPathFinal+Alltrim(cNomeWord)+'.doc'
	
Else
	OLE_SaveAsFile(hWord,cPathFinal+cNomeWord+cRevisao+'.pdf',,,.F.,wdFormatPDF)
	ShellExecute("open",cPathFinal+cNomeWord+cRevisao+'.pdf',"","",5) // 5=SW_SHOW
	
	// Fecha conexao com OLE
	OLE_CloseFile(hWord)
	hWord := OLE_CloseLink()

	DELETE FILE &cPathFinal+Alltrim(cNomeWord+cRevisao)+'.doc'
	
EndIf

Return



//-----------------------------------------------------------------------------
/*/{Protheus.doc} r600Agrp 

Consulta específica para posicionar o modelo .DOT  na tabela AG1 - Se existir 
cadastrado Regras Comerciais x Dots (AZ1), posiciona se existe na tabela 
caso ao contrario, posiciona diretamente na AG1.

@sample		U_r600Agrp()

@return		lRet - Verifica se existe o modelo na tabela AG1

@author		Aline Sebrian Damasceno
@since		24/06/2015
@version	12.1.6
/*/
//------------------------------------------------------------------------------
User Function r600Agrp()
Local 	cQuery 		:= ""
Local 	 lRet       := .F.
Local   aCampos     := {}
Local   oDlg        := Nil
Local 	oColEnt     := Nil
Local   oBrwMark    := Nil
Local   oPanel      := Nil

Static  cR600Agrp  := ""  //Variavel que receberá o valor do campo, para ser retornada pela função "U_r600RetGr()" na consulta padrão
 		
BeginSQL Alias "TRB" 		
Select AG1_CODIGO, AG1_DESCRI 
  From  %Table:AZ1%  AZ1,  %Table:ADZ%  ADZ ,  %Table:AG1%  AG1
  Where AZ1.%NotDel%   
    And ADZ.%NotDel%
    And AG1.%NotDel%      
    And AZ1.AZ1_FILIAL = %xFilial:AZ1%
    And ADZ.ADZ_FILIAL = %xFilial:ADZ%
    And AG1.AG1_FILIAL = %xFilial:AG1%
    And ADZ.ADZ_CODAGR = AZ1.AZ1_CODAGR 
    And ADZ.ADZ_CODNIV = AZ1.AZ1_CODNIV 
    And AZ1.AZ1_CODDOT = AG1.AG1_CODIGO 
    And ADZ.ADZ_PROPOS = %Exp:ADY->ADY_PROPOS%
EndSql
		
If TRB->(EOF()) 	   
	AG1->(dbGoTop())
	Do While !AG1->(Eof()) 
		AAdd( aCampos,{AG1->AG1_CODIGO,AG1->AG1_DESCRI} )
		AG1->( DbSkip())
	EndDo
Else   
	Do While TRB->(!EOF()) 
		AAdd( aCampos,{TRB->AG1_CODIGO,TRB->AG1_DESCRI} )
		TRB->( DbSkip())
	EndDo 
EndIf

TRB->(dbCloseArea())
       
oDlg := FWDialogModal():New()
		oDlg:SetBackground(.F.) // .T. -> escurece o fundo da janela 
		oDlg:SetTitle(STR0033)//"Campo de Retorno" 
		oDlg:SetEscClose(.T.)//permite fechar a tela com o ESC
		oDlg:SetSize(200,300) //cria a tela maximizada (chamar sempre antes do CreateDialog)
		oDlg:EnableFormBar(.T.) 
		oDlg:CreateDialog() //cria a janela (cria os paineis)
		
		oPanel := oDlg:getPanelMain()
		oDlg:createFormBar()//cria barra de botoes
		oDlg:addYesNoButton()	

		DEFINE FWBROWSE oBrwMark  DATA ARRAY ARRAY aCampos LINE BEGIN 1 OF oPanel
				ADD COLUMN oColEnt DATA &("{ || aCampos[oBrwMark:At()][1] }") TITLE "Campo" TYPE "C" SIZE 11 OF oBrwMark//"Campo"
		ADD COLUMN oColEnt DATA &("{ || aCampos[oBrwMark:At()][2] }") TITLE "Descrição" TYPE "C" SIZE 30 OF oBrwMark//"Descrição"
		ACTIVATE FWBROWSE oBrwMark	
		oDlg:Activate() 
		
If oDlg:getButtonSelected() > 0
	cR600Agrp := AllTrim(aCampos[oBrwMark:At()][1])
	lRet := .T.
Else
	lRet := .F.	
EndIf 	


Return lRet

//-----------------------------------------------------------------------------
/*/{Protheus.doc} r600RetGr 

Retorno da consulta específica Regras Comerciais x Dots (AZ1)

@sample		U_r600RetGr()

@return		cR600Agrp - Retorna o codigo do modelo

@author		Aline Sebrian Damasceno
@since		24/06/2015
@version	12.1.6
/*/
//------------------------------------------------------------------------------
User Function r600RetGr() 

Return cR600Agrp

//-----------------------------------------------------------------------------
/*/{Protheus.doc} r600Posic 

Posiciona o modelo .DOT  na tabela AG1 - Se existir cadastrado Regras Comerciais
 x Dots (AZ1), posiciona se existe na tabela caso ao contrario, posiciona diretamente
 na AG1.

@sample		ModelDef()

@param 		cCodigo - codigo do modelo
@param 		oGet1   - dialog da descricao
@param 		cDescri - descricao do modelo

@return		lRet - Verifica se existe o modelo na tabela AG1

@author		Aline Sebrian Damasceno
@since		24/06/2015
@version	12.1.6
/*/
//------------------------------------------------------------------------------
User Function r600Posic(cCodigo,oGet1,cDescri) 
Local 	cQuery 	:= ""
Local   lRet    := .T.
Local  nCount   := 0

BeginSQL Alias "TRB" 		
	Select AG1_CODIGO, AG1_DESCRI  "
	  From  %Table:AZ1%  AZ1,  %Table:ADZ%  ADZ ,  %Table:AG1%  AG1
	  Where AZ1.%NotDel%   
	    And ADZ.%NotDel%
	    And AG1.%NotDel%      
	    And AZ1.AZ1_FILIAL = %xFilial:AZ1%
	    And ADZ.ADZ_FILIAL = %xFilial:ADZ%
	    And AG1.AG1_FILIAL = %xFilial:AG1%
	    And ADZ.ADZ_CODAGR = AZ1.AZ1_CODAGR 
	    And ADZ.ADZ_CODNIV = AZ1.AZ1_CODNIV 
	    And AZ1.AZ1_CODDOT = AG1.AG1_CODIGO 
	    And ADZ.ADZ_PROPOS = %Exp:ADY->ADY_PROPOS%

EndSql

If TRB->(EOF()) 	   
	lRet    := ExistCpo("AG1",cCodigo,1)
	cDescri := iIf(lRet,Posicione("AG1", 01, xFilial("AG1")+cCodigo, "AG1_DESCRI"),'') 
Else   
	Do While TRB->(!EOF()) 
		If TRB->AG1_CODIGO == cCodigo
			lRet    := ExistCpo("AG1",TRB->AG1_CODIGO,1)
			cDescri := iIf(lRet,Posicione("AG1", 01, xFilial("AG1")+TRB->AG1_CODIGO , "AG1_DESCRI"),'')
			nCount  := 1
			Exit
		EndIf
	TRB->( DbSkip())
	EndDo 
	
	If nCount == 0
		Help( " ", 1, "REGNOIS" ) 
		lRet := .F.
	EndIf
EndIf
TRB->(dbCloseArea())

If lRet 
	oGet1:Refresh() 
EndIf 

Return lRet
