/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "ofior350.ch"

#define STR0017 "[Grupo] [Descricao-------] [Inconveniente------] [Descricao Inconv-------------] "
#define STR0041 "Pcs  Grp  Codigo do Item              Descricao                    Qtd Req"
#define STR0042 "Srv  Tp  Grupo   Secao     Cod. Servico    Descricao"
#define STR0043 "----------------------------------------------------------------------------------] "
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³OFIOR350  º Autor ³ Thiago             º Data ³  25/03/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Planos de Revisao.                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Gestao de Concessionarias                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIOR350()

Local aOrd           := {}
Local cDesc1         := STR0004 // //"Este programa tem como objetivo imprimir a tabela"
Local cDesc2         := ""// STR0002 // //"de Planos de Revisao conforme os parametros "
Local cDesc3         := ""// STR0003 // //"selecionados. "
Local cPict          := ""
Local imprime        := .T.
Local wnrel          := "OFIOR350"
Local cString        := "VO6"
Local cIndice        := ""
Local cChave         := ""
Local cCondicao      := ""
Local nIndice 		 := 0
Private titulo       := STR0004 // //"Planos de Revisao"
Private nLin         := 80
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private limite       := 132
Private tamanho      := "M"
Private Cabec1       := ""
Private Cabec2       := ""
Private nTipo        := 18
Private aReturn      := {STR0005, 1,STR0006, 1, 2, 1, "", 1} //### //"Zebrado"###"Administracao"
Private nLastKey     := 0
Private cPerg        := "OFI350"
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)
If nLastKey == 27
	Return
Endif
pergunte(cPerg,.F.)
ValidPerg()
SetDefault(aReturn,cString)
nTipo := If(aReturn[4]==1,15,18)

RptStatus({|lEnd| U_OFIR350IMP(@lEnd,wnrel,cString)},Titulo)
DbSelectArea("VF0")
RetIndex()
#IFNDEF TOP
   If File(cIndice+OrdBagExt())
      fErase(cIndice+OrdBagExt())
   Endif
#ENDIF
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³OFIR350IMPº Autor ³ Ricardo Farinelli  º Data ³  13/06/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar para a impressao do relatorio de tabela de º±±
±±º          ³ planos de revisao                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Gestao de Concessionarias                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIR350IMP(lEnd,wnrel,cString)
Local cChave   := ""
Local nTotRevF := 0 // Total Revisao Fabrica
Local nTotPlaF := 0 // Total Plano Fabrica
Local nTotRevC := 0 // Total Revisao Concessionaria
Local nTotPlaC := 0 // Total Revisao Concessionaria
Local nValor   := 0 // variavel temporaria para o calculo de valor de pecas      
Local i := 0             
Local aInconv := {}
Local cAliasVF0 := "SQLVF0"
Private cTipo  := ""
/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³MV_PAR01 = Marca - especificar uma marca, ou branco para todas                                        ³
//³MV_PAR02 = Modelo - especificar um modelo, ou branco para todos                                       ³
//³MV_PAR03 = Plano -  especificar um plano de revisao, ou branco para todos                             ³
//³MV_PAR04 = Tipo de Operacao - especificar um tipo de operacao, ou branco para todas                   ³
//³MV_PAR05 = Tipo de Tempo - especificar um T.T. valido para calculo do valor da mao de obra            ³
//³MV_PAR06 = Tempo - utilizar tempo da fabrica ou tempo da concessionaria                               ³
//³MV_PAR07 = Data de referencia para busca os valores no T.T.                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/


cQuery := "SELECT VF0.VF0_CODMAR,VF0.VF0_CODPLA,VF0.VF0_DESPLA,VF0.VF0_MODVEI "
cQuery += "FROM "
cQuery += RetSqlName( "VF0" ) + " VF0 " 
cQuery += "WHERE " 
cQuery += "VF0.VF0_FILIAL='"+ xFilial("VF0")+ "' AND "
If !Empty(MV_PAR01)
	cQuery += "VF0.VF0_CODMAR='"+MV_PAR01+"' AND "
