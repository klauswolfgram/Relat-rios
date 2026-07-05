/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º  06    º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#Include "Protheus.ch"
#Include "Folder.ch"
#Include "Fileio.ch" 
#Include "VEIVR200.ch"
                     
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ VEIVR200 º Autor ³ Manoel             º Data ³  17/06/2005 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Lista Vendas de Veiculos por Faturamento Direto 			  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Concessionarias                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEIVR200()

Private cAlias    := "VV0"
Private cDesc1    := STR0001 //Venda de Veiculos por Faturamento Direto
Private cDesc2    := ""
Private cDesc3    := ""
Private aRegistros:= {}
Private nLin      := 0
Private cTitulo   := STR0001 //Venda de Veiculos por Faturamento Direto
Private Titulo    := STR0001 //Venda de Veiculos por Faturamento Direto
Private cNomeProg := "VEIVR200"
Private cNomeRel  := "VEIVR200"
Private nLastKey  := 0
Private nCaracter := 15
Private cabec1    := ""
Private cabec2    := ""
Private lAbortPrint := .f.
Private cString  := "VV0"
Private Li       := 80
Private m_Pag    := 1
Private wnRel    := "VEIVR200"
Private nPos     := 0
Private ni       := 0
Private aReturn  := { OemToAnsi(STR0002), 1,OemToAnsi(STR0003), 1, 1, 1, "",2 }		//1-ZEBRADO,2-,3-ADMINISTRACAO,4-1:COMPACTA,2:NAO,5-MIDIA 1:DISCO,6-CRYSTAL,7-,8-ORDEM

cPerg := Padr("PVR200",len(SX1->X1_GRUPO))

//ValidPerg()

If !pergunte(cPerg,.t.)
	Return
Else
	If Mv_Par03 == 1 // Analitico
		Tamanho   := "G"
		limite    := 132
	Else
		Tamanho   := "G"
		limite    := 132
	Endif	
	Processa( {|| FS_Imprime() } )
Endif

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_IMPRIMEº Autor ³ Manoel             º Data ³  17/06/2005 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao dos Dados de Vendas de Veiculos 			        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Concessionarias                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_Imprime()

Local i:=0 
Local _i_ := 0
// Armazena dados da impressao
aVetor := {}
//  1o. Elemento -03- Entregamos Veiculo
//  20. Elemento -03- Recebemos do Cliente
//  3o. Elemento -03- Recebemos da fabrica
//  4o. Elemento -03- Pagamos Vendedor
//  5o. Elemento -08- Data do Movto
//  6o. Elemento -09- Numero NF Fabrica + Serie
//  7o. Elemento -20- Nome Cliente
//  8o. Elemento -15- Modelo
//  9o. Elemento -19- Chassi
// 10o. Elemento -10- Valor do Veiculo
// 11o. Elemento -09- Valor de Comissao
// 12o. Elemento -09- Data Cred. Comissao
// 13o. Elemento -10- Valor Negociado
// 14o. Elemento -10- Valores Adicionais (Receitas e Despesas)
// 15o. Elemento -10- Lucro Marginal 1
// 16o. Elemento -10- Comissao do Vendedor
// 17o. Elemento -10- Comissao do Gerente
// 18o. Elemento -10- Resultado Final
// 19o. Elemento -08- Data de Vencimento da NF da Fabrica
// 20o. Elemento -20- Observacoes

Cabec1 := ""
Cabec2 := ""


wnrel:= "VEIVR200"
wnrel:=SetPrint(cString,wnrel,,@titulo,cDesc1,cDesc2,cDesc3,.F.,,.T.,Tamanho)

If nLastKey == 27
	Set Filter to
	Return
Endif

Set Printer to &wnrel
Set Printer On
Set Device  to Printer

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter To
	Return
Endif

li        := 80
m_pag     := 1
If Mv_Par03 == 1 // Analitico
	Tamanho   := "G"
	limite    := 132
Else
	Tamanho   := "M"
	limite    := 132
Endif	
nTipo     := 15
nCaracter := 15
nomeprog  := "VEIVR200"

Titulo    := STR0001  //Venda de Veiculos por Faturamento Direto

nVeicul  := 0
nComFab  := 0
nNegoci  := 0
nTotAdi  := 0
nLM1     := 0
nComVen  := 0
nComSup  := 0
nResFin  := 0


