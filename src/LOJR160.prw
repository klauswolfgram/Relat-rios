/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "lojr160.ch"
#include "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LOJR160   º Autor ³ Paulo Augusto      º Data ³  18/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de transferencia de mercadorias entre lojas      º±±
±±º          ³ (Localizacoes)                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Loja                                                       º±±
±±ÃÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³  DATA  ³ BOPS ³Program.³    ALTERACAO                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³21/02/07³119542³Conrado ³Retirada função de ajuste do dicionário.      ³±±
±±ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LOJR160()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1  := OemToAnsi(STR0001)  //"Este programa tem como objetivo imprimir relatorio "
Local cDesc2  := OemToAnsi(STR0002)  //"de acordo com os parametros informados pelo usuario."
Local aArea   	:= GetArea()
Private cTitulo  := OemToAnsi(STR0003)  //"Relatorio de transferencia entre Lojas"
Private lAbortPrint  := .F.
Private m_pag      	 := 01
Private nTamanho      := "M"
Private cNomeProg     := "LOJR160"
Private cPerg        := "LJR160"
Private nTipo        := 18
Private aReturn      := { OemToAnsi(STR0004), 1, OemToAnsi(STR0005), 2, 2, 1, "", 1}  //"Zebrado"###"Administracao"
Private nLastKey     := 0
Private wnrel      	 := "LOJR160" // Coloque aqui o nome do arquivo usado para impressao em disco

Private cString := "SF2"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//| mv_par01  Filial Original de ?            			        |
//| mv_par02  Filial Original ate ?                             |
//| mv_par03  Filial Destino de ?             			        |
//| mv_par04  Filial Destino ate ?                              |
//| mv_par05  Numero Remissao de ?                              |
//| mv_par06  Numero Remissao ate ?                             |
//| mv_par07  Data de Saida de                                  |
//| mv_par08  Data de Saida ate                                 |
//| mv_par09  Data de Entrada de                                |
//| mv_par10  Data de Entrada ate                               |
//| mv_par11  Produto de ?                                      |
//| mv_par12  Produto ate?                                      |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.F.)

dbSelectArea("SF2")                                 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := SetPrint(cString,cNomeProg,cPerg,@cTitulo,cDesc1,cDesc2,,.F.,,,nTamanho)
          
If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)


RptStatus({|| LJR160Imp()})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Apos a geracao do relatorio fecha a area de trabalho³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP
	dbSelectArea("TMP")
	dbCloseArea()
#ENDIF

RestArea(aArea)
SET(11,"ON")

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³LJR160Imp º Autor ³ Paulo Augusto      º Data ³  18/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao de impressao                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function LJR160Imp()

Local aAreaEmp	:={}
Local cCabec1  	:= STR0006  //"Cod.Produto                  Desc.Produto                              Quantidade             Custo de Saida      Custo de Entrada"
Local nLin    	:= 80
Local nI
Local aDadItens	:={}
Local cChaveSF1 :=""
Local cArqSF1   :=""
Local cFiltroSF1:="" 
Local lSF1		:= .F.
#IFDEF TOP
   Local cQuery  	:= ""
#ELSE
   Local cChaveSF2 :="" 
   Local cArqSF2   :="" 
   Local cFiltroSF2:=""       
#ENDIF  

Private cSF2    := ""          

#IFNDEF TOP
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Varre o SF2 enquanto nao for fim de arquivo, listando os historicos³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SF2")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ordena os registros por Data de Emissao + Filial				 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   cChaveSF2 := "DTOS(F2_EMISSAO)+F2_DOC+F2_SERIE"
   cArqSF2   := CriaTrab(NIL,.F.) 
   cFiltroSF2:= "F2_FILIAL>= MV_PAR01 .AND. F2_FILIAL<= MV_PAR02 .AND. F2_DOC >=MV_PAR05 .AND. F2_DOC <=MV_PAR06 .AND. F2_EMISSAO >=MV_PAR07 .AND.F2_EMISSAO <=MV_PAR08 .AND. F2_TIPODOC=='50' "
   IndRegua("SF2",cArqSF2,cChaveSF2,,cFiltroSF2,,.F.) 
   dbGoTop()
   cSF2:="SF2"
   
 #ELSE
	cQuery := " SELECT F2_DOC,F2_FILIAL ,F2_SERIE, F2_CLIENTE,F2_LOJA, F2_EMISSAO, F2_TIPODOC"
    cQuery += " FROM " +RetSQLName("SF2")+" SF2 " 
	cQuery += " WHERE SF2.F2_FILIAL BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' AND "    
    cQuery += " SF2.F2_DOC BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' AND "  
  	cQuery += " SF2.F2_EMISSAO BETWEEN '" + DTOS(MV_PAR07) + "' AND '" + DTOS(MV_PAR08) + "' AND "  
 	cQuery += " SF2.F2_TIPODOC = '50'  AND "  
 	cQuery += " SF2.D_E_L_E_T_ = ' ' AND "	  
	cQuery += " SF2.D_E_L_E_T_ = ' '  "	 
	cQuery += " ORDER BY F2_EMISSAO,F2_DOC,F2_SERIE"
	
	cQuery := ChangeQuery(cQuery)

	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'TMP', .T., .F.)
	
	TCSetField( "TMP", "F2_EMISSAO", "D", 8, 0 )
		
	dbSelectArea("TMP")
	
	SetRegua(40)
	
	cSF2 := "TMP"

