/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "LOJR072.CH"
#DEFINE LJ_MAXNUM	19
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ LojR072  ³ Autor ³ Lucas                 ³ Data ³ 07.06.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Mapa de Vendas                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_LojR072(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nao tem                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³Uso       ³ SIGALOJA                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LojR072()
LOCAL cDesc1 := STR0001  // Imprime a rela‡„o das vendas considerando os parametros solicitados :
LOCAL cDesc2 := STR0002  // Por Data de Venda, por Vendedor, por Produto, por Tipo, por Grupo de
LOCAL cDesc3 := STR0003  // Produtos , por Clientes e por Caixa .

PRIVATE wnrel
PRIVATE tamanho:="G"
PRIVATE cString:="SL1"
PRIVATE titulo := STR0006  //Relacao de Vendas
PRIVATE nLastKey := 0

// Zebrado / Administracao
PRIVATE aReturn := { STR0004, 1, STR0005, 1, 2, 1, "",1 }
PRIVATE nomeprog:="LOJR072"
PRIVATE cPerg := "LJR072"

Pergunte( cPerg, .F. )

wnrel := "LOJR072"

// Por Data  / Por Vendedor / Por Produto / Por Tipo
// Por Grupo / Por Cliente  / Por Caixa
aOrd	:= {STR0007,STR0008,STR0009,STR0010,STR0011,STR0012,STR0013}
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho,,.F.)

If nLastKey != 27
   SetDefault(aReturn,cString)
   
   If nLastKey != 27   
      RptStatus( {|lEnd| U_LJR072Imp( @lEnd, wnRel, cString ) }, Titulo )
   EndIf
   
EndIf

