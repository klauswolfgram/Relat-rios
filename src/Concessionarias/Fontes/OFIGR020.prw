/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 06     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼ 
#INCLUDE "OFIGR020.ch"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³OFIGR020  º Autor ³ Ricardo Farinelli  º Data ³  03/07/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Garantias sem manutencao (Scania)             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Gestao de Concessionarias                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function OFIGR020()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local aOrd           := {}
Local cDesc1         := STR0001 //"Este programa tem como objetivo imprimir a relacao de "
Local cDesc2         := STR0002 //"Garantias sem Manutencao. (Scania)"
Local cDesc3         := ""
Local cPict          := ""
Local imprime        := .T.
Local wnrel          := "OFIGR020"
Local cString        := "VO1"
Local cIndice        := ""
Local cChave         := ""
Local cCondicao      := ""
Local nIndice 		   := 0
Local cMontadora     := ""

Private titulo       := STR0003 //"Garantias sem Manutencao - Scania"
Private nLin         := 80
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private limite       := 80
Private tamanho      := "P"
Private Cabec1       := STR0004 //" [Nro.OS] [Dt.Abe] [Ch.I] [Chassi do Veiculo------] [Modelo----------------------]"
Private Cabec2       := ""
Private nTipo        := 18
Private aReturn      := {STR0005, 1,STR0006, 1, 2, 1, "", 1}  //"Zebrado"###"Administracao"
Private nLastKey     := 0
Private cPerg        := "OGR020"
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01

//ValidPerg()

pergunte(cPerg,.F.)

wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

DbSelectArea("VG8")

cMontadora := Fg_Marca("SCANIA",,.F.) // Traz o codigo de montadora padrao da Volkswagem
cIndice    := CriaTrab(nil,.F.)
VO1->(DbSetOrder(1)) // por numero de OS

 cCondicao += "VG8->VG8_CODMAR=='"+cMontadora+"' .and. Empty(VG8->VG8_NUMRRC) .and. U_OGR020VO1()" 

// Foi incluso uma chave condicional porque nao existe no arquivo a ser lido, uma chave 
// que identifique primeiro pecas e depois servicos

//cChave := "VG6_FILIAL+VG6_CODMAR+VG6_NUMOSV+IIF(EMPTY(VG6_SERINT),'P','S')"
cChave := "VG8_FILIAL+VG8_CODMAR+VG8_NUMOSV"

IndRegua("VG8",cIndice,cChave,,cCondicao,STR0007)  //"Aguarde Selecionando Registro para Impressao"

DbSelectArea("VG8")
nIndice := RetIndex("VG8")
#IFNDEF TOP
   dbSetIndex(cIndice+ordBagExt())
#ENDIF
dbSetOrder(nIndice+1)

RptStatus({|lEnd| U_OFIG020IMP(@lEnd,wnrel,cString)},Titulo)

DbSelectArea("VG8")
RetIndex()

#IFNDEF TOP
   If File(cIndice+OrdBagExt())
      fErase(cIndice+OrdBagExt())
   Endif
#ENDIF

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³OFIG020IMPº Autor ³ Ricardo Farinelli  º Data ³  03/07/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar para a impressao do relatorio              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Gestao de Concessionarias                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function OFIG020IMP(lEnd,wnrel,cString)

Local nTotSrv  := 0 // Total vlr servico da os
Local nTotPec  := 0 // Total vlr pecas   da os
Local nTotSrvG := 0 // Total vlr servico geral
Local nTotPecG := 0 // Total vlr pecas geral
Local lImpPec  := .F.
Local nTotQtdP := 0 // Total qtde pecas da os
Local nTotQtdH := 0 // Total qtde horas da os
Local nTotOS   := 0 // Total por OS
/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³MV_PAR01 = Data Inicial - Data de inicio ou branco para desde o comeco                                ³
//³MV_PAR02 = Data Final - Data final para o escopo do relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
SB1->(DbSetOrder(1))
VO6->(Dbsetorder(1))

DbselectArea("VG8")

SetRegua(RecCount())

Titulo +=STR0008+dToc(MV_PAR01) //" de "
Titulo +=STR0009+dToc(MV_PAR02) //" a "

