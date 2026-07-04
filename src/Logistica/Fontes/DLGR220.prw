/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "DLGR220.ch"
#Include "Protheus.ch"                                                      

//----------------------------------------------------------
/*/{Protheus.doc} DLGR220
Relação de operações executadas por um funcionário          

@author  Flavio Luiz Vicco
@version	P11
@since   17/10/06 - revisão 18/09/14
/*/
//----------------------------------------------------------
User Function DLGR220()
Local oReport

If SuperGetMv("MV_WMSNEW",.F.,.F.)
	Return WMSR220()
EndIf

//Interface de Impressão
oReport:= ReportDef()
oReport:PrintDialog()

Return( Nil )

//----------------------------------------------------------
/*/{Protheus.doc}
Definições do Relatório            

@author  Flavio Luiz Vicco
@version	P11
@since   17/10/06 - revisão 18/09/14
@return  Objeto do relatório
/*/
//----------------------------------------------------------
Static Function ReportDef()
Local oReport, oSection1, oSection2, oSection3, oBreak1
Local cTitle     := OemToAnsi(STR0001) //"Mapa de Separacao"
Local cPictQtd   := PesqPict("SDB","DB_QUANT")
Local cAliasNew  := GetNextAlias()
Local cCondWhile := ""

//Criacao do componente de impressao 
oReport := TReport():New("DLGR220",cTitle,"DLR220",{|oReport| ReportPrint(oReport,cAliasNew,cCondWhile)},STR0001) //"Mapa de Separacao"

//Verifica os parâmetros selecionados via Pergunte
Pergunte(oReport:GetParam(),.F.)

