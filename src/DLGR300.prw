/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE 'DLGR300.CH'
#INCLUDE 'FIVEWIN.CH'

//----------------------------------------------------------
/*/{Protheus.doc} DLGR300
Romaneio de Separação        

@author  Felipe Nunes Toledo
@version	P11
@since   18/10/06 - revisão 30/09/14
/*/
//----------------------------------------------------------
User Function DLGR300()
Local oReport

If SuperGetMv("MV_WMSNEW",.F.,.F.)
	Return WMSR300()
EndIf

//-- Interface de impressão
oReport:= ReportDef()
oReport:PrintDialog()

Return 

//----------------------------------------------------------
/*/{Protheus.doc}
Definições do relatório        

@author  Felipe Nunes Toledo
@version	P11
@since   18/10/06 - revisão 30/09/14  
/*/
//----------------------------------------------------------
Static Function ReportDef()
Local oReport
Local oSection1, oSection2, oSection3
Local cTitle    := STR0001 //'Romaneio de Separacao por Carga'
Local cPerg     := "DLR300"
Local cPictQtd  := PesqPict("SDB","DB_QUANT") 

oReport:= TReport():New("DLGR300",cTitle,cPerg, {|oReport| ReportPrint(oReport)},STR0002+STR0003+STR0004) //##'Emite Relatorio de Romaneio de Separacao ordenado por'##'Carga+Sequencia de Carga. Em cada Carga os itens sao '##'ordenados por Pedido+Cliente/Fornecedor+Loja+Item    '

Pergunte(oReport:GetParam(),.F.)

