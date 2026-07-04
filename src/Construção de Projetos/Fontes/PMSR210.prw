/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "PMSR210.ch"
#include "protheus.ch"


//--------------------------RELEASE 4-------------------------------------------//


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PMSR210R4 ³ Autor ³Paulo Carnelossi       ³ Data ³05/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao do Relatorio para release 4 utilizando obj tReport   ³±±
±±³          ³Relatorio de alocacao de recursos                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³ Manutencao efetuada                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PMSR210()
Private oTarefa
Private OITEMTAREFA
Private cTarefa  	:= ""

If PMSBLKINT()
	Return Nil
EndIf

oReport := ReportDef()

If !Empty(oReport:uParam)
	Pergunte(oReport:uParam,.F.)
EndIf	

oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Paulo Carnelossi       ³ Data ³04/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local oProjeto
//Local oItemTarefa
Local aOrdem := {}
Local cPerg  := "PMR210"

// chamado através da opcao do menu
dbSelectArea("AF8")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport := TReport():New("PMSR210",STR0003, cPerg, ;
			{|oReport| ReportPrint()},;
			STR0001+CRLF+STR0003+CRLF+STR0002 )

//STR0001 //"Este programa tem como objetivo imprimir relatorio "
//STR0002 //"de acordo com os parametros informados pelo usuario."
//STR0003 //"Lista para Cotacao por Projeto"
//STR0003 //"Lista para Cotacao por Projeto"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//adiciona ordens do relatorio

oProjeto := TRSection():New(oReport, STR0010,{"AF8", "SA1","AFE"}, aOrdem /*{}*/, .F., .F.) //"Projeto"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRCell():New(oProjeto,	"AF8_PROJET"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"AF8_DESCRI"	,"AF8",/*Titulo*/,/*Picture*/,50/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)

TRPosition():New(oProjeto, "SA1", 1, {|| xFilial("SA1") + AF8->AF8_CLIENT})
TRPosition():New(oProjeto, "AFE", 1, {|| xFilial("AFE") + AF8->AF8_PROJET + AF8->AF8_REVISA})

oProjeto:SetLineStyle()

oTarefa := TRSection():New(oProjeto,STR0011,{"AF9"}, aOrdem /*{}*/, .F., .F.)  //"Tarefa"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRCell():New(oTarefa,	"AF9_TAREFA"	,"AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa,	"AF9_DESCRI"	,"AF9",/*Titulo*/,/*Picture*/,50/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)

TRPosition():New(oTarefa, "AF8", 1, {|| xFilial("AF8") + AF9->AF9_PROJET + AF9->AF9_REVISA})
TRPosition():New(oTarefa, "AFE", 1, {|| xFilial("AFE") + AF9->AF9_PROJET + AF9->AF9_REVISA})

oTarefa:SetLineStyle()

oItemTarefa := TRSection():New(oTarefa,STR0012,{"AFA", "AE8", "SB1"}, aOrdem /*{}*/, .F., .F.) //"Item"

TRCell():New(oItemTarefa,	"AFA_PRODUT"	,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oItemTarefa,	"AFA_TIPPRO"	,"",STR0015/*Titulo*/,/*Picture*/,8/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oItemTarefa,	"AFA_DESCRI"	,"AFA",/*Titulo*/,/*Picture*/,30/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oItemTarefa,	"AFA_QUANT"		,"AFA",/*Titulo*/,/*Picture*/,30/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oItemTarefa,	"AFA_QUANT1"	,"",STR0013/*Titulo*/,"@E 9,999,999.99"/*Picture*/,12/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oItemTarefa,	"AFA_ANOTAC"	,"",STR0014/*Titulo*/,/*Picture*/,50/*Tamanho*/,/*lPixel*/,{||Repl("_",50)})

TRPosition():New(oItemTarefa, "AE8", 1, {|| xFilial("AE8") + AFA->AFA_RECURS})
//TRPosition():New(oItemTarefa, "SB1", 1, {|| xFilial("SB1") + AFA->AFA_PRODUT})