Endif	
If !Empty(MV_PAR02)
   cQuery += "VF0.VF0_MODVEI='"+MV_PAR02+"' AND "
Endif
If !Empty(MV_PAR03)
   cQuery += "VF0.VF0_CODPLA='"+MV_PAR03+"' AND "
Endif  
cQuery += "VF0.D_E_L_E_T_=' '"                                             

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVF0, .T., .T. )

//SetRegua(LastRec())

n := 0 
lAchou := .f.
Do While !( cAliasVF0 )->( Eof() )

  If lAbortPrint .or. lEnd
    @nLin,00 PSAY STR0013 //"*** CANCELADO PELO OPERADOR ***"
    Exit
  Endif
  If nLin > 58
    Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
    nLin := 8
  Endif
  if lAchou 
     @ nLin++,000 PSAY STR0043
  Endif    
  nLin++
  lAchou := .t.
  @ nLin,001 PSAY STR0014+( cAliasVF0 )->VF0_CODMAR+STR0015+( cAliasVF0 )->VF0_CODPLA+" "+( cAliasVF0 )->VF0_DESPLA+STR0016+( cAliasVF0 )->VF0_MODVEI //###### //"Marca: "###" Plano: "###" Modelo: "
  nLin++
  If nLin > 58
    Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
    nLin := 8
  Endif
  nTotPlaF := 0
  nTotPlaC := 0
  VF1->(DbsetOrder(1))
  VF1->(Dbseek(xFilial("VF1")+( cAliasVF0 )->(VF0_CODMAR+VF0_CODPLA)))
  
  Do While (VF1->(VF1_FILIAL+VF1_CODMAR+VF1_CODPLA)) == (xFilial("VF1")+( cAliasVF0 )->VF0_CODMAR+( cAliasVF0 )->VF0_CODPLA) .and. !VF1->(Eof())
     If nLin > 50
        Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
        nLin := 8
     Endif
     nLin++	
     if !Empty(VF1->VF1_CODGRU) .and. !Empty(VF1->VF1_CODINC) 
	     @ nLin,004 PSAY STR0017
	 Endif    
     dbSelectArea("VSK")
     dbSetOrder(1)
     dbSeek(xFilial("VSK")+VF1->VF1_CODMAR+VF1->VF1_CODGRU)
     dbSelectArea("VSL")
     dbSetOrder(1)
     dbSeek(xFilial("VSL")+VF1->VF1_CODMAR+VF1->VF1_CODGRU+VF1->VF1_CODINC)   
     nLin++
     @ nLin,005 PSAY VF1->VF1_CODGRU+" "+VSK->VSK_DESGRU+" "+VF1->VF1_CODINC+" "+VSL->VSL_DESINC
     nLin++
     dbSelectArea("VAJ")
     dbSetOrder(1)
     dbSeek(xFilial("VAJ")+VF1->VF1_CODMAR+VF1->VF1_CODGRU+ALLTRIM(VF1->VF1_CODINC))  
     cInicio := "Inicio"    
     aInconv := {}
     While !Eof() .and. xFilial("VAJ") == VAJ->VAJ_FILIAL .and. VAJ->VAJ_CODMAR == VF1->VF1_CODMAR .and. VAJ->VAJ_CODGRU == VF1->VF1_CODGRU .and. Alltrim(VAJ->VAJ_CODINC) == Alltrim(VF1->VF1_CODINC)
    
        if !Empty(VAJ->VAJ_TIPSER)
	       dbSelectArea("VO6")
    	   dbSetOrder(2)
       	   dbSeek(xFilial("VO6")+VAJ->VAJ_CODMAR+VAJ->VAJ_CODSER)
   		   aAdd(aInconv,{"S",VAJ->VAJ_TIPSER,VAJ->VAJ_GRUSER,VAJ->VAJ_CODSEC,VAJ->VAJ_CODSER,VO6->VO6_DESSER})
        Else
	       dbSelectArea("SB1")
    	   dbSetOrder(7)
       	   dbSeek(xFilial("SB1")+VAJ->VAJ_GRUPEC+VAJ->VAJ_CODPEC)
			aAdd(aInconv,{"P",VAJ->VAJ_GRUPEC,VAJ->VAJ_CODPEC,SB1->B1_DESC,VAJ->VAJ_QTDPEC})
	    Endif    

        dbSelectArea("VAJ")
        dbSkip()
     Enddo    
   
     aSort(aInconv,,,{|x,y| x[1]<y[1]})
     nLin++	
     nPos := aScan(aInconv,{|x| x[1] == "P"})
     if nPos > 0 
	     @nLin++, 010 pSay STR0041
	 Endif    
     nPec := 0
     For i := 1 to Len(aInconv)  
         if aInconv[i,1] == "S" 
            if nPec == 0 
			   nPos := aScan(aInconv,{|x| x[1] == "S"})
			   if nPos > 0 
				   nLin++	
			       @nLin++, 010 pSay STR0042
			       nPec := 1
			   Endif    
		    Endif
  	        @nLin++, 015 pSay aInconv[i,2]+" "+aInconv[i,3]+"      "+aInconv[i,4]+"       "+aInconv[i,5]+" "+aInconv[i,6]
         Else
  	        @nLin++, 015 pSay aInconv[i,2]+" "+aInconv[i,3]+" "+aInconv[i,4]+" "+transform(aInconv[i,5],"99999")
         Endif
     Next
     
     dbSelectArea("VF1")
     dbSkip()  
   
  Enddo
  
  dbSelectArea(cAliasVF0)
  ( cAliasVF0 )->(dbSkip())
   