#ENDIF  

cChaveSF1 := "F1_FILORIG + F1_DOC + F1_SERIE + F1_FORNECE + F1_LOJA"
cArqSF1   := CriaTrab(NIL,.F.) 
cFiltroSF1:= "F1_FILIAL>= MV_PAR03 .AND. F1_FILIAL<= MV_PAR04 .AND. F1_DTDIGIT >=MV_PAR09 .AND.F1_DTDIGIT <=MV_PAR10 .AND. F1_TIPODOC == '60' .AND. F1_FILORIG>= MV_PAR01 .AND. F1_FILORIG<= MV_PAR02 "
IndRegua("SF1",cArqSF1,cChaveSF1,,cFiltroSF1,,.F.) 
dbGoTop()

#IFNDEF TOP    
	(cSF2)->(dbSeek(DTOS(MV_PAR07)+MV_PAR05,.T.))  
#ENDIF  	

SetRegua(RecCount())

While (cSF2)->(!EOF()) .And. (cSF2)->F2_EMISSAO <= MV_PAR08	
   	DbSelectArea("SF1")
   	lSF1:=dbSeek( (cSF2)->F2_FILIAL + (cSF2)->F2_DOC+ (cSF2)->F2_SERIE)
   	aDadItens:={}
    dBSelectArea("SD2")
    DbSetOrder(3)
	DbSeek((cSF2)->F2_FILIAL+(cSF2)->F2_DOC+(cSF2)->F2_SERIE+(cSF2)->F2_CLIENTE+(cSF2)->F2_LOJA)
	While((cSF2)->F2_FILIAL+(cSF2)->F2_DOC+(cSF2)->F2_SERIE+(cSF2)->F2_CLIENTE+(cSF2)->F2_LOJA = SD2->D2_FILIAL+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA )
		If !(D2_COD >=MV_PAR11 .AND. D2_COD <= MV_PAR12)
			DbSkip()
			Loop
		EndIf
		SB1->(DbSetOrder(1))
		SB1->(DbSeek(xFilial("SB1")+SD2->D2_COD))
		
		If lSf1
			DbSelectArea("SD1")
			DbSetOrder(1)
			DbSeek(SF1->F1_FILIAL+SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_FORNECE+SF1->F1_LOJA+SD2->D2_COD+SD2->D2_ITEM)
		    Aadd (aDadItens,{SD2->D2_COD,SB1->B1_DESC,SD2->D2_QUANT,SD2->D2_CUSTO1,SD1->D1_CUSTO})
		Else
		   	Aadd (aDadItens,{SD2->D2_COD,SB1->B1_DESC,SD2->D2_QUANT,SD2->D2_CUSTO1,0})
		EndIf
		IncRegua()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lAbortPrint
		@nLin,00 PSAY OemToAnsi(STR0013) //"*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
		DbSelectArea("SD2")
		DbSkip()
	EndDo	
	If Len(aDadItens) > 0
    	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
			Cabec(cTitulo,cCabec1,"",cNomeProg,nTamanho,nTipo)
			nLin := 8
		Endif 
		aAreaEmp:=SM0->(GetArea())
		SM0->(Dbseek(SM0->M0_CODIGO+(cSF2)->F2_FILIAL))
		@nLin,001 psay  STR0007   +  FWGETCODFILIAL + "  -  "+ SM0->M0_FILIAL  //"Filial Origem  : "
        nLin+=1
	   	If lSf1
    		SM0->(Dbseek(SM0->M0_CODIGO+SF1->F1_FILIAL))
    		@nLin,001 psay  STR0008  +  FWGETCODFILIAL +  "  -  "+ SM0->M0_FILIAL  //"Filial Destino : "
   	    	nLin+=1
    	EndIf	
   		@nLin,001 psay  STR0009 + (cSF2)->F2_SERIE + Space(7) +STR0010 + (cSF2)->F2_DOC +  Space(7)+STR0011 + DToc((cSF2)->F2_EMISSAO)+ Space(8)+ STR0012 + DToc(SF1->F1_DTDIGIT)  //"Serie Doc:  "###"Numero Doc: "###"Data de Saida : "###"  Data de Entrada : "
   		SM0->(RestArea(aAreaEmp) )
   		nLin+=2
   		For nI:= 1 to Len(aDadItens)
        	If nLin > 55 
				Cabec(cTitulo,cCabec1,"",cNomeProg,nTamanho,nTipo)
				nLin := 8
			Endif
        	@nLin,001 psay aDadItens[nI][1] Picture PesqPict("SB1","B1_COD")
    		@nLin,030 PSAY aDadItens[nI][2] Picture PesqPict("SB1","B1_DESC")
    		@nLin,068 Psay aDadItens[nI][3] Picture PesqPict("SD2","D2_QUANT")
    		@nLin,093 psay aDadItens[nI][4] Picture PesqPict("SD2","D2_CUSTO1")
    		@nLin,115 PSAY aDadItens[nI][5] Picture PesqPict("SD1","D1_CUSTO")
   			nLin+=1               
   			
        Next
    EndIf
	nLin+=2
    DbSelectArea(cSF2)
    DbSkip()
EndDo

Roda(0,"",nTamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return