DbSeek(xFilial("VG8"))
Do While VG8->VG8_FILIAL == xFilial("VG8") .and. !VG8->(Eof())

   If lAbortPrint .or. lEnd
      @nLin,00 PSAY STR0010 //"*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif
                   
   DbSelectArea("VG6")
	DbSetOrder(5)
	If (Empty(VG8->VG8_NUMRRC) .Or. Empty(VG8->VG8_ANORRC)) ;
		.And. !Dbseek(xFilial("VG6")+VG8->VG8_CODMAR+VG8->VG8_NUMOSV+VG8->VG8_ANORRC+VG8->VG8_NUMRRC)
		IncRegua()
		DbSelectArea("VG8")
		DbSkip()           
		Loop
	EndIf
	
   If nLin > 58
      Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
      nLin := 9
   Endif

   VV1->(DbSetOrder(1))
   VV1->(Dbseek(xFilial("VV1")+VG8->VG8_CHAINT))
   VO1->(DbSetOrder(1))
   VO1->(Dbseek(xFilial("VO1")+VG8->VG8_NUMOSV))

   @ nLin,001 PSAY VO1->VO1_NUMOSV
   @ nLin,010 PSAY VO1->VO1_DATABE
   @ nLin,019 PSAY VO1->VO1_CHAINT
   @ nLin,026 PSAY VV1->VV1_CHASSI
   @ nLin,053 PSAY VV1->VV1_MODVEI
   nLin++
   If nLin > 58
      Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
      nLin := 9
   Endif

   nTotPec := 0
   nTotQtdP:= 0
   lImpPec := .F.

   DbSelectArea("VG6")
	DbSetOrder(2)
	Dbseek(xFilial("VG6")+VG8->VG8_CODMAR+VG8->VG8_NUMOSV)

	Do While VG6->(VG6_FILIAL+VG6_CODMAR+VG6_NUMOSV) == VG8->(VG8_FILIAL+VG8_CODMAR+VG8_NUMOSV) .and. !VG6->(Eof())

		If !( VG6->VG6_NUMRRC == VG8->VG8_NUMRRC .And. VG6->VG6_ANORRC == VG8->VG8_ANORRC )
			DbSelectArea("VG6")
			DbSkip()
			Loop		
		EndIf
		
		If (!Empty(VG6->VG6_CODITE).Or.!Empty(VG6->VG6_PECINT))
		
	      If !lImpPec
	         @ nLin,004 PSAY STR0009 //"[Gr] [Codigo da Peca-----------] [Descricao---------] [Qtde] [Valor---] [Esp]"
	         lImpPec := .T.
	         nLin++
	         If nLin > 58
	            Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
	            nLin := 9
	         Endif
	      Endif   
	      SB1->(Dbseek(xFilial("SB1")+VG6->VG6_PECINT))      
	      @ nLin,004 PSAY VG6->VG6_GRUITE
	      @ nLin,009 PSAY VG6->VG6_CODITE              
	      @ nLin,037 PSAY Substr(SB1->B1_DESC,1,20)
	      @ nLin,058 PSAY Transform(VG6->VG6_QTDITE,"@E 999999")
	      @ nLin,065 PSAY Transform(VG6->VG6_VALITE,"@E 999,999.99")
	      @ nLin,078 PSAY VG6->VG6_ITEEXT
	      nLin++
	      If nLin > 58
	        Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
	        nLin := 9
	      Endif
	      nTotPec +=  VG6->VG6_VALITE
	      nTotPecG+=  VG6->VG6_VALITE
	      nTotQtdP+=  VG6->VG6_QTDITE

		EndIf      

		VG6->(Dbskip())

	Enddo
	
	If lImpPec
		@ nLin,050 PSAY STR0015 // //"Total.:"
		@ nLin,058 PSAY Transform(nTotQtdP,"@E 999999")
		@ nLin,065 PSAY Transform(nTotPec, "@E 999,999.99")
		nLin++
		If nLin > 58
			Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
			nLin := 9
		Endif
	Endif

	nTotSrv := 0
	nTotQtdH:= 0
	lImpSrv := .F.

   DbSelectArea("VG6")
	DbSetOrder(1)
	Dbseek(xFilial("VG6")+VG8->VG8_CODMAR+VG8->VG8_NUMOSV)

	Do While VG6->(VG6_FILIAL+VG6_CODMAR+VG6_NUMOSV) == VG8->(VG8_FILIAL+VG8_CODMAR+VG8_NUMOSV) .and. !VG6->(Eof())

		If !( VG6->VG6_NUMRRC == VG8->VG8_NUMRRC .And. VG6->VG6_ANORRC == VG8->VG8_ANORRC )
			DbSelectArea("VG6")
			DbSkip()
			Loop		
		EndIf
		
		If (!Empty(VG6->VG6_CODSER).Or.!Empty(VG6->VG6_SERINT))
		
	      VO6->(Dbseek(xFilial("VO6")+VG6->VG6_SERINT))      
			If !lImpSrv
			 	@ nLin,004 PSAY STR0011 //"[Gr] [Codigo do Servico--------] [Descricao---------] [Tmp-] [Valor---] [Esp]"
		      nLin++
	  	      If nLin > 58
	    	      Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
	      	   nLin := 9
		      Endif
		      lImpSrv := .T.
			Endif  
	      @ nLin,004 PSAY VO6->VO6_GRUSER
	      @ nLin,009 PSAY VO6->VO6_CODSER
	      @ nLin,037 PSAY VO6->VO6_DESABR
	      @ nLin,058 PSAY Transform(VO6->VO6_TEMFAB,"@E 999:99")
	      @ nLin,065 PSAY Transform(VG6->VG6_VALSER,"@E 999,999.99")
	      @ nLin,078 PSAY VG6->VG6_SEREXT
	      nLin++
	      If nLin > 58
	         Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
	         nLin := 9
	      Endif
	      nTotSrv   += VG6->VG6_VALSER
	      nTotSrvG  += VG6->VG6_VALSER
	      nTotQtdH  += VO6->VO6_TEMFAB

	   EndIf
	      
      VG6->(Dbskip())                 

   Enddo

 	If lImpSrv
	  	@ nLin,050 PSAY STR0015 //"Total.:"
		@ nLin,058 PSAY Transform(nTotQtdH,"@E 999:99")
		@ nLin,065 PSAY Transform(nTotSrv, "@E 999,999.99")
		nLin++
		If nLin > 58
			Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
			nLin := 9
		Endif
	Endif

	nTotOS += ntotPec
	lImppec := .F.
	lImpSrv := .F.
    
	nTotOS += nTotSrv 
	@ nLin,044 PSAY STR0012+Transform(nTotOS,"@E 99,999,999,999.99") //"Total da OS.: "
   nLin++
   If nLin > 58
      Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
      nLin := 9
   Endif
   nTotOs := 0
    
	IncRegua()
	DbSelectArea("VG8")
	DbSkip()