Return( Nil )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ LJR072Imp ³ Autor ³ Lucas                ³ Data ³ 07.06.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Mapa de Vendas                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_LojR072(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nao tem                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³Uso       ³ SIGALOJA                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LJR072Imp( lEnd, wnRel, cString)
LOCAL Cbtxt,CbCont,cabec1
LOCAL cabec2    		:= Replicate(" ", 220 )
LOCAL cCond1
LOCAL cCabec1,cCabec2,cCabec3,cCabec4,cCabec5,cCabec6,cCabec7
LOCAL aCampos   		:= {}
LOCAL nOrdem    		:= 0
Local nContador 		:= 0
Local cFilAtu

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para acumuladores de venda           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nQuant    		:= 0
Local nDescItem 		:= 0
Local nDescProp 		:= 0
Local nAcresItem		:= 0
Local nValorRec			:= 0
Local nValIcms			:= 0

Local nFilQuant    		:= 0
Local nFilDescItem 		:= 0
Local nFilDescProp 		:= 0
Local nFilAcresItem		:= 0
Local nFilValorRec 		:= 0
Local nFilValIcms  		:= 0

Local nGerQuant    		:= 0
Local nGerDescItem 		:= 0
Local nGerDescProp 		:= 0
Local nGerAcresItem		:= 0
Local nGerValorRec 		:= 0
Local nGerValIcms  		:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para acumuladores de devolucao       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nDQuant    		:= 0
Local nDDescItem 		:= 0
Local nDDescProp 		:= 0
Local nDAcresItem		:= 0
Local nDValorRec 		:= 0
Local nDValIcms  		:= 0

Local nDFilQuant		:= 0
Local nDFilDescItem 	:= 0
Local nDFilDescProp 	:= 0
Local nDFilAcresItem	:= 0
Local nDFilValorRec 	:= 0
Local nDFilValIcms  	:= 0

Local nDGerQuant    	:= 0
Local nDGerDescItem 	:= 0
Local nDGerDescProp 	:= 0
Local nDGerAcresItem	:= 0
Local nDGerValorRec 	:= 0
Local nDGerValIcms  	:= 0

Local aTesImpInf		:= {}
Local nImposto      	:= 0
Local nI            	:= 0
Local lIncluido   		:= .F.
Local lDiscrim    		:= .F.
Local nDecs 			:= MsDecimais(1)
Local nMoeda        	:= 1
#IFNDEF TOP
Local cCampo        	:= ""
Local cFilTmp
Local lFoundSLP     	:= .F.
Local lLayCanc      	:= .F.
Local nMoedaBco     	:= 1
#ENDIF
Local oTempTable		:= Nil //Objeto tabela temporaria

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Cbtxt 	:= ""
cbcont	:= 0
li 		:= 80
m_pag 	:= 1

cCabec1 := STR0014 // Data 	N.Fisc Ser Vend.	Nome Vend.	Client Nome Cliente		 Grupo Tipo Produto			   Descricao		  UN		Quantidade	  Valor Unitario	  Desconto Item	 Desc.Proproc. 	Valor Recebido 		Valor Icms CP. Fi OL
cCabec2 := STR0015 // Vended Nome Vend.	  Data	 N.Fisc Ser Client Nome Cliente		 Grupo Tipo Produto			 Descricao		  UN		Quantidade	  Valor Unitario	  Desconto Item	 Desc.Proproc. 	Valor Recebido 		Valor Icms CP. Fi OL
cCabec3 := STR0016 // Cod. Produto	  Descricao 			Data	  NF		Ser Vended Nome Vend.  Client Nome Cliente		Grupo Tipo UN		Quantidade	  Valor Unitario	  Desconto Item	 Desc.Proproc. 	Valor Recebido 		Valor Icms CP. Fi OL
cCabec4 := STR0017 // Tipo Cod. Produto	 Descricao			  Data	 NF	  Ser Vended Nome Vend.  Client Nome Cliente 	  Grupo UN		Quantidade	  Valor Unitario	  Desconto Item	 Desc.Proproc. 	Valor Recebido 		Valor Icms CP. Fi OL
cCabec5 := STR0018 // Grupo	 Data 	N.Fis  Ser Vended Nome Vend.	Client Nome Cliente		 Tipo Produto			 Descricao		  UN		Quantidade	  Valor Unitario	  Desconto Item	 Desc.Proproc. 	Valor Recebido 		Valor Icms CP. Fi OL
cCabec6 := STR0019 // Client Nome Cliente 	  Tipo	 Data 	NF 	 Ser Vended Nome Vend.	Grupo Produto			 Descricao		  UN		Quantidade	  Valor Unitario	  Desconto Item	 Desc.Proproc. 	Valor Recebido 		Valor Icms CP. Fi OL
cCabec7 := STR0020 // Caixa  Nome Cliente 	  Tipo	 Data 	NF 	 Ser Vended Nome Vend.	Grupo Produto			 Descricao		  UN		Quantidade	  Valor Unitario	  Desconto Item	 Desc.Proproc. 	Valor Recebido 		Valor Icms CP. Fi OL

nOrdem := aReturn[8]

If nOrdem == 1
   cCond1 := "FILIAL+DTOS(DTEMI)+STATUS"
   titulo += STR0021 + " ( " + DTOC(Mv_Par01) + " - " + DTOC(Mv_Par02) + " )"//  - Por Data ( XX/XX/XXXX - XX/XX/XXXX )
   cabec1 := cCabec1
Elseif nOrdem == 2
   cCond1 := "FILIAL+STATUS+VENDED"
   titulo += STR0022 + " ( " + Mv_Par03 + " - " + Mv_Par04 + " )"	 //  - Por Vendedor ( XXXXXX - XXXXXX )
   cabec1 := cCabec2
Elseif nOrdem == 3
   cCond1 := "FILIAL+STATUS+PROD"
   titulo += STR0023 + " ( " + Mv_Par05 + " - " + Mv_Par06 + " )"	 //  - Por Produto ( XXXXXXXXXXXXXXX - XXXXXXXXXXXXXXX )
   cabec1 := cCabec3
Elseif nOrdem == 4
   cCond1 := "FILIAL+TIPO+STATUS"
   titulo += STR0024 + " ( " + Mv_Par07 + " - " + Mv_Par08 + " )"	 //  - Por Tipo ( XX - XX )
   cabec1 := cCabec4
Elseif nOrdem == 5
   cCond1 := "FILIAL+GRUPO+STATUS"
   titulo += STR0025 + " ( " + Mv_Par09 + " - " + Mv_Par10 + " )"	 //  - Por Grupo ( XXXX - XXXX )
   cabec1 := cCabec5
Elseif nOrdem == 6
   cCond1 := "FILIAL+CLIENTE+STATUS"
   titulo += STR0026 + " ( " + Mv_Par11 + " - " + Mv_Par12 + " )"	 //  - Por Cliente ( XXXXXX - XXXXXX)
   cabec1 := cCabec6
Elseif nOrdem == 7
   cCond1 := "FILIAL+CAIXA+STATUS"
   titulo += STR0027 + " ( " + Mv_Par13 + " - " + Mv_Par14 + " )"	 //  - Por Caixa ( XXX - XXX )
   cabec1 := cCabec7
EndIf

AADD(aCampos,{"LOJA"      ,"C",TamSX3("L1_LOJA")[1]   ,TamSX3("L1_LOJA")[2]})
AADD(aCampos,{"DTEMI"     ,"D",TamSX3("L1_EMISNF")[1] ,TamSX3("L1_EMISNF")[2]})
AADD(aCampos,{"N_FISCAL"  ,"C",TamSX3("L1_DOC")[1]    ,TamSX3("L1_DOC")[2]})
AADD(aCampos,{"ITEM"      ,"C",TamSX3("L2_ITEM")[1]    ,TamSX3("L2_ITEM")[2]})
AADD(aCampos,{"SERIE"     ,"C",TamSX3("L1_SERIE")[1]  ,TamSX3("L1_SERIE")[2]})
AADD(aCampos,{"VENDED"	  ,"C",TamSX3("L1_VEND")[1]   ,TamSX3("L1_VEND")[2]})
AADD(aCampos,{"NOME"	  ,"C",TamSX3("A3_NREDUZ")[1] ,TamSX3("A3_NREDUZ")[2]})
AADD(aCampos,{"CLIENTE"   ,"C",TamSX3("L1_CLIENTE")[1],TamSX3("L1_CLIENTE")[2]})
AADD(aCampos,{"NOM_CLI"	  ,"C",TamSX3("A1_NREDUZ")[1] ,TamSX3("A1_NREDUZ")[2]})
AADD(aCampos,{"TIPO"	  ,"C",TamSX3("B1_TIPO")[1]	  ,TamSX3("B1_TIPO")[2]})
AADD(aCampos,{"PROD"	  ,"C",TamSX3("B1_COD")[1]    ,TamSX3("B1_COD")[2]})
AADD(aCampos,{"DESCRI"	  ,"C",TamSX3("B1_DESC")[1]   ,TamSX3("B1_DESC")[2]})
AADD(aCampos,{"QUANT"	  ,"N",TamSX3("L2_QUANT")[1]  ,TamSX3("L2_QUANT")[2]})
AADD(aCampos,{"UNIDA"	  ,"C",TamSX3("L2_UM")[1] 	  ,TamSX3("L2_UM")[2]})
AADD(aCampos,{"UNIT"	  ,"N",TamSX3("L2_VRUNIT")[1] ,TamSX3("L2_VRUNIT")[2]})
AADD(aCampos,{"DESCON"	  ,"N",TamSX3("L2_VALDESC")[1],TamSX3("L2_VALDESC")[2]})
AADD(aCampos,{"DESCTOT"	  ,"N",TamSX3("L2_DESCPRO")[1],TamSX3("L2_DESCPRO")[2]})
AADD(aCampos,{"TOTAL" 	  ,"N",TamSX3("L2_VLRITEM")[1],TamSX3("L2_VLRITEM")[2]})
AADD(aCampos,{"ICMS" 	  ,"N",TamSX3("L2_VALICM")[1] ,TamSX3("L2_VALICM")[2]})
AADD(aCampos,{"GRUPO"	  ,"C",TamSX3("B1_GRUPO")[1]  ,TamSX3("B1_GRUPO")[2]})
AADD(aCampos,{"COND"	  ,"C",TamSX3("L1_CONDPG")[1] ,TamSX3("L1_CONDPG")[2]})
AADD(aCampos,{"CAIXA" 	  ,"C",TamSX3("L1_OPERADO")[1],TamSX3("L1_OPERADO")[2]})
AADD(aCampos,{"FILIAL"    ,"C",2,0})
AADD(aCampos,{"MOEDA"     ,"N",2,0})
AADD(aCampos,{"STATUS"    ,"C",TamSX3("L2_STATUS")[1] ,TamSX3("L2_STATUS")[2]})
If cPaisLoc != "BRA"
	AADD(aCampos,{"TES" ,"C",3,0})
	AADD(aCampos,{"IMPOSTOS","N",TamSX3("L2_VALIMP1")[1] ,TamSX3("L2_VALIMP1")[2]})
	AADD(aCampos,{"TIPOIMP", "C",3,0})
EndIf
AADD(aCampos,{"ACRES"     ,"N",TamSX3("L2_VRUNIT")[1],TamSX3("L2_VRUNIT")[2]})
AADD(aCampos,{"OL"        ,"C",1,0})
AADD(aCampos,{"TIPODOC"   ,"C",3,0})

aStruTRB := AClone(aCampos)
			
cIndexKey := cCond1
//Cria tabela temporaria
oTempTable := LjCrTmpTbl("TRB", aCampos, {cIndexKey})

#IFDEF TOP
	If TcSrvType() != "AS/400"
		lQuery   := .T.
        
		cQuery := "SELECT "
		cQuery += "L1_LOJA AS LOJA,"
		cQuery += "L1_EMISNF AS DTEMI,"
		cQuery += "L1_DOC AS N_FISCAL,"
		cQuery += "L2_ITEM AS ITEM,"
		cQuery += "L1_SERIE AS SERIE,"
		cQuery += "L1_VEND AS VENDED,"
		cQuery += "A3_NREDUZ AS NOME,"
		cQuery += "L1_CLIENTE AS CLIENTE,"
		cQuery += "A1_NREDUZ AS NOM_CLI,"
		cQuery += "B1_TIPO AS TIPO,"
		cQuery += "L2_PRODUTO AS PROD,"
		cQuery += "B1_DESC AS DESCRI,"
		cQuery += "L2_QUANT AS QUANT,"
		cQuery += "L2_UM AS UNIDA,"	
		cQuery += "L2_VRUNIT AS UNIT,"
		cQuery += "L2_VALDESC AS DESCON,"
		cQuery += "L2_DESCPRO AS DESCTOT,"
		cQuery += "L2_VLRITEM AS TOTAL," 
		cQuery += "L2_VALICM AS ICMS," 
		cQuery += "B1_GRUPO AS GRUPO,"
		cQuery += "L1_CONDPG AS COND,"
		cQuery += "L1_OPERADO AS CAIXA,"
		cQuery += "L1_FILIAL AS FILIAL,"
		cQuery += "L1_MOEDA AS MOEDA,"    						
		cQuery += "L2_STATUS AS STATUS,"
		cQuery += "L2_TES AS TES,"
		cQuery += "L2_VLRITEM AS ACRES,"
		cQuery += "L1_VALIMP1+L1_VALIMP2+L1_VALIMP3+L1_VALIMP4+L1_VALIMP5+L1_VALIMP6 AS IMPOSTOS,"
		cQuery += "'() ' AS TIPOIMP,"
		cQuery += "' ' AS OL,"    
		cQuery += "'NF ' AS TIPODOC"    		
		cQuery += "  FROM "
		cQuery += RetSqlName("SL1") + " SL1,"
		cQuery += RetSqlName("SL2") + " SL2,"
		cQuery += RetSqlName("SA1") + " SA1,"
		cQuery += RetSqlName("SA3") + " SA3,"
		cQuery += RetSqlName("SB1") + " SB1,"
		cQuery += RetSqlName("SF4") + " SF4 "
		cQuery += " WHERE"
		cQuery += " SL1.L1_CLIENTE = SA1.A1_COD"
		cQuery += " AND SL1.L1_LOJA = SA1.A1_LOJA"
		cQuery += " AND SA1.A1_COD = SA3.A3_COD" 
		cQuery += " AND SA3.A3_COD = SL1.L1_VEND"
		cQuery += " AND SL1.L1_FILIAL = SL2.L2_FILIAL"
		cQuery += " AND SL1.L1_NUM = SL2.L2_NUM"
		cQuery += " AND SL2.L2_PRODUTO = SB1.B1_COD"  
		cQuery += " AND SL2.L2_TES = SF4.F4_CODIGO"
		cQuery += " AND SL1.L1_CLIENTE BETWEEN '"+mv_par11+"' AND '"+mv_par12+"'"
		cQuery += " AND SL1.L1_OPERADO BETWEEN '"+mv_par13+"' AND '"+mv_par14+"'"
		cQuery += " AND SL1.L1_EMISNF BETWEEN '"+DTOS(mv_par01)+"' AND '"+DTOS(mv_par02)+"'"
		cQuery += " AND SL1.L1_VEND BETWEEN '"+mv_par03+"' AND '"+mv_par04+"'"
		cQuery += " AND L1_TIPO LIKE 'V' "
		cQuery += " AND L1_CONDPG <> 'LAY' "	//Desprezar as finalizacoes de Lay-Away
		If mv_par15 == 2
			cQuery += " AND SL1.L1_FILIAL = '" +cFilAnt+"'"
		Else
			cQuery += " AND SL1.L1_FILIAL BETWEEN '"+mv_par17+"' AND '"+mv_par18+"'"			
		EndIf
		cQuery += " AND SL1.L1_MOEDA = '"+Str(mv_par20,2)+"'"
		cQuery += " AND SL2.L2_PRODUTO BETWEEN '"+mv_par05+"' AND '"+mv_par06+"'"
		cQuery += " AND SF4.F4_ESTOQUE LIKE 'S' " 
		cQuery += " AND SB1.B1_TIPO BETWEEN '"+mv_par07+"' AND '"+mv_par08+"'"
		cQuery += " AND SB1.B1_GRUPO BETWEEN '"+mv_par09+"' AND '"+mv_par10+"'"
		cQuery += " AND SL1.D_E_L_E_T_ <> '*' "
		cQuery += " AND SL2.D_E_L_E_T_ <> '*' "
		cQuery += " AND SB1.D_E_L_E_T_ <> '*' "
		cQuery += " AND SA1.D_E_L_E_T_ <> '*' "
		cQuery += " AND SA3.D_E_L_E_T_ <> '*' "
		cQuery += " AND SF4.D_E_L_E_T_ <> '*' "
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Lay-Away(Porto Rico/EUA)                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cPaisLoc $ "POR|EUA"
		   cQuery += "UNION "
		   cQuery += "SELECT "
		   cQuery += "E5_LOJA AS LOJA,"
		   cQuery += "E5_DATA AS DTEMI,"
		   cQuery += "E5_NUMERO AS N_FISCAL,"
		   cQuery += "' ' AS ITEM,"
		   cQuery += "E5_PARCELA AS SERIE,"
		   cQuery += "' ' AS VENDED,"
		   cQuery += "' ' AS NOME,"
		   cQuery += "E5_CLIFOR AS CLIENTE,"
		   cQuery += "A1_NREDUZ AS NOM_CLI,"  
		   cQuery += "B1_TIPO AS TIPO,"
		   cQuery += "LO_PRODUTO AS PROD,"
	 	   cQuery += "B1_DESC AS DESCRI,"
		   cQuery += "LO_QUANT AS QUANT,"
		   cQuery += "LO_UM AS UNIDA,"
		   cQuery += "E5_VALOR AS UNIT,"
		   cQuery += "LO_VALDESC AS DESCON,"
		   cQuery += "0 AS DESCTOT,"
		   cQuery += "E5_VALOR AS TOTAL,"
		   cQuery += "0 AS ICMS,"
		   cQuery += "B1_GRUPO AS GRUPO,"
		   cQuery += "LO_COND AS COND,"
		   cQuery += "E5_BANCO AS CAIXA,"
		   cQuery += "LO_FILIAL AS FILIAL,"
		   cQuery += "1 AS MOEDA,"    								   
		   cQuery += "' ' AS STATUS,"
		   cQuery += "LO_TES AS TES,"
		   cQuery += "0 AS ACRES,"
		   cQuery += "0 AS IMPOSTOS,"
		   cQuery += "'() ' AS TIPOIMP,"
		   cQuery += "' ' AS OL,"
		   cQuery += "'LAY' AS TIPODOC"    				   
		   cQuery += "  FROM "
		   cQuery += RetSqlName("SE5") + " SE5,"
		   cQuery += RetSqlName("SLO") + " SLO,"
		   cQuery += RetSqlName("SLP") + " SLP,"
		   cQuery += RetSqlName("SB1") + " SB1,"
		   cQuery += RetSqlName("SA1") + " SA1"
		   cQuery += "  WHERE	(SE5.E5_DATA >= '" + Dtos(mv_par01) + "' AND SE5.E5_DATA <= '" + Dtos(mv_par02) + "') AND "
		   cQuery += "  (SE5.E5_BANCO >= '" + mv_par13 + "' AND SE5.E5_BANCO <= '" + mv_par14 + "') AND "
		   cQuery += "  (SE5.E5_CLIFOR >= '" + mv_par11 + "' AND SE5.E5_CLIFOR <= '" + mv_par12 + "') AND "
		   cQuery += "  (SLO.LO_PRODUTO >= '" + mv_par05 + "' AND SLO.LO_PRODUTO <= '" + mv_par06 + "') AND "
           cQuery += "  (SB1.B1_GRUPO BETWEEN '"+mv_par09+"' AND '"+mv_par10+"') AND "		   
		   cQuery += "   SLO.LO_ITEM = ( SELECT MIN(LO_ITEM) FROM " + RetSqlName("SLO") + " SLOTMP WHERE SLOTMP.LO_NUMLAY = SLO.LO_NUMLAY AND SLOTMP.D_E_L_E_T_<>'*' ) AND "  //Busca o primeiro item do Lay-Away
		   cQuery += "  (SE5.E5_PREFIXO = '"+ &(GetMv("MV_LWPREF1")) +"' AND SE5.E5_TIPO = 'RA ' AND SE5.E5_RECPAG = 'R' AND SE5.E5_TIPODOC = 'RA') AND "    //LayAway - venda
		
 		   cQuery += "  SE5.E5_PREFIXO = SLP.LP_PREFIXO AND"   //SE5 x SLP
		   cQuery += "  SE5.E5_NUMERO = SLP.LP_NUME1 AND"
		   cQuery += "  SE5.E5_PARCELA = SLP.LP_PARCELA AND"
		
		   cQuery += "  SE5.E5_CLIFOR = SLO.LO_CLIENTE AND"	   //SLO x SE5
		   cQuery += "  SE5.E5_LOJA = SLO.LO_LOJA AND"
		
		   cQuery += "  SLP.LP_FILIAL = SLO.LO_FILIAL AND"	    //SLO x SLP
		   cQuery += "  SLP.LP_NUMLAY = SLO.LO_NUMLAY AND"
		
		   cQuery += "  SLO.LO_CLIENTE = SA1.A1_COD AND"	   //SLO x SA1
		   cQuery += "  SLO.LO_LOJA = SA1.A1_LOJA AND"
		
		   cQuery += "  SLO.LO_PRODUTO = SB1.B1_COD AND"      //SLO x SB1
		
	 	   cQuery += "  SE5.D_E_L_E_T_<>'*' "
		   cQuery += "AND  SLO.D_E_L_E_T_<>'*' "
		   cQuery += "AND  SB1.D_E_L_E_T_<>'*' "
		   cQuery += "AND  SA1.D_E_L_E_T_<>'*' "
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Devolucoes                                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        If mv_par16 == 1
            cQuery += "UNION "
			cQuery += "SELECT "
			cQuery += "F1_LOJA AS LOJA,"
			cQuery += "F1_EMISSAO AS DTEMI,"
			cQuery += "F1_DOC AS N_FISCAL,"
			cQuery += "D1_ITEM AS ITEM,"
			cQuery += "F1_SERIE AS SERIE,"
			cQuery += "F1_VEND1 AS VENDED,"
			cQuery += "A3_NREDUZ AS NOME,"
			cQuery += "F1_FORNECE AS CLIENTE,"
			cQuery += "A1_NREDUZ AS NOM_CLI,"
			cQuery += "B1_TIPO AS TIPO,"
			cQuery += "D1_COD AS PROD,"
			cQuery += "B1_DESC AS DESCRI,"
			cQuery += "D1_QUANT AS QUANT,"
			cQuery += "D1_UM AS UNIDA,"
			cQuery += "D1_VUNIT AS UNIT,"
			cQuery += "D1_VALDESC AS DESCON,"
			cQuery += "F1_DESCONT AS DESCTOT,"
			cQuery += "D1_TOTAL AS TOTAL,"
			cQuery += "D1_VALICM AS ICMS,"
			cQuery += "B1_GRUPO AS GRUPO,"
			cQuery += "F1_COND AS COND,"
			cQuery += "D1_NUMCQ AS CAIXA,"
			cQuery += "F1_FILIAL AS FILIAL,"
		    cQuery += "F1_MOEDA AS MOEDA,"    									
			cQuery += "'D' AS STATUS,"
			cQuery += "D1_TES AS TES,"
			cQuery += "D1_TOTAL AS ACRES,"
			cQuery += "D1_VALIMP1+D1_VALIMP2+D1_VALIMP3+D1_VALIMP4+D1_VALIMP5+D1_VALIMP6 AS IMPOSTOS,"
			cQuery += "'() ' AS TIPOIMP,"
			cQuery += "'S' AS OL,"    
		    cQuery += "'NCC' AS TIPODOC"    					
			cQuery += "  FROM "
			cQuery += RetSqlName("SF1") + " SF1,"
			cQuery += RetSqlName("SD1") + " SD1,"
			cQuery += RetSqlName("SA1") + " SA1,"
			cQuery += RetSqlName("SA3") + " SA3,"
			cQuery += RetSqlName("SF4") + " SF4,"
			cQuery += RetSqlName("SB1") + " SB1 "
			cQuery += " WHERE "
			cQuery += " SF1.F1_FORNECE = SA1.A1_COD"
			cQuery += " AND SF1.F1_FILIAL = SD1.D1_FILIAL"
			cQuery += " AND SA1.A1_COD = SA3.A3_COD"  
			cQuery += " AND SA3.A3_COD = SF1.F1_VEND1"
			cQuery += " AND SF1.F1_DOC = SD1.D1_DOC"
			cQuery += " AND SF1.F1_SERIE = SD1.D1_SERIE"
			cQuery += " AND SD1.D1_COD = SB1.B1_COD"
			cQuery += " AND SD1.D1_TES = SF4.F4_CODIGO"      
			cQuery += " AND SD1.D1_TIPO = 'D' "
			cQuery += " AND SD1.D1_ORIGLAN = 'LO' "
			cQuery += " AND SF1.F1_EMISSAO BETWEEN '"+DTOS(mv_par01)+"' AND '"+DTOS(mv_par02)+"'"
			cQuery += " AND SF1.F1_VEND1 BETWEEN '"+mv_par03+"' AND '"+mv_par04+"'"
			cQuery += " AND SF1.F1_FORNECE BETWEEN '"+mv_par11+"' AND '"+mv_par12+"'" 
			cQuery += " AND SF1.F1_MOEDA = '"+Str(mv_par20,2)+"'"
			cQuery += " AND SD1.D1_COD BETWEEN '"+mv_par05+"' AND '"+mv_par06+"'"
			cQuery += " AND SD1.D1_NUMCQ BETWEEN '"+mv_par13+"' AND '"+mv_par14+"'"
			cQuery += " AND SF4.F4_ESTOQUE = 'S' " 
			cQuery += " AND SB1.B1_TIPO BETWEEN '"+mv_par07+"' AND '"+mv_par08+"'"
			cQuery += " AND SB1.B1_GRUPO BETWEEN '"+mv_par09+"' AND '"+mv_par10+"'"
			cQuery += " AND SF1.D_E_L_E_T_ <> '*' "
			cQuery += " AND SD1.D_E_L_E_T_<>'*' "
			cQuery += " AND SA1.D_E_L_E_T_<>'*' "
			cQuery += " AND SA3.D_E_L_E_T_<>'*' "
			cQuery += " AND SF4.D_E_L_E_T_<>'*' "
			cQuery += " AND SB1.D_E_L_E_T_<>'*' "

		    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		    //³ Cancelamento do Lay-Away(Porto Rico/EUA)      ³
		    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		    If cPaisLoc $ "EUA|POR"
		       cQuery += "UNION "
		       cQuery += "SELECT "
		       cQuery += "E5_LOJA AS LOJA,"
		       cQuery += "E5_DATA AS DTEMI,"
		       cQuery += "E5_NUMERO AS N_FISCAL,"
		       cQuery += "' ' AS ITEM,"
		       cQuery += "E5_PARCELA AS SERIE,"
		       cQuery += "' ' AS VENDED,"
			   cQuery += "' ' AS NOME,"
			   cQuery += "E5_CLIFOR AS CLIENTE,"
			   cQuery += "' ' AS NOM_CLI,"  
			   cQuery += "' ' AS TIPO,"
			   cQuery += "' ' AS PROD,"
			   cQuery += "'"+OemToAnsi(STR0038)+"' AS DESCRI,"  //" DEVOLUCAO DE LAY-AWAY"			
			   cQuery += " 1  AS QUANT,"
			   cQuery += "' ' AS UNIDA,"
			   cQuery += "E5_VALOR AS UNIT,"
			   cQuery += " 0 AS DESCON,"
			   cQuery += "0 AS DESCTOT,"
			   cQuery += "E5_VALOR AS TOTAL,"
			   cQuery += "0 AS ICMS,"
			   cQuery += "' ' AS GRUPO,"
			   cQuery += "' ' AS COND,"
			   cQuery += "E5_BANCO AS CAIXA,"
			   cQuery += "E5_FILIAL AS FILIAL,"
		       cQuery += "1 AS MOEDA,"    									   
			   cQuery += "'D' AS STATUS,"
			   cQuery += "' ' AS TES,"
			   cQuery += "0 AS ACRES,"
			   cQuery += "0 AS IMPOSTOS,"
			   cQuery += "'() ' AS TIPOIMP,"
			   cQuery += "' ' AS OL,"
		       cQuery += "'LAY' AS TIPODOC"    					   
			   cQuery += "  FROM "
			   cQuery += RetSqlName("SE5") + " SE5"
			   cQuery += "  WHERE	(SE5.E5_DATA >= '" + Dtos(mv_par01) + "' AND SE5.E5_DATA <= '" + Dtos(mv_par02) + "') AND "
			   cQuery += "  (SE5.E5_BANCO >= '" + mv_par13 + "' AND SE5.E5_BANCO <= '" + mv_par14 + "') AND "
			   cQuery += "  (SE5.E5_CLIFOR >= '" + mv_par11 + "' AND SE5.E5_CLIFOR <= '" + mv_par12 + "') AND "
			   cQuery += "  (SE5.E5_PREFIXO = '"+ &(GetMv("MV_LWPREF1")) +"' AND SE5.E5_TIPO = 'RA ' AND SE5.E5_RECPAG = 'P' AND SE5.E5_TIPODOC = 'VL') AND "    //LayAway cancelado
			   cQuery += "  SE5.D_E_L_E_T_<>'*' "
			EndIf   
		EndIf
		cQuery += " ORDER BY "+ SqlOrder(cIndexKey)
			
		Processa( {|lEnd| MsSql2Trb(cQuery, aStruTRB, "TRB")}) //,,OemToAnsi(STR0045) )

		DbSelectArea("TRB")
		DbSetorder(1)
		DbGotop()

		SetRegua(RecCount())

		While !Eof()
    		IncRegua()
    		
    		//Se for Lay-Away, buscar a moeda baseado no Caixa(arq. SA6)
    		If TRB->TIPODOC == "LAY"
    		   SA6->(DbSetOrder(1))
    		   If SA6->(DbSeek(xFilial("SA6")+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))		  
    		      nMoeda  := Max(SA6->A6_MOEDA,1)
    		   EndIf
    		Else
    		   nMoeda  := TRB->MOEDA   
    		EndIf
		    RecLock("TRB",.F.)
			Replace UNIT		With Round(xMoeda(TRB->UNIT,nMoeda,mv_par20,DTEMI,nDecs+1),nDecs)
			Replace DESCON		With Round(xMoeda(TRB->DESCON,nMoeda,mv_par20,DTEMI,nDecs+1),nDecs)
			Replace DESCTOT		With Round(xMoeda(TRB->DESCTOT,nMoeda,mv_par20,DTEMI,nDecs+1),nDecs)
			Replace TOTAL		With Round(xMoeda(TRB->TOTAL,nMoeda,mv_par20,DTEMI,nDecs+1),nDecs)
			Replace ACRES		With Max(Round(xMoeda(TRB->TOTAL,nMoeda,mv_par20,DTEMI,nDecs+1),nDecs) - (Round(UNIT*QUANT,2)),0)
			Replace TIPOIMP 	With "()"			
			If cPaisLoc <> "BRA" .And. Iif(cPaisLoc$"POR|EUA",TRB->TIPODOC != "LAY",.T.)
				aTesImpInf 	:= TesImpInf(TRB->TES)
				DbSelectArea("TRB")
				For nI := 1 To Len( aTesImpInf )
					If ! lDiscrim
						lDiscrim := ( aTesImpInf[nI][3] == "1" )
					EndIf
					If ! lIncluido
						lIncluido := ( aTesImpInf[nI][3] <> "1" )
					EndIf
					nImposto := Round(xMoeda(IMPOSTOS,nMoeda,mv_par20,DTEMI,nDecs+1),nDecs)
					If ( lDiscrim .And. lIncluido )
						Replace TIPOIMP 	With "()"
					ElseIf lDiscrim
						Replace TIPOIMP		With "(D)"
						Replace TOTAL  		With TOTAL + IIf (aTesImpInf[nI][3] == "1",nImposto,0)
					ElseIf lIncluido
						Replace TIPOIMP 	With "(I)"
						Replace TOTAL  		With TOTAL - IIf (aTesImpInf[nI][3] == "1",nImposto,0)
					EndIf
				Next nI
			EndIf
			MsUnLock()
			DbSkip()
		End
	EndIf
#ELSE

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se totaliza as filiais  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par15 == 2
		cFilDe := cFilAnt
		cFilAte:= cFilAnt
	Else
		cFilDe := mv_par17
		cFilAte:= mv_par18
	EndIf

	DbSelectArea("SL1")
	DbSeek( cFilDe ,.T.)

	While !Eof() .and. L1_FILIAL <= cFilAte
		
		If L1_CLIENTE < mv_par11 .or. L1_CLIENTE > mv_par12
			DbSkip()
			Loop
		EndIf

        If DTOS(L1_EMISNF) < DTOS(mv_par01) .Or. DTOS(L1_EMISNF) > DTOS(mv_par02)
		   DbSkip()
           Loop
        EndIf
		
		If L1_OPERADO < mv_par13 .Or. L1_OPERADO > mv_par14
		   DbSkip()
		   Loop
		EndIf

		If L1_VEND < mv_par03 .Or. L1_VEND > mv_par04
			DbSkip()
			Loop
		EndIf

		If cPaisloc <> "BRA" .And. mv_par21 == 2 .And. mv_par20 <> SL1->L1_MOEDA
			DbSkip()
			Loop
		EndIf
	
		DbSelectArea("SL2")
		DbSetOrder(1)
		DbSeek( SL1->L1_FILIAL+SL1->L1_NUM )
	
		While !Eof() .and.;
			 L2_FILIAL == SL1->L1_FILIAL .and.;
			 L2_NUM == SL1->L1_NUM
		
			If SF4->( DbSeek(xFilial("SF4")+SL2->L2_TES) )
				If SF4->F4_DUPLIC != "S"
			   		SL2->(DbSkip())
				    Loop
				EndIf
			EndIf
				
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se as condicoes serao satisfeitas	  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If L2_PRODUTO < mv_par05 .or. L2_PRODUTO > mv_par06
				DbSkip()
				Loop
			EndIf
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona no produto                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DbSelectarea("SB1")
			DbSetOrder(1)
			cFilTmp := If( EMPTY( xFilial("SB1") ), xFilial("SB1"), SL1->L1_FILIAL )
			DbSeek( cFilTmp + SL2->L2_PRODUTO)
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona na Condicao de Pagto                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DbSelectarea("SE4")
			DbSetOrder(1)
			cFilTmp := IIF( EMPTY( xFilial("SE4") ), xFilial("SE4"), SL1->L1_FILIAL )
			DbSeek( cFilTmp + SL1->L1_CONDPG)
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona no registro do vendedor             ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DbSelectarea("SA3")
			DbSetOrder(1)
			cFilTmp := IIF( EMPTY( xFilial("SA3") ), xFilial("SA3"), SL1->L1_FILIAL )
			DbSeek( cFilTmp + SL1->L1_VEND)
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona no registro do cliente              ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DbSelectarea("SA1")
			DbSetOrder(1)
			cFilTmp := IIF( EMPTY( xFilial("SA1") ), xFilial("SA1"), SL1->L1_FILIAL )
			DbSeek( cFilTmp + SL1->L1_CLIENTE + SL1->L1_LOJA)
		
			If SB1-> B1_TIPO < Mv_Par07 .Or. SB1-> B1_TIPO > Mv_Par08 .Or. ;
				SB1-> B1_GRUPO < Mv_Par09 .Or. SB1-> B1_GRUPO > Mv_Par10
				DbSelectArea("SL2")
				DbSKIP()
				Loop
			EndIf

			nMoeda      	:= If( cPaisLoc <> "BRA", Max( SL1->L1_MOEDA, 1 ), 1 )
		
			RecLock("TRB",.T.)
			Replace LOJA		With SL1->L1_LOJA
			Replace CAIXA		With SL1->L1_OPERADO
			Replace DTEMI		With SL1->L1_EMISNF
			Replace N_FISCAL	With SL1->L1_DOC
			Replace SERIE		With SL1->L1_SERIE
			Replace VENDED 		With SL1->L1_VEND
			Replace NOME		With SA3->A3_NREDUZ
			Replace CLIENTE		With SL1->L1_CLIENTE
			Replace NOM_CLI		With SA1->A1_NREDUZ
			Replace TIPO		With SB1->B1_TIPO
			Replace PROD		With SL2->L2_PRODUTO
			Replace DESCRI 		With SL2->L2_DESCRI
			Replace QUANT		With SL2->L2_QUANT
			Replace UNIDA		With SL2->L2_UM
			Replace UNIT		With (IIF(SL2->L2_PRCTAB==0,Round(xMoeda(SL2->L2_VRUNIT,nMoeda,Mv_Par20,SL2->L2_EMISSAO,nDecs+1,SL1->L1_TXMOEDA),;
					nDecs),Round(xMoeda(SL2->L2_PRCTAB,nMoeda,Mv_Par20,SL2->L2_EMISSAO,nDecs+1,SL1->L1_TXMOEDA),nDecs)) + ;
					(SL2->L2_VALIPI / SL2->L2_QUANT))

			Replace TES         With SL2->L2_TES
			Replace DESCON		With Round(xMoeda(SL2->L2_VALDESC,nMoeda,Mv_Par20,SL2->L2_EMISSAO,nDecs+1,SL1->L1_TXMOEDA),nDecs)
			Replace DESCTOT		With Round(xMoeda(SL2->L2_DESCPRO,nMoeda,Mv_Par20,SL2->L2_EMISSAO,nDecs+1,SL1->L1_TXMOEDA),nDecs)
			Replace TOTAL		With Round(xMoeda(SL2->L2_VLRITEM,nMoeda,Mv_Par20,SL2->L2_EMISSAO,nDecs+1,SL1->L1_TXMOEDA),nDecs)
			Replace ICMS		With SL2->L2_VALICM
			Replace GRUPO		With SB1->B1_GRUPO
			Replace COND		With SL1->L1_CONDPG
			Replace FILIAL 		With SL1->L1_FILIAL
			Replace ACRES		With Round(xMoeda(SL2->L2_VLRITEM,nMoeda,Mv_Par20,SL2->L2_EMISSAO,nDecs+1,SL1->L1_TXMOEDA),nDecs) - (Round(UNIT*QUANT,2))
			Replace STATUS 		With ""
			If TRB->ACRES < 0
				Replace ACRES 	With 0
			EndIf
			
			lIncluido   	:= .F.
			lDiscrim    	:= .F.
			If cPaisLoc <> "BRA"
				aTesImpInf 	:= TesImpInf( SL2->L2_TES )
				For nI := 1 To Len( aTesImpInf )
					If ! lDiscrim
						lDiscrim := ( aTesImpInf[nI][3] == "1" )
					EndIf
					If ! lIncluido
						lIncluido := ( aTesImpInf[nI][3] <> "1" )
					EndIf
					cCampo := "SL2->L2_"+Substr( aTesImpInf[nI][2], 4 )
					nImposto := Round(xMoeda(&cCampo,nMoeda,Mv_Par20,SL2->L2_EMISSAO,nDecs+1,SL1->L1_TXMOEDA),nDecs)
					Replace TOTAL  With TOTAL + IIf (aTesImpInf[nI][3] == "1",nImposto,0)
				Next nI
				Replace IMPOSTOS	With nImposto
				If lDiscrim .and. lIncluido
					Replace TIPOIMP With "()"
				ElseIf lDiscrim
					Replace TIPOIMP With "(D)"
				ElseIf lIncluido
					Replace TIPOIMP With "(I)"
				EndIf
			EndIf

			DbSelectArea("SL2")
			DbSkip()
		End
		DbSelectArea("SL1")
		DbSkip()
	End

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Lay-Away - POR/EUA               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cPaisLoc $ "POR|EUA"
	   If mv_par15 == 2
		  cFilDe := cFilAnt
		  cFilAte:= cFilAnt
	   Else
		  cFilDe := mv_par17
		  cFilAte:= mv_par18
	   EndIf       
       
	   DbSelectArea("SE5")
	   DbSetOrder(1)
	   DbSeek( cFilDe+DTOS(mv_par01) ,.T.)

	   While !Eof() .And. E5_FILIAL <= cFilAte .And. DTOS(E5_DATA) <= DTOS(mv_par02)

		  If E5_PREFIXO != &(GetMv("MV_LWPREF1")) .Or. E5_TIPO != 'RA '
			 DbSkip()
			 Loop
		  EndIf

		  If DTOS(E5_DATA) < DTOS(mv_par01) .Or. DTOS(E5_DATA) > DTOS(mv_par02)
			 DbSkip()
			 Loop
		  EndIf
		
		  If E5_CLIFOR < mv_par11 .Or. E5_CLIFOR > mv_par12
			 DbSkip()
			 Loop
		  EndIf

		  If E5_BANCO < mv_par13 .Or. E5_BANCO > mv_par14
			 DbSkip()
			 Loop
		  EndIf
	      	
		  SA6->(DbSetOrder(1))
		  If SA6->(DbSeek(xFilial("SA6")+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))		  
		     nMoedaBco  := Max(SA6->A6_MOEDA,1)
		     If mv_par21 == 2 .And. mv_par20 <> nMoedaBco
			    SE5->(DbSkip())
			    Loop
			 EndIf   
		  EndIf
	      
	      lLayCanc  := (SE5->E5_RECPAG == 'P' .And. SE5->E5_TIPODOC == 'VL')  //Lay-Away cancelado
	      
		  DbSelectArea("SLP")
		  DbSetOrder(3)
		  lFoundSLP  := DbSeek(xFilial("SLP")+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA)
			 	 
		     DbSelectArea("SLO")
		     DbSetOrder(1)
		     If lFoundSLP  
		        DbSeek(xFilial("SLO")+SLP->LP_NUMLAY)				 
		     Else  //Lay-Away cancelado, logo, o(s) registro(s) do SLP correspondente foi(ram) deletado(s)
		        DbSeek(xFilial("SLO")+AllTrim(SE5->E5_NUMERO))				 		     
		     EndIf   
			 		
			 If SF4->( DbSeek(xFilial("SF4")+SLO->LO_TES) )
				If SF4->F4_DUPLIC != "S"
			   		SE5->(DbSkip())
				    Loop
				EndIf
			 EndIf
				
			 //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			 //³ Verifica se as condicoes serao satisfeitas	   ³
			 //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			 If LO_PRODUTO < mv_par05 .Or. LO_PRODUTO > mv_par06
			   	SE5->(DbSkip())
				Loop
			 EndIf
		
			 //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			 //³ Posiciona no produto                          ³
			 //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			 DbSelectarea("SB1")
			 DbSetOrder(1)
			 cFilTmp := If( EMPTY( xFilial("SB1") ), xFilial("SB1"), SLO->LO_FILIAL )
			 DbSeek( cFilTmp + SLO->LO_PRODUTO)

			 If SB1-> B1_TIPO < Mv_Par07 .Or. SB1-> B1_TIPO > Mv_Par08 .Or. ;
				SB1-> B1_GRUPO < Mv_Par09 .Or. SB1-> B1_GRUPO > Mv_Par10
				SE5->(DbSkip())
				Loop
			 EndIf
		
			 //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			 //³ Posiciona na Condicao de Pagto                ³
			 //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			 DbSelectarea("SE4")
			 DbSetOrder(1)
			 cFilTmp := IIF( EMPTY( xFilial("SE4") ), xFilial("SE4"), SLO->LO_FILIAL )
			 DbSeek( cFilTmp + SLO->LO_COND)
			
			 //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			 //³ Posiciona no registro do cliente              ³
			 //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			 DbSelectarea("SA1")
			 DbSetOrder(1)
			 cFilTmp := IIF( EMPTY( xFilial("SA1") ), xFilial("SA1"), SLO->LO_FILIAL )
			 DbSeek( cFilTmp + SLO->LO_CLIENTE + SLO->LO_LOJA)
		
			 nMoeda := If( cPaisLoc <> "BRA", Max( SLO->LO_MOEDA, 1 ), 1 )
		
			 RecLock("TRB",.T.)
			 Replace LOJA		With SLO->LO_LOJA
			 Replace CAIXA		With SE5->E5_BANCO
			 Replace DTEMI		With SLO->LO_EMISSAO
			 Replace N_FISCAL	With SLO->LO_NUMLAY
			 Replace SERIE		With SLP->LP_PARCELA
			 Replace CLIENTE	With SLO->LO_CLIENTE
			 Replace NOM_CLI	With SA1->A1_NREDUZ
			 Replace TIPO		With SB1->B1_TIPO
			 Replace PROD		With SLO->LO_PRODUTO
			 Replace DESCRI 	With SB1->B1_DESC
			 Replace QUANT		With SLO->LO_QUANT
			 Replace UNIDA		With SLO->LO_UM
			 Replace UNIT		With Round(xMoeda(SE5->E5_VALOR,nMoedaBco,Mv_Par20,SE5->E5_DATA,nDecs+1),nDecs)
			 Replace TES        With SLO->LO_TES
			 Replace DESCON		With Round(xMoeda(SLO->LO_VALDESC,nMoeda,Mv_Par20,SLO->LO_EMISSAO,nDecs+1,SLO->LO_TXMOEDA),nDecs)
			 Replace TOTAL		With Round(xMoeda(SE5->E5_VALOR,nMoedaBco,Mv_Par20,SE5->E5_DATA,nDecs+1),nDecs)
			 Replace GRUPO		With SB1->B1_GRUPO
			 Replace COND		With SLO->LO_COND
			 Replace FILIAL 	With SLO->LO_FILIAL
			 Replace ACRES		With 0
			 Replace STATUS 	With IIf(lLayCanc,"D","")
		     Replace TIPOIMP    With "()"
	      DbSelectArea("SE5")
	      DbSkip()
	   End
	EndIf   
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica devolucoes                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par16 == 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta IndRegua para SF1                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbSelectArea("SF1")
		DbSetOrder(1)
		DbSeek( cFilDe ,.T.)
	
		While (! Eof() .and. SF1->F1_FILIAL <= cFilAte )
		
		    If DTOS(F1_EMISSAO) < DTOS(mv_par01) .Or. DTOS(F1_EMISSAO) > DTOS(mv_par02)
			   DbSkip()
			   Loop
		    EndIf

		    If F1_FORNECE < mv_par11 .Or. F1_FORNECE > mv_par12
			   DbSkip()
			   Loop
		    EndIf

		    If F1_VEND1 < mv_par03 .Or. F1_VEND1 > mv_par04
			   DbSkip()
			   Loop
		    EndIf
		
			IF cPaisloc <> "BRA" .and. mv_par21 == 2 .and. mv_par20 <> SF1->F1_MOEDA 
				DbSkip()
				Loop
			ENDIF
		
			DbSelectArea("SD1")
			DbSetOrder(1)
			DbSeek( SF1->F1_FILIAL + SF1->F1_DOC + SF1->F1_SERIE )
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona no registro de fornecedores         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DbSelectArea("SA2")
			DbSetOrder(1)
			cFilTmp := IIF( EMPTY( xFilial("SA2") ), xFilial("SA2"), SF1->F1_FILIAL )
			DbSeek( cFilTmp + SF1->F1_FORNECE )
		
			DbSelectArea("SD1")
			While SD1->( ! EoF() ) .And. SF1->F1_FILIAL == SD1->D1_FILIAL .And. SF1->F1_DOC == SD1->D1_DOC .And. SF1->F1_SERIE == SD1->D1_SERIE
			
				If ! SD1->D1_TIPO == "D"
					DbSkip()
					Loop
				EndIf
			
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se as condicoes serao satisfeitas	  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If SubStr( SD1->D1_NUMCQ, 1, 3 ) < mv_par13 .Or.;
					SubStr( SD1->D1_NUMCQ, 1, 3 ) > mv_Par14
					dbSkip()
					Loop
				EndIf
			
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se as condicoes serao satisfeitas	  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If SD1->D1_COD < mv_par05 .Or. SD1->D1_COD > mv_par06
					DbSkip()
					Loop
				EndIf
			
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Posiciona no produto                          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				DbSelectarea("SB1")
				DbSetOrder(1)
				cFilTmp := IIF( EMPTY( xFilial("SB1") ), xFilial("SB1"), SF1->F1_FILIAL )
				DbSeek( cFilTmp + SD1->D1_COD)
				
			    If SB1->B1_TIPO  < mv_par07 .Or. SB1->B1_TIPO  > mv_par08 .Or.;
					SB1->B1_GRUPO < mv_par09 .Or. SB1->B1_GRUPO > mv_par10
					DbSelectArea("SD1")
					DbSkip()
					Loop
				EndIf

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Posiciona no registro do vendedor             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				DbSelectarea("SA3")
				DbSetOrder(1)
				cFilTmp := IIF( EMPTY( xFilial("SA3") ), xFilial("SA3"), SF1->F1_FILIAL )
				DbSeek( cFilTmp + SF1->F1_VEND1)

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Posiciona na Condicao de Pagto                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				DbSelectarea("SE4")
				DbSetOrder(1)
				cFilTmp := IIF( EMPTY( xFilial("SE4") ), xFilial("SE4"), SF1->F1_FILIAL )
				DbSeek( cFilTmp + SF1->F1_COND)
			
				nMoeda := If( cPaisLoc <> "BRA", Max( SF1->F1_MOEDA, 1 ), 1 )

				RecLock("TRB",.T.)
				Replace LOJA		With SF1->F1_LOJA
				Replace CAIXA		With Subs( SD1->D1_NUMCQ, 1, 3 )
				Replace DTEMI		With SF1->F1_EMISSAO
				Replace N_FISCAL	With SF1->F1_DOC
				Replace SERIE		With SF1->F1_SERIE
				Replace VENDED 		With SF1->F1_VEND1
				Replace NOME		With SA3->A3_NREDUZ
				Replace CLIENTE		With SF1->F1_FORNECE
				Replace NOM_CLI		With SA2->A2_NREDUZ
				Replace TIPO		With SB1->B1_TIPO
				Replace PROD		With SD1->D1_COD
				Replace DESCRI 		With SB1->B1_DESC
				Replace QUANT		With SD1->D1_QUANT
				Replace UNIDA		With SD1->D1_UM
				Replace UNIT		With Round(xMoeda(SD1->D1_VUNIT,nMoeda,Mv_Par20,SD1->D1_EMISSAO,nDecs+1),nDecs) + ;
						SD1->( D1_VALIPI / D1_QUANT )
                
				Replace TES         With SD1->D1_TES
				Replace DESCON		With Round(xMoeda(SD1->D1_VALDESC,nMoeda,Mv_Par20,SD1->D1_EMISSAO,nDecs+1),nDecs)
				Replace DESCTOT		With Round(xMoeda(SF1->F1_DESCONT,nMoeda,Mv_Par20,SD1->D1_EMISSAO,nDecs+1),nDecs)
				Replace TOTAL		With Round(xMoeda(SD1->D1_TOTAL,nMoeda,Mv_Par20,SD1->D1_EMISSAO,nDecs+1),nDecs)
				Replace ICMS		With SD1->D1_VALICM
				Replace GRUPO		With SD1->D1_GRUPO
				Replace COND		With SF1->F1_COND
				Replace FILIAL 		With SD1->D1_FILIAL
				Replace ACRES		With Max(Round(xMoeda(SD1->D1_TOTAL,nMoeda,Mv_Par20,SD1->D1_EMISSAO,nDecs+1),nDecs) - ( Round( UNIT * QUANT, 2 ) ),0)

				If cPaisLoc <> "BRA"
					aTesImpInf 	:= TesImpInf( SD1->D1_TES )
					For nI := 1 To Len( aTesImpInf )
						If ! lDiscrim
							lDiscrim := ( aTesImpInf[nI][3] == "1" )
						EndIf
						If ! lIncluido
							lIncluido := ( aTesImpInf[nI][3] <> "1" )
						EndIf
						cCampo := "SD1->"+aTesImpInf[nI][2]
						nImposto := Round(xMoeda(&cCampo,nMoeda,Mv_Par20,SD1->D1_EMISSAO,nDecs+1),nDecs)
						Replace TOTAL  With TOTAL + IIf (aTesImpInf[nI][3] == "1",nImposto,0)
					Next nI
					Replace IMPOSTOS	With nImposto
					If ( lDiscrim .And. lIncluido )
						Replace TIPOIMP 	With "()"
					ElseIf lDiscrim
						Replace TIPOIMP		With "(D)"
					ElseIf lIncluido
						Replace TIPOIMP 	With "(I)"
					EndIf
				EndIf	
				Replace STATUS 	With "D"
				Replace OL		With "S"
				MsUnlock()
				
				DbSelectArea("SD1")
				DbSkip()
			End
			DbSelectArea( "SF1" )
			DbSkip()
		End
	EndIf
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia a impressao do relatorio.              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("TRB")
DbSetorder(1)
DbGotop()

SetRegua(RecCount())

While !Eof()
	
	cFilAtu := TRB->FILIAL
	
	IF lEnd
		Exit
	EndIf
	
	While !Eof() .And. TRB->FILIAL == cFilAtu
		
		cParam:=&cCond1
		nContador := If( nOrdem # 3, 0, nContador )
		
		IF lEnd
			Exit
		EndIf	
		
		If Empty( Substr(cParam,1 + FWGETTAMFILIAL,4) )	 .And. nOrdem # 5 .And. nOrdem # 2		// Campo da quebra em branco
			dbSkip()
			Loop
		Endif
		
		While &cCond1 = cParam .And. !Eof()
			
			IncRegua()
			
			IF lEnd
				// CANCELADO PELO OPERADOR
				@PROW()+1,001 PSAY STR0029
				Exit
			EndIf
			
			If li >= 58
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,GetMv("MV_COMP"))
			Endif
			
			If !Empty(TRB->STATUS)
				nContador++
			EndIf
			
			If nContador == 1
				li++
				@ li,080 PSay STR0036  //" *********************** Devolucoes *********************** "
				li++
			EndIf
			
			If !Empty(TRB->STATUS)
				nDQuant	   += QUANT
				nDDescItem += DESCON
				nDDescProp += DESCTOT
				nDAcresItem+= ACRES
				nDValorRec += TOTAL
				If cPaisLoc == "BRA"
					nDValIcms+=ICMS
				Else
					nDValIcms+=IMPOSTOS
				EndIf
			ELSE
				nQuant	   += QUANT
				nDescItem += DESCON
				nDescProp += DESCTOT
				nAcresItem+= ACRES
				nValorRec += TOTAL
				If cPaisLoc == "BRA"
					nValIcms+=ICMS
				Else
					nValIcms+=IMPOSTOS
				Endif
			EndIf
			
			If	mv_par19 == 1
				LJR072Det(nOrdem)
				li++
			EndIf
			DbSkip()
			
		End
		
		If (nDescItem+nDescProp+nAcresItem+nValorRec+nValIcms) > 0
			LJR072ST(nDescItem,nDescProp,nAcresItem,nValorRec,nValIcms,nOrdem,cParam,nQuant)
			nFilQuant    += nQuant
			nFilDescItem += nDescItem
			nFilDescProp += nDescProp
			nFilAcresItem+= nAcresItem
			nFilValorRec += nValorRec
			nFilValIcms  += nValIcms
			nQuant    := 0
			nDescItem := 0
			nDescProp := 0
			nAcresItem:= 0
			nValorRec := 0
			nValIcms  := 0
		Endif
		
		If (nDDescItem+nDDescProp+nDAcresItem+nDValorRec+nDValIcms) > 0
			LJR072STD(nDDescItem,nDDescProp,nDAcresItem,nDValorRec,nDValIcms,nOrdem,cParam,nDQuant)
			nDFilQuant    += nDQuant
			nDFilDescItem += nDDescItem
			nDFilDescProp += nDDescProp
			nDFilAcresItem+= nDAcresItem
			nDFilValorRec += nDValorRec
			nDFilValIcms  += nDValIcms
			nDQuant     := 0
			nDDescItem := 0
			nDDescProp := 0
			nDAcresItem:= 0
			nDValorRec := 0
			nDValIcms  := 0
		EndIf
		li++
	Enddo
	
	If Mv_Par15 == 1
		LJR072TotF(nFilDescItem,nFilDescProp,nFilAcresItem,nFilValorRec,nFilValIcms,nDFilDescItem,;
		nDFilDescProp,nDFilAcresItem,nDFilValorRec,nDFilValIcms,cFilAtu,nFilQuant,nDFilQuant)
	Endif
	nGerQuant    += nFilQuant
	nGerDescItem += nFilDescItem
	nGerDescProp += nFilDescProp
	nGerAcresItem+= nFilAcresItem
	nGerValorRec += nFilValorRec
	nGerValIcms  += nFilValIcms
	nFilQuant    := 0
	nFilDescItem := 0
	nFilDescProp := 0
	nFilAcresItem:= 0
	nFilValorRec := 0
	nFilValIcms  := 0
	
	nDGerQuant    += nDFilQuant
	nDGerDescItem += nDFilDescItem
	nDGerDescProp += nDFilDescProp
	nDGerAcresItem+= nDFilAcresItem
	nDGerValorRec += nDFilValorRec
	nDGerValIcms  += nDFilValIcms
	
	nDFilQuant    := 0
	nDFilDescItem := 0
	nDFilDescProp := 0
	nDFilAcresItem:= 0
	nDFilValorRec := 0
	nDFilValIcms  := 0
	
	dbSelectArea("TRB")
Enddo

If li != 80
	LJR072Tot(nGerDescItem,nGerDescProp,nGerAcresItem,nGerValorRec,nGerValIcms,nDGerDescItem,;
	nDGerDescProp,nDGerAcresItem,nDGerValorRec,nDGerValIcms,nGerQuant,nDGerQuant)
Endif

Set Device To Screen

If( ValType(oTempTable) == "O")
  oTempTable:Delete()
  FreeObj(oTempTable)
  oTempTable := Nil
EndIf

RetIndex("SL1")
RetIndex("SF1")
RetIndex("SE5")

If aReturn[5] = 1
	Set Printer TO
	dbCommitAll()
	ourspool(wnrel)
Endif
MS_FLUSH()
Return( Nil )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ LJR072Det ³ Autor ³ Lucas                ³ Data ³ 07.06.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime a linha de detalhe do relatorio de acordo com a     ³±±
±±³          ³condicao de ordem                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_LojR072(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nao tem                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³Uso       ³ SIGALOJA                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function LJR072Det( nOrdem )

if nOrdem = 1
	/*/
	P	Data	 N.Fisc        Ser Vend.  Nome Vend.  Clien. Nome Cliente 	   Grupo Tipo Produto		  Descricao		  UN Quantidade	 Valor Unit.  Desc.It. Desc.Proproc.  Acrescimo  Valor Rec.          Valor Icms
	E	Date     Invoice       Ser Ass.   Name Cust.  Customer Name            Group Type Product         Description     UN Qtty        Unit Vlr.    It.Desc. Prop.Desc.     Item Incr. Receiv. Value    Tax  Value    CP. Fi OL
	S	Fecha    Factura       Ser Vend.  Nom. Vend.  Client Nom. Cliente      Grupo Tipo Producto        Descripcion     UN Cantidade   Vlr Unit.    Desc.It. Desc.Prop.     Acres.Item Valor Recibido   Impuestos     CP. Sc OL
	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	0		  1			2 	   	  3		    4 		  5			6		  7 	    8	      9			0 		  1			2	 	  3 		4		  5			6 		  7			8		  9 		0		  1			2 		  3
	0																									100																									200
	/*/
	@ li,000 PSay DTEMI
	@ li,009 PSay SubStr(N_FISCAL,1,TamSx3("L1_DOC")[1])
	@ li,023 PSay SubStr(SERIE,1,3)
	@ li,027 PSay SubStr(VENDED,1,6)
	@ li,034 PSay Substr(NOME,1,11)
	@ li,046 PSay Substr(CLIENTE,1,6)
	@ li,053 PSay Substr(NOM_CLI,1,17)
	@ li,072 PSay Substr(GRUPO,1,5)
	@ li,077 PSay Substr(TIPO,1,4)
	@ li,082 PSay Substr(PROD,1,15)
	@ li,098 PSay Substr(DESCRI,1,15)
	
elseif nOrdem =2
	/*/
	P	Vended Nome Vend. Data	   N.Fisc        Ser Client Nome Cliente      Grupo  Tip Produto         Descricao        UN Quantidade  Valor Unit.  Desc.It. Desc.Proproc.  Acrescimo  Valor Rec.          Valor Icms
	E   Assist Ass. Name  Date     Invoice       Ser Custom Name              Group  Typ Product         Description      UN Qtty        Unit. Vlr.   It.Descr Prop.Desc.     Item Incr. Receiv. Value    Tax  Value    CP. Fi OL
	S   Vend.  Nom. Vend. Fecha    Factuta       Ser Client Nom. Cliente      Grupo  Tip Producto        Descripcion      UN Canti.      Vlr Unit.    Desc.It. Desc.Prop.     Acres.Item Valor Recibido   Impuestos     CP. Sc OL
	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	0		  1			2 	   	  3		    4 		  5			6		  7 	    8	      9			0 		  1			2	 	  3 		4		  5			6 		  7			8		  9 		0		  1			2 		  3
	0																									100																									200
	/*/
	@ li,000 PSay SubStr(VENDED,1,6)
	@ li,007 PSay SubStr(NOME,1,10)
	@ LI,018 PSay DTEMI
	@ li,027 PSay SubStr(N_FISCAL,1,TamSx3("L1_DOC")[1])
	@ li,041 PSay Substr(SERIE,1,3)
	@ li,045 PSay Substr(CLIENTE,1,6)
	@ li,052 PSay Substr(NOM_CLI,1,17)
	@ li,072 PSay Substr(GRUPO,1,5)
	@ li,077 PSay Substr(TIPO,1,4)
	@ li,081 PSay Substr(PROD,1,15)
	@ li,097 PSay Substr(DESCRI,1,15)
	
elseif nOrdem = 3
	/*/
	P	Cod. Produto    Descricao      Data     NF		      Ser Vended Nome Vend.	 Client Nome Cliente      Grupo Tipo  UN Quantidade  Valor Unit.  Desc.It. Desc.Proproc.  Acrescimo  Valor Rec.          Valor Icms
	E   Product Code    Description    Date     Invoice       Ser Assis. Ass. Name   Cust.  Customer Name     Group Type  UN Qtty        Unit Vlr.    It.Descr Prop.Desc.     Item Incr. Receiv. Value    Tax  Value    CP. Fi OL
	S   Cod. Producto   Descripcion    Fecha    Factura       Ser Vend.  Nom. Vend.  Client Nom. Cliente      Grupo Tipo  UN Canti.      Vlr Unit.    Desc.It. Desc.Prop.     Acres.Item Valor Recibido   Impuestos     CP. Sc OL
	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	0		  1			2 	   	  3		    4 		  5			6		  7 	    8	      9			0 		  1			2	 	  3 		4		  5			6 		  7			8		  9 		0		  1			2 		  3
	0																									100																									200
	/*/
	@ li,000 PSay SubStr(PROD,1,15)
	@ li,016 PSay SubStr(DESCRI,1,15)
	@ li,031 PSay DTEMI
	@ li,040 PSay SubStr(N_FISCAL,1,TamSx3("L1_DOC")[1])
	@ li,054 PSay Substr(SERIE,1,3)
	@ li,058 PSay Substr(VENDED,1,6)
	@ li,065 PSay Substr(NOME,1,11)
	@ li,077 PSay Substr(CLIENTE,1,6)
	@ li,084 PSay Substr(NOM_CLI,1,17)
	@ li,102 PSay Substr(GRUPO,1,5)
	@ li,108 PSay Substr(TIPO,1,4)
	
Elseif nOrdem = 4
	/*/
	P	Tipo Cod. Produto    Descricao      Data     NF            Ser Vended Nome Vend.  Client Nome Cliente      Grupo  UN Quantidade  Valor Unit.  Desc.It. Desc.Proproc.  Acrescimo  Valor Rec.          Valor Icms
	E   Type Product Code    Description    Date     Invoice       Ser Assis. Ass. Name   Cust.  Customer Name     Group  UN Qtty        Unit Vlr.    It.Descr Prop.Desc.     Item Incr. Receiv. Value    Tax  Value    CP. Fi OL
	S   Tipo Cod. Producto   Descripcion    Fecha    Factura       Ser Vend.  Nom. Vend.  Client Nom. Cliente      Grupo  UN Canti.      Vlr Unit.    Desc.It. Desc.Prop.     Acres.Item Valor Recibido   Impuestos     CP. Sc OL
	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	0		  1			2 	   	  3		    4 		  5			6		  7 	    8	      9			0 		  1			2	 	  3 		4		  5			6 		  7			8		  9 		0		  1			2 		  3
	0																									100																									200
	/*/
	@ li,000 PSay SubStr(TIPO,1,4)
	@ li,005 PSay SubStr(PROD,1,15)
	@ li,021 PSay SubStr(DESCRI,1,15)
	@ li,036 PSay DTEMI
	@ li,045 PSay SubStr(N_FISCAL,1,TamSx3("L1_DOC")[1])
	@ li,059 PSay Substr(SERIE,1,3)
	@ li,063 PSay Substr(VENDED,1,6)
	@ li,072 PSay Substr(NOME,1,11)
	@ li,082 PSay Substr(CLIENTE,1,6)
	@ li,089 PSay Substr(NOM_CLI,1,17)
	@ li,107 PSay Substr(GRUPO,1,5)
	
elseif nOrdem = 5
	/*/
	P	Grup Data     N.Fis         Ser Vended Nome Vend.  Client Nome Cliente 		Tipo Produto         Descricao        UN Quantidade  Valor Unit.  Desc.It. Desc.Proproc.  Acrescimo  Valor Rec.          Valor Icms
	E   Grou Date     Invoice       Ser Ass.   Name Cust.  Custo. Name              Type Product         Description      UN Qtty        Unit Vlr.    It.Descr Prop.Desc.     Item Incr. Receiv. Value    Tax  Value    CP. Fi OL
	S   Grup Fecha    Factura       Ser Vend.  Nom. Vend.  Client Nom. Cliente      Tipo Producto        Descripcion      UN Canti.      Vlr Unit.    Desc.It. Desc.Prop.     Acres.Item Valor Recibido   Impuestos     CP. Sc OL
	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	0		  1			2 	   	  3		    4 		  5			6		  7 	    8	      9			0 		  1			2	 	  3 		4		  5			6 		  7			8		  9 		0		  1			2 		  3
	0																									100																									200
	/*/
	@ li,000 PSay SubStr(GRUPO,1,5)
	@ li,005 PSay DTEMI
	@ li,014 PSay SubStr(N_FISCAL,1,TamSx3("L1_DOC")[1])
	@ li,028 PSay SubStr(SERIE,1,3)
	@ li,032 PSay Substr(VENDED,1,6)
	@ li,039 PSay Substr(NOME,1,11)
	@ li,051 PSay Substr(CLIENTE,1,6)
	@ li,058 PSay Substr(NOM_CLI,1,17)
	@ li,076 PSay Substr(TIPO,1,4)
	@ li,081 PSay Substr(PROD,1,15)
	@ li,097 PSay Substr(DESCRI,1,15)
	
elseif nOrdem = 6
	/*/
	P	Client Nome Cliente		 Tip Data     NF            Ser Vended Nome Vend.  Grupo Produto         Descricao        UN Quantidade  Valor Unit.  Desc.It. Desc.Proproc.  Acrescimo  Valor Rec.          Valor Icms
	E   Client Customer Name     Typ Date     Invoice       Ser Ass.   Name        Group Product         Description      UN Qtty        Unit Vlr.    It.Descr Prop.Desc.     Item Incr. Receiv. Value    Tax  Value    CP. Fi OL
	S   Client Nom. Cliente      Tip Fecha    Factura       Ser Vend.  Nom. Vend.  Grupo Producto        Descripcion      UN Canti.      Vlr Unit.    Desc.It. Desc.Prop.     Acres.Item Valor Recibido   Impuestos     CP. Sc OL
	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	0		  1			2 	   	  3		    4 		  5			6		  7 	    8	      9			0 		  1			2	 	  3 		4		  5			6 		  7			8		  9 		0		  1			2 		  3
	0																									100																									200
	/*/
	@ li,000 PSay SubStr(CLIENTE,1,6)
	@ li,007 PSay SubStr(NOM_CLI,1,17)
	@ li,025 PSay Substr(TIPO,1,4)
	@ li,029 PSay DTEMI
	@ li,038 PSay SubStr(N_FISCAL,1,TamSx3("L1_DOC")[1])
	@ li,052 PSay Substr(SERIE,1,3)
	@ li,056 PSay Substr(VENDED,1,6)
	@ li,063 PSay Substr(NOME,1,11)
	@ li,075 PSay Substr(GRUPO,1,5)
	@ li,081 PSay Substr(PROD,1,15)
	@ li,097 PSay Substr(DESCRI,1,15)
	
elseif nOrdem = 7
	/*/
	P	Caixa Nome Cliente      Tipo Data     NF            Ser Vended Nome Vend.  Grupo Produto         Descricao        UN Quantidade  Valor Unit.  Desc.It. Desc.Proproc.  Acrescimo  Valor Rec.          Valor Icms
	E   Cash  Customer Name     Type Date     Invoice       Ser Ass.   Name        Group Product         Description      UN Qtty        Unit Vlr.    It.Desc. Prop.Desc.     Item Incr. Receiv. Value    Tax  Value    CP. Fi OL
	S   Caja  Nom. Cliente      Tipo Fecha    Factura       Ser Vend.  Nom. Vend.  Grupo Producto        Descripcion      UN Canti.      Vlr Unit.    Desc.It. Desc.Prop.     Acres.Ite. Valor Recibido   Impuestos     CP. Sc OL
	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	0		  1			2 	   	  3		    4 		  5			6		  7 	    8	      9			0 		  1			2	 	  3 		4		  5			6 		  7			8		  9 		0		  1			2 		  3
	0																									100																									200
	/*/
	@ li,000 PSay Substr(CAIXA,1,3)
	@ li,006 PSay SubStr(NOM_CLI,1,17)
	@ li,024 PSay Substr(TIPO,1,4)
	@ li,029 PSay DTEMI
	@ li,038 PSay SubStr(N_FISCAL,1,TamSx3("L1_DOC")[1])
	@ li,052 PSay Substr(SERIE,1,3)
	@ li,056 PSay Substr(VENDED,1,6)
	@ li,063 PSay Substr(NOME,1,11)
	@ li,075 PSay Substr(GRUPO,1,5)
	@ li,081 PSay Substr(PROD,1,15)
	@ li,097 PSay Substr(DESCRI,1,15)
	
EndIf
@ li,114 PSay Substr(UNIDA,1,2)
@ li,117 PSay QUANT		Picture PesqPictQt("L2_QUANT",10)
@ li,129 PSay UNIT		Picture PesqPict("SL2","L2_VRUNIT",13,Mv_Par20)
@ li,142 PSay DESCON	Picture PesqPict("SL2","L2_VALDESC",10,Mv_Par20)
@ li,151 PSay DESCTOT	Picture PesqPict("SL2","L2_DESCPRO",10,Mv_Par20)
@ li,166 PSay ACRES		Picture PesqPict("SL2","L2_VLRITEM",12,Mv_Par20)
@ li,179 PSay TOTAL		Picture PesqPict("SL2","L2_VLRITEM",12,Mv_Par20)
If cPaisLoc == "BRA"
	@ li,197 PSay ICMS		Picture PesqPict("SL2","L2_VALICM",10)
Else
	@ li,194 PSay IMPOSTOS	Picture PesqPict("SL2","L2_VALIMP1",12,Mv_Par20)
	@ li,208 PSay TIPOIMP
Endif
@ li,212 PSay Substr(COND,1,3)
@ li,216 PSay Substr(FILIAL,1,2)
@ li,219 PSay OL
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ LJR072STD ³ Autor ³ Lucas                ³ Data ³ 07.06.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime SubTotais de Devoluções...                          ³±±
±±³          ³condicao de ordem                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ LJR072STD(ExpN1,ExpN2,ExpN3,ExpChar1,ExpChar2)             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³Uso       ³ LOJR072                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function LJR072STD(nDDescItem,nDDescProp,nDAcresItem,nDValorRec,nDValIcms,nOrdem,cParam,nDQuant)
Local aArea     := GetArea()
LOCAL cPicQuant := ""

If TamSX3( "L2_QUANT" )[2] > 0
	cPicQuant := "@E " + REPLICATE("9", TamSX3( "L2_QUANT" )[1]+2) + "." + ;
	REPLICATE("9", TamSX3( "L2_QUANT" )[2])
Else
	cPicQuant := "@E " + REPLICATE("9", TamSX3( "L2_QUANT" )[1]+2)
EndIf

LJR072Quebra( nOrdem, cParam )
@li,112 PSay nDQuant   		Picture cPicQuant
@li,142 PSay nDDescItem	  	Picture PesqPict("SL2","L2_VALDESC",10,Mv_Par20)
@li,151 PSay nDDescProp  	Picture PesqPict("SL2","L2_DESCPRO",10,Mv_Par20)
@li,166 PSay nDAcresItem 	Picture PesqPict("SL2","L2_VLRITEM",12,Mv_Par20)
@li,179 PSay nDValorRec  	Picture PesqPict("SL2","L2_VLRITEM",12,Mv_Par20)
@li,194 PSay nDValIcms   	Picture PesqPict("SL2","L2_VALICM",12)
li++
RestArea( aArea )
Return( Nil )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ LJR072ST ³ Autor ³ Lucas                 ³ Data ³ 06.06.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprimir SubTotais do Relatório...                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ LJR072ST(ExpN1,ExpN2,ExpN3,ExpChar1,ExpChar2)              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Lojr072.prw                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function LJR072ST(nDescItem,nDescProp,nAcresItem,nValorRec,nValIcms,nOrdem,cParam,nQuant)

Local aArea     := GetArea()
Local cPicQuant := ""

If TamSX3( "L2_QUANT" )[2] > 0
	cPicQuant := "@E " + REPLICATE("9", TamSX3( "L2_QUANT" )[1]+2) + "." + ;
	REPLICATE("9", TamSX3( "L2_QUANT" )[2])
Else
	cPicQuant := "@E " + REPLICATE("9", TamSX3( "L2_QUANT" )[1]+2)
EndIf

cParam:=Alltrim(cParam)

LJR072Quebra(nOrdem,cParam)
@ li,112 PSay nQuant		Picture cPicQuant
@ li,152 PSay nDescProp		Picture PesqPict("SL2","L2_DESCPRO",10,Mv_Par20)
@ li,167 PSay nAcresItem  	Picture PesqPict("SL2","L2_VLRITEM",12,Mv_Par20)
@ li,179 PSay nValorRec   	Picture PesqPict("SL2","L2_VLRITEM",12,Mv_Par20)
@ li,195 PSay nValIcms   	Picture PesqPict("SL2","L2_VALICM",12)
li++
RestArea(aArea)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ LJR072TotF ³ Autor ³ Lucas               ³ Data ³ 06.06.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprimir linha de Totais por Filial do Relatório...        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ LJR072TotF( ExpN1,ExpN2,ExpN3 )                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Lojr072.prw                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function LJR072TotF(nFilDescItem,nFilDescProp,nFilAcresItem,nFilValorRec,nFilValIcms,nDFilDescItem,nDFilDescProp,nDFilAcresItem,nDFilValorRec,nDFilValIcms,cFilAtu,nFilQuant,nDFilQuant)

LOCAL aArea     := GetArea()
LOCAL cPicQuant := ""

If TamSX3( "L2_QUANT" )[2] > 0
	cPicQuant := "@E " + REPLICATE("9", TamSX3( "L2_QUANT" )[1]+2) + "." + ;
	REPLICATE("9", TamSX3( "L2_QUANT" )[2])
Else
	cPicQuant := "@E " + REPLICATE("9", TamSX3( "L2_QUANT" )[1]+2)
EndIf

dbSelectArea( "SM0")
dbSetOrder(1)
dbSeek(cEmpAnt + cFilAtu )

li++
// T O T A L	F I L I A L ---->
@li,000 PSay STR0035 + FWGETCODFILIAL + " " + SM0->M0_NOME
@li,112 PSay nFilQuant     -  nDFilQuant      Picture cPicQuant
@li,142 PSay nFilDescItem  -  nDFilDescItem   Picture PesqPict("SL2","L2_VALDESC",10,Mv_Par20)
@li,151 PSay nFilDescProp  -  nDFilDescProp   Picture PesqPict("SL2","L2_DESCPRO",10,Mv_Par20)
@li,166 PSay nFilAcresItem -  nDFilAcresItem  Picture PesqPict("SL2","L2_VLRITEM",12,Mv_Par20)
@li,179 PSay nFilValorRec  -  nDFilValorRec   Picture PesqPict("SL2","L2_VLRITEM",12,Mv_Par20)
@li,194 PSay nFilValIcms   -  nDFilValIcms    Picture PesqPict("SL2","L2_VALICM",12)
@li+1,00 PSay ""
li++
RestArea( aArea )
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ LJR072Tot  ³ Autor ³ Lucas               ³ Data ³ 06.06.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprimir linha de Totais do Relatório...                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ LJR072Tot( ExpN1,ExpN2,ExpN3 )                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Lojr072.prw                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function LJR072Tot(nGerDescItem,nGerDescProp,nGerAcresItem,nGerValorRec,nGerValIcms,nDGerDescItem,nDGerDescProp,nDGerAcresItem,nDGerValorRec,nDGerValIcms,nGerQuant,nDGerQuant)

LOCAL cPicQuant := ""

If TamSX3( "L2_QUANT" )[2] > 0
	cPicQuant := "@E " + REPLICATE("9", TamSX3( "L2_QUANT" )[1]+2) + "." + ;
	REPLICATE("9", TamSX3( "L2_QUANT" )[2])
Else
	cPicQuant := "@E " + REPLICATE("9", TamSX3( "L2_QUANT" )[1]+2)
EndIf

li++
@ li,000 PSay STR0031					// T O T A L	G E R A L ---->
@ li,112 PSay nGerQuant    - nDGerQuant   	 Picture cPicQuant
@ li,142 PSay nGerDescItem - nDGerDescItem	 Picture PesqPict("SL2","L2_VALDESC",10,Mv_Par20)
@ li,151 PSay nGerDescProp - nDGerDescProp  Picture PesqPict("SL2","L2_DESCPRO",10,Mv_Par20)
@ li,166 PSay nGerAcresItem- nDGerAcresItem Picture PesqPict("SL2","L2_VLRITEM",12,Mv_Par20)
@ li,179 PSay nGerValorRec - nDGerValorRec  Picture PesqPict("SL2","L2_VLRITEM",12,Mv_Par20)
@ li,194 PSay nGerValIcms  - nDGerValIcms   Picture PesqPict("SL2","L2_VALICM",12)
@ li+1,00 PSay ""
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ LJR072Quebra ³ Autor ³ Lucas             ³ Data ³ 06.06.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprimir Subtotais cuando existe Quebras...                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ LJR072Quebra( ExpN1,ExpN2,ExpN3 )                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Lojr072.prw                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function LJR072Quebra( nOrdem, cParam )

LOCAL cFil

li++
If nOrdem = 1				// Data
	// S U B - T O T A L	---->
	@ li,000 PSay STR0030
	@ li,026 Psay Substr(cParam,7 + FWGETTAMFILIAL,2)+"/"+Substr(cParam,5 + FWGETTAMFILIAL,2)+"/"+Substr(cParam,3 + FWGETTAMFILIAL,2)
	
Elseif nOrdem = 2			// Vendedor
	// S U B - T O T A L	---->
	dbSelectArea("SA3")
	cFil := IIF( EMPTY( xFilial("SA3") ), xFilial("SA3"), Substr( cParam, 1, FWGETTAMFILIAL) )
	dbSeek( cFil + Substr( cParam, 2 + FWGETTAMFILIAL, 6 ) )
	@ li,000 PSay STR0030 + " "+Substr(cParam,2 + FWGETTAMFILIAL,6) +" - "+SA3->A3_NREDUZ
	
Elseif nOrdem = 4 .Or. nOrdem = 5		// Grupo ou Tipo
	If nOrdem == 5		//Grupo
		DBSelectArea("SBM")
		cFil := IIF( EMPTY( xFilial("SBM") ), xFilial("SBM"), Substr( cParam, 1, FWGETTAMFILIAL) )
		DBSeek( cFil + Alltrim( Substr( cParam, 1 + FWGETTAMFILIAL, 4 ) ) )
		@ li,000 PSay STR0030 + " "+ Alltrim(Substr(cParam,1 + FWGETTAMFILIAL,4)) +If( ! Empty( SubStr(cParam,1 + FWGETTAMFILIAL,4) ),;
		" - "+Capital(SBM->BM_DESC), "")
	Else
		DBSelectArea("SX5")
		cFil := IIF( EMPTY( xFilial("SX5") ), xFilial("SX5"), Substr( cParam, 1, FWGETTAMFILIAL) )
		DBSeek( cFil + "02" + Alltrim( Substr( cParam, 1 + FWGETTAMFILIAL, 2 ) ) )
		@ li,000 PSay STR0030 + " "+ Alltrim(Substr(cParam,1 + FWGETTAMFILIAL,2)) +" - "+Capital(SX5->X5_DESCRI)
	Endif
Elseif nOrdem = 3								// Produto
	// S U B - T O T A L	---->
	dbSelectArea("SB1")
	cFil := IIF( EMPTY( xFilial("SB1") ), xFilial("SB1"), Substr(cParam,1,FWGETTAMFILIAL) )
	dbSeek( cFil + Substr( cParam, 2 + FWGETTAMFILIAL, 15 ) )
	@ li,000 PSay STR0030 + " "+ AllTrim(Substr(cParam,2 + FWGETTAMFILIAL,15)) +" - "+SB1->B1_DESC
	
Elseif nOrdem = 6							// Cliente
	// S U B - T O T A L	---->
	dbSelectArea("SA1")
	cFil := IIF( EMPTY( xFilial("SA1") ), xFilial("SA1"), Substr(cParam,1,FWGETTAMFILIAL) )
	dbSeek( cFil + Substr( cParam, 1 + FWGETTAMFILIAL, 6 ) )
	@ li,000 PSay STR0030 + " "+Substr(cParam,1 + FWGETTAMFILIAL,6) +" - "+SA1->A1_NREDUZ
	
Elseif nOrdem = 7							// Caixa
	dbSelectArea("SA6")
	cFil := IIF( EMPTY( xFilial("SA6") ), xFilial("SA6"), Substr(cParam,1,FWGETTAMFILIAL) )
	dbSeek( cFil + AllTrim( Substr( cParam, 1 + FWGETTAMFILIAL, 3 ) ) )
	// S U B - T O T A L	---->
	@ li,000 PSay STR0030 + " "+Substr(cParam,1 + FWGETTAMFILIAL,3) +" - "+SA6->A6_NREDUZ
Endif
Return( Nil )

#IFDEF TOP
	/*
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Funcao    ³ MsSql2Trb ³ Autor ³ Lucas                 ³ Data ³ 06/06/02 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descri‡…o ³ Cria arquivo temporario a partir de uma Query               ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Sintaxe	 ³ MsSql2Trb( ExpC1,ExpA2,ExpC3)  									   ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Parametros³ ExpC1 = Query a ser processada                              ³±±
	±±³          ³ ExpA2 = Array com estrutura do arquivo temporario           ³±±
	±±³          ³ ExpC3 = Nome do alias para o arquivo temporario             ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Uso       ³ Gen‚rico / TOPCONNECT                                       ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
	*/
	Static Function MsSql2Trb(cQuery, aStruTmp, cAliasTmp)
	Local nI, nJ, nF, nTotalRec
	
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), "TMP", .F., .T.)
	
	For nJ := 1 to Len(aStruTmp)
		If aStruTmp[nJ,2] != 'C'
			TCSetField("TMP", aStruTmp[nJ,1], aStruTmp[nJ,2],aStruTmp[nJ,3],aStruTmp[nJ,4])
		EndIf
	Next nJ
	
	nTotalRec := TMP->(RecCount())
	
	nF := (cAliasTMP)->(Fcount())
	
	TMP->(DbGoTop())
	
	ProcRegua( nTotalRec )
	
	Do While ! TMP->(Eof())
		IncProc()
		(cAliasTmp)->(DbAppend())
		For nI := 1 To nF
			(cAliasTmp)->(FieldPut(nI ,TMP->(FieldGet( TMP->(FieldPos( (cAliasTmp)->( FieldName( nI ))))))))
		Next nI
		TMP->(DbSkip())
	EndDo
	TMP->(dbCloseArea())
	DbSelectArea(cAliasTmp)
	Return
#ENDIF