cIndVV0 := CriaTrab(Nil, .F.)
cChave  := "VV0_FILIAL+VV0_OPEMOV+Dtos(VV0_DATEMI)"
IndRegua("VV0",cIndVV0,cChave,,,OemToAnsi(STR0004) ) //Aguarde... Indexando Arquivos..


dbSelectArea("VV0")
//DbSetOrder(2)
dbseek(xFilial("VV0")+"0"+Dtos(Mv_Par01),.t.)
nTot := RecCount()
ProcRegua( nTot )     

//while !eof() .and. VV0->VV0_FILIAL+VV0->VV0_OPEMOV == xFilial("VV0")+"0" .and. VV0->VV0_DATMOV <= Mv_Par02
while !eof() .and. VV0->VV0_FILIAL+VV0->VV0_OPEMOV == xFilial("VV0")+"0" .and. VV0->VV0_DATEMI <= Mv_Par02

	 IncProc(STR0005)		// Aguarde... Lendo Faturamentos de Veiculos...
	 
    If VV0->VV0_SITNFI != "1"
    	 DbSkip()
    	 Loop
    Endif  
    
    If VV0->VV0_TIPFAT != "2"
    	 DbSkip()
    	 Loop
    Endif  

	 dbSelectArea("SA1")
	 DbSetOrder(1)
	 dbseek(xFilial("SA1")+VV0->VV0_CODCLI+VV0->VV0_LOJA)

	 dbSelectArea("SA3")
	 DbSetOrder(1)
	 dbseek(xFilial("SA3")+VV0->VV0_CODVEN)
	 cNomVen := Left(SA3->A3_NREDUZ,8)

	 dbSelectArea("VVA")
	 DbSetOrder(1)
	 dbseek(xFilial("VVA")+VV0->VV0_NUMTRA)

	 dbSelectArea("VV1")
	 DbSetOrder(1)
	 dbseek(xFilial("VV1")+VVA->VVA_CHAINT)

	 for i:= 1 to 7
			
			cKeyAce := VVA->VVA_OBSMEM + strzero(i,3)
			cCampo  := "cObserv"+STR(i,1)
			
			if FG_SEEK("SYP","cKeyAce",1,.f.)
				
				nPos1 := AT("\13\10",SYP->YP_TEXTO)
				if nPos1 > 0
					nPos := len(alltrim(SYP->YP_TEXTO)) - 6
				else
					nPos := len(alltrim(SYP->YP_TEXTO))
				endif
				
				&cCampo := Substr(SYP->YP_TEXTO,1,nPos)
				
			Else
				&cCampo := " "
				
			Endif
			
	 next

    If(VV0->VV0_ENTREG == "1",cEnt:=STR0006,cEnt:=STR0007)//SIM ### NAO
    If(VV0->VV0_RECCLI == "1",cRec:=STR0006,cRec:=STR0007)//SIM ### NAO
    If(VV0->VV0_DRCFAB>dDataBase .or. Empty(VV0->VV0_DRCFAB),cFab:=STR0007,cFab:=STR0006)//SIM ### NAO
    If(VV0->VV0_DPGVEN>dDataBase .or. Empty(VV0->VV0_DPGVEN),cVen:=STR0007,cVen:=STR0006)//SIM ### NAO
    nAdicio  := (VVA->VVA_RECTEC+VVA->VVA_RECVEI+VVA->VVA_BONFAB)-(VVA->VVA_SEGVIA+VVA->VVA_VALASS+VVA->VVA_VALFRE+VVA->VVA_VALREV+VVA->VVA_REDCUS+VVA->VVA_DESCLI+VVA->VVA_DESVEI+(VVA->VVA_VALVDA-VV0->VV0_VALNEG))-((VVA->VVA_VALCVD*0.015)+VVA->VVA_ISSCVD+VVA->VVA_PISBFB)
    If VV0->VV0_MODVDA == "3" 
       cMod := "VDI"
    Else 
       cMod := "ESP"
    Endif
    nLucLiq1 := VVA->VVA_VALCVD + nAdicio
    nLucLiq2 := nLucLiq1 - (VVA->VVA_COMVDE+VVA->VVA_COMGER)
    If left(cObserv1,4) != "CANC"
		 nVeicul  += VVA->VVA_VALVDA
		 nComFab  += VVA->VVA_VALCVD
		 nNegoci  += VV0->VV0_VALNEG
		 nTotAdi  += nAdicio
		 nLM1     := nComFab+(ntotAdi)
		 nComVen  += VVA->VVA_COMVDE
		 nComSup  += VVA->VVA_COMGER
		 nResFin  := nLM1 - (nComVen+nComSup)
	