Enddo   
nLin++
@ nLin,004 PSAY STR0013+Transform(nTotPecG,"@E 9,999,999.99")+" "+STR0014+Transform(nTotSrvG,"@E 9,999,999.99")+" "+STR0015+Transform(nTotSrvG+nTotPecG,"@E 999,999,999.99") //"Total Pecas: "###" Total Servicos: "###" Total: "

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
 
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³OGR020VO1 º Autor ³ Thiago             º Data ³  20/05/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Posiciona na tabela VO1.								      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function OGR020VO1()
Local lRet := .f.
If VO1->(dbseek(xFilial('VO1')+VG8->VG8_NUMOSV))
   If !Empty(MV_PAR01) .AND. !Empty(MV_PAR02)
      If DTOS(VO1->VO1_DATABE)>= DTOS(MV_PAR01) .AND. DTOS(VO1->VO1_DATABE) <= DTOS(MV_PAR02)
         lRet := .t.
      EndIf
   Endif
EndIf
Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³VALIDPERG º Autor ³ Ricardo Farinelli  º Data ³  03/07/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Verifica a existencia das perguntas criando-as caso seja   º±±
±±º          ³ necessario (caso nao existam).                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
/*
Static Function ValidPerg

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)

aAdd(aRegs,{cPerg,"01",STR0016,"","","mv_ch1","D", 08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})  //"Data Inicial      ?"
aAdd(aRegs,{cPerg,"02",STR0017,"","","mv_ch2","D", 08,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""}) //"Data Final        ?"

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
