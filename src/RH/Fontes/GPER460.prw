/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Protheus.CH"
#INCLUDE "GPER460.CH"

Static _cRepDb	:= GetSrvProfString("RepositInDataBase","")
Static _cRep	:= SuperGetMv("MV_REPOSIT",.F.,"1")
Static _lRepDb	:= ( _cRepDb == "1" .And. _cRep == "2" )
Static lAnotacoes	:= .F.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GPER460    ³ Autor ³ R.H. - Mauro              ³ Data ³ 04.06.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrica‡…o ³ Impressao Ficha Registro                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GpeR460(void)                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data     ³ BOPS/FNC ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±|Mohanad Odeh|14/03/2013|M12RH01   |Unificacao da Folha V12                   ³±±
±±|            |          |RQ4505    |                                          ³±±
±±|Raquel Hager|01/11/2013|M12RH01   |Remocao do uso do parametro MV_NCPROF -   ³±±
±±|            |          |RQ4505    |Sempre sera o novo calculo.               ³±±
±±|Esther      |16/04/2014|M_RH003   |Replica da v11 para v12: Ajuste p/ que as ³±±
±±|Viveiro     |          |          |Fichas de Anotacoes possam apresentar     ³±±
±±|            |          |          |Assinaturas; Atualizado o numero da       ³±±
±±|            |          |          |Portaria do MTE; Modificada a função	    ³±±
±±|            |          |          |fCarLogo, pois estava trazendo o nome do  ³±±
±±|            |          |          |arquivo de Logo errado 					³±±
±±|Gustavo M.  |29/07/2014|TQEQSG    |Ajuste para impressão do CEI caso utiliza ³±±
±±|            |          |		     |do pela empresa.			                ³±±
±±|Allyson M   |14/08/2014|TQI405	 |Ajuste na carga da descrição do sindicato ³±±
±±|            |          |      	 |quando houve troca do sindicato.			³±±
±±|Christiane V|14/10/2014|TQUDMA    |Ajuste para impressão dos cursos do func. ³±±
±±|            |          |          |que estão com a opção Imprimir = "S".     ³±±
±±|Wag Mobile  |21/11/2014|TRBUAN	 |Ordenar a impressão alterações cadastrais ³±±
±±|            |          |          |e sindicais por data                      ³±±
±±|Wag Mobile  |17/12/2014|TREMOD	 |Ajuste para imprimir, no tipo normal, as  ³±±
±±|            |          |          |informações do no limite correto do layout³±±
±±|            |          |          |sem ultrapassar as margens.               ³±±
±±|Wag Mobile  |13/01/2015|TRJKQ4	 |Criação de opção para impressão  da  ficha³±±
±±|            |          |  		 |anotações conforme portaria 41 do MTE     ³±±
±±|Allyson M   |23/01/2015|TRDKWC	 |Ajuste p/ imprimir os dias de licenca     ³±±
±±|            |          |      	 |remunerada das ferias.					³±±
±±|L.Trombini  |03/03/2015|TRSZSL	 |Corrigir a impressão das Contribuições    ³±±
±±|            |          |  		 |Sindical e Assitencial                    ³±±
±±|Cícero Alves|20/03/2015|TRYFS4	 |Tratamento para os campos RA_COMPSAB e    ³±±
±±|            |          |  		 |RA_HOPARC na impressão					³±±
±±|Mariana M.  |27/08/2015|TSFJXA	 |Ajuste de CH							    ³±±
±±|Mariana M.  |08/10/2015|TTOCVV	 |Ajustada função fImpSal p/ quando existir ³±±
±±|            |          |  		 |duas alteraçoes salariais no mesmo dia,   ³±±
±±|            |          |  		 |porem o tipo de alteraçao se inverte		³±±
±±|Mariana M.  |06/11/2015|TTNTH4	 |Alteração na Função fCarLogo para que bus-³±±
±±|            |          |  		 |que a filial correta que o funcionário es-³±±
±±|            |          |  		 |tá e monte o codigo do logo corretamente. ³±±
±±|            |          |  		 |OBS: caso o logo tenha o nome LGRL01.BMP, ³±±
±±|            |          |  		 |o sitema imprimira para todas as filiais  ³±±
±±|            |          |  		 |da empresa 01 mesmo logo.Para diferenciar ³±±
±±|            |          |  		 |os logos por filial, deve ter nomes dife- ³±±
±±|            |          |  		 |renciados como LGRL0101.BMP e LGRL0102.BMP³±±
±±|            |          |  		 |Obrigatoriamente deve-se ter o código da  ³±±
±±|            |          |  		 |empresa e da filial						³±±
±±|Renan Borges|27/01/2016|TTNTH4	 |Ajuste para ao imprimir a ficha de regis- ³±±
±±|            |          |  		 |tro de um funcionário com ausencia cadas- ³±±
±±|            |          |  		 |trada sistema imprima a descrição correta ³±±
±±|            |          |  		 |de acordo com o tipo de ausencia (tabela  ³±±
±±|            |          |  		 |RCM).                                     ³±±
±±|            |          |          |Ajuste na função fImpFer, para que o sis- ³±±
±±|            |          |  		 |tema demonstre corretamente dias quebrados³±±
±±|            |          |  		 |com férias/licença remunerada após calculo³±±
±±|            |          |  		 |de férias coletivas						³±±
±±|Raquel Hager|15/06/2016|TUUFX9	 |Ajuste para impressão das transferências  ³±±
±±|            |          |  		 |sofridas pelo funcionário.                ³±±
±±|P. Pompeu...|30/06/2016|TVNIM6	 |Exibir contribuições sociais do per. atual³±±
±±|Gabriel A.  |05/08/2016|TVRRY4   |Ajuste para impressão do salário da       ³±±
±±|            |          |         |admissão do funcionário.                  ³±±
±±|P. Pompeu...|25/08/2016|TVWTOF	 |Otimização da ocupação da páginam, remoção ±±
±±|            |          |      	 |de espaços desnecessários. Refatoração das ±±
±±|            |          |     	 |tabelas de dados, unificando a implementação±
±±|Cícero Alves|08/09/2016|TVXPEZ	 |Ajuste para verificar se existe o grupo    ±±
±±|            |          |      	 |de perguntas							     ±±
±±|Gustavo M.  |23/12/2016|MRH-791	 |Ajuste na impressao da descricao do CC     ±±
±±|Oswaldo L.  |01/02/17  |MRH-5782  |Trativa para que o sistema apenas utilize ³±±
±±|            |          |          |os campos de acordo com o pais conectado  ³±±
±±|Paulo O     |09/05/2017|MRH-853	 |Efetuado ajuste para verificar se o campo ³±±
±±|Inzonha     |          |      	 |memo cabe na pagina,se não quebra a pagina³±±
±±|            |          |      	 | e imprime o campo memo na próxima.       ³±±
±±|Eduardo K.  |14/08/2017|MPRIMESP	 |Ajuste em fImpAfas para que desconsidere   ±±
±±|            |          |11057   	 |período de férias como afastamento.	     ±±
±±|Isabel N.   |11/09/2017|DRHPAG    |Ajuste na quebra de linha caso campo memo ³±±
±±|            |          |-5007     |esteja vazio, evitando sobreposição.      ³±±
±±|Isabel N.   |27/10/2017|DRHPAG    |Imprimir tipo de inscrição da filial no   ³±±
±±|            |          |-5458     |cabeçalho conforme cadastrado no CFG.     ³±±
±±|Willian U.  |16/11/2017|DRHPAG    |Ajuste p/a pergunta "Ficha atualizada"    ³±±
±±|            |          |-5749     |imprimir informações de cabeçalho caso	³±±
±±|            |          |          |seja preenchida com "Não"				    ³±±
±±|Jaqueline L |12/12/2017|DRHPAG    |Correção no SetOrder da Tabela SRD , pois ³±±
±±|            |          |-3775     |n estava ordenada, com isso não era    	³±±
±±|            |          |          |possível encontrar todas as infor. das    ³±±
±±|            |          |          |Contrib. Sindicais quando houvesse Transf.³±±
±±|Jaqueline L |12/01/2018|DRHPAG    |Correção no filtro da busca da descrição  ³±±
±±|            |          |-10681    |do turno de trabalho, passando agora a  	³±±
±±|            |          |          |filial da SRA.                            ³±±
±±|Henrique F. |17/01/2018|DRHPAG    |Correção da impressão da descrição da     ³±±
±±|            |          |-9756     |insalubridade                          	³±±
±±|WinstonCosta|17/12/2018|DRHPAG    |Automatizando o Fonte (Robô)              ³±±
±±|            |          |-22544    |                                       	³±±
±±|V.Flores    |04/04/2020|DMINA     |Dentro de la función GpeR460 se realiza   ³±±
±±|            |          |-8720     |modificación en la bifurcación de los     ³±±
±±|            |          |          |parametros para la generación del informe.³±±
±±|Alexandre A.|08/12/2020|DRHGCH    |Ajustes nas coordenadas de impressao no   ³±±
±±|            |          |-22498    |Box de informacoes de Afastamentos,       ³±±
±±|            |          |          |localizado na funcao fImpAfasG.           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GpeR460(__lAnotacoes, lunico)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

LOCAL cDesc1	:=	STR0001						//"Será impresso de acordo com os parametros solicitados pelo usuario."
LOCAL cDesc2 	:=	STR0002						//A area do relatório [Dados Cadastrais] irá utilizar os campos escolhidos no botão [Definições]
LOCAL cDesc3 	:=	""
LOCAL cString	:=	"SRA"						// alias do arquivo principal (Base)
LOCAL aOrd 		:=	{STR0004,STR0005,STR0006}	//"Matricula"###"Centro de Custo"###"Nome"
LOCAL wnRel
Local aArea		:= GetArea()
Local n
Local cRProc	:= ""

lAnotacoes := If(__lAnotacoes == Nil .Or. ValType(__lAnotacoes) <> "L", .F., __lAnotacoes)

