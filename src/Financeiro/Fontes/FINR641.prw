/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "protheus.ch"
#include "finr641.ch"
                                                         
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFINR641   บ Autor ณ Totvs	             บ Data ณ  06/05/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de conferencia rateio financeiro.                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿/*/

User Function FINR641()
     
Local cPerg := "FINR641"
Local aHelpPor 	:= {}
Local aHelpEng 	:= {}
Local aHelpSpa 	:= {}
Local aRegs		:= {}

Aadd( aHelpPor, "Informe a Numero da Solicita็ใo Inicial" )
Aadd( aHelpPor, "que deseja imprimir" )
Aadd( aHelpEng, "" )
Aadd( aHelpSpa, "" ) 
aAdd(aRegs,{cPerg,'01','Num.Solicita็ใo Inicial?',"Num.Solicita็ใo Inicial?",'Num.Solicita็ใo Inicial?','mv_ch1','C' ,06  	,0      ,0    ,'G' ,  ,'mv_par01', "" ,""	  ,""  ,""   ,""    ,""     ,""    	 ,"" 	  ,""	  ,""    ,""      ,""   	,""      ,""	 ,""	,""		 ,""  		,""  	,""	 	,""		 ,""	 ,""  	   ,""		 ,""	,''	,"","",aHelpPor,aHelpEng,aHelpSPA	 })

aHelpPor 	:= {}
aHelpEng 	:= {}
aHelpSpa 	:= {}
Aadd( aHelpPor, "Informe a Numero da Solicita็ใo Final" )
Aadd( aHelpPor, "que deseja imprimir" )
Aadd( aHelpEng, "" )
Aadd( aHelpSpa, "" ) 
aAdd(aRegs,{cPerg,'02','Num.Solicita็ใo Final?',"Num.Solicita็ใo Final?",'Num.Solicita็ใo Final?','mv_ch2','C' ,06  	,0      ,0    ,'G' ,  ,'mv_par02', "" ,""	  ,""  ,""   ,""    ,""     ,""    	 ,"" 	  ,""	  ,""    ,""      ,""   	,""      ,""	 ,""	,""		 ,""  		,""  	,""	 	,""		 ,""	 ,""  	   ,""		 ,""	,''	,"","",aHelpPor,aHelpEng,aHelpSPA	 })

aHelpPor 	:= {}
aHelpEng 	:= {}
aHelpSpa 	:= {}
Aadd( aHelpPor, "Informe a Data Inicial da Solicita็ใo " )
Aadd( aHelpPor, "que deseja imprimir" )
Aadd( aHelpEng, "" )
Aadd( aHelpSpa, "" ) 
aAdd(aRegs,{cPerg,'03','Data Inicial?',"Data Inicial?",'Data Inicial?','mv_ch3','D' ,08  	,0      ,0    ,'G' ,  ,'mv_par03', "" ,""	  ,""  ,""   ,""    ,""     ,""    	 ,"" 	  ,""	  ,""    ,""      ,""   	,""      ,""	 ,""	,""		 ,""  		,""  	,""	 	,""		 ,""	 ,""  	   ,""		 ,""	,''	,"","",aHelpPor,aHelpEng,aHelpSPA	 })

aHelpPor 	:= {}
aHelpEng 	:= {}
aHelpSpa 	:= {}
Aadd( aHelpPor, "Informe a Data Inicial da Solicita็ใo " )
Aadd( aHelpPor, "que deseja imprimir" )
Aadd( aHelpEng, "" )
Aadd( aHelpSpa, "" ) 
aAdd(aRegs,{cPerg,'04','Data Final?','Data Final?','Data Final?','mv_ch4','D' ,08  	,0      ,0    ,'G' ,  ,'mv_par04', "" ,""	  ,""  ,""   ,""    ,""     ,""    	 ,"" 	  ,""	  ,""    ,""      ,""   	,""      ,""	 ,""	,""		 ,""  		,""  	,""	 	,""		 ,""	 ,""  	   ,""		 ,""	,''	,"","",aHelpPor,aHelpEng,aHelpSPA	 })

ValidPerg(aRegs,cPerg,.F.)

If Pergunte(cPerg,.T.)
	U_FINRL641(MV_PAR01,MV_PAR02,MV_PAR03,MV_PAR04)
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FINRL641 บ Autor ณ Totvs	             บ Data ณ  06/05/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de conferencia de rateio financeiro.             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿/*/