oItemTarefa:SetHeaderPage()
Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Paulo Carnelossi      ³ Data ³29/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³que faz a chamada desta funcao ReportPrint()                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³ExpO1: Objeto TReport                                       ³±±
±±³          ³ExpC2: Alias da tabela de Planilha Orcamentaria (AK1)       ³±±
±±³          ³ExpC3: Alias da tabela de Contas da Planilha (Ak3)          ³±±
±±³          ³ExpC4: Alias da tabela de Revisoes da Planilha (AKE)        ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(  )
Local oProjeto  	:= oReport:Section(1)
Local oTarefa		:= oReport:Section(1):Section(1)
Local oItemTarefa	:= oReport:Section(1):Section(1):Section(1)
Local aProdutos		:= {}
Local aDescri		:= {}
Local cAliasAF8 	:= GetNextAlias()
Local cCondicao 	:= ""
Local nX, nZ, nColAux
Local cObfNRecur 	:= IIF(FATPDIsObfuscate("AE8_DESCRI",,.T.),FATPDObfuscate("RESOURCE NAME","AE8_DESCRI",,.T.),"")      


dbSelectArea("AF8")
dbSetOrder(1)

dbSelectArea("AF9")
dbSetOrder(1)

dbSelectArea("AFA")
dbSetOrder(1)

oItemTarefa:Cell("AFA_PRODUT")	:SetBlock( {|| IIF( !Empty(AFA->AFA_PRODUT),AFA->AFA_PRODUT,AFA->AFA_RECURS) } )
oItemTarefa:Cell("AFA_TIPPRO")	:SetBlock( {|| "(" + IIF( !Empty(AFA->AFA_PRODUT), "P", "R" ) + ")" } )
oItemTarefa:Cell("AFA_DESCRI")	:SetBlock( {|| IIF( !Empty(AFA->AFA_PRODUT),SB1->B1_DESC, IIF(Empty(cObfNRecur),AE8->AE8_DESCRI,cObfNRecur) ) } )
oItemTarefa:Cell("AFA_QUANT")	:SetBlock( {|| AFA->AFA_QUANT } )
oItemTarefa:Cell("AFA_QUANT1")	:SetBlock( {|| (AFA->AFA_CUSTD*PmsAFAQuant(AFA->AFA_PROJET,AFA->AFA_REVISA,AFA->AFA_TAREFA,AFA->AFA_PRODUT,AF9->AF9_QUANT,AFA->AFA_QUANT,AF9->AF9_HDURAC)) / PmsAFAQuant(AFA->AFA_PROJET,AFA->AFA_REVISA,AFA->AFA_TAREFA,AFA->AFA_PRODUT,AF9->AF9_QUANT,AFA->AFA_QUANT,AF9->AF9_HDURAC) } )

// transforma parametros Range em expressao SQL
MakeSqlExpr(oReport:uParam)

// query do relatorio da secao 1
oProjeto:BeginQuery()	

BeginSql Alias cAliasAF8
SELECT AF8_PROJET, AF8_DESCRI, AF8_REVISA, R_E_C_N_O_ NumRec

FROM %table:AF8% AF8

WHERE AF8.AF8_FILIAL = %xFilial:AF8% AND 
	AF8.AF8_PROJET >=%Exp:mv_par01% AND
	AF8.AF8_PROJET <=%Exp:mv_par02% AND 
	AF8.%NotDel%

ORDER BY %Order:AF8%
		
EndSql 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo EndQuery ( Classe TRSection )                                    ³
//³                                                                        ³
//³Prepara o relatório para executar o Embedded SQL.                       ³
//³                                                                        ³
//³ExpA1 : Array com os parametros do tipo Range                           ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oProjeto:EndQuery(/*Array com os parametros do tipo Range*/)

oReport:SetMeter((cAliasAF8)->(LastRec()))

dbSelectArea(cAliasAF8)
dbGoTop()

oProjeto:Init()

While (cAliasAF8)->(!Eof())

    //se for top posiciona no recno do AF8 
    AF8->(dbGoto((cAliasAF8)->NumRec))

	If oReport:Cancel()
		oReport:PrintText(STR0016)
		Exit
	EndIf

	aProdutos:= {}
	
	If mv_par10 == 1 .OR. (mv_par10 == 2 .AND. AFA->( dbSeek(xFilial("AFA")+AF8->AF8_PROJET+AF8->AF8_REVISA) ))
		
		If AFA->AFA_PRODUT >= mv_par04 .and. AFA->AFA_PRODUT <= mv_par05 
  		
	   	oProjeto:PrintLine()
    	oReport:SkipLine()

		// carrega os produtos do projeto/tarefa
		PMR210PR4(@aProdutos, @cAliasAF8, @oItemTarefa, @oTarefa, @oReport)
		oReport:ThinLine()
	EndIf 
EndIf
	
	oReport:IncMeter()	 

	dbSelectArea( cAliasAF8 )
	dbSkip()
	
EndDo

oProjeto:Finish()

(cAliasAF8)->(DbCloseArea())

Return