Enddo
( cAliasVF0 )->( dbCloseArea() )
SET DEVICE TO SCREEN
If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif
MS_FLUSH()
Return
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³VALIDPERG º Autor ³ Ricardo Farinelli  º Data ³  18/06/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Verifica a existencia das perguntas criando-as caso seja   º±±
±±º          ³ necessario (caso nao existam).                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ValidPerg
Local _sAlias := Alias()
Local aRegs := {}
Local i,j
dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)
aAdd(aRegs,{cPerg,"01",STR0031,"","","mv_ch1","C", 03,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","VE1",""}) //"Marca             ?"
aAdd(aRegs,{cPerg,"02",STR0032,"","","mv_ch2","C", 30,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","V2R",""}) //"Modelo            ?"
Aadd(aRegs,{cPerg,"03",STR0033,"","","mv_ch3","C", 03,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","V0R",""}) //"Plano             ?"
//Aadd(aRegs,{cPerg,"04",STR0034,"","","mv_ch4","C", 03,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","V5R",""}) //"Tipo de Operacao  ?"
//Aadd(aRegs,{cPerg,"05",STR0035,"","","mv_ch5","C", 01,0,0,"G","VOI->(Dbseek(xFilial('VOI')+MV_PAR05))","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","VOI",""}) //"Tipo de Tempo     ?"
//Aadd(aRegs,{cPerg,"06",STR0036,"","","mv_ch6","N",1,0,0,"C","NaoVazio()","mv_par06",STR0037,"","","","",STR0038,"","","","",STR0039,"","","","","","","","","","","","","","",""}) //"Obter Tempo da    ?"###"Fabrica"###"Concessionaria"###"Ambos"
//Aadd(aRegs,{cPerg,"07",STR0040,"","","mv_ch7","D", 08,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","",""}) //"Data Referencia   ?"
For i:=1 to Len(aRegs)
    If !dbSeek(cPerg+aRegs[i,2])
        RecLock("SX1",.T.)
        For j:=1 to FCount()
            If j <= Len(aRegs[i])
                FieldPut(j,aRegs[i,j])
            Endif
        Next
        MsUnlock()
    Endif
Next
dbSelectArea(_sAlias)
Return
*/