//		 aadd(aVetor,{cEnt+" "+cRec+" "+cFab+" "+cVen+" "+cMod+" "+cNomVen+" "+Dtoc(VV0->VV0_DATMOV)+" "+VV0->VV0_NNFFDI+"-"+VV0->VV0_SNFFDI+" "+;
		 aadd(aVetor,{cEnt+" "+cRec+" "+cFab+" "+cVen+" "+cMod+" "+cNomVen+" "+Dtoc(VV0->VV0_DATEMI)+" "+VV0->VV0_NNFFDI+"-"+VV0->VV0_SNFFDI+" "+;
		 If(Mv_Par03==1,Left(SA1->A1_NOME,20),Left(SA1->A1_NOME,18))+" "+Left(VV1->VV1_MODVEI,10)+" "+Right(Alltrim(VV1->VV1_CHASSI),8)+" "+transform(VVA->VVA_VALVDA,"@E 999,999.99")+;
		 " "+transform(VVA->VVA_VALCVD,"@E 999,999.99")+" "+Dtoc(VV0->VV0_DRCFAB)+" "+transform(VV0->VV0_VALNEG,"@E 999,999.99")+;
		 " "+transform(nAdicio,"@E 999,999.99")+" "+transform(nLucLiq1,"@E 999,999.99")+" "+transform(VVA->VVA_COMVDE,"@E 999,999.99")+;
		 " "+transform(VVA->VVA_COMGER,"@E 999,999.99")+" "+transform(nLucLiq2,"@E 999,999.99")+" "+Dtoc(VV0->VV0_DPGFAB)+" "+cObserv1})
	 Else
		 If Mv_Par03==1 // Analitico
//			 aadd(aVetor,{cEnt+" "+cRec+" "+cFab+" "+cVen+" "+cMod+" "+cNomVen+" "+Dtoc(VV0->VV0_DATMOV)+" "+VV0->VV0_NNFFDI+"-"+VV0->VV0_SNFFDI+" "+;
			 aadd(aVetor,{cEnt+" "+cRec+" "+cFab+" "+cVen+" "+cMod+" "+cNomVen+" "+Dtoc(VV0->VV0_DATEMI)+" "+VV0->VV0_NNFFDI+"-"+VV0->VV0_SNFFDI+" "+;
			 Left(SA1->A1_NOME,20)+" "+Left(VV1->VV1_MODVEI,10)+" "+Right(Alltrim(VV1->VV1_CHASSI),8)+" "+transform(0,"@E 999,999.99")+;
			 " "+transform(0,"@E 999,999.99")+" "+Dtoc(VV0->VV0_DRCFAB)+" "+transform(0,"@E 999,999.99")+;
			 " "+transform(0,"@E 999,999.99")+" "+transform(0,"@E 999,999.99")+" "+transform(0,"@E 999,999.99")+;
			 " "+transform(0,"@E 999,999.99")+" "+transform(0,"@E 999,999.99")+" "+Dtoc(VV0->VV0_DPGFAB)+" "+cObserv1})
		 Else
//			 aadd(aVetor,{cEnt+" "+cRec+" "+cFab+" "+cVen+" "+cMod+" "+cNomVen+" "+Dtoc(VV0->VV0_DATMOV)+" "+VV0->VV0_NNFFDI+"-"+VV0->VV0_SNFFDI+" "+;
			 aadd(aVetor,{cEnt+" "+cRec+" "+cFab+" "+cVen+" "+cMod+" "+cNomVen+" "+Dtoc(VV0->VV0_DATEMI)+" "+VV0->VV0_NNFFDI+"-"+VV0->VV0_SNFFDI+" "+;
			 Left(SA1->A1_NOME,18)+" "+Left(VV1->VV1_MODVEI,10)+" "+Right(Alltrim(VV1->VV1_CHASSI),8)+" "+transform(0,"@E 999,999.99")+;
			 " "+transform(0,"@E 999,999.99")+" "+Dtoc(VV0->VV0_DRCFAB)+" "+transform(0,"@E 999,999.99")+"  C"})
       Endif
	 Endif	 
		 
	 DbSelectArea("VV0")
	 DbSKip()
	 