//Função especifica para R4
Static Function PMR210PR4(aProdutos, cAliasAF8, oItemTarefa, oTarefa, oReport)
Local nPos	   := 0
Local nQuantAFA:= 0
Local cGrupAFA := ""
Local nRecAF8  := AF8->(recno())
Local cObfNRecur := IIF(FATPDIsObfuscate("AE8_DESCRI",,.T.),FATPDObfuscate("RESOURCE NAME","AE8_DESCRI",,.T.),"")      

dbSelectArea("AF9")
dbGoTop()
dbSeek(xFilial("AF9")+AF8->AF8_PROJET+AF8->AF8_REVISA) 
  		
While !AF9->(Eof()) .And. (xFilial("AF9")+AF8->AF8_PROJET+AF8->AF8_REVISA == AF9->AF9_FILIAL+AF9->AF9_PROJET+AF9->AF9_REVISA)
	If !PmrPertence(AF9->AF9_NIVEL,mv_par03)
		dbSelectArea("AF9")
		dbSkip()
		Loop
	Endif
	
	// pesquisa os produtos da tarefa
	dbSelectArea("AFA")
	dbSetOrder(1)  
				
	If dbSeek(xFilial("AFA")+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA)
		While !AFA->(Eof()) .And. (xFilial("AFA")+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA == AFA->AFA_FILIAL+AFA->AFA_PROJET+AFA->AFA_REVISA+AFA->AFA_TAREFA)
			If (mv_par08 == 2 .and. AFA->AFA_CUSTD == 0) .Or. (mv_par08 == 3 .and. AFA->AFA_CUSTD <> 0)
				dbSkip()
				Loop
			EndIf 
			
			cGrupAFA := Posicione("SB1",1,xFilial("SB1")+AFA->AFA_PRODUT,"B1_GRUPO")
			If AFA->AFA_PRODUT >= mv_par04 .and. AFA->AFA_PRODUT <= mv_par05 .and. cGrupAFA >= mv_par06 .and. cGrupAFA <= mv_par07
				
				nQuantAFA:= PmsAFAQuant(AFA->AFA_PROJET,AFA->AFA_REVISA,AFA->AFA_TAREFA,AFA->AFA_PRODUT,AF9->AF9_QUANT,AFA->AFA_QUANT,AF9->AF9_HDURAC)
				
				If Mv_Par09 == 2 //Imprime por tarefa
				
					If	Empty(AFA->AFA_PRODUT)
						dbSkip()
						Loop					
					Endif 
					
					If mv_par10 == 1 .Or. !Empty(AFA->AFA_PRODUT)
						If !Empty(AFA->AFA_PRODUT)
							nPos:= aScan(aProdutos,{|x| x[1]+x[2] == AFA->AFA_TAREFA+AFA->AFA_PRODUT	.And. x[5] =="P"})
						Else
							nPos:= aScan(aProdutos,{|x| x[1]+x[2] == AFA->AFA_TAREFA+AFA->AFA_RECURS	.And. x[5] =="R" })
						Endif							
						If (nPos > 0)
							aProdutos[nPos,3]+= nQuantAFA
							aProdutos[nPos,4]+= nQuantAFA * AFA->AFA_CUSTD
						Elseif AFA->AFA_PRODUT >= mv_par04 .and. AFA->AFA_PRODUT <= mv_par05
							If !Empty(AFA->AFA_PRODUT)
								aAdd(aProdutos,{AFA->AFA_TAREFA,AFA->AFA_PRODUT,nQuantAFA,AFA->AFA_CUSTD*nQuantAFA,"P",QbTexto(Posicione("SB1",1,xFilial("SB1")+AFA->AFA_PRODUT,"B1_DESC"), 030, " ")})
							Else
								aAdd(aProdutos,{AFA->AFA_TAREFA,AFA->AFA_RECURS,nQuantAFA,AFA->AFA_CUSTD*nQuantAFA,"R",QbTexto(IIF(Empty(cObfNRecur),Posicione("AE8",1,xFilial("AE8")+AFA->AFA_RECURS,"AE8_DESCRI"),cObfNRecur), 030, " ")})
						Endif  
						EndIf
					EndIf
				Else 
					If mv_par10 == 1 .Or. !Empty(AFA->AFA_PRODUT)  
						If !Empty(AFA->AFA_PRODUT)
							nPos:= aScan(aProdutos,{|x| x[2] == AFA->AFA_PRODUT	.And. x[5] =="P" })
						Else
							nPos:= aScan(aProdutos,{|x| x[2] == AFA->AFA_RECURS	.And. x[5] =="R" })
						Endif							
						If (nPos > 0)
							aProdutos[nPos,3]+= nQuantAFA
							aProdutos[nPos,4]+= nQuantAFA * AFA->AFA_CUSTD
						Elseif AFA->AFA_PRODUT >= mv_par04 .and. AFA->AFA_PRODUT <= mv_par05
							If  !Empty(AFA->AFA_PRODUT)
								aAdd(aProdutos,{"",AFA->AFA_PRODUT,nQuantAFA,AFA->AFA_CUSTD*nQuantAFA,"P",QbTexto(Posicione("SB1",1,xFilial("SB1")+AFA->AFA_PRODUT,"B1_DESC"), 030, " ")})
							Else
								aAdd(aProdutos,{"",AFA->AFA_RECURS,nQuantAFA,AFA->AFA_CUSTD*nQuantAFA,"R",QbTexto(IIF(Empty(cObfNRecur),Posicione("AE8",1,xFilial("AE8")+AFA->AFA_RECURS,"AE8_DESCRI"),cObfNRecur), 030, " ")})
							Endif
						Endif
					Endif
				EndIf
				//Valida se a opção de imprimir recursos sem produto seja 2(nao) no mv_par10  
				//e se na tabela AFA o recurso está sem produto na coluna AFA_PRODUT
				If mv_par10 == 2 .And. Empty(AFA->AFA_PRODUT) 
					dbSkip()
					Loop					
				Endif		   
			EndIf

			//////////////////////////  R4

			oItemTarefa:Init()
			// finaliza a sessao se mudar de tarefa
			If oTarefa:lPrinting .And. (mv_par09 == 2) .And. (cTarefa <> AFA->AFA_TAREFA )
				oTarefa:Finish()
			EndIf

			// verifica se a impressao e por projeto ou por tarefa
			If (mv_par09 == 2) .And. (cTarefa <> AFA->AFA_TAREFA)
				cTarefa:= AFA->AFA_TAREFA
				AF9->(dbSetOrder(1))
				AF9->(MsSeek(xFilial("AF9") + (cAliasAF8)->AF8_PROJET + (cAliasAF8)->AF8_REVISA + cTarefa))

				oReport:ThinLine()

				If ! oTarefa:lPrinting
					oTarefa:Init()
					oTarefa:PrintLine()
				EndIf

				oReport:ThinLine()

			EndIf    
			
			IF !Empty(AFA->AFA_PRODUT)
				
				dbSelectArea("SB1")
				dbSetOrder(1)
				SB1->(dbseek(xFilial("SB1")+ AFA->AFA_PRODUT ))
				
			ELSE
				
				dbSelectArea("AE8")
				dbSetOrder(1)
				AE8->(dbseek(xFilial("AE8")+ AFA->AFA_RECURS )) 					
								
			ENDIF
			
			dbSelectArea("AFA")
			
			If AFA->AFA_PRODUT >= mv_par04 .and. AFA->AFA_PRODUT <= mv_par05
				oItemTarefa:PrintLine()
			EndIf
			
			If oTarefa:lPrinting
				oTarefa:Finish()
			EndIf
			
			dbSkip()
			
		End
	EndIf
	AF8->(DbGoTo(nRecAF8))
	dbSelectArea("AF9")
	AF9->( dbSkip() )