User Function FINRL641(cPar1,cPar2,dPar3,dPar4,cTabela)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู      
Local aArea			:= GetArea()
Local cDesc1        := STR0001 //"Este programa tem como objetivo imprimir relatorio "
Local cDesc2        := STR0002 //"de acordo com os parametros informados pelo usuario."
Local cDesc3        := STR0003 //"Conferencia de Rateio Financeiro"
Local cPict         := ""
Local titulo       	:= STR0004 //"Conferencia de Rateio Financeiro"
Local nLin         	:= 80
Local Cabec1 		:= STR0005 //" Titulo              Situa็ใo   Entidade  Nome Entidade                             Emissao    Vencimento             Valor "
Local Cabec2 		:= ""
Local aOrd 			:= {}
Local cQuery		:= ""

        
If AllTrim(cPar1) $ "SC1/SC7/SF1"     

	U_FINRZ641(cPar1,cPar2)
	Return
ElseIF "SE1" $ AllTrim(cPar2)
	cPar2 		:= cPar1
ElseIf "SE2" $ AllTrim(cPar2)
	cPar2 		:= cPar1
EndIf                    

Default cTabela     := ""
Default cPar2 		:= cPar1
Default dPar3 		:= cToD("  /  /  ")
Default dPar4 		:= cToD("31/12/49")

Private lEnd        := .F.
Private lAbortPrint := .F.
Private CbTxt       := ""
Private limite      := 132
Private tamanho     := "M"
Private nomeprog    := "FINR641" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo       := 18
Private aReturn     := { STR0006, 1, STR0007, 2, 2, 1, "", 1} //"Zebrado"###"Administracao"
Private nLastKey    := 0
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private wnrel       := "FINR641" // Coloque aqui o nome do arquivo usado para impressao em disco

Private cString 	:= "TMPREL"
                             
                                         
if !Empty(cTabela)  //fun็ใo chamada pelo menu do FINA641 (apos visualizar um titulo e acessar  "Rat.Financeiro")
	Select(cTabela)

	if cTabela == "SE1"
		dPar3 := SE1->E1_EMISSAO
		dPar4 := SE1->E1_EMISSAO
	EndIf                         

	if cTabela == "SE2"
		dPar3 := SE2->E2_EMISSAO
		dPar4 := SE2->E2_EMISSAO
	EndIf
EndIf

cQuery := "SELECT SE6.* FROM "+RetSqlName("SE6")+" SE6 "    
cQuery += "WHERE SE6.E6_NUMSOL BETWEEN '"+cPar1+"' AND '"+cPar2+"' "
cQuery += "AND SE6.E6_DATSOL BETWEEN '"+dToS(dPar3)+"' AND '"+dToS(dPar4)+"' "
cQuery += "AND D_E_L_E_T_ = ' ' "
cQuery += "ORDER BY SE6.E6_NUMSOL"
                               
cQuery := ChangeQuery( cQuery )  



dbUseArea( .t., "TOPCONN", Tcgenqry( , , cQuery ), "TMPREL", .F., .T. )
TMPREL->(dbGoTop())

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

dbSelectArea("TMPREL")
DbCloseArea()
                                
RestArea(aArea)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ Totvs	             บ Data ณ  06/05/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                                                               

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nVlrOri	:= 0
Local nVlrDif	:= 0
Local nVlrDes	:= 0
Local cFilOld	:= cFilAnt
Local cQryE     := "", nRecno := 0, cTab2Tmp := "SE2TMP", cTab1Tmp := "SE1TMP"



dbSelectArea("TMPREL")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
SetRegua(RecCount())

dbGoTop()

cFilAnt 	:= TMPREL->E6_FILORIG
cSolAnt		:= TMPREL->E6_NUMSOL
lPrimeiro	:= .T.
nVlrOri		:= 0
nVlrDif		:= 0
nVlrDes		:= 0

