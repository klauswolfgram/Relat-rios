/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "OFIgr040.ch"

#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณOFIGR040  บ Autor ณ Ricardo Farinelli  บ Data ณ  05/07/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio Posicao de Deb/Cre Garantia (Scania)             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Concessionarias                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function OFIGR040()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local aOrd           := {}
Local cDesc1         := STR0001 // //"Este programa tem como objetivo imprimir a posicao de "
Local cDesc2         := STR0002 // //"Garantia (Debitos/Creditos) (Scania)"
Local cDesc3         := ""
Local cPict          := ""
Local imprime        := .T.
Local wnrel          := "OFIGR040"
Local cString        := "VG8"
Local cIndice        := ""
Local cChave         := ""
Local cCondicao      := ""
Local nIndice 		   := 0
Local cMontadora     := ""

Private titulo       := STR0003 // //"Posicao Debitos/Creditos - Scania"
Private nLin         := 80
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private limite       := 132
Private tamanho      := "M"
Private Cabec1       := STR0004 // //" [Nro.OS] [Dt.Abe] [Ch.I] [Chassi do Veiculo------] [Modelo----------------------] [Cliente------------------------------]"
Private Cabec2       := ""
Private nTipo        := 18
Private aReturn      := {STR0005, 1,STR0006, 1, 2, 1, "", 1}   //### //"Zebrado"###"Administracao"
Private nLastKey     := 0
Private cPerg        := "OGR040"
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
Cabec2 := Iif(MV_PAR03==1,STR0007,"") // //"          [Ano]  [Nr.RR] [Dt.Ret] [Dt.Tra] [Dt.Cre] [Dt.Est] [Pec.Tran] [Pec.Paga] [Pec.Est.] [Srv.Tran] [Srv.Pago] [Srv.Est.]"

cMontadora := Fg_Marca("SCANIA",,.F.) // Traz o codigo de montadora padrao da Volkswagem
cIndice    := CriaTrab(nil,.F.)
VO1->(DbSetOrder(1)) // por numero de OS

 cCondicao += "VG8_CODMAR=='"+cMontadora+"' .and. VO1->(dbseek(xFilial('VO1')+VG8->VG8_NUMOSV))" 

If !Empty(MV_PAR01)
  cCondicao += ".and. DTOS(VO1->VO1_DATABE)>='"+DTOS(MV_PAR01)+"'"
Endif
  
If !Empty(MV_PAR02)
  cCondicao += ".and. DTOS(VO1->VO1_DATABE) <='"+DTOS(MV_PAR02)+"'"
Endif

cChave := "VG8_FILIAL+VG8_CODMAR+VG8_NUMOSV+DTOS(VG8_ABEGAR)"

IndRegua("VG8",cIndice,cChave,,cCondicao,STR0008)   // //"Aguarde Selecionando Registro para Impressao"

DbSelectArea("VG8")
nIndice := RetIndex("VG8")
#IFNDEF TOP
   dbSetIndex(cIndice+ordBagExt())
#ENDIF
dbSetOrder(nIndice+1)

RptStatus({|lEnd| U_OFIG040IMP(@lEnd,wnrel,cString)},Titulo)

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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณOFIG040IMPบ Autor ณ Ricardo Farinelli  บ Data ณ  05/07/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar para a impressao do relatorio              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Concessionarias                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function OFIG040IMP(lEnd,wnrel,cString)

Local aTotais  := {} // Vetor totalizado
Local aTitulos := {} // vetor do titulo das colunas
Local cNumos   := ""
Local nWnk1    := 0
Local nWnk     := 0
aTotais := Array(1,20)
For nwnk := 1 To len(aTotais[1])
  aTotais[1,nwnk] := 0
Next

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณPosicao 1 - Total da OS - pecas  - transmitido   ณ
//ณPosicao 2 - Total da OS - pecas  - Pago          ณ
//ณPosicao 3 - Total da OS - pecas  - Estornado     ณ
//ณPosicao 4 - Total da OS - servicos  - transmitidoณ
//ณPosicao 5 - Total da OS - servicos  - Pago       ณ
//ณPosicao 6 - Total da OS - servicos  - Estornado  ณ
//ณPosicao 7 - Total - pecas  - transmitido         ณ
//ณPosicao 8 - Total - pecas  - Pago                ณ
//ณPosicao 9 - Total - des.ind. - transmitido       ณ
//ณPosicao 10 - Total - des.ind. - pago             ณ
//ณPosicao 11 - Total - tempo perm - transmitido    ณ
//ณPosicao 12 - Total - tempo pern - pago           ณ
//ณPosicao 13 - Total - dif.icms  - transmitido     ณ
//ณPosicao 14 - Total - dif.icms  - pago            ณ
//ณPosicao 15 - Total - srv. m.o. - transmitido     ณ
//ณPosicao 16 - Total - srv. m.o. - pago            ณ
//ณPosicao 17 - Total - cust. esp.- transmitido     ณ
//ณPosicao 18 - Total - cust. esp.- pago            ณ
//ณPosicao 19 - Total - deslocalm.- transmitido     ณ
//ณPosicao 20 - Total - deslocalm.- pago            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

