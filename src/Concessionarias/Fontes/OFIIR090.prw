/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.Ch"
/*    
ANTIGO M_RRECSC
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ OFIIR090 ³ Autor ³ Manoel Filho          ³ Data ³ 22/11/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio das Recompras SCANIA                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ FNC  ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Rafael Gonc ³09/11/10³      ³ Passado para projeto                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIIR090()

Private cDesc1 := "Recompra SCANIA"
Private cDesc2 := ""
Private cDesc3 := ""
Private tamanho:= "P"
Private limite := 80
Private cString:= "VL0"
Private titulo := "Recompra SCANIA"
Private cabec1 := ""
Private cabec2 := ""
Private aReturn := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
Private nomeprog:= "OFIIR090"
Private aLinha  := { },nLastKey := 0
Private cPerg   := "RRECSC"
Private aCodSer   := {}
Private nQtdSer   := 0
Private nTotSer   := 0
Private nTTPadrao	:= 0
Private nTTrab		:= 0
Private nTVend		:= 0
Private nTFatu 		:= 0
Private nCaracter   := 18
Private aProblema  := {}
Private aProblema1 := {}
ValidPerg()
wnrel := nomeprog
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,,tamanho)
If nLastKey == 27
	Return
EndIf
Pergunte(cPerg,.f.)
SetDefault(aReturn,cString)
RptStatus( { |lEnd| FS_IMPRIME(@lEnd,wnrel,cString) } , Titulo )
If aReturn[5] == 1
	OurSpool( wnrel )
EndIf
MS_Flush()
Return

Static Function FS_IMPRIME()
Local nip := 1
nLin    := 80
m_pag   := 1

aVetor  := {}
// 1o Elemento - VL1_MESANO
// 2o Elemento - VL1_PEDIDO
// 3o Elemento - VL1_SEQUEN
// 4o Elemento - VL1_CODITE
// 5o Elemento - VL1_DESCRI
// 6o Elemento - VL1_PESOLQ
// 7o Elemento - VL1_QUANTI
// 8o Elemento - VL1_PRECO
// 9o Elemento - VL1_PERICM

Set Printer to &wnrel
Set Printer On
Set Device  to Printer

DbSelectArea("VL0")
DbSetOrder(1)   
cWhen := ".f."
DbSelectArea("VL1")
DbSetOrder(1)
If !Empty(Mv_Par01) .and. !Empty(Mv_Par02)
	DbSeek(xFilial("VL1")+Mv_Par01+Mv_Par02,.t.)
	cWhen := "VL1->VL1_PEDIDO == Mv_Par02 .and. VL1->VL1_MESANO == Mv_Par01"
Else
	If Empty(Mv_Par01) .and. !Empty(Mv_Par02)
		DbSetOrder(2)
		DbSeek(xFilial("VL1")+Mv_Par02+Mv_Par01,.t.)  
		cWhen := "VL1->VL1_PEDIDO == Mv_Par02"
	Elseif !Empty(Mv_Par01) .and. Empty(Mv_Par02)
		DbSeek(xFilial("VL1")+Mv_Par01)
		cWhen := "VL1->VL1_MESANO == Mv_Par01"
	Endif
Endif
	
	
While !Eof() .and. VL1->VL1_FILIAL == xFilial("VL1") .and. &cWhen


	   aadd(aVetor,{VL1_MESANO,VL1_PEDIDO,VL1_SEQUEN,VL1_CODITE,VL1_DESCRI,VL1_PESOLQ,VL1_QUANTI,VL1_PRECO,VL1_PERICM})
	   
		DbSkip()
	
EndDo

//"        10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220       
//"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//"Seq.  Codigo   Descricao        Peso Lq  Quant.       Preco   Valor Total % Icms
// 9999  9999999  xxxxxxxxxxxxxxx  9999999  999999  999,999.99  9,999,999.99  99.99

cabec1 := ""
cabec2 := "" 

If !Len(aVetor) > 0
	MsgStop("Nao ha dados a serem listados...")
   Return
Endif

cPedido := aVetor[1,2] 
cAnoRef := aVetor[1,1]
nTotPed := 0

For nip := 1 to Len(aVetor)

    If nLin >= 56 .or. cPedido != aVetor[nip,2] .or. cAnoRef != aVetor[nip,1]
	    If cPedido != aVetor[nip,2] .or. cAnoRef != aVetor[nip,1]
		    nLin := nLin+1
		    @ nLin++,61 psay Transform(nTotPed,"@E 9,999,999.99")
			 nTotPed := 0  
	    Endif
	    nLin := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nCaracter)
	    nLin := nLin+2
	    @ nLin++,0 psay "Pedido: " + aVetor[nip,2] + "  -  Referencia " + aVetor[nip,1]
	    nLin := nLin+1
	    @ nLin++,0 psay "Seq.  Codigo   Descricao        Peso Lq  Quant.       Preco   Valor Total % Icms"
	    @ nLin++,0 psay "----  ------   ---------------  -------  ------  ----------  ------------ ------"
       If cPedido != aVetor[nip,2]
			 cPedido := aVetor[nip,2] 
		 Endif
       If cAnoRef != aVetor[nip,1]
			 cAnoRef := aVetor[nip,1]
       Endif
//		 nTotPed := 0
	 Endif   

	 nTotPed += (aVetor[nip,7]*aVetor[nip,8])

    @ nLin++,0 psay  aVetor[nip,3]+"  "+aVetor[nip,4]+"  "+aVetor[nip,5]+"  "+Transform(aVetor[nip,6],"@E 9999999");
					       +"  "+Transform(aVetor[nip,7],"@E 999999")+"  "+Transform(aVetor[nip,8],"@E 999,999.99")+"  "+Transform(aVetor[nip,7]*aVetor[nip,8],"@E 9,999,999.99")+"  "+Transform(aVetor[nip,9],"@E 99.99")

Next	

nLin := nLin+1
@ nLin++,61 psay Transform(nTotPed,"@E 9,999,999.99")

Set Printer to
Set Device  to Screen

Return


Static Function ValidPerg
local _sAlias := Alias()
local aRegs := {}
local i,j
dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,Len(SX1->X1_GRUPO))
// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(aRegs,{cPerg,"01","Mes/Ano Referencia","","","mv_ch1","C",7,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","VL0",""})
aAdd(aRegs,{cPerg,"02","Nro Pedido    ","","","mv_ch2","C",7,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
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