//Seção 1 - Movimentos por endereco - Estrutura
oSection1:= TRSection():New(oReport,STR0019+' - '+STR0008,{"SDB"}) //Movimentos por endereco - Estrutura
TRCell():New(oSection1,"DB_ESTFIS" ,"SDB", 'Estrutura'  ,/*Picture*/, 30        ,/*lPixel*/,/*{|| code-block de impressao }*/) //Estrutura 
TRCell():New(oSection1,"DC8_DESEST","DC8",/*Titulo*/    ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"DB_CARGA"  ,"SDB",/*Titulo*/    ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New(oSection1,"DB_DOC"    ,"SDB", 'Pedido'     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //Pedido 
oSection1:SetLineStyle()

//Seção 2 - Movimentos por endereco - Endereco
oSection2:= TRSection():New(oSection1,STR0019+' - '+STR0020,{"SDB","SB1"},,,,,,,,,,,,2) //Movimentos por endereco - Endereco
TRCell():New(oSection2,"DB_LOCAL"  ,"SDB"    ,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New(oSection2,"DB_LOCALIZ","SDB"    ,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New(oSection2,"DB_PRODUTO","SDB"    ,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New(oSection2,"B1_DESC"   ,"SB1"    ,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New(oSection2,"DB_LOTECTL","SDB"    ,/*Titulo*/,/*Picture*/,TamSX3("DB_LOTECTL")[1]+2,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New(oSection2,"DB_NUMLOTE","SDB"    ,/*Titulo*/,/*Picture*/,TamSX3("DB_NUMLOTE")[1]+2,/*lPixel*/,/*{|| code-block de impressao }*/) 
TRCell():New(oSection2,"NUNI"      ,/*Alias*/, STR0026  , cPictQtd  ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Unitizador"
TRCell():New(oSection2,"LACUNA4"   ,/*Alias*/, STR0026  ,/*Picture*/, 12        ,/*lPixel*/,{|| "[__________]"            }  )  //"Unitizador"
TRCell():New(oSection2,"NCAIXAFC"  ,/*Alias*/, STR0023  , cPictQtd  ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Segunda UM"
TRCell():New(oSection2,"LACUNA1"   ,/*Alias*/, STR0023  ,/*Picture*/, 12        ,/*lPixel*/,{|| "[__________]"            }  )  //"Segunda UM"
TRCell():New(oSection2,"N2UM"      ,/*Alias*/, STR0027  , cPictQtd  ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"2a. U.M."
TRCell():New(oSection2,"LACUNA5"   ,/*Alias*/, STR0027  ,/*Picture*/, 12        ,/*lPixel*/,{|| "[__________]"            }  )  //"2a. U.M."
TRCell():New(oSection2,"B1_SEGUM"  ,"SB1"    ,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  
TRCell():New(oSection2,"NUNIDADE"  ,/*Alias*/, STR0024  , cPictQtd  ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Unidades"
TRCell():New(oSection2,"LACUNA2"   ,/*Alias*/, STR0024  ,/*Picture*/, 12        ,/*lPixel*/,{|| "[__________]"            }  )  //"Unidades"
TRCell():New(oSection2,"N1UM"      ,/*Alias*/, STR0028  , cPictQtd  ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  //"1a. U.M."
TRCell():New(oSection2,"LACUNA6"   ,/*Alias*/, STR0028  ,/*Picture*/, 12        ,/*lPixel*/,{|| "[__________]"            }  )  //"1a. U.M."
TRCell():New(oSection2,"B1_UM"     ,"SB1"    ,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  
TRCell():New(oSection2,"LACUNA3"   ,/*Alias*/, STR0025  ,/*Picture*/, 18        ,/*lPixel*/,{|| "__________________"      }  ) //"Anormalidades"

//Seção 3 - Movimentos por endereco - Recurso Humano
oSection3:= TRSection():New(oSection1,STR0019+' - '+STR0021,{"SDB"},{'1'}) //Movimentos por endereco - Recurso Humano
TRCell():New(oSection3,"SEPARADOR", "",STR0013,,55,,{||" _______________________   ___:___   ___:___"}) //"Separador :"
TRCell():New(oSection3,"CONFERENTE","",STR0014,,55,,{||" _______________________   ___:___   ___:___"}) //"Conferente :"
oSection3:SetLineStyle()
oSection3:SetCharSeparator("")

//Esconde o título da 1a e 2a UM
oSection2:Cell('B1_UM'   ):HideHeader()
oSection2:Cell('B1_SEGUM'):HideHeader()

//Posicionamento das tabelas secundárias na impressão do relatório
TRPosition():New(oSection2,"SB1",1,{|| xFilial("SB1")+(cAliasNew)->DB_PRODUTO })
TRPosition():New(oSection2,"SB5",1,{|| xFilial("SB5")+(cAliasNew)->DB_PRODUTO })
TRPosition():New(oSection2,"SBE",1,{|| xFilial("SBE")+(cAliasNew)->DB_LOCAL+(cAliasNew)->DB_LOCALIZ } )
TRPosition():New(oSection1,"DC8",1,{|| xFilial("DC8")+(cAliasNew)->DB_ESTFIS  })

//Define que a seção filha utiliza a query da seção pai na impressão da seção
oSection2:SetParentQuery()
oSection3:SetParentQuery()

Return( oReport )

//----------------------------------------------------------
/*/{Protheus.doc}
Relatório de monitoramento de serviços             

@param   oReport     Objeto Report do relatório
@param   cAliasNew   Alias que será utilizado no Embedded SQL

@author  Flavio Luiz Vicco
@version	P11
@since   17/10/06 - revisão 18/09/14
/*/
//----------------------------------------------------------
Static Function ReportPrint(oReport,cAliasNew)
Local oSection1  := oReport:Section(1)
Local oSection2  := oReport:Section(1):Section(1)
Local oSection3  := oReport:Section(1):Section(2)
Local lWmsACar   := (SuperGetMV('MV_WMSACAR', .F., 'S')=='S')
Local cQuery     := ""
Local cChave     := ""
Local cValoWhile := ""
Local nCaixaFc   := 0
Local nUnidade   := 0
Local nUni       := 0
Local n1UM       := 0
Local n2UM       := 0
Local aQtdUni    := {}
Local cCodCFG    := ""
Local cPicCFG    := ""

//Desabilita células conforme parâmetros do pergunte
If	mv_par11 == 1
	oSection1:Cell("DB_CARGA"):Disable()
Else
	If	lWmsACar
		oSection1:Cell("DB_DOC"):Disable()
	EndIf
EndIf
If	mv_par12 == 2
	oSection2:Cell("DB_LOTECTL"):Disable()
	oSection2:Cell("DB_NUMLOTE"):Disable()
EndIf
If	mv_par15 == 2 //Oculta Quantidades ? Nao
	oSection2:Cell("LACUNA1"):Disable()
	oSection2:Cell("LACUNA2"):Disable()
Else
	oSection2:Cell("NCAIXAFC"):Disable()
	oSection2:Cell("NUNIDADE"):Disable()
EndIf
If	mv_par13 == 1 //Imprimir U.M.I. ? Sim
	oSection2:Cell("LACUNA1" ):Disable()
	oSection2:Cell("LACUNA2" ):Disable()
	oSection2:Cell("NCAIXAFC"):Disable()
	oSection2:Cell("NUNIDADE"):Disable()
	If	mv_par15 == 1 //Oculta Quantidades ? Sim
		oSection2:Cell("NUNI"):Disable()
		oSection2:Cell("N1UM"):Disable()
		oSection2:Cell("N2UM"):Disable()
	Else
		oSection2:Cell("LACUNA4"):Disable()
		oSection2:Cell("LACUNA5"):Disable()
		oSection2:Cell("LACUNA6"):Disable()
	EndIf
Else
	oSection2:Cell("NUNI"   ):Disable()
	oSection2:Cell("N1UM"   ):Disable()
	oSection2:Cell("N2UM"   ):Disable()
	oSection2:Cell("LACUNA4"):Disable()
	oSection2:Cell("LACUNA5"):Disable()
	oSection2:Cell("LACUNA6"):Disable()
EndIf

//Query do relatório da secao 1 
If	mv_par11 == 2
	cQuery := " AND DB_CARGA<>'"+Space(Len(SDB->DB_CARGA))+"'"
EndIf
cQuery := "%"+cQuery+"%"
If	mv_par14 == 1
	If	mv_par11 == 1
		cChave := "DB_ESTFIS,DB_DOC,DB_PRIORI,DB_LOCALIZ,DB_PRODUTO,DB_LOCAL"
	Else
		cChave := "DB_ESTFIS,DB_CARGA,DB_UNITIZ,DB_DOC,DB_PRIORI,DB_LOCALIZ,DB_PRODUTO,DB_LOCAL"
	EndIf
Else
	If	mv_par11 == 1
		cChave := "DB_DOC,DB_ESTFIS,DB_PRIORI,DB_LOCALIZ,DB_PRODUTO,DB_LOCAL"
	Else
		cChave := "DB_CARGA,DB_UNITIZ,DB_DOC,DB_ESTFIS,DB_PRIORI,DB_LOCALIZ,DB_PRODUTO,DB_LOCAL"
	EndIf
EndIf
cChave := "%"+cChave+"%"

oSection1:BeginQuery()	
BeginSql Alias cAliasNew
   SELECT SDB.DB_FILIAL,SDB.DB_LOCAL,SDB.DB_LOCALIZ,SDB.DB_DOC,SDB.DB_QUANT,SDB.DB_CARGA, 
   		 SDB.DB_SERVIC,SDB.DB_TAREFA,SDB.DB_ATIVID,SDB.DB_TM,SDB.DB_ESTORNO,SDB.DB_ATUEST, 
   		 SDB.DB_PRODUTO,SDB.DB_LOTECTL,SDB.DB_NUMLOTE,SDB.DB_ESTFIS,SDB.DB_UNITIZ
   FROM %table:SDB% SDB
   WHERE DB_FILIAL   = %xFilial:SDB%
   AND   DB_TM     >  '500'
   AND   DB_ORIGEM =  'SC9'
   AND   DB_SERVIC >= %Exp:mv_par01%
   AND   DB_SERVIC <= %Exp:mv_par02%
   AND   DB_TAREFA >= %Exp:mv_par03%
   AND   DB_TAREFA <= %Exp:mv_par04%
   AND   DB_ATIVID >= %Exp:mv_par05%
   AND   DB_ATIVID <= %Exp:mv_par06%
   AND   DB_DOC    >= %Exp:mv_par07%
   AND   DB_DOC    <= %Exp:mv_par08%
   AND   DB_CARGA  >= %Exp:mv_par09%
   AND   DB_CARGA  <= %Exp:mv_par10%
   AND   DB_ESTORNO = ' '
   AND   DB_ATUEST  = 'N'
   AND   SDB.%NotDel%
   %Exp:cQuery%
   ORDER BY %Exp:cChave%
EndSql 

//EndQuery (Classe TRSection) - Prepara o relatório para executar o Embedded SQL
oSection1:EndQuery(/*Array com os parametros do tipo Range*/)

If	mv_par11 == 1
	cCondWhile := If(mv_par14==1,"DB_ESTFIS+","")+"DB_DOC"
Else
	cCondWhile := If(mv_par14==1,"DB_ESTFIS+","")+"DB_CARGA+DB_UNITIZ"+If(lWmsACar,'','+DB_DOC')
EndIf

oReport:SetMeter((cAliasNew)->(LastRec()))
While !oReport:Cancel() .And. !(cAliasNew)->(Eof())
   oSection1:Init()
   oSection1:PrintLine()
   oSection2:Init()
   cValoWhile := &cCondWhile
   While !oReport:Cancel() .And. !(cAliasNew)->(Eof()) .And. cValoWhile == &cCondWhile
      If	mv_par15 == 2
   		If	mv_par13 == 1  //Imprimir U.M.I.    ? Sim
   			n1UM := n2UM := nUni := 0
   			aQtdUni := W220Qtd((cAliasNew)->DB_PRODUTO,(cAliasNew)->DB_LOCAL,(cAliasNew)->DB_ESTFIS,(cAliasNew)->DB_QUANT)
   			nUni   := aQtdUni[1] 
   			If	aQtdUni[2] > 0 .Or. aQtdUni[3] > 0  // Se a Quantidade de Unitizadores for diferente de um numero inteiro
   				n2UM := aQtdUni[2]
   				n1UM := aQtdUni[3]
   			EndIf 
   			oSection2:Cell("NUNI"):SetValue(nUni)
   			oSection2:Cell("N2UM"):SetValue(n2UM)
   			oSection2:Cell("N1UM"):SetValue(n1UM)
   		Else
   			If	SB5->B5_UMIND == "1"
   				nCaixaFc := 0
   				nUnidade := (cAliasNew)->DB_QUANT
   			Else
   				If	!Empty(SB1->B1_CONV)
   					nCaixaFc := Int(ConvUM((cALiasNew)->DB_PRODUTO,(cALiasNew)->DB_QUANT,0,2))
   					nUnidade := (cALiasNew)->DB_QUANT - ConvUM((cALiasNew)->DB_PRODUTO,0,nCaixaFc,1)
   				Else
   					nCaixaFc := (cALiasNew)->DB_QUANT
   					nUnidade := 0
   				EndIf
   			EndIf
   			oSection2:Cell("NCAIXAFC"):SetValue(nCaixaFc)
   			oSection2:Cell("NUNIDADE"):SetValue(nUnidade)
   		EndIf
   	EndIf 
   	If	cCodCFG <> SBE->BE_CODCFG //Verifica se o codigo mudou
   		cCodCFG := SBE->BE_CODCFG //Atualiza flag
   		cPicCFG := DLXPicEnd(SBE->BE_CODCFG) //Atualiza Picture
   	EndIf
   	oSection2:Cell("DB_LOCALIZ"):SetPicture(cPicCFG)
   	oSection2:PrintLine()
      oReport:IncMeter()
      (cAliasNew)->(DbSkip())
   EndDo
   oSection2:Finish()
   oSection3:Init()
   oSection3:PrintLine()
   oSection3:Finish()
   oSection1:Finish()
   oReport:EndPage()
   
EndDo 

Return( Nil )

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
@since   18/09/14
@return  aRet        Array com três posições, contendo as quantidades em unitizador, 
                     2a unidade de medida e 1a unidade de medida, respectivamente.
/*/
//----------------------------------------------------------
Static Function W220Qtd(cProduto, cLocal, cEstFis, nQuant)
Local aAreaAnt  := GetArea()
Local cAliasQry := GetNextAlias()
Local cQuery    := ''
Local aRet      := {}
Local QtdUni := 0
Local Qtd2UM := 0
Local Qtd1UM := 0

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
EndIf

(cAliasQry)->(DbCloseArea())

RestArea(aAreaAnt)
Return aRet 