Enddo
aadd(aVetor,{""})
aadd(aVetor,{Space(09)+"TOTAIS....."+If(Mv_Par03==1,Space(65),Space(63))+" "+transform(nVeicul,"@E 999,999,999.99")+;
				 transform(nComFab,"@E 9999,999.99")+Space(6)+transform(nNegoci,"@E 999,999,999.99")+;
				 transform(nTotAdi,"@E 9999,999.99")+transform(nLM1,"@E 9999,999.99")+transform(nComVen,"@E 9999,999.99")+;
				 transform(nComSup,"@E 9999,999.99")+transform(nResFin,"@E 9999,999.99")})

If Mv_Par03 == 1 // Analitico
	cCabec1 := STR0008  //ENT REC FAB VEN MOD Vendedor Data Fat  nro.NF         Cliente           Modelo    Chassi  Vl Veiculo Vl Comiss  Cred Com  Vl Negoc  Vl Adicion    LM 1    Comis Vend Comiss Sup Res. Final Venc.Fab Observacoes 
	cCabec2 := "--- --- --- --- --- -------- -------- ---------- -------------------- ---------- -------- ---------- ---------- -------- ---------- ---------- ---------- ---------- ---------- ---------- -------- ---------------------"
	//				xxx xxx xxx xxx xxx xxxxxxxx 99/99/99 xxxxxx-xxx xxxxxxxxxxxxxxxxxxxx xxxxxxxxxx xxxxxxxx 999,999,99 999,999,99 99/99/99 999,999,99 999,999,99 999,999,99 999,999,99 999,999,99 999,999,99 99/99/99 xxxxxxxxxxxxxxxxxxxxx
	//				123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456
	//							10			 20		  30        40        50        60        70        80        90       100       110       120       130       140       150       160      170       180       190       200       210      
Else // Sintetico
	cCabec1 := STR0009     //ENT REC FAB VEN MOD Vendedor Data Fat  nro.NF         Cliente         Modelo    Chassi  Vl Veiculo Vl Comiss  Cred Com  Vl Negoc  St
	cCabec2 := "--- --- --- --- --- -------- -------- ---------- ------------------ ---------- -------- ---------- ---------- -------- ---------- --"
	//				xxx xxx xxx xxx xxx xxxxxxxx 99/99/99 xxxxxx-xxx xxxxxxxxxxxxxxxxxx xxxxxxxxxx xxxxxxxx 999,999,99 999,999,99 99/99/99 999,999,99  x
	//				123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	//							10			 20		  30        40        50        60        70        80        90       100       110       120       130   
Endif	

For _i_ := 1 to Len(aVetor)

    If li > 33
	
		    cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		    li:=li+2
		    @li,00  PSAY cCabec1
		    li:=li+1
		    @li,00  PSAY cCabec2
		    li:=li+2
				 
    Endif

    @ li++,00 PSAY aVetor[_i_,01]
    
Next

ms_flush()

Set Printer to
set Device  to Screen

DbSelectArea("VV0")
Set Filter To

If aReturn[5] == 1
	Set Printer TO
	dbCommitAll()
	ourspool(wnrel)
Endif

#IFNDEF TOP
   If File(cIndVV0+OrdBagExt())
      fErase(cIndVV0+OrdBagExt())
   Endif
#ENDIF

Return .t.



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ºFun‡„o    ³VALIDPERG º Autor ³ AP5 IDE            º Data ³  13/07/01   º±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

Static Function ValidPerg
local _sAlias := Alias()
local aRegs := {}
local i,j
dbSelectArea("SX1")
dbSetOrder(1)
cPerg := Padr("PVR200",len(SX1->X1_GRUPO))
// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(aRegs,{cPerg,"01","Data Inicial?     ","","","mv_ch1","D",8,0,0,"G","","Mv_Par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Data Final?       ","","","mv_ch2","D",8,0,0,"G","","Mv_Par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Tipo de Relatorio?","","","mv_ch3","N",1,0,0,"C","","Mv_Par03","Analitico","","","","","Sintetico","","","","","","","","","","","","","","","","","","","",""})
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