While !EOF()
   	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
   	//ณ Verifica o cancelamento pelo usuario...                             ณ
   	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
   	If lAbortPrint
    	@nLin,00 PSAY STR0008 //"*** CANCELADO PELO OPERADOR ***"
    	Exit
   	Endif

	If TMPREL->E6_NUMSOL <> cSolAnt
   		nLin := nLin + 1
		@ nLin,00 PSay Replicate('-',130)
   		nLin := nLin + 1
   		@ nLin,00 PSAY STR0009 //"Resultado"
   		@ nLin,110 PSAY nVlrDif  Picture "@E 999,999,999.99"
		nLin := nLin + 1
		@ nLin,00 PSay Replicate('=',130)
   		nLin := nLin + 2

		nVlrDif		:= 0
        nVlrOri		:= 0
        nVrlDes		:= 0
        
		lPrimeiro	:= .T.
		cSolAnt 	:= TMPREL->E6_NUMSOL
	    
	EndIf
	   	
	If lPrimeiro
		      
		lPrimeiro := .F.	
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Impressao do cabecalho do relatorio. . .                            ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
		If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		Endif
	
	   	@ nLin,00 PSAY STR0010 + TMPREL->E6_NUMSOL //"Solicita็ใo:      "
	   	nLin++
	   	nLin++
	
		// Imprime titulo principal
		If TMPREL->E6_TIPOPER == "D"
			If TMPREL->E6_TIPOSOL == "P"
				  
				cQryE := "SELECT SE2.R_E_C_N_O_ RETORNO, SE2.E2_FILIAL, SE2.E2_NUMSOL, SE2.E2_PREFIXO, SE2.E2_NUM, SE2.E2_PARCELA, SE2.E2_TIPO, SE2.E2_FILORIG  FROM "+ RetSqlName("SE2") +" SE2  WHERE SE2.E2_NUMSOL = '" + TMPREL->(E6_NUMSOL) + "' AND SE2.D_E_L_E_T_ = ' '  AND SE2.E2_FILORIG = '" + TMPREL->(E6_FILORIG) + "' "
				cQryE := ChangeQuery( cQryE ) 
				dbUseArea( .T., "TOPCONN", Tcgenqry( , , cQryE ), cTab2Tmp, .F., .T. )        

				nRecno := 0
				If  (cTab2Tmp)->(!Eof()) 
                	nRecno := (cTab2Tmp)->RETORNO 
       		    End 
            
				(cTab2Tmp)->(dbCloseArea())                      
			     

				dbSelectArea("SE2")
				dbSetOrder(1)	//E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA	   
				dbGoTo(nRecno)
					
				If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif
				//Titulo  Situa็ใo  Entidade  Nome Entidade  Emissao  Vencimento  Valor
			   	@ nLin,00 	PSAY STR0011 //"Titulo de Origem"
			   	nLin++
			   	@ nLin,00 	PSAY SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO)
				If ROUND(SE2->E2_SALDO,2) + ROUND(SE2->E2_SDACRES,2)  = 0
					cSitua็ใo := STR0012 //"Baixado"
				Else
					cSituacao := STR0013 //"Em Aberto"
				EndIf			
				IF !Empty(GetMv("MV_APRPAG")) .or. GetMv("MV_CTLIPAG")           
					If EMPTY(SE2->E2_DATALIB) .AND. (SE2->E2_SALDO+SE2->E2_SDACRES-SE2->E2_SDDECRE) > GetMV("MV_VLMINPG") .AND. SE2->E2_SALDO > 0
						cSitua็ใo := STR0014 //"Bloqueado"
					EndIf 
				EndIf
			   	@ nLin,21 	PSAY cSituacao
			   	@ nLin,32 	PSAY SE2->E2_FORNECE+SE2->E2_LOJA
			   	@ nLin,42 	PSAY Posicione("SA2",1,xFilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA,"A2_NOME")
			   	@ nLin,84	PSAY SE2->E2_EMISSAO
			   	@ nLin,95 	PSAY SE2->E2_VENCREA
			   	@ nLin,110 	PSAY SE2->E2_VALOR  Picture "@E 999,999,999.99"
			   	nLin++
				nVlrOri += SE2->E2_VALOR
				nVlrDif	+= SE2->E2_VALOR
				
				cChave := "SE2"+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA
				dbSelectArea("FRZ")
				dbSetOrder(2) 	//FRZ_FILIAL+FRZ_CHAVE+FRZ_SEQUEN
				dbSeek(TMPREL->E6_FILORIG+SubStr(cChave+Space(TamSX3("FRZ_CHAVE")[1]),1,TamSX3("FRZ_CHAVE")[1]))			
				cFornece := ""
				cCliente := ""
				While !Eof() .and. FRZ->FRZ_CHAVE == SubStr(cChave+Space(TamSX3("FRZ_CHAVE")[1]),1,TamSX3("FRZ_CHAVE")[1])
					If FRZ->FRZ_TPENT $ "2"
						cFornece += FRZ->FRZ_FORNEC+"/"
						cCliente += FRZ->FRZ_CLIENT+"/"
					EndIf
					dbSkip()
				EndDo
				
				dbSelectArea("SE1")
				dbSetOrder(1)	//E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
				dbSeek(xFilial("SE1")+TMPREL->(E6_PREFIXO+E6_NUM+E6_PARCELA+E6_TIPO))
			   	@ nLin,00 	PSAY STR0015 //"Abatimentos Rateio"
			   	nLin++
				While !Eof() .and. SE1->(E1_PREFIXO+E1_NUM) == TMPREL->(E6_PREFIXO+E6_NUM)

					If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
						Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
						nLin := 9
					Endif

					If SE1->E1_CLIENTE $ cCliente
					   	@ nLin,00 	PSAY SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
						If ROUND(SE1->E1_SALDO,2) + ROUND(SE1->E1_SDACRES,2)  = 0
							cSitua็ใo := STR0012 //"Baixado"
						Else
							cSituacao := STR0013 //"Em Aberto"
						EndIf			
					   	@ nLin,21 	PSAY cSituacao
					   	@ nLin,32 	PSAY SE1->E1_CLIENTE+SE1->E1_LOJA
					   	@ nLin,42 	PSAY Posicione("SA1",1,xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA,"A1_NOME")
					   	@ nLin,84	PSAY SE1->E1_EMISSAO
					   	@ nLin,95 	PSAY SE1->E1_VENCREA
					   	@ nLin,110 	PSAY SE1->E1_VALOR  Picture "@E 999,999,999.99"
					   	nLin++
						nVlrOri -= SE1->E1_VALOR
					EndIf
					dbSelectArea("SE1")
					dbSkip()
				EndDo
				@ nLin,00 PSAY STR0016 + TMPREL->E6_FILORIG //"Total da Empresa/Filial: "
				@ nLin,110 PSAY nVlrOri  Picture "@E 999,999,999.99"
				nLin := nLin + 1
				
				nVlrDif -= nVlrOri
				
				@ nLin,00 	PSAY STR0017 //"Titulo(s) Distribuido(s)"
				nLin++
		    Else
			
				If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9                                                
				Endif
                
				cQryE := "SELECT SE1.R_E_C_N_O_, SE1.E1_FILIAL, SE1.E1_NUMSOL, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_FILORIG RETORNO FROM SE1010 SE1  WHERE SE1.E1_NUMSOL = '" + TMPREL->(E6_NUMSOL) + "' AND SE1.D_E_L_E_T_ = ' '   AND SE1.E1_FILORIG = '" + TMPREL->(E6_FILORIG) + "' "  				
			    cQryE := ChangeQuery( cQryE ) 
                
				dbUseArea( .T., "TOPCONN", Tcgenqry( , , cQryE ), cTab1Tmp, .F., .T. )        
			
				nRecno := 0         
				
				If  (cTab1Tmp)->(!Eof()) 
                	nRecno := (cTab1Tmp)->RETORNO
       		    End 
            
				(cTab1Tmp)->(dbCloseArea())                      
				
				dbSelectArea("SE1")
				dbSetOrder(1)		 
				dbGoTo(nRecno)  
				                
				//Titulo  Situa็ใo  Entidade  Nome Entidade  Emissao  Vencimento  Valor
			   	@ nLin,00 	PSAY STR0011 //"Titulo de Origem"
			   	nLin++
			   	@ nLin,00 	PSAY SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
				If ROUND(SE1->E1_SALDO,2) + ROUND(SE1->E1_SDACRES,2)  = 0
					cSitua็ใo := STR0012 //"Baixado"
				Else
					cSituacao := STR0013 //"Em Aberto"
				EndIf			
			   	@ nLin,21 	PSAY cSituacao
			   	@ nLin,32 	PSAY SE1->E1_CLIENTE+SE1->E1_LOJA
			   	@ nLin,42 	PSAY Posicione("SA1",1,xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA,"A1_NOME")
			   	@ nLin,84	PSAY SE1->E1_EMISSAO
			   	@ nLin,95 	PSAY SE1->E1_VENCREA
			   	@ nLin,110 	PSAY SE1->E1_VALOR  Picture "@E 999,999,999.99"
			   	nLin++
				nVlrOri += SE1->E1_VALOR
				nVlrDif	+= SE1->E1_VALOR
				
				cChave := "SE1"+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO+SE1->E1_CLIENTE+SE1->E1_LOJA
				dbSelectArea("FRY")
				dbSetOrder(2) 	//FRY_FILIAL+FRY_CHAVE+FRY_SEQUEN
				dbSeek(TMPREL->E6_FILORIG+SubStr(cChave+Space(TamSX3("FRY_CHAVE")[1]),1,TamSX3("FRY_CHAVE")[1]))			
				cFornece := ""
				cCliente := ""
				While !Eof() .and. FRY->FRY_CHAVE == SubStr(cChave+Space(TamSX3("FRY_CHAVE")[1]),1,TamSX3("FRY_CHAVE")[1])
					If FRY->FRY_TPENT $ "2"
						cFornece += FRY->FRY_FORNEC+"/"
						cCliente += FRY->FRY_CLIENT+"/"
					EndIf
					dbSkip()
				EndDo
				
				dbSelectArea("SE2")
				dbSetOrder(1)	//E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
				dbSeek(xFilial("SE2")+TMPREL->(E6_PREFIXO+E6_NUM+E6_PARCELA+E6_TIPO))
			   	@ nLin,00 	PSAY STR0015 //"Abatimentos Rateio"
			   	nLin++
				While !Eof() .and. SE2->(E2_PREFIXO+E2_NUM) == TMPREL->(E6_PREFIXO+E6_NUM)

					If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
						Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
						nLin := 9
					Endif

					If SE2->E2_FORNECE $ cFornece
					   	@ nLin,00 	PSAY SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO)
						If ROUND(SE2->E2_SALDO,2) + ROUND(SE2->E2_SDACRES,2)  = 0
							cSitua็ใo := STR0012 //"Baixado"
						Else
							cSituacao := STR0013 //"Em Aberto"
						EndIf			
						IF !Empty(GetMv("MV_APRPAG")) .or. GetMv("MV_CTLIPAG")           
							If EMPTY(SE2->E2_DATALIB) .AND. (SE2->E2_SALDO+SE2->E2_SDACRES-SE2->E2_SDDECRE) > GetMV("MV_VLMINPG") .AND. SE2->E2_SALDO > 0
								cSitua็ใo := STR0014 //"Bloqueado"
							EndIf 
						EndIf
					   	@ nLin,21 	PSAY cSituacao
					   	@ nLin,32 	PSAY SE2->E2_FORNECE+SE2->E2_LOJA
					   	@ nLin,42 	PSAY Posicione("SA2",1,xFilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA,"A2_NOME")
					   	@ nLin,84	PSAY SE2->E2_EMISSAO
					   	@ nLin,95 	PSAY SE2->E2_VENCREA
					   	@ nLin,110 	PSAY SE2->E2_VALOR  Picture "@E 999,999,999.99"
					   	nLin++
						nVlrOri -= SE2->E2_VALOR
					EndIf
					dbSelectArea("SE2")
					dbSkip()
				EndDo	
				@ nLin,00 PSAY STR0016 + TMPREL->E6_FILORIG //"Total da Empresa/Filial: "
				@ nLin,110 PSAY nVlrOri  Picture "@E 999,999,999.99"
				nLin++	

				nVlrDif -= nVlrOri

				@ nLin,00 	PSAY STR0017 //"Titulo(s) Distribuido(s)"
				nLin++	
			EndIf
		Else
		
		EndIf	
	
	Else
	
	EndIf
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
   	//ณ Impressao do cabecalho do relatorio. . .                            ณ
   	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

   	If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 9
   	Endif

	If TMPREL->E6_TIPOPER == "D"
		If TMPREL->E6_TIPOSOL == "P"
			dbSelectArea("SE2")
			dbSetOrder(1)	//E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA	 
			dbSeek(TMPREL->E6_FILIAL+TMPREL->E6_PREFIXO+TMPREL->E6_NUM+TMPREL->E6_PARCELA+TMPREL->E6_TIPO)
			//Titulo  Situa็ใo  Entidade  Nome Entidade  Emissao  Vencimento  Valor
			While !Eof() .and. SE2->(E2_PREFIXO+E2_NUM) == TMPREL->(E6_PREFIXO+E6_NUM)

				If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif

				If SE2->E2_FORNECE $ cFornece
					@ nLin,00 	PSAY SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO)
					If ROUND(SE2->E2_SALDO,2) + ROUND(SE2->E2_SDACRES,2)  = 0
						cSitua็ใo := STR0012 //"Baixado"
					Else
						cSituacao := STR0013 //"Em Aberto"
					EndIf			
					IF !Empty(GetMv("MV_APRPAG")) .or. GetMv("MV_CTLIPAG")           
						If EMPTY(SE2->E2_DATALIB) .AND. (SE2->E2_SALDO+SE2->E2_SDACRES-SE2->E2_SDDECRE) > GetMV("MV_VLMINPG") .AND. SE2->E2_SALDO > 0
							cSitua็ใo := STR0014 //"Bloqueado"
						EndIf 
					EndIf

				   	@ nLin,21 	PSAY cSituacao
				   	@ nLin,32 	PSAY SE2->E2_FORNECE+SE2->E2_LOJA
				   	@ nLin,42 	PSAY Posicione("SA2",1,xFilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA,"A2_NOME")
				   	@ nLin,84	PSAY SE2->E2_EMISSAO
				   	@ nLin,95 	PSAY SE2->E2_VENCREA
				   	@ nLin,110 	PSAY SE2->E2_VALOR  Picture "@E 999,999,999.99"
				   	nLin++
					nVlrDif -= SE2->E2_VALOR
                	Exit
                EndIf
        		DbSkip()
			EndDo
			@ nLin,00 PSAY STR0016 + TMPREL->E6_FILIAL //"Total da Empresa/Filial: "
			@ nLin,110 PSAY SE2->E2_VALOR  Picture "@E 999,999,999.99"
		   	nLin++
		Else
			dbSelectArea("SE1")
			dbSetOrder(1)	//E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA	 
			dbSeek(TMPREL->E6_FILIAL+TMPREL->E6_PREFIXO+TMPREL->E6_NUM+TMPREL->E6_PARCELA+TMPREL->E6_TIPO)
			//Titulo  Situa็ใo  Entidade  Nome Entidade  Emissao  Vencimento  Valor
			While !Eof() .and. SE1->(E1_PREFIXO+E1_NUM) == TMPREL->(E6_PREFIXO+E6_NUM)

				If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif
		
				If SE1->E1_CLIENTE $ cCliente
					@ nLin,00 	PSAY SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
					If ROUND(SE1->E1_SALDO,2) + ROUND(SE1->E1_SDACRES,2)  = 0
						cSitua็ใo := STR0012 //"Baixado"
					Else
						cSituacao := STR0013 //"Em Aberto"
					EndIf			

				   	@ nLin,21 	PSAY cSituacao
				   	@ nLin,32 	PSAY SE1->E1_CLIENTE+SE1->E1_LOJA
				   	@ nLin,42 	PSAY Posicione("SA1",1,xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA,"A1_NOME")
				   	@ nLin,84	PSAY SE1->E1_EMISSAO
				   	@ nLin,95 	PSAY SE1->E1_VENCREA
				   	@ nLin,110 	PSAY SE1->E1_VALOR  Picture "@E 999,999,999.99"
				   	nLin++
					nVlrDes += SE1->E1_VALOR
					nVlrDif -= SE1->E1_VALOR
                  	Exit
                EndIf
        		DbSkip()
			EndDo
			@ nLin,00 PSAY STR0016 + TMPREL->E6_FILIAL //"Total da Empresa/Filial: "
			@ nLin,110 PSAY SE1->E1_VALOR  Picture "@E 999,999,999.99"
		   	nLin++
		EndIf
	Else
	EndIf
		
   	dbSelectArea("TMPREL")
   	dbSkip()