AAdd(aTitulos,STR0009) // //"Pecas.....................: "
AAdd(aTitulos,STR0010) // //"Despesa Indireta..........: "
AAdd(aTitulos,STR0011) // //"Tempo de Permanencia......: "
AAdd(aTitulos,STR0012) // //"Diferenca de ICMS.........: "
AAdd(aTitulos,STR0013) // //"Servicos (Mao-de-Obra)....: "
AAdd(aTitulos,STR0014) // //"Custo Especial............: "
AAdd(aTitulos,STR0015) // //"Deslocamento..............: "

/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMV_PAR01 = Data Inicial - Data de inicio ou branco para desde o comeco                                ณ
//ณMV_PAR02 = Data Final - Data final para o escopo do relatorio                                         ณ
//ณMV_PAR03 = 1 - Analitico ou 2 - Sintetico                                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
*/

DbselectArea("VG8")

SetRegua(RecCount())

Titulo +=STR0016+dToc(MV_PAR01)  //" de "
Titulo +=STR0017+dToc(MV_PAR02)  //" a "
Titulo +=Iif(MV_PAR03==1,STR0016,STR0017)  //### //" Analitico"###" Sintetico"
DbSeek(xFilial("VG8"))
Do While VG8->VG8_FILIAL == xFilial("VG8") .and. !VG8->(Eof())

  cNumos := VG8->(VG8_FILIAL+VG8_CODMAR+VG8_NUMOSV)

  If lAbortPrint .or. lEnd
    @nLin,00 PSAY STR0018 // //"*** CANCELADO PELO OPERADOR ***"
    Exit
  Endif

  If nLin > 58
    Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
    nLin := 9
  Endif

  VV1->(DbSetOrder(1))
  VV1->(Dbseek(xFilial("VV1")+VG8->VG8_CHAINT))
  VO1->(DbSetOrder(1))                                                               	
  VO1->(Dbseek(xFilial("VO1")+VG8->VG8_NUMOSV))
  SA1->(DbSetOrder(1))
  SA1->(Dbseek(xFilial("SA1")+VV1->(VV1_PROATU+VV1_LJPATU)))
  VG9->(DbSetOrder(1))

  @ nLin,001 PSAY VO1->VO1_NUMOSV
  @ nLin,010 PSAY VO1->VO1_DATABE
  @ nLin,019 PSAY VO1->VO1_CHAINT
  @ nLin,026 PSAY VV1->VV1_CHASSI
  @ nLin,053 PSAY VV1->VV1_MODVEI
  @ nLin,084 PSAY VV1->VV1_PROATU+"/"+VV1->VV1_LJPATU
  @ nLin,094 PSAY Substr(SA1->A1_NOME,1,30)
  nLin++
  If nLin > 58
    Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
    nLin := 9
  Endif
  // zera variaveis de total da OS
  For nwnk := 1 To 6
    aTotais[1,nwnk] := 0
  Next

  Do While VG8->(VG8_FILIAL+VG8_CODMAR+VG8_NUMOSV) == cNumos .and. !VG8->(Eof())
	  aTotais[1,1] += VG8->VG8_VALITE
		aTotais[1,2] += VG8->VG8_ITEPGT	  
		aTotais[1,3] += VG8->VG8_ITEEST
	  aTotais[1,4] += VG8->VG8_VALSER
		aTotais[1,5] += VG8->VG8_SERPGT	  
		aTotais[1,6] += VG8->VG8_SEREST

    @ nLin,010 PSAY VG8->VG8_ANORRC
    @ nLin,017 PSAY VG8->VG8_NUMRRC
	  @ nLin,025 PSAY VG8->VG8_DATRET
  	@ nLin,034 PSAY VG8->VG8_DATTRA
	  @ nLin,043 PSAY VG8->VG8_DATCRE
	  @ nLin,052 PSAY VG8->VG8_DATEST
	  @ nLin,061 PSAY Transform(VG8->VG8_VALITE,"@E 999,999.99")
	  @ nLin,072 PSAY Transform(VG8->VG8_ITEPGT,"@E 999,999.99")
	  @ nLin,083 PSAY Transform(VG8->VG8_ITEEST,"@E 999,999.99")
	  @ nLin,094 PSAY Transform(VG8->VG8_VALSER,"@E 999,999.99")
	  @ nLin,105 PSAY Transform(VG8->VG8_SERPGT,"@E 999,999.99")
	  @ nLin,116 PSAY Transform(VG8->VG8_SEREST,"@E 999,999.99")
	  nLin++
	  If nLin > 58
	    Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
	    nLin := 9
	  Endif
    If MV_PAR03==1
      If VG9->(Dbseek(xFilial("VG9")+VG8->(VG8_CODMAR+VG8_NUMOSV+VG8_ANORRC+VG8_NUMRRC)))
        For nwnk := 7 To 20
          aTotais[1,nwnk] := 0
        Next
		    Do While VG9->(VG9_FILIAL+VG9_CODMAR+VG9_NUMOSV+VG9_ANORRC+VG9_NUMRRC) == VG8->(VG8_FILIAL+VG8_CODMAR+VG8_NUMOSV+VG8_ANORRC+VG8_NUMRRC) .and. !VG9->(Eof())
          aTotais[1,7] += VG9->VG9_ITETRA
          aTotais[1,8] += VG9->VG9_ITEPGT
          aTotais[1,9] += VG9->VG9_INDTRA
          aTotais[1,10]+= VG9->VG9_INDPGT
          aTotais[1,11]+= VG9->VG9_PERTRA
          aTotais[1,12]+= VG9->VG9_PERPGT
          aTotais[1,13]+= VG9->VG9_DIFTRA
          aTotais[1,14]+= VG9->VG9_DIFPGT
          aTotais[1,15]+= VG9->VG9_MAOTRA
          aTotais[1,16]+= VG9->VG9_MAOPGT
          aTotais[1,17]+= VG9->VG9_CUSTRA
          aTotais[1,18]+= VG9->VG9_CUSPGT
          aTotais[1,19]+= VG9->VG9_DESTRA
          aTotais[1,20]+= VG9->VG9_DESPGT
    		  VG9->(Dbskip())
		    Enddo
        @ nLin,001 PSAY PADC(STR0019,132) // //"[Posicao Analista---------] [Transmitido] [Pago-------]"
        nLin++
 	  		If nLin > 58
	    		Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
	    		nLin := 9
	  		Endif
        For nwnk1 := 1 To Len(aTitulos)
           @ nLin,001 PSAY PADC(aTitulos[nwnk1]+Transform(aTotais[1,nwnk1+6],"@E 99,999,999.99")+" "+Transform(aTotais[1,nwnk1+7],"@E 99,999,999.99"),132)
           nLin++
 	         If nLin > 58
	     			 Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
	    			 nLin := 9
	  			 Endif
        Next         
   		  For nwnk := 7 to 20
	  		  aTotais[1,nwnk] := 0
		    Next 
      Endif
    Endif  
    VG8->(dbskip())
    If VG8->VG8_NUMOSV<>Right(cNumos,8)
		  @ nLin,045 PSAY STR0020 // //"Totais da OS..: "
		  @ nLin,061 PSAY Transform(aTotais[1,1],"@E 999,999.99")
		  @ nLin,072 PSAY Transform(aTotais[1,2],"@E 999,999.99")
	  	@ nLin,083 PSAY Transform(aTotais[1,3],"@E 999,999.99")
		  @ nLin,094 PSAY Transform(aTotais[1,4],"@E 999,999.99")
		  @ nLin,105 PSAY Transform(aTotais[1,5],"@E 999,999.99")
	  	@ nLin,116 PSAY Transform(aTotais[1,6],"@E 999,999.99")
		  For nwnk := 1 to 6
			  aTotais[1,nwnk] := 0
		  Next 
		  nLin++
		  If nLin > 58
	  	  Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
	    	nLin := 9
		  Endif
    Endif
  Enddo
Enddo

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

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณVALIDPERG บ Autor ณ Ricardo Farinelli  บ Data ณ  05/07/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Verifica a existencia das perguntas criando-as caso seja   บฑฑ
ฑฑบ          ณ necessario (caso nao existam).                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
/*
Static Function ValidPerg

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)

aAdd(aRegs,{cPerg,"01",STR0021,"","","mv_ch1","D", 08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})  //"Data Inicial      ?"
aAdd(aRegs,{cPerg,"02",STR0022,"","","mv_ch2","D", 08,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""}) //"Data Final        ?"
aAdd(aRegs,{cPerg,"03",STR0023,"","","mv_ch3","N", 01,0,0,"C","","mv_par03",STR0024,"","","","",STR0025,"","","","","","","","","","","","","","","","","","","",""}) //"Tipo Relatorio    ?"###"Analitico"###"Sintetico"

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