If lAnotacoes
	cDesc2 := STR0003
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Utilizadas para Filtro                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cFiltraSRA				//Variavel para filtro
Private aIndexSRA	:= {}		//Variavel Para Filtro
Private bFiltraBrw  := {|| Nil}	//Variavel para Filtro

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis PRIVATE(Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aReturn := { STR0007, 1,STR0008, 2, 2, 1, "",1 }  //"Zebrado"###"Administra‡„o"
PRIVATE nomeprog:="GpeR460"
PRIVATE aLinha  := { },nLastKey := 0
PRIVATE cPerg   :=""
Private nChar	:= 18
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Utilizadas na funcao IMPR                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE Titulo  := If(lAnotacoes, STR0100, STR0009)  //"FICHA DE REGISTRO"
PRIVATE cCabec
PRIVATE AT_PRG  := "GPER460"
PRIVATE wCabec0 := 9
PRIVATE wCabec1:=""
PRIVATE wCabec2:=""
PRIVATE wCabec3:=""
PRIVATE wCabec4:=""
PRIVATE wCabec5:=""
PRIVATE wCabec6:=""
PRIVATE wCabec7:=""
PRIVATE wCabec8:=""
PRIVATE wCabec9:=""
PRIVATE CONTFL:=1
PRIVATE LI:=0
PRIVATE nTamanho:="P"
PRIVATE cPathPict	:= ""
Private lImpDIni	:= .T.
Private lImpDFim	:= .T.
PRIVATE aAgrup 	:= fReadFCH()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis PRIVATE(Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cIndCond
PRIVATE cFor
PRIVATE nOrdem
PRIVATE aInfo	:=	{}
Private oPrint , i:= 1
Private oTamFont,oFont07,oFont08,oFont08n,oFont08C, oFont10, oFont15, oFont10n, oFont21, oFont12,oFont12n,oFont16
Private nLin := nLinha:= 0, nColuna := 50
Private aCampo:= {}
Private nlinMax	:= 3215
Private nColMax := 2350
Private nColBox := 2200
Private lFirst	:= .T.
Private lFerLic	:= .F.
Private aFotos	:= {}			//armazena nome  foto
Private cProcessos	:= ""

Private nTipFicha := 1

Default _cRepDb	:= GetSrvProfString("RepositInDataBase","")
Default _cRep	:= SuperGetMv("MV_REPOSIT",.F.,"1")
Default _lRepDb	:= ( _cRepDb == "1" .And. _cRep == "2" )
Default lunico  := .F.

If Funname() <> "GPEA260"
	//"O relatório Ficha de Registro(GPER460) não deve ser incluído diretamente no menu e deve ser chamado exclusivamente a partir da rotina Ficha de Registro(GPEA260)."
	Help( ,, OemToAnsi(STR0046),, OemToAnsi(STR0160), 1, 0 )
	Return
EndIf

//--Altera o Set Epch para 1920
nEpoca := SET( 5,1920)

//--Verifica se o grupo de perguntas existe na base
dbSelectarea("SX1")
DbSetOrder(1)
If ! dbSeek("GPR460")
	Help(" ",1,"NOPERG")
	Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
if lunico
	cPerg   :="GPR460A"
	Pergunte("GPR460A",.F.)
else
	cPerg   :="GPR460"
	Pergunte("GPR460",.F.)
endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         					³
//³ mv_par01        //  Filial  De                              				 	³
//³ mv_par02        //  Filial  Ate                             			 		³
//³ mv_par03        //  Centro de Custo De                      			 		³
//³ mv_par04        //  Centro de Custo Ate                    				  		³
//³ mv_par05        //  Matricula De                             					³
//³ mv_par06        //  Matricula Ate                            					³
//³ mv_par07        //  Nome De                                  					³
//³ mv_par08        //  Nome Ate                                 					³
//³ mv_par09        //  Situacao                                 					³
//³ mv_par10        //  Categoria                                					³
//³ mv_par11        //  Ficha Atualizada                        					³
//³ mv_par12        //  Alt. Salariais                           					³
//³ mv_par13        //  Afastamentos                             					³
//³ mv_par14        //  Dependentes                              					³
//³ mv_par15        //  Ferias                                   					³
//³ mv_par16        //  Alt. Cadastrais                          					³
//³ mv_par17        //  Contrib. Sindicais                       					³
//³ mv_par18        //  Transferencias                           					³
//³ mv_par19        //  Beneficiarios                            					³
//³ mv_par20        //  Impr.Desc. Filial                        					³
//³ mv_par21        //  Impressao Grafica                        					³
//³ mv_par22        //  Data inicio de impressao                				    ³
//³ mv_par23        //  Data final de impressao                  					³
//³ mv_par24        //  Nome Responsavel Legal                   					³
//³ mv_par25        //  Imprime Tarefas( Fixas/Variaveis/Ambas)                   ³
//³ mv_par26        //  Prof./Tarefeiros Imprime(Historico Salarial/Tarefas/Ambos)³
//³ mv_par27        //  Titulo Relatorio: 											    ³
//³						  	   1-Ficha de Registro  	  							        ³
//³                         2-Ficha de Anotacoes e Atualizacoes da CTPS e PREVID.  ³
//³ mv_par28        //  Contrib. Assist.                        					 ³
//³ mv_par29        //  Processos para Impressao                 					 ³
//³ mv_par30        //  Imprime Treinamentos                     					 ³
//³ mv_par31        //  Considera dias de licenca nas ferias : 1-Sim / 2-Nao        ³
//³ mv_par32        //  Imprime Slário Atual? :1-Sim / 2-Nao                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="GPER460"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ordem do Relatorio                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nOrdem   := aReturn[8]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
if lunico
	FilialDe	:= SRA->RA_FILIAL
	FilialAte	:= SRA->RA_FILIAL
	CcDe     	:= SRA->RA_CC
	CcAte    	:= SRA->RA_CC
	MatDe    	:= SRA->RA_MAT
	MatAte   	:= SRA->RA_MAT
	NomDe    	:= SRA->RA_NOME
	NomAte   	:= SRA->RA_NOME
	cSit     	:= SRA->RA_SITFOLH
	cCat     	:= SRA->RA_CATFUNC

	lFicha   	:= (mv_par01 == 1)
	lSalar   	:= (mv_par02 == 1)
	nAfast   	:= mv_par03
	lDepen   	:= (mv_par04 == 1)
	nFerias  	:= mv_par05
	nAltcad	:= mv_par06
	nConSin	:= mv_par07
	nTransf	:= mv_par08
	lBenefic	:= (mv_par09 == 1)
	nFilial		:= mv_par10
	nGrafica	:= mv_par11
	dDataIni	:= mv_par12
	dDataFin	:= mv_par13
	cResponsavel:= mv_par14
	uTarefa		:= mv_par15
	nImpSalTar	:= mv_par16
	If lAnotacoes
		mv_par17 := 2
	EndIf
	nTitulo 	:= If(cPaisLoc == "BRA", mv_par17, 1) // Embora esteja visivel, apenas Brasil possui opcao para Ficha de Atualizacoes CPTS
	nContAss 	:= mv_par18
	nTipFicha 	:= nTitulo
	cProcessos	:= SRA->RA_PROCES
	nTreina 	:= mv_par19
	lFerLic		:= ( mv_par21 == 1 )
	nTipoSal    := If( Empty(mv_par20), 1, mv_par20 )//-- se a pergunta não existir imprime o salario atual, como fazia antes da alteração
	If ValType(mv_par22) == "N"
		nQuebra := mv_par22
	Else
		nQuebra := 2
	EndIf
else
	FilialDe	:= mv_par01
	FilialAte	:= mv_par02
	CcDe     	:= mv_par03
	CcAte    	:= mv_par04
	MatDe    	:= mv_par05
	MatAte   	:= mv_par06
	NomDe    	:= mv_par07
	NomAte   	:= mv_par08
	cSit     	:= mv_par09
	cCat     	:= mv_par10
	lFicha   	:= (mv_par11 == 1)
	lSalar   	:= (mv_par12 == 1)
	nAfast   	:= mv_par13
	lDepen   	:= (mv_par14 == 1)
	nFerias  	:= mv_par15
	nAltcad	:= mv_par16
	nConSin	:= mv_par17
	nTransf	:= mv_par18
	lBenefic	:= (mv_par19 == 1)
	nFilial		:= mv_par20
	nGrafica	:= mv_par21
	dDataIni	:= mv_par22
	dDataFin	:= mv_par23
	cResponsavel:= mv_par24
	uTarefa		:= mv_par25
	nImpSalTar	:= mv_par26
	If lAnotacoes
		mv_par27 := 2
	EndIf
	nTitulo 	:= If(cPaisLoc == "BRA", mv_par27, 1) // Embora esteja visivel, apenas Brasil possui opcao para Ficha de Atualizacoes CPTS
	If cPaisLoc == "BRA" .And. ValType(mv_par33) == "N"
		nContAss   := mv_par28
		cProcessos := If( Empty(mv_par29),"*", AllTrim(mv_par29) )
		nTreina    := mv_par30
		lFerLic    := ( mv_par31 == 1 )
		nTipoSal   := If( Empty(mv_par32), 1, mv_par32 )//-- se a pergunta não existir imprime o salario atual, como fazia antes da alteração
		nQuebra    := mv_par33
	Else
		cProcessos := If( Empty(mv_par28),"*", AllTrim(mv_par28) )
		nTreina    := mv_par29
		lFerLic    := ( mv_par30 == 1 )
		nTipoSal   := If( Empty(mv_par31), 1, mv_par31 )//-- se a pergunta não existir imprime o salario atual, como fazia antes da alteração
		nQuebra    := mv_par32
	EndIf

	nTipFicha 	:= nTitulo
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ ¿
//³Ajustada flag para tratar como altera := .t., pois o inicializador de campo     ³
//³X3_RELACAO usa INCLUI para buscar a descrição do campo quando "V"irtual.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Ù
INCLUI := .F.
ALTERA := .T.

cFiltraRh 	:= CHKRH("GPEA260","SRA","1")
bFiltraBrw 	:= {|| FilBrowse("SRA",@aIndexSRA,@cFiltraRH) }

If nLastKey = 27
	Eval(bFiltraBrw)
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica preenchimento dos campos datas³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Empty( dDataIni )
	lImpDIni:= .F.
	dDataIni := CTOD( "01/01/1900", "DDMMYYYY" )
Endif
If Empty( dDataFin )
	lImpDFim:= .F.
	dDataFin := CTOD( "31/12/2099", "DDMMYYYY" )
Endif
dDataFin := Max( dDataFin, dDataIni )

If !(mv_par21 = 1)
	SetDefault(aReturn,cString)
EndIf

If nLastKey = 27
	Eval(bFiltraBrw)
	Return
Endif
If nGrafica ==1
	oPrint:=TMSPrinter():New(STR0001)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se ha impressora ativa conectada ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ! oPrint:IsPrinterActive()
		oPrint:Setup()							//-- Escolhe a impressora
		If ! oPrint:IsPrinterActive()
			Help(" ",1,"NOPRINTGRA")			//-- Nao foi encontrada configuracao de impressora. ##Certifique-se de que as configurações da impressora estão corretas ou se há alguma impressora conectada.
			Return(Nil)
		Endif
	Endif
	If aReturn[4] == 2
		oPrint:SetLandscape()		//Modo Paisagem
		nlinMax	:= 2400
	Else
		oPrint:SetPortrait()		//Modo retrato
	EndIf
	oPrint:StartPage() 			//Inicia uma nova pagina
//                         /Nome Fonte/  /Tamanho/	  /Negrito/     /Sublinhado/    /Italico/
	oFont07	:= TFont():New("Courier New",07,07		,,.F.		,,,,.T.,			.F.)
	oFont08n:= TFont():New("Arial"		,08,08		,,.T.		,,,,.T.,			.F.)
	oFont08c:= TFont():New("Courier New",08,08		,,.F.		,,,,.T.,			.F.)
	oFont08 := TFont():New("Arial"		,08,08		,,.F.		,,,,.T.,			.F.)
	oFont10	:= TFont():New("Courier New",10,10		,,.F.		,,,,.T.,			.F.)
	oFont10n:= TFont():New("Courier New",10,10		,,.T.		,,,,.T.,			.F.)
	oFont12	:= TFont():New("Arial"		,12,12		,,.F.		,,,,.T.,			.F.)
	oFont12n:= TFont():New("Arial"		,12,12		,,.T.		,,,,.T.,			.F.)			//Negrito
	oFont15	:= TFont():New("Courier New",15,15		,,.F.		,,,,.T.,			.F.)
	oFont21 := TFont():New("Courier New",21,21		,,.F.		,,,,.T.,			.T.)
	oFont16	:= TFont():New("Arial"		,16,16		,,.T.		,,,,.T.,			.F.)
Endif

Titulo  := If (nTitulo== 1, STR0009, STR0100) //"FICHA DE REGISTRO", "FICHA DE ANOTACOES E ATUALIZACOES DA C.T.P.S."

RptStatus({|lEnd| GR460Imp(@lEnd,wnRel,cString)},Titulo)

If nGrafica == 1
	oPrint:Preview()  		// Visualiza antes de imprimir

	//-- Apaga BMP Foto do Diretorio
	For n:=1 to Len(aFotos)
		IF File(aFotos[n])
			fErase( aFotos[n])
		Endif
	next n
Endif

//--Retornar Set Epoch Padrao
SET(5,nEpoca)
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Restaura Area e Ordem de Entrada                              ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
RestArea( aArea)
Eval(bFiltraBrw)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPR460Imp³ Autor ³ R.H. - Ze Maria       ³ Data ³ 03.03.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Folha de Pagamanto                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ GPR460Imp(lEnd,wnRel,cString)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - A‡Æo do Codelock                             ³±±
±±³          ³ wnRel       - T¡tulo do relat¢rio                          ³±±
±±³          ³ cString     - Mensagem                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GR460Imp(lEnd,WnRel,cString)
Local cAcessaSRA  := &("{ || " + ChkRH("GPER460","SRA","2") + "}")
Local nLinhas	:= 0
Local X			:= 0
Local lNUse 	:= cPaisLoc == "PER"
Local cFilter  := aReturn[7] // #
Local cExpressao:= ""
Local cInicio:= ""
Local cFim   := ""
Local lPerAdm	:= .F.
Local cMsg		:= ""
Private	lImpressao	:= .F.  				//-- Define se houve impressao da informacao
Private  cFiltro	 := "" // Trocada para Private para poder manipular o Filtro quando necessário

// Exibe a mensagem perguntando ao usuário se o período informado dse a ficha
// deve considerar o período para filtro de admissão ou para filtro dos movimentos
//"Deseja utilizar a Data Inicia/Final informada para filtrar os funcionários de acordo com a Data de Admissão?"
//"Caso não, a ficha seguirá o comportamento padrão de utilizar a Data Inicia/Final somente para filtro dos movimentos."
If !IsBlind()
	cMsg += STR0158 + CRLF + CRLF + STR0159
	lPerAdm := MsgYesNo( cMsg, STR0046 )
EndIf
/*Montra Expressão Advpl de Filtragem do Alias.*/
cFiltro := "(SRA->RA_NOME >= '"	+ NomDe +"' .And. SRA->RA_NOME <= '"+ NomAte	+"') .And. "
cFiltro += "(SRA->RA_MAT >= '"	+ MatDe +"' .And. SRA->RA_MAT <= '"	+ MatAte	+"') .And. "
cFiltro += "(SRA->RA_CC >= '"	+ CcDe	+"' .And. SRA->RA_CC <= '"	+ CcAte	+"') .And. "
cFiltro += "(SRA->RA_SITFOLH $'"+ cSit	+"' .And. SRA->RA_CATFUNC $'"+ cCat	+"')"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a string de Processos para Impressao                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If AllTrim(cProcessos) <> "*"
	cRProc := ""
	nTamCod := GetSx3Cache( "RCJ_CODIGO" , "X3_TAMANHO" )
	For X := 1 to Len(cProcessos) step 5
		If Len(Subs(cProcessos,X,5)) < nTamCod
			cAuxPrc := Subs(cProcessos,X,5) + Space(nTamCod - Len(Subs(cProcessos,X,5)))
		Else
			cAuxPrc := Subs(cProcessos,X,5)
		EndIf
		cRProc += cAuxPrc
		cRProc += "#"
	Next X
	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Consiste Processos para Impressao                                      ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	cFiltro += " .And. (SRA->RA_PROCES $'"+ cRProc	+"')"

EndIf

//³ Consiste Filtro da setprint						             ³
If ! Empty(cFilter)
	cFiltro += " .And. ("+ cFilter +")"
EndIf

/*Seta o Filtro no Alias*/

SRA->(DbSetFilter({||&cFiltro}, cFiltro))

/*O filtro é ativado no dbGoTop, a partir desse ponto o alias está filtrado
de acordo com cFiltro!*/

SRA->(dbGoTop())

Do Case
	Case (nOrdem == 1)
		cExpressao	:= "SRA->RA_FILIAL + SRA->RA_MAT"
		cInicio	:= FilialDe	+ MatDe
		cFim		:= FilialAte	+ MatAte
	Case (nOrdem == 2)
		cExpressao	:= "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
			cInicio	:= FilialDe	+ CcDe	+ MatDe
			cFim		:= FilialAte	+ CcAte+ MatAte
	Case (nOrdem == 3)
		cExpressao	:= "SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT"
		cInicio	:= FilialDe	+ NomDe	+ MatDe
		cFim		:= FilialAte	+ NomAte	+ MatAte
EndCase
SRA->(dbSetOrder(nOrdem))
SRA->(dbSeek(cInicio,.T.))

SetRegua(SRA->(RecCount()))

cFilAnterior 	:= Space(FWGETTAMFILIAL)
cCcAnt       	:= Space(09)

dbSelectArea( "SRA" )
While !EOF() .And. &cExpressao <= cFim

	IncRegua()

    If lEnd
        @Prow()+1,0 PSAY cCancel
        Exit
    Endif

	//Consiste controle de acessos e filiais validas.
	//Essa consistência não pode ser inserida em cFiltro, pois dependendo
	//da quantidade de filiais do cliente o tamanho do filtro estourará o
	//limite máximo de uma variável string do Advpl.
	If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
		dbSelectArea( "SRA" )
		dbSkip()
		Loop
	EndIf

    IF  SRA->RA_FILIAL # cFilAnterior
        If ! fInfo(@aInfo,SRA->RA_FILIAL)
			Exit
		Endif
	Endif

	IF  lPerAdm .And. !(SRA->RA_ADMISSA >= dDataIni .And. SRA->RA_ADMISSA <= dDataFin)
		dbSelectArea( "SRA" )
		dbSkip()
		Loop
	Endif

	wCabec1	:=  Left(AllTrim(aInfo[3]),60)//Razao Social
	//Filial
	wCabec2	:=  IIF(Len(AllTrim(aInfo[1])) > 27,Left(AllTrim(aInfo[1]),28),STR0011 + AllTrim(aInfo[1]))
	//Endereco + Complemento + Bairro
	wCabec3 :=  alltrim(aInfo[4]) + " - " + If(len( AllTrim( ainfo[14] ) ) > 0  , AllTrim( aInfo[14] ) + " - " + AllTrim( aInfo[13] ), AllTrim( aInfo[13] ) )
	If nGrafica  == 1
		wCabec0	:= 9
   		wCabec4 :=  alltrim(aInfo[5]) + " - " + aInfo[6]
		wCabec5	:=  STR0031  + Transform(aInfo[7],"@R #####-###")          //CEP

		IF cPaisLoc == "ANG"
			wCabec6 :=  STR0113  + aInfo[8]											//NIF
		ELSE
			Do Case
				Case ( aInfo[28] == 1 )
					wCabec6 := STR0047 + Transform(aInfo[27],"@R ##.###.###/####-##") 	//CEI
				Case (aInfo[28] == 3 )
					wCabec6 := STR0144 + Transform(aInfo[8],"@R ###.###.###-##")	//CPF
				Otherwise
					wCabec6 := STR0032 + Transform(aInfo[8],"@R ##.###.###/####-##")//CNPJ
			EndCase
			wCabec7	:=  STR0033  + aInfo[16]										//CNAE
		ENDIF

		wCabec8	:=  STR0034  + aInfo[19]	 								//Cod.Munic.:"

	Else
		wCabec0	:= 6
		wCabec4 :=  Alltrim(aInfo[5]) + " - " + aInfo[6] + space(1)+ STR0031 + Transform(aInfo[7],"@R #####-###") 					//Municipio / Estado
		wCabec5 :=  STR0032  + Transform(aInfo[8],"@!R NN.NNN.NNN/NNNN-99")+space(5) + STR0033  + aInfo[16]+space(5)+STR0034  + aInfo[19] //CGC
		WCabec6	:=  STR0004  + "  " + If(!lNUse,SRA->RA_FICHA," ") + " "+ SRA->RA_MAT + " - " + SRA->RA_NOME
	Endif

	nLin := 0
	li	 := 0
	lImpressao 	:= .F.
	fImpFch()

	If lSalar
		fImpSal()
		If cPaisLoc=="PTG"
			fImpCat()//Alteracoes de Categorias
		Endif
	Endif

	If nAfast == 1 .Or. nAfast == 3
		fImpAfas()
	Endif

	If nferias == 1
		fImpFer()
	Endif

	If nAltcad == 1
		fImpCad()
	Endif

	If lDepen
		fImpDep()
	Endif

	If lBenefic
		fImpBen()
	Endif

	If nConSin == 1 .or. nContAss == 1
		fImpSin()
	Endif

	If nTransf == 1 .Or. nTransf == 2
		fImpTra()
	EndIf

	If nTreina == 1
		fImpTrei()
		fImpCur()
	Endif

	If SRA->RA_TPCONTR == "3" // Funcionário intermitente
		fImpConvoc()
	EndIf

	If lImpressao
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Periodo de impressao                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fImpPeriodo()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Assinaturas                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fAssinaBox()
	Endif

	aCampo 	:= {}
	lFirst	:= .T.
	dbSelectarea("SRA")
	dbSkip()
Enddo
If(nGrafica ==2,IMPR("","F"),oPrint:EndPage())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SRA")
If Type("cFiltraRH") == "U" .Or. Empty(cFiltraRH)
Set Filter to
EndIf
dbSetOrder(1)
dbGoTop()

Set Device To Screen
If aReturn[5] = 1  .and. nGrafica # 1
	Set Printer To
	Commit
	ourspool(wnrel)
Endif
MS_FLUSH()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fImpFch  ³ Autor ³ R.H. - Mauro          ³ Data ³ 04.06.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao Ficha Atualizada                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ fImpFch()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static function fImpfch()

	Local aArea		:= GetArea()
	Local aAreaSX3	:= {}

	Local cCabCpo,cCampo,cFolder,cOrdem,cAux
	Local nSal 		:= 0
	Local lPrint 	:= .F.
	Local aCampos	:= { 	{ "RA_NOME", "001" },;		// Lista de campos da ficha opção Legislação
							{ "RA_NASC", "002" },;
							{ "RA_PAI", "003" },;
							{ "RA_MAE", "004" },;
							{ "RA_NACIONA", "005" },;
							{ "RA_NATURAL", "006" },;
							{ "RA_NUMCP", "007" },;
							{ "RA_SERCP", "008" },;
							{ "RA_PIS", "009" },;
							{ "RA_ADMISSA", "010" },;
							{ "RA_CARGO", "011" },;
							{ "RA_DCARGO", "012" },;
							{ "RA_CODFUNC", "013" },;
							{ "RA_DESCFUN", "014" },;
							{ "RA_SALARIO", "015" },;
							{ "RA_TNOTRAB", "016" },;
							{ "RA_DESCTUR", "017" } }

	Private	nPosT


	/*	Teste para o ADVPR (Automação de Testes) - lRobo vem .T. do Caso de Teste	*/
	IF TYPE ("lRobo") == "L"
		If lRobo
			fIncCpsSX3()
			Gpea260FhcConf()
		Endif
	Endif

	cDet    := " "
	dbSelectArea("SX3")
	dbSetOrder(1)
	dbSeek("SRA")
	dbSetOrder(1)
	While ( !Eof() .And. SX3->X3_ARQUIVO == "SRA" )

		uCampo := SX3->X3_CAMPO

		If lFicha

			If Alltrim(uCampo) $ 'RA_FILIAL|RA_MAT|RA_NOME|RA_BITMAP|RA_FICHA'
				SX3->(dbSkip())
				Loop
			Endif

			If lAnotacoes
				/*
					Art. 2º O registro de empregados de que trata o art. 41 da CLT conterá as seguintes
					informações:
					I - nome do empregado, data de nascimento, filiação, nacionalidade e naturalidade;
					II - número e série da Carteira de Trabalho e Previdência Social - CTPS;
					III - número de identificação do cadastro no Programa de Integração Social - PIS ou no 	Programa de Formação do Patrimônio do Serviço Público - PASEP;
					IV - data de admissão;
					V - cargo e função;
					VI - remuneração;
					VII - jornada de trabalho;
				*/

				nPosT  := Ascan(aCampos,{|X| X[1] == AllTrim(uCampo) })
				If (Empty(nPosT))
					SX3->(dbSkip())
					Loop
				Endif
			Endif

			nPosT  := Ascan(aDicioT,{|X| Subs(X,36,10) == uCampo })
			lPrint := nPosT <> 0 .And. Subs(aDicioT[nPosT],29,1) == 'X'

			If lPrint
				If lAnotacoes
					nPosT  := Ascan(aCampos,{|X| X[1] == AllTrim(uCampo) })
				Endif

				IF ( SX3->X3_CONTEXT == "V"  )
					If alltrim(uCampo) == "RA_DESCCC"
						cCampo :=  fDesc("CTT",SRA->RA_CC,"CTT_DESC01",,SRA->RA_FILIAL)

					ElseIf alltrim(uCampo) == "RA_DESCFUN"
						cCampo :=  fDesc("SRJ",SRA->RA_CODFUNC,"RJ_DESC",,SRA->RA_FILIAL)

					ElseIf alltrim(uCampo) == "RA_DCARGO"
						// Primeiro busca com o Centro de Custo
						cCampo := Posicione("SQ3",1,xFilial("SQ3",SRA->RA_FILIAL)+SRA->RA_CARGO+SRA->RA_CC, "Q3_DESCSUM")
						If Empty(cCampo)
							cCampo := Posicione("SQ3",1,xFilial("SQ3",SRA->RA_FILIAL)+SRA->RA_CARGO, "Q3_DESCSUM")
						EndIf
					ElseIf alltrim(uCampo) == "RA_DDEPTO"
						cCampo :=  fDesc('SQB',SRA->RA_DEPTO,'QB_DESCRIC',,SRA->RA_FILIAL)

					ElseIf alltrim(uCampo) == "RA_DESCTUR"
						cCampo := fDesc("SR6",SRA->RA_TNOTRAB,"R6_DESC",,SRA->RA_FILIAL)

					ElseIf alltrim(uCampo) == "RA_DESCNAC"
						cCampo := IF(!EMPTY(SRA->RA_TABELA),Tabela("34",SRA->RA_NACIONA),"")

					ElseIf alltrim(uCampo) == "RA_DESCHAB"
						If cPaisLoc == "ANG" .or. cPaisLoc == "EQU" .or. cPaisLoc == "PTG"
							cCampo := fDescRCC("S002",SRA->RA_HABESCO,1,2,3,30)
						Else
							cCampo := ' '
						EndIf

					ElseIf alltrim(uCampo) == "RA_DESCAT"
						If cPaisLoc == "ANG" .or. cPaisLoc == "EQU" .or. cPaisLoc == "PTG"
							cCampo := fDesc("RGG",SRA->RA_CODCAT+SRA->RA_CODIRCT,"RGG_DESCRI",,SRA->RA_FILIAL)
						Else
							cCampo := " "
						EndIf

					ElseIf alltrim(uCampo) == "RA_DESCONT"
						If cPaisLoc == "ANG" .or. cPaisLoc == "EQU" .or. cPaisLoc == "PTG" .or. cPaisLoc == "COL"  .or. cPaisLoc == "PER"  .or. cPaisLoc == "VEN"
							cCampo := fDescRCC("S016",SRA->RA_TIPOCO,1,2,3,30)
						Else
							cCampo := ' '
						EndIf

					ElseIf alltrim(uCampo) == "RA_BIDESCE"
						If cPaisLoc == "ANG" .or. cPaisLoc == "EQU" .or. cPaisLoc == "PTG"
							cCampo := POSICIONE("SX5",1,XFILIAL("SX5")+"12"+SRA->RA_BIESTEM,"X5_DESCRI")
						Else
							cCampo := ' '
						EndIf
					ElseIf alltrim(uCampo) == "RA_CODCBO"
						cCampo :=  fDesc("SRJ",SRA->RA_CODFUNC,"RJ_CODCBO",,SRA->RA_FILIAL)
					Else
						cCampo := CriaVar(SX3->X3_CAMPO)
					Endif
				Else
					cCampo 	:= SRA->( FieldGet(FieldPos(uCampo)) )

					If AllTrim(uCampo) == "RA_SALARIO"
						If nTipoSal == 2
							nSal := fSalAdm()
							If nSal <> 0
								cCampo := Transform(nSal,"@E 999,999,999.99")
							EndIf
						EndIf
					EndIf

					If alltrim(ucampo) == "RA_SEXO"
						cCampo	:= fDescSexo( cCampo)
					ElseIf alltrim(ucampo) == "RA_TPCONTR"
						If(cCampo == '3')
							cCampo := STR0149 //-- Intermitente
						Elseif(cCampo == '2')
							cCampo := STR0067 //-- Determinado
						Else
							cCampo := STR0066 //-- Indeterminado
						Endif
					ElseIf alltrim(ucampo) == "RA_RACACOR"
						If cCampo =="1"
							cCampo	:= STR0068			//-- Indigena
						elseIf cCampo=="2"
							cCampo := STR0069 			//-- Branca
						elseif cCampo = "4"
							cCampo := STR0070			//-- Preta
						elseif cCampo = "6"
							cCampo := STR0071			//-- Amarela
						elseif cCampo = "8"
							cCampo := STR0072			//-- Parda
						elseif cCampo = "9"
							cCampo := STR0073 			//-- Nao Informado
						Endif
					ElseIf AllTrim(uCampo) == "RA_CATCNH"
						If !Empty(SRA->RA_CATCNH)
							cAux := X3CBOX()
							cAux := SubStr(cAux, AT(SRA->RA_CATCNH + "=",cAux))
							If At(";",cAux) > 0
								cAux := SubStr(cAux,3,At(";",cAux)-3)
							Else
								cAux := Alltrim(SubStr(cAux,3))
							EndIf
							cCampo := cAux
						Else
							cCampo := SRA->RA_CATCNH
						EndIf
					ElseIf alltrim(uCampo) == "RA_DEFIFIS"
						cCampo	:= If(cCampo == "1",STR0074, STR0075)
					ElseIf alltrim(uCampo) == "RA_ESTCIVI"
						cCampo := Substr(fDesc("SX5","33"+cCampo,"X5DESCRI()"),1,12)
					ElseIf alltrim(uCampo) == "RA_TPDEFFI"
						Do Case
							Case cCampo == "0"
								cCampo := STR0101		//Nenhuma
							Case cCampo == "1"
								cCampo := STR0102       //Fisica
							Case cCampo == "2"
								cCampo := STR0103		//Auditiva
							Case cCampo == "3"
								cCampo := STR0104		//Visual
							Case cCampo == "4"
								cCampo := STR0105		//Intelectual (Mental)
							Case cCampo == "5"
								cCampo := STR0106		//Multipla
							Case cCampo == "6"
								cCampo := STR0107		//Reabilitado
							Otherwise
								cCampo := ""
						EndCase
					ElseIf alltrim(uCampo) == "RA_NACIONA"
						cCampo := Substr( fDesc( "SX5", "34" + cCampo, "X5DESCRI()" ), 1, 25 )
					ElseIf alltrim(uCampo) == "RA_NOMECMP" //NOME COMPLETO
						cCampo := Substr(cCampo, 1, 62)
					ElseIf alltrim(ucampo) == "RA_HOPARC"
						If cCampo == "1"
							cCampo	:= STR0074 			// Sim
						elseIf cCampo == "2"
							cCampo := STR0075 			// Não
						Endif
					ElseIf  alltrim(ucampo) == "RA_COMPSAB"
						If cCampo == "1"
							cCampo	:= STR0074  		// Sim
						elseIf cCampo == "2"
							cCampo := STR0075 			// Não
						Endif
					ElseIf Alltrim(uCampo) == "RA_ADCINS"
						cCampo := fDescIns(cCampo)
					EndIf
				Endif

				If ValType(cCampo) = "D"
					cCampo := Dtoc(cCampo)
				Elseif ValType(cCampo) = "N"
					cPict := Alltrim(SX3->X3_PICTURE)
					If ! lAnotacoes
						cPict := "@E "+Replicate("9",Val(Subs(aDicioT[nPosT],49,3)) )
						If Val(Subs(aDicioT[nPosT],52,2)) > 0
							cPict += "."+Replicate("9",Val(Subs(aDicioT[nPosT],52,2)) )
						Endif
					EndIf
					cCampo := Transform(cCampo,cPict)
				ElseIf ValType(cCampo)="L"
					If cCampo	:= .F.
						cCampo 	:= "F"
					Else
						cCampo	:= "T"
					Endif
				Endif
				cFolder := "01"
				If lAnotacoes
					cCabCpo := fTacento(AllTrim(X3Titulo()))
					cOrdem  := aCampos[nPosT][2]
				Else
					cCabCpo := fTacento(AllTrim(Subs(aDicioT[nPosT],1,12)))
					cFolder := subs(aDicioT[nPosT],54,2)
					cOrdem  := subs(aDicioT[nPosT],56,3)
				EndIf
				aAdd(aCampo,{cCabCpo,cCampo,cFolder,cOrdem,SX3->X3_TIPO})
			EndIf
		Else
			If Alltrim(uCampo)$ 'RA_NASC | RA_PAI | RA_MAE | RA_NACIONA | RA_NATURAL | RA_NUMCP | RA_SERCP | RA_PIS | RA_ADMISSA | RA_CARGO | RA_DCARGO | RA_CODFUNC | RA_DESCFUN | RA_SALARIO | RA_TNOTRAB | RA_DESCTUR'
				If SRA->(FieldPos(uCampo)) >0
					cCabCpo := SX3->X3_TITULO
					dbSelectArea("SRA")
					cCampo	 := &(alltrim("SRA->" + uCampo))

					If AllTrim(uCampo) == "RA_SALARIO" .And. nTipoSal == 2
						nSal := fSalAdm()
						If nSal <> 0
							cCampo := Transform(nSal,"@E 999,999,999.99")
						elseif cCampo <> 0					
							cCampo := Transform(cCampo,"@E 999,999,999.99")
						EndIf
					Else
						If ValType(cCampo) = "D"
							cCampo := Dtoc(cCampo)
						Elseif ValType(cCampo) = "N"
							cPict := Alltrim(SX3->X3_PICTURE)
							cCampo := Transform(cCampo,cPict)
						ElseIf ValType(cCampo)="L"
							If cCampo	:= .F.
								cCampo 	:= "F"
							Else
								cCampo	:= "T"
							Endif
						Endif
					EndIf
					cFolder := SX3->X3_FOLDER
					cOrdem  := SX3->X3_ORDEM

					aAdd(aCampo,{cCabCpo,cCampo,cFolder,cOrdem,SX3->X3_TIPO})
				EndiF
			Endif
		Endif
		dbSelectArea("SX3")
		dbSkip()
	EndDo

	aSort( aCampo,,,{ |x,y| x[3]+x[4] < y[3]+y[4] } )

	If Len(aCampo) > 0
		If nGrafica == 1
			fImpGraf(aCampo)
		Else
			fImpNorm(aCampo)
		Endif
		lImpressao	:= .T.
	Endif

	RestArea( aArea)
	//--SET CENTURY OFF
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fImpSal  ³ Autor ³ R.H. - Mauro          ³ Data ³ 04.06.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao Alteracao Salarial                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ fImpSal()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static function fImpSal()
Local aArea		:= GetArea()
Local aSal	    := {}
Local aTar	    := {}
Local cChaveSort:= ""
Local cMotivo	:= ""
Local lImpSal	:= .T.
Local nPos		:= 0
Local dDataDiss := CToD("//")

Private cCategAnt	:= SRA->RA_CATFUNC // Cateroria do funcionario no periodo de impressao selecionado

// Verifica se o funcionario era Professor/Tarefeiro anteriormente
If !(SRA->RA_CATFUNC $ "I#J#T")
	DbSelectArea("SR7")
	DbSetOrder(2)
	If SR7->(dbSeek(SRA->RA_FILIAL+SRA->RA_MAT))
		While SR7->( !EOF()) .And. SRA->RA_FILIAL+SRA->RA_MAT = SR7->R7_FILIAL+SR7->R7_MAT
			If !(SR7->R7_CATFUNC == SRA->RA_CATFUNC) .And. SR7->R7_CATFUNC $ "I#J#T"
				cCategAnt := SR7->R7_CATFUNC
			EndIf
			SR7->(DbSkip())
		EndDo
	EndIf
EndIf

//-- Professores e Tarefeiros
If (SRA->RA_CATFUNC $ "I#J#T" .Or. cCategAnt $ "I#J#T") .and. (nImpSalTar== 2 .or. nImpSalTar== 3)
	dbSelectArea("SRO")
	dbSeek(SRA->RA_FILIAL+SRA->RA_MAT)
	While SRO->( !EOF()) .And. SRO->RO_FILIAL+SRO->RO_MAT == SRA->RA_FILIAL+SRA->RA_MAT
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica periodo de impressao³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ( !Empty(SRO->RO_DATAATE) .and. SRO->RO_DATAATE < dDataIni ) .or. (SRO->RO_DATA > dDataFin)
			SRO->(dbSkip())
			Loop
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Filtra tipos de tarefas      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SRA->RA_CATFUNC $ "I#J" .Or. cCategAnt $ "I#J"
			If cPaisLoc == "BRA"
				If !( SRO->RO_TIPO $ uTarefa )
					SRO->(dbSkip())
					Loop
				EndIf
			Else
				If ( uTarefa == 1 .And. SRO->RO_TIPO # "1" ) .Or. ( uTarefa == 2 .And. SRO->RO_TIPO # "2" )
					SRO->(dbSkip())
					Loop
				EndIf
			EndIf
		Endif

		If SRO->RO_QUANT == 0
			SRO->(dbSkip())
			Loop
		Endif
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Cabecalho tabela               ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		If Len(aSal) = 0 .And. Len(aTar) = 0
			If nGrafica == 1 .or. !(SRA->RA_CATFUNC $ "I#J" .And. cCategAnt $ "I#J")
				//---*** Professor ***---
				//" Tp. Tarefa  Data De    Data Ate   Tarefa                   Aulas Semana Qtde. Tarefa   Valor Unitario      Valor Total
				//  xxxxxxxx    99/99/9999 99/99/9999 999-XXXXXXXXXXXXXXXXXXXX   999,999.99 9,999,999.99 999,999,999.9999 999,999,999.9999
				Aadd(aTar ,{STR0086,STR0087,STR0088,STR0089,STR0090,STR0091,STR0092,STR0093,""}) //STR0094,STR0095
			Else
						//  Data De |Data Ate|Tarefa        |Aul/Sem.|Q.Tar.|  Vl. Unitario|     Vl Total
				Aadd(aTar ,{STR0086,STR0087,STR0088,STR0089,STR0096,STR0097,STR0098,STR0093,""}) //STR0094,STR0095
			EndIf
		Endif
		cChaveSort := DTOS(SRO->RO_DATA)+StrZero(SRO->RO_VALOR,15)+StrZero(SRO->(Recno()),15) + "0"
        //cTipoTar := If( SRO->RO_TIPO == "1","Fixa","Variavel")

        If SRO->RO_TIPO == "1"
        	cTipoTar := OemtoAnsi(STR0114)	//"Fixa"
        ElseIf SRO->RO_TIPO  == "2"
        	cTipoTar := OemtoAnsi(STR0115)	//"Variavel"
        ElseIf SRO->RO_TIPO  == "3"
        	cTipoTar := OemtoAnsi(STR0116)	//"Adit. Fixo"
        ElseIf SRO->RO_TIPO  == "4"
        	cTipoTar := OemtoAnsi(STR0117) 	//"Adit. Var."
        EndIf

		If nGrafica == 1 .or. !(SRA->RA_CATFUNC $ "I#J" .And. cCategAnt $ "I#J")
			Aadd(aTar,{cTipoTar,DTOC(SRO->RO_DATA),DTOC(SRO->RO_DATAATE),SRO->RO_CODTAR+"-"+U_fDescTarefa(SRO->RO_CODTAR),Transform(SRO->RO_QTDSEM,"@E 9,999,999.99"),Transform(SRO->RO_QUANT,"@E 9,999,999.99"),Transform(SRO->RO_VALOR,"@E 99,999,999.99"),Transform(SRO->RO_VALTOT,"@E 99,999,999.99"),cChaveSort })
   		Else
			Aadd(aTar,{cTipoTar,DTOC(SRO->RO_DATA),DTOC(SRO->RO_DATAATE),SRO->RO_CODTAR+"-"+U_fDescTarefa(SRO->RO_CODTAR),Transform(SRO->RO_QTDSEM,"@E 999.99"),Transform(SRO->RO_QUANT,"@E 999.99"),Transform(SRO->RO_VALOR,"@E 99,999,999.99"),Transform(SRO->RO_VALTOT,"@E 99,999,999.99"),cChaveSort })
		EndIf

		// Impressao do motivo da alteracao da tarefa
		If cPaisLoc $ "BRA"
			If (SRA->RA_CATFUNC $ "I*J" .Or. cCategAnt $ "I#J") .And. !Empty(SRO->RO_TPALT)

				dbSelectArea( "SX5" )
				If dbSeek( xFilial("SX5", SRA->RA_FILIAL) + "41" + SRO->RO_TPALT )
					cMotivo := fTAcento( SubStr(X5Descri(),1,31) )
				Endif

				If !Empty(cMotivo)
					Aadd(aTar,{"","","",STR0119+cMotivo,"","","","",Soma1(cChaveSort)})
				EndIf

				dbSelectArea("SRO")
			EndIf
		EndIf

		SRO->( dbSkip() )
	EndDo
EndIf

lImpSal := .T.

lImpSal := If ( SRA->RA_CATFUNC $ "I#J#T" .and. nImpSalTar== 2 ,.F., lImpSal)

If lImpSal
	dbSelectArea("SR7")
	SR7->(DbSetOrder(2))

    dbSelectArea("SR3")
    SR3->(DbSetOrder(2))

    If SR7->(dbSeek(SRA->RA_FILIAL+SRA->RA_MAT))
		While SR7->( !EOF()) .And. SRA->RA_FILIAL+SRA->RA_MAT = SR7->R7_FILIAL+SR7->R7_MAT
			nVez := 0
			dbSelectArea("SX5")
			SX5->(dbSeek(xFilial("SX5", SRA->RA_FILIAL)+"41"+SR7->R7_TIPO))
			If !SX5->(Eof())
				cDescS := fTAcento(SUBS(X5Descri(),1,20))
			Else
				cDescS := STR0017  //"Nao Cad. Tabela(41) "
			Endif

		    If SR3->(dBseek(SR7->R7_FILIAL+SR7->R7_MAT+DTOS(SR7->R7_DATA)+SR7->R7_SEQ+SR7->R7_TIPO))
			    While SR3->(!Eof()) .And. SRA->RA_FILIAL+SRA->RA_MAT = SR3->R3_FILIAL+SR3->R3_MAT .And. SR3->R3_DATA = SR7->R7_DATA .And. SR7->R7_SEQ = SR3->R3_SEQ .And. SR7->R7_TIPO = SR3->R3_TIPO
					dDataDiss := IIf( cPaisLoc == "BRA", SR3->R3_DTCDISS, SR3->R3_DATA)

					//Verifica periodo de impressao
					If SR3->R3_DATA < dDataIni .or. SR3->R3_DATA > dDataFin
						SR3->(dbSkip())
						Loop
					Endif

					// Cabecalho tabela
					If Len(aSal) = 0
						Aadd(aSal ,{STR0013,STR0014,STR0016,STR0053,STR0054,STR0055,STR0035,STR0063, "",If(nGrafica == 1, STR0143, STR0142) }) 	//###"Desc.Cargo"
						//" Data        Desc.Aumento            Cat.   Pgto.      Verba                          Valor    Funcao"
						//  99/99/9999  xxxxxxxxxxxxxxxxxxxx     x      x         xxxxxxxxxxxxxxxxxxxx   99.999.999,99    xxxxxxxxxxxxxx
					Endif

					//imprime somente a ultima alteração referente a mesma data por dissidio
					If cPaisLoc == "BRA" .And. !Empty(dDataDiss)
						nPos := Ascan(aSal,{|x| x[10] == DTOC(dDataDiss) })
						If nPos > 0 .And. SR7->R7_DATA > ctod(aSal[nPos][1])
							aDel(aSal,nPos)
							aSize(aSal,Len(aSal)-1)
						EndIf
					EndIf

					cChaveSort := DTOS(SR7->R7_DATA)+StrZero(SR3->R3_VALOR,15)+StrZero(SR3->(Recno()),15) + "0"
					If nVez = 0
						Aadd(aSal,{DTOC(SR7->R7_DATA),cDescS,SR7->R7_CATFUNC,SR7->R7_TIPOPGT,Subs(SR3->R3_DESCPD,1,15),Transform(SR3->R3_VALOR,"@E 99,999,999.99"),SR7->R7_DESCFUN,SR7->R7_DESCCAR,cChaveSort,DTOC(dDataDiss) })
						nVez := 1
					Else
						Aadd(aSal,{DTOC(SR7->R7_DATA),"","","",Subs(SR3->R3_DESCPD,1,15),Transform(SR3->R3_VALOR,"@E 99,999,999.99"),SR7->R7_DESCFUN,SR7->R7_DESCCAR, cChaveSort,DTOC(dDataDiss) })
					EndIf
					SR3->(dbSkip())
				Enddo
			EndIf
			SR7->(dbSkip())
		Enddo
	EndIf
EndIf

If !empty(aSal) .and. Len(aSal) > 1

	If nGrafica == 1
		fImpSalG(aSal,"S")
	Else
		fImpSalN(aSal,"S")
	Endif
	lImpressao	:= .T.
Endif

If !empty(aTar) .and. Len(aTar) > 1

	aSort( aTar,,,{ |x,y| x[9] < y[9] } )
	If nGrafica == 1
		fImpSalG(aTar,"T")
	Else
		fImpSalN(aTar,"T")
	Endif
	lImpressao	:= .T.
Endif

RestArea( aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fImpCat  ³ Autor ³ R.H. - SSERVICE       ³ Data ³ 27.05.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao Alteracao Categoria                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ fImpCat()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static function fImpCat()
Local aCat	     := {}
Local cChaveSort := "", cDescCat:=Space(60)
Local cDadSra	 :=SRA->RA_FILIAL+SRA->RA_MAT
If ChkFile("RGH")
	dbSelectArea("RGH")
	RGH->(DbSetOrder(RetOrder("RGH","RGH_FILIAL+RGH_MAT+RGH_DTINIC")))
	If dbSeek(cDadSra)
		Do While RGH->(!Eof()) .And. SRA->RA_MAT==RGH->RGH_MAT
			/*
			ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			³ Cabecalho tabela               ³
			ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
			If Len(aCat) = 0
					Aadd(aCat ,{STR0108,STR0109})
							  //" Data         Desc.Categoria                                                            "
					          //  99/99/9999   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx->60 caractere
			Endif

			cDescCat:=Space(60)
			dbSelectArea("RGG")
			RGG->(DbSetOrder(RetOrder("RGG","RGG_FILIAL+RGH_CODIGO+RGG_CODIRC")))

			If cPaisLoc == "ANG" .or. cPaisLoc == "EQU" .or. cPaisLoc == "PTG"
				If dbSeek(xFilial("RGG")+RGH->RGH_CODCAT+RGH->RGH_CODIRC)
					cDescCat := Substr(Alltrim(RGG->RGG_DESCRI),1,60)
				Endif
			Else
				cDescCat := " "
			EndIf

			cChaveSort := DTOS(RGH->RGH_DTINIC)
			Aadd(aCat,{DTOC(RGH->RGH_DTINIC),cDescCat,cChaveSort })
			dbSelectArea("RGH")
			RGH->(dbSkip())
		Enddo


		If !empty(aCat) .and. Len(aCat) > 1
			aSort( aCat,,,{ |x,y| x[1] < y[1] } )//Ordenando por Data
			If nGrafica == 1
				fImpCatG(aCat)
			Else
				fImpCatN(aCat)
			Endif
			lImpressao	:= .T.
		Endif
	Endif
Endif
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fDescIns ³ Autor ³ R.H. - Henrique F.      Data ³ 17.01.18 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ impressao da descrição do tipo de insalubridade            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ fDescIns()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fDescIns(cCod)

	Local cDesc := ""

	Do Case
		Case Empty(AllTrim(cCod)) .Or. AllTrim(cCod) == "1"
			cDesc := STR0145 // Não Possui
		Case Alltrim(cCod) == "2"
			cDesc := STR0146 // Insalubridade Mínina.
		Case AllTrim(cCod) == "3"
			cDesc := STR0147 // Insalubridade Média
		Otherwise
			cDesc := STR0148 // Insalubridade Máxima.
	EndCase

Return cDesc



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fImpAfas ³ Autor ³ R.H. - Mauro          ³ Data ³ 04.06.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ impressao de afastamentos                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ fImpAfas()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static function fImpAfas()
Local aArea		:= GetArea()

Local aAfas := {}
Local cTpAf := ""

dbSelectArea("SR8")
dbSeek(SRA->RA_FILIAL+SRA->RA_MAT)
While ! Eof() .And. SRA->RA_FILIAL+SRA->RA_MAT = SR8->R8_FILIAL+SR8->R8_MAT

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica periodo de impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SR8->R8_DATAINI < dDataIni .or. SR8->R8_DATAINI > dDataFin
		dbSkip()
		Loop
	Endif

	If Len(aAfas) = 0
		Aadd(aAfas,{STR0013,STR0019,STR0020,STR0022})  //"|Data       Tipo                                   Data Inicio      Data Fim   "
	Endif

	dbSelectArea("RCM")
   	RCM->(dbSeek( xFilial("RCM") + SR8->R8_TIPOAFA))
	If ! eof()
		cDescA := fTacento(RCM->RCM_DESCRI)
	Else
       cDescA := STR0141
	Endif

	dbSelectArea("SR8")
	cTpAf := fCarTpAf(SR8->R8_TIPOAFA)
	If nAfast != 3
		If cTpAf # "F" .Or. (cTpAf == "F" .And. SRA->RA_CATFUNC $ "E*G")
			Aadd(aAfas,{DTOC(SR8->R8_DATA),alltrim(cDescA),DTOC(SR8->R8_DATAINI),DTOC(SR8->R8_DATAFIM) })
		EndIf
	Else
		If cTpAf # "F" .And. (SR8->R8_DURACAO > 15 .Or. SR8->R8_TIPO $ "O|P|Q")
			Aadd(aAfas,{DTOC(SR8->R8_DATA),alltrim(cDescA),DTOC(SR8->R8_DATAINI),DTOC(SR8->R8_DATAFIM) })
		EndIf
	EndIf
	dbSkip()
Enddo
If !Empty(aAfas) .and. Len(aAfas) > 1
	 If nGrafica ==1
	 	fImpAfasG(aAfas)
	 Else
	 	fImpAfasN(aAfas)
	 Endif
     lImpressao	:= .T.
Endif

RestArea( aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fImpFer  ³ Autor ³ R.H. - Mauro          ³ Data ³ 04.06.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ impressao de Ferias                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ fImpFer()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static function fImpFer()
Local aArea		:= GetArea()
Local aFerias := {}

dbSelectArea("SRH")
dbSeek(SRA->RA_FILIAL+SRA->RA_MAT)
While ! Eof() .And. SRA->RA_FILIAL+SRA->RA_MAT = SRH->RH_FILIAL+SRH->RH_MAT

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica periodo de impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SRH->RH_DATAINI < dDataIni .or. SRH->RH_DATAINI > dDataFin
		dbSkip()
		Loop
	Endif

	If Len(aFerias) = 0
		Aadd(aFerias,{ STR0023,STR0056,STR0057,STR0058,STR0079,STR0080,STR0140 } )  //"|Periodo Aquisitivo   Periodo de Ferias       Data do Aviso    Data Pagto. D.Ferias D.Abono D.Lic.Rem."
	Endif
	Aadd(aFerias,{DTOC(SRH->RH_DATABAS)+ " a "+DTOC(SRH->RH_DBASEAT), ;
		          DTOC(SRH->RH_DATAINI) +" a " +DTOC( SRH->RH_DATAFIM - If( lFerLic, 0, SRH->RH_DIALRE1 + SRH->RH_DIALREM ) ), ;
	       		  DTOC(SRH->RH_DTAVISO) , DTOC(SRH->RH_DTRECIB)      , ;
        		  STR(SRH->RH_DFERIAS), STR(SRH->RH_DABONPE), STR(SRH->RH_DIALRE1 + SRH->RH_DIALREM) })
	dbSkip()
Enddo

If !Empty(aFerias) .and. Len(aFerias) > 1
	If nGrafica==1
		fImpFeriaG(aFerias)
	Else
		fImpFeriaN(aFerias)
	Endif
	lImpressao	:= .T.
Endif

RestArea( aArea)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fImpCad  ³ Autor ³ R.H. - Mauro          ³ Data ³ 04.06.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ impressao de Alt.Cadastrais                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ fImpCad()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static function fImpCad()
Local aArea	  := GetArea()
Local aAltCad := {}
Local cDescr := ""

cDet := ""

dbSelectArea("SR9")
DbSetOrder(2)
dbSeek(SRA->RA_FILIAL+SRA->RA_MAT)
While ! Eof() .And. SRA->RA_FILIAL+SRA->RA_MAT = SR9->R9_FILIAL+SR9->R9_MAT

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica periodo de impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SR9->R9_DATA < dDataIni .or. SR9->R9_DATA > dDataFin
		dbSkip()
		Loop
	Endif

	If Len(aAltCad) = 0
		Aadd(aAltCad,{ STR0013,STR0025,STR0059})  //"Data         Campo Alterado    Descricao"
	Endif
	nPos    := Ascan(aDicioT,{ |x| Subs(x,36,10)=SR9->R9_CAMPO })
	If nPos > 0
		cTitulo := fTAcento(Subs(aDicioT[nPos],1,12))
		If AllTrim(SR9->R9_CAMPO) == "RA_ADCINS" // Retorna a descrição, conforme o código da insalubridade.
			cDescr := fDescIns(SR9->R9_DESC)
		ElseIf AllTrim(SR9->R9_CAMPO) == "RA_CARGO"
			cDescr := fDesc ("SQ3",Alltrim(SR9->R9_DESC),"Q3_DESCSUM")
		Else
			cDescr := SR9->R9_DESC
		EndIf
		Aadd(aAltCad,{DTOC(SR9->R9_DATA), cTitulo,cDescr	} )
	Endif
	dbSkip()
Enddo
SR9->(DbSetOrder(1))
If !Empty(aAltCad) .and. Len(aAltCad) > 1
	If nGrafica ==1
		fImpCadG(aAltCad)
	Else
		fImpCadN(aAltCad)
	Endif
	lImpressao	:= .T.
Endif

RestArea( aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fImpDep  ³ Autor ³ R.H. - Mauro          ³ Data ³ 04.06.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ impressao de Dependentes                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ fImpDep()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static function fImpDep()
Local aArea		:= GetArea()

Local aDep := {}
Local m_sexo		:= ""
Local m_graupar 	:= ""
Local m_TipIR		:= ""
Local m_TipSF		:= ""

dbSelectArea("SRB")
dbSeek(SRA->RA_FILIAL+SRA->RA_MAT)
While ! Eof() .And. SRA->RA_FILIAL+SRA->RA_MAT = SRB->RB_FILIAL+SRB->RB_MAT
	If Len(aDep) = 0
		Aadd(aDep,{STR0027,STR0026,STR0037,STR0038,STR0040,STR0048,STR0050} )  //"|Cod|Dependente                     Dt.Nasc  Sexo Parent IR  S.F."
	Endif
    m_Sexo		:= fDescSexo(SRB->RB_SEXO)

	//Correcao dos menus de opcoes RB_GRAUPAR
    If SRB->RB_GRAUPAR  == "F"
    	m_graupar	:=  STR0076		 //"Filho"
    ElseIf SRB->RB_GRAUPAR  == "C"
    	m_graupar 	:=  STR0077 	 //"Conjuge"
    ElseIf SRB->RB_GRAUPAR  == "P"
    	m_graupar 	:= STR0126		 //"Pai/Mae"
    ElseIf SRB->RB_GRAUPAR  == "E"
    	m_graupar 	:= STR0127	 	 //"Enteado"
    Else
    	m_graupar 	:=  STR0078 	 //"Outros"
    EndIf

    m_TipIR		:= If(SRB->RB_TIPIR =="4", STR0075, STR0074)
    m_TipSF		:= If(SRB->RB_TIPSF =="3", STR0075, STR0074)

	If ascan(aDep,{ |x| ( x[2] == SRB->RB_NOME .AND. x[3] == Dtoc(SRB->RB_DTNASC) ) } ) == 0
		If Len(Alltrim(SRB->RB_NOME)) <= 40
			Aadd(aDep,{SRB->RB_COD,AllTrim(SRB->RB_NOME),Dtoc(SRB->RB_DTNASC),M_SEXO,M_GRAUPAR,M_TIPIR,M_TIPSF,SRB->RB_NOME ,.F.})
		Else
			Aadd(aDep,{SRB->RB_COD,SRB->RB_NOME,Dtoc(SRB->RB_DTNASC),M_SEXO,M_GRAUPAR,M_TIPIR,M_TIPSF,substr(SRB->RB_NOME,1,40),.F. })
			Aadd(aDep,{SRB->RB_COD,SRB->RB_NOME,Dtoc(SRB->RB_DTNASC),M_SEXO,M_GRAUPAR,M_TIPIR,M_TIPSF,substr(SRB->RB_NOME,41,30),.T. })
		EndIf
	EndIf
	dbSkip()
Enddo
If !Empty(aDep) .and. Len(aDep) > 1
	If nGrafica==1
		fImpDepG(aDep)
	Else
		fImpDepN(aDep)
	Endif
	lImpressao	:= .T.
Endif

RestArea( aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fImpBen  ³ Autor ³ R.H. - Natie          ³ Data ³ 22.01.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao de Beneficiarios                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ fImpBen()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static function fImpBen()
Local aArea		:= GetArea()

Local aBenef := {}

dbSelectArea("SRQ")
dbSeek(SRA->RA_FILIAL+SRA->RA_MAT)
While ! Eof() .And. SRA->RA_FILIAL+SRA->RA_MAT = SRQ->RQ_FILIAL+SRQ->RQ_MAT
	If Len(aBenef) = 0
		Aadd(aBenef,{STR0027,STR0060} )  //"|Cod|Beneficiario
	Endif
	Aadd(aBenef,{SRQ->RQ_ORDEM,SRQ->RQ_NOME })
	dbSkip()
Enddo
If !Empty(aBenef) .and. Len(aBenef) > 1
	If nGrafica==1
		fImpBenG(aBenef)
	Else
		fImpBenN(aBenef)
	Endif
	lImpressao	:= .T.
Endif

RestArea( aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fImpSin  ³ Autor ³ R.H. - Marinaldo      ³ Data ³09/05/2000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao das Contribuicoes Sindicais                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ fImpSin()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static function fImpSin()
Local aArea		:= GetArea()
Local nTamSind	:= TamSX3("RCE_CODIGO")[1]
Local aConSin	:=	{}
Local aConAss	:=	{}
Local aCodFol	:=	{}
Local aChave	:=	{}
Local aSindica	:=	{}
Local aTransf	:=	{}
Local cChave	:=	""
Local cSindica	:=	""
Local cDescSin	:=	""
Local cSindAnt	:=  ""
Local cDescAnt	:=  ""
Local cDet		:=	""
Local nPos		:=	0
Local nPosAux	:=  0
Local x			:=	0
Local dDataAux	:=	SRA->RA_ADMISSA
Local cDescACodFol	:= ""
Local lClasOutEmp 	:= .F.
Local nTra			:= 0
Local cPerAtual	:= ""
Local aPerAtual	:= {}
Local nStart		:= 1
nRecSRA			:= SRA->( Recno() )

fGetPerAtual( @aPerAtual, xFilial("RCH"), SRA->RA_PROCES, fGetRotOrdinar())

If Empty(aPerAtual)
	fGetPerAtual(@aPerAtual, xFilial("RCH"), SRA->RA_PROCES, fGetCalcRot('9'))
EndIf

If !(Empty(aPerAtual))
	cPerAtual := aPerAtual[1,1]
else
	cPerAtual := AnoMes(dDataBase)
EndIf

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Carrega aCodFol                                              ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
IF !Fp_CodFol(@aCodFol,SRA->RA_FILIAL)
   Return(.F.)
EndIF

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Seleciona o Arquivo de Transferencias e Retorna Todas as Trans³
³ferencias do Funcionario 									   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
fTransf(@aTransf,,,,,,,.T.)
For nTra := 1 To Len(aTransf)
	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Carrega apenas as Transferencias Entre Filiais e Empresas     ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	IF !( aTransf[nTra,1] == aTransf[nTra,4] ) .or. !(Subst(aTransf[nTra,2],1,FwGetTamFilial) == Subst(aTransf[nTra,5],1,FwGetTamFilial) )
    	aAdd(aChave,{	aTransf[nTra,1] ,; // Empresa De
						aTransf[nTra,2] ,; // Filial + Matricula De
    					aTransf[nTra,3] ,; // Centro de Custo De
						aTransf[nTra,4] ,; // Empresa Para
    					aTransf[nTra,5] ,; // Filial + Matricula Para
	    				aTransf[nTra,6] ,; // Centro de Custo Para
    	  				aTransf[nTra,7] ,; // Data da Transferencia
					} )
    EndIF
Next nTra

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Grava em aChave  a Situacao Atual do Funcionario              ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
IF aScan( aChave,{ |x| ( x[1] + x[2] ) == ( cEmpAnt + SRA->RA_FILIAL+SRA->RA_MAT ) } ) == 0
    	SRA->( aAdd(aChave,{									 ;
    						cEmpAnt								,; // 01 - Empresa Origem
    						RA_FILIAL+RA_MAT   					,; // 02 - Filial + Matricula Origem
    						RA_CC								,; // 03 - Centro de Custo Origem
    						cEmpAnt								,; // 04 - Empresa Destino
    						RA_FILIAL+RA_MAT      				,; // 05 - Filial + Matricula Destino
    						RA_CC								,; // 06 - Centro de Custo Destino
							Nil									,; // 07 - Data da Transferencia
							RA_FILIAL							,; // 08 - Filial Origem
    						}									 ;
    				)											 ;
    		  )
Endif

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Verifica se Teve Alteracao de Sindicato                      ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
IF Len(aChave) > 0
	For nPos := 1 To Len(aChave)
		cChave := aChave[nPos,2]
		SR9->(DbSetOrder(1))
		IF SR9->( dbSeek( cChave + "RA_SINDICA" ,.T.) )
    		dbSelectArea('SR9')
			While SR9->( !Eof()  .and. R9_FILIAL+R9_MAT+R9_CAMPO == cChave + "RA_SINDICA" )
	        	/*
				ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				³ Assume Sempre a Ultima Alteracao quando Feita no Mesmo Mes   ³
				ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	        	IF ( x := aScan( aSindica , { |y| MesAno( y[1] ) == MesAno( SR9->R9_DATA ) } ) ) > 0
	        		aSindica[x,1] := SR9->R9_DATA
	        	 	aSindica[x,2] := Subst(R9_DESC,1,nTamSind)
					aSindica[x,3] := AllTrim( fDesc("RCE",Subst(SR9->R9_DESC,1,nTamSind),"RCE_DESCRI",40, SR9->R9_FILIAL ) )
	        	Else
	        		SR9->( aAdd( aSindica ,{ R9_DATA , Subst(R9_DESC,1,nTamSind),AllTrim( fDesc("RCE",Subst(R9_DESC,1,nTamSind),"RCE_DESCRI",40,R9_FILIAL))}))
  	   			EndIF
  	   			dbSelectArea('SR9')
  	   			dbSkip()
			EndDo
		EndIF
	Next nPos
EndIF

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Verifica Se houve Troca de Sindicato por transferencia de FILIAL.	³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
nRecSRA	:= SRA->( Recno() )
IF Len( aChave ) > 0
	For nPos := 1 To Len( aChave )
		If Len(aChave[nPos]) >= 8	// Se nao tiver todos os elementos, indica sindicato atual e nao processa neste bloco de codigo

			cSindica := Posicione("SRA",1,aChave[nPos, 2],"RA_SINDICA")

			If Empty(cSindica) // Se não encontrou o sindicato verifico se não foi por conta do filtro de impressão do relatório
				dbSelectArea("SRA")
				Set Filter to
				cSindica := Posicione("SRA",1,aChave[nPos,2],"RA_SINDICA")
				SRA->(DbSetFilter({||&cFiltro}, cFiltro))  // recrio o filtro para não atrapalhar nas demais funções
				SRA->(DbGoTo( nRecSRA))
			EndIf

			cDescSin := AllTrim( fDesc("RCE", cSindica, "RCE_DESCRI", 40, aChave[nPos,8]))
			IF ! Empty( aSindica ) .and. aChave[nPos,7] # Nil
				aAdd( aSindica , { aChave[nPos,7] , cSindica, cDescSin } )
			ElseIf aChave[nPos,7] # Nil
				aSindica := { { aChave[nPos,7], cSindica, cDescSin } }
			EndIf
		EndIf
	next nPos
EndIf
SRA->( DbGoTo( nRecSRA ) )


/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Acrescenta o Sindicato Atual do Funcionario                  ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
IF !Empty(aSindica)
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³A Data Correspondente ao Sindicato Atual Deve ser Sempre Maior³
	³Que a ultima Alteracao de Sindicato.                          ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	aAdd( aSindica , { IF( dDataBase > aSindica[ Len(aSindica), 1 ] .or. aSindica[ Len(aSindica), 1 ] == Nil, dDataBase, ( aSindica[Len(aSindica),1] + 360 ) ),;
					  SRA->RA_SINDICA, AllTrim( fDesc("RCE",SRA->RA_SINDICA,"RCE_DESCRI",40,SRA->RA_FILIAL) ) } )
Else
	aSindica := { { dDataBase , SRA->RA_SINDICA, AllTrim( fDesc("RCE",SRA->RA_SINDICA,"RCE_DESCRI",40,SRA->RA_FILIAL) ) } }
EndIF
cSindica := aSindica[ Len(aSindica) , 2 ]
cDescSin := AllTrim( fDesc("RCE",SRA->RA_SINDICA,"RCE_DESCRI",40,SRA->RA_FILIAL))
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Ordena as Alteracoes de Sindicato Ordem Crescente de Data    ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
aSort( aSindica,,,{ |x,y| x[1] < y[1] } )

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Preparando Dados Para a Impressao                            ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
dbSelectArea("SRD")
dbSetOrder(1) // ORDENANDO A SRD ENCONTRAR AS INFORMAÇÕES QUE VEM DO aChave

cChave := ""
For nPos := 1 To Len(aChave)
	If cChave <> aChave[nPos, 2]
		cChave	:=	aChave[nPos, 2]
	Else
		Loop
	EndIf
	dbSeek(cChave)
	While SRD->( !Eof() .and. cChave == RD_FILIAL + RD_MAT )
		dDataAux	:=	SRA->RA_ADMISSA
  		lClasOutEmp 	:= .F.
  	    /*
  	    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ So Imprime verba de Contribuicao Sindical                    ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
       	IF !(SRD->RD_PD $ (aCodFol[068,1] + '_' + aCodFol[246,1] + '_' + aCodFol[069,1]))
       		SRD->( dbSkip() )
			Loop
	    /*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Se a contrib.sindical foi efetuada em outra empresa, a descr. ³
		³do sindicato sera a mesma do ID 246                           ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		ElseIf SRD->RD_PD $ aCodFol[246,1] .or.  (! Empty(SRD->RD_EMPRESA) .And. SRD->RD_EMPRESA # cEmpAnt)
			cDescACodFol	:= fDesc("SRV",aCodFol[246,1], "RV_DESC")
			lClasOutEmp 	:= .T.
   	    EndIF
   	    /*
  	    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Verifica se a Verba pertence a empresa Atual                 ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		If 	cEmpAnt # aChave[nPos,1]
       		SRD->( dbSkip() )
        	Loop
   	    EndIF

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica periodo de impressao³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SRD->RD_DATARQ < MesAno(dDataIni) .or. SRD->RD_DATARQ > MesAno(dDataFin)
			SRD->(dbSkip())
			Loop
		EndIf


   	    /*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Cabecalho das Contribuicoes Sindicais                        ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		If Len(aConSin) = 0
			Aadd(aConSin,{STR0013,STR0039 ,STR0055,STR0042,'H'} )	//"|Data        | Mes   | Valor            | Sindicato                     |"
        EndIf
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Verifica se a Alteracao de Sindicato esta dentro do Periodo a³
		³ Ser Listado.                                                 ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		For x := 1 To Len( aSindica )
			IF SRD->RD_DATARQ >= MesAno( aSindica[x,1] ) .or. x == 1 //Se a data for menor que o primeiro registro de transferencia, assume como o primeiro sindicato.
				cSindica := aSindica[x,2]
				cDescSin := aSindica[x,3]
		    EndIF
		Next x

		nPosAux	:= Ascan(aConSin,{|X| X[1]+x[5] == DTOC(RD_DATPGT)+IF( SRD->RD_PD $ ( aCodFol[069,1]), "A","S") })

		If nPosAux == 0
			SRD->( Aadd(aConSin,{ DTOC(RD_DATPGT), Subst( RD_DATARQ , -2 ), Transform(RD_VALOR,"@E 999,999,999.99"), If(lClasOutEmp,cDescACodFol, cDescSin ) ,;
									IF( SRD->RD_PD $ ( aCodFol[069,1]), "A","S");
								} ))
		Else
			aConSin[nPosAux,3] := Transform(Val(aConSin[nPosAux,3]) + SRD->RD_VALOR,"@E 999,999,999.99")
		EndIf

		dbSelectArea("SRD")
		dbSkip()
	Enddo
Next nPos

/*Se o Período atual estiver contido dentro do intervalo selecionado...*/
if(cPerAtual >= MesAno(dDataIni) .And. cPerAtual <= MesAno(dDataFin))
	nStart	:= Len(aConSin)+ 1
	For nPos := 1 To Len(aChave)

		if(cEmpAnt # aChave[nPos,1] )
			Loop
		endIf

		dDataAux	:=	SRA->RA_ADMISSA
		cChave	:=	aChave[nPos, 2]
		SRC->(dbSetOrder(1))
		SRC->(dbSeek(cChave))
		While (SRC->( !Eof() .and. cChave = RC_FILIAL + RC_MAT ))

       	IF !( SRC->RC_PD $ (  aCodFol[068,1] + '_' + aCodFol[246,1] + '_' + aCodFol[069,1] ) ) ;
       		.Or. SRC->RC_DATA < dDataIni .Or. SRC->RC_DATA > dDataFin

       		SRC->(dbSkip())
				Loop
	   	    EndIF

			For x := 1 To Len( aSindica )
				IF (SRC->RC_DATA >= dDataAux .And. SRC->RC_DATA <= aSindica[x,1])
					If x # 1 .and. MesAno( aSindica[x,1] ) > MesAno( dDataAux ) .and. Year( aSindica[x,1] ) > Year( SRC->RC_DATA )
			    		cSindica := cSindAnt
						cDescSin := cDescAnt
					Else
						cSindica := aSindica[x,2]
						cDescSin := aSindica[x,3]
					Endif
					Exit
			    EndIF
		    	dDataAux	:= aSindica[x,1]
	    		cSindAnt	:= aSindica[x,2]
		   	   	cDescAnt	:= aSindica[x,3]
			Next x

			nPosAux	:= aScan(aConSin,{|X| X[1]+x[5] == DtoC(SRC->RC_DATA) + IIF( SRC->RC_PD $ ( aCodFol[069,1]), "A","S") },nStart)

			If Len(aConSin) = 0
				Aadd(aConSin,{STR0013,STR0039 ,STR0055,STR0042,'H'} )	//"|Data        | Mes   | Valor            | Sindicato                     |"
	        EndIf

			if(nPosAux == 0)
				aAdd(aConSin,{DtoC(SRC->RC_DATA),;
								Substr(SRC->RC_PERIODO,5,2),;
								Transform(SRC->RC_VALOR,"@E 999,999,999.99"),;
								cDescSin,;
								IIF(SRC->RC_PD $ ( aCodFol[069,1]),"A","S")})
			Else
				aConSin[nPosAux,3] := Transform(Val(StrTran(aConSin[nPosAux,3],",",".")) + SRC->RC_VALOR,"@E 999,999,999.99")
			endIf
			SRC->(dbSkip())
		Enddo
	Next nPos
endIf

If len(aConSin) > 0

	aAux:=aClone(aConSin)

    aConSin := {}
    aConAss := {}

	aAdd(aConSin, aClone( aAux[1] ) )
	aAdd(aConAss, aClone( aAux[1] ) )

	Aeval(aAux,{|X| If(x[Len(X)] == "A", aAdd(aConAss, aClone(X) ), aAdd(aConSin, aClone(X)) )}, 2 )

	aSort( aConSin,2,,{ |x,y| Ctod(x[1]) < Ctod(y[1]) } )
	aSort( aConAss,2,,{ |x,y| Ctod(x[1]) < Ctod(y[1]) } )

	If nGrafica ==1
		IF Len(aConSin) > 0 .and. nConSin == 1
			fImpSindG(aConSin, STR0036)
		Endif

		IF Len(aConAss) > 0 .and. nContAss == 1
			fImpSindG(aConAss, STR0125)
		Endif
	Else
	  	IF Len(aConSin) > 0 .and. nConSin == 1
			fImpSindN(aConSin, STR0036)
		Endif

		IF Len(aConAss) > 0 .and. nContAss == 1
			fImpSindN(aConAss, STR0125)
		Endif
	Endif
	lImpressao	:= .T.
Endif

RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fImpTra  ³ Autor ³ R.H. - Marinaldo      ³ Data ³10/05/2000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao das Transferencias                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ fImpTra()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static function fImpTra()
Local aArea		:= GetArea()

Local aTransf	:=	{}
Local aTraFE	:=	{}
Local cEmp		:=	""
Local cFil	 	:=	""
Local cCgc		:=	""
Local cDescEmp	:=	""
Local cDescFil	:=	""
Local cEndereco	:=	""
Local cBairro	:=	""
Local cCidade	:=	""
Local cEstado	:=	""
Local cTipEnd	:=	GetMv("MV_PAREND")
Local dDataTra	:=	Ctod('//')
Local nSvRecno	:=	SM0->( Recno () )
Local nTra		:=	0
Local cCCustoDe	:=	""
Local cCCustoP	:=	""
Local cMatDe	:=	""
Local cMatP		:=	""
Local nLen		:=	TAMSX3("RE_MATD")[1]
Local cStringT	:=	""

nColuna	:= 050

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Seleciona o Arquivo de Transferencias e Retorna Todas as Trans³
³ferencias do Funcionario 									   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
If nTransf == 1
	fTransf(@aTransf,,,,,,,.T.)
ElseIf nTransf == 2
	fTransf(@aTransf,,.T.,,,,,.T.)
	fTransf(@aTransf,,,.T.,,,,.T.)
EndIf

For nTra := 1 To Len(aTransf)
	/*

	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Carrega apenas as Transferencias Entre Filiais e Empresas     ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If aTransf[nTra,7] >= dDataIni .and. aTransf[nTra,7] <= dDataFin
		IF !( aTransf[nTra,1] == aTransf[nTra,4] ) .or. !( aTransf[nTra,8] == aTransf[nTra,10] );
			.OR. !( aTransf[nTra,3] == aTransf[nTra,6 ] );
			.OR. !( aTransf[nTra,9] == aTransf[nTra,11] )
			aAdd(aTraFE,{aTransf[nTra,1] ,; // Empresa De
						aTransf[nTra,2] ,; // Filial + Matricula De
						aTransf[nTra,3] ,; // Centro de Custo De
						aTransf[nTra,4] ,; // Empresa Para
						aTransf[nTra,5] ,; // Filial + Matricula Para
						aTransf[nTra,6] ,; // Centro de Custo Para
						aTransf[nTra,7] ,; // Data da Transferencia
					     } )
		EndIF
	Endif

Next nTra

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Reinicializa aTransf                                          ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
aTransf := {}


/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Preparando Dados Para a Impressao                            ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
For nTra := 1 To Len(aTraFE)
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Cabecalho das Transferencias                                 ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	IF Len(aTransf) = 0
		Aadd(aTransf,{ " "   ,STR0043,"" })	//"|            Empresa de Origem   "
		Aadd(aTransf,{STR0013,STR0045,"" })	//"|Data        Empresa de Destino  "
    EndIf
    cMatDe		:= RIGHT( aTraFE[nTra , 2] , nLen )
  	cMatP		:= RIGHT( aTraFE[nTra , 5] , nLen )
    cCCustoDe	:= aTraFE[nTra,3]
    cCCustoP	:= aTraFE[nTra,6]

    /*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Dados da Empresa de Origem                                   ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
   	cEmp		:= aTraFE[nTra,1]
    cFil		:= Left(aTraFE[nTra,2],FwSizeFilial(aTraFE[nTra,1]))
    SM0->( dbSeek(cEmp+cFil) )
    cDescEmp	:= Alltrim( SM0->M0_NOMECOM )
    cDescFil	:= Alltrim ( SM0->( IF(nFilial == 1 , M0_NOME , M0_FILIAL ) ) )
    cStringT	:=	AllTrim(cEmp) + " - " + AllTrim(cDescEmp)

    If !( cMatDe == cMatP )
    	cStringT	+= " - " + STR0128 + cMatDe // Matrícula
    EndIf

    If !( cCCustoDe == cCCustoP )
    	cStringT += " - " + STR0129 + cCCustoDe // Centro de Custo
    EndIf

	aAdd(aTransf,{"" , cStringT , cFil + " - " + cDescFil} )

	cCgc		:= IF(SM0->M0_TPINSC == 1, SM0->(Transform(M0_CEI,'@R ##.###.###/####-##') ), SM0->(Transform(M0_CGC,'@R ##.###.###/####-##') ))
	cEndereco	:= Alltrim(SM0->( IF( cTipEnd = "C", M0_ENDCOB , M0_ENDENT ) ))

	aAdd(aTransf,{"" , IF(SM0->M0_TPINSC = 1 , STR0047 , STR0032 ) + cCgc + Space(01) + STR0049 + cEndereco," " } )//"CEI"###"CGC"###"End.: "

	cBairro		:=	Alltrim(SM0->( IF( cTipEnd = "C", M0_BAIRCOB, M0_BAIRENT ) ))
	cCidade		:=	Alltrim(SM0->( IF( cTipEnd = "C", M0_CIDCOB	, M0_CIDENT  ) ))
	cEstado		:=	SM0->( IF( cTipEnd = "C", M0_ESTCOB	, M0_ESTENT  ) )

	aAdd(aTransf,{"" ,STR0028 + cBairro + " -" + cCidade + Space(01) + STR0030 + cEstado," " } ) //"Bairro: "###"Cidade: "###"UF: "
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Dados da Empresa de Destino                                  ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	cEmp		:= aTraFE[nTra,4]
	cFil		:= Left(aTraFE[nTra,5],FwSizeFilial(aTraFE[nTra,4]))
	dDataTra	:= aTraFE[nTra,7]
	SM0->( dbSeek(cEmp+cFil) )
	cDescEmp	:= Alltrim( SM0->M0_NOMECOM )
	cDescFil	:= Alltrim( SM0->( IF(nFilial == 1 , M0_NOME , M0_FILIAL ) ) )
	cStringT	:=	AllTrim(cEmp) + " - " + AllTrim(cDescEmp) + SPACE(1)

	If !( cMatDe == cMatP )
    	cStringT += " - " + STR0128 + cMatP // Matrícula
    EndIf

    If !( cCCustoDe == cCCustoP )
    	cStringT += " - " + STR0129 + cCCustoP // Centro de Custo
    EndIf

	aAdd(aTransf,{DTOC(dDataTra), cStringT + space(7) , cFil + " - " + cDescFil } )

	cCgc		:= IF(SM0->M0_TPINSC == 1, SM0->(Transform(M0_CEI,'@R ##.###.###/####-##') ), SM0->(Transform(M0_CGC,'@R ##.###.###/####-##') ))
	cEndereco	:= Alltrim(SM0->( IF( cTipEnd = "C", M0_ENDCOB , M0_ENDENT ) ))

	aAdd(aTransf,{"" , IF(SM0->M0_TPINSC = 1 , STR0047 , STR0032 ) + cCgc + Space(01) + STR0049 + cEndereco," " })//"CEI"###"CGC"###"End.: "

	cBairro		:=	Alltrim(SM0->( IF( cTipEnd = "C", M0_BAIRCOB, M0_BAIRENT ) ))
	cCidade		:=	Alltrim(SM0->( IF( cTipEnd = "C", M0_CIDCOB	, M0_CIDENT  ) ))
	cEstado		:=	SM0->( IF( cTipEnd = "C", M0_ESTCOB	, M0_ESTENT  ) )

	aAdd(aTransf, {"" ,STR0028 + cBairro + " - " + cCidade + Space(01) + STR0030 + cEstado," " }) //"Bairro: "###"Cidade: "###"UF: "

	SM0->( dbGoto( nSvRecno ) )
Next nTra

If !Empty(aTransf) .and. Len(aTransf) > 2
	If  nGrafica==1
		fImpTraG(aTransf)
	Else
		fImpTraN(aTransf)
	Endif
	lImpressao	:= .T.
Endif
SM0->( dbGoto( nSvRecno ) )

RestArea( aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fImpTrei  ³ Autor ³ Inovação - RH        ³ Data ³07/10/2014³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao dos Treinamnetos do Funcionário                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ fImpTrei()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpTrei()
Local aArea		:= GetArea()

Local aTreina := {}

dbSelectArea("RA4")
dbSeek(SRA->RA_FILIAL+SRA->RA_MAT)
While ! Eof() .And. SRA->RA_FILIAL+SRA->RA_MAT = RA4->RA4_FILIAL+RA4->RA4_MAT
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica periodo de impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If RA4->RA4_DATAIN < dDataIni .Or. RA4->RA4_DATAIN > dDataFin
		dbSkip()
		Loop
	Endif

	//Verificar se o curso é para ser impresso
	dbSelectArea("RA1")
	dbSeek (xfilial("RA1")+RA4->RA4_CURSO)
	If RA1->RA1_IMPRIM == "1"
		If Len(aTreina) = 0
			Aadd(aTreina,{ STR0132,STR0059,STR0020,STR0022,STR0133} )  //"|Curso   Descrição       Data Inicial    Data Final	Validade"
		Endif
		Aadd(aTreina,{RA4->RA4_CURSO, RA1->RA1_DESC, DTOC(RA4->RA4_DATAIN), DTOC(RA4->RA4_DATAFI), DTOC(RA4->RA4_VALIDA)  })
	EndIf

	dbSelectArea("RA4")
	dbSkip()
Enddo

If !Empty(aTreina) .and. Len(aTreina) > 1
	If nGrafica ==1
	 	fImpTreiG(aTreina, 1)
	Else
	 	fImpTreiN(aTreina, 1)
	Endif
    lImpressao	:= .T.
Endif

RestArea( aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fImpTrei  ³ Autor ³ Inovação - RH        ³ Data ³07/10/2014³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao dos Treinamnetos do Funcionário                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ fImpTrei()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fImpCur()
Local aArea		:= GetArea()
Local aCurso := {}

dbSelectArea("SQ9")
dbSeek(SRA->RA_FILIAL+SRA->RA_MAT)
While ! Eof() .And. SRA->RA_FILIAL+SRA->RA_MAT = SQ9->Q9_FILIAL+SQ9->Q9_MAT
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica periodo de impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SQ9->Q9_DTINI < dDataIni .Or. SQ9->Q9_DATA > dDataFin
		dbSkip()
		Loop
	Endif

	//Verificar se o curso é para ser impresso
	dbSelectArea("SQT")
	dbSeek (xfilial("SQT")+SQ9->Q9_CURSO)
	If SQT->QT_IMPRIME == "1"
		If Len(aCurso) = 0
			Aadd(aCurso,{ STR0132,STR0059,STR0020,STR0022,STR0133} )  //"|Curso   Descrição       Data Inicial    Data Final	Validade"
		Endif
		Aadd(aCurso,{SQ9->Q9_CURSO, SubStr(SQ9->Q9_DESCRIC,1,37), DTOC(SQ9->Q9_DTINI), DTOC(SQ9->Q9_DATA), DTOC(SQ9->Q9_VALIDAD)  })
	EndIf

	dbSelectArea("SQ9")
	dbSkip()
Enddo

If !Empty(aCurso) .and. Len(aCurso) > 1
	If nGrafica ==1
	 	fImpTreiG(aCurso, 2)
	Else
		fImpTreiN(aCurso, 2)
	Endif
    lImpressao	:= .T.
Endif

RestArea( aArea)
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpGraf  ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Grafico - Ficha  Funcion.º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function  fImpGraf(aCampo)
Local cDet 		:= " ",Ix	:= 1
Local nTaman	:= nTam1	:=	nTam2	:= nTamTot	:= 0
Local cDescFol	:= " "
Local nPosF
Local nCol		:= 0
Local nX		:= 0
Local nLinhas   := 0
Local nIncLinha := 0
Local aCpoMemo  := {}

nLin 	:= 0
nColuna	:= 050

ImprG(" " ,"C",,,nColuna,,nLin)

nAcampo 	:= Len(aCampo)
nColuna 	:= 050
While  .T.
	cFolder := aCampo[Ix,3]
	nPosF	:= Ascan(aAgrup,{|X| substr(x,10,2) = cFolder })
	cDescFol:= ""
	cDescFol:=If(nPosF>0, substr(aAgrup[nPosF],12,20) , cDescFol )

	//-- Quebra do Agrupamento
	If nlin >= nLinMax .or. (nLin + 150) >= nLinMax
		nLin  := 0
		oPrint:EndPage() 		// Finaliza a pagina
		nColuna := 50
		ImprG(" ","C",,,nColuna,,nLin,oFont10)
	Endif

	nCol	:= int( ( nColBox - ( Len(cDescFol) * 100 / 7) )) /2
	oPrint:Line(nLin,nColuna-20 ,nLin, nColMax)
	nLin += 10
	oPrint:say(nlin,nCol,cDescFol,oFont10n)
	nLin  += 40
	oPrint:Line(nLin,nColuna-20 ,nLin, nColMax)
	nLin += 15
	While Ix <= nACampo .and. cFolder = aCampo[Ix,3]

		nTam1	:= ( Len(aCampo[ix,1]) * 100)/ 8
		nTam2 	:= ( Len(aCampo[ix,2]) * 100)/ 5
		nTaman	:= If( nTam1 > nTam2,nTam1,nTam2)+ 120

		IF (nColuna+nTaman) >= nColMax
			nLin 	+= 100
			nColuna := 50
		Endif

		If nlin >= nLinMax .or. (nLin  + 90) >= nLinMax
			nLin  := 0
			oPrint:EndPage() 		// Finaliza a pagina
			nColuna := 50
			ImprG(" ","C",,,nColuna,,nLin,oFont10)
		Endif

	    nTamTot	:= nColuna + nTaman
	    If nTamTot > nColMax
	    	nTamTot	:= nColMax - 10
	    Endif

		//Tratamento especifico para campos do tipo MEMO
		If (aCampo[ix,5] == 'M')
			// Limito o campo para até 1000 caracteres
			aCampo[ix,2]	:= SubStr(aCampo[ix,2],1,1000)
			Q_MemoArray( aCampo[ix,2], aCpoMemo, 106)
			nLinhas := Len( aCpoMemo )
			If nLinhas > 0
				fTestaQuebra(aCpoMemo)
			EndIf
		EndIf

		//Impressao da borda campos diferentes do Tipo Memo
		If nLinhas < 1
			oPrint:Line(nLin+020, nColuna, nLin+090, nColuna)	//1a vertical
			oPrint:Line(nLin+020, nTamTot, nLin+090, nTamTot) 	//2a vertical
			oPrint:Line(nLin+090, nColuna, nLin+090, nTamTot)	//horizontal
		EndIf

		ImprG(aCampo[ix,1],"C",,,nColuna+10,.f.,nlin,oFont08n)	//Cabecalho campo

		If nLinhas > 0
			nIncLinha := nLin + 20 //Guarda a posicao para impressao da coluna vertical
			For nX := 1 To nLinhas
				ImprG( aCpoMemo[nX],"C",,,nColuna,.f.,nLin+40,oFont10)	//Detalhe do campo tipo Memo
			Next nX
		Else
			ImprG(aCampo[ix,2],"C",,,nColuna,.f.,nLin+40,oFont10)	//Detalhe do campo demais tipos
		EndIf

		//Impressao da borda para campos Tipo Memo
		If nLinhas > 0
			nIncLinha := ( nLin - nIncLinha ) //Obtem a posicao inicial da coluna vertical
			oPrint:Line(nLin-nIncLinha, nColuna-10, nLin+50, nColuna-10) //1a vertical
			oPrint:Line(nLin-nIncLinha, nTamTot,    nLin+50, nTamTot) 	  //2a vertical
			oPrint:Line(nLin+50,        nColuna-10, nLin+50, nTamTot)	  //horizontal
		EndIf

		nLin 	-= 40
		nColuna	+= Int(nTaman)+ 10

		Ix ++
		If Ix > len(aCampo)
			nColuna := 050
			nLin += 100
			oPrint:Line(nLin,nColuna-20,nlin,nColMax)	//horizontal
			nLin += 020
			If nlin >= nLinMax
				nLin  := 0
				oPrint:EndPage() 		// Finaliza a pagina
				nColuna := 50
				ImprG(" ","C",,,nColuna,,nLin,oFont10)
			Endif
			Return
		Endif
		aCpoMemo := {}
		nLinhas  := 0
	Enddo
	nLin  	+= 100
	nColuna	:= 050

	If nlin >= nLinMax
		nLin  := 0
		oPrint:EndPage() 		// Finaliza a pagina
		nColuna := 50
		ImprG(" ","C",,,nColuna,,nLin,oFont10)
	Endif
Enddo
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpNorm  ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Normal                   º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/

Static Function  fImpNorm(aCampo)
Local cDet 		:= " ",Ix	:= 1
Local nTaman	:= nTam1	:=	nTam2	:= 0
Local cDescFol	:= " "
Local nPosF
Local nX 		:= 0
Local nLinhas	:= 0
Local aCpoMemo  := {}

nAcampo 	:= Len(aCampo)
Li 			:= 0
Impr("","C",,,,,,,,.T.)


While  .T.
	cFolder := aCampo[Ix,3]
	nPosF	:= Ascan(aAgrup,{|X| substr(x,10,2) = cFolder })
	cDescFol:= ""
	cDescFol:=If(nPosF>0, substr(aAgrup[nPosF],12,20) , cDescFol )

	//-- Quebra do Agrupamento
	If li >= 60 .or. (Li + 10) > 60
		Impr(" ","P")
	Endif
	//- Cabecalho Agrupamento
	cDet	:= repl("-",78)
	nDet	:= (78-Len(alltrim(cDescFol)) ) /2
	Impr( cDet,"C",,,01)
	Impr( "|" ,"C",,,00,.f.)
	Impr(cDescFol ,"C",,,nDet,.f.)
	Impr( "|" ,"C",,,79)
	Impr(cDet,"C",,,01)
	cDet	:= ""
	While cFolder = aCampo[Ix,3]
		If li >= 60
			Impr(REPL("-",78),"C")
			Impr(" ","P")
		Endif

		If Len(cDet)+Len(aCampo[ix,2])+16 < 78
			cCabCpo := aCampo[ix,1]
			cDet 	+= cCabCpo+Replicate(".",12-Len(cCabCpo))+" :["+aCampo[ix,2]+"]"
			cDet 	+= Space(If (Len(cDet)+5 > 78,78-Len(cDet),5))
		Else
			If !Empty( cDet )
				Impr("|"+cDet+Space(78-Len(cDet))+"|","C")
			EndIf
			cCabCpo := aCampo[ix,1]

			//Tratamento especifico para campos do tipo MEMO
			If (aCampo[ix,5] == 'M')
				Q_MemoArray( aCampo[ix,2], aCpoMemo, 63)
				nLinhas := Len( aCpoMemo )
				For nX := 1 To nLinhas
					If nX == 1
						cDet 	:= cCabCpo + Replicate(".",12-Len(cCabCpo)) + " :[" + AllTrim( aCpoMemo[nX] ) + If( nX==nLinhas, "]", "" )
						Impr("|" + cDet + Space(78-Len(cDet)) + "|" , "C")
						cDet     := ""
					Else
						cDet 	:= Space(15) + AllTrim( aCpoMemo[nX] )
						If nX == nLinhas
							cDet 	:= Space(15) + AllTrim( aCpoMemo[nX] ) + "]"
						Else
							Impr("|" + cDet + Space(78-Len(cDet)) + "|" , "C")
							cDet     := ""
						EndIf
					EndIf
				Next nX
				aCpoMemo := {}
			Else
				cDet 	:= cCabCpo+Replicate(".",12-Len(cCabCpo))
				cDet	+= Substr(" :["+aCampo[ix,2]+"]",1,78-LEN(cDet))
				cDet 	+= Space(If (Len(cDet)+5 > 78,78-Len(cDet),5))
			EndIf

		Endif
		Ix ++
		If Ix > len(aCampo)
			Impr("|"+cDet+Space(78-Len(cDet))+"|","C")
			cDet	:= repl("-",78)
			Impr( cDet,"C",,,01)
			Return nil
		Endif
	Enddo
Enddo
cDet	:= repl("-",78)
Impr(cDet,"C")

Li ++
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpSalG  ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Grafico                  º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/

Static Function fImpSalG(aSal,cHist)
Local N     	:= 0
Local nLinhas	:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Testa Quebra de Pagina                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
fTestaQuebra(aSal,@nLinhas)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Box Detalhe                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
fSalBox(nLinhas,cHist)
For N:=1 To Len(aSal)
	If nLin + 100 >= nLinMax

		fFimPag(aSal,N,@nLinhas)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Box Detalhe                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fSalBox(nLinhas,cHist)
		If (SRA->RA_CATFUNC $ "I#J" .Or. cCategAnt $ "I#J") .and. cHist == "T"
			ImprG(aSal[01,1],"C",,,0060,.f.,nLin,oFont08C)		//-- Tp. Tarefa
			ImprG(aSal[01,2],"C",,,0260,.f.,nLin,oFont08C)		//-- Data De
			ImprG(aSal[01,3],"C",,,0440,.f.,nLin,oFont08C)		//-- Data Ate
			ImprG(aSal[01,4],"C",,,0650,.f.,nLin,oFont08C)		//-- Tarefa
			ImprG(aSal[01,5],"C",,,1270,.f.,nLin,oFont08C)		//-- Aulas Semana
			ImprG(aSal[01,6],"C",,,1520,.f.,nLin,oFont08C)		//-- Qtde. Tarefa
			ImprG(aSal[01,7],"C",,,1790,.f.,nLin,oFont08C)		//-- Valor Unitario
			ImprG(aSal[01,8],"C",,,2110,.f.,nLin,oFont08C)		//-- Valor Total
		ElseIf (SRA->RA_CATFUNC $ "T" .Or. cCategAnt $ "T") .and. cHist == "T"
			ImprG(aSal[01,2],"C",,,0060,.f.,nLin,oFont08C)		//-- Data De
			ImprG(aSal[01,3],"C",,,0230,.f.,nLin,oFont08C)		//-- Data Ate
			ImprG(aSal[01,4],"C",,,0390,.f.,nLin,oFont08C)		//-- Tarefa
			ImprG(aSal[01,6],"C",,,1000,.f.,nLin,oFont08C)		//-- Qtde. Tarefa
			ImprG(aSal[01,7],"C",,,1260,.f.,nLin,oFont08C)		//-- Valor Unitario
			ImprG(aSal[01,8],"C",,,1590,.f.,nLin,oFont08C)		//-- Valor Total
		Else
			ImprG(aSal[01,1],"C",,,0060,.f.,nLin,oFont08)		//-- Cabecalho
			ImprG(aSal[01,10],"C",,,0210,.f.,nLin,oFont08)		//-- Cabecalho
			ImprG(aSal[01,2],"C",,,0370,.f.,nLin,oFont08)		//-- Cabecalho
			ImprG(aSal[01,3],"C",,,0800,.f.,nLin,oFont08)		//-- Cabecalho
			ImprG(aSal[01,4],"C",,,0880,.f.,nLin,oFont08)		//-- Cabecalho
			ImprG(aSal[01,5],"C",,,0950,.f.,nLin,oFont08)		//-- Cabecalho
			ImprG(aSal[01,6],"C",,,1340,.f.,nLin,oFont08)		//-- Cabecalho
			ImprG(aSal[01,7],"C",,,1490,.f.,nLin,oFont08)		//-- Cabecalho
			ImprG(aSal[01,8],"C",,,1880,.f.,nLin,oFont08)	// Detalhe campo ( cargo )
		EndIf
		// A Soma no nLin foi tirada de dentro do IF acima, pois estava imprimindo
		// a proxima informacao de alteracao salarial na linha do cabecalho
		nLin+=50
	Endif

	If (SRA->RA_CATFUNC $ "I#J" .Or. cCategAnt $ "I#J") .and. cHist == "T"
		ImprG(aSal[n,1],"C",,, 060,.f.,nLin,oFont08C)					// Detalhe campo ( Tp. Tarefa )
		ImprG(aSal[n,2],"C",,, 260,.f.,nLin,oFont08C)					// Detalhe campo ( Data de )
		ImprG(aSal[n,3],"C",,, 440,.f.,nLin,oFont08C)					// Detalhe campo ( Data Ate )
		ImprG(aSal[n,4],"C",,, 650,.f.,nLin,oFont08C)					// Detalhe campo ( Tarefa )
		ImprG(aSal[n,5],"C",,,1270,.f.,nLin,oFont08C)					// Detalhe campo ( Aulas Semana )
		ImprG(aSal[n,6],"C",,,If(n==1,1520,1520),.f.,nLin,oFont08C)	// Detalhe campo ( Qtde Tarefa )
		ImprG(aSal[n,7],"C",,,If(n==1,1790,1800),.f.,nLin,oFont08C)	// Detalhe campo ( Valor Unitario )
		ImprG(aSal[n,8],"C",,,If(n==1,2110,2080),.f.,nLin,oFont08C)	// Detalhe campo ( Valor Total )
	ElseIf (SRA->RA_CATFUNC $ "T" .Or. cCategAnt $ "T") .and. cHist == "T"
		ImprG(aSal[n,2],"C",,, 060,.f.,nLin,oFont07)					// Detalhe campo ( Data de )
		ImprG(aSal[n,3],"C",,, 230,.f.,nLin,oFont07)					// Detalhe campo ( Data Ate )
		ImprG(aSal[n,4],"C",,, 390,.f.,nLin,oFont07)					// Detalhe campo ( Tarefa )
		ImprG(aSal[n,6],"C",,,If(n==1,1000,1000),.f.,nLin,oFont07)	// Detalhe campo ( Qtde Tarefa )
		ImprG(aSal[n,7],"C",,,If(n==1,1260,1250),.f.,nLin,oFont07)	// Detalhe campo ( Valor Unitario )
		ImprG(aSal[n,8],"C",,,If(n==1,1590,1570),.f.,nLin,oFont07)	// Detalhe campo ( Valor Total )
	Else
		ImprG(aSal[n,1], "C",,,050 ,.f.,nLin,oFont08)	// Detalhe campo ( Data )
		ImprG(aSal[n,10],"C",,,210 ,.f.,nLin,oFont08)	// Detalhe campo ( Data Dissidio )
		ImprG(aSal[n,2],"C",,, 370 ,.f.,nLin,oFont08)	// Detalhe campo ( Desc. Aumento )
		ImprG(aSal[n,3],"C",,, 800 ,.f.,nLin,oFont08)	// Detalhe campo ( Categoria )
		ImprG(aSal[n,4],"C",,, 880 ,.f.,nLin,oFont08)	// Detalhe campo ( Pagamento )
		ImprG(aSal[n,5],"C",,, 950 ,.f.,nLin,oFont08)	// Detalhe campo ( Verba )
		ImprG(aSal[n,6],"C",,, 1325,.f.,nLin,oFont08)	// Detalhe campo ( Valor )
		ImprG(aSal[n,7],"C",,, 1490,.f.,nLin,oFont08)	// Detalhe campo ( Funcao )
		ImprG(aSal[n,8],"C",,, 1880,.f.,nLin,oFont08)	// Detalhe campo ( cargo )
	EndIf
	nLin += 50
Next N
ImprG("","C",,,50,,nLinhas)
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpSalN  ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Normal                   º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function fImpSalN(aSal,cHist)

Local N,M, nDet
Local aDetalhe	:= {}

If li >= 60
	Impr(" ","P")
Endif
Impr("","C")

//-- Box Detalhe
If (SRA->RA_CATFUNC $ "T" .Or. cCategAnt $ "T") .and. cHist == "T"
	aAdd(aDetalhe," ------------------------------------------------------------------------------ ")
	aAdd(aDetalhe,"|                                                                              |")
	aAdd(aDetalhe,"|------------------------------------------------------------------------------|")
	aAdd(aDetalhe,"|         |         |              |            |               |              |")
	aAdd(aDetalhe,"|---------+---------+--------------+------------+---------------+--------------|")
				//  Data De   Data Ate  Tarefa          Qtde.Tarefa    Vl. Unitario       Vl Total
				//  99/99/99  99/99/99   999            9,999,999.99 9,999,999.9999  9,999,999.9999
				//  1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
				//         10        20        30        40        50        60        70        80        90        100

ElseIf (SRA->RA_CATFUNC $ "I#J" .Or. cCategAnt $ "I#J") .and. cHist == "T"
	aAdd(aDetalhe," ------------------------------------------------------------------------------ ")
	aAdd(aDetalhe,"|                                                                              |")
	aAdd(aDetalhe,"|------------------------------------------------------------------------------|")
	aAdd(aDetalhe,"|        |        |              |        |      |              |              |")
	aAdd(aDetalhe,"|--------+--------+--------------+--------+------+--------------+--------------|")
				//  Data De |Data Ate|Tarefa        |Aul/Sem.|Q.Tar.|  Vl. Unitario|     Vl Total
				//  99/99/99|99/99/99|999-5678901234| 999.99 |999.99|9,999,999.9999|9,999,999.9999
				//  1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
				//         10        20        30        40        50        60        70        80        90        100

Else
	aAdd(aDetalhe," ------------------------------------------------------------------------------ ")
	aAdd(aDetalhe,"|                                                                              |")
	aAdd(aDetalhe,"|------------------------------------------------------------------------------|")
	aAdd(aDetalhe,"|          |                    |     |     |                    |             |")
	aAdd(aDetalhe,"|          |                    |     |     |                    |             |")
	aAdd(aDetalhe,"|          |                    |     |     |                    |             |")
	aAdd(aDetalhe,"|----------+--------------------+-----+-----+--------------------+-------------|")
	             //12345678901234567890123456789012345678901234567890123456789012345678901234567890
	             //          10        20        30        40        50        60        70
	             // 99/99/9999                                                       99,999,999.99
EndIf

If (SRA->RA_CATFUNC $ "I#J#T" .Or. cCategAnt $ "I#J#T") .and. cHist == "T"
	nDet	:= (78 - Len(STR0015+STR0099)) / 2      // Alterações salariais - Tarefas
	aDetalhe[2]	:= sTuff(aDetalhe[2],nDet,len(oemtoAnsi(STR0015+STR0099)) , oEmtoAnsi(STR0015+STR0099) )
Else
	nDet	:= (78 - Len(STR0015)) / 2
	aDetalhe[2]	:= sTuff(aDetalhe[2],nDet,len(oemtoAnsi(STR0015)) , oEmtoAnsi(STR0015) )
EndIf

If (SRA->RA_CATFUNC $ "I#J" .Or. cCategAnt $ "I#J") .and. cHist == "T"
	aDetalhe[4]	:= Stuff(aDetalhe[4],02,len(aSal[1,2]),aSal[1,2])
	aDetalhe[4]	:= Stuff(aDetalhe[4],11,len(aSal[1,3]),aSal[1,3])
	aDetalhe[4]	:= Stuff(aDetalhe[4],20,len(aSal[1,4]),aSal[1,4])
	aDetalhe[4]	:= Stuff(aDetalhe[4],35,len(aSal[1,5]),aSal[1,5])
	aDetalhe[4]	:= Stuff(aDetalhe[4],44,len(aSal[1,6]),aSal[1,6])
	aDetalhe[4]	:= Stuff(aDetalhe[4],52,len(aSal[1,7]),aSal[1,7])
	aDetalhe[4]	:= Stuff(aDetalhe[4],68,len(aSal[1,8]),aSal[1,8])
ElseIf (SRA->RA_CATFUNC $ "T" .Or. cCategAnt $ "T") .and. cHist == "T"
	aDetalhe[4]	:= Stuff(aDetalhe[4],02,len(aSal[1,2]),aSal[1,2])
	aDetalhe[4]	:= Stuff(aDetalhe[4],13,len(aSal[1,3]),aSal[1,3])
	aDetalhe[4]	:= Stuff(aDetalhe[4],23,len(aSal[1,4]),aSal[1,4])
	aDetalhe[4]	:= Stuff(aDetalhe[4],37,len(aSal[1,6]),aSal[1,6])
	aDetalhe[4]	:= Stuff(aDetalhe[4],50,len(aSal[1,7]),aSal[1,7])
	aDetalhe[4]	:= Stuff(aDetalhe[4],68,len(aSal[1,8]),aSal[1,8])
Else
	aDetalhe[4]	:= Stuff(aDetalhe[4],02,len(aSal[1,1]),aSal[1,1])
	aDetalhe[4]	:= Stuff(aDetalhe[4],14,len(aSal[1,2]),aSal[1,2])
	aDetalhe[4]	:= Stuff(aDetalhe[4],35,len(aSal[1,3]),aSal[1,3])
	aDetalhe[4]	:= Stuff(aDetalhe[4],41,len(aSal[1,4]),aSal[1,4])
	aDetalhe[4]	:= Stuff(aDetalhe[4],47,len(aSal[1,5]),aSal[1,5])
	aDetalhe[4]	:= Stuff(aDetalhe[4],68,len(aSal[1,6]),aSal[1,6])
	aDetalhe[5]	:= Stuff(aDetalhe[5],02,len(aSal[1,10]),aSal[1,10])
	aDetalhe[5]	:= Stuff(aDetalhe[5],13,len(aSal[1,7]),aSal[1,7])
	aDetalhe[6]	:= Stuff(aDetalhe[6],13,len(aSal[1,8]),aSal[1,8])
EndIf

If (LI +  Len(aDetalhe) + Len(aSal) + 04 ) >= 60
	Impr("","P")
Endif

For m:= 1 to Len(aDetalhe)
	Impr(aDetalhe[m],"C")
Next m

For N:=2 To Len(aSal)

	If (SRA->RA_CATFUNC $ "I#J#" .Or. cCategAnt $ "I#J") .and. cHist == "T"
		Impr("|"+ aSal[n,2]					,"C",,,00,.F. )		//-- Data de
		Impr("|"+ aSal[n,3]					,"C",,,09,.F. )		//-- Data Ate
		Impr("|"+ substr(aSal[n,4],1,14)	,"C",,,18,.F. )		//-- Tarefa
		Impr("|"+ space(01)+aSal[n,5]		,"C",,,33,.F. )		//-- Aulas/Semana
		Impr("|"+ aSal[n,6]					,"C",,,42,.F. )		//-- Qtd. Tarefa
		Impr("|"+ aSal[n,7]					,"C",,,49,.F. )        //-- Valor unitario
		Impr("|"+ Substr(aSal[n,8],1,20)	,"C",,,64,.F. )		//-- Valor Total
		Impr("|"           					,"C",,,79,.T. )
	ElseIf (SRA->RA_CATFUNC $ "T" .Or. cCategAnt $ "T") .and. cHist == "T"
		Impr("|"+ aSal[n,2]					,"C",,,00,.F. )		//-- Data de
		Impr("|"+ aSal[n,3]					,"C",,,10,.F. )		//-- Data Ate
		Impr("|"+ substr(aSal[n,4],1,14)	,"C",,,20,.F. )		//-- Tarefa
		Impr("|"+ aSal[n,6]					,"C",,,35,.F. )		//-- Qtd. Tarefa
		Impr("|"+ aSal[n,7]					,"C",,,48,.F. )        //Valor unitario
		Impr("|"+ Substr(aSal[n,8],1,20)	,"C",,,64,.F. )
		Impr("|"           					,"C",,,79,.T. )
	Else
		Impr("|"+ aSal[n,1]					,"C",,,00,.F. )		//-- Data Alteracao
		Impr("|"+ aSal[n,2]					,"C",,,11,.F. )		//-- Descricao
		Impr("|"+ aSal[n,3]					,"C",,,32,.F. )		//-- Categoria
		Impr("|"+ aSal[n,4]					,"C",,,38,.F. )		//-- pgto
		Impr("|"+ aSal[n,5]					,"C",,,44,.F. )		//-- Verba
		Impr("|"+ aSal[n,6]					,"C",,,65,.F. )		//-- Valor
		Impr("|"           					,"C",,,79,.T. )
		Impr("|"+ aSal[n,10]				,"C",,,00,.F. )		//-- Data Dissidio
		Impr("|"+ aSal[n,7]					,"C",,,11,.F. )
		Impr("|"            				,"C",,,32,.F. )
		Impr("|"            				,"C",,,38,.F. )
		Impr("|"            				,"C",,,44,.F. )
		Impr("|"            				,"C",,,65,.F. )
		Impr("|"            				,"C",,,79,.T. )
		Impr("|"            				,"C",,,00,.F. )
		Impr("|"+ Substr(aSal[n,8],1,20)	,"C",,,11,.F. )
		Impr("|"            				,"C",,,32,.F. )
		Impr("|"            				,"C",,,38,.F. )
		Impr("|"            				,"C",,,44,.F. )
		Impr("|"            				,"C",,,65,.F. )
		Impr("|"           					,"C",,,79,.T. )
    EndIf
Next n
Impr("","C")
Impr(aDetalhe[1],"C")
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpCatG  ºAutor  ³Desenv - SSERVICE   º Data ³  27/05/08   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Normal                   º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function  fImpCatG(aCat)
Local nLinhas	:= 0
Local N 		:= 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Testa Quebra de Pagina                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	fTestaQuebra(aCat,@nLinhas)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Box Detalhe                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	fCatBox(nLinhas)

	For N:=1 To Len(aCat)
 		If nLin + 100 > nLinMax

 			fFimPag(aCat,N,@nLinhas)
 			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Box Detalhe                                                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			fCatBox(nLinhas)
			ImprG(aCat[01,1],"C",,,0060,.f.,nLin,oFont08)			//-- Cabecalho
			ImprG(aCat[01,2],"C",,,0260,.f.,nLin,oFont08)			//-- Cabecalho
			nLin+=50
		Endif
		ImprG(aCat[n,1],"C",,, 060,.f.,nLin,oFont08)				// Detalhe campo
		ImprG(aCat[n,2],"C",,, 260,.f.,nLin,oFont08)				// Detalhe campo
		nLin += 50
	Next N
	ImprG("","C",,,,,nLinhas)
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpAfasG ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Grafico.                 º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function fImpAfasG(aAfas)
Local nAltura	:= 0
Local aColunas:= {}

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Testa Quebra de Pagina                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	fTestaQuebra(aAfas,@nAltura)

	aAdd(aColunas,{nLin + 50  , 220,nAltura , 220})
	aAdd(aColunas,{nLin + 50  ,1700,nAltura ,1700})
	aAdd(aColunas,{nLin + 50  ,2000,nAltura ,2000})


	BuildTable(aAfas, nAltura, OemToAnsi(STR0018), aColunas)
	aSize(aColunas,0)
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpAfasN ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Normal                   º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function  fImpAfasN(aAfas)
Local N ,M , nDet
Local aDetalhe	:= {}

If li >= 60
	Impr(" ","P")
Endif
Impr("","C")

//-- Box Detalhe
aAdd(aDetalhe," ------------------------------------------------------------------------------ ")
aAdd(aDetalhe,"|                                                                              |")
aAdd(aDetalhe,"|------------------------------------------------------------------------------|")
aAdd(aDetalhe,"|          |                                             |          |          |")
aAdd(aDetalhe,"|----------+---------------------------------------------+----------+----------|")
             //12345678901234567890123456789012345678901234567890123456789012345678901234567890
             //         10        20        30        40        50        60        70
//            "|99/99/9999+---------------------------------------------+99/99/9999+99/99/9999|")

nDet	:= (78 - len(STR0018) ) /2
aDetalhe[2]	:= stuff(aDetalhe[2],nDet,len(oemtoAnsi(STR0018)) , oEmtoAnsi(STR0018) )
aDetalhe[4]	:= Stuff(aDetalhe[4],02,len(aAfas[1,1]),aAfas[1,1])
aDetalhe[4]	:= Stuff(aDetalhe[4],13,len(aAfas[1,2]),aAfas[1,2])
aDetalhe[4]	:= Stuff(aDetalhe[4],59,len(aAfas[1,3]),aAfas[1,3])
aDetalhe[4]	:= Stuff(aDetalhe[4],70,len(aAfas[1,4]),aAfas[1,4])

If (li + Len(aDetalhe) + Len(aAfas)+ 04  ) >= 60
	Impr("","P")
Endif

For m:= 1 to Len(aDetalhe)
	Impr(aDetalhe[m],"C")
Next m

For N:=2 To Len(aAfas)
	Impr("|"+ aAfas[n,1],"C",,,00,.F. )
	IF len(aAfas[n,2]) > 45
		Impr("|"+ substr(aAfas[n,2],1,45),"C",,,11,.F. )
	Else
		Impr("|"+ aAfas[n,2],"C",,,11,.F. )
	Endif
	Impr("|"+ aAfas[n,3],"C",,,57,.F. )
	Impr("|"+ aAfas[n,4],"C",,,68,.F. )
	Impr("|","C",,,79 )
	IF len(aAfas[n,2]) > 45
		Impr("|"                           ,"C",,,00,.F. )
		Impr("|"+ substr(aAfas[n,2],46,55),"C",,,11,.F. )
		Impr("|"                           ,"C",,,57,.F. )
		Impr("|"                           ,"C",,,68,.F. )
		Impr("|"                           ,"C",,,79 )
	Endif
Next n
Impr(aDetalhe[1],"C")
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpFeriaGºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Grafico                  º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function  fImpFeriaG(aFerias)
Local nLinhas	:= 0
Local aColunas := {}

	//³ Testa Quebra de Pagina                                       ³
	fTestaQuebra(aFerias,@nLinhas)

	aAdd(aColunas,{nLin + 50  , 400,nLinhas , 400})
	aAdd(aColunas,{nLin + 50  , 800,nLinhas , 800})
	aAdd(aColunas,{nLin + 50  ,1150,nLinhas ,1150})
	aAdd(aColunas,{nLin + 50  ,1500,nLinhas ,1500})
	aAdd(aColunas,{nLin + 50  ,1700,nLinhas ,1700})
	aAdd(aColunas,{nLin + 50  ,1900,nLinhas ,1900})

	BuildTable(aFerias, nLinhas, OemToAnsi(STR0021), aColunas)
	aSize(aColunas,0)
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpFeriaNºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Normal                   º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function  fImpFeriaN(aFerias)
Local N ,M , nDet
Local aDetalhe	:= {}

If li >= 60
	Impr(" ","P")
Endif
Impr("","C")

//-- Box Detalhe
aAdd(aDetalhe," ------------------------------------------------------------------------------ ")
aAdd(aDetalhe,"|                                                                              |")
aAdd(aDetalhe,"|------------------------------------------------------------------------------|")
aAdd(aDetalhe,"|                       |                         |              |             |")
aAdd(aDetalhe,"|-----------------------+-------------------------+--------------+-------------|")
             //12345678901234567890123456789012345678901234567890123456789012345678901234567890
             //         10        20        30        40        50        60        70
nDet	:= (78 - Len(STR0021)) / 2
aDetalhe[2]	:= stuff(aDetalhe[2],nDet,len(oemtoAnsi(STR0021)) , oEmtoAnsi(STR0021) )
aDetalhe[4]	:= Stuff(aDetalhe[4],03,len(aFerias[1,1]),aFerias[1,1])
aDetalhe[4]	:= Stuff(aDetalhe[4],27,len(aFerias[1,2]),aFerias[1,2])
aDetalhe[4]	:= Stuff(aDetalhe[4],53,len(aFerias[1,3]),aFerias[1,3])
aDetalhe[4]	:= Stuff(aDetalhe[4],68,len(aFerias[1,4]),aFerias[1,4])

If (li + Len(aDetalhe) + Len(aFerias)+ 04 ) >= 60
	Impr("","P")
Endif

For m:= 1 to Len(aDetalhe)
	Impr(aDetalhe[m],"C")
Next m

For N:=2 To Len(aFerias)
	Impr("|"+aFerias[n,1],"C",,,00,.F.)
	Impr("|"+aFerias[n,2],"C",,,24,.F.)
	Impr("|"+aFerias[n,3],"C",,,50,.F.)
	Impr("|"+aFerias[n,4],"C",,,65,.F.)
	Impr("|","C",,,79 )
Next N
Impr(aDetalhe[1],"C")
Return


/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpCadG  ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Grafico                  º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function  fImpCadG(aAltCad)
Local nAltura	:= 0
Local aColunas:= {}

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Testa Quebra de Pagina                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	fTestaQuebra(aAltCad,@nAltura)

	aAdd(aColunas,{nLin + 50  , 350,nAltura , 350})
	aAdd(aColunas,{nLin + 50  , 800,nAltura , 800})

	BuildTable(aAltCad, nAltura, OemToAnsi(STR0024), aColunas)
	aSize(aColunas,0)
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpCadN  ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Normal                   º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function  fImpCadN(aAltCad)
Local N , M, nDet
Local aDetalhe	:= {}

If li >= 60
	Impr(" ","P")
Endif
Impr("","C")

aAdd(aDetalhe," ------------------------------------------------------------------------------ ")
aAdd(aDetalhe,"|                                                                              |")
aAdd(aDetalhe,"|------------------------------------------------------------------------------|")
aAdd(aDetalhe,"|             |                   |                                            |")
aAdd(aDetalhe,"|-------------+-------------------+--------------------------------------------|")
             //12345678901234567890123456789012345678901234567890123456789012345678901234567890
             //         10        20        30        40        50        60        70

nDet	:= (78 - Len(STR0024)) / 2
aDetalhe[2]	:= stuff(aDetalhe[2],nDet,len(oemtoAnsi(STR0024)) , oEmtoAnsi(STR0024) )
aDetalhe[4]	:= Stuff(aDetalhe[4],02,len(aAltCad[1,1]),aAltCad[1,1])
aDetalhe[4]	:= Stuff(aDetalhe[4],17,len(aAltCad[1,2]),aAltCad[1,2])
aDetalhe[4]	:= Stuff(aDetalhe[4],37,len(aAltCad[1,3]),aAltCad[1,3])


If ( Li + Len(aDetalhe) + Len(aAltCad) + 04 ) >= 60
	Impr("","P")
Endif

For m:= 1 to Len(aDetalhe)
	Impr(aDetalhe[m],"C")
Next m

For n:= 2 to Len(aAltCad)
	Impr("|"+aAltCad[n,1],"C",,,00,.F.)
	Impr("|"+aAltCad[n,2],"C",,,14,.F.)
	Impr("|"+aAltCad[n,3],"C",,,34,.F.)
	Impr("|","C",,,79 )
Next n

Impr(aDetalhe[1],"C")
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpDepG  ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Grafico                  º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function  fImpDepG(aDep)
Local nAltura	:= 0
Local aColunas:= {}

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Testa Quebra de Pagina                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	fTestaQuebra(aDep,@nAltura)
					/*EixoY		, EixoX, PosY			, PosX			*/
	aAdd(aColunas,{nLin + 50		, 200	, nAltura		, 200			})
	aAdd(aColunas,{nLin + 50		, 890	, nAltura		, 890			})
	aAdd(aColunas,{nLin + 50		, 1190	, nAltura		, 1190			})
	aAdd(aColunas,{nLin + 50		, 1400	, nAltura		, 1400			})
	If cPaisLoc <> "MEX"
		aAdd(aColunas,{nLin + 50		, 1700	, nAltura		, 1700			})
		aAdd(aColunas,{nLin + 50		, 1900	, nAltura		, 1900			})
	EndIf

	/*Função responsável pela montagem da tabela.*/
	BuildTable(aDep, nAltura, OemToAnsi(STR0026), aColunas,,.T.)

	aSize(aColunas,0)
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpDepN  ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Normal                   º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function  fImpDepN(aDEp)
Local N , M , nDet
Local aDetalhe	:= {}

If li >= 60
	Impr(" ","P")
Endif
Impr("","C")

aAdd(aDetalhe," ------------------------------------------------------------------------------ ")
aAdd(aDetalhe,"|                                                                              |")
// Mexico nao possui IR Dependentes e Salario Familia
If cPaisLoc == "MEX"
	aAdd(aDetalhe,"|------------------------------------------------------------------------------|")
	aAdd(aDetalhe,"|   |                              |          |    |                           |")
	aAdd(aDetalhe,"|---+------------------------------+----------+----+---------------------------|")
Else
	aAdd(aDetalhe,"|------------------------------------------------------------------------------|")
	aAdd(aDetalhe,"|   |                              |          |    |         |      |          |")
	aAdd(aDetalhe,"|---+------------------------------+----------+----+---------+------+----------|")
EndIf
             //|99 |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 99/99/9999| X       X       X        X    |
             //|Cod|Nome                           Dt.Nasc.   Sexo Parent  |Dp.IR.|Dp.S.Fam. |"
             //12345678901234567890123456789012345678901234567890123456789012345678901234567890
             //         10        20        30        40        50        60        70
nDet	:= (78 - Len(STR0026)) / 2
aDetalhe[2]	:= stuff(aDetalhe[2],nDet,len(oemtoAnsi(STR0026)) , oEmtoAnsi(STR0026) )
aDetalhe[4]	:= Stuff(aDetalhe[4],02,(len(aDep[1,1])),aDep[1,1])
aDetalhe[4]	:= Stuff(aDetalhe[4],06,len(aDep[1,2]),aDep[1,2])
aDetalhe[4]	:= Stuff(aDetalhe[4],37,len(aDep[1,3]),aDep[1,3])
aDetalhe[4]	:= Stuff(aDetalhe[4],48,len(aDep[1,4]),aDep[1,4])
aDetalhe[4]	:= Stuff(aDetalhe[4],53,len(aDep[1,5]),aDep[1,5])
If cPaisLoc <> "MEX"
	aDetalhe[4]	:= Stuff(aDetalhe[4],63,len(aDep[1,6]),aDep[1,6])
	aDetalhe[4]	:= Stuff(aDetalhe[4],70,len(aDep[1,7]),aDep[1,7])
Endif

If (Li + Len(aDetalhe) + Len(aDep)+ 04 ) >= 60
	Impr("","P")
Endif

For m:= 1 to Len(aDetalhe)
	Impr(aDetalhe[m],"C")
Next m

For N:=2  to Len(aDep)
	If !aDep[n,9]
		Impr("|"+aDep[n,1],"C",,,00,.F.)		//--Codigo
		Impr("|"+Substr(aDep[n,2],01,30),"C",,,04,.F.)		//--Dependente
		Impr("|"+aDep[n,3],"C",,,35,.F.)		//--Dt.Nasc.
		Impr("|"+substr(aDep[n,4],1,4),"C",,,46,.F.)		//--Sexo
		Impr("|"+aDep[n,5],"C",,,51,.F.)	//--Parent
		If cPaisLoc <> "MEX"
			Impr("|"+aDep[n,6],"C",,,61,.F.)	//--Dp.Ir.
			Impr("|"+aDep[n,7],"C",,,68,.F.)	//--Dp.S.Fam.
		EndIf
		If Len(aDep[n,2]) > 30	// Nome Dependente até 70
			Impr("|","C",,,79 )
			Impr("|"+Space(03)+"|"+substr(aDep[n,2],31,30),"C",,,00,.F.)
			Impr("|"+Space(10)+"|"+Space(4)+"|"+Space(9)+"|"+Space(6)+"|"+Space(10)+"|","C",,,35)
			If Len(aDep[n,2]) > 60
				Impr("|"+Space(03)+"|"+substr(aDep[n,2],61,10),"C",,,00,.F.)
				Impr("|"+Space(10)+"|"+Space(4)+"|"+Space(9)+"|"+Space(6)+"|"+Space(10)+"|","C",,,35)
			EndIf
		Else
			Impr("|","C",,,79 )
		EndIf
	EndIf
Next N

Impr(aDetalhe[1],"C")
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpBenG  ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Grafico                  º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function  fImpBenG(aBenef)
Local nAltura	:= 0 /*Altura da Tabela*/
Local aColunas:= {}/*Colunas da Tabela(aonde ficarão as linhas verticais)*/

	//³ Testa Quebra de Pagina                                       ³
	fTestaQuebra(aBenef,@nAltura)

	/*Estabelece as colunas da tabela.*/
					/*EixoY	,EixoX	, PosY		, PosX*/
	aAdd(aColunas,{nLin + 50	,200	,nAltura	, 200})

	/*Monta a tabela*/
	BuildTable(aBenef, nAltura, OemToAnsi(STR0060), aColunas)
	aSize(aColunas,0)
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpBenN  ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Normal                   º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function  fImpBenN(aBenef)
Local N , M , nDet
Local aDetalhe	:= {}

If li >= 60
	Impr(" ","P")
Endif
Impr("","C")

aAdd(aDetalhe," ------------------------------------------------------------------------------ ")
aAdd(aDetalhe,"|                                                                              |")
aAdd(aDetalhe,"|------------------------------------------------------------------------------|")
aAdd(aDetalhe,"|    |                                                                         |")
aAdd(aDetalhe,"|----+-------------------------------------------------------------------------|")
             //|Cod |Beneficiario
             //  99
             //12345678901234567890123456789012345678901234567890123456789012345678901234567890
             //         10        20        30        40        50        60        70
nDet	:= (78 - Len(STR0060)) / 2
aDetalhe[2]	:= stuff(aDetalhe[2],nDet,len(oemtoAnsi(STR0060)) , oEmtoAnsi(STR0060) )
aDetalhe[4]	:= Stuff(aDetalhe[4],02,len(aBenef[1,1]),aBenef[1,1])
aDetalhe[4]	:= Stuff(aDetalhe[4],07,len(aBenef[1,2]),aBenef[1,2])

If (Li + Len(aDetalhe) + Len(aBenef) + 04 ) >= 60
	Impr("","P")
Endif

For m:= 1 to Len(aDetalhe)
	Impr(aDetalhe[m],"C")
Next m

For N:=2  to Len(aBenef)
	Impr("|"+aBenef[n,1],"C",,,00,.F.)
	Impr("|"+aBenef[n,2],"C",,,05,.F.)
	Impr("|","C",,,79 )
Next N

Impr(aDetalhe[1],"C")
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpSindG ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Grafico                  º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function  fImpSindG(aConSin, cTituSind)
Local nAltura	:= 0 /*Altura da Tabela*/
Local nPos		:= 0
Local aColunas:= {}/*Colunas da Tabela*/

	//³ Testa Quebra de Pagina                                       ³
	fTestaQuebra(aConSin,@nAltura)
	aAdd(aColunas,{nLin + 50  , 300,nAltura , 300})
	aAdd(aColunas,{nLin + 50  , 690,nAltura , 690})
	aAdd(aColunas,{nLin + 50  ,1090,nAltura ,1090})

	for nPos:= 1 to Len(aConSin)
		aConSin[nPos,4] := Left(aConSin[nPos,4],50)
	next nPos

	BuildTable(aConSin, nAltura, cTituSind, aColunas)
	aSize(aColunas,0)
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpSindN ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Normal                   º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function  fImpSindN(aConSin, cTituSind)
Local N , M , nDet
Local aDetalhe	:= {}

If li >= 60
	Impr(" ","P")
Endif
Impr("","C")

aAdd(aDetalhe," ------------------------------------------------------------------------------ ")
aAdd(aDetalhe,"|                                                                              |")
aAdd(aDetalhe,"|------------------------------------------------------------------------------|")
aAdd(aDetalhe,"|           |       |               |                                          |")
aAdd(aDetalhe,"|-----------+-------+---------------+------------------------------------------|")
            //"|Data       | Mes   |          Valor| Sindicato                                |"
             //12345678901234567890123456789012345678901234567890123456789012345678901234567890
             //         10        20        30        40        50        60        70
nDet	:= (78 - Len(cTituSind)) / 2
aDetalhe[2]	:= stuff(aDetalhe[2],nDet,len(oemtoAnsi(cTituSind)) , oEmtoAnsi(cTituSind) )
aDetalhe[4]	:= Stuff(aDetalhe[4],02,len(aConSin[1,1]),aConSin[1,1])
aDetalhe[4]	:= Stuff(aDetalhe[4],14,len(aConSin[1,2]),aConSin[1,2])
aDetalhe[4]	:= Stuff(aDetalhe[4],22,len(aConSin[1,3]),aConSin[1,3])
aDetalhe[4]	:= Stuff(aDetalhe[4],38,len(aConSin[1,4]),aConSin[1,4])

If ( LI + Len(aDetalhe) + Len(aConSin)+ 04 ) >= 60
	Impr("","P")
Endif

For m:= 1 to Len(aDetalhe)
	Impr(aDetalhe[m],"C")
Next m

For N:=2  to Len(aConSin)
	Impr("|"+aConSin[n,1],"C",,,00,.F.)
	Impr("|"+aConSin[n,2],"C",,,12,.F.)
	Impr("|"+aConSin[n,3],"C",,,20,.F.)
	Impr("|"+left(aConSin[n,4],40), "C",,,36,.F.)
	Impr("|","C",,,79 )
Next N

Impr(aDetalhe[1],"C")
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpTraG  ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Grafico                  º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function  fImpTraG(aTransf)
Local nLinhas	:= 0
Local aColunas:={}

	//³ Testa Quebra de Pagina                                       ³
	fTestaQuebra(aTransf,@nLinhas)

	aAdd(aColunas,{nLin + 50  , 250,nLinhas , 250})			// linha vertical
	aAdd(aColunas,{nLin + 50  , 1790,nLinhas ,1790})		// linha vertical

	BuildTable(aTransf, nLinhas, OemToAnsi(STR0041), aColunas, 2)
	aSize(aColunas,0)
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpTraN  ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Normal                   º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
*/
Static Function  fImpTraN(aTransf)
Local N , M , nDet
Local aDetalhe	:= {}

If li >= 60
	Impr(" ","P")
Endif
Impr("","C")

aAdd(aDetalhe," ------------------------------------------------------------------------------ ")
aAdd(aDetalhe,"|                                                                              |")
aAdd(aDetalhe,"|------------------------------------------------------------------------------|")
aAdd(aDetalhe,"|           |                                                                  |")
aAdd(aDetalhe,"|           |                                                                  |")
aAdd(aDetalhe,"|-----------+------------------------------------------------------------------|")
            //"|           | Empresa de Origem                                                | "
            //"|Data       | Empresa de Destino                                               | "
            // 12345678901234567890123456789012345678901234567890123456789012345678901234567890
            //          10        20        30        40        50        60        70
nDet	:= (78 - Len(STR0041)) / 2
aDetalhe[2]	:= stuff(aDetalhe[2],nDet,len(oemtoAnsi(STR0041)) , oEmtoAnsi(STR0041) )
aDetalhe[4]	:= Stuff(aDetalhe[4],14,len(aTransf[1,2]),aTransf[1,2])
aDetalhe[4]	:= Stuff(aDetalhe[4],65,len(aTransf[1,3]),aTransf[1,3])
aDetalhe[5]	:= Stuff(aDetalhe[5],02,len(aTransf[2,1]),aTransf[2,1])
aDetalhe[5]	:= Stuff(aDetalhe[5],14,len(aTransf[2,2]),aTransf[2,2])
aDetalhe[5]	:= Stuff(aDetalhe[5],65,len(aTransf[2,3]),aTransf[2,3])

If ( Li + Len(aDetalhe) + Len(aTransf)+ 04  ) >= 60
	Impr("","P")
Endif

For m:= 1 to Len(aDetalhe)
	Impr(aDetalhe[m],"C")
Next m

For N:=3  to Len(aTransf)
	Impr("|","C",,,00,.F.)
	If !empty(aTransf[n,3])
		Impr("|"+aTransf[n,3],"C",,,12,.F.)
		Impr("|","C",,,79 )
	Endif
	If !empty(aTransf[n,1] )
		Impr("|"+aTransf[n,1],"C",,,00,.F.)
	endif
	Impr("|"+aTransf[n,2],"C",,,12,.F.)
	Impr("|","C",,,79 )
Next N
Impr(aDetalhe[1],"C")
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CabecGraf ºAutor  ³Microsiga - Natie   º Data ³  12/18/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FUNCTION cabecGraf(cTitulo,cCabec1,cCabec2,cNomPrg,nTamanho,aCustomText,lPerg,nLinha)

Local nLargura
Local nLin	:=0
Local lNUse := cPaisLoc == "PER"
Default nLinha := 0
Default aCustomText := Nil // Parâmetro que se passado suprime o texto padrao desta função por outro customizado

nLin := nLinha
nlargura:= IF(nTamanho=="P",2250,IF(nTamanho=="G",2300,2500))
cTitulo :=Iif(TYPE("NewHead")!="U",NewHead,cTitulo)
cNomPrg := Alltrim(cNomPrg)

nLin += 15
//Box Itens
oPrint:Box(nLin, 30, nLinMax, 2350 )
nLin 	+= 40
nColuna:= 100

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Imprime box com foto funcionario                             ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
If lFirst
   	//-- Verifica foto do funcionario
	fFoto(nLin)

	nColuna	:= 480
	If  Len(aCustomText) >0
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Imprime texto de outro cabecalho passado no array            ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		//-- Desenha Cabecalho
		oPrint:Line(nlin,nColuna-10  ,nlin+60, nColuna-10)				//1a linha
		oPrint:Line(nlin,nColuna+1315,nlin+60, nColuna+1315) 			//1a linha
		oPrint:Line(nlin+60,nColuna-10  ,nlin+60, nColuna+1315) 		//Horizontal
		oPrint:say(nLin,ncoluna,aCustomText[1],oFont10) 				//Empresa

		oPrint:Line(nlin,nColuna+1325,nlin+60, nColuna+1325) 			//1a linha
		oPrint:Line(nlin,nColuna+1820,nlin+60, nColuna+1820) 			//1a linha
		oPrint:Line(nlin+60,nColuna+1325,nlin+60, nColuna+1820) 		//Horizontal
		oTamFont := If( Len(aCustomText[2]) > 22, oFont08c, oFont10 ) 	//Reduz a fonte p/ nao ultrapassar o limite
		oPrint:say(nLin,ncoluna+1335,aCustomText[2],oTamFont) 			//Filial
		nLin +=90

		oPrint:Line(nlin,nColuna-10  ,nlin+60, nColuna-10)				//2a Linha
		oPrint:Line(nlin,nColuna+1820,nLin+60, nColuna+1820)			//2a Linha
		oPrint:Line(nlin+60,nColuna-10  ,nlin+60, nColuna+1820) 		//Horizontal
		oTamFont := If( Len(aCustomText[3]) > 75, oFont08c, oFont10 )	//Reduz a fonte p/ nao ultrapassar o limite
		oPrint:say(nLin,ncoluna,aCustomText[3],oTamFont)				//Endereco
		nLin +=90

		oPrint:Line(nlin,nColuna-10  ,nlin+60 , nColuna-10) 			//3a Linha
		oPrint:Line(nlin,nColuna+1315,nlin+60 , nColuna+1315)			//3a Linha
		oPrint:Line(nlin+60,nColuna-10  ,nlin+60 , nColuna+1315)		//Horizontal
		oPrint:say(nLin,ncoluna,aCustomText[4],oFont10) 				//Municipio

		oPrint:Line(nlin,nColuna+1325,nlin+60, nColuna+1325) 			//3a Linha
		oPrint:Line(nlin,nColuna+1820,nlin+60, nColuna+1820) 			//3a Linha
		oPrint:Line(nlin+60,nColuna+1325,nlin+60, nColuna+1820) 		//Horizontal
		oPrint:say(nLin,ncoluna+1335,aCustomText[5],oFont10) 			//Cep
		nLin +=90

		oPrint:Line(nlin,nColuna-10 ,nlin+60, nColuna-10)			//4a Linha
		oPrint:Line(nlin,nColuna+730,nLin+60, nColuna+730)			//4a Linha
		oPrint:Line(nlin+60,nColuna-10 ,nlin+60, nColuna+730)		// Horizontal
		oPrint:say(nLin,ncoluna,aCustomText[6],oFont10)            	//CGC

		IF cPaisLoc <> "ANG"
			oPrint:Line(nlin,nColuna+740 ,nlin+60, nColuna+740)			//4a Linha
			oPrint:Line(nlin,nColuna+1315,nlin+60, nColuna+1315)		//4a Linha
			oPrint:Line(nlin+60,nColuna+740 ,nlin+60, nColuna+1315)		// Horizontal
			oPrint:say(nLin,ncoluna+750,aCustomText[7],oFont10)   		    //CNAE
			oPrint:Line(nlin,nColuna+1325,nlin+60, nColuna+1325)		//4a Linha
			oPrint:Line(nlin,nColuna+1820,nlin+60, nColuna+1820)		//4a Linha
			oPrint:Line(nlin+60,nColuna+1325,nlin+60, nColuna+1820)		//Cod.Municipio
			oPrint:say(nLin,ncoluna+1335,aCustomText[8],oFont10)
		Else
			oPrint:Line(nlin,nColuna+740 ,nlin+60, nColuna+740)			//4a Linha
			oPrint:Line(nlin,nColuna+1300,nlin+60, nColuna+1300)		//4a Linha
			oPrint:Line(nlin+60,nColuna+740 ,nlin+60, nColuna+1300)		// Horizontal
			oPrint:say(nLin,ncoluna+750,aCustomText[8],oFont10)
		Endif
	Endif

	lfirst	:= .F.
	nLin 	+= 80
Endif

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Imprime Funcionario                                          ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/

oPrint:Line(nLin+15 ,nColuna-10  ,nLin+090 , nColuna-10  )		//1a vertical
oPrint:Line(nLin+15 ,nColuna+300 ,nLin+090 , nColuna+300 )		//2a vertical
oPrint:Line(nLin+90 ,nColuna-10  ,nlin+090 , nColuna+300 )		//horizontal
oPrint:say(nLin     ,nColuna,"No Ficha"   ,oFont08n ) 			//Ficha
oPrint:say(nLin+40  ,nColuna,If(!lNUse,SRA->RA_FICHA,""),oFont12n)

oPrint:Line(nLin+15 ,nColuna+310 ,nLin+090 , nColuna+310)		//1a vertical
oPrint:Line(nLin+15 ,nColuna+700 ,nLin+090 , nColuna+700)		//2a vertical
oPrint:Line(nLin+90 ,nColuna+310 ,nlin+090 , nColuna+700)		//horizontal
oPrint:say(nLin     ,nColuna+320,STR0004,oFont08n)
oPrint:say(nLin+40  ,nColuna+320,SRA->RA_MAT,oFont12n)

oPrint:Line(nLin+15 ,nColuna+710  ,nLin+090  , nColuna+710)	//1a vertical
oPrint:Line(nLin+15 ,nColuna+1820   ,nLin+090  , nColuna+1820 )	//2a vertical
oPrint:Line(nLin+090,nColuna+710  ,nlin+090  , nColuna+1820 )	//horizontal
oPrint:say(nLin     , nColuna+720 ,STR0006   , oFont08n)
oPrint:Say(nLin+40  , nColuna+720 ,SRA->RA_NOME,oFont12n)

nColuna := 50

If LEN(Trim(cCabec1)) != 0

	nLin += 150
	ImprG(cCabec1,"C",,,nColuna,.T. ,nLin,oFont12)
	If LEN(Trim(cCabec2)) != 0
		ImprG(cCabec2,"C",,,nColuna,.T. ,nLin,oFont12)
	EndIf
	oPrint:Line(nLin,nColuna-20,nLin,nColMax)
	nLin += 40
Else
	nLin += 65
EndIf

m_pag++

nLin+= 40

Return nLin

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER460   ºAutor  ³Microsiga           º Data ³  02/19/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime Rodape Grafico                                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function fRodaPe(wcbcont,wcbtxt,roda_tam)
Local cFileLogo	:= ""

//-- Carrega Logotipo para impressao
fCarLogo(@cFileLogo)

oPrint:Line(nLinMax+015,030,nLinMax+015,nColMax)			      	// Linha horizontal

IF File(cFilelogo)
	oPrint:SayBitmap(nLinMax + 030,30, cFileLogo,300,080) 			// Tem que estar abaixo do RootPath
Endif

If nTipFicha == 1
	oPrint:say(nLinMax +055,2000, STR0123+Time(),oFont08)
	oPrint:Line(nLinMax+125,030,nLinMax+125,nColMax)			      	// Linha horizontal
	oPrint:EndPage()
Else
	oPrint:say(nLinMax + 030,500, STR0130, oFont08)
	oPrint:say(nLinMax + 060,500, STR0111, oFont08)
	oPrint:say(nLinMax + 090,500, STR0112, oFont08)
	oPrint:say(nLinMax + 090,2000, "-  "+STR0123+Time(),oFont08)

	oPrint:Line(nLinMax+130,050,nLinMax+130,nColMax)			      	// Linha horizontal
	oPrint:EndPage()
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ImprG     ºAutor  ³Microsiga           º Data ³  18/02/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ImprG( cDetalhe , cFimFolha , nReg , cRoda , nColun , lSalta , nLinha,oFont)

Local aCabec := {}
Local cDetCab:= ""
Local cWCabec:= ""
Local nCb	 := 0
Local nLargura := IF(nTamanho=="P",2250,IF(nTamanho=="G",2300,2500))

Static lPerg

m_pag		:= ContFl
cFimFolha	:= IF( cFimFolha		== NIL							  		, ""		, cFimFolha	)
cDetalhe	:= IF( cDetalhe			== NIL							  		, ""		, cDetalhe	)
wCabec0 	:= IF( Type("wCabec0")	== "U"							  		, 0			, wCabec0	)
wCabec1 	:= IF( Type("wCabec1")	== "U"							  		, ""		, wCabec1	)
wCabec2 	:= IF( Type("wCabec2")	== "U"							  		, ""		, wCabec2	)
nReg		:= IF( nReg				== NIL							  		, 0.00		, nReg		)
wnRel		:= IF( Type("wnRel")	== "U" .and. Type("nomeprog") != "U"	, nomeprog	, wnRel		)
nColun 		:= IF( nColun			== NIL							  		, 0			, nColun	)
nLinha		:= IF( nLinha			== NIL							  		, 0			, nLinha	)
lSalta		:= IF( lSalta 			== NIL							  		, .T. 		, lSalta	)


IF Upper(cFimFolha) $ "FP" .or. nLinha >= nLinMax
	IF nLinha != 0.00
		IF Upper(cFimFolha) $ "F" .or. cRoda != NIL
			IF nReg == 0.00 .or. cRoda == NIL
				U_fRodaPe( 0.00 , ""    , nTamanho)
			Else
				U_fRodaPe( nReg , cRoda , nTamanho)
			EndIF
		EndIF
		nLinha := 0.00
	EndIF
	IF Upper(cFimFolha) $ "FP"
		Return( NIL )
	EndIF
EndIF

IF nLinha == 0.00
	oPrint:StartPage() 			//Inicia uma nova pagina
	SendCab1(nLargura,@nLinha, nColun)
	For nCb := 1 to wCabec0-1
		IF Type((cWCabec := "wCabec"+Alltrim(Str(nCb)))) != "U"
			cDetCab := &(cWCabec)
			aAdd(aCabec,cDetCab)
		EndIF
	Next nCb
	nlinha:=  CabecGraf( Titulo , "" , "" , wnrel , nTamanho ,aCabec, lPerg, nLinha)
	ContFl++
EndIF

//-- Imprime linha de detalhe
If nColun == 1800 .And. nColun + Len(cDetalhe) > 1830
	oPrint:say(nLinha,nColun,Substr(cDetalhe,1,30),oFont)
	oPrint:say(nLinha + 40,nColun,Substr(cDetalhe,31),oFont)
Else
	If (nColun == 1490 .or. nColun == 1840) .and. Len(Alltrim(cDetalhe)) > 20
		cDetalhe := AllTrim(SubStr(cDetalhe,1,20))+"."
	EndIf
	oPrint:say(nLinha,nColun,cDetalhe,oFont)
Endif

IF lSalta
	nLinha += 40
Endif

nLin	:= nLinha
nColuna	:= nColun

Return nlin


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SendCab1  ºAutor  ³Microsiga           º Data ³  18/02/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function SendCab1(nSpace,nLinha, nColun)

Local cDetCab 	:= ""
Local nEspaco 	:= 0
Local cFileLogo	:= ""

//-- Carrega Logotipo para impressao
fCarLogo(@cFileLogo)

nLinha++

// Nome da Empresa / Pagina  / Logotipo
oPrint:Line(nLinha,nColun-20,nLinha,nColMax)
If File(cFilelogo)
	nLinha += 15
	oPrint:SayBitmap(nLinha,50, cFileLogo,400,090) // Tem que estar abaixo do RootPath
	nLinha += 85
else
	nLinha += 100
Endif
cDetCab 	:=  STR0120 +" " + TRANSFORM(m_pag,'999999')
oPrint:say(nLinha, 1950  ,cDetCab,oFont10)
nLinha += 50
// Versão
cDetCab := "SIGA /"+wnrel+"/v."+cVersao+"  "
oPrint:say(nLinha,nColun -10 ,cDetCab,oFont10)

//-- Titulo
cDetCab := Trim(Titulo)
nEspaco	:= (nColMax - Len(AllTrim(Titulo)) *100 / 6 ) / 2
oPrint:say(nLinha, nEspaco , cDetCab, oFont12n)

cDetCab :=  STR0122 +" "+ DTOC(dDataBase)
oPrint:say(nLinha,1950,cDetCab,oFont10)

nLinha += 50
// Hora da emissão / Data Emissao
cDetCab := STR0121+" "+time()
oPrint:say(nLinha,nColun-10,cDetCab,oFont10)

cDetCab := STR0124+" "+DToC(MsDate())
oPrint:say(nLinha,1950,cDetCab,oFont10)

nLinha += 50
oPrint:Line(nLinha,nColun-20,nLinha,nColMax)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fcarLogo  ºAutor  ³RH - Natie          º Data ³  02/18/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fCarLogo(cLogo)
Local  cStartPath:= GetSrvProfString("Startpath","")

cLogo	:= cStartPath + "LGRL"+cEmpAnt+SRA->RA_FILIAL+".BMP" // Empresa+Filial
//-- Logotipo da Empresa
If !File( cLogo )
		cLogo := cStartPath + "LGRL"+cEmpAnt+".BMP" // Empresa
Endif

Return cLogo

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fFoto     ºAutor  ³RH - Natie          º Data ³  02/18/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fFoto(nLinha)
Local aArea		:= GetArea()
Local cAlias	:= "PROTHEUS_REPOSIT"
Local cBmpPict	:= ""
Local cPath		:= GetSrvProfString("Startpath","")
Local lFile
Local oDlg8
Local oBmp
Local cSAlias := Alias()
Local nSRecno := RecNo()
Local nSOrdem := IndexOrd()
Default nLinha:= 380

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Carrega a Foto do Funcionario								   ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
cBmpPict := Upper( AllTrim( SRA->RA_BITMAP))
cPathPict 	:= ( cPath + cBmpPict)

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Para impressao da foto eh necessario abrir um dialogo para   ³
³ extracao da foto do repositorio.No entanto na impressao,nao  |
³ ha a necessidade de visualiza-lo( o dialogo).Por esta razao  ³
³ ele sera montado nestas coordenadas fora da Tela             ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
DEFINE MSDIALOG oDlg8   FROM -1000000,-4000000 TO -10000000,-8000000  PIXEL
@ -10000000, -1000000000000 REPOSITORY oBmp SIZE -6000000000, -7000000000 OF oDlg8

If _lRepDb
	dbSelectArea(cAlias)
	(cAlias)->( dbSeek(cBmpPict) )
EndIf

nLinha -= 15
//-- Box com  Foto
oPrint:Box(nLinha,60,nLinha + 500, 460 )

// Verifica se a imagem existe no repositorio
If !Empty(cBmpPict) .AND. oBMP:ExistBMP(cBmpPict)
	If !_lRepDb
		oBmp:LoadBmp(cBmpPict)
	EndIf

	nLinha += 20
	IF !Empty( cBmpPict := Upper( AllTrim( SRA->RA_BITMAP ) ) )
		lFile:=oBmp:Extract(cBmpPict, cPathPict)
		If lFile
			If File(cPathPict+".BMP")
				oPrint:SayBitmap(nLinha,75,cPathPict + ".BMP",370,470)
				aAdd(aFotos,cPathPict + ".BMP")
			ElseIf File(cPathPict+".JPG")
				oPrint:SayBitmap(nLinha,75,cPathPict + ".JPG",370,470)
				aAdd(aFotos,cPathPict + ".JPG")
			EndIf
		EndIf
	EndIf
EndIf
ACTIVATE MSDIALOG oDlg8 ON INIT (oBmp:lStretch := .T., oDlg8:End())

dbselectarea(cSAlias)
dbsetorder(nSOrdem)
dbgoto(nSRecno)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fSalBox   ºAutor  ³RH - Natie          º Data ³  02/18/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Box-Alteracao Salarial                                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fSalBox(nLinhas,cHist)

Local nCol  := int( ( nColBox - ( Len(STR0015) * 100 / 7) )) /2
Local nColFim := 130

If (SRA->RA_CATFUNC == "T" .Or. cCategAnt $ "T") .and. cHist == "T"
	oPrint:box(nLin, nColuna ,nlinhas, 2000 )
	oPrint:Line(nLin + 50  , 050,nLin + 50  ,2000)
	oPrint:Line(nLin + 100 , 050,nLin + 100 ,2000)
Else
	oPrint:box(nLin, nColuna ,nlinhas, nColBox + nColFim )
	oPrint:Line(nLin + 50  , 050,nLin + 50  ,nColBox +nColFim)
	oPrint:Line(nLin + 100 , 050,nLin + 100 ,nColBox +nColFim)
EndIf

If (SRA->RA_CATFUNC $ "I#J" .Or. cCategAnt $ "I#J") .and. cHist == "T"
	oPrint:Line(nLin + 50  , 230,nLinhas , 230) // Data de
	oPrint:Line(nLin + 50  , 420,nLinhas , 420) // Data ate
	oPrint:Line(nLin + 50  , 610,nLinhas , 610) // Tarefa
	oPrint:Line(nLin + 50  ,1260,nLinhas ,1260) // Aulas/semana
	oPrint:Line(nLin + 50  ,1510,nLinhas ,1510) // qtd. Tarefa
	oPrint:Line(nLin + 50  ,1740,nLinhas ,1740)	 // Valor unitario
	oPrint:Line(nLin + 50  ,2040,nLinhas ,2040)		//Valor Total
ElseIf (SRA->RA_CATFUNC $ "T" .Or. cCategAnt $ "T") .and. cHist == "T"
	oPrint:Line(nLin + 50  , 220,nLinhas , 220) // Data ate
	oPrint:Line(nLin + 50  , 380,nLinhas , 380) // Tarefa
	oPrint:Line(nLin + 50  ,0980,nLinhas ,0980) // qtd. Tarefa
	oPrint:Line(nLin + 50  ,1210,nLinhas ,1210) // Valor unitario
	oPrint:Line(nLin + 50  ,1530,nLinhas ,1530)	 // Valor Total
Else
	oPrint:Line(nLin + 50  , 195,nLinhas , 195) // Data Dissidio
	oPrint:Line(nLin + 50  , 350,nLinhas , 350) // Desc aumento
	oPrint:Line(nLin + 50  , 780,nLinhas , 780) //750 Categoria
	oPrint:Line(nLin + 50  , 860,nLinhas , 860) //850 Pagamento
	oPrint:Line(nLin + 50  , 940,nLinhas , 940) //1000 Verba
	oPrint:Line(nLin + 50  ,1310,nLinhas ,1310) //1400 Valor
	oPrint:Line(nLin + 50  ,1480,nLinhas ,1480)	 //1695 Funcao
	oPrint:Line(nLin + 50  ,1860,nLinhas ,1860)	 //1695 Cargo
EndIf

If (SRA->RA_CATFUNC $ "I#J#T" .Or. cCategAnt $ "I#J#T") .and. cHist == "T"
	nCol  := int( ( nColBox - ( Len(STR0015+STR0099) * 100 / 7) )) /2
	oPrint:say(nLin, nCol,STR0015+STR0099,oFont10n)
Else
	oPrint:say(nLin, nCol,STR0015,oFont10n)
EndIf

nLin += 50

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fCatBox   ºAutor  ³RH - SSERVICE       º Data ³  27/05/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Box- Categoria                                             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fCatBox(nLinhas)

Local nCol	:= int( ( nColBox - ( Len("Alteracao Categoria") * 100 / 7) )) /2
	oPrint:box(nLin, nColuna ,nlinhas, nColBox + 10  )
	oPrint:Line(nLin + 50  , 050,nLin + 50  ,nColBox +10)
	oPrint:Line(nLin + 100 , 050,nLin + 100 ,nColBox +10)
	oPrint:Line(nLin + 50  , 250,nLinhas , 250)
	oPrint:say(nLin, nCol,"Alteracao Categoria",oFont10n)
	nLin += 50
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fAssinatBox ºAutor  ³RH - Natie          º Data ³  12/09/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Box-Assinatura Empregado e responsavel pela Empresa           º±±
±±º          ³                                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MP8                                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fAssinaBox()
Local aArea		:= GetArea()
Local nLinhas 	:= 0
Local nCol		:= int( ( nColBox - ( Len(STR0082) * 100 / 7) )) /2		// Assinaturas
Local M 		:= 0
Local aDetalhe 	:= {}

If nGrafica ==1

	//-- Verifica quebra de pagina
	If (nLin + 450) > nLinMax
		nLin  := 0
		oPrint:EndPage() 		// Finaliza a pagina
		nColuna := 50
		ImprG(" ","C",,,nColuna,,nLin,oFont10)
	Endif

	 //Ajuste para que Fichas de Registro e Anotacoes tenham Assinatura apresentada.
	nLinhas 	:= nLin + 450
	nColuna		:= 050

	oPrint:box(nLin, nColuna ,nlinhas, nColBox + 10  )
	oPrint:Line(nLin + 50  , 050 ,nLin + 50  ,nColBox +10)		//-- linha horizontal
	oPrint:say(nLin        , nCol,STR0082,oFont10n )				//-- Assinaturas
	oPrint:Line(nLin + 50  , 400 ,nLinhas    , 400)				//-- Vertical apos Polegar
	oPrint:Line(nLin + 50  ,1300 ,nLinhas    ,1300)				//-- Vertical apos Assin.Func.
	oPrint:say(nLin+50    , nColuna+10, oemtoAnsi(STR0085),oFont08n )				//-- Polegar Direito
	oPrint:say(nLIn+50    , 0410      , oEmToAnsi(STR0083),oFont08n)				//-- Assinat.Funciona
	oPrint:say(nLIn+50    , 1310      , oEmToAnsi(STR0084),oFont08n)				//-- Assinat.Responsavel
	oPrint:Line(nLin + 370 , 0420 ,nLin +370  ,1300)
	oPrint:Line(nLin + 370 , 1320 ,nLin +370 , 2200)
	//-- Assinatura do Funcionario
	oPrint:say( nLin+380  , 0410   ,SRA->RA_NOME  ,oFont10n)
	//-- Responsavel Legal
	oPrint:say( nLin+380  , 1320   ,cResponsavel  ,oFont10n)
	nLin +=25

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Finaliza impressao Grafica                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ImprG(" " ,"F",0,,0,,nLin)
	oPrint:EndPage()
	If nQuebra == 1 .And. (ContFl - 1) % 2 == 1
		oPrint:StartPage()
		oPrint:EndPage()
	EndIf
	ContFl	:= 1						//-- Inicia nova numeracao da ficha  p/cada funcionario
Else
	If li  + 14 >= 60
		Impr(" ","P")
	Endif
	Impr("","C")

	aAdd(aDetalhe," ------------------------------------------------------------------------------ ")
	aAdd(aDetalhe,"|                                                                              |")
	aAdd(aDetalhe,"|------------------------------------------------------------------------------|")
	aAdd(aDetalhe,"|          |                                  |                                |")
	aAdd(aDetalhe,"|----------+----------------------------------+--------------------------------|")
	aAdd(aDetalhe,"|          |                                  |                                |")
	aAdd(aDetalhe,"|          |                                  |                                |")
	aAdd(aDetalhe,"|          |                                  |                                |")
	aAdd(aDetalhe,"|          |                                  |                                |")
	aAdd(aDetalhe,"|          | -------------------------------- | ------------------------------ |")
	aAdd(aDetalhe,"|          |                                  |                                |")
	aAdd(aDetalhe," ------------------------------------------------------------------------------ ")
	             //|Polegar   | Assinatura Funcionario             Responsavel Legal              |"
	             //12345678901234567890123456789012345678901234567890123456789012345678901234567890
	             //         10        20        30        40        50        60        70
	nDet			:= (78 - Len(STR0082)) / 2
	aDetalhe[02]	:= stuff(aDetalhe[02],nDet,len(oemtoAnsi(STR0082)) ,oEmtoAnsi(STR0082) )
	aDetalhe[04]	:= Stuff(aDetalhe[04],02,len(oemtoAnsi(STR0085))   ,oemtoAnsi(STR0085) )
	aDetalhe[04]	:= Stuff(aDetalhe[04],13,len(oemtoAnsi(STR0083))   ,oemtoAnsi(STR0083) )
	aDetalhe[04]	:= Stuff(aDetalhe[04],49,len(oemtoAnsi(STR0084))   ,oemtoAnsi(STR0084) )
	aDetalhe[11]	:= Stuff(aDetalhe[11],13,len(SRA->RA_NOME )        ,SRA->RA_NOME  )
	aDetalhe[11]	:= Stuff(aDetalhe[11],49,len(cResponsavel)         ,left(cResponsavel,30)   )

	For m:= 1 to Len(aDetalhe)
		Impr(aDetalhe[m],"C")
	Next m

Endif

RestArea( aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fTestaQuebºAutor  ³RH - Natie          º Data ³  02/18/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Efetua Quebra de Pagina qdo Box de detalhe nao couber      º±±
±±º          ³ na folha atual                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fTestaQuebra(aArray, nLinhas,nSumLine)
Default nSumLine := 0

If nLin >= nLinMax
	oPrint:EndPage() 		// Finaliza a pagina
	ImprG(" " ,"P",,,nColuna,,0,)
Endif

nLinhas	:= Int(nLin    + ( (Len(aArray)+1)   * 50 ) ) + (50 * nSumLine)
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Se Array nao couber em  uma pagina, efetua a quebra          |
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
If  nLinhas >= nLinMax
	nColuna	:= 050
	oPrint:EndPage() 		// Finaliza a pagina
	ImprG(" ","C",,,nColuna,,0,oFont10)
	nLinhas	:= Int(nLin    + (( Len(aArray)+1)   * 50 ) ) + (50 * nSumLine)
	If nLinhas >= nLinMax
		nLinhas:= nLinMax-50
	Endif
Endif
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fFimPag   ºAutor  ³RH - Natie          º Data ³  02/18/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Quebra da  pagina quando box de detalhe  for maior que a    º±±
±±º          ³pagina                                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fFimPag(aArray,nX,nLinhas)

oPrint:EndPage() 											// Finaliza a pagina

ImprG(" " ,"C", ,,050,,0,)
nLinhas	:= Int(nLin    + ( (  (Len(aArray)+1) - NX ) * 50 ) ) + 100
If nLinhas >= nLinMax
	nLinhas:= nLinMax-50
Endif
Return

Static Function fDescSexo(cCod)
Return(If(cCod =="F", STR0065, STR0064 ))	//"Feminino"###"Masculino"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER460   ºAutor  ³Microsiga           º Data ³  09/12/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fImpPeriodo()
Local aArea		:= GetArea()

nColuna	:= 050

//³ Periodo de Impressao                                         ³
If nGrafica ==1
	If (nLin + 200) >= nLinMax
		nLin  := 0
		oPrint:EndPage() 		// Finaliza a pagina
		ImprG(" ","C",,,nColuna,,nLin,oFont10)
	Endif

	If lImpDIni .And. lImpDFim
		IF cPaisLoc <> "ANG"
			ImprG(OemToAnsi(STR0081) + DTOc(dDataIni) + " - " + dtoc(dDataFin)  ,"C",,,nColuna,,nLin,oFont10n)
			nLin  += 10
			oPrint:Line(nLin,nColuna - 20, nLin, nColMax)
		Endif
	Endif
	nLin  += 25
Else
	If Li + 3 >= 60
		Impr(" ","P")
	Endif

	Impr( repl("-",78),"C",,,01)
	If lImpDIni .And. lImpDFim
		IF cPaisLoc <> "ANG"
			Impr( OemToAnsi(STR0081) + DTOc(dDataIni) + " - " + dtoc(dDataFin),"C",,,01)
		Endif
	Endif
	Impr( repl("-",78),"C",,,01)

Endif

RestArea( aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER460   ºAutor  ³Microsiga           º Data ³  07/31/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function fDescTarefa(cVar)

Local aArea	:= GetArea()
Local cRet	:= ""
Local nPos	:= 0

nPOS	:= fPosTab("S070", cVar, "==", 04)	//04 = coluna do Codigo da Tarefa
cRet	:= fTabela("S070", nPOS, 05) 		//05 = coluna da Descricao da Tarefa a ser retornada

cRet := If(Empty(CRet)," ", cRet)

RestArea( aArea )
Return ( cRet )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³fGp190TpTa³ Autor ³ Jonatas A. T. Alves	³ Data ³ 11/04/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao para exibir os tipos de tarefas para selecao		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_fGp190TpTa()												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ GPER460  												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function fGp190TpTa()

Local MvPar
Local cTitulo	:= ""
Local MvParDef	:= ""
Local aArea		:= GetArea()

Private aTpTar:={}

MvPar := &(Alltrim(ReadVar()))		 // Carrega Nome da Variavel do Get em Questao
MvRet := Alltrim(ReadVar())			 // Iguala Nome da Variavel ao Nome variavel de Retorno

aTpTar :={;
			"1 - " + STR0114,;	//"Fixa"
			"2 - " + STR0115,;	//"Variavel"
			"3 - " + STR0116,;	//"Adit. Fixo"
			"4 - " + STR0117;	//"Adit. Var."
		}

MvParDef	:= "1234"


cTitulo		:= STR0118  //"Tipos de Tarefas"

IF f_Opcoes(@MvPar,cTitulo,aTpTar,MvParDef)  // Chama funcao f_Opcoes
	&MvRet := Mvpar							// Devolve Resultado
EndIF

RestArea(aArea)

Return(.T.)

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpAfasG ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Normal                   º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ*/
Static Function  fImpTreiG(aTreina, nTipo)
Local nLinhas	:= 0
Local aColunas:= {}
Local cTitulo	:= OemToAnsi(IIF(nTipo == 1,STR0131,STR0134))

	//³ Testa Quebra de Pagina                                       ³
	fTestaQuebra(aTreina,@nLinhas)

	aAdd(aColunas,{nLin + 50  , 250,nLinhas , 250})
	aAdd(aColunas,{nLin + 50  ,1240,nLinhas ,1240})
	aAdd(aColunas,{nLin + 50  ,1540,nLinhas ,1540})
	aAdd(aColunas,{nLin + 50  ,1840,nLinhas ,1840})

	BuildTable(aTreina, nLinhas, cTitulo, aColunas)
   aSize(aColunas,0)
Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpAfasN ºAutor  ³Desenv - RH Natie   º Data ³  12/13/01   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Normal                   º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function  fImpTreiN(aTreina, nTipo)
Local N ,M , nDet
Local aDetalhe	:= {}

If li >= 60
	Impr(" ","P")
Endif
Impr("","C")

//-- Box Detalhe
aAdd(aDetalhe," ------------------------------------------------------------------------------ ")
aAdd(aDetalhe,"|                                                                              |")
aAdd(aDetalhe,"|------------------------------------------------------------------------------|")
aAdd(aDetalhe,"|       |                                     |          |          |          |")
aAdd(aDetalhe,"|-------+-------------------------------------+----------+----------+----------|")
             //12345678901234567890123456789012345678901234567890123456789012345678901234567890
             //         10        20        30        40        50        60        70
//            "|99/99/9999+---------------------------------------------+99/99/9999+99/99/9999|")

If nTipo == 1
	nDet	:= (78 - len(STR0131) ) /2
	aDetalhe[2]	:= stuff(aDetalhe[2],nDet,len(oemtoAnsi(STR0131)) , oEmtoAnsi(STR0131) )
Else
	nDet	:= (78 - len(STR0134) ) /2
	aDetalhe[2]	:= stuff(aDetalhe[2],nDet,len(oemtoAnsi(STR0134)) , oEmtoAnsi(STR0134) )
Endif

aDetalhe[4]	:= Stuff(aDetalhe[4],02,len(aTreina[1,1]),aTreina[1,1])
aDetalhe[4]	:= Stuff(aDetalhe[4],10,len(aTreina[1,2]),aTreina[1,2])
aDetalhe[4]	:= Stuff(aDetalhe[4],48,len(aTreina[1,3]),aTreina[1,3])
aDetalhe[4]	:= Stuff(aDetalhe[4],59,len(aTreina[1,4]),aTreina[1,4])
aDetalhe[4]	:= Stuff(aDetalhe[4],70,len(aTreina[1,5]),aTreina[1,5])

If (li + Len(aDetalhe) + Len(aTreina)+ 04  ) >= 60
	Impr("","P")
Endif

For m:= 1 to Len(aDetalhe)
	Impr(aDetalhe[m],"C")
Next m

For N:=2 To Len(aTreina)
	Impr("|"+ aTreina[n,1],"C",,,00,.F. )
	Impr("|"+ AllTrim(aTreina[n,2]),"C",,,08,.F. )
	Impr("|"+ aTreina[n,3],"C",,,46,.F. )
	Impr("|"+ aTreina[n,4],"C",,,57,.F. )
	Impr("|"+ aTreina[n,5],"C",,,68,.F. )
	Impr("|","C",,,79 )
Next n
Impr(aDetalhe[1],"C")
Return

/*/{Protheus.doc}fSalAdm
Busca salário da admissão
@author Gabriel de Souza Almeida
@since 05/08/2016
@version P12
/*/
Static Function fSalAdm()
	Local aAreaSR3 := GetArea()
	Local nSalario := 0

	DbSelectArea("SR3")
	DbSetOrder(1)
	DbSeek( SRA->RA_FILIAL + SRA->RA_MAT )
	While SR3->( !( EOF() ) ) .And. SRA->RA_FILIAL + SRA->RA_MAT == SR3->R3_FILIAL + SR3->R3_MAT
		If SR3->R3_TIPO == "001"
			nSalario := SR3->R3_VALOR
			Exit
		EndIf
		SR3->(DBSKIP())
	End Do

	RestArea(aAreaSR3)

Return(nSalario)

/*/{Protheus.doc} GenericBox
	Funcao responsavel pela construcao das bordas da tabelas, titulo e
	colunas(linhas verticais).
@author PHILIPE.POMPEU
@since 24/08/2016
@version P12.1.7
@param nAltura, numerico, Altura estimada da tabela(numero de registros * 050)
@param cTitulo, caractere, Titulo da Tabela(por exemplo "Dependentes")
@param aColunas, vetor, posicoes que devem ser construidas as linhas verticais
@param nLinhAtual, numérico, não obrigatório, linha que deve-se comecar a impressao.
@return Nil, Valor Nulo
/*/
Static Function GenericBox(nAltura, cTitulo, aColunas,nLinhAtual)
	Local nCol	:= Int( ( nColBox - ( Len(cTitulo) * 100 / 7) )) /2
	Local nI := 0
	Default nLinhAtual := nLin

	/*Contrói as bordas*/
	oPrint:Box(nLinhAtual, 50, nAltura, nColBox + 10)

	/*Monta o título*/
	oPrint:Say(nLinhAtual, nCol,cTitulo,oFont10n)
	nLinhAtual+= 50
	/*Linha Abaixo do Título*/
	oPrint:Line(nLinhAtual, 050,nLinhAtual ,nColBox + 10)

	/*Monta as colunas(linhas verticais)*/
	for nI:= 1 to Len(aColunas)
		oPrint:Line(aColunas[nI,1] ,aColunas[nI,2],aColunas[nI,3] ,aColunas[nI,4])
	next nI

	nLin 		:= nLinhAtual
Return Nil

/*/{Protheus.doc} BuildTable
	Funcao responsavel pela construcao de tabelas de registros
@author PHILIPE.POMPEU
@since 24/08/2016
@version P12.1.07
@param aRegistros, vetor, dados a serem impressos
@param nAltura, numérico, altura da tabela
@param cTitulo, caracter, Titulo da tabela
@param aColunas, vetor, configuracao das colunas verticais
@param nNumLinCab, numérico, nao obrigatorio, diz quantas linhas de aRegistros compoem o cabecalho
@return Nil, Valor Nulo
/*/
Static Function BuildTable(aRegistros, nAltura, cTitulo, aColunas,nNumLinCab, lDep)
	Local nPos	:= 0
	Local nX 	:= 0
	Local nCab	:= 0
	Local nCol	:= 0
	Local cNome
	Local nColNome
	Default nNumLinCab := 1 /*Determina quantas Linhas compoem o Cabecalho.*/
	Default lDep := .F.

	nNumLinCab++
	For nPos := nNumLinCab To Len(aRegistros)
		/* Caso vá ocorrer a quebra de pagina e ainda exista um registro a ser mostrado
		alem do atual OU seja o primeiro registro, deve-se imprimir o cabecalho.*/
		If (nLin + 100 >= nLinMax .And. nPos + 1 <= Len(aRegistros)) .Or. nPos == nNumLinCab
			if(nLin + 100 >= nLinMax)
				fFimPag(aRegistros,nPos,@nAltura)

				For nX := 1 To Len(aColunas)
					aColunas[nX,3] := nAltura
				Next nX
			endIf

			/*Gera as bordas da tabela, as linhas verticais e o titulo centralizado.*/
			GenericBox(nAltura, cTitulo, aColunas)

			for nCab:= 1 to (nNumLinCab - 1)
				/*Monta a linha cabecalho*/
				for nX:= 1 to Len(aColunas) + 1

					/*Se for primeira coluna, sempre começa em 60*/
					if(nX == 1)
						nCol := 60
					else/*Caso contrario e o valor do eixo X da posicao anterior*/
						nCol := aColunas[nX - 1,4] + 10
					endIf

					ImprG(aRegistros[nCab,nX]	,"C",,,nCol,.F.,nLin,oFont08)
				next nX
				nLin+= 50
			next nCab

			/*Imprime Linha abaixo do Cabecalho!*/
			oPrint:Line(nLin, 050,nLin ,nColBox + 10)
		Endif

		/*Monta a linha do registro atual*/
		for nX:= 1 to Len(aColunas) + 1
			/*Se for primeira coluna, sempre comeca em 60*/
			if(nX == 1)
				nCol := 60
			else/*Caso contrario é o valor do eixo X da posicao anterior*/
				nCol := aColunas[nX - 1,4] + 10
			endIf

			If lDep
				If !aRegistros[nPos,9]
					If nx == 2
						ImprG(aRegistros[nPos,8]	,"C",,,nCol,.F.,nLin,oFont08)
					Else
						ImprG(aRegistros[nPos,nX]	,"C",,,nCol,.F.,nLin,oFont08)
					EndIf
				ElseIf aRegistros[nPos,9]  .and. nx == 2
					ImprG(aRegistros[nPos,8]	,"C",,,nCol,.F.,nLin,oFont08)
				EndIf
			Else
				ImprG(aRegistros[nPos,nX]	,"C",,,nCol,.F.,nLin,oFont08)
			EndIf
		next nX

		nLin += 50
	Next nPos
	nLin += 20
Return nil

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fCarTpAf  ºAutor  ³Eduardo K.		   º Data ³  11/08/17   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Obtem Tipo de Ausência conforme a tabela RCM               º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ*/

Static Function fCarTpAf(cCodAus)

Local cTipAus := ""
Local aArea   := SR8->(GetArea())

dbSelectArea("RCM")
If DbSeek(xFilial("RCM")+cCodAus)
	If RCM->RCM_TIPOAF == "1"
		cTipAus := "A"
	ElseIf RCM->RCM_TIPOAF == "4"
		cTipAus := "F"
	Endif
Endif

RestArea(aArea)

Return (cTipAus)

/*/{Protheus.doc} fImpConvoc
Imprime as informações das convocações para funcinários intermitentes
@type  Static Function
@author Cícero Alves
@since 23/04/2021
/*/
Static Function fImpConvoc()

	Local aArea 	:= GetArea()
	Local cAliasSV7 := GetNextAlias()
	Local aConvoc	:= {}
	Local cDescFunc	:= ""

	BeginSQL Alias cAliasSV7
		COLUMN V7_DTCON AS DATE
		COLUMN V7_DTINI AS DATE
		COLUMN V7_DTFIM AS DATE
		SELECT V7_CONVC, V7_DTCON, V7_DTINI, V7_DTFIM, V7_FUNC, V7_SALAR
		FROM %Table:SV7% SV7
		WHERE V7_FILIAL = %Exp:SRA->RA_FILIAL% AND
			V7_MAT = %Exp:SRA->RA_MAT% AND
			V7_DTCON BETWEEN %Exp:DToS(dDataIni)% AND %Exp:DToS(dDataFin)% AND
			SV7.%NotDel%
	EndSQL

	// Cabecalho tabela
	If (cAliasSV7)->(!EoF())
		//			"Dt. Convoc", "Inic. Ativ", "Fim Ativ", "Código e-Social", "Salário", "Função"
		Aadd(aConvoc, { STR0151, STR0152, STR0153, STR0154, STR0155, STR0156})
		lImpressao	:= .T.
	Endif

	While (cAliasSV7)->(!EoF())

		cDescFunc := Posicione("SRJ", 1, xFilial("SRJ", SRA->RA_FILIAL) + (cAliasSV7)->V7_FUNC, "RJ_DESC" )

		(cAliasSV7)->(Aadd(aConvoc, {DToC(V7_DTCON), DToC(V7_DTINI), DToC(V7_DTFIM), V7_CONVC, Transform(V7_SALAR, "@E 999,999,999.99"), AllTrim(V7_FUNC) + " - " + cDescFunc }))

		(cAliasSV7)->(dbSkip())

	EndDo

	If nGrafica == 1
		fImpConvG(aConvoc)
	Else
		fImpConvN(aConvoc)
	Endif

	(cAliasSV7)->(dbCloseArea())

	RestArea(aArea)

Return

/*/{Protheus.doc} fImpConvG
Impressão do bloco de convocações para funcionários intermitentes no formato gráfico
@type  Static Function
@author Cícero Alves
@since 23/04/2021
@param aConvoc, Array, Convocações do funcionário
/*/
Static Function fImpConvG(aConvoc)

	Local N     	:= 0
	Local nLinhas	:= 0

	Default aConvoc := {}


	// Testa Quebra de Página
	fTestaQuebra(aConvoc, @nLinhas)

	// Box Detalhe
	fConvocBox(nLinhas)

	For N :=1 To Len(aConvoc)

		If nLin + 100 >= nLinMax

			fFimPag(aConvoc, N, @nLinhas)

			//Box Detalhe
			fConvocBox(nLinhas)

			ImprG(aConvoc[01,01], "C",,, 0065, .F., nLin, oFont08)
			ImprG(aConvoc[01,02], "C",,, 0215, .F., nLin, oFont08)
			ImprG(aConvoc[01,03], "C",,, 0370, .F., nLin, oFont08)
			ImprG(aConvoc[01,04], "C",,, 0830, .F., nLin, oFont08)
			ImprG(aConvoc[01,05], "C",,, 1060, .F., nLin, oFont08)
			ImprG(aConvoc[01,06], "C",,, 1500, .F., nLin, oFont08)

			nLin += 50
		Endif

		ImprG(aConvoc[N,1], "C",,, 0055, .F., nLin, oFont08)
		ImprG(aConvoc[N,2], "C",,, 0210, .F., nLin, oFont08)
		ImprG(aConvoc[N,3], "C",,, 0370, .F., nLin, oFont08)
		ImprG(aConvoc[N,4], "C",,, 0530, .F., nLin, oFont08)
		ImprG(aConvoc[N,5], "C",,, 1030, .F., nLin, oFont08)
		ImprG(aConvoc[N,6], "C",,, 1350, .F., nLin, oFont08)

		nLin += 50

	Next N

	ImprG("", "C",,,,, nLinhas)

Return

/*/{Protheus.doc} fConvocBox
Cria a tabela utilizada na impressão
@type  Static Function
@author Cícero Alves
@since 23/04/2021
/*/
Static Function fConvocBox(nLinhas)

	Local nCol		:= Int(( nColBox - ( Len(STR0157) * 100 / 7) )) / 2
	Local nColFim	:= 130

	oPrint:box(nLin, nColuna, nlinhas, nColBox + nColFim )

	oPrint:Line(nLin + 50  , 050, nLin + 50  , nColBox + nColFim)
	oPrint:Line(nLin + 100 , 050, nLin + 100 , nColBox + nColFim)

	oPrint:Line(nLin + 50,  195, nLinhas,  195)
	oPrint:Line(nLin + 50,  350, nLinhas,  350)
	oPrint:Line(nLin + 50,  505, nLinhas,  505)
	oPrint:Line(nLin + 50, 1000, nLinhas, 1000)
	oPrint:Line(nLin + 50, 1300, nLinhas, 1300)

	oPrint:say(nLin, nCol, STR0157, oFont10n) // Convocações

	nLin += 50

Return

/*/{Protheus.doc} fImpConvN
Impressão do bloco de convocações para funcionários intermitentes no formato zebrado
@type  Static Function
@author Cícero Alves
@since 23/04/2021
@param aConvoc, Array, Convocações do funcionário
/*/
Static Function fImpConvN(aConvoc)

	Local N, M, nDet := 0
	Local aDetalhe	 := {}

	DEFAULT aConvoc := {}

	If li >= 60
		Impr(" ", "P")
	EndIf

	Impr("", "C")

	//-- Box Detalhe
	aAdd(aDetalhe," ------------------------------------------------------------------------------ ")// 1
	aAdd(aDetalhe,"|                                                                              |")// 2
	aAdd(aDetalhe,"|------------------------------------------------------------------------------|")// 3
	aAdd(aDetalhe,"|           |           |                              |                       |")// 4
	aAdd(aDetalhe,"|           |           |                              |                       |")// 5
	aAdd(aDetalhe,"|-----------+-----------+------------------------------+-----------------------|")// 6

	nDet := (78 - Len(STR0015)) / 2
	aDetalhe[2]	:= sTuff(aDetalhe[2], nDet, Len(STR0157), STR0157 ) // Convocações

	aDetalhe[4]	:= Stuff(aDetalhe[4], 02, len(aConvoc[1,1]),  aConvoc[1,1])  // Data da Convocação
	aDetalhe[4]	:= Stuff(aDetalhe[4], 14, len(aConvoc[1,2]),  aConvoc[1,2])  // Inicio da atividade
	aDetalhe[5]	:= Stuff(aDetalhe[5], 14, len(aConvoc[1,3]),  aConvoc[1,3])  // Fim da atividade
	aDetalhe[4]	:= Stuff(aDetalhe[4], 26, len(aConvoc[1,4]),  aConvoc[1,4])  // Cod eSocial
	aDetalhe[5]	:= Stuff(aDetalhe[5], 26, len(aConvoc[1,6]),  aConvoc[1,6])  // Função
	aDetalhe[4]	:= Stuff(aDetalhe[4], 57, len(aConvoc[1,5]),  aConvoc[1,5])  // Salário


	If (LI +  Len(aDetalhe) + Len(aConvoc) + 04 ) >= 60
		Impr("", "P")
	Endif

	For m := 1 to Len(aDetalhe)
		Impr(aDetalhe[m], "C")
	Next m

	For N :=2 To Len(aConvoc)
		Impr("|" + aConvoc[n,1], "C",,, 00, .F. )
		Impr("|" + aConvoc[n,2], "C",,, 12, .F. )
		Impr("|" + aConvoc[n,4], "C",,, 24, .F. )
		Impr("|" + aConvoc[n,5], "C",,, 55, .F. )
		Impr("|"           	   , "C",,, 79, .T. )
		Impr("|"			   , "C",,, 00, .F. )
		Impr("|" + aConvoc[n,3], "C",,, 12, .F. )
		Impr("|" + aConvoc[n,6], "C",,, 24, .F. )
		Impr("|"			   , "C",,, 55, .F. )
		Impr("|"			   , "C",,, 79, .T. )
	Next n

	Impr("", "C")
	Impr(aDetalhe[1], "C")

Return

/*
ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»
ºPrograma  ³fImpCatN  ºAutor  ³Desenv - SSERVICE   º Data ³  27/05/08   º
ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
ºDesc.     ³ Impressao Linhas de detalhe  Modo Normal                   º
ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼*/
Static Function  fImpCatN(aCat)
Local N ,M , nDet
Local aDetalhe	:= {}

If li >= 60
	Impr(" ","P")
Endif
Impr("","C")

//-- Box Detalhe
aAdd(aDetalhe," ------------------------------------------------------------------------------ ")
aAdd(aDetalhe,"|                                                                              |")
aAdd(aDetalhe,"|------------------------------------------------------------------------------|")
aAdd(aDetalhe,"|             |                                                                |")
aAdd(aDetalhe,"|-------------+--------------------------------------------------+-------------|")
             //12345678901234567890123456789012345678901234567890123456789012345678901234567890
             //         10        20        30        40        50        60        70
nDet	:= (78 - len("Alteracao de Categoria") ) /2
aDetalhe[2]	:= stuff(aDetalhe[2],nDet,len(oemtoAnsi("Alteracao de Categoria")) , oEmtoAnsi("Alteracao e Categoria") )
aDetalhe[4]	:= Stuff(aDetalhe[4],02,len(aCat[1,1]),aCat[1,1])
aDetalhe[4]	:= Stuff(aDetalhe[4],17,len(aCat[1,2]),aCat[1,2])

If (li + Len(aDetalhe) + Len(aCat)+ 04  ) >= 60
	Impr("","P")
Endif

For m:= 1 to Len(aDetalhe)
	Impr(aDetalhe[m],"C")
Next m

For N:=2 To Len(aCat)
	Impr("|"+ aCat[n,1],"C",,,00,.F. )
	Impr("|"+ aCat[n,2],"C",,,14,.F. )
	Impr("|","C",,,79 )
Next n
Impr(aDetalhe[1],"C")
Return