EndDo

nLin := nLin + 1
@ nLin,00 PSay Replicate('-',130)
nLin := nLin + 1
@ nLin,00 PSAY STR0009 //"Resultado"
@ nLin,110 PSAY nVlrDif  Picture "@E 999,999,999.99"
nLin := nLin + 1
@ nLin,00 PSay Replicate('=',130)
nLin := nLin + 2
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SET DEVICE TO SCREEN

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

cFilAnt	:= cFilOld

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FINRZ641 บ Autor ณ Totvs		         บ Data ณ  06/05/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de conferencia de rateio financeiro.             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿/*/

User Function FINRZ641(cPar1,cPar2)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู      
Local aArea			:= GetArea()
Local cDesc1        := STR0001 //"Este programa tem como objetivo imprimir relatorio "
Local cDesc2        := STR0002 //"de acordo com os parametros informados pelo usuario."
Local cDesc3        := STR0003 //"Conferencia de Rateio Financeiro"
Local cPict         := ""
Local titulo       	:= STR0004 //"Conferencia de Rateio Financeiro"
Local nLin         	:= 80
Local Cabec1 		:= STR0018 //" Descri็ใo                               Tipo     Emp/Fil   Perc. Cliente                                   Fornecedor "
Local Cabec2 		:= ""
Local aOrd 			:= {}
Local cQuery		:= ""

Private lEnd        := .F.
Private lAbortPrint := .F.
Private CbTxt       := ""
Private limite      := 132
Private tamanho     := "M"
Private nomeprog    := "FINR641" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo       := 18
Private aReturn     := { STR0006, 1, STR0007, 2, 2, 1, "", 1} //"Zebrado"###"Administracao"
Private nLastKey    := 0
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private wnrel       := "FINR641" // Coloque aqui o nome do arquivo usado para impressao em disco

Private cString 	:= AllTrim(cPar1)
Private cChave 		:= cPar2

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

RptStatus({|| RunReport1(Cabec1,Cabec2,Titulo,nLin) },Titulo)
                                
RestArea(aArea)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ Totvs	             บ Data ณ  06/05/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunReport1(Cabec1,Cabec2,Titulo,nLin)

dbSelectArea("FRZ")
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
SetRegua(RecCount())

dbSelectArea("FRZ")
dbSetOrder(2)
dbSeek(xFilial("FRZ")+cChave)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Impressao do cabecalho do relatorio. . .                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
   Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
   nLin := 9
Endif

@ nLin,00 PSAY STR0019 + cChave //"Documento:      "
nLin++
nLin++

While !EOF() .and. AllTrim(FRZ->FRZ_CHAVE) == cChave
   	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
   	//ณ Verifica o cancelamento pelo usuario...                             ณ
   	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
   	If lAbortPrint
    	@nLin,00 PSAY STR0008 //"*** CANCELADO PELO OPERADOR ***"
    	Exit
   	Endif

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
   	//ณ Impressao do cabecalho do relatorio. . .                            ณ
   	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

   	If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 9
   	Endif

	@ nLin,00 	PSAY FRZ->FRZ_DESC
	@ nLin,42 	PSAY If(FRZ->FRZ_TPENT=="1",STR0020,STR0021) //"Origem"###"Destino"
	@ nLin,51 	PSAY FRZ->(FRZ_EMPDES+FRZ_UNDDES+FRZ_FILDES)
	@ nLin,61	PSAY ( (FRZ->FRZ_PEREMP*(FRZ->FRZ_PERUND/100))*(FRZ->FRZ_PERCEN/100) ) Picture "@E 999.99"
	@ nLin,67	PSAY Posicione("SA1",1,xFilial("SA1")+FRZ->FRZ_CLIENT+FRZ->FRZ_LOJCLI,"A1_NOME")
	@ nLin,109	PSAY Posicione("SA2",1,xFilial("SA2")+FRZ->FRZ_FORNEC+FRZ->FRZ_LOJFOR,"A2_NOME")
	nLin++
   	
   	dbSelectArea("FRZ")
   	dbSkip()

EndDo

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SET DEVICE TO SCREEN

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return