//Seção 1 - Informações Genéricas da Carga
oSection1 := TRSection():New(oReport,STR0034,{"SDB","DA3","DA4","DAK"},/*Ordem*/) //"Cargas"
oSection1:SetLineStyle()
oSection1:SetCols(4)
TRCell():New(oSection1,'DB_CARGA'  ,'SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'DB_SEQCAR' ,'SDB',STR0037   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //'Seq'
TRCell():New(oSection1,'CHEGADA'   ,'SDB',STR0029   ,/*Picture*/,12         ,/*lPixel*/, {|| '[______]' }         		 ) //'Chegada'
TRCell():New(oSection1,'SAIDA'     ,'SDB',STR0030   ,/*Picture*/,12         ,/*lPixel*/, {|| '[______]' }        		    ) //'Saida'
TRCell():New(oSection1,'DA3_DESC'  ,'DA3',STR0038   ,/*Picture*/,27         ,/*lPixel*/,/*{|| code-block de impressao }*/) //'Veiculo'
TRCell():New(oSection1,'DA4_NOME'  ,'DA4',/*Titulo*/,/*Picture*/,28         ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'DAK_PESO'  ,'DAK',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'DAK_VALOR' ,'DAK',STR0039   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //'Valor'
TRCell():New(oSection1,'DAK_DATA'  ,'DAK',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'DAK_HORA'  ,'DAK',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'DB_ENDDES' ,'SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection1:Cell('DA4_NOME' ):SetCellBreak()
oSection1:Cell('DAK_VALOR'):SetCellBreak()

//Seção 2 - Itens da Carga
oSection2 := TRSection():New(oSection1,STR0035,{"SDB","SA1","SA2","DAI"},/*Ordem*/,,,,,,,,,,,5) //Itens da Carga
oSection2:SetLineStyle()
TRCell():New(oSection2,'DB_DOC  '  ,'SDB',STR0040   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //'Pedido'
TRCell():New(oSection2,'DB_CLIFOR' ,'SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,'DB_LOJA'   ,'SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,'A1_NOME'   ,'SA1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,'A2_NOME'   ,'SA2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,'DAI_PESO'  ,'DAI',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oSection2:SetNoFilter({"SA1","SA2","DAI"})

//Seção 3 - Movimentos por Endereço
oSection3 := TRSection():New(oSection2,STR0036,{"SDB","SB1"},/*Ordem*/,,,,,,,,,,,2) //Movimentos por Endereço
TRCell():New(oSection3,'DB_SERIE'  ,'SDB', STR0041  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Item"
TRCell():New(oSection3,'DB_PRODUTO','SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'B1_DESC'   ,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'DB_LOTECTL','SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'DB_NUMLOTE','SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'DB_LOCALIZ','SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,'UNITIZADA' ,'SDB', STR0031  ,cPictQtd   ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //'Unitizada'
TRCell():New(oSection3,'DB_QTSEGUM','SDB', STR0033  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //'2aUM'
TRCell():New(oSection3,'DB_QUANT'  ,'SDB', STR0032  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //'1aUM'
oSection3:SetNoFilter({"SB1"})

Return(oReport)

//----------------------------------------------------------
/*/{Protheus.doc}
Impressão do relatório        

@param   oReport     Objeto Report do relatório

@author  Felipe Nunes Toledo
@version	P11
@since   18/10/06 - revisão 30/09/14  
/*/
//----------------------------------------------------------
Static Function ReportPrint(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local oSection3 := oReport:Section(1):Section(1):Section(1)
Local cQryRel   := GetNextAlias()
Local cCompSec2 := ""
Local cCompSec3 := ""
Local cWhere01  := ""
Local cWhere02  := ""
Local cWhere03  := ""
Local cWhere04  := ""
Local aQtds     := {}

//Inibindo Celulas conforme parametro mv_par09
If mv_par09 == 1 //-- 1aUM
	oSection3:Cell('UNITIZADA' ):Disable()
	oSection3:Cell('DB_QTSEGUM'):DiSable()
ElseIf mv_par09 == 2 //-- 2aUM
	oSection3:Cell('UNITIZADA' ):Disable()
	oSection3:Cell('DB_QUANT'  ):Disable()
ElseIf mv_par09 == 4 //-- Nao Imprime Quantidades
	oSection3:Cell('UNITIZADA' ):Disable()
	oSection3:Cell('DB_QUANT'  ):Disable()
	oSection3:Cell('DB_QTSEGUM'):DiSable()
EndIf

//Transforma parametros Range em expressao SQL
MakeSqlExpr(oReport:GetParam())

cWhere01 := "%'"+CriaVar("DB_ESTORNO",.F.)+"'%"
cWhere02 := "%'"+CriaVar("DB_CARGA"  ,.F.)+"'%"

cWhere03 := "% EXISTS (SELECT 1"                                              +; 
                       " FROM "+RetSqlName('DC5')+" DC5"                       +;
                      " WHERE DC5.DC5_FILIAL  = '"+xFilial('DC5')+"'"          +;
                        " AND DC5.DC5_SERVIC = SDB.DB_SERVIC"                 +;
                        " AND DC5.DC5_TAREFA = SDB.DB_TAREFA"                 +;
                        " AND DC5.DC5_ORDEM  = SDB.DB_ORDTARE"                +;
                        " AND DC5.DC5_FUNEXE IN ('000002','000008','000009')" +;
                        " AND DC5.D_E_L_E_T_ = ' ') %"

cWhere04 := "% (SELECT MIN(DB_ORDATIV)"                                 +;
                " FROM "+RetSqlName("SDB")+" SDBM"                      +;
               " WHERE SDBM.DB_FILIAL  = SDB.DB_FILIAL"                 +;
                  " AND SDBM.DB_PRODUTO = SDB.DB_PRODUTO"               +;
                  " AND SDBM.DB_DOC     = SDB.DB_DOC"                   +;
                  " AND SDBM.DB_SERIE   = SDB.DB_SERIE"                 +;
                  " AND SDBM.DB_CLIFOR  = SDB.DB_CLIFOR"                +;
                  " AND SDBM.DB_LOJA    = SDB.DB_LOJA"                  +;
                  " AND SDBM.DB_SERVIC  = SDB.DB_SERVIC"                +;
                  " AND SDBM.DB_TAREFA  = SDB.DB_TAREFA"                +;
                  " AND SDBM.DB_IDMOVTO = SDB.DB_IDMOVTO"               +;
                  " AND SDBM.DB_ESTORNO = ' '"                          +;
                  " AND SDBM.DB_ATUEST  = 'N'"                          +;
                  " AND SDBM.D_E_L_E_T_ = ' ') %"
	
//Query do relatório 
oSection1:BeginQuery()	                              
 BeginSql Alias cQryRel

SELECT SDB.DB_FILIAL, SDB.DB_CARGA, SDB.DB_SEQCAR, SDB.DB_SERVIC, SDB.DB_TAREFA, SDB.DB_ATIVID, SDB.DB_ESTORNO,
       SDB.DB_ENDDES, SDB.DB_DOC, SDB.DB_CLIFOR, SDB.DB_LOJA, SDB.DB_SERIE, SDB.DB_PRODUTO, SDB.DB_LOTECTL,
       SDB.DB_NUMLOTE, SDB.DB_LOCALIZ, SDB.DB_QUANT, SDB.DB_QTSEGUM, SDB.DB_DATA, SDB.DB_ATUEST, SDB.DB_ORIGEM,
       SDB.DB_ORDTARE, SDB.DB_ORDATIV, SDB.DB_LOCAL, SDB.DB_ESTFIS

FROM %table:SDB% SDB

WHERE SDB.DB_FILIAL = %xFilial:SDB% AND
      SDB.DB_DOC    Between %Exp:mv_par01% AND %Exp:mv_par02% AND
      SDB.DB_CARGA  Between %Exp:mv_par03% AND %Exp:mv_par04% AND
      SDB.DB_SEQCAR Between %Exp:mv_par05% AND %Exp:mv_par06% AND
      SDB.DB_DATA   Between %Exp:mv_par07% AND %Exp:mv_par08% AND
      SDB.DB_ESTORNO = %Exp:cWhere01% AND
      SDB.DB_CARGA  <> %Exp:cWhere02% AND
      SDB.DB_ORDATIV = %Exp:cWhere04% AND
      SDB.DB_ORIGEM IN ('SC9','DBN') AND
      SDB.DB_ATUEST  = 'N' AND
      SDB.DB_QUANT   > 0 AND
      %Exp:cWhere03% AND
      SDB.%NotDel%

ORDER BY SDB.DB_FILIAL, SDB.DB_CARGA, SDB.DB_SEQCAR, SDB.DB_DOC 
		
EndSql 
oSection1:EndQuery()

//Posicionamento das tabelas
TRPosition():New(oSection1,"DAK",1,{|| xFilial("DAK") + (cQryRel)->(DB_CARGA + DB_SEQCAR)          })
TRPosition():New(oSection1,"DA3",1,{|| xFilial("DA3") + DAK->DAK_CAMINH                            })
TRPosition():New(oSection1,"DA4",1,{|| xFilial("DA4") + DAK->DAK_MOTORI                            })
TRPosition():New(oSection1,"DAI",4,{|| xFilial("DAI") + (cQryRel)->(DB_DOC + DB_CARGA + DB_SEQCAR) })
TRPosition():New(oSection1,"SB1",1,{|| xFilial("SB1") + (cQryRel)->DB_PRODUTO                      })
TRPosition():New(oSection2,"SA1",1,{|| xFilial("SA1") + (cQryRel)->(DB_CLIFOR+DB_LOJA)             })
TRPosition():New(oSection2,"SA2",1,{|| xFilial("SA2") + (cQryRel)->(DB_CLIFOR+DB_LOJA)             })
TRPosition():New(oSection2,"SC5",1,{|| xFilial("SC5") + (cQryRel)->DB_DOC                          })

oSection2:SetParentQuery()
oSection3:SetParentQuery()

//Fluxo de Impressao do Relatorio
oReport:SetMeter( SDB->(LastRec()) )

While !oReport:Cancel() .And. !(cQryRel)->(Eof())
	oSection1:Init()
	//Impressão da seção 1
	oSection1:PrintLine()
	oReport:ThinLine()
	
	cCompSec2 := (cQryRel)->(DB_FILIAL + DB_CARGA + DB_SEQCAR)
	While !oReport:Cancel() .And. !(cQryRel)->(Eof()) .And. (cQryRel)->(DB_FILIAL + DB_CARGA + DB_SEQCAR) == cCompSec2
		
		oSection2:Init()
		 
		//Dependendo do tipo do pedido de venda, apresenta o nome do cliente ou fornecedor
		Iif(SC5->C5_TIPO $ 'NCIPSTO',oSection2:Cell('A2_NOME'):Disable(),oSection2:Cell('A1_NOME'):Disable())

		//Impressão da seção 2
		oSection2:PrintLine()
		
		//Dependendo do tipo do pedido de venda, apresenta o nome do cliente ou fornecedor
		Iif(SC5->C5_TIPO $ 'NCIPSTO',oSection2:Cell('A2_NOME'):Enable(),oSection2:Cell('A1_NOME'):Enable())
		
		oSection3:Init()
		
		cCompSec3 := (cQryRel)->(DB_FILIAL + DB_CARGA + DB_SEQCAR + DB_DOC)
		While !oReport:Cancel() .And. (cQryRel)->(DB_FILIAL+DB_CARGA+DB_SEQCAR+DB_DOC) == cCompSec3
			
			oReport:IncMeter()
			
			//Calcula as quantidades em unitizador, 2aUM e 1aUM e preenche as células correspondentes
			aQtds := W300Qtd((cQryRel)->DB_PRODUTO,(cQryRel)->DB_LOCAL,(cQryRel)->DB_ESTFIS,(cQryRel)->DB_QUANT)
			oSection3:Cell('UNITIZADA' ):SetValue(aQtds[1]) 
			oSection3:Cell('DB_QTSEGUM'):SetValue(aQtds[2])
			oSection3:Cell('DB_QUANT'  ):SetValue(aQtds[3])

			//Impressão da seção 3
			oSection3:PrintLine()
			
			(cQryRel)->(DbSkip())
		EndDo
		
		oSection3:Finish()
		oSection2:Finish()
		oReport:SkipLine()
		
	EndDo
	
	oSection1:Finish()
	
	If MV_PAR10 == 1
		oReport:EndPage()
	EndIf
EndDo

(cQryRel)->(DbCloseArea()) 
Return Nil

//----------------------------------------------------------
/*/{Protheus.doc}
Calcula a quantidade de produtos em unitizadores, 2a unidade
de medida e 1a unidade de medida            

@param   cProduto    Código do produto
@param   cLocal      Armazém origem do produto
@param   cEstFis     Estrutura Física origem do produto
@param   nQuant      Quantidade da movimentação

@author  Guilherme Alexandre Metzger
@version	P11
@since   30/09/14
@return  aRet        Array com três posições, contendo as quantidades em unitizador, 
                     2a unidade de medida e 1a unidade de medida, respectivamente.
/*/
//----------------------------------------------------------
Static Function W300Qtd(cProduto, cLocal, cEstFis, nQuant)
Local aAreaAnt  := GetArea()
Local cAliasQry := GetNextAlias()
Local cQuery    := ''
Local aRet      := {}
Local QtdUni    := 0
Local Qtd2UM    := 0
Local Qtd1UM    := 0

cQuery := "SELECT (DC2_LASTRO * DC2_CAMADA) AS NORMA, B5_UMIND"
cQuery +=  " FROM "+RetSqlName('DC2')+" DC2, "+RetSqlName('DC3')+" DC3, "+RetSqlName('SB5')+" SB5"
cQuery += " WHERE DC2.DC2_FILIAL = '"+xFilial('DC2')+"'"
cQuery +=   " AND DC3.DC3_FILIAL = '"+xFilial('DC3')+"'"
cQuery +=   " AND SB5.B5_FILIAL  = '"+xFilial('SB5')+"'"
cQuery +=   " AND DC3.DC3_LOCAL  = '"+cLocal+"'"
cQuery +=   " AND DC3.DC3_TPESTR = '"+cEstFis+"'"
cQuery +=   " AND DC3.DC3_CODPRO = '"+cProduto+"'"
cQuery +=   " AND DC2.DC2_CODNOR = DC3.DC3_CODNOR"
cQuery +=   " AND SB5.B5_COD     = DC3.DC3_CODPRO"
cQuery +=   " AND DC2.D_E_L_E_T_ = ' '"
cQuery +=   " AND DC3.D_E_L_E_T_ = ' '"
cQuery +=   " AND SB5.D_E_L_E_T_ = ' '"
cQuery := ChangeQuery(cQuery)
DbUseArea(.T.,'TOPCONN',TcGenQry(,,cQuery),cAliasQry,.T.,.F.)

If (cAliasQry)->(!Eof())
	QtdUni := Int(nQuant / (cAliasQry)->NORMA)      
	nQuant -= (QtdUni * (cAliasQry)->NORMA)         
	Qtd2UM := Int(ConvUm(cProduto,nQuant,0,2))      
	Qtd1UM := nQuant - ConvUm(cProduto,0,Qtd2UM,1)  
	aRet   := {QtdUni, Qtd2UM, Qtd1UM}
Else
	aRet   := {0, 0, 0}
EndIf

(cAliasQry)->(DbCloseArea())

RestArea(aAreaAnt)
Return aRet 