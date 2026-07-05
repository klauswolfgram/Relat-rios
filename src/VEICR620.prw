/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "veicr620.ch"
#Include "fileio.ch"
#Include "protheus.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ VEICR620 ³ Autor ³  Fabio                ³ Data ³ 19/10/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Etiquetas p/ Cliente                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ (Veiculos)                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEICR620

Private aReturn  := { OemToAnsi(STR0001), 1,OemToAnsi(STR0002), 2, 2, 2,,1 },aCidades:={} //"Etiqueta"###"Codigo Inicial"
Private oColunas,titulo,wnrel,tamanho:="P"
Private lA1_IBGE := If(SA1->(FieldPos("A1_IBGE"))>0,.t.,.f.)
Private cAliasSA1 := "SQLSA1"
Private aImpr := {}

wnRel    := "VEIR620"
cAlias  := "SA1"
cNomRel := "VEIR620"
cPerg   := "VCR620"
cTitulo := STR0001 //"Etiqueta"
cDesc1  := STR0001 //"Etiqueta"
cDesc2  := cDesc3 := ""
lHabil  := .f.
cTamanho:= "P"

NomeRel := SetPrint(cAlias,cNomRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lHabil,,,cTamanho)

If nlastkey == 27
   Return
EndIf
                                     
Pergunte(cPerg,.f.)

RptStatus({|lEnd| FS_R620(@lEnd,wnRel,'SA1')},Titulo)

Static Function FS_R620()

Local a := 0 
Local x,i := 0

Set Console On
Set Printer to &NomeRel
Set Printer On
Set device to Printer

SetDefault(aReturn,cAlias)

cCodCli := " "
nLin    := 0
nCol    := 0
aCliente:= {}

Do While .T. .And. ( aReturn[5] == 2 .Or. aReturn[5] == 3 ) 

   If !(MsgYesNo(STR0003,STR0004)) //"Deseja Executar Teste de Impressora p/ Posicionamento da Etiqueta?"###"Teste de Impressora"
      Exit
   EndIf

   For x:=1 to 4
      For i:=1 to MV_PAR07
         @ (nLin+x),((i-1)*35) PSAY Repl("*",30)
      Next
   Next
   nLin:=(nLin+x)+1

//   MS_FLUSH()

EndDo
nLin := nLin + 1
                   
cQuery := "SELECT SA1.A1_COD,SA1.A1_LOJA,SA1.A1_NOME,SA1.A1_END,SA1.A1_BAIRRO,SA1.A1_IBGE,SA1.A1_CEP,SA1.A1_MUN,SA1.A1_EST "
cQuery += "FROM "
cQuery += RetSqlName( "SA1" ) + " SA1 " 
cQuery += "WHERE " 
cQuery += "SA1.A1_FILIAL='"+ xFilial("SA1")+ "' AND SA1.A1_COD >= '"+mv_par01+"' AND SA1.A1_LOJA >= '"+mv_par02+"' AND SA1.A1_COD <= '"+mv_par04+"' AND SA1.A1_LOJA <= '"+mv_par05+"' AND "
cQuery += "SA1.D_E_L_E_T_=' '"                                             

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasSA1, .T., .T. )

SetRegua(RecCount())

While !((cAliasSA1)->(Eof())) 
      
   aAdd(aImpr,{(cAliasSA1)->A1_COD,(cAliasSA1)->A1_LOJA,(cAliasSA1)->A1_NOME,(cAliasSA1)->A1_END,(cAliasSA1)->A1_BAIRRO,(cAliasSA1)->A1_CEP,(cAliasSA1)->A1_MUN,(cAliasSA1)->A1_EST})
   
   dbSelectArea(cAliasSA1)
   (cAliasSA1)->(dbSkip())

Enddo   

For a := 1  to Len(aImpr)
   nPosicao := a
   For i:=1 to MV_PAR07
      if a <= Len(aImpr) 
	      If aImpr[a,1]+aImpr[a,2]<MV_PAR01+MV_PAR02.And.aImpr[a,1]+aImpr[a,2]>MV_PAR04+MV_PAR05
    	     Exit
	      EndIf
      Else
        Exit
      Endif
      @ nLin,((i-1)*35) PSAY Left(aImpr[a,3],30)  
      a++
   Next
   nLin++
   a := nPosicao
   For i:=1 to MV_PAR07
      if a <= Len(aImpr) 
	      If aImpr[a,1]+aImpr[a,2]<MV_PAR01+MV_PAR02.And.aImpr[a,1]+aImpr[a,2]>MV_PAR04+MV_PAR05
    	     Exit
	      EndIf
      Else
        Exit
      Endif
      @ nLin,((i-1)*35) PSAY Left(aImpr[a,4],30)
      a++
   Next
   nLin++
   a := nPosicao
   For i:=1 to MV_PAR07
      if a <= Len(aImpr) 
	      If aImpr[a,1]+aImpr[a,2]<MV_PAR01+MV_PAR02.And.aImpr[a,1]+aImpr[a,2]>MV_PAR04+MV_PAR05
	         Exit
	      EndIf
      Else
        Exit
      Endif
      @ nLin,((i-1)*35) PSAY Left(aImpr[a,5],30)
      a++
   Next
   nLin++
   a := nPosicao
   For i:=1 to MV_PAR07
      if a <= Len(aImpr) 
	      If aImpr[a,1]+aImpr[a,2]<MV_PAR01+MV_PAR02.And.aImpr[a,1]+aImpr[a,2]>MV_PAR04+MV_PAR05
	         Exit
	      EndIf          
      Else
        Exit
      Endif
      dbSelectArea("SA1")
      dbSetOrder(1)
      dbSeek(xFilial("SA1")+aImpr[a,1]+aImpr[a,2])    
      if lA1_IBGE
	      FG_Seek("VAM","SA1->A1_IBGE",1,.f.) // CIDADE
    	  @ nLin,((i-1)*35) PSAY Transform(aImpr[a,6],"@R 99999-999")+" "+Left(VAM->VAM_DESCID,22)+" "+VAM->VAM_ESTADO
   		else
   		@ nLin,((i-1)*35) PSAY Transform(aImpr[a,6],"@R 99999-999")+" "+Left(aImpr[a,7],22)+" "+aImpr[a,8]
   		endif
      a++
   Next
   if a > 1
	   a-=1
   Endif
   IncRegua()

   nLin := nLin + 3

   If nLin > 63
      nLin := 1
   EndIf
   
Next
(cAliasSA1)->(DBCloseArea())

Eject

Set Printer to
Set device to Screen 

IF aReturn[5] == 1 
   ourspool(cNomRel)
Endif

MS_FLUSH()

Return                                                                       

User Function FS_VALR620(cPar1,cPar2,cPar3)    
Private cPara := cPar1
Private cParb := cPar2
Private cParc := cPar3
     
          
Return(FG_VALIDA(,"SA1TcPara+cParb*","&cParc := SA1->A1_NOME"))