End

Return  


//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDIsObfuscate
    @description
    Verifica se um campo deve ser ofuscado, esta função deve utilizada somente após 
    a inicialização das variaveis atravez da função FATPDLoad.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cField, Caractere, Campo que sera validado
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado
    @return lObfuscate, Lógico, Retorna se o campo será ofuscado.
    @example FATPDIsObfuscate("A1_CGC",Nil,.T.)
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDIsObfuscate(cField, cSource, lLoad)
    
	Local lObfuscate := .F.

    If FATPDActive()
		lObfuscate := FTPDIsObfuscate(cField, cSource, lLoad)
    EndIf 

Return lObfuscate


//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @sample FATPDObfuscate("999999999","U5_CEL")
    @author Squad CRM & Faturamento
    @since 04/12/2019
    @version P12
    @param xValue, (caracter,numerico,data), Valor que sera ofuscado.
    @param cField, caracter , Campo que sera verificado.
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado

    @return xValue, retorna o valor ofuscado.
/*/
//-----------------------------------------------------------------------------
Static Function FATPDObfuscate(xValue, cField, cSource, lLoad)
    
    If FATPDActive()
		xValue := FTPDObfuscate(xValue, cField, cSource, lLoad)
    EndIf

Return xValue   

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    Função que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive  
